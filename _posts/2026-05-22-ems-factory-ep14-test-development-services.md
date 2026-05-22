---
title: "EMS Factory EP14: Test Development Services — ICT Fixture, FCT Program, และ Boundary Scan"
date: 2026-05-22 00:19:00 +0700
categories: [Engineering]
tags: [ems, testing, ict, fct, boundary-scan, jtag, npi, fixture-design, pcba]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

Test Development Services คือบริการที่ EMS ทำให้ OEM มีระบบ test ที่พร้อมใช้ใน production — ครอบคลุมตั้งแต่ออกแบบ ICT fixture (bed of nails), เขียน FCT test program, ไปจนถึงวาง Boundary Scan strategy สำหรับ BGA และ high-density board ที่ probe ไม่ถึง ความแตกต่างจาก EP7 (ประเภทของ test) คือ EP นี้โฟกัสที่ **กระบวนการพัฒนา** และ **การแบ่งความรับผิดชอบ OEM/EMS**

## Background / Why this matters

ใน EMS supply chain, "test" มักถูกมองว่าเป็นขั้นตอนสุดท้ายก่อนส่งของ แต่ความจริงคือ **test development เริ่มต้องทำตั้งแต่ design phase** ถ้าออกแบบ board แล้วค่อยมาคิดว่าจะ test ยังไง มักเจอปัญหาใหญ่:

- **Test point ไม่เพียงพอ** — board ไม่มี TP (test point) ในตำแหน่งที่ probe เข้าถึงได้; ต้องแก้ layout ซึ่งแพงมากถ้าเกิดหลัง tape-out
- **BGA ไม่มี scan chain** — solder joint อยู่ใต้ component, ตรวจด้วย visual ไม่ได้, ไม่มี boundary scan ก็ไม่รู้ว่า open หรือ short
- **FCT ไม่มี spec ชัด** — OEM ไม่ได้กำหนด pass/fail criteria, EMS ก็ test ไม่ครบ; defect หลุดถึง field

EMS provider ที่มี test development service จะทำงานร่วมกับ OEM ตั้งแต่ NPI stage เพื่อ eliminate ปัญหาเหล่านี้ก่อนที่จะกลายเป็น production issue

## Deep Dive

### ICT Fixture Design Process

ICT (In-Circuit Test) ใช้ **bed-of-nails fixture** — แผ่น probe ที่มี pogo pin ตรงกับทุก test point บน PCB เพื่อทดสอบค่าไฟฟ้าระดับ component (resistance, capacitance, short circuit)

กระบวนการออกแบบ fixture มี 4 phase:

| Phase | รายละเอียด |
|-------|-----------|
| **Design** | รับ Gerber / CAD data จาก OEM; map test points; กำหนด pogo pin type และ force ที่ใช้; ออกแบบ interface board |
| **Prototyping** | CNC หรือ laser-cut ต้นแบบ fixture; ทดสอบ alignment กับ DUT จริง; ตรวจว่า pogo pin contact ครบ |
| **Testing & Validation** | วัด contact resistance; ทดสอบ isolation ระหว่าง pins; ยืนยันว่า test program ทำงานถูกต้องบน fixture จริง |
| **Production** | precision machining final version; integrate safety interlock; hand off พร้อม test program |

**Component หลักของ ICT fixture:**
- **Test head (bed of nails)** — pogo pins ที่ contact กับ TP บน PCB
- **Interface board** — routing จาก pogo pins ไปยัง test system connector
- **Mounting hardware** — ยึด DUT ในตำแหน่งที่แน่นอน (alignment pin + vacuum clamp)
- **Safety interlock** — ป้องกัน fixture ปิดขณะยังไม่ได้วาง DUT

Modern ICT ยังใช้ CAD/EDA data ในการ auto-generate test program เบื้องต้น (netlist-based), ซึ่งลด development time ลงได้มาก

### FCT Program Development

FCT (Functional Circuit Test) ทดสอบว่า assembly ทำงานได้จริงภายใต้สภาวะที่ใกล้เคียง real-world — ไม่ใช่แค่วัดค่าไฟฟ้า แต่ตรวจว่า **ระบบทำงานถูกต้องตาม spec**

FCT program development ต้องทำใน 3 dimension:

**1. Hardware interface**
- สร้าง custom test fixture ที่ simulate ตัว product จริง (connector ครบ, power supply ตรง, load resistor หรือ dummy sensor ตามจริง)
- สำหรับ wireless product → RF shielded enclosure เพื่อกัน interference

**2. Software test sequence**
- เขียน test script (Python, LabVIEW, หรือ proprietary framework)
- ทดสอบ communication bus: CAN, LIN, RS-485, Ethernet, I2C, SPI
- Firmware programming + boot verification
- Parametric measurement ภายใต้ load จริง (voltage regulation, current draw, thermal)

**3. Pass/Fail criteria**
- OEM ต้องกำหนด acceptance limit ทุก parameter ก่อน production (ถ้าไม่กำหนด EMS จะต้อง estimate เองซึ่งเสี่ยง)
- ทุก result ต้องบันทึกพร้อม serial number เพื่อ traceability ผ่าน MES

FCT มักดักจับ defect ที่ ICT พลาด: firmware failure, timing delay, power supply variation, และ interaction bug ระหว่าง subsystem

### Boundary Scan / JTAG

Boundary Scan (IEEE 1149.1 / JTAG) คือ test architecture ที่ฝังอยู่ใน digital IC — ให้ engineer **observe และ drive digital signal โดยไม่ต้องใช้ physical probe**

**ทำไมถึงสำคัญใน modern board:**
- BGA และ CSP package มี solder joint อยู่ใต้ component — ตรวจด้วย visual ไม่เห็น, ICT pogo pin เข้าไม่ถึง
- High-density board มี trace pitch ละเอียดมาก ไม่มีที่ว่างสำหรับ test point
- Boundary scan ใช้ JTAG chain (TDI → TDO → TMS → TCK) ที่ pass ผ่านทุก IC ใน chain

**สิ่งที่ boundary scan ทำได้:**
- **Interconnect test** — ตรวจ open/short ระหว่าง ICs บน board
- **In-System Programming (ISP)** — flash firmware ผ่าน JTAG โดยไม่ต้องมี bootloader
- **Board bring-up** — debug signal path ตั้งแต่ prototype stage

**DFT rule สำหรับ boundary scan:**
- เลือก IC ที่ support IEEE 1149.1 ตั้งแต่ component selection stage
- กำหนด JTAG chain architecture ก่อน PCB layout freeze
- เพิ่ม test access point (TAP) สำหรับ chain daisy-chain connection

### Fault Coverage Metrics

Fault coverage คือ % ของ possible faults ที่ test strategy ดักจับได้ — เป็น KPI หลักของ test development

**วิธีวัด:**
- ทำ **testability analysis** ก่อน layout freeze: ใช้ EDA tool scan netlist → คำนวณว่า boundary scan ครอบคลุมกี่ % ของ net
- identify "coverage gap" (net ที่ test ไม่ถึง) → แก้ DFT ก่อน production

**Impact ของ multi-layer test strategy (ICT + Boundary Scan + AOI + FCT):**

| Metric | ผลลัพธ์จากการ deploy multi-layer |
|--------|----------------------------------|
| Field returns | ลดลงสูงสุด 70% |
| First-pass yield | ดีขึ้น >95% บน mature product line |
| Warranty cost | ลด 30–50% ใน year แรก |

ตัวเลขเหล่านี้มาจาก EMS provider ที่ implement layered defense — ไม่ใช่ค่าเฉลี่ยอุตสาหกรรม; actual result ขึ้นกับ product complexity

### NPI Test Development Timeline

ช่วง NPI (New Product Introduction) คือเวลาที่ critical สุดสำหรับ test development เพราะการตัดสินใจผิดตอนนี้ทำให้ rework cost พุ่งสูงมากใน mass production

**แนวทางที่ดี:**

```
Design Phase    → กำหนด test strategy, เลือก scan-capable IC, วาง JTAG chain
Layout Phase    → เพิ่ม test point ตาม DFT guideline, ยืนยัน TP density
Prototype Stage → ใช้ Flying Probe Test (ไม่ต้องมี fixture) + boundary scan
                  → parallel: เริ่ม develop ICT fixture จาก Gerber
Pre-Production  → ICT fixture + FCT station พร้อม; validation run
Mass Production → Full test coverage; data logging ผ่าน MES
```

**Flying Probe Testing (FPT)** มีบทบาทสำคัญในช่วง prototype:
- ไม่ต้องมี custom fixture — ประหยัดเวลา 4–8 สัปดาห์เทียบกับ ICT fixture development
- probe เคลื่อนที่อัตโนมัติตาม coordinate จาก Gerber
- เหมาะกับ low-volume / prototype ที่ design ยังเปลี่ยน; ไม่ efficient สำหรับ mass production (slow throughput)

### OEM vs EMS: แบ่งความรับผิดชอบ

Test development ที่ล้มเหลวมักเกิดจากไม่ได้กำหนด ownership ให้ชัด:

| งาน | OEM ทำ | EMS ทำ |
|-----|--------|--------|
| กำหนด test strategy | ✓ | ร่วม |
| วาง DFT / DFM rules | ✓ | feedback |
| ออกแบบ ICT fixture | | ✓ |
| เขียน FCT test program | ร่วม | ✓ |
| กำหนด pass/fail criteria | ✓ | | 
| Execute test ใน production | | ✓ |
| Data logging + MES integration | | ✓ |
| Test escape analysis | ร่วม | ✓ |

**กฎสำคัญ**: OEM ต้อง **freeze test spec ก่อน** EMS เริ่ม develop fixture — ถ้า spec เปลี่ยนหลัง fixture เสร็จ จะต้อง rework fixture ซึ่งแพงและเสียเวลา

## Caveats / Limits

- **Fixture cost vs volume tradeoff** — ICT fixture มี upfront cost สูง (หลักหมื่น–แสนบาท ขึ้นกับขนาดและ complexity); คุ้มค่าสำหรับ volume >1,000 ต่อเดือน; ถ้า volume ต่ำกว่านั้น FPT อาจ cost-effective กว่า
- **Boundary scan ไม่ครอบคลุมทุก IC** — IC ที่ไม่ support IEEE 1149.1 จะอยู่นอก scan chain; ต้องใช้ ICT หรือ cluster test เสริม
- **FCT ไม่เหมือน end-to-end system test** — FCT test assembly เดียว; ไม่ได้ test การทำงานร่วมกันในระบบจริง (ต้องทำ system integration test แยก)
- **Test program maintenance** — ทุก design change ต้องอัปเดต test program และ fixture; ถ้าไม่มี change control ที่ดี (ดู EP12 ECO/ECN) test อาจ stale
- **Coverage ไม่ใช่ 100%** — ไม่มี test method ใดดักได้ทุก defect; layered strategy เพิ่ม coverage แต่ cost ก็เพิ่ม; ต้อง balance กับ field failure risk

## References

1. [Electronics Test Fixture Design And Manufacturing - EMS, Inc](https://emscable.com/test-fixture/)
2. [Testing and Functional Validation in Electronics Manufacturing — Foxtronics EMS](https://foxtronicsems.com/testing-integration/testing-and-validation-in-electronics-manufacturing/)
3. [PCB Assembly Testing Strategies to Reduce Failures and Costs — Foxtronics EMS](https://foxtronicsems.com/testing-integration/pcb-assembly-testing-strategies/)
4. [What Is Boundary-Scan (JTAG)? — JTAG Technologies](https://www.jtag.com/what-is-boundary-scan-jtag/)
5. [ICT vs. Functional Testing: Which One is Right for Your PCB? — Roots EMS](https://rootsems.com/ict-vs-functional-testing-which-one-is-right-for-your-pcb/)
6. [Board DFT Guidelines: Designing PCBs for Boundary-Scan (JTAG) Testability — JTAG Technologies](https://www.jtag.com/board-dft-guidelines-designing-pcbs-for-boundary-scan-jtag-testability/)

## Key Takeaways

- Test development ต้องเริ่มตั้งแต่ design phase — การมาคิดทีหลังทำให้ rework cost สูงและ coverage ต่ำ
- ICT fixture มี 4 phase (Design → Prototype → Validate → Produce) และ depend heavily ที่ test point ที่ OEM วางไว้ใน layout
- Boundary Scan (IEEE 1149.1/JTAG) คือ solution สำหรับ BGA และ high-density board ที่ physical probe เข้าไม่ถึง
- FCT ดักจับ defect ที่ ICT พลาด: firmware failure, timing, power variation — แต่ต้องการ spec ที่ชัดจาก OEM ก่อน
- Flying Probe เหมาะกับ NPI/prototype ที่ design ยังเปลี่ยน; ICT เหมาะกับ mass production ที่ต้องการ throughput สูง
- Multi-layer strategy (ICT + Boundary Scan + AOI + FCT) ลด field return ได้สูงสุด 70% และ warranty cost 30–50%
- OEM ต้อง freeze pass/fail criteria ก่อน EMS เริ่ม develop fixture — spec เปลี่ยนหลัง fixture เสร็จ = rework แพง
