---
marp: true
theme: default
paginate: true
title: "เจาะลึก: Fullstack Web App ด้วย Claude Code + Supabase อย่างปลอดภัย"
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
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
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

<div class="mark"></div>

# เจาะลึก: Fullstack Web App<br>ด้วย Claude Code + Supabase<br>อย่างปลอดภัยสำหรับมือใหม่

<p class="tag">3 กฎเหล็ก · Stack ที่ถูกต้อง · Security ตั้งแต่บรรทัดแรก</p>

<!-- Speaker: หัวข้อนี้ครอบคลุม stack architecture, CLAUDE.md, Supabase MCP, RLS, API keys — ออกแบบสำหรับ beginner ที่อยากสร้างแบบถูกต้องตั้งแต่ต้น -->

---

## มือใหม่ติด 3 กำแพง — Claude Code + Supabase พัง 3 ชั้นพร้อมกัน

<p class="subhead">แต่ละ tool แก้คนละปัญหา — รวมกันแล้วถึงทำ fullstack app ได้ภายในวันเดียว</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">กำแพง 1</p>
    <h3>ตั้งค่า Backend</h3>
    <p>Postgres + Auth + Storage ใช้เวลาเป็นสัปดาห์ถ้าทำเอง</p>
    <p><b style="color:var(--success)">Supabase แก้:</b> hosted Postgres + Auth ในตัว</p>
  </div>
  <div class="card danger">
    <p class="label">กำแพง 2</p>
    <h3>จัดการ Auth</h3>
    <p>OAuth, JWT, session management — complex ทั้งหมด</p>
    <p><b style="color:var(--success)">Supabase แก้:</b> Auth built-in พร้อม social login</p>
  </div>
  <div class="card danger">
    <p class="label">กำแพง 3</p>
    <h3>Database Security</h3>
    <p>RLS, policies, key management — เรียนรู้ยาก</p>
    <p><b style="color:var(--success)">Claude Code แก้:</b> generate secure schema ด้วย context จาก CLAUDE.md</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ Supabase สำหรับ backend infrastructure + Claude Code สำหรับ secure code generation — ไม่ใช่แค่ speed แต่ถูกต้องตั้งแต่ต้น</div>

<!-- Speaker: อธิบาย 3 กำแพง จากนั้น pivot ไปที่ว่าทำไม combo ของ 2 tools นี้ถึงสำคัญ -->

---

## 3 กฎเหล็กที่ต้องรู้ก่อนเขียน Code บรรทัดแรก

<p class="subhead">ฝ่าฝืนกฎข้อใดข้อหนึ่ง = data รั่วหรือ database โดนทำลาย</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 rule boxes with emphasis on danger -->
  <rect x="30" y="30" width="320" height="280" rx="14" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="30" y="30" width="320" height="52" rx="14" fill="var(--danger)" opacity=".9"/>
  <text x="190" y="62" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">กฎ 1</text>
  <text x="190" y="120" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ห้าม expose</text>
  <text x="190" y="142" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Service Role Key</text>
  <text x="190" y="165" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">client-side</text>
  <text x="190" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Key นี้ bypass RLS ทั้งหมด</text>
  <text x="190" y="230" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถ้า leak = data รั่วทั้ง DB</text>

  <rect x="390" y="30" width="320" height="280" rx="14" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="390" y="30" width="320" height="52" rx="14" fill="var(--danger)" opacity=".9"/>
  <text x="550" y="62" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">กฎ 2</text>
  <text x="550" y="120" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">เปิด RLS</text>
  <text x="550" y="142" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ทุก Table</text>
  <text x="550" y="165" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่มี RLS = public</text>
  <text x="550" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">anon key เห็นได้ทุก row</text>
  <text x="550" y="230" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ถ้าไม่มี policy</text>

  <rect x="750" y="30" width="320" height="280" rx="14" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="750" y="30" width="320" height="52" rx="14" fill="var(--danger)" opacity=".9"/>
  <text x="910" y="62" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">กฎ 3</text>
  <text x="910" y="120" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">MCP เชื่อมแค่</text>
  <text x="910" y="142" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Dev DB</text>
  <text x="910" y="165" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่ใช่ Production</text>
  <text x="910" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">LLM อาจ execute query ผิด</text>
  <text x="910" y="230" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">หรือถูก prompt injection</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> จำ 3 กฎนี้ไว้ก่อนเขียน code บรรทัดแรก — ป้องกัน 80% ของ security bugs ที่พบใน beginner projects</div>

<!-- Speaker: กฎทั้ง 3 จะถูกอธิบาย deep dive ในสไลด์ถัดไป -->

---

## Stack Architecture: Next.js + Supabase + Claude Code = Production-Ready

<p class="subhead">แต่ละ layer มีหน้าที่ชัดเจน — ไม่มี overlap ที่สร้าง security hole</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4-layer stack diagram -->
  <!-- Layer arrows -->
  <line x1="550" y1="68" x2="550" y2="88" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <line x1="550" y1="148" x2="550" y2="168" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <line x1="550" y1="228" x2="550" y2="248" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="6" refX="4" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--muted)"/>
    </marker>
  </defs>

  <!-- Layer 1: AI Dev -->
  <rect x="100" y="10" width="900" height="58" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="33" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI Development Layer</text>
  <text x="550" y="53" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude Code CLI + Supabase MCP (dev only) + CLAUDE.md Security Rules</text>

  <!-- Layer 2: Frontend -->
  <rect x="100" y="90" width="900" height="58" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="113" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Frontend Layer</text>
  <text x="550" y="133" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Next.js 15 App Router + TypeScript + Tailwind CSS (Vercel Deploy)</text>

  <!-- Layer 3: Backend -->
  <rect x="100" y="170" width="900" height="58" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="193" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Backend Layer</text>
  <text x="550" y="213" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Supabase — Postgres + Auth + Realtime + Storage + RLS</text>

  <!-- Layer 4: Deploy -->
  <rect x="100" y="250" width="900" height="58" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="273" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Deployment Layer</text>
  <text x="550" y="293" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Vercel (frontend auto-deploy) + Supabase Cloud (managed Postgres)</text>

  <!-- Security boundary note -->
  <rect x="100" y="320" width="900" height="30" rx="6" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="550" y="340" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Security Boundary: anon key (client) vs service_role key (server only) vs MCP (dev only)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI Dev Layer ใช้แค่ตอน develop — ไม่มีในโครงสร้าง production; security boundary แยก client/server/dev ชัดเจน</div>

<!-- Speaker: อธิบาย 4 layers + สิ่งสำคัญคือ AI Dev layer หายไปใน production -->

---

## CLAUDE.md คือ Security Anchor ของทุก Session

<p class="subhead">Claude Code อ่านไฟล์นี้ทุกครั้งที่เปิด session — กฎ security ที่ใส่ไว้จะถูกนำมาใช้ทุก code generation</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: without CLAUDE.md -->
  <rect x="30" y="20" width="460" height="300" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="460" height="48" rx="12" fill="var(--danger)" opacity=".15"/>
  <text x="260" y="50" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี CLAUDE.md</text>
  <text x="260" y="100" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI generate code ตาม "best guess"</text>
  <text x="260" y="130" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">อาจใช้ service_role ใน client component</text>
  <text x="260" y="160" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">สร้าง table โดยไม่เปิด RLS</text>
  <text x="260" y="190" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">commit .env.local โดยไม่รู้ตัว</text>
  <text x="260" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ทุก session = เริ่มต้นใหม่</text>
  <text x="260" y="250" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่มี project context</text>

  <!-- Right: with CLAUDE.md -->
  <rect x="610" y="20" width="460" height="300" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="610" y="20" width="460" height="48" rx="12" fill="var(--success)" opacity=".15"/>
  <text x="840" y="50" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">มี CLAUDE.md (Security Rules)</text>
  <text x="840" y="100" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI รู้ว่า service_role ห้ามใน client</text>
  <text x="840" y="130" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">generate RLS เสมอสำหรับ table ใหม่</text>
  <text x="840" y="160" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">warning ก่อน commit sensitive files</text>
  <text x="840" y="190" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทุก session = briefed ด้วย project rules</text>
  <text x="840" y="230" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Stack, commands, conventions ครบ</text>
  <text x="840" y="250" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สร้างครั้งเดียว ใช้ทุก session</text>

  <!-- VS badge -->
  <circle cx="550" cy="170" r="28" fill="var(--accent)"/>
  <text x="550" y="175" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> CLAUDE.md ทำหน้าที่เป็น "memory injection" — AI ไม่ลืมกฎ security ของ project แม้จะเปิด session ใหม่</div>

<!-- Speaker: เน้นว่า CLAUDE.md คือ investment ครั้งเดียวที่ protect ทุก session ถัดไป -->

---

## Supabase MCP: ให้ Claude Code จัดการ DB — แต่ต้อง Dev Only

<p class="subhead">MCP เชื่อม Claude Code เข้า Supabase โดยตรง — ทรงพลังมากจนต้องระวัง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="6" refX="4" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
    <marker id="arr3" markerWidth="8" markerHeight="6" refX="4" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--danger)"/>
    </marker>
  </defs>

  <!-- Claude Code box -->
  <rect x="60" y="120" width="200" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="160" y="162" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="160" y="182" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CLI + MCP Client</text>

  <!-- Arrow to decision -->
  <line x1="260" y1="170" x2="370" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr2)"/>

  <!-- Decision diamond -->
  <polygon points="420,130 500,170 420,210 340,170" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="420" y="165" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เชื่อมกับ</text>
  <text x="420" y="180" font-size="11" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">DB ไหน?</text>

  <!-- Green path: dev -->
  <line x1="500" y1="145" x2="620" y2="80" stroke="var(--success)" stroke-width="2" marker-end="url(#arr2)"/>
  <text x="555" y="103" font-size="11" fill="var(--success-ink)" font-family="system-ui">Dev DB</text>
  <rect x="620" y="40" width="200" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="720" y="73" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Safe</text>
  <text x="720" y="93" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">query ผิด = เสียแค่ test data</text>

  <!-- Red path: prod -->
  <line x1="500" y1="195" x2="620" y2="260" stroke="var(--danger)" stroke-width="2" marker-end="url(#arr3)"/>
  <text x="555" y="243" font-size="11" fill="var(--danger-ink)" font-family="system-ui">Prod DB</text>
  <rect x="620" y="240" width="200" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="720" y="273" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Risky</text>
  <text x="720" y="293" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Prompt injection = data loss</text>

  <!-- Setup command -->
  <rect x="860" y="100" width="220" height="140" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="970" y="125" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Setup Command</text>
  <text x="880" y="153" font-size="10" fill="var(--ink-dim)" font-family="monospace">claude mcp add \</text>
  <text x="880" y="170" font-size="10" fill="var(--ink-dim)" font-family="monospace"> --transport http \</text>
  <text x="880" y="187" font-size="10" fill="var(--accent)" font-family="monospace"> mcp.supabase.com</text>
  <text x="970" y="220" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">OAuth login — dev project เท่านั้น</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> MCP ควรเชื่อมกับ dev project เสมอ — เลือก dev project ระหว่าง OAuth flow อย่าเลือก prod</div>

<!-- Speaker: อธิบาย flow — Claude Code ส่ง SQL ผ่าน MCP; ถ้าเชื่อมกับ prod แล้ว AI rephrase prompt ผิด อาจ DROP TABLE ได้ -->

---

## 4 กฎ MCP Security ที่ต้องทำทุกครั้ง

<p class="subhead">กฎเหล่านี้ป้องกัน prompt injection และ accidental data destruction ผ่าน AI</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">กฎ 1 — ห้ามเด็ดขาด</p>
    <h3>ห้ามเชื่อม Production</h3>
    <p>LLM อาจ interpret prompt ผิดและ execute destructive query เช่น DELETE หรือ DROP ต่อ real data</p>
  </div>
  <div class="card warning">
    <p class="label">กฎ 2 — สำคัญมาก</p>
    <h3>Approve ทุก Tool Call</h3>
    <p>อ่านทุก SQL ที่ Claude จะรันก่อนกด approve — AI อาจส่ง query ที่ไม่ได้ขอผ่าน chained tool calls</p>
  </div>
  <div class="card warning">
    <p class="label">กฎ 3 — แนะนำอย่างยิ่ง</p>
    <h3>ใช้ Dev Project แยก</h3>
    <p>สร้าง my-app-dev และ my-app-prod แยกกัน — ถ้า AI รัน query ผิดใน dev จะไม่กระทบ production data</p>
  </div>
  <div class="card">
    <p class="label">กฎ 4 — ถ้าจำเป็นต้อง query prod</p>
    <h3>ใช้ Read-Only Mode</h3>
    <p>เปิด read-only mode ใน MCP config — execute queries ในฐานะ read-only Postgres user ป้องกัน write operations ทั้งหมด</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> MCP เป็น developer tool ไม่ใช่ production bridge — ทำงานได้ทรงพลังมากจนต้องมี boundary ชัดเจน</div>

<!-- Speaker: เน้นว่า approve all tool calls คือ habit ที่ต้องทำทุกครั้ง ไม่ใช่แค่ครั้งแรก -->

---

## RLS คือ ปราการที่ขาดไม่ได้ เพราะ Anon Key เปิดเผยได้

<p class="subhead">Supabase design ให้ anon key อยู่ใน client-side code — RLS คือสิ่งที่จำกัดว่าใครเห็นอะไรได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Without RLS -->
  <rect x="30" y="20" width="460" height="280" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="260" y="56" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี RLS</text>
  <text x="260" y="100" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">anon key + ไม่มี policy</text>
  <text x="260" y="135" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ทุกคนอ่าน users table ได้ทั้งหมด</text>
  <text x="260" y="165" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ทุกคน DELETE posts ของคนอื่นได้</text>
  <text x="260" y="195" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ผ่านแค่ API call ด้วย anon key</text>
  <text x="260" y="240" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">curl + anon key = full access</text>

  <!-- With RLS -->
  <rect x="610" y="20" width="460" height="280" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="840" y="56" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">มี RLS + Policies</text>
  <text x="840" y="100" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">anon key + RLS policies active</text>
  <text x="840" y="135" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">user เห็นแค่ rows ของตัวเอง</text>
  <text x="840" y="165" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DELETE ได้แค่ posts ตัวเอง</text>
  <text x="840" y="195" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Postgres enforce ระดับ row ทุก query</text>
  <text x="840" y="240" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">curl + anon key = [] หรือ data ตัวเอง</text>

  <!-- VS -->
  <circle cx="550" cy="160" r="28" fill="var(--accent)"/>
  <text x="550" y="165" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า table ไม่มี RLS + policy = database เปิดให้ทุกคน query ผ่าน anon key ที่เห็นได้ใน source code</div>

<!-- Speaker: อธิบายว่า anon key is "by design public" ดังนั้น RLS คือ guard ที่ Supabase ออกแบบให้ใช้คู่กัน -->

---

## RLS Performance: (SELECT auth.uid()) เร็วกว่า auth.uid() โดยตรง

<p class="subhead">ความแตกต่างเล็กน้อยใน syntax = performance ต่างกันมากบน table ขนาดใหญ่</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Slow version -->
  <rect x="30" y="20" width="480" height="280" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="270" y="52" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Slow: auth.uid() โดยตรง</text>
  <rect x="60" y="70" width="420" height="50" rx="8" fill="var(--paper)"/>
  <text x="270" y="91" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="monospace">USING (auth.uid() = user_id)</text>
  <text x="270" y="107" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="monospace">runs function per row</text>
  <text x="270" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Postgres ถือว่าเป็น volatile expression</text>
  <text x="270" y="180" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">รัน auth.uid() ทุก row</text>
  <text x="270" y="220" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1,000,000 rows = 1,000,000 function calls</text>
  <text x="270" y="250" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Query ช้ามากบน large tables</text>

  <!-- Fast version -->
  <rect x="590" y="20" width="480" height="280" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="830" y="52" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Fast: (SELECT auth.uid())</text>
  <rect x="620" y="70" width="420" height="50" rx="8" fill="var(--paper)"/>
  <text x="830" y="91" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="monospace">USING ((SELECT auth.uid()) = user_id)</text>
  <text x="830" y="107" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="monospace">cached per statement</text>
  <text x="830" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Postgres hoist เป็น init plan</text>
  <text x="830" y="180" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">รัน auth.uid() ครั้งเดียวต่อ query</text>
  <text x="830" y="220" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1,000,000 rows = 1 function call</text>
  <text x="830" y="250" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Index ก็ต้องทำบน user_id ด้วย</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เพิ่มแค่ <code>(SELECT ...)</code> รอบ auth.uid() — Postgres optimizer cache ผล 1 ครั้งต่อ query แทนที่จะรันทุก row</div>

<!-- Speaker: อธิบาย volatile vs stable function — init plan คือ optimization ที่ Postgres ทำอัตโนมัติถ้าเราบอกให้ -->

---

## API Keys: anon vs service_role — ต่างกันราวฟ้ากับดิน

<p class="subhead">ใช้ผิดตัวแม้แค่ครั้งเดียว อาจทำให้ data รั่วทั้ง database</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- anon key card -->
  <rect x="30" y="20" width="480" height="260" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--success)" opacity=".2"/>
  <text x="270" y="52" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">anon / Publishable Key</text>
  <text x="270" y="98" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่เก็บ: Client-side code (safe)</text>
  <text x="270" y="125" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">สิทธิ์: จำกัดด้วย RLS policies</text>
  <text x="270" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">NEXT_PUBLIC_SUPABASE_ANON_KEY</text>
  <text x="270" y="200" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ถ้า leak: เห็นแค่ที่ RLS อนุญาต</text>
  <text x="270" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ออกแบบให้เปิดเผยได้ — ปลอดภัยถ้า RLS ถูกต้อง</text>

  <!-- service_role key card -->
  <rect x="590" y="20" width="480" height="260" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--danger)" opacity=".2"/>
  <text x="830" y="52" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">service_role / Secret Key</text>
  <text x="830" y="98" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ที่เก็บ: Server-side ONLY</text>
  <text x="830" y="125" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">สิทธิ์: BYPASS RLS ทั้งหมด</text>
  <text x="830" y="155" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SUPABASE_SERVICE_ROLE_KEY (no PUBLIC prefix)</text>
  <text x="830" y="200" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ถ้า leak: data รั่วทั้ง database</text>
  <text x="830" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้ใน Server Component / API route เท่านั้น</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> <code>NEXT_PUBLIC_</code> prefix = client bundle อัตโนมัติ — ห้ามใช้กับ service_role key; ห้ามใช้ชื่อที่มี PUBLIC กับ secrets</div>

<!-- Speaker: อธิบาย Next.js convention — NEXT_PUBLIC_ prefix เป็น bundle flag ที่ทำให้ var เข้า client JS -->

---

## 6 Steps สร้าง Fullstack App อย่างปลอดภัย

<p class="subhead">ทำตามลำดับนี้ครบทุก step — อย่าข้ามขั้นตอน Security</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="farr" markerWidth="8" markerHeight="6" refX="4" refY="3" orient="auto">
      <polygon points="0 0,8 3,0 6" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Step boxes and arrows -->
  <!-- S0 -->
  <rect x="10" y="100" width="150" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="85" cy="115" r="12" fill="var(--accent)"/>
  <text x="85" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">0</text>
  <text x="85" y="150" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pre-flight</text>
  <text x="85" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">node, npm,</text>
  <text x="85" y="183" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">claude CLI</text>
  <line x1="160" y1="150" x2="175" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#farr)"/>

  <!-- S1 -->
  <rect x="180" y="100" width="150" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="255" cy="115" r="12" fill="var(--accent)"/>
  <text x="255" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="255" y="150" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Supabase</text>
  <text x="255" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สร้าง 2 projects</text>
  <text x="255" y="183" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">dev + prod แยก</text>
  <line x1="330" y1="150" x2="345" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#farr)"/>

  <!-- S2 -->
  <rect x="350" y="100" width="150" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="425" cy="115" r="12" fill="var(--accent)"/>
  <text x="425" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="425" y="150" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CLAUDE.md</text>
  <text x="425" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/init + เขียน</text>
  <text x="425" y="183" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">security rules</text>
  <line x1="500" y1="150" x2="515" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#farr)"/>

  <!-- S3 -->
  <rect x="520" y="100" width="150" height="100" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <circle cx="595" cy="115" r="12" fill="var(--warning)"/>
  <text x="595" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="595" y="150" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">MCP Setup</text>
  <text x="595" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">dev project</text>
  <text x="595" y="183" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เท่านั้น</text>
  <line x1="670" y1="150" x2="685" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#farr)"/>

  <!-- S4 -->
  <rect x="690" y="100" width="150" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="765" cy="115" r="12" fill="var(--accent)"/>
  <text x="765" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="765" y="150" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Schema + RLS</text>
  <text x="765" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ผ่าน Claude Code</text>
  <text x="765" y="183" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">approve SQL ก่อน</text>
  <line x1="840" y1="150" x2="855" y2="150" stroke="var(--accent)" stroke-width="2" marker-end="url(#farr)"/>

  <!-- S5+6 combined -->
  <rect x="860" y="100" width="220" height="100" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="910" cy="115" r="12" fill="var(--success)"/>
  <text x="910" y="120" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5+6</text>
  <text x="970" y="148" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Env Vars + Test</text>
  <text x="970" y="166" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">.env.local, gitignore</text>
  <text x="970" y="181" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">curl anon key test</text>

</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Step 2 (CLAUDE.md) และ Step 3 (MCP dev-only) คือ step ที่ beginner มักข้ามแต่สำคัญที่สุด</div>

<!-- Speaker: เน้น Step 2 และ 3 เป็นพิเศษ — ถ้าข้ามสองขั้นนี้จะเจอ security issue ในทุก step ที่ตามมา -->

---

## 6 Caveats ที่ AI บอกไม่ครบ

<p class="subhead">สิ่งที่ Claude Code generate ให้ไม่ได้หมายความว่าปลอดภัยเสมอ — ต้องตรวจเอง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger compact">
    <p class="label">Caveat 1</p>
    <h3>RLS ไม่ปกป้อง server-side</h3>
    <p>service_role bypass RLS อัตโนมัติ — ต้อง validate logic เองในฝั่ง server</p>
  </div>
  <div class="card danger compact">
    <p class="label">Caveat 2</p>
    <h3>MCP + Prod = อันตราย</h3>
    <p>Supabase ยังแนะนำ dev-only อย่างเป็นทางการ — LLM อาจ interpret prompt ผิด</p>
  </div>
  <div class="card warning compact">
    <p class="label">Caveat 3</p>
    <h3>Prompt Injection via MCP</h3>
    <p>User input อาจ inject SQL ผ่าน AI ไปยัง MCP — approve every tool call</p>
  </div>
  <div class="card warning compact">
    <p class="label">Caveat 4</p>
    <h3>anon key ไม่ใช่ junk</h3>
    <p>ถ้า RLS มีช่อง attacker ใช้ anon key query ข้อมูลที่ไม่ควรเข้าถึงได้</p>
  </div>
  <div class="card warning compact">
    <p class="label">Caveat 5</p>
    <h3>Raw SQL ไม่มี RLS</h3>
    <p>Migration scripts ต้องเพิ่ม ALTER TABLE ... ENABLE ROW LEVEL SECURITY เอง</p>
  </div>
  <div class="card compact">
    <p class="label">Caveat 6</p>
    <h3>AI อาจ generate insecure</h3>
    <p>CLAUDE.md ลด chance แต่ไม่ guarantee — review generated code ก่อน push เสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI เป็น co-pilot ไม่ใช่ security auditor — final review ต้องทำเองก่อน push ทุกครั้ง</div>

<!-- Speaker: Caveat 1 คือ trap ที่พบบ่อยที่สุด — developer ใช้ service_role เพราะ "RLS ก็ enabled แล้ว" แต่ service_role bypass อยู่ดี -->

---

## Key Takeaways: สิ่งที่ต้องจำ 7 ข้อ

<p class="subhead">ถ้าจำได้ทั้ง 7 ข้อ — app ของคุณจะปลอดภัยกว่า 90% ของ beginner projects</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 7 takeaway items in two columns -->
  <!-- Left column: 4 items -->
  <rect x="30" y="15" width="490" height="52" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <circle cx="66" cy="41" r="14" fill="var(--accent)"/>
  <text x="66" y="46" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="105" y="35" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">MCP = developer tool, not production bridge</text>
  <text x="105" y="53" font-size="11" fill="var(--ink-dim)" font-family="system-ui">เชื่อม dev project เท่านั้น, approve ทุก tool call</text>

  <rect x="30" y="78" width="490" height="52" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <circle cx="66" cy="104" r="14" fill="var(--danger)"/>
  <text x="66" y="109" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="105" y="98" font-size="12" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">RLS ไม่ optional</text>
  <text x="105" y="116" font-size="11" fill="var(--ink-dim)" font-family="system-ui">ไม่มี RLS = database เปิดให้ทุกคนผ่าน anon key</text>

  <rect x="30" y="141" width="490" height="52" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <circle cx="66" cy="167" r="14" fill="var(--danger)"/>
  <text x="66" y="172" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="105" y="161" font-size="12" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">service_role bypass RLS ทั้งหมด</text>
  <text x="105" y="179" font-size="11" fill="var(--ink-dim)" font-family="system-ui">server-side เท่านั้น, ห้ามอยู่ใน client bundle</text>

  <rect x="30" y="204" width="490" height="52" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <circle cx="66" cy="230" r="14" fill="var(--muted)"/>
  <text x="66" y="235" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="105" y="224" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">CLAUDE.md คือ security anchor</text>
  <text x="105" y="242" font-size="11" fill="var(--ink-dim)" font-family="system-ui">เขียนกฎ security ไว้ชัด — AI generate ตาม pattern</text>

  <!-- Right column: 3 items -->
  <rect x="580" y="15" width="490" height="52" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <circle cx="616" cy="41" r="14" fill="var(--success)"/>
  <text x="616" y="46" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="655" y="35" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui">(SELECT auth.uid()) เร็วกว่า auth.uid()</text>
  <text x="655" y="53" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Postgres cache result ต่อ statement ไม่ใช่ต่อ row</text>

  <rect x="580" y="78" width="490" height="52" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <circle cx="616" cy="104" r="14" fill="var(--warning)"/>
  <text x="616" y="109" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">6</text>
  <text x="655" y="98" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">NEXT_PUBLIC_ prefix = client bundle อัตโนมัติ</text>
  <text x="655" y="116" font-size="11" fill="var(--ink-dim)" font-family="system-ui">ห้ามใช้กับ secrets ทุกกรณี</text>

  <rect x="580" y="141" width="490" height="52" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="616" cy="167" r="14" fill="var(--accent)"/>
  <text x="616" y="172" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">7</text>
  <text x="655" y="161" font-size="12" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">Test RLS ด้วย anon key ก่อน deploy</text>
  <text x="655" y="179" font-size="11" fill="var(--ink-dim)" font-family="system-ui">curl + anon key ต้องได้ [] ถ้า RLS ทำงานถูกต้อง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Security ไม่ใช่ขั้นตอนสุดท้าย — ต้องเป็น default ตั้งแต่ CLAUDE.md, table creation, จนถึง deployment</div>

<!-- Speaker: ปิดด้วยการ recap ว่า 3 กฎเหล็กเป็นส่วนหนึ่งของ 7 ข้อนี้ ทำให้เห็น full picture -->
