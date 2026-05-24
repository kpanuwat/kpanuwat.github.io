---
title: "OpenSpec EP1: Spec-Driven Development คืออะไร และทำไมมันสำคัญกับการเขียนโค้ดด้วย AI"
date: 2026-05-23 00:01:00 +0700
categories: [Tools]
tags: [openspec, spec-driven-development, ai-coding, developer-tools, claude-code]
series: openspec-beginners
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

OpenSpec คือ framework ที่บังคับให้เราเขียน "spec" ก่อนที่ AI จะเริ่มเขียนโค้ด — แก้ปัญหา vibe coding ที่ทำให้โปรเจกต์ใหญ่พังเพราะ AI วิ่งผิดทิศ มีคนใช้งานกว่า 50,000 repo บน GitHub และรองรับ 25+ AI tools

## Background / Why this matters

ยุค AI coding มาถึงแล้ว — Claude Code, Cursor, Copilot ช่วยให้เราเขียนโค้ดได้เร็วขึ้นมาก แต่มันนำมาซึ่งปัญหาใหม่: **vibe coding**

Vibe coding คือการบอก AI ว่า "ทำ X ให้หน่อย" แล้วรอดูผล โดยไม่มีการวางแผนหรือ spec ก่อน ซึ่งทำงานได้ดีสำหรับ feature เล็กๆ แต่พอโปรเจกต์ใหญ่ขึ้น ปัญหาเริ่มโผล่:

- AI ตีความ requirement ผิด แก้ไขอย่างนึงแต่พัง 3 อย่าง
- ไม่มีเอกสารว่า "ตกลงเราจะทำอะไร" ทีมคนอื่นไม่รู้
- Code review ไม่รู้ว่า implementation ตรง requirement ไหม
- Rollback ยาก เพราะไม่มี baseline ว่า "ก่อนหน้านี้ระบบทำงานยังไง"

OpenSpec แก้ทุกปัญหานี้ด้วยแนวคิด **Spec-Driven Development (SDD)** — เขียน spec ก่อน แล้วให้ AI implement ตาม spec นั้น

## Deep Dive

### แนวคิดหลัก 4 ข้อของ OpenSpec

```
fluid not rigid         — ไม่บังคับ phase; ทำ artifact ได้ยืดหยุ่น
iterative not waterfall — ปรับ spec ได้เมื่อเข้าใจมากขึ้น
easy not complex        — ติดตั้งใน 1 คำสั่ง, ใช้งานได้ทันที
brownfield-first        — ทำงานกับ codebase เก่าได้ ไม่ใช่แค่ greenfield
```

หัวใจคือ **"ไม่ใช่ waterfall"** — OpenSpec ไม่บังคับให้ทำ planning ก่อน 100% แล้วค่อย implement สิ้น แต่ยืดหยุ่นพอที่จะ refine spec ระหว่าง implement ได้

### สองพื้นที่หลักใน OpenSpec

```
openspec/
├── specs/       ← source of truth: ระบบทำงานยังไงตอนนี้
└── changes/     ← proposed changes: จะเปลี่ยนอะไร (ยังไม่ merge)
```

**`specs/`** คือ living document ของระบบ บอกว่า "ตอนนี้ระบบทำงานยังไง" ถ้า team member ใหม่เข้ามา อ่าน `specs/` แล้วเข้าใจระบบได้เลย

**`changes/`** คือที่เก็บ feature ที่กำลังพัฒนา แต่ละ change มี folder ของตัวเอง ประกอบด้วย artifacts:

| Artifact | บอกอะไร |
|----------|---------|
| `proposal.md` | ทำไมต้องทำ, ทำอะไร, scope คืออะไร |
| `specs/` | delta specs — เพิ่ม/แก้ไข/ลบ requirement อะไร |
| `design.md` | technical approach — จะ implement ยังไง |
| `tasks.md` | checklist ที่ AI จะ implement ทีละ task |

### Flow หลัก (Core Profile)

```
/opsx:propose ──► /opsx:apply ──► /opsx:sync ──► /opsx:archive
```

1. **propose** — บอก AI ว่า "อยากทำอะไร" → AI สร้าง artifacts ทั้งหมด
2. **apply** — AI implement tasks จาก `tasks.md` ทีละอย่าง
3. **sync** — merge delta specs กลับเข้า `specs/` หลัก
4. **archive** — เก็บ change folder เข้า archive

ความสวยงามคือ **ตอน apply AI รู้ว่าทำอะไร** เพราะอ่านจาก `proposal.md`, `design.md`, `tasks.md` ที่ทั้งคุณและ AI ตกลงกันไว้แล้ว — ไม่ใช่แค่ "ทำๆ ไป"

### ทำไม 50,000+ repos ใช้ OpenSpec

- **Context-engineering friendly** — artifacts เป็น markdown ที่ AI อ่านได้ดี ช่วยลด hallucination
- **Multi-tool** — ใช้ได้กับ Claude Code, Cursor, Windsurf, GitHub Copilot และอีก 20+ tools
- **Git-trackable** — artifacts อยู่ใน repo → review ได้, diff ได้, rollback ได้
- **Brownfield** — ไม่ต้องเริ่มใหม่จากศูนย์; ใส่ลงใน codebase ที่มีอยู่แล้วได้เลย

### เปรียบเทียบ: วิธีเดิม vs OpenSpec

| วิธีเดิม (vibe coding) | OpenSpec |
|----------------------|---------|
| บอก AI โดยตรง → รอ | propose → review artifacts → apply |
| AI เดาความต้องการ | AI อ่าน spec ที่ชัดเจน |
| ไม่มีเอกสาร | artifacts อยู่ใน git |
| review ยาก | review proposal + design แยกจาก code |
| rollback = undo git | revert change folder |

## Caveats / Limits

- **Workspace feature** (cross-repo planning) ยัง experimental — ยังไม่ stable API ห้ามพึ่งใน production automation
- ต้องใช้ **Node.js 20.19.0+** — ถ้า project ใช้ Node เวอร์ชันเก่า ต้อง upgrade ก่อน
- OpenSpec ไม่ได้รับประกันว่า AI จะ implement ถูกต้อง 100% — ยัง need code review ปกติ; SDD ช่วยลด drift ไม่ใช่ eliminate มัน

## References

1. [OpenSpec GitHub Repository — Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec)
2. [OpenSpec Concepts Documentation](https://github.com/Fission-AI/OpenSpec/blob/main/docs/concepts.md)
3. [OpenSpec Getting Started](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md)

## Key Takeaways

- Vibe coding พัง project ใหญ่เพราะ AI ทำงานโดยไม่มี spec ที่ชัดเจน
- OpenSpec แก้ด้วย artifacts 4 ชิ้น: proposal → specs → design → tasks
- ไม่ใช่ waterfall — fluid, iterative, สามารถปรับ spec ระหว่าง implement ได้
- `specs/` = source of truth ของระบบ; `changes/` = feature ที่กำลังพัฒนา
- รองรับ 25+ AI tools, ติดตั้งผ่าน npm ใน 1 คำสั่ง
- Git-trackable ทั้งหมด — review, diff, rollback artifacts ได้เหมือน code
