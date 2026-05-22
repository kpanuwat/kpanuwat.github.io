---
title: "Lean Document Set สำหรับ Product Development ในงาน SI/Tech: ครบแต่ไม่หนัก"
date: 2026-05-22 00:24:00 +0700
categories: [Engineering]
tags: [lean-documentation, product-development, system-integrator, si, prd, bom, sow, phase-gate, evt-dvt-pvt, sat-uat, design-review, change-control, project-management]
series: project-management-si
slides: true
---

{% include series-nav.html %}

## TL;DR

เอกสารที่ดีในงาน SI/Tech ไม่ใช่เอกสารที่ครบที่สุด แต่คือเอกสารที่ "ใช้ตัดสินใจ, ควบคุมความเสี่ยง, และตรวจสอบย้อนกลับได้จริง" บทความนี้แมป document set ทั้ง 9 ช่วง ตั้งแต่ Idea/Discovery จนถึง Commercial & Post-deployment — แต่ละ phase มีเฉพาะเอกสารที่ "unblock gate ถัดไป" เท่านั้น ไม่มี overhead ที่ไม่มีคนอ่าน

## Background / Why this matters

ใน SI/Tech project ความเสี่ยงใหญ่สุดไม่ใช่การเขียนโค้ดผิด แต่คือ **ไม่รู้ว่าตกลงกันไว้ว่าอะไร** — ลูกค้าคิดว่าครอบคลุม Wi-Fi, ทีม engineer คิดว่าไม่รวม, PM ไม่รู้ว่าใครถูก ปัญหานี้เกิดเมื่อเอกสารสำคัญหายไปในช่วง pre-sales หรือ kick-off

แต่อีกขั้วหนึ่งคือ "เอกสารหนักจนไม่มีใครอัปเดต" — Design Spec 80 หน้าที่ version 1.0 ถูก sign-off แล้วไม่มีใครแตะอีก ทั้งที่ hardware เปลี่ยนไป 3 รอบแล้ว เอกสารแบบนั้นอันตรายกว่าการไม่มีเอกสารเพราะมันให้ความมั่นใจปลอม

**Lean document set** แก้ทั้งสองปัญหาด้วยหลักการเดียว: คงเฉพาะเอกสารที่มี **decision owner** ที่จะอ่านและ act บนมันจริง — ถ้าไม่มีใครใช้ ไม่ต้องมี

## Deep Dive

### Phase 1: Idea / Discovery

เป้าหมายของ phase นี้คือ **ยืนยันว่า "ปัญหาจริง และแก้ได้คุ้มทุน"** ก่อนลงทุนเวลาทีม

| เอกสาร | ความยาวเป้าหมาย | ใช้ตัดสินใจอะไร |
|--------|----------------|-----------------|
| **Problem Statement** | 1 หน้า | ยืนยันว่าปัญหามีอยู่จริงและ scope ชัด |
| **PRD Lite** | 1–2 หน้า | กำหนด "done" คืออะไร ก่อนลงมือออกแบบ |
| **Feasibility Note** | ½–1 หน้า | ตัดสินใจว่า Go / No-Go ก่อนใช้เวลา pre-sales |

**Problem Statement** ที่ดีตอบ 4 คำถาม: ปัญหาคืออะไร? ใครมีปัญหา? เรารู้ได้อย่างไรว่ามันจริง? ทำไมต้องแก้ตอนนี้?

**PRD Lite** แตกต่างจาก PRD เต็มตรงที่มุ่งไปที่ user story + acceptance criteria + MVP scope เท่านั้น ไม่มี wireframe, ไม่มี backlog — เพราะมันเขียนก่อนที่จะรู้ว่าจะ win deal

**Feasibility Note** ครอบคลุม 3 มิติ: Technical feasibility (ทำได้ด้วย tech ปัจจุบันไหม?), Commercial feasibility (margin เพียงพอไหม?), Timeline feasibility (ส่งได้ตามที่ลูกค้าต้องการไหม?) — output คือ Go/No-Go พร้อม assumption ที่ยืนยันแล้ว

---

### Phase 2: Pre-sales

เป้าหมาย: **ให้ลูกค้าตัดสินใจซื้อได้โดยมีข้อมูลครบ** — ไม่ใช่เพื่อ impress แต่เพื่อป้องกัน surprise หลัง sign

| เอกสาร | ผู้ใช้หลัก | สิ่งที่ unblock |
|--------|-----------|----------------|
| **Solution Proposal** | CTO / Decision maker | ยืนยัน fit ระหว่าง solution กับ problem |
| **High-level Architecture** | Technical evaluator | ยืนยัน feasibility ระดับ system |
| **Rough BoM** | Procurement / Finance | ยืนยัน budget range ก่อน formal quote |
| **Quotation / SOW** | Legal / Finance | กำหนด scope, deliverable, exclusion อย่างชัดเจน |
| **Risk & Assumption Log** | PM / Sponsor | ระบุ risk ที่ทั้งสองฝ่ายรับรู้ก่อน PO |

**SOW (Statement of Work)** คือเอกสารที่สำคัญที่สุดของ pre-sales — ไม่ใช่ quotation ต้องระบุ deliverable ที่ "วัดได้" (เช่น "system response < 2s under 100 concurrent users" ไม่ใช่ "fast response"), customer responsibility (access, credentials, network), และ **exclusion** ที่ชัดเจนเพื่อป้องกัน scope creep

**Risk & Assumption Log** เป็นสิ่งที่หลายทีมมองข้าม แต่ควรเป็น **living document** ตั้งแต่ pre-sales เพราะ assumption ที่ไม่ถูก document มักกลายเป็น "เราคิดว่า X, แต่จริง ๆ คือ Y" ในช่วง execution

---

### Phase 3: Kick-off (หลัง PO)

เป้าหมาย: **แปลง commercial agreement เป็น execution plan** ที่ทุกคนในทีมและลูกค้า aligned

| เอกสาร | ความยาว | สิ่งที่กำหนด |
|--------|--------|-------------|
| **Project Charter** | 2–4 หน้า | scope, objectives, RACI, budget, escalation path |
| **Integrated Plan** | ตาราง milestone | phase-gate dates + invoice schedule |

**Project Charter** ในบริบท SI แตกต่างจาก PMBOK เล็กน้อย — ต้องเพิ่ม **commercial milestones** เช่น "Pilot Acceptance = 40% payment" ลงไปใน charter เพราะ PM ต้องบริหาร cashflow ด้วย ไม่ใช่แค่ technical delivery

**Integrated Plan** ต้อง link **phase-gate** กับ **invoice schedule** โดยตรง เช่น:
- Gate 1 (Design Freeze) → milestone payment 20%
- Gate 2 (SAT Sign-off) → milestone payment 40%
- Gate 3 (Go-live) → milestone payment 30%
- Gate 4 (Post-support 30d) → final 10%

การ link แบบนี้ทำให้ทีมรู้ว่า "ถ้า design freeze slip 2 สัปดาห์ = cashflow ของบริษัท delayed 2 สัปดาห์"

---

### Phase 4: Design Phase

เป้าหมาย: **ตัดสินใจเรื่อง architecture และ spec ก่อนลงทุน build** — เปลี่ยน design บนกระดาษ ถูกกว่าเปลี่ยน hardware 100 เท่า

| เอกสาร | Lean format | จุดประสงค์ |
|--------|------------|-----------|
| **System Architecture** | 1 diagram + 1 หน้า | ยืนยัน interface ระหว่าง component |
| **Design Specs** (ME/EE/PCB/FW/SW) | 2–5 หน้า/discipline | กำหนด critical parameter, tolerance, interface |
| **PDR (Preliminary Design Review)** | Meeting minutes | ยืนยัน design direction ก่อนลงทุน detail |
| **CDR (Critical Design Review)** | Meeting minutes | freeze design ก่อนเข้า Build |

**Lean Design Spec** ไม่ใช่ spec ทุกอย่าง — คือ spec ของ **parameter ที่ถ้าผิดแล้ว fail gate** เท่านั้น เช่น:
- EE Spec: supply voltage range, current limit, protection threshold
- FW Spec: communication protocol version, OTA update flow, fail-safe behavior
- SW Spec: API contract, data retention policy, latency SLA

**Design Review (PDR/CDR)** ที่ดีคือ meeting ที่มี **action items + owner + date** ไม่ใช่ meeting ที่ทุกคน "เห็นด้วย" แล้วเดินออกมา — sign-off ที่ไม่มี open issue = sign-off ที่ไม่ได้ review จริง

---

### Phase 5: Build & Validation (EVT → DVT → PVT)

เป้าหมาย: **ยืนยันว่า design ทำงานได้จริง และ manufacturing ทำซ้ำได้**

```
EVT (Engineering Validation Test)
 → ยืนยัน: design works as intended
 → units: 3–50
 → output: validated design + issue log

DVT (Design Validation Test)
 → ยืนยัน: parts are good + DFM complete
 → units: 20–300
 → output: certified design + locked supply chain

PVT (Production Validation Test)
 → ยืนยัน: production line consistent
 → units: 100–1,000 (pilot build)
 → output: frozen production process + yield data
```

| เอกสาร | ช่วงที่ใช้ | ใช้ track อะไร |
|--------|-----------|---------------|
| **Test Plan** | ก่อน EVT/DVT/PVT | กำหนด pass/fail criteria ก่อนทดสอบ |
| **Test Report** | หลังทดสอบทุก round | evidence สำหรับ gate review |
| **Issue Log** | ตลอด build | track defect จาก open → root cause → closed |
| **Change Log (ECO/ECR)** | ตลอด build | track ทุกการเปลี่ยน BOM/design พร้อม approval |

**ECO (Engineering Change Order)** ต้องมีก่อนที่จะเปลี่ยน production BOM จริง — ไม่ใช่ document after-the-fact ถ้าทีมเปลี่ยน component แล้วค่อยเขียน ECO ทีหลัง แปลว่ากระบวนการ change control ล้มเหลว

---

### Phase 6: Pilot & Iteration

เป้าหมาย: **รับ feedback จากการใช้งานจริงก่อน GA** และ manage revision อย่างมีระบบ

| เอกสาร | ใช้ตัดสินใจอะไร |
|--------|----------------|
| **Pilot Plan** | กำหนด success criteria ของ pilot + escalation path |
| **Field Feedback Log** | aggregate issue จาก pilot site → priority matrix |
| **Revision Summary** | ระบุ change ระหว่าง spin/release พร้อม rationale |

**Pilot Plan** ควรระบุ **exit criteria** ชัดเจน — เช่น "zero critical bug, ≤3 major bug after 2 weeks operation" แทนที่จะเป็น "ลูกค้า happy" เพราะ criteria แบบหลังไม่สามารถ gate ได้

**Revision Summary** เชื่อม Pilot → DVT/PVT รอบถัดไป — เป็น living document ที่บันทึกว่า spin แต่ละรอบแก้ไขอะไร ทำไม และมี regression test ครอบคลุมหรือยัง

---

### Phase 7: Qualification & Certification

เป้าหมาย: **ได้ certificate ที่จำเป็นสำหรับ market entry** และ document ให้ตรวจสอบย้อนกลับได้

| เอกสาร | ตัวอย่าง |
|--------|---------|
| **Compliance Checklist** | CE, FCC, UL, RoHS, IEC 62368 |
| **Test Reports** | lab report จาก accredited lab |
| **Declaration of Conformity** | EU: DoC + technical file |

**Pre-compliance testing** ด้วย internal lab ก่อน formal submission ช่วยลด cost และเวลา — การส่งเข้า lab โดยไม่ผ่าน pre-compliance มักจะ fail รอบแรกเสมอ และ resubmission fee สูงกว่า pre-compliance cost มาก

---

### Phase 8: Deployment

เป้าหมาย: **ติดตั้งและ commission ที่ site ของลูกค้า และได้ sign-off อย่างเป็นทางการ**

| เอกสาร | สิ่งที่ unblock |
|--------|----------------|
| **Installation Guide** | ทำให้ field engineer ติดตั้งได้โดยไม่ต้องโทรหา R&D |
| **Commissioning Guide** | step-by-step สำหรับ power-on + initial config |
| **SAT Document** | formal record ของ test result ที่ site + customer sign-off |
| **UAT Document** | ยืนยัน end-user workflow ทำงานได้ตาม requirement |

**SAT (Site Acceptance Test)** คือ financial milestone — ส่วนใหญ่ผูกกับ payment 30–50% หน้าที่ของ PM คือ ensure ว่า SAT criteria ถูก define ไว้ใน SOW ตั้งแต่ต้น ไม่ใช่ negotiate ใหม่ตอน deployment

ความแตกต่างระหว่าง FAT และ SAT:
- **FAT** — ทดสอบที่ factory ของ vendor ก่อน ship: ยืนยันว่า build ถูกต้อง
- **SAT** — ทดสอบที่ site จริงของลูกค้า: ยืนยันว่า system ทำงานใน environment จริง

---

### Phase 9: Commercial & Post-deployment

เป้าหมาย: **ปิด commercial loop และส่งมอบ asset ครบถ้วนสำหรับ long-term operation**

| เอกสาร | ผู้ใช้หลัก |
|--------|-----------|
| **Invoice Tracker** | PM / Finance: track payment milestone vs actual |
| **Handover Pack** | Operations team: as-built + source code + all docs |
| **MA/SLA Agreement** | PM / Customer: กำหนด response time, coverage, exclusion |
| **Support Runbook** | Support team: troubleshooting guide + escalation path |

**Handover Pack** คือเอกสารที่มักถูกมองข้ามในงาน SI แต่มีความสำคัญมาก — ถ้า support engineer ใหม่เข้ามาแทน engineer เดิมไม่ได้โดยไม่มี handover pack แสดงว่า project นั้นยังไม่ complete จริง

**Support Runbook** ควรเขียนโดย engineer ที่รู้จักระบบดีที่สุด ก่อนที่จะย้ายไปทำ project ใหม่ — ไม่ใช่เขียนหลังจาก production incident ครั้งแรก

---

### หัวใจของ Lean: "3-filter test"

ก่อนสร้างเอกสารใหม่ ถามตัวเองสามข้อ:

1. **ตัดสินใจ**: มี decision ที่ต้องใช้เอกสารนี้เป็น input ไหม? ถ้าไม่มี — ไม่ต้องมี
2. **ควบคุมความเสี่ยง**: เอกสารนี้ป้องกัน risk ที่ระบุชื่อได้ไหม? ถ้าไม่มี risk ที่ชัด — ไม่ต้องมี
3. **ตรวจสอบย้อนกลับ**: ถ้าเกิดปัญหา เอกสารนี้จะช่วย trace root cause ได้ไหม? ถ้าไม่มีโอกาส — ไม่ต้องมี

ผ่านทั้งสามข้อ = สร้าง. ผ่านสองข้อ = พิจารณา. ผ่านหนึ่งหรือศูนย์ข้อ = skip

## User Guide (Step-by-Step)

### วิธีใช้ Lean Document Set ในโปรเจกต์จริง

**Step 1 — Map phases ของโปรเจกต์คุณ**

ไม่ใช่ทุก project ต้องครบ 9 phase — software-only SI อาจข้าม Qualification phase; fast-turnaround project อาจ merge Pilot & Iteration กับ Deployment ได้

ตัวอย่าง: Smart Factory Monitoring Project (12 สัปดาห์)
```
Idea/Discovery (w1) → Pre-sales (w2-3) → Kick-off (w4) →
Design (w5-6) → Build&Validate (w7-9) → Pilot (w10) →
Deployment+SAT (w11-12) → Handover (w12 end)
```

**Step 2 — กำหนด gate criteria ก่อนเริ่ม phase**

ทุก gate ต้องมี "Must Meet" criteria ที่วัดได้ เช่น:
- Design Freeze Gate: "All open issues in Issue Log = P3 หรือต่ำกว่า"
- SAT Gate: "All test cases in SAT doc = PASS, zero Critical/Major open"

**Step 3 — Assign document owner**

เอกสารที่ไม่มี owner = เอกสารที่จะ outdated — แต่ละ doc ต้องมีคน responsible สำหรับ update และ review ก่อน gate

**Step 4 — Version control ทุกอย่าง**

ใช้ git หรืออย่างน้อย date-suffix naming (`SOW_v1.2_2026-05-22.pdf`) — เพราะ dispute มักเกิดขึ้นเมื่อทั้งสองฝ่าย refer คนละ version

**Step 5 — Post-mortem: ระบุ doc ที่ไม่ได้ใช้**

หลัง project จบ ทำ 15-minute retro ถามว่า "เอกสารไหนไม่มีใครอ่าน?" — เอาออกจาก template ของ project ถัดไป นี่คือ mechanism ที่ทำให้ lean set เป็น lean จริง ๆ

## Caveats / Limits

**Document set นี้ไม่ universal** — hardware product ที่ต้องผ่าน FDA, DO-178C (avionics), หรือ IEC 62443 (industrial cybersecurity) มี mandatory documentation requirement ที่ไม่สามารถ lean ออกได้ ต้องตรวจสอบ regulatory requirement ก่อน

**Lean ≠ ไม่มีเอกสาร** — "lean" หมายถึงมีเฉพาะที่จำเป็น ไม่ใช่ minimize ทุกอย่าง ECO/ECR ที่ถูกมองว่า "overhead" มักกลายเป็น lifesaver ตอน production recall

**Version control ที่ไม่ดีล้มเหลว lean document set** — ถ้า SOW มี 3 version อยู่ใน email และไม่มีใครรู้ว่า version ไหน active lean set ก็ไม่ต่างจากไม่มีเอกสาร

**Remote/async team ต้องการ stricter gate criteria** — เพราะไม่มี "corridor conversation" ที่จะ sync ความเข้าใจ gate criteria ต้อง explicit และ written มากกว่า co-located team

## References

1. [Ultimate Guide to the Phase Gate Process — Smartsheet](https://www.smartsheet.com/phase-gate-process)
2. [How Gate Control and DMS Improve Product Development Success — CogniDox](https://www.cognidox.com/blog/effective-product-development-with-gate-phase-control-and-a-dms)
3. [How to Write a Lean Product Requirements Document (PRD) — IntelliSoft](https://intellisoft.io/product-requirements-document-prd-why-make-it-lean/)
4. [Hardware product development stages: POC–EVT–DVT–PVT explained — Encata](https://www.encata.net/blog/overview-of-the-hardware-product-development-stages-explained-poc-evt-dvt-pvt)
5. [What Are EVT, DVT, & PVT? — Hatch Product Development](https://www.hatch-pd.com/blog/what-are-evt-dvt-pvt)
6. [Site Acceptance Test (SAT) in Commissioning: Process & Checklist — Flowdit](https://flowdit.com/site-acceptance-test/)
7. [How to Structure an IT Solution Proposal: Executive Summary to BOM — VAR Street](https://blog.varstreetinc.com/how-to-structure-an-it-solution-proposal-that-every-stakeholder-can-approve/)

## Key Takeaways

- **3-filter test**: เอกสารผ่านถ้า ① ใช้ตัดสินใจ ② ควบคุม risk ที่ระบุได้ ③ trace root cause ได้ — ผ่านน้อยกว่า 2 ข้อ = ไม่ต้องมี
- **Phase Gate = decision checkpoint ไม่ใช่ filing deadline** — gate ที่ดีมี "Must Meet" criteria ที่วัดได้ และสามารถ Kill หรือ Hold project ได้จริง
- **SOW คือเอกสารที่ ROI สูงสุดใน pre-sales** — ทุกบรรทัดที่ define exclusion และ assumption ประหยัด dispute ที่แพงกว่าในช่วง execution
- **ECO/ECR ไม่ใช่ bureaucracy แต่คือ audit trail** — production recall ที่ trace ไม่ได้ว่า component เปลี่ยนเมื่อไรและใคร approve มีราคาสูงกว่า change order overhead มาก
- **SAT ผูกกับ payment milestone** — define SAT criteria ใน SOW ตั้งแต่ต้น อย่า negotiate ใหม่ตอน deployment เพราะ leverage หายไปแล้ว
- **Handover Pack คือ project completion test** — ถ้า support engineer ใหม่เข้ามาแทนไม่ได้โดยไม่มี handover pack แสดงว่ายังไม่ complete จริง
- **Post-mortem "เอกสารไหนไม่มีใครอ่าน?"** — mechanism เดียวที่ทำให้ lean document set lean ขึ้นเรื่อย ๆ ในแต่ละ project
