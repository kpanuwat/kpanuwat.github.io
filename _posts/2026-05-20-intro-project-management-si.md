---
title: "Project Management เบื้องต้น สำหรับงาน SI (System Integrations)"
date: 2026-05-20 00:01:00 +0700
categories: [Engineering]
tags: [project-management, system-integration, si, pmbok, agile]
series: project-management-si
slides: true
---

{% include series-nav.html %}

{% include slide-link.html %}

## TL;DR

งาน SI (System Integration) ซับซ้อนกว่า software project ทั่วไป เพราะต้องประสาน vendors หลายเจ้า, ระบบหลายตัว, และ stakeholders หลายฝ่ายพร้อมกัน บทความนี้อธิบายกรอบ PM เบื้องต้นที่ใช้ได้จริง ตั้งแต่ Initiation ถึง Go-Live — พร้อม deliverables หลัก (SOW, BRD, RTM) และ pitfalls ที่พบบ่อย

## Background / Why this matters

ใน software project ทั่วไป ทีมมักควบคุม codebase ได้เต็มที่ — เขียนเอง, deploy เอง, rollback เอง แต่ใน SI ต้องเชื่อมระบบที่แต่ละตัวมี owner, เทคโนโลยี, และ timeline ของตัวเอง เราไม่ได้ควบคุมทุก piece

ตาม Wikipedia [1] และ PMI [7] ความท้าทายหลักของ SI คือ:

- **Multi-vendor coordination** — แต่ละ vendor มี agenda, tool, และ SLA ต่างกัน ประสานงานผิดพลาดครั้งเดียวทำให้ timeline ทั้งโปรเจกต์เลื่อน
- **Integration risk** — จุดเชื่อมต่อระหว่างระบบคือจุดที่ bugs ซ่อนตัวได้มากที่สุด ระบบแต่ละตัวอาจผ่าน unit test แต่พอเชื่อมกันแล้วมีปัญหา
- **Scope creep** — stakeholders มักเห็นความต้องการจริงหลังจากเห็นระบบทำงาน ทำให้ requirement เพิ่มระหว่างทางโดยไม่ได้วางแผน [9]

PM ที่ดีใน SI จึงไม่ได้แค่ track timeline — ต้องเป็น "กาว" ที่ประสาน business, IT, และ vendors ทุกฝ่ายให้เดินไปทิศทางเดียวกัน

## Deep Dive

### Framework ที่เหมาะกับ SI: Hybrid Agile-Waterfall

SI projects มีสองส่วนที่ต้องการ approach ต่างกัน [10]:

| ส่วน | Approach | เหตุผล |
|------|----------|--------|
| Architecture, vendor contracts, integration specs | Waterfall / Predictive | ต้องกำหนดชัดก่อน vendor เริ่มงาน |
| Custom development, internal testing, bug fixes | Agile / Iterative | ต้องปรับได้เมื่อพบ integration issues |

PMBOK (Project Management Body of Knowledge) [2] คือ framework ที่ใช้ได้กับ SI ทุกขนาด — ออกแบบมาให้ flexible พอที่จะ customize ตาม context ของแต่ละโปรเจกต์

### 5 Phases ของ SI Project (PMBOK Framework)

**Phase 1 — Initiating**

เป้าหมาย: authorize โปรเจกต์อย่างเป็นทางการและระบุ stakeholders หลัก

SI-specific tasks:
- ระบุ vendors ทั้งหมดและ systems ที่ต้องเชื่อมต่อ
- ประเมิน architecture readiness ของแต่ละระบบ (API พร้อมไหม? documentation มีไหม?)
- จัดทำ Project Charter พร้อม initial scope และ high-level budget

---

**Phase 2 — Planning**

เป้าหมาย: สร้าง roadmap ละเอียดก่อนเริ่ม execution

Deliverables หลัก 4 ชิ้นที่ขาดไม่ได้ใน SI:

**SOW (Statement of Work)** [3]
สัญญาที่ระบุ scope, deliverables, timelines, และ acceptance criteria กับทุก vendor — ป้องกัน scope creep และสร้าง accountability ชัดเจน

**BRD (Business Requirements Document)** [4]
แปลง business goals เป็น requirements ที่ technical teams และ vendors ใช้งานได้จริง มักรวม "As-Is" (ระบบปัจจุบัน) และ "To-Be" (ระบบที่ต้องการ) เพื่อให้ทุกฝ่ายเห็นภาพเดียวกัน

**RTM (Requirements Traceability Matrix)** [5]
Matrix ที่ map requirement → test case → deliverable ใช้ยืนยันว่าทุก requirement ถูก implement และ test ครบ — critical มากใน SI เพราะ requirements มักมาจากหลาย vendors

**SIT Plan (System Integration Test Plan)** [6]
กำหนด scope, approach, resources, และ timeline ของการ test integration — รวม entry criteria (unit test ผ่านแล้ว, test environment พร้อม, test data prepared) และ exit criteria (pass rate ที่ยอมรับได้)

---

**Phase 3 — Executing**

เป้าหมาย: ทำงานจริงตาม plan

SI-specific concerns:
- ประสาน vendor รายงานความคืบหน้าตาม SOW milestones
- Verify integration interfaces ตาม spec ก่อนเริ่ม testing (อย่า assume ว่า vendor ทำถูก)
- เตรียม test data ที่ simulate production scenarios จริง ไม่ใช่แค่ happy path

---

**Phase 4 — Monitoring & Controlling**

เป้าหมาย: track progress และ adjust อย่างต่อเนื่อง ไม่รอให้ปัญหาใหญ่โต

- ติดตาม integration points ที่ยังไม่ complete (ทำ integration tracker แยก)
- จัดการ Change Requests ผ่าน formal **Change Control Board (CCB)** — ทุก change ต้องมี impact analysis ก่อน approve
- Monitor vendor performance ตาม contract terms — อย่ารอให้ deadline ผ่านแล้วค่อย escalate

---

**Phase 5 — Closing**

เป้าหมาย: Go-Live อย่างมั่นใจ พร้อม rollback plan รองรับ

**Go-Live Checklist** [8] — items ที่ขาดไม่ได้:

| Item | หมายเหตุ |
|------|---------|
| UAT sign-off จาก business owners ทุกฝ่าย | ต้องได้ลายเซ็น ไม่ใช่แค่ verbal OK |
| SIT completion — real transactions | ไม่ใช่แค่ connectivity test |
| Data migration validation | verify ข้อมูลหลัง migrate ครบและถูกต้อง |
| Rollback plan + cutover criteria | กำหนดชัดว่า "fail condition" คืออะไร |
| Hypercare support model | ใครดู support กี่วันหลัง go-live |

### Tools ที่ SI PMs ใช้บ่อย

| Category | Tools |
|----------|-------|
| Project planning | MS Project, Jira, Monday.com |
| Documentation & collaboration | Confluence, SharePoint |
| Test management | TestRail, Jira Test Management |
| Communication | Teams, Slack, MOM (Minutes of Meeting) |

Integration ระหว่าง tools ก็สำคัญ — บาง organization ใช้ MS Project สำหรับ high-level planning และ Jira สำหรับ detailed task tracking โดยมี middleware sync ข้อมูลระหว่างกัน [11]

## Caveats / Limits

**Integration testing ≠ connectivity testing**
ความผิดพลาดที่พบบ่อยที่สุดใน SI go-live [8]: เชื่อว่าระบบ integrate กันแล้วเพราะ API response 200 แต่จริงๆ ต้องทดสอบด้วย real transactions end-to-end เช่น EDI pipelines, banking connections, CRM sync ต้องผ่าน production-like scenarios ก่อน go-live เสมอ

**Scope creep ใน SI รุนแรงกว่า projects ทั่วไป** [9]
เพราะ stakeholders เห็นความต้องการจริงหลังจากเห็นระบบทำงาน การมี SOW ที่ชัดเจนและ formal CCB จึงสำคัญมาก ทุก change ต้องมี impact analysis และ approval ก่อน implement

**Vendor management ต้องเป็น formal process** [7]
กำหนดให้แต่ละ vendor มี SPOC (Single Point of Contact) ฝั่งตัวเองชัดเจน และกำหนด escalation path ป้องกันการ "แล้วแต่ vendor" เมื่อเกิดปัญหา

**PMBOK ไม่ใช่ silver bullet**
PMBOK ให้ framework แต่ไม่ได้บอกวิธี apply กับ context ของแต่ละโปรเจกต์ SI projects ขนาดเล็กอาจใช้ PMBOK แค่บางส่วนและเติม Agile practices ก็ได้ ขึ้นอยู่กับ complexity และ vendor maturity

## References

1. Wikipedia — [System integration](https://en.wikipedia.org/wiki/System_integration)
2. Wikipedia — [Project Management Body of Knowledge](https://en.wikipedia.org/wiki/Project_Management_Body_of_Knowledge)
3. ProjectManager.com — [What Is a Statement of Work?](https://www.projectmanager.com/blog/statement-work-definition-examples)
4. ProjectManager.com — [How to Write a Business Requirements Document (BRD)](https://www.projectmanager.com/blog/business-requirements-document)
5. ProjectManager.com — [How to Make a Requirements Traceability Matrix (RTM)](https://www.projectmanager.com/blog/requirements-traceability-matrix)
6. Perforce — [System Integration Test Plan (SIT Testing) Checklist](https://www.perforce.com/blog/alm/SIT-checklist)
7. PMI — [Successful management of vendors in IT projects](https://www.pmi.org/learning/library/successful-management-vendors-projects-3509)
8. Microsoft Learn — [Use the go-live checklist to make sure your solution is ready](https://learn.microsoft.com/en-us/dynamics365/guidance/implementation-guide/prepare-go-live-checklist)
9. Connecting Software — [Scope Creep in Integration Projects](https://www.connecting-software.com/blog/scope-creep-in-integration-projects-new-approaches/)
10. Toptal — [Hybrid Project Management: Agile and Waterfall](https://www.toptal.com/project-managers/agile/hybrid-project-management-a-middle-ground-between-agile-and-waterfall)
11. The Project Group — [Jira Integration with MS Project, SAP and other PPM Tools](https://www.theprojectgroup.com/en/middleware/jira-integration)

## Key Takeaways

- SI projects ซับซ้อนกว่า software projects ทั่วไป เพราะต้องประสาน vendors หลายเจ้าและระบบที่มี owner ต่างกัน
- Hybrid Agile-Waterfall เหมาะกับ SI มากที่สุด — ใช้ Waterfall สำหรับ vendor contracts/specs, Agile สำหรับ development/testing
- Deliverables ที่ขาดไม่ได้: SOW, BRD, RTM, SIT Plan, และ Go-Live Checklist
- Integration testing ต้องใช้ real transactions ไม่ใช่แค่ connectivity — failure ที่พบบ่อยที่สุดคือ go-live โดยไม่ test end-to-end จริง
- Scope creep คือ risk อันดับหนึ่ง — ป้องกันด้วย SOW ที่ชัดเจนและ formal Change Control Board (CCB)
- กำหนด SPOC (Single Point of Contact) ทั้งฝั่งตัวเองและ vendor เพื่อป้องกัน communication breakdown
- PM ใน SI ต้องมองภาพรวมทุก subsystem ไม่ใช่แค่ track tasks ของทีมตัวเอง
