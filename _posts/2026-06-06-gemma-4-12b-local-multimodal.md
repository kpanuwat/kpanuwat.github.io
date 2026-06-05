---
title: "Gemma 4 12B — โมเดล Multimodal รันบนเครื่องเล็กได้จริง"
date: 2026-06-05 00:01:00 +0700
categories: [Tools]
tags: [llm, gemma, local-ai, multimodal, ocr, open-source, mtp]
---

## TL;DR

Google เปิดตัว **Gemma 4 12B** เมื่อ 3 มิ.ย. 2026 — โมเดล open-weight (Apache 2.0) ที่รองรับ text, ภาพ, และเสียงโดยไม่ต้องใช้ encoder แยก รันได้บน MacBook หรือ Mac Mini 16GB RAM, และมีเทคโนโลยี **Multi-token Prediction (MTP)** ที่ช่วยเพิ่มความเร็ว decode ได้สูงสุด **3 เท่า** — เหมาะทำ OCR, จัดการอีเมล, หรืองาน local AI agent ส่วนตัว

## Background / Why This Matters

ปัญหาใหญ่ของ local AI คือ **ขนาด vs ประสิทธิภาพ**: โมเดลที่ทำงานได้ดีมักต้องการ RAM สูง 64–80GB ส่วนโมเดลที่รันบน 16GB มักเก่งแค่ text ไม่รองรับภาพหรือเสียง

Gemma 4 12B ตอบโจทย์ช่องว่างนี้โดยเฉพาะ — เป็นโมเดล dense 12B พารามิเตอร์ที่

- รันบน **RAM/VRAM 16GB** ที่ full 16-bit precision; ที่ 4-bit quantization ใช้แค่ **~8GB**
- รองรับ text + image + audio **โดยไม่มี encoder แยก** (ทำให้เร็วกว่าและน้ำหนักเบากว่า multimodal แบบเดิม)
- performance ใกล้เคียง **Gemma 4 26B MoE** ที่มีพารามิเตอร์รวมเกือบสองเท่า

Gemma family ก่อนหน้า (Gemma 3) ขนาดที่ใกล้เคียงคือ 12B dense และ 27B dense — แต่ไม่รองรับ multimodal native และยังขาด MTP ดังนั้น Gemma 4 12B คือ leap สำคัญสำหรับ on-device AI

## Deep Dive

### ตระกูล Gemma 4 — ใครเหมาะกับอะไร

| รุ่น | ขนาด | ประเภท | RAM (Ollama) | เหมาะกับ |
|------|------|--------|--------------|----------|
| E2B | 2B | Dense | 7.2 GB | Raspberry Pi, edge MCU |
| E4B | 4B | Dense | 9.6 GB | ≤ 8GB VRAM laptop (default Ollama) |
| **12B** | **12B** | **Dense, encoder-free** | **7.6 GB (4-bit)** | **Mac Mini 16GB, gaming laptop** |
| 26B | 26B total / 3.8B active | MoE | 18 GB | Workstation, M3 Pro 36GB+ |
| 31B | 31B | Dense | 20 GB | High-end workstation |

**12B vs 26B MoE**: ตาม Google official blog "delivers performance nearing the 26B MoE on standard benchmarks at less than half the total memory footprint"

### สถาปัตยกรรม Encoder-Free Multimodal

โมเดล multimodal ส่วนใหญ่ต่อ **vision encoder** (เช่น CLIP, SigLIP) แยกต่างหาก แล้วฉีด feature vector เข้า LLM backbone — ซึ่งเพิ่มน้ำหนักและ latency

Gemma 4 12B ตัดออกทั้งหมด:

**Vision** — ใช้ lightweight embedding module เล็กๆ (~35M พารามิเตอร์): single matrix multiplication + positional embedding + layer normalization แปลง image patches → tokens โดยตรง แล้วส่งเข้า LLM backbone เลย

**Audio** — ตัด audio encoder ออกทั้งหมด: raw 16 kHz waveform ถูก project เข้า token space เดียวกับ text โดยตรง

ผลลัพธ์: โมเดลเดียวที่จัดการ text/ภาพ/เสียงใน forward pass เดียว ไม่มีเส้นทาง encode แยก

### Multi-Token Prediction (MTP) — 3× Faster Decoding

การ decode LLM ปกติ: สร้างทีละ 1 token ต่อ forward pass → ช้า โดยเฉพาะ agentic workflow ที่มี tool-call หลายสิบรอบ

MTP ทำงานสองชั้น:

1. **Draft model** (lightweight): เดา token ล่วงหน้าหลายตัวพร้อมกัน
2. **Main model**: verify ทั้งหมดใน parallel pass เดียว — ถ้าตรง → accept ทีเดียว, ถ้าไม่ตรง → fallback token เดิม

ผล: throughput เพิ่มสูงสุด **3×** โดยที่ output quality เหมือนเดิมทุกบิต (ไม่ใช่ approximation)

MTP drafter สำหรับ Gemma 4 พร้อมใช้บน Ollama, HuggingFace Transformers, vLLM, SGLang, MLX

### Benchmarks

| Benchmark | Gemma 4 12B | Gemma 3 27B |
|-----------|-------------|-------------|
| DocVQA (document understanding) | ~94.9% | — |
| GPQA Diamond (graduate reasoning) | ~78.8% | — |
| BBEH (broad hard reasoning) | 53 | ~18 |
| LiveCodeBench (competitive coding) | 72 | — |

BBEH ที่กระโดดจาก ~18 → 53 คือสัญญาณที่ชัดเจนว่า reasoning ดีขึ้นมากอย่างไม่ proportional กับขนาด

## User Guide (Step-by-Step)

### 1. ติดตั้งผ่าน Ollama (วิธีเร็วที่สุด)

```bash
# ติดตั้ง Ollama ก่อน (ถ้ายังไม่มี)
# macOS: https://ollama.com/download
# หรือ via brew:
brew install ollama

# สำหรับ Mac M-series (Apple Silicon) — MLX-optimized
ollama pull gemma4:12b-mlx   # 10 GB

# สำหรับ Linux / Mac Intel / Windows (CUDA/Metal)
ollama pull gemma4:12b       # 7.6 GB
```

### 2. ทดสอบ Text Generation ก่อน

```bash
ollama run gemma4:12b "สรุปการทำงานของ Multi-token Prediction ในสองประโยค"
```

Expected: ได้คำตอบภายใน 5–10 วินาทีบน Mac Mini M2 16GB

### 3. Multimodal (Image → Text / OCR) ผ่าน API

Ollama expose REST API ที่ `localhost:11434` — ส่งภาพเป็น base64:

```bash
# เริ่ม server (ถ้า ollama run ยังไม่ทำงาน)
ollama serve &

# OCR: อ่าน text ในภาพ
IMAGE_B64=$(base64 -i /path/to/receipt.jpg)

curl http://localhost:11434/api/generate \
  -d "{
    \"model\": \"gemma4:12b\",
    \"prompt\": \"Read all text in this image. Output exactly what you see.\",
    \"images\": [\"$IMAGE_B64\"],
    \"stream\": false
  }"
```

Expected output: JSON field `"response"` มี text ที่ OCR ได้จากภาพ ความแม่นยำสูงบนเอกสารทั่วไป (DocVQA ~94.9%)

### 4. Email Triage / Summarization

```bash
ollama run gemma4:12b << 'EOF'
จัดกลุ่มอีเมลเหล่านี้เป็น: ด่วน / ตอบทีหลัง / ข้อมูลทั่วไป

Subject: Invoice #1234 due tomorrow
Subject: Team lunch next Friday
Subject: Critical production bug - payment API down
Subject: Newsletter: AI weekly digest
EOF
```

### 5. ใช้ Google AI Edge Gallery (GUI ไม่ต้องเขียน code)

สำหรับคนที่ไม่ต้องการ CLI — Google ออก **AI Edge Gallery** (มิ.ย. 2026) รองรับ macOS:

1. ดาวน์โหลดจาก [Google AI Edge](https://ai.google.dev/edge/gallery) (beta)
2. เลือก Gemma 4 12B จาก model list
3. ลาก-วางภาพเพื่อทำ OCR หรือพิมพ์ prompt โดยตรง

### 6. เปิดใช้ MTP ใน HuggingFace Transformers

```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model_id = "google/gemma-4-12B-it-assistant"
draft_id  = "google/gemma-4-12B-mtp-draft"  # MTP drafter

model     = AutoModelForCausalLM.from_pretrained(model_id)
assistant = AutoModelForCausalLM.from_pretrained(draft_id)

# ส่ง assistant_model เพื่อเปิด speculative decoding
outputs = model.generate(
    inputs,
    assistant_model=assistant,
    max_new_tokens=256,
)
```

### 7. Troubleshooting

| ปัญหา | สาเหตุ | แก้ไข |
|-------|--------|--------|
| OOM / crash | VRAM ไม่พอที่ full precision | ใช้ `gemma4:12b` (4-bit) แทน 16-bit |
| Decode ช้ามาก | MTP ยังไม่เปิด | เพิ่ม `assistant_model` (HF) หรือ upgrade Ollama ≥ latest |
| OCR ผิดพลาดสูง | ภาพความละเอียดต่ำ | resize ≥ 768px ก่อนส่ง; เพิ่ม visual token budget |
| Invoice parsing ผิด | structured doc extraction ยังไม่แม่น | ใช้ fine-tuned doc model หรือ LayoutLM ควบคู่ |

## Caveats / Limits

**Structured document extraction ยังไม่สมบูรณ์** — DocVQA ~94.9% คือ benchmark ทั่วไป แต่งานที่ต้องการ structured output จาก invoice เฉพาะทาง (เช่น แยก line items, รวม VAT, match vendor code) ยังพลาดได้บ่อย — ควรใช้ fine-tuned model หรือ LayoutLMv3 ควบคู่

**Quantization tradeoffs** — 4-bit (7.6GB) เร็วกว่าและใช้ RAM น้อยกว่า แต่อาจสูญเสีย nuance บนงาน reasoning ลึก; 8-bit (~13GB) balance ดีกว่าถ้ามี VRAM เหลือ

**ไม่ใช่ frontier reasoning model** — Gemma 4 12B เก่งมากสำหรับขนาด แต่สำหรับงานที่ต้องการ reasoning ระดับ PhD (GPQA Diamond 78.8% ดีแต่ยังต่ำกว่า Claude Opus หรือ GPT-4o) ควรจับคู่กับ cloud model

**Context window Ollama vs native** — Ollama default context สำหรับ `gemma4:12b` คือ 256K แต่ RAM ที่ใช้เพิ่มตาม context ยาว — สำหรับงาน OCR ปกติไม่ต้องกังวล

**License nuance** — Apache 2.0 อนุญาต commercial use, fine-tune, redistribute ได้อย่างเสรี แต่ยังมี [Gemma Prohibited Use Policy](https://ai.google.dev/gemma/terms) แยกที่ห้ามใช้สร้างเนื้อหาอันตราย

## References

1. [Introducing Gemma 4 12B: a unified, encoder-free multimodal model — blog.google](https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12b/)
2. [Accelerating Gemma 4: faster inference with multi-token prediction drafters — blog.google](https://blog.google/innovation-and-ai/technology/developers-tools/multi-token-prediction-gemma-4/)
3. [Gemma 4 MTP documentation — ai.google.dev](https://ai.google.dev/gemma/docs/mtp/mtp)
4. [Bringing Gemma 4 12B to your Laptop: Unlocking Local, Agentic Workflows — developers.googleblog.com](https://developers.googleblog.com/bringing-gemma-4-12b-to-your-laptop-unlocking-local-agentic-workflows-with-google-ai-edge/)
5. [Gemma 4 model overview — ai.google.dev](https://ai.google.dev/gemma/docs/core)
6. [google/gemma-4-12B-it-assistant — HuggingFace](https://huggingface.co/google/gemma-4-12B-it-assistant)
7. [gemma4 on Ollama library — ollama.com](https://ollama.com/library/gemma4)
8. [Google's new open source Gemma 4 12B analyzes audio, video — VentureBeat](https://venturebeat.com/technology/googles-new-open-source-gemma-4-12b-analyzes-audio-video-and-runs-entirely-locally-on-a-typical-16gb-enterprise-laptop)
9. [Google Found a Way to Make Local AI Up to 3x Faster — Decrypt](https://decrypt.co/367095/google-make-local-ai-3x-faster-no-new-hardware)
10. [Source video — YouTube](https://youtu.be/PDxKrp-dTDA)

## Key Takeaways

- **Gemma 4 12B** (Apache 2.0) รันได้บน 16GB RAM — text, ภาพ, เสียง ในโมเดลเดียว ไม่ต้องมี encoder แยก
- **Encoder-free design**: vision ~35M module + raw audio projection แทน CLIP/SigLIP → เบาและเร็วกว่า
- **MTP drafters** เพิ่ม decode speed สูงสุด 3× โดยไม่กระทบ output quality — สำคัญมากสำหรับ agentic loop ที่มีหลาย tool-call
- Performance ใกล้เคียง **26B MoE** ที่ใช้ RAM เกือบ 2.5× — 12B คุ้มค่าสุดสำหรับเครื่องส่วนตัว
- รัน Ollama: `ollama pull gemma4:12b` (7.6GB) หรือ `gemma4:12b-mlx` (Apple Silicon, 10GB)
- **OCR ทั่วไปทำได้ดี** (DocVQA ~94.9%) แต่ invoice/structured doc extraction ยังไม่สมบูรณ์ — ควรใช้ fine-tuned model เสริม
- Open-weight + Apache 2.0 = fine-tune ได้, ใช้ commercial ได้ — เหมาะสำหรับงาน privacy-sensitive ที่ไม่ต้องการส่งข้อมูลออก cloud
