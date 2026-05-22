---
title: "EMS Factory EP12: ECO/ECN — Engineering Change Control"
date: 2026-05-22 19:41:35 +0700
categories: [Engineering]
tags: [eco, ecn, change-control, plm, erp, mes, traceability, manufacturing, ems, ccb]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

ECR → ECO → ECN คือสามเอกสารที่ควบคุมการเปลี่ยนแปลงทุกอย่างใน EMS — ตั้งแต่ component swap ใน BOM ไปจนถึงการเปลี่ยน process parameter ใน reflow oven หาก change bypass ระบบนี้จะเกิด silent change, mixed build, และ defect หลุดถึงลูกค้า EMS ที่ mature ต้องมี CCB (Change Control Board), cut-in control ที่ชัดเจน, และ system integration ตั้งแต่ PLM ถึง MES

## Background / Why this matters

ในสายการผลิต PCBA ไม่มีอะไรอยู่นิ่ง — component obsolete, OEM ส่ง design revision มา, process engineer ค้นพบ improvement, supplier เปลี่ยน packaging — ทุกสิ่งเหล่านี้คือการเปลี่ยนแปลงที่ต้องควบคุม

ปัญหาไม่ใช่ว่าการเปลี่ยนแปลงเกิดขึ้น — ปัญหาคือการเปลี่ยนแปลงที่ไม่ได้รับการควบคุม เมื่อ operator เปลี่ยน component โดยไม่มี ECO หรือ engineer ปรับ reflow profile โดยไม่ผ่าน approval ผลคือ shop floor ผลิตของที่ไม่ตรงกับ design record — และไม่มีใครรู้จนกว่าจะเกิดปัญหาจริง

สำหรับ OEM ที่ outsource ให้ EMS ความเสี่ยงนี้สูงกว่าการผลิตเอง เพราะ design authority อยู่ที่ OEM แต่ manufacturing execution อยู่ที่ EMS — หาก change management ทั้งสองฝั่งไม่ synchronized ปัญหาจะตกหล่นในรอยต่อ

## Deep Dive

### ECR, ECO, ECN: สามเอกสาร หน้าที่ต่างกัน

สามคำนี้ใช้สลับกันบ่อย แต่แต่ละอันมีบทบาทเฉพาะ [1, 2]:

**Engineering Change Request (ECR)**
จุดเริ่มต้น — ใครก็ได้ที่พบปัญหาหรือโอกาสปรับปรุงสามารถ raise ECR ได้ ไม่ว่าจะเป็น quality engineer ที่เจอ field failure, design engineer ที่พบ margin ที่ต่ำเกินไป, หรือ supplier ที่แจ้ง component obsolescence

ECR บันทึก: ปัญหาคืออะไร, พบที่ไหน, impact เบื้องต้น, และทำไมต้องแก้ — แต่ **ยังไม่ authorize** การเปลี่ยนแปลงใดๆ

**Engineering Change Order (ECO)**
เอกสารที่มีอำนาจตามกฎหมาย — หลังจาก ECR ถูก review และ approve แล้ว ECO จะออกมาเป็น formal mandate ที่ระบุ [2, 3]:
- Part number และ revision ที่เปลี่ยน
- วิธีการ implement ทีละขั้นตอน
- ทรัพยากรที่ต้องใช้
- deadline และ effectivity date
- inventory disposition (ทำอะไรกับ stock เก่า)

**Engineering Change Notice (ECN)**
การสื่อสารออกไปยังทุกฝ่ายหลัง ECO ได้รับการ approve แล้ว — ECN ระบุว่า "อะไรเปลี่ยน, ทำไม, และมีผลตั้งแต่เมื่อไหร่" [1, 2]

ECN เป็น signal ที่ trigger ให้แต่ละฝ่ายดำเนินการ:
- Procurement: สั่ง component ใหม่, cancel order เก่า
- Production: update work instruction, จัด training
- Quality: update control plan, inspection criteria
- Warehouse: จัด disposition ของ inventory เก่า

### ECO Workflow: จาก Request ถึง Release

กระบวนการ ECO ที่ mature มี 5 ขั้นตอนหลัก [1, 2, 3]:

**1. Initiation**
ECR ถูก log เข้า PLM system พร้อม evidence (photo, test data, field report) และ preliminary impact assessment ข้อสำคัญ: ECR ต้องมี business justification — "อยากเปลี่ยน" ไม่พอ ต้องระบุว่า cost of change < cost of not changing

**2. Impact Analysis**
ขั้นตอนที่สำคัญที่สุดและมักถูก underestimate — ต้องวิเคราะห์ผลกระทบทุกด้าน [2, 4]:

| มิติ | สิ่งที่ต้องตรวจ |
|---|---|
| **BOM** | ทุก assembly ที่ใช้ part ที่เปลี่ยน, revision control, where-used |
| **Process** | work instruction, routing, assembly sequence, tool qualification |
| **Test** | test spec, limit, test fixture ที่ต้องปรับ |
| **Supply Chain** | lead time ของ new part, existing stock disposition, supplier qualification |
| **Quality** | PFMEA, control plan, incoming inspection criteria |
| **Compliance** | regulatory filing ถ้า change กระทบ certified spec |

**3. Approval — Change Control Board (CCB)**
CCB คือกลุ่ม cross-functional ที่มีอำนาจ approve หรือ reject ECO [3, 5] สมาชิกทั่วไปประกอบด้วย:
- Engineering lead (owner ของ design)
- Manufacturing engineering
- Supply chain / procurement
- Quality assurance
- Finance (สำหรับ cost impact ที่มีนัยสำคัญ)

CCB ใช้ RACI matrix ระบุว่าใคร Responsible, Accountable, Consulted, Informed ในแต่ละ change type — ไม่ใช่ทุก ECO ต้องผ่าน CCB เต็มรูปแบบ change ที่ low risk อาจ route ผ่าน delegated authority แทน [5]

**4. Implementation**
หลัง ECO ได้รับ approval — PLM ออก ECN ให้ทุกฝ่าย และ cascade change เข้าระบบ:
- PLM: update BOM revision, document revision
- ERP: update procurement list, cost roll
- MES: update work instruction, routing, inspection criteria บน shop floor

**5. Verification & Closure**
ก่อนปิด ECO ต้องมีหลักฐานว่า change ถูก implement ถูกต้อง [1, 3]:
- First Article Inspection (FAI) หรือ first-off verification
- Test pass ตาม updated spec
- Obsolete stock handled (scrapped, returned, or used-to-exhaust)
- Training completed สำหรับ operator ที่เกี่ยวข้อง

### Cut-in Control: วิธีจัดการช่วงรอยต่อระหว่าง Old กับ New

จุดวิกฤตในทางปฏิบัติคือช่วงที่ old stock ยังอยู่ใน warehouse ขณะที่ new component เริ่มเข้ามา — ต้องตัดสินใจ cut-in strategy [2, 3]:

**Date Effectivity**
Change มีผลตั้งแต่วันที่กำหนด ทุก order หลังจากนั้นใช้ spec ใหม่ — ง่ายที่สุดแต่ WIP ที่อยู่ระหว่าง production อาจ mixed

**Lot / Serial Number Effectivity**
Change มีผลตั้งแต่ lot number หรือ serial number ที่กำหนด — ดีกว่า date effectivity เพราะ link กับ physical unit โดยตรง เหมาะสำหรับ traceability-sensitive product (medical, automotive)

**Immediate (Mandatory Cut-in)**
Change มีผล immediately — ใช้เมื่อ safety หรือ critical quality issue ต้องการ action ทันที legacy stock ต้องถูก quarantine และ disposition ก่อนใช้งานต่อ

**Use-to-Exhaust**
ใช้ stock เก่าให้หมดก่อน แล้วค่อย cut-in new — เหมาะสำหรับ cosmetic หรือ non-functional change ที่ old part ยังใช้ได้ ประหยัด inventory write-off

ความเสี่ยงของ cut-in ที่ไม่ถูก control: **mixed build** — situation ที่ board ที่ผลิตในช่วงเดียวกันมีทั้ง old spec และ new spec ปะปนกัน ถ้าไม่มี serial number traceability จะแยกไม่ออก [3, 4]

### PLM → ERP → MES: การ Cascade Change ผ่านระบบ

ใน EMS ที่มี system integration ที่ดี ECO หนึ่งใบ trigger cascade ผ่านสามระบบ [4, 5]:

```
PLM (Product Lifecycle Management)
  ├─ BOM revision control (EBOM → MBOM)
  ├─ Document management (drawings, specs)
  └─ ECO/ECN workflow routing
       ↓ API sync
ERP (Enterprise Resource Planning)
  ├─ Procurement list update (new part number)
  ├─ Cost roll update
  ├─ Inventory disposition instruction
  └─ Work order effectivity
       ↓ MES integration
MES (Manufacturing Execution System)
  ├─ Work instruction update (version-controlled)
  ├─ Routing update
  ├─ Barcode/scan enforcement (operator must acknowledge new revision)
  └─ Inspection criteria update
```

**Barcode enforcement** คือ safeguard สำคัญใน MES — operator ต้อง scan label ของ component ก่อนใช้ ถ้า part number ไม่ตรงกับ ECO ที่ active ระบบจะ alert ทันที ป้องกัน legacy part ถูกใช้โดยบังเอิญ [3, 4]

เมื่อ PLM กับ ERP/MES ไม่ integrated — engineer approve ECO ใน PLM แต่ shop floor ยังดู work instruction เก่าอยู่ใน binder กระดาษ นี่คือ root cause ของ silent change ที่พบบ่อยที่สุด

### ความเสี่ยงของ Change Control ที่บกพร่อง

**Silent Change**
การเปลี่ยนแปลงที่เกิดขึ้นโดยไม่มี ECO — อาจเป็นเจตนา ("เปลี่ยนเล็กน้อยแค่นี้ไม่น่าจะมีผล") หรือไม่เจตนา (operator เปลี่ยน component เพราะหาของเดิมไม่ได้) ผลคือ:
- ไม่มี traceability ว่า unit ไหนถูก affect
- ไม่มี impact analysis — ไม่รู้ว่า change กระทบอะไรบ้าง
- ถ้าเกิดปัญหาทีหลัง ไม่สามารถ root cause ได้ [3, 4]

**Mixed Build**
WIP ที่มีทั้ง old spec และ new spec ปะปนกัน เกิดขึ้นเมื่อ cut-in control ไม่ชัดเจน เช่น warehouse จ่าย component โดยไม่ดู lot effectivity ผลคือ:
- Board บนสายเดียวกันมี BOM ต่างกัน
- ถ้าเกิด field failure ไม่สามารถระบุได้ว่า old build หรือ new build ที่มีปัญหา
- อาจต้อง recall ทั้งหมดแทนที่จะ recall เฉพาะ lot ที่เกี่ยวข้อง [3, 4]

**Defect Escape**
ผลลัพธ์สุดท้ายของ change control ที่ล้มเหลว — product ที่ไม่ conform กับ spec หลุดถึงลูกค้า สำหรับ medical device หรือ automotive product defect escape อาจหมายถึง:
- Regulatory non-compliance → Warning Letter หรือ recall
- Warranty cost ที่ backcharge กลับมา EMS
- Loss of customer confidence และ future business [3, 4]

### EMS กับ OEM: Bilateral Change Control

ใน contract manufacturing ทั้ง OEM และ EMS สามารถ initiate change ได้:

**OEM-initiated change:** OEM ส่ง design revision มาให้ EMS implement — EMS ต้องทำ impact analysis ฝั่งตัวเอง, assess lead time, และ confirm effectivity ก่อน acknowledge

**EMS-initiated change:** EMS ต้องการเปลี่ยน process, qualified alternate component, หรือ manufacturing method — ต้องขอ OEM approval ก่อน เพราะ OEM เป็น design authority

จุดสำคัญ: **ทุก EMS-initiated change ต้องได้รับ written approval จาก OEM ก่อน** โดยเฉพาะถ้า product อยู่ภายใต้ ITAR, FDA, หรือ automotive compliance [3, 5]

**Change freeze period:** ช่วง new product introduction (NPI) หรือก่อน major release บาง OEM จะกำหนด change freeze — EMS ต้องไม่ implement change ใดๆ แม้ will-have ECO ถ้าอยู่ใน freeze window

## Caveats / Limits

- **ECO cycle time เป็น competitive differentiator:** EMS ที่มี manual, paper-based ECO process อาจใช้เวลา 2–4 สัปดาห์ต่อ ECO; PLM-driven process อาจลดได้เหลือ 2–3 วัน — cycle time นี้มีผลต่อ speed ที่ OEM สามารถ respond ต่อ field issues
- **Retroactive ECO:** บางบริษัท raise ECO หลังจาก change ถูก implement ไปแล้ว (เพื่อ document) — นี่ยังดีกว่าไม่มี record แต่ขาด impact analysis ก่อน implement ซึ่งเป็น point สำคัญของ ECO process
- **Class I vs Class II change:** บาง regulatory framework (เช่น FDA 21 CFR 820 สำหรับ medical device) แบ่ง change เป็น class ที่มีความเสี่ยงต่างกัน — Class II อาจต้องทำ design validation ซ้ำและ resubmit
- **Legacy system gap:** EMS ที่มี ERP รุ่นเก่าหรือ MES ที่ไม่ integrate กับ PLM จะมี "air gap" — change จาก PLM ต้องถูก re-enter ด้วยมือใน ERP/MES เพิ่มความเสี่ยง human error
- **Supplier-initiated change:** Supplier อาจส่ง PCN (Product Change Notice) สำหรับ component ที่ EMS ใช้ — EMS ต้องมี process รับ PCN และ translate เป็น ECO internal ก่อนที่ change จะ reach shop floor

## References

1. [Engineering Change Order (ECO): Definition, Types, Process, and Example — SimplerQMS](https://simplerqms.com/engineering-change-order/)
2. [Engineering Change Order (ECO) in Contract Manufacturing — Assel EMS](https://asselems.com/en/engineering-change-order-eco-in-contract-manufacturing)
3. [Engineering Change Notice (ECN) vs ECO — How Top Plants Control Change — OxMaint](https://oxmaint.com/blog/post/what-is-an-ecn-or-eco-in-manufacturing)
4. [Engineering Change Management — Autodesk](https://www.autodesk.com/industry/design-manufacturing/plm/engineering-change-management)
5. [Engineering Change Management (ECM): A Complete Guide — BoostPLM](https://boostplm.com/engineering-change-management/)
6. [What is an Engineering Change Order (ECO)? — PTC](https://www.ptc.com/en/blogs/plm/what-is-an-engineering-change-order)

## Key Takeaways

- **ECR = identify, ECO = authorize, ECN = communicate** — สามเอกสาร บทบาทต่างกัน; bypass ใดใดหนึ่งคือ change ที่ไม่ controlled
- Impact analysis คือขั้นตอนสำคัญที่สุด — ต้องครอบ BOM, process, test, supply chain, และ compliance ก่อน approve ใดๆ
- CCB พร้อม RACI matrix ป้องกัน bottleneck — ไม่ใช่ทุก change ต้องผ่าน full board; delegate ตาม risk level
- Cut-in control: เลือก date / lot / serial / use-to-exhaust ให้ตรงกับ risk level; mixed build คือผลลัพธ์ของ cut-in ที่ไม่ชัดเจน
- PLM → ERP → MES integration คือ backbone ของ change cascade — "air gap" ระหว่างระบบคือ root cause ของ silent change
- Silent change เป็นอันตรายกว่า defect ที่รู้แล้ว เพราะไม่มี traceability — ไม่รู้ว่า unit ไหนถูก affect
- EMS-initiated change ทุกอย่างต้องได้ written approval จาก OEM ก่อน โดยเฉพาะ regulated product
- ถาม EMS partner: "ECO cycle time เฉลี่ยกี่วัน?" และ "PLM ของคุณ integrate กับ ERP/MES แบบ API หรือ manual?"
