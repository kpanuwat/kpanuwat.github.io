---
title: "เจาะลึก EMS Factory EP3: PCBA Basics — SMT vs THT"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [ems, pcba, smt, tht, manufacturing, soldering, assembly]
series: ems-factory
slides: true
---

{% include slide-link.html %}

{% include series-nav.html %}

## TL;DR

PCBA (Printed Circuit Board Assembly) มีเทคโนโลยีหลักสองแบบ: **SMT** (Surface Mount Technology) — components ติดบนผิว PCB — และ **THT** (Through-Hole Technology) — leads ทะลุรู PCB boards สมัยใหม่ใช้ SMT เป็นหลัก (~90%+) เพราะ density สูงกว่าและ automate ได้เต็มที่ โดย THT ยังคงอยู่สำหรับ connectors, high-power, และ components ที่ต้องการ mechanical bond แน่นกว่า

## Background / Why This Matters

EP1 และ EP2 ของ series นี้ cover ภาพรวม value chain และ business model ของ EMS แล้ว แต่ก่อนที่จะ zoom-in ลงไปที่ process control (EP4 ถัดไป) ต้องเข้าใจ fundamentals ของ PCBA ก่อน — โดยเฉพาะความแตกต่างระหว่าง SMT และ THT เพราะเทคโนโลยีที่ใช้ส่งผลโดยตรงต่อ:

- **Design rule** ที่ต้องใช้ใน layout (pad size, hole diameter, clearance)
- **ต้นทุนการผลิต** (SMT line ถูกกว่าต่อ joint ที่ volume สูง แต่มี NRE setup cost ที่แตกต่าง)
- **Reliability profile** ของ product (THT สำหรับ mechanical stress, SMT สำหรับ high-frequency)
- **EMS capability ที่ต้องมี** (wave solder line สำหรับ THT หรือ selective solder สำหรับ mixed boards)

ในทางปฏิบัติ วิศวกรที่ทำงานร่วมกับ EMS ต้องอ่าน bill of materials (BOM) และ Gerber files แล้วระบุได้ทันทีว่า board นี้ต้องการ SMT-only, THT-only, หรือ mixed assembly — และแต่ละ path มี process flow ที่แตกต่างกัน

## Deep Dive

### PCBA คืออะไร?

PCBA (Printed Circuit Board Assembly) คือกระบวนการ "populate" bare PCB ด้วย electronic components จนได้ functional circuit board พร้อมใช้งาน [1] แยกจาก PCB fabrication (การสร้างแผ่น PCB เปล่า) และ system integration (การนำ PCBA ไปประกอบเป็น product)

```
PCB Fabrication  →  PCBA  →  Box Build / System Integration
(สร้างแผ่น PCB)    (ติด components)    (ประกอบ product สมบูรณ์)
```

ในแง่ assembly technology มีสองแนวทางหลัก ซึ่ง board ส่วนใหญ่ใช้ทั้งสองร่วมกัน:

### SMT (Surface Mount Technology): กระบวนการและ Flow

SMT คือการติด components โดยตรงบนผิว PCB โดยไม่ต้องเจาะรู กระบวนการหลักมีดังนี้ [2, 3]:

**Process Flow:**

```
Solder Paste Printing → SPI → Pick & Place → Reflow Soldering → AOI → X-Ray
```

**1. Solder Paste Printing**
Stencil printer วาง solder paste (ส่วนผสมของ solder alloy balls และ flux) ลงบน PCB pads ผ่าน apertures ใน stencil โลหะ ปริมาณ paste ที่แม่นยำเป็น yield lever สำคัญที่สุด — ~70% ของ SMT defects มีต้นกำเนิดจาก stage นี้ [4]

**2. SPI (Solder Paste Inspection)**
3D inspection หลัง paste printing เพื่อวัด volume, area coverage, และ height ของ paste deposit; ระบบ closed-loop สมัยใหม่ส่ง offset data กลับไปให้ printer แก้อัตโนมัติ [4]

**3. Pick & Place**
Robotic machines ใช้ vacuum nozzles และ vision cameras หยิบ SMD components จาก tape-and-reel feeders แล้ววางลงบน paste-coated pads ด้วยความเร็วสูง (หลักหมื่น CPH — Components Per Hour) [2]

**4. Reflow Soldering**
Board ผ่าน reflow oven ที่มี 8–10 heating zones + 2 cooling zones ควบคุม temperature profile (preheat → soak → reflow peak → cooling) solder paste หลอมละลายที่ peak temperature (~183°C สำหรับ SnPb, ~217°C สำหรับ SAC lead-free) แล้ว solidify เป็น solder joint [5, 6]

**5. AOI (Automated Optical Inspection)**
ตรวจสอบ surface-level defects: misalignment, solder bridge, missing components, polarity errors ระบบ AI-3D-AOI สมัยใหม่ลด false alarm rate อย่างมีนัย [2]

**6. X-Ray Inspection**
จำเป็นสำหรับ hidden joints เช่น BGA (Ball Grid Array), QFN, และ LGA ที่ AOI ไม่สามารถ "มองเห็น" joints ใต้ package ได้ [2]

**SMD Package Types ที่พบบ่อย:**

| Package | ตัวอย่าง component | Pitch / Size |
|---------|------------------|-------------|
| 0402, 0201, 01005 | Resistors, capacitors | 1.0mm → 0.4mm → 0.3mm |
| SOT-23, SOT-223 | Transistors, voltage regulators | 0.95mm |
| SOIC, TSSOP | Logic ICs, drivers | 1.27mm, 0.65mm |
| QFP, LQFP | Microcontrollers, FPGAs | 0.8mm, 0.5mm, 0.4mm |
| BGA, LGA, QFN | High-density ICs, MCUs, processors | 0.8mm → 0.3mm (BGA pitch) |

### THT (Through-Hole Technology): กระบวนการและ Soldering Methods

THT คือการสอด component leads ผ่านรูที่เจาะไว้ใน PCB แล้ว solder leads เข้ากับ pads ที่ด้านตรงข้าม กระบวนการประกอบด้วย [7, 8]:

**Process Flow:**

```
PCB Hole Drilling  →  Component Insertion  →  Soldering  →  Inspection
(ใน fab stage)         (manual/auto)        (wave/selective)
```

**Soldering Methods สำหรับ THT:**

**1. Wave Soldering**
PCB ผ่านไปเหนือ reservoir ของ liquid solder ที่ pump สร้างเป็น "wave" solder ไหลขึ้นมาสัมผัส pads ด้านล่าง PCB พร้อมกันทุก joint ในครั้งเดียว — เหมาะกับ boards ที่มี THT components จำนวนมากบน bottom side [8]

ข้อจำกัด: wave soldering ใช้กับทั้งแผ่น PCB ไม่เหมาะกับ mixed boards ที่มี SMT components อยู่ด้านล่างเพราะความร้อนจะทำลาย SMT joints

**2. Selective Wave Soldering**
หัว nozzle ขนาดเล็กเคลื่อนที่ไปยัง specific joints ทีละจุด (หรือทีละกลุ่ม) แทนที่จะ flood ทั้งแผ่น [7, 8] ทำให้ solder เฉพาะ THT joints โดยไม่กระทบ SMT components ข้างเคียง เหมาะมากสำหรับ mixed-technology boards

**3. Manual / Hand Soldering**
ใช้สำหรับ low-volume, high-mix, prototype หรือ rework; ใช้ iron และ solder wire ทำด้วยมือ ช้าและขึ้นกับ operator skill

**THT Component Types:**

| Component | เหตุผลที่ใช้ THT |
|-----------|---------------|
| Power connectors (DB9, XLR, USB-B) | Mechanical stress จาก plug/unplug |
| Electrolytic capacitors (ขนาดใหญ่) | Weight + vibration resistance |
| Transformers, inductors | High current, heat dissipation |
| Relay, large heatsink | Mechanical mounting + thermal path |
| Test points, jumpers | Accessibility สำหรับ debug |

### SMT vs THT: Head-to-Head Comparison

| Criterion | **SMT** | **THT** |
|-----------|---------|---------|
| **Component density** | สูงมาก — 100+ ต่อ sq.in [9] | ต่ำ — ~20 ต่อ sq.in [9] |
| **Component size** | เล็กมาก — package ขนาด sub-mm | ใหญ่กว่า — leads ต้องยาวพอสอดรู |
| **Production speed** | เร็วมาก — automated ทั้งหมด | ช้ากว่า — มี manual/semi-auto insertion |
| **Cost at high volume** | ต่ำกว่าต่อ joint (~$0.03–$0.08/joint) [9] | สูงกว่า — drilling + labor overhead |
| **Mechanical strength** | ปานกลาง — surface bond เท่านั้น | สูงมาก — lead ทะลุ PCB สร้าง anchor point [10] |
| **Vibration / shock resistance** | ต่ำกว่า | สูงกว่า |
| **High-frequency performance** | ดีเยี่ยม — parasitic inductance ต่ำกว่า | แย่กว่า — leads ยาว = inductance สูงขึ้น [9] |
| **Rework ease** | ยากกว่า (โดยเฉพาะ BGA, QFN) | ง่ายกว่า — pull lead, clean, re-insert |
| **Suitable for** | Consumer, RF, digital, compact | Power, connectors, harsh environment |
| **IPC Class applicability** | Class 1/2/3 | Class 1/2/3 (Class 3 ต้องการ annular ring ใหญ่) |

### Mixed/Hybrid Assembly: ใช้ทั้งสองบน Board เดียว

Board สมัยใหม่ส่วนใหญ่ใช้ทั้ง SMT และ THT บน board เดียว — SMT สำหรับ ICs, passives, และ high-density area; THT สำหรับ connectors, power components, และ mounting hardware [11]

**Assembly Sequence สำหรับ Mixed Board:**

```
SMT Top Side → Reflow → Flip → SMT Bottom Side (ถ้ามี) → Reflow
    → THT Insertion → Selective Wave / Manual Solder → Final Inspection
```

**DFM Rules สำหรับ Mixed Assembly [12]:**

- **SMT-to-THT clearance**: ≥ 1.5 mm ระหว่าง PTH (Plated Through-Hole) และ SMT pads ป้องกัน solder bridge ระหว่าง processes
- **SMT pad spacing**: ≥ 0.2 mm ระหว่าง adjacent pads ป้องกัน bridging
- **Thermal via**: 0.3–0.5 mm diameter สำหรับ heat dissipation ใกล้ power components
- **Copper thickness**: inner layers 2–3 oz/ft² สำหรับ high-current paths ใกล้ THT power components
- **Component orientation**: connectors ต้องหันตาม board edge เพื่อ minimize mechanical lever arm

**Component Selection Guide:**

```
ต้องการ miniaturization / high-speed / RF    →  SMT เสมอ
High current (>3A sustained)                  →  THT หรือ Press-Fit
Mechanical stress (connector plug/unplug)     →  THT หรือ mounting hardware
Harsh vibration environment                   →  THT; หรือ SMT + conformal coat
Prototype / Low volume                        →  THT ง่ายกว่า rework
Production / High volume                      →  SMT ถูกกว่า
```

### Inspection Standards และ Acceptance Criteria

ทั้ง SMT และ THT joints ต้องผ่านตาม **IPC-A-610** (Acceptability of Electronic Assemblies) ซึ่งกำหนด Class 1/2/3 acceptance criteria [13]:

**SMT Joint Criteria (IPC-A-610):**
- Solder must wet component pad และ board pad ได้ smooth, concave fillet
- ห้ามมี solder bridge ระหว่าง adjacent pads
- Component ต้องอยู่ใน pad area ≥ 50% (Class 2) หรือ ≥ 75% (Class 3)

**THT Joint Criteria:**
- Solder ต้องเติมเต็ม annular ring และไหลขึ้น hole ≥ 75% (Class 2) หรือ 100% (Class 3)
- ต้องมี meniscus หรือ concave fillet ที่ด้านล่าง
- ห้ามมี cold joint (dull, grainy appearance)

## Caveats / Limits

**SMT Rework คือ Pain Point ใน High-Mix**  
BGA และ QFN rework ต้องใช้ hot air rework station + X-ray verify หลัง rework ถ้า EMS ไม่มี equipment นี้ board ที่มี BGA จะ reject ทิ้งทั้งใบ ควร confirm rework capability ก่อน design-in BGA

**Wave Solder กับ Mixed Board ต้องระวัง SMT Bottom-Side**  
ถ้า SMT components อยู่ด้านล่าง board และใช้ wave solder ต้องมี solder mask + fixture jig ป้องกัน joints ที่ reflow แล้วไม่ให้ถูก wave solder ซ้ำ (จะ remelt และ displace) EMS ที่ดีจะ handle เรื่องนี้ใน process documentation

**THT ใน Lead-Free Era มีค่า Hole Fill ที่ยากขึ้น**  
SAC305 lead-free solder มี wetting properties แย่กว่า SnPb ทำให้ hole fill ใน THT ยากขึ้น โดยเฉพาะ boards ที่มีหลาย copper layers (high thermal mass) ต้องปรับ preheat temperature และ wave solder speed อย่างระมัดระวัง [8]

**Selective Soldering มี Throughput ต่ำกว่า Wave**  
Selective soldering ยืดหยุ่นกว่าแต่ช้ากว่า wave soldering มาก — เหมาะสำหรับ medium-volume mixed boards ไม่เหมาะกับ high-volume boards ที่มี THT components จำนวนมาก

## References

1. [What is PCBA: A Comprehensive Guide — Wevolver](https://www.wevolver.com/article/smt-pcb-assembly-a-comprehensive-guide-to-surface-mount-technology-in-electronics)
2. [SMT PCB Assembly: A Comprehensive Guide to Surface Mount Technology in Electronics — Wevolver](https://www.wevolver.com/article/smt-pcb-assembly-a-comprehensive-guide-to-surface-mount-technology-in-electronics)
3. [Surface Mount Technology (SMT) for PCBA: A Comprehensive Guide — AllPCB](https://www.allpcb.com/blog/pcb-assembly/surface-mount-technology-smt-for-pcba-a-comprehensive-guide.html)
4. [What is Solder Paste Inspection (SPI)? — NextPCB](https://www.nextpcb.com/blog/what-is-solder-paste-inspection-spi)
5. [What is Reflow Soldering? Complete Guide to SMT Reflow Soldering — PCBOnline](https://www.pcbonline.com/blog/reflow-soldering.html)
6. [Reflow Soldering for Beginners: A Comprehensive Guide to SMT Assembly — AllPCB](https://www.allpcb.com/blog/pcb-assembly/reflow-soldering-for-beginners-a-comprehensive-guide-to-smt-assembly.html)
7. [Mastering THT Wave Soldering: Design, Process and Selective Wave Soldering — TSTRONIC](https://tstronic.eu/en/mastering-tht-wave-soldering-design-process-and-selective-wave-soldering-best-practices-for-pcb-assembly/)
8. [Through-Hole Technology PCB Assembly — FC PCBA](https://www.fcpcba.com/guide/tht-pcb-assembly/)
9. [SMT vs. Through-Hole: Cost, Space, & Speed Showdown — PCBNet](https://www.pcbnet.com/blog/smt-vs-through-hole-cost-space-speed-showdown/)
10. [Through Hole vs Surface Mount: Unveiling the Optimal PCB Assembly Technique — Wevolver](https://www.wevolver.com/article/through-hole-vs-surface-mount-unveiling-the-optimal-pcb-assembly-technique)
11. [PCB Assembly Techniques: SMT vs. THT and Hybrid Approaches for Modern Electronics — IC Online](https://www.ic-online.com/blog/post/pcb-assembly-techniques-smt-vs-tht-and-hybrid-approaches-for-modern-electronics)
12. [The Definitive Guide to Mixed-Technology PCB Assembly — NextPCB](https://www.nextpcb.com/blog/guide-to-mixed-technology-pcb-assembly)
13. [Surface Mount (SMT) vs. Through-Hole (THT): Choosing the Right PCB Assembly Technology — Aimtron](https://www.aimtron.com/blog/surface-mount-smt-vs-through-hole-tht-choosing-the-right-pcb-assembly-technology/)

## Key Takeaways

- **SMT = density + speed + automation**: components ติดบนผิว PCB; process flow คือ paste → pick & place → reflow → AOI; ~90%+ ของ PCBA สมัยใหม่ใช้ SMT เป็นหลัก
- **THT = mechanical strength + power**: leads ผ่านรู; soldering ด้วย wave, selective wave, หรือ hand; เหมาะสำหรับ connectors, power components, harsh environment
- **Mixed assembly** (SMT + THT บน board เดียว) คือ standard สมัยใหม่ — ต้องเรียง assembly sequence ให้ถูก (SMT first → reflow → THT → selective solder)
- **Component density**: SMT = 100+ per sq.in; THT = ~20 per sq.in — ต่างกัน 5x
- **Mechanical bond**: THT แน่นกว่า SMT อย่างมีนัย — THT leads สร้าง mechanical anchor ผ่าน board; SMT พึ่ง surface solder เท่านั้น
- **High-frequency performance**: SMT ดีกว่า — shorter leads = lower parasitic inductance; THT leads ยาว = impedance rises ที่ high frequency
- **DFM rule สำหรับ mixed boards**: ≥ 1.5 mm clearance ระหว่าง PTH และ SMT pads; ≥ 0.2 mm ระหว่าง SMT pads; thermal vias 0.3–0.5 mm สำหรับ power thermal path
- EP4 ถัดไปจะ zoom-in ลงลึก SMT process control: stencil engineering, paste rheology, reflow profiling, และ SPC implementation
