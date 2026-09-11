# Checklist ก่อนเปิดใช้งานจริง

- [ ] รัน 01_schema.sql
- [ ] รัน 02_seed_products_questions.sql
- [ ] รัน 03_seed_sales_customers.sql
- [ ] สร้าง Admin ใน Supabase Auth
- [ ] รัน 04_bootstrap_admin.sql
- [ ] Deploy Edge Function admin-create-user
- [ ] ใส่ SUPABASE_URL และ ANON KEY ใน js/config.js
- [ ] Deploy Cloudflare Pages
- [ ] สร้างบัญชีเซลล์และผูกชื่อเซลล์
- [ ] ตรวจ 13 ร้านที่ไม่มีจังหวัด
- [ ] ตรวจ Client_ID ซ้ำตาม data/DATA_QUALITY.md
- [ ] สร้าง Campaign แรก
- [ ] ทดสอบ Sales Survey
- [ ] ทดสอบ Public Shop Survey
- [ ] ทดสอบ QR Code / Copy Link
- [ ] ทดสอบ Dashboard และ Export CSV
