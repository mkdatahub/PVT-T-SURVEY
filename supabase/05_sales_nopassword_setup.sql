-- ==============================================================================
-- 05_sales_nopassword_setup.sql
-- นโยบายและฟังก์ชันสำหรับให้ฝ่ายขาย (เซลล์) เข้าสู่ระบบด้วยชื่อโดยไม่ต้องใส่รหัสผ่าน
-- และแก้ไขสิทธิ์ RLS ให้ทำงานได้อย่างราบรื่น 100%
-- ==============================================================================

-- 1. ลบฟังก์ชันเดิมที่มีหลาย signature (Overloading) เพื่อป้องกันข้อผิดพลาด PGRST203 (400 Bad Request)
drop function if exists public.submit_internal_survey(uuid, uuid, uuid, public.respondent_type, text, jsonb);
drop function if exists public.submit_internal_survey(uuid, uuid, uuid, text, text, jsonb);
drop function if exists public.submit_internal_survey(uuid, uuid, uuid, text, text, jsonb, uuid, text, text);
drop function if exists public.submit_internal_survey(uuid, uuid, uuid, public.respondent_type, text, jsonb, uuid, text, text);

drop function if exists public.create_survey_invite(uuid, uuid);
drop function if exists public.create_survey_invite(uuid, uuid, uuid);
drop function if exists public.create_survey_invite(uuid, uuid, uuid, timestamptz);

-- 2. สร้าง/อัปเดต Default Campaign ให้มี end_date ป้องกันข้อผิดพลาด NOT NULL constraint
insert into public.survey_campaigns (id, name, start_date, end_date, is_active)
values (
  'c0000000-0000-0000-0000-000000000001'::uuid,
  'สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026',
  current_date,
  (current_date + interval '10 years')::date,
  true
)
on conflict (id) do update set
  end_date = coalesce(survey_campaigns.end_date, (current_date + interval '10 years')::date),
  is_active = true;

-- 3. ให้สิทธิ์ Table Grant แก่ anon และ authenticated
grant select, insert, update on public.customers to anon, authenticated;
grant select, insert, update on public.survey_campaigns to anon, authenticated;
grant select on public.products, public.survey_questions, public.survey_question_options, public.sales_people to anon, authenticated;
grant select, insert, update, delete on public.survey_invites, public.survey_responses, public.survey_answers to anon, authenticated;

-- 4. ตั้งค่านโยบาย Row Level Security (RLS) ให้ผู้ใช้ทั่วไป (anon) และเซลล์บันทึกได้
drop policy if exists "allow_anon_read_sales_people" on public.sales_people;
create policy "allow_anon_read_sales_people"
  on public.sales_people for select
  to anon, authenticated
  using (true);

drop policy if exists "allow_anon_manage_customers" on public.customers;
drop policy if exists "allow_anon_read_customers" on public.customers;
create policy "allow_anon_manage_customers"
  on public.customers for all
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists "allow_anon_manage_campaigns" on public.survey_campaigns;
drop policy if exists "allow_anon_read_campaigns" on public.survey_campaigns;
create policy "allow_anon_manage_campaigns"
  on public.survey_campaigns for all
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists "allow_anon_read_products" on public.products;
create policy "allow_anon_read_products"
  on public.products for select
  to anon, authenticated
  using (true);

drop policy if exists "allow_anon_read_questions" on public.survey_questions;
create policy "allow_anon_read_questions"
  on public.survey_questions for select
  to anon, authenticated
  using (true);

drop policy if exists "allow_anon_read_question_options" on public.survey_question_options;
create policy "allow_anon_read_question_options"
  on public.survey_question_options for select
  to anon, authenticated
  using (true);

drop policy if exists "allow_anon_manage_invites" on public.survey_invites;
create policy "allow_anon_manage_invites"
  on public.survey_invites for all
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists "allow_anon_manage_responses" on public.survey_responses;
create policy "allow_anon_manage_responses"
  on public.survey_responses for all
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists "allow_anon_manage_answers" on public.survey_answers;
create policy "allow_anon_manage_answers"
  on public.survey_answers for all
  to anon, authenticated
  using (true)
  with check (true);

-- 5. ฟังก์ชันสร้างคำเชิญ (create_survey_invite) แบบ Security Definer ไม่ต้องพึ่ง auth.uid()
create or replace function public.create_survey_invite(
  p_customer_id uuid,
  p_campaign_id uuid,
  p_product_id uuid default null,
  p_expires_at timestamptz default null
)
returns jsonb
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_cust record;
  v_token text;
  v_invite_id uuid;
  v_salesperson_id uuid;
begin
  select * into v_cust from public.customers where id = p_customer_id;
  if found then
    v_salesperson_id := v_cust.salesperson_id;
  end if;

  if v_salesperson_id is null then
    v_salesperson_id := public.current_salesperson_id();
  end if;

  if v_salesperson_id is null then
    select id into v_salesperson_id from public.sales_people where is_active = true limit 1;
  end if;

  if v_salesperson_id is null then
    v_salesperson_id := 'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid;
  end if;

  v_token := encode(gen_random_bytes(24), 'hex');

  insert into public.survey_invites (
    token, customer_id, salesperson_id, campaign_id, product_id,
    status, expires_at, created_by
  ) values (
    v_token, p_customer_id, v_salesperson_id, p_campaign_id, p_product_id,
    'created', p_expires_at, auth.uid()
  )
  returning id into v_invite_id;

  return jsonb_build_object(
    'invite_id', v_invite_id,
    'token', v_token,
    'status', 'created'
  );
end;
$$;

-- 6. ฟังก์ชันบันทึกแบบสำรวจ (submit_internal_survey) ครบวงจรและทนทานสูงสุด
create or replace function public.submit_internal_survey(
  p_campaign_id uuid,
  p_customer_id uuid,
  p_product_id uuid,
  p_respondent_type text,
  p_respondent_name text,
  p_answers jsonb,
  p_salesperson_id uuid default null,
  p_customer_name text default null,
  p_province text default null
)
returns uuid
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_response_id uuid;
  v_salesperson_id uuid := p_salesperson_id;
  v_customer_name text := coalesce(nullif(trim(p_customer_name), ''), 'ลูกค้าทั่วไป');
  v_province text := coalesce(p_province, '');
  v_nps integer := null;
  v_item jsonb;
  v_q record;
  v_resp_type public.respondent_type;
begin
  -- 1. แปลง respondent_type ให้ตรงกับ enum
  if lower(trim(p_respondent_type)) = 'farmer' then
    v_resp_type := 'farmer'::public.respondent_type;
  else
    v_resp_type := 'dealer'::public.respondent_type;
  end if;

  -- 2. ตรวจสอบให้มั่นใจว่าแคมเปญมีอยู่จริง (มี end_date เพื่อไม่ให้ติด NOT NULL constraint)
  insert into public.survey_campaigns (id, name, start_date, end_date, is_active)
  values (
    p_campaign_id,
    'สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026',
    current_date,
    (current_date + interval '10 years')::date,
    true
  )
  on conflict (id) do update set
    end_date = coalesce(survey_campaigns.end_date, (current_date + interval '10 years')::date);

  -- 3. ค้นหา/กำหนด salesperson_id
  if v_salesperson_id is null then
    select salesperson_id into v_salesperson_id
    from public.customers where id = p_customer_id;
  end if;

  if v_salesperson_id is null then
    v_salesperson_id := public.current_salesperson_id();
  end if;

  if v_salesperson_id is null then
    select id into v_salesperson_id from public.sales_people where is_active = true limit 1;
  end if;

  if v_salesperson_id is null then
    v_salesperson_id := 'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid;
  end if;

  -- ป้องกัน foreign key error ในกรณี salesperson_id ยังไม่อยู่ใน sales_people
  insert into public.sales_people (id, display_name, is_active)
  values (v_salesperson_id, 'ฝ่ายขายตราต้นไม้', true)
  on conflict (id) do nothing;

  -- 4. ตรวจสอบให้มั่นใจว่าข้อมูลลูกค้ามีอยู่ในระบบ (รองรับกรณีเกษตรกรหรือลูกค้ารายใหม่)
  insert into public.customers (
    id, client_id, client_name, province_raw, province_normalized, salesperson_id, is_active
  ) values (
    p_customer_id,
    coalesce('CUST-' || substring(p_customer_id::text from 1 for 8), 'GEN-01'),
    v_customer_name,
    v_province,
    v_province,
    v_salesperson_id,
    true
  )
  on conflict (id) do update set
    salesperson_id = coalesce(customers.salesperson_id, excluded.salesperson_id);

  -- 5. คำนวณ NPS score หากมีข้อคำถามประเภท scale_0_10
  if p_answers is not null then
    for v_item in select * from jsonb_array_elements(p_answers)
    loop
      select * into v_q from public.survey_questions where id = (v_item->>'question_id')::uuid;
      if found and v_q.question_type = 'scale_0_10' then
        v_nps := nullif(v_item#>>'{answer,value}','')::integer;
      end if;
    end loop;
  end if;

  -- 6. บันทึกข้อมูลการตอบแบบสำรวจ
  insert into public.survey_responses (
    campaign_id, customer_id, salesperson_id, product_id,
    respondent_type, source, respondent_name, nps_score,
    submitted_by
  ) values (
    p_campaign_id, p_customer_id, v_salesperson_id, p_product_id,
    v_resp_type, 'sales', nullif(trim(p_respondent_name),''), v_nps,
    auth.uid()
  )
  returning id into v_response_id;

  -- 7. บันทึกคำตอบใน survey_answers
  if p_answers is not null then
    for v_item in select * from jsonb_array_elements(p_answers)
    loop
      insert into public.survey_answers (
        response_id, question_id, answer_json
      ) values (
        v_response_id, (v_item->>'question_id')::uuid, v_item->'answer'
      );
    end loop;
  end if;

  return v_response_id;
end;
$$;

-- 7. ให้สิทธิ์ execute ฟังก์ชันแก่ทุกคน
grant execute on function public.create_survey_invite to anon, authenticated;
grant execute on function public.submit_internal_survey to anon, authenticated;

