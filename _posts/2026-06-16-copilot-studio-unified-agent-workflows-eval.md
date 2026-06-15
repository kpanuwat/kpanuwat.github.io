---
title: "Copilot Studio ใหม่ EP.2: Unified Agent Screen, Workflows Designer และ Eval"
date: 2026-06-15 00:02:00 +0700
categories: [Tools]
tags: [copilot-studio, microsoft, ai-agents, workflows, evaluation, power-platform]
---

## TL;DR

Copilot Studio ยกเครื่องหน้าตาและ workflow ใหม่ — รวม Instructions, Knowledge, Memory, Tools ไว้ในหน้าจอเดียว, Skills แบบ Markdown ที่แชร์ข้าม agent ได้, Workflows Designer สำหรับต่อ SharePoint/Outlook/PDF ส่งเมล, Eval tab สำหรับ test cases, และ Classic toggle เพื่อ backward compatibility

## Background / Why This Matters

หลังจาก Microsoft ประกาศ rebuild Copilot Studio ด้วย generative orchestrator (ดูใน [EP.1](/tools/2026/06/15/copilot-studio-new-orchestrator-skills-memory.html)) คำถามที่ตามมาคือ "ในทางปฏิบัติ หน้าตาเปลี่ยนยังไง แล้วทำงานอย่างไร?"

post นี้เจาะในมุม practitioner — สิ่งที่คุณจะเห็นและทำใน UI ใหม่ ตั้งแต่หน้าจอ build agent แบบ unified ไปจนถึง Workflows Designer ที่ต่อ SharePoint หรือสั่งส่งไฟล์ PDF ทางอีเมลได้ โดยไม่ต้องออกไป Power Automate และ Eval tab ที่ใส่ test cases ตรวจคุณภาพ agent ได้ก่อน deploy

## Deep Dive

### Unified Agent Screen: Instructions + Knowledge + Memory + Tools

หน้าจอ build agent ใหม่รวมทุกอย่างไว้ในที่เดียว แทนที่จะกระจายอยู่ในหลาย menu:

| Panel | ทำอะไร |
|-------|--------|
| **Instructions** | เขียน system prompt หรือ load Skill — บอก agent ว่าต้องประพฤติตัวอย่างไร |
| **Knowledge** | เชื่อม SharePoint, PDF, website, หรือ Dataverse เป็น knowledge base |
| **Memory** | ตั้ง persistent/session memory keys — agent จำ context ข้ามเซสชัน |
| **Tools** | เพิ่ม MCP servers, connectors, หรือ Power Automate flows |

ทั้งสี่ panel อยู่ใน canvas เดียว ทำให้เห็น full capability ของ agent ได้ทันที ไม่ต้องเปิดหลาย tab

### Skills: Markdown Instructions ที่แชร์ได้

Skills คือ instruction set ที่เขียนเป็น Markdown ธรรมดา สร้างครั้งเดียว แชร์ข้าม agent หลายตัวได้:

```markdown
## Draft Professional Email

When user asks to draft an email:
1. Ask: recipient, purpose, tone (formal/casual)
2. Draft using the user's preferred language
3. Offer to attach a PDF summary if relevant
4. Send via Outlook connector on user confirmation
```

ต่างจาก Topics เดิมตรงที่:
- **ไม่มี trigger keyword** — orchestrator เรียกใช้ตาม context
- **แชร์ข้าม agent** — เก็บใน repository หรือ user profile → auto-discover
- **สร้างจาก prompt** — พิมพ์ describe what you want → Copilot Studio generate .md ให้

### Workflows Designer: ต่อ SharePoint, Outlook, PDF ส่งเมล

Workflows Designer คือ visual canvas ใหม่ที่ออกแบบ automation end-to-end ได้ในที่เดียว:

**ตัวอย่าง Workflow: รับ request → สร้าง PDF → ส่งอีเมล**

```
[Agent node: รับ request จาก user]
        ↓
[Logic node: ดึงข้อมูลจาก SharePoint]
        ↓
[Code node: Python สร้างไฟล์ PDF]
        ↓
[Outlook connector: แนบ PDF ส่งอีเมล]
        ↓
[Agent node: แจ้ง user ว่าส่งแล้ว]
```

ความสามารถหลัก:
- **Agent nodes** — ฝัง agent เข้าไปใน workflow ตรงจุดที่ต้องการ reasoning
- **Step-by-step testing** — test แต่ละ node ด้วย sample input ก่อน deploy ทั้ง workflow
- **Standalone หรือ agent-triggered** — รันได้ทั้งแบบ scheduled automation และแบบ agent เรียก

Integration ที่รองรับ (ผ่าน connectors + MCP):

| ระบบ | ทำอะไรได้ |
|------|----------|
| **SharePoint** | ดึงเอกสาร, อัปเดต list, สร้างหน้า |
| **Outlook** | ส่งอีเมล, แนบไฟล์, อ่าน inbox |
| **PDF/Excel** | สร้าง report ด้วย Python ใน orchestrator |
| **Teams** | ส่งข้อความ, สร้าง meeting, แจ้งเตือน |
| **Dataverse** | query/write ข้อมูล business data |

### Eval Tab: ป้อน Test Cases ตรวจคุณภาพก่อน Deploy

Eval เป็น built-in quality gate สำหรับ agent — GA ตั้งแต่ มีนาคม 2026:

**วิธีสร้าง Test Set:**

1. ไปที่ tab **Evaluation** ของ agent
2. คลิก **New evaluation → Single response** หรือ **Conversation**
3. เลือกวิธีสร้าง test cases:
   - **Quick question set** — AI generate 10 คำถามจาก agent description อัตโนมัติ
   - **Full question set** — generate จาก Knowledge source หรือ Topics (เลือกจำนวน)
   - **จาก test chat** — ใช้ conversations ที่เพิ่ง test มาเป็น test case
   - **Import CSV/Excel** — นำเข้า test cases ที่เตรียมไว้ (สูงสุด 100 cases)
   - **จาก real user analytics** — ดึงจาก Themes ใน Analytics tab

**Evaluation Methods ที่รองรับ:**

| Method | วัดอะไร | ประเภท |
|--------|--------|--------|
| **General quality** | คุณภาพโดยรวมของคำตอบ | คะแนน 0–100% |
| **Compare meaning** | ความหมายตรงกับ expected response | คะแนน 0–100% |
| **Text similarity** | ความคล้ายคลึงของข้อความ | คะแนน 0–100% |
| **Exact match** | ตรงตัวทุกตัวอักษร | Pass/Fail |
| **Keyword match** | มี keyword ที่กำหนดหรือไม่ | Pass/Fail |
| **Capability use** | เรียก tool/knowledge ที่คาดหวังหรือไม่ | Pass/Fail |
| **Custom** | criteria ที่ define เอง | Pass/Fail |

**Set-level grading**: ประเมิน overall quality ของทั้ง test set ไม่ใช่แค่ case ต่อ case — ทำให้วัด baseline และ track improvement ข้าม version ได้

**ข้อจำกัด**: test results เก็บได้ 89 วัน — export เป็น CSV ถ้าต้องการเก็บนานกว่านั้น

### Classic Mode Toggle: สลับได้ทันที

สำหรับทีมที่มี bot เดิมที่ใช้ Topics/Triggers อยู่แล้ว มี toggle ให้สลับได้:

- **Generative orchestration (default)** — LLM เลือก tool/skill ตาม intent ไม่ต้อง keyword
- **Classic orchestration** — ใช้ Topics + Triggers เหมือนเดิม suitable สำหรับ simple, deterministic flows

วิธีสลับ: ไปที่ **Settings → Generative AI → Orchestration** → เลือก **Yes/No** สำหรับ "Use generative AI orchestration for your agent's responses?"

ประโยชน์: ทีมสามารถ build ใน mode ใหม่แบบ parallel ไปกับ production bot เดิมที่ยังใช้ Classic ได้ ไม่ต้อง migrate ทุกอย่างพร้อมกัน

## User Guide (Step-by-Step)

### สร้าง Agent พร้อม Workflow ส่ง PDF ทางอีเมล

**1. สร้าง Agent ใน Unified Screen**
- ไปที่ Copilot Studio → **New Agent**
- กรอก Instructions (หรือ load Skill)
- เพิ่ม Knowledge: เชื่อม SharePoint library
- เพิ่ม Tool: เพิ่ม Outlook connector

**2. สร้าง Skill สำหรับ draft รายงาน**
- คลิก **Skills → Add Skill → Describe**
- พิมพ์: "When asked to create a summary report, generate a PDF and email it to the requester"
- Review .md ที่ generate → Save

**3. สร้าง Workflow**
- คลิก **Workflows → New Workflow**
- เพิ่ม nodes: Agent → SharePoint (ดึงข้อมูล) → Python (สร้าง PDF) → Outlook (ส่ง)
- Test แต่ละ node ด้วย sample input

**4. ตั้ง Eval test cases**
- ไปที่ **Evaluation → New evaluation → Quick question set**
- AI generate 10 คำถาม → review → เพิ่ม expected responses
- Run evaluation → ดู score ก่อน deploy

**5. Deploy**
- เปิด Preview mode → ทดสอบ end-to-end
- Publish → ตั้ง Monitor alerts

## Caveats / Limits

- **Eval: 100 test cases per set** — test results หมดอายุใน 89 วัน
- **Classic toggle ไม่ได้ migrate** — การสลับโหมดไม่แปลง Topics เป็น Skills อัตโนมัติ ต้อง rewrite เอง
- **Workflows node testing** อยู่ใน preview บาง features
- **SharePoint/Outlook connectors** ต้องการ authentication setup — eval ใช้ test account จึงต้อง configure credentials แยก
- **AI-generated test cases อาจ include sensitive data** — test cases generate จาก knowledge source ที่ account เชื่อมอยู่ ต้อง review ก่อนแชร์
- **Set-level grading** ต้องมี test set ที่มี test cases ครบพอสมควร (Microsoft แนะนำ ≥ 20 cases สำหรับ meaningful baseline)

## References

1. [Meet the new Copilot Studio: rebuilt for more complex, multi-step work — Microsoft Tech Community](https://techcommunity.microsoft.com/blog/copilot-studio-blog/meet-the-new-copilot-studio-rebuilt-for-more-complex-multi-step-work/4526488)
2. [Create a single response test set — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-agent-evaluation-create)
3. [Orchestrate agent behavior with generative AI — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-generative-actions)
4. [What's new in Copilot Studio: April 2026 — Microsoft Copilot Blog](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-agent-governance-intelligent-workflows-and-connected-app-experiences/)
5. [What's new in Copilot Studio: May 2026 — Microsoft Copilot Blog](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-computer-using-agents-a-new-workflows-experience-and-real-time-voice-experiences/)
6. [Overview of Microsoft Copilot Studio 2026 Release Wave 1 — Microsoft Learn](https://learn.microsoft.com/en-us/power-platform/release-plan/2026wave1/microsoft-copilot-studio/)
7. [Run evaluations and view results — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-agent-evaluation-results)
8. [Classic vs Generative Orchestration — DEV Community](https://dev.to/holgerimbery/exploring-copilot-studio-features-classic-orchestration-and-generative-orchestration-92b)
9. [YouTube: Copilot Studio deep-dive EP.2](https://youtu.be/CaEEv9Y-ibs)

## Key Takeaways

- **Unified Screen** รวม Instructions + Knowledge + Memory + Tools ในที่เดียว — เห็น capability ทั้งหมดของ agent ทันที
- **Skills = .md files** แชร์ข้าม agent ได้ สร้างจาก prompt ไม่ต้องรู้ code
- **Workflows Designer** ต่อ SharePoint, Outlook, PDF ได้ใน canvas เดียว — ไม่ต้องออกไป Power Automate
- **Eval tab** (GA มีนาคม 2026) มี 7 evaluation methods, AI-generate test cases, import CSV ได้
- **Classic toggle** ให้ build ใน mode ใหม่แบบ parallel กับ production bot เดิม
- Test results หมดอายุ 89 วัน — export CSV ถ้าต้องการ audit history
- AI-generated test cases อาจมี sensitive data จาก knowledge source — review ก่อนแชร์เสมอ
