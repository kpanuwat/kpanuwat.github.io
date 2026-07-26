---
marp: true
theme: default
paginate: true
title: "ESP32 ซ่อน 10 ฟีเจอร์ลับ"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#3b82f6; --accent-deep:#1e3a8a; --accent-wash:#dbeafe; --gold:#d4af37;
    --danger:#dc2626; --danger-wash:#fee2e2; --danger-ink:#991b1b;
    --success:#16a34a; --success-wash:#dcfce7; --success-ink:#14532d;
    --warning:#f59e0b; --warning-wash:#fef3c7; --warning-ink:#92400e;
    --shadow-sm:0 1px 2px rgba(15,23,42,.06);
    --shadow-md:0 4px 12px rgba(15,23,42,.08);
    --shadow-lg:0 12px 28px rgba(15,23,42,.12);
    --radius:12px; --radius-sm:8px;
  }
  section {
    display:flex; flex-direction:column; justify-content:space-between;
    padding:56px 64px 44px; font-family:system-ui,-apple-system,"Segoe UI",sans-serif;
    color:var(--ink); position:relative;
  }
  section::before {
    content:''; position:absolute; top:28px; left:64px;
    width:40px; height:3px; background:var(--accent); border-radius:2px;
  }
  section h2 { font-size:26px; margin:0 0 4px; color:var(--ink); font-weight:700; }
  .subhead { color:var(--ink-dim); font-size:14px; margin:0 0 8px; }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; min-height:0; }
  .takeaway {
    border-left:4px solid var(--accent); background:var(--soft);
    padding:12px 18px; border-radius:0 var(--radius-sm) var(--radius-sm) 0;
    font-size:13px; line-height:1.5;
  }
  .takeaway b { color:var(--accent); }
  .card {
    background:var(--paper); border-radius:var(--radius);
    box-shadow:var(--shadow-md); padding:16px 18px;
    border-left:4px solid var(--accent); box-sizing:border-box;
    display:flex; flex-direction:column; justify-content:center;
  }
  .card.success { border-left-color:var(--success); }
  .card.danger  { border-left-color:var(--danger); }
  .card.warning { border-left-color:var(--warning); }
  .card.gold    { border-left-color:var(--gold); }
  .card .label { font-size:10px; letter-spacing:.08em; text-transform:uppercase; color:var(--muted); margin:0 0 4px; }
  .card h3 { margin:0 0 6px; font-size:16px; color:var(--ink); font-weight:700; }
  .card p  { margin:0 0 4px; font-size:12.5px; color:var(--ink-dim); line-height:1.5; }
  .card code { font-size:11px; background:var(--soft); padding:2px 5px; border-radius:4px; color:var(--accent-deep); }
  .card ul { margin:0; padding-left:16px; font-size:12.5px; color:var(--ink-dim); line-height:1.7; }
  .card.compact { padding:10px 14px; }
  .card.compact h3 { font-size:14px; margin-bottom:4px; }
  .card.compact p, .card.compact .label { font-size:11px; }
  .bento { display:grid; gap:12px; width:100%; align-self:stretch; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/esp32-10-hidden-features-cover.png)

<div class="mark"></div>

# ESP32 ซ่อน 10 ฟีเจอร์ลับ

<p class="tag">Peripheral ระดับฮาร์ดแวร์ที่ Espressif ใส่มาให้ แต่ทิวทอเรียลเริ่มต้นไม่เคยพูดถึง</p>

<!-- Speaker: เปิดด้วยคำถาม — ใครเคยใช้ ESP32 แค่ Wi-Fi/BLE/GPIO ธรรมดา? วันนี้จะโชว์ 10 อย่างที่ชิปตัวนี้ทำได้มากกว่านั้น -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/esp32-10-hidden-features-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้ง 10 ฟีเจอร์ในหน้าเดียว ก่อนเจาะลึกทีละอย่าง -->

---

## TL;DR

<p class="subhead">10 peripheral ที่ซ่อนอยู่ใน ESP32 — ประหยัดแบต ลดปัญหา PCB routing ตัดปุ่มกด และทำให้จอ/เสียงลื่นขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="30" width="980" height="280" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="30" width="8" height="280" rx="4" fill="var(--accent)"/>
  <circle cx="150" cy="170" r="46" fill="var(--accent)" opacity=".12"/>
  <circle cx="150" cy="170" r="32" fill="var(--accent)"/>
  <text x="150" y="178" font-size="26" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="800">10</text>
  <text x="230" y="130" font-size="19" font-weight="700" fill="var(--ink)" font-family="system-ui">ESP32 hidden peripherals</text>
  <text x="230" y="160" font-size="14" fill="var(--ink-dim)" font-family="system-ui">ULP · GPIO Matrix · Touch · DMA · Wi-Fi promiscuous</text>
  <text x="230" y="184" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Hall sensor · RTC memory · Temp sensor · AM wave · DFS</text>
  <text x="230" y="220" font-size="13" fill="var(--muted)" font-family="system-ui">Zero extra hardware — all built into the chip you already have</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 10 ฟีเจอร์นี้ใช้ฮาร์ดแวร์ที่มีอยู่แล้วในชิป ไม่ต้องเพิ่มชิ้นส่วนภายนอกแม้แต่ตัวเดียว</div>

<!-- Speaker: ย้ำว่านี่ไม่ใช่ของแปลกใหม่ แต่เป็นของที่มีอยู่แล้วในชิปทุกตัว แค่ไม่มีใครสอน -->

---

## ทำไมเรื่องนี้ถึงสำคัญ

![bg right:40% contain](assets/esp32-10-hidden-features-why-this-matters.png)

<p class="subhead">นักพัฒนาส่วนใหญ่ใช้ ESP32 แค่ผิวเผิน — Wi-Fi, sensor, ส่งค่าขึ้น cloud จบ</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="620" height="70" rx="10" fill="var(--soft)"/>
  <text x="60" y="72" font-size="15" fill="var(--ink)" font-family="system-ui" font-weight="700">Surface-level usage</text>
  <text x="60" y="92" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Wi-Fi + BLE + sensor + cloud upload</text>
  <path d="M350 115 L350 155" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <defs><marker id="arrow" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
  <rect x="40" y="165" width="620" height="130" rx="10" fill="var(--accent)" opacity=".08"/>
  <text x="60" y="198" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">Hidden hardware peripherals</text>
  <text x="60" y="222" font-size="12" fill="var(--ink)" font-family="system-ui">ULP · GPIO Matrix · DMA · RTC memory</text>
  <text x="60" y="244" font-size="12" fill="var(--ink)" font-family="system-ui">ไม่ต้องใช้ hardware เพิ่ม แต่ต้องเข้าใจสถาปัตยกรรมชิป</text>
  <text x="60" y="270" font-size="12" fill="var(--ink-dim)" font-family="system-ui">→ แบตอยู่ได้นานขึ้น, PCB สะอาดขึ้น, จอ/เสียงลื่นขึ้น</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ฟีเจอร์เหล่านี้ไม่ใช่ความลับ — แค่ต้องเข้าใจสถาปัตยกรรมชิปลึกกว่าทิวทอเรียลเริ่มต้น</div>

<!-- Speaker: อธิบายว่า deep sleep ตัดโค้ดหลักทั้งหมด แต่ ULP ยังทำงานได้ - เป็นสะพานไปฟีเจอร์แรก -->

---

## ฟีเจอร์ 1-2: ประหยัดแบตและจัดการพิน

<p class="subhead">ULP co-processor เฝ้า sensor ตอนหลับ · GPIO Matrix ย้ายพินด้วยซอฟต์แวร์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Feature 1 · Power</p>
    <h3>ULP Co-processor</h3>
    <p>Core เล็กแยกต่างหากใน RTC domain — ตรวจ ADC/GPIO ระหว่าง deep sleep แล้วปลุก CPU หลักเมื่อค่าถึงเกณฑ์ เหมาะกับ sensor ใช้แบต</p>
    <code>esp_sleep_enable_ulp_wakeup()</code>
  </div>
  <div class="card gold">
    <p class="label">Feature 2 · Routing</p>
    <h3>GPIO Matrix</h3>
    <p>Software wire router ภายในชิป — remap SDA/SCL/UART/PWM ไปพินไหนก็ได้ผ่านโค้ด แก้ปัญหา PCB routing โดยไม่ respin บอร์ด</p>
    <code>Wire.begin(sda, scl)</code>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เช็ค pinout ก่อนเสมอ — พินที่ผูกกับ flash ภายในห้าม route peripheral อื่นทับ ไม่งั้นชิปบูตไม่ขึ้น</div>

<!-- Speaker: ULP เหมาะกับ battery project; GPIO matrix แก้ routing แต่มีข้อจำกัดเรื่อง flash pins -->

---

## ฟีเจอร์ 3-4: ปุ่มสัมผัสและ DMA

<p class="subhead">Touch pins แทนปุ่มกดจริง · DMA ลดภาระ CPU สำหรับจอและเสียง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Feature 3 · Input</p>
    <h3>Built-in Touch Pins</h3>
    <p>Capacitive touch ในตัวชิป วัดคาบ sawtooth wave ที่เปลี่ยนเมื่อนิ้วเข้าใกล้ — ต้อง calibrate baseline/touched เอง เพราะค่าเปลี่ยนตามวัสดุเคส</p>
    <code>touchAttachInterrupt(T0, cb, thr)</code>
  </div>
  <div class="card">
    <p class="label">Feature 4 · Throughput</p>
    <h3>DMA (Direct Memory Access)</h3>
    <p>ฮาร์ดแวร์ย้ายข้อมูลเองผ่าน SPI (จอ) หรือ I2S (เสียง) โดย CPU ไม่ต้องยุ่ง — ลดหน่วงบนจอ TFT/LED matrix และเสียงต่อเนื่อง</p>
    <code>I2S_OUT_EOF interrupt</code>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้าจอ/เสียงยังหน่วงหลังใช้ DMA แล้ว ให้เพิ่ม "ขนาด" buffer ไม่ใช่ "จำนวน" buffer</div>

<!-- Speaker: touch pin ต้องวัด baseline เอง ไม่มีค่าตายตัว; DMA tip จาก Espressif forum -->

---

## ฟีเจอร์ 5-6: วิเคราะห์สัญญาณและแม่เหล็ก

<p class="subhead">Wi-Fi promiscuous mode ดูสัญญาณรอบตัว · Hall sensor วัดสนามแม่เหล็ก (เฉพาะรุ่นดั้งเดิม)</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Feature 5 · RF</p>
    <h3>Wi-Fi Promiscuous Mode</h3>
    <p>รับทุก 802.11 data/management frame ในช่องสัญญาณปัจจุบัน — อ่านรหัสผ่าน/ข้อความส่วนตัวไม่ได้ แต่ทำ Wi-Fi analyzer หรือ signal map ได้ดี</p>
    <code>esp_wifi_set_promiscuous()</code>
  </div>
  <div class="card warning">
    <p class="label">Feature 6 · Legacy</p>
    <h3>Internal Hall Sensor</h3>
    <p>ESP32 ดั้งเดิมมี Hall sensor ในตัว — noisy และไม่ calibrate ใช้เป็น zero-component trick ตรวจฝากล่องเปิด/ปิดได้ แต่ Espressif ถอดจากเอกสารทางการแล้ว</p>
    <code>hallRead() — deprecated</code>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Hall sensor ใช้ได้เฉพาะ ESP32 ดั้งเดิม ไม่มีใน S2/S3/C3/H2 — ห้ามพึ่งพาความแม่นยำ</div>

<!-- Speaker: promiscuous mode ไม่ใช่การแฮก แค่ดู metadata; hall sensor เตือนเรื่อง deprecation -->

---

## ฟีเจอร์ 7-8: จำตัวแปรและวัดความร้อน

<p class="subhead">RTC memory เก็บตัวแปรข้ามรอบ sleep · Internal temp sensor วัดความร้อนชิป</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Feature 7 · Persistence</p>
    <h3>RTC Memory</h3>
    <p>RTC fast memory (8kB) ไม่ถูกลบเมื่อตื่นจาก deep sleep — ลบเฉพาะตอนกด EN/reset เติม attribute เดียวก็เก็บ boot count หรือ state ข้ามรอบ sleep ได้</p>
    <code>RTC_DATA_ATTR int bootCount;</code>
  </div>
  <div class="card warning">
    <p class="label">Feature 8 · Diagnostic</p>
    <h3>Internal Temperature Sensor</h3>
    <p>ชิปดั้งเดิม: ฟังก์ชันไม่มีเอกสารทางการ ค่า offset ต่างกันทุกชิป วัด delta ได้ไม่ใช่ค่าจริง ส่วน S2/S3/C3 มี official driver ให้ใช้แทน</p>
    <code>temperature_sensor_get_celsius()</code>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTC_DATA_ATTR ทำให้โปรเจกต์แบตนานขึ้นแบบไม่ต้องเขียน flash ทุกรอบ — ป้องกัน flash wear ด้วย</div>

<!-- Speaker: RTC memory แยกจาก flash ชัดเจน; temp sensor ต้องระวังเรื่อง documented vs undocumented -->

---

## ฟีเจอร์ 9-10: ทดลองวิทยุและจัดการพลังงาน

<p class="subhead">AM wave transmission ทดลองระยะสั้น · Dynamic CPU frequency scaling ปรับสมดุลพลังงาน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Feature 9 · Experiment</p>
    <h3>AM Wave Transmission</h3>
    <p>ส่ง square wave carrier ผ่าน I2S ออก GPIO ตรง — วิทยุ AM/MW เก่ารับสัญญาณได้ในระยะไม่กี่เมตร ใช้เพื่อการศึกษาเท่านั้น ห้ามต่อเสาอากาศยาว</p>
    <code>APLL sigma-delta carrier</code>
  </div>
  <div class="card">
    <p class="label">Feature 10 · Power</p>
    <h3>Dynamic CPU Frequency Scaling</h3>
    <p>ลดความถี่ CPU ตอน idle แล้วเร่งกลับสูงสุดเมื่อมีงานหนัก — แลกกับ interrupt latency เพิ่มขึ้น 0.2-40 µs ต้อง benchmark งาน real-time ก่อนเปิดใช้</p>
    <code>esp_pm_configure(&config)</code>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AM wave = การทดลองสอนทฤษฎีในห้องเรียน ไม่ใช่โซลูชันสื่อสารจริง — กำลังส่งระดับ microwatt เท่านั้น</div>

<!-- Speaker: เน้นข้อจำกัดทางกฎหมายของ AM wave; DFS trade-off กับ latency -->

---

## เริ่มใช้งานจริง: 4 ขั้นตอน

<p class="subhead">จากปัญหาจริงสู่การเลือกฟีเจอร์ที่ใช่ ไม่ต้องเปิดทุกอย่างพร้อมกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Step 1</p>
    <h3>ระบุ pain point</h3>
    <p>แบตหมดเร็ว? PCB routing ยุ่ง? เลือกฟีเจอร์ตามปัญหาจริง ไม่เปิดทุกอย่างพร้อมกัน</p>
  </div>
  <div class="card compact">
    <p class="label">Step 2</p>
    <h3>เช็ครุ่นชิป</h3>
    <p>Hall sensor และ temp sensor แบบ undocumented มีเฉพาะ ESP32 ดั้งเดิมเท่านั้น</p>
  </div>
  <div class="card compact">
    <p class="label">Step 3</p>
    <h3>Calibrate ค่าเอง</h3>
    <p>Touch pin วัด baseline/touched เอง — ไม่มีค่าตายตัวที่ใช้ได้ทุกบอร์ด</p>
  </div>
  <div class="card compact">
    <p class="label">Step 4</p>
    <h3>วัดผลจริง</h3>
    <p>ใช้ esp_timer_get_time() วัด CPU usage ก่อน/หลัง แทนการเดาว่าดีขึ้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า GPIO Matrix remap แล้วบูตไม่ขึ้น เช็คว่าพินนั้นผูกกับ flash/PSRAM หรือไม่ก่อนอื่นใด</div>

<!-- Speaker: ย้ำ workflow ทดลอง — ไม่ใช่ copy-paste โค้ดจากคลิปตรงๆ ต้อง calibrate ตามบอร์ดจริง -->

---

## ข้อควรระวังที่สำคัญที่สุด

<p class="subhead">3 จุดที่พลาดบ่อยที่สุดเวลาเอาฟีเจอร์เหล่านี้ไปใช้จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Deprecated</p>
    <h3>Hall Sensor</h3>
    <p>Espressif ถอดออกจากเอกสารทางการตั้งแต่ปลายปี 2022 — ไม่มีใน ESP32-S2/S3/C3/H2 เลย</p>
  </div>
  <div class="card danger">
    <p class="label">Legal Limit</p>
    <h3>AM Wave Transmission</h3>
    <p>เสาอากาศยาวหรือส่งระยะไกลอาจผิดกฎหมายคลื่นความถี่ที่มีการควบคุม — ใช้เพื่อการศึกษาเท่านั้น</p>
  </div>
  <div class="card warning">
    <p class="label">Boot Risk</p>
    <h3>GPIO Matrix + Flash Pins</h3>
    <p>Route peripheral ไปทับพินที่ผูกกับ flash/PSRAM ภายใน ทำให้ชิปบูตไม่ขึ้นทันที</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Internal temp sensor บนชิปดั้งเดิมไม่มีเอกสารรองรับ — วัด delta ได้ ไม่ใช่ค่าจริง อย่าเชื่อค่า absolute</div>

<!-- Speaker: เหล่านี้คือจุดที่มือใหม่เจอปัญหาบ่อยที่สุดจากประสบการณ์ community forum -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้อ่านแค่สไลด์นี้สไลด์เดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Zero</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">extra parts</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Power</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">ULP · RTC · DFS</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Routing</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">GPIO Matrix · Touch</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Throughput</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">DMA</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Signal</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Wi-Fi · Hall · AM</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 10 ฟีเจอร์ใช้ฮาร์ดแวร์ที่มีอยู่แล้วในชิป — ตรวจรุ่นชิปก่อนใช้ และ calibrate ค่าด้วยตัวเองเสมอ อย่า copy ค่าจาก tutorial อื่น</div>

<!-- Speaker: ปิดท้ายด้วยการย้ำว่าทุกฟีเจอร์ต้อง verify กับ pinout/รุ่นชิปจริงก่อนใช้ production -->
