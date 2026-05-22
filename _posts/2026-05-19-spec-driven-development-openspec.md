---
title: "Spec-Driven Development: ใช้ Spec เป็น Contract อุดรอยรั่วของ Vibe Coding"
date: 2026-05-19 00:03:00 +0700
categories: [Tools]
tags: [spec-driven-development, openspec, vibe-coding, ai-coding, llm, sddd]
slides: true
---

{% include slide-link.html %}

## TL;DR

Spec-Driven Development (SDDD) แก้จุดอ่อนของ Vibe Coding ด้วยการใช้ Specification เป็น Contract กำหนดขอบเขต พฤติกรรม และเงื่อนไขของระบบ _ก่อน_ ให้ AI เขียนโค้ด — ลด Ambiguity ของ AI Agent, เพิ่มความแม่นยำ, และทำให้ผลลัพธ์คาดเดาได้ OpenSpec คือ SDDD framework อันดับต้นของตลาดในปี 2025–2026 ด้วยความเบา ฟรี และออกแบบมาโดยเฉพาะสำหรับ Existing Systems

## Background / Why this matters

### ปัญหาของ Vibe Coding

Vibe Coding คือแนวทางพัฒนาแอปด้วย AI ที่เน้นการ Prompt ลอยๆ แล้วให้ LLM เดาใจ — เร็ว, ง่าย, แต่ผลลัพธ์ไม่เสถียร เพราะ AI Agent ต้องตีความ Intent จาก Context ที่ไม่ชัดเจน ทำให้เกิดปัญหาหลักสองอย่าง:

1. **Ambiguity** — AI ไม่รู้ขอบเขตงานจริง ทำมากไปบ้าง น้อยไปบ้าง หรือเบี่ยงไปทิศทางที่ผิด
2. **Instability** — ผลลัพธ์เปลี่ยนไปตาม Prompt phrasing แม้ Intent เดิม ทำให้ Reproduce ยาก และ Review ยากกว่า

### SDDD คืออะไร

Spec-Driven Development (SDDD) ยืมองค์ประกอบจาก SDLC (Software Development Lifecycle) แบบดั้งเดิม มาอุดรอยรั่วของ Vibe Coding โดยหัวใจของแนวคิดคือ:

> **Specification = Contract** ที่กำหนดขอบเขต พฤติกรรม และเงื่อนไขของระบบล่วงหน้า ก่อนเริ่มเขียนโค้ดจริง

ตัว Spec จึงกลายเป็น **Primary Artifact** ที่ควบคุมทุกขั้นตอนถัดไป ทั้ง code generation, TDD (Test-Driven Development), และ verification — แทนที่จะให้ AI ตัดสินใจเองทุกครั้ง

## Deep Dive

### ภาพรวมตลาด SDDD (ณ ปี 2025–2026)

ตลาด SDDD เติบโตขึ้น **131% ใน 6 เดือน** [2] สะท้อนว่าชุมชน AI coding เริ่มยอมรับว่า Vibe Coding บริสุทธิ์ไม่เพียงพอสำหรับโปรเจกต์จริง

ภาพแข่งขัน:

| Framework | สถานะ | จุดแข็ง |
|-----------|--------|---------|
| **OpenSpec** | ⬆ Stars/Downloads +863% | เบา, ฟรี, existing systems |
| **SpecKit (GitHub)** | ⬆ เติบโต | แบรนด์ GitHub, integration |
| **BMAT v6** | 🔄 Major update | Enterprise, feature-rich |
| **Taskmaster** | ⏸ ชะงัก | เคยโตแรง แต่เน้น commercial เกินไป |
| **Agent OS** | ❌ ยุติพัฒนา | — |

### Wild Card: Native Tooling

ตัวแปรสำคัญที่เปลี่ยนเกมคือ **Native Feature ของ AI coding tools** เช่น Claude Code's Plan Mode และ Ultra Plan Mode ที่ดูดซับความสามารถหลักของ SDDD Frameworks ไปแล้ว [2]

ผลคือกรอบการแข่งขันเปลี่ยนจาก "Framework A vs Framework B" เป็น "Framework vs Native Tooling" ทำให้ frameworks ที่ยังมีที่ยืนต้องนำเสนอ value ที่ native tools ทำไม่ได้ — เช่น artifact ที่ persist ข้ามเซสชัน, delta tracking, หรือการ integrate กับหลาย AI agent

### OpenSpec v1: Deep Dive

OpenSpec โดดเด่นด้วยการออกแบบ 5 คำสั่งหลักที่ครอบ lifecycle ทั้งหมด [3][4]:

```
openspec explore   → clarify ambiguity
openspec new       → create new spec slice
openspec continue  → continue spec slice
openspec validate  → completeness check
openspec archive   → merge deltas back to spec
```

#### `explore` — เคลียร์ความคลุมเครือก่อนแผน

ก่อนร่าง spec ใดๆ คำสั่ง `explore` ช่วยระบุและเคลียร์ Ambiguity ที่ยังเปิดอยู่ ป้องกันการเขียน spec บน assumption ที่ผิด

#### `new` + `continue` — Spec Slicing

SDDD ที่ดีไม่เขียน spec ทั้งระบบในครั้งเดียว แต่แบ่งเป็น **Slices** (ชิ้นย่อยที่จัดการได้) แต่ละ slice ให้ output 3 ไฟล์:

- **`design.md`** — Architecture spec: component, data flow, interface contract
- **`proposal.md`** — Scope spec: งานที่ต้องทำ, เงื่อนไข, acceptance criteria
- **To-do list** — Task breakdown พร้อม implement ได้เลย

#### `validate` — Completeness Scan

ใช้ Chrome Browser MCP เป็น interface ในการสแกนความสมบูรณ์ของ spec — ตรวจว่า requirement ครบ, ไม่มี gap, และ acceptance criteria วัดได้จริง [3]

#### `archive` — Source of Truth Maintenance

หลัง implement เสร็จ คำสั่ง `archive` **merge ไฟล์ delta** (ความเปลี่ยนแปลงที่เกิดระหว่าง implement) กลับไปอัปเดต spec หลัก ป้องกัน spec หลุดยุค (outdated) ในระยะยาว — ซึ่งเป็นปัญหาคลาสสิกของทีมที่เขียน spec แล้วไม่ maintain [3]

### OpenSpec vs SpecKit / Kiro

จุดต่างที่ชัดเจนที่สุดคือ **target use case** [4]:

| ด้าน | OpenSpec | GitHub SpecKit / Kiro |
|------|---------|----------------------|
| **สำหรับ** | Existing systems | New projects |
| **โครงสร้าง** | แยก current spec / proposal (delta) | spec ชุดเดียว |
| **ต้นทุน** | ฟรี | ฟรี/มี paid tier |
| **ขนาด** | Lightweight | Feature-rich |
| **Token cost** | ต่ำกว่า large frameworks | ขึ้นกับ implementation |
| **AI Agent support** | Claude Code, Cursor, Kilo Code | Claude Code, Cursor |

สำหรับโปรเจกต์ที่มีโค้ด legacy อยู่แล้ว การแยก "spec ปัจจุบัน" ออกจาก "proposal การแก้ไข" เป็น delta format ของ OpenSpec ทำให้ AI Agent เข้าใจ context ได้ดีกว่า และลด risk ที่จะ overwrite behavior เดิมโดยไม่ตั้งใจ

## User Guide (Step-by-Step)

### Workflow พื้นฐาน: Feature ใหม่บน Existing System

```
1. openspec explore "feature ที่ต้องการ"
   → AI ถามคำถามเพื่อเคลียร์ ambiguity
   → ตอบจนชัดก่อนไปต่อ

2. openspec new "feature-slug"
   → สร้าง design.md + proposal.md + todo list
   → review ก่อน implement

3. (implement งานตาม todo list)

4. openspec validate
   → scan ว่า spec ครบและ implementation ตรง

5. openspec archive
   → merge delta กลับ spec หลัก
   → spec ยังเป็น source of truth ต่อไป
```

### Integration กับ Claude Code

OpenSpec ทำงานร่วมกับ Claude Code ได้โดยตรง — ใช้ `proposal.md` และ `design.md` เป็น context ให้ Claude Code implement ตาม spec แทนการ prompt ลอยๆ ทำให้:

- Code generation แม่นยำขึ้น
- ผลลัพธ์คาดเดาได้
- Task verification ทำได้จาก acceptance criteria ใน proposal.md
- Token cost ต่ำกว่าการโหลด context ขนาดใหญ่ทั้งหมด

## Caveats / Limits

- **Learning curve**: SDDD เพิ่ม upfront work — ต้องเขียน spec ก่อน coding ซึ่งบางทีรู้สึกช้ากว่า vibe coding โดยเฉพาะงาน prototype
- **Native tooling pressure**: Claude Code Plan Mode ทำ spec-like planning ได้ในตัว ถ้าโปรเจกต์ไม่ต้องการ persistent artifacts ข้ามเซสชัน native tools อาจเพียงพอ
- **ข้อมูล market stats**: ตัวเลข +131% และ +863% มาจาก video ในช่วงเวลาหนึ่ง — ตัวเลขอาจเปลี่ยนแปลง ตรวจสอบ GitHub stars ปัจจุบันก่อนตัดสินใจ
- **Chrome Browser MCP**: ระบบ validate ของ OpenSpec พึ่ง Chrome Browser MCP ถ้า environment ไม่มี browser automation อาจต้อง skip หรือ adapt

## References

1. "Spec-Driven Development คืออะไร" — [https://youtu.be/mViFYTwWvcM](https://youtu.be/mViFYTwWvcM)
2. "ตลาด SDDD ปี 2025–2026" — [https://youtu.be/b6cbxSaa4U4](https://youtu.be/b6cbxSaa4U4)
3. "OpenSpec v1: explore, new, continue, validate, archive" — [https://youtu.be/nFq4POtqom4](https://youtu.be/nFq4POtqom4)
4. "OpenSpec vs SpecKit, Kiro" — [https://youtu.be/gHkdrO6IExM](https://youtu.be/gHkdrO6IExM)

## Key Takeaways

- **Spec = Contract**: SDDD ใช้ Specification เป็น Contract ที่กำหนดขอบเขตและพฤติกรรมก่อน AI เขียนโค้ด — ลด ambiguity อย่างมีนัยสำคัญ
- **Primary Artifact**: Spec ควบคุม code generation, TDD, และ verification ในขั้นตอนถัดไป
- **ตลาดโต 131%**: SDDD เป็น approach ที่ชุมชน AI coding เริ่มยอมรับอย่างกว้างขวาง
- **OpenSpec ชนะขาด**: +863% stars/downloads ด้วยความเบา ฟรี และเหมาะกับ existing systems
- **Native tools เป็น wildcard**: Claude Code Plan Mode ดูดซับ SDDD capability บางส่วน — SDDD frameworks ต้องนำเสนอ value ที่ native tools ทำไม่ได้ (persistent artifacts, delta tracking)
- **5 คำสั่งหลัก**: `explore` → `new`/`continue` → `validate` → `archive` ครอบ lifecycle ครบตั้งแต่ clarify จนถึง maintain spec
- **Delta format**: การแยก current spec / proposal เป็นจุดแข็งของ OpenSpec สำหรับ existing systems — ป้องกัน overwrite และทำให้ AI Agent เข้าใจ context ดีขึ้น
