---
marp: true
theme: default
paginate: true
title: "OpenSpec EP1: Spec-Driven Development คืออะไร"
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

# OpenSpec EP1: Spec-Driven Development คืออะไร

<p class="tag">และทำไมมันสำคัญกับการเขียนโค้ดด้วย AI — เจาะลึก OpenSpec สำหรับ Beginners</p>

<!-- Speaker: OpenSpec คือ framework ที่แก้ปัญหา vibe coding ด้วย Spec-Driven Development -->

---

## Vibe Coding พัง Project ใหญ่เสมอ

<p class="subhead">บอก AI โดยตรงโดยไม่มี spec — ทำงานได้กับ feature เล็ก แต่พังเมื่อ project ขยาย</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Problems flow from vibe coding -->
  <rect x="40" y="120" width="200" height="120" rx="12" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="2"/>
  <text x="140" y="166" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Vibe Coding</text>
  <text x="140" y="188" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"ทำ X ให้หน่อย"</text>
  <text x="140" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่มี spec</text>
  <!-- Arrow right -->
  <line x1="245" y1="180" x2="310" y2="180" stroke="var(--danger)" stroke-width="2.5" stroke-dasharray="6,3"/>
  <polygon points="310,174 322,180 310,186" fill="var(--danger)"/>
  <!-- 4 problem boxes -->
  <rect x="330" y="20" width="220" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="440" y="56" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">AI ตีความผิด</text>
  <text x="440" y="76" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">แก้อย่างนึง พัง 3 อย่าง</text>
  <rect x="580" y="20" width="220" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="690" y="56" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มีเอกสาร</text>
  <text x="690" y="76" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ทีมอื่นไม่รู้ว่าทำอะไร</text>
  <rect x="330" y="260" width="220" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="440" y="296" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Code review ยาก</text>
  <text x="440" y="316" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่รู้ว่าตรง requirement ไหม</text>
  <rect x="580" y="260" width="220" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="690" y="296" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Rollback ยาก</text>
  <text x="690" y="316" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี baseline ของระบบ</text>
  <!-- Lines from arrow to boxes -->
  <line x1="322" y1="180" x2="380" y2="100" stroke="var(--danger)" stroke-width="1.5" opacity=".5"/>
  <line x1="322" y1="180" x2="630" y2="100" stroke="var(--danger)" stroke-width="1.5" opacity=".5"/>
  <line x1="322" y1="180" x2="380" y2="260" stroke="var(--danger)" stroke-width="1.5" opacity=".5"/>
  <line x1="322" y1="180" x2="630" y2="260" stroke="var(--danger)" stroke-width="1.5" opacity=".5"/>
  <!-- Solution label -->
  <rect x="860" y="130" width="200" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="960" y="170" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">OpenSpec</text>
  <text x="960" y="192" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">แก้ทุกปัญหานี้</text>
  <line x1="810" y1="180" x2="855" y2="180" stroke="var(--success)" stroke-width="2"/>
  <polygon points="855,174 867,180 855,186" fill="var(--success)"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Vibe coding ทำงานได้สำหรับ feature เล็ก แต่พัง project ใหญ่เสมอเพราะไม่มี spec</div>

<!-- Speaker: 4 ปัญหาหลักของการ code โดยไม่มี spec -->

---

## Spec-Driven Development: เขียน Spec ก่อน แล้ว AI Implement

<p class="subhead">OpenSpec บังคับให้มี artifacts ตกลงกันก่อน — AI implement ตาม spec ไม่ใช่ตามการเดา</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Arrow flow: propose → artifacts → apply → archive -->
  <rect x="30" y="110" width="180" height="120" rx="14" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="2"/>
  <text x="120" y="162" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">/opsx:propose</text>
  <text x="120" y="184" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">บอก idea</text>
  <text x="120" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">AI สร้าง artifacts</text>
  <!-- Arrow -->
  <line x1="215" y1="170" x2="268" y2="170" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="268,164 280,170 268,176" fill="var(--accent)"/>
  <!-- Artifacts box -->
  <rect x="285" y="60" width="280" height="220" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="425" y="92" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Artifacts</text>
  <rect x="305" y="104" width="240" height="38" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="425" y="128" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">proposal.md — ทำไม + ทำอะไร</text>
  <rect x="305" y="148" width="240" height="38" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="425" y="172" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/ — requirements</text>
  <rect x="305" y="192" width="240" height="38" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="425" y="216" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">design.md — technical approach</text>
  <rect x="305" y="236" width="240" height="36" rx="8" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="1"/>
  <text x="425" y="259" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">tasks.md — checklist</text>
  <!-- Review label -->
  <text x="425" y="298" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Review ก่อน apply</text>
  <!-- Arrow -->
  <line x1="570" y1="170" x2="623" y2="170" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="623,164 635,170 623,176" fill="var(--accent)"/>
  <!-- Apply box -->
  <rect x="640" y="110" width="180" height="120" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="730" y="162" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/opsx:apply</text>
  <text x="730" y="184" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AI implement</text>
  <text x="730" y="204" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ตาม tasks.md</text>
  <!-- Arrow -->
  <line x1="825" y1="170" x2="878" y2="170" stroke="var(--accent)" stroke-width="2.5"/>
  <polygon points="878,164 890,170 878,176" fill="var(--accent)"/>
  <!-- Archive box -->
  <rect x="895" y="110" width="180" height="120" rx="14" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="985" y="162" font-size="15" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/opsx:archive</text>
  <text x="985" y="184" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เก็บ artifacts</text>
  <text x="985" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใน git history</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SDD = ตกลง spec ก่อน → AI implement ตาม spec — ไม่ใช่ตามการเดา</div>

<!-- Speaker: Key ของ OpenSpec คือ artifacts เป็น "สัญญา" ระหว่าง dev กับ AI -->

---

## 4 แนวคิดหลักของ OpenSpec

<p class="subhead">ไม่ใช่ waterfall — fluid, iterative, ปรับ spec ระหว่าง implement ได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Principle 1</p>
    <h3>Fluid not Rigid</h3>
    <p>ไม่บังคับ phase; ทำ artifact ได้ยืดหยุ่นตามที่ทำงานได้ดีที่สุด</p>
  </div>
  <div class="card success">
    <p class="label">Principle 2</p>
    <h3>Iterative not Waterfall</h3>
    <p>ปรับ spec ได้เมื่อเข้าใจ requirement มากขึ้นระหว่าง implement</p>
  </div>
  <div class="card warning">
    <p class="label">Principle 3</p>
    <h3>Easy not Complex</h3>
    <p>ติดตั้งใน 1 คำสั่ง ใช้งานได้ทันที ไม่มี ceremony ยาวๆ</p>
  </div>
  <div class="card gold">
    <p class="label">Principle 4</p>
    <h3>Brownfield-First</h3>
    <p>ใส่ใน codebase ที่มีอยู่แล้วได้เลย ไม่ต้องเริ่มใหม่จากศูนย์</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OpenSpec ไม่บังคับ waterfall — ยืดหยุ่นพอที่จะปรับ spec ระหว่าง implement</div>

<!-- Speaker: Brownfield-first สำคัญมาก — ส่วนใหญ่เราไม่ได้เริ่ม project ใหม่ -->

---

## สองพื้นที่หลัก: specs/ vs changes/

<p class="subhead">specs/ คือ source of truth; changes/ คือ proposed modifications ที่ยังไม่ merge</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- specs/ box -->
  <rect x="60" y="40" width="430" height="260" rx="16" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="60" y="40" width="430" height="54" rx="16" fill="var(--accent)" opacity=".2"/>
  <text x="275" y="75" font-size="17" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">openspec/specs/</text>
  <text x="275" y="96" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Source of Truth</text>
  <rect x="90" y="116" width="370" height="40" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="275" y="141" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/auth/spec.md</text>
  <rect x="90" y="164" width="370" height="40" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="275" y="189" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/payments/spec.md</text>
  <rect x="90" y="212" width="370" height="40" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="275" y="237" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/api/spec.md</text>
  <text x="275" y="280" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">บอกว่าระบบทำงานยังไงตอนนี้</text>
  <!-- Merge arrow (right to left) -->
  <line x1="613" y1="170" x2="496" y2="170" stroke="var(--success)" stroke-width="2.5"/>
  <polygon points="496,164 484,170 496,176" fill="var(--success)"/>
  <text x="548" y="156" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">merge on</text>
  <text x="548" y="172" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">archive</text>
  <!-- changes/ box -->
  <rect x="620" y="40" width="430" height="260" rx="16" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <rect x="620" y="40" width="430" height="54" rx="16" fill="var(--soft-2)"/>
  <text x="835" y="75" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">openspec/changes/</text>
  <text x="835" y="96" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Proposed Changes (per feature)</text>
  <!-- Feature folder -->
  <rect x="648" y="112" width="374" height="170" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="835" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">add-dark-mode/</text>
  <text x="835" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">proposal.md</text>
  <text x="835" y="184" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">specs/ (delta)</text>
  <text x="835" y="206" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">design.md</text>
  <text x="835" y="228" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">tasks.md</text>
  <text x="835" y="264" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แต่ละ feature มี folder ของตัวเอง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> specs/ = living doc ของระบบ; changes/ = feature ที่กำลังพัฒนา merge เมื่อ archive</div>

<!-- Speaker: แยกกันชัดเจน — ทำงาน parallel features ได้โดยไม่ conflict -->

---

## วิธีเดิม vs OpenSpec

<p class="subhead">ความต่างที่สำคัญ: AI รู้ว่าทำอะไรเพราะอ่าน spec ที่ตกลงกันไว้แล้ว</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Vibe Coding -->
  <rect x="40" y="30" width="460" height="260" rx="14" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="40" y="30" width="460" height="56" rx="14" fill="var(--danger-wash)"/>
  <text x="270" y="65" font-size="17" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Vibe Coding (วิธีเดิม)</text>
  <text x="80" y="116" font-size="14" fill="var(--ink)" font-family="system-ui">บอก AI โดยตรง</text>
  <text x="80" y="140" font-size="13" fill="var(--muted)" font-family="system-ui">AI เดา requirement</text>
  <text x="80" y="172" font-size="14" fill="var(--ink)" font-family="system-ui">ไม่มีเอกสาร</text>
  <text x="80" y="196" font-size="13" fill="var(--muted)" font-family="system-ui">ทีมอื่นไม่รู้ว่าทำอะไร</text>
  <text x="80" y="228" font-size="14" fill="var(--ink)" font-family="system-ui">Rollback = undo git</text>
  <text x="80" y="252" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่มี baseline ของระบบ</text>
  <!-- VS circle -->
  <circle cx="550" cy="160" r="30" fill="var(--ink-dim)"/>
  <text x="550" y="165" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">VS</text>
  <!-- Right: OpenSpec -->
  <rect x="600" y="30" width="460" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2.5"/>
  <rect x="600" y="30" width="460" height="56" rx="14" fill="var(--accent-wash)"/>
  <text x="830" y="65" font-size="17" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">OpenSpec (SDD)</text>
  <text x="640" y="116" font-size="14" fill="var(--ink)" font-family="system-ui">propose → review → apply</text>
  <text x="640" y="140" font-size="13" fill="var(--accent)" font-family="system-ui">AI อ่าน spec ที่ชัดเจน</text>
  <text x="640" y="172" font-size="14" fill="var(--ink)" font-family="system-ui">Artifacts อยู่ใน git</text>
  <text x="640" y="196" font-size="13" fill="var(--accent)" font-family="system-ui">review ได้, diff ได้, rollback ได้</text>
  <text x="640" y="228" font-size="14" fill="var(--ink)" font-family="system-ui">Revert change folder</text>
  <text x="640" y="252" font-size="13" fill="var(--accent)" font-family="system-ui">specs/ = baseline ของระบบ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OpenSpec ไม่ได้แค่เพิ่มเอกสาร — มันทำให้ AI รู้ว่าทำอะไรก่อนเริ่ม code</div>

<!-- Speaker: ข้อต่างหลักคือ AI ไม่ต้องเดา requirement -->

---

## Key Takeaways: OpenSpec EP1

<p class="subhead">สิ่งที่ต้องจำจาก EP1 ก่อนไป EP2 (ติดตั้ง)</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Problem</p>
    <h3>Vibe Coding พัง Project ใหญ่</h3>
    <p>AI เดา requirement, ไม่มีเอกสาร, code review ยาก, rollback ยาก</p>
  </div>
  <div class="card">
    <p class="label">Solution</p>
    <h3>Spec-Driven Development</h3>
    <p>เขียน spec ก่อน → review → apply — AI implement ตาม artifacts ที่ตกลงกัน</p>
  </div>
  <div class="card success">
    <p class="label">Key Concepts</p>
    <h3>specs/ + changes/</h3>
    <p>specs/ = source of truth; changes/ = feature artifacts; merge เมื่อ archive</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP2 → ติดตั้ง OpenSpec ด้วย npm + openspec init ใน project จริง</div>

<!-- Speaker: EP2 จะ walk through installation และโครงสร้างจริงที่ได้หลัง init -->
