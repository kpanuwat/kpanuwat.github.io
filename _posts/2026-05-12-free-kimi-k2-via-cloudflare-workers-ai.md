---
title: "Free Kimi K2.6 API via Cloudflare Workers AI"
date: 2026-05-12 00:00:00 +0700
categories: [Tools]
tags: [cloudflare, llm, api, kimi, free-tier]
slides: true
---

{% include slide-link.html %}

## TL;DR

Cloudflare Workers AI ให้ใช้ Kimi K2.6 ฟรี 10,000 requests/day ผ่าน API — สมัคร Cloudflare account → copy Account ID + สร้าง API Token → เชื่อมกับ tool ที่รองรับ OpenAI-compatible endpoint ได้เลย

## Kimi K2.6 คืออะไร

Kimi K2.6 เป็น open-source LLM จาก Moonshot AI ที่มีประสิทธิภาพเทียบเคียง GPT-4o และ Gemini Pro เหมาะสำหรับงาน coding, reasoning, และการสร้าง content โดยที่ Cloudflare นำมาให้บริการผ่าน Workers AI infrastructure ของตัวเอง

## วิธีเปิดใช้งาน

**1. สมัครบัญชี Cloudflare**

ไปที่ [cloudflare.com](https://cloudflare.com) และสมัครบัญชีฟรี

**2. ดึง Account ID และสร้าง API Token**

- เข้าเมนู **AI → Workers AI**
- คัดลอก **Account ID** (อยู่ด้านขวาของหน้า)
- กด **Create API Token** → เลือก template "Cloudflare Workers AI" → สร้าง token → คัดลอกไว้

**3. เชื่อมต่อกับ tool**

ตัวอย่างกับ Open Code AI:

```bash
/connect
# เลือก provider: Cloudflare Workers AI
# ใส่ Account ID และ API Token
# เลือกโมเดล: @cf/moonshot/kimi-k2-6
```

ตัวอย่าง curl ตรงๆ:

```bash
curl https://api.cloudflare.com/client/v4/accounts/{ACCOUNT_ID}/ai/run/@cf/moonshot/kimi-k2-6 \
  -H "Authorization: Bearer {API_TOKEN}" \
  -d '{"messages": [{"role": "user", "content": "Hello"}]}'
```

## ข้อจำกัด Free Tier

| ข้อมูล | ค่า |
|--------|-----|
| Requests/day | 10,000 |
| Model | `@cf/moonshot/kimi-k2-6` |
| Compatibility | OpenAI-compatible API |
| Cost | ฟรี (Workers AI free plan) |

## Key Takeaways

- Cloudflare Workers AI เป็น gateway ที่ดีสำหรับทดลอง LLM โดยไม่เสียค่าใช้จ่าย
- Kimi K2.6 รองรับ OpenAI API format → ต่อกับ tool ส่วนใหญ่ได้ทันที
- 10,000 req/day เพียงพอสำหรับงาน personal/side project
- ดูวิธีตั้งค่าเพิ่มเติมได้ที่ [วิดีโอนี้](https://youtu.be/sKybySSMIY4)
