---
title: "EMS Factory EP6: Quality Standards & IPC Framework"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [ipc, quality, standards, ems, manufacturing, pcba]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

IPC คือ global trade association ที่กำหนด standard ว่า "good workmanship ในงาน electronics manufacturing คืออะไร" IPC-A-610 บอก **อะไรต้อง accept/reject** ตอน inspect, J-STD-001 บอก **วิธีผลิต** — ทั้งสองต้องใช้คู่กัน EMS ที่ดีจะ embed IPC class ลงไปในทุก contract, traveler, และ inspection record

## Background / Why this matters

เมื่อ OEM ส่ง purchase order ให้ EMS โดยไม่ระบุ quality standard ที่ชัดเจน ทั้งสองฝ่ายอาจมี definition ของ "quality" ต่างกันโดยสิ้นเชิง — OEM อาจคาดหวัง aerospace grade แต่ EMS quote ราคาสำหรับ consumer grade ผลคือ dispute ที่แก้ไขไม่ได้หลังจาก production เสร็จแล้ว

IPC ก่อตั้งปี 1957 ในชื่อ Institute for Printed Circuits และเปลี่ยนเป็น Association Connecting Electronics Industries เพื่อสะท้อน scope ที่กว้างขึ้น ปัจจุบัน IPC เป็น global trade association ที่พัฒนา consensus-based standards ครอบคลุมตั้งแต่ PCB design, assembly process, soldering, rework, ไปจนถึง traceability สำหรับ electronics manufacturing lifecycle ทั้งหมด

Standard เหล่านี้ทำหน้าที่เป็น "common language" ระหว่าง OEM กับ EMS — เมื่อ contract ระบุ "IPC-A-610 Class 3" ทั้งสองฝ่ายรู้ว่า criteria คืออะไรทุก defect type โดยไม่ต้องตีความเอง และหาก operator ถือ IPC certification ก็มี evidence ว่าเขาได้รับการ train มาตามมาตรฐานนั้น

## Deep Dive

### IPC Organization และโครงสร้าง Standards

IPC ออก standards ครอบคลุม lifecycle ของ electronic hardware ตั้งแต่ design จนถึง field repair:

| Standard | ครอบคลุม | กลุ่มผู้ใช้หลัก |
|---|---|---|
| IPC-2221 | PCB design baseline: clearance, conductor sizing, mechanical | PCB designer |
| IPC-A-610 | Acceptance criteria สำหรับ finished assembly | Inspector, QA |
| J-STD-001 | Soldering process: material, method, verification | Process engineer |
| IPC-7711/7721 | Rework + repair procedures | Rework technician |
| IPC-1782 | Traceability: component, process, test data | EMS QMS |
| IPC-7095 | BGA inspection: void acceptance criteria | X-ray inspector |

Standards เหล่านี้ไม่ได้ standalone — J-STD-001 ระบุ process ที่ต้อง meet, IPC-A-610 ระบุ output criteria ที่ process นั้นต้องผลิตออกมา ทั้งสองอ้างอิงกันและกัน

### IPC-A-610: Acceptability of Electronic Assemblies

IPC-A-610 คือ visual inspection standard ที่ใช้กันมากที่สุดใน electronics industry ทำหน้าที่บอกว่า finished assembly "acceptable", "process indicator" หรือ "defect" ตาม criteria ที่กำหนดชัดเจนสำหรับแต่ละ defect type

**Class 1 — General Electronic Products**

โฟกัสที่ functionality เพียงอย่างเดียว cosmetic imperfection ยอมรับได้ เหมาะสำหรับสินค้าที่มี short life expectancy หรือ non-critical function เช่น cheap toys, promotional gadgets, disposable electronics ไม่ require high precision หรือ environmental resistance

**Class 2 — Dedicated Service Electronic Products**

ต้องการ extended life และ sustained performance แต่ downtime ไม่ได้ critical เช่น consumer electronics (laptop, TV), home appliances, industrial controls Class 2 คือ **industry default** เมื่อ contract ไม่ระบุ class

**Class 3 — High-Reliability Electronics**

มาตรฐานสูงที่สุด — zero defects, continuous performance-on-demand ในสภาพแวดล้อมที่ harsh ใช้สำหรับ aerospace, military, medical life-support, critical automotive safety ทุก defect ที่ยอมรับได้ใน Class 2 อาจเป็น "reject" ใน Class 3

ตัวอย่างความต่าง: solder fillet ที่ขาด side overhang เล็กน้อยอาจเป็น "process indicator" (ยอมรับได้) ใน Class 2 แต่เป็น "defect" ใน Class 3

### J-STD-001: Requirements for Soldering

ถ้า IPC-A-610 คือ "what to inspect" แล้ว J-STD-001 คือ "how to build" มาตรฐานนี้กำหนด:

- **Materials**: solder alloy composition (เช่น SAC305, Sn63Pb37), flux type (RMA, no-clean, water-soluble), solder paste specification
- **Process methods**: hand soldering, wave soldering, reflow — แต่ละ method มี procedure ของตัวเอง
- **Verification criteria**: อุณหภูมิ tip, time-on-pad, flux residue acceptance
- **Personnel**: technician ต้องมี training ตาม J-STD-001 certification ก่อน perform soldering

J-STD-001 ระบุว่า lead-free process ต้องใช้อุณหภูมิสูงกว่า leaded ประมาณ 30-40°C ซึ่งกระทบ component selection (ต้องทน peak temperature ที่สูงกว่า) และ thermal profile ทั้งหมด

### IPC-2221: Generic Standard on Printed Board Design

IPC-2221 คือ foundational PCB design standard ครอบคลุม:

- **Electrical clearance**: minimum distance ระหว่าง conductor ที่ต่าง voltage level (prevent arc/breakdown)
- **Conductor sizing**: trace width ตาม current carrying capacity และ temperature rise
- **Dielectric material**: FR-4 baseline; high-performance material สำหรับ high-frequency หรือ thermal requirement
- **Mechanical**: board thickness, via aspect ratio, drill tolerance

ผู้ออกแบบ PCB ที่ follow IPC-2221 สร้าง board ที่ manufacturable และ reliable โดยอัตโนมัติ — ป้องกัน overheating, dielectric breakdown, และ fabrication failure

### IPC-7711/7721: Rework and Repair

Production line ไม่มีที่ไหน perfect — boards บางส่วนจะต้องผ่าน rework ก่อน ship IPC-7711/7721 กำหนด approved procedures:

- **IPC-7711 (Rework)**: การแก้ไข defect เช่น replace component ที่ผิด, reflow joint ที่ cold — เพื่อ restore board กลับสู่ original compliance
- **IPC-7721 (Repair/Modification)**: การแก้ไข physical damage เช่น lifted pad, broken trace, damaged via — restore functionality โดยไม่ compromise long-term reliability

ขั้นตอน rework ที่ไม่ follow IPC-7711/7721 อาจทำให้ board fail ใน field แม้จะ "ดูดี" ผ่านการ visual inspect — เพราะ heat damage หรือ contamination ที่ซ่อนอยู่

### IPC Certification Levels: CIS, CIT, CSE

IPC มีโครงสร้าง certification สำหรับบุคลากรที่ต้อง renew ทุก 2 ปี:

- **CIS (Certified IPC Specialist)**: สำหรับ operator, inspector, technician — validate working knowledge ในการ apply IPC acceptance criteria อย่างถูกต้อง
- **CIT (Certified IPC Trainer)**: สำหรับ instructor ที่จะ train และ certify CIS candidate ภายใน organization — ต้องมี deeper technical knowledge และ teaching capability
- **CSE (Certified Standards Expert)**: สำหรับ subject matter expert ระดับสูงที่ interpret standards, resolve complex accept/reject disputes, และกำหนด company quality policy

EMS tier-1 ต้องการให้ inspector ทุกคนถือ CIS ขึ้นไป และมี CIT อย่างน้อย 1 คนต่อ line เพื่อทำ in-house training รักษา certification ให้ทีม

### IPC ใน Customer Contracts และ EMS Audits

IPC standards สร้าง "legally binding common language" ระหว่าง OEM กับ EMS:

**ใน Purchase Order / Contract:**
- OEM ระบุ IPC-A-610 class ที่ต้องการ (เช่น "Class 2 minimum, Class 3 for critical assemblies")
- J-STD-001 class อาจถูกระบุสำหรับ soldering process
- การระบุ class ป้องกัน ambiguity และ dispute หลัง delivery

**ใน Shop Traveler (Work Order):**
- แต่ละ operation บน traveler ระบุ IPC standard ที่ใช้ inspect
- Inspector sign-off พร้อม certification number และ date

**ใน QMS Audit (เช่น ISO 9001, IATF 16949):**
- EMS ต้องแสดง evidence ว่า operator ถือ IPC certification ที่ยังไม่ expired
- Process records ต้องแสดงว่า inspection ทำตาม IPC criteria
- Traceability records ตาม IPC-1782 ต้องครบ — component lot, date code, serial number

**IPC-1782 Traceability:**
มาตรฐานนี้กำหนด minimum traceability data ที่ EMS ต้องเก็บ ครอบคลุม:
- Component: manufacturer, lot number, date code, quantity
- Process: machine ID, operator ID, timestamp, parameter set
- Test: test result, equipment calibration status
ข้อมูลเหล่านี้ allow "recall" โดย lot — ถ้า component batch หนึ่งมีปัญหา EMS สามารถ identify ทุก board ที่ใช้ batch นั้นได้ภายใน hours

## Caveats / Limits

- **IPC standards ต้อง purchase**: เอกสาร IPC ไม่ free — EMS และ designer ต้อง subscribe หรือซื้อ standard ผ่าน IPC.org ค่าใช้จ่ายอยู่ที่หลักร้อยถึงหลักพัน USD ต่อ document
- **Class ≠ quality ที่แน่นอน**: Class 3 มี criteria ที่เข้มงวดกว่า แต่ไม่ได้ guarantee zero field failure — design, component selection, และ environment ก็มีผล
- **Certification หมดอายุ**: IPC certification ต้อง renew ทุก 2 ปี — EMS ที่ไม่ track expiration มี certified personnel แค่บนกระดาษ
- **Standard ต่างรุ่น**: IPC-A-610 มีหลาย revision (Rev G, Rev H, Rev J) — OEM และ EMS ต้องตกลงกันก่อนว่าใช้ revision ไหน
- **IPC-1782 tier**: มาตรฐานนี้มี 4 tiers (1-4) ของ traceability depth — Tier 4 สูงสุด (component level) มีต้นทุนสูงกว่า Tier 1 มาก ต้องตัดสินใจตาม product risk

## References

1. [IPC-A-610 Standard Explained: Classes, Certification & Inspection Criteria — PCBSync](https://pcbsync.com/ipc-a-610/)
2. [IPC-A-610: Acceptability of Electronic Assemblies — Wevolver](https://www.wevolver.com/article/ipc-a-610-acceptability-of-electronic-assemblies)
3. [IPC Standards: The Definitive Guide for Electronics Engineers — Wevolver](https://www.wevolver.com/article/mastering-ipc-standards-the-definitive-guide-for-electronics-engineers-and-pcb-designers)
4. [What Is IPC J-STD-001? — Blackfox Training Institute](https://www.blackfox.com/what-is-ipc-j-std-001/)
5. [IPC Standards in PCB Assembly: What EMS Clients Must Know — Violintec](https://www.violintec.com/pcb-assemblies/ipc-standards-in-pcb-assembly-requirements-every-ems-customer-should-know/)
6. [Top 15 IPC Standards for Electronics Manufacturing Excellence — Accuris](https://accuristech.com/blog/global-electronics-association-top-15-ipc-standards-for-electronics-manufacturing-excellence/)
7. [IPC-A-610 PCB Assembly Standards: Class 1 VS Class 2 VS Class 3 — PCBOnline](https://www.pcbonline.com/blog/ipc-a-610-pcb-assembly.html)
8. [What are the IPC standards that govern electronics manufacturing? — Surface Mount Process](https://www.surfacemountprocess.com/what-are-the-ipc-standards-that-govern-electronics-manufacturing-processes.html)

## Key Takeaways

- IPC-A-610 = "what to inspect"; J-STD-001 = "how to build" — ต้องระบุทั้งคู่ใน contract ถึงจะ cover quality ได้ครบ
- Class 2 คือ industry default ถ้า contract ไม่ระบุ — ถ้าต้องการ Class 3 ต้องระบุชัดเจน + ยอมรับราคาสูงขึ้น
- CIS/CIT/CSE ต้อง renew ทุก 2 ปี — ถาม EMS ว่ามี expired certificate หรือเปล่าตอน audit
- IPC-1782 traceability = ability to recall by lot — EMS ที่ไม่มี traceability ไม่สามารถ isolate impact ถ้า component มีปัญหา
- IPC-7095C กำหนด BGA void ≤ 25% per ball (Class 2/3) — ต้องใช้ X-ray เพื่อ verify
- Standard revision ต้องตกลงกัน — IPC-A-610 Rev G กับ Rev J มี criteria ต่างกันบางจุด
- EMS ที่ดีจะ embed IPC class ลงไปใน traveler, inspection record, และ QMS document ทุกชิ้น — ถ้า EMS ไม่รู้จัก term เหล่านี้ถือว่า red flag
