---
marp: true
theme: default
paginate: true
title: "Project Management เบื้องต้น สำหรับงาน SI"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:26px; margin:0 0 4px 0; color:var(--ink); line-height:1.2; }
  .subhead { color:var(--muted); font-size:15px; margin:0 0 6px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:11px 16px; border-radius:0 8px 8px 0; font-size:14px; margin-top:6px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; min-height:0; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; justify-content:center; gap:16px; }
  section.title h1 { font-size:42px; color:white; margin:0; line-height:1.2; }
  section.title p { color:#93c5fd; margin:0; font-size:18px; }
---

<!-- _class: title -->

# Project Management เบื้องต้น สำหรับงาน SI

**PM คือ "กาว" ที่ประสาน Business, IT, และ Vendors ทุกฝ่าย**

<p>ครอบคลุม: Hybrid Agile-Waterfall · 5 Phases (PMBOK) · SOW/BRD/RTM/SIT · Go-Live Checklist · Top Pitfalls</p>

<!-- Speaker note: SI = multi-vendor, multi-system, multi-owner. Normal software PM practices are not enough. This deck is self-contained — no presenter needed. -->

---

## TL;DR: SI ต้องอาศัยสามเสาร์จึงจะ Go-Live ผ่านโดยไม่มี surprise

<p class="subhead">ขาดเสาใดเสาหนึ่ง — timeline เลื่อน, scope บาน, หรือ go-live ล้มเหลว</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Pillar 1 -->
  <rect x="30" y="20" width="325" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="30" y="20" width="325" height="56" rx="12" fill="var(--accent)" opacity="0.12"/>
  <rect x="30" y="64" width="325" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="50" y="52" font-size="17" font-weight="700" fill="var(--accent)" font-family="system-ui">⚙ Hybrid PM Framework</text>
  <text x="50" y="105" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Waterfall → Vendor Contracts + Specs</text>
  <text x="50" y="130" font-size="13" fill="var(--muted)" font-family="system-ui">ต้องกำหนดชัดก่อน vendor เริ่มงาน</text>
  <text x="50" y="155" font-size="13" fill="var(--muted)" font-family="system-ui">เปลี่ยนทีหลังแพง — vendor อ้าง SOW</text>
  <text x="50" y="195" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Agile → Dev, Testing, Bug Fixes</text>
  <text x="50" y="220" font-size="13" fill="var(--muted)" font-family="system-ui">ต้องปรับได้เมื่อพบ integration issues</text>
  <text x="50" y="245" font-size="13" fill="var(--muted)" font-family="system-ui">sprints ช่วยให้ทีมดูดซับ change ได้</text>
  <!-- Pillar 2 -->
  <rect x="387" y="20" width="325" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="387" y="20" width="325" height="56" rx="12" fill="var(--accent)" opacity="0.12"/>
  <rect x="387" y="64" width="325" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="407" y="52" font-size="17" font-weight="700" fill="var(--accent)" font-family="system-ui">📋 Key Deliverables</text>
  <text x="407" y="105" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">SOW — scope + timeline กับทุก vendor</text>
  <text x="407" y="130" font-size="13" fill="var(--muted)" font-family="system-ui">BRD — business goals → tech requirements</text>
  <text x="407" y="155" font-size="13" fill="var(--muted)" font-family="system-ui">RTM — ทุก requirement → test case → delivery</text>
  <text x="407" y="195" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">SIT Plan + Go-Live Checklist</text>
  <text x="407" y="220" font-size="13" fill="var(--muted)" font-family="system-ui">SIT → scope/approach/entry-exit criteria</text>
  <text x="407" y="245" font-size="13" fill="var(--muted)" font-family="system-ui">Go-Live → UAT sign-off + rollback ready</text>
  <!-- Pillar 3 -->
  <rect x="744" y="20" width="325" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="744" y="20" width="325" height="56" rx="12" fill="var(--accent)" opacity="0.12"/>
  <rect x="744" y="64" width="325" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="764" y="52" font-size="17" font-weight="700" fill="var(--accent)" font-family="system-ui">✓ Vendor Discipline</text>
  <text x="764" y="105" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">SPOC ทุก vendor — 1 คนรับผิดชอบ</text>
  <text x="764" y="130" font-size="13" fill="var(--muted)" font-family="system-ui">ป้องกัน "ถามใครก็ไม่รู้" เมื่อมีปัญหา</text>
  <text x="764" y="155" font-size="13" fill="var(--muted)" font-family="system-ui">escalation path ต้องตกลงตั้งแต่วันแรก</text>
  <text x="764" y="195" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Real Transactions — ไม่ใช่แค่ API 200</text>
  <text x="764" y="220" font-size="13" fill="var(--muted)" font-family="system-ui">ทดสอบ EDI, banking, CRM ด้วย data จริง</text>
  <text x="764" y="245" font-size="13" fill="var(--muted)" font-family="system-ui">API 200 ≠ integration ทำงานถูกต้อง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Hybrid framework + ครบทุก deliverable + vendor discipline = สูตรป้องกัน SI failure ที่พบบ่อยที่สุด</div>

<!-- Speaker note: Three things separate successful SI from failed ones. Missing any pillar creates a gap that surfaces at go-live. -->

---

## SI Projects ล้มเหลวบ่อยกว่า เพราะมี 3 ความเสี่ยงที่ Software Project ปกติไม่เจอ

<p class="subhead">ไม่ใช่ technical skill ขาด — แต่ coordination complexity สูงกว่ามาก</p>

<div class="infographic">
<svg viewBox="0 0 1100 330" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Challenge 1: Multi-vendor -->
  <rect x="30" y="20" width="325" height="290" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="20" width="6" height="290" rx="3" fill="var(--accent)"/>
  <circle cx="112" cy="78" r="32" fill="var(--accent)" opacity="0.1"/>
  <circle cx="112" cy="78" r="32" fill="none" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="112" y="78" font-size="20" text-anchor="middle" dominant-baseline="central" font-family="system-ui">🔗</text>
  <text x="165" y="64" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Multi-vendor</text>
  <text x="165" y="88" font-size="13" fill="var(--muted)" font-family="system-ui">Coordination</text>
  <text x="52" y="142" font-size="13" fill="var(--ink)" font-family="system-ui">แต่ละ vendor มี agenda, tool,</text>
  <text x="52" y="163" font-size="13" fill="var(--ink)" font-family="system-ui">และ SLA ต่างกัน</text>
  <text x="52" y="200" font-size="12" fill="var(--muted)" font-family="system-ui">ประสานงานผิดพลาดครั้งเดียว</text>
  <text x="52" y="220" font-size="12" fill="var(--muted)" font-family="system-ui">→ timeline ทั้งโปรเจกต์เลื่อน</text>
  <text x="52" y="258" font-size="12" fill="var(--accent)" font-family="system-ui" font-style="italic">แก้: SPOC + formal escalation path</text>
  <text x="52" y="278" font-size="12" fill="var(--accent)" font-family="system-ui" font-style="italic">ตั้งแต่ kickoff</text>
  <!-- Challenge 2: Integration risk -->
  <rect x="387" y="20" width="325" height="290" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="387" y="20" width="6" height="290" rx="3" fill="var(--danger)"/>
  <circle cx="469" cy="78" r="32" fill="var(--danger)" opacity="0.1"/>
  <circle cx="469" cy="78" r="32" fill="none" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="469" y="78" font-size="20" text-anchor="middle" dominant-baseline="central" font-family="system-ui">⚠</text>
  <text x="522" y="64" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Integration Risk</text>
  <text x="522" y="88" font-size="13" fill="var(--muted)" font-family="system-ui">Hidden at join points</text>
  <text x="409" y="142" font-size="13" fill="var(--ink)" font-family="system-ui">จุดเชื่อมต่อระหว่างระบบคือ</text>
  <text x="409" y="163" font-size="13" fill="var(--ink)" font-family="system-ui">จุดที่ bugs ซ่อนตัวได้มากที่สุด</text>
  <text x="409" y="200" font-size="12" fill="var(--muted)" font-family="system-ui">ระบบแต่ละตัวผ่าน unit test แต่</text>
  <text x="409" y="220" font-size="12" fill="var(--muted)" font-family="system-ui">พอเชื่อมกันแล้วมีปัญหา</text>
  <text x="409" y="258" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">แก้: SIT ด้วย real transactions</text>
  <text x="409" y="278" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">ไม่ใช่แค่ API handshake</text>
  <!-- Challenge 3: Scope creep -->
  <rect x="744" y="20" width="325" height="290" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="744" y="20" width="6" height="290" rx="3" fill="var(--danger)"/>
  <circle cx="826" cy="78" r="32" fill="var(--danger)" opacity="0.1"/>
  <circle cx="826" cy="78" r="32" fill="none" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="826" y="78" font-size="20" text-anchor="middle" dominant-baseline="central" font-family="system-ui">📈</text>
  <text x="879" y="64" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Scope Creep</text>
  <text x="879" y="88" font-size="13" fill="var(--muted)" font-family="system-ui">Risk #1 ใน SI</text>
  <text x="766" y="142" font-size="13" fill="var(--ink)" font-family="system-ui">Stakeholders เห็นความต้องการจริง</text>
  <text x="766" y="163" font-size="13" fill="var(--ink)" font-family="system-ui">หลังจากเห็นระบบทำงาน</text>
  <text x="766" y="200" font-size="12" fill="var(--muted)" font-family="system-ui">requirement เพิ่มระหว่างทาง</text>
  <text x="766" y="220" font-size="12" fill="var(--muted)" font-family="system-ui">โดยไม่ได้วางแผน → budget บาน</text>
  <text x="766" y="258" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">แก้: SOW ชัดเจน + ทุก change</text>
  <text x="766" y="278" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">ต้องผ่าน CCB ก่อน implement</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 3 ความเสี่ยงนี้เป็น process failures — PM ที่จัดการได้ทั้ง 3 ข้อป้องกัน failure mode ที่พบบ่อยที่สุดใน SI</div>

<!-- Speaker note: These are structural, not technical. A skilled PM prevents all three without writing a single line of code. -->

---

## SI Project ต้องการ Coordination มากกว่า Software Project ทั่วไป

<p class="subhead">ใน SI ไม่ได้ควบคุมทุก piece — แต่ต้องรับผิดชอบทั้งระบบ</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Software Project card -->
  <rect x="30" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="58" rx="12" fill="var(--muted)" opacity="0.12"/>
  <rect x="30" y="66" width="480" height="12" fill="var(--muted)" opacity="0.12"/>
  <text x="270" y="53" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Software Project</text>
  <text x="58" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">• ทีมเขียน code เอง — ควบคุม codebase ได้เต็มที่</text>
  <text x="58" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">• Deploy / rollback ทำได้ทันทีเมื่อต้องการ</text>
  <text x="58" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">• 1 codebase, 1 owner, 1 pipeline</text>
  <text x="58" y="200" font-size="14" fill="var(--ink)" font-family="system-ui">• Integration risk ต่ำ — ทีมเดียวดู end-to-end</text>
  <text x="58" y="250" font-size="13" fill="var(--muted)" font-family="system-ui" font-style="italic">Coordination overhead: ต่ำ</text>
  <text x="58" y="272" font-size="13" fill="var(--muted)" font-family="system-ui" font-style="italic">PM focus: delivery speed + quality</text>
  <!-- VS -->
  <circle cx="550" cy="170" r="30" fill="var(--accent)"/>
  <text x="550" y="170" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- SI Project card -->
  <rect x="590" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="58" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="590" y="66" width="480" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="830" y="53" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SI Project</text>
  <text x="618" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">• หลาย Vendors — แต่ละเจ้ามี agenda และ SLA ต่างกัน</text>
  <text x="618" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">• แต่ละระบบมี owner ต่างกัน — deploy ไม่ได้ตามใจ</text>
  <text x="618" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">• Integration points = จุดเสี่ยงสูงสุด ต้องดูแลพิเศษ</text>
  <text x="618" y="200" font-size="14" fill="var(--ink)" font-family="system-ui">• Scope creep สูง — stakeholders เห็น "ของจริง" ทีหลัง</text>
  <text x="618" y="250" font-size="13" fill="var(--accent)" font-family="system-ui" font-style="italic">Coordination overhead: สูงมาก</text>
  <text x="618" y="272" font-size="13" fill="var(--accent)" font-family="system-ui" font-style="italic">PM focus: coordination + formal process</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PM ใน SI ต้องมองภาพรวมทุก subsystem และทุก vendor — ไม่ใช่แค่ track tasks ของทีมตัวเอง</div>

<!-- Speaker note: The key insight is ownership boundaries. In software, PM owns everything. In SI, PM coordinates across many ownership boundaries. -->

---

## Hybrid Agile-Waterfall: แต่ละส่วนของ SI ต้องการ Approach ต่างกัน

<p class="subhead">ไม่ใช่เลือกอันใดอันหนึ่ง — แต่รู้ว่าส่วนไหนต้องการ structure และส่วนไหนต้องการ flexibility</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Waterfall card -->
  <rect x="30" y="15" width="490" height="310" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="30" y="15" width="490" height="58" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="30" y="61" width="490" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="275" y="48" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Waterfall — ใช้เมื่อต้องการความชัดเจน</text>
  <text x="58" y="102" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ Vendor contracts + SOW</text>
  <text x="58" y="125" font-size="13" fill="var(--muted)" font-family="system-ui">   scope ต้องชัดก่อน vendor sign — เปลี่ยนทีหลังแพง</text>
  <text x="58" y="158" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ Integration architecture + BRD</text>
  <text x="58" y="181" font-size="13" fill="var(--muted)" font-family="system-ui">   ระบบแต่ละตัวต้องรู้ interface ก่อนเริ่ม develop</text>
  <text x="58" y="214" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ RTM + SIT Plan + Phase gates</text>
  <text x="58" y="237" font-size="13" fill="var(--muted)" font-family="system-ui">   gate ชัดเจน = ทุกฝ่าย agree ก่อนก้าวหน้า</text>
  <text x="58" y="290" font-size="12" fill="var(--accent)" font-family="system-ui" font-style="italic">เปลี่ยน scope หลัง sign SOW → impact analysis + CCB ก่อนเสมอ</text>
  <!-- Agile card -->
  <rect x="580" y="15" width="490" height="310" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="580" y="15" width="490" height="58" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="580" y="61" width="490" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="825" y="48" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Agile — ใช้เมื่อต้องการ flexibility</text>
  <text x="608" y="102" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ Custom development (sprints)</text>
  <text x="608" y="125" font-size="13" fill="var(--muted)" font-family="system-ui">   ทีมดูดซับ requirement changes ระหว่าง sprints</text>
  <text x="608" y="158" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ Integration testing iterations</text>
  <text x="608" y="181" font-size="13" fill="var(--muted)" font-family="system-ui">   พบ integration bug → fix → retest รอบเดียวกัน</text>
  <text x="608" y="214" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">✓ Bug fixes + retrospectives</text>
  <text x="608" y="237" font-size="13" fill="var(--muted)" font-family="system-ui">   ปรับ process ทุก sprint ตาม lessons learned</text>
  <text x="608" y="290" font-size="12" fill="var(--accent)" font-family="system-ui" font-style="italic">Agile ไม่ได้แปลว่า "ไม่มี process" — ยังต้องมี sprint goals ชัดเจน</text>
  <!-- Connector -->
  <text x="550" y="178" font-size="26" font-weight="700" fill="var(--accent)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">+</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ Waterfall ล็อค vendor contracts และ integration specs — ใช้ Agile ให้ development team ปรับตัวกับ integration surprises</div>

<!-- Speaker note: Not a choice. Both coexist. The Waterfall layer prevents vendor disputes; the Agile layer absorbs the inevitable integration surprises. -->

---

## PMBOK 5 Phases: Roadmap ของ SI Project ตั้งแต่ Charter จนถึง Hypercare

<p class="subhead">ทุก SI project ผ่าน 5 phases นี้ — ต่างกันแค่ depth ตาม complexity ของโปรเจกต์</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="9" markerHeight="7" refX="8" refY="3.5" orient="auto">
      <path d="M0,0 8,3.5 0,7" fill="#94a3b8"/>
    </marker>
  </defs>
  <!-- Phase 1: Initiating -->
  <rect x="20" y="80" width="170" height="80" rx="10" fill="var(--accent)"/>
  <text x="105" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Initiating</text>
  <text x="105" y="135" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.9">Project Charter</text>
  <text x="105" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 1</text>
  <text x="105" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Authorize +</text>
  <text x="105" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Identify stakeholders</text>
  <line x1="192" y1="120" x2="218" y2="120" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Phase 2: Planning -->
  <rect x="220" y="80" width="170" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="305" y="113" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Planning</text>
  <text x="305" y="135" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SOW, BRD, RTM</text>
  <text x="305" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 2</text>
  <text x="305" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Roadmap +</text>
  <text x="305" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">4 Deliverables</text>
  <line x1="392" y1="120" x2="418" y2="120" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Phase 3: Executing -->
  <rect x="420" y="80" width="170" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="505" y="113" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Executing</text>
  <text x="505" y="135" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Vendors + Dev</text>
  <text x="505" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 3</text>
  <text x="505" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Coordinate +</text>
  <text x="505" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Verify interfaces</text>
  <line x1="592" y1="120" x2="618" y2="120" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Phase 4: Monitoring -->
  <rect x="620" y="80" width="170" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="705" y="107" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Monitoring</text>
  <text x="705" y="127" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">&amp; Controlling</text>
  <text x="705" y="148" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CCB + Tracking</text>
  <text x="705" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 4</text>
  <text x="705" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Track + Adjust +</text>
  <text x="705" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Manage changes</text>
  <line x1="792" y1="120" x2="818" y2="120" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr)"/>
  <!-- Phase 5: Closing -->
  <rect x="820" y="80" width="170" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="905" y="113" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Closing</text>
  <text x="905" y="135" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Go-Live + Hypercare</text>
  <text x="905" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 5</text>
  <text x="905" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">UAT sign-off +</text>
  <text x="905" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Rollback ready</text>
  <!-- Note -->
  <text x="550" y="278" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PMBOK ออกแบบมาให้ flexible — SI projects ขนาดเล็กอาจใช้เพียงบางส่วน ปรับ scope ตาม complexity</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 5 phases ไม่ใช่ waterfall rigid — แต่ phase gate แต่ละจุดช่วยให้ทุก vendor และทุก team agree ก่อนก้าวหน้า</div>

<!-- Speaker note: Key is knowing what's SI-specific at each phase. Most project failures trace to skipping a phase gate or treating it as checkbox rather than real review. -->

---

## Phase 1 — Initiating: Authorize โปรเจกต์ + ระบุ Stakeholders ทุกฝ่าย

<p class="subhead">จุดที่ทำก่อนเสมอ: รู้ว่าใครเป็น owner ของอะไร และใครต้องเซ็น</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="6" refX="7" refY="3" orient="auto">
      <path d="M0,0 7,3 0,6" fill="#94a3b8"/>
    </marker>
  </defs>
  <!-- PM at top center -->
  <rect x="440" y="20" width="220" height="60" rx="10" fill="var(--accent)"/>
  <text x="550" y="55" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Project Manager (PM)</text>
  <!-- Lines to stakeholders -->
  <line x1="460" y1="80" x2="140" y2="165" stroke="#94a3b8" stroke-width="1.5" marker-end="url(#arr2)"/>
  <line x1="510" y1="80" x2="390" y2="165" stroke="#94a3b8" stroke-width="1.5" marker-end="url(#arr2)"/>
  <line x1="590" y1="80" x2="710" y2="165" stroke="#94a3b8" stroke-width="1.5" marker-end="url(#arr2)"/>
  <line x1="640" y1="80" x2="960" y2="165" stroke="#94a3b8" stroke-width="1.5" marker-end="url(#arr2)"/>
  <!-- Sponsor box -->
  <rect x="30" y="165" width="220" height="70" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="140" y="195" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sponsors</text>
  <text x="140" y="217" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Budget + Go/No-go authority</text>
  <!-- Vendors box -->
  <rect x="280" y="165" width="220" height="70" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="390" y="195" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Vendors</text>
  <text x="390" y="217" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Delivery + SPOC per vendor</text>
  <!-- IT Teams box -->
  <rect x="600" y="165" width="220" height="70" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="710" y="195" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">IT Teams</text>
  <text x="710" y="217" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Architecture + API readiness</text>
  <!-- Business owners box -->
  <rect x="850" y="165" width="220" height="70" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="960" y="195" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Business Owners</text>
  <text x="960" y="217" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Requirements + UAT sign-off</text>
  <!-- SI-specific tasks -->
  <rect x="30" y="264" width="1040" height="60" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1" opacity="0.8"/>
  <text x="60" y="288" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">SI-specific tasks ใน Initiating:</text>
  <text x="60" y="310" font-size="13" fill="var(--ink)" font-family="system-ui">① ระบุทุก vendor + system ที่ต้องเชื่อมต่อ   ② ประเมิน API readiness แต่ละระบบ (documentation มีไหม? API พร้อมไหม?)   ③ จัดทำ Project Charter + high-level budget</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Initiating ที่ดีคือการรู้ว่าใครเป็น SPOC ของอะไร — ก่อนเริ่มงานจริง ไม่ใช่หาทีหลังเมื่อปัญหาเกิด</div>

<!-- Speaker note: Most SI teams skip a proper Initiating phase. They find out 3 months in that Vendor B's API isn't documented or the system owner left. -->

---

## Phase 2 — Planning: 4 Deliverables ที่ขาดไม่ได้ในทุก SI Project

<p class="subhead">ขาดชิ้นใดชิ้นหนึ่ง — ช่องว่างนั้นจะโผล่ขึ้นมาในช่วง testing หรือ go-live</p>

<div class="infographic">
<svg viewBox="0 0 1100 330" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- SOW -->
  <rect x="20" y="20" width="510" height="140" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="20" y="20" width="510" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="20" y="54" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="44" y="47" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">SOW — Statement of Work</text>
  <text x="44" y="88" font-size="13" font-weight="600" fill="var(--ink)" font-family="system-ui">Scope + Deliverables + Timelines + Acceptance criteria</text>
  <text x="44" y="112" font-size="13" fill="var(--muted)" font-family="system-ui">ป้องกัน scope creep และสร้าง accountability ชัดเจนกับทุก vendor</text>
  <text x="44" y="134" font-size="13" fill="var(--muted)" font-family="system-ui">เปลี่ยนหลัง sign → impact analysis + CCB approval ก่อนทุกครั้ง</text>
  <!-- BRD -->
  <rect x="570" y="20" width="510" height="140" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="570" y="20" width="510" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="570" y="54" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="594" y="47" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">BRD — Business Requirements Document</text>
  <text x="594" y="88" font-size="13" font-weight="600" fill="var(--ink)" font-family="system-ui">As-Is → To-Be process mapping</text>
  <text x="594" y="112" font-size="13" fill="var(--muted)" font-family="system-ui">แปลง business goals เป็น technical requirements ที่ vendor ใช้งานได้</text>
  <text x="594" y="134" font-size="13" fill="var(--muted)" font-family="system-ui">ทุก vendor เห็นภาพเดียวกัน — ลด "ผมเข้าใจต่างออกไป" หลัง implement</text>
  <!-- RTM -->
  <rect x="20" y="178" width="510" height="140" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="20" y="178" width="510" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="20" y="212" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="44" y="205" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">RTM — Requirements Traceability Matrix</text>
  <text x="44" y="247" font-size="13" font-weight="600" fill="var(--ink)" font-family="system-ui">Requirement → Test Case → Deliverable mapping</text>
  <text x="44" y="271" font-size="13" fill="var(--muted)" font-family="system-ui">ยืนยันว่าทุก requirement ถูก implement และ test ครบถ้วน</text>
  <text x="44" y="293" font-size="13" fill="var(--muted)" font-family="system-ui">Critical ใน SI เพราะ requirements มาจากหลาย vendors พร้อมกัน</text>
  <!-- SIT Plan -->
  <rect x="570" y="178" width="510" height="140" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="570" y="178" width="510" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="570" y="212" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="594" y="205" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">SIT Plan — System Integration Test Plan</text>
  <text x="594" y="247" font-size="13" font-weight="600" fill="var(--ink)" font-family="system-ui">Scope + Approach + Schedule + Entry/Exit criteria</text>
  <text x="594" y="271" font-size="13" fill="var(--muted)" font-family="system-ui">Entry: unit tests ผ่าน + test env พร้อม + test data prepared</text>
  <text x="594" y="293" font-size="13" fill="var(--muted)" font-family="system-ui">Exit: pass rate ยอมรับได้ + real transactions ทดสอบครบ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SOW ป้องกัน vendor disputes — RTM ยืนยันว่าไม่มี requirement หลุด — ขาดอันใดอันหนึ่งคือ technical debt ที่รอ explode ใน SIT</div>

<!-- Speaker note: Each of these serves a specific gap. SOW without RTM means you deliver everything but can't prove it. RTM without SIT Plan means you know what to test but not how or when. -->

---

## Phase 3 — Executing: ประสาน Vendor + Verify ก่อน Trust ทุกครั้ง

<p class="subhead">อย่า assume ว่า vendor ทำถูกต้อง — verify interface ก่อน integration test เสมอ</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr3" markerWidth="10" markerHeight="8" refX="9" refY="4" orient="auto">
      <path d="M0,0 9,4 0,8" fill="#94a3b8"/>
    </marker>
  </defs>
  <!-- Step 1 -->
  <rect x="20" y="80" width="220" height="130" rx="12" fill="var(--accent)" opacity="0.9"/>
  <text x="130" y="120" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">① Vendor Report</text>
  <text x="130" y="145" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.9">รับ progress report</text>
  <text x="130" y="166" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.9">ตาม SOW milestones</text>
  <text x="130" y="191" font-size="11" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.75">ถาม: deliverable</text>
  <text x="130" y="207" font-size="11" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.75">ครบตาม spec ไหม?</text>
  <line x1="242" y1="145" x2="278" y2="145" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr3)"/>
  <!-- Step 2 -->
  <rect x="280" y="80" width="220" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="390" y="120" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">② PM Verifies</text>
  <text x="390" y="145" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ตรวจ interface ตาม</text>
  <text x="390" y="166" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">spec — ไม่ใช่แค่ถาม</text>
  <text x="390" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">API contract, data</text>
  <text x="390" y="207" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">format, field mapping</text>
  <line x1="502" y1="145" x2="538" y2="145" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr3)"/>
  <!-- Step 3 -->
  <rect x="540" y="80" width="220" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="650" y="120" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">③ Real Data Test</text>
  <text x="650" y="145" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ทดสอบด้วย production</text>
  <text x="650" y="166" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">-like data ไม่ใช่ mock</text>
  <text x="650" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EDI, banking, CRM</text>
  <text x="650" y="207" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">transactions จริง</text>
  <line x1="762" y1="145" x2="798" y2="145" stroke="#94a3b8" stroke-width="2.5" marker-end="url(#arr3)"/>
  <!-- Step 4 -->
  <rect x="800" y="80" width="280" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="940" y="120" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">④ Phase Gate Review</text>
  <text x="940" y="145" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ทุกฝ่าย agree ก่อน</text>
  <text x="940" y="166" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ก้าวสู่ phase ถัดไป</text>
  <text x="940" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">pass gate = เดินหน้า</text>
  <text x="940" y="207" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">fail gate = fix ก่อน</text>
  <!-- Warning box -->
  <rect x="20" y="240" width="1060" height="58" rx="8" fill="var(--danger)" opacity="0.07" stroke="var(--danger)" stroke-width="1"/>
  <text x="50" y="266" font-size="13" font-weight="700" fill="var(--danger)" font-family="system-ui">⚠ SI-specific concern:</text>
  <text x="240" y="266" font-size="13" fill="var(--ink)" font-family="system-ui">เตรียม test data ที่ simulate production scenarios จริง ไม่ใช่แค่ happy path</text>
  <text x="50" y="288" font-size="13" fill="var(--muted)" font-family="system-ui">Unhappy paths (ข้อมูลผิดรูปแบบ, timeout, partial failure) ต้องทดสอบด้วย — มักเจอปัญหาที่นี่</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Vendor บอกว่าเสร็จแล้ว" ≠ เสร็จแล้ว — PM ต้อง verify interface ด้วยตัวเองก่อน integration test ทุกครั้ง</div>

<!-- Speaker note: Vendor trust but verify. Most integration surprises happen between step 2 and 3 — the spec says one thing, the implementation does another. -->

---

## Phase 4 — Monitoring: ทุก Change Request ต้องผ่าน Formal CCB ก่อน

<p class="subhead">Change Control Board (CCB) ป้องกัน scope creep — ทุก change ต้องมี impact analysis ก่อน approve</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr4" markerWidth="10" markerHeight="8" refX="9" refY="4" orient="auto">
      <path d="M0,0 9,4 0,8" fill="#94a3b8"/>
    </marker>
    <marker id="arr4g" markerWidth="10" markerHeight="8" refX="9" refY="4" orient="auto">
      <path d="M0,0 9,4 0,8" fill="#22c55e"/>
    </marker>
    <marker id="arr4r" markerWidth="10" markerHeight="8" refX="9" refY="4" orient="auto">
      <path d="M0,0 9,4 0,8" fill="#ef4444"/>
    </marker>
  </defs>
  <!-- Change Request -->
  <rect x="20" y="100" width="190" height="80" rx="10" fill="var(--accent)" opacity="0.9"/>
  <text x="115" y="133" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Change Request</text>
  <text x="115" y="157" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.9">จาก vendor / stakeholder</text>
  <line x1="212" y1="140" x2="248" y2="140" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr4)"/>
  <!-- Impact Analysis -->
  <rect x="250" y="100" width="200" height="80" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="350" y="133" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Impact Analysis</text>
  <text x="350" y="157" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">scope / timeline / cost</text>
  <line x1="452" y1="140" x2="488" y2="140" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr4)"/>
  <!-- CCB -->
  <rect x="490" y="80" width="200" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="590" y="120" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CCB Review</text>
  <text x="590" y="145" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Change Control Board</text>
  <text x="590" y="165" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PM + Sponsor + Tech Lead</text>
  <text x="590" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">vote: approve / reject</text>
  <!-- Approve branch -->
  <line x1="692" y1="115" x2="770" y2="80" stroke="#22c55e" stroke-width="2" marker-end="url(#arr4g)"/>
  <rect x="772" y="40" width="200" height="80" rx="10" fill="var(--paper)" stroke="#22c55e" stroke-width="2"/>
  <text x="872" y="75" font-size="13" font-weight="700" fill="#22c55e" text-anchor="middle" font-family="system-ui">✓ Approved</text>
  <text x="872" y="98" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Update SOW + RTM + schedule</text>
  <!-- Reject branch -->
  <line x1="692" y1="165" x2="770" y2="200" stroke="#ef4444" stroke-width="2" marker-end="url(#arr4r)"/>
  <rect x="772" y="178" width="200" height="80" rx="10" fill="var(--paper)" stroke="#ef4444" stroke-width="2"/>
  <text x="872" y="213" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ Rejected</text>
  <text x="872" y="236" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Document reason + notify requester</text>
  <!-- Rule box -->
  <rect x="20" y="240" width="1060" height="50" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <text x="50" y="260" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">Integration Tracker:</text>
  <text x="210" y="260" font-size="13" fill="var(--ink)" font-family="system-ui">ทำ tracker แยก — ติดตาม integration points ที่ยังไม่ complete ทุก vendor</text>
  <text x="50" y="280" font-size="13" fill="var(--muted)" font-family="system-ui">Monitor vendor performance vs contract terms — อย่ารอให้ deadline ผ่านแล้วค่อย escalate</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก change ที่ไม่ผ่าน CCB คือ scope creep ที่รอโผล่ในรูปแบบ budget overrun หรือ timeline เลื่อน</div>

<!-- Speaker note: CCB doesn't need to be bureaucratic. For small changes, async vote via email works. The key is that no change goes in without impact analysis. -->

---

## Phase 5 — Closing: Go-Live ต้องผ่าน 5 Checkpoints ก่อน Cutover

<p class="subhead">verbal OK ไม่พอ — ทุก item ต้องมีหลักฐาน sign-off ชัดเจน</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Item 1 -->
  <rect x="30" y="20" width="1040" height="48" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="68" cy="44" r="16" fill="var(--accent)"/>
  <text x="68" y="44" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="102" y="38" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">UAT sign-off จาก business owners ทุกฝ่าย</text>
  <text x="102" y="57" font-size="12" fill="var(--muted)" font-family="system-ui">ต้องได้ลายเซ็นจริง ไม่ใช่แค่ "ดูแล้วโอเคนะ" — verbal OK ไม่ถือว่า accept</text>
  <!-- Item 2 -->
  <rect x="30" y="78" width="1040" height="48" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="68" cy="102" r="16" fill="var(--accent)"/>
  <text x="68" y="102" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="102" y="96" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">SIT completion — real transactions end-to-end</text>
  <text x="102" y="115" font-size="12" fill="var(--muted)" font-family="system-ui">ไม่ใช่แค่ connectivity test — EDI pipelines, banking connections, CRM sync ต้องผ่าน production-like scenarios</text>
  <!-- Item 3 -->
  <rect x="30" y="136" width="1040" height="48" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="68" cy="160" r="16" fill="var(--accent)"/>
  <text x="68" y="160" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="102" y="154" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Data migration validation</text>
  <text x="102" y="173" font-size="12" fill="var(--muted)" font-family="system-ui">verify ข้อมูลหลัง migrate ครบและถูกต้อง — record counts, checksums, sample spot-check</text>
  <!-- Item 4 -->
  <rect x="30" y="194" width="1040" height="48" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="68" cy="218" r="16" fill="var(--accent)"/>
  <text x="68" y="218" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="102" y="212" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Rollback plan + Cutover criteria ชัดเจน</text>
  <text x="102" y="231" font-size="12" fill="var(--muted)" font-family="system-ui">กำหนดล่วงหน้าว่า "fail condition" คืออะไร — ถ้าเกิดขึ้นจะ rollback อย่างไร และใครตัดสินใจ</text>
  <!-- Item 5 -->
  <rect x="30" y="252" width="1040" height="36" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="68" cy="270" r="16" fill="var(--accent)"/>
  <text x="68" y="270" font-size="14" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="102" y="267" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Hypercare support model</text>
  <text x="102" y="282" font-size="12" fill="var(--muted)" font-family="system-ui">ใครดู support กี่วันหลัง go-live, escalation path ถ้ามี critical bug</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Go-live ที่ล้มเหลวส่วนใหญ่ trace กลับมาที่ข้อ 2 — SIT ที่ทดสอบ connectivity ไม่ใช่ real transactions</div>

<!-- Speaker note: Real transactions means production-like data volumes, edge cases, and actual business flows. Not just "the API endpoint responds." -->

---

## Tools ที่ SI PM ใช้: แบ่งตาม 4 Functions

<p class="subhead">เลือก tool ตาม function — integration ระหว่าง tools สำคัญเท่ากับตัว tool เอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Planning quadrant -->
  <rect x="20" y="20" width="510" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="20" y="20" width="510" height="44" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="20" y="52" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="46" y="44" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">📅 Project Planning</text>
  <text x="46" y="86" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">MS Project</text>
  <text x="170" y="86" font-size="13" fill="var(--muted)" font-family="system-ui">High-level Gantt + milestones + vendor timelines</text>
  <text x="46" y="110" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Jira</text>
  <text x="100" y="110" font-size="13" fill="var(--muted)" font-family="system-ui">Sprint-level tasks + bug tracking + backlog</text>
  <text x="46" y="134" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Monday.com</text>
  <text x="180" y="134" font-size="13" fill="var(--muted)" font-family="system-ui">Cross-team timeline visibility + dependency tracking</text>
  <!-- Docs quadrant -->
  <rect x="570" y="20" width="510" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="570" y="20" width="510" height="44" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="570" y="52" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="596" y="44" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">📝 Documentation &amp; Collaboration</text>
  <text x="596" y="86" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Confluence</text>
  <text x="720" y="86" font-size="13" fill="var(--muted)" font-family="system-ui">BRD, SIT Plan, RTM, meeting notes central repo</text>
  <text x="596" y="110" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">SharePoint</text>
  <text x="722" y="110" font-size="13" fill="var(--muted)" font-family="system-ui">Document versioning + stakeholder access control</text>
  <text x="596" y="134" font-size="13" fill="var(--muted)" font-family="system-ui">ใช้ 1 platform เท่านั้น — หลายที่ = documents หลุดหายและ version เก่า</text>
  <!-- Testing quadrant -->
  <rect x="20" y="168" width="510" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="20" y="168" width="510" height="44" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="20" y="200" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="46" y="192" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">🧪 Test Management</text>
  <text x="46" y="234" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">TestRail</text>
  <text x="150" y="234" font-size="13" fill="var(--muted)" font-family="system-ui">Test case management + SIT execution tracking</text>
  <text x="46" y="258" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Jira Test Mgmt</text>
  <text x="210" y="258" font-size="13" fill="var(--muted)" font-family="system-ui">Link test cases ≡ Jira issues (RTM-ready)</text>
  <text x="46" y="282" font-size="13" fill="var(--muted)" font-family="system-ui">track pass/fail rate ต่อ integration point — ไม่ใช่แค่ overall pass rate</text>
  <!-- Comm quadrant -->
  <rect x="570" y="168" width="510" height="130" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="570" y="168" width="510" height="44" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="570" y="200" width="510" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="596" y="192" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">💬 Communication</text>
  <text x="596" y="234" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">Teams / Slack</text>
  <text x="730" y="234" font-size="13" fill="var(--muted)" font-family="system-ui">Daily sync + async update + vendor channels</text>
  <text x="596" y="258" font-size="14" font-weight="600" fill="var(--ink)" font-family="system-ui">MOM (Minutes of Meeting)</text>
  <text x="596" y="282" font-size="13" fill="var(--muted)" font-family="system-ui">บันทึก decisions + action items + owner ทุก meeting — ป้องกัน "ไม่ได้ตกลงกันแบบนั้น"</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> บาง organization ใช้ MS Project สำหรับ high-level และ Jira สำหรับ task-level — ถ้าใช้สองตัวต้องมี sync strategy ป้องกัน data drift</div>

<!-- Speaker note: Tools amplify PM process but don't replace it. A bad process with great tools is still a bad process. -->

---

## Top 3 Pitfalls: Process Failures ที่ทำให้ SI Go-Live ล้มเหลวบ่อยที่สุด

<p class="subhead">ทั้ง 3 ข้อไม่ใช่ technical — PM ที่จัดการได้ทั้ง 3 ป้องกัน failure mode ที่พบบ่อยที่สุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Pitfall 1 -->
  <rect x="20" y="20" width="1060" height="78" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="20" y="20" width="8" height="78" rx="4" fill="var(--danger)"/>
  <text x="46" y="50" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Integration testing ≠ Connectivity testing</text>
  <text x="46" y="72" font-size="13" fill="var(--muted)" font-family="system-ui">API response 200 ไม่ได้หมายความว่าระบบ integrate ถูกต้อง — ต้องทดสอบด้วย real transactions end-to-end เสมอ</text>
  <text x="46" y="90" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">ตัวอย่าง: API รับ order แล้ว "OK" แต่ inventory system ไม่ได้ deduct stock จริง — พบแค่หลัง go-live</text>
  <!-- Pitfall 2 -->
  <rect x="20" y="114" width="1060" height="78" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="20" y="114" width="8" height="78" rx="4" fill="var(--danger)"/>
  <text x="46" y="144" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Scope creep ป้องกันได้ด้วย SOW + Formal CCB</text>
  <text x="46" y="166" font-size="13" fill="var(--muted)" font-family="system-ui">ทุก change request ต้องมี impact analysis + Change Control Board approval ก่อน implement ทุกครั้ง</text>
  <text x="46" y="184" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">ตัวอย่าง: "เพิ่มฟิลด์นิดเดียว" กลายเป็น 3 sprints งานและต้องแก้ RTM และ SIT ทั้งหมด</text>
  <!-- Pitfall 3 -->
  <rect x="20" y="208" width="1060" height="78" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="20" y="208" width="8" height="78" rx="4" fill="var(--danger)"/>
  <text x="46" y="238" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">ไม่มี SPOC ทำให้ Vendor Coordination ล้มเหลว</text>
  <text x="46" y="260" font-size="13" fill="var(--muted)" font-family="system-ui">แต่ละ vendor ต้องมี Single Point of Contact + escalation path ชัดเจน — กำหนดใน kickoff ไม่ใช่ตอนปัญหาเกิด</text>
  <text x="46" y="278" font-size="12" fill="var(--danger)" font-family="system-ui" font-style="italic">ตัวอย่าง: bug พบใน SIT — ถามใครก็บอก "ถามอีกคน" → ปัญหาค้างอยู่ 2 สัปดาห์โดยไม่มีใครรับผิดชอบ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 3 pitfall แก้ได้ด้วย process — ไม่ใช่ technical skill: real transaction test, formal CCB, และ SPOC ตั้งแต่ kickoff</div>

<!-- Speaker note: Each of these has a true story behind it. Share one if presenting live. Most SI go-live failures are caused by one of these three. -->

---

## Key Takeaways: PM ใน SI คือ Coordinator ไม่ใช่แค่ Task Tracker

<p class="subhead">6 ข้อสรุปที่ต้องจำเพื่อจัดการ SI project ให้ผ่านตั้งแต่ Initiation จนถึง Hypercare</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Concentric rings: Core = PM = กาว -->
  <circle cx="200" cy="150" r="145" fill="none" stroke="var(--muted)" stroke-width="1" opacity="0.3"/>
  <circle cx="200" cy="150" r="100" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity="0.4"/>
  <circle cx="200" cy="150" r="58" fill="var(--accent)" opacity="0.12"/>
  <circle cx="200" cy="150" r="58" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="200" y="143" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">PM</text>
  <text x="200" y="163" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">= กาว</text>
  <!-- Middle ring labels -->
  <text x="200" y="62" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Hybrid Framework</text>
  <text x="200" y="242" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Real Transactions</text>
  <text x="70" y="120" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SOW+BRD</text>
  <text x="70" y="136" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">RTM+SIT</text>
  <text x="332" y="128" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CCB</text>
  <!-- Outer ring labels -->
  <text x="70" y="60" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SPOC</text>
  <text x="330" y="60" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Tools</text>
  <text x="42" y="188" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Gate Reviews</text>
  <!-- 6 Takeaway bullets -->
  <rect x="400" y="10" width="680" height="280" rx="12" fill="var(--soft)"/>
  <text x="430" y="44" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">① SI ต้องประสาน vendors + systems + stakeholders</text>
  <text x="430" y="64" font-size="12" fill="var(--muted)" font-family="system-ui">   PM คือ "กาว" — ต้องมองภาพรวมทุก subsystem</text>
  <text x="430" y="95" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">② Hybrid Agile-Waterfall เหมาะกับ SI</text>
  <text x="430" y="115" font-size="12" fill="var(--muted)" font-family="system-ui">   Waterfall สำหรับ vendor contracts, Agile สำหรับ dev/testing</text>
  <text x="430" y="146" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">③ Deliverables ที่ขาดไม่ได้: SOW → BRD → RTM → SIT</text>
  <text x="430" y="166" font-size="12" fill="var(--muted)" font-family="system-ui">   ขาดชิ้นใดชิ้นหนึ่งคือ gap ที่รอโผล่ใน testing</text>
  <text x="430" y="197" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">④ Integration test ต้องใช้ real transactions</text>
  <text x="430" y="217" font-size="12" fill="var(--muted)" font-family="system-ui">   API 200 ≠ integration ถูกต้อง — failure พบบ่อยสุดคือข้อนี้</text>
  <text x="430" y="248" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">⑤ Scope creep: ป้องกันด้วย SOW + formal CCB</text>
  <text x="430" y="268" font-size="12" fill="var(--muted)" font-family="system-ui">   ทุก change ต้องผ่าน impact analysis ก่อน approve</text>
  <text x="430" y="285" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">⑥ กำหนด SPOC ทุก vendor ตั้งแต่ kickoff</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SI PM ที่ประสบความสำเร็จไม่ใช่คนที่เก่ง tech ที่สุด — แต่คือคนที่ทำให้ทุกฝ่ายเดินไปทิศทางเดียวกันได้</div>

<!-- Speaker note: If you remember one thing — SI PM is about coordination and formal process, not technical delivery. The frameworks exist to make coordination reliable. -->
