---
title: "10 ไอซีพื้นฐานที่ช่วยให้การเรียนรู้อิเล็กทรอนิกส์ง่ายขึ้น"
date: 2026-06-01 00:01:00 +0700
categories: [Engineering]
tags: [electronics, ics, 555-timer, shift-register, logic-gates, op-amp, motor-driver, voltage-regulator]
slides: true
---

{% include slide-link.html %}

## TL;DR

ไอซี (Integrated Circuit) 10 ตัวที่ควรรู้จักก่อนเริ่มต้นเรียนรู้อิเล็กทรอนิกส์ — ตั้งแต่สร้างสัญญาณเวลา, นับเลข, ขยาย LED, ตัดสินใจเชิงตรรกะ, จำสถานะ, ขยายสัญญาณ, ขับมอเตอร์ ไปจนถึงควบคุมแรงดันไฟฟ้า ทั้ง 10 ตัวนี้เป็น "ตัวต่อ" พื้นฐานของโครงงานอิเล็กทรอนิกส์เกือบทุกชนิด

---

## Background / Why this matters

เมื่อเริ่มต้นเรียนรู้อิเล็กทรอนิกส์ มักเจอกำแพงแรก: รู้แค่ว่าต้องต่อวงจร แต่ไม่รู้ว่าไอซีตัวไหนทำอะไรได้บ้าง ทั้งที่ร้านขายอุปกรณ์มีตัวเลือกหลายร้อยชนิด

ไอซีแต่ละตัวในรายการนี้ถูกเลือกเพราะ:
- **ราคาถูก** (ส่วนใหญ่ไม่เกิน 20–50 บาท)
- **หาซื้อง่าย** (มีในร้านอิเล็กทรอนิกส์ทั่วไปและออนไลน์)
- **ใช้งานได้กว้าง** — เรียนรู้ตัวหนึ่งแล้วนำหลักการไปประยุกต์ต่อได้
- **เป็นฐานของไอซีสมัยใหม่** — ไมโครคอนโทรลเลอร์เช่น Arduino/ESP32 ก็ใช้แนวคิดเดียวกันภายใน

---

## Deep Dive

### 1. NE555 Timer — สร้างสัญญาณเวลา

555 Timer เป็นไอซีที่ขายดีที่สุดในประวัติศาสตร์อิเล็กทรอนิกส์ ออกแบบโดย Hans Camenzind ในปี 1972 มีขา 8 ขา ทำงานได้ 3 โหมด:

| โหมด | การทำงาน | ตัวอย่างการใช้งาน |
|------|----------|------------------|
| **Astable** | สร้างสัญญาณสี่เหลี่ยม (clock) ต่อเนื่อง | LED กระพริบ, oscillator |
| **Monostable** | ให้ pulse เดียวเมื่อได้รับ trigger | Debounce ปุ่ม, delay timer |
| **Bistable** | จำสถานะ HIGH/LOW จนกว่าจะถูก reset | SR Latch อย่างง่าย |

**สูตรความถี่ (Astable mode):**
```
f = 1.44 / ((R1 + 2×R2) × C)
```
ปรับ R2 เป็น potentiometer → ความถี่เปลี่ยนได้ทันที

**Pinout:**
- Pin 1: GND
- Pin 2: Trigger (ถ้าต่ำกว่า 1/3 Vcc → output HIGH)
- Pin 3: Output
- Pin 4: Reset (ต่อ HIGH เพื่อใช้งานปกติ)
- Pin 5: Control Voltage (ต่อ capacitor 10nF ป้องกัน noise)
- Pin 6: Threshold (สูงกว่า 2/3 Vcc → output LOW)
- Pin 7: Discharge
- Pin 8: Vcc (4.5–15V)

---

### 2. CD4017 Decade Counter — นับและแสดงผลแบบลำดับ

CD4017 เป็น Decade Counter มี output 10 ขา (Q0–Q9) แต่ละครั้งที่รับ clock pulse จาก pin CLK output จะเลื่อนไปทีละขา ใช้คู่กับ 555 Timer (astable mode) เป็น clock → ได้ LED Chaser วงจรคลาสสิคสำหรับมือใหม่

```
555 Timer (astable) → CLK pin ของ CD4017
Q0–Q9 → ต่อ LED ผ่าน resistor 470Ω → GND
```

**Key pins:**
- CLK (pin 14): รับ clock signal
- CLK EN (pin 13): ต้องต่อ GND เพื่อให้นับ
- RST (pin 15): ต่อ GND ปกติ; HIGH → reset กลับ Q0
- Q0–Q9 (pin 3,2,4,7,10,1,5,6,9,11): output แบบ one-hot (HIGH ทีละขา)
- Carry Out (pin 12): ส่งออก pulse ทุก 10 counts → daisy-chain ได้

---

### 3. 74HC595 Shift Register — ควบคุม 8 LEDs ด้วย 3 สัญญาณ

74HC595 เป็น SIPO (Serial-In Parallel-Out) shift register 8 บิต ควบคุม output 8 ขา ด้วย input เพียง 3 ขา ประหยัด GPIO ของ microcontroller ได้มาก

**3 สัญญาณควบคุม:**
| Pin | ชื่อ | หน้าที่ |
|-----|------|---------|
| 14 (SER/DS) | Data | รับข้อมูล 1 bit ต่อครั้ง |
| 11 (SRCLK/SHCP) | Shift Clock | เลื่อน bit เข้า shift register |
| 12 (RCLK/STCP) | Latch Clock | โอน shift register → output ทีเดียว |

**ตัวอย่าง Arduino:**
```cpp
void shiftOut595(int data) {
  for (int i = 7; i >= 0; i--) {
    digitalWrite(DATA_PIN, (data >> i) & 1);
    digitalWrite(CLK_PIN, HIGH); delayMicroseconds(5);
    digitalWrite(CLK_PIN, LOW);
  }
  digitalWrite(LATCH_PIN, HIGH); delayMicroseconds(5);
  digitalWrite(LATCH_PIN, LOW);
}
```

**Daisy-chain:** ต่อ Q7S (pin 9) ของตัวแรกเข้า SER ของตัวที่สอง → ควบคุม 16 output ด้วย 3 สัญญาณเดิม

---

### 4–6. Logic Gates — การตัดสินใจเชิงตรรกะ

Logic gates คือ building block ของดิจิทัลอิเล็กทรอนิกส์ทั้งหมด สัญญาณ HIGH (logic 1) หรือ LOW (logic 0) ถูกประมวลผลตามตาราง truth table

| ไอซี | ประเภท Gate | Package | ตัวอย่างการใช้งาน |
|------|------------|---------|------------------|
| **74HC08** | AND (4x) | DIP-14 | เปิดวงจรเมื่อ 2 เงื่อนไขเป็นจริงพร้อมกัน |
| **74HC32** | OR (4x) | DIP-14 | เปิดวงจรเมื่ออย่างน้อย 1 เงื่อนไขเป็นจริง |
| **74HC04** | NOT/Inverter (6x) | DIP-14 | กลับสัญญาณ; สร้าง oscillator อย่างง่าย |
| **74HC00** | NAND (4x) | DIP-14 | Universal gate — สร้างวงจรอื่นได้ทุกแบบ |

**NAND ทำได้ทุกอย่าง:** AND = NAND+NOT, OR = NOT(A) NAND NOT(B), ดังนั้น 74HC00 ตัวเดียวสามารถสร้าง logic ใดก็ได้ในทางทฤษฎี

---

### 7. Flip-Flop (74HC74) — หน่วยความจำ 1 บิต

Flip-Flop คือ bistable circuit ที่จำสถานะ HIGH/LOW ได้แม้เมื่อ input เปลี่ยน 74HC74 มี D-type Flip-Flop 2 ตัวในชิปเดียว

**D Flip-Flop ทำงานอย่างไร:**
- เมื่อ clock rising edge มาถึง → output Q จำค่า D ณ ขณะนั้น
- ไม่สนใจ input ระหว่าง clock cycles → edge-triggered

**การใช้งาน:**
- **Frequency divider:** ต่อ Q̄ กลับเข้า D → output เป็น clock ½ ความถี่
- **Shift register:** ต่อหลายตัวเป็น chain
- **Debounce:** จำสถานะสุดท้ายของปุ่ม

---

### 8. Op-Amp (LM358) — ขยายสัญญาณ

Operational Amplifier (Op-Amp) ขยายสัญญาณแรงดันได้หลายพันเท่า LM358 เป็น dual op-amp (2 ตัวในชิปเดียว) ใช้ไฟเลี้ยง 3–32V

**2 configurations พื้นฐาน:**

**Non-Inverting Amplifier:**
```
Gain = 1 + (Rf / R1)
Vout = Vin × Gain
```

**Inverting Amplifier:**
```
Gain = -(Rf / R1)   ← มีเครื่องหมายลบ (กลับเฟส)
```

**การใช้งาน:** ขยายสัญญาณจาก sensor (microphone, thermistor, LDR) ก่อนส่งให้ ADC ของ microcontroller

---

### 9. Comparator (LM393) — เปรียบเทียบแรงดัน

LM393 เป็น dual comparator เปรียบเทียบ V+ กับ V− และให้ output HIGH/LOW
- ถ้า V+ > V− → output HIGH
- ถ้า V+ < V− → output LOW

**ต่างจาก op-amp อย่างไร:** comparator ออกแบบมาเพื่อ saturation (output ไปถึง rail) ส่วน op-amp ออกแบบมาเพื่อ linear operation; ใช้ op-amp เป็น comparator ได้แต่ช้ากว่า

**ตัวอย่าง light sensor:**
```
V+: แรงดันจาก voltage divider (LDR + 10kΩ)
V−: ต่อ potentiometer เป็น reference threshold
Output: เปิด/ปิด relay หรือ LED ตามระดับแสง
```

---

### 10. Voltage Regulators (L7806 / LM317) — ควบคุมแรงดันไฟฟ้า

**L78xx Series (Fixed):**
- L7805 → 5V, L7806 → 6V, L7812 → 12V
- Input: Vin ต้องสูงกว่า Vout อย่างน้อย 2–3V (dropout voltage)
- Max current: 1A (TO-220 package)
- ใช้งาน: ต่อ capacitor 0.1μF และ 10μF ที่ขา input/output เพื่อป้องกัน oscillation

**LM317 (Adjustable, 1.25–37V):**
```
Vout = 1.25 × (1 + R2/R1)
```
ค่าเริ่มต้นที่ใช้: R1 = 240Ω, R2 = potentiometer → ปรับแรงดันได้

**L293D Motor Driver** (ไม่ใช่ regulator แต่ต้องใช้ร่วมกัน):
- H-bridge driver ขับ DC motor 2 ตัว หรือ stepper motor 1 ตัว
- Input: logic signal จาก microcontroller (3.3V/5V)
- Output: up to 36V / 600mA per channel
- IN1/IN2 กำหนดทิศทาง; EN กำหนด speed (PWM)

---

## Caveats / Limits

- **Supply voltage ต้องตรง:** 74HC series ทำงาน 2–6V; CD4000 series ทำงาน 3–18V; อย่าสับสนกัน
- **Input floating ทำให้ oscillate:** ขา input ของ logic gate ที่ไม่ได้ต่อสัญญาณต้องต่อ pull-up หรือ pull-down resistor เสมอ
- **L293D กินพลังงานมาก:** มี voltage drop ~2V และ efficiency ต่ำ ถ้า motor > 1A ใช้ L298N หรือ DRV8833 แทน
- **LM317 ต้องการ minimum load:** ต้องมีกระแสไหล ≥3.5mA เสมอ มิฉะนั้น output voltage จะไม่เสถียร
- **Op-Amp rail-to-rail:** LM358 output ไม่ถึง supply voltage เต็มๆ (ห่างประมาณ 1V) ถ้าต้องการ output ใกล้ rail ใช้ rail-to-rail op-amp เช่น MCP6002
- **555 Timer ใช้กระแสสูง:** ในบางโหมด 555 ดึงกระแส spike สูง ใส่ decoupling capacitor 100nF ใกล้ขา Vcc เสมอ

---

## References

1. [NE555N Timer Complete Guide - Fly-Wing](https://www.flywing-tech.com/blog/ne555n-timer-complete-guide/)
2. [CD4017 Decade Counter Datasheet & Application - Jotrin Electronics](https://www.jotrin.com/technology/details/the-ultimate-guide-to-cd4017-decade-counter-datasheet-application)
3. [74HC595 Shift Register with Arduino - Last Minute Engineers](https://lastminuteengineers.com/74hc595-shift-register-arduino-tutorial/)
4. [Serial to Parallel Shift Out with 74HC595 - Arduino Official Docs](https://docs.arduino.cc/tutorials/communication/guide-to-shift-out)
5. [LED Chaser Circuit with 555 Timer and CD4017 - Digi-Key](https://www.digikey.com/en/maker/projects/led-chaser-circuit-with-555-timer-and-cd4017/676f97426260456196765325905b8832)
6. [Popular ICs for DIY Electronics - Eleccircuit](https://www.eleccircuit.com/electronics-components-datasheets/)
7. [74HC595 Serial-to-Parallel Shift Register Guide - Build Electronic Circuits](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc595-74ls595/)
8. [CD4017 Decade Counter with Decoded Output - Build Electronic Circuits](https://www.build-electronic-circuits.com/4000-series-integrated-circuits/ic-4017/)
9. Source video: [10 Essential ICs for Electronics Beginners](https://youtu.be/h5NXvS098mA)

---

## Key Takeaways

- **555 Timer** คือจุดเริ่มต้นที่ดีที่สุด — ทำงานได้ 3 โหมดและเชื่อมต่อกับไอซีอื่นทุกตัวในรายการนี้ได้
- **74HC595** สอนหลักการ serial communication — แนวคิดเดียวกับ SPI ที่ microcontroller สมัยใหม่ใช้
- **Logic gates** เป็นพื้นฐานของ CPU ทุกตัวในโลก เข้าใจ AND/OR/NOT/NAND แล้วจะเข้าใจ digital logic ทั้งหมด
- **Flip-flop** คือ RAM ที่เล็กที่สุด — 1 bit; RAM 8GB ในคอมพิวเตอร์คือ flip-flop 64 พันล้านตัวในชิปเดียว
- **Op-Amp + Comparator** ช่วยให้ microcontroller "อ่าน" โลกอนาล็อก — sensor ทุกชนิดต้องผ่านสองตัวนี้ก่อน
- **L293D** คือสะพานระหว่าง logic (3.3V/5V) กับกลไก (12V/motor) — หลักการ H-bridge ใช้ใน EV ขนาดใหญ่เช่นกัน
- **Voltage regulators** — เรียนรู้ก่อน ประหยัดไอซีที่ตายจากแรงดันเกินได้หลายร้อยตัว
