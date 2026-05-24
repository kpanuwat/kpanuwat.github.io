---
marp: true
theme: default
paginate: true
title: "Claude Design: จาก PRD สู่ Prototype ใน 1 บทสนทนา"
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
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Claude Design: จาก PRD สู่ Prototype ใน 1 บทสนทนา

<p class="tag">Anthropic Labs · เปิดตัว 17 เม.ย. 2026 · คู่มือสำหรับ Beginners</p>

<!-- Speaker: Claude Design คือ workspace สร้าง prototype ด้วย AI แทน PRD ยาวเหยียด — deck นี้อธิบาย why, what, และ how ใน 12 สไลด์ -->

---

## เดิม: PRD ยาว → สร้าง → ผู้ใช้ไม่ชอบ

<p class="subhead">กระบวนการแบบเดิมใช้เวลาเป็นสัปดาห์ก่อนสร้าง prototype ได้แม้แต่ชิ้นเดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 5-step pain chain -->
  <defs>
    <marker id="ah1" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--muted)"/>
    </marker>
  </defs>
  <!-- Step boxes -->
  <rect x="20" y="120" width="160" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="100" y="170" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เขียน PRD</text>
  <text x="100" y="192" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2-4 สัปดาห์</text>
  <text x="100" y="214" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">approve cycle</text>
  <line x1="180" y1="180" x2="225" y2="180" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah1)"/>

  <rect x="230" y="120" width="160" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="310" y="170" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ออกแบบ</text>
  <text x="310" y="192" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1-2 สัปดาห์</text>
  <text x="310" y="214" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Figma mockup</text>
  <line x1="390" y1="180" x2="435" y2="180" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah1)"/>

  <rect x="440" y="120" width="160" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="520" y="170" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สร้าง</text>
  <text x="520" y="192" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">หลายเดือน</text>
  <text x="520" y="214" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">dev sprint</text>
  <line x1="600" y1="180" x2="645" y2="180" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah1)"/>

  <rect x="650" y="120" width="160" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="730" y="170" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Launch</text>
  <text x="730" y="192" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ผู้ใช้ทดสอบ</text>
  <text x="730" y="214" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ครั้งแรก</text>
  <line x1="810" y1="180" x2="855" y2="180" stroke="var(--danger)" stroke-width="2" marker-end="url(#ah1)"/>

  <rect x="860" y="100" width="200" height="160" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="960" y="162" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">"ไม่ใช่สิ่งที่</text>
  <text x="960" y="184" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ฉันต้องการ"</text>
  <text x="960" y="210" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">เริ่มใหม่</text>
  <!-- Total time label -->
  <rect x="20" y="60" width="820" height="36" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="430" y="83" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">รวม: 3-6 เดือน ก่อนได้รับ user feedback จริง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> กว่าผู้ใช้จะเห็น prototype จริง อาจผ่านไปครึ่งปีแล้ว — และอาจเดาความต้องการผิดทั้งหมด</div>

<!-- Speaker: นี่คือ pain ของ traditional software development — document-first ทำให้ feedback loop ยาวมาก -->

---

## Prototype-First ย่น Feedback Loop จาก เดือน → ชั่วโมง

<p class="subhead">Claude Design เปลี่ยนลำดับ: สร้างก่อน ตัดสินใจทีหลัง — iterate ตามข้อมูลจริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ah2" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
    <marker id="ah2b" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--success)"/>
    </marker>
  </defs>
  <!-- Central loop -->
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="2" stroke-dasharray="6 3"/>
  <circle cx="550" cy="170" r="48" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="48" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude</text>
  <text x="550" y="182" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Design</text>
  <!-- Nodes on loop -->
  <circle cx="550" cy="60" r="32" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="550" y="55" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prompt</text>
  <text x="550" y="71" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไอเดีย</text>
  <circle cx="670" cy="240" r="32" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="670" y="235" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prototype</text>
  <text x="670" y="251" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทันที</text>
  <circle cx="430" cy="240" r="32" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="430" y="235" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Feedback</text>
  <text x="430" y="251" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">จาก user</text>
  <!-- Left side: Old way metric -->
  <rect x="30" y="90" width="180" height="90" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="120" y="128" font-size="22" font-weight="800" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">3-6 เดือน</text>
  <text x="120" y="152" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">วิธีเดิม</text>
  <text x="120" y="172" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">กว่าจะ iterate ได้</text>
  <!-- Right side: New way metric -->
  <rect x="890" y="90" width="180" height="90" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="980" y="128" font-size="22" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">48 ชั่วโมง</text>
  <text x="980" y="152" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Claude Design</text>
  <text x="980" y="172" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">หลาย สิบครั้ง</text>
  <!-- Datadog quote -->
  <rect x="280" y="10" width="540" height="34" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="32" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-style="italic">"A week of back-and-forth reduced to a single conversation." — Datadog</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agility ไม่ใช่ความเร็วอย่างเดียว — มันคือการตัดสินใจด้วยข้อมูลจริงจาก user แทนการเดาล่วงหน้า</div>

<!-- Speaker: วงจร Prompt → Prototype → Feedback → Iterate วนซ้ำ หลาย สิบรอบใน 48 ชั่วโมง ซึ่งเดิมใช้เวลาเป็นเดือน -->

---

## Claude Design คือ Workspace แยก ไม่ใช่ Claude.ai ธรรมดา

<p class="subhead">claude.ai/design — ขับด้วย Opus 4.7 — interface 2 บาน: Chat + Canvas</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Browser chrome -->
  <rect x="40" y="20" width="1020" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-md))"/>
  <!-- Address bar -->
  <rect x="40" y="20" width="1020" height="44" rx="12" fill="var(--soft)"/>
  <rect x="40" y="52" width="1020" height="8" fill="var(--soft)"/>
  <rect x="280" y="30" width="540" height="24" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="46" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">claude.ai/design</text>
  <!-- Divider between panels -->
  <line x1="430" y1="64" x2="430" y2="340" stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- Chat panel -->
  <rect x="55" y="72" width="360" height="36" rx="6" fill="var(--soft)"/>
  <text x="75" y="95" font-size="13" font-weight="700" fill="var(--ink-dim)" font-family="system-ui">Chat Panel</text>
  <!-- Chat bubbles -->
  <rect x="55" y="118" width="280" height="54" rx="8" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="1"/>
  <text x="75" y="141" font-size="12" fill="var(--ink)" font-family="system-ui">"สร้าง dashboard</text>
  <text x="75" y="159" font-size="12" fill="var(--ink)" font-family="system-ui">สำหรับ e-commerce admin"</text>
  <rect x="55" y="184" width="260" height="40" rx="8" fill="var(--soft-2)"/>
  <text x="75" y="200" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Claude: กำลังออกแบบ…</text>
  <text x="75" y="216" font-size="11" fill="var(--muted)" font-family="system-ui">ต้องการ fidelity ระดับใด?</text>
  <rect x="55" y="236" width="280" height="40" rx="8" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="1"/>
  <text x="75" y="252" font-size="11" fill="var(--ink)" font-family="system-ui">"Mockup ก็พอ — เน้น</text>
  <text x="75" y="268" font-size="11" fill="var(--ink)" font-family="system-ui">metric cards 3 ตัวบนสุด"</text>
  <!-- Iteration label -->
  <rect x="55" y="292" width="350" height="28" rx="6" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="230" y="311" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Inline comment, Chat, Direct edit, Slider</text>
  <!-- Canvas panel -->
  <rect x="445" y="72" width="600" height="36" rx="6" fill="var(--soft)"/>
  <text x="465" y="95" font-size="13" font-weight="700" fill="var(--ink-dim)" font-family="system-ui">Canvas (Live Preview)</text>
  <!-- Mock dashboard wireframe -->
  <rect x="445" y="118" width="590" height="204" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <!-- 3 metric cards -->
  <rect x="460" y="130" width="173" height="64" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="546" y="157" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Orders Today</text>
  <text x="546" y="178" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">142</text>
  <rect x="645" y="130" width="173" height="64" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="731" y="157" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Revenue</text>
  <text x="731" y="178" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">฿28k</text>
  <rect x="830" y="130" width="173" height="64" rx="6" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="916" y="157" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Low Stock</text>
  <text x="916" y="178" font-size="18" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">7 items</text>
  <!-- Table area -->
  <rect x="460" y="206" width="543" height="106" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <rect x="460" y="206" width="543" height="24" rx="4" fill="var(--soft)"/>
  <text x="480" y="222" font-size="10" fill="var(--ink-dim)" font-family="system-ui">Order ID</text>
  <text x="590" y="222" font-size="10" fill="var(--ink-dim)" font-family="system-ui">Customer</text>
  <text x="720" y="222" font-size="10" fill="var(--ink-dim)" font-family="system-ui">Status</text>
  <text x="820" y="222" font-size="10" fill="var(--ink-dim)" font-family="system-ui">Amount</text>
  <line x1="460" y1="232" x2="1003" y2="232" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="480" y="248" font-size="10" fill="var(--muted)" font-family="system-ui">#1042</text>
  <text x="590" y="248" font-size="10" fill="var(--muted)" font-family="system-ui">สมชาย</text>
  <rect x="714" y="239" width="50" height="14" rx="4" fill="var(--success-wash)"/>
  <text x="739" y="250" font-size="9" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">shipped</text>
  <text x="820" y="248" font-size="10" fill="var(--muted)" font-family="system-ui">฿1,200</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Chat panel บอกสิ่งที่ต้องการ Canvas แสดงผลทันที — prototype เกิดขึ้นในบทสนทนาเดียว</div>

<!-- Speaker: Interface 2 บานทำงานพร้อมกัน — ซ้ายคุย ขวาเห็นผล real-time -->

---

## 4 วิธี Iterate — Inline Comment ครอบคลุม 95%

<p class="subhead">ไม่ต้องเขียน prompt ใหม่ทุกครั้ง — เลือกวิธีให้ตรงกับขนาดการเปลี่ยนแปลง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">โครงสร้างใหญ่</p>
    <h3>Chat</h3>
    <p>"เปลี่ยน layout จาก 2 คอลัมน์เป็น card grid ทั้งหมด"</p>
  </div>
  <div class="card gold">
    <p class="label">แก้จุด 95% ของงาน</p>
    <h3>Inline Comment</h3>
    <p>คลิก element บน canvas แล้วพิมพ์ "ทำให้ใหญ่กว่านี้ 20%"</p>
  </div>
  <div class="card success">
    <p class="label">แก้ค่าตรงๆ</p>
    <h3>Direct Edit</h3>
    <p>ดับเบิลคลิกข้อความบน canvas แก้ทันที ไม่ต้องผ่าน Claude</p>
  </div>
  <div class="card warning">
    <p class="label">ปรับ continuous</p>
    <h3>Custom Sliders</h3>
    <p>Claude สร้าง slider ให้ปรับ spacing / density / color intensity</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย Chat สำหรับ layout ใหญ่ แล้วใช้ Inline Comment ปรับรายละเอียด — นี่คือ workflow ที่เร็วที่สุด</div>

<!-- Speaker: MacStories ทดสอบจริงพบว่า Inline Comment เร็วกว่าพิมพ์ prompt ใหม่มาก เพราะ Claude รู้ว่ากำลังแก้ element ไหน -->

---

## Claude Design ทำได้ 6 ประเภทงาน

<p class="subhead">ตั้งแต่ prototype สำหรับ user test ยัน marketing landing page — ครอบคลุมทีมทุกขนาด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">ทดสอบกับ user</p>
    <h3>Realistic Prototypes</h3>
    <p>สร้าง interactive prototype โดยไม่ต้องเขียนโค้ด ไม่ต้องรอ PR review</p>
  </div>
  <div class="card success">
    <p class="label">ส่งต่อ dev</p>
    <h3>Wireframes & Mockups</h3>
    <p>ออกแบบ flow สำหรับ handoff ให้ developer ทำต่อ</p>
  </div>
  <div class="card">
    <p class="label">สำรวจทิศทาง</p>
    <h3>Design Exploration</h3>
    <p>ลอง direction หลายแบบอย่างรวดเร็ว ก่อนตัดสินใจ</p>
  </div>
  <div class="card gold">
    <p class="label">ประชุม / Investor</p>
    <h3>Pitch Decks</h3>
    <p>สร้าง deck พร้อม brand ของทีม — Brilliant: 2 prompts แทน 20+</p>
  </div>
  <div class="card warning">
    <p class="label">งานการตลาด</p>
    <h3>Marketing Collateral</h3>
    <p>Landing page, social assets, campaign visuals พร้อม brand system</p>
  </div>
  <div class="card danger">
    <p class="label">Experimental</p>
    <h3>Frontier Design</h3>
    <p>Voice UI, video, 3D shaders — ยังเป็น early-stage, expect roughness</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prototypes และ Design Exploration คือ core use case — Frontier Design เหมาะสำหรับทดลอง ไม่ใช่ production</div>

<!-- Speaker: 6 ประเภทงาน cover ทีม product, design, marketing, และ founder ได้ครบ -->

---

## Design System = ลงทุนครั้งเดียว ได้ Brand ทุกโปรเจกต์

<p class="subhead">Org admin ตั้งค่าครั้งเดียว — สีแบรนด์, typography, components inject อัตโนมัติทุก project ใหม่</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ah3" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Design System source box -->
  <rect x="60" y="80" width="280" height="180" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="200" y="120" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Design System</text>
  <text x="200" y="144" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตั้งค่าโดย Org Admin</text>
  <rect x="90" y="158" width="90" height="24" rx="6" fill="var(--accent)" opacity=".2"/>
  <text x="135" y="175" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Brand Colors</text>
  <rect x="200" y="158" width="90" height="24" rx="6" fill="var(--accent)" opacity=".2"/>
  <text x="245" y="175" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Typography</text>
  <rect x="90" y="192" width="200" height="24" rx="6" fill="var(--accent)" opacity=".2"/>
  <text x="190" y="209" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">UI Components Library</text>
  <!-- Arrow -->
  <line x1="340" y1="170" x2="440" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah3)" stroke-dasharray="6 3"/>
  <text x="390" y="158" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">auto-inject</text>
  <!-- New projects stacked -->
  <rect x="450" y="60" width="580" height="260" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="740" y="88" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทุก New Project</text>
  <rect x="475" y="104" width="240" height="88" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="595" y="130" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prototype A</text>
  <text x="595" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Brand colors auto-applied</text>
  <text x="595" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Components ready to use</text>
  <rect x="740" y="104" width="240" height="88" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="860" y="130" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pitch Deck B</text>
  <text x="860" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Typography matches brand</text>
  <text x="860" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No hex copy-paste needed</text>
  <rect x="607" y="208" width="240" height="88" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="727" y="234" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Landing Page C</text>
  <text x="727" y="256" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Consistent visual identity</text>
  <text x="727" y="276" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Across all team members</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งค่า Design System ครั้งแรกให้ครบก่อน rollout — output จะ generic มากถ้าข้ามขั้นนี้</div>

<!-- Speaker: Design System คือ investment สำคัญที่สุดก่อนใช้ Claude Design ทั้งทีม -->

---

## Export ได้ 5 รูปแบบ — Claude Code Handoff ซีมเลสที่สุด

<p class="subhead">จาก claude.ai/design ไปถึง production ได้โดยตรง — ไม่ต้อง convert หรือ screenshot</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ah4" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--muted)"/>
    </marker>
    <marker id="ah4b" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Source -->
  <rect x="60" y="110" width="200" height="100" rx="14" fill="var(--accent)" opacity=".9" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="160" y="152" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Claude Design</text>
  <text x="160" y="174" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">claude.ai/design</text>
  <!-- Arrows -->
  <line x1="260" y1="140" x2="320" y2="90" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah4)"/>
  <line x1="260" y1="155" x2="320" y2="155" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah4)"/>
  <line x1="260" y1="170" x2="320" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah4)"/>
  <line x1="260" y1="155" x2="620" y2="90" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah4)"/>
  <line x1="260" y1="155" x2="620" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah4)"/>
  <!-- Export options -->
  <rect x="325" y="58" width="160" height="64" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="405" y="85" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">URL Share</text>
  <text x="405" y="105" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">view/edit permission</text>
  <rect x="325" y="123" width="160" height="64" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="405" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PDF / PPTX</text>
  <text x="405" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">print / presentation</text>
  <rect x="325" y="188" width="160" height="64" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="405" y="215" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">HTML / ZIP</text>
  <text x="405" y="235" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">web deploy ได้ทันที</text>
  <rect x="625" y="58" width="160" height="64" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="705" y="85" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Canva</text>
  <text x="705" y="105" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">แก้ใน Canva ต่อได้</text>
  <!-- Claude Code highlight -->
  <rect x="625" y="188" width="200" height="88" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="725" y="220" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="725" y="242" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">bundle ส่ง dev โดยตรง</text>
  <text x="725" y="260" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ซีมเลสที่สุด</text>
  <line x1="260" y1="155" x2="623" y2="232" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah4b)" stroke-dasharray="0"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า developer จะสร้างต่อ → ใช้ Claude Code handoff ข้ามขั้นตอน screenshot และ spec เขียนเอง</div>

<!-- Speaker: Claude Code handoff คือ killer feature สำหรับทีมที่ใช้ Claude ทั้ง design และ dev side -->

---

## เริ่มใช้ใน 5 ขั้นตอน — ทำได้เลยวันนี้

<p class="subhead">ต้องมี Claude Pro ขึ้นไป — ไม่มีค่าใช้จ่ายเพิ่ม ใช้ quota จาก subscription เดิม</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ah5" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- 5 steps arrow flow -->
  <rect x="20" y="80" width="180" height="140" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="110" cy="112" r="18" fill="var(--accent)"/>
  <text x="110" y="118" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="110" y="148" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เข้า</text>
  <text x="110" y="166" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">claude.ai/design</text>
  <text x="110" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Pro / Max / Team</text>
  <line x1="200" y1="150" x2="225" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah5)"/>

  <rect x="230" y="80" width="180" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="320" cy="112" r="18" fill="var(--soft-2)"/>
  <text x="320" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="320" y="148" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สร้าง Project</text>
  <text x="320" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Wireframe /</text>
  <text x="320" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mockup / Prototype</text>
  <line x1="410" y1="150" x2="435" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah5)"/>

  <rect x="440" y="80" width="200" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="540" cy="112" r="18" fill="var(--soft-2)"/>
  <text x="540" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="540" y="148" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ให้ Context ครบ</text>
  <text x="540" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Goal + Layout</text>
  <text x="540" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Content + Audience</text>
  <line x1="640" y1="150" x2="665" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah5)"/>

  <rect x="670" y="80" width="180" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="760" cy="112" r="18" fill="var(--soft-2)"/>
  <text x="760" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="760" y="148" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Iterate</text>
  <text x="760" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Comment / Chat /</text>
  <text x="760" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทดสอบกับ user</text>
  <line x1="850" y1="150" x2="875" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#ah5)"/>

  <rect x="880" y="80" width="180" height="140" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="970" cy="112" r="18" fill="var(--success)"/>
  <text x="970" y="118" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="970" y="148" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Export / Handoff</text>
  <text x="970" y="168" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">URL / PDF /</text>
  <text x="970" y="186" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <!-- Tip box -->
  <rect x="20" y="248" width="1060" height="32" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="550" y="269" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Tip: ถ้า Claude ไม่เข้าใจ intent หลัง 3 rounds → reset prompt ใหม่ทั้งหมด อย่า patch ต่อไปเรื่อยๆ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Draft แรกคือจุดเริ่มต้น ไม่ใช่ผลลัพธ์ — คุณค่าอยู่ที่ iteration cycle ไม่ใช่ prompt แรก</div>

<!-- Speaker: 5 ขั้นตอน ใช้เวลาไม่ถึงชั่วโมงสำหรับ first prototype -->

---

## Context ที่ดี = Output ที่ดี — 4 องค์ประกอบ

<p class="subhead">Claude Design ทำงานได้ดีขึ้นมากเมื่อได้รับ context ครบ 4 ส่วน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">G — Goal</p>
    <h3>เป้าหมาย</h3>
    <p>"dashboard สำหรับ e-commerce admin ดู order รายวัน"</p>
  </div>
  <div class="card success">
    <p class="label">L — Layout</p>
    <h3>โครงสร้าง</h3>
    <p>"3 metric cards บนสุด ตาราง order ด้านล่าง"</p>
  </div>
  <div class="card gold">
    <p class="label">C — Content</p>
    <h3>เนื้อหา</h3>
    <p>"แสดง: orders วันนี้, revenue, stock ที่ใกล้หมด"</p>
  </div>
  <div class="card warning">
    <p class="label">A — Audience</p>
    <h3>ผู้ใช้</h3>
    <p>"store manager อายุ 30-45 ไม่ expert ด้าน tech"</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยิ่งบอก Audience ชัด ยิ่งได้ UI ที่เหมาะกับ user จริง — อย่าข้ามส่วนนี้แม้จะดูเหมือน obvious</div>

<!-- Speaker: GLCA framework ช่วยให้ Claude เข้าใจ intent ครบ ไม่ต้องถามกลับมาหลายรอบ -->

---

## ข้อจำกัดที่ต้องรู้ก่อนใช้ทั้งทีม

<p class="subhead">Research Preview ยังมี rough edges — วางแผน rollout ให้พร้อมก่อนจะดีกว่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card danger">
    <p class="label">ไม่รองรับ</p>
    <h3>ไม่มี Figma</h3>
    <p>นำเข้า/ส่งออก .fig ไม่ได้ — ถ้าทีมใช้ Figma เป็น source of truth ต้อง plan ก่อน</p>
  </div>
  <div class="card warning">
    <p class="label">Usage Limit</p>
    <h3>Weekly Quota</h3>
    <p>reset รายสัปดาห์ต่อ user ไม่ pooled ทั้ง org — ทีมใหญ่อาจชนเพดาน</p>
  </div>
  <div class="card warning">
    <p class="label">Research Preview</p>
    <h3>ยังมี Bugs</h3>
    <p>comment หาย, save error ใน compact view, lag กับ large codebase</p>
  </div>
  <div class="card danger">
    <p class="label">Output Generic</p>
    <h3>ไม่มี Design System</h3>
    <p>ตั้งค่า brand system ให้ครบก่อน rollout — output จะ generic มากถ้าข้าม</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งค่า Design System ก่อน rollout ทั้งทีม — นั่นคือสิ่งที่แก้ปัญหา generic output ได้มากที่สุด</div>

<!-- Speaker: ข้อจำกัดเหล่านี้แก้ได้ส่วนใหญ่ด้วยการ setup ที่ดีตั้งแต่แรก -->

---

## สรุป: Agility > Prediction ในยุค AI

<p class="subhead">Claude Design เปลี่ยน philosophy ไม่ใช่แค่เปลี่ยน tool</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- concentric rings: layered takeaways -->
  <circle cx="550" cy="160" r="150" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="160" r="100" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".35"/>
  <circle cx="550" cy="160" r="55" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="160" r="55" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="153" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Prototype</text>
  <text x="550" y="172" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">First</text>
  <!-- Second ring labels -->
  <text x="395" y="90" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Inline Comment</text>
  <text x="395" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">95% ของงาน</text>
  <text x="705" y="90" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Design System</text>
  <text x="705" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตั้งค่าครั้งเดียว</text>
  <text x="395" y="240" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">6 Use Cases</text>
  <text x="395" y="258" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">prototype → deck</text>
  <text x="705" y="240" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="705" y="258" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">handoff ซีมเลส</text>
  <!-- Outer ring labels -->
  <text x="190" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Pro+</text>
  <text x="190" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">17 เม.ย. 2026</text>
  <text x="910" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Opus 4.7</text>
  <text x="910" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Research Preview</text>
  <!-- Datadog quote -->
  <rect x="200" y="288" width="700" height="26" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="305" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-style="italic">"A week of back-and-forth → a single conversation" — Datadog</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เปิด claude.ai/design ตอนนี้ — ทดสอบ 2-3 iterations ก็รู้แล้วว่า fit กับ workflow ของทีมหรือเปล่า</div>

<!-- Speaker: Philosophy สำคัญกว่า feature list — Agility แทน Prediction คือ paradigm shift ที่แท้จริง -->
