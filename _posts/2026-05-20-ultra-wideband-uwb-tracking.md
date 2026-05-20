---
title: "Ultra-Wideband (UWB) Tracking: เทคโนโลยีระบุตำแหน่งความแม่นยำสูง"
date: 2026-05-20 12:00:00 +0700
categories: [Research]
tags: [uwb, indoor-positioning, iot, wireless, rtls]
---

## TL;DR

Ultra-Wideband (UWB) คือเทคโนโลยีวิทยุที่ใช้สัญญาณ bandwidth ≥500 MHz วัดระยะแบบ Time-of-Flight ได้ความแม่นยำ **10–30 cm** ในร่ม — เหนือกว่า BLE (~1–5 m) และ Wi-Fi (~5–15 m) หลายเท่า ปัจจุบัน embed อยู่ใน iPhone, AirTag, รถยนต์หลายรุ่น และระบบ RTLS ระดับ industrial

## Background / Why this matters

ระบบ GPS ที่เราใช้ทุกวันทำงานได้ดีเฉพาะ **กลางแจ้ง** เมื่อเข้าอาคาร ผนัง เพดาน และโลหะดูดซับ/สะท้อนสัญญาณดาวเทียมจนแม่นยำไม่พอสำหรับงานหลายอย่าง เช่น ติดตามแพทย์/อุปกรณ์ใน รพ., นำหุ่นยนต์คลังสินค้า, หรือบอกทิศทาง AirTag ให้ผู้ใช้

เทคโนโลยี indoor positioning ก่อนหน้า (BLE beacons, Wi-Fi RTT) ให้ความแม่นยำระดับ "ห้อง" ไม่ใช่ระดับ "จุด" ซึ่งไม่พอสำหรับ use case ใหม่ๆ ที่ต้องการบอกได้ว่าอุปกรณ์อยู่บนชั้นวางไหน หรือ fork lift อยู่ห่างจากกำแพงเท่าไร

UWB แก้ปัญหานี้ด้วยการส่งพัลส์สัญญาณที่กว้างมาก ทำให้แยก multipath จากสัญญาณตรงได้ วัดเวลาเดินทางของสัญญาณด้วยความละเอียดต่ำกว่า 1 นาโนวินาที — ซึ่งแปลงเป็นระยะทาง ≈30 cm ต่อ 1 ns

UWB กลับมาอยู่ใน mainstream ตั้งแต่ปี 2019 เมื่อ Apple ใส่ชิป U1 ใน iPhone 11 ตามด้วย AirTag (2021), Samsung SmartTag+, และ digital car key ของ BMW/Genesis/Kia ทำให้ ecosystem ขยายตัวอย่างรวดเร็ว

## Deep Dive

### มาตรฐาน IEEE

**IEEE 802.15.4a (2007)** เป็นมาตรฐานแรกที่นำ UWB เข้าสู่ family 802.15.4 กำหนด PHY layer สำหรับ UWB และ Chirp Spread Spectrum ครอบคลุม 3 band: sub-GHz (~499 MHz), low band (3–5 GHz), high band (6–10 GHz) ต่อมา merge เข้า IEEE 802.15.4-2011

**IEEE 802.15.4z (2020)** เพิ่ม Scrambled Timestamp Sequence (STS) — waveform เข้ารหัสที่ปกป้อง ranging timestamp ป้องกัน relay attack ซึ่งสำคัญมากสำหรับ digital car key (ไม่งั้นคนร้าย retransmit สัญญาณจากระยะไกลแล้วปลดล็อกรถได้) มาตรฐานนี้ยังเพิ่ม data rate สูงสุด 31.2 Mb/s และ higher PRF modes (BPRF 62.4 MHz, HPRF 124.8–249.6 MHz)

### Channels และ Frequencies

FCC นิยาม UWB คือสัญญาณที่มี bandwidth (−10 dB) ≥500 MHz หรือ fractional bandwidth ≥0.20 จำกัด power ไว้ที่ −41.3 dBm/MHz ใน band 3.1–10.6 GHz ทำให้รบกวนระบบอื่นน้อยมาก

มาตรฐาน 802.15.4 กำหนด 16 channels รวมกัน แต่ที่นิยมในผลิตภัณฑ์จริง:

| Channel | Center Freq | ผู้ใช้หลัก |
|---------|-------------|-----------|
| **Ch 5** | ~6.5 GHz | Qorvo DW3000, NXP SR150, Apple U1/U2 |
| **Ch 9** | ~8.0 GHz | Qorvo DW3000, NXP SR150, Apple U1/U2 |

Apple U1 ใช้ 6.24 GHz และ 8.2368 GHz ซึ่งตรงกับ channel 5 และ 9 นี้พอดี ทำให้ interoperable กับ third-party UWB hardware ที่รองรับ FiRa

### Ranging Methods

**Two-Way Ranging (TWR)**

Tag ส่ง poll ไป anchor, anchor ตอบพร้อม timestamp, tag คำนวณ round-trip time หาระยะ ไม่ต้องซิงค์นาฬิการะหว่าง anchor

- **SS-TWR** (Single-Sided): แลกสัญญาณ 2 รอบ เรียบง่ายแต่มี clock drift error
- **DS-TWR** (Double-Sided): แลก 3 รอบ — รอบที่สามยกเลิก clock drift error ความแม่นยำ <10 cm ด้วยการ calibrate ที่ดี

**TDoA (Time Difference of Arrival)**

Tag ส่งสัญญาณครั้งเดียว ("blink") หลาย anchor รับพร้อมกันแล้วเปรียบเทียบ timestamp ระบบคำนวณตำแหน่งจาก hyperbolic trilateration

- Tag power ต่ำมาก (ส่งทางเดียว) → ใช้ถ่านได้หลายปี, scale ได้ถึงหลักพัน tag
- **Trade-off**: ต้องซิงค์นาฬิกา anchor ระดับนาโนวินาที — เพิ่ม infrastructure cost และ complexity

### Chips สำคัญ

| Chip | มาตรฐาน | Accuracy | เหมาะกับ |
|------|---------|----------|---------|
| Qorvo DW1000 | 802.15.4a | <10 cm | อุปกรณ์รุ่นเก่า, prototype |
| Qorvo DW3000 | 802.15.4a + 4z | 10 cm | อุปกรณ์ใหม่, FiRa compliant |
| NXP SR040 | 802.15.4z | <10 cm | Tag/tracker พลังงานต่ำ, TDoA |
| NXP SR150 | 802.15.4z | ±10 cm / ±3° AoA | Anchor, access control, รถยนต์ |
| Apple U1 | 802.15.4a/z | ~10–15 cm | iPhone 11–14, AirTag gen 1 |
| Apple U2 | 802.15.4z | ~10 cm | iPhone 15+, AirTag gen 2 |

NXP SR150 โดดเด่นด้วย Angle of Arrival (AoA) ±3° ทำให้บอกได้ทั้งระยะและ **ทิศทาง** ซึ่งคือสิ่งที่ทำให้ Precision Finding บน iPhone ชี้ลูกศรได้

### UWB vs เทคโนโลยีอื่น (Indoor Positioning)

| | UWB | BLE | Wi-Fi | GPS |
|--|-----|-----|-------|-----|
| **Accuracy** | 10–30 cm | 1–5 m | 5–15 m | ~10 m (กลางแจ้งเท่านั้น) |
| **Range** | 50–70 m/anchor | 10–30 m | 40–50 m | Global |
| **Power (tag)** | ต่ำ (TDoA: ปีต่อถ่าน) | ต่ำมาก | สูง | สูงมาก |
| **Indoor** | ดีเยี่ยม | ระดับห้อง | ระดับห้อง | ใช้ไม่ได้ |
| **Infrastructure** | ต้องติด UWB anchor | BLE gateway | Wi-Fi AP | ดาวเทียม |
| **Cost (tag)** | ~2× BLE | ต่ำ | ปานกลาง | ขึ้นกับโมดูล |

### ผลิตภัณฑ์ที่ใช้ UWB

**Apple ecosystem**
- iPhone 11–14: ชิป U1 — Precision AirDrop, Nearby Interaction framework (iOS 14+)
- iPhone 15+: ชิป U2 — Expanded Precision Finding, Find People
- AirTag gen 1 (2021): U1, Precision Finding (ทิศทาง + ระยะ) ทำงานในระยะ ~60 m
- AirTag gen 2 (2025): U2, ระยะขยายกว้างขึ้น

**Android / Samsung**
- Galaxy S21+, S22+, S23+: Samsung Digital Key, SmartTag+
- Galaxy SmartTag+: Precise direction finding (ต้องใช้คู่กับ UWB phone)

**Car Digital Key (ใช้ CCC Digital Key 3.0 spec ที่สร้างบน 802.15.4z)**
- **BMW Digital Key Plus**: hands-free unlock ไม่ต้องหยิบโทรศัพท์จากกระเป๋า, Android support (Galaxy S23+, Pixel 7 Pro) เปิดตัว April 2023
- **Genesis GV60**: รถ EV คันแรกที่ใช้ Samsung UWB digital key
- **Kia Niro**: รองรับ Samsung Digital Key

**Industrial RTLS (Real-Time Location System)**
- โรงพยาบาล: ติดตาม stretcher, อุปกรณ์ราคาสูง, บุคลากร
- คลังสินค้า: ติดตาม forklift, พนักงาน, สินค้า ป้องกันอุบัติเหตุ
- กีฬา: วัดตำแหน่ง/ความเร็วนักกีฬาแบบ real-time

### Infrastructure ที่ต้องการ (TWR vs TDoA)

**TWR system**
- Anchor ขั้นต่ำ: 3 (สำหรับ 2D fix), แนะนำ 4+ เพื่อ reliability
- ไม่ต้องซิงค์นาฬิการะหว่าง anchor
- PoE + network backhaul ต่อ anchor

**TDoA system**
- Anchor เดิม + nanosecond-level time sync (hardware PPS หรือ wired sync)
- Tag ใช้ถ่านได้นานหลายปี, scale ได้ไม่จำกัด
- Complexity อยู่ที่ sync infrastructure ไม่ใช่ที่ tag

ทั้งสองโหมดครอบคลุม ~50–70 m ต่อ anchor pair ใน LOS; NLOS ต้องติด anchor ถี่ขึ้น

## Caveats / Limits

**NLOS (Non-Line-of-Sight)** คือ error source หลักในทางปฏิบัติ ผนังคอนกรีต ประตูโลหะ ลิฟต์ หรือแม้แต่ร่างกายคนทำให้เกิด positive range bias ตั้งแต่หลาย cm จนถึงหลาย m การแก้ด้วย machine learning + sensor fusion (IMU, floor map) เป็น active research area

**Multipath** ใน environment ที่มีโลหะหนาแน่น (โกดัง, ห้อง server) แม้ UWB จะแยก multipath ได้ดีกว่า narrowband แต่ยังเกิด error ได้ในสถานการณ์รุนแรง

**Cost** anchor UWB ราคาสูงกว่า BLE beacon มาก ระบบ RTLS ขนาดใหญ่ต้องลงทุน CapEx สำหรับ hardware, network backhaul, และ clock sync (TDoA) แต่ราคากำลังลดลงตาม consumer adoption ที่เพิ่มขึ้น

**Regulatory variability** FCC (US) อนุญาต 3.1–10.6 GHz แต่ EU (ETSI), ญี่ปุ่น, เกาหลี มี band restriction ต่างกัน ผลิตภัณฑ์ที่ขายหลายตลาดต้องผ่าน multi-region compliance

**Security (802.15.4z)** แม้ STS จะป้องกัน relay attack แต่งานวิจัย (Singh et al., arXiv 2023) แสดงว่าถ้า distance miss-detection threshold ตั้งต่ำกว่า 10% โอกาสสำเร็จของ distance-shortening attack อยู่ที่ 7–90% ขึ้นอยู่กับ receiver configuration — ต้อง tune threshold อย่างระมัดระวัง

**TWR Scalability** time-division scheme จำกัดจำนวน tag ต่อ anchor zone ถ้าต้องการ scale ต้องพิจารณาเปลี่ยนไปใช้ TDoA mode

## References

1. [IEEE SA — IEEE 802.15.4z-2020](https://standards.ieee.org/ieee/802.15.4z/10230/)
2. [Keysight — An Overview of the IEEE 802.15.4 HRP UWB Standard](https://www.keysight.com/blogs/en/tech/rfmw/2021/07/28/an-overview-of-the-ieee-802154-hrp-uwb-standard)
3. [Wikipedia — IEEE 802.15.4a](https://en.wikipedia.org/wiki/IEEE_802.15.4a)
4. [arXiv — Secure Ranging with IEEE 802.15.4z HRP UWB (Singh et al., 2023)](https://arxiv.org/html/2312.03964v2)
5. [FCC 02-48 UWB First Report and Order (2002)](https://transition.fcc.gov/Bureaus/Engineering_Technology/Orders/2002/fcc02048.pdf)
6. [Wikipedia — List of UWB Channels](https://en.wikipedia.org/wiki/List_of_UWB_channels)
7. [Qorvo — UWB Technology Overview](https://www.qorvo.com/innovation/ultra-wideband/technology)
8. [Qorvo — DW1000 Product Page](https://www.qorvo.com/products/p/DW1000)
9. [Qorvo — DWM3000 Module](https://www.qorvo.com/products/p/DWM3000)
10. [NXP — Trimension SR040](https://www.nxp.com/products/wireless-connectivity/trimension-uwb/trimension-sr040-reliable-uwb-solution-for-iot:SR040)
11. [NXP — Trimension SR150](https://www.nxp.com/products/wireless-connectivity/secure-ultra-wideband-uwb/trimension-sr150-secure-uwb-solution-for-iot-devices:SR150)
12. [Apple Support — Ultra Wideband Device Availability](https://support.apple.com/en-us/109512)
13. [TechInsights — Apple U1 (TMKA75) Chip Analysis](https://www.techinsights.com/blog/apple-u1-tmka75-ultra-wideband-uwb-chip-analysis)
14. [TechInsights — Apple U2 (TMQE08) Chip Analysis](https://www.techinsights.com/blog/apple-u2-tmqe08-die-ultra-wide-band-chip-floorplan-analysis-iotb)
15. [BMW Press — BMW Digital Key Plus on Android (April 2023)](https://www.press.bmwgroup.com/usa/article/detail/T0414019EN_US/bmw-digital-key-plus-now-available-on-compatible-android-devices)
16. [Android Police — Samsung UWB Digital Key for Genesis GV60](https://www.androidpolice.com/samsungs-uwb-digital-car-key-genesis-gv60-electric/)
17. [Pozyx — UWB vs Other Technologies (2026)](https://www.pozyx.io/newsroom/uwb-versus-other-technologies)
18. [Seeed Studio — BLE vs UWB vs GPS vs Wi-Fi Indoor Positioning (2025)](https://www.seeedstudio.com/blog/2025/11/13/ble-vs-uwb-vs-gps-vs-wifi-which-is-the-best-indoor-positioning-technology-for-personal-safety/)
19. [Lansitec — UWB Accuracy 2026 Guide](https://www.lansitec.com/blogs/uwb-accuracy-in-2026-essential-guide-to-10-cm-indoor-positioning/)
20. [CUWB — Anchor Deployment Estimator](https://www.cuwb.io/docs/v5.0/planning-for-deployment/anchor-estimator/)
21. [MDPI Sensors — Influence of UWB Anchor Placement on Localization Accuracy](https://www.mdpi.com/1424-8220/25/16/5115)
22. [IB Lenhardt — UWB Testing and Global Regulatory Compliance](https://ib-lenhardt.com/kb/ultra-wideband)

## Key Takeaways

- UWB ใช้สัญญาณ bandwidth ≥500 MHz วัดเวลาเดินทางด้วยความละเอียดต่ำกว่า 1 ns → ความแม่นยำ **10–30 cm** เหนือกว่า BLE/Wi-Fi หลายเท่า
- Ranging แบ่งเป็น 2 โหมดหลัก: **TWR** (tag-anchor handshake, ไม่ต้องซิงค์ anchor, แต่ tag ใช้พลังงานมากกว่า) vs **TDoA** (tag blink one-way, ประหยัดพลัง, scale ได้กว่า แต่ต้องซิงค์ anchor ระดับ ns)
- **802.15.4z + STS** เพิ่มการเข้ารหัส timestamp ป้องกัน relay attack — สำคัญสำหรับ car key และ payment use case
- Chips หลัก: Qorvo DW3000, NXP SR150 (AoA ±3°), NXP SR040 (low-power tag), Apple U1/U2 — ทุกตัวรองรับ channel 5 + 9 และ FiRa interoperability
- **Consumer mainstream แล้ว**: iPhone 11+ (U1), iPhone 15+ (U2), AirTag gen 1/2, Samsung Galaxy flagship, BMW/Genesis/Kia Digital Key Plus
- **NLOS** คือ error source หลักในทางปฏิบัติ ผนังและโลหะเพิ่ม bias ตั้งแต่ cm ถึง m — ML + sensor fusion เป็น mitigation ที่นิยม
- ราคา UWB กำลังลดลงตาม consumer volume แต่ยังสูงกว่า BLE; Industrial RTLS คุ้มค่าเมื่อต้องการความแม่นยำระดับ sub-meter
