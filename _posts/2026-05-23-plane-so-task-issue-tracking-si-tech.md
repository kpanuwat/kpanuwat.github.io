---
title: "Plane.so สำหรับงาน SI/Tech: Task & Issue Tracking ระดับ Engineering Team"
date: 2026-05-23 00:01:00 +0700
categories: [Engineering]
tags: [plane, task-tracking, issue-tracking, project-management, system-integrator, si, epic, wbs, sprint, milestone, agile, open-source, devops]
series: project-management-si
slides: true
---

{% include slide-link.html %}

{% include series-nav.html %}

## TL;DR

Plane.so คือ open-source project management tool ที่เหมาะกับงาน SI/Tech ในฐานะ **execution layer** สำหรับ engineering team — ใช้แตกงานแบบ Epic → Task → Sub-task ตาม WBS ผูกกับ phase และ milestone ได้ track issue/defect อย่างเป็นระบบ และสร้าง audit trail แบบ lightweight แต่ต้องใช้ร่วมกับ ERP/SCM, DevOps pipeline, และ document system เพื่อครอบ complexity จริงของ SI project

---

## Background / Why this matters

งาน SI (System Integration) ส่วนใหญ่มีทีม cross-functional อย่างน้อย 4–5 สาขา: ME, EE, FW, SW, QA — แต่ละทีมมี cadence และ deliverable ต่างกัน Hardware ใช้ระยะ validation นานหลายสัปดาห์ ขณะที่ SW iterate ทุก 2 วัน ถ้าไม่มีเครื่องมือกลาง ทีมก็พึ่ง spreadsheet หรือ chat log ซึ่ง track dependency ไม่ได้ และ audit trail หายหมดเมื่อโปรเจกต์ปิด

Plane.so เป็น open-source alternative ของ Jira, Linear, ClickUp — self-host ได้ผ่าน Docker Compose หรือ Helm (ไม่ต้องส่ง data ออก cloud ภายนอก) หรือจะใช้ SaaS plan ก็ได้ ข้อดีสำหรับ SI คือ **ออกแบบมาให้ยืดหยุ่น** — ไม่บังคับใช้ Scrum pure, รองรับ parallel cycle, custom properties, cross-project sub-work items ซึ่งตรงกับความเป็นจริงของโปรเจกต์ที่มีหลาย workstream

---

## Deep Dive

### Work Breakdown Structure: Epic → Task → Sub-task

Plane จัดลำดับชั้นงานไว้ดังนี้ [1][2]:

```
Workspace
└── Project (เช่น "SI-CustomerX-Line3")
    ├── Epic  ← phase หลัก (Design / Validation / Pilot / Deployment)
    │   ├── Work Item  ← task ระดับ deliverable
    │   │   ├── Sub-work item  ← รายละเอียดย่อย
    │   │   └── Sub-work item
    │   └── Work Item
    └── Epic  ← phase ถัดไป
```

Work item แต่ละรายการผูกกับ Epic ได้เพียง 1 อันเท่านั้น (one-to-one) ป้องกัน task ซ้ำข้าม phase [2] — แต่ sub-work item รองรับ **cross-project dependency** ได้ เช่น parent task ของ FW team มี sub-task ใน HW project ที่ต้องทำก่อน [4]

ข้อมูลที่กำหนดต่อ work item ได้แก่: owner (Assignee), Priority (Urgent/High/Normal/Low), Due Date, State (Backlog → In Progress → Done), Labels, Custom Properties (text/number/dropdown/boolean/date) [2][4]

Epic จะมี color-coded progress bar แสดง % complete แยกตาม state (Backlog, Started, Completed) [2] และสถานะ Epic-level: **On Track / At Risk / Off Track** สื่อสารกับ stakeholder ได้ทันที

### Phase-Based Milestones ด้วย Modules

สำหรับ SI project ที่มี milestone กำหนดไว้ชัดเจน (PDR, EVT Pass, DVT Pass, SAT) ใช้ **Modules** แทนการสร้าง Epic ใหม่ต่อ milestone [3]:

| Module | ตัวอย่างใช้งาน SI | State ที่ Plane รองรับ |
|--------|------------------|------------------------|
| Design Phase | HW layout, FW architecture, SW spec | Backlog → Planned → In Progress |
| EVT (Engineering Validation) | Build, PCBA, FW flash, DVT handoff | In Progress → Completed |
| DVT (Design Validation) | QA test suite, reliability, ECO | In Progress → Paused → Completed |
| Pilot | Customer site deployment, SAT | Planned → In Progress → Completed |

Module แสดง progress ตาม state รวมของ work item ทั้งหมดใน module และรองรับ layout หลายแบบ (List, Gallery, Timeline) [3] — Timeline view แสดง dependency arrow เปลี่ยนสีแดงเมื่อ scheduling conflict เกิดขึ้น [4]

Work item เดียวสามารถอยู่ใน **หลาย Module พร้อมกัน** ได้ (เช่น อยู่ใน "EVT" และ "Supplier Qualification" พร้อมกัน) [3]

### Issue Tracking: Defect, Bug, Field Issue

ใช้ **Labels** และ **Custom Properties** จำแนกประเภท issue [2][4]:

```
Label สำหรับ SI:
  - HW-Defect     EE-Board       FW-Bug
  - SW-Regression QA-Critical    Field-Issue
  - SCM-Delay     Cert-Block     ECO-Pending
```

ทุก work item มี **History tab** — บันทึกการเปลี่ยนแปลง property ทุกรายการ (field, before → after, user, timestamp) เป็น immutable changelog [4] ใช้แทน meeting note บางส่วนได้ นอกจากนี้ **Description Edit History** บันทึกการแก้ spec พร้อม timestamp และ user attribution [4]

**Transition tab** (time-in-state tracking) แสดง badge ว่า issue อยู่ใน state "In Review" กี่วัน — bottleneck identifier ที่ช่วย engineering manager ตรวจสอบว่า task ค้างที่ขั้นตอนไหน [4]

**Dependencies** ที่ Plane รองรับ [4]:
- `Blocked by` / `Blocking` — สำหรับ hardware component ที่ต้องมาก่อน FW integration
- `Starts Before` / `Finishes After` — กำหนด scheduling constraint ข้าม discipline

### Cycles / Sprints สำหรับ Engineering Teams

Cycle คือ time-boxed period คล้าย Agile sprint [5] แต่ยืดหยุ่นกว่าสำหรับ hardware/software mixed team:

| Feature | ประโยชน์สำหรับ SI |
|---------|-------------------|
| Cycle duration: 1/2/3 weeks | SW ใช้ 2 สัปดาห์, HW ใช้ 4 สัปดาห์ได้พร้อมกัน |
| Parallel Cycles (Enterprise) | HW/SW/QA run cycle แยกกัน overlap กัน |
| Auto-rollover incomplete items | Task ที่ยังไม่เสร็จย้ายไป cycle ถัดไปอัตโนมัติ |
| Burn-down + Build-up charts | ดู "Leading" vs "Trailing" ทันที [5] |
| Auto-scheduling (Business plan) | สร้าง cycle schedule ล่วงหน้าพร้อม cooldown period |

PM ใช้ Cycle เป็น **sprint review rhythm** — ทุก cycle end ดู chart ว่า team leading/trailing และ transfer item ที่ค้างด้วย 2 click

### Labels และ Tag Strategy สำหรับ Cross-Functional Team

แนะนำ label taxonomy แบบนี้สำหรับ SI team:

```
Discipline:   [HW] [EE] [FW] [SW] [QA] [SCM] [PM]
Severity:     [Critical] [Major] [Minor]
Type:         [Bug] [Defect] [Enhancement] [Cert-Item]
Coordination: [ERP-Needed] [Supplier-Action] [ECO-Pending]
```

ใช้ร่วมกับ **Views** (saved filter + layout) — สร้าง View ต่อ discipline เช่น "QA Open Issues", "FW Blocked Tasks" ให้แต่ละทีมเห็น queue ตัวเองโดยไม่ต้องนำ tag ออก [1]

### Activity Log เป็น Lightweight Audit Trail

สำหรับ project ที่ต้องการ traceability (ISO, safety, customer audit):

- **History tab**: ทุก property change มี user + timestamp — ใช้แทน "ใครอนุมัติ ECO?" ได้
- **Comment thread**: discussion ต่อ task อยู่กับ task ไม่หายไปใน chat
- **Description Edit History**: spec revision tracking
- **Transition tab**: เวลา cycle time ต่อ state — evidence สำหรับ process improvement

ข้อจำกัด: Plane ไม่ใช่ document control system — ไม่มี sign-off workflow แบบ formal (ต้องใช้ document system ต่างหากสำหรับ spec approval)

### Integration Gaps: สิ่งที่ Plane ไม่ครอบ

Plane เป็น **execution/control layer** — ต้องใช้ร่วมกับ [6]:

| Domain | เครื่องมือที่ต้องใช้เพิ่ม | สิ่งที่ Plane ไม่มี |
|--------|--------------------------|---------------------|
| Supply Chain / BOM | ERP (SAP, Odoo), SCM tool | BOM management, PO tracking, lead time |
| Procurement | ERP / e-procurement | Vendor management, cost approval |
| DevOps / CI-CD | GitHub Actions, GitLab CI | Pipeline trigger, artifact registry |
| Document Control | Confluence, SharePoint, PLM | Formal sign-off, version control of specs |
| Cost / Budget | ERP, finance tool | CapEx/OpEx tracking, cost variance |
| Compliance | QMS tool (IFS, ETQ) | CAPA, nonconformance formal workflow |

**Git integration** ที่มีใน Plane: Copy Branch Name จาก work item (format `username/PROJ-1`) เพื่อ link branch กับ issue [4] — ไม่ใช่ full CI/CD integration แต่ช่วย trace commit → task ได้

---

## User Guide (Step-by-Step)

### Setup SI Project บน Plane

**1. สร้าง Workspace และ Project**
- สร้าง Workspace ชื่อ organization (เช่น "SynTech")
- สร้าง Project ต่อ engagement: `SI-CustomerX-Line3`
- กำหนด Members + Roles (Admin = PM, Member = ทีม discipline)

**2. กำหนด States ตาม workflow SI**
```
Backlog → Planned → In Progress → In Review → Done → Cancelled
```
ใช้ Project Settings → States เพื่อเพิ่ม/ลบ state

**3. สร้าง Labels ตาม taxonomy**
Project Settings → Labels → สร้าง group: Discipline, Severity, Type

**4. สร้าง Epics ตาม phase**
```
Epic: Design Phase     (due: สิ้นสุด week 4)
Epic: EVT              (due: สิ้นสุด week 10)
Epic: DVT              (due: สิ้นสุด week 16)
Epic: Pilot            (due: สิ้นสุด week 20)
```

**5. สร้าง Modules ตาม milestone**
```
Module: PDR Sign-off   → work items: design review tasks
Module: EVT Pass       → work items: build + test tasks
Module: SAT Completed  → work items: deployment + handoff
```

**6. Break down Work Items ตาม WBS**
ต่อ Epic → สร้าง Work Item ต่อ deliverable → สร้าง Sub-work item ต่อ step ย่อย
กำหนด: Assignee (PIC), Priority, Due Date, Labels

**7. ใส่ Dependencies**
Work item → Properties → Add Relation → Blocked by / Starts Before
ดู dependency ใน Timeline View (แสดง Gantt-like)

**8. สร้าง Cycles ต่อ discipline**
```
Cycle: SW Sprint 1    (2 สัปดาห์)
Cycle: HW Build 1     (4 สัปดาห์)
```
ใช้ Parallel Cycles (Enterprise) ถ้า schedule overlap

**9. สร้าง Views ต่อทีม**
```
View: QA Open Issues    → filter: Labels=[QA], State≠Done
View: Blocked Tasks     → filter: Relation=Blocked by, State≠Done
View: PM Dashboard      → filter: Assignee=PM, all projects
```

**10. Daily tracking**
- ใช้ Burn-down chart ต่อ Cycle ดู pace
- ใช้ Epic progress bar ดู phase completion
- ใช้ Module status ดู milestone readiness
- ใช้ Transition tab flag task ที่ค้าง state นาน

---

## Caveats / Limits

- **Parallel Cycles เป็น Enterprise feature** — ถ้าใช้ Free/Business plan จะ run ได้ cycle เดียวต่อ project ในเวลาเดียวกัน
- **Auto-scheduling เป็น Business plan** — Free plan ต้องสร้าง cycle manual
- **ไม่มี formal approval workflow** — ไม่เหมาะเป็น document control หรือ ECO sign-off system
- **ไม่มี BOM/cost module** — ต้องใช้ ERP คู่ขนาน
- **Git integration จำกัด** — มีแค่ branch name copy, ไม่ใช่ full bi-directional sync กับ GitHub/GitLab
- **Self-host ต้องดูแล infra เอง** — Docker Compose setup ไม่ยาก แต่ backup + update เป็นความรับผิดชอบทีม DevOps
- **Mobile app** (iOS/Android) มีให้ แต่ feature ยังด้อยกว่า web บางส่วน

---

## References

1. [Core concepts | Plane](https://docs.plane.so/introduction/core-concepts)
2. [Organize related work items with Epics | Plane](https://docs.plane.so/core-concepts/issues/epics)
3. [Organize project features with Modules | Plane](https://docs.plane.so/core-concepts/modules)
4. [Manage work items | Plane](https://docs.plane.so/core-concepts/issues/overview)
5. [Manage sprints and track agile workflows | Plane](https://docs.plane.so/core-concepts/cycles)
6. [GitHub - makeplane/plane](https://github.com/makeplane/plane)
7. [Epics and Initiatives | Plane](https://plane.so/project-work-management/epics-initiatives)

---

## Key Takeaways

- **Plane = execution layer** สำหรับ engineering team — ไม่ใช่ full PM suite แต่เป็น hub ที่ทำให้ทีมเห็นภาพ task/issue ร่วมกัน
- **Epic → Task → Sub-task** map ตรงกับ WBS ของ SI project — ผูก owner, priority, due date, dependency ต่อทุก work item ได้
- **Modules** = milestone tracking — ตั้งชื่อว่า PDR, EVT Pass, SAT แล้วกำหนด work item ที่ต้อง complete ก่อน milestone จะ done
- **Cycles** = sprint rhythm สำหรับ SW/FW — Parallel Cycles รองรับ HW timeline ที่ยาวกว่า SW
- **Labels + Views** ให้แต่ละ discipline มี queue ตัวเอง โดยไม่ต้องแยก project
- **History tab + Transition tab** = lightweight audit trail สำหรับ process review และ bottleneck identification
- **ต้อง integrate** กับ ERP (BOM/procurement), DevOps pipeline, และ document system — Plane ไม่ได้ครอบทุก domain แต่ถ้าใช้เป็น execution layer มัน fit งาน SI ได้ดี
