---
marp: true
theme: default
paginate: true
title: "วัดพลังงาน Cooling Tower ด้วย Schneider PM2230 + Split-core CT"
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
  section h2 { font-size:28px; margin:0 0 4px; color:var(--ink); font-weight:700; }
  .subhead { color:var(--ink-dim); font-size:15px; margin:0 0 8px; }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; min-height:0; }
  .takeaway {
    border-left:4px solid var(--accent); background:var(--soft);
    padding:12px 18px; border-radius:0 var(--radius-sm) var(--radius-sm) 0;
    font-size:14px; line-height:1.5;
  }
  .takeaway b { color:var(--accent); }
  .card {
    background:var(--paper); border-radius:var(--radius);
    box-shadow:var(--shadow-md); padding:18px 20px;
    border-left:4px solid var(--accent); box-sizing:border-box;
  }
  .card.success { border-left-color:var(--success); }
  .card.danger  { border-left-color:var(--danger); }
  .card.warning { border-left-color:var(--warning); }
  .card.gold    { border-left-color:var(--gold); }
  .card .label { font-size:10px; letter-spacing:.08em; text-transform:uppercase; color:var(--muted); margin:0 0 4px; }
  .card h3 { margin:0 0 6px; font-size:17px; color:var(--ink); font-weight:700; }
  .card p  { margin:0 0 4px; font-size:13px; color:var(--ink-dim); line-height:1.5; }
  .card ul { margin:0; padding-left:16px; font-size:13px; color:var(--ink-dim); line-height:1.9; }
  .card.compact { padding:10px 14px; }
  .card.compact h3 { font-size:14px; margin-bottom:4px; }
  .card.compact p, .card.compact .label { font-size:11px; }
  .bento { display:grid; gap:12px; width:100%; align-self:stretch; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
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

<div class="mark"></div>

# วัดพลังงาน Cooling Tower
# ด้วย PM2230 + Split-core CT

<p class="tag">Schneider PM2230 · RS485 Modbus RTU · BMS/EMS Integration · งบ 15,000–30,000 บาท/จุด</p>

<!-- Speaker: ทำไมต้องวัดพลังงาน Cooling Tower? เพราะมันกินไฟ 20-40% ของระบบ HVAC ทั้งหมดแต่ส่วนใหญ่ไม่มีข้อมูล -->

---

## Cooling Tower วัดพลังงานได้ภายในวันเดียว ไม่ต้องดับระบบ

<p class="subhead">Split-core CT ครอบสาย L1/L2/L3 ขณะ energized → PM2230 วัด kW/kWh/PF → ส่งผ่าน Modbus RTU</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- callout box: TL;DR summary -->
  <rect x="40" y="30" width="1020" height="240" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="8" height="240" rx="4" fill="var(--accent)"/>
  <!-- Icon circle -->
  <circle cx="130" cy="150" r="50" fill="var(--accent)" opacity=".10"/>
  <circle cx="130" cy="150" r="34" fill="var(--accent)"/>
  <!-- lightning bolt simplified as text symbol -->
  <text x="130" y="158" font-size="22" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">kW</text>
  <!-- Key facts -->
  <text x="210" y="100" font-size="18" font-weight="700" fill="var(--ink)" font-family="system-ui">Schneider PM2230 + Split-core CT + RS485 Modbus RTU</text>
  <text x="210" y="133" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Measures: kW · kWh · Voltage (L1/L2/L3) · Current · Power Factor · THD</text>
  <text x="210" y="160" font-size="14" fill="var(--ink-dim)" font-family="system-ui">No system shutdown required — hinged CT clamps around live conductors</text>
  <text x="210" y="187" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Budget: 15,000–30,000 THB per measurement point · ROI typically under 1 year</text>
  <text x="210" y="214" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Scalable: start with total CT, then split Fan / Pump individually</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ติดตั้งแบบ non-intrusive ไม่ดับระบบ — เริ่มเก็บ energy data ได้ภายในวันเดียว</div>

<!-- Speaker: นี่คือ solution overview ที่เราจะ deep-dive ทั้ง 13 slides -->

---

## ทำไม Cooling Tower ต้องวัดพลังงาน?

<p class="subhead">ไม่มีข้อมูล = ไม่รู้ว่าเครื่องเสื่อม, ซ่อมแล้วดีขึ้นไหม, หรือรายงาน ESG ได้แค่ไหน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Problem 1</p>
    <h3>ตรวจไม่เจอ Efficiency Drop</h3>
    <p>ตะกรัน (scale) บนท่อหรือ Fan blade สึกหรอ ทำให้ kW สูงขึ้นโดยไม่มีอาการชัดเจน — ไม่มี meter = ไม่รู้ว่าเกิดขึ้น</p>
  </div>
  <div class="card warning">
    <p class="label">Problem 2</p>
    <h3>พิสูจน์ ROI ซ่อมบำรุงไม่ได้</h3>
    <p>หลังล้าง Fill media หรือเปลี่ยน Fan belt — ไม่มีข้อมูลก่อน/หลัง จึงไม่สามารถแสดงว่าประหยัดได้กี่ kWh ต่อวัน</p>
  </div>
  <div class="card">
    <p class="label">Problem 3</p>
    <h3>รายงาน ESG ไม่มี Baseline</h3>
    <p>ISO 50001 และ GHG Protocol Scope 2 ต้องการ energy baseline รายอุปกรณ์ — ไม่มีมิเตอร์ = ประมาณการเท่านั้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cooling Tower กิน 20–40% ของโหลด HVAC — ถ้าไม่วัดคือ blind spot ที่ใหญ่ที่สุดในระบบ</div>

<!-- Speaker: 3 pain points ที่ทีม Operations และ ESG เจอบ่อยที่สุด -->

---

## System Architecture: CT → PM2230 → RS485 → BMS

<p class="subhead">อุปกรณ์ 4 ชั้นทำงานต่อเนื่องกัน — ทุกชั้นส่งผลต่อความแม่นยำของข้อมูล</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Box 1: Cooling Tower Motor -->
  <rect x="20" y="100" width="200" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <text x="120" y="145" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cooling Tower</text>
  <text x="120" y="165" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Motor (3-phase)</text>
  <text x="120" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">L1 / L2 / L3</text>
  <!-- Arrow 1 -->
  <line x1="220" y1="160" x2="280" y2="160" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <text x="250" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">clamp</text>
  <!-- Box 2: Split-core CT -->
  <rect x="280" y="100" width="200" height="120" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="380" y="145" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Split-core CT x3</text>
  <text x="380" y="165" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">100/5A – 400/5A</text>
  <text x="380" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5A secondary out</text>
  <!-- Arrow 2 -->
  <line x1="480" y1="160" x2="540" y2="160" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <text x="510" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5A + Vac</text>
  <!-- Box 3: PM2230 -->
  <rect x="540" y="80" width="200" height="160" rx="12" fill="var(--accent)" stroke="none"/>
  <text x="640" y="145" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Schneider</text>
  <text x="640" y="165" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">PM2230</text>
  <text x="640" y="188" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Class 0.5S · RS485</text>
  <text x="640" y="206" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Slave ID 1-247</text>
  <!-- Arrow 3 -->
  <line x1="740" y1="160" x2="800" y2="160" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <text x="770" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">RS485 A/B</text>
  <!-- Box 4: BMS/EMS -->
  <rect x="800" y="100" width="280" height="120" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="940" y="145" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">BMS / EMS</text>
  <text x="940" y="165" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Modbus Master</text>
  <text x="940" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SCADA · MQTT · BACnet</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PM2230 เป็นศูนย์กลาง — CT ส่ง current, MCB ส่ง voltage, RS485 ส่งข้อมูลออก</div>

<!-- Speaker: อธิบายว่า CT วัด current แล้ว PM2230 คำนวณ power จาก V×I×PF -->

---

## PM2230 Key Specifications

<p class="subhead">EasyLogic PM2230 (METSEPM2230) — Class 0.5S, RS485 Modbus RTU, 31st harmonic</p>

| Parameter | Value |
|---|---|
| **Accuracy Class** | IEC 62053-22 Class 0.5S (±0.5% FS) |
| **CT Input** | 5A secondary |
| **Voltage Input** | 100–277 V L-N / 100–480 V L-L |
| **RS485 Protocol** | Modbus RTU, 4800–38400 bps, max 32 slaves, 1200 m |
| **Harmonics** | Up to 31st harmonic + THD per phase |
| **Measurements** | kW · kvar · kVA · kWh · kvarh · PF · V · I · Hz · THD |

<div class="takeaway"><b>★ Takeaway:</b> Class 0.5S = ±0.5% accuracy — เพียงพอสำหรับ energy monitoring และ ESG reporting แต่ไม่ใช่ revenue billing</div>

<!-- Speaker: ตัวเลข 0.5S สำคัญ — ถ้าต้องการ billing-grade ต้องใช้ Class 0.2S ขึ้นไป -->

---

## Modbus Register Map — ค่าที่ต้องอ่านบ่อย

<p class="subhead">ทุกค่าเป็น Float32 (2 registers) อ่านด้วย FC03 · pymodbus ใช้ 0-based address (register − 1)</p>

| พารามิเตอร์ | Register (Schneider) | pymodbus addr | Type |
|---|---|---|---|
| Current L1/L2/L3 (A) | 2999 / 3001 / 3003 | 2998 / 3000 / 3002 | Float32 |
| Voltage L1-N/L2-N/L3-N (V) | 3027 / 3029 / 3031 | 3026 / 3028 / 3030 | Float32 |
| **Active Power Total (kW)** | **3059** | **3058** | Float32 |
| **Active Energy (kWh)** | **2699** | **2698** | Float32 |

<div class="takeaway"><b>★ Takeaway:</b> register 3059 = kW total, 2699 = kWh — สองค่านี้คือ minimum viable monitoring สำหรับ Cooling Tower</div>

<!-- Speaker: Float32 Big-Endian — ต้อง pack ">HH" แล้ว unpack ">f" ใน Python -->

---

## Split-core CT — เลือก Ratio อย่างไร

<p class="subhead">เลือกผิด = วัดผิด: CT อิ่มตัว (saturation) หรือ accuracy ออกนอก spec</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Steps: FLA → x1.25 → pick CT → verify 5A secondary -->
  <!-- Step 1 -->
  <rect x="20" y="80" width="220" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="120" cy="110" r="18" fill="var(--accent)"/>
  <text x="120" y="116" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="120" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Read FLA</text>
  <text x="120" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Motor nameplate</text>
  <text x="120" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">or clamp meter</text>

  <line x1="240" y1="150" x2="290" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr2)"/>

  <!-- Step 2 -->
  <rect x="290" y="80" width="220" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="400" cy="110" r="18" fill="var(--accent)"/>
  <text x="400" y="116" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="400" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FLA x 1.25</text>
  <text x="400" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">80A → pick 100/5A</text>
  <text x="400" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Add 25% headroom</text>

  <line x1="510" y1="150" x2="560" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr2)"/>

  <!-- Step 3 -->
  <rect x="560" y="80" width="220" height="140" rx="12" fill="var(--accent)" stroke="none"/>
  <circle cx="670" cy="110" r="18" fill="white" opacity=".3"/>
  <text x="670" y="116" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="670" y="148" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Verify 5A secondary</text>
  <text x="670" y="168" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">PM2230 CT input = 5A</text>
  <text x="670" y="186" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Match all 3 phases</text>

  <line x1="780" y1="150" x2="830" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr2)"/>

  <!-- Step 4 -->
  <rect x="830" y="80" width="250" height="140" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <circle cx="955" cy="110" r="18" fill="var(--success)"/>
  <text x="955" y="116" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="955" y="148" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Same ratio all phases</text>
  <text x="955" y="168" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Ratio mismatch = error</text>
  <text x="955" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Class 0.5 min (IEC 61869-2)</text>

  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CT ที่ถูกต้อง = FLA x 1.25, secondary 5A, Class 0.5, ratio เหมือนกันทุก phase</div>

<!-- Speaker: ถ้า ratio ไม่เท่ากัน 3 phase จะทำให้ power factor ผิดด้วย -->

---

## CT Sizing Reference Table

<p class="subhead">เลือก CT ratio ตามขนาด Cooling Tower — ค่า FLA เป็นประมาณการ ควรวัดจริงก่อนสั่ง CT</p>

| Cooling Tower Size | Approx. FLA | Recommended CT | CT Primary |
|---|---|---|---|
| 50–100 RT | 30–60 A | 75/5A or **100/5A** | 100 A |
| 100–200 RT | 60–120 A | 150/5A or **200/5A** | 200 A |
| 200–400 RT | 120–250 A | 300/5A or **400/5A** | 400 A |
| > 400 RT | > 250 A | **500/5A** or measure first | 500 A |

> **Rule:** FLA (measured with clamp meter) × 1.25 → round up to nearest standard CT primary rating. Secondary must be **5A** for PM2230.

<div class="takeaway"><b>★ Takeaway:</b> วัด FLA จริงด้วย clamp meter ก่อนสั่ง CT เสมอ — nameplate FLA มักต่างจากความเป็นจริง 10–20%</div>

<!-- Speaker: สำคัญ: CT oversize ไม่อันตราย แต่ accuracy จะลดลง ถ้า load อยู่ที่ 20% ของ CT primary -->

---

## RS485 Wiring — Daisy Chain + Termination

<p class="subhead">ผิดพลาดที่พบบ่อยที่สุด: ไม่ใส่ terminator และ ground shield สองปลาย</p>

<div class="infographic" style="flex-direction:column;gap:14px;align-items:stretch;">
<svg viewBox="0 0 1100 180" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Bus line -->
  <line x1="80" y1="90" x2="1020" y2="90" stroke="var(--accent)" stroke-width="3"/>
  <!-- BMS Master -->
  <rect x="20" y="50" width="120" height="80" rx="10" fill="var(--accent-deep)"/>
  <text x="80" y="86" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">BMS</text>
  <text x="80" y="104" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Master</text>
  <!-- PM2230 #1 -->
  <rect x="240" y="50" width="150" height="80" rx="10" fill="var(--accent)"/>
  <text x="315" y="83" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">PM2230 · ID:1</text>
  <text x="315" y="100" font-size="10" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">CT Tower #1</text>
  <!-- PM2230 #2 -->
  <rect x="475" y="50" width="150" height="80" rx="10" fill="var(--accent)"/>
  <text x="550" y="83" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">PM2230 · ID:2</text>
  <text x="550" y="100" font-size="10" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">CT Tower #2</text>
  <!-- PM2230 #N -->
  <rect x="710" y="50" width="160" height="80" rx="10" fill="var(--accent)"/>
  <text x="790" y="83" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">PM2230 · ID:N</text>
  <text x="790" y="100" font-size="10" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">max 32 devices</text>
  <!-- Terminator -->
  <rect x="920" y="68" width="100" height="44" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="970" y="87" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">120 ohm</text>
  <text x="970" y="103" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">terminator</text>
</svg>
<div class="bento cols-3" style="flex-shrink:0">
  <div class="card compact">
    <p class="label">Cable</p>
    <h3>STP AWG22–24, 120 ohm</h3>
    <p>Shielded Twisted Pair · impedance 120 ohm · max 1200 m at 9600 bps</p>
  </div>
  <div class="card compact success">
    <p class="label">Shield</p>
    <h3>Ground at Master side only</h3>
    <p>Shield drain wire connects to GND at BMS Master only — both ends = ground loop</p>
  </div>
  <div class="card compact warning">
    <p class="label">Terminator</p>
    <h3>120 ohm at far end — mandatory</h3>
    <p>No terminator = signal reflection = data corruption — one terminator per segment</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Daisy chain + 120Ω ที่ปลาย + Shield ที่ Master เท่านั้น — ขาดอย่างใดอย่างหนึ่ง = data corruption</div>

<!-- Speaker: ห้ามต่อ Shield ทั้งสองปลาย — จะเกิด ground loop รบกวนสัญญาณ -->

---

## BMS/EMS Integration — 4 Paths

<p class="subhead">เลือก integration path ตาม protocol ที่ BMS ปลายทางรองรับ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Path 1 — Most Common</p>
    <h3>Modbus TCP Gateway</h3>
    <p>Moxa MGate หรือ equivalent แปลง RTU → TCP แบบ transparent — ใช้เมื่อ BMS รับ Modbus TCP เท่านั้น ไม่ต้องเขียน code</p>
  </div>
  <div class="card">
    <p class="label">Path 2 — Building BMS</p>
    <h3>RS485 to BACnet/IP</h3>
    <p>Gateway เช่น Babel Buster แปลง Modbus register → BACnet object — ใช้เมื่อ BMS อาคารเป็น BACnet/IP (Johnson Controls, Siemens)</p>
  </div>
  <div class="card success">
    <p class="label">Path 3 — Cloud EMS</p>
    <h3>Modbus to MQTT</h3>
    <p>Edge device (Node-RED, Raspberry Pi, industrial gateway) poll Modbus แล้ว publish → MQTT broker → AWS IoT / Azure IoT Hub</p>
  </div>
  <div class="card gold">
    <p class="label">Path 4 — Factory</p>
    <h3>Direct to SCADA</h3>
    <p>SCADA platform (Ignition, WinCC, Inductive Automation) เชื่อม RS485 โดยตรงผ่าน OPC-DA/UA driver — ใช้เมื่อมี SCADA อยู่แล้ว</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า BMS มีอยู่แล้วใช้ Gateway (Path 1 หรือ 2) — ถ้าต้องการ Cloud analytics ใช้ MQTT (Path 3)</div>

<!-- Speaker: Path 3 ยืดหยุ่นที่สุดสำหรับ future analytics แต่ต้องการ edge device และ config เพิ่ม -->

---

## Expansion Roadmap — Phase 1 to 4

<p class="subhead">เริ่มจากวัดรวม ค่อยขยายเป็นรายวงจร — ไม่ต้องรื้อระบบเดิม</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Timeline line -->
  <line x1="100" y1="140" x2="1000" y2="140" stroke="var(--soft-2)" stroke-width="3"/>

  <!-- Phase 1 -->
  <circle cx="160" cy="140" r="22" fill="var(--accent)"/>
  <text x="160" y="146" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">P1</text>
  <rect x="70" y="168" width="180" height="80" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="160" y="190" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cooling Tower Total</text>
  <text x="160" y="208" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1 PM2230 + 3 CT</text>
  <text x="160" y="224" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Overall energy view</text>

  <!-- Phase 2 -->
  <circle cx="410" cy="140" r="22" fill="var(--accent)"/>
  <text x="410" y="146" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">P2</text>
  <rect x="320" y="168" width="180" height="80" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="410" y="190" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Fan Motor Split</text>
  <text x="410" y="208" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+1 PM2230/Fan</text>
  <text x="410" y="224" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Per-fan visibility</text>

  <!-- Phase 3 -->
  <circle cx="660" cy="140" r="22" fill="var(--accent)"/>
  <text x="660" y="146" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">P3</text>
  <rect x="570" y="168" width="180" height="80" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="660" y="190" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pump Motor Split</text>
  <text x="660" y="208" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CW Pump, Cond. Pump</text>
  <text x="660" y="224" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Pump energy baseline</text>

  <!-- Phase 4 -->
  <circle cx="940" cy="140" r="22" fill="var(--gold)"/>
  <text x="940" y="146" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">P4</text>
  <rect x="840" y="168" width="190" height="80" rx="8" fill="var(--warning-wash)" stroke="var(--gold)" stroke-width="1"/>
  <text x="935" y="190" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Ambient + COP</text>
  <text x="935" y="208" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">OAT + WBT sensors</text>
  <text x="935" y="224" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">kW/RT calculation</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Phase 4 คือ kW/RT — efficiency metric ที่ช่วยเปรียบเทียบ Cooling Tower ต่างขนาดในระบบเดียวกัน</div>

<!-- Speaker: Phase 1 ใช้งบ 15-30k, Phase 2-3 เพิ่มทีละ 15-20k ต่อ circuit -->

---

## Installation Steps — 7 ขั้นตอน

<p class="subhead">ติดตั้งได้ใน 1 วัน ไม่ต้องดับระบบ — เรียงตามลำดับ มีความสำคัญด้านความปลอดภัย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Step 1–2</p>
    <h3>Measure FLA + Mount PM2230</h3>
    <p>Clamp meter วัด FLA → สั่ง CT · ติด PM2230 บน DIN rail หรือ panel cutout 92×92 mm</p>
  </div>
  <div class="card compact warning">
    <p class="label">Step 3 — Safety Critical</p>
    <h3>Clamp Split-core CT</h3>
    <p>เปิด hinge, ครอบสาย L1/L2/L3, ปิด · P1 ชี้ไปทาง Load · อย่าเปิด secondary ขณะ load ไหล</p>
  </div>
  <div class="card compact">
    <p class="label">Step 4–5</p>
    <h3>Wire RS485 + Configure</h3>
    <p>Daisy chain A/B · 120Ω terminator ปลายสาย · ตั้ง Slave ID + Baud 9600 + CT Ratio ในเมนู PM2230</p>
  </div>
  <div class="card compact success">
    <p class="label">Step 6–7</p>
    <h3>Test + BMS Connect</h3>
    <p>pymodbus poll register 3059 เทียบกับ clamp meter · Map ใน BMS: 3059=kW, 2699=kWh · polling interval 60–300s</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ขั้นตอนที่ 3 (ครอบ CT) ต้องระวังมากที่สุด — เปิด secondary ขณะ load = อันตรายแรงดันสูง</div>

<!-- Speaker: ทีม electrical ควรทำ Step 3 เสมอ ไม่ใช่ IT หรือ OT engineer -->

---

## Caveats — สิ่งที่ต้องระวัง

<p class="subhead">ข้อจำกัดจริงของระบบ — รู้ไว้ก่อนตัดสินใจซื้อและติดตั้ง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Accuracy Limit</p>
    <h3>Split-core CT: Class 0.5–1%</h3>
    <p>กว้างกว่า solid-core CT (Class 0.1–0.2%) — เหมาะสำหรับ monitoring ไม่ใช่ revenue billing ระหว่างสองฝ่าย</p>
  </div>
  <div class="card danger">
    <p class="label">Bus Architecture</p>
    <h3>RS485 Single Master เท่านั้น</h3>
    <p>ถ้า BMS และ EMS ต้องดึงข้อมูลพร้อมกัน → bus contention → data corruption ต้องใช้ Gateway เป็น concentrator</p>
  </div>
  <div class="card warning">
    <p class="label">EMI Risk</p>
    <h3>VFD ใกล้ RS485</h3>
    <p>Variable Frequency Drive ปล่อย EMI รุนแรง — ใช้ shielded cable + ferrite core + เดินสาย RS485 ห่าง power cable ≥ 30 cm</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Split-core CT ดีพอสำหรับ energy monitoring แต่ถ้าต้องการ billing-grade accuracy ให้ใช้ solid-core CT Class 0.2S</div>

<!-- Speaker: VFD คือปัญหาที่พบบ่อยที่สุด — ถ้า data ไม่นิ่งให้ตรวจสอบ wiring routing ก่อน -->

---

## Key Takeaways

<p class="subhead">7 สิ่งที่ต้องจำหลังจากอ่าน slide ชุดนี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Installation</p>
    <h3>ไม่ต้องดับระบบ</h3>
    <p>Split-core CT ครอบขณะ energized — ลด downtime และความเสี่ยง ติดตั้งได้ในวันเดียว</p>
  </div>
  <div class="card">
    <p class="label">CT Selection</p>
    <h3>FLA x 1.25, Secondary 5A</h3>
    <p>วัด FLA จริง → คูณ 1.25 → round up · Secondary 5A เท่านั้นสำหรับ PM2230 · Class 0.5 ขึ้นไป</p>
  </div>
  <div class="card warning">
    <p class="label">RS485 Wiring</p>
    <h3>Daisy chain + 120 ohm ต้องทำเสมอ</h3>
    <p>ไม่มี terminator = signal reflection = data corruption · Shield ต่อที่ Master ฝั่งเดียว</p>
  </div>
  <div class="card">
    <p class="label">Modbus</p>
    <h3>Register 3059 = kW, 2699 = kWh</h3>
    <p>Float32 / FC03 / 0-based address ใน pymodbus · Byte-swap IEEE 754 Big-Endian</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> งบ 15,000–30,000 บาท/จุด · ROI &lt; 1 ปีจาก energy saving ที่ตรวจพบ · เริ่ม Phase 1 แล้วขยายทีละ circuit</div>

<!-- Speaker: ถ้าจะเริ่มทำเพียงขั้นตอนเดียวคือ วัด FLA จริงด้วย clamp meter แล้วสั่ง CT ให้ถูก spec -->
