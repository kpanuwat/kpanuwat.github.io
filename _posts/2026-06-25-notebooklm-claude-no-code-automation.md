---
title: "เจาะลึก: NotebookLM + Claude สร้าง No-code Automation Pipeline"
date: 2026-06-24 00:01:00 +0700
categories: [Tools]
tags: [notebooklm, claude, automation, no-code, productivity, ai-workflow]
slides: true
---

{% include slide-link.html %}

## TL;DR

NotebookLM (memory layer) + Claude (execution layer) = no-code pipeline ที่ลดอาการ AI hallucination และเพิ่มความแม่นยำของ output ได้อย่างมีนัยสำคัญ มี 3 เวิร์กโฟลว์หลัก: **Content Machine**, **Pro Infographic Engine**, และ **Automated Daily Briefing** — ทั้งหมดทำได้โดยไม่ต้องเขียนโค้ดแม้แต่บรรทัดเดียว

## Background / Why this matters

ปัญหาที่ผู้ใช้ AI ส่วนใหญ่เจอคือ AI "หลอน" (hallucinate) — สร้างข้อมูลที่ฟังดูน่าเชื่อถือแต่ผิด โดยเฉพาะในงานที่ต้องการความแม่นยำสูงอย่างรายงานวิชาการ, สคริปต์ยูทูบ, หรือสรุปข่าวรายวัน

NotebookLM แก้ปัญหานี้ด้วยการ **ground** output ให้ยึดกับแหล่งข้อมูลที่ผู้ใช้คัดเลือกมาเอง (curated sources) ทำให้ทุก claim มี citation ชัดเจน ขณะที่ Claude ทำหน้าที่ reasoning และ execution — แปลง structured knowledge จาก NotebookLM ให้กลายเป็น deliverable จริง เช่น script, สไลด์, หรือ Slack message อัตโนมัติ

การ update ล่าสุดของ NotebookLM นำ **Gemini 3.5 Flash** มาใช้ (เร็วขึ้นอย่างเห็นได้ชัด) พร้อม Studio Panel ที่รองรับ output 9 รูปแบบรวมถึง Cinematic Video (powered by Veo 3) ทำให้ ecosystem นี้แข็งแกร่งกว่าเดิมมาก

## Deep Dive

### NotebookLM vs Claude: แบ่งงานกันอย่างไร

| บทบาท | NotebookLM | Claude |
|--------|-----------|--------|
| **หน้าที่** | Memory / Knowledge Layer | Execution / Reasoning Layer |
| **จุดแข็ง** | จัดเก็บ, organize, ground ข้อมูล | ทำงานซ้ำอัตโนมัติ, reasoning ซับซ้อน |
| **Input** | PDF, YouTube, บทความ, โน้ตส่วนตัว | Structured prompt + context จาก NotebookLM |
| **Output** | Grounded summary + citations | Script, slides, design brief, Slack message |

กุญแจของ synergy นี้คือ NotebookLM **ป้องกัน hallucination** เพราะ Claude ต้องอ้างอิงกลับไปที่ sources เสมอ แทนที่จะ "คิดขึ้นมาเอง"

### อะไรใหม่ใน NotebookLM 2026

- **Gemini 3.5 Flash**: ประมวลผลเร็วขึ้นมาก; source ขนาดใหญ่ไม่ทำให้ช้า
- **Studio Panel (9 output modes)**: Audio Overview, Podcast, Slide Deck, Infographic (10 preset styles + custom), Mind Map, Data Table, Flashcard, Quiz, Cinematic Video (Veo 3)
- **Cinematic Video Summary**: แปลง source เป็นวิดีโอสั้น narration + visual ใน style ภาพยนตร์
- **SciSpace integration**: ดึง academic papers เป็น source ได้โดยตรง

### Workflow 1: Content Machine

**เป้าหมาย**: 1 topic + 5 sources → YouTube script + podcast + slides ภายใน 20 นาที

**ขั้นตอน**:
1. เปิด NotebookLM → สร้าง notebook ใหม่
2. เพิ่ม 5 sources (PDF, YouTube URL, บทความ, โน้ตส่วนตัว) — ต้องเป็น sources ที่ **คุณคัดกรองมาแล้ว** ไม่ใช่สุ่มเพิ่ม
3. ใช้ Chat ถาม: `"Summarize the key subtopics with numbered citations"` → ได้ grounded outline
4. ส่ง outline นั้นให้ Claude ด้วย prompt:
   ```
   Based on this outline with citations, write a 1,500-word YouTube script
   in a conversational tone. Keep all citation references [1], [2], etc.
   ```
5. กลับไป NotebookLM → Studio → Generate Slide Deck + Audio Overview จาก sources เดิม

**ผลลัพธ์**: Script มี citation, สไลด์ align กับ script, podcast ใช้ sources เดิม — ทุกชิ้น grounded ในข้อมูลเดียวกัน

### Workflow 2: Pro Infographic Engine (Design Workflow)

**เป้าหมาย**: ใช้ Claude บรีฟสไตล์ภาพ → ได้ infographic คุณภาพสูงในไม่กี่วินาที

**ขั้นตอน**:
1. ใส่ PDF หรือรายงานใน NotebookLM
2. ถาม Claude ให้สร้าง **design brief** ก่อน:
   ```
   Based on this content, write a detailed image generation prompt for an infographic.
   Include: color palette, layout structure, key data points to visualize,
   typography style, and visual metaphors.
   ```
3. นำ prompt ที่ได้ → ใส่ใน NotebookLM Studio → Infographic (เลือก preset หรือ custom style)
4. หรือนำ prompt ไปใช้กับ image generator อื่น (Nano Banana / Midjourney / Ideogram)

**ทำไม Claude ต้อง brief ก่อน**: Claude วิเคราะห์ content เพื่อเลือก visual metaphor ที่เหมาะสม แทนที่ผู้ใช้จะต้องนึก layout เอง — ลด iteration loop จาก 5-6 ครั้งเหลือ 1-2 ครั้ง

### Workflow 3: Automated Daily Briefing (Slack + Chrome Extension)

**เป้าหมาย**: สรุปข่าว/อัปเดตที่เกี่ยวข้องส่งลง Slack ทุกเช้าโดยอัตโนมัติ

**Components**:
- **NotebookLM**: เก็บ ongoing sources (RSS, Slack threads, newsletters)
- **Claude Chrome Extension**: ควบคุม browser อัตโนมัติ — trigger NotebookLM, copy output
- **Kortex Chrome Extension** (optional): automation rules เช่น "เมื่อมี source ใหม่ → generate summary อัตโนมัติ"
- **Slack Webhook**: รับ text จาก Claude → ส่งเข้า channel ที่กำหนด

**Setup แบบย่อ**:
1. ติดตั้ง Claude Chrome Extension
2. กำหนด automation rule: ทุก 8:00 น. → เปิด NotebookLM → generate Audio Overview → copy transcript
3. Claude ส่ง transcript ไปที่ Slack webhook URL ของ channel

**ข้อควรระวัง**: Feature นี้ต้อง browser เปิดค้างไว้ (Chrome Extension ไม่ใช่ server-side) — ยังไม่เหมาะสำหรับ production ที่ต้องการ 24/7 uptime

## User Guide (Step-by-Step)

### เริ่มต้นกับ Workflow 1 ใน 10 นาที

**1. สร้าง NotebookLM notebook**
- ไปที่ [notebooklm.google.com](https://notebooklm.google.com)
- คลิก **New Notebook** → ตั้งชื่อตาม project

**2. เพิ่ม sources (สำคัญมาก: คุณภาพ source = คุณภาพ output)**
- รองรับ: PDF, Google Doc, YouTube URL, Website, Paste text
- แนะนำ: 3-7 sources; เกินไปอาจทำให้ focus เจือจาง

**3. ทดสอบด้วย Chat**
```
Summarize the 5 most important points in this content
and cite which source each point comes from.
```
- ถ้า answer มี `[Source 1]`, `[Source 2]` → grounding ทำงานถูกต้อง

**4. Generate via Studio**
- คลิกแท็บ **Studio** (ด้านขวา) → เลือก output type → คลิก **Generate**
- Infographic: เลือก preset style หรือ custom prompt

**5. ส่งต่อให้ Claude**
- Copy grounded summary จาก NotebookLM
- เปิด [claude.ai](https://claude.ai) → paste + เพิ่ม instruction
- ตัวอย่าง: `"Turn this into a 5-slide presentation outline with speaker notes"`

### ติดตั้ง Claude Chrome Extension
1. ค้นหา "Claude for Chrome" ใน Chrome Web Store
2. Pin extension → คลิก icon → login ด้วย Anthropic account
3. บน webpage ใดก็ได้ → คลิก icon → เลือก text → ถาม Claude ได้เลย

## Caveats / Limits

- **Curation is everything**: output ดีแค่ไหนขึ้นกับ sources ที่เลือก — garbage in, garbage out; NotebookLM ไม่ filter ให้
- **ไม่เหมาะกับ public-facing content โดยตรง**: ต้องมี human review เสมอ โดยเฉพาะ factual claims
- **API limitations**: Chrome Extension ใช้ Claude Pro account; ถ้าใช้งานหนักอาจเจอ rate limit
- **Browser dependency**: Automation workflow ต้องการ browser เปิดอยู่ตลอด — ไม่ใช่ background service จริง
- **Source freshness**: NotebookLM ไม่ auto-update sources — ต้อง re-add URL หรือ refresh เอง
- **Cinematic Video**: ยังอยู่ใน limited rollout; ไม่ใช่ทุก account ที่เข้าถึงได้

## References

1. [NotebookLM Combined with Claude Creates the Ultimate AI Productivity Pipeline — Geeky Gadgets](https://www.geeky-gadgets.com/claude-notebooklm-automation-workflow/)
2. [How to Integrate Claude With NotebookLM for Automated Workflows — Geeky Gadgets](https://www.geeky-gadgets.com/claude-notebooklm-integration-workflow/)
3. [I paired NotebookLM with Slack to streamline my workflow — XDA Developers](https://www.xda-developers.com/paired-notebooklm-with-slack/)
4. [Kortex NotebookLM Chrome Extension: New Dashboard & Automation Rules — Geeky Gadgets](https://www.geeky-gadgets.com/cortex-notebooklm-extension-update/)
5. [3 Chrome extensions that help NotebookLM play nice with other tools — XDA Developers](https://www.xda-developers.com/notebooklm-chrome-extensions-for-better-integration/)
6. [NotebookLM Released A New Workflow For Infographics, Podcasts and Slide Decks — YouTube](https://www.youtube.com/watch?v=vq0FLMyK2QA)
7. [Claude + NotebookLM: Ultimate AI Automation Workflow — My Living AI](https://www.mylivingai.com/claude-notebooklm-ultimate-ai-automation-workflow-to-work-10x-faster/)
8. [AI Master — NotebookLM + Claude No-code Automation Pipeline](https://youtu.be/8tOfGkddPNM)

## Key Takeaways

- NotebookLM = memory layer (organizes + grounds); Claude = execution layer (reasons + automates) — แบ่งบทบาทชัดเจน ไม่ซ้อนทับ
- Grounded output = hallucination ลดลงอย่างมีนัยสำคัญ เพราะทุก claim อ้างอิง source จริง
- Content Machine workflow: 5 sources → script + slides + podcast ใน 20 นาที โดยไม่ต้องเขียนโค้ด
- Design brief จาก Claude ก่อน → infographic quality สูงขึ้น iteration ลดลง
- Automation workflow ทำได้ผ่าน Chrome Extension + Slack webhook — ยังต้อง browser เปิดค้างไว้
- **คุณภาพ output = คุณภาพ curation ของผู้ใช้** — AI จัดการ execution แต่ judgment ในการเลือก sources ยังต้องเป็นมนุษย์
- NotebookLM 2026 รองรับ 9 output formats รวม Cinematic Video (Veo 3) และ Infographic 10 presets
