---
title: "เจาะลึก ISO 56001:2024 EP5 — Clauses 7-8: Support, Knowledge และ Innovation Operations"
date: 2026-05-24 00:06:00 +0700
categories: [Engineering]
tags: [iso56001, innovation-management, operations, knowledge-management, support, idea-to-launch, ims]
series: iso56001-2024
slides: false
---

{% include series-nav.html %}

## TL;DR

Clauses 7-8 คือ "เครื่องยนต์" ของ IMS — Clause 7 วางรากฐาน (คน, ความรู้, สื่อสาร) ส่วน Clause 8 กำหนดกระบวนการ idea-to-launch ที่ยืดหยุ่นพอสำหรับทุก type ของ innovation ทั้ง incremental และ transformational Clause 8 เป็น Clause ที่ไม่ prescriptive ที่สุดใน standard — องค์กรต้องออกแบบ process เอง แต่ต้องครอบ 5 ขั้นตอนหลัก

## Background / Why this matters

ถ้า Clauses 4-6 คือ "วาง blueprint" Clauses 7-8 คือ "build and operate the machine" — ความล้มเหลวส่วนใหญ่ของ IMS implementation เกิดที่นี่ เพราะองค์กรมักมี strategy ที่ดีแต่ไม่มี operational process ที่รองรับ [1][2]

Clause 7 แก้ปัญหา **enablers** — ทรัพยากร, ทักษะ, ความรู้ที่จำเป็น ส่วน Clause 8 แก้ปัญหา **execution** — กระบวนการที่ทำให้ idea กลายเป็น deployed solution จริงๆ ไม่ใช่แค่ pilot ที่ถูกลืม [1][3][4]

## Deep Dive

### Clause 7 — Support

**7.1 Resources**
องค์กรต้องกำหนดและจัดหาทรัพยากรที่จำเป็น:
- บุคคล (คนที่มีเวลาและทักษะ ไม่ใช่แค่ "เพิ่มงานให้")
- โครงสร้างพื้นฐาน (lab, maker space, ซอฟต์แวร์ prototype)
- สภาพแวดล้อม (physical space + psychological safety)
- ความรู้ (organizational knowledge — ดูข้อ 7.6)

**7.2 Competence**
ระบุ competencies ที่จำเป็นสำหรับแต่ละ role ใน IMS:
- Innovation methodology (Design Thinking, Lean Startup, TRIZ)
- Domain expertise (technology, market, customer)
- Facilitation skills
- Commercial/business model thinking

**7.3 Awareness**
ทุกคนในองค์กรต้องเข้าใจ:
- Innovation policy และเป้าหมาย
- บทบาทของตัวเองในกระบวนการ
- ผลที่ตามมาเมื่อ IMS ไม่ได้ผล

**7.4 Communication**
กำหนด communication plan สำหรับ innovation:
- ใครสื่อสารอะไร กับใคร เมื่อไหร่ ผ่านช่องทางไหน
- Innovation successes ถูก celebrate และแชร์อย่างไร
- Ideas ถูก received และ acknowledged อย่างไร

**7.5 Documented Information**
กำหนดเอกสารที่จำเป็น:
- Innovation process descriptions
- Decision records ที่ stage gates
- Lessons learned จาก initiatives ที่ success และ fail

### Clause 7.6 — Knowledge Management

นี่คือส่วนที่หลายองค์กรมองข้าม แต่สำคัญมากสำหรับ innovation:

**ประเภท Knowledge ที่ IMS ต้องจัดการ:**

| ประเภท | ตัวอย่าง | วิธีจัดการ |
|---|---|---|
| **Explicit knowledge** | เอกสาร, patents, methodology | Knowledge base, wiki |
| **Tacit knowledge** | ประสบการณ์ทีม, เทคนิคเฉพาะ | Communities of practice, mentoring |
| **Market knowledge** | customer insights, trend analysis | Research reports, customer interviews |
| **Technology knowledge** | emerging tech landscape | Tech radar, R&D partnerships |

**Knowledge Reuse Problem:**
หนึ่งในเหตุผลที่ SI company "reinvent the wheel" บ่อยคือ tacit knowledge อยู่ในหัวคนเดิมๆ ไม่ถูก capture — Clause 7.6 กำหนดให้มีระบบ capture, protect, share และ evaluate organizational knowledge [2][3]

### Clause 8 — Operation

Clause 8 เป็น heart ของ IMS ในระดับ operational — กำหนดว่าองค์กรจะ **ขับ innovation initiatives** จาก idea ถึง market อย่างไร

**8.1 Operational Planning and Control**
กระบวนการต้องออกแบบมาให้:
- **ยืดหยุ่น** — แต่ละ initiative มี context ต่างกัน
- **ควบคุมได้** — มี governance ชัดเจน
- **เชื่อมกับ portfolio** — decisions ระดับ initiative ส่งผลต่อ portfolio ได้

### กระบวนการ Innovation: 5 ขั้นตอนหลักตาม Clause 8

```
Stage 1: Opportunity Identification & Definition
─────────────────────────────────────────────────
INPUT:  Strategic intent, market signals, customer insights
TOOLS:  PESTLE, Jobs-to-be-Done, Technology radar
OUTPUT: Validated opportunity brief (problem statement + hypothesis)

         ↓ Gate: Is this opportunity worth pursuing?

Stage 2: Concept Creation & Development  
─────────────────────────────────────────────────
INPUT:  Opportunity brief
TOOLS:  Design Thinking ideation, TRIZ, brainstorming
OUTPUT: 3-5 concept alternatives with preliminary business case

         ↓ Gate: Which concept(s) to validate?

Stage 3: Concept Validation
─────────────────────────────────────────────────
INPUT:  Selected concept(s)
TOOLS:  Lean Startup (MVP), user testing, technical PoC
OUTPUT: Validated assumptions (or pivoted concept)

         ↓ Gate: Is this concept technically + commercially viable?

Stage 4: Development & Scaling
─────────────────────────────────────────────────
INPUT:  Validated concept
TOOLS:  Agile/Scrum, pilot programs, market testing
OUTPUT: Deployable solution with proven unit economics

         ↓ Gate: Ready to launch?

Stage 5: Deployment
─────────────────────────────────────────────────
INPUT:  Developed solution
TOOLS:  Launch playbook, change management, training
OUTPUT: Launched innovation + value realization tracking
```

### Tools ที่นิยมใช้แต่ละ Stage

| Stage | Tools |
|---|---|
| Opportunity | Jobs-to-be-Done, PESTLE, Voice of Customer, Technology Watch |
| Concept | Design Thinking, Brainstorming, SCAMPER, Business Model Canvas |
| Validation | MVP, A/B Testing, User Interviews, Technical PoC |
| Development | Agile/Scrum, SAFe (large org), Kanban, CI/CD |
| Deployment | Change Management, Training Plan, KPI dashboards |

ISO 56001 **ไม่ได้บังคับ tools** — บังคับแค่ว่า 5 stages ต้องมีอยู่ใน design [1][2]

### Clause 8 กับงาน Project-Based (SI Context)

สำหรับ SI company Clause 8 มีความยืดหยุ่นที่สำคัญ:
- **Innovation ใน project scope** ทำได้ภายใน Stage Gate ของ client project โดยใช้ "innovation sandbox" ที่ตกลงกับลูกค้า
- **Cross-project innovation** ทำแยกเป็น internal program ที่ไม่ขึ้นกับ client project timeline
- **PoC จาก client project** สามารถ productize เป็น reusable solution ผ่าน Clause 8 process ปกติ [1][3]

## Caveats / Limits

- **Clause 8 ไม่ prescriptive** — ถ้าองค์กรไม่มี methodology พื้นฐานก่อน การ implement Clause 8 จะยาก
- **Stage Gates อาจกลายเป็น bureaucracy** — ถ้ามี gates มากเกินไปหรือ criteria ไม่ clear จะ slow down innovation
- **Knowledge management ต้องมี champion** — ถ้าไม่มีคนรับผิดชอบ knowledge จะไม่ถูก capture
- **Clause 7.6 (Knowledge) มักถูกมองว่า "document work"** — ควรออกแบบให้ capture เป็น natural part of workflow ไม่ใช่ extra burden

## References

1. HYPE Innovation. "ISO 56001: The Ultimate Guide." https://www.hypeinnovation.com/iso-56001-ultimate-guide
2. ITONICS. "ISO 56001 Innovation Management Guide." https://www.itonics-innovation.com/blog/iso-56001
3. Reins Agency. "ISO 56001 Consulting." https://reinsagcy.com/en/iso-56001-consulting-how-to-build-an-innovation-system-that-enhances-your-companys-competitiveness/
4. DNV. "ISO 56001 Certification." https://www.dnv.com/services/iso-56001-innovation-management-system/

## Key Takeaways

- Clause 7 วาง enablers: คน, ทักษะ, ความรู้, สื่อสาร — ถ้า enablers ไม่พร้อม Clause 8 จะ fail
- Clause 7.6 Knowledge Management คือกลไกหยุด "reinventing the wheel" — สำคัญมากสำหรับ SI
- Clause 8 กำหนด 5 stages หลัก: Opportunity → Concept → Validate → Develop → Deploy
- Standard ไม่บังคับ tools — บังคับว่า 5 stages ต้องมีใน design ขององค์กร
- Stage Gates คือ decision points ไม่ใช่ bureaucracy checkboxes — criteria ต้องชัด simple
- Innovation process ต้องยืดหยุ่น — ปรับ pace และ depth ได้ตาม complexity ของแต่ละ initiative
