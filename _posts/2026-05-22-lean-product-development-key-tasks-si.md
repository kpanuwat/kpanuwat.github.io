---
title: "Key Tasks ใน Product Development (SI) แบบ Lean: ตั้งแต่ Idea ถึง Commercial"
date: 2026-05-22 00:25:00 +0700
categories: [Engineering]
tags: [product-development, system-integrator, si, lean, npi, prd, bom, sow, evt-dvt-pvt, pdr-cdr, eco-ecr, dfm-dft, sat-uat, ma-sla, change-control, supply-chain, project-management]
series: project-management-si
slides: true
---

{% include series-nav.html %}

{% include slide-link.html %}

## TL;DR

Product Development ใน SI/Tech project คือ chain ของ decision gates ตั้งแต่ Idea ถึง Commercial — แต่ละ phase มี 2–4 task หลักที่ต้องทำให้ "complete จริง" ก่อน unblock phase ถัดไป บทความนี้แมป 10 phases พร้อม task ที่ PM และทีมต้อง execute ในแต่ละ gate โดยมีหัวใจ 4 cross-cutting disciplines: BOM maturity, supply risk, cross-discipline sync, และ change control ที่ thread ผ่านทุก phase

## Background / Why this matters

ใน SI project ส่วนใหญ่ความล้มเหลวไม่ได้เกิดจากทีมไม่เก่ง แต่เกิดจาก **ไม่รู้ว่าต้องทำอะไรตอนไหน** — PM ข้ามขั้นตอน engineer ไม่ส่ง eBOM ให้ SCM ก่อนสั่ง component, หรือทำ pilot deploy ก่อน CDR complete ปัญหาเหล่านี้ส่งผลให้ respin เพิ่ม, cost overrun, และที่สำคัญกว่า — missed invoice milestone ที่กระทบ cashflow บริษัทโดยตรง

สาเหตุที่ SI product development ยากกว่า pure software คือ **tri-discipline dependency**: HW, FW, และ SW ต้องสอดประสานกัน — FW ไม่สามารถ validate บน board ที่ยังไม่ผ่าน DVT, SW integration test ไม่สมบูรณ์จนกว่า FW API จะ stable, และ procurement lead-time ของ HW component อาจกิน 16–20 สัปดาห์ ทั้งหมดนี้บังคับให้ PM ต้องคิดเป็น dependency graph ไม่ใช่ to-do list

## Deep Dive

### Phase 1: Idea / Discovery

เป้าหมาย: **ยืนยันว่า "ปัญหาจริง แก้ได้ คุ้มทุน"** ก่อนลงทุน resource ใดๆ

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| นิยามปัญหา | PM + Customer | Problem Statement (1 หน้า) | ปัญหา scoped & validated |
| จัดทำ PRD Lite | PM + Tech Lead | User story + acceptance criteria + MVP scope | "Done" definition ชัด |
| Feasibility triple | Tech Lead + Finance | Feasibility Note: tech/cost/supply | Go / No-Go decision |

**Lean shortcut**: PRD Lite ≠ PRD เต็ม — ไม่มี wireframe, ไม่มี backlog, เขียน 1–2 หน้าเพื่อ align "done คืออะไร" ก่อนที่จะรู้ว่าจะ win deal หรือเปล่า [1]

**Feasibility triple** ครอบคลุม 3 มิติ: Technical (ทำได้ด้วย stack ปัจจุบันไหม?), Cost (margin เพียงพอไหม?), Supply constraint (component ที่ต้องใช้หามาได้ใน timeline ที่ commit ไหม?) — supply constraint เป็น gate ที่หลายทีมมองข้ามแล้วไปสะดุดใน Phase 5

---

### Phase 2: Pre-sales

เป้าหมาย: **ให้ลูกค้า approve proposal และออก PO** — PO คือ official kick-off

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| จัดทำ Solution Proposal | Pre-sales + Tech Lead | Proposal document | Customer technical sign-off |
| จัดทำ Budgetary BOM | Hardware Lead + SCM | BOM พร้อม estimated cost + lead time | Budget range confirmed |
| เขียน SOW | PM | Deliverable, exclusion, customer responsibility | Scope agreed |
| จัดทำ Risk/Assumption Log | PM | Risk register + assumption list | ลูกค้ารับรู้ความเสี่ยง |
| รับ PO | PM | Purchase Order | **Official kick-off** |

**Budgetary BOM** ต่างจาก eBOM ตรงที่ใช้ estimated parts + substitute components — ยังไม่ใช่ final design แต่ต้องสะท้อน lead-time reality: component ที่ lead time 16–20 สัปดาห์ต้องระบุ risk ตั้งแต่ตอนนี้ [2]

**SOW** คือเอกสารที่สำคัญที่สุดของ phase นี้ — deliverable ต้องวัดได้ ("system response < 2s under 100 concurrent users"), customer responsibility ต้องชัด (access, credentials, site readiness), และ exclusion ต้องระบุ explicit เพื่อป้องกัน scope creep หลัง PO

---

### Phase 3: Kick-off & Project Setup

เป้าหมาย: **แปลง commercial agreement เป็น execution plan** ที่ทุก discipline aligned

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| จัดทำ Project Charter | PM | Charter: scope, RACI, budget, escalation | Sponsor + Customer sign-off |
| สร้าง Master Plan | PM | Integrated milestone plan | Phase-gate dates confirmed |
| ผูก milestone กับ invoice | PM + Finance | Payment schedule aligned to gates | Finance & Customer aligned |
| ตั้ง Config/DevOps environment | Tech Lead + DevOps | Repo, CI/CD, staging environment | "First commit" พร้อม |

**Milestone ↔ invoice binding** เป็น task ที่ PM ใน SI ต้องทำแต่ PM ใน pure software มักไม่ต้องคิด — ตัวอย่างทั่วไป: Design Freeze → 20%, SAT Sign-off → 40%, Go-live → 30%, Post-support 30d → 10% [1]

การ setup Config/DevOps environment ใน kick-off phase ป้องกัน "ทำเสร็จแล้วแต่ไม่มีที่ deploy" — ต้องรวม version control, artifact registry, staging/production environments, และ access management ให้ทีมสามารถ work ได้ตั้งแต่ Day 1 of Design

---

### Phase 4: Design

เป้าหมาย: **ออกแบบ system จนถึงระดับที่พร้อม build prototype** — ปิด phase ด้วย eBOM freeze

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| พัฒนา System Architecture | Architect / Tech Lead | Architecture diagram + interface spec | PDR passed |
| Detailed Design HW | Hardware Engineer | Schematic, PCB layout, mechanical drawing | CDR passed |
| Detailed Design FW | Firmware Engineer | FW spec, module decomposition | CDR passed |
| Detailed Design SW | Software Engineer | SW architecture, API spec, DB schema | CDR passed |
| ทำ PDR (Preliminary Design Review) | PM + Leads | PDR report + action items | Design direction aligned |
| ทำ CDR (Critical Design Review) | PM + Leads + Customer | CDR report | Baseline design approved |
| Freeze eBOM | Hardware Lead + SCM | Engineering BOM v1.0 | SCM สามารถสั่ง prototype parts ได้ |

**PDR vs CDR**: PDR เป็น "direction review" — validate ว่า architecture ถูกต้อง, interface ชัด, risk ที่รู้แล้วถูก mitigate; CDR คือ "build review" — validate ว่า design detail ครบพอที่จะ build [1]

**eBOM freeze** หลัง CDR คือ gate ที่สำคัญมาก: SCM ต้องการ eBOM ที่ stable ก่อนสั่ง long-lead component สำหรับ EVT เพราะถ้า eBOM เปลี่ยนหลัง PO แปลว่า ECO process เริ่มทำงานทันที [3]

---

### Phase 5: Prototype — EVT / DVT / PVT

เป้าหมาย: **validate ทั้ง design และ manufacturing process** ผ่าน 3 checkpoint gates [2]

| Gate | Focus | Units | Exit criteria |
|------|-------|-------|---------------|
| **EVT** (Engineering Validation Test) | Core functionality, critical design flaws | Hand-assembled, ~5–10 units | ฟังก์ชันหลักทำงาน, critical bugs identified |
| **DVT** (Design Validation Test) | Production-grade reliability, regulatory compliance | Production-equivalent parts, ~20–50 units | FCC/CE pass, environmental stress pass |
| **PVT** (Production Validation Test) | Manufacturing assembly process, yield | Pilot production run, ~50–200 units | Yield ≥ 95%, assembly process documented |

**Tasks ที่ต้องทำระหว่าง EVT→PVT:**

- **SCM procurement**: Long-lead component ต้องสั่งก่อน EVT build — component บางตัว lead time 16–20 สัปดาห์; PO ช้ากว่า eBOM freeze 2 สัปดาห์ = EVT slip
- **Test plan execution**: แต่ละ gate มี test plan ที่ต้อง execute ครบก่อน sign-off — defect tracking ต้องมี root cause analysis ไม่ใช่แค่ fix แล้วปิด
- **ECO/ECR + BOM revision**: ทุก design change ระหว่าง prototype phases ต้องผ่าน ECR review → ECO issued → BOM version incremented [4]

---

### Phase 6: Pilot Deployment

เป้าหมาย: **ทดสอบ system ใน real-world environment ก่อน mass rollout**

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| Limited field rollout | PM + Field Team | System running ที่ 1–3 sites | Installation complete |
| Field feedback collection | PM + Support | Defect/feedback log จาก real use | Feedback สรุปแล้ว |
| Design iteration | Engineering | ECO/ECR + BOM update | 1–2 respins เสร็จ |
| Baseline confirmation | Tech Lead | Baseline release | Design frozen |

**Respin guideline**: 1–2 respins ใน pilot phase ถือเป็น healthy baseline สำหรับ HW product — ถ้า >3 respins ต้องหยุดตรวจว่า root cause คือ insufficient EVT/DVT testing หรือ scope creep [2]

Pilot deployment expose ปัญหาที่ EVT/DVT ใน lab ไม่เจอ — เช่น EMI ที่ site จริง, network latency ที่ไม่เสถียร, หรือ user workflow ที่ SW design ไม่ได้คาดไว้

---

### Phase 7: Qualification & Certification

เป้าหมาย: **ทำให้ product ผ่านมาตรฐานที่จำเป็น และ harden BOM เป็น pBOM**

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| Regulatory certification | Compliance Engineer | FCC, CE, UL, หรือ local cert | Certificate issued |
| DFM / DFT review | Manufacturing + HW | DFM/DFT report + BOM update | Manufacturing sign-off |
| BOM hardening → pBOM | SCM + Hardware | Production BOM (pBOM) | Mass production-ready |

**DFM (Design for Manufacturing)** ที่ทำตั้งแต่ design phase ช่วยลด manufacturing cost ได้ 15–20% — รวมถึงการ simplify components, standardize connectors, และลด hand-assembly steps [5]

**DFT (Design for Testability)** ผ่าน Boundary Scan และ In-Circuit Testing ช่วยลด post-launch field failure rates ได้ถึง 50% เมื่อเทียบกับ product ที่ไม่ได้ออกแบบเพื่อ testability [5]

**pBOM** ต้องผ่าน SCM approval ว่า component ทุกตัวมี source ที่ reliable, มี approved alternate, และ lead time เหมาะสมสำหรับ mass production schedule

---

### Phase 8: Mass Production & Logistics

เป้าหมาย: **scale production และส่งมอบ system ถึง site**

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| Production transfer | Manufacturing + SCM | Manufacturing SOP + pBOM released | First production batch started |
| Component procurement | SCM | Purchase orders issued | Components in warehouse |
| Production run | Manufacturing | Finished goods inventory | Quantity per PO filled |
| Logistics & packing | Logistics | Shipment to customer site | Goods received at site |
| Field installation | Field Team | System installed | Installation checklist done |

ขั้นตอนนี้ PM ต้องบริหาร **logistics lead-time** ร่วมกับ **invoice milestone** — ถ้า PO ระบุ "Goods Delivery = invoice trigger 30%" แต่ logistics delay 3 สัปดาห์ = cashflow กระทบทันที

---

### Phase 9: Acceptance — SAT / UAT

เป้าหมาย: **รับ formal sign-off จากลูกค้า** ที่ผูกกับ milestone ทางการเงิน

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| SAT (Site Acceptance Test) | PM + Field + Customer | SAT test report | System ทำงานถูกต้องที่ site จริง |
| UAT (User Acceptance Test) | PM + End Users | UAT sign-off sheet | End users confirm workflow สมบูรณ์ |
| Punch list resolution | Engineering | Resolved issues log | Critical issues = 0 |
| Acceptance sign-off | Customer | Signed acceptance document | **Invoice trigger** |

**SAT** คือ testing ที่ site จริง — verify ว่า system integrate กับ infrastructure ที่ site ได้จริง (SCADA, ERP, network) ไม่ใช่แค่ unit test ใน lab [6]

**UAT** focus อยู่ที่ end-user workflow — ตรวจสอบว่า operator ทำงานได้ตาม use case ที่ระบุใน PRD Lite และ SOW จริง

Acceptance criteria ต้อง agree ตั้งแต่ pre-sales เพื่อป้องกัน "ลูกค้าปฏิเสธ sign" โดยไม่มี basis [1]

---

### Phase 10: Commercial Handover & MA/SLA

เป้าหมาย: **ปิด project อย่างสมบูรณ์ และเข้าสู่ maintenance mode**

| Task | Owner | Output | Gate exit |
|------|-------|--------|-----------|
| Final invoicing | PM + Finance | Invoice issued | Payment received |
| As-built documentation | Engineering | As-built drawings, config files, network diagram | Docs delivered |
| Source + docs handover | Engineering | Source code, build instructions, user manual | Customer received |
| MA/SLA activation | PM + Support | MA contract active | Support team ready |
| Monitoring setup | DevOps / Support | Monitoring dashboard + alert threshold | Operational |
| Patch / OTA process | Engineering + Support | Update procedure + release cadence | First patch cycle defined |
| RMA process via SCM | SCM + Support | RMA procedure + spare parts inventory | Customer knows RMA process |

**As-built bundle** ต้องครอบคลุม: as-built drawings (capture changes จาก site installation — ต่างจาก design drawing), final pBOM, configuration files, และ network diagram — ถ้า bundle ไม่ครบ PM ต้องถือว่า phase ยังไม่ complete

**MA/SLA** contract ต้องระบุ response time (critical/non-critical), patch schedule, และ escalation path — RMA กับ SCM ต้องวางแผน spare parts inventory โดยเฉพาะ component ที่มี end-of-life risk สูง

---

## Cross-cutting Disciplines

### 1. BOM Maturity Control

BOM evolve ตาม phase — ทุก version change ต้องมี ECO trail:

| Phase | BOM Type | ใช้ทำอะไร | Risk ถ้าไม่ update |
|-------|----------|-----------|-------------------|
| Pre-sales | Budgetary BOM | Estimate cost, identify long-lead | Quote ผิดพลาด |
| Post-CDR | eBOM (Engineering BOM) | Drive prototype procurement | SCM สั่งผิด parts |
| Post-DVT | Draft pBOM | Validate supply chain readiness | Manufacturing delay |
| Post-PVT | pBOM (Production BOM) | Mass production + spare parts | Rework, yield loss |

eBOM → pBOM transformation ต้องมี digital thread ที่ไม่ขาด: engineering change ทุกชิ้นต้อง flow downstream ผ่าน ECO process ก่อน manufacturing จะ act [3]

---

### 2. Supply Risk Management

80% ของ PCB design ต้องการ component replacement บางชนิดระหว่าง development เนื่องจาก availability หรือ cost shift [7] — PM และ SCM ต้องคิดล่วงหน้า:

- **Long-lead identification**: ระบุ component ที่ lead time > 8 สัปดาห์ ตั้งแต่ Budgetary BOM phase
- **Dual sourcing**: ทุก critical component ควรมี approved alternate supplier ใน pBOM
- **Inventory buffering**: safety stock สำหรับ pilot + first production batch ป้องกัน allocation ตึงตัว
- **Obsolescence watch**: component ที่ end-of-life risk สูงต้องถูก flag ใน pBOM review cycle [7]

---

### 3. Cross-discipline Sync

HW, FW, SW ทำงาน parallel แต่มี dependency ที่ถ้า unmanaged จะ block progress:

| Dependency | ผลถ้าไม่ sync |
|-----------|--------------|
| FW ต้องการ DVT board ที่ HW stable | FW validation delayed หาก board ยัง respin |
| SW integration ต้องการ FW API stable | SW regression เมื่อ FW เปลี่ยน spec กลางทาง |
| SCM ต้องการ eBOM freeze ก่อน PO | Component late ถ้า eBOM ยัง draft |
| Field install ต้องการ SW release build | Deploy ช้าหาก SW ยัง feature branch |

PM ต้อง run **weekly cross-discipline sync** ใน Design + Prototype phases เพื่อ surface dependency block ก่อนที่มันจะ cascade

---

### 4. Change Control Discipline

ทุก change หลัง baseline ต้องผ่าน formal process — ไม่มี "แก้เงียบๆ":

1. **ECR raised** — engineer ระบุ problem, proposed change, impact บน BOM/schedule/cost
2. **Change Review Board** — PM + leads ประเมิน impact และ approve/reject
3. **ECO issued** — authorized change order สำหรับ HW/FW/SW/SCM
4. **BOM revision incremented** — eBOM/pBOM version update พร้อม change history [4]

**Gate-then-batch principle**: รวม ECO รอบเดียวหลัง gate review ดีกว่า ship ทีละ item เพราะลด interrupt ของ manufacturing และ SCM — แต่ safety/critical issue = immediate ECO เสมอ

---

## Caveats / Limits

- **Lean ≠ skip gates** — ลด document overhead ได้ แต่ gate exit criteria ต้องครบ; ทุก gate ที่ข้าม = technical debt ที่จ่ายทีหลัง
- **Respin budget**: plan สำหรับ 1–2 hardware respins — zero-respin planning เป็น wishful thinking สำหรับ product ที่มี custom HW
- **Cert lead-time**: FCC/CE certification ใช้เวลา 4–12 สัปดาห์ขึ้นกับ lab queue — ต้องเริ่ม application ก่อน DVT complete ไม่ใช่หลัง
- **pBOM lock risk**: SCM contract อาจ lock ราคา/spec ของ pBOM — PM ต้องทราบว่า component ใดที่ change หลัง lock จะ trigger ECO รอบใหม่ + cost renegotiation
- **Software-only SI**: กรณี SI project ที่ไม่มี custom HW phases EVT/DVT/PVT และ DFM/DFT ไม่ apply — แต่ eBOM (software component, license, dependency) ยังต้องบริหาร BOM maturity และ change control เช่นเดียวกัน

## References

1. Stage-Gate International. "The Stage-Gate Model: An Overview." https://www.stage-gate.com/blog/the-stage-gate-model-an-overview/
2. SCM Solution. "Understanding EVT, DVT, PVT in Product Development." https://scm-solution.com/understanding-evt-dvt-pvt-in-product-development/
3. PTC. "eBOM, mBOM, sBOM: Strengthening the Digital Thread." https://www.ptc.com/en/blogs/plm/ebom-vs-mbom-vs-sbom
4. PTC. "What Is an Engineering Change Request (ECR)?" https://www.ptc.com/en/blogs/plm/what-is-an-engineering-change-request
5. DEVICENEXT. "Design for Manufacturing (DFM) and Design for Testability (DFT)." https://www.devicenext.com/design-for-manufacturing-dfm-and-design-for-testability-dft-collaborating-with-designers-to-ensure-manufacturability-and-testability/
6. Zamann Pharma Support. "Site Acceptance Testing (SAT)." https://zamann-pharma.com/glossary/site-acceptance-testing-sat/
7. Altium. "Electronics Supply Chain Management: Best Practices." https://resources.altium.com/p/electronics-supply-chain-management-best-practices

## Key Takeaways

- Product Development ใน SI คือ chain of decision gates — แต่ละ phase มี 2–4 task หลักที่ต้อง "complete จริง" ก่อน unblock phase ถัดไป
- PO คือ official kick-off — งาน pre-sales ทั้งหมดก่อน PO คือ investment ที่อาจไม่ได้รับเงินถ้า deal ไม่ปิด; เขียน lean ไว้ก่อน
- BOM ไม่ใช่ document เดียว — evolve จาก budgetary → eBOM → pBOM ตาม phase และทุก version change ต้องมี ECO trail
- EVT/DVT/PVT ไม่ใช่ optional — เป็น systematic risk reduction ที่ทำให้ manufacturing เจอ defect ใน lab ไม่ใช่ที่ customer site
- DFM + DFT ลดต้นทุนและ field failure ได้จริง: DFM ลด manufacturing cost 15–20%, DFT ลด field failure rate ได้ถึง 50%
- SAT/UAT sign-off = invoice trigger — acceptance criteria ต้อง agree ตั้งแต่ pre-sales เพื่อป้องกัน "ลูกค้าปฏิเสธ sign" โดยไม่มี basis
- 80% ของ PCB design ต้องการ component swap ระหว่าง development — dual source + early long-lead PO คือ insurance ที่ถูกที่สุด
