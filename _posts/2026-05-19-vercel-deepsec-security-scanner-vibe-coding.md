---
title: "Vercel deepsec: เครื่องมือสแกนช่องโหว่ Open-source สำหรับ Vibe Coding"
date: 2026-05-19 00:02:00 +0700
categories: [Tools]
tags: [vercel, security, vibe-coding, owasp, open-source, ai-agent]
slides: true
---

{% include slide-link.html %}

## TL;DR

Vercel เปิดตัว **deepsec** — open-source security harness ที่ใช้ AI Coding Agents สแกนหาช่องโหว่ใน codebase ขนาดใหญ่ผ่าน 5-stage pipeline: `scan` (Regex) → `process` (AI) → `revalidate` → `enrich` → `export` ออกแบบมาสำหรับ Vibe coding workflow โดยเฉพาะ

## Background / Why this matters

Vibe coding — การเขียนโค้ดโดยใช้ AI ช่วย generate — ทำให้ velocity สูงขึ้นมากแต่ security review ตามไม่ทัน นักพัฒนาสามารถ ship feature ได้ในชั่วโมง แต่ช่องโหว่ที่ AI สร้างขึ้นโดยไม่ตั้งใจมักซ่อนอยู่ใน data flow ที่ซับซ้อน

ปัญหาหลักของ Vibe coding security มี 3 ข้อ:

- **Scale**: repo ที่ generate ด้วย AI อาจมีหมื่นบรรทัดในวันเดียว — human code review ครอบคลุมไม่ไหว
- **Context loss**: LLM ที่ generate โค้ดไม่ได้ trace data flow ข้าม module — ช่องโหว่เกิดที่ boundary
- **OWASP gap**: injection, missing rate limiting, insecure deserialization — ไม่มีใน default prompt ของ AI coding tools

deepsec แก้ปัญหานี้โดยเป็น "security agent" ที่ทำงานแบบ automated — ไม่ใช่ linter แบบ static แต่ใช้ LLM ที่เข้าใจ semantic ของโค้ด

## Deep Dive

### Pipeline 5 ขั้นตอน

deepsec ทำงานเป็น sequential pipeline โดยแต่ละ stage มีหน้าที่ชัดเจน:

| Stage | Command | วิธีทำงาน | ใช้ AI? |
|-------|---------|-----------|---------|
| 1 | `scan` | ใช้ Regex หา candidate files ที่มีโค้ดน่าสงสัย | ไม่ (เร็ว, ฟรี) |
| 2 | `process` | AI agent วิเคราะห์เชิงลึก: trace data flow + ตรวจ mitigation | ใช่ |
| 3 | `revalidate` | AI agent ตัวที่สองตรวจซ้ำ + ตรวจ git history ว่า fix แล้วหรือยัง | ใช่ |
| 4 | `enrich` | เพิ่ม git metadata — ใครเขียนโค้ดส่วนนั้น (สำหรับ assign fix) | ไม่ |
| 5 | `export` | ส่งออกรายงาน JSON หรือ Markdown | ไม่ |

การแยก `scan` (Regex) ออกจาก `process` (LLM) เป็น design choice สำคัญ — ช่วยลด API cost โดย LLM จะเรียกเฉพาะ files ที่ผ่าน filter ก่อนแล้วเท่านั้น

### คำสั่งเพิ่มเติม

นอกจาก 5 stage หลักยังมี:

| Command | วัตถุประสงค์ |
|---------|-------------|
| `process --diff` | PR mode — สแกนเฉพาะ files ที่เปลี่ยนใน PR ปัจจุบัน |
| `triage` | จัด severity แบบ lightweight ด้วย model ถูกกว่า |
| `report` | สรุปรายงาน Markdown + JSON ระดับ project |
| `metrics` | นับจำนวน vulnerability ข้าม projects |
| `sandbox <cmd>` | รัน commands บน Vercel Sandbox microVMs เพื่อ scale แบบ parallel |

### AI Models ที่ใช้

deepsec ใช้ Claude Opus 4.7 (extended thinking) และ GPT-5.5 (xhigh reasoning) ในขั้น `process` — เลือก model ที่มี reasoning ลึกเพราะ security analysis ต้องการ multi-step trace ไม่ใช่แค่ pattern match

### Scale ผ่าน Vercel Sandboxes

สำหรับ repo ขนาดใหญ่ deepsec รองรับ fan-out ไปยัง Vercel Sandbox microVMs — แทนที่จะรัน sequential บน local machine สามารถ distribute workers แบบ parallel ได้ ซึ่งลดเวลาจากหลายวันเหลือชั่วโมง

## User Guide (Step-by-Step)

### 1. ติดตั้ง deepsec

```bash
npx deepsec init   # bootstrap ใน repo root → สร้าง .deepsec/
cd .deepsec
pnpm install       # ติดตั้ง dependencies
```

ตั้งค่า API key (เลือกอย่างใดอย่างหนึ่ง):

```bash
# ตัวเลือก A: Vercel AI Gateway
export AI_GATEWAY_API_KEY="your-key"

# ตัวเลือก B: ใช้ key ของตัวเองโดยตรง
export ANTHROPIC_API_KEY="your-key"
export OPENAI_API_KEY="your-key"
```

### 2. สแกนหา candidate files (ไม่ใช้ AI)

```bash
pnpm deepsec scan
```

ผลลัพธ์: รายการ files ที่ Regex ระบุว่ามี pattern น่าสงสัย เช่น `db.query(` ที่ไม่ sanitize input หรือ `req.body` ที่ไม่มี validation — เร็วและไม่เสีย API cost

### 3. วิเคราะห์เชิงลึกด้วย AI

```bash
# สแกนทั้ง repo
pnpm deepsec process

# PR mode — เฉพาะ files ที่เปลี่ยน (เหมาะสำหรับ CI/CD)
pnpm deepsec process --diff
```

AI agent จะ trace data flow ข้าม files ตรวจว่า input validation, authentication, rate limiting ครบถ้วนไหม รายงานออกมาเป็น findings พร้อม severity

### 4. ลด false positive ด้วย revalidate

```bash
pnpm deepsec revalidate
```

AI agent ตัวที่สองตรวจ findings ซ้ำ + ดู git history ว่ามีใครแก้ไขปัญหานี้แล้วหรือยัง ช่วยลด false positive จาก ~30-40% เหลือ ~10-20%

### 5. ส่งออกรายงาน

```bash
pnpm deepsec enrich    # เพิ่มข้อมูลว่าใครต้องแก้
pnpm deepsec export    # JSON หรือ Markdown
pnpm deepsec report    # สรุป project-level
```

ผลลัพธ์: รายงาน structured ที่ระบุ vulnerability, severity, ไฟล์ที่มีปัญหา, และชื่อผู้รับผิดชอบ — พร้อม assign เป็น ticket ได้ทันที

### 6. ใช้กับ Spec-driven tools

บริบทจาก deepsec report สามารถส่งต่อให้ tools อย่าง OpenSpec เพื่อ generate fix plan ได้ — deepsec บอกว่า "ตรงไหนที่เสี่ยง" ส่วน OpenSpec ช่วย "วางแผนแก้อย่างไร" ก่อน implement จริง

## Caveats / Limits

- **False positive rate ~10-20%**: แม้ revalidate ลดได้แล้วก็ยังต้องมี human review ขั้นสุดท้าย
- **ไม่เหมาะกับ libraries/frameworks**: ออกแบบมาสำหรับ applications/services ที่มี request-response flow — library ที่ไม่มี entry point ชัดเจนจะวิเคราะห์ยาก
- **Large repo = เวลานาน**: สแกน repo ใหญ่บน single machine อาจใช้เวลาหลายวัน ต้องใช้ Vercel Sandboxes เพื่อ distribute
- **ต้องการ API key**: ไม่ฟรีสมบูรณ์ — `process` และ `revalidate` เรียก Claude/GPT API ซึ่งมีค่าใช้จ่ายตาม token
- **ไม่ใช่ real-time**: ทำงานแบบ batch scan ไม่ใช่ inline IDE suggestion — ใช้คู่กับ IDE security plugin ไม่ใช่แทนกัน

## References

1. [Introducing deepsec — Vercel Blog](https://vercel.com/blog/introducing-deepsec-find-and-fix-vulnerabilities-in-your-code-base) — announcement + architecture overview
2. [vercel-labs/deepsec — GitHub](https://github.com/vercel-labs/deepsec/) — source code, CLI docs, install instructions (Apache 2.0)
3. [deepsec: AI-Powered Vulnerability Scanner — YouTube](https://youtu.be/hTpHmLFXBrc) — demo walkthrough

## Key Takeaways

- deepsec ใช้ 5-stage pipeline: `scan` (Regex, ฟรี) → `process` (AI วิเคราะห์) → `revalidate` (ลด false positive) → `enrich` (git ownership) → `export` (รายงาน)
- ออกแบบมาสำหรับ Vibe coding — scan ทั้ง repo ใหญ่ได้ ไม่ใช่แค่ per-PR
- `revalidate` ตรวจ git history เพื่อยืนยันว่า fix แล้วหรือยัง ลด false positive เหลือ ~10-20%
- scale ผ่าน Vercel Sandboxes microVMs สำหรับ parallel execution
- open-source Apache 2.0; ต้องการ Anthropic หรือ OpenAI API key สำหรับขั้น AI analysis
