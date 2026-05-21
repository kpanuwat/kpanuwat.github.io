---
title: "Prompt Caching: กลยุทธ์ลดต้นทุน Claude Code อย่างยั่งยืน"
date: 2026-05-22 12:00:00 +0700
categories: [Engineering]
tags: [prompt-caching, claude-code, llm, cost-optimization, anthropic]
---

## TL;DR

Prompt Caching ช่วยลดต้นทุน Token สูงสุด **90%** โดยเก็บ context ที่ซ้ำกันไว้ใน cache — cache read ราคาเพียง **10% ของ input ปกติ** กุญแจสำคัญคือรักษาความเสถียรของ prefix (system prompt, `CLAUDE.md`, tool definitions) และเลือก TTL ให้เหมาะกับ workflow

## Background / Why this matters

ทุกครั้งที่ส่ง request ไปยัง Claude API โดยไม่มี caching ระบบจะอ่าน token ทั้งหมดใหม่ตั้งแต่ต้น — ทั้ง system prompt, context ประวัติการสนทนา, tool definitions สิ่งเหล่านี้มักไม่เปลี่ยนระหว่าง request แต่คุณจ่ายราคาเต็มทุกครั้ง

สำหรับ Claude Code ที่ทำงานกับ codebase ขนาดใหญ่ปัญหานี้ยิ่งชัดเจน: `CLAUDE.md` หลายร้อย token, rule files, memory files — ทั้งหมดนี้ถูก inject ซ้ำทุก turn โดยไม่จำเป็น

Prompt Caching แก้ปัญหานี้โดยเก็บ "prefix" ของ prompt ไว้ใน cache และ reuse ได้ราคาถูก การเข้าใจกลไกนี้เปลี่ยนวิธีออกแบบ prompt และ session management อย่างมีนัยสำคัญ

## Deep Dive

### ราคา: Cache Write vs Cache Read

Prompt Caching มี 2 tier ราคา ขึ้นอยู่กับ TTL ที่เลือก:

| Operation | ราคา (relative to base input) |
|-----------|-------------------------------|
| Cache write (5-min TTL) | **1.25x** base input price |
| Cache write (1-hour TTL) | **2x** base input price |
| Cache read (hit) | **0.1x** base input price (ประหยัด 90%) |
| Output tokens | ปกติ (caching ไม่กระทบ output) |

ตัวอย่าง Claude Opus 4.7 (base $5/MTok):
- Cache write 5-min: $6.25/MTok
- Cache write 1-hr: $10/MTok
- **Cache read: $0.50/MTok** ← นี่คือเป้าหมาย

"จ่ายแพงขึ้นตอน write เพื่อประหยัดมากตอน read" — breakeven เกิดเร็วมากถ้า cache ถูก hit หลายครั้ง

### TTL: เลือกให้เหมาะกับ Workflow

**5-minute TTL (default)**
- Refresh อัตโนมัติทุกครั้งที่ hit (ไม่เสียค่าใช้จ่ายเพิ่ม)
- เหมาะกับ multi-turn conversation ที่ต่อเนื่อง, debugging session, rapid iteration

**1-hour TTL (extended)**
ต้องระบุ `"ttl": "1h"` ใน `cache_control`:
```json
{ "cache_control": { "type": "ephemeral", "ttl": "1h" } }
```
- เหมาะกับ agentic workflow ที่มี pause ระหว่าง step, user session ที่ irregular, latency-sensitive app

### Prefix Matching: กลไกสำคัญที่ต้องเข้าใจ

Cache ทำงานโดย **hash prefix** — ระบบจะ hash ทุกอย่างตั้งแต่ต้นจนถึง `cache_control` breakpoint และเก็บไว้

```
[tools][system][messages...][cache_control here] → hash → lookup
```

**กฎหลัก 3 ข้อ:**

1. **Breakpoint ต้องอยู่บน stable content**
   ถ้า content ที่ breakpoint เปลี่ยนทุก request (เช่น timestamp, dynamic data) → hash ไม่ตรงเลย → จ่าย write ทุกครั้ง, hit = 0

2. **Hierarchy ของ cache**: `tools` → `system` → `messages`
   การเปลี่ยน `tools` invalidate ทุกอย่าง; เปลี่ยน `system` invalidate system+messages; เปลี่ยน messages กระทบแค่ messages

3. **20-block lookback window**
   ระบบ walk backward สูงสุด 20 block เพื่อหา match สำหรับ conversation ยาวๆ ควรมี breakpoint หลายจุด

**ตัวอย่างที่ถูกต้อง:**
```python
system=[
    {
        "type": "text",
        "text": "You are a software engineer assistant...",  # stable
        "cache_control": {"type": "ephemeral"}  # ✓ breakpoint บน stable content
    },
    {
        "type": "text",
        "text": f"Current task: {dynamic_task}"  # เปลี่ยนทุก request — ไม่มี cache_control
    }
]
```

### Cache Invalidation Triggers

| การเปลี่ยนแปลง | ผลกระทบ |
|----------------|----------|
| แก้ไข tool definitions | ❌ cache ทั้งหมด invalid |
| toggle web search / citations | ❌ system + messages invalid |
| เปลี่ยน `tool_choice` parameter | ❌ messages invalid |
| เพิ่ม/ลบ images | ❌ messages invalid |
| เปลี่ยน extended thinking settings | ❌ messages invalid |
| **สลับ model** | ❌ **cache reset ทั้งหมด** |

การสลับ model ระหว่าง session เป็น cache killer ที่พบบ่อยที่สุด — ทุก cached token ต้องถูก re-process ใหม่

## User Guide (Step-by-Step)

### Step 1: รักษาความเสถียรของ Global Rules

สำหรับ Claude Code: ไฟล์ที่ inject ทุก session (`CLAUDE.md`, memory files, skill files) คือ cache prefix ที่มีค่าที่สุด

- ห้ามแก้ `CLAUDE.md` บ่อยโดยไม่จำเป็น — ทุกการเปลี่ยนแปลงทำให้ system prompt เปลี่ยน → cache miss
- จัด dynamic content (task, context ชั่วคราว) ไว้ท้าย prompt ไม่ใช่ต้น
- ใช้ session เดิมต่อเนื่องแทนการเริ่ม session ใหม่ทุกครั้ง

### Step 2: เลือก TTL ให้เหมาะกับ Workflow

```python
# สำหรับ conversation ทั่วไป — 5-min TTL (default)
response = client.messages.create(
    model="claude-opus-4-7",
    max_tokens=1024,
    cache_control={"type": "ephemeral"},  # single line, system จัดการ breakpoint
    system="Long system prompt...",
    messages=conversation_history
)

# สำหรับ agentic workflow ที่มี pause นาน — 1-hour TTL
system=[{
    "type": "text",
    "text": "Company handbook (updates quarterly)...",
    "cache_control": {"type": "ephemeral", "ttl": "1h"}
}]
```

### Step 3: ตรวจสอบ Token Dashboard

Response ทุกอันมี usage stats ที่บอกว่า cache ทำงานจริงหรือเปล่า:

```python
response = client.messages.create(...)
usage = response.usage

print(f"Cache reads:  {usage.cache_read_input_tokens}")    # tokens ที่ hit cache
print(f"Cache writes: {usage.cache_creation_input_tokens}") # tokens ที่ถูก cache ครั้งแรก
print(f"New input:    {usage.input_tokens}")                # tokens ใหม่ที่ไม่ได้ cache

# ถ้า cache_creation_input_tokens = 0 และ cache_read_input_tokens = 0
# → caching ไม่เกิดขึ้น ตรวจสอบ minimum token threshold
```

สำหรับ Claude Code ใช้ `/cost` command เพื่อดู token breakdown ของ session ปัจจุบัน

### Step 4: Pre-warm Cache สำหรับ Latency-Sensitive App

```python
# Fire ก่อน user มาถึง — write cache ล่วงหน้า
client.messages.create(
    model="claude-opus-4-7",
    max_tokens=1,
    system=[{
        "type": "text",
        "text": "Expert system prompt (3000+ tokens)...",
        "cache_control": {"type": "ephemeral"}
    }],
    messages=[{"role": "user", "content": "warmup"}]
)
# Real requests ที่มาทีหลังจะ hit warm cache → TTFT ลดลงมาก
```

### Step 5: Multiple Breakpoints สำหรับ Content ที่เปลี่ยนความถี่ต่างกัน

```python
tools=[
    tool_1, tool_2,
    {**tool_3, "cache_control": {"type": "ephemeral"}},  # tools เปลี่ยนน้อย → cache
],
system=[
    {
        "type": "text",
        "text": "Static instructions...",
        "cache_control": {"type": "ephemeral"}  # เปลี่ยนน้อยมาก
    },
    {
        "type": "text",
        "text": "Daily context..."  # อัปเดตทุกวัน — ไม่ cache
    }
],
messages=[...]  # automatic caching สำหรับ conversation history
```

## Caveats / Limits

**Minimum token threshold** — ถ้า prompt สั้นกว่า threshold ระบบไม่ cache (ไม่มี error, แค่ไม่เกิด):

| Model | Minimum tokens |
|-------|----------------|
| Claude Opus 4.7, 4.6, 4.5 | 4,096 |
| Claude Sonnet 4.6, 4.5 | 1,024 |
| Claude Haiku 4.5 | 4,096 |

**Cache isolation** — Bedrock และ Vertex AI ใช้ organization-level isolation; Claude API ใช้ workspace-level — cache ไม่ข้าม workspace

**Tool ordering** — JSON key ordering มีผลต่อ cache hash โดยเฉพาะใน Go และ Swift ที่ map key order ไม่ deterministic — serialize tools ให้ consistent ทุกครั้ง

**Extended thinking** — Thinking blocks ไม่สามารถใส่ `cache_control` โดยตรงได้; แต่ preserved ได้ใน multi-turn (Opus 4.5+ / Sonnet 4.6+)

**Cost ตอน write สูงกว่าปกติ** — request แรกที่ write cache จ่าย 1.25x หรือ 2x; ถ้า hit rate ต่ำมากอาจไม่คุ้ม — ตรวจสอบ `cache_creation_input_tokens` vs `cache_read_input_tokens` ratio เป็น KPI

## References

1. [Anthropic Prompt Caching Documentation](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching) — official docs, pricing tables, code examples
2. [Cache Diagnostics API (beta)](https://docs.anthropic.com/en/docs/build-with-claude/cache-diagnostics) — เครื่องมือ debug cache misses
3. [Prompt Caching: กลยุทธ์ลดต้นทุนและยืดอายุเซสชัน (Video)](https://youtu.be/6cEQEba0i2A) — source video ของ post นี้

## Key Takeaways

- Cache read ราคา **0.1x** (ประหยัด 90%) — เป้าหมายคือ maximize cache hits ไม่ใช่แค่ enable caching
- มี **2 TTL**: 5-min default (1.25x write) และ 1-hr extended (2x write); เลือกตาม workflow
- **Model switching = cache reset** — อย่าสลับ model ระหว่าง session ที่ต้องการ cache
- รักษาความเสถียรของ **prefix** — `CLAUDE.md`, system prompt, tool definitions ต้องเปลี่ยนน้อยที่สุด
- ตรวจสอบ **`cache_read_input_tokens`** ใน response usage — ตัวเลขนี้บอกว่า caching ทำงานจริงหรือเปล่า
- Breakpoint ต้องอยู่บน **stable content** — ถ้าใส่บน dynamic content (timestamp, task ID) จะไม่มี cache hit เลย
- Pre-warm cache สำหรับ latency-critical app โดย fire warmup request ก่อน users มาถึง
