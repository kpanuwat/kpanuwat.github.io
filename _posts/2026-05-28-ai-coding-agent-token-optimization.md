---
title: "เทคนิคประหยัด Token สำหรับ AI Coding Agent"
date: 2026-05-27 00:10:00 +0700
categories: [Tools]
tags: [token-optimization, ai-coding, claude-code, caveman, rtk, productivity, context-window]
slides: true
---

{% include slide-link.html %}

## TL;DR

ปัญหา Token หมดเร็วของ AI Coding Agent มาจาก 3 แหล่งหลัก: **Startup Waste** (skills/MCPs โหลดอัตโนมัติ), **Input Waste** (อ่านไฟล์ซ้ำซ้อน), **Output Waste** (ภาษาฟุ่มเฟือย) — 7 เทคนิคนี้โจมตีทุกแหล่งพร้อมกัน ลดการสิ้นเปลือง Token ได้ 30–99% ขึ้นอยู่กับ stack ที่ใช้

## Background / Why this matters

Context Window ของ Claude Code รุ่นปัจจุบันอยู่ที่ ~200,000 tokens แต่ในทางปฏิบัติ ควรใช้ไม่เกิน **25–30%** เพื่อหลีกเลี่ยงค่าใช้จ่ายพุ่งสูงและ session reset บ่อย [1]

ตัวอย่างที่วัดได้จริง: session coding 2 ชั่วโมงทั่วไปใช้ terminal output ราว **210,000 tokens** โดยที่ส่วนใหญ่เป็น noise (git output, test logs, build artifacts) ที่ AI ต้องอ่านทั้งหมด [2]

ปัญหาอีกจุดคือ **session startup**: แค่เปิด Claude Code ขึ้นมา ก็อาจโหลด token ไปแล้ว 25,000+ token ก่อนพิมพ์คำสั่งแรก [3] เนื่องจาก:
- Skills ทุก definition (ชื่อ + description) โหลดเข้า context ทันทีเพื่อให้ AI ตัดสินใจว่าควรใช้ tool ไหน
- MCPs และ slash commands เพิ่ม overhead อีก
- CLAUDE.md ที่ยาวมากถูก inject ทุก session

## Deep Dive

### 1. Token Optimizer — ตรวจสอบจุดรั่วไหล

**Token Optimizer** เป็น Claude Code plugin ที่ audit session history เพื่อระบุว่า token หายไปไหน ทำงานผ่าน 6 sub-agents แบบขนาน ตรวจ: CLAUDE.md, skills, MCPs, slash commands, hooks, และ settings [3]

```bash
# ติดตั้งผ่าน Claude Code marketplace
/plugin install token-optimizer

# รัน audit
token optimizer
```

ผลลัพธ์: dashboard แสดง breakdown เช่น

| Source | Tokens | % |
|--------|--------|---|
| Skills (82 skills) | 9,000 | 36% |
| CLAUDE.md | 1,000 | 4% |
| Slash Commands | 750 | 3% |
| MCPs + Tools | 450 | 1.8% |
| **Total Startup** | **25,000** | — |

> **Caveat:** Token Optimizer ใช้ AI agents ทำงานที่ทำได้ด้วย script ธรรมดา — ใช้เป็น one-time audit ไม่ใช่ run ทุกวัน [3]

---

### 2. Caveman Skill — ลดภาษาฟุ่มเฟือย

พัฒนาโดย Matt PCO, **Caveman** skill บังคับให้ Claude ตอบสั้น ตรง ไม่มี filler เช่น "Let me explain what I'm going to do" หรือ "Great question!" — โดยยังคงความถูกต้องทางเทคนิคไว้ครบ [4]

```bash
# invoke ด้วย caveman mode
/caveman explain how our app manages context summarization
```

ผลการทดสอบจริง: **30–40% reduction** ใน output tokens (creator claim 75%) [4]  
ตัวอย่าง: คำอธิบาย technical ใช้เวลา 40 วินาที ค่าใช้จ่าย **42 cents ด้วย Opus 4.7** [4]

---

### 3. Intent Layers — แผนที่โปรเจกต์แบบประหยัด Token

**Intent Layers** แก้ปัญหา AI อ่านไฟล์แบบ blindly เพื่อเข้าใจโครงสร้างโปรเจกต์ [5]

```bash
# สแกนและสร้าง nested config files
/intent layer
```

คำสั่งนี้ scan directories และวาง `agents.md` หรือ `CLAUDE.md` ในทุก directory ที่มี content >20,000 tokens [5] ไฟล์เหล่านี้อธิบาย:
- สถาปัตยกรรมของ directory นั้นๆ
- กฎและ anti-patterns
- ป้องกัน AI ทำ workarounds ที่สิ้นเปลือง token

ผลการวิจัย: การมี `AGENTS.md` ที่ดีช่วยลด **median runtime 29%** และ **output tokens 17%** [6]

---

### 4. Handoff — สรุปบริบทก่อนเปลี่ยน Session

เมื่อ context window เริ่มเต็ม (ใช้ไป ~25–30%) แทนที่จะปล่อยให้ token หมดและ session reset เอง ให้ใช้ **Handoff** skill เพื่อสรุปบริบทก่อน [1]

```bash
# สร้าง handoff summary
/handoff
```

AI จะสร้างสรุปงานที่ทำไปแล้ว วิธีการ และ next steps ให้กระชับ (<300 คำ) [1] จากนั้น:
1. เปิด session ใหม่
2. paste handoff summary เข้าไป
3. AI เข้าใจ context เดิมได้โดยไม่ต้องโหลด history ทั้งหมด

วิธีนี้ช่วยลด token overhead จากการ carry forward ได้ 20–86% ขึ้นอยู่กับ session complexity [7]

---

### 5. CLAUDE.md ที่กระชับ — ลด Startup Overhead

`CLAUDE.md` ถูก inject เข้า context ทุก session ดังนั้น **ทุกบรรทัดคือ token ที่จ่ายซ้ำทุกครั้ง** [8]

**หลักการเขียน CLAUDE.md ที่ประหยัด:**

| ใส่ | ไม่ใส่ |
|-----|--------|
| Non-obvious constraints (เช่น framework version เฉพาะ) | "Write clean code" หรือ obvious rules |
| Architectural map กระชับ | File-by-file descriptions |
| Project motivation 1 บรรทัด | Background story ยาว |
| Tooling paths ที่หาเองยาก | Commands ที่ Google ได้ใน 10 วินาที |

เป้าหมาย: **ไม่เกิน 300 บรรทัด** — ยิ่งสั้น ยิ่งดี [8]

---

### 6. Code Graphs — ดัชนีโค้ดแทนการอ่านไฟล์

**CodeGraph** (และ codebase-memory-mcp) parse โค้ดทั้งหมดด้วย tree-sitter AST และสร้าง SQLite-backed knowledge graph ที่ map: functions, classes, imports, call chains, HTTP routes [9]

```bash
# initialize (one-time)
codegraph init

# query ผ่าน MCP tools
codegraph_search "function name"
codegraph_trace "call chain from endpoint"
```

แทนที่ AI จะ `grep` หรืออ่านไฟล์ raw, CodeGraph ตอบ structural queries ใน **<1ms ด้วย ~200 tokens** [9]

ผลการ benchmark จริง:

| Metric | Before | After |
|--------|--------|-------|
| Token usage | 120,000 | ~800 |
| Tool calls | baseline | -71% |
| Cost per query | baseline | -35% |
| Overall reduction | — | **99.2% (120x)** |

---

### 7. RTK Proxy — กรอง Terminal Output

**RTK (Rust Token Killer)** เป็น CLI proxy ที่นั่งระหว่าง terminal กับ AI agent กรอง compress deduplicate terminal noise ก่อนส่งให้ AI อ่าน [2]

```bash
# ติดตั้ง
brew install rtk

# ใช้งาน (auto-via Claude Code PreToolUse hook)
# ไม่ต้องเปลี่ยน workflow — RTK rewrite bash commands อัตโนมัติ

# ดู savings
rtk gain
```

RTK ทำงานผ่าน PreToolUse hook ใน Claude Code — ทุก bash command ถูก rewrite ผ่าน RTK โดยอัตโนมัติ ไม่ต้องเปลี่ยนวิธีทำงาน [2]

| Command | Before | After | Savings |
|---------|--------|-------|---------|
| `git add/commit/push` | 1,600 tokens | 120 tokens | **92%** |
| `cargo test` | baseline | — | **91.8%** |
| Session 2 ชั่วโมง | 210,000 tokens | 23,000 tokens | **89%** |

## Caveats / Limits

- **Token Optimizer** ใช้ AI agents ทำ audit — ironically เปลือง token ระหว่าง audit ควรรันเป็น one-time setup ไม่ใช่ daily
- **Caveman** 30–40% real-world savings ต่างจาก 75% ที่ creator claim — วัดจริงก่อนคาดหวัง
- **Code Graphs** ต้อง re-index เมื่อโค้ดเปลี่ยนมาก — ถ้า project เปลี่ยนบ่อย overhead การ maintain graph อาจสูง
- **RTK** optimize terminal output เท่านั้น — ไม่ช่วย prompt ที่ยาว หรือ file reads ที่ไม่จำเป็น
- **Intent Layers** ดีสำหรับโปรเจกต์ขนาดใหญ่ — โปรเจกต์เล็ก (<20k tokens) ไม่คุ้ม overhead ของการ setup
- การผสม stack ทั้งหมด (caveman + RTK + code graph) อาจประหยัดได้ **85–92%** แต่ setup time รวมประมาณ 3–4 ชั่วโมง

## References

1. MindStudio — [18 Claude Code Token Management Hacks to Extend Your Session](https://www.mindstudio.ai/blog/claude-code-token-management-hacks)
2. GitHub — [rtk-ai/rtk: CLI proxy that reduces LLM token consumption by 60-90%](https://github.com/rtk-ai/rtk)
3. YouTube — [7 Token-Saving Vibe Code Tricks That Feel Like Cheating](https://www.youtube.com/watch?v=bhB57Meachc) (video transcript via NotebookLM)
4. RTK AI — [Caveman Skill for Claude Code](https://www.rtk-ai.app/)
5. DEV Community — [How I Cut My AI Coding Agent's Token Usage by 120x With a Code Knowledge Graph](https://dev.to/deusdata/how-i-cut-my-ai-coding-agents-token-usage-by-120x-with-a-code-knowledge-graph-4a3d)
6. arXiv — [Codified Context: Infrastructure for AI Agents in a Complex Codebase](https://arxiv.org/pdf/2602.20478v1)
7. arXiv — [Contextual Memory Virtualisation: DAG-Based State Management for LLM Agents](https://arxiv.org/pdf/2602.22402)
8. Claude Code Docs — [Best practices for Claude Code](https://code.claude.com/docs/en/best-practices)
9. GitHub — [colbymchenry/codegraph: Pre-indexed code knowledge graph for Claude Code](https://github.com/colbymchenry/codegraph)

## Key Takeaways

- **ก่อนทำอะไร: audit ก่อน** — Token Optimizer บอกว่า token หายไปที่ไหน; ไม่รู้ปัญหาก็แก้ไม่ถูกจุด
- **Startup waste ใหญ่กว่าที่คิด** — 25k tokens หายก่อนพิมพ์คำแรก ส่วนใหญ่มาจาก skills ที่ install ไว้แต่ไม่ได้ใช้
- **RTK คือ low-effort high-reward** — ติดตั้งครั้งเดียว ประหยัดทันที 60–90% โดยไม่เปลี่ยน workflow
- **CLAUDE.md สั้น = ดีกว่า** — ทุกบรรทัดคือค่าที่จ่ายซ้ำทุก session; prune aggressively
- **Code Graphs ชนะ grep** — 120x token reduction สำหรับ codebase navigation; คุ้มมากสำหรับโปรเจกต์ขนาดใหญ่
- **Handoff ก่อน session เต็ม** — อย่ารอให้ context หมด; สรุปที่ <300 คำพาไปต่อ session ใหม่ได้ทันที
- **Full stack savings: 85–92%** — Caveman + RTK + Code Graph ร่วมกันลด token ได้มหาศาล แต่ setup ต้องใช้เวลา
