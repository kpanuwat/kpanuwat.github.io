---
title: "EMS Factory EP5: DFM / DFT — Design for Manufacturability & Testability"
date: 2026-05-22 18:09:19 +0700
categories: [Engineering]
tags: [dfm, dft, pcb, ems, manufacturing, design]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

DFM (Design for Manufacturability) และ DFT (Design for Testability) คือ discipline ที่ engineer ต้องทำ **ก่อน** ส่ง design ให้ EMS — ไม่ใช่หลังจากที่ production line ปฏิเสธ board แล้ว DFM แก้ปัญหาว่า "board นี้ผลิตได้ไหม" ส่วน DFT แก้ปัญหาว่า "board นี้ test ได้ครบไหม" ทั้งสองต้องทำ parallel ตั้งแต่ layout stage

## Background / Why this matters

เวลาที่ hardware startup หรือ R&D team ออกแบบ PCB พวกเขามักโฟกัสที่ function correctness — circuit ทำงานตาม schematic ไหม? แต่คำถามที่ EMS engineer ถามต่างกัน: "board นี้ pick-and-place machine จับ component ได้ไหม?", "stencil พิมพ์ paste ลง pad ได้ครบไหม?", "ถ้า component หายไป 1 ตัว เราจะรู้ได้ยังไง?"

DFM คือ process ของการออกแบบ PCB ให้สอดคล้องกับ capability ของ manufacturing equipment — ตั้งแต่ stencil printer ไปจนถึง reflow oven DFT คือ process ของการออกแบบ PCB ให้ test equipment เข้าถึง net ที่ต้องการได้ — ตั้งแต่ ICT bed-of-nails ไปจนถึง JTAG boundary scan ทั้งสองเป็น mindset ที่ต้องฝังตั้งแต่ schematic capture ไม่ใช่ checklist ที่รันแค่ก่อน tapeout

ต้นทุนของการละเลย DFM/DFT สูงมาก: PCB respin หนึ่งครั้งใช้เวลา 4-8 สัปดาห์และอาจมีค่าใช้จ่าย $20,000-100,000 สำหรับ prototype NRE ส่วนถ้าปัญหาหลุดไปถึง production ต้นทุนรวม rework + scrap + schedule slip สูงกว่านั้นอีกหลายเท่า

## Deep Dive

### DFM: ออกแบบให้ผลิตได้

DFM คือ practice ของการ optimize PCB design ให้ seamless กับ assembly, testing, และ volume production โดย proactively align design choices กับ capability และ limitation ของ manufacturing equipment

**Component Spacing และ Keepout Zones**

Component ที่วางชิด board edge มากเกินไปจะรบกวน conveyor rail และ V-score blade ระหว่าง depaneling ส่วน component ที่วางชิดกันเกินไปจะทำให้ nozzle ของ pick-and-place machine ไม่มีพื้นที่ลาก — เกิด collision หรือ misplacement

กฎทั่วไป:
- Component clearance จาก board edge: อย่างน้อย 3mm (5mm สำหรับ tall component)
- Component-to-component gap: อย่างน้อย 0.2mm สำหรับ SMT passives, 0.5mm สำหรับ IC package
- ทิศทางของ component: orient component ชนิดเดียวกันให้ขนานกันเพื่อให้ reflow profile เหมือนกัน — ลด tombstoning

**Fiducials**

Fiducial marks คือ copper targets บน PCB ที่ pick-and-place machine ใช้เป็น reference point สำหรับ optical alignment ขาด fiducial = machine ไม่รู้ว่า board อยู่ที่ไหน = placement error

- Global fiducials: อย่างน้อย 3 จุด บน board outline (ไม่ symmetric — ต้องบังคับ orientation)
- Local fiducials: ใกล้ fine-pitch IC เช่น BGA, QFP ที่ placement accuracy ≤ ±35µm
- Fiducial size: copper circle ø 1mm ± 0.05mm, solder mask clearance รัศมี 3mm รอบๆ

**Panelization**

Board เดี่ยวมักไม่ efficient สำหรับ SMT line — EMS จะ panelize รวม board หลายใบเข้า panel เดียวเพื่อ throughput เมื่อ designer กำหนด panelization rules ล่วงหน้าจะลด NRE และ panel rejection rate

- V-score (V-groove): cut ลึก 1/3 ของ thickness ทั้งด้านบนและล่าง; ข้อจำกัดคือต้องเป็น straight line เท่านั้น
- Mouse bites: ช่องเจาะเรียงกัน ใช้กับ board ที่มี irregular outline; ขนาด drill 0.8-1.0mm, pitch 1.5-2.0mm
- Copper clearance จาก V-score: อย่างน้อย 0.38mm (15 mils) เพื่อป้องกัน short circuit เวลา snap

**Thermal Relief**

Component ที่ pin เชื่อมกับ copper plane ขนาดใหญ่โดยตรงจะ conduct heat ออกเร็วเกินไป ทำให้ solder ไม่ flow เข้า joint ได้สมบูรณ์ — เกิด cold joint

Thermal relief pad ใช้ copper "spokes" 4 เส้นเชื่อม pad กับ plane แทนที่จะ flood solid "Starved thermal" (spoke กว้างเกินไปหรือ clearance เล็กเกินไป) ทำให้ heat dissipate ไม่สม่ำเสมอ — ต้องปรับ spoke width 0.25-0.5mm และ clearance 0.3-0.5mm

**Stencil และ Solder Paste Rules**

- Area Ratio ≥ 0.66 (pad area ÷ aperture wall area) — ต่ำกว่านี้ paste ไม่ release ออกจาก stencil
- Aspect Ratio ≥ 1.5 สำหรับ round aperture
- Solder mask expansion: เล็กกว่า pad 0.05mm รอบด้าน เพื่อป้องกัน mask sliver ระหว่าง pad

### DFT: ออกแบบให้ test ได้

DFT คือ engineering discipline ของการทำ PCB ให้ measurable, controllable, และ diagnosable ตลอด lifecycle — ตั้งแต่ prototype debug จนถึง volume production และ field service

**Test Coverage Methods**

| Method | Mechanism | Coverage | Fixture Cost | Best For |
|---|---|---|---|---|
| ICT (In-Circuit Test) | Bed-of-nails fixture; contact all test points directly | 80-95% | High ($5k-50k) | High-volume, analog/mixed-signal |
| Flying Probe | 4-8 movable probes; no fixture | 80-95% | None | Prototype, low-volume |
| JTAG / Boundary Scan | On-chip TAP; shift-register chain | 90-100% (JTAG nets) | None | BGA, dense boards |
| Functional Test | Power-up + stimulus/response | Varies | Medium | System validation |

**ICT (In-Circuit Testing)** ใช้ "bed-of-nails" fixture ที่มี spring-loaded probe ตรงทุก test point บน PCB ทำให้วัด resistance, capacitance, continuity ของ component แต่ละตัวได้โดยตรง ข้อจำกัดคือต้องมี physical access ทุก net — BGA hidden joint ตรวจไม่ได้

**Flying Probe** ใช้ probe ที่เคลื่อนที่ได้ (4-8 หัว) sequential contact test point ทีละจุด ไม่ต้องมี custom fixture — เหมาะสำหรับ prototype หรือ NPI ที่ design ยังเปลี่ยนบ่อย แต่ throughput ช้ากว่า ICT 5-10x ไม่เหมาะ high-volume

**JTAG / Boundary Scan** ใช้ IEEE 1149.1 TAP (Test Access Port) บน IC — ทุก pin มี boundary scan cell ที่ shift chain สามารถ observe + drive ได้ผ่าน TDI/TDO/TMS/TCK pins โดยไม่ต้องมี physical probe เหมาะสำหรับ BGA ที่ probe เข้าไม่ถึง solder ball และ fine-pitch IC ที่ pitch < 0.5mm

**Functional Test** เป็น system-level validation — power-up board จริง ส่ง stimulus, วัด response เทียบกับ expected behavior ไม่ได้ตรวจ component-level แต่ validate ว่า unit ทำงาน end-to-end ได้

### Test Point Guidelines

Test point design เป็นส่วนที่ designer มักมองข้ามจนถึงเวลาที่ EMS บอกว่า ICT fixture ทำไม่ได้:

- **ขนาด**: pad หรือ via ø อย่างน้อย 1.0mm (40 mils); ถ้าใช้ via ต้องเป็น untented (ไม่มี solder mask ปิด)
- **Spacing**: center-to-center ≥ 2.5mm (100 mils) สำหรับ bed-of-nails ICT; ≥ 2.0mm (80 mils) สำหรับ flying probe
- **ตำแหน่ง**: prefer bottom side เพื่อลด fixture complexity; หลีกเลี่ยง ใกล้ tall component ที่จะขวาง probe
- **High-impedance nets**: keep test point ห่างจาก high-impedance node อย่างน้อย 5mm (200 mils) — probe capacitance ทำให้ signal ผิดเพี้ยน
- **Documentation**: label ทุก test point (TP1, TP2, …) ใน design files และส่ง test point schedule หรือ netlist ให้ EMS ก่อน fixture design

### Coverage Strategy: ไม่มี Silver Bullet

ไม่มี test method เดียวที่ cover ได้ครบ — EMS tier-1 มักใช้ layered approach:

```
AOI → ICT / Flying Probe → JTAG → Functional Test
         ↑                    ↑
    surface defects      hidden joints (BGA)
```

Target coverage benchmark:
- **> 95% overall** (industry standard for Class 2 product)
- **100% coverage บน power net** และ critical signal
- JTAG coverage report ต้องระบุ "escaped nets" — net ที่ไม่มี JTAG cell และไม่มี test point (high-risk zone)

### DFM/DFT Review ที่ EMS

ก่อน production freeze EMS engineering team ทำ DFM/DFT review โดย:

1. **Gerber + BOM audit**: ตรวจ layer stack-up, trace clearance, component orientation, polarity marking
2. **Automated DFM check**: software สแกนหา violation เช่น annular ring < minimum, silkscreen บน pad, via-in-pad ไม่มี fill
3. **Testability analysis**: quantify boundary-scan coverage, ระบุ gap, แนะนำจุดที่เพิ่ม test point เพื่อ dramatically ลด test escape rate
4. **DFM report**: document ออกมาเป็น severity-graded list (Critical / Major / Minor) พร้อม suggested fix

Cost of fixing issues by stage:
- Design stage: 1× (แค่ edit file)
- NPI / prototype: 10× (respin + delay)
- Production: 100× (rework + scrap + schedule slip)
- Field return: 1000× (warranty + brand damage)

## Caveats / Limits

- **DFM rules ต่างกันระหว่าง EMS**: minimum trace width ของ vendor A อาจไม่เหมือน vendor B — ขอ "DFM capability document" จาก EMS ก่อนเริ่ม layout เสมอ
- **Functional test ไม่ replace unit test**: board ผ่าน functional test ≠ บรรลุ 100% coverage; edge case ที่ไม่ได้เขียน test script ยังหลุดไปถึง field ได้
- **JTAG coverage ขึ้นกับ IC selection**: ถ้า supplier เลือก IC ที่ไม่มี JTAG TAP, coverage ของ hidden joint จะเป็นศูนย์ — ต้องออกแบบ test strategy ตั้งแต่ BOM stage
- **Flying probe ไม่ scale**: 80-95% coverage ใกล้เคียง ICT แต่ cycle time ช้ากว่า 5-10x — สำหรับ volume > 500 units/month ICT มักคุ้มค่ากว่า

## References

1. [DFM in PCB Design: A Practical Guide to Building Manufacturable Circuit Boards — Arshon Inc.](https://arshon.com/blog/dfm-in-pcb-design-a-practical-guide-to-building-manufacturable-circuit-boards/)
2. [Design for Manufacturability (DFM) in Electronics and its Benefits — Foxtronics EMS](https://foxtronicsems.com/design-engineering/dfm-for-electronics-manufacturing/)
3. [DFM Issues to Check Before PCB Manufacturing — Sierra Circuits](https://www.protoexpress.com/blog/dfm-issues-pcb-manufacturing/)
4. [Board DFT Guidelines: Designing PCBs for Boundary-Scan (JTAG) Testability — JTAG Technologies](https://www.jtag.com/board-dft-guidelines-designing-pcbs-for-boundary-scan-jtag-testability/)
5. [How To Design for a Successful Manufacturing and Testing Process — Altium](https://resources.altium.com/p/designing-for-testability-dft)
6. [Optimizing PCB Design for In-Circuit Testing: A DFT Handbook — AllPCB](https://www.allpcb.com/blog/pcb-manufacturing/optimizing-pcb-design-for-in-circuit-testing-a-design-for-testability-dft-handbook.html)
7. [PCBA Test: A Comprehensive Guide — Electronic Manufacturing Service](https://electronicmanufacturingservice.org/pcba-test-a-comprehensive-guide/)

## Key Takeaways

- DFM แก้ปัญหา "ผลิตได้ไหม" — DFT แก้ปัญหา "test ได้ครบไหม" ทั้งสองทำ parallel ตั้งแต่ layout stage ไม่ใช่ step แยก
- กฎ DFM ที่มักถูกละเลย: fiducials (ขาดแล้ว pick-and-place error), thermal relief (ขาดแล้ว cold joint), copper clearance จาก V-score ≥ 15 mils
- Test point specs: ø ≥ 1.0mm, spacing ≥ 2.5mm (ICT) หรือ 2.0mm (flying probe), prefer bottom side, label TP1/TP2/…
- ไม่มี test method เดียวที่ครบ — layered: AOI → ICT/Flying Probe → JTAG → Functional Test
- JTAG boundary scan คือทางเดียวที่จะ test BGA hidden joints โดยไม่ต้องมี physical probe
- ขอ DFM capability document จาก EMS ก่อนเริ่ม layout — rules ต่างกันระหว่าง vendor
- Cost of defect เพิ่ม 10× ต่อ stage: design (1×) → prototype (10×) → production (100×) → field (1000×)
