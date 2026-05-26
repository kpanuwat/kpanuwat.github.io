---
marp: true
theme: default
paginate: true
title: "AI สร้าง HTML Presentation แทน PowerPoint"
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

# AI สร้าง HTML Presentation แทน PowerPoint

<p class="tag">Interactive Slides สำหรับทุกคน — ไม่ต้องเขียนโค้ด ไม่ต้องเป็น Designer</p>

<!-- Speaker: เปิดด้วยคำถาม "ทำไมยังใช้ PowerPoint อยู่?" แล้วบอกว่าวันนี้จะแสดงทางเลือกที่ดีกว่า -->

---

## HTML Slides สร้างได้ใน Minutes ด้วยพิมพ์อธิบาย Content

<p class="subhead">AI agent จัดการ layout, animation, 3D — ผู้ใช้แค่บอก "อยากได้อะไร"</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="260" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="260" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="130" r="32" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="130" r="22" fill="var(--accent)"/>
  <text x="148" y="136" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">AI</text>
  <text x="210" y="118" font-size="19" font-weight="700" fill="var(--ink)" font-family="system-ui">พิมพ์อธิบาย content → AI สร้าง HTML Presentation ให้เลย</text>
  <text x="210" y="148" font-size="14" fill="var(--ink-dim)" font-family="system-ui">12 preset styles · 3 preview ก่อน confirm · single .html file ไม่มี dependency</text>
  <rect x="90" y="195" width="220" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="200" y="224" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Interactive</text>
  <text x="200" y="248" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Hover, 3D, Animation</text>
  <rect x="340" y="195" width="220" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="450" y="224" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browser-native</text>
  <text x="450" y="248" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เปิดได้ทุก browser</text>
  <rect x="590" y="195" width="220" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="700" y="224" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Deploy บน Web</text>
  <text x="700" y="248" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">GitHub Pages ฟรี</text>
  <rect x="840" y="195" width="170" height="72" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="925" y="224" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">ไม่ต้องโค้ด</text>
  <text x="925" y="248" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AI ทำให้ทั้งหมด</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML Presentation เปลี่ยน workflow จาก "ออกแบบทีละ element" เป็น "อธิบาย outcome แล้วให้ AI สร้าง"</div>

<!-- Speaker: นี่คือ TL;DR ของทั้ง deck — ถ้าเวลาน้อย slide นี้ slide เดียวก็พอ -->

---

## PowerPoint มีข้อจำกัด — ที่ HTML แก้ได้ทั้งหมด

<p class="subhead">30+ HTML Slide Skills สำหรับ Claude Code, Cursor, Codex พร้อมใช้ปี 2025-2026</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-html-presentation-vs-powerpoint-3.png" alt="UI Component ecosystem for HTML presentations: 21st.dev, Motion Sites, reveal.js, single-file output">
<figcaption>Source: NotebookLM · HTML Presentation ecosystem — frameworks, component sources, output formats</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อะไรก็ตามที่ทำได้บน website ทำได้บน slide — 3D, live chart, API call, scroll animation</div>

<!-- Speaker: แสดง ecosystem ของ tools ที่มีอยู่ — ไม่ใช่แค่ reveal.js แต่มี skill layer ที่ทำให้ AI ใช้ framework เหล่านี้ได้โดยตรง -->

---

## HTML Presentation Skill คือ "Instruction Set" ให้ AI สร้างสไลด์

<p class="subhead">ติดตั้งครั้งเดียว — agent รู้วิธีสร้าง deck ทุกครั้งที่สั่ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: install → prompt → preview → select → generate → edit -->
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Step boxes -->
  <rect x="30" y="110" width="140" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="100" y="152" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1. ติดตั้ง</text>
  <text x="100" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HTML Slide</text>
  <text x="100" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Skill</text>
  <line x1="170" y1="170" x2="200" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <rect x="205" y="110" width="140" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="275" y="152" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Prompt</text>
  <text x="275" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">อธิบาย content</text>
  <text x="275" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ mood + จำนวน</text>
  <line x1="345" y1="170" x2="375" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <rect x="380" y="110" width="140" height="120" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="450" y="152" font-size="11" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">3. Preview</text>
  <text x="450" y="170" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AI สร้าง 3 style</text>
  <text x="450" y="186" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ให้เลือก</text>
  <line x1="520" y1="170" x2="550" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <rect x="555" y="110" width="140" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="625" y="152" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">4. เลือก Style</text>
  <text x="625" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">จาก 12 presets</text>
  <text x="625" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(dark/light/special)</text>
  <line x1="695" y1="170" x2="725" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <rect x="730" y="110" width="140" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="800" y="152" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">5. Generate</text>
  <text x="800" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">deck เต็มรูปแบบ</text>
  <text x="800" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">single .html</text>
  <line x1="870" y1="170" x2="900" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <rect x="905" y="110" width="160" height="120" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="985" y="152" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">6. แก้ใน Browser</text>
  <text x="985" y="170" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">click-to-edit</text>
  <text x="985" y="186" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">ทันที ไม่ต้องโค้ด</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 12 preset styles + 3 preview before commit = ลด AI slop — ได้ผลที่ไม่ generic ทุกครั้ง</div>

<!-- Speaker: เน้นว่า skill คือ "system prompt" พิเศษที่บอก AI ว่าต้องทำงานอย่างไร — เหมือน template ที่ฉลาด -->

---

## HTML เหนือกว่า PowerPoint ใน 5 มิติหลัก

<p class="subhead">Interactivity, 3D, Browser-native, AI speed, Portability — HTML ชนะทั้งหมด</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-html-presentation-vs-powerpoint-2.png" alt="Comparison: HTML Presentation vs PowerPoint vs Google Slides across 8 criteria">
<figcaption>Source: NotebookLM · HTML vs PowerPoint vs Google Slides — 8 criteria comparison</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PDF export ยังได้ แต่สูญเสีย animation — วางแผนไว้ล่วงหน้าถ้าต้องการ share แบบ static</div>

<!-- Speaker: อ่าน table ให้ผู้ฟัง focus ที่ Interactivity และ 3D — สองตัวนี้คือความแตกต่างที่เห็นได้ชัดที่สุด -->

---

## 21st.dev + Motion Sites: คลัง Component เสริมลูกเล่น

<p class="subhead">Copy prompt → AI inject ลง slide ได้เลย — ไม่ต้องเขียน CSS/JS เอง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Free · 1.4M Users</p>
    <h3>21st.dev</h3>
    <p>Community registry ใหญ่สุด React + Tailwind + Framer Motion. Copy prompt ของ component → AI inject ลง slide ได้ทันที. Magic Chat สร้าง/remix component ผ่าน AI chat.</p>
  </div>
  <div class="card gold">
    <p class="label">Inspiration + Free Tier</p>
    <h3>Motion Sites</h3>
    <p>Design inspiration + web animation components. Premium designs ใช้เป็น reference ให้ AI recreate คล้ายๆ ได้ฟรี. Free components copy ได้ตรงๆ.</p>
  </div>
  <div class="card">
    <p class="label">Open Source · Foundation</p>
    <h3>reveal.js</h3>
    <p>HTML presentation framework ที่ Skills หลายตัวใช้เป็น base. Auto-Animate, nested slides, 3D transitions, Markdown support. ผสาน Three.js / D3 ได้.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 21st.dev คือ "component store" ที่ AI agent ดึงมาใช้ได้ตรงๆ — copy prompt → inject ลง slide ได้เลย</div>

<!-- Speaker: เปิด 21st.dev ใน browser สด แล้วแสดงวิธี copy prompt — audience จะเห็น workflow จริง -->

---

## Workflow ทีละขั้น: ติดตั้งถึง Deploy

<p class="subhead">ตั้งแต่ศูนย์จนได้ presentation พร้อมแชร์ — ใน session เดียว</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-html-presentation-vs-powerpoint-1.png" alt="Step-by-step workflow: Install → Describe → Preview → Select → Build → Edit → Components → Deploy">
<figcaption>Source: NotebookLM · Complete workflow — install skill to live presentation</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Browser editing แบบ click-to-edit ลด feedback loop — แก้ไขได้เลยโดยไม่ต้องกลับไปแก้โค้ด</div>

<!-- Speaker: เน้นขั้นตอนที่ 3 (Preview 3 styles) — นี่คือจุดที่ชนะ PowerPoint ชัดที่สุด ไม่ต้องเดาว่า output จะออกมาแบบไหน -->

---

## ข้อควรรู้ก่อนใช้งาน HTML Presentation

<p class="subhead">Trade-off ที่ต้องวางแผนล่วงหน้า — ไม่ใช่ปัญหา แต่ต้องรู้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">PDF Export</p>
    <h3>Animation หายใน PDF</h3>
    <p>Export PDF ได้ แต่ได้แค่ static snapshot ถ้าต้องการ share แบบมี animation ต้อง deploy เป็น website หรือส่ง link แทน</p>
  </div>
  <div class="card warning">
    <p class="label">Browser Compatibility</p>
    <h3>ทดสอบบน Chrome/Edge ก่อน</h3>
    <p>CSS 3D effect อาจแสดงผลต่างระหว่าง browser ทดสอบบน target browser ก่อน present จริง</p>
  </div>
  <div class="card danger">
    <p class="label">Component Compatibility</p>
    <h3>React Component ต้องปรับก่อน</h3>
    <p>Component จาก 21st.dev ที่เป็น React อาจต้องแปลงเป็น vanilla JS ก่อน inject ถ้า slide output ไม่ใช่ React-based</p>
  </div>
  <div class="card danger">
    <p class="label">File Size</p>
    <h3>หลาย 3D Component = ไฟล์ใหญ่</h3>
    <p>Embed หลาย animation อาจได้ไฟล์ 10MB+ optimize ก่อน deploy สำหรับ audience ที่ internet ช้า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Skill quality varies — ทดสอบหลาย skills แล้วเลือก ไม่มี one-size-fits-all</div>

<!-- Speaker: นี่ไม่ใช่เหตุผลให้ไม่ใช้ แต่เป็นสิ่งที่ต้องรู้ก่อนเลือก tool สำหรับงานแต่ละแบบ -->

---

## Key Takeaways: HTML Presentation เปลี่ยน Workflow ไปตลอดกาล

<p class="subhead">7 สิ่งที่ต้องจำจาก deck นี้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- concentric-rings: core = AI generation, outer = benefits -->
  <circle cx="550" cy="160" r="150" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="160" r="100" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".35"/>
  <circle cx="550" cy="160" r="55" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="160" r="55" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="154" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AI สร้าง</text>
  <text x="550" y="174" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">HTML Slides</text>
  <!-- Mid ring labels -->
  <text x="390" y="95" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">12 Presets</text>
  <text x="390" y="112" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ 3 Preview</text>
  <text x="710" y="95" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browser Edit</text>
  <text x="710" y="112" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">click-to-edit</text>
  <text x="690" y="235" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">21st.dev</text>
  <text x="690" y="252" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">inject component</text>
  <text x="410" y="235" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Web-native</text>
  <text x="410" y="252" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3D · Animation</text>
  <!-- Outer labels -->
  <text x="240" y="155" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Deploy</text>
  <text x="240" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">bน Web ฟรี</text>
  <text x="860" y="155" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1 File</text>
  <text x="860" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Zero Deps</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เหมาะที่สุดสำหรับ pitch deck, technical presentation, project showcase — ที่ต้องการ impression แรกที่แข็งแกร่ง</div>

<!-- Speaker: ถ้าจะลองวันนี้ — เริ่มที่ mcpmarket.com หรือ explainx.ai แล้ว install skill ตัวแรก ใช้เวลาไม่เกิน 5 นาที -->
