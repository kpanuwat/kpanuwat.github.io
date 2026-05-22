---
marp: true
theme: default
paginate: true
title: "EMS Factory EP11: ESG & Compliance"
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

# EMS Factory EP11
# ESG & Compliance

<p class="tag">Scope 1–3 Emissions · Conflict Minerals · CMRT · Form SD</p>

<!-- Speaker: Two compliance worlds EMS must navigate simultaneously — carbon and conflict minerals. Both are market access requirements, not optional. -->

---

## ESG Compliance คือ Market Access — ไม่ใช่แค่ Best Practice

<p class="subhead">CSRD, Dodd-Frank, CBAM บังคับให้ OEM ขอข้อมูลจาก EMS — EMS ที่ไม่พร้อมเสียลูกค้า</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Two-column: ESG Emissions vs Conflict Minerals -->
  <rect x="30" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="30" y="20" width="490" height="60" rx="14" fill="var(--accent)" opacity=".10"/>
  <rect x="30" y="60" width="490" height="20" rx="0" fill="var(--accent)" opacity=".10"/>
  <text x="275" y="58" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ESG Emissions (Scope 1-2-3)</text>
  <text x="60" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">กฎหมาย: EU CSRD, SEC Climate Rules, CBAM</text>
  <text x="60" y="140" font-size="13" fill="var(--ink-dim)" font-family="system-ui">OEM รายงาน Scope 3 → ต้องการข้อมูลจาก EMS</text>
  <text x="60" y="175" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Scope 3 = 70–90% ของ carbon footprint ทั้งหมด</text>
  <text x="60" y="210" font-size="13" fill="var(--ink-dim)" font-family="system-ui">วัดยาก — ต้องรวบรวม data จาก supplier</text>
  <text x="60" y="255" font-size="13" font-weight="600" fill="var(--accent)" font-family="system-ui">Deadline: ต่อเนื่อง (CSRD annual report)</text>
  <rect x="580" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="580" y="20" width="490" height="60" rx="14" fill="var(--warning)" opacity=".10"/>
  <rect x="580" y="60" width="490" height="20" rx="0" fill="var(--warning)" opacity=".10"/>
  <text x="825" y="58" font-size="17" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Conflict Minerals (3TG)</text>
  <text x="610" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">กฎหมาย: Dodd-Frank Sec. 1502, EU CMR</text>
  <text x="610" y="140" font-size="13" fill="var(--ink-dim)" font-family="system-ui">OEM ต้อง trace 3TG → ส่ง CMRT มาให้ EMS กรอก</text>
  <text x="610" y="175" font-size="13" fill="var(--ink-dim)" font-family="system-ui">3TG: Tantalum, Tin, Tungsten, Gold</text>
  <text x="610" y="210" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Tin อยู่ใน solder paste ทุกกระบวนการ SMT</text>
  <text x="610" y="255" font-size="13" font-weight="600" fill="var(--warning-ink)" font-family="system-ui">Deadline: 31 พฤษภาคม (Form SD filing)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ทุกรายมี 3TG ใน process โดยธรรมชาติ และ OEM ต้องการ emissions data เพื่อ CSRD — ทั้งสองเรื่องนี้ EMS ต้องพร้อมตอบได้</div>

<!-- Speaker: Two parallel compliance obligations. One is annual deadline (Form SD May 31), one is ongoing. Both driven by customer demand. -->

---

## Scope 3 คิดเป็น 70–90% ของ Carbon Footprint — แต่วัดยากที่สุด

<p class="subhead">GHG Protocol แบ่ง emissions เป็นสามชั้น — EMS ควบคุมได้แค่ Scope 1+2 แต่ลูกค้าสนใจ Scope 3</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Three-scope layered diagram -->
  <!-- Scope 1 box -->
  <rect x="30" y="30" width="310" height="300" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="185" y="65" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Scope 1</text>
  <text x="185" y="87" font-size="13" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Direct Emissions</text>
  <text x="185" y="120" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">On-site boiler / generator</text>
  <text x="185" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Company vehicle fleet</text>
  <text x="185" y="164" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Refrigerant leak (HVAC)</text>
  <rect x="50" y="250" width="270" height="36" rx="8" fill="var(--success)" opacity=".15"/>
  <text x="185" y="274" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">สำหรับ EMS: เล็กมาก</text>
  <!-- Scope 2 box -->
  <rect x="380" y="30" width="310" height="300" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="535" y="65" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Scope 2</text>
  <text x="535" y="87" font-size="13" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Purchased Energy</text>
  <text x="535" y="120" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไฟฟ้าของ SMT line ทั้งหมด</text>
  <text x="535" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Reflow oven, AOI, ICT</text>
  <text x="535" y="164" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Air conditioning cleanroom</text>
  <rect x="400" y="250" width="270" height="36" rx="8" fill="var(--accent)" opacity=".15"/>
  <text x="535" y="274" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">วัดง่าย — ดู utility bill</text>
  <!-- Scope 3 box - bigger to show dominance -->
  <rect x="730" y="30" width="340" height="300" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2.5"/>
  <text x="900" y="65" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Scope 3</text>
  <text x="900" y="87" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Value Chain (70–90%)</text>
  <text x="900" y="120" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">IC, PCB, passive components</text>
  <text x="900" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Logistics in + out</text>
  <text x="900" y="164" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Solder waste, scrap</text>
  <text x="900" y="186" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">End-of-life product</text>
  <rect x="750" y="246" width="300" height="40" rx="8" fill="var(--warning)" opacity=".20"/>
  <text x="900" y="272" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">วัดยาก — ต้องขอ data supplier</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Scope 3 ใหญ่กว่า Scope 1+2 รวมกัน 15 เท่า — OEM จะกดดัน EMS ให้ provide emissions data เพื่อ CSRD compliance</div>

<!-- Speaker: The irony: EMS can directly control only 10-30%, but customers care most about the 70-90% it can only estimate. -->

---

## 3TG: ทุก PCBA มี Conflict Minerals ใช้อยู่แล้วโดยธรรมชาติ

<p class="subhead">Tantalum, Tin, Tungsten, Gold — พบใน component ที่ EMS ใช้ทุกวัน; Dodd-Frank บังคับ trace ถึง smelter</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card warning">
    <p class="label">Tantalum · Ta</p>
    <h3>Capacitor</h3>
    <p>Tantalum capacitor ใน smartphone, tablet, high-reliability PCB — energy density สูงกว่า ceramic</p>
  </div>
  <div class="card warning">
    <p class="label">Tin · Sn</p>
    <h3>Solder Paste</h3>
    <p>SAC305 (Sn96.5/Ag3/Cu0.5) คือ tin เป็นหลัก — ทุก reflow process ใช้อยู่; ใหญ่ที่สุดใน 3TG</p>
  </div>
  <div class="card warning">
    <p class="label">Tungsten · W</p>
    <h3>Vibration Motor</h3>
    <p>Tungsten counter-weight ใน haptic motor ของ mobile device; heavy = effective vibration</p>
  </div>
  <div class="card gold">
    <p class="label">Gold · Au</p>
    <h3>Contact / Wire Bond</h3>
    <p>Gold wire bond ใน IC packaging, gold contact ใน connector — corrosion resistance สูง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Tin ใน solder paste หมายความว่า EMS ทุกรายที่ทำ SMT ต้องมี 3TG compliance โดยอัตโนมัติ — ไม่มีทางเลี่ยง</div>

<!-- Speaker: There's no opt-out. Every PCB uses tin solder. The question is only whether you can trace where it came from. -->

---

## Dodd-Frank 1502: Trace 3TG ถึง Smelter — Form SD ยื่น 31 พฤษภาคม

<p class="subhead">กฎหมาย 2010 บังคับให้ SEC-listed companies เปิดเผย 3TG ว่ามาจาก conflict zone ใน DRC หรือไม่</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- CMRT arrow flow: 5 steps -->
  <!-- Step boxes -->
  <rect x="20" y="100" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="105" cy="80" r="20" fill="var(--accent)"/>
  <text x="105" y="86" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="105" y="130" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BOM Mapping</text>
  <text x="105" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ระบุ component</text>
  <text x="105" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่มี 3TG</text>
  <text x="105" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ตัดส่วนที่ไม่เกี่ยว</text>
  <!-- Arrow 1 -->
  <line x1="195" y1="170" x2="225" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="225,164 237,170 225,176" fill="var(--accent)"/>
  <!-- Step 2 -->
  <rect x="240" y="100" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="325" cy="80" r="20" fill="var(--accent)"/>
  <text x="325" y="86" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="325" y="130" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">CMRT Distribution</text>
  <text x="325" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ส่ง Excel template</text>
  <text x="325" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ให้ supplier กรอก</text>
  <text x="325" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">track response rate</text>
  <!-- Arrow 2 -->
  <line x1="415" y1="170" x2="445" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="445,164 457,170 445,176" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="460" y="100" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="545" cy="80" r="20" fill="var(--accent)"/>
  <text x="545" y="86" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="545" y="130" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Smelter Verify</text>
  <text x="545" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">cross-ref กับ RMI</text>
  <text x="545" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">conformant list</text>
  <text x="545" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">escalate non-conformant</text>
  <!-- Arrow 3 -->
  <line x1="635" y1="170" x2="665" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="665,164 677,170 665,176" fill="var(--accent)"/>
  <!-- Step 4 -->
  <rect x="680" y="100" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="765" cy="80" r="20" fill="var(--accent)"/>
  <text x="765" y="86" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="765" y="130" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">RCOI Assessment</text>
  <text x="765" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">มีจาก DRC หรือไม่?</text>
  <text x="765" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Reasonable Country</text>
  <text x="765" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">of Origin Inquiry</text>
  <!-- Arrow 4 -->
  <line x1="855" y1="170" x2="885" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="885,164 897,170 885,176" fill="var(--accent)"/>
  <!-- Step 5 - highlighted as deadline -->
  <rect x="900" y="100" width="180" height="140" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.12))"/>
  <circle cx="990" cy="80" r="20" fill="var(--danger)"/>
  <text x="990" y="86" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="990" y="130" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Form SD Filing</text>
  <text x="990" y="152" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ยื่น SEC</text>
  <text x="990" y="170" font-size="12" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Deadline: May 31</text>
  <text x="990" y="192" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Conflict Minerals</text>
  <text x="990" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Report ถ้ามีจาก DRC</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ต้องพร้อมรับ CMRT ทุกปีก่อน 31 พฤษภาคม — ถ้า supplier response rate ต่ำ → Form SD ของ OEM อาจ delay</div>

<!-- Speaker: EMS is in the middle of this chain. It receives CMRT from OEM, then pushes it down to its own component suppliers, aggregates, and sends back. -->

---

## OECD 5-Step Framework: Due Diligence ต้องทำทุกปี

<p class="subhead">ทั้ง Dodd-Frank และ EU Conflict Minerals Regulation ใช้ OECD framework เดียวกัน — trace ถึง smelter/refiner</p>

<div class="infographic">
<svg viewBox="0 0 1100 330" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5 column steps -->
  <rect x="20" y="60" width="188" height="230" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="20" y="60" width="188" height="40" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="114" y="87" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">01</text>
  <text x="114" y="125" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Management</text>
  <text x="114" y="143" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Systems</text>
  <text x="114" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Policy + supplier</text>
  <text x="114" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">code of conduct</text>
  <text x="114" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ grievance</text>
  <text x="114" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">mechanism</text>

  <rect x="228" y="60" width="188" height="230" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="228" y="60" width="188" height="40" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="322" y="87" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">02</text>
  <text x="322" y="125" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Identify &amp;</text>
  <text x="322" y="143" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Assess Risks</text>
  <text x="322" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Map supply chain</text>
  <text x="322" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถึง smelter level</text>
  <text x="322" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ระบุ CAHRA</text>
  <text x="322" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">exposure</text>

  <rect x="436" y="60" width="188" height="230" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="436" y="60" width="188" height="40" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="530" y="87" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">03</text>
  <text x="530" y="125" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Risk Response</text>
  <text x="530" y="143" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Strategy</text>
  <text x="530" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Engage supplier</text>
  <text x="530" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เพื่อปรับปรุง</text>
  <text x="530" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">หรือ disengage</text>
  <text x="530" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถ้า risk สูงเกิน</text>

  <rect x="644" y="60" width="188" height="230" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="644" y="60" width="188" height="40" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="738" y="87" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">04</text>
  <text x="738" y="125" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Third-Party</text>
  <text x="738" y="143" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Audit</text>
  <text x="738" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Smelter audit</text>
  <text x="738" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตาม RMAP</text>
  <text x="738" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(Responsible</text>
  <text x="738" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Minerals Assurance)</text>

  <rect x="852" y="60" width="228" height="230" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="852" y="60" width="228" height="40" rx="10" fill="var(--success)" opacity=".15"/>
  <text x="966" y="87" font-size="22" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">05</text>
  <text x="966" y="125" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Annual Report</text>
  <text x="966" y="143" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">to Public</text>
  <text x="966" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">รายงาน due diligence</text>
  <text x="966" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่ทำทั้งปี</text>
  <text x="966" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Form SD + Conflict</text>
  <text x="966" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Minerals Report</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OECD framework ต้องการ trace ถึง smelter/refiner — ไม่ใช่แค่ tier-1 supplier; RMAP audit คือ evidence ที่ใช้ได้จริง</div>

<!-- Speaker: The OECD framework is the backbone of both US and EU regulations. Step 4 (third-party audit at smelter level) is what gives the compliance real teeth. -->

---

## ESG Regulations ที่ EMS ต้องติดตาม: CSRD, CBAM, SEC

<p class="subhead">สามกฎหมายหลักที่ shape ว่า OEM จะขอข้อมูลอะไรจาก EMS partner ในอีก 2–5 ปีข้างหน้า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">EU · ใช้บังคับแล้ว</p>
    <h3>CSRD</h3>
    <p>Corporate Sustainability Reporting Directive — บังคับ OEM ขนาดใหญ่ใน EU รายงาน ESG ตาม ESRS รวมถึง Scope 3 supply chain</p>
    <p><b>ผลต่อ EMS:</b> OEM จะขอ emissions data เป็น annual supplier questionnaire</p>
  </div>
  <div class="card warning">
    <p class="label">EU · เริ่ม 2026</p>
    <h3>CBAM</h3>
    <p>Carbon Border Adjustment Mechanism — เก็บค่า carbon ของ goods import เข้า EU; EMS ที่ export ไป EU ต้องคำนวณ embedded carbon</p>
    <p><b>ปัจจุบัน:</b> steel, cement, aluminum; electronics กำลังถูก discuss</p>
  </div>
  <div class="card success">
    <p class="label">US · อยู่ระหว่าง implementation</p>
    <h3>SEC Climate Rules</h3>
    <p>Public companies ต้องเปิดเผย Scope 1+2; Scope 3 ถ้า material — ยังอยู่ระหว่าง legal challenge แต่ direction ชัดเจน</p>
    <p><b>ผลต่อ EMS:</b> US-listed OEM จะกดดัน EMS ให้ measure emissions</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แม้ CBAM ยังไม่ครอบคลุม electronics — EMS ที่เริ่ม measure Scope 3 ตอนนี้จะพร้อมกว่าเมื่อกฎหมายขยาย scope</div>

<!-- Speaker: The direction is clear even if timelines shift. Companies that build emissions measurement capability now won't scramble when their OEM customers start demanding it. -->

---

## Key Takeaways

<p class="subhead">ESG + Conflict Minerals — สองระบบ compliance ที่ EMS ต้องรับมือพร้อมกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">ESG Emissions</p>
    <h3>Scope 3 คือ 70–90% — วัดยากที่สุด</h3>
    <p>Scope 1 (direct) + Scope 2 (electricity) วัดง่าย แต่ Scope 3 (supply chain) ใหญ่ที่สุด OEM ที่ต้องรายงาน CSRD จะกดดัน EMS ให้ provide data</p>
    <ul>
      <li>CSRD: annual ESG report รวม Scope 3</li>
      <li>CBAM: embedded carbon ของ goods export</li>
      <li>เริ่มจาก spend-based method ก่อน</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Conflict Minerals</p>
    <h3>3TG ใน PCBA — ต้อง trace ถึง smelter</h3>
    <p>Tin ใน solder paste หมายความว่า EMS ทุกรายมี 3TG Dodd-Frank 1502 บังคับ SEC filers → กระจาย CMRT มาถึง EMS</p>
    <ul>
      <li>Deadline: Form SD ยื่น 31 พฤษภาคม</li>
      <li>CMRT → RCOI → smelter verify (RMI list)</li>
      <li>OECD 5-step: trace ถึง smelter/refiner</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถาม EMS partner: "CMRT response rate คือเท่าไหร่?" และ "Scope 2 emissions ของคุณคือเท่าไหร่ต่อ board?" — คำตอบบอกว่า EMS พร้อมสำหรับ compliance ยุคใหม่แค่ไหน</div>

<!-- Speaker: Two questions for evaluating an EMS partner's compliance maturity. If they can't answer either, that's a red flag. -->
