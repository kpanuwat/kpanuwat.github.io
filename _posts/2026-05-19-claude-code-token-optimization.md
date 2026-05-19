---
title: "ตั้งค่า Claude Code ให้ประหยัด Token ด้วย CLAUDE.md, Memory และ Skills"
date: 2026-05-19 12:00:00 +0700
categories: [Tools]
tags: [claude-code, token-optimization, productivity, obsidian, ai-workflow]
---

## TL;DR

5 วิธีตั้งค่า Claude Code ให้ใช้ token น้อยลงและตอบสนองดีขึ้น: คุมความยาว CLAUDE.md, แยกประเภทข้อมูล, ตั้งเพดาน memory.md, และเปลี่ยนจาก Claude Projects มา Co-work (Claude Code)

## Background / Why this matters

Claude Code อ่าน CLAUDE.md และ memory.md **ทุก session** — ไม่ว่าจะต้องการหรือเปล่า ยิ่งไฟล์ยาว ยิ่งเสีย token ไปกับ context ที่ไม่จำเป็น และที่แย่กว่านั้นคือ context window ของ LLM มี ceiling — เมื่อเต็ม โมเดลจะเริ่ม "ลืม" คำสั่งก่อนหน้า

> "If your CLAUDE.md is too long, Claude ignores half of it because important rules get lost in the noise." — Claude Code Official Docs

จุดปัญหาหลักที่เจอบ่อย:
- CLAUDE.md พองโตเพราะใส่ทุกอย่างไว้ที่เดียว
- memory.md สะสมข้อมูลจนล้น 200 บรรทัด (เส้นตายของ Claude Code)
- ยังอยู่ใน Claude Projects ซึ่งมีข้อจำกัดด้านบริบทและเครื่องมือ

## Deep Dive

### หลักการ: Context Window คือ Resource หลัก

Claude Code โหลด context ทุกอย่างตั้งแต่ต้น session — ทุก message, ทุก file ที่ read, ทุก command output ล้วนกิน token ทั้งนั้น เมื่อ context เต็ม performance ตกและ instructions สำคัญหายไป

แนวคิดหลักคือ **แยก signal ออกจาก noise** — อะไรต้องโหลดทุกครั้ง vs อะไรโหลดเฉพาะเมื่อต้องการ

### Tip 1: ใช้ Obsidian อ่าน/แก้ไขไฟล์ .md

CLAUDE.md, memory.md, SKILL.md ล้วนเป็น plain Markdown — Obsidian เปิดได้ทั้งหมดในครั้งเดียว อ่านง่าย ค้นหาได้ link graph ช่วยเห็นความสัมพันธ์ระหว่างไฟล์

ประโยชน์จริงๆ:
- แก้ CLAUDE.md ทุกวันได้สะดวก → ไม่มีข้ออ้างไม่ prune
- ใช้ Obsidian Search หาคำสั่งซ้ำ → ลบออก
- Graph view เห็น link ระหว่าง memory files ทันที

### Tip 2: คุมความยาว CLAUDE.md ไม่เกิน 200–250 บรรทัด

CLAUDE.md โหลดทุก session — ยิ่งยาวยิ่งแพง Official docs แนะนำ: สำหรับแต่ละบรรทัดถามตัวเองว่า *"ถ้าลบออกจะทำให้ Claude ผิดพลาดไหม?"* ถ้าไม่ → ลบ

วิธีย่อให้สั้น:
- **ย้ายกฎเฉพาะงาน** ไปไฟล์อ้างอิง (`@docs/git-workflow.md`, `@docs/api-conventions.md`) แล้ว import ด้วย `@path` syntax
- **เปลี่ยนกฎซ้ำๆ เป็น Hook** — อะไรที่ต้องทำ 100% ของเวลา ควรเป็น PreToolUse hook ไม่ใช่ text instruction
- **ลบสิ่งที่ Claude รู้อยู่แล้ว** — convention ทั่วไปของภาษา, standard tools, สิ่งที่อ่านจาก code ได้

```markdown
# ตัวอย่าง: แทน inline rules
# Git Workflow
- Create feature branch from main
- Name branch: feat/ticket-description
- Squash commits before merge
- ...10 more lines

# ใช้ @import แทน
# Git workflow: @docs/git-workflow.md
```

โหลดน้อยลง 10 บรรทัด × ทุก session × ทุกวัน = ประหยัดได้เยอะ

### Tip 3: แยกประเภทข้อมูลให้ถูกไฟล์

| ประเภทข้อมูล | ไฟล์ที่ใช่ | เหตุผล |
|---|---|---|
| กฎพฤติกรรม (Always/Never) | `CLAUDE.md` | ต้องการทุก session |
| Workflow ซ้ำๆ | `SKILL.md` | โหลดเฉพาะเมื่อเรียก |
| ข้อเท็จจริงที่เปลี่ยนได้ (version, paths, current task) | `memory.md` | เก็บระยะสั้น |
| ข้อมูลเก่าแต่ยังต้องการ | `archive.md` | ไม่โหลดอัตโนมัติ |

กฎง่ายๆ: ถ้าใช้คำว่า **"Always"** หรือ **"Never"** → ใน CLAUDE.md; ถ้าเป็นข้อเท็จจริงที่อาจเปลี่ยน (เช่น "ตอนนี้ทำงาน feature X") → ใน memory.md

### Tip 4: memory.md ไม่เกิน 150 บรรทัด → ย้ายเก่าไป archive.md

**เส้นตายของ Claude Code**: บรรทัดที่ 1–200 ของ MEMORY.md โหลดทุก session อัตโนมัติ บรรทัดที่ 201+ = **ไม่ถูกอ่าน** จนกว่าจะ fetch เอง

ตั้งเพดานที่ 150 บรรทัดเพื่อให้มี buffer และ structure:

```
memory/
  MEMORY.md          ← index + active facts (≤ 150 lines)
  recent.md          ← last 7 days decisions
  archive.md         ← old entries, not auto-loaded
  user.md            ← user profile, preferences
  feedback.md        ← corrections + validated approaches
```

เมื่อ MEMORY.md ใกล้ 150 บรรทัด: review แต่ละ entry → เก่า/ไม่ใช้ → ย้ายไป archive.md แทนลบทิ้ง (ยังค้นหาได้ถ้าต้องการ)

### Tip 5: ย้ายจาก Claude Projects มา Claude Code (Co-work)

**Claude Projects** = interface บน claude.ai ที่มี system prompt + knowledge files แต่มีข้อจำกัด:
- ไม่มี tool use นอกจาก built-in
- ไม่รันโค้ด ไม่อ่าน local files ได้โดยตรง
- context ผูกอยู่กับ project เดียว

**Claude Code (Co-work)** = agentic environment ที่:
- รัน bash, อ่านเขียนไฟล์, เรียก MCP tools ได้
- มี Skills system — โหลด domain knowledge เฉพาะเมื่อต้อง
- Sessions แยกกัน ไม่ cross-contaminate context
- ใช้ git worktrees รัน parallel sessions ได้

**Workstation vs Skill** — ความแตกต่างสำคัญ:

| | Workstation (Session) | Skill (SKILL.md) |
|---|---|---|
| ความหมาย | พื้นที่ทำงานที่มี context เฉพาะ | กระบวนการซ้ำๆ ที่ define ไว้ล่วงหน้า |
| โหลดเมื่อ | เปิด session | เรียกด้วย `/skill-name` หรือ auto-trigger |
| ตัวอย่าง | Session สำหรับ feature X | `/fix-issue`, `/deploy`, `/code-review` |
| ข้อดี | context เฉพาะงาน ไม่รบกวนกัน | ไม่โหลด CLAUDE.md ทุกครั้ง |

## User Guide (Step-by-Step)

### 1. Audit CLAUDE.md ปัจจุบัน

```bash
wc -l ~/.claude/CLAUDE.md
# ถ้า > 250 → ต้องตัด
```

เปิดใน Obsidian → highlight แต่ละบรรทัด → ถามว่า *"Claude ทำผิดพลาดถ้าลบบรรทัดนี้ไหม?"*

### 2. ตั้งโครงสร้าง @import

สร้างไฟล์ reference แยก แล้วใช้ `@` import ใน CLAUDE.md:

```markdown
# ~/.claude/CLAUDE.md
# Project docs: @~/dev/my-project/docs/conventions.md
# Git workflow: @~/dev/my-project/docs/git.md

# Core rules only (behavior/never/always)
- Never commit .env files
- Always run tests before push
```

> ตรวจสอบ syntax `@path` ล่าสุดที่ [Claude Code Memory docs](https://code.claude.com/docs/en/memory)

### 3. ตั้งเพดาน memory.md

ใน MEMORY.md เพิ่มหัวข้อ:

```markdown
# Memory Index
<!-- CAP: 150 lines. Move entries older than 30d to archive.md -->
```

ทุกสัปดาห์ (หรือเมื่อใกล้ 150 บรรทัด): review → entries เก่า → ย้ายไป `archive.md`

### 4. สร้าง Skills สำหรับ workflow ซ้ำๆ

```bash
mkdir -p ~/.claude/skills/my-workflow
cat > ~/.claude/skills/my-workflow/SKILL.md << 'EOF'
---
name: my-workflow
description: Daily standup prep workflow
---
1. Read git log --since="yesterday"
2. Summarize changes per module
3. Flag any blockers
EOF
```

แล้วเรียกด้วย `/my-workflow` แทนที่จะใส่ steps ทั้งหมดใน CLAUDE.md

### 5. ย้ายจาก Projects มา Claude Code

ดาวน์โหลด Claude Code CLI:
```bash
npm install -g @anthropic-ai/claude-code
# หรือเปิด claude.ai/code บน web
```

นำ system prompt เดิมจาก Claude Projects มา refactor เป็น CLAUDE.md + Skills — แยกตาม Tip 2–3

## Caveats / Limits

- **`@import` syntax** — ไฟล์ที่ import ก็กิน token เหมือนกัน แค่แยก concerns ออกไป ไม่ใช่ free
- **memory.md 200-line limit** — บรรทัดที่ 201+ ไม่โหลดอัตโนมัติ ต้อง explicit fetch เอง — อย่าพึ่งพา entries ที่อยู่ท้ายไฟล์
- **Skills โหลดแบบ on-demand** — ถ้าต้องการให้ rule apply ทุก session → ใส่ใน CLAUDE.md ไม่ใช่ Skill
- **Claude Code ≠ Claude Projects** — Projects เหมาะกับ knowledge retrieval แบบ structured, Code เหมาะกับ agentic workflows — แต่ละอันมี use case ต่างกัน ไม่ใช่ Projects แย่กว่า

## References

1. [Best practices for Claude Code — Official Docs](https://code.claude.com/docs/en/best-practices)
2. [How Claude remembers your project — Claude Code Memory Docs](https://code.claude.com/docs/en/memory)
3. [Claude Code Token Optimization: Stop the $1,600 Bill — Build to Launch](https://buildtolaunch.substack.com/p/claude-code-token-optimization)
4. [Optimizing Claude Code token usage: lessons learned — DEV Community](https://dev.to/ohugonnot/optimizing-claude-code-token-usage-lessons-learned-3h71)
5. [Claude Cowork Guide for Power Users — Karol Zieminski](https://karozieminski.substack.com/p/claude-cowork-guide-plugins-memory-sub-agents-tips)
6. [Claude Code Memory System Explained — Milvus Blog](https://milvus.io/blog/claude-code-memory-memsearch.md)
7. [ตั้งค่า Claude Code ให้ประหยัด Token — YouTube](https://youtu.be/4wvLHFgnQZQ)

## Key Takeaways

- CLAUDE.md โหลดทุก session — ทุกบรรทัดมีต้นทุน token; เป้าหมาย ≤ 200–250 บรรทัด
- กฎพฤติกรรม (Always/Never) → CLAUDE.md; ข้อเท็จจริงที่เปลี่ยนได้ → memory.md
- memory.md มี hard limit 200 บรรทัดที่โหลดอัตโนมัติ — ตั้งเพดานที่ 150 เพื่อ safety margin
- ย้ายกฎเฉพาะงานไปเป็น Skill — โหลดเฉพาะเมื่อเรียก ไม่กิน context ทุก session
- Claude Code (Co-work) > Claude Projects สำหรับ agentic workflows ที่ต้องการ tools + local file access
- Workstation = session context; Skill = reusable automated process — แยกแนวคิดนี้ให้ชัดก่อนออกแบบ setup
- Obsidian ช่วยให้ maintain ไฟล์ .md ได้ง่ายขึ้น → lowering the barrier ในการ prune ทุกสัปดาห์
