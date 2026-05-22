---
marp: true
theme: default
paginate: true
title: "เจาะลึก EMS Factory EP3: PCBA Basics — SMT vs THT"
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

# EMS Factory EP3: PCBA Basics — SMT vs THT

<p class="tag">ทำไม 90%+ ของ boards สมัยใหม่ใช้ SMT — และเมื่อไหร่ THT ยังจำเป็นอยู่</p>

<!-- Speaker: EP3 covers the two fundamental PCBA assembly technologies. Understanding when to use each directly impacts design, cost, and EMS partner selection. -->

---

## PCBA คืออะไร? และสองเทคโนโลยีหลัก

<p class="subhead">PCBA = กระบวนการติด components บน bare PCB — มีสองวิธีหลักที่แตกต่างกันอย่างมีนัยสำคัญ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">SMT — Surface Mount Technology</p>
    <h3>Components ติดบนผิว PCB</h3>
    <p>ไม่เจาะรู — solder paste เชื่อม component pad โดยตรงกับ PCB pad ผ่าน reflow oven</p>
    <ul>
      <li>~90%+ ของ modern PCBA</li>
      <li>High density: 100+ components/sq.in</li>
      <li>Fully automated: paste → P&P → reflow</li>
      <li>ดีสำหรับ high-frequency และ miniaturization</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">THT — Through-Hole Technology</p>
    <h3>Leads ทะลุรูใน PCB</h3>
    <p>เจาะ Plated Through-Holes (PTH) — leads สอดผ่าน soldered ด้านตรงข้ามด้วย wave หรือ selective solder</p>
    <ul>
      <li>Mechanical bond แน่นกว่า SMT</li>
      <li>สำหรับ connectors, power, harsh environment</li>
      <li>Wave / selective soldering</li>
      <li>ดีสำหรับ high-current และ vibration resistance</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PCBA ≠ PCB fabrication — PCBA คือ "populate ด้วย components"; ส่วนใหญ่ใช้ SMT เป็น primary + THT สำหรับ structural parts เท่านั้น</div>

<!-- Speaker: Bare PCB is just the substrate. PCBA is when components are added. The technology choice is driven by component type and end-use environment. -->

---

## SMT Process Flow: 6 Stages ตั้งแต่ Paste ถึง X-Ray

<p class="subhead">~70% ของ SMT defects เกิดที่ stage 1–2 — paste printing และ SPI คือ yield gate ที่สำคัญที่สุด</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep3-pcba-basics-1.png" alt="SMT process flow: solder paste printing, SPI, pick and place, reflow, AOI, X-ray">
<figcaption>Source: NotebookLM · SMT 6-stage process flow with equipment parameters at each stage</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Paste printing → SPI closed-loop → reflow profile engineering คือ 3 levers หลักที่ EMS ที่ดีควบคุมอย่างเข้มงวด — ถ้าขาดตัวใดตัวหนึ่ง yield จะไม่ stable</div>

<!-- Speaker: The 6-stage SMT flow is fully automated. Note that defect origins cluster at the earliest stages — which is why SPI feedback loops and tight paste control matter so much. -->

---

## THT Soldering Methods: Wave vs Selective vs Manual

<p class="subhead">เลือก method ให้ match กับ board complexity และ SMT/THT mix ratio</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Wave Soldering</p>
    <h3>Solder ทั้งแผ่นพร้อมกัน</h3>
    <p>PCB ผ่านเหนือ "wave" ของ liquid solder — สัมผัส bottom side ทุก joint ในครั้งเดียว</p>
    <ul>
      <li>High throughput</li>
      <li>เหมาะกับ THT-only boards</li>
      <li>ไม่เหมาะกับ SMT components ที่ bottom side</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Selective Wave Soldering</p>
    <h3>Nozzle เล็กเคลื่อนที่เฉพาะจุด</h3>
    <p>Robot head เล็กสร้าง mini-wave เฉพาะ PTH joints ที่ต้องการ ไม่กระทบ SMT areas</p>
    <ul>
      <li>Mixed boards สมัยใหม่</li>
      <li>ยืดหยุ่นสูง</li>
      <li>Throughput ต่ำกว่า wave</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Hand / Manual Soldering</p>
    <h3>Iron + solder wire</h3>
    <p>Operator ทำด้วยมือ — ช้า, ขึ้นกับ skill, แต่ยืดหยุ่นสูงสุดสำหรับ rework และ proto</p>
    <ul>
      <li>Prototype / NPI</li>
      <li>Rework / repair</li>
      <li>Low-volume high-mix</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Mixed boards (SMT + THT) ต้องใช้ selective soldering — wave จะ remelt SMT joints ที่ bottom side; selective ป้องกัน thermal damage ด้วย targeted nozzle</div>

<!-- Speaker: The soldering method selection is a process engineering decision. Mixed boards almost always need selective — it's more expensive per joint but protects the SMT work already done. -->

---

## SMT vs THT: การเปรียบเทียบเชิงเทคนิคครบถ้วน

<p class="subhead">ทุกเกณฑ์ชี้ไปทาง SMT — ยกเว้น mechanical strength และ high-power tolerance</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep3-pcba-basics-2.png" alt="SMT vs THT technical comparison matrix showing density, speed, cost, mechanical strength, vibration, high-frequency performance, and rework ease">
<figcaption>Source: NotebookLM · SMT vs THT comparison across 6 technical dimensions + use case mapping</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SMT ชนะเกือบทุกมิติยกเว้น "physical bond strength" — ถ้า component จะถูก mechanical stress (plug/unplug, vibration, weight) → THT คือคำตอบที่ถูกต้อง</div>

<!-- Speaker: This is the key decision framework. For any component that experiences repeated physical stress, THT's through-board anchor is irreplaceable. For everything else, SMT wins. -->

---

## Mixed Assembly: Sequence และ DFM Rules

<p class="subhead">Board สมัยใหม่ส่วนใหญ่ใช้ทั้งสองเทคโนโลยี — sequence สำคัญมาก</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Assembly sequence flow -->
  <!-- Step 1: SMT Top -->
  <rect x="20" y="100" width="160" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="100" y="133" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">SMT Top Side</text>
  <text x="100" y="153" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Paste → P&P</text>
  <text x="100" y="170" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">→ Reflow → AOI</text>
  <!-- Arrow -->
  <line x1="180" y1="140" x2="210" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="216,140 204,134 204,146" fill="var(--muted)"/>
  <!-- Step 2: Flip (optional) -->
  <rect x="216" y="100" width="140" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <text x="286" y="133" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Flip Board</text>
  <text x="286" y="153" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SMT Bottom</text>
  <text x="286" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(optional)</text>
  <!-- Arrow -->
  <line x1="356" y1="140" x2="386" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="392,140 380,134 380,146" fill="var(--muted)"/>
  <!-- Step 3: THT Insertion -->
  <rect x="392" y="100" width="160" height="80" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="472" y="133" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">THT Insertion</text>
  <text x="472" y="153" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Manual / auto</text>
  <text x="472" y="170" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">component insert</text>
  <!-- Arrow -->
  <line x1="552" y1="140" x2="582" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="588,140 576,134 576,146" fill="var(--muted)"/>
  <!-- Step 4: Selective Solder -->
  <rect x="588" y="100" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="668" y="133" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Selective Solder</text>
  <text x="668" y="153" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">THT joints only</text>
  <text x="668" y="170" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">targeted nozzle</text>
  <!-- Arrow -->
  <line x1="748" y1="140" x2="778" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="784,140 772,134 772,146" fill="var(--muted)"/>
  <!-- Step 5: Final Inspection -->
  <rect x="784" y="100" width="160" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="864" y="133" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Final Inspection</text>
  <text x="864" y="153" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AOI + X-ray</text>
  <text x="864" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ functional test</text>
  <!-- DFM Rules box -->
  <rect x="20" y="220" width="520" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="270" y="242" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Key DFM Rules for Mixed Boards</text>
  <text x="40" y="263" font-size="12" fill="var(--ink-dim)" font-family="system-ui">PTH-to-SMT pad clearance: ≥ 1.5 mm</text>
  <text x="40" y="283" font-size="12" fill="var(--ink-dim)" font-family="system-ui">SMT pad-to-pad spacing: ≥ 0.2 mm</text>
  <text x="40" y="303" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Thermal vias near power: 0.3–0.5 mm diameter</text>
  <!-- Why sequence matters box -->
  <rect x="560" y="220" width="520" height="100" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <text x="820" y="242" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ทำไม Sequence ถึงสำคัญ</text>
  <text x="580" y="263" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Wave solder หลัง SMT reflow = SMT joints remelt</text>
  <text x="580" y="283" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Reflow หลัง THT insert = leads may lift</text>
  <text x="580" y="303" font-size="12" fill="var(--danger-ink)" font-family="system-ui">SMT first → THT last: irreversible rule</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SMT ต้องทำก่อน THT เสมอ — reflow temperature จะทำลาย THT leads; selective solder หลัง reflow จะไม่กระทบ SMT joints ที่ solidified แล้ว</div>

<!-- Speaker: Mixed board sequencing is non-negotiable. The reflow oven temperature that cures SMT paste will also deform or oxidize THT leads. Assembly order is set by thermal constraints. -->

---

## Component Selection: SMT หรือ THT?

<p class="subhead">ตัดสินด้วย 3 ปัจจัย: mechanical stress, current/voltage, และ frequency requirement</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Decision node: Mechanical stress? -->
  <polygon points="550,30 700,100 550,170 400,100" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="550" y="93" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Mechanical</text>
  <text x="550" y="113" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">stress/vibration?</text>
  <!-- Yes → THT -->
  <line x1="400" y1="100" x2="250" y2="100" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="244,100 256,94 256,106" fill="var(--muted)"/>
  <text x="325" y="90" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Yes</text>
  <rect x="60" y="74" width="184" height="52" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="152" y="96" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">THT</text>
  <text x="152" y="116" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Connectors, power components</text>
  <!-- No → next question -->
  <line x1="700" y1="100" x2="820" y2="100" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="826,100 814,94 814,106" fill="var(--muted)"/>
  <text x="758" y="90" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No</text>
  <!-- Decision: High frequency / miniaturization? -->
  <polygon points="950,30 1090,100 950,170 810,100" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="950" y="93" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">High-freq /</text>
  <text x="950" y="113" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">miniaturization?</text>
  <!-- Yes → SMT -->
  <line x1="950" y1="170" x2="950" y2="220" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="950,226 944,214 956,214" fill="var(--muted)"/>
  <text x="968" y="200" font-size="11" fill="var(--muted)" font-family="system-ui">Yes / No</text>
  <rect x="858" y="226" width="184" height="52" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="950" y="248" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">SMT</text>
  <text x="950" y="266" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ICs, passives, MCUs, RF</text>
  <!-- Common THT use cases -->
  <rect x="20" y="165" width="380" height="130" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="210" y="187" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">THT Use Cases</text>
  <text x="36" y="208" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Power connectors (DB9, USB-B, XLR)</text>
  <text x="36" y="228" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Large electrolytic capacitors (&gt;1000uF)</text>
  <text x="36" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Transformers and inductors</text>
  <text x="36" y="268" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Relays, heatsinks, test points</text>
  <text x="36" y="288" font-size="12" fill="var(--ink-dim)" font-family="system-ui">High-vibration / aerospace environments</text>
  <!-- Common SMT use cases -->
  <rect x="420" y="165" width="380" height="130" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="610" y="187" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">SMT Use Cases</text>
  <text x="436" y="208" font-size="12" fill="var(--ink-dim)" font-family="system-ui">MCUs, processors, FPGAs</text>
  <text x="436" y="228" font-size="12" fill="var(--ink-dim)" font-family="system-ui">0402/0201 resistors and capacitors</text>
  <text x="436" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">BGA, QFN, LGA high-density ICs</text>
  <text x="436" y="268" font-size="12" fill="var(--ink-dim)" font-family="system-ui">RF components, impedance-controlled</text>
  <text x="436" y="288" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Consumer, telecom, industrial compact</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Default คือ SMT; switch to THT เมื่อ component จะรับ mechanical stress, current &gt;3A sustained, หรือ weight/heat ที่ surface bond ไม่พอรับ</div>

<!-- Speaker: Most engineers start with SMT for everything, then add THT only for specific requirements. This decision tree captures the key override conditions for switching to THT. -->

---

## Key Takeaways: PCBA Technology Fundamentals

<p class="subhead">เข้าใจ technology layer ก่อน — process control EP4 จะ build on top of this</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Core concepts</p>
    <h3>SMT vs THT Summary</h3>
    <ul>
      <li>SMT = surface mount, no holes, 100+ comp/sq.in, fully automated</li>
      <li>THT = through-hole, mechanical anchor, high current/vibration</li>
      <li>~70% of SMT defects originate at paste printing stage</li>
      <li>Mixed boards: SMT first → THT selective solder last</li>
      <li>Wave solder = THT-only boards; selective solder = mixed boards</li>
      <li>SMT wins on density/speed/cost; THT wins on bond strength/power</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Design & EMS selection implications</p>
    <h3>Practical Application</h3>
    <ul>
      <li>Confirm EMS มี selective solder line ถ้า board เป็น mixed technology</li>
      <li>Design BGA/QFN → confirm EMS มี X-ray + BGA rework capability</li>
      <li>PTH-to-SMT clearance ≥ 1.5 mm — enforce at DFM review</li>
      <li>THT lead-free hole fill ยากกว่า SnPb — preheat profile ต้องปรับ</li>
      <li>Component selection: stress/current/frequency → decision criteria</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP4 จะ zoom-in ที่ SMT process control: stencil aperture engineering, paste rheology, reflow profile optimization, และ SPC implementation</div>

<!-- Speaker: These fundamentals underpin every process control decision in EP4. When we talk about yield levers and defect reduction, it all comes back to understanding which technology you're working with and why defects form. -->
