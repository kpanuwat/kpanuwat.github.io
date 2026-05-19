---
marp: true
theme: default
paginate: true
---

# ตั้งค่า Claude Code ให้ประหยัด Token

**CLAUDE.md + Memory + Skills = ใช้ token น้อยลง ตอบสนองดีขึ้น**

---

## TL;DR

- Claude Code อ่าน CLAUDE.md + memory.md **ทุก session** — ทุกบรรทัดมีต้นทุน
- 5 วิธีประหยัด: Obsidian → ตัด CLAUDE.md → แยกไฟล์ → cap memory → ย้ายมา Code
- เป้าหมาย: CLAUDE.md ≤ 250 บรรทัด, memory.md ≤ 150 บรรทัด

---

## ทำไม Context Window ถึงสำคัญ

Claude Code โหลดทุกอย่างตั้งแต่ต้น session:
- ทุก message, ทุก file ที่ read, ทุก command output

เมื่อ context เต็ม:
- โมเดล "ลืม" คำสั่งก่อนหน้า
- instructions สำคัญหายไปในสัญญาณรบกวน
- performance ตก

> "If your CLAUDE.md is too long, Claude ignores half of it." — Claude Code Docs

**หลักการ**: แยก signal ออกจาก noise — โหลดเฉพาะสิ่งที่ต้องการตอนนั้น

---

## Tip 1: ใช้ Obsidian จัดการไฟล์ .md

CLAUDE.md, memory.md, SKILL.md = plain Markdown → Obsidian เปิดได้ทั้งหมด

ประโยชน์:
- **แก้ทุกวันได้สะดวก** → ไม่มีข้ออ้างไม่ prune
- **Search** หาคำสั่งซ้ำ → ลบออก
- **Graph view** เห็น link ระหว่าง memory files ทันที

Obsidian ลด friction ของการ maintain → CLAUDE.md ไม่พองโต

---

## Tip 2: CLAUDE.md ≤ 200–250 บรรทัด

สำหรับแต่ละบรรทัด ถามว่า: **"ถ้าลบออก Claude จะผิดพลาดไหม?"** ถ้าไม่ → ลบ

วิธีย่อ:
- ย้ายกฎเฉพาะงาน → ใช้ `@import` แทน
- เปลี่ยนกฎซ้ำๆ 100% → Hook (deterministic, ไม่ใช่ text instruction)
- ลบสิ่งที่ Claude รู้อยู่แล้ว (language conventions, standard tools)

```markdown
# แทนที่ inline rules 10 บรรทัด
# Git workflow: @docs/git-workflow.md
```

---

## Tip 3: แยกประเภทข้อมูลให้ถูกไฟล์

| ประเภทข้อมูล | ไฟล์ที่ใช่ | โหลดเมื่อ |
|---|---|---|
| กฎพฤติกรรม (Always/Never) | `CLAUDE.md` | ทุก session |
| Workflow ซ้ำๆ | `SKILL.md` | เรียกด้วย `/skill-name` |
| ข้อเท็จจริงที่เปลี่ยนได้ | `memory.md` | ทุก session (≤ 200 lines) |
| ข้อมูลเก่า ยังต้องการ | `archive.md` | fetch เมื่อต้องการ |

**กฎง่ายๆ**: ใช้คำ **"Always/Never"** → CLAUDE.md; ข้อเท็จจริงที่เปลี่ยนได้ → memory.md

---

## Tip 4: memory.md ≤ 150 บรรทัด → archive.md

**Hard limit ของ Claude Code**: บรรทัดที่ 1–200 โหลดอัตโนมัติ — บรรทัดที่ 201+ **ไม่ถูกอ่าน**

ตั้งเพดานที่ 150 (safety margin 50 บรรทัด):

```
memory/
  MEMORY.md     ← index + active facts (≤ 150 lines)
  recent.md     ← last 7 days decisions
  archive.md    ← old entries, not auto-loaded
  user.md       ← user profile, preferences
  feedback.md   ← corrections + validated approaches
```

ทุกสัปดาห์: entries เก่า → ย้าย archive.md แทนลบ (ยังค้นหาได้)

---

## Tip 5: Claude Projects vs Claude Code (Co-work)

| | Claude Projects | Claude Code |
|---|---|---|
| Tool use | built-in เท่านั้น | bash, MCP, local files |
| Context | ผูกกับ project | แยก sessions |
| Skills | ไม่มี | on-demand loading |
| Parallel | ไม่รองรับ | git worktrees |

**Workstation vs Skill**:
- **Workstation** = session ที่มี context เฉพาะงาน (ไม่รบกวนกัน)
- **Skill** = `/fix-issue`, `/deploy` — process ซ้ำๆ ที่ define ไว้ล่วงหน้า

---

## Step 1–2: Audit + @import

**1. วัดความยาว CLAUDE.md**
```bash
wc -l ~/.claude/CLAUDE.md
# ถ้า > 250 → ต้องตัด
```

**2. ตั้งโครงสร้าง @import**
```markdown
# ~/.claude/CLAUDE.md
# Git workflow: @~/dev/project/docs/git.md
# Conventions: @~/dev/project/docs/conventions.md

# Core rules only
- Never commit .env files
- Always run tests before push
```

---

## Step 3–4: memory cap + Skills

**3. ตั้งเพดาน memory.md**
```markdown
# Memory Index
<!-- CAP: 150 lines. Move entries >30d to archive.md -->
```

**4. สร้าง Skill สำหรับ workflow ซ้ำๆ**
```bash
mkdir -p ~/.claude/skills/standup
cat > ~/.claude/skills/standup/SKILL.md << 'EOF'
---
name: standup
description: Daily standup prep
---
1. Read git log --since="yesterday"
2. Summarize per module
3. Flag blockers
EOF
```
→ เรียกด้วย `/standup` แทนใส่ steps ใน CLAUDE.md

---

## Step 5: ย้ายจาก Projects มา Claude Code

```bash
npm install -g @anthropic-ai/claude-code
# หรือเปิด claude.ai/code บน web
```

Refactor system prompt เดิม → CLAUDE.md + Skills:
- Behavior rules → CLAUDE.md
- Domain knowledge → SKILL.md (on-demand)
- Active facts → memory.md

---

## Caveats / Limits

- **@import ไม่ฟรี** — ไฟล์ที่ import ก็กิน token แค่แยก concerns ออกไป
- **memory.md 200-line hard limit** — entries ท้ายไฟล์ไม่โหลด อย่าพึ่งพา
- **Skill = on-demand** — ถ้าต้องการทุก session → ใส่ใน CLAUDE.md
- **Projects ≠ แย่กว่า** — เหมาะกับ structured knowledge retrieval, Code เหมาะกับ agentic workflows

---

## Key Takeaways

- ทุกบรรทัดใน CLAUDE.md มีต้นทุน token — เป้าหมาย ≤ 250 บรรทัด
- Always/Never → CLAUDE.md; ข้อเท็จจริงที่เปลี่ยนได้ → memory.md
- memory.md hard limit 200 บรรทัด — ตั้งเพดาน 150 เพื่อ safety
- Skills โหลด on-demand — ไม่กิน context ทุก session
- Workstation = context เฉพาะงาน; Skill = process ซ้ำที่ automate ได้
