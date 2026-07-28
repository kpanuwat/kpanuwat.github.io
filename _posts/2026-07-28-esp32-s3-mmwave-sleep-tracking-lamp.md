---
title: "โคมไฟติดตามการนอนหลับไร้สัมผัส SleepLamp: ESP32-S3 + mmWave Sensor วัดหัวใจและการหายใจ"
date: 2026-07-27 00:02:00 +0700
categories: [Engineering]
tags: [esp32-s3, mmwave, sleep-tracking, iot, neopixel, open-source, dfrobot-c1001]
slides: true
---

{% include slide-link.html %}

## TL;DR

**SleepLamp** คือโคมไฟข้างเตียง open-source ที่ตรวจจับ sleep stage, อัตราการเต้นหัวใจ และการหายใจแบบ **ไร้สัมผัส** (contactless) ด้วย 60 GHz mmWave radar + ESP32-S3 — ไม่ต้องใส่ wearable, ไม่ต้องมีกล้อง, ไม่มี cloud — ข้อมูลทั้งหมดอยู่ใน local dashboard ที่ `http://sleeplamp.local`

## Background / Why this matters

Sleep tracker ส่วนใหญ่ในตลาดวันนี้เป็น wearable (นาฬิกา, แหวน) ที่ต้องชาร์จแบตทุกคืน หรือไม่ก็เป็นอุปกรณ์ใต้ที่นอน — โปรเจกต์นี้จากช่อง YouTube **techiesms** (สร้างโดย Shubh Jaiswal) เลือกแนวทางแบบเดียวกับผลิตภัณฑ์เชิงพาณิชย์ **Sleepal AI Lamp** บน Kickstarter คือใช้ mmWave radar ยิงคลื่นวิทยุความถี่สูงไปสะท้อนที่หน้าอก แล้ววัด micro-movement ของการเต้นหัวใจและการหายใจ จากระยะห่างประมาณ 0.5–1.5 เมตร

จุดที่น่าสนใจคือ radar sensor ที่ใช้ (DFRobot C1001) ประมวลผล DSP ภายในตัวมันเองแล้วส่งผลลัพธ์ออกมาทาง UART ธรรมดา — งานของ ESP32-S3 จึงเหลือแค่อ่าน UART, ขับ LED ring, รับค่าจาก DHT11, รัน Wi-Fi/Matter, และ serve web dashboard เล็กๆ ตัวเดียว ทำให้ทั้งระบบไม่ต้องพึ่ง cloud หรือแอปมือถือเลย [^1][^2]

## Deep Dive

### Hardware & Bill of Materials

BOM ตัวจริงที่ shipped ในโปรเจกต์ (ต่างจาก research doc ช่วงต้นที่เคยพิจารณา BME280/mic/RTC เพิ่ม แต่สุดท้ายตัดออกเพื่อความเรียบง่าย) มีดังนี้ [^3]:

| Component | Model | หน้าที่ |
|-----------|-------|---------|
| Microcontroller | **ESP32-S3-WROOM-1 N16R8** | 16 MB flash, 8 MB PSRAM, dual-core |
| Radar sensor | **DFRobot C1001 / SEN0623** | 60 GHz mmWave วัดหัวใจ+การหายใจแบบไร้สัมผัส |
| Temp/humidity | **DHT11** | อ่านผ่าน bit-banged GPIO ไม่มี library แยก |
| LED lamp | **12× WS2812/SK6812 NeoPixel ring** | โคมไฟปรับแสงตาม sleep state (~0.7A ที่ full brightness) |
| Touch input | **TTP223** capacitive module | แตะเพื่อเปิด/ปิดไฟ และปิด alarm |
| Power | External 5V ≥1.5A | **จำเป็น** — USB rail ของบอร์ด noisy เกินไปสำหรับ radar |

### Wiring

```
GPIO 18  ← C1001 TX   (UART RX ฝั่ง ESP32)
GPIO 17  → C1001 RX   (UART TX ฝั่ง ESP32)
GPIO 4   ↔ DHT11 DATA (bit-banged, 3V3 logic)
GPIO 5   → NeoPixel DIN (ไฟเลี้ยง 5V แยกจาก external supply)
GPIO 6   ← TTP223 OUT (3V3 input)
```

pin ทั้งหมดถูก `#define` ไว้ใน `config.h` — เปลี่ยนที่นี่ถ้าต่อสายไม่ตรง [^3]

**Gotcha สำคัญ:** radar ต้องกินไฟจาก external 5V เท่านั้น (ไม่ใช่ USB rail ของบอร์ด) ไม่งั้นจะเจอ HR lock หลุด, UART frame corrupt, และ brownout reboot — นี่คือ root cause อันดับ 1 ของปัญหา "วัด HR ไม่ได้เลย" [^3]

### Sleep-Staging Engine — ทำไมไม่ใช้ staging ในตัว sensor

C1001 มี sleep-staging ในตัวอยู่แล้ว แต่มีปัญหา: ต้องรอ 15–20 นาทีถึงจะรายงานผลครั้งแรก, รายงาน nightly stats แค่ครั้งเดียวต่อคืน (ใช้กับการงีบไม่ได้), และเคยมีปัญหา corrupt frame ทำให้ข้อมูลขยะไหลเข้า history (เช่น HR 2 bpm, apnea 56 ครั้ง)

SleepLamp เลยเขียน **custom 1-minute epoch classifier** ของตัวเอง เป็น state machine:

- Awake → Light: นิ่ง 3 นาทีติดต่อกัน (backdate ไปจุดเริ่มนิ่ง)
- Light → Deep: นิ่งมาก 10 นาที **และ** heart rate ต่ำกว่า baseline ตอนตื่น
- Deep/Light → Awake: ตรวจจับการเคลื่อนไหวต่อเนื่อง
- จบ session: ลุกจากเตียง 8 นาที หรือกดจบ session เอง

**Sleep score (1–99)** คำนวณจาก 4 ปัจจัยถ่วงน้ำหนัก:

| น้ำหนัก | ปัจจัย | เป้าหมาย |
|:--:|---|---|
| 45% | Sleep efficiency (เวลาหลับ ÷ เวลาบนเตียง) | สูง |
| 25% | สัดส่วน Deep sleep | ~25% |
| 15% | ระยะเวลารวม | ~7 ชั่วโมง |
| 15% | ความถี่การตื่นกลางดึก | น้อย = ดี |

ข้อมูลจะถูกเขียนลง history **เฉพาะตอนจบ session** เท่านั้น ไม่ใช่จาก raw radar frame ทุกครั้ง — นี่คือวิธีที่กำจัดปัญหาข้อมูลขยะได้เด็ดขาด [^3]

### Software Architecture — FreeRTOS Dual-Core

ESP32-S3 มี 2 core และ SleepLamp แบ่งงานชัดเจนเพื่อไม่ให้ radar ที่ช้าหรือ reboot ไปแช่ web UI:

- **Core 0 (`sensorTask`)** — อ่าน UART จาก radar แต่เพียงผู้เดียว, validate/smooth ข้อมูล, รัน staging engine, เก็บ session ring buffer
- **Core 1 (`loop()` + WebServer)** — serve dashboard, ควบคุมโคมไฟ/alarm, poll DHT11

ข้อมูลที่แชร์ระหว่าง core ใช้ mutex-guarded globals เพื่อให้ web layer อ่านค่าที่ consistent เสมอ [^2][^3]

### Dashboard & HTTP API

Dashboard เป็น self-contained web page (deep-space theme, glassmorphism) served ตรงจาก ESP32 ที่ `http://sleeplamp.local` — ติดตั้งเป็น PWA ได้, ไม่ต้องมี app แยก:

| Endpoint | หน้าที่ |
|----------|---------|
| `GET /api/data` | live JSON snapshot (vitals, state, session ปัจจุบัน) |
| `GET /api/session` | array รายนาที: stage, HR, breathing (สำหรับ hypnogram) |
| `GET /api/history` | session ที่บันทึกไว้ทั้งหมด; `?del=N` ลบทีละอัน, `?clear=1` ลบทั้งหมด |
| `GET /api/export` | ดาวน์โหลด CSV |
| `GET /api/report?end=1` | จบ session ทันที + บันทึกรายงาน |
| `GET /api/light?mode=&r=&g=&b=&bright=` | ควบคุมสีและความสว่างโคมไฟ |
| `GET /api/alarm?en=&h=&m=&win=` | ตั้งค่า smart-wake alarm |
| `GET /api/sensor?reset=1` | recalibrate radar |

### Matter Smart-Home Integration

โคมไฟถูก expose เป็น **Matter Color Light** มาตรฐาน — สแกน QR code ที่พิมพ์ออกทาง serial monitor เพื่อ pair กับ Apple Home / Google Home / Alexa ได้เลย สถานะซิงก์สองทาง (แตะโคมไฟหรือสั่งจาก dashboard ก็อัปเดตแอปสมาร์ทโฮมด้วย) — ต้องใช้ esp32 board package **3.1.0 ขึ้นไป** ถึงจะ build Matter ได้ [^2][^3]

## User Guide (Step-by-Step)

1. **ติดตั้ง toolchain** — Arduino IDE 2.x, esp32 board package ≥3.1.0 (จำเป็นสำหรับ Matter; ปิด `ENABLE_MATTER 0` ใน `config.h` ถ้าใช้ 3.0.x), Adafruit NeoPixel library ≥1.12.3 — ไม่ต้องติดตั้ง sensor library แยก เพราะ C1001 driver ถูก bundle เป็น header ไฟล์เดียว (`ShubhSensor.h`) มาพร้อมสเก็ตช์แล้ว
2. **ตั้งค่า WiFi** — `cp secrets.example.h secrets.h` แล้วแก้ SSID/password (ไฟล์นี้ git-ignored) หรือข้ามขั้นตอนนี้แล้วตั้งค่าผ่าน hotspot `SleepLamp-Setup` (password `sleeplamp123`) ที่ `192.168.4.1/wifi` ตอน flash ครั้งแรก
3. **ตั้งค่าบอร์ดใน Arduino IDE** — Board: `ESP32S3 Dev Module`, Partition Scheme: `Huge APP (3 MB No OTA / 1 MB SPIFFS)`, เปิด **Erase All Flash Before Sketch Upload** สำหรับการ flash Matter ครั้งแรก (จะล้าง sleep history เก่าด้วย)
4. **Flash** — เปิด `firmware/sleeplamp/sleeplamp.ino` แล้วอัปโหลด บอร์ดจะรัน RGB boot test (Red → Green → Blue) เพื่อเช็คการต่อสาย NeoPixel
5. **ต่อสายฮาร์ดแวร์** ตามตารางด้านบน — ย้ำ: radar ต้องใช้ external 5V แยกจาก USB
6. **คืนแรกใช้งาน** — เปิด `http://sleeplamp.local`, รัน "placement check" (เช็ค presence → นิ่ง → จับการหายใจ → จับ HR ได้) แล้วนอนให้ระบบเริ่ม session อัตโนมัติ
7. **Daily workflow** — ดู sleep score + hypnogram ตอนเช้า, ตั้ง smart-wake alarm ก่อนนอน, ปรับโหมดโคมไฟ (Auto/Manual/Off) จาก dashboard
8. **Troubleshooting** — เจอ `init error, retrying` ใน log 10–15 วินาทีแรกหลังเปิดเครื่อง = ปกติ (radar กำลัง boot); ถ้า HR ไม่ล็อกเลย ให้กด "Recalibrate sensor" หรือ power-cycle สาย 5V ของ radar; ถ้าแก้โค้ดแล้วไม่ขึ้นบนชิป ให้ลบ cache ที่ `%LOCALAPPDATA%\arduino\sketches` แล้วอัปโหลดใหม่

## Caveats / Limits

- **ไม่มี custom PCB หรือไฟล์เคส 3D-printed ใน repo ปัจจุบัน** — ตรวจสอบ file tree ของ repo แล้วไม่พบไฟล์ KiCad/Gerber หรือ STL ใดๆ; "Finished 3D-printed enclosure" ยังเป็นรายการที่ **ยังไม่ติ๊ก** ใน Roadmap ของ README ตัวปัจจุบัน การประกอบเป็นการต่อโมดูลสำเร็จรูปด้วย perfboard/dupont wire ไม่ใช่ PCB ที่ออกแบบเอง [^3]
- ต้องใช้ external 5V power supply แยกต่างหาก — ใช้ USB rail อย่างเดียวจะเจอปัญหา HR ไม่ล็อกและ reboot กะทันหัน
- Radar วัดได้แม่นยำเมื่อคนอยู่นิ่ง ห่างจากเซนเซอร์ 0.5–0.8 ม. และหันหน้าอกเข้าหาเซนเซอร์ — ท่านอนหรือระยะที่ไม่เหมาะจะทำให้ HR/breathing lock หลุด
- Feature snore detection (I²S mic + TensorFlow Lite Micro) และ ambient light sensor (BH1750) ยังอยู่ใน Roadmap เช่นกัน ยังไม่ได้ implement [^3]
- Matter ยังไม่มี native device type สำหรับ "sleep tracker" — โปรเจกต์นี้ expose ผ่าน occupancy + light แทน
- License: โค้ดของโปรเจกต์เองใช้ MIT License; radar driver `ShubhSensor.h` build บนไลบรารี DFRobot_HumanDetection (MIT เช่นกัน) ต้องเก็บ copyright เดิมไว้ตามเงื่อนไข license [^4][^5]
- โปรเจกต์นี้เป็น independent/unaffiliated build ที่ได้แรงบันดาลใจจาก Sleepal AI Lamp เชิงพาณิชย์ ไม่ใช่ทีมเดียวกัน

## References

[^1]: techiesms (YouTube), "I Built a LAMP That Tracks Your Sleep (No Wearable Needed!)" — https://youtu.be/KlZlvOph3Yc
[^2]: GitHub repo — techiesms/sleeplamp-mmwave-sleep-tracker — https://github.com/techiesms/sleeplamp-mmwave-sleep-tracker
[^3]: README.md (full technical detail: BOM, wiring, staging engine, dashboard, roadmap) — https://raw.githubusercontent.com/techiesms/sleeplamp-mmwave-sleep-tracker/main/README.md
[^4]: DFRobot C1001 / SEN0623 sensor wiki — https://wiki.dfrobot.com/SKU_SEN0623_C1001_mmWave_Human_Detection_Sensor
[^5]: DFRobot_HumanDetection driver library (base for `ShubhSensor.h`) — https://github.com/DFRobot/DFRobot_HumanDetection

## Key Takeaways

- SleepLamp วัด sleep stage, heart rate, และ breathing rate แบบไร้สัมผัสด้วย 60 GHz mmWave radar (DFRobot C1001) + ESP32-S3 — ไม่มี wearable, ไม่มีกล้อง, ไม่มี cloud
- Custom 1-minute epoch staging engine ทำงานได้เร็วกว่า built-in staging ของ radar (รายงานได้ตั้งแต่นาทีแรก แทนที่จะรอ 15–20 นาที) และรองรับการงีบหลับ
- Sleep score (1–99) มาจาก 4 ปัจจัยถ่วงน้ำหนัก: sleep efficiency, deep-sleep %, ระยะเวลารวม, ความถี่การตื่น
- Dual-core FreeRTOS แยกงาน sensor (core 0) กับ web/lamp (core 1) เพื่อกัน radar ที่ช้าไปบล็อก dashboard
- Dashboard + HTTP API ทั้งหมด serve จาก ESP32 เอง ผ่าน `http://sleeplamp.local` พร้อม Matter integration สำหรับ Apple Home/Google/Alexa
- **สำคัญ:** repo ปัจจุบันยังไม่มี custom PCB หรือไฟล์เคส 3D-printed แบบ open-source — เป็นการต่อโมดูลสำเร็จรูป และเคส 3D-printed ยังเป็นแผนงานที่ยังไม่เสร็จ
- External 5V power supply แยกจาก USB คือ requirement ที่พลาดไม่ได้ ไม่งั้น radar จะ lock HR ไม่ติดและ reboot เอง
