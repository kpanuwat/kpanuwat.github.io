---
title: "Matt Gray: สร้าง Business OS ด้วย Claude Code — เปลี่ยน Founder จาก Operator เป็น Architect"
date: 2026-05-31 06:43:00 +0700
categories: [Tools]
tags: [claude-code, business-os, founders, productivity, okr, ai-automation, hubspot, fathom, eos]
slides: true
---

{% include slide-link.html %}

## TL;DR

Matt Gray ใช้ Claude Code สร้าง Business Operating System ที่รวม OKRs, KPI Dashboard, Level 10 Meetings, และ Company Brain ไว้ในที่เดียว — เชื่อมต่อ HubSpot (CRM) และ Fathom (AI meeting notes) เพื่อให้ทีมทำงานสอดประสานโดยอัตโนมัติ ลดภาระ Founder จากการลงไปปฏิบัติการทุกขั้นตอน

## Background / Why this matters

Matt Gray เป็น Founder & CEO ของ [Founder OS](https://www.founderos.com/) — บริษัทที่ช่วย entrepreneur สร้างระบบธุรกิจที่ยั่งยืน เขามีพอร์ตโฟลิโอรายได้กว่า $13.8M ARR, สร้าง 4 บริษัทที่ประสบความสำเร็จ และมีชุมชนกว่า 14 ล้านคนทั่วโลก

ปัญหาที่ Founder ส่วนใหญ่เผชิญคือ **"Operator Trap"** — ผู้ก่อตั้งถูกดูดเข้าไปอยู่ใน day-to-day operations จนไม่มีเวลาคิด strategy ระยะยาว ทีมขาด alignment เพราะข้อมูล KPI กระจัดกระจายอยู่ใน tools หลายตัว ไม่มีศูนย์กลางที่ทุกคนเห็นภาพเดียวกัน

Claude Code ช่วยให้ Matt สร้างสิ่งที่เคยต้องใช้ทีม dev หลายคนหรืองบประมาณสูงมากในการ implement ได้ด้วยตัวคนเดียว โดยไม่ต้องเขียนโค้ดแบบ traditional

## Deep Dive

### จาก Operator สู่ Architect

Business OS ของ Matt ออกแบบมาเพื่อย้าย Founder จาก **Operator mode** (ลงไปทำทุกอย่างเอง) ไปสู่ **Architect mode** (ออกแบบระบบ, วาง strategy, ดู metrics แล้วตัดสินใจ)

แนวคิดหลัก: แทนที่ AI จะเป็นแค่ chatbot ตอบคำถาม → AI กลายเป็น **institutional memory** ที่รู้จัก business context ทั้งหมด ทั้ง company voice, KPI targets, team structure, meeting history

### สี่ Layer หลักของ Business OS

**1. Company Brain (Context Layer)**

ทุกอย่างเริ่มจากการ "สอน" Claude รู้จักธุรกิจ ผ่าน Claude Projects:

- Company mission, values, tone of voice
- Team structure และ accountability map
- Historical decisions และ rationale
- Customer persona และ ICP (Ideal Customer Profile)

เมื่อ context ถูก embed ไว้แล้ว ทุกคนในทีมที่ใช้ Project เดียวกันจะได้ AI ที่ "รู้จัก" บริษัท ไม่ต้องอธิบายซ้ำทุกครั้ง

**2. OKR & KPI Dashboard**

Matt ใช้ Claude Code สร้าง dashboard ที่ดึงข้อมูลจากหลาย sources:

- **HubSpot** → CRM data: deals, pipeline, conversion rates, customer lifecycle
- **Fathom** → AI-generated meeting summaries, action items, decisions
- ตัวชี้วัดหลัก (KPI) แสดงแบบ real-time ไม่ต้องรอ weekly report

OKRs (Objectives and Key Results) ถูก track อัตโนมัติ โดย AI สามารถ flag ได้ว่า metric ไหนกำลัง off-track ก่อนที่จะสาย

**3. Level 10 Meetings (Structured Cadence)**

Level 10 Meeting มาจาก EOS (Entrepreneurial Operating System) โดย Gino Wickman — การประชุมทีมรายสัปดาห์ที่มีโครงสร้างชัดเจน:

| ส่วน | เวลา | เนื้อหา |
|------|------|---------|
| Check-in | 5 นาที | rating สัปดาห์ 1-10 |
| Scorecard | 5 นาที | review KPI vs targets |
| Rock Review | 5 นาที | quarterly priorities progress |
| Headlines | 5 นาที | customer/employee news |
| To-do List | 5 นาที | carryover action items |
| IDS | 60 นาที | Identify/Discuss/Solve issues |
| Conclude | 5 นาที | rating การประชุม + cascade messages |

ใน Business OS ของ Matt, Fathom บันทึกและ transcribe ทุก meeting → Claude สรุป action items + decisions → ข้อมูลถูก sync เข้า dashboard อัตโนมัติ ทำให้ "issues" จาก IDS session ถูก track ต่อเนื่องข้ามสัปดาห์

**4. Automation Layer**

เชื่อมต่อ systems ด้วย Claude Code แทนที่จะใช้ Zapier หรือ Make ซึ่งมี limitations:

- HubSpot deal updates → trigger AI summary + Slack notification
- Fathom transcript → extract action items → assign ใน project management tool
- Weekly scorecard → auto-generated draft สำหรับ Level 10 prep

### Workflow จริงของ Founder

```
เช้าวันจันทร์:
1. เปิด Dashboard → เห็น KPI week-over-week ทันที
2. AI highlights issues ที่ต้อง attention (off-track metrics)
3. Level 10 agenda ถูก pre-populated จาก Fathom + Scorecard

ระหว่างสัปดาห์:
- Sales ปิด deal ใน HubSpot → CEO เห็นใน dashboard real-time
- Team meeting → Fathom records → Claude สรุป action items อัตโนมัติ

วันศุกร์:
- Weekly wrap-up report สร้างอัตโนมัติ
- Founder review แค่ decisions + exceptions ไม่ต้องรวบรวม data เอง
```

## Caveats / Limits

- **Claude Projects context limit**: บาง business context อาจต้องจัดการ chunking ถ้าเอกสาร company มีขนาดใหญ่มาก
- **HubSpot API permissions**: integration ต้องการ HubSpot Professional tier ขึ้นไปสำหรับ full API access
- **Fathom availability**: Fathom รองรับ video conferencing หลัก (Zoom, Google Meet, Teams) แต่อาจมี latency ในการ transcript
- **Maintenance overhead**: เมื่อ business เติบโต Company Brain context ต้องอัปเดตตาม — ถ้าไม่ maintain อาจ outdated
- **Not a replacement for judgment**: AI สรุป action items ได้ แต่การตัดสินใจเชิง strategy ยังต้องการ human context
- **Cost**: Claude API costs scale ตาม usage โดยเฉพาะถ้าทีมใหญ่ขึ้น

## References

1. [I built a complete "business operating system" using claude code — Matt Gray, YouTube](https://youtu.be/3Bfx4osqbfE)
2. [Founder OS — Matt Gray](https://www.founderos.com/)
3. [How I Built an AI Operating System with Claude Code (6 People, No Devs) — MeasureU](https://measureu.com/ai-operating-system/)
4. [Traction: Get a Grip on Your Business — Gino Wickman (EOS, Level 10 Meetings)](https://www.eosworldwide.com/traction-book)
5. [HubSpot CRM Platform](https://www.hubspot.com/)
6. [Fathom — AI Meeting Notetaker](https://fathom.video/)
7. [OKR Framework — Objectives and Key Results](https://www.whatmatters.com/faqs/okr-meaning-definition-example)

## Key Takeaways

- **Business OS = Claude Projects + integrations**: ไม่ใช่แค่ chatbot แต่คือระบบที่ AI รู้จักบริษัทของคุณทั้งหมด
- **Company Brain ทำให้ทีม aligned**: ทุกคนถามคำถามเดียวกันกับ AI ที่มี context เดียวกัน ลด miscommunication
- **HubSpot + Fathom = data flywheel**: CRM data + meeting intelligence ไหลเข้า AI อัตโนมัติ ไม่ต้องรวบรวมด้วยมือ
- **Level 10 structure + AI prep** ลดเวลาเตรียมประชุมจากชั่วโมงเป็นนาที
- **Founder เป็น Architect** เมื่อ exceptions ถูก flag โดย AI — ไม่ต้องไล่ดูทุก metric เอง
- **Claude Code ลด barrier**: สิ่งที่เคยต้องใช้ dev team หลายคน → สร้างได้คนเดียวใน days ไม่ใช่ months
- **Start small**: เริ่มจาก Company Brain + KPI dashboard ก่อน แล้วค่อย layer เพิ่ม automation
