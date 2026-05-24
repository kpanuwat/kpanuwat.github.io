---
marp: true
theme: default
paginate: true
title: "OpenSpec EP3: Core Workflow"
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

# OpenSpec EP3: Core Workflow

<p class="tag">/opsx:propose → /opsx:apply → /opsx:archive — เจาะลึก OpenSpec สำหรับ Beginners</p>

<!-- Speaker: EP3 walk-through Core Workflow ครบทั้ง cycle กับ feature จริง -->

---

## 4 Commands ที่ต้องรู้ใน Core Profile

<p class="subhead">Commands เป็น "actions" ไม่ใช่ "phases" — ทำได้ยืดหยุ่นตามที่ต้องการ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Command 1</p>
    <h3>/opsx:explore</h3>
    <p>Brainstorm ก่อน propose — ไม่สร้าง artifact ใช้เมื่อ requirement ยังไม่ชัด</p>
  </div>
  <div class="card">
    <p class="label">Command 2</p>
    <h3>/opsx:propose</h3>
    <p>สร้าง artifacts ทั้งหมดพร้อมกัน: proposal, specs, design, tasks</p>
  </div>
  <div class="card success">
    <p class="label">Command 3</p>
    <h3>/opsx:apply</h3>
    <p>AI implement tasks จาก tasks.md ทีละ item ตาม artifacts ที่ review แล้ว</p>
  </div>
  <div class="card warning">
    <p class="label">Command 4</p>
    <h3>/opsx:sync + archive</h3>
    <p>sync: merge delta specs; archive: เก็บ change folder เป็น history</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Core flow: explore (optional) → propose → review → apply → sync → archive</div>

<!-- Speaker: review artifacts ระหว่าง propose และ apply คือขั้นตอนที่สำคัญที่สุด -->

---

## Workflow จริง: Add Dark Mode Feature

<p class="subhead">ตัวอย่าง end-to-end ตั้งแต่ propose จนถึง archive</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1: propose -->
  <rect x="20" y="60" width="190" height="180" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="115" y="92" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">/opsx:propose</text>
  <text x="115" y="112" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">add-dark-mode</text>
  <text x="115" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI creates:</text>
  <text x="115" y="160" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">proposal.md</text>
  <text x="115" y="178" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/ design.md</text>
  <text x="115" y="196" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">tasks.md</text>
  <text x="115" y="220" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~2 min</text>
  <!-- Arrow + Review -->
  <line x1="216" y1="150" x2="250" y2="150" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="250,144 262,150 250,156" fill="var(--muted)"/>
  <rect x="265" y="100" width="120" height="100" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="325" y="136" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Review</text>
  <text x="325" y="156" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Artifacts</text>
  <text x="325" y="174" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แก้ถ้าจำเป็น</text>
  <!-- Arrow -->
  <line x1="390" y1="150" x2="424" y2="150" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="424,144 436,150 424,156" fill="var(--muted)"/>
  <!-- Step 3: apply -->
  <rect x="440" y="60" width="190" height="180" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="535" y="92" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/opsx:apply</text>
  <text x="535" y="118" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Working through tasks...</text>
  <text x="535" y="142" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">1.1 Add ThemeContext</text>
  <text x="535" y="162" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">1.2 Create Toggle</text>
  <text x="535" y="182" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">2.1 Add CSS variables</text>
  <text x="535" y="200" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">2.2 localStorage persist</text>
  <text x="535" y="222" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">All tasks complete!</text>
  <!-- Arrow + test -->
  <line x1="636" y1="150" x2="670" y2="150" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="670,144 682,150 670,156" fill="var(--muted)"/>
  <rect x="686" y="100" width="110" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="741" y="138" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Test</text>
  <text x="741" y="158" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">npm test</text>
  <text x="741" y="176" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ปกติ</text>
  <!-- Arrow -->
  <line x1="800" y1="150" x2="834" y2="150" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="834,144 846,150 834,156" fill="var(--muted)"/>
  <!-- Step 5: sync + archive -->
  <rect x="850" y="60" width="220" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="960" y="92" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">sync + archive</text>
  <text x="960" y="116" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Merge delta specs</text>
  <text x="960" y="134" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">into openspec/specs/</text>
  <text x="960" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Archive change folder</text>
  <text x="960" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">to changes/archive/</text>
  <text x="960" y="216" font-size="11" fill="var(--success)" font-weight="700" text-anchor="middle" font-family="system-ui">Done!</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Review artifacts ก่อน apply เสมอ — propose สร้าง draft; คุณ finalize</div>

<!-- Speaker: ขั้นตอน review ระหว่าง propose และ apply คือที่ที่ developer ใส่ domain knowledge -->

---

## /opsx:explore: ใช้เมื่อไร?

<p class="subhead">Explore ก่อน propose เมื่อ requirement ยังไม่ชัด — AI วิเคราะห์ codebase ช่วยตัดสินใจ</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: when to use -->
  <rect x="40" y="30" width="440" height="240" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="260" y="64" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ใช้ explore เมื่อ...</text>
  <text x="80" y="104" font-size="14" fill="var(--ink)" font-family="system-ui">ยังไม่รู้จะ propose อะไร</text>
  <text x="80" y="128" font-size="13" fill="var(--muted)" font-family="system-ui">requirement ยังฟุ้ง</text>
  <text x="80" y="160" font-size="14" fill="var(--ink)" font-family="system-ui">อยากให้ AI วิเคราะห์ก่อน</text>
  <text x="80" y="184" font-size="13" fill="var(--muted)" font-family="system-ui">สแกน codebase หา patterns</text>
  <text x="80" y="216" font-size="14" fill="var(--ink)" font-family="system-ui">อยากเปรียบเทียบ approaches</text>
  <text x="80" y="240" font-size="13" fill="var(--muted)" font-family="system-ui">JWT vs session-based, หลาย options</text>
  <!-- Arrow -->
  <line x1="490" y1="150" x2="540" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="540,144 552,150 540,156" fill="var(--accent)"/>
  <!-- Right: explore result -->
  <rect x="558" y="30" width="502" height="240" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="809" y="64" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">explore ทำอะไร?</text>
  <text x="598" y="100" font-size="14" fill="var(--ink)" font-family="system-ui">วิเคราะห์ codebase ปัจจุบัน</text>
  <text x="598" y="120" font-size="13" fill="var(--ink-dim)" font-family="system-ui">อ่าน files, หา patterns, เข้าใจ context</text>
  <text x="598" y="154" font-size="14" fill="var(--ink)" font-family="system-ui">เปรียบเทียบ options</text>
  <text x="598" y="174" font-size="13" fill="var(--ink-dim)" font-family="system-ui">บอก tradeoffs, recommend approach</text>
  <text x="598" y="208" font-size="14" fill="var(--ink)" font-family="system-ui">ไม่สร้าง artifacts</text>
  <text x="598" y="228" font-size="13" fill="var(--ink-dim)" font-family="system-ui">แค่ "คิดด้วยกัน" ก่อน commit ไป propose</text>
  <text x="598" y="252" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">จบด้วย: /opsx:propose เมื่อพร้อม</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> explore = ฟรี ไม่มี side effects; ใช้เมื่อ requirement ฟุ้ง ก่อนค่อย propose</div>

<!-- Speaker: explore ไม่บังคับ — ถ้า requirement ชัดแล้ว propose เลย -->

---

## Checkpoints ที่สำคัญใน Core Workflow

<p class="subhead">จุดที่ developer ต้องตรวจสอบ — OpenSpec ไม่ใช่ autopilot 100%</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Checkpoint 1</p>
    <h3>หลัง Propose</h3>
    <p>Review proposal.md (scope), tasks.md (ครบไหม), design.md (ตรง convention ไหม) — แก้ก่อน apply</p>
  </div>
  <div class="card">
    <p class="label">Checkpoint 2</p>
    <h3>หลัง Apply</h3>
    <p>Run tests ปกติ — OpenSpec ไม่แทนที่ testing; verify code quality เหมือนเดิม</p>
  </div>
  <div class="card success">
    <p class="label">Checkpoint 3</p>
    <h3>ก่อน Archive</h3>
    <p>ต้อง sync ก่อนเสมอ — ถ้า archive โดยไม่ sync, delta specs จะหายไม่ merge เข้า main</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> sync ก่อน archive เสมอ — ลำดับนี้สำคัญมาก ห้ามข้าม</div>

<!-- Speaker: Developer ยังต้อง review artifacts และ run tests — SDD ลด drift ไม่ใช่ eliminate judgment -->

---

## Key Takeaways: OpenSpec EP3

<p class="subhead">สิ่งที่ต้องจำจาก EP3 ก่อนไป EP4 (Artifacts Deep Dive)</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Core Flow</p>
    <h3>propose → review → apply → sync → archive</h3>
    <p>explore เป็น optional ก่อน propose; ทำทุกขั้นตอน ไม่ข้าม sync</p>
  </div>
  <div class="card warning">
    <p class="label">Critical Rule</p>
    <h3>Review artifacts ก่อน apply เสมอ</h3>
    <p>propose สร้าง draft — developer finalize; garbage in artifacts = garbage out code</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP4 → เจาะลึก artifacts แต่ละชิ้น: เขียนยังไงให้ AI implement ได้ดี</div>

<!-- Speaker: EP4 คือ deep dive ว่า artifacts แต่ละชิ้นมีหน้าที่อะไร และเขียนยังไงให้ดี -->
