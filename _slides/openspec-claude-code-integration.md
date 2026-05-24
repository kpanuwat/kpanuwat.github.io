---
marp: true
theme: default
paginate: true
title: "OpenSpec + Claude Code CLI"
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

# OpenSpec + Claude Code CLI

<p class="tag">Skill files, context pipeline, และ workflow ที่ทำงานจริง</p>

<!-- Speaker: Post นี้เจาะเฉพาะ Claude Code perspective — ทำไม /opsx:propose ถึงทำงานได้, และ tune ยังไงให้ artifacts ดีขึ้น -->

---

## Skill Files คือ Bridge ที่ทำให้ /opsx:* ทำงานใน Claude Code

<p class="subhead">OpenSpec inject ตัวเองผ่าน Markdown files ที่ Claude อ่านเป็น context — ไม่มี plugin ระดับ system</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- directory tree showing .claude/skills/ structure -->
  <!-- left: openspec init -->
  <rect x="40" y="60" width="200" height="60" rx="10" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="86" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">openspec init</text>
  <text x="140" y="107" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">--tools claude</text>

  <!-- arrow -->
  <line x1="240" y1="90" x2="310" y2="90" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>
  <defs><marker id="arr" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="var(--accent)"/></marker></defs>

  <!-- center: .claude/skills/ -->
  <rect x="310" y="20" width="480" height="260" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="50" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">.claude/skills/</text>

  <rect x="330" y="65" width="440" height="42" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="91" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">openspec-core/SKILL.md</text>

  <rect x="330" y="115" width="440" height="42" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="141" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">openspec-propose/SKILL.md</text>

  <rect x="330" y="165" width="440" height="42" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="191" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">openspec-apply/SKILL.md</text>

  <rect x="330" y="215" width="440" height="42" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="241" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">openspec-sync/  openspec-archive/  ...</text>

  <!-- arrow -->
  <line x1="790" y1="150" x2="860" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>

  <!-- right: Claude reads -->
  <rect x="860" y="80" width="200" height="140" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="960" y="120" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="960" y="144" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">reads SKILL.md</text>
  <text x="960" y="164" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">at session start</text>
  <text x="960" y="198" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/opsx:* ready</text>

  <!-- label below -->
  <text x="550" y="310" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Skill files = system prompt เพิ่มเติม — ไม่มี plugin ระดับระบบ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> /opsx:propose ทำงานได้เพราะ Claude อ่าน SKILL.md — commit .claude/skills/ เข้า repo ให้ทีมใช้ร่วมกัน</div>

<!-- Speaker: Skill files เป็นแค่ Markdown ที่ Claude อ่านเป็น context ตอน session start — ไม่ต้องมี plugin ระดับ system -->

---

## Init สำหรับ Claude Code: 3 ขั้นตอน, 2 Profile

<p class="subhead">openspec init --tools claude รัน wizard 3 ข้อ แล้ว install skill files ตาม profile ที่เลือก</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-step arrow flow top half -->
  <!-- Step 1 -->
  <rect x="40" y="30" width="220" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <text x="150" y="58" font-size="28" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="150" y="82" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Profile</text>
  <text x="150" y="102" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">core / expanded</text>

  <line x1="260" y1="75" x2="330" y2="75" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <defs><marker id="a2" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="var(--accent)"/></marker></defs>

  <!-- Step 2 -->
  <rect x="330" y="30" width="220" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <text x="440" y="58" font-size="28" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="440" y="82" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI Tool</text>
  <text x="440" y="102" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เลือก claude</text>

  <line x1="550" y1="75" x2="620" y2="75" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Step 3 -->
  <rect x="620" y="30" width="220" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <text x="730" y="58" font-size="28" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="730" y="82" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Language</text>
  <text x="730" y="102" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(optional)</text>

  <line x1="840" y1="75" x2="910" y2="75" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Result -->
  <rect x="910" y="30" width="160" height="90" rx="10" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
  <text x="990" y="65" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Skills</text>
  <text x="990" y="85" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Installed</text>
  <text x="990" y="105" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">.claude/skills/</text>

  <!-- Profile comparison table -->
  <rect x="40" y="155" width="500" height="170" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="155" width="500" height="38" rx="10" fill="var(--soft)"/>
  <text x="180" y="179" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Core (Beginner)</text>
  <text x="420" y="179" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Expanded</text>
  <line x1="290" y1="155" x2="290" y2="325" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="180" y="210" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">propose, explore</text>
  <text x="180" y="230" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">apply, sync, archive</text>
  <text x="180" y="260" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5 skill files</text>
  <text x="420" y="210" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">+ new, continue, ff</text>
  <text x="420" y="230" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">verify, bulk-archive, onboard</text>
  <text x="420" y="260" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">11 skill files</text>
  <rect x="40" y="287" width="500" height="38" rx="10" fill="var(--accent-wash)" opacity=".6"/>
  <text x="290" y="311" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Beginners: เริ่ม Core ก่อน — ครอบคลุม 80% ของ use case</text>

  <!-- note right -->
  <rect x="570" y="155" width="500" height="170" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="820" y="185" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Non-interactive init</text>
  <text x="820" y="225" font-size="14" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-style="italic">openspec init --tools claude</text>
  <text x="820" y="260" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เหมาะสำหรับ CI / scripting</text>
  <text x="820" y="295" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ถาม interactive prompts</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มด้วย Core profile — propose + apply + archive ครอบคลุมงาน 80%; เพิ่ม Expanded เมื่อต้องการ artifact-by-artifact control</div>

<!-- Speaker: 3 questions in wizard, แล้ว skill files install อัตโนมัติ ไม่ต้องทำ manual -->

---

## Context Pipeline: config.yaml ไหลเข้า Claude ยังไง

<p class="subhead">ทุก /opsx:* command inject config.yaml เข้าไปใน Claude's context — ทำครั้งเดียวได้ผลทุก proposal</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Stage 1: config.yaml -->
  <rect x="20" y="80" width="190" height="180" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="20" y="80" width="190" height="36" rx="10" fill="var(--soft)"/>
  <text x="115" y="103" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">config.yaml</text>
  <text x="115" y="140" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tech stack</text>
  <text x="115" y="160" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Testing framework</text>
  <text x="115" y="180" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Artifact rules</text>
  <text x="115" y="200" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Team conventions</text>
  <text x="115" y="240" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">openspec/config.yaml</text>

  <!-- Arrow 1 -->
  <line x1="210" y1="170" x2="280" y2="170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <defs><marker id="a3" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="var(--accent)"/></marker></defs>
  <text x="245" y="160" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">reads</text>

  <!-- Stage 2: Skill file -->
  <rect x="280" y="80" width="190" height="180" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="280" y="80" width="190" height="36" rx="10" fill="var(--soft)"/>
  <text x="375" y="103" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Skill file</text>
  <text x="375" y="140" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Command definition</text>
  <text x="375" y="160" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Artifact structure</text>
  <text x="375" y="180" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">+ injected context</text>
  <text x="375" y="200" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">from config.yaml</text>
  <text x="375" y="240" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">.claude/skills/openspec-*/SKILL.md</text>

  <!-- Arrow 2 -->
  <line x1="470" y1="170" x2="540" y2="170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <text x="505" y="160" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">sends to</text>

  <!-- Stage 3: Claude -->
  <rect x="540" y="80" width="190" height="180" rx="10" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
  <rect x="540" y="80" width="190" height="36" rx="10" fill="var(--accent)" opacity=".15"/>
  <text x="635" y="103" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude</text>
  <text x="635" y="140" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Aware of: React 19</text>
  <text x="635" y="160" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Aware of: Vitest</text>
  <text x="635" y="180" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Rules: task &lt;= 30 min</text>
  <text x="635" y="200" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Rules: Given/When/Then</text>
  <text x="635" y="240" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/opsx:propose triggered</text>

  <!-- Arrow 3 -->
  <line x1="730" y1="170" x2="800" y2="170" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <text x="765" y="160" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">generates</text>

  <!-- Stage 4: Artifacts -->
  <rect x="800" y="80" width="280" height="180" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="800" y="80" width="280" height="36" rx="10" fill="var(--success-wash)"/>
  <text x="940" y="103" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Artifacts</text>
  <text x="940" y="138" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">proposal.md — mentions Vitest</text>
  <text x="940" y="158" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/ — Given/When/Then</text>
  <text x="940" y="178" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">tasks.md — tasks &lt;= 30 min</text>
  <text x="940" y="198" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">design.md — stack-aware</text>
  <text x="940" y="240" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">project-specific, not generic</text>

  <!-- bottom label -->
  <text x="550" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">config.yaml เขียนครั้งเดียว — inject เข้าทุก proposal อัตโนมัติ ไม่ต้องพิมพ์ซ้ำ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เพิ่ม openspec/config.yaml ก่อนรัน propose ครั้งแรก — ผลต่างชัดเจนทันที</div>

<!-- Speaker: ถ้า artifacts ออกมา generic ไม่ตรง project — ตรวจ config.yaml ก่อนเสมอ -->

---

## CLAUDE.md vs config.yaml: ต่างกันอย่างไร

<p class="subhead">สองไฟล์ทำงานต่างกัน — combine ให้สอดคล้องกันเพื่อให้ artifacts ตรงกับ behavior rules</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">CLAUDE.md</p>
    <h3>Behavior Rules — อ่านทุก Session</h3>
    <p><b>อ่านโดย:</b> Claude Code ทุก session โดยอัตโนมัติ</p>
    <p><b>ควรใส่:</b> Behavior rules, code style, project structure, tools, git conventions</p>
    <p><b>Scope:</b> ทุก interaction กับ Claude ไม่ใช่แค่ OpenSpec</p>
    <p><b>ตัวอย่าง:</b> "always use Vitest", "no console.log", "conventional commits"</p>
  </div>
  <div class="card gold">
    <p class="label">openspec/config.yaml</p>
    <h3>Artifact Rules — Inject เข้า /opsx:*</h3>
    <p><b>อ่านโดย:</b> OpenSpec skill เฉพาะตอน run /opsx:* commands</p>
    <p><b>ควรใส่:</b> Tech stack, versions, per-artifact rules สำหรับ AI</p>
    <p><b>Scope:</b> OpenSpec workflows เท่านั้น</p>
    <p><b>ตัวอย่าง:</b> "tasks must include Vitest test", "specs: Given/When/Then", "stack: React 19"</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cross-reference: ถ้า CLAUDE.md บอก "use Vitest" ให้ config.yaml บอก "tasks must include Vitest test" — ให้ artifacts สอดคล้องกับ behavior</div>

<!-- Speaker: สองไฟล์ complement กัน — CLAUDE.md บอกว่าทำอะไร, config.yaml บอกว่า OpenSpec ควร generate อะไร -->

---

## Practical Workflow ใน Claude Code

<p class="subhead">5 ขั้นตอนจาก idea ไปถึง archived feature — ทุกขั้นทำผ่าน slash commands ใน Claude Code</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step boxes -->
  <!-- 1: propose -->
  <rect x="20" y="60" width="185" height="110" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="20" y="60" width="185" height="34" rx="10" fill="var(--accent)" opacity=".1"/>
  <text x="112" y="83" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">/opsx:propose</text>
  <text x="112" y="110" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สร้าง artifacts</text>
  <text x="112" y="130" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">4 ไฟล์พร้อมกัน</text>
  <text x="112" y="155" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">proposal, specs,</text>
  <text x="112" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">design, tasks</text>

  <line x1="205" y1="115" x2="235" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#a4)"/>
  <defs><marker id="a4" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="var(--accent)"/></marker></defs>

  <!-- 2: review (manual) -->
  <rect x="235" y="60" width="175" height="110" rx="10" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="235" y="60" width="175" height="34" rx="10" fill="var(--warning-wash)" opacity=".8"/>
  <text x="322" y="83" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Review</text>
  <text x="322" y="110" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Read artifacts</text>
  <text x="322" y="130" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">แก้ถ้าจำเป็น</text>
  <text x="322" y="155" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ขั้นตอนนี้สำคัญ</text>
  <text x="322" y="168" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">อย่าข้าม</text>

  <line x1="410" y1="115" x2="440" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#a4)"/>

  <!-- 3: apply -->
  <rect x="440" y="60" width="175" height="110" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="440" y="60" width="175" height="34" rx="10" fill="var(--accent)" opacity=".1"/>
  <text x="527" y="83" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">/opsx:apply</text>
  <text x="527" y="110" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Implement tasks.md</text>
  <text x="527" y="130" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ทีละ task</text>
  <text x="527" y="155" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Claude reads codebase</text>
  <text x="527" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ tasks → implements</text>

  <line x1="615" y1="115" x2="645" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#a4)"/>

  <!-- 4: sync -->
  <rect x="645" y="60" width="175" height="110" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="645" y="60" width="175" height="34" rx="10" fill="var(--accent)" opacity=".1"/>
  <text x="732" y="83" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">/opsx:sync</text>
  <text x="732" y="110" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Merge delta specs</text>
  <text x="732" y="130" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เข้า main specs/</text>
  <text x="732" y="155" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต้องทำก่อน</text>
  <text x="732" y="168" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">archive เสมอ</text>

  <line x1="820" y1="115" x2="850" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#a4)"/>

  <!-- 5: archive -->
  <rect x="850" y="60" width="220" height="110" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="850" y="60" width="220" height="34" rx="10" fill="var(--success-wash)" opacity=".8"/>
  <text x="960" y="83" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">/opsx:archive</text>
  <text x="960" y="110" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เก็บ change folder</text>
  <text x="960" y="130" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เข้า archive/</text>
  <text x="960" y="155" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ดูย้อนหลังได้ทุกเมื่อ</text>
  <text x="960" y="168" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">artifacts อยู่ใน git</text>

  <!-- Claude Code tip -->
  <rect x="160" y="210" width="780" height="56" rx="10" fill="var(--accent-wash)" opacity=".7"/>
  <text x="550" y="235" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude Code tip: ก่อน /opsx:apply บน feature ซับซ้อน</text>
  <text x="550" y="255" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"Read src/payments/ then /opsx:apply" — Claude reads codebase ก่อน implement</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Review artifacts ก่อน apply เสมอ — AI สร้าง draft; คุณ finalize; /opsx:sync ก่อน archive เสมอ</div>

<!-- Speaker: Review step คือ checkpoint ที่สำคัญที่สุด — garbage in garbage out -->

---

## Key Takeaways: OpenSpec + Claude Code

<p class="subhead">6 สิ่งที่ต้องรู้เพื่อให้ integration ทำงานได้ดี</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Skill Files</p>
    <h3>Bridge ระหว่าง OpenSpec กับ Claude</h3>
    <p>.claude/skills/ คือที่ที่ Claude อ่าน command definitions — commit เข้า repo ให้ทีมใช้ร่วมกัน</p>
  </div>
  <div class="card gold">
    <p class="label">config.yaml</p>
    <h3>Inject ครั้งเดียว ได้ผลทุก Proposal</h3>
    <p>tech stack + per-artifact rules เข้าทุก /opsx:* — ทำก่อนรัน propose ครั้งแรก</p>
  </div>
  <div class="card success">
    <p class="label">CLAUDE.md + config.yaml</p>
    <h3>Cross-reference ให้สอดคล้องกัน</h3>
    <p>CLAUDE.md = behavior rules สำหรับ Claude; config.yaml = artifact rules สำหรับ OpenSpec</p>
  </div>
  <div class="card warning">
    <p class="label">openspec update</p>
    <h3>Manual sync ทุกครั้งที่เปลี่ยน config</h3>
    <p>ไม่มี auto-watch — run หลังเปลี่ยน profile หรือ config.yaml ไม่งั้น Claude ใช้ skills เก่า</p>
  </div>
  <div class="card">
    <p class="label">Codebase Context</p>
    <h3>Read ก่อน apply บน feature ซับซ้อน</h3>
    <p>"Read src/X then /opsx:apply" — Claude Code context window คือข้อได้เปรียบหลัก</p>
  </div>
  <div class="card">
    <p class="label">Workflow Order</p>
    <h3>propose → review → apply → sync → archive</h3>
    <p>sync ก่อน archive เสมอ; review artifacts ก่อน apply เสมอ — สองขั้นนี้มัก skip แล้วเสียใจ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> config.yaml คือ investment ที่คุ้มที่สุด — 10 นาทีเขียน ประหยัดเวลา prompt ซ้ำในทุก session</div>

<!-- Speaker: จบ — ถ้าจะเริ่มวันนี้: openspec init --tools claude แล้วเพิ่ม config.yaml ก่อน propose -->
