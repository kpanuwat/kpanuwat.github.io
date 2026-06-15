---
title: "ESP32 OTA: อัปเดตเฟิร์มแวร์แบบไร้สาย 3 วิธี"
date: 2026-06-14 00:01:00 +0700
categories: [Engineering]
tags: [esp32, iot, ota, arduino, firmware, embedded]
image:
  path: /assets/images/esp32_ota_concept.png
  alt: ESP32 OTA Wireless Firmware Update Concept Illustration
slides: true
---

{% include slide-link.html %}

## TL;DR

ESP32 รองรับการอัปเดตเฟิร์มแวร์แบบไร้สาย (OTA) โดยไม่ต้องใช้สาย USB ผ่าน 3 วิธีหลัก ได้แก่ Arduino OTA (IDE), Web OTA (browser upload), และ Server Pull OTA (auto-fleet update) — ทั้งหมดอาศัยการแบ่ง flash memory เป็น 2 partition สลับกัน

## Background / Why this matters

ในโลก IoT การที่ต้องเดินไปเสียบสาย USB เพื่ออัปเดตเฟิร์มแวร์ทีละตัวนั้นไม่ practical เลย โดยเฉพาะเมื่อ deploy อุปกรณ์ไปแล้วหลายร้อยจุด ไม่ว่าจะเป็น smart home sensor, industrial monitor หรือ weather station ที่ติดตั้งอยู่บนหลังคา

ESP32 แก้ปัญหานี้ด้วย OTA (Over-the-Air) update — กลไกที่ให้บอร์ดรับโค้ดใหม่ผ่าน Wi-Fi แล้ว reboot เข้า firmware ใหม่โดยอัตโนมัติ โดยที่ระบบ downtime แทบเป็นศูนย์ และไม่ต้องแตะตัวฮาร์ดแวร์เลย

ความสำคัญยิ่งกว่านั้นคือ OTA เปิดให้ทำ **remote bug fix** และ **security patch** ได้หลัง deploy ไปแล้ว — สิ่งที่ขาดไม่ได้ในระบบ production IoT สมัยใหม่

## Deep Dive

### Flash Partition Layout: หัวใจของ OTA

กลไก OTA ของ ESP32 พึ่งพา **partition table** ที่แบ่ง flash memory ออกเป็นส่วนย่อย โดยมี 3 partition ที่สำคัญ:

| Partition | ชื่อย่อ | บทบาท |
|-----------|---------|-------|
| `app0` | OTA0 | เก็บ firmware ที่รันอยู่ปัจจุบัน |
| `app1` | OTA1 | เก็บ firmware ใหม่ระหว่างอัปเดต |
| `otadata` | OTA Data | pointer ที่บอก bootloader ว่าให้บูตจาก partition ไหน |

**การทำงาน (A/B swap pattern):**

```
ก่อนอัปเดต:  otadata → app0 (running)
ระหว่างอัปเดต: เขียน firmware ใหม่ลง app1 (ESP32 ยังรัน app0 อยู่)
หลังอัปเดต:  otadata → app1 (reboot แล้วรัน firmware ใหม่)
อัปเดตครั้งต่อไป: เขียนลง app0, flip กลับ
```

ข้อดีคือ **atomic swap** — ถ้าไฟดับระหว่างเขียน firmware ใหม่ ระบบยัง boot จาก partition เดิมได้ เพราะ otadata ยังไม่ถูกเปลี่ยน `otadata` ใช้ 2 flash sector (0x2000 bytes) เพื่อ resilience กรณี power fail กลางคัน [1]

### Method 1: Arduino OTA

วิธีนี้ใช้ library `ArduinoOTA` ที่มาใน ESP32 Arduino Core โดยตรง บอร์ดจะ advertise ตัวเองเป็น network port บน Wi-Fi ทำให้ Arduino IDE มองเห็นและ upload ผ่าน Wi-Fi ได้เลย

**โค้ด skeleton:**

```cpp
#include <WiFi.h>
#include <ArduinoOTA.h>

void setup() {
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) delay(500);

  ArduinoOTA.setHostname("my-esp32");
  ArduinoOTA.setPassword("your-password");  // optional but recommended
  ArduinoOTA.begin();
}

void loop() {
  ArduinoOTA.handle();  // ต้องเรียกทุก iteration — non-blocking
  // ... โค้ดหลักของคุณ
}
```

ครั้งแรกยังต้องใช้ USB flash เพื่อใส่โค้ดที่มี ArduinoOTA — หลังจากนั้นทุก upload ใช้ Wi-Fi ได้เลย [2]

**เหมาะกับ:** นักพัฒนาที่ใช้ Arduino IDE, การ iterate โค้ดระหว่าง dev phase
**ข้อจำกัด:** ต้องมี Arduino IDE, ไม่มี wireless serial monitor, ทุกคนบน network เดียวกันสามารถ flash ได้ถ้าไม่ set password [2]

### Method 2: Web OTA

ESP32 ทำตัวเป็น **web server** ที่ host หน้าเว็บสำหรับ upload .bin file เปิด browser ไปที่ IP ของบอร์ด กด upload ได้เลย ไม่ต้องติดตั้งอะไร

**โค้ด skeleton:**

```cpp
#include <WiFi.h>
#include <WebServer.h>
#include <Update.h>

WebServer server(80);

void handleUpdate() {
  HTTPUpload& upload = server.upload();
  if (upload.status == UPLOAD_FILE_START) {
    Update.begin();
  } else if (upload.status == UPLOAD_FILE_WRITE) {
    Update.write(upload.buf, upload.currentSize);
  } else if (upload.status == UPLOAD_FILE_END) {
    Update.end(true);
    server.sendHeader("Location", "/");
    server.send(303);
    ESP.restart();
  }
}

void setup() {
  WiFi.begin(ssid, password);
  server.on("/update", HTTP_POST, []() {}, handleUpdate);
  server.begin();
}

void loop() {
  server.handleClient();  // non-blocking
}
```

**วิธี export .bin จาก Arduino IDE:** `Sketch → Export Compiled Binary` → ได้ไฟล์ `.bin` ในโฟลเดอร์ sketch [2]

**เหมาะกับ:** deploying ให้ user ที่ไม่มี Arduino IDE, field tech ที่ต้องอัปเดตในสนาม
**ข้อจำกัด:** ต้อง distribute .bin ไปถึงมือ user, ไม่มี version control อัตโนมัติ [2]

### Method 3: Server Pull OTA

วิธีที่ professional ที่สุด — **บอร์ดเป็นฝ่ายดึงอัปเดตเอง** จาก server ตามกำหนดเวลาหรือ trigger ตรวจเวอร์ชัน ถ้ามี version ใหม่ก็ download และ apply เอง

**Architecture:**

```
ESP32                         Server (Python / Nginx / S3)
  │                               │
  ├─ fetch version.txt ─────────► │ "1.2.0"
  ├─ compare with running ver ─┐  │
  │  running=1.1.0 < 1.2.0    │  │
  └─ fetch firmware.bin ──────►│  │
     flash to inactive part.   │  │
     update otadata             │  │
     ESP.restart()             ◄─┘
```

**Server ง่ายๆ ด้วย Python:**

```bash
# สร้าง directory โครงสร้าง
mkdir ota-server && cd ota-server
echo "1.2.0" > version.txt
cp sketch.ino.esp32.bin firmware.bin
python3 -m http.server 8080
```

**ESP32 sketch:**

```cpp
#include <HTTPClient.h>
#include <Update.h>

#define FIRMWARE_VERSION "1.1.0"
#define SERVER_URL "http://192.168.1.100:8080"

void checkForUpdate() {
  HTTPClient http;
  http.begin(SERVER_URL + String("/version.txt"));
  if (http.GET() == 200) {
    String latestVersion = http.getString();
    latestVersion.trim();
    if (latestVersion != FIRMWARE_VERSION) {
      performUpdate(SERVER_URL + "/firmware.bin");
    }
  }
  http.end();
}

void performUpdate(String url) {
  HTTPClient http;
  http.begin(url);
  int httpCode = http.GET();
  if (httpCode == 200) {
    int contentLength = http.getSize();
    WiFiClient* stream = http.getStreamPtr();
    if (Update.begin(contentLength)) {
      Update.writeStream(*stream);
      if (Update.end()) ESP.restart();
    }
  }
  http.end();
}
```

**เหมาะกับ:** fleet ของ IoT อุปกรณ์ที่ deploy แล้ว, production systems, CI/CD pipeline ที่ push .bin อัตโนมัติ [2]

### Critical Rule: ห้ามใช้ Blocking Code ในลูป

**`delay()` เป็นศัตรูของ OTA** — ทำให้ CPU หยุดทำงาน ทำให้พลาด OTA packet ที่เข้ามา:

```cpp
// ❌ ผิด — ถ้ามี OTA request ระหว่าง delay() จะหาย
void loop() {
  doSomething();
  delay(5000);        // บล็อก 5 วินาที — OTA request ที่มาช่วงนี้หายหมด
  ArduinoOTA.handle();
}

// ✅ ถูก — ใช้ millis() แทน
unsigned long lastRun = 0;
void loop() {
  ArduinoOTA.handle();   // ต้องอยู่ต้นลูป, ทุก iteration
  if (millis() - lastRun >= 5000) {
    lastRun = millis();
    doSomething();
  }
}
```

นอกจาก `delay()` แล้ว ต้องระวัง: blocking HTTP request ยาว, `while(true)` ที่ไม่ yield, และ task ที่ใช้ CPU นาน [2]

## User Guide (Step-by-Step)

### เริ่มต้น: Arduino OTA

**1. ติดตั้ง ESP32 Board Package ใน Arduino IDE**

`File → Preferences → Additional Boards Manager URLs`:
```
https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
```
แล้วไป `Tools → Board → Boards Manager` ค้นหา "esp32" และ Install

**2. เลือก Partition Scheme ที่รองรับ OTA**

`Tools → Partition Scheme → "Default 4MB with spiffs (1.2MB APP/1.5MB SPIFFS)"` หรือ `"Minimal SPIFFS (Large APPS with OTA)"`

ถ้าใช้ partition scheme ที่ไม่มี OTA slot สอง slot OTA จะ fail ตอน runtime

**3. Flash ครั้งแรกผ่าน USB**

Upload sketch ที่มี `ArduinoOTA.begin()` ผ่าน USB ปกติ เปิด Serial Monitor ดู IP address ของบอร์ด

**4. Upload ครั้งต่อไปผ่าน Wi-Fi**

`Tools → Port` → เลือก port ที่ชื่อเป็น IP address (เช่น `192.168.1.42 at my-esp32`) แล้ว Upload ตามปกติ

**5. ตรวจสอบว่า OTA สำเร็จ**

Serial Monitor จะแสดง:
```
Receiving OTA...
OTA Progress: 100%
Rebooting...
```

### Server Pull OTA: Production Setup

**1. สร้าง version file และ firmware file**

ทุกครั้งที่ build firmware ใหม่ ให้ bump version ใน sketch:
```cpp
#define FIRMWARE_VERSION "1.2.0"
```
แล้ว export .bin และอัปโหลดขึ้น server พร้อมอัปเดต `version.txt`

**2. Trigger การอัปเดต**

Options: timer (ทุก X นาที), physical button, MQTT message, หรือ HTTP endpoint บนตัว ESP32 เอง

**3. Monitor via Serial / Logging**

เพิ่ม logging ใน `performUpdate()`:
```cpp
Serial.printf("Update: %s → checking server\n", FIRMWARE_VERSION);
```

## Caveats / Limits

- **Flash size:** partition scheme OTA ต้องการ flash อย่างน้อย 2MB (OTA0+OTA1 partition ใหญ่พอสำหรับ .bin ของคุณ) — ESP32 ส่วนใหญ่มี 4MB แต่ถ้าใช้ ESP32-C3 รุ่นถูกอาจมีแค่ 2MB [1]
- **No wireless serial monitor ใน Arduino OTA:** ต้อง reconnect USB เพื่อดู Serial output [2]
- **HTTP Server Pull ไม่ encrypt โดย default:** ใช้ HTTPS (`WiFiClientSecure`) ถ้า firmware มี sensitive logic หรือ deploy บน network สาธารณะ [1]
- **OTA อาจ fail ถ้า flash เต็ม:** ก่อน OTA ควรตรวจ `ESP.getFreeSketchSpace()` ให้ใหญ่พอสำหรับ .bin ใหม่
- **Anti-rollback (ESP-IDF เท่านั้น):** Arduino framework ไม่มี anti-rollback built-in — ถ้าต้องการป้องกัน downgrade ต้องเขียน logic เองหรือใช้ ESP-IDF โดยตรง [1]
- **mDNS ใน Arduino OTA:** ต้องการ `ESPmDNS` library และ mDNS ทำงานได้ดีบน local network แต่อาจมีปัญหากับ router บางรุ่นที่ block multicast

## References

1. Espressif Systems, "Over The Air Updates (OTA) — ESP-IDF Programming Guide v6.0.1," [Online]. Available: https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/system/ota.html
2. DroneBot Workshop, "Upgrade Your ESP32 Projects Wirelessly | ESP32 OTA Tutorial," YouTube, 2024. Available: https://youtu.be/8m5M3ZIXlWw
3. ESP8266 Arduino Core, "OTA Updates," Read the Docs. Available: https://arduino-esp8266.readthedocs.io/en/latest/ota_updates/readme.html
4. Espressif Systems, "arduino-esp32 Update Library README," GitHub. Available: https://github.com/espressif/arduino-esp32/blob/master/libraries/Update/README.md

## Key Takeaways

- ESP32 OTA ใช้ **A/B partition swap** (OTA0/OTA1 + otadata pointer) — เขียน firmware ใหม่ใน inactive partition ก่อน แล้ว atomic flip; ถ้า power ดับกลางคัน ระบบยัง boot partition เดิมได้
- **Arduino OTA** เหมาะ dev phase — update จาก IDE ผ่าน Wi-Fi, setup เร็ว แต่ต้องมี IDE
- **Web OTA** เหมาะ field deployment — user เปิด browser ไปที่ IP บอร์ด upload .bin ได้เลย ไม่ต้องติดตั้งอะไร
- **Server Pull OTA** เหมาะ fleet management — ESP32 ดึง update เองอัตโนมัติ, check version ก่อน download, scale ได้ไม่จำกัด
- **`delay()` เป็นบัคพื้นฐานของ OTA** — ใช้ `millis()` แทนเสมอ; `ArduinoOTA.handle()` / `server.handleClient()` ต้องอยู่ทุก iteration ของ loop
- Production OTA ต้องการ HTTPS + firmware signing เพื่อป้องกัน malicious update บน network สาธารณะ
- ต้องเลือก **Partition Scheme ที่มี OTA** ใน Arduino IDE ก่อน flash ครั้งแรก — เปลี่ยนทีหลังไม่ได้หากไม่ reflash ทั้งหมด
