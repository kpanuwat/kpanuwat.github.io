---
title: "AI Coding Workflow ที่มีประสิทธิภาพ: Smart Zone, Vertical Slices และ TDD"
date: 2026-05-31 06:38:00 +0700
categories: [Engineering]
tags: [ai, software-engineering, tdd, workflow, vertical-slices, kanban]
---

## TL;DR

Matt Pocock นำเสนอ workflow การทำงานกับ AI แบบ full walkthrough: เริ่มจากการเข้าใจ Smart/Dumb Zone ของ LLM, สร้าง Shared Design Concept ผ่านการ Grill, แปลงเป็น PRD, แบ่งงานเป็น Kanban Board ที่มี blocking relationship, ใช้ Vertical Slices แทนการ code แบบ horizontal, ควบคุมคุณภาพด้วย TDD และจัดโครงสร้างโค้ดแบบ Deep Modules เพื่อให้ AI navigate ได้ง่าย

## Background / Why this matters

ปัญหาหลักที่นักพัฒนาพบเมื่อทำงานกับ AI ไม่ใช่ว่า AI ไม่เก่ง — แต่เป็นเพราะ **ใช้ AI ผิดวิธี**: เขียน spec ยาวๆ แล้วหวังว่า AI จะสร้างทุกอย่างในคราวเดียว ผลลัพธ์คือ AI เข้า "dumb zone" กลางงาน output ออกมาผิดเพี้ยน และต้อง re-prompt จนงานยิ่งยุ่งเหยิง

Matt Pocock นำเสนอ workflow ที่สอดคล้องกับข้อจำกัดของ LLM จริงๆ ใน talk "Full Walkthrough: Workflow for AI Coding" ที่ AI Engineer Europe 2026 โดยอาศัยหลักการจาก software engineering ดั้งเดิมมาปรับใช้กับยุค AI โดยตรง

สิ่งที่ต่างจาก tutorial ทั่วไปคือ Pocock ไม่ได้แค่ "บอกว่าใช้ AI ยังไง" แต่อธิบาย **ว่าทำไม** workflow แต่ละขั้นถึงจำเป็น โดยอ้างอิงจากข้อจำกัดทางเทคนิคของ LLM ที่เปลี่ยนแปลงได้ยากในระยะสั้น

## Deep Dive

### 1. Smart Zone vs Dumb Zone — ข้อจำกัดพื้นฐานของ LLM

แนวคิดนี้มาจาก **Dex Hy** ผู้ก่อตั้ง Human Layer: เมื่อเริ่ม conversation ใหม่กับ LLM จะอยู่ใน **Smart Zone** — attention relationships ระหว่าง tokens ยังน้อย model คิดได้แม่นยำที่สุด

แต่ยิ่งเพิ่ม token มาก ความซับซ้อนจะ **scale แบบ quadratic** (O(n²)) — เหมือนการเพิ่มทีมใน football league ที่จำนวน match เพิ่มแบบกำลังสอง เมื่อถึงประมาณ **100,000 tokens (~40% ของ window)** model เข้า **Dumb Zone**: ตัดสินใจแย่ลง, error เพิ่ม, output ไม่สม่ำเสมอ

**สิ่งสำคัญ:** ตัวเลข 100K นี้ไม่ขึ้นกับขนาด context window ของ model — model ที่มี 1M context window ก็ยังเข้า dumb zone ที่ ~100K สำหรับ **งาน coding** เพราะ context เพิ่มเติมช่วยการ *retrieval* แต่ไม่ช่วย *reasoning* เหมือน Memento: ตัวละครอาจจำได้มากขึ้นแต่ยังตัดสินใจไม่ดีขึ้น

**วิธีแก้:** อย่า "compact" conversation ที่ยาว — **ล้าง context แล้วเริ่มใหม่** ทุกครั้งที่เริ่มงานใหม่ ทั้งนี้ขึ้นอยู่กับการออกแบบงานให้เล็กพอที่จะอยู่ใน smart zone เสมอ

### 2. Grill → Shared Design Concept → PRD

ก่อนจะให้ AI เขียนโค้ดแม้แต่บรรทัดเดียว ต้องสร้าง **shared design concept** ก่อน — ทฤษฎีล่องหนของสิ่งที่กำลังสร้าง (Fred Brooks) ที่ทั้งนักพัฒนาและ AI ต้องมีร่วมกัน

**ขั้นตอน:**
1. ใช้ "Grill Me" skill: ให้ AI ถามคำถาม 40–100 ข้อ จนทุก branch ของ design tree ถูก resolve
2. เมื่อ shared concept ชัดเจน ให้ AI สร้าง **PRD (Product Requirements Document)** — "destination document" ที่บันทึก:
   - Problem statement
   - User stories
   - Implementation decisions (ที่ตัดสินใจแล้วใน grill session)
   - Testing strategy
3. PRD ไม่ต้องอ่านละเอียด เพราะ developer และ AI ถูก align มาแล้วจากการ grill — PRD คือ **สิ่งที่ส่งต่อให้ Kanban**

PRD ทำงานเหมือน "long-term memory" สำหรับ AI: เมื่อเริ่ม context ใหม่ (เพื่อรักษา smart zone) AI ยังรู้ว่ากำลังสร้างอะไรอยู่

### 3. Kanban Board — แบ่งงานด้วย Markdown Issues

จาก PRD ให้ AI สร้าง **Kanban Board** ในรูปแบบ markdown files ที่มี:
- แต่ละ issue มี description + blocking dependencies ชัดเจน
- โครงสร้างเป็น **Directed Acyclic Graph (DAG)**: Task C ต้องรอ Task A เสร็จก่อน แต่ Task B ทำพร้อม A ได้
- Issues ที่ไม่มี blocking dependency สามารถทำ **parallel** ได้

**วิธีใช้:**
```
Day Shift (developer + AI):
  - Grill session → PRD → Kanban breakdown
  - Human reviews + approves the plan

Night Shift (autonomous agents):
  - Ralph Loop: อ่าน issue → implement ด้วย TDD → run tests → commit
  - Multiple agents ทำงาน parallel บน unblocked issues
  - Human reviews PRs ตอนเช้า
```

Kanban as markdown ดีกว่า Jira/Linear สำหรับ AI เพราะ: อ่านง่าย, อยู่ใน codebase, และ agent แก้ไข/อัปเดตได้โดยตรง

### 4. Vertical Slices / Tracer Bullets — หั่นงานแบบ End-to-End

แนวคิดจาก *The Pragmatic Programmer* (Thomas & Hunt): **tracer bullet** คือฟีเจอร์บางๆ ที่ตัดผ่านทุก layer ของระบบในคราวเดียว

**ปัญหาของ Horizontal Coding (AI Default):**
```
❌ Horizontal (แย่):
  Phase 1: Database schema ทั้งหมด
  Phase 2: API layer ทั้งหมด  
  Phase 3: Frontend ทั้งหมด
  → ไม่มี feedback จนถึง phase 3
  → error ที่ phase 3 บอกว่า root cause ที่ไหนไม่ได้
```

**Vertical Slice (ดี):**
```
✓ Vertical (ดี):
  Slice 1: DB change + service layer + minimal UI ของฟีเจอร์ A
  Slice 2: DB change + service layer + minimal UI ของฟีเจอร์ B
  → ทุก slice มี feedback loop ทันที
  → error ชัดเจน หา root cause ได้เร็ว
```

AI มีแนวโน้มที่จะ code แบบ horizontal โดยธรรมชาติ (เพราะ "สมบูรณ์กว่า" ในระยะสั้น) นักพัฒนาต้องบังคับให้ slice แบบ vertical อย่างชัดเจน ทั้งใน PRD และใน Kanban issues

### 5. TDD — Feedback Loop ที่ดีที่สุดสำหรับ AI

**Automated feedback loops** คือ "เพดาน" ของ AI coding quality — ยิ่งมี feedback ดีเท่าไร AI ก็ทำงานได้ดีเท่านั้น

**ทำไม TDD ถึงสำคัญเป็นพิเศษกับ AI:**

AI มักมี failure mode ที่เรียกว่า **"cheating"**: เมื่อให้ implement และ test พร้อมกัน AI มักเขียน test ที่ออกแบบมาเพื่อ pass implementation ที่แย่ ไม่ใช่ test ที่ตรวจสอบ behavior จริงๆ

TDD แก้ปัญหานี้โดยบังคับให้:
1. **RED**: เขียน test ก่อน (AI ยังไม่รู้ว่า implementation จะเป็นอะไร)
2. **GREEN**: implement ให้ test pass (scope จำกัดแคบมาก)
3. **REFACTOR**: ปรับปรุง code โดยไม่แตะ test

ขนาดของ step ต้องเล็กมาก — หนึ่ง test ต่อหนึ่ง cycle ไม่ใช่หลาย tests พร้อมกัน เพราะ step ใหญ่ = หาสาเหตุ error ยาก = กลับเข้า dumb zone เร็วขึ้น

### 6. Deep Modules — ทำให้ AI Navigate ได้โดยไม่ต้องอ่านทุกไฟล์

จาก *A Philosophy of Software Design* (Ousterhout): codebase ที่มี **shallow modules** (ไฟล์เล็กๆ เยอะๆ ที่ interconnect กัน) ทำให้ AI ต้องอ่าน context จำนวนมากเพื่อเข้าใจแม้แต่การเปลี่ยนแปลงเล็กน้อย — ดัน context เข้า dumb zone โดยตรง

**Deep Module** มี interface เรียบง่ายที่ซ่อน complexity ภายใน:
- AI รู้ว่า "กล่องนี้ทำอะไร" จาก interface โดยไม่ต้องอ่าน internal implementation
- ง่ายต่อการเขียน test ที่ครอบคลุม (test ที่ boundary ชัดเจน)
- Developer ออกแบบ interface → AI implement ภายใน "grey box"

โดยพฤตินัย Deep Modules ช่วยรักษา smart zone: AI ต้องการ context น้อยลงต่อ task เพราะ abstraction ที่ดีซ่อนสิ่งที่ไม่เกี่ยวข้องไว้

## Caveats / Limits

- **100K threshold เปลี่ยนได้**: Pocock ระบุว่าตัวเลขนี้จะขยายตามเวลา — ตรวจสอบ benchmark ล่าสุด เพราะ model architecture ก็พัฒนาต่อเนื่อง
- **Ralph Loop (Night Shift)** ยังเป็น experimental workflow — ต้องการ CI/CD + test suite ที่แข็งแรงก่อน ไม่ควรปล่อย agents ทำงาน autonomous บน codebase ที่ไม่มี automated checks
- **Grill → PRD ใช้เวลา**: ไม่เหมาะกับ bug fix เล็กๆ หรืองานที่ scope ชัดเจนแล้ว — ลงทุนแค่กับ feature ใหม่ที่ซับซ้อน
- **Vertical Slices ต้องการ planning skill**: การตัดสินใจว่าจะ slice ยังไงให้ทุก layer covered ต้องอาศัยความเข้าใจ architecture ลึก — ไม่ใช่สิ่งที่ AI ควรทำเอง
- **Kanban ใน markdown** scalable สำหรับ project เดียว แต่ multi-team ยังต้องการ tooling เพิ่ม

## References

1. [Full Walkthrough: Workflow for AI Coding — Matt Pocock (YouTube)](https://youtu.be/-QFHIoCo-Ko)
2. [Matt Pocock's workflow notes — Sean Weldon](https://www.sean-weldon.com/blog/2026-04-27-workflow-for-ai-coding-matt-pocock)
3. [Workflow for AI Coding — lecture notes (leomax.fyi)](https://leomax.fyi/blog/matt-pocock-workflow-for-ai-coding/)
4. [Matt Pocock: Why AI Coding's "Smart Zone" Is Only 100K Tokens (BigGo Finance)](https://finance.biggo.com/news/e7209c094224b09c)
5. [Matt Pocock's dictionary of AI coding (GitHub)](https://github.com/mattpocock/dictionary-of-ai-coding)
6. *The Pragmatic Programmer* — David Thomas, Andrew Hunt (Tracer Bullets concept)
7. *A Philosophy of Software Design* — John Ousterhout (Deep Modules concept)
8. Smart Zone / Dumb Zone concept originally from Dex Hy, Human Layer

## Key Takeaways

- **Smart Zone (~100K tokens)** คือขีดจำกัดที่ AI คิดได้ดี — เลยนั้นคือ Dumb Zone ที่ quality ตก; แก้ด้วยการ restart context บ่อยๆ ไม่ใช่ compact
- **Grill → PRD** คือจุดเริ่มต้นของทุก feature ใหม่ — ไม่มีโค้ดแม้แต่บรรทัดเดียวก่อน shared design concept ถูกสร้างขึ้น
- **Kanban Board (markdown)** แปลง PRD เป็น issues ที่มี blocking relationship — ให้ parallel agents ทำงาน night shift ได้
- **Vertical Slices** คือการบังคับให้ AI ตัดงานผ่านทุก layer (DB + API + UI) ในคราวเดียว — ป้องกัน horizontal coding ที่ไม่มี feedback loop
- **TDD** ป้องกัน AI จากการ "cheat" โดยเขียน test ก่อน implementation เสมอ — Red → Green → Refactor ทีละ step เล็กๆ
- **Deep Modules** ลด context ที่ AI ต้องอ่านต่อ task — ช่วยรักษา smart zone และทำให้ test boundary ชัดเจน
- Workflow ทั้งหมดนี้ไม่ได้ลด role ของ developer แต่เปลี่ยน focus ไปที่ **planning, architecture และ quality gate** — งานที่ AI ยังทำแทนไม่ได้
