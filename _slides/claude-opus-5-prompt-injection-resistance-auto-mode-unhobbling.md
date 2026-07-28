---
marp: true
theme: default
paginate: true
title: "Claude Opus 5: Prompt Injection Resistance and Auto Mode"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-cover.png)

<div class="mark"></div>

# Claude Opus 5: ต้านทาน Prompt Injection เกือบสมบูรณ์ พร้อมรัน Auto Mode ต่อเนื่องเป็นเดือน

<p class="tag">Boris Cherny เผยเบื้องหลัง: ลบ system prompt ทิ้ง 80% แล้วโมเดลฉลาดขึ้น</p>

<!-- Speaker: 30-second intro — Opus 5 released July 24 2026; this deck covers prompt injection defense, Auto Mode, unhobbling, and Dynamic Workflows. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-cheatsheet.png)

<!-- Speaker: 60-second cheatsheet orientation — point at the 5 panels before advancing. -->

---

## TL;DR: 0% Attack Success เมื่อรวม Auto Mode

<p class="subhead">Claude Opus 5 (24 ก.ค. 2026) + Auto Mode ปิดช่องโหว่ prompt injection ได้เกือบสมบูรณ์ใน 129 browser scenarios</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="30" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="30" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="220" cy="180" r="110" fill="var(--accent)" opacity=".08"/>
  <circle cx="220" cy="180" r="82" fill="var(--accent)"/>
  <text x="220" y="172" font-size="48" font-weight="800" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">0%</text>
  <text x="220" y="208" font-size="13" fill="var(--paper)" text-anchor="middle" font-family="system-ui">129 SCENARIOS</text>
  <text x="410" y="110" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">Attack success with Auto Mode ON</text>
  <text x="410" y="145" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Gray Swan benchmark: 5.5% (Opus 4.8) to 2.0% (Opus 5)</text>
  <text x="410" y="175" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Browser attacks without safeguards: 31.5% to 3.70%</text>
  <text x="410" y="205" font-size="15" fill="var(--muted)" font-family="system-ui">System prompt deleted: over 80%</text>
  <text x="410" y="235" font-size="15" fill="var(--muted)" font-family="system-ui">Dynamic Workflows: up to 1,000 sub-agents / run</text>
  <text x="410" y="275" font-size="14" fill="var(--danger)" font-family="system-ui" font-weight="700">Caveat: risk is not zero in practice</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตัวเลข 0% เกิดจากการรวมโมเดล + Auto Mode เท่านั้น ไม่ใช่ความสามารถของโมเดลเดี่ยวๆ</div>

<!-- Speaker: Set the headline number, flag the caveat early so the audience doesn't overclaim it later. -->

---

## ทำไม Prompt Injection ถึงเป็น "Lethal Trifecta"

![bg right:40% contain](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-background.png)

<p class="subhead">Agent ที่อ่าน content จากภายนอกเสี่ยงถูกฝัง instruction แปลกปลอมเข้าควบคุมพฤติกรรม</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="40" width="180" height="90" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="120" y="80" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Web page</text>
  <text x="120" y="100" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">"delete all files"</text>
  <path d="M210 85 L320 85" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow1)"/>
  <rect x="320" y="40" width="140" height="90" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="390" y="80" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI Agent</text>
  <text x="390" y="100" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">reads content</text>
  <path d="M460 85 L560 85" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow1)" stroke-dasharray="4 3"/>
  <circle cx="600" cy="85" r="45" fill="var(--success)" opacity=".12"/>
  <circle cx="600" cy="85" r="32" fill="var(--success)"/>
  <text x="600" y="90" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">BLOCK</text>
  <text x="350" y="220" font-size="14" fill="var(--ink)" font-family="system-ui">2026: OpenAI admits prompt injection</text>
  <text x="350" y="245" font-size="14" fill="var(--ink)" font-family="system-ui">"may never be fully solved"</text>
  <defs>
    <marker id="arrow1" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ปีที่แล้ว agent จะทำตาม instruction แปลกปลอมนี้ทันที — Opus 5 คือรุ่นแรกที่ปฏิเสธได้เกือบสมบูรณ์</div>

<!-- Speaker: The portrait rail sets the security-shield scene; explain the lethal trifecta concept before the numbers slide. -->

---

## Gray Swan Benchmark: Opus 5 นำหน้าเรื่อง Anti-Injection

<p class="subhead">อัตราความสำเร็จของผู้โจมตีหลังพยายาม 15 ครั้ง — ยิ่งต่ำยิ่งดี</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="120" y1="60" x2="120" y2="320" stroke="var(--soft-2)" stroke-width="1.5"/>
  <line x1="120" y1="320" x2="1040" y2="320" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="180" y="80" width="90" height="240" rx="6" fill="var(--danger)" opacity=".75"/>
  <text x="225" y="70" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">5.5%</text>
  <text x="225" y="345" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Opus 4.8</text>
  <rect x="380" y="234" width="90" height="86" rx="6" fill="var(--accent)"/>
  <text x="425" y="224" font-size="18" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2.0%</text>
  <text x="425" y="345" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Opus 5</text>
  <rect x="580" y="223" width="90" height="97" rx="6" fill="var(--muted)" opacity=".6"/>
  <text x="625" y="213" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2.6%</text>
  <text x="625" y="345" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mythos 5</text>
  <rect x="780" y="216" width="90" height="104" rx="6" fill="var(--muted)" opacity=".4"/>
  <text x="825" y="206" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2.8%</text>
  <text x="825" y="345" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Fable 5</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Opus 5 ลดอัตราความสำเร็จของผู้โจมตีจาก 5.5% เหลือ 2.0% — ดีที่สุดในกลุ่มที่ทดสอบ</div>

<!-- Speaker: Lower is better. Opus 5 leads the comparison set on Gray Swan. -->

---

## Defense 3 ชั้น: ทำไม Browser Attack ถึงเหลือ 0%

<p class="subhead">ต้องรวมทั้ง 3 ชั้นถึงจะปิดช่องโหว่ได้เกือบสมบูรณ์ — ไม่มีชั้นไหนทำได้คนเดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="500" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="90" y="72" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">1. Aligned base model</text>
  <text x="90" y="96" font-size="12" fill="var(--ink-dim)" font-family="system-ui">3 years of alignment research</text>
  <path d="M310 120 L310 145" stroke="var(--muted)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="60" y="145" width="500" height="80" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="90" y="177" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">2. Prompt-injection classifier</text>
  <text x="90" y="201" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Mechanistic interpretability (Chris Olah)</text>
  <path d="M310 225 L310 250" stroke="var(--muted)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="60" y="250" width="500" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="90" y="282" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">3. Auto Mode classifier</text>
  <text x="90" y="306" font-size="12" fill="var(--ink)" font-family="system-ui">Blocks dangerous action before execution</text>
  <path d="M600 190 L680 190" stroke="var(--muted)" stroke-width="2" marker-end="url(#a2)"/>
  <circle cx="850" cy="190" r="120" fill="var(--success)" opacity=".08"/>
  <circle cx="850" cy="190" r="88" fill="var(--success)"/>
  <text x="850" y="182" font-size="42" font-weight="800" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">0%</text>
  <text x="850" y="216" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui">129 SCENARIOS</text>
  <defs><marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่มีชั้นไหนชั้นเดียวที่ทำให้ risk เป็นศูนย์ได้ด้วยตัวเอง — ต้องรวมทั้ง 3 ชั้น</div>

<!-- Speaker: Walk through each layer bottom-up; emphasize the Chris Olah interpretability piece as the novel part. -->

---

## Auto Mode: รันได้ "เป็นวัน สัปดาห์ เป็นเดือน มันไม่หยุด"

![bg right:40% contain](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-auto-mode.png)

<p class="subhead">2 ชั้นตรวจสอบ (input scanner + action classifier) ตัด permission prompt ที่คอยขัดจังหวะ session ยาว</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="60" width="180" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="120" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Input scanner</text>
  <text x="120" y="110" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">reviews each tool call</text>
  <path d="M210 95 L280 95" stroke="var(--muted)" stroke-width="2" marker-end="url(#a3)"/>
  <rect x="280" y="60" width="180" height="70" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="370" y="90" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Action classifier</text>
  <text x="370" y="110" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">blocks risky action</text>
  <path d="M460 95 L560 95" stroke="var(--muted)" stroke-width="2" marker-end="url(#a3)"/>
  <circle cx="610" cy="95" r="40" fill="var(--success)" opacity=".12"/>
  <circle cx="610" cy="95" r="28" fill="var(--success)"/>
  <text x="610" y="100" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">RUN</text>
  <text x="120" y="200" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">GA: July 10, 2026</text>
  <text x="120" y="228" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Team / Enterprise / API</text>
  <text x="120" y="256" font-size="14" fill="var(--muted)" font-family="system-ui">Trade-off: +token cost, +latency</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ต้องพึ่ง scaffolding เสริมแบบเดิม — โมเดลรู้เองว่าต้องทำ task ให้เสร็จ</div>

<!-- Speaker: Quote Cherny directly — "days, weeks, months at a time, it just won't stop." -->

---

## Unhobbling: ลบ System Prompt ทิ้งกว่า 80% แล้วโมเดลฉลาดขึ้น

![bg right:40% contain](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-unhobbling.png)

<p class="subhead">Ablation testing เจอว่า instruction เก่าที่เขียนไว้สำหรับโมเดลรุ่นก่อนกลายเป็นตัวถ่วง</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="60" y="50" font-size="13" font-weight="700" fill="var(--ink-dim)" font-family="system-ui">System prompt size</text>
  <rect x="60" y="70" width="240" height="46" rx="6" fill="var(--danger)" opacity=".7"/>
  <text x="180" y="99" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">BEFORE — 100%</text>
  <rect x="60" y="140" width="45" height="46" rx="6" fill="var(--success)"/>
  <text x="140" y="169" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">AFTER — under 20%</text>
  <path d="M170 220 L530 220" stroke="var(--soft-2)" stroke-width="2"/>
  <text x="170" y="250" font-size="13" fill="var(--ink)" font-family="system-ui">Delete all &#8594; find failures &#8594; add back only where needed</text>
  <text x="170" y="278" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">Result: model got smarter</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งเป้าหมายยากพร้อมเครื่องมือ verify แทนการสั่งทีละขั้นตอนแบบเดิม</div>

<!-- Speaker: Distinguish product overhang (gap between capability and product) from hobbling (product that restricts it). -->

---

## Dynamic Workflows: 1 คำสั่งสั่ง Sub-agent ได้ถึง 1,000 ตัว

<p class="subhead">Script JavaScript ที่ Claude เขียนเอง รันแยกจาก context หลัก — context เก็บแค่คำตอบสุดท้าย</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="150" width="180" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="130" y="185" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">"use a workflow"</text>
  <text x="130" y="205" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">user prompt</text>
  <path d="M220 190 L300 190" stroke="var(--muted)" stroke-width="2" marker-end="url(#a4)"/>
  <rect x="300" y="150" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="400" y="182" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">JS orchestrator</text>
  <text x="400" y="202" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">runs in background</text>
  <path d="M500 190 L580 190" stroke="var(--muted)" stroke-width="2" marker-end="url(#a4)"/>
  <rect x="580" y="90" width="220" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)"/>
  <text x="690" y="125" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">16 concurrent</text>
  <rect x="580" y="230" width="220" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)"/>
  <text x="690" y="265" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1,000 total / run</text>
  <path d="M800 190 L900 190" stroke="var(--muted)" stroke-width="2" marker-end="url(#a4)"/>
  <circle cx="960" cy="190" r="70" fill="var(--success)" opacity=".1"/>
  <text x="960" y="182" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Final answer</text>
  <text x="960" y="204" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">only</text>
  <text x="130" y="330" font-size="14" font-weight="700" fill="var(--gold)" font-family="system-ui">Example: Bun runtime, Zig to Rust</text>
  <text x="130" y="355" font-size="13" fill="var(--ink-dim)" font-family="system-ui">750,000 lines / 11 days / 99.8% tests passing</text>
  <defs><marker id="a4" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Loop, branching, และผลลัพธ์ระหว่างทางอยู่ในตัวแปรของสคริปต์ — ไม่ใช่ใน context ของโมเดล</div>

<!-- Speaker: Dynamic Workflows shipped with Opus 4.8 in May; Opus 5 lets these agents run for even longer. -->

---

## ทักษะยุคใหม่: Empirical มากกว่า Dogma

![bg right:40% contain](assets/claude-opus-5-prompt-injection-resistance-auto-mode-unhobbling-empirical-era.png)

<p class="subhead">Cherny เคยยึดกฎ function-only จนต้อง revert งานวิศวกร ก่อนยอมรับว่าความเห็นต้องพิสูจน์ด้วยข้อมูลจริง</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="150" cy="160" r="70" fill="none" stroke="var(--soft-2)" stroke-width="2"/>
  <text x="150" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Strong</text>
  <text x="150" y="175" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">opinion</text>
  <path d="M220 160 L330 160" stroke="var(--muted)" stroke-width="2" marker-end="url(#a5)"/>
  <circle cx="400" cy="160" r="70" fill="var(--accent)" opacity=".1"/>
  <circle cx="400" cy="160" r="52" fill="var(--accent)"/>
  <text x="400" y="155" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Test it</text>
  <text x="400" y="175" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui">empirically</text>
  <path d="M460 160 L570 160" stroke="var(--muted)" stroke-width="2" marker-end="url(#a5)"/>
  <circle cx="620" cy="160" r="60" fill="none" stroke="var(--success)" stroke-width="2"/>
  <text x="620" y="155" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Updated</text>
  <text x="620" y="175" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">belief</text>
  <text x="150" y="270" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">90%+ of Anthropic's code</text>
  <text x="150" y="290" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">now written by Claude Code</text>
  <defs><marker id="a5" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ความได้เปรียบที่ยังเหลือของมนุษย์คือการสอนคุณค่า ไม่ใช่ taste หรือ product sense</div>

<!-- Speaker: Cherny runs hundreds of Claude instances monitoring feedback — the human's job shifted from coding to teaching values. -->

---

## เริ่มต้นใช้งานจริง: 4 ขั้นตอน

<p class="subhead">จากตรวจสอบ Auto Mode ไปจนถึงสั่งงานด้วย Dynamic Workflows</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="130" width="230" height="90" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="145" y="165" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Check version</text>
  <text x="145" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Enable Auto Mode</text>
  <path d="M260 175 L290 175" stroke="var(--muted)" stroke-width="2" marker-end="url(#a6)"/>
  <rect x="290" y="130" width="230" height="90" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="405" y="165" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2. Audit prompts</text>
  <text x="405" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Ablation test old rules</text>
  <path d="M520 175 L550 175" stroke="var(--muted)" stroke-width="2" marker-end="url(#a6)"/>
  <rect x="550" y="130" width="230" height="90" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="665" y="165" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3. Use a workflow</text>
  <text x="665" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">High-level goal only</text>
  <path d="M780 175 L810 175" stroke="var(--muted)" stroke-width="2" marker-end="url(#a6)"/>
  <rect x="810" y="130" width="230" height="90" rx="10" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="925" y="165" font-size="13" font-weight="700" fill="var(--warning)" text-anchor="middle" font-family="system-ui">4. Watch for gaps</text>
  <text x="925" y="190" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">No auto-verify = human check</text>
  <defs><marker id="a6" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มจากลบก่อนเพิ่ม — ablation ก่อนเขียน instruction ใหม่ทับเข้าไป</div>

<!-- Speaker: Walk through the 4 steps in order; step 4 is the safety net for anything without automated verification. -->

---

## Caveats: Risk ไม่เท่ากับศูนย์

<p class="subhead">ตัวเลขสวยงามมาจากเงื่อนไขเฉพาะเจาะจง ไม่ใช่การรับประกันแบบไม่มีเงื่อนไข</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card danger compact">
    <p class="label">Risk</p>
    <h3>ไม่ใช่ศูนย์จริง</h3>
    <p>Anthropic เองยังระบุใน help doc ว่า risk ไม่เท่ากับศูนย์</p>
  </div>
  <div class="card warning compact">
    <p class="label">Condition</p>
    <h3>ต้องเปิด Auto Mode</h3>
    <p>ปิด safeguard เหลือ 3.70-4.30% ไม่ใช่ 0%</p>
  </div>
  <div class="card warning compact">
    <p class="label">Preview</p>
    <h3>Dynamic Workflows</h3>
    <p>ยังเป็น Research Preview พร้อม hard cap 16/1,000</p>
  </div>
  <div class="card compact">
    <p class="label">Trade-off</p>
    <h3>Token + Latency</h3>
    <p>Auto Mode เพิ่ม cost ต่อ tool call ที่ถูกตรวจสอบ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุกตัวเลขมีเงื่อนไขกำกับ — อ่าน system card ก่อนเชื่อ ไม่ใช่แค่ headline</div>

<!-- Speaker: Don't let the 0% number get quoted without its conditions attached. -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้อ่านแค่สไลด์นี้สไลด์เดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Unhobble</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">then measure</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">0% attack</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">with Auto Mode</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">80% prompt</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">deleted</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">1,000</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">sub-agents</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Empirical</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">over dogma</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Unhobble โมเดลให้ทำงานเอง แล้ววัดผลจริงด้วยข้อมูล — ไม่ใช่ยึดทฤษฎีหรือ scaffolding เก่า</div>
