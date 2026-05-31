---
marp: true
theme: default
paginate: true
title: "Diode: AWS for Electronics"
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

# Diode: AWS for Electronics

<p class="tag">AI-powered PCB design & manufacturing — from months to weeks</p>

<!-- Speaker: Diode คือ startup ที่ใช้ AI ปฏิวัติการออกแบบและผลิต PCB ในสหรัฐฯ วิสัยทัศน์: ทำ hardware ให้ agile เหมือน software บน AWS -->

---

## Hardware Gets an AWS Moment

<p class="subhead">Diode ระดมทุน $11.4M (a16z) เพื่อเร่ง PCB iteration จากเดือนเหลือสัปดาห์ — 100+ บอร์ดต่อวิศวกรต่อปี</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="300" height="220" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="300" height="6" rx="3" fill="var(--accent)"/>
  <text x="210" y="120" font-size="56" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">$11.4M</text>
  <text x="210" y="160" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Series A — a16z lead</text>
  <text x="210" y="230" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Jul 2025</text>
  <rect x="400" y="40" width="300" height="220" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="400" y="40" width="300" height="6" rx="3" fill="var(--success)"/>
  <text x="550" y="120" font-size="56" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">100+</text>
  <text x="550" y="160" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">boards / engineer / year</text>
  <text x="550" y="230" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">vs ~10-20 traditional</text>
  <rect x="740" y="40" width="300" height="220" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="740" y="40" width="300" height="6" rx="3" fill="var(--warning)"/>
  <text x="890" y="120" font-size="56" font-weight="800" fill="var(--warning)" text-anchor="middle" font-family="system-ui">250+</text>
  <text x="890" y="160" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">reference modules</text>
  <text x="890" y="230" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">generated in 2 weeks</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Diode เปลี่ยน hardware development จาก "months of waiting" เป็น "days of iteration" — ด้วย AI + full-stack manufacturing</div>

<!-- Speaker: 3 ตัวเลขหลักที่พิสูจน์ว่า Diode ทำงานได้จริง ไม่ใช่แค่ vision -->

---

## PCB is the "Forgotten Middle Child" of Tech

<p class="subhead">Software iterates in hours; hardware PCB takes months — same team, same ambition, 100x speed difference</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="480" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="280" y="51" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Software Development</text>
  <text x="280" y="110" font-size="42" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Hours</text>
  <text x="280" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">write code — push — deployed</text>
  <text x="80" y="200" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Git push triggers build</text>
  <text x="80" y="225" font-size="13" fill="var(--ink-dim)" font-family="system-ui">CI/CD pipeline runs tests</text>
  <text x="80" y="250" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Feature ships to users</text>
  <text x="80" y="275" font-size="13" fill="var(--muted)" font-family="system-ui">Iterate again tomorrow</text>
  <rect x="580" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="580" y="20" width="480" height="52" rx="12" fill="var(--danger)" opacity=".06"/>
  <text x="820" y="51" font-size="16" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">PCB Hardware (Traditional)</text>
  <text x="820" y="110" font-size="42" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Months</text>
  <text x="820" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">manual — sequential — error-prone</text>
  <text x="620" y="200" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Library component: manual entry</text>
  <text x="620" y="225" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Schematic: draw in GUI</text>
  <text x="620" y="250" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Layout: route traces manually</text>
  <text x="620" y="275" font-size="13" fill="var(--danger)" font-family="system-ui">Fabricator email loop: weeks</text>
  <circle cx="555" cy="170" r="24" fill="var(--ink)"/>
  <text x="555" y="175" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PCB คือ bottleneck ระหว่าง idea กับ product — Diode แก้ gap นี้โดยทำให้ hardware iterate ได้เหมือน software</div>

<!-- Speaker: ปัญหาคือ hardware dev ไม่ evolve ตาม software ทำให้ทีม hardware ถูกเบรกทุกครั้ง -->

---

## Zener: Schematics-as-Code Unlocks LLM Design

<p class="subhead">Zener (Starlark/Python DSL) แทนการวาด schematic ด้วย GUI — ทำให้ LLM อ่านและแก้ circuit ได้โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="480" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="280" y="51" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Traditional GUI (EDA)</text>
  <text x="80" y="110" font-size="13" fill="var(--danger)" font-family="system-ui">Binary file — git merge fails</text>
  <text x="80" y="140" font-size="13" fill="var(--danger)" font-family="system-ui">LLM cannot read symbols/images</text>
  <text x="80" y="170" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Fab constraints separate doc</text>
  <text x="80" y="200" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Copy-paste = silent errors</text>
  <text x="80" y="230" font-size="13" fill="var(--muted)" font-family="system-ui">No code review workflow</text>
  <text x="80" y="260" font-size="13" fill="var(--muted)" font-family="system-ui">No automated reuse</text>
  <rect x="580" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="580" y="20" width="480" height="52" rx="12" fill="var(--accent)" opacity=".06"/>
  <text x="820" y="51" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Zener DSL (Code)</text>
  <text x="620" y="110" font-size="13" fill="var(--success)" font-family="system-ui">Plain text — git diff / PR review</text>
  <text x="620" y="140" font-size="13" fill="var(--success)" font-family="system-ui">LLM traces signal paths directly</text>
  <text x="620" y="170" font-size="13" fill="var(--ink)" font-family="system-ui">Fab constraints embedded in code</text>
  <text x="620" y="200" font-size="13" fill="var(--ink)" font-family="system-ui">Reuse module = function call</text>
  <text x="620" y="230" font-size="13" fill="var(--ink)" font-family="system-ui">CI/CD for hardware design</text>
  <text x="620" y="260" font-size="13" fill="var(--accent)" font-family="system-ui">Renders to graphical schematic</text>
  <circle cx="555" cy="170" r="24" fill="var(--accent)"/>
  <text x="555" y="175" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Zener คือกุญแจ — Python-based syntax ทำให้ Claude อ่าน schematic ได้โดยตรงและ trace signal path ได้เหมือน engineer อ่าน code</div>

<!-- Speaker: Zener แก้ปัญหาพื้นฐาน: LLM ไม่สามารถ "มองเห็น" circuit ใน GUI ได้ แต่อ่าน code ได้ดีมาก -->

---

## AI Pipeline: Datasheet In, Verified Module Out

<p class="subhead">Claude อ่าน datasheet → draft Zener module → verify อัตโนมัติ → engineer sign-off → publish library — ทั้งหมดในไม่กี่ชั่วโมง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="100" width="155" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="107" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Datasheet</text>
  <text x="107" y="156" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PDF / specs</text>
  <polygon points="192,140 206,134 206,146" fill="var(--accent)"/>
  <line x1="185" y1="140" x2="207" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <rect x="210" y="100" width="155" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="287" y="136" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude LLM</text>
  <text x="287" y="156" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">drafts Zener module</text>
  <polygon points="372,140 386,134 386,146" fill="var(--accent)"/>
  <line x1="365" y1="140" x2="387" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <rect x="390" y="100" width="155" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="467" y="132" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Verification</text>
  <text x="467" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SPICE + static</text>
  <text x="467" y="170" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">checks (Rust core)</text>
  <polygon points="552,140 566,134 566,146" fill="var(--success)"/>
  <line x1="545" y1="140" x2="567" y2="140" stroke="var(--success)" stroke-width="2"/>
  <rect x="570" y="100" width="155" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="647" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Engineer</text>
  <text x="647" y="156" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">review + sign-off</text>
  <polygon points="732,140 746,134 746,146" fill="var(--success)"/>
  <line x1="725" y1="140" x2="747" y2="140" stroke="var(--success)" stroke-width="2"/>
  <rect x="750" y="100" width="155" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="827" y="136" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Library</text>
  <text x="827" y="156" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">zener.diode.computer</text>
  <path d="M545,185 C545,255 287,255 287,185" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,3"/>
  <polygon points="282,185 287,180 292,185" fill="var(--danger)"/>
  <text x="416" y="248" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">fail: model iterates</text>
  <rect x="940" y="80" width="130" height="52" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="1005" y="101" font-size="18" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">250+</text>
  <text x="1005" y="122" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">modules / 2 weeks</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI pipeline ไม่ใช่แค่ "generate" — มี SPICE simulation + static analysis ทุกครั้ง ก่อนส่งให้ human review</div>

<!-- Speaker: การมี fail loop กลับไปที่ Claude ทำให้ระบบ self-correct ได้ก่อนที่ engineer จะต้องเห็น -->

---

## Three-Layer Verification: No Undetected Defects

<p class="subhead">ทุก module ผ่าน 3 ชั้น verification อัตโนมัติก่อนถึง engineer — SPICE, static analysis, auto-placement</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Layer 1 — Simulation</p>
    <h3>SPICE Simulation</h3>
    <p>รัน simulation อัตโนมัติทุก module คืนค่า quantitative: gain, bandwidth, stability margins</p>
    <p>Model iterate อัตโนมัติถ้าวงจรไม่ผ่าน spec</p>
  </div>
  <div class="card warning">
    <p class="label">Layer 2 — Static Analysis</p>
    <h3>Rust Verification Core</h3>
    <p>Netlist tracing: ตรวจ power paths + signal directionality</p>
    <p>Floating pin detection, miswired connection detection</p>
  </div>
  <div class="card success">
    <p class="label">Layer 3 — Placement</p>
    <h3>Auto Placement</h3>
    <p>AI จัด decoupling capacitor, bulk cap banks, label alignment อัตโนมัติ</p>
    <p>ลด manual layout error ที่เกิดจากการวางด้วยมือ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Verification 3 ชั้นทำให้ "AI-generated design" กลายเป็น "production-ready design" ไม่ใช่แค่ draft ที่ต้องแก้ทั้งหมด</div>

<!-- Speaker: Rust core เลือกเพราะ memory safety และ speed — verification loop ต้องไว เพราะ model อาจ iterate หลายรอบ -->

---

## Co-design: Manufacturing Constraints Live in Code

<p class="subhead">Diode เป็น full-stack manufacturer — shop-specific rules embed ใน Zener ตั้งแต่ต้น ลด fabricator revision loop</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="100" width="135" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="87" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">git push</text>
  <text x="87" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Zener source</text>
  <polygon points="161,140 175,134 175,146" fill="var(--accent)"/>
  <line x1="155" y1="140" x2="176" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <rect x="180" y="100" width="135" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="247" y="136" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Compile</text>
  <text x="247" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">schematic + netlist</text>
  <polygon points="321,140 335,134 335,146" fill="var(--accent)"/>
  <line x1="315" y1="140" x2="336" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <rect x="340" y="100" width="135" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="407" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">DRC / ERC</text>
  <text x="407" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">auto-verified rules</text>
  <polygon points="481,140 495,134 495,146" fill="var(--accent)"/>
  <line x1="475" y1="140" x2="496" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <rect x="500" y="100" width="135" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="567" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Gerber + BOM</text>
  <text x="567" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">generated output</text>
  <polygon points="641,140 655,134 655,146" fill="var(--success)"/>
  <line x1="635" y1="140" x2="656" y2="140" stroke="var(--success)" stroke-width="2"/>
  <rect x="660" y="100" width="135" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="727" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Fabrication</text>
  <text x="727" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Brooklyn Navy Yard</text>
  <polygon points="801,140 815,134 815,146" fill="var(--success)"/>
  <line x1="795" y1="140" x2="816" y2="140" stroke="var(--success)" stroke-width="2"/>
  <rect x="820" y="100" width="135" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="887" y="136" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Ship Board</text>
  <text x="887" y="156" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">physical product</text>
  <rect x="1000" y="90" width="80" height="40" rx="8" fill="var(--gold)" fill-opacity="0.15" stroke="var(--gold)" stroke-width="1.5"/>
  <text x="1040" y="112" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Like AWS</text>
  <text x="40" y="220" font-size="11" fill="var(--muted)" font-family="system-ui">Fab constraints embedded at design time — no email loop with fabricator</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Full-stack ownership = manufacturing constraint embed ใน code ตั้งแต่ต้น ลด revision round จาก "หลายครั้ง" เหลือ "ไม่มี"</div>

<!-- Speaker: นี่คือ moat ของ Diode — คู่แข่งที่เป็นแค่ design tool ไม่รู้ว่า fab ทำได้จริงหรือเปล่า -->

---

## Impact by the Numbers

<p class="subhead">ตัวเลขที่วัดได้ — ก่อนและหลัง Diode</p>

<div class="infographic">

| Metric | Traditional | With Diode |
|---|---|---|
| Design cycle | weeks–months | **days to weeks** |
| Boards / engineer / year | ~10–20 | **100+** |
| Reference modules (2 weeks) | — | **250+** |
| Fabricator revision loops | many | **near zero** |
| Funding (Series A, Jul 2025) | — | **$11.4M — a16z lead** |

</div>

<div class="takeaway"><b>★ Takeaway:</b> 100+ boards/year ต่อ engineer = 5–10x improvement — measured on real projects, not benchmark</div>

<!-- Speaker: ตัวเลข 250 modules ใน 2 สัปดาห์มาจาก pipeline จริงที่ Diode รันกับ Anthropic -->

---

## Customers: Where Hardware Meets Real-World AI

<p class="subhead">Diode เน้น industry ที่ hardware iteration คือ bottleneck — robotics, maritime, aerospace, Fortune 100</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">AI Robotics</p>
    <h3>Physical Intelligence</h3>
    <p>Robot hardware ต้องการ PCB iteration เร็วเพื่อตาม software model ที่ evolve รายสัปดาห์</p>
  </div>
  <div class="card warning">
    <p class="label">Maritime Autonomy</p>
    <h3>Saronic</h3>
    <p>Autonomous vessel electronics ต้องการ reliability สูงและ custom board design ที่รวดเร็ว</p>
  </div>
  <div class="card gold">
    <p class="label">Enterprise</p>
    <h3>Fortune 100</h3>
    <p>บริษัทขนาดใหญ่ (ไม่เปิดเผยชื่อ) ต้องการ in-house PCB design ที่ scalable</p>
  </div>
  <div class="card success">
    <p class="label">AI Partner</p>
    <h3>Anthropic</h3>
    <p>Partner อย่างเป็นทางการ — teaching Claude electrical engineering domain knowledge</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Diode เลือก customer ที่ hardware velocity คือ competitive advantage — ไม่ใช่ commodity manufacturer</div>

<!-- Speaker: การ partner กับ Anthropic หมายความว่า Claude จะดีขึ้นใน EE domain ซึ่งเป็น flywheel ให้ Diode ด้วย -->

---

## Know the Limits Before You Adopt

<p class="subhead">Diode แก้ปัญหาใหญ่ได้ แต่มีข้อจำกัดที่ต้องรู้ก่อนตัดสินใจ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Still Required</p>
    <h3>Engineer Sign-off</h3>
    <p>ทุก AI-generated design ต้องผ่าน human review ก่อน production — ไม่ใช่ push-button automation สมบูรณ์</p>
  </div>
  <div class="card danger">
    <p class="label">Lock-in Risk</p>
    <h3>Zener Ecosystem</h3>
    <p>Design ที่อยู่ใน Zener DSL migrate ออกยาก — vendor lock-in คล้าย AWS ตอนย้าย cloud</p>
  </div>
  <div class="card">
    <p class="label">Scope</p>
    <h3>US-Focused, Early Stage</h3>
    <p>Manufacturing ที่ Brooklyn Navy Yard — geographic reach จำกัด Series A ยังเป็นช่วง scale</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Diode เหมาะกับทีมที่ hardware velocity คือ priority — ไม่ใช่ทุก company ที่ต้องการ custom PCB</div>

<!-- Speaker: Analog circuit และ high-speed layout ยังต้องการ domain expertise สูง — AI ช่วยได้มากแต่ยังไม่ replace senior EE engineer -->

---

## System Overview: One-Page Reference

<p class="subhead">แผนผังรวม Diode ecosystem — Zener, AI pipeline, verification, manufacturing</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/diode-aws-for-electronics-cheatsheet.png" alt="Diode AWS for Electronics technical cheatsheet showing Zener DSL, AI pipeline, verification layers, co-design manufacturing, and key metrics">
<figcaption>Source: NotebookLM · Diode technical overview — Zener, AI pipeline, verification, metrics</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Zener + Claude + Rust verification + full-stack manufacturing = hardware development ที่ agile เหมือน software</div>

<!-- Speaker: ใช้ slide นี้เป็น reference card หลังการ present -->

---

## Key Takeaways: Hardware Renaissance is Now

<p class="subhead">สิ่งที่ต้องจำจาก Diode</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Core Insight</p>
    <h3>Schematics-as-Code = LLM Gateway</h3>
    <p>Zener (Starlark/Python) ทำให้ Claude อ่านและแก้ circuit design ได้โดยตรง — เปิด version control + AI workflow</p>
  </div>
  <div class="card">
    <p class="label">Pipeline Design</p>
    <h3>Generate + Verify = Production-Ready</h3>
    <p>SPICE simulation + Rust static checks ทำงานอัตโนมัติก่อน human review — ไม่ใช่แค่ draft generation</p>
  </div>
  <div class="card warning">
    <p class="label">Business Moat</p>
    <h3>Full-Stack Beats Design-Only</h3>
    <p>Own ทั้ง design tool + manufacturing = fab constraint embed ตั้งแต่ต้น — คู่แข่งที่เป็น tool-only ทำไม่ได้</p>
  </div>
  <div class="card gold">
    <p class="label">Impact</p>
    <h3>100+ Boards/Engineer/Year</h3>
    <p>5-10x vs traditional — measured on real projects; 250+ reference modules ใน 2 สัปดาห์ เป็นหลักฐาน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Electronics is where software meets the real world" — Davide Asnaghi. Diode พิสูจน์ว่า hardware dev ควรและสามารถ agile เหมือน softwareได้</div>

<!-- Speaker: จบด้วย vision ของ founder — hardware renaissance ต้องการ toolchain ใหม่ ไม่ใช่แค่ทำงานหนักขึ้น -->
