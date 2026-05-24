---
title: "OpenSpec + Claude Code CLI: เจาะลึกการ Integrate สองเครื่องมือนี้ให้ทำงานร่วมกัน"
date: 2026-05-24 00:06:00 +0700
categories: [Tools]
tags: [openspec, claude-code, spec-driven-development, ai-coding, developer-tools]
---

{% include slide-link.html %}

## TL;DR

OpenSpec ทำงานกับ Claude Code CLI ผ่าน skill files ที่ install ไว้ที่ `.claude/skills/openspec-*/SKILL.md` — slash commands อย่าง `/opsx:propose` และ `/opsx:apply` พร้อมใช้งานทันทีหลัง `openspec init --tools claude`; project context จาก `openspec/config.yaml` ถูกส่งให้ Claude ทุกครั้งที่ run command

## Background / Why this matters

Claude Code CLI มี context window ขนาดใหญ่และ read codebase ได้โดยตรง — นี่คือข้อได้เปรียบที่ทำให้ OpenSpec ทำงานได้ดีเป็นพิเศษบน Claude Code เมื่อเทียบกับ AI tools อื่น

แต่หลายคนที่ใช้ทั้งสองเครื่องมือยังไม่ทราบว่า integration ทำงานยังไงภายใน — skill files คืออะไร, ทำไม `/opsx:propose` ถึงทำงานได้ใน Claude Code, และจะ tune integration ยังไงให้ได้ artifacts ที่ดีขึ้น

Post นี้เจาะเฉพาะ Claude Code perspective ครับ

## Deep Dive

### วิธีที่ OpenSpec inject ตัวเองเข้า Claude Code

เมื่อ run `openspec init` แล้วเลือก Claude Code, OpenSpec install **skill files** ลง:

```
your-project/
└── .claude/
    └── skills/
        ├── openspec-core/
        │   └── SKILL.md
        └── openspec-propose/
            └── SKILL.md
```

Claude Code อ่าน `.claude/skills/*/SKILL.md` ทุกไฟล์ใน directory นี้โดยอัตโนมัติเมื่อ session เริ่ม — skill files เหล่านี้บอก Claude ว่า `/opsx:propose` ทำอะไร, สร้าง artifacts อะไร, และควร respond ยังไง ไม่มี plugin ระดับ system ใด — แค่ Markdown ที่ Claude อ่านเป็น context

```
Skill file = System prompt เพิ่มเติมที่บอก Claude ว่าจะทำงานกับ OpenSpec ยังไง
```

นอกจาก skills, OpenSpec ยังสร้าง **command files** ที่ `.claude/commands/opsx/<id>.md` สำหรับ Expanded Workflow — เหล่านี้ bind กับ slash commands ใน Claude Code UI โดยตรง

### Init สำหรับ Claude Code โดยเฉพาะ

```bash
# Interactive wizard (เลือก claude ใน tool selection)
openspec init

# หรือ non-interactive — เหมาะสำหรับ CI / scripting
openspec init --tools claude
```

wizard จะถาม 3 อย่าง:
1. **Profile** — `core` (default) หรือ `expanded`
2. **AI tools** — เลือก `claude` (หรือหลาย tools ถ้าต้องการ)
3. **Language** — ภาษาที่ใช้ generate artifacts (optional)

Skills ที่ถูก install ขึ้นอยู่กับ profile:

| Profile | Skills ที่ install |
|---------|------------------|
| Core | `openspec-core`, `openspec-propose`, `openspec-explore`, `openspec-apply`, `openspec-sync`, `openspec-archive` |
| Expanded | + `openspec-new`, `openspec-continue`, `openspec-ff`, `openspec-verify`, `openspec-bulk-archive`, `openspec-onboard` |

### Slash commands ทำงานยังไงใน Claude Code

หลัง init, เปิด Claude Code ใน project แล้วพิมพ์ `/opsx:` — Claude จะรู้จัก commands ทันที:

```
You: /opsx:propose add-user-auth

Claude: Reading codebase context...
        Creating openspec/changes/add-user-auth/

        ✓ proposal.md    — why + what + out-of-scope
        ✓ specs/auth/spec.md  — delta requirements
        ✓ design.md      — technical approach
        ✓ tasks.md       — implementation checklist

        Review artifacts before /opsx:apply
```

Claude ใช้ skill file เป็น "manual" บอกว่าควร create ไฟล์อะไร, format ยังไง, และ respond อะไร — นั่นคือทำไม response จึงสม่ำเสมอข้ามทุก session

### Context Pipeline: จาก config.yaml → Claude

`openspec/config.yaml` ไม่ได้แค่ "store settings" — มันถูก inject เข้าไปใน every OpenSpec command เป็น prompt context:

```
/opsx:propose
    ↓
OpenSpec skill file อ่าน config.yaml
    ↓
Inject into Claude's context:
  - Tech stack (React, Node.js, PostgreSQL ฯลฯ)
  - Per-artifact rules (tasks ≤ 30 min, Given/When/Then format)
  - Project conventions
    ↓
Claude generate artifacts ที่ aware ของ project context
```

ตัวอย่าง `openspec/config.yaml` สำหรับ Claude Code project:

```yaml
schema: spec-driven

context: |
  Tech stack: TypeScript, Node.js 22, React 19
  Testing: Vitest + Playwright
  Auth: JWT via Clerk
  Conventions: no console.log, conventional commits
  Claude Code skills: openspec installed at .claude/skills/

rules:
  proposal:
    - Include affected files estimated list
    - Note any CLAUDE.md conventions that apply
  tasks:
    - แต่ละ task ≤ 30 นาที
    - Add test task สำหรับทุก business logic change
  design:
    - Specify new npm packages required (if any)
    - Note if change requires CLAUDE.md update
```

**ผลลัพธ์:** artifacts ที่ออกมาจะ mention TypeScript types, Clerk auth pattern, และ Vitest tests โดยอัตโนมัติ — ไม่ต้อง prompt ทุกครั้ง

### CLAUDE.md + openspec/config.yaml: ทำงานร่วมกันยังไง

Claude Code users มักมี `CLAUDE.md` อยู่แล้ว — สองไฟล์นี้ทำงานต่างกัน:

| | `CLAUDE.md` | `openspec/config.yaml` |
|--|-------------|------------------------|
| **อ่านโดย** | Claude Code เสมอ (ทุก session) | OpenSpec skill เฉพาะตอน run `/opsx:*` |
| **ควรใส่** | Behavior rules, code style, project structure | Tech stack, artifact rules, team conventions |
| **Scope** | ทุก interaction | OpenSpec workflows เท่านั้น |

แนะนำให้ cross-reference: ถ้า `CLAUDE.md` บอกว่า "always use Vitest", ให้ `config.yaml` บอกว่า "tasks.md must include Vitest test task for every business logic change" — เพื่อให้ OpenSpec artifacts สอดคล้องกับ behavior ที่ define ไว้ใน CLAUDE.md

### openspec update: sync หลังเปลี่ยน config

ทุกครั้งที่เปลี่ยน profile หรือ config, ต้อง sync skill files ด้วย:

```bash
openspec update
```

command นี้ regenerate skill files ใน `.claude/skills/` ให้ตรงกับ config ล่าสุด — ถ้าไม่ run, Claude ยังใช้ skill files เก่าอยู่

**เมื่อไหรที่ต้อง run `openspec update`:**
- หลัง `openspec config profile` (เปลี่ยน Core ↔ Expanded)
- หลังแก้ `openspec/config.yaml` อย่างมีนัยสำคัญ
- หลัง `npm install -g @fission-ai/openspec@latest` (upgrade version)
- หลัง add AI tools ใหม่ด้วย `openspec init`

### Practical Claude Code Workflow

workflow ที่ทำงานได้ดีกับ Claude Code:

```bash
# 1. เริ่ม feature ใหม่
# ใน Claude Code:
You: /opsx:propose add-payment-flow

# 2. Review artifacts ที่ Claude สร้างให้
# อ่าน openspec/changes/add-payment-flow/proposal.md
# อ่าน openspec/changes/add-payment-flow/tasks.md
# แก้ถ้าจำเป็น (ใช้ Edit tool หรือ text editor)

# 3. Apply
You: /opsx:apply

# 4. ถ้าต้องการ verify ก่อน PR (Expanded Workflow)
You: /opsx:verify

# 5. Sync + Archive
You: /opsx:sync
You: /opsx:archive
```

**Claude Code-specific tip:** ก่อน `/opsx:apply` บน feature ซับซ้อน สามารถ ask Claude ให้ read codebase เพิ่มก่อน:

```
You: Read src/payments/ then /opsx:apply

Claude: Reading payments module...
        [reads 3 files]
        Now implementing tasks.md with payment module context...
```

Claude Code's codebase reading + OpenSpec's task structure = implementation ที่ aware ของ existing code patterns

### Commit Strategy กับ OpenSpec Artifacts

OpenSpec artifacts อยู่ใน `openspec/changes/` ซึ่งควร commit เข้า git:

```bash
# Pattern 1: Artifacts + Code ใน PR เดียว
git add openspec/changes/add-payment-flow/
git add src/payments/
git commit -m "feat: add payment flow"
# Reviewers เห็นทั้ง spec และ implementation

# Pattern 2: Artifacts ก่อน, Code ทีหลัง (Expanded Workflow)
git add openspec/changes/add-payment-flow/
git commit -m "spec: add payment flow proposal"
# → Code review artifacts → approve → implement → PR #2
```

Pattern 2 เหมาะกับ team ที่ต้องการ approve design ก่อน implement — ใช้ Expanded Workflow ร่วมด้วย (`/opsx:new`, `/opsx:continue`)

## User Guide (Step-by-Step)

### Setup สำหรับ Claude Code

**1. Install OpenSpec**
```bash
npm install -g @fission-ai/openspec@latest
```

**2. Init ใน project**
```bash
cd your-project
openspec init --tools claude
# Profile: core (สำหรับ beginner)
```

**3. ตรวจสอบ skill files**
```bash
ls .claude/skills/
# ควรเห็น: openspec-core/ openspec-propose/ openspec-apply/ ...
```

**4. เพิ่ม context ใน config.yaml**
```bash
cat >> openspec/config.yaml << 'EOF'

context: |
  Tech stack: [ใส่ stack ของคุณ]
  Testing: [framework ที่ใช้]
EOF
```

**5. Commit**
```bash
git add openspec/ .claude/skills/
git commit -m "feat: add openspec with claude code integration"
```

**6. ทดสอบ**
เปิด Claude Code แล้วพิมพ์:
```
/opsx:propose test-hello-world
```
ถ้าสร้าง `openspec/changes/test-hello-world/` — setup สำเร็จ

### Troubleshooting

**Claude ไม่รู้จัก `/opsx:*` commands**

ตรวจสอบ:
```bash
ls .claude/skills/          # ต้องมีไฟล์อยู่
cat .claude/skills/openspec-propose/SKILL.md  # ต้อง readable
```
ถ้าไม่มี → run `openspec update` อีกครั้ง

**Artifacts ออกมา generic ไม่ตรง project**

เพิ่ม context ใน `openspec/config.yaml`:
```yaml
context: |
  Tech stack: [ใส่ stack จริง]
  Conventions: [ใส่ conventions สำคัญ]
```
แล้ว run `openspec update`

**`/opsx:verify` ไม่ available**

Command นี้อยู่ใน Expanded Workflow เท่านั้น:
```bash
openspec config profile   # เลือก expanded
openspec update
```

## Caveats / Limits

- Skill files อยู่ใน `.claude/skills/` — ถ้า team member ไม่ run `openspec init`, Claude ของพวกเขาจะไม่รู้จัก `/opsx:*` commands; ต้องให้ทุกคน init เอง หรือ commit `.claude/skills/` เข้า repo
- `openspec update` ต้องรัน **manually** — ไม่มี auto-watch บน config changes
- Claude Code อ่าน skill files ตอน session start — ถ้า edit skill files ขณะ session กำลัง run ต้องเริ่ม session ใหม่
- ถ้าใช้ Claude Code Workspaces (หลาย projects), แต่ละ project ต้อง init OpenSpec แยก — skills ไม่ share ข้าม workspace
- Project ที่ใช้ `.mcp.json` หรือ custom CLAUDE.md อาจต้องการ cross-reference ระหว่าง `openspec/config.yaml` กับ CLAUDE.md เพื่อให้ conventions สอดคล้องกัน

## References

1. [OpenSpec Supported Tools — Claude Code entry](https://github.com/Fission-AI/OpenSpec/blob/main/docs/supported-tools.md)
2. [OpenSpec Getting Started](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md)
3. [OpenSpec Customization — config.yaml](https://github.com/Fission-AI/OpenSpec/blob/main/docs/customization.md)
4. [OpenSpec Commands Reference](https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md)
5. [Claude Code Documentation — Skills](https://docs.anthropic.com/en/docs/claude-code/skills)

## Key Takeaways

- Skill files ที่ `.claude/skills/openspec-*/SKILL.md` คือ "bridge" — Claude อ่านแล้วรู้จัก `/opsx:*` commands ทันที ไม่ต้องมี plugin
- `openspec/config.yaml` inject tech stack + rules เข้า **ทุก** OpenSpec command — ทำครั้งเดียว, ได้ผลทุก proposal
- CLAUDE.md (behavior) + config.yaml (artifact rules) ทำงานคู่กัน — cross-reference ให้สอดคล้องกัน
- `openspec update` ต้องรัน manually ทุกครั้งที่เปลี่ยน profile หรือ config
- Commit `.claude/skills/` เข้า repo ถ้าต้องการให้ทุกคนในทีม init พร้อมกัน — หรือให้แต่ละคน run `openspec init` เอง
- Claude Code context window + OpenSpec task structure = implementation ที่ aware ของ existing code patterns — ใช้ `Read` ก่อน `/opsx:apply` บน feature ซับซ้อน
