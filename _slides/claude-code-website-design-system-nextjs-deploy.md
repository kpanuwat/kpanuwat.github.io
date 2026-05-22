---
marp: true
theme: default
paginate: true
title: "สร้างเว็บไซต์ด้วย Claude Code: Design System → Next.js → Deploy ในหลักนาที"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# สร้างเว็บไซต์ด้วย Claude Code

<p class="tag">Design System → Next.js → Spline 3D → Deploy ในหลักนาที</p>

<!-- Speaker: งานเว็บที่เคยใช้เวลาหลายวันตอนนี้ทำได้ในหลักนาที โดยไม่ลด quality -->

---

## Workflow เปลี่ยนทุกอย่าง: หลายวัน → หลักนาที

<p class="subhead">6 ขั้นตอน ปิด Loop Design → Code → Deploy ใน Ecosystem เดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Arrow flow: 6 steps -->
  <!-- Step 1: Claude Design -->
  <rect x="20" y="100" width="150" height="140" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="20" y="100" width="150" height="6" rx="3" fill="var(--accent)"/>
  <text x="95" y="140" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude Design</text>
  <text x="95" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สกัด Design System</text>
  <text x="95" y="180" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Prototype</text>
  <text x="95" y="220" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Handoff Bundle</text>
  <!-- Arrow 1→2 -->
  <path d="M175 170 L205 170" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Step 2: Claude Code -->
  <rect x="210" y="100" width="150" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="210" y="100" width="150" height="6" rx="3" fill="var(--ink-dim)"/>
  <text x="285" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="285" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CLAUDE.md</text>
  <text x="285" y="180" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Brand Voice + Rules</text>
  <!-- Arrow 2→3 -->
  <path d="M365 170 L395 170" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Step 3: Next.js + Tailwind -->
  <rect x="400" y="100" width="150" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="400" y="100" width="150" height="6" rx="3" fill="var(--success)"/>
  <text x="475" y="140" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Next.js 16</text>
  <text x="475" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Tailwind CSS v4</text>
  <text x="475" y="180" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">TypeScript</text>
  <!-- Arrow 3→4 -->
  <path d="M555 170 L585 170" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Step 4: Spline + Higgsfield -->
  <rect x="590" y="100" width="150" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="590" y="100" width="150" height="6" rx="3" fill="var(--warning)"/>
  <text x="665" y="140" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Spline 3D</text>
  <text x="665" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Higgsfield AI</text>
  <text x="665" y="180" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Video</text>
  <!-- Arrow 4→5 -->
  <path d="M745 170 L775 170" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Step 5: GitHub + Vercel -->
  <rect x="780" y="100" width="150" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="780" y="100" width="150" height="6" rx="3" fill="var(--accent-deep)"/>
  <text x="855" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">GitHub</text>
  <text x="855" y="162" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Vercel</text>
  <text x="855" y="180" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Auto-deploy</text>
  <!-- Arrow 5→6 -->
  <path d="M935 170 L965 170" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Step 6: Live -->
  <rect x="970" y="100" width="110" height="140" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.2))"/>
  <rect x="970" y="100" width="110" height="6" rx="3" fill="var(--success)"/>
  <text x="1025" y="145" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Live</text>
  <text x="1025" y="165" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">2-3 min</text>
  <text x="1025" y="185" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">after push</text>
  <!-- Time labels -->
  <text x="550" y="290" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เวลารวม: นาที → ชั่วโมง (แทนที่จะเป็น วัน)</text>
  <!-- Arrow marker -->
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design → Code → Deploy ปิด Loop ใน Ecosystem เดียว — ไม่มี Handoff Gap ระหว่างดีไซเนอร์กับนักพัฒนา</div>

<!-- Speaker: แต่ละขั้นตอนเชื่อมกันอัตโนมัติ Handoff Bundle จาก Claude Design คือกุญแจ -->

---

## Claude Design + Design System: รากฐานที่ทำให้ Brand สม่ำเสมอ

<p class="subhead">Anthropic Labs เปิดตัว 17 เม.ย. 2026 — สกัด Token จาก Codebase/Figma อัตโนมัติ</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-website-design-system-nextjs-deploy-1.png" alt="AI-Powered Product Development Pipeline">
<figcaption>Source: NotebookLM · Claude Design → Handoff Bundle → Claude Code → Next.js/Vercel Pipeline</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Claude Design อ่าน Codebase/Figma แล้ว Output Design Token ที่ Claude Code อ่านได้โดยตรง — ไม่ต้อง Config ซ้ำ</div>

<!-- Speaker: ชี้ที่ Design System extraction stage ใน pipeline -->

---

## CLAUDE.md + .claude Folder: Brain ของ Project

<p class="subhead">กำหนด Brand Voice, Design Tokens, Code Conventions ครั้งเดียว — Claude enforce ทุก Component</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Structure</p>
    <h3>.claude/ Folder</h3>
    <ul>
      <li><b>CLAUDE.md</b> — กฎหลัก Tech stack + Brand</li>
      <li><b>rules/</b> — Brand voice, Design tokens (@import)</li>
      <li><b>skills/</b> — Workflow scripts (component-gen, deploy)</li>
      <li><b>agents/</b> — Subagents เฉพาะ (perf-optimizer)</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Key Benefits</p>
    <h3>ทำไมต้องมี CLAUDE.md</h3>
    <ul>
      <li>Claude ไม่ต้อง "เดา" Tech stack ทุก Session</li>
      <li>Tailwind classes ตรง Design Token เสมอ</li>
      <li>Server vs Client Component ถูกต้องตาม Convention</li>
      <li>Brand Voice คงเดิมทุก Component ที่ Generate</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CLAUDE.md คือ Single Source of Truth — เขียนครั้งเดียว Claude enforce ตลอด Project โดยไม่ต้อง Remind ซ้ำ</div>

<!-- Speaker: ยิ่งละเอียดใน CLAUDE.md ยิ่งลด Review รอบ -->

---

## AI Design Tools 2026: Claude Design vs คู่แข่ง

<p class="subhead">Comparison Matrix — ดูว่า Claude Design เด่นตรงไหน</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-website-design-system-nextjs-deploy-2.png" alt="AI Web Design Tools Comparison Matrix 2026">
<figcaption>Source: NotebookLM · Claude Design vs Figma AI vs v0.dev vs Framer AI — Feature Comparison 2026</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Claude Design ชนะด้าน Design System + Handoff Integration — แลกกับ Ecosystem ที่ยัง Early Preview ณ พ.ค. 2026</div>

<!-- Speaker: จุดแข็งคือ Closed Loop กับ Claude Code ไม่มีคู่แข่งทำได้เหมือน -->

---

## Spline 3D + Higgsfield AI: เพิ่มมิติให้เว็บ

<p class="subhead">Interactive 3D (WebGPU) + Cinematic AI Video สำหรับ Hero Section ระดับ Production</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-website-design-system-nextjs-deploy-3.png" alt="Spline 3D and Higgsfield AI Web Design Workflow">
<figcaption>Source: NotebookLM · Spline 3D (@splinetool/react-spline) + Higgsfield AI Video Integration ใน Next.js</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Spline ใช้ WebGPU (3x เร็วกว่า WebGL) — Lazy-load ด้วย dynamic import ป้องกัน LCP เสีย; Higgsfield เหมาะเป็น Background Layer opacity ต่ำ</div>

<!-- Speaker: ทั้งสองต้องการ Lazy Loading — ไม่งั้น Initial Load หนัก -->

---

## GitHub + Vercel: Deploy อัตโนมัติพร้อม Performance Guard

<p class="subhead">Push → Build → Live ภายใน 2-3 นาที; Claude Code Hook ป้องกัน Bundle เกิน Threshold</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Deploy pipeline -->
  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Stage 1: Local Dev -->
  <rect x="30" y="80" width="170" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="80" width="170" height="6" rx="3" fill="var(--accent)"/>
  <text x="115" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Local Dev</text>
  <text x="115" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude Code edits</text>
  <text x="115" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Performance Guard</text>
  <text x="115" y="176" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Hook: check bundle size</text>
  <text x="115" y="220" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">git push main</text>
  <!-- Arrow 1→2 -->
  <path d="M205 160 L240 160" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <!-- Stage 2: GitHub Actions -->
  <rect x="245" y="80" width="200" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="245" y="80" width="200" height="6" rx="3" fill="var(--ink-dim)"/>
  <text x="345" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">GitHub Actions</text>
  <text x="345" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Marp render</text>
  <text x="345" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Jekyll build</text>
  <text x="345" y="176" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~60 sec</text>
  <!-- Arrow 2→3 -->
  <path d="M450 160 L490 160" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <!-- Stage 3: Vercel -->
  <rect x="495" y="80" width="200" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="495" y="80" width="200" height="6" rx="3" fill="var(--warning)"/>
  <text x="595" y="118" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Vercel Build</text>
  <text x="595" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Auto-infer Static/Dynamic</text>
  <text x="595" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CDN distribution</text>
  <text x="595" y="176" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~90 sec</text>
  <!-- Arrow 3→4 -->
  <path d="M700 160 L740 160" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <!-- Stage 4: Live -->
  <rect x="745" y="60" width="320" height="200" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.2))"/>
  <rect x="745" y="60" width="320" height="6" rx="3" fill="var(--success)"/>
  <text x="905" y="102" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Live on Vercel</text>
  <text x="905" y="128" font-size="13" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">https://my-site.vercel.app</text>
  <text x="905" y="155" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Edge Network: Global CDN</text>
  <text x="905" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Preview URL per PR</text>
  <text x="905" y="238" font-size="22" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">2-3 min total</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Claude Code Hook ใน .claude/settings.json ป้องกัน Deploy ที่ Bundle Size เกิน — QA Gate อัตโนมัติก่อนถึง Production</div>

<!-- Speaker: Performance Budget Guard คือ Safety Net ที่ทีมมักข้ามแต่ควรมี -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำหาก Skip เนื้อหาทั้งหมด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Design Layer</p>
    <h3>Claude Design</h3>
    <p>สกัด Design System อัตโนมัติจาก Codebase/Figma — Handoff Bundle ส่งต่อ Claude Code ได้โดยตรง ไม่มี Gap</p>
  </div>
  <div class="card success">
    <p class="label">Code Layer</p>
    <h3>CLAUDE.md เป็น Brain</h3>
    <p>ใส่ Brand Voice + Design Tokens + Code Conventions ครั้งเดียว Claude enforce ทุก Component ตลอด Project</p>
  </div>
  <div class="card warning">
    <p class="label">Media Layer</p>
    <h3>Spline + Higgsfield</h3>
    <p>Spline 3D ผ่าน WebGPU (3x ใน Mobile) + Higgsfield AI Video สำหรับ Background Hero — ต้อง Lazy Load ทั้งคู่</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Workflow นี้เหมาะมากสำหรับ Solo Founder หรือทีมเล็ก — Output คุณภาพ Agency โดยไม่ต้องมี Full Design Team</div>

<div class="src">Source: Anthropic Labs · Spline.design · Higgsfield.ai · Vercel Docs · 2026</div>

<!-- Speaker: จุดคุ้มค่าสุด: CLAUDE.md ที่ดี ลด Review รอบได้มากที่สุด -->
