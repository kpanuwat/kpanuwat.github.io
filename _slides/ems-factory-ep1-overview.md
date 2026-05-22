---
marp: true
theme: default
paginate: true
title: "เจาะลึก EMS Factory EP1"
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

# เจาะลึก EMS Factory EP1

<p class="tag">ภาพรวม Value Chain · SMT Line · IPC · QMS · Supply Chain · ESG</p>

<!-- Speaker: Series intro — EP1 คือ panorama view ก่อน zoom-in ใน EP ถัดไป -->

---

## EMS คืออะไร และทำไม Process Control ถึงสำคัญกว่าเครื่องจักร

<p class="subhead">EMS ช่วย OEM ลด CapEx + เร่ง time-to-market — แต่ความสามารถจริงวัดด้วย process discipline</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">EMS Role</p>
    <h3>Full-Service Partner</h3>
    <p>ครอบคลุม DFM, PCBA, box build, test, logistics — OEM focus บน R&D และ brand</p>
  </div>
  <div class="card warning">
    <p class="label">Wrong Question</p>
    <h3>"เครื่องจักรดีแค่ไหน?"</h3>
    <p>จำนวนและราคาอุปกรณ์ไม่บ่งบอก quality outcome จริงๆ</p>
  </div>
  <div class="card success">
    <p class="label">Right Question</p>
    <h3>"Process Control แน่นแค่ไหน?"</h3>
    <p>QMS + traceability + yield data คือ evidence ที่ใช้ตัดสิน EMS</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Certificate บนผนังไม่ใช่หลักฐาน — ขอดู CPK data, NCR history, first-pass yield trend</div>

<!-- Speaker: Core thesis ของ series นี้ทั้งหมด -->

---

## EMS Value Chain ครอบคลุม 6 Stages ตลอด Product Lifecycle

<p class="subhead">DFM คือ stage ที่ ROI สูงที่สุด — ปัญหาที่แก้ตอน design ถูกกว่าแก้ตอน production 10–100x</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 6-stage arrow flow -->
  <!-- Stage boxes -->
  <rect x="20"  y="80" width="150" height="120" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="200" y="80" width="150" height="120" rx="10" fill="var(--soft)"        stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="380" y="80" width="150" height="120" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="560" y="80" width="150" height="120" rx="10" fill="var(--soft)"        stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="740" y="80" width="150" height="120" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="920" y="80" width="150" height="120" rx="10" fill="var(--soft)"        stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- Stage titles -->
  <text x="95"  y="130" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">DFM / NPI</text>
  <text x="275" y="130" font-size="14" font-weight="700" fill="var(--ink)"         text-anchor="middle" font-family="system-ui">Procurement</text>
  <text x="455" y="130" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">PCBA</text>
  <text x="635" y="130" font-size="14" font-weight="700" fill="var(--ink)"         text-anchor="middle" font-family="system-ui">Box Build</text>
  <text x="815" y="130" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Test</text>
  <text x="995" y="130" font-size="14" font-weight="700" fill="var(--ink)"         text-anchor="middle" font-family="system-ui">Logistics</text>
  <!-- Stage sub-labels -->
  <text x="95"  y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design review</text>
  <text x="95"  y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">DFM flag</text>
  <text x="275" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BOM mgmt</text>
  <text x="275" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Vendor qual</text>
  <text x="455" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SMT + TH</text>
  <text x="455" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Inline inspect</text>
  <text x="635" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Housing, wiring</text>
  <text x="635" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Cable assy</text>
  <text x="815" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ICT, FCT</text>
  <text x="815" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Burn-in, ATE</text>
  <text x="995" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Kit, label</text>
  <text x="995" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Dropship</text>
  <!-- Arrows between boxes (tip at rightmost point = pointing right) -->
  <line x1="170" y1="137" x2="181" y2="137" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="199,137  181,130  181,144" fill="var(--muted)"/>
  <line x1="350" y1="137" x2="361" y2="137" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="379,137  361,130  361,144" fill="var(--muted)"/>
  <line x1="530" y1="137" x2="541" y2="137" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="559,137  541,130  541,144" fill="var(--muted)"/>
  <line x1="710" y1="137" x2="721" y2="137" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="739,137  721,130  721,144" fill="var(--muted)"/>
  <line x1="890" y1="137" x2="901" y2="137" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="919,137  901,130  901,144" fill="var(--muted)"/>
  <!-- OEM benefit label -->
  <text x="550" y="240" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OEM ได้: ลด CapEx · เร่ง TTM · Focus on core competency</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DFM/NPI stage คือจุดที่ ROI สูงสุด — ปัญหาที่แก้ตอนนี้ถูกกว่าแก้ใน production 10–100x</div>

<!-- Speaker: Emphasize DFM — ปัญหา ~70% ของ production defects แก้ได้ที่ design stage -->

---

## SMT Line: ~70% ของ Defects ถูกกำหนดตั้งแต่ขั้นตอนแรก

<p class="subhead">Solder paste printing คือ yield lever ที่สำคัญที่สุด — SPI closed-loop เป็น must-have ไม่ใช่ nice-to-have</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 8-step SMT pipeline, paste printing highlighted in danger -->
  <!-- Step boxes -->
  <rect x="10"  y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="140" y="100" width="110" height="70" rx="8" fill="var(--danger-wash)" stroke="var(--danger)"   stroke-width="2.5"/>
  <rect x="270" y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="400" y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="530" y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="660" y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="790" y="100" width="110" height="70" rx="8" fill="var(--soft)"        stroke="var(--soft-2)"  stroke-width="1.5"/>
  <rect x="920" y="100" width="110" height="70" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <!-- Step labels -->
  <text x="65"  y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Board</text>
  <text x="65"  y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Loading</text>
  <text x="195" y="125" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Paste</text>
  <text x="195" y="140" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Printing</text>
  <text x="195" y="158" font-size="10" fill="var(--danger)"  text-anchor="middle" font-family="system-ui">~70% defects</text>
  <text x="325" y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">SPI</text>
  <text x="325" y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">3D Inspect</text>
  <text x="455" y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Component</text>
  <text x="455" y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Placement</text>
  <text x="585" y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Reflow</text>
  <text x="585" y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">Soldering</text>
  <text x="715" y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">AOI</text>
  <text x="715" y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">3D + AI</text>
  <text x="845" y="128" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">X-Ray</text>
  <text x="845" y="143" font-size="11" font-weight="700" fill="var(--ink-dim)"  text-anchor="middle" font-family="system-ui">BGA/QFN</text>
  <text x="975" y="128" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ICT / FCT</text>
  <text x="975" y="143" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Final Test</text>
  <!-- Arrows (tip at rightmost point = pointing right) -->
  <line x1="120" y1="132" x2="131" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="139,132  121,126  121,138" fill="var(--muted)"/>
  <line x1="250" y1="132" x2="261" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="269,132  251,126  251,138" fill="var(--muted)"/>
  <line x1="380" y1="132" x2="391" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="399,132  381,126  381,138" fill="var(--muted)"/>
  <line x1="510" y1="132" x2="521" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="529,132  511,126  511,138" fill="var(--muted)"/>
  <line x1="640" y1="132" x2="651" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="659,132  641,126  641,138" fill="var(--muted)"/>
  <line x1="770" y1="132" x2="781" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="789,132  771,126  771,138" fill="var(--muted)"/>
  <line x1="900" y1="132" x2="911" y2="132" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="919,132  901,126  901,138" fill="var(--muted)"/>
  <!-- Closed-loop SPI feedback arrow -->
  <path d="M325,100 Q325,60 195,60 Q140,60 140,100" stroke="var(--accent)" stroke-width="1.5" fill="none" stroke-dasharray="5,3"/>
  <polygon points="140,100  133,84  147,84" fill="var(--accent)"/>
  <text x="260" y="52" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SPI closed-loop feedback</text>
  <!-- Yield Levers label -->
  <text x="550" y="250" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Yield Levers: Stencil Control · Paste Viscosity · Reflow Profile · N2 Atmosphere · AI-AOI</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ลงทุนใน 3D SPI closed-loop ก่อน — มันคือ leverage point ที่คุ้มค่ากว่า AOI หรือ X-ray 3–4x</div>

<!-- Speaker: Stencil + paste control คือ root cause ของ defects ส่วนใหญ่ — inspect ปลายสาย AOI/X-ray แก้ปัญหาได้น้อยกว่า -->

---

## IPC Standards แยกบทบาทชัด: Acceptance ≠ Process Control

<p class="subhead">EMS ที่บอกแค่ "ทำตาม IPC-A-610" โดยไม่มี J-STD-001 = มีแค่ pass/fail criteria ไม่มี process discipline</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Acceptance Criteria — "ผล" ออกมาเป็น pass/fail</p>
    <h3>IPC-A-610</h3>
    <p><b>Acceptability of Electronic Assemblies</b> — Class 1 (consumer) · Class 2 (industrial) · Class 3 (aerospace/medical)</p>
    <p style="margin-top:8px;font-size:12px;color:var(--warning-ink)">⚠ บอกแค่ว่า "ยอมรับได้หรือไม่" — ไม่ได้ควบคุมว่า process ผลิตอย่างไร</p>
  </div>
  <div class="card success">
    <p class="label">Process Control — ควบคุม "วิธี" ผลิต</p>
    <h3>J-STD-001 + IPC-2221 + IPC-7711 + IPC-1782B</h3>
    <p><b>J-STD-001:</b> Soldering materials + process requirements</p>
    <p><b>IPC-2221:</b> PCB design rules — manufacturability ตั้งแต่ design</p>
    <p><b>IPC-7711/7721:</b> Rework &amp; repair procedures</p>
    <p><b>IPC-1782B:</b> Traceability — M1/P1 (batch) to M4/P4 (unit-level)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถาม EMS ว่า "Class 2 หรือ Class 3?" และ "J-STD-001 process control อยู่ใน QMS ไหม?" — สองคำถามนี้แยก serious EMS ออกจาก paper-certified ได้ทันที</div>

<!-- Speaker: Class 3 = zero-defect expectation สำหรับ aerospace/medical — ส่วนใหญ่ industrial grade = Class 2 -->

---

## QMS Framework: ISO 9001 คือ Baseline, Sector-Specific คือ Real Bar

<p class="subhead">ยิ่ง regulated sector มากเท่าไหร่ QMS ยิ่งเข้มข้น — เลือก EMS ที่ QMS match กับ product risk level</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Universal Baseline</p>
    <h3>ISO 9001</h3>
    <p>ทุก EMS tier ต้องมี — documented quality system, process control, corrective action</p>
  </div>
  <div class="card warning">
    <p class="label">Automotive</p>
    <h3>IATF 16949</h3>
    <p>เพิ่ม APQP, PPAP, FMEA, control plan — process capability + special char. management</p>
  </div>
  <div class="card gold">
    <p class="label">Aerospace / Defense</p>
    <h3>AS9100</h3>
    <p>Configuration management + traceability เข้มมาก — zero defect culture required</p>
  </div>
  <div class="card success">
    <p class="label">Medical Devices</p>
    <h3>ISO 13485</h3>
    <p>Design control + post-market surveillance — risk management ตาม ISO 14971</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ISO 9001 alone ≠ enough สำหรับ automotive/medical/defense — ต้องตรวจว่า EMS มี sector-specific cert ที่ตรงกับ product ของคุณ</div>

<!-- Speaker: IATF 16949:2027 จะ integrate ESG + cyber requirements — EMS ที่ serve automotive ต้องเตรียมตัวแล้ว -->

---

## Traceability = Recall Scope Reduction, Not Just Barcode Scanning

<p class="subhead">Full traceability เปลี่ยน recall จาก "ทั้ง production run" เหลือ "เฉพาะ batch ที่ affected"</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-layer traceability diagram: Upstream | Internal | Downstream -->
  <!-- Upstream box -->
  <rect x="30"  y="50" width="280" height="200" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="30"  y="50" width="280" height="44"  rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="170" y="79" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Upstream</text>
  <text x="170" y="120" font-size="12" fill="var(--ink)"     text-anchor="middle" font-family="system-ui">Supplier lot tracking</text>
  <text x="170" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Certificate of Conformance</text>
  <text x="170" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Component batch ID</text>
  <text x="170" y="180" font-size="12" fill="var(--muted)"   text-anchor="middle" font-family="system-ui">Country of origin</text>
  <!-- Internal box -->
  <rect x="390" y="50" width="320" height="200" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2.5"/>
  <rect x="390" y="50" width="320" height="44"  rx="12" fill="var(--accent)" opacity=".25"/>
  <text x="550" y="79" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Internal Process</text>
  <text x="550" y="120" font-size="12" fill="var(--ink)"     text-anchor="middle" font-family="system-ui">Operator ID + workstation</text>
  <text x="550" y="140" font-size="12" fill="var(--ink)"     text-anchor="middle" font-family="system-ui">Reflow temp profile + time</text>
  <text x="550" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Paste lot + SPI result</text>
  <text x="550" y="180" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Test result + serial no.</text>
  <!-- Downstream box -->
  <rect x="790" y="50" width="280" height="200" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="790" y="50" width="280" height="44"  rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="930" y="79" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Downstream</text>
  <text x="930" y="120" font-size="12" fill="var(--ink)"     text-anchor="middle" font-family="system-ui">Ship-to customer + date</text>
  <text x="930" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Delivery order linkage</text>
  <text x="930" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Field return correlation</text>
  <text x="930" y="180" font-size="12" fill="var(--muted)"   text-anchor="middle" font-family="system-ui">Recall scope containment</text>
  <!-- Flow arrows -->
  <polygon points="312,147  382,140  382,154" fill="var(--accent)"/>
  <line x1="310" y1="147" x2="389" y2="147" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="712,147  782,140  782,154" fill="var(--accent)"/>
  <line x1="710" y1="147" x2="789" y2="147" stroke="var(--accent)" stroke-width="2"/>
  <!-- IPC-1782B label -->
  <text x="550" y="280" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IPC-1782B: M1/P1 (batch) to M4/P4 (unit-level parameter) — higher level = higher cost infrastructure</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 1 field failure + full traceability = contain ได้ภายใน hours; 1 field failure + no traceability = recall ทั้ง production run</div>

<!-- Speaker: ROI ของ full traceability คือ recall insurance — คุ้มมากใน high-liability products -->

---

## Supply Chain: 3 Risk Vectors ที่ OEM มักมองข้าม

<p class="subhead">Obsolescence, shortage, counterfeit คือ risk ที่ต้องจัดการตั้งแต่ DFM ไม่ใช่รอให้เกิดแล้วค่อยแก้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Risk #1</p>
    <h3>Obsolescence</h3>
    <p>Semiconductor lifecycle หดลง 60%+ ในทศวรรษที่ผ่านมา</p>
    <ul>
      <li>Predictive analytics + PDN monitoring</li>
      <li>FFF cross-reference catalog ตั้งแต่ DFM</li>
      <li>Last-Time Buy (LTB) analysis</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Risk #2</p>
    <h3>Shortage + Counterfeit</h3>
    <p>Geopolitics, export controls, spot market pressure เพิ่มความเสี่ยง</p>
    <ul>
      <li>Authorized distributor only (ISO 9001 cert)</li>
      <li>Anti-counterfeit: SAE AS5553, AS6081</li>
      <li>Multi-source + qualification test จริง</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Mitigation Framework</p>
    <h3>Design → Build → EOL</h3>
    <p>Risk management ต้องครอบ 4 stages:</p>
    <ul>
      <li>DFM: multi-sourced components</li>
      <li>Procurement: lifecycle monitoring</li>
      <li>Production: lot traceability + CoC</li>
      <li>EOL: predictive LTB calculation</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่ดีมี lifecycle monitoring tool และ FFF catalog — ถามให้เห็น evidence ก่อนเลือก</div>

<!-- Speaker: Counterfeit component คือ root cause ของ field failure ที่ trace ยากที่สุด — authorized distributor ไม่ใช่แค่ราคา -->

---

## ESG: RoHS/REACH คือ Entry Ticket, Conflict Minerals คือ Value Chain Mandate

<p class="subhead">ESG migrating จาก "nice to have" ไปเป็น contract requirement — IATF 16949:2027 จะ embed ไว้ใน automotive QMS</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Environmental Directives</p>
    <h3>RoHS + REACH + WEEE</h3>
    <p>จำกัด hazardous substances (Pb, Cd, Hg, Cr6+) ใน product</p>
    <p>REACH: chemical registration + restriction</p>
    <p>WEEE: end-of-life recycling obligation</p>
  </div>
  <div class="card warning">
    <p class="label">Sustainability Trends</p>
    <h3>Carbon + Circularity</h3>
    <p>ISO 14067: product carbon footprint measurement</p>
    <p>Energy-efficient production (reflow, lighting)</p>
    <p>Design for Circularity ตั้งแต่ DFM stage</p>
  </div>
  <div class="card danger">
    <p class="label">Conflict Minerals</p>
    <h3>3TG + Dodd-Frank</h3>
    <p>Tin, Tantalum, Tungsten, Gold ต้องมี CMRT จาก AIAG</p>
    <p>Automotive tier-1 กำลัง push ลงมาถึง EMS tier</p>
    <p>IATF 16949:2027 จะ mandate ESG ใน automotive QMS</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า supply chain ของคุณมี automotive หรือ EU customer — conflict minerals + RoHS compliance คือ must-have แล้ว</div>

<!-- Speaker: IATF 16949:2027 upcoming — EMS ที่ prepare ล่วงหน้าจะได้ advantage ในการ qualify เป็น automotive supplier -->

---

## Key Takeaways: Process Control Wins Every Time

<p class="subhead">Series ถัดไป: zoom-in SMT stencil engineering, paste characterization, และ SPC implementation</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Process & Quality</p>
    <h3>3 Core Levers</h3>
    <ul>
      <li><b>~70% SMT defects</b> กำหนดที่ paste printing — SPI closed-loop คือ must-have</li>
      <li><b>IPC-A-610</b> บอก acceptance เท่านั้น — J-STD-001 คือ process discipline</li>
      <li><b>Full traceability M4/P4</b> = recall scope จาก run ทั้งหมด เหลือแค่ batch ที่ affected</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Selection Criteria</p>
    <h3>Evaluate EMS ด้วย Evidence</h3>
    <ul>
      <li><b>Supply chain</b>: lifecycle monitoring + multi-source ตั้งแต่ DFM stage</li>
      <li><b>ESG</b>: RoHS/REACH + conflict minerals กลายเป็น value chain mandate</li>
      <li><b>Cert ≠ Capability</b>: ขอดู CPK, NCR history, first-pass yield trend</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือก EMS ด้วย evidence ไม่ใช่ certificate — control plan, change management log, test coverage report คือ 3 เอกสารที่ต้องขอดู</div>

<!-- Speaker: EP2 จะเจาะลึก SMT stencil engineering: aperture ratio, paste rheology, SPC control limits -->
