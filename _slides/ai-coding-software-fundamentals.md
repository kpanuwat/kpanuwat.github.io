---
marp: true
theme: default
paginate: true
title: "Software Fundamentals in the AI Era"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:16px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# ทักษะพื้นฐานซอฟต์แวร์ในยุค AI

<p class="tag">Software Fundamentals Matter More Than Ever — Matt Pocock @ AI Engineer Europe 2026</p>

<!-- Speaker: Matt Pocock (TypeScript educator) argues vibe coding destroys codebases. 5 strategies: entropy awareness, design concept, ubiquitous language, deep modules, TDD. -->

---

## Code is NOT Cheap — Bad Code Blocks AI from Working

<p class="subhead">The "specs-to-code" movement assumes code is cheap — Pocock shows every isolated prompt degrades the codebase.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="110" width="160" height="64" rx="10" fill="var(--accent)"/>
  <text x="110" y="137" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Vibe Coding</text>
  <text x="110" y="159" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Isolated Prompt</text>

  <rect x="255" y="110" width="160" height="64" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="335" y="137" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">No Global</text>
  <text x="335" y="159" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design View</text>

  <rect x="480" y="110" width="160" height="64" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="560" y="137" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Entropy</text>
  <text x="560" y="159" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Accumulates</text>

  <rect x="705" y="110" width="160" height="64" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="785" y="137" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Hard-to-Change</text>
  <text x="785" y="159" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Codebase</text>

  <rect x="925" y="110" width="145" height="64" rx="10" fill="var(--danger)"/>
  <text x="998" y="137" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">AI Fails</text>
  <text x="998" y="159" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Re-Prompt Loop</text>

  <line x1="190" y1="142" x2="252" y2="142" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="249,137 262,142 249,147" fill="var(--muted)"/>
  <line x1="415" y1="142" x2="477" y2="142" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="474,137 487,142 474,147" fill="var(--muted)"/>
  <line x1="640" y1="142" x2="702" y2="142" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="699,137 712,142 699,147" fill="var(--warning)"/>
  <line x1="865" y1="142" x2="922" y2="142" stroke="var(--danger)" stroke-width="2"/>
  <polygon points="919,137 932,142 919,147" fill="var(--danger)"/>

  <path d="M 998 174 Q 998 250 560 250 Q 180 250 110 174" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,4"/>
  <polygon points="104,172 110,185 117,172" fill="var(--danger)"/>
  <text x="560" y="244" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">worse with every loop</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Bad code in the AI era is more expensive than ever — it prevents AI from working well in the codebase.</div>

<!-- Speaker: Pocock's core thesis: code is NOT cheap. AI does well in good codebases, fails in bad ones. The loop is self-reinforcing. -->

---

## Software Entropy: 3 Conditions That Accelerate It

<p class="subhead">From The Pragmatic Programmer: entropy is the natural drift toward disorder — AI-era prompting makes it worse.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Trigger 1</p>
    <h3>Isolated Prompts</h3>
    <p>แก้แต่ "สิ่งที่เห็น" โดยไม่คิดถึง design ภาพรวม ทุก prompt ทำให้ระบบ inconsistent ขึ้นทีละนิด</p>
  </div>
  <div class="card warning">
    <p class="label">Trigger 2</p>
    <h3>No Shared Model</h3>
    <p>ไม่มี mental model ร่วมกันระหว่างนักพัฒนาและ AI — AI เดาสิ่งที่คุณต้องการ และมักเดาผิด</p>
  </div>
  <div class="card">
    <p class="label">Consequence</p>
    <h3>Complexity Lock-out</h3>
    <p>ระบบยากต่อการเข้าใจและแก้ไข (Ousterhout) → AI ทำงานได้แย่ลงเรื่อยๆ จนถึงจุดที่แก้ไม่ได้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Every change made without thinking about the whole system makes the codebase progressively worse — this is exactly what Pocock observed with specs-to-code.</div>

<!-- Speaker: Two books: The Pragmatic Programmer (entropy) + A Philosophy of Software Design (complexity). Same root cause. -->

---

## Shared Design Concept: Fix the #1 AI Failure Mode

<p class="subhead">Fred Brooks (The Design of Design): the "design concept" is an invisible theory — when developer and AI don't share it, AI builds the wrong thing.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="480" height="260" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--danger-wash)"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">No Shared Concept</text>
  <text x="70" y="105" font-size="13" fill="var(--ink)" font-family="system-ui">Developer has one vision in mind</text>
  <text x="70" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">AI interprets prompt differently</text>
  <text x="70" y="165" font-size="13" fill="var(--danger)" font-family="system-ui">AI builds the wrong thing</text>
  <text x="70" y="195" font-size="13" fill="var(--danger)" font-family="system-ui">Re-prompt, patch, entropy grows</text>
  <text x="70" y="225" font-size="12" fill="var(--muted)" font-family="system-ui">Most common AI coding failure mode</text>

  <rect x="590" y="20" width="480" height="260" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--success-wash)"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Shared Concept (Grill Me)</text>
  <text x="630" y="105" font-size="13" fill="var(--ink)" font-family="system-ui">Use "Grill Me" skill first</text>
  <text x="630" y="135" font-size="13" fill="var(--ink)" font-family="system-ui">AI asks 40-100 questions</text>
  <text x="630" y="165" font-size="13" fill="var(--success-ink)" font-family="system-ui">Both sides share design concept</text>
  <text x="630" y="195" font-size="13" fill="var(--success-ink)" font-family="system-ui">AI builds exactly what's needed</text>
  <text x="630" y="225" font-size="12" fill="var(--success-ink)" font-family="system-ui">13,000+ stars — "went viral"</text>

  <circle cx="550" cy="150" r="26" fill="var(--accent)"/>
  <text x="550" y="155" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Run "Grill Me" before every new feature — let AI interview you relentlessly until you both share the same design concept.</div>

<!-- Speaker: The prompt: "Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree." -->

---

## Ubiquitous Language Cuts AI Verbosity and Hallucination

<p class="subhead">DDD concept applied to AI: a shared vocabulary markdown file makes AI use exact domain terms instead of guessing.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Without Vocabulary File</p>
    <h3>Ambiguous Communication</h3>
    <p>AI เดาความหมายของ business term → generate code ที่ใช้ term ผิด หรือ verbose เกินไป</p>
    <ul>
      <li>AI thinking traces ยาวและวกวน</li>
      <li>Implementation ไม่ตรง domain model</li>
      <li>Business term hallucination สูง</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">With Vocabulary File</p>
    <h3>Precise Domain Vocabulary</h3>
    <p>Feed markdown file ให้ AI ทุกครั้งที่ plan → AI ใช้ term ถูกต้อง consistent ทุก output</p>
    <ul>
      <li>AI thinking traces สั้นและชัดขึ้น</li>
      <li>Code consistent กับ domain model</li>
      <li>Hallucination เรื่อง business term ลดลง</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Create a project vocabulary markdown file (Order vs Cart, SKU vs Product) and feed it to AI at planning time — it dramatically reduces verbosity and misalignment.</div>

<!-- Speaker: Example: Order != Cart. SKU != Product. The vocabulary file is the "single source of truth" for domain terms between human and AI. -->

---

## Deep Modules: Give AI Clear Boundaries to Implement Within

<p class="subhead">Ousterhout: simple interface hiding massive functionality — the architecture AI works best with. AI's natural output is the opposite.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Shallow Module (AI Default Output)</p>
    <h3>Complex Interface, Simple Inside</h3>
    <p>AI มักสร้าง shallow modules — small code blobs with tangled dependencies ที่ navigate ไม่ออก</p>
    <ul>
      <li>Interface ซับซ้อน หลาย parameter</li>
      <li>Dependencies interconnected รก</li>
      <li>AI navigate ไม่ออก → สร้าง bug</li>
      <li>Unit test ยาก เพราะ boundary ไม่ชัด</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Deep Module (Target Design)</p>
    <h3>Simple Interface, Complex Inside</h3>
    <p>Developer ออกแบบ interface → AI implement ภายใน "grey box" — ประหยัด cognitive energy ทั้งคู่</p>
    <ul>
      <li>Interface เรียบง่าย ชัดเจน</li>
      <li>Complexity encapsulated ข้างใน</li>
      <li>AI รู้ขอบเขต → output ตรงเป้า</li>
      <li>Unit test ง่าย → AI ได้ feedback ชัด</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design the external interface (the "grey box") yourself — then delegate all internal implementation to AI. You save cognitive energy; AI gets clear scope.</div>

<!-- Speaker: Grey box strategy: developer as architect of the what, AI as implementer of the how. Deep modules also make TDD trivial. -->

---

## TDD Prevents AI from Outrunning Its Headlights

<p class="subhead">"Outrunning headlights": AI generates large chunks at once, errors compound with no root cause. TDD forces small deliberate steps.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="200" cy="150" r="85" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="200" y="138" font-size="22" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">RED</text>
  <text x="200" y="162" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Write test first</text>
  <text x="200" y="182" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Define expectation</text>

  <circle cx="550" cy="150" r="85" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="550" y="138" font-size="22" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">GREEN</text>
  <text x="550" y="162" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AI makes test pass</text>
  <text x="550" y="182" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">One small step</text>

  <circle cx="900" cy="150" r="85" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="900" y="138" font-size="19" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">REFACTOR</text>
  <text x="900" y="162" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI cleans code</text>
  <text x="900" y="182" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Developer reviews</text>

  <line x1="287" y1="130" x2="463" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="460,125 474,130 460,135" fill="var(--muted)"/>
  <line x1="637" y1="130" x2="813" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="810,125 824,130 810,135" fill="var(--muted)"/>

  <path d="M 900 65 Q 550 10 200 65" stroke="var(--accent)" stroke-width="1.5" fill="none" stroke-dasharray="6,4"/>
  <polygon points="194,58 200,72 206,58" fill="var(--accent)"/>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> TDD + Deep Modules is the strongest combo — simple module boundaries make tests trivial to write, giving AI precise feedback to produce better code.</div>

<!-- Speaker: TDD workflow with AI: 1. Developer defines test spec. 2. AI writes test. 3. AI verifies RED. 4. AI implements GREEN. 5. AI refactors. 6. Developer reviews. -->

---

## Cheatsheet: All 5 Concepts at a Glance

<p class="subhead">Software Fundamentals Matter More Than Ever — your one-page reference for AI-era engineering.</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-coding-software-fundamentals-cheatsheet.png" alt="5-concept cheatsheet: Entropy, Shared Design Concept, Ubiquitous Language, Deep Modules, TDD with AI">
<figcaption>Source: NotebookLM · Software Fundamentals for the AI Era — Matt Pocock @ AI Engineer Europe 2026</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pin this as your daily reference — run through these 5 concepts before any significant AI coding session.</div>

<!-- Speaker: Cheatsheet summarizing all 5 strategies. Walk through each panel. -->

---

## Be the Strategic Architect, Not the Vibe Coder

<p class="subhead">Your software skills — not your prompt skills — decide whether AI-assisted development succeeds long-term.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact danger">
    <p class="label">Entropy</p>
    <h3>Code is NOT Cheap</h3>
    <p>Bad code ขัดขวาง AI → แพงกว่าที่เคย ใน AI era</p>
  </div>
  <div class="card compact">
    <p class="label">Design Concept</p>
    <h3>Grill Me First</h3>
    <p>ให้ AI interview developer ก่อนเขียนโค้ดทุกครั้ง</p>
  </div>
  <div class="card compact warning">
    <p class="label">DDD</p>
    <h3>Ubiquitous Language</h3>
    <p>Vocabulary file ลด verbosity และ hallucination</p>
  </div>
  <div class="card compact success">
    <p class="label">Architecture</p>
    <h3>Deep Modules</h3>
    <p>Simple interface → AI มี boundary ชัดเจน + TDD ง่าย</p>
  </div>
  <div class="card gold" style="grid-column:1/-1;padding:14px 18px;">
    <p class="label">The Role Shift</p>
    <h3>From Code Writer to Strategic Architect</h3>
    <p>TDD + Deep Modules = feedback loop ที่ดีที่สุดสำหรับ AI code quality — บทบาทนักพัฒนาไม่หายไป แต่เปลี่ยนจาก "คนเขียนโค้ด" เป็น "สถาปนิกที่ควบคุม AI ด้วยหลักการพื้นฐาน"</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Software fundamentals are now more critical than ever — they are what allow AI to work at its best.</div>

<!-- Speaker: The developer role evolves: you are the architect, AI is the implementation engine. Fundamentals decide who wins. -->
