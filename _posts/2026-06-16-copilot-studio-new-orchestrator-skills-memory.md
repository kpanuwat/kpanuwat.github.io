---
title: "Copilot Studio ใหม่: Orchestrator, Skills, Memory และ MCP Servers"
date: 2026-06-15 00:01:00 +0700
categories: [Tools]
tags: [copilot-studio, microsoft, ai-agents, mcp, orchestrator, power-platform]
---

## TL;DR

Microsoft ปรับ Copilot Studio ครั้งใหญ่ — เปลี่ยนจาก chatbot builder ที่ใช้ Topics/Triggers มาเป็น enterprise automation platform ขับเคลื่อนด้วย generative orchestrator รองรับ Python, Node, Bash พร้อม Skills (.md), Memory ข้ามเซสชัน และ MCP Servers แทน connector แบบเดิม

## Background / Why This Matters

Copilot Studio รุ่นเดิมสร้างมาสำหรับ chatbot ที่มี flow แบบ deterministic — ผู้ใช้พิมพ์ keyword → trigger firing → topic tree เดิน conversation flow ไปตามแผนที่วาดไว้ โมเดลนี้ทำงานได้ดีสำหรับ FAQ bot หรือ simple task automation แต่พอ workload ซับซ้อนขึ้น (multi-step research, cross-system orchestration, file generation) มันกลายเป็น bottleneck

ปี 2026 Microsoft ตัดสินใจ rebuild Copilot Studio ใหม่จากพื้นฐาน เพื่อรองรับ agentic workflow ที่ agent ตัดสินใจเองว่าจะเรียก tool ไหน ในลำดับใด โดยไม่ต้องกำหนด trigger ล่วงหน้าทุกอย่าง ผลลัพธ์คือ platform ใหม่ที่เปลี่ยนทั้ง UX, runtime และ architecture

## Deep Dive

### 4 Modes ใหม่: Build → Preview → Evaluate → Monitor

UI ปรับจาก sidebar-driven canvas มาเป็น **4 tab workflow** ที่แต่ละ tab มี context ชัดเจน:

| Mode | หน้าที่ |
|------|--------|
| **Build** | สร้าง agent — กำหนด Skills, เชื่อม MCP servers, ตั้ง Memory, เขียน instructions |
| **Preview** | ทดสอบ agent แบบ interactive ก่อน deploy — ดู reasoning trace, tool calls, memory reads |
| **Evaluate** | วัดผลด้วย custom metrics — เช่น resolution rate, task completion, response accuracy |
| **Monitor** | ดู production logs, token usage, error rates, conversation health แบบ real-time |

Pattern นี้คล้าย software development lifecycle: code → test → measure → observe ทำให้ enterprise team สามารถสร้าง governance process รอบ agent ได้ชัดเจนขึ้น

### Orchestrator: Python, Node, Bash

Orchestrator คือ brain หลักที่เปลี่ยน Copilot Studio จาก rule-based ไป generative:

- รับ user intent → วิเคราะห์ว่าต้องใช้ tool/skill/knowledge/sub-agent ตัวไหน
- เรียก code execution ใน **Python, Node.js หรือ Bash** โดยตรง — ทำให้ agent วิเคราะห์ข้อมูล, query API, แปลง format ได้โดยไม่ต้องออกไป Power Automate
- ประสิทธิภาพดีกว่า orchestrator รุ่นเดิม ~20% และใช้ token น้อยลง ~50%

ตัวอย่าง: agent รับไฟล์ CSV → ใช้ Python script วิเคราะห์ → สร้าง Excel report → แนบใน reply — ทั้งหมดนี้เกิดใน Copilot Studio ไม่ต้องไป Power Automate หรือ Logic Apps

### Skills: ไฟล์ .md ที่สร้างจาก Prompt

Skills คือ reusable instruction set ที่สอน agent ว่าทำ task เฉพาะทางอย่างไร:

```markdown
# Analyze Sales Data

When user asks to analyze sales data:
1. Request the data file or connection
2. Run Python analysis: calculate totals, trends, outliers
3. Generate summary table
4. Offer to export as Excel or PDF
```

- เขียนเป็น Markdown ธรรมดา ไม่ต้องรู้ code
- สร้างได้จาก prompt ใน Build mode — describe what the agent should do → Copilot Studio generates the Skill file
- เก็บใน repository หรือ user profile → Copilot Studio auto-discovers และ apply
- แตกต่างจาก Topics เดิมตรงที่ Skills ไม่มี trigger keyword — orchestrator เลือกเรียกตาม context

### Memory: จดจำข้ามเซสชัน

Memory system ให้ agent เก็บข้อมูลที่ user บอกไว้และนำมาใช้ใน session ถัดไป:

- **Session memory**: context ใน conversation ปัจจุบัน (เหมือน context window)
- **Persistent memory**: เก็บ user preferences, project context, past decisions ข้ามวัน
- ผ่าน **Work IQ API** (public preview) — developer integrate memory layer เข้าไปใน custom app ได้

ตัวอย่าง use case: agent จำได้ว่า user ชอบ report format ใดหรือว่า project นี้ใช้ budget สกุลเงินอะไร โดยไม่ต้องถามซ้ำทุกครั้ง

### MCP Servers: แทน Connector แบบเดิม

Model Context Protocol (MCP) เป็น open standard ที่ให้ agent เชื่อมกับ external tools และ data sources ผ่าน interface เดียว:

```
Copilot Studio Agent
       │
       ▼
  MCP Server (your tool)
  ├── Resources (data to read: files, API responses)
  ├── Tools     (functions to call: create, update, query)
  └── Prompts   (predefined templates)
```

ข้อดีเหนือ Power Platform Connector แบบเดิม:

| | Traditional Connector | MCP Server |
|---|---|---|
| **มาตรฐาน** | Microsoft-specific | Open standard (cross-platform) |
| **Update** | Manual publish | Dynamic — agent reflects changes อัตโนมัติ |
| **Scope** | Actions only | Resources + Tools + Prompts |
| **ต้องการ** | Certified connector | MCP server ใดก็ได้ |

**ข้อกำหนด**: ต้องเปิด Generative Orchestration เพื่อใช้ MCP

### ถอดออก: Topics, Triggers, Inline Child Agents

Microsoft ถอด 3 feature หลักออกจากโมเดลใหม่:

| Feature เดิม | เหตุผลที่ถอด | ทดแทนด้วย |
|---|---|---|
| **Topics** | Deterministic flow, fragile ถ้า user พิมพ์นอกสคริปต์ | **Skills** + Generative Orchestrator |
| **Triggers** | Keyword matching brittle, ต้อง maintain list | Orchestrator เข้าใจ intent เอง |
| **Inline Child Agents** | Tightly coupled, ยาก reuse | **Standalone Agents** + Workflows |

### Workflows และ Standalone Agents

**Workflows**: visual designer ใหม่บน unified canvas — build end-to-end automation ที่รวม agent nodes, approvals, API calls, logic ไว้ที่เดียว ทำงานได้ทั้งแบบ standalone automation หรือ agent-triggered tool

**Standalone Agents**: agent ที่ deploy แยกต่างหาก reuse ได้ข้าม workflow หลาย project เรียกผ่าน Agent-to-Agent (A2A) protocol ที่ GA แล้ว

## User Guide (Step-by-Step)

### สร้าง Agent ใหม่ด้วย Copilot Studio ใหม่

**1. เปิด Build mode → New Agent**
- ตั้งชื่อและ description
- เลือก base model
- เปิด Generative Orchestration (จำเป็นสำหรับ MCP และ Skills)

**2. เพิ่ม Skill**
- คลิก **Skills → Add Skill**
- พิมพ์ description ว่าต้องการให้ agent ทำอะไร
- Copilot Studio generate Skill .md ให้ → review และ save

**3. เชื่อม MCP Server**
- คลิก **Tools → Add MCP Server**
- ใส่ MCP server endpoint URL
- เลือก Tools และ Resources ที่ต้องการ expose ให้ agent

**4. ตั้ง Memory**
- เปิด **Memory** panel → เลือก Persistent หรือ Session scope
- กำหนด memory keys ที่ agent ควรจำ (เช่น user language preference, project name)

**5. ทดสอบใน Preview mode**
- พิมพ์ test prompt → ดู reasoning trace ว่า orchestrator เลือก Skill/Tool ไหน
- ตรวจสอบ memory read/write ว่าถูกต้อง

**6. Deploy → Monitor**
- Publish agent → ไปที่ Monitor tab
- ตั้ง alert สำหรับ error rate หรือ high token usage

## Caveats / Limits

- **Migration cost**: bot เดิมที่ใช้ Topics ต้อง rewrite เป็น Skills — ไม่มี auto-migration tool ณ ตอนนี้
- **MCP ต้องการ Generative Orchestration**: ถ้าปิด feature นี้ MCP จะไม่ทำงาน
- **Memory (Persistent) = Work IQ API**: ยังอยู่ใน public preview — อาจเปลี่ยน schema
- **Python/Node/Bash execution**: มี sandbox limitations — ไม่สามารถ install arbitrary packages, network access จำกัด
- **Computer-using agents**: GA แล้วในบาง region แต่ยังไม่ครบทุกประเทศ
- **Pricing**: token usage เปลี่ยนวิธีคิด — orchestrator ที่ generative อาจใช้ token มากกว่า deterministic topic flow สำหรับ simple tasks

## References

1. [Meet the new Copilot Studio: rebuilt for more complex, multi-step work — Microsoft Tech Community](https://techcommunity.microsoft.com/blog/copilot-studio-blog/meet-the-new-copilot-studio-rebuilt-for-more-complex-multi-step-work/4526488)
2. [What's new in Copilot Studio: May 2026 — Microsoft Copilot Blog](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-computer-using-agents-a-new-workflows-experience-and-real-time-voice-experiences/)
3. [What's new in Copilot Studio: April 2026 — Microsoft Copilot Blog](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/new-and-improved-agent-governance-intelligent-workflows-and-connected-app-experiences/)
4. [Extend your agent with Model Context Protocol — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agent-extend-action-mcp)
5. [Overview of Microsoft Copilot Studio 2026 Release Wave 1 — Microsoft Learn](https://learn.microsoft.com/en-us/power-platform/release-plan/2026wave1/microsoft-copilot-studio/)
6. [Multi-agent orchestration patterns — Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/multi-agent-patterns)
7. [Copilot Studio 2026 Orchestrator & UX — HubSite365](https://www.hubsite365.com/en-ww/crm-pages/copilot-studio-new-2026-orchestrator-and-ui-ux-be8dd255-176c-4e2f-a5a1-ca9884611c41.htm)
8. [YouTube: New Copilot Studio deep-dive](https://youtu.be/aX4bcDPTmPY)

## Key Takeaways

- **4-mode workflow** (Build → Preview → Evaluate → Monitor) ทำ SDLC ชัดขึ้น — ไม่ใช่แค่ build แล้ว deploy
- **Orchestrator generative** เลือก tool เองตาม intent — ไม่ต้อง map keyword → trigger ทุกกรณี
- **Skills = .md files** สร้างจาก natural language ทำให้ non-developer สร้าง instruction set ได้
- **Memory ข้ามเซสชัน** ผ่าน Work IQ API — agent จำ context ของ user ได้โดยไม่ต้องถามซ้ำ
- **MCP แทน Connector** — open standard, dynamic update, reuse ข้าม platform ได้
- **Topics/Triggers ถูกถอดออก** — migration จาก bot เดิมต้องเขียน Skills ใหม่
- Python/Node/Bash ใน orchestrator ทำให้ agent สร้าง Excel/PDF โดยตรง ไม่ต้องออกไป Power Automate
