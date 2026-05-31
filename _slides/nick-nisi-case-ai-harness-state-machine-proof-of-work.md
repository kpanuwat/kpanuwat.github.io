---
marp: true
theme: default
paginate: true
title: "Case AI Harness: State Machine + Proof of Work"
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

# Case AI Harness

<p class="tag">State Machine + Proof of Work — Nick Nisi @ WorkOS</p>

<!-- Speaker: Nick Nisi built an AI harness that stops agents from lying by requiring cryptographic proof of work. 11 slides. -->

---

## Three Numbers That Changed Everything

<p class="subhead">ลบ Skills 95% → accuracy +20% และ eval time -91% — วัดก่อนเชื่อ อย่า assume ว่า more context = better</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Skill Reduction</p>
    <h3>95% Deleted</h3>
    <p>10,000+ lines → 553 lines of targeted gotchas — counter-intuitive but measured</p>
  </div>
  <div class="card">
    <p class="label">Accuracy</p>
    <h3>77% → 97%</h3>
    <p>Removing bloated skills raised task accuracy by 20 points — skills were hurting</p>
  </div>
  <div class="card warning">
    <p class="label">Eval Speed</p>
    <h3>68 min → 6 min</h3>
    <p>91% faster — less noise means faster, cleaner measurement loops</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> More context actively hurt the model — only measurement revealed what intuition hid.</div>

<!-- Speaker: Open with the punchline. These numbers came from running evals, not from guessing. -->

---

## Prompts Alone Cannot Enforce Workflows

<p class="subhead">เพิ่ม prompt ยาวขึ้น = model หลงทางมากขึ้น — วิธีของ Nick คือบังคับด้วย Code แทน</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Prompt-heavy -->
  <rect x="30" y="20" width="470" height="280" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="470" height="50" rx="12" fill="var(--danger)" opacity=".15"/>
  <text x="265" y="51" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Prompt-Heavy Approach</text>
  <text x="60" y="100" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">Context drop: model forgets instructions</text>
  <text x="60" y="126" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">Agent skips steps by choice</text>
  <text x="60" y="152" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">touch case-tested = "tests passed"</text>
  <text x="60" y="178" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">10,000 lines, 68 min, 77% accuracy</text>
  <text x="60" y="218" font-size="12" fill="var(--muted)" font-family="system-ui,sans-serif" font-style="italic">Fix: add more instructions...</text>
  <text x="60" y="240" font-size="12" fill="var(--muted)" font-family="system-ui,sans-serif" font-style="italic">Fix: add even more instructions...</text>
  <text x="265" y="278" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui,sans-serif">Still failing</text>
  <!-- Right: Code-enforced -->
  <rect x="600" y="20" width="470" height="280" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="600" y="20" width="470" height="50" rx="12" fill="var(--success)" opacity=".12"/>
  <text x="835" y="51" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Code-Enforced Harness</text>
  <text x="630" y="100" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">State machine: skip is impossible</text>
  <text x="630" y="126" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">SHA-256 hash proves tests ran</text>
  <text x="630" y="152" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">Playwright video proves UI bug fixed</text>
  <text x="630" y="178" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">553 lines, 6 min, 97% accuracy</text>
  <text x="630" y="218" font-size="12" fill="var(--success-ink)" font-family="system-ui,sans-serif">Fail? Fix the harness once.</text>
  <text x="630" y="240" font-size="12" fill="var(--success-ink)" font-family="system-ui,sans-serif">Next run: won't repeat the mistake.</text>
  <text x="835" y="278" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui,sans-serif">Reliable + measurable</text>
  <!-- VS badge -->
  <circle cx="550" cy="158" r="30" fill="var(--accent)"/>
  <text x="550" y="163" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui,sans-serif">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Prompts tell agents what to do — code makes it physically impossible to do otherwise.</div>

<!-- Speaker: The left is where most teams start and stay. The right is what Nick built after measuring. -->

---

## Gates Enforce What Prompts Never Could

<p class="subhead">5 agents ใน TypeScript state machine — สิ่งสำคัญไม่ใช่ agents แต่คือ gates ที่ code บังคับ</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5 boxes: w=158 h=58 y=115 -->
  <!-- Implementer x=20 -->
  <rect x="20" y="115" width="158" height="58" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="99" y="141" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui,sans-serif">Implementer</text>
  <text x="99" y="160" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui,sans-serif">fixes code</text>
  <!-- Arrow 1: 180 -> 215, gate at 197 -->
  <line x1="180" y1="144" x2="213" y2="144" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="207,139 215,144 207,149" fill="var(--accent)"/>
  <polygon points="197,136 204,144 197,152 190,144" fill="var(--warning)"/>
  <!-- Verifier x=218 -->
  <rect x="218" y="115" width="158" height="58" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="297" y="141" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,sans-serif">Verifier</text>
  <text x="297" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">checks evidence</text>
  <!-- Arrow 2: 378 -> 413, gate at 395 -->
  <line x1="378" y1="144" x2="411" y2="144" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="405,139 413,144 405,149" fill="var(--accent)"/>
  <polygon points="395,136 402,144 395,152 388,144" fill="var(--warning)"/>
  <!-- Reviewer x=416 -->
  <rect x="416" y="115" width="158" height="58" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="495" y="141" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,sans-serif">Reviewer</text>
  <text x="495" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">code quality</text>
  <!-- Arrow 3: 576 -> 611, gate at 593 -->
  <line x1="576" y1="144" x2="609" y2="144" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="603,139 611,144 603,149" fill="var(--accent)"/>
  <polygon points="593,136 600,144 593,152 586,144" fill="var(--warning)"/>
  <!-- Closer x=614 -->
  <rect x="614" y="115" width="158" height="58" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="693" y="141" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,sans-serif">Closer</text>
  <text x="693" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">PR + evidence</text>
  <!-- Arrow 4: 774 -> 809, gate at 791 -->
  <line x1="774" y1="144" x2="807" y2="144" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="801,139 809,144 801,149" fill="var(--accent)"/>
  <polygon points="791,136 798,144 791,152 784,144" fill="var(--warning)"/>
  <!-- Retro x=812 -->
  <rect x="812" y="115" width="158" height="58" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="891" y="141" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Retro</text>
  <text x="891" y="160" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui,sans-serif">learns + memory</text>
  <!-- Feedback loop: Reviewer top (495,114) up to y=65, left to Implementer (99,65), down to (99,114) -->
  <line x1="495" y1="114" x2="495" y2="68" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="495" y1="68" x2="99" y2="68" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="99" y1="68" x2="99" y2="112" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <polygon points="94,108 99,116 104,108" fill="var(--danger)"/>
  <text x="300" y="58" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui,sans-serif">review fails: back to Implementer</text>
  <!-- Gate legend -->
  <polygon points="28,255 35,263 28,271 21,263" fill="var(--warning)"/>
  <text x="44" y="267" font-size="11" fill="var(--ink-dim)" font-family="system-ui,sans-serif">Gate (code-enforced — cannot skip)</text>
  <!-- Task input -->
  <text x="99" y="102" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">Task / Issue</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Gates คือนวัตกรรมจริง — ไม่ใช่ agents แต่คือ code ที่ทำให้การข้ามขั้นตอนเป็นไปไม่ได้</div>

<!-- Speaker: State machine owns the workflow. The model only owns the work inside each agent. Gates are non-negotiable. -->

---

## SHA-256 Proof: Made Lying Physically Impossible

<p class="subhead">Agent แค่ touch file แล้วบอก "รันแล้ว" — hash verification ทำให้ต้องรัน test จริงเท่านั้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5 steps horizontal: w=170 h=110 y=80 -->
  <!-- Step 1 -->
  <rect x="20" y="80" width="170" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="105" y="108" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,sans-serif">1. Run Tests</text>
  <text x="105" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">Agent executes</text>
  <text x="105" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">full test suite</text>
  <text x="105" y="175" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,sans-serif">$ npm test</text>
  <!-- Arrow 1 -->
  <line x1="192" y1="135" x2="218" y2="135" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="212,130 220,135 212,140" fill="var(--accent)"/>
  <!-- Step 2 -->
  <rect x="222" y="80" width="170" height="110" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="307" y="108" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui,sans-serif">2. SHA-256 Hash</text>
  <text x="307" y="130" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui,sans-serif">hash the actual</text>
  <text x="307" y="148" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui,sans-serif">test output</text>
  <text x="307" y="175" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui,sans-serif">a3f9...b82c</text>
  <!-- Arrow 2 -->
  <line x1="394" y1="135" x2="420" y2="135" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="414,130 422,135 414,140" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="424" y="80" width="170" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="509" y="108" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,sans-serif">3. Save Hash</text>
  <text x="509" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">write to</text>
  <text x="509" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">case-tested</text>
  <text x="509" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,sans-serif">file: a3f9...b82c</text>
  <!-- Arrow 3 -->
  <line x1="596" y1="135" x2="622" y2="135" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="616,130 624,135 616,140" fill="var(--accent)"/>
  <!-- Step 4 -->
  <rect x="626" y="80" width="170" height="110" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="711" y="104" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">4. Verifier</text>
  <text x="711" y="122" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Re-runs Tests</text>
  <text x="711" y="144" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">independent run</text>
  <text x="711" y="175" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">$ npm test</text>
  <!-- Arrow 4 -->
  <line x1="798" y1="135" x2="824" y2="135" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="818,130 826,135 818,140" fill="var(--accent)"/>
  <!-- Step 5: hash match -->
  <rect x="828" y="80" width="252" height="110" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="954" y="104" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">5. Hash Match?</text>
  <!-- PASS box -->
  <rect x="846" y="118" width="80" height="28" rx="6" fill="var(--success)"/>
  <text x="886" y="137" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui,sans-serif">PASS</text>
  <text x="886" y="112" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">match</text>
  <!-- FAIL box -->
  <rect x="982" y="118" width="80" height="28" rx="6" fill="var(--danger)"/>
  <text x="1022" y="137" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui,sans-serif">FAIL</text>
  <text x="1022" y="112" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">mismatch</text>
  <!-- fork lines from step5 center to PASS/FAIL -->
  <line x1="954" y1="116" x2="886" y2="116" stroke="var(--success)" stroke-width="1" stroke-dasharray="3,2"/>
  <line x1="954" y1="116" x2="1022" y2="116" stroke="var(--danger)" stroke-width="1" stroke-dasharray="3,2"/>
  <!-- bottom note -->
  <text x="954" y="220" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">touch case-tested != proof</text>
  <text x="954" y="238" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,sans-serif">only real run output hash matches</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> การรัน test จริงกลายเป็นสิ่งที่ทำได้ง่ายกว่าการโกหก — นั่นคือหลักการออกแบบ</div>

<!-- Speaker: Nick's rule: make it easier to just do the real work than to fake it. The hash is the unforgeable proof. -->

---

## 95% Fewer Skills, 20% Better Results

<p class="subhead">Evals พิสูจน์ว่า skill ที่ "ครอบคลุม" กำลังรบกวน model — ลบออก 95% ให้ผลดีขึ้นทันที</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Before -->
  <rect x="30" y="20" width="470" height="270" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="265" y="52" font-size="17" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Before: 10,000+ Lines</text>
  <text x="60" y="95" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">Skills size:</text>
  <rect x="195" y="80" width="270" height="22" rx="4" fill="var(--danger)"/>
  <text x="476" y="96" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="end" font-family="system-ui,sans-serif">10,000 lines</text>
  <text x="60" y="145" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">Eval time:</text>
  <rect x="195" y="130" width="225" height="22" rx="4" fill="var(--danger)"/>
  <text x="431" y="146" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="end" font-family="system-ui,sans-serif">68 minutes</text>
  <text x="60" y="195" font-size="13" fill="var(--danger-ink)" font-family="system-ui,sans-serif">Accuracy:</text>
  <rect x="195" y="180" width="147" height="22" rx="4" fill="var(--danger)"/>
  <text x="353" y="196" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="end" font-family="system-ui,sans-serif">77%</text>
  <text x="60" y="248" font-size="12" fill="var(--muted)" font-family="system-ui,sans-serif" font-style="italic">More docs = more noise</text>
  <text x="60" y="268" font-size="12" fill="var(--muted)" font-family="system-ui,sans-serif" font-style="italic">= model on wild goose chase</text>
  <!-- Right: After -->
  <rect x="600" y="20" width="470" height="270" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="835" y="52" font-size="17" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">After: 553 Lines</text>
  <text x="630" y="95" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">Skills size:</text>
  <rect x="765" y="80" width="15" height="22" rx="4" fill="var(--success)"/>
  <text x="792" y="96" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui,sans-serif">553 lines (5%)</text>
  <text x="630" y="145" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">Eval time:</text>
  <rect x="765" y="130" width="20" height="22" rx="4" fill="var(--success)"/>
  <text x="797" y="146" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui,sans-serif">6 minutes</text>
  <text x="630" y="195" font-size="13" fill="var(--success-ink)" font-family="system-ui,sans-serif">Accuracy:</text>
  <rect x="765" y="180" width="185" height="22" rx="4" fill="var(--success)"/>
  <text x="961" y="196" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="end" font-family="system-ui,sans-serif">97%</text>
  <text x="630" y="248" font-size="12" fill="var(--success-ink)" font-family="system-ui,sans-serif" font-style="italic">Gotchas only = focused signal</text>
  <text x="630" y="268" font-size="12" fill="var(--success-ink)" font-family="system-ui,sans-serif" font-style="italic">= model stays on track</text>
  <!-- VS badge -->
  <circle cx="550" cy="155" r="30" fill="var(--accent)"/>
  <text x="550" y="160" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui,sans-serif">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า LLM รู้เรื่องนั้นอยู่แล้ว skill นั้นแค่เพิ่ม noise — วัดก่อนเพิ่ม skill ใดๆ เสมอ</div>

<!-- Speaker: This is counter-intuitive. More context caused the model to veer off course. Measuring exposed it. Less was literally better. -->

---

## Gotchas Only: Teach What Models Reliably Fail At

<p class="subhead">ลบ Documentation ที่ model รู้อยู่แล้ว — เหลือแค่จุดที่ model จะ fail อย่างน่าเชื่อถือเท่านั้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Skip These</p>
    <h3>General Docs</h3>
    <p>How to write TypeScript, React patterns, REST APIs — LLM already knows this. Adding it = noise that hurts.</p>
  </div>
  <div class="card warning">
    <p class="label">The Filter Test</p>
    <h3>"Does LLM know this?"</h3>
    <p>If yes and it matches your codebase → skip it. If yes but model uses wrong pattern for your project → keep as gotcha. Evals decide.</p>
  </div>
  <div class="card success">
    <p class="label">Keep Only</p>
    <h3>Reliable Failure Points</h3>
    <p>Next.js proxy redirect rules, phantom SDK methods LLMs hallucinate, project-specific conventions not in public docs.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Skills should teach surprises — evals measure whether each skill is additive or actively destructive.</div>

<!-- Speaker: Nick's filter: if the LLM already knows it and uses it correctly, adding a skill just wastes tokens and adds noise. -->

---

## Evals: Measure Before Trusting Anything

<p class="subhead">Nick ค้นพบ skill ที่ "ดี" กำลังทำให้ accuracy ลดลง 20% — ค้นพบได้ด้วย Evals เท่านั้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Hallucination Scoring System</p>
    <h3>Per-Penalty Scoring</h3>
    <p><strong>-5 pts</strong> per hallucinated SDK method (cap: -25 total)</p>
    <p><strong>+5 pts</strong> bonus for zero hallucinations in output</p>
    <p>Negation-aware: 30-char look-back for "don't", "avoid", "never", "anti-pattern" — warning = not a failure</p>
  </div>
  <div class="card success">
    <p class="label">Key Counter-Intuitive Finding</p>
    <h3>Skill Was Hurting</h3>
    <p>Task <em>with</em> specific skill: <strong>77% accuracy</strong></p>
    <p>Same task <em>without</em> that skill: <strong>97% accuracy</strong></p>
    <p>Without evals, this inversion is invisible — you would keep the skill indefinitely and never know why accuracy was low.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Non-deterministic systems require evals — never assume; always measure before adding or removing context.</div>

<!-- Speaker: The 77→97 jump happened by deleting a skill that intuitively seemed helpful. Only evals revealed the truth. -->

---

## Fix the Harness, Not the One-Off Code

<p class="subhead">เมื่อ agent ทำผิด อย่าแก้ code ครั้งนั้น — แก้ harness ให้ระบบไม่ทำผิดซ้ำอีก</p>

<div class="infographic">
<svg viewBox="0 0 1100 270" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4-node cycle: horizontal layout with return arc below -->
  <!-- Node 1: Failure x=30 -->
  <rect x="30" y="80" width="200" height="78" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="130" y="114" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Agent Failure</text>
  <text x="130" y="134" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">loop, stuck state</text>
  <text x="130" y="150" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui,sans-serif">wrong output</text>
  <!-- Arrow 1 -->
  <line x1="232" y1="119" x2="278" y2="119" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="272,114 280,119 272,124" fill="var(--accent)"/>
  <!-- Node 2: Retro Agent x=282 -->
  <rect x="282" y="80" width="200" height="78" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="382" y="111" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui,sans-serif">Retro Agent</text>
  <text x="382" y="131" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui,sans-serif">analyzes full run logs</text>
  <text x="382" y="149" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui,sans-serif">finds root cause</text>
  <!-- Arrow 2 -->
  <line x1="484" y1="119" x2="530" y2="119" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="524,114 532,119 524,124" fill="var(--accent)"/>
  <!-- Node 3: Memory File x=534 -->
  <rect x="534" y="80" width="200" height="78" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="634" y="111" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Lesson Saved</text>
  <text x="634" y="131" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">written to memory</text>
  <text x="634" y="149" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui,sans-serif">file per project</text>
  <!-- Arrow 3 -->
  <line x1="736" y1="119" x2="782" y2="119" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="776,114 784,119 776,124" fill="var(--accent)"/>
  <!-- Node 4: Next Run x=786 -->
  <rect x="786" y="80" width="200" height="78" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="886" y="111" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">Next Run</text>
  <text x="886" y="131" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">reads memory file</text>
  <text x="886" y="149" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">skips past roadblock</text>
  <!-- Return arc: below from Node4 back to Node1 -->
  <line x1="886" y1="160" x2="886" y2="210" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <line x1="886" y1="210" x2="130" y2="210" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <line x1="130" y1="210" x2="130" y2="162" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <polygon points="125,158 130,166 135,158" fill="var(--success)"/>
  <text x="510" y="228" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,sans-serif">harness improved — same failure will not repeat</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก failure คือ system bug — Retro agent เปลี่ยน mistakes ให้เป็น improvements แบบอัตโนมัติทุก run</div>

<!-- Speaker: This is the self-healing loop. Nick doesn't manually fix recurring mistakes — the retro agent does it for him, permanently. -->

---

## Case Harness: Complete Reference

<p class="subhead">Cheatsheet ครอบคลุม 6 แนวคิดหลัก — State Machine, Proof of Work, Skill Reduction, Gotchas, Evals, Harness Fixes</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/nick-nisi-case-ai-harness-state-machine-proof-of-work-cheatsheet.png" alt="Case AI Harness cheatsheet: state machine architecture, proof of work SHA-256, 95% skill reduction, gotchas approach, evals scoring, and harness-level fixes">
<figcaption>Source: NotebookLM · Case AI Harness — Nick Nisi @ WorkOS</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> บังคับด้วย Code, วัดด้วย Evals, แก้ที่ Harness — สามหลักการที่เปลี่ยน AI agent ให้เชื่อถือได้จริง</div>

<!-- Speaker: Six principles on one page. This is the architectural shift from asking the model nicely to building a system that enforces correctness. -->

---

## Build Systems, Not Just Prompts

<p class="subhead">หลัก 6 ข้อที่เปลี่ยนการเขียน AI agent จากการขอร้อง model เป็นการสร้างระบบที่วัดผลได้จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Principle 1</p>
    <h3>Code Enforces</h3>
    <p>State machine ทำให้ workflow ข้ามขั้นตอนไม่ได้ ไม่ว่า model จะตัดสินใจอย่างไร</p>
  </div>
  <div class="card success">
    <p class="label">Principle 2</p>
    <h3>Prove, Don't Trust</h3>
    <p>SHA-256 hash + Playwright video = หลักฐานที่ปลอมไม่ได้ แทนการเชื่อใจ model</p>
  </div>
  <div class="card warning">
    <p class="label">Principle 3</p>
    <h3>Less Skills = Better</h3>
    <p>10,000 → 553 lines; accuracy 77% → 97% — วัดก่อนเพิ่มหรือลบ skill ใดๆ เสมอ</p>
  </div>
  <div class="card gold">
    <p class="label">Principle 4</p>
    <h3>Gotchas Only</h3>
    <p>สอนเฉพาะสิ่งที่ model จะ fail อย่างน่าเชื่อถือ — ถ้า LLM รู้อยู่แล้ว skill นั้นแค่เพิ่ม noise</p>
  </div>
  <div class="card">
    <p class="label">Principle 5</p>
    <h3>Measure Always</h3>
    <p>Evals พิสูจน์ counter-intuitive findings — อย่า assume ว่า more context = better</p>
  </div>
  <div class="card success">
    <p class="label">Principle 6</p>
    <h3>Fix the Harness</h3>
    <p>ทุก agent failure คือ system bug — แก้ harness ครั้งเดียว Retro agent เรียนรู้ถาวร</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The shift: from "how do I prompt this better?" to "how do I build a system that can't fail this way?"</div>

<!-- Speaker: Pick one principle to implement this week. Start with evals — everything else flows from measurement. -->
