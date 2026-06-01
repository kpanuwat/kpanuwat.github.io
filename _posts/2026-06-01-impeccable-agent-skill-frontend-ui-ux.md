---
title: "Impeccable: Agent Skill ที่เปลี่ยน AI Frontend จาก Slop เป็นงานคุณภาพระดับ Design Director"
date: 2026-05-31 06:44:00 +0700
categories: [Tools]
tags: [frontend, ui-ux, claude-code, design, agent-skill, ai-slop, open-source]
---

## TL;DR

Impeccable คือ Agent Skill open-source ที่ติดตั้งบน Claude Code (และ AI coding agents อื่น) เพื่อยกระดับผลลัพธ์ frontend จาก "AI slop" — งานที่ดูสำเร็จรูป จืด ไม่มีเอกลักษณ์ — ให้กลายเป็นงาน UI/UX คุณภาพสูงผ่านชุดคำสั่ง 23 คำสั่ง, ระบบตรวจ anti-pattern อัตโนมัติ 41 กฎ, และไฟล์ context ที่ช่วยให้ AI "จำ" design language ของโปรเจกต์ได้ข้ามเซสชัน

## Background / Why This Matters

ปัญหาที่ผู้ใช้ AI coding agents เจอบ่อยคือ **"AI Slop"** — ผลลัพธ์ UI ที่ดูเหมือนกันทุกโปรเจกต์: purple gradient, glassmorphism, bounce animation, padding ไม่พอ, contrast ต่ำ สาเหตุไม่ใช่ AI โง่ แต่เป็นเพราะ AI ขาด design vocabulary ที่ชัดเจน และขาด context เฉพาะโปรเจกต์ เวลาบอกว่า "ทำให้สวยขึ้น" AI แปลว่า "ใส่ gradient เพิ่ม"

Paul Bakaus ผู้สร้าง Impeccable พัฒนาต่อจาก `frontend-design` skill เดิมของ Anthropic โดยตั้งโจทย์ว่า: ถ้า AI มี shared design vocabulary เดียวกับเรา — รู้ว่า "polish" หมายถึงอะไร, รู้ว่า "bolder" หมายถึงอะไรใน context นี้ — ผลลัพธ์จะต่างกันมาก

ผลคือ Impeccable ได้รับ GitHub stars 32,1k+ และถูก adopt โดย community ที่ใช้ Claude Code, Cursor, Gemini CLI, Codex CLI อย่างกว้างขวาง

## Deep Dive

### สถาปัตยกรรมหลัก: Context Files

เมื่อ run `/impeccable init` ครั้งแรก AI จะอ่านโปรเจกต์แล้วสร้างไฟล์ 2 ไฟล์:

- **`PRODUCT.md`** — brief ของโปรเจกต์: เป็น product อะไร, target user คือใคร, tone และ brand direction
- **`DESIGN.md`** — design system ที่ extract จาก codebase จริง: color tokens, typography scale, component patterns, spacing conventions

ไฟล์ทั้งสองนี้ load อัตโนมัติพร้อมทุกคำสั่ง Impeccable ทำให้ทุก critique และทุก polish ทำ **ภายใต้ context ของโปรเจกต์นั้น** ไม่ใช่ generic defaults

Impeccable ยังรองรับ **dual-mode operation**:
- **Brand register** — สำหรับ landing pages, marketing sites: เน้น visual impact, uniqueness
- **Product register** — สำหรับ dashboards, SaaS apps: เน้น clarity, consistency, usability

### 23 คำสั่งแบ่งตามหน้าที่

| กลุ่ม | คำสั่ง | หน้าที่ |
|-------|--------|--------|
| **Setup** | `init`, `document`, `extract` | สร้าง context files, generate DESIGN.md, pull tokens |
| **Review** | `critique`, `audit`, `harden` | UX review, accessibility/performance check, defensive hardening |
| **Polish** | `polish`, `distill`, `clarify` | final pass ก่อน ship, ลด visual noise, ปรับ clarity |
| **Design** | `typeset`, `colorize`, `layout`, `animate` | ปรับ typography / color / spacing / motion |
| **Creative** | `bolder`, `quieter`, `delight`, `overdrive` | เพิ่ม/ลด visual intensity, เพิ่ม delight moments |
| **Workflow** | `onboard`, `shape`, `adapt`, `live` | context onboarding, component shaping, responsive, live mode |

#### คำสั่งที่ใช้บ่อยที่สุด

**`/impeccable critique`** — เปรียบเหมือนขอ Design Director ตรวจงาน: AI อ่าน PRODUCT.md + DESIGN.md แล้ว comment แบบ structured ว่าอะไรผิดพลาด, ทำไม, และควรแก้อย่างไร ไม่ใช่แค่ "ดูไม่สวย" แต่ระบุ rule ที่ละเมิด

**`/impeccable audit`** — ตรวจ accessibility (WCAG contrast, heading hierarchy, focus states), performance (render-blocking, image optimization), และ semantic HTML ทั้ง deterministic และ LLM pass

**`/impeccable polish`** — final sweep ก่อน ship: ตรวจ spacing consistency, micro-copy quality, animation timing, responsive breakpoints ทำให้งาน "ดูเสร็จ" จริงๆ ไม่ใช่แค่ "functional"

### Anti-Pattern Detection: Desloppification

นี่คือ feature ที่โดดเด่นที่สุด — ระบบตรวจ "AI slop signatures" แบบอัตโนมัติ

**41 deterministic rules** ทำงานโดยไม่ต้องใช้ LLM เลย:
- Purple/teal gradients ที่ไม่มี brand rationale
- Glassmorphism ที่ใช้เกินควร
- Side-stripe borders ที่เป็น AI default
- `bounce` easing บน non-playful UI
- Inadequate padding (`< 8px` บน interactive elements)
- Skipped heading levels (`h1` → `h3` ไม่มี `h2`)
- AI color palettes ที่ recognizable เกินไป

**12-rule LLM critique pass** สำหรับ judgment calls ที่ต้องการ semantic understanding:
- ความเหมาะสมของ visual hierarchy กับ content importance
- Tone consistency ระหว่าง copy และ visual design
- Whether animation adds meaning หรือแค่ distraction

**CLI integration:**
```bash
npx impeccable detect src/
```
รันได้ใน CI pipeline โดยไม่ต้องมี API key — fail build เมื่อ slop patterns ถูกตรวจเจอ

### Live Mode (Beta)

feature ที่กำลัง develop คือ **live iteration loop**:
1. เปิด dev server ตามปกติ
2. Select element ใน browser
3. ใส่ design note ("too much whitespace here", "heading feels weak")
4. Impeccable generate 3 variants ผ่าน framework HMR
5. เลือก variant → ไฟล์ source แก้ไขทันที

ทำให้ design iteration เกิดใน context ของ running app จริง ไม่ใช่แค่บน static mockup

## User Guide (Step-by-Step)

### Installation

**วิธีที่ 1 — Claude Code Plugin (แนะนำ):**
```
/plugin marketplace add pbakaus/impeccable
```

**วิธีที่ 2 — CLI Installer:**
```bash
npx impeccable skills install
```
ตัวนี้ support ทั้ง Claude Code, Cursor, Gemini CLI, Codex CLI, VS Code, Kiro

**วิธีที่ 3 — Chrome Extension:** ติดตั้งจาก Chrome Web Store สำหรับ visual overlay anti-pattern detection

### First Use: Onboarding โปรเจกต์

```
/impeccable init
```
AI จะถามชุดคำถาม → สร้าง `PRODUCT.md` และ `DESIGN.md` ที่ root ของโปรเจกต์ commit ไฟล์เหล่านี้เข้า repo เพื่อให้ทีมทั้งหมดใช้ context เดียวกัน

สำหรับโปรเจกต์ที่มี codebase อยู่แล้ว:
```
/impeccable document
```
Extract design tokens และ component patterns จาก code ที่มีอยู่เข้า `DESIGN.md` อัตโนมัติ

### Daily Workflow

1. **ก่อน commit UI changes** → `/impeccable critique` เพื่อรับ structured feedback
2. **ก่อน PR review** → `/impeccable audit` ตรวจ accessibility + performance
3. **ก่อน ship** → `/impeccable polish` สำหรับ final sweep
4. **เมื่อต้องการ visual direction** → `/impeccable bolder` หรือ `/impeccable quieter` ตาม context

### CI Integration

```bash
# .github/workflows/design-check.yml
- name: Desloppification check
  run: npx impeccable detect src/ --fail-on-violations
```

ไม่ต้อง API key — deterministic rules รันเป็น pure Node.js

## Caveats / Limits

- **Context file maintenance**: `PRODUCT.md` และ `DESIGN.md` ต้องอัปเดตเมื่อ design direction เปลี่ยน ถ้า stale → critiques จะ off-target
- **Live Mode beta**: ยังไม่ stable บางโปรเจกต์ HMR integration อาจมีปัญหา
- **LLM critique cost**: 12-rule LLM pass ใช้ token ทุกครั้งที่ run `/audit` ใน codebase ขนาดใหญ่ควร scope ให้แคบ (`/audit src/components/checkout/`)
- **Design subjectivity**: Impeccable ให้ direction แต่ creative decisions ยังเป็นของ developer — `/overdrive` อาจเกินสำหรับบาง brand
- **Framework coverage**: รองรับ React, Vue, Svelte ดี TypeScript-first; framework อื่นๆ อาจ detect tokens ได้ไม่ครบ

## References

1. [Impeccable GitHub Repository](https://github.com/pbakaus/impeccable) — source code, full command reference, Apache 2.0 license
2. [Impeccable Official Site](https://impeccable.style/) — documentation, installation guide, live demo
3. [Impeccable on Claude Plugin Hub](https://www.claudepluginhub.com/plugins/pbakaus-impeccable) — plugin metadata
4. [Impeccable: The Claude Code Skill for Unique Frontend UI — Apidog Blog](https://apidog.com/blog/impeccable-claude-code-skill/) — community review
5. [Video Overview](https://youtu.be/xdfKFNek) — original YouTube source

## Key Takeaways

- Impeccable แก้ปัญหา "AI Slop" ด้วยการให้ AI มี shared design vocabulary + project context ผ่าน `PRODUCT.md` และ `DESIGN.md`
- 23 คำสั่งครอบคลุมทุก phase: setup → critique → audit → polish → creative direction
- 41 deterministic anti-pattern rules รันโดยไม่ต้อง LLM — integrate ได้ใน CI pipeline ฟรี
- `/critique` เปรียบเหมือน Design Director review, `/audit` ตรวจ accessibility/performance, `/polish` คือ final sweep ก่อน ship
- Open-source (Apache 2.0), ฟรี, รองรับ Claude Code, Cursor, Gemini CLI, Codex CLI และอื่นๆ
- `PRODUCT.md` + `DESIGN.md` ต้อง commit เข้า repo เพื่อให้ context คงอยู่ข้ามเซสชัน — นี่คือจุดสำคัญที่ทำให้ต่างจาก AI design prompting ทั่วไป
