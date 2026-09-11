-- Seed sales people and all customer rows from the uploaded Excel file.
-- Duplicate Client_ID values are intentionally preserved as separate source rows.
begin;
insert into public.sales_people(id,display_name) values ('d514d255-8b82-5710-971c-847c445bdc43'::uuid,'คุณกิตติพงษ์') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,'คุณจักรพันธ์') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,'คุณฐาปนี') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,'คุณพิชัย') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,'คุณวิรุฬห์') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,'คุณอรญา') on conflict(display_name) do update set is_active=true;
insert into public.sales_people(id,display_name) values ('c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,'บริษัท') on conflict(display_name) do update set is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5cf08e70-ba4a-5b63-8f0c-563443be2d20'::uuid,2,'ก099','กล้าพันธุ์ดี','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('86e19053-d7b9-531c-bc7e-769c0e891612'::uuid,3,'ก032','กิตพานิช','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c1e34bc2-d0aa-5902-9500-55a26d55bbc1'::uuid,4,'ก017','กิมเฮง','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('50130a46-8a28-5790-8fa4-c68a0a928c16'::uuid,5,'ก021','เกษตรภัณฑ์(สุรินทร์) /ก021','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ed61e4e0-1449-5fd7-ab4b-a537751a08f7'::uuid,6,'ก031','เกียหลี','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9bd1ab3-f383-5229-b67e-cb053fa3cf72'::uuid,7,'ค002','คลีนิคเกษตร','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1b8bdfe5-71ab-54b1-9cfd-74c490f54427'::uuid,8,'ค056','เค.เค ปาล์มเอ็นเตอร์ไพรส์ (อุดรธานี) /ค056','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('beef031e-b152-5b6f-ad70-30d3681fcc0d'::uuid,9,'จ083','จอมพระพันธุ์ไม้','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('932e3ac3-5c9c-5636-8570-114230e4fd15'::uuid,10,'จ002','เจริญกิจเกษตรภัณฑ์','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f3fec388-bddc-56d2-892e-c7f976d5fe26'::uuid,11,'จ016','แจใจ ส่งเสริมการเกษตร','กาฬสินธุ์','กาฬสินธุ์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e1a0b5ca-3284-571a-b5fa-989b4e5ceda9'::uuid,12,'ช005','ชุมแพการเกษตร','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('28e4866b-1094-52ef-906f-321d6bdd6424'::uuid,13,'ช012','โชคไพบูลย์','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c399b62d-0309-5e8b-ba27-5d2681ac4217'::uuid,14,'ด035','ดียิ่ง อินฟินิท จำกัด-(ขอนแก่น) /ด035','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8e7adc15-cae2-51b7-8851-4d9be7fc56c6'::uuid,15,'ต0092','ตั้งเส่งฮงการเกษตร','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bc267553-f224-5ef6-93c8-4bf61cbc7b73'::uuid,16,'ท026','ท.เจริญกิจเกษตรภัณฑ์','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2c45227f-798b-59d2-90be-ae6d4d4e2b1d'::uuid,17,'ท007','ท้วนการเกษตร','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bf731d0b-ead2-52ee-8109-c1511765ab15'::uuid,18,'ท044','ทวีทรัพย์','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ebd5ed33-d8ec-538a-a199-f52d80c27e91'::uuid,19,'ท104','ทวีผล คอร์ปอเรชั่น จำกัด','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e75aafef-a913-585a-9570-a2bc7b2af6b4'::uuid,20,'ท109','ทีพีเอส คอนแทรคเตอร์ จำกัด(สนง.ใหญ่) /ท109',NULL,NULL,'6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f22b4c6f-e5e7-56b5-a5ba-4584cd8c6c6d'::uuid,21,'ท002','ไท้เชียงล้ง','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e01b9315-4412-51bd-b079-b0055d81109f'::uuid,22,'ท025','ไทยการค้า','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f01bf13e-6403-57a5-93ca-0a41761d2215'::uuid,23,'ท1012','ไทยถาวร','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3c94ce88-751c-5e00-a075-68386d59b3fe'::uuid,24,'ท001','ไทยสามัคคี','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('000b0171-0400-5eeb-9606-202a5d7589ce'::uuid,25,'ธ037','ธนโชติการเกษตร','กาฬสินธุ์','กาฬสินธุ์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('75972431-090d-5bab-aca6-da510cd137fe'::uuid,26,'ธ002','ธนาพันธุ์(นครพนม)','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('97ff821f-5e9c-511c-9a84-35a526b0e82b'::uuid,27,'น012','น.เกษตร ครบุรี','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ed7048aa-84c3-55da-a424-395c708598af'::uuid,28,'บ008','บรรลือพาณิชย์','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ef309865-3650-5081-8f5a-729b0c33d776'::uuid,29,'บ020','บุญเกษตรพอเพียง','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('60e9525d-a38a-5ed2-9300-e8b943a7186f'::uuid,30,'บ070','บุญมีโฮลเซล จำกัด','กาฬสินธุ์','กาฬสินธุ์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fae3148e-27f3-5278-9f57-271010563e9a'::uuid,31,'บ071','เบสท์การเกษตรและอุปกรณ์','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('24e13e19-5d2d-5272-8a5a-24a17ca4061a'::uuid,32,'ป003','ป.สถิตย์เคหะการ','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eacb5aab-f392-5b73-8e4f-0e1f218a57c4'::uuid,33,'พ034','พันธ์ทวี คอร์ปอเรชั่น','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5573da3f-8f04-5889-a397-5f6d9a4c9094'::uuid,34,'พ016','พี เอส วาย การเกษตร(ขอนแก่น) /พ016','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1239bafe-4bf5-521e-8f08-10ae33aa5866'::uuid,35,'พ029','พูนผล','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0553b94a-0f7d-5075-85ba-2b9ddeb2f5c9'::uuid,36,'พ001','เพื่อนเกษตร','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f6dcd10c-d4ab-5b4a-a423-47bdca97f44c'::uuid,37,'ฟ009','ฟาร์มเห็ดวาสนา(หนองบัวลำภู) /ฟ009','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('83a1b2a1-770d-574e-9f71-08f2b590ed17'::uuid,38,'ม012','มารุ่งเรือง(สุรินทร์) /ม012','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0d313ecf-ba92-5695-8d07-39019ea3f0ea'::uuid,39,'ส0252','ร่มโพธิ์การเกษตร จำกัด','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('89e749ef-2b78-55c3-bd43-1097154db446'::uuid,40,'ร037','รวมกิจอะไหล่','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a6cb2590-4505-5610-a766-2c765a7b0e42'::uuid,41,'ร003','รวมเกษตร(สุรินทร์) /ร003','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('23390d0c-62ec-50b1-9f21-232155403162'::uuid,42,'ร005','รวมเกษตร(หนองคาย) /ร005','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b2d16b1-40ed-5d1c-a56f-7b6ba1ea645a'::uuid,43,'ร048','ร้อยเอ็ดบิ๊คเทรดดิ้ง','ร้อยเอ็ด','ร้อยเอ็ด','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f31ff000-8307-5add-ab5d-a66a05dfec15'::uuid,44,'ร042','ริริน จำกัด','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0186e730-5896-5640-8462-453ebbcdeaca'::uuid,45,'ว0451','วุฒิผ่องพืชผล กรุ๊ป(ชัยภูมิ) /ว0451','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('88fedbdf-16cc-534d-b208-407149755026'::uuid,46,'ส016','สันติสุขโภคภัณฑ์','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('88cf4e47-74e2-5a66-a86b-fb2ead4ed964'::uuid,47,'ส058','สินเกษตร','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b3f7379e-b193-5a12-9774-d5f3397f11f5'::uuid,48,'ส191','แสงมณี รักษ์เกษตร จำกัด','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f84ab793-ed61-5be9-b95f-ea6dbaad6358'::uuid,49,'ส159','แสงศิริเคมีเกษตร','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a5a40077-c8a0-5fb1-b2df-d71f7a55476a'::uuid,50,'ห004','เหมียว','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f237948a-3cec-5c31-8f44-36f46bfffba6'::uuid,51,'อ056','อึ้งชุนฮะ(1994) จำกัด','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('34cfa59c-4194-5ad8-8075-fdaf2acd1c4f'::uuid,52,'อ0982','เอ็น อาร์ เทรดดิ้ง 2018','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cdb10438-2b0d-572f-a1b8-4bf8ef0c8c02'::uuid,53,'ฮ005','ฮะฮง','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ab9d3286-3b42-5aaf-be8c-fbbd72fe4351'::uuid,54,'ห028','679 ดีเวลลอปเม้นท์-(สระบุรี) /ห028','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('97c16c00-c7e8-5314-a9d3-fe3dfc454bc0'::uuid,55,'ก111','เกษตรบ้านนา','นครนายก','นครนายก','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1d1e0d08-4055-50cf-bb9a-f393fad7a508'::uuid,56,'ค054','คิววัสดุ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4d8493af-0e61-5fa0-a298-2396926c9fc1'::uuid,57,'ก1142','แสงทิพย์การค้า 888 จำกัด(สมุทรสาคร) /ก1142','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2094eaf5-3076-5a32-b95c-4736d43f5db9'::uuid,58,'ค0401','โคกสูงพัฒนา จำกัด','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aec3ee78-0b93-59b8-8501-997c78cd382b'::uuid,59,'จ058','จันทิมา ธวัชพันธุ์','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb27ae5a-266b-5f87-b8a0-3ec1a4605609'::uuid,60,'จ085','เจด็จ ปาลวัฒน์-(สระบุรี) /จ085','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('01a66c06-9817-5291-9ad9-5e3672928e84'::uuid,61,'จ033','เจริญชัยอะหลั่ย','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('72477261-068d-503a-a505-1b9f30114b5e'::uuid,62,'ย0121','เจ้าสัวเกษตร จำกัด','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff227849-f456-5543-b61d-5bc23fed77eb'::uuid,63,'จ037','เจี่ยเทียมเส็ง','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ebb5166a-e20f-5006-99bc-d1294be1765c'::uuid,64,'ช013','ชัยชนะเกษตร(ลพบุรี) /ช013','ลพบุรี','ลพบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d729b04f-3b3b-553b-8996-d858d3831f02'::uuid,65,'ด015','ดำรงค์เกียรติ(1994)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c36cb7dd-fd32-5f60-8537-832464a4e5fb'::uuid,66,'ด025','เด่นใหญ่ โกลเบิล ไลน์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ed1f037f-33de-51e4-8c66-4d58e170c062'::uuid,67,'ต021','ตั้งธนไพศาล จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ec704153-0688-591a-898f-b2b223a24489'::uuid,68,'ท043','ทรงชัยการค้า','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('96e9c7ba-a121-5a88-a2fb-6a4d89bd57f4'::uuid,69,'ท057','ทีพีเค โกลเบิล ซัพพลายส์ จำกัด','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c7f37655-04bc-51b0-90db-cdb09287a738'::uuid,70,'ท1124','ไทยเจริญสุกร จำกัด','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a5778130-1a4c-520d-b476-36402c95d98e'::uuid,71,'ท017','ไทยสมานมิตร','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1510aa0d-4889-51ac-aee4-574b7e719113'::uuid,72,'บ0452','ธนะสาร เทรดดิ้ง(2015) จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b01bc924-59ec-5ad4-9f68-ffd7dc305839'::uuid,73,'บ0452','ธนะสาร เทรดดิ้ง(2015) จำกัด /บ0452','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a464825e-566b-5c8e-af17-37ad306c6a9e'::uuid,74,'ธ0302','ธนายุทธแมชชีนเทค /ธ0302','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('03c85e85-9ebb-5e4f-be85-dcbf491daefc'::uuid,75,'บ050','บ้านไร่การเกษตร','เลย','เลย','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c8a137c-4edd-59a7-a0b7-9b50bf88a3be'::uuid,76,'บ038','บุญชัย รับเบอร์ /บ038','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('80f1d551-92d5-5b2a-833b-ad8793353fc5'::uuid,77,'ป011','ประเสริฐวัสดุภัณฑ์สระแก้ว /ป011','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a750adb3-9def-57f1-9f07-f42048ccb833'::uuid,78,'พ030','พรปรีชาการเกษตร','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f1f300b-2270-5a05-99e1-ee3af9ebe237'::uuid,79,'พ0702','พี เจ แอนด์ ควอลิตี้ กรุ๊ป จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8fba4c97-4f8a-59e7-b409-419185646330'::uuid,80,'พ0612','พี.เอส.เบสท์ โปรดักส์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('941d9a7b-828a-5cd5-8f95-1876e67ac36e'::uuid,81,'พ0632','พีอาร์โอ ซัพพลาย (2017)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('01e3f9ef-571d-509a-aa8b-18c9c3189710'::uuid,82,'พ002','เพราพิลาศ จำกัด','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1f8df20-d54e-506e-b417-8b112ad1a895'::uuid,83,'พ0632','แพ็คกิ้ง สตอรี่','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('29baa482-b97d-5144-9abc-f537cb4ada91'::uuid,84,'ภ024','ภูดิส 99 ซัพพลาย','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('67788a13-8f33-5ccc-81a2-e4e49ca531e7'::uuid,85,'ภ0112','ภูตะวันวัสดุก่อสร้าง(สนง.ใหญ่)','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ae460b02-a62f-5edf-b255-10105a2334a3'::uuid,86,'ล009','ลุงเที้ยม','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9117920e-06be-55d6-ae98-26060854b04c'::uuid,87,'ธ0253','ฟาร์มก่อสุข จำกัด','พิษณุโลก','พิษณุโลก','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('09ace9db-ee20-5086-b626-d38111816f4a'::uuid,88,'ว051','วินค้าไม้ศาลาแดง','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bb0f8841-552b-5ef7-a6b6-21bc96da7f9f'::uuid,89,'ว0372','ไวท์ปาร์ตี้ เทรดดิ้ง จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('337acca0-37e3-5756-8940-3df5fd621fe8'::uuid,90,'ศ034','ศิรภิชฌาย์ สุทธิเมธีวงศ์(อินดี้)','กทม.','กรุงเทพมหานคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb45a794-72e9-5ed6-9b73-b1ef7b2934bc'::uuid,91,'ศ0402','ศิริบุญอินเตอร์พลาส จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1cb1c36-e984-5724-b30f-cca0832213f2'::uuid,92,'ส051','สมบัติโอสถการเกษตร จำกัด','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6b22061b-5e49-51f8-baa5-b8322636dfa8'::uuid,93,'อ083','อำนวยการเกษตร','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4ab73f7e-aecc-5d27-b712-c066cecd9e5d'::uuid,94,'อ192','เอกพร โตสวน','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b2150a2-bda2-5122-bb6b-8c9e5be6a129'::uuid,95,'อ021','เอสโบ้โฮมเวิลด์(สนง.ใหญ่)','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f209092c-a261-5d6c-85fc-8f79545fe785'::uuid,96,'อ121','เอสพี.เจริญทรัพย์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('39c9fd99-1c5b-5be1-940d-750e695ea71b'::uuid,97,'อ0641','เอสเอพี โฮม เซนเตอร์','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b106567e-35b3-541c-a0e3-65425bf2f8d1'::uuid,98,'ค0145','คงสวัสดิ์ ซัพพลาย จำกัด','กทม.','กรุงเทพมหานคร','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3626d959-cecd-5724-b1db-18d2a3357134'::uuid,99,'ค048','คิว โอ ยู เทรดดิ้ง จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ee36428f-5bc9-586d-a291-54b3da0b6158'::uuid,100,'ค0182','เค.เจ.ที เทรดดิ้ง จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a42a686b-50f2-5939-99ba-f68b22d1704f'::uuid,101,'จ015','จิตรศิลป์โสภณ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('21b2998c-6ad2-52f5-a65e-d07b148a69a6'::uuid,102,'จ068','จิราภาส พงษ์สัมฤทธิ์ผล(กทม.) /จ068','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1f80972-4e56-5ede-84c1-dbd71a756181'::uuid,103,'จ0412','เจ.เค.ซัพพลาย แอนด์ แมชชีนเนอรี่ จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('78525dd3-aff3-5b1e-bce9-b238cd803d79'::uuid,104,'จ0522','เจริญกิจรุ่งเรืองฮาร์ดแวร์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c333718-1ef8-5a81-854a-9c6af4ae12d0'::uuid,105,'ฉ002','เฉลิมชัยฮาร์ดแวร์ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('99191e57-7bc8-548a-8bd4-227990e86b89'::uuid,106,'ด0081','ดี ไอ โอ กรีนคลีนนิ่ง','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ecdab5a5-3079-5dfb-8554-23bcb5137591'::uuid,107,'ด0091','ทรัพย์มั่งคั่ง6666','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7bf3587d-d601-5951-aae7-741cb6e3d0b9'::uuid,108,'ท074','ทิพาพร(กุ้ง)','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5adcb073-8e7a-588b-9acd-2ff3245705de'::uuid,109,'ท015','ทีเอชเค มาร์เก็ตติ้ง(นนทบุรี) /ท015','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('88387e67-1ce8-50c0-9c2a-fcf19a0684ad'::uuid,110,'ท062','เทคอิท จำกัด(บิวเดอร์)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d8042dde-036c-51a8-9fef-0e2fe03b39dc'::uuid,111,'บ023','บ้านเกษตร (นนทบุรี)','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff5e4fc3-ba30-5f39-b26e-fd23c24f1126'::uuid,112,'บ054','บ้านป่าป๊า หม่ามี๊','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('643cde15-ef74-5d8a-a97e-88d7bd589bac'::uuid,113,'บ004','บิวเดอร์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ddce4063-4b78-5e65-9231-5c538ed16f1c'::uuid,114,'บ061','บีพีวาย คอนสตรัคชั่น แมททีเรียล จำกัด /บ061','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9cb922f-1872-5cc6-b51e-775128146ec4'::uuid,115,'บ014','บียอนด์เซฟ','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb5c984e-fea9-5654-a9c7-e07df87cc230'::uuid,116,'ป0603','ออลไรส์ คอมเมิร์ซ จำกัด','กทม.','กรุงเทพมหานคร','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4c587f4d-3a2f-503e-8bd0-a92a150abbd0'::uuid,117,'พ0122','พงษ์เชียงทอง พลาสติกเน็ทติ้ง จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('56e66d7b-a964-5673-89f7-46b98f9c0562'::uuid,118,'ม058','มันตรา','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('94d01701-7066-5d10-bb3e-c28ad207af3b'::uuid,119,'ย002','ยูเนี่ยน พรีซิชั่น เอ็นจิเนียริ่ง จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('713720fa-7144-578d-9222-06eb20768250'::uuid,120,'ร066','รวยเจริญดี เทรดดิ้ง-กรุงเทพฯ /ร066','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2f770178-29ac-5681-854a-e6b15af265da'::uuid,121,'ร034','รุ่งเรืองเสาเข็ม(นาย พิศาล เล้าอรุณ) /ร034','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9ee41fda-c7b3-5ec1-b30b-b16a6a1e3798'::uuid,122,'ล019','ลิ้มเจริญ','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('13fe39e2-9d44-56f6-a108-a95c5e5e912b'::uuid,123,'ล004','ลิ้มเจริญ เทรดดิ้ง','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ba8bfa43-4e77-5268-8053-b81730147449'::uuid,124,'ว031','วงแหวน ก.ม.10 ค้าไม้ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4e7b94a1-1eb6-5e86-ac14-835c8ba1b26e'::uuid,125,'ว017','วี อาร์ วอเตอร์ ซีสเต็มส์ จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b6be2426-2f95-5536-91c1-fca5ccdcac7b'::uuid,126,'ว028','เวิลด์ เบสท์ เอนจิเนียริ่ง จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('19b7e7c3-de4f-533b-92a5-5434bdb1ba53'::uuid,127,'ศ042','ศศกรการเกษตร','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('470d440d-ac40-5834-8879-d692f0449536'::uuid,128,'ศ041','ศศิภัทร ตาข่าย จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('87681f49-52ec-5988-96c1-f5e173d9764e'::uuid,129,'ส154','สนธยา น่วมใย','พระนครศรีอยุธยา','พระนครศรีอยุธยา','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3e97421d-a772-5f37-a2f2-9679d631fa4f'::uuid,130,'ห005','หฤทัย กระถาง','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e028da6a-bdc6-5a2b-a13c-aee150c17cdc'::uuid,131,'อ0451','อ.เกษมสันต์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6d8c90b1-8c10-5b1f-ba6c-922b10084f03'::uuid,132,'อ0451','อ.เกษมสันต์ จำกัด(กทม) /อ0451','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('caeb5c57-ff85-5fcc-9e60-66703c8e0f74'::uuid,133,'อ133','อาร์.พี.วาย.เซ็นเตอร์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5116fbad-e99f-57c2-81fa-331fdac8f6ac'::uuid,134,'อ195','อีสท์ เวสท์ ซีด จำกัด','นนทบุรี','นนทบุรี','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c40ef7fb-d80c-5fd7-a9d2-d45a243a9cb8'::uuid,135,'อ198','เอ็นซี เซอร์วิสแอนด์เซลส์ จำกัด','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1821d102-3470-5974-b8f7-f94ecc76a9e9'::uuid,136,'อ0523','เอวี อะกรีเทค จำกัด(ปทุมธานี) /อ0521','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('115262f9-6f2f-5609-8e72-6713f43c5723'::uuid,137,'อ194','เอสเอ็ม ซัพพลาย-สมุทรสาคร /อ194','สมุทรสาคร','สมุทรสาคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b6c8e9c8-6ae0-50b1-9d86-d9d49f920456'::uuid,138,'ฮ015','ไฮโฮมเวิลด์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b448c27c-b95a-5785-92e7-0522fc238b9e'::uuid,139,'ก024','ก.เกษตรกิจ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('85cae5f2-7f44-5958-aae2-b8b28f7d0f49'::uuid,140,'ก003','ก.พานิช','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('be6550aa-9450-5bf4-84e0-1d9e42137f79'::uuid,141,'ก093','กรีนนี่','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d65858d5-e49b-551b-b4c6-b802e75b595e'::uuid,142,'ก0223','กิจอาคม','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0e72f2f6-90bb-56f6-97d7-1cb1d2b5279e'::uuid,143,'ก0223','กิจอาคม(ลำพูน) /ก0223','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f8c7b2d5-9b5b-5a94-851e-86999da0bd34'::uuid,144,'ก0842','เกษตรยนต์(น่าน) /ก084','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('501787e2-ec82-5251-9360-46b8edcb7303'::uuid,145,'ก112','แกลสซี่แลนด์ จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f8b7a6ab-0355-5af5-80fb-0469711e3c8c'::uuid,146,'ก006','โกศัยการเกษตร','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1bfe5779-7f4c-5de2-8e97-6b0e7e01427a'::uuid,147,'ค047','คอนเซอร์เทค จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2e1d5f92-1a85-5e93-b031-7ed150e3ef59'::uuid,148,'จ003','จงเจริญวัสดุภัณฑ์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('656f530a-8b75-5789-beeb-ebce918fcaca'::uuid,149,'จ021','จารุณีการเกษตร','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e1e93428-a4db-5805-bc30-a57a89e93dd3'::uuid,150,'จ025','จิวไถ่อัง','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2921a7a4-6150-5199-a563-cbe3169887bc'::uuid,151,'จ053','เจ็กไข่ -เลย /จ053','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4e29ddbf-031e-5470-ad45-ef2d44683ebc'::uuid,152,'จ0382','เจริญพานิช กรุ๊ป จำกัด','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('05f87cec-5271-59fb-ba4a-95975d16d3ee'::uuid,153,'จ066','เจริญสุข(เชียงใหม่) /จ066','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('65d040a2-90cb-5b97-862b-318c5aa93164'::uuid,154,'จ0541','เจริญสุขพาณิชย์ เชียงใหม่ (2011) จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7149dac3-e58f-576b-8819-1a0c0c329f4e'::uuid,155,'ช009','ชัยชนะการเกษตร(กำแพงเพชร) /ช009','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3cf33c87-399d-5524-862b-13f15337c421'::uuid,156,'ช004','ชัยเฮงจั่น','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('684dcbc5-01ab-511b-850e-b6c38dbee805'::uuid,157,'ช016','โชควัฒนาการเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6a3013fc-c6bb-51d4-b4fa-8b2025f8aa3f'::uuid,158,'ซ002','ซินฮั้ว','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fce20da7-8a3e-5a9a-9da8-5afd6cbc52d8'::uuid,159,'ด005','ดวงทวียนต์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c8c95f96-873f-5d02-9e24-2e79d4e67af6'::uuid,160,'ด006','แดนทองพาณิชย์','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('303e2257-d65f-5e30-bf42-9d4c17ca92b4'::uuid,161,'ต010','ต้นไม้','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('59790b03-34d8-5495-b465-21ea29169f6a'::uuid,162,'ต017','ติยะจักรกล','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c46867e5-248f-5478-9a2b-1cdb871efe7c'::uuid,163,'ท085','ท่าข้าวทองดีพืชผล','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b381127-5cde-5f11-b7e0-b37166290359'::uuid,164,'ท090','ทิพย์เสถียรคลีนิคการเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('331f04e5-d506-5f73-9396-41ff9956b216'::uuid,165,'ท111','ไทยกันเอง','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b2ca31d5-3f45-51e6-9283-b87d762a948b'::uuid,166,'ธ017','ธนพร','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('783cff49-87a1-55f7-8dcb-cd2fd2f64d07'::uuid,167,'ธ013','ธนาผล(กำแพงเพชร)','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('66861eff-d0a7-5827-9233-9ea029722fb6'::uuid,168,'ธ031','ธาราตะวัน','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6e37f0b7-1059-5d42-aa44-aaaf31a19540'::uuid,169,'น015','น้ำโท้งกิจเกษตร','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eca1c062-7f6e-5132-a8a0-bcc2fd0a8a40'::uuid,170,'บ013','บ้วนเส็งเฮง','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('21e6e70d-e95f-5d81-8692-bb4f94ca6b80'::uuid,171,'บ0632','บ้านสวนครูเก่ง','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f17d6c16-83e3-53e3-bbd2-4de208376d7a'::uuid,172,'บ033','บ้านสวนคำแสน','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1cccb87-dd4a-50f6-9ac3-5642e8ddb312'::uuid,173,'ป030','ป.เกษตรภัณฑ์ (พิษณุโลก) /ป030','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9a4bc98-c10b-5f9c-9ed0-a3374c44dcc7'::uuid,174,'ป015','ป.ชัยยนต์(เชียงใหม่) /ป015','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('75ce4825-8cc5-5c4f-94ee-31894965057e'::uuid,175,'ป061','ปังแป๊ะเฮง','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('253de6f4-9181-5f79-830a-dd4f896d0cdb'::uuid,176,'พ047','พ.การค้า','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5fe28327-6ad9-5651-9304-77d5a5cd7f38'::uuid,177,'พ048','พงษ์เต็ง','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1ed1c66e-921d-5625-818e-2d9e8a5d66ac'::uuid,178,'พ005','พงษ์พลาสติกเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a0084f7f-811c-515c-9692-c133d545c752'::uuid,179,'พ096','พรรณทิพย์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fa26a152-3dec-5d9b-aafb-6883769430d9'::uuid,180,'พ009','พะเยาเคมีภัณฑ์','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('248a28d2-d517-5ae4-ad6c-7630422011ec'::uuid,181,'พ033','พิชัยการเกษตร','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e6d1174b-888a-59af-9396-cf057d6c72ca'::uuid,182,'พ110','พิษณุโลกระบบน้ำเกษตร(2019)จำกัด','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('35a2f50f-7df4-5f5e-a569-d94cb0d0c4aa'::uuid,183,'พ022','พิสิษฐ์ภัณฑ์เชียงราย จำกัด','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('114ed2f8-1050-5fca-a8a2-6ea3d30e8dbd'::uuid,184,'ภ013','ภูคาคชรัตน์(น่าน) /ภ013','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('104664ea-9f30-528c-8d5d-71099fb24000'::uuid,185,'ม014','มิตรเกษตร(ฝาง)','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('78c3781d-b3a0-535b-9e95-7406d82b3882'::uuid,186,'ม026','มิตรเกษตร-เจ๊ต่อ(แม่ข่า)-(เชียงใหม่) /ม026','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('95f05963-640e-5af8-b1ea-72877170e441'::uuid,187,'ม042','มิตรภาพการค้า','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff83bf5d-6652-5f8f-a5a6-13b2522fe8f2'::uuid,188,'ม0202','แม่โจ้ออร์แกนิค','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('33a7b936-4ace-51d5-8fa1-66d8197588e2'::uuid,189,'ย018','ยิ่งการเกษตร','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f0e3a6e1-f4e3-526d-b004-a1eb7ad4f2f2'::uuid,190,'ย022','ยินดี','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dcb0dad6-530a-5a33-8fee-839ed307a907'::uuid,191,'ร004','รวมสินชื่นชอบการเกษตร','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a0a4456a-fb2b-5a92-9ac7-a46002559811'::uuid,192,'ร001','ราชาอาหารสัตว์และเกษตร(เลย) /ร001','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('130bb5e9-f2a7-5075-a024-6718a5b9eabd'::uuid,193,'ร0212','เรดาร์ โฮมชอป จำกัด(เชียงใหม่) /ร0212','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('daa9a9fa-2192-5dfe-9924-e562ce5ea3b6'::uuid,194,'ร0262','เรืองพร','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('52be5e97-9bd5-5ee2-9b21-8ecf8eb20adc'::uuid,195,'ร0492','เรืองพรวัสดุ','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('acc6e0f2-12a6-53b1-beab-927050744238'::uuid,196,'ล008','ลิ้มซำฮวด','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c147549e-53b9-559a-a9ad-f2696b5df43d'::uuid,197,'ล011','ลิ้มศักดากุลเคมีเกษตร จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('72dc3e2a-e7ff-5abe-a0a9-dae98c1a6a18'::uuid,198,'ว003','วรพลจอมทอง','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bff49ccc-e2f6-5d47-8754-f9bbc9c8953f'::uuid,199,'ว032','วัฒนาการเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('de22c906-6472-549f-96f9-478e2d93dbba'::uuid,200,'ว011','วาวีการเกษตร','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('57bc6d57-bccb-5156-9cb6-8609b551753d'::uuid,201,'ว023','เวียงสาวัสดุภัณฑ์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b555d226-86bb-58b3-859c-27ebe90ba6b1'::uuid,202,'ศ011','ศรีสวรรค์ 2','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('84c2b0ed-4acc-524f-983e-021a9aa4c5e4'::uuid,203,'ศ007','ศักดิ์การเกษตร(พะเยา) /ศ007','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('19257bdb-c695-5f55-954d-28d80c714aee'::uuid,204,'ศ016','ศักดิ์เกษตร(พิษณุโลก) /ศ016','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1005574a-a15b-5c26-a7f9-81d0361726b5'::uuid,205,'ส026','ส.พืชผลเจริญการเกษตร','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d3fdfc53-8445-5d7c-80e9-cb89e34a4e69'::uuid,206,'ส008','ส.รุ่งเรือง(น่าน) /ส008','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eff582d6-c278-548e-b629-abcfeee9d4b3'::uuid,207,'ส1772','สิทธิโชคการเกษตร','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('13e7709c-abdb-51a8-ad43-73c3592ff5f9'::uuid,208,'ส096','สุเกียว (สำนักงานใหญ่)','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('db64ac27-fdaa-5c89-a944-57770aa588b7'::uuid,209,'ส046','สุวรรณภัณฑ์','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('99d0ed01-653d-5370-800f-51d89d02df91'::uuid,210,'ส0693','เสรีภู่พิสิฐ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7bd4727e-c39c-5a16-8f4f-057f7c04da64'::uuid,211,'ส057','แสงสุรีย์การเกษตร(เชียงราย) /ส057','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a7aadfbf-ea16-59ce-8fb0-20623f028ce1'::uuid,212,'ห022','หลู่วาณิชย์เคมีภัณฑ์','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c3041da9-f0a1-530d-a557-cde8f9f51f28'::uuid,213,'อ017','อดุลย์ค้าวัสดุ','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('17c61dae-5f36-57bc-8c92-8f08a3ae47d3'::uuid,214,'อ132','อังการเกษตร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5f7cc181-4006-511f-81a2-8e04920df10d'::uuid,215,'อ019','อาทิตย์เคหะภัณฑ์','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c5d9d3d-6bcd-5672-b0eb-ce336e78ecff'::uuid,216,'อ1072','อึ้ง เป๋ง เฮง การเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d0512203-70f8-51de-b358-75872d91d17c'::uuid,217,'อ190','เอส ที เซ็นเตอร์ กรุ๊ป','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6adbf7d9-de6e-5608-9505-0cd32f2fe354'::uuid,218,'ฮ007','เฮงอะหลั่ย','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7f4456a0-0ed6-5dad-a393-32f90779a517'::uuid,219,'ก039','กระบุรีเกษตรภัณฑ์','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fd79053b-e3dd-5326-9608-a29c62f9b7dd'::uuid,220,'ก091','กัญชิต จำกัด','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dc260223-fe4b-56e6-a4be-1d25e446abaf'::uuid,221,'ก042','ก้าวหน้าซัพพลาย','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7d7213f2-2a59-54b2-8fba-e148a67979f0'::uuid,222,'ค055','คุ้นการเกษตร','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1fa52cf8-fc12-528b-b491-864105dd5075'::uuid,223,'ค004','โค้วเกษตร','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('56d4a470-7d2f-5f16-894b-cbfcce813f11'::uuid,224,'จ043','จรัสศรี','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('01362cf8-d684-583c-b440-83b5e0fda606'::uuid,225,'จ061','จิบล้งโลหะภัณฑ์(ปัตตานี) /จ061','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8270be16-121e-5d1a-b0cb-5b9ffc3a6556'::uuid,226,'จ076','เจเค ภูเก็ต พร็อพเพอร์ตี้ จำกัด-สำนักงานใหญ่ /จ076','ภูเก็ต','ภูเก็ต','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('64022953-8557-5494-8b0b-71a6ddddb273'::uuid,227,'จ017','เจ็งบุ้งฮวด','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f3ac6595-e3b8-5b38-a295-b9b6fa969edf'::uuid,228,'จ018','เจริญการช่าง','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d74a566f-5e53-5800-b0d2-98eafbbcdf94'::uuid,229,'จ006','เจริญพืชผล','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('599740f7-7edf-5c65-809b-892fab60716a'::uuid,230,'ช032','ชัยประเสริฐ','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d5f8bde-7615-5e27-ad90-2350e0ff7f8a'::uuid,231,'ช041','ช่างน้ำ','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c5103d89-ce83-5814-a87d-d4e29d86c6f2'::uuid,232,'ช014','โชคชัยพานิช','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0b55680c-6a39-5264-b6ea-5cba9d93c6ca'::uuid,233,'ซ0075','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00002(พังงา) /ซ0073','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('49bdc252-dc7a-5ffe-a6dc-47aa127c39e3'::uuid,234,'ซ009','เซี่ยงฮวด','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d13a8a89-6165-5cb5-a9d8-5e6e29a2d1c5'::uuid,235,'ด004','แดงเคมีเกษตร','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('11ebd984-fcfc-532a-9084-30b21d3d5f1a'::uuid,236,'ต0432','ไตรแพค อินเตอร์เทรด จำกัด-(สงขลา) /ต0432','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('24d169b8-40b3-5ead-bd64-91a8d44e764a'::uuid,237,'ถ003','เถกิงอุตสาหกรรม สับปะรดกระป๋อง จำกัด','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('38fd5603-4774-5afa-a649-1f6d22e4a31d'::uuid,238,'ท042','ทวีชัย','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('adcea1cf-d561-5417-bb1a-747ca7e3efde'::uuid,239,'ท052','ทักษิณสตีล','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dab4277e-35c0-5695-8611-9bb76c1da150'::uuid,240,'ท051','ไทยพานิช','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a371ee54-57c3-5daa-949e-f91c28e2cfa7'::uuid,241,'ท1061','ไทโยแปซิฟิก จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dcc21aa3-a8ac-51bf-890d-b404ccf7c126'::uuid,242,'บ022','บรรหารค้าวัสดุ','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d4ca6e52-c4cd-5904-b44d-c7f27158b27f'::uuid,243,'บ0163','บางกุ้งเกษตรภัณฑ์(2548)','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('17fe2654-7906-58f6-bb6f-b32585debc85'::uuid,244,'บ019','บางใหญ่เกษตรภัณฑ์','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8a7944a2-39af-5fa9-9883-55b2aa7022fd'::uuid,245,'บ021','บ้านในเกษตรภัณฑ์','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4e48e16a-4a7d-57f3-b7a9-5dc39c09e847'::uuid,246,'บ003','บำรุงพานิช','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('72780c5e-c0d0-599c-813d-5aa1a8702705'::uuid,247,'บ024','บี บ้านบึง','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0b595858-2c0b-5241-9f5c-de886572dcb0'::uuid,248,'บ017','บุญสมเคมีเกษตร','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0cf6e292-c9e8-549f-91dc-0a3c2b6125c3'::uuid,249,'บ018','แบงก์แบตเตอรี่ 2','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5ddd1348-c56e-53ed-b9e3-4db8fb189fe7'::uuid,250,'ป014','ป.เกษตรภัณฑ์ (ชุมพร)','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('65fa27eb-0258-5dbf-a70d-e3d76826af20'::uuid,251,'ป023','ป.อุดม','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6cad335a-3424-51d2-a32c-2694b72c9f5c'::uuid,252,'ป020','ประพันธ์อะไหล่','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('40814353-9ffb-5d21-b587-653af9330c21'::uuid,253,'ป034','ปากเหมืองรุ่งเรืองกิจ','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bf1088d8-9242-54df-9049-4b683aee9dd3'::uuid,254,'ป044','ปึงไท้เชียง','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d44fb988-3478-5b38-9ba1-dd1e7de4eaed'::uuid,255,'ผ002','ผาณิตาการเกษตร','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f00b0cd1-3ab5-5033-bd2f-2792f2b302a0'::uuid,256,'พ113','พระรักษ์การเกษตร','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dceb2b76-bb02-5d3d-a5c4-0faf85b3f6bf'::uuid,257,'พ040','พัฒนกิจ','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('db6d4602-6385-566e-b938-fd06f02a46ba'::uuid,258,'พ036','พัฒนาเกษตรกล','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b2089065-f493-53d2-aa0b-3c7d224043f9'::uuid,259,'พ107','พิชัยโลหะภัณฑ์','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fab5e396-da2e-52af-a4ae-9fda21717dbd'::uuid,260,'พ015','ไพโรจน์พานิช','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8a4c44f5-b179-5d79-9f98-35ff9018e6aa'::uuid,261,'ภ004','ภาคใต้การเกษตร','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('937934cf-b4c2-5710-9d93-895eccb53ee5'::uuid,262,'ม0162','มานิตย์ระนองการเกษตร จำกัด','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8e252470-f13c-55cf-8205-f4dff9babb22'::uuid,263,'ม030','มิตรเกษตร(ระนอง) /ม030','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a29df3f8-3ea4-5c16-96fb-87101df28dbd'::uuid,264,'ม018','เม้งเกษตรเคมีภัณฑ์','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b1d1fcc2-ed67-5e5d-b8bb-ff443f54bf43'::uuid,265,'ม059','เมษารุ่งเรือง','สตูล','สตูล','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d810faf-2e4b-5c41-9f85-9598eab64c09'::uuid,266,'ม028','เมืองไทย(คลองแงะ)','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ace83961-e8e5-533a-9829-3288bafabc72'::uuid,267,'ย005','ยงนำ หาดใหญ่ฮาร์ดแวร์','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('084a29f2-fc95-5ad4-8e43-cdc148b1c672'::uuid,268,'ย008','ยูโสบคานกลการ','สตูล','สตูล','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('714616a4-95e1-591f-87e0-8080a9d25fd1'::uuid,269,'ย007','ยูโสบคานคลังเกษตร','สตูล','สตูล','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6e873714-b311-5b8b-9013-8486b0413252'::uuid,270,'ร024','รุ่งศิลป์ 22','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('10027b2f-91b3-5696-bfdb-c0dc27a0ba26'::uuid,271,'ล0323','ลิฟวิ่ง กราส จำกัด(สำนักงานใหญ่)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2c2f857a-91ac-589a-8f4d-2c6205b009c3'::uuid,272,'ล013','ลิ้มกิมเส็ง','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8f73543a-e08a-58d1-875c-72af7c4e1bbc'::uuid,273,'ล003','ลุงน้ำการเกษตร','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('68e1a7ef-2114-5cf5-a348-a94551591de2'::uuid,274,'ล035','เลขาโลหะภัณฑ์-นครศรีฯ /ล035','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d4261c6-e513-5f95-b415-e091e1ab8a4f'::uuid,275,'ล033','เล้งพาวเวอร์ทูลส์ จำกัด','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('118db5af-4bd7-5d05-ad50-0130e993bc0b'::uuid,276,'ว026','ว.เกษตรภัณฑ์(บ้านส้อง)','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ac81d1a3-73d6-5a63-8483-e2dbc4d312bd'::uuid,277,'ว052','วิโรจน์การค้า','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('32ff1810-905a-5611-99b2-976b34fb5012'::uuid,278,'ว021','วิเศษการเกษตร','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('40df72e7-ed00-5fb9-b814-31c5a14f44ab'::uuid,279,'ศ006','ศรีสุพรรณพานิช','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e6c9d711-6152-586e-9a5d-6eb0a164f075'::uuid,280,'ศ015','ศิริชัยเกษตรภัณฑ์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff262504-1c18-5e14-9e66-4c59b2f823f8'::uuid,281,'ส182','สมศรีเกษตรภัณฑ์','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('33db3b9a-f83c-527b-8868-ed5bb5082a09'::uuid,282,'ส0552','สหพานิชจันดี','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9e5f631-1678-5ca0-8272-9ee5375e4ebb'::uuid,283,'ส074','สหไพบูลย์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('86c7fa4e-3471-5d88-bf58-f9e952007844'::uuid,284,'ส067','สหภัณฑ์','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bc61ef24-2538-5d85-9fa3-70ab37ee43ca'::uuid,285,'ส116','สาม ม.เกษตรภัณฑ์(นครศรีฯ) /ส116','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('08137498-00bd-5c97-ab4c-24140b717d50'::uuid,286,'ส141','สายบุรีฟาร์ม','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9706ab42-cb80-59e2-97d2-8801e84c524c'::uuid,287,'ส190','สาระเห็ด วัสดุ','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('16132150-c70f-53c0-ace0-bb44001aaa3f'::uuid,288,'ส155','สิงห์รุ่งเรือง','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bd2a9f8f-e3ec-5516-9366-f11ef039839c'::uuid,289,'ส133','สินเสถียรอะไหล่','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b73f9a25-44ea-5560-ae9f-a6e40b2400f8'::uuid,290,'ช0211','สุขสรรค์ ไชยโชค(โชคพิทักษ์)','อุดรธานี','อุดรธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cfd7038a-9f78-50be-b022-3e305088dc7d'::uuid,291,'ห023','หนูทับการเกษตร จำกัด','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a6c96e19-c03c-5251-95f0-f81c0dee5e63'::uuid,292,'ห017','หลังสวนเกษตรภัณฑ์','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4bb45033-b1c3-50b6-84d1-69926ee17933'::uuid,293,'อ100','อนุชิต ขจีรัตน์วัฒนา(นครศรีฯ) /อ100','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ce411dd9-daa2-5c2a-aa6e-c1933528d79c'::uuid,294,'อ111','เอ็ม.โฟร์.การเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5fdc7260-f830-578e-b489-539f5b6b0844'::uuid,295,'อ099','เอส เอส ซี กรุ๊ป','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ba07d0ca-cfe6-54a2-b399-3fddaee2e0db'::uuid,296,'ก081','ก.เกษตรภัณฑ์','ราชบุรี','ราชบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('54ce99a4-04ff-5598-ac92-8784f3b0f4ee'::uuid,297,'ก035','ก.อุปกรณ์','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('543d602d-9ffa-5a52-a8ce-b498db4bea58'::uuid,298,'ก041','ก้องโลหะ','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('201e738f-a66e-59d9-9600-90153c878f05'::uuid,299,'ก050','กิจเจริญการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('91de7b3f-c347-5ac6-8a9b-700b74630419'::uuid,300,'ก086','กิมแซศรีเทพ 1995(เพชรบูรณ์) /ก086','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5851a9e1-0d66-58da-b18e-de5d2e8d4ec8'::uuid,301,'ก047','เกษตรภัณฑ์(สุพรรณบุรี) /ก047','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c039888f-2d49-5408-af59-a28828478fd0'::uuid,302,'ข003','ขายถังท่าล้อ','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('75b8675b-f00e-5039-b6f6-91b1992114f8'::uuid,303,'จ004','จันทร์เจริญเกษตรภัณฑ์','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f48b15a3-5f2f-54b4-9887-cc9ea84c99d0'::uuid,304,'จ010','จูฮะฮวดเกษตรภัณฑ์','สิงห์บุรี','สิงห์บุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('40df22f5-2b60-51d2-8c28-6e241cccb8c8'::uuid,305,'จ080','เจ๊เจี๊ยบการไฟฟ้า','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1d8386d-79eb-57a2-88e7-53ca4b2ac254'::uuid,306,'จ036','เจริญชล','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb964580-9d02-51b1-82a8-5d7a02cb1475'::uuid,307,'จ078','เจ้าพระยาการเกษตร','ชัยนาท','ชัยนาท','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8e3531d1-1360-5a78-9eb6-22240bf61e9e'::uuid,308,'ฉ001','ฉลวยเภสัช','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('278d3e63-d00e-5f38-8c68-9f9cf0e0fd2b'::uuid,309,'ช0103','ช.พูนกิจชลบุรี จำกัด','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('91dcb41e-a17b-5468-b1dd-bc971622b937'::uuid,310,'ช007','ชัชวาลย์เภสัช','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('690c72ed-2c0b-5ab3-b38d-4db258febaba'::uuid,311,'ณ013','ณวัฒน์ ซื่อสัจลือสกุล','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('06a65f09-dae6-53d5-ac5d-4c26d00b9232'::uuid,312,'ส0651','ดี แอนด์ ดี สิริ','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b4b995d9-aeb9-56ba-b9ff-95b48071913b'::uuid,313,'ต025','ตงเฮงการเกษตร','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a35c4297-4d76-5fe9-b6bc-60d27c584586'::uuid,314,'ต035','ตราดตระกูลพานิช','ตราด','ตราด','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2bf69e5b-fff8-507d-9c70-ce1d7e674a3b'::uuid,315,'ต041','ตรีเพ็ชร ครอปซายน์ จำกัด','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fa98d37d-fc5d-56ce-a237-48e714b6d56b'::uuid,316,'ต031','ตากนานาภัณฑ์','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a14b7d7a-e446-5c4c-9c7c-0e18192b2975'::uuid,317,'ท023','ทรงพลธุรกิจการเกษตร','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1ed942df-b95e-5102-a0f4-386085b889c4'::uuid,318,'ท046','ทรัพย์เกษตร','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('275fc433-6d84-59b9-9250-309195addd4b'::uuid,319,'ท035','ทรายอะไหล่ยนต์','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('662f364c-9d0a-511a-82ca-470aabbbbbca'::uuid,320,'ท036','ทองปานการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0953cd0c-7ed9-5fee-9ddc-4a8f8b3ba33c'::uuid,321,'ท014','ท่าเหล็กไทย (เพชรบูรณ์) /ท014','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8f0418b7-a188-51c2-976c-56c3e37fec26'::uuid,322,'ท054','ทิพวรรณ','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('60a9bad2-f92a-5353-9865-304767faa329'::uuid,323,'ท116','ที.ซี.อาร์.สตีล','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1fa29e7e-6552-52dc-8112-26a557d44516'::uuid,324,'ท005','ไทยถาวรบึงสามพันก่อสร้าง','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4328e538-fd18-5525-85c3-108214b9e568'::uuid,325,'ท050','ไทยทองดีการเกษตร','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('94542e67-a7a1-57be-b946-276f85675312'::uuid,326,'ท039','ไทยนำ','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2f3f5065-d08d-5a2c-8bd1-d72ef4dc9f3c'::uuid,327,'ท038','ไทยประมง','ราชบุรี','ราชบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a002cb2c-394b-5511-a3d3-342bd2a91c82'::uuid,328,'ท064','ไทยรัตน์ ฮาร์ดแวร์','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('69097321-91fc-5418-ad8b-6cc13f2fb731'::uuid,329,'ท049','ไทยวิทยุ','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0dc8eb15-89d7-5c80-bb62-0d274818b8b3'::uuid,330,'ธ043','ธนทรัพย์เกษตรภัณฑ์','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cc66e8df-76d2-5511-b515-5a3882a8d065'::uuid,331,'ธ012','ธนผล','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a8ea37be-c42b-5430-a5e5-3ea3fd3807d2'::uuid,332,'ธ016','ธนาสิน','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8fafe86c-673e-5530-934d-c2c461e1320e'::uuid,333,'น027','นะโมช็อป','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cb498ede-1583-5581-bcb2-052e7e6d11d7'::uuid,334,'น044','นาโบสถ์การเกษตร','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1fa8285e-9970-5198-b47d-e7c335c771f0'::uuid,335,'น005','นิมิตรยนต์การเกษตร','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4a39409a-e998-53a8-aa15-d862b4544bcc'::uuid,336,'น013','นิวัฒน์ชัยท่อน้ำ','ราชบุรี','ราชบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f563a03a-60f6-5e75-b440-168e232bc0d4'::uuid,337,'ส0651','บริษัท สิริการค้า อินเตอร์เทรด จำกัด','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3617c320-a159-512b-847e-bc1a383bf309'::uuid,338,'บ036','บวรเลิศการเกษตร','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c1440d8-b5d8-57e9-bac0-657db21050ad'::uuid,339,'บ055','บ้านเกษตร(พิจิตร) /บ055','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('739870e3-46d6-58ac-88c5-bc8939f87d20'::uuid,340,'บ007','บุญเกรียง','ตราด','ตราด','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f5b9e5e-fe7f-5f82-bf3f-9b733b4834a2'::uuid,341,'บ031','โบโซ่(ตลาดพ่อขุน)','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a786fd7-e5dc-5ee7-8ada-f368414c9a84'::uuid,342,'ป0401','ป.รุ่งกิจ 789','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2064af53-3836-5248-aede-c6af693dc24e'::uuid,343,'ป065','ปฎิพัทธ์ วนาวงศ์ธเนศ /ป065',NULL,NULL,'d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('efed01fb-ba6a-534b-b435-190f8bc093a1'::uuid,344,'ป031','ปีนัง-ลูกชาย','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b85da0f-e206-5edd-ae51-cd93a1c003de'::uuid,345,'พ039','พรชัยเขาไร่ยา','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f8aa167d-d4b4-5a4c-8c62-2e3e8b0e676a'::uuid,346,'พ031','พัฒนกิจเกษตร','ตราด','ตราด','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2c58c9af-4290-5c5a-862d-24583b0c5788'::uuid,347,'พ127','พิมพ์ทรัพย์อุดมโชค จำกัด','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('92f779b9-511b-50d8-9d0a-1888ec0796ec'::uuid,348,'พ087','พีรศักดิ์','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a8dfdaa-10e3-5620-b452-63b5acd7d96d'::uuid,349,'อ1052','ไพรินทร์การเกษตร','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('06d4ddbe-0ab4-54ab-9a70-47684ea6617b'::uuid,350,'ภ018','ภ.โลหะภัณฑ์','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8a9918b6-0db2-51e4-bb51-1ec098f05323'::uuid,351,'ม057','มั่งมีพาณิชย์','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7385313b-e1e4-53ee-a9e7-7a578751f760'::uuid,352,'ม010','ไมตรีจิตการเกษตร','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b6e8f90e-5d46-5dbf-b89b-c9c74a871abf'::uuid,353,'ร047','ราตรีการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('90d5f098-d178-5829-9fea-5233153f34b6'::uuid,354,'ร050','รุ่งเสรีชัย 2018(ตาก) /ร050','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('58e3e422-33b2-5efa-aab9-1b9a336a8b6a'::uuid,355,'ล012','เล้งการค้า','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('05e25c1f-1c3f-5420-a274-fe1b6c150385'::uuid,356,'ว034','วันดี','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ffaad83e-3933-5be6-9267-ffb67dba6eaa'::uuid,357,'ว007','วิชัยเกษตรภัณฑ์','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c05b7076-c6ee-5319-a252-88add107dddc'::uuid,358,'ว061','วีระพานิช','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ea0f91d0-e4c6-5510-81e1-72a197ab155c'::uuid,359,'ศ010','ศรแดงการเกษตร','อ่างทอง','อ่างทอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4ca8c4df-5fba-57b0-8494-6c8ba088ae42'::uuid,360,'ศ009','ศรีเจริญพานิช','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8a23b457-bf4e-5642-9df0-f2a05b873aae'::uuid,361,'ศ031','ศุภวัฒน์การเกษตร(พรหมภัสสร)','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ad52f0fc-f7e0-5aca-9ed6-6e2dc5115fb3'::uuid,362,'ส061','ส.รุ่งเรือง(ฉะเชิงเทรา)','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a4dc81dc-327a-58e0-a262-b0f1867ae003'::uuid,363,'ส1263','ส.สหพาณิชการเกษตร','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b6b047c-1815-528c-b975-b0738a023d5a'::uuid,364,'ส151','สมหมายการเกษตร','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('132def7d-5ebf-5dd7-a3c8-1042bb972e5a'::uuid,365,'ส136','สยาม บิลด์อิท จำกัด','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('057588dc-3dc9-5de7-876a-175acbceb511'::uuid,366,'ส013','สากเหล็กการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0153138a-ac84-58a0-9884-bd2f122ec784'::uuid,367,'ส017','สิทธิชัย','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0ff4afda-d2cf-5946-a551-ab2b9c254ae7'::uuid,368,'ส115','แสงอุดม ภุมราเศวต /ส115','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5953261c-18d0-53cf-bd38-94aee430d629'::uuid,369,'ห0032','หจก.หลีย่งอัน','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6b63fbab-9f5b-5dc2-a713-7ce155563b43'::uuid,370,'อ032','อ.ทองไทย','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cc190395-8b1c-534c-8381-5be6d9d99fc2'::uuid,371,'อ025','อรุณพืชผล','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2ac40932-61a4-5829-8f2a-e7e75ac8174d'::uuid,372,'อ089','อินทโชค-(ศรีสะเกษ) /อ089','ศรีสะเกษ','ศรีสะเกษ','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('afa4bca1-5e2f-5514-869e-3495618d855f'::uuid,373,'อ1052','เอกพรรณ','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('41f87ddb-0d22-5e49-b3ed-f2817e5353cb'::uuid,374,'อ103','แอ็กกี้โฮม จำกัด /อ103','ชัยนาท','ชัยนาท','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f78e9c1f-8644-5e5a-9d01-ee42c6458e0c'::uuid,375,'จ067','Jams(Cambodia) /จ067','Cambodia','Cambodia','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d97e4e73-92bc-5ed4-9b6e-8fa02b4f61a2'::uuid,376,'อ134','LH agriculture co.,ltd /อ134',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('30dc7d06-2610-5976-a538-6b23aaea2b46'::uuid,377,'พ128','ParkThang Village(LIN) /พ128','Lao','Lao','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d72a37e8-c44e-52ca-84e6-209d328c86e2'::uuid,378,'ส168','SerngLY','Cambodia','Cambodia','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('00609850-e944-5bfd-a618-ae05d377eb37'::uuid,379,'ก140','เก็บทรัพย์ จำกัด-นนทบุรี /ก140','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c80fcaea-3b4a-569a-8263-f93bfe203960'::uuid,380,'ง001','เงินสด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6e489c61-a3df-501b-927a-65edb69257c5'::uuid,381,'ซ017','ซาวาลิน จำกัด(กทม.) /ซ017','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a23c8e7c-d9fa-5179-88b4-c3b2a858401c'::uuid,382,'ง004','งามสิริ แซ่ตั้ง','สมุทรปราการ','สมุทรปราการ','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9a95d83-a9c2-566a-9a73-a537264d87e3'::uuid,383,'ธ042','ธนาคูณพร็อพเพอร์ตี้ จำกัด /ธ042','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1083fe4-8b69-5299-a53f-17c14514a467'::uuid,384,'ป056','ปณัยยา บุญเกิด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a5645fe0-f623-5793-8f1e-1bc3bb3570fa'::uuid,385,'ป062','ปภัสสร ไข่ษรศักดิ์','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('22efe866-0e50-5029-b755-b53e06f26f83'::uuid,386,'ภ027','ภรณ์ทิพย์ ทองผิว','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dcd0b920-0981-575e-b390-680421412978'::uuid,387,'ม0511','มณฑา เบทเทอร์เมนท์ จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dde3809c-4f52-5120-ad98-dbb578fab467'::uuid,388,'ร031','ราวี ศรีสุทัศน์','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('292a48e1-c504-53f8-95e8-0475d9217a82'::uuid,389,'ล023','ลิขิต','พม่า','พม่า','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('714d78ce-b5fc-5d78-8eba-5ca60cf0b68f'::uuid,390,'ส174','สหเซวา จำกัด','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4de06b38-1569-5df5-8c0d-e4c517254cff'::uuid,391,'อ199','ออฟ มาย เบค จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8d49eb3a-d7a4-5c0b-838b-69baa8b4b973'::uuid,392,'อ0932','เอกลักษณ์ แดงน้อย /อ093','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('efe1238b-82ba-563e-8a92-e32c86b00118'::uuid,393,'ก079','กิจเกษตรกิจ','อำนาจเจริญ','อำนาจเจริญ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2ed39b78-f434-5084-bee0-9b3e11b6737c'::uuid,394,'ก004','กิมเซ้งฮาร์ดแวร์ จำกัด','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a9c6eab5-a6da-58f9-97be-7fc1a06e4a0a'::uuid,395,'จ086','จันทร์รุ่ง วัสดุ','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2dc91f3e-b986-5af0-be01-0396e56a3a68'::uuid,396,'ช049','โชคบุญมากสินทวี 2018','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bce36fa2-fed5-52f1-8c65-8d9bb5d8d1b8'::uuid,397,'ซ023','ซีเค กรุ๊ป การเกษตร จำกัด','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('068945f1-226b-5030-9cd1-332894f14571'::uuid,398,'ท117','ทองมากค้าผ้า(สาขาโนนคูณ)','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f4ec4d0e-02e7-5718-8b77-961ffc41b2a5'::uuid,399,'ท096','ทันสมัยการเกษตร','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fa605376-8589-5b1d-99d4-f3bcd30de8df'::uuid,400,'ท004','ไทยเจริญ','ชัยภูมิ','ชัยภูมิ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('674743e9-f1ee-54a6-a90f-6e1f76461ec3'::uuid,401,'พ008','พัฒนาการช่าง(บขส)-(สกลนคร) /พ008','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5dd4b1cc-14d2-5662-adc4-8a64d28c7811'::uuid,402,'บ0291','ภารุ่งเรืองการเกษตร','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c4d21be-022a-5d55-8705-87e99a62cd34'::uuid,403,'ม007','มหาผลการเกษตร','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('de64ae73-0dec-5e4c-b1f4-f05bc92449cd'::uuid,404,'ม062','มาสเตอร์เวิร์ค ไดเรคท์(นครราชสีมา) /ม062','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f9c3b058-a87d-5ac2-ba7a-daaa98f6961a'::uuid,405,'ร014','รุ่งเรืองกิจ','อำนาจเจริญ','อำนาจเจริญ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9e4abe8-3ead-5f99-b285-8a364e358d0c'::uuid,406,'ร035','รุ่งเรืองชัยเกษตรนากลาง จำกัด','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7101a7dd-a75a-51b3-b5e8-4ca65f7174d1'::uuid,407,'อ191','เอี่ยมเส็ง 2003 จำกัด','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f98ab92-b7f9-5205-b805-eaabeee0ac1d'::uuid,408,'ฮ016','โฮมพลัส สโตร์ จำกัด-(มหาสารคาม) /ฮ016','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dfe1094f-e48b-5e99-85f9-6e41a16dc78f'::uuid,409,'ก090','กฤตพาณิชย์ /ก090','สุพรรณบุรี','สุพรรณบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7db81180-d411-5981-9446-6f29044ed497'::uuid,410,'ก087','กู๊ดมอร์นิ่ง อะกริคัลเจอร์ แอนด์ ทูลส์ จำกัด(สนงญ)','ลพบุรี','ลพบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ad154416-2467-5e6c-8fe3-d60173941799'::uuid,411,'ก078','เกียรติทวีค้าไม้ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3b58d528-8647-51f8-842e-7faa07b64f34'::uuid,412,'ค050','ครูเล็ก-(กทม.) /ค050','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a1600869-e21f-52a3-bae4-6ce9a31a51cf'::uuid,413,'จ069','เจริญซีเมนต์ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6fa83d96-84bd-5e65-ae90-920da1f07256'::uuid,414,'จ081','เจริญพักตร์ วิศวกรรม จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5629c3a9-db40-5807-98f3-1b30d9825bc7'::uuid,415,'ซ016','ซี เอส เทรดดิ้ง (คุณกิ๊บ)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8db6e555-ba1a-5372-aeaf-a1475f939f7c'::uuid,416,'ป048','ประสิทธิ์ รุจิโรจน์วงศ์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('755d711e-87b2-5b94-a62d-86152d177b67'::uuid,417,'พ133','พี แอนด์ เค ไลม์โปรดักซ์ จำกัด /พ133',NULL,NULL,'4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ad58e953-0041-5488-adef-c26f11f9ae66'::uuid,418,'ภ012','ภัทรชัย เอี่ยมรัตนเมธีกุล','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ca40c0c7-38ab-5381-9a5d-2177978aba8e'::uuid,419,'ม0414','เม้งเจริญ','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5ed05df0-d51f-510c-8081-130a00ba5183'::uuid,420,'ล021','ล.ประสิทธิ์','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('30bf8b29-8c79-5309-a59b-4f19b69d0ba0'::uuid,421,'ล025','เล็ก-ดา(ปทุมธานี) /ล025','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fe6bc8e1-6bb2-562c-b7b8-604a465034aa'::uuid,422,'ว036','วิคตอรี่ สตีล อิมปอร์ต เอ็กซ์ปอร์ต จำกัด /ว036','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c1fc7fdb-ddd7-5b3e-ad88-78ef2b9c5509'::uuid,423,'ว064','วิไลเจริญภัณฑ์','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3bf47af6-4978-50de-a863-41dc4d423d9c'::uuid,424,'ว0372','ไวท์ ปาร์ตี้ พลัส จำกัด-(กทม.) /ว037','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('54409afe-5424-58b8-be40-f991dec8860a'::uuid,425,'ส189','สยามอะดิเนี่ยม จำกัด-นครปฐม /ส189','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5fe9c2a7-457e-5e3c-af6f-a20670c86280'::uuid,426,'ส193','สายชล สิทธิสม(ปรีชาพันธุ์ไม้)-กทม. /ส193','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('af5d08fd-1856-5bde-a2f9-70bd2264ca6b'::uuid,427,'อ0523','กรีน ซีดส์ จำกัด','สกลนคร','สกลนคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e056ff7d-469e-595a-a5a7-e82659aa4e83'::uuid,428,'ค052','คิง โปรดัก คอนโทรล จำกัด /ค052','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('81225625-6857-5034-ae56-8209e50dbd81'::uuid,429,'ซ0061','ซี.พี. เกษตร เชือก','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('370a8dec-e643-5c55-a333-b22bb2dc93e9'::uuid,430,'ง303','ไทยยูนิบรอส จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('97c928cd-8260-59dc-9e33-6075b877e5a3'::uuid,431,'พ131','เพชรตระกูล อุตสาหกรรม','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6e5f53fa-8f4c-5c24-bd74-7f1b240baf0a'::uuid,432,'ว062','วี.อาร์.ยูเนี่ยน จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b53aef68-1e12-5faf-ba9e-4a6d1b8972c7'::uuid,433,'ส010','สยามวิวัฒน์ จำกัด /ส010','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3b9bdff6-2edf-5426-bb22-4c9d080a823c'::uuid,434,'อ110','อาร์.ที.คอร์เปอเรชั่น จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('29742d4b-af4d-5a14-b96f-21815d521ac4'::uuid,435,'ก054','เกษตรพัชรพฤกษ์','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d5b7c843-ce30-5a45-9718-a91da936a9c0'::uuid,436,'ก0302','เกษตรยนต์ (2530) จำกัด','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f2669191-9c41-512a-8a6c-eb6d9529339f'::uuid,437,'จ023','เจริญพานิช(อุตรดิตถ์) /จ023','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6d0038d9-3442-5fde-9167-1dce74abbffa'::uuid,438,'ช020','ชัยฟ้าเกษตรภัณฑ์','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('927b0255-5eec-544f-b1c6-f3b47d5e1e3e'::uuid,439,'ต018','เต็งชูเกียรติ(สุโขทัย) /ต018','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a3664c48-aac9-5155-97e9-f22aa483720e'::uuid,440,'ต023','แต้เตียมฮวด','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9af49e5a-5ebf-5df0-9194-1b97579f47f0'::uuid,441,'ม0322','ไทยวัฒนันท์วัสดุก่อสร้าง','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ae92fbc2-0b1d-5c10-9eb2-ec00ef94be30'::uuid,442,'ท056','ไทยสวัสดี','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('71fb6a9a-f150-55f1-a0a5-051093974829'::uuid,443,'น036','นามจันทร์ลักษณ์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('00321a09-61d3-52d7-82d6-edb9d96a2e84'::uuid,444,'ป019','ประเสริฐสมเคหะภัณฑ์','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('35622057-3676-5730-9044-a7fad9a5f1b7'::uuid,445,'ม040','มัณฑนาวัสดุ(กำแพงเพชร) /ม040','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6a692f00-091b-5864-8629-13f9c5ecec05'::uuid,446,'ม0491','แม่สะเรียงการเกษตร','แม่ฮ่องสอน','แม่ฮ่องสอน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6bccb846-f31e-582b-8552-083188b7cd48'::uuid,447,'ร007','รุ่งนิรันทร์','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9ee16b0e-7453-57e6-9fef-7fde6caf9643'::uuid,448,'ร045','เรืองศิริ เคพีพี จำกัด','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5cec32a0-1924-5d0e-940b-685766c5a409'::uuid,449,'ล036','ละเอียดวัสดุ','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('335efc9a-cc13-5ac9-b624-22f3ee6a751f'::uuid,450,'ศ002','ศ.บ้านแซม','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4350eb37-4841-5366-ad11-8cb54ee3a6a5'::uuid,451,'ศ017','ศักดิ์สิทธิ์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('96fd9d55-707e-5aea-9d7d-8c36e4ab963a'::uuid,452,'ท1021','ส.สหไทยเทรดดิ้ง-อุตรดิตถ์ /ท1021','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a4157a5-4fb4-56d7-91a0-aaf0bf60a724'::uuid,453,'ส056','สวนอิ่มผล(ร้านเอฟ 242-245)-(เชียงใหม่) /ส056','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f644b54e-085b-5e18-b4ca-f720ff5a1168'::uuid,454,'ส052','สุชาดาพาณิชย์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9b417062-8ccb-55ac-90de-780710688129'::uuid,455,'ส041','เสียงชัย(กำแพงเพชร) /ส041','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8696fa0f-48eb-5125-b951-8b0dc0609f2f'::uuid,456,'อ1171','เอ็ม เอ็น-ช็อป (เชียงใหม่) /อ1171','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6684fcb3-822c-596e-b741-59ce0c106b37'::uuid,457,'ก098','ก.ลูกชาวนาการเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3d95dedd-5d9f-5977-a8f2-e80ee1d394b1'::uuid,458,'ก075','กสิวิวัฒน์ (นครศรีฯ) /ก075','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('86e26bc1-a39d-5f99-b1a7-33f1e919c01c'::uuid,459,'ก005','เกษตรภัณฑ์(สงขลา) /ก005','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f84c4f00-861c-5fa5-8f17-b2572bad955b'::uuid,460,'ก092','เกาะรุ้งเกษตรภัณฑ์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e88c8e54-0963-56a2-b719-f0755022ccf0'::uuid,461,'ค001','คูไต้เจี่ย','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa517fb5-dc19-5f63-b699-6a09d70dab63'::uuid,462,'จ072','จรูญการเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('10a8ddfa-282d-56e4-94e7-78cfec05b860'::uuid,463,'ช042','ชลกิจสปริงเกอร์','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('21f7cca2-914e-5515-bf6a-9129788e7ebc'::uuid,464,'ซ0075','เซเว่นซี ค้าส่ง จำกัด (สนญ.)-สงขลา /ซ0075','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('47a954f4-f163-518f-adb0-f17cc24f24c7'::uuid,465,'ณ002','ณัชชาภัณฑ์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c58b8ef2-9382-5240-b4b7-019ae154e6e4'::uuid,466,'ถ001','ไถ่เชียงหลังสวน จำกัด(ชุมพร) /ถ001','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('54e732f2-b1d3-5cea-b2db-9f4d71968ae7'::uuid,467,'ท0711','ทริปเปิล เอ กรุ๊ป','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d1ffff5c-5b58-5679-ae11-736fbbfcc5ba'::uuid,468,'ท105','ทำนบวัสดุก่อสร้าง','ยะลา','ยะลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1e0bcd70-0bea-515e-8c05-a87e6343b7f8'::uuid,469,'ท040','เทพนครการประปา','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f7219386-7c35-5ff2-99bf-5cce0e3cba49'::uuid,470,'ป025','ป๋วยพานิช(จันดี)-(นครศรีฯ) /ป025','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('14590526-f296-5104-a8b8-b0aa1ebb013c'::uuid,471,'ป018','ปัตตานีจักรกลการเกษตร','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7c36aa01-a2cb-549a-b04d-a1c8e61a985b'::uuid,472,'พ038','พรหมทองการเกษตร','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('93944efd-977e-5b6e-98fa-3ca288f42c46'::uuid,473,'ว0251','พี่วัฒน์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ee5dafd5-afc9-5ba4-b27c-fbaa8f7296d9'::uuid,474,'ฟ004','เฟื่องศักดิ์วัฒน์(นครศรีฯ) /ฟ004','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9a074a3e-1e27-552d-80e8-2254e5132253'::uuid,475,'ย004','ยอดเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5283fcaa-897b-5ffc-8c9d-3fa66f1b4fbf'::uuid,476,'ร041','รุ่งโรจน์การเกษตร','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d9f5aebd-2edc-5c54-b4d9-3f7a2049ab4a'::uuid,477,'ล030','เล็กรัตน์ซุปเปอร์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f29f6e4d-fd29-5fbc-bdbc-047e30d92b47'::uuid,478,'ศ037','ศรายุทธเครื่องตัดหญ้า','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('782921f4-6731-52a2-b486-cbf41f43dc24'::uuid,479,'ส062','สองเกษตรพาณิชย์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('90eacfe3-282f-5c19-b14e-124209baf2bf'::uuid,480,'ส192','เสือการเกษตร','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('169e3f97-a197-5ab3-9edc-385d1bc8bb97'::uuid,481,'อ124','อัสมาการพาณิชย์-(สงขลา) /อ124','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb1a2c69-3d18-50ea-82c9-f88762c700f2'::uuid,482,'อ125','อาบู มุสฟานี นังตา','ยะลา','ยะลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b7b1b5c6-78da-51e2-8c52-ca1b96aa04c6'::uuid,483,'ศ0381','เอส พี ซัพพลาย','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7ba57a17-e6c3-593e-9b4c-7024364fa02b'::uuid,484,'อ0952','โอเคซัพพลาย หาดใหญ่ จำกัด(สนญ.)','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a4dd5ee-5868-508d-b4ee-09f203f67f33'::uuid,485,'ก007','กล้าเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a0d6a164-8324-5449-a411-cc5a6b25b394'::uuid,486,'น0081','เขาดินกลการ','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('103ea401-aa3f-563d-8191-87cd9b20d8e3'::uuid,487,'ค043','ครูว์ ดีบิวด์ จำกัด','กทม.','กรุงเทพมหานคร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0230981e-e5f1-5530-a5b2-6d6b512e1c0e'::uuid,488,'ค051','คลองจันทร์โลหะชัย 2','ชัยนาท','ชัยนาท','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d41d0b3e-40c8-59fc-89b7-2e1462212b58'::uuid,489,'ซ005','ซินหงี่ฮะ','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dcc2f516-5e59-5493-a0f0-a883ce997721'::uuid,490,'ต015','เต็กการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7bf3cb4c-08f5-5b5b-9481-d201e7e78464'::uuid,491,'ท065','ไทยวิทยุ 2556(ระยอง) /ท065','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b8aef4c-b02a-5a1c-97c7-2d3a0edc6963'::uuid,492,'น041','เนส มล เจริญอะไหล่(พิจิตร) /น041','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0ea954f7-ea0c-52a0-a321-69dd0e5cc72f'::uuid,493,'ภ028','ภรณ์ทิพย์ จรุงจรรยาพงศ์ /ภ028','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1653b5e8-e5f3-5943-aefc-1eb4f91f426b'::uuid,494,'ภ003','ภัทรภัณฑ์','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('77c04b95-ae58-511d-96e0-c5388a26820a'::uuid,495,'ภ022','ภานุมาศ,กฤษณะภัณฑ์ (ชัยนาท) /ภ022','ชัยนาท','ชัยนาท','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('66e2ea59-9d01-572d-8eed-445c7792e521'::uuid,496,'ม004','มงกุฎทอง','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c28065a2-b794-5b4c-94e0-133f3a9d589e'::uuid,497,'ม0641','ชนาธิป การ์เด้น จำกัด-(แม่ประยูร)','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ddfbcaad-30d8-5027-8edf-eaa570ca4f4f'::uuid,498,'ร033','เรียมการเกษตร','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('53ac6331-fc18-58e8-92df-86c3f00d06fa'::uuid,499,'ส015','ส่งอางฮึ๊ง','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e07380d5-8d85-5c4b-b751-8c55b2b9c95a'::uuid,500,'ส144','สหมงคลฮาร์ดแวร์','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9bfd8ec3-38e2-58a2-87be-6589320631cf'::uuid,501,'อ101','อดิศร กำจัดโศรก','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bfa519ab-59fb-5f17-adf2-93f39c2d7a91'::uuid,502,'พ130','Phorn Nok /พ130',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('46f53276-43b4-5377-abff-9cf001770adf'::uuid,503,'ง013','เกียรติศักดิ์ เรืองศรี','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ffa48a80-fe02-56c3-955d-387bf7cf25b0'::uuid,504,'พ085','พัชดา สวัสดิ์ธนาคูณ /พ085','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('281f3856-b95e-5783-816b-c188e0689381'::uuid,505,'ม044','มิตรไมตรี 1994 จำกัด /ม044',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0fed4d52-1e8d-52ca-bff8-1f378f28d542'::uuid,506,'ร046','ร่วมดีคอนสตรัคชั่น จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('156a7268-fe87-554e-9776-43472d5dec55'::uuid,507,'ส143','แสงไทยผลิตยาง จำกัด','สมุทรปราการ','สมุทรปราการ','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3f0b2630-d775-504c-8501-997f88e8fa3a'::uuid,508,'จ070','จึงเจริญการเกษตร 2','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('81f08d2c-7d04-504f-9130-d8b5a137024f'::uuid,509,'ซ004','เซียงเซี่ยงกี่','มุกดาหาร','มุกดาหาร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bd9c0d15-1302-53a2-9b2a-7156fbe39054'::uuid,510,'ท020','ทวีโชค','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a3df2aca-5835-5801-8c5d-cd8850cc10dd'::uuid,511,'ท008','ไทยสามัคคี-สว่างแดนดิน(สกลนคร) /ท008','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c059dd29-b821-5e73-85d6-e31c2549cec8'::uuid,512,'น011','นางรองการเกษตร','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ac13f5e9-58f2-5a22-b950-c25078e93ece'::uuid,513,'น009','นิรันทร์พาณิชย์','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3b7b75a4-2493-5810-8a9f-c30114c9ed59'::uuid,514,'บ059','บุญส่งเสริม','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b047ccfb-0c75-573e-973b-34497032d4b3'::uuid,515,'ย025','ยานางวัสดุ-(หนองบัวลำภู) /ย025','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa557b6a-0e36-50b2-91cf-3714aab07474'::uuid,516,'ร067','รวมมิตร วัสดุก่อสร้าง(2018)','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a7e0ead0-ad53-5d68-95e0-36e01965efa9'::uuid,517,'ร013','รุ่งอนันต์เคมีภัณฑ์(ศรีสะเกษ) /ร013','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8b9b7a92-2eca-5f97-a4e7-888ac1187654'::uuid,518,'ส119','แสงทวีครอปแคร์ 1973 จำกัด','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cf8bfe4a-df40-5e14-8170-854a150b3931'::uuid,519,'ส059','แสงทองอาหารสัตว์','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9977c4c4-68a4-5cf0-bfee-a45e99220d59'::uuid,520,'ค003','คำมูล','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('79b3e197-e29f-53ca-92dc-611d7301802d'::uuid,521,'ค058','เคทีเอส อินเตอร์เทรดดิ้ง จำกัด-(กทม.) /ค058','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('863bc3f9-4774-51f6-bc82-30f4e6218b5b'::uuid,522,'จ005','เจี่ยเทียมเส็งการเกษตร','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a354f1ee-a7cd-54cd-9d56-eeddb57fc83e'::uuid,523,'ท011','ไทยสวัสดิ์ค้าวัสดุและโลหะภัณฑ์','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f165f589-ffb4-5d9e-a59d-90943992433f'::uuid,524,'พ124','พเยาว์ เจียมจันทร์แจ้ง(กทม.) /พ124','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d5b62187-535f-51e8-93b2-c5d6cb5471ef'::uuid,525,'ม0414','เม้งเจริญวังม่วงค้าเหล็ก(สระบุรี) /ม0412','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('eb3ca1c5-3177-55e5-999b-156a027bd893'::uuid,526,'ว069','วี เอ็น โปรดักส์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c752074e-eded-56cc-afc5-7774904eeeed'::uuid,527,'ส131','สินทองการเกษตร','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('de100267-490a-5d3f-a3fa-1e8b0982f4de'::uuid,528,'อ0391','เอส ซีจี แสงเจริญกรุ๊ป','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8d11b6d2-fc13-56b4-be4c-e9991bd73b07'::uuid,529,'ค042','คณิต ปานทอง','กาญจนบุรี','กาญจนบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b73761a0-2f2e-5341-bed7-5cb2aed64bf4'::uuid,530,'ท068','ที.เค.ที มาร์เก็ตติ้ง จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dfff2595-2ca4-551c-b718-ae4f0beae1d9'::uuid,531,'ธ046','ธนนท์ 1982 จำกัด-นนทบุรี /ธ046','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6544a214-f349-5a0c-8746-2c590134c568'::uuid,532,'ส111','สินทวีภัณฑ์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f0871e23-a53b-5b5b-909d-46347d64fa12'::uuid,533,'อ135','เอส วาย มาร์เก็ตติ้ง-กรุงเทพฯ /อ135','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('43a1baba-1924-5ac5-a74a-fe64574524d3'::uuid,534,'ก0302','เกษตรยนต์อะหลั่ย(ลำพูน) /ก0301','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bd2b2cb1-8301-5cd2-8016-8ba183b82329'::uuid,535,'จ084','จักรวาล','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('58f7d972-60e2-5c80-9c8c-5b02e4e4768a'::uuid,536,'จ009','เจ๊แดง(ลำพูน) /จ009','ลำพูน','ลำพูน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2fd507d7-92b6-55e0-b1c1-5e48a91fa2b6'::uuid,537,'จ008','เจริญผลก่อสร้าง','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0dd4f7f2-bdfd-5bd2-aedd-374d89521e50'::uuid,538,'ด007','ดาวทอง','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e51cfc70-3eba-5911-bb72-d6a314a76161'::uuid,539,'ก0842','ท็อปนอร์ท อินเตอร์เทรด จำกัด','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3103661c-0eb9-5366-8328-9f7c9eb30cc8'::uuid,540,'พ119','เพิ่มพูนการค้าวรนคร(น่าน) /พ119','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('64f2b86d-a3e6-527e-b0e2-4067c5003b65'::uuid,541,'ร038','โรงพยาบาลสัตว์ลำปาง(อุดมการเกษตร) /ร038','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1c9faa97-0d0a-54a6-a64b-27492a25db61'::uuid,542,'ศ003','ศรีสอาดการเกษตร(เชียงใหม่) /ศ003','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0886f8a2-f7f7-5340-8f7a-76c5a29fe7d6'::uuid,543,'ส073','สลกบาตร(รวมน๊อต)','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c48b4e9-2df2-55e5-9c13-dd5524b47a24'::uuid,544,'ส063','สันป่าตองเคมีเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('99383891-5464-54ac-87b4-eb55373901e2'::uuid,545,'ป0582','หัวเวียงของถูก','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cfba0762-443e-54b1-b02c-3ee7a57afce7'::uuid,546,'ก070','โกลั๋มพืชผล(พังงา) /ก070','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('89519f09-7d66-5002-8698-16f028e59b1e'::uuid,547,'ค041','ครอบโปรไลน์(โกเค่ง)','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('50aa3d6b-1466-58f3-aa16-239ac617979a'::uuid,548,'จ055','จีรพร วรวงศ์สกุล(นครศรีฯ) /จ055','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f0a9e0fb-ebd7-5f03-9bf3-02440337fee8'::uuid,549,'ถ002','ไถ่เชียงโฮมแม็กซ์ จำกัด','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a4cbab5a-d4db-5f05-94ca-3292d0acd1e0'::uuid,550,'ท053','ทรัพย์ประเสริฐการเกษตร','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('493f391c-33a5-5ee7-9633-a077b4939978'::uuid,551,'บ067','บ้านใหม่ค้าวัสดุก่อสร้าง(เพชรบุรี) /บ067','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ded0f882-81be-53ba-a42e-0f08c87799d7'::uuid,552,'ป052','ปกรณ์การเกษตร(นครศรีฯ) /ป052','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ac12c1d7-e541-575e-af0e-1faa839d153b'::uuid,553,'ป016','ประสิทธิ์เคมีการเกษตร','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3ca51f0e-3eb0-56c2-82f8-ba5fbc8c45be'::uuid,554,'พ042','พรโลหะภัณฑ์','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('11ffc3cf-1460-5770-867c-4e450188bf9f'::uuid,555,'พ078','เพื่อนเกษตร(นครศรีฯ) /พ078','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e4b606f4-a788-5332-a95c-5b3f50fc03d4'::uuid,556,'ก009','92 ย่งเซี้ยง','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('af7d59a7-1b86-536c-9e13-276e93810661'::uuid,557,'ช023','โชคประเสริฐ','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('600fabf4-d62e-5b54-9cc0-363a37a965ac'::uuid,558,'ป022','ประคองพานิช','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('05526b14-f3e4-53ee-b10c-5ef9ee44ce83'::uuid,559,'ป006','ประเสริฐ์ยนต์อาหลั่ย','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('081bdc0d-b963-5b12-a16b-701df7fb0352'::uuid,560,'ภ008','ภ.เกษตรภัณฑ์','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c4b6ecb1-9eae-564b-8e8d-b90f75296439'::uuid,561,'ม015','เมืองพลอยการไฟฟ้า(กาญจนบุรี) /ม015','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7bbc69f2-8d66-5a8d-a4be-16e14826950b'::uuid,562,'ส028','ส.ศิริยนต์อุปกรณ์เกษตร','อ่างทอง','อ่างทอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0755f1be-6477-5816-bce7-1f11cdb9fa4f'::uuid,563,'ส018','สมอทองเภสัช(เพชรบูรณ์) /ส018','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('84f31ea9-f1f2-51bf-90cd-65e5db77deec'::uuid,564,'ส150','สิงห์โตทองรุ่งเรือง(นครสวรรค์) /ส150','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('008348c9-461f-574c-971d-3b702690f8a0'::uuid,565,'ส194','สุนันท์ พันธุ์ไม้-(เพชรบูรณ์) /ส194','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fb888004-15c1-50a2-a643-14fa1506de07'::uuid,566,'ส186','แสงไทย(ตลาดสามชุก100ปี)','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('828b5155-f7a0-52ac-b27b-a48fba7b3fed'::uuid,567,'ค057','คอสเปกซ์ จำกัด','สระบุรี','สระบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bfcd17ad-9e59-5c26-be57-a4dd99f5334a'::uuid,568,'ง004','งามสิริ แซ่ตั้ง','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('213b624e-845d-5eb4-8274-e202b0eef2f0'::uuid,569,'ป047','ปัญญภูมิ คอนสตรัตชั่น จำกัด /ป047',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c43f0f2-06dc-550a-807f-ae65abb0a223'::uuid,570,'ส173','สถานบำเพ็ญตามรอยผู้รู้','นครสวรรค์','นครสวรรค์','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c2f26774-8f49-5318-8e01-429548ae955b'::uuid,571,'จ087','จีจีเอส ซัพพลาย(สนง.ใหญ่)-(ขอนแก่น) /จ087','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dd7ae486-2ff1-5da9-b0bd-7cc94d5dd977'::uuid,572,'ท067','ท่าบ่อสมบูรณ์','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6ae3ba43-17dc-5a66-9406-d930afc9fdf7'::uuid,573,'ท087','ไทยสปีดแมชชีนเนอรี่ จำกัด(นครราชสีมา) /ท087','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dffda46d-b9be-5b6e-a809-97620e13b585'::uuid,574,'ท033','ไทยอาภรณ์','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e78cf7c1-8c94-52f3-86db-6f424f2f32a3'::uuid,575,'บ027','บิ๊กตงเฮง จำกัด','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4130422f-6596-5ec5-8d79-0464d5c98736'::uuid,576,'พ0692','พันธ์ทวี คอร์ปอเรชั่น จำกัด(หนองบัวลำภู) /พ0692','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bda27efa-f5c6-52d9-a654-d59b3ea112d7'::uuid,577,'พ100','ไพบูลย์การเกษตร(ขอนแก่น) /พ100','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('19b7111a-c9e9-539c-b36a-72f73582581e'::uuid,578,'พ072','ไพศาลเกษตรเคมี จำกัด(อุบลฯ) /พ072','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('19ac723c-91ba-577f-b065-836e8841e16c'::uuid,579,'ว0021','วิเชียรการเกษตร(ภุชชงค์)','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9b58d7c-929c-5ed5-a475-2f6fe21cff6a'::uuid,580,'ว0021','วิเชียรการเกษตร(หนองคาย) /ว002','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9e3a927-f41b-5970-8594-b5ba07aec83b'::uuid,581,'ศ008','ศรีธานี(นครราชสีมา) /ศ008','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4a858b61-5d31-5f7b-ae30-5e06cc54f4c2'::uuid,582,'ป032','ปฐมอโศก-โรงปุ๋ยพลังแผ่นดิน(นครปฐม) /ป032','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4999b494-01b7-58c4-b2d6-5c8820791ea7'::uuid,583,'พ137','พัชราพร วงจันทา-(ปทุมธานี) /พ137','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c8b8290-e107-53f8-8778-5249499d3a7a'::uuid,584,'ด031','ดีเฮง(นนทบุรี) /ด031','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('06cee5ca-e539-59a3-8e65-c2a2800ac3c3'::uuid,585,'ส0942','ส.ชัยมงคลยนต์-กทม. /ส094','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0d3b5e20-e84d-5308-ae96-c8c4fec29e97'::uuid,586,'ต011','ตันติพงษ์ เทรดดิ้ง จำกัด(เชียงราย) /ต011','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bc039d6b-fd60-537b-ae8e-50d11f3fe9cf'::uuid,587,'ล024','ลูกเกษตร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('48c0aa15-7ac2-5f19-89a7-89b72ef8c72a'::uuid,588,'ว0662','วออินเตอร์เทรด จำกัด','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c80cd2b-9736-5a37-bcda-3f953f296928'::uuid,589,'ส053','ส.การช่าง(นครศรีฯ) /ส053','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bebab234-febc-57ec-b1b8-c1c67a74866f'::uuid,590,'ส118','สวนยางงานทวี จำกัด(ภูเก็ต) /ส118','ภูเก็ต','ภูเก็ต','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b44cb8d9-b2d2-51a7-a042-1f037d007077'::uuid,591,'ส047','สุราษฎร์ไทยเจริญการเกษตร','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('510b6472-3314-5b6a-9925-09679d15a5ef'::uuid,592,'ด003','ดีจริงพานิช','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9777069-571d-53d9-a8d7-63d2d136da78'::uuid,593,'บ069','บีเอ็ม แอนด์ เบนซ์ ค้าวัสดุ','พระนครศรีอยุธยา','พระนครศรีอยุธยา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('97a619a1-88d7-5d90-a396-4f5a2346cd77'::uuid,594,'พ059','พิชัยบางลาย','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8ff6e3ce-3349-574f-a00a-2d6f48c4993a'::uuid,595,'อ035','อุดมการเกษตร','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('23080a99-aa52-567f-b153-428d09750a91'::uuid,596,'พ183','P.R INTERNATIONAL TRADING (BR NO.WU16985) /พ183',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d9996eb6-d545-54a6-a454-bff62fea9f0e'::uuid,597,'ด019','ดวงตะวัน พิมพ์ดี','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0cdad427-0181-5c3d-98bd-6459fa273628'::uuid,598,'ธ008','ธนาคูณพัฒนา จำกัด /ธ008','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('62d2a424-f230-5843-aad6-cb8a367fdbb0'::uuid,599,'ธ021','ธนาคูณพัฒนา จำกัด /ธ021','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7ebb2649-4f29-50f7-ab44-1421a3b98899'::uuid,600,'บ039','บัญญัติ ปิ่นทองพันธ์','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e682eccc-6d68-59b1-8ff5-6da95a9e2686'::uuid,601,'ส157','สดใส พิณวานิช /ส157',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f04f89a3-8194-5f14-b0b7-af823342a100'::uuid,602,'ก020','ก้าวหน้าเคมีภัณฑ์','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ea8f02f0-3e23-5bb9-81fb-9b1849a8798c'::uuid,603,'ก095','เกษตรเกษม 69 (อุบลฯ) /ก095','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('207400c7-a155-58d1-ae47-b49c6654bcdf'::uuid,604,'ค009','เคพี การเกษตร29','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1d5acb22-3075-5f9c-9a55-e137f1caa26a'::uuid,605,'ฉ021','ฉัตรกมล','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('99429d08-74ce-5fea-a8fc-7b21d12729aa'::uuid,606,'ต002','เตียซุ่นเฮง','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d2767550-db19-5203-9e76-f8b14d964b5e'::uuid,607,'พ104','เพื่อนช่าง ปากช่อง(นครราชสีมา) /พ104','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b9e8f28-81e5-59bb-89e1-e8850c673222'::uuid,608,'ส135','สันวังการเกษตร','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7f806167-fbc4-5bb7-ba56-ff7846e9d6d6'::uuid,609,'ส007','สินเจริญ','ร้อยเอ็ด','ร้อยเอ็ด','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f7f8f66-95e1-5767-8e4c-80e2d3d85f96'::uuid,610,'ส087','แสงชัยพาณิชย์','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1977ef47-57d8-5e33-895d-3a4f52805c1c'::uuid,611,'ห027','หนองคูการเกษตร-(ศรีสะเกษ) /ห027','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cd12f70b-cb28-557e-b8ab-37d2699edc8f'::uuid,612,'ห025','หนิง บ้านดอนแก้ว-(บึงกาฬ) /ห025','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0c6fd8d2-6ecc-528d-a9f0-690178f76279'::uuid,613,'ก104','เกษมพันธ์ จงเจริญคุณวุฒิ-กทม /ก104','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('18045965-11b2-5d81-b2a3-63c5b2ff5868'::uuid,614,'ค0322','คิงส์ริช ซัพพลาย(กทม) /ค032','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7154fbe6-763f-5424-8c66-082617fe3315'::uuid,615,'ค060','เคเอ็น 9978 จำกัด(สนง.ใหญ่)-สมุทรสาคร /ค060','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('977bb33a-6aad-5d13-9578-8c1ffb301878'::uuid,616,'บ0452','บ้านธนะสาร เซรามิค จำกัด(กทม) /บ045','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f9dcca7a-1ae8-5c5e-8fc9-69418087246d'::uuid,617,'พ136','พรมมาคลังเกษตร จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b7e289bd-f832-5593-b616-5df248f9ca8c'::uuid,618,'พ138','พีพี โกรท อินฟินิตี้ จำกัด','นครนายก','นครนายก','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f90ba2e0-9c2c-58d6-a29c-5ee644c6e0c8'::uuid,619,'ม065','มงคลชัย-(ปราจีนบุรี) /ม065','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('02642894-d94e-5881-b77c-524db5ae5327'::uuid,620,'ล007','ลำนารายณ์การเกษตร','ลพบุรี','ลพบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('51b6223e-14df-5029-812d-1f63b8c5ec8a'::uuid,621,'จ0412','เจ.เค.ซัพพลาย แอนด์ แมชชีนเนอรี่ จำกัด-สมุทรสาคร /จ0412','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1fbdfd69-66e4-595e-91b2-903f32eb3f7f'::uuid,622,'ฉ006','เฉลิมชัย คุณธรรมลิขิต','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('10408314-b10f-5fa0-bbcd-efca82830fcf'::uuid,623,'ช066','ช่างคิด บ้านบัวทอง(นนทบุรี) /ช066','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('108d382f-4eda-5067-9352-14aa8eb28b5a'::uuid,624,'ท119','ไทยเปเปอร์คาร์ตอนส์ จำกัด /ท119',NULL,NULL,'4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('94733a8a-ae50-501f-badd-3eb83946c859'::uuid,625,'ป007','ปิติภัณฑ์ /ป007','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d88ccce-65eb-5a63-9fe1-70e62a7188ca'::uuid,626,'ส083','ส.ฮาร์ดแวร์(นนทบุรี) /ส083','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8cae1253-26bf-5880-9353-7aa91289a753'::uuid,627,'ส160','สราวุธ เพ็ชรมุข(กทม.) /ส160','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a0fef536-899b-518b-8f40-c6d71aea8687'::uuid,628,'อ200','อุบล การค้า','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('814b95d9-47f9-537a-9d9c-7bf7d29c0cae'::uuid,629,'ก015','กำแพงเพชรง่วนฮงหลี','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('20d4742d-e7d2-5ee5-96d2-b3e106561a68'::uuid,630,'ค013','คนทำสวน','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('57b5ceba-af42-586b-a462-090d4d7a7b6f'::uuid,631,'จ088','โจ้ การค้า','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('01c98819-469c-5ffa-8650-df0bd6e61b9f'::uuid,632,'ด033','ดีท๊อป-น่าน /ด033','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6ea63f9a-9e2c-50cf-abcf-35a9fd641037'::uuid,633,'ป0171','ปัญญาการเกษตร จำกัด(สนญ.)-แพร่ /ป0171','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('19d4eb1e-8021-5dde-ab73-e44eaf1a77fa'::uuid,634,'พ184','พะเยาซีเมนต์บล็อค-พะเยา /พ184','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('478a634f-68f2-58ec-9268-2668f8d9f342'::uuid,635,'พ011','แพร่เกษตรพัฒนา(แพร่) /พ011','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aff75905-3b37-561f-b2c6-b00149cc5ade'::uuid,636,'ม053','มิลเลี่ยน ฟีลด์ส ออแกนิค ฟาร์ม โฮเทล สปอร์ตส /ม053',NULL,NULL,'7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('855bb305-0ec8-553d-bd9c-ce548967a131'::uuid,637,'ว014','วีระพันธุ์ไม้(เชียงราย) /ว014','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bf99df29-6e10-5c55-80f5-ca7e051e250a'::uuid,638,'ส027','สวนสำราญ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff003af6-72a5-5d28-9a1e-6a90397cf730'::uuid,639,'ส184','สายสวาท มณีรัตน์-เชียงราย /ส184','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a3ef8a16-b776-5b04-ad3e-cbca33359484'::uuid,640,'อ003','อาลิ่ม','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('513dde7e-fe79-57e9-9dc3-7a05293d0e57'::uuid,641,'ส165','3 พี ซัพพลาย','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('864ae122-14e6-51ef-89a1-2dd7c0b44fee'::uuid,642,'ข008','เขาฝ้ายนานาภัณฑ์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9deb879-71a3-5402-af32-d5ed6710b4d2'::uuid,643,'บ0163','บางกุ้งเกษตรภัณฑ์(2548)-(สุราษฎร์ธานี) /บ0162','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d04b30b3-b22f-5b1d-add7-e2da02f82465'::uuid,644,'บ0163','บางกุ้งเกษตรภัณฑ์(2548)-(สุราษฎร์ธานี) /บ0163','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1c95fdcb-3c9e-5490-8042-55d5b2f9cf07'::uuid,645,'บ073','เบย์คลังเกษตร','สตูล','สตูล','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2fa744eb-8913-5f85-b35f-ad149457ab3c'::uuid,646,'ส195','สัมฤทธิ์พาณิช-ประจวบฯ /ส195','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4030f6c9-855f-5ec0-9685-ceaf2e2ee4f0'::uuid,647,'ช040','ช.แสงฟ้าโลหะภัณฑ์','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d0bf0335-07cd-5cbd-a2b6-ad23e99d51d1'::uuid,648,'ท063','ทิพวรรณภัณฑ์','กาญจนบุรี','กาญจนบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('09c1b733-60b0-55dd-9572-c27f29712d82'::uuid,649,'ธ015','ธนวัฒน์','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ae37b94b-ef7d-57b2-b4f0-9f559d00e22c'::uuid,650,'น0081','นิเวศน์การเกษตร(ระยอง) /น008','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a3b79f78-545e-52aa-bdfd-cc11e159cb07'::uuid,651,'ก0101','ศุภศศิน จำกัด (สนง)','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9be06d9f-027e-5599-b165-578fc9714f45'::uuid,652,'ท118','ไทยเวนเดอร์ อินเตอร์เนชั่นแนล จำกัด','นครนายก','นครนายก','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c3fa381a-7c43-536f-9884-32dd206149db'::uuid,653,'พ175','พรพิชัย คลังวิเชียร','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ceb525a7-a002-526b-8328-8ec84c66af5c'::uuid,654,'อ1702','อนันต์ บูชาบุพพาจารย์','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7fc2038b-4906-5e7c-90e4-0eabf0f238b2'::uuid,655,'ต046','ตั้งถาวรฟาร์ม-(สุรินทร์) /ต046','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('53adf42b-4d30-54a8-87aa-212511fe21fc'::uuid,656,'อ131','อลงกรณ์','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('68e21c1d-e25f-5cbf-af15-7852e6749663'::uuid,657,'ค0401','K S ท่อพีวีซี(สระแก้ว) /ค040','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3e8e9519-470e-5c66-96c6-72a22ccea139'::uuid,658,'ท120','ไทยยนต์สตีล ฮาร์ดแวร์','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('14d47f02-1f37-5b61-894d-273ffccd997d'::uuid,659,'บ041','ใบบุญ 38','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e83a23ae-d0f7-593f-a308-3845710cb2a4'::uuid,660,'พ134','ไพโรจน์ ขาวเจริญ-กทม. /พ134','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d45dc172-e08c-50c9-a132-7c023271b26d'::uuid,661,'จ063','จันทร์ที ชาลีนิวัฒน์(อุทัยธานี) /จ063','อุทัยธานี','อุทัยธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8254e1c0-64e2-5f2b-9f52-7fb2c9cc148d'::uuid,662,'บ074','บ้านใหม่ รุ่งเรือง จำกัด /บ074','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8f1a2e94-8dd4-56d4-8ae2-6cfdc76ce32b'::uuid,663,'บ072','ไบโอเทค ซิสเต็ม /บ072','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6496e22c-e18f-5f3b-8b4a-4e781fa7613c'::uuid,664,'ด037','แดงรุ่งเรือง','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ede14101-8464-5ad7-a736-eda064f814a7'::uuid,665,'ช0471','ตั้งชัยเฮง-น่าน /ช0471','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('010b6530-77ef-5d57-80fc-532bca0fb501'::uuid,666,'อ0861','ทวีศักดิ์การเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d2e548bf-0ed6-598b-8b6f-2d8fa4583747'::uuid,667,'ท081','ทุ่งน้าวการเกษตร(แพร่) /ท081','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d46d8ce8-d7de-599a-b6e0-915c60ebbe0e'::uuid,668,'พ139','พรพรรณค้าวัสดุ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('05c3ea7c-1e87-5096-a1da-fa0133096135'::uuid,669,'ภ007','ภูเพียงปศุสัตว์ฟาร์ม','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3530f9c2-59f0-5850-90f4-19dca3189a60'::uuid,670,'ฮ017','โฮมซีดส์ จำกัด-เชียงใหม่ /ฮ017','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f65188f-e0d6-5c25-a40e-d1b94d73aafb'::uuid,671,'พ055','พิจิตรป่าละอู(ประจวบฯ) /พ055','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('82b77329-eb73-5aae-bbc1-f9cc73fc76ce'::uuid,672,'ส077','สมบูรณ์','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bcb55015-9b8a-5df4-af9f-5207dbae090c'::uuid,673,'ก043','เกษตรเกษม','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b25b8a53-b5a9-5490-89c7-477e9cc12d25'::uuid,674,'ช062','ช.รุ่งแสง คอนสตรัคชั่น จำกัด /ช062','นนทบุรี','นนทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('39d33ae8-3718-5801-afc5-cdb2388057fd'::uuid,675,'ร056','รัฐวัฒนา','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3b49c490-ae3b-58b1-aec1-da7eccc50725'::uuid,676,'จ064','จรัญ สีบุตรา(พิษณุโลก) /จ064','พิษณุโลก','พิษณุโลก','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('35415026-0c3c-5c98-8b37-72383f981f33'::uuid,677,'ธ003','ธนาคูณกรุงเทพ (2001) จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('04a8fb93-c8c8-5230-8075-aecefa124557'::uuid,678,'ช070','ชนะเชิด สิงหมาตร','กาฬสินธุ์','กาฬสินธุ์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3d7898ab-5693-55c6-84bc-a50e00399431'::uuid,679,'บ075','บ้านจอมพล','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('883da97c-5fe8-5337-8fe9-40838f61b3c2'::uuid,680,'ว073','วุฒินันท์ นันทพันธ์-(บุรีรัมย์) /ว073','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('96bd2248-3d26-5c8e-878a-54c5054eae70'::uuid,681,'ว010','วุฒิภัณฑ์การเกษตร','มุกดาหาร','มุกดาหาร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('85c5c8ab-521d-5bf6-b3de-f4a2fe302f75'::uuid,682,'ส044','สมนึก เทือกชัยคำ(นครราชสีมา) /ส044','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c64e76d0-a688-529e-a732-4cf82ffd2db0'::uuid,683,'จ075','จิตตานันท์ ผึ่งผาย /จ075',NULL,NULL,'4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f30253a7-289c-54ee-9386-3aae21a8fd37'::uuid,684,'ต022','ต.แสงรุ่งเรือง','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('81a78f32-0a7e-5f81-aed8-d67f08f64c80'::uuid,685,'ท078','โทเทิล บิลดิ้ง โปรดักส์ จำกัด (นครปฐม) /ท078','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0edff60a-3143-58ef-ac03-799f78d516ff'::uuid,686,'ภ0112','ธีร์-ธาม มาร์เก็ตติ้ง-(สระบุรี) /ภ0112','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('015bb594-7f96-5165-82ab-1c81684cb84f'::uuid,687,'พ116','พิชามญชุ์ บัวเจริญ(ปทุมธานี) /พ116','ปทุมธานี','ปทุมธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7a3c6720-eddd-5759-a90f-b940b866e85a'::uuid,688,'ว072','วัดพระธรรมกาย','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('839e33b8-0fb6-5d09-8934-6c28e3406d30'::uuid,689,'ศ046','ศิริชาย','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('be80848d-6a4c-5744-922c-c92d6403bf6d'::uuid,690,'อ128','อภิวัฒน์ โภคสมบัติ-สมุทรสาคร /อ128','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5cb23580-4ec6-5b96-b8e3-04aa712b386e'::uuid,691,'อ0391','เอส ซีจี แสงเจริญกรุ๊ป(กทม) /อ0391','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3290f60e-3ad4-5f0e-9906-ddc8e87bbffc'::uuid,692,'ค0145','คงสวัสดิ์ ซัพพลาย จำกัด(กรุงเทพฯ) /ค0145','กทม.','กรุงเทพมหานคร','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('86387595-0e24-58f6-8bf6-593feab45eac'::uuid,693,'น035','น้ำเพชร ต้นไม้ซิ่ง(นนทบุรี) /น035','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dc128f9c-dbe5-55d0-826b-eb1664f02a60'::uuid,694,'พ117','พิพัฒนกิจเทรดดิ้ง จำกัด /พ117','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5861c0d0-0802-52d1-a650-8aabb73c89ff'::uuid,695,'ฟ003','โฟลเทคซีดส์ จำกัด','ลำปาง','ลำปาง','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2ef1656e-050a-53ce-ba8d-fc5678cacdb4'::uuid,696,'ธ047','ธนาสันต์ โฆษิตประเสริฐ-พิษณุโลก /ธ047','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('60a6f4d0-b31c-5478-a8ca-63021c56d666'::uuid,697,'ธ040','ธัญมนการเกษตร(เชียงราย) /ธ040','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('79464a39-4a1a-5d51-bb2d-7cc1f75f80df'::uuid,698,'พ007','พันธุ์เจริญ(ลำปาง) /พ007','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3c1ed418-30f3-567a-a640-e286700c0fdc'::uuid,699,'ศ013','ศรีสุนทร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d70582c2-e738-50a6-bddc-f24193b9ad41'::uuid,700,'ก103','ไก่การเกษตร','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ec9dd05a-7a43-54a5-905a-f595efc23911'::uuid,701,'ร036','เรี่ยวรุ่งโรจน์(นครศรีฯ) /ร036','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a28b5dce-201b-5490-a391-4ef7a2a2d17d'::uuid,702,'ต014','ต.แสงเจริญ','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b57387b1-26ed-5cd0-8da9-52da6643a9b2'::uuid,703,'พ028','เพื่อนเกษตร(อุทัยธานี) /พ028','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3b28a1eb-a02c-5c67-ad1b-9f516ddd7b81'::uuid,704,'ว071','วาย เจ เอช แมชชีนเนอรี่ จำกัด-กรุงเทพฯ /ว071','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1472c10a-50f4-51b5-8be5-5b5ffe4d6363'::uuid,705,'ห026','หาญชัย เดชคุ้ม /ห026','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ddbef9da-2034-5da9-a5c4-64c3f0819e13'::uuid,706,'ส164','3เอส คอมเมอร์เชียล (2015)','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5c0c5200-8f99-5379-9f74-9b7cba37d410'::uuid,707,'น025','นาโนนค้าปุ๋ย','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('722ff4d9-274f-52e8-8e62-8a0ae89a92c5'::uuid,708,'ป066','ปักกีอุปกรณ์','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('69462d39-bead-5084-abb8-bbd56485a05d'::uuid,709,'ว074','ว่านใหญ่อินเตอร์ไพรส์-(มุกดาหาร) /ว074','มุกดาหาร','มุกดาหาร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('939f5910-b7c8-51ec-a8e3-4dc8424f2aa6'::uuid,710,'ม067','มั่นคงวัสดุก่อสร้าง','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c5b88189-4915-5956-a1b6-c5b33a584fa2'::uuid,711,'ก100','กู๊ดชัวร์ เกทเวย์(หว่าหวา ช็อป)จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c5d1a29f-1a81-5dd6-b5bb-54295cf689cc'::uuid,712,'บ065','บัญชา กุลสิงห์(นนทบุรี) /บ065','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ef769b7c-95ab-5f89-b781-0db0a25c73e5'::uuid,713,'ม055','เมเจอร์ฟาร์ คอร์ปอเรชั่น จำกัด /ม055','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('85756709-55cc-5aa5-9b3b-b9c4aeb10f76'::uuid,714,'ช029','เชียงใหม่มณชัยพาณิชย์(เชียงใหม่) /ช029','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('745a21bd-1b2f-5748-b791-c7ba5e32d8cf'::uuid,715,'น051','นพดลแพร่โฮม-แพร่ /น051','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3f286e7e-9c8e-5c38-8825-373e216a8ffc'::uuid,716,'น001','นานาภัณฑ์(น่าน) /น001','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8a5bb89e-1412-50ce-8d11-a6adfd2a25a0'::uuid,717,'ก106','เกษตรสำราญ','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cc32a8ee-9254-5f41-aba8-2c32a7034826'::uuid,718,'ก115','เกษตรสุขใจ-(อุทัยธานี) /ก115','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7d166a7a-6c6a-5b06-8c1a-7490f9d4b9e2'::uuid,719,'ธ007','ธนาคูณอินเตอร์เนชั่นแนล จำกัด /ธ007','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2ef1e525-3876-59b5-986c-e15cd3cd8a8e'::uuid,720,'อ015','เอ็ม จี เทคกรุ๊ฟ จำกัด(กรุงเทพฯ) /อ015','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5740b0b2-0735-5ef3-a0e9-83d8496d5589'::uuid,721,'ป064','เปมิกา พาณิชย์','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a8101c53-aa34-5bda-82e9-162e0cc30c87'::uuid,722,'ท123','ทรัพย์รุ่งเรืองวัสดุภัณฑ์-(สระบุรี) /ท123','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1b0bad96-d70d-57c0-9ce6-8de0c08d289a'::uuid,723,'ด020','ดีเด่นเฟอร์นิเจอร์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('21ccf5b0-2025-5676-a1d7-f18efcccb3e0'::uuid,724,'น040','นพเก้าวัสดุภัณฑ์(นนทบุรี) /น040','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('11f88280-45d4-5ee6-9a1a-34407e2328dd'::uuid,725,'จ066','เจริญสุข','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b0dd0824-2bad-51f3-8470-636979080ef1'::uuid,726,'น019','น่าน-แพร่การเกษตร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4562ae1d-b12a-5428-9918-e24869df655b'::uuid,727,'น037','นิว เวิลด์ อะโกร โพรดักส์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b44f5bea-8457-5998-b2bb-eae890483064'::uuid,728,'พ129','พัฒนศักดิ์การค้า-กำแพงเพชร /พ129','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5c9f7c09-66b2-5114-acee-1e115a146676'::uuid,729,'ท115','ท่อเกษตรไทยตะวันออก','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bdcb9ac4-06b9-5bc8-9987-a73d51303862'::uuid,730,'ม038','มงคลคูลทวี(ตราด) /ม038','ตราด','ตราด','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b0049190-442e-5483-9b27-deb690aa4676'::uuid,731,'ส196','สายฟ้า','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d61885cd-2bfc-573a-8dc8-f0c38fc36f3c'::uuid,732,'ช006','ชำนาญการเกษตร(สกลนคร) /ช006','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e92ec40e-74c6-5caf-a716-dcacd26d1628'::uuid,733,'ท076','ไทยสมบูรณ์(ขอนแก่น) /ท076','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c6d6fc2a-0a94-5135-93f6-fb20c7be0b9a'::uuid,734,'บ062','บัลลังก์วัสดุ','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d96f212e-bbae-5608-be00-1ec2f550dfe2'::uuid,735,'ก083','กินใจ จำกัด(สมุทรสาคร) /ก083','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8c51c51b-e39f-5ae1-b9c8-87dcbdc561a0'::uuid,736,'ช0682','ชาดา ซีวิล จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('506e8baf-7c97-5155-b9ad-d362370c1c48'::uuid,737,'ศ018','ศิริชัย','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8b0d39d4-b9e9-5559-949c-b3d232ae17d2'::uuid,738,'ส188','สุธาทิพย์ คำโสกเชือก-ปทุมธานี /ส188','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('98c47269-3d14-50be-87cc-9807c0d69d92'::uuid,739,'อ050','เอส.พี.จี.ฮาร์ดแวร์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('45a111eb-0ddd-59e4-b3d2-5efd9c300359'::uuid,740,'ท027','ทรัพย์อรุณวัสดุ','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b9fb0d4-ea66-5a1c-979c-8363ce050454'::uuid,741,'ป0603','ออลไรส์ คอมเมิร์ซ จำกัด(กทม.) /ป0603','กทม.','กรุงเทพมหานคร','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('84beaa72-acd9-5f84-abc2-6dcbe4f642ee'::uuid,742,'ช0563','เชียงรายแลนด์ แอสโซซิเอทส์ จำกัด(เชียงราย) /ช0561','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('96ba8fdd-46e4-5c49-b854-cbcf7f8a530f'::uuid,743,'ท124','ทิพย์เกษตร 168-แพร่ /ท124','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7e87126e-3288-5cd4-81d2-f0da4a00c34e'::uuid,744,'น052','นิรันด์ อาชาบุญญาวิศิษฏ์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('283d059f-23f2-5bef-964e-b00bbbed4372'::uuid,745,'ห020','หล่อวิเชียร','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1b720eb6-d8e3-58f5-9842-8652adffc550'::uuid,746,'ง001','เงินสด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('23ffcdd6-152a-56da-8be3-1c5faf733b31'::uuid,747,'จ062','จินอาโอสถ(เพชรบูรณ์) /จ062','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('db6b02ec-cdce-54b9-8dfd-0abc47d7ec6e'::uuid,748,'จ047','เจ๊ง๊อ','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('24b50356-9569-52bc-9697-65c4831b75f9'::uuid,749,'ท070','ไทยเจริญอุปกรณ์(กาญฯ) /ท070','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7f644126-c36b-50f5-b33c-1546a03bb852'::uuid,750,'พ135','พิชาญพัสสุ์ สุวรรณสิทธิคชา','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6a43ed8c-a117-5431-a56e-7247a7135190'::uuid,751,'ส019','แสงทอง 2000','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('98d78952-3d91-530e-a722-0b2ff2a5ed25'::uuid,752,'ย020','ยุวดี วิรัตน์ชัยมงคล /ย020','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9be5ecd4-a900-5e31-9093-8f0609023d0b'::uuid,753,'ส197','สี่กรัตพันธุ์ไม้','นครศรีธรรมราช','นครศรีธรรมราช','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9bf0533a-b34e-5e81-81f4-992b10617738'::uuid,754,'ค012','คลังเกษตร','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0701bd9e-0ab4-509a-9fb4-a601b3648914'::uuid,755,'ม069','มหาเฮงเคมีเกษตรภัณฑ์','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fb7844c4-c12c-5834-aa87-dad78e688766'::uuid,756,'ศ022','ศราวุธ ทาเหล็ก /ศ022','พิษณุโลก','พิษณุโลก','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff47b8dc-a5c7-5559-ab76-1fc0d195251b'::uuid,757,'อ023','อ.พานิช(สระบุรี) /อ023','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ee2dbefb-a119-5d84-82eb-5f66b5d41219'::uuid,758,'ค016','เคเอสมาร์เก็ตติ้ง 2014 จำกัด(นครปฐม) /ค016','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1c1afe36-eaee-5a72-a66d-53ce4e7ad253'::uuid,759,'พ132','พรหมสิน พี.เอส.ซี.จำกัด-กรุงเทพฯ /พ132','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('56821c4a-9a50-5bb2-9e22-cbee3b3631a9'::uuid,760,'ก082','กระต่ายเครื่องมือช่าง(น่าน) /ก082','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0807901e-e762-5eef-a81e-7d851c0f90bc'::uuid,761,'ก014','เกษตร 2000','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9aac0be0-fca0-5b1e-afb9-96ed563ebeef'::uuid,762,'ช0563','เชียงรายแลนด์ ซีเมนต์บล็อก จำกัด(เชียงราย) /ช0563','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0c1b3a1f-2ef4-5d41-ab96-f3486ffe0c38'::uuid,763,'ม068','มีโชคการเกษตร','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('640e3565-69b8-5025-b7c0-86e60a4dcb17'::uuid,764,'ก010','กิมแซอาหลั่ย(เพชรบูรณ์) /ก010','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aaa1b95c-a12d-582b-890f-36362d0c9b7a'::uuid,765,'ย001','ยนต์เสรีการเกษตร(เพชรบูรณ์) /ย001','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8b7848f5-f809-5ead-8b54-aa578f2fb95e'::uuid,766,'ร061','รุ่งเรือง-(ตาก) /ร061','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c87b4988-2522-529f-b01e-dd74d8245e25'::uuid,767,'ส049','สุรินทร์ฮาร์ดแวร์(นครสวรรค์) /ส049','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7472a0c6-817b-54b1-bb94-d528d3c9468e'::uuid,768,'ง003','งามจิต แซ่ตั้ง','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('faf045f0-3036-50c8-a6c1-43b724099001'::uuid,769,'ธ048','ธนาทรัพย์ ธาตุพนม','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e074524c-1058-50ec-9bba-d6f12ded5d21'::uuid,770,'อ127','อ.ยิ่งเจริญการเกษตร-(อุดรธานี) /อ127','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c4c32cb9-3408-5955-9eeb-c6e33d288042'::uuid,771,'ก116','กานดา อพาร์ทเม้นท์ จำกัด','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d0344acc-0c67-5c8e-b1ab-9616ebbf6d74'::uuid,772,'ง001','เงินสด','นนทบุรี','นนทบุรี','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e052098f-3bad-57a7-9184-6670c02eafb3'::uuid,773,'ว075','วิคทอเรีย เทรดดิ้ง จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('71f6f6fe-c9e6-5e8b-8748-8e31bd33780a'::uuid,774,'ว076','วิโรจน์การเกษตร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0a0270e8-e8f9-5030-a17f-ca89d40d767a'::uuid,775,'อ0331','อภิญญา-เลย /อ0331','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('466eeee8-83a3-5389-8a0c-06b8e9ca987c'::uuid,776,'ต042','ตันติวัฒน์เกษตรภัณฑ์(นครศรีฯ) /ต042','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c87fd46d-ff4c-545a-b586-3655cd3fa0aa'::uuid,777,'ร068','รัตภูมิ การเกษตร','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fe82b99e-a473-5e27-ae85-510c51197ae2'::uuid,778,'ร052','รพินทร์เกษตร(จันทบุรี) /ร052','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('da6ba095-4f4c-5357-984a-73c0f4470ffb'::uuid,779,'ส030','สหะชัยท่อน้ำ','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('378b043a-88c6-5f5d-87b6-24c7b302a80a'::uuid,780,'อ1052','เอกพรรณการเกษตร 2019 จำกัด(กาญจนบุรี) /อ1052','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('322c1f47-56ee-5677-8962-0f7576bf6f53'::uuid,781,'ก117','กวงฮะเคมีเกษตร จำกัด','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c7ccd8aa-fe77-545a-a9b3-34c870b0ac0b'::uuid,782,'ก021','เกษตรภัณฑ์','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('75078451-5db3-50ab-bca6-efbc12496134'::uuid,783,'พ016','พี เอส วาย การเกษตร','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a49b7733-ab84-53a1-9220-fdc6b170abd8'::uuid,784,'ฟ009','ฟาร์มเห็ดวาสนา','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2bc5054e-b12f-5624-b07c-6443bdc49f78'::uuid,785,'ร069','รวมการเกษตร','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('437b93ea-0fac-568f-8a81-b1efae48e6e6'::uuid,786,'ร005','รวมเกษตร','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('10c9ba6f-2af1-5bd4-99e2-8019234a6e55'::uuid,787,'ร005','รวมเกษตร','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('890c4ed3-20c5-591b-84c6-b23c38372cad'::uuid,788,'อ0982','เอ็น อาร์ เทรดดิ้ง 2018','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('182aafd4-4586-5e5b-b393-e7718901a732'::uuid,789,'ว069','วี เอ็น โปรดักส์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6d8efbb3-93fc-55e7-9acb-1bb05df513f2'::uuid,790,'อ138','อภิชาติ จันทร์โต','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4dafaa42-16ed-5f59-9797-eaee0c2161a2'::uuid,791,'ก068','กู๊ดไอเดีย วอเตอร์ ซิสเต็ม','เชียงราย','เชียงราย','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b0463eac-3196-5d1f-bd71-2eb0eb7d47d3'::uuid,792,'จ023','เจริญพานิช','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fce432b4-1f29-56b7-a3d6-5ecc89ff6d98'::uuid,793,'ป015','ป.ชัยยนต์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d9807a5a-1f20-58c0-882a-568f677deb25'::uuid,794,'ม030','มิตรเกษตร','เชียงใหม่','เชียงใหม่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6678d15e-0e75-55fb-8ae2-eb02d4215b2b'::uuid,795,'อ137','อู๋ฟิชชิ่ง','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f69897cd-681c-5caf-9ce7-86bd76197e1a'::uuid,796,'อ1171','เอ็ม เอ็น','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0aa4c3d4-2360-552c-907a-1152628131df'::uuid,797,'อ190','เอส ที เซ็นเตอร์ กรุ๊ป','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fda89a32-deed-5ab6-a365-dd47a8eb2a0c'::uuid,798,'ซ0075','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00002','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fad0f595-f83d-51fa-842f-c2f4883c349c'::uuid,799,'ท125','ที เอส โลหะกิจ','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6ce34674-2b70-5a30-a24b-5b17bbd1edfe'::uuid,800,'พ001','เพื่อนเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b31b28a0-a344-52a6-878a-9ef4293b0e29'::uuid,801,'ส1982','เอส เจ มัลติ โปรดักส์ จำกัด(นครศรีธรรมราช) /ส1982','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f8cc5b21-986e-5112-9950-f281c40a325b'::uuid,802,'ก021','เกษตรภัณฑ์','สุพรรณบุรี','สุพรรณบุรี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('91d00cf2-7b47-5e89-8bc0-682970a2420b'::uuid,803,'ร061','รุ่งเรือง','ตาก','ตาก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d94b2170-779b-58ce-b766-977de7986458'::uuid,804,'ส136','สยาม บิลด์อิท จำกัด','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f148ed62-355f-5fd7-bff5-de0b1c7f6381'::uuid,805,'ส146','สวนครูพรรณี สหเจริญ','จันทบุรี','จันทบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0412eaef-d222-5b0a-9cdd-249811d55ef3'::uuid,806,'ส150','สิงห์โตทองรุ่งเรือง','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6e3fb78b-a92f-532f-bcca-56dfe4c98950'::uuid,807,'ท0062','เกียร์ ทูลส์ (2023)','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('76e56c75-af80-55de-821a-d79c4a65ce39'::uuid,808,'ฐ002','ฐานลาภ(นครปฐม) /ฐ002','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5b8ea797-0539-5698-a171-14c628432fc4'::uuid,809,'ต044','โตวัน ทรานสปอร์ต จำกัด-(นครปฐม) /ต044','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('04d2c14d-f6c8-5a02-9253-39e86d2c203f'::uuid,810,'พ0031','ปวเรศ ธีระชาติ','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e2d2ad3d-8e7d-52e4-94f5-a099cf272d64'::uuid,811,'พ0122','พงษ์เชียงทอง พลาสติกเน็ทติ้ง จำกัด(สมุทรสาคร/กทม) /พ0122','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f5dccc66-53a9-5f20-a61d-667ce4f7978d'::uuid,812,'ก118','กีรตยามิตรเกษตร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('53976527-fc2b-5501-aeae-c08e66c3d821'::uuid,813,'พ122','พอเพียงการเกษตร-(เชียงใหม่) /พ122','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('512a0643-c5e9-555d-a883-67a0d0f33dee'::uuid,814,'ว016','วาณิชย์','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4aa5cd3e-9c98-5a10-8172-2784b641ce44'::uuid,815,'ท018','ไทยเจริญโลหะภัณฑ์(กาญจนบุรี) /ท018','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d939e6c7-64f3-5fa4-ab8a-1d9a37446334'::uuid,816,'ณ0141','ณัฐดนัย วิชัยดิษฐ','สุราษฎร์ธานี','สุราษฎร์ธานี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b430e628-7314-5736-b860-a66f2d0b399b'::uuid,817,'ณ006','ณัฐพัชญ์ ธนชาญวิศิษฐ์ (กทม.) /ณ006','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c59e7f4f-7644-50af-ba38-86aa4d4666ae'::uuid,818,'พ140','พิชัย สัมมาลา /พ140','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('32930e89-f117-5223-8e65-1160375b4041'::uuid,819,'ฉ007','ฉัตรวัฒนา-(มหาสารคาม) /ฉ007','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e3eac7a3-7193-5548-ac4b-95aafa23dc0a'::uuid,820,'ช071','ไชโย','ร้อยเอ็ด','ร้อยเอ็ด','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a1b74266-6090-5724-997c-3e4265d356e9'::uuid,821,'บ077','บัลลังก์ ทูลล์','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('458e7264-e556-5257-9c17-3ff9c8d68ba9'::uuid,822,'บ078','บี.พี.ฟิวเจอร์ซีด-(อุดรธานี) /บ078','อุดรธานี','อุดรธานี','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1c185d57-eaf7-597a-bdd5-e833404a43b0'::uuid,823,'ส036','ส.เคมีภัณฑ์','หนองบัวลำภู','หนองบัวลำภู','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('20f7c46e-40cf-5f4c-b936-0fb59d8bd619'::uuid,824,'ด038','ดีไอที โฮมโปรดักส์ จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8eeeaf9e-c134-5e44-92fb-8e69fbb7f995'::uuid,825,'พ066','พานวัธนะกิจ จำกัด','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('127b3afc-2e52-5eb5-82cb-04764fbffd87'::uuid,826,'ท126','ทับสะแกค้าปุ๋ย จำกัด-ประจวบฯ /ท126','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d359526c-2747-55d0-b1c0-a50738440b01'::uuid,827,'ค061','เค.พี.พี.ฮาร์ดแวร์ จำกัด(ชลบุรี) /ค061','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3aaf43c3-0b28-52e0-8ca7-9e8f581dd06b'::uuid,828,'ต047','ต๋องไทยเจริญเกษตร-(บุรีรัมย์) /ต047','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1a769c51-a6d7-525a-8297-873138b1b80f'::uuid,829,'ท029','ทรัพย์สินการเกษตร','ยโสธร','ยโสธร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b27589fe-8066-5e9b-9959-91c94d88964b'::uuid,830,'บ079','บิ๊ก ไฟว์ แมชีนเนอรี่ จำกัด-(กทม.) /บ079','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bd7868c9-349d-5b33-8ade-24181d97eb82'::uuid,831,'ก141','กนิษฐาพลาสติก จำกัด-นนทบุรี /ก141','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4b1caef9-6fc6-5f92-a81d-0cc52e03cc4e'::uuid,832,'ศ047','ศรีสะเกษเกษตรกรรมยั่งยืน จำกัด','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0b501c75-b7d4-518c-bc0e-e2154606da2c'::uuid,833,'บ081','บ้านสวนเกษตร','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3c061f48-17de-5775-b7b4-c85095fc0f3c'::uuid,834,'ภ029','ภานกฤตทอรี่ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('66194996-ba13-5abe-b9e9-0ff5a9e93bf8'::uuid,835,'ส199','สามารถ สุริฉาย','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7faff937-92a2-587c-b870-bef393324c5f'::uuid,836,'ร016','รัตนะกิจ(เชียงราย) /ร016','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ee1427f5-1a59-5eb9-9b11-9792b148b0c8'::uuid,837,'ซ0075','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00001-ตรัง /ซ0074','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a36f498c-cbb4-5af6-91f9-b87b07e346e3'::uuid,838,'บ080','บันไทยการเกษตร-กระบี่ /บ080','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1391c1f8-54a9-552c-9b81-5862ebdff684'::uuid,839,'ป004','ปราณนานาภัณฑ์(ประจวบฯ) /ป004','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('02dd6891-7c1e-5375-9f41-7ddc2d5dad7c'::uuid,840,'ต048','ตี๋ วัดโพธิ์-(นครสววรค์) /ต048','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9e3eb269-f0f7-59ff-a453-3c7861b3eb0b'::uuid,841,'อ1392','องศาการเกษตร-(เพชรบูรณ์) /อ139','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6954d814-dd45-5cf9-8b17-1adce499d8a5'::uuid,842,'อ140','เอกศิริโฮมเดคคอร์เรชั่น จำกัด-กทม. /อ140','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('240cb9ea-96b3-510f-96d1-c7a0b32ee339'::uuid,843,'ว077','วิชาญเภสัช-(บุรีรัมย์) /ว077','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('57d15f8a-19e9-5792-a74b-6e51c6f164ac'::uuid,844,'ม0414','เม้งเจริญวัสดุก่อสร้าง 2021','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('293bd938-6a25-5d06-872d-3ea2ba7a9bfc'::uuid,845,'ฐ004','ฐาปนี ศุภศิริสินธุ์ /ฐ004','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8eb68d8a-3f88-51fc-aefd-4de74d5e2cbe'::uuid,846,'ฟ015','แฟนชาย','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('300462c4-26ab-565c-a4de-ac546a7dbbf0'::uuid,847,'ว078','วีรดา อนันต์โชติวิรุฬห์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5656c3fc-0315-5121-8319-ed29c6c85157'::uuid,848,'ก119','กำจร วงค์วุฒิ-เชียงใหม่ /ก119','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa7a4ac9-ba53-578a-b72c-74b91df97a47'::uuid,849,'ศ048','ศุภลักษณ์-เชียงราย /ศ048','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5df6dd06-2bbb-5ef7-a35f-f35cee39b704'::uuid,850,'ส200','สวนพิริตาไร่ภูริพัฒน์ จำกัด-พิษณุโลก /ส200','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cdf5ae64-a4d6-5248-9453-187dc6a106d4'::uuid,851,'ป028','ป้อมเกษตรภัณฑ์','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ca3a07c4-e9dd-51e7-8920-4b5de614dac8'::uuid,852,'ม045','มูลนิธิ หลวงตาน้อย /ม045','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a5ee4560-c797-5068-89df-6b163099ba42'::uuid,853,'พ001','เพื่อนเกษตร','อุทัยธานี','อุทัยธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4d1a455a-1303-5919-8214-801641315f5a'::uuid,854,'ศ0402','ศิริบุญอินเตอร์พลาส จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1dcf88a5-7c7d-5fda-9c7a-630bad7ef564'::uuid,855,'ม030','มิตรเกษตร','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('22e3e758-3780-502b-a4b7-6bf655b74167'::uuid,856,'ก105','แก้วทีวี การไฟฟ้า สาขา 3','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a573de0e-9e26-5251-bddd-dad79426d302'::uuid,857,'ซ0075','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00002','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('04068bcc-a0ad-57be-a898-bc6f1d352ac0'::uuid,858,'อ1392','ภูมิภูมิพัฒน์ กรุ๊ป','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e2d1db05-575b-5ed4-b8d5-6bc0aae8163e'::uuid,859,'อ1192','เอ็มเอกซ์ที จีโอ โพรเทคชั่น','ลำพูน','ลำพูน','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('54f2dfca-7566-5ac5-98b1-84bc38580bc7'::uuid,860,'บ082','บุญกอง บุตธิจักร','อำนาจเจริญ','อำนาจเจริญ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7d08ef05-330e-5cd4-bb65-21eaeeccfd69'::uuid,861,'ป067','ป๋อง พารา ปากคาด-(บึงกาฬ) /ป067','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aafd6636-cff6-57d1-891b-62b4273af0c8'::uuid,862,'ร070','รวมเกษตรบึงกาฬ-(บึงกาฬ) /ร070','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5f8110af-8f82-5088-a844-1e199ca21703'::uuid,863,'จ089','จันทร์จิราการเกษตร-(สระแก้ว) /จ089','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('78c816d6-a583-51a0-835e-c51a294649a6'::uuid,864,'ร053','ราชาเต็นท์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff5b14ce-2648-5a6b-b6ba-2fffabc00081'::uuid,865,'ณ009','ณพวัชร ภู่อมร(นนทบุรี) /ณ009','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('946a2f24-bae7-51ba-860e-79fc9ba8eb43'::uuid,866,'ส0942','ภัชโสภณไปป์ จำกัด-กทม. /ส0942','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('17701937-0fa5-5efe-b9fc-c587986055b7'::uuid,867,'อ141','เอ็ม แอนด์ ซี อีควิปเม้น จำกัด','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8e48fd46-8a93-5d9c-9e80-aba520a78eb2'::uuid,868,'ภ031','ภาสกรเกษตรภัณฑ์ จำกัด','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fc76b67c-eff0-5cda-898c-f52c10ad4082'::uuid,869,'ส201','ส.พาณิชย์ ทุ่งยาว','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0b0a687f-bc80-51c0-8800-56383f8a91f0'::uuid,870,'ท127','T-One Home','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9fe41b3d-8c97-55e6-8361-2d193bafdac4'::uuid,871,'ส202','สมยศ อินทร์ภูวงษ์-(กทม.) /ส202','กทม.','กรุงเทพมหานคร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('99c8f040-4995-5cab-aca4-9f2658c87ff8'::uuid,872,'ส203','สยามรุ่งเรืองโลหะภัณฑ์-(กาญจนบุรี) /ส203','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6474d65a-d570-519e-b628-24eb1e0ec08e'::uuid,873,'ภ030','ภัทรารีย์ ชูโต','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('360763a6-e0ed-5d35-83f5-56ee38783067'::uuid,874,'ว079','วิชุดา ลีลารุ่งโรจน์','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('439f0978-1188-5b26-84aa-622f8942e54a'::uuid,875,'ว080','วรวุฒ ปทุมรัตน์','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8691cec5-92af-54d4-8dfb-50a5f59dba40'::uuid,876,'ฉ005','เฉลิมชัยค้าวัสดุ','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b38be9c9-7ce1-5f87-896c-f8f08c242a4a'::uuid,877,'พ088','พอเพียง เทคโนโลยี จำกัด (สำนักงานใหญ่)','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('abb2e0a7-a8e2-537f-b317-4f569373a116'::uuid,878,'ส205','สมบัติการค้า','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0638db5f-a4ac-5035-9d36-eb34e3884a96'::uuid,879,'ส204','สุริยา ไชยชนะ','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ce9c15e4-5c3f-5b8f-8ab5-393e7ba74e40'::uuid,880,'พ186','พ.การเกษตร','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('42bb6a31-275a-5ed6-af21-983a33fcd25f'::uuid,881,'ส206','สุรัตน์','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('391b9365-e74f-5dab-9a27-64aaeaa67d33'::uuid,882,'ซ0075','เซเว่นซี ค้าส่ง จำกัด (สนญ.)','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('12312cf6-4761-59b1-bc26-63916a60aa60'::uuid,883,'ต0432','ไตรแพค อินเตอร์เทรด จำกัด','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('91c980b0-5527-5b6f-b6b4-82edd4d30d35'::uuid,884,'พ049','พานิชการ(ตราด) /พ049','ตราด','ตราด','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('900bae86-8c72-5b36-a516-f27515d458f4'::uuid,885,'ภ032','ภูมิพัฒน์ จันทกุล','ฉะเชิงเทรา','ฉะเชิงเทรา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('306406bb-2e17-57b2-8ce0-3a800195e199'::uuid,886,'อ142','เอ็น พี เค โปรดักส์ จำกัด-(สุพรรณบุรี) /อ142','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1d625086-cb15-5ad1-8f62-a8361b6997f5'::uuid,887,'ก065','กอล์ฟอีสท์ จำกัด','พระนครศรีอยุธยา','พระนครศรีอยุธยา','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('40d677a3-e7a2-56f0-bb9d-6f89629484f3'::uuid,888,'ม0442','มีมิตร ดีเวลลอปเม้นท์ จำกัด','กาญจนบุรี','กาญจนบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ed951380-3637-5ae6-a5e5-328fe5ce2b13'::uuid,889,'ร054','รจนา เฮ้าส์ซิ่ง จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('dc248119-a6e8-5c4d-8bc6-bb20b35ea950'::uuid,890,'พ142','พรพิศาลค้าส่ง','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('49c78834-a5dc-5ca8-936b-38c9bc175d29'::uuid,891,'ป032','ปฐมอโศก','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fed650db-8de4-5432-a003-252c27cd6498'::uuid,892,'ส207','โสภณพลาสติก จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f2f88dbe-ecaa-5d1d-8c9a-51555ceba39a'::uuid,893,'อ203','อี.ที.เจม ฮาร์ดแวร์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5c325572-b8d8-5c87-9b91-efdd15d00fc6'::uuid,894,'ก060','กุ่ยพานิช','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9efb554-a585-5cef-a219-771f6952ba51'::uuid,895,'ล037','ลัดดาวัลย์ การ์เด้น','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9abdc98e-4c6c-5096-bf49-5721c3fe1038'::uuid,896,'ธ049','ธัญธนาพาณิชย์','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('589b1fc4-bcea-5c28-ac55-046ca345206c'::uuid,897,'น053','นิติพัฒน์ จงจรูญชินเลิศ-(มหาสารคาม) /น053','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a34ab5ad-9d9c-5e96-a404-930e0eea8a7d'::uuid,898,'ส208','สยาม เกรท-เทค กู๊ดส์ จำกัด-นนทบุรี /ส208','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9835b6e5-984d-549d-87b6-dde862bde74e'::uuid,899,'อ202','เอ็ม อาร์ เอช เทรดดิ้ง จำกัด /อ202','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('93e57c03-6b27-5bca-b81b-9eb863f16264'::uuid,900,'อ143','เอิรท คิว เคมซีดส์-(ราชบุรี) /อ143','ราชบุรี','ราชบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b357db53-51c1-510d-aa10-321540b48a8e'::uuid,901,'ง005','งานเกษตรกำแพงแสน','นครปฐม','นครปฐม','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2be4e155-cb71-5f67-99dd-f0dfaac8db58'::uuid,902,'พ143','เพชรพลาซ่า(ขอนแก่น) /พ143','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('026e8698-c95f-5fb0-9afe-cb1e8b6b8eac'::uuid,903,'ก121','กิ่งกาญจน์ จิระสกุลไทย-(นครปฐม) /ก121','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('019e2f79-e19d-5b2c-88d0-0dfb0e76f086'::uuid,904,'ก021','เกษตรภัณฑ์','สงขลา','สงขลา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('de3b4e47-7838-52b2-8d9a-dd96bc6e231a'::uuid,905,'ซ0073','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00002','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5edda78a-75d8-50b5-bc2e-99e03374140d'::uuid,906,'ฮ013','ฮุ้งเซ้งการเกษตร จำกัด(สุพรรณบุรี) /ฮ013','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1fc3ad31-feb3-5705-8b04-f6a2cb698808'::uuid,907,'จ090','จารุวรรณ ทำเสื้อทำสวน-กรุงเทพฯ /จ090','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b2acace-300d-5943-914f-e0525e96394d'::uuid,908,'ว063','วาสนา อยู่ประจำ','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c691b982-cd20-5e49-a8ec-4531a1ae278b'::uuid,909,'ศ004','ศรีอารยะเทพ จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b031367-e126-5071-9518-0084d398aeaa'::uuid,910,'พ144','พี.พี.คอนกรีตโปรดัคท์(สระแก้ว) /พ144','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5d26067e-aa57-5792-a8bd-92740c348819'::uuid,911,'พ141','พีดีเกษตร(ลพบุรี) /พ141','ลพบุรี','ลพบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e40ae461-c2a3-54e9-b18f-701e65c57de0'::uuid,912,'ท001','ไทยสามัคคี','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f98241fb-ab4f-5cae-ae46-b8276d8091d0'::uuid,913,'ก142','กิจนครค้าไม้(เชียงราย) /ก142','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('58f03638-e93e-50dd-b253-c3c9add83c0b'::uuid,914,'ต037','ต.การเกษตร','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('006a90fa-0db3-513b-ad91-fd24e62feeb1'::uuid,915,'น020','นับพระพรการค้า(แม่ฮ่องสอน) /น020','แม่ฮ่องสอน','แม่ฮ่องสอน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9b757e7c-2e7d-5336-94cb-f2640b4f5885'::uuid,916,'ส1772','เอส แอนด์ ดับบลิว ซัพพลาย(พิษณุโลก) /ส1772','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa2387b2-32ad-5d54-a7a3-6ff7d9ef86b2'::uuid,917,'ช072','ช.เกษตรภัณฑ์ (ลานข่อย)(พัทลุง) /ช072','พัทลุง','พัทลุง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('410bbc7d-ca36-55d7-9230-9f0c5f29f294'::uuid,918,'ต0362','ตฤณภัทร จำกัด(ระนอง) /ต0362','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('42696296-ed3c-54e9-823b-f6ceb41befcd'::uuid,919,'บ083','บางกล่ำการเกษตร จำกัด(สงขลา) /บ083','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1a405eff-0b76-5195-9fd5-4e728dae233e'::uuid,920,'ส209','สาม.เอ็น. เกษตรกลการ(ตรัง) /ส209','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('124d0c55-8ea9-5fbd-b3dd-205a03ceb7f8'::uuid,921,'ศ0381','เอส พี ซัพพลาย','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2713ec93-ebb0-55f9-bf08-728e71c1c1aa'::uuid,922,'บ023','บ้านเกษตร (นนทบุรี)','พิจิตร','พิจิตร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ad444638-0b05-5409-966f-e0056c7a136e'::uuid,923,'พ131','เพชรตระกูล อุตสาหกรรม','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('515d391e-fa1d-525b-afb1-56c1f6d96ffe'::uuid,924,'ส210','ส.โฮมมาร์ท(นนทบุรี) /ส210','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e82b17e1-1dbf-5f68-84a0-68ff5ea1303c'::uuid,925,'ณ0141','P.E.HOUSE(สุราษฏร์ธานี) /ณ0141','สุราษฎร์ธานี','สุราษฎร์ธานี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d64197b1-98c9-51a1-b09f-6b74fc4a4c72'::uuid,926,'ป011','ประเสริฐวัสดุภัณฑ์','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fcd573fd-1eb2-5d00-b9f1-8363d10c55cf'::uuid,927,'ส189','สยามอะดิเนี่ยม จำกัด','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('69a9292e-7d2f-57a8-9fa8-a3902830767d'::uuid,928,'ส0552','สหพานิชจันดี(นครศรีธรรมราช) /ส0552','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('efe00f87-f0f7-5ccc-9634-d861811c276d'::uuid,929,'ส115','แสงอุดม ภุมราเศวต','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9d80c646-d2fb-5f81-b99c-432810d4e4cb'::uuid,930,'ต048','ตี๋ วัดโพธิ์','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e93834f3-e5a1-575f-ab82-ec4c5ce3d9d1'::uuid,931,'บ055','บ้านเกษตร (นนทบุรี)','พิจิตร','พิจิตร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('85e4b77e-b0ad-5d5d-afe5-cfa8450c7b62'::uuid,932,'ก143','กัลยาก่อสร้างและเกษตร(แพร่) /ก143','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d0d4d8ea-56b0-5934-af94-7ab806e42048'::uuid,933,'ห029','ห้วยโก๋นการเกษตร(น่าน) /ห029','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('88d48e60-afdf-5989-b91a-24f5b35c1b29'::uuid,934,'ส170','เสือการเกษตร','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6c68bf16-cc3d-5c9f-b5ed-7b6490e4a673'::uuid,935,'พ061','พี.เอส.ฟิชเชอรี่ อินเตอร์เนชั่นแนล จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('57af35cf-c016-5389-9d9a-7c676424af02'::uuid,936,'พ028','เพื่อนเกษตร','อุทัยธานี','อุทัยธานี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5fb547e0-71ad-5ff1-aa9a-c211cff01382'::uuid,937,'พ100','ไพบูลย์การเกษตร','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c7c90df-9860-5a51-b9ff-520f7481982c'::uuid,938,'ร071','บ้านใหม่ หมู่ที่4 วิหารประชา(นนทบุรี) /ร071','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0455515d-213b-5cf4-bc92-f78e473ddb80'::uuid,939,'ส041','เสียงชัย','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('42a6037e-2683-5a3b-8a15-83ffe17acf37'::uuid,940,'ส116','สาม ม.เกษตรภัณฑ์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6a0200b1-b394-56f0-ac8c-fa23952e1e8c'::uuid,941,'พ055','พิจิตรป่าละอู','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('47398959-1687-57d2-b8a2-ccf2693d0186'::uuid,942,'พ078','เพื่อนเกษตร','อุทัยธานี','อุทัยธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('454a3033-4c71-5b86-bbd1-ef6ed2b5e46b'::uuid,943,'ต046','ตั้งถาวรฟาร์ม','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b0d7c45b-a1e4-5290-85a4-df92616cee25'::uuid,944,'พ0613','พี.เอส.อาร์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('76ee60ba-3d4c-5336-ad16-073633bfc614'::uuid,945,'ก075','กสิวิวัฒน์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('60d3089c-604b-5653-b6ca-170b39b669fd'::uuid,946,'ภ022','ภานุมาศ,กฤษณะภัณฑ์','ชัยนาท','ชัยนาท','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('42835c42-bb1f-5e44-80b1-352b3cabcd29'::uuid,947,'ค050','ครูเล็ก','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('25bdcbe0-f360-586a-af61-3e4fb1d1cb42'::uuid,948,'ณ015','ณัฏฐชัย วานิชย์ธนบดี(กรุงเทพมหานคร) /ณ015','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('44e0bb92-99ec-567c-a997-655801927e99'::uuid,949,'พ135','พิชาญพัสสุ์ สุวรรณสิทธิคชา','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('032d44a4-d933-532c-b666-461b8194483d'::uuid,950,'ก086','กิมแซศรีเทพ 1995','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3fe9d232-0dc4-570e-aabb-89eb6bf4c91a'::uuid,951,'บ0632','บ้านสวนครูเก่ง(เชียงใหม่) /บ0632','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d5539d0b-4da8-5af1-b426-cdf8e1cf2358'::uuid,952,'ค062','ไครอน จำกัด(กรุงเทพมหานคร) /ค062','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3f068741-5b54-581a-9a68-44223d20805c'::uuid,953,'ท0711','ทริปเปิล เอ กรุ๊ป','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('047b75a7-1ad1-579a-b16d-31dc4d050458'::uuid,954,'ภ012','ภัทรชัย เอี่ยมรัตนเมธีกุล','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('65919a38-a35e-55d5-8f44-a3760e0df8e5'::uuid,955,'ภ028','ภรณ์ทิพย์ จรุงจรรยาพงศ์','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('bf974ddf-d26c-57f0-8b53-9ac5edd007f7'::uuid,956,'ก005','เกษตรภัณฑ์','สุรินทร์','สุรินทร์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9000ae92-6e06-5f62-8370-10f22aaab0ef'::uuid,957,'พ085','พัชดา สวัสดิ์ธนาคูณ','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('909ad8fe-6bac-5ffa-aad9-07aa70c2a97d'::uuid,958,'ภ027','ภรณ์ทิพย์ ทองผิว','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d8fd331-ff42-5eba-87d5-fbfcb34fe07e'::uuid,959,'พ183','P.R INTERNATIONAL TRADING (BR NO.WU16985)',NULL,NULL,'c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('adc60770-49d8-57c0-8382-628f18c734fa'::uuid,960,'ร003','รวมเกษตร','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('97a3d1af-5827-5470-bc17-2dcac97a59b2'::uuid,961,'ส211','เสริมทรัพย์(อ่างทอง) /ส211','อ่างทอง','อ่างทอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('12a49709-f987-58f8-b5e8-6579dd051826'::uuid,962,'ป067','ป๋อง พารา ปากคาด','บึงกาฬ','บึงกาฬ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ec1d42e1-f69b-54fb-8fa6-97f83eff12a9'::uuid,963,'ต011','ตันติพงษ์ เทรดดิ้ง จำกัด','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ce28d5dc-d4cb-56b1-9d7d-36fcb0f769ff'::uuid,964,'ม026','มิตรเกษตร','ระนอง','ระนอง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e59705f5-8d13-58df-bc68-f14d9d36428f'::uuid,965,'ส057','แสงสุรีย์การเกษตร','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cc766a21-67b7-58a6-a797-ea3d8a8079ed'::uuid,966,'ล025','เล็ก','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e120785c-6d72-5b22-b83c-2b1a9abb6848'::uuid,967,'ม026','มิตรเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ea969294-e598-5480-bcb8-af0319b6ab78'::uuid,968,'พ078','เพื่อนเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('118a8973-0bce-5c40-89e6-6160c266df9e'::uuid,969,'ช001','ชัยณรงค์ กรพิพัฒน์','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('98b5aaaa-9b6b-5f92-8f32-d8f3ee024187'::uuid,970,'ล039','ลิกมันไลท์ติ้ง จำกัด(ฉะเชิงเทรา) /ล039','ฉะเชิงเทรา','ฉะเชิงเทรา','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d9fa0ebb-00e8-5691-bcf8-86250ab47fc3'::uuid,971,'ร054','รจนา เฮ้าส์ซิ่ง จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4e7bd2eb-e39f-511e-bbbb-b0cdbdf21fce'::uuid,972,'ส053','ส.การช่าง','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('717a6b98-7a7e-5b7e-aa77-4a651a5b7a56'::uuid,973,'ส192','เสือการเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('54b23bf1-e56d-5d20-9170-c2a3a155ec05'::uuid,974,'ท015','ทีเอชเค มาร์เก็ตติ้ง','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c084bfb0-f25a-577d-9dfb-12b31a0e4c61'::uuid,975,'ด033','ดีท๊อป','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8d89186c-7614-5cb1-ba77-70eda161de31'::uuid,976,'ก0082','กรีนพลาน่า จำกัด(นนทบุรี) /ก008','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('74b0ba0b-5634-5711-9f1b-fa031505b1e4'::uuid,977,'ท104','ทวีผล คอร์ปอเรชั่น จำกัด','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6ce4f457-a78a-5859-a732-7d3a51fd7dd5'::uuid,978,'ป007','ปิติภัณฑ์','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ac0dfb2b-1c91-51db-9b8e-91906eff2ed3'::uuid,979,'ท1012','ออลการเกษตร(อุบลราชธานี) /ท1012','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('04ed0f70-1a45-5a4d-9007-10d994440f2f'::uuid,980,'ม070','มหาโชค มหาชัย อินเตอร์เทรด จำกัด(สมุทรสาคร) /ม070','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1529dfe4-e9a7-5d63-a580-80eba75d38a4'::uuid,981,'พ0941','สวนละไม จำกัด(สำนักงานใหญ่)','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('47d0c899-7aa7-59f1-98bc-668f3b15b3b2'::uuid,982,'ม015','เมืองพลอยการไฟฟ้า','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('543c8ae7-d85f-56ba-94e2-4b331f206962'::uuid,983,'ร072','เรืองเจริญการเกษตร(อุบลราชธานี) /ร072','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7923a2b7-ee90-5ce7-99da-0d050996cc2a'::uuid,984,'ร038','โรงพยาบาลสัตว์ลำปาง(อุดมการเกษตร)','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('176f2b87-18ae-58ce-af85-d196b840fc33'::uuid,985,'ร036','เรี่ยวรุ่งโรจน์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c3279edb-1941-5df1-b3eb-3b543c36d59f'::uuid,986,'จ091','Je porch(กัมพูชา) /จ091','กัมพูชา','กัมพูชา','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e64af3f8-24cc-51d3-be9b-3cd41fec627f'::uuid,987,'ก0082','กรีนพลาน่า จำกัด(นนทบุรี) /ก0082','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f34296e3-7bda-5366-b5fa-dc7c3592fa7b'::uuid,988,'พ088','พอเพียง เทคโนโลยี จำกัด (สำนักงานใหญ่)','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2d67e2f1-fba1-54df-a350-836eaf062d31'::uuid,989,'ท087','ไทยสปีดแมชชีนเนอรี่ จำกัด','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('71ed364e-d2c9-51e6-a47d-e42e3aff83cf'::uuid,990,'ส008','ส.รุ่งเรือง(ฉะเชิงเทรา)','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('435ccc82-e16b-5c65-8d45-1fe569fb7adf'::uuid,991,'จ064','จรัญ สีบุตรา','พิษณุโลก','พิษณุโลก','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d09f3a11-1b49-5984-ae1b-a7bfc823f53a'::uuid,992,'จ070','จึงเจริญการเกษตร 2','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6c4b6e6d-0b78-509f-a2df-aa278b7684aa'::uuid,993,'ก104','เกษมพันธ์ จงเจริญคุณวุฒิ','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2139122e-52ff-57dc-ac0f-2d06ab14d974'::uuid,994,'ป052','ปกรณ์การเกษตร','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('64c83f6a-b76b-5cd6-b8de-9e2313a915a2'::uuid,995,'ธ042','ธนาคูณพร็อพเพอร์ตี้ จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6bf65320-5151-5c7e-8c32-1c5af923435c'::uuid,996,'ว079','วิชุดา ลีลารุ่งโรจน์','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4cc769c9-17cd-5143-8c73-6dddc28460a9'::uuid,997,'ท065','ไทยวิทยุ 2556','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ab9dfdf4-4f57-5836-aa87-6f937de14dcc'::uuid,998,'ท008','ไทยสามัคคี','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cb7146e5-ece7-568d-8394-ef7905a8377a'::uuid,999,'จ061','จิบล้งโลหะภัณฑ์','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b4cd054-e8a8-533a-8954-73644b6d4df2'::uuid,1000,'จ069','เจริญซีเมนต์ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6d631726-3908-57d8-b44b-6eac2aedb086'::uuid,1001,'ฮ016','โฮมพลัส สโตร์ จำกัด','มหาสารคาม','มหาสารคาม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b917e51d-48f1-5be0-8c32-272e60bbd6a2'::uuid,1002,'ย021','ยุทธนา พิมพิสาร','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5647add4-dadc-559a-880d-1e3446fc82b0'::uuid,1003,'ช0103','ช.พูนกิจชลบุรี จำกัด(สนง.ใหญ่)-ชลบุรี /ช0103','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4665bd85-bfef-5b51-8042-2aa08d20ed1b'::uuid,1004,'ศ050','ศิรินภา สันทาลุนัย(นครราชสีมา) /ศ050','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6df0cf8d-3c4f-5268-b8c6-7bf9e4f50301'::uuid,1005,'ว081','วิสูตรการเกษตร(พะเยา) /ว081','พะเยา','พะเยา','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3c3bd183-7505-5fae-9e62-b2b707cd08c4'::uuid,1006,'ส0942','ภัชโสภณไปป์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('878c126c-1b1e-5136-811b-a1dade95c6a7'::uuid,1007,'อ1702','ไอเดียล โกลบ จำกัด(กรุงเทพมหานคร) /อ1702','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('151344a7-dcdd-5263-aa96-d97151eeed0f'::uuid,1008,'บ078','บี.พี.ฟิวเจอร์ซีด','อุดรธานี','อุดรธานี','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('941abb0b-1991-5eb9-8f09-58eae7062e6e'::uuid,1009,'ส213','แสงทอง(อุตรดิตถ์) /ส213','อุตรดิตถ์','อุตรดิตถ์','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa42971b-8eb1-5356-aeea-29d31fce013d'::uuid,1010,'พ0702','พี เจ แอนด์ ควอลิตี้ กรุ๊ป จำกัด(กรุงเทพมหานคร) /พ0702','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('24a27854-d0ed-5a1d-99f6-105f2b9fba0e'::uuid,1011,'ภ033','ภัชรวี โสภณกัมพล(กรุงเทพมหานคร) /ภ033','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cf31afbc-045e-5bda-aab6-34a9e5f40656'::uuid,1012,'พ145','พิชญาภร(นนทบุรี) /พ145','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa9332b4-f0e3-5f89-8797-e2d486d28a96'::uuid,1013,'อ140','เอกศิริโฮมเดคคอร์เรชั่น จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e1f0fe87-6afb-5a32-bfcd-7abe6eb98fed'::uuid,1014,'อ195','อีสท์ เวสท์ ซีด จำกัด','นนทบุรี','นนทบุรี','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('abef068e-102e-595e-88ea-b16f53de12df'::uuid,1015,'ว036','วิคตอรี่ สตีล อิมปอร์ต เอ็กซ์ปอร์ต จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2f6b1216-f308-5db3-bcf4-28e8f8ff69c6'::uuid,1016,'น040','นพเก้าวัสดุภัณฑ์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b4896294-87c7-51ce-8ee9-fc644ddf9f31'::uuid,1017,'ศ008','ศรีธานี','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e4fc3acb-8760-5a1d-9f67-6362f76434eb'::uuid,1018,'ถ005','ถุงเงิน พาณิชย์(เลย) /ถ005','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9bdc0e27-58c8-5e53-a467-50e658a8932b'::uuid,1019,'จ068','จิราภาส พงษ์สัมฤทธิ์ผล','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e68f7d66-c6db-5994-a414-2c284a955509'::uuid,1020,'น054','นำชัย(นนทบุรี) /น054','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('524c7117-a8fc-5cc1-a7b3-ba3ca7e9fa01'::uuid,1021,'ช029','เชียงใหม่มณชัยพาณิชย์','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5a25b252-406b-53d9-ab80-30bce8df6968'::uuid,1022,'ส049','สุรินทร์ฮาร์ดแวร์','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e478d167-b4c3-5a9f-9c77-56f936487368'::uuid,1023,'อ1072','เกษตรมีสุข69(เชียงใหม่) /อ1072','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3acd6083-db5f-5edb-8047-aef4412857a1'::uuid,1024,'พ072','ไพศาลเกษตรเคมี จำกัด','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('83549974-28a6-57fd-8f6d-c29a10c4ff92'::uuid,1025,'พ119','เพิ่มพูนการค้าวรนคร','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('487445ed-dbfa-582a-b52b-d15b672a3000'::uuid,1026,'บ077','บัลลังก์ ทูลล์','อุดรธานี','อุดรธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7b7425c1-2186-5145-9291-19bb132e52f6'::uuid,1027,'อ202','เอ็ม อาร์ เอช เทรดดิ้ง จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1a775f2b-2b28-57ca-8296-4d72054d3ddb'::uuid,1028,'ก005','เกษตรภัณฑ์','สงขลา','สงขลา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8e537bf1-02b3-5ae4-8bb4-bccbdff635e5'::uuid,1029,'ศ022','ศราวุธ ทาเหล็ก','พิจิตร','พิจิตร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('79764c3c-513a-5782-a422-2c862d62f60c'::uuid,1030,'ก0842','เกษตรยนต์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f42a17cb-9644-5a7c-b329-c699cf354170'::uuid,1031,'ท1124','แซท เนเจอร์ จำกัด(นครปฐม) /ท1123','นครปฐม','นครปฐม','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('af49c0d0-73ac-505d-8d7d-c01ff9f730db'::uuid,1032,'ท018','ไทยเจริญโลหะภัณฑ์','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a2d598df-600c-5247-988e-73247e379046'::uuid,1033,'ฟ003','โฟลเทคซีดส์ จำกัด','ลำปาง','ลำปาง','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f033e277-53f4-5c7b-a325-1d8ae9bbd04d'::uuid,1034,'จ062','จินอาโอสถ','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2685360e-76a6-58ae-9dff-8fbed96f08ae'::uuid,1035,'ม055','เมเจอร์ฟาร์ คอร์ปอเรชั่น จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cf2c15bc-81ab-544c-b4b3-4d272ce1a054'::uuid,1036,'ค009','เคพี การเกษตร29','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0435c2a3-c41a-5c90-9b3c-77c583ee6a53'::uuid,1037,'ต005','ตี๋การเกษตร','มุกดาหาร','มุกดาหาร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8b2f6596-f24e-5387-aeee-59db311995c0'::uuid,1038,'ภ013','ภูคาคชรัตน์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('14d241b1-47eb-5350-8e71-4325acd3dfec'::uuid,1039,'ส051','สมบัติโอสถการเกษตร จำกัด','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('815da36e-748b-513b-bc13-9b64a976e812'::uuid,1040,'บ067','บ้านใหม่ค้าวัสดุก่อสร้าง','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('00a2be86-92f1-51ff-b884-bfa1258346aa'::uuid,1041,'พ011','แพร่เกษตรพัฒนา','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a8aa7f76-1a28-552e-a428-516154725202'::uuid,1042,'ร073','ร่มไทรฮาร์ดแวร์(ปราจีนบุรี) /ร073','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('37c3dd91-cb6f-5350-9968-3b1a1dd72c53'::uuid,1043,'น012','น.เกษตร ครบุรี','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c57e96f-01d4-558a-872b-2fbb10efdd73'::uuid,1044,'ก047','เกษตรภัณฑ์','สุพรรณบุรี','สุพรรณบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('30e4a552-0096-5cad-8b0b-7941d5aa56b4'::uuid,1045,'ท1124','ไทยเจริญสุกร จำกัด สาขา00001(นครสวรรค์) /ท1124','นครสวรรค์','นครสวรรค์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1720d1c8-3fe4-55e0-b3af-5c4e22d17f4c'::uuid,1046,'พ146','พิษณุ ซัพพลาย(นนทบุรี) /พ146','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ad1b45f0-bcce-598c-b994-e71ba0f4ae8b'::uuid,1047,'บ080','บันไทยการเกษตร','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4b367d64-f9e9-5620-9967-da1776431921'::uuid,1048,'ก083','กินใจ จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('cfeaf4d9-6126-580d-a108-4c988b969c99'::uuid,1049,'ท1012','ออลการเกษตร','อุบลราชธานี','อุบลราชธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fccb174a-4a5d-5d5a-8e31-e785f9d4c374'::uuid,1050,'ธ047','ธนาสันต์ โฆษิตประเสริฐ','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('af6821b3-8ef8-548a-bbdc-fb43f34012c7'::uuid,1051,'ร034','รุ่งเรืองเสาเข็ม(นาย พิศาล เล้าอรุณ)','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('035021ce-3c1e-56fb-b173-eaeadda08a33'::uuid,1052,'ท123','ทรัพย์รุ่งเรืองวัสดุภัณฑ์','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7dd51c9d-03a0-584a-b2d6-c2e766dcc18b'::uuid,1053,'ฤ002','ฤทธิ สตีล(หนองคาย) /ฤ002','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('771e8733-5312-5a9d-9d20-dcea64042f9a'::uuid,1054,'อ1052','เอกพรรณการเกษตร 2019 จำกัด','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('81cda0e3-ef02-543a-841b-1de78f832a9b'::uuid,1055,'ค0322','คิงส์ริช เอ็นจิเนียริ่ง จำกัด(กรุงเทพมหานคร) /ค0322','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('367a38bd-cd49-52a4-9e8d-91f5ab4b223d'::uuid,1056,'ก144','กุลชไม ปัญญา(กรุงเทพมหานคร) /ก144','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('da50c978-5e79-5faf-b034-ad89ae59f7b3'::uuid,1057,'พ187','พระมหาวิชัย(เลย) /พ187','เลย','เลย','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e4661819-3c6a-58cc-b842-133d9a7c48ce'::uuid,1058,'พ116','พิชามญชุ์ บัวเจริญ','ปทุมธานี','ปทุมธานี','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e8c78145-7957-5ae6-b702-f94ef50d6b63'::uuid,1059,'ส188','สุธาทิพย์ คำโสกเชือก','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('151727a1-ffaf-583b-9d1c-f10d9cf97203'::uuid,1060,'ว014','วีระพันธุ์ไม้','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a6de7e2f-890a-5443-89a8-4393307859fb'::uuid,1061,'ภ011','ภูตะวันวัสดุก่อสร้าง(สนง.ใหญ่)','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('db4a9e74-7bf6-59d4-9542-f717b2a82f8a'::uuid,1062,'พ139','พรพรรณค้าวัสดุ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('081b369e-9ddb-5881-b1f7-fc6c99790cc4'::uuid,1063,'พ110','พิษณุโลกระบบน้ำเกษตร(2019)จำกัด','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b29dc30-09d1-532c-9d53-11777b307b53'::uuid,1064,'ค0182','เค.เจ.ที เทรดดิ้ง จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('12494735-40b0-5d80-b9ce-b0bf4de735a3'::uuid,1065,'ธ0253','ฟาร์มก่อสุข จำกัด','พิษณุโลก','พิษณุโลก','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3e1384d4-b343-525b-8bda-2c918a22ac25'::uuid,1066,'ว036','วิคตอรี่ สตีล อิมปอร์ต เอ็กซ์ปอร์ต จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('67909450-8a5a-5f53-aba4-5c97fdda28c8'::uuid,1067,'ง001','เงินสด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('51259e2b-d0bc-5f1e-b3fd-6cf3a60fa244'::uuid,1068,'บ073','เบย์คลังเกษตร','สตูล','สตูล','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('155d5936-3eed-5480-b7c0-339ab5f35206'::uuid,1069,'ป014','ป.เกษตรภัณฑ์ (ชุมพร)','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d9bdc674-edf0-5f0f-ad46-556a6f681b48'::uuid,1070,'บ0452','ธนะสาร เทรดดิ้ง(2015) จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('64862d34-5acd-5980-a5a6-dee4e9b3a32d'::uuid,1071,'ร074','เรณู สารการ(อ่างทอง) /ร074','อ่างทอง','อ่างทอง','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('33b71165-99a5-5899-9cd9-c1f9822c78e8'::uuid,1072,'จ005','เจี่ยเทียมเส็งการเกษตร','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1a9e7d99-7df3-5a1f-94ac-6ce85550e39f'::uuid,1073,'ต049','ต.เจริญก่อสร้าง(นครราชสีมา) /ต049','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('68fc13ea-4df1-5963-a8ac-f898c8e53f59'::uuid,1074,'ก078','เกียรติทวีค้าไม้ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f15144ac-a2a0-5887-b2ba-ce69b43f6533'::uuid,1075,'ต021','ตั้งธนไพศาล จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('8bbf3acf-a910-52e6-a302-8e38b9ce90cf'::uuid,1076,'ว0372','ไวท์ปาร์ตี้ เทรดดิ้ง จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6bc2eac3-ec36-5d08-8288-c4b7abee60bd'::uuid,1077,'ณ014','ณัฐดนัย วิชัยดิษฐ','สุราษฎร์ธานี','สุราษฎร์ธานี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5a434c0d-0a1b-5be7-b55c-99550dc77fc5'::uuid,1078,'อ199','ออฟ มาย เบค จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('64ea9bb0-7777-52f7-a4f6-f86e05a51443'::uuid,1079,'ก087','กู๊ดมอร์นิ่ง อะกริคัลเจอร์ แอนด์ ทูลส์ จำกัด(สนงญ)','ลพบุรี','ลพบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9a39f7e3-3e0a-5476-a1b4-3237dc4a2fb2'::uuid,1080,'พ034','พันธ์ทวี คอร์ปอเรชั่น','ขอนแก่น','ขอนแก่น','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('12e6ceaa-f752-5f21-90ee-5e7db052e47a'::uuid,1081,'จ0412','เจ.เค.ซัพพลาย แอนด์ แมชชีนเนอรี่ จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('44e3c76d-c313-567b-b8ce-46fc343b3ad9'::uuid,1082,'บ016','บางกุ้งเกษตรภัณฑ์(2548)','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d77a2567-d6c4-54ff-9f6e-4aa9b0494dfc'::uuid,1083,'ค048','คิว โอ ยู เทรดดิ้ง จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e8eb4d0d-a5a0-57ac-851e-fcde024ee08d'::uuid,1084,'ย002','ยูเนี่ยน พรีซิชั่น เอ็นจิเนียริ่ง จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('440da09f-3bd6-5838-8e7e-f28d93bb55a4'::uuid,1085,'ว028','เวิลด์ เบสท์ เอนจิเนียริ่ง จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('29261fa1-551e-5807-9acc-7bbe56cf001c'::uuid,1086,'ส154','สนธยา น่วมใย','อยุธยา','พระนครศรีอยุธยา','955a7ad1-973f-50e4-8b12-346a51886fdf'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('277b9237-0877-5b15-91c3-66c3ef2c75bb'::uuid,1087,'พ085','พัชดา สวัสดิ์ธนาคูณ','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('779244dc-41b0-5805-9435-d8fbf34d4855'::uuid,1088,'พ022','พิสิษฐ์ภัณฑ์เชียงราย จำกัด','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f7c9e0b8-cd19-56d2-a73a-c18ed0c69d62'::uuid,1089,'อ198','เอ็นซี เซอร์วิสแอนด์เซลส์ จำกัด','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('618285e5-6214-501a-8fa8-9d56cb5b63a5'::uuid,1090,'ม0511','มณฑา เบทเทอร์เมนท์ จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b0613dd0-ec8f-549c-8c82-e15d749f10cf'::uuid,1091,'ก084','เกษตรยนต์','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e67f95ed-525d-5829-b2c9-97d299001a34'::uuid,1092,'ท081','ทุ่งน้าวการเกษตร','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fe07aa71-a475-5734-a37b-9eefba5deefe'::uuid,1093,'ท062','เทคอิท จำกัด(บิวเดอร์)','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9b91be61-2656-5036-bd4a-7e4e43a55054'::uuid,1094,'ส204','สุริยา ไชยชนะ','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e9050286-4b4a-5af2-aa32-bde5175274b4'::uuid,1095,'ธ002','ธนาพันธุ์(นครพนม)','นครพนม','นครพนม','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1d54daed-8bc8-5d7e-9346-e4bd0ff0dee5'::uuid,1096,'ก015','กำแพงเพชรง่วนฮงหลี','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a9621c5-e395-5c88-994b-ec3003b23bca'::uuid,1097,'ท124','ทิพย์เกษตร 168','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('af8ec69d-7c43-56ba-b8e4-a15955d66a16'::uuid,1098,'ส055','สหพานิชจันดี','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('81d7753d-9c59-584c-93ed-9428c2c4a9bd'::uuid,1099,'ส141','สายบุรีฟาร์ม','ปัตตานี','ปัตตานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3e46f8f9-67a0-50c2-afae-84b856c8a395'::uuid,1100,'จ092','เจ๊ต้อย อุปกรณ์การเกษตร(นนทบุรี) /จ092','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('acc56fe3-5c65-56ca-ab86-1748aaa9a69e'::uuid,1101,'บ063','บ้านสวนครูเก่ง','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('414d6775-d2db-5957-a245-c99a4e362511'::uuid,1102,'ศ022','ศราวุธ ทาเหล็ก','พิจิตร','พิจิตร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0fad2487-7ab4-55e2-918c-09080c8711ea'::uuid,1103,'ธ042','ธนาคูณพร็อพเพอร์ตี้ จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c0e68768-cfe4-5f0b-9ef1-2ed190c8b5b0'::uuid,1104,'ร049','เรืองพรวัสดุ','เลย','เลย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fe2535ba-a97e-5076-b25e-b23f08fca2e6'::uuid,1105,'ธ003','ธนาคูณกรุงเทพ (2001) จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('69cbf5a0-f6e8-5e88-b14e-ceb553051509'::uuid,1106,'ร054','รจนา เฮ้าส์ซิ่ง จำกัด','กทม.','กรุงเทพมหานคร','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f852dc55-7cb0-5388-9cd6-e11a23af656d'::uuid,1107,'จ088','โจ้ การค้า','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5d0c18e1-cce6-5b07-bf6d-33d7dcb922e1'::uuid,1108,'ด0081','ดี ไอ โอ กรีนคลีนนิ่ง','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7be7633a-bd98-5a32-b5dc-74b0a7e14ba0'::uuid,1109,'ส0653','ดี แอนด์ ดี สิริ','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('633d95fb-8a7f-5d4c-8bf0-a6df0645882b'::uuid,1110,'ส067','สหภัณฑ์','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ac440fa8-abf9-5f3b-bee0-7c0d67ba129b'::uuid,1111,'ฮ015','ไฮโฮมเวิลด์ จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('34365ebd-b23a-500e-8724-7516ebb3225e'::uuid,1112,'ว034','วันดี','เพชรบูรณ์','เพชรบูรณ์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4861fed6-c172-528b-b0cc-c24bb30d8144'::uuid,1113,'ภ028','ภรณ์ทิพย์ จรุงจรรยาพงศ์','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6f8e8d81-2500-5783-8604-f9eda56f51f4'::uuid,1114,'ช0211','สุขสรรค์ ไชยโชค(โชคพิทักษ์)','อุดรธานี','อุดรธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d772b6af-2727-5ba6-9e56-ce47edbe8bdf'::uuid,1115,'ค054','คิววัสดุ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('466c37f4-b26c-5cf5-87e3-a4f44cf08bf8'::uuid,1116,'ภ012','ภัทรชัย เอี่ยมรัตนเมธีกุล','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0de55e52-5da7-516c-9989-04d5fc957b3d'::uuid,1117,'ว069','วี เอ็น โปรดักส์','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9c693d8d-3973-5100-8b48-a14592bdeea6'::uuid,1118,'ม041','เม้งเจริญ','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f6777347-3245-586b-b30c-a403ce319794'::uuid,1119,'ด038','ดีไอที โฮมโปรดักส์ จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('0b74f00c-6a3c-5418-b904-e28c5dbaff4f'::uuid,1120,'บ069','บีเอ็ม แอนด์ เบนซ์ ค้าวัสดุ','อยุธยา','พระนครศรีอยุธยา','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('6adaa6f0-5505-587c-a8b1-547a7085f127'::uuid,1121,'ค009','เคพี การเกษตร29','ศรีสะเกษ','ศรีสะเกษ','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d4085a3e-705e-591e-a69b-d55f6fadef82'::uuid,1122,'ด019','ดวงตะวัน พิมพ์ดี','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fa7e5709-710a-5f73-9f33-3b16bec918a1'::uuid,1123,'ป068','ปลูกทรัพย์พันธุ์ไม้(ชุมพร) /ป068','ชุมพร','ชุมพร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('aa95d8c1-5420-55cc-a7c9-9f418a176b16'::uuid,1124,'ส201','ส.พาณิชย์ ทุ่งยาว','ตรัง','ตรัง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2b6bce57-0a09-59ae-b5c2-4441e5095608'::uuid,1125,'ป052','ปกรณ์การเกษตร','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('847082aa-3258-5cc7-9c8c-36e92b9d13b0'::uuid,1126,'ร036','เรี่ยวรุ่งโรจน์','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2033740f-fd17-5dbf-a310-96b165be44f6'::uuid,1127,'ส053','ส.การช่าง','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7c789619-7117-5690-b097-1fc1ddce9119'::uuid,1128,'อ111','เอ็ม.โฟร์.การเกษตร','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1c3bf8d8-47f0-550a-b6fe-a4fb5ce1903d'::uuid,1129,'ค0401','โคกสูงพัฒนา จำกัด','สระแก้ว','สระแก้ว','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9d851143-ef04-5072-ae02-5c7628dc5616'::uuid,1130,'ม062','มาสเตอร์เวิร์ค ไดเรคท์','นครราชสีมา','นครราชสีมา','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('ff0b56c5-2a9b-5f1e-9fa4-725e97484068'::uuid,1131,'ม068','มีโชคการเกษตร','กำแพงเพชร','กำแพงเพชร','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b3289612-410b-50ca-99f2-70ecee9bdb59'::uuid,1132,'ส096','สุเกียว (สำนักงานใหญ่)','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('25957ebf-2396-5e89-bba8-8623e09e91d9'::uuid,1133,'ฟ004','เฟื่องศักดิ์วัฒน์','นครศรีธรรมราช','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1919036c-8401-50a8-bfa2-c2a056ab7eee'::uuid,1134,'ท1061','ไทโยแปซิฟิก จำกัด','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('79906fe9-ecb0-5871-abc6-cd6e78534254'::uuid,1135,'ม012','มารุ่งเรือง','สุรินทร์','สุรินทร์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('615647b2-0975-5af0-bcbf-3d9181954b9d'::uuid,1136,'ผ0022','บ้านเกษตร(ประจวบคีรีขันธ์) /ผ0022','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b9821348-dfe7-5920-b40e-9edbc8b94376'::uuid,1137,'ก140','เก็บทรัพย์ จำกัด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('342b4ef5-f49c-5c25-9af8-32d4b9627697'::uuid,1138,'ง001','เงินสด','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('39750774-281b-5dda-9de8-934e755122f5'::uuid,1139,'ด0042','แดงเคมีเกษตร(เพชรบุรี) /ด0042','เพชรบุรี','เพชรบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('da210c11-985b-5fb0-835d-830a1544e4d7'::uuid,1140,'บ080','บันไทยการเกษตร','กระบี่','กระบี่','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4f601140-15d2-5cfd-b188-b07505e8cdeb'::uuid,1141,'ศ015','ศิริชัยเกษตรภัณฑ์','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('f1683a3b-a03b-5c82-ba6e-44f0fb043476'::uuid,1142,'ส074','สหไพบูลย์','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4948de5b-4699-54cf-8886-13282cb782cf'::uuid,1143,'ก1162','หงษ์ทองแตงโม จำกัด(ปทุมธานี) /ก1162','ปทุมธานี','ปทุมธานี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('18a0a778-6912-546c-a0c2-68f574e3bf49'::uuid,1144,'ย0121','เจ้าสัวเกษตร จำกัด','สระบุรี','สระบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('faf4ff53-20bc-5852-b418-e1622de8fd7d'::uuid,1145,'ว010','วุฒิภัณฑ์การเกษตร','มุกดาหาร','มุกดาหาร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('e097b00e-9ffb-5fda-b2dc-9cd325280b24'::uuid,1146,'ค055','คุ้นการเกษตร','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7ee80fb4-32cd-52e5-a52c-421a5b53ee59'::uuid,1147,'ว002','วิเชียรการเกษตร','หนองคาย','หนองคาย','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7e0236de-be78-5489-a7fe-b40bf45c2b5f'::uuid,1148,'น055','เน้งการเกษตร2(แพร่) /น055','แพร่','แพร่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('a989b13b-6a94-56b8-9518-497ad5f8c5b2'::uuid,1149,'จ069','เจริญซีเมนต์ จำกัด','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b04202eb-e768-50bb-b444-29b41b39858d'::uuid,1150,'ม065','มงคลชัย','ปราจีนบุรี','ปราจีนบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1bcb6eee-85c9-5a26-93af-ad3c0c8b4c7d'::uuid,1151,'พ008','พัฒนาการช่าง(บขส)','สกลนคร','สกลนคร','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('55b8dd8a-da2d-56b1-a5f4-17fbf0bbad98'::uuid,1152,'จ081','เจริญพักตร์ วิศวกรรม จำกัด','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1491e93a-b4f3-574e-95c4-dfaf84ee08d7'::uuid,1153,'จ0033','ระคุ แอนด์ โกรว์ สตูดิโอ จำกัด(ชลบุรี) /จ0033','ชลบุรี','ชลบุรี','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('134d7b6a-8fe4-537d-8b9d-ad59cc341684'::uuid,1154,'พ007','พันธุ์เจริญ','ลำปาง','ลำปาง','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('afb72072-4b4b-5a34-a96e-f5af0f88de5c'::uuid,1155,'ส069','เสรีภู่พิสิฐ','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('82c498c2-f259-5b7c-baa2-018c33b94379'::uuid,1156,'อ1051','ไพรินทร์การเกษตร','กาญจนบุรี','กาญจนบุรี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2a5fcbee-1a7f-554a-ba8d-04158c209f4a'::uuid,1157,'ว017','วี อาร์ วอเตอร์ ซีสเต็มส์ จำกัด','สมุทรปราการ','สมุทรปราการ','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('77088b10-18d8-5075-a252-15f09a673e26'::uuid,1158,'ค043','ครูว์ ดีบิวด์ จำกัด','กทม.','กรุงเทพมหานคร','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d0c2c4a6-402d-55c9-8d82-305cb3c012f5'::uuid,1159,'อ204','เอสเคทีเอ็น คอนสตรัคชั่น(อันดามัน)จำกัด(ภูเก็ต) /อ204','ภูเก็ต','ภูเก็ต','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('71551f84-ef87-5ebd-8303-7dc370b0e55f'::uuid,1160,'น0082','นิเวศการเกษตร(วังหว้า)','ระยอง','ระยอง','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('01d5f84d-57e7-5237-a3ec-28ccb777e52d'::uuid,1161,'ก112','แกลสซี่แลนด์ จำกัด','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3e0a3ae7-c6be-50ae-9130-c63f6fccc4f4'::uuid,1162,'ม070','มหาโชค มหาชัย อินเตอร์เทรด จำกัด(สมุทรสาคร) /ม070','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('b556b5cb-e988-5461-a0db-59e43eef4959'::uuid,1163,'ก1142','แสงทิพย์การค้า 888 จำกัด(สมุทรสาคร) /ก1142','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('21d1ad76-7574-589c-84b8-52d15900f5e8'::uuid,1164,'อ0861','ทวีศักดิ์การเกษตร','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d2afa18c-98fe-51c4-b54e-d31038b7f04d'::uuid,1165,'ซ0073','เซเว่นซี ค้าส่ง จำกัด สาขาที่ 00002','พังงา','พังงา','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('84369890-2304-5968-b9dc-0bbf84174d3f'::uuid,1166,'ส133','สินเสถียรอะไหล่','ระนอง','ระนอง','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5d6dabdc-cce1-58b5-8e2d-85c014608231'::uuid,1167,'อ0952','โอเคซัพพลาย หาดใหญ่ จำกัด(สนญ.)','สุราษฎร์ธานี','สุราษฎร์ธานี','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3c6919e7-0d7c-517f-819a-4934901c3aa4'::uuid,1168,'อ0523','กรีน ซีดส์ จำกัด','สกลนคร','สกลนคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('2aa607c2-80f1-5824-bccc-3d702ef48dab'::uuid,1169,'ว0362','วิคตอรี่ สตีล อิมปอร์ต เอ็กซ์ปอร์ต จำกัด(สมุทรสาคร) /ว0362','สมุทรสาคร','สมุทรสาคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('1b9bfa42-cc8b-5606-ac47-2d7f99de6418'::uuid,1170,'ธ040','ธัญมนการเกษตร','เชียงราย','เชียงราย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('db4f01ef-ce1d-51b5-ac78-597bc5d3a348'::uuid,1171,'ว082','วิภาวี จามมาลา(กรุงเทพมหานคร) /ว082','กทม.','กรุงเทพมหานคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d27fbc10-7715-5848-80bd-edf5d32a0467'::uuid,1172,'อ192','เอกพร โตสวน','นนทบุรี','นนทบุรี','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('73c4f85c-b33c-54c6-b434-1b49413b9616'::uuid,1173,'ส174','สหเซวา จำกัด','ประจวบคีรีขันธ์','ประจวบคีรีขันธ์','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('3a6087ae-4408-5d5b-ba2f-a9c9afa604ee'::uuid,1174,'ภ027','ภรณ์ทิพย์ ทองผิว','นนทบุรี','นนทบุรี','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5fa3cd6b-852a-5d7b-83a7-74d159f96613'::uuid,1175,'ซ025','ซีเอส พลัส กรุ๊ปส์ จำกัด(สมุทรสาคร) /ซ025','สมุทรสาคร','สมุทรสาคร','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('fac4d05c-7b39-5ccb-b90a-fd2bd59658ee'::uuid,1176,'ว0362','วิคตอรี่ สตีล อิมปอร์ต เอ็กซ์ปอร์ต จำกัด(สมุทรสาคร) /ว0362','สมุทรสาคร','สมุทรสาคร','4efef0a9-4a63-541d-8d4e-7914d647bcf9'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('d19e388e-0d53-5f96-9450-975d36459197'::uuid,1177,'ส056','สวนอิ่มผล(ร้านเอฟ 242','เชียงใหม่','เชียงใหม่','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('9f2644f2-7623-5e47-b6f5-378542417cdb'::uuid,1178,'ป061','ปังแป๊ะเฮง','น่าน','น่าน','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c7746fd4-ac11-5ee2-abe2-8a270020d2da'::uuid,1179,'ร075','รุ่งเรืองยางพารา 888(พิษณุโลก) /ร075','พิษณุโลก','พิษณุโลก','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('7f777d63-70d2-5348-a2ab-36b6784f6e3f'::uuid,1180,'ก092','เกาะรุ้งเกษตรภัณฑ์','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('913c76a9-c855-57b7-b2ec-61697fea9036'::uuid,1181,'ฟ004','เฟื่องศักดิ์วัฒน์','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('480891e8-d55c-55f0-a231-d268bad62572'::uuid,1182,'ส192','เสือการเกษตร','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('5d320f4e-6791-580b-a700-cc53c18464c6'::uuid,1183,'ว077','วิชาญเภสัช','บุรีรัมย์','บุรีรัมย์','6a445fea-5b89-5189-a55a-a58b0f22f5c3'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('46f15844-586c-58f7-8381-dfc69b04ab7b'::uuid,1184,'ศ037','ศรายุทธเครื่องตัดหญ้า','นครศรีฯ','นครศรีธรรมราช','e5e246ce-f117-51d4-8f08-a5fc69fd5ab2'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c299a979-bad4-593b-9ca7-92d714ea3c4d'::uuid,1185,'ส143','แสงไทยผลิตยาง จำกัด','สมุทรปราการ','สมุทรปราการ','c03a7c5e-ccc8-559d-9223-3379b540f53d'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('4e9eba4c-0ff5-538f-8882-39a068676a01'::uuid,1186,'ร010','รวมเกษตร','นครสวรรค์','นครสวรรค์','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('c19a3946-72d9-5bc8-b740-0340256c609f'::uuid,1187,'จ0382','เจริญพานิช กรุ๊ป จำกัด','สุโขทัย','สุโขทัย','7fea3301-3316-5e1c-836f-580d9df9bd24'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
insert into public.customers(id,source_row,client_id,client_name,province_raw,province_normalized,salesperson_id,is_active)
values ('29e1cd9a-dd66-5e4b-8797-fc1b46c96f14'::uuid,1188,'ช0103','ช.พูนกิจชลบุรี จำกัด(สนง.ใหญ่)-ชลบุรี /ช0103','ชลบุรี','ชลบุรี','d514d255-8b82-5710-971c-847c445bdc43'::uuid,true)
on conflict(id) do update set client_id=excluded.client_id,client_name=excluded.client_name,province_raw=excluded.province_raw,province_normalized=excluded.province_normalized,salesperson_id=excluded.salesperson_id,is_active=true;
commit;
