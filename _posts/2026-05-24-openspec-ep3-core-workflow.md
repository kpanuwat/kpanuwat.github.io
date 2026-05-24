---
title: "OpenSpec EP3: Core Workflow — /opsx:propose → /opsx:apply → /opsx:archive"
date: 2026-05-24 00:03:00 +0700
categories: [Tools]
tags: [openspec, spec-driven-development, ai-coding, workflow, developer-tools]
series: openspec-beginners
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

Core workflow ของ OpenSpec มี 4 คำสั่งหลัก: `propose` (สร้าง artifacts) → `apply` (implement ตาม tasks) → `sync` (merge specs) → `archive` (เก็บประวัติ) — ทั้งหมดทำผ่าน slash commands ใน AI tool โดยตรง

## Background / Why this matters

ถ้า EP1 อธิบาย "ทำไม" และ EP2 อธิบาย "ติดตั้งยังไง" — EP3 นี้คือ "ใช้งานจริงยังไง" ซึ่งเป็นหัวใจของ OpenSpec

หลายคนติดตั้งเสร็จแล้วไม่รู้ว่าจะเริ่มต้นตรงไหน บทนี้จะ walk through ตัวอย่าง feature จริงทั้ง flow เพื่อให้เห็นภาพรวมชัดเจน

## Deep Dive

### ภาพรวม Core Commands

| Command | ทำอะไร | สร้าง/ใช้อะไร |
|---------|---------|--------------|
| `/opsx:explore` | brainstorm ก่อน propose (optional) | ไม่สร้าง artifact |
| `/opsx:propose <name>` | สร้าง artifacts ทั้งหมดพร้อมกัน | proposal, specs, design, tasks |
| `/opsx:apply` | implement tasks จาก `tasks.md` | แก้ไข code จริง |
| `/opsx:sync` | merge delta specs → main specs | อัปเดต `specs/` directory |
| `/opsx:archive` | เก็บ change folder เข้า archive | ย้าย folder ไป `changes/archive/` |

### Step-by-step: Feature "Add Dark Mode"

สมมติอยากเพิ่ม dark mode ใน React app

**1. propose**

```
You: /opsx:propose add-dark-mode

AI:  Created openspec/changes/add-dark-mode/
     ✓ proposal.md    — why + what + scope
     ✓ specs/ui/spec.md  — delta specs
     ✓ design.md      — technical approach
     ✓ tasks.md       — implementation checklist
     Ready for /opsx:apply
```

ตอนนี้ใน `openspec/changes/add-dark-mode/` มีไฟล์ที่ AI สร้างให้ **ต้อง review ก่อน apply เสมอ**

**2. review artifacts** (สำคัญมาก)

เปิด `proposal.md` ตรวจ scope: ตรงกับที่ต้องการไหม?
เปิด `tasks.md` ตรวจ checklist: ครบไหม? มี task ที่ไม่ต้องการไหม?
ถ้าต้องแก้ไข — edit artifact ด้วย manual แล้วค่อย apply

**3. apply**

```
You: /opsx:apply

AI:  Working through tasks from tasks.md...
     ✓ 1.1 Add ThemeContext provider
     ✓ 1.2 Create ThemeToggle component
     ✓ 2.1 Add CSS variables for dark/light theme
     ✓ 2.2 Persist preference in localStorage
     All tasks complete!
```

AI implement code ตาม tasks ใน `tasks.md` ทีละ task — ไม่ได้เดาเอง

**4. sync**

```
You: /opsx:sync

AI:  Merging delta specs into main specs...
     ✓ Merged specs/ui/spec.md → openspec/specs/ui/spec.md
```

Delta specs (สิ่งที่เปลี่ยน) ถูก merge เข้า source of truth หลัก

**5. archive**

```
You: /opsx:archive

AI:  ✓ Archived openspec/changes/add-dark-mode/
       → openspec/changes/archive/2026-05-24-add-dark-mode/
```

Change folder เก็บเป็น history ไว้ดูย้อนหลังได้

### `/opsx:explore` — ใช้เมื่อไร?

`explore` ใช้เมื่อยังไม่ชัดว่าจะทำอะไร หรืออยากให้ AI วิเคราะห์ codebase ก่อน:

```
You: /opsx:explore

AI:  What would you like to explore?

You: เราควร implement auth ยังไง ระหว่าง JWT กับ session-based?

AI:  Let me look at your current setup...
     [วิเคราะห์ codebase]

     ตอนนี้ใช้ session-based สำหรับ web app
     สำหรับ mobile เราสามารถเลือก:
     1. JWT tokens — stateless, offline-friendly
     2. OAuth2 — ถ้าต้องการ third-party login
     3. Extend sessions — simpler แต่ต้อง connectivity

     อยากเริ่ม propose ทิศทางไหนดีครับ?

You: เลือก JWT ครับ

AI:  Run /opsx:propose add-jwt-auth เพื่อเริ่มได้เลย
```

`explore` ไม่สร้าง artifact — เป็นแค่ "คิดด้วยกัน" ก่อน commit ไปทาง propose

### เมื่อ artifact ต้องการการแก้ไขก่อน apply

ถ้า `tasks.md` ที่ AI สร้างมี task ที่ไม่ต้องการ หรือขาด task สำคัญ:

```bash
# แก้ไข tasks.md ด้วย text editor
vi openspec/changes/add-dark-mode/tasks.md
```

แล้ว apply ต่อ — AI จะ implement ตาม tasks ที่แก้แล้ว ไม่ใช่ตามต้นฉบับ

### Partial apply

ถ้าอยาก apply แค่บาง tasks:

```
You: /opsx:apply --task 1.1

AI:  Implementing task 1.1 only...
     ✓ 1.1 Add ThemeContext provider
```

แล้วค่อย review ก่อน apply tasks ถัดไป

## User Guide (Step-by-Step)

### ทำ feature จริงตาม workflow

**กรณี: อยากเพิ่ม user notification feature**

```
# Step 1: (optional) explore ถ้ายังไม่ชัด
/opsx:explore "notification system — push vs polling"

# Step 2: propose
/opsx:propose add-user-notifications

# Step 3: review artifacts (manual)
# เปิด openspec/changes/add-user-notifications/proposal.md
# เปิด openspec/changes/add-user-notifications/tasks.md
# แก้ถ้าจำเป็น

# Step 4: apply
/opsx:apply

# Step 5: test code ที่ AI เขียน (ทำปกติ)
npm test

# Step 6: sync specs
/opsx:sync

# Step 7: archive
/opsx:archive
```

### Checkpoint สำคัญ

| จุด | ต้องทำอะไร |
|-----|-----------|
| หลัง propose | review artifacts ก่อน apply เสมอ |
| ระหว่าง apply | ถ้า AI ถามอะไร ตอบให้ชัด |
| หลัง apply | run tests ปกติ — OpenSpec ไม่แทนที่การ test |
| ก่อน archive | sync specs เสมอ เพื่อ source of truth update |

## Caveats / Limits

- **`/opsx:sync` ต้องทำก่อน `/opsx:archive`** เสมอ — ถ้า archive โดยไม่ sync, delta specs จะหายไปโดยไม่ merge เข้า main
- `propose` generate artifacts ด้วย AI — artifacts อาจไม่สมบูรณ์ 100%; review ก่อน apply เสมอ
- ถ้า codebase ใหญ่มากและ AI ไม่มี `specs/` เป็น context, `propose` อาจได้ artifacts ที่ generic — แก้ไขด้วยการเพิ่ม context ใน `openspec/config.yaml` (อธิบายใน EP5)
- `apply` implement ตาม `tasks.md` — ถ้า tasks เขียนไม่ดี, implementation ก็จะออกมาไม่ดี; garbage in, garbage out ยังใช้อยู่

## References

1. [OpenSpec Commands Reference](https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md)
2. [OpenSpec Workflows Guide](https://github.com/Fission-AI/OpenSpec/blob/main/docs/workflows.md)
3. [OpenSpec Getting Started](https://github.com/Fission-AI/OpenSpec/blob/main/docs/getting-started.md)

## Key Takeaways

- Core flow: `propose` → review artifacts → `apply` → test → `sync` → `archive`
- **Review artifacts ก่อน apply เสมอ** — AI สร้าง draft; คุณ finalize
- `explore` ใช้เมื่อ requirement ยังไม่ชัด — brainstorm ก่อน commit ไป propose
- `sync` ต้องทำก่อน `archive` เพื่อ merge delta specs เข้า source of truth
- Artifacts อยู่ใน git → ทำ PR review ได้; เพื่อนร่วมทีม review spec ก่อน implement
