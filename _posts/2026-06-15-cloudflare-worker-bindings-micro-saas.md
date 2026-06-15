---
title: "Cloudflare Worker Bindings: รันบริการครบในที่เดียว ไม่ต้อง API Key สำหรับ Micro SaaS"
date: 2026-06-14 00:08:00 +0700
categories: [Engineering]
tags: [cloudflare, workers, bindings, headless-browser, micro-saas, security, vendor-lock-in]
---

{% include slide-link.html %}

## TL;DR

Cloudflare Worker **Bindings** คือระบบที่ให้ Worker เข้าถึงบริการ 25+ ตัว — AI, R2, D1, Browser Run, Queues, Vectorize และอื่นๆ — **โดยไม่ต้องมี API key ใน code** เพราะ permission ฝังอยู่ใน runtime เลย ทำให้ปลอดภัยขึ้น บริหาร cost ง่าย และเหมาะมากสำหรับ Micro SaaS อย่างไรก็ตาม ต้องระวังค่า Headless browser ที่คิดตาม concurrent browser และปัญหา vendor lock-in

## Background / Why this matters

นักพัฒนา SaaS ส่วนใหญ่เจอปัญหาเดียวกัน: API keys กระจายอยู่ใน `.env`, secrets manager, CI/CD ทำให้จัดการยาก และมีโอกาส leak สูง โดยเฉพาะเมื่อ project ขยาย นอกจากนี้ยังต้องจัดการ billing แยกจากหลาย provider — OpenAI, S3, RDS, Puppeteer cloud, Auth0 — ต่างคนต่างออกใบแจ้งหนี้

Cloudflare แก้ปัญหานี้ด้วย **Bindings architecture**: แทนที่ Worker จะ call REST API ของ service แต่ละตัว (พร้อม API key ใน header) Cloudflare inject permission เข้าไปใน Worker runtime โดยตรง ผ่าน `wrangler.toml` หนึ่งไฟล์ ไม่มี secret ใน code, ไม่มี credential ใน memory

สำหรับ Micro SaaS ที่ต้องการ stack ครบใน cost ต่ำ Cloudflare เป็น one-stop platform ที่หาคู่แข่งยาก: AI inference, SQL DB, object storage, headless browser, queue, vector search — ทั้งหมดรันบน Workers ด้วย Binding เดียวกัน

## Deep Dive

### Binding คืออะไร และทำไมถึงปลอดภัยกว่า API Key

Binding คือ permission ที่ประกาศใน `wrangler.toml` และ Cloudflare inject เข้า Worker ณ runtime:

```toml
# wrangler.toml
[[r2_buckets]]
binding = "MY_BUCKET"
bucket_name = "my-saas-files"

[ai]
binding = "AI"

[[d1_databases]]
binding = "DB"
database_id = "..."

[browser]
binding = "BROWSER"
```

```typescript
export default {
  async fetch(req: Request, env: Env) {
    // ไม่มี API key — env.MY_BUCKET, env.AI, env.DB มาจาก runtime binding
    await env.MY_BUCKET.put("result.json", data);
    const ai = await env.AI.run("@cf/meta/llama-3.1-8b-instruct", { prompt });
    const db = await env.DB.prepare("SELECT * FROM users").all();
  }
};
```

**เหตุผลที่ปลอดภัยกว่า API key** [1]:
- Underlying secret ไม่เคยอยู่ใน Worker code → ไม่มีทาง leak ผ่าน `console.log`, error trace, หรือ bundle
- Permission embed ใน API เอง → ถ้า Worker ถูก compromise ก็ใช้ binding ได้แค่ตามที่ประกาศ scope ไว้
- Rotate ได้จาก dashboard โดยไม่ต้อง redeploy Worker

### บริการที่ใช้ Bindings ได้ทั้งหมด (25+ ตัว) [1]

| กลุ่ม | Bindings ที่มี |
|-------|---------------|
| **AI/ML** | Workers AI, Vectorize |
| **Storage** | R2, D1, KV, Hyperdrive |
| **Compute** | Durable Objects, Queues, Workflows, Service bindings |
| **Media** | Browser Run, Images, Stream, Media Transformations |
| **Auth/Security** | Secrets, Secrets Store, mTLS, Rate Limiting |
| **Platform** | Analytics Engine, Assets, Workers for Platforms, Version metadata |

### AI + R2 + D1 + Browser Run = Stack สำหรับ Micro SaaS

นี่คือ combination ที่ทรงพลังที่สุดสำหรับ Micro SaaS:

**ตัวอย่าง: SaaS สำหรับ Web Scraping + AI Summarizer**

```typescript
export default {
  async fetch(req: Request, env: Env) {
    const { url } = await req.json();

    // 1. Browser Run: เปิด headless browser scrape หน้าเว็บ
    const browser = await puppeteer.launch(env.BROWSER);
    const page = await browser.newPage();
    await page.goto(url);
    const html = await page.content();
    await browser.close();

    // 2. Workers AI: summarize ด้วย LLM
    const summary = await env.AI.run(
      "@cf/meta/llama-3.1-8b-instruct",
      { prompt: `Summarize this page: ${html.slice(0, 2000)}` }
    );

    // 3. D1: save result
    await env.DB.prepare(
      "INSERT INTO summaries (url, summary, ts) VALUES (?, ?, ?)"
    ).bind(url, summary.response, Date.now()).run();

    // 4. R2: store raw HTML
    await env.BUCKET.put(`html/${Date.now()}.html`, html);

    return Response.json({ summary: summary.response });
  }
};
```

ทั้ง 4 บริการไม่มี API key ในโค้ดเลย — ทั้งหมด inject ผ่าน Binding

### Browser Run: Headless Browser at the Edge

Browser Run (เดิมชื่อ Browser Rendering) รัน headless Chromium บน Cloudflare network โดยตรง รองรับ Puppeteer, Playwright, และ Chrome DevTools Protocol (CDP)

**Use cases:**
- Web scraping + data extraction
- Screenshot/PDF generation
- UI automation + testing
- Pre-rendering SPA สำหรับ SEO
- AI agent ที่ต้องควบคุม browser

**Pricing** [2]:

| Mode | ค่าใช้จ่าย |
|------|-----------|
| **Quick Actions** (screenshot, PDF, scrape) | $0.09 ต่อ browser hour |
| **Browser Sessions** (Puppeteer/Playwright/CDP) | $0.09/hr + $2.00/concurrent browser/เดือน |

**ตัวอย่าง Browser Sessions cost calculation** [2]:
- ใช้ 50 ชั่วโมง/เดือน + concurrent browser 20 ตัว
- Browser hours: (50 − 10 free) × $0.09 = **$3.60**
- Concurrent: ((20 − 10 free) × $2.00) = **$10.00**
- รวม: **$13.60/เดือน** ยังถูกกว่า Browserless.io หรือ Apify ที่ $25+/เดือน

Free tier: 10 นาที/วัน, 3 concurrent browsers — พอสำหรับ development และ demo

### AI-Assisted Development บน Cloudflare Platform

Bindings ยังทำให้ AI agents พัฒนาและ test Worker ได้ง่ายขึ้น:
- Claude Code / Cursor อ่าน `wrangler.toml` เข้าใจ architecture ได้ทันที
- Type-safe `Env` interface auto-generate — AI ไม่ต้องเดา method signatures
- `wrangler dev` ทำ local binding simulation — test ได้ก่อน deploy จริง
- `wrangler tail` stream logs จาก production — AI debug ได้ real-time

## Caveats / Limits

**Browser Run ราคาสูงที่ concurrent scale:**
- $2.00/concurrent browser คิดเป็น monthly average — ถ้า spike ถึง 50 concurrent = $80/เดือนแค่ค่า browser alone
- Quick Actions ราคาถูกกว่า แต่รองรับแค่ single-page operations ไม่ได้ทำ multi-step interaction
- Free tier 10 นาที/วัน หมดเร็วมากในโปรดักชัน

**Vendor lock-in:**
- Bindings เป็น Cloudflare-specific — ย้าย Worker ไป AWS Lambda ต้องเปลี่ยน `env.AI` เป็น Bedrock SDK, `env.DB` เป็น RDS client ฯลฯ
- D1 และ Durable Objects ไม่มี standard compatible alternative — ย้ายยากกว่า R2 (S3-compatible)
- ยิ่งใช้ Binding มาก ยิ่ง lock-in ลึก เป็น trade-off ระหว่าง simplicity และ portability
- แนะนำ: abstract service layer ด้วย interface ของตัวเอง เพื่อ swap implementation ได้ถ้าจำเป็น

**Custom code limitations:**
- Workers runtime ไม่รองรับ binary ทั่วไป, subprocess, หรือ native modules — ทำให้ library บาง เช่น ffmpeg, sharp (native), หรือ Python package ใช้ไม่ได้โดยตรง
- CPU time limit: 30 วินาที (Paid plan) — งาน long-running ต้องแยกออกไปเป็น Workflows หรือ Queues
- Memory limit: 128 MB ต่อ Worker invocation — ไม่เหมาะสำหรับ large model inference หรือ in-memory data processing ขนาดใหญ่
- ถ้าต้องการ custom Docker container ต้องใช้ Cloudflare Containers (beta) ซึ่งยังไม่ GA

**Micro SaaS considerations:**
- เหมาะมากสำหรับ API-first SaaS, scraping tools, AI wrappers, data pipeline
- ไม่เหมาะสำหรับ workload ที่ต้องการ stateful compute หนัก, GPU training, หรือ real-time game server
- Free plan ไม่มี Durable Objects — ต้องใช้ Paid plan ($5/mo minimum) ถ้าต้องการ session state

## References

1. Cloudflare Workers Bindings docs: <https://developers.cloudflare.com/workers/runtime-apis/bindings/>
2. Cloudflare Browser Run Pricing: <https://developers.cloudflare.com/browser-rendering/platform/pricing/>
3. Cloudflare Browser Run overview: <https://www.cloudflare.com/products/browser-rendering/>
4. Cloudflare Changelog — Browser Rendering pricing launch ($0.09/hr): <https://developers.cloudflare.com/changelog/post/2025-07-28-br-pricing/>
5. Workers AI docs: <https://developers.cloudflare.com/workers-ai/>
6. Cloudflare D1 docs: <https://developers.cloudflare.com/d1/>

## Key Takeaways

- **Bindings = permission embedded in runtime** — ไม่มี API key ใน code, ไม่มี secret ใน bundle, reduce breach surface ลงอย่างมาก
- **25+ services ใช้ Binding ได้** — AI, R2, D1, Browser Run, DO, KV, Queues, Vectorize, Workflows — ทั้งหมดใน `wrangler.toml` เดียว
- **Browser Run รองรับ Puppeteer และ Playwright** — $0.09/hr สำหรับ Quick Actions, บวก $2.00/concurrent browser สำหรับ Sessions — คิดคำนวณก่อน scale
- **Vendor lock-in เป็นของแถมที่ต้องยอมรับ** — ยิ่งใช้ Binding มาก ยิ่ง migrate ยาก แก้ด้วยการ abstract service layer ของตัวเอง
- **Workers มี CPU/memory limit** — 30s CPU, 128 MB memory ไม่เหมาะกับ heavy compute; ใช้ Workflows สำหรับ long-running jobs
- **Micro SaaS golden path**: Workers (runtime) + AI (inference) + D1 (SQL) + R2 (storage) + Browser Run (automation) + Bindings (glue) — stack ครบ ราคาถูก ปลอดภัย
