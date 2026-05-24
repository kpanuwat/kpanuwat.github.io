---
marp: true
theme: default
paginate: true
title: "ISO 56001:2024 EP5 — Support, Knowledge และ Innovation Operations"
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

# ISO 56001:2024 EP5
# Support, Knowledge และ Innovation Operations

<p class="tag">Clauses 7-8 คือ "เครื่องยนต์" — enablers ที่พร้อมก่อน แล้วถึง operate กระบวนการ idea-to-launch</p>

<!-- Speaker: EP5 เจาะ Clauses 7-8 ซึ่งเป็น "ลงมือทำ" ของ PDCA — ส่วนที่ most implementations fail ที่นี่ -->

---

## Clause 7: Enablers ที่ต้องพร้อมก่อน Clause 8

<p class="subhead">Clause 7 ไม่ใช่แค่ "HR เรื่อง" — เป็น foundation ที่ทำให้ innovation operations ทำงานได้จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">7.1 Resources</p>
    <h3>คน + เวลา + Space</h3>
    <p>บุคคลที่มีเวลา dedicated, lab/maker space, ซอฟต์แวร์ prototype, psychological safety environment</p>
  </div>
  <div class="card success">
    <p class="label">7.2 Competence</p>
    <h3>ทักษะที่จำเป็นจริง</h3>
    <p>Innovation methodology (Design Thinking, Lean Startup, TRIZ), domain expertise, facilitation skills, commercial thinking</p>
  </div>
  <div class="card">
    <p class="label">7.3-7.4</p>
    <h3>Awareness + Communication</h3>
    <p>ทุกคนเข้าใจ IMS และบทบาทตัวเอง; Innovation successes ถูก celebrate และแชร์ทั่วองค์กร</p>
  </div>
  <div class="card gold" style="grid-column:span 3;">
    <p class="label">7.6 Knowledge Management — สำคัญที่สุดสำหรับ SI</p>
    <h3>หยุด "Reinventing the Wheel"</h3>
    <p>Tacit knowledge อยู่ในหัวคนเดิมๆ ไม่ถูก capture — Clause 7.6 กำหนดให้มีระบบ capture, protect, share, evaluate organizational knowledge ที่ทุกคนสร้างสม</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า enablers ไม่พร้อม Clause 8 จะ fail — strategy ดีแต่ไม่มี operational support = ไม่มีผล</div>

---

## Clause 7.6 Knowledge Management: 4 ประเภทที่ต้องจัดการ

<p class="subhead">SI companies มักสูญเสีย tacit knowledge เมื่อคนลาออก — Clause 7.6 แก้ปัญหานี้ตรงๆ</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep5-support-operations-2.png" alt="ISO 56001 Clause 7.6 Knowledge Management four types">
<figcaption>Source: NotebookLM · Explicit (wiki/patents), Tacit (CoP/mentoring), Market (research/interviews), Technology (tech radar) — capture-protect-share-evaluate cycle</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Knowledge management ต้องมี champion — ถ้าไม่มีคนรับผิดชอบ knowledge จะไม่ถูก capture ระบบจะ decay</div>

---

## Clause 8: กระบวนการ 5 ขั้นตอน Idea-to-Launch

<p class="subhead">ISO ไม่บังคับว่าต้องใช้ Design Thinking หรือ Agile — บังคับแค่ว่า 5 stages ต้องมีอยู่ใน design</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep5-support-operations-1.png" alt="ISO 56001 Clause 8 five-stage innovation process">
<figcaption>Source: NotebookLM · Stage 1 Opportunity → Stage 2 Concept → Stage 3 Validate → Stage 4 Develop → Stage 5 Deploy — tools and gate criteria per stage</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Clause 8 ยืดหยุ่นสูงสุดใน standard — องค์กรต้องออกแบบ process เอง แต่ต้องครอบ 5 stages</div>

---

## Tools ต่อ Stage: เลือกตาม Context ไม่ใช่ Trend

<p class="subhead">ISO 56001 ไม่บังคับ tools — แต่แต่ละ stage มี tools ที่ proven แล้วในอุตสาหกรรม</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="195" height="300" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="20" width="195" height="46" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="117" y="48" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Opportunity</text>
  <text x="117" y="88" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Jobs-to-be-Done</text>
  <text x="117" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PESTLE Analysis</text>
  <text x="117" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Voice of Customer</text>
  <text x="117" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Technology Watch</text>
  <rect x="230" y="20" width="195" height="300" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="230" y="20" width="195" height="46" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="327" y="48" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Concept</text>
  <text x="327" y="88" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design Thinking</text>
  <text x="327" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Brainstorming</text>
  <text x="327" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SCAMPER</text>
  <text x="327" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Business Model Canvas</text>
  <rect x="440" y="20" width="195" height="300" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="440" y="20" width="195" height="46" rx="10" fill="var(--accent-wash)"/>
  <text x="537" y="48" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Validation ★</text>
  <text x="537" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MVP (Lean Startup)</text>
  <text x="537" y="114" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">A/B Testing</text>
  <text x="537" y="140" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User Interviews</text>
  <text x="537" y="166" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Technical PoC</text>
  <rect x="650" y="20" width="195" height="300" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="650" y="20" width="195" height="46" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="747" y="48" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Development</text>
  <text x="747" y="88" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Agile / Scrum</text>
  <text x="747" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SAFe (large org)</text>
  <text x="747" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Kanban</text>
  <text x="747" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CI/CD pipelines</text>
  <rect x="860" y="20" width="220" height="300" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="860" y="20" width="220" height="46" rx="10" fill="var(--accent)" opacity=".12"/>
  <text x="970" y="48" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Deployment</text>
  <text x="970" y="88" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Change Management</text>
  <text x="970" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Training Plan</text>
  <text x="970" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">KPI Dashboards</text>
  <text x="970" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Launch Playbook</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Validation stage คือที่ที่ investments กลับคืนสูงสุด — ล้ม early ด้วย MVP ดีกว่าล้ม late หลัง scale</div>

---

## Clause 8 กับ SI Company: ยืดหยุ่นที่สำคัญ

<p class="subhead">สำหรับ System Integrator Clause 8 ออกแบบมาให้รองรับงาน project-based ได้โดยตรง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Innovation ใน Project Scope</p>
    <h3>Innovation Sandbox</h3>
    <p>ทำ innovation ภายใน Stage Gate ของ client project โดยใช้ "innovation sandbox" ที่ตกลงกับลูกค้าไว้ล่วงหน้า</p>
  </div>
  <div class="card gold">
    <p class="label">Cross-Project Innovation</p>
    <h3>Internal Program</h3>
    <p>ทำแยกเป็น internal program ที่ไม่ขึ้นกับ client project timeline ใช้ทรัพยากร dedicated ไม่ใช่ "เวลาว่าง"</p>
  </div>
  <div class="card success">
    <p class="label">PoC Productization</p>
    <h3>Reusable Solutions</h3>
    <p>PoC ที่ทำจาก client project สามารถ productize เป็น reusable solution ผ่าน Clause 8 process ปกติ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Knowledge Management (7.6) + PoC Productization (Clause 8) คือ combination ที่ทำให้ SI สร้าง IP แทนที่จะ deliver แล้วลืม</div>

---

## Key Takeaways — EP5 Support & Operations

<p class="subhead">Clause 7 วาง enablers; Clause 8 กำหนด operations — ทั้งสองต้องทำงานร่วมกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Clause 7 Foundation</p>
    <h3>Enablers ก่อน Execution</h3>
    <p>คน ทักษะ ความรู้ สื่อสาร — ถ้า enablers ไม่พร้อม Clause 8 operations จะ fail ไม่ว่า process จะดีแค่ไหน</p>
  </div>
  <div class="card success">
    <p class="label">Clause 7.6</p>
    <h3>หยุด Reinventing the Wheel</h3>
    <p>Knowledge capture สำคัญมากสำหรับ SI — ต้องมี champion และเป็น natural part of workflow ไม่ใช่ extra burden</p>
  </div>
  <div class="card gold">
    <p class="label">Clause 8</p>
    <h3>5 Stages ต้องมี ไม่บังคับ Tools</h3>
    <p>Opportunity → Concept → Validate → Develop → Deploy — ออกแบบ process เอง แต่ต้องครอบทุก stage</p>
  </div>
  <div class="card warning">
    <p class="label">Stage Gates</p>
    <h3>Decision Points ไม่ใช่ Checkpoint</h3>
    <p>Gates ที่มีมากเกินไปหรือ criteria ไม่ชัดกลายเป็น bureaucracy ที่ slow down innovation แทนที่จะช่วย</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP6 จะปิด PDCA loop — Clauses 9-10 วัดผล audit และ continual improvement ที่ทำให้ IMS ไม่หยุดพัฒนา</div>
