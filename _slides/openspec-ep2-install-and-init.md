---
marp: true
theme: default
paginate: true
title: "OpenSpec EP2: ติดตั้งและ Init โปรเจกต์แรก"
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

# OpenSpec EP2: ติดตั้งและ Init โปรเจกต์แรก

<p class="tag">npm install + openspec init = พร้อมใช้งานใน 2 นาที — เจาะลึก OpenSpec สำหรับ Beginners</p>

<!-- Speaker: EP2 walk-through ติดตั้ง OpenSpec และโครงสร้างที่ได้หลัง init -->

---

## ทำไม OpenSpec ติดตั้งง่าย?

<p class="subhead">แค่ CLI + Markdown files ใน repo — ไม่มี server, ไม่มี subscription, ทำงาน offline ได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">ข้อดี 1</p>
    <h3>Zero External Deps</h3>
    <p>ไม่มี server, database, หรือ cloud service — แค่ npm package + markdown files</p>
  </div>
  <div class="card">
    <p class="label">ข้อดี 2</p>
    <h3>Brownfield Ready</h3>
    <p>ใส่ใน codebase ที่มีอยู่แล้วได้ทันที ไม่ต้องเริ่ม project ใหม่</p>
  </div>
  <div class="card warning">
    <p class="label">Prerequisite</p>
    <h3>Node.js 20.19.0+</h3>
    <p>ตรวจสอบด้วย node --version ก่อนติดตั้ง ถ้าต่ำกว่าต้อง upgrade</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prerequisites: Node.js 20.19.0+ เท่านั้น — ไม่มีอะไรอื่น</div>

<!-- Speaker: ความเรียบง่ายนี้คือ design choice ของ OpenSpec -->

---

## โครงสร้างที่ได้หลัง openspec init

<p class="subhead">สามโฟลเดอร์หลัก: specs/ (source of truth), changes/ (features), config.yaml (optional)</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Root folder -->
  <rect x="40" y="130" width="200" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="140" y="166" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">your-project/</text>
  <text x="140" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">openspec/</text>
  <!-- Branch lines -->
  <line x1="245" y1="170" x2="310" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="245" y1="170" x2="310" y2="170" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="245" y1="170" x2="310" y2="260" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- specs/ box -->
  <rect x="315" y="50" width="220" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="425" y="82" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">specs/</text>
  <text x="425" y="104" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Source of Truth</text>
  <text x="425" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">auth/, payments/, api/</text>
  <!-- changes/ box -->
  <rect x="315" y="130" width="220" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="425" y="162" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">changes/</text>
  <text x="425" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">feature folders, archive/</text>
  <!-- config.yaml -->
  <rect x="315" y="230" width="220" height="60" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="425" y="256" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">config.yaml</text>
  <text x="425" y="276" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">optional แต่แนะนำ</text>
  <!-- Changes detail -->
  <line x1="540" y1="170" x2="600" y2="110" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="540" y1="170" x2="600" y2="200" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="605" y="60" width="200" height="100" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="705" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">add-dark-mode/</text>
  <text x="705" y="114" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">proposal.md</text>
  <text x="705" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">specs/ design.md tasks.md</text>
  <rect x="605" y="170" width="200" height="60" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="705" y="198" font-size="13" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">archive/</text>
  <text x="705" y="216" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">completed changes</text>
  <!-- Skill files note -->
  <rect x="850" y="100" width="220" height="140" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="960" y="130" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Skill Files (auto)</text>
  <text x="960" y="152" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">.claude/skills/</text>
  <text x="960" y="170" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">.cursor/skills/</text>
  <text x="960" y="188" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">.windsurf/skills/</text>
  <text x="960" y="210" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">25+ tools supported</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> init สร้าง 3 สิ่ง: specs/, changes/, + skill files สำหรับ AI tool ที่เลือก</div>

<!-- Speaker: skill files คือ Markdown ที่บอก AI ว่า OpenSpec commands ทำอะไร -->

---

## Step-by-Step: ติดตั้ง OpenSpec ใน 4 ขั้นตอน

<p class="subhead">ตั้งแต่ node --version จนถึงทดสอบ /opsx:propose ครั้งแรก</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1 -->
  <rect x="30" y="60" width="220" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="140" cy="40" r="22" fill="var(--accent)"/>
  <text x="140" y="46" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="140" y="92" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ตรวจสอบ Node.js</text>
  <rect x="50" y="108" width="180" height="30" rx="6" fill="var(--ink)" opacity=".9"/>
  <text x="140" y="127" font-size="11" fill="white" text-anchor="middle" font-family="monospace">node --version</text>
  <text x="140" y="160" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต้องได้ v20.19.0+</text>
  <text x="140" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ถ้าต่ำกว่า: nvm install 20</text>
  <!-- Arrow 1 -->
  <line x1="256" y1="150" x2="296" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="296,144 308,150 296,156" fill="var(--accent)"/>
  <!-- Step 2 -->
  <rect x="315" y="60" width="220" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="425" cy="40" r="22" fill="var(--accent)"/>
  <text x="425" y="46" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="425" y="92" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ติดตั้ง OpenSpec</text>
  <rect x="335" y="108" width="180" height="30" rx="6" fill="var(--ink)" opacity=".9"/>
  <text x="425" y="123" font-size="9" fill="white" text-anchor="middle" font-family="monospace">npm install -g</text>
  <text x="425" y="137" font-size="9" fill="white" text-anchor="middle" font-family="monospace">@fission-ai/openspec@latest</text>
  <text x="425" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ตรวจสอบ:</text>
  <text x="425" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="monospace">openspec --version</text>
  <!-- Arrow 2 -->
  <line x1="541" y1="150" x2="581" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="581,144 593,150 581,156" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="600" y="60" width="220" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="710" cy="40" r="22" fill="var(--accent)"/>
  <text x="710" y="46" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="710" y="92" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Init โปรเจกต์</text>
  <rect x="620" y="108" width="180" height="48" rx="6" fill="var(--ink)" opacity=".9"/>
  <text x="710" y="127" font-size="11" fill="white" text-anchor="middle" font-family="monospace">cd your-project</text>
  <text x="710" y="147" font-size="11" fill="white" text-anchor="middle" font-family="monospace">openspec init</text>
  <text x="710" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เลือก profile + AI tool</text>
  <!-- Arrow 3 -->
  <line x1="826" y1="150" x2="866" y2="150" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="866,144 878,150 866,156" fill="var(--accent)"/>
  <!-- Step 4 -->
  <rect x="882" y="60" width="190" height="180" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="977" cy="40" r="22" fill="var(--success)"/>
  <text x="977" y="46" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="977" y="92" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ทดสอบ</text>
  <rect x="900" y="108" width="155" height="30" rx="6" fill="var(--success)" opacity=".8"/>
  <text x="977" y="127" font-size="10" fill="white" text-anchor="middle" font-family="monospace">/opsx:propose test</text>
  <text x="977" y="160" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ถ้า AI สร้าง folder</text>
  <text x="977" y="180" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">= setup ถูกต้อง!</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 4 ขั้นตอน: check node → install → init → test — ใช้เวลาไม่ถึง 2 นาที</div>

<!-- Speaker: ขั้นตอนที่ 3 (init) จะ auto-install skill files สำหรับ AI tool ที่เลือก -->

---

## Core vs Expanded: เลือก Profile ไหน?

<p class="subhead">เริ่มด้วย Core — ครอบคลุม 80% ของ use case; เปิด Expanded เมื่อต้องการ control มากขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Core profile -->
  <rect x="40" y="30" width="480" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2.5"/>
  <rect x="40" y="30" width="480" height="56" rx="14" fill="var(--accent-wash)"/>
  <text x="280" y="65" font-size="17" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Core Profile (Default)</text>
  <text x="80" y="116" font-size="14" fill="var(--ink)" font-family="system-ui">propose</text>
  <text x="80" y="140" font-size="13" fill="var(--muted)" font-family="system-ui">สร้าง artifacts ทั้งหมดพร้อมกัน</text>
  <text x="80" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">explore</text>
  <text x="80" y="194" font-size="13" fill="var(--muted)" font-family="system-ui">brainstorm ก่อน propose</text>
  <text x="80" y="224" font-size="14" fill="var(--ink)" font-family="system-ui">apply / sync / archive</text>
  <text x="80" y="248" font-size="13" fill="var(--muted)" font-family="system-ui">implement, merge specs, เก็บประวัติ</text>
  <text x="280" y="272" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">แนะนำสำหรับ Beginners</text>
  <!-- Arrow -->
  <text x="548" y="165" font-size="18" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+</text>
  <!-- Expanded profile -->
  <rect x="580" y="30" width="480" height="260" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="580" y="30" width="480" height="56" rx="14" fill="var(--soft)"/>
  <text x="820" y="65" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Expanded Workflow</text>
  <text x="620" y="116" font-size="14" fill="var(--ink)" font-family="system-ui">new / continue / ff</text>
  <text x="620" y="140" font-size="13" fill="var(--muted)" font-family="system-ui">artifact-by-artifact control</text>
  <text x="620" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">verify</text>
  <text x="620" y="194" font-size="13" fill="var(--muted)" font-family="system-ui">ตรวจสอบ implementation vs artifacts</text>
  <text x="620" y="224" font-size="14" fill="var(--ink)" font-family="system-ui">bulk-archive / onboard</text>
  <text x="620" y="248" font-size="13" fill="var(--muted)" font-family="system-ui">archive หลายชิ้น, tutorial guided</text>
  <text x="820" y="272" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เปิดด้วย: openspec config profile</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย Core Profile — ถ้า need artifact control มากขึ้น ค่อยเปิด Expanded</div>

<!-- Speaker: ส่วนใหญ่ใช้ Core ตลอด — Expanded สำหรับ feature ใหญ่หรือ team ที่ต้องการ review ทุก artifact -->

---

## Key Takeaways: OpenSpec EP2

<p class="subhead">สิ่งที่ต้องจำจาก EP2 ก่อนไป EP3 (Core Workflow)</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Prerequisite</p>
    <h3>Node.js 20.19.0+</h3>
    <p>ตรวจ version ก่อนเสมอ ถ้าต่ำกว่าต้อง upgrade ก่อนติดตั้ง</p>
  </div>
  <div class="card">
    <p class="label">Install + Init</p>
    <h3>2 คำสั่ง พร้อมใช้</h3>
    <p>npm install -g @fission-ai/openspec@latest แล้ว openspec init ในโปรเจกต์</p>
  </div>
  <div class="card success">
    <p class="label">What You Get</p>
    <h3>specs/ + changes/ + Skills</h3>
    <p>init สร้าง folder structure + install skill files สำหรับ AI tool ที่เลือก</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP3 → walk-through Core Workflow จริง: /opsx:propose → /opsx:apply → /opsx:archive</div>

<!-- Speaker: EP3 จะ demo workflow ครบทั้ง cycle กับตัวอย่าง feature จริง -->
