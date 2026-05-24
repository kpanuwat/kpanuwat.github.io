---
marp: true
theme: default
paginate: true
title: "Software 3.0: AI Agents เปลี่ยนโมเดลธุรกิจ"
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

# Software 3.0: AI Agents เปลี่ยนโมเดลธุรกิจ

<p class="tag">Karpathy framework — Prompts แทน Code, ขาย Outcome ไม่ใช่ Process, สร้าง Moat ที่ยั่งยืน</p>

<!-- Speaker: Software 3.0 ไม่ใช่แค่เทรนด์ — เป็น paradigm shift ที่เปลี่ยน moat ทางธุรกิจจากรากฐาน -->

---

## Software 3.0 คือ: Prompts เป็น Programming Language ใหม่

<p class="subhead">Karpathy: "Prompting a language model is a form of programming" — LLM คือ runtime ของ Software 3.0</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-era evolution arrow flow -->
  <!-- Era 1 box -->
  <rect x="30" y="80" width="300" height="220" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="80" width="300" height="48" rx="12" fill="var(--soft-2)"/>
  <text x="180" y="110" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Software 1.0</text>
  <text x="180" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Traditional Code</text>
  <text x="180" y="166" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Developer เขียน</text>
  <text x="180" y="186" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">if-else, algorithm</text>
  <text x="180" y="206" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทุกบรรทัด</text>
  <rect x="50" y="238" width="260" height="44" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="180" y="256" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Moat:</text>
  <text x="180" y="274" font-size="12" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Technical Expertise</text>
  <!-- Arrow 1 -->
  <path d="M340 190 L390 190" stroke="var(--accent)" stroke-width="2.5" fill="none"/>
  <polygon points="390,183 404,190 390,197" fill="var(--accent)"/>
  <!-- Era 2 box -->
  <rect x="404" y="80" width="290" height="220" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="404" y="80" width="290" height="48" rx="12" fill="var(--soft-2)"/>
  <text x="549" y="110" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Software 2.0</text>
  <text x="549" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Neural Networks (2017)</text>
  <text x="549" y="166" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Train จาก data</text>
  <text x="549" y="186" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"Program" = model</text>
  <text x="549" y="206" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">weights</text>
  <rect x="424" y="238" width="250" height="44" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="549" y="256" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Moat:</text>
  <text x="549" y="274" font-size="12" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Data Volume + Compute</text>
  <!-- Arrow 2 -->
  <path d="M704 190 L754 190" stroke="var(--accent)" stroke-width="2.5" fill="none"/>
  <polygon points="754,183 768,190 754,197" fill="var(--accent)"/>
  <!-- Era 3 box (highlighted) -->
  <rect x="768" y="60" width="302" height="260" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="768" y="60" width="302" height="52" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="919" y="92" font-size="17" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Software 3.0</text>
  <text x="919" y="112" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">NOW</text>
  <text x="919" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prompt Foundation</text>
  <text x="919" y="170" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Models ด้วย natural</text>
  <text x="919" y="190" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">language</text>
  <text x="919" y="214" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Context window =</text>
  <text x="919" y="234" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">programming surface</text>
  <rect x="788" y="262" width="262" height="44" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="919" y="280" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Moat:</text>
  <text x="919" y="298" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Domain Knowledge + Orchestration</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Software 3.0 กำลัง eat 1.0 และ 2.0 พร้อมกัน — moat ที่เคยอิง code complexity เริ่มหมดอายุ</div>

<!-- Speaker: Karpathy essay 2017 นิยาม 2.0; Sequoia AI Ascent 2026 เพิ่ม 3.0 — ทั้งสามยังอยู่ร่วมกัน ต้องรู้ว่าใช้ layer ไหน -->

---

## Verifiability บอกว่า Workflow ไหนจะถูก Disrupt ก่อน

<p class="subhead">Karpathy: ยิ่ง output ตรวจง่าย ยิ่ง automate ได้เร็ว — high-verifiability domains มีความเสี่ยงสูงสุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Table header -->
  <rect x="40" y="20" width="1020" height="46" rx="8" fill="var(--accent)" opacity=".12"/>
  <text x="200" y="48" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Workflow</text>
  <text x="500" y="48" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Verifiability</text>
  <text x="800" y="48" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ความเสี่ยง Disruption</text>
  <!-- Row 1 - High risk -->
  <rect x="40" y="70" width="1020" height="56" rx="0" fill="var(--danger-wash)"/>
  <text x="200" y="103" font-size="15" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tax Calculation</text>
  <rect x="440" y="82" width="120" height="32" rx="16" fill="var(--danger)"/>
  <text x="500" y="103" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">High</text>
  <rect x="680" y="82" width="240" height="32" rx="8" fill="var(--danger)" opacity=".15"/>
  <text x="800" y="103" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">สูงมาก — automate ได้เร็ว</text>
  <!-- Row 2 -->
  <rect x="40" y="128" width="1020" height="56" rx="0" fill="var(--warning-wash)"/>
  <text x="200" y="161" font-size="15" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Contract Review</text>
  <rect x="420" y="140" width="160" height="32" rx="16" fill="var(--warning)"/>
  <text x="500" y="161" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Medium</text>
  <rect x="680" y="140" width="240" height="32" rx="8" fill="var(--warning)" opacity=".15"/>
  <text x="800" y="161" font-size="14" font-weight="600" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">สูง — checklist-based</text>
  <!-- Row 3 -->
  <rect x="40" y="186" width="1020" height="56" rx="0" fill="var(--soft)"/>
  <text x="200" y="219" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Creative Content</text>
  <rect x="420" y="198" width="160" height="32" rx="16" fill="var(--muted)"/>
  <text x="500" y="219" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Low</text>
  <rect x="680" y="198" width="220" height="32" rx="8" fill="var(--soft-2)"/>
  <text x="800" y="219" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ปานกลาง</text>
  <!-- Row 4 -->
  <rect x="40" y="244" width="1020" height="56" rx="0" fill="var(--success-wash)"/>
  <text x="200" y="277" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Strategic Decision</text>
  <rect x="400" y="256" width="200" height="32" rx="16" fill="var(--success)"/>
  <text x="500" y="277" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Very Low</text>
  <rect x="680" y="256" width="200" height="32" rx="8" fill="var(--success)" opacity=".15"/>
  <text x="800" y="277" font-size="14" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ต่ำ — ต้อง judgment</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Legal research, financial analysis, code review — ล้วนอยู่ในโซน high-risk disruption แล้วในปี 2025-2026</div>

<!-- Speaker: Finance/legal/compliance เริ่มถูก disrupt แล้ว; creative/strategic ยังปลอดภัยกว่า เพราะ output ตรวจยาก -->

---

## 5 Moats ที่ยั่งยืนใน Software 3.0 Era

<p class="subhead">เมื่อ "simple prompts are commoditized" — moat ใหม่คือ Data, Knowledge, Orchestration, Trust</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card gold">
    <p class="label">Moat 1</p>
    <h3>Specialized Domain Knowledge</h3>
    <p>Domain experts เปลี่ยนเป็น "prompt architects" — Palantir เป็นตัวอย่าง: moat ไม่ใช่ code แต่เป็น intel workflow knowledge</p>
  </div>
  <div class="card">
    <p class="label">Moat 2</p>
    <h3>Proprietary Data Assets</h3>
    <p>Bloomberg Terminal, Tesla driving data — AI ทั่วไปไม่มีสิทธิ์ access แต่ระบบของธุรกิจมี</p>
  </div>
  <div class="card warning">
    <p class="label">Moat 3</p>
    <h3>Complex Workflow Orchestration</h3>
    <p>Multi-agent end-to-end systems ที่ competitor replicate ยาก — KPMG TaxBot เป็นตัวอย่าง</p>
  </div>
  <div class="card success">
    <p class="label">Moat 4</p>
    <h3>Human-AI Feedback Loops</h3>
    <p>Tight loop ระหว่าง human expertise กับ AI — สะสม institutional knowledge ที่ competitor เริ่มจากศูนย์</p>
  </div>
  <div class="card danger">
    <p class="label">Moat 5</p>
    <h3>Brand Trust & Accountability</h3>
    <p>ลูกค้าจ่ายเพิ่มเพื่อ "accountable entity" ที่รับผิดชอบ outcome — track record = premium</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "ใช้ AI เป็น" ไม่ใช่ moat — moat แท้จริงคือ data + knowledge + orchestration ที่ competitor ต้องใช้เวลาหลายปีสร้าง</div>

<!-- Speaker: เน้น moat 1+2 ก่อน — ถ้าองค์กรมี proprietary data ที่ยังไม่ถูก AI-accessible นั่นคือโอกาสที่ใหญ่ที่สุด -->

---

## Vibe Coding vs Agentic Engineering: คุณเลือกแบบไหน

<p class="subhead">Karpathy แยก 2 paradigm — democratize building vs maintain professional standards</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Vibe Coding -->
  <rect x="30" y="20" width="480" height="300" rx="14" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="56" rx="14" fill="var(--warning)" opacity=".2"/>
  <text x="270" y="52" font-size="18" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Vibe Coding</text>
  <text x="270" y="96" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ให้ AI เขียน code โดยไม่ต้องเข้าใจ</text>
  <text x="270" y="124" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Democratizes building</text>
  <text x="270" y="148" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เหมาะกับ prototype</text>
  <rect x="60" y="178" width="420" height="100" rx="8" fill="var(--warning)" opacity=".1"/>
  <text x="270" y="202" font-size="13" font-weight="600" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Production path ยังต้องการ:</text>
  <text x="270" y="224" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">auth + payments + deployment</text>
  <text x="270" y="248" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ล้วน labor-intensive</text>
  <!-- Divider -->
  <circle cx="550" cy="170" r="32" fill="var(--accent)" opacity=".12"/>
  <circle cx="550" cy="170" r="24" fill="var(--accent)"/>
  <text x="550" y="175" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- Right: Agentic Engineering -->
  <rect x="590" y="20" width="480" height="300" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="56" rx="14" fill="var(--accent)" opacity=".15"/>
  <text x="830" y="52" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Agentic Engineering</text>
  <text x="830" y="96" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">มนุษย์ maintain standards ขณะ leverage AI</text>
  <text x="830" y="124" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Security + Architecture + Reliability</text>
  <text x="830" y="148" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Production-grade systems</text>
  <rect x="620" y="178" width="420" height="100" rx="8" fill="var(--accent)" opacity=".08"/>
  <text x="830" y="202" font-size="13" font-weight="600" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Human role shifts to:</text>
  <text x="830" y="224" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">"Decide what's worth building"</text>
  <text x="830" y="248" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">"Define what good looks like"</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "You can outsource thinking. You cannot outsource understanding." — Karpathy: understanding ยิ่งสำคัญขึ้นใน Software 3.0</div>

<!-- Speaker: Vibe coding OK สำหรับ hackathon/prototype; production systems ต้องการ agentic engineering mindset -->

---

## เลิกขาย "Process" — เริ่มขาย "Outcome"

<p class="subhead">Strategic shift ที่สำคัญที่สุด: AI รับผิดชอบ orchestration, ลูกค้าซื้อผลลัพธ์สุดท้าย</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Old model -->
  <rect x="30" y="20" width="468" height="300" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="20" width="468" height="52" rx="14" fill="var(--soft-2)"/>
  <text x="264" y="50" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Old Model (1.0 / 2.0)</text>
  <!-- old model rows -->
  <text x="60" y="98" font-size="12" fill="var(--muted)" font-family="system-ui">ลูกค้าซื้อ:</text>
  <text x="160" y="98" font-size="13" fill="var(--ink-dim)" font-family="system-ui">software tool + training + support</text>
  <text x="60" y="128" font-size="12" fill="var(--muted)" font-family="system-ui">ลูกค้าทำเอง:</text>
  <text x="160" y="128" font-size="13" fill="var(--ink-dim)" font-family="system-ui">เรียนใช้เครื่องมือ → ทำงาน → ผลลัพธ์</text>
  <text x="60" y="158" font-size="12" fill="var(--muted)" font-family="system-ui">ราคา:</text>
  <text x="160" y="158" font-size="13" fill="var(--ink-dim)" font-family="system-ui">license fee + consulting hours</text>
  <!-- examples old -->
  <rect x="50" y="182" width="428" height="118" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="264" y="206" font-size="12" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตัวอย่าง:</text>
  <text x="264" y="228" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Law firm: bill by hour for doc review</text>
  <text x="264" y="252" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Marketing: sell content creation hours</text>
  <text x="264" y="276" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Accounting: charge per return prepared</text>
  <!-- Arrow -->
  <path d="M508 170 L560 170" stroke="var(--accent)" stroke-width="3" fill="none"/>
  <polygon points="560,161 578,170 560,179" fill="var(--accent)"/>
  <text x="543" y="152" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">shift</text>
  <!-- New model -->
  <rect x="580" y="20" width="490" height="300" rx="14" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="580" y="20" width="490" height="52" rx="14" fill="var(--accent)" opacity=".15"/>
  <text x="825" y="50" font-size="17" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">New Model (Software 3.0)</text>
  <!-- new model rows -->
  <text x="610" y="98" font-size="12" fill="var(--accent)" font-weight="600" font-family="system-ui">ลูกค้าซื้อ:</text>
  <text x="710" y="98" font-size="13" fill="var(--ink)" font-family="system-ui">ผลลัพธ์ (contract reviewed, leads qualified)</text>
  <text x="610" y="128" font-size="12" fill="var(--accent)" font-weight="600" font-family="system-ui">ธุรกิจรับผิดชอบ:</text>
  <text x="750" y="128" font-size="13" fill="var(--ink)" font-family="system-ui">orchestrate AI → deliver outcome</text>
  <text x="610" y="158" font-size="12" fill="var(--accent)" font-weight="600" font-family="system-ui">ราคา:</text>
  <text x="710" y="158" font-size="13" fill="var(--ink)" font-family="system-ui">outcome-based / success fee</text>
  <!-- examples new -->
  <rect x="600" y="182" width="450" height="118" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1"/>
  <text x="825" y="206" font-size="12" font-weight="600" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ตัวอย่าง:</text>
  <text x="825" y="228" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Law firm: flat fee per contract reviewed</text>
  <text x="825" y="252" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Marketing: sell leads generated / conversion</text>
  <text x="825" y="276" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Accounting: subscription for compliance</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ธุรกิจที่ยังขาย "step" หรือ "process" จะ commoditize — ธุรกิจที่ขาย "outcome" ด้วย AI-backed guarantee จะสร้าง defensible position</div>

<!-- Speaker: นี่คือ shift ที่ disrupt ได้ทุกอุตสาหกรรม; เริ่มจากถามว่า "ลูกค้าจ่ายเงินเพื่อได้ผลลัพธ์อะไร?" แล้ว AI ช่วย deliver ได้ไหม -->

---

## Key Takeaways: Software 3.0 Playbook

<p class="subhead">จาก Karpathy framework สู่การ action — 6 insights ที่นำไปใช้ได้ทันที</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Paradigm</p>
    <h3>Prompts = Programming</h3>
    <p>Context window คือ programming surface ใหม่ — LLM คือ runtime ที่รับ natural language แทน code</p>
  </div>
  <div class="card warning">
    <p class="label">Disruption Signal</p>
    <h3>Verifiability = Risk</h3>
    <p>High-verifiability workflow (finance, compliance, legal) คือ zone ที่ถูก disrupt ก่อน — ประเมิน portfolio ของธุรกิจตอนนี้</p>
  </div>
  <div class="card gold">
    <p class="label">Moat Strategy</p>
    <h3>Data + Knowledge + Trust</h3>
    <p>Proprietary data, domain expertise, complex orchestration, brand accountability — ไม่ใช่แค่ "ใช้ AI เป็น"</p>
  </div>
</div>
<div class="bento cols-3" style="margin-top:12px;">
  <div class="card success">
    <p class="label">Business Model</p>
    <h3>ขาย Outcome ไม่ใช่ Process</h3>
    <p>เลิก charge by hour/step → charge by outcome delivered — AI orchestration เป็น engine ที่ซ่อนอยู่</p>
  </div>
  <div class="card">
    <p class="label">Engineering Practice</p>
    <h3>Agentic ไม่ใช่ Vibe</h3>
    <p>Production systems ต้องการ security, reliability, proper architecture — "You can outsource thinking, not understanding"</p>
  </div>
  <div class="card danger">
    <p class="label">Caveat</p>
    <h3>Prototype ≠ Production</h3>
    <p>Hallucination risk ใน high-stakes domains; regulation lag; moat ต้องอยู่ที่ data/knowledge ไม่ใช่ technology</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Software 3.0 ไม่ได้แค่เปลี่ยนวิธีเขียน code — มันเปลี่ยนว่าธุรกิจควรขายอะไรและสร้าง moat จากอะไร</div>

<!-- Speaker: จบด้วย call-to-action: audit ว่า workflow ใดใน org มี verifiability สูง → นั่นคือจุดเริ่มต้นของ AI transformation -->
