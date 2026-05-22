---
marp: true
theme: default
paginate: true
title: "Project Charter สำหรับงาน SI"
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
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
  table { width:100%; border-collapse:collapse; font-size:13px; }
  th { background:var(--soft); color:var(--ink); font-weight:700; padding:8px 12px; text-align:left; }
  td { padding:7px 12px; border-bottom:1px solid var(--soft-2); color:var(--ink-dim); }
  tr:last-child td { border-bottom:none; }
---

<!-- _class: title -->

<div class="mark"></div>

# Project Charter สำหรับงาน SI

<p class="tag">กรอบโครงการตั้งแต่ Pre-Sales จนถึง Maintenance — ผูก technical scope กับ commercial terms</p>

<!-- Speaker: Charter ใน SI project ไม่ใช่แค่เอกสารเริ่มต้น — มันคือ master contract ภายในที่ PM ต้องใช้ควบคุม scope, cash flow, และ acceptance criteria ตลอดโครงการ -->

---

## Charter คือ Master Contract ภายใน — ไม่ใช่แค่เอกสารเริ่มต้น

<p class="subhead">ถ้า Charter ไม่ครอบตั้งแต่ต้น PM จะเจอ scope creep, delayed payment, และ certification surprise</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="grid-template-rows:1fr 1fr;">
  <div class="card compact">
    <p class="label">Technical</p>
    <h3>Scope ครบทุก Discipline</h3>
    <p>ME / EE / PCB / FW / SW / WebApp — พร้อม interface definition ระหว่าง discipline</p>
  </div>
  <div class="card compact">
    <p class="label">Design Governance</p>
    <h3>Design Review Gates</h3>
    <p>SRR → PDR → CDR — freeze irreversible decisions ก่อนลงทุนแพงขึ้น</p>
  </div>
  <div class="card compact">
    <p class="label">Build Pipeline</p>
    <h3>Build Stages + Certification</h3>
    <p>EVT / DVT / PVT timeline + certification lead time plot บน master schedule</p>
  </div>
  <div class="card gold compact">
    <p class="label">Acceptance</p>
    <h3>SAT / UAT Protocol</h3>
    <p>Checklist + acceptance criteria กำหนดใน Charter ก่อน commissioning — ไม่ negotiate ที่ site</p>
  </div>
  <div class="card gold compact">
    <p class="label">Commercial</p>
    <h3>Invoice Schedule</h3>
    <p>Payment trigger ผูกกับ technical milestone — PO, CDR, EVT, SAT, Final Acceptance</p>
  </div>
  <div class="card compact" style="border-left-color:var(--muted);">
    <p class="label">Note</p>
    <h3>Charter ≠ Contract</h3>
    <p>Charter คือ internal alignment tool — แต่ต้องสอดคล้องกับ legal contract กับลูกค้าเสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Charter ที่ขาด commercial terms คือ Gantt chart ธรรมดา — ไม่ใช่ master contract ของ SI</div>

<!-- Speaker: Charter ต้องผูก technical กับ commercial ไว้ด้วยกัน ถ้ามีแค่ Gantt แต่ไม่มี invoice trigger จะควบคุม cash flow ไม่ได้ -->

---

## SI Project ซับซ้อนกว่า SW-Only เพราะ 4 เหตุผลนี้

<p class="subhead">ทุก challenge นี้ต้องกำหนด mitigation ใน Charter ตั้งแต่ก่อน PO</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Dependency Risk</p>
    <h3>HW/FW/SW Interdependency</h3>
    <p>Bug ใน firmware บล็อก SW test ทั้ง sprint — cycle time ยาวกว่า pure SW มาก</p>
  </div>
  <div class="card warning">
    <p class="label">Procurement Risk</p>
    <h3>Long-Lead Items</h3>
    <p>PCB fabrication, mechanical tooling, regulatory testing ใช้เวลา 4–24 สัปดาห์ — ต้อง plan ก่อน kick-off</p>
  </div>
  <div class="card gold">
    <p class="label">Commercial Risk</p>
    <h3>Contractual Milestones</h3>
    <p>Payment trigger ผูกกับ physical deliverables (prototype, SAT) — ไม่ใช่ commit หรือ story point</p>
  </div>
  <div class="card">
    <p class="label">Timeline Risk</p>
    <h3>Certification Latency</h3>
    <p>CE, FCC, UL, TISI ใช้เวลา 6–12 สัปดาห์+ — fail ครั้งเดียวดัน deployment ออก 1–3 เดือน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก risk นี้ต้องมี mitigation plan ใน Charter ก่อนลงนาม — ไม่ใช่ manage ระหว่าง execution</div>

<!-- Speaker: นี่คือ 4 เหตุผลว่าทำไม SI PM ต้องทำ Charter ให้ครอบคลุมกว่า PM ใน pure-software project -->

---

## Charter เริ่มก่อน PO — ไม่ใช่ที่ Kick-off Meeting

<p class="subhead">PO คือ official Day 1; แต่ Charter ต้อง pre-draft ให้ตรงกับ proposal ก่อน customer sign</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 5 stages -->
  <rect x="30" y="100" width="170" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="115" y="143" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Proposal</text>
  <text x="115" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Solution + Quotation</text>
  <text x="115" y="181" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Charter pre-draft starts</text>
  <polygon points="208,150 222,142 222,158" fill="var(--muted)"/>
  <rect x="230" y="100" width="170" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="315" y="143" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Customer</text>
  <text x="315" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Review &amp; Approve</text>
  <polygon points="408,150 422,142 422,158" fill="var(--muted)"/>
  <rect x="430" y="80" width="200" height="140" rx="12" fill="var(--accent)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.3))"/>
  <text x="530" y="130" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">PO Release</text>
  <text x="530" y="155" font-size="13" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Official Day 1</text>
  <text x="530" y="175" font-size="13" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Charter activated</text>
  <text x="530" y="195" font-size="12" fill="rgba(255,255,255,.7)" text-anchor="middle" font-family="system-ui">Kick-off meeting</text>
  <polygon points="638,150 652,142 652,158" fill="var(--accent)"/>
  <rect x="660" y="100" width="170" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="745" y="143" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Execution</text>
  <text x="745" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Design + Build</text>
  <text x="745" y="181" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Charter = living doc</text>
  <polygon points="838,150 852,142 852,158" fill="var(--muted)"/>
  <rect x="860" y="100" width="170" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="945" y="143" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Handover</text>
  <text x="945" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SAT/UAT + MA/SLA</text>
  <text x="945" y="181" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Change via ECO/ECR</text>
  <text x="30" y="240" font-size="12" fill="var(--danger)" font-family="system-ui" font-weight="600">Risk: Charter ที่ไม่ sync กับ quotation → scope mismatch วันแรก</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า pre-draft Charter ไม่ตรงกับ proposal ที่ขายไป โครงการเริ่มผิดตั้งแต่วินาทีที่ลงนาม</div>

<!-- Speaker: นี่คือ mistake ที่พบบ่อยที่สุด — PM รอให้ได้ PO ก่อนค่อย draft Charter แต่ถึงเวลานั้น scope ที่ตกลงกับ quotation อาจ mismatch แล้ว -->

---

## Scope ต้องครอบ 6 Engineering Disciplines พร้อม Interface Dependencies

<p class="subhead">PM ต้องกำหนด interface definition ชัดเจนเพื่อป้องกัน "ฉันรอ HW/FW อยู่" loop ที่ไม่มี owner</p>

<div class="infographic">

| Discipline | ตัวอย่าง Deliverable | Key Dependency |
|---|---|---|
| **ME** (Mechanical) | Enclosure, PCB holder, thermal design | Dimension → FW thermal limit |
| **EE** (Electrical) | Schematic, BOM, power budget | Voltage rails → FW power mgmt |
| **PCB** | Gerber, assembly drawing, stack-up | Component lead time |
| **FW** (Firmware) | BSP, driver, OTA update | HW bring-up sequence |
| **SW / App** | Backend API, mobile app, web dashboard | API contract with FW |
| **WebApp** | Portal, reporting, configuration UI | SW API availability |

</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก discipline ต้องมี interface lock date ใน Charter — วันที่ definition freeze ก่อน dependent team เริ่ม integrate</div>

<!-- Speaker: ความซับซ้อนของ SI อยู่ที่ cross-discipline dependency ไม่ใช่ความซับซ้อนของ discipline เดียว -->

---

## Design Review Gates ทำหน้าที่ Freeze Irreversible Decisions

<p class="subhead">SRR → PDR → CDR คือ gated lifecycle — แต่ละ gate authorize การลงทุนที่ cost สูงขึ้นในขั้นถัดไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Gate 1: SRR -->
  <rect x="20" y="60" width="300" height="200" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="60" width="300" height="44" rx="12" fill="var(--accent)" opacity=".15"/>
  <rect x="20" y="88" width="300" height="16" rx="0" fill="var(--accent)" opacity=".15"/>
  <text x="170" y="88" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SRR</text>
  <text x="170" y="107" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">System Requirements Review</text>
  <text x="40" y="138" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="600">Validates:</text>
  <text x="40" y="158" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Requirements ครบ, consistent,</text>
  <text x="40" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">verifiable; verification plan OK</text>
  <text x="40" y="205" font-size="12" fill="var(--success-ink)" font-family="system-ui" font-weight="600">Freezes:</text>
  <text x="40" y="223" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Requirements baseline</text>
  <text x="40" y="241" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Authorizes: preliminary design</text>
  <!-- Arrow 1 -->
  <polygon points="328,150 346,142 346,158" fill="var(--accent)"/>
  <line x1="320" y1="150" x2="346" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <!-- Gate 2: PDR -->
  <rect x="354" y="60" width="300" height="200" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="354" y="60" width="300" height="44" rx="12" fill="var(--accent)" opacity=".25"/>
  <rect x="354" y="88" width="300" height="16" rx="0" fill="var(--accent)" opacity=".25"/>
  <text x="504" y="88" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">PDR</text>
  <text x="504" y="107" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Preliminary Design Review</text>
  <text x="374" y="138" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="600">Validates:</text>
  <text x="374" y="158" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Architecture + interfaces meet</text>
  <text x="374" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">requirements with margin</text>
  <text x="374" y="205" font-size="12" fill="var(--success-ink)" font-family="system-ui" font-weight="600">Freezes:</text>
  <text x="374" y="223" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Architecture; long-lead</text>
  <text x="374" y="241" font-size="12" fill="var(--ink-dim)" font-family="system-ui">procurement authorized</text>
  <!-- Arrow 2 -->
  <polygon points="662,150 680,142 680,158" fill="var(--accent)"/>
  <line x1="654" y1="150" x2="680" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <!-- Gate 3: CDR -->
  <rect x="688" y="60" width="300" height="200" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="688" y="60" width="300" height="44" rx="12" fill="var(--accent)" opacity=".4"/>
  <rect x="688" y="88" width="300" height="16" rx="0" fill="var(--accent)" opacity=".4"/>
  <text x="838" y="88" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CDR</text>
  <text x="838" y="107" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Critical Design Review</text>
  <text x="708" y="138" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="600">Validates:</text>
  <text x="708" y="158" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Detailed design complete,</text>
  <text x="708" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">producible, traceable to reqs</text>
  <text x="708" y="205" font-size="12" fill="var(--success-ink)" font-family="system-ui" font-weight="600">Freezes:</text>
  <text x="708" y="223" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Drawings + BOM; manufacturing</text>
  <text x="708" y="241" font-size="12" fill="var(--ink-dim)" font-family="system-ui">and prototype build authorized</text>
  <!-- Post-CDR label -->
  <rect x="1000" y="110" width="90" height="80" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="1045" y="145" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">EVT</text>
  <text x="1045" y="163" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Build</text>
  <text x="1045" y="179" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Starts</text>
  <polygon points="994,150 1000,142 1000,158" fill="var(--success)"/>
  <!-- Warning note -->
  <text x="20" y="295" font-size="12" fill="var(--danger)" font-family="system-ui" font-weight="600">Skip any gate → rework cost multiplies 5-10x when found late</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก gate freeze irreversible decisions — SRR ถูกที่สุดที่จะแก้; หลัง CDR ทุก change ต้องผ่าน ECO</div>

<!-- Speaker: ค่า rework ที่พบที่ SRR แก้ถูกมาก แต่ปัญหา requirements เดียวกันถ้าเจอที่ CDR หรือ EVT ค่า rework อาจสูงขึ้น 10x -->

---

## EVT / DVT / PVT: Build สามรอบ เป้าหมายต่างกันโดยสิ้นเชิง

<p class="subhead">แต่ละ stage มี exit criteria เฉพาะตัว — ผ่านหนึ่งแล้วเข้าถัดไป ไม่ใช่ iterate ใน stage เดิม</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- EVT -->
  <rect x="20" y="20" width="330" height="270" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="20" width="330" height="52" rx="14" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="20" y="52" width="330" height="20" fill="var(--warning-wash)"/>
  <text x="185" y="52" font-size="20" font-weight="800" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">EVT</text>
  <text x="185" y="69" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Engineering Validation Test</text>
  <text x="40" y="105" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">Goal: เลือก design configuration</text>
  <text x="40" y="128" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Qty: 100–1,000 units</text>
  <text x="40" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">First time: looks-like + works-like</text>
  <text x="40" y="168" font-size="12" fill="var(--ink-dim)" font-family="system-ui">ใน production-intent materials</text>
  <text x="40" y="195" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">Accept: failure rate สูงปกติ</text>
  <text x="40" y="215" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Up to 40% in reliability test = OK</text>
  <rect x="30" y="238" width="310" height="40" rx="8" fill="var(--warning-wash)"/>
  <text x="185" y="260" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Exit: 1 config passes all requirements</text>
  <!-- Arrow EVT→DVT -->
  <polygon points="358,155 376,147 376,163" fill="var(--accent)"/>
  <line x1="350" y1="155" x2="376" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <!-- DVT -->
  <rect x="384" y="20" width="330" height="270" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="384" y="20" width="330" height="52" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="384" y="52" width="330" height="20" fill="var(--accent-wash)"/>
  <text x="549" y="52" font-size="20" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">DVT</text>
  <text x="549" y="69" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Design Validation Test</text>
  <text x="404" y="105" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">Goal: verify mass production yield</text>
  <text x="404" y="128" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Qty: 300–2,000 units</text>
  <text x="404" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Parts: hard tools + mass-production</text>
  <text x="404" y="168" font-size="12" fill="var(--ink-dim)" font-family="system-ui">processes เท่านั้น</text>
  <text x="404" y="195" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">ระบุ yield issues + corrective</text>
  <text x="404" y="215" font-size="12" fill="var(--ink-dim)" font-family="system-ui">actions ก่อนเข้า PVT</text>
  <rect x="394" y="238" width="310" height="40" rx="8" fill="var(--accent-wash)"/>
  <text x="549" y="260" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700">Exit: high confidence in yield at scale</text>
  <!-- Arrow DVT→PVT -->
  <polygon points="722,155 740,147 740,163" fill="var(--accent)"/>
  <line x1="714" y1="155" x2="740" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <!-- PVT -->
  <rect x="748" y="20" width="330" height="270" rx="14" fill="var(--soft)" stroke="var(--success)" stroke-width="2"/>
  <rect x="748" y="20" width="330" height="52" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="748" y="52" width="330" height="20" fill="var(--success-wash)"/>
  <text x="913" y="52" font-size="20" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">PVT</text>
  <text x="913" y="69" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Production Validation Test</text>
  <text x="768" y="105" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">Goal: verify yield at production speed</text>
  <text x="768" y="128" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Qty: 1K–20K units</text>
  <text x="768" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Units คือ units ที่จะขายจริง</text>
  <text x="768" y="168" font-size="12" fill="var(--ink-dim)" font-family="system-ui">No parallel experimental builds</text>
  <text x="768" y="195" font-size="12" fill="var(--ink)" font-family="system-ui" font-weight="700">Transitions to: Ramp / MP</text>
  <text x="768" y="215" font-size="12" fill="var(--ink-dim)" font-family="system-ui">ไม่ย้อนกลับ DVT อีกแล้ว</text>
  <rect x="758" y="238" width="310" height="40" rx="8" fill="var(--success-wash)"/>
  <text x="913" y="260" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Exit: MP yields at production speed</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Charter ต้องกำหนด spin budget (จำนวน PCB revision ที่ยอมรับ) และ escalation path ถ้าเกิน budget</div>

<!-- Speaker: EVT = เลือก design, DVT = prove yield, PVT = prove speed — objective ต่างกันโดยสิ้นเชิง อย่า mix กัน -->

---

## Certification ต้อง Plot บน Gantt ก่อนกำหนด Deployment Date

<p class="subhead">ห้ามกำหนด deployment date แล้วค่อย plan certification — ต้องทำกลับกัน</p>

<div class="infographic">

| Certification | Coverage | ประมาณเวลา | Buffer แนะนำ |
|---|---|---|---|
| CE (Europe) | EMC + Safety | 6–12 สัปดาห์ | +20% = 7–14 สัปดาห์ |
| FCC (US) | Radio frequency | 4–8 สัปดาห์ | +20% = 5–10 สัปดาห์ |
| UL/ETL (US Safety) | Electrical safety | 8–16 สัปดาห์ | +20% = 10–19 สัปดาห์ |
| TISI (ไทย) | มอก. | 4–12 สัปดาห์ | +20% = 5–14 สัปดาห์ |
| IP Rating | Ingress protection | 2–4 สัปดาห์ | +20% = 3–5 สัปดาห์ |
| IEC 61508 (Func. Safety) | Safety-critical | 12–24 สัปดาห์ | +20% = 14–29 สัปดาห์ |

</div>

<div class="takeaway"><b>★ Takeaway:</b> Certification fail = +1–3 เดือน; ต้อง buffer 20% ทุกรายการและ submit ทันทีหลัง DVT pass</div>

<!-- Speaker: lab backlog และ regulatory revision กระทบ lead time เสมอ ควร submit certification ทันทีหลัง DVT pass ไม่รอ PVT -->

---

## Deployment: FAT → Commissioning → SAT → UAT คือ 4 Milestone เชิงสัญญา

<p class="subhead">SAT pass คือ payment trigger หลัก — ต้องมี protocol และ acceptance criteria กำหนดใน Charter ตั้งแต่ต้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- FAT -->
  <rect x="20" y="60" width="220" height="160" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="130" y="100" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FAT</text>
  <text x="130" y="118" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Factory Acceptance Test</text>
  <text x="130" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่ SI facility</text>
  <text x="130" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตาม spec / controlled</text>
  <rect x="30" y="192" width="200" height="20" rx="6" fill="var(--soft-2)"/>
  <text x="130" y="206" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Pass = authorized to ship</text>
  <polygon points="247,140 265,132 265,148" fill="var(--accent)"/>
  <!-- Commissioning -->
  <rect x="273" y="60" width="220" height="160" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="383" y="100" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Commissioning</text>
  <text x="383" y="118" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Field Installation</text>
  <text x="383" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่ customer site</text>
  <text x="383" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Connect: power, network, ERP</text>
  <rect x="283" y="192" width="200" height="20" rx="6" fill="var(--soft-2)"/>
  <text x="383" y="206" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Physical + integration complete</text>
  <polygon points="500,140 518,132 518,148" fill="var(--accent)"/>
  <!-- SAT -->
  <rect x="526" y="40" width="240" height="200" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="646" y="85" font-size="18" font-weight="800" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">SAT</text>
  <text x="646" y="104" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Site Acceptance Test</text>
  <text x="646" y="132" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่ customer site</text>
  <text x="646" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Actual load + conditions จริง</text>
  <text x="646" y="168" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Integration กับ existing systems</text>
  <rect x="536" y="208" width="220" height="22" rx="6" fill="var(--accent)"/>
  <text x="646" y="223" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui" font-weight="700">Pass = PAYMENT TRIGGER</text>
  <polygon points="773,140 791,132 791,148" fill="var(--accent)"/>
  <!-- UAT -->
  <rect x="799" y="60" width="280" height="160" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="939" y="100" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">UAT</text>
  <text x="939" y="118" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">User Acceptance Test</text>
  <text x="939" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">End-user ทดสอบ SW layer</text>
  <text x="939" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Parallel หรือ หลัง SAT</text>
  <rect x="809" y="192" width="260" height="20" rx="6" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="939" y="206" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Pass = Handover + Warranty starts</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SAT protocol ที่ไม่ชัดเจนใน Charter = customer negotiate acceptance criteria ที่ commissioning site — เสียเปรียบแน่นอน</div>

<!-- Speaker: SAT ต่างจาก FAT ตรงที่ validate ใน real operating environment — actual load, real ambient, integration กับ existing systems ที่ customer มีอยู่ -->

---

## Invoice ผูกกับ Milestone = ควบคุม Cash Flow และ Risk

<p class="subhead">PM ต้อง negotiate invoice schedule พร้อมกับ technical scope ก่อนลงนาม contract</p>

<div class="infographic">

| Invoice Trigger | % Payment | เหตุผล |
|---|---|---|
| Upon PO release | 15–30% | Mobilization fee; cover long-lead procurement |
| Design approval (CDR pass) | 10–15% | Protect design investment |
| Prototype delivery (EVT) | 10–15% | Hardware deliverable |
| Test pass (DVT/PVT) | 10–15% | Validated design |
| Certification approval | 5–10% | Regulatory milestone |
| Installation completion | 10–15% | Physical milestone at site |
| SAT pass | 15–20% | Contractual acceptance |
| Final acceptance (UAT + warranty) | 5–10% | Project closeout |

</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า customer cancel หลัง CDR pass, SI ได้รับ payment ครอบ design cost แล้ว — นี่คือ risk distribution ที่ดี</div>

<!-- Speaker: milestone-linked invoice ป้องกัน SI จากการลงทุน hardware + labor แล้ว customer ไม่จ่าย — cash flow ต้องวาง model จากวันแรก -->

---

## RACI Matrix ป้องกัน "ใครเป็น Owner?" ตลอดโครงการ

<p class="subhead">R=Responsible, A=Accountable, C=Consulted, I=Informed — ทุก activity ต้องมี A เสมอ</p>

<div class="infographic">

| Activity | PM | HW Lead | FW Lead | SW Lead | QA | Customer |
|---|---|---|---|---|---|---|
| Requirements sign-off | **A** | C | C | C | C | R |
| SRR/PDR/CDR approval | **A** | R | R | R | C | I |
| Design freeze | **A** | R | C | C | C | I |
| EVT/DVT/PVT execution | I | R | R | R | **A** | I |
| Certification submission | **A** | R | C | C | C | I |
| SAT execution | **A** | R | I | I | R | R |
| Invoice approval | I | I | I | I | I | **A** |
| Change control (ECO) | **A** | R | C | C | R | I |

</div>

<div class="takeaway"><b>★ Takeaway:</b> Customer เป็น A สำหรับ invoice approval เท่านั้น — ทุก technical decision PM เป็น Accountable</div>

<!-- Speaker: RACI ใน Charter ป้องกัน blame game หลัง project มีปัญหา — ชัดเจนว่าใครต้อง approve อะไร -->

---

## Change Control: ECR → ECO → ECN รักษา Design Baseline หลัง CDR

<p class="subhead">ทุก change หลัง CDR freeze ต้องผ่าน CCB — ไม่มีทางลัด; artifact ทุกชิ้นต้อง version พร้อม ECO number</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Step 1</p>
    <h3>ECR</h3>
    <p><strong>Engineering Change Request</strong></p>
    <ul>
      <li>ใครๆ raise ได้</li>
      <li>ระบุ: problem + proposed change + impact (cost/schedule/risk)</li>
      <li>CCB review → approve/reject</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Step 2</p>
    <h3>ECO</h3>
    <p><strong>Engineering Change Order</strong></p>
    <ul>
      <li>ECR approved → convert to ECO</li>
      <li>ระบุ affected: BOM, drawings, FW version, test plan</li>
      <li>CCB ทั้งหมด (PM+HW+FW+SW+QA) ต้อง approve</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Step 3</p>
    <h3>ECN</h3>
    <p><strong>Engineering Change Notice</strong></p>
    <ul>
      <li>Communicate ECO ที่ approved</li>
      <li>Update configuration baseline</li>
      <li>Version: PCB Rev A→B→C + ECO reference</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "PCB Rev B (ECO-0012)" — ทุก design artifact ต้องมี version ที่ trace กลับไปหา ECO เสมอ</div>

<!-- Speaker: ECR ถาม "ควรเปลี่ยนไหม?" ECO บอก "เปลี่ยนอะไรบ้าง?" ECN แจ้ง "เปลี่ยนแล้วนะ" — สามขั้นตอนนี้สร้าง audit trail ที่ trace ได้ -->

---

## HW/FW/SW Sync: หัวใจของ SI คือ Interface Lock Date

<p class="subhead">Dependency chain ข้าม discipline คือต้นเหตุ delay อันดับ 1 ใน SI project</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Row labels -->
  <text x="20" y="85" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">HW</text>
  <text x="20" y="175" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">FW</text>
  <text x="20" y="265" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">SW</text>
  <!-- HW timeline -->
  <rect x="60" y="60" width="200" height="50" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="160" y="89" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">PCB Design</text>
  <rect x="268" y="60" width="160" height="50" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="348" y="89" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">PCB Fab (4–6 wk)</text>
  <rect x="436" y="60" width="160" height="50" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="516" y="89" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">HW Bring-up</text>
  <!-- Interface lock line -->
  <line x1="260" y1="40" x2="260" y2="290" stroke="var(--gold)" stroke-width="2" stroke-dasharray="6,3"/>
  <rect x="210" y="20" width="150" height="24" rx="6" fill="var(--gold)" opacity=".15"/>
  <text x="285" y="35" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Interface Lock Date</text>
  <!-- FW timeline -->
  <rect x="60" y="150" width="190" height="50" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="155" y="179" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HW Emulator (parallel)</text>
  <rect x="436" y="150" width="180" height="50" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="526" y="171" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">FW Porting +</text>
  <text x="526" y="188" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Driver Dev</text>
  <rect x="624" y="150" width="180" height="50" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="714" y="179" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">FW Integration</text>
  <!-- SW timeline -->
  <rect x="60" y="240" width="190" height="50" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="155" y="269" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FW Stub API (parallel)</text>
  <rect x="624" y="240" width="200" height="50" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="724" y="269" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SW Integration Test</text>
  <rect x="832" y="240" width="180" height="50" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="922" y="269" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">System Test (EVT)</text>
  <!-- dependency arrows -->
  <line x1="616" y1="85" x2="616" y2="150" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,2"/>
  <polygon points="610,148 616,158 622,148" fill="var(--accent)"/>
  <line x1="714" y1="200" x2="714" y2="240" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,2"/>
  <polygon points="708,238 714,248 720,238" fill="var(--accent)"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Interface Lock Date = วันที่ FW/SW team หยุดรอ HW spec — ก่อนวันนั้นต้องใช้ emulator/stub เพื่อไม่หยุดนิ่ง</div>

<!-- Speaker: Parallel simulation คือ technique ที่สำคัญที่สุดในการ manage SI dependency — FW ไม่ต้องรอ PCB จริง SW ไม่ต้องรอ FW จริง -->

---

## Key Takeaways: Charter ที่ดีทำงานแทน PM ตลอด 24 ชั่วโมง

<p class="subhead">7 หลักการที่ PM ต้องแน่ใจว่ามีใน Charter ก่อนลงนาม</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card gold">
    <p class="label">Commercial</p>
    <h3>Invoice ผูก Milestone</h3>
    <p>ทุก payment trigger ต้องมี technical milestone รองรับ — ไม่ใช่แค่ calendar date</p>
  </div>
  <div class="card">
    <p class="label">Design Governance</p>
    <h3>SRR → PDR → CDR</h3>
    <p>Risk gates ที่ freeze decisions ก่อนลงทุนแพงขึ้น — ข้ามไม่ได้โดยไม่มี penalty</p>
  </div>
  <div class="card warning">
    <p class="label">Build Stages</p>
    <h3>EVT / DVT / PVT</h3>
    <p>แต่ละ stage มี exit criteria เฉพาะ — EVT=select, DVT=yield, PVT=speed</p>
  </div>
  <div class="card success">
    <p class="label">Acceptance</p>
    <h3>SAT Protocol</h3>
    <p>ต้องกำหนด checklist + acceptance criteria ใน Charter ก่อน commissioning</p>
  </div>
  <div class="card danger">
    <p class="label">Certification</p>
    <h3>Plot Before Deploy</h3>
    <p>Cert timeline บน Gantt ก่อนกำหนด deployment date — buffer 20% ทุกรายการ</p>
  </div>
  <div class="card">
    <p class="label">Change Control</p>
    <h3>ECO/ECR + RACI</h3>
    <p>ทุก change หลัง CDR ผ่าน CCB — version ทุก artifact + interface lock date</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Charter ที่ครอบตั้งแต่ต้นคือ alignment tool ที่มีค่าที่สุดของ SI PM — ลงทุนเวลาที่ pre-sales คืนทุนตลอดโครงการ</div>

<!-- Speaker: จบด้วย action item: ถ้า project กำลังเริ่ม ให้ check Charter ว่ามี 5 องค์ประกอบครบไหม — scope, gates, build stages, acceptance criteria, invoice schedule -->
