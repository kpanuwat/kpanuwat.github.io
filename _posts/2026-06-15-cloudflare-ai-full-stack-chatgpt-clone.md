---
title: "Cloudflare AI Full-Stack: สร้าง ChatGPT Clone ระดับ 10M Users ด้วย Workers, D1, Durable Objects และ AI Gateway"
date: 2026-06-14 00:03:00 +0700
categories: [Engineering]
tags: [cloudflare, workers, ai-gateway, durable-objects, d1, r2, full-stack]
---

## TL;DR

Cloudflare มี ecosystem ครบวงจรสำหรับสร้างแอป AI ระดับ production — Workers (compute), D1 (SQL), Durable Objects (stateful sessions), R2 (object storage), และ AI Gateway (caching + fallback) ทำงานบน edge network เดียวกัน ไม่ต้องพึ่งผู้ให้บริการอื่น และสเกลได้ถึง 10 ล้านผู้ใช้โดยไม่ต้องจัดการ server เอง

## Background / Why this matters

เวลาสร้างแอป AI อย่าง ChatGPT clone นักพัฒนาส่วนใหญ่ต้องใช้ stack หลายชั้น — Next.js บน Vercel, PostgreSQL บน Supabase, Redis สำหรับ session, AWS S3 สำหรับ file storage แต่ละส่วนมี billing แยก, latency แยก, และ vendor lock-in แยกกัน

Cloudflare เสนอทางเลือกที่น่าสนใจ: **ทุกอย่างอยู่บน edge network เดียวกัน** Workers รัน JS ใกล้ผู้ใช้ใน 300+ เมืองทั่วโลก, D1 เป็น SQLite serverless ที่ replicate แบบ global, Durable Objects เก็บ state per-session โดยไม่ต้องมี external Redis, R2 เก็บไฟล์โดย **ไม่คิด egress fee**, และ AI Gateway คั่นกลางระหว่างแอปกับ LLM provider เพื่อ cache + fallback อัตโนมัติ

ที่น่าสนใจกว่านั้น: ทุกอย่างตั้งค่าได้ผ่าน `wrangler` CLI ร่วมกับ AI เช่น Claude Code — ไม่ต้องกดผ่าน dashboard เลย

## Deep Dive

### Cloudflare Ecosystem Overview

```
┌─────────────────────────────────────────────────────┐
│                Cloudflare Edge Network               │
│                                                     │
│  [Access] → [Workers] → [AI Gateway] → [LLM API]   │
│                ↕              ↕                     │
│         [D1 SQL]    [Durable Objects]               │
│         [R2 Object Storage]                         │
└─────────────────────────────────────────────────────┘
```

ทุก component อยู่ใน network เดียวกัน ทำให้ latency ระหว่าง Workers กับ D1 หรือ Durable Objects ต่ำมาก ต่างจากการเรียก external database ข้าม region

### Cloudflare Access — ระบบ Authentication ที่ขอบ

**Cloudflare Access** ทำหน้าที่บล็อกสิทธิ์เข้าถึงก่อนที่ request จะถึง Worker ใช้ Zero Trust model — ผู้ใช้ต้อง authenticate ผ่าน identity provider (Google, GitHub, SAML ฯลฯ) ก่อน Cloudflare จะส่ง request ต่อ

ข้อดี: ไม่ต้องเขียน auth middleware ใน Worker เอง Workers ได้รับ `Cf-Access-Jwt-Assertion` header พร้อมข้อมูลผู้ใช้ verified แล้ว

### Workers — Serverless Compute สำหรับ Backend + Frontend

**Cloudflare Workers** รัน JavaScript/TypeScript (หรือ Wasm) บน V8 isolates ที่ deploy ใน 300+ edge locations ทั่วโลก ไม่มี cold start ที่สำคัญเหมือน Lambda เพราะ isolate เบากว่า container มาก

ใน ChatGPT clone pattern Workers ทำหน้าที่ทั้ง:
- **Backend API**: รับ chat request, เรียก AI Gateway, บันทึก history ผ่าน Durable Object
- **Frontend serving**: serve static assets หรือ render SSR ผ่าน `assets` binding ใน `wrangler.jsonc`

```jsonc
// wrangler.jsonc
{
  "name": "chatgpt-clone",
  "compatibility_date": "2025-01-01",
  "assets": { "directory": "./public" },
  "ai": { "binding": "AI" },
  "d1_databases": [{ "binding": "DB", "database_name": "chatdb" }],
  "r2_buckets": [{ "binding": "STORAGE", "bucket_name": "chat-files" }]
}
```

### D1 — SQLite Serverless สำหรับ Metadata

**Cloudflare D1** เป็น managed SQLite database ที่ใช้ Workers binding โดยตรง — ไม่มี connection pool, ไม่มี connection string ยาวๆ

ใช้เก็บ metadata ที่แชร์ข้าม session:
- รายการ conversation ของผู้ใช้
- ข้อมูล user profile
- ค่า settings ต่างๆ

```typescript
// Worker code
const stmt = env.DB.prepare(
  "INSERT INTO conversations (user_id, title, created_at) VALUES (?, ?, ?)"
);
await stmt.bind(userId, title, Date.now()).run();
```

D1 รองรับ **Global Read Replication** — read replica deploy ทั่วโลกเพื่อลด latency สำหรับ read-heavy workload และมี **Time Travel** ย้อนคืน database ได้ถึง 30 วัน

### Durable Objects — Stateful Computer รายเซสชัน

นี่คือ component ที่น่าสนใจที่สุด **Durable Objects** คือ Workers ที่มี state ของตัวเอง — แต่ละ Durable Object instance มี globally-unique name และ SQLite storage ที่ strongly consistent

ใน ChatGPT clone ใช้ Durable Object **หนึ่ง instance ต่อหนึ่ง conversation** เก็บ chat history รายเซสชัน:

```typescript
export class ChatSession extends DurableObject {
  async addMessage(role: string, content: string) {
    await this.ctx.storage.put(`msg:${Date.now()}`, { role, content });
  }

  async getHistory(): Promise<Message[]> {
    const entries = await this.ctx.storage.list({ prefix: "msg:" });
    return Array.from(entries.values()) as Message[];
  }
}
```

Worker เรียก Durable Object ผ่าน stub:
```typescript
const id = env.CHAT_SESSION.idFromName(conversationId);
const session = env.CHAT_SESSION.get(id);
await session.addMessage("user", userMessage);
```

ต่างจาก D1 ตรงที่ Durable Object เหมาะกับ **real-time, per-entity state** ที่ต้องการ strong consistency ภายใน entity เดียว

### R2 — Object Storage ไร้ค่า Egress

**Cloudflare R2** เป็น S3-compatible object storage ที่ **ไม่คิด egress fee** ต่างจาก AWS S3 ที่คิดค่า bandwidth ทุกครั้งที่ดึงไฟล์ออก

ใน ChatGPT clone ใช้เก็บ:
- ไฟล์ที่ผู้ใช้อัปโหลด (PDF, รูปภาพ)
- Export ประวัติการสนทนา

R2 เชื่อมกับ Worker ผ่าน binding โดยตรง ไม่ต้องผ่าน HTTP ทำให้เร็วและถูก

### AI Gateway — Caching + Fallback สำหรับ LLM Calls

**Cloudflare AI Gateway** คือ reverse proxy ที่คั่นกลางระหว่าง Worker กับ LLM API provider รองรับ 20+ provider (OpenAI, Anthropic, Google Gemini, Workers AI ฯลฯ)

**ฟีเจอร์หลัก:**

**1. Response Caching** — identical request จาก user คนต่างๆ ได้รับ response จาก Cloudflare global cache แทนที่จะเรียก LLM ซ้ำ ลด latency ได้ถึง 90% และประหยัด token cost อย่างมากสำหรับ common prompts

**2. Automatic Fallback** — กำหนด provider chain ไว้ล่วงหน้า ถ้า primary model ล่มหรือ rate limit เต็ม AI Gateway สลับไปยัง fallback อัตโนมัติโดยไม่ต้องแก้ code:

```jsonc
// AI Gateway routing config
{
  "providers": [
    { "provider": "anthropic", "model": "claude-sonnet-4-6" },
    { "provider": "openai", "model": "gpt-4o" },
    { "provider": "workers-ai", "model": "@cf/meta/llama-3.1-8b-instruct" }
  ]
}
```

**3. Analytics + Logging** — เห็น token usage, cost, error rate, cache hit rate ทั้งหมดใน dashboard เดียว

**4. Rate Limiting + Spend Limits** — กำหนด budget per user/team ป้องกัน cost overrun

การเชื่อมกับ Worker ต้องการ config เพียงบรรทัดเดียวใน `wrangler.jsonc`:
```jsonc
{ "ai": { "binding": "AI" } }
```

แล้วใช้ใน code:
```typescript
const response = await env.AI.run("@cf/meta/llama-3.1-8b-instruct", {
  messages: history
});
```

### cf CLI + Claude Code — Infrastructure as Conversation

แทนที่จะคลิกผ่าน Cloudflare dashboard ทีละขั้น ใช้ `wrangler` CLI ร่วมกับ Claude Code ตั้งค่า infrastructure ทั้งหมดผ่าน terminal:

```bash
# สร้าง D1 database
npx wrangler d1 create chatdb

# สร้าง R2 bucket
npx wrangler r2 bucket create chat-files

# Deploy Worker
npx wrangler deploy

# ดู logs แบบ real-time
npx wrangler tail
```

Claude Code อ่าน `wrangler.jsonc` และ Worker code โดยตรง แนะนำ config ที่ถูกต้อง แก้ TypeScript types สำหรับ bindings และ debug runtime errors จาก `wrangler tail` ได้ใน conversation เดียว

## User Guide (Step-by-Step)

### 1. ติดตั้ง Wrangler CLI

```bash
npm install -g wrangler
wrangler login   # เปิด browser สำหรับ OAuth
```

### 2. สร้างโปรเจกต์

```bash
npx create-cloudflare@latest chatgpt-clone --template worker-typescript
cd chatgpt-clone
```

### 3. สร้าง Resources

```bash
# D1 Database
npx wrangler d1 create chatdb
# → copy database_id ที่ได้มาใส่ wrangler.jsonc

# R2 Bucket
npx wrangler r2 bucket create chat-files
```

### 4. ตั้งค่า AI Gateway

ใน Cloudflare Dashboard → AI Gateway → Create Gateway → copy gateway URL ใส่ใน Worker config

### 5. Deploy

```bash
npx wrangler deploy
# → ได้ URL: https://chatgpt-clone.<your-subdomain>.workers.dev
```

### 6. เปิดใช้ Cloudflare Access (optional)

Dashboard → Zero Trust → Access → Applications → Add → กำหนด identity provider + policy

### 7. Monitor

```bash
npx wrangler tail   # real-time logs
```

## Caveats / Limits

- **Durable Objects** มี storage limit 10GB ต่อ instance บน free tier; สำหรับ long-running sessions ควรสร้าง archival flow ไปยัง D1
- **D1 free tier**: 5GB storage, 5M rows read/วัน — เพียงพอสำหรับ development แต่ production ต้องใช้ Paid plan
- **Workers CPU time**: 10ms ต่อ request บน free tier (50ms บน Paid) — streaming LLM responses ต้องใช้ `waitUntil()` pattern เพื่อ extend execution
- **AI Gateway caching**: ทำงานได้ดีกับ deterministic prompts; ถ้า temperature > 0 cache hit rate จะต่ำ เพราะ response ไม่ซ้ำกัน
- **Cloudflare Access** ไม่รองรับ social login สำหรับ public apps โดยตรง — ต้องใช้ร่วมกับ auth provider ภายนอก (Auth0, Clerk ฯลฯ) ถ้าต้องการ self-registration
- **R2 free tier**: 10GB storage, 1M Class A operations/เดือน (write), 10M Class B operations/เดือน (read)
- **Wrangler CLI**: ต้องการ Node.js 18+ และ Cloudflare account

## References

1. [Cloudflare AI Gateway Overview](https://developers.cloudflare.com/ai-gateway/) — official docs
2. [AI Gateway Features](https://developers.cloudflare.com/ai-gateway/features/) — caching, rate limiting, fallback, guardrails
3. [Cloudflare Durable Objects Overview](https://developers.cloudflare.com/durable-objects/) — stateful compute + storage
4. [Cloudflare D1 Overview](https://developers.cloudflare.com/d1/) — serverless SQLite, global replication
5. [Cloudflare Workers AI Solutions](https://workers.cloudflare.com/solutions/ai) — AI workloads on Workers
6. [Full-Stack AI Chat on Cloudflare (GitHub workersai)](https://github.com/akazwz/workersai) — reference implementation
7. [YouTube: Cloudflare Full-Stack AI Demo](https://youtu.be/pIa9pt0-C9U) — source video สำหรับโพสต์นี้

## Key Takeaways

- **One network, all components** — Workers, D1, Durable Objects, R2, AI Gateway ทำงานบน Cloudflare edge เดียวกัน ลด latency ระหว่าง layers อย่างมาก
- **D1 สำหรับ metadata, Durable Objects สำหรับ session state** — ทั้งคู่ใช้ SQLite แต่ use case ต่างกัน: D1 สำหรับ shared relational data, DO สำหรับ strongly-consistent per-entity state
- **AI Gateway เป็น free insurance** — เปิดใช้งานได้ด้วย config บรรทัดเดียว ได้ caching + fallback + analytics ทันที ไม่มีเหตุผลที่จะไม่ใช้
- **R2 = S3 ไม่มี egress fee** — สำหรับแอปที่ serve ไฟล์หนักๆ ให้ผู้ใช้จำนวนมาก ต่างกันมากในระยะยาว
- **Wrangler CLI + Claude Code** = infrastructure automation ที่ไม่ต้องแตะ dashboard ทำให้ตั้งค่า reproducible และ version-controlled ได้
- **Free tier ครอบคลุม development ทั้งหมด** — ทุก service มี free tier ที่ใช้งานได้จริง ทดสอบ full stack ได้โดยไม่มีค่าใช้จ่ายก่อนขึ้น production
