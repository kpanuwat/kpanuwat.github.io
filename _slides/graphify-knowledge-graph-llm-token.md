---
marp: true
theme: default
paginate: true
title: "เจาะลึก Graphify: เปลี่ยนโค้ดเป็น Knowledge Graph"
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
  section.title h1 { font-size:46px; color:white; margin:0 0 8px; line-height:1.2; font-weight:800; }
  section.title h2 { font-size:28px; color:rgba(255,255,255,.85); font-weight:600; margin:0 0 16px; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# เจาะลึก Graphify
## เปลี่ยนโค้ดและเอกสารเป็น Knowledge Graph

<p class="tag">ประหยัด Token ได้ถึง 71.5x · Two-Pass AST+Semantic · Claude Code PreToolUse Hook</p>

<!-- Speaker: Graphify คือ open-source skill ที่แก้ปัญหา context window หมดเร็วบน large codebase -->

---

## Graphify คือคำตอบของปัญหา Large Codebase

<p class="subhead">AI coding assistant ใช้ token มหาศาลเมื่อต้อง grep ทุกไฟล์ — Graphify แก้ด้วย graph-first navigation</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- callout-box: TL;DR summary -->
  <rect x="50" y="30" width="1000" height="310" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="50" y="30" width="8" height="310" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="125" r="38" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="125" r="26" fill="var(--accent)"/>
  <text x="148" y="131" font-size="15" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">KG</text>
  <text x="210" y="108" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">Open-source skill (MIT) — Python, v0.3</text>
  <text x="210" y="136" font-size="15" fill="var(--ink-dim)" font-family="system-ui">แปลงโค้ด, PDF, รูปภาพ, วิดีโอทั้งโฟลเดอร์เป็น queryable Knowledge Graph</text>
  <line x1="100" y1="175" x2="1030" y2="175" stroke="var(--soft-2)" stroke-width="1"/>
  <rect x="100" y="195" width="260" height="110" rx="10" fill="var(--soft)" />
  <text x="230" y="222" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ลด Token</text>
  <text x="230" y="246" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">71.5x</text>
  <text x="230" y="270" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สูงสุด (large codebase)</text>
  <rect x="420" y="195" width="260" height="110" rx="10" fill="var(--soft)" />
  <text x="550" y="222" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Platforms</text>
  <text x="550" y="250" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude Code, Cursor</text>
  <text x="550" y="272" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Codex, Gemini CLI + more</text>
  <rect x="740" y="195" width="260" height="110" rx="10" fill="var(--soft)" />
  <text x="870" y="222" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Install</text>
  <text x="870" y="250" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">pip install graphifyy</text>
  <text x="870" y="272" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(PyPI = double-y)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Graphify = open-source, MIT, v0.3 — ติดตั้งด้วย pip install graphifyy แล้วใช้งานผ่าน /graphify command</div>

<!-- Speaker: สรุปภาพรวม: เป็น tool ที่ solve context-window problem ด้วย graph -->

---

## Naive Grep กิน Token 71.5x มากกว่า Graph Navigation

<p class="subhead">การ grep ทุกไฟล์ใน 500+ file project ใช้ ~123k tokens ต่อ query — Graphify ลดเหลือ ~1.7k tokens</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: Naive vs Graphify -->
  <rect x="30" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="490" height="52" rx="12" fill="var(--soft)" opacity=".9"/>
  <text x="275" y="52" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Naive Grep / Read All Files</text>
  <text x="275" y="112" font-size="36" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">~123,000</text>
  <text x="275" y="138" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">tokens per query (average)</text>
  <text x="70" y="180" font-size="14" fill="var(--ink-dim)" font-family="system-ui">- อ่านทุกไฟล์โดยไม่จำเป็น</text>
  <text x="70" y="208" font-size="14" fill="var(--ink-dim)" font-family="system-ui">- Context window หมดเร็ว</text>
  <text x="70" y="236" font-size="14" fill="var(--ink-dim)" font-family="system-ui">- บ่อยครั้งยังหาไม่เจอ</text>
  <text x="70" y="264" font-size="14" fill="var(--muted)" font-family="system-ui">- ค่าใช้จ่าย API พุ่งสูง</text>
  <rect x="580" y="20" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="580" y="20" width="490" height="52" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="825" y="52" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Graphify Knowledge Graph</text>
  <text x="825" y="112" font-size="36" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">~1,700</text>
  <text x="825" y="138" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">tokens per query (average)</text>
  <text x="620" y="180" font-size="14" fill="var(--ink)" font-family="system-ui">- เดิน graph edge ไป subgraph</text>
  <text x="620" y="208" font-size="14" fill="var(--ink)" font-family="system-ui">- ดึงเฉพาะ node ที่เชื่อมโยง</text>
  <text x="620" y="236" font-size="14" fill="var(--ink)" font-family="system-ui">- ค้นหาแม่นยำกว่า path-based</text>
  <text x="620" y="264" font-size="14" fill="var(--success-ink)" font-family="system-ui">- ประหยัด token 6.8x–71.5x</text>
  <circle cx="555" cy="185" r="28" fill="var(--accent)"/>
  <text x="555" y="190" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Graph navigation ประหยัดกว่า naive grep 71.5x เพราะ AI เดินตาม edge แทนการอ่านทุกไฟล์</div>

<!-- Speaker: ตัวเลข ~1,700 vs ~123,000 tokens มาจากการวัดจริงบน 50k+ line codebase -->

---

## Two-Pass Extraction: Local AST + AI Semantic

<p class="subhead">Graphify สร้าง graph สองรอบ — pass แรก local ฟรี, pass สองใช้ AI API เพื่อ infer ความสัมพันธ์ซ่อน</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: Source Files → AST Pass → Semantic Pass → Knowledge Graph -->
  <!-- Step 1: Source Files -->
  <rect x="30" y="120" width="200" height="120" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="130" y="165" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Source Files</text>
  <text x="130" y="187" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">code, docs, PDF</text>
  <text x="130" y="207" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">images, video</text>
  <!-- Arrow 1 -->
  <line x1="230" y1="180" x2="280" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="280,174 292,180 280,186" fill="var(--muted)"/>
  <!-- Step 2: AST Pass -->
  <rect x="292" y="100" width="220" height="160" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="402" y="145" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Pass 1 — AST</text>
  <text x="402" y="167" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Tree-sitter (local)</text>
  <text x="402" y="187" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">function calls</text>
  <text x="402" y="205" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">imports, inheritance</text>
  <text x="402" y="223" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">zero API cost</text>
  <!-- Arrow 2 -->
  <line x1="512" y1="180" x2="562" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="562,174 574,180 562,186" fill="var(--muted)"/>
  <!-- Step 3: Semantic Pass -->
  <rect x="574" y="100" width="220" height="160" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="684" y="145" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Pass 2 — Semantic</text>
  <text x="684" y="167" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">AI Model API</text>
  <text x="684" y="187" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">inferred edges</text>
  <text x="684" y="205" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">conceptual links</text>
  <text x="684" y="223" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">--mode deep = more</text>
  <!-- Arrow 3 -->
  <line x1="794" y1="180" x2="844" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="844,174 856,180 844,186" fill="var(--muted)"/>
  <!-- Step 4: Knowledge Graph -->
  <rect x="856" y="100" width="220" height="160" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="966" y="145" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Knowledge Graph</text>
  <text x="966" y="167" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">graph.json</text>
  <text x="966" y="187" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">nodes + edges</text>
  <text x="966" y="205" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">communities</text>
  <text x="966" y="223" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">GRAPH_REPORT.md</text>
  <!-- Labels below -->
  <text x="402" y="295" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">100% local</text>
  <text x="684" y="295" font-size="12" fill="var(--warning)" text-anchor="middle" font-family="system-ui">ใช้ API ครั้งแรกเท่านั้น</text>
  <text x="966" y="295" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">queryable ได้ทันที</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AST pass ทำงาน local ฟรี — semantic pass ใช้ API แค่ครั้งแรก; ใช้ --mode deep เพิ่ม inferred edges</div>

<!-- Speaker: สองรอบนี้ balance ระหว่าง cost กับ completeness ได้ดี -->

---

## Leiden Algorithm จัด Node เป็น Communities

<p class="subhead">หลังสร้าง graph แล้ว Leiden clustering จัดกลุ่ม node ที่เชื่อมโยงกันหนาแน่น — ผล = GRAPH_REPORT.md</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- hierarchy-tree: graph.json → communities → god nodes + report -->
  <!-- Root -->
  <rect x="440" y="20" width="220" height="56" rx="10" fill="var(--accent)" />
  <text x="550" y="45" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">graph.json</text>
  <text x="550" y="64" font-size="12" fill="var(--accent-wash)" text-anchor="middle" font-family="system-ui">Leiden clustering</text>
  <!-- Line to communities level -->
  <line x1="550" y1="76" x2="550" y2="110" stroke="var(--muted)" stroke-width="2"/>
  <line x1="200" y1="110" x2="900" y2="110" stroke="var(--muted)" stroke-width="2"/>
  <!-- Community 1 -->
  <line x1="200" y1="110" x2="200" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <rect x="100" y="140" width="200" height="56" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="200" y="163" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Community A</text>
  <text x="200" y="182" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Auth cluster</text>
  <!-- Community 2 -->
  <line x1="450" y1="110" x2="450" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <rect x="350" y="140" width="200" height="56" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="450" y="163" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Community B</text>
  <text x="450" y="182" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">API layer cluster</text>
  <!-- Community 3 -->
  <line x1="700" y1="110" x2="700" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <rect x="600" y="140" width="200" height="56" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="700" y="163" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Community C</text>
  <text x="700" y="182" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">DB layer cluster</text>
  <!-- Community 4 -->
  <line x1="900" y1="110" x2="900" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <rect x="800" y="140" width="200" height="56" rx="10" fill="var(--soft)" stroke="var(--gold)" stroke-width="2"/>
  <text x="900" y="163" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">God Nodes</text>
  <text x="900" y="182" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">highest-edge nodes</text>
  <!-- Output row -->
  <line x1="550" y1="110" x2="550" y2="265" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4"/>
  <rect x="330" y="265" width="440" height="70" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="291" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">graphify-out/GRAPH_REPORT.md</text>
  <text x="550" y="313" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">god nodes + community structure + surprising connections</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> GRAPH_REPORT.md = one-page map ของโปรเจกต์ — Claude อ่านไฟล์นี้แทนการ grep ทุกไฟล์</div>

<!-- Speaker: Leiden เป็น community detection algorithm ที่ดีกว่า Louvain ในแง่ resolution -->

---

## Graphify Ingest ได้ทุก Source Type

<p class="subhead">ไม่ใช่แค่ code — รองรับ PDF, รูปภาพ, วิดีโอ และ URL ภายนอก ทำให้ graph รวม knowledge ทั้งโปรเจกต์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Code</p>
    <h3>Code &amp; Scripts</h3>
    <p>Python, JS/TS, Go, Rust, SQL schemas, R, shell — Tree-sitter parse ทุกภาษา</p>
  </div>
  <div class="card gold">
    <p class="label">Documents</p>
    <h3>Docs &amp; PDF</h3>
    <p>PDF papers, markdown docs — สกัด concept และ section ไปเป็น graph nodes</p>
  </div>
  <div class="card success">
    <p class="label">External</p>
    <h3>URLs</h3>
    <p>arXiv papers, tweets, web pages — ใช้ /graphify add &lt;url&gt; ดึงและเพิ่มเข้า graph</p>
  </div>
  <div class="card warning">
    <p class="label">Media</p>
    <h3>Images &amp; Video</h3>
    <p>รูปภาพและวิดีโอ — extraction ยังอยู่ระหว่างทดลอง; quality ไม่สม่ำเสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Graph รวมทั้งโค้ด + เอกสาร + ข้อมูลภายนอกไว้ด้วยกัน — AI เห็น context ครบกว่าการอ่านไฟล์เดียว</div>

<!-- Speaker: /graphify add URL เป็น feature ที่น่าสนใจสำหรับ research-heavy projects -->

---

## 6 Export Formats ตามความต้องการ

<p class="subhead">หลัง /graphify สร้าง graph แล้ว export ได้หลายรูปแบบ — ตั้งแต่ Obsidian vault จนถึง MCP server</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Interactive</p>
    <h3>--obsidian</h3>
    <p>Obsidian vault พร้อม backlinks — ดู graph view แบบ interactive ใน Obsidian</p>
  </div>
  <div class="card success">
    <p class="label">Agent API</p>
    <h3>--mcp</h3>
    <p>MCP stdio server — ต่อกับ Claude Desktop หรือ agent ใดๆ ที่รองรับ MCP protocol</p>
  </div>
  <div class="card gold">
    <p class="label">Documentation</p>
    <h3>--wiki</h3>
    <p>Wikipedia-style markdown per community — ให้ agent crawl ได้</p>
  </div>
  <div class="card warning">
    <p class="label">Database</p>
    <h3>--neo4j</h3>
    <p>Cypher queries สำหรับ Neo4j — push ตรงด้วย --neo4j-push bolt://localhost</p>
  </div>
  <div class="card">
    <p class="label">Visual</p>
    <h3>--svg / --graphml</h3>
    <p>Visual exports สำหรับ Gephi, yEd หรือ embed ใน documentation</p>
  </div>
  <div class="card">
    <p class="label">Default</p>
    <h3>graph.html</h3>
    <p>Interactive HTML visualization สร้างอัตโนมัติทุกครั้งที่รัน /graphify</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> --mcp สำหรับ agent integration; --obsidian สำหรับ human exploration; --wiki สำหรับ documentation</div>

<!-- Speaker: เลือก export ตาม use case: code review ใช้ obsidian, autonomous agent ใช้ mcp -->

---

## graphify claude install ติดตั้ง 2 อย่างพร้อมกัน

<p class="subhead">Claude Code ได้ deepest integration — PreToolUse hook fire ก่อนทุก Glob/Grep call อัตโนมัติ</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- flowchart: install → CLAUDE.md + hook → Claude sees graph -->
  <!-- Install command -->
  <rect x="380" y="20" width="340" height="56" rx="10" fill="var(--accent)" />
  <text x="550" y="45" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">graphify claude install</text>
  <text x="550" y="63" font-size="12" fill="var(--accent-wash)" text-anchor="middle" font-family="system-ui">run inside project root</text>
  <!-- Split arrow -->
  <line x1="550" y1="76" x2="550" y2="100" stroke="var(--muted)" stroke-width="2"/>
  <line x1="260" y1="100" x2="840" y2="100" stroke="var(--muted)" stroke-width="2"/>
  <!-- Left: CLAUDE.md -->
  <line x1="260" y1="100" x2="260" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <rect x="80" y="130" width="360" height="100" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="260" y="160" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">CLAUDE.md directive</text>
  <text x="260" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">บอก Claude อ่าน</text>
  <text x="260" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">graphify-out/GRAPH_REPORT.md</text>
  <!-- Right: PreToolUse hook -->
  <line x1="840" y1="100" x2="840" y2="130" stroke="var(--muted)" stroke-width="2"/>
  <rect x="660" y="130" width="360" height="100" rx="10" fill="var(--soft)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="840" y="160" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PreToolUse hook</text>
  <text x="840" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">fire ก่อนทุก Glob + Grep</text>
  <text x="840" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">settings.json</text>
  <!-- Join arrow -->
  <line x1="260" y1="230" x2="260" y2="270" stroke="var(--muted)" stroke-width="2"/>
  <line x1="840" y1="230" x2="840" y2="270" stroke="var(--muted)" stroke-width="2"/>
  <line x1="260" y1="270" x2="840" y2="270" stroke="var(--muted)" stroke-width="2"/>
  <line x1="550" y1="270" x2="550" y2="294" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="544,294 550,308 556,294" fill="var(--muted)"/>
  <!-- Result -->
  <rect x="310" y="308" width="480" height="40" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="333" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Claude navigate by graph structure — ไม่ grep ทุกไฟล์</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PreToolUse hook คือ deepest integration — Claude เห็น graph context ก่อนตัดสินใจจะ search ไฟล์ไหน</div>

<!-- Speaker: hook นี้ intercept ที่ layer ที่ถูกต้อง — ก่อน Claude เลือก search strategy -->

---

## ขั้นตอนที่ 1–3: ติดตั้ง สร้าง Graph และ Query

<p class="subhead">3 คำสั่งแรกที่ต้องรู้ — install, build graph, แล้วถาม</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 3 steps -->
  <!-- Step 1 -->
  <rect x="30" y="80" width="300" height="200" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="90" cy="120" r="22" fill="var(--accent)"/>
  <text x="90" y="126" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="180" y="115" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">ติดตั้ง</text>
  <text x="60" y="158" font-size="12" fill="var(--muted)" font-family="system-ui">pip install graphifyy</text>
  <text x="60" y="178" font-size="12" fill="var(--muted)" font-family="system-ui">graphify install</text>
  <text x="60" y="208" font-size="11" fill="var(--ink-dim)" font-family="system-ui">note: PyPI=graphifyy</text>
  <text x="60" y="226" font-size="11" fill="var(--ink-dim)" font-family="system-ui">CLI=graphify (1 y)</text>
  <text x="60" y="252" font-size="11" fill="var(--muted)" font-family="system-ui">MIT, Python, v0.3</text>
  <!-- Arrow 1 -->
  <polygon points="340,174 360,180 340,186" fill="var(--muted)"/>
  <line x1="330" y1="180" x2="360" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <!-- Step 2 -->
  <rect x="370" y="80" width="300" height="200" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="430" cy="120" r="22" fill="var(--accent)"/>
  <text x="430" y="126" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="516" y="115" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">สร้าง Graph</text>
  <text x="396" y="158" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify ./src</text>
  <text x="396" y="178" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify --mode deep</text>
  <text x="396" y="208" font-size="11" fill="var(--ink-dim)" font-family="system-ui">output: graphify-out/</text>
  <text x="396" y="226" font-size="11" fill="var(--ink-dim)" font-family="system-ui">graph.json + report.md</text>
  <text x="396" y="252" font-size="11" fill="var(--muted)" font-family="system-ui">+ graph.html (viz)</text>
  <!-- Arrow 2 -->
  <polygon points="680,174 700,180 680,186" fill="var(--muted)"/>
  <line x1="670" y1="180" x2="700" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <!-- Step 3 -->
  <rect x="710" y="80" width="360" height="200" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="770" cy="120" r="22" fill="var(--success)"/>
  <text x="770" y="126" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="850" y="115" font-size="15" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Query Graph</text>
  <text x="736" y="158" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify query "..."</text>
  <text x="736" y="178" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify path A B</text>
  <text x="736" y="198" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify explain Node</text>
  <text x="736" y="226" font-size="11" fill="var(--ink-dim)" font-family="system-ui">--budget 1500 จำกัด tokens</text>
  <text x="736" y="244" font-size="11" fill="var(--ink-dim)" font-family="system-ui">--dfs trace specific path</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /graphify query, path, explain ใช้ graph.json โดยตรง — ได้ edge-level detail พร้อม relation type และ confidence</div>

<!-- Speaker: path command trace เส้นทางระหว่าง 2 node ได้แม่นยำมาก -->

---

## ขั้นตอนที่ 4–7: Claude Integration, Hooks, Obsidian, MCP

<p class="subhead">เชื่อม Claude Code, ตั้ง git hooks ให้ graph fresh, export เป็น Obsidian vault หรือ MCP server</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4 steps in 2x2 -->
  <!-- Step 4 -->
  <rect x="30" y="20" width="490" height="130" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="80" cy="52" r="18" fill="var(--accent)"/>
  <text x="80" y="57" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="140" y="48" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Claude Code Integration</text>
  <text x="55" y="82" font-size="12" fill="var(--muted)" font-family="system-ui">graphify claude install</text>
  <text x="55" y="102" font-size="11" fill="var(--ink-dim)" font-family="system-ui">เขียน CLAUDE.md + PreToolUse hook</text>
  <text x="55" y="122" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Claude consult graph ก่อนทุก file search</text>
  <!-- Step 5 -->
  <rect x="580" y="20" width="490" height="130" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="630" cy="52" r="18" fill="var(--accent)"/>
  <text x="630" y="57" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="690" y="48" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Keep Graph Fresh</text>
  <text x="605" y="82" font-size="12" fill="var(--muted)" font-family="system-ui">graphify hook install</text>
  <text x="605" y="102" font-size="11" fill="var(--ink-dim)" font-family="system-ui">post-commit + post-checkout rebuild</text>
  <text x="605" y="122" font-size="11" fill="var(--ink-dim)" font-family="system-ui">หรือใช้ /graphify --watch สำหรับ real-time</text>
  <!-- Step 6 -->
  <rect x="30" y="190" width="490" height="130" rx="12" fill="var(--soft)" stroke="var(--gold)" stroke-width="1.5"/>
  <circle cx="80" cy="222" r="18" fill="var(--gold)"/>
  <text x="80" y="227" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">6</text>
  <text x="140" y="218" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Export Obsidian Vault</text>
  <text x="55" y="252" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify ./src --obsidian</text>
  <text x="55" y="272" font-size="11" fill="var(--ink-dim)" font-family="system-ui">ได้ Obsidian vault ใน graphify-out/obsidian/</text>
  <text x="55" y="292" font-size="11" fill="var(--ink-dim)" font-family="system-ui">เปิดใน Obsidian ดู graph view แบบ interactive</text>
  <!-- Step 7 -->
  <rect x="580" y="190" width="490" height="130" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <circle cx="630" cy="222" r="18" fill="var(--success)"/>
  <text x="630" y="227" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">7</text>
  <text x="690" y="218" font-size="14" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Start MCP Server</text>
  <text x="605" y="252" font-size="12" fill="var(--muted)" font-family="system-ui">/graphify ./src --mcp</text>
  <text x="605" y="272" font-size="11" fill="var(--ink-dim)" font-family="system-ui">MCP stdio server — ต่อกับ Claude Desktop</text>
  <text x="605" y="292" font-size="11" fill="var(--ink-dim)" font-family="system-ui">หรือ agent ใดๆ ที่รองรับ MCP protocol</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> git hook ทำให้ graph ไม่ staleness; MCP server เปิด codebase ให้ agent อื่นเข้าถึงได้ข้ามเซสชัน</div>

<!-- Speaker: hook install สำคัญมาก — graph ที่ stale ทำให้ AI เห็น structure เก่าผิดพลาด -->

---

## 5 สิ่งที่ต้องระวัง

<p class="subhead">Graphify ทรงพลัง แต่มี gotchas ที่ต้องรู้ก่อนใช้จริงใน production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Cost</p>
    <h3>Semantic Pass ใช้ API</h3>
    <p>Pass 2 ส่ง context ไป AI API — มีค่าใช้จ่ายรอบแรก ใช้ --no-viz หรือ AST-only ถ้าต้องการประหยัด</p>
  </div>
  <div class="card danger">
    <p class="label">Staleness</p>
    <h3>Graph หมดอายุได้</h3>
    <p>Graph ที่ไม่ update out of sync กับโค้ด — ต้องติดตั้ง hook หรือ watch mode เพื่อ auto-rebuild</p>
  </div>
  <div class="card">
    <p class="label">Naming</p>
    <h3>PyPI Name ≠ CLI Name</h3>
    <p>pip install graphifyy (y สองตัว) แต่ใช้งานด้วย graphify (y ตัวเดียว) — ระวังสับสน</p>
  </div>
  <div class="card">
    <p class="label">Expectations</p>
    <h3>71.5x ไม่ใช่ทุก Task</h3>
    <p>ผล 71.5x เป็น best case บน large codebase — task อ่าน full file content ได้ประมาณ 6.8x–49x</p>
  </div>
  <div class="card warning">
    <p class="label">Experimental</p>
    <h3>Media Extraction ยังทดลอง</h3>
    <p>PDF และรูปภาพ ingest ได้ แต่ quality ของ edge extraction จาก non-code ยังไม่สม่ำเสมอ</p>
  </div>
  <div class="card success">
    <p class="label">Privacy</p>
    <h3>AST Pass = 100% Local</h3>
    <p>Structural extraction ทำงาน local ทั้งหมด — โค้ดไม่ออกไป internet ในขั้นตอน AST pass</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ติดตั้ง git hook ทันทีหลัง setup — graph staleness คือความเสี่ยงที่ป้องกันได้ง่ายที่สุด</div>

<!-- Speaker: privacy point สำคัญสำหรับ enterprise — AST local, semantic pass ส่งเฉพาะ context ที่จำเป็น -->

---

## Key Takeaways: Graphify ในสามชั้น

<p class="subhead">ทุกอย่างใน deck นี้สรุปได้เป็นสามชั้น — Install, Build, Navigate</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- concentric-rings: core = Navigate, mid = Build, outer = Install/Integrate -->
  <circle cx="380" cy="170" r="155" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="380" cy="170" r="105" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="380" cy="170" r="58" fill="var(--accent)" opacity=".1"/>
  <circle cx="380" cy="170" r="58" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="380" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Navigate</text>
  <text x="380" y="184" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">graph-first</text>
  <text x="220" y="95" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Build</text>
  <text x="220" y="113" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">AST + Semantic</text>
  <text x="540" y="95" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Build</text>
  <text x="540" y="113" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Leiden clusters</text>
  <text x="130" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Install</text>
  <text x="130" y="188" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">pip graphifyy</text>
  <text x="630" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Integrate</text>
  <text x="630" y="188" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">claude install</text>
  <!-- Takeaway list right side -->
  <rect x="600" y="20" width="470" height="300" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="835" y="56" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สรุปสิ่งสำคัญ</text>
  <circle cx="638" cy="92" r="5" fill="var(--accent)"/>
  <text x="655" y="97" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Token savings 6.8x–71.5x (ขึ้นกับ task)</text>
  <circle cx="638" cy="122" r="5" fill="var(--accent)"/>
  <text x="655" y="127" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Two-pass: AST local + Semantic AI API</text>
  <circle cx="638" cy="152" r="5" fill="var(--accent)"/>
  <text x="655" y="157" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Claude Code = deepest integration</text>
  <circle cx="638" cy="182" r="5" fill="var(--accent)"/>
  <text x="655" y="187" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Export: Obsidian, MCP, Neo4j, Wiki</text>
  <circle cx="638" cy="212" r="5" fill="var(--warning)"/>
  <text x="655" y="217" font-size="12" fill="var(--ink-dim)" font-family="system-ui">PyPI: graphifyy (2 y), CLI: graphify (1 y)</text>
  <circle cx="638" cy="242" r="5" fill="var(--success)"/>
  <text x="655" y="247" font-size="12" fill="var(--ink-dim)" font-family="system-ui">graphify hook install = keep graph fresh</text>
  <circle cx="638" cy="272" r="5" fill="var(--success)"/>
  <text x="655" y="277" font-size="12" fill="var(--ink-dim)" font-family="system-ui">AST pass 100% local — code ไม่ออก internet</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Install graphifyy → /graphify ./src → graphify claude install — สามคำสั่งนี้เปลี่ยนวิธี AI ทำความเข้าใจโปรเจกต์</div>

<!-- Speaker: จบด้วย 3 steps ที่ต้องทำวันนี้ เพื่อให้ผู้ฟัง action ได้ทันที -->
