---
marp: true
theme: default
paginate: true
title: "EMS Factory EP5: DFM / DFT"
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

# EMS Factory EP5: DFM / DFT

<p class="tag">Design for Manufacturability & Testability — แก้ปัญหาก่อนถึง production line</p>

<!-- Speaker: DFM/DFT คือ upstream insurance — ทุก DFM rule มีคนจ่ายต้นทุนให้มาก่อน -->

---

## DFM vs DFT: สองด้านของ Design Quality Gate

<p class="subhead">DFM ถามว่า "ผลิตได้ไหม" — DFT ถามว่า "test ได้ครบไหม" ทั้งสองต้องทำ parallel ตั้งแต่ layout</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: DFM -->
  <rect x="40" y="20" width="480" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="20" width="480" height="60" rx="12" fill="var(--warning-wash)"/>
  <rect x="40" y="68" width="480" height="12" fill="var(--warning-wash)"/>
  <text x="280" y="57" font-size="19" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">DFM — Design for Manufacturability</text>
  <text x="80" y="115" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Goal:</text>
  <text x="160" y="115" font-size="14" fill="var(--ink-dim)" font-family="system-ui">PCB ผลิตได้โดย manufacturing equipment</text>
  <text x="80" y="148" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Covers:</text>
  <text x="80" y="175" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Component spacing &amp; keepout zones</text>
  <text x="80" y="198" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Fiducial marks (global + local)</text>
  <text x="80" y="221" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Panelization: V-score / mouse bites</text>
  <text x="80" y="244" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Thermal relief spokes</text>
  <text x="80" y="267" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Solder paste Area Ratio ≥ 0.66</text>
  <text x="80" y="318" font-size="13" fill="var(--warning-ink)" font-weight="600" font-family="system-ui">Reviewed by: EMS DFM engineer + software scan</text>

  <!-- VS bubble -->
  <circle cx="550" cy="190" r="32" fill="var(--accent)"/>
  <text x="550" y="195" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>

  <!-- Right: DFT -->
  <rect x="580" y="20" width="480" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="580" y="20" width="480" height="60" rx="12" fill="var(--accent-wash)"/>
  <rect x="580" y="68" width="480" height="12" fill="var(--accent-wash)"/>
  <text x="820" y="57" font-size="19" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">DFT — Design for Testability</text>
  <text x="620" y="115" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Goal:</text>
  <text x="700" y="115" font-size="14" fill="var(--ink-dim)" font-family="system-ui">PCB ให้ test equipment เข้าถึงได้ครบ</text>
  <text x="620" y="148" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Covers:</text>
  <text x="620" y="175" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Test points: ø ≥ 1mm, spacing ≥ 2.5mm</text>
  <text x="620" y="198" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• ICT / Flying probe access</text>
  <text x="620" y="221" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• JTAG TAP for BGA hidden joints</text>
  <text x="620" y="244" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Functional test stimulus/response</text>
  <text x="620" y="267" font-size="13" fill="var(--ink-dim)" font-family="system-ui">• Coverage target: &gt; 95% overall</text>
  <text x="620" y="318" font-size="13" fill="var(--accent-deep)" font-weight="600" font-family="system-ui">Reviewed by: EMS test engineer + JTAG coverage tool</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DFM = ผลิตได้; DFT = test ได้ — ขาดตัวใดตัวหนึ่ง board ผ่าน schematic แต่ fail ที่ production</div>

<!-- Speaker: EMS review ทั้งสองก่อน production freeze — designer ที่ส่ง design ไม่มี fiducial หรือไม่มี test point จะถูก reject -->

---

## DFM Rules: Manufacturing Readiness Checklist

<p class="subhead">6 กฎที่ EMS ตรวจก่อน accept Gerber file — ผิดกฎใดกฎหนึ่ง = respin</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep5-dfm-dft-1.png" alt="PCB DFM checklist: thermal relief, panelization V-score, trace edge spacing, fiducials, component spacing, test point access">
<figcaption>Source: NotebookLM · Manufacturing Readiness Guide — 6 DFM rules ที่มีผลต่อ assembly yield โดยตรง</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Fiducials ขาด = pick-and-place error; thermal relief ผิด = cold joint; V-score clearance &lt; 15 mils = copper short ตอน snap</div>

<!-- Speaker: Image แสดง 6 panel — เน้น thermal relief spoke (top-left) และ test point access (bottom-right) ที่ designerมักลืม -->

---

## Component Spacing, Fiducials, Panelization: ตัวเลขที่ต้องรู้

<p class="subhead">กฎเหล่านี้มาจาก manufacturing equipment spec — ไม่ใช่ความชอบของ engineer</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Component Spacing</p>
    <h3>Keepout Zones</h3>
    <ul>
      <li>Board edge: ≥ 3mm (tall: 5mm)</li>
      <li>SMT passive-to-passive: ≥ 0.2mm</li>
      <li>IC package gap: ≥ 0.5mm</li>
      <li>Orient same-type parallel → same reflow profile → ลด tombstoning</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Fiducials</p>
    <h3>Optical Alignment Targets</h3>
    <ul>
      <li>Global: ≥ 3 จุด, ไม่ symmetric (บังคับ orientation)</li>
      <li>Local: ใกล้ BGA/QFP ที่ accuracy ≤ ±35µm</li>
      <li>Size: copper circle ø 1mm ± 0.05mm</li>
      <li>Clearance: solder mask radius 3mm รอบ</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Panelization</p>
    <h3>V-Score &amp; Mouse Bites</h3>
    <ul>
      <li>V-score: cut 1/3 depth both sides; straight line เท่านั้น</li>
      <li>Mouse bites: drill ø 0.8-1.0mm, pitch 1.5-2.0mm</li>
      <li>Copper clearance จาก V-score: ≥ 0.38mm (15 mils)</li>
      <li>Thermal relief spokes: width 0.25-0.5mm</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ขอ "DFM capability document" จาก EMS ก่อน layout — minimum rules ต่างกันระหว่าง vendor</div>

<!-- Speaker: 15 mils V-score clearance คือตัวเลขที่มาจาก blade tolerance + copper etch variation — ไม่ใช่ round number สุ่ม -->

---

## PCB Test Methods: เลือกให้ถูก Coverage vs Cost

<p class="subhead">ICT testing accounts for 25-30% of total production cost — เลือก method ผิดกระทบ unit economics ทั้ง line</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep5-dfm-dft-2.png" alt="PCB test method comparison: ICT bed-of-nails, flying probe, JTAG boundary scan, functional test — coverage, cost, speed">
<figcaption>Source: NotebookLM · PCB Test Method Strategic Comparison — coverage %, fixture cost, throughput ของแต่ละ method</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> JTAG คือทางเดียวที่ test BGA hidden joints — board ที่มี BGA โดยไม่มี JTAG TAP มี untestable zone อยู่ใต้ package</div>

<!-- Speaker: Key insight จาก image — JTAG เป็น "no fixture" แต่ coverage 90-100% สำหรับ JTAG-enabled nets; limitation คือ analog component และ non-JTAG IC ยังต้องใช้ ICT/flying probe ควบ -->

---

## Test Point Design: ตัวเลข Spec ที่ EMS ต้องการ

<p class="subhead">Test point ผิด spec = ICT fixture ทำไม่ได้ = เพิ่ม cost หรือ coverage หายไป</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Physical Specs</p>
    <h3>Size &amp; Spacing</h3>
    <ul>
      <li>Diameter: ≥ 1.0mm (40 mils) — pad หรือ untented via</li>
      <li>ICT bed-of-nails: center-to-center ≥ 2.5mm (100 mils)</li>
      <li>Flying probe: center-to-center ≥ 2.0mm (80 mils)</li>
      <li>Label: TP1, TP2, … ใน design files + send netlist ให้ EMS</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Placement Rules</p>
    <h3>ตำแหน่งและ Signal Integrity</h3>
    <ul>
      <li>Prefer bottom side — ลด fixture complexity</li>
      <li>หลีกเลี่ยงใกล้ tall component — probe ขวาง</li>
      <li>High-impedance nodes: ห่าง ≥ 5mm (200 mils) — probe capacitance บิด signal</li>
      <li>High-speed nets: หลีกเลี่ยง test point เว้นแต่จำเป็น</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Test point บน high-impedance node ระยะ &lt; 5mm ทำให้วัดค่าผิด — ห่างออกไปหรือ isolate ด้วย resistor series</div>

<!-- Speaker: Untented via คือ via ที่เปิด solder mask ทั้งสองด้าน — ถ้า tent ทับ probe จะลื่นและ miss contact -->

---

## Layered Test Strategy: ไม่มี Silver Bullet

<p class="subhead">Test method เดียวไม่ cover ได้ครบ — EMS tier-1 ใช้ layered approach เพื่อ &gt; 95% overall coverage</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Stage boxes -->
  <!-- AOI -->
  <rect x="30" y="100" width="190" height="160" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="125" y="140" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AOI</text>
  <text x="125" y="162" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Surface defects</text>
  <text x="125" y="182" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">solder bridges</text>
  <text x="125" y="202" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">tombstoning</text>
  <text x="125" y="224" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui" font-weight="600">10-20s/board</text>

  <!-- Arrow 1 -->
  <polygon points="234,178 254,168 254,188" fill="var(--muted)"/>
  <line x1="220" y1="178" x2="254" y2="178" stroke="var(--muted)" stroke-width="2"/>

  <!-- ICT/Flying -->
  <rect x="258" y="80" width="210" height="200" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="363" y="118" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">ICT / Flying Probe</text>
  <text x="363" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Component-level</text>
  <text x="363" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">shorts, opens</text>
  <text x="363" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">missing / wrong value</text>
  <text x="363" y="202" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Coverage: 80-95%</text>
  <text x="363" y="242" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="600">fixture or probe</text>

  <!-- Arrow 2 -->
  <polygon points="482,178 502,168 502,188" fill="var(--muted)"/>
  <line x1="468" y1="178" x2="502" y2="178" stroke="var(--muted)" stroke-width="2"/>

  <!-- JTAG -->
  <rect x="506" y="60" width="210" height="240" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="611" y="98" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">JTAG / Boundary Scan</text>
  <text x="611" y="122" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BGA hidden joints</text>
  <text x="611" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">fine-pitch &lt; 0.5mm</text>
  <text x="611" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">IEEE 1149.1 TAP</text>
  <text x="611" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">TDI/TDO/TMS/TCK</text>
  <text x="611" y="202" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Coverage: 90-100%</text>
  <text x="611" y="270" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">on JTAG-enabled nets</text>

  <!-- Arrow 3 -->
  <polygon points="730,178 750,168 750,188" fill="var(--muted)"/>
  <line x1="716" y1="178" x2="750" y2="178" stroke="var(--muted)" stroke-width="2"/>

  <!-- Functional Test -->
  <rect x="754" y="100" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--ink-dim)" stroke-width="2"/>
  <text x="859" y="140" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Functional Test</text>
  <text x="859" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">System-level</text>
  <text x="859" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Power-up + stimulus</text>
  <text x="859" y="202" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">validates end-to-end</text>
  <text x="859" y="224" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-weight="600">system test script</text>

  <!-- Target -->
  <rect x="990" y="140" width="100" height="76" rx="10" fill="var(--success)" opacity=".15" stroke="var(--success)" stroke-width="1.5"/>
  <text x="1040" y="172" font-size="22" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">&gt;95%</text>
  <text x="1040" y="196" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">overall</text>
  <polygon points="964,178 984,168 984,188" fill="var(--success)"/>
  <line x1="964" y1="178" x2="984" y2="178" stroke="var(--success)" stroke-width="2"/>

</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Escaped nets" = net ที่ไม่มี JTAG cell และไม่มี test point — ต้องระบุใน coverage report และ accept risk อย่างรู้เรื่อง</div>

<!-- Speaker: 100% coverage บน power net และ critical signal เป็น hard requirement; remaining net ทำ best-effort -->

---

## Key Takeaways: DFM / DFT

<p class="subhead">สิ่งที่ engineer ต้องรู้ก่อนส่ง design ให้ EMS</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">DFM Numbers ที่ต้องจำ</p>
    <h3>Manufacturing Rules</h3>
    <ul>
      <li>Board edge clearance: ≥ 3mm</li>
      <li>Fiducials: ≥ 3 global + local ที่ fine-pitch IC</li>
      <li>V-score copper clearance: ≥ 15 mils (0.38mm)</li>
      <li>Area Ratio ≥ 0.66, Aspect Ratio ≥ 1.5</li>
      <li>Thermal spoke width: 0.25-0.5mm</li>
      <li>ขอ DFM capability doc ก่อน layout เสมอ</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">DFT Numbers ที่ต้องจำ</p>
    <h3>Testability Rules</h3>
    <ul>
      <li>Test point ø: ≥ 1.0mm (40 mils), untented via</li>
      <li>ICT spacing: ≥ 2.5mm; Flying probe: ≥ 2.0mm</li>
      <li>High-impedance clearance: ≥ 5mm</li>
      <li>BGA board: ต้องมี JTAG TAP หรือ accept blind spot</li>
      <li>Coverage target: &gt; 95% overall, 100% power nets</li>
      <li>Cost of defect: design 1× → field return 1000×</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP6 → QMS &amp; Traceability: ระบบที่ทำให้ EMS รู้ว่าทุก board ผ่าน process อะไร ด้วย component lot ไหน</div>

<!-- Speaker: DFM/DFT review ก่อน production freeze ราคา 1× — ถ้าปล่อยให้หลุดไปถึง field จะจ่าย 1000× ทั้ง warranty + brand damage -->
