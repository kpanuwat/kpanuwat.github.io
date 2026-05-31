---
marp: true
theme: default
paginate: true
title: "5 ทริคขอ AI สร้าง HTML แทน MD"
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

# 5 ทริคขอ AI สร้าง HTML

<p class="tag">5 use cases where a single HTML file beats Markdown — and how to prompt for it</p>

<!-- Speaker: When do you ask AI for .html instead of .md? This deck covers 5 clear-cut cases: spec diagrams, meeting reports, idea comparisons, drag tools, and interactive explainers. -->

---

## Pick your output format by what the reader needs to do

<p class="subhead">Markdown is readable and editable; HTML is interactive and delivery-ready. Neither replaces the other.</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="472" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 1px 2px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="472" height="52" rx="12" fill="var(--soft)"/>
  <text x="276" y="53" font-size="18" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">.md  Markdown</text>
  <text x="76" y="108" font-size="14" fill="var(--success)" font-family="system-ui">+ Readable, git-diffable, editable</text>
  <text x="76" y="140" font-size="14" fill="var(--success)" font-family="system-ui">+ Renders on GitHub / Notion natively</text>
  <text x="76" y="172" font-size="14" fill="var(--muted)" font-family="system-ui">- Plain text + headers only</text>
  <text x="76" y="204" font-size="14" fill="var(--muted)" font-family="system-ui">- No JS, no CSS layout</text>
  <text x="76" y="236" font-size="14" fill="var(--muted)" font-family="system-ui">- Diagrams = code blocks (render elsewhere)</text>
  <text x="76" y="268" font-size="14" fill="var(--muted)" font-family="system-ui">- No interactivity (drag, toggle, decode)</text>
  <rect x="588" y="20" width="472" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="588" y="20" width="472" height="52" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="824" y="53" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">.html  Single-file HTML</text>
  <text x="624" y="108" font-size="14" fill="var(--ink)" font-family="system-ui">+ CSS layout: grid, color, badges</text>
  <text x="624" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">+ JavaScript: drag, toggle, inline decode</text>
  <text x="624" y="172" font-size="14" fill="var(--ink)" font-family="system-ui">+ Inline SVG diagrams — renders immediately</text>
  <text x="624" y="204" font-size="14" fill="var(--ink)" font-family="system-ui">+ Opens offline in any browser</text>
  <text x="624" y="236" font-size="14" fill="var(--ink)" font-family="system-ui">+ Share via Slack / email attachment</text>
  <circle cx="540" cy="190" r="30" fill="var(--accent)"/>
  <text x="540" y="195" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือก HTML เมื่อ reader ต้องการ diagram, tool, หรือ report ที่ scan ได้เร็ว — Markdown เมื่อต้องการอ่านหรือ edit</div>

<!-- Speaker: Markdown for writing, HTML for delivery. The moment you need diagrams, color-coding, drag-drop, or offline sharing — HTML is the right output format. -->

---

## Single-file HTML: four delivery advantages over Markdown

<p class="subhead">No server, no login, no build step — just a file that opens and works anywhere.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Delivery</p>
    <h3>Browser-ready, offline</h3>
    <p>เปิดได้เลยใน browser ไม่ต้องมี server หรือ deploy — ดับเบิลคลิกที่ไฟล์ก็ใช้ได้เลย ทำงานแม้ไม่มี internet</p>
  </div>
  <div class="card">
    <p class="label">Sharing</p>
    <h3>Attach and send instantly</h3>
    <p>แนบไฟล์ทาง Slack, LINE, email ได้ทันที ไม่ต้องมี link ให้ login หรือขอ permission จาก admin</p>
  </div>
  <div class="card gold">
    <p class="label">Independence</p>
    <h3>Zero CMS dependency</h3>
    <p>ไม่ต้องพึ่ง Notion, Confluence, หรือ Google Docs — ไฟล์เดียวครบในตัว ไม่มี vendor lock-in</p>
  </div>
  <div class="card warning">
    <p class="label">AI output quality</p>
    <h3>AI writes it well</h3>
    <p>Claude, GPT-4o, Gemini เขียน self-contained HTML คุณภาพสูงมาก — ถ้าบอก "no CDN" ให้ชัด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML file เดียวแทน Notion page + permissions + login flow — แชร์ได้เลย เปิด offline ได้เลย</div>

<!-- Speaker: Four wins in one: offline-ready, instant-share, dependency-free, AI-writable. These compound when you need quick collaboration across teams without shared tool access. -->

---

## Trick 1: Spec + diagram — one self-contained file, no render step

<p class="subhead">Markdown gives you Mermaid code blocks that need a separate renderer. HTML gives you an inline SVG that renders immediately on open.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="120" width="190" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="125" y="162" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Your Prompt</text>
  <text x="125" y="185" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"spec + diagram"</text>
  <line x1="220" y1="170" x2="282" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="282,164 296,170 282,176" fill="var(--accent)"/>
  <rect x="296" y="120" width="210" height="100" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="401" y="162" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude / GPT-4o</text>
  <text x="401" y="185" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">generates HTML</text>
  <line x1="506" y1="170" x2="568" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="568,164 582,170 568,176" fill="var(--accent)"/>
  <rect x="582" y="100" width="220" height="140" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <text x="692" y="152" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">spec.html</text>
  <text x="692" y="174" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">SVG diagram inside</text>
  <text x="692" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ prose sections</text>
  <text x="692" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">self-contained</text>
  <line x1="802" y1="170" x2="864" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="864,164 878,170 864,176" fill="var(--accent)"/>
  <rect x="878" y="120" width="192" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="974" y="162" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Browser</text>
  <text x="974" y="185" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">diagram renders live</text>
  <rect x="200" y="278" width="700" height="32" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="299" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">prompt must include: "self-contained, no external fetch"</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ขอ "spec + SVG diagram, self-contained" จาก AI แล้วได้ไฟล์เดียวที่แชร์ทีมได้ทันที ไม่ต้อง render แยก</div>

<!-- Speaker: The key difference: in Markdown you get a Mermaid block that needs a renderer. In HTML the diagram is inside — open the file, diagram shows up. -->

---

## Trick 2: Color-code speakers so anyone scans in 10 seconds

<p class="subhead">CSS assigns each participant a color. Action items get yellow boxes, decisions get red borders — Markdown can't do any of this.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Speaker — Alice (blue)</p>
    <h3>Decision owner</h3>
    <p>ข้อความ Alice แสดง blue border-left ทุกบรรทัด — scan ได้ทันทีว่าใครพูดอะไร ไม่ต้องอ่านชื่อทุกครั้ง</p>
    <p style="font-size:11px;color:var(--muted);margin-top:6px">border-left: 4px solid #3b82f6</p>
  </div>
  <div class="card warning">
    <p class="label">Speaker — Bob (orange)</p>
    <h3>Action items</h3>
    <p>Action items highlight สีเหลือง — ดึงสายตาทันที อ่าน meeting notes ยาว 3 หน้าได้ใน 30 วินาที</p>
    <p style="font-size:11px;color:var(--muted);margin-top:6px">background: warning-wash</p>
  </div>
  <div class="card success">
    <p class="label">Speaker — Carol (green)</p>
    <h3>Decisions logged</h3>
    <p>Decisions สีเขียว bold border — ต่างจาก discussion ชัดเจน หาทุก decision ในไฟล์ได้ใน 10 วินาที</p>
    <p style="font-size:11px;color:var(--muted);margin-top:6px">border-left: 4px solid #16a34a</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML meeting report ให้ visual scan ใน 10 วินาที — Markdown ต้องอ่านทีละบรรทัดเพื่อหาว่าใครพูดอะไร</div>

<!-- Speaker: Prompt pattern: "each person gets a CSS color, action items get yellow boxes, decisions get red border-left, summary at top." The HTML output is scannable where Markdown is not. -->

---

## Trick 3: Compare N options — one file with winner highlights

<p class="subhead">HTML adds toggle views, per-row winner highlights, and color scores. The table below is what Markdown gives you — HTML gives you this plus interactivity.</p>

<div class="infographic" style="align-items:flex-start;overflow-x:auto;padding:8px 0;">

| Criterion | Postgres | MongoDB | SQLite | DynamoDB |
|---|:---:|:---:|:---:|:---:|
| Cost (free tier) | ★★★★ | ★★★ | ★★★★★ | ★★★ |
| Scalability | ★★★★★ | ★★★★★ | ★★ | ★★★★★ |
| Query flexibility | ★★★★★ | ★★★★ | ★★★★ | ★★ |
| Local dev ease | ★★★★ | ★★★★ | ★★★★★ | ★★ |
| Managed option | ★★★★★ | ★★★★★ | ★ | ★★★★★ |

</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML เพิ่ม "highlight winner per row" + toggle Card/Table view ได้ — เป็น decision artifact ไม่ใช่แค่ table อ่านอย่างเดียว</div>

<!-- Speaker: The prompt adds: "highlight the winner in each row, add a toggle between table-view and card-view, add a recommendation section." That transforms a static table into a decision tool. -->

---

## Trick 4: Drag-and-drop Kanban — HTML5, zero dependencies

<p class="subhead">Drag cards between columns, edit inline, export JSON — vanilla JS only, no React or CDN. Markdown cannot do this at all.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="320" height="280" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="30" width="320" height="46" rx="12" fill="var(--danger)" opacity=".85"/>
  <text x="190" y="60" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Must Do</text>
  <rect x="46" y="90" width="288" height="50" rx="8" fill="var(--paper)" stroke="var(--danger)" stroke-width="1" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="190" y="111" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Task card</text>
  <text x="190" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">click to edit · drag to move</text>
  <rect x="46" y="152" width="288" height="50" rx="8" fill="var(--paper)" stroke="var(--danger)" stroke-width="1" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="190" y="181" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Another card</text>
  <rect x="390" y="30" width="320" height="280" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="390" y="30" width="320" height="46" rx="12" fill="var(--warning)" opacity=".85"/>
  <text x="550" y="60" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Should Do</text>
  <rect x="406" y="90" width="288" height="50" rx="8" fill="var(--paper)" stroke="var(--warning)" stroke-width="1" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="550" y="111" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Backlog item</text>
  <text x="550" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">drag from Must Do</text>
  <rect x="750" y="30" width="320" height="280" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="750" y="30" width="320" height="46" rx="12" fill="var(--success)" opacity=".85"/>
  <text x="910" y="60" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Nice to Have</text>
  <rect x="766" y="90" width="288" height="50" rx="8" fill="var(--paper)" stroke="var(--success)" stroke-width="1" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="910" y="111" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Future idea</text>
  <rect x="300" y="290" width="500" height="30" rx="8" fill="var(--soft)"/>
  <text x="550" y="310" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HTML5 Drag API + vanilla JS · Export JSON button · self-contained</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Markdown ทำ Kanban ไม่ได้เลย — HTML + vanilla JS สร้าง drag tool ใน 1 ไฟล์ ไม่ต้องพึ่ง React หรือ CDN</div>

<!-- Speaker: Self-contained constraint is critical here. Without "no CDN," AI imports React from a CDN and breaks offline usage. -->

---

## Trick 5: Interactive explainer — complex concepts without a presenter

<p class="subhead">Collapsible sections, live decoders, animated step diagrams — HTML makes abstract protocols understandable when opened alone.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="390" y="10" width="320" height="54" rx="12" fill="var(--accent)" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <text x="550" y="44" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">HTML Explainer File</text>
  <line x1="550" y1="64" x2="550" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="180" y1="100" x2="920" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="180" y1="100" x2="180" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="100" x2="550" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="920" y1="100" x2="920" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="60" y="130" width="240" height="54" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="180" y="154" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Section Nav</text>
  <text x="180" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">jump + collapsible</text>
  <rect x="430" y="130" width="240" height="54" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="154" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Live Decoder</text>
  <text x="550" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">input — decoded output</text>
  <rect x="800" y="130" width="240" height="54" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="920" y="154" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Step Diagram</text>
  <text x="920" y="174" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">animated step flow</text>
  <line x1="550" y1="184" x2="550" y2="218" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="420" y1="218" x2="680" y2="218" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="420" y1="218" x2="420" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="680" y1="218" x2="680" y2="240" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="330" y="240" width="180" height="48" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="420" y="260" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">JWT Header</text>
  <text x="420" y="278" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">alg, typ decoded</text>
  <rect x="590" y="240" width="180" height="48" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="680" y="260" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">JWT Payload</text>
  <text x="680" y="278" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">claims color-coded</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML explainer = onboarding doc ที่เปิดเองได้ ไม่ต้องมี presenter — เหมาะสำหรับ JWT, OAuth flow, async/await</div>

<!-- Speaker: The JWT decoder example: paste a token, see header/payload/signature decoded and color-coded instantly. Zero-cost to request in HTML — one prompt away. -->

---

## Know these 5 limits before shipping an HTML artifact

<p class="subhead">HTML artifacts have real trade-offs vs Markdown — include the right constraints in your prompt to avoid surprises.</p>

<div class="infographic" style="flex-direction:column;gap:12px;align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">File size</p>
    <h3>30–100 KB typical</h3>
    <p>HTML ที่มี inline SVG + CSS + JS อ้วนกว่า MD มาก — ระวัง email attachment size limit บางบริษัทจำกัดที่ 10 MB</p>
  </div>
  <div class="card danger">
    <p class="label">Browser security</p>
    <h3>file:// blocks fetch()</h3>
    <p>ถ้าใช้ fetch() หรือ localStorage ต้อง serve ผ่าน http:// — ใช้ python3 -m http.server แทนการเปิดตรง</p>
  </div>
  <div class="card danger">
    <p class="label">AI token limit</p>
    <h3>500+ lines gets cut</h3>
    <p>HTML ซับซ้อนอาจถูกตัดกลาง — ขอ "minimal version first" แล้ว iterate เพิ่ม feature ทีละชิ้น</p>
  </div>
</div>
<div class="bento cols-2">
  <div class="card">
    <p class="label">Maintenance</p>
    <h3>Re-generate, don't hand-edit</h3>
    <p>HTML ไม่ git-diff ได้ดีเหมือน MD — ถ้า content เปลี่ยนบ่อย ให้ generate ใหม่ทั้งหมด ใช้ AI เป็น generator</p>
  </div>
  <div class="card gold">
    <p class="label">Critical prompt rule</p>
    <h3>"self-contained, no CDN"</h3>
    <p>ต้องบอกทุกครั้ง — ไม่งั้น AI import React/Vue จาก CDN ทำให้ offline ใช้ไม่ได้ ประโยคนี้สำคัญที่สุด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Magic phrase: <b>"self-contained, no external CDN, no fetch"</b> — ใส่ทุกครั้งที่ขอ HTML artifact จาก AI</div>

<!-- Speaker: The most critical constraint is "self-contained." Without it, AI will import libraries that break offline usage — the main selling point of HTML artifacts. -->

---

## HTML artifacts: choose by what the reader needs to do

<p class="subhead">Markdown is the default — but these 5 cases clearly call for HTML instead.</p>

<div class="infographic" style="align-items:stretch;">
<div style="display:flex;flex-direction:column;gap:8px;width:100%;">
  <div class="card compact">
    <h3>Markdown = prose &nbsp;|&nbsp; HTML = interactive artifact</h3>
    <p>เลือกตาม output ที่ reader ต้องการทำ ไม่ใช่ตาม default ที่คุ้นเคย</p>
  </div>
  <div class="card compact success">
    <h3>5 use cases: spec+diagram, meeting report, idea comparison, drag-tool, explainer</h3>
    <p>แต่ละ use case ให้ value ที่ MD ทำไม่ได้ — diagram, color scan, interactivity, animation</p>
  </div>
  <div class="card compact gold">
    <h3>Magic phrase: "self-contained, no CDN, no external fetch"</h3>
    <p>ประโยคนี้เป็น constraint ที่สำคัญที่สุด — ใส่ทุกครั้งที่ขอ HTML จาก AI</p>
  </div>
  <div class="card compact warning">
    <h3>Re-generate beats hand-editing HTML</h3>
    <p>ใช้ AI เป็น generator ไม่ใช่ editor — ขอ generate ใหม่เมื่อ content เปลี่ยน</p>
  </div>
  <div class="card compact">
    <h3>Start minimal: "minimal version first, then add X"</h3>
    <p>ป้องกัน AI token cutoff สำหรับ HTML ซับซ้อน — iterate เพิ่มทีละ feature</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML artifact = 1 prompt + "self-contained, no CDN" — AI generates it; you open it offline and share it instantly</div>

<!-- Speaker: The mental model: Markdown for writing and editing, HTML for delivery and interaction. When the artifact needs to work without a reader installing anything — go HTML. -->
