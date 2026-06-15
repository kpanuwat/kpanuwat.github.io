---
title: "สร้างเกม AR WebApp ลากวางการ์ดคำศัพท์ด้วย Gemini Canvas + Hand Tracking"
date: 2026-06-14 00:02:00 +0700
categories: [Engineering]
tags: [gemini, ar, hand-tracking, mediapipe, webapp, game, canvas, html]
slides: true
---

{% include slide-link.html %}

## TL;DR

ใช้ Gemini Canvas + โมเดล Pro เขียน HTML เกม AR แบบ real-time ที่ตรวจจับปลายนิ้วผ่าน MediaPipe Hand Tracking ให้ผู้เล่นลากวางการ์ดคำศัพท์ภาษาอังกฤษด้วยมือจริง — ไม่ต้องเขียนโค้ดเอง แค่ Prompt ให้ถูก และอย่าลืมคัดลอกโค้ดเก็บไว้ เพราะ share link ของ Google ไม่ถาวร

## Background / Why this matters

เกม AR ที่ใช้ร่างกายควบคุมเคยเป็นโดเมนของ dev ที่มีทักษะ Computer Vision โดยเฉพาะ แต่ฟีเจอร์ **Gemini Canvas** เปลี่ยนกติกา — แทนที่จะต้องเขียน WebRTC + MediaPipe + Canvas API เอง คุณ describe ไอเดียเป็นภาษาธรรมชาติแล้วให้ Gemini Pro generate HTML ทั้งก้อนออกมา ทดสอบได้ใน Preview tab ทันที

**ทำไมเลือกเกมคำศัพท์?**

- เด็กเรียนภาษาอังกฤษ engage ดีขึ้นเมื่อร่างกายมีส่วนร่วม (embodied learning)
- Drag-and-drop ด้วยนิ้วมือเป็น mechanic ที่ง่ายต่อการ prototype
- เห็นผลทันทีใน browser ไม่ต้องติดตั้งแอป

## Deep Dive

### Gemini Canvas คืออะไร

Gemini Canvas คือ workspace ฝั่ง gemini.google.com ที่รวม editor + AI + preview ไว้ในหน้าเดียว เหมาะกับการสร้างเอกสาร โค้ด หรือ interactive app โดยไม่ต้องออกจาก browser

| ระดับ | โมเดล | Context |
|-------|--------|---------|
| Free | Gemini (standard) | จำกัด |
| Google AI Pro / Ultra | **Gemini 3.1 Pro** | สูงสุด 1 ล้าน token |

สำหรับงานที่ generate HTML ซับซ้อน (hand tracking + game logic) ควรเลือก **Pro** เพื่อให้โค้ดที่ออกมาครบและ functional

### MediaPipe Hand Tracking — เบื้องหลัง AI-tracking

MediaPipe Hands เป็น ML solution ของ Google ที่ทำงาน **on-device** ทั้งหมด ไม่ส่งข้อมูลไป server ทำให้ latency ต่ำมากเหมาะกับ real-time game

**21 Landmarks ต่อมือ 1 ข้าง:**

```
WRIST (0)
  ├── THUMB: 1→2→3→4 (tip)
  ├── INDEX: 5→6→7→8 (tip) ← ใช้ตรวจจับปลายนิ้วชี้
  ├── MIDDLE: 9→10→11→12 (tip)
  ├── RING: 13→14→15→16 (tip)
  └── PINKY: 17→18→19→20 (tip)
```

- **Landmark #8** = ปลายนิ้วชี้ → ใช้เป็น "cursor" สำหรับ drag
- **Landmark #4** = ปลายนิ้วโป้ง → ถ้า distance(4,8) < threshold = "pinch" (จับ)
- ค่าพิกัด (x, y) ออกมาเป็น normalized 0.0–1.0 ของหน้าจอ

### เกม AR ลากวางการ์ดคำศัพท์ — ทำงานอย่างไร

```
[Webcam feed] → [MediaPipe Hands] → [Landmark coordinates]
                                            ↓
                              ตรวจจับ pinch gesture ที่ card
                                            ↓
                              drag card ไปยัง target zone
                                            ↓
                              เช็ค collision → แสดง feedback
```

1. Canvas แสดงวิดีโอกล้องเป็น background (AR layer)
2. การ์ดคำศัพท์ (เช่น "apple", "banana") วางเป็น overlay elements
3. MediaPipe ส่ง landmark ของปลายนิ้วมาทุก frame
4. เมื่อ pinch ทับการ์ด → card ติดกับนิ้วและลาก
5. ปล่อยนิ้ว → drop การ์ดลง target zone

### เขียน Prompt อย่างไรให้ได้ผล

**โครงสร้าง Prompt ที่แนะนำ:**

```
Build an AR vocabulary card game using MediaPipe Hands.

GAME MECHANICS:
- Show webcam feed as background
- Display 5 English vocabulary cards (apple, book, cat, dog, egg)
  as draggable overlays
- Use MediaPipe Hand Landmarker to detect index fingertip (landmark #8)
  and thumb tip (landmark #4)
- When pinch distance < 40px: grab the nearest card
- When pinch releases: drop card at current position
- Show target zones on right side; if card dropped correctly → green glow + sound

FALLBACK (if camera unavailable):
- Support mouse drag-and-drop as backup control
- Show "Mouse mode" label when camera is off

UI:
- Dark background, card style: white rounded rect with word + emoji
- Score counter top-right
- Reset button bottom-center
```

**หลักการ prompt ที่สำคัญ:**

| เทคนิค | ทำไม |
|--------|------|
| ระบุ landmark index ชัดเจน (#8, #4) | ป้องกัน Gemini เดา landmark ผิด |
| กำหนด threshold ตัวเลข (40px) | ได้ pinch sensitivity ที่ test ได้ทันที |
| บอก fallback mouse อย่างชัดเจน | กล้องไม่ทำงานก็ยัง demo ได้ |
| ใส่ reset button | เทสซ้ำได้ง่ายระหว่าง iterate |

### ทำไมต้องใส่ Mouse Fallback

กล้องอาจมีปัญหาใน scenario เหล่านี้:
- Browser ไม่ให้ permission webcam
- แสงน้อยเกินไปให้ MediaPipe track ลำบาก
- ทดสอบบน device ที่ไม่มีกล้อง

การ**ใส่ fallback ใน prompt เดิม** ดีกว่า iterate ทีหลัง เพราะ Gemini จะออกแบบ event handler ให้รองรับ dual mode ตั้งแต่ต้น ไม่ต้องมา patch code ทีหลัง

```
FALLBACK:
- Support mouse drag-and-drop as backup control
- If navigator.mediaDevices is unavailable → auto-switch to mouse mode
- Show mode indicator: "📷 Hand Mode" / "🖱️ Mouse Mode"
```

### คัดลอกโค้ดเก็บไว้เสมอ

Share link ของ Gemini Canvas / AI Studio **ไม่ได้การันตีความถาวร** — Google อาจเปลี่ยน URL scheme หรือ purge project ที่ inactive

**วิธีเซฟโค้ด:**

1. ใน Canvas → คลิก `</>` (Code view)
2. Select All → Copy
3. วางใน file `vocabulary-game.html` บนเครื่อง
4. เปิดด้วย browser ได้เลย (ไม่ต้อง server ถ้าไม่มี CORS issue)

```bash
# ทดสอบ local
open vocabulary-game.html          # macOS
xdg-open vocabulary-game.html      # Linux
start vocabulary-game.html         # Windows
```

หรือ push ขึ้น GitHub Pages / Netlify Drop เพื่อได้ HTTPS URL (MediaPipe ต้องการ HTTPS สำหรับ webcam access)

## User Guide (Step-by-Step)

### Step 1 — เปิด Gemini Canvas ด้วย Pro

1. ไปที่ [gemini.google.com](https://gemini.google.com)
2. ใต้ช่อง prompt → เลือก **Canvas**
3. คลิกไอคอน settings → เลือก **Gemini 3.1 Pro** (ต้องเป็น subscriber)

### Step 2 — วาง Prompt

วาง prompt ตาม template ในหัวข้อ Deep Dive ข้างต้น กด Enter

**Expected output:** Gemini generate HTML ~200-400 บรรทัดใน Code tab พร้อม Preview tab

### Step 3 — อนุญาตกล้อง

Preview tab จะแสดงหน้าเกม → browser ขอ permission กล้อง → คลิก **Allow**

### Step 4 — ทดสอบ Hand Tracking

ยกมือหน้ากล้อง → เห็น landmark overlay → ลอง pinch การ์ด

ถ้า tracking กระตุก: ลองปรับ threshold ใน chat:
```
Increase the pinch threshold to 60px and add smoothing (average last 3 frames)
```

### Step 5 — Iterate ด้วยภาษา

ปรับเกมผ่าน chat ต่อ ไม่ต้องแตะโค้ดโดยตรง:
```
Add 10 more vocabulary cards. Shuffle positions on reset.
Add a 30-second countdown timer. Show "Time's Up!" when it ends.
```

### Step 6 — คัดลอกโค้ดเก็บ

เมื่อพอใจแล้ว → Code view → Select All → Copy → บันทึกเป็น `.html` file

### Step 7 — Deploy (Optional)

```bash
# Netlify Drop: ลาก .html file ไปที่ app.netlify.com/drop
# ได้ HTTPS URL ทันที — ต้องการสำหรับ webcam บน mobile
```

## Caveats / Limits

- **กล้อง = HTTPS-only:** MediaPipe ต้องการ secure context; `localhost` ใช้งานได้แต่ `file://` อาจไม่ได้
- **Pro subscription required สำหรับ complex app:** Free tier อาจ generate โค้ดไม่ครบหรือ timeout
- **Share link ไม่ถาวร:** ไม่มี SLA จาก Google — เซฟโค้ดเสมอก่อน share
- **MediaPipe accuracy:** แสงน้อย / พื้นหลังซับซ้อน → tracking แม่นน้อยลง; แนะนำพื้นหลังสว่างสม่ำเสมอ
- **Mobile:** webcam access บน mobile ต้องการ HTTPS + browser ที่รองรับ MediaPipe (Chrome/Edge แนะนำ)
- **One hand at a time:** MediaPipe Hands default อาจ track 2 มือ แต่ game logic ที่ generate อาจใช้แค่มือแรก — ระบุใน prompt ถ้าต้องการ dual-hand support

## References

1. [Jump to play: Building with Gemini & MediaPipe — Google Developers Blog](https://developers.googleblog.com/jump-to-play-building-with-gemini-mediapipe/) — source ของตัวอย่าง Chrome Dino + prompt patterns (March 2026)
2. [MediaPipe Solutions — Available Solutions](https://ai.google.dev/edge/mediapipe/solutions/guide#available_solutions) — รายการ ML solutions รวม Hand Landmarker
3. [Gemini Canvas Overview](https://gemini.google/overview/canvas/) — ข้อมูล tier, context window, feature list
4. [Turn creative prompts into interactive XR experiences — Google Developers Blog](https://developers.googleblog.com/turn-creative-prompts-into-interactive-xr-experiences-with-gemini/) — Gemini + XR / AR use cases
5. [MediaPipe Showcase Gallery — Google AI Studio](https://aistudio.google.com/apps?source=showcase&showcaseTag=mediapipe) — ตัวอย่าง app ที่ใช้ hand/pose/face tracking
6. [สอนสร้างเกม AR WebApp ลากวางการ์ดคำศัพท์ด้วยร่างกาย — YouTube](https://youtu.be/yrZDp0kSdKc) — video tutorial ต้นทาง

## Key Takeaways

- Gemini Canvas + Pro model = เขียนเกม AR จาก prompt ใน 5 นาที ไม่ต้องรู้ MediaPipe API
- MediaPipe Hands track 21 landmark ต่อมือ on-device → zero latency; ใช้ landmark #8 (index tip) + #4 (thumb tip) สำหรับ pinch drag
- **ใส่ mouse fallback ใน prompt แรกเสมอ** — ป้องกันเกมใช้ไม่ได้เมื่อกล้องมีปัญหา
- ระบุ threshold เป็นตัวเลข (px) ใน prompt เพื่อ control sensitivity ตั้งแต่ต้น
- **Share link ของ Google ไม่ถาวร** — Copy โค้ดออกมาเซฟเป็น `.html` ทุกครั้งก่อน share
- MediaPipe ต้องการ HTTPS สำหรับ webcam access → host บน Netlify/GitHub Pages ไม่ใช่ `file://`
- Iterate ผ่าน chat ได้เลย ไม่ต้องแก้โค้ดมือ: บอก Gemini ว่าจะ tweak อะไร
