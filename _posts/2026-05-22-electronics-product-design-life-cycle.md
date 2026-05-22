---
title: "เจาะลึกเกี่ยวกับ Electronics Product Design Life Cycle"
date: 2026-05-22 00:20:00 +0700
categories: [Engineering]
tags: [electronics, product-design, hardware, pcb-design, dfm, prototyping, certification]
slides: false
---

## TL;DR

Electronics Product Design Life Cycle คือกระบวนการที่เปลี่ยน "ไอเดีย" ให้กลายเป็น "สินค้าจริงที่ขายได้" ผ่านขั้นตอนที่เป็นระบบ ตั้งแต่ Concept → PCB Design → Prototyping (EVT/DVT/PVT) → Certification → Mass Production โดยแต่ละ Gate มีจุดประสงค์คือ "ป้องกันไม่ให้ข้อผิดพลาดรั่วไหลไปสู่ขั้นตอนถัดไปที่แพงกว่า" [1][3]

---

## Background / Why this matters

ถ้าคุณเคยสงสัยว่าทำไม hardware product ถึงใช้เวลานาน 6 เดือน ถึง 2 ปีกว่าจะออกสู่ตลาด คำตอบอยู่ที่ complexity ของ life cycle นี้ ซอฟต์แวร์แก้ bug ได้ด้วยการ push code ชุดใหม่ แต่ hardware เมื่อโรงงานผลิต PCB ไปแล้วหลายพันชิ้น การแก้ผิดพลาดหนึ่งจุดอาจหมายถึงการ rework หรือทิ้งทั้ง batch

Life cycle ที่ชัดเจนจึงไม่ใช่ "ระเบียบราชการ" แต่คือ **risk management tool** — แต่ละ phase gate ทำหน้าที่กรองความเสี่ยงก่อนที่ต้นทุนจะสูงขึ้น

สำหรับวิศวกรที่มาจาก software background หรือเพิ่งเริ่มทำ hardware product การเข้าใจ lifecycle นี้จะช่วยให้สื่อสารกับ EMS (Electronics Manufacturing Services), PCB house, และ certification lab ได้อย่างมีประสิทธิภาพ

---

## Deep Dive

### Phase 1: Concept Definition & Requirements

จุดเริ่มต้นคือการกำหนด **Product Specification Document** ซึ่งครอบคลุม:

- **Functional requirements** — ทำอะไรได้บ้าง? (connectivity, power consumption, form factor)
- **Non-functional requirements** — ทนความร้อน/ความชื้นเท่าไร? IP rating? Drop test?
- **Market & regulatory target** — ขายที่ไหน? → กำหนด certification ที่ต้องผ่าน (FCC สำหรับ US, CE สำหรับ EU)
- **Cost target** — BOM cost สูงสุดเท่าไร? ส่งผลต่อ component selection ทั้งหมด

ข้อผิดพลาดที่พบบ่อยที่สุดในระยะนี้: **Scope Creep** — ทีมเพิ่ม feature กลางโปรเจกต์โดยไม่ update requirement ทำให้ schedule พัง budget บาน [4]

---

### Phase 2: System Architecture & Component Selection

หลังจากมี spec แล้ว วิศวกรจะออกแบบ **System Block Diagram** เพื่อแสดงว่า subsystem แต่ละส่วน (MCU, power management, RF module, sensors) เชื่อมต่อกันอย่างไร

**Component Selection** เป็นขั้นตอนที่สำคัญมากกว่าที่หลายคนคิด:

| ปัจจัย | ทำไมสำคัญ |
|--------|-----------|
| Lifecycle status | ชิ้นส่วน EOL (End of Life) กลางโปรเจกต์ = หายนะ |
| Lead time | บาง IC ใช้เวลา 52 สัปดาห์ในการส่งมอบ |
| Alternate sources | ต้องมี Alternate Vendor List (AVL) เสมอ |
| Thermal rating | ชิ้นส่วนทนอุณหภูมิได้ตาม operating range ที่กำหนดไหม? |

ขั้นตอนนี้ยังรวมถึงการทำ **Proof of Concept (PoC)** — ทดสอบ key technology risk ก่อนออกแบบ PCB เต็มรูปแบบ [1][3]

---

### Phase 3: PCB Design — Schematic → Layout → DFM

PCB Design เป็นหัวใจของ hardware development แบ่งเป็น 3 sub-phase:

#### 3.1 Schematic Design (การออกแบบวงจร)

Schematic คือ "แผนที่ไฟฟ้า" ของ PCB — แสดงว่าทุก component เชื่อมต่อกันอย่างไรในเชิง logic โดยไม่สนใจ physical position

งานหลักในขั้นนี้:
- เลือก component ทุกตัวและกำหนด part number จริง
- ทำ **Electrical Rule Check (ERC)** — ตรวจหา floating pin, wrong voltage level, short circuit
- ทำ **Simulation** (SPICE) สำหรับ critical path เช่น power supply หรือ RF matching circuit

#### 3.2 PCB Layout (การวาง component และ routing)

Layout คือการแปลง schematic เป็น physical space บนแผ่น PCB:

- **Component Placement** — จัด grouping ตาม function เช่น decoupling capacitor ต้องอยู่ใกล้ IC power pin, RF component ต้องแยกห่างจาก switching power supply
- **Trace Routing** — กำหนด trace width ตาม current, impedance control สำหรับ high-speed signal (DDR, USB, PCIe)
- **Layer Stack-up** — PCB 4 layer มาตรฐาน: Signal / GND / Power / Signal ทำให้ EMI ต่ำและ impedance คำนวณได้ [3][8]

#### 3.3 Design for Manufacturing (DFM)

DFM คือการ "ตรวจว่า PCB ที่ออกแบบสามารถผลิตได้จริงในโรงงาน" ก่อนส่ง Gerber file ให้ PCB house

**3 phase ของ DFM:** [5]

```
1. Layout Design Review    → ตรวจ footprint, pad size, clearance
2. Component Placement     → ตรวจ orientation ที่ machine pick-and-place รองรับ
3. Routing Review          → ตรวจ via-in-pad, solder mask, silkscreen
```

DFM checklist ที่สำคัญ:
- Symmetric copper pour บน top/bottom layer → ป้องกัน board warpage ตอน reflow
- Minimum trace width ≥ 0.1 mm (standard), ≥ 0.075 mm (advanced)
- Solder mask dam ≥ 0.1 mm ระหว่าง pad → ป้องกัน solder bridging
- Test point สำหรับ In-Circuit Test (ICT) ทุก net ที่สำคัญ [8]

---

### Phase 4: Prototyping — EVT / DVT / PVT

นี่คือขั้นตอนที่แยก "hardware development" ออกจาก software อย่างชัดเจน — ต้องผ่าน 3 validation gate ก่อน mass production:

#### Engineering Validation Test (EVT)

**เป้าหมาย:** ตรวจว่า design concept ทำงานได้ในโลกจริง

- สร้าง prototype ด้วยมือ (hand-soldered) หรือ PCB house batch เล็ก (~5-20 ชิ้น)
- ทดสอบ basic functionality ทุก feature
- ค้นหา design bug ที่ simulation ไม่เจอ เช่น thermal hotspot, RF interference, power sequencing ผิด
- **ไม่ต้อง** รอ mechanical หรือ aesthetic ที่สมบูรณ์ในขั้นนี้ [4]

#### Design Validation Test (DVT)

**เป้าหมาย:** ตรวจว่า design ผ่าน environmental stress และ simulated customer usage

- Prototype ใกล้เคียง production จริง (injection-molded enclosure, production-intent assembly)
- ทดสอบ:
  - **Thermal cycling** (-20°C ถึง +85°C สำหรับ industrial grade)
  - **Vibration & Drop test** ตาม IEC 60068 หรือ MIL-STD
  - **EMC pre-compliance** — วัด radiated emission ก่อนส่ง cert lab จริง
- นี่คือ phase ที่ทำ **regulatory certification** (FCC, CE, UL) [4][6]

#### Production Validation Test (PVT) / Pilot Run

**เป้าหมาย:** ตรวจว่า factory สามารถผลิตซ้ำได้ตาม spec อย่างสม่ำเสมอ

- สร้างสินค้า 50-500 ชิ้นบน production line จริง
- วัด **First Pass Yield (FPY)** — เปอร์เซ็นต์ชิ้นส่วนที่ผ่าน ICT ครั้งแรกโดยไม่ต้อง rework
- ระบุ bottleneck บน assembly line (ตำแหน่งที่ใช้เวลานานหรือ defect rate สูง)
- หลังจาก PVT ผ่าน → ทำ **Mass Production (MP)** [1][4]

```
EVT: "Design ถูกไหม?"
DVT: "Design รอดในโลกจริงไหม?"
PVT: "Factory ผลิตซ้ำได้ไหม?"
```

---

### Phase 5: Regulatory Certification

Certification ไม่ใช่ขั้นตอนสุดท้าย — ควร **plan ตั้งแต่ Phase 1** เพราะมีผลต่อ PCB design ตั้งแต่ต้น

| Certification | Region | ครอบคลุม |
|--------------|--------|---------|
| **FCC Part 15** | สหรัฐอเมริกา | EMC, RF emission |
| **CE Marking** | สหภาพยุโรป | Safety, EMC, Radio (รวมกัน) |
| **UL Listed** | สหรัฐ/แคนาดา | Electrical safety (ไม่ก่อไฟ/ไฟฟ้าช็อต) |
| **RoHS** | EU + California | ไม่มีสาร hazardous (Pb, Hg, Cd, etc.) |

**FCC:** อุปกรณ์ที่มี wireless (Wi-Fi, Bluetooth, Zigbee) ต้องผ่าน "Intentional Radiator" testing ซึ่งแพงกว่ามาก วิธีลดต้นทุนคือใช้ **pre-certified radio module** (เช่น ESP32, Nordic nRF module ที่มี FCC ID แล้ว) — ทำให้ระบุแค่ "unintentional radiator" testing ราคาถูกกว่า [6][7]

**RoHS compliance** ไม่ได้ครอบคลุมแค่ PCB — ครอบคลุมถึง enclosure, สกรู, สายไฟ ทุกชิ้นส่วนต้องมี RoHS compliance certificate จาก supplier [7]

---

### Phase 6: Mass Production & Post-Market

หลังจาก PVT และ certification ผ่าน:

- **Transfer to Manufacturing (NPI — New Product Introduction):** ส่งมอบ production package ให้ EMS รวมถึง Gerber files, BOM, assembly drawing, test specification, golden sample
- **Supply Chain Setup:** เจรจา MOQ (Minimum Order Quantity), สำรอง buffer stock สำหรับ long lead-time component
- **Quality Control:** กำหนด AQL (Acceptable Quality Level) สำหรับ incoming inspection และ outgoing inspection
- **Post-Market Surveillance:** ติดตาม field failure rate, MTBF (Mean Time Between Failures), warranty claims → feedback กลับสู่ engineering team สำหรับ next revision

---

## Caveats / Limits

**Certification ล้มเหลวเพราะไม่ทำ pre-compliance EMC:**
เกือบทุก startup hardware ที่ผ่าน DVT แล้วส่ง cert lab แล้วล้มเหลว FCC มาจากการไม่ทำ **pre-compliance EMC scan** ด้วย near-field probe ก่อน ค่า fail แต่ละครั้งคือ $5,000–$15,000 USD และ 4–8 สัปดาห์ที่หายไป [6][7]

**Lead time ของชิ้นส่วน:**
ในปี 2021–2023 บาง MCU มี lead time 52–104 สัปดาห์ ถ้าไม่ plan component เร็วพอ โปรเจกต์หยุดทั้งหมดแม้ design จะพร้อม

**Mixing lead-free / leaded components:**
อย่าผสม RoHS-compliant (lead-free) กับ leaded component บน PCB เดียวกัน เพราะ reflow profile ไม่เหมือนกัน (lead-free ต้องการ peak temp 260°C vs. 183°C) ทำให้ joint เสียหาย [8]

**EVT prototype ≠ production quality:**
ผล EVT ที่ดีไม่ได้การันตีว่า production จะไม่มีปัญหา เพราะ hand-soldered prototype ต่างจาก SMT reflow + wave solder อย่างมาก yield จริงต้องวัดจาก PVT เท่านั้น

---

## References

1. [Electronic Product Development Process: Step-by-Step — Embien](https://www.embien.com/blog/electronic-product-development-lifecycle-a-step-by-step-guide)
2. [7 Stages of Electronic Product Development — MLWORKx](https://www.mlworkx.com/blog/7-stages-of-electronic-product-development/)
3. [The Phases of the Hardware Product Development Lifecycle — Cadence PCB](https://resources.pcb.cadence.com/blog/2022-the-phases-of-the-hardware-product-development-lifecycle)
4. [Understanding the Hardware Product Development Lifecycle — AJProTech](https://ajprotech.com/blog/iot-product-development/understanding-the-hardware-product-development-lifecycle-key-stages-of-hardware-development-process.html)
5. [Design for Manufacturing (DFM) Considerations for PCB Design — Autodesk](https://www.autodesk.com/products/fusion-360/blog/design-for-manufacturing-dfm-considerations-pcb-design/)
6. [FCC, CE, UL, RoHS: Global Electronic Certification — Embien](https://www.embien.com/blog/fcc-ce-ul-rohs-your-global-electronic-certification-guide)
7. [Understanding Certifications for Electronic Hardware Products — Predictable Designs](https://predictabledesigns.com/understanding-certifications-for-electronic-hardware-products/)
8. [PCB Assembly Design Guide: DFM, DFA, and Best Practices — NextPCB](https://www.nextpcb.com/blog/pcb-assembly-design-guide)

---

## Key Takeaways

- **Hardware lifecycle มี 6 phase หลัก:** Concept → System Architecture → PCB Design → Prototyping → Certification → Mass Production — ทุก phase มี gate ที่กรองความเสี่ยงก่อนต้นทุนเพิ่ม
- **PCB Design ≠ แค่วาด schematic:** ต้องผ่าน Layout + DFM review ก่อนส่ง Gerber — DFM ที่ดีลด defect rate บน production line ได้มหาศาล
- **EVT/DVT/PVT ไม่ใช่ redundancy:** แต่ละขั้นตอบคำถามต่างกัน — ข้าม DVT คือความเสี่ยงสูงสุดที่นำไปสู่ field recall
- **Plan certification ตั้งแต่ Phase 1:** การเลือก pre-certified radio module ลดค่าใช้จ่าย FCC testing ได้หลายหมื่นบาท
- **Component lifecycle + lead time** ต้องวิเคราะห์ตั้งแต่ต้น — EOL หรือ long lead-time component สามารถหยุดโปรเจกต์ได้แม้ design จะพร้อม
- **DFM failure modes ที่พบบ่อย:** tombstoning, solder bridging, board warpage — แก้ได้ด้วย symmetric copper pour, correct pad geometry, thermal relief
- Timeline ทั่วไปสำหรับ consumer electronics: **6–18 เดือน**; สำหรับ industrial/medical: **18–36 เดือน** เพราะ certification เข้มงวดกว่า
