---
title: "ออกแบบระบบ Vehicle Tracking ระยะไกลด้วย GNSS RTK และ Iridium Satellite"
date: 2026-05-21 21:49:31 +0700
categories: [Engineering]
tags: [gnss, rtk, iridium, satellite-iot, firmware, telemetry, vehicle-tracking, iot]
slides: true
---

{% include slide-link.html %}

## TL;DR

ออกแบบ end-to-end vehicle tracking system สำหรับพื้นที่ห่างไกลที่ไม่มี cellular coverage โดยใช้ GNSS RTK (centimeter-level accuracy) + RockBLOCK 9704 ผ่าน Iridium IMT เป็น communication backbone. Critical challenge คือ balance ระหว่าง position accuracy, reporting latency และ data cost ภายใต้ 100 KB payload limit และ budget 15 MB/device/month.

## Background / Why this matters

ระบบ fleet management ทั่วไปพึ่งพา cellular network (4G/LTE) ซึ่งทำงานได้ดีในเขตเมือง แต่ล้มเหลวในพื้นที่อุตสาหกรรมจริง เช่น เหมือง, ป่าไม้, เกษตรกรรมขนาดใหญ่, งานสำรวจในพื้นที่ห่างไกล — สถานที่ที่ equipment tracking มีความสำคัญสูงสุดแต่ connectivity กลับเป็นศูนย์.

GPS ธรรมดา (3-5 meter accuracy) เพียงพอสำหรับ general location แต่ไม่ตอบโจทย์ use case ที่ต้องการ lane-level precision หรือ boundary monitoring ที่แม่นยำ เช่น automated farming, mine pit edge monitoring, หรือ geofencing บน terrain ที่ซับซ้อน. นี่คือ domain ของ GNSS RTK (Real-Time Kinematic) ที่ให้ centimeter-level positioning.

ปัญหาคือ RTK corrections และ high-frequency telemetry ต้องการ data link — และในพื้นที่ไม่มี cellular ทางเลือกเดียวที่ global coverage คือ satellite. Iridium เป็น LEO (Low Earth Orbit) constellation ที่ครอบคลุม 100% ของโลกรวม polar regions ต่างจาก GEO satellite (VSAT) ที่มี blind spots และ high latency.

## Deep Dive

### System Architecture

ระบบประกอบด้วย 3 layer หลัก:

```
[Edge Device]  →  Satellite Link  →  [Cloud Pipeline]  →  [Dashboard]
 GNSS Module        Iridium IMT        Ingestion API         Map UI
 MCU                RockBLOCK 9704     Processing Layer      Analytics
 Satellite Modem                       Storage + API
```

**Edge Device** คือหัวใจของระบบ ประกอบด้วย:
- **GNSS Module** (เช่น u-blox ZED-F9P): รับสัญญาณ GPS, GLONASS, Galileo, BeiDou พร้อมกัน; รองรับ RTCM correction input สำหรับ RTK fix
- **MCU**: ควบคุม firmware logic, payload encoding, retry queue
- **RockBLOCK 9704**: Iridium Certus 100 modem; เชื่อมต่อผ่าน UART/USB-C; ส่ง-รับ IMT messages

### GNSS RTK: Centimeter Positioning

RTK ทำงานโดยอาศัย correction data จาก reference station (base station ที่ตำแหน่งรู้แล้ว) ส่งผ่าน RTCM protocol ไปยัง rover (อุปกรณ์บน vehicle). Rover ใช้ carrier-phase measurement ร่วมกับ correction ลด error จาก ionospheric delay, satellite orbit error และ clock drift เหลือ accuracy ระดับ 1-2 cm.

**RTK modes:**
- **Fixed RTK**: ambiguity resolved → accuracy ~1 cm horizontal, ~2 cm vertical
- **Float RTK**: ambiguity not resolved → accuracy ~20-50 cm (ดีกว่า standalone GPS แต่ไม่ถึง fixed)
- **Standalone GPS**: ไม่มี correction → 3-5 m accuracy

**Correction delivery challenge**: ปกติ RTCM corrections ส่งผ่าน internet (NTRIP protocol) แต่ในพื้นที่ไม่มี cellular จำเป็นต้องใช้ local base station radio link หรือยอมรับ Float RTK / standalone mode เป็น fallback.

### RockBLOCK 9704: Satellite Modem

RockBLOCK 9704 เป็น Iridium Certus 100 device ที่ compact และ rugged ที่สุดในตลาด (ณ 2025):

| Spec | Value |
|------|-------|
| Protocol | Iridium Messaging Transport (IMT) |
| Payload size | 25 bytes – 100 KB per message |
| Data rate | 4.8 kbps bi-directional |
| Latency (end-to-cloud) | typically < 10 seconds |
| Voltage | 4.0–5.3 V DC |
| Peak power | 1.4 W |
| Idle power | < 60 mW |
| Sleep power | < 5 mW |
| Temperature | -40°C to +70°C |
| Size (SMA version) | 48 × 52 × 16 mm, < 35g |
| Interfaces | UART (TTL 3.3V), USB-C, U.FL (GNSS passthrough), 5x digital in / 3x digital out |

**ต่างจาก RockBLOCK 9603 (รุ่นเก่า):** รุ่น 9603 ใช้ Short Burst Data (SBD) ซึ่ง payload max เพียง 340 bytes. IMT เปิด payload เป็น 100 KB — ความต่าง ~300x ที่ทำให้ batch telemetry และ compressed payload เป็นไปได้.

### Firmware Design: Adaptive Reporting

**Adaptive reporting** ปรับ reporting interval ตาม vehicle state:

```
if velocity > 5 km/h:
    interval = 30s          # moving: high frequency
elif motion_detected:
    interval = 120s         # idle but engine on
else:
    interval = 600s         # parked: minimal reporting
```

การปรับ interval ตาม state สามารถลด data usage ได้ 60-80% เทียบกับ fixed interval reporting โดยไม่เสียความละเอียดของ track ขณะ vehicle กำลังเคลื่อนที่.

**Budget math** (15 MB/device/month = ~15,000,000 bytes):
- ถ้า compressed payload เฉลี่ย 150 bytes/position
- 15,000,000 ÷ 150 = 100,000 positions/month
- 100,000 ÷ 30 days ÷ 24h ÷ 60min ≈ รายงานได้ทุก **2.3 นาที** ตลอด 24 ชั่วโมง
- ด้วย adaptive interval (30s เมื่อวิ่ง, 600s เมื่อจอด) — budget เพียงพอสำหรับ vehicle ที่วิ่งจริงวันละ 8-10 ชั่วโมง

### Payload Compression Strategy

ข้อมูล telemetry ที่ส่งต่อ message ควรมี:

```
struct TelemetryPacket {
    uint32_t timestamp;      // Unix epoch, 4 bytes
    int32_t  latitude;       // scaled integer (÷1e7), 4 bytes
    int32_t  longitude;      // scaled integer (÷1e7), 4 bytes
    int16_t  altitude_cm;    // altitude in cm, 2 bytes
    uint8_t  fix_type;       // 0=none, 1=GPS, 2=float_rtk, 3=fixed_rtk, 1 byte
    uint8_t  speed_kmh;      // 1 byte
    uint16_t heading;        // 0.1 degree units, 2 bytes
    uint8_t  battery_pct;    // 1 byte
    uint8_t  flags;          // status bits, 1 byte
} // total: 20 bytes per position point
```

ด้วย 20 bytes/point สามารถ batch 50 positions ใน 1 message (1,000 bytes) แทนที่จะส่ง 50 messages แยก — ลด overhead และ satellite call cost ได้มาก.

**Delta encoding** สำหรับ batch: แทนที่จะส่ง absolute coordinates ทุก point ส่ง full coordinate แค่ point แรก แล้วส่งเฉพาะ delta (ความต่างจาก point ก่อน) ซึ่งมักเป็นค่าเล็กมาก — สามารถ compress ด้วย variable-length encoding เหลือ 5-8 bytes/point.

### Store-and-Forward + Retry

เมื่อ satellite link ไม่พร้อม (antenna blocked, message queue full):

```
firmware loop:
  collect_position()
  write_to_local_queue()    # Flash/SD storage
  
  if satellite_ready() and queue_not_empty():
    packet = build_batch(dequeue_up_to_50())
    result = imt_send(packet)
    if result == SUCCESS:
      mark_sent()
    else:
      requeue_with_backoff()   # exponential backoff
```

Queue บน Flash storage ให้ระบบเก็บ positions ได้หลายชั่วโมงถึงหลายวันขณะที่ satellite link ขาด แล้วส่ง batch ใหญ่เมื่อ link กลับมา — ลด data loss โดยไม่เพิ่ม real-time cost.

### Cloud Pipeline

```
Iridium Ground Station → IMT REST API → Ingestion Function → Message Queue
                                                                     ↓
                                                            Processing Worker
                                                            (decode, validate, enrich)
                                                                     ↓
                                                         Time-series DB (positions)
                                                                     ↓
                                                         Dashboard API → Map UI
```

**Key design decisions:**
- **Ingest**: Iridium ส่ง webhook POST ไปยัง endpoint ของเรา (หรือ poll IMT REST API) → parse binary payload → validate → push to queue
- **Processing**: decode compressed packets, validate fix_type quality, compute geofence events
- **Storage**: time-series database (InfluxDB, TimescaleDB, หรือ BigQuery) เหมาะกับ position data มากกว่า relational DB
- **Dashboard**: real-time map (positions), history playback, alert management, cost analytics

## Caveats / Limits

**RTK correction delivery:**
RTK accuracy ระดับ centimeter ต้องการ RTCM correction stream อย่างต่อเนื่อง. ในพื้นที่ไม่มี internet ต้องติดตั้ง local base station และ radio link (UHF/LoRa) หรือยอมรับ Float RTK (~20-50 cm) เป็น operational baseline. RTK signal loss → automatic downgrade เป็น standalone GPS; firmware ต้อง log fix_type ทุก message เพื่อให้ cloud side รู้ accuracy ของแต่ละ point.

**Satellite network latency:**
IMT latency "< 10 seconds" เป็น typical — worst case อาจสูงกว่าในสภาพ network congestion หรือ antenna view ไม่ดี. ระบบนี้ไม่ใช่ real-time tracking (like cellular) แต่ near-real-time reporting. ถ้า application ต้องการ latency < 5s ต้องประเมิน SLA ของ Iridium IMT อย่างละเอียด.

**Payload cost:**
Airtime pricing: $0.30–$0.50/KB overage นอกจาก base plan. ถ้า firmware bug ทำให้ส่ง uncompressed payload หรือ retry loop บ้า — cost พุ่งได้รวดเร็ว. ต้องมี **hard cap** บน firmware ที่ปฏิเสธการส่งถ้า monthly byte counter เกิน threshold, และ cloud-side monitoring บน data volume.

**Supply chain:**
Production-grade GNSS module เช่น u-blox ZED-F9P มี lead time 8-16 สัปดาห์ขึ้นไปในช่วงที่ chip supply tight. RockBLOCK 9704 ก็มี availability เป็นรอบ. ควรวางแผน BOM และ lead time ก่อน commit production timeline.

**IMT message size minimum:**
RockBLOCK 9704 documented minimum payload 25 bytes — ถ้า logic ส่ง heartbeat 5-byte packet ต้องตรวจสอบ behavior ว่า pad หรือ error.

**Single constellation GNSS fallback:**
ZED-F9P support multi-constellation แต่ถ้า firmware ไม่ configure ให้ใช้ทุก constellation หรือ antenna ถูก block — อาจ lose fix ในบางสภาพแวดล้อม (urban canyon, dense forest). ต้องมี firmware fallback logic ที่ชัดเจน.

## References

1. [RockBLOCK 9704 Specifications — Ground Control](https://www.groundcontrol.com/product/rockblock-9704/)
2. [Iridium Messaging Transport (IMT) — Iridium Official](https://www.iridium.com/services/iridium-messaging-transport-imt)
3. [IMT Spec Sheet 2024 — MetOcean](https://metocean.com/wp-content/uploads/2024/10/IMT_SpecSheet_2024-11_v3.pdf)
4. [Iridium Certus 100 Overview — Iridium Official](https://www.iridium.com/services/iridium-certus-100)
5. [u-blox ZED-F9P Module Product Page](https://www.u-blox.com/en/product/zed-f9p-module)
6. [ZED-F9P Product Summary Datasheet — u-blox](https://content.u-blox.com/sites/default/files/ZED-F9P_ProductSummary_UBX-17005151.pdf)
7. [How Iridium IMT Opens Up New IoT Possibilities — Ground Control Blog](https://www.groundcontrol.com/blog/how-iridium-messaging-transport-imt-opens-up-new-iot-possibilities/)
8. [RockBLOCK 9704 — SparkFun Electronics](https://www.sparkfun.com/rockblock-9704-sma.html)

## Key Takeaways

- **Iridium IMT + RockBLOCK 9704** คือ practical choice สำหรับ global satellite IoT ในปี 2025 — payload 100 KB, latency < 10s, rugged hardware ขนาดเล็ก
- **RTK accuracy** ขึ้นกับ correction delivery — ต้องออกแบบ fallback tiers (Fixed → Float → Standalone) และ log fix_type ทุก message
- **15 MB/month budget** achievable ด้วย adaptive interval + binary encoding + batch + delta compression — อย่าส่ง JSON บน satellite
- **Store-and-forward** ไม่ optional — satellite link ขาดเป็นปกติ; firmware ที่ไม่มี queue จะ lose data
- **Cost guard rails** ต้องอยู่ทั้ง firmware (byte counter + hard cap) และ cloud (anomaly alert) — overage บน IMT แพงมาก
- **Supply chain** เป็น risk ที่ underestimated — plan BOM และ lead time ก่อน commit production schedule อย่างน้อย 1 quarter
- Critical success factor คือ **edge intelligence** ที่ decide เมื่อไรส่ง เท่าไร และ compress อย่างไร — cloud pipeline เป็นแค่ receiver
