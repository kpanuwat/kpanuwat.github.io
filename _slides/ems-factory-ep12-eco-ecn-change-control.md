---
marp: true
theme: default
paginate: true
title: "EMS Factory EP12: ECO/ECN — Engineering Change Control"
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

# EMS Factory EP12
# ECO/ECN Change Control

<p class="tag">ECR → ECO → ECN · CCB · Cut-in Control · PLM/ERP/MES Integration</p>

<!-- Speaker: Every change in a factory—component swap, process tweak, test limit—must go through a controlled channel. This deck shows why and how. -->

---

## ทุกการเปลี่ยนแปลงที่ไม่ Controlled คือความเสี่ยงที่ซ่อนอยู่

<p class="subhead">Silent change, mixed build, defect escape — ทั้งสามคือผลลัพธ์ของ change ที่ bypass ECO process</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Causal chain: No ECO → Silent Change → Mixed Build → Defect Escape -->
  <!-- Starting event -->
  <rect x="30" y="110" width="200" height="120" rx="12" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="130" y="156" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Change ไม่มี ECO</text>
  <text x="130" y="178" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">operator เปลี่ยน component</text>
  <text x="130" y="198" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">โดยไม่ผ่าน approval</text>
  <!-- Arrow 1 -->
  <line x1="234" y1="170" x2="270" y2="170" stroke="var(--danger)" stroke-width="2.5" stroke-dasharray="6,3"/>
  <polygon points="270,163 284,170 270,177" fill="var(--danger)"/>
  <!-- Silent Change -->
  <rect x="286" y="90" width="220" height="160" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="396" y="130" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Silent Change</text>
  <text x="396" y="154" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่มี traceability</text>
  <text x="396" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่รู้ว่า unit ไหน affect</text>
  <text x="396" y="194" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่มี impact analysis</text>
  <text x="396" y="218" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">root cause ไม่ได้</text>
  <!-- Arrow 2 -->
  <line x1="510" y1="170" x2="546" y2="170" stroke="var(--danger)" stroke-width="2.5" stroke-dasharray="6,3"/>
  <polygon points="546,163 560,170 546,177" fill="var(--danger)"/>
  <!-- Mixed Build -->
  <rect x="562" y="90" width="220" height="160" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="672" y="130" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Mixed Build</text>
  <text x="672" y="154" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">old + new spec ปะปน</text>
  <text x="672" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">แยก lot ไม่ออก</text>
  <text x="672" y="194" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ต้อง recall ทั้งหมด</text>
  <text x="672" y="218" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">แทนที่จะ recall เฉพาะ lot</text>
  <!-- Arrow 3 -->
  <line x1="786" y1="170" x2="822" y2="170" stroke="var(--danger)" stroke-width="2.5" stroke-dasharray="6,3"/>
  <polygon points="822,163 836,170 822,177" fill="var(--danger)"/>
  <!-- Defect Escape -->
  <rect x="838" y="90" width="232" height="160" rx="12" fill="var(--danger)" opacity=".12" stroke="var(--danger)" stroke-width="2.5"/>
  <text x="954" y="130" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Defect Escape</text>
  <text x="954" y="154" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">หลุดถึงลูกค้า</text>
  <text x="954" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">warranty cost</text>
  <text x="954" y="194" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">regulatory penalty</text>
  <text x="954" y="218" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">loss of certification</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Silent change คืออันตรายที่สุด — ไม่ใช่เพราะมีผลทันที แต่เพราะไม่มีใครรู้ว่าเกิดขึ้น จนกว่าจะสายเกินไป</div>

<!-- Speaker: This is the "why" for the whole deck. Every governance mechanism exists to prevent this chain from starting. -->

---

## ECR vs ECO vs ECN: สามเอกสาร หน้าที่ต่างกัน

<p class="subhead">ใช้สลับกันบ่อย แต่แต่ละอันเป็น distinct step — bypass ใดหนึ่งคือ change ที่ขาด governance</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Step 1 · Identify</p>
    <h3>ECR</h3>
    <p><b>Engineering Change Request</b> — ใครก็ raise ได้: engineer, QA, OEM, supplier</p>
    <p>บันทึก: ปัญหาคืออะไร, found where, impact เบื้องต้น, business justification</p>
    <p>ยังไม่ authorize การเปลี่ยนแปลงใดๆ</p>
  </div>
  <div class="card">
    <p class="label">Step 2 · Authorize</p>
    <h3>ECO</h3>
    <p><b>Engineering Change Order</b> — formal mandate หลัง CCB approve</p>
    <p>ระบุ: part number affected, วิธี implement, effectivity date, inventory disposition, ทรัพยากร</p>
    <p>มีอำนาจตามกฎหมายในการ authorize change</p>
  </div>
  <div class="card success">
    <p class="label">Step 3 · Communicate</p>
    <h3>ECN</h3>
    <p><b>Engineering Change Notice</b> — signal ออกไปยังทุกฝ่ายหลัง ECO approve</p>
    <p>ระบุ: อะไรเปลี่ยน, ทำไม, มีผลตั้งแต่เมื่อไหร่ — trigger action ใน procurement, production, QA, warehouse</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ECR = identify, ECO = authorize, ECN = communicate — missing ใดใดหนึ่งคือ change ที่ incomplete; ECN ที่ไม่ออกคือ silent change ที่รอเกิดขึ้น</div>

<!-- Speaker: Many plants conflate ECO and ECN. The distinction matters: ECO is the decision, ECN is the execution signal. You need both. -->

---

## ECO Workflow: จาก Request ถึง Verified Closure

<p class="subhead">5 ขั้นตอนที่ต้องเกิดขึ้นครบก่อนปิด ECO — ข้ามขั้นตอนใดหนึ่งคือ change ที่ยังไม่ complete</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5-step arrow flow -->
  <rect x="20" y="90" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="105" cy="72" r="20" fill="var(--accent)"/>
  <text x="105" y="78" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="105" y="122" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Initiation</text>
  <text x="105" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ECR + evidence</text>
  <text x="105" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">business justification</text>
  <text x="105" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">log ใน PLM</text>
  <line x1="194" y1="160" x2="222" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="222,153 235,160 222,167" fill="var(--accent)"/>

  <rect x="237" y="90" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="322" cy="72" r="20" fill="var(--accent)"/>
  <text x="322" y="78" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="322" y="122" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Impact Analysis</text>
  <text x="322" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BOM, process, test</text>
  <text x="322" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">supply chain, PFMEA</text>
  <text x="322" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cross-functional</text>
  <line x1="411" y1="160" x2="439" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="439,153 452,160 439,167" fill="var(--accent)"/>

  <rect x="454" y="90" width="170" height="140" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="539" cy="72" r="20" fill="var(--warning)"/>
  <text x="539" y="78" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="539" y="122" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">CCB Approval</text>
  <text x="539" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">cross-functional sign-off</text>
  <text x="539" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">approve / reject / defer</text>
  <text x="539" y="180" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">formal ECO issued</text>
  <line x1="628" y1="160" x2="656" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="656,153 669,160 656,167" fill="var(--accent)"/>

  <rect x="671" y="90" width="170" height="140" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="756" cy="72" r="20" fill="var(--accent)"/>
  <text x="756" y="78" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="756" y="122" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Implementation</text>
  <text x="756" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ECN ออกทุกฝ่าย</text>
  <text x="756" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PLM→ERP→MES cascade</text>
  <text x="756" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cut-in control</text>
  <line x1="845" y1="160" x2="873" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="873,153 886,160 873,167" fill="var(--accent)"/>

  <rect x="888" y="90" width="192" height="140" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <circle cx="984" cy="72" r="20" fill="var(--success)"/>
  <text x="984" y="78" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="984" y="122" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Verify &amp; Close</text>
  <text x="984" y="144" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FAI / first-off verify</text>
  <text x="984" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">obsolete stock handled</text>
  <text x="984" y="180" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">training completed</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Impact Analysis (Step 2) คือขั้นตอนที่สำคัญที่สุดและมักถูก underestimate — ต้องครอบทั้ง BOM, process, test, supply chain, และ compliance</div>

<!-- Speaker: Most failures happen because step 2 was rushed. A 30-minute impact analysis prevents a 30-day recall. -->

---

## Cut-in Control: จัดการช่วงรอยต่อระหว่าง Old กับ New

<p class="subhead">ต้องตัดสินใจว่าจะ "cut in" ณ จุดไหน — ผิดพลาดคือ mixed build; ไม่ตัดสินใจเลยแย่กว่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4 cut-in strategies as comparison boxes -->
  <rect x="20" y="40" width="240" height="270" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="20" y="40" width="240" height="46" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="140" y="70" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Date Effectivity</text>
  <text x="140" y="112" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Change มีผลตั้งแต่วันที่กำหนด</text>
  <text x="140" y="136" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทุก order หลังวันนั้นใช้ spec ใหม่</text>
  <text x="140" y="175" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ ง่ายที่สุด</text>
  <text x="140" y="200" font-size="12" font-weight="600" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">- WIP ที่อยู่กลางคันอาจ mixed</text>
  <text x="140" y="260" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เหมาะกับ: ทั่วไป</text>
  <text x="140" y="280" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">low-risk change</text>

  <rect x="285" y="40" width="240" height="270" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="285" y="40" width="240" height="46" rx="12" fill="var(--accent)" opacity=".10"/>
  <text x="405" y="70" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Lot / SN Effectivity</text>
  <text x="405" y="112" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Change มีผลตั้งแต่ lot number</text>
  <text x="405" y="136" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">หรือ serial number ที่กำหนด</text>
  <text x="405" y="175" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ link กับ physical unit โดยตรง</text>
  <text x="405" y="200" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ traceability สูงสุด</text>
  <text x="405" y="260" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">เหมาะกับ: medical, automotive</text>
  <text x="405" y="280" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">regulated product</text>

  <rect x="550" y="40" width="240" height="270" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="550" y="40" width="240" height="46" rx="12" fill="var(--danger)" opacity=".10"/>
  <text x="670" y="70" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Immediate (Mandatory)</text>
  <text x="670" y="112" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Change มีผลทันที</text>
  <text x="670" y="136" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">legacy stock ต้อง quarantine</text>
  <text x="670" y="175" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ เร็วที่สุด</text>
  <text x="670" y="200" font-size="12" font-weight="600" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">- inventory write-off สูง</text>
  <text x="670" y="260" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">เหมาะกับ: safety / critical</text>
  <text x="670" y="280" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">quality issue เท่านั้น</text>

  <rect x="815" y="40" width="265" height="270" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.08))"/>
  <rect x="815" y="40" width="265" height="46" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="947" y="70" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Use-to-Exhaust</text>
  <text x="947" y="112" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ใช้ stock เก่าให้หมดก่อน</text>
  <text x="947" y="136" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">แล้ว cut-in ของใหม่</text>
  <text x="947" y="175" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ ประหยัด write-off</text>
  <text x="947" y="200" font-size="12" font-weight="600" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">- ต้องแน่ใจว่า old part ใช้ได้</text>
  <text x="947" y="260" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เหมาะกับ: cosmetic หรือ</text>
  <text x="947" y="280" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">non-functional change</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lot/SN Effectivity คือ gold standard สำหรับ regulated product — วัด traceability ได้ถึงระดับ unit แต่ต้องการ MES ที่ support barcode scan enforcement</div>

<!-- Speaker: The choice of cut-in strategy must be documented in the ECO itself. "We'll figure it out during implementation" is how mixed builds happen. -->

---

## PLM → ERP → MES: Change Cascade ผ่านสามระบบ

<p class="subhead">ECO หนึ่งใบ trigger การ update ในทุกระบบ — "air gap" ระหว่างระบบคือ root cause ของ silent change</p>

<div class="infographic">
<svg viewBox="0 0 1100 350" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Three tiers: PLM, ERP, MES -->
  <!-- PLM tier -->
  <rect x="30" y="20" width="1040" height="90" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="60" y="52" font-size="15" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">PLM (Product Lifecycle Management)</text>
  <text x="60" y="76" font-size="12" fill="var(--ink-dim)" font-family="system-ui">BOM revision control (EBOM → MBOM)  |  ECO/ECN workflow routing  |  Document management (drawings, specs)  |  Revision lock</text>
  <!-- Arrow PLM → ERP -->
  <line x1="550" y1="114" x2="550" y2="148" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="543,148 550,162 557,148" fill="var(--accent)"/>
  <rect x="420" y="118" width="260" height="24" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">API sync — automated on ECO approve</text>
  <!-- ERP tier -->
  <rect x="30" y="162" width="1040" height="90" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="60" y="194" font-size="15" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">ERP (Enterprise Resource Planning)</text>
  <text x="60" y="218" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Procurement list update (new part number)  |  Cost roll  |  Inventory disposition instruction  |  Work order effectivity date</text>
  <!-- Arrow ERP → MES -->
  <line x1="550" y1="256" x2="550" y2="290" stroke="var(--warning)" stroke-width="2.5"/>
  <polygon points="543,290 550,304 557,290" fill="var(--warning)"/>
  <rect x="390" y="260" width="320" height="24" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="276" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MES integration — push work instruction update</text>
  <!-- MES tier -->
  <rect x="30" y="304" width="1040" height="36" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="60" y="327" font-size="13" font-weight="700" fill="var(--success-ink)" font-family="system-ui">MES (Manufacturing Execution System)</text>
  <text x="400" y="327" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Work instruction (version-controlled)  |  Barcode scan enforcement  |  Routing  |  Inspection criteria</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Barcode scan enforcement ใน MES คือ last line of defense — operator ต้อง scan component ทุกชิ้น; ถ้า part number ไม่ตรงกับ ECO active ระบบ alert ทันที</div>

<!-- Speaker: In plants without API integration, engineers approve ECOs in PLM while shop floor operators still read paper binders from two revisions ago. That gap is where silent changes live. -->

---

## CCB Governance: ใครต้อง Sign-off อะไร

<p class="subhead">Change Control Board ทำงาน cross-functional — RACI matrix ระบุว่าใครมีอำนาจตัดสินใจในแต่ละ change type</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Engineering</p>
    <h3>Design Authority</h3>
    <p>ตรวจ fit-form-function — change ยังตรงกับ design intent ไหม, margin ยังพอไหม</p>
    <p>อนุมัติ: BOM revision, spec change, alternate component qualification</p>
  </div>
  <div class="card warning">
    <p class="label">Manufacturing + Quality</p>
    <h3>Process &amp; QA</h3>
    <p>Manufacturing: process ทำได้ไหม, tool ต้องเปลี่ยนไหม, training ต้องอัปเดตไหม</p>
    <p>QA: PFMEA update, control plan, inspection criteria ที่ต้องแก้ไข</p>
  </div>
  <div class="card success">
    <p class="label">Supply Chain + Finance</p>
    <h3>Operations</h3>
    <p>Supply Chain: new part lead time, existing stock disposition, supplier qualification</p>
    <p>Finance: inventory write-off cost, tooling cost, ผลกระทบต่อ COGS</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ใช่ทุก ECO ต้องผ่าน full CCB — change ที่ low risk ควร delegate ให้ functional owner ตัดสินใจเองได้เพื่อลด cycle time; RACI matrix ช่วยกำหนดว่าขอบเขตอยู่ที่ไหน</div>

<!-- Speaker: Full CCB for every change creates a bottleneck. Smart governance tiers changes by risk: cosmetic changes are delegated, safety-critical changes always go to full board. -->

---

## Key Takeaways

<p class="subhead">ECO/ECN คือ backbone ของ manufacturing discipline — ไม่ใช่ overhead</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Process</p>
    <h3>ECR → ECO → ECN — ครบทั้งสาม</h3>
    <ul>
      <li>ECR = identify (ยังไม่ authorize)</li>
      <li>ECO = formal mandate จาก CCB</li>
      <li>ECN = signal ออกทุกฝ่าย</li>
      <li>Verify &amp; Close ก่อนปิด ECO</li>
      <li>EMS-initiated change ต้องมี OEM written approval</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Risks &amp; Questions</p>
    <h3>ถาม EMS ก่อนเซ็น Contract</h3>
    <ul>
      <li>ECO cycle time เฉลี่ยกี่วัน?</li>
      <li>PLM integrate กับ ERP/MES แบบ API หรือ manual?</li>
      <li>Cut-in control ใช้ date / lot / SN effectivity?</li>
      <li>Barcode scan enforcement ใน MES มีไหม?</li>
      <li>Silent change ใน last 12 เดือนมีกี่ case?</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่ตอบว่า "ECO cycle time ของเรา 2–3 วัน + PLM-ERP-MES fully integrated" คือ partner ที่ change control ใช้งานได้จริง — ไม่ใช่แค่มี document</div>

<!-- Speaker: The five questions on the right are your evaluation rubric. An EMS that can answer all five with specifics has real change control. One that says "we have a process" but can't answer specifics — that's a risk. -->
