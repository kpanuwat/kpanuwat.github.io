---
marp: true
theme: default
paginate: true
title: "CLI-Anything vs CLI Printing Press"
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
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# CLI-Anything vs CLI Printing Press

<p class="tag">วางสถาปัตยกรรม AI Agent ให้ถูก Layer — Access vs Optimization</p>

<!-- Speaker: Both tools solve the same root problem — agents can't reach real software — but from opposite directions. This deck shows when to use each and how they compose. -->

---

## AI Agent ยังเข้าไม่ถึง "Software จริง" ในองค์กร

<p class="subhead">สองทางที่มีอยู่ต่างก็มีจุดอ่อน — ต้องการวิธีใหม่</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">ทางที่ 1: เรียก REST API</p>
    <h3>Software ในองค์กรไม่มี API</h3>
    <p>Legacy apps, desktop tools, internal systems ส่วนใหญ่ไม่มี REST endpoint ให้เรียก agent ต้องทำงานกับ raw interface แทน</p>
  </div>
  <div class="card warning">
    <p class="label">ทางที่ 2: Browser/UI Automation</p>
    <h3>Fragile, แพง, ไม่ reproducible</h3>
    <p>Screenshot-based automation พัง เมื่อ UI เปลี่ยน token cost สูง latency สูง และไม่ reliable สำหรับ production workflow</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ต้องการ third path — CLI layer ที่ agent เรียกได้โดยตรงโดยไม่พึ่ง UI</div>

<!-- Speaker: Both current approaches have fundamental flaws. The answer is a CLI abstraction layer between agent and software. -->

---

## Two-Layer Agent Architecture Stack

<p class="subhead">CLI-Anything = Access Layer | CLI Printing Press = Optimization Layer</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/cli-anything-vs-cli-printing-press-2.png" alt="Two-layer agent architecture: CLI-Anything (access layer) + CLI Printing Press (optimization layer)">
<figcaption>Source: NotebookLM · Access Layer handles local software; Optimization Layer handles remote APIs</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> คนละ layer ในสถาปัตยกรรมเดียวกัน — ไม่ใช่คู่แข่ง</div>

<!-- Speaker: Think of it as two layers. CLI-Anything is the wide-access layer at the bottom. Printing Press is the efficiency layer at the top for high-frequency API calls. -->

---

## CLI-Anything: ให้ Agent ใช้ Software จริง ไม่ใช่ Workaround

<p class="subhead">Python Click CLI + Stateful REPL + --json flag = agent-native interface จาก codebase จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Philosophy</p>
    <h3>Use Real Software</h3>
    <p>Integrate กับ real backend ผ่าน subprocess หรือ native APIs — ไม่ใช่ reimplementation</p>
  </div>
  <div class="card success">
    <p class="label">Key Features</p>
    <h3>Stateful REPL + JSON</h3>
    <p>Persistent project state, undo/redo, built-in --json flag ทุก command สำหรับ machine-readable output</p>
  </div>
  <div class="card gold">
    <p class="label">Output</p>
    <h3>pip install + SKILL.md</h3>
    <p>Installable Python package + agent-discoverable SKILL.md ให้ Claude Code ค้นพบได้อัตโนมัติ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 1,508+ tests รองรับ real apps: Blender, LibreOffice, GIMP, Zotero, CloudCompare</div>

<!-- Speaker: The key insight is using the real software — not building a fake version of it. -->

---

## CLI-Anything: 7-Phase Automated Pipeline

<p class="subhead">Deterministic pipeline — ไม่ต้องแก้ไขด้วยมือ ทุก phase มี output ที่ verifiable</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/cli-anything-vs-cli-printing-press-1.png" alt="CLI-Anything 7-phase automated pipeline: Analyze, Design, Implement, Plan Tests, Write Tests, Document, Publish">
<figcaption>Source: NotebookLM · Phase 1–7: Analyze → Design → Implement → Test × 2 → Document → Publish</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Analyze codebase → Software.md → CLI → Tests → SKILL.md → pip install — อัตโนมัติทั้งหมด</div>

<!-- Speaker: This is a fully automated pipeline. You point it at a codebase and get a tested, installable CLI with agent metadata. -->

---

## CLI Printing Press: Data Gravity เปลี่ยน Cloud API ให้เป็น Local Tool

<p class="subhead">Go binary + SQLite cache + MCP server = agent มี "muscle memory" สำหรับทุก API</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Philosophy</p>
    <h3>Data Gravity</h3>
    <p>ดึง API data มาไว้ local แทนที่จะให้ agent fetch ทุกครั้ง — ลด latency + token cost อย่างมีนัยสำคัญ</p>
  </div>
  <div class="card success">
    <p class="label">Architecture</p>
    <h3>Go + SQLite + MCP</h3>
    <p>Statically compiled Go binary, SQLite sync layer, offline search, typed exit codes, machine-owned freshness</p>
  </div>
  <div class="card gold">
    <p class="label">Output per run</p>
    <h3>CLI + MCP + Manuscript</h3>
    <p>Go binary + MCP server (Claude Code ready) + Manuscript proof-of-work + Scorecard quality audit</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Input: OpenAPI spec / GraphQL / HAR file — Output: production-grade Go CLI + MCP server</div>

<!-- Speaker: Data Gravity is the key innovation. Instead of the agent traveling to the API, you bring the data locally. -->

---

## CLI Printing Press: 9-Phase Managed Pipeline

<p class="subhead">จาก API spec ถึง production CLI — 9 phases ที่ออกแบบมาสำหรับ agent-native ergonomics</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/cli-anything-vs-cli-printing-press-3.png" alt="CLI Printing Press 9-phase pipeline: Preflight, Research, Scaffold, Enrich, Regenerate, Review, Agent-readiness, Comparative, Ship">
<figcaption>Source: NotebookLM · Phase 1–9: Preflight → Research → Scaffold → Enrich → Regenerate → Review → Agent-readiness → Comparative → Ship</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Phase "Research" รองรับ HAR file สำหรับ API ที่ไม่มี official docs — capture browser traffic แล้วส่งเข้า pipeline</div>

<!-- Speaker: The HAR file support is especially powerful for undocumented internal APIs. Capture the traffic once, generate the CLI from it. -->

---

## เปรียบเทียบ: CLI-Anything vs CLI Printing Press

<p class="subhead">คนละ target, คนละ language, คนละ pipeline — แต่ agent-native standards เหมือนกัน</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/cli-anything-vs-cli-printing-press-5.png" alt="Comparison matrix: CLI-Anything vs CLI Printing Press across target, language, pipeline, output, key feature, and use cases">
<figcaption>Source: NotebookLM · Comparison across target, language, pipeline, key feature, and example use cases</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้งสองใช้ --help discovery + structured JSON + MCP — agent compose ได้ใน workflow เดียวกัน</div>

<!-- Speaker: Despite the differences, both tools speak the same agent-native language. That's what makes them composable. -->

---

## เลือกใช้อะไร ตอนไหน: Decision Framework

<p class="subhead">คำถามเดียวที่ต้องถาม: มี source code หรือมี API spec?</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/cli-anything-vs-cli-printing-press-4.png" alt="Decision flowchart: CLI-Anything for local software with source code, CLI Printing Press for remote APIs and web services">
<figcaption>Source: NotebookLM · Decision tree: local source code → CLI-Anything | remote API → CLI Printing Press</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Source code อยู่ local → CLI-Anything | เรียก API/web service → CLI Printing Press | ทั้งสองอยู่ใน stack เดียวกัน</div>

<!-- Speaker: The decision is simple. If you have source code, use CLI-Anything. If you have an API, use Printing Press. In real systems, you'll almost always need both. -->

---

## สถาปัตยกรรมสมบูรณ์: Access + Optimization Stack

<p class="subhead">CLI-Anything เป็น foundation — CLI Printing Press optimize APIs ที่ใช้งานหนัก</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Agent box at top -->
  <rect x="380" y="10" width="340" height="52" rx="10" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="550" y="42" font-size="18" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">AI Agent</text>
  <!-- Arrow down -->
  <line x1="550" y1="62" x2="550" y2="90" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrowhead)"/>
  <!-- Optimization Layer -->
  <rect x="200" y="90" width="700" height="100" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="126" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Optimization Layer — CLI Printing Press</text>
  <text x="550" y="150" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Go binary + SQLite cache + MCP server | GitHub, Stripe, Salesforce, internal REST/GraphQL APIs</text>
  <text x="550" y="172" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Data Gravity: local-first | offline search | compound queries | low latency</text>
  <!-- Arrow down -->
  <line x1="550" y1="190" x2="550" y2="218" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrowhead)"/>
  <!-- Access Layer -->
  <rect x="200" y="218" width="700" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="550" y="254" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Access Layer — CLI-Anything</text>
  <text x="550" y="278" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Python Click CLI + Stateful REPL | Blender, LibreOffice, GIMP, legacy desktop apps</text>
  <text x="550" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Use Real Software: subprocess/native APIs | pip install | SKILL.md discoverable</text>
  <!-- Arrow down -->
  <line x1="550" y1="318" x2="550" y2="346" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrowhead)"/>
  <!-- Real Software box -->
  <rect x="380" y="346" width="340" height="10" rx="4" fill="var(--soft-2)"/>
  <defs>
    <marker id="arrowhead" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0, 8 3, 0 6" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CLI-Anything ในขั้นเริ่มต้นเพื่อ coverage กว้างสุด — Printing Press ในขั้น optimize APIs ที่ใช้งานหนัก</div>

<!-- Speaker: This is the recommended architecture. Start with CLI-Anything for broad access, layer Printing Press on top for APIs that need optimization. -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำจาก deck นี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">CLI-Anything</p>
    <h3>Access Layer</h3>
    <p>ใช้กับ software ที่มี source code — Desktop apps, legacy tools, GUI software ที่ไม่มี API pipeline 7 phases: Analyze → Publish</p>
  </div>
  <div class="card success">
    <p class="label">CLI Printing Press</p>
    <h3>Optimization Layer</h3>
    <p>ใช้กับ API/web services ที่ต้องการ efficiency — Data Gravity, SQLite cache, MCP server pipeline 9 phases: Preflight → Ship</p>
  </div>
  <div class="card warning">
    <p class="label">Decision Rule</p>
    <h3>มี source code? → CLI-Anything</h3>
    <p>มี API spec/HAR? → Printing Press ทั้งสองร่วมกันในระบบเดียว = coverage + efficiency</p>
  </div>
  <div class="card gold">
    <p class="label">Key Insight</p>
    <h3>Data Gravity เปลี่ยนเกม</h3>
    <p>แทนที่ agent เดินทางไปหา API — ดึงข้อมูลมาไว้ local ก่อน agent ทำงานที่ local speed</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วาง CLI-Anything เป็น foundation ก่อน — ใช้ Printing Press optimize APIs สำคัญที่ใช้งานหนักหรือมี cost สูง</div>

<!-- Speaker: The one-sentence summary: CLI-Anything gives you access to everything, Printing Press makes the APIs you use most run faster and cheaper. -->
