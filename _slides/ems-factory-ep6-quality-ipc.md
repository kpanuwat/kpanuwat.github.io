---
marp: true
theme: default
paginate: true
title: "EMS Factory EP6: Quality Standards & IPC Framework"
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

# EMS Factory EP6: Quality Standards & IPC Framework

<p class="tag">IPC — common language ระหว่าง OEM กับ EMS ที่ทำให้ "quality" ไม่ใช่ความเห็น</p>

<!-- Speaker: ก่อนมี IPC "quality" แปลว่าอะไรก็ได้ตามที่แต่ละคนนึกออก — IPC แปลงความเห็นให้เป็น measurable criteria -->

---

## IPC Standards: ครอบ Lifecycle ตั้งแต่ Design ถึง Field Repair

<p class="subhead">ไม่มี standard เดียวที่ cover ทุกอย่าง — แต่ละ phase มี IPC document ของตัวเอง</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep6-quality-ipc-2.png" alt="IPC standards framework lifecycle: IPC-2221 design, J-STD-001 assembly, IPC-A-610 inspection, IPC-7711/7721 rework">
<figcaption>Source: NotebookLM · Electronics Manufacturing Standards Framework — 4 phases, 4 IPC standards</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> IPC-A-610 = inspect output; J-STD-001 = govern process — ระบุทั้งคู่ใน contract ถึงจะ cover quality ได้ครบสองด้าน</div>

<!-- Speaker: IPC-2221 คือ phase 1 (design) → J-STD-001 phase 2 (assembly) → IPC-A-610 phase 3 (visual benchmark) → IPC-7711/7721 phase 4 (rework/repair) -->

---

## IPC-A-610: เลือก Class ให้ถูกก่อน Production

<p class="subhead">Class ที่ระบุใน contract ≠ Class ที่ EMS default — ถ้าไม่ระบุ EMS ใช้ Class 2 โดยอัตโนมัติ</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ems-factory-ep6-quality-ipc-1.png" alt="IPC-A-610 Class 1 vs Class 2 vs Class 3: use cases, strictness, and acceptance criteria comparison">
<figcaption>Source: NotebookLM · Navigating IPC-A-610: Electronics Reliability Class Comparison</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Class 3 ไม่ใช่แค่ "inspect มากขึ้น" — criteria ต่างกันทุก defect type; บอร์ดเดียวกันอาจ pass Class 2 แต่ fail Class 3</div>

<!-- Speaker: Data table ใน image แสดงตัวอย่าง: Through-Hole Solder Fill — Class 2 ≥ 50% barrel, Class 3 ≥ 75% barrel — criteria ชัดเจนแบบนี้ไม่ต้องตีความ -->

---

## Class 1 / 2 / 3: เลือกตาม Product Risk Profile

<p class="subhead">Class ที่สูงขึ้น = inspection เข้มขึ้น + ราคาสูงขึ้น — เลือกให้ตรงกับ risk จริง ไม่ใช่แค่ "ต้องการดีที่สุด"</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Class 1 — General</p>
    <h3>Function = เพียงพอ</h3>
    <p>Cosmetic imperfection ยอมรับได้ Short life expectancy</p>
    <ul>
      <li>Toys, gadgets, promotional items</li>
      <li>Disposable electronics</li>
      <li>Low-cost consumer goods</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Class 2 — Dedicated Service</p>
    <h3>Performance + Longevity</h3>
    <p>Extended life, sustained performance; downtime ไม่ critical <b>Default เมื่อไม่ระบุ</b></p>
    <ul>
      <li>Laptops, TVs, home appliances</li>
      <li>Industrial controls</li>
      <li>Commercial electronics</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Class 3 — High Reliability</p>
    <h3>Zero Defects Required</h3>
    <p>Continuous performance-on-demand; downtime = unacceptable risk</p>
    <ul>
      <li>Aerospace, military</li>
      <li>Medical life-support</li>
      <li>Critical automotive safety</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Class 3 เพิ่มต้นทุน inspection อย่างมีนัย — ถ้าผลิตภัณฑ์ไม่ใช่ life-critical การเลือก Class 3 ทั้งบอร์ดอาจ over-engineer และทำราคาแพงโดยไม่จำเป็น</div>

<!-- Speaker: บาง OEM ใช้ mixed-class: board เดียวอาจมี Class 3 สำหรับ power section + Class 2 สำหรับ UI section — ต้องระบุ zone ใน drawing -->

---

## J-STD-001 vs IPC-A-610: สองด้านของ Quality Assurance

<p class="subhead">Build ถูก process ตาม J-STD-001 + Inspect output ตาม IPC-A-610 — ขาดอย่างใดอย่างหนึ่งคือ quality gap</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">J-STD-001 — "How to Build"</p>
    <h3>Soldering Process Standard</h3>
    <ul>
      <li><b>Materials:</b> solder alloy (SAC305, Sn63Pb37), flux type, paste spec</li>
      <li><b>Methods:</b> hand / wave / reflow — แต่ละมี procedure เฉพาะ</li>
      <li><b>Verification:</b> tip temp, time-on-pad, flux residue acceptance</li>
      <li><b>Personnel:</b> ต้องผ่าน J-STD-001 certification ก่อน perform soldering</li>
      <li><b>Lead-free:</b> +30-40°C vs leaded → กระทบ component selection ทั้งหมด</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">IPC-A-610 — "How to Inspect"</p>
    <h3>Assembly Acceptance Standard</h3>
    <ul>
      <li><b>Solder fillet:</b> geometry, wetting, void %, bridging</li>
      <li><b>Component:</b> placement accuracy, orientation, spacing</li>
      <li><b>Cleanliness:</b> flux residue, contamination</li>
      <li><b>Coating:</b> conformal coating coverage, adhesion</li>
      <li><b>3 verdicts:</b> Acceptable / Process Indicator / Defect — per class</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่อ้าง "ทำตาม IPC-A-610" แต่ไม่มี J-STD-001 process control กำลังตรวจ output โดยไม่ควบคุม input — reactive ไม่ใช่ preventive quality</div>

<!-- Speaker: Analogy: J-STD-001 = recipe + cooking method; IPC-A-610 = taste test ถ้าทำตาม recipe ผิดแต่ food test ผ่าน แสดงว่า test ไม่เข้มพอ -->

---

## Rework, Certification, และ Traceability

<p class="subhead">Quality framework ไม่สมบูรณ์ถ้าไม่มี: approved rework procedure, certified personnel, และ lot-level traceability</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">IPC-7711/7721 + Certification</p>
    <h3>Rework &amp; Human Quality Gate</h3>
    <ul>
      <li><b>IPC-7711:</b> correcting defects (replace component, reflow cold joint) → restore original compliance</li>
      <li><b>IPC-7721:</b> repair physical damage (lifted pad, broken trace) → restore functionality</li>
      <li><b>CIS:</b> operator/inspector — apply IPC criteria correctly</li>
      <li><b>CIT:</b> trainer — certify CIS in-house; deeper technical + teaching</li>
      <li><b>CSE:</b> expert — interpret standards, resolve disputes, set policy</li>
      <li>All certifications <b>expire every 2 years</b> — track expiration</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">IPC-1782 Traceability</p>
    <h3>Lot-Level Recall Capability</h3>
    <ul>
      <li><b>Component data:</b> manufacturer, lot number, date code, qty</li>
      <li><b>Process data:</b> machine ID, operator ID, timestamp, param set</li>
      <li><b>Test data:</b> result, equipment calibration status</li>
      <li><b>4 Tiers:</b> Tier 1 (basic) → Tier 4 (component level) — higher tier = higher cost</li>
      <li>Enables batch recall: ถ้า component lot มีปัญหา identify affected boards ได้ใน hours</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CIS certification ที่หมดอายุ = ไม่มี certified personnel — ถาม EMS ให้แสดง active certification list ก่อน contract</div>

<!-- Speaker: IPC-7711/7721 rework ที่ไม่ follow approved procedure อาจผ่าน visual inspect แต่ fail ใน field เพราะ heat damage ที่ซ่อนอยู่ -->

---

## IPC ใน Contracts และ Audits: Practical Checklist

<p class="subhead">อย่าปล่อยให้ "quality" เป็น assumption — embed IPC class ลงไปใน document ทุกชิ้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Contract Language ที่ต้องระบุ</p>
    <h3>ใน PO / Engineering Drawing</h3>
    <ul>
      <li>"IPC-A-610 Class [2/3] applies to all assemblies"</li>
      <li>"J-STD-001 Class [2/3] governs soldering process"</li>
      <li>"IPC revision: Rev [H/J] — agree before production freeze"</li>
      <li>"Mixed class zones: specify in assembly drawing"</li>
      <li>"IPC-1782 Tier [1-4] traceability required"</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">EMS Audit Checklist</p>
    <h3>สิ่งที่ต้องขอดู</h3>
    <ul>
      <li>Active CIS/CIT certification list + expiration dates</li>
      <li>Shop traveler ที่ระบุ IPC class ต่อ operation</li>
      <li>Inspector sign-off พร้อม cert number + date</li>
      <li>IPC-1782 traceability records สำหรับ recent lot</li>
      <li>Rework log ที่ระบุ IPC-7711/7721 procedure used</li>
      <li>Corrective action records เมื่อ IPC criterion failed</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EMS ที่ไม่รู้จัก "IPC-1782 Tier" หรือ "CIT expiration" ตอน audit = red flag ว่า IPC เป็นแค่ marketing ไม่ใช่ embedded quality system</div>

<!-- Speaker: Mixed-class zones เป็นเรื่องปกติสำหรับ complex board — แต่ต้องระบุใน drawing ชัดเจน ถ้า EMS ไม่รู้ว่า zone ไหน Class เท่าไร → inspect ผิด class ทั้งบอร์ด -->

---

## Key Takeaways: Quality Standards & IPC Framework

<p class="subhead">สิ่งที่ต้องรู้ก่อนเลือก EMS และก่อน sign contract</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">IPC Standards Quick Reference</p>
    <h3>Standard → ใช้ทำอะไร</h3>
    <ul>
      <li><b>IPC-2221:</b> PCB design baseline (clearance, conductor, mechanical)</li>
      <li><b>IPC-A-610:</b> Assembly acceptance — Class 1/2/3 criteria</li>
      <li><b>J-STD-001:</b> Soldering process — materials, methods, verification</li>
      <li><b>IPC-7711/7721:</b> Rework + repair — approved procedures only</li>
      <li><b>IPC-1782:</b> Traceability — component, process, test data</li>
      <li><b>IPC-7095C:</b> BGA void ≤ 25% per ball (Class 2/3)</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Red Flags ขณะ Audit EMS</p>
    <h3>สัญญาณที่ต้องระวัง</h3>
    <ul>
      <li>ไม่รู้จัก IPC Class หรือ ไม่ระบุ class ใน traveler</li>
      <li>CIS certification หมดอายุหรือ track ไม่ได้</li>
      <li>Rework ไม่มี procedure reference (ทำตาม "ประสบการณ์")</li>
      <li>ไม่มี traceability ระดับ component lot</li>
      <li>ใช้ IPC revision ต่างจาก contract โดยไม่แจ้ง</li>
      <li>ไม่มี corrective action record เมื่อ criterion failed</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP7 → Supply Chain &amp; Component Sourcing: วิธีที่ EMS manage BOM, AVL, last-time-buy, และ counterfeit risk ในโลกที่ lead time ไม่แน่นอน</div>

<!-- Speaker: IPC คือ common language — ถ้า OEM และ EMS พูดภาษาเดียวกัน quality dispute ลดลงอย่างมาก; ถ้าพูดต่าง กัน dispute เกิดขึ้นหลัง production เสร็จแล้ว ซึ่งแพงมาก -->
