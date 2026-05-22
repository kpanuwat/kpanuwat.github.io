---
marp: true
theme: default
paginate: true
title: "EMS Factory EP10: Manufacturing Yield Optimization"
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
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
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

# EMS Factory EP10: Manufacturing Yield Optimization

<p class="tag">SPC · FPY · OEE — 3 metrics ที่ปรับปรุง yield อย่างเป็นระบบ</p>

<!-- Speaker: ทำไม "quality ดี" โดยไม่มีตัวเลขสนับสนุนไม่มีความหมาย -->

---

## 3 Metric ที่ทำงานร่วมกัน — ไม่ใช่แยกอิสระ

<p class="subhead">FPY วัดคุณภาพที่ step, OEE วัด machine productivity รวม, SPC เป็น early warning ก่อนเกิด defect</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Quality at Step</p>
    <h3>FPY / RTY</h3>
    <p><b>First Pass Yield</b>: % ที่ผ่านโดยไม่ต้อง rework ในครั้งแรก</p>
    <p><b>RTY</b>: compound yield ตลอดทุก step — 5 steps × 95% = เพียง 77%</p>
    <p>Formula: (Units - Defective) / Units × 100%</p>
  </div>
  <div class="card warning">
    <p class="label">Machine Productivity</p>
    <h3>OEE</h3>
    <p><b>OEE = Availability × Performance × Quality</b></p>
    <p>85% = world-class; 60% = typical; 40% = starting point</p>
    <p>วัด 3 loss type: downtime, speed, defects</p>
  </div>
  <div class="card success">
    <p class="label">Early Warning System</p>
    <h3>SPC</h3>
    <p><b>Statistical Process Control</b>: ตรวจ parameter drift ก่อน defect เกิด</p>
    <p>X-bar R chart สำหรับ solder paste volume, placement offset, reflow temp</p>
    <p>ไม่ใช่ inspection — คือ prevention</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OEE ชี้ว่าปัญหาอยู่ที่ไหน → FPY/RTY ระบุ step → SPC ระบุ parameter — ทำงานเป็น closed-loop</div>

<!-- Speaker: สามตัวนี้ต้อง deploy ร่วมกัน ใช้ตัวเดียวไม่เห็นภาพรวม -->

---

## RTY คือตัวเลขที่ซ่อนปัญหา — FPY 95% ต่อ step ไม่ได้แปลว่าดี

<p class="subhead">5 steps × 95% FPY → RTY เพียง 77.4% — 22.6% ของ board ต้อง rework หรือ scrap</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep10-yield-optimization-1.png" alt="FPY vs RTY compounding yield trap: 5-stage PCBA process each at 95% FPY compounds to 77.4% RTY with defect types per stage">
<figcaption>Source: NotebookLM · The Compounding Manufacturing Yield Trap — 5-stage PCBA cascade and hidden rework cost</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ขอ per-step FPY จาก EMS ไม่ใช่แค่ end-of-line defect rate — ตัวหลังซ่อน rework ที่เกิดใน intermediate step</div>

<!-- Speaker: Six Sigma benchmark = 3.4 DPMO = 99.99966% FPY ต่อ step -->

---

## OEE: Availability × Performance × Quality

<p class="subhead">85% คือ world-class สำหรับ discrete manufacturing — แต่ละ component บอก loss ต่างกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- OEE Formula bar -->
  <rect x="30" y="20" width="1040" height="50" rx="10" fill="var(--soft)"/>
  <text x="550" y="51" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">OEE = Availability × Performance × Quality</text>
  <!-- Availability -->
  <rect x="30" y="90" width="320" height="220" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="30" y="90" width="320" height="44" rx="12" fill="var(--accent)" opacity=".9"/>
  <text x="190" y="117" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Availability</text>
  <text x="50" y="158" font-size="13" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">Run Time / Planned Time</text>
  <text x="50" y="180" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Equipment breakdown</text>
  <text x="50" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Changeover / setup</text>
  <text x="50" y="220" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Planned maintenance</text>
  <rect x="50" y="240" width="280" height="1.5" fill="var(--accent)" opacity=".4"/>
  <text x="50" y="264" font-size="12" fill="var(--accent)" font-family="system-ui" font-weight="600">Example: 8h shift, 1h down = 87.5%</text>
  <text x="50" y="284" font-size="12" fill="var(--muted)" font-family="system-ui">Track: MTTR, MTBF, changeover time</text>
  <!-- Performance -->
  <rect x="390" y="90" width="320" height="220" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="390" y="90" width="320" height="44" rx="12" fill="var(--warning)" opacity=".9"/>
  <text x="550" y="117" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Performance</text>
  <text x="410" y="158" font-size="13" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">(Ideal CT × Count) / Run Time</text>
  <text x="410" y="180" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Micro-stops (&lt;5 min)</text>
  <text x="410" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Speed reduction</text>
  <text x="410" y="220" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Warm-up / idle</text>
  <rect x="410" y="240" width="280" height="1.5" fill="var(--warning)" opacity=".4"/>
  <text x="410" y="264" font-size="12" fill="var(--warning-ink)" font-family="system-ui" font-weight="600">Example: running 90% of ideal = 90%</text>
  <text x="410" y="284" font-size="12" fill="var(--muted)" font-family="system-ui">Track: actual vs ideal cycle time</text>
  <!-- Quality -->
  <rect x="750" y="90" width="320" height="220" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="750" y="90" width="320" height="44" rx="12" fill="var(--success)" opacity=".9"/>
  <text x="910" y="117" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Quality</text>
  <text x="770" y="158" font-size="13" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Good Count / Total Count</text>
  <text x="770" y="180" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Defects / scrap</text>
  <text x="770" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Loss: Rework (still counts)</text>
  <text x="770" y="220" font-size="12" fill="var(--ink-dim)" font-family="system-ui">= FPY fed into OEE</text>
  <rect x="770" y="240" width="280" height="1.5" fill="var(--success)" opacity=".4"/>
  <text x="770" y="264" font-size="12" fill="var(--success-ink)" font-family="system-ui" font-weight="600">Example: 98% good boards = 98%</text>
  <text x="770" y="284" font-size="12" fill="var(--muted)" font-family="system-ui">= direct link to FPY metric</text>
  <!-- Result -->
  <rect x="30" y="330" width="1040" height="38" rx="8" fill="var(--ink)" opacity=".06"/>
  <text x="190" y="354" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">87.5%</text>
  <text x="550" y="354" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">× 90%</text>
  <text x="910" y="354" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">× 98% = OEE 77.2%</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 85% = world-class; 60% = typical แต่ยังมี room ปรับปรุง; OEE 77% ในตัวอย่างยังต่ำกว่า world-class</div>

<!-- Speaker: OEE เดียวไม่บอกว่าปัญหาคืออะไร แต่บอกว่ามีปัญหา -->

---

## SPC Control Chart: จับ Drift ก่อนที่จะกลายเป็น Defect

<p class="subhead">X-bar R chart ตรวจจับ 3 signal — จุดนอก limit, 7 จุดด้านเดียว, 7 จุด trend</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- X-bar chart area -->
  <rect x="30" y="20" width="680" height="220" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="370" y="44" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">X-bar Chart (Process Mean)</text>
  <!-- UCL line -->
  <line x1="50" y1="70" x2="695" y2="70" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <text x="705" y="74" font-size="11" fill="var(--danger)" font-family="system-ui">UCL</text>
  <!-- Center line -->
  <line x1="50" y1="130" x2="695" y2="130" stroke="var(--accent)" stroke-width="2"/>
  <text x="705" y="134" font-size="11" fill="var(--accent)" font-family="system-ui">CL</text>
  <!-- LCL line -->
  <line x1="50" y1="190" x2="695" y2="190" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <text x="705" y="194" font-size="11" fill="var(--danger)" font-family="system-ui">LCL</text>
  <!-- Normal data points (green) -->
  <circle cx="90" cy="125" r="5" fill="var(--success)"/>
  <circle cx="140" cy="140" r="5" fill="var(--success)"/>
  <circle cx="190" cy="118" r="5" fill="var(--success)"/>
  <circle cx="240" cy="135" r="5" fill="var(--success)"/>
  <circle cx="290" cy="122" r="5" fill="var(--success)"/>
  <polyline points="90,125 140,140 190,118 240,135 290,122" fill="none" stroke="var(--success)" stroke-width="1.5"/>
  <!-- Signal 1: point outside UCL -->
  <circle cx="340" cy="58" r="6" fill="var(--danger)"/>
  <text x="340" y="50" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">1</text>
  <polyline points="290,122 340,58" fill="none" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <!-- Signal 2: 7 points same side (drift up) -->
  <circle cx="380" cy="108" r="5" fill="var(--warning)"/>
  <circle cx="420" cy="105" r="5" fill="var(--warning)"/>
  <circle cx="460" cy="110" r="5" fill="var(--warning)"/>
  <circle cx="500" cy="103" r="5" fill="var(--warning)"/>
  <circle cx="540" cy="107" r="5" fill="var(--warning)"/>
  <circle cx="580" cy="104" r="5" fill="var(--warning)"/>
  <circle cx="620" cy="109" r="5" fill="var(--warning)"/>
  <polyline points="340,58 380,108 420,105 460,110 500,103 540,107 580,104 620,109" fill="none" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="500" y="95" font-size="10" fill="var(--warning)" text-anchor="middle" font-family="system-ui">2: 7 points above center</text>
  <!-- Signal 3: trend -->
  <circle cx="660" cy="100" r="6" fill="var(--warning)"/>
  <polyline points="620,109 660,100" fill="none" stroke="var(--warning)" stroke-width="1.5"/>
  <!-- Annotations -->
  <rect x="30" y="240" width="680" height="15" rx="4" fill="var(--soft)"/>
  <text x="370" y="252" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Subgroups (time)</text>
  <!-- Signal legend -->
  <rect x="740" y="20" width="330" height="220" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="905" y="44" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Out-of-Control Signals</text>
  <circle cx="765" cy="75" r="8" fill="var(--danger)"/>
  <text x="765" y="79" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="785" y="72" font-size="12" font-weight="700" fill="var(--danger)" font-family="system-ui">จุดนอก UCL / LCL</text>
  <text x="785" y="90" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Special cause — investigate now</text>
  <circle cx="765" cy="130" r="8" fill="var(--warning)"/>
  <text x="765" y="134" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="785" y="127" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">7 จุดต่อเนื่อง — ด้านเดียว</text>
  <text x="785" y="145" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Process mean shift (drift)</text>
  <circle cx="765" cy="180" r="8" fill="var(--warning)"/>
  <text x="765" y="184" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="785" y="177" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">7 จุดต่อเนื่อง — trend</text>
  <text x="785" y="195" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Upward or downward trend</text>
  <rect x="760" y="210" width="295" height="22" rx="6" fill="var(--accent-wash)"/>
  <text x="907" y="225" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">PCBA: monitor solder paste height, placement offset</text>
  <!-- Bottom scale labels -->
  <text x="30" y="290" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">PCBA parameters ที่ SPC ดูแล:</text>
  <text x="30" y="310" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Solder paste volume (SPI) · Component placement offset (P&amp;P) · Reflow peak temp · Board warp</text>
  <text x="30" y="330" font-size="11" fill="var(--muted)" font-family="system-ui">ต้องทำ MSA (Gauge R&amp;R) ก่อน deploy SPC — measurement noise สูงทำให้ chart ไม่มีความหมาย</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SPC ตรวจจับ drift ของ parameter — ก่อนที่ defect จะเกิด; Inspection จับ defect ที่เกิดแล้ว</div>

<!-- Speaker: "in control" ไม่ได้แปลว่า "capable" — ต้องดู Cpk ร่วมด้วย -->

---

## Common Yield Killers ใน PCBA: 6 Defect ที่พบบ่อย

<p class="subhead">ทุก defect มี root cause ที่ชัดเจน — เชื่อมตรงกับ process parameter ที่ SPC ควรดูแล</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger compact">
    <p class="label">Reflow</p>
    <h3>Tombstoning</h3>
    <p>Profile ไม่สมมาตร, pad design ไม่สมดุล — component ยืนตั้งขึ้น</p>
  </div>
  <div class="card danger compact">
    <p class="label">Print → Reflow</p>
    <h3>Solder Bridge</h3>
    <p>Paste volume มากเกิน, stencil aperture ใหญ่เกิน — short ระหว่าง pad</p>
  </div>
  <div class="card danger compact">
    <p class="label">Reflow</p>
    <h3>Cold Joint / Open</h3>
    <p>Peak temp ต่ำ, coplanarity ไม่ดี — solder ไม่หลอมสมบูรณ์</p>
  </div>
  <div class="card warning compact">
    <p class="label">Reflow (BGA)</p>
    <h3>BGA Void</h3>
    <p>Flux activation ไม่สมบูรณ์, thermal profile ไม่เหมาะ — void ใต้ BGA ball</p>
  </div>
  <div class="card warning compact">
    <p class="label">SMT Placement</p>
    <h3>Missing Component</h3>
    <p>Nozzle worn, feeder jam — component ไม่ถูก place หรือหลุดก่อน reflow</p>
  </div>
  <div class="card warning compact">
    <p class="label">SMT Placement</p>
    <h3>Misalignment</h3>
    <p>Vision calibration drift, board support ไม่ดี — component เยื้องจาก pad</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI-driven reflow profile optimization ลด voiding risk ได้ถึง 40% และกำจัด tombstoning — SPC track peak temp + TAL ก่อนที่ defect จะเกิด</div>

<!-- Speaker: defect map + SPC parameter correlation = root cause analysis ที่แม่นยำ -->

---

## Practical Actions: EMS ทำอะไรจริงๆ เพื่อปรับปรุง Yield

<p class="subhead">5 action ที่พิสูจน์แล้วว่าได้ผล — เรียงจาก prevention ถึง improvement</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Prevention First</p>
    <h3>SPI + AOI 100% ทุก board</h3>
    <p>3D Solder Paste Inspection (SPI) หลัง printing + AOI หลัง reflow ต้องเป็น 100% inspection ไม่ใช่ sampling</p>
    <p>Catch defect ก่อน cascade ไปยัง step ถัดไป — ต้นทุน rework ที่ step ต้นต่ำกว่า step ปลายมาก</p>
  </div>
  <div class="card success">
    <p class="label">AI-Driven Optimization</p>
    <h3>Adaptive Reflow Profile</h3>
    <p>Machine learning cross-reference thermal data กับ defect map → dynamically adjust heating zones</p>
    <p>ลด voiding risk 40%, กำจัด tombstoning — ไม่ใช่แค่ follow fixed recipe</p>
  </div>
  <div class="card">
    <p class="label">Equipment Health</p>
    <h3>Predictive Maintenance (CMMS)</h3>
    <p>Track health: P&amp;P nozzle wear, reflow heating element, squeegee pressure, stencil life</p>
    <p>เปลี่ยนก่อน wear ส่งผลต่อ process capability — ไม่ใช่รอให้ breakdown</p>
  </div>
  <div class="card">
    <p class="label">Human Factor</p>
    <h3>SWI + Rework Tracking</h3>
    <p>Visual Standardized Work Instructions ลด human error; รework ทุกใบต้องมี root cause + technician ID + verification</p>
    <p>Rework data feed กลับไปยัง SPC → continuous improvement loop</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่ track FPY per-step + OEE + มี SPI/AOI 100% คือ partner ที่พร้อมทำ continuous improvement ให้คุณ</div>

<!-- Speaker: ถาม EMS: "what's your RTY for my board type?" ถ้าตอบไม่ได้ = ไม่มี per-step tracking -->

---

## Key Takeaways: Yield ปรับปรุงได้ด้วย Data ไม่ใช่ความรู้สึก

<p class="subhead">3 metric, 3 action — framework ที่นำไปใช้ได้ทันที</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">3 Metrics ที่ต้องรู้</p>
    <h3>Framework ครบวงจร</h3>
    <ul>
      <li><b>FPY per step:</b> รายงาน rework จริง ไม่ใช่ final acceptance rate</li>
      <li><b>RTY:</b> 5 steps × 95% = 77.4% — ตัวเลขสะท้อน process จริง</li>
      <li><b>OEE:</b> 85% = world-class; 60% = typical; ดู component ที่ต่ำสุดก่อน</li>
      <li><b>SPC:</b> X-bar R สำหรับ paste height, placement offset, reflow temp</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">3 Actions ที่ได้ผล</p>
    <h3>จาก Prevention ถึง Improvement</h3>
    <ul>
      <li>SPI + AOI 100% inspection ไม่ใช่ sampling</li>
      <li>SPC ต้องผ่าน MSA ก่อน deploy — noise ทำให้ chart ไร้ความหมาย</li>
      <li>Rework data → root cause analysis → SPC update → FPY ดีขึ้น</li>
      <li>ถาม EMS: "RTY ของ board ประเภทนี้คือเท่าไหร่?" คำตอบบอก maturity</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Quality ดี" ไม่ใช่ข้อมูล — FPY 97% per step ที่ verified ทุก step คือข้อมูล</div>

<!-- Speaker: ถ้า EMS ไม่มี per-step FPY data = ไม่มี system ที่จะปรับปรุงได้อย่างเป็นระบบ -->
