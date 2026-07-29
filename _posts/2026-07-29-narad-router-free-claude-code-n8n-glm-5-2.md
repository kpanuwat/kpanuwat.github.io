---
title: "เจาะลึก NaraRouter: ใช้ Claude Code และ n8n ฟรี 7 ล้าน Token/วัน จริงหรือมีอะไรซ่อนอยู่?"
date: 2026-07-28 00:02:00 +0700
categories: [Tools]
tags: [claude-code, n8n, llm-gateway, api, free-tier]
slides: true
---

{% include slide-link.html %}

## TL;DR

มีคลิปและกระแสบอกว่าใช้ **Claude Code** และ **n8n** ฟรีได้วันละ 7 ล้าน token ผ่านบริการชื่อ "Narad/Nara Router" (สมัครด้วย Google + ยืนยัน Telegram แล้วต่อกับ GLM 5.2) — ตรวจสอบกับ source จริงแล้วพบว่า **โควตาฟรี 7M token/วันมีจริง** แต่ **GLM 5.2 ไม่ได้อยู่ใน model list ของบริการนี้เลย** และ **ไม่มีขั้นตอน Google/Telegram verification ตามที่เข้าใจกัน** — ที่สำคัญกว่านั้น Anthropic เองระบุชัดว่าไม่รับรอง (endorse) gateway บุคคลที่สามใดๆ ทั้งสิ้น

## Background / Why this matters

กระแส "ใช้ Claude Code ฟรี" ผ่าน third-party router/gateway เป็นเทรนด์ที่มาพร้อมคลิป YouTube จำนวนมาก โดยมากอ้างตัวเลข token quota ที่ฟังดูดีเกินจริง (5M, 7M token/วันแบบไม่ต้องผูกบัตรเครดิต) ประเด็นคือ Claude Code เป็นเครื่องมือที่พ่วงกับ workflow การเขียนโค้ดจริง — โค้ด, prompt, และบางครั้งแม้แต่ secret/config ของโปรเจกต์ จะไหลผ่าน server ของ third-party นั้นทั้งหมดถ้าตั้งค่า `ANTHROPIC_BASE_URL` ไปชี้ที่ router

บทความนี้เจาะลึก **NaraRouter** (`router.bynara.id`) ซึ่งเป็นบริการที่ถูกพูดถึงในบริบทนี้ — แยกให้ชัดว่าอะไรคือ fact ที่ตรวจสอบได้จริงจากตัวเว็บไซต์ อะไรคือคำกล่าวอ้างที่มาจากคลิปสอนเท่านั้นแต่หา source ยืนยันไม่ได้ และมีความเสี่ยงอะไรบ้างที่ต้องรู้ก่อนเอา credential ของบัญชีจริงไปผูกกับบริการแบบนี้

## Deep Dive

### NaraRouter คืออะไรจริงๆ

NaraRouter เป็น "unified AI gateway" — proxy ที่รวม API หลายผู้ให้บริการ (Claude, GPT, Gemini, DeepSeek, Meta และอื่นๆ) ไว้หลัง endpoint เดียว โดยเปิด endpoint สองแบบให้ compatible กับ SDK ที่มีอยู่แล้ว:

- OpenAI-compatible: `/v1/chat/completions`
- Anthropic-compatible: `/v1/messages`

Base URL: `https://router.bynara.id/v1` — API key format `sk-nara-xxxx` [1]

### Onboarding ที่ระบุไว้จริงบนเว็บไซต์ (3 ขั้นตอน)

1. **Sign Up & Generate an API Key** — "Create an account in seconds", "Generate an API key from the dashboard", "Free tier quota is active instantly" [1]
2. **Set Up Your Favorite Tool** — วาง Base URL + API key ลงในเครื่องมือที่ใช้อยู่แล้ว [1]
3. **Start Building** — ใช้โมเดลผ่าน endpoint เดียว [1]

**ไม่มีขั้นตอน sign-in ด้วย Google account หรือ verification ผ่าน Telegram ปรากฏอยู่ในเนื้อหาที่ดึงมาจากเว็บไซต์จริง** — ลิงก์ Telegram (`t.me/bynara_ai`) ที่พบมีไว้เป็นช่องทาง support/ติดต่อเท่านั้น ไม่ใช่ auth flow [1]

### Pricing tier ที่ระบุจริง

| Tier | ราคา | Token cap/วัน | Rate limit |
|------|------|--------------|------------|
| Free | Rp 0 | 7M | 10 req/min |
| Mimo Lite | Rp 10K/วัน | 12M | 50 req/min |
| Deepseek Lite | Rp 12K/วัน | 11M | 50 req/min |
| Mimo Plus | Rp 15K/วัน | 17M | 50 req/min |
| Deepseek Plus | Rp 17K/วัน | 16M | 50 req/min |
| Mimo Pro | Rp 18K/วัน | 20M | 50 req/min |
| Deepseek Pro | Rp 20K/วัน | 19M | 50 req/min |
| GPT Fams | Rp 40K/วัน | 25M | 60 req/min |
| Deepseek Fams Alibaba | Rp 66K/วัน | 15M | 60 req/min |

[2] — ราคาเป็น Rupiah อินโดนีเซีย (โดเมน `.id`) บ่งชี้ว่านี่คือบริการระดับ personal/regional ไม่ใช่ enterprise-grade gateway ที่มีทีม compliance รองรับ

### แล้ว GLM 5.2 อยู่ตรงไหน?

**ไม่อยู่เลย.** Model list ที่ระบุไว้บนเว็บไซต์ NaraRouter คือ Agnes 2.0/2.5 Flash, Mistral Large/Medium 3.5, Nemotron Ultra [1][2] — Zhipu AI (ผู้พัฒนา GLM) ปรากฏเพียงในฐานะโลโก้ "supported provider" แต่ไม่มี GLM 5.2 ในรายการโมเดลจริงทั้ง free และ paid tier

GLM 5.2 เองเป็นโมเดลจริง เปิดตัวโดย Z.ai เมื่อ 2026-06-16 — open-weight, MIT license, 753B parameter, context window 1M token, output สูงสุด 128K token, ใช้สถาปัตยกรรม IndexShare ที่ลด FLOPs ต่อ token ลง 2.9x ที่ context 1M [3][4] ราคา API อย่างเป็นทางการจาก Z.ai คือ $1.40 / 1M input token และ $4.40 / 1M output token — ดังนั้นถ้าอยากใช้ GLM 5.2 จริงๆ ต้องต่อ API ตรงกับ Z.ai หรือผ่าน provider ที่ระบุรองรับโมเดลนี้จริง ไม่ใช่ NaraRouter

**สรุป:** คำกล่าวอ้าง "GLM 5.2 ฟรีผ่าน NaraRouter" ในคลิปสอนต่างๆ ไม่มี source ยืนยันได้จากตัวบริการเอง — น่าจะเป็นความเข้าใจผิดหรือ hype จากผู้ทำคลิป ไม่ใช่ fact จากผู้ให้บริการ

## User Guide (Step-by-Step)

ส่วนนี้ครอบคลุมเฉพาะสิ่งที่ตรวจสอบได้จริง — ไม่รวมส่วนที่หา source ยืนยันไม่ได้ (GLM 5.2, Google/Telegram auth)

### 1. สมัครและสร้าง API key

ตามที่ระบุบนเว็บไซต์: สร้างบัญชี → generate API key จาก dashboard → free tier quota ใช้งานได้ทันที [1] (ไม่มีเอกสารยืนยันขั้นตอน Google sign-in หรือ Telegram verification)

### 2. ต่อกับ Claude Code — ทำตาม official Anthropic docs ไม่ใช่ตาม NaraRouter

Claude Code รองรับการชี้ไปที่ gateway ใดๆ ผ่าน environment variable `ANTHROPIC_BASE_URL` และ credential variable หนึ่งในสองแบบ: `ANTHROPIC_AUTH_TOKEN` (ถ้า gateway บอกว่าเป็น bearer token) หรือ `ANTHROPIC_API_KEY` (ถ้าเป็น x-api-key) [5]

**ตั้งค่าแบบ shell (ทดสอบก่อน):**

```bash
export ANTHROPIC_BASE_URL=https://router.bynara.id/v1
export ANTHROPIC_AUTH_TOKEN=sk-nara-xxxx
```

**ตั้งค่าถาวรใน settings file** — ใช้ `env` block ตาม schema เดียวกันทั้ง user-level และ project-level:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://router.bynara.id/v1",
    "ANTHROPIC_AUTH_TOKEN": "sk-nara-xxxx"
  }
}
```

**⚠️ สำคัญ — ตำแหน่งไฟล์ที่ควรใช้จริง:** เอกสาร Anthropic เตือนตรงๆ ว่า **ห้ามใส่ credential ใน project-level `.claude/settings.json`** เพราะไฟล์นี้ถูก commit และแชร์กับทุกคนที่ clone repo — ให้ใส่ที่ `~/.claude/settings.json` (user-level, apply ทุกโปรเจกต์) หรือ `.claude/settings.local.json` (project-level แต่ไม่ถูก commit, Claude Code auto-gitignore ให้) แทน [5]

ตรวจสอบว่าเชื่อมสำเร็จด้วย `/status` ใน Claude Code — ต้องเห็นบรรทัด `Anthropic base URL` ชี้ไปที่ router และบรรทัด `Auth token`/`API key` ยืนยันว่า credential ทำงาน [5]

### 3. ต่อกับ n8n

n8n รองรับการเรียก API ภายนอกผ่าน **HTTP Request node** ได้เสมอ (generic, ใช้ endpoint ใดก็ได้รวมถึง `router.bynara.id/v1/chat/completions`) แต่ **OpenAI credential type ที่ built-in ของ n8n ตามเอกสารทางการมีแค่ฟิลด์ API Key กับ Organization ID เท่านั้น ไม่มีฟิลด์ Base URL ให้ override** [6] — หมายความว่าการต่อ NaraRouter ผ่าน n8n's native OpenAI node ไม่ใช่ configuration ที่มีเอกสารรองรับอย่างเป็นทางการ ถ้าจะทำจริงต้องใช้ HTTP Request node ตรงๆ

## Caveats / Limits

- **Anthropic ไม่รับรอง third-party gateway ใดๆ ทั้งสิ้น** — คำพูดตรงจากเอกสารทางการ: *"Anthropic doesn't endorse, maintain, or audit third-party gateway products, and doesn't support routing Claude Code to non-Claude models through any gateway."* [5] เนื่องจาก NaraRouter free tier ไม่มี Claude model ให้ใช้เลย (มีแต่ Mistral/Nemotron/Agnes) การต่อ Claude Code เข้ากับ router นี้เพื่อยิงไปยังโมเดลที่ไม่ใช่ Claude คือ use case ที่ Anthropic ระบุชัดว่าไม่ support
- **Data privacy ไม่ชัดเจน** — เนื้อหาที่ดึงมาจากเว็บไซต์ไม่มีการระบุ data retention/privacy policy สำหรับ prompt ที่ส่งผ่าน router; โค้ดและ prompt ทั้งหมดไหลผ่าน server ของผู้ให้บริการที่ไม่มีข้อมูลบริษัท/ทีมงานเปิดเผยชัดเจน
- **Security signal ที่ไม่ตรงกัน** — third-party scanner (Sur.ly) ระบุว่า *"Router.bynara.id has not yet implemented SSL encryption"* แต่ก็ระบุด้วยว่า *"most likely does not offer any malicious content"* [7] — ข้อมูลนี้ขัดกับข้อเท็จจริงที่ตัวเว็บไซต์เข้าถึงได้ผ่าน `https://` จริง จึงควรมองเป็นสัญญาณเตือนที่ยัง unverified มากกว่าฟันธง แต่ก็เป็นเหตุผลให้ระวังก่อนผูก credential จริง
- **Fair-use policy คลุมเครือ** — เอกสารระบุว่า "Each plan includes a generous monthly credit grant under a fair-use policy" [1] โดยไม่นิยามตัวเลขชัดเจนว่า "generous" คือเท่าไหร่ และ "ถ้ายกเลิก request กลางทางอาจยังถูกคิด token เต็มจำนวน" [1]
- **บริการฟรีลักษณะนี้ไม่ยั่งยืนโดยธรรมชาติ** — โมเดลธุรกิจของ router ที่แจก 7M token/วันฟรีมักอยู่ได้จากการ arbitrage โควตา promotional ของ provider ต้นทาง ซึ่งมีความเสี่ยงที่จะหายไปหรือถูกจำกัดแบบไม่แจ้งล่วงหน้า
- **GLM 5.2 ไม่ได้ฟรีที่ไหนเลยในเนื้อหาที่ตรวจสอบได้** — ถ้าต้องการ GLM 5.2 จริง ต้องจ่ายตามราคา official ของ Z.ai ($1.40/$4.40 ต่อ 1M token)

## References

1. [NaraRouter — Unified AI Gateway](https://router.bynara.id/) — onboarding steps, pricing tiers, model list, FAQ
2. NaraRouter pricing tier data (same source as [1])
3. [GLM-5.2 - Overview - Z.AI Developer Document](https://docs.z.ai/guides/llm/glm-5.2)
4. [zai-org/GLM-5.2 · Hugging Face](https://huggingface.co/zai-org/GLM-5.2)
5. [Connect Claude Code to an LLM gateway — Claude Code Docs](https://code.claude.com/docs/en/llm-gateway-connect), [Other LLM gateways — Claude Code Docs](https://code.claude.com/docs/en/llm-gateway)
6. [OpenAI credentials | Nodes | n8n Docs](https://docs.n8n.io/integrations/builtin/credentials/openai/)
7. [router.bynara.id safety check — Sur.ly](https://sur.ly/i/router.bynara.id/)
8. [Get 5 Million Free AI Tokens Every Day! (NaraRouter + Claude Code Tutorial) — YouTube](https://www.youtube.com/watch?v=0fFq16XokCY) — tutorial source for the circulating claims, referenced for context only (not used as a factual source)

## Key Takeaways

- NaraRouter free tier (7M token/วัน, 10 req/min) มีจริง ตรวจสอบได้จากเว็บไซต์ตรงๆ
- GLM 5.2 **ไม่อยู่ใน model list ของ NaraRouter เลย** ทั้ง free และ paid — คำกล่าวอ้างนี้หา source ยืนยันไม่ได้
- ไม่มีขั้นตอน Google sign-in หรือ Telegram verification ตามที่เข้าใจกัน — Telegram ที่พบเป็นแค่ช่องทาง support
- Claude Code ต่อ gateway ได้จริงผ่าน `ANTHROPIC_BASE_URL` + `ANTHROPIC_AUTH_TOKEN`/`ANTHROPIC_API_KEY` — แต่ **ห้ามใส่ credential ใน project `.claude/settings.json`** ที่ commit เข้า repo
- Anthropic ระบุชัดว่าไม่รับรอง third-party gateway และไม่ support การ route Claude Code ไปยังโมเดลที่ไม่ใช่ Claude
- n8n ต่อ router แบบนี้ได้ผ่าน HTTP Request node เท่านั้น — ไม่ใช่ผ่าน built-in OpenAI credential ที่มีแค่ API Key field
- ก่อนผูก credential จริงกับ router แบบนี้ ควรพิจารณา ToS, data privacy, และความยั่งยืนของ free quota ให้รอบคอบ
