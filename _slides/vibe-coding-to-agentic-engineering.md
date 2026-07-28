---
marp: true
theme: default
paginate: true
title: "From Vibe Coding to Agentic Engineering"
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
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
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

![bg opacity:.25](assets/vibe-coding-to-agentic-engineering-cover.png)

<div class="mark"></div>

# From Vibe Coding to Agentic Engineering

<p class="tag">เลิกปล่อย AI เขียนโค้ดแบบไม่อ่าน diff — ลด maintenance cost ด้วย spec, architecture และ CI/CD guardrails</p>

<!-- Speaker: เปิดด้วยคำถาม — ใครในห้องเคย "Accept All" โดยไม่อ่าน diff บ้าง? -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #0D1117 -->

![bg fit](assets/vibe-coding-to-agentic-engineering-cheatsheet.png)

<!-- Speaker: 60 วินาที ชี้ 9 concept หลักในแผ่นนี้ก่อนเข้าเนื้อหาละเอียด -->

---

## TL;DR

<p class="subhead">Vibe coding ลด initial cost แต่บวม maintenance cost — ทางแก้คือคง human judgment ไว้ 2 ขั้นแรก และลง foundation ด้วย architecture ที่ดี</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="190" r="40" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="190" r="28" fill="var(--accent)"/>
  <text x="148" y="196" font-size="20" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">!</text>
  <text x="220" y="150" font-size="19" font-weight="700" fill="var(--ink)" font-family="system-ui">Even Karpathy moved on</text>
  <text x="220" y="182" font-size="14" fill="var(--ink-dim)" font-family="system-ui">The person who coined "vibe coding" now uses</text>
  <text x="220" y="204" font-size="14" fill="var(--ink-dim)" font-family="system-ui">"Agentic Engineering" instead</text>
  <text x="220" y="250" font-size="14" fill="var(--muted)" font-family="system-ui">Keep human judgment in: WHAT to build + spec grooming</text>
  <text x="220" y="272" font-size="14" fill="var(--muted)" font-family="system-ui">Let agents own: coding (clear spec) + CI/CD guardrails</text>
  <text x="220" y="294" font-size="14" fill="var(--muted)" font-family="system-ui">Foundation: Deep Modules + Hexagonal Architecture</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI ไม่ใช่ปัญหา — ปัญหาคือปล่อยให้ AI ทำงานโดยไม่มี spec, test, และ architecture รองรับ</div>

<!-- Speaker: ตั้งกรอบก่อนเข้ารายละเอียด — นี่ไม่ใช่การ anti-AI แต่คือการใช้ให้ถูกจังหวะ -->

---

## Vibe Coding: จุดเริ่มต้นจากทวีตของ Karpathy

![bg right:40% contain](assets/vibe-coding-to-agentic-engineering-vibe-origin.png)

<p class="subhead">"I 'Accept All' always, I don't read the diffs anymore" — Andrej Karpathy, กุมภาพันธ์ 2025</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="660" height="70" rx="10" fill="var(--soft)"/>
  <text x="40" y="55" font-size="15" fill="var(--ink)" font-family="system-ui" font-weight="700">Coined for: throwaway weekend projects</text>
  <text x="40" y="76" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Not intended for production software</text>
  <rect x="20" y="110" width="660" height="70" rx="10" fill="var(--danger-wash)"/>
  <text x="40" y="145" font-size="15" fill="var(--danger-ink)" font-family="system-ui" font-weight="700">Became: default workflow for many teams</text>
  <text x="40" y="166" font-size="12" fill="var(--danger-ink)" font-family="system-ui">"Accept All" without reading diffs, no refactor pass</text>
  <rect x="20" y="200" width="660" height="90" rx="10" fill="var(--soft)"/>
  <text x="40" y="230" font-size="14" fill="var(--ink)" font-family="system-ui" font-weight="700">Pre-AI precedent: Exploratory Coding</text>
  <text x="40" y="252" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Explore solutions fast, ignore architecture —</text>
  <text x="40" y="270" font-size="12" fill="var(--ink-dim)" font-family="system-ui">but always followed by a refactor pass. Vibe coding skips that.</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Vibe coding เหมาะกับ throwaway project เท่านั้น — ปัญหาคือคนเอาไปใช้กับ production โดยข้ามขั้น refactor</div>

<!-- Speaker: อ่าน quote ดังๆ แล้วถามว่ามันฟังดูเหมือนงานที่ทีมเราทำอยู่ทุกวันมั้ย -->

---

## Maintenance Cost กำลังบวมขึ้นจริง — ไม่ใช่แค่ความรู้สึก

<p class="subhead">ข้อมูลจากปี 2024-2025 ยืนยันว่า AI ที่ไม่มี guardrail สร้าง technical debt สะสมจริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning compact">
    <p class="label">McKinsey</p>
    <h3>~20%/ปี</h3>
    <p>ของต้นทุนพัฒนาเริ่มต้น ถูกใช้ไปกับ maintenance ทุกปี สะสมข้ามอายุการใช้งาน</p>
  </div>
  <div class="card danger compact">
    <p class="label">GitClear 2024</p>
    <h3>Duplication ×8</h3>
    <p>โค้ดซ้ำเพิ่มขึ้น 8 เท่าเทียบ 2 ปีก่อน copy-paste แซงหน้า refactor</p>
  </div>
  <div class="card danger compact">
    <p class="label">Google DORA</p>
    <h3>-7.2%</h3>
    <p>delivery stability ลดลง แม้ AI จะเร่งความเร็ว code review ได้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Initial cost ถูกลงเพราะ AI แต่ maintenance cost บวมขึ้นแบบไม่มีเพดานถ้าไม่มี guardrail คุม</div>

<!-- Speaker: เน้นว่าตัวเลขพวกนี้มาจาก report จริง ไม่ใช่ anecdote -->

---

## AI Slop กำลังทำร้าย Open Source จริง

<p class="subhead">ตัวอย่างจริงจากสองโปรเจกต์ที่ทุกคนรู้จัก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">curl · Daniel Stenberg (bagder)</p>
    <h3>49 fake security reports</h3>
    <p>รายงานช่องโหว่ AI-generated ที่ไม่ผ่านการตรวจสอบ ส่งมาหวังเงิน bug bounty — กลายเป็น DoS ใส่กระบวนการ maintain เอง</p>
  </div>
  <div class="card warning">
    <p class="label">Ghostty · Mitchell Hashimoto</p>
    <h3>AGENTS.md prompt-injection trap</h3>
    <p>ฝังคำสั่งลับให้ agent เขียน "I am a sad, dumb little AI driver" ถ้ามีคนเปิด PR โดยไม่อ่านโค้ดตัวเอง — ใช้กรอง contributor</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Maintainer กำลังสร้างกลไกป้องกันตัวเองจาก "AI slop" — สัญญาณว่าปัญหานี้เกิดขึ้นจริงในวงกว้าง</div>

<!-- Speaker: ถ้ามีคนในทีมเคยเปิด PR แบบไม่อ่านโค้ด นี่คือสิ่งที่เกิดขึ้นกับพวกเขาในโลกจริง -->

---

## แม้แต่ Karpathy เองก็เปลี่ยนคำ

<p class="subhead">จาก "vibe coding" สู่ "Agentic Engineering" — engineering ยังต้องมีศาสตร์และศิลป์</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"Vibe Coding" (2025)</text>
  <text x="80" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">"Fully give in to the vibes"</text>
  <text x="80" y="140" font-size="14" fill="var(--ink-dim)" font-family="system-ui">"Accept All", never read diffs</text>
  <text x="80" y="170" font-size="14" fill="var(--muted)" font-family="system-ui">Intended for weekend throwaway projects</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">"Agentic Engineering" (now)</text>
  <text x="610" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">"Engineering" = still needs craft</text>
  <text x="610" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">Engineer designs the factory,</text>
  <text x="610" y="166" font-size="14" fill="var(--ink)" font-family="system-ui">not just the output</text>
  <text x="610" y="196" font-size="14" fill="var(--ink)" font-family="system-ui">Quality still controlled by humans</text>
  <circle cx="550" cy="190" r="28" fill="var(--accent)"/>
  <text x="550" y="195" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">→</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> คนที่บัญญัติคำว่า "vibe" เองก็ไม่ชอบมันอีกแล้ว เพราะมันสื่อถึงความไม่ใส่ใจ</div>

<!-- Speaker: นี่คือหลักฐานว่าแม้แต่ต้นตำรับยังยอมรับว่าคำเดิมมีปัญหา -->

---

## 4 ขั้นตอนของ Dev Lifecycle — agent ช่วยได้ 80-90% ใน 3 ขั้นแรก

<p class="subhead">ขั้นที่ 4 (guardrail) automate อยู่แล้วผ่าน CI/CD — ที่คนยังไม่รู้คือ 3 ขั้นแรกก็ automate ได้เกือบหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="140" width="220" height="90" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="140" y="175" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1. What to Build</text>
  <text x="140" y="198" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Human decides priority</text>
  <path d="M 260 185 L 300 185" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <rect x="310" y="140" width="220" height="90" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="420" y="175" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Groom the Spec</text>
  <text x="420" y="198" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Human clarifies scope</text>
  <path d="M 540 185 L 580 185" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <rect x="590" y="140" width="220" height="90" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="700" y="175" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">3. Coding</text>
  <text x="700" y="198" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Agent, if spec is clear</text>
  <path d="M 820 185 L 860 185" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <rect x="870" y="140" width="200" height="90" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="970" y="175" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">4. Guardrails</text>
  <text x="970" y="198" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">CI/CD, already automated</text>
  <defs><marker id="arrow" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="var(--muted)"/></marker></defs>
  <text x="550" y="290" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Blue = requires human judgment · Green = agent-automatable</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยิ่งสเปคชัดและมี test คลุมตั้งแต่ขั้น 2 ยิ่งปล่อย agent ทำขั้น 3-4 ได้เต็มที่</div>

<!-- Speaker: ย้ำว่าขั้น 1-2 ต้องเป็นคน เพราะการตัดสินใจผิดทางแก้ทีหลังแพงกว่ามาก -->

---

## Coding แบ่ง 2 ประเภท: Easy Fix vs Large Feature

<p class="subhead">ระดับ automation ต่างกันตามความชัดของสเปคและ test coverage</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--success)" opacity=".12"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Easy Fix / Safe Refactor</text>
  <text x="80" y="110" font-size="14" fill="var(--success-ink)" font-family="system-ui">Test coverage มีอยู่แล้ว</text>
  <text x="80" y="140" font-size="14" fill="var(--success-ink)" font-family="system-ui">Behavior ต้องเหมือนเดิม</text>
  <text x="80" y="170" font-size="14" fill="var(--success-ink)" font-family="system-ui">วัดผลได้ชัดเจน (test/profiler)</text>
  <text x="80" y="220" font-size="15" font-weight="700" fill="var(--success-ink)" font-family="system-ui">→ agent ทำได้เกือบ 100%</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--warning)" opacity=".12"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Large Feature / Non-trivial</text>
  <text x="610" y="110" font-size="14" fill="var(--warning-ink)" font-family="system-ui">ต้องออกแบบ subsystem ใหม่</text>
  <text x="610" y="140" font-size="14" fill="var(--warning-ink)" font-family="system-ui">ไม่มีตัวอย่างใน codebase</text>
  <text x="610" y="170" font-size="14" fill="var(--warning-ink)" font-family="system-ui">ต้องการ flexible/scalable design</text>
  <text x="610" y="220" font-size="15" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">→ ต้องมี human-in-the-loop เยอะ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> รีวิว easy-fix PR แค่เช็คว่า test make sense + ไม่แหกดีไซน์ ปล่อยที่เหลือให้ CI/CD</div>

<!-- Speaker: ยกตัวอย่างงานในทีมตัวเอง ว่าอันไหนเข้าข่ายฝั่งซ้ายบ้าง -->

---

## Root Cause ของโค้ดที่ "แตะไม่ได้": ไม่ใช่ตัวคน คือ Architecture

<p class="subhead">นิยาม bad code: โค้ดที่แก้ไขได้ยาก — duplication, ไม่มี test, couple กับ infra แน่นเกินไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="30" width="500" height="280" rx="14" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="310" y="70" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Symptom (visible late)</text>
  <text x="90" y="120" font-size="14" fill="var(--danger-ink)" font-family="system-ui">"ระบบนี้แตะไม่ได้ ต้องเขียนใหม่"</text>
  <text x="90" y="150" font-size="14" fill="var(--danger-ink)" font-family="system-ui">Legacy system ที่ทีม maintain ยอมแพ้</text>
  <text x="90" y="180" font-size="14" fill="var(--danger-ink)" font-family="system-ui">Non-engineer มองไม่เห็นจนสายเกินแก้</text>
  <path d="M 570 170 L 620 170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow2)"/>
  <rect x="630" y="30" width="410" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="835" y="70" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Root Cause</text>
  <text x="660" y="120" font-size="14" fill="var(--ink)" font-family="system-ui">Code architecture ที่ไม่ดี</text>
  <text x="660" y="150" font-size="14" fill="var(--ink)" font-family="system-ui">+ ไม่มี test coverage</text>
  <text x="660" y="190" font-size="13" fill="var(--ink-dim)" font-family="system-ui">แก้ที่นี่ → symptom หายไปเอง</text>
  <text x="660" y="212" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ไม่ใช่แก้ที่ปลายเหตุ</text>
  <defs><marker id="arrow2" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> การแก้ที่ root cause (architecture) ถูกกว่าการรอจนต้องเขียนใหม่ทั้งระบบเสมอ</div>

<!-- Speaker: เชื่อมโยงกับเคสระบบ legacy ที่ทุกคนน่าจะเคยเจอในองค์กรตัวเอง -->

---

## Deep Module, Simple Interface

![bg right:40% contain](assets/vibe-coding-to-agentic-engineering-hexagonal.png)

<p class="subhead">ซ่อนความซับซ้อนไว้หลัง interface ง่ายๆ — concept เดียวกับ context engineering แต่ทำให้กับตัว codebase</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <path d="M 100 60 L 250 60 L 270 100 L 240 130 L 260 160 L 100 160 Z" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="2"/>
  <text x="175" y="105" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Simple</text>
  <text x="175" y="122" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Interface</text>
  <rect x="100" y="170" width="180" height="110" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="190" y="210" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Hidden</text>
  <text x="190" y="228" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">complexity</text>
  <text x="190" y="246" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(implementation)</text>
  <rect x="360" y="60" width="280" height="220" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="500" y="90" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Result</text>
  <text x="380" y="125" font-size="13" fill="var(--ink)" font-family="system-ui">~100 shallow modules</text>
  <text x="380" y="147" font-size="12" fill="var(--danger-ink)" font-family="system-ui">→ hard to hold in one head</text>
  <text x="380" y="185" font-size="13" fill="var(--ink)" font-family="system-ui">~20-30 deep modules</text>
  <text x="380" y="207" font-size="12" fill="var(--success-ink)" font-family="system-ui">→ smaller context window</text>
  <text x="380" y="229" font-size="12" fill="var(--success-ink)" font-family="system-ui">for both human AND agent</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Codebase ที่มี deep module น้อยตัวแต่ interface ชัด ทำให้ทั้งคนและ agent ไล่โค้ดโดยไม่ต้อง overload context</div>

<!-- Speaker: เชื่อม concept นี้กับ context engineering ที่หลายคนคุ้นเคยจากฝั่ง prompt -->

---

## Hexagonal Architecture: มองโค้ดเป็น Lego

<p class="subhead">Ports and Adapters (Alistair Cockburn, 2005) — เปลี่ยน adapter ได้โดยไม่แตะ core logic</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <polygon points="550,60 660,120 660,240 550,300 440,240 440,120" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="2.5"/>
  <text x="550" y="175" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Todo App</text>
  <text x="550" y="195" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">core logic</text>
  <rect x="80" y="70" width="220" height="60" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="190" y="95" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">CLI Adapter</text>
  <text x="190" y="115" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Driving Port</text>
  <path d="M 300 100 L 440 140" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="80" y="240" width="220" height="60" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="190" y="265" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Web Adapter</text>
  <text x="190" y="285" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Driving Port</text>
  <path d="M 300 260 L 440 220" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="800" y="70" width="220" height="60" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="910" y="95" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">File Persistence</text>
  <text x="910" y="115" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Driven Port</text>
  <path d="M 660 140 L 800 100" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="800" y="240" width="220" height="60" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="910" y="265" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">SQL Persistence</text>
  <text x="910" y="285" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Driven Port</text>
  <path d="M 660 220 L 800 260" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <defs><marker id="arrow3" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="var(--muted)"/></marker></defs>
  <text x="550" y="345" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Swap any adapter (file → SQL, CLI → web) — core never changes</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> สิ่งที่เปลี่ยนบ่อยที่สุดคือ adapter รอบนอก — core logic ตรงกลางแทบไม่ต้องแตะเลย</div>

<!-- Speaker: ยกตัวอย่าง Todo app จากวิดีโอต้นฉบับ — 4 ฟังก์ชัน add/remove/toggle/view เท่านั้นที่ core ต้อง define -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้จะข้ามเนื้อหาส่วนอื่นไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Human owns</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">what + spec</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Agent owns</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">easy-fix coding</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">CI/CD owns</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">guardrails</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Deep</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Modules</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Hexagonal</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Architecture</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agentic Engineering = คงสมองคนไว้ตรง "จะสร้างอะไร" แล้วปล่อยให้ agent + architecture ที่ดีจัดการที่เหลือ</div>

<!-- Speaker: ปิดด้วยคำถามกลับไปที่เปิด — วันนี้ทีมเราอยู่ตรงไหนของสเปกตรัมนี้ -->
