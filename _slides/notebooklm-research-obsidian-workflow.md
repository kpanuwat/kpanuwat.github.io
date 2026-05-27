---
marp: true
theme: default
paginate: true
title: "NotebookLM: สำรวจหัวข้อวิจัยด้วย AI ก่อนบันทึกลง Obsidian"
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
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:40px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# NotebookLM + Obsidian: Research Workflow

<p class="tag">สำรวจด้วย AI citation → กลั่นกรอง → บันทึกถาวรใน knowledge graph</p>

<!-- Speaker: ไม่ต้องเลือกอันใดอันหนึ่ง — ใช้สองอันตามลำดับ research → consolidation -->

---

## สองช่วงวิจัยที่ต้องการเครื่องมือต่างกัน

<p class="subhead">ปัญหาคือหลายคนใช้เครื่องมือเดียวทำทั้งสองช่วง — แก้ด้วย NotebookLM ก่อน Obsidian</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col -->
  <rect x="40" y="20" width="470" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="470" height="56" rx="12" fill="var(--soft)"/>
  <rect x="40" y="56" width="470" height="20" fill="var(--soft)"/>
  <text x="275" y="52" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Phase 1: Exploration</text>
  <text x="275" y="74" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ยังไม่รู้ว่าอะไรสำคัญ</text>
  <text x="80" y="115" font-size="13" fill="var(--ink)" font-family="system-ui">ถาม ทดสอบ เชื่อมโยงหลายแหล่ง</text>
  <text x="80" y="145" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ต้องการ response เร็ว + citation</text>
  <text x="80" y="175" font-size="13" fill="var(--muted)" font-family="system-ui">ข้อมูลอาจ discard ทีหลัง</text>
  <text x="80" y="230" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">NotebookLM</text>
  <text x="80" y="254" font-size="12" fill="var(--muted)" font-family="system-ui">1M token context + exact citation</text>

  <circle cx="550" cy="150" r="28" fill="var(--accent)"/>
  <text x="550" y="146" font-size="10" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">แล้ว</text>
  <text x="550" y="162" font-size="10" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">ค่อย</text>

  <rect x="590" y="20" width="470" height="260" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.12))"/>
  <rect x="590" y="20" width="470" height="56" rx="12" fill="var(--success-wash)"/>
  <rect x="590" y="56" width="470" height="20" fill="var(--success-wash)"/>
  <text x="825" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Phase 2: Consolidation</text>
  <text x="825" y="74" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">เข้าใจภาพรวมแล้ว</text>
  <text x="630" y="115" font-size="13" fill="var(--ink)" font-family="system-ui">เก็บ insight ที่กลั่นกรองแล้ว</text>
  <text x="630" y="145" font-size="13" fill="var(--ink-dim)" font-family="system-ui">เชื่อมกับความรู้เดิม</text>
  <text x="630" y="175" font-size="13" fill="var(--muted)" font-family="system-ui">สร้าง knowledge graph ถาวร</text>
  <text x="630" y="230" font-size="14" font-weight="700" fill="var(--success)" font-family="system-ui">Obsidian</text>
  <text x="630" y="254" font-size="12" fill="var(--muted)" font-family="system-ui">local files + bidirectional links</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> NotebookLM = สำรวจ, Obsidian = บันทึกถาวร — ใช้ตามลำดับ ไม่ใช่แทนกัน</div>

<!-- Speaker: เหตุผลที่ใช้ Obsidian ตั้งแต่แรกแล้วช้า — เสียเวลาจัดระเบียบก่อนเข้าใจหัวข้อ -->

---

## NotebookLM: 4 ความสามารถที่ต่างจาก AI ทั่วไป

<p class="subhead">ตอบจากแหล่งข้อมูลที่คุณเพิ่มเท่านั้น ไม่ hallucinate จากภายนอก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Context</p>
    <h3>1M Token Window</h3>
    <p>โหลด source ทั้งหมดพร้อมกัน ไม่ตัด chunk แบบ RAG ทั่วไป</p>
  </div>
  <div class="card success">
    <p class="label">Accuracy</p>
    <h3>Exact Citation</h3>
    <p>ทุกคำตอบมี original quote จาก source — คลิกดูบริบทต้นฉบับได้ทันที</p>
  </div>
  <div class="card warning">
    <p class="label">Persona</p>
    <h3>Custom AI Role</h3>
    <p>กำหนดบุคลิก AI ได้ เช่น "ผู้เชี่ยวชาญ UX ที่เน้น business impact"</p>
  </div>
  <div class="card gold">
    <p class="label">Audio</p>
    <h3>Podcast Summary</h3>
    <p>สร้าง podcast-style summary จาก sources ทั้งหมด — ฟังระหว่างเดินทาง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 1M token context + citation แม่นยำ = ลด hallucination ได้มากกว่า AI ทั่วไปมาก</div>

<!-- Speaker: ความต่างสำคัญ — RAG ตัด chunk, NotebookLM โหลดทั้งหมด citation จึงแม่นกว่า -->

---

## NotebookLM vs Obsidian: เลือกให้ถูกบริบท

<p class="subhead">ไม่ใช่คู่แข่ง — เป็น complementary tools สำหรับคนละ phase</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- table comparison -->
  <rect x="40" y="10" width="1020" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <!-- header -->
  <rect x="40" y="10" width="1020" height="50" rx="12" fill="var(--soft)"/>
  <rect x="40" y="45" width="1020" height="15" fill="var(--soft)"/>
  <text x="280" y="42" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">มิติ</text>
  <text x="600" y="42" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">NotebookLM</text>
  <text x="900" y="42" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Obsidian</text>
  <!-- col dividers -->
  <line x1="460" y1="60" x2="460" y2="270" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="760" y1="60" x2="760" y2="270" stroke="var(--soft-2)" stroke-width="1"/>
  <!-- row dividers -->
  <line x1="40" y1="105" x2="1060" y2="105" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="40" y1="150" x2="1060" y2="150" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="40" y1="195" x2="1060" y2="195" stroke="var(--soft-2)" stroke-width="1"/>
  <!-- rows -->
  <text x="100" y="87" font-size="13" fill="var(--ink)" font-family="system-ui">เหมาะกับ</text>
  <text x="600" y="87" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สำรวจหัวข้อใหม่, research</text>
  <text x="900" y="87" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เก็บความรู้ระยะยาว</text>
  <text x="100" y="132" font-size="13" fill="var(--ink)" font-family="system-ui">ข้อมูล</text>
  <text x="600" y="132" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Google Cloud</text>
  <text x="900" y="132" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">Local files (เป็นเจ้าของ)</text>
  <text x="100" y="177" font-size="13" fill="var(--ink)" font-family="system-ui">Linking</text>
  <text x="600" y="177" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ภายใน notebook</text>
  <text x="900" y="177" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">bidirectional + graph view</text>
  <text x="100" y="222" font-size="13" fill="var(--ink)" font-family="system-ui">ราคา</text>
  <text x="600" y="222" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ฟรี (มี Plus plan)</text>
  <text x="900" y="222" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ฟรี (มี Commercial)</text>
  <text x="100" y="257" font-size="12" fill="var(--danger)" font-family="system-ui">ห้าม: ข้อมูลลับ / proprietary</text>
  <text x="600" y="257" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">max 50 sources/notebook</text>
  <text x="900" y="257" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่จำกัด</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> NotebookLM ไม่ถาวร — ลบ notebook ข้อมูลหาย, ต้องโอนย้าย insight ไป Obsidian ก่อน</div>

<!-- Speaker: ข้อควรระวัง — อย่าใส่ข้อมูล confidential ใน NotebookLM เพราะอยู่บน Google Cloud -->

---

## Workflow ที่ใช้ร่วมกัน: Sources → Insight → Obsidian

<p class="subhead">โอนย้ายด้วยการถอดความ ไม่ใช่ copy-paste — บังคับให้เข้าใจจริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 4 steps -->
  <rect x="20" y="70" width="210" height="140" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="125" y="125" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sources</text>
  <text x="125" y="148" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PDF, URL, Doc</text>
  <text x="125" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">YouTube, Audio</text>
  <text x="125" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">max 50/notebook</text>

  <path d="M235 140 L278 140" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="278,134 290,140 278,146" fill="var(--accent)"/>

  <rect x="290" y="70" width="210" height="140" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.1))"/>
  <text x="395" y="115" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">NotebookLM</text>
  <text x="395" y="138" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถาม / ทดสอบ</text>
  <text x="395" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Audio Overview</text>
  <text x="395" y="178" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Custom Persona</text>
  <text x="395" y="198" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">citation แม่นยำ</text>

  <path d="M505 140 L548 140" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="548,134 560,140 548,146" fill="var(--accent)"/>

  <rect x="560" y="70" width="210" height="140" rx="12" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(245,158,11,.1))"/>
  <text x="665" y="115" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">กลั่นกรอง</text>
  <text x="665" y="138" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เลือก actionable</text>
  <text x="665" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">insights เท่านั้น</text>
  <text x="665" y="178" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ copy ทุกอย่าง</text>
  <text x="665" y="198" font-size="11" fill="var(--warning)" text-anchor="middle" font-family="system-ui">ถอดความด้วยตัวเอง</text>

  <path d="M775 140 L818 140" stroke="var(--success)" stroke-width="2" fill="none"/>
  <polygon points="818,134 830,140 818,146" fill="var(--success)"/>

  <rect x="830" y="70" width="240" height="140" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.15))"/>
  <text x="950" y="115" font-size="14" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Obsidian Note</text>
  <text x="950" y="138" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เขียนด้วยคำของตัวเอง</text>
  <text x="950" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">link กับ note เดิม</text>
  <text x="950" y="178" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">ถาวร + searchable</text>
  <text x="950" y="198" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">knowledge graph เติบโต</text>

  <text x="550" y="250" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ขั้นตอนสำคัญ: ไม่ copy ทุกอย่าง — เลือกเฉพาะ insight ที่ผ่านการทดสอบด้วยคำถามแล้วว่าสำคัญจริง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> การถอดความบังคับให้เข้าใจจริง — copy-paste เพียงแค่ย้ายข้อมูล ไม่ได้สร้างความรู้</div>

<!-- Speaker: ขั้นตอนที่คนมักข้าม — กลั่นกรองก่อน ไม่ใช่ dump ทุกอย่างลง Obsidian -->

---

## Key Takeaways — Research Workflow ที่ถูกต้อง

<p class="subhead">เครื่องมือที่ดีใช้ได้เฉพาะช่วงที่เหมาะ — ผิด phase = ประสิทธิภาพตก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">NotebookLM</p>
    <h3>AI Research Assistant</h3>
    <p>ไม่ใช่ note-taking app — ตอบจาก sources ของคุณเท่านั้น 1M token + citation แม่นยำ</p>
    <p>หนึ่ง notebook = หนึ่งหัวข้อ อย่า mix</p>
  </div>
  <div class="card success">
    <p class="label">Obsidian</p>
    <h3>Permanent Knowledge Base</h3>
    <p>local files เป็นเจ้าของเอง, bidirectional links, graph view สำหรับ insight ระยะยาว</p>
    <p>เขียนด้วยคำของตัวเอง ไม่ copy-paste</p>
  </div>
  <div class="card gold">
    <p class="label">Workflow</p>
    <h3>ตามลำดับ ไม่แทนกัน</h3>
    <p>Explore → NotebookLM (fast, cited)</p>
    <p>Consolidate → Obsidian (permanent, linked)</p>
    <p>ห้ามใส่ข้อมูลลับใน NotebookLM</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> NotebookLM = สำรวจ, Obsidian = บันทึกถาวร — ใช้ตามลำดับ research phase ได้ผลดีที่สุด</div>

<!-- Speaker: ถ้าจำได้อย่างเดียว — ใช้ NotebookLM ก่อนเมื่อยังไม่รู้ว่าอะไรสำคัญ แล้วค่อย Obsidian -->
