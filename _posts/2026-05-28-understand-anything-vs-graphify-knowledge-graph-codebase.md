---
title: "Understand Anything vs Graphify: เปรียบเทียบ Tools สร้าง Knowledge Graph สำหรับ Codebase"
date: 2026-05-27 00:14:00 +0700
categories: [Tools]
tags: [knowledge-graph, mcp, codebase, graphify, llm, local-model, ollama]
slides: true
---

{% include slide-link.html %}

## TL;DR

**Understand Anything** และ **Graphify** เป็นสอง Tools ยอดนิยมสำหรับแปลง Codebase ให้เป็น Knowledge Graph ที่ AI ถามได้ — ทั้งคู่ติดตั้งผ่าน UV/MCP และอัปเดตอัตโนมัติเมื่อ Commit แต่มีจุดแข็งต่างกัน: Understand Anything ชนะเรื่อง Dashboard Visualization และ AI Q&A เชิงลึก ส่วน Graphify ชนะเรื่องประหยัด Token (71–79×) และรองรับ Local Model อย่าง Ollama/Bedrock สำหรับงาน Privacy-First

---

## Background / Why this matters

เมื่อ Codebase โตขึ้น การทำความเข้าใจโครงสร้างด้วยการอ่านโค้ดตรงๆ กลายเป็นงานที่แพงทั้งเวลาและ Token AI Coding Agents อย่าง Claude Code หรือ Cursor ต้องอ่านไฟล์ทีละไฟล์เพื่อหา context — ซึ่ง scale ไม่ได้ดีนักเมื่อ Project มีไฟล์หลายร้อยหรือหลายพันไฟล์

**Knowledge Graph approach** แก้ปัญหานี้ด้วยการ pre-index โครงสร้างทั้งหมดไว้ล่วงหน้า แล้วให้ AI query ผ่าน Graph แทนการอ่านไฟล์ดิบ ผลลัพธ์คือ AI เข้าใจ Codebase ได้เร็วขึ้นมาก ใช้ Token น้อยลง และตอบคำถามเชิง Architecture ได้ดีขึ้น

ในปี 2026 Tools สองตัวที่ถูกพูดถึงมากที่สุดในกลุ่มนี้คือ **Understand Anything** (โดย Lum1104) และ **Graphify** (โดย safishamsi) ซึ่งมีแนวทางการออกแบบแตกต่างกันอย่างน่าสนใจ

---

## Deep Dive

### Understand Anything — ภาพรวมและ Features หลัก

Understand Anything ใช้ **Multi-agent pipeline 5 ตัว** (File Analyzer, Architecture Analyzer, Domain Mapper, Impact Analyzer, Tour Builder) ในการสแกนและสรุป Codebase ก่อน Build เป็น Knowledge Graph ที่เก็บไว้ใน `.understand-anything/knowledge-graph.json` [1][3]

Feature ที่โดดเด่น:

| Feature | รายละเอียด |
|---------|-----------|
| **Interactive Dashboard** | เปิดใน Browser — ทุก File/Function/Class เป็น Node ที่คลิกได้ |
| **Persona-Adaptive UI** | ปรับมุมมองตามตำแหน่ง (PM, Junior Dev, Senior Eng) |
| **Domain View** | แสดง Business Process เชื่อมกับ Code Domain ในรูปแบบ Horizontal Graph |
| **Impact Analysis** (`/understand-diff`) | Overlay ที่ Highlight downstream nodes ที่อาจกระทบเมื่อแก้ Code |
| **Guided Tours** | AI อธิบาย Flow ของ Feature สำคัญแบบ Step-by-step |
| **Fuzzy Search** | ค้นหา Node ด้วย Natural Language |

Platform ที่รองรับ: Claude Code, Cursor, VS Code, Codex, Copilot, Gemini CLI [1]

### Graphify — ภาพรวมและ Features หลัก

Graphify เป็น **Multi-modal Knowledge Graph** ที่วิเคราะห์ได้มากกว่าแค่ Code — รองรับ SQL Schemas, R Scripts, Shell Scripts, Docs, PDFs, Images, Videos ด้วย [2][5]

Architecture ภายในแบ่งเป็น 3 ชั้น:

1. **Local AST parsing** — ใช้ Tree-sitter สกัดโครงสร้าง Code บนเครื่องตัวเอง **ฟรี ไม่กิน API Tokens เลย**
2. **Transcription** — ถอดเสียง Video/Audio ด้วย faster-whisper แบบ Local ได้
3. **LLM Semantic extraction** — เรียก LLM เฉพาะในขั้นตอนที่ต้องการความหมาย (ส่วนน้อย)

Algorithm ที่น่าสนใจ: ใช้ **Leiden algorithm** ในการ Cluster โหนดเป็น Community Groups และหา **"God Nodes"** (โหนดที่เชื่อมทุกอย่างไว้) — ช่วยระบุ Central Modules ของ Project ได้ทันที [2][5]

ไม่ต้องใช้ Vector Database — Graph query ตรงผ่าน MCP functions: `query_graph`, `get_node`, `get_neighbors`, `shortest_path`, `get_pr_impact` [2]

### เปรียบเทียบ Dashboard Visualization

นี่คือจุดที่ทั้งสอง Tool ต่างกันชัดที่สุด:

**Understand Anything** มีหน้า Dashboard ที่ออกแบบมาสำหรับ Human readability — Graph แสดงโครงสร้างแบบ Parent/Child ชัดเจน มี Architectural layers คลิกแล้วได้คำอธิบายเป็นภาษาที่อ่านออก เหมาะกับ Onboarding สมาชิกใหม่ [3][4]

**Graphify** generate HTML Graph ที่รวมข้อมูลทั้งหมดใน Bundle เดียว — แสดงเป็น Neighbor nodes แต่ไม่มีลำดับ Parent/Child ที่ชัดเจน ดังนั้น Dashboard ของ Graphify จึงเหมาะกับ Machine query มากกว่า Human browsing [3][4]

> ⚠️ **Known limitation**: Understand Anything อาจ Freeze ได้บน Codebase ที่ใหญ่มาก (>3,000 nodes) เนื่องจาก Dashboard render ทั้งกราฟในคราวเดียว [3]

### Token Usage: ประหยัดแค่ไหน?

| Tool | Token Usage (ทดสอบจริง) | หมายเหตุ |
|------|------------------------|---------|
| **Understand Anything** | ~200,000 tokens/run | Agent อ่านและสรุปทุกไฟล์ |
| **Graphify** | ~2,500–3,500 tokens/run | AST local ฟรี, LLM เฉพาะ Semantic |

Graphify ประหยัด Token ได้ **71–79×** เมื่อเทียบกับ Understand Anything [5][6] เหตุผลหลักคือ Tree-sitter parse โครงสร้างบนเครื่องโดยไม่ส่งข้อมูลออก — LLM จะถูกเรียกเฉพาะขั้นตอน Semantic extraction ที่จำเป็นจริงๆ เท่านั้น

### Local Model Support: Privacy-First

**Understand Anything**: ไม่รองรับ Local Model — ข้อมูล Codebase จะถูกส่งไปยัง Model Provider ที่ IDE ผูกไว้ (เช่น Anthropic API) [3][4]

**Graphify** รองรับ Local Model เต็มรูปแบบ ผ่าน flag `--backend`:

```bash
graphify extract --backend ollama    # Ollama (local)
graphify extract --backend bedrock   # AWS Bedrock (IAM auth)
graphify extract --backend vllm      # vLLM self-hosted
```

สำหรับ Ollama ตั้งค่า `OLLAMA_BASE_URL` ได้ สำหรับ Bedrock ใช้ Standard AWS credential chain — ไม่ต้องการ API Key [2][5] Code files ถูก parse ด้วย Tree-sitter บน Local เสมอ ไม่มีการส่ง Raw Code ออกนอกเครื่อง

### สรุป Use Cases ที่เหมาะสม

| Scenario | แนะนำ |
|----------|-------|
| Onboarding พนักงานใหม่หรือ PM เข้าใจ Codebase | **Understand Anything** |
| Developer อยากถาม AI เรื่อง Architecture Flowchart | **Understand Anything** |
| Project ขนาดใหญ่ต้องควบคุม Cost | **Graphify** |
| ข้อมูล Source Code เป็นความลับ (Banking, Healthcare) | **Graphify** |
| Codebase ผสมหลาย Format (Code + PDF + Video) | **Graphify** |
| ทีมใช้ AWS Bedrock หรือ Self-hosted LLM | **Graphify** |

---

## User Guide (Step-by-Step)

### ติดตั้ง Understand Anything

**วิธีที่ 1: ผ่าน Claude Code Plugin Marketplace**

```bash
# Claude Code CLI
/plugins install Lum1104/Understand-Anything
```

**วิธีที่ 2: Script (สำหรับ Cursor, VS Code, Codex, Copilot)**

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/Lum1104/Understand-Anything/main/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/Lum1104/Understand-Anything/main/install.ps1 | iex
```

**ใช้งาน:**

```bash
# สร้าง Knowledge Graph ครั้งแรก (รัน 1 ครั้ง)
/understand

# เปิด Dashboard
/understand-explore

# วิเคราะห์ Impact หลัง diff
/understand-diff
```

Dashboard จะเปิดใน Browser อัตโนมัติ [1]

---

### ติดตั้ง Graphify

```bash
# 1. ติดตั้ง package (ชื่อ package บน PyPI คือ graphifyy)
pip install graphifyy
# หรือ
uv pip install graphifyy

# 2. ติดตั้ง Skill ลงใน Claude Code
graphify claude install

# สำหรับ platform อื่น
graphify cursor install
graphify codex install
```

**สร้าง Knowledge Graph:**

```bash
# Build graph สำหรับ Project ปัจจุบัน (ใช้ Claude Code default backend)
graphify extract

# ใช้ Ollama (local, privacy-first)
graphify extract --backend ollama

# ใช้ AWS Bedrock
graphify extract --backend bedrock
```

**Query ผ่าน MCP (ใน Claude Code):**

```
"What are the god nodes in this codebase?"
"Show me all neighbors of the AuthService module"
"What's the shortest path between UserController and DatabasePool?"
```

---

## Caveats / Limits

**Understand Anything:**
- Token cost สูงมากสำหรับ Project ใหญ่ — อาจกิน Monthly quota หมดในรันเดียว
- Dashboard อาจ Freeze บน Codebase >3,000 nodes
- ไม่รองรับ Local Model — ข้อมูลออกนอกเครื่องผ่าน API เสมอ
- Multi-agent pipeline ใช้เวลา Build นานกว่า Graphify

**Graphify:**
- HTML Graph ไม่ได้ออกแบบมาสำหรับ Human browsing — ดูยากกว่า Understand Anything
- Docs, PDFs, Images ที่ต้อง Semantic extraction ยังส่งไป LLM API (เฉพาะ Text parsing ฟรี)
- ชื่อ Package บน PyPI คือ `graphifyy` (มี y สองตัว) — ระวังพิมพ์ผิด

---

## References

1. [GitHub - Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything)
2. [GitHub - safishamsi/graphify](https://github.com/safishamsi/graphify)
3. [Understand-Anything vs Graphify: I Tested Both on My SaaS (YouTube)](https://youtu.be/Ynv_WYO_slw)
4. [Understand-Anything codebase knowledge graphs — ddewhurst.com](https://ddewhurst.com/blog/understand-anything-knowledge-graph-for-your-codebase/)
5. [Graph Your Codebase with Graphify: 79× Token Reduction — stevescargall.com](https://stevescargall.com/blog/2026/05/graphify--memmachine-79-token-reduction-zero-vector-database/)
6. [Graphify — Open-Source Knowledge Graph Skill for AI Coding Assistants](https://graphify.net/)

---

## Key Takeaways

- ทั้งคู่ติดตั้งผ่าน UV/MCP และอัปเดตอัตโนมัติเมื่อ Commit — ไม่ต้อง Re-index ด้วยตัวเอง
- **Understand Anything** ชนะเรื่อง Dashboard UX และ AI Q&A เชิงลึก (Flowchart, Domain Map, Impact Overlay)
- **Graphify** ประหยัด Token ได้ **71–79×** ด้วย Tree-sitter AST parsing บน Local — LLM ถูกเรียกน้อยมาก
- Graphify เป็นตัวเลือกเดียวที่รองรับ **Local Model** (Ollama, Bedrock, vLLM) สำหรับงาน Privacy-Critical
- สำหรับ Project ใหญ่ (>3,000 nodes) Graphify เสถียรกว่า — Understand Anything อาจ Freeze
- ใช้ทั้งสองร่วมกันได้: Understand Anything สำหรับ Onboarding/สำรวจ, Graphify สำหรับ Daily AI queries
- Graphify รองรับ Multi-modal inputs (PDF, Video, Image) — เหมาะกับ Project ที่ไม่ได้เป็นแค่ Code อย่างเดียว
