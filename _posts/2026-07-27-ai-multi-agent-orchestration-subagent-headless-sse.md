---
title: "AI Multi-agent Orchestration: Sub-agent CLI กับ Headless Mode ผ่าน SSE"
date: 2026-07-26 00:01:00 +0700
categories: [Engineering]
tags: [claude-code, multi-agent, subagents, headless-mode, sse, cli-orchestration, ai-agents]
---

## TL;DR

AI Multi-agent Orchestration ทำได้ 2 รูปแบบหลัก: (1) **Sub-agent** ผ่าน Agent CLI ตัวเดียว กระจายงานไปยัง context window แยกกันภายในเซสชันเดียว และ (2) **Headless Mode** ควบคุมผ่าน command line เชื่อมข้าม CLI หลายตัวด้วย `stdin`/`stdout` แล้วส่งต่อสถานะแบบเรียลไทม์ด้วย Server-Sent Events (SSE) — ทั้งสองแบบช่วยเพิ่มความเร็วด้วย parallelization และบริหาร context window แยกตามความเฉพาะทางของงาน

## Background / Why this matters

เมื่อ agent ตัวเดียวต้องรับผิดชอบทุกงาน — ค้นเอกสาร, รัน test, เขียนโค้ด, สร้างภาพ — บทสนทนาหลัก (main context) จะเต็มไปด้วย log และผลลัพธ์ระหว่างทางที่ไม่ได้ใช้ซ้ำ ทำให้ context window หมดเร็วและ agent เริ่ม "หลงประเด็น" การกระจายงานออกไปทำในพื้นที่แยก (isolated context) จึงกลายเป็นสถาปัตยกรรมหลักของ agent CLI สมัยใหม่ ไม่ใช่แค่ฟีเจอร์เสริม

ปัญหาถัดมาคือการ **orchestrate agent หลายตัวข้ามเครื่องมือ** — เช่น ให้ Claude Code วางแผน แล้วส่งงานย่อยไปให้ CLI อื่น (Codex, Gemini CLI ฯลฯ) ทำงานเฉพาะทาง สิ่งนี้ต้องการช่องทางสื่อสารที่เป็นมาตรฐาน (stdin/stdout) และกลไกอัปเดตสถานะแบบ real-time (SSE) เพื่อให้ผู้ใช้เห็นความคืบหน้าของ agent แต่ละตัวโดยไม่ต้อง poll ซ้ำๆ

## Deep Dive

### 1. Sub-agent — กระจายงานภายใน context ที่แยกกัน

Subagent คือ AI assistant เฉพาะทางที่ทำงานย่อยแบบอัตโนมัติ ภายใต้ session เดียวกัน [1][2] จุดสำคัญคือ subagent แต่ละตัว **เริ่มต้นด้วย context window ใหม่ทั้งหมด** — ไม่สืบทอดประวัติสนทนาหรือผลลัพธ์ tool ก่อนหน้าจาก orchestrator หลัก [1][2] ทำให้งานที่มีผลลัพธ์เยอะๆ (อ่าน log ก้อนใหญ่, สแกนหลายไฟล์, ทดสอบซ้ำๆ) ถูก "กัน" ไว้ในพื้นที่ของตัวเอง แล้วส่งกลับมาแค่บทสรุปสั้นๆ ให้ orchestrator [1]

แต่ละ subagent ยังกำหนด **system prompt, ชุด tool ที่เข้าถึงได้, และ permission ของตัวเอง** แยกจากกัน — เช่น subagent ที่ทำหน้าที่รีวิวโค้ดอาจได้แค่สิทธิ์ read-only ในขณะที่ subagent ที่ implement ฟีเจอร์ได้สิทธิ์เขียนไฟล์เต็มรูปแบบ [2] ช่องทางเดียวที่ parent ส่งข้อมูลเข้าไปคือ prompt string ตอนเรียกใช้งาน — จึงต้องใส่ path ไฟล์, error message, หรือบริบทที่จำเป็นทั้งหมดลงในนั้นโดยตรง เพราะ subagent มองไม่เห็นบทสนทนาก่อนหน้า

### 2. Headless Mode (`-p` flag) — orchestration ข้าม CLI ผ่าน stdin/stdout

Headless mode รัน agent CLI แบบ non-interactive — ส่ง prompt เข้าไปครั้งเดียวด้วยแฟล็ก `-p` (หรือ `--print`) แล้วได้ผลลัพธ์กลับมาโดยไม่ต้องเปิดหน้าต่างแชท [3] เพราะรันเป็น process มาตรฐานของ shell ผลลัพธ์ที่ออกทาง **stdout ของ CLI ตัวหนึ่งจึงถูก pipe เข้าไปเป็น stdin ของ CLI อีกตัวได้โดยตรง** [3] — เช่น ให้ Claude Code ส่ง prompt สำหรับ generate ภาพผ่าน stdout ไปยัง stdin ของ Codex CLI

Output format มี 3 แบบ: `text` (ข้อความเปล่า), `json` (ผลลัพธ์โครงสร้างพร้อม metadata เช่น session ID), และ `stream-json` (เหตุการณ์แบบ newline-delimited JSON ที่ทยอยส่งออกมาระหว่างรัน) [3] รูปแบบ `stream-json` นี้เองที่ทำให้ระบบภายนอกแกะข้อมูล execution ได้แบบ incremental — เช่น รู้ว่า agent กำลังเรียก tool ไหน, spawn subagent ตัวไหน — โดยไม่ต้องรอจนจบงาน

### 3. SSE — ส่งสถานะ multi-agent แบบเรียลไทม์ไปหน้าเว็บ

Server-Sent Events (SSE) คือการเชื่อมต่อทางเดียวแบบต่อเนื่องจาก server ไปหา client เพื่อ push ข้อมูลสดๆ ตลอดเวลา ในสถาปัตยกรรม multi-agent, server ฟัง `stream-json` ที่ไหลออกมาจาก headless CLI, แกะสถานะปัจจุบัน แล้วส่งต่อผ่าน SSE ไปยัง frontend โดยตรง ทำให้ผู้ใช้เห็นอัปเดตแบบ "agent is thinking", "agent spawned", "results synthesized" ของ agent หลายตัวที่รันพร้อมกันแบบ asynchronous โดยไม่ต้อง poll server ซ้ำๆ — ต่างจาก WebSocket ตรงที่ SSE เป็น one-way (server→client) ทำให้ implement ง่ายกว่าเมื่อ client แค่ต้องการ "ดู" สถานะ ไม่ต้องส่งข้อมูลกลับ

### 4. ทำไมวิธีนี้เร็วขึ้นและบริหาร context ได้ดีขึ้น

- **Speed ผ่าน parallelization** — งานย่อยที่เป็นอิสระต่อกัน (query database คนละตัว, สแกนไฟล์คนละชุด) spawn พร้อมกันได้ ทำให้ workflow ทั้งหมดจบเร็วเท่า agent ที่ช้าที่สุด แทนที่จะรันเรียงลำดับทีละตัว [4][5]
- **Context window management** — งานที่มีข้อมูลดิบเยอะถูกส่งไปให้ subagent จัดการ ทำให้ orchestrator หลักไม่ชนขีดจำกัด token และไม่เสียพื้นที่ context ไปกับรายละเอียดที่ไม่จำเป็นต้องเก็บ [1][4]
- **Task specialization** — แทนที่จะมี agent เดียวที่โหลดทุกความสามารถไว้ งานถูกส่งไปยัง subagent เฉพาะทางที่มี system prompt, โมเดล, และข้อจำกัดการใช้ tool ที่รัดกุมกว่า ทำให้ผลลัพธ์แม่นยำและปลอดภัยกว่า [5][6]

## User Guide (Step-by-Step)

### 1. เริ่มด้วย Sub-agent ภายใน Claude Code

```bash
# ตรวจสอบ subagent ที่มีอยู่ในโปรเจกต์
ls .claude/agents/

# เรียก subagent ผ่านเครื่องมือ Agent ภายในเซสชัน
# (Claude Code ตัดสินใจ dispatch เองเมื่อ description ของ subagent ตรงกับงาน)
```
คาดหวังผลลัพธ์: subagent รันแยก context, สรุปผลกลับมาสั้นๆ โดยไม่พ่น log ดิบเข้ามาในบทสนทนาหลัก

### 2. รัน headless mode ครั้งแรก

```bash
claude -p "summarize the open TODOs in this repo" --output-format json
```
คาดหวังผลลัพธ์: JSON object เดียวที่มี `result` + `session_id` — ใช้ใน script/CI ได้ทันทีโดยไม่ต้องเปิดหน้าต่างแชท

### 3. เชื่อมข้าม CLI ด้วย stdin/stdout

```bash
claude -p "draft an image-gen prompt for a cheatsheet" --output-format text \
  | codex exec --stdin
```
คาดหวังผลลัพธ์: prompt ที่ Claude Code สร้างถูกส่งตรงเข้า stdin ของ Codex CLI โดยไม่ต้อง copy-paste ด้วยมือ

### 4. ทยอยอ่านสถานะแบบ stream-json

```bash
claude -p "run the test suite and report" --output-format stream-json
```
คาดหวังผลลัพธ์: newline-delimited JSON events (tool call, subagent spawn, ผลลัพธ์บางส่วน) — parse ทีละบรรทัดเพื่อ track ความคืบหน้าแบบ real-time

### 5. ต่อ SSE เข้ากับ frontend

ฝั่ง server: อ่าน `stream-json` จาก process ของ headless CLI ทีละบรรทัด, แปลงเป็น event object, ส่งผ่าน SSE endpoint (`Content-Type: text/event-stream`) ฝั่ง client: เปิด `EventSource` ฟัง event แล้วอัปเดต UI ทันทีที่มี event ใหม่ — ไม่ต้องตั้ง polling interval

### Troubleshooting

- CLI ตัวปลายทางไม่รับ stdin → เช็คว่า flag ที่ใช้รองรับ non-interactive input จริง (ไม่ใช่ทุก CLI มี `--stdin` เหมือนกัน)
- SSE connection หลุดกลางทาง → เพิ่ม heartbeat event ทุกๆ ไม่กี่วินาทีกันบาง proxy/load balancer timeout การเชื่อมต่อที่ idle นานเกินไป
- subagent ไม่เห็น context ที่ต้องการ → ตรวจสอบว่าใส่ path/error/decision ที่จำเป็นลงใน prompt string ตอนเรียกจริง เพราะ subagent ไม่สืบทอดบทสนทนาก่อนหน้า

## Caveats / Limits

- Subagent เริ่ม context ใหม่ทุกครั้ง — ถ้า orchestrator ลืมใส่ข้อมูลจำเป็นลง prompt, subagent จะทำงานผิดทิศทางโดยไม่รู้ตัว
- Headless mode ตัดส่วน human-facing chat shell ออก แต่ agent loop เต็มรูปแบบยังทำงานอยู่เบื้องหลัง — ไม่ใช่โหมด "เบา" กว่าในแง่การใช้ token
- SSE เป็นการสื่อสารทางเดียว (server→client) เท่านั้น — ถ้าต้องการส่งคำสั่งกลับไป steer agent ระหว่างทาง ต้องมีช่องทางเพิ่มเติม (เช่น separate POST endpoint) ไม่ใช่ SSE เอง
- การ pipe stdout ข้าม CLI ต้องมั่นใจว่า output format ของฝั่งต้นทางตรงกับ input format ที่ปลายทางรับได้ — text เปล่าอาจพาข้อความ metadata ปนเข้าไปถ้าไม่ระบุ `--output-format` ให้ชัดเจน

## References

1. [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
2. [Subagents in the SDK - Claude Code Docs](https://platform.claude.com/docs/en/agent-sdk/subagents)
3. [Agent SDK overview / Headless mode - Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code/sdk/sdk-headless)
4. [Agent SDK overview - Claude Code Docs](https://code.claude.com/docs/en/agent-sdk/overview)
5. [Multiagent orchestration - Claude Platform Docs](https://platform.claude.com/docs/en/managed-agents/multiagent-orchestration)
6. [Async multi-agent orchestration - Claude Cookbook](https://platform.claude.com/cookbook/patterns-agents-async-multi-agent-orchestration)
7. [มาลองทำ AI Multi-agent Orchestration กันน (YouTube)](https://youtu.be/oYL0QL435Ag)

## Key Takeaways

- Sub-agent = กระจายงานภายในเซสชันเดียว, แต่ละตัวเริ่ม context ใหม่และคืนแค่บทสรุป
- Headless mode (`-p` flag) = รัน CLI แบบ non-interactive, ต่อกันข้าม CLI ด้วย stdin/stdout
- `stream-json` output format = เปิดทางให้ external system อ่านสถานะ execution แบบ incremental
- SSE = push สถานะ real-time ไปหน้าเว็บทางเดียว โดยไม่ต้อง poll ซ้ำ
- ประโยชน์หลัก: parallelization เพิ่มความเร็ว, แยก context กันชนขีดจำกัด token, และ task specialization ให้ผลลัพธ์แม่นยำ/ปลอดภัยกว่า
- ข้อจำกัด: subagent ไม่สืบทอด context เดิม, SSE สื่อสารทางเดียว, ต้อง match output/input format ให้ตรงกันเวลา pipe ข้าม CLI
