---
title: "เจาะลึก Graphify: เปลี่ยนโค้ดและเอกสารเป็น Knowledge Graph ประหยัด Token ได้ถึง 71.5x"
date: 2026-05-26 00:01:00 +0700
categories: [Tools]
tags: [knowledge-graph, llm, claude-code, mcp, token-optimization]
slides: true
---

{% include slide-link.html %}

## TL;DR

Graphify เป็น open-source skill (MIT) ที่แปลงโค้ด, PDF, รูปภาพ และวิดีโอทั้งโฟลเดอร์ให้กลายเป็น Knowledge Graph แบบ queryable — ช่วยให้ AI coding assistant ดึงเฉพาะ node ที่เชื่อมโยงแทนการอ่านไฟล์ทุกไฟล์ ทดสอบแล้วว่าประหยัด token ได้สูงสุดถึง 71.5x บน codebase ขนาด 50k+ บรรทัด

## Background / Why this matters

ปัญหาหลักของ AI coding assistant คือ **context window หมดเร็วบน large codebase** เมื่อ Claude หรือ AI ตัวอื่นต้องค้นหา function หนึ่งในโปรเจกต์ขนาด 500+ ไฟล์ วิธี naive คือ `grep` หรืออ่านทุกไฟล์ — ใช้ token มหาศาล และบ่อยครั้งก็ยังหาไม่เจอเพราะ path ไม่ตรง

Graphify แก้ปัญหานี้ด้วยแนวคิด **graph-first navigation**: สร้าง index โครงสร้างโปรเจกต์ล่วงหน้าเป็น Knowledge Graph ที่ประกอบด้วย node (functions, classes, document sections, concepts) และ edge (calls, imports, references, inferred dependencies) เมื่อ AI ต้องการข้อมูล แทนที่จะ grep ทุกไฟล์ ก็เดิน graph edge ไปยัง subgraph ที่เกี่ยวข้องเท่านั้น

ผลลัพธ์ที่วัดได้: query ต้นทุนเฉลี่ย ~1,700 tokens แทน ~123,000 tokens แบบ naive — ลดได้ 71.5x บน codebase ขนาดใหญ่ [1][2]

## Deep Dive

### สถาปัตยกรรม Two-Pass Extraction

Graphify สร้าง graph ด้วยสองขั้นตอน:

**Pass 1 — AST (Local, ไม่ใช้ API):** ใช้ Tree-sitter parse source code ทุกภาษาที่รองรับ สกัด node และ edge แบบ structural (function calls, imports, class inheritance) ทำงาน local ทั้งหมด ไม่มีค่าใช้จ่าย API [3]

**Pass 2 — Semantic (AI Model API):** ใช้ AI model สกัด "inferred edges" — ความสัมพันธ์ที่ไม่ปรากฏใน AST เช่น conceptual links ระหว่าง document sections กับ code modules flag `--mode deep` เพิ่มความ aggressive ของ pass นี้

### Leiden Community Detection

หลังสร้าง graph แล้ว Graphify ใช้ Leiden algorithm จัดกลุ่ม node เป็น "communities" — cluster ของ node ที่เชื่อมโยงกันหนาแน่น ผลลัพธ์ถูกเขียนไปที่ `graphify-out/GRAPH_REPORT.md` ซึ่งสรุป "god nodes" (node ที่มี edge มากที่สุด), community structure, และ surprising connections [4]

### รองรับหลาย Source Types

ไม่ใช่แค่ code — Graphify ingest ได้ทั้ง:

| Source Type | ตัวอย่าง |
|---|---|
| Code & Scripts | Python, JS/TS, Go, Rust, SQL schemas, R, shell |
| Documents | PDF papers, markdown docs |
| URLs | arXiv papers, tweets, web pages |
| Media | รูปภาพ, วิดีโอ |

สำหรับ URL: `/graphify add https://arxiv.org/abs/...` ดึง paper แล้วเพิ่มเข้า graph อัตโนมัติ

### Export Formats

หลังสร้าง graph แล้ว export ได้หลายรูปแบบ:

- `--obsidian` → Obsidian vault พร้อม backlinks แบบ interactive
- `--mcp` → MCP stdio server สำหรับ agent integration
- `--wiki` → Wikipedia-style markdown per community
- `--neo4j` → Cypher queries สำหรับ Neo4j database
- `--svg` / `--graphml` → visual exports (Gephi, yEd)

### Claude Code Integration (PreToolUse Hook)

การ integrate กับ Claude Code ลึกที่สุดในบรรดา AI assistant ทั้งหมด:

```bash
pip install graphifyy      # note: double-y
graphify install
graphify claude install    # run inside your project
```

คำสั่ง `graphify claude install` ทำ 2 อย่างพร้อมกัน:
1. เขียน section ใน `CLAUDE.md` บอก Claude ให้อ่าน `graphify-out/GRAPH_REPORT.md` ก่อนตอบคำถาม architecture
2. ติดตั้ง **PreToolUse hook** ใน `settings.json` — hook นี้ fire ก่อนทุก `Glob` และ `Grep` call ถ้า knowledge graph มีอยู่ Claude จะเห็น: *"graphify: Knowledge graph exists. Read GRAPH_REPORT.md for god nodes and community structure before searching raw files."*

ผลคือ Claude navigate by structure ก่อน — ไม่ grep ทุกไฟล์โดยไม่จำเป็น

## User Guide (Step-by-Step)

### ขั้นตอนที่ 1: ติดตั้ง

```bash
pip install graphifyy   # PyPI package ใช้ชื่อ graphifyy (double-y)
graphify install        # setup initial config
```

> ข้อสังเกต: PyPI package ชื่อ `graphifyy` (y สองตัว) แต่ CLI command ใช้ `graphify` (y ตัวเดียว)

### ขั้นตอนที่ 2: สร้าง Knowledge Graph

```bash
# รันบน current directory
/graphify

# รันบน specific folder
/graphify ./src

# Deep mode: infer edge เพิ่มเติม (ใช้ API มากขึ้น)
/graphify ./src --mode deep

# อัปเดตเฉพาะไฟล์ที่เปลี่ยน
/graphify ./src --update

# Watch mode: rebuild อัตโนมัติเมื่อ file เปลี่ยน
/graphify ./src --watch
```

Output ถูก generate ไปที่ `graphify-out/` — ประกอบด้วย `graph.json`, `GRAPH_REPORT.md`, และ `graph.html` (interactive visualization)

### ขั้นตอนที่ 3: Query Graph

```bash
# ถามเรื่อง connection
/graphify query "what connects authentication to the database layer?"

# Trace path ระหว่าง 2 node
/graphify path "UserAuth" "DatabasePool"

# ดูทุกอย่างที่ Graphify รู้เกี่ยวกับ node
/graphify explain "PaymentService"

# จำกัด token budget
/graphify query "show the API flow" --budget 1500
```

### ขั้นตอนที่ 4: Claude Code Integration

```bash
graphify claude install   # ใช้ใน project root
```

หลังจากนี้ Claude จะ consult knowledge graph อัตโนมัติก่อนทุก file search

### ขั้นตอนที่ 5: Keep Graph Fresh

```bash
# Auto-rebuild หลัง git commit / branch switch
graphify hook install

# ตรวจสอบ hook status
graphify hook status
```

### ขั้นตอนที่ 6: Export เป็น Obsidian Vault

```bash
/graphify ./src --obsidian
```

สร้าง Obsidian vault ใน `graphify-out/obsidian/` — เปิดใน Obsidian แล้วดู graph view แบบ interactive ได้เลย

### ขั้นตอนที่ 7: เริ่ม MCP Server

```bash
/graphify ./src --mcp
```

Start MCP stdio server — ใช้ต่อกับ Claude Desktop หรือ agent ใดๆ ที่รองรับ MCP protocol สำหรับงาน cross-session codebase exploration

## Caveats / Limits

**Semantic pass ใช้ API calls:** Pass 2 (semantic extraction) ส่ง context ไปยัง AI model API — มีค่าใช้จ่าย token สำหรับโปรเจกต์ขนาดใหญ่ครั้งแรก ใช้ `--no-viz --cluster-only` หรือ AST-only pass เพื่อลดต้นทุนถ้าต้องการ

**Graph staleness:** Knowledge graph ที่ไม่ได้ update จะ out of sync กับโค้ด ใช้ `graphify hook install` หรือ `--watch` เพื่อ auto-rebuild

**ตัวเลข token savings ขึ้นกับ task type:** 71.5x เป็น case ที่ดีที่สุด (large codebase, structural navigation tasks) — task ที่ต้องการอ่าน full file content จะได้ savings น้อยกว่า (ทดสอบพบ 6.8x–49x ขึ้นกับ query type) [2]

**PyPI name ต่างจาก CLI:** `pip install graphifyy` (สองตัว y) แต่ใช้งานด้วย `graphify` (ตัว y เดียว) — สับสนได้ง่าย

**Media extraction ยังทดลองอยู่:** PDF และรูปภาพ ingest ได้ แต่ quality ของ edge extraction จาก non-code sources อาจไม่สม่ำเสมอเท่า code sources

## References

1. [Graphify Official Site — graphify.net](https://graphify.net/)
2. [Graphify CLI Command Reference](https://graphify.net/graphify-cli-commands.html)
3. [Graphify + Claude Code Integration](https://graphify.net/graphify-claude-code-integration.html)
4. [Graphify GitHub — safishamsi/graphify](https://github.com/safishamsi/graphify)
5. [Graphify + Claude Code: Token Usage 71x — Medium](https://medium.com/@manavghosh/graphify-claude-code-how-i-cut-token-usage-by-71x-on-a-50k-line-codebase-74868ac67fd1)
6. [claude-code-memory-setup — Up to 71.5x fewer tokens](https://github.com/lucasrosati/claude-code-memory-setup)
7. [Graphify: Build Knowledge Graph Without Sending Code — GoPenAI](https://blog.gopenai.com/graphify-build-a-knowledge-graph-from-your-entire-codebase-without-sending-your-code-to-anyone-1b6924474b50)
8. [YouTube Demo 1 — Graphify with Claude Code](https://youtu.be/HQEm4rBKdec)
9. [YouTube Demo 2 — Graphify Plugin Overview (Thai)](https://youtu.be/ltzlw983s3s)

## Key Takeaways

- Graphify แปลงทุก folder (code, docs, PDF, image, video) เป็น queryable Knowledge Graph — AI เดิน graph แทน grep ไฟล์ดิบ
- ประหยัด token ได้ 6.8x–71.5x ขึ้นกับ codebase size และ query type; ใหญ่และ structural = ประหยัดมากกว่า
- Two-pass: Tree-sitter AST (local, free) + semantic pass (AI API) — `--mode deep` เพิ่ม inferred edges ใน pass 2
- Claude Code integration ลึกที่สุด: `graphify claude install` ติดตั้ง CLAUDE.md directive + PreToolUse hook พร้อมกัน
- Export ได้หลายรูป: Obsidian vault (interactive), MCP server (agent integration), Neo4j, SVG, GraphML
- `pip install graphifyy` (double-y) — PyPI name ≠ CLI name; ระวังสับสน
- Git hooks (`graphify hook install`) และ watch mode (`--watch`) ช่วย keep graph fresh โดยอัตโนมัติ
- 100% local สำหรับ AST pass — ไม่ส่งโค้ดออก internet ในขั้นตอน structural extraction
