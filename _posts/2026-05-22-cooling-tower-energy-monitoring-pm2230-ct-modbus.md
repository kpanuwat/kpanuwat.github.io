---
title: "วัดพลังงาน Cooling Tower ด้วย Schneider PM2230 + Split-core CT + Modbus RTU"
date: 2026-05-22 00:18:00 +0700
categories: [Engineering]
tags: [energy-monitoring, power-meter, modbus, bms, ems, cooling-tower, schneider, hvac, rs485]
slides: true
---

{% include slide-link.html %}

## TL;DR

ใช้ **Schneider EasyLogic PM2230** ร่วมกับ **Split-core CT** ครอบสาย L1/L2/L3 เพื่อวัด kW, kWh, Voltage, Current และ Power Factor ของระบบ Cooling Tower แบบ 3-phase โดยไม่ต้องดับระบบ ส่งข้อมูลผ่าน **Modbus RTU (RS485)** ไปยัง BMS/EMS — ติดตั้งได้ภายในวันเดียว งบประมาณ **15,000–30,000 บาทต่อจุดวัด**

---

## Background / Why This Matters

ระบบ Cooling Tower เป็นหนึ่งในผู้ใช้พลังงานรายใหญ่ในโรงงาน, อาคารสำนักงาน และ Data Center โดยทั่วไปคิดเป็น **20–40% ของโหลด HVAC ทั้งหมด** ปัญหาที่พบบ่อยคือ Operations Team ไม่รู้ว่าใช้พลังงานเท่าไหร่จริงๆ ในแต่ละช่วงเวลา จึงไม่สามารถ:

- ตรวจจับ **efficiency degradation** เช่น ตะกรัน (scale) บนท่อ หรือ Fan blade สึกหรอ ที่ทำให้ kW สูงขึ้นโดยไม่มีเหตุผล
- พิสูจน์ **ROI ของการซ่อมบำรุง** เช่น หลังล้าง Fill media แล้ว power ลดลงจริงไหม
- รายงาน **carbon footprint** ตาม scope 2 ของ GHG Protocol หรือ ISO 50001 energy baseline

Solution นี้แก้ปัญหาด้วยการติดตั้ง **Power Meter + CT** โดยไม่ต้องตัดไฟ แล้วส่งข้อมูลผ่าน Modbus RTU เข้าสู่ระบบ BMS หรือ EMS ที่มีอยู่

---

## Deep Dive

### ส่วนประกอบหลักของระบบ

```
[ Cooling Tower Motor (3-phase) ]
        │ L1   L2   L3
        ▼
[ Split-core CT x3 ] ─ 5A secondary ─► [ PM2230 CT inputs ]
        │                                      │
[ Voltage tap จาก MCB ] ──────────────► [ PM2230 V inputs (L1,L2,L3,N) ]
                                               │
                                    [ RS485 2-wire (A/B) ]
                                               │
                                    [ BMS / EMS (Modbus Master) ]
```

**อุปกรณ์ที่ต้องใช้:**

| อุปกรณ์ | รุ่น | หมายเหตุ |
|---|---|---|
| Power Meter | Schneider PM2230 (METSEPM2230) | Class 0.5S, RS485 Modbus RTU |
| Split-core CT | 100/5A หรือ 200/5A หรือ 400/5A | เลือกตาม FLA ของ motor |
| RS485 Cable | Belden 3106A หรือ equivalent | 120Ω impedance, shielded |
| Terminal Block | 120Ω termination resistor | ติดที่ปลายสาย RS485 |

---

### Schneider PM2230 — Key Specs

- **Accuracy class:** IEC 62053-22 Class 0.5S (±0.5% FS)
- **CT input:** 5A secondary (รองรับทั้ง 1A และ 5A ตามรุ่น)
- **Voltage input:** 100–277 V L-N หรือ 100–480 V L-L
- **Harmonics:** วัดได้ถึง 31st harmonic + THD per phase
- **Communication:** RS485 Modbus RTU, baud rate 4800–38400 bps, max 32 slaves, max 1200 m
- **Display:** LCD backlit, 7-segment, 4 screens scrollable
- **Mounting:** 96×96 mm panel cutout หรือ DIN rail
- **Operating temp:** -25 ถึง 70°C

พารามิเตอร์ที่วัดได้:

| พารามิเตอร์ | Register (Decimal) | Data Type |
|---|---|---|
| Current L1 (A) | 2999 | Float32 (2 registers) |
| Current L2 (A) | 3001 | Float32 |
| Current L3 (A) | 3003 | Float32 |
| Voltage L1-N (V) | 3027 | Float32 |
| Voltage L2-N (V) | 3029 | Float32 |
| Voltage L3-N (V) | 3031 | Float32 |
| Active Power L1 (kW) | 3053 | Float32 |
| Active Power L2 (kW) | 3055 | Float32 |
| Active Power L3 (kW) | 3057 | Float32 |
| Active Power Total (kW) | 3059 | Float32 |
| Active Energy (kWh) | 2699 | Float32 |
| Frequency (Hz) | (consult PM2200 User Manual) | Float32 |

> **Modbus Function Code:** FC03 (Read Holding Registers). Float32 ใช้ 2 registers ต่อ 1 ค่า — ต้อง byte-swap ตาม IEEE 754 Big-Endian (register 1 = high word, register 2 = low word)

---

### Split-core CT — เลือกขนาดอย่างไร

Split-core CT มีหลักการทำงานเหมือน CT ทั่วไป แต่ **ตัดกลางได้** (hinged design) — ครอบสาย phase ได้เลยโดยไม่ต้องถอดสายออก ลดเวลาติดตั้งและความเสี่ยงการดับระบบ

**วิธีเลือก CT ratio:**

1. ดู **FLA (Full Load Amps)** ของ motor จาก nameplate หรือ MCC
2. คูณ 1.25× เพื่อ headroom: เช่น FLA = 80A → เลือก CT **100/5A**
3. ตรวจสอบว่า secondary output เป็น **5A** (ตรงกับ PM2230 CT input)
4. ใช้ CT ratio ที่เท่ากันทั้ง 3 phase — ratio ไม่ตรงกันทำให้วัดผิดพลาดได้

**ตัวอย่าง Cooling Tower ทั่วไป:**

| ขนาด Cooling Tower (RT) | FLA โดยประมาณ | CT ที่แนะนำ |
|---|---|---|
| 50–100 RT | 30–60A | 75/5A หรือ 100/5A |
| 100–200 RT | 60–120A | 150/5A หรือ 200/5A |
| 200–400 RT | 120–250A | 300/5A หรือ 400/5A |

> Accuracy class ควรเป็น **Class 0.5 หรือดีกว่า** (IEC 61869-2) เพื่อให้ผลการวัดไว้วางใจได้สำหรับ energy reporting

---

### Modbus RTU RS485 — การเดินสายและ Configuration

**Topology: Daisy Chain (แนะนำที่สุด)**

```
[BMS Master] ──── [PM2230 #1] ──── [PM2230 #2] ──── ... ──── [120Ω terminator]
               A/B                A/B                         A/B
```

**กฎสำคัญ:**

- ใช้สาย **Shielded Twisted Pair (STP)** ขนาด AWG22–24, impedance 120Ω
- ต่อ **Shield (drain wire) ที่ฝั่ง Master เท่านั้น** — ไม่ต่อทั้งสองปลาย (ground loop)
- ติด **120Ω termination resistor** ที่ปลายสุดของ bus
- Device สูงสุด 32 ตัวต่อ segment (หากต้องการมากกว่า ใช้ RS485 repeater)
- ระยะสูงสุด 1200 เมตรที่ 9600 bps

**PM2230 Modbus Configuration (ตั้งที่ตัว meter):**

| Parameter | ค่าแนะนำ |
|---|---|
| Slave Address | 1–247 (ไม่ซ้ำในระบบ) |
| Baud Rate | 9600 หรือ 19200 bps |
| Parity | None / Even (ตามที่ Master กำหนด) |
| Stop Bit | 1 (หาก parity ≠ None) หรือ 2 (หาก None) |

---

### ตัวอย่าง Python Poll ด้วย `pymodbus`

```python
from pymodbus.client import ModbusSerialClient

client = ModbusSerialClient(
    port="/dev/ttyUSB0",
    baudrate=9600,
    bytesize=8,
    parity="N",
    stopbits=2,
    timeout=1,
)
client.connect()

# อ่าน Active Power Total (kW) — register 3059, Float32 = 2 registers
result = client.read_holding_registers(address=3059, count=2, slave=1)
if not result.isError():
    import struct
    raw = struct.pack(">HH", result.registers[0], result.registers[1])
    kw_total = struct.unpack(">f", raw)[0]
    print(f"Active Power Total: {kw_total:.2f} kW")

client.close()
```

> Register address ใน `pymodbus` เป็น **0-based** — register 3059 ในเอกสาร Schneider คือ address 3058 ใน pymodbus (ลบ 1)

---

### BMS/EMS Integration Architecture

หลังจาก poll ข้อมูลได้แล้ว ระบบส่วนใหญ่รับข้อมูลผ่าน:

| Integration path | Use case |
|---|---|
| **Modbus TCP Gateway** (เช่น Moxa MGate) | BMS ที่รับ TCP เท่านั้น; แปลง RTU→TCP โดยอัตโนมัติ |
| **Direct RS485 to BACnet** (via gateway) | อาคาร BMS ที่ใช้ BACnet/IP เป็นหลัก |
| **Modbus to MQTT** (via Node-RED / Edge device) | EMS ที่ใช้ Cloud (AWS IoT, Azure IoT Hub) |
| **Direct RS485 to SCADA** (เช่น Ignition, WinCC) | โรงงานที่มี SCADA อยู่แล้ว |

**Data points ที่ควร log ทุก 1–5 นาที:**

- `kW_total` — ตรวจจับ anomaly (peak load, เครื่องเสีย)
- `kWh_total` — คำนวณ energy consumption รายวัน/รายเดือน
- `PF_total` — Power Factor ต่ำกว่า 0.85 ควร investigate
- `I_L1, I_L2, I_L3` — Current imbalance >5% บ่งชี้ปัญหา electrical หรือ motor
- `V_L1N, V_L2N, V_L3N` — Voltage sag/swell

---

### การขยายระบบในอนาคต

PM2230 ออกแบบให้ขยายได้ง่าย:

```
Phase 1: วัด Cooling Tower รวม (CT ครอบ incoming L1/L2/L3 ของตู้ CT)
Phase 2: แยกวัด Fan Motor แต่ละตัว (PM2230 เพิ่ม 1 ตัวต่อ 1 Fan circuit)
Phase 3: แยกวัด Pump Motor (Cooling Water Pump, Condenser Pump)
Phase 4: เพิ่ม ambient sensor (OAT, WBT) → คำนวณ COP หรือ kW/RT
```

การแยกวัดแบบนี้ทำให้รู้ว่า Fan หรือ Pump คือตัวที่กิน energy มากที่สุด และสามารถ prioritize maintenance ได้ถูกจุด

---

## Caveats / Limits

- **Split-core CT accuracy:** Class 0.5–1% (กว้างกว่า solid-core CT ที่ Class 0.1–0.2%) — เหมาะสำหรับ monitoring ไม่ใช่ revenue billing ระหว่างสองฝ่าย
- **CT saturation:** ถ้า load สูงเกิน 120% ของ CT primary rating จะเกิด saturation — วัดผิดพลาดได้; ต้องเลือก ratio ให้มี headroom เพียงพอ
- **RS485 bus contention:** Modbus RTU รองรับ master เดียวต่อ segment — ถ้า BMS และ EMS ต้องการดึงข้อมูลพร้อมกัน ต้องใช้ Gateway หรือ Data Concentrator
- **Wiring noise:** ใกล้ VFD (Variable Frequency Drive) มากจะมี EMI รุนแรง — ใช้ shielded cable และ ferrite core ที่จุดเชื่อมต่อ
- **CT burden:** ต้องตรวจสอบว่า wiring resistance + PM2230 input impedance รวมกันไม่เกิน rated burden ของ CT (เช่น 5VA สำหรับ Class 0.5)
- **PM2230 CT input:** รองรับ **5A secondary เท่านั้น** (ไม่ใช่ 1A หรือ Rogowski coil) — ตรวจสอบให้แน่ใจก่อนซื้อ CT

---

## User Guide (Step-by-Step)

### ขั้นตอนการติดตั้ง

**1. ตรวจสอบ load current ก่อนซื้อ CT**
```bash
# ดูจาก motor nameplate หรือวัดจริงด้วย clamp meter
# FLA ที่อ่านได้ × 1.25 = CT primary rating ที่ต้องใช้
```

**2. ติดตั้ง PM2230 ในตู้ไฟ**
- ตัดช่อง 92×92 mm ในแผง หรือ snap บน DIN rail
- ต่อแรงดัน V1/V2/V3/N จาก MCB 10A (ฝั่ง Load — เพื่อความปลอดภัย)
- ต่อ CT secondary (S1/S2) ทั้ง 3 phase เข้า I1/I2/I3 ของ PM2230

**3. ครอบ Split-core CT บนสาย phase**
- เปิด hinge ของ CT, ครอบที่สาย L1 (phase A), ปิด hinge
- ทำซ้ำกับ L2 (B) และ L3 (C)
- ตรวจสอบว่า polarization mark (`P1` หรือลูกศร) ชี้ไปทิศทางเดียวกันทั้งหมด (ไปทาง load)
- **อย่าเปิด secondary ของ CT ขณะ load ไหลอยู่** — แรงดันสูงอันตราย

**4. เดินสาย RS485**
- ต่อ A/B จาก PM2230 เป็น daisy chain ไปยัง meter ตัวต่อไป หรือ BMS
- ติด 120Ω terminator ที่ปลายสาย
- ต่อ Shield ที่ BMS master เท่านั้น

**5. Configure PM2230**
- กด `Mode` จนเข้า Communication settings
- ตั้ง Slave Address (เช่น 1), Baud Rate (9600), Parity (None)
- ตั้ง CT Ratio ให้ตรงกับ CT ที่ใช้ (เช่น 200)

**6. ทดสอบการสื่อสาร**
```python
# ใช้ Modbus Poll (Windows) หรือ pymodbus เพื่อ poll register 3059
# ค่าที่ได้ควรใกล้เคียงกับ clamp meter ที่วัดแยก
```

**7. เชื่อมต่อกับ BMS/EMS**
- เพิ่ม device ใน BMS ด้วย Slave ID ที่ตั้งไว้
- Map register 3059 → `CT_kW_total`, 2699 → `CT_kWh`, ฯลฯ
- ตั้ง polling interval 60–300 วินาที

---

## References

1. [Schneider Electric PM2230 Product Page — Clipsal](https://www.clipsal.com/products/industrial/pm2000-series/power-energy-meter-up-to-the-31st-harmonic-lcd-display-rs485-class-05s-metsepm2230?itemno=METSEPM2230)
2. [PM2230 Specifications — TechSource Groups (2025)](https://www.techsourcegroups.com/2025/power-energy-meter-pm2230-schneider/)
3. [Schneider Electric PM2200 Series Modbus Register Map — Aggsoft](https://www.aggsoft.com/modbus-data-logging/schneider-electric.htm)
4. [Split-core CT Selection, Installation, and Accuracy — Enwei Electric](https://www.enweielectric.com/blog/split-core-current-transformers)
5. [How to Select the Right Current Transformer — Accuenergy](https://www.accuenergy.com/articles/current-transformers/how-to-select-the-right-current-transformer/)
6. [Modbus RTU over RS485 Cabling Rules — TrackSo](https://trackso.in/knowledge-base/rules-perfect-cabling-modbus-rtu-rs485-communication-systems/)
7. [Modbus Protocol in Building Management Systems — Consteel Electronics](https://consteel-electronics.com/articles/enriching-building-management-systems-bms-with-modbus-solutions-modbus-protocol-in-bms-systems/)

---

## Key Takeaways

- **ไม่ต้องดับระบบ:** Split-core CT ครอบสายไฟได้เลยขณะ energized — ลดความเสี่ยงและ downtime
- **CT ratio selection คือขั้นตอนที่สำคัญที่สุด:** เลือก FLA × 1.25 เพื่อ headroom และต้องเป็น 5A secondary สำหรับ PM2230
- **Daisy chain RS485 + terminator 120Ω:** บังคับ — ไม่มี terminator → signal reflection → data corruption
- **Register เป็น Float32 (2 registers):** ใช้ FC03 อ่าน 2 registers แล้ว unpack IEEE 754 Big-Endian เสมอ
- **Power Factor ต่ำกว่า 0.85 คือ warning sign:** ควรตรวจสอบ motor, VFD, หรือ capacitor bank
- **ขยายได้ทีละ phase:** เริ่มจากวัดรวม ค่อยแยก Fan/Pump — ไม่ต้องรื้อระบบเดิม
- **งบ 15,000–30,000 บาทต่อจุด:** รวม PM2230 + CT 3 ตัว + สาย RS485 + ค่าแรงติดตั้ง; ROI ปกติ < 1 ปีจาก energy saving ที่ตรวจพบ
