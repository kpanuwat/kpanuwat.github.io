---
marp: true
theme: default
paginate: true
title: "6 หลักจิตวิทยา UX/UI เพื่อเพิ่ม Conversion และลด Drop-off"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/ux-psychology-conversion-principles-cover.png)

<div class="mark"></div>

# 6 หลักจิตวิทยา UX/UI เพื่อเพิ่ม Conversion และลด Drop-off

<p class="tag">Smart Defaults · Goal Gradient · Reciprocity · IKEA Effect · Loss Aversion · Contrast Effect — พร้อม evidence จาก peer-reviewed research</p>

<!-- Speaker: เปิดด้วยคำถาม — เคยสงสัยไหมว่าทำไม design สวยแต่ conversion ไม่ขึ้น? วันนี้จะเจาะ 6 หลักจิตวิทยาที่ตอบคำถามนี้ -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/ux-psychology-conversion-principles-cheatsheet.png)

<!-- Speaker: cheatsheet นี้สรุปทั้ง 6 หลักการในหน้าเดียว — ใช้เป็น reference กลับมาดูได้ทุกเมื่อ -->

---

## TL;DR: Psychology ตัดสิน Conversion ไม่ใช่ Pixel

<p class="subhead">6 หลักจิตวิทยาที่มี research รองรับ ลด Decision Fatigue สร้าง Momentum และเพิ่ม Conversion</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="90" y1="170" x2="1010" y2="170" stroke="var(--soft-2)" stroke-width="2"/>
  <g>
    <circle cx="90" cy="170" r="34" fill="var(--accent)"/>
    <text x="90" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
    <text x="90" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Smart Defaults</text>
  </g>
  <g>
    <circle cx="274" cy="170" r="34" fill="var(--accent)"/>
    <text x="274" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
    <text x="274" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Goal Gradient</text>
  </g>
  <g>
    <circle cx="458" cy="170" r="34" fill="var(--accent)"/>
    <text x="458" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
    <text x="458" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Reciprocity</text>
  </g>
  <g>
    <circle cx="642" cy="170" r="34" fill="var(--accent)"/>
    <text x="642" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
    <text x="642" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">IKEA Effect</text>
  </g>
  <g>
    <circle cx="826" cy="170" r="34" fill="var(--accent)"/>
    <text x="826" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
    <text x="826" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Loss Aversion</text>
  </g>
  <g>
    <circle cx="1010" cy="170" r="34" fill="var(--accent)"/>
    <text x="1010" y="176" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">6</text>
    <text x="1010" y="230" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Contrast Effect</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design ที่ดีต้องเข้าใจว่าคนตัดสินใจอย่างไร ไม่ใช่แค่สวยงาม</div>

<!-- Speaker: 6 หลักการนี้มาจาก experiment จริงที่ตีพิมพ์ใน peer-reviewed journal ไม่ใช่ทฤษฎีลอยๆ -->

---

## ทำไม Psychology สำคัญกว่า Pixel

<p class="subhead">Product team ส่วนใหญ่ optimize ด้วยสายตา แต่ user ไม่ตัดสินใจด้วย aesthetic เพียงอย่างเดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 1px 2px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Aesthetic-Only Design</text>
  <text x="80" y="110" font-size="15" fill="var(--ink)" font-family="system-ui">Optimizes color, spacing, typography</text>
  <text x="80" y="145" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Ignores cognitive bias &amp; decision friction</text>
  <text x="80" y="180" font-size="15" fill="var(--muted)" font-family="system-ui">Result: high drop-off, unclear cause</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Psychology-Informed Design</text>
  <text x="610" y="110" font-size="15" fill="var(--ink)" font-family="system-ui">Grounded in peer-reviewed research</text>
  <text x="610" y="145" font-size="15" fill="var(--ink)" font-family="system-ui">Targets exact friction point in the funnel</text>
  <text x="610" y="180" font-size="15" fill="var(--ink)" font-family="system-ui">Result: measurable conversion lift</text>
  <circle cx="550" cy="190" r="28" fill="var(--accent)"/>
  <text x="550" y="195" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> การเข้าใจ "ทำไม" behind bias ทำให้ปรับใช้ตรงจุด ไม่ใช่ copy pattern แบบไม่รู้เหตุผล</div>

<!-- Speaker: เชื่อมเข้าหลักการแรก — Smart Defaults -->

---

## Smart Defaults: ลด Decision Fatigue

<p class="subhead">ทุก field ว่างคือ 1 decision — pre-fill ค่าที่คนส่วนใหญ่เลือกอยู่แล้ว เพราะ 70-90% ไม่เปลี่ยน default</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="550" y="40" font-size="14" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Grocery-store jam study — Iyengar &amp; Lepper (2000)</text>
  <rect x="180" y="280" width="140" height="20" fill="var(--muted)" opacity=".3"/>
  <text x="250" y="270" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">24 flavors</text>
  <rect x="580" y="120" width="140" height="180" fill="var(--accent)"/>
  <text x="650" y="110" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">6 flavors</text>
  <text x="250" y="330" font-size="26" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3%</text>
  <text x="650" y="330" font-size="26" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">30%</text>
  <text x="250" y="356" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">purchase rate</text>
  <text x="650" y="356" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">purchase rate</text>
  <line x1="150" y1="300" x2="920" y2="300" stroke="var(--soft-2)" stroke-width="2"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยิ่ง choice มาก ยิ่งไม่ตัดสินใจ — ตั้ง default ที่ดีที่สุดไว้เสมอ ไม่ใช่ปล่อย field ว่าง</div>

<!-- Speaker: เน้นว่านี่คือ field-experiment จริง ไม่ใช่ lab mock -->

---

## Goal Gradient Effect: สร้าง Momentum

<p class="subhead">คนเร่งความเร็วเข้าใกล้เป้าหมาย — ห้ามเริ่ม progress ที่ 0% ให้ artificial head start เสมอ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="550" y="40" font-size="14" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Car-wash loyalty card — Nunes &amp; Drèze (2006)</text>
  <text x="120" y="90" font-size="14" fill="var(--ink)" font-family="system-ui">8-stamp card, 0 pre-filled</text>
  <rect x="120" y="105" width="480" height="26" rx="13" fill="var(--soft-2)"/>
  <rect x="120" y="105" width="0" height="26" rx="13" fill="var(--muted)"/>
  <text x="620" y="123" font-size="15" font-weight="700" fill="var(--muted)" font-family="system-ui">19% complete</text>
  <text x="120" y="200" font-size="14" fill="var(--ink)" font-family="system-ui">10-stamp card, 2 pre-filled (head start)</text>
  <rect x="120" y="215" width="480" height="26" rx="13" fill="var(--soft-2)"/>
  <rect x="120" y="215" width="192" height="26" rx="13" fill="var(--accent)"/>
  <text x="620" y="233" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">34% complete</text>
  <text x="120" y="320" font-size="13" fill="var(--muted)" font-family="system-ui">Both groups needed exactly 8 washes to finish.</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Framing "Step 1 เสร็จแล้ว" ที่ 20% เปลี่ยนความรู้สึกจากยืนนิ่งเป็นมี momentum จริง</div>

<!-- Speaker: ย้ำว่า 0% เท่ากับบอก user ว่ายังไม่ได้ทำอะไรเลย -->

---

## Reciprocity: ให้ Value ก่อนขอ

<p class="subhead">Cialdini จัดให้เป็น driver พฤติกรรมที่ทรงพลังที่สุด — การได้รับก่อนสร้าง "หนี้ทางใจ" แบบไม่รู้ตัว</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="80" y="140" width="260" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="210" y="185" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Give value</text>
  <text x="210" y="210" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">free sample / free preview</text>
  <path d="M 360 190 L 480 190" stroke="var(--accent)" stroke-width="3" marker-end="url(#arrow-recip)"/>
  <defs>
    <marker id="arrow-recip" markerWidth="10" markerHeight="10" refX="8" refY="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 Z" fill="var(--accent)"/>
    </marker>
  </defs>
  <rect x="500" y="140" width="260" height="100" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
  <text x="630" y="185" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">User signs up</text>
  <text x="630" y="210" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">feels like natural next step</text>
  <text x="900" y="180" font-size="34" font-weight="700" fill="var(--gold)" text-anchor="middle" font-family="system-ui">+2000%</text>
  <text x="900" y="206" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">sample → purchase lift</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อย่ายึด value ไว้เป็นตัวประกัน — ให้ user เห็นผลลัพธ์บางส่วนก่อนบังคับสมัคร account</div>

<!-- Speaker: เชื่อม Reciprocity ไปสู่ IKEA Effect — ทั้งสองข้อเกี่ยวกับ "ให้ก่อน" -->

---

## IKEA Effect: สร้างความรู้สึกเป็นเจ้าของ

<p class="subhead">คนให้คุณค่ากับสิ่งที่ตัวเองลงมือสร้าง มากกว่าสิ่งที่ได้มาแบบสำเร็จรูป — แต่เฉพาะเมื่อทำสำเร็จ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="60" width="300" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="210" y="105" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Standard signup</text>
  <text x="210" y="150" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">email · password · submit</text>
  <text x="210" y="290" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">nothing to lose → easy to abandon</text>
  <rect x="740" y="60" width="300" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="890" y="105" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Build-first signup</text>
  <text x="890" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">pick goal → customize → first lesson</text>
  <text x="890" y="290" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">invested effort → wants to save it</text>
  <path d="M 380 190 L 720 190" stroke="var(--muted)" stroke-width="3" stroke-dasharray="6 6" marker-end="url(#arrow-ikea)"/>
  <defs>
    <marker id="arrow-ikea" markerWidth="10" markerHeight="10" refX="8" refY="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 Z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ให้ user custom goal, สี, หรือ lesson แรกก่อนขอสร้าง account (แบบ Duolingo)</div>

<!-- Speaker: ปุ่ม signup ที่โผล่หลังลงมือทำ จะรู้สึกเป็น "continue" ไม่ใช่ form เปล่า -->

---

## Loss Aversion: ชูสิ่งที่จะสูญเสีย

<p class="subhead">Kahneman พิสูจน์ว่าความเจ็บปวดจากการสูญเสียมีพลังมากกว่าความสุขจากการได้รับเทียบเท่าถึง ~2 เท่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="550" y1="60" x2="550" y2="180" stroke="var(--ink-dim)" stroke-width="4"/>
  <line x1="280" y1="180" x2="820" y2="180" stroke="var(--ink-dim)" stroke-width="4"/>
  <line x1="280" y1="180" x2="280" y2="260" stroke="var(--ink-dim)" stroke-width="3"/>
  <line x1="820" y1="180" x2="820" y2="220" stroke="var(--ink-dim)" stroke-width="3"/>
  <rect x="200" y="260" width="160" height="60" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="280" y="296" font-size="18" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">LOSS</text>
  <rect x="740" y="220" width="160" height="40" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="820" y="246" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">GAIN</text>
  <text x="550" y="120" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prospect Theory</text>
  <text x="550" y="345" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Loss weighs ~2x heavier psychologically than an equal gain</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อย่า frame แค่สิ่งที่ user จะได้ — โชว์สิ่งที่จะเสีย (ไฟล์ที่จะถูกลบ, countdown) จะสร้าง urgency มากกว่า</div>

<!-- Speaker: เตือนเส้นแบ่ง dark pattern — ต้องเป็นเรื่องจริง ไม่ใช่ fake urgency -->

---

## Contrast Effect: เปรียบเทียบราคาให้ดูคุ้ม

<p class="subhead">สมองประเมินตัวเลขโดยเทียบกับสิ่งที่เห็นก่อนหน้าทันที (anchoring) — อย่าโชว์ราคาแบบเดี่ยวๆ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="120" y="60" width="380" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="310" y="105" font-size="15" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Laptop (anchor)</text>
  <text x="310" y="180" font-size="40" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">$1,900</text>
  <path d="M 500 190 L 590 190" stroke="var(--accent)" stroke-width="3" marker-end="url(#arrow-contrast)"/>
  <defs>
    <marker id="arrow-contrast" markerWidth="10" markerHeight="10" refX="8" refY="5" orient="auto">
      <path d="M0,0 L10,5 L0,10 Z" fill="var(--accent)"/>
    </marker>
  </defs>
  <rect x="600" y="60" width="380" height="260" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
  <text x="790" y="105" font-size="15" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Protection plan</text>
  <text x="790" y="180" font-size="40" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">$50</text>
  <text x="790" y="230" font-size="18" font-weight="700" fill="var(--gold)" text-anchor="middle" font-family="system-ui">just 2.6%</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วาง price add-on ไว้คู่กับ anchor ที่ใหญ่กว่าเสมอ ทำให้ตัวเลขจริงดูเหมือนเศษเล็กๆ</div>

<!-- Speaker: ปิดหลักการทั้ง 6 — เชื่อมไปสู่ user guide ว่าจะเอาไปใช้ยังไง -->

---

## User Guide: เอาไปใช้จริง 6 ขั้นตอน

<p class="subhead">แก้ทีละจุด วัดผลก่อน-หลัง อย่า optimize ทั้ง funnel พร้อมกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="90" y1="80" x2="1010" y2="80" stroke="var(--soft-2)" stroke-width="2"/>
  <g>
    <circle cx="90" cy="80" r="30" fill="var(--accent)"/>
    <text x="90" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
    <text x="90" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Audit funnel</text>
  </g>
  <g>
    <circle cx="274" cy="80" r="30" fill="var(--accent)"/>
    <text x="274" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
    <text x="274" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Map principle</text>
  </g>
  <g>
    <circle cx="458" cy="80" r="30" fill="var(--accent)"/>
    <text x="458" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
    <text x="458" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Prototype</text>
  </g>
  <g>
    <circle cx="642" cy="80" r="30" fill="var(--accent)"/>
    <text x="642" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
    <text x="642" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Instrument</text>
  </g>
  <g>
    <circle cx="826" cy="80" r="30" fill="var(--accent)"/>
    <text x="826" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
    <text x="826" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">A/B test</text>
  </g>
  <g>
    <circle cx="1010" cy="80" r="30" fill="var(--accent)"/>
    <text x="1010" y="86" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">6</text>
    <text x="1010" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Repeat</text>
  </g>
  <text x="550" y="210" font-size="14" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1 principle → 1 A/B test → measure → next drop-off point</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เปลี่ยนแค่ 1 principle ต่อ 1 test เพื่อแยกให้ออกว่าอะไร move metric จริง</div>

<!-- Speaker: ย้ำเรื่อง sample size ให้พอก่อนตัดสินใจ roll out เต็ม -->

---

## Caveats: เส้นแบ่งที่ต้องระวัง

<p class="subhead">Psychology-informed design ไม่เท่ากับ manipulation — มีขอบเขตที่ต้องรักษา</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Ethics</p>
    <h3>เส้นแบ่ง Dark Pattern</h3>
    <p>Fake countdown หรือ fake stock ต่ำ ข้ามจาก psychology-informed ไปเป็น manipulative — เสีย trust และอาจผิด regulation</p>
  </div>
  <div class="card warning">
    <p class="label">Evidence</p>
    <h3>Correlation ≠ Causation</h3>
    <p>ตัวเลขจาก case study มาจาก context เฉพาะ — ต้อง validate ด้วย A/B test ของตัวเองเสมอ ไม่ copy ตรงๆ</p>
  </div>
  <div class="card">
    <p class="label">Context</p>
    <h3>Cultural Variance</h3>
    <p>Reciprocity และ Loss Aversion มี strength ต่างกันตาม culture — งานวิจัยส่วนใหญ่ทำใน US/Western context</p>
  </div>
  <div class="card success">
    <p class="label">Fatigue</p>
    <h3>Novelty Wear-off</h3>
    <p>Goal Gradient และ IKEA Effect ทำงานดีตอน user ยังใหม่ — ใช้ pattern ซ้ำนานเกินไป user จะรู้สึกว่าเป็น "trick"</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้หลักจิตวิทยาเพื่อลด friction ที่มีอยู่จริง ไม่ใช่สร้าง friction ปลอมเพื่อบังคับ</div>

<!-- Speaker: นี่คือจุดที่ทีม legal/design ควร review ร่วมกัน -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้ข้าม deep dive ไปเลย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card compact">
    <h3>Smart Defaults</h3>
    <p>Pre-fill ค่าที่คนส่วนใหญ่เลือก — 70-90% ไม่เปลี่ยน default</p>
  </div>
  <div class="card compact">
    <h3>Goal Gradient</h3>
    <p>ห้ามเริ่ม 0% ให้ head start เพื่อสร้าง momentum</p>
  </div>
  <div class="card compact">
    <h3>Reciprocity</h3>
    <p>ให้ value ก่อนขอ sign up เสมอ</p>
  </div>
  <div class="card compact">
    <h3>IKEA Effect</h3>
    <p>ให้ user custom ก่อนสร้าง account เพื่อความเป็นเจ้าของ</p>
  </div>
  <div class="card compact">
    <h3>Loss Aversion</h3>
    <p>Frame สิ่งที่จะเสีย — pain มีพลังกว่า gain ~2 เท่า</p>
  </div>
  <div class="card compact gold">
    <h3>Contrast Effect</h3>
    <p>วางราคาคู่กับ anchor ที่ใหญ่กว่าเสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Validate ทุกอย่างด้วย A/B test จริง — ตัวเลขจาก case study เป็น hypothesis ไม่ใช่ guarantee</div>

<!-- Speaker: จบด้วยการชวนให้เลือก 1 principle ไปทดลองใน sprint ถัดไป -->
