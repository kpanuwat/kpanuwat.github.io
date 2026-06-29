---
marp: true
theme: default
paginate: true
title: "Industry 1.0 ถึง 5.0: เจาะลึกวิวัฒนาการอุตสาหกรรม"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#3b82f6; --accent-deep:#1e3a8a; --accent-wash:#dbeafe; --gold:#d4af37;
    --danger:#dc2626; --danger-wash:#fee2e2; --danger-ink:#991b1b;
    --success:#16a34a; --success-wash:#dcfce7; --success-ink:#14532d;
    --warning:#f59e0b; --warning-wash:#fef3c7; --warning-ink:#92400e;
    --amber:#d97706; --amber-wash:#fef3c7;
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
    padding:10px 16px; border-radius:0 var(--radius-sm) var(--radius-sm) 0;
    font-size:13px; line-height:1.5;
  }
  .takeaway b { color:var(--accent); }
  .card {
    background:var(--paper); border-radius:var(--radius);
    box-shadow:var(--shadow-md); padding:14px 16px;
    border-left:4px solid var(--accent); box-sizing:border-box;
  }
  .card.success { border-left-color:var(--success); }
  .card.danger  { border-left-color:var(--danger); }
  .card.warning { border-left-color:var(--warning); }
  .card.gold    { border-left-color:var(--gold); }
  .card.amber   { border-left-color:var(--amber); }
  .card .label { font-size:9px; letter-spacing:.08em; text-transform:uppercase; color:var(--muted); margin:0 0 3px; }
  .card h3 { margin:0 0 4px; font-size:15px; color:var(--ink); font-weight:700; }
  .card p  { margin:0 0 3px; font-size:12px; color:var(--ink-dim); line-height:1.5; }
  .card ul { margin:0; padding-left:14px; font-size:12px; color:var(--ink-dim); line-height:1.8; }
  .card.compact { padding:8px 12px; }
  .card.compact h3 { font-size:13px; margin-bottom:3px; }
  .card.compact p, .card.compact .label { font-size:11px; }
  .bento { display:grid; gap:10px; width:100%; align-self:stretch; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:6px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:16px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/industry-1-to-5-deep-dive-cover.png)

<div class="mark"></div>

# Industry 1.0 ถึง 5.0

<p class="tag">เจาะลึกวิวัฒนาการอุตสาหกรรม 5 ยุค — จากไอน้ำสู่ Human-AI Collaboration</p>

<!-- Speaker: 5 industrial revolutions in 12 slides. The core thesis: eras layer on top of each other — they don't replace. Most factories run 3 eras simultaneously right now. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/industry-1-to-5-deep-dive-cheatsheet.png)

<!-- Speaker: One-page overview of all 5 eras. Notice the right panel — multi-era factory reality. That's the key insight most miss. -->

---

## 5 Eras Layer, They Don't Replace Each Other

<p class="subhead">โรงงานในปัจจุบันส่วนใหญ่รัน 3 ยุคพร้อมกัน — ไม่ใช่ก้าวขึ้นบันไดทีละขั้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="12" width="980" height="50" rx="8" fill="var(--accent)" opacity=".85"/>
  <text x="120" y="43" font-size="15" font-weight="700" fill="white" font-family="system-ui">Industry 5.0</text>
  <text x="310" y="43" font-size="13" fill="rgba(255,255,255,.85)" font-family="system-ui">Human-Centric + AI + Sustainability  (2020s+)  [EU Commission 2021]</text>
  <rect x="60" y="70" width="980" height="50" rx="8" fill="var(--accent)" opacity=".68"/>
  <text x="120" y="101" font-size="15" font-weight="700" fill="white" font-family="system-ui">Industry 4.0</text>
  <text x="310" y="101" font-size="13" fill="rgba(255,255,255,.85)" font-family="system-ui">IoT + Cloud + AI + Cyber-Physical Systems  (2011+)  [Hannover Messe]</text>
  <rect x="60" y="128" width="980" height="50" rx="8" fill="var(--amber)" opacity=".72"/>
  <text x="120" y="159" font-size="15" font-weight="700" fill="white" font-family="system-ui">Industry 3.0</text>
  <text x="310" y="159" font-size="13" fill="rgba(255,255,255,.88)" font-family="system-ui">PLC + Computers + Digital Automation  (1960s-2000s)</text>
  <rect x="60" y="186" width="980" height="50" rx="8" fill="var(--amber)" opacity=".52"/>
  <text x="120" y="217" font-size="15" font-weight="700" fill="white" font-family="system-ui">Industry 2.0</text>
  <text x="310" y="217" font-size="13" fill="rgba(255,255,255,.88)" font-family="system-ui">Electricity + Assembly Line + Mass Production  (1870-1914)</text>
  <rect x="60" y="244" width="980" height="50" rx="8" fill="var(--muted)" opacity=".55"/>
  <text x="120" y="275" font-size="15" font-weight="700" fill="white" font-family="system-ui">Industry 1.0</text>
  <text x="310" y="275" font-size="13" fill="rgba(255,255,255,.88)" font-family="system-ui">Steam Power + Mechanization + Factory System  (1760-1840)</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Most factories today run Industry 2.0–4.0 on the same line — understanding the layers beats memorizing the eras as a checklist.</div>

<!-- Speaker: Geological strata analogy: you don't erase old layers when new ones form. A 1987 hydraulic press + 2003 CNC + 2024 IoT gateway on one line is completely normal. -->

---

## Why Industry Eras Matter to Engineers and Product Builders

![bg right:40% contain](assets/industry-1-to-5-deep-dive-background.png)

<p class="subhead">เข้าใจ context → เลือกเทคโนโลยีถูก; ข้ามขั้น → เสียทั้งเงินและเวลา</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">For Developers and PMs</p>
    <h3>Decision Context</h3>
    <p>เข้าใจ era = รู้ว่า IoT gateway ใดเหมาะกับ PLC ยุค 3.0 โดยไม่ต้องรื้อทั้งสาย</p>
  </div>
  <div class="card warning">
    <p class="label">Thailand Context</p>
    <h3>Thailand 4.0 Crossroads</h3>
    <p>SME ไทยส่วนใหญ่อยู่ระดับ 2.0–3.0 ขณะที่นโยบาย Thailand 4.0 ดันสู่ digital manufacturing</p>
  </div>
  <div class="card gold">
    <p class="label">Common Misconception</p>
    <h3>Eras Don't Replace</h3>
    <p>เครื่องกดปี 1987 + CNC ปี 2003 + IoT gateway ปี 2024 รันบนสายผลิตเดียวกัน — เป็นเรื่องปกติ</p>
  </div>
  <div class="card danger">
    <p class="label">Marketing Alert</p>
    <h3>Buzzword vs Reality</h3>
    <p>"Industry 4.0" ถูกใช้เป็น label มากเกินจริง — นิยามจริงมีเกณฑ์วัดได้ 5 ข้อที่ชัดเจน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ก่อนเลือก solution ตรวจก่อนว่าองค์กรอยู่ยุคไหน — over-engineering I4.0 สำหรับ factory ที่ยัง 2.0 อยู่ = waste ที่แพงมาก</div>

<!-- Speaker: Thailand 4.0 is a policy direction, not a description of current state. Most Thai SMEs are 2.0–3.0. -->

---

## Industry 1.0: Steam Power Creates the Factory System (1760–1840)

<p class="subhead">England first — ถ่านหิน + ไอน้ำ = การผลิตย้ายจากบ้านสู่โรงงาน; Craftsman skill becomes machine-readable</p>

<div class="infographic">
<svg viewBox="0 0 1100 270" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="80" y1="130" x2="1030" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="1025,123 1045,130 1025,137" fill="var(--muted)"/>
  <circle cx="170" cy="130" r="34" fill="var(--accent)" opacity=".12"/>
  <circle cx="170" cy="130" r="24" fill="var(--accent)"/>
  <text x="170" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1764</text>
  <text x="170" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Jenny</text>
  <text x="170" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Spinning Jenny</text>
  <text x="170" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">8x thread output</text>
  <circle cx="420" cy="130" r="34" fill="var(--accent)" opacity=".12"/>
  <circle cx="420" cy="130" r="24" fill="var(--accent)"/>
  <text x="420" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1769</text>
  <text x="420" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Steam</text>
  <text x="420" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Watt Steam Engine</text>
  <text x="420" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Rotary motion, scalable</text>
  <circle cx="680" cy="130" r="34" fill="var(--amber)" opacity=".2"/>
  <circle cx="680" cy="130" r="24" fill="var(--amber)"/>
  <text x="680" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1785</text>
  <text x="680" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Loom</text>
  <text x="680" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Power Loom</text>
  <text x="680" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mechanical weaving</text>
  <circle cx="930" cy="130" r="34" fill="var(--amber)" opacity=".2"/>
  <circle cx="930" cy="130" r="24" fill="var(--amber)"/>
  <text x="930" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1804</text>
  <text x="930" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Rail</text>
  <text x="930" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Steam Locomotive</text>
  <text x="930" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Continental supply chain</text>
  <text x="80" y="55" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Control tech: None — craftsman skill only</text>
  <text x="80" y="73" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Core industries: Textiles / Mining / Iron production</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Industry 1.0 shifted production from homes to factories via steam — it also created the first labor crisis (child labor, 16-hr days) that forced early labor law.</div>

<!-- Speaker: No feedback loop, no control system. Craftsmen became machine operators. The Factory System was born here. -->

---

## Industry 2.0: Electricity Powers Mass Production (1870–1914)

<p class="subhead">Electricity + standardized parts + moving assembly line = ของฟุ่มเฟือยกลายเป็นของใช้ทั่วไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 270" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="80" y1="130" x2="1030" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="1025,123 1045,130 1025,137" fill="var(--muted)"/>
  <circle cx="200" cy="130" r="34" fill="var(--accent)" opacity=".12"/>
  <circle cx="200" cy="130" r="24" fill="var(--accent)"/>
  <text x="200" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1879</text>
  <text x="200" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Edison</text>
  <text x="200" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Electric Light Bulb</text>
  <text x="200" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Factories run at night</text>
  <circle cx="550" cy="130" r="34" fill="var(--accent)" opacity=".12"/>
  <circle cx="550" cy="130" r="24" fill="var(--accent)"/>
  <text x="550" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1901</text>
  <text x="550" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Olds</text>
  <text x="550" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">First Assembly Line</text>
  <text x="550" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Ransom Olds / car production</text>
  <circle cx="900" cy="130" r="40" fill="var(--amber)" opacity=".2"/>
  <circle cx="900" cy="130" r="28" fill="var(--amber)"/>
  <text x="900" y="125" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1913</text>
  <text x="900" y="139" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Ford</text>
  <text x="900" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Ford Moving Line</text>
  <text x="900" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1 car / 93 min</text>
  <text x="80" y="55" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Key pattern: Interchangeable parts + standardization = easy repair at scale</text>
  <text x="80" y="73" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Side effect: Labor unions + first labor laws (direct response to mass factory conditions)</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Ford's 1913 assembly line cut car build time from 12.5 hours to 93 minutes — proving that standardization + sequencing beats raw speed.</div>

<!-- Speaker: Rail and telegraph extended supply chains to continental scale for the first time. Mass production made the car — previously a luxury — affordable to factory workers. -->

---

## Industry 3.0: Digital Revolution Automates Factories (1960s–2000s)

<p class="subhead">Transistor → Microprocessor → PLC → CAD/CAM → ERP: automation becomes programmable, not just mechanical</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0, 8 3, 0 6" fill="var(--muted)"/>
    </marker>
  </defs>
  <rect x="30" y="100" width="150" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="105" y="132" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Transistor</text>
  <text x="105" y="150" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1947</text>
  <text x="105" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">silicon switch</text>
  <line x1="180" y1="140" x2="225" y2="140" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="230" y="100" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="310" y="132" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">PLC</text>
  <text x="310" y="150" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Modicon 084</text>
  <text x="310" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1968 / factory logic</text>
  <line x1="390" y1="140" x2="435" y2="140" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="440" y="100" width="160" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="520" y="132" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Microprocessor</text>
  <text x="520" y="150" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Intel 4004 / 1971</text>
  <text x="520" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1000x cost drop</text>
  <line x1="600" y1="140" x2="645" y2="140" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="650" y="100" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="730" y="132" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CAD / CAM</text>
  <text x="730" y="150" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">1970s-80s</text>
  <text x="730" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">design → machine</text>
  <line x1="810" y1="140" x2="855" y2="140" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="860" y="100" width="200" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="960" y="132" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ERP + LAN</text>
  <text x="960" y="150" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1990s</text>
  <text x="960" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">enterprise-wide data</text>
  <text x="30" y="55" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Control tech: SCADA + PLC + internal LAN</text>
  <text x="30" y="73" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Key trait: Partial automation — some steps automated, humans still required for others</text>
  <text x="30" y="240" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Thailand example: Toyota, Honda automotive plants + WD, Seagate electronics in industrial estates = I3.0 anchor</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Industry 3.0 made automation programmable instead of mechanical — the Modicon 084 PLC (1968) replaced relay cabinets the size of rooms with software logic.</div>

<!-- Speaker: Toyota's Just-In-Time system is I3.0's operational peak. Thailand's automotive and electronics export industries are essentially I3.0 infrastructure. -->

---

## Industry 4.0: Smart Manufacturing Thinks for Itself (2011+)

<p class="subhead">Term coined: Hannover Messe 2011 (German national strategy) — machines emit data automatically; decisions are automated</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="395" y="10" width="310" height="50" rx="10" fill="var(--accent)" opacity=".9"/>
  <text x="550" y="41" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Industry 4.0 Factory</text>
  <line x1="550" y1="60" x2="140" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="60" x2="335" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="60" x2="550" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="60" x2="765" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="60" x2="960" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="45" y="100" width="190" height="82" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="130" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CPS + Digital Twin</text>
  <text x="140" y="148" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Sensors in every machine</text>
  <text x="140" y="164" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Virtual factory mirror</text>
  <rect x="245" y="100" width="180" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="335" y="130" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">IIoT</text>
  <text x="335" y="148" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OPC UA + MQTT</text>
  <text x="335" y="164" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Machine-to-machine</text>
  <rect x="455" y="100" width="190" height="82" rx="10" fill="var(--amber-wash)" stroke="var(--amber)" stroke-width="1.5"/>
  <text x="550" y="130" font-size="12" font-weight="700" fill="var(--amber)" text-anchor="middle" font-family="system-ui">Cloud + Edge</text>
  <text x="550" y="148" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AWS IoT / Azure IoT</text>
  <text x="550" y="164" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Edge = low latency</text>
  <rect x="670" y="100" width="190" height="82" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="765" y="130" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AI / ML</text>
  <text x="765" y="148" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Predictive Maint.</text>
  <text x="765" y="164" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Vision QC, -45% downtime</text>
  <rect x="870" y="100" width="185" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="962" y="130" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MES</text>
  <text x="962" y="148" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Real-time ERP link</text>
  <text x="962" y="164" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Orders to machines</text>
  <text x="30" y="242" font-size="12" fill="var(--accent-deep)" font-weight="700" font-family="system-ui">5 criteria for real I4.0:</text>
  <text x="30" y="260" font-size="11" fill="var(--ink-dim)" font-family="system-ui">1. Machines emit data automatically  2. No manual data entry  3. Data links to order/shift context</text>
  <text x="30" y="278" font-size="11" fill="var(--ink-dim)" font-family="system-ui">4. Data triggers automated decisions  5. Architecture is equipment-generation-independent</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> If your factory still requires manual data entry at any step, it is not I4.0 — regardless of how many IoT sensors you have installed.</div>

<!-- Speaker: Siemens Amberg plant, Amazon Kiva robots (750k+), Bosch predictive maintenance are real I4.0 examples. Cybersecurity is the silent risk: OT + IT convergence = new attack surface. -->

---

## Industry 5.0: Worker Well-being at the Centre (2020s+)

![bg right:40% contain](assets/industry-1-to-5-deep-dive-industry50.png)

<p class="subhead">EU Commission white paper (Jan 2021): ไปพ้น efficiency เพียงอย่างเดียว — คน, สังคม, และโลก คือเป้าหมายหลัก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Pillar 1: Human-Centric</p>
    <h3>คนอยู่ศูนย์กลาง</h3>
    <p>Cobots (Universal Robots, ABB YuMi) ทำงานข้างมนุษย์โดยตรง ไม่ต้องใช้ cage กั้น — force sensor หยุดทันทีเมื่อสัมผัส</p>
  </div>
  <div class="card amber">
    <p class="label">Pillar 2: Sustainable</p>
    <h3>ผลิตอย่างยั่งยืน</h3>
    <p>Circular economy + Green manufacturing + AI energy optimization — ไม่ทำลายทรัพยากรเกินกว่าโลกฟื้นฟูได้</p>
  </div>
  <div class="card">
    <p class="label">Pillar 3: Resilient</p>
    <h3>รับมือวิกฤตได้</h3>
    <p>COVID-19 = wake-up call — supply chain ที่พึ่ง single-source เดี๋ยวนี้ต้องกระจาย + มีสายผลิตสำรองในท้องถิ่น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Industry 5.0 shifts from shareholder value to stakeholder value — but it's still a vision (EU policy), not a measurable ISO standard like I4.0's OPC UA or IEC 62443.</div>

<!-- Speaker: I4.0 asked "how do we automate humans out?" — I5.0 asks "how do we amplify humans with AI?" That's the philosophical flip. Critics call it a marketing reframe; proponents say it's a necessary ethical correction. -->

---

## Multi-era Reality: Most Factories Run 3 Eras Simultaneously

![bg right:40% contain](assets/industry-1-to-5-deep-dive-multiera.png)

<p class="subhead">ความจริงที่มักถูกมองข้าม — not a ladder to climb, but layers that accumulate</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Typical European Mid-size Factory</p>
    <h3>Parallel Era Stack</h3>
    <p>1987 hydraulic press (I2.0) + 2003 CNC machine (I3.0) + 2024 IoT gateway (I4.0) — all on one production line, all producing revenue</p>
  </div>
  <div class="card">
    <p class="label">Thailand Industry Map</p>
    <h3>Crossroads Reality</h3>
    <ul>
      <li>SMEs: mostly I2.0–I3.0</li>
      <li>Automotive tier-1 (Toyota, Isuzu): I3.0→I4.0 transition</li>
      <li>Electronics (WD, Seagate): I3.0–I4.0</li>
      <li>Thailand 4.0 policy: strategic direction, not current state</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "What era is your factory?" is the wrong question — ask "which processes are at which era, and which gaps cause the most downtime/waste?" Then fix the highest-value gap first.</div>

<!-- Speaker: The multi-era reality means ROI calculations for I4.0 upgrades must account for backward compatibility — retrofitting IoT onto 1987 hardware is a real engineering challenge. -->

---

## Caveats: What Industry N.0 Labels Don't Tell You

<p class="subhead">5 blind spots ที่มักพลาดเมื่อวางแผน digital transformation</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">No Universal Standard</p>
    <h3>ไม่มีมาตรวัดสากล</h3>
    <p>ไม่มี ISO/IEC ที่วัด "factory is I4.0" — I4.0 มีแค่ component standards (OPC UA IEC 62541, ISA-95) ไม่ใช่ certification level</p>
  </div>
  <div class="card danger">
    <p class="label">Digital Divide</p>
    <h3>กระโดดข้ามยาก</h3>
    <p>ประเทศกำลังพัฒนาส่วนใหญ่ยังข้าม I3.0 ไม่พ้น — กระโดดสู่ I4.0 ต้องการ bandwidth, cloud infra, และ talent ที่อาจยังไม่พร้อม</p>
  </div>
  <div class="card warning">
    <p class="label">Transition Cost</p>
    <h3>ต้นทุนสูง, ROI ช้า</h3>
    <p>IIoT gateway + cloud subscription + retraining = ไม่ถูก — ROI อาจใช้เวลา 3–7 ปี; ต้อง model ก่อนตัดสินใจ</p>
  </div>
  <div class="card amber">
    <p class="label">Industry 5.0 Reality</p>
    <h3>Vision ไม่ใช่ Standard</h3>
    <p>I5.0 ยังไม่มี ISO standard — ต่างจาก I4.0 ที่มี OPC UA, IEC 62443; ระวัง vendor ที่ขายของโดยอ้าง I5.0 compliance</p>
  </div>
  <div class="card danger">
    <p class="label">OT + IT Convergence</p>
    <h3>Cybersecurity Blind Spot</h3>
    <p>การเชื่อม OT กับ IT network ทำให้โรงงานกลายเป็น attack surface — Colonial Pipeline hack (2021) ปิดท่อส่งน้ำมัน 5,500 ไมล์ใน 6 วัน</p>
  </div>
  <div class="card success">
    <p class="label">Best Practice</p>
    <h3>Retrofit + Incrementally</h3>
    <p>IIoT overlay บน existing PLC = low risk, high signal value — ไม่ต้องรื้อสาย, ได้ data flow ก่อน ค่อย automate decision</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "We're doing Industry 4.0" without the 5 measurable criteria = marketing, not manufacturing transformation.</div>

<!-- Speaker: Colonial Pipeline is the starkest warning: OT systems running critical infrastructure with no IT security posture. When IT and OT converge, the threat model changes completely. -->

---

## Key Takeaways: 5 Era Essentials

<p class="subhead">โรงงานส่วนใหญ่รัน multi-era — เป้าหมายไม่ใช่ไปถึง 5.0, แต่คือหา gap ที่แพงที่สุดแล้วปิดก่อน</p>

<div class="infographic">
<div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;align-items:center;width:100%">
<div>
<svg viewBox="0 0 500 400" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="250" cy="200" r="185" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="250" cy="200" r="145" fill="none" stroke="var(--muted)" stroke-width="1.5" opacity=".5"/>
  <circle cx="250" cy="200" r="105" fill="none" stroke="var(--amber)" stroke-width="1.5" opacity=".6"/>
  <circle cx="250" cy="200" r="65" fill="none" stroke="var(--accent)" stroke-width="2" opacity=".7"/>
  <circle cx="250" cy="200" r="28" fill="var(--accent)" opacity=".15"/>
  <circle cx="250" cy="200" r="28" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="250" y="195" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">I1.0</text>
  <text x="250" y="210" font-size="10" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Steam</text>
  <text x="250" y="130" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">I2.0  Electricity</text>
  <text x="250" y="75" font-size="11" font-weight="700" fill="var(--amber)" text-anchor="middle" font-family="system-ui">I3.0  PLC + Digital</text>
  <text x="250" y="28" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">I4.0  IoT + AI + Cloud</text>
  <text x="250" y="388" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">I5.0  Human-Centric (outer context)</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>
<div style="display:flex;flex-direction:column;gap:8px;">
  <div class="card compact amber">
    <p class="label">Industry 1.0–2.0</p>
    <p>Steam → Electricity; Factory System → Mass Production; Craftsmen → Operators</p>
  </div>
  <div class="card compact warning">
    <p class="label">Industry 3.0</p>
    <p>PLC (1968) + CAD/CAM → Partial automation; SCADA control; Toyota JIT</p>
  </div>
  <div class="card compact">
    <p class="label">Industry 4.0</p>
    <p>IoT + AI + CPS → Smart Mfg; 5 measurable criteria; Cybersecurity risk</p>
  </div>
  <div class="card compact success">
    <p class="label">Industry 5.0</p>
    <p>EU vision 2021: Human-Centric + Sustainable + Resilient; Cobots; still no ISO</p>
  </div>
  <div class="card compact gold">
    <p class="label">Multi-era Truth</p>
    <p>Most factories = I2.0+I3.0+I4.0 simultaneously — find the highest-value gap first</p>
  </div>
</div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 5 ยุค ≠ 5 ขั้นบันได — โรงงานส่วนใหญ่รัน multi-era; "Industry 5.0" ยังเป็น vision ไม่ใช่ standard; Cybersecurity คือ blind spot ใหญ่ที่สุดของ I4.0</div>

<!-- Speaker: Final message: don't chase the number. Chase the value gap. A factory that runs I2.0 machines with I4.0 data overlay on the bottleneck process will outperform a factory that buys I4.0 vendor packages without fixing the bottleneck. -->
