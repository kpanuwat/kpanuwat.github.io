---
marp: true
theme: default
paginate: true
---

# Obsidian YOLO

**จาก Second Brain กลายเป็น Agent Workspace**

You Orchestrate, LLM Operates

---

## TL;DR

- YOLO เปลี่ยน vault จาก "ที่เก็บโน้ต" → "workspace ของ AI agent"
- LLM อ่าน เขียน จัดระเบียบ และต่อ toolchain ใน vault ได้จริง
- เราเป็นคนกำกับทิศทาง — LLM เป็นคนลงมือทำ

---

## ปัญหาของ Knowledge Base ยุคเก่า

ปัญหาไม่ใช่ "ไม่มีโน้ต" — แต่คือ**มีโน้ตเยอะเกินไปจนอ่านไม่ทัน**

| ยุค | แนวทาง | ข้อจำกัด |
|-----|--------|----------|
| GTD / Second Brain | เราค้นและใช้ความรู้ | ยังต้องทำเอง |
| AI Gen 1 (ChatGPT, Claude) | ช่วยเขียน | ไม่แก้ KB ที่กระจัดกระจาย |
| **YOLO** | **Agent ทำงานใน vault แทน** | — |

---

## YOLO คืออะไร

**You Orchestrate, LLM Operates**

- เราเป็น **director** — ตั้ง goal, เลือก scope, อนุมัติผล
- LLM เป็น **operator** — ลงมือทำใน vault จริง

สิทธิ์ที่ agent มี:
- **Read** — โน้ตทุกไฟล์ที่ grant access
- **Write** — เขียนหรือแก้ไขเนื้อหา
- **Organize** — ย้ายไฟล์ จัด folder
- **Connect** — ต่อ external tool ผ่าน MCP

---

## Features หลัก

| Feature | ใช้เมื่อ |
|---------|----------|
| **Agent Mode** | multi-step task อ่านหลายไฟล์ก่อนตัดสินใจ |
| **Quick Ask (`@`)** | inline AI โดยไม่ออกจาก editor |
| **Focus Sync** | AI รู้ว่าเรากำลังอ่านไฟล์ไหน |
| **Memory System** | จำ context ข้ามการสนทนา |
| **Built-in Web Search** | ค้น web + synthesize กับ vault |
| **Native PDF Support** | อ่าน PDF ด้วย vision model โดยตรง |

---

## Timeline พัฒนาการ

| Version | Feature หลัก |
|---------|-------------|
| 1.5.1 | Agent Mode |
| 1.5.2 | Memory System |
| 1.5.3 | Multi-window Chat + Background Agents |
| 1.5.5 | Hybrid search & knowledge-base re-index |
| 1.5.6 | Built-in Web Search (multiple providers) |
| 1.5.7 | Focus Sync + Deep PDF support |

→ กำลัง build toward "AI workspace ที่รู้ context ของเรา"

---

## Adoption

- **~34,000 downloads** บน Obsidian Plugin Directory
- **~1k GitHub stars**, 67 contributors, 84+ releases

สัญญาณ: คน Obsidian community กำลังมองหา  
"ระบบคิด + ระบบลงมือทำ" ในที่เดียว

---

## ติดตั้ง (2 วิธี)

**วิธี A — Community Plugins (แนะนำ)**

Settings → Community plugins → Browse → ค้น `YOLO` → Install → Enable

**วิธี B — Manual**

ดาวน์โหลด `main.js` + `manifest.json` + `styles.css` จาก Releases  
วางใน `<vault>/.obsidian/plugins/obsidian-yolo/`

> ⚠️ **Smart Composer ต้อง disable ก่อน** — conflict กัน

---

## ตั้งค่า LLM Provider

Settings → YOLO → เลือก provider + ใส่ API key

| Provider | API Key จากที่ไหน |
|---------|-----------------|
| OpenAI | platform.openai.com/api-keys |
| Claude | console.anthropic.com/settings/keys |
| Gemini | aistudio.google.com/apikey |
| Groq | console.groq.com/keys |

> ⚠️ API key เก็บใน `data.json` — ตรวจสอบว่า `.obsidian/` ไม่อยู่ใน public git

---

## Step แรก: Agent Task

```
ดู note ทั้งหมดใน "Projects/Alpha"
แล้วสรุป action item ที่ค้างอยู่
จัดลำดับ priority → เขียนลง "Planning/week-2026-W20.md"
```

Agent จะ:
1. อ่านทุกไฟล์ใน folder ที่ระบุ
2. Extract action item + deadline
3. สร้างไฟล์ weekly plan ที่จัดลำดับแล้ว

> ทดสอบใน **sandbox vault** ก่อน — agent มี write access จริง

---

## Quick Ask (`@` Trigger)

พิมพ์ `@` ขณะเขียน note → inline assistant ขึ้นทันที

```
@ สรุป section ก่อนหน้าเป็น 3 bullet point
@ แปลย่อหน้านี้เป็น formal English
@ หา typo และ grammar error
```

AI ตอบ inline — ไม่ต้อง copy-paste ไป chat window ใหม่

---

## Memory + Web Search ร่วมกัน

**Session แรก:**
```
จำไว้ว่า project "Alpha" คือ internal tool สำหรับ finance team
deadline ปลาย Q3 2026, tech stack: Python + FastAPI
```

**Session ถัดมา:**
```
อัปเดต progress note ของ Alpha
แล้ว search web ว่า FastAPI รองรับ async generator ใน Python 3.13 ไหม
```

Agent ดึง Memory + ค้น web ในคำสั่งเดียว

---

## Safe Practice สำหรับ Vault งานจริง

1. **ทดสอบใน sandbox vault ก่อน** — copy note ตัวแทนเข้าไปก่อน
2. **ใช้ Focus Sync เพื่อ scope** — จำกัดไม่ให้ agent อ่านทั้ง vault
3. **Back up ก่อน session ใหญ่** — `git commit -m "pre-agent snapshot"`
4. **แยก vault สำหรับ sensitive data** — passwords, PII ไม่ควรอยู่ vault เดียวกัน

---

## Caveats

| ข้อจำกัด | รายละเอียด |
|----------|-----------|
| ขัดกับ Smart Composer | ต้อง disable ก่อนใช้ |
| Mobile ไม่สมบูรณ์ | Agent Mode ยังไม่ full บน mobile |
| Write access จริง | อาจแก้/ลบ/ย้ายไฟล์ — sandbox ก่อน |
| API cost | Agent task เรียก LLM หลายรอบ |
| API key security | `.obsidian/` ห้ามอยู่ใน public git |
| Prompt injection | ระวัง untrusted content ใน vault |

---

## Key Takeaways

- YOLO = "You Orchestrate, LLM Operates" — เราเป็น director, LLM เป็น operator
- Agent Mode คือจุดเปลี่ยน: read → write → organize → connect ผ่าน MCP
- Quick Ask (`@`) คือ entry point friction น้อยที่สุด — ลองก่อนแล้วค่อย dive ลง Agent
- ติดตั้งผ่าน Community Plugins; ป้องกัน API key รั่ว (`.gitignore` ก่อน)
- ปี 2026: knowledge base ไม่ใช่แค่ "ที่เก็บ" — เป็น living workspace ของ AI agent
