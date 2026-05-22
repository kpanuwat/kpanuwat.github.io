---
title: "NotebookLM: สำรวจหัวข้อวิจัยด้วย AI ก่อนบันทึกลง Obsidian"
date: 2026-05-22 04:06:32 +0700
categories: [Tools]
tags: [notebooklm, research, obsidian, knowledge-management, ai]
---

## TL;DR

NotebookLM เป็น AI research tool จาก Google ที่ดีที่สุดสำหรับ **ขั้นสำรวจหัวข้อใหม่** — โยนแหล่งข้อมูลเข้าไป ถามได้ทันที มี citation พร้อม ส่วน Obsidian คือที่เก็บ insight ที่สรุปแล้วอย่างถาวร ทั้งสองใช้ร่วมกันได้ดีกว่าเลือกอันใดอันหนึ่ง

## Background / Why this matters

งานวิจัยหรือการเรียนรู้หัวข้อใหม่มักมีสองช่วงที่ต่างกันมาก:

**ช่วงแรก — สำรวจ (Exploration):** ยังไม่รู้ว่าอะไรสำคัญ ต้องการถาม ทดสอบสมมติฐาน และเชื่อมโยงแหล่งข้อมูลหลายชิ้นพร้อมกัน ช่วงนี้ต้องการเครื่องมือที่ยืดหยุ่นและตอบเร็ว

**ช่วงที่สอง — บันทึก (Consolidation):** เข้าใจภาพรวมแล้ว ต้องการเก็บ insight ที่ผ่านการกลั่นกรองไว้ใช้ในอนาคต เชื่อมโยงกับสิ่งที่รู้ไปก่อน และสร้างเครือข่ายความรู้ที่ขยายได้เรื่อยๆ

ปัญหาคือหลายคนพยายามใช้เครื่องมือเดียวทำทั้งสองช่วง — ใช้ Obsidian ตั้งแต่แรกก็จะเสียเวลาจัดระเบียบโน้ตก่อนที่จะเข้าใจหัวข้อ หรือใช้ NotebookLM ตลอดก็เสียข้อมูลเมื่อลบ notebook ทิ้ง

## Deep Dive

### NotebookLM คืออะไร

NotebookLM เป็น AI research assistant ที่พัฒนาโดย Google Labs ขับเคลื่อนด้วย Gemini ความต่างจาก ChatGPT หรือ Claude ทั่วไปคือ **NotebookLM ตอบจากแหล่งข้อมูลที่คุณเพิ่มเข้าไปเท่านั้น** ไม่มีการ hallucinate ข้อมูลจากภายนอก

### รูปแบบแหล่งข้อมูลที่รองรับ

| ประเภท | ตัวอย่าง |
|--------|---------|
| ไฟล์อัปโหลด | PDF, TXT, audio files |
| Google Workspace | Google Docs, Google Slides |
| เว็บ | URLs, YouTube videos |

แต่ละ notebook รองรับ **สูงสุด 50 sources** แต่ละ source จุได้ถึง **500,000 คำหรือ 200 MB** [1]

### Context window ขนาด 1 ล้าน token

NotebookLM ใช้ context window ของ Gemini เต็ม **1 ล้าน token** — ซึ่งแตกต่างจากระบบ RAG (Retrieval-Augmented Generation) แบบทั่วไป ระบบ RAG จะตัดเอาเฉพาะ chunk ที่เกี่ยวข้องมาตอบ แต่ NotebookLM โหลดแหล่งข้อมูลทั้งหมดพร้อมกัน ทำให้ citation เป็นข้อความจริงจากเอกสาร ไม่ใช่การประมาณ [2]

### Citations แม่นยำ

ทุกคำตอบมี citation เป็น **original quotes** จาก source ที่คุณเพิ่มไว้ สามารถคลิกดูบริบทต้นฉบับได้ทันที ช่วยลด hallucination ได้มาก [1]

### Custom Persona (AI Personality)

สามารถกำหนดบุคลิก AI ได้ เช่น "ตอบแบบผู้เชี่ยวชาญด้าน UX ที่เน้น business impact" หรือ "อธิบายให้นักเรียนมัธยมเข้าใจ" ปรับให้เหมาะกับบริบทของแต่ละ notebook ได้ [3]

### Audio Overview

สร้าง podcast-style summary จากแหล่งข้อมูลทั้งหมดได้ในคลิกเดียว เหมาะสำหรับฟังระหว่างเดินทางหรือทบทวนภาพรวมก่อนเข้าประชุม [4]

### NotebookLM vs Obsidian — เปรียบเทียบ

| มิติ | NotebookLM | Obsidian |
|-----|-----------|---------|
| เหมาะกับ | สำรวจหัวข้อใหม่, bounded research | เก็บความรู้ระยะยาว, personal wiki |
| ข้อมูล | อยู่บน Google Cloud | อยู่ใน local files (เป็นเจ้าของเอง) |
| Citation | อัตโนมัติ, exact quote | ต้องเพิ่มเอง |
| Linking | ภายใน notebook | bidirectional, graph view |
| ขยาย | จำกัด 50 sources/notebook | ไม่จำกัด |
| ราคา | ฟรี (มี Plus) | ฟรี (มี Commercial license) |

### Workflow ที่ใช้ร่วมกัน

```
[แหล่งข้อมูล] → NotebookLM Notebook
                     ↓ สำรวจ, ถาม, Audio Overview
              [Insight ที่กลั่นแล้ว]
                     ↓ copy สิ่งที่ดีที่สุด
              Obsidian Note (ถาวร)
                     ↓ link กับความรู้เดิม
              [Knowledge Graph]
```

ขั้นตอนสำคัญคือ **ไม่ copy ทุกอย่าง** — เลือกเฉพาะ insight ที่ผ่านการทดสอบด้วยคำถามจาก NotebookLM แล้วว่าสำคัญจริง

## User Guide (Step-by-Step)

### ขั้น 1: สร้าง Notebook ใหม่

1. ไปที่ [notebooklm.google.com](https://notebooklm.google.com)
2. คลิก **New Notebook** — ตั้งชื่อตามหัวข้อวิจัย เช่น `"LLM Context Windows Research"`
3. หนึ่ง notebook = หนึ่งหัวข้อ อย่าใส่ทุกอย่างรวมกัน

### ขั้น 2: เพิ่ม Sources

1. คลิก **Add source** ใน sidebar ซ้าย
2. เลือกประเภท: อัปโหลด PDF / วาง URL / เชื่อม Google Doc / วาง YouTube URL
3. NotebookLM จะ index อัตโนมัติ ไม่ต้องรอนาน
4. เพิ่มได้สูงสุด 50 sources ต่อ notebook

### ขั้น 3: ตั้ง Custom Persona (optional)

1. คลิกไอคอน ⚙️ ที่มุมบน
2. ไปที่ **Notebook settings → Customize AI responses**
3. ใส่ persona เช่น: `"You are a senior researcher in machine learning. Answer with technical precision and always highlight practical limitations."`

### ขั้น 4: สำรวจด้วยคำถาม

เริ่มด้วยคำถาม high-level ก่อน แล้วค่อย drill down:

```
❶ "สรุป key themes จากเอกสารทั้งหมด"
❷ "อะไรคือความขัดแย้ง (contradictions) ระหว่าง source ต่างๆ?"
❸ "คำถามที่เอกสารเหล่านี้ยังไม่ตอบคืออะไร?"
❹ "ให้ตัวอย่าง concrete จาก source X เกี่ยวกับ Y"
```

ทุกคำตอบมี citation — คลิกดู original text ได้เลย

### ขั้น 5: สร้าง Audio Overview

1. คลิก **Notebook guide** → **Audio Overview**
2. กด **Generate** — รอ 1-2 นาที
3. ฟังเพื่อทบทวนภาพรวมก่อนขั้นต่อไป

### ขั้น 6: โอนย้ายไป Obsidian

เมื่อเข้าใจหัวข้อแล้ว คัด insight ที่ผ่านการยืนยัน:

1. **เลือกเฉพาะที่ actionable** — ข้อเท็จจริงที่จะใช้งาน, framework ที่จะนำไปปรับ, คำถามที่เปิดหัวข้อใหม่
2. เขียนใน Obsidian ด้วยคำของตัวเอง (ไม่ copy-paste) — การถอดความบังคับให้เข้าใจจริง
3. ใส่ link กลับไปยัง source ต้นฉบับในส่วน References
4. เชื่อม note ใหม่กับ note เดิมที่เกี่ยวข้องใน Obsidian

## Caveats / Limits

- **ข้อมูลอยู่บน Google Cloud** — ไม่ควรใส่ข้อมูลลับหรือ proprietary ใน notebook
- **50 sources/notebook** — สำหรับโปรเจกต์ใหญ่ต้องแยกเป็นหลาย notebook
- **ไม่มี offline mode** — ต้องการ internet ตลอด
- **Notebook ไม่ถาวร** — ถ้าลบ notebook ข้อมูลหายหมด นี่คือเหตุผลที่ต้องโอนย้ายไป Obsidian
- **Audio Overview ภาษาไทย** — ยังไม่รองรับเต็มที่, ผลลัพธ์อาจเป็นภาษาอังกฤษ
- **NotebookLM Plus** — plan premium สำหรับ Google One AI Premium subscribers มี Audio Overview มากกว่า 5 เท่าและ notebooks มากกว่า [4]

## References

1. [Add or discover new sources - NotebookLM Help](https://support.google.com/notebooklm/answer/16215270?hl=en)
2. [Chat in NotebookLM: A powerful, goal-focused AI research partner](https://blog.google/technology/google-labs/notebooklm-custom-personas-engine-upgrade/)
3. [Frequently asked questions - NotebookLM Help](https://support.google.com/notebooklm/answer/16269187?hl=en)
4. [NotebookLM announces NotebookLM Plus and other new features](https://blog.google/innovation-and-ai/models-and-research/google-labs/notebooklm-new-features-december-2024/)
5. [Obsidian is the perfect app to pair with NotebookLM - XDA Developers](https://www.xda-developers.com/obsidian-perfect-app-to-pair-with-notebooklm/)
6. [Video: How to use NotebookLM effectively](https://youtu.be/Lt0Zuyy2Ecw)

## Key Takeaways

- NotebookLM ไม่ใช่ note-taking app — มันเป็น **AI research assistant** ที่ตอบจากแหล่งข้อมูลของคุณเท่านั้น
- Context window 1 ล้าน token + citation แม่นยำ = ลด hallucination ได้มากกว่า AI ทั่วไป
- หนึ่ง notebook ควรมีหนึ่งหัวข้อ — อย่า mix หลาย project ในที่เดียว
- Custom Persona ช่วยกรองคำตอบให้เหมาะกับบริบทของคุณ ใช้ทุกครั้ง
- NotebookLM = สำรวจ, Obsidian = บันทึกถาวร — ใช้ **ตามลำดับ** ไม่ใช่แทนกัน
- โอนย้ายด้วยการถอดความ ไม่ใช่ copy-paste — บังคับให้สร้างความเข้าใจจริง
- ข้อมูลอยู่บน Cloud ห้ามใส่ข้อมูลที่เป็นความลับ
