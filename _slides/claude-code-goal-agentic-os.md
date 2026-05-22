---
marp: true
theme: default
paginate: true
title: "เจาะลึก Goal Feature ใน Claude Code: ก้าวสู่ Agentic OS"
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
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; }
  .img-card img { display:block; width:100%; border-radius:var(--radius-sm); }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# เจาะลึก Goal Feature ใน Claude Code: ก้าวสู่ Agentic OS

<p class="tag">Claude Code 2.1 · /goal command · Agent View · Hermes · Cross-session persistence</p>

<!-- Speaker: ใน 10 slides นี้จะครอบคลุม: /goal คืออะไร, Agentic OS ทำงานอย่างไร, Chief Wiggum 2.0, Hermes integration, และวิธีเปลี่ยน human role -->

---

## AI เปลี่ยนจาก "ผู้ช่วย" สู่ "ผู้รับเหมาอิสระ"

<p class="subhead">Claude Code v2.1.139 (Research Preview, 13 พ.ค. 2026) เปลี่ยนรูปแบบการทำงานพื้นฐาน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Before column -->
  <rect x="40" y="40" width="440" height="260" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="40" width="440" height="52" rx="12" fill="var(--soft-2)"/>
  <text x="260" y="72" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เดิม: Reactive Assistant</text>
  <text x="80" y="124" font-size="14" fill="var(--ink-dim)" font-family="system-ui">พิมพ์คำสั่ง 1</text>
  <text x="80" y="154" font-size="14" fill="var(--ink-dim)" font-family="system-ui">รอผล → ตรวจ → แก้ไข</text>
  <text x="80" y="184" font-size="14" fill="var(--ink-dim)" font-family="system-ui">พิมพ์คำสั่ง 2 (ซ้ำ)</text>
  <text x="80" y="214" font-size="14" fill="var(--muted)" font-family="system-ui">ปิด session = context หาย</text>
  <text x="80" y="244" font-size="14" fill="var(--muted)" font-family="system-ui">มนุษย์ทำทุก decision</text>
  <!-- Arrow -->
  <polygon points="548,170 572,155 572,185" fill="var(--accent)"/>
  <line x1="520" y1="170" x2="572" y2="170" stroke="var(--accent)" stroke-width="3"/>
  <!-- After column -->
  <rect x="620" y="40" width="440" height="260" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="620" y="40" width="440" height="52" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="840" y="72" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ใหม่: Autonomous Contractor</text>
  <text x="660" y="124" font-size="14" fill="var(--ink)" font-family="system-ui">/goal "วางเป้าหมาย"</text>
  <text x="660" y="154" font-size="14" fill="var(--ink)" font-family="system-ui">Claude วิ่งจนบรรลุเป้า (หลายชั่วโมง)</text>
  <text x="660" y="184" font-size="14" fill="var(--ink)" font-family="system-ui">ข้ามเซสชัน — state ไม่หาย</text>
  <text x="660" y="214" font-size="14" fill="var(--ink)" font-family="system-ui">Supervisor ตรวจก่อน handoff</text>
  <text x="660" y="244" font-size="14" fill="var(--ink)" font-family="system-ui">มนุษย์กำกับทิศทางระดับสูง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Everyone else built a construction worker. We built the contractor." — MindStudio</div>

<!-- Speaker: ความต่างหลักคือ model ของ interaction เปลี่ยน จาก turn-by-turn สู่ goal-oriented loop -->

---

## /goal Command: Observe-Act-Observe Loop

<p class="subhead">ไม่ใช่ prompt ยาว — เป็น continuous evaluation loop ที่วนซ้ำจนบรรลุเป้าหมาย</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-goal-agentic-os-1.png" alt="Claude Code /goal command control loop diagram showing Planning, Observe-Act-Observe, and goal completion">
<figcaption>Source: NotebookLM · Mastering the Agent Control Loop</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /goal ทำให้ Claude ถามตัวเองหลังทุก action ว่า "goal บรรลุแล้วหรือยัง?" — ถ้ายัง → วนต่ออัตโนมัติ</div>

<!-- Speaker: 3 phase: Planning (implicit, ไม่แสดง), Observe-Act-Observe loop, Interrupt เฉพาะเมื่อ ambiguous จริงๆ -->

---

## Agentic OS: 4-Layer Architecture แก้ Blank Slate Syndrome

<p class="subhead">โครงสร้างพื้นฐานที่ทำให้ context ไม่หายข้ามเซสชัน</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-goal-agentic-os-2.png" alt="Agentic OS 4-layer architecture: Orchestration, Memory & Logging, Tool Registry, Persistent Context">
<figcaption>Source: NotebookLM · Blueprint of an Agentic OS</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CLAUDE.md = system prompt ถาวร; ~/.claude/tasks/ = state รอดจาก crash; vector DB = memory ข้ามเซสชันระยะยาว</div>

<!-- Speaker: Layer ล่างสุด (CLAUDE.md) คือจุดเริ่มต้นที่ง่ายที่สุด ทุกคนทำได้วันนี้เลย -->

---

## Chief Wiggum 2.0: Framework สำหรับ Multi-Week Goals

<p class="subhead">เมื่อ /goal เดี่ยวๆ ไม่พอ — community methodology จากวิดีโอ (ไม่ใช่ official Anthropic feature)</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step boxes -->
  <rect x="30" y="60" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="60" width="220" height="44" rx="12" fill="var(--accent)" opacity=".12"/>
  <text x="140" y="88" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Define Massive Goal</text>
  <text x="140" y="126" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"Launch 5-day email</text>
  <text x="140" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">course, 500 signups</text>
  <text x="140" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">in 4 weeks"</text>

  <polygon points="258,150 278,140 278,160" fill="var(--accent)"/>
  <line x1="250" y1="150" x2="278" y2="150" stroke="var(--accent)" stroke-width="2"/>

  <rect x="285" y="60" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="285" y="60" width="220" height="44" rx="12" fill="var(--warning)" opacity=".12"/>
  <text x="395" y="88" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">2. Context Gathering</text>
  <text x="395" y="126" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถามบริบท: audience,</text>
  <text x="395" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">assets ที่มี,</text>
  <text x="395" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">constraints ทั้งหมด</text>

  <polygon points="513,150 533,140 533,160" fill="var(--accent)"/>
  <line x1="505" y1="150" x2="533" y2="150" stroke="var(--accent)" stroke-width="2"/>

  <rect x="540" y="60" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="540" y="60" width="220" height="44" rx="12" fill="var(--success)" opacity=".12"/>
  <text x="650" y="88" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">3. Strategy Breakdown</text>
  <text x="650" y="126" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">แบ่งเป็น mini-goals</text>
  <text x="650" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่ actionable พร้อม</text>
  <text x="650" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">timeline ชัดเจน</text>

  <polygon points="768,150 788,140 788,160" fill="var(--accent)"/>
  <line x1="760" y1="150" x2="788" y2="150" stroke="var(--accent)" stroke-width="2"/>

  <rect x="795" y="60" width="275" height="180" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="795" y="60" width="275" height="44" rx="12" fill="var(--gold)" opacity=".15"/>
  <text x="932" y="88" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">4. Real-World Handshakes</text>
  <text x="932" y="120" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI ทำ: code, research, draft</text>
  <text x="932" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Human ทำ: วิดีโอ, โทรขาย</text>
  <text x="932" y="164" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">พร้อม script + time-box</text>
  <text x="932" y="186" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ folder สำหรับ deliverables</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Chief Wiggum 2.0 คือ pattern ที่ AI ถามก่อนสร้าง strategy — ลด misalignment ในโปรเจกต์ระยะยาว</div>

<!-- Speaker: "Real-world handshakes" คือหัวใจ — AI ไม่ทำแทนได้ทุกอย่าง มันจะระบุงานที่ต้องให้มนุษย์ทำพร้อม brief ครบถ้วน -->

---

## Hermes + Agent View: Parallel Execution Platform

<p class="subhead">Claude Code + Hermes Agent ทำงานบน memory เดียวกัน — Agent View เป็น mission control</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Hermes Agent</p>
    <h3>Background Research Engine</h3>
    <p>ทำงานขนานกับ /goal sessions — ใช้ Firecrawl navigate web, อ่าน HTML, ดึง market data โดยไม่ต้องมีคนนั่งดู</p>
    <p>One-to-one memory bridge: อ่าน CLAUDE.md เดียวกัน → shared state ระหว่าง Claude Code + Hermes</p>
  </div>
  <div class="card success">
    <p class="label">Agent View Dashboard</p>
    <h3>Multi-Session Mission Control</h3>
    <p>รวม multiple Claude sessions ในหน้าต่างเดียว แสดง RUNNING / BLOCKED / DONE พร้อม token usage ต่อ agent</p>
    <p>/bg command: background agent ที่รันอยู่ → เปิด session ใหม่ขนานได้ทันที ไม่ต้องรอ goal เดิมเสร็จ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /bg + Agent View ทำให้ parallel engineering workflows จาก terminal เดียว — เหมือนมี dev team ทำงานพร้อมกัน</div>

<!-- Speaker: Multi-session coordination ผ่าน CLAUDE_CODE_TASK_LIST_ID env var — หลาย instances แชร์ task list เดียวกันได้ -->

---

## AI Evolves: Manager-Assistant → Autonomous Contractor

<p class="subhead">การเปลี่ยนแปลงนี้ไม่ใช่ upgrade — เป็น paradigm shift ของ human-AI collaboration</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/claude-code-goal-agentic-os-3.png" alt="Evolution of human-AI collaboration model from manager-assistant to autonomous contractor">
<figcaption>Source: NotebookLM · Evolution of Agentic AI Models</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Human role เปลี่ยนจาก "approve ทุก action" → "วางทิศทาง + รับ handoff งานที่ AI ทำไม่ได้เท่านั้น"</div>

<!-- Speaker: Supervisor architecture ใน v2.1 เพิ่ม second Claude session ที่ audit ก่อน notify — autonomous QA ก่อน handoff กลับมาให้มนุษย์ -->

---

## เขียน /goal ที่ดี: Verifiable + Scoped + Constrained

<p class="subhead">Goal ที่ดีคือ goal ที่ระบบรู้ว่าเสร็จเมื่อไหร่ — vague goal = meandering execution</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Bad goals -->
  <rect x="30" y="30" width="490" height="240" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="30" width="490" height="48" rx="12" fill="var(--danger-wash)"/>
  <text x="275" y="60" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Bad Goals</text>
  <text x="70" y="108" font-size="14" fill="var(--danger)" font-family="system-ui">✗</text>
  <text x="95" y="108" font-size="14" fill="var(--ink-dim)" font-family="system-ui">"make it better"</text>
  <text x="70" y="144" font-size="14" fill="var(--danger)" font-family="system-ui">✗</text>
  <text x="95" y="144" font-size="14" fill="var(--ink-dim)" font-family="system-ui">"refactor everything"</text>
  <text x="70" y="180" font-size="14" fill="var(--danger)" font-family="system-ui">✗</text>
  <text x="95" y="180" font-family="system-ui" font-size="14" fill="var(--ink-dim)">"work on marketing"</text>
  <text x="70" y="218" font-size="14" fill="var(--danger)" font-family="system-ui">✗</text>
  <text x="95" y="218" font-size="14" fill="var(--ink-dim)" font-family="system-ui">ไม่มี success criteria</text>
  <!-- Good goals -->
  <rect x="580" y="30" width="490" height="240" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="580" y="30" width="490" height="48" rx="12" fill="var(--success-wash)"/>
  <text x="825" y="60" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Good Goals</text>
  <text x="620" y="108" font-size="14" fill="var(--success)" font-family="system-ui">✓</text>
  <text x="645" y="108" font-size="14" fill="var(--ink)" font-family="system-ui">"ensure all tests pass"</text>
  <text x="620" y="144" font-size="14" fill="var(--success)" font-family="system-ui">✓</text>
  <text x="645" y="144" font-size="14" fill="var(--ink)" font-family="system-ui">"in /src/services/ only"</text>
  <text x="620" y="180" font-size="14" fill="var(--success)" font-family="system-ui">✓</text>
  <text x="645" y="180" font-size="14" fill="var(--ink)" font-family="system-ui">"get 500 signups in 4 weeks"</text>
  <text x="620" y="218" font-size="14" fill="var(--success)" font-family="system-ui">✓</text>
  <text x="645" y="218" font-size="14" fill="var(--ink)" font-family="system-ui">--tokens 500K --time 2h</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า Claude ไม่รู้ว่า "เสร็จ" หมายถึงอะไร มันจะวนซ้ำหรือเดาเอง — ระบุ verifiable outcome เสมอ</div>

<!-- Speaker: --tokens/--turns/--time คือ safety nets ที่ดี ใช้เสมอสำหรับ goals ที่ไม่แน่ใจ scope -->

---

## Caveats: สิ่งที่ /goal ยังทำไม่ได้

<p class="subhead">v2.1.139 เป็น Research Preview — ใช้ด้วยความเข้าใจขอบเขต</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Context Limit</p>
    <h3>Window ยังมีขอบเขต</h3>
    <p>Codebase ขนาดใหญ่หรือ open-ended research: แบ่งเป็น mini-goals ได้ผลดีกว่า /goal เดี่ยวยาว</p>
  </div>
  <div class="card danger">
    <p class="label">Cost</p>
    <h3>Supervisor = 2x Token</h3>
    <p>Second Claude session audit ก่อน handoff — token cost เพิ่มขึ้น คำนึงถึงใน budget planning</p>
  </div>
  <div class="card gold">
    <p class="label">Ecosystem</p>
    <h3>Hermes + Vector DB = Setup เพิ่ม</h3>
    <p>ไม่ใช่ out-of-the-box: ต้องติดตั้ง Hermes แยก + configure memory bridge + Pinecone/pgvector</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มจาก CLAUDE.md + /goal + budget flags ก่อน — ไม่ต้องครบ stack ทุกชั้นจึงจะได้ประโยชน์</div>

<!-- Speaker: Chief Wiggum 2.0 ก็ไม่ใช่ official feature — community methodology จากวิดีโอ ตรวจสอบกับ official docs เสมอ -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำจาก deck นี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Core Feature</p>
    <h3>/goal = Control Loop</h3>
    <p>Observe-Act-Observe วนซ้ำจนบรรลุเป้า — ต่างจาก long prompt ที่ตอบครั้งเดียว</p>
  </div>
  <div class="card success">
    <p class="label">Architecture</p>
    <h3>Agentic OS 4 Layers</h3>
    <p>CLAUDE.md + task state + vector DB + orchestration แก้ blank slate syndrome</p>
  </div>
  <div class="card gold">
    <p class="label">Paradigm</p>
    <h3>Human = Strategist</h3>
    <p>วางทิศทาง + รับ handoff งาน physical เท่านั้น — AI execute loop ทั้งหมด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มวันนี้: สร้าง CLAUDE.md + ลอง /goal task เล็กๆ + ดู Agent View — paradigm shift เริ่มจากขั้นตอนเดียว</div>

<!-- Speaker: ทั้งหมดนี้ยังเป็น Research Preview — ติดตาม official docs ที่ code.claude.com สำหรับอัปเดตล่าสุด -->
