---
title: "EMS Factory EP10: Manufacturing Yield Optimization (SPC, FPY, OEE)"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [spc, fpy, oee, yield, manufacturing, ems, quality, six-sigma]
series: ems-factory
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

FPY, OEE, และ SPC คือสามเครื่องมือที่ EMS ใช้วัดและปรับปรุง yield — FPY วัดว่ากี่ % ผ่านครั้งแรกโดยไม่ต้อง rework, OEE วัดว่า equipment productive จริงกี่ % ของเวลาที่วางแผนไว้, SPC คือ real-time warning system ที่ตรวจจับ drift ก่อนที่จะกลายเป็น defect สามตัวนี้ทำงานร่วมกันเป็น closed-loop ระบบ ไม่ใช่ metric แยกอิสระ

## Background / Why this matters

EMS ที่บอกว่า "quality ดี" โดยไม่มีตัวเลขสนับสนุนไม่มีความหมาย ในทางปฏิบัติ yield คือตัวกำหนดต้นทุน — board ที่ต้อง rework ทุกใบกิน labor time, material, และ capacity โดยไม่เพิ่ม revenue board ที่ต้อง scrap คือ pure loss

สิ่งที่ซับซ้อนกว่าที่คิดคือ yield ไม่ใช่ตัวเลขเดียว ในสายการผลิต PCBA มีหลาย process step — solder paste printing, SMT placement, reflow, AOI, ICT/FCT — แต่ละ step มี yield ของตัวเอง และ yield ที่ดูดีในแต่ละ step อาจซ่อนปัญหาใหญ่เมื่อดูภาพรวม

OEM ที่ประเมิน EMS partner ควรถามว่า "FPY ของคุณคือเท่าไหร่ในแต่ละ step?" ไม่ใช่แค่ "end-of-line defect rate เป็นเท่าไหร่?" เพราะตัวหลังอาจมอง rework เป็น "ผ่าน" ทั้งที่มันบ่งบอกถึง process ที่มีปัญหาซ่อนอยู่

## Deep Dive

### FPY และ RTY: ตัวเลขที่ซ่อนความจริงของ Process

**First Pass Yield (FPY)** คือ % ของ unit ที่ผ่าน process step หนึ่งโดยไม่ต้อง rework, repair, หรือ scrap ในครั้งแรก [1]

**สูตร:**
```
FPY = (Total Units Entered - Defective Units) / Total Units Entered × 100%
```

**ตัวอย่าง PCBA:**
- สายผลิต 1,000 board/shift
- AOI ตรวจพบ defect 80 board → ส่ง rework
- FPY ของ step นั้น = (1000 - 80) / 1000 = **92%**

**สิ่งที่ FPY ไม่บอก:** board ที่ถูก rework แล้วผ่านในที่สุดยังคง count เป็น defect ในสูตร — เพราะ point คือการวัด process discipline ไม่ใช่ final product quality

**Rolled Throughput Yield (RTY):** เมื่อมีหลาย step ต่อเนื่อง defect ใน step ต้นๆ compound ไปถึง step ท้าย

```
RTY = FPY_step1 × FPY_step2 × FPY_step3 × ... × FPY_stepN
```

**ตัวอย่างที่น่าตกใจ:** PCBA line ที่แต่ละ step มี FPY 95% ดูดีในระดับ step แต่เมื่อมี 5 steps:

| Step | FPY | Cumulative RTY |
|---|---|---|
| Solder Paste Print | 95% | 95.0% |
| SMT Placement | 95% | 90.2% |
| Reflow | 95% | 85.7% |
| AOI | 95% | 81.5% |
| ICT / FCT | 95% | **77.4%** |

RTY 77.4% หมายความว่า 22.6% ของ board ต้องผ่าน rework หรือถูก scrap ในบางจุด — แม้ว่าแต่ละ step ดูเหมือนมี quality 95% [1]

**Six Sigma benchmark:** world-class process target คือ 3.4 DPMO (Defects Per Million Opportunities) ซึ่งเทียบเท่า FPY ≈ 99.99966% [2]

### OEE: วัดว่า Machine ทำงานจริงกี่ % ของเวลาที่วางแผน

**Overall Equipment Effectiveness (OEE)** วัด productivity ของ equipment จากมุมมอง 3 มิติ [3]:

```
OEE = Availability × Performance × Quality
```

**สามองค์ประกอบ:**

| องค์ประกอบ | สูตร | Loss ที่วัด |
|---|---|---|
| **Availability** | Run Time / Planned Production Time | Equipment breakdown, changeover, setup |
| **Performance** | (Ideal Cycle Time × Total Count) / Run Time | Micro-stops, speed loss, warm-up |
| **Quality** | Good Count / Total Count | Defects, rework, scrap |

**ตัวอย่างคำนวณ:**
- Availability: 8-hour shift, 1 hour breakdown → 87.5%
- Performance: running at 90% of ideal speed → 90%
- Quality: 98% good boards → 98%
- OEE = 0.875 × 0.90 × 0.98 = **77.2%**

**Benchmark ที่ใช้กันในอุตสาหกรรม:** [3, 4]
- **100%** = perfect production (good parts only, max speed, zero downtime)
- **85%** = world-class สำหรับ discrete manufacturing
- **60%** = typical — ยังมี room to improve มาก
- **40%** = พบบ่อยใน EMS ที่เพิ่งเริ่ม track OEE

OEE ที่ต่ำกว่า 60% บ่งชี้ว่ามีปัญหาใน one or more ขององค์ประกอบที่ต้องระบุก่อนจะแก้ — OEE เดียวไม่บอกว่าปัญหาอยู่ที่ไหน แต่ชี้ให้รู้ว่ามีปัญหา

### SPC: Control Chart คือ Early Warning System

**Statistical Process Control (SPC)** ใช้ statistical method ตรวจจับ variation ใน process ก่อนที่จะกลายเป็น defect [5]

**หลักการ:** process ทุกอย่างมี variation — คำถามคือ variation นั้นมาจาก "common cause" (ปกติ, คาดการณ์ได้) หรือ "special cause" (ผิดปกติ, ต้องสอบสวน)

**X-bar and R Control Chart** คือ chart ที่ใช้บ่อยสุดใน SMT manufacturing สำหรับ variable data [5, 6]:
- **X-bar chart**: plot ค่าเฉลี่ยของ subgroup — ตรวจจับ process mean shift
- **R chart**: plot range (max - min) ของ subgroup — ตรวจจับ process variation เพิ่มขึ้น

**ใช้กับ parameter อะไรใน PCBA:**
- Solder paste volume/height (SPI measurement)
- Component placement accuracy (pick-and-place offset)
- Reflow oven temperature profile (peak temp, TAL)
- Solder joint shear strength (sampling)

**Out-of-control signals ที่ต้องสอบสวน:** [5]
1. จุดใดจุดหนึ่งอยู่นอก UCL หรือ LCL
2. 7 จุดต่อเนื่องอยู่บนด้านเดียวของ center line (process drift)
3. 7 จุดต่อเนื่อง trend ขึ้นหรือลงอย่างต่อเนื่อง

**ทำไม SPC ต่างจาก inspection:** Inspection จับ defect ที่เกิดแล้ว SPC ตรวจจับ parameter drift ก่อนที่ defect จะเกิด — ประหยัดทั้ง material และ rework labor

### ความสัมพันธ์ระหว่าง FPY, OEE, และ SPC

สามตัวนี้ทำงานเป็น closed-loop ไม่ใช่ metric แยกกัน:

- **FPY** เป็น input ของ OEE ผ่าน Quality component — ถ้า FPY สูง, Quality ใน OEE สูง
- **OEE** วัด total productivity loss — ระบุว่าปัญหามาจาก downtime, speed, หรือ quality
- **SPC** เป็น early warning ก่อน FPY drop — ตรวจจับ drift ของ parameter ที่นำไปสู่ defect

ลำดับการใช้งานในทางปฏิบัติ:
1. OEE ต่ำ → ดูว่า loss อยู่ใน Availability, Performance, หรือ Quality
2. Quality ต่ำ → ดู FPY แต่ละ step → RTY บอกว่า bottleneck อยู่ที่ step ไหน
3. SPC chart ของ step นั้น → ตรวจว่ามี out-of-control signal ก่อนหน้านี้ไหม → root cause analysis

### Common Yield Killers ใน PCBA

ปัญหา yield ที่พบบ่อยที่สุดใน SMT manufacturing [6, 7]:

| Defect | สาเหตุหลัก | Process Step |
|---|---|---|
| **Tombstoning** | Reflow profile ไม่สมมาตร, pad design ไม่สมดุล | Reflow |
| **Solder Bridge** | Solder paste volume มากเกินไป, stencil aperture ใหญ่เกิน | Print → Reflow |
| **Cold Joint / Open** | Peak temperature ต่ำ, component coplanarity ไม่ดี | Reflow |
| **BGA Void** | Flux activation ไม่สมบูรณ์, thermal profile ไม่เหมาะ | Reflow |
| **Component Missing** | Pick-and-place nozzle worn, feeder jam | SMT Placement |
| **Misalignment** | Vision calibration drift, board support ไม่ดี | SMT Placement |

### Practical Actions: EMS ทำอะไรจริงๆ เพื่อปรับปรุง Yield

**1. SPI + AOI ทุก board — ไม่ใช่ sampling**
3D Solder Paste Inspection (SPI) หลัง printing และ AOI หลัง reflow ต้องเป็น 100% inspection ไม่ใช่ sample เพื่อ catch defect ก่อนที่จะ cascade ไปยัง step ถัดไป [6]

**2. AI-driven reflow profile optimization**
Machine learning ที่ cross-reference thermal data กับ defect map สามารถลด voiding risk ได้ถึง 40% และกำจัด tombstoning ได้โดยการ dynamically adjust heating zones [7]

**3. Predictive Maintenance ผ่าน CMMS**
Track health ของ pick-and-place nozzle, reflow oven heating element, squeegee pressure — เปลี่ยนก่อนที่ wear จะส่งผลต่อ process capability [7]

**4. Standardized Work Instructions (SWI)**
Visual SWI ลด human error ในขั้นตอนที่ต้องใช้ manual judgment — เช่น board support placement, rework temperature setting

**5. Rework tracking ที่ strict**
ทุก rework ต้องมี root cause, technician ID, และ verification sign-off — data นี้ feed กลับไปยัง SPC และ process improvement

## Caveats / Limits

- **FPY เดี่ยวไม่พอ:** EMS ที่รายงาน end-of-line FPY เพียงตัวเดียวอาจซ่อน rework ที่เกิดใน intermediate step ควรขอ per-step FPY และ RTY
- **OEE ≠ throughput:** OEE 85% ไม่ได้แปลว่าผลิตได้ 85% ของ theoretical max — ต้องดูร่วมกับ planned production time และ takt time
- **SPC ต้องการ measurement system ที่น่าเชื่อถือ:** ถ้า gauge ที่ใช้วัดไม่มี GRR (Gauge Repeatability and Reproducibility) ที่ดี SPC chart จะเต็มไปด้วย noise ที่ไม่มีความหมาย — ควรทำ MSA ก่อน deploy SPC
- **Control limits ≠ specification limits:** UCL/LCL คำนวณจาก process variation ไม่ใช่จาก customer spec — process ที่ "in control" ยังอาจผลิต defect ถ้า process capability (Cpk) ต่ำ
- **OEE benchmark อุตสาหกรรมต่างกัน:** 85% เป็น benchmark สำหรับ discrete manufacturing — semiconductor fab หรือ continuous process มี benchmark ที่สูงกว่า

## References

1. [First Pass Yield: Definition and Formula — Tractian](https://tractian.com/en/blog/first-pass-yield)
2. [First Pass Yield: What is it, Formula, and How to Improve — MachineMetrics](https://www.machinemetrics.com/blog/first-pass-yield)
3. [Understanding OEE in Lean Manufacturing — Lean Production](https://www.leanproduction.com/oee/)
4. [OEE Calculation: Formulas, Examples, and Insights — Evocon](https://evocon.com/articles/how-to-calculate-oee-formulas-examples/)
5. [SPC: Statistical Process Control — Quality-One](https://quality-one.com/spc/)
6. [Electronics Assembly Quality: Detecting Defects and Reducing Rework — Lean6SigmaHub](https://lean6sigmahub.com/electronics-assembly-how-to-identify-yield-loss-and-rework-problems-in-manufacturing/)
7. [Smart Workflow Strategies for High-Yield PCBA Manufacturing — Andwin Circuits](https://www.andwinpcb.com/smart-workflow-strategies-for-high-yield-pcba-manufacturing/)
8. [SPC in Manufacturing: Definition, Control Chart Types, and Modern Software Tools — Augmentir](https://www.augmentir.com/glossary/statistical-process-control-spc)

## Key Takeaways

- FPY วัด quality ที่ step เดียว — RTY วัด compound yield ตลอด process line; 5 steps × 95% FPY ให้ RTY เพียง 77%
- **OEE = Availability × Performance × Quality** — 85% คือ world-class, 60% คือ typical สำหรับ discrete manufacturing
- SPC ไม่ใช่ inspection — มันคือ early warning system ที่ตรวจจับ parameter drift ก่อนที่จะเกิด defect
- สาม metric ทำงานร่วมกัน: OEE ระบุว่าปัญหาอยู่ที่ไหน, FPY/RTY ระบุ step ที่มี yield loss, SPC ระบุ parameter ที่ drift
- Tombstoning, solder bridge, BGA void คือ yield killer ที่แก้ได้ด้วย reflow profile optimization และ SPI coverage
- ขอ per-step FPY data จาก EMS ก่อนเซ็น contract — end-of-line defect rate เดี่ยวซ่อนปัญหา rework ที่ intermediate step
- SPC ต้องการ MSA (Gauge R&R) ที่ผ่านก่อน — measurement noise ที่สูงทำให้ control chart ไม่มีความหมาย
