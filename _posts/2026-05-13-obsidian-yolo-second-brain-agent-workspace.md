---
title: "Obsidian YOLO: จาก Second Brain กลายเป็น Agent Workspace"
date: 2026-05-12 12:00:00 +0700
categories: [Obsidian]
tags: [obsidian, llm, agent, pkm, productivity]
---

## TL;DR

Obsidian YOLO เปลี่ยน vault จาก "ที่เก็บโน้ต" เป็น "workspace ของ AI agent" — LLM อ่าน เขียน จัดระเบียบ และต่อ toolchain ใน vault ได้จริง โดยเราเป็นคนกำกับทิศทาง (You Orchestrate, LLM Operates)

## Background / Why this matters

ปัญหาของคนทำงานยุค AI ไม่ใช่ "ไม่มีโน้ต" อีกต่อไปแล้ว — แต่คือมีโน้ตเยอะเกินไปจนอ่านไม่ทัน meeting note, research, SOP, idea, backlog กองรวมกันอยู่ใน vault แต่สุดท้ายเรายังต้องเป็นคนไล่อ่านเองอยู่ดี

ตั้งแต่ยุค Getting Things Done (GTD) ของ David Allen จนมาถึง Second Brain ของ Tiago Forte paradigm ของ PKM หมุนรอบ **เราเป็นคนค้นและใช้ความรู้** AI generation แรก (ChatGPT, Claude chat) แก้ปัญหาการเขียน แต่ไม่ได้แก้ปัญหาของ knowledge base ที่กระจัดกระจาย

Obsidian YOLO เป็นสัญญาณว่า paradigm กำลังเปลี่ยน: จาก "เราค้นโน้ตเพื่อทำงาน" → "agent ทำงานใน vault แทนเรา"

## Deep Dive

### แนวคิด YOLO: You Orchestrate, LLM Operates

ชื่อ YOLO ไม่ได้แปลว่า "You Only Live Once" ในบริบทนี้ แต่คือ **You Orchestrate, LLM Operates** — เราเป็นผู้กำกับทิศทาง (ตั้ง goal, เลือก scope, อนุมัติผล) ส่วน LLM เป็น operator ที่ลงมือทำใน vault จริง

ต่างจาก AI chat ทั่วไปตรงที่ LLM ไม่ได้แค่ "ตอบคำถาม" แต่ **มี agency** อ่านไฟล์ได้ แก้โน้ตได้ จัดระเบียบ folder ได้ ต่อ tool ภายนอกได้ (via MCP)

### Feature ที่น่าสนใจ

**Agent Mode** — LLM ทำงานเป็น multi-step task ได้โดยไม่ต้องสั่งทีละบรรทัด เช่น "ดู project notes ทั้งชุด แล้วจัด action item เป็นแผนงาน"

**Quick Ask (@ trigger)** — เรียก AI ใน flow การเขียนได้เลยโดยไม่ต้องเปลี่ยน context ไปเปิดอีกแอป เป็นความต่างระหว่าง "ออกไปถาม" กับ "AI อยู่ตรงที่เรากำลังคิด"

**Smart Space / Cursor Chat / Tab Completion / Multi-window Chat** — หลายโหมดรองรับ workflow ที่แตกต่างกัน ทั้ง deep work, quick lookup, และ background automation

**Focus Sync** — AI รู้ว่าเรากำลังอ่านไฟล์ไหน อยู่ตำแหน่งไหน ทำให้ context ของ AI ตรงกับ context ของเรา ณ ขณะนั้น

**Built-in Web Search** — Agent ค้น web ได้โดยตรง รวมกับ vault knowledge ได้เลย

**Memory System** — จำ context ข้ามการสนทนาได้ ไม่ต้อง re-brief ทุกครั้ง

**Native PDF Support** — อ่าน PDF ใน vault ได้ via vision (Gemini / Claude) รวมถึง region screenshot และ selection sync

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

## Caveats / Limits

**ไม่เข้ากันกับ Smart Composer** — ต้อง disable หรือ uninstall Smart Composer ก่อนใช้ YOLO มิฉะนั้นจะเกิด conflict [3]

**Mobile ยังไม่สมบูรณ์** — desktop-first; บาง feature (เช่น Agent Mode, background agents) ยังไม่ทำงานเต็มรูปแบบบน mobile

**Agent มี write access** — ถ้า Agent Mode ทำงานใน vault งานจริงที่มีไฟล์สำคัญ ควรเริ่มทดลองจาก folder หรือ vault สำรองก่อน เพราะนี่ไม่ใช่แค่ chatbot — agent สามารถแก้/ลบ/ย้ายไฟล์ได้

**API cost** — ทุก Agent task เรียก LLM หลายรอบ ควรตั้ง rate limit หรือ budget alert กับ provider ที่ใช้

## References

1. [YOLO – Obsidian Plugin Stats](https://www.obsidianstats.com/plugins/yolo) — download count (point-in-time)
2. [obsidian-yolo GitHub Repository](https://github.com/Lapis0x0/obsidian-yolo) — stars, contributors, releases
3. [obsidian-yolo Releases & Changelog](https://github.com/Lapis0x0/obsidian-yolo/releases) — version history
4. [Obsidian Community Plugins](https://obsidian.md/plugins) — official plugin directory

## Key Takeaways

- YOLO = "You Orchestrate, LLM Operates" — เราเป็น director, LLM เป็น operator
- จุดเปลี่ยนจาก plugin อื่นคือ Agent Mode ที่ทำ multi-step task ใน vault ได้จริง
- Timeline 1.5.x แสดงว่า plugin กำลัง build toward context-aware AI workspace อย่างมีทิศทาง
- ใช้กับ vault งานจริง ควรเริ่มจาก sandbox folder ก่อน — agent มี write access
- ปี 2026 knowledge base ไม่ใช่แค่ที่เก็บความรู้ แต่กลายเป็นพื้นที่ทำงานของ AI agent
