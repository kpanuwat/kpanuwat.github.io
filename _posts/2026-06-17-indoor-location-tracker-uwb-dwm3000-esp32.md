---
title: "Indoor Location Tracker: ติดตามตำแหน่งในอาคารระดับ 10 ซม. ด้วย UWB DWM3000 + ESP32"
date: 2026-06-16 00:04:00 +0700
categories: [Engineering]
tags: [uwb, esp32, indoor-positioning, trilateration, iot, dwm3000]
image:
  path: /assets/images/uwb_esp32_cheatsheet.png
  alt: UWB DWM3000 + ESP32 Indoor Location Tracker Cheatsheet
---

## TL;DR

ระบบ Indoor Location Tracker ความแม่นยำระดับ 10 ซม. สร้างจาก Qorvo DWM3000 UWB module + ESP32 จำนวน 4 ชุด — Anchor 3 ตัวติดตั้งประจำจุด Tag 1 ตัวเคลื่อนที่ — วัดระยะด้วย DS-TWR แล้ว Trilaterate พิกัดบน Floor Plan ผ่าน Python script รันบน PC

## Background / Why this matters

**ทำไม GPS ไม่ได้ผลในอาคาร?** สัญญาณดาวเทียมถูกบล็อกและสะท้อนจากโครงสร้างอาคาร ทำให้ความแม่นยำลดลงเหลือ 5–30 เมตร ขณะที่ Wi-Fi RSSI ให้ความแม่นยำเพียง ±3 เมตร Bluetooth BLE เพียง ±1–3 เมตร ทั้งสองเทคนิควัดจาก signal strength ซึ่งได้รับผลกระทบจากผนัง คน และการสะท้อน

**Ultra-Wideband (UWB)** แก้ปัญหาโดยวัด Time-of-Flight ของสัญญาณวิทยุที่ความถี่ 6.5 GHz และ 8 GHz ด้วยความแม่นยำระดับนาโนวินาที ทำให้แปลงเป็นระยะทางได้แม่นถึง ~10 ซม. เทคโนโลยีนี้คือหัวใจของ Apple AirTag, iPhone U1 chip และระบบ RTLS (Real-Time Location System) ในโรงงาน

**ทำไมโปรเจกต์นี้น่าสนใจ:** ใช้ hardware ราคาประหยัด (DWM3000 module + ESP32) สร้างระบบที่ทำงานเทียบเท่าระบบ RTLS ระดับอุตสาหกรรม ประยุกต์ใช้ได้ในคลังสินค้า งานหุ่นยนต์ และโดรนในพื้นที่ปิด

## Deep Dive

### UWB vs เทคโนโลยีอื่น

| เทคโนโลยี | วิธีวัด | ความแม่นยำ | ช่วงสัญญาณ |
|-----------|---------|-----------|-----------|
| GPS | Time-of-Flight (satellite) | 5–30 ม. (ในอาคาร) | ไม่จำกัด |
| Wi-Fi RSSI | Signal Strength | ±3 ม. | 50–100 ม. |
| Bluetooth BLE | Signal Strength | ±1–3 ม. | 10–30 ม. |
| **UWB DWM3000** | **Time-of-Flight (nanosec)** | **~10 ซม.** | **~50 ม.** |

### Hardware: Qorvo DWM3000 Module

DWM3000 เป็น UWB module สำเร็จรูปที่ใช้ชิป DW3110 รองรับ IEEE 802.15.4z มาพร้อม:
- Omnidirectional antenna ในตัว
- RF circuitry + power management ครบในโมดูลเดียว
- รองรับ 2 ช่องสัญญาณ: **Channel 5 (6.5 GHz)** และ **Channel 9 (8 GHz)**
- Interface: **SPI ที่ 38 MHz**
- จำหน่ายในรูปแบบ shield ไม่ต้องบัดกรี SMD — เชื่อมต่อด้วย jumper wire ได้เลย

### SPI Wiring: DWM3000 → ESP32

| DWM3000 | ESP32 | ฟังก์ชัน |
|---------|-------|---------|
| VCC | 3.3V | ⚠️ 3.3V เท่านั้น — 5V จะเสียหาย |
| GND | GND | Ground |
| SCK | GPIO18 | SPI Clock |
| MOSI | GPIO23 | Data: ESP32 → DWM3000 |
| MISO | GPIO19 | Data: DWM3000 → ESP32 |
| CS | GPIO4 | Chip Select |
| RST | GPIO27 | Hardware Reset |
| IRQ | GPIO34 | Interrupt (optional) |

### Tag vs Anchor: บทบาทต่างกัน firmware ต่างกัน

Hardware ทั้ง 4 ชุดเหมือนกันทุกประการ แต่แยกด้วย firmware ที่ flash:

```
├── Anchor (3 ตัว) — ติดตั้งประจำมุมห้องที่ตำแหน่งทราบแน่นอน
│   └── รอรับ Poll packet → ตอบ Response → บันทึก TX/RX timestamp
│
└── Tag (1 ตัว) — เคลื่อนที่ได้
    ├── ส่ง Poll ไปหา Anchor แต่ละตัวตามลำดับ
    ├── คำนวณระยะทาง (DS-TWR)
    └── ส่งพิกัดผ่าน Wi-Fi TCP port 7007 ไปยัง PC
```

### DS-TWR Algorithm: ทำไมต้องใช้ Double-Sided?

**Two-Way Ranging (TWR) ธรรมดา** วัด round-trip time แล้วหาร 2 เพื่อได้ Time of Flight (ToF) ปัญหา: นาฬิกาของ ESP32 แต่ละตัวต่างกันเล็กน้อย (clock drift) ทำให้คำนวณ ToF ผิดพลาด

**Double-Sided TWR (DS-TWR)** เพิ่ม round-trip อีกรอบเพื่อ cancel-out clock drift:

```
Tag                    Anchor
 |--- Poll (T₁) ------->|  T₂ (รับ)
 |                       |  T₃ (ส่ง Response)
 |<-- Response (T₄) ----|
 |--- Final (T₅) ------->|  T₆ (รับ)

Tround1 = T₄ - T₁   (round trip 1 ฝั่ง Tag)
Treply1 = T₃ - T₂   (reply delay ฝั่ง Anchor)
Tround2 = T₆ - T₃   (round trip 2 ฝั่ง Anchor)
Treply2 = T₅ - T₄   (reply delay ฝั่ง Tag)

ToF = (Tround1 × Tround2 - Treply1 × Treply2) /
      (Tround1 + Tround2 + Treply1 + Treply2)

Distance = ToF × speed_of_light (≈ 3×10⁸ m/s)
```

### Trilateration: หาพิกัดจาก 3 วงกลม

เมื่อทราบระยะจาก Tag ไปยัง Anchor ทั้ง 3 ตัว (d₁, d₂, d₃) สามารถเขียนสมการวงกลมได้:

```
(x - x₁)² + (y - y₁)² = d₁²   # วงกลมรอบ Anchor 1
(x - x₂)² + (y - y₂)² = d₂²   # วงกลมรอบ Anchor 2
(x - x₃)² + (y - y₃)² = d₃²   # วงกลมรอบ Anchor 3
```

จุดตัดของวงกลมทั้ง 3 คือตำแหน่ง Tag ในโลกจริง เนื่องจากมี noise จึงไม่ตัดกันพอดี ใช้ `scipy.optimize.least_squares()` หาจุดที่ minimize ผลรวมความคลาดเคลื่อน

ตัวอย่าง anchor coordinate ใน `floor_view.py`:
```python
ANCHOR_POSITIONS = np.array([
    [15, 5],      # Anchor 1 (มุมล่างซ้าย)
    [290, 5],     # Anchor 2 (มุมล่างขวา)
    [165, 625]    # Anchor 3 (กลางบน)
])  # หน่วยเป็น ซม.
```

### Wi-Fi Transmission + floor_view.py

Tag ส่งข้อมูล JSON ผ่าน TCP socket:
```cpp
const char *host = "192.168.xx.xx";  // IP ของ PC
const int port = 7007;
```

Python script รับค่า → คำนวณ trilateration → plot จุดสีแดงบน floor plan image:
```python
# dependencies
pip install numpy scipy matplotlib
```

ต้องวัดพิกัดจริงของ Anchor แต่ละตัวในห้องและ hardcode ลงใน script ก่อน รัน เพื่อให้ภาพ floor plan มี scale ถูกต้อง (ใช้ iPhone LiDAR scan floor plan ก็ได้)

## User Guide (Step-by-Step)

**สิ่งที่ต้องเตรียม:**
- 4× Qorvo DWM3000 shield module
- 4× ESP32-WROOM development board
- 4× USB cable + power adapter
- PC ที่มี Python 3.x

**ขั้นตอน:**

1. **Clone repo:**
   ```bash
   git clone https://github.com/Circuit-Digest/ESP32-DWM3000-UWB-Indoor-RTLS-Tracker
   cd ESP32-DWM3000-UWB-Indoor-RTLS-Tracker
   ```

2. **ต่อสาย SPI** ตามตารางด้านบน ระวัง: ใช้ **3.3V เท่านั้น** — 5V จะเผาโมดูล

3. **Flash firmware ด้วย PlatformIO:**
   - เปิดโฟลเดอร์ `UWB_Arduino/` ใน VS Code
   - แก้ไข Wi-Fi SSID, password, และ IP ของ PC ใน tag firmware
   - Flash `anchor_firmware` ให้ ESP32 ทั้ง 3 ตัวที่เป็น Anchor
   - Flash `tag_firmware` ให้ ESP32 ตัวที่เป็น Tag

4. **ติดตั้ง Python dependencies:**
   ```bash
   pip install numpy scipy matplotlib
   ```

5. **วัดและ config Anchor positions:**
   - วัดระยะ X, Y ของ Anchor แต่ละตัวจากมุมห้อง (หน่วย ซม.)
   - แก้ไข `ANCHOR_POSITIONS` ใน `py_script/floor_view.py`
   - เตรียม floor plan image (top-down view) วาง scale ให้ตรง

6. **เปิดระบบ:**
   - เปิด Anchor ก่อน → รอ 3 วินาที → เปิด Tag
   - รัน `python py_script/floor_view.py`
   - เห็น Tag เป็นจุดแดงเคลื่อนที่บน floor plan

7. **Antenna Delay Calibration** (เพื่อความแม่นยำสูงสุด):
   - วางคู่ anchor-tag ห่างกัน 1 เมตรพอดี
   - ปรับค่า `ANTENNA_DELAY` ใน firmware จนการวัดแสดง 100 ซม.

## Caveats / Limits

- **Line-of-sight สำคัญมาก** — ผนัง โต๊ะ หรือคนที่อยู่ระหว่าง Tag กับ Anchor ทำให้สัญญาณสะท้อน (NLOS) และ error พุ่งเป็น 30–50 ซม. ได้
- **ต้อง hardcode Anchor coordinates** — ถ้าขยับ Anchor ต้องวัดและอัปเดต script ทุกครั้ง
- **แค่ 2D tracking** — ระบบนี้คำนวณ X, Y เท่านั้น ไม่รองรับ Z (ความสูง)
- **Wi-Fi Latency** — TCP over Wi-Fi เพิ่ม latency ~5–20 ms ไม่เหมาะกับ use case ที่ต้องการ update rate >50 Hz
- **3.3V เท่านั้น** — DWM3000 ทนได้สูงสุด 3.6V การต่อกับ 5V GPIO โดยตรงจะเสียหาย
- **Antenna delay per-unit** — โมดูลแต่ละตัวมีค่า delay ต่างกันเล็กน้อย ต้อง calibrate ทีละตัว
- **Range ~50 เมตร** ในพื้นที่ปิดที่สะอาด — real-world อาจลดลงถ้ามีสิ่งกีดขวาง

## References

1. Circuit Digest — [DIY UWB Indoor Positioning System using ESP32 and Qorvo DWM3000](https://circuitdigest.com/microcontrollers-projects/diy-indoor-uwb-positioning-system-using-esp32-and-qorvo-dwm3000)
2. YouTube — [How to build an Indoor Position Tracker using ESP32 and Qorvo UWB DWM3000 (Circuit Digest)](https://youtu.be/tU45avfoSFU)
3. GitHub — [Circuit-Digest/ESP32-DWM3000-UWB-Indoor-RTLS-Tracker](https://github.com/Circuit-Digest/ESP32-DWM3000-UWB-Indoor-RTLS-Tracker)
4. Hackster.io — [Real-Time UWB Indoor Positioning System Using ESP32](https://www.hackster.io/ElectroScopeArchive/real-time-uwb-indoor-positioning-system-using-esp32-c1c834)
5. DigiKey Maker — [DIY UWB Indoor Positioning System using ESP32 and Qorvo DWM3](https://www.digikey.be/en/maker/projects/how-to-build-an-uwb-indoor-positioning-system-using-esp32-and-qorvo-dwm3/01d746fe3c594cccb0aacfdcbc8196fb)

## Key Takeaways

- UWB วัด **Time-of-Flight** ไม่ใช่ Signal Strength — จึงแม่นยำกว่า Wi-Fi/BLE หลายเท่า (~10 ซม. vs ±3 ม.)
- **DS-TWR** ใช้ 2 round-trip exchange เพื่อ cancel clock drift ระหว่าง ESP32 แต่ละตัว
- Hardware เหมือนกันทุกตัว แยก Tag/Anchor ด้วย **firmware** ที่ flash
- **Trilateration = ตัดกัน 3 วงกลม** — ใช้ `scipy.optimize.least_squares()` รับมือ noise
- Anchor ต้องเปิดก่อน Tag เสมอ และต้อง **calibrate antenna delay** ทีละตัวเพื่อความแม่นยำสูงสุด
- ประยุกต์ได้กับ: Asset tracking ในคลังสินค้า, นำทางหุ่นยนต์, Drone indoor navigation
