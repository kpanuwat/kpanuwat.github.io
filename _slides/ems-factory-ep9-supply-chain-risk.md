---
marp: true
theme: default
paginate: true
title: "EMS Factory EP9: Supply Chain Risk & Component Obsolescence"
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

# EMS Factory EP9: Supply Chain Risk & Component Obsolescence

<p class="tag">37% ของ part ที่ obsolete ไม่มี advance warning — reactive ไม่พอ</p>

<!-- Speaker: supply chain risk ที่ซ่อนอยู่ในทุก BOM -->

---

## Component Lifespan ลดลง 87% — นี่คือเหตุฉุกเฉินของ Supply Chain

<p class="subhead">จาก 30 ปีเหลือต่ำกว่า 4 ปี — และ 37% ของ part ที่หายไปไม่มีการแจ้งเตือนล่วงหน้า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card danger">
    <p class="label">Lifespan Drop</p>
    <h3>87%</h3>
    <p>ลดลงจาก 30 ปี เหลือต่ำกว่า 4 ปีเฉลี่ย</p>
  </div>
  <div class="card danger">
    <p class="label">No Warning</p>
    <h3>37%</h3>
    <p>ของ obsolete parts ไม่มี PCN หรือ PDN แจ้งก่อน</p>
  </div>
  <div class="card warning">
    <p class="label">2022 Scale</p>
    <h3>750K+</h3>
    <p>components ถูกประกาศ obsolete ในปีเดียว</p>
  </div>
  <div class="card warning">
    <p class="label">Instant OBS</p>
    <h3>+35%</h3>
    <p>"Instant obsolescence" (ไม่มี notice) เพิ่มขึ้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Advanced semiconductor มี lifecycle 2–5 ปี — BOM ที่ design วันนี้อาจมี red part แล้วใน 3 ปี</div>

<!-- Speaker: ตัวเลขเหล่านี้มาจาก Luminovo และ Sourceability research 2024-2025 -->

---

## Component Lifecycle: 6 Stages & Obsolescence Drivers

<p class="subhead">ทุก part ผ่าน 6 ขั้น — EMS ที่ดีรู้ว่า part อยู่ขั้นไหน ก่อนที่มันจะถึง Phase-Out</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep9-supply-chain-risk-1.png" alt="Electronic component lifecycle 6-stage risk curve showing Introduction through Obsolescence with intervention points and industry data overlay">
<figcaption>Source: NotebookLM · Component lifecycle risk — 6 stages, obsolescence drivers, and EMS intervention points</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Phase-Out คือ window สุดท้ายสำหรับ LTB — ถ้ารอถึง Obsolescence ราคา secondary market สูงขึ้น 3-5x</div>

<!-- Speaker: 4 driver หลัก: tech shift, market consolidation, regulatory (RoHS/REACH), geopolitical -->

---

## BOM Heat-Map: แยก Red / Yellow / Green ก่อน Production เริ่ม

<p class="subhead">Risk classification ตั้งแต่ program onboarding — ไม่ใช่หลังจาก PO ออกแล้ว</p>

<div class="infographic">
<svg viewBox="0 0 1100 390" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Header -->
  <text x="550" y="30" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BOM Risk Classification Framework</text>
  <!-- Red column -->
  <rect x="30" y="55" width="330" height="310" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="30" y="55" width="330" height="48" rx="12" fill="var(--danger)" opacity=".9"/>
  <text x="195" y="84" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">RED — Critical</text>
  <text x="55" y="128" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Single-source only</text>
  <text x="55" y="152" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Lifecycle: Decline or Phase-Out</text>
  <text x="55" y="176" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Lead time &gt; 26 weeks</text>
  <text x="55" y="200" font-size="13" fill="var(--danger-ink)" font-family="system-ui">No known FFF equivalent</text>
  <rect x="55" y="228" width="280" height="2" fill="var(--danger)" opacity=".3"/>
  <text x="55" y="256" font-size="12" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">ACTION (Immediate):</text>
  <text x="55" y="278" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Execute LTB + qualify alternate</text>
  <text x="55" y="300" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Escalate to engineering review</text>
  <text x="55" y="322" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Review monthly</text>
  <!-- Yellow column -->
  <rect x="390" y="55" width="320" height="310" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <rect x="390" y="55" width="320" height="48" rx="12" fill="var(--warning)" opacity=".9"/>
  <text x="550" y="84" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">YELLOW — Watch</text>
  <text x="415" y="128" font-size="13" fill="var(--warning-ink)" font-family="system-ui">Dual-source but concentrated</text>
  <text x="415" y="152" font-size="13" fill="var(--warning-ink)" font-family="system-ui">Lifecycle: Decline</text>
  <text x="415" y="176" font-size="13" fill="var(--warning-ink)" font-family="system-ui">Lead time 13–26 weeks</text>
  <text x="415" y="200" font-size="13" fill="var(--warning-ink)" font-family="system-ui">Alternate known, not qualified</text>
  <rect x="415" y="228" width="270" height="2" fill="var(--warning)" opacity=".3"/>
  <text x="415" y="256" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">ACTION (Monthly):</text>
  <text x="415" y="278" font-size="12" fill="var(--warning-ink)" font-family="system-ui">Qualify 2nd source</text>
  <text x="415" y="300" font-size="12" fill="var(--warning-ink)" font-family="system-ui">Set buffer inventory</text>
  <text x="415" y="322" font-size="12" fill="var(--warning-ink)" font-family="system-ui">Track PCN feeds</text>
  <!-- Green column -->
  <rect x="730" y="55" width="340" height="310" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="730" y="55" width="340" height="48" rx="12" fill="var(--success)" opacity=".9"/>
  <text x="900" y="84" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">GREEN — Stable</text>
  <text x="755" y="128" font-size="13" fill="var(--success-ink)" font-family="system-ui">Multi-source (3+ OCM)</text>
  <text x="755" y="152" font-size="13" fill="var(--success-ink)" font-family="system-ui">Lifecycle: Growth or Maturity</text>
  <text x="755" y="176" font-size="13" fill="var(--success-ink)" font-family="system-ui">Lead time &lt; 13 weeks</text>
  <text x="755" y="200" font-size="13" fill="var(--success-ink)" font-family="system-ui">Standard catalog part</text>
  <rect x="755" y="228" width="290" height="2" fill="var(--success)" opacity=".3"/>
  <text x="755" y="256" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui">ACTION (Quarterly):</text>
  <text x="755" y="278" font-size="12" fill="var(--success-ink)" font-family="system-ui">Routine lifecycle check</text>
  <text x="755" y="300" font-size="12" fill="var(--success-ink)" font-family="system-ui">No special action needed</text>
  <text x="755" y="322" font-size="12" fill="var(--success-ink)" font-family="system-ui">Monitor annually</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> target: >80% ของ critical component ต้องมี qualified 2nd source — ถาม EMS ว่า AVL ของพวกเขาอยู่ที่ % ไหน</div>

<!-- Speaker: tool ที่ใช้: SiliconExpert, Z2Data, IHS Markit — ไม่ใช่แค่ดู distributor website -->

---

## Mitigation Strategies: จาก Multi-Sourcing ถึง Re-Design

<p class="subhead">4 strategy เรียงจาก preferred → last resort — อย่ากระโดดไป LTB ก่อนหา alternate ก่อน</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep9-supply-chain-risk-2.png" alt="Supply chain risk mitigation strategy playbook: Multi-sourcing, Last Time Buy, Bonded Inventory, Re-Design with cost and timing tradeoffs">
<figcaption>Source: NotebookLM · 4-strategy mitigation playbook — cost, lead time, risk reduction, and when each applies</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Dual-sourcing ลด disruption cost 15–20% vs single-source — ROI คุ้มแม้จะมี qualification overhead</div>

<!-- Speaker: Re-design อาจใช้เวลา 6-18 เดือนสำหรับ medical/automotive — ไม่ใช่ option ที่รอได้นาน -->

---

## Counterfeit Risk: อันตรายที่มากับ Secondary Market

<p class="subhead">ยิ่ง shortage หนัก ยิ่งมีแรงกดดันให้ซื้อจาก broker — ยิ่งเสี่ยง counterfeit</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Red Flags</p>
    <h3>สัญญาณ Counterfeit</h3>
    <ul>
      <li>ราคาต่ำผิดปกติในช่วง shortage</li>
      <li>Marking ไม่ตรง datasheet (date code, lot code, country of origin)</li>
      <li>Source เป็น broker ไม่มี traceability ถึง OCM</li>
      <li>MOQ ไม่สมเหตุ (ได้จำนวนพอดีเป๊ะในราคาที่ต่ำมาก)</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Verified Path</p>
    <h3>ซื้ออย่างถูกต้อง</h3>
    <ul>
      <li>Authorized distributor เท่านั้น (Mouser, Digi-Key, Arrow, Avnet, TTI)</li>
      <li>Open market: ต้องผ่าน AS6081/AS6171 testing</li>
      <li>IDEA-ICE-3000 inspection: marking, dimensions, solderability</li>
      <li>ใช้ bonded inventory กับ authorized distributor แทน spot buy จาก broker</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Counterfeit component ผ่าน incoming inspection ปกติได้ — ต้องมี specific incoming test procedure สำหรับ high-risk parts</div>

<!-- Speaker: US DoD ประเมิน counterfeit เป็น billion-dollar problem ต่อปี — civilian sector ก็ไม่ต่างกัน -->

---

## ประเมิน EMS Partner: 5 คำถามที่ต้องถาม

<p class="subhead">Badge ไม่พอ — Supply chain resilience วัดได้จากคำตอบ 5 ข้อนี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Green Answers</p>
    <h3>EMS ที่ดีตอบว่า...</h3>
    <ul>
      <li><b>BOM risk scan:</b> "ทำตั้งแต่ RFQ/onboarding"</li>
      <li><b>Lifecycle tool:</b> "ใช้ SiliconExpert / Z2Data / IHS real-time feed"</li>
      <li><b>AVL coverage:</b> "critical parts >80% มี qualified 2nd source"</li>
      <li><b>LTB track record:</b> "ปีที่แล้วทำ N LTBs — รายการนี้คือ..."</li>
      <li><b>Counterfeit policy:</b> "Authorized-only + incoming inspection procedure"</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Red Answers</p>
    <h3>EMS ที่เสี่ยงตอบว่า...</h3>
    <ul>
      <li><b>BOM risk scan:</b> "ทำหลังจาก PO ออก" หรือ "ไม่มี formal process"</li>
      <li><b>Lifecycle tool:</b> "ดูจาก distributor website เอง"</li>
      <li><b>AVL coverage:</b> ตอบไม่ได้ว่ากี่ %</li>
      <li><b>LTB track record:</b> "ไม่แน่ใจ" หรือ "ทำเมื่อ customer ถาม"</li>
      <li><b>Counterfeit policy:</b> "ไม่มี procedure เป็นทางการ"</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่ดีรู้ว่า program ของคุณมี red part กี่ตัว — ก่อนที่คุณจะถาม</div>

<!-- Speaker: ถามให้เจาะจง: "show me your last 3 BOM risk reports" — documentation เป็น evidence ที่ดีที่สุด -->

---

## Key Takeaways: Supply Chain ที่ Resilient สร้างตั้งแต่ Design Phase

<p class="subhead">ปัญหา obsolescence แก้ไม่ได้ด้วยการ expedite — แก้ได้ด้วยการ design for replaceability</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Design Time</p>
    <h3>สร้าง resilience ตั้งแต่วันแรก</h3>
    <ul>
      <li>Prefer multi-source components ตั้งแต่ schematic phase</li>
      <li>ระบุ FFF equivalent ก่อน BOM lock</li>
      <li>ทำ BOM risk scan ตั้งแต่ RFQ — ไม่ใช่หลัง PO</li>
      <li>Target: >80% critical parts มี qualified 2nd source</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Production Time</p>
    <h3>Monitor + Act Proactively</h3>
    <ul>
      <li>Lifecycle monitoring ต้องเป็น continuous — ไม่ใช่ one-time</li>
      <li>LTB execute ตั้งแต่ Phase-Out window เปิด (ไม่รอ Obsolescence)</li>
      <li>Bonded inventory กับ authorized distributor แทน spot buy จาก broker</li>
      <li>Re-design = last resort; qualify ล่วงหน้า 12–18 เดือนสำหรับ regulated product</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> US Air Force ใช้ structured lifetime buys + cross-sourcing → cost avoidance $1.2B (2012–2021); ROI ของ proactive obsolescence management วัดได้จริง</div>

<!-- Speaker: ถ้า EMS ของคุณไม่มี answer สำหรับ 5 คำถามในสไลด์ก่อน — นั่นคือ supply chain risk ที่คุณกำลังรับ -->
