-- PVT USP Survey - Supabase schema
-- Run this file first in Supabase SQL Editor.

create extension if not exists pgcrypto;

do $$ begin
  create type public.app_role as enum ('admin','management','sales');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.respondent_type as enum ('dealer','farmer');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.response_source as enum ('sales','public');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.question_type as enum ('checkbox','rating_grid','single_choice','scale');
exception when duplicate_object then null; end $$;

do $$ begin
  create type public.invite_status as enum ('created','opened','completed','expired','cancelled');
exception when duplicate_object then null; end $$;

create table if not exists public.sales_people (
  id uuid primary key default gen_random_uuid(),
  display_name text not null unique,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.profiles (
  auth_user_id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  display_name text not null,
  role public.app_role not null default 'sales',
  salesperson_id uuid references public.sales_people(id) on delete set null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  source_row integer,
  client_id text not null,
  client_name text not null,
  province_raw text,
  province_normalized text,
  salesperson_id uuid not null references public.sales_people(id) on delete restrict,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);
create index if not exists customers_salesperson_idx on public.customers(salesperson_id);
create index if not exists customers_province_idx on public.customers(province_normalized);
create index if not exists customers_client_id_idx on public.customers(client_id);
create index if not exists customers_name_idx on public.customers(client_name);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name_th text not null,
  name_en text,
  pain_point text,
  dealer_enabled boolean not null default true,
  farmer_enabled boolean not null default true,
  sort_order integer not null default 0,
  is_active boolean not null default true
);

create table if not exists public.survey_questions (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  respondent_type public.respondent_type not null,
  question_no smallint not null check (question_no between 1 and 99),
  question_type public.question_type not null,
  prompt text not null,
  max_selections smallint,
  required boolean not null default true,
  scale_min smallint,
  scale_max smallint,
  scale_min_label text,
  scale_mid_label text,
  scale_max_label text,
  analysis_hint text,
  sort_order integer not null default 0,
  unique(product_id, respondent_type, question_no)
);
create index if not exists survey_questions_set_idx
  on public.survey_questions(product_id, respondent_type, sort_order);

create table if not exists public.survey_question_options (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.survey_questions(id) on delete cascade,
  option_key text not null,
  option_text text not null,
  sort_order integer not null default 0,
  is_other boolean not null default false,
  unique(question_id, option_key)
);

create table if not exists public.survey_campaigns (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  start_date date not null,
  end_date date not null,
  is_active boolean not null default false,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  constraint campaign_dates_ok check (end_date >= start_date)
);
create index if not exists campaigns_active_idx on public.survey_campaigns(is_active, start_date, end_date);

create table if not exists public.survey_invites (
  id uuid primary key default gen_random_uuid(),
  token text not null unique default encode(gen_random_bytes(24),'hex'),
  customer_id uuid not null references public.customers(id) on delete cascade,
  salesperson_id uuid not null references public.sales_people(id) on delete restrict,
  campaign_id uuid not null references public.survey_campaigns(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  status public.invite_status not null default 'created',
  opened_at timestamptz,
  completed_at timestamptz,
  expires_at timestamptz,
  last_sent_at timestamptz,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);
create index if not exists survey_invites_customer_idx on public.survey_invites(customer_id);
create index if not exists survey_invites_campaign_idx on public.survey_invites(campaign_id);
create index if not exists survey_invites_sales_idx on public.survey_invites(salesperson_id);
create index if not exists survey_invites_token_idx on public.survey_invites(token);

create table if not exists public.survey_responses (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.survey_campaigns(id) on delete restrict,
  invite_id uuid references public.survey_invites(id) on delete set null,
  customer_id uuid not null references public.customers(id) on delete restrict,
  salesperson_id uuid not null references public.sales_people(id) on delete restrict,
  product_id uuid not null references public.products(id) on delete restrict,
  respondent_type public.respondent_type not null,
  source public.response_source not null,
  respondent_name text,
  nps_score smallint check (nps_score between 1 and 5),
  submitted_by uuid references auth.users(id) on delete set null,
  submitted_at timestamptz not null default now()
);
create index if not exists responses_campaign_idx on public.survey_responses(campaign_id);
create index if not exists responses_sales_idx on public.survey_responses(salesperson_id);
create index if not exists responses_customer_idx on public.survey_responses(customer_id);
create index if not exists responses_product_idx on public.survey_responses(product_id);
create index if not exists responses_submitted_idx on public.survey_responses(submitted_at desc);

create table if not exists public.survey_answers (
  id uuid primary key default gen_random_uuid(),
  response_id uuid not null references public.survey_responses(id) on delete cascade,
  question_id uuid not null references public.survey_questions(id) on delete restrict,
  answer_json jsonb not null,
  created_at timestamptz not null default now(),
  unique(response_id, question_id)
);

-- ---------- helpers ----------
create or replace function public.current_app_role()
returns public.app_role
language sql stable security definer
set search_path = public
as $$
  select p.role from public.profiles p
  where p.auth_user_id = auth.uid() and p.is_active = true
  limit 1
$$;

create or replace function public.current_salesperson_id()
returns uuid
language sql stable security definer
set search_path = public
as $$
  select p.salesperson_id from public.profiles p
  where p.auth_user_id = auth.uid() and p.is_active = true
  limit 1
$$;

create or replace function public.can_access_customer(p_customer_id uuid)
returns boolean
language sql stable security definer
set search_path = public
as $$
  select
    public.current_app_role() in ('admin','management')
    or exists (
      select 1 from public.customers c
      where c.id = p_customer_id
        and c.salesperson_id = public.current_salesperson_id()
    )
$$;

-- ---------- RLS ----------
alter table public.sales_people enable row level security;
alter table public.profiles enable row level security;
alter table public.customers enable row level security;
alter table public.products enable row level security;
alter table public.survey_questions enable row level security;
alter table public.survey_question_options enable row level security;
alter table public.survey_campaigns enable row level security;
alter table public.survey_invites enable row level security;
alter table public.survey_responses enable row level security;
alter table public.survey_answers enable row level security;

drop policy if exists sales_people_read_auth on public.sales_people;
create policy sales_people_read_auth on public.sales_people for select to authenticated using (true);

drop policy if exists profile_read_self_or_manager on public.profiles;
create policy profile_read_self_or_manager on public.profiles for select to authenticated
using (auth.uid() = auth_user_id or public.current_app_role() in ('admin','management'));

drop policy if exists profile_admin_update on public.profiles;
create policy profile_admin_update on public.profiles for update to authenticated
using (public.current_app_role() = 'admin')
with check (public.current_app_role() = 'admin');

drop policy if exists customer_read_scope on public.customers;
create policy customer_read_scope on public.customers for select to authenticated
using (
  public.current_app_role() in ('admin','management')
  or salesperson_id = public.current_salesperson_id()
);

drop policy if exists product_public_read on public.products;
create policy product_public_read on public.products for select to anon, authenticated using (is_active = true);

drop policy if exists question_public_read on public.survey_questions;
create policy question_public_read on public.survey_questions for select to anon, authenticated using (true);

drop policy if exists option_public_read on public.survey_question_options;
create policy option_public_read on public.survey_question_options for select to anon, authenticated using (true);

drop policy if exists campaign_auth_read on public.survey_campaigns;
create policy campaign_auth_read on public.survey_campaigns for select to authenticated using (true);

drop policy if exists campaign_admin_write on public.survey_campaigns;
create policy campaign_admin_write on public.survey_campaigns for all to authenticated
using (public.current_app_role() = 'admin')
with check (public.current_app_role() = 'admin');

drop policy if exists invite_read_scope on public.survey_invites;
create policy invite_read_scope on public.survey_invites for select to authenticated
using (
  public.current_app_role() in ('admin','management')
  or salesperson_id = public.current_salesperson_id()
);

drop policy if exists response_read_scope on public.survey_responses;
create policy response_read_scope on public.survey_responses for select to authenticated
using (
  public.current_app_role() in ('admin','management')
  or salesperson_id = public.current_salesperson_id()
);

drop policy if exists answer_read_scope on public.survey_answers;
create policy answer_read_scope on public.survey_answers for select to authenticated
using (
  exists (
    select 1 from public.survey_responses r
    where r.id = response_id
      and (
        public.current_app_role() in ('admin','management')
        or r.salesperson_id = public.current_salesperson_id()
      )
  )
);

-- ---------- authenticated RPCs ----------
create or replace function public.create_survey_invite(
  p_customer_id uuid,
  p_campaign_id uuid,
  p_product_id uuid default null,
  p_expires_at timestamptz default null
)
returns jsonb
language plpgsql security definer
set search_path = public
as $$
declare
  v_customer public.customers%rowtype;
  v_campaign public.survey_campaigns%rowtype;
  v_invite public.survey_invites%rowtype;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  select * into v_customer from public.customers where id = p_customer_id;
  if not found or not public.can_access_customer(p_customer_id) then
    raise exception 'Customer not found or access denied';
  end if;

  select * into v_campaign from public.survey_campaigns where id = p_campaign_id;
  if not found then raise exception 'Campaign not found'; end if;

  if p_product_id is not null and not exists (
    select 1 from public.products p where p.id = p_product_id and p.is_active and p.dealer_enabled
  ) then
    raise exception 'Invalid dealer product';
  end if;

  insert into public.survey_invites(
    customer_id, salesperson_id, campaign_id, product_id, expires_at, created_by
  ) values (
    v_customer.id, v_customer.salesperson_id, p_campaign_id, p_product_id,
    coalesce(p_expires_at, (v_campaign.end_date::timestamptz + interval '1 day' - interval '1 second')),
    auth.uid()
  )
  returning * into v_invite;

  return jsonb_build_object(
    'id', v_invite.id,
    'token', v_invite.token,
    'status', v_invite.status,
    'expires_at', v_invite.expires_at
  );
end;
$$;

create or replace function public.submit_internal_survey(
  p_campaign_id uuid,
  p_customer_id uuid,
  p_product_id uuid,
  p_respondent_type public.respondent_type,
  p_respondent_name text,
  p_answers jsonb
)
returns uuid
language plpgsql security definer
set search_path = public
as $$
declare
  v_customer public.customers%rowtype;
  v_response_id uuid;
  v_item jsonb;
  v_q public.survey_questions%rowtype;
  v_nps smallint;
begin
  if auth.uid() is null then raise exception 'Authentication required'; end if;
  select * into v_customer from public.customers where id = p_customer_id;
  if not found or not public.can_access_customer(p_customer_id) then
    raise exception 'Customer not found or access denied';
  end if;

  if not exists(select 1 from public.survey_campaigns where id=p_campaign_id) then
    raise exception 'Campaign not found';
  end if;

  if not exists(
    select 1 from public.products p where p.id=p_product_id and p.is_active
      and ((p_respondent_type='dealer' and p.dealer_enabled) or (p_respondent_type='farmer' and p.farmer_enabled))
  ) then raise exception 'Invalid product/respondent type'; end if;

  for v_item in select * from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb))
  loop
    select * into v_q from public.survey_questions q
      where q.id=(v_item->>'question_id')::uuid
        and q.product_id=p_product_id and q.respondent_type=p_respondent_type;
    if not found then raise exception 'Invalid question in answers'; end if;
    if v_q.question_no=5 then
      v_nps := nullif(v_item->'answer'->>'value','')::smallint;
    end if;
  end loop;

  if (
    select count(*) from public.survey_questions q
    where q.product_id=p_product_id and q.respondent_type=p_respondent_type and q.required
  ) > (
    select count(distinct (x->>'question_id'))
    from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb)) x
  ) then
    raise exception 'Required answers are missing';
  end if;

  insert into public.survey_responses(
    campaign_id, customer_id, salesperson_id, product_id, respondent_type,
    source, respondent_name, nps_score, submitted_by
  ) values (
    p_campaign_id, v_customer.id, v_customer.salesperson_id, p_product_id,
    p_respondent_type, 'sales', nullif(trim(p_respondent_name),''), v_nps, auth.uid()
  ) returning id into v_response_id;

  for v_item in select * from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb))
  loop
    insert into public.survey_answers(response_id, question_id, answer_json)
    values(v_response_id, (v_item->>'question_id')::uuid, v_item->'answer');
  end loop;

  return v_response_id;
end;
$$;

-- ---------- public shop survey RPCs ----------
create or replace function public.get_public_survey_context(p_token text)
returns jsonb
language plpgsql security definer
set search_path = public
as $$
declare
  v_invite public.survey_invites%rowtype;
  v_customer public.customers%rowtype;
  v_campaign public.survey_campaigns%rowtype;
begin
  select * into v_invite from public.survey_invites where token=p_token;
  if not found then return jsonb_build_object('valid',false,'reason','not_found'); end if;

  if v_invite.status='cancelled' then
    return jsonb_build_object('valid',false,'reason','cancelled');
  end if;

  if v_invite.expires_at is not null and now() > v_invite.expires_at and v_invite.status <> 'completed' then
    update public.survey_invites set status='expired' where id=v_invite.id;
    return jsonb_build_object('valid',false,'reason','expired');
  end if;

  select * into v_customer from public.customers where id=v_invite.customer_id;
  select * into v_campaign from public.survey_campaigns where id=v_invite.campaign_id;

  return jsonb_build_object(
    'valid', true,
    'status', v_invite.status,
    'customer_name', v_customer.client_name,
    'province', coalesce(v_customer.province_normalized, v_customer.province_raw),
    'campaign_id', v_campaign.id,
    'campaign_name', v_campaign.name,
    'preselected_product_id', v_invite.product_id,
    'expires_at', v_invite.expires_at
  );
end;
$$;

create or replace function public.mark_invite_opened(p_token text)
returns boolean
language plpgsql security definer
set search_path = public
as $$
begin
  update public.survey_invites
  set status=case when status='created' then 'opened' else status end,
      opened_at=coalesce(opened_at,now())
  where token=p_token
    and status in ('created','opened');
  return found;
end;
$$;

create or replace function public.submit_public_survey(
  p_token text,
  p_product_id uuid,
  p_respondent_name text,
  p_answers jsonb
)
returns uuid
language plpgsql security definer
set search_path = public
as $$
declare
  v_invite public.survey_invites%rowtype;
  v_response_id uuid;
  v_item jsonb;
  v_q public.survey_questions%rowtype;
  v_nps smallint;
begin
  select * into v_invite from public.survey_invites where token=p_token for update;
  if not found then raise exception 'Invalid survey link'; end if;
  if v_invite.status='completed' then raise exception 'Survey already completed'; end if;
  if v_invite.status in ('cancelled','expired') then raise exception 'Survey link is not active'; end if;
  if v_invite.expires_at is not null and now()>v_invite.expires_at then
    update public.survey_invites set status='expired' where id=v_invite.id;
    raise exception 'Survey link expired';
  end if;
  if v_invite.product_id is not null and v_invite.product_id <> p_product_id then
    raise exception 'Product does not match invite';
  end if;
  if not exists(select 1 from public.products where id=p_product_id and dealer_enabled and is_active) then
    raise exception 'Invalid dealer product';
  end if;

  for v_item in select * from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb))
  loop
    select * into v_q from public.survey_questions q
      where q.id=(v_item->>'question_id')::uuid
        and q.product_id=p_product_id and q.respondent_type='dealer';
    if not found then raise exception 'Invalid question in answers'; end if;
    if v_q.question_no=5 then
      v_nps := nullif(v_item->'answer'->>'value','')::smallint;
    end if;
  end loop;

  if (
    select count(*) from public.survey_questions q
    where q.product_id=p_product_id and q.respondent_type='dealer' and q.required
  ) > (
    select count(distinct (x->>'question_id'))
    from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb)) x
  ) then
    raise exception 'Required answers are missing';
  end if;

  insert into public.survey_responses(
    campaign_id, invite_id, customer_id, salesperson_id, product_id,
    respondent_type, source, respondent_name, nps_score
  ) values (
    v_invite.campaign_id, v_invite.id, v_invite.customer_id, v_invite.salesperson_id,
    p_product_id, 'dealer', 'public', nullif(trim(p_respondent_name),''), v_nps
  ) returning id into v_response_id;

  for v_item in select * from jsonb_array_elements(coalesce(p_answers,'[]'::jsonb))
  loop
    insert into public.survey_answers(response_id, question_id, answer_json)
    values(v_response_id, (v_item->>'question_id')::uuid, v_item->'answer');
  end loop;

  update public.survey_invites
  set status='completed', completed_at=now(), opened_at=coalesce(opened_at,now())
  where id=v_invite.id;

  return v_response_id;
end;
$$;

-- Dashboard view. RLS is enforced through underlying tables.
drop view if exists public.response_overview;
create view public.response_overview
with (security_invoker = true)
as
select
  r.id,
  r.submitted_at,
  r.source,
  r.respondent_type,
  r.respondent_name,
  r.nps_score,
  case
    when r.nps_score >= 4 then 'Promoter'
    when r.nps_score = 3 then 'Passive'
    when r.nps_score <= 2 then 'Detractor'
    else null
  end as nps_group,
  c.id as customer_id,
  c.client_id,
  c.client_name,
  c.province_normalized as province,
  s.id as salesperson_id,
  s.display_name as salesperson_name,
  p.id as product_id,
  p.code as product_code,
  p.name_th as product_name,
  cp.id as campaign_id,
  cp.name as campaign_name
from public.survey_responses r
join public.customers c on c.id=r.customer_id
join public.sales_people s on s.id=r.salesperson_id
join public.products p on p.id=r.product_id
join public.survey_campaigns cp on cp.id=r.campaign_id;

grant select on public.products, public.survey_questions, public.survey_question_options to anon, authenticated;
grant select on public.sales_people, public.profiles, public.customers, public.survey_campaigns,
  public.survey_invites, public.survey_responses, public.survey_answers, public.response_overview to authenticated;
grant insert, update, delete on public.survey_campaigns to authenticated;
grant update on public.profiles to authenticated;

grant execute on function public.get_public_survey_context(text) to anon, authenticated;
grant execute on function public.mark_invite_opened(text) to anon, authenticated;
grant execute on function public.submit_public_survey(text,uuid,text,jsonb) to anon, authenticated;
grant execute on function public.create_survey_invite(uuid,uuid,uuid,timestamptz) to authenticated;
grant execute on function public.submit_internal_survey(uuid,uuid,uuid,public.respondent_type,text,jsonb) to authenticated;
grant execute on function public.current_app_role() to authenticated;
grant execute on function public.current_salesperson_id() to authenticated;
