---
marp: true
theme: default
paginate: true
title: "เจาะลึก EMS Factory EP4: SMT Line Workflow"
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

# EMS Factory EP4: SMT Line Workflow

<p class="tag">6 stations, 1 sequence — 60–80% of all defects decided before first component is placed</p>

<!-- Speaker: EP4 maps every SMT station from stencil printer to X-ray, with the key process parameters and failure modes at each stage. -->

---

## SMT Line: 6 Stations ต่อกันบน Conveyor

<p class="subhead">ทุก defect มี origin station — trace กลับได้ถ้ารู้ว่าแต่ละ station ทำอะไร</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Station boxes -->
  <!-- S1 Stencil Printer -->
  <rect x="20" y="80" width="150" height="70" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="95" y="110" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Stencil</text>
  <text x="95" y="128" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Printer</text>
  <text x="95" y="146" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">60–80% defects here</text>
  <!-- Arrow -->
  <line x1="170" y1="115" x2="196" y2="115" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="202,115 190,109 190,121" fill="var(--muted)"/>
  <!-- S2 SPI -->
  <rect x="202" y="80" width="130" height="70" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="267" y="110" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">SPI</text>
  <text x="267" y="128" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">3D paste</text>
  <text x="267" y="144" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">inspection</text>
  <!-- Arrow -->
  <line x1="332" y1="115" x2="358" y2="115" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="364,115 352,109 352,121" fill="var(--muted)"/>
  <!-- S3 Pick & Place -->
  <rect x="364" y="80" width="140" height="70" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="434" y="108" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Pick &amp;</text>
  <text x="434" y="126" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Place</text>
  <text x="434" y="144" font-size="10" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">±15–35 µm accuracy</text>
  <!-- Arrow -->
  <line x1="504" y1="115" x2="530" y2="115" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="536,115 524,109 524,121" fill="var(--muted)"/>
  <!-- S4 Reflow -->
  <rect x="536" y="80" width="140" height="70" rx="10" fill="var(--soft-2)" stroke="var(--ink-dim)" stroke-width="2"/>
  <text x="606" y="108" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Reflow</text>
  <text x="606" y="126" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Oven</text>
  <text x="606" y="144" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SAC305 peak 240–250°C</text>
  <!-- Arrow -->
  <line x1="676" y1="115" x2="702" y2="115" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="708,115 696,109 696,121" fill="var(--muted)"/>
  <!-- S5 AOI -->
  <rect x="708" y="80" width="130" height="70" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="773" y="110" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AOI</text>
  <text x="773" y="128" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">surface defects</text>
  <text x="773" y="144" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">10–20s/board</text>
  <!-- Arrow -->
  <line x1="838" y1="115" x2="864" y2="115" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="870,115 858,109 858,121" fill="var(--muted)"/>
  <!-- S6 X-Ray -->
  <rect x="870" y="80" width="130" height="70" rx="10" fill="var(--soft)" stroke="var(--ink-dim)" stroke-width="1.5"/>
  <text x="935" y="110" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">X-Ray</text>
  <text x="935" y="128" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BGA/hidden joints</text>
  <text x="935" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">30–60s/board</text>
  <!-- "60-80% defects" callout arrow pointing to S1 -->
  <line x1="95" y1="150" x2="95" y2="195" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="20" y="196" width="150" height="36" rx="6" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <text x="95" y="212" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">60–80% of all SMT</text>
  <text x="95" y="228" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">defects originate here</text>
  <!-- Station numbers -->
  <text x="95" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S1</text>
  <text x="267" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S2</text>
  <text x="434" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S3</text>
  <text x="606" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S4</text>
  <text x="773" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S5</text>
  <text x="935" y="75" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S6</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Defect origin ≠ defect detection point — board ที่ผ่าน SPI ยังอาจมี latent defects จาก paste printing; AOI จะจับได้หลัง reflow เท่านั้น</div>

<!-- Speaker: The 6-station flow is a single-pass conveyor. Double-sided boards loop once for the second side. Defects compound — a small paste offset becomes a solder bridge after reflow. -->

---

## Stencil Printing + SPI: ต้นทางของ Yield

<p class="subhead">60–80% ของ SMT defects เกิดที่ stage นี้ — ทุก parameter ต้องอยู่ใน control</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Stencil Printing Parameters</p>
    <h3>4 Variables ที่ต้องควบคุม</h3>
    <p><b>Squeegee pressure:</b> 5–10 N/25mm — มากไป = scooping; น้อยไป = smearing</p>
    <p><b>Print speed:</b> 20–40 mm/s — เร็วเกิน = apertures ไม่เต็ม</p>
    <p><b>Angle:</b> 45–60° — ต่ำกว่า 45° = paste residue บน stencil</p>
    <p><b>Separation speed:</b> ≤ 1 mm/s — เร็วเกิน = paste pulling</p>
    <p style="margin-top:8px"><b>Area Ratio ≥ 0.66, Aspect Ratio ≥ 1.5</b> — ออกแบบ aperture ผิด = defects แน่นอน</p>
  </div>
  <div class="card warning">
    <p class="label">SPI — First Quality Gate</p>
    <h3>3D Paste Volume Inspection</h3>
    <p>วัด volume (%), height (µm), area coverage, alignment offset ทุก pad บน board</p>
    <p><b>Threshold:</b> 80–120% ของ nominal volume — เกิน = reject ก่อน placement</p>
    <p><b>Closed-loop feedback:</b> offset data → printer auto-correction → monitor drift real-time</p>
    <p><b>ROI สูงสุดใน SMT line:</b> catch defect ที่ SPI ถูกกว่า catch หลัง reflow 10–50x (ไม่ต้อง rework)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Area Ratio ≥ 0.66 คือ design rule ขั้นต่ำ — ถ้า aperture design ผิด SPI closed-loop แก้ไม่ได้; ต้องแก้ที่ stencil design ก่อน</div>

<!-- Speaker: The stencil parameters interact. You can't fix a bad area ratio with pressure adjustments — that's a hardware fix requiring a new stencil. SPI feedback only corrects drift, not structural stencil problems. -->

---

## Pick & Place: Speed vs Accuracy Trade-off

<p class="subhead">CPH บนกล่องเครื่อง ≠ CPH จริง — real-world efficiency ขึ้นกับ BOM complexity</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Machine Specifications</p>
    <h3>Key Specs ที่ต้องดูเวลา Evaluate</h3>
    <ul>
      <li><b>CPH (Chip shooter):</b> 115,000–200,000 — "optimum" conditions; real-world 50–70% ของนั้น</li>
      <li><b>Placement accuracy:</b> ±15–35 µm — ±25 µm สำหรับ 0201; ±15 µm สำหรับ 01005</li>
      <li><b>Vision system:</b> Laser + camera — correct X/Y/θ offset ก่อน placement</li>
      <li><b>Feeder types:</b> tape-and-reel, tray (BGA), stick — tray = CPH ลดลงมาก</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Yield Failure Modes</p>
    <h3>สิ่งที่ทำให้ P&P Yield ตก</h3>
    <ul>
      <li><b>Nozzle wear</b> → vacuum pickup ล้มเหลว → missing component</li>
      <li><b>Feeder jam</b> → component ไม่ advance → placement skip</li>
      <li><b>Vision calibration drift</b> → systematic placement offset → bridging</li>
      <li><b>Tape splice error</b> → wrong component at feeder position</li>
      <li><b>Component missing in reel</b> → empty pick → ghost placement</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> P&P yield ขึ้นกับ PM schedule ไม่ใช่แค่ machine spec — nozzle inspection, feeder cleaning, และ vision recalibration ต้องทำตาม interval ที่กำหนด</div>

<!-- Speaker: Machine specifications sell machines. Maintenance discipline keeps yield. A 200,000 CPH machine with worn nozzles underperforms a 80,000 CPH machine with proper PM. -->

---

## Reflow Profile: 4-Zone Thermal Engineering สำหรับ SAC305

<p class="subhead">แต่ละ zone มี failure mode ของตัวเอง — deviation ออกนอก range = specific defect ที่คาดเดาได้</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep4-smt-line-workflow-1.png" alt="SMT reflow soldering 4-zone thermal profile for SAC305: preheat ramp 1-3°C/s, soak 150-200°C 60-120s, reflow peak 240-250°C TAL 45-90s, cooling -2 to -4°C/s">
<figcaption>Source: NotebookLM · SAC305 4-zone reflow profile with key parameters and liquidus point at 217°C</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> TAL (Time Above Liquidus) 45–90s เป็น zone ที่ sensitive ที่สุด — สั้นเกิน = BGA voids; ยาวเกิน = brittle IMC layer; ต้องวัดด้วย thermocouple board จริง ไม่ใช่แค่ set oven temperature</div>

<!-- Speaker: The profile isn't just about peak temperature. TAL is often more critical — it determines whether solder has enough time to fully wet and degas, or too much time that creates thick intermetallic compounds. -->

---

## AOI vs X-Ray: Inspection Coverage Map

<p class="subhead">AOI เร็วแต่ตาบอด BGA — X-ray ช้าแต่เห็นทุก hidden joint; ต้องใช้ทั้งคู่</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">AOI — Automated Optical Inspection</p>
    <h3>Surface Defects: 10–20s/board</h3>
    <p><b>ตรวจได้:</b> missing component, polarity error, solder bridge, tombstone, component offset/rotation</p>
    <p><b>ตรวจไม่ได้:</b> hidden joints (BGA balls, QFN/LGA underside), internal voids</p>
    <p><b>AI-3D AOI:</b> ลด false positive ~70% เทียบกับ rule-based 2D — สำคัญมากเพราะ false positives เป็น operator fatigue</p>
    <p><b>ใช้:</b> 100% inline สำหรับทุก product class</p>
  </div>
  <div class="card">
    <p class="label">X-Ray (AXI) — Automated X-ray Inspection</p>
    <h3>Hidden Joints: 30–60s/board, 99% precision</h3>
    <p><b>ตรวจได้:</b> BGA void %, ball alignment/bridging, QFN underside, internal crack, hidden opens</p>
    <p><b>ตรวจไม่ได้:</b> surface color/appearance defects ที่ AOI เห็นดีกว่า</p>
    <p><b>IPC-7095C:</b> BGA void ≤ 25% per ball (Class 2/3) — void ≠ failure แต่ distribution สำคัญ</p>
    <p><b>ใช้:</b> 100% สำหรับ Class 3; sampling สำหรับ Class 1/2</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Board ที่ผ่าน AOI 100% แต่ไม่มี X-ray = ไม่รู้สถานะ BGA joints เลย — สำหรับ product ที่มี BGA ต้องมี X-ray capability ใน EMS ก่อน commit ไป production</div>

<!-- Speaker: This is a common audit question. Ask the EMS to show you their AOI false-call rate and X-ray sampling plan. A false-call rate above 2-3% means operator review time is wasted on non-defects. -->

---

## Common SMT Defects: Root Cause ทุก Defect Traceable กลับถึง Station

<p class="subhead">ทุก defect type มี fingerprint process parameter — ถ้า diagnose ถูก แก้ไขได้ที่ต้นเหตุ</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep4-smt-line-workflow-2.png" alt="SMT defect root cause guide: solder bridging from excessive squeegee pressure, insufficient solder from low area ratio, tombstone from high preheat ramp, BGA voids from short TAL, cold solder joints from low peak temperature">
<figcaption>Source: NotebookLM · SMT defect diagnostic guide — printing stage vs reflow stage root causes with process parameters</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Solder bridge → ดู stencil design + squeegee pressure; BGA void → ดู TAL + flux; Tombstone → ดู preheat ramp + pad symmetry — แต่ละ defect ชี้ไปที่ parameter เดียว ไม่ใช่ "ทั้งหมด"</div>

<!-- Speaker: Root cause mapping prevents the "adjust everything" trap. If you get tombstones, you don't need to touch paste viscosity — you need preheat ramp rate or pad balance. Systematic diagnosis saves weeks of trial-and-error. -->

---

## SPC และ FPY: วัด Health ของ SMT Line

<p class="subhead">World-class SMT: FPY > 99.5% — ต่ำกว่านี้บ่งบอกว่ามี systematic process issue</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Key SPC Control Charts</p>
    <h3>3 Charts ที่ SMT Engineer ต้องดูทุกวัน</h3>
    <ul>
      <li><b>SPI volume Cp/Cpk:</b> target Cpk ≥ 1.33 (≈ 64 ppm defect rate) — track per pad type</li>
      <li><b>P&P placement offset X/Y:</b> detect machine alignment drift ก่อนที่ offset จะ compound</li>
      <li><b>Reflow peak temperature trend:</b> detect oven element degradation ก่อน go out-of-spec</li>
    </ul>
    <p style="margin-top:8px; font-size:12px; color:var(--muted)">Control chart คือ early warning — ไม่ใช่ reactive tool หลัง defects เกิดแล้ว</p>
  </div>
  <div class="card success">
    <p class="label">First Pass Yield Benchmarks</p>
    <h3>FPY = % ผ่านโดยไม่ต้อง Rework</h3>
    <ul>
      <li><b>&gt; 99.5%:</b> World-class SMT operation</li>
      <li><b>99–99.5%:</b> Good — ดูแล PM schedule + SPI data</li>
      <li><b>95–99%:</b> Average — มี systematic issue ที่ต้องหา</li>
      <li><b>&lt; 95%:</b> ต้องการ process audit เร่งด่วน</li>
    </ul>
    <p style="margin-top:8px; font-size:12px; color:var(--muted)">FPY ต่ำ = rework cost + cycle time เพิ่ม + risk ว่า rework เอง introduce defects ใหม่</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถาม EMS ว่า FPY เท่าไหร่และ track ด้วยอะไร — ถ้าไม่มี SPC data ตอบได้ทันที หมายความว่า process ไม่อยู่ใน statistical control</div>

<!-- Speaker: FPY is the single number that summarizes SMT line health. But the real value is the SPC data behind it — which tells you WHERE the yield is being lost and whether it's getting worse. -->

---

## Key Takeaways: SMT Line Workflow

<p class="subhead">ทุก station มี lever และ failure mode ของตัวเอง — control ที่ต้นทาง ไม่ใช่แก้ที่ปลายน้ำ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Process Parameters</p>
    <h3>Numbers ที่ต้องจำ</h3>
    <ul>
      <li>60–80% ของ SMT defects → stencil printing stage</li>
      <li>Area Ratio ≥ 0.66, Aspect Ratio ≥ 1.5 → stencil design rule</li>
      <li>Squeegee: 5–10 N/25mm, 20–40 mm/s, 45–60°</li>
      <li>SAC305: peak 240–250°C, TAL 45–90s, liquidus 217°C</li>
      <li>Preheat ramp &lt; 2°C/s → prevent ceramic cracking</li>
      <li>Cooling -2 to -4°C/s → fine-grain microstructure</li>
      <li>AOI: 10–20s/board surface; X-ray: 30–60s/board hidden joints</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">EMS Audit Questions</p>
    <h3>สิ่งที่ต้องถาม EMS</h3>
    <ul>
      <li>SPI Cpk data ต่อ pad type คือเท่าไหร่?</li>
      <li>AOI false-call rate คือเท่าไหร่?</li>
      <li>Reflow profile validate ด้วย thermocouple board ไหม?</li>
      <li>FPY ของ line นี้คือเท่าไหร่ และ trend อย่างไร?</li>
      <li>มี X-ray สำหรับ BGA boards ไหม? Sampling plan คืออะไร?</li>
      <li>P&P nozzle PM interval คือกี่ชั่วโมง/กี่ placements?</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP5 จะ deep-dive stencil engineering methodology, SPC implementation, และ reflow profile validation — จาก concept ไปสู่ actual EMS audit evidence</div>

<!-- Speaker: These audit questions are the difference between a supplier visit and a supplier qualification. Numbers and trends tell you whether the process is in control — not whether the certificates are current. -->
