---
marp: true
theme: default
paginate: true
title: "ISO 56001:2024 EP3 — Context, Stakeholders และ Leadership"
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

---

<!-- _class: title -->

<div class="mark"></div>

# ISO 56001:2024 EP3
# Context, Stakeholders และ Leadership

<p class="tag">Clauses 4-5 คือ "ทิศทาง" ของ IMS — กำหนดว่าจะ innovate ทำไม และไปทิศทางไหน</p>

<!-- Speaker: EP3 เจาะ foundation ที่สำคัญที่สุด — ถ้า context ไม่ชัดและ leadership ไม่ commit ระบบในภายหลังจะ fail -->

---

## Clause 4: วิเคราะห์บริบทรอบด้านก่อนสร้าง IMS

<p class="subhead">PESTLE (external) + SWOT (internal) — ต้องทำซ้ำทุกปีเพราะ context เปลี่ยน</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="490" height="52" rx="14" fill="var(--soft)"/>
  <text x="285" y="52" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">External Factors (PESTLE)</text>
  <text x="70" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Competitive landscape</text>
  <text x="70" y="128" font-size="13" fill="var(--muted)" font-family="system-ui">   คู่แข่ง innovate ในทิศทางไหน?</text>
  <text x="70" y="160" font-size="14" fill="var(--ink)" font-family="system-ui">Technology trends</text>
  <text x="70" y="183" font-size="13" fill="var(--muted)" font-family="system-ui">   เทคโนโลยีอะไรกำลัง disrupt?</text>
  <text x="70" y="215" font-size="14" fill="var(--ink)" font-family="system-ui">Market dynamics</text>
  <text x="70" y="238" font-size="13" fill="var(--muted)" font-family="system-ui">   ลูกค้าต้องการอะไรที่ยังไม่มี?</text>
  <text x="70" y="270" font-size="14" fill="var(--ink)" font-family="system-ui">Regulatory environment</text>
  <text x="70" y="293" font-size="13" fill="var(--muted)" font-family="system-ui">   กฎใดเปิด/ปิด opportunity?</text>
  <rect x="570" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="815" y="52" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Internal Factors (SWOT)</text>
  <text x="600" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Innovation capabilities จริง</text>
  <text x="600" y="128" font-size="13" fill="var(--muted)" font-family="system-ui">   ไม่ใช่ที่คิดว่ามี</text>
  <text x="600" y="160" font-size="14" fill="var(--ink)" font-family="system-ui">Knowledge assets และ IP</text>
  <text x="600" y="183" font-size="13" fill="var(--muted)" font-family="system-ui">   patents, trade secrets, data</text>
  <text x="600" y="215" font-size="14" fill="var(--ink)" font-family="system-ui">Culture: Psychological Safety</text>
  <text x="600" y="238" font-size="13" fill="var(--muted)" font-family="system-ui">   คนกล้า fail และเรียนรู้ไหม?</text>
  <text x="600" y="270" font-size="14" fill="var(--ink)" font-family="system-ui">Resource constraints</text>
  <text x="600" y="293" font-size="13" fill="var(--muted)" font-family="system-ui">   คน เงิน เวลา ที่มีจริง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Clause 4 ต้องทำซ้ำทุกปี — context เปลี่ยน ถ้าทำครั้งเดียวแล้วไม่ update ข้อมูลจะ stale และ IMS จะ mis-aligned</div>

---

## Stakeholder Map: ครอบทุกกลุ่ม รวมถึง "Blockers"

<p class="subhead">Clause 4.2 กำหนดให้ map stakeholders ทั้งหมด — กลุ่มที่มักถูกลืมคือคนที่มีอำนาจบล็อก innovation</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep3-context-leadership-1.png" alt="ISO 56001 stakeholder ecosystem map internal and external">
<figcaption>Source: NotebookLM · Stakeholder map: Internal (management, teams, R&D, BU, HR, finance) + External (customers, partners, investors, regulatory, academia)</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Stakeholder map ต้องรวม "blockers" — คนที่มีอำนาจหยุด innovation มักถูกลืมในการ map แต่สำคัญที่สุด</div>

---

## Strategic Intent: จุดตัดของ Context + Leadership

<p class="subhead">ไม่มี Strategic Intent ที่ชัดเจน → innovation แบบ bottom-up only → teams ทำในสิ่งที่ตัวเองสนใจ ไม่ใช่สิ่งที่ business ต้องการ</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="20" width="420" height="300" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="60" y="20" width="420" height="52" rx="14" fill="var(--soft)"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Where to Play (Clause 4)</text>
  <text x="90" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Which markets?</text>
  <text x="90" y="133" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Which customers?</text>
  <text x="90" y="161" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Which technologies?</text>
  <text x="90" y="189" font-size="14" fill="var(--muted)" font-family="system-ui">Which time horizon?</text>
  <circle cx="550" cy="170" r="75" fill="var(--accent)" opacity=".15"/>
  <circle cx="550" cy="170" r="55" fill="var(--accent)" opacity=".25"/>
  <text x="550" y="162" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">STRATEGIC</text>
  <text x="550" y="182" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">INTENT</text>
  <rect x="620" y="20" width="420" height="300" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="620" y="20" width="420" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">How to Win (Clause 5)</text>
  <text x="650" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">What capabilities needed?</text>
  <text x="650" y="133" font-size="14" fill="var(--ink-dim)" font-family="system-ui">What processes to build?</text>
  <text x="650" y="161" font-size="14" fill="var(--ink-dim)" font-family="system-ui">What partnerships required?</text>
  <text x="650" y="189" font-size="14" fill="var(--muted)" font-family="system-ui">What risk level acceptable?</text>
  <path d="M550 248 L550 305 L550 340" stroke="var(--accent)" stroke-width="2" stroke-dasharray="6,4" marker-end="url(#arr3)"/>
  <defs><marker id="arr3" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto"><polygon points="0 0,10 3.5,0 7" fill="var(--accent)"/></marker></defs>
  <text x="550" y="332" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="600">Innovation Portfolio (Clause 6)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Strategic Intent กำหนด "why and where to innovate" — ขาดสิ่งนี้ innovation จะ scattered ไม่ตอบ business goal</div>

---

## Clause 5: Innovation Policy ที่ดีต้องระบุ Risk Appetite

<p class="subhead">Policy ที่บอกแค่ "เราสนับสนุน innovation" ไม่มีความหมาย — ต้องระบุ % ที่ลงทุน, % ที่ยอมให้ fail, และ learning obligation</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="20" width="980" height="280" rx="16" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="20" width="980" height="8" rx="4" fill="var(--accent)"/>
  <text x="120" y="75" font-size="14" fill="var(--muted)" font-family="system-ui">ตัวอย่าง Innovation Policy ที่ดี:</text>
  <text x="120" y="115" font-size="18" font-weight="700" fill="var(--ink)" font-family="system-ui">"เราจะลงทุน 15% ของรายได้ใน innovation portfolio</text>
  <text x="120" y="145" font-size="18" font-weight="700" fill="var(--ink)" font-family="system-ui">ที่ครอบทั้ง incremental (60%) และ radical (40%)</text>
  <text x="120" y="185" font-size="18" fill="var(--ink-dim)" font-family="system-ui">โดยยอมรับว่า 30% ของ initiatives อาจไม่สำเร็จ</text>
  <text x="120" y="215" font-size="18" fill="var(--ink-dim)" font-family="system-ui">แต่ทุก failure ต้องสร้าง learning ที่ documented"</text>
  <rect x="120" y="245" width="220" height="32" rx="8" fill="var(--success-wash)"/>
  <text x="230" y="266" font-size="13" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Specific allocation</text>
  <rect x="360" y="245" width="220" height="32" rx="8" fill="var(--accent-wash)"/>
  <text x="470" y="266" font-size="13" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui" font-weight="600">Clear risk appetite</text>
  <rect x="600" y="245" width="240" height="32" rx="8" fill="var(--warning-wash)"/>
  <text x="720" y="266" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Learning commitment</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Leadership commitment วัดจากพฤติกรรมเวลา budget tight — ไม่ใช่เวลา slide presentation</div>

---

## Innovation Culture: 5 เสาหลักที่ Leadership ต้องสร้าง

<p class="subhead">Clause 5 กำหนดให้ leadership สร้าง enabling environment — culture เปลี่ยนช้า ต้องใช้ 2-3 ปีและ consistency</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/iso56001-2024-ep3-context-leadership-2.png" alt="Innovation culture five pillars framework">
<figcaption>Source: NotebookLM · 5 pillars: Psychological Safety, Tolerance for Failure, Cross-functional Collaboration, Resource Availability, Recognition Systems</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Culture เปลี่ยนช้า — ประกาศ policy ไม่ได้เปลี่ยนทันที ต้องมี consistent leadership behavior 2-3 ปี</div>

---

## Key Takeaways — EP3 Context & Leadership

<p class="subhead">Foundation ที่ต้องแข็งก่อน Clauses 6-8 จะทำงานได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Clause 4</p>
    <h3>Context ต้องทำซ้ำทุกปี</h3>
    <p>PESTLE + SWOT ทำครั้งเดียวแล้วลืม = IMS mis-aligned กับ reality ปัจจุบัน</p>
  </div>
  <div class="card warning">
    <p class="label">Stakeholder Map</p>
    <h3>อย่าลืม Blockers</h3>
    <p>คนที่มีอำนาจหยุด innovation มักถูกลืมในการ map แต่เป็นตัวแปรสำคัญที่สุด</p>
  </div>
  <div class="card success">
    <p class="label">Strategic Intent</p>
    <h3>Why + Where ก่อน How</h3>
    <p>Strategic Intent คือจุดตัดของ Context × Leadership — กำหนดก่อนวาง portfolio</p>
  </div>
  <div class="card gold">
    <p class="label">Innovation Policy</p>
    <h3>Risk Appetite ต้องชัด</h3>
    <p>ระบุ % ลงทุน, % ยอมให้ fail, learning obligation — ไม่ใช่แค่ "เราสนับสนุน innovation"</p>
  </div>
  <div class="card danger">
    <p class="label">Culture</p>
    <h3>เริ่มก่อน System</h3>
    <p>ระบบที่ดีในองค์กรที่กลัว failure จะไม่ถูกใช้จริง — culture ต้องพร้อมก่อน</p>
  </div>
  <div class="card">
    <p class="label">Clause 5 Roles</p>
    <h3>Innovation Manager ต้องมี Mandate</h3>
    <p>Chief Innovation Officer / Innovation Champion ต้องมีอำนาจจริง ไม่ใช่แค่ title</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP4 จะเจาะ Clause 6: Innovation Portfolio Planning — วิธีแปล Strategic Intent เป็น portfolio ที่ balance</div>
