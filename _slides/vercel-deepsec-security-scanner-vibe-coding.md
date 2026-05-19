---
marp: true
theme: default
paginate: true
---

# Vercel deepsec: เครื่องมือสแกนช่องโหว่ Open-source สำหรับ Vibe Coding

**AI Security Harness สำหรับ codebase ที่ generate ด้วย AI**

---

## TL;DR

- **deepsec** = open-source security harness powered by AI Coding Agents
- 5-stage pipeline: `scan` → `process` → `revalidate` → `enrich` → `export`
- ออกแบบมาสำหรับ Vibe coding — scan ทั้ง repo ขนาดใหญ่ได้ ไม่ใช่แค่ per-PR

---

## ทำไม Vibe Coding ถึงต้องการ Security Tool ใหม่

3 ปัญหาที่ human review จัดการไม่ไหว:

- **Scale**: AI generate โค้ดหมื่นบรรทัด/วัน — review มือไม่ทัน
- **Context loss**: LLM ไม่ trace data flow ข้าม module → ช่องโหว่ที่ boundary
- **OWASP gap**: injection, missing rate limiting, insecure deserialization ไม่อยู่ใน AI default prompt

deepsec แก้ด้วย AI agent ที่เข้าใจ semantic ของโค้ด ไม่ใช่แค่ static linter

---

## Pipeline 5 ขั้นตอน (1/2)

| Stage | Command | วิธีทำงาน | ใช้ AI? |
|-------|---------|-----------|---------|
| 1 | `scan` | Regex หา candidate files น่าสงสัย | ไม่ (เร็ว, ฟรี) |
| 2 | `process` | AI trace data flow + ตรวจ mitigation | ใช่ |
| 3 | `revalidate` | AI ตัวที่ 2 ตรวจซ้ำ + ตรวจ git history | ใช่ |

> แยก `scan` (Regex) ออกจาก `process` (LLM) — LLM เรียกเฉพาะ files ที่ผ่าน filter แล้ว

---

## Pipeline 5 ขั้นตอน (2/2)

| Stage | Command | วิธีทำงาน | ใช้ AI? |
|-------|---------|-----------|---------|
| 4 | `enrich` | เพิ่ม git metadata — ใครเขียนโค้ดส่วนนั้น | ไม่ |
| 5 | `export` | ส่งออก JSON หรือ Markdown | ไม่ |

คำสั่งเพิ่มเติม:

| Command | วัตถุประสงค์ |
|---------|-------------|
| `process --diff` | PR mode — สแกนเฉพาะ files ที่เปลี่ยน |
| `triage` | จัด severity ด้วย model ถูกกว่า |
| `report` | สรุป Markdown + JSON ระดับ project |
| `sandbox <cmd>` | Vercel Sandbox microVMs (parallel) |

---

## AI Models + Scale

**Models ใน `process` stage:**
- Claude Opus 4.7 (extended thinking)
- GPT-5.5 (xhigh reasoning)

เลือก model reasoning ลึก เพราะ security ต้องการ multi-step trace ไม่ใช่ pattern match

**Scale ผ่าน Vercel Sandboxes:**
- Local: sequential, อาจใช้เวลาหลายวันกับ repo ใหญ่
- Sandboxes: fan-out parallel workers → ลดเหลือชั่วโมง

---

## Steps 1–2: ติดตั้ง + สแกน

**Step 1: ติดตั้ง**
```bash
npx deepsec init     # bootstrap → สร้าง .deepsec/
cd .deepsec
pnpm install
export AI_GATEWAY_API_KEY="your-key"   # หรือ ANTHROPIC/OPENAI key
```

**Step 2: Scan (ไม่ใช้ AI)**
```bash
pnpm deepsec scan
```
ผลลัพธ์: รายการ files ที่มี pattern น่าสงสัย เช่น `db.query(` ที่ไม่ sanitize

---

## Steps 3–4: Process + Revalidate

**Step 3: AI วิเคราะห์เชิงลึก**
```bash
pnpm deepsec process          # ทั้ง repo
pnpm deepsec process --diff   # เฉพาะ files ที่เปลี่ยน (PR mode)
```
AI trace data flow, ตรวจ validation, auth, rate limiting → findings + severity

**Step 4: ลด false positive**
```bash
pnpm deepsec revalidate
```
AI ตัวที่ 2 + ตรวจ git history → ลด false positive จาก ~30-40% เหลือ ~10-20%

---

## Steps 5–6: Export + OpenSpec

**Step 5: ส่งออกรายงาน**
```bash
pnpm deepsec enrich   # เพิ่มข้อมูลผู้รับผิดชอบ
pnpm deepsec export   # JSON หรือ Markdown
pnpm deepsec report   # สรุป project-level
```

**Step 6: ส่งต่อไปยัง Spec-driven tools**

บริบทจาก deepsec → OpenSpec → fix plan → implement

deepsec บอก "ตรงไหนเสี่ยง" / OpenSpec บอก "แก้อย่างไร"

---

## Caveats / Limits

- **False positive ~10-20%**: revalidate ลดแล้ว แต่ยังต้อง human review
- **ไม่เหมาะกับ libraries/frameworks**: ออกแบบสำหรับ applications ที่มี entry point ชัดเจน
- **Large repo = เวลานาน**: single machine อาจหลายวัน → ใช้ Vercel Sandboxes
- **ต้องการ API key**: `process` + `revalidate` เรียก Claude/GPT → มีค่าใช้จ่าย
- **ไม่ใช่ real-time**: batch scan ไม่ใช่ inline IDE — ใช้คู่กับ IDE plugin

---

## Key Takeaways

- **5-stage pipeline**: `scan` (Regex, ฟรี) → `process` (AI) → `revalidate` → `enrich` → `export`
- ออกแบบสำหรับ **Vibe coding** — scan ทั้ง repo ได้ ไม่ใช่แค่ per-PR
- `revalidate` ตรวจ **git history** → ลด false positive เหลือ ~10-20%
- **scale** ผ่าน Vercel Sandboxes microVMs (parallel workers)
- Apache 2.0, ต้องการ **Anthropic หรือ OpenAI API key** สำหรับ AI stages
