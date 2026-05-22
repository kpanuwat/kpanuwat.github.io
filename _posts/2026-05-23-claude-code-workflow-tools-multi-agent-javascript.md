---
title: "Claude Code Workflow Tools: JavaScript Multi-Agent Orchestration ที่ประหยัด Token"
date: 2026-05-23 00:02:00 +0700
categories: [Engineering]
tags: [claude-code, multi-agent, workflow, javascript, orchestration, token-optimization]
---

## TL;DR

Anthropic เพิ่งเปิดตัว **Workflow Tool** ใน Claude Code — ฟีเจอร์ที่เปลี่ยนวิธีทำ multi-agent orchestration จากการใช้ LLM เป็น orchestrator กลาง มาเป็น **JavaScript code wrapper** แทน ทำให้ขจัด token tax ได้หมด รองรับ parallel processing, pipeline, schema validation และ auto-retry อัตโนมัติ เหมาะสำหรับงานซ้ำๆ หรือ multi-step job ที่ซับซ้อน ทำให้ระบบ agent ทำงานได้เสถียร ประหยัดต้นทุน และรับ task ระดับ production ได้จริง

## Background / Why This Matters

ก่อนหน้านี้การทำ multi-agent workflow ด้วย Claude Code มีวิธีหลักๆ คือให้ main session เป็น orchestrator แล้ว spawn sub-agent ออกไปทำงาน เมื่อ sub-agent ทำเสร็จ ผลลัพธ์จะถูกส่งกลับมายัง main session ดูเหมือนจะใช้งานได้ดี แต่ปัญหาคือ **ทุก token ที่ sub-agent ผลิตขึ้นมาจะวนกลับสู่ context window ของ orchestrator** ทำให้เกิดปรากฏการณ์ที่เรียกว่า "token tax"

ปัญหาจริงๆ ที่เกิดขึ้นในทางปฏิบัติ:

- Context window ของ main session เต็มอย่างรวดเร็วเมื่อทำงานหลาย step
- Model กลายเป็น "ขี้ลืม" และทำงานได้แย่ลงเมื่อ context อิ่มตัว
- ค่าใช้จ่ายพุ่งสูง เพราะ token ไหลเวียนซ้ำระหว่าง orchestrator กับ sub-agents โดยไม่จำเป็น
- ระบบไม่ resilient — ถ้า sub-agent ตัวใดตัวหนึ่งล้มเหลว ทั้ง workflow มักล่มตามไปด้วย

Workflow Tool แก้ทุกปัญหาข้างต้นด้วยแนวคิดเดียว: **เปลี่ยน orchestrator จาก LLM ที่ไม่ deterministic มาเป็น JavaScript code ที่ deterministic**

## Deep Dive

### ปัญหา: Token Tax และ Context Window เต็ม

เมื่อ main LLM session ทำหน้าที่ orchestrator มันต้องรับข้อมูลจาก sub-agent ทุกตัวก่อนส่งต่อ เหมือนกับให้ผู้จัดการอ่านรายงานทุกฉบับแล้วส่งสรุปให้พนักงานคนถัดไป แทนที่จะให้พนักงานส่งรายงานกันโดยตรง

```
[ก่อนใช้ Workflow Tool]

Sub-Agent A ──→ (ผลลัพธ์ทั้งหมด) ──→ Main LLM (Orchestrator)
                                                │
                                                ↓ (แปลงแล้วส่งต่อ)
Sub-Agent B ←──────────────────────────────────

→ Token ไหลผ่าน Main Session ทุกครั้ง → context เต็ม → model ลืมและทำงานได้แย่ลง
```

### วิธีแก้: Workflow Tool คืออะไร

Workflow Tool คือฟีเจอร์ใหม่ใน Claude Code ที่ให้นักพัฒนาสร้าง **ไฟล์ JavaScript** (เช่น `triage-sentry.js`) เพื่อทำหน้าที่ orchestrator แทน LLM ไฟล์นี้สามารถเรียก sub-agent, ผสม plain JavaScript logic กับ autonomous agent, กำหนด loop, conditional และ schema ได้อย่างอิสระ

```javascript
// triage-sentry.js — ตัวอย่าง workflow file
const issues = await getIssuesFromSentry();
const bigIssues = issues.filter(i => i.affectedUsers >= 20); // JS กรองข้อมูล

for (const issue of bigIssues) {
  const analysis = await agent(`Investigate this bug: ${issue.title}`, {
    schema: { fixNotes: "string", severity: "high|medium|low" }
  });
  await agent(`Fix the bug based on: ${analysis.fixNotes}`);
}
```

แนวคิดหลัก: **orchestration logic ถูกควบคุมโดย code ที่ deterministic** ไม่ใช่ LLM ที่อาจตัดสินใจแตกต่างกันในแต่ละครั้ง

### การส่งข้อมูลตรงระหว่าง Sub-Agents

เมื่อ orchestrator เป็น JavaScript แทน LLM ข้อมูลสามารถไหลตรงจาก sub-agent หนึ่งไปยังอีกตัวได้ทันที **โดยไม่ผ่าน main context window**

```
[หลังใช้ Workflow Tool]

JavaScript Code (Orchestrator — ไม่ใช่ LLM)
        │
        ├──→ Sub-Agent A → (structured data) ──→ Sub-Agent B
        │
        └──→ Sub-Agent C → (structured data) ──→ Sub-Agent D

→ Main context ไม่ถูกใช้เลย → ไม่มี token tax → รัน hundreds of agents ได้
```

ตัวแปรที่ Sub-Agent A คืนมา (เช่น issue ID, title, affected user count) จะถูก inject ตรงเข้า prompt ของ Sub-Agent B ผ่าน JavaScript variable — ไม่มีการ bounce กลับผ่าน main session

### Parallel Processing

Workflow Tool รองรับการ **fan out** — spawn sub-agent หลายตัวพร้อมกันแบบ parallel สมมติมี leads 8 คน สามารถเปิด research agent 8 ตัวพร้อมกันในคราวเดียว:

```javascript
const leads = loadFromCSV("leads.csv"); // 8 leads

// Fan out: research agent 8 ตัวทำงานพร้อมกัน
const results = await Promise.all(
  leads.map(lead =>
    agent(`Research this company: ${lead.company}`, {
      schema: { summary: "string", keyProducts: "string[]" }
    })
  )
);
```

เวลาที่ใช้ = เวลาของ agent ที่ช้าที่สุด 1 ตัว ไม่ใช่ผลรวมของทุกตัว

### Pipeline Design

Workflow สามารถออกแบบเป็น **หลาย stage** โดยแต่ละ stage รับ output จาก stage ก่อน และสิ่งที่ทรงพลังคือ pipeline ผสมกับ parallel ได้พร้อมกัน

ในตัวอย่าง lead outreach workflow:

1. **Stage 1 (Parallel):** Research agents 8 ตัวทำงานพร้อมกัน
2. **Stage 2 (Pipeline):** ทันทีที่ research agent ตัวแรกเสร็จ → writing agent เริ่มเขียนอีเมลทันที โดยไม่รอ research agent ตัวอื่นที่ยังทำงานอยู่

นี่คือ "streaming pipeline" — throughput สูงขึ้นมาก เพราะ stage 2 ไม่ต้องรอ stage 1 ทุกตัวเสร็จพร้อมกัน

### Schema Validation

เพื่อให้ sub-agent ส่งข้อมูลในรูปแบบที่ JavaScript logic อ่านได้ Workflow Tool รองรับ **schema validation** ระหว่าง agent:

```javascript
// กำหนด schema ที่ sub-agent ต้องคืนมา
const issue = await agent("Analyze this Sentry error", {
  schema: {
    issueId: "string",
    title: "string",
    affectedUsers: "number"
  }
});

// issue.issueId, issue.title, issue.affectedUsers พร้อมใช้ใน JS ทันที
if (issue.affectedUsers >= 20) {
  const verdict = await agent(`Fix: ${issue.title}`, {
    schema: { fixNotes: "string", severity: "high|medium|low" }
  });
}
```

Schema ทำให้ JavaScript filter, sort และ transform ข้อมูลระหว่าง agent ได้อย่างปลอดภัย

### Auto-Retry System

สำหรับ workflow ยาวที่อาจล้มเหลวกลางทาง Workflow Tool มีระบบ **retry อัตโนมัติ** — ถ้า sub-agent ใด fail (เช่น MCP server crash) ระบบจะ retry agent นั้นสูงสุด **3 ครั้ง** โดยอัตโนมัติ ทำให้ workflow ทั้งหมด resumable และไม่ต้องเริ่มใหม่ตั้งแต่ต้น

## User Guide (Step-by-Step)

### สร้าง Workflow ไฟล์แรก

**Step 1: สร้างไฟล์ JavaScript ในโปรเจค**

```bash
touch triage-sentry.js
```

**Step 2: เขียน workflow พื้นฐาน (sequential)**

```javascript
// triage-sentry.js
const issues = await agent("Fetch all unresolved Sentry issues as JSON", {
  schema: { issues: [{ id: "string", title: "string", affectedUsers: "number" }] }
});

// JS กรองแบบ deterministic — ไม่พึ่ง LLM
const bigIssues = issues.issues.filter(i => i.affectedUsers >= 20);

for (const issue of bigIssues) {
  await agent(`Investigate and fix this bug: ${issue.title} (ID: ${issue.id})`);
}
```

**Step 3: รัน workflow จาก Claude Code**

```
Run the workflow in triage-sentry.js
```

**Step 4: เพิ่ม parallel processing สำหรับ bulk tasks**

```javascript
// outreach.js
const leads = loadFromCSV("leads.csv");

// Phase 1: parallel research
const researched = await Promise.all(
  leads.map(lead => agent(`Research ${lead.company} for personalized outreach`, {
    schema: { summary: "string", painPoints: "string[]" }
  }))
);

// Phase 2: pipeline — draft email ทันทีที่ research เสร็จ (ไม่รอทุกตัว)
for (const [lead, research] of zip(leads, researched)) {
  await agent(`Write a personalized email to ${lead.name} at ${lead.company}.
    Key pain points: ${research.painPoints.join(", ")}`);
}
```

**Step 5: เพิ่ม loop สำหรับ iterative task**

```javascript
// dead-code-sweep.js
let hasDeadCode = true;

while (hasDeadCode) {
  const scan = await agent("Find dead code in this codebase", {
    schema: { found: "boolean", locations: "string[]" }
  });
  
  hasDeadCode = scan.found;
  
  if (hasDeadCode) {
    await agent(`Remove dead code at: ${scan.locations.join(", ")}`);
  }
}
```

### Use Case เมื่อไหรควรใช้ Workflow

| Use Case | เหมาะ? | เหตุผล |
|---|---|---|
| Triage bugs/issues ซ้ำๆ ทุกวัน | ✅ ดีมาก | Repeatable, structured, มี filter logic |
| Dead code cleanup แบบ iterative | ✅ ดีมาก | ต้องการ `while` loop จนกว่าจะหมด |
| Bulk outreach personalization | ✅ ดีมาก | Parallel + pipeline ได้ประโยชน์สูงสุด |
| One-off task ที่ไม่ซ้ำ | ❌ ไม่คุ้ม | Setup overhead สูงเกิน |
| งานที่ต้อง human approval ทุก step | ⚠️ ไม่เหมาะ | ออกแบบมาสำหรับ full automation |

## Caveats / Limits

- **JavaScript only (ปัจจุบัน):** Workflow file ต้องเขียนเป็น JavaScript — TypeScript และภาษาอื่นยังไม่รองรับ ณ เวลาที่เขียนบทความนี้ ควรตรวจสอบ [Claude Code Docs](https://code.claude.com/docs/en/common-workflows) สำหรับ update ล่าสุด
- **Auto-retry มีขีดจำกัดที่ 3 ครั้ง:** ถ้า sub-agent fail เกิน 3 ครั้ง workflow หยุด ควรออกแบบ fallback logic ไว้เองสำหรับงานที่ critical
- **Schema เป็น soft contract:** Sub-agent พยายาม conform กับ schema แต่ไม่ได้ guarantee 100% ควร validate output ใน JavaScript ก่อนส่งต่อ
- **Context window ของ sub-agent ยังมีอยู่:** Workflow ลด token tax ของ orchestrator แต่ sub-agent แต่ละตัวยังมี context window ของตัวเอง งานที่ต้องใช้ context ขนาดใหญ่ต่อ agent เดียวยังมีข้อจำกัด
- **MCP server stability:** Auto-retry ช่วยได้เมื่อ MCP crash ชั่วคราว แต่ถ้า MCP server down ทั้งหมด workflow จะล้มเหลว ควรมี health check ก่อนเริ่ม workflow ยาว

## References

1. [Anthropic Just Dropped the Feature Everyone Needed (YouTube)](https://youtu.be/c0gVowvMR-g) — demo Workflow Tool, Sentry triage, outreach workflow (แหล่งหลัก)
2. [Claude Code Common Workflows — Official Docs](https://code.claude.com/docs/en/common-workflows) — workflow patterns: subagents, worktrees, parallel sessions
3. [Code with Claude 2026: 5 New Agent Features (MindStudio)](https://www.mindstudio.ai/blog/code-with-claude-2026-new-agent-features) — ภาพรวม features ที่ Anthropic เปิดตัวงาน Code with Claude 2026
4. [Live blog: Code w/ Claude 2026 (Simon Willison)](https://simonwillison.net/2026/May/6/code-w-claude-2026/) — บันทึก keynote real-time รวม multi-agent orchestration announcement
5. [Claude Agent SDK: Agent Loops, Tool Calls, and Multi-Step Workflows (Augment Code)](https://www.augmentcode.com/guides/claude-agent-sdk-agent-loops-tool-calls) — ความสัมพันธ์ระหว่าง Claude Agent SDK กับ multi-agent patterns

## Key Takeaways

- **JavaScript orchestrator แทน LLM orchestrator:** เปลี่ยน non-deterministic LLM มาเป็น deterministic code — ควบคุมได้ ทดสอบได้ reproducible
- **ขจัด token tax ได้หมด:** ข้อมูลไหลตรงระหว่าง sub-agents ไม่ผ่าน main context → รัน hundreds of agents ได้โดยไม่ overflow
- **Parallel + Pipeline = throughput สูงสุด:** Fan out agents ทำงานพร้อมกัน + pipeline ที่ไม่ต้องรอทุก parallel agent เสร็จก่อนเริ่ม stage ถัดไป
- **Schema validation ทำให้ inter-agent communication type-safe:** กำหนด data structure ระหว่าง agents ทำให้ JavaScript filter/transform ได้ปลอดภัย
- **Auto-retry 3 ครั้ง** ทำให้ workflow ยาวๆ resilient กับ transient failures
- **เหมาะที่สุดกับ:** งานซ้ำๆ ทุกวัน, workflow ที่ต้องการ loop/conditional, multi-step job ที่ยาวพอที่จะล้มเหลวกลางทาง
- **ไม่ต้องการ orchestrator LLM** สำหรับ workflow ที่โครงสร้างชัดเจน — ประหยัดทั้ง token และเวลา
