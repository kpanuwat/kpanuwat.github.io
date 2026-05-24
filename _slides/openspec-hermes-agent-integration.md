---
marp: true
theme: default
paginate: true
title: "OpenSpec + Hermes Agent Swarm"
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

# OpenSpec + Hermes Agent Swarm

<p class="tag">Shared spec layer ที่ป้องกัน agent drift ใน multi-agent workflow</p>

<!-- Speaker: Post นี้เจาะว่า OpenSpec integrate กับ Hermes Swarm Mode ยังไง — ทำไมถึงสำคัญกว่า single-agent -->

---

## Agent Drift: ปัญหาที่คูณตัวเองใน Multi-Agent

<p class="subhead">ปัญหา vibe coding ในระดับ single-agent กลายเป็น agent drift เมื่อหลาย workers implement feature เดียวกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">ไม่มี OpenSpec</p>
    <h3>SwarmBrief: "add dark mode"</h3>
    <p><b>Builder:</b> CSS variables + ThemeContext</p>
    <p><b>Sidekick (parallel):</b> styled-components + different localStorage key</p>
    <p><b>ผล:</b> merge conflict, inconsistent implementation, Reviewer ไม่รู้ว่า approach ไหนถูก</p>
  </div>
  <div class="card success">
    <p class="label">มี OpenSpec</p>
    <h3>openspec/changes/add-dark-mode/tasks.md</h3>
    <p>ThemeContext + CSS variables + localStorage (defined once)</p>
    <p><b>Builder:</b> reads tasks.md → implements task 1-3</p>
    <p><b>Sidekick:</b> reads tasks.md → implements task 4-6</p>
    <p><b>ผล:</b> consistent, /opsx:verify passes, 0 drift</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Shared artifacts ใน git = shared source of truth สำหรับทุก agent — ป้องกัน drift ตั้งแต่ propose</div>

<!-- Speaker: ปัญหา agent drift คือเหตุผลหลักที่ OpenSpec จำเป็นใน swarm context -->

---

## Hermes Swarm Architecture: 12 Workers, 1 Shared Spec

<p class="subhead">Eric ตั้ง intent → Aurora แปลเป็น SwarmBrief → orchestrator routes → workers execute โดยอ้างถึง artifacts เดียวกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="ah" markerWidth="7" markerHeight="5" refX="7" refY="2.5" orient="auto"><polygon points="0 0,7 2.5,0 5" fill="var(--accent)"/></marker></defs>

  <!-- Eric -->
  <rect x="460" y="10" width="180" height="44" rx="10" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="37" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Eric (intent)</text>

  <line x1="550" y1="54" x2="550" y2="76" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#ah)"/>

  <!-- Aurora -->
  <rect x="400" y="76" width="300" height="44" rx="10" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <text x="550" y="103" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Aurora — /opsx:propose</text>

  <line x1="550" y1="120" x2="550" y2="142" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#ah)"/>

  <!-- Orchestrator -->
  <rect x="370" y="142" width="360" height="44" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="169" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">swarm3/Mirror — Orchestrator</text>

  <!-- Lines to workers -->
  <line x1="400" y1="186" x2="220" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah)"/>
  <line x1="460" y1="186" x2="400" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah)"/>
  <line x1="550" y1="186" x2="550" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah)"/>
  <line x1="630" y1="186" x2="700" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah)"/>
  <line x1="700" y1="186" x2="880" y2="220" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#ah)"/>

  <!-- Worker boxes -->
  <rect x="100" y="220" width="160" height="52" rx="8" fill="var(--paper)" stroke="var(--gold)" stroke-width="1.5"/>
  <text x="180" y="243" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Scribe (sw7)</text>
  <text x="180" y="261" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">propose + refine</text>

  <rect x="290" y="220" width="150" height="52" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="365" y="243" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Builder (sw5)</text>
  <text x="365" y="261" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/opsx:apply 1-3</text>

  <rect x="470" y="220" width="160" height="52" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="243" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sidekick (sw10)</text>
  <text x="550" y="261" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/opsx:apply 4-6</text>

  <rect x="650" y="220" width="160" height="52" rx="8" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="730" y="243" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Reviewer (sw6)</text>
  <text x="730" y="261" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/opsx:verify</text>

  <rect x="840" y="220" width="160" height="52" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="920" y="243" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sage (sw4)</text>
  <text x="920" y="261" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/opsx:explore</text>

  <!-- Shared artifacts label -->
  <rect x="200" y="295" width="700" height="32" rx="8" fill="var(--accent-wash)" opacity=".8"/>
  <text x="550" y="316" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ทุก worker อ่าน openspec/changes/&lt;id&gt;/ เดียวกัน — shared artifacts via git</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Orchestrator routes workers; OpenSpec artifacts คือ shared contract ที่ทุกคนอ่านก่อน execute</div>

<!-- Speaker: Key insight: Aurora เป็น propose agent, Scribe refine, Builder/Sidekick parallel, Reviewer verify -->

---

## OpenSpec Already Installed ใน Hermes Workspace

<p class="subhead">ไม่ต้อง setup ใหม่ — .claude/skills/ + openspec/ มีอยู่แล้ว; แค่เพิ่ม swarm-aware rules ใน config.yaml</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">.claude/skills/ — Aurora reads at session start</p>
    <h3>Skills ที่ Install แล้ว</h3>
    <ul>
      <li>openspec-propose/SKILL.md</li>
      <li>openspec-apply-change/SKILL.md</li>
      <li>openspec-archive-change/SKILL.md</li>
      <li>openspec-explore/SKILL.md</li>
      <li>opsx/ (core runtime)</li>
    </ul>
    <p style="margin-top:8px">Aurora + all workers อ่าน skills เหล่านี้ที่ session start</p>
  </div>
  <div class="card gold">
    <p class="label">openspec/config.yaml — inject ทุก /opsx:* command</p>
    <h3>Swarm-Aware Rules ที่ควรเพิ่ม</h3>
    <p><b>context:</b> Tech stack: React 19, Vite 7, Electron 40; Swarm Mode: persistent tmux workers</p>
    <p><b>rules.tasks:</b></p>
    <ul>
      <li>tasks &lt; 2h per chunk</li>
      <li>parallel-safe task partitioning</li>
      <li>Electron vs web-only labeling</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เพิ่ม swarm-aware rules ใน config.yaml — ให้ AI generate tasks ที่ parallel-safe และ assignable ทีละ worker</div>

<!-- Speaker: config.yaml ที่มีอยู่แล้วต้องเพิ่ม parallel task rules เพื่อให้ swarm ใช้ได้อย่างมีประสิทธิภาพ -->

---

## Worker Roles กับ OpenSpec Artifacts

<p class="subhead">แต่ละ worker ใน swarm มีบทบาทเฉพาะกับ OpenSpec artifacts — ไม่ใช่ทุก worker ต้อง run ทุก command</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card gold">
    <p class="label">Scribe · sw7</p>
    <h3>Propose + Refine</h3>
    <p>รัน /opsx:propose เพื่อสร้าง artifacts; review + refine tasks.md ให้ task แต่ละอัน &lt; 2h และ parallel-safe</p>
  </div>
  <div class="card">
    <p class="label">Builder + Sidekick · sw5/sw10</p>
    <h3>Parallel Apply</h3>
    <p>รัน /opsx:apply --task [range] ตาม tasks.md; parallel workers รับ task range ต่างกัน — shared queue</p>
  </div>
  <div class="card success">
    <p class="label">Reviewer · sw6</p>
    <h3>Verify via /opsx:verify</h3>
    <p>ตรวจสอบ implementation ตาม specs/ และ tasks.md; รัน /opsx:verify ก่อน approve PR</p>
  </div>
  <div class="card">
    <p class="label">Mirror · sw3 + Aurora</p>
    <h3>Orchestrate + Archive</h3>
    <p>Aurora propose; Mirror dispatch workers; หลัง review ผ่าน: /opsx:sync แล้ว /opsx:archive</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> tasks.md = shared work queue; ใช้ --task flag ระบุ range สำหรับ parallel workers ป้องกัน overlap</div>

<!-- Speaker: tasks.md ทำงานเหมือน kanban board ที่ทุก worker อ่านและ claim tasks เป็น range -->

---

## Full Swarm Flow: จาก Intent ถึง Archive

<p class="subhead">8 ขั้นตอนใน Hermes Swarm — OpenSpec artifacts เป็น checkpoint ระหว่างทุก phase</p>

<div class="infographic">
<svg viewBox="0 0 1100 330" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="af" markerWidth="7" markerHeight="5" refX="7" refY="2.5" orient="auto"><polygon points="0 0,7 2.5,0 5" fill="var(--accent)"/></marker></defs>

  <!-- Row 1: 4 boxes -->
  <!-- 1 Eric -->
  <rect x="20" y="30" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="130" y="55" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Eric</text>
  <text x="130" y="73" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">"add notification bell"</text>
  <text x="130" y="91" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">states outcome</text>

  <line x1="240" y1="68" x2="268" y2="68" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- 2 Aurora propose -->
  <rect x="268" y="30" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="378" y="55" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">2. Aurora</text>
  <text x="378" y="73" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/opsx:propose</text>
  <text x="378" y="91" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">creates artifacts</text>

  <line x1="488" y1="68" x2="516" y2="68" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- 3 Scribe refine -->
  <rect x="516" y="30" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--gold)" stroke-width="1.5" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="626" y="55" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">3. Scribe</text>
  <text x="626" y="73" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">review + refine tasks.md</text>
  <text x="626" y="91" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">commit artifacts</text>

  <line x1="736" y1="68" x2="764" y2="68" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- 4 Mirror dispatch -->
  <rect x="764" y="30" width="316" height="76" rx="9" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="922" y="55" font-size="11" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">4. Mirror dispatches</text>
  <text x="922" y="73" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Builder: tasks 1-3 | Sidekick: tasks 4-6</text>
  <text x="922" y="91" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SwarmBrief refs tasks.md</text>

  <!-- Down arrow from Mirror -->
  <line x1="922" y1="106" x2="922" y2="165" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- Row 2: reversed flow, 4 boxes -->
  <!-- 8 Archive -->
  <rect x="20" y="165" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="130" y="190" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">8. Scribe</text>
  <text x="130" y="208" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/opsx:sync + /opsx:archive</text>
  <text x="130" y="226" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">specs updated, done</text>

  <line x1="240" y1="203" x2="268" y2="203" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- 7 Reviewer verify -->
  <rect x="268" y="165" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="378" y="190" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">7. Reviewer</text>
  <text x="378" y="208" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/opsx:verify</text>
  <text x="378" y="226" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">0 tasks incomplete</text>

  <line x1="488" y1="203" x2="516" y2="203" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- 5/6 Builder + Sidekick -->
  <rect x="516" y="165" width="220" height="76" rx="9" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 4px rgba(15,23,42,.06))"/>
  <text x="626" y="190" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">5+6. Builder / Sidekick</text>
  <text x="626" y="208" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/opsx:apply (parallel)</text>
  <text x="626" y="226" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">checkpoint → orchestrator</text>

  <line x1="736" y1="203" x2="764" y2="203" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#af)"/>

  <!-- connected to top row via down arrow already -->
  <rect x="764" y="165" width="316" height="76" rx="9" fill="var(--accent-wash)" opacity=".7" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="922" y="194" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">tasks.md = shared work queue</text>
  <text x="922" y="214" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">parallel workers, 0 drift</text>

  <!-- bottom text -->
  <text x="550" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">flow: Eric → Aurora propose → Scribe refine → parallel apply → verify → archive</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Commit artifacts ก่อน dispatch workers เสมอ — ถ้า tasks.md ไม่ใน git, parallel workers ดึงไม่ได้</div>

<!-- Speaker: 8 steps ทั้งหมด; key rule = commit artifacts first, dispatch second -->

---

## Key Takeaways: OpenSpec + Hermes Swarm

<p class="subhead">6 สิ่งที่ทำให้ OpenSpec ทำงานได้ดีใน multi-agent context</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">ปัญหาที่แก้</p>
    <h3>Agent Drift ใน Parallel Workers</h3>
    <p>ปัญหาหลักของ multi-agent — แต่ละ worker interpret feature ต่างกัน; OpenSpec artifacts เป็น shared contract</p>
  </div>
  <div class="card gold">
    <p class="label">Scribe Role</p>
    <h3>Propose + Refine ก่อน Dispatch</h3>
    <p>Scribe (sw7) เหมาะที่สุดสำหรับ propose + refine tasks ให้ parallel-safe ก่อน orchestrator dispatch</p>
  </div>
  <div class="card">
    <p class="label">tasks.md</p>
    <h3>Shared Work Queue สำหรับ Parallel</h3>
    <p>Builder + Sidekick รับ task range ต่างกันจาก tasks.md เดียวกัน — ใช้ /opsx:apply --task N</p>
  </div>
  <div class="card success">
    <p class="label">Reviewer</p>
    <h3>/opsx:verify ก่อน Approve PR</h3>
    <p>Reviewer (sw6) รัน /opsx:verify ตรวจว่า implementation ครบตาม specs ก่อน merge</p>
  </div>
  <div class="card warning">
    <p class="label">Git Order Matters</p>
    <h3>Commit Artifacts ก่อน Dispatch</h3>
    <p>openspec/changes/ ต้องใน git ก่อน dispatch workers — parallel workers อาจอยู่ใน worktree แยก</p>
  </div>
  <div class="card">
    <p class="label">config.yaml</p>
    <h3>เพิ่ม Swarm-Aware Rules</h3>
    <p>tasks: parallel-safe partitioning, &lt;2h per chunk, Electron vs web labeling — inject ทุก propose</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OpenSpec artifacts = coordination protocol สำหรับ swarm — propose ก่อน, commit ก่อน, dispatch หลัง</div>

<!-- Speaker: จบ — จุดสำคัญที่สุดคือ "commit before dispatch" และ tasks.md เป็น work queue -->
