---
title: "NotebookLM → Google Vids: สร้างวิดีโอ AI Avatar แบบ Pro ด้วยเครื่องมือฟรี"
date: 2026-06-16 00:03:00 +0700
categories: [Tools]
tags: [notebooklm, google-vids, ai-avatar, gemini, google-workspace, video-production]
slides: true
---

{% include slide-link.html %}

## TL;DR

แปลง content จาก NotebookLM เป็นวิดีโอ AI Avatar บน Google Vids ได้ฟรีทั้งหมด — ตั้งแต่ gen สไลด์, สร้าง Custom Avatar ด้วย Gemini prompts, ไปจนถึง export MP4 พร้อม Google Voice Actor โดยมีเทคนิคสำคัญ 2 อย่างที่ต้องรู้: วิธีแก้ปัญหา watermark (สำหรับคนไม่มี Ultra) และ trick "Make a copy" เพื่อ reuse avatar ข้ามโปรเจกต์

## Background / Why this matters

Google Vids คือ platform สร้างวิดีโอที่ฝังอยู่ใน Google Workspace สามารถใช้งานได้ฟรี และรองรับ AI Avatar พร้อม voice-over อัตโนมัติจาก 30 Google Voice Actors

ปัญหาที่หลายคนเจอคือ workflow ไม่ชัด — ต้องเริ่มตรงไหน, สไลด์มาจากไหน, Avatar สร้างยังไง และทำไม Avatar ที่สร้างแล้วถึงหายไปเวลาเปิดโปรเจกต์ใหม่ บทความนี้ใช้ workflow จากวิดีโอ [How to Turn NotebookLM into Custom AI Avatar Videos (Google Vids)](https://youtu.be/uTlHapI-aP8) มาเรียบเรียงเป็น step-by-step ที่ทำตามได้ทันที

## Deep Dive

### ทำไม Custom Avatar ถึง "หาย" ข้ามโปรเจกต์

ข้อจำกัดสำคัญที่สุดที่ต้องเข้าใจก่อน: **Custom Avatar ใน Google Vids เป็น file-scoped** ไม่ใช่ account-wide

เมื่อคุณสร้าง Custom Avatar ใน file A แล้วเปิด file B ใหม่ → Avatar นั้นจะไม่ปรากฏในตัวเลือก Google Vids แสดงข้อความว่า "Custom avatars created in this file are only available here. To reuse this avatar in another project, you'll need to make a copy of the file."

**วิธีแก้:** สร้าง Avatar template file ไว้หนึ่งไฟล์ → ทุกครั้งที่ต้องการใช้ Avatar ให้ทำ "Make a copy" ของ template แทนการสร้างไฟล์ใหม่เปล่า

### Pipeline ภาพรวม

```
NotebookLM (slide gen)
  → Download PPT
  → [Watermark fix] Gemini Canvas → Export to Google Slides
  → vids.google Template (Custom Avatar)
  → "Make a copy" → Import Slides → Voice Actor → Mute → Export
```

### ขั้นตอนที่ 1: Gen สไลด์ใน NotebookLM

1. เตรียม prompt ด้วย Gemini ก่อน — ขอให้ Gemini เขียน "plain language prompt" สำหรับหัวข้อที่ต้องการ
2. เปิด NotebookLM → คลิก "Slides" → เลือก **"Presenter Slides"** (ไม่ใช่ Detailed Deck) — ให้สไลด์ยาวและมีเนื้อหาพอสำหรับ voiceover
3. Paste prompt → Generate
4. ตรวจสอบความถูกต้องของ content ก่อน download — AI สามารถ hallucinate ข้อมูลได้
5. Download เป็น **PowerPoint (.pptx)**

### ขั้นตอนที่ 2: แก้ปัญหา Watermark (สำหรับ non-Ultra users)

ถ้าไม่มี Google One AI Premium / Workspace Ultra → สไลด์ที่ export จาก NotebookLM จะมี watermark

**Workaround ผ่าน Gemini Canvas:**

1. เปิด Gemini → คลิก **Canvas**
2. Upload ไฟล์ `.pptx` ที่มี watermark
3. พิมพ์ prompt เช่น "Turn this document into a clean slide deck without watermarks"
4. Gemini จะ recreate สไลด์ใน Canvas side panel
5. คลิก **"Export to Slides"** → เปิดใน Google Drive → ได้ Google Slides ที่สะอาดพร้อมใช้

> ตรวจสอบสไลด์หลัง export ทุกครั้ง — Gemini อาจปรับ layout หรือตัดข้อความบางส่วน

### ขั้นตอนที่ 3: สร้าง Custom Avatar ใน Google Vids

1. เปิด [vids.google.com](https://vids.google.com) → สร้างวิดีโอใหม่ → คลิก **"AI Avatar"** → **"Create a Custom Avatar"**
2. **ใช้ Gemini ช่วยตั้ง settings:**
   - ถ่าย screenshot ของหน้า avatar creation ทั้งหน้า
   - เปิด Gemini → upload screenshot + รูปภาพ reference ที่ต้องการให้ avatar คล้าย
   - ถาม Gemini ว่า "What settings should I use in the dialogue boxes to approximate this image as closely as possible?"
   - Gemini จะแนะนำค่าต่างๆ เช่น outfit style (formal/business casual), additional appearance details
3. Paste Gemini's prompt → Generate → ได้ตัวเลือก avatars หลายตัว
4. **Refine อีกรอบด้วย Gemini:**
   - ถ่าย screenshot ของ avatar options
   - ถาม Gemini ว่าตัวไหนใกล้เคียงที่สุดและควร refine ยังไง
   - คลิก **"Refine selected"** → Paste Gemini's refinement prompt → Click **"Update"**
5. ตั้งชื่อ → **Save avatar**

### ขั้นตอนที่ 4: สร้าง Template File

หลังสร้าง Avatar เสร็จ → **อย่า** ปิดหรือสร้างโปรเจกต์ใหม่

ให้ทำ: **Rename** ไฟล์ปัจจุบันเป็นชื่อที่ระบุว่าเป็น template เช่น `[TEMPLATE] My Avatar - Sales`

ไฟล์นี้คือ master template ที่จะใช้ clone ทุกครั้ง

### ขั้นตอนที่ 5: ใช้ Avatar ในวิดีโอใหม่

1. เปิด template file → **File → "Make a copy"** → ตั้งชื่อวิดีโอใหม่ → Make a copy
2. ตรวจสอบว่า Custom Avatar ปรากฏ: คลิก "Change avatar" → ควรเห็น Custom Avatar ของคุณ
3. **Import สไลด์:** File → **"Convert slides"** → เลือก Google Slides file จาก Drive
4. Google Vids จะ import ทุก slide พร้อม generate script อัตโนมัติ

### ขั้นตอนที่ 6: ตั้งค่า Voice Actor และ Audio

1. เลือก **Voice Actor** ให้ตรงกับ Avatar ที่ใช้ — Google มี 30 voice actors ให้เลือกฟรี
2. ตัวเลือกที่แนะนำให้ติ๊ก: **AI voice over** + script; ไม่แนะนำ background music + animation (ทำให้วิดีโอดูรกและอาจชนกับ voiceover)
3. คลิก **"Use this voice over"** → **"Draft video"**

**Critical: Mute double track**

เมื่อ import สไลด์ที่มี audio อยู่แล้ว (เช่น จาก NotebookLM) + เพิ่ม Google Voice Actor → จะมี audio สองชั้นซ้อนกัน ต้อง mute หรือลบ track ที่ไม่ต้องการออก ไม่งั้นเสียงจะทับกัน

### ขั้นตอนที่ 7: วางตำแหน่ง Avatar และ Export

1. ในแต่ละ scene คลิก **"Add avatar"** หรือเลือก scene → Change avatar → เลือก Custom Avatar
2. ปรับขนาดและตำแหน่งตามต้องการ
3. **Export:** คลิก Export → **MP4** หรือ **Share directly to YouTube**

## Caveats / Limits

- **Avatar scope:** Custom Avatar ผูกกับ file — ต้อง "Make a copy" ทุกครั้ง ไม่สามารถ import ข้าม file โดยตรงได้
- **Watermark:** NotebookLM slide export มี watermark ถ้าไม่มี Google One AI Premium (US: $19.99/เดือน) หรือ Google Workspace Ultra — Gemini Canvas เป็น workaround แต่ layout อาจเปลี่ยน
- **Script accuracy:** AI-generated script จาก slide content อาจ paraphrase หรือตัดข้อมูล ควรตรวจก่อน render
- **Avatar quality:** Vids.google ใช้ prompt-based avatar ไม่ใช่ photo-realistic likeness — ความคล้ายกับรูปต้นแบบขึ้นอยู่กับ prompt quality
- **Animations:** การ enable animation มักทำให้วิดีโอดูรกและชนกับ voiceover timing แนะนำให้ปิด
- **Free tier limits:** Google Vids ฟรีสำหรับ Google account ทั่วไปแต่ feature บางอย่าง (เช่น export resolution สูงสุด) อาจต้องการ Workspace plan — ตรวจสอบที่ [workspace.google.com/pricing](https://workspace.google.com/pricing)

## References

1. How to Turn NotebookLM into Custom AI Avatar Videos (Google Vids) — [YouTube](https://youtu.be/uTlHapI-aP8)
2. Google Vids — [vids.google.com](https://vids.google.com)
3. NotebookLM — [notebooklm.google.com](https://notebooklm.google.com)
4. Google Gemini Canvas — [gemini.google.com](https://gemini.google.com)
5. Google Workspace Pricing — [workspace.google.com/pricing](https://workspace.google.com/pricing)

## Key Takeaways

- Custom Avatar ใน Google Vids เป็น **file-scoped** — ต้อง "Make a copy" จาก template ทุกครั้ง ไม่ใช่เปิดไฟล์ใหม่เปล่า
- **Gemini เป็นตัวกลางสำคัญ** ทั้งสร้าง prompt สำหรับ NotebookLM สไลด์ และช่วย describe avatar settings ให้ละเอียดขึ้น
- Watermark แก้ได้ฟรีผ่าน **Gemini Canvas → Export to Slides** โดยไม่ต้องซื้อ Ultra
- เลือก **Presenter Slides** (ไม่ใช่ Detailed Deck) ใน NotebookLM เพื่อให้สไลด์มีเนื้อหาพอสำหรับ voiceover
- ต้อง **Mute double track** ถ้า slides มี audio อยู่แล้วก่อน add Google Voice Actor
- ปิด animation และเลือก voice actor ให้ตรงกับ avatar character เพื่อผลลัพธ์ที่ดูเป็น professional
- ทั้ง workflow ใช้ได้ **ฟรี** ด้วย Google account ทั่วไป + 30 voice actors + vids.google free tier
