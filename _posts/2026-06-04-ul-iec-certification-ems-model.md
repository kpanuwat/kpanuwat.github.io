---
title: "UL และ IEC Certification ใน EMS Model: ใครรับรองอะไร?"
date: 2026-06-03 00:01:00 +0700
categories: [Engineering]
tags: [ul-certification, iec, ems, pcba, electronics-manufacturing, compliance]
slides: true
---

{% include slide-link.html %}

## TL;DR

ในโมเดล EMS การรับรอง UL จะ focus ที่ **end product** เป็นหลัก ไม่ใช่ PCBA โดยตรง แต่ความสำเร็จของ UL Listing ขึ้นอยู่กับว่า PCBA ถูกประกอบด้วย components ที่ถูกต้อง — โดยเฉพาะ safety-critical components ที่ต้องมี **UL Recognized** mark หรือสอดคล้องกับมาตรฐาน IEC ที่กำหนด และการเปลี่ยน BOM ใดๆ ต้องผ่านกระบวนการ approval อย่างเป็นระบบ ไม่เช่นนั้น certification status ของ end product จะตกอยู่ในความเสี่ยง

## Background / Why this matters

ในอุตสาหกรรม Electronics Manufacturing Services (EMS) ผู้ผลิต OEM มักจะส่ง design ไปให้ EMS contractor ผลิต PCBA หรือ finished product ให้ คำถามที่เกิดขึ้นเสมอคือ: **ใครต้องรับผิดชอบ certification อะไร?**

ความเข้าใจผิดที่พบบ่อยคือคิดว่า "ถ้า EMS มี ISO 9001 แล้ว product ก็ควรผ่าน UL ได้เอง" — แต่จริงๆ แล้ว UL certification และ ISO 9001 เป็นคนละเรื่องกันโดยสิ้นเชิง ISO คือ quality management system ส่วน UL คือ product safety certification ที่มีข้อกำหนดชัดเจนว่า component ใดต้องมี mark อะไร

ยิ่งไปกว่านั้น ตลาดอเมริกาเหนือ (US + Canada) บังคับใช้ UL standards เป็นเงื่อนไขในการเข้าตลาด ขณะที่ตลาดยุโรปและนานาชาติใช้ IEC standards ดังนั้น hardware engineer และ procurement ที่ทำงานใน EMS model จำเป็นต้องเข้าใจโครงสร้างของ certification ทั้งสองระบบอย่างชัดเจน

## Deep Dive

### UL Listing vs. UL Recognized: ความต่างพื้นฐาน

UL มีสองสถานะที่ต่างกันอย่างสิ้นเชิง:

| ลักษณะ | UL Listed | UL Recognized |
|--------|-----------|---------------|
| **สัญลักษณ์** | ⓤL (วงกลม UL) | ᴿᵁ (UR กลับด้าน) |
| **ใช้กับ** | Complete end product | Sub-component ที่ built-in ใน product |
| **ตัวอย่าง** | Power strip, luminaire, appliance | Transformer, power supply module, PCB, insulation material |
| **ผ่านการทดสอบ** | ทั้ง system รวมถึง housing, wiring, heat management | เฉพาะ component นั้น ภายใต้ Conditions of Acceptability |
| **ใช้แบบ standalone ได้?** | ได้ — electrician ติดตั้งในสนามได้ | ไม่ได้ — ต้องอยู่ใน end product ที่ UL Listed เท่านั้น |

**Conditions of Acceptability** คือข้อกำหนดสำคัญของ UL Recognized: component นั้นๆ ได้รับการ certify ภายใต้ operating conditions เฉพาะ เช่น temperature range, voltage, installation method — หาก end product ใช้ component นอกเหนือจากเงื่อนไขนั้น การ Recognized ก็ไม่มีผลทางกฎหมาย

### โครงสร้าง Certification ใน EMS Model

ใน EMS model มีสามฝ่ายหลัก: **OEM** (ออกแบบ + เป็นเจ้าของ IP), **EMS** (ผลิต PCBA + assemble), และ **End Customer** (ผู้ใช้ปลายทาง) ความรับผิดชอบด้าน certification แบ่งดังนี้:

```
OEM                         EMS                         End Product
─────────────────────────── ─────────────────────────── ───────────
Design + BOM (UL-spec'd)    Assembly ตาม spec          UL Listed
                            ตรวจสอบ UL-critical parts   (OEM เป็นเจ้าของ)
                            Incoming inspection
                            Audit trail per UL 796
```

**UL 796** คือมาตรฐานหลักสำหรับ Printed Wiring Boards ที่ EMS ต้องปฏิบัติตาม — ครอบคลุมตลาด US (ZPVI2) และ Canada (ZPVI8)

EMS ที่มี UL 796 certification หมายความว่า EMS นั้น **ได้รับอนุมัติให้ผลิต PCBA** ที่จะถูกนำไป certify เป็น UL Listed end product ได้ แต่ EMS ไม่ได้เป็นเจ้าของ UL Listing — OEM เป็นเจ้าของ

### Component Categories: ใครต้องมี Mark อะไร

**Safety-Critical Components (ต้องมี UL Recognized หรือ IEC equivalent):**

- **Power components**: Internal power supplies, AC/DC converters, transformers, inductors — เป็น "safeguard" ใน IEC 62368-1 terminology
- **Insulation materials**: PCB substrate ต้องผ่าน UL 94 (flammability rating) โดยเฉพาะ V-0 หรือ V-1 สำหรับ enclosure ที่อยู่ใกล้ heat source
- **Protection components**: Fuses, circuit breakers, MOVs (Metal Oxide Varistors), TVS diodes ที่ทำหน้าที่ป้องกัน overvoltage/overcurrent

Part number ของ UL Recognized components จะมี "UL" suffix ต่อท้าย เช่น `123456UL` — EMS ต้องทำ second-stage verification ที่ incoming inspection ว่า part number ตรงกับที่ระบุใน BOM จริง

**General Components (ไม่จำเป็นต้องมี UL Recognized โดยตรง แต่ต้อง quality control):**

- Passive components (resistors, capacitors ทั่วไปที่ไม่อยู่ใน protection circuit)
- Mechanical hardware (standoffs, screws)
- Connectors ที่ไม่ใช่ high-voltage

อย่างไรก็ตาม "ไม่ต้องมี UL mark" ≠ "ใช้อะไรก็ได้" — general components ยังต้องผ่าน quality control ของ EMS, IPC-A-610 workmanship standards, และ RoHS/REACH compliance

### IEC Standards ที่สำคัญสำหรับ Safety Components

**IEC 62368-1** (Audio/Video, IT, and Communication Equipment) เป็นมาตรฐานหลักที่แทนที่ IEC 60950-1 (IT equipment) และ IEC 60065 (AV equipment) — edition ที่ใช้ปัจจุบันคือ **Edition 3 และ Edition 4 (2025)**

ใน UL 62368-1:2025 (Edition 4) มีการเปลี่ยนแปลงที่กระทบ BOM อย่างมาก:

> Components ที่ certify ภายใต้ IEC 60950-1 หรือ IEC 60065 (legacy standards) **ไม่ได้รับการยอมรับอีกต่อไป** ใน 4th edition — ต้องมี certification ภายใต้ IEC 62368-1 edition เดียวกัน

นั่นหมายความว่า OEM ที่กำลังทำ product certification ใหม่หรือ recertification จำเป็นต้องตรวจสอบ BOM ว่า safety-critical components ทุกชิ้น (โดยเฉพาะ power supplies) certify ภายใต้ edition ที่ถูกต้อง

**IEC 62368-1 และ UL มีความสัมพันธ์กันอย่างไร?** — UL 62368-1 คือ US adoption ของ IEC 62368-1 เพิ่มเติม US-specific requirements — product ที่ผ่าน IEC 62368-1 Ed. 3/4 มักสามารถใช้ test report เดียวกันเพื่อขอ UL mark ได้ ลด duplication ของ testing

### BOM Change Control: ทำไมถึงสำคัญมาก

ทุก BOM change ที่กระทบ safety-critical components = **potential certification impact**:

```
BOM Change Event
      │
      ▼
ประเมิน: component นี้ใน safety path ไหม?
      │
 ใช่ ─┼─ ไม่ใช่
      │         └─→ EMS quality approval เท่านั้น
      ▼
UL Recognized ของ replacement component ตรงกับ
Conditions of Acceptability ของ end product ไหม?
      │
ใช่ ──┼── ไม่ใช่
      │         └─→ Re-evaluation โดย UL → อาจต้อง re-test
      ▼
OEM approve + update UL file
(EMS ห้ามเปลี่ยนฝ่ายเดียว)
```

**การเปลี่ยน BOM โดยไม่ผ่าน approval process เป็นความเสี่ยงที่ร้ายแรง** เพราะ:

1. Product ที่ออกจาก production line มี certification label แต่ assembly จริงไม่ตรงกับ certified design
2. หาก incident เกิดขึ้น liability ตกที่ OEM และ EMS ร่วมกัน
3. UL สามารถ revoke UL Listing ได้ทันทีหากพบว่ามีการ deviate จาก certified BOM

ใน practice EMS ที่ดีจะมี **Configuration Control Board (CCB)** process ที่ทุก engineering change order (ECO) ต้องผ่านก่อน production — รวมถึง documented approval จาก OEM สำหรับ safety-critical changes

## Caveats / Limits

- **UL ≠ ทั่วโลก**: UL Listing ครอบคลุม US + Canada เป็นหลัก — EU ต้องการ CE marking (IEC + CENELEC), Japan ต้องการ PSE, Australia ต้องการ RCM ซึ่งแต่ละตลาดมี safety-critical component requirements ของตัวเอง
- **Edition lock**: หาก end product certify ภายใต้ IEC 62368-1 Ed. 3 และ component ถูก certify ภายใต้ Ed. 4 เท่านั้น อาจต้องทำ additional evaluation — ตรวจสอบ edition compatibility เสมอ
- **Sub-assembly complexity**: หาก PCBA เป็น sub-assembly ที่ถูกนำไปประกอบเป็น end product โดย party อื่น responsibility chain จะซับซ้อนขึ้น — ต้องระบุ scope ของ certification ให้ชัดใน contract
- **UL 94 flammability**: PCB substrate ต้องผ่าน UL 94 แต่ UL 94 rating ที่ต้องการ (V-0, V-1, V-2) ขึ้นอยู่กับ application — ตรวจสอบ product standard ที่ใช้ ไม่ใช่ assume V-0 เสมอ
- **Counterfeits**: EMS ต้องมี incoming inspection process ที่ verify UL mark จริง ไม่ใช่แค่ดู label — counterfeit components กับ UL suffix ปลอมมีในตลาด

## References

1. [UL Certification for PCB Assembly - Newmatik](https://www.newmatik.com/knowledge-base/KB-EN-00927/ul-certification-for-pcb-assembly)
2. [UL Recognized vs. UL Listed: What is the Difference? - Jahnsmueller](https://www.jahnsmueller.de/en/blog/ul-recognized-vs-ul-listed-what-is-the-difference)
3. [Preparing for IEC 62368-1 4th Edition - UL Solutions](https://www.ul.com/insights/preparing-iec-62368-1-4th-edition)
4. [IEC 62368-1 Testing and Certification - UL Solutions](https://www.ul.com/services/iec-62368-1-testing-certification)
5. [BOM Checklist for OEMs Partnering with EMS Providers - Agility Tech](https://www.agilitytech.net/blog/bom-checklist-for-oems-partnering-with-ems-providers)
6. [Top Certifications and Standards for PCB Assembly - Suntronic](https://suntronicinc.com/blog/which-are-the-major-certifications-and-standards-applicable-to-pcb-assembly/)
7. [Mandatory quality processes for EMS providers - VentureOutsource](https://ventureoutsource.com/contract-manufacturing/quality-processes-procedures-ems-providers/)
8. [UL 62368-1:2025 (Edition 4) Released - GDEST Lab](https://en.gdestl.com/488.html)

## Key Takeaways

- **UL Listed** = end product certification; **UL Recognized** = sub-component certification — สองอย่างนี้ต่างกัน ห้ามสับสน
- PCBA ไม่ได้รับ UL Listing โดยตัวมันเอง — แต่ EMS ต้องมี UL 796 compliance เพื่อให้ผลิต PCBA ที่จะถูก include ใน UL Listed product ได้
- Safety-critical components (power, insulation/PCB substrate, protection) **ต้องมี UL Recognized mark** พร้อม Conditions of Acceptability ที่ตรงกับ application
- IEC 62368-1 Ed. 4 (2025) ยกเลิก legacy IEC 60950-1/60065 — components ที่ certify ภายใต้ legacy standards ต้องถูก re-evaluated ก่อน use ใน new product certification
- BOM change ที่กระทบ safety-critical components ต้องผ่าน OEM approval เสมอ — EMS เปลี่ยนฝ่ายเดียวไม่ได้ ไม่ว่าจะเป็น "equivalent" แค่ไหน
- General components ที่ไม่กระทบ safety path ไม่ต้องมี UL Recognized โดยตรง แต่ยังต้องผ่าน quality control, IPC-A-610, และ RoHS/REACH
- UL Listing ครอบคลุม US + Canada เท่านั้น — CE (EU), PSE (Japan), RCM (AU) ต้องทำแยก
