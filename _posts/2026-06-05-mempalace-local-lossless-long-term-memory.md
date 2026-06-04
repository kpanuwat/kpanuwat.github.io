---
title: "MemPalace — Local Lossless Long-term Memory สำหรับ AI"
date: 2026-06-04 00:01:00 +0700
categories: [Tools]
tags: [memory, ai-tools, claude-code, mcp, local-first, chromadb, llm]
slides: true
---

{% include slide-link.html %}

## TL;DR

MemPalace คือระบบ Long-term Memory แบบ Local-first สำหรับ AI ที่เก็บประวัติการสนทนาแบบ Verbatim (คำต่อคำ) ไม่สรุปเอง ทำให้ Claude หรือ AI tools อื่นๆ จดจำ Project context ได้ข้ามเซสชัน โดยใช้ ChromaDB + SQLite ทำงานทั้งหมดบนเครื่อง ไม่ส่งข้อมูลออกนอก รองรับ MCP และ Claude Code hooks

## Background / Why this matters

AI coding assistants เช่น Claude Code มีปัญหา fundamental อย่างหนึ่งคือ **context window ที่จำกัด** เมื่อปิดเซสชัน ความรู้เกี่ยวกับ project ที่สร้างขึ้นทั้งหมดก็หายไป

ทางแก้ทั่วไปคือ `CLAUDE.md` หรือ memory files แต่ต้องเขียนด้วยตนเอง และมักสรุปเอาแต่ "สาระสำคัญ" ทิ้งรายละเอียดปลีกย่อยที่บางทีสำคัญมากไว้ ยิ่ง codebase ซับซ้อน ยิ่งยากที่จะรู้ล่วงหน้าว่าอะไรจะ matter ในอนาคต

MemPalace แก้ปัญหานี้ด้วยแนวคิด **"Lossless"** — เก็บทุกอย่างไว้ก่อน ค้นหาเมื่อต้องการ แทนการตัดสินใจล่วงหน้าว่าอะไรสำคัญ เสมือน hard drive ที่ AI ค้นหาได้ด้วย natural language

## Deep Dive

### Architecture: Palace Metaphor

MemPalace ใช้ Mental Model แบบ Memory Palace (Method of Loci) ในการจัด organize ข้อมูล:

| ระดับ | แทน | ตัวอย่าง |
|-------|-----|---------|
| **Wing** | Person / Project | `@alice`, `myapp/` |
| **Room** | Topic / Context | `auth`, `database`, `deploy` |
| **Drawer** | Individual Memory Unit | ข้อความ, file content, conversation turn |

โครงสร้างนี้ทำให้ navigation มี semantics ที่ intuitive — ไม่ใช่แค่ flat key-value store ทำให้ AI สามารถ "เดิน" หา context ที่เกี่ยวข้องได้อย่างมีทิศทาง

### Verbatim Storage vs. Summary-based Memory

| Feature | MemPalace | Mem0 / Traditional |
|---------|-----------|-------------------|
| Storage approach | Verbatim (คำต่อคำ) | LLM-generated summary |
| Information loss | ไม่มี | มี (summarization ตัดทิ้ง) |
| Privacy | Local only | Cloud API required |
| Cost | ฟรี (MIT) | $249/mo (Mem0 Pro) |
| Recall (LongMemEval R@5) | **96.6%** | ขึ้นกับ summary quality |

### Tech Stack

```
Conversation / Files
       ↓
 Sentence Transformers (all-MiniLM-L6-v2, 384-dim, CPU-only)
       ↓
   ┌──────────┬──────────────────────────┐
   │ ChromaDB │       SQLite             │
   │ (vector) │ (temporal KG + validity) │
   └──────────┴──────────────────────────┘
       ↓
  29 MCP Tools → Claude Code / ChatGPT / Cursor
```

- **ChromaDB**: Vector store สำหรับ semantic similarity search — ค้นหา "อะไรที่เกี่ยวข้อง" ด้วย embedding
- **SQLite**: Temporal entity-relationship knowledge graph — track ว่า fact ไหน "ยังคงจริงอยู่" ผ่าน validity window ใช้สำหรับ query เชิงเวลา (เช่น "API version ที่ใช้อยู่ตอนนี้คืออะไร")
- **Sentence Transformers**: Local embedding model ทำงานบน CPU, download ครั้งเดียว ~80MB (English) หรือ ~300MB (multilingual)

### 29 MCP Tools

ครอบคลุม 5 กลุ่มหลัก:

| กลุ่ม | หน้าที่ |
|-------|--------|
| Palace read/write | อ่าน/เขียน drawers และ rooms |
| Knowledge graph ops | เพิ่ม/query/invalidate temporal entities |
| Cross-wing navigation | ข้าม project contexts ได้ |
| Drawer management | organize, tag, expire memories |
| Agent diaries | structured log สำหรับ autonomous agents |

### Claude Code Hooks Integration

MemPalace ฝัง auto-save hooks ใน Claude Code ที่ทำงาน 2 จุดสำคัญ:

1. **Periodic during session**: บันทึก conversation turns ระหว่างทำงาน
2. **Pre-compression hook**: ก่อน Claude compresses context → `mempalace sweep` แปลง transcript เป็น drawers ก่อน

> ⚠ Claude Code sessions expire ใน 30 วัน ถ้าไม่มี auto-save hooks — ต้อง setup ก่อนใช้งานจริง

### Benchmark Performance

| Benchmark | Score | Mode |
|-----------|-------|------|
| LongMemEval R@5 | **96.6%** | Raw (no LLM reranking) |
| LongMemEval R@5 | **98.4%** | Hybrid (BM25 + vector) |
| LoCoMo R@10 | **88.9%** | Hybrid |
| ConvoMem | **92.9%** | Average recall |
| MemBench ACL 2025 | **80.3%** | R@5 |

อ้างอิงจาก MemPalace GitHub — ควร cross-check กับ leaderboard อิสระก่อน adopt ใน production

## User Guide (Step-by-Step)

### 1. Install

```bash
# แนะนำ — isolated environment:
uv tool install mempalace

# หรือ:
pipx install mempalace
```

### 2. Initialize Memory Palace

```bash
mempalace init ~/projects/myapp
```

สร้าง:
- `~/.mempalace/palace.db` — SQLite metadata และ knowledge graph
- `~/.mempalace/vectors/` — ChromaDB vector embeddings

ครั้งแรก download embedding model ~80MB (English) หรือ ~300MB (multilingual) — ต้องทำครั้งเดียว

### 3. Connect to Claude Code

```bash
# วิธีอัตโนมัติ (แนะนำ) — config ทุกอย่างให้เลย:
mempalace connect claude-code
```

หรือเพิ่ม MCP config ใน `~/.claude/settings.json` ด้วยตนเอง:

```json
{
  "mcpServers": {
    "mempalace": {
      "command": "mempalace",
      "args": ["serve", "--mcp"]
    }
  }
}
```

### 4. Daily Workflows

**บันทึก project convention:**
> "Remember that our API uses snake_case for all endpoints and deploys to AWS us-east-1."

**ค้นหาใน session ใหม่:**
> "What conventions does our API use?"

Claude recall ผ่าน MCP tool ใน <100ms โดย auto

**Index project files:**
```bash
mempalace mine ./src
```

**Load context เมื่อเริ่ม session ใหม่:**
```bash
mempalace wake-up
```

### 5. Troubleshooting

| ปัญหา | สาเหตุที่น่าจะเป็น | วิธีแก้ |
|-------|-------------|--------|
| Memory ไม่ถูก recall | hooks ไม่ได้ setup | `mempalace connect claude-code` อีกครั้ง |
| Session ไม่มี context | ไม่ได้ `sweep` ก่อน expire | `mempalace wake-up` ก่อนเริ่มงานทุกครั้ง |
| Embedding download ช้า | first-run model download | รอ ~80-300MB ครั้งเดียว |
| Search ไม่ accurate | memory ยังน้อย | `mempalace mine` index files เพิ่ม |

## Caveats / Limits

- **ไม่มี Admin/Dashboard**: ไม่เหมาะสำหรับ Enterprise ที่ต้องการ audit trail, permission management, หรือ multi-user control
- **ไม่มี Cloud backup**: ข้อมูลอยู่ local อย่างเดียว — เครื่องพังหรือ `~/.mempalace/` ถูกลบ = ข้อมูลหายหมด
- **Python 3.9+ required**: ไม่รองรับ Python เวอร์ชันเก่ากว่านี้
- **Disk footprint**: ~80-300MB สำหรับ embedding model + ~1MB ต่อ 1,000 memories
- **Benchmark claims**: ตัวเลข 96.6% มาจาก self-reported — ควร cross-check กับ leaderboard อิสระ (เช่น MemBench) ก่อนตัดสินใจ deploy ใน production
- **30-day session expiry**: Claude Code conversations expire ใน 30 วัน ถ้าไม่ setup auto-save hooks ครบ

## References

1. [MemPalace GitHub Repository](https://github.com/mempalace/mempalace)
2. [How to Add Persistent Memory to Claude Code — MemPalace.tech](https://www.mempalace.tech/blog/add-memory-to-claude-code)
3. [Install MemPalace in 5 Minutes Guide](https://www.mempalace.tech/guides/setup)
4. [MemPalace: 170 Tokens to Recall Everything (Technical Deep Dive)](https://recca0120.github.io/en/2026/04/08/mempalace-ai-memory-system/)
5. [MemPalace vs Mem0 Comparison](https://www.mempalace.tech/compare/mempalace-vs-mem0)
6. [MemPalace Review: Real AI Memory Innovation, Questionable Benchmark Claims](https://artificiallyintimidating.com/p/mempalace-ai-memory-review-benchmarks)
7. [MemPalace PyPI](https://pypi.org/project/mempalace/)
8. [MemPalace Demo Video — YouTube](https://youtu.be/kRACHOx1p8s)

## Key Takeaways

- MemPalace เก็บ memory แบบ **Verbatim** ไม่สรุป → ไม่เสียรายละเอียด เพราะไม่มีใครรู้ล่วงหน้าว่าอะไรจะสำคัญ
- Architecture แบบ Palace (Wing → Room → Drawer) ให้ semantic structure ที่ navigate ได้ ไม่ใช่แค่ flat store
- ทำงาน **Local-first** ทั้งหมด — ChromaDB + SQLite + local embedding model ไม่มีข้อมูลออกนอกเครื่อง
- **29 MCP tools** ให้ Claude Code เข้าถึง memory ได้โดยตรง retrieval <100ms
- Claude Code hooks auto-save ก่อน context compression — ป้องกัน context loss ที่เกิดขึ้นโดยไม่รู้ตัว
- Benchmark scores สูงมาก แต่ควร verify อิสระก่อน adopt ใน production
- ข้อจำกัดหลัก: ไม่มี Admin Dashboard สำหรับ Enterprise + ไม่มี Cloud backup
