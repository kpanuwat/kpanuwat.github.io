---
title: "EMS Factory EP7: Testing Strategy (AOI, ICT, FCT)"
date: 2026-05-22 00:12:00 +0700
categories: [Engineering]
tags: [aoi, ict, fct, testing, ems, manufacturing, pcba]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

AOI, ICT, และ FCT คือ 3 ชั้นของ testing ใน EMS ที่ทำงานคนละ scope — AOI ตรวจสายตา (visual), ICT ตรวจไฟฟ้าระดับ component (electrical structural), FCT ตรวจว่าระบบทำงานได้จริง (functional system) ทั้งสามไม่ใช่ทางเลือก แต่เป็น layered defense ที่แต่ละชั้นดักจับ defect ที่ชั้นอื่นตรวจไม่เจอ

## Background / Why this matters

หลังจาก board ผ่าน SMT line มาแล้ว คำถามที่ EMS ต้องตอบคือ: "board ใบนี้พร้อม ship ไหม?" คำตอบไม่ได้มาจากการตรวจครั้งเดียว เพราะแต่ละ testing method มี blind spot ของตัวเอง — AOI ไม่รู้ว่าค่า resistor ถูกหรือเปล่า, ICT ไม่รู้ว่า firmware ทำงานได้หรือเปล่า, FCT ไม่รู้ว่า solder joint ชิ้นนั้นจะรอดจาก thermal cycling ได้หรือเปล่า

ปัญหาที่เกิดจากการ test ไม่ครบ: board ที่ "ผ่าน visual แล้ว" อาจมี component ผิดค่าซ่อนอยู่ ซึ่งไม่ manifest จนกว่า device จะอยู่ในมือ end user สิ่งนี้แปลว่า warranty cost, brand damage, และในกรณี medical/automotive อาจหมายถึง safety incident

EMS tier-1 ออกแบบ test strategy ก่อนที่ production จะเริ่ม — ไม่ใช่เพิ่มทีหลังเมื่อมีปัญหา การลงทุนใน testing infrastructure ล่วงหน้ามี ROI ชัดเจน: ค่าแก้ defect ที่จับได้ใน ICT อยู่ที่ $1-10 ต่อ unit แต่ถ้าหลุดไปถึง field อาจสูงถึง $100-1,000+ ต่อ unit (รวม warranty, logistics, recall cost)

## Deep Dive

### AOI: Automated Optical Inspection

AOI คือ non-contact inspection ที่ใช้ high-resolution camera (2D หรือ 3D) และ image analysis algorithm สแกน PCB หลัง reflow เพื่อตรวจ visual defect ระบบ capture ภาพของ board แล้วเปรียบเทียบกับ reference — อาจเป็น "golden board" (board ที่รู้ว่า good) หรือ CAD/Gerber file โดยตรง

**สิ่งที่ AOI ตรวจจับได้:**

| Defect Type | ตัวอย่าง |
|---|---|
| Missing component | resistor หายหลัง pick-and-place |
| Misaligned component | IC ที่ pin ไม่ตรง pad |
| Rotated component | capacitor หมุน 180° |
| Incorrect polarity | diode กลับขั้ว (ตรวจจากสีขีดหรือ marking) |
| Solder bridge | short ระหว่าง 2 pad ที่ต่อกันด้วย solder เกิน |
| Insufficient solder | solder น้อยเกินไปจนไม่เกิด fillet |
| Tombstoning | passive component ตั้งตรงแทนที่จะนอนราบ |

**AOI ตรวจไม่ได้:**
- ค่าไฟฟ้าของ component (ไม่รู้ว่า resistor ค่าถูกหรือเปล่า)
- Solder joint ที่ดูดีแต่ cold (hidden crack)
- BGA joint ใต้ package
- ว่า firmware ทำงานถูกหรือเปล่า

**เมื่อ AOI ใช้:** หลัง reflow oven — เป็น first checkpoint ของ SMT line ใน high-volume production AOI วิ่งได้ 30-60 board ต่อชั่วโมง ตรวจทุก board โดยไม่เพิ่ม bottleneck มากนัก ผล AOI ยังใช้ track process trend ได้ — ถ้า solder bridge เพิ่มขึ้นต่อเนื่องใน time series แสดงว่า stencil หรือ paste อาจเริ่มมีปัญหา

### ICT: In-Circuit Test

ICT คือ "white-box" electrical structural test — ไม่ได้ power up ระบบทั้งหมด แต่ใช้ probe contact ทุก test point บน board แล้ว measure resistance, capacitance, inductance, voltage, และ continuity ของ node แต่ละจุด หลักการคือ "guarding" ซึ่งใช้ voltage ที่ known ป้องกัน current จาก net อื่นรั่วเข้ามา ทำให้สามารถวัด component แต่ละตัวได้อย่าง isolated

**Fixture สองแบบ:**

**Bed-of-Nails ICT**
- Fixture สั่งทำพิเศษสำหรับ board design นั้นๆ ประกอบด้วย spring-loaded pogo pin หลายร้อยถึงหลายพัน pin ที่ contact test point พร้อมกันทุก pin ในครั้งเดียว
- ความเร็วสูง: test board ใบหนึ่งใน 15-60 วินาที
- ต้นทุน fixture: $5,000-50,000 ขึ้นกับความซับซ้อนของ board
- เหมาะกับ: high-volume stable design (>1,000 units/month) ที่ NRE ของ fixture amortize ได้
- ข้อจำกัด: ต้องมี physical test point ทุก node ที่ต้องการ test — BGA hidden joint ตรวจไม่ได้

**Flying Probe**
- ใช้ robotic probe 4-20 หัวที่เคลื่อนที่ตาม program sequential — ไม่มี dedicated fixture
- ช้ากว่า ICT 5-10x: board ใบเดียวใช้เวลา 2-10 นาทีขึ้นกับ node จำนวน
- ต้นทุน fixture: ศูนย์ (แค่ program)
- เหมาะกับ: prototype, NPI, low-volume (<500 units/month), หรือ board ที่ design เปลี่ยนบ่อย
- ข้อดี: ยืดหยุ่นสูง เปลี่ยน program ใหม่เมื่อ design เปลี่ยน

**สิ่งที่ ICT ตรวจจับได้:**
- Open circuit (connection ขาด)
- Short circuit (net 2 เส้นต่อกันผิดพลาด)
- Component ค่าผิด (resistor 1kΩ แต่ใส่ 10kΩ)
- Component หาย หรือใส่ผิดชนิด
- Polarized component กลับขั้ว
- ICT coverage benchmark: **70-90% ของ manufacturing defect ทั้งหมด**

### FCT: Functional Circuit Test

FCT คือ "black-box" system-level validation — power up board จริง, inject stimulus ที่จำลอง real-world operating condition, แล้ววัด response เทียบกับ expected behavior ตาม design spec ไม่สนว่า component แต่ละตัวดีหรือเปล่า แต่สนว่า ระบบทำงานได้ครบ function ที่ต้องการหรือเปล่า

**FCT fixture ประกอบด้วย:**
- **Mechanical interface**: clamshell (มือกด), pneumatic (ลมกด), หรือ inline (สายพาน) — เชื่อมต่อกับ board ผ่าน pogo pin, edge connector, หรือ high-cycle cable
- **Test instruments**: programmable power supply, signal generator, oscilloscope, multimeter, DAQ
- **Communication interfaces**: UART, SPI, I2C, CAN, Ethernet — ส่ง stimulus และรับ response จาก firmware
- **DUT power supply**: จำลองแหล่งจ่ายไฟ production จริง พร้อม overcurrent protection

**สิ่งที่ FCT ตรวจจับได้:**

| Category | ตัวอย่าง |
|---|---|
| Firmware bug | bootloader ไม่ boot, logic ผิด |
| System instability under load | crash เมื่อรับ max current |
| Signal integrity | noise บน communication bus |
| Analog calibration drift | ADC offset ผิดจาก spec |
| Protocol failure | I2C NACK เมื่อ clock stretch |
| LED / display | สีผิด, segment ดับ |
| Acoustic | speaker มี distortion หรือ no output |
| Thermal | component เกิน temperature limit เมื่อ load ปกติ |

**เมื่อ FCT ใช้:** final gate ก่อน ship หรือก่อน final assembly ใน system-level product เป็นสิ่งที่ OEM จาก industrial, medical, automotive, IoT ต้องการให้ EMS ทำก่อนส่งของทุกครั้ง — เพราะ functional failure ในมือ end user มีต้นทุนสูงกว่าการตรวจ 10x

### Layered Testing Strategy: AOI → ICT → FCT

```
[SMT Line] → [AOI] → [ICT / Flying Probe] → [FCT] → [Ship]
               ↑              ↑                 ↑
          visual defect   component-level   system-level
           (no power)    (no firmware)    (full powered)
```

**ทำไมต้องทำตามลำดับนี้:**

1. **AOI ก่อน ICT**: ถ้า board มี missing component หรือ solder bridge ผ่านเข้า ICT, probe อาจ short, fixture เสียหาย, หรือ ICT ให้ false pass เพราะ circuit topology เปลี่ยน AOI กรอง defect ราคาถูก-ง่ายออกก่อน

2. **ICT ก่อน FCT**: FCT ใช้เวลา 3-20 นาทีต่อ board FCT fixture ราคาแพงกว่า ICT fixture ถ้าปล่อย board ที่มี component ผิดค่าเข้า FCT → FCT fail → ต้องส่ง board กลับ debug ตั้งแต่ต้น เสียเวลา ICT จับ structural defect ก่อน = FCT เจอแต่ board ที่ "โครงสร้างดี" แล้ว ทำให้ FCT fail analysis ชัดขึ้น

3. **FCT เป็น final gate**: ยืนยันว่า board ที่ผ่าน AOI + ICT มาแล้ว สามารถทำ function ได้ครบตาม spec จริง

**Coverage ที่ได้จาก layered approach:**
- AOI เดียว: ~70% (visual coverage)
- AOI + ICT: ~90-95%
- AOI + ICT + FCT: ~97-99%+ (ขึ้นกับ FCT test script coverage)

### ต้นทุนและ ROI ของ Testing Infrastructure

| Test Method | Setup Cost | Per-Unit Cost | Speed | Best ROI At |
|---|---|---|---|---|
| AOI | $30k-150k (machine) | ต่ำมาก | สูง (30-60 brd/hr) | Medium+ volume |
| ICT Bed-of-Nails | $5k-50k (fixture) | ต่ำ | สูง (4 brd/min) | High volume |
| Flying Probe | $0 (program only) | สูงกว่า ICT | ต่ำ (2-10 min/brd) | Low volume / proto |
| FCT | $10k-100k (station) | ปานกลาง | ปานกลาง (3-20 min) | ทุก volume สำหรับ complex product |

กฎง่ายๆ: ถ้า volume > 1,000 units/month → ICT bed-of-nails คุ้มกว่า flying probe ภายใน 2-3 เดือน ถ้า volume < 500 units/month → flying probe ไม่ต้องลงทุน fixture

### FCT Test Script Design

FCT ไม่ได้มาฟรีกับ EMS — OEM ต้องจัดหา หรือ EMS develop ร่วมกับ OEM test script ที่ดีต้องครอบคลุม:

- **Happy path**: ทุก function ทำงานได้ under nominal conditions
- **Boundary conditions**: test ที่ voltage min/max, temperature, signal edge
- **Communication protocol**: verify command/response set ครบ
- **Firmware version check**: ยืนยัน firmware version ที่ถูกต้อง flash ลงไปแล้ว
- **Calibration routines**: ถ้า product ต้องการ calibration ทำตอน FCT พร้อม log ค่า
- **Burn-in / soak**: power on นาน 4-24 ชั่วโมงเพื่อจับ infant mortality failures (optional แต่สำคัญสำหรับ high-reliability product)

## Caveats / Limits

- **AOI false positive rate**: AOI มี false call (reject board ที่จริงดี) เฉลี่ย 1-5% ขึ้นกับ board complexity — ต้องมี human operator ยืนยัน reject ทุกใบก่อน scrap (AOI ห้าม auto-scrap)
- **ICT ไม่ cover BGA**: solder ball ใต้ BGA ไม่มี test point ให้ probe — ต้องใช้ X-ray + JTAG แทน (ดู EP5 สำหรับ JTAG boundary scan)
- **FCT script lag**: FCT script มักไม่ update ทันเมื่อ firmware เปลี่ยน version — OEM ต้องมี process sync FCT script กับ firmware release
- **Flying probe ไม่ scale**: ถ้าใช้ flying probe แล้ว volume เพิ่มขึ้นเกิน 500 units/month → ต้อง plan migrate ไป ICT ล่วงหน้า ไม่ใช่รอจนเกิด backlog
- **FCT station เป็น single point of failure**: ถ้า FCT machine เสีย production หยุดทันที — EMS tier-1 มักมี redundant station อย่างน้อย 2 เครื่อง
- **Test coverage ≠ 100%**: แม้จะทำ AOI + ICT + FCT ครบ ยังมี defect ที่หลุดได้ (เช่น intermittent cold joint ที่ pass ตอน test แต่ fail หลัง thermal cycling 100 รอบ) — นี่คือเหตุผลที่ต้องคู่กับ IPC class criteria ใน EP6

## References

1. [PCB Testing in EMS: AOI, ICT and Functional Test — Elhurt EMS](https://elhurtems.com/en/pcb-testing-strategy-aoi-ict-fct/)
2. [ICT vs FCT: PCBA Test Strategy — NextPCB](https://www.nextpcb.com/blog/ict-vs-fct-pcba-test-strategy)
3. [ICT in Electronics Manufacturing — Fundamental PCBA Testing Principles — NextPCB](https://www.nextpcb.com/blog/in-circuit-testing-fundamental-principles)
4. [Functional Circuit Test (FCT) in PCB & PCB Assembly: Fundamental Guide — NextPCB](https://www.nextpcb.com/blog/fct-test)
5. [What Is FCT (Functional Test)? How It Works in Electronics Manufacturing — PCBSync](https://pcbsync.com/functional-test/)
6. [The Ultimate PCBA Testing (AOI, ICT, FCT) — TopFastPCB](https://www.topfastpcb.com/blog/the-ultimate-pcba-testing/)
7. [Flying Probe vs. Bed of Nails: Choosing the Right PCB Testing Strategy — AllPCB](https://www.allpcb.com/allelectrohub/flying-probe-vs-bed-of-nails-choosing-the-right-pcb-testing-strategy)
8. [PCBA Functional Test (FCT) Planning: Coverage, Fixtures, Logging — APTPCB](https://aptpcb.com/en/blog/pcba-functional-test-fct-planning-guide)
9. [Automated Optical Inspection (AOI): Enhancing PCB Quality — JLCPCB](https://jlcpcb.com/blog/automated-optical-inspection)

## Key Takeaways

- AOI = "สายตา" (visual only), ICT = "มัลติมิเตอร์" (structural electrical), FCT = "ทดสอบใช้งานจริง" — คนละ scope, ไม่แทนกันได้
- ลำดับ AOI → ICT → FCT คือ industry standard — ทำในลำดับนี้เพื่อลด cost of failure ในแต่ละชั้น
- ICT bed-of-nails คุ้มค่าเมื่อ volume > ~1,000 units/month; flying probe เหมาะ proto/low-volume
- FCT coverage ขึ้นกับ test script — OEM ต้องเป็นคนเขียนหรือ review script ไม่ใช่ leave ให้ EMS ทำคนเดียว
- AOI false positive 1-5% ปกติ — ห้าม auto-scrap, ต้องมี human confirm ทุก AOI reject
- Layered AOI + ICT + FCT → 97-99%+ defect coverage; ICT เดียวได้แค่ 70-90%
- ถาม EMS: "FCT station ของคุณมีกี่เครื่อง และมี redundancy ไหม?" — single station = single point of failure ที่ stop production ทันที
