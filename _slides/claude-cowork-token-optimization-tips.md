---
marp: true
theme: default
paginate: true
title: "Top 5 Claude Co-work Tips: ประหยัด Token และทำงานมีประสิทธิภาพ"
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
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Top 5 Claude Co-work Tips: ประหยัด Token

<p class="tag">ลด context bloat, แยก behavioral rules จาก mutable facts, และ migrate จาก Claude Projects</p>

<!-- Speaker: 5 เทคนิคที่ลด token usage ใน Claude Code ได้ทันที ไม่ต้องซื้อ plan แพงขึ้น -->

---

## ปัญหา: Context Bloat กินเงินทุก Session

<p class="subhead">Claude Code โหลด CLAUDE.md + MEMORY.md + Skills ทุกครั้งที่เริ่ม session ใหม่</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">อาการที่พบบ่อย</p>
    <h3>Context Bloat</h3>
    <ul>
      <li>CLAUDE.md บวม &gt; 400-500 บรรทัด</li>
      <li>MEMORY.md เก็บทุกอย่างไม่ archive</li>
      <li>Behavioral rules ปนกับ mutable facts</li>
      <li>ไม่รู้ว่าบริบทควรอยู่ใน Project หรือ Co-work</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">ผลกระทบ</p>
    <h3>Token หมดเร็ว งานแพง</h3>
    <p>ทุกบรรทัดใน CLAUDE.md ถูกโหลดเข้า context <strong>ทุก session</strong></p>
    <p>ยิ่งยาว → Token หมดเร็ว → ต้องเปิด session ใหม่บ่อย → ค่าใช้จ่ายพุ่ง</p>
    <p>5 เทคนิคข้างล่างแก้ปัญหานี้โดยตรง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุกบรรทัดใน context files มีราคา — trim สม่ำเสมอ = ประหยัดได้มาก</div>

<!-- Speaker: นี่คือเหตุผลที่ session แพง ทั้งที่ task ไม่ได้ซับซ้อน -->

---

## Tip 1: Obsidian เป็น Native Editor สำหรับ Claude Files

<p class="subhead">เปิด ~/.claude/ เป็น Vault → เห็น backlinks, preview, ค้นข้ามไฟล์ได้เร็วกว่า grep</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Obsidian Vault</p>
    <h3>เปิดที่ ~/.claude/</h3>
    <p>เห็น CLAUDE.md, MEMORY.md, skills/, projects/ ใน sidebar ทันที</p>
    <p>Preview markdown โดยไม่ต้อง build</p>
    <p>เขียน [[link]] เชื่อม memory files</p>
    <p>Save → Claude Code รับทันทีใน session ถัดไป</p>
  </div>
  <div class="card success">
    <p class="label">ทำไมดีกว่า terminal</p>
    <h3>Backlinks + Graph View</h3>
    <p>เห็นว่า memory file ไหนถูกอ้างถึงบ้าง</p>
    <p>ค้นหาข้ามไฟล์ได้เร็วกว่า grep มาก</p>
    <p>แก้ไข behavioral rules ได้ง่ายขึ้น</p>
    <p>ระวัง: backup settings.local.json ก่อน edit</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Obsidian คือ native .md editor ที่ดีที่สุดสำหรับจัดการ Claude context files</div>

<!-- Speaker: ไม่ต้องติดตั้งอะไรพิเศษ — เปิด folder เป็น vault ได้เลย -->

---

## Tip 2 & 3: Hard Limits + แยกประเภทข้อมูล

<p class="subhead">CLAUDE.md ≤ 250 บรรทัด, MEMORY.md ≤ 150 บรรทัด — แยก behavioral vs mutable</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: behavioral vs mutable -->
  <rect x="40" y="20" width="490" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--soft)" opacity=".8"/>
  <rect x="40" y="56" width="490" height="20" fill="var(--soft)" opacity=".8"/>
  <text x="285" y="54" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Behavioral Rules</text>
  <text x="285" y="78" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เก็บใน CLAUDE.md (max 250 บรรทัด)</text>
  <text x="80" y="115" font-size="13" fill="var(--ink)" font-family="system-ui">Always use ISO 8601 dates</text>
  <text x="80" y="145" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Never push --force to main</text>
  <text x="80" y="175" font-size="13" fill="var(--muted)" font-family="system-ui">กฎที่ยังถูกอยู่ใน 6 เดือน</text>
  <text x="80" y="205" font-size="13" fill="var(--muted)" font-family="system-ui">ประโยค Always / Never</text>
  <text x="80" y="260" font-size="12" fill="var(--success)" font-family="system-ui">เปลี่ยนไม่บ่อย → อยู่ใน CLAUDE.md ได้</text>

  <circle cx="550" cy="160" r="28" fill="var(--accent)"/>
  <text x="550" y="156" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">แยก</text>
  <text x="550" y="172" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">ออก</text>

  <rect x="570" y="20" width="490" height="280" rx="12" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(245,158,11,.15))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--warning-wash)" opacity=".8"/>
  <rect x="570" y="56" width="490" height="20" fill="var(--warning-wash)" opacity=".8"/>
  <text x="815" y="54" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Mutable Facts</text>
  <text x="815" y="78" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ย้ายไป memory/*.md (max 150 บรรทัด)</text>
  <text x="610" y="115" font-size="13" fill="var(--ink)" font-family="system-ui">current sprint goal</text>
  <text x="610" y="145" font-size="13" fill="var(--ink-dim)" font-family="system-ui">active bug ref: #1234</text>
  <text x="610" y="175" font-size="13" fill="var(--muted)" font-family="system-ui">temp config / env note</text>
  <text x="610" y="205" font-size="13" fill="var(--muted)" font-family="system-ui">อาจเปลี่ยนใน 30 วัน</text>
  <text x="610" y="260" font-size="12" fill="var(--warning)" font-family="system-ui">เก่า → archive.md (ไม่โหลดอัตโนมัติ)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้าประโยคขึ้นด้วย "Always"/"Never" → CLAUDE.md. อาจเปลี่ยนใน 30 วัน → memory</div>

<!-- Speaker: กฎง่ายๆ ในการแยก — ไม่ต้องคิดนาน -->

---

## Tip 4: MEMORY.md = Index เท่านั้น + Archive

<p class="subhead">MEMORY.md ≤ 150 บรรทัด — เนื้อหาจริงอยู่ในไฟล์แยก, เก่าเกิน → archive</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- hierarchy-tree: MEMORY.md → files → archive -->
  <rect x="400" y="20" width="300" height="70" rx="10" fill="var(--accent)" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.3))"/>
  <text x="550" y="52" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">MEMORY.md</text>
  <text x="550" y="74" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">index ≤ 150 บรรทัด (auto-load)</text>

  <line x1="550" y1="90" x2="550" y2="130" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="200" y1="130" x2="900" y2="130" stroke="var(--muted)" stroke-width="1.5"/>

  <line x1="200" y1="130" x2="200" y2="160" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="100" y="160" width="200" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="200" y="192" font-size="13" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">feedback_testing.md</text>
  <text x="200" y="212" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เนื้อหาจริงอยู่ที่นี่</text>

  <line x1="550" y1="130" x2="550" y2="160" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="450" y="160" width="200" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="550" y="192" font-size="13" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">project_current.md</text>
  <text x="550" y="212" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เนื้อหาจริงอยู่ที่นี่</text>

  <line x1="900" y1="130" x2="900" y2="160" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="790" y="160" width="220" height="70" rx="10" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(245,158,11,.1))"/>
  <text x="900" y="192" font-size="13" font-weight="600" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">archive.md</text>
  <text x="900" y="212" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่โหลดอัตโนมัติ ค้นได้เมื่อต้อง</text>

  <text x="550" y="275" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">memory ที่ไม่ได้อ้างถึง 30-90 วัน → ย้ายไป archive.md</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> MEMORY.md = pointer เท่านั้น, เนื้อหาอยู่ในไฟล์แยก, เก่า → archive ไม่โหลดอัตโนมัติ</div>

<!-- Speaker: archive.md ไม่กิน token แต่ยังค้นได้เมื่อต้องการ -->

---

## Tip 5: Workstation vs Skill — เลือกให้ถูกประเภท

<p class="subhead">Workstation = context-rich multi-session; Skill = repeatable automation</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col -->
  <rect x="40" y="20" width="480" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="480" height="56" rx="12" fill="var(--soft)"/>
  <rect x="40" y="56" width="480" height="20" fill="var(--soft)"/>
  <text x="280" y="54" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Workstation</text>
  <text x="280" y="75" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">พื้นที่ทำงานที่มีบริบท</text>
  <text x="80" y="112" font-size="13" fill="var(--ink)" font-family="system-ui">project context + memory + CLAUDE.md</text>
  <text x="80" y="140" font-size="13" fill="var(--ink-dim)" font-family="system-ui">งานต่อเนื่อง multi-session</text>
  <text x="80" y="168" font-size="13" fill="var(--muted)" font-family="system-ui">ยังไม่รู้ workflow ชัดเจน</text>
  <text x="80" y="196" font-size="13" fill="var(--muted)" font-family="system-ui">ต้องการ human judgment บ่อย</text>
  <text x="80" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">ใช้ก่อน แล้วค่อย extract เป็น Skill</text>

  <circle cx="550" cy="150" r="28" fill="var(--accent)"/>
  <text x="550" y="146" font-size="10" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">เลือก</text>
  <text x="550" y="160" font-size="10" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">ให้ถูก</text>

  <rect x="570" y="20" width="490" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--accent-wash)"/>
  <rect x="570" y="56" width="490" height="20" fill="var(--accent-wash)"/>
  <text x="815" y="54" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Skill</text>
  <text x="815" y="75" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">กระบวนการซ้ำๆ ที่ automate ได้</text>
  <text x="610" y="112" font-size="13" fill="var(--ink)" font-family="system-ui">workflow ชัดเจน trigger ได้ง่าย</text>
  <text x="610" y="140" font-size="13" fill="var(--ink-dim)" font-family="system-ui">งาน repeatable ที่ทำซ้ำบ่อย</text>
  <text x="610" y="168" font-size="13" fill="var(--accent)" font-family="system-ui">เช่น: add-post, marp-deck</text>
  <text x="610" y="196" font-size="13" fill="var(--muted)" font-family="system-ui">ประหยัด token ต่อครั้งที่ใช้</text>
  <text x="610" y="248" font-size="12" fill="var(--ink-dim)" font-family="system-ui">สร้างใน ~/.claude/skills/&lt;name&gt;/</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้ายังไม่รู้ workflow → Workstation ก่อน. รู้แล้วว่าซ้ำได้ → extract เป็น Skill</div>

<!-- Speaker: Claude Projects (claude.ai) ไม่มี code execution, file access → ย้ายมา Co-work -->

---

## Key Takeaways — 5 เทคนิคที่ต้องจำ

<p class="subhead">ทุกบรรทัดในไฟล์ context มีราคา — จัดการให้ถูกต้องประหยัดได้มาก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Tip 1-2</p>
    <h3>Obsidian + Hard Limits</h3>
    <p>เปิด ~/.claude/ เป็น Obsidian vault. CLAUDE.md ≤ 250 บรรทัด, MEMORY.md ≤ 150 บรรทัด</p>
  </div>
  <div class="card warning">
    <p class="label">Tip 3-4</p>
    <h3>แยกประเภท + Archive</h3>
    <p>Behavioral → CLAUDE.md. Mutable → memory files. เก่า → archive.md ไม่โหลดอัตโนมัติ</p>
  </div>
  <div class="card success">
    <p class="label">Tip 5</p>
    <h3>Workstation vs Skill</h3>
    <p>งาน multi-session → Workstation. งานซ้ำที่รู้ workflow ชัด → extract เป็น Skill</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Trim CLAUDE.md + MEMORY.md ทุกสัปดาห์ = ประหยัด token ได้ 30-50% โดยไม่เสียประสิทธิภาพ</div>

<!-- Speaker: ถ้าจำได้แค่ข้อเดียว → hard limit ทั้งสองไฟล์ แล้ว archive เก่าออกทุกเดือน -->
