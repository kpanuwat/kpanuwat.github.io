---
title: "เจาะลึก EMS Factory EP4: SMT Line Workflow"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [ems, smt, pcba, manufacturing, soldering, reflow, quality, yield]
series: ems-factory
slides: true
---

{% include slide-link.html %}

{% include series-nav.html %}

## TL;DR

SMT line คือเครื่องจักรกลที่ประกอบด้วย 6 stations ต่อกันเป็น sequence: stencil printer → SPI → pick & place → reflow oven → AOI → X-ray ความสามารถและข้อผิดพลาดส่วนใหญ่ถูกกำหนดตั้งแต่ต้นไลน์ — ~60–80% ของ SMT defects มีต้นกำเนิดจาก solder paste printing stage ก่อนที่ component จะถูกวางลงบน board แม้แต่ตัวเดียว

## Background / Why This Matters

EP3 cover fundamentals ของ SMT vs THT ไปแล้ว EP4 นี้จะ zoom-in ลงที่ SMT line เอง ทีละ station — เพราะการที่ EMS engineer จะ optimize yield หรือ diagnose defect ได้ต้องเข้าใจว่าแต่ละ station ทำงานอย่างไร และ parameter ไหนที่ "โดน" ก่อนที่ defect จะมีโอกาสเกิด

ความสำคัญของการเข้าใจ SMT line workflow ในเชิง operational:
- **EMS audit**: รู้ว่าจะถาม evidence อะไรที่แต่ละ station (SPI data, AOI false-call rate, reflow profile log)
- **Defect diagnosis**: trace root cause กลับไปยัง station ที่ถูก ไม่ใช่แก้ที่ปลายน้ำเท่านั้น
- **Design review**: DFM decisions เช่น component pitch, pad size, thermal relief ล้วนส่งผลต่อ processability ในแต่ละ station

## Deep Dive

### SMT Line Overview: 6 Stations เชื่อมต่อกัน

```
[1] Stencil Printer → [2] SPI → [3] Pick & Place → [4] Reflow Oven → [5] AOI → [6] X-Ray
       ↑ ~60-80% defects originate here
```

Boards เคลื่อนผ่านทุก station บน conveyor ใน single-pass — ยกเว้น boards ที่ double-sided ซึ่งจะ loop กลับมา rerun หลังจาก flip board [1]

### Station 1: Stencil Printing — ต้นทางของ Yield

Stencil printer วาง solder paste ลงบน PCB pads ผ่าน apertures ใน stencil โลหะ (ส่วนใหญ่ stainless steel, thickness 100–180 µm) [2, 3]

**Critical Parameters:**

| Parameter | Range ที่แนะนำ | ผลกระทบจาก deviation |
|-----------|--------------|---------------------|
| Squeegee pressure | 5–10 N/25 mm (0.5–1.5 kg/cm) | มากไป → scooping; น้อยไป → smearing |
| Print speed | 20–70 mm/s (แนะนำ 20–40 mm/s) | เร็วเกินไป → apertures ไม่เต็ม |
| Squeegee angle | 45°–60° | ต่ำกว่า 45° → paste residue บน stencil |
| Separation speed | ช้า (≤ 1 mm/s) | เร็วเกินไป → paste pulling, dog-ear defect |

**Stencil Design Rules (Area Ratio):**

Area Ratio (AR) = (Aperture area) / (Aperture wall area) ≥ **0.66** [2, 3]
Aspect Ratio = (Aperture length) / (Stencil thickness) ≥ **1.5** [3]

ถ้า AR ต่ำกว่า 0.66 paste จะ "ติด" อยู่ใน aperture ไม่ release ลงบน pad — เป็นเหตุผลหลักที่ fine-pitch components (0201, 01005) ต้องการ stencil บางพิเศษ หรือ stepped stencil ที่มี thickness differential 1.0–1.5 mils [3]

**Closed-loop SPI Feedback:**  
SPI ยุคใหม่ไม่ใช่แค่ reject boards — ส่ง offset correction data กลับไปให้ printer ปรับ alignment อัตโนมัติก่อน print ใบถัดไป ทำให้ process drift ถูกจับได้แบบ real-time [2]

### Station 2: SPI (Solder Paste Inspection) — First Quality Gate

SPI ใช้ laser triangulation หรือ structured light เพื่อสร้าง 3D height map ของ paste deposits ทุก pad บน board [4]:

- **วัด**: volume (%), height (µm), area coverage (%), alignment offset (µm)
- **Threshold**: ปกติ set ที่ 80–120% ของ nominal volume; deviation เกิน → reject ก่อน placement
- **Feedback loop**: offset data → printer auto-correction → monitor drift trend

**ทำไม SPI ถึงสำคัญมากกว่าที่คิด:**  
SPI คือ gate ที่ถูกที่สุดในการ catch defects — การ reject board หลัง placement หรือหลัง reflow แพงกว่าหลาย 10x เพราะต้องใช้ rework หรือทิ้ง board ทั้งใบ [4]

### Station 3: Pick & Place — Placement Accuracy และ Speed

Pick & place machine ใช้ vacuum nozzles + vision cameras หยิบ components จาก feeders และวางลงบน paste-coated pads [5, 6]

**Machine Specifications:**

| Spec | ช่วงทั่วไป | หมายเหตุ |
|------|-----------|---------|
| CPH (Chip shooter) | 115,000–200,000 CPH | "Optimum" conditions — real-world ต่ำกว่ามาก |
| Placement accuracy | ±15–35 µm | ±25 µm standard สำหรับ 0201; ±15 µm สำหรับ 01005 |
| Vision system | Laser + top-down camera | Correct X/Y/θ offset real-time ก่อน placement |
| Feeder types | Tape-and-reel, tray, stick | BGA และ odd-form ใช้ tray; ลด effective CPH |

**ทำไม "CPH บนกล่อง" ≠ CPH จริง:**  
Manufacturer CPH วัดจาก simple chips บน single-feeder setup — real-world CPH ลดลง 30–50% เมื่อ BOM มี component หลาย types, feeder ต้อง change, หรือมี tray components [5, 6]

**Yield Factors ที่ต้องควบคุม:**
- Nozzle wear → ลด vacuum pickup reliability → missing components
- Feeder jam → component stuck → placement skip
- Vision calibration drift → placement offset → bridging หรือ open joints
- รูปแบบ scheduling (gang-pick vs. sequential) → ส่งผลต่อ effective CPH อย่างมีนัย [6]

### Station 4: Reflow Soldering — Thermal Profile Engineering

Reflow oven เป็น tunnel ยาว 3–6 เมตร แบ่งเป็น 8–10 heating zones + 1–2 cooling zones ควบคุม temperature profile ของ board ตลอดทาง [7, 8]

**4-Zone Profile สำหรับ SAC305 Lead-Free:**

```
Temperature
    ↑
250°C│                    ___peak (240–250°C)___
     │                  /                       \  TAL 45-90s
220°C│                /  SAC305 liquidus (217°C)  \
     │              /·····················          \
180°C│         ___ / soak (150–200°C, 60–120s)       \
     │        /                                        \
150°C│      /  ramp 1–3°C/s                             \  cool -2 to -4°C/s
     │    /                                              \
 25°C│___/                                                \___
     └──────────────────────────────────────────────────────→ Time (s)
         Preheat       Soak         Reflow         Cooling
```

**Zone-by-Zone Engineering:**

**1. Preheat Zone** — Ramp 1.0–3.0°C/s (แนะนำ < 2.0°C/s) [7, 8]  
ระเหย solvents ใน paste; thermal shock หลีกเลี่ยง — ramp เร็วเกินไปทำให้ MLCC capacitors แตก (ceramic cracking) [7]

**2. Soak Zone** — 150–200°C, 60–120 seconds [8]  
Flux activation: กำจัด oxides บน pads และ component leads; thermal equalization — ให้ copper planes และ small components ถึงอุณหภูมิใกล้เคียงกันก่อน reflow [7, 8]

**3. Reflow Zone (Time Above Liquidus — TAL)** — Peak 240–250°C, TAL 45–90 seconds [7, 8]  
SAC305 liquidus = 217°C — peak ต้องสูงกว่า liquidus 20–30°C เพื่อ wetting ที่สมบูรณ์ TAL ที่สั้นเกินไป (< 45s) → BGA voids จาก flux entrapment; TAL ที่ยาวเกินไป (> 90s) → brittle intermetallic compound (IMC) layer, component damage [7]

**4. Cooling Zone** — -2.0 to -4.0°C/s [8]  
เร็วพอให้ fine-grain solder microstructure (ทนทานกว่า) แต่ไม่เร็วเกินไปจนเกิด thermal stress บน thick boards หรือ boards ที่มี large copper mass [7, 8]

**Nitrogen Atmosphere:**  
การใช้ nitrogen (O₂ < 500–2,000 ppm) ใน reflow oven ลด oxidation ระหว่าง reflow ปรับปรุง wetting และลด voiding — สำคัญสำหรับ fine-pitch และ lead-free alloys ที่ wetting properties แย่กว่า SnPb [7]

### Station 5: AOI (Automated Optical Inspection) — Surface Quality Gate

AOI ใช้ high-resolution cameras + structured light / multi-angle lighting ตรวจสอบ board หลัง reflow [9, 10]:

**สิ่งที่ AOI ตรวจได้:**
- Missing components, wrong component, polarity errors
- Solder bridges (short ระหว่าง pads)
- Tombstone, lifted component
- Insufficient solder fillet (ประเมินจาก optical shape)
- Component offset/rotation เกิน spec

**ข้อจำกัดของ AOI:**
- ไม่เห็น hidden joints: BGA balls, QFN, LGA underside → ต้องใช้ X-ray
- False positive rate สูงถ้า algorithm calibration ไม่ดี — ทำให้ operator fatigue จาก "review overload" [9]
- 2D AOI อ่านบ่าได้ solder volume จริง — 3D AOI ดีกว่าแต่ยังไม่แม่นยำสำหรับ micro solder bridges [10]

**Speed**: 10–20 seconds per board (สำหรับ 100% inline inspection) [9]

**AI-3D AOI สมัยใหม่** ลด false positive ได้ ~70% เทียบกับ rule-based 2D AOI [9] ทำให้ operator ใช้เวลากับ genuine defects มากขึ้น

### Station 6: X-Ray (AXI) — Hidden Joint Verification

AXI ใช้ X-ray penetrate ผ่าน components เพื่อดู hidden joints [9, 10]:

**สิ่งที่ X-Ray ตรวจได้ (AOI ไม่เห็น):**
- BGA void percentage (IPC-7095 กำหนด void % limit ตาม class)
- BGA ball alignment, missing ball, bridged ball
- QFN/LGA underside solder joint shape
- Internal solder crack หรือ delamination
- Insufficient fill ใน hidden joints

**Precision**: up to 99% สำหรับ hidden structural defects [9]  
**Speed**: 30–60 seconds per board (ช้ากว่า AOI 3–6x) — มักใช้ sampling ไม่ใช่ 100% inline ยกเว้น Class 3 products [9, 10]

**X-Ray Void Acceptance (IPC-7095C):**

| IPC Class | Max void % ต่อ BGA ball | Notes |
|-----------|------------------------|-------|
| Class 1 | ไม่กำหนด | Consumer products |
| Class 2 | ≤ 25% | Commercial / industrial |
| Class 3 | ≤ 25% (stricter distribution) | Aerospace, medical |

### Common SMT Defects และ Root Causes

| Defect | Root Cause หลัก | Station ที่เกิด | วิธีแก้ไข |
|--------|----------------|----------------|----------|
| Solder bridge | Paste too much, bad AR, poor stencil release | Printing | ลด aperture size; ลด squeegee pressure; clean stencil |
| Open / insufficient | Paste too little, aperture blocked, bad AR | Printing | เพิ่ม stencil thickness; clean aperture; check AR ≥ 0.66 |
| Tombstone | Uneven heating, unbalanced pad design | Reflow | Profile soak zone; ปรับ pad symmetry ใน layout |
| BGA void | TAL สั้นเกินไป, flux entrapment | Reflow | เพิ่ม TAL; use nitrogen; ปรับ flux chemistry |
| Cold solder joint | Peak temp ต่ำเกินไป, thermal mass mismatch | Reflow | เพิ่ม peak temp; ปรับ soak time |
| Missing component | Nozzle wear, feeder jam, vision error | Pick & Place | ตรวจ nozzle wear; clean feeders; recalibrate vision |
| Misalignment | Paste offset + P&P offset compound | Printing + P&P | SPI closed-loop; P&P vision recalibration |

### SPC (Statistical Process Control) ใน SMT Line

SPC ช่วย detect process drift ก่อนที่ defects จะเกิด — ไม่ใช่แค่ check หลังเกิดแล้ว [11]:

**Key Control Charts ใน SMT:**
- **SPI volume Cp/Cpk**: process capability ของ paste deposit — เป้า Cpk ≥ 1.33 (≈ 64 ppm defect rate)
- **Placement offset X/Y control chart**: detect drift ใน P&P machine alignment
- **Reflow peak temperature trend**: detect oven element degradation ก่อน go out-of-spec

**First Pass Yield (FPY)** คือ metric หลักของ SMT line quality [11]:  
FPY = (Units ที่ผ่าน inspection ทุก station โดยไม่ต้อง rework) / (Total units)

World-class SMT lines: FPY > 99.5%  
Average SMT lines: FPY 95–99%  
ต่ำกว่า 95% = process ต้องการ systematic improvement

## Caveats / Limits

**SAC305 Profile ≠ Universal Lead-Free Profile**  
SAC305 (Sn-Ag-Cu) เป็น lead-free alloy ที่พบบ่อยที่สุด แต่ alloys อื่นเช่น SAC0307, SnBi, หรือ low-temperature alloys (Sn42Bi58 — liquidus ~138°C) ต้องการ profile ที่แตกต่างกันอย่างมีนัย ห้ามใช้ SAC305 profile กับ alloy อื่นโดยไม่ validate ก่อน

**Area Ratio ≥ 0.66 คือ Necessary ไม่ใช่ Sufficient**  
AR ≥ 0.66 เป็นเงื่อนไขขั้นต่ำสำหรับ paste release ที่ดี แต่ยังต้องพิจารณา stencil surface finish (electro-polish, nano-coating), paste type (type 3/4/5 powder size), และ under-stencil wiping frequency ร่วมด้วย

**CPH Rating ≠ Line Output**  
Overall Equipment Efficiency (OEE) ของ SMT line ขึ้นกับ uptime, quality rate, และ performance — line ที่มี chip shooter 150,000 CPH แต่ OEE 70% ได้ effective output ต่ำกว่า line ที่มี 80,000 CPH แต่ OEE 95%

**X-Ray Void ≠ Failure**  
Void ใน BGA joint ไม่ได้หมายความว่า joint จะ fail เสมอไป — IPC-7095C กำหนด acceptance criteria โดยพิจารณา void distribution ไม่ใช่แค่ void percentage single ball

## References

1. [SMT Assembly Process Flow for PCBA Manufacturing — PCBCool](https://pcbcool.com/technical-guides/smt-assembly-process-flow/)
2. [Optimizing Solder Paste Printing: Key to High-Yield SMT Assembly — AllPCB](https://www.allpcb.com/blog/pcb-assembly/optimizing-solder-paste-printing-key-to-high-yield-smt-assembly.html)
3. [In-Depth Analysis of Solder Paste Printing Technology and Process Optimization Guide — NextPCB](https://www.nextpcb.com/blog/solder-paste-printing-technology-and-process-optimization)
4. [What is Solder Paste Inspection (SPI)? — NextPCB](https://www.nextpcb.com/blog/what-is-solder-paste-inspection-spi)
5. [Pick and Place Perfection: Maximizing Efficiency in SMT Component Placement — AllPCB](https://www.allpcb.com/blog/pcb-assembly/pick-and-place-perfection-maximizing-efficiency-in-smt-component-placement.html)
6. [Understanding Pick And Place Machine Specifications: CPH, Accuracy, Speed — PickAndPlaceMachine.com](https://pickandplacemachine.com/understanding-pick-and-place-machine-specifications-cph-accuracy-speed/)
7. [Reflow Soldering Profile Optimization: How to Stop SMT Defects — QueenEMS](https://www.queenems.com/blog/reflow-soldering-profile-optimization-how-to-stop-smt-defects/)
8. [Reflow Soldering 101: Temperature Profile Optimization — FastTurnPCB](https://www.fastturnpcbs.com/guides/reflow-soldering-profile/)
9. [AOI vs. AXI: Choosing the Right Inspection Method for Your SMT Line — AllPCB](https://www.allpcb.com/blog/pcb-assembly/aoi-vs-axi-choosing-the-right-inspection-method-for-your-smt-line.html)
10. [Automated Optical Inspection (AOI): The Ultimate Guide — NextPCB](https://www.nextpcb.com/blog/automated-optical-inspection-aoi)
11. [Quality Metrics and Improvement Methods in PCBA Processing — Neoden SMT](https://www.neodensmt.com/news/quality-metrics-and-improvement-methods-in-pcb-71844268.html)

## Key Takeaways

- **60–80% ของ SMT defects เกิดที่ paste printing** — SPI closed-loop feedback คือ single highest-ROI improvement ใน SMT line
- **Area Ratio ≥ 0.66, Aspect Ratio ≥ 1.5** คือ design rules ขั้นต่ำของ stencil aperture — ละเมิดแล้วมั่นใจได้ว่า paste release defects จะเกิด
- **Squeegee parameters**: pressure 5–10 N/25 mm, speed 20–40 mm/s, angle 45–60° — deviation ไม่ว่าทิศทางใดสร้าง defects คนละประเภท
- **SAC305 reflow**: preheat ramp < 2°C/s → soak 150–200°C/60–120s → peak 240–250°C → TAL 45–90s → cooling -2 to -4°C/s — แต่ละ parameter มี failure mode ที่ชัดเจนถ้าออกนอก range
- **AOI ตรวจ surface เท่านั้น** (10–20s/board); **X-ray ดู hidden joints** เช่น BGA (30–60s/board, 99% precision) — ต้องใช้ทั้งคู่สำหรับ complete coverage
- **FPY > 99.5%** คือ world-class benchmark — ต่ำกว่า 99% ต้องหา systematic root cause ไม่ใช่แค่ rework
- EP5 ถัดไปจะ deep-dive SMT process control tools: stencil engineering, SPC implementation, และ reflow profile validation methodology
