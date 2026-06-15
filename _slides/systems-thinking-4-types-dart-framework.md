---
marp: true
theme: default
paginate: true
title: "Systems Thinking: 4 Types and DART Framework"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#0891b2; --accent-deep:#0e7490; --accent-wash:#cffafe; --gold:#d4af37;
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
  .card.teal    { border-left-color:var(--accent); }
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
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0c1a2e 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/systems-thinking-4-types-dart-framework-cover.png)

<div class="mark"></div>

# Systems Thinking: 4 Types

<p class="tag">See Hidden Patterns — Solve Problems at the Root</p>

<!-- Speaker: Systems thinking helps us see patterns hidden in complexity. The core insight: different types of problems need different types of responses. Using the wrong approach guarantees failure regardless of effort. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/systems-thinking-4-types-dart-framework-cheatsheet.png)

<!-- Speaker: 4 types at a glance — Clear, Complicated, Complex, Chaotic — each with a distinct response pattern. DART helps you classify which one you're in. -->

---

## Systems Thinking Sees What Analysis Misses

<p class="subhead">The wrong response to the right problem still fails — domain classification is the first step.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="1020" height="280" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="20" width="8" height="280" rx="4" fill="var(--accent)"/>
  <!-- Row 1: labels -->
  <text x="140" y="68" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CLEAR</text>
  <text x="360" y="68" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">COMPLICATED</text>
  <text x="600" y="68" font-size="14" font-weight="700" fill="var(--gold)" text-anchor="middle" font-family="system-ui">COMPLEX</text>
  <text x="860" y="68" font-size="14" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">CHAOTIC</text>
  <!-- Row 2: patterns -->
  <rect x="80" y="80" width="120" height="36" rx="6" fill="var(--accent)" opacity=".1"/>
  <text x="140" y="103" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Sense-Cat-Respond</text>
  <rect x="280" y="80" width="160" height="36" rx="6" fill="var(--accent)" opacity=".1"/>
  <text x="360" y="103" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Sense-Analyze-Respond</text>
  <rect x="520" y="80" width="160" height="36" rx="6" fill="var(--gold)" opacity=".12"/>
  <text x="600" y="103" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Probe-Sense-Respond</text>
  <rect x="780" y="80" width="160" height="36" rx="6" fill="var(--danger-wash)"/>
  <text x="860" y="103" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Act-Sense-Respond</text>
  <!-- Row 3: tools -->
  <text x="140" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Checklist / SOP</text>
  <text x="360" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Expert + Analysis</text>
  <text x="600" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Safe-to-fail Experiments</text>
  <text x="860" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Stabilize First</text>
  <!-- Row 4: cause-effect -->
  <text x="140" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Known / Predictable</text>
  <text x="360" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Discoverable by experts</text>
  <text x="600" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Retrospective only</text>
  <text x="860" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No visible pattern</text>
  <!-- Ordered / Unordered labels -->
  <line x1="480" y1="210" x2="480" y2="280" stroke="var(--soft-2)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="90" y="220" width="350" height="36" rx="8" fill="var(--accent-wash)"/>
  <text x="265" y="243" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Ordered — cause-effect known or findable</text>
  <rect x="500" y="220" width="520" height="36" rx="8" fill="var(--warning-wash)"/>
  <text x="760" y="243" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Unordered — cause-effect unknown until after</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ระบุ domain ก่อนเสมอ — wrong response + right effort ยังคือความล้มเหลว</div>

<!-- Speaker: This summary table is the core of the whole talk. Every framework, every tool, every decision method is downstream of this classification. -->

---

## Clear Systems: Use Checklists, Not Creativity

<p class="subhead">Cause-effect is predictable — best practices are known, repeatable, and already proven.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Arrow flow: Sense → Categorize → Respond -->
  <rect x="60" y="100" width="220" height="80" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="170" y="133" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SENSE</text>
  <text x="170" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Observe the situation</text>
  <text x="170" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">What type is this?</text>
  <line x1="280" y1="140" x2="340" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="336,134 346,140 336,146" fill="var(--accent)"/>
  <rect x="345" y="100" width="220" height="80" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="455" y="133" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CATEGORIZE</text>
  <text x="455" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Match to known pattern</text>
  <text x="455" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Which checklist applies?</text>
  <line x1="565" y1="140" x2="625" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="621,134 631,140 621,146" fill="var(--accent)"/>
  <rect x="630" y="100" width="220" height="80" rx="12" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="740" y="133" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">RESPOND</text>
  <text x="740" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Apply best practice</text>
  <text x="740" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Execute SOP / checklist</text>
  <!-- Warning box -->
  <rect x="880" y="90" width="190" height="100" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="975" y="120" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Watch out:</text>
  <text x="975" y="140" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Complacency trap</text>
  <text x="975" y="158" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">When context shifts</text>
  <text x="975" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">old checklist still runs</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Clear = ใช้ checklist/SOP — creativity และ expert analysis เป็นการเสียเวลาสำหรับปัญหาประเภทนี้</div>

<!-- Speaker: The danger of Clear systems is success breeds complacency. When everything works on autopilot, teams stop questioning whether the context has shifted. -->

---

## Complicated Systems: Bring in the Experts

<p class="subhead">Answer exists — but requires expertise and analysis to discover among multiple valid options.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="100" width="220" height="80" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="170" y="133" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SENSE</text>
  <text x="170" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Gather facts &amp; data</text>
  <text x="170" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">What do we know?</text>
  <line x1="280" y1="140" x2="340" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="336,134 346,140 336,146" fill="var(--accent)"/>
  <rect x="345" y="90" width="240" height="100" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="465" y="128" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ANALYZE</text>
  <text x="465" y="148" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Expert + Root cause</text>
  <text x="465" y="166" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Multiple valid options</text>
  <text x="465" y="182" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Good practice (not best)</text>
  <line x1="585" y1="140" x2="645" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="641,134 651,140 641,146" fill="var(--accent)"/>
  <rect x="650" y="100" width="220" height="80" rx="12" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="760" y="133" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">RESPOND</text>
  <text x="760" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Apply expert solution</text>
  <text x="760" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Document learnings</text>
  <!-- Expert trap warning -->
  <rect x="880" y="90" width="190" height="100" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="975" y="120" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Expert trap:</text>
  <text x="975" y="140" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Forcing Complex</text>
  <text x="975" y="158" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">problems into this</text>
  <text x="975" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">domain to use expertise</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Complicated = Sense-Analyze-Respond — ผู้เชี่ยวชาญจำเป็น แต่ต้องระวัง expert bias ที่ force ปัญหา Complex เข้า domain นี้</div>

<!-- Speaker: The expert trap is real — specialists tend to see all problems as analyzable. Watch for experts who resist "we don't know yet" as an answer. -->

---

## Complex Systems: Experiment First, Understand Later

<p class="subhead">No answer exists upfront — patterns emerge through action, understood only in retrospect.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Probe-Sense-Respond cycle -->
  <rect x="60" y="100" width="220" height="100" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="170" y="135" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">PROBE</text>
  <text x="170" y="157" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Safe-to-fail experiment</text>
  <text x="170" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Small scope, real context</text>
  <text x="170" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Fail = data, not disaster</text>
  <line x1="280" y1="150" x2="340" y2="150" stroke="var(--gold)" stroke-width="2"/>
  <polygon points="336,144 346,150 336,156" fill="var(--gold)"/>
  <rect x="345" y="100" width="220" height="100" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="455" y="135" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">SENSE</text>
  <text x="455" y="157" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Observe what emerged</text>
  <text x="455" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">What patterns appeared?</text>
  <text x="455" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">What surprised you?</text>
  <line x1="565" y1="150" x2="625" y2="150" stroke="var(--gold)" stroke-width="2"/>
  <polygon points="621,144 631,150 621,156" fill="var(--gold)"/>
  <rect x="630" y="100" width="220" height="100" rx="12" fill="var(--gold)" opacity=".1" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="740" y="135" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">RESPOND</text>
  <text x="740" y="157" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Amplify what works</text>
  <text x="740" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Dampen what doesn't</text>
  <text x="740" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Iterate → new probe</text>
  <!-- Feedback loop arrow -->
  <path d="M 850 150 C 920 150 940 260 850 270 C 760 280 300 275 250 265 C 140 255 100 210 95 200" stroke="var(--gold)" stroke-width="1.5" fill="none" stroke-dasharray="5,3" opacity=".6"/>
  <polygon points="95,210 89,198 101,198" fill="var(--gold)" opacity=".6"/>
  <text x="540" y="290" font-size="11" fill="var(--gold)" text-anchor="middle" font-family="system-ui">Continuous feedback loop</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Complex = Probe-Sense-Respond — ปัญหาองค์กรวัฒนธรรม, product ใหม่, scaling; ทดลองเร็วถูกกว่าแผนที่สมบูรณ์</div>

<!-- Speaker: The feedback loop arrow is the key visual — this isn't a one-shot process. You probe, learn, probe again. Over-planning is as dangerous as under-planning here. -->

---

## Chaotic Systems: Act First, Analyze Second

<p class="subhead">No cause-effect visible — stabilize the situation immediately before attempting analysis.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="90" width="220" height="100" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="170" y="128" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ACT</text>
  <text x="170" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Decisive immediate action</text>
  <text x="170" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No time to analyze</text>
  <text x="170" y="186" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Stop the bleeding first</text>
  <line x1="280" y1="140" x2="340" y2="140" stroke="var(--danger)" stroke-width="2"/>
  <polygon points="336,134 346,140 336,146" fill="var(--danger)"/>
  <rect x="345" y="100" width="220" height="80" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="455" y="133" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">SENSE</text>
  <text x="455" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">What has stabilized?</text>
  <text x="455" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Assess immediate state</text>
  <line x1="565" y1="140" x2="625" y2="140" stroke="var(--success)" stroke-width="2"/>
  <polygon points="621,134 631,140 621,146" fill="var(--success)"/>
  <rect x="630" y="100" width="220" height="80" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="740" y="128" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">RESPOND</text>
  <text x="740" y="148" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Transition to Complex</text>
  <text x="740" y="165" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Then Complicated</text>
  <text x="740" y="182" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Goal: leave Chaotic fast</text>
  <!-- Hero mode warning -->
  <rect x="880" y="80" width="190" height="120" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="975" y="112" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Hero mode trap:</text>
  <text x="975" y="132" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Leaders who enjoy</text>
  <text x="975" y="150" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">chaos maintain it</text>
  <text x="975" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">instead of resolving</text>
  <text x="975" y="186" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">it. Watch for this.</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Chaotic = Act-Sense-Respond — เป้าหมายคือออกจาก Chaotic ให้เร็วที่สุด ไม่ใช่คงอยู่ใน "hero mode"</div>

<!-- Speaker: The transition arrow to Complex is deliberate — Chaotic is not a permanent state. The goal is always to stabilize, learn, and move toward more ordered domains. -->

---

## DART: Classify Before You Respond

<p class="subhead">Four questions that identify which domain you're operating in before choosing a response pattern.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">D — Domain Clarity</p>
    <h3>How clear is cause-effect?</h3>
    <p>Known and predictable → Clear. Discoverable with analysis → Complicated. Only retrospective → Complex. Invisible now → Chaotic.</p>
  </div>
  <div class="card">
    <p class="label">A — Actor Variety</p>
    <h3>How many parties are involved?</h3>
    <p>Few, predictable actors → Ordered domain. Many independent actors with emergent behavior → Unordered domain (Complex or Chaotic).</p>
  </div>
  <div class="card gold">
    <p class="label">R — Response Options</p>
    <h3>Does a playbook exist?</h3>
    <p>Established SOP exists → Clear. Expert can analyze → Complicated. Must experiment to discover → Complex. Must act now → Chaotic.</p>
  </div>
  <div class="card gold">
    <p class="label">T — Time Pressure</p>
    <h3>How much time to analyze?</h3>
    <p>Ample time, known solution → Clear/Complicated. Time to run small experiments → Complex. No time at all → Chaotic; act first.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DART → domain → response pattern — ตอบทั้ง 4 คำถามก่อนตัดสินใจว่าจะ respond อย่างไร</div>

<!-- Speaker: DART is a classification heuristic, not an algorithm. The four questions push you to think about context before reaching for your default tool. -->

---

## 3 External Perspectives That Help You See Clearly

<p class="subhead">We can't accurately classify the system we're inside — external input corrects our blind spots.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Perspective 1</p>
    <h3>Mentor / Advisor</h3>
    <p>Someone who has operated in similar systems before. Pattern recognition from past experience can confirm: "this is Complicated — there's an answer, keep analyzing" or "this is Complex — stop planning, start experimenting."</p>
  </div>
  <div class="card gold">
    <p class="label">Perspective 2</p>
    <h3>Data</h3>
    <p>Leading indicators that track feedback loops. Is your response moving the system in the intended direction? Are unexpected emergent behaviors appearing? Data surfaces what intuition misses.</p>
  </div>
  <div class="card success">
    <p class="label">Perspective 3</p>
    <h3>Time</h3>
    <p>Complex system patterns often clarify in retrospect. Sometimes the best move is a small probe + wait for the signal. Premature commitment with insufficient data costs more than a short pause to observe.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อย่าประเมิน domain ของระบบที่ตัวเองอยู่ใน คนเดียว — mentor, data, หรือ time ให้มุมมองที่ unbiased กว่าเสมอ</div>

<!-- Speaker: The hardest part of systems thinking is that you're inside the system you're trying to classify. These three external inputs are the antidote to tunnel vision. -->

---

## The Hardest System to Improve: Your Own Mental Model

<p class="subhead">Cognitive bias makes us misclassify domains — and the pattern repeats until you build a habit of checking.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">The Problem</p>
    <h3>3 Mental Model Bugs</h3>
    <ul>
      <li><b>Domain misclassification:</b> Experience bias makes Complex look Complicated — we reach for experts instead of experiments</li>
      <li><b>Availability heuristic:</b> We pull the last solution that worked, even when context has changed</li>
      <li><b>Tunnel vision:</b> Being inside the system blinds us to its actual domain</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">The Fix</p>
    <h3>3 Habits to Build</h3>
    <ul>
      <li><b>Domain check habit:</b> Before every decision — "which of the 4 domains is this?" (30-second pause)</li>
      <li><b>Seek external input:</b> Mentor, data, or deliberate waiting — especially for high-stakes decisions</li>
      <li><b>Post-mortem question:</b> "Did I classify the domain correctly from the start?" — learn from each mismatch</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> กรอบความคิดในหัวเราคือระบบ Complex — ต้องทดลอง, สังเกต, และปรับ ไม่ใช่แค่รู้แล้วทำตาม</div>

<!-- Speaker: The meta-lesson: our mental models are themselves Complex systems. You can't think your way to better thinking — you have to probe (try new approach), sense (what happened), and respond (adjust). -->

---

## Key Takeaways: One Framework, Four Responses

<p class="subhead">Systems thinking works only when the response matches the domain — not just the effort level.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card compact teal">
    <p class="label">Clear</p>
    <h3>Sense-Categorize-Respond</h3>
    <p>Checklists + SOP. Watch for complacency when context shifts.</p>
  </div>
  <div class="card compact teal">
    <p class="label">Complicated</p>
    <h3>Sense-Analyze-Respond</h3>
    <p>Experts + analysis. Watch for expert trap forcing Complex into this.</p>
  </div>
  <div class="card compact gold">
    <p class="label">Complex</p>
    <h3>Probe-Sense-Respond</h3>
    <p>Safe-to-fail experiments. Patterns emerge — don't over-plan.</p>
  </div>
  <div class="card compact danger">
    <p class="label">Chaotic</p>
    <h3>Act-Sense-Respond</h3>
    <p>Stabilize immediately. Goal: leave Chaotic fast, avoid hero mode.</p>
  </div>
  <div class="card compact">
    <p class="label">DART</p>
    <h3>Classify First</h3>
    <p>Domain clarity, Actor variety, Response options, Time pressure.</p>
  </div>
  <div class="card compact warning">
    <p class="label">Hardest System</p>
    <h3>Your Mental Model</h3>
    <p>Use mentor + data + time. Post-mortem domain classification every time.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถามก่อนทุกครั้ง: "domain นี้คืออะไร?" — คำถามนั้นเพียงข้อเดียวเปลี่ยนคุณภาพของการตัดสินใจได้</div>

<!-- Speaker: Close with the one habit: before any response, classify the domain. 30 seconds of DART is worth hours of misaligned effort. -->
