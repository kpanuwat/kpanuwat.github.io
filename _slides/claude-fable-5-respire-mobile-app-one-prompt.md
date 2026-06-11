---
marp: true
theme: default
paginate: true
title: "Claude Fable 5 สร้าง Mobile App ได้ในพรอมต์เดียว"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/claude-fable-5-respire-mobile-app-one-prompt-cover.png)

<div class="mark"></div>

# Claude Fable 5 สร้าง Mobile App ในพรอมต์เดียว

<p class="tag">เฟรมเวิร์ก AGENT + Hermes Telegram = APK บนมือถือใน 30 นาที</p>

<!-- Speaker: Claude Fable 5 collapsed the entire mobile dev workflow into a single inference session. This deck shows the framework and tools that made it possible. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/claude-fable-5-respire-mobile-app-one-prompt-cheatsheet.png)

<!-- Speaker: One-page reference — AGENT framework, Respire features, Hermes flow, token cost table. We'll go deep on each zone. -->

---

## TL;DR: หนึ่งพรอมต์ → APK บนมือถือ

<p class="subhead">Claude Fable 5 สร้าง Respire ใน ~30 นาที — features ครบโดยไม่ได้ขอทั้งหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="40" width="200" height="260" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="140" y="95" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ONE PROMPT</text>
  <text x="140" y="120" font-size="24" text-anchor="middle" font-family="system-ui" fill="var(--accent)">+</text>
  <text x="140" y="155" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">AGENT contract</text>
  <text x="140" y="175" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">via /goal</text>
  <text x="140" y="255" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~30 min</text>
  <path d="M248 170 L308 170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)" fill="none"/>
  <defs><marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/></marker></defs>
  <rect x="316" y="40" width="200" height="260" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="416" y="95" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">RESPIRE APP</text>
  <text x="416" y="125" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Box Breathing animation</text>
  <text x="416" y="148" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Coherent Flow wave anim.</text>
  <text x="416" y="171" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sound effects</text>
  <text x="416" y="194" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Filter + Favorites UX</text>
  <text x="416" y="217" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">APK — install on Android</text>
  <path d="M524 170 L584 170" stroke="var(--success)" stroke-width="2.5" marker-end="url(#arr2)" fill="none"/>
  <defs><marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--success)"/></marker></defs>
  <rect x="592" y="40" width="460" height="260" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="822" y="90" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">KEY INSIGHT</text>
  <rect x="622" y="108" width="400" height="160" rx="8" fill="var(--paper)" stroke="var(--success)" stroke-width="1" opacity=".6"/>
  <text x="822" y="145" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Claude decided which animation</text>
  <text x="822" y="168" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">fits each technique itself</text>
  <text x="822" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">UX features not in the prompt:</text>
  <text x="822" y="222" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">filter levels + favorites system</text>
  <text x="822" y="265" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">second prompt: rename "Halakon" to "Respire"</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> One prompt + 30 min = installable Android app with premium UX — including features nobody asked for.</div>

<!-- Speaker: The name Claude chose, "Halakon," had to be changed in a 2nd prompt. That's the only correction made. Everything else shipped. -->

---

## The Old Way vs The New Way

![bg right:40% contain](assets/claude-fable-5-respire-mobile-app-one-prompt-background.png)

<p class="subhead">Mobile app dev used to need a team; now needs a well-crafted prompt.</p>

<div class="infographic">
<svg viewBox="0 0 700 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="300" height="240" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="20" width="300" height="44" rx="12" fill="var(--danger-wash)"/>
  <text x="170" y="48" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Before: Traditional Dev</text>
  <text x="40" y="88" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Dev team + designer + QA</text>
  <text x="40" y="112" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Weeks to months</text>
  <text x="40" y="136" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Boilerplate + toolchain setup</text>
  <text x="40" y="160" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Animation libs to integrate</text>
  <text x="40" y="184" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Build pipeline configuration</text>
  <text x="40" y="232" font-size="11" fill="var(--muted)" font-family="system-ui">Barrier: high cost + expertise</text>
  <rect x="360" y="20" width="310" height="240" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="360" y="20" width="310" height="44" rx="12" fill="var(--accent)"/>
  <text x="515" y="48" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">After: Fable 5 One-Shot</text>
  <text x="380" y="88" font-size="12" fill="var(--ink)" font-family="system-ui">One person with a prompt</text>
  <text x="380" y="112" font-size="12" fill="var(--ink)" font-family="system-ui">~30 minutes</text>
  <text x="380" y="136" font-size="12" fill="var(--ink)" font-family="system-ui">Single inference session</text>
  <text x="380" y="160" font-size="12" fill="var(--ink)" font-family="system-ui">AI designs animations itself</text>
  <text x="380" y="184" font-size="12" fill="var(--ink)" font-family="system-ui">APK ready to install</text>
  <text x="380" y="232" font-size="11" fill="var(--accent)" font-family="system-ui">Barrier: knowing how to prompt well</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The barrier shifted from technical skill to prompt skill — who can build changed fundamentally.</div>

<!-- Speaker: The key shift is NOT just speed. It's who can ship. Non-programmers can now produce installable apps. -->

---

## Respire: 5 Features Built from One Prompt

<p class="subhead">Claude auto-generated UX features that were never specified — shows emergent design judgment.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="gap:10px;">
  <div class="card success">
    <p class="label">Animation</p>
    <h3>Per-Technique Visuals</h3>
    <p>Box Breathing and Coherent Flow each have a unique animation. Claude chose which visual fits each technique — not prompted.</p>
  </div>
  <div class="card">
    <p class="label">Sensory</p>
    <h3>Sound Effects</h3>
    <p>Audio cues guide the breathing cycle. No screen-watching needed during practice.</p>
  </div>
  <div class="card gold">
    <p class="label">Emergent UX</p>
    <h3>Filter + Favorites</h3>
    <p>Intermediate/advanced filtering and a favorites system appeared without being requested — Fable 5 inferred them from context.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Fable 5 doesn't just follow specs — it infers missing UX from product context.</div>

<!-- Speaker: The favorites and filter system were emergent — Claude reasoned that any meditation app worth using needs them. This is design judgment, not code generation. -->

---

## AGENT: เฟรมเวิร์ก 5 ส่วนที่ควบคุม Claude

<p class="subhead">Prompt contract ที่ออกแบบมาสำหรับ /goal command — บอกทั้ง what AND when to stop</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5" style="gap:8px;">
  <div class="card compact">
    <p class="label">A</p>
    <h3>Ask</h3>
    <p>Clear request: what, which platform, output format. "Build mobile breathing app, export APK."</p>
  </div>
  <div class="card compact success">
    <p class="label">G</p>
    <h3>Goal</h3>
    <p>Stop condition: Claude works until app built, transferred, tested on emulator. No mid-session pauses.</p>
  </div>
  <div class="card compact gold">
    <p class="label">E</p>
    <h3>Examples</h3>
    <p>Design pegs for quality bar. "Headspace/Calm polish — but original, not copied."</p>
  </div>
  <div class="card compact danger">
    <p class="label">N</p>
    <h3>Negations</h3>
    <p>Hard constraints. "No generic timer, no medical claims, no cloud login for MVP."</p>
  </div>
  <div class="card compact warning">
    <p class="label">T</p>
    <h3>Tools</h3>
    <p>Recommended stack. "React Native, Expo EAS, Flutter — pick fastest to APK."</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AGENT works because it specifies the exit condition (G) and what NOT to do (N) — both are missing from most prompts.</div>

<!-- Speaker: Most prompts only have Ask and maybe Examples. Goal and Negations are what make Fable 5 run autonomously to completion. -->

---

## Negations: ทำไมถึงสำคัญกว่า Requirements

<p class="subhead">LLMs มี default priors ที่แข็งแกร่ง — Negations เป็นวิธีเดียวที่ override ได้ตรงจุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="480" height="300" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="30" width="480" height="52" rx="14" fill="var(--danger-wash)"/>
  <text x="280" y="62" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Without Negations</text>
  <text x="60" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">Prompt: "Build a breathing app"</text>
  <rect x="60" y="122" width="440" height="2" rx="1" fill="var(--soft-2)"/>
  <text x="60" y="152" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Claude defaults to: generic countdown timer</text>
  <text x="60" y="178" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Model pulls from most common training patterns</text>
  <text x="60" y="204" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Safe, standard, forgettable UX</text>
  <text x="60" y="280" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Result: app looks like every other timer app</text>
  <rect x="580" y="30" width="480" height="300" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="580" y="30" width="480" height="52" rx="14" fill="var(--success)"/>
  <text x="820" y="62" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">With Negations (AGENT N)</text>
  <text x="600" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">Adds: "No generic timer UI"</text>
  <rect x="600" y="122" width="440" height="2" rx="1" fill="var(--success-wash)"/>
  <text x="600" y="152" font-size="12" fill="var(--ink)" font-family="system-ui">Claude forced out of high-probability defaults</text>
  <text x="600" y="178" font-size="12" fill="var(--ink)" font-family="system-ui">Explores tail: unique per-technique animations</text>
  <text x="600" y="204" font-size="12" fill="var(--ink)" font-family="system-ui">Infers: what would actually be good here?</text>
  <text x="600" y="280" font-size="12" fill="var(--success-ink)" font-family="system-ui">Result: custom wave + box animations per practice</text>
  <circle cx="542" cy="180" r="32" fill="var(--accent)"/>
  <text x="542" y="186" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Negations force the model off its safest defaults — that's where premium, original design lives.</div>

<!-- Speaker: This is the single most underused technique in prompt engineering. Describing what you want is not enough; you must explicitly block the boring paths. -->

---

## Hermes: สร้าง AGENT Prompt บนมือถือขณะเดินทาง

![bg right:40% contain](assets/claude-fable-5-respire-mobile-app-one-prompt-hermes.png)

<p class="subhead">Hermes agent บน Telegram sync กับ Claude Code — craft prompt ได้ทุกที่</p>

<div class="infographic">
<svg viewBox="0 0 700 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="70" cy="140" r="44" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="70" y="136" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">vague</text>
  <text x="70" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">idea</text>
  <path d="M118 140 L168 140" stroke="var(--muted)" stroke-width="2" marker-end="url(#a1)" fill="none"/>
  <defs><marker id="a1" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/></marker></defs>
  <rect x="176" y="96" width="120" height="88" rx="10" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="236" y="133" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">align skill</text>
  <text x="236" y="153" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3 clarifying</text>
  <text x="236" y="170" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">questions</text>
  <path d="M304 140 L354 140" stroke="var(--muted)" stroke-width="2" marker-end="url(#a2)" fill="none"/>
  <defs><marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/></marker></defs>
  <rect x="362" y="96" width="130" height="88" rx="10" fill="var(--gold)" opacity=".15" stroke="var(--gold)" stroke-width="1.5"/>
  <text x="427" y="130" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">agent-goal</text>
  <text x="427" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">skill</text>
  <text x="427" y="165" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">formats AGENT</text>
  <path d="M500 140 L550 140" stroke="var(--success)" stroke-width="2" marker-end="url(#a3)" fill="none"/>
  <defs><marker id="a3" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--success)"/></marker></defs>
  <rect x="558" y="96" width="120" height="88" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="618" y="130" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Claude</text>
  <text x="618" y="148" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Code</text>
  <text x="618" y="166" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/goal runs</text>
  <text x="350" y="220" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Hermes + Claude Code share second brain workspace</text>
  <rect x="30" y="238" width="640" height="1" rx="1" fill="var(--soft-2)"/>
  <text x="350" y="258" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">same context, skills, memory — no duplication</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Hermes + Claude Code share the same second brain — a vague Telegram message becomes a full AGENT contract automatically.</div>

<!-- Speaker: The creator sent a casual Telegram message while traveling, Hermes asked 3 questions, then produced the full prompt. No keyboard needed for the heavy lifting. -->

---

## Token Cost: Pro vs Max 20x

<p class="subhead">Building a full app is token-intensive — plan before you start</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="460" height="290" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="30" width="460" height="52" rx="14" fill="var(--danger-wash)"/>
  <text x="270" y="62" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Pro Plan</text>
  <text x="60" y="112" font-size="13" fill="var(--ink)" font-family="system-ui">1 app build = quota exhausted</text>
  <text x="60" y="142" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Risk: hit limit mid-session</text>
  <text x="60" y="170" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Mitigation: set Effort Low first</text>
  <rect x="70" y="196" width="400" height="44" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="270" y="222" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Build early in billing cycle</text>
  <rect x="580" y="30" width="480" height="290" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="580" y="30" width="480" height="52" rx="14" fill="var(--success)"/>
  <text x="820" y="62" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Max 20x Plan</text>
  <text x="600" y="112" font-size="13" fill="var(--ink)" font-family="system-ui">1 app = 3–5% weekly rate limit</text>
  <text x="600" y="142" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Can build ~20 apps per week</text>
  <text x="600" y="170" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Effort Low still recommended</text>
  <rect x="610" y="196" width="420" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="820" y="222" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">MVP quality at Effort Low confirmed</text>
  <rect x="40" y="255" width="1020" height="52" rx="10" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="276" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Both plans: set Effort Low before large builds</text>
  <text x="550" y="298" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/effort low  then  /goal [AGENT contract]</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Effort Low doesn't reduce quality for MVP builds — it reduces reasoning tokens. Always set it before a full app session.</div>

<!-- Speaker: The creator verified that Effort Low produced Respire successfully. The quality bar for an MVP is met; it's only extended reasoning that's cut. -->

---

## Caveats: MVP ≠ Production-Ready

<p class="subhead">One-shot builds are impressive starting points — not finished products</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="gap:12px;">
  <div class="card danger">
    <p class="label">Deploy Limit</p>
    <h3>APK is Sideload-Only</h3>
    <p>Not a signed release build. Requires "Unknown Sources" on Android. Play Store submission needs signing, store listing, and compliance review.</p>
  </div>
  <div class="card warning">
    <p class="label">Quality Gap</p>
    <h3>MVP Has No Safety Net</h3>
    <p>No error handling audit, no accessibility review, no performance profiling. Ship to users = additional engineering work required.</p>
  </div>
  <div class="card warning">
    <p class="label">Naming Risk</p>
    <h3>Claude-Generated Names</h3>
    <p>"Halakon" came from training data — may collide with existing trademarks. Always trademark-search any AI-generated app name.</p>
  </div>
  <div class="card">
    <p class="label">Setup Note</p>
    <h3>Hermes is Custom</h3>
    <p>Telegram + Claude Code integration is the creator's personal setup. AGENT framework is transferable; the Hermes agent is not out-of-the-box.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> One-shot = excellent validated prototype; production shipping still needs signing, QA, and compliance work.</div>

<!-- Speaker: Be honest about what one-shot produces. It's a proof of concept that works on your phone. It's not ready for 10,000 users. -->

---

## Key Takeaways

<p class="subhead">What to carry away from this demo and framework</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="160" r="148" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="160" r="98" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="160" r="52" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="160" r="52" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="153" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AGENT</text>
  <text x="550" y="172" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">framework</text>
  <text x="360" y="82" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Negations</text>
  <text x="360" y="100" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">most powerful N</text>
  <text x="750" y="82" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Goal stops</text>
  <text x="750" y="100" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">agentic loop</text>
  <text x="200" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Hermes</text>
  <text x="200" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">mobile crafting</text>
  <text x="900" y="160" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Effort Low</text>
  <text x="900" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">token guard</text>
  <text x="360" y="238" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">30 min APK</text>
  <text x="750" y="238" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MVP only</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AGENT framework + /goal + Effort Low = repeatable one-shot mobile app pipeline for anyone, not just developers.</div>

<!-- Speaker: The core insight is that Negations are the unlock. Everything else is infrastructure around that one insight. -->
