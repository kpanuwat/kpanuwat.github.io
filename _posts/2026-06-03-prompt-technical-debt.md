---
title: "Prompt Technical Debt: ทำไม System Prompt ที่ซับซ้อนทำให้ AI โง่ลง"
date: 2026-06-02 00:02:00 +0700
categories: [Engineering]
tags: [prompt-engineering, tech-debt, llm, ai-agents, context-management]
slides: true
---

{% include slide-link.html %}

## TL;DR

Prompt ไม่ต่างจาก code — มันสะสมกลายเป็นหนี้ทางเทคนิค (Technical Debt) ได้ แต่อันตรายกว่ามาก เพราะ code debt ล้มเหลวเสียงดัง ส่วน prompt debt เน่าเงียบๆ ทุก model upgrade อาจทำให้ prompt เก่าที่เคยใช้งานได้ดี กลายเป็นตัวถ่วงความสามารถของ AI โดยที่คุณไม่รู้ตัว

## Background / Why This Matters

ก่อนหน้านี้นักพัฒนาส่วนใหญ่มองว่า code คือสิ่งที่ต้องดูแล ส่วน prompt แค่เป็น "ข้อความ" ที่เขียนครั้งเดียวแล้วลืมได้ แต่โลกของ AI-assisted development เปลี่ยนไปมากแล้ว — โปรเจกต์ขนาดใหญ่วันนี้มักมี `AGENTS.md`, `CLAUDE.md`, skill files, MCP server descriptions, และ dynamic system prompts ที่สร้างขึ้น runtime กองอยู่เต็มไปหมด

ปัญหาคือ prompt เหล่านี้มักถูกเขียนขึ้นสำหรับ model เวอร์ชันหนึ่ง แล้วก็ถูกทิ้งไว้โดยไม่อัปเดต ในขณะที่ทีมยุ่งอยู่กับการ ship features สำคัญกว่า เดือนผ่านไป model upgrade มาหลายรอบ แต่ไฟล์ instruction ยังอยู่เหมือนเดิม ผลที่ได้คือ AI ที่ "โง่ลง" กว่าที่ควรจะเป็นในทุกวัน

Sean Goedecke นักพัฒนาอาวุโสที่ GitHub เรียกปรากฏการณ์นี้ว่า prompt debt — หนี้ที่ซ่อนตัวอยู่ในทุก configuration file ที่ไม่ได้แตะมา 2 เดือน

## Deep Dive

### Prompt Debt คืออะไร

เหมือนกับ code ทุก prompt ที่เพิ่มเข้ามาล้วนเพิ่ม complexity และ maintenance burden ให้ระบบ แต่ prompt debt นั้น "แย่กว่า" code debt ในด้านสำคัญ:

| | Code Debt | Prompt Debt |
|---|---|---|
| การล้มเหลว | เสียงดัง (errors, slowdowns) | เงียบ (AI แค่ทำงานได้แย่ลง) |
| ความเสถียร | stable เมื่อไม่ถูกแตะ | ทุก model upgrade อาจทำลายมัน |
| การตรวจสอบ | ดูจาก stack trace ได้ | ต้องสังเกตพฤติกรรมเอง |

> "Prompts will decay silently. Even janky code tends to be relatively stable when untouched, but every single model upgrade could turn a functional prompt into a non-functional one." — Sean Goedecke [2]

### กลไกการสะสมของ Prompt Debt

**1. Proliferation of Files**
โปรเจกต์ใหญ่มักมีไฟล์ prompt หลายชั้น: `AGENTS.md` ระดับ project, `CLAUDE.md` ระดับ subdirectory, skills, tool-specific prompts, และ dynamic system prompts ที่ปรับตาม parameters เช่น tools ที่เปิดอยู่หรือ model ที่ใช้ [1, 2]

**2. Plugin และ MCP Bloat**
การ install plugin หรือ MCP server คือการเพิ่ม prompt อีกชุดหนึ่งเข้าสู่ context โดยอัตโนมัติ ทุกครั้งที่ agent เริ่มทำงาน token จำนวนมากถูกใช้ไปกับ tool descriptions เหล่านั้นก่อนที่จะทำงานจริงสักบรรทัด [1]

```
คนจำนวนมากไปกด install ทุก MCP ที่ดูน่าสนใจ
พอเริ่ม agent ครึ่งหนึ่งของ context ก็หมดแล้ว
แล้วก็งงว่า ทำไม AI ถึงโง่
```

**3. Auto-generated Fluff**
เมื่อให้ AI สร้าง configuration file ให้เอง มันมักสร้าง text ยาวๆ โดยไม่กลั่นกรอง นักพัฒนาหลายคน copy-paste ผลลัพธ์นั้นเข้า `CLAUDE.md` โดยตรงโดยไม่อ่าน กลายเป็นหนี้ที่ซ่อนอยู่ตั้งแต่วันแรก

**4. Stagnation — ไฟล์ที่ไม่เคยถูกแตะ**
ตัวอย่างจากวิดีโอ: T3 Chat repo มี `AGENTS.md` ที่ไม่ได้อัปเดตมา 2 เดือน ยังเขียนอยู่ว่า "this repo is a very early WIP" และ "T3 Chat is currently Codex-first" ทั้งที่ทั้งสองอย่างไม่เป็นความจริงอีกต่อไปแล้ว [1] คำสั่งเหล่านี้ยังคง steering model ทุกวัน

### Outdated Prompts ทำให้ AI รุ่นใหม่โง่ลงได้อย่างไร

Prompt นั้น model-specific มาก สิ่งที่ unlock performance ของ model เก่าอาจ restrict หรือทำให้ model ใหม่สับสนได้ ตัวอย่าง behavior steering ที่ล้าสมัย:

- `"Think step by step"` — model รุ่นใหม่มี built-in chain-of-thought อยู่แล้ว การบอกซ้ำอาจรบกวนกระบวนการคิดมากกว่าช่วย
- `"You are a skilled senior engineer"` — model ใหม่ไม่ต้องการ persona injection แบบนี้แล้ว
- `"I'll tip you $200 if you do this correctly"` — trick จาก GPT-3 era ที่ไม่มีผลกับ model ใหม่

ปัญหาคือ legacy instruction เหล่านี้ยังคง occupy context space และอาจสั่งให้ model ทำในสิ่งที่ model ใหม่ตัดสินใจได้ดีกว่าถ้าปล่อยให้มันทำเอง [1, 2]

### Context Rot: อาการของ Prompt Debt ที่สะสม

เมื่อ prompt debt สะสมมากพอ จะเกิด "context rot" — model attention เริ่มเจือจาง สัญญาณที่สังเกตได้ [3]:

- AI หยิบ idea เก่าที่เคย reject มาใช้ซ้ำ
- ให้คำตอบแบบ hedged, vague แทนที่จะตรงประเด็น
- ขัดแย้งกับสิ่งที่ตัวเองพูดไปก่อนหน้า
- นำ bug กลับมาอีกครั้งในโค้ดที่เพิ่งแก้ไปแล้ว

นี่ไม่ใช่ bug ของ model — มันคืออาการของ context ที่มีสัญญาณรบกวนมากเกินไป

## User Guide: วิธีจัดการ Prompt Technical Debt

### 1. Minimal Config Philosophy

กฎทองคือ: ใช้ third-party tools ที่บริษัทใหญ่ดูแลให้ดีที่สุด แล้วปล่อยให้มันทำงานใกล้เคียง stock มากที่สุด

ทีม engineering ที่ Cursor, Copilot, หรือ Claude Code ใช้เวลา benchmark และ tune system prompt ของพวกเขาทุกครั้งที่ model ใหม่ออกมา ถ้าคุณ override ด้วย custom prompt ของตัวเอง คุณกำลังต่อสู้กับงานที่คนอื่นทำให้คุณแล้ว [1]

### 2. เขียน CLAUDE.md / AGENTS.md แบบ Lean

ปฏิบัติกับ instruction file เหมือน onboarding doc สำหรับ contractor ใหม่ ไม่ใช่ brain dump:

```
✅ ใส่: project purpose, tech stack, non-standard conventions
❌ ห้าม: behavior steering ยาวๆ, persona injection, trick เก่าๆ
📏 เป้าหมาย: ไม่เกิน 500 words
```

ทุก token ใน `CLAUDE.md` ถูกใช้ตั้งแต่ session เริ่ม — ก่อนที่งานจริงจะเริ่มต้น [3]

### 3. ตรวจสอบ Prompt Inventory ของคุณ

```bash
# ดูไฟล์ที่ไม่ได้แตะมานาน
find . -name "*.md" -name "AGENTS*" -o -name "CLAUDE*" | \
  xargs ls -lt | head -20

# ดูว่า MCP server ไหนบ้างที่ enabled อยู่
cat ~/.claude/settings.json | jq '.mcpServers | keys'
```

คำถามที่ต้องถามกับทุก instruction:
- มันยังเป็นความจริงอยู่ไหม?
- มันเขียนขึ้นสำหรับ model รุ่นไหน?
- ถ้าลบทิ้งแล้ว AI จะทำงานได้แย่ลงจริงไหม?

### 4. Session Hygiene

| คำสั่ง | เมื่อใช้ |
|--------|---------|
| `/clear` | ก่อนเริ่มงานใหม่ที่ไม่เกี่ยวกับงานเดิม |
| `/compact` | Session ยาวที่ productive แต่ context เริ่มหนัก |
| Pre-summarize | เขียน 1 ประโยคสรุป goal ปัจจุบันก่อน `/clear` |

## Caveats / Limits

- **Minimal ≠ ไม่มีเลย** — บาง project conventions จำเป็นต้องระบุจริงๆ (เช่น non-standard file structure, specific forbidden patterns) กฎคือใส่เฉพาะที่ AI ไม่มีทางรู้เองได้
- **Prompt auditing ต้องใช้ effort** — ยังไม่มี tool ที่ detect stale instructions ได้อัตโนมัติ ต้องอาศัย human judgment
- **Model-specific optimization ยังมีคุณค่า** — สำหรับ production LLM application (ไม่ใช่ coding assistant) การ tune prompt ยังสำคัญ แต่ต้องทำด้วย benchmark ที่ชัดเจน ไม่ใช่ guess

## References

1. [Your prompts are tech debt. (YouTube)](https://youtu.be/WnBx1Vi7M6w)
2. [Prompts are technical debt too — Sean Goedecke](https://www.seangoedecke.com/prompts-are-technical-debt-too/)
3. [What Is Context Rot in Claude Code? — MindStudio](https://www.mindstudio.ai/blog/what-is-context-rot-claude-code)
4. [Why prompt debt, retrieval debt, and evaluation debt are quietly reshaping enterprise AI risk — VentureBeat](https://venturebeat.com/technology/why-prompt-debt-retrieval-debt-and-evaluation-debt-are-quietly-reshaping-enterprise-ai-risk)

## Key Takeaways

- Prompt debt แย่กว่า code debt เพราะ **เน่าเงียบ** — ไม่มี error log, ไม่มี alert, AI แค่ทำงานได้แย่ลงเรื่อยๆ
- ทุก model upgrade อาจทำให้ legacy behavior steering ที่เคยใช้งานได้ กลายเป็นตัวถ่วงความสามารถของ model ใหม่
- MCP server, plugin, และ skill files ที่ติดตั้งแต่ไม่ใช้คือ hidden prompt debt ที่ดูดเปลือง context token ทุก session
- กฎ "ใกล้เคียง stock มากที่สุด" — trust ทีมที่ maintain tool ให้ optimze สำหรับ model ใหม่แทนที่จะ override เอง
- `CLAUDE.md` ควรอยู่ใต้ 500 words — เขียนสำหรับ contractor ที่ฉลาดแต่ไม่รู้ project ของคุณ ไม่ใช่สำหรับ machine ที่โง่
- ตรวจสอบ instruction files เป็น regular habit — ถามตัวเองว่า "ถ้าลบทิ้ง AI จะทำงานได้แย่ลงจริงไหม?"
- `/clear` + pre-summarize = วิธีที่ถูกที่สุดในการ reset context rot ระหว่าง session
