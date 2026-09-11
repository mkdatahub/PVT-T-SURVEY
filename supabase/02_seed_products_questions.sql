-- Seed products and all USP survey questions from the provided 30-page questionnaire.
begin;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('87559461-5883-586f-924b-b12ab974cd5c'::uuid,'GREENHOUSE','Green House / พลาสติกโรงเรือน','Green House Film','ต้องการฟิล์มทนทาน 1–3 ปี ปกป้องพืชได้จริง',true,true,1,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'POND_LINER','ปูบ่อ / ผ้าปูบ่อ','Pond Liner','ต้องการผ้าปูบ่อไม่รั่วซึม กำหนดขนาดได้เอง',true,true,2,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'SHADE_NET','แสลน','Shade Net','ต้องการกรองแสงตามสัดส่วนพืช ทนแดดทนฝน',true,true,3,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('22903454-9bc7-5025-a316-8050c7704a17'::uuid,'MULCH_FILM','ดำเงิน / พลาสติกคลุมดิน','Mulch Film','ควบคุมวัชพืช รักษาความชื้น ลดต้นทุนแรงงาน',true,true,4,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'PE_PIPE','ท่อ PE / HDPE / LDPE','PE / HDPE / LDPE Pipe','ต้องการท่อมาตรฐาน ทนแรงดัน ราคาสู้จีนได้',true,true,5,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('797feb8b-d26a-52aa-8b69-084776513497'::uuid,'NURSERY_BAG','ถุงเพาะชำ','Nursery Bag','ถุงต้องทนทาน ไม่แตก รากพืชแข็งแรง',true,false,6,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'DRIP_TAPE','เทปน้ำพุ่ง / Drip Tape','Drip Tape','อัตราการไหลสม่ำเสมอ ไม่อุดตัน ทนทานหลายฤดูกาล',true,true,7,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.products(id,code,name_th,name_en,pain_point,dealer_enabled,farmer_enabled,sort_order,is_active)
values ('e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'GENERAL_BAG','ถุงเอนกประสงค์','General-purpose Bag','ราคาดี คุณภาพสม่ำเสมอ ส่งตรงเวลา',true,false,8,true)
on conflict(code) do update set name_th=excluded.name_th,name_en=excluded.name_en,pain_point=excluded.pain_point,
dealer_enabled=excluded.dealer_enabled,farmer_enabled=excluded.farmer_enabled,sort_order=excluded.sort_order,is_active=true;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกซื้อฟิล์มโรงเรือนตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'รู้ว่า USP ที่ลูกค้าให้คุณค่าจริงคืออะไร เปรียบกับที่ทีมคิดไว้',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2cea4acb-a83c-5051-aaa8-6f211be02d51'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O1','คุณภาพ / ฟิล์มทนนาน 1–3 ปี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('af634310-226d-59cc-8fa1-0df9ba4d5d5b'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O2','ความสม่ำเสมอทุก Lot',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b40958a5-c235-5517-9575-7fe3b0f6becb'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O3','ราคาและ Margin คุ้มค่า',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('78de0c52-4b3c-5a47-93c5-05849510bf05'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O4','บริการหลังการขาย',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e372fe71-d4ab-511e-86e0-e788995ccb17'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O5','แบรนด์น่าเชื่อถือ',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('44e68c3a-3e8b-5d5b-952f-096634752119'::uuid,'f247ea71-aa2a-5670-abbf-8c761e01284c'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าในด้านใดมากที่สุด? (ให้คะแนน 1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'นำค่าเฉลี่ยไปเติมช่อง ''เสียงลูกค้า'' ใน Excel USP ได้ทันที',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('239f5634-7fe6-5e77-89b0-51c9d6128649'::uuid,'3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'O1','คุณภาพ/ทนทาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5993da7a-e8c4-5b3b-8692-c5cf27b852f8'::uuid,'3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'O2','ความสม่ำเสมอ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('951f001d-bbaf-5b13-8ab1-131db85cc58b'::uuid,'3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a770d37f-adda-5d72-b96a-d66f0318128e'::uuid,'3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'O4','Delivery ตรงเวลา',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('69340dfc-92d3-5faf-a218-2d2b0adba178'::uuid,'3d3fe2c2-ef35-52dd-8216-ecfe991ed216'::uuid,'O5','บริการหลังการขาย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ตราต้นไม้ปรับปรุงมากที่สุด 1 อย่าง',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ข้อที่ได้มากสุด = Action ที่ต้องแก้ก่อนในไตรมาสหน้า',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('18e8884b-f60f-5656-a1ed-0cc7dcd93dc0'::uuid,'35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'O1','ราคาแพงเกินไปเมื่อเทียบคู่แข่ง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5d832d71-b40e-55ba-a08a-8dbf72b29d9a'::uuid,'35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'O2','Delivery ช้า / ไม่ตรงเวลา',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('25b084c6-7938-58e4-93c8-5ed8a2bf8395'::uuid,'35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'O3','ขาด Stock ช่วง High Season',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3e84d546-945c-5733-8048-c7526990237e'::uuid,'35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'O4','Technical Support น้อยเกินไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('53b78b0a-8863-5f75-a73c-8373ab46b17e'::uuid,'35fd6846-b053-5bf8-92d6-d0e16fadf50d'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางถามเรื่องอะไรมากที่สุดก่อนซื้อฟิล์มโรงเรือน?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ว่า Pain Point ของ End User คืออะไร → ปรับสื่อการขายให้ตรงจุด',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('06e85e5b-b944-5fc2-a48a-c5172a0603de'::uuid,'7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'O1','อายุการใช้งาน / ทนได้กี่ปี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('95032954-a541-5ff6-b293-a7f4b7fe324c'::uuid,'7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'O2','ราคาเทียบยี่ห้ออื่น',2,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('1455c631-49c1-5861-b610-7ef4a41701b1'::uuid,'7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'O3','ความหนา / สเปกฟิล์ม',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ca326802-079e-5e5e-a562-3fff6c1d6962'::uuid,'7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'O4','การรับประกันสินค้า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('24df5999-dad6-5f78-9b20-07e11b6d7ed7'::uuid,'7993f13a-fe29-556e-9749-4d4c16d14eac'::uuid,'O5','วิธีติดตั้ง',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('944adff4-8835-5a13-80f8-415d83b0eef3'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำฟิล์มโรงเรือนตราต้นไม้ให้ร้านอื่น (1=ไม่แนะนำ, 5=แนะนำแน่นอน)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','NPS 4–5 = Promoter | 3 = Passive | 1–2 = Detractor',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้ฟิล์มโรงเรือนตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เปรียบเทียบว่าเกษตรกรให้คุณค่าอะไรต่างจาก Dealer',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('57477367-dd52-57cd-954d-accf0c353c2d'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O1','ฟิล์มทนทาน ใช้ได้นาน 1–3 ปี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e7a4ffbf-f963-511e-aa9b-b69402692aa2'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O2','ไม่ต้องเปลี่ยนบ่อย ประหยัดต้นทุน',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2cda8079-9513-53c9-aa29-84e01d369ae7'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O3','แบรนด์น่าเชื่อถือ',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c65928c6-42d5-5c44-a0bc-f18eb704e3cc'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O4','Sales แนะนำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('15286c64-4eed-5974-95c6-0a6c197365d6'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O5','ราคาเหมาะสม',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('77840065-0341-53e5-8449-9cc133c90b2e'::uuid,'3754243c-70c1-5993-9081-ef0cbdc609ed'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'หลังใช้งานจริง ฟิล์มของเราดีกว่าที่คาดหวังไว้ในด้านใด? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Gap ระหว่าง ''ที่คาดหวัง'' vs ''ที่ได้รับ'' คือ USP ที่แท้จริง',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b1a8391e-5642-5a11-a025-da1745783f71'::uuid,'38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'O1','ความทนทานต่อแสง UV',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d46a497b-8aa4-5f6c-a885-9f75dfed4789'::uuid,'38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'O2','ความสม่ำเสมอของเนื้อฟิล์ม',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4f55aeaa-34a5-5098-a40d-c1472a396887'::uuid,'38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'O3','ผลผลิตที่ได้หลังใช้',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('657a7b0e-77ad-5042-a02e-be1448fb00db'::uuid,'38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'O4','ความคุ้มค่าเมื่อเทียบต้นทุน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('892c7dee-1901-5c7b-a9cf-37fba51f891b'::uuid,'38634765-8be4-50e9-a257-3d2ff22237a6'::uuid,'O5','บริการหลังการขาย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับฟิล์มโรงเรือน (ยี่ห้อใดก็ได้) มากที่สุดคืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Pain Point ที่ยังไม่มีใครแก้ได้ดี = โอกาส Innovation',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('52d6c17b-ee93-5fbc-8874-350eaaf74d39'::uuid,'fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'O1','ฟิล์มเปราะ แตกหักง่ายก่อนกำหนด',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('484724d1-2911-560b-b8ae-41115c434f0c'::uuid,'fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'O2','สีซีดเร็ว แสงผ่านเปลี่ยนไป',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('8f9121ec-b949-5cfe-b5cd-2dc8f09200cd'::uuid,'fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'O3','ขนาดไม่ตรงกับโรงเรือน',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a9a5e718-9963-5f72-9df3-9bac1902dd02'::uuid,'fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'O4','ราคาแพงเกินไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('8012a3ce-b86d-524d-8fa8-c61fabf6948a'::uuid,'fe11574b-f7a6-5855-ab89-e5d272e34cdd'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'เคยเปรียบเทียบกับยี่ห้ออื่นไหม? ถ้าเคย ยี่ห้อใด?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ Competitive Set จริงในพื้นที่ ไม่ใช่แค่ที่ทีมคาดเดา',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('82375e8d-27bb-5423-beea-8f1562679dc8'::uuid,'2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'O1','VSC',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('24430fbb-e51d-5549-9127-65167ba483eb'::uuid,'2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'O2','SPI',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7c0efb8f-726e-59e4-b809-bd3f21199dd9'::uuid,'2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'O3','สินค้าจีน (ไม่ระบุยี่ห้อ)',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('100e8c80-edce-592e-bc42-b33d30f33250'::uuid,'2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'O4','ไม่เคยเปลี่ยน ใช้ตราต้นไม้อย่างเดียว',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7fa3520f-f2b3-5e8d-8c6f-cf2a0c77c2fd'::uuid,'2faf1590-5498-5c18-b658-2fe455a8df91'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('c62fd061-c558-5e91-9e72-ad98f831ca8b'::uuid,'87559461-5883-586f-924b-b12ab974cd5c'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำฟิล์มโรงเรือนตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','สะท้อนประสบการณ์ใช้งานจริง',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งผ้าปูบ่อตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'ตรวจสอบว่า USP ''กำหนดขนาดได้'' ถูกรับรู้จาก Dealer ไหม',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('523ae405-4918-5a85-b76a-7827206b7f92'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O1','กำหนดความกว้าง-ยาวได้เอง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('cc92bc4b-607b-5844-8251-422c1768f495'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O2','คุณภาพ/ไม่รั่วซึม',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b0acad50-a83e-5a7e-bd1d-566589066e57'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O3','ส่งฟรีถึงหน้าร้าน',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d1ba61a2-5777-5cdb-8dba-dbcb1fe0df88'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O4','ราคาและ Margin ดี',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('506e01f2-0221-51d4-9597-6ff8676f9eda'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O5','มาตรฐานสม่ำเสมอ',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4be9766d-d879-5339-8af5-5bb09cf91284'::uuid,'cef0456f-7bc0-5a16-a901-62335812479f'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับ TCT / คงสวัสดิ์ / เอกสุวรรณ เราดีกว่าในด้านใด? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'นำไปเทียบกับคะแนนภายในทีมใน Excel — Gap สูง = ต้องสื่อสารเพิ่ม',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('62a227c8-9e84-5a31-b823-4704605a81ff'::uuid,'220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'O1','คุณภาพ/ไม่รั่วซึม',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('41c97db1-04be-5fef-af49-eee639c15cb8'::uuid,'220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'O2','ความยืดหยุ่นด้านขนาด',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('af64c220-a09f-5701-85f1-f8810ae6b2a3'::uuid,'220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('eecceb0e-c5a8-5614-8d0f-f446736eaa22'::uuid,'220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'O4','Delivery ตรงเวลา',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ebe9bbf0-6437-5bc0-b4f3-bd42006ced3d'::uuid,'220c4b03-83f6-54ea-b0f4-3e73e221e6ad'::uuid,'O5','บริการหลังการขาย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ตราต้นไม้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'จุดอ่อนที่ Dealer บอกตรงๆ = ข้อมูลที่แม่นยำที่สุด',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('60197ad7-a5c9-5cb0-a3ed-e77c13922744'::uuid,'5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'O1','ราคาแพงกว่าคู่แข่ง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c9baae6b-930a-5f9f-97a9-0b7f45b3f605'::uuid,'5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'O2','ขนาดพิเศษใช้เวลาผลิตนาน',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9e330353-d512-52bc-a00c-9186bb8561e4'::uuid,'5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'O3','ขาด Stock ขนาดมาตรฐาน',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9eb0f006-099c-5933-9d28-090b0399a537'::uuid,'5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'O4','อยากได้รูปแบบ Credit Term ที่ดีกว่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ef803c37-4a2c-5ba0-b874-c86d60da9c2f'::uuid,'5b8e8011-3285-54dc-abb5-45a101aa9bb1'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางที่ซื้อผ้าปูบ่อส่วนใหญ่คือใคร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'เข้าใจ Value Chain จริง ว่า End User คือใคร เพื่อออกแบบ Promotion ให้ถูกกลุ่ม',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('16f88a0c-8277-57c9-b98c-2eaa4cfa3b71'::uuid,'8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'O1','เกษตรกรเพาะกุ้ง/ปลา',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('95eb90df-74bb-5195-90b6-da5ed9d87802'::uuid,'8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'O2','สวนผัก/ผลไม้ที่ต้องการบ่อน้ำ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('42973bc5-8d93-56b7-a23e-d9ea9079b265'::uuid,'8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'O3','ผู้รับเหมาก่อสร้าง',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3327dc2e-8940-5b40-a239-ca5dce1080ce'::uuid,'8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'O4','เกษตรกรทั่วไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f528e919-ad69-57ba-b658-8b193fcd71fd'::uuid,'8b68272b-bd4e-51a2-ab8f-8ad84ef2250d'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('f346927e-d818-547f-80ee-17dbc52c0d74'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำผ้าปูบ่อตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','NPS Dealer สะท้อนความแข็งแกร่งของ Channel',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้ผ้าปูบ่อตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เกษตรกรเน้น ''ไม่รั่ว'' มากกว่า ''ราคา'' — ยืนยันหรือหักล้าง USP',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('df55081b-3196-55d4-a6dd-e9b61eb7060b'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O1','คุณภาพดี ไม่รั่วซึม',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e479b71a-bb29-5f20-b913-076646a103db'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O2','กำหนดขนาดบ่อได้เอง',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4afe9afb-8398-5be6-8389-0ae67acbbc71'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O3','ราคาเหมาะสม',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('35835ffd-1d8c-59ea-b65b-998367692999'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O4','ร้านที่ซื้อประจำแนะนำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('24fe8790-dea4-5a86-9108-6f0a85cb8e2c'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O5','ไม่เคยมีปัญหากับยี่ห้อนี้',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('46367363-0427-560f-b88c-74f40f46faa8'::uuid,'86200713-6f48-54fc-8d82-1e229ea270c2'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'หลังใช้งานจริง ผ้าปูบ่อของเราดีกว่าที่คาดไว้ในด้านใด? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'USP ที่ได้จากปากเกษตรกรโดยตรงน่าเชื่อถือกว่าการประเมินภายใน',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5cd9adbe-6a7a-5668-82a4-717ced9d6341'::uuid,'362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'O1','ความแข็งแรง/ไม่รั่ว',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('751ba91e-2d4a-50da-982d-5da0c5e2d485'::uuid,'362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'O2','ความคงทนระยะยาว',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c982d74e-f3b0-5ff5-9600-5a33d6469ace'::uuid,'362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'O3','ขนาดตรงตามที่สั่ง',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e538f89b-bfcf-5e71-a678-2d11ed72a177'::uuid,'362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'O4','ความคุ้มค่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e4709b7d-19ca-5a26-9120-d4310db4fb65'::uuid,'362b7df7-5fd8-535e-b16c-1879ad51c325'::uuid,'O5','บริการหลังการขาย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับผ้าปูบ่อ (ยี่ห้อใดก็ได้) คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ปัญหาที่คู่แข่งยังแก้ไม่ได้ = โอกาสสร้าง Differentiation',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ba8f1a92-b85e-5135-90b2-1b37f3e30e66'::uuid,'d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'O1','ผ้ารั่วก่อนกำหนด',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7d3ffebb-2706-5c0d-8633-d9b670143b00'::uuid,'d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'O2','ขนาดไม่ตรงกับบ่อ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('277df983-6553-515a-96c1-2842c066db26'::uuid,'d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'O3','ราคาแพงเกินงบ',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5174b9e7-8753-534c-a609-893f55b209c5'::uuid,'d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'O4','ไม่มีบริการหลังการขาย',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('0b0d0a6f-1e45-5027-9156-27a75f629ef7'::uuid,'d2731755-79a2-55be-bc8f-bdedb4ec950b'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'พืช/สัตว์ที่ปลูก/เลี้ยงในบ่อนี้คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ Use Case จริง → Promotion ตรงฤดูกาลพืช/สัตว์นั้น',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b047d880-d40c-5bd0-9af0-09c6fa414eb8'::uuid,'e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'O1','กุ้ง/ปลา',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('db51c406-c77f-5316-9a5f-9d8060aa5f5b'::uuid,'e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'O2','ผักไฮโดรโปนิกส์',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9e50dfb5-43bd-5eae-8cc9-b3b2010ab034'::uuid,'e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'O3','บัว/พืชน้ำ',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('44d959aa-0f69-5845-9422-86fcc9bbff3d'::uuid,'e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'O4','กักเก็บน้ำเพื่อชลประทาน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2d70cc54-eea9-55b0-b18b-04559744e53c'::uuid,'e688ff9e-c20c-5b84-84b0-96fc6aea2050'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('e9b221f3-5986-5a27-95f8-bd63afe80d9c'::uuid,'bfb6694a-1efd-5f9f-a341-b305ff51c3fa'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำผ้าปูบ่อตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','Word of Mouth ในกลุ่มเกษตรกร',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งแสลนตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'Dealer โฟกัส Margin vs เกษตรกรโฟกัส % แสง — เปรียบเทียบ 2 กลุ่มให้เห็น Gap',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('765848e0-8d78-5e75-acf0-3ee129abbd0e'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O1','คุณภาพ/ความทนทาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('949836ab-967e-5802-aa52-f3e4bc49260a'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O2','เปอร์เซ็นต์กรองแสงตรงตามสเปก',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('48503ba7-e6f0-5cbf-b73e-639319df5525'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O3','ราคาและ Margin ดี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4d2d419a-2d8e-55fa-9345-5504744d235b'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O4','มีหลายขนาด/หลาย %',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b11126f0-c130-5435-9b40-919edd3d92de'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O5','แบรนด์น่าเชื่อถือ',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2fffe038-ee2d-55a0-8a41-9094b8b7b1dc'::uuid,'498dc2e1-81d5-5a31-8b38-cfd126be3e90'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ปัจจัยที่เราได้ต่ำกว่า 3 = จุดเสี่ยงที่ Dealer อาจหันไปหาคู่แข่ง',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f92534e4-9f66-5887-8fd7-81f4b895160c'::uuid,'0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'O1','ความแข็งแรง/ทนทาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('125af06d-bcb7-580b-84e4-16e22f29cb1d'::uuid,'0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'O2','ความแม่นยำ % แสง',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9ba8f6da-50d0-530f-a3f2-c3f1a8ad9bed'::uuid,'0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('da0ffa94-60db-537b-b2c1-09fdf9c61e5b'::uuid,'0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'O4','ความหลากหลายขนาด',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('84fd61d0-3d56-5624-b61c-3c27492c2906'::uuid,'0b77de5c-0b43-53ac-8744-3ab370a73fec'::uuid,'O5','Delivery',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Action แรกที่ต้องทำก่อน Q ถัดไป',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('32a69f53-327b-5377-8eab-1c92f75b4730'::uuid,'996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'O1','ราคาแพงกว่าจีน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9f5922b3-8f9d-5ea6-ad1c-6996e6c9d3f1'::uuid,'996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'O2','สีซีดเร็วกว่าที่บอก',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('84f8918d-c8db-5c9e-bb2f-9afba556df9b'::uuid,'996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'O3','ขนาดที่ต้องการไม่มี Stock',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3f4fe4c9-4282-5d8a-be1f-85ce4f505353'::uuid,'996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'O4','ข้อมูลสเปก % แสงไม่ชัดเจน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('8560d1d0-f10d-54dc-8032-965ee7c4184c'::uuid,'996071a6-67e9-5dc9-897f-72def9aff086'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางที่ซื้อแสลนส่วนใหญ่ใช้ทำอะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ Use Case → วางแผน Seasonal Promotion ได้แม่นยำขึ้น',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b85f7c8f-599c-5efc-b461-6497795ed7f7'::uuid,'fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'O1','โรงเรือนผัก/ผลไม้',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f5b94fbd-858f-51d4-b6dd-7399d85f41ac'::uuid,'fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'O2','รั้วกันแดด',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('bc366fc7-a781-5c0f-8ab8-8308429bbe44'::uuid,'fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'O3','ที่พรางแสงลานจอดรถ',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e6a4a1be-5cc6-5fdf-ac89-894a1d83ae4d'::uuid,'fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'O4','เพาะกล้า/เรือนเพาะชำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b07c352b-dc8a-537a-8da1-3ff3b39c4892'::uuid,'fa059cac-4c84-5faa-ae6f-35fe4deaf94b'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('3b6338d7-fbb1-579d-9517-affb5d5afd3f'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำแสลนตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','NPS Dealer แสลน บ่งบอกความแข็งแกร่งของ Distribution',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('6850649c-551d-5723-8842-f734c654324e'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้แสลนตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เกษตรกรเน้น ''% แสงตรง'' มากกว่าราคา — ยืนยัน USP ที่แท้จริง',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('26a1e05a-3e47-5a6d-a85f-3be3225b680a'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O1','ความทนทาน ใช้ได้นาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d43fb986-99c7-54db-a8a6-6eccdb8626a7'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O2','เปอร์เซ็นต์กรองแสงตรงตามต้องการ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ffc0ad0c-2288-58d7-b770-ad83ee06a065'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O3','ราคาเหมาะสม',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6a94419f-0f69-58b9-b6fe-4c6202241f62'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O4','ร้านที่ซื้อประจำแนะนำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('1922fe47-5ecc-50ce-bd91-9dd5139ef247'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O5','สีไม่ซีดเร็ว',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d5ba724d-7ab5-54cc-b051-6f622674b020'::uuid,'6850649c-551d-5723-8842-f734c654324e'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'แสลนที่ใช้อยู่ตอบโจทย์การปลูกพืชของคุณไหม? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'วัดว่าสินค้าแก้ Pain Point ได้จริงไหม ไม่ใช่แค่ขายได้',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('97a0d493-1f35-5ea0-b8c0-6887c12a7670'::uuid,'a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'O1','% แสงตรงกับความต้องการพืช',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('73f48079-de96-51b7-afe8-d4e79773918b'::uuid,'a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'O2','ความทนทานต่อสภาพอากาศ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('450494a1-210e-5ab8-bf38-a248268a4383'::uuid,'a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'O3','ขนาดเหมาะกับพื้นที่',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2d7461a1-86d3-50e6-b0c1-d6fbb50fb9a6'::uuid,'a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'O4','ความคุ้มค่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('596b8957-9d56-512a-8892-677d0993c147'::uuid,'a4083d82-a471-5e85-8ea4-5ee5d6ad134a'::uuid,'O5','ง่ายต่อการติดตั้ง',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'พืชที่ปลูกใต้แสลนคืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Segment ตาม Crop → Promotion ตรงช่วง Planting Season',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('de162b02-6b0f-548a-b7b6-f42ca9ad5639'::uuid,'7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'O1','ผักใบเขียว (ผักบุ้ง/คะน้า)',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c0f46c8f-820b-5851-9bf9-440fcd4208c4'::uuid,'7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'O2','สตรอว์เบอร์รี/เมลอน',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('dcd53594-4b9e-59cc-b4cc-ea65dd69aba4'::uuid,'7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'O3','กล้วยไม้/ไม้ดอก',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7d6c16d7-a48b-52fd-99f1-215570c2276a'::uuid,'7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'O4','กล้าไม้/เพาะชำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e4df176d-2f2a-57b6-8db4-9fa50929c11e'::uuid,'7d91fa49-459c-5893-b375-7026e9b6ded5'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับแสลน (ยี่ห้อใดก็ได้) คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Pain ที่ยังแก้ไม่ได้ในตลาด = โอกาส Product Development',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('bf9f0c85-2729-54d1-accb-8e7cf968533c'::uuid,'2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'O1','สีซีด % แสงเปลี่ยนก่อนกำหนด',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4f822552-c188-5b08-a3c3-0ea317ac74bc'::uuid,'2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'O2','ขาดหรือฉีกง่าย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ff2f7dc3-7fdd-5767-9f4c-33aa4310d77e'::uuid,'2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'O3','ขนาดไม่ตรงพื้นที่',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('50630e0a-9c98-5bd9-a6db-e1b2bff381b7'::uuid,'2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'O4','ราคาแพงเกินไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d9502850-9881-5294-afcb-11f2ff28fdff'::uuid,'2b08c3eb-7fb0-5f3d-9de7-58d9089aa1c7'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('a0ecccb7-8f2a-5de6-9d90-d86f61704bab'::uuid,'5e53e4c1-0ec9-5780-be6a-2075a768eaf8'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำแสลนตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','Word of Mouth ในกลุ่มเกษตรกรเป็นช่องทาง Marketing ที่ทรงพลัง',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('4438717c-fd60-5c82-a131-35af12daf929'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งพลาสติกคลุมดินตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'ตรวจสอบว่า Dealer ให้คุณค่ากับ ''ความหนาตรงสเปก'' เท่ากับที่เราคิดไหม',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6f639362-1c43-5a50-830e-1c4491834010'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O1','ความหนาตรงตามสเปก ไม่ขาดง่าย',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a00327ec-f3ec-5ac1-8d80-9e9687ea9770'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O2','สีดำด้านกำจัดวัชพืชได้ดี',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('8e4b5295-21bb-5411-83d0-0b1b834da426'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O3','ราคาและ Margin ดี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f0a69690-5faf-564c-b611-22f8136070c3'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O4','มีทั้งหน้าดำ-หลังเงิน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('01ae5651-8f73-5c79-a266-963274722c93'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O5','Delivery ตรงเวลา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('88e06905-b945-5dfc-aa87-6a1975ac8dfe'::uuid,'4438717c-fd60-5c82-a131-35af12daf929'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ปัจจัยที่คู่แข่งจีนมักชนะคือราคา — ดูว่าเราชนะด้านไหนได้บ้าง',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2e6b723f-1251-5e0f-aa62-ca7c97891a65'::uuid,'5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'O1','ความหนา/ทนทาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('421587e8-eb9c-5529-82bc-a7aa4972f02f'::uuid,'5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'O2','ประสิทธิภาพกำจัดวัชพืช',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('1229088d-c586-5e0b-999f-0c697e08cb57'::uuid,'5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('90e449c1-945d-5e2b-9628-055a8912b32e'::uuid,'5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'O4','ความหลากหลาย',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c17949d5-b915-57ab-b9aa-e83e0eddbf98'::uuid,'5b050049-1f9b-5262-92f5-9eae703a9bbe'::uuid,'O5','Delivery',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ถ้า ''ราคา'' ถูกเลือกมากสุด แสดงว่าจีนกำลังกดดัน — ต้องหา Differentiation อื่น',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('50c90993-c47b-5fb6-99f7-df354bde54ad'::uuid,'aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'O1','ราคาแพงกว่าจีน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c02b7f65-1cf3-5c82-8804-d83e93f277c4'::uuid,'aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'O2','ขาด Stock ช่วง High Season',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3f23dc08-1a6c-58ce-8d2d-85c4fdbe9cfb'::uuid,'aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'O3','ขนาดม้วนที่ต้องการไม่มี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7395f23f-2528-56f6-bdce-ff7ebb47d65d'::uuid,'aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'O4','คุณภาพไม่สม่ำเสมอ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('60329932-74e2-526c-9944-4ff68ce0cb35'::uuid,'aaf464d2-1ce5-5d0c-b732-80a653ff6769'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางใช้พลาสติกคลุมดินกับพืชอะไรมากที่สุด?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'วางแผน Stock ล่วงหน้าตรงกับช่วง Planting Season ของแต่ละพืช',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2715abd9-b994-5897-8dc1-1524628ac753'::uuid,'26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'O1','สตรอว์เบอร์รี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d13d882c-18f9-5f6d-8fb7-17cec77f5c9c'::uuid,'26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'O2','มะเขือเทศ/พริก',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d07970a3-74fc-521a-82cd-1bd4bbaa1a9a'::uuid,'26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'O3','อ้อย/มันสำปะหลัง',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6e3eaf6c-f761-52f5-aeaa-8666b7382e4c'::uuid,'26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'O4','ผักทั่วไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3eed5ed6-af25-5937-8601-152ff5e544f1'::uuid,'26d8ae4a-d392-52e1-86f3-2e88cd48923e'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('9f364fbc-2633-5742-a076-d3773e307e08'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำพลาสติกคลุมดินตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','ติดตามแรงกดดันด้านราคา',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้พลาสติกคลุมดินตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เกษตรกรเน้น ''ผลลัพธ์จริง'' คือลดวัชพืชได้ไหม — ต่างจาก Dealer ที่เน้น Margin',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6113e0f4-a68d-5bd0-9ad7-d30b4e00263a'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O1','ลดวัชพืชได้จริง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('35ad8f03-85f3-5e8d-af5b-b8775f40c96c'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O2','รักษาความชื้นดิน ประหยัดน้ำ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4fd52fc1-fd85-5e96-b065-46c19b5a4e9d'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O3','ความหนา ไม่ขาดง่าย',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7b76e1fb-159c-5a6c-a889-a21cf906e8a8'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O4','ราคาเหมาะสม',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b51523c3-61f3-5504-a0e3-c13c5b101cac'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O5','ร้านแนะนำ',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('0ee90578-0bea-519b-9e44-ec9970345fe3'::uuid,'8abbeec7-608a-5471-a5db-4939f9565d88'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'หลังใช้งานจริง พลาสติกคลุมดินของเราดีกว่าที่คาดไว้ตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'สิ่งที่เกษตรกร ''ประหลาดใจว่าดีกว่าที่คิด'' คือ USP ที่ต้องสื่อสารมากขึ้น',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3bb6a8dc-e91c-5815-8ef4-dd40dafeafd6'::uuid,'7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'O1','ประสิทธิภาพกำจัดวัชพืช',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('030ec37c-1ddc-5ada-ade8-53329e9ad266'::uuid,'7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'O2','ความทนทานตลอดฤดูกาล',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('71773c60-eb43-514a-970d-1ba82d440683'::uuid,'7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'O3','รักษาความชื้น',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('aaf3cd95-a334-5215-a237-abf6aee49259'::uuid,'7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'O4','ความคุ้มค่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('82b71d76-2884-5ef5-97da-034487229891'::uuid,'7f4ced30-de2c-5806-8c29-82e19c53a9e0'::uuid,'O5','ง่ายต่อการใช้งาน',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับพลาสติกคลุมดิน คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ปัญหาที่ยังไม่มีใครแก้ได้ดี = โอกาส Product Innovation',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('52c60bb9-5204-5db1-9b03-b5ae52b6dd28'::uuid,'24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'O1','ฉีกขาดก่อนสิ้นฤดูกาล',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('26c19438-d581-59cd-87d0-0e2110b8bd10'::uuid,'24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'O2','วัชพืชยังขึ้นได้อยู่',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2a32ad99-ad0e-58bd-a62f-82c376565051'::uuid,'24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'O3','ราคาแพงเกินไป',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('891c1c7e-ce05-595a-b07c-34c795afe150'::uuid,'24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'O4','ติดตั้งยาก',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b4374563-85d4-5767-9b6b-ef65c61ed04a'::uuid,'24badb91-c253-5396-a0cc-7e1dffe611c0'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'พืชที่ปลูกและใช้พลาสติกคลุมดินคืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Crop Segmentation → Promotion ตรงฤดูปลูกแต่ละพืช',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b25289df-32ad-5376-b655-e7aafe8ef8bf'::uuid,'ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'O1','สตรอว์เบอร์รี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a167f251-f1c1-518f-888b-706a1ca0954a'::uuid,'ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'O2','พืชผักทั่วไป',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5b6c5f8d-3dec-54d9-96ba-5f9482705be0'::uuid,'ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'O3','ไม้ผล (มะม่วง/ลิ้นจี่)',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('15bc9942-ccf2-5592-8d22-16766c6963b2'::uuid,'ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'O4','อ้อย/มันสำปะหลัง',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('10f5f5b2-6950-5290-9532-122887c1eb2d'::uuid,'ad1d0bf6-ad3f-5863-a6d1-65ad3dcec081'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('fa3b2cb3-36e8-56d9-a1f6-7feed1219332'::uuid,'22903454-9bc7-5025-a316-8050c7704a17'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำพลาสติกคลุมดินตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','เกษตรกรที่ให้ 5 คือกลุ่ม Advocate ที่ดีสำหรับ Case Study',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งท่อ PE ตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เอกสารต้นฉบับกล่าวถึงมาตรฐาน มอก./TIS ในส่วนวิเคราะห์ แต่ Q1 ไม่ได้ระบุเป็นตัวเลือก',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5e12785e-3967-5335-a304-83c17fedc01e'::uuid,'a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'O1','ทนแรงดันตามสเปก',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4e900996-4a5d-5b52-b00c-99a5177b5d4d'::uuid,'a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'O2','ราคาและ Margin ดี',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6bfe8cbe-af08-5c0c-868c-aa2ae153bc1d'::uuid,'a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'O3','มีหลายขนาด/หลายชนิด',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e34a7a40-3c01-50d6-a6c4-14dd3ced91e8'::uuid,'a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'O4','Delivery ตรงเวลา',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9018727e-9d85-5b07-9031-f202cbe9f68f'::uuid,'a2429b3f-a27b-5dd3-bbea-90890cf10762'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ปัจจัย ''มาตรฐาน'' คือจุดที่จีนแพ้เราได้ — ดูว่า Dealer เห็น Gap นี้ไหม',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('0bee8fe4-12cb-5aa2-909c-05c78447da61'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O1','คุณภาพ/ทนแรงดัน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('17df3700-2de4-5853-843a-737234901cbe'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O2','มาตรฐาน/ความน่าเชื่อถือ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f998b909-41df-5adf-8f46-d262624eafd4'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('78a56e1e-5f4c-5906-b2a0-65a86677156c'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O4','ความหลากหลาย',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3f6ad605-046d-5df3-81ef-85c9203f0010'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O5','Delivery',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a461965a-9181-51c4-a357-544c758f24e6'::uuid,'cd42a470-a2f0-5218-a1cf-d873292e3120'::uuid,'O6','มาตรฐาน มอก. / TIS ชัดเจน',6,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'''ขาด TIS'' ถูกเลือกมากสุด = ลงทุนขอ Certification คุ้ม',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ffa195bc-1778-5e84-81b0-ad9724d467ae'::uuid,'53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'O1','ราคาแพงกว่าจีน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('15c21937-e6ee-5b18-aaee-3a00077bfeaf'::uuid,'53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'O2','ขาด TIS บางประเภท',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('16592887-3c97-513d-b65a-38ef8158c553'::uuid,'53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'O3','ขนาดที่ต้องการไม่มี Stock',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('26ed73cd-ab83-5ef0-a4d0-4ac1b4a432b0'::uuid,'53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'O4','Delivery ช้า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('dc28fc79-5550-5f15-a813-923c2f87bbda'::uuid,'53224ee8-cb48-50b7-8584-98c0cc7bb327'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางส่วนใหญ่ใช้ท่อ PE ทำอะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ Use Case → วางแผน Bundle Product กับเทปน้ำพุ่ง/แสลนได้',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7421a07f-5938-5189-b53d-d6985ab12fd2'::uuid,'53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'O1','ระบบน้ำหยด/Drip Irrigation',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e5433af3-80a6-54cb-a3ed-6b27a76a459b'::uuid,'53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'O2','ส่งน้ำในสวน/ไร่',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f03068fd-cee9-55f7-99f5-c3b0f15ee2dc'::uuid,'53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'O3','ก่อสร้าง/งานโยธา',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9036695a-8558-5857-b195-d2de7e189a7b'::uuid,'53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'O4','ประปาชุมชน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('8a433f2f-dd61-5b9d-bbf3-1ae30f52fcac'::uuid,'53f631d9-9c61-50aa-8b35-0d102c1659a4'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('43efa97e-f674-5bb0-9ea1-c588aa395826'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำท่อ PE ตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','ติดตามสินค้า PE เป็นพิเศษ',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้ท่อ PE ตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เกษตรกรมักไม่รู้เรื่อง TIS — ถ้าเลือก ''ทนได้นาน'' แสดงว่าคุณภาพคือ USP ที่ได้ผล',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ce35f530-fd0c-54b3-898d-c7cc7d3293a8'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O1','ทนทาน ใช้ได้นานหลายปี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('09a2ee01-091e-55e3-9c61-bc2aa4d820c0'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O2','ไม่แตกร้าวหรือรั่วง่าย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3e65a03c-8504-58db-af03-2e97e8eb5fe5'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O3','ราคาเหมาะสม',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('53e43a2a-f578-576d-baab-a82f3735d5d2'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O4','ร้านที่ซื้อประจำแนะนำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('bbcff46e-67e0-5b9e-a2d3-5394be5aaf2d'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O5','หาซื้อได้ง่าย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e4e519e5-e7e1-5e79-a3bf-0937facd49ca'::uuid,'1a540568-47c3-53bf-afe7-6fa8d3524c0f'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('79212c9b-8671-54ac-ad61-739326f06151'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'ท่อ PE ที่ใช้อยู่ตอบโจทย์ระบบน้ำในฟาร์มไหม? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Performance ที่ต่ำกว่า 3 คือสัญญาณเตือนก่อนที่ลูกค้าจะเปลี่ยนยี่ห้อ',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ad0c2945-baab-5618-ba8b-37f5680dfd56'::uuid,'79212c9b-8671-54ac-ad61-739326f06151'::uuid,'O1','ทนแรงดันน้ำได้ดี',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2798f267-6857-559d-9de2-eb829e4bccf4'::uuid,'79212c9b-8671-54ac-ad61-739326f06151'::uuid,'O2','ไม่รั่วซึมบริเวณต่อ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('13d2a4a4-a6c3-5372-b8a6-a9d7f3ae954a'::uuid,'79212c9b-8671-54ac-ad61-739326f06151'::uuid,'O3','ความทนทานระยะยาว',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('99107871-0af2-5f7f-bfd3-9cbb262126c7'::uuid,'79212c9b-8671-54ac-ad61-739326f06151'::uuid,'O4','ความคุ้มค่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6dfbf592-421f-5c84-9f35-1c8b40a0912d'::uuid,'79212c9b-8671-54ac-ad61-739326f06151'::uuid,'O5','ติดตั้งและต่อท่อง่าย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับท่อ PE (ยี่ห้อใดก็ได้) คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Pain Point ท่อ → เชื่อม Insight กับการพัฒนา Technical Support',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('70d36c1a-80aa-5ca9-8190-82aafa117e9e'::uuid,'eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'O1','แตกร้าวเมื่อโดนแดดนาน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6d413f03-ce8c-5829-8b31-beffb5632bbe'::uuid,'eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'O2','รั่วบริเวณข้อต่อ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f773e101-c0de-51c8-a0b4-a9bb347ee7c4'::uuid,'eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'O3','ราคาแพงเกินไป',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('820a13ed-55ae-5fdf-bf7d-79510f403227'::uuid,'eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'O4','ขนาดไม่ตรงกับระบบที่มี',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f2c93980-551d-5ab1-9356-cfce62f851cd'::uuid,'eae8353f-cd3b-51f7-8fe4-56f7e87eeed2'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'ระบบน้ำที่ใช้ในฟาร์มเป็นแบบไหน?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ระบบน้ำ → Package ท่อ PE + เทปน้ำพุ่ง เพิ่ม Cross-sell',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7aff7470-135f-51b0-ad51-56796826f8b7'::uuid,'1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'O1','ระบบน้ำหยด (Drip)',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5d0350c8-791b-5105-94e8-c6ad028ff28d'::uuid,'1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'O2','สปริงเกลอร์',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('71c67c9e-c8cd-58b2-8969-6db8ed608824'::uuid,'1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'O3','ท่อส่งน้ำธรรมดา',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('7ff71fae-c0ba-5a7c-b3b2-be41ba9fa923'::uuid,'1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'O4','Micro Sprinkler',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b1ed9613-0904-5cbc-8958-92ed66cd6521'::uuid,'1b543cd8-d0eb-53a5-ab0a-8a83d249fab8'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('5147c05d-09a7-5767-b10f-e720adda1402'::uuid,'b11cbfda-d2e4-58df-a8e5-6c00c782719c'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำท่อ PE ตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','โอกาส Bundle Promotion',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'797feb8b-d26a-52aa-8b69-084776513497'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งถุงเพาะชำตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'Dealer ถุงเพาะชำมักโฟกัส Price/Unit เป็นหลัก ถ้าเลือก ''คุณภาพ'' แปลว่าเราสร้างความแตกต่างได้แล้ว',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('22a724d0-8a9f-581c-96a9-4961d82e52ff'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O1','ความแข็งแรง ไม่แตกง่าย',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5f22d84c-c9b4-596e-bb4e-52cacee84850'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O2','รูระบายน้ำพอดี',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ca826442-33d9-592f-9918-b8c4af96998e'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O3','ราคาต่อใบถูก',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('eb1d17b7-75c7-5122-8ab5-a665068911b2'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O4','มีหลายขนาดให้เลือก',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('688f25e0-6b8a-5d87-b0d4-390cdd1c2b90'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O5','Delivery ตรงเวลา ไม่ขาด Stock',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('fdd70bd1-d8c8-5be9-9363-c9db4f2ceff5'::uuid,'fcb5dc98-7ef4-5830-a9f6-1abab95b8825'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'797feb8b-d26a-52aa-8b69-084776513497'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ถ้า ''ราคา'' ได้ต่ำกว่า 3 แสดงว่าจีนกดดันมาก ต้องหา Differentiation อื่น',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9218aeb4-0df6-5da7-a329-92f6236ab2a0'::uuid,'6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'O1','ความแข็งแรง/ไม่แตก',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b17609b5-325d-5d47-9bfa-271ef4247c49'::uuid,'6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'O2','ราคาต่อใบ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('45f59080-b107-54c3-96d1-5f78b79c9053'::uuid,'6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'O3','ความหลากหลายขนาด',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a4a8d77f-0380-5b3c-a423-32f99356b32c'::uuid,'6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'O4','Delivery ตรงเวลา',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('f39d3b6f-ac3b-5b8f-8a63-cab6d2eeead3'::uuid,'6156d127-dbc5-592a-a831-ff9f8842f303'::uuid,'O5','ความสม่ำเสมอแต่ละ Lot',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'797feb8b-d26a-52aa-8b69-084776513497'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'จุดอ่อนจาก Dealer มักสะท้อน Pain ของ End User ด้วย',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e453b89a-9ad6-5b21-b73f-f3cfc4930d26'::uuid,'c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'O1','ราคาแพงกว่าคู่แข่ง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b2368494-68a6-58bf-aefd-66df595006bb'::uuid,'c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'O2','ถุงบางไม่สม่ำเสมอบาง Lot',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('42dfb23c-379e-56e5-ac73-e029abb7fff4'::uuid,'c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'O3','ขนาดที่ต้องการไม่มี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ac53e9b1-8d3c-5065-a2f6-376269fe8e3d'::uuid,'c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'O4','Delivery ช้า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a6790da6-7250-56e4-a7ef-37c2f2825c38'::uuid,'c6528922-38ce-5bdf-80db-4ee1e3946573'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'797feb8b-d26a-52aa-8b69-084776513497'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางส่วนใหญ่ใช้ถุงเพาะชำทำอะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Segment End User → วาง Seasonal Stock ให้ตรงกับช่วงเพาะกล้า',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5272452e-d2cd-5ed6-a94d-7e7c856d5901'::uuid,'5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'O1','เพาะกล้าผัก',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('940dd3ce-6cdb-568b-a179-63c114af514a'::uuid,'5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'O2','เพาะกล้าไม้ผล',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6abff598-0c7a-5f92-942c-c0e653769e22'::uuid,'5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'O3','ต้นไม้ประดับ/ไม้ดอก',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3f98f291-82c3-527a-ba26-5910be716921'::uuid,'5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'O4','เพาะพันธุ์ไม้ขาย',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('ca22a8c3-787f-5709-ad21-b1a22e0760b6'::uuid,'5ceea4fc-3163-5fc9-909c-750a6440cf9e'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('849378a9-d6e5-5625-9a8f-63bc726275e9'::uuid,'797feb8b-d26a-52aa-8b69-084776513497'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำถุงเพาะชำตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','NPS ถุงเพาะชำสะท้อน Loyalty ของ Dealer เป็นหลัก',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งเทปน้ำพุ่งตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'Dealer เทปน้ำมักขาย Bundle กับท่อ PE — ดูว่า USP เทปคือ ''ไม่อุดตัน'' หรือ ''ราคา''',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5f772599-94c9-5584-93e3-26efc7b985bb'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O1','อัตราไหลสม่ำเสมอ',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3e549698-3ae8-5959-a773-bdcd0cc09e27'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O2','ไม่อุดตันง่าย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4defa724-8f97-51b4-816f-9c1f8702dd10'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O3','ราคาและ Margin ดี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5f7d5202-2613-5e16-9c93-874dd668f1f5'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O4','ทนทาน ใช้ได้หลายฤดูกาล',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2ad437a2-0c2b-5a67-b710-44bb3b6054f9'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O5','ติดตั้งง่าย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2ab62056-c09d-59ec-8d51-876dcb482f7e'::uuid,'018d81b3-631e-541c-b2cf-430b3a44ff64'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ถ้า ''ไม่อุดตัน'' ได้ต่ำ แสดงว่าคุณภาพจริงไม่ตรง USP ที่อ้าง — ต้องแก้ก่อน',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('90c35369-7eff-54fb-b6e7-0c62605c28c1'::uuid,'ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'O1','ความสม่ำเสมอการไหล',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('cdfa0d31-3cd5-5195-ac69-539f1691e0f3'::uuid,'ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'O2','ความทนทาน',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('67b7a1f1-f484-5e26-8b92-bc50762d42aa'::uuid,'ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'O3','ราคา/Margin',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('85511f94-b5d2-52d7-9b0c-ab7c71a8fa84'::uuid,'ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'O4','ความต้านทานการอุดตัน',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('362a63eb-e9d2-51ca-b206-ae9b369351c7'::uuid,'ee1c1df9-4f93-5359-aa88-dc2b6ac01a02'::uuid,'O5','คำแนะนำการติดตั้ง',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Action แรกที่ต้องแก้ก่อนฤดูกาลถัดไป',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('daacbe8a-0a1d-5773-982c-1fbc2a7e44d7'::uuid,'412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'O1','ราคาแพงกว่าจีน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('fe8f179a-2b06-5015-8725-a6b7e5782822'::uuid,'412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'O2','อุดตันบ่อยเกินไป',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6798379a-f9c5-5db3-b692-457ab60c5df2'::uuid,'412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'O3','ขาดคำแนะนำการติดตั้ง',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('562ab082-f8ee-553b-83c9-bb489aec0eef'::uuid,'412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'O4','ขาด Stock ช่วง Peak Season',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e58d169c-a2f4-5696-bd29-6aef18fbfd64'::uuid,'412277c1-d5e1-59b2-8c7f-125599180034'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางใช้เทปน้ำพุ่งกับพืชอะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'วาง Seasonal Stock ให้ตรงกับช่วงปลูกพืชหลักในพื้นที่',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a0c6ce0d-d31e-511c-957e-6aca28619da3'::uuid,'77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'O1','ผักทั่วไป',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c56edd0b-aa47-5958-a3b2-9ea63dfd5118'::uuid,'77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'O2','สตรอว์เบอร์รี/แตงโม',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b3f8e05e-1504-57f9-bc68-2eb5666ce5a7'::uuid,'77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'O3','ข้าวโพด/อ้อย',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b52f94d7-ebc8-5a48-b3d5-9d76e3db1b7b'::uuid,'77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'O4','ไม้ผล',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('25f07e02-dbe3-516c-add5-8f8ea5b93967'::uuid,'77987f70-c70c-573e-a401-8fda61f511b2'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('fe4919f1-dedc-5ae8-9262-cd3546a5df1e'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำเทปน้ำพุ่งตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','NPS เทปน้ำ + ท่อ PE ควรสูงพร้อมกัน เพราะมักซื้อด้วยกัน',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'farmer'::public.respondent_type,1,'checkbox'::public.question_type,'ทำไมถึงเลือกใช้เทปน้ำพุ่งตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'เกษตรกรเน้น ''น้ำออกสม่ำเสมอ'' มากกว่าราคา — ยืนยัน USP ด้านคุณภาพ',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('834ae370-7d7b-5a0b-879c-dd56f2f391ba'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O1','น้ำออกสม่ำเสมอทุกหัว',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('472d83bd-cb82-502b-a234-1ed31b124d1c'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O2','ไม่อุดตันง่าย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('5411d60f-ff42-53f3-bd48-02156f584d72'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O3','ราคาเหมาะสม',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('70197d45-b69a-502e-b88f-d66e85660054'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O4','ทนทาน ใช้ได้หลายฤดู',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('d2d8e8ba-e323-5c00-bc87-0783932d064c'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O5','ร้านที่ซื้อประจำแนะนำ',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c2106992-adb2-5f56-8c26-14a166d45b86'::uuid,'ae89f38c-8791-53d2-845f-5a926e49b254'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'farmer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทปน้ำพุ่งที่ใช้อยู่ตอบโจทย์ระบบน้ำในแปลงไหม? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Performance จริงในแปลง สะท้อน USP ที่แท้จริงกว่าการประเมินในออฟฟิศ',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('41d35435-38c6-5701-9b5b-718e986b2e6a'::uuid,'8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'O1','น้ำออกสม่ำเสมอทุกจุด',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4883cea8-b04d-50fb-9306-971ec1e5ff82'::uuid,'8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'O2','ไม่อุดตันตลอดฤดูกาล',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b88afcf7-ea89-5077-8555-864e7234e918'::uuid,'8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'O3','ความทนทานต่อสภาพดิน',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a0e939f0-d8d9-5e2c-b1a9-a195cffd99df'::uuid,'8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'O4','ความคุ้มค่า',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e0f449c0-02a2-5d1b-b00f-dd27b8e54e86'::uuid,'8bf000d6-8c69-52e3-83f4-ebd87c88c233'::uuid,'O5','ง่ายต่อการติดตั้ง',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'farmer'::public.respondent_type,3,'single_choice'::public.question_type,'ปัญหาที่เคยเจอกับเทปน้ำพุ่ง (ยี่ห้อใดก็ได้) คืออะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'Pain Point เกษตรกร → เชื่อมกับการพัฒนา Technical Support / คู่มือการใช้งาน',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('18208a97-f0e0-5121-8683-01415becb212'::uuid,'d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'O1','อุดตันบ่อยจากตะกอน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('87b98a3a-f692-57e9-847f-cdfe056afd45'::uuid,'d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'O2','น้ำออกไม่สม่ำเสมอ',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('239de6fc-41a4-500f-8751-2de6ef57e8ac'::uuid,'d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'O3','แตกหักง่าย',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('413179da-97a1-52f4-925a-35cbc1e5c804'::uuid,'d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'O4','ราคาแพงเกินไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('770a7a5a-45ee-5090-9653-05160db80591'::uuid,'d26748c8-aa44-5181-9e00-4f5d4c7414ba'::uuid,'O5','ยังไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('9f563ae8-28f6-5c2d-a7d8-2719795a0298'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'farmer'::public.respondent_type,4,'single_choice'::public.question_type,'ใช้ร่วมกับท่อ PE ยี่ห้อไหน?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'โอกาส Cross-sell ท่อ PE + เทปน้ำพุ่ง แบบ Package เดียว',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('bee9c66b-7584-512c-94dc-f854cbc15335'::uuid,'9f563ae8-28f6-5c2d-a7d8-2719795a0298'::uuid,'O1','ตราต้นไม้ (เหมือนกัน)',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('c3733ed3-5393-5644-8cc6-b94290994505'::uuid,'9f563ae8-28f6-5c2d-a7d8-2719795a0298'::uuid,'O2','ยี่ห้ออื่น',2,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('88b71b43-c7dd-593a-b5e7-6fcadba34b8f'::uuid,'9f563ae8-28f6-5c2d-a7d8-2719795a0298'::uuid,'O3','ซื้อตามร้านใกล้บ้าน ไม่ได้เลือกยี่ห้อ',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('4342b32a-7c3a-52fa-badf-f261df4b6138'::uuid,'9f563ae8-28f6-5c2d-a7d8-2719795a0298'::uuid,'O4','ยังไม่มีระบบท่อประจำ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('370fb3a7-071e-514d-923a-1a643e39f8ad'::uuid,'f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6'::uuid,'farmer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำเทปน้ำพุ่งตราต้นไม้ให้เพื่อนเกษตรกร (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','โอกาส Referral Program',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'dealer'::public.respondent_type,1,'checkbox'::public.question_type,'เหตุผลหลักที่เลือกสั่งถุงเอนกประสงค์ตราต้นไม้ (เลือกได้ 2 ข้อ)',2,true,
NULL,NULL,NULL,NULL,NULL,'ถุงเอนกประสงค์เป็นสินค้า Commodity สูง — ถ้า Dealer เลือก ''คุณภาพ'' แสดงว่าเราสร้างความแตกต่างได้แล้ว',1)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('a60482c7-5b52-5970-b1f9-2f33f54d912e'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O1','ราคาเหมาะสม/ถูกกว่าคู่แข่ง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('0c07137c-e1df-52e9-b162-abde63d60e01'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O2','คุณภาพสม่ำเสมอ ไม่แตกง่าย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('48ad568d-de9e-5507-aebb-9d20d9921eef'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O3','มีหลายขนาด/หลายความหนา',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('957bdc7b-5f34-5c25-aab2-6f0ba2a05bac'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O4','Delivery ตรงเวลา',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2b6870e8-577a-58a9-8cb9-3e7370812ba5'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O5','บริการดี/ติดต่อง่าย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e18bacfa-ef93-57b0-ad11-102fddfa4b5f'::uuid,'732767e9-6de3-5aa9-9233-65f1f1a0a3db'::uuid,'O6','อื่นๆ',6,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'dealer'::public.respondent_type,2,'rating_grid'::public.question_type,'เทียบกับคู่แข่ง เราดีกว่าตรงไหน? (1–5)',NULL,true,
NULL,NULL,NULL,NULL,NULL,'สินค้า Commodity — ปัจจัยที่เราได้สูงกว่า 3 คือ Differentiation ที่แท้จริง',2)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('2d6435ef-438f-505e-aef9-732335e61fa1'::uuid,'13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'O1','คุณภาพ/ความแข็งแรง',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('43fa4ed8-c30c-525f-8ec9-1869d7fe062a'::uuid,'13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'O2','ราคา',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('3ae45bba-eff3-5495-b7a0-d29a963e92f4'::uuid,'13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'O3','ความหลากหลาย',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('25e4755a-6469-50d0-aaa1-828b2e6fa18e'::uuid,'13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'O4','Delivery',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('bd02d973-1a12-5ee9-9b67-e873453c32fc'::uuid,'13696112-d527-5c3d-a127-0f29e1deb455'::uuid,'O5','บริการหลังการขาย',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'dealer'::public.respondent_type,3,'single_choice'::public.question_type,'สิ่งที่อยากให้ปรับปรุงมากที่สุด',NULL,true,
NULL,NULL,NULL,NULL,NULL,'ข้อที่ถูกเลือกคือสัญญาณสำคัญ',3)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b787755d-12f7-5604-a6ab-1d63f5d41ecf'::uuid,'b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'O1','ราคาแพงกว่าจีน',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('fc2c1f19-9295-5a37-b7cc-ebebc39a49b9'::uuid,'b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'O2','ขาด Stock บ่อย',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('b18af99d-fc4c-513d-8215-54b3b1f75119'::uuid,'b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'O3','ขนาดที่ต้องการไม่มี',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('6bb8c02b-c008-5212-b2a9-a26228281607'::uuid,'b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'O4','คุณภาพไม่สม่ำเสมอ',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('05518b37-4c8b-52e7-904e-19cf4e2bc101'::uuid,'b1c58ae7-83b0-5b36-bac5-388d4f269297'::uuid,'O5','ไม่มีปัญหา',5,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'dealer'::public.respondent_type,4,'single_choice'::public.question_type,'ลูกค้าปลายทางส่วนใหญ่ใช้ถุงเอนกประสงค์ทำอะไร?',NULL,true,
NULL,NULL,NULL,NULL,NULL,'รู้ Use Case → วาง Seasonal Stock และออก Promotion ตรงเป้า',4)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('e5e9f51e-bc4c-5e70-858d-e781a62f5bef'::uuid,'21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'O1','บรรจุผลผลิตเกษตร',1,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('9ad0820e-8733-5fe6-b79b-52b043995bf1'::uuid,'21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'O2','ขยะ/สิ่งแวดล้อม',2,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('fd02823b-1824-5e73-8799-37e56d85f0a6'::uuid,'21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'O3','งานก่อสร้าง',3,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('022358b9-2957-5183-9949-dbcf9d3ace47'::uuid,'21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'O4','ร้านค้าทั่วไป',4,false)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_question_options(id,question_id,option_key,option_text,sort_order,is_other)
values ('be6381fd-71d5-5b18-a3eb-9b876da6c05c'::uuid,'21b76d44-a832-5b0b-b1cc-5a9309eac139'::uuid,'O5','อื่นๆ',5,true)
on conflict(question_id,option_key) do update set option_text=excluded.option_text,sort_order=excluded.sort_order,is_other=excluded.is_other;
insert into public.survey_questions(id,product_id,respondent_type,question_no,question_type,prompt,max_selections,required,scale_min,scale_max,scale_min_label,scale_mid_label,scale_max_label,analysis_hint,sort_order)
values ('6a0635c2-cd54-5f53-a0f4-7a2344886180'::uuid,'e68dd0f2-67bb-5377-b603-3aa115d433cc'::uuid,'dealer'::public.respondent_type,5,'scale'::public.question_type,'โอกาสที่จะแนะนำถุงเอนกประสงค์ตราต้นไม้ให้ร้านอื่น (1–5)',NULL,true,
1,5,'ไม่แนะนำแน่นอน','พอได้','แนะนำแน่นอน','ถ้าคะแนนสูง Service ของเราอาจเป็นจุดแข็งจริง',5)
on conflict(product_id,respondent_type,question_no) do update set question_type=excluded.question_type,prompt=excluded.prompt,max_selections=excluded.max_selections,
required=excluded.required,scale_min=excluded.scale_min,scale_max=excluded.scale_max,scale_min_label=excluded.scale_min_label,scale_mid_label=excluded.scale_mid_label,
scale_max_label=excluded.scale_max_label,analysis_hint=excluded.analysis_hint,sort_order=excluded.sort_order;
commit;
