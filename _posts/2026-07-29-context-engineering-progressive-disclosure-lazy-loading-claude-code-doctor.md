---
title: "Context Engineering ยุคใหม่: Claude 5 ฉลาดพอให้ลบ System Prompt ทิ้ง 80% ด้วยคำสั่ง /doctor"
date: 2026-07-28 00:01:00 +0700
categories: [Engineering]
tags: [context-engineering, claude-code, progressive-disclosure, lazy-loading, claude-5, doctor-command, token-optimization]
slides: true
---

{% include slide-link.html %}

## TL;DR

Anthropic ลบ system prompt ของ Claude Code ทิ้งกว่า 80% สำหรับ Claude Opus 5 และ Claude Fable 5 โดยไม่มี performance loss ที่วัดได้ (Thariq Shihipar, 24 ก.ค. 2026) — หลักการ context engineering ยุคใหม่เปลี่ยนจาก "กฎตายตัว" เป็น "ดุลพินิจของโมเดล" และใช้ **Progressive Disclosure** ผ่าน Skills แทนการยัดทุกอย่างไว้ล่วงหน้าใน context พร้อมคำสั่ง **`/doctor`** (v2.1.205) ที่ช่วยตรวจจับ skill/MCP/plugin ที่ไม่เคยใช้แต่แอบกิน token ทุกเซสชัน

## Background / Why this matters

โมเดลรุ่นแรกๆ ต้องการ "ราวกั้น" (guardrail) จำนวนมากในรูป system prompt ยาวๆ เพราะถ้าไม่มีกฎละเอียด โมเดลอาจทำเรื่องแย่ๆ โดยไม่ตั้งใจ เช่น ลบไฟล์ทิ้งหรือเขียนคอมเมนต์แบบไม่มืออาชีพ ทีม Claude Code จึงเขียนกฎเฉพาะเจาะจง เช่น "ห้ามเขียน docstring หลายย่อหน้า" ทั้งที่รู้อยู่แล้วว่ากฎแบบนี้จะผิดบ้างในบางสถานการณ์ — เพราะทางเลือกอื่นแย่กว่า [1]

ปัญหาคือ เมื่อกฎสะสมมากขึ้นเรื่อยๆ กฎเหล่านั้นเริ่ม**ขัดแย้งกันเอง** — ทีมงานเคยเจอ transcript ที่ skill หนึ่งบอกว่า "อย่าเพิ่มเอกสาร" ในขณะที่ผู้ใช้กำลังถามเรื่องการเขียนเอกสารอยู่พอดี Claude ยังพอตีความเจตนาของผู้ใช้ได้ แต่ต้องเสีย reasoning ไปกับการประนีประนอมกฎที่ขัดกัน แทนที่จะโฟกัสกับปัญหาจริงของผู้ใช้ [2] นี่คือจุดเปลี่ยนที่ทำให้ Anthropic ตั้งคำถามใหม่: ถ้าโมเดลฉลาดพอจะตัดสินใจเองได้ กฎเก่าที่เขียนไว้สำหรับโมเดลอ่อนแอกว่าจะยังจำเป็นอยู่ไหม

## Deep Dive

### 1. ทำไมลบ System Prompt ทิ้ง 80% แล้วผลลัพธ์ไม่ตก

Thariq Shihipar (Member of Technical Staff, Anthropic) เขียนใน blog post อย่างเป็นทางการว่า **"We removed over 80% of Claude Code's system prompt for models like Claude Opus 5 and Claude Fable 5 with no measurable loss on our coding evaluations"** [1] — เผยแพร่วันเดียวกับที่ Claude Opus 5 เปิดตัว (24 ก.ค. 2026)

หลักคิดเบื้องหลังคือ **rules become judgment**: กฎที่เคยเขียนไว้แบบ "ห้ามทำ X", "ต้องทำ Y ก่อนเสมอ" ถูกแทนที่ด้วยการให้บริบทและเป้าหมายกับ Claude แล้วปล่อยให้โมเดลตัดสินใจเองว่าวิธีไหนเหมาะกับสถานการณ์นั้นๆ [1][2]

### 2. 3 การเปลี่ยนกระบวนทัศน์ของ Context Engineering ยุคใหม่

บทความของ Thariq สรุปการเปลี่ยนแปลงหลักไว้ 3 ข้อ [1]:

1. **Rules → Judgment** — จากกฎตายตัวที่ครอบคลุมทุกกรณี (และรู้อยู่แล้วว่าจะผิดในบางกรณี) เปลี่ยนเป็นให้ Claude ใช้ context และ reasoning ตัดสินใจเอง
2. **Examples → Interface Design** — แทนที่จะสาธิตวิธีใช้ tool ด้วยตัวอย่างจำนวนมาก ให้ออกแบบ tool parameter ให้สื่อความหมายชัดเจนในตัวเองแทน
3. **Upfront Context → Progressive Disclosure** — ย้ายข้อมูลรายละเอียด (เช่น วิธีทำ code review) จาก system prompt ที่โหลดทุกครั้ง ไปไว้ใน Skill ที่เรียกใช้เฉพาะเมื่อจำเป็น

### 3. Progressive Disclosure: สถาปัตยกรรม 3 ระดับของ Agent Skills

Anthropic อธิบายว่า Agent Skills คือ "organized folders of instructions, scripts, and resources that agents can discover and load dynamically" [3] ระบบนี้ทำงานผ่าน 3 ระดับ [3]:

| ระดับ | เนื้อหา | Token cost | โหลดเมื่อไหร่ |
|---|---|---|---|
| Level 1 | ชื่อ + description ของ skill | ~100 tokens/skill | ทุก session (system prompt) |
| Level 2 | เนื้อหาเต็มใน `SKILL.md` | สูงสุด ~5,000 tokens | เมื่อ Claude เห็นว่า skill เกี่ยวข้องกับงาน |
| Level 3 | ไฟล์อ้างอิงเพิ่มเติม (reference.md, forms.md) | ไม่จำกัด | เมื่อ Claude ต้องการรายละเอียดเฉพาะจุดจริงๆ |

หลักการนี้เหมือนโครงสร้างคู่มือที่ดี: สารบัญ → เนื้อหาบทต่างๆ → ภาคผนวก — Claude เข้าถึงข้อมูลทีละชั้นตามที่จำเป็นจริง ไม่ต้องโหลดทั้งหมดตั้งแต่ต้น [3] ผลคือ ระบบที่เชื่อมต่อเครื่องมือนับร้อยชิ้นสามารถลด token usage ได้ถึง **85%** — จากที่ต้องโหลด tool definition 25,000 tokens เหลือแค่ skill description 2,500 tokens ก่อนที่ Claude จะดึงคำสั่งเต็มมาเมื่อ request ของผู้ใช้ตรงกับ skill นั้นจริงๆ [4]

Claude Code เองก็ยืนยันหลักการเดียวกันในเอกสารทางการ: **"Unlike CLAUDE.md content, a skill's body loads only when it's used, so long reference material costs almost nothing until you need it"** [5]

### 4. Lazy Loading ในทางปฏิบัติ: Deferred Tools + ToolSearch

นอกจาก Skill แล้ว หลักการเดียวกันยังถูกใช้กับ **tool definitions** — บทความของ Thariq ระบุว่า "deferred loading" tools ต้องผ่าน **ToolSearch** ก่อนที่ definition เต็มจะถูกโหลดเข้า context [1] แทนที่จะยัด tool definition ทั้งหมดไว้ล่วงหน้า ระบบจะโหลดแค่ชื่อ tool พร้อมคำอธิบายสั้นๆ แล้วให้ Claude ค้นหา (search) definition เต็มเฉพาะ tool ที่ต้องใช้จริงเท่านั้น — ป้องกัน token bloat จากการมี tool จำนวนมากที่ไม่ได้ใช้ในงานนั้นๆ

### 5. คำสั่ง /doctor: หมอตรวจสุขภาพ Context ของ Claude Code

`/doctor` (มี `/checkup` เป็น alias) กลายเป็นเครื่องมือตรวจสุขภาพ setup แบบเต็มรูปแบบตั้งแต่ **Claude Code v2.1.205** (เผยแพร่ 8 ก.ค. 2026) เอกสารทางการระบุว่าคำสั่งนี้ **"diagnoses issues and can fix them, instead of printing a read-only report"** [6] โดยตรวจสอบ:

- **Installation health** — ตรวจว่า install สมบูรณ์ ไม่มีอะไรพัง
- **Dead weight** — หา skill, MCP server, และ plugin ที่ติดตั้งไว้แต่**ไม่เคยถูกใช้จริง** เทียบกับ context cost ที่มันกินไป โดยดูจาก usage counter และ session transcript ของผู้ใช้เอง [6][7]
- **CLAUDE.md deduplication** — เทียบ CLAUDE.md ส่วนตัวกับไฟล์ที่ checked-in ไว้ในโปรเจกต์ เพื่อหาความซ้ำซ้อน
- **CLAUDE.md trimming** — เสนอตัดเนื้อหาที่ Claude สามารถอนุมานเองได้จาก codebase อยู่แล้ว (เช่น โครงสร้าง directory, tech stack)
- **Slow hooks** — ตรวจจับ hook ที่ทำให้ทุก tool call ช้าลง

คำสั่งนี้ **รายงานผลก่อนแล้วค่อยขอ confirmation** ก่อนเปลี่ยนแปลงอะไรจริง — ไม่แก้ไฟล์หรือ setting ใดๆ โดยอัตโนมัติ [6] ตัวอย่างจริงจาก session หนึ่ง: ผู้ใช้มี personal skill ติดตั้งไว้ 113 ตัว ซึ่งกินโควตา context ไปประมาณ 10,000 tokens ทุกเซสชันแค่เพื่อ "ลิสต์ชื่อ" skill เหล่านั้น และใน 113 ตัวนั้นมีถึง 25 ตัวที่**ไม่เคยถูกเรียกใช้เลย** [7]

## User Guide (Step-by-Step)

1. **รันคำสั่งตรวจสุขภาพ** — พิมพ์ `/doctor` (หรือ `/checkup`) ในเซสชัน Claude Code ใดก็ได้ → ได้รายงาน read-only แสดง skill/MCP ที่ไม่เคยใช้ พร้อม token cost โดยประมาณ
2. **ตรวจสอบข้อเสนอ** — `/doctor` จะแสดงตัวเลือก: ล้างข้อมูลอัตโนมัติ, เลือกเฉพาะบางหมวด, ไม่แก้อะไรเลย, หรือคุยเพิ่มเติมก่อนตัดสินใจ — การแก้ไข CLAUDE.md จะลงเป็น diff ในไฟล์ให้ review ก่อน commit เสมอ ไม่มีอะไรเปลี่ยนแบบเงียบๆ
3. **ปรับ CLAUDE.md ให้เป็น index ระดับสูง** — ย้าย procedure ยาวๆ ที่โหลดทุกเซสชันไปเป็น skill แยกต่างหาก (โหลดเฉพาะเมื่อใช้จริง) แทนการยัดทุกอย่างไว้ในไฟล์เดียว
4. **เขียน skill ใหม่ด้วย progressive disclosure** — เก็บ `SKILL.md` ให้กระชับ ระบุ metadata (name + description) ให้ชัดเจนที่สุด แล้วแยกรายละเอียดเชิงลึกไปไว้ในไฟล์อ้างอิงเสริม
5. **ตรวจสอบ auto mode** — `/doctor` จะเตือนถ้า auto mode ยังไม่เป็นค่า default บนเครื่อง

## Caveats / Limits

- **Detection เป็น heuristic ไม่ใช่ certainty** — skill ที่ใช้แค่ไตรมาสละครั้งอาจถูกเข้าใจผิดว่า "ไม่เคยใช้" ถ้าวัดผลแค่ในช่วงสัปดาห์เดียว
- **80% reduction ใช้เฉพาะกับ Claude Opus 5 และ Claude Fable 5** — โมเดลรุ่นเก่ากว่ายังต้องพึ่งกฎแบบเดิมในระดับหนึ่ง อย่ารีบลบ system prompt ทิ้งถ้ายังใช้โมเดลรุ่นก่อนหน้า
- **Progressive disclosure ต้องพึ่ง metadata ที่ดี** — ถ้า name/description ของ skill ไม่ชัดเจนพอ Claude อาจไม่เรียกใช้ skill ที่ถูกต้องตอนจำเป็น
- **CLAUDE.md edits ต้อง review เอง** — `/doctor` เสนอการแก้ไขแต่ไม่ commit ให้อัตโนมัติ ผู้ใช้ต้องตรวจ diff ก่อนเสมอ
- ดูเพิ่มเติมเรื่อง unhobbling และการลบ system prompt ของ Claude Opus 5 แบบเจาะลึกได้ที่ [โพสต์ก่อนหน้า]({{ site.baseurl }}/engineering/2026/07/27/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling.html)

## References

1. [The new rules of context engineering for Claude 5 generation models](https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models) — Thariq Shihipar, Claude by Anthropic, 24 ก.ค. 2026
2. [Anthropic Engineers Just Fixed Claude Code and Nobody's Talking About it!](https://youtu.be/UBFHTHUs1wA) — YouTube commentary/analysis video
3. [Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) — Anthropic Engineering
4. [Agent Skills: Solving the MCP Context Explosion Problem](https://docs.bswen.com/blog/2026-03-25-agent-skills/) — BSWEN
5. [Extend Claude with skills](https://code.claude.com/docs/en/skills) — Claude Code Docs
6. [Week 28 · July 6–10, 2026](https://code.claude.com/docs/en/whats-new/2026-w28) — Claude Code Docs, official changelog digest
7. [Claude Code /checkup Explained (2026)](https://mcp.directory/blog/claude-code-checkup-command-2026) — MCP.Directory

## Key Takeaways

- Anthropic ลบ system prompt ของ Claude Code ทิ้งกว่า 80% สำหรับ Opus 5 และ Fable 5 โดยไม่มี performance loss ที่วัดได้ (24 ก.ค. 2026)
- Context engineering ยุคใหม่เปลี่ยน 3 เรื่องหลัก: rules → judgment, examples → interface design, upfront context → progressive disclosure
- Agent Skills ใช้สถาปัตยกรรม 3 ระดับ (metadata ~100 tokens → SKILL.md ~5,000 tokens → linked resources ไม่จำกัด) ลด token usage ได้ถึง 85%
- Deferred-loading tools ต้องผ่าน ToolSearch ก่อนโหลด definition เต็ม — ป้องกัน token bloat จาก tool ที่ไม่ได้ใช้
- คำสั่ง `/doctor` (v2.1.205, `/checkup` เป็น alias) ตรวจจับ skill/MCP/plugin ที่ไม่เคยใช้แต่กิน context ทุกเซสชัน พร้อมรายงานก่อนแก้ไขจริง
- ตัวอย่างจริง: 113 personal skills กิน ~10,000 tokens ทุกเซสชัน โดย 25 ตัวไม่เคยถูกใช้เลย — `/doctor` ช่วยหาและตัดทิ้งได้
- Detection ของ `/doctor` เป็น heuristic — ตรวจสอบก่อนลบเสมอ อย่าเชื่อรายงานแบบไม่ review
