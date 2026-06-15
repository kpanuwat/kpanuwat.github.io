---
title: "AI Agent Harness: สร้าง Agent ระดับ Production ด้วย Context Management, Skills และ Microsoft Foundry"
date: 2026-06-14 00:04:00 +0700
categories: [Engineering]
tags: [ai-agents, llm, agent-harness, context-management, microsoft-foundry, docker]
---

## TL;DR

**Agent Harness** คือ scaffolding ที่ควบคุม LLM ให้ทำงานได้จริงในโลก production — จัดการ Agent Loop, บริหาร Context (ป้องกัน Context Rot), โหลด Skills, สั่ง Sub-agent และบังคับ Permission การรัน Agent มี 3 โหมดหลัก: Local PC (ต้องเปิดเครื่องทิ้ง), Cloud VPS (จ่ายตลอด 24 ชม.) และ Microsoft Foundry Hosted Agent (Docker + scale-to-zero จ่ายเฉพาะเวลาใช้งาน)

## Background / Why this matters

LLM เพียงตัวเองรับ input ข้อความและ return output ข้อความ — ไม่มีความสามารถในการ "ทำ" อะไรในโลกจริงได้ด้วยตัวเอง นักพัฒนาที่ใช้ ChatGPT ผ่าน web จะรู้ว่าต้อง copy code → แก้ manual → copy error กลับไป → ถามใหม่ ทำซ้ำวนไปเรื่อยๆ

**Harness** คือสิ่งที่ทำให้ขั้นตอนนี้เป็น **อัตโนมัติ** — model เสนอ action → harness execute → ผลลัพธ์กลับสู่ model → loop ซ้ำจนงานเสร็จ ตัวอย่างที่เห็นได้ชัดคือ Cursor ที่ automate workflow ที่ ChatGPT ทำด้วย manual loop

แต่เมื่อ AI Agent พัฒนาอย่างรวดเร็ว โปรแกรมเมอร์ต้องการรัน agent 24/7 เพื่อทำงานอัตโนมัติ ทำให้เกิดคำถามว่าจะรัน agent ที่ไหน และอย่างไร ถึงจะคุ้มค่าและง่ายต่อการจัดการ

## Deep Dive

### Agent Harness คืออะไร

**Agent Harness** คือ scaffolding ที่ wrap รอบ LLM — "คุณภาพของ harness กำหนดว่า agent สามารถทำอะไรได้" harness ที่ดีขยาย capability ของ model อย่างมากโดยไม่ต้อง upgrade model เลย

Harness ทำหน้าที่หลัก 3 อย่าง:
1. **Context Management** — กำหนดว่า model เห็นอะไรในแต่ละ turn: code, errors, history, tool results
2. **Tool Execution** — execute action จริง (แก้ไฟล์, รัน tests, เรียก API) ไม่ใช่แค่ propose
3. **Loop Control** — ตัดสินใจว่าจะ loop ต่อหรือจบงาน

### Agent Loop

```
┌────────────────────────────────────────────────────┐
│                   Agent Loop                        │
│                                                    │
│  [Context] → [LLM] → [Action] → [Execute] → [Result]│
│      ↑                                      ↓      │
│      └──────────── Update Context ←─────────┘      │
└────────────────────────────────────────────────────┘
```

แต่ละ iteration: harness เตรียม context → ส่งไป LLM → LLM เลือก action (tool call หรือ final answer) → harness execute → ผลลัพธ์เข้า context รอบถัดไป Loop หยุดเมื่อ: task complete, step limit ครบ, หรือ LLM ระบุว่าเสร็จแล้ว

### Context Management และ Context Rot

**Context window** คือทรัพยากรที่แพงที่สุดใน agent system — ทุก token ใน context เสียค่า inference

**Context Rot** คือปัญหาที่เกิดเมื่อ context เต็มด้วยข้อมูลที่ไม่เกี่ยวข้อง ล้าสมัย หรือซ้ำซ้อน ทำให้:
- LLM เสียสมาธิ → คุณภาพ output ลดลง
- Token cost สูงขึ้นทุก turn
- Response ช้าลง

Harness แก้ปัญหา Context Rot ด้วย:
- **Summarization** — summarize ประวัติ conversation เก่าแทนที่จะเก็บ raw text
- **Staged loading** — โหลด skill/guide เฉพาะเมื่อ task ตรงกัน (ไม่ load ทุกอย่างตั้งแต่ต้น)
- **Priority eviction** — ลบ entry ที่ relevance ลดลง

### Skills

**Skills** คือไฟล์ instruction ที่ Harness โหลดเข้า context แบบ on-demand ตามความต้องการของ task แต่ละ skill บรรจุ:
- วิธีการ approach งานประเภทนั้น
- checklist ขั้นตอนที่ต้องทำ
- ข้อกำหนดเฉพาะ (เช่น security rules, naming conventions)

แทนที่จะใส่ instruction ทั้งหมดใน system prompt (ทำให้ context ใหญ่ตั้งแต่เริ่ม) harness โหลด skill เฉพาะที่จำเป็น ตัวอย่าง: ถ้า task คือ "สร้าง post ใหม่" → โหลด `knowledge-hub` skill; ถ้า task คือ "สร้าง slide deck" → โหลด `marp-deck` skill

### Sub-agents

**Sub-agent** คือ agent ที่ถูกสร้างขึ้นมาสำหรับงานเฉพาะ — มี Agent Loop ของตัวเอง, context แยกต่างหาก, และ tool registry ที่ถูก filter ให้เหมาะกับ role

ประโยชน์หลัก:
- **Context isolation** — แต่ละ sub-agent มี clean context ป้องกัน context rot ข้ามงาน
- **Parallel execution** — หลาย sub-agent ทำงานพร้อมกันได้
- **Tool scoping** — sub-agent Code-Explorer มีแค่ read-only tools; sub-agent Security-Reviewer มีแค่ vulnerability scanner

Parent agent สั่ง sub-agent ผ่าน `Agent` tool พร้อม prompt และ sub-agent type

### Permission System

**Permission** ใน harness คือ governance ที่ externalize ออกมาจาก prompt — constraint ถูก encode เป็น declarative rules แล้ว enforce ที่ runtime

รูปแบบ:
- **allowlist/denylist** — tool/command ไหนรัน auto ได้, อันไหนต้องถาม
- **Just-in-time access** — สิทธิ์เข้า sensitive API ให้เฉพาะ duration ของ task
- **Human-in-the-loop** — destructive operations (force push, DB drop) ต้องได้รับ confirm จาก human ก่อน

### 3 วิธีรัน Agent

#### Option 1: Local PC

รัน agent บน laptop/desktop ส่วนตัว

**ข้อดี:**
- ฟรี — ใช้ hardware ที่มีอยู่แล้ว
- latency ต่ำ — ไม่มี network hop

**ข้อเสีย:**
- ต้องเปิดเครื่องทิ้งไว้ตลอดเวลา
- ถ้าปิดเครื่อง/sleep → agent หยุดทำงาน
- ไม่เหมาะสำหรับ agent ที่ต้องทำงาน 24/7 หรือ scheduled tasks

**เหมาะสำหรับ:** development, testing, งานที่ไม่ต้องการ uptime สูง

#### Option 2: Cloud VPS

รัน agent บน Virtual Private Server (เช่น DigitalOcean Droplet, AWS EC2, Hetzner)

**ข้อดี:**
- uptime 24/7 โดยไม่ต้องพึ่ง local machine
- ควบคุม environment ได้เต็มที่

**ข้อเสีย:**
- **จ่ายตลอด 24 ชม. แม้ agent ไม่ได้ทำงาน** — VPS billing by hour/month ไม่ใช่ by usage
- ต้องดูแล OS updates, security patches, monitoring เอง
- Scale manually

**ข้อคำนวณ:** Hetzner CX22 (2 vCPU, 4GB RAM) ~€3.79/เดือน — ถ้า agent รัน 2 ชม./วัน จ่าย 100% สำหรับ 92% ของเวลาที่ idle

#### Option 3: Microsoft Foundry Hosted Agent

รัน agent เป็น Docker container บน **Microsoft Foundry Agent Service** — managed platform ที่จัดการ infra ให้ทั้งหมด

**สถาปัตยกรรม:**
```
Docker Image → Azure Container Registry → Foundry Agent Service
                                                    ↓
                           Per-session VM-isolated sandbox
                           (provisioned on demand, $HOME persisted)
```

**ข้อดีหลัก — Stateless Compute:**
- **Scale-to-zero** — compute deprovision อัตโนมัติหลัง idle 15 นาที
- **จ่ายเฉพาะเวลา active session** — billing by CPU + memory ที่ใช้จริง ไม่ใช่ by time
- **State ยังคงอยู่** — `$HOME` และ `/files` persist แม้ compute หยุด; session resume ได้ทุกเวลา

**Isolation model:**
- แต่ละ session ได้ VM-isolated sandbox แยกต่างหาก
- Session lifetime สูงสุด 30 วัน; idle timeout 15 นาที

**Sandbox sizes (preview):**

| CPU | Memory | Use case |
|-----|--------|---------|
| 0.5 vCPU | 1 GiB | Light tasks, simple agents |
| 1 vCPU | 2 GiB | Standard workloads |
| 2 vCPU | 4 GiB | Heavy computation |

**Protocols รองรับ:**
- **Responses** — OpenAI-compatible; platform จัดการ conversation history, streaming
- **Invocations** — custom JSON payload; เหมาะกับ webhooks, structured data processing
- **Invocations (WebSocket)** — bidirectional streaming สำหรับ voice agent (preview, North Central US only)

**Deployment เพียง 4 ขั้นตอน:**
```bash
# 1. Build + push Docker image
docker build -t myagent . && az acr push myregistry.azurecr.io/myagent:v1

# 2. Create agent version
az foundry agent create-version --name myagent --image myregistry.azurecr.io/myagent:v1

# 3. Deploy
az foundry agent deploy --name myagent

# 4. Invoke
curl {project_endpoint}/agents/myagent/endpoint/protocols/openai/responses
```

**หรือใช้ `azd` (Azure Developer CLI) ที่ auto-provision Container Apps, ACR, Cosmos DB ทั้งหมดจาก `azure.yaml` เดียว**

**ข้อควรระวัง:**
- ยัง Preview (mid-2026); GA คาดปลาย Q2/Q3 2026
- Max 50 concurrent sessions/subscription/region (ขอเพิ่มได้)
- ภาษาที่รองรับ: Python และ C# เท่านั้น
- Container Registry ต้องเป็น public endpoint (private ACR ยังไม่รองรับ)

### เปรียบเทียบ 3 โหมด

| เกณฑ์ | Local PC | Cloud VPS | Microsoft Foundry |
|--------|----------|-----------|-------------------|
| Uptime | เครื่องเปิดอยู่เท่านั้น | 24/7 | 24/7 (scale-to-zero) |
| Cost model | ฟรี (hardware เดิม) | Fixed/month | Pay per session |
| Idle cost | $0 | จ่ายเต็ม | $0 (15 min timeout) |
| Setup complexity | ต่ำ | กลาง | กลาง-สูง (Docker) |
| Scale | Manual | Manual | Auto per session |
| State persistence | Process memory | Disk | $HOME + Cosmos DB |
| Best for | Dev/test | Always-on low cost | Production, bursty |

## Caveats / Limits

- **Microsoft Foundry Hosted Agents** ยัง Preview ณ mid-2026 — production workloads อาจต้องรอ GA (Q3/Q4 2026)
- **Cold start latency** — session resume หลัง 15 นาที idle มี cold start เพิ่มขึ้นเล็กน้อย (state restore)
- **Language lock-in** — Foundry Hosted Agents รองรับแค่ Python และ C# ตอนนี้ — Go/Rust/Node ต้องรอ หรือใช้ HTTP proxy
- **Context Rot เป็น progressive** — ไม่มี error; agent ค่อยๆ ด้อยประสิทธิภาพลงโดยไม่มีสัญญาณชัดเจน ต้องตั้ง context window budget ไว้ตั้งแต่ต้น
- **Sub-agent cost** — แต่ละ sub-agent มี LLM call แยก → cost พุ่งถ้าไม่ได้ set step limit
- **Permission bypass risk** — harness permission ทำงานที่ runtime ไม่ใช่ฝั่ง model — model ยังคงสามารถ hallucinate action ที่ไม่ได้ allow ได้ ต้องมี validation layer ด้วย
- **Concurrent sessions limit** — default 50 sessions/subscription/region; สำหรับ multi-tenant app ต้องขอ quota เพิ่ม

## References

1. [What is an AI Agent Harness? — Medium (Deven Joshi)](https://medium.com/@d3xvn/what-is-an-ai-agent-harness-20a573f24e01) — harness definition and core concepts
2. [Hosted agents in Foundry Agent Service — Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents) — official concepts, session lifecycle, sandbox sizes
3. [What's New in Hosted Agents — Foundry Blog](https://devblogs.microsoft.com/foundry/hosted-agents-build26/) — Build 2026 announcement and updates
4. [Microsoft Agent Framework at BUILD 2026](https://devblogs.microsoft.com/agent-framework/microsoft-agent-framework-at-build-2026-announce/) — Hosted Agents context in broader framework
5. [Hosted Containers and AI Agent Solutions — Microsoft Community Hub](https://techcommunity.microsoft.com/blog/azuredevcommunityblog/hosted-containers-and-ai-agent-solutions/4500627) — Docker + Container Apps architecture
6. [AI Agent Best Practices: Production-Ready Harness Engineering 2026](https://medium.com/@tort_mario/ai-agent-best-practices-production-ready-harness-engineering-2026-guide-c1236d713fac) — agent loop, context rot, permission patterns
7. [YouTube: Claw and agent harness on Microsoft Foundry](https://youtu.be/vvkN0Hvl-bg) — source video สำหรับโพสต์นี้

## Key Takeaways

- **Harness คือ multiplier** — คุณภาพของ harness กำหนด capability ของ agent มากกว่า model เวอร์ชัน
- **Context Rot เป็นปัญหาเงียบ** — agent ค่อยๆ แย่ลงโดยไม่มี error message; harness ต้องบริหาร context actively ผ่าน summarization + staged loading
- **Skills = on-demand instruction** — โหลดเฉพาะ skill ที่ task ต้องการ ลด context ตั้งแต่เริ่มต้น
- **Sub-agents + context isolation** — แต่ละ sub-agent มี clean context แยกต่างหาก ป้องกัน cross-task noise
- **Foundry Hosted Agent = บิลค่าแรงงาน ไม่ใช่ค่าเช่า** — จ่ายเฉพาะเวลา agent ทำงานจริง ไม่มี idle cost; state persist ผ่าน $HOME + Cosmos DB
- **Local → VPS → Foundry** คือ spectrum ของ trade-off: ฟรีแต่ไม่ always-on → always-on แต่ idle waste → always-on + pay-per-use
