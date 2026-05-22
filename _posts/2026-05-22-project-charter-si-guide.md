---
title: "Project Charter สำหรับงาน SI: กรอบโครงการตั้งแต่ Pre-Sales จนถึง Maintenance"
date: 2026-05-22 00:23:00 +0700
categories: [Engineering]
tags: [project-management, project-charter, system-integrator, si, design-review, milestone, evt-dvt-pvt, raci, change-control]
series: project-management-si
slides: true
---

{% include series-nav.html %}

{% include slide-link.html %}

## TL;DR

Project Charter ใน SI project ไม่ใช่แค่เอกสารเริ่มต้น — มันคือ **master contract ภายใน** ที่ผูก technical scope, design review gates, build stages, acceptance criteria, และ invoice schedule ไว้ด้วยกัน ถ้า Charter ไม่ครอบคลุมตั้งแต่ต้น PM จะเจอ scope creep, delayed payment, และ certification surprise ที่แก้ไม่ทันก่อน deadline

---

## Background / Why this matters

งาน System Integrator (SI) คือการนำ hardware, firmware, software, และ physical installation มารวมเป็น solution ให้ลูกค้า — ความซับซ้อนจึงสูงกว่า software-only project อย่างมีนัยสำคัญ เพราะ:

- **HW/FW/SW interdependency**: bug ใน firmware อาจบล็อก software test ทั้ง sprint
- **Long-lead items**: PCB fabrication, mechanical tooling, regulatory testing ล้วนใช้เวลาหลายสัปดาห์ถึงหลายเดือน
- **Contractual milestones**: payment trigger ผูกกับ physical deliverables เช่น prototype delivery, SAT pass — ไม่ใช่แค่ commit หรือ story point
- **Certification latency**: regulatory approval (CE, FCC, UL, TISI) มักใช้เวลา 6–12 สัปดาห์ และ fail ครั้งเดียวดันเลื่อน deployment ทั้ง project

PM ที่ไม่มี Charter ที่แข็งแกร่งพอจะควบคุม cash flow, manage dependency, และ enforce acceptance criteria ตามสัญญาได้ยากมาก

---

## Deep Dive

### 1. Pre-Sales → PO: ต้นกำเนิดของ Charter

Charter ไม่ได้เริ่มที่ kick-off meeting — มันเริ่มก่อนนั้นมาก:

```
Proposal Phase
└─ Customer reviews solution + quotation
   └─ Customer approves → issues PO
      └─ PO = Official Day 1 (Kick-off)
         └─ Charter is activated / finalized
```

**ก่อน PO**: PM ต้อง pre-draft Charter แล้ว เพราะ scope, milestone, และ commercial terms ต้องสอดคล้องกับ proposal ที่ขายไป ถ้า draft Charter ไม่ sync กับ quotation จะเกิด mismatch ตั้งแต่วันแรก

**หลัง PO**: Charter กลายเป็น living document — update ได้แต่ต้องผ่าน Change Control (ECO/ECR) ทุกครั้ง

---

### 2. Scope Definition: Product Design Disciplines

Charter ต้องระบุ scope ครอบคลุมทุก discipline ที่เกี่ยวข้อง:

| Discipline | ตัวอย่าง Deliverable | Key Dependency |
|---|---|---|
| **ME** (Mechanical Engineering) | Enclosure, PCB holder, thermal design | Dimension → FW thermal limit |
| **EE** (Electrical Engineering) | Schematic, BOM, power budget | Voltage rails → FW power mgmt |
| **PCB** | Gerber, assembly drawing, stack-up | Component lead time |
| **FW** (Firmware) | BSP, driver, OTA update | HW bring-up sequence |
| **SW/App** | Backend API, mobile app, web dashboard | API contract with FW |
| **WebApp** | Portal, reporting, configuration UI | SW API availability |

กรณีที่ scope ข้าม discipline: PM ต้องกำหนด **interface definition** ชัดเจนใน Charter เพื่อป้องกัน "ฉันรอ HW อยู่" / "ฉันรอ FW อยู่" loop ที่ไม่มีใครเป็น owner

---

### 3. Design Review Gates: SRR / PDR / CDR

Design review คือ **risk gates** — ไม่ใช่แค่ meeting เพื่อ update progress ทุก gate มี entry/exit criteria และ **ทำหน้าที่ freeze irreversible decisions** ก่อนเข้าสู่ขั้นตอนถัดไปที่ cost สูงกว่า:

#### SRR — System Requirements Review

- **เมื่อไร**: หลัง kick-off ก่อนเริ่ม design ใดๆ
- **validate อะไร**: requirements ครบ, consistent, verifiable; verification plan credible
- **exit criteria**: requirements baseline + verification plan ได้รับ approve; preliminary design work เริ่มได้
- **ถ้า skip**: เสี่ยง build solution ที่ไม่ตรง requirements จนต้อง redesign ที่ CDR stage

#### PDR — Preliminary Design Review

- **เมื่อไร**: หลัง SRR, preliminary design เสร็จ
- **validate อะไร**: baseline architecture + interfaces meet requirements with margin; long-lead planning ready
- **exit criteria**: architecture frozen; detailed design work และ long-lead procurement authorized
- **ถ้า skip**: โอกาส architecture mismatch สูง → ค้นพบปัญหาตอน CDR = เสียเวลา 2–4 เดือน

#### CDR — Critical Design Review

- **เมื่อไร**: หลัง PDR, detailed design เสร็จ
- **validate อะไร**: detailed design complete, producible, fully traceable to requirements
- **exit criteria**: design frozen; drawings + BOM frozen; manufacturing + test hardware fabrication authorized
- **ถ้า skip**: build prototype จาก incomplete/unreviewed design → EVT fail rate พุ่ง

```
SRR → PDR → CDR → [Prototype Build] → EVT → DVT → PVT → MP
 ↑       ↑      ↑
 requirements  architecture  detailed design
 baseline      frozen        frozen
```

---

### 4. Prototype Build & Validation: EVT / DVT / PVT

หลัง CDR ผ่าน โครงการเข้าสู่ build & validation cycle — แต่ละ stage มี objective, scale, และ success criteria ต่างกัน:

#### EVT — Engineering Validation Test

**Goal**: เลือก production-worthy design configuration

- First time ที่ design รวม "looks-like" และ "works-like" เข้าด้วยกันใน form factor จริง
- ใช้ production-intent materials และ processes (ไม่ใช่ prototype shortcuts)
- Quantity: ~100–1,000 units
- ยอมรับ failure rate ได้สูง (up to 40% ใน reliability testing เป็นเรื่องปกติ)
- **Exit**: มี 1 configuration ที่ผ่าน functionality + performance + reliability requirements

#### DVT — Design Validation Test

**Goal**: verify mass production yields

- ใช้ parts จาก hard tools + mass-production processes เท่านั้น
- Quantity: ~300–2,000 units
- ระบุ yield issues + corrective actions ก่อนเข้า PVT
- **Exit**: high confidence ว่า corrective actions จะให้ acceptable yield ที่ production scale

#### PVT — Production Validation Test

**Goal**: verify yields at actual production speed

- Units ที่ build ใน PVT คือ units ที่จะขายให้ลูกค้าจริง (no parallel experimental builds)
- Quantity: ~1K–20K units
- Transition โดยตรงเข้า Ramp / Mass Production
- **Exit**: achieved mass production yields ที่ production speed บน at least one line

**Design Iterations (Spins)**: ระหว่าง EVT/DVT/PVT จะมี design spin (PCB revision, FW patch, ME modification) เพื่อแก้ issues — Charter ต้องกำหนด spin budget (จำนวน revision ที่ยอมรับได้) และ escalation path ถ้าเกิน budget

---

### 5. Qualification & Certifications

ก่อน deployment จริง product ต้องผ่าน qualification ที่ตรงกับ market/application:

| Certification | Coverage | ประมาณเวลา |
|---|---|---|
| CE (Europe) | EMC + Safety | 6–12 สัปดาห์ |
| FCC (US) | Radio frequency | 4–8 สัปดาห์ |
| UL/ETL (US Safety) | Electrical safety | 8–16 สัปดาห์ |
| TISI (ไทย) | มอก. | 4–12 สัปดาห์ |
| IP Rating | Ingress protection | 2–4 สัปดาห์ |
| Functional Safety (IEC 61508) | Safety-critical systems | 12–24 สัปดาห์ |

**Charter rule**: certification timeline ต้อง plot บน Gantt ก่อนกำหนด deployment date เสมอ ไม่ใช่ add-on หลัง build เสร็จ Certification fail ครั้งเดียว = ดัน deployment ออกไป 1–3 เดือน

---

### 6. Deployment: Installation, Commissioning, SAT / UAT

Deployment phase มี milestone เชิงสัญญาที่สำคัญที่สุด:

#### FAT — Factory Acceptance Test

- ทำที่ SI facility ก่อน ship
- ตรวจสอบว่า system ทำงานตาม spec ภายใต้ controlled conditions
- Pass FAT = authorized to ship

#### Commissioning

- Field installation + integration ที่ site ลูกค้า
- Connect to existing infrastructure (power, network, sensors, ERP)
- ตรวจสอบ physical installation, cabling, network, control system

#### SAT — Site Acceptance Test

- ทำที่ customer site หลัง commissioning เสร็จ
- **validate ว่า system ทำงานถูกต้องใน operating environment จริง** — รวม actual load, ambient conditions, integration กับ existing systems
- SAT pass คือ **payment trigger** หลักใน contract (milestone payment)
- ต้องมี SAT checklist/protocol กำหนดใน Charter ตั้งแต่ต้น ไม่ใช่รอ negotiate ตอน commissioning

#### UAT — User Acceptance Test

- โดยหลักคือ end-user ทดสอบ software/application layer
- มักทำ parallel กับ SAT หรือ หลัง SAT pass
- Pass UAT = system handover + warranty เริ่มต้น

---

### 7. Maintenance Phase: MA / SLA

หลัง SAT/UAT pass โครงการเข้าสู่ maintenance:

- **MA (Maintenance Agreement)**: กำหนด scope งาน maintenance รายปี (preventive + corrective)
- **SLA (Service Level Agreement)**: response time, uptime guarantee, escalation path
- **Spare Parts Plan**: BOM สำหรับ critical components ที่ต้อง stock ที่ site หรือ regional warehouse
- **EOL/Lifecycle Management**: กำหนด product lifecycle, upgrade path, sunset plan

Charter ต้องระบุว่า MA/SLA scope รวมหรือไม่รวมอะไร เพื่อป้องกัน "ทำไมยังไม่มาซ่อม" dispute

---

### 8. Commercial Terms: Milestone-Linked Invoice Schedule

นี่คือหัวใจของ Charter ที่ PM มักมองข้าม — invoice schedule ต้องผูกกับ technical milestone อย่างชัดเจน:

| Invoice Trigger | % Payment | หมายเหตุ |
|---|---|---|
| Upon PO release | 15–30% | Mobilization fee; cover long-lead procurement |
| Design approval (CDR pass) | 10–15% | Confirm design investment |
| Prototype delivery (EVT) | 10–15% | Hardware deliverable |
| Test pass (DVT/PVT) | 10–15% | Validated design |
| Certification approval | 5–10% | Regulatory milestone |
| Installation completion | 10–15% | Physical milestone at site |
| SAT pass | 15–20% | Contractual acceptance |
| Final acceptance (UAT + warranty start) | 5–10% | Project closeout |

**ทำไม structure แบบนี้สำคัญ**:
- **Cash flow control**: SI ต้องลงทุน hardware + labor ก่อน — up-front payment ป้องกัน working capital ติดลบ
- **Risk distribution**: ถ้า customer cancel หลัง CDR pass, SI ได้รับ payment ครอบ design cost แล้ว
- **Accountability alignment**: ลูกค้ามี incentive approve milestone อย่าง timely เพราะ payment ผูกกับ acceptance

---

### 9. Governance: RACI Matrix

RACI ใน SI project ต้องครอบคลุม cross-functional roles:

| Activity | PM | HW Lead | FW Lead | SW Lead | QA | Customer |
|---|---|---|---|---|---|---|
| Requirements sign-off | A | C | C | C | C | R |
| SRR/PDR/CDR approval | A | R | R | R | C | I |
| Design freeze | A | R | C | C | C | I |
| EVT/DVT/PVT execution | I | R | R | R | A | I |
| Certification submission | A | R | C | C | C | I |
| SAT execution | A | R | I | I | R | R |
| Invoice approval | I | I | I | I | I | A |
| Change control (ECO) | A | R | C | C | R | I |

**R** = Responsible (ทำ), **A** = Accountable (sign-off), **C** = Consulted, **I** = Informed

---

### 10. Change Control: ECO / ECR / ECN

ใน SI project การ change หลัง design freeze มี cost สูง — ต้องมี formal process:

**ECR (Engineering Change Request)**
- ใครๆ ก็ raise ได้ (engineer, QA, customer, field)
- ระบุ: ปัญหาที่พบ, proposed change, estimated impact (cost/schedule/risk)
- CCB (Change Control Board) review → approve หรือ reject

**ECO (Engineering Change Order)**
- ECR ที่ approved แล้ว → convert เป็น ECO
- ระบุ affected items: BOM, drawings, firmware version, test plan
- CCB (PM + HW + FW + SW + QA) ต้อง approve ทั้งหมด ก่อน implement

**ECN (Engineering Change Notice)**
- Communicate approved ECO ไปยังทุก stakeholder ที่ affected
- Update configuration baseline (version control)

**Versioning rule**: ทุก design artifact ต้องมี version number ที่ link กับ ECO เสมอ ตัวอย่าง:
```
PCB Rev: A → EVT
PCB Rev: B → DVT (ECO-0012: fix thermal pad)
PCB Rev: C → PVT (ECO-0019: change USB ESD protection)
```

---

### 11. การ Sync ข้าม HW / FW / SW: หัวใจของ SI

ความท้าทายที่ unique ของ SI คือ dependency chain ข้าม discipline:

```
HW bring-up → FW porting → SW integration test
     ↑                           ↑
PCB spin time (4–6 wk)   API contract freeze
```

**Best practices ใน Charter**:
1. **Interface Lock Date**: กำหนดวันที่ HW/FW/SW interface definitions ต้อง freeze ก่อน dependent team เริ่ม integrate
2. **Parallel Simulation**: FW team ใช้ hardware emulator ระหว่างรอ PCB; SW team ใช้ FW stub API ระหว่างรอ firmware
3. **Integration Sprint**: reserve sprint เฉพาะสำหรับ cross-discipline integration (ไม่ใช่ new feature)
4. **Regression Gate**: FW update ทุกครั้งต้อง run SW regression test suite ก่อน push to integration branch

---

## Caveats / Limits

- **Charter ≠ Contract**: Charter คือ internal document ที่ align team; contract กับลูกค้าคือ legal document แยกต่างหาก แต่ทั้งสองต้องสอดคล้องกัน
- **SRR/PDR/CDR มาจาก Space/Defense sector**: ใน commercial SI อาจเรียกต่างกัน (Design Review, Concept Review) แต่ principle เดียวกัน
- **Certification timeline เปลี่ยนได้**: lab backlog และ regulatory change กระทบ lead time — ควร buffer อย่างน้อย 20%
- **Payment trigger ต้อง negotiate ก่อน sign contract**: อย่า assume ว่า structure ข้างต้นใช้ได้กับทุก customer — บาง customer มี internal process ที่ช้ากว่า

---

## References

1. [What is a project charter? Definition, examples and best practices — Plane](https://plane.so/blog/what-is-a-project-charter)
2. [EVT, DVT, PVT Stage Gate Definitions — Instrumental](https://instrumental.com/build-better-handbook/evt-dvt-pvt)
3. [PDR, CDR, MRR… Space Project Milestones Decoded — Anywaves](https://anywaves.com/resources/blog/space-project-milestones-a-practical-guide/)
4. [Site Acceptance Test (SAT) in Commissioning: Process & Checklist — Flowdit](https://flowdit.com/site-acceptance-test/)
5. [What is an Engineering Change Order (ECO)? — Arena Solutions](https://www.arenasolutions.com/resources/articles/engineering-change-order/)
6. [How to Make a RACI Chart for a Project — ProjectManager](https://www.projectmanager.com/blog/how-to-make-a-raci-chart-for-a-project-with-example)
7. [Hardware product development stages: POC–EVT–DVT–PVT explained — Encata](https://www.encata.net/blog/overview-of-the-hardware-product-development-stages-explained-poc-evt-dvt-pvt)

---

## Key Takeaways

- Charter ที่ดีต้อง **ผูก milestone กับ invoice trigger** — ไม่ใช่แค่ Gantt chart ที่ไม่มี commercial consequence
- **SRR → PDR → CDR** คือ risk gate ที่ freeze irreversible decisions; ข้ามไปเสี่ยง rework cost สูงใน late stage
- **EVT = design selection**, **DVT = yield validation**, **PVT = production speed validation** — แต่ละ stage มี exit criteria ต่างกัน
- **SAT pass** คือ contractual acceptance milestone หลัก — ต้องมี protocol กำหนดใน Charter ก่อนเริ่มโครงการ
- **Certification timeline** ต้อง plot บน master schedule ก่อนกำหนด deployment date — ไม่ใช่ afterthought
- **ECO/ECR process** ปกป้อง design baseline หลัง CDR freeze; ทุก change ต้องมี CCB approval และ version update
- **Interface lock date** ระหว่าง HW/FW/SW คือ dependency ที่ critical ที่สุดใน SI project — กำหนดใน Charter และ enforce อย่างเคร่งครัด
