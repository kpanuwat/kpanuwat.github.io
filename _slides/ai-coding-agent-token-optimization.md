---
marp: true
theme: default
paginate: true
title: "เทคนิคประหยัด Token สำหรับ AI Coding Agent"
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
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# เทคนิคประหยัด Token<br>สำหรับ AI Coding Agent

<p class="tag">7 วิธีลด Token 30–99% · ลดค่าใช้จ่าย · เพิ่มประสิทธิภาพ</p>

<!-- Speaker: 7 techniques ที่โจมตี token waste ทุกแหล่งพร้อมกัน — ตั้งแต่ session startup จนถึง terminal output -->

---

## Token หมดเร็วเพราะ 3 แหล่งนี้

<p class="subhead">วินิจฉัยก่อน รักษาถูกจุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Startup Waste</p>
    <h3>Skills / MCPs</h3>
    <p>ทุก skill definition โหลดเข้า context อัตโนมัติ ก่อนพิมพ์คำสั่งแรก — 25,000+ tokens หายก่อนเริ่มงาน</p>
  </div>
  <div class="card warning">
    <p class="label">Input Waste</p>
    <h3>File Reads ซ้ำซ้อน</h3>
    <p>AI อ่านไฟล์ raw แทนการ query structure — grep + read ใช้ 120,000 tokens สำหรับ call chain เดียว</p>
  </div>
  <div class="card">
    <p class="label">Output Waste</p>
    <h3>ภาษาฟุ่มเฟือย</h3>
    <p>"Let me explain what I am going to do..." — filler tokens ที่ไม่มีข้อมูล กิน 30–75% ของ output ทั้งหมด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แก้ Startup + Input + Output พร้อมกัน — ไม่ใช่ทีละอย่าง</div>

<!-- Speaker: Token หมดไม่ใช่แค่เพราะโค้ดซับซ้อน — มาจาก 3 แหล่งที่แก้ได้ทั้งหมด -->

---

## Startup: 25,000 Tokens ก่อนพิมพ์คำแรก

<p class="subhead">Token Optimizer วัดได้ว่า token หายไปที่ไหน — ก่อน fix ต้องรู้ก่อน</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-coding-agent-token-optimization-1.png" alt="Token waste breakdown dashboard showing startup token distribution across skills, CLAUDE.md, slash commands, and MCPs">
<figcaption>Source: NotebookLM · Token startup breakdown — 25k total, 36% from skills alone</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 82 skills ใช้ 9,000 tokens ทุก session — audit ก่อน prune</div>

<!-- Speaker: Token Optimizer plugin run 6 sub-agents ตรวจ skills/MCPs/CLAUDE.md พร้อมกัน สร้าง dashboard -->

---

## 7 เทคนิค: ภาพรวมและ Savings

<p class="subhead">จัดกลุ่มตาม waste category เลือกเริ่มจากจุดที่เจ็บปวดที่สุด</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-coding-agent-token-optimization-3.png" alt="7 token-saving techniques comparison matrix showing all 7 techniques, savings percentages, and difficulty levels">
<figcaption>Source: NotebookLM · Token-Saving Matrix — 7 techniques, savings %, difficulty</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTK + CLAUDE.md lean = quick wins Day 1; Code Graph = highest savings ceiling</div>

<!-- Speaker: เลือก technique ตาม pain: startup waste → Token Optimizer/prune; output → Caveman; navigation → Code Graph -->

---

## #1 Token Optimizer — Audit ก่อน Fix

<p class="subhead">คุณไม่สามารถแก้สิ่งที่ไม่รู้ว่าเป็นปัญหา</p>

<div class="infographic" style="align-items:stretch; flex-direction:column; gap:12px;">

| Source | Tokens | % ของ Startup |
|--------|--------|--------------|
| Skills (82 installed) | 9,000 | 36% |
| CLAUDE.md | 1,000 | 4% |
| Slash Commands | 750 | 3% |
| MCPs + Tools | 450 | 1.8% |
| **Total Startup** | **25,000** | — |

<div class="card warning">
  <p class="label">Caveat — One-Time Audit เท่านั้น</p>
  <h3>Token Optimizer ใช้ AI agents ทำงาน</h3>
  <p>ตัวเองก็เปลือง token — run เป็น one-time baseline แล้ว prune skills ด้วยตัวเอง ไม่ใช่ run ทุกวัน</p>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /plugin install token-optimizer → audit → prune unused skills → ประหยัดทันที</div>

<!-- Speaker: ติดตั้ง → รัน token optimizer → ดู dashboard → ลบ skills ที่ install ไว้แต่ไม่ได้ใช้จริง -->

---

## #2 Caveman Skill — ตัด Output Waste 30–40%

<p class="subhead">บังคับให้ Claude ตอบตรง ไม่มี narrative padding</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="470" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="20" width="470" height="50" rx="12" fill="var(--soft)" opacity=".9"/>
  <text x="265" y="52" font-size="15" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Without Caveman</text>
  <text x="60" y="100" font-size="12" fill="var(--ink-dim)" font-family="system-ui">"Great question! Let me explain what</text>
  <text x="60" y="122" font-size="12" fill="var(--ink-dim)" font-family="system-ui">I am going to do. I will walk you</text>
  <text x="60" y="144" font-size="12" fill="var(--ink-dim)" font-family="system-ui">through the concept step by step</text>
  <text x="60" y="166" font-size="12" fill="var(--ink-dim)" font-family="system-ui">so you can understand it fully..."</text>
  <rect x="60" y="198" width="360" height="34" rx="8" fill="var(--danger-wash)"/>
  <text x="240" y="220" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">~800 tokens — zero information</text>
  <rect x="600" y="20" width="470" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="600" y="20" width="470" height="50" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="835" y="52" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">/caveman (Active)</text>
  <text x="630" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">"Context summary: stored in</text>
  <text x="630" y="122" font-size="12" fill="var(--ink)" font-family="system-ui">memory.json, updated per /compact</text>
  <text x="630" y="144" font-size="12" fill="var(--ink)" font-family="system-ui">call, 3-key structure."</text>
  <rect x="630" y="198" width="360" height="34" rx="8" fill="var(--success-wash)"/>
  <text x="810" y="220" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">30-40% less output tokens</text>
  <text x="810" y="262" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">40s · 42 cents Opus 4.7 (real test)</text>
  <circle cx="550" cy="170" r="28" fill="var(--accent)"/>
  <text x="550" y="175" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /caveman ก่อนทุก technical query — 30–40% output reduction โดยไม่เสียข้อมูล</div>

<!-- Speaker: Creator claim 75% แต่ real-world 30–40% — ยังคุ้มมาก; ใช้: /caveman explain how X works -->

---

## #3 Intent Layers — แผนที่โปรเจกต์แบบ Token-Lean

<p class="subhead">แทนที่ AI จะอ่านไฟล์ blindly ให้ directory บอกตัวเองว่ามีอะไร</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="380" y="10" width="340" height="52" rx="10" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="550" y="41" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">project/</text>
  <line x1="180" y1="62" x2="180" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="62" x2="550" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="920" y1="62" x2="920" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="180" y1="90" x2="920" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="90" width="280" height="52" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="180" y="121" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">backend/ (42k tokens)</text>
  <rect x="390" y="90" width="320" height="52" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="121" font-size="13" font-weight="600" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">frontend/ (18k tokens)</text>
  <rect x="780" y="90" width="280" height="52" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="920" y="121" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">infra/ (31k tokens)</text>
  <line x1="180" y1="142" x2="180" y2="178" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="80" y="178" width="200" height="42" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="180" y="204" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CLAUDE.md injected</text>
  <line x1="920" y1="142" x2="920" y2="178" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="820" y="178" width="200" height="42" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="920" y="204" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CLAUDE.md injected</text>
  <line x1="550" y1="142" x2="550" y2="178" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="450" y="178" width="200" height="42" rx="8" fill="var(--soft-2)"/>
  <text x="550" y="204" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">skip (under 20k)</text>
  <rect x="250" y="252" width="600" height="44" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="279" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">-29% runtime · -17% output tokens (arXiv 2602.20478)</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /intent layer → auto-place AGENTS.md ใน dirs ใหญ่ → AI ไม่ต้องอ่านไฟล์ blindly</div>

<!-- Speaker: /intent layer scan directories → วาง CLAUDE.md ใน dirs >20k tokens → อธิบาย architecture + anti-patterns -->

---

## #4 Handoff — Reset Session ก่อน Context เต็ม

<p class="subhead">อย่ารอให้ token หมด สรุปก่อน เริ่มใหม่พร้อม context</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="80" width="210" height="100" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="125" y="125" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Session</text>
  <text x="125" y="148" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">25-30% full</text>
  <polygon points="248,125 268,130 248,135" fill="var(--muted)"/>
  <line x1="230" y1="130" x2="248" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="272" y="80" width="210" height="100" rx="12" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="377" y="125" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">/handoff</text>
  <text x="377" y="148" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">summarize work</text>
  <polygon points="498,125 518,130 498,135" fill="var(--muted)"/>
  <line x1="482" y1="130" x2="498" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="522" y="80" width="210" height="100" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="627" y="118" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Summary</text>
  <text x="627" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">&lt;300 words</text>
  <text x="627" y="162" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">clear session</text>
  <polygon points="748,125 768,130 748,135" fill="var(--muted)"/>
  <line x1="732" y1="130" x2="748" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="772" y="80" width="210" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="877" y="118" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">New Session</text>
  <text x="877" y="140" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">paste summary</text>
  <text x="877" y="162" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">continue work</text>
  <rect x="300" y="210" width="500" height="40" rx="8" fill="var(--soft-2)"/>
  <text x="550" y="235" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">20-86% reduction vs full context carry-forward</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /handoff ก่อน context เต็ม — 300 คำพา context ไปต่อ session ใหม่ได้ทันที</div>

<!-- Speaker: /handoff สร้าง <300 word summary → clear session → paste เข้า session ใหม่ → ลด overhead 20-86% -->

---

## #5 CLAUDE.md กระชับ — ทุกบรรทัดคือ Recurring Cost

<p class="subhead">CLAUDE.md inject ทุก session — ยาวเกินไปคือ tax ที่จ่ายซ้ำตลอด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">ใส่ใน CLAUDE.md</p>
    <h3>Non-obvious constraints</h3>
    <ul>
      <li>Framework version เฉพาะ (ถ้า conflict กับ default)</li>
      <li>Architectural map กระชับ 1–3 บรรทัด</li>
      <li>Project motivation 1 บรรทัด</li>
      <li>Tooling paths ที่หาเองยากหรือ non-standard</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">ห้ามใส่</p>
    <h3>Obvious / Derivable rules</h3>
    <ul>
      <li>"Write clean code" — AI รู้อยู่แล้ว</li>
      <li>File-by-file descriptions</li>
      <li>Background story ยาว</li>
      <li>Commands ที่ Google ได้ใน 10 วินาที</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เป้าหมาย &lt;300 บรรทัด — ทุกบรรทัดที่ตัดได้คือ recurring token saving ทุก session</div>

<!-- Speaker: Anthropic แนะนำ <200 lines; ใช้ Token Optimizer หลัง prune เพื่อวัด improvement จริง -->

---

## #6 Code Graphs — 120x Token Reduction สำหรับ Navigation

<p class="subhead">CodeGraph แทน grep + read — ตอบ structural queries ใน ~200 tokens แทน 120,000</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="480" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="20" y="20" width="480" height="50" rx="12" fill="var(--soft)"/>
  <text x="260" y="52" font-size="15" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Traditional: grep + read</text>
  <text x="50" y="100" font-size="12" fill="var(--ink-dim)" font-family="system-ui">grep -r "functionName" . (scans ALL files)</text>
  <text x="50" y="128" font-size="12" fill="var(--ink-dim)" font-family="system-ui">cat src/api/handler.ts (full file, 2k tokens)</text>
  <text x="50" y="156" font-size="12" fill="var(--muted)" font-family="system-ui">cat src/services/*.ts ... (repeat N times)</text>
  <rect x="50" y="186" width="390" height="52" rx="8" fill="var(--danger-wash)"/>
  <text x="245" y="208" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">120,000 tokens per call chain</text>
  <text x="245" y="228" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">multiple tool calls · slow · expensive</text>
  <circle cx="550" cy="150" r="30" fill="var(--accent)"/>
  <text x="550" y="155" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="600" y="20" width="480" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="600" y="20" width="480" height="50" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="840" y="52" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CodeGraph MCP</text>
  <text x="630" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">codegraph_trace("functionName")</text>
  <text x="630" y="128" font-size="12" fill="var(--ink-dim)" font-family="system-ui">→ call chain in structured JSON</text>
  <text x="630" y="156" font-size="12" fill="var(--muted)" font-family="system-ui">SQLite-backed · &lt;1ms response time</text>
  <rect x="630" y="186" width="420" height="52" rx="8" fill="var(--success-wash)"/>
  <text x="840" y="208" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">~800 tokens · 99.2% reduction (120x)</text>
  <text x="840" y="228" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">-71% tool calls · -35% cost per query</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> codegraph init ครั้งเดียว → AI navigate codebase ด้วย token ต่ำกว่า 100x</div>

<!-- Speaker: codegraph init → index ด้วย tree-sitter AST → เพิ่ม MCP server → AI ใช้ codegraph_search แทน grep -->

---

## #7 RTK Proxy — 89% ของ Terminal Noise หายไป

<p class="subhead">CLI proxy กรอง compress deduplicate output ก่อนส่งให้ AI — zero workflow change</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/ai-coding-agent-token-optimization-2.png" alt="RTK proxy flow diagram: terminal command intercepted, filtered, compressed, delivered to AI. Before: 210k tokens. After: 23k tokens.">
<figcaption>Source: NotebookLM · RTK: 210k → 23k tokens ต่อ session 2 ชั่วโมง · git ops -92% · cargo test -91.8%</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> brew install rtk → ทำงาน auto ผ่าน PreToolUse hook — 89% savings ไม่ต้องเปลี่ยน workflow</div>

<!-- Speaker: RTK hook rewrite bash commands อัตโนมัติ — ไม่ต้องเปลี่ยนวิธีทำงาน; rtk gain ดู cumulative savings -->

---

## Caveats & Gotchas

<p class="subhead">ทุกเทคนิคมีขอบเขต รู้ก่อน deploy</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Token Optimizer</p>
    <h3>One-Time Only</h3>
    <p>ใช้ AI agents ทำ audit = เปลือง token; run เป็น one-time baseline ไม่ใช่ daily habit</p>
  </div>
  <div class="card warning">
    <p class="label">Code Graph</p>
    <h3>Re-index Overhead</h3>
    <p>ถ้า codebase เปลี่ยนบ่อย ต้อง re-index — โปรเจกต์ที่ evolve เร็วอาจไม่คุ้มต้นทุน maintenance</p>
  </div>
  <div class="card warning">
    <p class="label">RTK</p>
    <h3>Terminal Only</h3>
    <p>ช่วยแค่ terminal output — ไม่ลด prompt ที่ยาว หรือ file reads ที่ไม่จำเป็น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Full stack (Caveman + RTK + Code Graph) ประหยัด 85–92% แต่ setup ~3–4 ชั่วโมง</div>

<!-- Speaker: เริ่มจาก RTK (30 นาที) → ผลทันที; Code Graph สำหรับโปรเจกต์ขนาดใหญ่ที่ codebase stable -->

---

## Key Takeaways: 7 เทคนิค 3 หมวด

<p class="subhead">เลือกตาม pain point — เริ่มจาก ROI สูงสุดก่อน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Audit First</p>
    <h3>วัดก่อน Fix</h3>
    <p><b>Token Optimizer</b> — รู้ว่า token หายไปที่ไหน ก่อนเลือก technique</p>
    <p style="margin-top:8px;font-size:11px;color:var(--muted)">One-time · essential baseline</p>
  </div>
  <div class="card success">
    <p class="label">Quick Wins (Day 1)</p>
    <h3>ROI สูง Setup ต่ำ</h3>
    <ul>
      <li><b>RTK</b> — 89% terminal savings</li>
      <li><b>CLAUDE.md</b> — prune ทุกบรรทัด</li>
      <li><b>Caveman</b> — 30–40% output cut</li>
      <li><b>Handoff</b> — prevent overflow</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Deep Optimization</p>
    <h3>Ceiling สูง Setup มาก</h3>
    <ul>
      <li><b>Code Graph</b> — 120x nav savings</li>
      <li><b>Intent Layers</b> — -29% runtime</li>
    </ul>
    <p style="margin-top:8px;font-size:11px;color:var(--muted)">Best for large stable codebases</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTK + CLAUDE.md lean + Caveman วันแรก → 60–70% savings ก่อนทำอะไรซับซ้อน</div>

<!-- Speaker: ไม่ต้องทำทีเดียว — RTK 30 นาที, CLAUDE.md prune 1 ชั่วโมง, Code Graph เมื่อ project stable -->
