---
marp: true
theme: default
paginate: true
title: "SI Tech x Super AI Engineer: Intern AI Use Cases"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# SI Tech x Super AI Engineer
# เปิดรับ Intern 4 บทบาท

<p class="tag">พัฒนา AI Use Cases จริงในอุตสาหกรรม — Season 6 (2026)</p>

<!-- Speaker: SI Tech เข้าร่วม Super AI Engineer Season 6 เปิดรับ intern 4 บทบาทเพื่อพัฒนา 5 AI use cases จริง ทั้งสำหรับลูกค้าและภายในองค์กร -->

---

## ความร่วมมือนี้สร้าง Win-Win ทั้งสองฝ่าย

<p class="subhead">SI Tech เข้าถึง AI talent คุณภาพสูง — Intern ได้พัฒนา use case จากอุตสาหกรรมจริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">4 Intern Roles</p>
    <h3>บทบาทที่เปิดรับ</h3>
    <ul>
      <li>Forward Deploy Engineer</li>
      <li>AI Engineer</li>
      <li>Data Engineer</li>
      <li>Solutions Engineer</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">5 AI Use Cases</p>
    <h3>Use Cases ที่จะพัฒนา</h3>
    <ul>
      <li>AI Customer Support Copilot</li>
      <li>Sales &amp; Proposal Assistant</li>
      <li>Predictive Analytics Dashboard</li>
      <li>Document Intelligence &amp; Automation</li>
      <li>API-based LLM Integration</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 5 use cases x 4 roles = 5 parallel workstreams ที่ run พร้อมกันได้ในทีม intern เดียว</div>

<!-- Speaker: สรุปภาพรวมของความร่วมมือ — 4 roles ครอบ full-stack AI delivery ตั้งแต่ architecture จนถึง deployment -->

---

## Super AI Engineer Season 6 ผลิต AI Talent คุณภาพสูง

<p class="subhead">45,800+ participants ใน 6 ซีซั่น — upskilling + hackathon + real-world internship</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">AI Innovator Track</p>
    <h3>Product Builder</h3>
    <p>สร้าง AI product/service จาก idea ถึง market — business + tech mindset</p>
  </div>
  <div class="card">
    <p class="label">AI Engineer Track</p>
    <h3>System Builder</h3>
    <p>ออกแบบและ implement AI systems — LLM, RAG, fine-tuning, deployment</p>
  </div>
  <div class="card warning">
    <p class="label">AI Researcher Track</p>
    <h3>Knowledge Builder</h3>
    <p>วิจัย AI models, algorithms, evaluation — deep theoretical + applied skills</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Intern จาก Super AI Engineer ไม่ใช่ fresh graduate ทั่วไป — ผ่าน intensive selection + real-world hackathon มาแล้ว</div>

<!-- Speaker: Season 6 ล่าสุดรับสมัครเมษายน 2026 ทั้ง 3 tracks ล้วนมีประโยชน์สำหรับ SI Tech -->

---

## 4 บทบาทครอบ Full AI Delivery Stack

<p class="subhead">ตั้งแต่ architecture proposal จนถึง production monitoring — intern แต่ละบทบาทเสริมกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact gold">
    <p class="label">Forward Deploy</p>
    <h3>FDE</h3>
    <p>เขียน production code ใน client environment โดยตรง RAG, agents, observability</p>
  </div>
  <div class="card compact">
    <p class="label">AI Engineer</p>
    <h3>AI Eng</h3>
    <p>Model selection, fine-tuning, LLM API, vector DB, inference optimization</p>
  </div>
  <div class="card compact success">
    <p class="label">Data Engineer</p>
    <h3>Data Eng</h3>
    <p>ETL pipelines, feature stores, structured + unstructured data, data quality</p>
  </div>
  <div class="card compact warning">
    <p class="label">Solutions Engineer</p>
    <h3>Solutions Eng</h3>
    <p>Pre/post-sales scoping, solution architecture, PoC delivery, client demo</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 4 roles ครอบ full stack: FDE builds in prod, AI Eng owns models, Data Eng owns pipelines, Solutions Eng owns client</div>

<!-- Speaker: คิดว่า 4 roles นี้เหมือน 4 ด้านของ rhombus — FDE + AI Eng ด้านใน, Data Eng + Solutions Eng ด้านนอก -->

---

## FDE คือ Role ที่โตเร็วสุดในวงการ AI ปี 2026

<p class="subhead">Consultant ส่ง report — FDE เขียน production code ในระบบลูกค้าโดยตรงและอยู่จนระบบ run จริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Consultant -->
  <rect x="40" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 1px 2px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="480" height="52" rx="12" fill="var(--soft)" opacity=".9"/>
  <text x="280" y="52" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Consultant</text>
  <text x="80" y="115" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Output: Reports &amp; Recommendations</text>
  <text x="80" y="150" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Timeline: Leaves after delivery</text>
  <text x="80" y="185" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Code: None — advisory only</text>
  <text x="80" y="240" font-size="13" fill="var(--muted)" font-family="system-ui">Demand growth (2025-26): moderate</text>
  <!-- Right: FDE -->
  <rect x="580" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="580" y="20" width="480" height="52" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="820" y="52" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Forward Deploy Engineer (FDE)</text>
  <text x="620" y="115" font-size="14" fill="var(--ink)" font-family="system-ui">Output: Working AI in production</text>
  <text x="620" y="150" font-size="14" fill="var(--ink)" font-family="system-ui">Timeline: Stays until system runs</text>
  <text x="620" y="185" font-size="14" fill="var(--ink)" font-family="system-ui">Code: Writes directly in client systems</text>
  <text x="620" y="240" font-size="13" fill="var(--accent)" font-family="system-ui" font-weight="600">Demand growth: +800-1,000% in 2026</text>
  <!-- VS badge -->
  <circle cx="550" cy="170" r="30" fill="var(--accent)"/>
  <text x="550" y="176" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OpenAI, Anthropic, Cohere เปิดรับ FDE เพิ่ม 800-1,000% — SI Tech ที่มี client projects จริงคือ perfect training ground</div>

<!-- Speaker: FDE คือ role ที่ AI companies ต้องการมากที่สุดตอนนี้ เพราะมันแก้ปัญหา last-mile deployment -->

---

## UC1: AI Copilot ลด Response Time ได้ 40-70%

<p class="subhead">LLM Router + RAG จัดการ tier-1 tickets อัตโนมัติ ส่งต่อ human agent เฉพาะ case ซับซ้อน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Node 1: User Ticket -->
  <rect x="30" y="125" width="190" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="125" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User Ticket</text>
  <text x="125" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">any channel</text>
  <!-- Arrow 1 -->
  <line x1="220" y1="160" x2="295" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="285,153 298,160 285,167" fill="var(--accent)"/>
  <!-- Node 2: AI Router -->
  <rect x="298" y="125" width="200" height="70" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="398" y="152" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI Copilot</text>
  <text x="398" y="170" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">LLM Router + RAG</text>
  <text x="398" y="187" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">knowledge base</text>
  <!-- Arrow 2a (auto-resolve) -->
  <line x1="498" y1="150" x2="573" y2="130" stroke="var(--success)" stroke-width="2"/>
  <polygon points="563,121 576,128 566,137" fill="var(--success)"/>
  <!-- Arrow 2b (escalate) -->
  <line x1="498" y1="170" x2="573" y2="200" stroke="var(--warning)" stroke-width="2"/>
  <polygon points="563,193 576,200 566,209" fill="var(--warning)"/>
  <!-- Node 3a: Auto-Resolve -->
  <rect x="576" y="95" width="200" height="60" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="676" y="121" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Auto-Resolve</text>
  <text x="676" y="143" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">24/7, instant response</text>
  <!-- Node 3b: Escalate -->
  <rect x="576" y="185" width="200" height="60" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="676" y="211" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Human Agent</text>
  <text x="676" y="233" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">complex cases + context</text>
  <!-- Arrow 3 (merge to response) -->
  <line x1="776" y1="125" x2="845" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <line x1="776" y1="215" x2="845" y2="175" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="835,148 848,155 835,162" fill="var(--accent)"/>
  <polygon points="835,168 848,175 835,182" fill="var(--accent)"/>
  <!-- Node 4: Response -->
  <rect x="848" y="125" width="190" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="943" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Customer</text>
  <text x="943" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">resolved + satisfied</text>
  <!-- ROI badges -->
  <rect x="298" y="240" width="200" height="52" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="398" y="262" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">40-70%</text>
  <text x="398" y="282" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">ลด resolution time</text>
  <rect x="516" y="240" width="200" height="52" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="616" y="262" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">70%</text>
  <text x="616" y="282" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">ลด human escalation</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI Copilot scales support volume โดยไม่ต้องเพิ่ม headcount — ROI ชัดที่สุดใน 5 use cases</div>

<!-- Speaker: Roles: AI Engineer (RAG pipeline), FDE (deploy in client env), Solutions Engineer (ROI demo + proposal) -->

---

## UC2: Sales Proposal จาก Days เหลือ Minutes

<p class="subhead">LLM generate ร่างแรกจาก brief + RAG จาก past proposals — เหลือแค่ human review ก่อนส่ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1 -->
  <rect x="30" y="120" width="175" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="117" y="150" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Deal Brief</text>
  <text x="117" y="170" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">client requirements</text>
  <!-- Arrow 1 -->
  <line x1="205" y1="155" x2="270" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="260,148 273,155 260,162" fill="var(--accent)"/>
  <!-- Step 2: AI Generator -->
  <rect x="273" y="100" width="200" height="110" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="373" y="130" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI Generator</text>
  <text x="373" y="150" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">LLM + RAG</text>
  <text x="373" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">past proposals DB</text>
  <text x="373" y="186" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">pricing catalog</text>
  <!-- Arrow 2 -->
  <line x1="473" y1="155" x2="538" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="528,148 541,155 528,162" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="541" y="120" width="175" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="628" y="150" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sales Review</text>
  <text x="628" y="170" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">human-in-the-loop</text>
  <!-- Arrow 3 -->
  <line x1="716" y1="155" x2="781" y2="155" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="771,148 784,155 771,162" fill="var(--accent)"/>
  <!-- Step 4 -->
  <rect x="784" y="120" width="175" height="70" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="871" y="150" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Client Proposal</text>
  <text x="871" y="170" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">polished + accurate</text>
  <!-- Time saving badge -->
  <rect x="273" y="240" width="200" height="52" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="373" y="262" font-size="20" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1-2 days</text>
  <text x="373" y="282" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">old process</text>
  <line x1="480" y1="266" x2="520" y2="266" stroke="var(--danger)" stroke-width="2"/>
  <polygon points="510,259 523,266 510,273" fill="var(--danger)"/>
  <rect x="527" y="240" width="175" height="52" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="614" y="262" font-size="20" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">5-10 min</text>
  <text x="614" y="282" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">with AI draft</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Proposal generation คือ highest-ROI gen AI use case — compress จาก days เหลือ minutes; sales team focus ที่ closing</div>

<!-- Speaker: Roles: AI Engineer (LLM pipeline + RAG), Data Engineer (past project DB + pricing catalog) -->

---

## UC3: Dashboard ไม่พอ — ต้อง Embed ใน Workflow

<p class="subhead">องค์กรที่ embed predictions ใน ERP/CRM ได้ ROI — องค์กรที่แค่แสดงบน dashboard ไม่ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Dashboard Only (no ROI) -->
  <rect x="40" y="20" width="460" height="280" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5" opacity=".7"/>
  <rect x="40" y="20" width="460" height="52" rx="12" fill="var(--danger-wash)"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Dashboard Only</text>
  <text x="80" y="110" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Data → ML Model → Forecast number</text>
  <text x="80" y="140" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Shown on a pretty dashboard screen</text>
  <text x="80" y="175" font-size="13" fill="var(--danger-ink)" font-family="system-ui" font-weight="600">Nobody acts on it consistently</text>
  <rect x="80" y="205" width="360" height="56" rx="8" fill="var(--danger-wash)"/>
  <text x="260" y="230" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ROI = minimal</text>
  <text x="260" y="250" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Prediction exists, decisions unchanged</text>
  <!-- Right: Embedded in ERP/CRM -->
  <rect x="600" y="20" width="460" height="280" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.12))"/>
  <rect x="600" y="20" width="460" height="52" rx="12" fill="var(--success-wash)"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Embedded in ERP / CRM</text>
  <text x="640" y="110" font-size="13" fill="var(--ink)" font-family="system-ui">Data → ML Model → Forecast</text>
  <text x="640" y="140" font-size="13" fill="var(--ink)" font-family="system-ui">Injected into CRM / pricing engine</text>
  <text x="640" y="175" font-size="13" fill="var(--success-ink)" font-family="system-ui" font-weight="600">Triggers automated action</text>
  <rect x="640" y="205" width="360" height="56" rx="8" fill="var(--success-wash)"/>
  <text x="820" y="230" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ROI = demand forecast -16% inventory</text>
  <text x="820" y="250" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">Prediction changes decisions automatically</text>
  <!-- VS -->
  <circle cx="549" cy="160" r="32" fill="var(--accent)"/>
  <text x="549" y="166" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">KEY</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI ต้องเชื่อมกับ decision จริงถึงจะสร้าง ROI — สร้าง dashboard สวยไม่พอ ต้อง embed ใน workflow ที่เกิดขึ้นทุกวัน</div>

<!-- Speaker: นี่คือ non-obvious insight ที่สำคัญสุดในสไลด์นี้ — บอก client ตั้งแต่ต้นว่า PoC ต้องต่อกับระบบจริง ไม่ใช่แค่แสดงผล -->

---

## UC4: LLM-IDP เข้าใจเอกสารแบบ Zero-Config

<p class="subhead">วิวัฒนาการ Document Intelligence: จาก template-locked OCR ถึง semantic LLM ที่ไม่ต้องมี template</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Stage 1: Legacy OCR -->
  <rect x="30" y="60" width="290" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="60" width="290" height="48" rx="12" fill="var(--muted)" opacity=".25"/>
  <text x="175" y="91" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Legacy OCR</text>
  <text x="175" y="112" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">template-based extraction</text>
  <text x="60" y="150" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Accuracy: ~80%</text>
  <text x="60" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Needs template per format</text>
  <text x="60" y="200" font-size="12" fill="var(--danger)" font-family="system-ui">Breaks on new layouts</text>
  <!-- Arrow 1 -->
  <line x1="320" y1="150" x2="395" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="385,143 398,150 385,157" fill="var(--muted)"/>
  <!-- Stage 2: ML-IDP -->
  <rect x="398" y="60" width="290" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="398" y="60" width="290" height="48" rx="12" fill="var(--warning)" opacity=".2"/>
  <text x="543" y="91" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ML-based IDP</text>
  <text x="543" y="112" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">pattern recognition + retraining</text>
  <text x="428" y="150" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Accuracy: ~88%</text>
  <text x="428" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Adapts to more layouts</text>
  <text x="428" y="200" font-size="12" fill="var(--warning-ink)" font-family="system-ui">Needs retraining on change</text>
  <!-- Arrow 2 -->
  <line x1="688" y1="150" x2="763" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="753,143 766,150 753,157" fill="var(--accent)"/>
  <!-- Stage 3: LLM-IDP -->
  <rect x="766" y="40" width="304" height="220" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="766" y="40" width="304" height="50" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="918" y="73" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">LLM-powered IDP</text>
  <text x="918" y="93" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">semantic comprehension, zero-config</text>
  <text x="796" y="135" font-size="12" fill="var(--ink)" font-family="system-ui">Accuracy: 95%+</text>
  <text x="796" y="158" font-size="12" fill="var(--ink)" font-family="system-ui">Any layout, no template</text>
  <text x="796" y="181" font-size="12" fill="var(--ink)" font-family="system-ui">Normalizes + validates context</text>
  <text x="796" y="215" font-size="11" fill="var(--accent)" font-family="system-ui" font-weight="600">ROI: 340% on automation investment</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> LLM-IDP เข้าใจ intent ไม่ใช่แค่ extract characters — ข้ามจาก 80% ถึง 95%+ accuracy โดยไม่ต้อง template setup</div>

<!-- Speaker: ตลาด IDP โต 26%+/ปี — ทุก SI project ที่มีเอกสาร (invoice, PO, contract) คือ use case ที่ apply ได้ทันที -->

---

## UC5: Model-Agnostic Architecture ป้องกัน Vendor Lock-in

<p class="subhead">LLM integration ที่ดีต้องแยก business logic ออกจาก model layer — swap model โดยไม่ break workflow</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Layer 5 (top): Business Application -->
  <rect x="80" y="20" width="940" height="50" rx="8" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1"/>
  <text x="550" y="51" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Business Application Layer  (ERP / CRM / HRMS)</text>
  <!-- Arrow down -->
  <line x1="550" y1="70" x2="550" y2="88" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="543,82 550,90 557,82" fill="var(--muted)"/>
  <!-- Layer 4: Orchestration -->
  <rect x="80" y="90" width="940" height="50" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="121" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Orchestration Layer  (LangChain / LlamaIndex / custom agent framework)</text>
  <!-- Arrow down -->
  <line x1="550" y1="140" x2="550" y2="158" stroke="var(--accent)" stroke-width="1.5"/>
  <polygon points="543,152 550,160 557,152" fill="var(--accent)"/>
  <!-- Layer 3: Model Abstraction (KEY LAYER) -->
  <rect x="80" y="160" width="940" height="52" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="430" y="191" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Model Abstraction Layer</text>
  <text x="850" y="185" font-size="11" fill="var(--accent)" font-family="system-ui">swap model</text>
  <text x="850" y="202" font-size="11" fill="var(--accent)" font-family="system-ui">without breaking logic</text>
  <!-- Arrow down -->
  <line x1="550" y1="212" x2="550" y2="228" stroke="var(--accent)" stroke-width="1.5"/>
  <polygon points="543,222 550,230 557,222" fill="var(--accent)"/>
  <!-- Layer 2: LLM Models -->
  <rect x="80" y="230" width="940" height="50" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="200" y="261" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">GPT-4o</text>
  <text x="400" y="261" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude</text>
  <text x="600" y="261" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ThaiLLM</text>
  <text x="800" y="261" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Llama (local)</text>
  <text x="990" y="261" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">any</text>
  <!-- Arrow down -->
  <line x1="550" y1="280" x2="550" y2="295" stroke="var(--danger)" stroke-width="1.5"/>
  <polygon points="543,289 550,297 557,289" fill="var(--danger)"/>
  <!-- Layer 1 (bottom): Governance -->
  <rect x="80" y="297" width="940" height="36" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <text x="550" y="320" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Governance Layer  (PII detection | Audit log | Compliance check — real-time)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Model Abstraction คือ layer ที่สำคัญสุด — hardcode GPT-4 ใน business logic = vendor lock-in ที่ต้อง rework ทั้ง stack ภายหลัง</div>

<!-- Speaker: Governance layer ต้องรัน real-time ไม่ใช่ afterthought — shadow AI คือ regulatory risk จริงในองค์กรไทย -->

---

## ความร่วมมือนี้สร้าง Value รอบด้านให้ SI Tech

<p class="subhead">5 ประโยชน์ที่วัดได้ — ตั้งแต่ talent pipeline ถึง recurring revenue</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact gold">
    <p class="label">Talent</p>
    <h3>AI Talent Pipeline</h3>
    <p>ทดสอบ intern ก่อนตัดสินใจ hire — PoC เป็น extended interview</p>
  </div>
  <div class="card compact">
    <p class="label">Cost</p>
    <h3>PoC ต้นทุนต่ำ</h3>
    <p>ทดลอง use case 3-6 เดือน ก่อนลงทุน full product หรือ FTE</p>
  </div>
  <div class="card compact success">
    <p class="label">Speed</p>
    <h3>Scale AI เร็ว</h3>
    <p>5 workstreams run parallel ถ้ามี intern ครบ 4 บทบาท</p>
  </div>
  <div class="card compact warning">
    <p class="label">Client</p>
    <h3>Value ลูกค้า</h3>
    <p>AI features เพิ่ม stickiness + justify premium pricing</p>
  </div>
  <div class="card compact">
    <p class="label">Revenue</p>
    <h3>Recurring Revenue</h3>
    <p>AI Copilot, IDP คือ recurring service ต่าง one-time project</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Intern ไม่ใช่แค่ "แรงงานถูก" — คือ low-risk AI experimentation vehicle ที่ช่วย SI Tech พิสูจน์ ROI ก่อน commit ลงทุนใหญ่</div>

<!-- Speaker: เน้น framing นี้กับ management — intern PoC คือ "fail fast cheaply" mechanism ไม่ใช่แค่ CSR -->

---

## ระวัง 3 กับดักที่ทำให้ AI PoC ล้มเหลว

<p class="subhead">Governance, Hallucination, และ Scope creep — วางแผนก่อน intern เริ่มงาน ไม่ใช่ตามแก้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Governance Risk</p>
    <h3>ข้อมูลลูกค้า</h3>
    <p>Use cases ส่วนใหญ่ต้องเข้าถึง sensitive data ต้องมี data governance, NDA, role-based access ก่อน intern เริ่ม</p>
  </div>
  <div class="card warning">
    <p class="label">AI Risk</p>
    <h3>Hallucination</h3>
    <p>LLM-generated proposals/forecasts ต้องผ่าน human review เสมอ อย่า automate สมบูรณ์ใน high-stakes decisions</p>
  </div>
  <div class="card warning">
    <p class="label">Execution Risk</p>
    <h3>Scope vs Timeline</h3>
    <p>Intern timeline ≈ 3 เดือน ต้องวาง MVP scope ชัดก่อนเริ่ม PoC ง่ายกว่า production integration มาก — budget ต้องรวม hardening cost</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Plan governance + scope ก่อนเริ่ม — แก้ data access หลัง intern เริ่มงานแล้วคือ delay ที่ป้องกันได้</div>

<!-- Speaker: PoC ง่ายกว่า production integration 5-10x เสมอ — ต้องแจ้งความจริงนี้กับ client ตั้งแต่ต้น -->

---

## สรุป: AI Intern คือกลยุทธ์ Fail Fast ที่ต้นทุนต่ำ

<p class="subhead">SI Tech + Super AI Engineer = เส้นทางที่เร็วที่สุดสู่ AI-driven services จริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Callout box -->
  <rect x="40" y="20" width="1020" height="260" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="20" width="8" height="260" rx="4" fill="var(--accent)"/>
  <!-- Key points -->
  <circle cx="110" cy="72" r="16" fill="var(--accent)" opacity=".15"/>
  <circle cx="110" cy="72" r="10" fill="var(--accent)"/>
  <text x="110" y="77" font-size="10" fill="white" text-anchor="middle" font-weight="700" font-family="system-ui">1</text>
  <text x="140" y="68" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Super AI Engineer intern &#8800; fresh graduate</text>
  <text x="140" y="86" font-size="12" fill="var(--ink-dim)" font-family="system-ui">ผ่าน upskilling + hackathon + real-world selection มาแล้ว</text>
  <circle cx="110" cy="130" r="16" fill="var(--accent)" opacity=".15"/>
  <circle cx="110" cy="130" r="10" fill="var(--accent)"/>
  <text x="110" y="135" font-size="10" fill="white" text-anchor="middle" font-weight="700" font-family="system-ui">2</text>
  <text x="140" y="126" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">5 use cases ครอบ revenue, cost, efficiency</text>
  <text x="140" y="144" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Support Copilot, Proposal, Analytics, IDP, LLM Integration</text>
  <circle cx="110" cy="188" r="16" fill="var(--accent)" opacity=".15"/>
  <circle cx="110" cy="188" r="10" fill="var(--accent)"/>
  <text x="110" y="193" font-size="10" fill="white" text-anchor="middle" font-weight="700" font-family="system-ui">3</text>
  <text x="140" y="184" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Dashboard =/= ROI — embed predictions ใน workflow</text>
  <text x="140" y="202" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Model-agnostic architecture + governance layer ตั้งแต่ต้น</text>
  <circle cx="110" cy="246" r="16" fill="var(--gold)" opacity=".2"/>
  <circle cx="110" cy="246" r="10" fill="var(--gold)"/>
  <text x="110" y="251" font-size="10" fill="white" text-anchor="middle" font-weight="700" font-family="system-ui">4</text>
  <text x="140" y="242" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">PoC scope ต้องจำกัด — plan data governance ก่อน intern เริ่ม</text>
  <text x="140" y="260" font-size="12" fill="var(--ink-dim)" font-family="system-ui">3 เดือน = MVP ไม่ใช่ full product</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ความร่วมมือนี้สร้าง win-win — SI Tech ได้ PoC AI solutions ต้นทุนต่ำ + intern ได้ experience จาก production projects จริง</div>

<!-- Speaker: ปิดด้วย call to action: สมัครเป็น industry partner ของ Super AI Engineer Season 6 -->
