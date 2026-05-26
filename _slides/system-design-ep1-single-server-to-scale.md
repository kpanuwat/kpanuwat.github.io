---
marp: true
theme: default
paginate: true
title: "System Design EP1: จาก Single Server สู่ระบบที่รองรับล้าน User"
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
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# System Design EP1
# จาก Single Server สู่ระบบที่รองรับล้าน User

<p class="tag">Series: เจาะลึก System Design Fundamentals · EP 1/5</p>

<!-- Speaker: EP แรกของ series — วางรากฐานทุกอย่างที่ EP ถัด ๆ ไปจะต่อยอด -->

---

## ทุกระบบเริ่มจาก Single Server — แต่ไม่ได้จบที่นั้น

<p class="subhead">การเข้าใจ evolution ของ architecture ทำให้ตัดสินใจได้ว่าควร scale เมื่อไหร่ และ scale อะไร</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="60" width="200" height="240" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="140" y="110" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MVP Stage</text>
  <rect x="60" y="125" width="160" height="44" rx="8" fill="var(--accent)" opacity=".15"/>
  <text x="140" y="151" font-size="13" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Single Server</text>
  <text x="140" y="190" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Web+App+DB</text>
  <text x="140" y="268" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Fast + Cheap</text>

  <path d="M240 180 L320 180" stroke="var(--muted)" stroke-width="2" stroke-dasharray="6,3" marker-end="url(#arr)"/>
  <text x="280" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Users grow</text>

  <rect x="320" y="60" width="200" height="240" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="420" y="110" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Growth Stage</text>
  <rect x="340" y="125" width="160" height="36" rx="8" fill="var(--accent)" opacity=".15"/>
  <text x="420" y="147" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Web Tier</text>
  <rect x="340" y="172" width="160" height="36" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="420" y="194" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">DB Tier</text>
  <text x="420" y="248" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Tiers separated</text>

  <path d="M520 180 L600 180" stroke="var(--muted)" stroke-width="2" stroke-dasharray="6,3" marker-end="url(#arr)"/>
  <text x="560" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Scale needed</text>

  <rect x="600" y="60" width="460" height="240" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="830" y="104" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Scale Stage</text>
  <rect x="700" y="120" width="100" height="34" rx="8" fill="var(--accent)"/>
  <text x="750" y="141" font-size="11" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">Load Balancer</text>
  <rect x="840" y="108" width="80" height="28" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="880" y="125" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Web 1</text>
  <rect x="840" y="144" width="80" height="28" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="880" y="161" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Web 2</text>
  <path d="M800 134 L840 120" stroke="var(--accent)" stroke-width="1.5"/>
  <path d="M800 134 L840 157" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="840" y="188" width="80" height="28" rx="6" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="880" y="205" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Cache</text>
  <rect x="940" y="188" width="80" height="28" rx="6" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1"/>
  <text x="980" y="205" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">DB Master</text>
  <text x="830" y="270" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">LB + Cache + Replication + CDN</text>

  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Architecture evolution เป็น response to real demand — ไม่ใช่การ design ล่วงหน้าทั้งหมด</div>

<!-- Speaker: ชี้ให้เห็น 3 stage ที่ทุก system ผ่าน — วันนี้จะไล่ทีละ step -->

---

## Single Server: ง่าย เร็ว แต่มี Ceiling ที่ชัดเจน

<p class="subhead">ทุกอย่างรันในเครื่องเดียว — เหมาะสำหรับ MVP แต่ไม่ scale</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- User -->
  <circle cx="80" cy="180" r="32" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="2"/>
  <text x="80" y="175" font-size="20" text-anchor="middle" font-family="system-ui">👤</text>
  <text x="80" y="230" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">User</text>

  <!-- Arrow to DNS -->
  <path d="M112 180 L200 180" stroke="var(--accent)" stroke-width="2" marker-end="url(#a1)"/>
  <text x="156" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">DNS lookup</text>

  <!-- DNS -->
  <rect x="200" y="152" width="100" height="56" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="250" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">DNS</text>
  <text x="250" y="198" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IP address</text>

  <!-- Arrow to Server -->
  <path d="M300 180 L420 180" stroke="var(--accent)" stroke-width="2" marker-end="url(#a1)"/>
  <text x="360" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HTTP request</text>

  <!-- Single Server box -->
  <rect x="420" y="80" width="340" height="200" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="420" y="80" width="340" height="44" rx="14" fill="var(--accent)" opacity=".9"/>
  <text x="590" y="108" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Single Server</text>
  <rect x="444" y="140" width="90" height="32" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="489" y="160" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Web Server</text>
  <rect x="554" y="140" width="90" height="32" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="599" y="160" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">App Server</text>
  <rect x="664" y="140" width="80" height="32" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="704" y="160" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Database</text>

  <!-- Pros / Cons -->
  <rect x="444" y="188" width="140" height="76" rx="8" fill="var(--success-wash)"/>
  <text x="514" y="208" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ข้อดี</text>
  <text x="514" y="228" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ง่าย / ถูก / deploy เร็ว</text>
  <text x="514" y="248" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">เหมาะกับ MVP</text>

  <rect x="604" y="188" width="140" height="76" rx="8" fill="var(--danger-wash)"/>
  <text x="674" y="208" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ข้อเสีย</text>
  <text x="674" y="228" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Single point of failure</text>
  <text x="674" y="248" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Scale ไม่ได้เป็นส่วน ๆ</text>

  <defs>
    <marker id="a1" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Single server เหมาะกับ MVP — เมื่อมี user จริง ค่อย scale ตาม bottleneck ที่เกิดขึ้น</div>

<!-- Speaker: ถ้า server ตาย ทุกอย่างตาย — นี่คือ motivation สำหรับ step ถัดไป -->

---

## แยก Web Tier และ Data Tier: Scale ได้อิสระแต่ละส่วน

<p class="subhead">การแยก tier เป็น prerequisite สำหรับ horizontal scaling — ทำตั้งแต่เนิ่น ๆ คุ้มค่าที่สุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Internet/Users -->
  <rect x="30" y="140" width="110" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="85" y="176" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Internet</text>
  <text x="85" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Users</text>

  <!-- Arrow -->
  <path d="M140 180 L220 180" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Load Balancer -->
  <rect x="220" y="150" width="120" height="60" rx="10" fill="var(--accent)" />
  <text x="280" y="178" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Load</text>
  <text x="280" y="198" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Balancer</text>

  <!-- Arrows to web servers -->
  <path d="M340 165 L430 120" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#a2)"/>
  <path d="M340 180 L430 180" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#a2)"/>
  <path d="M340 195 L430 240" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#a2)"/>

  <!-- Web tier label -->
  <rect x="425" y="60" width="220" height="260" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <text x="535" y="88" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Web Tier</text>
  <text x="535" y="104" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">(scale horizontal)</text>

  <rect x="440" y="108" width="190" height="36" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="535" y="130" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Web Server 1</text>
  <rect x="440" y="166" width="190" height="36" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="535" y="188" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Web Server 2</text>
  <rect x="440" y="224" width="190" height="36" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="535" y="246" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Web Server N</text>

  <!-- Arrows to DB -->
  <path d="M645 125 L720 160" stroke="var(--warning)" stroke-width="1.5" marker-end="url(#a3)"/>
  <path d="M645 184 L720 184" stroke="var(--warning)" stroke-width="1.5" marker-end="url(#a3)"/>
  <path d="M645 242 L720 208" stroke="var(--warning)" stroke-width="1.5" marker-end="url(#a3)"/>

  <!-- DB tier label -->
  <rect x="715" y="120" width="220" height="130" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <text x="825" y="148" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Data Tier</text>
  <text x="825" y="164" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">(scale vertical)</text>
  <rect x="735" y="176" width="180" height="60" rx="8" fill="var(--paper)" stroke="var(--warning)" stroke-width="1"/>
  <text x="825" y="203" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Database Server</text>
  <text x="825" y="222" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">dedicated, optimized</text>

  <defs>
    <marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
    <marker id="a3" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--warning)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แยก tier = scale แต่ละส่วนได้อิสระ — ถ้า Web รับ load เพิ่ม server ได้เลย ไม่ต้องแตะ DB</div>

<!-- Speaker: จุดนี้คือ foundation ของ scaling ทุกอย่าง — ทำก่อน add features อื่น -->

---

## Vertical vs Horizontal Scaling: เลือกให้ถูกทาง

<p class="subhead">Vertical เร็วแต่มี ceiling; Horizontal ไม่มีขีดจำกัดแต่ต้องการ stateless design</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Scale Up (Vertical)</p>
    <h3>เพิ่ม CPU / RAM เครื่องเดิม</h3>
    <p>ง่ายและเร็ว — แต่มี hardware ceiling และยังคงเป็น single point of failure ไม่ว่า server จะใหญ่แค่ไหน</p>
    <ul>
      <li>Hardware ceiling ชัดเจน</li>
      <li>Single point of failure</li>
      <li>ค่าใช้จ่ายพุ่งสูงที่ high-end</li>
      <li>เหมาะระยะสั้น / quick fix</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Scale Out (Horizontal) — Recommended</p>
    <h3>เพิ่มจำนวน Server</h3>
    <p>ไม่มีขีดจำกัดทางทฤษฎี — เพิ่ม server ใหม่เข้า pool ได้ตลอดเวลา ต้องมี Load Balancer และ Stateless design</p>
    <ul>
      <li>ไม่มี hardware ceiling</li>
      <li>Redundant โดยธรรมชาติ</li>
      <li>Zero-downtime scaling</li>
      <li>ต้องการ stateless web tier</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Vertical เป็นทางออกระยะสั้น — Horizontal เป็น long-term strategy แต่ต้องการ stateless architecture</div>

<!-- Speaker: เน้น: Horizontal ต้องการ stateless — ถ้า server เก็บ session ไว้ใน memory จะ scale ไม่ได้ -->

---

## Load Balancer: กระจาย Traffic + ป้องกัน Single Point of Failure

<p class="subhead">Load balancer รับ public traffic แล้วส่งต่อผ่าน private network ซ่อน internal topology</p>

<div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;flex:1;align-items:center">
<div>
<svg viewBox="0 0 480 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a4" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="#3b82f6"/>
    </marker>
  </defs>
  <rect x="10" y="120" width="80" height="60" rx="8" fill="#f1f5f9" stroke="#e2e8f0" stroke-width="1.5"/>
  <text x="50" y="148" font-size="12" fill="#1e293b" text-anchor="middle" font-family="system-ui" font-weight="700">Internet</text>
  <text x="50" y="166" font-size="9" fill="#94a3b8" text-anchor="middle" font-family="system-ui">public</text>
  <path d="M90 150 L150 150" stroke="#3b82f6" stroke-width="2" marker-end="url(#a4)"/>
  <rect x="150" y="108" width="100" height="84" rx="10" fill="#3b82f6"/>
  <text x="200" y="145" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Load</text>
  <text x="200" y="163" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Balancer</text>
  <text x="200" y="182" font-size="9" fill="rgba(255,255,255,.7)" text-anchor="middle" font-family="system-ui">public IP</text>
  <path d="M250 130 L330 80" stroke="#3b82f6" stroke-width="1.5" marker-end="url(#a4)"/>
  <path d="M250 150 L330 150" stroke="#3b82f6" stroke-width="1.5" marker-end="url(#a4)"/>
  <path d="M250 170 L330 220" stroke="#3b82f6" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="330" y="58" width="130" height="44" rx="6" fill="white" stroke="#3b82f6" stroke-width="1.5"/>
  <text x="395" y="83" font-size="11" font-weight="700" fill="#3b82f6" text-anchor="middle" font-family="system-ui">Web Server 1</text>
  <rect x="330" y="128" width="130" height="44" rx="6" fill="white" stroke="#3b82f6" stroke-width="1.5"/>
  <text x="395" y="153" font-size="11" font-weight="700" fill="#3b82f6" text-anchor="middle" font-family="system-ui">Web Server 2</text>
  <rect x="330" y="198" width="130" height="44" rx="6" fill="white" stroke="#94a3b8" stroke-width="1" stroke-dasharray="4,3"/>
  <text x="395" y="223" font-size="11" fill="#94a3b8" text-anchor="middle" font-family="system-ui">Server N+</text>
</svg>
</div>
<div class="bento cols-1" style="display:flex;flex-direction:column;gap:10px">
  <div class="card compact">
    <p class="label">Algorithm 1</p>
    <h3>Round Robin</h3>
    <p>เวียนส่ง request ทีละ server — เหมาะเมื่อ server spec เท่ากัน</p>
  </div>
  <div class="card compact success">
    <p class="label">Algorithm 2</p>
    <h3>Least Connections</h3>
    <p>ส่งไป server ที่มี active connection น้อยที่สุด — เหมาะ long-lived connections</p>
  </div>
  <div class="card compact warning">
    <p class="label">Algorithm 3</p>
    <h3>Weighted Round Robin</h3>
    <p>กำหนด weight ตาม capacity — server แรงกว่าได้ traffic มากกว่า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Load Balancer = HA gateway + scaling enabler + IP shield — LB เองต้องมี HA ด้วย ไม่เช่นนั้นกลายเป็น SPOF ตัวใหม่</div>

<!-- Speaker: อย่าลืม: LB เองก็ต้องมี HA — ถ้ามี LB ตัวเดียว กลายเป็น SPOF ตัวใหม่ -->

---

## Database Replication: แยก Read และ Write เพื่อ Performance

<p class="subhead">Read:Write ratio 80:20 → offload reads ไป replicas ลด load บน master ได้มหาศาล</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- App server -->
  <rect x="60" y="120" width="160" height="100" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="165" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Application</text>
  <text x="140" y="185" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Server</text>

  <!-- Write arrow -->
  <path d="M220 148 L380 110" stroke="var(--danger)" stroke-width="2" marker-end="url(#a5)"/>
  <text x="295" y="120" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui" font-weight="700">WRITE</text>

  <!-- Read arrow -->
  <path d="M220 192 L380 250" stroke="var(--success)" stroke-width="2" marker-end="url(#a5a)"/>
  <text x="295" y="240" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui" font-weight="700">READ</text>

  <!-- Master DB -->
  <rect x="380" y="60" width="200" height="100" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="380" y="60" width="200" height="36" rx="12" fill="var(--danger)" opacity=".12"/>
  <text x="480" y="84" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Master DB</text>
  <text x="480" y="104" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">(Primary)</text>
  <text x="480" y="130" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Writes only</text>
  <text x="480" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Strong consistency</text>

  <!-- Sync arrows -->
  <path d="M580 90 L680 110" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#a5b)"/>
  <path d="M580 105 L680 220" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#a5b)"/>
  <text x="650" y="160" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">async sync</text>

  <!-- Replica 1 -->
  <rect x="680" y="80" width="180" height="90" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="770" y="108" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Replica DB 1</text>
  <text x="770" y="128" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Reads only</text>
  <text x="770" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Eventual consistency</text>

  <!-- Replica 2 -->
  <rect x="680" y="196" width="180" height="90" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="770" y="224" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Replica DB 2</text>
  <text x="770" y="244" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Reads only</text>
  <text x="770" y="264" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Horizontal read scale</text>

  <!-- Stats box -->
  <rect x="890" y="100" width="185" height="140" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="982" y="126" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Typical Ratio</text>
  <text x="982" y="156" font-size="28" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">80%</text>
  <text x="982" y="176" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Reads (go to Replicas)</text>
  <text x="982" y="204" font-size="22" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">20%</text>
  <text x="982" y="222" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Writes (go to Master)</text>

  <defs>
    <marker id="a5" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--danger)"/>
    </marker>
    <marker id="a5a" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--success)"/>
    </marker>
    <marker id="a5b" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ส่วนใหญ่ app อ่านมากกว่าเขียน — replica DB คือวิธีที่ cost-effective ที่สุดในการ scale read throughput</div>

<!-- Speaker: ระวัง replication lag — critical reads เช่น "ยืนยัน payment" ต้องไปที่ master เสมอ -->

---

## Caching Layer: ตอบ Request เร็วขึ้น 100x โดยไม่แตะ Database

<p class="subhead">Cache เก็บผลลัพธ์ที่ compute แล้ว — Read-through pattern ลด DB load ได้อย่างมีประสิทธิภาพ</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- App -->
  <rect x="40" y="140" width="130" height="70" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="105" y="178" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Application</text>

  <!-- Arrow to cache check -->
  <path d="M170 175 L250 175" stroke="var(--accent)" stroke-width="2" marker-end="url(#a6)"/>
  <text x="210" y="163" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">request</text>

  <!-- Cache -->
  <rect x="250" y="120" width="180" height="110" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="340" y="155" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Cache</text>
  <text x="340" y="175" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">(Redis)</text>
  <text x="340" y="200" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">in-memory store</text>

  <!-- HIT path -->
  <path d="M430 165 L580 130" stroke="var(--success)" stroke-width="2" marker-end="url(#a6a)"/>
  <text x="505" y="140" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui" font-weight="700">CACHE HIT</text>

  <rect x="580" y="100" width="200" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="680" y="134" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Return cached</text>
  <text x="680" y="154" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">data instantly</text>
  <text x="680" y="172" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">&lt; 1ms response</text>

  <!-- MISS path -->
  <path d="M430 205 L580 240" stroke="var(--danger)" stroke-width="2" marker-end="url(#a6b)"/>
  <text x="505" y="238" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui" font-weight="700">CACHE MISS</text>

  <rect x="580" y="208" width="200" height="80" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="680" y="238" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Query Database</text>
  <text x="680" y="258" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Store in cache</text>
  <text x="680" y="276" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">10-100ms response</text>

  <!-- Store back arrow -->
  <path d="M580 248 L430 220" stroke="var(--muted)" stroke-width="1" stroke-dasharray="4,3" marker-end="url(#a6c)"/>
  <text x="510" y="242" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">store result</text>

  <!-- DB -->
  <rect x="820" y="208" width="160" height="80" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="900" y="250" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Database</text>
  <text x="900" y="274" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">only on MISS</text>
  <path d="M780 248 L820 248" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a6c)"/>

  <!-- Trade-offs -->
  <rect x="820" y="80" width="240" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="940" y="106" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Trade-offs</text>
  <text x="840" y="128" font-size="10" fill="var(--warning-ink)" font-family="system-ui">TTL too long: stale data</text>
  <text x="840" y="148" font-size="10" fill="var(--danger-ink)" font-family="system-ui">TTL too short: no benefit</text>
  <text x="840" y="168" font-size="10" fill="var(--ink-dim)" font-family="system-ui">Cold start: DB spike risk</text>

  <defs>
    <marker id="a6" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
    <marker id="a6a" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--success)"/>
    </marker>
    <marker id="a6b" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--danger)"/>
    </marker>
    <marker id="a6c" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cache ลด DB load ได้มาก แต่ cache invalidation คือปัญหา classic — กำหนด TTL ให้เหมาะกับ data freshness requirement</div>

<!-- Speaker: "There are only two hard things in computer science: cache invalidation and naming things" — Phil Karlton -->

---

## CDN: เสิร์ฟ Static Assets จากที่ใกล้ User ที่สุด

<p class="subhead">CDN edge servers กระจายทั่วโลก — user Bangkok ดึง content จาก Singapore ไม่ใช่ US</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Origin Server -->
  <rect x="460" y="120" width="180" height="100" rx="12" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="2"/>
  <text x="550" y="162" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Origin Server</text>
  <text x="550" y="182" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(e.g. US-East)</text>
  <text x="550" y="200" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Source of truth</text>

  <!-- CDN Edges -->
  <rect x="60" y="60" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="94" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CDN Edge</text>
  <text x="140" y="114" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Singapore</text>
  <text x="140" y="130" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cached assets</text>

  <rect x="60" y="200" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="234" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CDN Edge</text>
  <text x="140" y="254" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Tokyo</text>
  <text x="140" y="270" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cached assets</text>

  <rect x="880" y="60" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="960" y="94" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CDN Edge</text>
  <text x="960" y="114" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Frankfurt</text>
  <text x="960" y="130" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cached assets</text>

  <rect x="880" y="200" width="160" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="960" y="234" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CDN Edge</text>
  <text x="960" y="254" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Virginia</text>
  <text x="960" y="270" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cached assets</text>

  <!-- Lines from origin to edges -->
  <path d="M460 152 L220 98" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <path d="M460 168 L220 238" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <path d="M640 152 L880 98" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <path d="M640 168 L880 238" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>

  <!-- User Bangkok -->
  <rect x="60" y="286" width="160" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="140" y="312" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">User Bangkok</text>
  <text x="140" y="326" font-size="9" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">hits Singapore edge</text>

  <rect x="880" y="296" width="160" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="960" y="322" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">User New York</text>
  <text x="960" y="336" font-size="9" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">hits Virginia edge</text>
  <text x="550" y="310" font-size="10" fill="#94a3b8" text-anchor="middle" font-family="system-ui">Cache miss: falls back to origin server</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CDN ลด latency สำหรับ static content โดยไม่ต้องแตะ origin — cost ตาม data transfer, คุ้มเมื่อมี global users</div>

<!-- Speaker: CloudFront, Cloudflare, Fastly เป็น CDN ยอดนิยม — ตั้งค่าง่าย, ROI ชัด -->

---

## Stateless Web Tier: Prerequisite สำหรับ Horizontal Scaling

<p class="subhead">ถ้า server เก็บ session ใน memory จะ scale ไม่ได้ — ย้าย state ไป shared store แก้ได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Stateful — Problem</p>
    <h3>Session อยู่ใน Server Memory</h3>
    <p>User A login ที่ Server 1 → Load Balancer ส่ง request ถัดไปไป Server 2 → Server 2 ไม่มี session → User ถูก logout</p>
    <ul>
      <li>ไม่สามารถเพิ่ม Server 3 ได้อย่างปลอดภัย</li>
      <li>Sticky sessions เป็น workaround ไม่ใช่ solution</li>
      <li>Auto-scaling ทำได้ยาก</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Stateless — Solution</p>
    <h3>Session ใน Shared Store (Redis)</h3>
    <p>Server ทุกตัวอ่าน session จาก Redis — Load Balancer ส่ง request ไป server ไหนก็ได้ ผู้ใช้ไม่รู้สึกถึงความต่าง</p>
    <ul>
      <li>เพิ่ม Server N ได้ทันที</li>
      <li>Auto-scaling ทำงานได้สมบูรณ์</li>
      <li>Zero-downtime deploy ง่ายขึ้น</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Stateless = scalable — ย้าย session ออกจาก server memory ก่อนที่จะ scale horizontal ทุกครั้ง</div>

<!-- Speaker: เรื่องนี้ขัดกับ intuition — "session อยู่กับ server" ดูง่ายกว่า แต่ฆ่า scalability -->

---

## Architecture Evolution: 8 Steps จาก Single Server สู่ Scale

<p class="subhead">ทุก step เพิ่มเพื่อแก้ปัญหาเฉพาะ — อย่า add ล่วงหน้าโดยไม่มี evidence</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Steps -->
  <circle cx="70" cy="80" r="26" fill="var(--accent)"/>
  <text x="70" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="70" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Single</text>
  <text x="70" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Server</text>

  <path d="M96 80 L164 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="190" cy="80" r="26" fill="var(--accent)"/>
  <text x="190" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="190" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Web+DB</text>
  <text x="190" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Split</text>

  <path d="M216 80 L284 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="310" cy="80" r="26" fill="var(--accent)"/>
  <text x="310" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="310" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Load</text>
  <text x="310" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Balancer</text>

  <path d="M336 80 L404 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="430" cy="80" r="26" fill="var(--accent)"/>
  <text x="430" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="430" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">DB</text>
  <text x="430" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Replica</text>

  <path d="M456 80 L524 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="550" cy="80" r="26" fill="var(--accent)"/>
  <text x="550" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="550" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cache</text>
  <text x="550" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Layer</text>

  <path d="M576 80 L644 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="670" cy="80" r="26" fill="var(--accent)"/>
  <text x="670" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">6</text>
  <text x="670" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">CDN</text>
  <text x="670" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Static</text>

  <path d="M696 80 L764 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="790" cy="80" r="26" fill="var(--accent)"/>
  <text x="790" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">7</text>
  <text x="790" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Stateless</text>
  <text x="790" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tier</text>

  <path d="M816 80 L884 80" stroke="var(--accent)" stroke-width="2" marker-end="url(#a8)"/>

  <circle cx="910" cy="80" r="26" fill="var(--accent-deep)"/>
  <text x="910" y="86" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">8</text>
  <text x="910" y="122" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Multi</text>
  <text x="910" y="134" font-size="9" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Region</text>

  <!-- What's next -->
  <rect x="40" y="170" width="1020" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="200" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">EP Series ต่อไป</text>

  <rect x="60" y="216" width="200" height="56" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="160" y="240" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">EP2</text>
  <text x="160" y="258" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SQL vs NoSQL</text>

  <rect x="290" y="216" width="200" height="56" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="390" y="240" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">EP3</text>
  <text x="390" y="258" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Load Balancing Deep Dive</text>

  <rect x="520" y="216" width="200" height="56" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="620" y="240" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">EP4</text>
  <text x="620" y="258" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">API Design</text>

  <rect x="750" y="216" width="200" height="56" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="850" y="240" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">EP5</text>
  <text x="850" y="258" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Auth &amp; Security</text>

  <defs>
    <marker id="a8" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก step แก้ปัญหาเฉพาะที่มี evidence — scale เพื่อ solve ไม่ใช่ scale เพื่อ impress</div>

---

## Key Takeaways: สิ่งที่ต้องจำจาก EP1

<p class="subhead">Foundation ของ System Design — ทุก EP ถัดไปต่อยอดจากนี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Principle 1</p>
    <h3>Start Simple</h3>
    <p>Single server เหมาะกับ MVP ไม่ใช่ "แพ้" — เพิ่ม complexity เมื่อมี evidence จาก traffic จริง</p>
  </div>
  <div class="card">
    <p class="label">Principle 2</p>
    <h3>Separate Tiers</h3>
    <p>Web + DB แยก tier ตั้งแต่เนิ่น ๆ ทำให้ scale อิสระ — ต้นทุนต่ำ, ผลลัพธ์สูง</p>
  </div>
  <div class="card warning">
    <p class="label">Principle 3</p>
    <h3>Go Stateless</h3>
    <p>Session ใน server memory = ขวาง horizontal scaling — ย้ายออกไปก่อนที่จะ scale</p>
  </div>
  <div class="card gold">
    <p class="label">Building Blocks</p>
    <h3>4 Core Layers</h3>
    <p>Load Balancer + DB Replication + Cache + CDN = infrastructure ที่รองรับ millions of users</p>
  </div>
  <div class="card danger">
    <p class="label">Pitfall</p>
    <h3>New SPOF</h3>
    <p>ทุก layer ใหม่อาจกลายเป็น SPOF ใหม่ — LB ต้องมี HA, Cache ต้องมี fallback</p>
  </div>
  <div class="card success">
    <p class="label">Philosophy</p>
    <h3>Measure First</h3>
    <p>Cache invalidation is hard, replication lag is real — วัดผลจริงก่อน optimize</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> System design = trade-off ที่ตัดสินจาก evidence ไม่ใช่ intuition หรือ trend</div>

<!-- Speaker: EP2 ต่อไป: SQL vs NoSQL — database selection ที่ผิดเป็นหนึ่งใน tech debt ที่แก้ยากที่สุด -->
