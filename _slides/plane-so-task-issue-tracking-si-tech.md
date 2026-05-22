---
marp: true
theme: default
paginate: true
title: "Plane.so สำหรับงาน SI/Tech"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Plane.so สำหรับงาน SI/Tech

<p class="tag">Execution layer สำหรับ engineering team — ME/EE/FW/SW/QA เห็นภาพ task ร่วมกัน</p>

<!-- Speaker: บทนี้วาง Plane.so ในฐานะ execution hub สำหรับ SI — ครอบ WBS, issue tracking, milestone, sprint, audit trail แต่ต้อง integrate กับ ERP/DevOps/QMS -->

---

## Plane คือ Execution Layer — ไม่ใช่ Full PM Suite

<p class="subhead">Open-source alternative ของ Jira/ClickUp — self-host ได้, ยืดหยุ่นกว่า Scrum pure, รองรับ parallel workstream</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="10" width="1020" height="280" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="10" width="8" height="280" rx="4" fill="var(--accent)"/>
  <text x="120" y="58" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">WBS Hierarchy</text>
  <text x="120" y="80" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Epic → Task → Sub-task ผูกกับ phase (Design / EVT / DVT / Pilot)</text>
  <text x="120" y="118" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">Milestone Tracking</text>
  <text x="120" y="140" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Modules เชื่อมกับ gate (PDR, EVT Pass, DVT Pass, SAT)</text>
  <text x="120" y="178" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">Sprint Flexibility</text>
  <text x="120" y="200" font-size="14" fill="var(--ink-dim)" font-family="system-ui">SW 2w + HW 4w รันพร้อมกัน — Parallel Cycles รองรับ overlap</text>
  <text x="120" y="238" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">Audit Trail</text>
  <text x="120" y="260" font-size="14" fill="var(--ink-dim)" font-family="system-ui">History tab + Transition tab แทน meeting note บางส่วน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Plane ทำให้ทีม execute ตรงกัน — แต่ต้องใช้ร่วมกับ ERP, DevOps, และ QMS เพื่อครอบ SI จริง</div>

<!-- Speaker: TL;DR — Plane เป็น execution layer ไม่ใช่ tool เดียวที่ครอบทุกอย่าง ต้อง integrate -->

---

## SI Teams ต้องการ Central Hub สำหรับ Cross-Functional Dependencies

<p class="subhead">5 discipline ทำงานคนละ cadence — ถ้าไม่มี task hub กลาง ทีมพึ่ง spreadsheet และ chat log</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact">
    <p class="label">Mechanical</p>
    <h3>ME</h3>
    <p>CAD, tolerance, housing — cycle เป็น weeks</p>
  </div>
  <div class="card compact">
    <p class="label">Electrical</p>
    <h3>EE</h3>
    <p>PCB, schematic, PCBA — parallel กับ FW</p>
  </div>
  <div class="card compact">
    <p class="label">Firmware</p>
    <h3>FW</h3>
    <p>Driver, BSP, integration — sprint 2 weeks</p>
  </div>
  <div class="card compact">
    <p class="label">Software</p>
    <h3>SW</h3>
    <p>App, API, UI — iterate ทุก 2 วัน</p>
  </div>
  <div class="card compact warning">
    <p class="label">Quality</p>
    <h3>QA</h3>
    <p>Test suite, reliability, cert — gate ทุก phase</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Dependency ข้าม discipline track ไม่ได้ใน spreadsheet — Plane แก้ความโปร่งใสในระดับ day-to-day execution</div>

<!-- Speaker: แต่ละ discipline มี cadence ต่างกัน Plane ช่วย sync โดยไม่ force Scrum pure -->

---

## WBS ใน Plane: Epic → Task → Sub-task ผูกกับ Phase

<p class="subhead">Work item ทุกรายการกำหนด owner (PIC), priority, due date, dependency ได้ทันที</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Project root -->
  <rect x="390" y="8" width="320" height="42" rx="8" fill="var(--accent-deep)"/>
  <text x="550" y="35" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Project: SI-CustomerX-Line3</text>
  <!-- Connector line down -->
  <line x1="550" y1="50" x2="550" y2="68" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Horizontal bar connecting 4 epics -->
  <line x1="130" y1="68" x2="970" y2="68" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Epic verticals -->
  <line x1="130" y1="68" x2="130" y2="86" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="370" y1="68" x2="370" y2="86" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="680" y1="68" x2="680" y2="86" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="970" y1="68" x2="970" y2="86" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Epic boxes -->
  <rect x="40" y="86" width="180" height="38" rx="7" fill="var(--accent)" opacity=".9"/>
  <text x="130" y="110" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Design Phase</text>
  <rect x="280" y="86" width="180" height="38" rx="7" fill="var(--accent)" opacity=".9"/>
  <text x="370" y="110" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">EVT</text>
  <rect x="590" y="86" width="180" height="38" rx="7" fill="var(--accent)" opacity=".9"/>
  <text x="680" y="110" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">DVT</text>
  <rect x="880" y="86" width="180" height="38" rx="7" fill="var(--accent)" opacity=".9"/>
  <text x="970" y="110" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Pilot / Deploy</text>
  <!-- Work items under Design Phase -->
  <line x1="130" y1="124" x2="130" y2="142" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="80" y1="142" x2="180" y2="142" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="80" y1="142" x2="80" y2="158" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="180" y1="142" x2="180" y2="158" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="158" width="100" height="30" rx="5" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="80" y="178" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">HW Layout</text>
  <rect x="130" y="158" width="100" height="30" rx="5" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="180" y="178" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FW Arch</text>
  <!-- Sub-work items under HW Layout -->
  <line x1="80" y1="188" x2="80" y2="204" stroke="var(--muted)" stroke-width="1"/>
  <line x1="56" y1="204" x2="104" y2="204" stroke="var(--muted)" stroke-width="1"/>
  <line x1="56" y1="204" x2="56" y2="218" stroke="var(--muted)" stroke-width="1"/>
  <line x1="104" y1="204" x2="104" y2="218" stroke="var(--muted)" stroke-width="1"/>
  <rect x="18" y="218" width="76" height="24" rx="4" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="56" y="234" font-size="10" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">PCB Review</text>
  <rect x="66" y="218" width="76" height="24" rx="4" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="104" y="234" font-size="10" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">DFM Check</text>
  <!-- Properties info box -->
  <rect x="240" y="155" width="530" height="90" rx="8" fill="var(--soft)"/>
  <text x="260" y="178" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Work Item Properties:</text>
  <text x="260" y="198" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Assignee (PIC) · Priority (Urgent/High/Normal/Low) · Due Date · State</text>
  <text x="260" y="218" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Labels · Custom Properties · Dependencies (Blocked by / Starts Before)</text>
  <text x="260" y="234" font-size="11" fill="var(--muted)" font-family="system-ui">Epic progress bar: % complete per state · Status: On Track / At Risk / Off Track</text>
  <!-- Cross-project note -->
  <rect x="800" y="155" width="270" height="90" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="820" y="178" font-size="12" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">Cross-project dependency:</text>
  <text x="820" y="198" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Sub-work item ใน HW project</text>
  <text x="820" y="216" font-size="11" fill="var(--ink-dim)" font-family="system-ui">เป็น parent ของ FW task ได้</text>
  <text x="820" y="234" font-size="11" fill="var(--muted)" font-family="system-ui">Timeline view แสดง conflict</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Epic = phase หลัก; Work Item = deliverable; Sub-item = step ย่อย — map ตรงกับ WBS ของ SI project</div>

<!-- Speaker: One-to-one Epic ownership ป้องกัน task ซ้ำข้าม phase; cross-project sub-items รองรับ inter-discipline dependency -->

---

## Modules = Milestone Gates: PDR → EVT → DVT → SAT

<p class="subhead">Work item เดียวอยู่ได้หลาย Module พร้อมกัน — Timeline view แสดง dependency conflict ด้วยสีแดง</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Timeline line -->
  <line x1="80" y1="140" x2="1040" y2="140" stroke="var(--soft-2)" stroke-width="3"/>
  <!-- PDR node -->
  <circle cx="160" cy="140" r="30" fill="var(--success)"/>
  <text x="160" y="145" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">PDR</text>
  <!-- EVT node -->
  <circle cx="430" cy="140" r="30" fill="var(--accent)"/>
  <text x="430" y="145" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">EVT</text>
  <!-- DVT node -->
  <circle cx="710" cy="140" r="30" fill="var(--accent)"/>
  <text x="710" y="145" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">DVT</text>
  <!-- SAT node -->
  <circle cx="980" cy="140" r="30" fill="var(--gold)"/>
  <text x="980" y="145" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">SAT</text>
  <!-- Week labels below nodes -->
  <text x="160" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Week 4</text>
  <text x="430" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Week 10</text>
  <text x="710" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Week 16</text>
  <text x="980" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Week 20</text>
  <!-- Module cards above -->
  <rect x="72" y="14" width="176" height="100" rx="7" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="160" y="36" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Module: PDR Sign-off</text>
  <text x="160" y="54" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HW layout review</text>
  <text x="160" y="70" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FW architecture review</text>
  <text x="160" y="86" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SW spec sign-off</text>
  <line x1="160" y1="114" x2="160" y2="110" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="342" y="14" width="176" height="100" rx="7" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="430" y="36" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Module: EVT Pass</text>
  <text x="430" y="54" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Build + PCBA</text>
  <text x="430" y="70" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FW flash + basic test</text>
  <text x="430" y="86" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">DVT handoff checklist</text>
  <rect x="622" y="14" width="176" height="100" rx="7" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="710" y="36" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Module: DVT Pass</text>
  <text x="710" y="54" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">QA test suite</text>
  <text x="710" y="70" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Reliability testing</text>
  <text x="710" y="86" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ECO items closed</text>
  <rect x="892" y="14" width="176" height="100" rx="7" fill="var(--warning-wash)" stroke="var(--gold)" stroke-width="1"/>
  <text x="980" y="36" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Module: SAT</text>
  <text x="980" y="54" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Customer site deploy</text>
  <text x="980" y="70" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Acceptance testing</text>
  <text x="980" y="86" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Handoff complete</text>
  <!-- Multi-module note -->
  <rect x="80" y="206" width="940" height="46" rx="7" fill="var(--soft)"/>
  <text x="100" y="227" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Key feature:</text>
  <text x="210" y="227" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Work item เดียวอยู่ได้ใน หลาย Module พร้อมกัน</text>
  <text x="100" y="244" font-size="12" fill="var(--ink-dim)" font-family="system-ui">เช่น task "Supplier Qualification" อยู่ทั้งใน EVT Module และ SCM Module — Layout หลายแบบ: List, Gallery, Timeline</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Module ≠ Epic — Module คือ milestone gate ที่ work item จาก phase ต่างกันมารวมกันเพื่อ track readiness</div>

<!-- Speaker: Modules ใช้สำหรับ cross-phase milestone readiness tracking แยกจาก Epic structure -->

---

## Issue Tracking: จำแนก Defect / Bug / Field Issue ด้วย Labels

<p class="subhead">History tab + Transition tab เป็น immutable audit trail สำหรับทุก property change</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Hardware Defect</p>
    <h3>HW-Defect · EE-Board</h3>
    <p>PCB fault, mechanical failure — ผูกกับ <b>Blocked by</b> dependency เพื่อ block FW task ที่ต้องการ HW ดีก่อน</p>
    <p>Transition tab: badge แสดงว่า stuck ใน "In Review" กี่วัน</p>
  </div>
  <div class="card warning">
    <p class="label">Software Bug</p>
    <h3>FW-Bug · SW-Regression</h3>
    <p>Driver crash, API regression — Transition tab แสดง bottleneck ว่า review ค้างที่ QA หรือ supplier</p>
    <p>Description Edit History: spec revision tracking ต่อทุก update</p>
  </div>
  <div class="card">
    <p class="label">Coordination</p>
    <h3>SCM-Delay · Cert-Block · ECO-Pending</h3>
    <p>Supply chain delay, cert blocker — Comment thread ต่อ task เป็นเอกสารการตัดสินใจแทน meeting note</p>
    <p>History tab: user + timestamp ต่อทุก field change</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> History tab บันทึก user + timestamp ต่อทุก change — ตอบ "ใครอนุมัติ ECO?" ได้โดยไม่ต้องหา email หรือ chat log</div>

<!-- Speaker: Transition tab = time-in-state tracker — ดู bottleneck ว่า stuck ที่ QA review หรือ supplier response; Plane ไม่ใช่ formal sign-off system -->

---

## Cycles & Sprints: SW 2 สัปดาห์ · HW 4 สัปดาห์ พร้อมกัน

<p class="subhead">Parallel Cycles รองรับ multi-discipline timeline ที่ overlap กัน (Enterprise feature)</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Track labels -->
  <text x="20" y="72" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">SW / FW</text>
  <text x="20" y="88" font-size="12" fill="var(--muted)" font-family="system-ui">(2 weeks)</text>
  <text x="20" y="190" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">HW / ME</text>
  <text x="20" y="206" font-size="12" fill="var(--muted)" font-family="system-ui">(4 weeks)</text>
  <!-- SW sprint blocks -->
  <rect x="130" y="50" width="185" height="54" rx="7" fill="var(--accent)" opacity=".85"/>
  <text x="222" y="82" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Sprint 1</text>
  <rect x="325" y="50" width="185" height="54" rx="7" fill="var(--accent)" opacity=".7"/>
  <text x="417" y="82" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Sprint 2</text>
  <rect x="520" y="50" width="185" height="54" rx="7" fill="var(--accent)" opacity=".7"/>
  <text x="612" y="82" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Sprint 3</text>
  <rect x="715" y="50" width="185" height="54" rx="7" fill="var(--accent)" opacity=".7"/>
  <text x="807" y="82" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Sprint 4</text>
  <!-- HW cycle blocks -->
  <rect x="130" y="165" width="380" height="54" rx="7" fill="var(--success)" opacity=".8"/>
  <text x="320" y="197" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">HW Build Cycle 1 (4 weeks)</text>
  <rect x="520" y="165" width="380" height="54" rx="7" fill="var(--success)" opacity=".7"/>
  <text x="710" y="197" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">HW Build Cycle 2 (4 weeks)</text>
  <!-- Week axis -->
  <line x1="130" y1="240" x2="910" y2="240" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="130" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Wk 1</text>
  <text x="325" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Wk 3</text>
  <text x="520" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Wk 5</text>
  <text x="715" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Wk 7</text>
  <text x="910" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Wk 9</text>
  <!-- Feature box -->
  <rect x="930" y="48" width="148" height="174" rx="8" fill="var(--soft)"/>
  <text x="1004" y="72" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cycle Features</text>
  <text x="948" y="94" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Burn-down chart</text>
  <text x="948" y="112" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Build-up chart</text>
  <text x="948" y="130" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Leading / Trailing</text>
  <text x="948" y="148" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Auto-rollover</text>
  <text x="948" y="172" font-size="11" fill="var(--warning-ink)" font-family="system-ui">Parallel: Enterprise</text>
  <text x="948" y="190" font-size="11" fill="var(--muted)" font-family="system-ui">Auto-sched: Business</text>
  <text x="948" y="208" font-size="11" fill="var(--muted)" font-family="system-ui">Free: 1 cycle/project</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SW sprint 2w + HW cycle 4w รันพร้อมกันได้ — Auto-rollover ส่ง task ค้างไป cycle ถัดไปอัตโนมัติ</div>

<!-- Speaker: Parallel Cycles เป็น Enterprise plan เท่านั้น — ถ้าใช้ Free plan ต้องรัน HW และ SW ใน cycle เดียวกัน -->

---

## Labels + Views: แต่ละ Discipline เห็น Queue ตัวเอง

<p class="subhead">Label taxonomy 4 กลุ่ม + Saved Views ให้ทีมกรองงานตัวเองโดยไม่แยก project</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Label Taxonomy — 4 กลุ่ม</p>
    <h3>จำแนกประเภทงานทุก item</h3>
    <p><b>Discipline:</b> [HW] [EE] [FW] [SW] [QA] [SCM] [PM]</p>
    <p><b>Severity:</b> [Critical] [Major] [Minor]</p>
    <p><b>Type:</b> [Bug] [Defect] [Enhancement] [Cert-Item]</p>
    <p><b>Coordination:</b> [ERP-Needed] [Supplier-Action] [ECO-Pending]</p>
  </div>
  <div class="card success">
    <p class="label">Saved Views — Queue ต่อทีม</p>
    <h3>Self-service dashboard ต่อ discipline</h3>
    <p><b>QA Open Issues:</b> Labels=[QA], State≠Done</p>
    <p><b>FW Blocked Tasks:</b> Relation=Blocked by, State≠Done</p>
    <p><b>SCM Delays:</b> Labels=[SCM-Delay], Priority=Urgent</p>
    <p><b>PM Dashboard:</b> Assignee=PM, all projects</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Views ทำให้ QA เห็นแค่ queue ของตัวเอง — ไม่ต้องสร้าง project แยกหรือ tool แยกต่อ discipline</div>

<!-- Speaker: Views ร่วมกับ Labels เป็น self-service dashboard ต่อ discipline — PM สร้าง cross-project view ดู all-teams ได้ด้วย -->

---

## Plane ครอบ Execution — ไม่ครอบ Supply Chain / Cost / Compliance

<p class="subhead">ต้อง integrate กับ ERP, DevOps, Document Control — ไม่ใช่ optional สำหรับ SI จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Plane ครอบ</p>
    <h3>Execution Layer</h3>
    <p>Task/Issue tracking · WBS breakdown · Sprint/Cycle · Milestone gate · Cross-team visibility · Lightweight audit trail</p>
  </div>
  <div class="card warning">
    <p class="label">ต้องใช้ร่วม</p>
    <h3>Adjacent Systems</h3>
    <p><b>ERP/SCM:</b> BOM, PO, procurement, lead time, cost</p>
    <p><b>DevOps:</b> CI/CD pipeline, artifact registry</p>
    <p><b>Doc Control:</b> Spec sign-off, version control, PLM</p>
  </div>
  <div class="card danger">
    <p class="label">Plane ไม่มี</p>
    <h3>Out of Scope</h3>
    <p>Formal sign-off workflow · CAPA/NCR (QMS) · CapEx/OpEx tracking · Full Git bi-directional sync · Vendor management</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Plane as execution hub" ถูกต้อง — แต่ต้อง integrate ไม่ใช่ replace ERP หรือ QMS สำหรับ SI complexity จริง</div>

<!-- Speaker: Git integration ที่มีคือ Copy Branch Name เท่านั้น — ไม่ใช่ full CI/CD integration แต่ trace commit → task ได้ -->

---

## Setup SI Project บน Plane: 10 ขั้นตอน

<p class="subhead">จาก Workspace ใหม่จนถึง daily tracking dashboard — ทำได้ภายใน 1 วัน</p>

<div class="infographic" style="align-items:stretch;">
<div style="display:grid;grid-template-columns:repeat(5,1fr);gap:8px;width:100%;align-self:stretch;">
  <div class="card compact">
    <p class="label">Step 1</p>
    <h3>Workspace + Project</h3>
    <p>สร้าง SI-CustomerX-Line3 · กำหนด Members + Roles</p>
  </div>
  <div class="card compact">
    <p class="label">Step 2</p>
    <h3>Custom States</h3>
    <p>Backlog → Planned → In Progress → In Review → Done</p>
  </div>
  <div class="card compact">
    <p class="label">Step 3</p>
    <h3>Labels (4 กลุ่ม)</h3>
    <p>Discipline · Severity · Type · Coordination</p>
  </div>
  <div class="card compact">
    <p class="label">Step 4</p>
    <h3>Epics (Phases)</h3>
    <p>Design / EVT / DVT / Pilot · due date ต่อ phase</p>
  </div>
  <div class="card compact">
    <p class="label">Step 5</p>
    <h3>Modules (Milestones)</h3>
    <p>PDR Sign-off / EVT Pass / DVT Pass / SAT</p>
  </div>
  <div class="card compact success">
    <p class="label">Step 6</p>
    <h3>Work Items (WBS)</h3>
    <p>Break deliverables · PIC + Priority + Due + Labels</p>
  </div>
  <div class="card compact success">
    <p class="label">Step 7</p>
    <h3>Dependencies</h3>
    <p>Blocked by / Starts Before · Timeline view</p>
  </div>
  <div class="card compact success">
    <p class="label">Step 8</p>
    <h3>Cycles</h3>
    <p>SW 2w / HW 4w · Parallel Cycles (Enterprise)</p>
  </div>
  <div class="card compact success">
    <p class="label">Step 9</p>
    <h3>Saved Views</h3>
    <p>QA Queue · Blocked Tasks · PM Dashboard</p>
  </div>
  <div class="card compact gold">
    <p class="label">Step 10</p>
    <h3>Daily Tracking</h3>
    <p>Burn-down · Epic bar · Module readiness · Transition tab</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Steps 1–5 setup ครั้งเดียว; Steps 6–10 เป็น daily/sprint operation routine ของทีม</div>

<!-- Speaker: ขั้นตอน 1-5 project setup; 6-10 daily operation — ทีมเริ่ม track ได้ภายในวันแรก -->

---

## ข้อจำกัดที่ต้องรู้ก่อน Deploy Plane

<p class="subhead">Plan tier, missing domain, และ self-host responsibility ต้องวางแผนตั้งแต่ต้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Plan Limitations</p>
    <h3>Enterprise Features</h3>
    <p>Parallel Cycles: Enterprise เท่านั้น · Auto-scheduling: Business plan · Free plan = 1 cycle ต่อ project ในเวลาเดียวกัน</p>
  </div>
  <div class="card danger">
    <p class="label">Missing Domain</p>
    <h3>ไม่มีใน Plane</h3>
    <p>BOM/cost module · Formal approval workflow · Full Git bi-directional sync · Mobile app feature ยังด้อยกว่า web</p>
  </div>
  <div class="card">
    <p class="label">Self-Host Cost</p>
    <h3>Infra Responsibility</h3>
    <p>Docker Compose setup ไม่ยาก — แต่ backup, update, security patch เป็นความรับผิดชอบ DevOps team</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ประเมิน plan tier ก่อน deploy — Parallel Cycles เป็น hard requirement สำหรับ SI ที่มี HW+SW track overlap</div>

<!-- Speaker: Self-host ดีสำหรับ data sovereignty แต่ต้องมี DevOps resource; SaaS plan ลด overhead แต่ data ออกนอก -->

---

## Plane Fits SI เมื่อใช้เป็น Execution Hub

<p class="subhead">ใช้ Plane ทำให้ทีม task-aligned และโปร่งใสระดับ day-to-day — integrate กับระบบอื่นเพื่อครอบ complexity จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact success">
    <p class="label">WBS Structure</p>
    <h3>Epic = Phase · Module = Milestone</h3>
    <p>Map ตรงกับ SI project structure — ผูก owner, priority, dependency ต่อทุก work item</p>
  </div>
  <div class="card compact">
    <p class="label">Team Visibility</p>
    <h3>Labels + Views = Discipline Queue</h3>
    <p>QA, FW, SCM เห็น queue ตัวเองโดยไม่แยก project หรือสร้าง tool เพิ่ม</p>
  </div>
  <div class="card compact">
    <p class="label">Sprint Rhythm</p>
    <h3>Cycles ≠ Pure Scrum</h3>
    <p>SW 2w + HW 4w รันพร้อมกันได้ (Enterprise) · Auto-rollover รองรับ task ค้าง</p>
  </div>
  <div class="card compact warning">
    <p class="label">Audit Trail</p>
    <h3>History + Transition Tab</h3>
    <p>Lightweight audit trail — ไม่ใช่ formal sign-off; ต้องใช้ QMS สำหรับ CAPA/NCR</p>
  </div>
  <div class="card compact danger">
    <p class="label">Integration Required</p>
    <h3>Plane + ERP + DevOps + Doc</h3>
    <p>BOM, cost, compliance ไม่อยู่ใน Plane — ต้อง integrate เพื่อครอบ SI complexity จริง</p>
  </div>
  <div class="card compact gold">
    <p class="label">Bottom Line</p>
    <h3>Task Alignment + Transparency</h3>
    <p>Plane ทำให้ทีมเห็นภาพ day-to-day execution ร่วมกัน — นี่คือ core value สำหรับ SI team</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Plane ดีที่สุดเมื่อเป็น execution hub — วางแผน integration กับ ERP/DevOps/QMS ตั้งแต่วันแรก</div>

<!-- Speaker: ถ้า takeaway เดียวคือ Plane ≠ silver bullet — ใช้เป็น execution layer แล้ว integrate กับ ERP/DevOps/QMS จึงจะครอบ SI จริง -->
