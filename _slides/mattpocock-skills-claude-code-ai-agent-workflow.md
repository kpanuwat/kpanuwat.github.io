---
marp: true
theme: default
paginate: true
title: "mattpocock/skills: AI Coding Workflow for Claude Code"
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
  section h2 { font-size:26px; margin:0 0 4px; color:var(--ink); font-weight:700; }
  .subhead { color:var(--ink-dim); font-size:14px; margin:0 0 8px; }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; min-height:0; }
  .takeaway {
    border-left:4px solid var(--accent); background:var(--soft);
    padding:12px 18px; border-radius:0 var(--radius-sm) var(--radius-sm) 0;
    font-size:13px; line-height:1.5;
  }
  .takeaway b { color:var(--accent); }
  .card {
    background:var(--paper); border-radius:var(--radius);
    box-shadow:var(--shadow-md); padding:16px 18px;
    border-left:4px solid var(--accent); box-sizing:border-box;
  }
  .card.success { border-left-color:var(--success); }
  .card.danger  { border-left-color:var(--danger); }
  .card.warning { border-left-color:var(--warning); }
  .card.gold    { border-left-color:var(--gold); }
  .card .label { font-size:10px; letter-spacing:.08em; text-transform:uppercase; color:var(--muted); margin:0 0 4px; }
  .card h3 { margin:0 0 6px; font-size:16px; color:var(--ink); font-weight:700; }
  .card p  { margin:0 0 4px; font-size:12.5px; color:var(--ink-dim); line-height:1.5; }
  .card ul { margin:0; padding-left:16px; font-size:12.5px; color:var(--ink-dim); line-height:1.8; }
  .card.compact { padding:10px 14px; }
  .card.compact h3 { font-size:13px; margin-bottom:4px; }
  .card.compact p, .card.compact .label { font-size:11px; }
  .bento { display:grid; gap:12px; width:100%; align-self:stretch; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
  .bento + .bento { margin-top:12px; }
  .infographic .bento { align-self:auto; }
  .infographic .bento .card { align-self:start; }
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
  section.title h1 { font-size:38px; color:white; margin:0 0 16px; line-height:1.25; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
  table { font-size:14px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/mattpocock-skills-claude-code-ai-agent-workflow-cover.png)

<div class="mark"></div>

# เจาะลึก mattpocock/skills: AI Coding Workflow ประหยัด Context Window

<p class="tag">A disciplined, user-invoked skill system for Claude Code, Cursor &amp; Codex — 176k★ MIT repo</p>

<!-- Speaker: เกริ่นว่า repo นี้คือ .agents directory ของ Matt Pocock ที่เปิดสาธารณะ แก้ปัญหา agent เขียนโค้ดมั่วและ context บวม -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/mattpocock-skills-claude-code-ai-agent-workflow-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้ง deck ใน 1 หน้า — 8 concept หลักตั้งแต่ install ถึง auto-commit -->

---

## TL;DR

<p class="subhead">สรุปสั้น ก่อนลงรายละเอียด</p>

<div class="infographic">
<div class="card gold" style="max-width:900px;">
<p class="label">mattpocock/skills</p>
<p style="font-size:16px;color:var(--ink);line-height:1.7;">
ชุด skill <b>user-invoked</b> สำหรับ Claude Code (และ Cursor, Codex) ที่กิน context แค่ ~660 token/skill
วางขั้นตอนพัฒนาแบบมีวินัย: คุยแผน (<code>/grill-with-docs</code>) → แตก spec/ticket ถ้าเกิน smart zone →
เขียนโค้ดพร้อม TDD (<code>/implement</code>) → sub-agent รีวิว (<code>/code-review</code>) → auto-commit
</p>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ผู้ใช้ควบคุม workflow เอง ไม่ใช่ปล่อยให้ agent เดาแล้วรันยาว</div>

<!-- Speaker: เน้นคำว่า user-invoked ตรงข้ามกับ vibe coding -->

---

## Background: ทำไม workflow นี้ถึงสำคัญ

![bg right:40% contain](assets/mattpocock-skills-claude-code-ai-agent-workflow-why-it-matters.png)

<p class="subhead">AI agent ที่ไม่มีวินัย มักเขียนโค้ดเร็วเกินไปและทำ context บวมจนโมเดล "โง่ลง"</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card compact success">
    <p class="label">Stars</p>
    <h3>176,203</h3>
    <p>Forks: 15,096</p>
  </div>
  <div class="card compact gold">
    <p class="label">License</p>
    <h3>MIT</h3>
    <p>สร้าง 3 ก.พ. 2026</p>
  </div>
  <div class="card compact">
    <p class="label">Overhead</p>
    <h3>~660 token</h3>
    <p>ต่อ skill</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Matt Pocock แชร์ .agents directory ที่ใช้จริงใน production ไม่ใช่ทฤษฎี</div>

<!-- Speaker: ตัวเลขยืนยันผ่าน GitHub API วันที่เผยแพร่บทความ -->

---

## ติดตั้งยังไง

<p class="subhead">2 ทางเลือกหลัก — ยืนยันตรงจาก README ของ repo</p>

<div class="infographic">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Option A — Skills Installer</p>
    <h3>npx skills@latest</h3>
    <p><code>npx skills@latest add mattpocock/skills</code></p>
    <p>เลือก agent เป้าหมาย (Claude Code / Cursor / Codex) และ scope (global/project)</p>
  </div>
  <div class="card success">
    <p class="label">Option B — Claude Code Plugin</p>
    <h3>plugin marketplace</h3>
    <p><code>claude plugin marketplace add mattpocock/skills</code></p>
    <p><code>claude plugin install mattpocock-skills@mattpocock</code></p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้งสองทางติดตั้งชุด skill เดียวกัน เลือกตามว่าใช้ Claude Code เป็นหลักหรือไม่</div>

<!-- Speaker: แนะนำ plugin marketplace ถ้าใช้ Claude Code อยู่แล้ว -->

---

## ตั้งค่าเชื่อม issue tracker

<p class="subhead">รันครั้งเดียวต่อ repo หลังติดตั้งเสร็จ</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card compact">
    <p class="label">Command</p>
    <h3>/setup-matt-pocock-skills</h3>
  </div>
  <div class="card compact warning">
    <p class="label">1. Issue Tracker</p>
    <p>GitHub, Linear หรือ local markdown files</p>
  </div>
  <div class="card compact warning">
    <p class="label">2. Triage Label</p>
    <p>ใช้สื่อสารสถานะ ticket ระหว่าง skill</p>
  </div>
</div>
<div class="bento cols-3" style="margin-top:12px;">
  <div class="card compact gold">
    <p class="label">3. Doc Layout</p>
    <p>Single context หรือ multi-context (monorepo)</p>
  </div>
  <div class="card compact">
    <p class="label">Result</p>
    <p>Skill อื่นบันทึก spec/ticket ไป tracker ที่เลือกอัตโนมัติ</p>
  </div>
  <div class="card compact">
    <p class="label">Frequency</p>
    <p>ครั้งเดียวต่อ repository</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งค่าครั้งเดียว skill ทั้งชุดใช้ config เดียวกันตลอด repo</div>

<!-- Speaker: ย้ำว่าตั้งครั้งเดียวไม่ต้องทำซ้ำทุก session -->

---

## Grill-with-docs: สัมภาษณ์แปลงไอเดียเป็นแผน

![bg right:40% contain](assets/mattpocock-skills-claude-code-ai-agent-workflow-grill-with-docs.png)

<p class="subhead">Agent ถามทีละคำถาม จนทั้งคู่เข้าใจตรงกัน ก่อนเขียนโค้ดแม้แต่บรรทัดเดียว</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="40" width="660" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="350" y="82" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/grill-with-docs</text>
  <path d="M350 110 L350 150" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <rect x="20" y="150" width="310" height="80" rx="10" fill="var(--accent)" opacity=".08"/>
  <text x="175" y="185" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CONTEXT.md</text>
  <text x="175" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">updated live</text>
  <rect x="370" y="150" width="310" height="80" rx="10" fill="var(--gold)" opacity=".12"/>
  <text x="525" y="185" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ADRs</text>
  <text x="525" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">decisions logged</text>
  <defs><marker id="arrow" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> v1.1 เพิ่ม confirmation gate กัน agent เขียนโค้ดก่อนแผนถูกยืนยัน</div>

<!-- Speaker: เน้นว่านี่คือจุดเริ่มต้นของ main flow ทุกครั้ง -->

---

## Smart Zone: เพดาน token ที่โมเดลยังคิดคมอยู่

<p class="subhead">ช่วง ~140,000 token ก่อนที่ attention จะเริ่มเสื่อมและ hallucinate ง่ายขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="300" height="90" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="190" y="65" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Task size</text>
  <text x="190" y="90" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">fits smart zone (~140k)?</text>
  <path d="M340 75 L420 75" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow2)"/>
  <path d="M190 120 L190 170 L340 220" stroke="var(--success)" stroke-width="2" marker-end="url(#arrow2)" fill="none"/>
  <text x="230" y="165" font-size="12" fill="var(--success-ink)" font-family="system-ui">YES</text>
  <rect x="420" y="30" width="300" height="90" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="570" y="65" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/implement</text>
  <text x="570" y="90" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไปต่อได้ทันที</text>
  <rect x="340" y="190" width="300" height="90" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="490" y="225" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">/to-spec</text>
  <text x="490" y="250" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">บีบเป็นสเปกเดียว</text>
  <path d="M640 235 L720 235" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow2)"/>
  <rect x="720" y="190" width="300" height="90" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="870" y="225" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">/to-tickets</text>
  <text x="870" y="250" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ตัดเป็น ticket ย่อย</text>
  <text x="190" y="150" font-size="12" fill="var(--danger-ink)" font-family="system-ui">NO</text>
  <defs><marker id="arrow2" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ห้าม clear context ตั้งแต่ grill ถึง to-tickets — ใช้ /handoff ถ้าใกล้ชนเพดานแทน</div>

<!-- Speaker: ย้ำว่าตัวเลข 140k เป็นแนวคิดเชิงประสบการณ์จากวิดีโอ ไม่ใช่ hard limit ในเอกสาร README -->

---

## Implement + Code-Review: sub-agent ตรวจสอบตัวเอง

<p class="subhead">Context สะอาดของ sub-agent ประเมินงานตรงไปตรงมากว่า agent ที่เขียนโค้ดเอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="100" width="230" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="135" y="135" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/implement</text>
  <text x="135" y="158" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ TDD at seams</text>
  <path d="M250 145 L300 145" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="300" y="60" width="240" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="420" y="93" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Sub-agent A</text>
  <text x="420" y="114" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">spec compliance</text>
  <rect x="300" y="160" width="240" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="420" y="193" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Sub-agent B</text>
  <text x="420" y="214" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">coding standards</text>
  <path d="M540 145 L610 145" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="610" y="100" width="230" height="90" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="725" y="135" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/code-review</text>
  <text x="725" y="158" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">2-axis pass?</text>
  <path d="M840 145 L890 145" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
  <rect x="890" y="100" width="190" height="90" rx="10" fill="var(--gold)" opacity=".15" stroke="var(--gold)" stroke-width="1.5"/>
  <text x="985" y="135" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">auto-commit</text>
  <text x="985" y="158" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">to current branch</text>
  <defs><marker id="arrow3" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ผ่านทั้ง 2 แกน (spec + standards) เมื่อไหร่ — commit ทันทีโดยไม่ต้องมีคนกดเอง</div>

<!-- Speaker: เน้นว่า sub-agent context แยกจาก agent ที่เขียนโค้ด คือหัวใจของความน่าเชื่อถือ -->

---

## โครงสร้าง skill ทั้งหมดใน repo

<p class="subhead">แบ่งเป็น 2 bucket หลัก ตรวจสอบตรงจาก README</p>

| Bucket | User-invoked | Model-invoked |
|---|---|---|
| **Engineering** | ask-matt, grill-with-docs, triage, improve-codebase-architecture, setup-matt-pocock-skills, to-spec, to-tickets, implement, wayfinder | prototype, diagnosing-bugs, research, tdd, domain-modeling, codebase-design, code-review, resolving-merge-conflicts |
| **Productivity** | grill-me, handoff, teach, writing-great-skills | grilling |

<div class="takeaway"><b>★ Takeaway:</b> ask-matt ทำหน้าที่ router — แผนที่รวมทุก skill ที่เรียกได้และความสัมพันธ์ระหว่างกัน</div>

<!-- Speaker: ตารางนี้เป็นข้อมูลหนาแน่น ใช้ native markdown table แทน SVG -->

---

## User Guide: 6 ขั้นตอนใช้งานจริง

<p class="subhead">ตั้งแต่ติดตั้งจนถึง workflow ประจำวัน</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card compact">
    <p class="label">1. ติดตั้ง</p>
    <p><code>npx skills@latest add mattpocock/skills</code></p>
  </div>
  <div class="card compact">
    <p class="label">2. ตั้งค่า tracker</p>
    <p><code>/setup-matt-pocock-skills</code> ครั้งเดียวต่อ repo</p>
  </div>
  <div class="card compact">
    <p class="label">3. คุยแผน</p>
    <p><code>/grill-with-docs</code> ตอบทีละคำถาม</p>
  </div>
</div>
<div class="bento cols-3">
  <div class="card compact warning">
    <p class="label">4. แตกงาน (ถ้าใหญ่)</p>
    <p><code>/to-spec</code> → <code>/to-tickets</code> ต่อเนื่องใน context เดียว</p>
  </div>
  <div class="card compact success">
    <p class="label">5. ลงมือทำ</p>
    <p><code>/implement</code> ต่อ 1 ticket, session ใหม่</p>
  </div>
  <div class="card compact gold">
    <p class="label">6. งานประจำวัน</p>
    <p><code>/triage</code>, <code>/improve-codebase-architecture</code>, <code>/handoff</code></p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ขั้น 3-4 ต้องอยู่ใน context window เดียวกัน ห้าม clear กลางทาง</div>

<!-- Speaker: ไล่ทีละขั้นแบบเร็ว เพราะรายละเอียดอยู่ใน Deep Dive slides ก่อนหน้าแล้ว -->

---

## Caveats / Limits

<p class="subhead">สิ่งที่ต้องระวังก่อนเอาไปใช้จริง</p>

<div class="infographic">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Skill Overload</p>
    <h3>เริ่มจากน้อยก่อน</h3>
    <p>อย่าติดตั้งทั้งหมดพร้อมกัน — เลือก skill หลักที่ตรงงานจริงก่อน</p>
  </div>
  <div class="card danger">
    <p class="label">TDD ไม่เหมาะทุกงาน</p>
    <h3>Exploratory UI</h3>
    <p>งานที่ spec ยังไม่นิ่ง TDD อาจถ่วงแทนที่จะเร่ง</p>
  </div>
</div>
<div class="bento cols-2">
  <div class="card">
    <p class="label">ตัวเลขไม่ Official</p>
    <h3>Smart zone ~140k</h3>
    <p>มาจากวิดีโอ/ชุมชน ไม่ใช่ hard limit ใน README/CLAUDE.md ของ repo</p>
  </div>
  <div class="card gold">
    <p class="label">อัปเดตบ่อย</p>
    <h3>ชื่อคำสั่งเคยเปลี่ยน</h3>
    <p>to-spec เดิมชื่อ to-prd, to-tickets เดิมชื่อ to-plan/to-issues</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> รัน npx skills@latest add ซ้ำเป็นระยะ เพื่อรับชื่อคำสั่งล่าสุด</div>

<!-- Speaker: เตือนผู้ฟังอย่าเชื่อตัวเลขที่ไม่มีใน official docs แบบไม่ตรวจสอบ -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ควรจำแม้ข้ามส่วนอื่นไปหมด</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card compact">
    <h3>User-invoked</h3>
    <p>ผู้ใช้สั่ง workflow เอง ไม่ปล่อยให้ agent เดา, ~660 token/skill</p>
  </div>
  <div class="card compact">
    <h3>ติดตั้งง่าย</h3>
    <p><code>npx skills@latest add mattpocock/skills</code> + <code>/setup-matt-pocock-skills</code></p>
  </div>
  <div class="card compact">
    <h3>Main Flow</h3>
    <p>grill-with-docs → to-spec/to-tickets → implement → code-review → auto-commit</p>
  </div>
  <div class="card compact success">
    <h3>Sub-agent Review</h3>
    <p>Context สะอาด ตรวจสอบตรงกว่า agent ที่เขียนโค้ดเอง</p>
  </div>
  <div class="card compact warning">
    <h3>Smart Zone</h3>
    <p>~140k token — อยู่ context เดียวจน to-tickets เสร็จ ใช้ /handoff ถ้าใกล้ชน</p>
  </div>
  <div class="card compact gold">
    <h3>176k★ MIT</h3>
    <p>เริ่มจาก skill น้อยๆ ก่อน และอัปเดต repo เป็นระยะ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วินัยของ workflow (คุยแผนก่อน, จำกัด context, ให้ sub-agent รีวิว) สำคัญกว่าจำนวน skill ที่ติดตั้ง</div>

<!-- Speaker: ปิดท้ายด้วยการย้ำว่านี่คือกรอบวินัย ไม่ใช่ magic bullet -->
