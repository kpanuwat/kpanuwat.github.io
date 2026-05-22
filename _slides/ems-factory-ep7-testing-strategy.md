---
marp: true
theme: default
paginate: true
title: "EMS Factory EP7: Testing Strategy (AOI, ICT, FCT)"
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
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# EMS Factory EP7: Testing Strategy (AOI, ICT, FCT)

<p class="tag">3 ชั้นของ testing — visual → electrical → functional — แต่ละชั้นดักจับ defect ที่ชั้นอื่นตรวจไม่เจอ</p>

<!-- Speaker: Testing strategy คือ risk management ไม่ใช่แค่ QC step — ทุก method ที่ skip คือ defect ที่อาจหลุดถึงมือ end user -->

---

## AOI, ICT, FCT: คนละ Scope — ทำงานร่วมกัน

<p class="subhead">ไม่มี method เดียวที่ cover ได้ครบ — แต่ละ method ตรวจคนละ layer ของ quality</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Layer 1 — Visual</p>
    <h3>AOI</h3>
    <p>สแกนด้วยกล้อง หลัง reflow oven</p>
    <ul>
      <li>Missing / misaligned component</li>
      <li>Solder bridge / tombstone</li>
      <li>ไม่ใช้ไฟ — ตรวจสายตาเท่านั้น</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Layer 2 — Electrical Structural</p>
    <h3>ICT</h3>
    <p>Probe ทุก test point — ไม่ power up ระบบ</p>
    <ul>
      <li>Open / short / ค่า component ผิด</li>
      <li>Coverage 70–90% ของ mfg defect</li>
      <li>Bed-of-nails หรือ flying probe</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Layer 3 — Functional System</p>
    <h3>FCT</h3>
    <p>Power up จริง ส่ง stimulus ตรวจ response</p>
    <ul>
      <li>Firmware / protocol / calibration</li>
      <li>System-level pass/fail</li>
      <li>Final gate ก่อน ship</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AOI = สายตา, ICT = มัลติมิเตอร์, FCT = ทดสอบใช้งานจริง — ตรวจคนละเรื่อง ทดแทนกันไม่ได้</div>

<!-- Speaker: Framing ที่ง่ายที่สุดคือ visual → electrical → functional — ลำดับนี้คือ sequence ที่ใช้บนสายการผลิตจริง -->

---

## AOI vs ICT vs FCT: เปรียบรายละเอียดทุก Dimension

<p class="subhead">แต่ละ method มีต้นทุน ความเร็ว และ coverage ต่างกัน — ต้องเลือกให้ตรงกับ product risk</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep7-testing-strategy-1.png" alt="4-panel comparison of AOI, ICT bed-of-nails, ICT flying probe, and FCT testing methods">
<figcaption>Source: NotebookLM · PCB Testing Strategy Guide — defect types, coverage, speed, and cost per method</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AOI วิ่งเร็วที่สุด, ICT bed-of-nails ถูกที่สุดต่อ unit ใน high-volume, FCT แพงที่สุดแต่ตรวจสิ่งที่คนอื่นตรวจไม่ได้</div>

<!-- Speaker: ชี้ที่ coverage column — AOI ไม่มี electrical coverage, ICT ไม่มี firmware coverage, FCT ไม่มี component-level resolution -->

---

## ICT Fixture: Bed-of-Nails vs Flying Probe

<p class="subhead">ทั้งสอง fixture ให้ electrical structural coverage ใกล้เคียงกัน — ต่างกันที่ speed, cost, และ flexibility</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Bed-of-Nails panel -->
  <rect x="40" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="40" y="20" width="490" height="52" rx="12" fill="var(--accent)" opacity=".10"/>
  <text x="285" y="51" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Bed-of-Nails ICT</text>
  <!-- pogo pin icons -->
  <line x1="120" y1="90" x2="120" y2="130" stroke="var(--accent)" stroke-width="3"/>
  <circle cx="120" cy="135" r="5" fill="var(--accent)"/>
  <line x1="160" y1="90" x2="160" y2="120" stroke="var(--accent)" stroke-width="3"/>
  <circle cx="160" cy="125" r="5" fill="var(--accent)"/>
  <line x1="200" y1="90" x2="200" y2="130" stroke="var(--accent)" stroke-width="3"/>
  <circle cx="200" cy="135" r="5" fill="var(--accent)"/>
  <line x1="240" y1="90" x2="240" y2="115" stroke="var(--accent)" stroke-width="3"/>
  <circle cx="240" cy="120" r="5" fill="var(--accent)"/>
  <line x1="280" y1="90" x2="280" y2="128" stroke="var(--accent)" stroke-width="3"/>
  <circle cx="280" cy="133" r="5" fill="var(--accent)"/>
  <text x="285" y="165" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Pogo pins contact all points simultaneously</text>
  <text x="80" y="200" font-size="13" fill="var(--ink)" font-family="system-ui">Speed</text>
  <text x="220" y="200" font-size="13" fill="var(--success)" font-weight="700" font-family="system-ui">15–60 sec / board</text>
  <text x="80" y="228" font-size="13" fill="var(--ink)" font-family="system-ui">Fixture cost</text>
  <text x="220" y="228" font-size="13" fill="var(--warning)" font-weight="700" font-family="system-ui">$5k–50k NRE</text>
  <text x="80" y="256" font-size="13" fill="var(--ink)" font-family="system-ui">Best for</text>
  <text x="220" y="256" font-size="13" fill="var(--ink-dim)" font-family="system-ui">&gt;1,000 units/month</text>
  <text x="80" y="284" font-size="13" fill="var(--ink)" font-family="system-ui">Design change</text>
  <text x="220" y="284" font-size="13" fill="var(--danger)" font-weight="700" font-family="system-ui">New fixture required</text>
  <text x="80" y="312" font-size="13" fill="var(--ink)" font-family="system-ui">BGA joints</text>
  <text x="220" y="312" font-size="13" fill="var(--danger)" font-weight="700" font-family="system-ui">ตรวจไม่ได้</text>
  <!-- Flying Probe panel -->
  <rect x="570" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="570" y="20" width="490" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="815" y="51" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Flying Probe</text>
  <!-- robot arm icon simplified -->
  <rect x="770" y="85" width="90" height="10" rx="4" fill="var(--muted)"/>
  <rect x="850" y="85" width="10" height="30" rx="4" fill="var(--muted)"/>
  <circle cx="855" cy="120" r="8" fill="var(--muted)"/>
  <text x="815" y="155" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Sequential robotic probe movement</text>
  <text x="610" y="200" font-size="13" fill="var(--ink)" font-family="system-ui">Speed</text>
  <text x="750" y="200" font-size="13" fill="var(--warning)" font-weight="700" font-family="system-ui">2–10 min / board</text>
  <text x="610" y="228" font-size="13" fill="var(--ink)" font-family="system-ui">Fixture cost</text>
  <text x="750" y="228" font-size="13" fill="var(--success)" font-weight="700" font-family="system-ui">$0 (program only)</text>
  <text x="610" y="256" font-size="13" fill="var(--ink)" font-family="system-ui">Best for</text>
  <text x="750" y="256" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Prototype / &lt;500 units/month</text>
  <text x="610" y="284" font-size="13" fill="var(--ink)" font-family="system-ui">Design change</text>
  <text x="750" y="284" font-size="13" fill="var(--success)" font-weight="700" font-family="system-ui">Re-program เท่านั้น</text>
  <text x="610" y="312" font-size="13" fill="var(--ink)" font-family="system-ui">BGA joints</text>
  <text x="750" y="312" font-size="13" fill="var(--danger)" font-weight="700" font-family="system-ui">ตรวจไม่ได้เช่นกัน</text>
  <!-- VS badge -->
  <circle cx="550" cy="180" r="28" fill="var(--accent)"/>
  <text x="550" y="185" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Volume &gt; 1,000 units/month → bed-of-nails คุ้มค่ากว่าภายใน 2–3 เดือน; volume ต่ำกว่า → flying probe ไม่ต้องลงทุน fixture</div>

<!-- Speaker: Breakeven ขึ้นกับ fixture cost หาร per-unit time saving — EMS tier-1 จะ recommend migration timing ให้ -->

---

## FCT: Functional Circuit Test — Black-Box Final Gate

<p class="subhead">Power up จริง ส่ง stimulus — ตรวจสิ่งที่ AOI และ ICT มองไม่เห็นเลย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">FCT Fixture Components</p>
    <h3>Hardware ของ Test Station</h3>
    <ul>
      <li>Mechanical: clamshell / pneumatic / inline</li>
      <li>Connect: pogo pin, edge connector, high-cycle cable</li>
      <li>Instruments: power supply, signal gen, oscilloscope, DAQ</li>
      <li>Comms: UART, SPI, I2C, CAN, Ethernet</li>
      <li>DUT PSU พร้อม overcurrent protection</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Defects FCT จับได้ที่ ICT พลาด</p>
    <h3>System-Level Failures</h3>
    <ul>
      <li>Firmware bug — bootloader ไม่ boot</li>
      <li>System crash under max load</li>
      <li>ADC calibration drift / ADC offset</li>
      <li>I2C / SPI protocol failure</li>
      <li>LED สีผิด / speaker distortion</li>
      <li>Component overtemp under normal load</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FCT คือ test เดียวที่ตรวจ firmware + hardware interaction ได้ — OEM ต้องเขียน test script เอง ไม่ใช่ leave ให้ EMS ทำคนเดียว</div>

<!-- Speaker: FCT test script quality = FCT coverage quality — EMS ที่ดีจะ review script กับ OEM ก่อน production freeze -->

---

## Layered Strategy: ทำไมต้องทำตาม AOI → ICT → FCT

<p class="subhead">แต่ละชั้นกรอง defect ที่ถูกกว่าออก — ชั้นถัดไปเจอแต่ defect ที่ซับซ้อนขึ้น</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep7-testing-strategy-2.png" alt="Layered PCBA testing strategy flow showing AOI to ICT to FCT with defect escape rates and cost of failure at each stage">
<figcaption>Source: NotebookLM · PCBA Layered Testing Strategy — cascading risk-reduction with defect escape rate per stage</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Layered AOI + ICT + FCT → 97–99%+ coverage; ICT เดียวได้แค่ 70–90% — แต่ละชั้นที่ขาดไปคือ risk ที่หลุดถึง field</div>

<!-- Speaker: ชี้ที่ cost-of-failure bar — ค่าแก้ defect ในมือ end user สูงกว่าในสาย 100x -->

---

## Cost & ROI: เลือก Test Method ให้ตรงกับ Volume

<p class="subhead">ไม่มี one-size-fits-all — ROI ขึ้นกับ volume, product complexity, และ risk profile</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">High Volume — stable design</p>
    <h3>AOI + ICT Bed-of-Nails + FCT</h3>
    <p>AOI machine $30k–150k · ICT fixture $5k–50k · FCT station $10k–100k</p>
    <p>Per-unit cost ต่ำมากเมื่อ amortize — เหมาะ &gt;1,000 units/month</p>
    <p>Coverage: 97–99%+ · Speed: 4 brd/min (ICT)</p>
  </div>
  <div class="card warning">
    <p class="label">Low Volume / Prototype — changing design</p>
    <h3>AOI + Flying Probe + FCT</h3>
    <p>AOI machine $30k–150k · Flying probe $0 fixture · FCT station $10k–100k</p>
    <p>Per-unit cost สูงกว่า ICT 5–10x แต่ไม่ต้องลงทุน fixture</p>
    <p>Coverage: 95–97% · Speed: 2–10 min/brd (flying probe)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Migration trigger: volume &gt;500 units/month ต่อเนื่อง 2+ เดือน → plan migrate flying probe → ICT bed-of-nails ก่อนเกิด bottleneck</div>

<!-- Speaker: FCT station redundancy สำคัญเสมอ — single station = single point of failure ที่หยุด production ทันที -->

---

## Key Takeaways: Testing Strategy in EMS

<p class="subhead">สิ่งที่ต้องถามก่อน sign contract กับ EMS ทุกเจ้า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Green Flags — EMS ที่ดี</p>
    <h3>สัญญาณที่ควรเห็น</h3>
    <ul>
      <li>ออกแบบ test strategy ก่อน production freeze</li>
      <li>มี AOI ทุก SMT line ไม่ skip</li>
      <li>ICT coverage report ระบุ "escaped nets" ชัดเจน</li>
      <li>FCT มี redundant station (&gt;1)</li>
      <li>Review FCT script กับ OEM ก่อน production</li>
      <li>AOI reject ทุกใบมี human confirm ก่อน scrap</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Red Flags — ระวัง</p>
    <h3>สัญญาณที่ควรระวัง</h3>
    <ul>
      <li>"เราทำ AOI ก็พอแล้ว" — ไม่มี ICT</li>
      <li>FCT เดียว ไม่มี backup station</li>
      <li>Test script ไม่ sync กับ firmware version</li>
      <li>AOI auto-scrap โดยไม่ human confirm</li>
      <li>ไม่รู้ว่า ICT coverage ของ board คือเท่าไหร่</li>
      <li>ไม่มี test log ต่อ serial number</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP8 → Supply Chain & Component Sourcing — EMS manage BOM, AVL, last-time-buy, และ counterfeit risk อย่างไรใน volatile market</div>

<!-- Speaker: Test log ต่อ serial number คือ traceability พื้นฐาน — เชื่อมกับ IPC-1782 ที่พูดถึงใน EP6 -->
