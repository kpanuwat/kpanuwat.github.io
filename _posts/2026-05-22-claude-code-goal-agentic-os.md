---
title: "เจาะลึก Goal Feature ใน Claude Code: ก้าวสู่ Agentic OS ที่ทำงานต่อเนื่องข้ามเซสชัน"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [claude-code, agentic-os, hermes, ai-agents, goal-feature, anthropic]
---

## TL;DR

Claude Code 2.1 เปิดตัว `/goal` command และ Agent View ที่เปลี่ยน AI จากผู้ช่วยตอบโต้ทีละ step สู่ **autonomous contractor** ที่ทำงานข้ามเซสชันได้หลายชั่วโมงโดยไม่ต้องรอคำสั่งซ้ำ เมื่อรวมกับ Hermes agent และสถาปัตยกรรม Agentic OS แบบ 4 layers มนุษย์เหลือหน้าที่เพียง "วางทิศทาง + รับ handoff งานที่ AI ทำไม่ได้"

## Background / Why this matters

ตลอดหลายปีที่ผ่านมา เราใช้ AI ในโหมด **reactive** — พิมพ์คำสั่ง รอผล แก้ไข วนซ้ำ ทุกครั้งที่ session ปิด context หายหมด เหมือนจ้างพนักงานที่ลืมทุกอย่างทุกเช้า

วันที่ 13 พฤษภาคม 2026 ในงาน "Code with Claude" Anthropic ประกาศ Claude Code v2.1.139 (Research Preview) พร้อมสองฟีเจอร์หลักที่เปลี่ยนสมการนี้:

1. **`/goal` command** — กำหนดเป้าหมายระดับสูง แล้วปล่อยให้ Claude วิ่งไปจนถึงเป้าหมายนั้นเอง
2. **Agent View** — dashboard ควบคุม multi-session agents จากหน้าต่างเดียว

ประกอบกับ **Hermes Agent** ที่ทำงานในพื้นหลังอย่างต่อเนื่อง การประกอบกันนี้ไม่ใช่แค่ feature update — มันคือการเปลี่ยนรูปแบบความสัมพันธ์ระหว่างมนุษย์กับ AI ในการทำงาน

## Deep Dive

### 1. `/goal` command: จาก chat สู่ control loop

คำสั่ง `/goal` เปลี่ยนวิธีที่ Claude ทำงานจากระดับ infrastructure ขึ้นมา แทนที่จะตอบทีละ prompt มันสร้าง **iterative execution loop**:

```
/goal "Migrate all API calls in /src/services from v1 to v2,
       update error handling, ensure all existing tests pass"
```

เบื้องหลังมี 3 phase:

**Planning Phase**: Claude วิเคราะห์ scope, ไฟล์ที่เกี่ยวข้อง, dependencies ก่อนลงมือ — โดยไม่แสดง plan ให้เห็น (ถ้าไม่ขอ)

**Observe-Act-Observe Loop**: แต่ละ action (แก้ไขไฟล์, รัน test, อ่าน output) trigger การวิเคราะห์ผลและกำหนด next step อัตโนมัติ

**Interrupt-on-Ambiguity**: Claude หยุดถามเฉพาะเมื่อพบ decision point ที่ตัดสินใจไม่ได้ — เช่น ต้องเลือก breaking change ที่กระทบ downstream

สามารถกำหนดขอบเขตได้:

| Flag | ตัวอย่าง | ความหมาย |
|------|---------|-----------|
| `--tokens` | `--tokens 500K` | จำกัด token budget |
| `--turns` | `--turns 20` | จำกัดจำนวน iteration |
| `--time` | `--time 30m` | จำกัดเวลา |

ต่างจาก "prompt ยาวๆ" อย่างไร? Long prompt คือคำถามเดียว `/goal` คือ **continuous evaluation** — หลังทุก action Claude ถามตัวเองว่า "goal บรรลุแล้วหรือยัง?" ถ้ายัง → วนต่อ

### 2. Cross-Session Persistence: Agentic OS Architecture

ปัญหาเดิมของ AI sessions คือ "blank slate syndrome" — ทุกครั้งที่เปิด session ใหม่ context หาย Agentic OS แก้ปัญหานี้ด้วย 4 layers:

```
┌─────────────────────────────────────────────┐
│  Orchestration Layer                        │
│  (coordinates agents, task routing)         │
├─────────────────────────────────────────────┤
│  Memory & Logging Layer                     │
│  short-term (session logs) +                │
│  long-term (vector DB: Pinecone/pgvector)   │
├─────────────────────────────────────────────┤
│  Tool Registry                              │
│  (web search, DB query, API calls, email)   │
├─────────────────────────────────────────────┤
│  Persistent Context Layer                   │
│  CLAUDE.md + business context               │
└─────────────────────────────────────────────┘
```

**Persistent Context Layer** — `CLAUDE.md` ที่ root directory คือ system prompt อัตโนมัติของทุก session: business goals, brand voice, client data, workflows

**Memory & Logging Layer** — สองระดับ:
- Session logs (`~/.claude/tasks/`) สำหรับ short-term state ที่รอดจาก terminal crash
- Vector database สำหรับ long-term retrieval ข้ามเซสชัน

**Multi-agent coordination** ผ่าน `CLAUDE_CODE_TASK_LIST_ID` environment variable ทำให้หลาย Claude instances แชร์ task list เดียวกันได้

### 3. Chief Wiggum 2.0: Framework สำหรับ Midterm Goals

"Chief Wiggum 2.0" (บางครั้งเรียก "Ralph 2.0") คือ methodology ที่ผู้สร้างวิดีโอ _Claude Code just got 10X Better_ นำเสนอสำหรับจัดการ **complex goals ระดับหลายสัปดาห์** ที่ `/goal` command เพียงอย่างเดียวอาจยังไม่พอ

วิธีการทำงาน:

1. **Define massive goal**: เช่น "launch 5-day email course and get 500 signups in 4 weeks"
2. **Context gathering**: ระบบถามคำถาม clarifying — target audience คือใคร? มี asset อะไรแล้ว? constraints มีอะไรบ้าง?
3. **Strategy breakdown**: แยกออกเป็น mini-goals ที่ actionable พร้อม timeline
4. **Real-world handshakes**: งานที่ AI ทำไม่ได้ (บันทึกวิดีโอ, โทรขาย) จะถูก delegate กลับมาให้มนุษย์ พร้อม script, time-box, และ folder สำหรับ deliverables

Framework นี้ไม่ใช่ official Anthropic feature แต่เป็น best practice pattern ที่แสดงให้เห็นว่า `/goal` + Agentic OS สามารถ scale ขึ้นไปถึง business operations จริงๆ ได้

### 4. Hermes Agent Integration

[Hermes Agent](https://hermes-agent.nousresearch.com/) ทำงานเป็น background agent ที่เชื่อมต่อกับ memory layer เดียวกัน:

- **Research-heavy tasks**: Hermes ใช้ Firecrawl navigate web pages, อ่าน HTML, ดึง market data โดยไม่ต้องมีคนนั่งดู
- **One-to-one memory bridge**: Hermes อ่าน context เดียวกับ Claude Code ทำให้สองระบบทำงานบน shared state
- **Background execution**: ในขณะที่ Claude Code กำลัง `/goal` อยู่ Hermes รัน research mini-goals ควบคู่กัน

### 5. Agent View: Mission Control Dashboard

Agent View คือ CLI dashboard ที่รวม multiple Claude sessions ไว้ในหน้าต่างเดียว:

```
┌────────────────────────────────────┐
│ Agent View                         │
├──────────┬────────────┬────────────┤
│ RUNNING  │  BLOCKED   │    DONE    │
│ goal:API │ auth:perms │ tests:pass │
│ tokens:  │ waiting:   │ reviewed:  │
│ 240K/500K│ approval   │ ✓          │
└──────────┴────────────┴────────────┘
```

**`/bg` command** — background agents ที่กำลังทำงานอยู่เพื่อเปิด session ใหม่ขนานกัน ทำให้สามารถรัน parallel engineering workflows ได้โดยไม่ต้องรอให้ goal หนึ่งเสร็จก่อน

### 6. Human-AI Collaboration Model ใหม่

การเปลี่ยนแปลงนี้ย้ายจาก **manager-assistant dynamic** ไปสู่ **autonomous contractor model**:

| เดิม (Manager-Assistant) | ใหม่ (Autonomous Contractor) |
|--------------------------|------------------------------|
| อนุมัติทุก action | กำหนดเป้าหมาย + รับรายงานสุดท้าย |
| session-scoped context | persistent memory ข้ามเซสชัน |
| reactive: คำสั่ง → ผล | proactive: goal → iterative execution |
| มนุษย์ทำงาน AI ช่วย | AI ทำงาน มนุษย์กำกับทิศทาง |

**"Everyone else built a construction worker. We built the contractor."** — MindStudio

Supervisor architecture ใน Claude Code 2.1 เพิ่ม second Claude session ที่ audit ผลลัพธ์สุดท้ายก่อน notify ผู้ใช้ ทำให้มีการ verify แบบ autonomous ก่อน handoff กลับมาให้มนุษย์

## User Guide (Step-by-Step)

### เริ่มต้นใช้ `/goal` command

**ขั้นตอนที่ 1: ติดตั้ง Claude Code 2.1+**

```bash
npm install -g @anthropic-ai/claude-code
claude --version  # ต้อง >= 2.1.139
```

**ขั้นตอนที่ 2: สร้าง CLAUDE.md เป็น persistent context**

```bash
# ที่ root ของ project
cat > CLAUDE.md << 'EOF'
# Project Context
## Goal
[Business objective ของ project นี้]

## Tech Stack
[Languages, frameworks, databases]

## Conventions
[Coding standards, commit format, testing approach]
EOF
```

**ขั้นตอนที่ 3: ใช้ `/goal` สำหรับ objective ระดับสูง**

```bash
# เปิด Claude Code
claude

# ใน session — define goal
/goal "Refactor all database calls in /src/db/ to use connection pooling,
       add retry logic for transient failures, ensure all tests pass"

# Optional: กำหนด constraints
/goal "..." --tokens 500K --time 2h
```

Expected output: Claude จะเริ่ม planning phase (invisible), แล้ว execute แต่ละ step พร้อมรายงานความคืบหน้า หยุดถามเฉพาะเมื่อพบ ambiguity จริงๆ

**ขั้นตอนที่ 4: Background agents ด้วย `/bg`**

```bash
# Background goal ที่กำลังรัน แล้วเปิด session ใหม่
/bg

# เปิด session ขนาน
claude  # new session — เริ่ม goal ใหม่ได้เลย
```

**ขั้นตอนที่ 5: Monitor ผ่าน Agent View**

```bash
# เปิด Agent View dashboard
/agent-view
```

ดู status: RUNNING / BLOCKED / DONE พร้อม token usage ต่อ agent

**ขั้นตอนที่ 6: Multi-session task sharing**

```bash
# Share task list ระหว่างหลาย Claude instances
export CLAUDE_CODE_TASK_LIST_ID="<task-list-id>"
claude  # instance ใหม่จะเห็น task list เดียวกัน
```

Task state เก็บที่ `~/.claude/tasks/` — รอดจาก terminal crash และ machine restart

### เขียน Goal ที่ดี

| ✅ Goal ที่ดี | ❌ Goal ที่ไม่ดี |
|--------------|----------------|
| Verifiable — "ensure all tests pass" | Vague — "make it better" |
| Scoped — "in /src/services/" | Open-ended — "refactor everything" |
| Outcome-based — "get 500 signups" | Process-based — "work on marketing" |
| Includes constraints | ไม่มี success criteria |

## Caveats / Limits

**Context window ยังมีขอบเขต**: `/goal` ไม่ได้หมายความว่า unlimited — สำหรับ codebase ขนาดใหญ่ หรือ open-ended research goals การแบ่งเป็น mini-goals ได้ผลดีกว่า

**Research Preview ยังไม่ stable**: v2.1.139 ยังเป็น Research Preview — behavior อาจเปลี่ยนในรุ่นถัดไป อย่า hardcode dependency ต่อ specific behavior

**Supervisor audit มีค่าใช้จ่ายสองเท่า**: การ verify ด้วย second Claude session หมายถึง token cost เพิ่มขึ้น — คำนึงถึงในการวาง budget

**Chief Wiggum 2.0 ไม่ใช่ official feature**: เป็น community methodology จากวิดีโอ ไม่ใช่ Anthropic documentation — ใช้เป็น inspiration pattern ไม่ใช่ spec

**Hermes integration ต้องการ setup เพิ่มเติม**: ไม่ใช่ out-of-the-box — ต้องติดตั้ง Hermes agent แยก และ configure memory bridge

**Vector DB สำหรับ long-term memory**: ถ้าต้องการ cross-session memory จริงๆ ต้องเพิ่ม Pinecone/Weaviate/pgvector เอง — Claude Code ไม่ได้ bundle มาให้

## References

1. [Claude Code 2.1: Anthropic Unveils Agent View and Autonomous /goal Command — explainx.ai](https://explainx.ai/blog/anthropic-claude-code-agent-view-goal-command)
2. [What Is the /goal Command in Claude Code? Autonomous Long-Running Tasks Explained — MindStudio](https://www.mindstudio.ai/blog/claude-code-goal-command-autonomous-tasks)
3. [How to Build an Agentic Operating System with Claude Code — MindStudio](https://www.mindstudio.ai/blog/how-to-build-agentic-operating-system-claude-code)
4. [Claude Code's 'Tasks' update lets agents work longer and coordinate across sessions — VentureBeat](https://venturebeat.com/orchestration/claude-codes-tasks-update-lets-agents-work-longer-and-coordinate-across)
5. [Anthropic Introduces Claude Code 'Goal' Command to Make AI Coding Sessions Actually Finish The Job — Eyerys](https://www.eyerys.com/articles/news/anthropic-introduces-claude-code-goal-command-make-ai-coding-sessions)
6. [Hermes Agent — The Agent That Grows With You — Nous Research](https://hermes-agent.nousresearch.com/)
7. [Claude Code just got 10X Better (Agentic OS) — YouTube](https://youtu.be/UQmmGnz6iVQ)
8. [Dive into Claude Code: The Design Space of Today's and Future AI Agent Systems — arXiv](https://arxiv.org/html/2604.14228v1)

## Key Takeaways

- `/goal` เปลี่ยน Claude Code จาก reactive prompt-response loop สู่ **goal-directed control loop** ที่วนซ้ำจนบรรลุเป้าหมาย
- Agentic OS architecture 4 layers (Persistent Context, Memory & Logging, Tool Registry, Orchestration) แก้ปัญหา "blank slate syndrome" ระหว่าง sessions
- **Chief Wiggum 2.0** คือ pattern สำหรับ multi-week goals — ให้ระบบถามบริบท สร้าง strategy, delegate งาน physical กลับมาให้มนุษย์
- **Hermes agent** ทำงานขนาน รัน research-heavy mini-goals ในพื้นหลังบน memory เดียวกันกับ Claude Code
- **Agent View** + `/bg` command ทำให้ parallel engineering workflows เป็นไปได้จาก terminal เดียว
- Human role เปลี่ยนจาก "ทำทุกอย่าง" → "วางทิศทาง + รับ handoff งานที่ AI ทำไม่ได้"
- Context window ยังมีขอบเขต — goal ที่ดีต้องมี success criteria ชัดเจน, scoped, และมี constraints
