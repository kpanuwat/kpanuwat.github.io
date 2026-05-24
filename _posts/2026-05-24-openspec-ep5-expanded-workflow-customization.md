---
title: "OpenSpec EP5: Expanded Workflow, Customization และ Tool Integrations"
date: 2026-05-24 00:05:00 +0700
categories: [Tools]
tags: [openspec, spec-driven-development, ai-coding, customization, developer-tools]
series: openspec-beginners
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

เมื่อ Core Profile ไม่พอ: เปิด Expanded Workflow ได้ด้วย `openspec config profile` สำหรับ artifact-by-artifact control; ใช้ `openspec/config.yaml` inject project context ให้ AI สร้าง artifacts ที่ specific กว่า; รองรับ 25+ AI tools พร้อมกัน

## Background / Why this matters

3 EP ที่ผ่านมาคือ Core OpenSpec ที่ครอบคลุม 80% ของ use case EP สุดท้ายนี้คือ 20% ที่เหลือ — สำหรับ team ที่ต้องการควบคุมมากขึ้น, อยากปรับ artifact format ให้ตรง process ของทีม, หรือ project ที่ซับซ้อนจนต้องมี artifact ทีละชิ้น

## Deep Dive

### Expanded Workflow: ควบคุม artifact ทีละชิ้น

Core `/opsx:propose` สร้าง artifacts ทั้งหมดพร้อมกัน แต่ Expanded Workflow ให้ควบคุมทีละ artifact:

| Command | ทำอะไร |
|---------|---------|
| `/opsx:new` | สร้าง change folder + `.openspec.yaml` metadata |
| `/opsx:continue` | สร้าง artifact ถัดไปตาม dependency chain |
| `/opsx:ff` | fast-forward: สร้าง artifacts ทั้งหมดที่ยังขาดอยู่ |
| `/opsx:verify` | ตรวจสอบว่า implementation ตรงกับ artifacts ไหม |
| `/opsx:bulk-archive` | archive หลาย changes พร้อมกัน |
| `/opsx:onboard` | tutorial แบบ guided สำหรับ newcomers |

**เปิด Expanded Workflow:**

```bash
openspec config profile   # เลือก profile ที่ต้องการ
openspec update           # sync skill files ไปยัง AI tools ทั้งหมด
```

**ตัวอย่าง Expanded flow:**

```
You: /opsx:new add-payment-gateway

AI:  Created openspec/changes/add-payment-gateway/
     Next: proposal — run /opsx:continue

You: /opsx:continue

AI:  Creating proposal.md...
     ✓ proposal.md created
     Next: specs — run /opsx:continue

You: [review + edit proposal.md]

You: /opsx:continue

AI:  Creating specs/...
     ✓ specs/payments/spec.md created
     Next: design — run /opsx:continue

You: /opsx:ff   # ถ้าอยากข้ามไปสร้าง design + tasks ทีเดียว

AI:  ✓ design.md
     ✓ tasks.md
     Ready for /opsx:apply!
```

ประโยชน์: review และ approve ทีละ artifact ก่อน artifact ถัดไปถูกสร้าง — ลด rework เพราะ upstream artifact ไม่ดี

### `/opsx:verify` — ตรวจสอบ implementation ตรง spec ไหม

```
You: /opsx:verify

AI:  Checking implementation against artifacts...

     ✓ ThemeContext created at src/contexts/ThemeContext.tsx
     ✓ CSS variables added to global.css
     ✗ localStorage persistence missing (tasks.md 4.1–4.3)

     2 tasks incomplete. Run /opsx:apply to finish.
```

`verify` อ่าน `tasks.md` แล้ว scan codebase ว่า implement ครบหรือเปล่า — ใช้ก่อน PR review เพื่อ sanity check

### Customization ด้วย `openspec/config.yaml`

นี่คือไฟล์ที่ปลดล็อค artifacts ให้ specific กับ project ของคุณจริงๆ

```yaml
# openspec/config.yaml
schema: spec-driven

context: |
  Tech stack: TypeScript, React 19, Node.js 22, PostgreSQL 16
  API style: RESTful, JSON:API format
  Testing: Vitest (unit), Playwright (e2e), MSW (mocking)
  Auth: Clerk for authentication
  State: Zustand (client), React Query (server)
  Style: Tailwind CSS v4, no vanilla CSS

rules:
  proposal:
    - Include rollback plan สำหรับทุก change
    - ระบุ affected teams (Frontend / Backend / Infra)
    - Estimate story points (1/3/5/8)
  specs:
    - ใช้ Given/When/Then format
    - Reference existing spec files ที่ relate
  design:
    - Include sequence diagram สำหรับ async operations
    - ระบุ new npm packages ที่ต้องติดตั้ง (ถ้ามี)
  tasks:
    - แต่ละ task ≤ 30 นาที
    - เพิ่ม unit test task สำหรับทุก business logic
```

**ผลลัพธ์:** AI จะ generate artifacts ที่ mention Zustand, Clerk, JSON:API, และ include Given/When/Then ใน specs โดยอัตโนมัติ — ไม่ต้องบอกทุกครั้ง

### Custom Schemas: สร้าง workflow ของตัวเอง

ถ้า artifact structure เริ่มต้นไม่ตรงกับ process ของ team, สร้าง custom schema ได้:

```yaml
# openspec/schemas/our-workflow.yaml
name: our-workflow
artifacts:
  - id: rfc
    name: RFC Document
    template: templates/rfc.md
    description: Request for Comments — architectural decisions
  - id: tasks
    name: Implementation Tasks
    template: templates/tasks.md
    depends_on: [rfc]
```

แล้วใช้:
```bash
/opsx:new my-feature --schema our-workflow
```

เหมาะสำหรับ team ที่มี RFC process, ADR (Architecture Decision Records), หรือ custom planning documents

### Multi-tool: ใช้หลาย AI tools พร้อมกัน

```bash
openspec init   # เลือกหลาย tools พร้อมกัน
# หรือ update หลังเพิ่ม tool ใหม่:
openspec update
```

OpenSpec sync skill files ไปยัง tool directories ทั้งหมด:

```
your-project/
├── .claude/skills/openspec-*/SKILL.md     ← Claude Code
├── .cursor/skills/openspec-*/SKILL.md     ← Cursor
├── .windsurf/skills/openspec-*/SKILL.md   ← Windsurf
└── .github/skills/openspec-*/SKILL.md     ← GitHub Copilot
```

ทุกคนในทีมใช้ AI tool ที่ต่างกันแต่ทำงานกับ `openspec/` folder เดียวกันได้เลย

### Workspace (Multi-repo) — Experimental

สำหรับ monorepo หรือ cross-repo planning (ยัง experimental):

```bash
openspec workspace init   # สร้าง workspace folder
openspec workspace link api /repos/api
openspec workspace link web /repos/web
```

สร้าง `workspace.yaml` + `local.yaml` ที่ track links ระหว่าง repos โดยไม่เก็บ absolute paths ใน shared files

> ⚠ Workspace feature ยัง **not stable** — อย่าใช้ใน production automation; API อาจเปลี่ยนได้ตลอด

## User Guide (Step-by-Step)

### เพิ่ม context ให้ AI สร้าง artifacts ได้ดีขึ้น

1. สร้าง `openspec/config.yaml` ถ้ายังไม่มี:
   ```bash
   openspec init   # ถ้า init ใหม่
   # หรือสร้าง manual:
   touch openspec/config.yaml
   ```

2. เพิ่ม context และ rules (ตาม project จริง):
   ```yaml
   context: |
     Tech stack: [ใส่ stack จริง]
     Testing: [ใส่ testing framework]
     Conventions: [ใส่ coding conventions สำคัญ]
   
   rules:
     tasks:
       - Each task should be completable in under 30 minutes
       - Include test tasks for every business logic change
   ```

3. ทดสอบด้วย propose ใหม่แล้วเปรียบเทียบ artifacts กับก่อนมี config

### เปิด Expanded Workflow

```bash
openspec config profile   # ตอบ prompts เพื่อเลือก expanded commands
openspec update           # sync skill files
```

ทดสอบ:
```
/opsx:new test-expanded
/opsx:continue
```

## Caveats / Limits

- Custom schemas ต้องมี `depends_on` ที่ถูกต้อง — ถ้า artifact A ต้องการ B แต่ไม่ได้ declare dependency, `/opsx:continue` อาจ skip
- `openspec update` ต้องรันทุกครั้งที่เปลี่ยน profile หรือ config — ไม่ auto-update
- Workspace feature ยัง experimental — local.yaml เก็บ absolute paths ที่ใช้ได้แค่บน machine ของคุณ, ไม่ควร commit
- ถ้ามี multiple AI tools, skill files จะถูก install ทั้งหมด — อาจต้อง commit หลาย directories เพิ่มเข้า repo

## References

1. [OpenSpec OPSX Workflow Documentation](https://github.com/Fission-AI/OpenSpec/blob/main/docs/opsx.md)
2. [OpenSpec Customization — Schemas and Config](https://github.com/Fission-AI/OpenSpec/blob/main/docs/customization.md)
3. [OpenSpec Supported Tools — Full List](https://github.com/Fission-AI/OpenSpec/blob/main/docs/supported-tools.md)
4. [OpenSpec Commands — Expanded Set](https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md)

## Key Takeaways

- Expanded Workflow เหมาะกับ feature ใหญ่ที่ต้องการ review artifact ทีละชิ้น ก่อนสร้างอันถัดไป
- `openspec/config.yaml` คือ investment ที่คุ้มที่สุด — ทำ artifacts specific กับ project ได้โดยไม่ต้อง prompt ทุกครั้ง
- `/opsx:verify` ใช้ก่อน PR review เพื่อ sanity check ว่า implementation ครบตาม tasks
- `openspec update` ต้องรันทุกครั้งที่เปลี่ยน config/profile เพื่อ sync skill files
- Workspace (cross-repo) ยัง experimental — ใช้ได้แต่อย่า depend ใน automation
