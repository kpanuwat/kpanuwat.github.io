---
title: "Andreas Spiess + Claude Code + ESP32: iOS Voice Keyboard & Automated Workbench"
date: 2026-05-31 06:41:00 +0700
categories: [Engineering]
tags: [esp32, claude-code, ble, usb-hid, raspberry-pi, ai-workflow, embedded, firmware]
slides: true
---

{% include slide-link.html %}

## TL;DR

Andreas Spiess สาธิตการสร้าง **iOS Voice Keyboard** — ใช้ ESP32 เป็น USB HID keyboard รับข้อมูลเสียงผ่าน BLE จากสมาร์ทโฟน — ควบคู่กับ **ESP32 Workbench** บน Raspberry Pi Zero 2W ที่ให้ AI agent (Claude Code) ควบคุมการ flash, monitor, และทดสอบ firmware แบบอัตโนมัติ ทั้งหมดนี้ผ่าน workflow 8 ขั้นตอนที่เปลี่ยนการเขียนโค้ดด้วยตนเองเป็นการบริหารจัดการผ่าน AI

## Background / Why This Matters

โปรแกรม speech-to-text ใน Windows มีข้อจำกัดมาก ส่วนซอฟต์แวร์ระดับ professional มักราคาแพง แต่สมาร์ทโฟนมีระบบรู้จำเสียงที่ยอดเยี่ยมอยู่แล้ว — ทำไมไม่ใช้ประโยชน์จากมัน?

Andreas Spiess (ช่อง YouTube ดัง เรื่อง sensors และ microcontrollers) เล่าว่าเขาวิ่งระบบ AI development อยู่ใน Docker containers บน VM (Proxmox) เพื่อ isolate สภาพแวดล้อม แต่พบปัญหาว่า VM มี serial controller เดียว — ใช้ Zigbee dongle ไปแล้ว ทำให้ไม่มี serial port เหลือสำหรับโปรแกรม ESP32

ปัญหาที่สองคือการทดสอบในสถานการณ์จริง: ถ้าอยากทดสอบว่า Wi-Fi หายกลางคัน หรือ MQTT broker ออฟไลน์ จะทำยังไง? ปิด router จริงไม่ได้ ปิด MQTT production ก็ไม่ได้ — จึงกำเนิด **ESP32 Workbench**

## Deep Dive

### โครงการ iOS Voice Keyboard

**แนวคิด (Concept)**:
```
[iPhone/Android] → (BLE) → [ESP32] → (USB HID) → [Windows/Linux/Mac]
```

สมาร์ทโฟนทำ speech-to-text ในตัวเอง (ด้วยระบบ OS native ที่แม่นยำและรองรับหลายภาษา) แล้วส่งข้อความผ่าน BLE ไปยัง ESP32 ซึ่งจำลองตัวเองเป็น USB keyboard และ "พิมพ์" ข้อความนั้นเข้าสู่คอมพิวเตอร์โดยตรง

**ข้อดีหลัก**:
- รองรับหลายภาษา (อังกฤษ, เยอรมัน, ฯลฯ) ตามความสามารถของสมาร์ทโฟน
- ใช้ได้กับทุกแอปบน Windows/Linux — ไม่ต้องมี driver พิเศษ
- ESP32 เป็น USB HID class → OS รู้จักเป็น keyboard ทันที ไม่ต้องติดตั้งซอฟต์แวร์

### ESP32 Workbench — Automated Hardware Test Lab

Raspberry Pi Zero 2W พร้อม USB hub ทำหน้าที่เป็น "lab assistant" อัตโนมัติ:

| ความสามารถ | รายละเอียด |
|---|---|
| Connect ESP32 ผ่าน USB | หลาย board พร้อมกัน |
| Expose serial ports | ส่งต่อไปยัง VM ผ่าน Ethernet |
| สร้าง Wi-Fi AP | จำลอง network สำหรับ test |
| ควบคุม captive portal | ป้อนข้อมูลเข้าระบบอัตโนมัติ |
| Toggle Wi-Fi / MQTT | ทดสอบสถานการณ์ failure |
| Monitor serial output | ดู log แบบ real-time |

**สิ่งที่ทำให้ต่างออกไป**: ระบบออกแบบมาให้ **AI agent ควบคุมได้โดยตรง** — Claude Code สั่ง flash, อ่าน serial log, รัน test, วิเคราะห์ผล และแก้โค้ดเองถ้าจำเป็น ทั้งหมดในลูปเดียว

### The 8-Step AI Workflow

```
Idea → Spec → Plan → Code → Flash → Test → Fix → Enhance
```

**Step 1 — Create Repository**  
เริ่มทุกโปรเจกต์ด้วย GitHub เสมอ บอก Claude สร้าง repo ทันที ระหว่าง dev ก็บอกให้ commit + push สม่ำเสมอ — ไม่ต้องจำ Git syntax เอง และ protect ตัวเองจาก "AI disasters"

**Step 2 — Describe the Idea** (Markdown)  
เขียน idea document สั้น ๆ เป็น Markdown อธิบายว่าโปรเจกต์ทำอะไร ยังไม่ต้องลงรายละเอียด implementation

**Step 3 — Generate Functional Specification (FSD)**  
Andreas มี Standard Operating Procedure (SOP) ที่สร้างเป็น Claude skill — Claude อ่าน idea document แล้วสร้าง **Functional Specification Document** อัตโนมัติ ประกอบด้วย:
- MCU ที่ใช้ และ pinout
- Communication protocols (BLE, Wi-Fi, MQTT, USB HID)
- Error handling scenarios
- Test cases พร้อมใช้ทันที

**Step 4 — Implementation Planning**  
สำหรับโปรเจกต์ขนาดใหญ่ Claude แบ่งงานเป็น phases เพื่อลด complexity และทำให้ debug ง่ายขึ้น

**Step 5 — Code Generation**  
Claude เขียนโค้ดและ compile — ถ้ามี error ก็แก้เองส่วนใหญ่ โดยไม่ต้องให้ developer เข้ามา intervention

**Step 6 — Flash the Device** (ผ่าน ESP32 Workbench)  
เมื่อ compile สำเร็จ Claude สั่ง workbench flash firmware ไปยัง ESP32 จากนั้น monitor serial output ยืนยันว่า boot สำเร็จ

**Step 7 — Run Tests**  
Claude รัน test cases จาก FSD ผ่าน workbench — ถ้าผ่าน เดินหน้า phase ถัดไป; ถ้าไม่ผ่าน วิเคราะห์ serial log และแก้ไขโค้ด

**Step 8 — Enhance**  
เพิ่ม feature ใหม่โดย update FSD ให้ Claude implement ตาม steps เดิม หรือบอก Claude โดยตรงแล้วให้ update FSD ตามหลัง

### ผลลัพธ์จริง

iOS Voice Keyboard (phases 1 + 2) ใช้เวลา **~1.5 ชั่วโมง** รวมทั้ง build และ test แม้โปรเจกต์ต้องการโค้ดหลายพันบรรทัด (ทั้ง BLE stack, USB HID descriptor, และ firmware logic)

## Caveats / Limits

- **Infrastructure overhead**: ต้องมี Raspberry Pi Zero 2W + USB hub + Ethernet cable ถ้าต้องการ workbench เต็มรูปแบบ — ถ้า computer มี serial port และไม่ต้องการ automated testing เชื่อม ESP32 ตรงได้เลย
- **VM serial port limitation**: Proxmox (หรือ hypervisor ทั่วไป) มักมี serial controller จำกัด — ต้องวางแผน resource allocation ก่อน
- **Cost**: Claude Code ไม่ฟรี Andreas เองยอมรับว่า "never regretted the money" แต่ต้องประเมิน ROI สำหรับ hobbyist
- **Claude Code เป็นแค่หนึ่งตัวเลือก**: Andreas พูดถึง Codex และ Gemini ว่าอาจตามทัน — workflow นี้ไม่ผูกติดกับ tool ใด tool หนึ่ง
- **Firmware complexity**: USB HID descriptor, BLE stack, และ serial protocol ยังคงเป็นเรื่องที่ต้องเข้าใจพอประมาณเพื่อ review งานที่ AI ทำ

## References

1. [Andreas Spiess — "iOS Voice Keyboard for any Computer" (YouTube)](https://youtu.be/nmGEedloQ6E)
2. [ESP32 USB HID — Espressif ESP-IDF USB Device Stack](https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/peripherals/usb_device.html)
3. [Bluetooth Low Energy on ESP32 — Espressif Docs](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/bluetooth/index.html)
4. [Claude Code — Official Documentation](https://docs.anthropic.com/en/docs/claude-code)
5. [Raspberry Pi Zero 2W — Product Page](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/)

## Key Takeaways

- **เปลี่ยนจาก "นักโปรแกรม" เป็น "ผู้จัดการ AI"** — Andreas ไม่ได้เขียนโค้ดเอง แต่บอก spec และ review ผลลัพธ์
- **FSD คือ key** — Functional Specification Document ที่ดีทำให้ AI generate code + test cases ที่ตรงจุดได้ทันที
- **Workbench = reproducible test environment** — ไม่ต้องปิด production infrastructure เพื่อทดสอบ edge cases
- **GitHub commit บ่อย = safety net** — ทุก step ที่ AI ทำ มี commit รองรับ rollback ได้เสมอ
- **1.5h สำหรับ multi-thousand-line firmware** — แสดงให้เห็น throughput ที่เป็นไปได้เมื่อ AI จัดการ boilerplate และ debug loop
- **Workflow นี้ reusable** — SOP ที่เขียนครั้งเดียว (เป็น Claude skill) ใช้ได้กับ ESP32 โปรเจกต์ใหม่ทุกตัว
- **Isolation ลด risk** — Docker container per project + VM boundary ป้องกัน AI จากการเข้าถึง host system
