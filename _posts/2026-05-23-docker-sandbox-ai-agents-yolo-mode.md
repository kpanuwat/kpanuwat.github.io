---
title: "Docker Sandbox: รัน AI Agents ใน YOLO Mode อย่างปลอดภัย"
date: 2026-05-23 00:01:00 +0700
categories: [Tools]
tags: [docker, ai-agents, sandbox, security, yolo-mode, claude-code, local-llm, lm-studio]
---

## TL;DR

Docker Sandboxes มอบ isolated microVM ให้ AI Agent ทำงานแบบ YOLO mode (ไม่ต้องขออนุมัติทุกคำสั่ง) โดยไม่เสี่ยงกับระบบ host — ล็อก filesystem, บล็อก network ที่ไม่อนุญาต, และ log ทุก action อย่างชัดเจน ติดตั้งได้ใน 1 คำสั่งบน Mac ผ่าน Homebrew และรองรับ Local LLM เช่น LM Studio เพื่อความเป็นส่วนตัวและประหยัด API cost

## Background / Why This Matters

ปัญหาหลักของการรัน AI Agent แบบ autonomous คือทุกครั้งที่ agent ต้องการทำอะไร (สร้างไฟล์, รัน shell command, เรียก API) ระบบจะหยุดรอให้ developer อนุมัติ behavior นี้เรียกว่า "approval loop" และมันทำให้ agent ช้ามากเมื่อเทียบกับศักยภาพจริง

วิธีแก้แบบดิบที่สุดคือ `--dangerously-skip-permissions` ใน Claude Code ซึ่งอนุมัติ action ทุกอย่างโดยไม่ถาม — เรียก YOLO mode แต่ชื่อบอกแล้วว่ามันอันตราย: agent อาจเผลอลบไฟล์สำคัญ, ส่ง HTTP request ไปข้างนอก, หรือแก้ `.ssh/config` ของ host ได้

Docker Sandboxes แก้ปัญหานี้ด้วย microVM-based isolation — ให้ agent รัน YOLO ได้เต็มที่ แต่ขอบเขต action จำกัดอยู่แค่ภายใน sandbox ที่เรากำหนด host system ปลอดภัยสมบูรณ์

## Deep Dive

### YOLO Mode คืออะไร

ใน Claude Code และ Codex CLI มี flag `--dangerously-skip-permissions` ที่สั่งให้ agent ข้ามการขออนุมัติทุก action Docker Sandbox ถูกออกแบบมาเพื่อรัน mode นี้โดย default — agent ทำงาน "at full speed" โดยไม่มี developer คอยเป็น bottleneck [1][3]

จุดสำคัญคือ sandbox เป็น **guardrail** แทน developer ซึ่งทำได้ดีกว่า เพราะ:
- กำหนด policy ชัดเจน (filesystem scope, network allowlist)
- บังคับใช้ทุก operation โดยไม่พลาด
- log ทุกอย่างเพื่อ audit

### MicroVM Isolation — ไม่ใช่แค่ Container

Docker Sandbox ไม่ได้แค่ใช้ Docker container ทั่วไป แต่ใช้ **microVM-based isolation** ซึ่งเป็น security boundary ที่แข็งแกร่งกว่า [5]

แต่ละ agent session ได้รับ microVM แยกต่างหาก:

| สิ่งที่ mount ให้ | สิ่งที่ block |
|---|---|
| Project workspace เท่านั้น | `.ssh` directory ของ host |
| Environment variables ที่ระบุไว้ | Sensitive env vars ของ host |
| (ถ้าใช้ Docker-in-Docker) | Docker daemon ของ host |

ผลคือ agent ทำ `rm -rf /` ภายใน microVM ได้ — host ไม่ได้รับผลกระทบ ไม่มี shared state, ไม่มี bleed-through [6] และยังรองรับการรัน Docker container ภายใน microVM โดยไม่ต้องใช้ privileged mode หรือเปิด host Docker socket [7]

### Network Policy — 3 Tier

การควบคุม network เป็นส่วนสำคัญของ security model เพราะ agent ที่ compromise อาจพยายาม exfiltrate ข้อมูลผ่าน HTTP Docker Sandbox จัดการผ่าน proxy layer พร้อม 3 tier [10]:

```
Open         — อนุญาต outbound ทั้งหมด (ใช้สำหรับ dev ที่ต้อง access internet เต็มที่)
Balanced     — default: deny all + allowlist เฉพาะ AI provider APIs และ package managers
Locked Down  — block ทุก outbound ไม่มีข้อยกเว้น
```

ปรับ policy ได้ผ่าน `sbx policy` CLI:

```bash
# ดู policy ปัจจุบัน
sbx policy list

# เพิ่ม allowlist เฉพาะ domain
sbx policy allow network api.github.com

# Allow localhost port (ใช้สำหรับ Local LLM)
sbx policy allow network -g localhost:1234
```

### Audit Log ด้วย `sbx policy log`

ทุก network attempt (allowed และ denied) ถูก log แบบ real-time ดูได้ด้วย:

```bash
sbx policy log
```

Output แสดงข้อมูลครบ: timestamp, endpoint ที่พยายาม access, policy rule ที่ match, status (allowed/denied) [4][11]

ในวิดีโอ demo พบว่า Codex agent พยายาม fallback จาก WebSocket ไป HTTPS transport และ sandbox log บันทึกว่า "attack attempt detected" ทันที ทำให้เห็นว่าระบบ detect behavior ผิดปกติได้แม้ไม่ได้ตั้ง rule เฉพาะ [9]

สำหรับ enterprise สามารถ export log ไปยัง SIEM system เพื่อ audit trail เต็มรูปแบบ — event แต่ละตัวมี user identity, timestamp, session context, และ policy rule ที่ trigger [13]

### ติดตั้งบน Mac ผ่าน Homebrew

ข้อดีสำคัญ: **ไม่ต้องติดตั้ง Docker Desktop** ก่อน [15]

```bash
# ติดตั้ง Homebrew (ถ้ายังไม่มี)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ติดตั้ง sbx
brew install docker/tap/sbx

# ตรวจสอบ
sbx --version
```

รัน agent ใน sandbox:

```bash
# รัน Claude Code ใน sandbox (YOLO mode อัตโนมัติ)
sbx run claude

# รัน Codex ใน sandbox
sbx run codex
```

### ใช้กับ Local LLM (LM Studio)

แทนที่จะใช้ Claude API ของ Anthropic สามารถชี้ agent ไปยัง Local LLM ที่รันบน LM Studio ได้ เพื่อ:
- ไม่มี API cost
- ข้อมูลไม่ออกนอก machine
- ทดสอบ model ต่างๆ ได้อิสระ

LM Studio expose Anthropic-compatible endpoint ที่ `/v1/messages` [20][21] ทำให้ Claude Code เชื่อมต่อได้โดยตรง

ขั้นตอน:

```bash
# 1. เปิด LM Studio และโหลด model (default port: 1234)

# 2. Allow sandbox เข้าถึง localhost port ของ host
sbx policy allow network -g localhost:1234

# 3. Set env vars ก่อนรัน sbx
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_API_KEY=local  # placeholder — LM Studio ไม่ต้องการ key จริง

# 4. รัน agent ใน sandbox
sbx run claude
```

Agent จะใช้ model จาก LM Studio แทน Claude API โดย sandbox ยัง enforce network policy ปกติ [18][19]

## User Guide (Step-by-Step)

### Step 1: ติดตั้ง

```bash
brew install docker/tap/sbx
sbx --version   # ควรแสดง version number
```

ไม่ต้องมี Docker Desktop — `sbx` เป็น standalone binary

### Step 2: รัน Agent ครั้งแรก

```bash
cd your-project/
sbx run claude   # รัน Claude Code ใน sandbox
```

Claude Code จะเปิดขึ้นมาใน YOLO mode อัตโนมัติ ทำงานได้เลยโดยไม่ถามอนุมัติ

### Step 3: ตรวจสอบ Network Policy

```bash
# ดู policy default (Balanced)
sbx policy list

# Monitor network attempts แบบ real-time
sbx policy log
```

### Step 4: ปรับ Policy ตาม Use Case

```bash
# Dev mode — เปิด internet เต็มที่
sbx policy set open

# Production-like — deny all ยกเว้น allowlist
sbx policy set balanced

# Offline testing — block ทุกอย่าง
sbx policy set locked-down
```

### Step 5: ใช้กับ Local LLM

```bash
# Allow sandbox เข้าถึง LM Studio
sbx policy allow network -g localhost:1234

# Set env vars
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_API_KEY=local

# รัน
sbx run claude
```

## Caveats / Limits

- **macOS only (2025)** — Docker Sandbox ปัจจุบันรองรับ macOS เป็นหลัก Linux/Windows support อยู่ใน roadmap [3]
- **MicroVM overhead** — startup time ของ microVM นานกว่า container ปกติเล็กน้อย (ไม่กระทบ throughput ของ agent)
- **Local LLM performance** — model ที่รันบน CPU จะช้ากว่า Anthropic API มาก เหมาะสำหรับทดสอบ logic ไม่ใช่ production speed
- **Network policy learning curve** — Balanced mode อาจ block dependency ที่ไม่ได้อยู่ใน default allowlist ต้องเพิ่ม rule เองผ่าน `sbx policy allow`
- **ไม่ใช่ sandbox สำหรับ malware** — ออกแบบมาสำหรับ agent autonomy ไม่ใช่ malware analysis sandbox ที่ต้องการ kernel-level isolation เต็มรูปแบบ

## References

1. Docker Blog — "Docker Sandboxes: Run Agents in YOLO Mode, Safely": https://www.docker.com/blog/docker-sandboxes-run-agents-in-yolo-mode-safely/
2. Docker Docs — Claude Code in Docker Sandboxes: https://docs.docker.com/ai/sandboxes/agents/claude-code/
3. Docker Blog — "Docker Sandboxes: Run Claude Code and More Safely": https://www.docker.com/blog/docker-sandboxes-run-claude-code-and-other-coding-agents-unsupervised-but-safely/
4. Docker Blog — "Docker AI Governance: Unlock Agent Autonomy, Safely": https://www.docker.com/blog/docker-ai-governance-unlock-agent-autonomy-safely/
5. LM Studio Blog — "Use your LM Studio Models in Claude Code": https://lmstudio.ai/blog/claudecode
6. LM Studio Docs — Claude Code Integration: https://lmstudio.ai/docs/integrations/claude-code
7. YouTube — "Docker Sandboxes Hands-On Guide – A Safe Space for AI Agents!": https://youtu.be/kNGXuIPXR24

## Key Takeaways

- Docker Sandbox ใช้ **microVM isolation** (ไม่ใช่แค่ container) — agent ทำ destructive action ภายใน VM ได้โดย host ปลอดภัย
- **YOLO mode** (`--dangerously-skip-permissions`) ปลอดภัยเมื่อรันภายใน sandbox เพราะ sandbox เป็น guardrail แทน developer
- Network policy มี 3 tier: **Open / Balanced / Locked Down** — default คือ Balanced (deny all + AI API allowlist)
- `sbx policy log` แสดง audit trail real-time ของทุก network attempt ทั้ง allowed และ denied
- ติดตั้งด้วย `brew install docker/tap/sbx` — **ไม่ต้องมี Docker Desktop**
- รองรับ **Local LLM** (LM Studio) ผ่าน `sbx policy allow network -g localhost:1234` + override `ANTHROPIC_BASE_URL`
- เหมาะสำหรับ: CI/CD pipeline ที่รัน autonomous agent, การทดสอบ agent logic ที่ sensitive, และการลด API cost ด้วย local model
