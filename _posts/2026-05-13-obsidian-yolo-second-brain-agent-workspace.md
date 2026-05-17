---
title: "Obsidian YOLO: จาก Second Brain กลายเป็น Agent Workspace"
date: 2026-05-12 12:00:00 +0700
categories: [Obsidian]
tags: [obsidian, llm, agent, pkm, productivity]
slides: true
---

{% include slide-link.html %}

## TL;DR

Obsidian YOLO เปลี่ยน vault จาก "ที่เก็บโน้ต" เป็น "workspace ของ AI agent" — LLM อ่าน เขียน จัดระเบียบ และต่อ toolchain ใน vault ได้จริง โดยเราเป็นคนกำกับทิศทาง (You Orchestrate, LLM Operates)

## Background / Why this matters

ปัญหาของคนทำงานยุค AI ไม่ใช่ "ไม่มีโน้ต" อีกต่อไปแล้ว — แต่คือมีโน้ตเยอะเกินไปจนอ่านไม่ทัน meeting note, research, SOP, idea, backlog กองรวมกันอยู่ใน vault แต่สุดท้ายเรายังต้องเป็นคนไล่อ่านเองอยู่ดี

ตั้งแต่ยุค Getting Things Done (GTD) ของ David Allen จนมาถึง Second Brain ของ Tiago Forte paradigm ของ PKM หมุนรอบ **เราเป็นคนค้นและใช้ความรู้** AI generation แรก (ChatGPT, Claude chat) แก้ปัญหาการเขียน แต่ไม่ได้แก้ปัญหาของ knowledge base ที่กระจัดกระจาย

Obsidian YOLO เป็นสัญญาณว่า paradigm กำลังเปลี่ยน: จาก "เราค้นโน้ตเพื่อทำงาน" → "agent ทำงานใน vault แทนเรา"

เทียบกับ AI tools รุ่นก่อน เช่น Smart Composer, Copilot, Cursor — ทั้งหมดนั้น **passive** รอให้เราเปิด context ก่อน ถามก่อน แล้วค่อยตอบ และทำงานได้เฉพาะขณะที่ session เปิดอยู่เท่านั้น YOLO เปลี่ยนสมการ: agent ทำงานใน vault โดยตรง มีสิทธิ์อ่าน เขียน จัดระเบียบไฟล์ และต่อ tool ภายนอก — knowledge base ไม่ใช่แค่ "ที่เก็บ" อีกต่อไป แต่กลายเป็น living workspace ที่ AI เป็น co-worker ได้จริง

## Deep Dive

### แนวคิด YOLO: You Orchestrate, LLM Operates

ชื่อ YOLO ไม่ได้แปลว่า "You Only Live Once" ในบริบทนี้ แต่คือ **You Orchestrate, LLM Operates** — เราเป็นผู้กำกับทิศทาง (ตั้ง goal, เลือก scope, อนุมัติผล) ส่วน LLM เป็น operator ที่ลงมือทำใน vault จริง

ต่างจาก AI chat ทั่วไปตรงที่ LLM ไม่ได้แค่ "ตอบคำถาม" แต่ **มี agency** อ่านไฟล์ได้ แก้โน้ตได้ จัดระเบียบ folder ได้ ต่อ tool ภายนอกได้ (via MCP)

ในทางปฏิบัติ หมายความว่า LLM มีสิทธิ์: **read** โน้ตทุกไฟล์ที่ grant access ไว้, **write** เขียนหรือแก้ไขเนื้อหาได้, **organize** ย้ายไฟล์ จัด folder ใหม่, และ **connect** ต่อ external tool ผ่าน MCP protocol เพื่อดึงข้อมูลจาก API, calendar, หรือ task manager เข้ามา process ใน vault ได้โดยตรง ต่างจาก Cursor ที่ scope อยู่แค่ code editor, YOLO scope คือ personal knowledge base ทั้งหมด

### Feature ที่น่าสนใจ

**Agent Mode** — LLM ทำงานเป็น multi-step task ได้โดยไม่ต้องสั่งทีละบรรทัด เช่น "ดู project notes ทั้งชุด แล้วจัด action item เป็นแผนงาน" ใช้เมื่อต้องการ automate งานที่ซับซ้อนและต้องอ่านหลายไฟล์ก่อนตัดสินใจ — Agent เลือก tool ที่เหมาะสมและ execute ตามลำดับเอง

**Quick Ask (@ trigger)** — เรียก AI ใน flow การเขียนได้เลยโดยพิมพ์ `@` ใน editor โดยไม่ต้องเปลี่ยน context ไปเปิดอีกแอป เช่น "สรุป section นี้เป็น 3 bullet" หรือ "แปลย่อหน้านี้เป็นภาษาอังกฤษ" — AI ตอบ inline ในเอกสารเลย

**Smart Space / Cursor Chat / Tab Completion / Multi-window Chat** — หลายโหมดรองรับ workflow ที่แตกต่างกัน: Cursor Chat เพิ่ม context ด้วย one-click, Tab Completion ช่วย writing flow ต่อเนื่องไม่หยุด, Multi-window ให้รัน parallel tasks พร้อมกันในหลาย vault section

**Focus Sync** — AI รู้ว่าเรากำลังอ่านไฟล์ไหน อยู่ตำแหน่งไหน ทำให้ context ของ AI ตรงกับ context ของเรา ณ ขณะนั้น โดยไม่ต้อง copy-paste เนื้อหาเข้า chat window ใหม่ทุกครั้ง

**Built-in Web Search** — Agent ค้น web ได้โดยตรงผ่าน multiple search providers แล้ว synthesize กับ vault knowledge ได้ทันที เหมาะกับ research workflow ที่ต้องผสม external info กับ existing notes

**Memory System** — จำ context, preference, และ working habit ข้ามการสนทนาได้ ช่วยได้มากเมื่อทำงาน ongoing project ที่มี background context ซับซ้อนและไม่อยากต้อง re-brief ทุกครั้ง

**Native PDF Support** — อ่าน PDF ใน vault ได้ via vision model (Gemini / Claude) รองรับ region screenshot และ selection sync ทำให้ถาม agent เกี่ยวกับ research paper หรือเอกสาร contract ได้โดยตรงโดยไม่ต้อง copy ข้อความออกมาก่อน

### Timeline การพัฒนา

| Version | Feature หลัก |
|---------|-------------|
| 1.5.1 | Agent Mode |
| 1.5.2 | Memory System |
| 1.5.3 | Multi-window Chat + Background Agents |
| 1.5.4 | Smart context pruning, multi-model branches |
| 1.5.5 | Hybrid search & knowledge-base re-index |
| 1.5.6 | Built-in Web Search (multiple providers) |
| 1.5.7 | Focus Sync + Deep PDF support |
| 1.5.7.5 | Native PDF Input สำหรับ Gemini/Claude, context reliability |

เส้นทางนี้แสดงชัดว่า YOLO ไม่ได้แค่เพิ่ม feature — แต่กำลัง build toward "AI workspace ที่รู้ context ของเรา" อย่างเป็นระบบ

### Adoption signal

- **~34,000 downloads** บน Obsidian community plugin directory (ณ เวลาที่ผู้เขียนเช็ก) [1]
- **~1k GitHub stars**, 67 contributors, 84+ releases [2]

สำหรับ plugin ในหมวด experimental AI agent ตัวเลขนี้บ่งชี้ว่าคน Obsidian community กำลังมองหา "ระบบคิด + ระบบลงมือทำ" ในที่เดียว ไม่ใช่แค่ note-taking อีกต่อไป

## User Guide (Step-by-Step)

### ก่อนเริ่ม: ข้อกำหนดเบื้องต้น

- **Obsidian desktop** — YOLO เป็น desktop-first plugin; บาง feature ยังไม่ทำงานเต็มรูปแบบบน mobile
- **API key** หรือ OAuth จาก provider ที่ต้องการ (OpenAI, Claude, Gemini, Groq, DeepSeek)
- **Smart Composer ต้อง disable ก่อน** — ทั้งสอง plugin ไม่สามารถทำงานร่วมกันได้ [3]

### Step 1: ติดตั้ง Plugin

**วิธี A — Community Plugins (แนะนำ):**
1. เปิด Obsidian → `Settings` → `Community plugins` → `Browse`
2. ค้นหา `YOLO` → `Install` → `Enable`

**วิธี B — Manual Installation:**
1. ดาวน์โหลด `main.js`, `manifest.json`, `styles.css` จาก [Releases](https://github.com/Lapis0x0/obsidian-yolo/releases) [3]
2. สร้าง folder: `<vault>/.obsidian/plugins/obsidian-yolo/`
3. วางไฟล์ทั้งสามในนั้น
4. กลับไปที่ `Settings` → `Community plugins` → เปิด toggle ที่ชื่อ YOLO

### Step 2: ตั้งค่า LLM Provider

เปิด `Settings` → `YOLO` แล้วเลือก provider และใส่ API key:

| Provider | ที่มา API Key |
|---------|--------------|
| OpenAI | platform.openai.com/api-keys |
| Claude (Anthropic) | console.anthropic.com/settings/keys |
| Google Gemini | aistudio.google.com/apikey |
| Groq | console.groq.com/keys |

> **Security note:** API key ถูกเก็บไว้ใน `.obsidian/plugins/obsidian-yolo/data.json` — ตรวจสอบให้แน่ใจว่า `.obsidian/` ไม่ได้อยู่ใน public git repository หรือ unencrypted cloud sync

### Step 3: First Agent Task

เปิด YOLO sidebar แล้วส่ง prompt แรก:

**ตัวอย่าง scenario:** มี project notes กระจายใน folder "Projects/Alpha" อยากจัดเป็น weekly plan

```
ดู note ทั้งหมดใน folder "Projects/Alpha" แล้วสรุป action item ที่ยังค้างอยู่
จัดลำดับตาม priority แล้วเขียนเป็น weekly plan ลง "Planning/week-2026-W20.md"
```

Agent จะ: (1) อ่านทุกไฟล์ใน folder ที่ระบุ, (2) extract action item และ deadline, (3) สร้างไฟล์ใหม่พร้อม weekly plan ที่จัดลำดับแล้ว

> ครั้งแรกควรทดสอบใน **sandbox vault** ก่อน — agent มี write access จริงและสามารถแก้ไขไฟล์ได้

### Step 4: Quick Ask (@ Trigger)

ขณะกำลังเขียน note ให้พิมพ์ `@` เพื่อเรียก inline assistant ขึ้นมาทันที

**ตัวอย่าง use cases:**

```
@ สรุป section ก่อนหน้าเป็น 3 bullet point
@ แปลย่อหน้านี้เป็นภาษาอังกฤษ formal tone
@ หา typo และ grammar error ใน paragraph นี้
```

AI ตอบ inline ใน editor เดิม ไม่ต้องออกไปเปิด chat window หรือ copy-paste เนื้อหา

### Step 5: Memory + Web Search ร่วมกัน

เมื่อ Memory system เปิดใช้งาน agent จำ context ข้ามการสนทนาได้ ตัวอย่าง:

**Session แรก:**
```
จำไว้ว่า project "Alpha" คือ internal tool สำหรับ finance team
deadline ปลาย Q3 2026, tech stack: Python + FastAPI
```

**Session ถัดมา:**
```
อัปเดต progress note ของ Alpha แล้ว search web ว่า FastAPI รองรับ async generator ใน Python 3.13 ไหม
```

Agent ดึง context จาก Memory + ค้น web ในคำสั่งเดียว โดยไม่ต้อง re-explain background ซ้ำ

### Step 6: PDF Workflow

ลาก PDF เข้า vault แล้วใช้ YOLO อ่านด้วย vision model:

```
อ่าน PDF "research/paper-2026-05.pdf" แล้วสรุป methodology section
พร้อมระบุ dataset ที่ใช้และ evaluation metric ทั้งหมด
```

Vision model (Gemini / Claude) อ่าน PDF โดยตรง รองรับ region screenshot และ selection sync ทำให้ถาม follow-up เกี่ยวกับ figure หรือ table เฉพาะส่วนได้ [5]

### Step 7: Safe Practice สำหรับ Vault งานจริง

ก่อน deploy YOLO ใน vault หลัก:

1. **ทดสอบใน sandbox vault ก่อน** — สร้าง vault ใหม่แยก copy note ตัวแทนเข้าไป แล้วทดสอบ Agent Mode ที่นั่น
2. **ใช้ Focus Sync เพื่อ scope** — เปิดไฟล์ที่ต้องการก่อน แล้วส่ง prompt เพื่อจำกัด scope ไม่ให้ agent อ่านทั้ง vault
3. **Back up ก่อน session ใหญ่** — ถ้า vault ใช้ git: `git commit -m "pre-agent snapshot"` ก่อนรัน Agent task ที่ write หลายไฟล์
4. **แยก vault สำหรับ sensitive data** — passwords, private keys, PII ไม่ควรอยู่ใน vault เดียวกับ YOLO ที่เปิดอยู่

### Troubleshooting

| ปัญหา | สาเหตุ | แก้ไข |
|-------|--------|-------|
| Plugin error ตั้งแต่ enable | Smart Composer ยังเปิดอยู่ | Settings → Community plugins → Disable Smart Composer ก่อน |
| Agent ตอบ "rate limit exceeded" | API quota หมดหรือ request ถี่เกิน | ตรวจ usage dashboard ของ provider; พิจารณาเพิ่ม tier |
| Feature (Agent Mode) ไม่ทำงาน | กำลังใช้ mobile หรือ YOLO version เก่า | อัปเดต plugin; ย้ายไป desktop สำหรับ full feature set |

## Caveats / Limits

**ไม่เข้ากันกับ Smart Composer** — ต้อง disable หรือ uninstall Smart Composer ก่อนใช้ YOLO มิฉะนั้นจะเกิด conflict [3]

**Mobile ยังไม่สมบูรณ์** — desktop-first; บาง feature (เช่น Agent Mode, background agents) ยังไม่ทำงานเต็มรูปแบบบน mobile

**Agent มี write access** — ถ้า Agent Mode ทำงานใน vault งานจริงที่มีไฟล์สำคัญ ควรเริ่มทดลองจาก folder หรือ vault สำรองก่อน เพราะนี่ไม่ใช่แค่ chatbot — agent สามารถแก้/ลบ/ย้ายไฟล์ได้

**API cost** — ทุก Agent task เรียก LLM หลายรอบ ควรตั้ง rate limit หรือ budget alert กับ provider ที่ใช้

**API key security** — YOLO เก็บ API key ไว้ใน `.obsidian/plugins/obsidian-yolo/data.json` ใน vault ถ้า vault sync ผ่าน Git, iCloud, หรือ Dropbox และ `.obsidian/` ไม่ได้ถูก exclude ไว้ — key อาจรั่วออกไปได้ ควรเพิ่ม `.obsidian/plugins/*/data.json` ลงใน `.gitignore` หรือ cloud exclude list

**Prompt injection risk** — agent อ่านเนื้อหาใน vault ได้โดยตรง ถ้า vault มีโน้ตที่ดึงมาจาก web หรือ external source ที่มี instruction ออกแบบมาเพื่อ hijack agent (เช่น "ignore previous instructions...") อาจทำให้ agent ทำงานไม่ตามที่ต้องการ ควรระวังใน vault ที่มีเนื้อหา untrusted จำนวนมาก

**Model recommendation** — ไม่ใช่ทุก feature ทำงานได้ดีกับทุก model: PDF vision ต้องการ model ที่รองรับ vision (Gemini Flash, Claude Sonnet ขึ้นไป); สำหรับ Agent Mode ที่ต้องใช้ multi-step reasoning Claude หรือ Gemini Pro ให้ผลดีกว่า Groq ในงานที่ซับซ้อน

## References

1. [YOLO – Obsidian Plugin Stats](https://www.obsidianstats.com/plugins/yolo) — download count (point-in-time)
2. [obsidian-yolo GitHub Repository](https://github.com/Lapis0x0/obsidian-yolo) — stars, contributors, releases
3. [obsidian-yolo Releases & Changelog](https://github.com/Lapis0x0/obsidian-yolo/releases) — version history
4. [Obsidian Community Plugins](https://obsidian.md/plugins) — official plugin directory
5. [obsidian-yolo README](https://github.com/Lapis0x0/obsidian-yolo/blob/main/README.md) — installation guide, supported providers, feature overview

## Key Takeaways

- YOLO = "You Orchestrate, LLM Operates" — เราเป็น director, LLM เป็น operator
- จุดเปลี่ยนจาก plugin อื่นคือ Agent Mode ที่ทำ multi-step task ใน vault ได้จริง: read, write, organize, connect ผ่าน MCP
- Timeline 1.5.x แสดงว่า plugin กำลัง build toward context-aware AI workspace อย่างมีทิศทาง
- ติดตั้งได้ผ่าน Community Plugins โดยตรง; API key ตรวจสอบว่า `.obsidian/` ไม่รั่วผ่าน git/cloud sync
- Quick Ask (`@`) คือ entry point ที่ใช้บ่อยที่สุดและ friction น้อยที่สุด — ลองก่อนแล้วค่อย dive ลง Agent Mode
- ใช้กับ vault งานจริง ควรเริ่มจาก sandbox vault ก่อน — agent มี write access จริง
- ปี 2026 knowledge base ไม่ใช่แค่ที่เก็บความรู้ แต่กลายเป็นพื้นที่ทำงานของ AI agent ที่ active อยู่ตลอด
