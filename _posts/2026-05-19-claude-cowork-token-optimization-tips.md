---
title: "Top 5 Claude Co-work Tips: ประหยัด Token และทำงานมีประสิทธิภาพ"
date: 2026-05-19 12:00:00 +0700
categories: [Tools]
tags: [claude, claude-code, token-optimization, co-work, obsidian, claude-md, productivity]
---

## TL;DR

5 เทคนิค setup Claude Co-work (Claude Code) ที่ช่วยลด Token ที่สูญเสียโดยเปล่าประโยชน์ใน context window — ตั้งแต่จัดการไฟล์ `CLAUDE.md` ให้กระชับ แยกข้อมูลให้ถูกที่ถูกทาง จนถึงเข้าใจความต่างระหว่าง Workstation กับ Skill

## Background / Why this matters

Claude Code โหลดไฟล์ context หลายไฟล์ทุกครั้งที่เริ่ม session ใหม่ ได้แก่ `CLAUDE.md`, `memory/MEMORY.md`, memory files ต่างๆ และ skill definitions ทั้งหมดนี้กินพื้นที่ใน context window ทุกครั้ง ถ้าไฟล์เหล่านี้ยาวหรือมีข้อมูลที่ไม่จำเป็น → Token หมดเร็ว → งานแพง

ปัญหาที่พบบ่อย:
- `CLAUDE.md` บวมจนเกิน 400–500 บรรทัด
- `memory.md` เก็บทุกอย่างแบบไม่เลือก ทั้งที่บางส่วนล้าสมัยไปแล้ว
- ข้อกำหนดพฤติกรรม (behavioral rules) ปนกับข้อเท็จจริงชั่วคราว (mutable facts) ในไฟล์เดียวกัน
- ไม่รู้ว่าควรเอาบริบทไว้ใน "Project" หรือ "Co-work" กันแน่

เทคนิคทั้ง 5 ด้านล่างตอบโจทย์นี้โดยตรง

## Deep Dive

### Tip 1: ใช้ Obsidian อ่าน-แก้ไฟล์ .md

Claude Code ทำงานกับไฟล์ `.md` จำนวนมาก ทั้ง `CLAUDE.md`, `MEMORY.md`, memory files, skill files — แก้ผ่าน terminal ทำได้แต่ไม่สะดวก

**Obsidian** เปิด vault ที่ `~/.claude/` หรือ project directory ได้โดยตรง:
- เห็น backlinks ระหว่าง memory files
- Preview ทันทีโดยไม่ต้อง build
- เขียน `[[link]]` เพื่อเชื่อม memory file
- ค้นหาข้ามไฟล์ได้เร็วกว่า `grep`

การ edit `CLAUDE.md` ใน Obsidian แล้ว save → Claude Code รับทันทีใน session ถัดไป

### Tip 2: คุม CLAUDE.md ≤ 200–250 บรรทัด (max 300)

ทุกบรรทัดใน `CLAUDE.md` ถูกโหลดเข้า context **ทุก session** — ยิ่งยาว ยิ่งแพง

กฎ:
- **เป้าหมาย**: 200–250 บรรทัด
- **เพดาน**: 300 บรรทัด (ห้ามเกิน)
- กฎที่ใช้เฉพาะงาน หรือเฉพาะโปรเจกต์ → ย้ายไปไฟล์อ้างอิงแยก เช่น `@RTK.md`, `@DEPLOY.md`
- ใช้ `@filename` syntax ใน `CLAUDE.md` เพื่อ reference ไฟล์ภายนอก — Claude Code จะโหลดเฉพาะเมื่อจำเป็น

```
# CLAUDE.md (slim version)
@RTK.md          ← โหลดเฉพาะเมื่อใช้ rtk
@SECURITY.md     ← โหลดเฉพาะงาน security
```

ลด context load ได้มากถ้ากฎเฉพาะงานถูก offload ออกไป

### Tip 3: แยกประเภทข้อมูลให้ถูกที่

ข้อมูลสองประเภทนี้ไม่ควรอยู่ไฟล์เดียวกัน:

| ประเภท | ที่อยู่ | ตัวอย่าง |
|--------|---------|----------|
| **Behavioral rules** (เปลี่ยนไม่บ่อย) | `CLAUDE.md` | "Always use ISO 8601 dates", "Never push --force" |
| **Mutable facts** (เปลี่ยนได้ตาม session) | `memory/*.md` | current sprint goal, active bug, temp config |

ถ้า `CLAUDE.md` มีประโยคขึ้นต้นด้วย `Always` หรือ `Never` → ถูกที่แล้ว  
ถ้าเป็นข้อมูลที่จะล้าสมัยใน 2–4 สัปดาห์ → ย้ายไป memory ทันที

### Tip 4: เพดาน MEMORY.md ≤ 150 บรรทัด + archive

`MEMORY.md` เป็น index ที่โหลดทุก session เหมือนกัน (auto-context) ถ้าบวมเกิน 150 บรรทัด → เสีย Token ฟรี

วิธีจัดการ:
1. `MEMORY.md` = index เท่านั้น (pointer + one-liner per entry)
2. เนื้อหาจริงอยู่ในไฟล์แยก เช่น `memory/feedback_testing.md`
3. memory ที่ไม่ได้อ้างถึงใน 30–90 วัน → ย้ายไป `memory/archive.md`
4. `archive.md` ไม่ถูกโหลดอัตโนมัติ → ไม่กิน Token แต่ยังค้นได้เมื่อต้องการ

```
MEMORY.md (≤150 บรรทัด)
├── memory/feedback_testing.md
├── memory/project_current.md
└── memory/archive.md   ← ไม่โหลดอัตโนมัติ
```

### Tip 5: ย้ายออกจาก Claude Projects → Claude Code (Co-work)

**Claude Projects** (claude.ai) มีข้อจำกัด:
- ไม่สามารถ run code หรือ shell commands
- ไม่มี file system access
- context reset ทุก conversation

**Claude Code (Co-work)** แก้ปัญหาเหล่านี้ทั้งหมด แต่ต้องเข้าใจการแบ่งบทบาท:

| ประเภท | คือ | เหมาะกับ |
|--------|-----|---------|
| **Workstation** | พื้นที่ทำงานที่มีบริบท (project context, memory, CLAUDE.md) | งานต่อเนื่อง multi-session |
| **Skill** | กระบวนการซ้ำๆ ที่ automate ได้ (เช่น skill add-post, marp-deck) | งาน repeatable ที่มี workflow ชัดเจน |

แนวทาง migration:
1. Export project instructions → ย้ายเข้า `CLAUDE.md` ของ repo
2. Export project knowledge → ย้ายเข้า memory files (แยกตาม type: user/project/feedback)
3. Recurring tasks → สร้างเป็น skill file ใน `~/.claude/skills/`

## User Guide (Step-by-Step)

### Setup ครั้งแรก (30 นาที)

**Step 1: เปิด Obsidian vault ที่ `~/.claude/`**
```bash
# เปิด Obsidian → Open folder as vault → เลือก ~/.claude/
# หรือถ้ามี CLI: obsidian ~/.claude/
```
Expected: เห็นไฟล์ `settings.local.json`, `skills/`, `projects/` ใน sidebar

**Step 2: วัดความยาว CLAUDE.md ปัจจุบัน**
```bash
wc -l ~/CLAUDE.md ~/.claude/CLAUDE.md
```
ถ้าเกิน 300 → เริ่ม trim ทันที

**Step 3: แยก behavioral rules ออกจาก mutable facts**
```bash
# ดู CLAUDE.md ทั้งหมด แล้วถามตัวเองต่อแต่ละ rule:
# "rule นี้จะยังถูกอยู่ใน 6 เดือน?" → ใช่ = behavioral (เก็บใน CLAUDE.md)
# "อาจเปลี่ยนใน 30 วัน?" → ใช่ = mutable (ย้ายไป memory)
```

**Step 4: ตั้งเพดาน MEMORY.md**
```bash
wc -l ~/.claude/projects/<slug>/memory/MEMORY.md
# ถ้าเกิน 150 บรรทัด → ย้าย entries เก่าไป archive.md
```

**Step 5: รัน Claude Code session ใหม่ — สังเกต token usage**
```bash
claude  # เริ่ม session ใหม่
# ดู prompt token count ที่ขึ้นต้น session — ควรลดลงหลัง trim
```

## Caveats / Limits

- **`@filename` ใน CLAUDE.md**: ไฟล์ที่ reference ด้วย `@` ถูกโหลดเมื่อ Claude เห็นว่าเกี่ยวข้อง ไม่ใช่ทุกครั้ง — behavior อาจต่างกันตาม context
- **Obsidian vault ที่ `~/.claude/`**: ระวัง edit `settings.local.json` ผิดพลาด — backup ก่อนเสมอ
- **ย้ายจาก Claude Projects**: conversation history ย้ายตามไม่ได้ — เฉพาะ instructions และ knowledge เท่านั้น
- **Skill vs Workstation**: Skill ที่ดีต้องมี clear trigger และ repeatable workflow — ถ้ายังไม่ชัดเจน ใช้ Workstation ก่อน แล้วค่อย extract เป็น Skill

## References

1. [Top 5 Claude Cowork Tips I Wish I Knew from Day One](https://youtu.be/4wvLHFgnQZQ) — video source สำหรับ 5 เทคนิคนี้
2. [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code) — official Claude Code docs
3. [Obsidian](https://obsidian.md/) — Markdown-based knowledge base app

## Key Takeaways

- โหลดทุก session → ทุกบรรทัดใน `CLAUDE.md` และ `MEMORY.md` มีราคา — trim สม่ำเสมอ
- แยก behavioral rules (`Always`/`Never`) ออกจาก mutable facts — คนละไฟล์ คนละ lifecycle
- `CLAUDE.md` ≤ 250 บรรทัด, `MEMORY.md` ≤ 150 บรรทัด — เป็น hard limits ที่ควรตั้ง reminder
- ข้อมูลเก่าใน memory → `archive.md` ไม่ถูกโหลดอัตโนมัติ แต่ค้นได้เมื่อต้องการ
- Obsidian เป็น native .md editor ที่ดีที่สุดสำหรับจัดการ Claude context files
- Workstation = บริบท (context-rich, multi-session); Skill = กระบวนการ (repeatable, automatable)
- ย้ายออกจาก Claude Projects เมื่อต้องการ code execution, file access, หรือ persistent context ข้าม session
