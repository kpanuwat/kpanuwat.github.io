---
marp: true
theme: default
paginate: true
title: "EMS Factory EP13: Engineering Services"
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
  table { width:100%; border-collapse:collapse; font-size:13px; }
  th { background:var(--soft); color:var(--ink); font-weight:700; padding:10px 14px; text-align:left; border-bottom:2px solid var(--soft-2); }
  td { padding:9px 14px; border-bottom:1px solid var(--soft-2); color:var(--ink-dim); vertical-align:top; }
  tr:last-child td { border-bottom:none; }
---

<!-- _class: title -->

<div class="mark"></div>

# EMS Factory EP13: Engineering Services

<p class="tag">NPI · Process · Test · Customer Support — หัวใจวิศวกรรมของโรงงาน EMS</p>

<!-- Speaker: EP13 เจาะลึก Engineering Services — 6 ฟังก์ชันที่เปลี่ยน OEM design เป็น product จริงใน production -->

---

## Engineering Services ครอบ 6 ฟังก์ชันตลอด Product Lifecycle

<p class="subhead">ไม่ใช่แค่ทีมหนึ่ง — แต่คือ 6 ฟังก์ชันที่ active คนละช่วงของ lifecycle ตั้งแต่ก่อนผลิตถึงหลัง launch</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Pre-Production</p>
    <h3>NPI Engineering</h3>
    <p>รับ design ใหม่ → pilot build → FAI → handoff to production</p>
  </div>
  <div class="card success">
    <p class="label">Production</p>
    <h3>Process Engineering</h3>
    <p>Document + validate กระบวนการผลิตให้ repeatable และ stable</p>
  </div>
  <div class="card">
    <p class="label">Production</p>
    <h3>Test Engineering</h3>
    <p>ออกแบบ test strategy: AOI, ICT, FCT, reliability testing</p>
  </div>
  <div class="card gold">
    <p class="label">Full Lifecycle</p>
    <h3>Customer Engineering</h3>
    <p>DFM review + program management + ECO coordination กับ OEM</p>
  </div>
  <div class="card warning">
    <p class="label">NPI → Ramp</p>
    <h3>Tooling & Fixtures</h3>
    <p>Stencils, test fixtures, pallets — physical infrastructure ของสายผลิต</p>
  </div>
  <div class="card">
    <p class="label">Post-Launch</p>
    <h3>Sustaining Engineering</h3>
    <p>Obsolescence management + PLM + cost reduction ตลอด lifecycle</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Engineering Services ทำงานตั้งแต่ DFM review (ก่อนผลิต) ไปจนถึง sustaining engineering (หลัง launch) — ไม่ใช่แค่ช่วง NPI</div>

<!-- Speaker: แต่ละ function active ในช่วงต่างกัน — NPI eng เป็น "bridge" team แต่ process + test eng อยู่ใน production ยาวนานกว่า -->

---

## NPI สำเร็จเพียง 56% — Engineering Services คือ Risk Mitigation

<p class="subhead">เกือบครึ่งของ product launch ล้มเหลว — ส่วนใหญ่มาจาก poor design + development process ที่ไม่ robust</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Big stat panel: left -->
  <rect x="40" y="20" width="360" height="300" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="20" width="8" height="300" rx="4" fill="var(--danger)"/>
  <text x="220" y="140" font-size="100" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">56%</text>
  <text x="220" y="190" font-size="16" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">NPI Success Rate</text>
  <text x="220" y="214" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">industry average (Byte Lab / SVTronics)</text>
  <!-- Success panel: top right -->
  <rect x="430" y="20" width="630" height="138" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="450" y="54" font-size="14" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Engineering Services ที่แข็งแกร่ง:</text>
  <text x="468" y="82" font-size="13" fill="var(--success-ink)" font-family="system-ui">Early DFM review — fix issues before manufacturing</text>
  <text x="468" y="106" font-size="13" fill="var(--success-ink)" font-family="system-ui">Structured NPI — validate before mass production</text>
  <text x="468" y="130" font-size="13" fill="var(--success-ink)" font-family="system-ui">Sustaining eng — protect against supply disruptions</text>
  <!-- Danger panel: bottom right -->
  <rect x="430" y="182" width="630" height="138" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="450" y="216" font-size="14" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">Engineering Services ที่อ่อนแอ:</text>
  <text x="468" y="244" font-size="13" fill="var(--danger-ink)" font-family="system-ui">DFM issues found at production — expensive rework</text>
  <text x="468" y="268" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Untested process — scrap, poor yield, delays</text>
  <text x="468" y="292" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Obsolete parts — production halt, redesign cost</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Engineering Services ไม่ใช่ cost center — คือ risk reduction investment ที่เพิ่ม odds ของ NPI success</div>

<!-- Speaker: 56% เป็น industry average — EMS ที่มี engineering services ครบและทำงาน early collaboration กับ OEM จะมี rate สูงกว่ามาก -->

---

## NPI คือ 5-Phase Journey: จาก Design ถึง Production

<p class="subhead">Structured NPI process ลด risk และต้นทุนการ redesign — ทุก phase มี gate ก่อนเดินหน้า</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5 boxes: w=170 h=100, gap=37 -->
  <!-- Total = 5×170 + 4×37 = 850+148 = 998, start x=(1100-998)/2=51 -->
  <!-- Centers: 51+85=136, 136+170+37+85=428... -->
  <!-- Let me compute: -->
  <!-- Box 1: x=51, center=136 -->
  <!-- Box 2: x=258, center=343 -->
  <!-- Box 3: x=465, center=550 -->
  <!-- Box 4: x=672, center=757 -->
  <!-- Box 5: x=879, center=964 -->
  <!-- Box y: (320-100)/2=110, y=110 to y=210 -->
  <!-- Phase 4 (FAI): y=100, h=120 — slightly taller as gate indicator -->

  <!-- Phase 1 -->
  <rect x="51" y="110" width="170" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="91" cy="133" r="13" fill="var(--accent)"/>
  <text x="91" y="137" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="136" y="158" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Definition</text>
  <text x="136" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Feasibility</text>
  <text x="136" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Goals · risk · ROI</text>

  <!-- Arrow 1→2 -->
  <line x1="221" y1="160" x2="253" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="251,155 263,160 251,165" fill="var(--accent)"/>

  <!-- Phase 2 -->
  <rect x="258" y="110" width="170" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="298" cy="133" r="13" fill="var(--accent)"/>
  <text x="298" y="137" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="343" y="158" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Development</text>
  <text x="343" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Prototyping</text>
  <text x="343" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BOM · stencils · SMT</text>

  <!-- Arrow 2→3 -->
  <line x1="428" y1="160" x2="460" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="458,155 470,160 458,165" fill="var(--accent)"/>

  <!-- Phase 3 -->
  <rect x="465" y="110" width="170" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="505" cy="133" r="13" fill="var(--accent)"/>
  <text x="505" y="137" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="550" y="158" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pre-Build</text>
  <text x="550" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Verification</text>
  <text x="550" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Gerber · BOM check</text>

  <!-- Arrow 3→4 -->
  <line x1="635" y1="160" x2="667" y2="160" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="665,155 677,160 665,165" fill="var(--warning)"/>

  <!-- Phase 4: FAI Gate — highlighted, taller -->
  <rect x="672" y="98" width="170" height="124" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2.5"/>
  <circle cx="712" cy="122" r="13" fill="var(--warning)"/>
  <text x="712" y="126" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="757" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FAI Validation</text>
  <text x="757" y="167" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Process Gate</text>
  <text x="757" y="184" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Controlled initial run</text>
  <rect x="720" y="195" width="74" height="18" rx="4" fill="var(--warning)"/>
  <text x="757" y="207" font-size="9" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">PASS/FAIL GATE</text>

  <!-- Arrow 4→5 -->
  <line x1="842" y1="160" x2="874" y2="160" stroke="var(--success)" stroke-width="2"/>
  <polygon points="872,155 884,160 872,165" fill="var(--success)"/>

  <!-- Phase 5 -->
  <rect x="879" y="110" width="170" height="100" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="919" cy="133" r="13" fill="var(--success)"/>
  <text x="919" y="137" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="964" y="158" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Production</text>
  <text x="964" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Released</text>
  <text x="964" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Mass manufacturing</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FAI คือ pass/fail gate — ผ่าน FAI ก่อน ค่อยเปิด mass production ห้ามข้ามขั้นตอนนี้</div>

<!-- Speaker: Phase 4 (FAI) คือจุดที่ EMS certify ว่า process พร้อมแล้ว — first article ที่ผ่าน FAI = green light ของทั้งโรงงาน -->

---

## Process Engineering: ทำให้กระบวนการผลิต Repeatable

<p class="subhead">Process Engineers คือผู้ที่รู้ capabilities ของทุก machine บน production floor — "translator" ระหว่าง design spec กับ production reality</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Foundation</p>
    <h3>Assembly Documentation</h3>
    <p>สร้าง process-flow diagrams, work instructions, assembly docs ที่ชัดเจนสำหรับทุก step บนสายผลิต</p>
  </div>
  <div class="card success">
    <p class="label">Process Control</p>
    <h3>SPC & Validation</h3>
    <p>Program + validate SMT lines, selective soldering, conformal coating — ใช้ Statistical Process Control ตรวจ stability อย่างต่อเนื่อง</p>
  </div>
  <div class="card gold">
    <p class="label">Improvement</p>
    <h3>FMEA & Value Engineering</h3>
    <p>ทำ failure-mode analysis หา weak points ก่อนเกิดปัญหา + lead cost optimization ผ่าน process improvements</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Process Engineer ต้องรู้ทั้ง machine capabilities และ design tolerances — คือ "สะพาน" ระหว่าง engineering spec กับ factory floor</div>

<!-- Speaker: SPC คือ data-driven approach — detect drift ก่อนที่จะกลายเป็น defect แทนที่จะรอ QC ปลายสาย -->

---

## Test Engineering: 5 Methods ที่ใช้ใน EMS

<p class="subhead">ไม่มี one-size-fits-all — Test Engineers เลือก methodology ตาม product risk, volume, และ industry requirement</p>

<div class="infographic">

| Test Type | สิ่งที่ตรวจสอบ | เมื่อไหร่ใช้ |
|-----------|---------------|-------------|
| **AOI** — Automated Optical Inspection | Component placement, solder joints | หลัง SMT ทุก board — high throughput |
| **ICT** — In-Circuit Test | Electrical connectivity, component values | หลัง assembly — ต้องมี test fixture (BoN) |
| **FCT** — Functional Test | ระบบทำงานครบตาม spec หรือไม่ | ก่อน ship — most comprehensive |
| **Environmental / Reliability** | ทนความร้อน, ความชื้น, vibration | Qualification phase — sample basis |
| **Thermal Cycling** | Solder joint fatigue ใน extreme conditions | Long-life products: aerospace, medical, industrial |

</div>

<div class="takeaway"><b>★ Takeaway:</b> DFT (Design for Testability) ต้องทำก่อน production — PCB ต้องมี test points เพียงพอสำหรับ ICT/FCT probing</div>

<!-- Speaker: AOI = ทุก board, ICT = ทุก board หรือ sample ขึ้นกับ risk, FCT = ทุก board ก่อน ship เสมอ -->

---

## Customer Engineering: Single Point of Contact ระหว่าง OEM กับ Factory

<p class="subhead">Customer Engineering รับ design input จาก OEM และส่ง quality output กลับ — OEM ไม่ต้องคุยกับทุก internal team โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- FROM OEM box -->
  <rect x="30" y="30" width="270" height="240" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="30" y="30" width="270" height="46" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="165" y="60" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Input from OEM</text>
  <text x="50" y="100" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Design files (Gerber, BOM)</text>
  <text x="50" y="124" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Schematics</text>
  <text x="50" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Test requirements + criteria</text>
  <text x="50" y="172" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Volume ramp plan</text>
  <text x="50" y="196" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Quality targets</text>

  <!-- Arrow left → center -->
  <line x1="302" y1="150" x2="368" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="366,144 380,150 366,156" fill="var(--accent)"/>

  <!-- Customer Engineering center box -->
  <rect x="380" y="40" width="240" height="220" rx="14" fill="var(--accent)" style="filter:drop-shadow(0 6px 16px rgba(59,130,246,.35))"/>
  <text x="500" y="110" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Customer</text>
  <text x="500" y="132" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Engineering</text>
  <text x="500" y="170" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">DFM / DFA Review</text>
  <text x="500" y="192" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Program Management</text>
  <text x="500" y="214" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">ECO Coordination</text>
  <text x="500" y="236" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Cross-team Interface</text>

  <!-- Arrow center → right -->
  <line x1="622" y1="150" x2="688" y2="150" stroke="var(--success)" stroke-width="2.5"/>
  <polygon points="686,144 700,150 686,156" fill="var(--success)"/>

  <!-- TO OEM box -->
  <rect x="700" y="30" width="370" height="240" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="700" y="30" width="370" height="46" rx="12" fill="var(--success)" opacity=".1"/>
  <text x="885" y="60" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Output to OEM</text>
  <text x="720" y="100" font-size="12" fill="var(--success-ink)" font-family="system-ui">DFM report + recommendations</text>
  <text x="720" y="124" font-size="12" fill="var(--success-ink)" font-family="system-ui">FAI package (test logs + traceability)</text>
  <text x="720" y="148" font-size="12" fill="var(--success-ink)" font-family="system-ui">Yield data, defect Pareto</text>
  <text x="720" y="172" font-size="12" fill="var(--success-ink)" font-family="system-ui">ECO status updates</text>
  <text x="720" y="196" font-size="12" fill="var(--success-ink)" font-family="system-ui">Regular quality reports</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DFM report คือ output แรกที่สำคัญที่สุด — ทำให้ OEM รู้ว่าต้องแก้อะไรก่อนที่จะสาย</div>

<!-- Speaker: Cost to fix ที่ design stage ถูกกว่า production stage 10–100x นี่คือ ROI ของ Customer Engineering -->

---

## Tooling & Fixtures: Physical Infrastructure ของสายผลิต

<p class="subhead">Tooling เป็น physical assets ที่ทำให้ process ทำงานได้จริง — ต้อง sync กับ design revision ทุกครั้งมี ECO</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact">
    <p class="label">Screen Print</p>
    <h3>Solder Stencils</h3>
    <p>กำหนด pattern + ปริมาณ solder paste บน pad — verify Gerber ก่อนสั่งทำ</p>
  </div>
  <div class="card compact success">
    <p class="label">Board Support</p>
    <h3>Pallets / Carriers</h3>
    <p>รองรับ PCB ระหว่างผ่าน selective soldering + wave soldering</p>
  </div>
  <div class="card compact">
    <p class="label">ICT Testing</p>
    <h3>Test Fixtures (BoN)</h3>
    <p>Bed-of-Nails — probe connects กับ test points สำหรับ In-Circuit Test</p>
  </div>
  <div class="card compact warning">
    <p class="label">Assembly</p>
    <h3>Assembly Jigs</h3>
    <p>Guide ช่างใน through-hole + mechanical assembly ให้ถูก position</p>
  </div>
  <div class="card compact gold">
    <p class="label">Coating</p>
    <h3>CC Masks</h3>
    <p>Conformal Coating Masks ป้องกัน connectors + test points จาก coating</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุกครั้งมี ECO ต้อง review tooling ด้วย — stencil, fixture, mask อาจต้องอัปเดตพร้อม design revision</div>

<!-- Speaker: Test fixture (Bed-of-Nails) ราคาแพง — DFT review ก่อนสั่งทำช่วยประหยัดต้นทุนได้มาก -->

---

## Sustaining Engineering: ป้องกัน Production หยุดชะงัก

<p class="subhead">Sustaining Engineering รับไม้ต่อหลัง NPI — ดูแลให้สินค้าผลิตได้ต่อเนื่องตลอดอายุผลิตภัณฑ์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Risk: Component EOL</p>
    <h3>Obsolescence Management</h3>
    <p>Monitor manufacturer EOL notices อย่างต่อเนื่อง ระบุ + qualify alternative components ก่อนของจะ obsolete — ป้องกัน production halt</p>
  </div>
  <div class="card">
    <p class="label">History & Continuity</p>
    <h3>Product Lifecycle Mgmt</h3>
    <p>บันทึก design changes, material substitutions, process improvements ตลอด lifecycle — สำคัญอย่างยิ่งใน aerospace, medical, industrial</p>
  </div>
  <div class="card success">
    <p class="label">Opportunity</p>
    <h3>Cost Reduction Programs</h3>
    <p>Identify equivalent parts ที่ต้นทุนต่ำกว่า + optimize process เพื่อลด cycle time และ scrap rate — ทุกอย่างต้อง qualify ก่อน implement</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Sustaining Engineering มักถูก undervalue แต่คือ function ที่ป้องกัน production halt จาก obsolete components ในระยะยาว</div>

<!-- Speaker: OEM ที่ตัด sustaining budget หลัง launch มักจ่ายแพงกว่ามากเมื่อ component obsolescence มาถึง -->

---

## ECO Management: ควบคุมการเปลี่ยนแปลง Design โดยไม่หยุด Production

<p class="subhead">Engineering Change Order ต้องผ่าน 6 ขั้นตอน — sync ทุก element พร้อมกันก่อน implement</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Snake flow: 3 boxes top (→), bend right, 3 boxes bottom (←) -->
  <!-- Box: w=240, h=82, gap=42 -->
  <!-- Top row y=30-112; Bottom row y=194-276 -->
  <!-- Top row: x=40, 322, 604 -->
  <!-- Bottom row: x=604, 322, 40 (step 4 under step 3) -->

  <!-- Step 1 -->
  <rect x="40" y="30" width="240" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <circle cx="66" cy="52" r="13" fill="var(--accent)"/>
  <text x="66" y="56" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="165" y="56" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">OEM Issues ECO</text>
  <text x="88" y="80" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Reason + scope of change</text>
  <text x="88" y="98" font-size="10" fill="var(--muted)" font-family="system-ui">ECO document</text>

  <!-- Arrow 1→2 -->
  <line x1="282" y1="71" x2="318" y2="71" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="316,66 328,71 316,76" fill="var(--accent)"/>

  <!-- Step 2 -->
  <rect x="322" y="30" width="240" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <circle cx="348" cy="52" r="13" fill="var(--accent)"/>
  <text x="348" y="56" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="447" y="56" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Impact Review</text>
  <text x="370" y="80" font-size="11" fill="var(--ink-dim)" font-family="system-ui">BOM, stencil, fixtures</text>
  <text x="370" y="98" font-size="10" fill="var(--muted)" font-family="system-ui">Customer + Process Eng</text>

  <!-- Arrow 2→3 -->
  <line x1="564" y1="71" x2="600" y2="71" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="598,66 610,71 598,76" fill="var(--accent)"/>

  <!-- Step 3: CCB Gate -->
  <rect x="604" y="20" width="240" height="102" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2.5"/>
  <circle cx="630" cy="46" r="13" fill="var(--warning)"/>
  <text x="630" y="50" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="729" y="50" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">CCB Approval</text>
  <text x="652" y="76" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Change Control Board</text>
  <text x="652" y="94" font-size="10" fill="var(--muted)" font-family="system-ui">Effective date set</text>
  <rect x="668" y="104" width="112" height="14" rx="3" fill="var(--warning)"/>
  <text x="724" y="114" font-size="8" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">GATE</text>

  <!-- Bend arrow: right of step 3 → down → into step 4 from right -->
  <line x1="844" y1="71" x2="900" y2="71" stroke="var(--accent)" stroke-width="2"/>
  <line x1="900" y1="71" x2="900" y2="235" stroke="var(--accent)" stroke-width="2"/>
  <line x1="900" y1="235" x2="846" y2="235" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="848,229 836,235 848,241" fill="var(--accent)"/>

  <!-- Step 4: under step 3, right side of bottom row -->
  <rect x="604" y="194" width="240" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <circle cx="630" cy="216" r="13" fill="var(--accent)"/>
  <text x="630" y="220" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="729" y="220" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Implement All</text>
  <text x="652" y="244" font-size="11" fill="var(--ink-dim)" font-family="system-ui">BOM · tooling · traveler</text>
  <text x="652" y="262" font-size="10" fill="var(--muted)" font-family="system-ui">Sync all elements</text>

  <!-- Arrow 4→5 (right-to-left) -->
  <line x1="602" y1="235" x2="566" y2="235" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="568,229 556,235 568,241" fill="var(--accent)"/>

  <!-- Step 5 -->
  <rect x="322" y="194" width="240" height="82" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <circle cx="348" cy="216" r="13" fill="var(--accent)"/>
  <text x="348" y="220" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="447" y="220" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">First Article</text>
  <text x="370" y="244" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Validate after change</text>
  <text x="370" y="262" font-size="10" fill="var(--muted)" font-family="system-ui">Before full production</text>

  <!-- Arrow 5→6 (right-to-left) -->
  <line x1="320" y1="235" x2="284" y2="235" stroke="var(--success)" stroke-width="2"/>
  <polygon points="286,229 274,235 286,241" fill="var(--success)"/>

  <!-- Step 6: Production Resumes -->
  <rect x="40" y="194" width="240" height="82" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="66" cy="216" r="13" fill="var(--success)"/>
  <text x="66" y="220" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">6</text>
  <text x="165" y="220" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Production Resumes</text>
  <text x="88" y="244" font-size="11" fill="var(--success-ink)" font-family="system-ui">New revision live</text>
  <text x="88" y="262" font-size="10" fill="var(--success-ink)" font-family="system-ui">Traceability updated</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ECO ต้อง sync ทุก element พร้อมกัน — BOM, tooling, test fixture, traveler document — ขาดอย่างใดทำให้ traceability เสีย</div>

<!-- Speaker: CCB (Step 3) คือ gate สำคัญ — ต้อง approve ก่อน implement และต้องกำหนด effective date ชัดเจนเพื่อจัดการ old stock -->

---

## Caveats: สิ่งที่ต้องระวังกับ Engineering Services

<p class="subhead">OEM ที่เข้าใจ constraints เหล่านี้จะใช้ Engineering Services ได้เต็มประสิทธิภาพมากกว่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card gold">
    <p class="label">Cost Reality</p>
    <h3>NPI Fee ไม่ฟรี</h3>
    <p>EMS คิด NPI fee แยกจาก production pricing — มองว่า expensive แต่จริงๆ คือ risk reduction investment ที่ช่วยลด rework + scrap ในระยะยาวได้มาก</p>
  </div>
  <div class="card warning">
    <p class="label">Timing is Critical</p>
    <h3>DFM ต้องทำก่อนเสมอ</h3>
    <p>Cost to fix ที่ design stage ถูกกว่า production stage 10–100x — OEM ที่ข้าม DFM review แล้วเจอปัญหาใน production จ่ายแพงกว่ามาก</p>
  </div>
  <div class="card danger">
    <p class="label">Scope Boundary</p>
    <h3>EMS Engineering ≠ Product Design</h3>
    <p>Engineering Services ใน EMS focus ที่ manufacturability ไม่ใช่ product design — circuit design, firmware ยังเป็นความรับผิดชอบของ OEM เสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Early collaboration (OEM + EMS ร่วม DFM review ก่อน production) คือ best practice ที่ลด risk สูงสุดในทุกโปรเจกต์</div>

<!-- Speaker: EMS ที่ดีจะ push ให้ทำ DFM ก่อนเสมอ — ถ้า EMS ไม่ทำ DFM review นั่นคือ red flag ที่ควรระวัง -->

---

## Key Takeaways: Engineering Services ใน EMS Factory

<p class="subhead">สิ่งที่ต้องจำจาก EP13 — Engineering Services คือสิ่งที่แยก EMS ที่เป็น partner จาก contract assembler</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact">
    <p class="label">Core Function</p>
    <h3>Lifecycle Bridge</h3>
    <p>ทำงานตั้งแต่ DFM review (ก่อนผลิต) ถึง sustaining engineering (หลัง launch) — ไม่ใช่แค่ช่วง production</p>
  </div>
  <div class="card compact danger">
    <p class="label">Key Stat</p>
    <h3>NPI Success Rate เพียง 56%</h3>
    <p>Engineering Services ที่แข็งแกร่งคือ risk mitigation หลักสำหรับ product launch ที่สำเร็จ</p>
  </div>
  <div class="card compact warning">
    <p class="label">Rule #1</p>
    <h3>DFM ก่อนเสมอ</h3>
    <p>Fix issues ที่ design stage — ถูกกว่า production stage 10–100x เป็น rule ที่ทุก OEM ต้องจำ</p>
  </div>
  <div class="card compact success">
    <p class="label">Integration</p>
    <h3>6 Functions ทำงานร่วมกัน</h3>
    <p>Process, Test, Customer Eng แยก team แต่ integrate กันผ่าน NPI → production → sustaining lifecycle</p>
  </div>
  <div class="card compact gold">
    <p class="label">Change Control</p>
    <h3>Tooling Sync กับ ECO</h3>
    <p>ทุกครั้ง design เปลี่ยน ต้อง update stencil, fixture, test software พร้อมกันเสมอ</p>
  </div>
  <div class="card compact">
    <p class="label">Long-term</p>
    <h3>Sustaining = EOL Protection</h3>
    <p>Monitor component lifecycle ต่อเนื่อง — ป้องกัน production halt จาก EOL components</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OEM ที่เลือก EMS จากราคาอย่างเดียวโดยไม่ดู Engineering Services อาจเสียมากกว่าในระยะยาว</div>

<!-- Speaker: ปิดด้วย message นี้ — engineering services ที่ครบคือ differentiator ของ EMS ระดับ tier 1 -->
