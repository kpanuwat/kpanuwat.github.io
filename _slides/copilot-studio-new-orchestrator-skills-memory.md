---
marp: true
theme: default
paginate: true
title: "Copilot Studio ใหม่: Orchestrator, Skills, Memory และ MCP Servers"
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

![bg opacity:.25](assets/copilot-studio-new-orchestrator-skills-memory-cover.png)

<div class="mark"></div>

# Copilot Studio ใหม่

<p class="tag">Orchestrator · Skills · Memory · MCP Servers — สิ่งที่เปลี่ยนและสิ่งที่ถูกถอดออก</p>

<!-- Speaker: Copilot Studio rebuild ครั้งใหญ่ — จาก chatbot builder → enterprise automation platform -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/copilot-studio-new-orchestrator-skills-memory-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้ง deck ใน 60 วินาที — จดจุดสำคัญก่อนเข้า deep dive -->

---

## Copilot Studio 2026: ปรับใหญ่จาก Chatbot สู่ Agentic Platform

<p class="subhead">จาก Topics/Triggers → Generative Orchestrator — ทั้ง runtime และ UX เปลี่ยนหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="280" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="280" rx="4" fill="var(--accent)"/>
  <!-- Icon circle -->
  <circle cx="148" cy="180" r="44" fill="var(--accent)" opacity=".1"/>
  <circle cx="148" cy="180" r="30" fill="var(--accent)"/>
  <text x="148" y="186" font-size="16" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">NEW</text>
  <!-- Key message -->
  <text x="220" y="152" font-size="22" font-weight="700" fill="var(--ink)" font-family="system-ui">Rebuilt for complex, multi-step agentic work</text>
  <text x="220" y="185" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Generative orchestrator · Python/Node/Bash · Skills (.md) · Memory · MCP</text>
  <text x="220" y="218" font-size="14" fill="var(--muted)" font-family="system-ui">Topics / Triggers / Inline child agents removed — replaced by Workflows + Standalone Agents</text>
  <!-- Perf badges -->
  <rect x="220" y="240" width="160" height="36" rx="8" fill="var(--success-wash)"/>
  <text x="300" y="263" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+20% eval perf</text>
  <rect x="396" y="240" width="160" height="36" rx="8" fill="var(--accent-wash)"/>
  <text x="476" y="263" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">-50% token usage</text>
  <rect x="572" y="240" width="160" height="36" rx="8" fill="var(--warning-wash)"/>
  <text x="652" y="263" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">4-tab workflow UI</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Copilot Studio ไม่ใช่ chatbot builder อีกต่อไป — มันคือ agentic automation platform ที่ orchestrate งานซับซ้อนได้เอง</div>

<!-- Speaker: นี่คือสรุปสั้นๆ ก่อนเข้า slide ต่อไป -->

---

## Why Rebuild: Deterministic Flow Hits a Wall

![bg right:40% contain](assets/copilot-studio-new-orchestrator-skills-memory-background.png)

<p class="subhead">Topics/Triggers ทำงานได้ดีกับ FAQ bot — แต่พัง เมื่อ workload ซับซ้อนขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Old model -->
  <rect x="20" y="20" width="300" height="280" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5" opacity=".6"/>
  <text x="170" y="50" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Old: Topic Tree</text>
  <rect x="60" y="68" width="220" height="32" rx="6" fill="var(--danger)" opacity=".15"/>
  <text x="170" y="89" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">keyword match → trigger</text>
  <rect x="60" y="112" width="220" height="32" rx="6" fill="var(--danger)" opacity=".15"/>
  <text x="170" y="133" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">hardcoded topic flow</text>
  <rect x="60" y="156" width="220" height="32" rx="6" fill="var(--danger)" opacity=".15"/>
  <text x="170" y="177" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">breaks if user goes off-script</text>
  <rect x="60" y="200" width="220" height="32" rx="6" fill="var(--danger)" opacity=".15"/>
  <text x="170" y="221" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">no multi-step orchestration</text>
  <!-- Arrow -->
  <text x="340" y="168" font-size="22" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700">→</text>
  <!-- New model -->
  <rect x="370" y="20" width="300" height="280" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5" opacity=".6"/>
  <text x="520" y="50" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">New: Generative Orchestrator</text>
  <rect x="410" y="68" width="220" height="32" rx="6" fill="var(--success)" opacity=".15"/>
  <text x="520" y="89" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">intent → dynamic routing</text>
  <rect x="410" y="112" width="220" height="32" rx="6" fill="var(--success)" opacity=".15"/>
  <text x="520" y="133" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Skills + MCP + Memory</text>
  <rect x="410" y="156" width="220" height="32" rx="6" fill="var(--success)" opacity=".15"/>
  <text x="520" y="177" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">handles off-script gracefully</text>
  <rect x="410" y="200" width="220" height="32" rx="6" fill="var(--success)" opacity=".15"/>
  <text x="520" y="221" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">multi-step, multi-tool work</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> โมเดลเดิมพังเมื่อ user ไม่ทำตาม script — generative orchestrator ออกแบบมาเพื่อรับมือกับ unpredictability</div>

<!-- Speaker: Root cause ของการ rebuild — Topics เป็น fragile glue code ไม่ใช่ real AI -->

---

## 4 Modes: Build → Preview → Evaluate → Monitor

<p class="subhead">UI ปรับเป็น 4-tab SDLC workflow — แต่ละ mode มีบทบาทชัดเจน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1: Build -->
  <rect x="30" y="60" width="220" height="220" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="140" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="140" cy="120" r="24" fill="var(--accent)"/>
  <text x="140" y="126" font-size="14" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">1</text>
  <text x="140" y="176" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">BUILD</text>
  <text x="140" y="198" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Skills + MCP</text>
  <text x="140" y="216" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Memory + Instructions</text>
  <text x="140" y="254" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Create agent</text>
  <!-- Arrow 1→2 -->
  <path d="M258 170 L290 170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <defs><marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/></marker></defs>
  <!-- Step 2: Preview -->
  <rect x="298" y="60" width="220" height="220" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="408" cy="120" r="36" fill="var(--gold)" opacity=".12"/>
  <circle cx="408" cy="120" r="24" fill="var(--gold)"/>
  <text x="408" y="126" font-size="14" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">2</text>
  <text x="408" y="176" font-size="16" font-weight="700" fill="var(--gold)" text-anchor="middle" font-family="system-ui">PREVIEW</text>
  <text x="408" y="198" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Interactive test</text>
  <text x="408" y="216" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Reasoning trace</text>
  <text x="408" y="254" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Test before deploy</text>
  <!-- Arrow 2→3 -->
  <path d="M526 170 L558 170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Step 3: Evaluate -->
  <rect x="566" y="60" width="220" height="220" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="676" cy="120" r="36" fill="var(--success)" opacity=".12"/>
  <circle cx="676" cy="120" r="24" fill="var(--success)"/>
  <text x="676" y="126" font-size="14" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">3</text>
  <text x="676" y="176" font-size="16" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">EVALUATE</text>
  <text x="676" y="198" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Custom metrics</text>
  <text x="676" y="216" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Resolution rate, accuracy</text>
  <text x="676" y="254" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Measure outcomes</text>
  <!-- Arrow 3→4 -->
  <path d="M794 170 L826 170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Step 4: Monitor -->
  <rect x="834" y="60" width="220" height="220" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="944" cy="120" r="36" fill="var(--danger)" opacity=".12"/>
  <circle cx="944" cy="120" r="24" fill="var(--danger)"/>
  <text x="944" y="126" font-size="14" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">4</text>
  <text x="944" y="176" font-size="16" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">MONITOR</text>
  <text x="944" y="198" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Prod logs + errors</text>
  <text x="944" y="216" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Token usage + health</text>
  <text x="944" y="254" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Observe production</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> สี่ mode ครอบคลุม full SDLC ของ agent — ไม่ใช่แค่ build แล้วปล่อยให้วิ่งเอง</div>

<!-- Speaker: Pattern นี้ทำให้ enterprise team มี governance process รอบ agent ได้ชัดเจน -->

---

## Orchestrator: Python, Node.js, Bash ใน Runtime

![bg right:40% contain](assets/copilot-studio-new-orchestrator-skills-memory-orchestrator.png)

<p class="subhead">Generative orchestrator เลือก tool เองตาม intent — รันโค้ดได้โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Center node -->
  <circle cx="340" cy="150" r="50" fill="var(--accent)" opacity=".1"/>
  <circle cx="340" cy="150" r="34" fill="var(--accent)"/>
  <text x="340" y="145" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">Orchestrator</text>
  <text x="340" y="162" font-size="10" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">generative</text>
  <!-- Python -->
  <rect x="20" y="40" width="160" height="56" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="100" y="62" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Python</text>
  <text x="100" y="82" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">data analysis · Excel/PDF</text>
  <path d="M180 68 L290 130" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <!-- Node.js -->
  <rect x="20" y="204" width="160" height="56" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="100" y="226" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Node.js</text>
  <text x="100" y="246" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">API calls · transforms</text>
  <path d="M180 232 L290 170" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <!-- Bash -->
  <rect x="540" y="122" width="150" height="56" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="615" y="144" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Bash</text>
  <text x="615" y="164" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">shell · file ops</text>
  <path d="M390 150 L540 150" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <!-- Perf -->
  <rect x="440" y="40" width="240" height="52" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="560" y="60" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">+20% eval · -50% tokens</text>
  <text x="560" y="80" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">vs. previous orchestrator</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent รับ CSV → วิเคราะห์ Python → สร้าง Excel → ส่ง reply ได้ใน Copilot Studio ไม่ต้องออกไป Power Automate</div>

<!-- Speaker: นี่คือ killer feature — รัน code ได้ใน runtime โดยตรง -->

---

## Skills: .md Files Generated from Prompts

<p class="subhead">แทน Topics ด้วย reusable instruction sets — เขียนเป็น Markdown สร้างจาก natural language ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Old: Topics -->
  <rect x="30" y="20" width="480" height="320" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="48" rx="12" fill="var(--danger)" opacity=".15"/>
  <text x="270" y="50" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Topics (Old) — Keyword-Triggered</text>
  <rect x="60" y="82" width="420" height="32" rx="6" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="103" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">trigger: "analyze" | "data" | "report"</text>
  <rect x="60" y="126" width="420" height="80" rx="6" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">step 1: ask for file</text>
  <text x="270" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">step 2: send to Power Automate</text>
  <text x="270" y="190" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">step 3: return fixed message</text>
  <text x="270" y="242" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">brittle · no reuse · hard to maintain</text>
  <rect x="60" y="260" width="420" height="60" rx="6" fill="var(--danger)" opacity=".07"/>
  <text x="270" y="285" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">breaks when user goes off-script</text>
  <text x="270" y="305" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">must maintain keyword lists manually</text>
  <!-- Arrow -->
  <text x="542" y="200" font-size="26" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700">→</text>
  <!-- New: Skills -->
  <rect x="590" y="20" width="480" height="320" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <rect x="590" y="20" width="480" height="48" rx="12" fill="var(--success)" opacity=".15"/>
  <text x="830" y="50" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Skills (.md) — Context-Aware</text>
  <rect x="620" y="82" width="420" height="128" rx="6" fill="white" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="640" y="106" font-size="11" fill="var(--muted)" font-family="monospace">## Analyze Sales Data</text>
  <text x="640" y="126" font-size="11" fill="var(--ink-dim)" font-family="monospace">When user asks to analyze data:</text>
  <text x="640" y="146" font-size="11" fill="var(--ink-dim)" font-family="monospace">1. Request file or connection</text>
  <text x="640" y="166" font-size="11" fill="var(--ink-dim)" font-family="monospace">2. Run Python: totals, trends</text>
  <text x="640" y="186" font-size="11" fill="var(--ink-dim)" font-family="monospace">3. Offer Excel or PDF export</text>
  <text x="830" y="242" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">reusable · no keywords · context-driven</text>
  <rect x="620" y="260" width="420" height="60" rx="6" fill="var(--success)" opacity=".07"/>
  <text x="830" y="285" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">generate from prompt in Build mode</text>
  <text x="830" y="305" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">orchestrator selects by context, not keyword</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Skills ไม่ต้องการ trigger keyword — orchestrator เลือกเรียกตาม intent ทำให้ agent เข้าใจ off-script requests ได้</div>

<!-- Speaker: Non-developer สามารถสร้าง Skill โดยพิมพ์ describe what you want → Copilot Studio generates the .md -->

---

## Memory: Cross-Session Context Storage

![bg right:40% contain](assets/copilot-studio-new-orchestrator-skills-memory-memory.png)

<p class="subhead">Agent จำ user preferences และ project context ข้ามเซสชัน — ผ่าน Work IQ API</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Session memory -->
  <rect x="20" y="30" width="300" height="110" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 8px rgba(15,23,42,.08))"/>
  <rect x="20" y="30" width="300" height="36" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="170" y="54" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Session Memory</text>
  <text x="50" y="88" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Context window — current convo</text>
  <text x="50" y="110" font-size="12" fill="var(--muted)" font-family="system-ui">Cleared on session end</text>
  <!-- Persistent memory -->
  <rect x="20" y="158" width="300" height="110" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 4px 8px rgba(15,23,42,.08))"/>
  <rect x="20" y="158" width="300" height="36" rx="12" fill="var(--gold)" opacity=".1"/>
  <text x="170" y="182" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Persistent Memory</text>
  <text x="50" y="216" font-size="12" fill="var(--ink-dim)" font-family="system-ui">User prefs · project context</text>
  <text x="50" y="238" font-size="12" fill="var(--muted)" font-family="system-ui">Work IQ API — public preview</text>
  <!-- Arrow to API -->
  <path d="M330 150 L430 150" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <defs><marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/></marker></defs>
  <rect x="438" y="110" width="230" height="80" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="553" y="140" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Work IQ API</text>
  <text x="553" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">public preview · REST</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent จำได้ว่า user ชอบ format Excel ไม่ใช่ PDF — ไม่ต้องถามซ้ำทุก session</div>

<!-- Speaker: Work IQ API ยังอยู่ใน public preview — schema อาจเปลี่ยน ควร monitor -->

---

## MCP Servers vs Traditional Connectors

<p class="subhead">Open standard แทน Microsoft-specific connectors — dynamic, cross-platform, no certification required</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Traditional Connector -->
  <rect x="30" y="20" width="470" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="20" width="470" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="265" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Traditional Connector</text>
  <text x="60" y="100" font-size="13" fill="var(--ink)" font-family="system-ui">Microsoft-specific format</text>
  <text x="60" y="130" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Manual publish / certification</text>
  <text x="60" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Actions only (no Resources/Prompts)</text>
  <text x="60" y="190" font-size="13" fill="var(--muted)" font-family="system-ui">Update requires republish cycle</text>
  <text x="60" y="220" font-size="13" fill="var(--muted)" font-family="system-ui">Locked to Power Platform ecosystem</text>
  <rect x="60" y="250" width="400" height="64" rx="8" fill="var(--danger-wash)"/>
  <text x="260" y="276" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">fragile when external API changes</text>
  <text x="260" y="298" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">can't reuse across platforms</text>
  <!-- VS badge -->
  <circle cx="550" cy="190" r="30" fill="var(--accent)"/>
  <text x="550" y="196" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- MCP Server -->
  <rect x="600" y="20" width="470" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="600" y="20" width="470" height="52" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="835" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">MCP Server</text>
  <text x="630" y="100" font-size="13" fill="var(--ink)" font-family="system-ui">Open standard (cross-platform)</text>
  <text x="630" y="130" font-size="13" fill="var(--ink)" font-family="system-ui">No certification needed</text>
  <text x="630" y="160" font-size="13" fill="var(--ink)" font-family="system-ui">Resources + Tools + Prompts</text>
  <text x="630" y="190" font-size="13" fill="var(--ink)" font-family="system-ui">Dynamic — agent reflects changes auto</text>
  <text x="630" y="220" font-size="13" fill="var(--ink)" font-family="system-ui">Reuse across any MCP-compatible platform</text>
  <rect x="630" y="250" width="400" height="64" rx="8" fill="var(--success-wash)"/>
  <text x="830" y="276" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">requires Generative Orchestration ON</text>
  <text x="830" y="298" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">one server → multiple tools + resources</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> MCP เป็น open standard — ลงทุนสร้าง MCP server ครั้งเดียว ใช้ได้ข้าม platform ไม่ต้อง vendor lock-in</div>

<!-- Speaker: ต้องเปิด Generative Orchestration ก่อนถึงจะใช้ MCP ได้ -->

---

## สิ่งที่ถูกถอดออก: Topics, Triggers, Inline Child Agents

<p class="subhead">Deterministic features ถูกแทนที่ด้วย generative equivalents — ไม่มี auto-migration</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Removed</p>
    <h3>Topics</h3>
    <p>Deterministic conversation flow ที่ต้องกำหนด keyword triggers และ step ทุกอย่างล่วงหน้า</p>
    <p style="color:var(--success-ink);margin-top:8px;font-size:12px">แทนด้วย: <b>Skills (.md)</b> + Generative Orchestrator</p>
  </div>
  <div class="card danger">
    <p class="label">Removed</p>
    <h3>Triggers</h3>
    <p>Keyword matching rules ที่ brittle และต้อง maintain รายการ keywords ด้วยมือตลอดเวลา</p>
    <p style="color:var(--success-ink);margin-top:8px;font-size:12px">แทนด้วย: <b>Orchestrator</b> เข้าใจ intent เอง</p>
  </div>
  <div class="card danger">
    <p class="label">Removed</p>
    <h3>Inline Child Agents</h3>
    <p>Sub-agents แบบ tightly coupled ที่ reuse ข้าม project ไม่ได้ และยาก maintain</p>
    <p style="color:var(--success-ink);margin-top:8px;font-size:12px">แทนด้วย: <b>Standalone Agents</b> + Workflows</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Bot เดิมที่ใช้ Topics ต้อง rewrite เป็น Skills — ไม่มี auto-migration tool ณ ปัจจุบัน นี่คือ migration cost ที่ต้องวางแผน</div>

<!-- Speaker: สำหรับ team ที่มี bot เดิม นี่คือ breaking change ที่ใหญ่ที่สุด -->

---

## Workflows & Standalone Agents

<p class="subhead">Visual designer ใหม่ + decoupled agents ที่ reuse ข้าม project ได้ผ่าน A2A protocol</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Workflow box -->
  <rect x="30" y="30" width="500" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="30" y="30" width="500" height="48" rx="14" fill="var(--accent)" opacity=".08"/>
  <text x="280" y="60" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Workflows</text>
  <!-- Flow items -->
  <rect x="60" y="96" width="380" height="32" rx="6" fill="var(--soft)"/>
  <text x="250" y="117" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Agent node (user request)</text>
  <path d="M250 128 L250 142" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="60" y="142" width="380" height="32" rx="6" fill="var(--soft)"/>
  <text x="250" y="163" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">API call + business logic</text>
  <path d="M250 174 L250 188" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="60" y="188" width="380" height="32" rx="6" fill="var(--soft)"/>
  <text x="250" y="209" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Approval gate</text>
  <path d="M250 220 L250 234" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="60" y="234" width="380" height="32" rx="6" fill="var(--accent-wash)"/>
  <text x="250" y="255" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Output (standalone or agent-triggered)</text>
  <!-- A2A bridge -->
  <path d="M550 170 L590 170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <defs><marker id="a3" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/></marker></defs>
  <text x="570" y="158" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">A2A (GA)</text>
  <!-- Standalone agents -->
  <rect x="598" y="30" width="470" height="280" rx="14" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="598" y="30" width="470" height="48" rx="14" fill="var(--gold)" opacity=".1"/>
  <text x="833" y="60" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Standalone Agents</text>
  <rect x="628" y="96" width="410" height="60" rx="8" fill="var(--soft)"/>
  <text x="833" y="120" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Agent A: Data Analyzer</text>
  <text x="833" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">deployed independently, reusable</text>
  <rect x="628" y="170" width="410" height="60" rx="8" fill="var(--soft)"/>
  <text x="833" y="194" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Agent B: Report Generator</text>
  <text x="833" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">reuse across multiple workflows</text>
  <rect x="628" y="244" width="410" height="44" rx="8" fill="var(--gold)" opacity=".1"/>
  <text x="833" y="271" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">called via Agent-to-Agent (A2A) — GA</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Standalone agents deploy ครั้งเดียว reuse ได้หลาย workflow — A2A protocol ที่ GA แล้วทำให้ agent คุยกันได้โดยตรง</div>

<!-- Speaker: แทน inline child agents ที่ tightly coupled ด้วย standalone ที่ modular และ reusable -->

---

## User Guide: สร้าง Agent ใหม่ใน Copilot Studio

<p class="subhead">6 ขั้นตอนจาก Build mode ไปถึง production monitoring</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="a4" markerWidth="7" markerHeight="7" refX="5" refY="3" orient="auto"><path d="M0,0 L0,6 L7,3 z" fill="var(--muted)"/></marker></defs>
  <!-- Step boxes: 3 top row, 3 bottom row -->
  <!-- Row 1 -->
  <rect x="20" y="20" width="300" height="120" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="70" cy="60" r="20" fill="var(--accent)"/>
  <text x="70" y="66" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">1</text>
  <text x="110" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">New Agent (Build)</text>
  <text x="40" y="96" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Name + model + turn on</text>
  <text x="40" y="112" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Generative Orchestration</text>
  <path d="M322 80 L368 80" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="376" y="20" width="300" height="120" rx="10" fill="var(--paper)" stroke="var(--gold)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="426" cy="60" r="20" fill="var(--gold)"/>
  <text x="426" y="66" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">2</text>
  <text x="466" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Add Skills</text>
  <text x="396" y="96" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Describe → Copilot generates</text>
  <text x="396" y="112" font-size="11" fill="var(--ink-dim)" font-family="system-ui">.md file → review + save</text>
  <path d="M678 80 L724 80" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="732" y="20" width="340" height="120" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="784" cy="60" r="20" fill="var(--success)"/>
  <text x="784" y="66" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">3</text>
  <text x="820" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Connect MCP Server</text>
  <text x="752" y="96" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Tools → Add MCP → endpoint URL</text>
  <text x="752" y="112" font-size="11" fill="var(--ink-dim)" font-family="system-ui">select Tools + Resources</text>
  <!-- Row 2 -->
  <path d="M570 142 L570 174" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="732" y="182" width="340" height="120" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="784" cy="222" r="20" fill="var(--accent)" opacity=".7"/>
  <text x="784" y="228" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">4</text>
  <text x="820" y="214" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Set Memory</text>
  <text x="752" y="258" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Memory panel → Persistent/Session</text>
  <text x="752" y="274" font-size="11" fill="var(--ink-dim)" font-family="system-ui">define memory keys to retain</text>
  <path d="M730 242 L686 242" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="376" y="182" width="300" height="120" rx="10" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="426" cy="222" r="20" fill="var(--warning)"/>
  <text x="426" y="228" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">5</text>
  <text x="466" y="214" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Test in Preview</text>
  <text x="396" y="258" font-size="11" fill="var(--ink-dim)" font-family="system-ui">type prompt → reasoning trace</text>
  <text x="396" y="274" font-size="11" fill="var(--ink-dim)" font-family="system-ui">verify memory read/write</text>
  <path d="M374 242 L330 242" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a4)"/>
  <rect x="20" y="182" width="300" height="120" rx="10" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="70" cy="222" r="20" fill="var(--danger)"/>
  <text x="70" y="228" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">6</text>
  <text x="110" y="214" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Deploy + Monitor</text>
  <text x="40" y="258" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Publish → Monitor tab</text>
  <text x="40" y="274" font-size="11" fill="var(--ink-dim)" font-family="system-ui">set alerts on error rate + tokens</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Enable Generative Orchestration ตั้งแต่ step 1 — ถ้าปิดไว้ MCP และ Skills จะไม่ทำงาน</div>

<!-- Speaker: Step 1 มี prerequisite ที่คนมักลืม — Generative Orchestration ต้องเปิดก่อน -->

---

## Caveats & Limits

<p class="subhead">สิ่งที่ต้องรู้ก่อน migrate หรือ deploy ไปยัง production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Migration</p>
    <h3>No Auto-Migration</h3>
    <p>Bot เดิมที่ใช้ Topics ต้อง rewrite เป็น Skills ด้วยมือ — ไม่มี automated migration tool ณ ปัจจุบัน</p>
  </div>
  <div class="card warning">
    <p class="label">Preview Features</p>
    <h3>Work IQ API (Preview)</h3>
    <p>Persistent memory ยังอยู่ใน public preview — schema อาจเปลี่ยน และ Python/Node/Bash execution มี sandbox limits</p>
  </div>
  <div class="card warning">
    <p class="label">Cost Watch</p>
    <h3>Token Usage Shift</h3>
    <p>Generative orchestrator อาจใช้ token มากกว่า deterministic Topics สำหรับ simple tasks — ต้องตั้ง Monitor alerts</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Platform ใหม่ทรงพลังกว่าเดิม แต่ migration cost สูงและ preview features ยังไม่ stable — วางแผน gradual rollout</div>

<!-- Speaker: Computer-using agents GA แล้วบาง region แต่ไม่ครบทุกประเทศ — ตรวจสอบ region availability ก่อน deploy -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำจาก Copilot Studio ใหม่</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Concentric rings -->
  <circle cx="240" cy="160" r="150" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="240" cy="160" r="100" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".35"/>
  <circle cx="240" cy="160" r="52" fill="var(--accent)" opacity=".1"/>
  <circle cx="240" cy="160" r="52" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="240" y="154" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Generative</text>
  <text x="240" y="172" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Orchestrator</text>
  <text x="110" y="88" font-size="12" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Skills</text>
  <text x="110" y="105" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">.md files</text>
  <text x="380" y="88" font-size="12" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Memory</text>
  <text x="380" y="105" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">cross-session</text>
  <text x="100" y="240" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">MCP</text>
  <text x="390" y="240" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Workflows</text>
  <!-- Takeaway bullets -->
  <rect x="430" y="20" width="640" height="280" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="460" y="56" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">4 Modes</text>
  <text x="600" y="56" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Build → Preview → Evaluate → Monitor</text>
  <text x="460" y="90" font-size="14" font-weight="700" fill="var(--success)" font-family="system-ui">Skills</text>
  <text x="600" y="90" font-size="13" fill="var(--ink-dim)" font-family="system-ui">.md · no keywords · context-driven</text>
  <text x="460" y="124" font-size="14" font-weight="700" fill="var(--gold)" font-family="system-ui">Memory</text>
  <text x="600" y="124" font-size="13" fill="var(--ink-dim)" font-family="system-ui">cross-session · Work IQ API (preview)</text>
  <text x="460" y="158" font-size="14" font-weight="700" fill="var(--warning)" font-family="system-ui">MCP</text>
  <text x="600" y="158" font-size="13" fill="var(--ink-dim)" font-family="system-ui">open standard · dynamic · no certification</text>
  <text x="460" y="192" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">Removed</text>
  <text x="600" y="192" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Topics · Triggers · Inline Child Agents</text>
  <text x="460" y="226" font-size="14" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">Python/Node</text>
  <text x="600" y="226" font-size="13" fill="var(--ink-dim)" font-family="system-ui">run code in orchestrator · Excel/PDF direct</text>
  <text x="460" y="260" font-size="14" font-weight="700" fill="var(--muted)" font-family="system-ui">Migrate</text>
  <text x="600" y="260" font-size="13" fill="var(--ink-dim)" font-family="system-ui">no auto-migration · plan Skills rewrite</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Copilot Studio 2026 = agentic runtime ไม่ใช่ chatbot builder — generative orchestrator คือ core ที่ทุก feature อื่นพึ่งพา</div>

<!-- Speaker: จบด้วยการเน้น migration — ทีมที่มี bot เดิมต้องวางแผน rewrite Topics → Skills ก่อน adopt -->
