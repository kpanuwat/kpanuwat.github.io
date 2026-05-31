---
marp: true
theme: default
paginate: true
title: "AI Coding Workflow"
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
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:16px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# AI Coding Workflow ที่มีประสิทธิภาพ

<p class="tag">Smart Zone · Vertical Slices · TDD — Matt Pocock @ AI Engineer Europe 2026</p>

<!-- Speaker: Full walkthrough of Matt Pocock's AI coding workflow — 6 principles grounded in LLM constraints. Not "how to prompt" but "why each step works." -->

---

## Writing a Big Spec and Hoping for Results Always Fails

<p class="subhead">AI hits its "dumb zone" mid-task — output degrades, errors compound, the re-prompt loop makes things worse.</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="105" width="155" height="64" rx="10" fill="var(--accent)"/>
  <text x="108" y="131" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Big Spec</text>
  <text x="108" y="152" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Written upfront</text>

  <rect x="250" y="105" width="155" height="64" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="328" y="131" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI Starts</text>
  <text x="328" y="152" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Context grows</text>

  <rect x="470" y="105" width="155" height="64" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="548" y="131" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Dumb Zone</text>
  <text x="548" y="152" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">100K+ tokens</text>

  <rect x="690" y="105" width="155" height="64" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="768" y="131" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Wrong Output</text>
  <text x="768" y="152" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Errors compound</text>

  <rect x="910" y="105" width="155" height="64" rx="10" fill="var(--danger)"/>
  <text x="988" y="131" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Re-prompt</text>
  <text x="988" y="152" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Loop worsens</text>

  <line x1="186" y1="137" x2="248" y2="137" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="245,132 258,137 245,142" fill="var(--muted)"/>
  <line x1="406" y1="137" x2="468" y2="137" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="465,132 478,137 465,142" fill="var(--muted)"/>
  <line x1="626" y1="137" x2="688" y2="137" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="685,132 698,137 685,142" fill="var(--warning)"/>
  <line x1="846" y1="137" x2="908" y2="137" stroke="var(--danger)" stroke-width="2"/>
  <polygon points="905,132 918,137 905,142" fill="var(--danger)"/>

  <path d="M 988 169 Q 988 240 548 240 Q 180 240 108 169" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,4"/>
  <polygon points="102,168 108,181 114,168" fill="var(--danger)"/>
  <text x="548" y="232" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">context never resets — dumb zone deepens</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The fix isn't a better prompt — it's a workflow that keeps AI inside its smart zone for every task.</div>

<!-- Speaker: The root cause is context management, not prompt quality. We need to redesign how we assign work to AI. -->

---

## LLM Reasoning Degrades at ~100K Tokens, Regardless of Window Size

<p class="subhead">Concept from Dex Hy (Human Layer): attention relationships scale as O(n²) — the smart zone ends at ~40% of any context window.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Smart Zone panel -->
  <rect x="40" y="20" width="460" height="260" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="40" y="20" width="460" height="52" rx="12" fill="var(--success)"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Smart Zone (0-100K tokens)</text>
  <text x="80" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">Fresh conversation</text>
  <text x="80" y="138" font-size="13" fill="var(--ink)" font-family="system-ui">Attention load is low</text>
  <text x="80" y="168" font-size="13" fill="var(--success-ink)" font-family="system-ui">Accurate reasoning</text>
  <text x="80" y="198" font-size="13" fill="var(--success-ink)" font-family="system-ui">Consistent outputs</text>
  <text x="80" y="228" font-size="12" fill="var(--muted)" font-family="system-ui">Fix: clear context, restart per task</text>

  <!-- Dumb Zone panel -->
  <rect x="600" y="20" width="460" height="260" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="600" y="20" width="460" height="52" rx="12" fill="var(--danger)"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Dumb Zone (100K+ tokens)</text>
  <text x="640" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">Context accumulated</text>
  <text x="640" y="138" font-size="13" fill="var(--ink)" font-family="system-ui">O(n2) attention strain</text>
  <text x="640" y="168" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Degraded decisions</text>
  <text x="640" y="198" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Inconsistent outputs</text>
  <text x="640" y="228" font-size="12" fill="var(--muted)" font-family="system-ui">Compacting helps retrieval, NOT reasoning</text>

  <!-- Arrow between -->
  <line x1="502" y1="150" x2="598" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="595,145 608,150 595,155" fill="var(--muted)"/>
  <text x="550" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~100K</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Never compact a long conversation — restart context for every new task to stay in the smart zone.</div>

<!-- Speaker: This is Dex Hy's insight. 1M context window still degrades at 100K for coding. More context = retrieval; doesn't = reasoning. Like Memento: more notes, same bad judgment. -->

---

## Grill First, Code Never — Until the PRD Exists

<p class="subhead">Shared design concept must exist before any code — PRD is the "destination document" AI uses to recover context after each reset.</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1: Grill Me -->
  <rect x="30" y="90" width="200" height="100" rx="12" fill="var(--accent)" />
  <text x="130" y="133" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Grill Me</text>
  <text x="130" y="158" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">40-100 questions</text>

  <!-- Arrow 1 -->
  <line x1="232" y1="140" x2="290" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="287,135 300,140 287,145" fill="var(--muted)"/>

  <!-- Step 2: Shared Design Concept -->
  <rect x="302" y="70" width="200" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="402" y="116" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Shared</text>
  <text x="402" y="138" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Design</text>
  <text x="402" y="160" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Concept</text>
  <text x="402" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Invisible shared theory</text>

  <!-- Arrow 2 -->
  <line x1="504" y1="140" x2="562" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="559,135 572,140 559,145" fill="var(--muted)"/>

  <!-- Step 3: PRD -->
  <rect x="574" y="70" width="200" height="140" rx="12" fill="var(--gold)" opacity=".15" stroke="var(--gold)" stroke-width="2"/>
  <text x="674" y="116" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PRD</text>
  <text x="674" y="138" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Destination doc</text>
  <text x="674" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Problem + Stories</text>
  <text x="674" y="182" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Decisions + Tests</text>

  <!-- Arrow 3 -->
  <line x1="776" y1="140" x2="834" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="831,135 844,140 831,145" fill="var(--muted)"/>

  <!-- Step 4: Kanban -->
  <rect x="846" y="70" width="224" height="140" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="958" y="116" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Kanban</text>
  <text x="958" y="138" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Issues + DAG</text>
  <text x="958" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Blocking relations</text>
  <text x="958" y="182" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Ready for night shift</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PRD is the context reset survival kit — AI reads it at the start of each new conversation to recover shared understanding without prompting from scratch.</div>

<!-- Speaker: "Grill me" forces AI to interview you 40-100 questions before any code. PRD records the outcome. Kanban breaks PRD into executable, context-sized tasks. -->

---

## Kanban as DAG: Human Plans the Day, Agents Execute the Night

<p class="subhead">Markdown issues with blocking relationships form a DAG — tasks without blockers run in parallel during the autonomous "night shift."</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Day Shift (Human + AI)</p>
    <h3>Planning Session</h3>
    <p>Grill → PRD → แบ่งงานเป็น Kanban issues แต่ละ issue มี: description ชัดเจน + blocking dependencies บอก predecessor</p>
    <ul>
      <li>Human reviews และ approves plan</li>
      <li>AI จัด DAG structure ให้ออกมาเป็น markdown files</li>
      <li>Kanban ใน codebase — agents อ่านและอัปเดตได้โดยตรง</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Night Shift (Autonomous Agents)</p>
    <h3>Ralph Loop — AFK Execution</h3>
    <p>อ่าน issue ที่ไม่มี blocker → implement ด้วย TDD → run tests → commit PR → Human reviews ตอนเช้า</p>
    <ul>
      <li>Multiple agents parallel บน unblocked issues</li>
      <li>ทุก agent เริ่ม context ใหม่ (smart zone) ต่อ issue</li>
      <li>ต้องการ CI/CD + test suite ที่แข็งแรงก่อนใช้</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Structure work as a DAG of small, context-sized issues — each one fits in the smart zone, and unblocked ones run in parallel autonomously.</div>

<!-- Speaker: The markdown kanban is key: it lives in the codebase, agents can read/update it, and it survives context resets. -->

---

## Vertical Slices Force Feedback; Horizontal Coding Blinds AI

<p class="subhead">AI defaults to horizontal coding (all DB first, then API, then UI) — mandate vertical slices that cut through every layer per feature.</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Horizontal (bad) -->
  <rect x="30" y="20" width="470" height="240" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="470" height="50" rx="12" fill="var(--danger-wash)"/>
  <text x="265" y="51" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Horizontal (AI Default) — Bad</text>
  <rect x="55" y="90" width="420" height="36" rx="6" fill="var(--soft-2)"/>
  <text x="265" y="113" font-size="13" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase 1: All Database schemas</text>
  <rect x="55" y="136" width="420" height="36" rx="6" fill="var(--soft-2)"/>
  <text x="265" y="159" font-size="13" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Phase 2: All API endpoints</text>
  <rect x="55" y="182" width="420" height="36" rx="6" fill="var(--danger-wash)"/>
  <text x="265" y="205" font-size="13" font-weight="600" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Phase 3: All UI — first feedback here</text>

  <!-- Vertical (good) -->
  <rect x="600" y="20" width="470" height="240" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2"/>
  <rect x="600" y="20" width="470" height="50" rx="12" fill="var(--success-wash)"/>
  <text x="835" y="51" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Vertical Slices — Good</text>
  <rect x="625" y="90" width="420" height="36" rx="6" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="835" y="113" font-size="13" font-weight="600" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Slice A: DB + API + UI — feedback now</text>
  <rect x="625" y="136" width="420" height="36" rx="6" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="835" y="159" font-size="13" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Slice B: DB + API + UI — feedback now</text>
  <rect x="625" y="182" width="420" height="36" rx="6" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="835" y="205" font-size="13" font-weight="600" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Slice C: DB + API + UI — feedback now</text>

  <!-- VS badge -->
  <circle cx="550" cy="150" r="26" fill="var(--accent)"/>
  <text x="550" y="155" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Mandate vertical slices in every Kanban issue — each issue must touch DB + service + UI so AI gets integrated feedback immediately.</div>

<!-- Speaker: Tracer bullets from The Pragmatic Programmer. AI naturally wants to go horizontal because it "feels" complete. Enforce vertical in the PRD and Kanban issue descriptions. -->

---

## TDD is the Ceiling for How Good AI Code Can Be

<p class="subhead">Without TDD, AI "cheats" — it writes tests to pass its own flawed implementation. TDD forces writing the test before the implementation exists.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Without TDD — AI Cheats</p>
    <h3>Implementation + Test Together</h3>
    <p>AI รู้ว่า implementation เป็นอะไรแล้ว → เขียน test ที่ออกแบบมาเพื่อ pass implementation ที่แย่โดยเฉพาะ ไม่ใช่ test ที่ตรวจสอบ behavior จริง</p>
    <ul>
      <li>Tests pass แต่ behavior ผิด</li>
      <li>Bug ซ่อนอยู่ใต้ test coverage ปลอม</li>
      <li>Context ใหญ่ขึ้น → dumb zone เร็วขึ้น</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">With TDD — Honest Feedback</p>
    <h3>RED → GREEN → REFACTOR</h3>
    <p>เขียน test ก่อน (AI ยังไม่รู้ว่า implementation จะเป็นอะไร) → implement ให้ pass → refactor ทีละ step เล็กๆ ไม่เกิน 1 test/cycle</p>
    <ul>
      <li>Test ตรวจสอบ behavior จริง</li>
      <li>Step เล็ก → error หา root cause ได้เร็ว</li>
      <li>Context ต่อ cycle สั้น → อยู่ใน smart zone</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Automated feedback loops are the hard ceiling for AI code quality — TDD is how you raise that ceiling by forcing honest tests.</div>

<!-- Speaker: TDD also naturally enforces small context windows per cycle — you write one test, AI passes it. The cycle stays in the smart zone. -->

---

## Deep Modules Let AI Work Without Reading Every File

<p class="subhead">Shallow modules force AI to load massive context to understand even small changes — this directly pushes context into the dumb zone.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Shallow Modules (AI Default Output)</p>
    <h3>Many Small Interconnected Files</h3>
    <p>AI สร้าง code blobs เล็กๆ ที่ interconnect กันทั้ง codebase ทุกครั้งที่แก้ไขต้องอ่าน 10+ files เพื่อเข้าใจ context</p>
    <ul>
      <li>ต้องการ context มากเพื่อเข้าใจการเปลี่ยนแปลงเล็กน้อย</li>
      <li>ดัน context เข้า dumb zone โดยตรง</li>
      <li>Test boundary ไม่ชัด → TDD ยาก</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Deep Modules (Target Architecture)</p>
    <h3>Simple Interface, Complex Inside</h3>
    <p>Developer ออกแบบ interface → AI implement ภายใน "grey box" AI รู้ว่า module ทำอะไรจาก interface เดียว ไม่ต้องอ่าน internals</p>
    <ul>
      <li>Context ต่อ task น้อย → รักษา smart zone</li>
      <li>Test ที่ boundary ชัดเจน → TDD ง่าย</li>
      <li>AI มี scope จำกัด → output ตรงเป้า</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design the module interface yourself — then hand the internal implementation to AI as a "grey box." This keeps tasks small and context-bounded.</div>

<!-- Speaker: Deep modules and TDD reinforce each other: deep modules create clear test boundaries, TDD forces AI to implement correctly inside those boundaries. -->

---

## Cheatsheet: All 6 Concepts at a Glance

<p class="subhead">AI Coding Workflow — Matt Pocock @ AI Engineer Europe 2026.</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-coding-workflow-smart-zone-vertical-slices-tdd-cheatsheet.png" alt="6-concept cheatsheet: Smart Zone, Grill-PRD, Kanban, Vertical Slices, TDD, Deep Modules">
<figcaption>Source: NotebookLM · AI Coding Workflow — Matt Pocock's full walkthrough</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pin this — your daily checklist before any significant AI coding session starts.</div>

<!-- Speaker: Walk through each panel. These 6 concepts form a complete, interlocking system. -->

---

## Your Role: Plan the Day Shift, Trust the Night Shift

<p class="subhead">The developer's role shifts from writing code to designing workflows — planning, architecture, and quality gates that AI cannot do alone.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact danger">
    <p class="label">Context Limit</p>
    <h3>Smart Zone ~100K</h3>
    <p>Reset context ทุก task ใหม่ — ไม่ใช่ compact</p>
  </div>
  <div class="card compact">
    <p class="label">Planning</p>
    <h3>Grill → PRD</h3>
    <p>ไม่มีโค้ดก่อน shared design concept ชัดเจน</p>
  </div>
  <div class="card compact warning">
    <p class="label">Execution</p>
    <h3>Kanban DAG</h3>
    <p>Issues เล็ก, blocking ชัด, parallel night shift</p>
  </div>
  <div class="card compact">
    <p class="label">Slicing</p>
    <h3>Vertical Slices</h3>
    <p>ทุก issue ตัดผ่าน DB + API + UI พร้อมกัน</p>
  </div>
  <div class="card compact success">
    <p class="label">Quality</p>
    <h3>TDD Ceiling</h3>
    <p>Test ก่อน implement เสมอ — ป้องกัน AI cheating</p>
  </div>
  <div class="card compact">
    <p class="label">Architecture</p>
    <h3>Deep Modules</h3>
    <p>Interface ออกแบบเอง — AI implement "grey box"</p>
  </div>
  <div class="card gold" style="grid-column:1/-1;padding:14px 18px;">
    <p class="label">The Developer's New Role</p>
    <h3>Architect of the Workflow, Not Writer of the Code</h3>
    <p>Workflow 6 ขั้นนี้ไม่ได้ลด role ของ developer — แต่ย้าย focus ไปที่ planning, architecture และ quality gate ซึ่งเป็นงานที่ AI ยังทำแทนไม่ได้ในปัจจุบัน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Software engineering skills decide workflow design — that's what determines whether AI-assisted development succeeds or spirals into entropy.</div>

<!-- Speaker: Six interlocking concepts — none works alone. Smart Zone sizing enables PRD, PRD enables Kanban, Kanban enables parallel night shift, TDD and Deep Modules ensure quality throughout. -->
