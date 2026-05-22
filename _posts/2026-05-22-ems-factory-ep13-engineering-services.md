---
title: "EMS Factory EP13: Engineering Services — NPI, Process, Test, และ Customer Support"
date: 2026-05-22 00:18:00 +0700
categories: [Engineering]
tags: [engineering-services, npi, process-engineering, test-engineering, dfm, dft, tooling, sustaining-engineering, ems, manufacturing]
series: ems-factory
---

{% include series-nav.html %}

## TL;DR

Engineering Services คือ "หัวใจทางวิศวกรรม" ของโรงงาน EMS — ทีมที่รับ design จาก OEM แล้วทำให้มันผลิตได้จริงในสายการผลิต ครอบคลุมตั้งแต่ NPI, Process Engineering, Test Engineering ไปจนถึง Sustaining Engineering ตลอดอายุสินค้า

## Background / Why this matters

โรงงาน EMS ไม่ได้แค่ "รับ PCB มาประกอบ" — ส่วนใหญ่ต้องรับ design จาก OEM ที่ยังไม่ผ่านการทดสอบกับสายการผลิตจริง แล้วทำให้มันกลายเป็นสินค้าที่ผลิตได้ซ้ำได้ ถูกต้อง คุ้มต้นทุน

Engineering Services คือกลุ่มฟังก์ชันที่ทำหน้าที่นี้ ประกอบด้วย:

- **NPI (New Product Introduction)** — รับ design ใหม่เข้าสู่การผลิต
- **Process Engineering** — ออกแบบและ validate กระบวนการผลิต
- **Test Engineering** — ออกแบบ strategy ทดสอบสินค้า
- **Customer Engineering** — ดูแล interface กับ OEM ตั้งแต่ DFM ถึง ECO
- **Tooling & Fixtures** — สร้าง physical tools ที่ใช้ในสายการผลิต
- **Sustaining Engineering** — ดูแลสินค้าที่ production แล้วตลอด lifecycle

ความสำคัญ: สถิติชี้ว่า NPI มี success rate เพียง **56%** [3] — หมายความว่าเกือบครึ่งของ product launch ล้มเหลว ส่วนใหญ่มาจาก poor design + development process ที่ไม่ robust พอ Engineering Services ที่แข็งแกร่งคือสิ่งที่เพิ่ม odds ให้ project สำเร็จ

## Deep Dive

### 1. NPI (New Product Introduction) — เส้นทางจาก Design สู่ Production

NPI คือ structured process ที่พาสินค้าใหม่จาก concept ไปถึง full-scale production พร้อมลด risk และต้นทุนการ redesign [1][2]

**Phase 1 — Definition & Feasibility**
- ทีมกำหนด product goals, evaluate risk management
- ตรวจสอบว่า project คุ้มค่าทาง financial หรือไม่
- EMS engineers ทำ DFM/DFA review เบื้องต้นกับ design ของ OEM [4]

**Phase 2 — Development & Prototyping**
- สร้าง functional prototypes (PCBA, box-build) เพื่อ validate fit, form, function [2]
- Engineers สร้าง bespoke build packs, เขียน SMT programs, สั่ง solder stencils/pallets [1]
- ตรวจสอบ Gerber files, BOM, และ component data ก่อนเริ่ม build

**Phase 3 — Pre-Build Verification**
- Verify stepped Gerber files สำหรับ panelisation ที่ถูกต้อง
- Visual inspect stencils/pallets เมื่อได้รับ เพื่อป้องกัน PCB scrap
- ครอสเช็ค BOM ทุก line item: part number, package, supplier, lead time

**Phase 4 — Process Validation & First Article Inspection (FAI)**
- ทำ controlled initial run (First Article) เพื่อยืนยันว่า materials, components, และ assembly operations ครบถ้วนตาม engineering requirements [2]
- FAI เป็น "pass/fail gate" ก่อนเปิด production จริง

**Phase 5 — Release for Production & Evaluation**
- เปิด mass production จาก pilot batches
- ใช้ field data และ yield data ต่อเนื่องเพื่อปรับปรุงคุณภาพ [1]
- NPI stage จบเมื่อ prototype แรกกลายเป็น reproducible final product

### 2. Process Engineering — ทำให้กระบวนการ Repeatable

Process Engineers ทำให้ทุก manufacturing step มี documentation, repeatable, และ stable [5]

**ความรับผิดชอบหลัก:**
- สร้าง assembly documentation, process-flow diagrams, work instructions
- Program และ validate SMT lines, selective soldering, conformal-coating processes
- ใช้ **Statistical Process Control (SPC)** เพื่อ confirm stability ของสายการผลิต
- ทำ failure-mode analysis (FMEA) เพื่อระบุ weak points ก่อนเกิดปัญหา
- Lead value engineering และ cost optimization ผ่าน process improvements [4]

**สิ่งที่ Process Engineer ต้องรู้:**
- Capabilities ของทุก machine บน production floor
- Tolerances ที่แต่ละ process ทำได้จริง (vs. what the design assumes)
- Interaction ระหว่าง materials, equipment, และ environment

### 3. Test Engineering — ตรวจสอบว่าสินค้าทำงานได้จริง

Test Engineering พัฒนา strategy และ infrastructure ที่ใช้ verify product quality [4][6]

**Test Methodologies ที่ใช้ใน EMS:**

| Test Type | สิ่งที่ตรวจสอบ | เมื่อไหร่ใช้ |
|-----------|---------------|-------------|
| AOI (Automated Optical Inspection) | Component placement, solder joints | หลัง SMT ทุก board |
| ICT (In-Circuit Test) | Electrical connectivity, component values | หลัง assembly |
| Functional Test | ระบบทำงานครบตาม spec หรือไม่ | ก่อน ship |
| Environmental / Reliability Test | ทนความร้อน, ความชื้น, vibration | Qualification phase |
| Thermal Cycling | Solder joint fatigue ใน extreme conditions | Long-life products |

**DFT (Design for Testability):**
- Test Engineers ทำ DFT analysis เพื่อ optimize test procedures ก่อน mass production [4]
- ออกแบบ PCB ให้มี test points เพียงพอสำหรับ ICT/functional probing
- สร้าง test fixtures ทาง physical เพื่อ verify board connections

### 4. Customer Engineering Support — สะพานระหว่าง OEM กับ Factory

Customer Engineering เป็น interface หลักระหว่าง OEM's design team กับ manufacturing floor [4][5]

**DFM/DFA Review:**
- ระบุ layout issues: unusual component footprints, spacing violations, routing challenges
- ชี้ปัญหาก่อนที่จะแพงเกินแก้ — cost to fix a bug ที่ design stage ถูกกว่า production 10–100x
- ให้ feedback เป็น DFM report พร้อม recommended changes กลับไปยัง OEM

**Program Management:**
- Dedicated program managers track deliverables, milestones
- Transparent communication: share yield data, defect trends, ECO status กับ customer อย่างต่อเนื่อง [1]
- เป็น single point of contact ระหว่าง OEM กับทุก internal engineering group

**Customer Engineering รับ input จาก OEM:**
- Product specs, design files (Gerber, BOM, schematics)
- Test requirements, acceptance criteria
- Volume ramp plan, quality targets

**และ output กลับไป OEM:**
- DFM report พร้อม actionable recommendations
- FAI package: test logs, traceability records, First Article report
- Regular status updates: yield, throughput, defect Pareto

### 5. Tooling & Fixtures — Physical Infrastructure ของ Engineering

Tooling เป็น physical assets ที่ทำให้กระบวนการผลิตทำงานได้จริง [4][7]

**ประเภทหลักของ Tooling:**

- **Solder Stencils** — กำหนด pattern และปริมาณ solder paste ที่วางบน PCB pad แต่ละจุด; ต้อง verify stepped Gerber ก่อนสั่งทำ
- **Pallets/Carriers** — frame ที่ช่วยรองรับ PCB ระหว่างผ่านกระบวนการต่างๆ (เช่น selective soldering, wave soldering)
- **Test Fixtures (Bed-of-Nails)** — physical fixture ที่ probe connects กับ test point บน PCB สำหรับ ICT; ออกแบบโดย Test Engineers
- **Assembly Jigs** — ช่วย guide ช่างในการประกอบชิ้นส่วน through-hole หรือ mechanical parts อย่างถูกต้อง
- **Conformal Coating Masks** — ป้องกันพื้นที่ที่ไม่ต้องการ coating (connectors, test points)

**Tooling Management:**
- Track revision ของ tooling พร้อม product ECO — ถ้า design เปลี่ยน stencil/fixture ต้องอัปเดตด้วย
- มี maintenance schedule เพื่อยืดอายุการใช้งาน

### 6. Sustaining Engineering — ดูแลสินค้าตลอด Lifecycle

Sustaining Engineering รับไม้ต่อหลังจาก NPI ปิดตัว — ดูแลให้สินค้าผลิตได้ต่อเนื่องตลอดอายุ [6][7]

**Obsolescence Management:**
- Monitor component lifecycles อย่างต่อเนื่อง — manufacturer EOL (End of Life) notices
- ระบุ alternative components ล่วงหน้าก่อนที่ของจะ obsolete
- Alternative Materials Management: เสนอ substitutes ที่มี spec ใกล้เคียงและผ่าน qualification

**Product Lifecycle Management (PLM):**
- บันทึก history ของ design changes, material substitutions, process improvements
- ทำงานร่วมกับ OEM ใน long-term product support plan
- สำคัญอย่างยิ่งใน industries ที่ต้องการ long product life เช่น aerospace, industrial automation, medical

**Cost Reduction Programs:**
- Identify opportunities ใน BOM เพื่อใช้ equivalent parts ที่ต้นทุนต่ำกว่า
- Process optimization ที่ลด cycle time หรือ scrap rate
- ทั้งหมดต้องผ่าน engineering qualification ก่อน implement

### 7. Engineering Change Management — ควบคุมการเปลี่ยนแปลง Design

ECO (Engineering Change Order) management ทำให้ design updates เกิดขึ้นได้โดยไม่หยุดชะงัก production [4][7]

**ECO Process Flow:**
1. OEM ออก ECO document (เหตุผล, scope ของการเปลี่ยน)
2. Customer Engineer review impact ต่อ BOM, stencil, fixtures, test procedures
3. Process Engineer ประเมิน impact ต่อ work instructions และ SPC data
4. CCB (Change Control Board) อนุมัติ — พร้อม effective date
5. Implement พร้อมกันทุก production elements; update traveler document
6. First article หลัง change เพื่อ validate ก่อน full production

**ความซับซ้อนของ ECO ใน Mass Production:**
- ต้องจัดการ "old stock" vs "new design" inventory อย่างรอบคอบ
- ถ้า change กระทบ test: test fixture และ software ต้องอัปเดตพร้อมกัน
- Traceability records ต้องระบุชัดว่า serial number ไหนใช้ revision อะไร

## Caveats / Limits

**1. Engineering Services Cost ไม่ฟรี**
EMS ส่วนใหญ่คิด NPI fee แยกต่างหากจาก production pricing — ลูกค้าบางรายมองว่าแพงเกินแต่จริงๆ ช่วยลด risk ระยะยาวได้มาก

**2. DFM ต้องทำให้เร็ว**
ถ้า OEM ส่ง design มาโดยไม่ผ่าน DFM review และเริ่ม mass production ทันที ต้นทุน rework/scrap อาจสูงมาก การลงทุน engineering time ตั้งแต่ต้นคุ้มกว่าเสมอ

**3. Sustaining Engineering มักถูก undervalue**
OEM บางรายตัด sustaining budget หลัง product launch — แต่นี่คือช่วงที่ component obsolescence และ yield improvement ต้องการ attention มากที่สุด

**4. EMS Engineering ≠ Product Design**
Engineering Services ใน EMS คือ **manufacturability** focus ไม่ใช่ product design EMS ไม่ได้เป็นเจ้าของ IP ของสินค้า การออกแบบ circuit หรือ firmware ยังเป็นความรับผิดชอบของ OEM

**5. NPI Success Rate 56%**
แม้แต่กับ EMS ที่มี engineering services ครบ NPI ยังมีโอกาสล้มเหลวสูง สาเหตุหลักมักมาจาก poor design ฝั่ง OEM ไม่ใช่ EMS process — engineering collaboration ที่ดีตั้งแต่ต้นจึงสำคัญ

## References

1. [NPI Programs: 8 Critical Elements For Success — Federal Electronics](https://federalelec.com/blog/elements-of-npi-program/)
2. [What Is New Product Introduction (NPI) in the Electronics Industry? — SVTronics](https://svtronics.com/what-is-new-product-introduction-npi-in-the-electronics-industry/)
3. [Guide to the NPI Process in Electronics Manufacturing Services — Byte Lab](https://www.byte-lab.com/guide-to-the-npi-process-in-electronics-manufacturing-services/)
4. [Electronics Manufacturing Services — EMS Engineering — VECTOR BLUE HUB](https://vectorbluehub.com/electronics-manufacturing-services-ems)
5. [Electronic Manufacturing Services (EMS): Complete Guide — TPS Elektronik](https://tps-elektronik.com/en/electronic-manufacturing-services-complete-guide/)
6. [Electronic Manufacturing Services (EMS) — Ultimate Guide — Podrain Electronics](https://podrain.com/the-ultimate-guide-to-electronic-manufacturing-services/)
7. [Design for Manufacturability (DFM) in Electronics and its benefits? — Foxtronics EMS](https://foxtronicsems.com/design-engineering/dfm-for-electronics-manufacturing/)

## Key Takeaways

- **Engineering Services คือ lifecycle bridge** — ทำงานตั้งแต่ DFM review (ก่อนผลิต) ไปจนถึง sustaining engineering (หลัง launch) ไม่ใช่แค่ช่วง production
- **NPI มี success rate เพียง 56%** — Engineering Services ที่แข็งแกร่งคือ risk mitigation หลักสำหรับ product launch
- **DFM review ต้องทำก่อน** ค่าใช้จ่ายในการแก้ปัญหาที่ design stage ถูกกว่า production stage หลาย 10 เท่า
- **Process, Test, Customer Engineering แยกกันทำงาน** แต่ต้อง integrate กันผ่าน NPI → production → sustaining
- **Tooling ต้อง sync กับ ECO** — ทุกครั้งที่ design เปลี่ยน stencil, fixture, test software ต้องอัปเดตพร้อมกัน
- **Sustaining Engineering ป้องกัน obsolescence** — monitor component lifecycle อย่างต่อเนื่องเพื่อไม่ให้ production หยุดเพราะหาชิ้นส่วนไม่ได้
- **ECO management เป็นศิลปะ** — ต้องจัดการ old stock, traceability, และ test qualification พร้อมกันโดยไม่หยุด production
