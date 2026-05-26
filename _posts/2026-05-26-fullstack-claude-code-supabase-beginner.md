---
title: "เจาะลึก: พัฒนา Fullstack Web App ด้วย Claude Code + Supabase อย่างปลอดภัยสำหรับมือใหม่"
date: 2026-05-25 00:02:00 +0700
categories: [Engineering]
tags: [claude-code, supabase, fullstack, web-dev, security, beginner]
slides: false
---

## TL;DR

Claude Code CLI + Supabase คือ combo ที่ทำให้มือใหม่สร้าง fullstack web app ได้เร็วและปลอดภัย — แต่ต้องเข้าใจ 3 กฎเหล็ก: **ไม่ expose Service Role Key ในฝั่ง client**, **เปิด Row Level Security (RLS) ทุก table**, และ **ไม่เชื่อม MCP กับ production database โดยตรง**

---

## Background / Why this matters

ก่อนจะมี Claude Code CLI นักพัฒนาหน้าใหม่ที่อยากสร้าง fullstack app มักเจอกำแพง 3 ชั้น: ตั้งค่า backend, จัดการ auth, และเขียน database schema ให้ปลอดภัย แต่ละชั้นใช้เวลาเรียนรู้หลายสัปดาห์

Supabase แก้ปัญหาชั้นที่ 1 และ 2 ด้วย hosted Postgres + Auth บน cloud Anthropic แก้ชั้นที่ 3 ด้วย Claude Code ซึ่ง "เข้าใจ" codebase ของคุณและ generate code ที่ context-aware ได้ ผลลัพธ์คือ beginner สามารถ ship working app ที่มี authentication, database, และ real-time feature ได้ภายในวันเดียว

ปัญหาคือ "เร็ว" กับ "ปลอดภัย" มักขัดกัน — โดยเฉพาะตอนที่ AI เป็นคนเขียน code ให้ บทความนี้จะ map ว่า "อะไรที่ AI ทำให้ได้" กับ "อะไรที่คุณต้องตรวจเองเสมอ"

---

## Deep Dive

### สถาปัตยกรรมพื้นฐาน: Next.js + Supabase + Claude Code

Stack ที่แนะนำสำหรับมือใหม่ปี 2026:

```
Frontend: Next.js 15 (App Router) + TypeScript + Tailwind CSS
Backend:  Supabase (Postgres + Auth + Realtime + Storage)
AI Dev:   Claude Code CLI + Supabase MCP
Deploy:   Vercel (frontend) + Supabase Cloud (backend)
```

ทำไมถึงเป็น stack นี้:
- **Next.js App Router** แยก Server Component กับ Client Component ชัดเจน ช่วยให้ไม่หลงส่ง Service Role Key ไปฝั่ง client
- **Supabase** ให้ Postgres + Auth + Row Level Security ในตัว ไม่ต้อง implement auth จาก scratch
- **Claude Code** เข้าใจ project context ผ่าน `CLAUDE.md` ทำให้ generated code ตรงกับ pattern ของ project

---

### ตั้งค่า Claude Code CLI + CLAUDE.md

**ติดตั้ง Claude Code:**
```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

**สร้าง project:**
```bash
mkdir my-app && cd my-app
claude
# ใน Claude Code shell:
> Initialize a Next.js 15 + TypeScript + Supabase project with App Router
```

**CLAUDE.md คืออะไร และทำไมสำคัญ**

`CLAUDE.md` คือไฟล์ Markdown ที่ Claude Code อ่านทุกครั้งที่เปิด session ใหม่ — เหมือน "briefing document" ที่บอก AI ว่า project นี้มีกฎอะไร เทคโนโลยีอะไร และ pattern อะไรที่ต้องใช้

```markdown
# CLAUDE.md

## Stack
- Next.js 15 App Router
- Supabase (Postgres + Auth)
- TypeScript strict mode

## Security Rules
- NEVER use service role key in client components
- ALWAYS enable RLS on new tables
- NEVER commit .env.local

## Commands
- dev: `npm run dev`
- build: `npm run build`
- type-check: `npx tsc --noEmit`
```

`★ Insight ─────────────────────────────────────`
`CLAUDE.md` ทำหน้าที่เหมือน "memory injection" — ทุก session ใหม่ Claude จะ "จำ" กฎของ project ได้ทันที แม้ไม่มี context จากการสนทนาก่อนหน้า ยิ่งเขียนกฎ security ไว้ชัด ยิ่งลด chance ที่ AI จะ generate insecure code
`─────────────────────────────────────────────────`

---

### เชื่อม Supabase MCP กับ Claude Code

**MCP (Model Context Protocol)** คือ protocol มาตรฐานที่ให้ AI tools เชื่อมกับ external services ได้ Supabase MCP ให้ Claude Code execute SQL, manage schema, และ query docs ของ Supabase ได้โดยตรงจาก terminal

**วิธีเปิดใช้ MCP:**
```bash
# วิธีที่ 1: ผ่าน CLI (แนะนำ)
claude mcp add --transport http https://mcp.supabase.com

# วิธีที่ 2: ผ่าน .mcp.json ใน project root
```

```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server-supabase@latest",
               "--project-ref", "YOUR_PROJECT_REF"]
    }
  }
}
```

⚠️ **กฎความปลอดภัย MCP ที่ต้องรู้:**

| กฎ | เหตุผล |
|----|--------|
| ห้ามเชื่อม MCP กับ production database | LLM มีความเสี่ยง prompt injection — attacker inject SQL ผ่าน input ได้ |
| ใช้ dev/staging project แยกต่างหาก | ถ้า AI รัน query ผิด จะไม่กระทบ data จริง |
| เปิด "approve all tool calls" | review ทุก query ก่อน execute |
| ตั้ง read-only mode ถ้าจำเป็นต้อง query prod | ป้องกัน AI เขียนทับ data |

---

### Row Level Security (RLS) — ปราการด่านแรก

RLS คือ feature ของ PostgreSQL ที่ Supabase ใช้งานอย่างเต็มที่ — มันให้คุณกำหนดได้ว่า "user คนไหน เห็น/แก้ไข row ไหนได้"

**ทำไม RLS จึงสำคัญมากกับ Supabase โดยเฉพาะ:**

Supabase ให้ `anon key` (API key) ที่ฝัง client-side code ได้ ทุกคนที่ดู source code จะเห็น key นี้ ถ้าไม่มี RLS ใครก็สามารถ query ทุก table ได้ผ่าน key นี้

```sql
-- เปิด RLS บน table (บังคับสำหรับทุก table ที่ expose ผ่าน API)
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- ตัวอย่าง Policy: user เห็นเฉพาะ posts ของตัวเอง
CREATE POLICY "users_own_posts"
ON posts
FOR ALL
USING ((SELECT auth.uid()) = user_id);

-- ตัวอย่าง Policy: ทุกคนอ่าน public posts ได้
CREATE POLICY "public_posts_readable"
ON posts
FOR SELECT
USING (is_public = true);
```

**Performance Tip:** ใช้ `(SELECT auth.uid())` แทน `auth.uid()` โดยตรง

```sql
-- ❌ ช้า: runs function ทุก row
USING (auth.uid() = user_id)

-- ✅ เร็ว: Postgres cache result ต่อ statement
USING ((SELECT auth.uid()) = user_id)
```

สาเหตุ: `auth.uid()` เป็น function ที่ Postgres รันแยกต่อ row ถ้า table มีล้าน rows จะช้ามาก การ wrap ด้วย `SELECT` ให้ optimizer cache ผลลัพธ์ไว้ใช้ครั้งเดียวต่อ query

**การตั้ง RLS ผ่าน Claude Code:**
```
> Create a posts table with RLS enabled. Users can only CRUD their own posts. 
  Public posts (is_public=true) are readable by anyone including anonymous users.
```

---

### API Keys — anon key vs service_role key

| Key | ที่เก็บ | สิทธิ์ | ถ้า leak |
|-----|---------|---------|----------|
| `anon` / Publishable Key | Client-side (safe) | จำกัดด้วย RLS | ผู้โจมตีเห็นได้แค่ที่ RLS อนุญาต |
| `service_role` / Secret Key | Server-side only | Bypass RLS ทั้งหมด | data รั่วทั้ง database |

```typescript
// ✅ Client component — ใช้ anon key
import { createBrowserClient } from '@supabase/ssr'

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!  // safe to expose
  )
}

// ✅ Server component / API route — ใช้ service_role key
import { createServerClient } from '@supabase/ssr'

export function createAdminClient() {
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,  // never to client
    { cookies: {} }
  )
}
```

---

### Environment Variables — ห้าม commit ขึ้น Git

```bash
# .env.local (ไม่ commit)
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGci...    # safe, client-side
SUPABASE_SERVICE_ROLE_KEY=eyJhbGci...         # SECRET — server only
```

```bash
# .gitignore (ต้องมี)
.env.local
.env*.local
```

`NEXT_PUBLIC_` prefix ใน Next.js หมายความว่า variable นั้นจะถูก bundle เข้า client-side JavaScript โดยอัตโนมัติ — ดังนั้นใช้ prefix นี้กับ `anon key` เท่านั้น ห้ามใช้กับ `service_role key`

---

## User Guide (Step-by-Step)

### Step 0: Pre-flight checklist

```bash
node --version    # ≥ 18
npm --version     # ≥ 9
claude --version  # Claude Code CLI installed
```

### Step 1: สร้าง Supabase project

1. ไปที่ [supabase.com](https://supabase.com) → New Project
2. จด Project URL และ API Keys (`anon` + `service_role`)
3. สร้าง **2 projects**: `my-app-dev` (สำหรับ develop) และ `my-app-prod` (สำหรับ production)
4. ใน dev project: ไป Settings → Database → enable "Allow connections from everywhere" (dev only)

### Step 2: Init project + CLAUDE.md

```bash
mkdir my-app && cd my-app
claude
```

ใน Claude Code shell:
```
> /init
> Create a CLAUDE.md with our stack: Next.js 15, Supabase, TypeScript strict.
  Add security rules: never expose service_role key in client code, 
  always enable RLS on new tables.
```

### Step 3: เปิด Supabase MCP (dev project เท่านั้น)

```bash
# ใน terminal (ไม่ใช่ Claude Code shell)
claude mcp add --transport http https://mcp.supabase.com
```

ระหว่าง OAuth flow เลือก dev project เท่านั้น ไม่ใช่ prod

Expected output:
```
✓ MCP server "supabase" added
✓ Authenticated with Supabase (project: my-app-dev)
```

### Step 4: สร้าง schema ผ่าน Claude Code

```
> Create a users_profile table linked to auth.users.
  Add a posts table where users can CRUD their own posts.
  Enable RLS on both tables with appropriate policies.
  Show me the SQL before running it.
```

Claude จะ generate SQL แล้วขอ approval ก่อน execute — **อ่านทุก query ก่อนกด approve**

### Step 5: เซ็ต environment variables

```bash
cp .env.example .env.local
# แก้ค่าจาก Supabase Dashboard > Settings > API
```

### Step 6: Run + ทดสอบ

```bash
npm run dev
# http://localhost:3000
```

ทดสอบ security:
```bash
# ทดสอบว่า anon user เข้าถึง protected data ไม่ได้
curl -H "apikey: YOUR_ANON_KEY" \
  https://YOUR_PROJECT.supabase.co/rest/v1/posts
# ต้องได้ [] หรือ error ถ้า RLS ทำงานถูกต้อง
```

### Troubleshooting ที่พบบ่อย

| ปัญหา | สาเหตุ | วิธีแก้ |
|-------|--------|---------|
| `permission denied for table posts` | ไม่มี RLS policy สำหรับ operation นั้น | เพิ่ม policy ที่ตรงกับ operation |
| MCP ไม่ connect | env var เปลี่ยนหลัง restart Claude Code | restart Claude Code ใหม่ทั้งหมด |
| `service_role` leaked ใน client bundle | ใช้ `NEXT_PUBLIC_` กับ secret key | เปลี่ยนชื่อ var ให้ไม่มี prefix |
| Post ไม่แสดงใน feed | RLS policy ใช้ `auth.uid()` แทน `(SELECT auth.uid())` | แก้ function call ให้มี subquery |

---

## Caveats / Limits

- **RLS ไม่ได้ปกป้อง server-side code**: ถ้าใช้ `service_role key` ในฝั่ง server, RLS จะถูก bypass โดยตรง — ต้อง validate logic เอง
- **MCP กับ production data**: ณ วันที่เขียน Supabase ยังแนะนำให้ใช้ MCP กับ dev environment เท่านั้น เพราะ LLM อาจ interpret prompt ผิดและ execute destructive query
- **Prompt injection via MCP**: ถ้า attacker inject SQL command ผ่าน user input แล้ว AI ส่งต่อให้ MCP execute ได้ — ต้อง approve ทุก MCP tool call ด้วยตัวเอง
- **anon key ไม่ใช่ secret แต่ก็ไม่ใช่ junk**: ถ้า RLS มีช่อง attacker ก็สามารถใช้ anon key query data ที่ไม่ควรเข้าถึงได้ — test RLS policies เสมอ
- **Table ที่สร้างด้วย raw SQL ไม่มี RLS by default**: Dashboard เปิดให้อัตโนมัติ แต่ migration scripts ต้องเพิ่ม `ALTER TABLE ... ENABLE ROW LEVEL SECURITY` เอง
- **Claude Code อาจ generate insecure code**: AI ไม่รู้จัก context ของ project ถ้าไม่บอกผ่าน `CLAUDE.md` — เสมอ review generated code ก่อน push

---

## References

1. [Row Level Security — Supabase Docs](https://supabase.com/docs/guides/database/postgres/row-level-security)
2. [Supabase MCP Server — Supabase Docs](https://supabase.com/docs/guides/getting-started/mcp)
3. [Supabase Security Retro: 2025](https://supabase.com/blog/supabase-security-2025-retro)
4. [Supabase Security Best Practices for Production Apps — Bastion](https://bastion.tech/blog/supabase-security-best-practices/)
5. [Overview — Claude Code Docs](https://code.claude.com/docs/en/overview)

---

## Key Takeaways

- **MCP = developer tool, not production bridge** — เชื่อมเฉพาะ dev project, approve ทุก tool call
- **RLS ไม่ optional** — ถ้า table ไม่มี RLS = database เปิดให้ทุกคน query ผ่าน anon key
- **`service_role` key bypass RLS ทั้งหมด** — เก็บไว้ server-side เท่านั้น, ห้ามอยู่ใน client bundle
- **`(SELECT auth.uid())` เร็วกว่า `auth.uid()`** ใน RLS policies — optimizer cache ต่อ statement
- **CLAUDE.md คือ security anchor** — เขียนกฎ security ไว้ชัด AI จะ generate code ตาม pattern นั้น
- **Next.js `NEXT_PUBLIC_` prefix** inject variable เข้า client bundle อัตโนมัติ — ห้ามใช้กับ secrets
- **Test RLS ด้วย anon key ก่อน deploy** — curl หรือ Supabase Dashboard > Table Editor > Policies test
