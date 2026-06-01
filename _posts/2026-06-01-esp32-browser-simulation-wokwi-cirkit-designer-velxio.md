---
title: "จำลองวงจร ESP32 บนเบราว์เซอร์: Wokwi, Cirkit Designer และ Velxio"
date: 2026-05-31 06:45:00 +0700
categories: [Engineering]
tags: [esp32, simulation, wokwi, embedded, iot, hardware]
slides: true
---

{% include slide-link.html %}

## TL;DR

ไม่ต้องมีบอร์ดจริงก็พัฒนา ESP32 ได้ — มี 3 แพลตฟอร์ม browser-based ที่ครอบคลุมทุก use case: **Wokwi** สำหรับ IoT workflow ที่ต้องการ WiFi/MQTT จริง, **Cirkit Designer** สำหรับมือใหม่ที่ต้องการ AI ช่วยต่อวงจรและเขียนโค้ด, และ **Velxio** สำหรับความแม่นยำสูงสุดด้วย QEMU CPU emulation ผ่าน WebAssembly

## Background / Why this matters

การพัฒนา embedded systems แบบดั้งเดิมมีต้นทุนสูง — ทั้งเวลา (รอของ, รอ flash), เงิน (บอร์ด, sensors, สาย), และความเสี่ยง (เผลอ short circuit, IC ตาย) ก่อนจะได้ทดสอบโค้ดจริงๆ

Browser-based simulation แก้ปัญหานี้โดยรัน firmware จริงในสภาพแวดล้อมเสมือน เขียนโค้ดแล้วเห็นผลทันที loop ที่ใช้เวลาหลายชั่วโมงในโลกจริงเหลือแค่วินาที

ทั้งสามแพลตฟอร์มในบทความนี้ถูกนำเสนอในวิดีโอ YouTube ของ channel ไทย (ลิงก์ใน References) ครอบคลุมแนวทางที่แตกต่างกัน: Wokwi เน้น production IoT workflow, Cirkit Designer เน้น AI-assisted onboarding, Velxio เน้น hardware-accurate emulation

## Deep Dive

### 1. Wokwi — IoT Workflow ที่สมบูรณ์ที่สุด

**Wokwi** (wokwi.com) คือ browser simulator ที่ simulate ทั้ง network stack ตั้งแต่ MAC layer ผ่าน IP/TCP/UDP ไปจนถึง DNS, HTTP, MQTT และ CoAP ทำให้ ESP32 โค้ดที่ connect กับ broker จริงๆ ทำงานได้ใน browser โดยไม่ต้องแก้โค้ด

**จุดเด่น:**
- **WiFi simulation ครบ stack**: simulate 802.11 MAC → TCP/IP → MQTT/HTTP/HTTPS ภายในเบราว์เซอร์เดียวกัน
- **Private Gateway**: ส่ง traffic จาก simulator ตรงไปยัง network ของเครื่องโดยไม่ผ่าน cloud (ลด latency + เพิ่ม privacy)
- **VS Code integration**: `wokwi.toml` ใน project root ผูก firmware กับ simulation config; build → flash → simulate ในขั้นตอนเดียว
- **Chip coverage กว้าง**: ESP32, S2, S3, C3, C5, C6, H2, P4, Arduino Uno/Mega/Nano, STM32 Nucleo, Raspberry Pi Pico
- **Language support**: Arduino (C/C++), MicroPython, CircuitPython, Rust, Zephyr

**Supported peripherals (ESP32):**
| Peripheral | Status |
|---|---|
| GPIO + interrupts | เต็ม |
| UART, I2C (master), SPI | เต็ม |
| LEDC PWM, timers, watchdog | เต็ม |
| ADC, RNG, DMA | เต็ม |
| AES/SHA/RSA accelerators | เต็ม |
| I2S, RMT (WS2812), TWAI | บางส่วน |
| Bluetooth, ULP | ยังไม่รองรับ |

**เหมาะสำหรับ**: โปรเจกต์ IoT ที่ต้องการ MQTT broker connection, HTTP API calls, หรือ multi-device network simulation; team ที่ใช้ VS Code และต้องการ CI integration

---

### 2. Cirkit Designer — AI-Powered สำหรับมือใหม่

**Cirkit Designer** (cirkitdesigner.com) คือ AI-first electronics IDE ที่ออกแบบมาให้ผู้เริ่มต้นสร้างวงจรโดยไม่ต้องรู้ pinout ทุกตัวเอง

**จุดเด่น:**
- **Cirkit AI assistant**: อธิบาย component ให้ต่อยังไง, generate Arduino/ESP32 code จาก description ภาษาพูด, และ troubleshoot เมื่อวงจรมีปัญหา
- **Visual-first workflow**: drag-and-drop wiring + component library ครอบคลุม sensors, displays, motors, LEDs
- **ESP32-S3 simulation**: รันโค้ดจริงพร้อม peripheral response ในหน้าต่างเดียวกัน
- **WiFi workflow support**: HTTP, MQTT และ IoT-style connected project ใน browser
- **Export**: ออก circuit diagram ได้สำหรับการ present หรือ documentation

**เหมาะสำหรับ**: นักเรียน, maker มือใหม่, หรือใครก็ตามที่ต้องการเรียนรู้การต่อวงจรโดยมี AI เป็น co-pilot ตลอดเวลา; prototyping ด่วนที่ต้องการ explain-as-you-go

---

### 3. Velxio — Hardware-Accurate CPU Emulation

**Velxio** (velxio.dev) เป็น open-source, self-hostable simulator ที่ใช้ **QEMU** compiled เป็น WebAssembly เพื่อ emulate CPU จริงของแต่ละ chip ทำให้ behavior ตรงกับ hardware มากที่สุด

**Architecture แบ่งตาม chip:**

| Chip | Emulation Engine | Freq |
|---|---|---|
| Arduino Uno/Nano/Mega, ATtiny85 | avr8js (cycle-accurate AVR8) | 16 MHz |
| Raspberry Pi Pico (RP2040) | rp2040js (ARM Cortex-M0+) | 133 MHz |
| ESP32, ESP32-S3 (Xtensa LX6/LX7) | QEMU lcgamboa via WASM | 240 MHz |
| ESP32-C3 (RISC-V RV32IMC) | QEMU lcgamboa libqemu-riscv32 | — |
| Raspberry Pi 3B (ARM Cortex-A53) | QEMU raspi3b | full Linux |

**จุดเด่น:**
- **SPICE analog co-simulation**: GPIO pins ทำงานเป็น voltage source ใน SPICE net; `analogRead()` อ่าน solved node voltages กลับมาใน firmware — ทดสอบ real circuit behavior ได้
- **Offline-capable**: self-host ด้วย Docker; ทำงานได้โดยไม่ต้องมี internet หลังจาก pull image แล้ว
- **19 real boards**: ESP32-C3, XIAO ESP32-C3/S3, Arduino Uno/Mega/Nano/Micro/Mini, RP Pico, Raspberry Pi 3B ฯลฯ
- **Open-source**: GitHub: `davidmonterocrespo24/velxio`
- **Zero setup**: เข้า velxio.dev ได้เลย หรือ `docker run` สำหรับ offline

**เหมาะสำหรับ**: งานที่ต้องการ hardware-accurate results (timing, analog, edge behavior), ทีมที่ต้องการ air-gapped หรือ offline environment, นักพัฒนาที่ต้องการ SPICE-level analog verification

---

### เปรียบเทียบสรุป

| Feature | Wokwi | Cirkit Designer | Velxio |
|---|---|---|---|
| WiFi/MQTT simulation | ✅ ครบ stack | ✅ HTTP/MQTT | ❌ (ไม่มี network stack) |
| AI assistance | ❌ | ✅ Cirkit AI | ❌ |
| CPU emulation accuracy | ✅ simulator | ⚠️ simulator | ✅✅ QEMU/avr8js |
| SPICE analog | ❌ | ❌ | ✅ |
| Self-host / offline | ❌ | ❌ | ✅ Docker |
| Open source | ❌ | ❌ | ✅ |
| Free tier | ✅ | ✅ | ✅ |
| VS Code extension | ✅ | ❌ | ❌ |

## Caveats / Limits

- **Wokwi**: Bluetooth ยังไม่รองรับ; ULP processor ไม่รองรับ; free tier มี simulation speed limit; advanced features (private gateway, CI integration) อยู่ใน paid plan
- **Cirkit Designer**: AI-generated code ควร verify ก่อน flash บอร์ดจริง; ESP32-S3 เท่านั้น (ไม่ใช่ ESP32 ทุก variant); ข้อมูล pricing ไม่ชัดเจน
- **Velxio**: ESP32/ESP32-S3 ใช้ QEMU ซึ่งรันใน Docker container (ไม่ใช่ pure browser); network simulation ไม่มี — ทดสอบ WiFi/MQTT ไม่ได้; ต้องการ Docker สำหรับ offline self-hosting
- ทั้ง 3 แพลตฟอร์มไม่ได้ replace hardware testing สมบูรณ์ — timing-sensitive peripherals เช่น RF, specific HAL edge cases ยังต้องทดสอบบอร์ดจริง

## References

1. [Wokwi - World's most advanced ESP32 Simulator](https://wokwi.com/)
2. [ESP32 WiFi Networking — Wokwi Docs](https://docs.wokwi.com/guides/esp32-wifi)
3. [ESP32 on Wokwi](https://wokwi.com/esp32)
4. [Cirkit Designer - AI Circuit Design and Simulation](https://www.cirkitdesigner.com/)
5. [ESP32 Simulator Online - Cirkit Designer](https://www.cirkitdesigner.com/esp32-simulator)
6. [Velxio — Free Online Circuit & Arduino Simulator](https://velxio.dev/)
7. [Velxio Emulator Architecture](https://velxio.dev/docs/emulator/)
8. [RISC-V Emulation (ESP32-C3) — Velxio Docs](https://velxio.dev/docs/riscv-emulation/)
9. [Velxio is an open-source, self-hosted ESP32 simulator — CNX Software](https://www.cnx-software.com/2026/04/04/velxio-open-source-self-hosted-arduino-raspberry-pi-and-esp32-simulator/)
10. [GitHub: davidmonterocrespo24/velxio](https://github.com/davidmonterocrespo24/velxio)
11. [Top 3 Free Online Microcontroller Simulators (2025) — Embedded Electronics](https://embeddelectronics.blog/2025/10/27/top-3-free-online-microcontroller-simulators-for-arduino-esp32-2025/)
12. [วิดีโอต้นฉบับ: ESP32 Browser Simulation — YouTube](https://youtu.be/_HsZzkSYao0)

## Key Takeaways

- **Wokwi** = ตัวเลือกที่ดีที่สุดสำหรับ IoT workflow จริง — WiFi/MQTT/HTTP simulate ครบ stack ใน browser; integrate กับ VS Code ได้
- **Cirkit Designer** = AI co-pilot สำหรับมือใหม่ — ช่วยต่อวงจร, generate code, troubleshoot ได้ทันที; ESP32-S3
- **Velxio** = accuracy สูงสุด — QEMU ผ่าน WASM + SPICE analog solver; open-source, self-hostable, offline-ready
- ทั้ง 3 แพลตฟอร์มใช้งานฟรีและไม่ต้องติดตั้งซอฟต์แวร์ (ยกเว้น Velxio self-hosted)
- เลือกตาม use case: network testing → Wokwi; เรียนรู้/prototype ด่วน → Cirkit Designer; analog/timing accuracy → Velxio
- Browser simulation ลด iteration loop จากชั่วโมง (flash + test + debug) เหลือวินาที — เหมาะมากสำหรับ rapid prototyping ก่อนซื้อ hardware
