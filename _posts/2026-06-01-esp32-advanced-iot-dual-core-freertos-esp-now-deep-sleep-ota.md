---
title: "ESP32 ยกระดับงาน IoT: Dual-core FreeRTOS, ESP-NOW, Deep Sleep, OTA และ TLS"
date: 2026-05-31 06:46:00 +0700
categories: [Engineering]
tags: [esp32, freertos, iot, embedded, ota, tls, hardware]
---

## TL;DR

ESP32 มีฟีเจอร์ระดับ pro ที่ทำให้งาน IoT ซับซ้อนทำได้จริง — Dual-core + FreeRTOS สำหรับ multitasking แท้, ESP-NOW สำหรับ mesh ไร้ broker, Deep Sleep + ULP ยืดแบตฯ ได้เป็นปี, OTA Update อัพเดท firmware จากระยะไกล, TLS + mbedTLS รักษาความปลอดภัย, และ DMA สำหรับรับส่งข้อมูลความเร็วสูง

## Background / Why this matters

ESP32 ไม่ใช่แค่ "Arduino ที่มี WiFi" — มัน redesign ใหม่ทั้งหมดสำหรับงาน IoT production ที่ต้องการความน่าเชื่อถือ ประสิทธิภาพ และ security พร้อมกัน

ความแตกต่างหลักจาก ESP8266 คือ ESP32 มี **CPU 2 core** แยกกัน ทำให้รันงานพร้อมกันได้จริงโดยไม่ blocking กัน; มี **ULP Co-processor** ที่ทำงานขณะ main CPU หลับ ทำให้ประหยัดพลังงานอย่างมาก; และมี **hardware security accelerators** (AES, SHA, RSA) ทำให้เข้ารหัสได้โดยไม่กินเวลา CPU

วิดีโอ YouTube ที่เป็นต้นฉบับบทความนี้พาผ่าน 8 ฟีเจอร์ที่ยกระดับงาน IoT จากระดับ hobbyist ขึ้นไปสู่ production-ready ทุกฟีเจอร์มีตัวอย่างโค้ดและ use case จริง

## Deep Dive

### 1. Dual-core + FreeRTOS: Multitasking แท้

ESP32 มี **Xtensa LX6 32-bit dual-core** (Core 0 = Protocol CPU, Core 1 = Application CPU) ที่รันพร้อมกันได้จริง ต่างจาก microcontroller ทั่วไปที่ cooperative multitasking เท่านั้น

FreeRTOS เป็น RTOS ที่ built-in ใน ESP-IDF และ Arduino core — สร้าง task ได้ด้วย `xTaskCreatePinnedToCore()`:

```cpp
// กำหนด task ที่ Core 0 (Protocol CPU)
xTaskCreatePinnedToCore(
  sensorTask,     // function
  "SensorTask",   // name
  4096,           // stack size (bytes)
  NULL,           // parameter
  1,              // priority (1-25)
  &sensorHandle,  // task handle
  0               // core: 0 หรือ 1
);

// กำหนด task ที่ Core 1 (Application CPU)
xTaskCreatePinnedToCore(
  displayTask,
  "DisplayTask",
  4096, NULL, 1, &displayHandle, 1
);
```

**Best practice**: แยก WiFi/BLE stack ไว้ Core 0, ส่วน sensor reading + display update ไว้ Core 1 เพื่อไม่ให้ network stack รบกวน timing-sensitive งาน

**Synchronization**: ใช้ Queue และ Semaphore เมื่อ task ต้องแชร์ข้อมูล — อย่า access shared variable โดยตรงข้ามระหว่าง task

---

### 2. ESP-NOW: การสื่อสาร P2P ไร้ router

**ESP-NOW** คือ protocol ของ Espressif ที่ให้ ESP32 คุยกันโดยตรงโดยไม่ต้องผ่าน WiFi router หรือ MQTT broker — ส่ง packet ตรงระหว่างอุปกรณ์ในระดับ MAC layer

**Specs ที่สำคัญ:**
| ค่า | Standard Mode | Long Range Mode |
|---|---|---|
| Data rate | 1 Mbps | 512 / 256 Kbps |
| Max payload | 250 bytes | 250 bytes |
| Range (outdoor LOS) | ~220–400 m | มากกว่า |
| Range (through walls) | 40–100 m | — |
| Max peers | 20 (unicast) | — |

```cpp
#include <esp_now.h>
#include <WiFi.h>

uint8_t peerMac[] = {0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};

void setup() {
  WiFi.mode(WIFI_STA);
  esp_now_init();
  
  esp_now_peer_info_t peerInfo = {};
  memcpy(peerInfo.peer_addr, peerMac, 6);
  peerInfo.channel = 0; // same as WiFi channel
  esp_now_add_peer(&peerInfo);
}

void sendData(float value) {
  esp_now_send(peerMac, (uint8_t*)&value, sizeof(value));
}
```

**เหมาะสำหรับ**: sensor mesh ใน warehouse, remote control ที่ไม่ต้องมี internet, home automation โดยไม่ผ่าน cloud

---

### 3. Wi-Fi/BLE Coexistence

ESP32 ใช้ **time-division multiplexing (TDM)** ให้ WiFi และ BLE ใช้งาน 2.4GHz radio เดียวกันพร้อมกันได้ — สลับกันใช้ antenna ในระดับ microsecond

**Coexistence modes** (ESP-IDF):
- `ESP_COEX_PREFER_WIFI` — WiFi ได้ priority สูงกว่า; BLE อาจ latency สูง
- `ESP_COEX_PREFER_BT` — BLE ได้ priority; WiFi throughput ลด
- `ESP_COEX_PREFER_BALANCE` — สมดุล (default)

```cpp
#include "esp_coexist.h"
esp_coex_preference_set(ESP_COEX_PREFER_BALANCE);
```

ESP-NOW สามารถรันคู่กับ WiFi ได้โดยกำหนด channel ให้ตรงกัน: ถ้า WiFi connect อยู่ที่ channel 6, ให้ ESP-NOW peer ใช้ channel 6 เช่นกัน

---

### 4. ESPAsyncWebServer: Real-time data ไม่บล็อก

**ESPAsyncWebServer** คือ async HTTP + WebSocket server ที่ handle หลาย connection พร้อมกันโดยไม่บล็อก main loop — เหมาะสำหรับ dashboard ที่ต้องการ real-time sensor data

**ติดตั้ง**: `ESPAsyncWebServer` (by ESP32Async) + `AsyncTCP` (by ESP32Async) ผ่าน Arduino Library Manager

**Server-Sent Events (SSE)** สำหรับ push data ไปหา browser:

```cpp
#include <ESPAsyncWebServer.h>
AsyncWebServer server(80);
AsyncEventSource events("/events");

void setup() {
  server.addHandler(&events);
  
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *req) {
    req->send(200, "text/html", htmlPage);
  });
  server.begin();
}

void loop() {
  // Push sensor data ทุก 2 วินาที — ไม่บล็อก
  static unsigned long last = 0;
  if (millis() - last > 2000) {
    events.send(String(analogRead(34)).c_str(), "sensor", millis());
    last = millis();
  }
}
```

**SSE vs WebSocket**: SSE = unidirectional (server → client), ง่ายกว่า เหมาะกับ sensor dashboard; WebSocket = bidirectional เหมาะกับ interactive control

---

### 5. Deep Sleep + ULP Co-processor

ESP32 มี sleep modes หลายระดับ — เลือกตาม trade-off ระหว่างพลังงานกับ wakeup latency:

| Mode | Current | Wake-up time | อะไรทำงานอยู่ |
|---|---|---|---|
| Active | 160–240 mA | — | ทุกอย่าง |
| Modem sleep | 3–20 mA | instant | CPU, peripherals; radio off |
| Light sleep | 0.8 mA | ~1 ms | RTC, ULP; CPU suspended |
| Deep sleep | 10–150 µA | ~1–2 s | RTC + ULP เท่านั้น |
| Hibernation | ~5 µA | ~1–2 s | RTC timer เท่านั้น |

```cpp
// Deep sleep 30 วินาที แล้ว wake up
#include "esp_sleep.h"
#include "esp_timer.h"

void goToSleep() {
  esp_sleep_enable_timer_wakeup(30 * 1000000ULL); // microseconds
  esp_deep_sleep_start();
}
```

**ULP Co-processor** เป็น microcontroller เล็กๆ ใน chip ที่รันขณะ main CPU หลับ — กินไฟแค่ ~150 µA แต่อ่านค่า ADC, monitor GPIO, และ wake main CPU ได้เมื่อถึงเงื่อนไข:

```cpp
// ULP wakes main CPU เมื่อ temperature เกิน threshold
// (เขียนใน ULP assembly หรือ C via ulp_riscv สำหรับ ESP32-S3)
ulp_set_wakeup_period(0, 5 * 1000000); // ทุก 5 วินาที
```

**ตัวอย่างประสิทธิภาพ**: temperature monitor บน 18650 2 ก้อน (6,000 mAh) อ่านค่าทุกชั่วโมง → อายุแบตประมาณ **12 ปี**

---

### 6. DAC: Analog Output แท้

ESP32 มี **2x 8-bit DAC** (GPIO 25 และ GPIO 26) สำหรับสร้าง analog voltage จริง — ต่างจาก PWM ที่จำลองเท่านั้น

```cpp
#include <driver/dac.h>

void setup() {
  dac_output_enable(DAC_CHANNEL_1); // GPIO 25
}

void loop() {
  // สร้าง sine wave
  for (int i = 0; i < 360; i++) {
    uint8_t value = (uint8_t)(127.5 + 127.5 * sin(i * PI / 180.0));
    dac_output_voltage(DAC_CHANNEL_1, value); // 0-255 → 0-3.3V
    delayMicroseconds(100);
  }
}
```

**Use cases**: tone generation, analog reference signal, waveform output — แต่ resolution 8-bit (256 steps) ถ้าต้องการ precision สูงกว่านี้ต้องใช้ external DAC ผ่าน SPI/I2C

**หมายเหตุ**: ESP32-S2 และ ESP32-S3 ไม่มี DAC hardware; ESP32-C3 ก็ไม่มี — ฟีเจอร์นี้มีเฉพาะ ESP32 (original) และ ESP32-S3 บางตัว

---

### 7. OTA Update: อัพเดท Firmware จากระยะไกล

ESP32 รองรับ **dual-partition OTA** — เก็บ firmware 2 ชุดใน flash: OTA_0 และ OTA_1 สลับกันใช้ ถ้า update ล้มเหลวจะ rollback กลับ partition เดิมอัตโนมัติ

**ArduinoOTA** (ง่าย, ผ่าน LAN):
```cpp
#include <ArduinoOTA.h>

void setup() {
  WiFi.begin(SSID, PASSWORD);
  ArduinoOTA.setPassword("secret123"); // password ป้องกัน
  ArduinoOTA.onStart([]() { Serial.println("OTA Start"); });
  ArduinoOTA.begin();
}

void loop() {
  ArduinoOTA.handle(); // ต้องเรียกทุก loop
}
```

**ElegantOTA** (ผ่าน Web browser, ง่ายกว่า):
- เปิด browser → `http://<esp32-ip>/update`
- อัพโหลดไฟล์ `.bin` — อัพเดทเสร็จ reboot อัตโนมัติ

**Secure OTA**: ป้องกัน rollback attack ด้วย `CONFIG_BOOTLOADER_APP_ANTI_ROLLBACK` + sign firmware ด้วย private key ก่อน upload — ตรวจสอบ signature ก่อน flash

---

### 8. TLS / Certificate: Security ที่แท้จริง

ESP-IDF ใช้ **mbedTLS** (TLS 1.2 + TLS 1.3 + DTLS 1.2) สำหรับ HTTPS connections ทั้งหมด — hardware AES accelerator ช่วยให้เข้ารหัสเร็วโดยไม่กิน CPU มาก

```cpp
#include <WiFiClientSecure.h>

WiFiClientSecure client;

// Option 1: verify server certificate
const char* rootCA = "-----BEGIN CERTIFICATE-----\n...";
client.setCACert(rootCA);

// Option 2: ข้ามการ verify (dev only — อย่าใช้ใน production!)
// client.setInsecure();

void fetchSecure() {
  client.connect("api.example.com", 443);
  client.print("GET /data HTTP/1.1\r\nHost: api.example.com\r\n\r\n");
}
```

**Global CA store**: ถ้ามีหลาย HTTPS connections ให้ init CA store ครั้งเดียวแล้วใช้ร่วมกัน (ประหยัด RAM)

**Mutual TLS (mTLS)**: ใช้ `setCertificate()` + `setPrivateKey()` บน client เพื่อ authenticate ทั้ง 2 ฝั่ง — เหมาะสำหรับ device-to-backend API ที่ต้องการ zero-trust security

---

### 9. DMA: รับส่งข้อมูลความเร็วสูง

**DMA (Direct Memory Access)** ให้ peripheral (SPI, I2S, ADC, UART) รับส่งข้อมูลกับ RAM โดยตรงโดยไม่ผ่าน CPU — CPU ว่างทำงานอื่นได้ระหว่าง transfer

**Use cases หลัก:**
- **I2S + DMA**: stream audio data (microphone, speaker) ต่อเนื่องโดยไม่ interrupt CPU
- **SPI + DMA**: ส่งข้อมูลหน้าจอ TFT (SPI DMA transfer) ได้เร็วขึ้น 5-10x
- **ADC + DMA**: เก็บ ADC samples ความเร็วสูงลง buffer โดยไม่ miss sample

```cpp
// SPI DMA สำหรับ TFT display
spi_device_interface_config_t devcfg = {
  .clock_speed_hz = 80 * 1000 * 1000, // 80 MHz
  .mode = 0,
  .spics_io_num = PIN_CS,
  .queue_size = 7,
  .flags = SPI_DEVICE_HALFDUPLEX
};

// DMA channel กำหนดตอน init SPI bus
spi_bus_config_t buscfg = {
  .miso_io_num = PIN_MISO,
  .mosi_io_num = PIN_MOSI,
  .sclk_io_num = PIN_CLK,
  .max_transfer_sz = 4094 // max DMA transfer
};
spi_bus_initialize(VSPI_HOST, &buscfg, SPI_DMA_CH_AUTO);
```

## Caveats / Limits

- **FreeRTOS**: task priority ที่สูงเกินไปจะ starve tasks อื่น; ต้องระวัง stack overflow (ใช้ `uxTaskGetStackHighWaterMark()` ตรวจสอบ)
- **ESP-NOW**: payload จำกัด 250 bytes; ไม่มี built-in encryption (ต้องเข้ารหัสเองก่อนส่ง); coexistence กับ WiFi ต้องใช้ channel เดียวกัน
- **Deep Sleep**: GPIO state ไม่ถูก preserve ข้าม sleep cycles โดย default; ต้องใช้ RTC GPIO ถ้าต้องการ; wakeup ใช้เวลา ~1-2 วินาที
- **DAC**: มีเฉพาะ ESP32 classic เท่านั้น (GPIO 25, 26); resolution 8-bit (0.013V/step) อาจไม่พอสำหรับ precision application
- **OTA**: ต้องมี partition table แบบ OTA-enabled; ถ้า filesystem เต็มจะ update ไม่ได้; ควร validate firmware checksum ก่อน flash เสมอ
- **TLS**: handshake ใช้ RAM ~20-40 KB ต่อ connection; ESP32 มี RAM จำกัด (~320 KB SRAM) ระวัง memory exhaustion ถ้า handle หลาย HTTPS concurrent
- **DMA**: max single transfer size = 4094 bytes (ESP32); transfers ขนาดใหญ่ต้องแบ่งเป็น chunks

## References

1. [ESP32 Dual Core with Arduino IDE — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-dual-core-arduino-ide/)
2. [ESP32 with FreeRTOS: Create Tasks — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-freertos-arduino-tasks/)
3. [ESP-NOW Wireless Communication — Espressif Systems](https://www.espressif.com/en/solutions/low-power-solutions/esp-now)
4. [RF Coexistence — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-guides/coexist.html)
5. [ESPAsyncWebServer — GitHub (ESP32Async)](https://github.com/ESP32Async/ESPAsyncWebServer)
6. [ESP32 Web Server with Server-Sent Events — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-web-server-sent-events-sse/)
7. [ESP32 Sleep Modes & Power Consumption — Last Minute Engineers](https://lastminuteengineers.com/esp32-sleep-modes-power-consumption/)
8. [ESP32 Deep Sleep Wakeup Sources — Last Minute Engineers](https://lastminuteengineers.com/esp32-deep-sleep-wakeup-sources/)
9. [Over The Air Updates (OTA) — ESP-IDF Docs](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/system/ota.html)
10. [ESP32 OTA with ElegantOTA — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-ota-elegantota-arduino/)
11. [ESP-TLS — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/protocols/esp_tls.html)
12. [Mbed TLS — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/protocols/mbedtls.html)
13. [ESP-NOW Tutorial for Long-Range Communication — ThinkRobotics](https://thinkrobotics.com/blogs/learn/esp-now-tutorial-for-long-range-communication-building-robust-wireless-networks-in-2025)
14. [วิดีโอต้นฉบับ: ESP32 Pro IoT Features — YouTube](https://youtu.be/_HzG5FjH_6g)

## Key Takeaways

- **Dual-core + FreeRTOS**: แยก network stack ไว้ Core 0, sensor + UI ไว้ Core 1 — ไม่มี blocking อีกต่อไป; ใช้ Queue/Semaphore ป้องกัน race condition
- **ESP-NOW**: สื่อสาร P2P ได้ถึง 400m โดยไม่ต้องมี router หรือ broker — เหมาะกับ local mesh ที่ต้องการ low latency
- **Deep Sleep + ULP**: กิน current < 10 µA; ULP อ่าน sensor ขณะ main CPU หลับ — แบตก้อนเดียวยืดได้เป็นปี
- **ESPAsyncWebServer**: handle หลาย connection พร้อมกันโดยไม่ block; SSE สำหรับ real-time dashboard
- **OTA dual-partition**: update firmware จากระยะไกล มี rollback อัตโนมัติถ้า update ล้มเหลว
- **TLS + mbedTLS**: hardware AES accelerator ทำให้ HTTPS ไม่กิน CPU มาก; ใช้ certificate verification เสมอใน production
- **DMA**: ให้ peripheral คุยกับ RAM โดยตรง — CPU ว่างทำงานอื่นได้ระหว่าง I/O transfer; เพิ่มความเร็ว SPI display 5-10x
- **DAC**: 2x 8-bit analog output แท้ (GPIO 25, 26) เฉพาะ ESP32 classic — ใช้สำหรับ audio tone, waveform, analog reference signal
