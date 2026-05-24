---
marp: true
theme: default
paginate: true
title: "OpenSpec EP4: เจาะลึก Artifacts"
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

# OpenSpec EP4: เจาะลึก Artifacts

<p class="tag">proposal, specs, design, tasks — สัญญาระหว่างคุณกับ AI — เจาะลึก OpenSpec สำหรับ Beginners</p>

<!-- Speaker: Artifacts คือ core ของ OpenSpec — เขียนดีได้ดี เขียนแย่ AI implement แย่ -->

---

## 4 Artifacts ทำงานร่วมกันยังไง?

<p class="subhead">แต่ละชิ้น inherit context จากชิ้นก่อน — ถ้า proposal ไม่ดี, tasks จะพลาด</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- proposal.md -->
  <rect x="30" y="80" width="210" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="80" width="210" height="48" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="135" y="112" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">proposal.md</text>
  <text x="135" y="150" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ทำไม + ทำอะไร</text>
  <text x="135" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">scope + out-of-scope</text>
  <text x="135" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">context สำหรับ AI</text>
  <!-- Arrow 1 -->
  <line x1="246" y1="150" x2="298" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="298,144 310,150 298,156" fill="var(--accent)"/>
  <!-- specs/ -->
  <rect x="315" y="80" width="210" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="315" y="80" width="210" height="48" rx="12" fill="var(--success)" opacity=".12"/>
  <text x="420" y="112" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">specs/</text>
  <text x="420" y="150" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">delta requirements</text>
  <text x="420" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ADDED / MODIFIED</text>
  <text x="420" y="190" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">REMOVED</text>
  <!-- Arrow 2 -->
  <line x1="531" y1="150" x2="583" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="583,144 595,150 583,156" fill="var(--accent)"/>
  <!-- design.md -->
  <rect x="600" y="80" width="210" height="140" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="600" y="80" width="210" height="48" rx="12" fill="var(--warning)" opacity=".12"/>
  <text x="705" y="112" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">design.md</text>
  <text x="705" y="150" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">technical approach</text>
  <text x="705" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">architecture decisions</text>
  <text x="705" y="190" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">file changes list</text>
  <!-- Arrow 3 -->
  <line x1="816" y1="150" x2="868" y2="150" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="868,144 880,150 868,156" fill="var(--accent)"/>
  <!-- tasks.md -->
  <rect x="884" y="60" width="196" height="180" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2.5"/>
  <rect x="884" y="60" width="196" height="48" rx="12" fill="var(--accent)" opacity=".2"/>
  <text x="982" y="92" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">tasks.md</text>
  <text x="982" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">implementation checklist</text>
  <text x="982" y="152" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AI implements this</text>
  <text x="982" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">สำคัญที่สุด</text>
  <text x="982" y="192" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ลงทุน review ให้ดี</text>
  <!-- Dependency label -->
  <text x="550" y="256" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แต่ละชิ้น inherit context จากชิ้นก่อน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> tasks.md สำคัญที่สุด — AI implement ตามนี้ตรงๆ; review order: proposal → tasks → design</div>

<!-- Speaker: เริ่ม review จาก tasks.md เพราะนั่นคือสิ่งที่ AI จะทำจริงๆ -->

---

## proposal.md: ทำไมต้องมี Out-of-Scope?

<p class="subhead">Out-of-scope ชัดเจน = ป้องกัน AI scope creep ที่พบบ่อยที่สุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Bad proposal -->
  <rect x="40" y="30" width="460" height="260" rx="14" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="40" y="30" width="460" height="52" rx="14" fill="var(--danger-wash)"/>
  <text x="270" y="63" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Proposal ที่ไม่ดี</text>
  <text x="80" y="110" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui"># Add Dark Mode</text>
  <text x="80" y="136" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Add dark mode to the app.</text>
  <text x="80" y="200" font-size="12" fill="var(--danger)" font-family="system-ui">ไม่มี out-of-scope</text>
  <text x="80" y="224" font-size="12" fill="var(--danger)" font-family="system-ui">AI อาจเพิ่ม: mobile dark mode,</text>
  <text x="80" y="248" font-size="12" fill="var(--danger)" font-family="system-ui">per-component themes, color picker</text>
  <text x="80" y="268" font-size="11" fill="var(--muted)" font-family="system-ui">= scope creep</text>
  <!-- Arrow -->
  <text x="550" y="165" font-size="28" fill="var(--muted)" text-anchor="middle" font-family="system-ui">vs</text>
  <!-- Good proposal -->
  <rect x="600" y="30" width="460" height="260" rx="14" fill="var(--paper)" stroke="var(--success)" stroke-width="2.5"/>
  <rect x="600" y="30" width="460" height="52" rx="14" fill="var(--success-wash)"/>
  <text x="830" y="63" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Proposal ที่ดี</text>
  <text x="640" y="110" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui"># Add Dark Mode</text>
  <text x="640" y="138" font-size="12" fill="var(--ink-dim)" font-family="system-ui">In Scope: ThemeContext, CSS vars,</text>
  <text x="640" y="158" font-size="12" fill="var(--ink-dim)" font-family="system-ui">toggle button, localStorage</text>
  <text x="640" y="190" font-size="12" font-weight="700" fill="var(--success)" font-family="system-ui">Out of Scope:</text>
  <text x="640" y="212" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Mobile app changes (separate epic)</text>
  <text x="640" y="232" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Custom color picker</text>
  <text x="640" y="252" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Scheduled auto-switch</text>
  <text x="640" y="272" font-size="11" fill="var(--success)" font-family="system-ui">AI รู้ขอบเขตชัดเจน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เพิ่ม "Out of Scope" ทุกครั้ง — ป้องกัน AI implement เกินที่ต้องการ</div>

<!-- Speaker: Out-of-scope เป็น defense สำคัญ โดยเฉพาะสำหรับ feature ที่ขอบเขต ambiguous -->

---

## tasks.md: Checklist ที่ดีเป็นยังไง?

<p class="subhead">Tasks ที่ดี: ขนาดพอเหมาะ, ลำดับถูกต้อง, วัดได้ว่า "done" คืออะไร</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Task ที่แย่</p>
    <h3>Task ใหญ่เกินไป</h3>
    <p>"Implement dark mode feature" — AI ไม่รู้ว่าจะเริ่มตรงไหน ทำอะไรบ้าง</p>
  </div>
  <div class="card warning">
    <p class="label">Task ที่พอใช้</p>
    <h3>Task เล็กเกินไป</h3>
    <p>"Add one CSS variable" — ใช้ได้ แต่มี 50 tasks จะ manage ยาก</p>
  </div>
  <div class="card success">
    <p class="label">Task ที่ดี</p>
    <h3>30 นาทีต่อ task</h3>
    <p>"1.1 Create ThemeContext with light/dark state and toggle" — ชัดเจน, วัดได้, dependency ถูก</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แต่ละ task ควร complete ได้ใน ~30 นาที — ไม่ใหญ่เกิน ไม่เล็กเกิน</div>

<!-- Speaker: ถ้า tasks.md ขาด task สำคัญ ให้เพิ่มเองก่อน apply -->

---

## Review Order: ตรวจ Artifacts ยังไงให้มีประสิทธิภาพ?

<p class="subhead">ไม่ต้อง review ทุกชิ้นอย่างละเอียดเท่ากัน — ลงทุนเวลาตามความสำคัญ</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Priority items -->
  <rect x="40" y="40" width="240" height="220" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2.5"/>
  <circle cx="160" cy="32" r="18" fill="var(--accent)"/>
  <text x="160" y="38" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="160" y="90" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">tasks.md</text>
  <text x="160" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">5 นาที</text>
  <text x="160" y="148" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ครบไหม?</text>
  <text x="160" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ลำดับ OK?</text>
  <text x="160" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ขนาดพอเหมาะ?</text>
  <text x="160" y="218" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">สำคัญที่สุด</text>
  <!-- 2 -->
  <rect x="320" y="40" width="240" height="220" rx="12" fill="var(--paper)" stroke="var(--ink-dim)" stroke-width="1.5"/>
  <circle cx="440" cy="32" r="18" fill="var(--ink-dim)"/>
  <text x="440" y="38" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="440" y="90" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">proposal.md</text>
  <text x="440" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2 นาที</text>
  <text x="440" y="148" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">scope ถูกไหม?</text>
  <text x="440" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">out-of-scope ชัดไหม?</text>
  <!-- 3 -->
  <rect x="600" y="40" width="240" height="220" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <circle cx="720" cy="32" r="18" fill="var(--muted)"/>
  <text x="720" y="38" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="720" y="90" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">design.md</text>
  <text x="720" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">3 นาที</text>
  <text x="720" y="148" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ตรง convention ไหม?</text>
  <text x="720" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">file changes ถูกต้อง?</text>
  <!-- 4 -->
  <rect x="880" y="40" width="190" height="220" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="975" cy="32" r="18" fill="var(--soft-2)"/>
  <text x="975" y="38" font-size="14" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="975" y="90" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">specs/</text>
  <text x="975" y="114" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">optional</text>
  <text x="975" y="148" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">requirements</text>
  <text x="975" y="168" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ครบไหม?</text>
  <text x="975" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ถ้าเวลาไม่พอ ข้ามได้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Review เริ่มจาก tasks.md (5 min) → proposal.md (2 min) → design.md (3 min) → specs/ (optional)</div>

<!-- Speaker: Total review ประมาณ 10 นาที ก่อน apply — ลงทุนที่คุ้มค่ามาก -->

---

## Key Takeaways: OpenSpec EP4

<p class="subhead">สิ่งที่ต้องจำจาก EP4 ก่อนไป EP5 (Expanded Workflow)</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Artifact Chain</p>
    <h3>proposal → specs → design → tasks</h3>
    <p>แต่ละชิ้น inherit จากก่อนหน้า — ถ้า proposal แย่ tasks จะพลาดเสมอ</p>
  </div>
  <div class="card warning">
    <p class="label">Most Critical</p>
    <h3>tasks.md สำคัญที่สุด</h3>
    <p>AI implement ตามนี้ตรงๆ — review ให้ดี แต่ละ task ~30 นาที ลำดับถูกต้อง</p>
  </div>
  <div class="card success">
    <p class="label">Quick Win</p>
    <h3>ใส่ Out-of-Scope เสมอ</h3>
    <p>ป้องกัน AI scope creep — ง่าย แต่ developer หลายคนข้ามขั้นตอนนี้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP5 → Expanded Workflow, config.yaml inject context, และ multi-tool integration</div>

<!-- Speaker: EP5 คือ advanced topics สำหรับ team ที่ต้องการ customize OpenSpec ให้ fit กับ process -->
