---
title: "ดัดแปลง HolyIoT Beacon เป็นปุ่ม Smart Home Matter over Thread กินไฟ 6 µA"
date: 2026-06-07 00:02:00 +0700
categories: [Engineering]
tags: [matter, thread, nrf54l15, smart-home, iot, bluetooth-beacon, power-optimization, 3d-printing, zephyr]
---

## TL;DR

บอร์ด HolyIoT 25008 เป็น Bluetooth Beacon ราคาถูกที่ใช้ชิป nRF54L15 ของ Nordic ซึ่งรองรับ Matter over Thread ได้เต็มรูปแบบ — ด้วยการใช้ Raspberry Pi Pico เป็น SWD probe แฟลชเฟิร์มแวร์ Zephyr ใหม่เข้าไปโดยไม่ต้องบัดกรีเลย และปรับโค้ดให้กินกระแสเหลือ 6 µA ในโหมดสลีป บอร์ดขนาด 32 มม. นี้จึงกลายเป็นปุ่ม Smart Home ที่ใช้พลังงานจากถ่านกระดุมได้นานกว่า 2 ปี รองรับทั้งกด เปิด/ปิด, หมุน หรี่ไฟ, และดับเบิ้ลแท็บ เปิดเซนเซอร์ชั่วคราว

## Background / Why this matters

ปุ่ม Smart Home ทั่วไปในตลาดมักราคาแพงหรือต้องผูกกับ ecosystem ของแบรนด์ใดแบรนด์หนึ่ง แต่มาตรฐาน **Matter over Thread** เปิดทางให้อุปกรณ์จากต่างค่ายคุยกันได้โดยตรง ไม่ต้องง้อคลาวด์ และ nRF54L15 คือชิปที่ Nordic ออกแบบมาโดยเฉพาะสำหรับงานนี้

HolyIoT 25008 เป็นโมดูล Bluetooth Beacon ที่ขายบน AliExpress ราคาประมาณ $5–10 ต่อชิ้น แต่ภายในคือชิป nRF54L15 ตัวเดียวกับที่ใช้ในชุดพัฒนา nRF54L15-DK ราคาหลายพัน — มีทั้ง RAM 256 KiB, Flash 1.5 MB, CPU ARM Cortex-M33 @ 128 MHz, และวิทยุ multi-protocol รองรับ BLE 6.0, Thread, Zigbee, และ Matter บนบอร์ดขนาดแค่ 32 มม.

การ "ดัดแปลง" ในที่นี้คือการเขียนเฟิร์มแวร์ใหม่เข้าไปผ่านพอร์ต SWD ที่บอร์ดมีอยู่แล้ว ไม่มีการตัดหรือบัดกรีวงจรใหม่แต่อย่างใด

## Deep Dive

### ชิป nRF54L15 กับ Matter ICD

nRF54L15 รองรับโหมด **ICD (Intermittently Connected Device)** ซึ่งเป็นมาตรฐาน Matter สำหรับอุปกรณ์ที่ทำงานด้วยแบตเตอรี่ อุปกรณ์จะสลีปและตื่นมาเช็ค Thread mesh เป็นช่วงๆ แทนที่จะออนไลน์ตลอดเวลา ซึ่งช่วยประหยัดพลังงานได้มาก

ลักษณะเฉพาะของชิปที่เกี่ยวกับ power:

| พารามิเตอร์ | ค่า |
|---|---|
| System ON sleep + 256 KB RAM retention | ~3.0 µA |
| กระแสขณะรับส่งข้อมูล Thread | ~4–7 mA peak |
| กระแสเฉลี่ย (ICD button mode) | **~6 µA** |
| แบตเตอรี่ CR2032 (225 mAh) | **>2 ปี** |

### HolyIoT 25008: ฮาร์ดแวร์บนบอร์ด

บอร์ดนี้มีส่วนประกอบสำคัญดังนี้ (ตาม Zephyr board definition):

- **CPU**: ARM Cortex-M33 (nRF54L15)
- **Crystal**: 32 MHz HFXO + 32.768 kHz LFXO
- **LED**: RGB LED 1 ดวง
- **ปุ่ม**: push button 1 ปุ่ม
- **IMU**: LIS2DH12 accelerometer (ใช้สำหรับ double-tap detection)
- **พอร์ต debug**: SWD (เข้าถึงได้ผ่าน pad บนบอร์ด)

บอร์ดในวิดีโอมี 2 รุ่น:
1. **รุ่นปุ่มเปล่า** — กด/หมุน/แตะ สำหรับ light control
2. **รุ่น T&H** — เพิ่ม sensor วัดอุณหภูมิและความชื้น กินไฟเท่าเดิม (~6 µA)

### วิธีแฟลชด้วย Raspberry Pi Pico (ไม่บัดกรี)

แทนที่จะใช้ J-Link debugger ราคาแพง วิดีโอใช้ **Raspberry Pi Pico** เป็น SWD probe ผ่านเฟิร์มแวร์ **Picoprobe** ซึ่งเป็น open-source และใช้ร่วมกับ OpenOCD:

```
Raspberry Pi Pico (Picoprobe firmware)
    ├── GP2 → SWDCLK (HolyIoT 25008)
    ├── GP3 → SWDIO  (HolyIoT 25008)
    ├── GND → GND
    └── 3V3 → VDD
```

ขั้นตอนโดยย่อ:

```bash
# 1. Flash Picoprobe ลง Pico
# (drag-and-drop .uf2 ไฟล์ขณะกดปุ่ม BOOTSEL)

# 2. Build เฟิร์มแวร์ Matter button ด้วย nRF Connect SDK
west build -b holyiot_25008/nrf54l15/cpuapp -- \
  -DCONFIG_CHIP_DEVICE_TYPE="MA-L-DIY-button" \
  -DCONFIG_CHIP_ENABLE_ICD_SERVER=y

# 3. Flash ผ่าน OpenOCD + Picoprobe
west flash --runner openocd \
  --openocd-commands "adapter driver cmsis-dap"
```

### Interaction Model: กด / หมุน / ดับเบิ้ลแท็บ

| ท่าทาง | ฟังก์ชัน |
|---|---|
| กด 1 ครั้ง | Toggle เปิด/ปิดไฟ |
| หมุน | หรี่ไฟ (Dimmer level ±10% ต่อ step) |
| ดับเบิ้ลแท็บ (LIS2DH12) | เปิด sensor mode ชั่วคราว (เช่น ส่งค่าอุณหภูมิ 60 วิ แล้วกลับ sleep) |

Double-tap detection ใช้ interrupt จาก LIS2DH12 accelerometer โดยตรง — ไม่ต้องตื่น CPU ตลอดเวลา

### Power Optimization: จาก beacon สู่ 6 µA

สิ่งที่ต้องปรับในโค้ดเพื่อให้ถึง 6 µA:

```c
/* ปิด peripheral ที่ไม่ใช้ */
CONFIG_UART_CONSOLE=n
CONFIG_LOG=n
CONFIG_SHELL=n

/* ตั้งค่า ICD ให้ตื่น check-in ทุก 30 วิ */
CONFIG_CHIP_ICD_SLOW_POLL_INTERVAL=30000
CONFIG_CHIP_ICD_FAST_POLLING_INTERVAL=200

/* ใช้ LFXO แทน RC oscillator เพื่อ accuracy + ประหยัดไฟ */
CONFIG_CLOCK_CONTROL_NRF_K32SRC_XTAL=y
```

### เคส 3D Print

เคสออกแบบให้บอร์ด 32 มม. ใส่พอดี พร้อมช่อง CR2032 และฝาปิดแบบสกรู ไฟล์ STL แชร์บน Printables/Thingiverse (ดูลิงก์ในวิดีโอ)

## User Guide (Step-by-Step)

### สิ่งที่ต้องเตรียม

- HolyIoT 25008 (AliExpress — ค้นหา "HolyIoT nRF54L15")
- Raspberry Pi Pico (ตัวไหนก็ได้ — ทั้ง Pico 1 และ Pico 2 ใช้ได้)
- สาย Dupont 4 เส้น (Female-Female)
- nRF Connect SDK + West CLI (ติดตั้งตาม Nordic docs)
- Thread Border Router ที่พร้อมใช้งาน (เช่น Apple HomePod mini, Google Nest Hub, หรือ Raspberry Pi + OpenThread Border Router)

### ขั้นตอน

**1. เตรียม Raspberry Pi Pico เป็น SWD probe**

```bash
# Download Picoprobe .uf2
# https://github.com/raspberrypi/picoprobe/releases

# กดปุ่ม BOOTSEL ค้างไว้แล้วเสียบ USB
# Drag .uf2 ไปที่ drive "RPI-RP2"
```

**2. ต่อสาย SWD**

ดู pad บนบอร์ด HolyIoT 25008 (มักอยู่ขอบบอร์ด):
- `SWDCLK` → Pico GP2
- `SWDIO` → Pico GP3
- `GND` → Pico GND
- `VCC` → Pico 3V3(OUT)

**3. Build เฟิร์มแวร์**

```bash
# ติดตั้ง nRF Connect SDK (ใช้ nRF Connect for VS Code หรือ command line)
west init -m https://github.com/nrfconnect/sdk-nrf --mr v2.9.0
west update

# Build Matter light-switch sample
cd ncs/nrf/samples/matter/light_switch
west build -b holyiot_25008/nrf54l15/cpuapp
```

**4. Flash**

```bash
west flash --runner openocd
```

ถ้าสำเร็จ LED RGB จะกระพริบแสดงสถานะ commissioning

**5. Commission เข้า Matter network**

ใช้แอป Home (iOS), Google Home, หรือ Home Assistant ทำ commissioning:
- QR Code / Pairing Code อยู่ในตัวอย่าง sample config
- บอร์ดจะ join Thread network ผ่าน Border Router อัตโนมัติ

**6. ใส่เคสและติดตั้ง**

ใส่ CR2032, ประกอบเคส 3D print, ติดด้วยเทปสองหน้าหรือสกรู

## Caveats / Limits

- **Zephyr board status**: `holyiot_25008` อยู่ใน status "not actively maintained" ใน Zephyr upstream — ใช้งานได้ แต่อาจต้องแก้ DTS เองถ้า API เปลี่ยน
- **SWD pad**: บน HolyIoT 25008 pad เล็กมาก (0.8 mm pitch บางรุ่น) — ต้องใช้ probe tip หรือ solder probe wire ชั่วคราว
- **ICD + OTA**: ถ้าต้องการ OTA update เฟิร์มแวร์ผ่าน Matter ต้องเปิด `CONFIG_CHIP_OTA_REQUESTOR` ซึ่งจะเพิ่มกระแสเล็กน้อยในช่วง polling
- **Thread Border Router จำเป็น**: Matter over Thread ต้องการ Border Router ในเครือข่าย — ถ้าใช้แค่ WiFi network จะไม่รองรับ
- **หมุนไม่ได้ถ้าไม่มี encoder**: รุ่นที่หมุนได้ต้องใช้ rotary encoder ภายนอก (บอร์ดเปล่าไม่มีมาในกล่อง)
- **CR2032 อายุ**: 2+ ปีเป็นค่าประมาณที่ 6 µA เฉลี่ย — กดปุ่มบ่อยมากจะลดอายุลงจากกระแส peak ขณะส่ง Thread

## References

1. [Hacking a Cheap Bluetooth Beacon into a DIY Matter Button (YouTube)](https://www.youtube.com/watch?v=5BypIqVotR8)
2. [HOLYIOT 25008 — Zephyr Project Documentation](https://docs.zephyrproject.org/latest/boards/holyiot/holyiot_25008/doc/index.html)
3. [nRF54L15 ultra-low-power wireless SoC — Nordic Semiconductor](https://www.nordicsemi.com/Products/nRF54L15)
4. [nRF54L15-DK Matter Over Thread start — Nordic DevZone](https://devzone.nordicsemi.com/f/nordic-q-a/124815/nrf54l15-dk-matter-over-thread-start)
5. [Optimizing Power Consumption for Battery-Operated Matter-over-Thread Device (nRF54L15) — Nordic DevZone](https://devzone.nordicsemi.com/f/nordic-q-a/119872/optimizing-power-consumption-for-battery-operated-matter-over-thread-device-nrf54l15)
6. [Picoprobe: Using the Raspberry Pi Pico as Debug Probe — MCU on Eclipse](https://mcuoneclipse.com/2022/09/17/picoprobe-using-the-raspberry-pi-pico-as-debug-probe/)
7. [Testing my HolyIoT nRF54L15DK — tomasmcguinness.com](https://tomasmcguinness.com/2025/08/30/testing-my-holyiot-nrf54l15dk/)
8. [Seeed Studio XIAO nRF54L15 Matter — Seeed Studio Wiki](https://wiki.seeedstudio.com/xiao_nrf54l15_sense_matter/)

## Key Takeaways

- HolyIoT 25008 คือ nRF54L15 ราคา $5–10 ที่รองรับ Matter over Thread ได้เต็มรูปแบบ — แค่ flash เฟิร์มแวร์ใหม่
- ใช้ Raspberry Pi Pico + Picoprobe เป็น SWD programmer ได้โดยไม่ต้องซื้อ J-Link
- กินกระแสเพียง 6 µA เฉลี่ยในโหมด ICD → CR2032 อยู่ได้ 2+ ปี
- Interaction model รองรับ กด / หมุน / double-tap ผ่าน accelerometer onboard
- สามารถเพิ่ม sensor วัดอุณหภูมิ-ความชื้นโดยไม่เพิ่มกระแสเฉลี่ย
- เคส 3D print ช่วยให้ติดตั้งได้ง่าย — รวม CR2032 ในตัวเดียวกัน
- Matter over Thread ต้องการ Border Router ในบ้าน — ถ้ามีแล้ว (Apple/Google/Home Assistant) พร้อมใช้ทันที
