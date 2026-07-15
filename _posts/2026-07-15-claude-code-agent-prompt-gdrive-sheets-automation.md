---
title: "Claude Code 2.1.198: ยกเลิก /agent เปลี่ยนมาสร้าง AI Agent ด้วย Prompt (Use Case: อ่านใบเสร็จ PDF จาก Google Drive ลง Sheets อัตโนมัติ)"
date: 2026-07-14 00:02:00 +0700
categories: [Tools]
tags: [claude-code, ai-agent, automation, google-apps-script, google-drive, google-sheets, no-code]
slides: true
---

{% include slide-link.html %}

## TL;DR

Claude Code เวอร์ชัน **2.1.198** (2 ก.ค. 2026) ถอด `/agents` wizard ออกอย่างเป็นทางการ [1][2] — วิธีสร้าง subagent ใหม่คือ**พิมพ์ prompt บอก Claude ตรงๆ** ให้ช่วยสร้างให้ ไฟล์ agent ที่ได้ยังเป็น Markdown + YAML frontmatter ใน `.claude/agents/` เหมือนเดิมทุกประการ [3] บทความนี้เจาะลึก use case จริงจากคลิปต้นทาง: สร้าง "expense subagent" ที่อ่านใบเสร็จ PDF จาก Google Drive แล้วกรอกลง Google Sheets อัตโนมัติ ผ่าน Google Drive Connector + Google Apps Script

## Background / Why this matters

`/agents` เคยเป็นคำสั่งเปิด wizard แบบ interactive ให้เลือก Library → Create new agent → Generate with Claude แล้วพิมพ์อธิบาย agent ที่ต้องการ [3][4]. ตั้งแต่ 2.1.198 เป็นต้นไป พิมพ์ `/agents` จะขึ้นข้อความแจ้งว่าคำสั่งถูก remove แล้ว พร้อมแนะนำให้ "ask Claude to create or manage subagents, or edit `.claude/agents/` directly" [1][2][4] — นี่ไม่ใช่การตัดฟีเจอร์ subagent ทิ้ง แค่เปลี่ยน UI จาก wizard เป็น conversational prompt เท่านั้น สถาปัตยกรรมเบื้องหลัง (ไฟล์ `.md` ที่มี YAML frontmatter เก็บ identifier, description, tool permissions, model, system prompt ใน `.claude/agents/` หรือ `~/.claude/agents/`) เหมือนเดิม 100% [3]

เรื่องนี้สำคัญเพราะ**คู่มือ/บทเรียนเก่าที่สอนกด `/agents`** จะใช้งานไม่ได้แล้วทันที (มี GitHub issue ยืนยันว่า docs quickstart ของทีม Anthropic เองก็ยังไม่ได้อัปเดตตามทัน) [4] — ใครก็อปวิธีสร้าง agent จากคลิป/บล็อกที่อ้างอิงเวอร์ชันเก่าต้องปรับ workflow ใหม่

## Deep Dive

### สิ่งที่เปลี่ยนจริงใน 2.1.198

- ถอด `/agents` interactive wizard ทิ้งทั้งหมด [1][2]
- แทนที่ด้วยการพิมพ์ prompt ตรงๆ เช่น "สร้าง sub agent ที่ ..." — ใช้ได้ทั้งภาษาไทยและอังกฤษ แต่ prompt ภาษาอังกฤษประหยัด token กว่า (ยืนยันจากคลิปต้นทาง ผู้ทำคลิปเลือกพิมพ์ไทยเพื่อความเข้าใจง่าย)
- Claude Code เฝ้าดู (watch) โฟลเดอร์ agent อยู่แล้ว ดังนั้น agent ที่สร้างผ่าน prompt หรือแก้ไฟล์ตรงๆ มีผลทันทีโดยไม่ต้อง restart session [3]
- release เดียวกันยังมีของอื่นที่ไม่เกี่ยวกับหัวข้อนี้ เช่น subagent รันเป็น background โดย default, Claude in Chrome GA, `/dataviz` skill ใหม่ [2] — ไม่ใช่โฟกัสของโพสต์นี้ ใส่ไว้เพื่อบริบทเวอร์ชันเท่านั้น

### วิธีสร้าง subagent แบบใหม่

แทนที่จะกด `/agents` ให้พิมพ์อธิบายสิ่งที่ต้องการตรงๆ เช่น "create a subagent that reads receipts and logs expenses" — Claude จะ generate ไฟล์ `.md` ให้เอง พร้อม identifier, description, tool permissions, model selection, และ system prompt ที่ปรับให้เหมาะกับงาน [3][5] แก้ไขภายหลังได้ด้วยการเปิดไฟล์ตรงๆ ใน `.claude/agents/<name>.md` เช่นกัน

### Deep-dive use case: อ่านใบเสร็จ PDF จาก Google Drive → กรอก Google Sheets อัตโนมัติ

โจทย์ในคลิป: มีโฟลเดอร์ Google Drive แยกตามเดือน เก็บใบเสร็จ/ใบแจ้งหนี้ค่าใช้จ่ายต่างๆ (เช่น Google Workspace, ค่า infra) ต้องการให้ agent อ่านทุกไฟล์ ดึงรายละเอียด แล้วกรอกลง Google Sheet ตามคอลัมน์ที่กำหนด (เดือน, section/ประเภทค่าใช้จ่าย, รายละเอียด, จำนวนเงิน, vendor, วันที่จ่าย) [5]

ขั้นตอนที่เกิดขึ้นจริง:

1. **Prompt สร้าง agent** — ผู้ใช้พิมพ์อธิบายตรงๆ ว่าต้องการ "expense subagent" ที่อ่านใบเสร็จแล้วบันทึกลง Sheet พร้อมวางลิงก์โฟลเดอร์ Google Drive และลิงก์ Google Sheet เข้าไปใน prompt เลย (ต้องเชื่อม **Google Drive Connector** ไว้ล่วงหน้าก่อน) [5]
2. **Claude ถามกลับเรื่องสิทธิ์เขียนไฟล์** — Google Drive Connector ของ Claude อ่านไฟล์ได้ (และตามเอกสารทางการคือ **read-only**, ไม่รองรับ create/edit/move ไฟล์เดิม) [6][7] แต่ในดีโม agent แจ้งว่า connector สร้างไฟล์ใหม่ได้ เพียงแต่**แก้ไขไฟล์ Sheet ที่มีอยู่แล้วไม่ได้** จึงเสนอ 3 ทางเลือก: (a) ใช้ Google Apps Script เขียนเข้า Sheet เดิมได้ตรงๆ, (b) agent สรุปผลเป็น CSV ให้ผู้ใช้ copy เอง, (c) ให้ connector สร้างไฟล์ Sheet ใหม่ทุกครั้งที่เรียก agent [5]
3. **เลือก Apps Script** — ทางเลือกที่ดีที่สุดสำหรับใช้งานต่อเนื่อง คือ (a) แม้ต้อง setup เพิ่มหน่อย [5]
4. **ติดตั้ง Apps Script** — Claude ให้ขั้นตอน step-by-step (1-2-3-4) วิธีวาง script ลงใน Google Sheet ของผู้ใช้เอง จากนั้นขอ 2 อย่างกลับมา: **Web App URL** กับ **Secret Token** ของ Apps Script deployment [5]
5. **ทดสอบการเชื่อมต่อ** — agent เขียนแถวชื่อ "Test" ลง Sheet เพื่อยืนยันว่าเขียนได้จริง ผู้ใช้ลบแถวทดสอบทิ้งก่อนใช้งานจริง [5]
6. **เรียกใช้งาน agent** — เรียกด้วย `@` ตามด้วยชื่อ agent (เช่น `@expense`) เหมือนวิธีเดิมก่อนมี `/agents` — ส่วนนี้ไม่เปลี่ยน [5]

### Human-in-the-loop: agent หยุดถามเมื่อเจอ edge case

ในดีโม สั่งให้ agent บันทึกใบเสร็จทั้งปีทีเดียว (21 รายการ) — ผลลัพธ์: บันทึกสำเร็จ 17 รายการ, ล้มเหลว 4 รายการ พร้อมเหตุผล เช่น สลิปโอนเงินที่ไม่ระบุว่าจ่ายค่าอะไร หรือใบเสร็จสกุลเงิน USD ที่แปลงเป็น THB ไม่ได้อัตโนมัติ agent เสนอทางแก้ 2 แบบ: ข้ามรายการนั้นไปก่อน หรือให้ผู้ใช้ระบุอัตราแลกเปลี่ยนเอง [5] — นี่คือรูปแบบที่ดีของ agent ที่ไม่ hallucinate ข้อมูลการเงินเอง แต่หยุดถามเมื่อข้อมูลไม่พอ

### Agent ปรับปรุงความสามารถของตัวเอง (self-updating)

จุดที่น่าสนใจที่สุดของคลิป: ผู้ใช้ลากไฟล์ PDF ใบเสร็จที่ยังไม่ได้อัปโหลดขึ้น Google Drive มาวางใน terminal ตรงๆ แล้วเรียก `@expense` โดยไม่อธิบายอะไรเพิ่ม Claude Code สังเกตว่านี่เป็น input ประเภทใหม่ (ไฟล์ local ผ่าน terminal ไม่ใช่ Google Drive) จึง**แก้ไฟล์ config ของ agent เอง** (`expense.md`) เพื่อเพิ่มความสามารถ "อ่านไฟล์ที่ผู้ใช้แนบเข้ามาโดยตรง" ก่อน แล้วค่อยกลับมาทำงานที่ขอต่อ [5] — แสดงว่า subagent ที่สร้างด้วย prompt สามารถถูก "จูน" หรือขยายความสามารถได้ทั้งจาก feedback ตรงๆ ของผู้ใช้ และจากการที่ agent เจอ pattern งานใหม่แล้วปรับตัวเอง

## User Guide (Step-by-Step)

1. **เช็กเวอร์ชัน** — รัน `claude --version` ยืนยันว่า ≥ 2.1.198 ถ้าพิมพ์ `/agents` แล้วขึ้นข้อความ removed แปลว่าอัปเดตแล้ว [1][2]
2. **เชื่อม Google Drive Connector ล่วงหน้า** — ต้องทำก่อนสร้าง agent เพราะ agent จะอ้างอิงสิทธิ์นี้ตอนอ่านไฟล์ (วิธีเชื่อม connector อยู่นอกขอบเขตโพสต์นี้ ดูเอกสารทางการ [6])
3. **Prompt สร้าง agent** — ตัวอย่าง prompt (ปรับได้ทั้งไทย/อังกฤษ):
   > "สร้าง sub agent ชื่อ expense ที่อ่านใบเสร็จ/ใบแจ้งหนี้จากโฟลเดอร์ Google Drive นี้ [ลิงก์] ดึงข้อมูล เดือน, section, รายละเอียด, จำนวนเงิน, vendor, วันที่จ่าย แล้วบันทึกลง Google Sheet นี้ [ลิงก์] ตามคอลัมน์ที่มีอยู่แล้ว"
4. **ตอบคำถามเรื่องวิธีเขียน Sheet** — เมื่อ Claude ถามว่าจะเขียนข้อมูลกลับ Sheet เดิมยังไง เลือก Apps Script ถ้าต้องการใช้งานซ้ำแบบ append เข้า Sheet เดิมได้เรื่อยๆ
5. **Deploy Apps Script ตามขั้นตอนที่ Claude ให้มา** แล้วส่ง Web App URL + Secret Token กลับเข้าไปในแชท — **เก็บ Token นี้เป็นความลับ อย่า commit เข้า git หรือแชร์สาธารณะ**
6. **ตรวจแถว Test** — เปิด Sheet เช็กว่ามีแถว "Test" เพิ่มมาจริง แล้วลบทิ้งก่อนใช้งานจริง
7. **เรียกใช้งานประจำวัน** — พิมพ์ `@expense บันทึกใบเสร็จเดือน 6` หรือสั่งบันทึกทั้งปีทีเดียวก็ได้
8. **จัดการ error** — เมื่อ agent รายงานรายการที่บันทึกไม่ได้ ให้ตอบคำถามที่ agent ถามกลับ (ข้าม หรือ ให้ข้อมูลเพิ่ม เช่น อัตราแลกเปลี่ยน)
9. **ป้อนไฟล์ local ได้เลย** — ถ้ามีใบเสร็จที่ยังไม่ได้อัปโหลดขึ้น Drive ลากไฟล์ PDF วางใน terminal แล้วเรียก `@expense` ตรงๆ ได้ agent จะปรับ config ตัวเองให้รองรับ

## Caveats / Limits

- **Connector เป็น read-only ตามเอกสารทางการ** — Google Workspace connector ของ Claude ระบุชัดว่าอ่านได้อย่างเดียว ไม่รองรับ create/edit/move/rename ไฟล์ [6][7] ส่วนพฤติกรรม "สร้างไฟล์ใหม่ได้แต่แก้ไฟล์เดิมไม่ได้" ที่เห็นในคลิปเป็นการสังเกตจากการใช้งานจริงของผู้ทำคลิป ไม่ใช่ spec ที่ยืนยันในเอกสาร — พฤติกรรมอาจต่างกันตามเวอร์ชัน/สภาพแวดล้อม ควรทดสอบเองก่อนพึ่งพา
- **แปลงสกุลเงินไม่อัตโนมัติ** — รายการที่เป็น USD หรือสกุลอื่นที่ไม่ใช่ THB จะถูกข้ามหรือต้องผู้ใช้ระบุอัตราแลกเปลี่ยนเอง ไม่มีการเดาอัตราแลกเปลี่ยนจาก agent
- **Secret Token ของ Apps Script คือกุญแจเข้าถึง Sheet** — ถือเป็นความลับระดับเดียวกับ API key รั่วไหลแล้วมีคนเขียนข้อมูลปลอมลง Sheet ได้
- **ข้อมูลผ่าน connector ถูกส่งไปประมวลผลบนเซิร์ฟเวอร์ Anthropic** — ตามเอกสารทางการ ไม่ใช้เทรนโมเดล แต่ข้อมูลใบเสร็จ/รายจ่ายก็ยังผ่านเซิร์ฟเวอร์ภายนอกอยู่ดี ถ้ามีข้อมูลอ่อนไหวควรพิจารณาก่อนเชื่อม [6]
- **docs บางหน้าของ Anthropic เองยังไม่อัปเดตตาม 2.1.198** — มี GitHub issue เปิดอยู่ว่า sub-agents quickstart ยังสอนวิธี `/agents` แบบเก่า [4] อย่าแปลกใจถ้าเจอ doc ที่ขัดแย้งกับพฤติกรรมจริง
- **Prompt ภาษาไทยใช้ token มากกว่าอังกฤษ** — ถ้าต้องสร้าง agent บ่อยๆ หรือ cost-sensitive ควรพิจารณาพิมพ์ prompt เป็นอังกฤษแทน

## References

1. [Claude Code changelog — Claude Code Docs](https://code.claude.com/docs/en/changelog)
2. [Claude Code v2.1.198 Release Notes - 33 Changes — Claude Updates](https://www.claudeupdates.dev/version/2.1.198)
3. [Create custom subagents — Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
4. [[DOCS] Sub-agents quickstart still walks through the `/agents` wizard that v2.1.198 removed — GitHub Issue #72945](https://github.com/anthropics/claude-code/issues/72945)
5. [สร้าง AI Agent ใน Claude Code ด้วย Prompt | อ่าน PDF บน GDrive แจกแจงลง Google Sheets อัตโนมัติ — YouTube](https://youtu.be/he8SHkHHrGw) (แหล่งต้นทางของ use case ทั้งหมดในโพสต์นี้)
6. [Use Google Workspace connectors — Claude Help Center](https://support.claude.com/en/articles/10166901-use-google-workspace-connectors)
7. [Google Drive Connector — Claude by Anthropic](https://claude.com/connectors/google-drive)
8. [claude-code/CHANGELOG.md — GitHub anthropics/claude-code](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)

## Key Takeaways

- Claude Code 2.1.198 (2 ก.ค. 2026) ถอด `/agents` wizard ทิ้ง — สร้าง subagent ใหม่ต้อง **prompt ตรงๆ** หรือแก้ไฟล์ `.claude/agents/*.md` เอง สถาปัตยกรรมไฟล์ไม่เปลี่ยน
- Use case จริง: "expense subagent" อ่านใบเสร็จ PDF จาก Google Drive → กรอก Google Sheets อัตโนมัติ ผ่าน Google Drive Connector + Google Apps Script (เพราะ connector อ่านได้แต่แก้ไฟล์เดิมไม่ได้)
- Agent ที่ดีควร**หยุดถามเมื่อข้อมูลไม่พอ** (สกุลเงินแปลงไม่ได้, สลิปไม่ระบุรายละเอียด) แทนที่จะเดาข้อมูลการเงินเอง
- Subagent แบบใหม่ปรับปรุง/ขยายความสามารถตัวเองได้ (เช่น เพิ่มการรองรับไฟล์ local) จากทั้ง feedback ของผู้ใช้และการเจอ pattern งานใหม่
- Secret Token ของ Apps Script ต้องเก็บเป็นความลับเหมือน API key
- Prompt ภาษาอังกฤษประหยัด token กว่าภาษาไทยสำหรับงานสร้าง agent ซ้ำๆ
- เอกสารทางการบางหน้าของ Anthropic ยังไม่อัปเดตตาม 2.1.198 — ระวังเจอ doc เก่าที่สอน `/agents` แบบ wizard
