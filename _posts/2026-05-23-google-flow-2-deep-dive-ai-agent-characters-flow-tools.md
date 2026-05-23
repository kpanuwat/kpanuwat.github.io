---
title: "เจาะลึก Google Flow 2.0: AI Agent, Characters และ Flow Tools ปฏิวัติการสร้างวิดีโอ"
date: 2026-05-23 00:05:00 +0700
categories: [Tools]
tags: [google-flow, ai-video, video-generation, ai-agent, gemini, generative-ai, no-code]
slides: true
---

{% include slide-link.html %}

## TL;DR

Google Flow อัปเดตครั้งใหญ่ที่ Google I/O 2026 เพิ่ม **AI Agent** สำหรับงานหลายขั้นตอน, **Characters** ที่ล็อครูปลักษณ์+เสียงตัวละครให้คงที่ทุก scene, และ **Flow Tools** สร้างเครื่องมือเฉพาะทางโดยไม่ต้องเขียน code — ทั้งหมดขับเคลื่อนด้วย Gemini Omni Flash model

## Background / Why this matters

ปัญหาคลาสสิกของ AI video generation คือ **character inconsistency** — ตัวละครเดิมในคลิปถัดไปกลับหน้าตาต่างออกไป เสียงเปลี่ยน ผมยาวขึ้นผิดปกติ สิ่งเหล่านี้ทำให้การสร้าง narrative ต่อเนื่องทำได้ยากมาก

ก่อน Flow 2.0 creators ต้องใช้ prompt engineering ซับซ้อนหรือ seed image เพื่อพยายามรักษาความต่อเนื่อง ซึ่งยังได้ผลไม่สม่ำเสมอ นอกจากนี้ Gemini Omni model ยังจำกัดอยู่ที่ ~10 วินาทีต่อ clip ทำให้การสร้าง explainer video หรือ long-form content ต้องแบ่งทำเองทั้งหมด

Google I/O 2026 แก้ปัญหาเหล่านี้ใน 3 ทิศทางพร้อมกัน: agent automation, character lock, และ no-code tooling — เป็นการยกระดับจาก "AI clip generator" สู่ "AI filmmaking platform"

## Deep Dive

### 1. Google Flow Agent — Creative Partner หลายขั้นตอน

Flow Agent คือ chatbot ที่ฝังอยู่ใน **side panel** ของ project — ไม่ใช่ general-purpose AI แต่ถูก ground ไว้กับ project context โดยเฉพาะ

**ทำอะไรได้บ้าง:**
- สร้าง assets หลายชิ้นพร้อมกัน (เช่น 3 ภาพ ต่างสไตล์ ในคำสั่งเดียว)
- แปลง static image → video อัตโนมัติ
- Batch edit ข้ามทุก assets ใน project
- Rename + จัดกลุ่ม collections อัจฉริยะ
- เป็น sounding board สำหรับ dialogue ระหว่างตัวละคร
- เสนอ plot twist และ scene recommendations

**Credit Approval System:**
ก่อน generate ทุกครั้ง Agent จะถามก่อนเสมอ เช่น:
> "Would you like me to kick off this 3-image generation costing 0 credits?"

มี toggle สำหรับ **Auto-Approve** แต่ผู้ใช้ควรระวัง — agent สามารถ generate content จำนวนมากและเผาผลาญ credits ได้เร็วมากเมื่อเปิด auto-approve ไว้ แนะนำให้ manual approve โดยเฉพาะ video generation (15 credits ต่อคลิป)

**Long-form Explainer Videos:**
นี่คือ use case ที่โดดเด่นที่สุด แทนที่จะ generate ครั้งละ 10 วินาที ให้:
1. ป้อน **script เต็ม** ให้ Agent
2. Agent แยก script ออกเป็น scenes อัตโนมัติ
3. สร้าง video clip ทีละ scene
4. Stitch ทุก scene เข้าด้วยกัน

ผลลัพธ์คือ long-form video ที่สร้างแบบ fully automated — เหมาะกับ explainer content, tutorial, หรือ storytelling ยาวๆ

**Access:** ฟรีสำหรับผู้ใช้ทุกคนทั่วโลก (ไม่ต้องสมัคร subscription)

---

### 2. Characters — แก้ปัญหา Consistency ตัวละคร

Features ที่รอกันมานาน — ระบบ Characters แก้ปัญหา identity drift ด้วย 2 องค์ประกอบ:

**Visual Consistency:**
- Upload ภาพตัวละครที่มีอยู่ หรือ generate ตัวละครใหม่จาก text prompt
- หน้าต้องเห็นชัด เพื่อให้ AI track facial features ได้ถูกต้อง
- ระบบล็อค visual identity รวมถึง ชุด เกราะ ทรงผม ไว้ทุก camera angle

**Voice Consistency:**
- เลือก default voice หรือสร้าง custom voice จาก:
  - Base voice template
  - คำอธิบาย performance (เช่น "เสียงผู้หญิงอายุ 30 ปี สำเนียงอังกฤษ")
- เสียงถูกผูกไว้กับตัวละครถาวร ทุก clip ที่ cast ตัวละครนั้นใช้เสียงเดิมเสมอ

**Casting ด้วย "Add to Prompt":**
พิมพ์ชื่อตัวละครผ่าน **"add to prompt" linking function** ใน prompt field — ระบบดึง visual + voice profile มาใช้ทันที ไม่ต้องระบุรายละเอียดซ้ำในแต่ละ scene

ตัวอย่าง workflow:
```
สร้างตัวละคร "Kira" → upload ภาพ → assign voice "สาวไทยอายุ 25 ปี"
→ generate scene 1: [Kira] นั่งในคาเฟ่
→ generate scene 5: [Kira] วิ่งบนถนน
→ ทั้ง 2 scene ใช้หน้า เสียง ทรงผมเดิม
```

**ทำไม Flow Tools ถึงสำคัญสำหรับ Characters:**
Consistency ใน Flow ขับเคลื่อนโดย Gemini Omni Flash ที่เรียนรู้ face embedding จาก upload — ต่างจากแค่ "ใส่ seed image ใน prompt" เพราะระบบรักษา identity ใน latent space ไม่ใช่แค่ copy pixel

---

### 3. Flow Tools — No-Code Custom Tooling

Flow Tools เปิดให้ทุกคนสร้างเครื่องมือเฉพาะทางด้วย **natural language** — ไม่ต้องเขียน code แม้แต่บรรทัดเดียว

**วิธีสร้าง Tool:**
อธิบายสิ่งที่ต้องการด้วยภาษาธรรมดา เช่น:
> "สร้าง tool ที่แปลงภาพทุกภาพเป็น stop-motion claymation style ด้วยคลิกเดียว"

Flow สร้าง tool ให้อัตโนมัติ พร้อมให้ทดสอบทันที

**Community Library:**
Tools ที่สร้างสามารถ publish ขึ้น community library ให้คนอื่น **ใช้หรือ remix** ต่อได้ ตัวอย่าง community tools ที่มีอยู่:

| Tool | ทำอะไร |
|------|---------|
| **pixelBento** | ใส่ lo-fi + glitch aesthetics ให้ภาพ |
| **Simple Sketch Tool** | แปลง rough canvas drawing → generated image |
| **Image Editor Tool** | ปรับ color grading + เพิ่ม 3D depth-aware text layers |

**Access tiers:**
- **ฟรี:** ใช้ existing community tools
- **Google AI Subscription:** สร้างหรือ remix tools เอง

---

### 4. Gemini Omni Flash — Multimodal Engine

Model ใหม่ที่ขับเคลื่อนทุก features ด้านบน มีความสามารถหลัก:
- **"Create anything from any input, starting with video"** — รับ input ได้ทุกรูปแบบ (text, image, video)
- Conversational iteration — แก้ไขผ่าน chat โดยไม่ต้อง re-prompt ทั้งหมด
- ทำงานบน both Flow (video) และ Flow Music (music video direction)

**ข้อจำกัด:** video clip ต่อ generation ~10 วินาที → ต้องใช้ Agent เพื่อ stitch long-form

**Access:** ต้องมี Google AI subscription

---

### 5. Flow Music — Gemini Omni มาถึง Music Video ด้วย

Gemini Omni Flash มาถึง **Flow Music** เช่นกัน — สั่ง agent ให้ direct music video แบบ conversational ได้เลย ปรับ style, subject, และ scene ให้ match กับ narrative และ pacing ของเพลง

---

### 6. Mobile Apps

| App | Platform | สถานะ |
|-----|----------|-------|
| Google Flow (video) | Android | Beta |
| Google Flow (video) | iOS | Coming soon |
| Flow Music | iOS | พร้อมใช้แล้ว |
| Flow Music | Android | Coming soon |

ใช้ได้สำหรับผู้ใช้อายุ 18+ เท่านั้น

## User Guide (Step-by-Step)

### เริ่มต้นใช้ Flow Agent

1. เปิด [labs.google/fx/tools/flow](https://labs.google/fx/tools/flow) → สร้าง New Project
2. คลิก **Agent** ใน panel ด้านซ้าย → chat panel เปิดขึ้น
3. พิมพ์ task เช่น:
   > "สร้าง 3 ภาพต้นไม้ใน 3 สไตล์: 3D, 2D anime, clay animation"
4. Agent แสดง credit cost ก่อน → คลิก Approve
5. ดู results ใน canvas ทางขวา

**Pro tip:** ปิด Auto-Approve ไว้เสมอในช่วงแรก เพื่อควบคุม credit usage

### สร้าง Explainer Video ด้วย Agent

1. เตรียม script ทั้งหมด (plain text หรือ numbered scenes)
2. ใน Agent พิมพ์:
   > "อ่าน script นี้แล้วสร้าง explainer video โดยแบ่งเป็น scenes และ stitch เข้าด้วยกัน: [paste script]"
3. Agent breakdown scenes → ขอ approval ทีละ scene หรือ bulk
4. Output: video clips ต่อกันอัตโนมัติ

### ตั้งค่า Character

1. ไปที่ **Characters** tab
2. คลิก **+ New Character** → upload ภาพ (หน้าต้องชัด) หรือ generate จาก prompt
3. กด **Assign Voice** → เลือก base voice → อธิบาย performance
4. บันทึก character name
5. ใน prompt field → กด **Add Character** icon → เลือกชื่อ
6. ตัวละครถูก embed ใน prompt อัตโนมัติ

### สร้าง Custom Flow Tool

1. ไปที่ **Flow Tools** tab → คลิก **+ Create Tool**
2. อธิบาย tool ที่ต้องการด้วยภาษาธรรมดา
3. ทดสอบด้วยภาพตัวอย่าง
4. Publish ขึ้น community library (optional)

## Caveats / Limits

- **Video duration:** Gemini Omni Flash generates ~10 sec/clip — long-form ต้องใช้ Agent stitching
- **Credit burn risk:** Auto-Approve Agent อาจเผาผลาญ credits เร็วโดยไม่ตั้งใจ
- **Character face requirement:** ต้องเห็นหน้าชัดเจน — ภาพมาสก์หรือหมวกคลุมหน้าใช้ไม่ได้
- **Tool creation gated:** สร้าง/remix Flow Tools ต้องมี Google AI subscription
- **Mobile age restriction:** 18+ เท่านั้น
- **Gemini Omni Flash access:** ต้อง Google AI subscription (ฟรี tier ใช้ model เก่า)
- **Feature variance:** บางฟีเจอร์ยังอยู่ระหว่าง rollout ตาม region

## References

1. Google Blog — "Introducing Gemini Omni for Google Flow and Flow Music": [blog.google](https://blog.google/innovation-and-ai/models-and-research/google-labs/flow-updates/)
2. Android Headlines — "Google Flow Gets a Major Upgrade — AI Agents, Music Videos, and Mobile Apps Are Here": [androidheadlines.com](https://www.androidheadlines.com/2026/05/google-flow-gets-a-major-upgrade-ai-agents-music-videos-and-mobile-apps-are-here.html)
3. 9to5Google — "Google Flow AI video editing & music tools getting dedicated apps and Omni upgrades": [9to5google.com](https://9to5google.com/2026/05/19/google-flow-video-music-ai-apps/)
4. YouTube — "The New Google Flow Just Changed AI Filmmaking Forever": [youtu.be/5AquJxcBGao](https://youtu.be/5AquJxcBGao)
5. Google Flow — Official product page: [labs.google/fx/tools/flow](https://labs.google/fx/tools/flow)

## Key Takeaways

- **AI Agent** เปลี่ยน Flow จาก clip generator เป็น multi-step creative partner — สร้าง long-form explainer video จาก script ได้ในคำสั่งเดียว
- **Characters** แก้ปัญหา identity drift ที่รบกวน AI filmmaking มานาน — ล็อค visual + voice ไว้ใน project ระดับ latent space ไม่ใช่แค่ seed image
- **Flow Tools** เปิด no-code tooling ให้ community — สร้าง, publish, remix เครื่องมือเฉพาะทางได้โดยไม่ต้องเขียน code
- **Gemini Omni Flash** เป็น multimodal engine ที่รับ input ทุกรูปแบบ แต่ยังจำกัดที่ ~10 วินาที/clip ต้องอาศัย Agent stitching สำหรับ long-form
- **Credit management สำคัญ** — ปิด Auto-Approve ไว้จน comfortable กับ workflow; Agent ใช้ credits อย่างรวดเร็วเมื่อมี free reign
- Agent + Characters + Flow Tools = ฟรี; Gemini Omni Flash + สร้าง Tools = ต้อง Google AI subscription
- Mobile apps กำลัง rollout ทั้ง 2 platform ภายในปีนี้ (อายุ 18+ เท่านั้น)
