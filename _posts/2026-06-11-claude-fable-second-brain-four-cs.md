---
title: "เจาะลึก: สร้าง Second Brain ด้วย Claude Fable และ Four Cs Framework"
date: 2026-06-10 00:01:00 +0700
categories: [Obsidian]
tags: [claude, fable, second-brain, knowledge-management, ai-workflow, productivity]
---

## TL;DR

Nate Herkelman แห่ง Uppit AI เสนอ **Four Cs Framework** — Context, Connections, Capabilities, Cadence — เป็นโครงสร้างสำหรับเปลี่ยน Claude Fable ให้เป็น AI Operating System ส่วนตัว C สองตัวแรกสร้าง "second brain" (ฐานความรู้ที่รู้จักคุณ), C สองตัวหลังเปลี่ยนมันเป็น OS ที่ทำงานแทนคุณโดยอัตโนมัติ

---

## Background / Why this matters

### ทำไม Second Brain บน AI จึงต่างจาก Note App

เราส่วนใหญ่มี Notion, Obsidian, หรือ Google Docs เต็มไปด้วยข้อมูล แต่ข้อมูลนั้นเงียบ — มันไม่ทำงานแทนเรา Nate อธิบาย Mindset Shift ที่สำคัญ: แทนที่จะมองว่า AI คือ "chatbot" ให้มองว่ามันคือ **co-founder ที่รู้จักธุรกิจและชีวิตของเราทุกอย่าง**

การทดสอบง่ายๆ (gut check): ถ้าเปิด Claude Code ขึ้นมาแล้วถามเรื่องตัวเอง ได้คำตอบที่ฟังดูเหมือน "คนแปลกหน้า" หรือ "เพื่อนร่วมงานที่รู้จักเราดี"?

### Two-Layer Architecture

Nate แบ่งระบบออกเป็น 2 layer ชัดเจน:

| Layer | ชื่อ | สิ่งที่ทำ |
|-------|------|-----------|
| **Layer 1** | Second Brain | Knowledge base — AI รู้จักคุณ สามารถตอบคำถามได้ |
| **Layer 2** | AI Operating System (AIOS) | Infrastructure — AI ทำงานแทนคุณโดยอัตโนมัติ |

Four Cs Framework สร้าง layer ทั้งสองนี้ตามลำดับ: Context + Connections = Second Brain; Capabilities + Cadence = AIOS

---

## Deep Dive

### Context — Routing Tree (สร้างแผนที่นำทาง)

**ปัญหาที่แก้**: โดยไม่มี Context AI ทำงานเหมือนคนแปลกหน้าที่ต้องอธิบายทุกอย่างใหม่ทุกครั้ง Nate เปรียบว่าการขาด Context เหมือนจ้างพนักงานใหม่มาแต่ไม่บอกอะไรเลย

**แนวคิดหลัก**: CLAUDE.md file ทำหน้าที่เป็น **router** — ชี้ทาง agent ไปยังไฟล์ที่ถูกต้อง ไม่ใช่แค่ "system prompt" ธรรมดา

ตัวอย่าง CLAUDE.md ที่ Nate ใช้จริง:
```
You are Nate Herk's executive assistant.
Your job is to help him spend less time on operations,
people management and admin so we can focus on
learning AI tools and making YouTube videos.

Knowledge base: [wiki path]
Hot cache: [path]
Master index: [path]
API keys: [path]
Skills: [path]
Active projects: [path]
```

**การจัด folder architecture** ที่สนับสนุน routing:
- รวม projects ที่ใช้บ่อยไว้ใน directory เดียว (Nate เรียกว่า "Herk 2")
- ประโยชน์: AI cross-reference ระหว่าง projects ได้ง่าย; sync ขึ้น GitHub ทีเดียวได้ทุก project

**Pulse Check** (ตัวชี้วัดคุณภาพ Architecture):
> ถ้า AI ใช้เวลา **มากกว่า 5 นาที** หาไฟล์ที่คุณรู้ว่าอยู่ที่ไหน — แสดงว่า file architecture engineering ต้องแก้ใหม่

เมื่อ Context ดี Nate เปิด session ด้วย 40,000-token context window ที่ประกอบด้วย system tools + memory files เป็นหลัก — agent "รู้" สถานะธุรกิจทันทีที่เริ่ม session

---

### Connections — Static vs Live Data (ต่อกับโลกจริง)

**ปัญหาที่แก้**: Context ใน CLAUDE.md คือข้อมูล static (เขียนครั้งเดียว) แต่โลกจริงเปลี่ยนแปลงตลอด AI ที่ไม่มี Connections จะให้ข้อมูลล้าสมัย

**ตัวอย่างที่เห็นในวิดีโอ**: Nate ถาม Fable เรื่องจำนวน YouTube subscribers — Fable ตอบว่า 620,000 (จาก static context) แต่ตัวเลขจริงคือ ~800,000 การ Connect กับ YouTube API จะดึงตัวเลขล่าสุดได้ถูกต้อง

**ขั้นตอนสร้าง Connections**:

1. **Audit weekly apps** — เขียนรายการ app และ bookmark ที่เปิดทุกสัปดาห์ แยกตาม category: revenue, customers, calendar, tasks, communications
2. **Integrate via API/CLI** ไม่ใช่ผ่าน MCP servers เท่านั้น — Nate แนะนำ CLI/API endpoints โดยตรง เพราะถูกกว่าและควบคุมได้มากกว่า
3. **Scoped API Keys** — ใช้ key ที่จำกัดสิทธิ์เสมอ ตัวอย่าง: key ที่อ่าน transcript ได้อย่างเดียว แต่ลบไม่ได้

Apps ที่ Nate ใช้เชื่อมต่อ: Google Workspace, QuickBooks, Stripe, ClickUp, Slack

| Data Type | ตัวอย่าง | วิธี Connect |
|-----------|----------|-------------|
| Static | SOPs, background history, bios | CLAUDE.md + ไฟล์ใน knowledge base |
| Live | Subscriber count, sales data, calendar | API endpoints, CLI tools |
| Semi-live | Email threads, project status | MCP หรือ CLI polling |

---

### Capabilities — Skills & Workflows (จาก brainstormer เป็น executor)

**ปัญหาที่แก้**: Context + Connections ทำให้ AI รู้ข้อมูล แต่ยังไม่ได้ทำงานแทนเรา Capabilities เปลี่ยน AI จาก "ที่ปรึกษา" เป็น "ผู้ลงมือทำ"

**Mindset shift สำคัญ**: หยุดเปิด browser เพื่อทำงาน — ทำงานทุกอย่างผ่าน Claude Code ใน AIOS แทน

**Building Reusable Skills**:

ทุกครั้งที่ใช้ prompt เดิมซ้ำ → บันทึกเป็น skill Nate ตัวอย่าง **"Grill Me" skill**:
- AI ถามคำถาม 15–30 ข้อ แบบ relentless เพื่อดึงความรู้จากหัวคุณ
- ผลลัพธ์: brainstorm docs ที่เก็บ undocumented knowledge จากผู้เชี่ยวชาญ
- ทุก run → ให้ feedback เพื่อ improve skill ในรอบถัดไป

**Assembly Line Architecture** (หลีกเลี่ยง "context rot"):

อย่าทำงานซับซ้อนใน prompt เดียว — ทำให้ context เน่าเสีย แทนที่ให้ chain sub-agents:

```
Research Agent → [ล้าง session] → Draft Agent → [ล้าง session] → Polish Agent
```

แต่ละ agent รับ output จาก agent ก่อนหน้า เริ่ม context ใหม่สะอาด

> **หมายเหตุ**: Skills ที่ Nate พูดถึงคือ Claude Code Custom Skills (SKILL.md files) — เป็น feature จริงของ Claude Code ที่ Anthropic พัฒนา ไม่ใช่แนวคิดเฉพาะของ Nate

---

### Cadence — Automating While You Sleep (ทำงานขณะหลับ)

**ปัญหาที่แก้**: ถ้าต้องนั่ง trigger ทุก Capability ด้วยตัวเอง นั่นคือการจ้างผู้ช่วยแต่ต้องนั่งดูตลอด Cadence คือการให้ระบบวิ่งเองตาม schedule หรือ event

**ประเภท Triggers**:
- **Event-based**: ลูกค้าจอง call → agent เตรียม brief อัตโนมัติ
- **Schedule-based**: ทุกวันอาทิตย์คืน → agent สรุปสัปดาห์ที่ผ่านมา

**เครื่องมือ Deploy**:
- Cloud code routines
- TypeScript scripts บน Modal (deterministic, predictable)
- n8n สำหรับ workflow automation

**บทเรียน Security ราคาแพง — เรื่องจริงจาก Nate**:

> Agent เข้าใจผิดและส่งโค้ดส่วนลดให้คนถึง **150,000–200,000 คน** เพราะมัน _มี_ physical API keys สำหรับส่งอีเมล

กฎที่ Nate ใช้หลังจากนั้น:
- **"Earn Autonomy"**: battle-test skills ก่อนให้ run อัตโนมัติ
- อย่าใช้ text prompt เป็น "permission layer" — ถ้า AI เข้าถึง database ได้จริง สมมติว่ามันจะทำ
- ให้ physical API keys แบบ scoped เท่านั้น — จำกัด blast radius

---

## User Guide (Step-by-Step)

สร้าง Claude Fable Second Brain ทีละขั้น:

### ขั้นที่ 1: ติดตั้ง Foundation

1. ติดตั้ง [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) (CLI) หรือเปิดใน VS Code extension
2. สร้าง folder หลักสำหรับ AIOS ของคุณ (เช่น `~/my-aios/`)
3. ย้าย projects ที่ใช้บ่อยเข้ามาใน folder นี้

### ขั้นที่ 2: สร้าง Context Routing Tree

สร้าง `CLAUDE.md` ที่ root ของ folder:

```markdown
# My AIOS

You are [ชื่อของคุณ]'s executive assistant.
Goal: ช่วยลดเวลาที่ใช้กับ [งานที่ต้องการลด] เพื่อโฟกัสที่ [สิ่งที่สำคัญ]

## Knowledge Base
- Wiki: [path]
- Notes: [path]
- Active projects: [path]

## Tools & APIs
- [tool]: [path/credential location]

## Skills
- Skills directory: ./skills/
```

**ทดสอบ**: ถาม Claude เรื่องตัวเองหรือ project ปัจจุบัน — ต้องตอบได้เหมือน "เพื่อนร่วมงาน" ไม่ใช่ "คนแปลกหน้า"

### ขั้นที่ 3: Wire Connections

Audit: เปิด apps อะไรทุกสัปดาห์? เลือก 3 อันดับแรกที่สำคัญที่สุด:

```bash
# ตัวอย่าง: connect กับ Google Calendar ผ่าน CLI
gcloud auth login
# บันทึก path ใน CLAUDE.md เพื่อให้ agent รู้ว่าจะ query ยังไง
```

สร้าง API keys แบบ **read-only/scoped** — อย่าให้ full access ตั้งแต่แรก

### ขั้นที่ 4: Build First Skill

เริ่มจาก skill ที่ใช้บ่อยที่สุด สร้างไฟล์ `./skills/weekly-review/SKILL.md`:

```markdown
# Weekly Review Skill

สรุปสัปดาห์ที่ผ่านมา:
1. ดึง tasks จาก [tool] ที่ complete
2. ดูข้อมูล revenue จาก [tool]
3. สรุปอีเมลสำคัญ
4. Draft plan สำหรับสัปดาห์หน้า

Output format: bullet points สั้นๆ พร้อม action items
```

ทดสอบ run → ให้ feedback → ปรับ → repeat

### ขั้นที่ 5: เพิ่ม Cadence (ระมัดระวัง)

**อย่าเพิ่งรีบ**: ใช้ skill แบบ manual อย่างน้อย 1–2 สัปดาห์ก่อน automate

เมื่อ skill น่าเชื่อถือแล้ว:
```bash
# ตัวอย่าง cron job (ทุกวันอาทิตย์ 22:00)
0 22 * * 0 cd ~/my-aios && claude --skill weekly-review
```

ตรวจสอบ permissions ก่อน deploy: agent ควรมี access เฉพาะสิ่งที่ต้องการจริงๆ

---

## Caveats / Limits

### 1. ราคาและ Usage Limits

Claude Fable 5 (`claude-fable-5`) ราคาอยู่ที่ $10/million input tokens และ $50/million output tokens — แพงกว่า Opus 4.8 สองเท่า Nate เองยอมรับว่า Fable ใช้ limit $200/เดือนหมดเร็วกว่า models รุ่นก่อนมาก

กลยุทธ์ควบคุมต้นทุน (ตาม Nate): ใช้ Fable สำหรับงาน complex reasoning, delegate งานง่ายๆ ให้ Sonnet หรือ Haiku ผ่าน dynamic workflows

### 2. Privacy และ Security

การป้อนข้อมูลธุรกิจ, client data, หรือ personal life เข้าไปใน AI มี trade-off ด้าน privacy ที่ต้องพิจารณาตามบริบทของแต่ละคน — โดยเฉพาะในองค์กรที่มี data governance policies

### 3. "Fable Gets It" — Creator's Opinion, Not a Benchmark

Nate กล่าวว่า Fable "requires less micromanagement" และ "intrinsically gets it" — นี่คือ **ความเห็นส่วนตัวจากประสบการณ์ใช้งาน** ไม่ใช่ข้อมูล benchmark เปรียบเทียบที่ Anthropic published

### 4. Glasswing Guardrails (Over-cautious at Launch)

Nate อ้างถึง "Project Glasswing" ซึ่งเขาเชื่อว่าเป็น cyber safety guardrails ของ Anthropic ที่ทำให้ Fable refuse tasks บ่อยกว่า models รุ่นก่อนตอน launch แรก — นี่คือ creator's claim และ Anthropic ไม่ได้ publish ชื่อ project นี้เป็น public information

### 5. Vendor Lock-in

ระบบที่สร้างรอบ CLAUDE.md, Claude Code skills, และ Claude-specific APIs จะย้ายไป provider อื่นลำบาก — ต้องนับเป็น cost ระยะยาว

### 6. Context Rot ยังเป็นปัญหาแม้ใช้ Assembly Line

แม้ sub-agent approach ช่วยได้ แต่ยังต้องออกแบบ handoff prompt ให้ดี information loss ระหว่าง agents คือ failure mode ที่พบบ่อย

---

## References

1. Nate Herkelman, "I Turned Claude Fable Into The Ultimate Second Brain," YouTube, 2026. [https://www.youtube.com/watch?v=8QQ_INxAhRs](https://www.youtube.com/watch?v=8QQ_INxAhRs)
2. Anthropic, "Claude Models Overview," Anthropic Documentation. [https://docs.anthropic.com/en/docs/about-claude/models/overview](https://docs.anthropic.com/en/docs/about-claude/models/overview)
3. Anthropic, "Claude Code Overview," Anthropic Documentation. [https://docs.anthropic.com/en/docs/claude-code/overview](https://docs.anthropic.com/en/docs/claude-code/overview)
4. Nate Herkelman / Uppit AI, community and course resources. [https://uppitai.com](https://uppitai.com)

---

## Key Takeaways

- **Four Cs = ลำดับ** ไม่ใช่แค่ checklist: Context → Connections → Capabilities → Cadence ต้องทำตามลำดับ ข้ามขั้นไม่ได้
- **Routing Tree คือหัวใจ**: CLAUDE.md ที่ดีไม่ใช่แค่ system prompt — มันคือ map ที่ชี้ทาง agent ไปหาทุกอย่าง; ถ้า agent หาไฟล์ไม่เจอใน 5 นาที แสดงว่า architecture ผิด
- **Static vs Live**: ข้อมูลใน CLAUDE.md จะล้าสมัย — Connections ผ่าน scoped API/CLI ทำให้ AI รู้ความจริง ณ ปัจจุบัน
- **Skills = capital ที่สะสม**: ทุก prompt ซ้ำที่บันทึกเป็น skill และปรับปรุงทุก run = compound value ที่สะสมได้
- **"Earn Autonomy"**: อย่า automate สิ่งที่ยังไม่ผ่าน manual battle-test — story ของ email 150k คนคือบทเรียนที่แพงมาก
- **ต้นทุนจริง**: Fable ราคา $10/$50 per MTok — ต้องวางแผน tiered model strategy (Fable สำหรับ complex, Sonnet/Haiku สำหรับ routine)
- **Framework vs Product**: Four Cs เป็น creator's framework ที่ map กับ Claude features จริง (Code, Skills, custom instructions) แต่ส่วนหนึ่งเป็น workflow opinion ของ Nate โดยเฉพาะ
