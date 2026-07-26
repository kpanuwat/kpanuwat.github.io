---
title: "ESP32 ซ่อน 10 ฟีเจอร์ลับ: เพิ่มประสิทธิภาพโปรเจกต์แบบมือโปร"
date: 2026-07-25 00:01:00 +0700
categories: [Engineering]
tags: [esp32, embedded, iot, arduino, low-power, hardware]
slides: true
---

{% include slide-link.html %}

## TL;DR

ESP32 มี peripheral ซ่อนอยู่มากกว่าที่ส่วนใหญ่ใช้ (Wi-Fi/BLE/GPIO ธรรมดา) — ตั้งแต่ ULP co-processor ที่เฝ้า sensor ตอน deep sleep, GPIO Matrix ที่ remap ขาสัญญาณด้วยซอฟต์แวร์, ไปจนถึงการทดลองส่งคลื่นวิทยุ AM ระยะสั้นด้วย I2S/DAC เดี่ยวๆ 10 ฟีเจอร์นี้ช่วยประหยัดแบต ลดปัญหา PCB routing ตัดปุ่มกด และทำให้จอ/เสียงลื่นขึ้นโดยไม่ต้องเพิ่มฮาร์ดแวร์ภายนอก

## Background / Why this matters

นักพัฒนา IoT ส่วนใหญ่ใช้ ESP32 แค่ระดับผิว: ต่อ sensor, เปิด Wi-Fi, ส่งค่าขึ้น cloud จบ แต่ตัวชิปเองมี peripheral ระดับฮาร์ดแวร์ที่ Espressif ใส่มาให้ตั้งแต่แรก เช่น co-processor แยกสำหรับงานพลังงานต่ำ, matrix สำหรับ route สัญญาณกายภาพ, และ DMA controller ที่ทำงานได้โดยไม่พึ่ง CPU หลัก ฟีเจอร์เหล่านี้ไม่ได้ "ซ่อน" ในแง่ที่เป็นความลับ — แต่ส่วนใหญ่ไม่ถูกพูดถึงในทิวทอเรียลเริ่มต้น เพราะต้องเข้าใจสถาปัตยกรรมชิปลึกกว่าปกติ

บทความนี้เจาะลึก 10 ฟีเจอร์จากคลิป [10 Hidden ESP32 Features Most Makers Don't Know About](https://youtu.be/Hya6Zc1cTr4) พร้อม cross-check กับเอกสารทางการของ Espressif (ESP-IDF Programming Guide) เพื่อความถูกต้องระดับ production ไม่ใช่แค่ demo

## Deep Dive

### 1. ULP Co-processor — เฝ้า sensor ระหว่าง Deep Sleep

ปัญหาคลาสสิกของโปรเจกต์ใช้แบตเตอรี่: ถ้าปล่อย ESP32 ตื่นตลอดเวลา แบตหมดเร็ว แต่ deep sleep ทำให้โค้ดหลักหยุดทำงานทั้งหมด **ULP (Ultra Low Power) co-processor** คือ core เล็กๆ แยกต่างหากที่อยู่ใน RTC power domain — มันรันโปรแกรมที่เก็บใน RTC slow memory ได้เองโดยไม่ต้องปลุก CPU หลัก คอยตรวจ ADC/GPIO และปลุกชิปเมื่อค่าถึงเกณฑ์ที่ตั้งไว้ [1][2]

เหมาะกับ: เครื่องวัดความชื้นดิน, sensor ประตู/หน้าต่าง, weather station ที่รันเดือนนึงด้วยแบตก้อนเดียว

```cpp
// ESP-IDF: ULP wakes main CPU when soil sensor crosses threshold
// (ulp program compiled separately, loaded via ulp_load_binary())
esp_sleep_enable_ulp_wakeup();
esp_deep_sleep_start();
```

### 2. GPIO Matrix — ย้ายพินด้วยซอฟต์แวร์

พินบนบอร์ดจำนวนมากถูก "fix" ตายตัวในชิปทั่วไป แต่ ESP32 มี **GPIO Matrix** ทำหน้าที่เหมือน software wire router ภายในชิป — route สัญญาณอย่าง SDA, SCL, UART TX/RX หรือ PWM ไปยังขาไหนก็ได้ (เกือบทั้งหมด) ผ่านโค้ด ไม่ต้องแก้ฮาร์ดแวร์ [1][3][4]

ประโยชน์จริง: แก้ปัญหา PCB routing ที่สายไขว้กัน โดยไม่ต้อง respin บอร์ด แต่ต้องเช็คก่อนว่าพินเป้าหมายรองรับ signal ประเภทนั้นจริง — บางพินผูกกับ flash memory ภายใน ถ้า route peripheral ไปโดนพินเหล่านี้ชิปจะบูตไม่ขึ้น [4]

```cpp
// Arduino: remap I2C to non-default pins via GPIO Matrix
Wire.begin(/*SDA=*/33, /*SCL=*/32);
```

### 3. Built-in Touch Pins — ปุ่มสัมผัสไม่ต้องมีปุ่มจริง

หลายบอร์ด ESP32 มี **capacitive touch pins** ในตัว ทำงานโดยชาร์จ/คายประจุ touch channel แล้ววัดคาบของ sawtooth wave ที่เปลี่ยนไปเมื่อมีนิ้วเข้าใกล้ [1][5] แปะลวดหรือแผ่นทองแดงไว้หลังพลาสติก/อะคริลิก ก็กลายเป็นปุ่มสัมผัสซ่อนได้โดยไม่ต้องเจาะรูเคส

ข้อควรระวัง: ค่าที่อ่านได้ขึ้นกับความยาวลวด ความชื้น และวัสดุเคส — ต้องวัดค่า baseline (ไม่แตะ) กับค่าตอนแตะจริง แล้วตั้ง threshold อยู่ตรงกลาง ไม่ใช้ค่าตายตัวจาก tutorial อื่น [1]

```cpp
touchAttachInterrupt(T0, onTouch, threshold); // threshold = calibrated midpoint
```

### 4. DMA — ลดภาระ CPU สำหรับจอและเสียง

จอ TFT, LED matrix หรือ audio stream ต้องการข้อมูลต่อเนื่องปริมาณมาก ถ้าให้ CPU push ทีละ byte เอง โปรแกรมจะหน่วง (ปุ่มตอบช้า, sensor ค้าง) **DMA (Direct Memory Access)** ให้ฮาร์ดแวร์ย้ายข้อมูลเองผ่าน SPI (จอ) หรือ I2S (เสียง) โดย CPU ไม่ต้องยุ่ง — เมื่อ DMA buffer เต็มหนึ่งก้อนจะยิง interrupt `I2S_OUT_EOF`/`I2S_IN_SUC_EOF` แทน [1][6]

Tip จากฟอรัม Espressif: ถ้าอยาก ลด CPU load เพิ่มเติม ให้เพิ่ม **ขนาด** DMA buffer แทนที่จะเพิ่ม **จำนวน** buffer — เพราะทุก buffer ต้อง handle interrupt เอง [6]

### 5. Wi-Fi Promiscuous Mode — วิเคราะห์สัญญาณรอบตัว

ปกติ ESP32 ฟังเฉพาะการเชื่อมต่อ Wi-Fi ของตัวเอง แต่เปิด **promiscuous mode** ด้วย `esp_wifi_set_promiscuous()` แล้ว มันจะรับทุก 802.11 data/management frame ที่ผ่าน channel ปัจจุบัน — ใช้ `esp_wifi_set_promiscuous_filter()` กรองประเภท frame ได้ [7]

สำคัญ: มันอ่านรหัสผ่านหรือข้อความส่วนตัวไม่ได้ (การเข้ารหัสยังทำงานปกติ) แต่ใช้ทำ Wi-Fi analyzer, channel monitor, หรือ signal-strength heatmap ได้ดีมาก [1][7] callback ที่ตั้งไว้รันอยู่ใน Wi-Fi driver task โดยตรง — ถ้างานหนักให้ post event ไปทำต่อใน task อื่น อย่าประมวลผลหนักใน callback [7]

### 6. Internal Hall Sensor — วัดสนามแม่เหล็กแบบไม่ต้องมีชิ้นส่วนเพิ่ม

ESP32 รุ่นดั้งเดิม (original, non-S) มี Hall sensor ในตัวที่ตอบสนองต่อสนามแม่เหล็ก [1][8] แต่ Espressif ได้ **ถอด Hall sensor ออกจากเอกสารทางการอย่างเป็นทางการตั้งแต่ปลายปี 2022** (PCN20221202) และไม่รองรับใน ESP32-S2/S3/C3/H2 เลย เพราะความแม่นยำต่ำ [9][10]

ใช้เป็น "zero-component trick" ได้ เช่น ติดแม่เหล็กเล็กๆ ที่ฝากล่องโปรเจกต์ ตรวจจับตอนเปิด/ปิดฝาผ่านการเปลี่ยนสนามแม่เหล็ก — ต้อง average + filter ค่าเพราะสัญญาณ noisy มาก และห้ามใช้แทน magnetic sensor คุณภาพจริง [1][8]

### 7. RTC Memory — เก็บตัวแปรข้ามรอบ Deep Sleep

ปกติตัวแปรทั้งหมดถูกล้างทุกครั้งที่ ESP32 ตื่นจาก reset แต่ **RTC memory** (8kB RTC fast memory) ไม่ถูกลบเมื่อตื่นจาก deep sleep — ลบเฉพาะตอนกดปุ่ม EN/reset จริงๆ [1][11][12] ใน Arduino แค่เติม `RTC_DATA_ATTR` หน้าตัวแปร ก็เก็บ boot count, state, หรือค่า sensor ล่าสุดข้ามรอบ sleep ได้

```cpp
RTC_DATA_ATTR int bootCount = 0;   // survives deep sleep, resets on EN/reset
```

ESP-IDF ยังมี attribute เฉพาะทางเพิ่มเติม: `RTC_FAST_ATTR`, `RTC_SLOW_ATTR` (บังคับ memory region) และ `RTC_RODATA_ATTR` (read-only) [12]

### 8. Internal Temperature Sensor — วัดความร้อนภายในชิป (ไม่ใช่ห้อง)

ต้องแยกสองกรณีให้ชัด เพราะเป็นจุดที่คนเข้าใจผิดบ่อย:

- **ESP32 ดั้งเดิม (original)**: มี sensor วัดอุณหภูมิภายในจริง แต่เข้าถึงผ่านฟังก์ชัน **ไม่มีเอกสารทางการ** ชื่อ `temprature_sens_read()` (สะกดผิดโดยตั้งใจใน SDK) ที่ไม่อยู่ใน datasheet หรือ header ไฟล์ใดๆ — ต้อง declare เองในโค้ด ค่าที่ได้มี offset สุ่มต่างกันในแต่ละชิป เชื่อถือได้แค่ระดับ "เปลี่ยนแปลงสัมพัทธ์" ไม่ใช่ค่าจริง [13][14]
- **ESP32-S2/S3/C3 รุ่นใหม่กว่า**: มี **official temperature sensor driver** ผ่าน `temperature_sensor_install()` / `temperature_sensor_get_celsius()` ในไฟล์ header `driver/temperature_sensor.h` [14]

ใช้ประโยชน์เพื่อ diagnostic เช่น ตรวจจับความร้อนพุ่งจาก Wi-Fi โหลดหนัก หรือ voltage regulator ร้อนผิดปกติในกล่องปิด — ไม่ใช่ตัวแทน environment sensor [1]

### 9. AM Wave Transmission — ทดลองส่งคลื่นวิทยุระยะสั้น

ESP32 (silicon revision ที่รองรับ APLL) สามารถส่ง square wave carrier ออก GPIO ได้โดยตรงผ่าน I2S peripheral ด้วย sigma-delta encoding — ต่อสายสั้นๆ เป็นเสาอากาศ วิทยุ AM/LW/MW เก่าที่จูนความถี่ carrier (เช่น harmonic ที่ 3 ในย่าน MW) จะรับสัญญาณเสียงที่ modulate เข้าไปได้ [1][15][16]

กำลังส่งต่ำมาก (ระดับ microwatt) ระยะไม่กี่เมตร — เหมาะเป็นการทดลองในห้องเรียนเพื่อสอนทฤษฎีวิทยุเท่านั้น **ห้าม** ต่อเสาอากาศยาวหรือส่งระยะไกลเพราะจะรบกวนคลื่นความถี่ที่มีการควบคุมตามกฎหมาย [1][15]

### 10. Dynamic CPU Frequency Scaling — ปรับสมดุลพลังงานอัตโนมัติ

เปิดผ่าน `esp_pm_configure()` พร้อม `esp_pm_config_t` — ระบบจะลดความถี่ CPU ตอนไม่มีงานหนัก (idle, รอปุ่มกด) แล้วเร่งกลับไปสูงสุดเมื่อมีงานประมวลผลจริง [1][17]

Trade-off ที่ต้องรู้: การเปิด power management เพิ่ม interrupt latency ขั้นต่ำ 0.2 µs (240MHz คงที่) ไปจนถึงสูงสุด 40 µs (ตอนสลับจาก 40MHz → 80MHz ระหว่าง interrupt) — งานที่ต้องการ real-time latency สูงควร benchmark ก่อนเปิดใช้จริง [17]

```cpp
esp_pm_config_t pm_config = {
  .max_freq_mhz = 240,
  .min_freq_mhz = 40,
  .light_sleep_enable = true
};
esp_pm_configure(&pm_config);
```

## User Guide (Step-by-Step)

1. **เลือกฟีเจอร์ตามปัญหาจริง** — อย่าเปิดทุกอย่างพร้อมกัน เริ่มจาก pain point เดียว เช่น แบตหมดเร็ว → ลอง ULP + deep sleep + RTC memory ก่อน
2. **ตรวจรุ่นชิปก่อนเสมอ** — Hall sensor และ temp sensor แบบ undocumented มีเฉพาะ ESP32 ดั้งเดิม; GPIO Matrix ต้องเช็ค pinout เฉพาะบอร์ด/รุ่น
3. **Deep sleep + ULP workflow**: เขียน ULP program แยก (assembly หรือ ulp-riscv), compile, `ulp_load_binary()`, ตั้ง `esp_sleep_enable_ulp_wakeup()`, แล้ว `esp_deep_sleep_start()` — ตรวจสอบด้วย serial monitor ว่า wake reason ตรงกับที่ ULP ปลุกจริง
4. **Touch pin calibration**: อ่านค่า `touchRead(pin)` ตอนไม่แตะ 10 ครั้ง หาค่าเฉลี่ย (baseline) แล้วแตะจริง 10 ครั้ง หาค่าเฉลี่ยอีกที ตั้ง threshold ตรงกลางสองค่านั้น
5. **DMA verification**: เปิด I2S/SPI ด้วย DMA buffer count/size ตาม default ก่อน แล้ววัด CPU usage จริงด้วย `esp_timer_get_time()` รอบ loop — ถ้ายังหน่วง ค่อยขยาย buffer size ไม่ใช่จำนวน buffer
6. **Troubleshooting ที่พบบ่อย**: ถ้า GPIO Matrix remap แล้วชิปไม่บูต → เช็คว่าพินนั้นผูกกับ flash/PSRAM หรือไม่ (ดู pinout diagram ทางการ); ถ้า promiscuous mode ไม่รับ packet → เช็คว่าตั้ง Wi-Fi mode เป็น `WIFI_MODE_NULL`/`STA`/`AP`/`APSTA` ก่อนเปิด callback

## Caveats / Limits

- **Hall sensor**: ถอดออกจากเอกสารทางการแล้ว (2022-12-27) ใช้ได้เฉพาะ ESP32 ดั้งเดิม ไม่มีใน S2/S3/C3/H2 — noisy, ไม่ calibrate, ห้ามพึ่งพาความแม่นยำ [9][10]
- **Internal temp sensor บน ESP32 ดั้งเดิม**: ไม่มีเอกสารทางการรองรับ ค่า offset ต่างกันในแต่ละชิป วัดได้แค่ delta ไม่ใช่ค่าจริง [13][14]
- **AM wave transmission**: กำลังส่งต่ำ ระยะสั้นมาก ใช้เพื่อการศึกษาเท่านั้น การต่อเสาอากาศยาวหรือส่งระยะไกลอาจผิดกฎหมายคลื่นความถี่ในหลายประเทศ [15]
- **GPIO Matrix**: ไม่ใช่ทุกพินรองรับทุก signal — พินที่ผูกกับ flash/PSRAM ภายในห้าม route peripheral อื่นทับ ไม่งั้นชิปบูตไม่ขึ้น [4]
- **Power management (DFS)**: เพิ่ม interrupt latency (0.2–40 µs) — งาน real-time-sensitive ต้องทดสอบก่อนใช้จริง [17]
- **DMA**: ลด CPU load แต่ต้องจัดสรร RAM สำหรับ DMA buffer เพิ่ม — บอร์ดที่มี RAM จำกัดต้อง balance ระหว่าง buffer size กับ heap ที่เหลือ

## References

1. [10 Hidden ESP32 Features Most Makers Don't Know About (YouTube)](https://youtu.be/Hya6Zc1cTr4)
2. [Ultra Low Power (ULP) coprocessor — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/system/ulp.html)
3. [GPIO & RTC GPIO — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/peripherals/gpio.html)
4. [Where can I find GPIO Matrix and how do I modify it to remap pins? — esp-idf issue #3590](https://github.com/espressif/esp-idf/issues/3590)
5. [Capacitive Touch Sensor — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/peripherals/cap_touch_sens.html)
6. [Inter-IC Sound (I2S) — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/peripherals/i2s.html)
7. [Wi-Fi API Reference (esp_wifi_set_promiscuous) — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/network/esp_wifi.html)
8. [ESP32 Built-In Hall Effect Sensor — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-hall-effect-sensor/)
9. [Peripherals migration guide (Hall sensor removal) — ESP-IDF v5.0](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/migration-guides/release-5.x/5.0/peripherals.html)
10. [ESP32 hallRead(): How to Use the Deprecated Hall Sensor Function](https://coolplaydev.com/deprecated-esp32-hallread-function)
11. [ESP32 Deep Sleep with Arduino IDE and Wake Up Sources — Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-deep-sleep-arduino-ide-wake-up-sources/)
12. [Deep-sleep Wake Stubs — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-guides/deep-sleep-stub.html)
13. [API to read the internal temperature sensor? — arduino-esp32 issue #98](https://github.com/espressif/arduino-esp32/issues/98)
14. [Temperature Sensor — ESP-IDF Programming Guide (ESP32-S2)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s2/api-reference/peripherals/temp_sensor.html)
15. [ESP32 Makes For World's Worst Radio Station — Hackaday](https://hackaday.com/2018/01/28/esp32-makes-for-worlds-worst-radio-station/)
16. [MW-AM radio transmitter with an ESP32 as web-radio — Hackster.io](https://www.hackster.io/philippedc/mw-am-radio-transmitter-with-an-esp32-as-web-radio-fc6394)
17. [Power Management — ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/system/power_management.html)

## Key Takeaways

- ULP co-processor เฝ้า sensor ระหว่าง deep sleep ได้โดยไม่ปลุก CPU หลัก — สำคัญมากสำหรับโปรเจกต์ใช้แบต
- GPIO Matrix แก้ปัญหา PCB routing ด้วยซอฟต์แวร์ แต่ต้องเช็ค pinout ก่อนเสมอ (พินผูก flash ห้ามแตะ)
- Touch pin ต้อง calibrate ค่า baseline/touched เอง ไม่มีค่าตายตัวที่ใช้ได้ทุกบอร์ด
- DMA ทำให้จอ/เสียงลื่นขึ้นโดยลด CPU load — ปรับ buffer size ไม่ใช่จำนวน buffer เมื่อยังหน่วง
- Hall sensor ถูกถอดจากเอกสารทางการแล้ว (2022) ใช้ได้เฉพาะ ESP32 ดั้งเดิม และไม่ควรพึ่งพาความแม่นยำ
- Internal temp sensor บนชิปดั้งเดิมไม่มีเอกสารรองรับ — วัด delta ได้ ไม่ใช่ค่าจริง; S2/S3 มี official driver
- AM wave transmission เป็นการทดลองการศึกษาระยะสั้นเท่านั้น ไม่ใช่โซลูชันสื่อสารจริง
- Dynamic CPU frequency scaling ประหยัดพลังงานแต่แลกกับ interrupt latency ที่เพิ่มขึ้น
