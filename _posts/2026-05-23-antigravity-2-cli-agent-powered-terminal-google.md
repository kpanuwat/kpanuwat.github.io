---
title: "Antigravity 2.0 CLI: เจาะลึก Agent-Powered Terminal Interface ของ Google"
date: 2026-05-22 00:31:00 +0700
categories: [Tools]
tags: [cli, ai-agent, google, orchestration, antigravity, gemini]
slides: true
---

{% include slide-link.html %}

## TL;DR

**Antigravity CLI** (`agy`) คือ terminal interface ใหม่จาก Google ที่ประกาศที่ I/O 2026 — ใช้ Go, เร็วกว่า Gemini CLI เดิม, และแชร์ agent engine เดียวกับ Antigravity 2.0 desktop GUI ผู้ใช้พิมพ์ natural language แล้ว agent จะวางแผน เลือก tool และรันงานอัตโนมัติ รวมถึง dispatch parallel subagents สำหรับงานขนาดใหญ่ในพื้นหลัง

## Background / Why this matters

ตลาด AI coding agent กำลัง reshuffle ใหม่อย่างรวดเร็ว Anthropic มี Claude Code, OpenAI มี Codex CLI, xAI มี Grok CLI และ Google ได้ retire Gemini CLI แล้วแทนด้วย **Antigravity CLI** ซึ่งเป็น Go-based terminal agent ที่แชร์ engine เดียวกับ Antigravity 2.0 desktop app [1]

**ทำไมต้องรู้เรื่องนี้?**
- Gemini CLI (Node.js-based รุ่นเดิม) จะ stop serving requests วันที่ **18 มิถุนายน 2026** สำหรับ free/individual users [4]
- Antigravity CLI เปลี่ยน paradigm จาก "สั่ง command ตรงๆ" เป็น "อธิบาย goal เป็น natural language แล้วให้ agent จัดการ"
- ถ้าคุณใช้ terminal workflow สำหรับ code, research, หรือ automation งาน — นี่คือ tool ที่ต้องทำความเข้าใจ

## Deep Dive

### 1. Architecture: Go-based, Low Overhead

Antigravity CLI เขียนด้วย **Go** (rewrite จาก Gemini CLI ที่ใช้ Node.js) เป้าหมายหลักคือ:
- Startup เร็วกว่า
- Memory footprint ต่ำกว่า
- เหมาะสำหรับ **remote SSH workflows** และ headless environments [1]

Default model คือ **Gemini 3.5 Flash** ซึ่ง Google ระบุว่าเร็วกว่า frontier model รุ่นก่อน 4 เท่า เพื่อลด latency compounding ใน multi-agent calls [3]

Antigravity CLI รองรับ multi-model:
- Gemini 3.5 Flash, Gemini 3.1 Pro
- Claude (Anthropic models)
- GPT-OSS และ open-source models อื่นๆ [1]

### 2. CLI กับ GUI: Engine เดียวกัน

จุดสำคัญที่ทำให้ Antigravity CLI แตกต่างจาก CLI ทั่วไปคือมัน **ไม่ใช่ wrapper แยกต่างหาก** — CLI กับ Antigravity 2.0 desktop GUI ใช้ core agent engine ชุดเดียวกัน:

```
User (terminal)     ──┐
                       ├─→ Agent Engine (shared) ──→ Tools / APIs
User (desktop GUI)  ──┘
```

ซึ่งหมายความว่า:
- Preferences, permissions, และ active sessions **sync สองทางแบบ real-time** [1]
- ถ้าเจอปัญหาซับซ้อนใน terminal ใช้ `/export` เพื่อ push session ไปใน GUI ทันที เพื่อดู visual diffs และ graph views [1]
- Platform improvements ใดๆ apply กับทั้งสอง interface พร้อมกัน

**GUI เหมาะกับ:** project management รูปแบบ visual, orchestration dashboard
**CLI เหมาะกับ:** speed, keyboard-first, low resource, remote SSH

### 3. สามโหมดหลักใน Antigravity CLI

#### Interactive Agent Mode (โหมดหลัก)
```bash
agy
# เข้าสู่ interactive session
# พิมพ์ natural language prompt ได้ทันที
```

ใช้ `@` syntax เพื่อ pull context เข้ามา:
```bash
# ดึงทั้ง directory เข้า context
refactor the authentication flow @src/auth/

# ดึง glob pattern
add error handling for all API calls @src/**/*.ts
```

Agent จะ reason ข้ามทั้ง project, edit หลายไฟล์พร้อมกัน และ execute tools อัตโนมัติ [1]

#### Command Mode (One-Shot)
```bash
# Inline execution โดยไม่เปิด full conversational UI
agy -c "generate a migration for adding user_roles table"

# Output structured data แล้ว pipe ต่อ
agy -c "list all TODO comments in src/" | grep "CRITICAL"
```

เหมาะสำหรับ quick task หรือ script integration [1]

#### Async Subagent Mode (Parallel Background)
โหมดที่ทรงพลังที่สุด — dispatch งาน long-running ไปทำงานพื้นหลัง:
```bash
# ส่ง task ไปทำงาน background
/spawn "refactor the payment module to use the new Stripe API"

# Subagent รายงาน progress ผ่าน status bar
# เมื่อเสร็จ → post diff กลับเข้า foreground conversation
```

ผู้ใช้สามารถรัน **หลาย subagents พร้อมกัน** และ terminal prompt ไม่ถูก lock [1, 4]

### 4. Natural Language → Tool Execution Flow

เมื่อพิมพ์ prompt ใน Interactive Mode:

```
1. User types: "add input validation to all POST endpoints"
2. Agent analyzes project structure + context
3. Agent plans: which files to read → which edits to make
4. Agent executes tool calls (file read, edit, run tests)
5. Agent reports diffs + asks for approval before writing
```

สองระบบหลักที่ควบคุม tool execution:

**Hooks** — JSON-defined lifecycle interceptors:
```json
{
  "hooks": {
    "after_file_edit": ["gofmt {{file}}"],
    "before_tool_call": ["check-vendor-lock {{file}}"]
  }
}
```
Hooks fire ก่อน/หลัง tool call, หลัง file edit, หรือตอน session start ใช้เพื่อ auto-format, block edits ใน protected directories, หรือ run linters [1]

**MCP Servers** — ดึง live context จาก external systems:
```bash
# ตัวอย่าง: เชื่อม Antigravity CLI กับ Jira
agy --mcp jira://your-workspace
# จากนั้น agent สามารถอ่าน/อัปเดต Jira tickets โดยตรง
```

### 5. Image Generation: ผ่าน External Script/Tool

> **หมายเหตุ:** Official sources ไม่ระบุ built-in image generation command ใน Antigravity CLI โดยตรง [1–4] แนวทางที่ document ไว้คือ external script/skill ที่เรียก Google Image API

**แนวทาง 1: Agent-Driven (tool-dependent)**

ถ้า agent engine มี image generation tool ติดตั้งไว้ ผู้ใช้สามารถสั่งใน natural language:
```
create an image of a cyberpunk city at night, 16:9
```
แล้ว agent จะเรียก tool ภายในเพื่อสร้างภาพ — แต่ขึ้นอยู่กับ tool/plugin ที่ install ไว้

**แนวทาง 2: External Skill/Script (recommended สำหรับ production)**

สร้าง script แยก แล้วเรียกผ่าน Command Mode หรือ CLI arguments:
```bash
node generate.js \
  --prompt "A futuristic city on Mars" \
  --output "/tmp/mars.png" \
  --aspect-ratio "16:9"
```

Script นี้จะ:
1. เรียก Google Imagen / Gemini Image API โดยตรง
2. Save ไฟล์ภาพที่ `--output` path
3. Return exit code (0 = success)

ข้อดีของ approach นี้: reproducible, scriptable, ไม่ต้องรอ agent reasoning

### 6. Orchestration: Multi-Agent Parallel Workflows

ตัวอย่าง workflow ขั้นสูงที่ใช้ async subagent:

```bash
# Scenario: refactor 3 independent modules พร้อมกัน
/spawn "refactor auth module to use JWT v4" &
/spawn "migrate database layer to connection pooling" &
/spawn "update API endpoints to REST v2 format" &
# ทั้ง 3 agents ทำงานพร้อมกัน
# แต่ละ agent รายงาน progress → เสร็จแล้ว post diff กลับมา
```

Agents ทำงาน **asynchronously** — ไม่ lock terminal, ผู้ใช้สามารถทำงานอื่นต่อได้ [1, 4]

**สิ่งที่ต้องตรวจสอบ:**
```bash
/agents  # ดู status ของ subagents ทุกตัวที่รันอยู่
/usage   # ตรวจ API quota consumption
```

## User Guide (Step-by-Step)

### ติดตั้ง

```bash
# macOS / Linux (via Homebrew)
brew install google-antigravity/tap/agy

# หรือ download binary โดยตรง
curl -fsSL https://get.antigravity.google | bash
```

ตรวจสอบ:
```bash
agy --version
```

### Authentication

```bash
agy auth login
# เปิด browser สำหรับ OAuth (Google account)
# SSH / headless: จะ print local URL ให้เปิดใน browser อื่น
```

### เริ่มใช้งานครั้งแรก

```bash
cd your-project/
agy
# → เข้าสู่ Interactive mode
# พิมพ์: "explain the architecture of this project"
```

### Daily Workflows

| งาน | Command |
|-----|---------|
| Code review PR | `agy -c "review my latest commit for bugs"` |
| Refactor module | `agy` → `refactor @src/payments/ to use async/await` |
| Research task | `/spawn "research best practices for rate limiting in Go"` |
| Check agent status | `/agents` |
| Export to GUI | `/export` |
| Check quota | `/usage` |

### Hook ที่แนะนำสำหรับ Development

```json
{
  "hooks": {
    "after_file_edit": ["prettier --write {{file}}"],
    "before_tool_call": [
      "if [[ {{file}} == vendor/* ]]; then echo 'BLOCKED: vendor dir'; exit 1; fi"
    ]
  }
}
```

## Caveats / Limits

**1. LLM code ต้องตรวจเสมอ**
Agent สร้าง code ที่ดูสมเหตุสมผลแต่มี subtle bug ได้ ต้อง review diffs ก่อน run ใน production [1]

**2. Parallel subagents กิน API quota พร้อมกัน**
ผู้ใช้ metered plan ต้องระวัง — ตรวจสอบด้วย `/usage` ก่อน spawn หลาย agents [1]

**3. Legacy Gemini CLI extensions อาจไม่รองรับ**
Community extensions จาก Gemini CLI era บางตัวยังไม่ถูก re-test กับ Go runtime ใหม่ [1]

**4. Image generation ไม่ built-in**
ไม่มี `agy generate-image` command ตรงๆ — ต้องใช้ external script ที่เรียก API เอง หรือ image generation plugin ที่ติดตั้งแยก

**5. Gemini CLI retiring June 18, 2026**
ถ้ายังใช้ Gemini CLI อยู่ — migrate ไป Antigravity CLI ก่อน deadline [4]

## References

1. DEV Community, Arindam Dutta — [Antigravity CLI: A Hands-On Guide to Google's Terminal Coding Agent](https://dev.to/arindam_1729/antigravity-cli-a-hands-on-guide-to-googles-terminal-coding-agent-5bc7)
2. TechCrunch — [Google launches Antigravity 2.0 with an updated desktop app and CLI tool at IO 2026](https://techcrunch.com/2026/05/19/google-launches-antigravity-2-0-with-an-updated-desktop-app-and-cli-tool/)
3. MarkTechPost — [Google Launches Antigravity 2.0 at I/O 2026: A Standalone Agent-First Platform with CLI, SDK, Managed Execution, and Enterprise Support](https://www.marktechpost.com/2026/05/19/google-launches-antigravity-2-0-at-i-o-2026-a-standalone-agent-first-platform-with-cli-sdk-managed-execution-and-enterprise-support/)
4. Google Developers Blog — [An important update: Transitioning Gemini CLI to Antigravity CLI](https://developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/)
5. GitHub — [google-antigravity/antigravity-cli](https://github.com/google-antigravity/antigravity-cli)

## Key Takeaways

- **Antigravity CLI (`agy`)** แทน Gemini CLI ทั้งหมด — ถ้าใช้ Gemini CLI ต้อง migrate ก่อน 18 มิ.ย. 2026
- CLI กับ GUI **ใช้ engine เดียวกัน** — เลือก interface ได้ตามสถานการณ์; `/export` ย้าย session ข้ามได้
- **สาม modes**: Interactive (conversational), Command (one-shot/pipe), Async Subagent (parallel background)
- **`@` syntax** ดึง file/directory เข้า context ได้ทันที; **Hooks** ควบคุม tool lifecycle
- **Image generation** ไม่ built-in — ใช้ external script เรียก Image API แทน
- **Parallel subagents** เป็น game-changer สำหรับงาน refactor ขนาดใหญ่ แต่ต้องตรวจ quota
- ทุก AI-generated code ต้อง review ก่อน ship — agent ไม่ได้ correct 100% เสมอ
