---
title: "Cloudflare AI Ecosystem: เจาะลึกสแต็ก Workers, Durable Objects, D1, AI Gateway และ Agents SDK"
date: 2026-06-14 00:07:00 +0700
categories: [Engineering]
tags: [cloudflare, workers, durable-objects, d1, r2, ai-gateway, agents-sdk, bindings]
---

{% include slide-link.html %}

## TL;DR

Cloudflare AI ไม่ใช่แค่ GPU inference — มันคือ **complete platform** ที่ประกอบด้วย Workers (runtime), Durable Objects (per-session state), D1+R2 (zero-egress storage), AI Gateway (caching + model routing), Cloudflare Access (auth), และ Bindings (zero-API-key wiring) ทั้งหมดเชื่อมกันผ่าน `wrangler.toml` หนึ่งไฟล์ ไม่มี secrets ใน code

## Background / Why this matters

ทีมที่สร้าง AI application ส่วนใหญ่เจอปัญหาเดิมซ้ำๆ: จัดการ session state ยากเพราะ serverless stateless, ค่า egress จาก S3/GCS สูง, โมเดลค่าแพงเพราะไม่มี caching, และ API keys กระจายอยู่ทั่ว codebase

Cloudflare แก้ทั้งหมดนี้ด้วยแนวคิด **"infrastructure as bindings"** — แทนที่จะ provision ทุกอย่างแยกกัน ทุก service (AI, DB, storage, auth) wired เข้า Worker โดยตรงผ่าน runtime bindings Cloudflare จัดการ secret management ให้หมด ไม่มี `.env` ไม่มี IAM role

ตัวเลขที่ Cloudflare ใช้ภายในเอง: **20 ล้าน requests** ผ่าน AI Gateway, **241 พันล้าน tokens** ประมวลผลผ่าน Workers AI, 3,683 internal users — บน platform เดียวกับที่ ship ให้ลูกค้า [1]

## Deep Dive

### Workers — Serverless Runtime at the Edge

Cloudflare Workers รัน JavaScript/TypeScript บน V8 isolates ใน **330+ เมือง** ทั่วโลก ไม่มี cold start เพราะ isolates start ใน sub-millisecond แทน container spin-up

```typescript
export default {
  async fetch(req: Request, env: Env): Promise<Response> {
    const result = await env.AI.run("@cf/meta/llama-3.1-8b-instruct", {
      prompt: "Hello from the edge"
    });
    return Response.json(result);
  }
};
```

`env.AI` คือ Binding — ไม่มี API key, ไม่มี HTTP call ออกไปข้างนอก, Cloudflare wires ให้ใน runtime

### Durable Objects — Per-Session State Isolation

Durable Objects (DO) คือ primitive ที่ทรงพลังที่สุดในสแต็กนี้ แต่ละ DO instance มี:
- **Compute** (JavaScript class) + **Storage** (SQLite-based key-value) อยู่ในที่เดียวกัน
- **Strong consistency** — ไม่มี race condition ระหว่าง read/write
- **Unique identity** — สร้างจาก session ID, user ID, หรือ chat ID ทำให้แต่ละ session isolated สมบูรณ์

```typescript
export class ChatSession extends DurableObject {
  async addMessage(role: string, content: string) {
    const msgs = (await this.ctx.storage.get<Message[]>("msgs")) ?? [];
    msgs.push({ role, content, ts: Date.now() });
    await this.ctx.storage.put("msgs", msgs);
  }

  async getHistory(): Promise<Message[]> {
    return (await this.ctx.storage.get<Message[]>("msgs")) ?? [];
  }
}
```

Worker route ไปยัง DO โดยใช้ session ID:
```typescript
const id = env.CHAT_SESSION.idFromName(sessionId);
const stub = env.CHAT_SESSION.get(id);
await stub.addMessage("user", userInput);
```

ผลลัพธ์: user A กับ user B มี storage + compute แยกกันสมบูรณ์ ไม่มี shared state leak

### D1 — Serverless SQL, Zero Egress

D1 คือ SQLite ที่รันบน Cloudflare network ใช้ได้ทันทีจาก Worker ผ่าน Binding:

```typescript
// wrangler.toml
[[d1_databases]]
binding = "DB"
database_name = "my-app"
database_id = "xxxx-xxxx"

// Worker code
const { results } = await env.DB.prepare(
  "SELECT * FROM users WHERE id = ?"
).bind(userId).all();
```

**Zero egress fees** — ไม่มีค่าบริการเมื่อ query ข้อมูลจาก Worker เดียวกับที่ D1 อยู่ ต่างจาก RDS/PlanetScale ที่คิดค่า data transfer

### R2 — Object Storage Without Egress Tax

R2 คือ S3-compatible object storage ที่ไม่มีค่า egress bandwidth เลย เก็บ model outputs, user uploads, generated files ได้โดยไม่กลัวค่า transfer

```typescript
// Store
await env.MY_BUCKET.put(`outputs/${sessionId}.json`, JSON.stringify(result));

// Retrieve
const obj = await env.MY_BUCKET.get(`outputs/${sessionId}.json`);
const data = await obj?.json();
```

เหมาะสำหรับ: AI-generated images, audio files, PDF exports, batch inference results

### AI Gateway — Cache, Route, Control

AI Gateway นั่งอยู่ระหว่าง Worker กับ AI providers (OpenAI, Anthropic, Google, Workers AI, etc.) และทำหน้าที่:

| Feature | Detail |
|---------|--------|
| **Caching** | Cache identical prompts ลด API costs (config: cache TTL) |
| **Model fallback** | ถ้า OpenAI down → fallback ไป Anthropic อัตโนมัติ |
| **Rate limiting** | จำกัด requests/tokens per minute per user |
| **Spend limits** | Real-time budget cap — หยุดทันทีเมื่อถึง limit |
| **Observability** | Log ทุก request + token usage + latency |

ตั้งค่าผ่าน Binding หรือ REST:
```typescript
const response = await env.AI.run(
  "@cf/meta/llama-3.1-8b-instruct",
  { prompt },
  { gateway: { id: "my-gateway", skipCache: false, cacheTtl: 3600 } }
);
```

### Cloudflare Access — Zero-Trust Auth Layer

Cloudflare Access วาง auth layer ด้านหน้า Worker โดยไม่ต้องแตะ application code:
- รองรับ SSO (Google, GitHub, Azure AD, SAML, OIDC)
- Enforce MFA ก่อนถึง app
- JWT validation อัตโนมัติ — Worker อ่าน `CF-Access-JWT-Assertion` header ได้เลย

เหมาะสำหรับ internal tools, admin panels, หรือ AI apps ที่ต้องการ enterprise auth โดยไม่ implement เอง

### Bindings — The Glue That Removes API Keys

Bindings คือ concept สำคัญที่สุดใน Cloudflare stack: **ทุก service wired เข้า Worker ใน runtime — ไม่มี credentials ใน code**

```toml
# wrangler.toml — ทั้งหมดอยู่ที่เดียว
[ai]
binding = "AI"

[[d1_databases]]
binding = "DB"
database_name = "prod-db"
database_id = "..."

[[r2_buckets]]
binding = "BUCKET"
bucket_name = "ai-outputs"

[durable_objects]
bindings = [{ name = "CHAT_SESSION", class_name = "ChatSession" }]
```

TypeScript interface auto-generated:
```typescript
interface Env {
  AI: Ai;
  DB: D1Database;
  BUCKET: R2Bucket;
  CHAT_SESSION: DurableObjectNamespace;
}
```

### Agents SDK + New CLI Tools

**Agents SDK** เป็น framework สำหรับสร้าง AI agents บน Workers ที่รองรับ:
- State management ผ่าน DO
- Real-time WebSockets (bi-directional client ↔ agent)
- Scheduled tasks (cron-like)
- Tool integration: browser automation, code execution sandbox, AI Search, MCP tools, payments
- ไม่ต้องกำหนด API keys — Workers AI ใช้ `env.AI` โดย default [2]

**`cf` CLI** (ใหม่ 2026): unified CLI แทน wrangler สำหรับทุก service:
```bash
cf deploy            # deploy Worker
cf d1 execute        # run SQL on D1
cf r2 object put     # upload to R2
cf ai run            # test AI model locally
cf tunnel create     # expose local port
```

```bash
# Quick start: scaffold AI agent
npm create cloudflare@latest my-ai-agent -- --template ai-agent
cd my-ai-agent && npm run dev
```

## User Guide (Step-by-Step)

### 1. Install & Auth

```bash
npm install -g wrangler
wrangler login    # opens browser → Cloudflare dashboard auth
```

### 2. Scaffold project

```bash
npm create cloudflare@latest my-ai-app
# เลือก: "Hello World" Worker → TypeScript → Deploy now: Yes
cd my-ai-app
```

### 3. Enable bindings ใน `wrangler.toml`

```toml
name = "my-ai-app"
compatibility_date = "2025-01-01"

[ai]
binding = "AI"

[[d1_databases]]
binding = "DB"
database_name = "my-db"
database_id = ""  # fill after: wrangler d1 create my-db

[[r2_buckets]]
binding = "BUCKET"
bucket_name = "my-outputs"  # fill after: wrangler r2 bucket create my-outputs
```

### 4. Create D1 + R2

```bash
wrangler d1 create my-db
# copy database_id ไปใส่ wrangler.toml

wrangler r2 bucket create my-outputs
```

### 5. Add AI Gateway (optional แต่แนะนำ)

ไปที่ Cloudflare Dashboard → AI → AI Gateway → Create gateway → copy gateway ID:
```typescript
const response = await env.AI.run("@cf/meta/llama-3.1-8b-instruct",
  { prompt },
  { gateway: { id: "my-gateway" } }
);
```

### 6. Deploy

```bash
wrangler deploy
# → ได้ URL: https://my-ai-app.<your-subdomain>.workers.dev
```

### 7. Add Cloudflare Access (for protected apps)

Dashboard → Zero Trust → Access → Applications → Add application → เลือก Worker URL → ตั้ง identity provider → Done โดยไม่แตะ code

### Daily Workflows

```bash
wrangler dev                    # local dev server (port 8787)
wrangler d1 execute my-db --file=schema.sql   # run migration
wrangler tail                   # live log streaming จาก production
wrangler ai models              # list available models
```

## Caveats / Limits

**Free plan limits:**
- Workers AI: 10,000 neurons/day (1 neuron ≈ 1 text token หรือ 1 image pixel batch) [3]
- D1: 5 million rows read/day, 100,000 rows written/day
- R2: 10 GB storage, 1 million Class-A ops/month
- Durable Objects: ไม่มีในแผน Free — ต้องใช้ Paid plan ($5/mo minimum)

**DO limitations:**
- ต้องกำหนด `jurisdiction` สำหรับ GDPR compliance (EU data ต้องอยู่ EU)
- Cold start ครั้งแรก ~100ms (ต่างจาก Worker sub-ms)
- Maximum object storage per DO: 128 KB per key (ใช้ R2 สำหรับ large payloads)

**AI Gateway:**
- Cache key = exact prompt hash — minor wording change = cache miss
- Model fallback ต้องตั้ง provider fallback chain เองใน dashboard

**Workers AI:**
- Model catalog ~50+ models — ถ้าต้องการ fine-tuned model ต้องใช้ external provider ผ่าน AI Gateway
- GPU availability ไม่ guaranteed ในทุก PoP — Cloudflare route ไปยัง nearest available GPU automatically

**Bindings security:**
- Binding secrets ไม่ visible ใน wrangler.toml ที่ push ขึ้น git — แต่ Durable Object class names ต้องตรงกับ binding declaration ไม่งั้น deploy fail

## References

1. Cloudflare — "The AI engineering stack we built internally": <https://blog.cloudflare.com/internal-ai-engineering-stack>
2. Cloudflare Agents docs: <https://developers.cloudflare.com/agents/>
3. Workers AI Pricing: <https://developers.cloudflare.com/workers-ai/platform/pricing/>
4. Durable Objects Overview: <https://developers.cloudflare.com/durable-objects/>
5. AI Gateway docs: <https://developers.cloudflare.com/ai-gateway/>
6. D1 docs: <https://developers.cloudflare.com/d1/>
7. R2 docs: <https://developers.cloudflare.com/r2/>
8. Workers AI Bindings + AI Gateway integration: <https://developers.cloudflare.com/ai-gateway/integrations/aig-workers-ai-binding/>
9. Agents Week 2026 review: <https://blog.cloudflare.com/agents-week-in-review>

## Key Takeaways

- **Bindings = no API keys in code** — ทุก service (AI, DB, storage) wired เข้า Worker ใน runtime; credentials ไม่เคยแตะ source code
- **Durable Objects isolate state per session** — compute + SQLite storage ต่อ instance เดียว; เหมาะสำหรับ chat sessions, game state, collaborative tools
- **D1 + R2 = zero egress** — เก็บ AI outputs, user data ได้โดยไม่มีค่า data transfer เมื่อ access จาก Worker
- **AI Gateway caches + routes models** — identical prompts hit cache ก่อน; model fallback อัตโนมัติเมื่อ provider down; real-time spend limits ป้องกัน bill shock
- **Agents SDK ไม่ต้อง provision infra** — DO state + WebSocket + tools พร้อมใช้ใน `npm create cloudflare` template เดียว
- **330+ edge PoPs** — inference เกิดใกล้ user ที่สุด; latency ต่ำกว่า centralized API calls
- Cloudflare ใช้ platform นี้เองภายใน: 241 พันล้าน tokens, 20 ล้าน Gateway requests — same stack ที่ ship ให้ลูกค้า
