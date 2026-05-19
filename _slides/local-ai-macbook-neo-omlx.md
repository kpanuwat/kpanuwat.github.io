---
marp: true
theme: default
paginate: true
---

# ทดสอบรัน Local AI บน MacBook Neo ด้วย oMLX

**MacBook Neo 8GB + oMLX + Gemma 4 E2B = Local AI ที่รันได้จริง**

---

## TL;DR

- MacBook Neo (A18 Pro, 8GB) รัน Local AI ได้จริง — ไม่ใช่ไปไม่ถึง
- ใช้ **oMLX** แทน LM Studio: native macOS, เบากว่า, เร็วกว่า ~3x
- โมเดล **Gemma 4 E2B** (GGUF Q4_K_M) เหมาะกับ 8GB RAM
- ดีสำหรับ chat / query ทั่วไป — ไม่ใช่แทน cloud AI สำหรับงานซับซ้อน

---

## MacBook Neo: ทำไมถึงลอง Local AI?

- เปิดตัว **มีนาคม 2026** — Mac ราคาประหยัดที่สุด เริ่มต้น $599
- ขับเคลื่อนด้วย **A18 Pro chip** (เดียวกับ iPhone 16 Pro)
- **8GB Unified Memory** — CPU + GPU ใช้ RAM ร่วมกัน
- Apple Silicon ได้เปรียบ Windows: ไม่ต้องแยก VRAM ออกจาก system RAM

---

## ทำไม oMLX แทน LM Studio?

| | oMLX | LM Studio |
|---|---|---|
| App type | Native macOS | Electron (web app) |
| Speed | ~47 tokens/sec | ~16 tokens/sec |
| Memory | KV cache paging to SSD | ถือ context ใน RAM ทั้งหมด |
| Stability | ดี (บาง overflow errors) | Stable กว่า |

> ทดสอบด้วย Qwen3 35B 4-bit บน M2 MacBook Pro (Stork.AI)

---

## oMLX: Two-Tier KV Cache

**จุดเด่นหลัก** — บริหาร context แบบ 2 ชั้น:

| Layer | Storage | หน้าที่ |
|-------|---------|---------|
| Hot cache | Unified memory | context ที่กำลังใช้งานอยู่ |
| Cold cache | SSD | context เก่าที่ยัง page ไว้ |

- เมื่อ conversation ยาว → page context เก่าออก SSD อัตโนมัติ
- ผล: multitask ได้ระหว่าง inference, latency ต่ำช่วง context สั้น

---

## Gemma 4 E2B คืออะไร?

- **Gemma 4** = model family ล่าสุดจาก Google (2025)
- **E2B** = โมเดลที่เล็กที่สุดในตระกูล (~2B active parameters)
- ดาวน์โหลดในรูปแบบ **GGUF** จาก HuggingFace
- Quantization **Q4_K_M** — balance ระหว่าง size และ quality, เหมาะ 8GB RAM
- ⚠️ E2B ≠ Gemma 2 (2B) — คนละ generation อย่าสับสน

---

## ผลทดสอบบน MacBook Neo (8GB)

✅ **ทำได้น่าพอใจ**
- Chat ทั่วไป — latency ต่ำ โต้ตอบลื่น
- Snake game (Python) — เขียน code พื้นฐานได้ถูกต้อง รวดเร็ว

❌ **ข้อจำกัดที่เจอ**
- Follow-up context ช้าลงเห็นได้ชัด (SSD paging กลับมา)
- งานซับซ้อน (multi-file, context > 4K tokens) เริ่มมีปัญหา

---

## Step 1–2: ติดตั้ง

**1. ดาวน์โหลด oMLX**
→ [omlx.ai](https://omlx.ai/) → ดาวน์โหลด → ติดตั้ง (signed + notarized)

**2. ดาวน์โหลด Gemma 4 E2B GGUF**

```bash
huggingface-cli download bartowski/google_gemma-4-E2B-it-GGUF \
  --include "*.Q4_K_M.gguf" \
  --local-dir ~/models/gemma4-e2b
```

> ต้องติดตั้ง `huggingface_hub` ก่อน: `pip install huggingface_hub`

---

## Step 3–4: ใช้งาน

**3. โหลด Model ใน oMLX**
→ เปิด oMLX → เลือก model directory → Start Server

**4. ใช้งาน**
- **Chat UI**: dashboard ใน oMLX โดยตรง
- **API**: `http://localhost:PORT/v1/chat/completions`
- รองรับ OpenAI-compatible API → ใช้กับ Cursor, Claude Code ได้

---

## Caveats / Limits

- **8GB = จำกัดจริง** — Q4_K_M ใช้ ~1.5–2GB; โมเดลใหญ่กว่านี้ swap → latency พุ่ง
- **Follow-up context ช้า** — SSD paging ทำให้ long conversation ไม่ real-time
- **ไม่แทน cloud AI** — multi-file refactor, debug codebase ใหญ่ ยังต้องพึ่ง GPT-4/Claude
- **oMLX stability** — context overflow เกิดได้บางครั้ง

---

## Key Takeaways

- MacBook Neo 8GB รัน Local AI ได้จริง — ด้วย oMLX + Gemma 4 E2B
- oMLX เร็วกว่า LM Studio ~3x เพราะ native + KV cache paging
- ใช้แทน Google / chat ทั่วไปได้ดี — offline, ไม่มี tracking
- ไม่เหมาะกับ: งาน coding ซับซ้อน, context ใหญ่, multi-file reasoning
- **ตั้งความหวังให้สมสเปก** — 8GB = light inference, ไม่ใช่ workstation AI
