---
marp: true
theme: default
paginate: true
title: "Understand Anything vs Graphify: Knowledge Graph สำหรับ Codebase"
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
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Understand Anything vs Graphify

<p class="tag">เปรียบเทียบ Tools สร้าง Knowledge Graph สำหรับ Codebase — ประหยัด Token vs Dashboard สวยงาม</p>

<!-- Speaker: Two tools, one goal: turn your codebase into a queryable knowledge graph. Very different design philosophies. -->

---

## AI Agents อ่านโค้ดทีละไฟล์ — Scale ไม่ได้

<p class="subhead">Knowledge Graph pre-indexes the full codebase so AI queries the graph, not raw files.</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: problem → solution -->
  <!-- Step 1: Problem -->
  <rect x="40" y="120" width="200" height="120" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="140" y="166" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">AI Agent</text>
  <text x="140" y="188" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">reads file</text>
  <text x="140" y="208" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">by file</text>
  <!-- Arrow 1 -->
  <line x1="240" y1="180" x2="295" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="295,174 308,180 295,186" fill="var(--muted)"/>
  <!-- Step 2: Scale problem -->
  <rect x="308" y="120" width="200" height="120" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="408" y="166" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">500+ files</text>
  <text x="408" y="188" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">= massive</text>
  <text x="408" y="208" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">token cost</text>
  <!-- Arrow 2 -->
  <line x1="508" y1="180" x2="563" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="563,174 576,180 563,186" fill="var(--muted)"/>
  <!-- Step 3: KG solution -->
  <rect x="576" y="100" width="220" height="160" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2.5"/>
  <text x="686" y="154" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Knowledge</text>
  <text x="686" y="174" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Graph</text>
  <text x="686" y="200" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">pre-indexed</text>
  <text x="686" y="218" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">query-ready</text>
  <!-- Arrow 3 -->
  <line x1="796" y1="180" x2="851" y2="180" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="851,174 864,180 851,186" fill="var(--accent)"/>
  <!-- Step 4: Result -->
  <rect x="864" y="120" width="196" height="120" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="962" y="162" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Fast AI</text>
  <text x="962" y="182" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">answers</text>
  <text x="962" y="204" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">low token cost</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Knowledge Graph = codebase pre-indexed once, queried cheaply forever — both tools solve this differently.</div>

<!-- Speaker: Without KG, every AI query reads raw files. With KG, the graph is the index. -->

---

## Understand Anything: Multi-Agent Pipeline + Rich Dashboard

<p class="subhead">5 specialized agents build the graph; humans explore it through a visual browser dashboard.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Core Engine</p>
    <h3>5-Agent Pipeline</h3>
    <p>File Analyzer · Architecture Analyzer · Domain Mapper · Impact Analyzer · Tour Builder</p>
  </div>
  <div class="card">
    <p class="label">Dashboard</p>
    <h3>Interactive Graph</h3>
    <p>Parent/Child hierarchy, Architectural layers, Persona-Adaptive UI (PM / Junior / Senior)</p>
  </div>
  <div class="card gold">
    <p class="label">Unique Features</p>
    <h3>Domain View + Impact</h3>
    <p>/understand-diff — overlay ที่ highlight nodes กระทบเมื่อแก้ Code + Guided Tours</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Understand Anything ออกแบบมาให้ Human อ่าน Dashboard ได้จริง — เหมาะกับ Onboarding และ Project exploration.</div>

<!-- Speaker: Each agent has a specific job. The dashboard is the killer feature — PM can browse it without reading code. -->

---

## Graphify: Tree-sitter AST + 79x Token Savings

<p class="subhead">Local parsing does the heavy lifting; LLM only called for semantic meaning — most cost avoided.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-layer arrow flow: AST → Transcribe → LLM Semantic -->
  <!-- Layer 1 -->
  <rect x="40" y="80" width="280" height="180" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="180" y="128" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Layer 1: AST Parsing</text>
  <text x="180" y="152" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Tree-sitter (local)</text>
  <text x="180" y="172" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">FREE — 0 API tokens</text>
  <text x="180" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Code never leaves machine</text>
  <!-- Arrow -->
  <line x1="320" y1="170" x2="375" y2="170" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="375,164 388,170 375,176" fill="var(--muted)"/>
  <!-- Layer 2 -->
  <rect x="388" y="80" width="280" height="180" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="528" y="128" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Layer 2: Transcription</text>
  <text x="528" y="152" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">faster-whisper (local)</text>
  <text x="528" y="172" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Video/Audio — local</text>
  <text x="528" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Optional step</text>
  <!-- Arrow -->
  <line x1="668" y1="170" x2="723" y2="170" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="723,164 736,170 723,176" fill="var(--muted)"/>
  <!-- Layer 3 -->
  <rect x="736" y="80" width="324" height="180" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="898" y="128" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Layer 3: LLM Semantic</text>
  <text x="898" y="152" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Only for meaning — minimal</text>
  <text x="898" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Ollama / Bedrock / vLLM</text>
  <text x="898" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Leiden algo + God Nodes</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Layer 1 (AST) costs nothing — 90%+ of structure extracted locally. LLM budget goes only where semantics matter.</div>

<!-- Speaker: Tree-sitter parses the syntax tree without any API call. The LLM only gets called for the "why" not the "what". -->

---

## Dashboard: Understand Anything ชนะด้าน Human Readability

<p class="subhead">Both tools generate a graph — but designed for very different audiences.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col -->
  <rect x="40" y="20" width="490" height="300" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="40" y="20" width="490" height="52" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="285" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Understand Anything</text>
  <text x="80" y="108" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Parent/Child hierarchy</text>
  <text x="80" y="132" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Architectural layers visible</text>
  <text x="80" y="166" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Click node → explanation</text>
  <text x="80" y="190" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Plain English + Persona mode</text>
  <text x="80" y="224" font-size="14" font-weight="600" fill="var(--success-ink)" font-family="system-ui">Best for: Human browsing</text>
  <text x="80" y="248" font-size="13" fill="var(--muted)" font-family="system-ui">Onboarding, PM, exploration</text>
  <text x="80" y="286" font-size="12" fill="var(--danger-ink)" font-family="system-ui">⚠ May freeze &gt;3,000 nodes</text>
  <!-- VS badge -->
  <circle cx="550" cy="170" r="28" fill="var(--accent-deep)"/>
  <text x="550" y="175" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- Right panel -->
  <rect x="570" y="20" width="490" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="570" y="20" width="490" height="52" rx="12" fill="var(--soft-2)"/>
  <text x="815" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Graphify</text>
  <text x="610" y="108" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Neighbor nodes flat layout</text>
  <text x="610" y="132" font-size="13" fill="var(--ink-dim)" font-family="system-ui">No clear Parent/Child order</text>
  <text x="610" y="166" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">MCP query interface</text>
  <text x="610" y="190" font-size="13" fill="var(--ink-dim)" font-family="system-ui">query_graph, shortest_path</text>
  <text x="610" y="224" font-size="14" font-weight="600" fill="var(--success-ink)" font-family="system-ui">Best for: Machine queries</text>
  <text x="610" y="248" font-size="13" fill="var(--muted)" font-family="system-ui">Daily AI coding, large repos</text>
  <text x="610" y="286" font-size="12" fill="var(--success-ink)" font-family="system-ui">Stable at any codebase size</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pick Understand Anything when a human needs to browse the graph; pick Graphify when the AI does the querying.</div>

<!-- Speaker: The dashboard is Understand Anything's moat. Graphify's graph is machine-optimized — harder for humans to browse but fast for MCP queries. -->

---

## Graphify ประหยัด Token ได้ 71–79x

<p class="subhead">Tree-sitter extracts structure locally for free; LLM called only for semantics — a fraction of the total.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Bar chart comparison -->
  <!-- Y axis -->
  <line x1="120" y1="40" x2="120" y2="280" stroke="var(--soft-2)" stroke-width="2"/>
  <!-- X axis -->
  <line x1="120" y1="280" x2="1060" y2="280" stroke="var(--soft-2)" stroke-width="2"/>
  <!-- Y labels -->
  <text x="110" y="285" font-size="12" fill="var(--muted)" text-anchor="end" font-family="system-ui">0</text>
  <text x="110" y="205" font-size="12" fill="var(--muted)" text-anchor="end" font-family="system-ui">50k</text>
  <text x="110" y="125" font-size="12" fill="var(--muted)" text-anchor="end" font-family="system-ui">100k</text>
  <text x="110" y="45" font-size="12" fill="var(--muted)" text-anchor="end" font-family="system-ui">200k</text>
  <!-- Grid lines -->
  <line x1="120" y1="205" x2="1060" y2="205" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4,4"/>
  <line x1="120" y1="125" x2="1060" y2="125" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4,4"/>
  <!-- Understand Anything bar — 200k tokens = full height -->
  <rect x="200" y="45" width="280" height="235" rx="8" fill="var(--danger)" opacity=".75"/>
  <text x="340" y="38" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">~200,000 tokens</text>
  <text x="340" y="296" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Understand Anything</text>
  <!-- Graphify bar — ~2,500 tokens ≈ ~3px tall, show as tiny sliver + callout -->
  <rect x="680" y="277" width="280" height="3" rx="2" fill="var(--success)" opacity=".9"/>
  <!-- Callout pointing to tiny bar -->
  <line x1="820" y1="270" x2="820" y2="180" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="700" y="140" width="240" height="50" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="820" y="162" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">~2,500–3,500 tokens</text>
  <text x="820" y="182" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AST free + min LLM</text>
  <text x="820" y="296" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Graphify</text>
  <!-- Badge -->
  <rect x="860" y="60" width="180" height="52" rx="10" fill="var(--accent)" opacity=".9"/>
  <text x="950" y="82" font-size="18" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">71–79x</text>
  <text x="950" y="102" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">token savings</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Graphify's 79x savings come from Tree-sitter (free) doing the structural work — LLM budget spent only where meaning requires it.</div>

<!-- Speaker: This isn't micro-optimization. 200k vs 2.5k is the difference between blowing your monthly quota vs barely noticing the cost. -->

---

## Local Model Support: Graphify เท่านั้นที่รองรับ

<p class="subhead">For privacy-sensitive codebases, only Graphify keeps code off external APIs.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Understand Anything</p>
    <h3>Cloud API Only</h3>
    <p>ข้อมูล Codebase ถูกส่งไปยัง Model Provider ที่ IDE ผูกไว้ (Anthropic API, OpenAI, etc.)</p>
    <p>ไม่มี flag --backend หรือ option สำหรับ Local Model</p>
    <ul>
      <li>No Ollama support</li>
      <li>No Bedrock support</li>
      <li>No vLLM support</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Graphify</p>
    <h3>Local Model Ready</h3>
    <p>Code ถูก parse ด้วย Tree-sitter บนเครื่องเสมอ — Raw code ไม่ออกนอกเครื่องเลย</p>
    <p>LLM backend เลือกได้:</p>
    <ul>
      <li>--backend ollama (OLLAMA_BASE_URL)</li>
      <li>--backend bedrock (IAM auth)</li>
      <li>--backend vllm (self-hosted)</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Banking, Healthcare, Defense codebases — Graphify is the only option when code must stay on-premise.</div>

<!-- Speaker: The --backend flag is the key differentiator. IAM auth for Bedrock means zero API keys needed — uses your AWS credentials. -->

---

## Use Case Matrix: เมื่อไหร่ใช้ Tool ไหน

<p class="subhead">Both tools solve the same problem — different priorities determine the right choice.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Choose Understand Anything</p>
    <h3>Human-first exploration</h3>
    <ul>
      <li>Onboarding พนักงานใหม่หรือ PM</li>
      <li>ต้องการ Flowchart/Domain view ที่คลิกได้</li>
      <li>Small-to-medium codebase (&lt;3,000 nodes)</li>
      <li>ต้องการ Impact analysis หลัง code change</li>
      <li>Budget Token ไม่ใช่ปัญหาหลัก</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Choose Graphify</p>
    <h3>Machine-first querying</h3>
    <ul>
      <li>Large/Enterprise codebase</li>
      <li>Privacy-critical code (Banking, Healthcare)</li>
      <li>ทีมต้องการประหยัด Token/ลด Cost</li>
      <li>Self-hosted LLM (Ollama, Bedrock, vLLM)</li>
      <li>Multi-modal inputs (Code + PDF + Video)</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ได้ทั้งคู่พร้อมกัน — Understand Anything สำรวจ/Onboard, Graphify สำหรับ Daily AI queries ประหยัดต้นทุน.</div>

<!-- Speaker: They're not mutually exclusive. Use UA for onboarding week 1, switch to Graphify for daily coding assistant work. -->

---

## Install in 2 Commands: Both Tools

<p class="subhead">Skill-based install integrates directly with your IDE — one install, works across sessions.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Two column install guides -->
  <!-- Left: Understand Anything -->
  <rect x="40" y="20" width="490" height="280" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="490" height="48" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="285" y="50" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Understand Anything</text>
  <!-- Claude Code path -->
  <rect x="70" y="88" width="420" height="38" rx="6" fill="var(--soft)"/>
  <text x="90" y="112" font-size="12" fill="var(--ink)" font-family="monospace">/plugins install Lum1104/Understand-Anything</text>
  <!-- Script path -->
  <rect x="70" y="140" width="420" height="56" rx="6" fill="var(--soft)"/>
  <text x="90" y="162" font-size="11" fill="var(--ink-dim)" font-family="monospace">curl -fsSL ...install.sh | bash</text>
  <text x="90" y="184" font-size="11" fill="var(--ink-dim)" font-family="monospace">irm ...install.ps1 | iex  # Windows</text>
  <!-- Usage -->
  <rect x="70" y="212" width="420" height="62" rx="6" fill="var(--soft)"/>
  <text x="90" y="232" font-size="11" fill="var(--ink)" font-family="monospace">/understand       # build graph</text>
  <text x="90" y="252" font-size="11" fill="var(--ink)" font-family="monospace">/understand-explore  # open dashboard</text>
  <text x="90" y="272" font-size="11" fill="var(--ink)" font-family="monospace">/understand-diff  # impact analysis</text>
  <!-- Right: Graphify -->
  <rect x="570" y="20" width="490" height="280" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="570" y="20" width="490" height="48" rx="12" fill="var(--gold)" opacity=".1"/>
  <text x="815" y="50" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Graphify</text>
  <!-- Install -->
  <rect x="600" y="88" width="420" height="56" rx="6" fill="var(--soft)"/>
  <text x="620" y="112" font-size="12" fill="var(--ink)" font-family="monospace">pip install graphifyy</text>
  <text x="620" y="134" font-size="12" fill="var(--ink-dim)" font-family="monospace">graphify claude install</text>
  <!-- Extract -->
  <rect x="600" y="160" width="420" height="56" rx="6" fill="var(--soft)"/>
  <text x="620" y="182" font-size="11" fill="var(--ink)" font-family="monospace">graphify extract</text>
  <text x="620" y="202" font-size="11" fill="var(--ink-dim)" font-family="monospace">graphify extract --backend ollama</text>
  <!-- Note -->
  <rect x="600" y="234" width="420" height="40" rx="6" fill="var(--warning-wash)"/>
  <text x="620" y="256" font-size="11" fill="var(--warning-ink)" font-family="monospace">PyPI: graphifyy (double-y) !</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Graphify PyPI ชื่อ <code>graphifyy</code> (มี y สองตัว) — CLI command ยังคือ <code>graphify</code> — ระวังพิมพ์ผิด.</div>

<!-- Speaker: The double-y in graphifyy is a common gotcha. The CLI binary is still called graphify — just the package name has the extra y. -->

---

## Caveats: สิ่งที่ต้องรู้ก่อนเลือก

<p class="subhead">No tool is perfect — knowing the limits upfront saves debugging time later.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Understand Anything — Watch Out</p>
    <h3>High Cost + Scale Limit</h3>
    <ul>
      <li>~200k tokens/run — อาจหมด Monthly quota</li>
      <li>Dashboard freeze บน codebase &gt;3,000 nodes</li>
      <li>ไม่รองรับ Local Model ใดๆ</li>
      <li>Multi-agent pipeline ใช้เวลา build นาน</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Graphify — Watch Out</p>
    <h3>Machine-Readable Graph Only</h3>
    <ul>
      <li>HTML Graph ดูด้วยตาคนยาก — ไม่มี Parent/Child UI</li>
      <li>Docs/PDFs/Images ยังส่งไป LLM (text parsing free เท่านั้น)</li>
      <li>PyPI name: graphifyy (y สองตัว) — ระวังพิมพ์ผิด</li>
      <li>Auto-update requires commit hook setup</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Understand Anything trades token budget for UX; Graphify trades human readability for efficiency and privacy.</div>

<!-- Speaker: The scale limit on Understand Anything is real — tested at 3k+ nodes it can become unresponsive. Plan your tool choice based on repo size. -->

---

## Key Takeaways

<p class="subhead">Both tools — different design philosophies for different jobs.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Understand Anything</p>
    <h3>Dashboard + Deep Exploration</h3>
    <ul>
      <li>Multi-agent pipeline — rich architecture insights</li>
      <li>Best-in-class human-browsable dashboard</li>
      <li>Persona mode, Domain View, Impact Analysis</li>
      <li>Use for: Onboarding, PM, small-medium repos</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Graphify</p>
    <h3>Efficiency + Privacy</h3>
    <ul>
      <li>71–79x token savings via local AST (Tree-sitter)</li>
      <li>Full local model support: Ollama, Bedrock, vLLM</li>
      <li>Multi-modal: Code + Docs + PDF + Video</li>
      <li>Use for: Large repos, privacy-critical, cost control</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ทั้งสองร่วมกัน — Understand Anything สำรวจ/Onboard ครั้งแรก, Graphify สำหรับ Daily AI queries ประหยัดต้นทุน.</div>

<!-- Speaker: Not either/or. Use UA to onboard the team once; use Graphify as the daily driver for AI-assisted coding. -->
