---
title: "ทดสอบรัน Local AI บน MacBook Neo ด้วย oMLX"
date: 2026-05-19 04:26:15 +0700
categories: [Tools]
tags: [local-ai, omlx, llm, gemma, apple-silicon, quantization]
slides: true
---

{% include slide-link.html %}

## TL;DR

MacBook Neo (A18 Pro, 8GB RAM) รัน Local AI ได้จริงด้วย oMLX + Gemma 4 E2B แต่ต้องตั้งความหวังให้สมกับสเปก — ดีสำหรับ chat ทั่วไปและโค้ดง่ายๆ ไม่ใช่ทางเลือกแทน cloud AI สำหรับงานซับซ้อน

## Background / Why this matters

**MacBook Neo** เปิดตัวเดือนมีนาคม 2026 เป็น Mac รุ่นราคาประหยัดที่สุดของ Apple (เริ่มต้น $599) ขับเคลื่อนด้วย **A18 Pro chip** และ unified memory 8GB — สเปกเดียวกับ iPhone 16 Pro แต่ในรูปแบบ laptop

ในยุคที่ Local AI กลายเป็นของจริง คำถามที่หลายคนอยากรู้คือ: เครื่องระดับ entry-level อย่าง MacBook Neo รัน LLM ได้ดีแค่ไหน? ข้อดีคือ Apple Silicon มี unified memory architecture ที่ CPU/GPU ใช้ RAM ร่วมกัน ทำให้การ inference บน Mac ดีกว่า Windows ที่ต้องแยก VRAM ออกจาก system RAM

**ทำไม oMLX แทน LM Studio?**
LM Studio เป็นชื่อคุ้นเคย แต่มัน Electron-based (web app ห่อเป็น desktop) — หนักกว่าและกิน memory มากกว่า oMLX ที่เป็น native macOS app สร้างบน Apple MLX framework โดยตรง

## Deep Dive

### oMLX คืออะไร

**oMLX** เป็น inference engine สำหรับ Apple Silicon โดยเฉพาะ จุดเด่นหลักคือ **two-tier KV cache system**:

| Layer | Storage | หน้าที่ |
|-------|---------|---------|
| Hot cache | Unified memory | context ที่กำลังใช้งานอยู่ |
| Cold cache | SSD | context เก่าที่ยังไม่ลบ |

เวลาคุยยาว oMLX จะ page context เก่าออกไปที่ SSD แทนที่จะกินหน่วยความจำไปเรื่อยๆ เหมือน LM Studio ผลคือสามารถ multitask ได้ระหว่าง inference และ latency ต่ำกว่าเมื่อ context ยังสั้น

> จากการทดสอบด้วย Qwen3 35B 4-bit: oMLX ทำได้ ~47 tokens/sec vs LM Studio ~16 tokens/sec บน M2 MacBook Pro (มา: Stork.AI review)

### Gemma 4 E2B

**Gemma 4** คือ model family ล่าสุดจาก Google โมเดลที่เล็กที่สุดในตระกูลนี้คือ **E2B** (ประมาณ 2B active parameters) ซึ่งเหมาะกับเครื่องที่ RAM จำกัด ดาวน์โหลดได้ในรูปแบบ **GGUF** ผ่าน HuggingFace — format มาตรฐานสำหรับ quantized inference ที่รองรับโดย llama.cpp และเครื่องมือในกลุ่มเดียวกัน

Quantization เปลี่ยน model weights จาก 32-bit float → 4-bit หรือ 8-bit int ลด file size ลงมากพอให้รันบนเครื่อง consumer ได้ แลกกับ accuracy เล็กน้อย

### ผลทดสอบบน MacBook Neo (8GB)

สิ่งที่ทำได้น่าพอใจ:
- **Chat ทั่วไป** — คุยโต้ตอบได้ลื่น latency ต่ำรอบแรก
- **Snake game (Python)** — เขียน code พื้นฐานได้ถูกต้อง รวดเร็ว

ข้อจำกัดที่เจอ:
- **Follow-up context ช้าลง** — เมื่อ conversation ยาวขึ้น token generation ช้าลงเห็นได้ชัด (KV cache ต้อง page ข้อมูลกลับจาก SSD)
- **ไม่เหมาะกับงานซับซ้อน** — multi-file refactor, debug codebase ขนาดกลาง, หรือ context > 4K tokens เริ่มมีปัญหา

## User Guide (Step-by-Step)

### 1. ดาวน์โหลด oMLX

ไปที่ [omlx.ai](https://omlx.ai/) → ดาวน์โหลด macOS app → ติดตั้งตามปกติ (signed + notarized โดย Apple)

> ตรวจสอบเวอร์ชันล่าสุดและ system requirements ที่หน้าเว็บ — ต้องการ macOS และ Apple Silicon (M-series หรือ A-series)

### 2. ดาวน์โหลด Gemma 4 E2B GGUF

ค้นหาบน HuggingFace: `bartowski/google_gemma-4-E2B-it-GGUF` หรือ `ggml-org/gemma-4-E2B-it-GGUF`

```bash
# ใช้ huggingface-cli (ต้องติดตั้งก่อน: pip install huggingface_hub)
huggingface-cli download bartowski/google_gemma-4-E2B-it-GGUF \
  --include "*.Q4_K_M.gguf" \
  --local-dir ~/models/gemma4-e2b
```

Quantization ที่แนะนำสำหรับ 8GB RAM: **Q4_K_M** — balance ระหว่าง size และ quality

### 3. โหลด Model ใน oMLX

เปิด oMLX → เลือก model directory ที่ดาวน์โหลดไว้ → Start Server

oMLX เปิด local endpoint ที่ `http://localhost:PORT` ซึ่งรองรับ OpenAI-compatible API — ใช้กับ Cursor, Claude Code, หรือ client อื่นได้

### 4. ใช้งาน

- **Chat UI**: เปิด dashboard ใน oMLX โดยตรง
- **API**: เรียก `http://localhost:PORT/v1/chat/completions` ผ่าน code หรือ client ใดก็ได้

## Caveats / Limits

- **8GB RAM = constraint จริง**: Gemma 4 E2B Q4_K_M ใช้ประมาณ 1.5–2GB สำหรับ model weights + KV cache buffer ทำให้ได้ context window จำกัด ถ้าโหลด model ขนาดใหญ่กว่า system อาจ swap จน latency พุ่ง
- **Follow-up context ช้า**: เป็นลักษณะของ SSD paging ไม่ใช่ bug — ใครที่ต้องการ long conversation แบบ real-time ควรพิจารณา cloud หรือเครื่องที่ RAM มากกว่า
- **ไม่เหมาะกับงานโค้ดขนาดใหญ่**: ถ้าต้องการ refactor หลาย file หรือ debug complex codebase Gemma 4 E2B มี capacity จำกัดกว่า GPT-4 / Claude มาก
- **oMLX stability**: มีรายงาน context overflow error บางครั้ง ต่างจาก LM Studio ที่ stable กว่าแต่ช้ากว่า
- **Gemma 4 E2B ≠ Gemma 4 2B**: ชื่อจริงคือ E2B (Efficient 2B) ระวังสับสนกับ Gemma 2 รุ่น 2B ซึ่งเป็น model generation ก่อนหน้า

## References

1. [oMLX — LLM inference, optimized for your Mac](https://omlx.ai/)
2. [oMLX Review: The Ultimate AI Model Runner for Apple Silicon Macs — Stork.AI](https://www.stork.ai/blog/omlx-the-ai-tool-unlocking-your-mac)
3. [MacBook Neo — Apple](https://www.apple.com/macbook-neo/)
4. [Say hello to MacBook Neo — Apple Newsroom](https://www.apple.com/newsroom/2026/03/say-hello-to-macbook-neo/)
5. [bartowski/google_gemma-4-E2B-it-GGUF — HuggingFace](https://huggingface.co/bartowski/google_gemma-4-E2B-it-GGUF)
6. [ggml-org/gemma-4-E2B-it-GGUF — HuggingFace](https://huggingface.co/ggml-org/gemma-4-E2B-it-GGUF)
7. [ทดสอบรัน Local AI บน MacBook Neo — YouTube](https://youtu.be/kKKPq_uj0m0)
8. [Apple MacBook Neo 13-inch (2026) — Amazon](https://www.amazon.com/Apple-2026-MacBook-13-inch-Laptop/dp/B0GR6FHGXX)

## Key Takeaways

- MacBook Neo (A18 Pro, 8GB) รัน Local AI ได้จริงด้วย oMLX + Gemma 4 E2B Q4_K_M — ไม่ใช่ไปไม่ถึง
- oMLX เหมาะกับ Apple Silicon กว่า LM Studio เพราะเป็น native app + two-tier KV cache ที่ page context เก่าไปยัง SSD
- ผลทดสอบ: chat ลื่น, code พื้นฐาน (เช่น Snake game) ทำได้ดี — แต่ follow-up context ยาวช้าลงเห็นได้ชัด
- ใช้แทน Google สำหรับ query ทั่วไปได้ — ไม่ต้องออนไลน์ ไม่มี tracking
- ไม่เหมาะกับ: งาน coding ซับซ้อน, context ขนาดใหญ่, multi-file reasoning
- Gemma 4 E2B = โมเดลที่เล็กที่สุดใน Gemma 4 family ชื่อ "E2B" ไม่ใช่ "2B" เหมือน Gemma 2
- ตั้งความหวังให้สมสเปก: 8GB เพียงพอสำหรับ light local inference ไม่ใช่ workstation AI
