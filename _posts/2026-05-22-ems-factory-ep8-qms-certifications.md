---
title: "EMS Factory EP8: QMS & Certifications (ISO 9001, IATF 16949, ISO 13485)"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [qms, iso9001, iatf16949, iso13485, certifications, ems, manufacturing, quality]
series: ems-factory
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

ISO 9001, IATF 16949, และ ISO 13485 คือ QMS certification สามชั้นที่ EMS ใช้พิสูจน์ว่า quality system ของตนเองเชื่อถือได้ ISO 9001 เป็น baseline สำหรับทุก industry, IATF 16949 เป็น automotive extension ที่กำหนด core tools 5 ชุด, ISO 13485 เป็น medical device version ที่โฟกัสที่ patient safety และ regulatory compliance — OEM ต้องตรวจสอบ scope ของ certificate ไม่ใช่แค่ว่ามี badge หรือเปล่า

## Background / Why this matters

เวลา OEM เลือก EMS ส่วนหนึ่งของ due diligence คือการดู certification ที่ EMS ถืออยู่ แต่ certificate ไม่ได้บอกทุกอย่าง — EMS อาจถือ ISO 9001 แต่ scope ครอบคลุมแค่ warehouse ไม่ใช่ production line, หรือ certificate หมดอายุโดยที่ client ไม่รู้ หรือผ่านการ audit ด้วย "checklist mentality" ที่ไม่สะท้อน actual process discipline จริงๆ

QMS (Quality Management System) certification ถูกออกแบบมาเพื่อเป็น "common language" ระหว่าง OEM กับ EMS ในเรื่อง quality expectation เหมือนกับที่ IPC standard ทำหน้าที่นี้ในเรื่อง inspection criteria (ดู EP6) certification ทำหน้าที่เดียวกันในระดับ systemic — ยืนยันว่า process, documentation, และ culture ของ EMS เป็นไปในทิศทางที่ถูกต้อง

สำหรับ OEM ที่ผลิต product สำหรับ automotive หรือ medical segment การเลือก EMS ที่ไม่ถือ IATF 16949 หรือ ISO 13485 ที่เกี่ยวข้องอาจทำให้ผลิตภัณฑ์ไม่สามารถขาย หรือไม่ผ่าน regulatory approval ในตลาดปลายทางได้

## Deep Dive

### ISO 9001:2015 — Baseline QMS Framework

ISO 9001 คือ international standard สำหรับ Quality Management System ที่ใช้ได้กับทุก organization ทุก industry เป็น foundation ที่ IATF 16949 และ ISO 13485 สร้างอยู่บน

**โครงสร้าง 10 Clause ตาม PDCA:**

| Clause | หัวข้อ | PDCA Phase |
|---|---|---|
| 4 | Context of the organization | Plan |
| 5 | Leadership | Plan |
| 6 | Planning | Plan |
| 7 | Support (resources, competence, communication) | Plan |
| 8 | Operation (production, service delivery) | Do |
| 9 | Performance evaluation (internal audit, review) | Check |
| 10 | Improvement (corrective action, continual improvement) | Act |

**สิ่งที่ ISO 9001 กำหนด:**
- **Documented procedures**: กระบวนการที่สำคัญต้องมีเอกสารและมีการ control
- **Management review**: top management ต้อง review QMS effectiveness เป็นระยะ
- **Risk-based thinking**: วิเคราะห์ risk ที่มีต่อ quality objective และวางแผนรับมือ
- **Customer satisfaction**: วัดและ monitor ว่า customer satisfied หรือเปล่า
- **Continual improvement**: ระบบต้องดีขึ้นเรื่อยๆ ไม่ใช่แค่ maintain

**สิ่งที่ ISO 9001 ไม่กำหนด (เพราะยืดหยุ่นตาม context):**
- Lean หรือ Six Sigma ไม่ได้ required โดย standard — แต่ EMS tier-1 มักใช้เป็น tool ในการบรรลุ continual improvement
- ไม่มี prescription ว่าต้องใช้ tool อะไรเฉพาะเจาะจง (ต่างจาก IATF 16949 ที่กำหนด core tools ชัดเจน)

### IATF 16949:2016 — Automotive QMS Extension

IATF 16949:2016 (แทน ISO/TS 16949:2009) คือ QMS standard เฉพาะสำหรับ automotive supply chain พัฒนาโดย IATF (International Automotive Task Force) ซึ่งประกอบด้วยผู้ผลิตรถยนต์รายใหญ่ — BMW, Chrysler, Fiat, Ford, GM, PSA Peugeot Citroën, Renault, Volkswagen

**จุดสำคัญ: IATF 16949 ไม่สามารถ standalone ได้** — organization ต้องได้รับ ISO 9001 ก่อนหรือพร้อมกัน จึงจะสามารถ certify IATF 16949 ได้ นี่คือความต่างจาก ISO 13485 ซึ่งมีสถานะ independent มากกว่า

**Automotive Core Tools 5 ชุด (mandated โดย IATF 16949):**

| Core Tool | ย่อ | หน้าที่ |
|---|---|---|
| Advanced Product Quality Planning | APQP | วางแผน quality ตั้งแต่ design phase ก่อน production |
| Failure Mode and Effects Analysis | FMEA | ระบุ failure mode ที่อาจเกิดและ effect ต่อ system |
| Statistical Process Control | SPC | monitor process variation ด้วย control chart แบบ real-time |
| Measurement Systems Analysis | MSA | ยืนยันว่า measurement tool เชื่อถือได้ (Gauge R&R) |
| Production Part Approval Process | PPAP | กระบวนการอนุมัติ parts จาก supplier ก่อนเข้า production จริง |

**APQP 5 Phases:**
1. Plan and Define Program — voice of customer, product/process benchmark
2. Product Design and Development — DFMEA, design verification
3. Process Design and Development — PFMEA, control plan draft
4. Product and Process Validation — process capability study, PPAP submission
5. Launch, Assessment and Continuous Improvement — production monitoring, lessons learned

**Customer-Specific Requirements (CSR):** นอกจาก IATF 16949 requirements, automotive OEM แต่ละรายมี CSR เพิ่มเติม — Ford มี Q1, GM มี BIQS, Toyota มี Toyota Supplier Quality Standards EMS ที่รับ automotive job ต้องทำความเข้าใจ CSR ของ OEM นั้นๆ โดยเฉพาะ

### ISO 13485:2016 — Medical Device QMS

ISO 13485:2016 คือ QMS standard สำหรับ medical device industry ครอบคลุมทุก organization ในห่วงโซ่การผลิต — ผู้ออกแบบ, ผู้ผลิต, contract manufacturer (EMS), supplier ของ component, distributor, authorized representative

**ความต่างจาก ISO 9001 ที่สำคัญ:**
- ISO 13485 โฟกัสที่ **patient safety** และ **regulatory compliance** — ไม่ใช่ continual improvement แบบ open-ended เหมือน ISO 9001
- ความสอดคล้องกับ ISO 9001 **ไม่ได้** หมายความว่าสอดคล้องกับ ISO 13485 — ต้องได้รับการ certify แยกกัน
- มีข้อกำหนดเรื่อง documentation ที่ strict กว่ามาก

**Documentation ที่ ISO 13485 กำหนด:**
- **Device History Record (DHR)**: บันทึกทุก batch ว่าผลิตตาม specification ไหม (เทียบกับ Device Master Record ที่เป็น "design")
- **Device Master Record (DMR)**: เอกสาร design และ specification อ้างอิงสำหรับ product
- **Quality Manual + Procedures + Work Instructions**: สามระดับ documentation ลงลึกจนถึง step-by-step instruction สำหรับ operator

**Core requirements:**
- **Risk management**: ตาม ISO 14971 ตลอด product lifecycle — ไม่ใช่แค่ design phase
- **Process validation**: process ที่ output ไม่สามารถ verify ได้ด้วย inspection ปกติ ต้องผ่าน validation (เช่น sterilization, potting, conformal coating)
- **Software validation**: software ทุกตัวที่ใช้ใน production หรือ quality system ต้อง validate
- **CAPA (Corrective and Preventive Action)**: ระบบจัดการ nonconformance แบบ closed-loop — ต้องระบุ root cause, corrective action, และยืนยันว่า action effective

**การใช้งาน FMEA ใน ISO 13485:**
- DFMEA (Design FMEA): ระบุ risk จาก design decisions
- PFMEA (Process FMEA): ระบุ risk จาก production process
- ทั้งสองต้องเป็น living document ที่ update เมื่อมี design change หรือ nonconformance ใหม่

### ความสัมพันธ์ระหว่าง Standards

```
ISO 9001:2015 (Baseline)
├── IATF 16949:2016 (ต้องมี ISO 9001 ก่อน)
│   └── เพิ่ม: APQP, FMEA, SPC, MSA, PPAP, CSR compliance
└── ISO 13485:2016 (independent แต่ based on ISO 9001 principles)
    └── เพิ่ม: patient safety, DHR/DMR, risk mgmt (ISO 14971), CAPA, process validation
```

EMS tier-1 ที่รับงานหลาย segment อาจถือ certification สามชุดพร้อมกัน:
- ISO 9001: general commercial electronics
- IATF 16949: automotive ECU, sensor module
- ISO 13485: medical device, wearable health monitor

แต่ละ certification มี audit cycle และค่าใช้จ่าย maintain แยกกัน ดังนั้น EMS tier-2 อาจเลือกถือเฉพาะที่ตรงกับ customer segment หลัก

### Certification Lifecycle & Audit Cycle

กระบวนการ certify ใหม่ (initial certification) ประกอบด้วย:

**Stage 1 Audit — Documentation Review:**
Certification Body (CB) เช่น BSI, SGS, TÜV ตรวจสอบว่า QMS documentation ของ EMS ครอบคลุมตาม standard หรือเปล่า — Quality Manual, Procedures, Risk Register ต้องสมบูรณ์ก่อนไปขั้น 2

**Stage 2 Audit — On-Site Assessment:**
Auditor มาที่ site ตรวจว่า document สะท้อน actual practice จริงหรือเปล่า — สัมภาษณ์ operator, ตรวจ record, ดู production line, ตรวจ internal audit records ถ้าผ่านทั้งสอง stage → ออก certificate

**Surveillance Audits (ประจำปี):**
หลัง certify แล้ว ต้องผ่าน surveillance audit ทุกปีเพื่อยืนยัน ongoing compliance ค่าใช้จ่าย surveillance ประมาณ 20-30% ของค่า initial certification

**Recertification (ทุก 3 ปี):**
Certificate มีอายุ 3 ปี หลังจากนั้นต้องทำ full recertification audit ที่ครอบคลุม QMS ทั้งหมดอีกครั้ง ถ้า standard ออก revision ใหม่ (เช่น ISO 9001:2015 แทน 2008) ต้องทำ transition audit ด้วย

### สิ่งที่ OEM ต้องตรวจสอบเมื่อ Choose EMS

**ตรวจสอบ Certificate ที่ได้รับ:**
- ขอดู certificate ตัวจริง — ตรวจ issue date, expiration date, และที่สำคัญ **scope**
- Scope คือ paragraph เล็กๆ ที่ระบุว่า certification ครอบคลุมกิจกรรมอะไรที่ site ไหน — EMS อาจถือ ISO 9001 แต่ scope ครอบคลุมแค่ warehouse logistics ไม่ใช่ PCB assembly

**Red Flags:**
- Certificate หมดอายุ หรือ expiry date ใกล้มาก
- EMS ลังเลที่จะแสดง certificate หรือ scope
- ใช้ "checklist mentality" ในการตอบคำถาม QMS — ตอบตาม standard text แต่ไม่สามารถอธิบาย how it applies to their floor
- ไม่มี internal audit records หรือ CAPA log ให้แสดง

**Site Visit คือ Gold Standard:**
Certificate ไม่ได้ guarantee on-the-floor competence — OEM ควรไป audit site เองหรือส่ง third-party auditor เพื่อ verify ว่า:
- Operator รู้จัก QMS procedure ที่ตัวเองต้องทำ
- Record keeping ทำจริง ไม่ใช่สร้างย้อนหลังก่อน audit
- Corrective action จาก previous nonconformance ได้รับการ close อย่างแท้จริง

**สำหรับ Automotive:**
ถาม EMS ว่ามี experience กับ Customer-Specific Requirements ของ automotive OEM ที่เกี่ยวข้องหรือเปล่า — ถือ IATF 16949 ไม่ได้แปลว่ารู้จัก Ford Q1 หรือ Toyota SQS

**สำหรับ Medical:**
ถาม EMS ว่าเคย pass ใน FDA inspection หรือ EU MDR audit หรือเปล่า — ISO 13485 certification เป็น prerequisite แต่ regulatory body inspection คือ test จริง

## Caveats / Limits

- **Certification ≠ Quality**: EMS ที่ certify แล้วยังสามารถ produce defect ได้ — certification ยืนยันว่า system ดี ไม่ใช่ว่า output ดีทุกครั้ง
- **Scope limitation**: ต้องอ่าน scope ทุกครั้ง — certification อาจครอบคลุมเฉพาะบาง product line, บาง process, หรือบาง site
- **Transition lag**: เมื่อ standard ออก revision ใหม่ EMS มีช่วงเวลา transition — ถามว่า currently certified กับ revision ใด (เช่น IATF 16949:2016 ไม่ใช่ ISO/TS 16949:2009)
- **CSR ไม่ถูก cover**: IATF 16949 certification ไม่รับประกันว่า EMS comply กับ CSR ของ OEM ใดๆ — ต้องตรวจ CSR compliance แยก
- **Surveillance gap**: ระหว่าง surveillance audit EMS อาจ drift จาก procedure — continuous monitoring ผ่าน customer audit หรือ quality scorecard สำคัญ

## References

1. [EMS Certifications in Electronics Manufacturing: Ensuring Quality, Compliance and Reliability — TSTRONIC](https://tstronic.eu/en/ems-certifications-in-electronics-manufacturing-ensuring-quality-compliance-and-reliability/)
2. [Quality Standards and Accreditations within Electronics Manufacturing — Escatec](https://www.escatec.com/blog/quality-standards-and-accreditations-within-electronics-manufacturing)
3. [The Importance of ISO 9001 and ISO 13485 Certifications in Electronics Manufacturing — August Electronics](https://www.aeicm.com/news/iso-9001-iso-13485-certifications-electronics-manufacturing/)
4. [ISO 9001 & IATF 16949 Certification: What's the Difference? — DeGrandson](https://info.degrandson.com/blog/iso-9001-foundation-of-iatf-16949)
5. [IATF 16949: Automotive Quality Management System — Quality-One](https://quality-one.com/iatf-16949/)
6. [Quality Core Tools: APQP, PPAP, FMEA, MSA, SPC — AIAG](https://www.aiag.org/expertise-areas/quality/quality-core-tools)
7. [ISO 13485 for Medical Devices QMS: The Complete Guide — PTC](https://www.ptc.com/en/blogs/medtech/iso-13485-qms-medical-device)
8. [ISO 13485: Definition, Requirements, and Certification — SimplerQMS](https://simplerqms.com/iso-13485-quality-management-system/)
9. [What Certifications Should I Look for in an Electronics Manufacturing Partner? — EMSG Inc.](https://emsginc.com/resources/what-certifications-should-i-look-for-in-an-electronics-manufacturing-partner/)

## Key Takeaways

- ISO 9001 = baseline สำหรับทุก industry; IATF 16949 = automotive extension (ต้องมี ISO 9001); ISO 13485 = medical device independent standard — แต่ละใบมี scope และ audit cycle ของตัวเอง
- IATF 16949 บังคับ 5 core tools: APQP, FMEA, SPC, MSA, PPAP — EMS ที่ถือ IATF 16949 แต่ไม่รู้จัก tools เหล่านี้คือ red flag
- ISO 13485 emphasizes CAPA, DHR/DMR, process validation, ISO 14971 risk management — มากกว่า ISO 9001 มาก
- Audit cycle: Stage 1 (doc) → Stage 2 (on-site) → surveillance ทุกปี (20-30% ค่า initial) → recertification ทุก 3 ปี
- ตรวจ scope ของ certificate ทุกครั้ง — certification อาจไม่ครอบคลุม production line ที่คุณต้องการ
- Site visit > certificate badge — ไปดูสาย ถาม operator, ดู record จริง
- IATF 16949 ≠ CSR compliance — ต้องตรวจ Customer-Specific Requirements ของ automotive OEM แยกต่างหาก
