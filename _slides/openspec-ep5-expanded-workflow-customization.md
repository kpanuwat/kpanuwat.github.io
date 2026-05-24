---
marp: true
theme: default
paginate: true
title: "OpenSpec EP5: Expanded Workflow + Customization"
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

# OpenSpec EP5: Expanded Workflow + Customization

<p class="tag">config.yaml, Expanded commands, multi-tool — เจาะลึก OpenSpec สำหรับ Beginners</p>

<!-- Speaker: EP5 คือ advanced topics สำหรับ team ที่ต้องการ customize OpenSpec -->

---

## Core vs Expanded: เมื่อไรต้องการ Expanded?

<p class="subhead">Expanded ให้ control artifact ทีละชิ้น — เหมาะกับ feature ใหญ่ที่ต้องการ review ทุก step</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Core -->
  <rect x="40" y="40" width="460" height="220" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="40" y="40" width="460" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="270" y="74" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Core Profile</text>
  <text x="80" y="118" font-size="13" fill="var(--ink)" font-family="system-ui">propose — สร้าง artifacts ทั้งหมดพร้อมกัน</text>
  <text x="80" y="146" font-size="13" fill="var(--ink)" font-family="system-ui">apply / sync / archive</text>
  <text x="80" y="180" font-size="12" fill="var(--success)" font-family="system-ui">เหมาะกับ: feature ขนาดกลาง-เล็ก</text>
  <text x="80" y="200" font-size="12" fill="var(--success)" font-family="system-ui">requirement ชัดเจน, team เดียว</text>
  <text x="270" y="238" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">80% ของ use case</text>
  <!-- VS -->
  <text x="548" y="162" font-size="20" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+</text>
  <!-- Expanded -->
  <rect x="600" y="40" width="460" height="220" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="600" y="40" width="460" height="52" rx="14" fill="var(--soft)"/>
  <text x="830" y="74" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Expanded Workflow</text>
  <text x="640" y="118" font-size="13" fill="var(--ink)" font-family="system-ui">new + continue / ff — artifact ทีละชิ้น</text>
  <text x="640" y="146" font-size="13" fill="var(--ink)" font-family="system-ui">verify — check implementation vs artifacts</text>
  <text x="640" y="174" font-size="13" fill="var(--ink)" font-family="system-ui">bulk-archive, onboard</text>
  <text x="640" y="208" font-size="12" fill="var(--warning-ink)" font-family="system-ui">เหมาะกับ: feature ใหญ่, cross-team,</text>
  <text x="640" y="228" font-size="12" fill="var(--warning-ink)" font-family="system-ui">หรือต้องการ review ทุก artifact</text>
  <text x="830" y="248" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เปิดด้วย: openspec config profile</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย Core ก่อนเสมอ — เปิด Expanded เมื่อ Core ไม่พอสำหรับ feature นั้น</div>

<!-- Speaker: Expanded ไม่ได้ดีกว่า Core เสมอ — ขึ้นอยู่กับ complexity ของ feature -->

---

## config.yaml: การลงทุนที่คุ้มค่าที่สุด

<p class="subhead">Inject tech stack context ให้ AI สร้าง artifacts ที่ specific กับ project — ไม่ต้อง repeat ทุกครั้ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Without config -->
  <rect x="40" y="30" width="460" height="250" rx="14" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="40" y="30" width="460" height="52" rx="14" fill="var(--danger-wash)"/>
  <text x="270" y="64" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี config.yaml</text>
  <text x="80" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">proposal.md ที่ AI สร้าง:</text>
  <text x="80" y="134" font-size="12" fill="var(--ink-dim)" font-family="system-ui">"Add authentication..." (generic)</text>
  <text x="80" y="162" font-size="12" fill="var(--muted)" font-family="system-ui">ไม่รู้ว่าใช้ Clerk</text>
  <text x="80" y="182" font-size="12" fill="var(--muted)" font-family="system-ui">ไม่รู้ว่า test ด้วย Vitest</text>
  <text x="80" y="202" font-size="12" fill="var(--muted)" font-family="system-ui">ไม่รู้ว่า state management คือ Zustand</text>
  <text x="270" y="252" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">artifacts generic ทุกครั้ง</text>
  <!-- Arrow -->
  <line x1="510" y1="155" x2="558" y2="155" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="558,149 570,155 558,161" fill="var(--accent)"/>
  <rect x="480" y="106" width="100" height="100" rx="8" fill="var(--accent)" opacity=".08"/>
  <text x="530" y="150" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">+ config</text>
  <text x="530" y="168" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">.yaml</text>
  <!-- With config -->
  <rect x="580" y="30" width="480" height="250" rx="14" fill="var(--paper)" stroke="var(--success)" stroke-width="2.5"/>
  <rect x="580" y="30" width="480" height="52" rx="14" fill="var(--success-wash)"/>
  <text x="820" y="64" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">มี config.yaml</text>
  <text x="620" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">proposal.md ที่ AI สร้าง:</text>
  <text x="620" y="134" font-size="12" fill="var(--ink-dim)" font-family="system-ui">"Use Clerk for auth,</text>
  <text x="620" y="154" font-size="12" fill="var(--ink-dim)" font-family="system-ui"> store session in Zustand..."</text>
  <text x="620" y="182" font-size="12" fill="var(--success)" font-family="system-ui">tasks.md include: "write Vitest tests"</text>
  <text x="620" y="202" font-size="12" fill="var(--success)" font-family="system-ui">design.md reference existing patterns</text>
  <text x="820" y="252" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">artifacts specific ทุกครั้ง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> config.yaml = ลงทุนครั้งเดียว ได้ artifacts ที่ specific กับ project ทุก propose</div>

<!-- Speaker: context ใน config inject ทุก artifact — proposal, specs, design, tasks ทั้งหมด -->

---

## /opsx:verify: Sanity Check ก่อน PR

<p class="subhead">verify อ่าน tasks.md แล้ว scan codebase ว่า implement ครบหรือเปล่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- verify flow -->
  <rect x="40" y="90" width="200" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="140" y="145" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/opsx:apply</text>
  <text x="140" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">tasks complete</text>
  <!-- Arrow -->
  <line x1="245" y1="150" x2="295" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="295,144 307,150 295,156" fill="var(--accent)"/>
  <!-- verify box -->
  <rect x="310" y="60" width="200" height="180" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="410" y="95" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">/opsx:verify</text>
  <text x="410" y="120" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">reads tasks.md</text>
  <text x="410" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">scans codebase</text>
  <text x="410" y="164" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">checks each task</text>
  <!-- Results -->
  <line x1="516" y1="120" x2="560" y2="90" stroke="var(--success)" stroke-width="1.5"/>
  <line x1="516" y1="180" x2="560" y2="210" stroke="var(--danger)" stroke-width="1.5"/>
  <!-- Pass box -->
  <rect x="566" y="50" width="260" height="100" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="696" y="90" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">All tasks complete</text>
  <text x="696" y="112" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Ready for sync + archive</text>
  <text x="696" y="132" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">PR review confidence high</text>
  <!-- Fail box -->
  <rect x="566" y="170" width="260" height="100" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="696" y="210" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Tasks incomplete</text>
  <text x="696" y="232" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">3.2 localStorage missing</text>
  <text x="696" y="252" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Run /opsx:apply to finish</text>
  <!-- Arrow to sync -->
  <line x1="832" y1="100" x2="890" y2="140" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="895" y="110" width="175" height="60" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="982" y="145" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">sync + archive</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /opsx:verify ก่อน PR review เสมอ — ตรวจสอบ implementation ตรง tasks ไหม</div>

<!-- Speaker: verify ใช้ได้เฉพาะใน Expanded Workflow — ต้อง enable ก่อน -->

---

## Key Takeaways: OpenSpec Series จบแล้ว!

<p class="subhead">สิ่งที่ต้องจำตลอดทั้ง 5 EPs</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">EP1-2: Foundation</p>
    <h3>SDD + Install</h3>
    <p>OpenSpec แก้ vibe coding ด้วย spec ก่อน code; ติดตั้งใน 2 นาทีด้วย npm</p>
  </div>
  <div class="card warning">
    <p class="label">EP3-4: Core Skills</p>
    <h3>Workflow + Artifacts</h3>
    <p>propose → review → apply → sync → archive; tasks.md สำคัญที่สุด review ให้ดี</p>
  </div>
  <div class="card success">
    <p class="label">EP5: Scale Up</p>
    <h3>Config + Expanded</h3>
    <p>config.yaml inject context ให้ AI; Expanded เมื่อต้องการ artifact-by-artifact control</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย Core Profile + config.yaml — นั่นคือ 90% ของที่ต้องรู้เพื่อใช้ OpenSpec อย่างมีประสิทธิภาพ</div>

<!-- Speaker: OpenSpec มีแค่นี้ — สิ่งที่ยากคือ discipline ในการเขียน artifacts ที่ดีสม่ำเสมอ -->
