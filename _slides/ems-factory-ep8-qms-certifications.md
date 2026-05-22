---
marp: true
theme: default
paginate: true
title: "EMS Factory EP8: QMS & Certifications"
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

# EMS Factory EP8: QMS & Certifications

<p class="tag">ISO 9001 · IATF 16949 · ISO 13485 — อ่าน certificate อย่างไรให้ถูกต้อง</p>

<!-- Speaker: 3 standards ที่ OEM ต้องเข้าใจก่อนเซ็น EMS contract -->

---

## QMS Certification สามชั้นที่ EMS ต้องรู้

<p class="subhead">ISO 9001 เป็น baseline — IATF ต่อยอด automotive, ISO 13485 ต่อยอด medical.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">All Industries · Foundation</p>
    <h3>ISO 9001:2015</h3>
    <p>PDCA-based QMS framework ใช้ได้ทุก industry ต้องมีก่อนจึงจะต่อยอดเป็น IATF ได้ กำหนด 10 clause ครอบคลุม planning → operation → improvement</p>
  </div>
  <div class="card warning">
    <p class="label">Automotive · Extension</p>
    <h3>IATF 16949:2016</h3>
    <p>ต้องมี ISO 9001 ก่อน — standalone ไม่ได้ บังคับ 5 core tools: APQP, FMEA, SPC, MSA, PPAP และต้องตอบ Customer-Specific Requirements (CSR) ของ OEM แต่ละราย</p>
  </div>
  <div class="card success">
    <p class="label">Medical Device · Independent</p>
    <h3>ISO 13485:2016</h3>
    <p>Independent standard (ไม่ต้องมี ISO 9001 ก่อน) โฟกัสที่ patient safety: CAPA, DHR/DMR, process validation, ISO 14971 risk management และ software validation</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Badge ไม่พอ — ต้องดู scope, expiry, และว่า standard นั้น mandatory จริงในอุตสาหกรรมของคุณหรือเปล่า</div>

<!-- Speaker: สามชั้นนี้ cover 3 market segment ที่ EMS รับงาน -->

---

## ISO 9001 เป็นภาษากลาง — ทุก QMS พูดบน foundation นี้

<p class="subhead">10-clause PDCA structure ยืดหยุ่นตาม context แต่ core discipline เหมือนกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- PDCA cycle with clause mapping -->
  <!-- Background ring -->
  <circle cx="550" cy="190" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- PLAN arc (top-left) -->
  <path d="M 390 190 A 160 160 0 0 1 550 30" fill="none" stroke="var(--accent)" stroke-width="20" stroke-linecap="round" opacity=".25"/>
  <path d="M 390 190 A 160 160 0 0 1 550 30" fill="none" stroke="var(--accent)" stroke-width="3"/>
  <text x="430" y="90" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui" text-anchor="middle">PLAN</text>
  <text x="430" y="110" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Clause 4–7</text>
  <!-- DO arc (top-right) -->
  <path d="M 550 30 A 160 160 0 0 1 710 190" fill="none" stroke="var(--warning)" stroke-width="20" stroke-linecap="round" opacity=".25"/>
  <path d="M 550 30 A 160 160 0 0 1 710 190" fill="none" stroke="var(--warning)" stroke-width="3"/>
  <text x="680" y="90" font-size="14" font-weight="700" fill="var(--warning)" font-family="system-ui" text-anchor="middle">DO</text>
  <text x="680" y="110" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Clause 8</text>
  <!-- CHECK arc (bottom-right) -->
  <path d="M 710 190 A 160 160 0 0 1 550 350" fill="none" stroke="var(--success)" stroke-width="20" stroke-linecap="round" opacity=".25"/>
  <path d="M 710 190 A 160 160 0 0 1 550 350" fill="none" stroke="var(--success)" stroke-width="3"/>
  <text x="680" y="300" font-size="14" font-weight="700" fill="var(--success)" font-family="system-ui" text-anchor="middle">CHECK</text>
  <text x="680" y="318" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Clause 9</text>
  <!-- ACT arc (bottom-left) -->
  <path d="M 550 350 A 160 160 0 0 1 390 190" fill="none" stroke="var(--danger)" stroke-width="20" stroke-linecap="round" opacity=".25"/>
  <path d="M 550 350 A 160 160 0 0 1 390 190" fill="none" stroke="var(--danger)" stroke-width="3"/>
  <text x="420" y="300" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui" text-anchor="middle">ACT</text>
  <text x="420" y="318" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Clause 10</text>
  <!-- Center -->
  <circle cx="550" cy="190" r="55" fill="var(--accent)" opacity=".08"/>
  <circle cx="550" cy="190" r="55" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="184" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ISO 9001</text>
  <text x="550" y="202" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">10 Clauses</text>
  <!-- Key requirements callouts -->
  <rect x="30" y="30" width="240" height="100" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="30" width="5" height="100" rx="2" fill="var(--accent)"/>
  <text x="48" y="56" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Documented Procedures</text>
  <text x="48" y="76" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Process ต้องมีเอกสาร</text>
  <text x="48" y="96" font-size="12" fill="var(--muted)" font-family="system-ui">Risk-based thinking</text>
  <text x="48" y="116" font-size="12" fill="var(--muted)" font-family="system-ui">Management review</text>
  <rect x="830" y="30" width="240" height="100" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="830" y="30" width="5" height="100" rx="2" fill="var(--accent)"/>
  <text x="848" y="56" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Customer Satisfaction</text>
  <text x="848" y="76" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Measure + monitor</text>
  <text x="848" y="96" font-size="12" fill="var(--muted)" font-family="system-ui">Continual improvement</text>
  <text x="848" y="116" font-size="12" fill="var(--muted)" font-family="system-ui">Internal audit cycle</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ISO 9001 ไม่กำหนด tool เฉพาะ — IATF ต่างหากที่บังคับ 5 core tools</div>

<!-- Speaker: PDCA loop หมุนตลอด — Plan/Do/Check/Act ไม่ใช่ one-time project -->

---

## IATF 16949: 5 Core Tools คือหัวใจของ Automotive Quality

<p class="subhead">EMS ที่รับงาน automotive ต้องใช้ครบทั้ง 5 — ขาดอันเดียวคือ nonconformance</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact warning">
    <p class="label">Planning</p>
    <h3>APQP</h3>
    <p>Advanced Product Quality Planning — 5 phases ตั้งแต่ design จนถึง launch</p>
  </div>
  <div class="card compact warning">
    <p class="label">Risk</p>
    <h3>FMEA</h3>
    <p>Failure Mode &amp; Effects Analysis — DFMEA (design) + PFMEA (process)</p>
  </div>
  <div class="card compact warning">
    <p class="label">Monitoring</p>
    <h3>SPC</h3>
    <p>Statistical Process Control — control chart real-time, detect drift ก่อน defect เกิด</p>
  </div>
  <div class="card compact warning">
    <p class="label">Measurement</p>
    <h3>MSA</h3>
    <p>Measurement Systems Analysis — Gauge R&amp;R ยืนยันว่า tool วัดได้เชื่อถือได้</p>
  </div>
  <div class="card compact warning">
    <p class="label">Approval</p>
    <h3>PPAP</h3>
    <p>Production Part Approval Process — อนุมัติ parts จาก supplier ก่อน production จริง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> IATF 16949 standalone ไม่ได้ — ต้องมี ISO 9001 ก่อน + CSR ของ OEM แต่ละราย (Ford Q1, GM BIQS, Toyota SQS)</div>

<!-- Speaker: แต่ละ core tool แก้ปัญหาคนละ phase ใน product lifecycle -->

---

## ความสัมพันธ์ระหว่าง Standards

<p class="subhead">ISO 9001 เป็น foundation — IATF ต่อ automotive, ISO 13485 independent สำหรับ medical</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep8-qms-certifications-1.png" alt="QMS Standards Hierarchy Diagram showing ISO 9001 baseline, IATF 16949 automotive extension with 5 core tools, and ISO 13485 medical device branch">
<figcaption>Source: NotebookLM · QMS certification hierarchy — industries, requirements, and standard relationships</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ISO 13485 ไม่ต้องพึ่ง ISO 9001 แต่ความต้องการ overlap กันมาก — medical EMS มักถือทั้งสอง</div>

<!-- Speaker: ลูกศรจาก ISO 9001 ไป IATF หมายความว่า mandatory dependency -->

---

## ISO 13485: Patient Safety First — กฎ 4 ข้อที่ต่างจาก ISO 9001

<p class="subhead">Medical device ผิดพลาดหมายถึง patient ได้รับอันตราย — tolerance สำหรับ ambiguity แทบเป็นศูนย์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Traceability & Documentation</p>
    <h3>DHR + DMR ทุก unit</h3>
    <p><b>Device History Record (DHR)</b> — บันทึกว่า unit นี้ผลิตด้วยอะไร เมื่อไหร่ โดยใคร</p>
    <p><b>Device Master Record (DMR)</b> — specs, process, test criteria ของ product model</p>
    <p>ต้องเก็บ record ตลอด product lifecycle — ปกติ 5–15 ปีขึ้นอยู่กับ device class</p>
  </div>
  <div class="card success">
    <p class="label">Risk & Validation</p>
    <h3>ISO 14971 + Process Validation</h3>
    <p><b>Risk Management (ISO 14971)</b> — identify, evaluate, control risks ที่ device อาจทำร้าย patient</p>
    <p><b>Process Validation</b> — พิสูจน์ว่า process ผลิต output ที่ consistent โดยไม่ต้องตรวจทุก unit</p>
    <p><b>CAPA</b> — Corrective and Preventive Action เมื่อพบ nonconformance ต้องหาต้นเหตุและป้องกัน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ISO 13485 ไม่ใช่แค่ quality standard — มันคือ regulatory framework ที่ผูกกับ FDA 21 CFR Part 820 และ EU MDR</div>

<!-- Speaker: Software validation ก็บังคับ — ทุก embedded firmware ที่ส่งผลต่อ patient safety ต้องผ่าน IEC 62304 -->

---

## Certification Lifecycle & Audit Cycle

<p class="subhead">Certificate มีวันหมดอายุ — EMS ที่ดีเตรียมล่วงหน้า ไม่ใช่รอให้ audit แล้วค่อยทำ</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep8-qms-certifications-2.png" alt="QMS Certification Lifecycle showing Stage 1 documentation review, Stage 2 on-site assessment, annual surveillance audits, and 3-year recertification cycle">
<figcaption>Source: NotebookLM · Full certification journey — time, cost, and key activities at each phase</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Annual surveillance audit ราคา 20–30% ของ initial audit — budget สำหรับ ongoing compliance ไม่ใช่แค่ครั้งแรก</div>

<!-- Speaker: Stage 1 = document review (CB checks QMS docs), Stage 2 = on-site (auditors visit, interview operators) -->

---

## Key Takeaways: อ่าน Certificate ให้ขาด

<p class="subhead">Badge ไม่พอ — ต้องตรวจสอบ 4 มิตินี้ก่อนเซ็น EMS contract</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Green Flags</p>
    <h3>สัญญาณที่ดี</h3>
    <ul>
      <li>Scope ครอบคลุม production line จริง (ไม่ใช่แค่ warehouse)</li>
      <li>Certificate ยังไม่หมดอายุ + surveillance audit ล่าสุด &lt;12 เดือน</li>
      <li>IATF: มี CSR register สำหรับ OEM ที่คุณ target</li>
      <li>ISO 13485: มี Notified Body / Registrar ที่ recognize ในตลาดของคุณ</li>
      <li>Site visit: เจอ SPC chart ติดผนัง, DHR log จริง, CAPA tracker active</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Red Flags</p>
    <h3>สัญญาณเตือน</h3>
    <ul>
      <li>Certificate scope เขียนกว้างแต่ auditor ไม่ได้เข้าชม production จริง</li>
      <li>ไม่สามารถแสดง last surveillance audit report ได้</li>
      <li>IATF: ไม่รู้จัก CSR ของ OEM ที่คุณถาม</li>
      <li>ISO 13485: ไม่มี risk management file หรือ CAPA system จริง</li>
      <li>"Checklist mentality" — ตอบคำถามตาม form แต่ explain process ไม่ได้</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Certificate คือจุดเริ่มต้นของ due diligence — ไม่ใช่จุดสิ้นสุด</div>

<!-- Speaker: OEM ที่ serious จะทำ second-party audit ด้วย ไม่ใช่แค่เชื่อ certificate -->
