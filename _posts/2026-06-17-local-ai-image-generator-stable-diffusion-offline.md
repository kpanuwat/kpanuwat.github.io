---
title: "เจาะลึก Local-AI-Image-Generator: รัน Stable Diffusion ฟรี 100% Offline บน PC ไม่ต้องอินเทอร์เน็ต"
date: 2026-06-16 00:02:00 +0700
categories: [Tools]
tags: [stable-diffusion, local-ai, image-generation, open-source, cuda, vulkan, windows]
slides: true
---

{% include slide-link.html %}

## TL;DR

`Local-AI-Image-Generator` คือโปรเจกต์โอเพนซอร์ส MIT บน GitHub ที่ให้รัน Stable Diffusion ได้ 100% บนเครื่อง Windows โดยไม่ต้องอินเทอร์เน็ต ไม่มี content filter และไม่ต้องติดตั้ง Python — แค่ดับเบิลคลิก `start.bat` แล้วเปิด browser ที่ `localhost:1420` ใช้งานได้ทันที รองรับ Nvidia (CUDA), AMD/Intel (Vulkan), และ CPU

## Background / Why this matters

Stable Diffusion เป็นโมเดล AI image generation ที่ทรงพลัง แต่การตั้งค่าแบบดั้งเดิมอย่าง AUTOMATIC1111 หรือ ComfyUI ต้องใช้ Python, virtual environment, CUDA toolkit และ dependencies อีกมากมาย ซึ่งสร้างอุปสรรคให้ผู้ใช้ทั่วไปที่ไม่มีพื้นฐาน developer อย่างมีนัยสำคัญ

โปรเจกต์ `techjarves/Local-AI-Image-Generator` แก้ปัญหานี้ด้วยการใช้ Node.js เป็น runtime แทน Python โดย sandbox Node.js ไว้ภายใน folder ของโปรเจกต์เลย ไม่แตะ system-wide PATH ทำให้เป็น portable และ zero-dependency จากมุมมองของ OS

ด้านความเป็นส่วนตัว: image ทั้งหมดถูก generate บนฮาร์ดแวร์ของผู้ใช้เอง ไม่มีการส่งข้อมูลออกนอก ไม่มี content filter ที่อาจปฏิเสธ prompt

## Deep Dive

### สถาปัตยกรรมแบบ Portable Node.js

ต่างจาก AUTOMATIC1111 หรือ ComfyUI ที่ใช้ Python stack, Local-AI-Image-Generator ใช้ Node.js เป็น runtime หลัก `start.bat` จะ download portable Node.js binary มาไว้ใน folder ของโปรเจกต์เองโดยอัตโนมัติ พร้อมกับ pre-compiled GPU backend binaries ที่เหมาะกับฮาร์ดแวร์ที่ตรวจพบ

โครงสร้าง folder:

```
Local-AI-Image-Generator/
├── start.bat          # entry point หลัก
├── scripts/           # automation setup
├── app/
│   ├── frontend/      # UI code (Node.js)
│   ├── models/        # ใส่ model files ไว้ที่นี่
│   └── outputs/       # ภาพที่ generate แล้ว (PNG + JSON metadata)
```

### ระบบ Auto GPU Detection

ระบบตรวจ GPU อัตโนมัติและเลือก backend ที่เหมาะสม — ไม่ต้องตั้งค่าเพิ่ม:

| GPU | Backend | Performance (20 steps, 512×512) |
|-----|---------|--------------------------------|
| Nvidia RTX/GTX | CUDA | ~10 วินาที |
| AMD Radeon | Vulkan | ~89 วินาที |
| Intel Arc | Vulkan | ~89 วินาที |
| CPU ธรรมดา | CPU fallback | 150–300+ วินาที |

Vulkan backend เป็นตัวเลือกที่สำคัญสำหรับผู้ใช้ AMD และ Intel ที่ ecosystem ของ Stable Diffusion เดิมรองรับได้ไม่ดีนัก

### รูปแบบโมเดลที่รองรับ

- **`.safetensors`** — format มาตรฐานปัจจุบัน ปลอดภัยกว่า `.ckpt` (ไม่สามารถ execute arbitrary code ได้)
- **`.gguf`** — format quantized ใช้ RAM/VRAM น้อยกว่า เหมาะกับฮาร์ดแวร์ mid-range
- **`.ckpt`** — format เก่า ยังรองรับสำหรับโมเดล legacy

### UI Controls หลัก

Web app ที่ `http://localhost:1420` มีพารามิเตอร์ควบคุมหลัก:

| พารามิเตอร์ | ช่วงค่า | ค่าแนะนำ | ผลกระทบ |
|------------|---------|---------|---------|
| **Steps** | 1–150 | 20–30 | ยิ่งมาก ยิ่งละเอียด แต่ช้าขึ้น |
| **Resolution** | 256–1024 | 512×512 | ยิ่งใหญ่ ยิ่งใช้ VRAM มาก |
| **CFG Scale** | 1–20 | 7–9 | ต่ำ = อิสระ / สูง = ตาม prompt มากขึ้น |

นอกจากนี้ยังมี **Real-time Monitor** แสดง RAM, VRAM, CPU, GPU usage live และ **Local Gallery** สำหรับดูภาพที่ generate แล้ว

## User Guide (Step-by-Step)

### 1. ดาวน์โหลดโปรเจกต์

```bash
# ผ่าน Git
git clone https://github.com/techjarves/Local-AI-Image-Generator.git

# หรือ Download ZIP จาก GitHub แล้ว Extract
```

### 2. รัน start.bat (ครั้งแรก)

ดับเบิลคลิก `start.bat` — ระบบจะ:
1. Download portable Node.js มาไว้ใน folder
2. ตรวจ GPU → download CUDA binaries (Nvidia) หรือ Vulkan binaries (AMD/Intel)
3. เปิด web server ที่ `http://localhost:1420`

> การรันครั้งแรกใช้เวลาสักครู่ขึ้นอยู่กับ internet speed สำหรับ download binaries ครั้งถัดไปเร็วทันที

### 3. เพิ่มโมเดล

**วิธีที่ 1: Download ผ่าน UI**
- ไปที่ **Model Manager** ใน web app
- ใส่ Hugging Face model URL แล้วกด Download

**วิธีที่ 2: Import โมเดลที่มีอยู่**
- Copy ไฟล์ `.safetensors`, `.gguf`, หรือ `.ckpt` ไปไว้ใน `app/models/`
- Refresh browser

แหล่งโมเดลยอดนิยม:
- [Civitai](https://civitai.com) — community models หลากหลาย style
- [Hugging Face](https://huggingface.co/models?filter=stable-diffusion) — official + research models

### 4. Generate ภาพ

1. เลือกโมเดลที่ต้องการ
2. ใส่ prompt (ภาษาอังกฤษให้ผลดีที่สุด)
3. ปรับ Steps, Resolution, CFG Scale
4. กด Generate — ภาพ save อัตโนมัติที่ `app/outputs/` พร้อม JSON metadata

### 5. Tips การปรับค่า

- เริ่มด้วย Steps=20, CFG=7, Resolution=512×512 เสมอ — หา baseline ก่อน
- เพิ่ม Steps เป็น 30–50 เมื่อต้องการ detail มากขึ้น (ใช้เวลาเพิ่มตามสัดส่วน)
- CFG Scale 7–9 เป็นช่วงที่สมดุลที่สุดสำหรับโมเดลส่วนใหญ่
- หากมี VRAM ≥6GB: ลองเพิ่ม Resolution เป็น 768×768

## Caveats / Limits

- **Windows only** — ยังไม่รองรับ macOS หรือ Linux ณ เวลาที่เขียน
- **CPU fallback ช้ามาก** — 150–300+ วินาที/ภาพ ไม่เหมาะสำหรับ workflow ที่ต้องการหลายภาพ
- **VRAM threshold** — แนะนำ ≥4GB VRAM สำหรับ CUDA; Vulkan อาจใช้ system RAM แทนได้แต่ช้ากว่า
- **ไม่ compatible กับ AUTOMATIC1111 extensions** — ใช้ Node.js stack ต่างจาก Python-based tools
- **โมเดลขนาดใหญ่ต้องการ VRAM สูง** — SDXL ≥8GB, FLUX ≥12GB

## References

1. [techjarves/Local-AI-Image-Generator — GitHub](https://github.com/techjarves/Local-AI-Image-Generator)
2. [Hugging Face — Stable Diffusion Models](https://huggingface.co/models?filter=stable-diffusion)
3. [Civitai — Community Model Hub](https://civitai.com)
4. [Vulkan API Overview — Khronos Group](https://www.vulkan.org/learn#key-resources)

## Key Takeaways

- `start.bat` ดูแลทุกอย่าง: download Node.js, ตรวจ GPU, install backend — ไม่ต้องแตะ Python หรือ venv
- รองรับ 3 hardware tier: CUDA (Nvidia, ~10s), Vulkan (AMD/Intel, ~89s), CPU (fallback, 150–300s+) ที่ 20 steps / 512×512
- โมเดล format ที่รองรับ: `.safetensors`, `.gguf`, `.ckpt`
- 100% offline และไม่มี content filter — privacy สมบูรณ์
- MIT License — ใช้งานและ modify ได้เสรี
- ข้อจำกัดหลัก: Windows only, CPU mode ช้า, ไม่ใช่ Python ecosystem จึงไม่ compatible กับ A1111 extensions
