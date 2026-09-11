# PVT USP Survey Web

ระบบเว็บแบบสอบถามออนไลน์สำหรับ **P.V.T. & T Plas Co., Ltd. — ตราต้นไม้**

เวอร์ชันนี้ทำครบ Flow หลักที่คุยกัน:

- Login เซลล์ / Admin / Management
- ฐานข้อมูลร้านค้า → เซลล์ → จังหวัด/พื้นที่
- เซลล์กรอกแบบสอบถามทันทีหลังเยี่ยมลูกค้า
- ร้านค้ากรอกแบบประเมินเองผ่าน **ลิงก์เฉพาะร้าน / QR Code โดยไม่ต้อง Login**
- เลือก/ล็อกสินค้าที่ต้องการประเมินได้
- Campaign รายรอบ เช่น Q3/2026
- สถานะลิงก์: สร้างแล้ว → เปิดแล้ว → ตอบแล้ว / หมดอายุ
- Dashboard กรอง Campaign / สินค้า / เซลล์ / จังหวัด
- แสดง NPS Score (สเกล 1–5 ตามเอกสาร)
- Export ผลสำรวจเป็น CSV
- Admin สร้างบัญชีเซลล์และผูกกับชื่อเซลล์จากฐานลูกค้า
- RLS แยกสิทธิ์: เซลล์เห็นเฉพาะร้านของตน, Management/Admin เห็นภาพรวม

## ข้อมูลที่เตรียมมาให้แล้ว

จาก Excel ต้นทาง:

- ลูกค้า **1,187 แถว**
- เซลล์/ผู้รับผิดชอบ **7 ค่า**
- เก็บข้อมูลจาก Excel ครบใน `supabase/03_seed_sales_customers.sql`
- มีไฟล์ CSV สำรองใน `data/customers_seed.csv`
- **ไม่ลบรหัสลูกค้าซ้ำอัตโนมัติ** เพราะบางรหัสมีสาขา/ชื่อ/จังหวัดต่างกัน
- มีรายงานตรวจข้อมูลใน `data/DATA_QUALITY.md`

จากแบบสอบถาม 30 หน้า:

- 8 กลุ่มสินค้า
- Q1–Q5 ครบ
- แยก Dealer / ร้านค้า กับ เกษตรกรตามต้นฉบับ
- `ถุงเพาะชำ` และ `ถุงเอนกประสงค์` ใช้ชุด Dealer เท่านั้นตามต้นฉบับ
- Seed คำถามทั้งหมดอยู่ใน `supabase/02_seed_products_questions.sql`

---

# โครงสร้างไฟล์

```text
PVT_USP_Survey_Web/
├─ index.html                 # Login
├─ sales.html                 # หน้าของเซลล์
├─ survey.html                # เซลล์กรอกหลังเยี่ยม
├─ public-survey.html         # ร้านค้ากรอกเองจาก Token / QR
├─ admin.html                 # Dashboard + Campaign + ร้านค้า + User
├─ assets/
│  └─ styles.css
├─ js/
│  ├─ config.js               # ต้องใส่ Supabase URL + anon key
│  ├─ config.example.js
│  ├─ utils.js
│  ├─ supabase-client.js
│  ├─ auth.js
│  ├─ survey-renderer.js
│  ├─ login.js
│  ├─ sales.js
│  ├─ survey.js
│  ├─ public-survey.js
│  └─ admin.js
├─ supabase/
│  ├─ 01_schema.sql
│  ├─ 02_seed_products_questions.sql
│  ├─ 03_seed_sales_customers.sql
│  ├─ 04_bootstrap_admin.sql
│  ├─ config.toml
│  └─ functions/admin-create-user/index.ts
└─ data/
   ├─ customers_seed.csv
   ├─ sales_people_seed.csv
   └─ DATA_QUALITY.md
```

# วิธีติดตั้ง

## 1. สร้าง Supabase Project

แนะนำให้สร้าง Project แยกสำหรับระบบ Survey เพื่อไม่ให้กระทบระบบอื่น

จากนั้นไปที่ **SQL Editor** แล้วรันตามลำดับ:

1. `supabase/01_schema.sql`
2. `supabase/02_seed_products_questions.sql`
3. `supabase/03_seed_sales_customers.sql`

> ไฟล์ 03 มีลูกค้า 1,187 แถว จึงยาวเป็นปกติ

## 2. สร้าง Admin คนแรก

ไปที่:

**Supabase → Authentication → Users → Add user**

ตัวอย่าง:

```text
Email: admin@pvt.local
Password: ตั้งรหัสผ่านที่ต้องการ
```

Copy UUID ของ user ที่สร้าง

เปิด:

`supabase/04_bootstrap_admin.sql`

แทน:

```sql
'YOUR_AUTH_USER_UUID'
```

ด้วย UUID จริง แล้ว Run

หลังจากนั้น Login หน้าเว็บด้วย:

```text
Username: admin
Password: รหัสที่ตั้ง
```

ระบบจะเติม `@pvt.local` ให้อัตโนมัติ

## 3. Deploy Edge Function สำหรับสร้าง User

ติดตั้ง Supabase CLI แล้ว:

```bash
supabase login
supabase link --project-ref YOUR_PROJECT_REF
supabase functions deploy admin-create-user
```

Supabase Edge Function ใช้ `SUPABASE_SERVICE_ROLE_KEY` ฝั่ง Server เท่านั้น

**ห้ามใส่ Service Role Key ในไฟล์ JavaScript หน้าเว็บ**

## 4. ตั้งค่าเว็บให้เชื่อม Supabase

เปิด:

`js/config.js`

แก้เป็น:

```js
window.PVT_SURVEY_CONFIG = {
  SUPABASE_URL: "https://xxxx.supabase.co",
  SUPABASE_ANON_KEY: "YOUR_ANON_KEY",
  PUBLIC_BASE_URL: window.location.origin
};
```

ค่าทั้งสองเอาจาก:

**Supabase → Project Settings → API**

ใช้ **anon / publishable key** เท่านั้น

## 5. Deploy Cloudflare Pages

เอาโฟลเดอร์นี้ขึ้น GitHub แล้วสร้าง Cloudflare Pages Project

ค่าที่แนะนำ:

```text
Framework preset: None
Build command: (เว้นว่าง)
Build output directory: .
```

หลัง Deploy ให้ตรวจว่า:

```text
https://โดเมนของคุณ/index.html
https://โดเมนของคุณ/public-survey.html
```

เปิดได้

## 6. สร้างบัญชีเซลล์

Login ด้วย Admin → เมนู **ผู้ใช้งาน**

กรอก:

- Username
- ชื่อแสดงผล
- Password เริ่มต้น
- Role = `sales`
- เลือกชื่อเซลล์ที่ต้องการผูก

ระบบจะสร้าง User ใน Supabase Auth และผูก `salesperson_id`

เซลล์จึงเห็นเฉพาะร้านที่อยู่ใต้ชื่อของตน

## 7. สร้าง Campaign

Admin → **Campaign**

ตัวอย่าง:

```text
ชื่อ: USP Q3/2026
เริ่ม: 2026-07-01
สิ้นสุด: 2026-09-30
Active: ✓
```

## 8. เซลล์ใช้งาน

หน้า `sales.html`

เซลล์สามารถ:

1. กรองจังหวัด
2. ค้นหาร้าน
3. กด **กรอกหลังเยี่ยม** → เลือกสินค้า → Dealer/เกษตรกร → กรอก Q1–Q5
4. หรือกด **ส่งให้ร้านประเมิน**
5. เลือก Campaign
6. เลือกสินค้าไว้ล่วงหน้า หรือให้ร้านเลือกเอง
7. ระบบสร้าง **ลิงก์ + QR Code**
8. Copy ลิงก์ส่ง LINE ร้านค้า

## 9. ร้านค้าใช้งาน

ร้านเปิดลิงก์ เช่น:

```text
https://survey.example.com/public-survey.html?token=xxxxxxxx
```

ระบบรู้ร้าน / จังหวัด / Campaign จาก Token

ร้าน:

- ไม่ต้อง Login
- ไม่ต้องกรอกรหัสลูกค้า
- เลือกสินค้า (ถ้าเซลล์ไม่ได้ล็อกไว้)
- ตอบแบบประเมิน
- ส่งได้ 1 ครั้งต่อลิงก์

เมื่อส่งแล้วสถานะ Invite = `completed`

---

# โครงสร้างคำตอบ

ระบบเก็บคำตอบแบบ Dynamic:

- Q1 Checkbox → JSON selected options
- Q2 Rating Grid → คะแนนแต่ละหัวข้อ 1–5
- Q3 Single choice
- Q4 Single choice
- Q5 Scale 1–5

Q5 ถูกเก็บซ้ำไว้ที่ `survey_responses.nps_score` เพื่อใช้ทำ Dashboard ได้เร็ว

ตามแบบสอบถามนี้ระบบจัดกลุ่ม:

```text
4–5 = Promoter
3   = Passive
1–2 = Detractor
```

> นี่เป็นการใช้คำว่า NPS ตามเอกสารต้นทาง ซึ่งเป็นสเกล 1–5

# Security ที่ใส่มาให้

- ร้านค้าไม่สามารถ Query ตารางลูกค้าโดยตรง
- Public Link ใช้ RPC แบบ `SECURITY DEFINER` และเปิดเผยเฉพาะข้อมูลที่จำเป็น
- Token สุ่ม 24 bytes
- เซลล์มี RLS เห็นเฉพาะร้านของตน
- Management อ่านภาพรวม
- Admin จัดการ Campaign / User
- Service Role ใช้เฉพาะ Edge Function
- `_headers` มี Security Headers สำหรับ Cloudflare Pages

# หมายเหตุข้อมูลต้นทาง

ดูรายละเอียดที่:

`data/DATA_QUALITY.md`

มีข้อมูล 13 แถวที่ไม่ระบุจังหวัด และพบ Client_ID ซ้ำหลายรายการ ระบบจึงเก็บทุกแถวไว้ก่อน ไม่รวม/ลบเอง

## จุดที่ควรยืนยันกับเจ้าของแบบสอบถาม

ในส่วน **ท่อ PE / Dealer หน้า 19** ต้นฉบับมีข้อความวิเคราะห์เกี่ยวกับ “มาตรฐาน มอก./TIS” แต่ Q1 ที่แสดงไม่มีตัวเลือกนี้ ขณะที่ Q2 มีหัวข้อ “มาตรฐาน มอก. / TIS ชัดเจน”

ใน Seed นี้:
- ไม่เพิ่ม TIS เข้า Q1 เอง
- คงหัวข้อ TIS ใน Q2
- ใส่หมายเหตุไว้ใน `analysis_hint`

เพื่อไม่แก้เจตนาของต้นฉบับโดยเดา

# ทดสอบก่อนใช้จริง

แนะนำทดสอบครบ 4 กรณี:

1. Admin Login
2. Sales Login และเห็นเฉพาะร้านตัวเอง
3. Sales กรอกแบบสอบถาม 1 ชุด
4. สร้าง Public Link → เปิดโหมดไม่ Login → ร้านตอบ → Dashboard เห็นผล

เมื่อ 4 ขั้นผ่านค่อยเริ่มส่งลิงก์จริง
