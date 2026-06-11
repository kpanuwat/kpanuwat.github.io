---
title: "เปลี่ยน Claude เป็นผู้ช่วยสอนด้วยภาพ ด้วยเทคนิค Brainstorm First"
date: 2026-06-10 00:03:00 +0700
categories: [Tools]
tags: [claude, prompt-engineering, visual-learning, artifacts, ai]
---

## TL;DR

ใช้ prompt สูตร "ให้ 5 ตัวเลือกก่อน" เพื่อบังคับให้ Claude คิดหาวิธีแสดงผลที่ดีที่สุดก่อนสร้างจริง จากนั้นเปลี่ยนภาพโต้ตอบในแชทให้เป็น Artifact — web app ที่มี URL แชร์ได้ ไม่ต้องมีบัญชี Claude ก็ใช้งานได้

## Background / Why this matters

ปัญหาคลาสสิกของการถาม AI: ได้คำตอบเป็น "กำแพงข้อความ" ที่ยาวและอ่านยาก แม้จะขอภาพประกอบ AI มักสร้างทันทีโดยไม่คิดว่า _รูปแบบไหน_ เหมาะกับหัวข้อนั้นที่สุด

วิดีโอ "Endless Claude Visuals in 5 Minutes" แนะนำว่าปัญหานี้แก้ได้ด้วยการ **แยกขั้นตอนคิดออกจากขั้นตอนสร้าง** — เทคนิคที่ผู้สร้างเรียกว่า Brainstorm First

โดยค่าเริ่มต้น Claude ไม่สร้างภาพเพราะการสร้าง interactive visual ใช้ token มากกว่าการตอบเป็นข้อความ แต่ถ้าเราขอมันจะทำ และผลลัพธ์ที่ได้ต่างกันมากระหว่าง "ขอภาพเดียวทันที" กับ "ขอให้คิดก่อน 5 แบบ แล้วเลือก"

## Deep Dive

### เทคนิค Brainstorm First: แยกการคิดออกจากการผลิต

หลักการง่ายมาก: **อย่าให้ AI สร้างเลยทันที — ให้มันคิดก่อน**

ปกติเราถาม → AI ตอบทันที → หวังว่าจะดี  
Brainstorm First: ถาม → AI เสนอ 5 ตัวเลือก → เราเลือก → AI สร้างตัวที่เลือก

การแยกขั้นตอนนี้ทำให้ AI "สำรวจ solution space" ก่อนตัดสินใจ แทนที่จะ anchor กับตัวเลือกแรกที่นึกได้ เหมือนกับหลักการของ Tree-of-Thought prompting แต่ทำโดยผู้ใช้ควบคุมเอง

สิ่งที่น่าสังเกต: Claude มักใส่ตัวเลือกที่คิดว่าดีที่สุดไว้ด้านล่างของ list เราสามารถเลือกตัวนั้น หรือจะขอให้รวม 2-3 ตัวเลือกเข้าด้วยกันก็ได้

### Prompt สูตรสำเร็จ

```
I want to understand [หัวข้อที่ต้องการเรียนรู้]. 
Figure out what visuals would be most useful for me to understand this deeply. 
Give me five options.
```

Claude จะไม่สร้างอะไรทันที แต่จะเสนอ 5 แนวคิดการแสดงผล เช่น:
- Interactive timeline
- Comparison table with visual indicators  
- Flow diagram with hover details
- Animated step-by-step breakdown
- Data visualization with sliders

จากนั้นตอบ เช่น `"ทำตัวที่ 3 ครับ"` หรือ `"รวม 2 กับ 4 เลย"` — Claude จะสร้างภาพโต้ตอบออกมา

เทคนิคนี้ apply ได้กับงานอื่นด้วย ไม่ใช่แค่ visual เช่น "ให้ 5 วิธีในการอธิบาย X" หรือ "ให้ 5 โครงสร้างสำหรับบทความนี้"

### Interactive Visuals: ภาพโต้ตอบในแชท

ตั้งแต่มีนาคม 2026 Claude สามารถสร้าง **interactive visuals** ที่แสดงผลแบบ inline ในแชทได้ ภาพเหล่านี้สร้างด้วย HTML จึงโต้ตอบได้จริง ไม่ใช่รูปภาพนิ่ง

ลักษณะสำคัญของ interactive visuals:
- แสดงผลระหว่างย่อหน้าในการตอบ (ไม่เปิด panel แยก)
- Claude ตัดสินใจเองว่าเมื่อไหรควรใช้ภาพ หรือเราสั่งได้ตรงๆ
- เป็น "whiteboard sketch" ชั่วคราว — ถ้าต้องการถาวรต้องแปลงเป็น Artifact
- ไม่แสดงบน iOS/Android, shared chat ต้องล็อกอินถึงจะเห็น

สั่งได้หลายรูปแบบ:
- "วาดเป็น diagram ให้หน่อย"
- "chart ข้อมูลนี้"
- "แสดงเป็น flowchart"

### Artifacts: อัพเกรดจากภาพเป็น Web App

Artifact คือขั้นตอนถัดไปจาก interactive visual — เปลี่ยนจาก "sketch ชั่วคราว" เป็น "standalone app ถาวร"

**เปิดใช้งาน Artifacts:**
1. คลิก initials มุมล่างซ้าย
2. Settings → Capabilities
3. Toggle "Artifacts" เปิด

**แปลง visual เป็น Artifact:**
```
make the visual an artifact
```

Claude จะเขียน code และ render ใน side panel แยก จากนั้นสามารถ:
- เพิ่ม interactive elements เช่น ปุ่ม, sliders, dropdowns
- ขอให้ refine หรือเพิ่มข้อมูล
- คลิก **Publish** เพื่อได้ URL สาธารณะ

**ความสามารถของ Published Artifact:**
- มี URL เฉพาะ ใช้งานบน internet ได้
- **ไม่ต้องมีบัญชี Claude** ก็เปิดดูและโต้ตอบได้
- ผู้รับสามารถ remix เป็น version ของตัวเองได้
- สามารถ embed บนเว็บไซต์ได้

### ความแตกต่างระหว่าง Interactive Visual กับ Artifact

| Feature | Interactive Visual | Artifact |
|---|---|---|
| ที่แสดงผล | Inline ในแชท | Side panel แยก |
| ความถาวร | ชั่วคราว | ถาวร |
| แชร์ได้ | ต้องล็อกอินดู | มี URL สาธารณะ |
| ต้องบัญชี Claude | ใช่ | ไม่ต้อง (ดูอย่างเดียว) |
| เหมาะกับ | คิดสำรวจในแชท | แชร์ให้คนอื่น |

### Claude Opus สำหรับ Visualization

Anthropic ระบุว่า **Claude Opus** ทำงาน visualization ได้ดีที่สุดในบรรดาโมเดลของ Anthropic ถ้าต้องการ visual คุณภาพสูง ลองเปลี่ยนโมเดลเป็น Opus ใน dropdown ก่อนส่ง prompt

## User Guide (Step-by-Step)

### Step 1: เตรียม Prompt และตั้งค่า

1. เปิด [claude.ai](https://claude.ai) (บัญชีฟรีใช้ได้)
2. (Optional) เปิด Settings → Capabilities → toggle Artifacts ON
3. เตรียมหัวข้อที่ต้องการเรียนรู้

### Step 2: ขอ 5 ตัวเลือก

วาง prompt นี้ โดยแทนที่ `[หัวข้อ]`:

```
I want to understand [หัวข้อ]. 
Figure out what visuals would be most useful for me to understand this deeply. 
Give me five options.
```

Claude จะตอบด้วย 5 แนวคิดพร้อมคำอธิบายว่าแต่ละแบบจะแสดงอะไรบ้าง ยังไม่สร้างภาพ

### Step 3: เลือกและสั่งสร้าง

ตอบเลือกตัวเลือก เช่น:
- `"ทำตัวที่ 2 ครับ"`
- `"ชอบ 1 กับ 4 รวมกันได้เลยไหม"`
- `"ทำตัวที่ Claude แนะนำ"` (มักอยู่ด้านล่างสุด)

Claude จะสร้าง interactive visual ออกมาใน chat

### Step 4: แปลงเป็น Artifact (ถ้าต้องการแชร์)

```
make the visual an artifact
```

หรือ:
```
แปลงเป็น artifact พร้อม slider เพื่อปรับค่า X
```

ภาพจะเปิดใน side panel และสามารถ iterate ต่อได้

### Step 5: Publish และแชร์

1. คลิก **Publish** บน Artifact
2. ได้ URL สาธารณะ — แชร์ให้ใครก็ได้
3. ผู้รับไม่ต้องมีบัญชี Claude เพื่อโต้ตอบกับ app

### ตัวอย่าง Use Cases

- **นักศึกษา**: แปลงสูตรฟิสิกส์เป็น interactive simulator
- **ครู/อาจารย์**: สร้าง visual explainer แล้วแชร์ URL ให้ทั้งห้อง
- **นักวิเคราะห์ข้อมูล**: เปลี่ยนตารางเป็น dashboard โต้ตอบได้
- **นักเขียน/Blogger**: สร้าง infographic แบบ interactive แทน static image
- **ทีมงาน**: แชร์ decision tree หรือ comparison chart เป็น URL

## Caveats / Limits

- **Token cost**: Visual generation ใช้ token มากกว่าข้อความ — บัญชีฟรีมี rate limit, Pro อาจกระทบ daily usage
- **Mobile ไม่แสดง**: Interactive visuals ไม่ render บน iOS/Android app
- **Shared chat**: คนดู shared chat ต้องล็อกอิน Claude ถึงจะเห็น visual (ต่างจาก published Artifact)
- **Artifact ฟรี**: บัญชีฟรีสร้าง Artifact ได้แต่มีขีดจำกัดจำนวน publish
- **ความแม่นยำข้อมูล**: Visual ที่ Claude สร้างอิงจากความรู้ตัดสิน 2025 — ตรวจสอบข้อมูลจริงก่อนแชร์
- **Remix ได้**: ทุกคนที่มี URL สามารถ remix Artifact ในบัญชีของตัวเองได้ — ไม่เหมาะเก็บข้อมูล proprietary

## References

1. [Endless Claude Visuals in 5 Minutes (Beginner Tutorial)](https://youtu.be/oWeAVc_VPSo) — วิดีโอต้นฉบับ
2. [What are artifacts and how do I use them? — Claude Help Center](https://support.claude.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them) — คำอธิบาย Artifacts อย่างเป็นทางการ
3. [Custom visuals in chat and Cowork — Claude Help Center](https://support.claude.com/en/articles/13979539-custom-visuals-in-chat-and-cowork) — ความแตกต่างระหว่าง interactive visuals และ Artifacts
4. [Publishing and sharing artifacts — Claude Help Center](https://support.claude.com/en/articles/9547008-publishing-and-sharing-artifacts) — วิธี publish และแชร์ Artifacts
5. [Turn ideas into interactive AI-powered apps — Claude Blog](https://claude.com/blog/build-artifacts) — announcement ของ Artifacts feature

## Key Takeaways

- **Brainstorm First** = แยกขั้นตอนคิดออกจากขั้นตอนสร้าง; บังคับ Claude สำรวจ 5 ตัวเลือกก่อนลงมือทำ
- Prompt สูตร: _"I want to understand X. Figure out what visuals would be most useful. Give me five options."_
- Claude มักใส่ตัวเลือกที่คิดว่าดีที่สุดไว้สุดท้าย; เลือกหรือรวม options ได้
- Interactive visuals = inline ชั่วคราว; Artifacts = side panel ถาวร + shareable URL
- `"make the visual an artifact"` — คำสั่งเปลี่ยน visual เป็น web app
- Published Artifact มี URL สาธารณะ: ไม่ต้องมีบัญชี Claude ก็โต้ตอบได้
- Claude Opus ทำ visualization ได้ดีที่สุดในบรรดาโมเดล Anthropic
- เทคนิค "ให้ options ก่อน" apply ได้กับทุกงาน ไม่ใช่แค่ visual
