---
title: "5 ทริคที่ขอ AI สร้างเป็น HTML file แทน MD file ได้เลย"
date: 2026-05-30 06:32:00 +0700
categories: [Tools]
tags: [ai, html, prompt-engineering, productivity, workflow]
slides: true
---

{% include slide-link.html %}

## TL;DR

Markdown เหมาะกับ prose แต่ HTML เหมาะกับ interactive artifacts — diagram, color-coded report, side-by-side comparison, drag tool, หรือ explainer ที่มี JS/CSS ซ่อนอยู่ บทความนี้รวม 5 use case ที่ขอ AI ให้ output เป็น `.html` แทน `.md` แล้วได้ผลลัพธ์ที่ดีกว่ามาก

---

## Background / Why this matters

ส่วนใหญ่เราสั่ง AI ให้ draft เนื้อหาเป็น Markdown เพราะอ่านง่าย, commit ง่าย, render บน GitHub/Notion ได้เลย แต่มีบางสถานการณ์ที่ Markdown ทำได้แค่ "plain text + headers" ในขณะที่ HTML ให้ CSS layout, JavaScript interactivity, และ SVG graphics ได้ในไฟล์เดียว

ข้อดีของ single-file HTML:
- เปิดได้เลยใน browser ไม่ต้องมี server
- แชร์ได้ทันทีด้วย Slack/email attachment
- ไม่ต้องพึ่ง Notion, Confluence, หรือ CMS ใดๆ
- AI ที่ดี (Claude, GPT-4o, Gemini) เขียน self-contained HTML ได้เก่งมาก

---

## Deep Dive

### 1. Spec / Plan งาน — มี Diagram

เมื่อต้องการ **system architecture diagram**, **flowchart**, หรือ **Gantt-style timeline** ที่ต้องการ visual layout ชัดเจน การขอ Markdown จะได้แค่ ASCII art หรือ Mermaid code block (ต้อง render แยก) แต่ถ้าขอ HTML จะได้ SVG หรือ inline Mermaid ที่ render ได้เลย

**Prompt ตัวอย่าง:**
```
สร้าง HTML file เดียวสำหรับ spec ระบบ user authentication
- มี SVG diagram แสดง flow: login → JWT → refresh
- มี section: Overview, API Endpoints, Error Codes, Security Notes
- ใช้ dark theme, monospace font
- self-contained (ไม่มี external CSS/JS ที่ต้อง fetch)
```

สิ่งที่ได้คือ `.html` ที่เปิดได้เลย มี diagram + prose ในหน้าเดียว ส่งให้ทีมทาง chat ได้ทันที

---

### 2. Report สรุปประชุม — แยกสีตามคน

Meeting notes ใน Markdown ดูยากเมื่อมีหลายคนพูด HTML ให้ CSS `color`, `badge`, หรือ `border-left` แยกสีต่อคนได้ ทำให้ scan ว่า "ใครบอกอะไร" เร็วมาก

**Prompt ตัวอย่าง:**
```
แปล meeting transcript นี้เป็น HTML report:
- แต่ละคนมีสีประจำตัว (Alice=blue, Bob=orange, Carol=green)
- action items ไฮไลต์เป็น yellow box
- decisions มี bold border-left สีแดง
- มี summary section ด้านบน
[วาง transcript ที่นี่]
```

**Output pattern ที่ AI มักสร้าง:**
```html
<div class="speaker alice">
  <span class="name">Alice</span>
  <p>เราต้อง ship ก่อน deadline 15 มิ.ย.</p>
</div>
<div class="action-item">✅ Bob: ส่ง PR ภายใน EOD พฤหัส</div>
```

---

### 3. เปรียบเทียบ 4 ไอเดีย — ในไฟล์เดียว

ถ้าต้องตัดสินใจระหว่าง 4 ตัวเลือก (framework, vendor, approach) Markdown ได้แค่ table ที่ wrap เป็น text แต่ HTML ทำ **responsive grid**, **tab-switch**, หรือ **radar chart** ได้

**Prompt ตัวอย่าง:**
```
สร้าง HTML comparison page สำหรับ 4 ตัวเลือก database: Postgres, MongoDB, SQLite, DynamoDB
- criteria: cost, scalability, query flexibility, local dev ease, managed option
- มี toggle ระหว่าง "Table view" กับ "Card view"
- ไฮไลต์ winner ในแต่ละ criteria
- มี recommendation section ด้านล่าง
```

**เทคนิค:** บอก criteria ให้ครบก่อน แล้วให้ AI ให้คะแนน 1-5 ต่อ criterion — ง่ายกว่าให้ AI ตัดสินเองทั้งหมด

---

### 4. Mini-Tool — ลากการ์ดจัด Priority

นี่คือ use case ที่ Markdown ทำไม่ได้เลย: **drag-and-drop Kanban** หรือ **priority sorter** ที่ใช้ HTML5 Drag API + vanilla JS

**Prompt ตัวอย่าง:**
```
สร้าง HTML priority board:
- 3 columns: Must Do, Should Do, Nice to Have
- มี pre-populated tasks: [รายการ 10 items]
- drag card ระหว่าง column ได้
- คลิก card เพื่อ edit text ได้ inline
- ปุ่ม Export JSON ที่ copy รายการปัจจุบันไป clipboard
- self-contained (ไม่ใช้ library ภายนอก)
```

Self-contained constraint สำคัญมาก — ถ้าไม่บอก AI มักจะ import React/Vue จาก CDN ซึ่งต้องการ internet

---

### 5. Explainer — อธิบายเรื่องยากๆ

เมื่อต้องการ **step-by-step visual walkthrough** ของ concept ที่ซับซ้อน เช่น TCP handshake, JWT decode flow, หรือ async/await execution — HTML ให้ collapsible sections, animated SVG, หรือ step-highlight ได้

**Prompt ตัวอย่าง:**
```
สร้าง HTML explainer สำหรับ "How JWT works"
- section: Header, Payload, Signature
- มี interactive decoder: ใส่ JWT token แล้วแสดง decoded parts แบบ color-coded
- มี step diagram: สร้าง token → ส่ง → verify
- ภาษาไทย + English mixed สำหรับ technical terms
- self-contained
```

Pattern นี้ดีสำหรับ onboarding doc ที่ต้องส่งให้คนที่ไม่ familiar กับ code

---

## Caveats / Limits

- **ขนาดไฟล์**: HTML ที่มี inline SVG + CSS + JS ได้ง่ายๆ 30-100KB — ถ้า share ทาง email ควรระวัง attachment size limit
- **Browser security**: HTML ที่ใช้ `fetch()` หรือ `localStorage` อาจถูกบล็อกถ้าเปิดจาก `file://` — ให้ใช้ `python3 -m http.server` แทน
- **AI token limit**: HTML ที่ซับซ้อนมาก (>500 บรรทัด) อาจถูกตัด — บอก AI ให้ทำ minimal version ก่อน แล้ว iterate
- **Maintenance**: HTML ไม่ได้ version ใน git อย่าง readable เหมือน Markdown — ถ้า content เปลี่ยนบ่อย ให้ generate ใหม่แทนการ edit มือ
- **Self-contained constraint**: บอกทุกครั้งว่า "no external CDN, no fetch" ไม่งั้น AI จะ import libs ที่ต้องการ internet ทำให้ file ใช้ offline ไม่ได้

---

## References

1. [HTML5 Drag and Drop API — MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/HTML_Drag_and_Drop_API)
2. [SVG Tutorial — MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial)
3. [Mermaid — Diagramming and charting tool](https://mermaid.js.org/)

---

## Key Takeaways

- Markdown = prose; HTML = interactive artifact — เลือกตาม output ที่ต้องการ
- Self-contained HTML (no external deps) เปิดได้เลย offline, share ได้ทันที
- 5 use case หลัก: diagram spec, color-coded meeting report, idea comparison, drag-tool, interactive explainer
- บอก AI ว่า "self-contained, no CDN" ทุกครั้ง มิฉะนั้น AI จะ import library
- Generate ใหม่ง่ายกว่า edit HTML มือ — ใช้ AI เป็น generator ไม่ใช่ editor
