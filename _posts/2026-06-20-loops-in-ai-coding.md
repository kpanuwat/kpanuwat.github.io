---
title: "Loops ใน AI Coding: ออกแบบระบบให้ AI ทำงานอัตโนมัติจนบรรลุเป้าหมาย"
date: 2026-06-19 00:01:00 +0700
categories: [Engineering]
tags: [ai, loops, automation, claude-code, agentic, llm]
slides: true
---

{% include slide-link.html %}

## TL;DR

"Loop Engineering" คือวิวัฒนาการหลัง Prompt Engineering — แทนที่จะพิมพ์คำสั่งให้ AI ทีละครั้ง คุณ*ออกแบบระบบ*ที่คอยส่ง prompt ให้ AI เอง, ตรวจสอบผลลัพธ์, และวนซ้ำจนบรรลุเป้าหมายที่กำหนด โดยไม่ต้องมีมนุษย์นั่งเฝ้า

## Background / Why This Matters

ในเดือนมิถุนายน 2026 Boris Cherny ผู้สร้าง Claude Code จาก Anthropic พูดประโยคหนึ่งที่เขย่าวงการ AI coding:

> "I don't prompt Claude anymore. I have loops that are running. They're the ones that are prompting Claude and figuring out what to do."

นั่นคือ shift ที่สำคัญ: จาก **คุณเป็นคนพิมพ์ prompt** → **ระบบเป็นคนพิมพ์ prompt แทนคุณ**

Addy Osmani (Engineering Lead ที่ Google Chrome) และ Peter Steinberger (ผู้ก่อตั้ง PSPDFKit/Nutrient) ช่วยกันทำให้แนวคิดนี้เป็น mainstream ในชื่อ "Loop Engineering" — ทักษะ layer ถัดไปหลัง prompt engineering สำหรับยุค agentic AI

**ทำไมถึงสำคัญ?** ถ้าคุณยังพิมพ์ prompt ทีละครั้ง คุณกำลังทิ้ง leverage 90% ไว้บนโต๊ะ ใน mid-2026 AI coding agents สามารถรันงาน multi-step ได้ชั่วโมงโดยอัตโนมัติ — bottleneck ไม่ใช่ model capability อีกต่อไป แต่เป็น **การออกแบบระบบ orchestration**

## Deep Dive

### Prompt Engineering vs. Loop Engineering

| มิติ | Prompt Engineering | Loop Engineering |
|------|-------------------|-----------------|
| หน่วยงาน | One turn | Entire autonomous run |
| ใครขับเคลื่อน AI | คุณ, manual | ระบบที่คุณออกแบบ |
| ระยะเวลา | วินาที | นาที ถึง ชั่วโมง |
| Output | Response | Verified outcome |
| Leverage | 1× | 10–100× |
| ทักษะที่ต้องการ | การเลือกคำ | System design |

Prompt engineering ไม่ได้ตาย — มันคือ table stakes แต่ Loop Engineering คือ layer ถัดไป

### 5 องค์ประกอบของ Loop ที่ดี

#### 1. Trigger — อะไรเป็นตัวเปิด Loop

- **Schedule**: ทุกเช้า 9:00 น. ให้ตรวจ open issues
- **Event/Action**: มี PR เปิด, test fail, deploy เสร็จ
- **Human instruction**: "ไปแก้ ESLint warnings ทั้งหมด"
- **Another agent completes**: agent หนึ่งส่งงานต่อให้อีกตัว

ถ้าไม่มี trigger ที่ชัดเจน คุณยังคง prompt อยู่ด้วยมือ — นั่นไม่ใช่ loop

#### 2. Goal — เป้าหมายที่วัดผลได้

Goal ที่ดีต้องเป็น **verifiable end state** ไม่ใช่ process:

❌ "refactor the code" (process — วัดไม่ได้)
✅ "all tests pass + no function exceeds 40 lines" (verifiable)

**ใน Claude Code** ใช้ `/goal` command:

```bash
/goal All TypeScript files in /src pass lint with zero errors and all unit tests return green
```

```bash
/goal The README accurately documents every public function in the codebase
```

Claude ใช้ goal เป็น reference point หลังทุก action เพื่อตรวจว่าบรรลุหรือยัง ถ้ายัง → วางแผนขั้นต่อไปเอง

#### 3. Stop Condition — LLM as a Judge

เมื่อ goal ไม่ verifiable เป็น binary (เช่น "documentation ดีพอหรือยัง?") → ใช้ **LLM as a Judge**: ส่ง output ให้ LLM อีกตัวตัดสิน

```bash
/loop every 5m until: deployment succeeds
/loop until: all tests pass
```

Claude ใน loop มี **continuity** — จำว่าลองอะไรไปแล้ว, อะไรล้มเหลว, ทำไม การรัน Claude ใหม่ทุกครั้งจะเสีย context และซ้ำ mistake เดิม

#### 4. Memory — จำระหว่าง Iterations

Loop ที่ดีต้องจำว่าทำอะไรไปแล้ว:
- Skills และ instructions ที่บันทึกไว้ (ไม่ต้อง re-explain ทุกรอบ)
- สถานะปัจจุบันของ repo / codebase
- ผล iteration ก่อนหน้า

#### 5. Sub-agents — แยก Maker จาก Checker

Pattern ที่แข็งแกร่ง: **Sub-agent หนึ่งทำงาน, อีกตัวตรวจสอบ** — ป้องกัน agent หลอกตัวเอง (self-deception) เช่น เขียน test ที่ pass แทนที่จะแก้ bug จริง

### ตัวอย่าง Loop จริงในชีวิตประจำวัน

| Use Case | Trigger | Goal |
|----------|---------|------|
| เพิ่มความเร็วเว็บ | Manual / Weekly | Bundle size < 200KB + Lighthouse score ≥ 90 |
| อัปเดตเอกสาร | PR merged event | README match ทุก public API |
| จัดการ Error | CI fail event | Zero failed tests in main branch |
| ทดสอบผลิตภัณฑ์เชิงลึก | Nightly schedule | Test coverage ≥ 80% + zero P1 bugs |
| Babysit PRs | PR open event | Auto-rebase + fix CI failures |

### ใน Claude Code: `/goal` + `/loop`

```bash
# ตั้ง goal แล้วปล่อย Claude ทำงาน
/goal All TypeScript errors resolved and build succeeds

# วน loop ทุก 10 นาที
/loop every 10m

# รวม goal + loop + stop condition
/loop every 5m until: all tests pass
```

Claude จะ:
1. ประเมินสถานะปัจจุบัน
2. วางแผนขั้นต่อไป
3. ดำเนินการ (edit files, run tests, etc.)
4. ตรวจว่า goal บรรลุหรือยัง
5. ถ้ายัง → กลับไป step 1

### The Ralph Technique

"Ralph Loop" คือ pattern ที่พิสูจน์ idea นี้ก่อนจะมีชื่อ — Claude Code กำหนด goal แบบ iterative แล้วรัน sub-agent ตรวจสอบ ก่อนที่ `/goal` และ `/loop` commands จะ ship เป็น feature อย่างเป็นทางการ

## Caveats / Limits

### 1. Token Cost สูงมาก

Loop ที่รันนาน = token burn สูง ทุก iteration ใช้ context window ใหม่ + อ่านสถานะ codebase ใหม่ ต้นทุนสามารถพุ่งได้โดยไม่รู้ตัว

**แนวทาง**: กำหนด budget limit, ใช้ smaller models สำหรับ iteration สั้น, reserve ใหญ่สำหรับ final verification

### 2. Goal Design ยากสำหรับ Feature ใหม่

Loop เหมาะกับงานที่ **end state ชัดเจนและวัดได้** งาน "สร้าง feature ใหม่" มักมี goal แบบ fuzzy เช่น "ทำให้ดีขึ้น" → loop จะวนไม่หยุดหรือหยุดก่อนเวลา

**แนวทาง**: ใช้ loop กับ maintenance/optimization/testing tasks ก่อน ส่วน feature ใหม่ยังต้องการ human-in-the-loop สำหรับ goal definition

### 3. Self-Deception Risk

Agent อาจ "ผ่าน" goal โดยไม่ได้แก้ root cause เช่น เขียน test ที่ pass โดย skip assertion จริง ต้องใช้ sub-agent แยกเป็น checker

### 4. Loop ที่รันนานมีความเสี่ยงสะสม

ยิ่งรันนาน โอกาส drift จาก intent เดิมยิ่งสูง ตั้ง checkpoint intervals และ review ระหว่างทาง

### 5. ยังไม่เหมาะกับทุก Task

```
✅ Loop เหมาะกับ:        ❌ ยังต้องการ human:
- Fix lint errors         - ออกแบบ architecture ใหม่
- Update docs             - Define business requirements
- Optimize performance    - Decide trade-offs
- Run regression tests    - Creative feature design
- Monitor CI health
```

## References

1. [Loop Engineering: The New Paradigm Beyond Prompt Engineering — explainx.ai](https://explainx.ai/blog/what-is-loop-engineering-ai-agents-2026)
2. [Loop Engineering: A Practical Guide for AI Coding Agents — Lushbinary](https://lushbinary.com/blog/loop-engineering-ai-coding-agents-guide/)
3. [How to Use /goal and /loop in Claude Code — MindStudio](https://www.mindstudio.ai/blog/claude-code-goal-loop-commands-autonomous-tasks)
4. [Claude Code: The Autonomous Commands That Finish Work While You Sleep — Towards AI](https://medium.com/@richardhightower/claude-code-the-autonomous-commands-that-finish-work-while-you-sleep-goal-loop-batch-etc-7acb82bf46b1)
5. [From Prompts to Loops: Building Agentic Workflows in Codex and Claude — Medium](https://medium.com/@KilgortTrout/from-prompts-to-loops-a-practical-guide-to-building-agentic-workflows-in-codex-and-claude-0b57234452ed)
6. [Claude Code Creators Explain Agent Loops — The Neuron](https://www.theneuron.ai/explainer-articles/claude-code-creators-boris-cherny-and-cat-wu-explain-how-to-use-agent-loops/)
7. [Loops ใน AI Coding (วิดีโอต้นฉบับ) — YouTube](https://youtu.be/F4a8aMLb678)

## Key Takeaways

- **Loop Engineering** = ออกแบบระบบที่ prompt AI แทนคุณ ไม่ใช่พิมพ์ prompt เอง
- **5 องค์ประกอบ**: Trigger → Goal → Memory → Sub-agents → Stop condition
- **Goal ต้องเป็น verifiable end state** เช่น "all tests pass" ไม่ใช่ "ทำให้ดีขึ้น"
- **LLM as a Judge** ใช้เมื่อ goal วัดเป็น binary ไม่ได้ — AI ตัวอื่นเป็นคนตัดสิน
- **Claude Code `/goal` + `/loop`** คือ building blocks ที่ ship มาในตัวเอง ไม่ต้องสร้างเอง
- **ระวัง token cost** — loop ที่รันนานเผา budget เร็วมาก ต้องตั้ง limit
- เหมาะกับ maintenance/optimization/testing; ยัง human-required สำหรับ creative feature design
