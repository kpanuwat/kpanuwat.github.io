---
marp: true
theme: default
paginate: true
title: "Lean Document Set สำหรับ Product Development ในงาน SI/Tech"
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
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Lean Document Set
# for SI/Tech Product Dev

<p class="tag">สำหรับ Product Development ในงาน SI/Tech · 9 phases · ครบแต่ไม่หนัก</p>

<!-- Speaker: 9-phase document map for SI/Tech projects. Lean = every doc has a decision owner who will act on it. -->

---

## เอกสารที่ดีคือเอกสารที่ผ่าน 3-Filter Test

<p class="subhead">ก่อนสร้างเอกสารใหม่ ถาม 3 ข้อ — ผ่านน้อยกว่า 2 ข้อ = ไม่ต้องมี</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Filter 1</p>
    <h3>ใช้ตัดสินใจ</h3>
    <p>มี decision ที่ต้องใช้เอกสารนี้เป็น input ไหม? ถ้าไม่มี — ไม่ต้องมี</p>
  </div>
  <div class="card">
    <p class="label">Filter 2</p>
    <h3>ควบคุมความเสี่ยง</h3>
    <p>เอกสารนี้ป้องกัน risk ที่ระบุชื่อได้ไหม? ถ้าไม่ชัดเจน — ไม่ต้องมี</p>
  </div>
  <div class="card">
    <p class="label">Filter 3</p>
    <h3>ตรวจสอบย้อนกลับ</h3>
    <p>ช่วย trace root cause ได้เมื่อเกิดปัญหา? ถ้าไม่มีโอกาส — ไม่ต้องมี</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lean ≠ ไม่มีเอกสาร — Lean = มีเฉพาะที่มี decision owner จะอ่านและ act จริง</div>

<!-- Speaker: All 9 phases apply this filter. If a doc doesn't pass 2 of 3, it's overhead. -->

---

## Two Failure Modes — Lean Solves Both

<p class="subhead">Too little = misalignment. Too heavy = false confidence. Lean is the third way.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Failure Mode 1</p>
    <h3>เอกสารน้อยเกิน</h3>
    <p>ลูกค้าคิดว่าครอบคลุม Wi-Fi แต่ engineer คิดว่าไม่รวม PM ไม่รู้ว่าใครถูก — misalignment ตั้งแต่ pre-sales</p>
  </div>
  <div class="card success">
    <p class="label">Lean Solution</p>
    <h3>ครบแต่ไม่หนัก</h3>
    <p>เฉพาะ doc ที่ตัดสินใจ + ควบคุม risk + trace root cause ได้จริง ทุก doc มี decision owner</p>
  </div>
  <div class="card warning">
    <p class="label">Failure Mode 2</p>
    <h3>เอกสารหนักเกิน</h3>
    <p>Design Spec 80 หน้า signed แต่ไม่มีใครอัปเดต hardware เปลี่ยน 3 รอบ แต่ spec ยัง v1.0 — false confidence</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เอกสารที่ไม่อัปเดตอันตรายกว่าไม่มีเอกสาร — มันให้ความมั่นใจปลอมแก่ทั้งทีม</div>

<!-- Speaker: Most teams fall into one of these traps. Lean targets the middle: right-sized docs with active owners. -->

---

## 9 Phases: Idea to Commercial

<p class="subhead">แต่ละ phase มี document set ที่ unblock gate ถัดไป — ไม่มี overhead ที่ไม่มีคนอ่าน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Pre-project · Phases 1–3</p>
    <h3>Validate → Win → Kick-off</h3>
    <ul>
      <li>1: Idea / Discovery</li>
      <li>2: Pre-sales</li>
      <li>3: Kick-off (post-PO)</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Build · Phases 4–6</p>
    <h3>Design → Build → Pilot</h3>
    <ul>
      <li>4: Design Phase</li>
      <li>5: Build &amp; Validation (EVT/DVT/PVT)</li>
      <li>6: Pilot &amp; Iteration</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Launch · Phases 7–9</p>
    <h3>Certify → Deploy → Close</h3>
    <ul>
      <li>7: Qualification &amp; Certification</li>
      <li>8: Deployment (SAT/UAT)</li>
      <li>9: Commercial &amp; Post-deployment</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ต้องครบทุก phase — software-only SI ข้าม Phase 7 ได้; fast-turnaround merge Phase 6+8</div>

<!-- Speaker: Map this to your actual project scope. The phases are a menu, not a mandate. -->

---

## Phase 1: Idea/Discovery — Go/No-Go ก่อนลงทุนเวลาทีม

<p class="subhead">3 เอกสาร, เป้าหมายเดียว: ยืนยัน "ปัญหาจริง และแก้ได้คุ้มทุน"</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">1 page</p>
    <h3>Problem Statement</h3>
    <p>ตอบ 4 คำถาม: ปัญหาคืออะไร? ใครมีปัญหา? รู้ได้อย่างไรว่ามันจริง? ทำไมต้องแก้ตอนนี้?</p>
  </div>
  <div class="card">
    <p class="label">1–2 pages</p>
    <h3>PRD Lite</h3>
    <p>User story + acceptance criteria + MVP scope เท่านั้น ไม่มี wireframe ไม่มี backlog — เขียนก่อนรู้ว่าจะ win deal</p>
  </div>
  <div class="card gold">
    <p class="label">½–1 page · Gate</p>
    <h3>Feasibility Note</h3>
    <p>3 มิติ: Technical / Commercial / Timeline feasibility output = Go/No-Go พร้อม assumptions ที่ยืนยันแล้ว</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Feasibility Note คือ gate ที่ป้องกันการใช้เวลา pre-sales กับ deal ที่ไม่ควร pursue</div>

<!-- Speaker: Three short docs to validate before spending sales resources. Feasibility Note gates the pre-sales phase. -->

---

## Phase 2: Pre-sales — SOW คือเอกสารที่ ROI สูงสุด

<p class="subhead">5 เอกสาร ให้ลูกค้าตัดสินใจได้โดยมีข้อมูลครบ — ป้องกัน surprise หลัง sign</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger compact">
    <p class="label">Legal / Finance · CRITICAL</p>
    <h3>SOW (Statement of Work)</h3>
    <p>Deliverables วัดได้ + customer responsibilities + exclusions ชัดเจน ทุก exclusion ประหยัด dispute ใน execution</p>
  </div>
  <div class="card compact">
    <p class="label">Decision Maker</p>
    <h3>Solution Proposal</h3>
    <p>Business challenge + solution fit + investment range — ไม่ใช่เพื่อ impress แต่เพื่อ align</p>
  </div>
  <div class="card compact warning">
    <p class="label">Procurement</p>
    <h3>Rough BoM + Quotation</h3>
    <p>Budget range + part numbers + warranty; BoM ที่ incomplete delay procurement approval</p>
  </div>
  <div class="card compact">
    <p class="label">Technical Evaluator</p>
    <h3>High-level Architecture</h3>
    <p>System diagram + interfaces — ยืนยัน technical feasibility ก่อน commit</p>
  </div>
  <div class="card compact gold">
    <p class="label">PM / Sponsor · Living Doc</p>
    <h3>Risk &amp; Assumption Log</h3>
    <p>Assumption ที่ไม่ document = "เราคิดว่า X แต่จริงๆ คือ Y" ใน execution</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SOW ที่ดีระบุ exclusions ชัดเจน — negotiate scope บน paper ถูกกว่า negotiate หลัง PO มาก</div>

<!-- Speaker: SOW is not just a legal doc — it's a scope contract. Every unclear line is a future dispute. -->

---

## Phase 3: Kick-off — Link Gates Directly to Invoice Schedule

<p class="subhead">Project Charter + Integrated Plan: phase-gate dates ต้องผูกกับ payment milestones โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1060 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Gate 1 -->
  <rect x="20" y="30" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="30" width="200" height="6" rx="3" fill="var(--accent)"/>
  <text x="120" y="72" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Gate 1</text>
  <text x="120" y="92" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design Freeze</text>
  <rect x="60" y="128" width="120" height="36" rx="18" fill="var(--accent-wash)"/>
  <text x="120" y="152" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">20%</text>
  <!-- Arrow 1→2 -->
  <line x1="220" y1="70" x2="256" y2="70" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="256,65 266,70 256,75" fill="var(--muted)"/>
  <!-- Gate 2 -->
  <rect x="266" y="30" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="266" y="30" width="200" height="6" rx="3" fill="var(--warning)"/>
  <text x="366" y="72" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Gate 2</text>
  <text x="366" y="92" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SAT Sign-off</text>
  <rect x="306" y="128" width="120" height="36" rx="18" fill="var(--warning-wash)"/>
  <text x="366" y="152" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">40%</text>
  <!-- Arrow 2→3 -->
  <line x1="466" y1="70" x2="502" y2="70" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="502,65 512,70 502,75" fill="var(--muted)"/>
  <!-- Gate 3 -->
  <rect x="512" y="30" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="512" y="30" width="200" height="6" rx="3" fill="var(--success)"/>
  <text x="612" y="72" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Gate 3</text>
  <text x="612" y="92" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Go-live</text>
  <rect x="552" y="128" width="120" height="36" rx="18" fill="var(--success-wash)"/>
  <text x="612" y="152" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">30%</text>
  <!-- Arrow 3→4 -->
  <line x1="712" y1="70" x2="748" y2="70" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="748,65 758,70 748,75" fill="var(--muted)"/>
  <!-- Gate 4 -->
  <rect x="758" y="30" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="758" y="30" width="200" height="6" rx="3" fill="var(--muted)"/>
  <text x="858" y="65" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Gate 4</text>
  <text x="858" y="84" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Post-support</text>
  <text x="858" y="100" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">30 days</text>
  <rect x="798" y="128" width="120" height="36" rx="18" fill="var(--soft-2)"/>
  <text x="858" y="152" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">10%</text>
  <!-- Total label -->
  <text x="530" y="215" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Design slip 2 weeks = cashflow delayed 2 weeks — ทีมรู้สึกได้ถึงผลกระทบโดยตรง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Integrated Plan ที่ไม่ link gates กับ invoice schedule คือ plan ที่ PM ไม่สามารถ defend cashflow ได้</div>

<!-- Speaker: Gate = decision point AND financial event. This alignment makes delays visible as revenue impact. -->

---

## Phase 4: Design Phase — Lean Specs ของ Parameter ที่ fail gate

<p class="subhead">4 เอกสาร: spec เฉพาะ critical parameter + design review ที่มี action items จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">1 diagram + 1 page</p>
    <h3>System Architecture</h3>
    <p>ยืนยัน interface ระหว่าง component ก่อน detail design</p>
  </div>
  <div class="card compact warning">
    <p class="label">2–5 pages / discipline</p>
    <h3>Design Specs</h3>
    <p>ME / EE / PCB / FW / SW: เฉพาะ parameter ที่ถ้าผิดแล้ว fail gate</p>
  </div>
  <div class="card compact">
    <p class="label">Meeting minutes · Gate</p>
    <h3>PDR</h3>
    <p>Preliminary Design Review — ยืนยัน direction ก่อนลงทุน detail design</p>
  </div>
  <div class="card compact gold">
    <p class="label">Meeting minutes · Freeze</p>
    <h3>CDR</h3>
    <p>Critical Design Review — freeze design ก่อนเข้า Build; sign-off ต้องมี open issues list</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CDR ที่ไม่มี open issue list = CDR ที่ไม่ได้ review จริง — sign-off ที่ดีต้องมี open items</div>

<!-- Speaker: Lean spec = only parameters that gate-fail if wrong. PDR/CDR outputs are action items, not approvals. -->

---

## Phase 5: EVT → DVT → PVT — ยืนยันทีละ hypothesis

<p class="subhead">3 stages, 3 questions: design works? / parts are good? / line is consistent?</p>

<div class="infographic">
<svg viewBox="0 0 1060 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- EVT box -->
  <rect x="20" y="20" width="290" height="150" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="20" width="290" height="8" rx="4" fill="var(--accent)"/>
  <text x="165" y="56" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">EVT</text>
  <text x="165" y="78" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Engineering Validation Test</text>
  <text x="165" y="104" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3–50 units</text>
  <text x="165" y="124" font-size="12" font-weight="600" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Design works as intended?</text>
  <text x="165" y="148" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Output: validated design + issue log</text>
  <!-- Arrow EVT→DVT -->
  <line x1="310" y1="95" x2="346" y2="95" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="346,90 356,95 346,100" fill="var(--muted)"/>
  <!-- DVT box -->
  <rect x="356" y="20" width="290" height="150" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="356" y="20" width="290" height="8" rx="4" fill="var(--warning)"/>
  <text x="501" y="56" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">DVT</text>
  <text x="501" y="78" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design Validation Test</text>
  <text x="501" y="104" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">20–300 units</text>
  <text x="501" y="124" font-size="12" font-weight="600" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Parts are good + DFM done?</text>
  <text x="501" y="148" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Output: certified design + supply chain</text>
  <!-- Arrow DVT→PVT -->
  <line x1="646" y1="95" x2="682" y2="95" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="682,90 692,95 682,100" fill="var(--muted)"/>
  <!-- PVT box -->
  <rect x="692" y="20" width="290" height="150" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="692" y="20" width="290" height="8" rx="4" fill="var(--success)"/>
  <text x="837" y="56" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PVT</text>
  <text x="837" y="78" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Production Validation Test</text>
  <text x="837" y="104" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">100–1,000 units (pilot build)</text>
  <text x="837" y="124" font-size="12" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Production line consistent?</text>
  <text x="837" y="148" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Output: frozen process + yield data</text>
  <!-- Docs row -->
  <text x="530" y="215" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Docs: Test Plan / Test Report / Issue Log / ECO-ECR Change Log — ใช้ตลอดทุก stage</text>
  <text x="530" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ECO ต้องมีก่อนเปลี่ยน BOM — ไม่ใช่เขียนหลังเปลี่ยนแล้ว</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ECO after-the-fact = change control ล้มเหลว; production recall ที่ trace ไม่ได้มีราคาแพงกว่า overhead มาก</div>

<!-- Speaker: Each stage answers one question. ECO must precede the BOM change, not document it after. -->

---

## Phase 6+7: Pilot → Certification — Exit Criteria ก่อน Enter

<p class="subhead">Pilot: วัดผลด้วย criteria ที่ gate ได้จริง / Certification: pre-compliance ก่อน formal lab</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Phase 6 · Pilot &amp; Iteration</p>
    <h3>Field-test ก่อน GA</h3>
    <p><strong>Pilot Plan</strong> — exit criteria ที่วัดได้: "zero critical, ≤3 major after 2 weeks"<br>ไม่ใช่ "ลูกค้า happy"</p>
    <p><strong>Field Feedback Log</strong> — aggregate issues → priority matrix</p>
    <p><strong>Revision Summary</strong> — บันทึก change แต่ละ spin + regression test coverage</p>
  </div>
  <div class="card">
    <p class="label">Phase 7 · Qualification &amp; Certification</p>
    <h3>Market Entry Gate</h3>
    <p><strong>Compliance Checklist</strong> — CE, FCC, UL, RoHS, IEC 62368</p>
    <p><strong>Test Reports</strong> — accredited lab results (traceable)</p>
    <p><strong>Pre-compliance first</strong> — internal lab ก่อน submission; resubmission fee สูงกว่า pre-compliance cost มาก</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pilot exit criteria ที่ไม่วัดได้ไม่สามารถ gate phase ได้จริง — "ลูกค้า happy" ไม่ใช่ criterion</div>

<!-- Speaker: Measurable exit criteria are the difference between a controlled pilot and an endless beta. -->

---

## Phase 8: Deployment — SAT คือ Financial Gate ไม่ใช่แค่ Technical Test

<p class="subhead">FAT vs SAT: สองจุดต่างกัน, สองวัตถุประสงค์ต่างกัน, SAT ผูกกับ payment milestone</p>

<div class="infographic">
<svg viewBox="0 0 1060 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- FAT box (left) -->
  <rect x="30" y="20" width="450" height="240" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="20" width="450" height="56" rx="14" fill="var(--soft)" />
  <text x="255" y="56" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FAT — Factory Acceptance Test</text>
  <text x="70" y="104" font-size="13" fill="var(--ink)" font-family="system-ui">Location:</text>
  <text x="200" y="104" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Vendor factory</text>
  <text x="70" y="132" font-size="13" fill="var(--ink)" font-family="system-ui">Purpose:</text>
  <text x="200" y="132" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Verify build is correct</text>
  <text x="70" y="160" font-size="13" fill="var(--ink)" font-family="system-ui">Timing:</text>
  <text x="200" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Before shipment</text>
  <text x="70" y="188" font-size="13" fill="var(--ink)" font-family="system-ui">Doc output:</text>
  <text x="200" y="188" font-size="13" fill="var(--ink-dim)" font-family="system-ui">FAT report + punch list</text>
  <text x="70" y="216" font-size="13" fill="var(--ink)" font-family="system-ui">Payment link:</text>
  <text x="200" y="216" font-size="13" fill="var(--muted)" font-family="system-ui">Usually none</text>
  <!-- SAT box (right, highlighted) -->
  <rect x="580" y="20" width="450" height="240" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="580" y="20" width="450" height="56" rx="14" fill="var(--accent)" opacity=".08"/>
  <text x="805" y="56" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SAT — Site Acceptance Test</text>
  <text x="620" y="104" font-size="13" fill="var(--ink)" font-family="system-ui">Location:</text>
  <text x="750" y="104" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Customer site (actual env)</text>
  <text x="620" y="132" font-size="13" fill="var(--ink)" font-family="system-ui">Purpose:</text>
  <text x="750" y="132" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Verify system works in production</text>
  <text x="620" y="160" font-size="13" fill="var(--ink)" font-family="system-ui">Timing:</text>
  <text x="750" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">After on-site commissioning</text>
  <text x="620" y="188" font-size="13" fill="var(--ink)" font-family="system-ui">Doc output:</text>
  <text x="750" y="188" font-size="13" fill="var(--ink-dim)" font-family="system-ui">SAT report + customer sign-off</text>
  <text x="620" y="216" font-size="13" fill="var(--ink)" font-family="system-ui">Payment link:</text>
  <text x="750" y="216" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">30–50% milestone payment</text>
  <!-- VS label -->
  <circle cx="530" cy="140" r="26" fill="var(--accent)"/>
  <text x="530" y="145" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SAT criteria ต้อง define ใน SOW ตั้งแต่ pre-sales — negotiate หลัง deployment leverage หายไปแล้ว</div>

<!-- Speaker: SAT sign-off is a financial event. Define pass/fail criteria in SOW, not at the deployment site. -->

---

## Phase 9: Commercial &amp; Post-deployment — Project ยังไม่ complete จนกว่า Handover Pack จะครบ

<p class="subhead">4 เอกสาร ปิด commercial loop + ส่งมอบ asset สำหรับ long-term operation</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">PM / Finance</p>
    <h3>Invoice Tracker</h3>
    <p>Track payment milestone vs actual; visibility สำหรับ cashflow management</p>
  </div>
  <div class="card compact gold">
    <p class="label">Operations · CRITICAL</p>
    <h3>Handover Pack</h3>
    <p>As-built + source code + all docs — test: support engineer ใหม่เข้ามาแทนได้ไหม?</p>
  </div>
  <div class="card compact">
    <p class="label">PM / Customer</p>
    <h3>MA / SLA Agreement</h3>
    <p>Response time + coverage + exclusions; define ก่อน go-live ไม่ใช่หลัง incident</p>
  </div>
  <div class="card compact warning">
    <p class="label">Support Team</p>
    <h3>Support Runbook</h3>
    <p>Troubleshooting guide + escalation path — เขียนโดย engineer ที่รู้ระบบดีที่สุด ก่อนย้าย project</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า support engineer ใหม่เข้ามาแทนไม่ได้โดยไม่มี Handover Pack แสดงว่า project ยังไม่ complete จริง</div>

<!-- Speaker: Handover Pack is the real completion test. Support Runbook must be written before engineers move to next project. -->

---

## 3-Filter Test: ทุก Document ต้องผ่านก่อน Create

<p class="subhead">Lean = ตัดเอกสารที่ผ่านน้อยกว่า 2 ข้อออก — ทำซ้ำทุกครั้งที่มีการเพิ่ม doc ใหม่</p>

<div class="infographic">
<svg viewBox="0 0 1060 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Q1 diamond -->
  <polygon points="170,55 250,100 170,145 90,100" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="170" y="96" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Decide?</text>
  <text x="170" y="112" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Filter 1</text>
  <!-- Yes arrow Q1→Q2 -->
  <line x1="250" y1="100" x2="316" y2="100" stroke="var(--success)" stroke-width="2"/>
  <polygon points="316,95 326,100 316,105" fill="var(--success)"/>
  <text x="283" y="92" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">Yes</text>
  <!-- No arrow Q1→SKIP -->
  <line x1="170" y1="145" x2="170" y2="210" stroke="var(--danger)" stroke-width="2"/>
  <polygon points="165,210 170,220 175,210" fill="var(--danger)"/>
  <text x="183" y="183" font-size="10" fill="var(--danger)" font-family="system-ui">No</text>
  <!-- SKIP box -->
  <rect x="100" y="220" width="140" height="40" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="170" y="245" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">SKIP</text>

  <!-- Q2 diamond -->
  <polygon points="500,55 580,100 500,145 420,100" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="500" y="96" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Risk?</text>
  <text x="500" y="112" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Filter 2</text>
  <!-- Yes arrow Q2→Q3 -->
  <line x1="580" y1="100" x2="646" y2="100" stroke="var(--success)" stroke-width="2"/>
  <polygon points="646,95 656,100 646,105" fill="var(--success)"/>
  <text x="613" y="92" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">Yes</text>
  <!-- No arrow Q2→CONSIDER1 -->
  <line x1="500" y1="145" x2="500" y2="210" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="495,210 500,220 505,210" fill="var(--warning)"/>
  <text x="513" y="183" font-size="10" fill="var(--warning-ink)" font-family="system-ui">No</text>
  <!-- CONSIDER1 box -->
  <rect x="430" y="220" width="140" height="40" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="500" y="245" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">CONSIDER</text>

  <!-- Q3 diamond -->
  <polygon points="830,55 910,100 830,145 750,100" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="830" y="96" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Trace?</text>
  <text x="830" y="112" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Filter 3</text>
  <!-- Yes arrow Q3→CREATE -->
  <line x1="910" y1="100" x2="950" y2="100" stroke="var(--success)" stroke-width="2"/>
  <polygon points="950,95 960,100 950,105" fill="var(--success)"/>
  <text x="930" y="92" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">Yes</text>
  <!-- No arrow Q3→CONSIDER2 -->
  <line x1="830" y1="145" x2="830" y2="210" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="825,210 830,220 835,210" fill="var(--warning)"/>
  <text x="843" y="183" font-size="10" fill="var(--warning-ink)" font-family="system-ui">No</text>
  <!-- CONSIDER2 box -->
  <rect x="760" y="220" width="140" height="40" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="830" y="245" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">CONSIDER</text>

  <!-- CREATE box -->
  <rect x="960" y="76" width="90" height="48" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="1005" y="104" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">CREATE</text>

  <!-- Connecting arrow from Q1 label to Q2 (via 326,100→420,100) — already drawn above, need line 326→420 -->
  <line x1="326" y1="100" x2="420" y2="100" stroke="var(--success)" stroke-width="2"/>

  <!-- Connecting arrow from Q2 label to Q3 (via 656,100→750,100) -->
  <line x1="656" y1="100" x2="750" y2="100" stroke="var(--success)" stroke-width="2"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ผ่าน 3/3 = CREATE · ผ่าน 2/3 = CONSIDER · ผ่าน 0–1/3 = SKIP — apply ก่อน create ทุกครั้ง</div>

<!-- Speaker: Use this filter every time someone proposes a new document. It stops documentation bloat at the source. -->

---

## Key Takeaways

<p class="subhead">7 หลักการจาก 9 phases ที่ carry ไปทุก SI/Tech project</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card compact danger">
    <p class="label">Pre-sales</p>
    <h3>SOW ROI สูงสุด</h3>
    <p>ทุก exclusion ที่ define ได้ก่อน sign = dispute ที่ไม่เกิดใน execution</p>
  </div>
  <div class="card compact warning">
    <p class="label">Kick-off</p>
    <h3>Gate = Invoice Event</h3>
    <p>Link phase-gate กับ payment milestone ทำให้ทีมรู้สึกถึงผลกระทบของ delay โดยตรง</p>
  </div>
  <div class="card compact">
    <p class="label">Build</p>
    <h3>ECO ก่อน ไม่ใช่หลัง</h3>
    <p>ECO after-the-fact = change control ล้มเหลว; audit trail ที่ขาดหายมีราคาแพง</p>
  </div>
  <div class="card compact gold">
    <p class="label">Deployment</p>
    <h3>SAT Criteria ใน SOW</h3>
    <p>Define pass/fail criteria ตั้งแต่ pre-sales — leverage หายไปหลัง deployment แล้ว</p>
  </div>
  <div class="card compact success">
    <p class="label">Handover</p>
    <h3>Handover Pack Test</h3>
    <p>ถ้า support ใหม่เข้ามาแทนไม่ได้ = project ยังไม่ complete — ใช้เป็น completion checklist</p>
  </div>
  <div class="card compact">
    <p class="label">Post-mortem</p>
    <h3>"Doc ไหนไม่มีใครอ่าน?"</h3>
    <p>15-minute retro หลัง project — เอาออกจาก template ถัดไป; mechanism ทำให้ lean จริง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lean document set ไม่ใช่ state ที่ set once — มันวิวัฒน์ทุก project ผ่าน post-mortem loop</div>

<!-- Speaker: The post-mortem is the most underrated practice. It's how the template gets leaner with each project. -->
