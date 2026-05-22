---
marp: true
theme: default
paginate: true
title: "Key Tasks ใน Product Development (SI) แบบ Lean: ตั้งแต่ Idea ถึง Commercial"
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

# Key Tasks ใน Product Development (SI) แบบ Lean

<p class="tag">ตั้งแต่ Idea ถึง Commercial — 10 phases, 4 disciplines</p>

<!-- Speaker: PM/team task-focused deep-dive of the HW-bearing SI product development lifecycle. What to DO at each gate. -->

---

## Product Dev ใน SI คือ Chain of Decision Gates

<p class="subhead">แต่ละ phase มี 2–4 task หลักที่ต้องทำให้สมบูรณ์ก่อน unblock phase ถัดไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="1020" height="76" rx="10" fill="var(--accent-wash)"/>
  <rect x="40" y="20" width="6" height="76" rx="3" fill="var(--accent)"/>
  <circle cx="84" cy="58" r="20" fill="var(--accent)"/>
  <text x="84" y="63" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">1</text>
  <text x="118" y="50" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">10 Phases — Each Gate Has Clear Exit Criteria</text>
  <text x="118" y="72" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ไม่มี gate ที่ skip ได้โดยไม่มี consequence — ทุก phase ที่ข้าม = technical debt ที่จ่ายทีหลัง</text>
  <rect x="40" y="110" width="1020" height="76" rx="10" fill="var(--soft)"/>
  <rect x="40" y="110" width="6" height="76" rx="3" fill="var(--gold)"/>
  <circle cx="84" cy="148" r="20" fill="var(--gold)"/>
  <text x="84" y="153" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">2</text>
  <text x="118" y="140" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">PO = Official Kick-off</text>
  <text x="118" y="162" font-size="13" fill="var(--ink-dim)" font-family="system-ui">All pre-PO work is investment — may not recover if deal falls through. Write lean, align early.</text>
  <rect x="40" y="200" width="1020" height="76" rx="10" fill="var(--soft)"/>
  <rect x="40" y="200" width="6" height="76" rx="3" fill="var(--success)"/>
  <circle cx="84" cy="238" r="20" fill="var(--success)"/>
  <text x="84" y="243" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">3</text>
  <text x="118" y="230" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">4 Cross-cutting Disciplines Thread Every Phase</text>
  <text x="118" y="252" font-size="13" fill="var(--ink-dim)" font-family="system-ui">BOM maturity · supply risk · cross-discipline sync · change control — neglect any = cascade failure</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Tasks = verbs; gates = checkpoints; disciplines = habits — all three must coexist to ship on time and invoice on schedule.</div>

<!-- Speaker: This deck is about what the team DOES (tasks), not what they WRITE (documents). Complementary to the lean-doc-set post. -->

---

## SI + Custom HW บังคับคิดเป็น Dependency Graph

<p class="subhead">ไม่ใช่ to-do list — FW blocked until HW stable; SCM blocked until eBOM frozen</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="470" height="250" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="30" width="470" height="48" rx="12" fill="var(--soft-2)"/>
  <text x="275" y="59" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Pure Software SI</text>
  <text x="65" y="107" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- Control full codebase and deploy</text>
  <text x="65" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- Rollback in minutes if needed</text>
  <text x="65" y="163" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- Timeline = dev effort only</text>
  <text x="65" y="191" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- Dependencies: SW modules only</text>
  <text x="65" y="219" font-size="13" fill="var(--muted)" font-family="system-ui">- No procurement; no regulatory cert</text>
  <text x="65" y="247" font-size="13" fill="var(--muted)" font-family="system-ui">- PM manages sprints</text>
  <rect x="590" y="30" width="470" height="250" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="30" width="470" height="48" rx="12" fill="var(--accent)" opacity=".12"/>
  <text x="825" y="59" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SI with Custom HW</text>
  <text x="615" y="107" font-size="13" fill="var(--ink)" font-family="system-ui">- HW + FW + SW must sync in sequence</text>
  <text x="615" y="135" font-size="13" fill="var(--ink)" font-family="system-ui">- Board respin = weeks of delay</text>
  <text x="615" y="163" font-size="13" fill="var(--ink)" font-family="system-ui">- Component lead-time: 16–20 weeks</text>
  <text x="615" y="191" font-size="13" fill="var(--ink)" font-family="system-ui">- HW -&gt; FW -&gt; SW cascade dependency</text>
  <text x="615" y="219" font-size="13" fill="var(--ink)" font-family="system-ui">- Regulatory cert: 4–12 wks lead-time</text>
  <text x="615" y="247" font-size="13" fill="var(--ink)" font-family="system-ui">- PM manages dependency graph</text>
  <circle cx="550" cy="155" r="30" fill="var(--accent)"/>
  <text x="550" y="160" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">vs</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FW ยัง validate ไม่ได้จนกว่า HW DVT board จะ stable; SW ยัง integrate ไม่ได้จนกว่า FW API จะ lock — นี่คือ cascade ที่ PM ต้อง manage proactively.</div>

<!-- Speaker: Core message: SI with HW is a different class of PM challenge. The dependency cascade is the hardest part. -->

---

## 10-Phase Lifecycle: ทุก Phase คือ Decision Gate

<p class="subhead">Build phases 1–5 (blue) → Deploy &amp; sustain phases 6–10 (green)</p>

<div class="infographic">
<svg viewBox="0 0 1100 350" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--muted)"/>
    </marker>
  </defs>
  <circle cx="90" cy="105" r="38" fill="var(--accent)"/>
  <circle cx="280" cy="105" r="38" fill="var(--accent)"/>
  <circle cx="470" cy="105" r="38" fill="var(--accent)"/>
  <circle cx="660" cy="105" r="38" fill="var(--accent)"/>
  <circle cx="850" cy="105" r="38" fill="var(--accent)"/>
  <circle cx="90" cy="265" r="38" fill="var(--success)"/>
  <circle cx="280" cy="265" r="38" fill="var(--success)"/>
  <circle cx="470" cy="265" r="38" fill="var(--success)"/>
  <circle cx="660" cy="265" r="38" fill="var(--success)"/>
  <circle cx="850" cy="265" r="38" fill="var(--success)"/>
  <text x="90" y="111" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="280" y="111" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="470" y="111" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="660" y="111" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="850" y="111" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">5</text>
  <text x="90" y="271" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">6</text>
  <text x="280" y="271" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">7</text>
  <text x="470" y="271" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">8</text>
  <text x="660" y="271" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">9</text>
  <text x="850" y="271" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">10</text>
  <text x="90" y="156" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Idea</text>
  <text x="280" y="156" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Pre-sales</text>
  <text x="470" y="156" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Kick-off</text>
  <text x="660" y="156" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Design</text>
  <text x="850" y="156" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Prototype</text>
  <text x="90" y="316" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Pilot</text>
  <text x="280" y="316" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Qual/Cert</text>
  <text x="470" y="316" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Mass Prod</text>
  <text x="660" y="316" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">SAT/UAT</text>
  <text x="850" y="316" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Handover</text>
  <line x1="130" y1="105" x2="238" y2="105" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="320" y1="105" x2="428" y2="105" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="510" y1="105" x2="618" y2="105" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="700" y1="105" x2="808" y2="105" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="130" y1="265" x2="238" y2="265" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="320" y1="265" x2="428" y2="265" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="510" y1="265" x2="618" y2="265" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <line x1="700" y1="265" x2="808" y2="265" stroke="var(--muted)" stroke-width="2" marker-end="url(#a)"/>
  <path d="M850,143 C850,215 90,185 90,226" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#a)"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Phases 1–5 build the product; phases 6–10 deliver and sustain it. The pilot-to-qualification bridge (5→6) is where most schedule risk accumulates.</div>

<!-- Speaker: Each numbered circle is a gate. Blue = build. Green = deploy/sustain. -->

---

## Phase 1–2: Idea → Pre-sales → PO

<p class="subhead">PO คือ official kick-off — ทุกอย่างก่อนนั้นคือ investment ที่ยังไม่รับประกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Phase 1 — Idea / Discovery</p>
    <h3>ยืนยันว่า "ปัญหาจริง แก้ได้ คุ้มทุน"</h3>
    <ul>
      <li><b>Problem Statement</b> — define &amp; validate the problem (1 page)</li>
      <li><b>PRD Lite</b> — user story + acceptance criteria + MVP scope (1–2 pages, no wireframe)</li>
      <li><b>Feasibility triple</b> — Technical / Cost / Supply constraint assessment</li>
    </ul>
    <p>Gate exit: Go/No-Go decision with documented assumptions</p>
  </div>
  <div class="card gold">
    <p class="label">Phase 2 — Pre-sales</p>
    <h3>ลูกค้า approve proposal + ออก PO</h3>
    <ul>
      <li><b>Solution Proposal</b> — architecture fit + approach</li>
      <li><b>Budgetary BOM</b> — estimated cost + lead time per component</li>
      <li><b>SOW</b> — deliverable (measurable), exclusion, customer responsibility</li>
      <li><b>Risk/Assumption Log</b> — both parties acknowledge risk before PO</li>
    </ul>
    <p>Gate exit: PO received = official kick-off</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Supply constraint ใน Feasibility triple คือ gate ที่หลายทีมมองข้ามแล้วไปสะดุดใน Prototype phase — component lead-time 16–20 สัปดาห์ต้องรู้ตั้งแต่ Idea.</div>

<!-- Speaker: PRD Lite is not a full PRD — no wireframes, no backlog. Just enough to align on "done" before winning the deal. -->

---

## Phase 3–4: Kick-off + Design → eBOM Freeze

<p class="subhead">ผูก milestone กับ invoice ตั้งแต่ Day 1 — eBOM freeze unblocks SCM procurement</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Phase 3 — Kick-off &amp; Project Setup</p>
    <h3>แปลง commercial agreement เป็น execution plan</h3>
    <ul>
      <li><b>Project Charter</b> — scope, RACI, budget, escalation path</li>
      <li><b>Master Plan</b> — phase-gate dates + dependencies</li>
      <li><b>Milestone ↔ Invoice binding</b> — Design Freeze=20%, SAT=40%, Go-live=30%, Support=10%</li>
      <li><b>Config/DevOps env</b> — repo, CI/CD, staging ready Day 1</li>
    </ul>
    <p>Gate exit: Sponsor + customer sign-off on charter</p>
  </div>
  <div class="card">
    <p class="label">Phase 4 — Design</p>
    <h3>ออกแบบจนพร้อม build prototype + freeze eBOM</h3>
    <ul>
      <li><b>System Architecture</b> — architecture diagram + interface spec</li>
      <li><b>Detailed Design</b> — HW (schematic/PCB), FW (spec/modules), SW (arch/API)</li>
      <li><b>PDR</b> — direction review: architecture correct, interfaces clear</li>
      <li><b>CDR</b> — build review: design detail complete enough to build</li>
      <li><b>eBOM freeze</b> — SCM สามารถสั่ง long-lead component ได้</li>
    </ul>
    <p>Gate exit: CDR passed + eBOM v1.0 signed off</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design Freeze slip 2 สัปดาห์ = invoice milestone 20% ช้า 2 สัปดาห์ = cashflow กระทบ — PM ต้องรู้ว่า every design decision มี financial consequence.</div>

<!-- Speaker: Milestone-invoice binding is what makes SI PM different from software PM. Cashflow management is part of the job. -->

---

## Phase 5: EVT / DVT / PVT — 3 Validation Gates

<p class="subhead">Validate design AND manufacturing process ผ่าน 3 checkpoint ก่อน mass production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">EVT — Engineering Validation Test</p>
    <h3>Core functionality, critical flaws</h3>
    <p><b>Units:</b> Hand-assembled, ~5–10 units</p>
    <p><b>Focus:</b> ฟังก์ชันหลักทำงาน, identify critical design flaws</p>
    <p><b>Gate exit:</b> Critical bugs identified + root-caused</p>
    <p><b>SCM task:</b> Long-lead parts must be ordered at eBOM freeze — 16–20 wk lead-time cannot wait</p>
  </div>
  <div class="card warning">
    <p class="label">DVT — Design Validation Test</p>
    <h3>Reliability, regulatory compliance</h3>
    <p><b>Units:</b> Production-equivalent parts, ~20–50 units</p>
    <p><b>Focus:</b> Environmental stress, FCC/CE/regulatory compliance</p>
    <p><b>Gate exit:</b> Regulatory pass + stress test pass</p>
    <p><b>Note:</b> FW cannot final-validate until DVT board is stable — HW respin delays FW timeline</p>
  </div>
  <div class="card success">
    <p class="label">PVT — Production Validation Test</p>
    <h3>Manufacturing process, yield</h3>
    <p><b>Units:</b> Pilot production run, ~50–200 units</p>
    <p><b>Focus:</b> Assembly line, yield rate target</p>
    <p><b>Gate exit:</b> Yield &gt;= 95%, assembly SOP documented</p>
    <p><b>BOM:</b> eBOM locks at EVT; strictly finalizes at PVT as pBOM</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก design change ระหว่าง EVT→PVT ต้องผ่าน ECR review → ECO issued → BOM version incremented — ไม่มี "แก้เงียบๆ" หลัง baseline.</div>

<!-- Speaker: EVT/DVT/PVT is systematic risk reduction. Finding defects in the lab is 10x cheaper than finding them at the customer site. -->

---

## Phase 6–8: Pilot → Qual/Cert → Mass Production

<p class="subhead">Pilot validates real world; qualification validates standards; mass prod scales delivery</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Phase 6 — Pilot Deployment</p>
    <h3>ทดสอบ real world ก่อน mass rollout</h3>
    <ul>
      <li>Deploy ที่ 1–3 sites จริง</li>
      <li>Collect field feedback (defect log)</li>
      <li>Design iteration via ECO/ECR</li>
      <li>1–2 respins = healthy baseline</li>
    </ul>
    <p><b>Red flag:</b> &gt;3 respins = insufficient EVT/DVT or scope creep</p>
  </div>
  <div class="card warning">
    <p class="label">Phase 7 — Qualification &amp; Cert</p>
    <h3>ผ่านมาตรฐาน + harden pBOM</h3>
    <ul>
      <li>Regulatory cert: FCC, CE, UL, local</li>
      <li>DFM review — lowers mfg cost 15–20%</li>
      <li>DFT review — lowers field failure ~50%</li>
      <li>BOM hardening → pBOM</li>
    </ul>
    <p><b>Timing:</b> Start cert application before DVT completes — 4–12 wk lab queue</p>
  </div>
  <div class="card success">
    <p class="label">Phase 8 — Mass Production &amp; Logistics</p>
    <h3>Scale production + deliver to site</h3>
    <ul>
      <li>Production transfer: SOP + pBOM released</li>
      <li>SCM procurement for production run</li>
      <li>Logistics + packing + field installation</li>
    </ul>
    <p><b>Invoice risk:</b> Logistics delay = payment milestone delay = cashflow impact</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cert lead-time เริ่มนับตั้งแต่ lab queue — ถ้ารอให้ DVT complete แล้วค่อยยื่น cert อาจ delay mass production 8–12 สัปดาห์ได้.</div>

<!-- Speaker: Pilot exposes what lab testing misses: EMI at real site, unstable network, user workflow gaps. Budget 1-2 respins. -->

---

## Phase 9–10: Acceptance → Commercial Handover

<p class="subhead">SAT/UAT sign-off = invoice trigger — define criteria at pre-sales, not at acceptance</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Phase 9 — Acceptance (SAT / UAT)</p>
    <h3>รับ formal sign-off ที่ผูกกับ milestone การเงิน</h3>
    <ul>
      <li><b>SAT</b> — site testing: system integrates with SCADA/ERP/network at actual site</li>
      <li><b>UAT</b> — user testing: operator confirms workflow matches PRD Lite + SOW use cases</li>
      <li><b>Punch list</b> — resolve all critical issues before sign-off</li>
      <li><b>Acceptance sign-off</b> = invoice trigger (typically 40% payment)</li>
    </ul>
    <p><b>Key:</b> Acceptance criteria must be agreed at pre-sales — not negotiated at sign-off time</p>
  </div>
  <div class="card">
    <p class="label">Phase 10 — Commercial Handover &amp; MA/SLA</p>
    <h3>ปิด project + เข้าสู่ maintenance mode</h3>
    <ul>
      <li><b>Final invoice</b> — remaining balance</li>
      <li><b>As-built bundle</b> — as-built drawings + pBOM + config files + network diagram + source + user manual</li>
      <li><b>MA/SLA activation</b> — response time, patch schedule, escalation path</li>
      <li><b>RMA via SCM</b> — spare parts inventory + RMA procedure</li>
      <li><b>Monitoring</b> — dashboard + alert thresholds active</li>
    </ul>
    <p><b>Key:</b> As-built differs from design drawings — captures what was actually installed</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> As-built bundle ไม่ครบ = phase ยังไม่ complete — PM ต้อง gate this before final invoice is issued.</div>

<!-- Speaker: SAT tests site integration. UAT tests user workflow. Both are needed. SAT passing doesn't mean UAT passes. -->

---

## BOM Maturity: 4-Stage Evolution — Never Static

<p class="subhead">ทุก BOM stage change ต้องมี ECO trail — ไม่มี silent update หลัง baseline</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="b" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--muted)"/>
    </marker>
  </defs>
  <rect x="15" y="40" width="215" height="160" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="2"/>
  <rect x="15" y="40" width="215" height="44" rx="10" fill="var(--muted)" opacity=".3"/>
  <text x="122" y="66" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Budgetary BOM</text>
  <text x="122" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase: Pre-sales</text>
  <text x="122" y="128" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Estimated parts + substitutes</text>
  <text x="122" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Owner: HW Lead + SCM</text>
  <text x="122" y="170" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Risk: quote error if wrong</text>
  <line x1="233" y1="120" x2="275" y2="120" stroke="var(--muted)" stroke-width="2" marker-end="url(#b)"/>
  <rect x="278" y="40" width="215" height="160" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="278" y="40" width="215" height="44" rx="10" fill="var(--accent)" opacity=".15"/>
  <text x="385" y="66" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">eBOM</text>
  <text x="385" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase: Post-CDR</text>
  <text x="385" y="128" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Actual design specs + tolerances</text>
  <text x="385" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Owner: HW Engineer</text>
  <text x="385" y="170" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Risk: SCM orders wrong parts</text>
  <line x1="496" y1="120" x2="538" y2="120" stroke="var(--muted)" stroke-width="2" marker-end="url(#b)"/>
  <rect x="541" y="40" width="215" height="160" rx="10" fill="var(--soft)" stroke="var(--warning)" stroke-width="2"/>
  <rect x="541" y="40" width="215" height="44" rx="10" fill="var(--warning)" opacity=".15"/>
  <text x="648" y="66" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Draft pBOM</text>
  <text x="648" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase: Post-DVT</text>
  <text x="648" y="128" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Production-grade parts validated</text>
  <text x="648" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Owner: SCM + HW Lead</text>
  <text x="648" y="170" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Risk: manufacturing delay</text>
  <line x1="759" y1="120" x2="801" y2="120" stroke="var(--muted)" stroke-width="2" marker-end="url(#b)"/>
  <rect x="804" y="40" width="215" height="160" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="804" y="40" width="215" height="44" rx="10" fill="var(--success)" opacity=".2"/>
  <text x="911" y="66" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">pBOM</text>
  <text x="911" y="108" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase: Post-PVT</text>
  <text x="911" y="128" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mass production + spare parts</text>
  <text x="911" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Owner: SCM approved</text>
  <text x="911" y="170" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Dual source + alt confirmed</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> eBOM → pBOM transformation ต้องมี digital thread ที่ไม่ขาด — engineering change ทุกชิ้นต้อง flow downstream ผ่าน ECO ก่อน manufacturing จะ act.</div>

<!-- Speaker: BOM is not written once. Each stage change unlocks the next phase. Silent updates break the supply chain. -->

---

## Supply Risk: 80% of PCB Designs Need Component Swaps

<p class="subhead">80% ของ PCB design ต้องการ component replacement ระหว่าง development เนื่องจาก availability หรือ cost shift</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Strategy 1</p>
    <h3>Long-lead ID</h3>
    <p>ระบุ component ที่ lead time &gt;8 สัปดาห์ตั้งแต่ Budgetary BOM phase — ก่อนที่ deal จะ close</p>
  </div>
  <div class="card compact warning">
    <p class="label">Strategy 2</p>
    <h3>Dual Sourcing</h3>
    <p>ทุก critical component ต้องมี approved alternate supplier ใน pBOM — single-source = single point of failure</p>
  </div>
  <div class="card compact">
    <p class="label">Strategy 3</p>
    <h3>Buffer Stock</h3>
    <p>Safety stock สำหรับ pilot + first production batch ป้องกัน allocation ตึงตัวระหว่าง market shortage</p>
  </div>
  <div class="card compact danger">
    <p class="label">Strategy 4</p>
    <h3>Obsolescence Watch</h3>
    <p>Component ที่ end-of-life risk สูงต้องถูก flag ใน pBOM review cycle — เปลี่ยน alternate ก่อนที่จะถูกบังคับ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Order long-lead parts when eBOM freezes — not when EVT build starts. 16-week lead time cannot be compressed by urgency.</div>

<!-- Speaker: Supply chain risk is the #1 silent killer of hardware project timelines. Start procurement planning at pre-sales, not at kick-off. -->

---

## Cross-discipline Sync: HW → FW → SW Cascade

<p class="subhead">Unmanaged dependencies cascade — one board respin can delay FW and SW by weeks</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--danger)"/>
    </marker>
  </defs>
  <rect x="10" y="20" width="1080" height="85" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="10" y="125" width="1080" height="75" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="10" y="220" width="1080" height="75" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="35" y="68" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">HW</text>
  <text x="35" y="168" font-size="13" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">FW</text>
  <text x="35" y="263" font-size="13" font-weight="700" fill="var(--ink-dim)" font-family="system-ui">SW</text>
  <text x="250" y="15" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Design</text>
  <text x="510" y="15" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EVT</text>
  <text x="750" y="15" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">DVT</text>
  <text x="990" y="15" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PVT</text>
  <text x="250" y="52" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Architecture</text>
  <text x="250" y="68" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Schematic</text>
  <text x="510" y="52" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Build EVT boards</text>
  <text x="510" y="68" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Hand-assembled</text>
  <text x="750" y="52" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Build DVT boards</text>
  <text x="750" y="68" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Production-grade</text>
  <text x="990" y="52" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">pBOM + DFM/DFT</text>
  <text x="990" y="68" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mass prod ready</text>
  <text x="250" y="148" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">FW Spec</text>
  <text x="510" y="148" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">FW EVT test</text>
  <text x="750" y="148" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">FW DVT final</text>
  <text x="990" y="148" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">FW release</text>
  <text x="250" y="248" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SW Architecture</text>
  <text x="510" y="248" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SW EVT integration</text>
  <text x="750" y="248" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SW DVT integration</text>
  <text x="990" y="248" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SW release build</text>
  <line x1="750" y1="105" x2="750" y2="123" stroke="var(--danger)" stroke-width="2" stroke-dasharray="4,3" marker-end="url(#c)"/>
  <text x="760" y="117" font-size="9" fill="var(--danger)" font-family="system-ui">DVT board needed</text>
  <line x1="750" y1="200" x2="750" y2="218" stroke="var(--danger)" stroke-width="2" stroke-dasharray="4,3" marker-end="url(#c)"/>
  <text x="760" y="213" font-size="9" fill="var(--danger)" font-family="system-ui">FW API must be stable</text>
  <text x="10" y="312" font-size="10" fill="var(--muted)" font-family="system-ui">Red arrows = blocking dependency — if HW slips, FW and SW slip in sequence</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Weekly cross-discipline sync ใน Design + Prototype phases คือ ของ mandatory — surface dependency block ก่อนที่มันจะ cascade เป็น weeks of delay.</div>

<!-- Speaker: HW owns the critical path for phases 1-5. FW and SW cannot finalize until HW stabilizes. PM must track this dependency weekly. -->

---

## Change Control: ECO/ECR Loop — No Silent Changes

<p class="subhead">ทุก change หลัง baseline ต้องผ่าน formal process — "แก้เงียบๆ" คือ root cause ของ BOM drift</p>

<div class="infographic">
<svg viewBox="0 0 1100 270" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="d" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--muted)"/>
    </marker>
    <marker id="dg" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--success)"/>
    </marker>
    <marker id="dr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--danger)"/>
    </marker>
  </defs>
  <rect x="15" y="85" width="155" height="60" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="92" y="111" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ECR Raised</text>
  <text x="92" y="129" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">problem + proposed change</text>
  <line x1="173" y1="115" x2="213" y2="115" stroke="var(--muted)" stroke-width="2" marker-end="url(#d)"/>
  <rect x="216" y="85" width="155" height="60" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="293" y="108" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Review Board</text>
  <text x="293" y="124" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PM + Leads evaluate</text>
  <text x="293" y="137" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BOM / schedule / cost impact</text>
  <line x1="374" y1="115" x2="414" y2="115" stroke="var(--muted)" stroke-width="2" marker-end="url(#d)"/>
  <polygon points="458,75 498,115 458,155 418,115" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="458" y="112" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Approved</text>
  <text x="458" y="126" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">?</text>
  <line x1="498" y1="115" x2="538" y2="115" stroke="var(--success)" stroke-width="2" marker-end="url(#dg)"/>
  <text x="518" y="108" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Yes</text>
  <rect x="540" y="85" width="155" height="60" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="617" y="111" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ECO Issued</text>
  <text x="617" y="129" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">authorized change order</text>
  <line x1="698" y1="115" x2="738" y2="115" stroke="var(--muted)" stroke-width="2" marker-end="url(#d)"/>
  <rect x="740" y="85" width="155" height="60" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="817" y="108" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BOM Rev++</text>
  <text x="817" y="124" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">version incremented</text>
  <text x="817" y="138" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ change history logged</text>
  <line x1="898" y1="115" x2="938" y2="115" stroke="var(--muted)" stroke-width="2" marker-end="url(#d)"/>
  <rect x="940" y="85" width="145" height="60" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="1012" y="108" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Implement</text>
  <text x="1012" y="122" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HW / FW / SW / SCM</text>
  <text x="1012" y="136" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">all disciplines update</text>
  <line x1="458" y1="155" x2="458" y2="205" stroke="var(--danger)" stroke-width="2" marker-end="url(#dr)"/>
  <text x="472" y="185" font-size="10" fill="var(--danger-ink)" font-family="system-ui">No</text>
  <rect x="390" y="207" width="135" height="45" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="457" y="228" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ECR Rejected</text>
  <text x="457" y="244" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">back to engineer</text>
  <text x="15" y="262" font-size="10" fill="var(--muted)" font-family="system-ui">Gate-then-batch: collect ECOs at gate reviews — except safety/critical issues which are always immediate ECO</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ECR → ECO → BOM Rev — ทุก change ต้องมี trail ที่ traceable; ไม่มีใครแก้ hardware หรือ firmware โดยไม่มี ECO หลัง baseline.</div>

<!-- Speaker: The gate-then-batch principle prevents the supply chain from being interrupted by constant ECO noise. Safety issues override this always. -->

---

## Caveats: สิ่งที่ Lean ไม่ได้หมายถึง

<p class="subhead">Lean = lean docs + lean process overhead — ไม่ใช่ lean gates หรือ lean discipline</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card compact danger">
    <p class="label">Misconception 1</p>
    <h3>Lean ≠ Skip Gates</h3>
    <p>ลด document overhead ได้ แต่ gate exit criteria ต้องครบ ทุก gate ที่ข้ามคือ technical debt ที่จ่ายทีหลัง</p>
  </div>
  <div class="card compact warning">
    <p class="label">Misconception 2</p>
    <h3>Zero Respin Isn't Realistic</h3>
    <p>Plan 1–2 hardware respins ตั้งแต่ต้น zero-respin planning = wishful thinking สำหรับ custom HW</p>
  </div>
  <div class="card compact">
    <p class="label">Risk 3</p>
    <h3>Cert Lead-time Blind Spot</h3>
    <p>FCC/CE cert ใช้เวลา 4–12 สัปดาห์ ต้องยื่นก่อน DVT complete ไม่ใช่หลัง</p>
  </div>
  <div class="card compact warning">
    <p class="label">Risk 4</p>
    <h3>pBOM Lock Risk</h3>
    <p>SCM contract อาจ lock spec ของ pBOM — component change หลัง lock = ECO รอบใหม่ + cost renegotiation</p>
  </div>
  <div class="card compact">
    <p class="label">Scope Note 5</p>
    <h3>Software-only SI</h3>
    <p>ถ้าไม่มี custom HW — EVT/DVT/PVT และ DFM/DFT ไม่ apply แต่ BOM maturity + change control ยังใช้ได้เสมอ</p>
  </div>
  <div class="card compact gold">
    <p class="label">Always True</p>
    <h3>Acceptance Criteria Early</h3>
    <p>SAT/UAT criteria ต้อง agree ตั้งแต่ pre-sales — ถ้ารอ negotiate ตอน sign-off จะไม่มี basis</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lean คือ "ไม่มีงานที่ไม่มีคนใช้" — ไม่ใช่ "ไม่ต้องมีงาน" ทุก gate ยังต้องมี exit criteria ครบ.</div>

<!-- Speaker: The most common lean misunderstanding: lean means removing waste, not removing rigor. Gates exist to reduce rework, not to add bureaucracy. -->

---

## Key Takeaways: 7 Rules for SI Product Dev

<p class="subhead">Rules ที่ PM และทีม SI ต้องจำไว้ตลอด product lifecycle</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Lifecycle &amp; Commercial</p>
    <h3>Gates + Cash</h3>
    <ul>
      <li>Chain of decision gates — แต่ละ phase unblocks phase ถัดไปด้วย exit criteria จริง</li>
      <li>PO = official kick-off — งาน pre-PO ทั้งหมดคือ investment ที่อาจไม่ได้คืน</li>
      <li>SAT/UAT sign-off = invoice trigger — agree criteria ตั้งแต่ pre-sales</li>
      <li>Logistics delay = payment milestone delay = cashflow impact</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Technical Disciplines</p>
    <h3>BOM + Validation + Supply</h3>
    <ul>
      <li>BOM evolves: budgetary → eBOM → pBOM — ทุก change ต้องมี ECO trail</li>
      <li>EVT/DVT/PVT ไม่ใช่ optional — defect ใน lab ถูกกว่า defect ที่ customer site</li>
      <li>DFM ลด mfg cost 15–20%; DFT ลด field failure rate ~50%</li>
      <li>80% of PCB designs need component swap — order long-lead at eBOM freeze, not at build time</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> BOM + gates + change control = the three non-negotiables. Neglect any one and you will pay in rework, delayed invoices, or field failures.</div>

<!-- Speaker: These 7 rules encode the most common failure modes of SI product development. The first set is about commercial alignment; the second is about technical discipline. -->
