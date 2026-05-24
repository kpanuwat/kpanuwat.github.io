---
marp: true
theme: default
paginate: true
title: "ISO 56001:2024 EP4 — Innovation Portfolio Planning"
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

---

<!-- _class: title -->

<div class="mark"></div>

# ISO 56001:2024 EP4
# Innovation Portfolio Planning

<p class="tag">Clause 6 คือตัวแปล Strategic Intent → Portfolio → Operations — balance ระหว่าง now และ future</p>

<!-- Speaker: EP4 เจาะ Clause 6 ซึ่งเป็นหัวใจของการวาง innovation portfolio ให้ balance และมีระบบ -->

---

## Portfolio ≠ Project: มุมมองที่ต่างกันโดยสิ้นเชิง

<p class="subhead">Clause 6 ต้องการ portfolio thinking — มองทุก initiative รวมกัน ไม่ใช่แค่ดูทีละ project</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="480" height="280" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="480" height="52" rx="14" fill="var(--soft)"/>
  <text x="280" y="52" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Project Management</text>
  <text x="70" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">ขอบเขต: ทีละ project</text>
  <text x="70" y="140" font-size="14" fill="var(--ink-dim)" font-family="system-ui">เป้าหมาย: ส่งมอบ scope ในเวลา/งบ</text>
  <text x="70" y="175" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Decision: ทำให้ project สำเร็จ</text>
  <text x="70" y="210" font-size="14" fill="var(--muted)" font-family="system-ui">Metric: On-time, on-budget</text>
  <rect x="580" y="20" width="480" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="580" y="20" width="480" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="820" y="52" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Innovation Portfolio Management ★</text>
  <text x="610" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">ขอบเขต: ทุก initiative รวมกัน</text>
  <text x="610" y="140" font-size="14" fill="var(--ink-dim)" font-family="system-ui">เป้าหมาย: Optimize return vs. risk</text>
  <text x="610" y="175" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Decision: คัดกรอง / เพิ่ม / หยุด</text>
  <text x="610" y="210" font-size="14" fill="var(--accent)" font-family="system-ui" font-weight="600">Metric: Portfolio balance + value</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Portfolio manager ถามว่า "ทรัพยากรทั้งหมดกระจายถูกต้องไหม?" — ไม่ใช่แค่ "project นี้ on-track ไหม?"</div>

---

## Three Horizons: สูตร Balance ระหว่าง Now และ Future

<p class="subhead">McKinsey Three Horizons คือ framework ที่ใช้บ่อยที่สุดกับ ISO 56001 Clause 6 — 70/20/10 เป็น starting point ไม่ใช่กฎตายตัว</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep4-planning-1.png" alt="McKinsey Three Horizons model for ISO 56001 portfolio">
<figcaption>Source: NotebookLM · H1 Core (~70%), H2 Adjacent (~20%), H3 Transformational (~10%) — time-risk-allocation matrix</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Horizon 3 ที่ 0% = ไม่มี future growth engine; Horizon 1 ที่ 100% = ประกาศว่าจะ decline ใน 5-10 ปี</div>

---

## Stage Gate Process: ตัวกรอง Portfolio

<p class="subhead">Gate ทุกตัวต้องมี criteria ชัดเจน — Gate ที่ไม่มี criteria จะ kill ทุก moonshot หรือปล่อยทุก initiative ผ่านแบบไม่มีความหมาย</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep4-planning-2.png" alt="Innovation Stage Gate Process Clause 6">
<figcaption>Source: NotebookLM · Idea → Gate 1 Feasibility → Concept → Gate 2 Technical → PoC → Gate 3 Business Case → Scale → Gate 4 Investment → Launch</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Stage Gates คือ decision points ไม่ใช่ bureaucracy checkboxes — criteria ต้องชัดและ simple</div>

---

## Innovation Objectives: SMART แต่อย่าวัด Output เพียงอย่างเดียว

<p class="subhead">KPIs ที่วัดแค่จำนวน patents หรือ ideas submitted จะ incentivize พฤติกรรมผิด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Vanity Metrics (หลีกเลี่ยง)</p>
    <h3>Output เพียงอย่างเดียว</h3>
    <p>จำนวน patents filed, จำนวน ideas submitted, จำนวน workshops จัด — วัดได้ง่ายแต่ไม่สะท้อน value จริง</p>
    <p>Incentivize: ส่ง idea เยอะๆ, patent สิ่งที่ไม่มี commercial value</p>
  </div>
  <div class="card success">
    <p class="label">Balanced KPIs (ใช้นี้)</p>
    <h3>ครอบ 4 ระดับ</h3>
    <p><strong>Input:</strong> R&D investment %, innovation FTE</p>
    <p><strong>Process:</strong> stage gate conversion rate, time-to-market</p>
    <p><strong>Output:</strong> new products launched</p>
    <p><strong>Outcome:</strong> revenue from innovations &lt;3yr old ≥20%</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วัดทั้ง 4 ระดับ: Input → Process → Output → Outcome — ขาดระดับใดระดับหนึ่งจะ incentivize behavior ผิด</div>

---

## Resource Allocation: ต้อง Planned ไม่ใช่ "เวลาว่าง"

<p class="subhead">Clause 6 กำหนดให้มี planned resources — innovation ที่ทำใน "เวลาว่าง" จะ fail เสมอ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Pain Points ที่พบบ่อย</p>
    <h3>ปัญหา Resource Allocation</h3>
    <p><strong>Dedicated time:</strong> ทีมมีเวลา innovation จริงกี่ %?</p>
    <p><strong>Budget ringfencing:</strong> เงิน innovation ถูก cut ช่วง budget tight?</p>
    <p><strong>Infrastructure:</strong> มี lab / maker space / prototype tools?</p>
    <p><strong>Data access:</strong> ทีม innovation เข้าถึง customer data ได้?</p>
  </div>
  <div class="card success">
    <p class="label">Portfolio Balance Red Flags</p>
    <h3>สัญญาณ Portfolio ไม่ Balanced</h3>
    <p><strong>มีแต่ incremental:</strong> ไม่มี future growth engine (Horizon 3 = 0%)</p>
    <p><strong>มีแต่ moonshots:</strong> ไม่มี quick wins แสดง ROI ระยะสั้น</p>
    <p><strong>H1 ครอบ 95%+:</strong> ไม่ได้ลงทุนใน future ไม่มีทาง grow</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Portfolio balance ต้องตรวจสอบอย่างน้อย quarterly — ถ้า check แค่ปีละครั้งจะ course-correct ช้าเกินไป</div>

---

## Key Takeaways — EP4 Portfolio Planning

<p class="subhead">Clause 6 คือตัวแปลจาก Strategy → Portfolio → Operations</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Core Principle</p>
    <h3>Portfolio ≠ Project</h3>
    <p>มองทุก initiative รวมกัน optimize return vs. risk ทั้ง portfolio ไม่ใช่แค่ทีละชิ้น</p>
  </div>
  <div class="card gold">
    <p class="label">Three Horizons</p>
    <h3>~70/20/10 เป็น Starting Point</h3>
    <p>Core / Adjacent / Transformational — ปรับ allocation ตาม strategic intent ของแต่ละองค์กร</p>
  </div>
  <div class="card success">
    <p class="label">Stage Gates</p>
    <h3>Decision Points ที่ชัดเจน</h3>
    <p>Criteria ต้องชัด ทำ Go/No-Go จริง ไม่ใช่แค่ checkpoint ที่ทุกคนผ่านเสมอ</p>
  </div>
  <div class="card danger">
    <p class="label">KPI Trap</p>
    <h3>อย่าวัดแค่ Output</h3>
    <p>Input + Process + Output + Outcome — ครอบ 4 ระดับเสมอ มิฉะนั้นจะ incentivize behavior ผิด</p>
  </div>
  <div class="card warning">
    <p class="label">Resources</p>
    <h3>ต้อง Planned ล่วงหน้า</h3>
    <p>Budget ringfencing, dedicated time, infrastructure — ไม่ใช่ทำใน "เวลาว่าง" แล้วหวังว่าจะ succeed</p>
  </div>
  <div class="card">
    <p class="label">Next EP</p>
    <h3>EP5: Clauses 7-8</h3>
    <p>Portfolio วางแล้ว — EP5 จะเจาะ enablers (Clause 7) และ operational process idea-to-launch (Clause 8)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Clause 6 เป็น bridge จาก "วางแผน" ไปสู่ "ลงมือทำ" — ขาด portfolio logic ทรัพยากรจะกระจายแบบ watering can</div>
