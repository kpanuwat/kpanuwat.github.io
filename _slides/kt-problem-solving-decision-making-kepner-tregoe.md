---
marp: true
theme: default
paginate: true
title: "KT Problem Solving & Decision Making (Kepner-Tregoe)"
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

# KT Problem Solving & Decision Making

<p class="tag">Kepner-Tregoe Method — กรอบคิดแก้ปัญหาแบบมีโครงสร้างจาก RAND Corporation (1960s)</p>

<!-- Speaker: KT แบ่งการคิดออกเป็น 4 ประเภทคำถามที่ไม่ควรปนกัน ช่วยให้ทีมไม่กระโดดจากปัญหาไปหา solution เร็วเกินไป -->

---

## ทำไม KT ถึงสำคัญ: Problem ≠ Decision

<p class="subhead">ความผิดพลาดส่วนใหญ่ในงานวิศวกรรมไม่ได้มาจากขาดทักษะ แต่มาจากการถามคำถามผิดประเภท</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: without KT vs with KT -->
  <rect x="40" y="20" width="470" height="320" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="40" y="20" width="470" height="52" rx="12" fill="var(--danger)" opacity=".15"/>
  <text x="275" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Without KT</text>
  <text x="70" y="105" font-size="14" fill="var(--danger-ink)" font-family="system-ui">1. พบปัญหา</text>
  <text x="70" y="135" font-size="14" fill="var(--ink-dim)" font-family="system-ui">2. brainstorm สาเหตุทันที</text>
  <text x="70" y="165" font-size="14" fill="var(--ink-dim)" font-family="system-ui">3. เลือก solution แรกที่นึกออก</text>
  <text x="70" y="195" font-size="14" fill="var(--ink-dim)" font-family="system-ui">4. implement</text>
  <text x="70" y="235" font-size="13" fill="var(--danger)" font-family="system-ui">Result: แก้ผิดจุด, ปัญหาวนกลับ</text>
  <text x="70" y="258" font-size="13" fill="var(--danger)" font-family="system-ui">เสียเวลา, เสียงบประมาณ</text>

  <circle cx="550" cy="190" r="26" fill="var(--accent)"/>
  <text x="550" y="195" font-size="12" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>

  <rect x="590" y="20" width="470" height="320" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="590" y="20" width="470" height="52" rx="12" fill="var(--success)" opacity=".15"/>
  <text x="825" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">With KT</text>
  <text x="620" y="105" font-size="14" fill="var(--success-ink)" font-family="system-ui">1. SA — จัด priority concern</text>
  <text x="620" y="135" font-size="14" fill="var(--ink-dim)" font-family="system-ui">2. PA — หา root cause ด้วย IS/IS NOT</text>
  <text x="620" y="165" font-size="14" fill="var(--ink-dim)" font-family="system-ui">3. DA — เลือก solution อย่างมีโครงสร้าง</text>
  <text x="620" y="195" font-size="14" fill="var(--ink-dim)" font-family="system-ui">4. PPA — ป้องกันปัญหาอนาคต</text>
  <text x="620" y="235" font-size="13" fill="var(--success)" font-family="system-ui">Result: แก้ถูกจุด, ตรวจสอบได้</text>
  <text x="620" y="258" font-size="13" fill="var(--success)" font-family="system-ui">ปัญหาไม่วนซ้ำ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> KT บังคับให้ถามคำถามถูกประเภทก่อน — ป้องกัน cognitive shortcut ที่ทำให้แก้ผิดจุด</div>

<!-- Speaker: Kepner กับ Tregoe พบจาก RAND research ว่า successful problem solvers ใช้ logical deduction ไม่ใช่ intuition -->

---

## KT: 4 กระบวนการ ถามคำถามคนละประเภท

<p class="subhead">แต่ละ process ตอบคำถามคนละชนิด ห้ามปนกัน — นั่นคือหัวใจของ KT</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4-box arrow flow -->
  <!-- SA -->
  <rect x="20" y="80" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="20" y="80" width="220" height="44" rx="12" fill="var(--accent)"/>
  <text x="130" y="108" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1 · Situation Appraisal</text>
  <text x="130" y="155" font-size="22" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SA</text>
  <text x="130" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เกิดอะไรขึ้น?</text>
  <text x="130" y="203" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">อะไรสำคัญกว่า?</text>
  <text x="130" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Priority list</text>
  <!-- arrow -->
  <line x1="243" y1="170" x2="273" y2="170" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="273,164 285,170 273,176" fill="var(--muted)"/>
  <!-- PA -->
  <rect x="287" y="80" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="287" y="80" width="220" height="44" rx="12" fill="var(--warning)"/>
  <text x="397" y="108" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2 · Problem Analysis</text>
  <text x="397" y="155" font-size="22" font-weight="800" fill="var(--warning)" text-anchor="middle" font-family="system-ui">PA</text>
  <text x="397" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทำไมถึงเกิด?</text>
  <text x="397" y="203" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Root cause คืออะไร?</text>
  <text x="397" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Verified cause</text>
  <!-- arrow -->
  <line x1="510" y1="170" x2="540" y2="170" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="540,164 552,170 540,176" fill="var(--muted)"/>
  <!-- DA -->
  <rect x="554" y="80" width="220" height="180" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="554" y="80" width="220" height="44" rx="12" fill="var(--success)"/>
  <text x="664" y="108" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3 · Decision Analysis</text>
  <text x="664" y="155" font-size="22" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">DA</text>
  <text x="664" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">จะทำอะไร?</text>
  <text x="664" y="203" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตัวเลือกไหนดีที่สุด?</text>
  <text x="664" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Documented decision</text>
  <!-- arrow -->
  <line x1="777" y1="170" x2="807" y2="170" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="807,164 819,170 807,176" fill="var(--muted)"/>
  <!-- PPA -->
  <rect x="821" y="80" width="260" height="180" rx="12" fill="var(--paper)" stroke="var(--ink-dim)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="821" y="80" width="260" height="44" rx="12" fill="var(--ink-dim)"/>
  <text x="951" y="108" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4 · Potential Problem Analysis</text>
  <text x="951" y="155" font-size="22" font-weight="800" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PPA</text>
  <text x="951" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">อะไรอาจผิดพลาด?</text>
  <text x="951" y="203" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">จะป้องกันอย่างไร?</text>
  <text x="951" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Preventive + contingency</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 4 process ตอบคำถามคนละชนิด — ปนกันทำให้เสียเวลาและได้คำตอบผิด</div>

<!-- Speaker: ต้องรู้ก่อนว่ากำลังอยู่ใน process ไหน มิฉะนั้น team จะ debate กันโดยไม่รู้ว่ากำลังถามคำถามต่างประเภท -->

---

## SA: จัด Priority ก่อนลงมือ

<p class="subhead">Situation Appraisal คือ triage — แยกประเภท concern และจัด priority ก่อนเลือก tool ถัดไป</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">ขั้นที่ 1</p>
    <h3>Concern Listing</h3>
    <p>รวบรวมทุก concern ออกมาก่อน ไม่กรอง ไม่วิเคราะห์ — เขียนออกมาทั้งหมด</p>
  </div>
  <div class="card warning">
    <p class="label">ขั้นที่ 2</p>
    <h3>Separation</h3>
    <p>แยก concern เป็น 3 ประเภท: <b>Problem</b> (เกิดแล้ว) · <b>Decision</b> (ต้องเลือก) · <b>Potential Problem</b> (ยังไม่เกิด)</p>
  </div>
  <div class="card success">
    <p class="label">ขั้นที่ 3</p>
    <h3>Priority Setting</h3>
    <p>ใช้ 3 เกณฑ์: <b>Urgency</b> (ต้องทำเมื่อไหร่) · <b>Seriousness</b> (ผลกระทบมากแค่ไหน) · <b>Growth Trend</b> (จะแย่ลงไหม)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SA ป้องกัน "ดับไฟ" โดยไม่มีแผน — หยุดก่อน จัด priority ก่อน แล้วค่อยเลือก PA, DA หรือ PPA</div>

<!-- Speaker: ตัวอย่าง: เครื่อง line A หยุด + ของเสียเพิ่ม + supplier ล่าช้า → SA บอกว่าจะจัดการอะไรก่อน -->

---

## PA: IS / IS NOT — หัวใจของ Root Cause Analysis

<p class="subhead">Problem Analysis ใช้ logical deduction ไม่ใช่ brainstorming — narrow down สาเหตุจากข้อเท็จจริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- IS/IS NOT table structure -->
  <!-- header row -->
  <rect x="20" y="20" width="200" height="44" rx="4" fill="var(--ink)"/>
  <text x="120" y="47" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">มิติ</text>
  <rect x="224" y="20" width="280" height="44" rx="4" fill="var(--accent)"/>
  <text x="364" y="47" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">IS (ที่ปัญหาเกิด)</text>
  <rect x="508" y="20" width="280" height="44" rx="4" fill="var(--ink-dim)"/>
  <text x="648" y="47" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">IS NOT (ที่ไม่เกิด)</text>
  <rect x="792" y="20" width="288" height="44" rx="4" fill="var(--warning)"/>
  <text x="936" y="47" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">What's Distinct?</text>
  <!-- row 1: WHAT -->
  <rect x="20" y="68" width="200" height="64" rx="2" fill="var(--soft)"/>
  <text x="120" y="104" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">WHAT</text>
  <rect x="224" y="68" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="364" y="104" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PCB model X มี defect</text>
  <rect x="508" y="68" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="648" y="104" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Model Y, Z ไม่มี</text>
  <rect x="792" y="68" width="288" height="64" rx="2" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="936" y="104" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">X ต่างจาก Y, Z อย่างไร?</text>
  <!-- row 2: WHERE -->
  <rect x="20" y="136" width="200" height="64" rx="2" fill="var(--soft)"/>
  <text x="120" y="172" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">WHERE</text>
  <rect x="224" y="136" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="364" y="172" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Station 3 เท่านั้น</text>
  <rect x="508" y="136" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="648" y="172" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Station 1, 2, 4 ไม่มี</text>
  <rect x="792" y="136" width="288" height="64" rx="2" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="936" y="172" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">อะไรที่เฉพาะ St.3?</text>
  <!-- row 3: WHEN -->
  <rect x="20" y="204" width="200" height="64" rx="2" fill="var(--soft)"/>
  <text x="120" y="240" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">WHEN</text>
  <rect x="224" y="204" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="364" y="240" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">หลัง 14:00 เท่านั้น</text>
  <rect x="508" y="204" width="280" height="64" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="648" y="240" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ก่อน 14:00 ไม่เกิด</text>
  <rect x="792" y="204" width="288" height="64" rx="2" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="936" y="240" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">เปลี่ยนอะไรตอน 14:00?</text>
  <!-- row 4: EXTENT -->
  <rect x="20" y="272" width="200" height="60" rx="2" fill="var(--soft)"/>
  <text x="120" y="306" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">EXTENT</text>
  <rect x="224" y="272" width="280" height="60" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="364" y="306" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">~15% ของ lot</text>
  <rect x="508" y="272" width="280" height="60" rx="2" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="648" y="306" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ใช่ 100%</text>
  <rect x="792" y="272" width="288" height="60" rx="2" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="936" y="306" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ขนาดบ่งบอกอะไร?</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> IS/IS NOT ไม่ใช่ checklist — เป็น logical deduction: distinctions บ่งชี้ probable cause โดยไม่ต้อง brainstorm</div>

<!-- Speaker: หลังจากนี้ทุก distinction → possible cause → test "explain ทั้ง IS และ IS NOT ได้ไหม?" → most probable cause → verify -->

---

## PA: จาก Distinctions สู่ Root Cause

<p class="subhead">Distinctions ที่พบใน IS vs IS NOT นำไปสู่ Possible Causes → Most Probable Cause → Verification</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 5 steps -->
  <!-- step 1 -->
  <rect x="20" y="90" width="170" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="105" y="135" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Define</text>
  <text x="105" y="153" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Problem</text>
  <text x="105" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Object + Deviation</text>
  <line x1="193" y1="150" x2="213" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="213,144 225,150 213,156" fill="var(--muted)"/>
  <!-- step 2 -->
  <rect x="227" y="90" width="170" height="120" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="312" y="135" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">IS / IS NOT</text>
  <text x="312" y="153" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Analysis</text>
  <text x="312" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">WHAT WHERE WHEN EXTENT</text>
  <line x1="400" y1="150" x2="420" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="420,144 432,150 420,156" fill="var(--muted)"/>
  <!-- step 3 -->
  <rect x="434" y="90" width="170" height="120" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="519" y="135" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Identify</text>
  <text x="519" y="153" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Distinctions</text>
  <text x="519" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IS vs IS NOT</text>
  <line x1="607" y1="150" x2="627" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="627,144 639,150 627,156" fill="var(--muted)"/>
  <!-- step 4 -->
  <rect x="641" y="90" width="170" height="120" rx="10" fill="var(--soft)" stroke="var(--ink-dim)" stroke-width="1.5"/>
  <text x="726" y="135" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Possible</text>
  <text x="726" y="153" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Causes</text>
  <text x="726" y="178" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">"อธิบาย IS+IS NOT ได้?"</text>
  <line x1="814" y1="150" x2="834" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="834,144 846,150 834,156" fill="var(--muted)"/>
  <!-- step 5 -->
  <rect x="848" y="90" width="230" height="120" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="963" y="128" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Most Probable</text>
  <text x="963" y="146" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Cause + Verify</text>
  <text x="963" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Test, observe, confirm</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> KT PA ไม่ใช่ 5-Why — ไม่ถามซ้ำไปเรื่อยๆ แต่ใช้ distinction เพื่อ falsify causes ทีละตัว</div>

<!-- Speaker: Most Probable Cause คือ cause ที่อธิบาย IS ทั้งหมดได้ และอธิบายว่าทำไม IS NOT ถึงไม่มีปัญหา -->

---

## DA: ตัดสินใจด้วย MUSTS + WANTS Matrix

<p class="subhead">Decision Analysis แยก non-negotiables (MUSTS) ออกจาก weighted preferences (WANTS) ก่อนประเมิน alternatives</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- DA matrix table -->
  <!-- headers -->
  <rect x="20" y="20" width="360" height="44" rx="4" fill="var(--ink)"/>
  <text x="200" y="47" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Objective</text>
  <rect x="384" y="20" width="100" height="44" rx="4" fill="var(--ink)"/>
  <text x="434" y="47" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Type</text>
  <rect x="488" y="20" width="80" height="44" rx="4" fill="var(--ink)"/>
  <text x="528" y="47" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Wt.</text>
  <rect x="572" y="20" width="230" height="44" rx="4" fill="var(--accent)"/>
  <text x="687" y="47" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Alt A (ผ่าน)</text>
  <rect x="806" y="20" width="270" height="44" rx="4" fill="var(--danger)"/>
  <text x="941" y="47" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Alt B (ตัดออก)</text>
  <!-- row 1 MUST -->
  <rect x="20" y="68" width="360" height="52" rx="2" fill="var(--danger-wash)"/>
  <text x="200" y="98" font-size="13" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ราคา &lt; 2M THB</text>
  <rect x="384" y="68" width="100" height="52" rx="2" fill="var(--danger-wash)"/>
  <text x="434" y="98" font-size="12" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">MUST</text>
  <rect x="488" y="68" width="80" height="52" rx="2" fill="var(--soft)"/>
  <text x="528" y="98" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">—</text>
  <rect x="572" y="68" width="230" height="52" rx="2" fill="var(--success-wash)"/>
  <text x="687" y="98" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">PASS</text>
  <rect x="806" y="68" width="270" height="52" rx="2" fill="var(--danger-wash)"/>
  <text x="941" y="98" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">FAIL (ตัดทิ้ง)</text>
  <!-- row 2 MUST -->
  <rect x="20" y="124" width="360" height="52" rx="2" fill="var(--danger-wash)"/>
  <text x="200" y="154" font-size="13" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Support ภาษาไทย</text>
  <rect x="384" y="124" width="100" height="52" rx="2" fill="var(--danger-wash)"/>
  <text x="434" y="154" font-size="12" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">MUST</text>
  <rect x="488" y="124" width="80" height="52" rx="2" fill="var(--soft)"/>
  <text x="528" y="154" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">—</text>
  <rect x="572" y="124" width="230" height="52" rx="2" fill="var(--success-wash)"/>
  <text x="687" y="154" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">PASS</text>
  <rect x="806" y="124" width="270" height="52" rx="2" fill="var(--soft)"/>
  <text x="941" y="154" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">—</text>
  <!-- row 3 WANT -->
  <rect x="20" y="180" width="360" height="52" rx="2" fill="var(--soft)"/>
  <text x="200" y="210" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Implementation &lt; 6 months</text>
  <rect x="384" y="180" width="100" height="52" rx="2" fill="var(--accent-wash)"/>
  <text x="434" y="210" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">WANT</text>
  <rect x="488" y="180" width="80" height="52" rx="2" fill="var(--accent-wash)"/>
  <text x="528" y="210" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">9</text>
  <rect x="572" y="180" width="230" height="52" rx="2" fill="var(--soft)"/>
  <text x="687" y="210" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Score 7 → 7×9=63</text>
  <rect x="806" y="180" width="270" height="52" rx="2" fill="var(--soft)"/>
  <text x="941" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">—</text>
  <!-- row 4 WANT -->
  <rect x="20" y="236" width="360" height="52" rx="2" fill="var(--soft)"/>
  <text x="200" y="266" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Local support team</text>
  <rect x="384" y="236" width="100" height="52" rx="2" fill="var(--accent-wash)"/>
  <text x="434" y="266" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">WANT</text>
  <rect x="488" y="236" width="80" height="52" rx="2" fill="var(--accent-wash)"/>
  <text x="528" y="266" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">7</text>
  <rect x="572" y="236" width="230" height="52" rx="2" fill="var(--soft)"/>
  <text x="687" y="266" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Score 8 → 8×7=56</text>
  <rect x="806" y="236" width="270" height="52" rx="2" fill="var(--soft)"/>
  <text x="941" y="266" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">—</text>
  <!-- total row -->
  <rect x="572" y="292" width="230" height="44" rx="4" fill="var(--accent)"/>
  <text x="687" y="318" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Total: 119</text>
  <rect x="806" y="292" width="270" height="44" rx="4" fill="var(--danger)"/>
  <text x="941" y="318" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Eliminated</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตรวจ MUSTS ก่อนเสมอ — alternative ที่ fail MUST ต้องตัดออกทันที ไม่ต้องให้คะแนน WANTS</div>

<!-- Speaker: หลัง DA ได้ winner แล้ว ต้อง assess adverse consequences ของ winner ด้วย ก่อนตัดสินใจสุดท้าย -->

---

## PPA: ป้องกันปัญหาก่อนเกิด

<p class="subhead">Potential Problem Analysis ใช้ก่อน implement — ถาม "อะไรอาจผิดพลาด?" แล้ววางแผนป้องกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Potential Problems</p>
    <h3>ระบุความเสี่ยง</h3>
    <p>ถามว่า "อะไรอาจผิดพลาด?" สำหรับแต่ละขั้นตอนของ plan</p>
    <p>ประเมิน Probability × Seriousness → priority risk list</p>
  </div>
  <div class="card danger">
    <p class="label">Preventive Actions</p>
    <h3>ลด Probability</h3>
    <p>ทำอะไรเพื่อให้ปัญหาไม่เกิดขึ้น (เช่น เพิ่ม QA checkpoint)</p>
    <p>ใครรับผิดชอบ? ภายในเมื่อไหร่?</p>
  </div>
  <div class="card">
    <p class="label">Contingent Actions</p>
    <h3>ลด Seriousness</h3>
    <p>"ถ้าเกิดแล้วจะทำอะไร?" — plan B ที่ prepare ไว้แล้ว</p>
    <p>Trigger condition คืออะไร? ใครตัดสินใจ activate?</p>
  </div>
  <div class="card success">
    <p class="label">POA (Bonus)</p>
    <h3>Potential Opportunity</h3>
    <p>ด้านบวก: โอกาสอะไรที่อาจเกิดระหว่าง implement?</p>
    <p>วางแผนขยายผลล่วงหน้า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PPA คือ tool ที่ถูกข้ามมากที่สุด — แต่มีคุณค่าสูงสุดก่อน production launch หรือ ECO</div>

<!-- Speaker: ตัวอย่างใน EMS: PPA ก่อน ECO ช่วยหา risk เช่น component lead time ยาว, tooling เปลี่ยน, test fixture ต้องอัปเดต -->

---

## KT vs. Methodologies อื่น

<p class="subhead">KT เป็น thinking layer — ทำงานร่วมกับ 8D, ITIL, Six Sigma ได้ดี ไม่ใช่คู่แข่ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5-column comparison -->
  <!-- headers -->
  <rect x="10" y="10" width="195" height="40" rx="4" fill="var(--ink)"/>
  <text x="107" y="34" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Methodology</text>
  <rect x="210" y="10" width="175" height="40" rx="4" fill="var(--ink)"/>
  <text x="297" y="34" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">จุดเน้น</text>
  <rect x="390" y="10" width="215" height="40" rx="4" fill="var(--ink)"/>
  <text x="497" y="34" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">เหมาะกับ</text>
  <rect x="610" y="10" width="220" height="40" rx="4" fill="var(--ink)"/>
  <text x="720" y="34" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">ไม่เหมาะกับ</text>
  <rect x="835" y="10" width="255" height="40" rx="4" fill="var(--ink)"/>
  <text x="962" y="34" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">ใช้ร่วมกับ KT</text>
  <!-- KT row -->
  <rect x="10" y="55" width="195" height="50" rx="2" fill="var(--accent)"/>
  <text x="107" y="84" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">KT</text>
  <rect x="210" y="55" width="175" height="50" rx="2" fill="var(--accent-wash)"/>
  <text x="297" y="84" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Thinking framework</text>
  <rect x="390" y="55" width="215" height="50" rx="2" fill="var(--accent-wash)"/>
  <text x="497" y="78" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Complex multi-factor</text>
  <text x="497" y="96" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">problems + decisions</text>
  <rect x="610" y="55" width="220" height="50" rx="2" fill="var(--soft)"/>
  <text x="720" y="84" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Simple SOP problems</text>
  <rect x="835" y="55" width="255" height="50" rx="2" fill="var(--accent-wash)"/>
  <text x="962" y="84" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">—</text>
  <!-- 5-Why row -->
  <rect x="10" y="110" width="195" height="50" rx="2" fill="var(--soft)"/>
  <text x="107" y="139" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">5-Why</text>
  <rect x="210" y="110" width="175" height="50" rx="2" fill="var(--soft)"/>
  <text x="297" y="139" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Linear root cause</text>
  <rect x="390" y="110" width="215" height="50" rx="2" fill="var(--soft)"/>
  <text x="497" y="139" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Simple linear causation</text>
  <rect x="610" y="110" width="220" height="50" rx="2" fill="var(--soft)"/>
  <text x="720" y="139" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Multi-factor problems</text>
  <rect x="835" y="110" width="255" height="50" rx="2" fill="var(--success-wash)"/>
  <text x="962" y="139" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ใช้ KT PA แทนใน D4</text>
  <!-- 8D row -->
  <rect x="10" y="165" width="195" height="50" rx="2" fill="var(--soft)"/>
  <text x="107" y="194" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">8D</text>
  <rect x="210" y="165" width="175" height="50" rx="2" fill="var(--soft)"/>
  <text x="297" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Team problem</text>
  <text x="297" y="204" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">solving + CAPA</text>
  <rect x="390" y="165" width="215" height="50" rx="2" fill="var(--soft)"/>
  <text x="497" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mfg defects /</text>
  <text x="497" y="204" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">customer complaints</text>
  <rect x="610" y="165" width="220" height="50" rx="2" fill="var(--soft)"/>
  <text x="720" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่รู้จะแก้ทีมไหน</text>
  <rect x="835" y="165" width="255" height="50" rx="2" fill="var(--success-wash)"/>
  <text x="962" y="186" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">KT PA → D4 (RCA)</text>
  <text x="962" y="204" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">KT DA → D5 (solution)</text>
  <!-- FMEA row -->
  <rect x="10" y="220" width="195" height="50" rx="2" fill="var(--soft)"/>
  <text x="107" y="249" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FMEA</text>
  <rect x="210" y="220" width="175" height="50" rx="2" fill="var(--soft)"/>
  <text x="297" y="249" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Risk prevention</text>
  <rect x="390" y="220" width="215" height="50" rx="2" fill="var(--soft)"/>
  <text x="497" y="249" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Design/process risk</text>
  <rect x="610" y="220" width="220" height="50" rx="2" fill="var(--soft)"/>
  <text x="720" y="249" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Post-failure analysis</text>
  <rect x="835" y="220" width="255" height="50" rx="2" fill="var(--success-wash)"/>
  <text x="962" y="249" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">KT PPA ทำงานคล้าย FMEA</text>
  <!-- PDCA row -->
  <rect x="10" y="275" width="195" height="40" rx="2" fill="var(--soft)"/>
  <text x="107" y="299" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PDCA</text>
  <rect x="210" y="275" width="175" height="40" rx="2" fill="var(--soft)"/>
  <text x="297" y="299" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CI cycle</text>
  <rect x="390" y="275" width="215" height="40" rx="2" fill="var(--soft)"/>
  <text x="497" y="299" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Iterative improvement</text>
  <rect x="610" y="275" width="220" height="40" rx="2" fill="var(--soft)"/>
  <text x="720" y="299" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">One-time decisions</text>
  <rect x="835" y="275" width="255" height="40" rx="2" fill="var(--soft)"/>
  <text x="962" y="299" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้ KT ใน "P" phase</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> KT PA เป็น drop-in สำหรับ 8D D4 และ ITIL Problem Management — เสริมได้โดยไม่ต้องเปลี่ยน process เดิม</div>

<!-- Speaker: ไม่ต้อง certify KT เต็มรูปแบบ — แค่รู้จัก IS/IS NOT + MUSTS/WANTS แล้วใส่ใน 8D หรือ ITIL ที่มีอยู่แล้วได้เลย -->

---

## User Guide: 8 ขั้นตอนทำ IS/IS NOT Analysis

<p class="subhead">ขั้นตอนที่ใช้บ่อยที่สุดของ KT — ทำได้ทันทีด้วย whiteboard หรือ spreadsheet</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 8-step flow in 2 rows of 4 -->
  <!-- row 1 -->
  <rect x="20" y="20" width="220" height="110" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="60" cy="50" r="16" fill="var(--accent)"/>
  <text x="60" y="55" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="130" y="55" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Define Problem</text>
  <text x="40" y="85" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Object + Deviation</text>
  <text x="40" y="103" font-size="11" fill="var(--muted)" font-family="system-ui">ชัดเจน, วัดได้</text>

  <line x1="243" y1="75" x2="263" y2="75" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="263,69 275,75 263,81" fill="var(--muted)"/>

  <rect x="277" y="20" width="220" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="317" cy="50" r="16" fill="var(--ink-dim)"/>
  <text x="317" y="55" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="387" y="55" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Build Worksheet</text>
  <text x="297" y="85" font-size="12" fill="var(--ink-dim)" font-family="system-ui">4 rows × 3 columns</text>
  <text x="297" y="103" font-size="11" fill="var(--muted)" font-family="system-ui">WHAT WHERE WHEN EXTENT</text>

  <line x1="500" y1="75" x2="520" y2="75" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="520,69 532,75 520,81" fill="var(--muted)"/>

  <rect x="534" y="20" width="220" height="110" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="574" cy="50" r="16" fill="var(--accent)"/>
  <text x="574" y="55" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="644" y="55" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">Fill IS Column</text>
  <text x="554" y="85" font-size="12" fill="var(--ink-dim)" font-family="system-ui">ข้อเท็จจริงเท่านั้น</text>
  <text x="554" y="103" font-size="11" fill="var(--muted)" font-family="system-ui">ห้าม assumption</text>

  <line x1="757" y1="75" x2="777" y2="75" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="777,69 789,75 777,81" fill="var(--muted)"/>

  <rect x="791" y="20" width="290" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="831" cy="50" r="16" fill="var(--ink-dim)"/>
  <text x="831" y="55" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="861" y="55" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Fill IS NOT Column</text>
  <text x="811" y="85" font-size="12" fill="var(--ink-dim)" font-family="system-ui">"comparable แต่ไม่มีปัญหา"</text>
  <text x="811" y="103" font-size="11" fill="var(--muted)" font-family="system-ui">ต้อง comparable กับ IS</text>

  <!-- row 2 -->
  <rect x="20" y="185" width="220" height="110" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <circle cx="60" cy="215" r="16" fill="var(--warning)"/>
  <text x="60" y="220" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="130" y="220" font-size="13" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">Distinctions</text>
  <text x="40" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">IS vs IS NOT ต่างกันอย่างไร?</text>
  <text x="40" y="266" font-size="11" fill="var(--muted)" font-family="system-ui">บันทึกทุก distinction</text>

  <line x1="243" y1="240" x2="263" y2="240" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="263,234 275,240 263,246" fill="var(--muted)"/>

  <rect x="277" y="185" width="220" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="317" cy="215" r="16" fill="var(--ink-dim)"/>
  <text x="317" y="220" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">6</text>
  <text x="387" y="220" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Possible Causes</text>
  <text x="297" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Explain IS + IS NOT ได้?</text>
  <text x="297" y="266" font-size="11" fill="var(--muted)" font-family="system-ui">falsify ทีละตัว</text>

  <line x1="500" y1="240" x2="520" y2="240" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="520,234 532,240 520,246" fill="var(--muted)"/>

  <rect x="534" y="185" width="220" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="574" cy="215" r="16" fill="var(--ink-dim)"/>
  <text x="574" y="220" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">7</text>
  <text x="644" y="220" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Test MPC</text>
  <text x="554" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Most Probable Cause</text>
  <text x="554" y="266" font-size="11" fill="var(--muted)" font-family="system-ui">confirm + fix + observe</text>

  <line x1="757" y1="240" x2="777" y2="240" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="777,234 789,240 777,246" fill="var(--muted)"/>

  <rect x="791" y="185" width="290" height="110" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="831" cy="215" r="16" fill="var(--success)"/>
  <text x="831" y="220" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">8</text>
  <text x="861" y="220" font-size="13" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Document</text>
  <text x="811" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Verified cause + CAPA</text>
  <text x="811" y="266" font-size="11" fill="var(--muted)" font-family="system-ui">ใคร ทำอะไร ภายในเมื่อไหร่</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทำได้วันนี้ — ครั้งถัดไปที่มี defect ซ้ำๆ ลองทำ IS/IS NOT worksheet ก่อน brainstorm</div>

<!-- Speaker: ไม่ต้องรอ training หรือ certification — IS/IS NOT worksheet ใช้ whiteboard ก็ได้ -->

---

## Caveats: รู้ขีดจำกัดก่อนใช้

<p class="subhead">KT ไม่ใช่ silver bullet — รู้ว่าควรและไม่ควรใช้เมื่อไหร่</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">เวลาและทรัพยากร</p>
    <h3>ใช้เวลา</h3>
    <p>เหมาะกับปัญหาที่ cost ของการแก้ผิดสูง ไม่ใช่ปัญหาเล็กน้อยที่แก้ได้ใน 5 นาที</p>
  </div>
  <div class="card warning">
    <p class="label">Data Quality</p>
    <h3>Garbage In = Garbage Out</h3>
    <p>IS/IS NOT ต้องใส่ factual data เท่านั้น ถ้าใส่ assumption เข้าไป ผลจะผิดพลาด</p>
  </div>
  <div class="card danger">
    <p class="label">Complex Systems</p>
    <h3>Single Cause Only</h3>
    <p>PA เหมาะกับปัญหาที่มี single root cause ชัดเจน สำหรับ distributed failures ต้องใช้ร่วมกับ FTA</p>
  </div>
  <div class="card">
    <p class="label">Facilitator</p>
    <h3>ต้องมีคนนำ</h3>
    <p>ถ้าไม่มี facilitator ที่รู้ method ทีมจะเข้าสู่ speculation แทน IS/IS NOT ที่มีวินัย</p>
  </div>
  <div class="card">
    <p class="label">IS NOT Selection</p>
    <h3>Comparable Set สำคัญ</h3>
    <p>IS NOT ต้องเป็น comparable case — ถ้าเลือกผิด distinctions ที่ได้จะไร้ประโยชน์</p>
  </div>
  <div class="card success">
    <p class="label">Self-Study</p>
    <h3>เริ่มได้โดยไม่ Certify</h3>
    <p>อ่าน The Rational Manager หรือ Toolshero แล้วลองทำ IS/IS NOT worksheet ได้เลย</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ KT PA เฉพาะกับปัญหาที่ซับซ้อน, เกิดซ้ำ, หรือ cost สูง — อย่า over-engineer ปัญหาง่ายๆ</div>

<!-- Speaker: KT training ราคาสูงสำหรับ corporate — แต่ IS/IS NOT และ MUSTS/WANTS ใช้ได้เลยโดยไม่ต้อง certify -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ควรนำกลับไปใช้ได้ทันที</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">หลักการสำคัญ</p>
    <h3>4 Process ห้ามปนกัน</h3>
    <p>SA, PA, DA, PPA ตอบคำถามคนละประเภท — รู้ก่อนว่ากำลังอยู่ใน process ไหน</p>
  </div>
  <div class="card">
    <p class="label">Tool ที่ใช้บ่อยที่สุด</p>
    <h3>IS/IS NOT = Logical Deduction</h3>
    <p>ไม่ใช่ brainstorming แต่คือการใช้ distinctions เพื่อ narrow down cause อย่างมีวินัย</p>
  </div>
  <div class="card">
    <p class="label">Decision Making</p>
    <h3>MUSTS ก่อน WANTS เสมอ</h3>
    <p>ตัด alternative ที่ fail MUST ก่อน แล้วค่อยให้คะแนน WANTS — ไม่ใช่ average ทุกอย่างรวมกัน</p>
  </div>
  <div class="card success">
    <p class="label">Integration</p>
    <h3>เสริม 8D และ ITIL ได้เลย</h3>
    <p>KT PA → ใส่ใน 8D D4 · KT DA → ใส่ใน D5 · KT PPA → FMEA companion ก่อน launch</p>
  </div>
  <div class="card warning">
    <p class="label">ข้อควรระวัง</p>
    <h3>PPA มักถูกข้าม</h3>
    <p>Potential Problem Analysis ให้ value สูงที่สุดก่อน production launch แต่ถูก skip บ่อยที่สุด</p>
  </div>
  <div class="card danger">
    <p class="label">เริ่มต้น</p>
    <h3>ลองทำวันนี้</h3>
    <p>ครั้งถัดไปที่มี defect ซ้ำๆ — ใช้ IS/IS NOT worksheet ก่อน brainstorm ทันที</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> KT ไม่ได้ให้คำตอบ — KT บังคับให้ถามคำถามถูกประเภท ซึ่งนำไปสู่คำตอบที่ถูกต้อง</div>

<!-- Speaker: จบด้วยสิ่งที่ทำได้ทันที: เปิด spreadsheet, ทำ IS/IS NOT worksheet สำหรับ defect ที่กำลังวิเคราะห์อยู่ -->
