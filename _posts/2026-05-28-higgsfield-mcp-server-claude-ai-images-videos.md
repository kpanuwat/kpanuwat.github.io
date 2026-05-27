---
title: "ติดตั้ง Higgsfield MCP Server ใน Claude: สร้าง AI Images & Videos แบบ Agentic"
date: 2026-05-27 00:12:00 +0700
categories: [Tools]
tags: [mcp, claude, ai-image, ai-video, higgsfield, agentic]
---

## TL;DR

**Higgsfield MCP Server** คือ connector ที่เชื่อม Claude เข้ากับระบบสร้าง AI image และ video ระดับ cinematic ผ่าน MCP (Model Context Protocol) — ติดตั้งครั้งเดียว ไม่ต้องใช้ API key หลายตัว และเปิดให้ Claude ทำงานแบบ agentic ได้ตั้งแต่สร้าง เปรียบเทียบ ไปจนถึงแก้ไขสื่อโฆษณาโดยอัตโนมัติ มี free tier 150 credits/เดือน

---

## Background / Why this matters

ก่อนที่ MCP จะเกิดขึ้น การสร้าง AI video/image สำหรับ content creator หรือทีม marketing มักหมายความว่าต้องเปิดหลายแท็บพร้อมกัน: อีกแท็บหนึ่งสำหรับ Runway, อีกแท็บสำหรับ Kling, อีกแท็บสำหรับ Midjourney — แต่ละ platform มี API key, credit system, และ UX เป็นของตัวเอง

**Higgsfield AI** เปิดตัว MCP Server เมื่อ April 30, 2026 โดยแก้ปัญหานี้ตรงๆ: แทนที่จะให้ผู้ใช้สลับ tool ด้วยตัวเอง ก็ให้ Claude เป็นตัวกลาง orchestrate ทุกอย่างแทน ผ่าน Model Context Protocol ซึ่งเป็น open standard ที่ Anthropic สร้างขึ้นเพื่อให้ AI agent เรียกใช้ external tools ได้อย่างปลอดภัย

ผลที่ได้คือสามารถพิมพ์ใน Claude ว่า _"สร้าง ad video สำหรับผลิตภัณฑ์นี้ เปรียบเทียบ 3 โมเดล แล้วเลือกตัวที่ดีที่สุด"_ แล้ว Claude จะจัดการทุกขั้นตอนเองโดยไม่ต้องออกจาก conversation

---

## Deep Dive

### Architecture: MCP Bridge Pattern

Higgsfield MCP ทำงานผ่าน 3 ชั้น:

```
[Claude] ──prompt──▶ [MCP Bridge] ──API call──▶ [Higgsfield Server]
   ◀──asset returned──              ◀──rendered media──  ◀── 30+ AI Models
```

1. **Intent Translation** — Claude รับ prompt ภาษาธรรมชาติ (หรือ input เป็น image/sketch/audio) แล้วแปลงเป็น structured parameters เช่น camera move, aspect ratio, frame rate
2. **Secure Bridging** — MCP server ทำหน้าที่เป็น secure proxy: account credentials ของ Higgsfield อยู่ฝั่ง Higgsfield เสมอ — Claude ไม่เห็น API key
3. **Execution & Delivery** — Higgsfield infrastructure render media, sync audio, maintain character consistency แล้วส่ง asset กลับเข้า Claude chat โดยตรง; ไฟล์ทั้งหมดบันทึกไว้ใน Higgsfield workspace ด้วย

### Models ที่ใช้ได้ (30+ รุ่น)

**Video Models:**

| Model | หมายเหตุ |
|-------|----------|
| Veo 3 / 3.1 (Google) | high-fidelity cinematic |
| Sora 2 (OpenAI) | long-form coherence |
| Kling 3.0 / 2.6 Turbo | ความเร็วสูง |
| Seedance 2.0 | motion quality ดีมาก |
| Wan 2.5 / 2.6 | open-weight, cost-efficient |
| MiniMax Hailuo | lip-sync support |
| Soul / Soul Cinema / Cinema Studio | proprietary Higgsfield models |

**Image Models:**

| Model | หมายเหตุ |
|-------|----------|
| Soul 2.0 | character consistency |
| Nano Banana Pro | credit-efficient |
| Flux 2.0 | photorealism |
| Seedream 4.5 / 5.0 | stylized |
| GPT Image 2 | OpenAI Hazel integration |

### Tools ที่ Claude เรียกได้

```
generate_image        → text-to-image (16+ models)
generate_video        → image-to-video / text-to-video
create_character      → train reusable character reference
get_generation_status → poll job progress (async)
list_characters       → manage saved characters
```

นอกจากนี้ยังมี Marketing Studio tools: avatar generation, product placement, brand kit presets, virality predictor (engagement score)

---

## User Guide (Step-by-Step)

### ติดตั้งใน Claude Desktop / claude.ai

1. เปิด Claude Desktop หรือ [claude.ai](https://claude.ai) → **Settings → Connectors**
2. กด **Add custom connector**
3. ตั้งชื่อ `Higgsfield`
4. ใส่ URL: `https://mcp.higgsfield.ai/mcp`
5. กด **Connect** → ระบบ redirect ไป Higgsfield สำหรับ OAuth login (ครั้งเดียว)
6. อนุมัติ access → connector พร้อมใช้งาน
7. (Optional) เลือก **Always Allow** เพื่อข้าม approval prompt ทุกครั้ง

### ติดตั้งใน Claude Code (CLI)

```bash
claude mcp add --transport http --scope user higgsfield https://mcp.higgsfield.ai/mcp
```

- `--scope user` → เขียนไปที่ `~/.claude/mcp.json` (ใช้ได้ทุก project)
- `--scope project` → เขียนไปที่ `.mcp.json` ที่ root repo (share กับทีมได้)

ตรวจสอบว่าติดตั้งสำเร็จ:

```bash
claude mcp list
# ควรเห็น: higgsfield  https://mcp.higgsfield.ai/mcp
```

หรือพิมพ์ `/mcp` ใน Claude Code session เพื่อดู connector status

### First generation

เปิด chat ใหม่แล้วลองพิมพ์:

```
สร้างภาพ product shot ของกาแฟ dark roast บนโต๊ะไม้สไตล์ Japanese minimalist
ใช้โมเดล Soul 2.0 ความละเอียด 1024x1024
```

Claude จะเรียก `generate_image` tool, ส่ง request ไป Higgsfield, แล้ว return ภาพใน chat โดยตรง

### Agentic Workflow ขั้นสูง

**Multi-model showdown:**
```
สร้าง video clip 5 วินาทีจากภาพนี้ โดยรัน 3 โมเดลพร้อมกัน: Veo 3.1, Kling 3.0, Seedance 2.0
แล้วเลือกตัวที่ motion quality ดีที่สุดให้ฉัน
```

**Full production pipeline:**
```
1. Train character จากรูปภาพ 3 รูปที่แนบมา
2. สร้าง 6-shot product reel สำหรับ TikTok (9:16)
3. ใช้ UGC preset
4. แนะนำ caption และ hashtag
```

**Feedback loop:**
```
วิดีโอที่ได้ดีมาก แต่ต้องการให้ตัวละครเดินช้าลง 30% และ tone สีอุ่นขึ้น
ปรับแล้ว re-generate
```

---

## Caveats / Limits

**Free tier (150 credits/เดือน):**
- เฉพาะ selected models (ไม่ใช่ทุกโมเดล) — Nano Banana Pro และ Soul V2 มักรวมอยู่ใน free
- Output มี watermark
- Parallel limit: 1 video + 1 image พร้อมกัน
- ≈ $1 = 16 credits เมื่อซื้อเพิ่ม

**OAuth token:**
- Expire เป็นระยะ → ต้อง re-authenticate ผ่าน `/mcp` panel
- ใช้ใน CI / headless environment ไม่ได้ — สำหรับกรณีนั้น ให้ใช้ [Higgsfield CLI](https://higgsfield.ai/cli) แทน

**Credit system:**
- Credits ไม่มี cash value และหมดอายุเมื่อยกเลิก account
- Refund ได้ภายใน 7 วันหลังซื้อครั้งแรก (ถ้ายังไม่ได้ใช้ credits)

**Model availability:**
- โมเดลบางตัว (เช่น Sora 2, Veo 3.1) อาจต้องการ plan ระดับ Plus ขึ้นไป
- Model lineup เปลี่ยนได้ตลอด — ตรวจสอบที่ [higgsfield.ai/mcp](https://higgsfield.ai/mcp)

---

## References

1. [Higgsfield MCP Official Page](https://higgsfield.ai/mcp) — tool list, supported agents, MCP URL
2. [Generate AI Videos From Claude — Higgsfield Blog](https://higgsfield.ai/blog/Generate-AI-Videos-From-Claude-with-Higgsfield-MCP) — installation steps, model list, workflow examples
3. [Higgsfield MCP for Claude Code: 60-Second Setup — TECHSY](https://techsy.io/en/blog/higgsfield-mcp-claude-code) — Claude Code CLI command, OAuth notes, free tier credits
4. [Higgsfield AI Pricing Plans](https://geo.higgsfield.ai/task/blog/higgsfield-ai-pricing-plans) — credit amounts, plan features, refund policy
5. [Claude Just Got a Superpower No One's Talking About — YouTube](https://youtu.be/rrylSizvnSg) — demo video: agentic workflow in action
6. [GitHub: jfikrat/higgsfield-mcp](https://github.com/jfikrat/higgsfield-mcp) — open-source MCP implementation

---

## Key Takeaways

- **Higgsfield MCP** เปลี่ยน Claude จาก text assistant เป็น full media production orchestrator — พิมพ์ brief ครั้งเดียว ได้งานครบวงจร
- **ไม่ต้องใช้ API key** — auth ผ่าน OAuth; credentials ไม่โดน expose ใน Claude context
- **30+ โมเดล** ใน tool เดียว: Veo, Sora, Kling, Seedance, Flux, Soul และอีกมาก
- **Agentic power** มาจาก async polling (`get_generation_status`) + multi-call chain — Claude รอ job เสร็จแล้วทำต่อได้เองโดยไม่ต้องกลับมาถาม
- **Free tier 150 credits/เดือน** เหมาะสำหรับ prototype และทดสอบ workflow — ใช้ Nano Banana Pro / Soul V2 เพื่อยืดงบ
- **Claude Code user** ใช้ `claude mcp add --transport http --scope user higgsfield https://mcp.higgsfield.ai/mcp` — ตั้งค่าใน 1 คำสั่ง
- สำหรับ **production automation** ที่ไม่มี UI ให้ใช้ Higgsfield CLI แทน (ไม่ require OAuth interactive flow)
