---
title: "เจาะลึกการสร้าง LINE OA บรอดแคสต์ธุรกิจ ด้วย Messaging API, LINE Login และ LIFF"
date: 2026-07-04 00:02:00 +0700
categories: [Engineering]
tags: [line-oa, messaging-api, line-login, liff, webhook, rich-menu, chatbot]
slides: true
---

{% include slide-link.html %}

## TL;DR

การเชื่อม LINE Official Account (OA) เข้ากับระบบธุรกิจต้องตั้งค่าผ่าน [LINE Developers Console](https://developers.line.biz/console/) ใน 3 ส่วนหลัก: **Messaging API** (Channel ID/Secret/Access Token + Webhook สำหรับแชตบอทและบรอดแคสต์), **LINE Login** (Callback URL สำหรับล็อกอินด้วยบัญชี LINE), และ **LIFF** (Endpoint URL สำหรับเปิดเว็บแอปในแอป LINE) — สุดท้ายนำ LIFF URL ไปผูกกับปุ่มบน **Rich Menu** เพื่อให้ผู้ใช้กดเข้าเว็บ/แดชบอร์ดจากหน้าแชตได้ทันทีโดยไม่ต้องล็อกอินซ้ำ

## Background / Why this matters

ธุรกิจไทยจำนวนมากใช้ LINE เป็นช่องทางหลักในการสื่อสารกับลูกค้า เพราะ LINE OA มีฐานผู้ใช้กว้างและลูกค้าเปิดแอปอยู่แล้วในชีวิตประจำวัน การบรอดแคสต์ข้อความ โปรโมชั่น หรือแจ้งเตือนผ่าน LINE OA จึงมี engagement สูงกว่าอีเมลหรือ SMS มาก แต่การจะทำให้ระบบธุรกิจ (เว็บจองคิว ระบบสมาชิก แดชบอร์ดร้าน) "คุย" กับ LINE ได้จริง ต้องอาศัยการเชื่อมต่อ API เบื้องหลังที่ถูกต้อง ไม่ใช่แค่เปิด LINE OA Manager แล้วพิมพ์ข้อความส่งเอง

จุดที่ทำให้มือใหม่สับสนคือ LINE แยกฟีเจอร์ออกเป็นคนละ "Channel" กัน — Messaging API สำหรับบอท, LINE Login สำหรับยืนยันตัวตน, และ LIFF สำหรับเว็บแอปที่รันอยู่ในแอป LINE — แต่ละ Channel มีค่า config และ URL ที่ต้องตั้งแยกกัน ถ้าตั้งผิด endpoint หรือใช้ LIFF ID ข้าม Channel จะเจอ error `invalid liff id` หรือ webhook verify ไม่ผ่านทันที การเข้าใจภาพรวมทั้ง 4 ส่วนนี้ก่อนลงมือตั้งค่าจะช่วยลดเวลาแก้บั๊กได้มาก

## Deep Dive

### 1. Messaging API Channel: หัวใจของแชตบอตและบรอดแคสต์

การใช้ Messaging API ต้องเริ่มจากสร้าง [LINE Official Account](https://developers.line.biz/en/glossary/#line-official-account) ก่อน แล้วเปิดใช้งาน Messaging API ผ่าน [LINE Official Account Manager](https://manager.line.biz/) ซึ่งระบบจะสร้าง Channel ให้อัตโนมัติใน LINE Developers Console [1]

ค่าที่ต้องดึงมาใช้งานคู่กับระบบธุรกิจมี 3 ตัว:

- **Channel ID** และ **Channel Secret** — รหัสประจำ Channel สำหรับยืนยันตัวตนของแอปพลิเคชันกับ LINE Platform [2]
- **Channel Access Token** — โทเคนที่ใช้เรียก Messaging API จริง มี 4 ประเภทต่างกันที่อายุการใช้งาน: token แบบกำหนดวันหมดอายุเอง (สูงสุด 30 วัน, ออกได้ 30 ตัว), stateless token (15 นาที, ออกได้ไม่จำกัด), short-lived token (30 วัน, ออกได้ 30 ตัว) และ **long-lived token** (ไม่มีวันหมดอายุ, ออกได้ 1 ตัวต่อ Channel) [3] — สำหรับงานบรอดแคสต์ทั่วไป นิยมใช้ long-lived token เพราะไม่ต้อง refresh
- **Webhook URL** — endpoint บนเซิร์ฟเวอร์ของธุรกิจที่รอรับ event จาก LINE เช่น ข้อความที่ลูกค้าทัก, follow/unfollow, postback จาก Rich Menu ต้องเป็น HTTPS พร้อม SSL/TLS certificate ที่ browser ทั่วไปเชื่อถือ (self-signed ใช้ไม่ได้) และต้องกด **Verify** ให้ผ่านหลังตั้งค่าและเปิด "Use webhook" [1][4]

### 2. LINE Login: ระบบล็อกอินด้วยบัญชี LINE

ถ้าต้องการให้ผู้ใช้ล็อกอินด้วยบัญชี LINE (เพื่อดึงโปรไฟล์หรืออีเมล) ต้องสร้าง Channel ประเภท **LINE Login** แยกต่างหากจาก Messaging API Channel [5] หัวใจของการตั้งค่าคือ **Callback URL** — เมื่อผู้ใช้ยืนยันตัวตนผ่าน LINE สำเร็จ ระบบ LINE จะ redirect กลับมาที่ Callback URL นี้พร้อม authorization code และค่า `state` เพื่อให้เว็บแอปแลก code เป็น access token ต่อไป [5] LINE Login รองรับหลาย Callback URL ต่อ Channel เดียว (เพิ่มทีละบรรทัดใน Console) และใช้ flow ตามมาตรฐาน OAuth 2.0 authorization code grant + OpenID Connect [5]

### 3. LIFF: เปิดเว็บแอปในแอป LINE โดยไม่ต้องล็อกอินซ้ำ

LIFF (LINE Front-end Framework) คือแพลตฟอร์มเว็บแอปที่รันอยู่ภายในแอป LINE ผ่าน "LIFF browser" (ใช้ WKWebView บน iOS และ Android WebView บน Android) — จุดเด่นคือดึงข้อมูลผู้ใช้ (เช่น LINE user ID) ได้ทันทีโดยไม่ต้องให้ผู้ใช้ล็อกอินซ้ำ เพราะรันอยู่ในบริบทของแอป LINE อยู่แล้ว [6]

การสร้าง LIFF App ทำภายใต้ LINE Login Channel ที่มีอยู่ ค่าที่ต้องตั้งคือ:

- **Endpoint URL** — หน้าเว็บจริงของระบบธุรกิจ (เช่น หน้าจองคิว, หน้าแดชบอร์ด) ต้องเป็น HTTPS และ path ต้องตรงกับที่ deploy จริงเป๊ะ เพราะ `liff.init()` จะทำงานเฉพาะกับ URL ที่ตรงกับ endpoint หรืออยู่ level ต่ำกว่าเท่านั้น [6]
- **LIFF ID → LIFF URL** — หลังสร้าง LIFF App และกำหนด scope (เช่น `openid`, `profile`) แล้ว ระบบจะออก LIFF ID มาให้ แปลงเป็น LIFF URL รูปแบบ `https://liff.line.me/{LIFF_ID}` เพื่อแจกจ่ายให้ผู้ใช้กด [6]
- ขนาดหน้าจอ LIFF (Full/Tall/Compact) ตั้งได้ตอนเพิ่ม LIFF App เข้า Channel

แนวทางที่แนะนำสำหรับระบบที่มีหลายฟีเจอร์: แยก LIFF App เป็นหลายตัวตามฟังก์ชัน (เช่น ตัวจองคิว กับตัวข้อมูลสมาชิก) เพื่อจัดการ scope และ endpoint ให้ชัดเจน ไม่ปนกัน [7]

### 4. Rich Menu: ทางลัดจากหน้าแชตสู่เว็บแอป

Rich Menu คือเมนูที่แสดงด้านล่างหน้าแชตของ LINE OA ประกอบด้วย 3 ส่วน: รูปเมนู (JPEG/PNG), tappable area (พื้นที่กดแต่ละปุ่ม), และ chat bar (แถบเปิด/ปิดเมนู) [8] สร้างได้ 2 ทาง:

| เครื่องมือ | จุดเด่น |
|---|---|
| LINE Official Account Manager | ตั้งค่าเร็ว, GUI ใช้ง่าย, มี display period, มีสถิติ impression/click |
| Messaging API | ปรับแต่งขั้นสูง, ใช้ postback/datetime-picker action ได้, สลับแท็บเมนูได้, ตั้ง per-user rich menu ได้ |

การเชื่อม Rich Menu เข้ากับ LIFF ทำโดยตั้ง Action ของแต่ละปุ่มเป็นประเภท "Link" แล้วใส่ LIFF URL ที่ได้จากขั้นตอนก่อนหน้า เช่น ปุ่ม 1 → `https://liff.line.me/{LIFF_BOOKING_ID}` และปุ่ม 2 → `https://liff.line.me/{LIFF_MEMBER_ID}` [8][7] เมื่อผู้ใช้กดปุ่ม แอป LINE จะเปิด LIFF browser ไปที่ Endpoint URL ทันที ทำให้ประสบการณ์ใช้งานลื่นไหลอยู่ในแอป LINE ตลอด ไม่ต้องออกไป external browser

## User Guide (Step-by-Step)

1. **สร้าง LINE OA + เปิด Messaging API**
   สมัคร Business ID → กรอกฟอร์มสร้าง LINE Official Account → เปิดใช้งาน Messaging API จาก [LINE Official Account Manager](https://manager.line.biz/) → ระบบสร้าง Channel ให้อัตโนมัติใน [LINE Developers Console](https://developers.line.biz/console/) [1]
   Expected: เห็น Channel ใหม่ในหน้า Provider ของ Console

2. **ตั้งค่า Webhook**
   ใน tab Messaging API ของ Channel → คัดลอก Channel ID, Channel Secret, ออก long-lived Channel Access Token → นำ Webhook URL ของระบบ (เช่น `https://yourdomain.com/api/line/webhook`) มากรอก → เปิด "Use webhook" → กด Verify [1][4]
   Expected: Verify ขึ้นสถานะสำเร็จ (green check) — ถ้าล้มเหลวให้เช็ก HTTPS certificate ก่อน

3. **สร้าง LINE Login Channel + Callback URL**
   สร้าง Channel ประเภท LINE Login แยกจาก Messaging API → ใน tab "LINE Login" ใส่ Callback URL ให้ตรงโดเมน production (เพิ่มได้หลายบรรทัดถ้ามีหลาย environment) [5]
   Expected: ทดสอบ authorize URL แล้ว redirect กลับมาที่ Callback URL พร้อม `code` และ `state`

4. **สร้าง LIFF App + Endpoint URL**
   ใน LINE Login Channel เดิม → เพิ่ม LIFF App → ตั้งชื่อ, ขนาดหน้าจอ (แนะนำ Full สำหรับหน้าเว็บเต็มจอ) → ใส่ Endpoint URL ให้ตรง path จริงที่ deploy → เลือก scope (`openid`, `profile`, และ `chat_message.write` ถ้าต้องส่งข้อความแทนผู้ใช้) [6][7]
   Expected: ได้ LIFF ID → นำไปแปลงเป็น `https://liff.line.me/{LIFF_ID}`

5. **ผูก LIFF URL กับ Rich Menu**
   สร้าง Rich Menu ผ่าน LINE Official Account Manager หรือ Messaging API → เตรียมรูปเมนู → แบ่ง tappable area → ตั้ง Action แต่ละปุ่มเป็น "Link" ไปยัง LIFF URL ที่ได้จากขั้นตอนก่อนหน้า → Publish ให้เป็น default rich menu ของ OA [8][7]
   Expected: เปิดแชต OA จริงในมือถือ เห็นเมนูใหม่ด้านล่าง

6. **ทดสอบ end-to-end**
   กดปุ่มบน Rich Menu → ต้องเข้า LIFF browser → โหลด Endpoint URL → ระบบดึงโปรไฟล์ผู้ใช้ได้โดยไม่ต้องล็อกอินซ้ำ → ทำ flow ธุรกิจ (จองคิว/ดูข้อมูลสมาชิก) จนจบ → ตรวจว่าข้อความยืนยันส่งกลับเข้า LINE ผ่าน Messaging API [7]

**Troubleshooting:**
- `invalid liff id` → LIFF ID ในระบบไม่ตรงกับ LIFF App ที่ตั้ง endpoint จริง หรือใช้ LIFF ID ข้าม Channel — ต้องอัปเดต env ให้ตรงและ redeploy [7]
- Webhook verify ไม่ผ่าน → เช็ก HTTPS certificate ต้องออกจาก CA ที่เชื่อถือได้ (ไม่ใช่ self-signed), เช็กว่าเปิด "Use webhook" หลังกรอก URL แล้วจริง [1][4]
- Rich Menu ปุ่มกดไม่เปิดหน้าเว็บ — เช็กว่า Action type เป็น "Link" และ LIFF URL สะกดถูก ไม่ใช่ URL เว็บตรงๆ (ต้องผ่าน `liff.line.me`) [8]

## Caveats / Limits

- **Provider ผูกถาวร**: เมื่อกำหนด Provider ให้ LINE OA แล้ว เปลี่ยน/ยกเลิกไม่ได้ในภายหลัง ควรเลือก Provider ให้ถูกต้องตั้งแต่แรกโดยเฉพาะถ้าจะรวม Channel จากหลายบริการไว้ด้วยกัน [1]
- **Rich Menu ใช้ได้ทีละเครื่องมือ**: Rich Menu ที่สร้างผ่าน LINE Official Account Manager จะแก้ไข/ดึงข้อมูลได้เฉพาะผ่าน Manager เท่านั้น สลับไปใช้ Messaging API กับตัวเดียวกันไม่ได้ [8]
- **Rich Menu ไม่แสดงบน LINE PC**: ใช้งานได้เฉพาะแอป LINE บนมือถือ [8]
- **LIFF browser มีข้อจำกัด**: ไม่รองรับ web technology บางตัวเหมือน external browser เต็มรูปแบบ, cache ควบคุมผ่าน HTTP header เท่านั้น (ไม่มีทางลบ cache ตรงๆ), และ LIFF ยังไม่รองรับ OpenChat อย่างเป็นทางการ (ดึงโปรไฟล์ผู้ใช้ใน OpenChat ส่วนใหญ่ทำไม่ได้) [6]
- **Channel Access Token ต้อง revoke ทันทีถ้าหลุด**: เพราะใครก็ตามที่มี token สามารถเรียก Messaging API แทนธุรกิจได้ [3]
- **ความปลอดภัย**: Channel Secret และ Channel Access Token เป็นข้อมูลอ่อนไหว ห้าม commit เข้า public repository

## References

1. [Get started with the Messaging API — LINE Developers](https://developers.line.biz/en/docs/messaging-api/getting-started/)
2. [LINE Platform glossary — LINE Developers](https://developers.line.biz/en/glossary/)
3. [Channel access token — LINE Developers](https://developers.line.biz/en/docs/basics/channel-access-token/)
4. [Messaging API reference — LINE Developers](https://developers.line.biz/en/reference/messaging-api/)
5. [Integrating LINE Login with your web app — LINE Developers](https://developers.line.biz/en/docs/line-login/integrate-line-login/)
6. [LIFF overview — LINE Developers](https://developers.line.biz/en/docs/liff/overview/)
7. [คู่มือตั้งค่า LINE Messaging API + LIFF + LINE Login + Rich Menu (ใช้งานจริง) — QueueBooking](https://queuebooking.com/blog/line-msgapi-liff-login-richmenu-setup-guide)
8. [Rich menus overview — LINE Developers](https://developers.line.biz/en/docs/messaging-api/rich-menus-overview/)
9. [การสร้าง Line Official Account และสร้างพวก LINE Login + Messaging API ต่างๆ (YouTube)](https://youtu.be/F-fpyjRBxUU)

## Key Takeaways

- LINE OA เชื่อมระบบธุรกิจผ่าน 3 Channel แยกกัน: Messaging API (บอท/บรอดแคสต์), LINE Login (ล็อกอิน), และ LIFF App ที่อยู่ภายใต้ LINE Login Channel (เว็บแอปในแอป LINE)
- Webhook URL ต้องเป็น HTTPS จาก CA ที่เชื่อถือได้ และต้องกด Verify ให้ผ่านก่อนใช้งานจริง
- ใช้ long-lived Channel Access Token สำหรับงานบรอดแคสต์ทั่วไป เพราะไม่มีวันหมดอายุ ต่างจาก short-lived (30 วัน) และ stateless (15 นาที)
- Endpoint URL ของ LIFF ต้องตรง path deploy จริงเป๊ะ — ผิด path หรือใช้ LIFF ID ข้าม Channel คือสาเหตุหลักของ error `invalid liff id`
- Rich Menu ผูกกับ LIFF URL ผ่าน Action ประเภท "Link" ทำให้ผู้ใช้กดจากหน้าแชตเข้าเว็บ/แดชบอร์ดได้ทันทีโดยไม่ต้องล็อกอินซ้ำ
- แยก LIFF App หลายตัวตามฟังก์ชันธุรกิจ (เช่น จองคิว vs ข้อมูลสมาชิก) เพื่อจัดการ scope และ endpoint ให้ชัดเจน
- Provider ที่ผูกกับ LINE OA เปลี่ยนภายหลังไม่ได้ — ตัดสินใจให้รอบคอบตั้งแต่ขั้นตอนแรก
