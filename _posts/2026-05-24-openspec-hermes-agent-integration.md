---
title: "OpenSpec + Hermes Agent: เจาะลึกการประยุกต์ใช้ใน Multi-Agent Swarm"
date: 2026-05-24 00:07:00 +0700
categories: [Tools]
tags: [openspec, hermes-agent, multi-agent, spec-driven-development, swarm, developer-tools]
slides: true
---

{% include slide-link.html %}

## TL;DR

ใน Hermes Workspace Swarm Mode, OpenSpec ทำหน้าที่เป็น "shared spec layer" ที่ป้องกัน agent drift — แต่ละ worker อ่าน artifacts เดียวกัน (`openspec/changes/<id>/`) แทนที่จะ interpret requirement ต่างกัน; Scribe dispatch เป็น propose agent, Builder/Sidekick implement ตาม `tasks.md`, Reviewer verify ตาม `specs/`

## Background / Why this matters

ปัญหาของ vibe coding ในระดับ single-agent คือ: AI เดาว่าจะทำอะไร แล้วทำเลย ไม่มี checkpoint ก่อน implement

ใน **multi-agent swarm** ปัญหานี้คูณตัวเอง — ถ้าไม่มี shared spec:
- Builder implement feature A แบบหนึ่ง
- Sidekick implement feature A แบบอื่น (งาน parallel)
- Reviewer review โดยไม่รู้ว่า spec จริงๆ คืออะไร
- Scribe เขียน docs ที่ไม่ตรงกับ implementation

นี่คือ **agent drift** — แต่ละ agent มีความเข้าใจต่างกัน ทำให้ผลลัพธ์รวมไม่สอดคล้องกัน

OpenSpec แก้ปัญหานี้ด้วย artifacts ที่ **git-tracked และ shared** — ทุก worker อ่านจาก `openspec/changes/<id>/` เดียวกัน ก่อน execute ทุกครั้ง

## Deep Dive

### Hermes Workspace คืออะไร

**Hermes Agent** คือ AI agent จาก [NousResearch](https://github.com/NousResearch/hermes-agent) — รัน locally เป็น gateway server ที่ port 8642

**Hermes Workspace** คือ workspace built on top — chat, memory, skills, terminal, MCP, Kanban TaskBoard, และ **Swarm Mode** ที่เปลี่ยน single-agent ให้เป็น multi-agent control plane

```
User (Eric)
    │ intent
    ▼
Aurora (main agent)
    │ translates → SwarmBrief
    ▼
swarm3/Mirror (orchestrator)
    │ routes by role
    ├─→ swarm7/Scribe   ← specs, docs, handoffs
    ├─→ swarm5/Builder  ← implementation
    ├─→ swarm6/Reviewer ← code review
    ├─→ swarm4/Sage     ← research
    └─→ swarm10/Sidekick ← parallel patches
```

แต่ละ worker รันเป็น persistent tmux session — มี context ข้ามหลาย task และ checkpoint กลับไปยัง orchestrator (ไม่ message Eric โดยตรง)

### OpenSpec ใน Hermes Workspace

OpenSpec ถูก install แล้วใน hermes-workspace ที่ `.claude/skills/`:

```
hermes-workspace/
├── .claude/skills/
│   ├── openspec-propose/      ← /opsx:propose skill
│   ├── openspec-apply-change/ ← /opsx:apply skill
│   ├── openspec-archive-change/ ← /opsx:archive skill
│   ├── openspec-explore/      ← /opsx:explore skill
│   └── opsx/                  ← core OpenSpec runtime
└── openspec/
    ├── config.yaml            ← stack context (inject ทุก command)
    ├── changes/               ← proposed changes (git-tracked)
    └── specs/                 ← source of truth
```

`openspec/config.yaml` ใน hermes-workspace บอก AI ว่า stack คืออะไร:

```yaml
schema: spec-driven
context: |
  Tech stack: React 19, Vite 7, Electron 40, Node.js backend
  Package manager: pnpm. Commands: pnpm dev, pnpm build, pnpm test (Vitest)
  Swarm Mode: multi-agent orchestration via persistent tmux workers.
  Docker Compose for containerized dev/prod.
rules:
  tasks:
    - Break tasks into chunks completable in under 2 hours
    - Mark Electron-specific tasks separately from web-only tasks
```

### Agent Drift: ปัญหาที่ OpenSpec แก้ได้

ก่อนใช้ OpenSpec ใน swarm, workflow อาจเป็นแบบนี้:

```
SwarmBrief → Builder: "add dark mode"
SwarmBrief → Sidekick: "add dark mode"

Builder:  ใช้ CSS variables + ThemeContext
Sidekick: ใช้ styled-components + localStorage key ต่างกัน
Reviewer: ไม่รู้ว่า approach ไหนถูก

→ merge conflict + inconsistent implementation
```

**หลังใช้ OpenSpec:**

```
Aurora: /opsx:propose add-dark-mode
          ↓
Scribe:  review + finalize tasks.md
          ↓ (artifacts committed to git)
Builder:  /opsx:apply  ← reads same tasks.md
Sidekick: /opsx:apply --task 3  ← reads same tasks.md
Reviewer: /opsx:verify  ← checks against same specs/
          ↓
Mirror:  /opsx:sync + /opsx:archive
```

### Worker Role Mapping กับ OpenSpec Artifacts

| Worker | Role | OpenSpec ที่ใช้ |
|--------|------|----------------|
| Aurora | Main agent, intent → SwarmBrief | `/opsx:propose` เพื่อสร้าง artifacts จาก intent |
| Scribe (swarm7) | Specs, docs, handoffs | Review + refine `proposal.md` และ `tasks.md`; sync specs หลัง implement |
| Builder (swarm5) | Full-stack implementation | `/opsx:apply` implement ตาม `tasks.md` |
| Sidekick (swarm10) | Parallel patches | `/opsx:apply --task N` implement tasks ที่แยกออกมา |
| Reviewer (swarm6) | Code review, quality gate | `/opsx:verify` ตรวจว่า implementation ตรง specs |
| Mirror (swarm3) | Orchestration | `/opsx:archive` หลัง review ผ่าน |
| Sage (swarm4) | Research | `/opsx:explore` brainstorm approach ก่อน propose |

### SwarmBrief + OpenSpec Integration Pattern

สิ่งที่ทำให้ integration ทำงานดีคือ **SwarmBrief ที่ reference OpenSpec artifacts**:

```yaml
# SwarmBrief ที่ส่งไปหา Builder
brief_id: brief-2026-05-24-add-dark-mode
worker: swarm5
project: hermes-workspace
goal: implement dark mode as specified in openspec/changes/add-dark-mode/

scope:
  - ดู tasks.md ใน openspec/changes/add-dark-mode/ ก่อนเริ่ม
  - implement ทีละ task ตามลำดับที่ระบุ
  - อย่า scope creep นอก tasks.md

deliverables:
  - task checklist ใน tasks.md ครบ ✓
  - /opsx:verify ไม่มี remaining tasks

test_or_proof:
  - /opsx:verify output ไม่มี ✗
  - pnpm test ผ่าน
```

เมื่อ Builder ได้รับ brief นี้ แทนที่จะตีความ "add dark mode" เอง จะอ่าน `tasks.md` ที่ Scribe refine แล้ว — implementation ตรงกับ spec ทันที

### Parallel Worker Pattern

OpenSpec รองรับ **partial apply** — ทำให้แบ่งงานระหว่าง Builder + Sidekick ได้:

```yaml
# SwarmBrief สำหรับ Builder
goal: implement tasks 1-3 จาก openspec/changes/add-dark-mode/
# /opsx:apply --task 1.1 --task 1.2 --task 2.1 --task 2.2

# SwarmBrief สำหรับ Sidekick (parallel)
goal: implement tasks 4-5 จาก openspec/changes/add-dark-mode/
# /opsx:apply --task 3.1 --task 4.1 --task 4.2 --task 4.3
```

ทั้งสอง worker อ่าน `tasks.md` เดียวกัน แต่ implement คนละส่วน — tasks.md ทำหน้าที่เป็น **shared work queue**

### Full Swarm Flow กับ OpenSpec

```
1. Eric → Aurora: "add notification bell to header"

2. Aurora:
   /opsx:explore → วิเคราะห์ current notification system
   /opsx:propose add-notification-bell

3. Scribe (SwarmBrief → review artifacts):
   - review proposal.md: ขอบเขตถูกไหม?
   - refine tasks.md: แตก tasks ให้ < 2 ชม. ต่อ chunk
   - commit artifacts

4. Mirror dispatches:
   → Builder: implement tasks 1-3 (foundation)
   → Sidekick: implement tasks 4-6 parallel (UI layer)

5. Builder + Sidekick:
   /opsx:apply --task [assigned range]
   checkpoint กลับ orchestrator

6. Reviewer (SwarmBrief → /opsx:verify):
   STATE: DONE
   RESULT: /opsx:verify — 0 tasks incomplete

7. Scribe:
   /opsx:sync  ← merge delta specs → main specs
   /opsx:archive

8. Mirror: routes checkpoint → Reports/Inbox
```

## User Guide (Step-by-Step)

### Setup OpenSpec ใน Hermes Workspace

**1. ตรวจสอบว่า OpenSpec install แล้ว**

```bash
ls ~/hermes-workspace/.claude/skills/ | grep openspec
# ควรเห็น: openspec-propose/ openspec-apply-change/ openspec-archive-change/ ...
```

ถ้ายังไม่มี:
```bash
cd ~/hermes-workspace
openspec init --tools claude
openspec update
```

**2. ตรวจสอบ config.yaml**

```bash
cat ~/hermes-workspace/openspec/config.yaml
```

เพิ่ม swarm context ถ้ายังไม่มี:
```yaml
rules:
  tasks:
    - Break tasks into chunks completable in under 2 hours
    - Mark Electron-specific tasks separately from web-only tasks
    - แต่ละ task ควรสามารถ assign ให้ worker คนเดียวได้
  proposal:
    - ระบุ affected workers (Builder/Sidekick/etc.)
    - ระบุว่า tasks ไหน parallel ได้
```

**3. Propose ผ่าน Aurora**

เปิด Hermes Workspace แล้วพิมพ์ใน chat:
```
/opsx:propose <feature-name>
```

Aurora จะ propose artifacts ใน `openspec/changes/<feature-name>/`

**4. Dispatch SwarmBrief ที่ reference artifacts**

ใน orchestrator/Mirror dispatch, reference tasks.md:

```
ดู openspec/changes/<feature-name>/tasks.md ก่อนเริ่ม
Implement task 1.1-2.3 ตามที่ระบุใน tasks.md
ห้าม scope creep นอก tasks.md
```

**5. Verify ก่อน merge**

Reviewer ควร run:
```
/opsx:verify
```

ตรวจสอบว่า implementation ครบตาม tasks ทุกข้อก่อน PR

### Troubleshooting

**Worker implement ผิดจาก spec**

สาเหตุ: SwarmBrief ไม่ reference tasks.md อย่างชัดเจน
แก้: เพิ่ม explicit instruction ใน brief: "ดู tasks.md ใน openspec/changes/X/ ก่อน implement"

**Tasks.md ใหญ่เกิน (worker ทำไม่ทัน)**

สาเหตุ: tasks ใหญ่เกิน 2 ชม.
แก้: Scribe refine tasks.md ให้แต่ละ task เล็กลง แล้ว dispatch ใหม่

**Worker หลายตัว conflict กัน**

สาเหตุ: Builder + Sidekick implement tasks ซ้ำกัน
แก้: ใช้ `/opsx:apply --task N` ระบุ task range ใน SwarmBrief ให้ชัดเจน

## Caveats / Limits

- OpenSpec ใน hermes-workspace ถูก install สำหรับ Claude Code (`.claude/skills/`) — ถ้า worker บางตัวรัน AI model อื่น (GPT-5.5 ตาม swarm.yaml), skill files จะไม่ auto-load; worker นั้นต้องได้รับ OpenSpec instructions ผ่าน SwarmBrief context แทน
- `/opsx:verify` อ่าน `tasks.md` แล้ว scan codebase — ถ้า worker ทำงานใน git branch แยก, Reviewer ต้องอยู่ใน branch เดียวกันถึงจะ verify ได้ถูกต้อง
- Parallel apply (Builder + Sidekick) อาจเกิด merge conflict ถ้า tasks overlap — Scribe ต้อง partition tasks ให้ชัดก่อน dispatch
- `openspec/changes/` ควร commit ก่อน dispatch workers — ถ้า artifacts ยังไม่ใน git, worker บางตัวอาจดึงไม่ได้ถ้ารันใน worktree แยก
- OpenSpec `openspec update` ต้องรัน manually หลังเปลี่ยน profile — skill files ไม่ auto-sync

## References

1. [Hermes Workspace — GitHub (outsourc-e/hermes-workspace)](https://github.com/outsourc-e/hermes-workspace)
2. [NousResearch/hermes-agent — Official Installer](https://github.com/NousResearch/hermes-agent)
3. [OpenSpec Getting Started](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md)
4. [OpenSpec Commands Reference — apply with --task flag](https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md)
5. [Hermes Workspace Swarm Architecture](https://github.com/outsourc-e/hermes-workspace/blob/main/docs/swarm/)

## Key Takeaways

- **Agent drift** คือปัญหาหลักของ multi-agent swarm — แต่ละ worker interpret feature ต่างกัน ถ้าไม่มี shared spec
- OpenSpec `openspec/changes/<id>/` คือ **shared spec layer** ที่ป้องกัน drift — ทุก worker อ่านจาก artifacts เดียวกัน
- **Scribe** (swarm7) เหมาะที่สุดสำหรับ propose + refine artifacts; **Builder/Sidekick** implement ตาม tasks.md; **Reviewer** verify ตาม specs/
- SwarmBrief ที่ดีต้อง **explicit reference** `openspec/changes/<id>/tasks.md` — ไม่ใช่แค่บอก "implement feature X"
- `tasks.md` ทำหน้าที่เป็น **shared work queue** สำหรับ parallel workers — ใช้ `--task N` partition งานได้
- Commit artifacts ก่อน dispatch workers เสมอ — ถ้า `openspec/changes/` ยังไม่ใน git, parallel workers ดึงไม่ได้
