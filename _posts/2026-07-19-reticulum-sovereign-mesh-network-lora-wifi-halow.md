---
title: "Reticulum: เครือข่ายอธิปไตยข้ามฮาร์ดแวร์ที่เชื่อม LoRa เข้ากับ Wi-Fi HaLow"
date: 2026-07-18 00:03:00 +0700
categories: [Engineering]
tags: [reticulum, mesh-networking, lora, wifi-halow, sovereign-communication, end-to-end-encryption, atak, raspberry-pi, lxmf, off-grid]
slides: true
---

{% include slide-link.html %}

## TL;DR

Reticulum (RNS) ไม่ใช่ radio protocol แต่คือ networking stack เต็มรูปแบบที่ทำงาน "เหนือ" ฮาร์ดแวร์ใดๆ ก็ได้ — เชื่อม LoRa 915MHz เข้ากับ Wi-Fi HaLow, Ethernet, หรือแม้แต่ Morse code 5bps เข้าด้วยกันในเครือข่ายเดียว โดยเข้ารหัส end-to-end และไม่มีจุดศูนย์กลางให้ปิดหรือเซ็นเซอร์ — สาธิตจริงแล้วด้วยการรัน ATAK บน Haven nodes (Raspberry Pi + Wi-Fi HaLow) สำหรับภารกิจกู้ภัย/off-grid

## Background / Why this matters

อินเทอร์เน็ตที่เราใช้ทุกวันนี้ผูกติดกับ "สาย" หรือ "เสาสัญญาณ" ของผู้ให้บริการรายใดรายหนึ่งเสมอ — ตัดสาย ตัดไฟ ตัดเสา คือจบการสื่อสาร แก่นแท้ของอินเทอร์เน็ตจริงๆ ไม่ใช่ตัวฮาร์ดแวร์ แต่คือ**ระบบการจัดเส้นทาง (routing)** ที่ตัดสินใจว่าข้อมูลชิ้นหนึ่งควรวิ่งผ่านอุปกรณ์ไหนไปยังปลายทาง

[Reticulum Network Stack (RNS)](https://github.com/markqvist/reticulum) เป็นความพยายามเขียน routing layer นี้ใหม่ทั้งหมด โดยตัดการพึ่งพา IP, ISP, หรือ centralized authority ออกไปเลย ผู้เขียนหลักคือ Mark Qvist ออกแบบให้เป็น "sovereign" network stack — ใครก็ตั้งเครือข่ายของตัวเองได้ ครอบคลุมพื้นที่กว้างแค่ไหนก็ได้ โดยไม่ต้องขออนุญาตใคร [1][2]

จุดที่ทำให้ Reticulum ต่างจากโปรเจกต์ mesh อื่นอย่าง Meshtastic หรือ MeshCore คือ: โปรเจกต์เหล่านั้น "ใช้วิทยุเป็นเครือข่าย" — ทุกอุปกรณ์คุยกันผ่าน LoRa transport layer เดียวกันหมด ส่วน Reticulum ปฏิบัติต่อวิทยุ, Wi-Fi, สายอีเทอร์เน็ต, สายซีเรียล ว่าเป็นแค่ "interface ที่สลับกันได้" เพราะเครือข่ายอยู่เหนือชั้นฮาร์ดแวร์ [9]

## Deep Dive

### Hardware-agnostic โดยสมบูรณ์

Reticulum กำหนดสเปกขั้นต่ำไว้แค่ MTU 500 byte และ throughput 5 bit ต่อวินาที — นั่นแปลว่าเครือข่ายเดียวกันสามารถทอดยาวจากปลายที่เป็นคีย์มอร์สแบบมือกด ไปจนถึงปลายที่เป็นสายไฟเบอร์ออปติกได้ในเวลาเดียวกัน [5][9] สื่อที่รองรับแล้ว ได้แก่ data radio, LoRa, packet radio TNC (AX.25), serial line, ad-hoc Wi-Fi, และ free-space optical link [1][2]

ตัวอย่างที่จับต้องได้ในวิดีโอต้นทาง: บริดจ์ระหว่าง LoRa 915MHz (ผ่านอุปกรณ์อย่าง [RNode](https://reticulum.network/hardware.html) หรือบอร์ด Meshtastic เดิม) กับ Wi-Fi HaLow 900MHz หรือ Wi-Fi มาตรฐาน 2.4/5GHz — Reticulum จัดการ multi-hop path discovery และ routing ข้าม modulation ที่ต่างกันโดยอัตโนมัติ ไม่ต้อง broadcast ซ้ำข้ามเครือข่ายทั้งหมด [17][19-21]

### Cryptographic identity แทน IP address

Reticulum ทิ้ง IP address แบบเดิมทิ้งไปเลย ปลายทางทุกจุดถูกแทนด้วย **destination hash ขนาด 16 byte** ที่ตัดทอนมาจาก SHA-256 hash ของคีย์ประจำตัว — ขนาด 128 bit นี้เลือกมาเพื่อ trade-off ระหว่าง address space (รองรับอุปกรณ์active พร้อมกันได้หลายพันล้านเครื่อง) กับ packet overhead ที่ต้องต่ำที่สุดสำหรับเครือข่ายแบนด์วิดท์จำกัด

การเข้ารหัสใช้ **X25519** สำหรับ key exchange, **Ed25519** สำหรับ digital signature, และ **AES-256-CBC** สำหรับ symmetric encryption — ทั้งหมด default มาให้ตั้งแต่ต้น ไม่ต้อง config เพิ่ม ทุก link มี forward secrecy และ initiator anonymity คือไม่มี packet ไหนพกข้อมูลต้นทางติดไปด้วย

### ขยายตัวแบบ Linear ไม่ใช่ Flood ทั้งเครือข่าย

ปัญหาคลาสสิกของ mesh network แบบเก่าคือยิ่ง hop เยอะ ยิ่งต้อง flood routing table ไปทั้งเครือข่าย ทำให้ traffic โตแบบ exponential เมื่อโหนดเพิ่ม Reticulum แก้ปัญหานี้ด้วยสถาปัตยกรรมสองชั้น: **Transport Node** (ทำหน้าที่ routing เต็มรูปแบบ) กับ **โหนดทั่วไป** (แค่รักษา next-hop state ในเครื่อง ไม่ต้องรู้ topology ทั้งหมด) — เส้นทางถูกค้นพบแบบ on-demand เมื่อมีการใช้งานจริงเท่านั้น ไม่ broadcast ต่อเนื่องตลอดเวลา ทำให้ control traffic ไม่โตตามจำนวน hop แบบทวีคูณ

Header ของแพ็กเก็ตมี hop-count field ในตัว จำกัดการแพร่กระจายได้โดยไม่ต้องมี routing structure เพิ่ม — นี่คือกลไกหลักที่ทำให้เครือข่ายขนาดใหญ่และ sparse ยังคง scale ได้โดยไม่ทำให้อุปกรณ์พลังงานต่ำ (เช่น LoRa node ที่วิ่งด้วยแบตเตอรี่) ล่มจากภาระ routing

### LXMF — ชั้นแอปพลิเคชันสำหรับข้อความ

บน Reticulum มีโปรโตคอลข้อความชื่อ [LXMF (Lightweight Extensible Message Format)](https://github.com/markqvist/LXMF) ที่มี overhead ต่อข้อความเพียง ~111 byte เหมาะกับ LoRa/packet radio ที่แบนด์วิดท์จำกัดสุดๆ รองรับ zero-configuration message routing, end-to-end encryption, และ delay-tolerant delivery (เก็บข้อความไว้ส่งภายหลังถ้าปลายทางออฟไลน์) แอปที่สร้างบน LXMF ได้แก่ Sideband (Android/Linux/macOS), MeshChat, และ Nomad Network

### Haven nodes: Reticulum จริงบน Raspberry Pi + Wi-Fi HaLow

[Haven](https://buildwithparallel.com/products/haven) คือชุดฮาร์ดแวร์/เฟิร์มแวร์โอเพนซอร์สที่รวม Wi-Fi HaLow (802.11ah, ~900MHz) เข้ากับ Raspberry Pi — Haven 1 ใช้ Pi 4/CM4 กับเฟิร์มแวร์ OpenMANET ส่วน Haven 2 ใช้ Pi 5 กับ OpenWrt และชิป Morse Micro MM8108 ที่ให้ระยะได้เกิน 10 กิโลเมตรในสภาพเปิดโล่ง เมื่อติดตั้ง Reticulum ลงบนโหนดเหล่านี้ พร้อม USB sidecar สำหรับ LoRa (RNode หรือ Meshtastic board) ก็สามารถบริดจ์อุปกรณ์ที่มีแค่ LoRa radio ให้คุยกับอุปกรณ์ที่มีแค่ Wi-Fi มาตรฐานได้ในเครือข่ายเดียว

### ATAK บน Reticulum: situational awareness แบบ off-grid เต็มรูปแบบ

[ATAK (Android Team Awareness Kit)](https://github.com/deptofdefense/AndroidTacticalAssaultKit-CIV) ปกติต้องพึ่ง Wi-Fi, เครือข่ายมือถือ, หรือโครงสร้าง TCP/IP ปกติ แต่ทีมงานสาธิตให้เห็นว่า route ข้อมูล ATAK ทั้งหมด — ทั้ง Cursor-on-Target (CoT) แบบ multicast และแชท — ผ่าน Reticulum ได้เต็มรูปแบบ โดยรัน Python bridge script บน Haven node เพื่อดักจับ, บีบอัด, และตัดแบ่ง (fragment) ข้อมูลให้พอดีกับ MTU 500 byte ของ Reticulum จากนั้นส่งผ่าน Wi-Fi HaLow เข้าสู่ mesh ที่เข้ารหัสไว้ทั้งหมด แล้วประกอบกลับที่ปลายทาง — ผลลัพธ์คือ tactical network สำหรับ mapping/chat ที่ไม่พึ่งเซิร์ฟเวอร์กลางหรืออินเทอร์เน็ตเลยแม้แต่นิดเดียว เหมาะกับภารกิจกู้ภัยหรือพื้นที่ไม่มีโครงสร้างพื้นฐาน

## Caveats / Limits

- Overhead ของ cryptographic header ทำให้แพ็กเก็ต Reticulum ใหญ่กว่าระบบเทียบเท่าที่ไม่เข้ารหัส — ต้องแลกกับความปลอดภัย
- Wi-Fi HaLow ยังเป็นฮาร์ดแวร์เฉพาะทาง (เช่นชิป Morse Micro) หาซื้อยากกว่า Wi-Fi มาตรฐานทั่วไปในบางภูมิภาค
- Bridge script สำหรับ ATAK เป็นงาน integration เฉพาะกิจ (custom Python) ไม่ใช่ฟีเจอร์ built-in ของ ATAK หรือ Reticulum — ต้องดูแล/แก้บั๊กเอง
- Meshtastic/MeshCore ยังเหมาะกว่าสำหรับ lightweight telemetry/text ล้วนๆ ที่ไม่ต้องการข้าม hardware แบบ Reticulum
- Transport Node ต้องมีอย่างน้อยบางโหนดในเครือข่ายที่พอมีทรัพยากร (ไม่ใช่ IoT บอร์ดเล็กสุด) เพื่อทำ routing เต็มรูปแบบ

## References

1. [What is Reticulum? — Reticulum Network Stack documentation](https://reticulum.network/manual/whatis.html)
2. [Understanding Reticulum — Reticulum Network Stack documentation](https://reticulum.network/manual/understanding.html)
3. [markqvist/Reticulum — GitHub](https://github.com/markqvist/reticulum)
4. [markqvist/LXMF — GitHub](https://github.com/markqvist/LXMF)
5. [Haven 2 – IP Mesh Radio (Digital Guide) — Parallel](https://buildwithparallel.com/products/haven)
6. [buildwithparallel/haven-manet-ip-mesh-radio — GitHub](https://github.com/buildwithparallel/haven-manet-ip-mesh-radio)
7. [Reticulum Network — hardware / RNode](https://reticulum.network/hardware.html)
8. [Android Team Awareness Kit — Wikipedia](https://en.wikipedia.org/wiki/Android_Team_Awareness_Kit) / [deptofdefense/AndroidTacticalAssaultKit-CIV — GitHub](https://github.com/deptofdefense/AndroidTacticalAssaultKit-CIV)
9. Source video: ["The Internet, Reinvented."](https://youtu.be/XTnYVh7K6xQ)

## Key Takeaways

- Reticulum คือ networking stack ไม่ใช่ radio protocol — treat วิทยุ/Wi-Fi/สายอีเทอร์เน็ต/สายซีเรียลเป็น interface ที่สลับกันได้หมด สเปกขั้นต่ำแค่ MTU 500 byte + 5bps
- ปลายทางระบุด้วย destination hash 16 byte (SHA-256 truncated) แทน IP address — เข้ารหัสด้วย X25519 + Ed25519 + AES-256-CBC เป็นค่า default
- Transport Node/โหนดทั่วไป แยกบทบาทกัน + on-demand route discovery ทำให้ traffic ขยายตัวแบบ linear ไม่ flood ทั้งเครือข่ายเมื่อ hop เพิ่ม
- LXMF เป็นชั้นข้อความบน Reticulum overhead ~111 byte/ข้อความ เหมาะกับ LoRa/packet radio แบนด์วิดท์ต่ำ
- Haven nodes (Raspberry Pi + Wi-Fi HaLow, Morse Micro chip) บริดจ์ LoRa เข้ากับ Wi-Fi HaLow ได้จริง ระยะเกิน 10km ในสภาพเปิดโล่ง
- สาธิตจริงแล้ว: รัน ATAK เต็มรูปแบบผ่าน Reticulum mesh ด้วย custom Python bridge — ใช้งานได้จริงสำหรับกู้ภัย/off-grid โดยไม่พึ่งอินเทอร์เน็ตหรือเซิร์ฟเวอร์กลางเลย
