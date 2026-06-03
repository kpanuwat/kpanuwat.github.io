---
marp: true
theme: default
paginate: true
title: "Prompt Technical Debt"
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
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
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

![bg opacity:.25](assets/prompt-technical-debt-cover.png)

<div class="mark"></div>

# Prompt Technical Debt

<p class="tag">Why complex system prompts make AI dumber — and how to fix it</p>

<!-- Speaker: Prompt debt is the hidden tax on every AI-assisted project. Today: what it is, how it accumulates, and the minimal-config practices that prevent it. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/prompt-technical-debt-cheatsheet.png)

<!-- Speaker: Orientation: 4 accumulation mechanisms, context rot symptoms, minimal-config playbook, session hygiene commands. -->

---

## Prompt Debt: Silent Decay

<p class="subhead">Prompt debt ไม่ throw error — มันแค่ทำให้ AI โง่ลงเงียบๆ ทุกครั้งที่ model upgrade</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="1020" height="290" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="8" height="290" rx="4" fill="var(--danger)"/>
  <circle cx="128" cy="175" r="48" fill="var(--danger)" opacity=".1"/>
  <circle cx="128" cy="175" r="34" fill="var(--danger)" opacity=".2"/>
  <text x="128" y="182" font-size="30" fill="var(--danger)" text-anchor="middle" font-family="system-ui" font-weight="800">!</text>
  <text x="210" y="110" font-size="21" font-weight="700" fill="var(--ink)" font-family="system-ui">Silent Decay</text>
  <text x="210" y="145" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Code debt: loud failures (errors, slowdowns, stack traces)</text>
  <text x="210" y="175" font-size="15" fill="var(--danger)" font-family="system-ui" font-weight="600">Prompt debt: silent failures — AI just gets dumber, no warning</text>
  <text x="210" y="215" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Every model upgrade can break a working prompt — with zero signal</text>
  <text x="210" y="245" font-size="14" fill="var(--muted)" font-family="system-ui">Files untouched for months still steer every AI session today</text>
  <rect x="870" y="70" width="150" height="38" rx="8" fill="var(--danger-wash)"/>
  <text x="945" y="94" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">CODE DEBT</text>
  <rect x="870" y="120" width="150" height="38" rx="8" fill="var(--warning-wash)"/>
  <text x="945" y="144" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">PROMPT DEBT</text>
  <text x="875" y="188" font-size="11" fill="var(--muted)" font-family="system-ui">Loud</text>
  <text x="985" y="188" font-size="11" fill="var(--muted)" text-anchor="end" font-family="system-ui">Silent</text>
  <line x1="875" y1="196" x2="1015" y2="196" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="875" y1="196" x2="875" y2="256" stroke="var(--danger)" stroke-width="2"/>
  <line x1="1015" y1="196" x2="1015" y2="256" stroke="var(--warning)" stroke-width="2"/>
  <rect x="0" y="310" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prompt debt decays silently — you won't know it's hurting until significant AI quality degradation has already accumulated.</div>

<!-- Speaker: Sean Goedecke's key insight: code debt at least gives you errors. Prompt debt quietly degrades AI quality with no signal. -->

---

## Why This Matters Now

![bg right:40% contain](assets/prompt-technical-debt-background.png)

<p class="subhead">Modern AI projects stack multiple prompt layers — most written for older models and never revisited.</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--danger)"/></marker></defs>
  <rect x="20" y="222" width="280" height="34" rx="6" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="160" y="244" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-weight="600">system_prompt_v3.txt</text>
  <rect x="20" y="182" width="280" height="34" rx="6" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="160" y="204" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-weight="600">CLAUDE.md</text>
  <rect x="20" y="142" width="280" height="34" rx="6" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="160" y="164" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="600">AGENTS.md</text>
  <rect x="20" y="102" width="280" height="34" rx="6" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="160" y="124" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">skills/*.md (x12)</text>
  <rect x="20" y="62" width="280" height="34" rx="6" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="160" y="84" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">MCP server descriptions</text>
  <text x="160" y="292" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Last updated: 2 months ago</text>
  <line x1="310" y1="142" x2="370" y2="142" stroke="var(--danger)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="380" y="102" width="280" height="96" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="520" y="140" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Context Bloat</text>
  <text x="520" y="164" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Tokens consumed before</text>
  <text x="520" y="184" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">any real work begins</text>
  <rect x="0" y="298" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Real example: T3 Chat AGENTS.md still said "this is an early WIP" and "Codex-first" — both false, both still steering every AI session.</div>

<!-- Speaker: The file is stable. The world changed around it. Model v3 came out; file still thinks you're on v1 with early-WIP assumptions. -->

---

## Prompt Debt vs Code Debt

<p class="subhead">Prompt debt แย่กว่า code debt ในทุก 3 มิติ — เงียบ, ไม่เสถียร, และมองไม่เห็น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="align-items:stretch;">
  <div class="card compact" style="border-left-color:var(--muted)">
    <p class="label">Dimension 1</p>
    <h3>Failure Mode</h3>
    <p><b style="color:var(--success)">Code Debt:</b> Loud — errors, slowdowns, visible stack traces. You know when it breaks.</p>
    <p><b style="color:var(--danger)">Prompt Debt:</b> Silent — AI just works worse. No alert, no log entry, no CI failure.</p>
  </div>
  <div class="card compact" style="border-left-color:var(--muted)">
    <p class="label">Dimension 2</p>
    <h3>Stability</h3>
    <p><b style="color:var(--success)">Code Debt:</b> Stable when untouched — code doesn't rot on its own without a change.</p>
    <p><b style="color:var(--danger)">Prompt Debt:</b> Every model upgrade can silently break working prompts.</p>
  </div>
  <div class="card compact" style="border-left-color:var(--muted)">
    <p class="label">Dimension 3</p>
    <h3>Detection</h3>
    <p><b style="color:var(--success)">Code Debt:</b> Stack traces, CI failures, type errors, linters — automatic detection.</p>
    <p><b style="color:var(--danger)">Prompt Debt:</b> Only observable through behavioral changes — requires human judgment.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prompt debt is worse in every dimension — no automatic detection means it compounds unseen until someone notices the AI "got weird."</div>

<!-- Speaker: The asymmetry is the key insight: code debt at least fails loudly. You can't set up a CI check for "AI started giving vague answers." -->

---

## 4 กลไกที่ Prompt Debt สะสม

<p class="subhead">แต่ละกลไกเพิ่ม hidden context overhead ที่กิน token ก่อนงานจริงจะเริ่ม</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="align-items:stretch;">
  <div class="card danger">
    <p class="label">Mechanism 1</p>
    <h3>File Proliferation</h3>
    <p>AGENTS.md + CLAUDE.md + subdirectory files + skills + tool prompts + dynamic system prompts — each layer adds context overhead and potential staleness. ทุกชั้นเพิ่ม debt โดยอัตโนมัติ</p>
  </div>
  <div class="card danger">
    <p class="label">Mechanism 2</p>
    <h3>Plugin &amp; MCP Bloat</h3>
    <p>ทุก MCP server หรือ plugin ที่ install คือ prompt ที่ inject เข้า context อัตโนมัติ ครึ่งหนึ่งของ context window หมดไปก่อน agent จะเริ่มทำงานจริง</p>
  </div>
  <div class="card warning">
    <p class="label">Mechanism 3</p>
    <h3>Auto-generated Fluff</h3>
    <p>AI-generated config files ที่ developer copy-paste เข้า CLAUDE.md โดยไม่อ่าน — สร้างหนี้ตั้งแต่วันแรกโดยไม่รู้ตัว เต็มไปด้วย instructions ที่ไม่มีใครต้องการ</p>
  </div>
  <div class="card warning">
    <p class="label">Mechanism 4</p>
    <h3>Stagnation</h3>
    <p>T3 Chat AGENTS.md: ไม่ได้อัปเดต 2 เดือน ยังบอก "early WIP" และ "Codex-first" — ทั้งสองเท็จ แต่ยังคง steer model ทุกวัน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prompt debt accumulates passively — you don't have to make a mistake; just stop maintaining your config files for 2 months.</div>

<!-- Speaker: Stagnation is the sneakiest. The file is "stable" but the world changed around it. Model upgraded; file still has old assumptions. -->

---

## Legacy Steering Hurts New Models

<p class="subhead">Prompts written for old models can actively restrict newer, more capable ones</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="align-items:stretch;">
  <div class="card danger">
    <p class="label">Legacy Trick (GPT-3 era)</p>
    <h3>"Think step by step"</h3>
    <p>Model รุ่นใหม่มี built-in chain-of-thought อยู่แล้ว การบอกซ้ำอาจ interrupt หรือ override กระบวนการคิดที่ model ทำได้ดีกว่าเองอยู่แล้ว</p>
  </div>
  <div class="card danger">
    <p class="label">Outdated Pattern</p>
    <h3>"You are a senior engineer"</h3>
    <p>Persona injection จำเป็นสำหรับ early models Model ใหม่ไม่ต้องการ role-priming — instruction นี้แค่ waste tokens และจำกัดความยืดหยุ่นของ model</p>
  </div>
  <div class="card danger">
    <p class="label">Psychological Hack</p>
    <h3>"I'll tip you $200"</h3>
    <p>Worked as a hack on GPT-3. Has zero effect on modern models. Pure context overhead — แถมยังทำให้ prompt ดูไม่ professional อีกด้วย</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Every model upgrade means legacy steering is either useless (wasting tokens) or harmful (overriding the model's better defaults).</div>

<!-- Speaker: These were good advice once. The problem: they outlived their usefulness. Model improved, prompt didn't get deleted. -->

---

## Context Rot: อาการที่สังเกตได้

<p class="subhead">When context fills with stale instructions, model attention fragments and quality collapses</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="align-items:stretch;">
  <div class="card warning">
    <p class="label">Symptom 1</p>
    <h3>Revisits Rejected Ideas</h3>
    <p>AI นำ approach หรือ library ที่คุณ reject ไปแล้วกลับมาเสนออีกครั้ง — context รุ่นเก่าถูกดึงมาใช้แทน instruction ปัจจุบัน</p>
  </div>
  <div class="card warning">
    <p class="label">Symptom 2</p>
    <h3>Vague &amp; Hedged Answers</h3>
    <p>คำตอบกลายเป็น "it depends", "you might consider" แทนที่จะตรงประเด็น — useful signal กลมกลืนกับ noise ที่สะสม</p>
  </div>
  <div class="card danger">
    <p class="label">Symptom 3</p>
    <h3>Self-Contradiction</h3>
    <p>AI ขัดแย้งกับสิ่งที่ตัวเองพูดหรือ decide ไปก่อนหน้าในช่วงการสนทนาเดียวกัน — context ของ earlier decision หายไปแล้ว</p>
  </div>
  <div class="card danger">
    <p class="label">Symptom 4</p>
    <h3>Bug Resurrection</h3>
    <p>Bug ที่เพิ่งแก้กลับมาอีกครั้ง — context window สมัยที่ bug ยังอยู่ถูกดึงมาใช้มากกว่า fix ที่ทำไปล่าสุด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Context rot symptoms look like AI stupidity — but it's an engineering problem: signal-to-noise failure from accumulated junk in the context window.</div>

<!-- Speaker: Most developers blame the model. Context rot is fixable. Clean context = smart AI. Same model, better results. -->

---

## Minimal Config: ใช้ Stock ให้มากที่สุด

![bg right:40% contain](assets/prompt-technical-debt-minimal.png)

<p class="subhead">The best system prompt is maintained by a full engineering team — not you alone.</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--danger)"/></marker><marker id="arr3" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--success)"/></marker></defs>
  <rect x="10" y="20" width="310" height="256" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="165" y="50" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Custom Override</text>
  <text x="165" y="82" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Tune prompts for Model v1</text>
  <line x1="165" y1="94" x2="165" y2="114" stroke="var(--danger)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="165" y="132" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Model v2 ships</text>
  <line x1="165" y1="144" x2="165" y2="164" stroke="var(--danger)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="165" y="182" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Your overrides fight v2 defaults</text>
  <text x="165" y="226" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">AI gets dumber over time</text>
  <circle cx="350" cy="148" r="24" fill="var(--accent)"/>
  <text x="350" y="153" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="380" y="20" width="310" height="256" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="535" y="50" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Stock / Minimal</text>
  <text x="535" y="82" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Tool ships with v1 tuning</text>
  <line x1="535" y1="94" x2="535" y2="114" stroke="var(--success)" stroke-width="1.5" marker-end="url(#arr3)"/>
  <text x="535" y="132" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">v2 ships — tool team re-tunes</text>
  <line x1="535" y1="144" x2="535" y2="164" stroke="var(--success)" stroke-width="1.5" marker-end="url(#arr3)"/>
  <text x="535" y="182" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">You get improvements for free</text>
  <text x="535" y="226" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">AI gets smarter over time</text>
  <rect x="0" y="298" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cursor, Copilot, Claude Code teams benchmark prompts for every model release. Overriding their defaults means fighting work already done for you.</div>

<!-- Speaker: The key mental shift. The moment you override tool defaults, you've taken on the prompt-maintenance burden that a full team was handling for you. -->

---

## เขียน CLAUDE.md แบบ Lean

<p class="subhead">Treat it as a contractor onboarding doc — only what they can't infer from reading the codebase</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="align-items:stretch;">
  <div class="card success">
    <p class="label">Include — Factual</p>
    <h3>What AI Cannot Know</h3>
    <p>Project purpose, tech stack, non-standard file structure, forbidden patterns specific to your codebase.</p>
    <p><b>Target: under 500 words total</b></p>
  </div>
  <div class="card danger">
    <p class="label">Remove — Behavioral</p>
    <h3>What AI Already Knows</h3>
    <p>Persona injections, step-by-step reasoning prompts, psychological tricks, generic "be careful" instructions — anything written for GPT-3 era.</p>
  </div>
  <div class="card gold">
    <p class="label">The Acid Test</p>
    <h3>Delete &amp; Observe</h3>
    <p>ถามตัวเองว่า "ถ้าลบบรรทัดนี้ทิ้ง AI จะทำงานได้แย่ลงจริงไหม?" ถ้าไม่แน่ใจ — ลบ แล้วสังเกต 1 สัปดาห์ Add back เฉพาะสิ่งที่พิสูจน์ได้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Every token in CLAUDE.md is consumed before any real work begins — the 500-word limit forces you to keep only facts the AI genuinely can't infer.</div>

<!-- Speaker: The 500-word target is the threshold where every instruction fits in working memory. Above that: you have a brain dump, not an onboarding doc. -->

---

## Session Hygiene: Reset Context Rot

<p class="subhead">3 คำสั่งที่ป้องกัน context rot ระหว่าง session — ต้นทุนต่ำ ผลลัพธ์สูง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="align-items:stretch;">
  <div class="card">
    <p class="label">Command 1</p>
    <h3><code>/clear</code></h3>
    <p>Wipes entire conversation history. Use before switching to an unrelated task — prevents debug context from bleeding into new work.</p>
    <p><b>Before /clear:</b> Write 1 sentence: current goal + where you left off.</p>
  </div>
  <div class="card">
    <p class="label">Command 2</p>
    <h3><code>/compact</code></h3>
    <p>AI summarizes conversation into token-efficient digest. Use for long productive sessions — continue working without losing progress.</p>
    <p><b>Result:</b> Verbose history replaced with compressed summary.</p>
  </div>
  <div class="card gold">
    <p class="label">Habit</p>
    <h3>Pre-summarize</h3>
    <p>Before /clear: "Working on auth flow, fixed JWT refresh bug, next: rate limiting." Paste as first message in new session.</p>
    <p><b>Cost:</b> 30 seconds. <b>Benefit:</b> AI starts with full context.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /clear + pre-summarize costs 30 seconds and prevents hours of degraded AI quality — cheapest anti-debt tool available.</div>

<!-- Speaker: Most developers never /clear. They work in one session all day, wonder why AI got weird by afternoon. Context rot, not model failure. -->

---

## Key Takeaways

<p class="subhead">Prompt debt is manageable — once you know what to look for</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="align-items:stretch;">
  <div class="card danger compact">
    <p class="label">The Core Problem</p>
    <h3>Silent Decay</h3>
    <p>Prompt debt fails without errors. Every model upgrade silently degrades configs written for older models — no alert, no stack trace, no CI failure.</p>
  </div>
  <div class="card warning compact">
    <p class="label">The Hidden Source</p>
    <h3>Plugin &amp; File Bloat</h3>
    <p>MCP servers, skills, and unused plugins consume context before work begins. Installed-but-unused = hidden tax on every session.</p>
  </div>
  <div class="card success compact">
    <p class="label">The Fix</p>
    <h3>Stay Stock, Stay Lean</h3>
    <p>Trust the tool team's system prompts. Keep CLAUDE.md under 500 words. Include only what AI can't infer from the codebase itself.</p>
  </div>
  <div class="card gold compact">
    <p class="label">The Habit</p>
    <h3>Audit + /clear + /compact</h3>
    <p>Regular prompt audit (delete and observe), /clear between tasks, /compact for long sessions — the 3-command anti-debt toolkit.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The acid test for every instruction: "Will AI actually work worse if I delete this?" Delete everything you're not sure about — add back only what you can prove.</div>

<!-- Speaker: That question is the key. Most instructions fail it. Delete liberally, add back conservatively — prompt debt fights back only through your attachment to old instructions. -->
