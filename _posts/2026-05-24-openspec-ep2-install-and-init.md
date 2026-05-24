---
title: "OpenSpec EP2: ติดตั้งและ Init โปรเจกต์แรก"
date: 2026-05-23 00:02:00 +0700
categories: [Tools]
tags: [openspec, spec-driven-development, ai-coding, developer-tools, nodejs]
series: openspec-beginners
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

ติดตั้ง OpenSpec ด้วย `npm install -g @fission-ai/openspec@latest` แล้ว `openspec init` ใน project folder — ใช้เวลาไม่ถึง 2 นาที ได้โครงสร้าง `openspec/` ที่พร้อมใช้งานทันที

## Background / Why this matters

Installation ของ OpenSpec ออกแบบมาให้ง่ายที่สุด — ต่างจาก spec frameworks อื่นที่ต้องการ config ยาวๆ หรือ server เสริม OpenSpec เป็นแค่ CLI + markdown files ใน repo ของคุณ ไม่มี external dependency, ไม่มี subscription required, ทำงาน offline ได้

สิ่งที่ต้องรู้ก่อนติดตั้ง:
- ต้องมี **Node.js 20.19.0+** (ตรวจสอบด้วย `node --version`)
- ไม่ต้องสร้าง account
- ทำงานได้กับ repo ที่มีอยู่แล้ว (brownfield) ไม่ต้องเริ่มใหม่

## Deep Dive

### โครงสร้างที่ `openspec init` สร้าง

หลัง init แล้ว project จะมีโครงสร้างนี้:

```
your-project/
└── openspec/
    ├── specs/              ← source of truth
    │   └── <domain>/
    │       └── spec.md
    ├── changes/            ← proposed changes (ยังไม่ merge)
    │   └── <change-name>/
    │       ├── proposal.md
    │       ├── design.md
    │       ├── tasks.md
    │       └── specs/      ← delta specs
    └── config.yaml         ← project config (optional)
```

**`specs/`** — เอกสาร source of truth บอกว่าระบบทำงานยังไง แบ่งตาม domain เช่น `specs/auth/`, `specs/payments/`, `specs/api/`

**`changes/`** — แต่ละ feature/fix มี folder ของตัวเอง เมื่อ archive แล้ว delta specs จะ merge กลับเข้า `specs/` หลัก

**`config.yaml`** — optional แต่แนะนำสำหรับ team; inject tech stack context ให้ AI โดยอัตโนมัติ

### Profiles: Core vs Expanded Workflow

OpenSpec มี 2 mode หลัก:

| | Core Profile (default) | Expanded Workflow |
|--|--|--|
| Commands | propose, explore, apply, sync, archive | + new, continue, ff, verify, bulk-archive, onboard |
| เหมาะกับ | ส่วนใหญ่ของงาน | งานที่ต้องการ artifact-by-artifact control |
| วิธีเปิด | default | `openspec config profile` → `openspec update` |

Beginners แนะนำเริ่มจาก **Core Profile** ก่อน — ใช้งานง่ายกว่า

### Tool Integration

`openspec init` ถามว่าใช้ AI tool อะไร แล้ว install skill files ให้อัตโนมัติ รองรับ 25+ tools:

| Tool | Skill path |
|------|-----------|
| Claude Code | `.claude/skills/openspec-*/SKILL.md` |
| Cursor | `.cursor/skills/openspec-*/SKILL.md` |
| Windsurf | `.windsurf/skills/openspec-*/SKILL.md` |
| GitHub Copilot | `.github/skills/openspec-*/SKILL.md` |
| Gemini CLI | `.gemini/skills/openspec-*/SKILL.md` |

Skill files คือ Markdown ที่บอก AI ว่า OpenSpec commands แต่ละตัวทำงานยังไง — AI อ่านแล้วรู้วิธีใช้ commands โดยอัตโนมัติ

## User Guide (Step-by-Step)

### Step 1: ตรวจสอบ Node.js version

```bash
node --version
# ต้องได้ v20.19.0 หรือสูงกว่า
```

ถ้าเวอร์ชันต่ำกว่า ใช้ `nvm` upgrade:
```bash
nvm install 20
nvm use 20
```

### Step 2: ติดตั้ง OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

ตรวจสอบว่าติดตั้งสำเร็จ:
```bash
openspec --version
# คาดหวัง: X.Y.Z (เวอร์ชัน latest)
```

### Step 3: Init ใน project ของคุณ

```bash
cd your-project
openspec init
```

Init wizard จะถาม:
1. **Profile** — เลือก `core` สำหรับ beginner
2. **AI tools** — เลือก tool ที่ใช้ (Claude Code, Cursor, ฯลฯ)
3. **Language** — ภาษาหลัก (optional)

หลัง init: `openspec/` folder จะถูกสร้าง พร้อม skill files สำหรับ AI tool ที่เลือก

### Step 4: ทดสอบว่า AI รู้จัก OpenSpec แล้ว

เปิด AI tool แล้วพิมพ์:
```
/opsx:propose test-hello-world
```

ถ้า AI สร้าง `openspec/changes/test-hello-world/` แสดงว่า setup ถูกต้อง

### Step 5: Commit openspec/ เข้า git

```bash
git add openspec/
git commit -m "feat: add OpenSpec to project"
```

แนะนำ **อย่า `.gitignore` openspec/changes/** เพราะ artifacts ควรอยู่ใน version control

## Caveats / Limits

- `openspec init` ต้องทำใน project root (ที่มี git repository หรือ package.json)
- ถ้า project มี multiple AI tools, `openspec update` ใช้ sync skill files ให้ทุก tool พร้อมกัน
- `config.yaml` เป็น optional แต่ถ้าไม่ตั้ง AI จะไม่รู้ tech stack ของ project → artifacts อาจ generic เกินไป
- ถ้า Node.js version ต่ำกว่า 20.19.0 จะ error ตอน install — ต้อง upgrade ก่อน

## References

1. [OpenSpec Installation Guide](https://github.com/Fission-AI/OpenSpec/blob/main/docs/installation.md)
2. [OpenSpec Getting Started](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md)
3. [OpenSpec Supported Tools](https://github.com/Fission-AI/OpenSpec/blob/main/docs/supported-tools.md)
4. [OpenSpec Customization — config.yaml](https://github.com/Fission-AI/OpenSpec/blob/main/docs/customization.md)

## Key Takeaways

- ต้องใช้ Node.js 20.19.0+ เท่านั้น — ตรวจสอบ version ก่อนติดตั้ง
- `npm install -g @fission-ai/openspec@latest` + `openspec init` = พร้อมใช้งาน
- Init wizard ตั้งค่า AI tool integration ให้อัตโนมัติ — ไม่ต้อง config manual
- `openspec/` ควร commit เข้า git เพื่อให้ทั้ง team ใช้ artifacts ร่วมกัน
- เริ่มด้วย Core Profile ก่อน — propose, apply, archive ครอบคลุม 80% ของ use case
