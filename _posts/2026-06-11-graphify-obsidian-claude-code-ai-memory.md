---
title: "Graphify + Obsidian + Claude Code: Second Brain สำหรับ AI ที่ประหยัด Token ถึง 71.5 เท่า"
date: 2026-06-10 00:02:00 +0700
categories: [Engineering]
tags: [graphify, obsidian, claude-code, knowledge-graph, ai-memory, token-optimization]
---

## TL;DR

Graphify แปลงโค้ดเบสหรือโฟลเดอร์เอกสารให้เป็น Knowledge Graph แบบ local โดยใช้ AST parsing ผ่าน tree-sitter แล้ว export ออกมาเป็น Obsidian Vault (Markdown + wikilinks) เชื่อมกับ Claude Code ผ่าน CLAUDE.md ทำให้ AI ค้นข้อมูลเป็น graph query แทนการอ่านไฟล์ซ้ำทุก session — ช่วยประหยัด token ได้สูงสุด 71.5 เท่า

## Background / Why this matters

ปัญหาหลักของ Claude Code (และ AI coding assistant ทุกตัว) คือ **amnesia between sessions** — ทุกครั้งที่เริ่ม session ใหม่ AI ต้องอ่านไฟล์ทั้งหมดซ้ำตั้งแต่ต้น งานวิจัยชี้ว่า session ทั่วไปใช้ ~20,000 tokens แค่เพื่ออ่านโค้ดเบสใหม่จาก 40 ไฟล์ ยิ่งโปรเจกต์ใหญ่ขึ้น cost ก็พุ่งแบบ quadratic

**Graphify** แก้ปัญหานี้ด้วย Knowledge Graph ที่ build ครั้งเดียวแล้วใช้ซ้ำได้ตลอด: แทนที่จะส่งไฟล์ทั้งหมดเข้า context window ทุกครั้ง Claude Code query graph เฉพาะส่วนที่เกี่ยวข้อง ลด token ใช้จริงต่อ query ลงได้ถึง 499x ในบางกรณี

เมื่อรวมกับ **Obsidian** ในฐานะ "second brain" ที่เก็บ notes, session logs, และ architecture decisions ข้ามโปรเจกต์ได้ — ระบบนี้กลายเป็น persistent memory layer ที่ AI ใช้ได้โดยตรง ไม่ถูกจำกัดอยู่ใน context window เดิม

## Deep Dive

### Graphify คืออะไร

Graphify เป็น open-source knowledge graph skill สำหรับ AI coding assistant — รองรับ Claude Code, Cursor, Gemini CLI, GitHub Copilot CLI, Aider, Codex, OpenCode, Kimi Code และอีกหลายตัว

package PyPI ชื่อ `graphifyy` (double-y); CLI command คือ `graphify`

ผลลัพธ์จากการรัน `graphify .` มี 3 ไฟล์:

| ไฟล์ | ใช้งาน |
|------|--------|
| `graph.json` | structured graph data — query ซ้ำได้โดยไม่ต้อง re-read |
| `graph.html` | interactive visualization พร้อม clickable nodes |
| `GRAPH_REPORT.md` | สรุป high-centrality components + suggested queries |

### How Graphify Works Technically

Graphify ใช้ **3-pass extraction pipeline**:

**Pass 1 — AST Parsing (100% local, ใช้ 0 tokens)**
- ใช้ [tree-sitter](https://tree-sitter.github.io/) parse โค้ด 28 ภาษา
- extract: functions, classes, imports, call chains
- ข้อดีเหนือ embeddings: exact structural relationships (อะไรเรียกอะไร, อะไร import อะไร) ไม่ใช่ probabilistic similarity

**Pass 2 — Whisper Transcription**
- สำหรับไฟล์ audio/video ในโปรเจกต์
- แปลง meeting recordings หรือ video docs เป็น text ก่อน index

**Pass 3 — Claude Semantic Extraction**
- วิเคราะห์ design rationale จาก docs, PDFs, images
- ต้องใช้ API key (หรือ `--backend ollama` สำหรับ full local)

**Graph clustering** ใช้ **Leiden community detection** — หา clusters จาก edge density แทน vector-based RAG ทำให้ topologically similar nodes อยู่ cluster เดียวกัน

### Obsidian Vault Structure

Vault เดี่ยวที่แนะนำให้ใช้ข้ามทุกโปรเจกต์ (ไม่ใช่ 1 vault ต่อ 1 โปรเจกต์) มีโครงสร้างดังนี้:

```
~/vault/
├── CLAUDE.md                    ← global instructions ที่ Claude Code อ่านอัตโนมัติ
├── permanent/                   ← Zettelkasten atomic notes
├── logs/                        ← session records จาก /save
├── chats/
│   ├── code/                    ← imported Claude Code conversations
│   └── web/                     ← imported Claude Web conversations
├── graphify/
│   └── project-name/            ← knowledge graph ของแต่ละโปรเจกต์
└── project-folders/
    └── project-name/            ← architecture decisions, pipelines
```

vault เดี่ยวทำให้ note "Supabase Auth" ใน project A link ไปยัง project B ได้ทันที — ความรู้สะสมแบบ compound ข้ามโปรเจกต์

### Claude Code Integration

Claude Code อ่าน `CLAUDE.md` ที่ root ของ vault อัตโนมัติ ควรใส่ "Context Navigation" section ที่บอกให้ query `graph.json` ก่อนอ่านไฟล์โค้ดตรงๆ:

```markdown
## Context Navigation
Before reading raw source files, query the knowledge graph:
- Project graph: ~/vault/graphify/project-name/graph.json
- Architecture decisions: ~/vault/project-folders/project-name/
- Recent session: ~/vault/logs/ (sort by date)
```

Claude Code เข้าถึง vault ผ่านได้ 2 วิธี:
1. **Direct file read** — CLAUDE.md reference path → Read tool
2. **MCP Bridge** — ใช้ `obsidian-claude-code-mcp` plugin ให้ query vault เป็น external data source ไม่รก codebase

### Token Savings Architecture

| Layer | Tool | Token Reduction |
|-------|------|-----------------|
| Project memory | Obsidian Zettelkasten | ตัด re-explanation ทั้งหมด |
| Code structure | Graphify graph queries | 499x ต่อ query |
| Conversation history | Chat import pipeline | ไม่สูญเสีย insights เก่า |
| **รวม** | | **สูงสุด 71.5x ต่อ session** |

### Automation & Hooks

**Git Hook (auto-rebuild on commit):**
```bash
graphify hook install
```
Post-commit hook รัน `graphify update .` อัตโนมัติ — rebuild เฉพาะไฟล์ที่เปลี่ยน

**Cron Job (daily chat import):**
```bash
# crontab -e
0 22 * * * bash ~/scripts/sync_claude_obsidian.sh
```
sync Claude conversations → vault ทุกวัน export frontmatter + tags + wikilinks อัตโนมัติ

**Session Commands (ใน CLAUDE.md):**
- `/resume` — อ่าน recent logs + architecture decisions เพื่อ restore context
- `/save` — สร้าง timestamped session log + wikilinks + git commit

## User Guide (Step-by-Step)

### 1. ติดตั้ง Graphify

```bash
# แนะนำ uv (จัดการ PATH ให้อัตโนมัติ)
uv tool install graphifyy

# หรือ pipx
pipx install graphifyy

# register skill ใน AI assistant profile
graphify install

# project-scoped (เฉพาะโปรเจกต์นี้)
graphify install --project
```

> หมายเหตุ: PyPI package ชื่อ `graphifyy` (สะกด double-y) แต่ CLI command คือ `graphify` (y เดียว)

### 2. สร้าง Knowledge Graph

```bash
# รันใน root ของโปรเจกต์
graphify .

# ผลลัพธ์: graph.json, graph.html, GRAPH_REPORT.md
```

สำหรับโปรเจกต์ขนาดใหญ่ (>5,000 nodes) ข้าม HTML visualization:

```bash
graphify . --no-viz
```

อัพเดตเฉพาะไฟล์ที่เปลี่ยน:

```bash
graphify --update
# หรือ skill command:
/graphify . --update
```

### 3. Export เป็น Obsidian Vault

```bash
graphify . --obsidian --obsidian-dir ~/vault/graphify/project-name
```

คำสั่งนี้สร้าง Markdown files พร้อม `[[wikilinks]]` ใน vault — แต่ละ node ใน graph กลายเป็นหน้า Obsidian ที่ link กลับไปยัง source file ต้นฉบับ

### 4. เชื่อม Claude Code กับ Vault

เพิ่ม "Context Navigation" ใน `CLAUDE.md` ของโปรเจกต์:

```markdown
## Context Navigation
Query knowledge graph before reading source files:
- Graph: ~/vault/graphify/your-project/GRAPH_REPORT.md
- For targeted queries: graph.json (via graph MCP or direct read)
```

Claude Code จะ reference vault ใน session แทนอ่านทุกไฟล์ซ้ำ

### 5. ติดตั้ง Git Hook

```bash
graphify hook install
```

ทดสอบ: แก้ไขไฟล์ → commit → ดูว่า `graph.json` update timestamp เปลี่ยน

### 6. Cross-project Queries

```bash
# รวม graph หลายโปรเจกต์เป็น unified map
graphify merge-graphs ~/project-a/graph.json ~/project-b/graph.json \
  -o ~/vault/graphify/merged.json
```

ใช้กรณีต้องการให้ Claude Code เห็น dependency ข้ามโปรเจกต์

### Troubleshooting

| ปัญหา | สาเหตุ | แก้ไข |
|-------|--------|--------|
| `graphify: command not found` | PATH ไม่รวม tool dir | ใช้ `uv tool install` หรือ `pipx` แทน `pip` |
| Skill เวอร์ชันเก่า | ไม่ได้ upgrade หลัง install | `uv tool upgrade graphifyy && graphify install` |
| `/graphify .` ไม่ทำงานใน PowerShell | `/` คือ path separator ใน PS | ใช้ `graphify .` แทน |
| HTML ไม่สร้าง, process ค้าง | graph ใหญ่เกิน 5,000 nodes | เพิ่ม flag `--no-viz` |

## Caveats / Limits

- **Code extraction เป็น local เสมอ** — tree-sitter ไม่ส่งข้อมูลออก แต่ docs/PDFs/images ผ่าน AI backend (ตั้งค่า `--backend ollama` สำหรับ full local)
- **AST ไม่ใช่ embeddings** — ได้ exact structure ไม่ได้ semantic similarity; ถามว่า "concept ที่คล้ายกัน" อาจ miss ถ้าไม่ได้ link กันใน code
- **Obsidian vault sync ไม่ real-time** — git hook rebuild เมื่อ commit เท่านั้น; uncommitted changes ไม่ปรากฏใน graph
- **Token savings ขึ้นกับขนาดโปรเจกต์** — 71.5x เป็นตัวเลขสูงสุดจาก large codebase; small project ได้ผลน้อยกว่า
- **merge-graphs ยังเป็น experimental** — ใช้ได้แต่ edge ข้ามโปรเจกต์อาจไม่ครบ

## References

1. [GitHub — safishamsi/graphify](https://github.com/safishamsi/graphify) — official repo, README, command reference
2. [GitHub — lucasrosati/claude-code-memory-setup](https://github.com/lucasrosati/claude-code-memory-setup) — Obsidian + Graphify + Claude Code setup (71.5x token savings)
3. [The Ultimate Claude Code Setup: Integrating Graphify and Obsidian for Infinite Context — Artimind](https://aiartimind.com/the-ultimate-claude-code-setup-integrating-graphify-and-obsidian-for-infinite-context/)
4. [Graphify + code-review-graph: Build a Self-Updating Knowledge Graph — DEV Community](https://dev.to/mir_mursalin_ankur/graphify-code-review-graph-build-a-self-updating-knowledge-graph-for-claude-code-and-other-ai-j1m)
5. [Graphify + Obsidian + Claude Code: The Token-Saving Second Brain Setup — Medium](https://medium.com/ai-systems-lab/graphify-obsidian-claude-code-the-token-saving-second-brain-setup-b1af686ac264)
6. [YouTube — Graphify + Obsidian + Claude Code Demo](https://youtu.be/mWLDn49_8HA) — source video สำหรับ post นี้

## Key Takeaways

- Graphify สร้าง Knowledge Graph จากโค้ดเบส/docs ผ่าน tree-sitter (local, 0 tokens) + Leiden clustering; output: `graph.json`, `graph.html`, `GRAPH_REPORT.md`
- PyPI package ชื่อ `graphifyy` (double-y); CLI command: `graphify`; install ผ่าน `uv tool install graphifyy` แล้วตาม `graphify install`
- Export เป็น Obsidian Vault ด้วย `--obsidian --obsidian-dir ~/vault/graphify/<project>` — ได้ Markdown + wikilinks link กลับ source docs
- Claude Code อ่าน vault ผ่าน `CLAUDE.md` "Context Navigation" section — query graph แทนอ่านไฟล์ตรง
- ประหยัด token สูงสุด 71.5x ต่อ session จาก 3 layer: Zettelkasten memory + graph queries + chat import pipeline
- Vault เดี่ยวข้ามโปรเจกต์ดีกว่า 1 vault ต่อโปรเจกต์ — ความรู้ compound ได้, wikilinks ข้าม repo ทำงานได้
- Git hook (`graphify hook install`) + cron sync = graph อัพเดตอัตโนมัติ ไม่ต้อง manual rebuild
