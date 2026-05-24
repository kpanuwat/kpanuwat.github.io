---
title: "OpenSpec EP4: เจาะลึก Artifacts — proposal, specs, design, tasks"
date: 2026-05-24 00:04:00 +0700
categories: [Tools]
tags: [openspec, spec-driven-development, ai-coding, artifacts, technical-writing]
series: openspec-beginners
---

{% include series-nav.html %}

## TL;DR

OpenSpec มี artifacts 4 ชิ้นที่ทำงานร่วมกัน: `proposal.md` (ทำไม+ทำอะไร), `specs/` (requirements), `design.md` (technical approach), `tasks.md` (implementation checklist) — เขียนดีได้ดี เขียนแย่ AI ก็ implement แย่

## Background / Why this matters

Artifacts คือ "สัญญา" ระหว่างคุณกับ AI — เป็นตัวกลางที่ทำให้ทั้งสองฝ่ายเข้าใจตรงกัน ก่อนจะสักบรรทัดของ code ถูกเขียน

ปัญหาที่พบบ่อยคือใช้ OpenSpec แต่ implement ออกมาไม่ตรง requirement — 90% ของเวลามาจาก artifacts ที่เขียนไม่ดี ไม่ใช่ bug ใน tool EP นี้จะอธิบายแต่ละ artifact ว่าเขียนยังไงให้ดี

## Deep Dive

### Artifact 1: `proposal.md` — ทำไมและทำอะไร

`proposal.md` คือ artifact แรกที่ AI สร้างจาก `/opsx:propose` มันตอบ 3 คำถาม:

1. **ทำไม** — ปัญหาคืออะไร? ทำไมต้องแก้ตอนนี้?
2. **ทำอะไร** — feature/change ที่จะทำคืออะไร? scope ชัดแค่ไหน?
3. **ไม่ทำอะไร** — out-of-scope ชัดเจน เพื่อป้องกัน scope creep

ตัวอย่าง proposal ที่ดี:

```markdown
# Add Dark Mode

## Problem
Users report eye strain during night-time use. Support tickets
about brightness: 47 in Q4 2025. No theme toggle exists.

## Solution
Add system-preference-aware dark/light theme toggle with
localStorage persistence.

## In Scope
- ThemeContext provider
- CSS variables for both themes
- Toggle button in header
- localStorage persistence

## Out of Scope
- Per-component theme customization
- Custom color picker
- Scheduled auto-switch
```

**สิ่งที่ต้อง review:** scope ครบไหม? out-of-scope ชัดไหม? ถ้า scope ใหญ่เกินไป → แก้ก่อน apply

### Artifact 2: `specs/` — Requirements ในรูป Delta

`specs/` ใน change folder คือ **delta specs** — บอกว่า requirement เปลี่ยนแปลงอะไรจากระบบปัจจุบัน ใช้ 3 markers:

```markdown
# UI Spec — Delta

## ADDED: Theme Support

The system SHALL support light and dark color themes.
Users SHALL be able to toggle between themes.
Theme preference SHALL persist across sessions.

## MODIFIED: Header Component

The header SHALL include a theme toggle button (was: no toggle).

## REMOVED: (none)
```

ต่างจาก `openspec/specs/` หลัก (source of truth) ที่บอกว่า "ระบบทำงานยังไงตอนนี้" delta specs บอกว่า "จะเปลี่ยนอะไร"

**ทำไมต้องแยก?** — ทำให้ code review แยก "spec ที่จะเปลี่ยน" ออกจาก implementation ได้ชัดเจน

### Artifact 3: `design.md` — Technical Approach

`design.md` บอก AI ว่าจะ implement ยังไง — เป็น bridge จาก "ทำอะไร" (proposal) ไปสู่ "ทำงานยังไง" (tasks)

```markdown
# Dark Mode — Design

## Architecture
Use React Context for theme state. CSS custom properties
for color values. Follow existing component patterns.

## Key Decisions
- Context: ThemeContext in src/contexts/
- Toggle: reuse existing IconButton component
- Storage: localStorage key "theme-preference"
- Default: follow prefers-color-scheme media query

## File Changes
- NEW: src/contexts/ThemeContext.tsx
- MODIFY: src/components/Header.tsx (add toggle)
- MODIFY: src/styles/global.css (add CSS variables)
```

**สิ่งที่ต้อง review:** technical decision ตรงกับ project convention ไหม? มี file ที่ AI ไม่รู้ว่ามีอยู่แล้วไหม?

### Artifact 4: `tasks.md` — Implementation Checklist

`tasks.md` คือ artifact ที่ AI ใช้ตอน `/opsx:apply` — เป็น checklist ที่ implement ทีละ item

```markdown
# Dark Mode — Tasks

## 1. Foundation

- [ ] 1.1 Create ThemeContext with light/dark state and toggle function
- [ ] 1.2 Wrap App root with ThemeProvider

## 2. Styling

- [ ] 2.1 Add CSS variables for light theme to global.css
- [ ] 2.2 Add CSS variables for dark theme to global.css
- [ ] 2.3 Update existing components to use CSS variables (replace hardcoded colors)

## 3. Toggle UI

- [ ] 3.1 Create ThemeToggle component using existing IconButton
- [ ] 3.2 Add ThemeToggle to Header component

## 4. Persistence

- [ ] 4.1 Read localStorage on ThemeContext init
- [ ] 4.2 Write localStorage on toggle
- [ ] 4.3 Fall back to prefers-color-scheme if no localStorage value
```

**นี่คือ artifact ที่สำคัญที่สุด** — เพราะ AI implement ตามนี้ตรงๆ tasks ที่ดีต้องมี:
- ขนาดพอเหมาะ — ไม่ใหญ่เกินไป (ทำ 1 task = ~30 นาที) ไม่เล็กเกินไป
- ลำดับถูกต้อง — dependency ชัดเจน (สร้าง context ก่อน ค่อย wrap App)
- พอรู้ว่า "done" คืออะไร — แต่ละ task measurable

### ความสัมพันธ์ระหว่าง artifacts

```
proposal.md  →  ทำไม + ทำอะไร
    ↓
specs/       →  requirements เปลี่ยนอะไร (testable)
    ↓
design.md    →  technical approach + file changes
    ↓
tasks.md     →  checklist ที่ AI implement ทีละ item
```

แต่ละชิ้น inherit context จากชิ้นก่อนหน้า — ถ้า proposal ไม่ดี, specs จะ vague, design จะ off, tasks จะ incomplete

### Tips: แก้ artifact ยังไงให้ได้ผลดี

**proposal.md** — เพิ่ม out-of-scope ถ้า AI scope creep บ่อย:
```markdown
## Out of Scope
- Mobile app changes (separate epic)
- Backend API changes (this PR: frontend only)
```

**tasks.md** — เพิ่ม task ที่ขาดหายหรือลบที่ไม่ต้องการ:
```markdown
- [ ] 4.4 Add unit test for ThemeContext toggle logic
      # เพิ่ม task นี้เอง เพราะ AI ไม่ได้ generate มา
```

**design.md** — เพิ่ม constraint ของ project:
```markdown
## Constraints
- Must use styled-components (not vanilla CSS) — our convention
- No new npm packages without approval
```

## User Guide (Step-by-Step)

### Review artifacts อย่างมีประสิทธิภาพ

หลัง `/opsx:propose` ทำตามลำดับนี้:

1. **proposal.md** (2 นาที) — scope ถูกไหม? out-of-scope ชัดไหม?
2. **tasks.md** (5 นาที) — ครบไหม? ลำดับ OK? แก้ถ้าจำเป็น
3. **design.md** (3 นาที) — technical approach ตรง project convention ไหม?
4. **specs/** (optional) — ถ้าต้องการ review requirements อย่างละเอียด

จากนั้น apply — ทำ PR review artifacts พร้อม code ในขั้นตอนเดียวได้เลย

## Caveats / Limits

- AI generate artifacts จาก codebase context + `openspec/config.yaml` — ถ้าไม่มี config หรือ codebase ใหม่มาก artifacts จะ generic
- `tasks.md` ที่ AI generate อาจพลาด edge cases — developer ที่รู้ domain ต้อง review เสมอ
- ถ้า project มี specs ใน `openspec/specs/` อยู่แล้ว, AI จะ reference มัน ถ้ายังไม่มี (project ใหม่) artifacts จะขาด context ของระบบ

## References

1. [OpenSpec Getting Started — Understanding Artifacts](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md#understanding-artifacts)
2. [OpenSpec Concepts — The Big Picture](https://github.com/Fission-AI/OpenSpec/blob/main/docs/concepts.md#the-big-picture)
3. [OpenSpec Customization — Rules per Artifact](https://github.com/Fission-AI/OpenSpec/blob/main/docs/customization.md#project-configuration)

## Key Takeaways

- Artifacts 4 ชิ้น: proposal (why+what) → specs (requirements) → design (how) → tasks (checklist)
- `tasks.md` สำคัญที่สุด — AI implement ตามนี้ตรงๆ; ลงทุน review ให้ดี
- Delta specs ใน `changes/` ≠ main specs ใน `openspec/specs/` — แยก "จะเปลี่ยนอะไร" ออกจาก "ตอนนี้เป็นยังไง"
- Proposal ที่ดีต้องมี **out-of-scope ชัดเจน** ป้องกัน AI scope creep
- Review order: proposal → tasks → design → specs (จากสำคัญที่สุดไปน้อยที่สุด)
