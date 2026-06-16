---
title: "เจาะลึก Microsoft 365 Copilot: 3 ระดับ Chat, M365 และ Copilot Studio"
date: 2026-06-16 00:01:00 +0700
categories: [Tools]
tags: [microsoft-365, copilot, copilot-studio, ai-agent, enterprise, low-code]
---

## TL;DR

Microsoft 365 Copilot แบ่ง 3 ระดับ: **Copilot Chat** (รวมใน M365 subscription ทุกแบบ), **M365 Copilot** (add-on per-user เชื่อม Microsoft Graph กับข้อมูลองค์กร), **Copilot Studio** (low-code platform สร้าง AI Agent ระดับแผนก/องค์กร) — เรียนรู้วิธีตั้งค่า Agent ด้วย Instruction Prompt, Knowledge Source, Topics และ Enterprise Data Protection

## Background / Why this matters

ในยุค AI First หลายองค์กรที่ใช้ Microsoft 365 อยู่แล้วมักสับสนว่า "Copilot" ที่เห็นในแต่ละที่คือตัวเดียวกันหรือเปล่า และต้องจ่ายเงินเพิ่มแค่ไหน ความจริงคือ Microsoft สร้าง ecosystem ของ Copilot แบบ layered — ระดับล่างสุดรวมอยู่ใน subscription ที่มีอยู่แล้ว ระดับกลางเป็น add-on per-person สำหรับ power users และระดับบนสุดเป็น platform สร้าง AI Agent custom สำหรับทีมหรือองค์กรทั้งหมด

การเข้าใจความแตกต่างทั้ง 3 ระดับช่วยให้ IT admin และ decision-maker วางงบประมาณและเลือก tooling ได้ถูกต้อง ไม่จ่ายแพงเกินจำเป็น และไม่ใช้เครื่องมือที่ capability ต่ำเกินไปกับงาน

## Deep Dive

### 1. Microsoft 365 Copilot Chat (รวมใน M365 subscription)

**Copilot Chat** มาพร้อม Microsoft 365 subscription ทุกแบบโดยไม่มีค่าใช้จ่ายเพิ่มเติม ใช้งานได้ทันทีที่ login ด้วย Entra work account

ความสามารถหลัก:
- AI chat grounded on the web — ตอบคำถามจากข้อมูลอินเทอร์เน็ต ไม่ใช่ข้อมูลองค์กร
- สร้างรูปภาพ และ **Copilot Pages** (บันทึก/แก้ไข/แชร์ AI-generated content)
- Pay-as-you-go agents
- **Enterprise Data Protection (EDP)** ครบทุก session

เข้าถึงได้ที่ [m365copilot.com](https://m365copilot.com), Microsoft 365 app, Teams, Outlook, Edge

### 2. Microsoft 365 Copilot (Add-on per User)

ระดับนี้ต้องซื้อ license เพิ่มรายบุคคล จุดต่างที่ชัดที่สุดคือ **Work mode** — เชื่อมต่อกับ **Microsoft Graph** ดึงข้อมูลจาก email, Teams meetings, SharePoint, OneDrive ของ user คนนั้น

ความสามารถหลัก:
- **Work mode**: chat grounded in organizational data ผ่าน Microsoft Graph
- **Web mode**: ข้อมูลองค์กร + อินเทอร์เน็ตรวมกัน
- In-app experiences ใน Word, Excel, PowerPoint, Outlook, Teams
- สร้าง Copilot Agents custom ได้
- Copilot Analytics วัด ROI การใช้งาน
- Copilot Search ค้นหาข้าม M365 + third-party sources

ตัวอย่างใช้งาน: "สรุป email ทั้งสัปดาห์เกี่ยวกับ Project X", "สร้าง PowerPoint จากเอกสาร Word นี้", "สรุป Teams meeting ที่ฉันพลาดไป"

### 3. Copilot Studio (Low-code Platform สร้าง AI Agent)

**Copilot Studio** เป็น platform แยกต่างหาก เข้าถึงที่ [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) เหมาะสำหรับ:
- สร้าง Agent สำหรับผู้ใช้ทั้งแผนก องค์กร หรือ external customers
- ต้องการ multi-step workflow หรือ custom integrations
- Deploy หลาย channel (website, Teams, mobile, Facebook, Azure Bot Service)
- ต้องการ control เรื่อง deployment และ management อย่างเต็มที่

ใช้ Azure OpenAI (GPT models) เป็น default LLM พร้อมรองรับ custom AI model connections

### 4. Instruction Prompt: กำหนดบุคลิกและขอบเขต Agent

ขั้นตอนแรกของการสร้าง Agent คือกำหนด **Instructions** — system prompt ที่บอก Agent ว่า:
- ชื่อตัวเอง บทบาท และขอบเขตความรับผิดชอบ
- โทนเสียงในการตอบ (professional, friendly, formal)
- สิ่งที่ Agent ไม่ควรตอบ เพื่อกันไม่ให้ Agent ออกนอก scope

```
ตัวอย่าง Instruction:
คุณคือ HR Assistant ของบริษัท Contoso
ตอบคำถามเกี่ยวกับสวัสดิการ วันหยุด และนโยบาย HR เท่านั้น
ใช้ภาษาไทยสุภาพ ตอบสั้นกระชับ
ไม่ตอบคำถามเกี่ยวกับเงินเดือนหรือข้อมูลส่วนตัวของพนักงานคนอื่น
```

Instruction ที่ชัดเจนช่วยลด hallucination และทำให้ Agent ตอบตรง persona ที่ต้องการ

### 5. Knowledge Source: เชื่อมฐานความรู้องค์กร

Copilot Studio รองรับ knowledge source หลายประเภท โดย **generative orchestration mode** มีขีดจำกัดที่สูงกว่า classic mode มาก:

| ประเภท | Generative Mode | Classic Mode | Authentication |
|--------|-----------------|--------------|----------------|
| SharePoint URLs | 25 URLs | 4 URLs | Entra ID |
| Public websites | 25 domains | 4 URLs | ไม่ต้องการ |
| Dataverse | ไม่จำกัด | 2 sources (≤15 tables) | Entra ID |
| Uploaded files | ไม่จำกัด | จำกัดตาม Dataverse storage | ไม่ต้องการ |
| Enterprise connectors | ไม่จำกัด | 2 | Entra ID |

**ขนาดไฟล์**: SharePoint และ Microsoft Copilot connectors รองรับไฟล์ **สูงสุด 512 MB** สำหรับ PDF, PPTX, DOCX — ต้องเปิดใช้งาน **Work IQ** feature (ต้องการ M365 Copilot license ใน tenant เดียวกัน) หากไม่มี license นั้นขนาดสูงสุดลดเหลือ 200 MB

**Security by design**: เมื่อ user ถาม Agent จะ surface เฉพาะเนื้อหาที่ user คนนั้นมีสิทธิ์เข้าถึงบน SharePoint/Dataverse เท่านั้น — ไม่มีสิทธิ์อ่าน != ไม่ได้รับคำตอบ

### 6. Topics: จัดเส้นทางสนทนา + Suggestion Box

**Topic** คือ conversational thread สำหรับ intent หนึ่งๆ เช่น "สอบถามวันหยุด", "แจ้งซ่อม IT", "ขอใบลา"

Agent ใช้ **NLU (Natural Language Understanding)** จับคู่คำถาม user กับ Topic ที่ถูกต้องโดยอัตโนมัติ — ไม่ต้อง keyword matching แบบเดิม

แต่ละ Topic ประกอบด้วย:
- **Trigger phrases**: ประโยคตัวอย่างที่ activate topic นั้น
- **Conversation flow**: ลำดับ nodes (ถาม, เงื่อนไข if/else, action, ตอบ)
- **Generative answers node**: ให้ topic นี้ค้นหาจาก knowledge source เฉพาะ

**Conversation Starters (Suggestion Box)**: ปุ่ม shortcut ที่แสดงให้ user เลือกเมื่อเริ่ม conversation — ช่วยกำหนดกรอบการทำงานและนำ user ไปยัง topic ที่ถูกต้อง ลดคำถาม out-of-scope

### 7. Enterprise Data Protection (EDP)

EDP ใช้กับ **ทุกระดับ** ของ M365 Copilot:
- Prompt และ response ไม่ถูกนำไป train model ของ Microsoft
- ข้อมูลไม่รั่วออกนอก tenant
- Entra ID authentication ควบคุมการเข้าถึง knowledge source ทุกตัว
- Audit log ทุก session ผ่าน Microsoft Purview

## User Guide (Step-by-Step)

### สร้าง Agent ใน Copilot Studio ครั้งแรก

**ขั้นตอนที่ 1: เข้าถึง Copilot Studio**

ไปที่ [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) → login ด้วย work account → เลือก **Create** → ตั้งชื่อ Agent

**ขั้นตอนที่ 2: กำหนด Instruction**

ใส่ description ใน **Instructions** field:
```
คุณคือ IT Helpdesk ของบริษัท
ตอบคำถามเกี่ยวกับการแก้ปัญหาคอมพิวเตอร์ ซอฟต์แวร์ และสิทธิ์การเข้าถึงระบบ
ใช้ภาษาไทย ตอบกระชับ
หากไม่รู้คำตอบ ให้แนะนำ user ส่ง ticket ผ่าน helpdesk@contoso.com
```

**ขั้นตอนที่ 3: เพิ่ม Knowledge Source**

Knowledge tab → **Add** → เลือกประเภท:
- **SharePoint**: ใส่ URL เช่น `https://contoso.sharepoint.com/sites/IT`
- **Upload files**: อัปโหลด PDF คู่มือ หรือ FAQ document โดยตรง
- **Website**: ใส่ domain เช่น `support.microsoft.com`

Expected: Agent จะใช้เนื้อหาจาก source เหล่านี้ในการตอบคำถาม และอ้างอิง source ให้ user ด้วย

**ขั้นตอนที่ 4: สร้าง Topic**

Topics tab → **Add topic** → **From blank**:
1. ตั้งชื่อ topic เช่น `แจ้งซ่อมอุปกรณ์`
2. เพิ่ม trigger phrases: `อุปกรณ์เสีย`, `คอมพิวเตอร์พัง`, `ขอแจ้งซ่อม`
3. สร้าง flow: Message node (ขอรายละเอียด) → Question node (ชื่ออุปกรณ์) → Message node (ยืนยัน)

**ขั้นตอนที่ 5: ตั้ง Conversation Starters**

Overview page → **Conversation starters** → เพิ่มปุ่ม:
- "แจ้งซ่อมอุปกรณ์"
- "รีเซ็ตรหัสผ่าน"
- "ขอสิทธิ์โปรแกรม"

**ขั้นตอนที่ 6: Test และ Publish**

คลิก **Test** (chat panel ขวา) → ทดสอบคำถามหลาย scenario → เมื่อพอใจ → **Publish** → เลือก channel (Teams, Website, ฯลฯ)

## Caveats / Limits

- **Classic orchestration**: SharePoint จำกัด 4 URLs ต่อ generative answers node, website จำกัด 4 domains — ถ้าต้องการมากกว่านั้นต้องเปลี่ยนเป็น generative mode
- **Work IQ dependency**: ขนาดไฟล์ 512 MB ต้องการ M365 Copilot license ใน tenant เดียวกัน และต้อง set authentication เป็น **Authenticate with Microsoft** เท่านั้น
- **Generative mode**: ถ้ามีมากกว่า 25 knowledge sources, GPT จะเลือก source โดยอ้างอิง description ที่ผู้สร้างกำหนด — description ไม่ชัดเจน = Agent เลือก source ผิด
- **Teams app sunset**: หลังสิ้นเดือนมิถุนายน 2026 ไม่สามารถสร้าง classic chatbot ผ่าน Copilot Studio for Teams app ได้อีก ต้องใช้ web app แทน
- **Authentication required**: SharePoint, Dataverse, Enterprise connectors ต้องตั้งค่า authentication — agent ที่ไม่มี auth จะเข้าถึง internal sources ไม่ได้
- Copilot Studio ต้องได้รับการเปิดสิทธิ์จาก IT admin ผ่าน Power Platform Admin Center ก่อนใช้งาน

## References

1. [Decide which Copilot is right for you — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/copilot/which-copilot-for-your-organization)
2. [Knowledge sources summary — Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-copilot-studio)
3. [Overview — Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio)
4. [Add SharePoint as a knowledge source — Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint)
5. [Enterprise data protection in Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/enterprise-data-protection)
6. [Microsoft 365 Copilot Plans and Pricing](https://www.microsoft.com/en-us/microsoft-365-copilot/pricing)
7. [อยากสร้าง Agent? เริ่มที่ Copilot Studio แบบเข้าใจง่าย — YouTube](https://youtu.be/0Ez01UHP_fk)

## Key Takeaways

- Copilot Chat รวมอยู่ใน M365 subscription ทุกแบบ — ไม่ต้องซื้อเพิ่ม แต่ทำงานกับ web เท่านั้น ไม่ใช่ข้อมูลองค์กร
- M365 Copilot add-on เพิ่ม Work mode ที่เชื่อม Microsoft Graph — email, calendar, SharePoint, Teams ของ user คนนั้น
- Copilot Studio คือ low-code platform แยก สร้าง custom Agent สำหรับทีม/องค์กร/ลูกค้า deploy หลาย channel ได้
- Instruction Prompt กำหนดบุคลิก scope และข้อห้ามของ Agent — เขียนให้ชัดเพื่อลด hallucination และ out-of-scope answers
- Knowledge Source: SharePoint/OneDrive รองรับ PDF/PPTX/DOCX สูงสุด 512 MB (ต้อง Work IQ + M365 Copilot license); generative mode รองรับ 25 sources
- Topics ใช้ NLU จัดเส้นทางสนทนาอัตโนมัติ; Conversation Starters คือปุ่มที่ช่วยกรอบการทำงานให้ user
- Enterprise Data Protection ป้องกันทุกระดับ — prompt/response ไม่ถูกนำไป train model ของ Microsoft
