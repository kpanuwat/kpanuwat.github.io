---
marp: true
theme: default
paginate: true
title: "MiroFish: Swarm Intelligence for Future Prediction"
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
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# MiroFish: Swarm Intelligence Engine ที่จำลองสังคมเสมือนเพื่อพยากรณ์อนาคต

<p class="tag">Agent AI นับพัน — ถกเถียงกัน — emergent behavior บอกอนาคต</p>

<!-- Speaker: MiroFish ไม่ใช่ AI ที่ตอบคำถาม แต่เป็น engine ที่สร้างสังคมดิจิทัลแล้วสังเกตว่าอะไรจะเกิดขึ้น สร้างใน 10 วัน ติด #1 GitHub Trending ระดมทุน $4.1M ใน 24 ชั่วโมง -->

---

## Traditional AI Forecasting มีจุดอ่อนร่วมกัน

<p class="subhead">Statistical models วิเคราะห์ตัวเลขในอดีต — แต่ไม่ได้จำลองพฤติกรรมมนุษย์</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: Traditional vs MiroFish -->
  <rect x="30" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 1px 2px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="490" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="275" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Traditional Forecasting</text>
  <text x="70" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Approach: Time-series / Regression</text>
  <text x="70" y="135" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Data: Historical numbers</text>
  <text x="70" y="165" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Output: Point estimate</text>
  <text x="70" y="195" font-size="14" fill="var(--muted)" font-family="system-ui">Validation: Backtested</text>
  <text x="70" y="225" font-size="14" fill="var(--muted)" font-family="system-ui">Cost: Compute-efficient</text>
  <text x="70" y="275" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Best for: Price, demand, numeric trends</text>
  <rect x="580" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="580" y="20" width="490" height="52" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="825" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">MiroFish (Swarm Sim)</text>
  <text x="620" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Approach: Simulates society</text>
  <text x="620" y="135" font-size="14" fill="var(--ink)" font-family="system-ui">Data: Unstructured text seed</text>
  <text x="620" y="165" font-size="14" fill="var(--ink)" font-family="system-ui">Output: Emergent distribution</text>
  <text x="620" y="195" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Validation: No published benchmark</text>
  <text x="620" y="225" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Cost: High API token usage</text>
  <text x="620" y="275" font-size="13" fill="var(--accent)" font-family="system-ui">Best for: Policy, opinion, narrative</text>
  <circle cx="555" cy="185" r="26" fill="var(--accent)"/>
  <text x="555" y="190" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> MiroFish แก้ blind spot ที่ statistical models มองไม่เห็น — collective human behavior</div>

<!-- Speaker: Traditional models ดีมากสำหรับ numeric forecasting แต่ถ้า event ขึ้นอยู่กับ social dynamics, opinion shifts, coalition formation — ต้องการ approach ที่ต่างออกไป -->

---

## MiroFish Pipeline: 5 ขั้นตอนจาก Seed สู่ Prediction

<p class="subhead">Data seeds a knowledge graph → agents are born → they debate → ReportAgent synthesizes</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow 6 nodes horizontal -->
  <!-- Node 1: Seed Data -->
  <rect x="20" y="120" width="148" height="90" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="20" y="120" width="148" height="6" rx="3" fill="var(--muted)"/>
  <text x="94" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Seed Data</text>
  <text x="94" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">News / Reports</text>
  <text x="94" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Policy Docs</text>
  <!-- Arrow 1 -->
  <path d="M168 165 L188 165" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="188,160 198,165 188,170" fill="var(--muted)"/>
  <!-- Node 2: Knowledge Graph -->
  <rect x="198" y="120" width="148" height="90" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="198" y="120" width="148" height="6" rx="3" fill="var(--accent)"/>
  <text x="272" y="155" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Knowledge</text>
  <text x="272" y="173" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Graph</text>
  <text x="272" y="196" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">GraphRAG</text>
  <!-- Arrow 2 -->
  <path d="M346 165 L366 165" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="366,160 376,165 366,170" fill="var(--muted)"/>
  <!-- Node 3: Agent Setup -->
  <rect x="376" y="120" width="148" height="90" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="376" y="120" width="148" height="6" rx="3" fill="var(--accent)"/>
  <text x="450" y="155" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Agent Setup</text>
  <text x="450" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Personas + Memory</text>
  <text x="450" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1000s unique</text>
  <!-- Arrow 3 -->
  <path d="M524 165 L544 165" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="544,160 554,165 544,170" fill="var(--muted)"/>
  <!-- Node 4: Simulation -->
  <rect x="554" y="100" width="148" height="130" rx="10" fill="var(--accent)" stroke="var(--accent-deep)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="628" y="135" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Simulation</text>
  <text x="628" y="158" font-size="11" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">OASIS Engine</text>
  <text x="628" y="178" font-size="11" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Twitter + Reddit</text>
  <text x="628" y="198" font-size="11" fill="rgba(255,255,255,.7)" text-anchor="middle" font-family="system-ui">Parallel debate</text>
  <text x="628" y="218" font-size="10" fill="rgba(255,255,255,.6)" text-anchor="middle" font-family="system-ui">Up to 1M agents</text>
  <!-- Arrow 4 -->
  <path d="M702 165 L722 165" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="722,160 732,165 722,170" fill="var(--muted)"/>
  <!-- Node 5: ReportAgent -->
  <rect x="732" y="120" width="148" height="90" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="732" y="120" width="148" height="6" rx="3" fill="var(--success)"/>
  <text x="806" y="155" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ReportAgent</text>
  <text x="806" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Synthesizes results</text>
  <text x="806" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Structured report</text>
  <!-- Arrow 5 -->
  <path d="M880 165 L900 165" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="900,160 910,165 900,170" fill="var(--muted)"/>
  <!-- Node 6: Deep Interaction -->
  <rect x="910" y="120" width="168" height="90" rx="10" fill="var(--gold)" opacity=".15" stroke="var(--gold)" stroke-width="1.5"/>
  <rect x="910" y="120" width="168" height="6" rx="3" fill="var(--gold)"/>
  <text x="994" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Deep Interaction</text>
  <text x="994" y="175" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Talk to agents</text>
  <text x="994" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">What-if injection</text>
  <!-- Step labels -->
  <text x="94" y="235" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Stage 1</text>
  <text x="272" y="235" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Stage 1</text>
  <text x="450" y="235" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Stage 2</text>
  <text x="628" y="250" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Stage 3</text>
  <text x="806" y="235" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">Stage 4</text>
  <text x="994" y="235" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Stage 5</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 5 ขั้นตอน: Seed → Knowledge Graph → Agents → Simulation (OASIS) → Report → Deep Interaction</div>

<!-- Speaker: แต่ละ stage สำคัญ — อธิบายว่า Simulation คือ heart ของระบบ OASIS engine รองรับ 1M agents -->

---

## Stage 1: GraphRAG สร้าง Knowledge Graph จาก Seed

<p class="subhead">ต่างจาก plain RAG — GraphRAG เก็บ entity-relationship ทำให้ agents รู้ว่า "ใครเกี่ยวข้องกับใคร"</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: plain RAG vs GraphRAG -->
  <rect x="30" y="20" width="470" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="20" width="470" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="265" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Plain RAG</text>
  <!-- nodes: text chunks -->
  <circle cx="160" cy="180" r="36" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="160" y="184" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Chunk A</text>
  <circle cx="280" cy="130" r="36" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="280" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Chunk B</text>
  <circle cx="380" cy="220" r="36" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="380" y="224" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Chunk C</text>
  <line x1="196" y1="166" x2="244" y2="144" stroke="var(--muted)" stroke-width="1" stroke-dasharray="4,3"/>
  <line x1="316" y1="154" x2="344" y2="196" stroke="var(--muted)" stroke-width="1" stroke-dasharray="4,3"/>
  <text x="265" y="300" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Similarity-only, no structure</text>

  <rect x="590" y="20" width="470" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="590" y="20" width="470" height="52" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="825" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">GraphRAG (MiroFish)</text>
  <!-- entity nodes -->
  <circle cx="720" cy="160" r="38" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="720" y="155" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Person</text>
  <text x="720" y="172" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Entity</text>
  <circle cx="850" cy="110" r="38" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="850" y="105" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Company</text>
  <text x="850" y="122" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Entity</text>
  <circle cx="920" cy="220" r="38" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="920" y="215" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Event</text>
  <text x="920" y="232" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Entity</text>
  <!-- labeled edges -->
  <line x1="758" y1="143" x2="812" y2="127" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="788" y="128" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">works-at</text>
  <line x1="886" y1="140" x2="902" y2="184" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="910" y="168" font-size="10" fill="var(--accent)" font-family="system-ui">caused</text>
  <line x1="748" y1="190" x2="890" y2="213" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="820" y="213" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">reacted-to</text>
  <text x="825" y="300" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Structured context — who relates to whom</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> GraphRAG ทำให้ Agent รู้ว่า "Person A เคยทำงานให้ Company B ซึ่งแข่งกับ C" — ไม่ใช่แค่ text similarity</div>

<!-- Speaker: นี่คือ foundation ของ simulation — ถ้า knowledge graph ไม่ดี agents จะมี world model ที่ผิดตั้งแต่ต้น -->

---

## Stage 2: Agent Architecture — แต่ละตัวไม่เหมือนกัน

<p class="subhead">ทุก agent มี 4 layer ของ identity ที่สร้างจาก knowledge graph</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Layer 1</p>
    <h3>Personality Traits</h3>
    <p>Background, initial stance, decision logic ที่ unique — ไม่มี 2 agents ที่เหมือนกัน</p>
  </div>
  <div class="card success">
    <p class="label">Layer 2</p>
    <h3>Long-term Memory</h3>
    <p>จัดการโดย <b>Zep Cloud</b> — จำ interactions ข้ามรอบ simulation, อัปเดต belief แบบ persistent</p>
  </div>
  <div class="card gold">
    <p class="label">Layer 3</p>
    <h3>Social Network</h3>
    <p>ความสัมพันธ์และ influence weight กับ agent อื่น — บางคนมี reach สูงกว่า</p>
  </div>
  <div class="card warning">
    <p class="label">Layer 4</p>
    <h3>23 Social Actions</h3>
    <p>post, comment, like, follow, quote-reply, <b>opinion-shift</b> — ครบ lifecycle ของ social behavior</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Memory + personality + network = agents ที่มี emergent behavior จริง ไม่ใช่แค่ random responses</div>

<!-- Speaker: Layer ที่สำคัญที่สุดคือ Memory — ทำให้ agent "เติบโต" ข้ามรอบแทนที่จะ reset ทุกครั้ง -->

---

## Stage 3: OASIS Engine — 1M Agents ใน Dual-Platform

<p class="subhead">Open Agent Social Interaction Simulations จาก CAMEL-AI — peer-reviewed, replicates real social phenomena</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- OASIS center, two platforms left/right, phenomena below -->
  <!-- Center circle: OASIS -->
  <circle cx="550" cy="165" r="72" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <circle cx="550" cy="165" r="72" fill="none" stroke="var(--accent-deep)" stroke-width="2"/>
  <text x="550" y="155" font-size="18" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">OASIS</text>
  <text x="550" y="175" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Engine</text>
  <text x="550" y="193" font-size="11" fill="rgba(255,255,255,.65)" text-anchor="middle" font-family="system-ui">Up to 1M agents</text>
  <!-- Left: Twitter-like -->
  <rect x="60" y="100" width="380" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="60" y="100" width="380" height="6" rx="3" fill="var(--muted)"/>
  <text x="250" y="132" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Twitter-like Platform</text>
  <text x="250" y="156" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Short posts, reactions, trending</text>
  <text x="250" y="176" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Fast opinion spread</text>
  <text x="250" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Herd effects visible here</text>
  <!-- Arrow left -->
  <path d="M440 155 L478 155" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="478,150 488,155 478,160" fill="var(--accent)"/>
  <!-- Right: Reddit-like -->
  <rect x="660" y="100" width="380" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="660" y="100" width="380" height="6" rx="3" fill="var(--muted)"/>
  <text x="850" y="132" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Reddit-like Platform</text>
  <text x="850" y="156" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Threaded debate, argumentation</text>
  <text x="850" y="176" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Coalition formation</text>
  <text x="850" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Polarization dynamics</text>
  <!-- Arrow right -->
  <path d="M612 155 L650 155" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="650,150 660,155 650,160" fill="var(--accent)"/>
  <!-- Bottom: phenomena -->
  <text x="550" y="280" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Replicates documented phenomena: information propagation, group polarization, herd effects</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OASIS ไม่ใช่แค่ chat simulator — มัน replicate social phenomena ที่ peer-reviewed researchers ยืนยันแล้ว</div>

<!-- Speaker: Dual-platform design คือ key insight — Twitter สำหรับ fast propagation, Reddit สำหรับ deep debate; คล้ายกับที่เกิดจริงใน social media -->

---

## Stage 4: ReportAgent — AI ที่วิเคราะห์ผลการจำลอง

<p class="subhead">ไม่ใช่ summary — ReportAgent "สัมภาษณ์" agents และวิเคราะห์ dynamics ของ simulation</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- hierarchy-tree: ReportAgent → 4 output types -->
  <!-- Root: Simulation Results -->
  <rect x="390" y="20" width="320" height="60" rx="10" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="550" y="45" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Simulation Results</text>
  <text x="550" y="66" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Opinion shifts, coalitions, narratives</text>
  <!-- Connector down to ReportAgent -->
  <line x1="550" y1="80" x2="550" y2="120" stroke="var(--muted)" stroke-width="2"/>
  <!-- ReportAgent -->
  <rect x="390" y="120" width="320" height="60" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="550" y="145" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ReportAgent</text>
  <text x="550" y="167" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Specialized AI analyzer</text>
  <!-- Branches to 4 outputs -->
  <line x1="550" y1="180" x2="550" y2="210" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="160" y1="210" x2="940" y2="210" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="160" y1="210" x2="160" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="393" y1="210" x2="393" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="706" y1="210" x2="706" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="940" y1="210" x2="940" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Output 1 -->
  <rect x="60" y="240" width="200" height="70" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="160" y="263" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Key Outcomes</text>
  <text x="160" y="282" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Probabilities</text>
  <text x="160" y="300" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Weighted scenarios</text>
  <!-- Output 2 -->
  <rect x="293" y="240" width="200" height="70" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="393" y="263" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Emerging Trends</text>
  <text x="393" y="282" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Behavioral insights</text>
  <text x="393" y="300" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Narrative dominance</text>
  <!-- Output 3 -->
  <rect x="606" y="240" width="200" height="70" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="706" y="263" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Possible Risks</text>
  <text x="706" y="282" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Scenario variations</text>
  <text x="706" y="300" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Downside analysis</text>
  <!-- Output 4 -->
  <rect x="840" y="240" width="200" height="70" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="940" y="263" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Signal Monitor</text>
  <text x="940" y="282" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">30-90 day indicators</text>
  <text x="940" y="300" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Track actual trajectory</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ReportAgent ผลิต 4 outputs: outcomes + probabilities, trends, risks, signal monitors</div>

<!-- Speaker: Signal monitor คือ unique feature — บอกว่า "ดู indicator ไหนใน 30-90 วัน" เพื่อ verify ว่า simulation ถูก -->

---

## Stage 5: Deep Interaction — God's-Eye View

<p class="subhead">Feature ที่ทำให้ MiroFish ต่างจากทุก prediction tool — user เข้าไปในสังคมจำลองได้เลย</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- flowchart-decision: user → probe/inject → insight -->
  <!-- User box -->
  <rect x="40" y="120" width="160" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="120" y="155" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User</text>
  <text x="120" y="176" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(God Mode)</text>
  <!-- Arrow to decision -->
  <path d="M200 160 L260 160" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="260,155 270,160 260,165" fill="var(--muted)"/>
  <!-- Decision diamond -->
  <polygon points="370,120 470,160 370,200 270,160" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="370" y="155" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Action</text>
  <text x="370" y="173" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">type?</text>
  <!-- Branch 1: Talk to Agent -->
  <path d="M370 120 L370 60 L600 60" stroke="var(--accent)" stroke-width="1.5" fill="none"/>
  <polygon points="600,55 610,60 600,65" fill="var(--accent)"/>
  <rect x="610" y="30" width="240" height="60" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="730" y="57" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Talk to Agent</text>
  <text x="730" y="77" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Ask "why did you change?"</text>
  <text x="490" y="52" font-size="11" fill="var(--accent)" font-family="system-ui">probe</text>
  <!-- Branch 2: Ask ReportAgent -->
  <path d="M470 160 L610 160" stroke="var(--success)" stroke-width="1.5" fill="none"/>
  <polygon points="610,155 620,160 610,165" fill="var(--success)"/>
  <rect x="620" y="130" width="240" height="60" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="740" y="157" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Ask ReportAgent</text>
  <text x="740" y="177" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"What if X happened instead?"</text>
  <text x="545" y="152" font-size="11" fill="var(--success)" font-family="system-ui">query</text>
  <!-- Branch 3: Inject variable -->
  <path d="M370 200 L370 270 L610 270" stroke="var(--warning)" stroke-width="1.5" fill="none"/>
  <polygon points="610,265 620,270 610,275" fill="var(--warning)"/>
  <rect x="620" y="240" width="240" height="60" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="740" y="267" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Inject Variable</text>
  <text x="740" y="287" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Add new event mid-simulation</text>
  <text x="490" y="262" font-size="11" fill="var(--warning-ink)" font-family="system-ui">inject</text>
  <!-- Outcomes converge right -->
  <path d="M860 60 L940 60 L940 160" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <path d="M860 160 L940 160" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <path d="M860 270 L940 270 L940 160" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <polygon points="935,170 940,160 945,170" fill="var(--muted)"/>
  <rect x="940" y="120" width="140" height="80" rx="10" fill="var(--ink)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="1010" y="153" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Deeper</text>
  <text x="1010" y="173" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Insight</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Deep Interaction เปลี่ยน prediction tool เป็น interactive world — สอบถาม, inject, ทดสอบ what-if ได้ไม่จำกัด</div>

<!-- Speaker: นี่คือ unique value prop ของ MiroFish — ไม่ใช่แค่อ่านรายงาน แต่ "อยู่ใน" simulation -->

---

## Use Cases: จากการเงินถึง Narrative Forecasting

<p class="subhead">5 domains ที่ MiroFish ให้ insight แบบที่ traditional models ทำไม่ได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact">
    <p class="label">Finance</p>
    <h3>Trading &amp; Markets</h3>
    <p>Inject Fed announcement → simulate investor reactions → predict sentiment &amp; volatility</p>
  </div>
  <div class="card compact success">
    <p class="label">Policy</p>
    <h3>Law Impact</h3>
    <p>Simulate citizen/media/lobbyist reactions → find unexpected alliances หรือ blockers</p>
  </div>
  <div class="card compact gold">
    <p class="label">Marketing</p>
    <h3>Crisis PR</h3>
    <p>ทดสอบว่า brand crisis unfold อย่างไรบน social media ก่อน launch จริง</p>
  </div>
  <div class="card compact warning">
    <p class="label">Personal</p>
    <h3>Decisions</h3>
    <p>Career change, relocation, partnership — predict social fallout ก่อนตัดสินใจ</p>
  </div>
  <div class="card compact">
    <p class="label">Creative</p>
    <h3>Narrative</h3>
    <p>Simulate character interactions → predict story arcs หรือ missing chapters</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก use case มีจุดร่วม — ผลลัพธ์ขึ้นอยู่กับ collective human behavior ไม่ใช่ numeric trend</div>

<!-- Speaker: Finance use case ที่ hype มากที่สุด แต่ validation ยังไม่มี benchmark — ใช้เป็น ideation tool ดีกว่า trading signal -->

---

## Setup: ติดตั้งและ Config ใน 3 ขั้นตอน

<p class="subhead">Node.js + Python + LLM API key (OpenAI-compatible) — Qwen recommended for cost</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-step arrow-flow horizontal -->
  <rect x="30" y="80" width="300" height="140" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="80" width="300" height="6" rx="3" fill="var(--accent)"/>
  <text x="180" y="120" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1. Clone + Install</text>
  <text x="180" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">git clone + npm install</text>
  <text x="180" y="165" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ pip install -r requirements.txt</text>
  <text x="180" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">node &gt;= 18, python &gt;= 3.8</text>
  <!-- Arrow -->
  <path d="M330 150 L370 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="370,145 380,150 370,155" fill="var(--muted)"/>
  <rect x="380" y="80" width="320" height="140" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="380" y="80" width="320" height="6" rx="3" fill="var(--accent)"/>
  <text x="540" y="120" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Configure .env</text>
  <text x="540" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">LLM_API_KEY + ZEP_API_KEY</text>
  <text x="540" y="165" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">AGENT_COUNT=50 (start small!)</text>
  <text x="540" y="200" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Qwen = cheaper than GPT-4o</text>
  <!-- Arrow -->
  <path d="M700 150 L740 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="740,145 750,150 740,155" fill="var(--muted)"/>
  <rect x="750" y="80" width="310" height="140" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="750" y="80" width="310" height="6" rx="3" fill="var(--success)"/>
  <text x="905" y="120" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">3. npm run dev</text>
  <text x="905" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">localhost:3000 → New Simulation</text>
  <text x="905" y="165" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5-10 rounds, 50-100 agents</text>
  <text x="905" y="200" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Wait ~2-5 min for KG generation</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย 50-100 agents / 5-10 rounds เสมอ — 1,000 agents × 40 rounds = ~200M tokens</div>

<!-- Speaker: Cost table ในบล็อก: 50 agents ≈ $0.05/round, 5,000 agents ≈ $5/round — scale เร็วมาก -->

---

## Caveats: 4 ข้อจำกัดที่ต้องรู้ก่อนใช้

<p class="subhead">MiroFish เป็น early-stage prototype (v0.1.2) — ทรงพลัง แต่มี real limitations</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Validation Gap</p>
    <h3>ไม่มี Benchmark</h3>
    <p>ยังไม่มี published research ที่ verify ว่า MiroFish accurate กว่า traditional methods — outcome ขึ้นอยู่กับ seed data และ prompt framing อย่างมาก</p>
  </div>
  <div class="card warning">
    <p class="label">Cost Trap</p>
    <h3>API Tokens สูงมาก</h3>
    <p>ทุก agent interaction = 1 LLM call — 1,000 agents × 40 rounds = ~200M tokens Zep Cloud free tier หมดเร็วมาก</p>
  </div>
  <div class="card warning">
    <p class="label">Bias</p>
    <h3>LLM Bias Amplification</h3>
    <p>Agents สืบทอด bias จาก LLM — อาจ amplify polarization หรือ herd behavior เกินความเป็นจริง ห้าม interpret เป็น ground truth</p>
  </div>
  <div class="card">
    <p class="label">Security + Platform</p>
    <h3>Enterprise Concerns</h3>
    <p>Origin: Chinese open-source, docs ภาษาจีน บาง org มีข้อกังวล security v0.1.2 optimize สำหรับ macOS เท่านั้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ MiroFish เป็น exploration/ideation tool — ไม่ใช่ prediction oracle หรือ trading signal</div>

<!-- Speaker: Validation gap คือ biggest risk — ระวัง over-confidence จาก simulation results ที่ดูน่าเชื่อถือ -->

---

## Key Takeaways: MiroFish ใน 8 ประโยค

<p class="subhead">จาก paradigm shift สู่ cost trap — สิ่งที่ต้องจำจากทั้ง deck</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Paradigm</p>
    <h3>Digital Society ≠ Statistics</h3>
    <p>สร้าง emergent behavior จาก agent interactions — ไม่ใช่ regression บนข้อมูลตัวเลข</p>
  </div>
  <div class="card">
    <p class="label">Pipeline</p>
    <h3>5-Stage Flow</h3>
    <p>GraphRAG → Agent Setup → OASIS Simulation → ReportAgent → Deep Interaction</p>
  </div>
  <div class="card gold">
    <p class="label">Killer Feature</p>
    <h3>Deep Interaction</h3>
    <p>สอบถาม agent รายบุคคล, inject what-if variables กลาง simulation ได้ทันที</p>
  </div>
  <div class="card danger">
    <p class="label">Risk</p>
    <h3>Cost + Validation</h3>
    <p>Scale ช้า เริ่ม 50-100 agents เสมอ ไม่มี benchmark = ใช้เป็น ideation tool ไม่ใช่ oracle</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Built in 10 days, 33K+ GitHub stars, $4.1M in 24h — MiroFish พิสูจน์ว่า "Swarm Sim for forecasting" เป็น idea ที่โลกรอคอย</div>

<!-- Speaker: จบด้วย context ของ creator — นักศึกษาอายุ 20 สร้างใน 10 วัน สิ่งที่ impressive ไม่ใช่ funding แต่คือ concept ที่ disruptive -->
