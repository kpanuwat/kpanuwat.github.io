---
marp: true
theme: default
paginate: true
title: "เจาะลึก EMS Factory EP2: Business Model & Value Chain"
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

# EMS Factory EP2: Business Model & Value Chain

<p class="tag">IP ownership, manufacturing models, margin reality — who actually profits from electronics manufacturing</p>

<!-- Speaker: EP2 focuses on the business layer — before diving into process control, understand how EMS makes money and what model fits your product. -->

---

## EMS vs ODM vs OEM: IP Ownership Is the Only Differentiator

<p class="subhead">The manufacturing method is the same — the contract determines who owns the design.</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- OEM card -->
  <rect x="30" y="20" width="320" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="30" y="20" width="320" height="52" rx="12" fill="var(--soft)"/>
  <rect x="30" y="56" width="320" height="16" fill="var(--soft)"/>
  <text x="190" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OEM</text>
  <text x="190" y="90" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Brand owner designs</text>
  <text x="190" y="115" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Brand owner owns IP</text>
  <text x="190" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">EMS manufactures</text>
  <text x="190" y="175" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Sold under brand label</text>
  <text x="190" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Example: Apple → Foxconn</text>
  <rect x="110" y="245" width="160" height="28" rx="6" fill="var(--soft-2)"/>
  <text x="190" y="263" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Brand retains full IP</text>
  <!-- ODM card (highlighted danger) -->
  <rect x="390" y="20" width="320" height="320" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="390" y="20" width="320" height="52" rx="12" fill="var(--danger-wash)"/>
  <rect x="390" y="56" width="320" height="16" fill="var(--danger-wash)"/>
  <text x="550" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ODM</text>
  <text x="550" y="90" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Manufacturer designs</text>
  <text x="550" y="115" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Manufacturer owns IP</text>
  <text x="550" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Manufacturer manufactures</text>
  <text x="550" y="175" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Sold under brand label</text>
  <text x="550" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Example: Taiwanese ODM → Many brands</text>
  <rect x="430" y="245" width="240" height="28" rx="6" fill="var(--danger-wash)"/>
  <text x="550" y="263" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">IP risk: ODM can license to competitors</text>
  <!-- EMS card (success) -->
  <rect x="750" y="20" width="320" height="320" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="750" y="20" width="320" height="52" rx="12" fill="var(--success-wash)"/>
  <rect x="750" y="56" width="320" height="16" fill="var(--success-wash)"/>
  <text x="910" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">EMS / CEM</text>
  <text x="910" y="90" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Brand owner designs</text>
  <text x="910" y="115" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Brand owner owns IP</text>
  <text x="910" y="140" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">EMS manufactures to spec</text>
  <text x="910" y="175" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Sold under brand label</text>
  <text x="910" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Example: OEM spec → CM executes</text>
  <rect x="810" y="245" width="200" height="28" rx="6" fill="var(--success-wash)"/>
  <text x="910" y="263" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Brand retains full IP control</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ODM แตกต่างจาก EMS ที่ IP ownership — ODM owns design; ถ้า relationship เปลี่ยน design ของคุณอาจเจอ competitor</div>

<!-- Speaker: The manufacturing process is identical — what changes is the contract. OEM and EMS both protect the brand's IP; ODM does not. -->

---

## Manufacturing Models: Turnkey vs Consignment vs Hybrid

<p class="subhead">เลือก model ตาม procurement capability และ supply chain risk ที่ยอมรับได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Turnkey</p>
    <h3>EMS จัดการทุกอย่าง</h3>
    <p>EMS sources components, assembles, tests, ships. OEM จ่ายต่อ unit.</p>
    <ul>
      <li>~$20–80 per board</li>
      <li>ลด working capital</li>
      <li>Shortage risk ตกที่ EMS</li>
      <li>EMS อาจ markup components</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Hybrid</p>
    <h3>OEM supply proprietary parts</h3>
    <p>OEM ส่ง IP-sensitive components; EMS source standard passives/MCU.</p>
    <ul>
      <li>ปกป้อง EE architecture</li>
      <li>ใช้ EMS scale สำหรับ commodity</li>
      <li>Automotive tier-1 นิยมใช้</li>
      <li>ซับซ้อนกว่า — ต้องประสาน 2 chains</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Consignment</p>
    <h3>OEM supply components ทั้งหมด</h3>
    <p>OEM จัดหา components ก่อน; EMS รับเฉพาะ assembly labor.</p>
    <ul>
      <li>~$5–25 per board (labor only)</li>
      <li>OEM ควบคุม supplier โดยตรง</li>
      <li>Inventory risk อยู่ที่ OEM</li>
      <li>ต้องมี procurement team</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Turnkey = สะดวก แต่ต้องจ่ายเพิ่ม; Consignment = ถูกกว่า แต่ต้องมี procurement capability; Hybrid = sweet spot สำหรับ IP-sensitive products</div>

<!-- Speaker: The model choice is fundamentally about who carries inventory risk and who has supplier leverage. Match to your org's actual capability. -->

---

## Model Selection: Decision Flow by Product Profile

<p class="subhead">Framework สำหรับเลือก manufacturing model ให้ match กับ context จริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Start node -->
  <rect x="430" y="10" width="240" height="44" rx="22" fill="var(--accent)" style="filter:drop-shadow(0 2px 6px rgba(59,130,246,.35))"/>
  <text x="550" y="37" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">มี procurement team?</text>
  <!-- Arrow down -->
  <line x1="550" y1="54" x2="550" y2="86" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="550,92 544,80 556,80" fill="var(--muted)"/>
  <!-- No branch left -->
  <line x1="430" y1="32" x2="200" y2="32" stroke="var(--muted)" stroke-width="2" stroke-dasharray="4,3"/>
  <line x1="200" y1="32" x2="200" y2="86" stroke="var(--muted)" stroke-width="2" stroke-dasharray="4,3"/>
  <polygon points="200,92 194,80 206,80" fill="var(--muted)"/>
  <text x="305" y="28" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่มี</text>
  <!-- Turnkey box -->
  <rect x="80" y="92" width="240" height="52" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="200" y="114" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Turnkey</text>
  <text x="200" y="134" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">EMS จัดการทุกอย่าง</text>
  <!-- Yes arrow down from start -->
  <text x="570" y="78" font-size="11" fill="var(--muted)" font-family="system-ui">มี</text>
  <!-- Diamond: Proprietary components? -->
  <polygon points="550,92 660,140 550,188 440,140" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="550" y="135" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">มี proprietary</text>
  <text x="550" y="152" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">components?</text>
  <!-- Yes → Hybrid -->
  <line x1="660" y1="140" x2="810" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="816,140 804,134 804,146" fill="var(--muted)"/>
  <text x="730" y="130" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">มี</text>
  <rect x="816" y="114" width="240" height="52" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="936" y="136" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Hybrid</text>
  <text x="936" y="156" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">OEM supply proprietary parts</text>
  <!-- No → Consignment -->
  <line x1="550" y1="188" x2="550" y2="220" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="550,226 544,214 556,214" fill="var(--muted)"/>
  <text x="570" y="212" font-size="11" fill="var(--muted)" font-family="system-ui">ไม่มี</text>
  <rect x="430" y="226" width="240" height="52" rx="10" fill="var(--soft-2)" stroke="var(--ink-dim)" stroke-width="1.5"/>
  <text x="550" y="248" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Consignment</text>
  <text x="550" y="268" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OEM supply all components</text>
  <!-- High reliability note -->
  <rect x="60" y="200" width="300" height="48" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1" stroke-dasharray="4,3"/>
  <text x="210" y="220" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Medical / Defense / Aerospace</text>
  <text x="210" y="238" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Hybrid + Approved Vendor List required</text>
  <!-- Arrow from Turnkey to special note -->
  <line x1="200" y1="144" x2="200" y2="200" stroke="var(--danger)" stroke-width="1" stroke-dasharray="3,3"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Startup ไม่มี procurement team → Turnkey ก่อน; Scale ขึ้นแล้วค่อย shift ไป Hybrid หรือ Consignment</div>

<!-- Speaker: This isn't prescriptive — it's a starting heuristic. The actual decision also depends on volume, lead time tolerance, and trust level with the EMS partner. -->

---

## EMS Market: $578B (2024) Growing to $909B (2031)

<p class="subhead">Consumer electronics dominates, but automotive and AI infrastructure are driving growth</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Market growth bar chart -->
  <text x="90" y="28" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Global EMS Market Size (USD Billion)</text>
  <!-- Y axis -->
  <line x1="100" y1="50" x2="100" y2="290" stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- X axis -->
  <line x1="100" y1="290" x2="740" y2="290" stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- Y gridlines -->
  <line x1="100" y1="230" x2="740" y2="230" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4,3"/>
  <line x1="100" y1="170" x2="740" y2="170" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4,3"/>
  <line x1="100" y1="110" x2="740" y2="110" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="4,3"/>
  <text x="90" y="234" font-size="11" fill="var(--muted)" text-anchor="end" font-family="system-ui">400</text>
  <text x="90" y="174" font-size="11" fill="var(--muted)" text-anchor="end" font-family="system-ui">600</text>
  <text x="90" y="114" font-size="11" fill="var(--muted)" text-anchor="end" font-family="system-ui">800</text>
  <text x="90" y="294" font-size="11" fill="var(--muted)" text-anchor="end" font-family="system-ui">200</text>
  <!-- Bars: scale 200=290, 900=50, range=240px for 700B, 1B = 240/700 = 0.343px -->
  <!-- 2024: 578B → height=(578-200)*240/700=129.4, y=290-129=161 -->
  <rect x="135" y="161" width="70" height="129" rx="4" fill="var(--accent)" opacity=".7"/>
  <text x="170" y="155" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">$578B</text>
  <text x="170" y="305" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2024</text>
  <!-- 2026: 663B → h=(663-200)*240/700=158.6, y=290-159=131 -->
  <rect x="235" y="131" width="70" height="159" rx="4" fill="var(--accent)" opacity=".8"/>
  <text x="270" y="125" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">$663B</text>
  <text x="270" y="305" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2026</text>
  <!-- 2028 projected: ~760B → h=(760-200)*240/700=192, y=290-192=98 -->
  <rect x="335" y="98" width="70" height="192" rx="4" fill="var(--accent)" opacity=".85"/>
  <text x="370" y="92" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">~$760B</text>
  <text x="370" y="305" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2028E</text>
  <!-- 2031: 909B → h=(909-200)*240/700=243, y=290-243=47 -->
  <rect x="435" y="47" width="70" height="243" rx="4" fill="var(--accent)"/>
  <text x="470" y="41" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">$909B</text>
  <text x="470" y="305" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2031E</text>
  <!-- CAGR label -->
  <rect x="540" y="120" width="180" height="40" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="630" y="136" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">CAGR 6.51%</text>
  <text x="630" y="152" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">2026–2031</text>
  <!-- Segment breakdown donut placeholder — legend -->
  <text x="780" y="50" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">2024 Revenue Mix</text>
  <rect x="780" y="68" width="14" height="14" rx="3" fill="var(--accent)"/>
  <text x="800" y="80" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Consumer Electronics 42%</text>
  <rect x="780" y="90" width="14" height="14" rx="3" fill="var(--warning)"/>
  <text x="800" y="102" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Industrial / IoT</text>
  <rect x="780" y="112" width="14" height="14" rx="3" fill="var(--success)"/>
  <text x="800" y="124" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Automotive (CAGR 8.27%)</text>
  <rect x="780" y="134" width="14" height="14" rx="3" fill="var(--danger)"/>
  <text x="800" y="146" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Medical / Defense</text>
  <rect x="780" y="156" width="14" height="14" rx="3" fill="var(--gold)"/>
  <text x="800" y="168" font-size="12" fill="var(--ink-dim)" font-family="system-ui">AI Infrastructure (fastest growing)</text>
  <!-- Tier annotation -->
  <rect x="770" y="200" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="920" y="222" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tier Concentration</text>
  <text x="920" y="244" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Top 5 players: 35–40% market share</text>
  <text x="920" y="264" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Foxconn alone: >40% of EMS segment</text>
  <text x="920" y="284" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Long tail: thousands of tier-2/3 EMS</text>
  <text x="920" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Mordor Intelligence 2024</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Market โตแต่ต้องระวัง segment — automotive และ AI infrastructure เติบโตเร็วกว่า consumer electronics มาก</div>

<!-- Speaker: The total market size is massive, but growth is not uniform. Consumer electronics is mature; AI server and automotive are where EMS players are pivoting. -->

---

## Margin Reality: Volume Kills Margin, Specialization Saves It

<p class="subhead">Foxconn คือ case study ที่ชัดที่สุด — >40% market share ได้ ~2.5% operating margin</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Horizontal bar chart — operating margins -->
  <text x="550" y="25" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Operating Margin by EMS Player (2024)</text>
  <!-- Y labels -->
  <text x="185" y="72" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Pegatron</text>
  <text x="185" y="112" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Foxconn</text>
  <text x="185" y="152" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Jabil</text>
  <text x="185" y="192" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Flex</text>
  <text x="185" y="232" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Sanmina</text>
  <text x="185" y="272" font-size="13" fill="var(--ink)" text-anchor="end" font-family="system-ui">Celestica</text>
  <!-- Scale: 0% at x=200, 7% at x=760 → 1% = 80px -->
  <!-- X axis labels -->
  <line x1="200" y1="290" x2="760" y2="290" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="200" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">0%</text>
  <text x="280" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1%</text>
  <text x="360" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2%</text>
  <text x="440" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3%</text>
  <text x="520" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">4%</text>
  <text x="600" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5%</text>
  <text x="680" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">6%</text>
  <text x="760" y="306" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">7%</text>
  <!-- Gridlines -->
  <line x1="280" y1="40" x2="280" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="360" y1="40" x2="360" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="440" y1="40" x2="440" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="520" y1="40" x2="520" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="600" y1="40" x2="600" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="680" y1="40" x2="680" y2="290" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="3,3"/>
  <!-- Bars: 1% = 80px from x=200 -->
  <!-- Pegatron: 1.5% → w=120 -->
  <rect x="200" y="52" width="120" height="28" rx="4" fill="var(--danger)" opacity=".75"/>
  <text x="328" y="70" font-size="12" font-weight="700" fill="var(--danger)" font-family="system-ui"> ~1.5%</text>
  <!-- Foxconn: 2.5% → w=200 -->
  <rect x="200" y="92" width="200" height="28" rx="4" fill="var(--warning)" opacity=".8"/>
  <text x="408" y="110" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui"> ~2.5%</text>
  <!-- Jabil: 4.0% → w=320 -->
  <rect x="200" y="132" width="320" height="28" rx="4" fill="var(--accent)" opacity=".7"/>
  <text x="528" y="150" font-size="12" font-weight="700" fill="var(--accent)" font-family="system-ui"> 3.5–4.5%</text>
  <!-- Flex: 4.2% → w=336 -->
  <rect x="200" y="172" width="336" height="28" rx="4" fill="var(--accent)" opacity=".8"/>
  <text x="544" y="190" font-size="12" font-weight="700" fill="var(--accent)" font-family="system-ui"> ~4.2%</text>
  <!-- Sanmina: 6.0% → w=480 -->
  <rect x="200" y="212" width="480" height="28" rx="4" fill="var(--success)" opacity=".75"/>
  <text x="688" y="230" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui"> ~6.0%</text>
  <!-- Celestica: 6.2% → w=496 -->
  <rect x="200" y="252" width="496" height="28" rx="4" fill="var(--success)"/>
  <text x="704" y="270" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui"> ~6.2%</text>
  <!-- Strategy legend -->
  <rect x="800" y="55" width="280" height="180" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="940" y="78" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Strategy drives margin</text>
  <text x="815" y="102" font-size="12" fill="var(--danger-ink)" font-family="system-ui">Volume + consumer = thin margin</text>
  <text x="815" y="122" font-size="12" fill="var(--warning-ink)" font-family="system-ui">Foxconn: scale is the moat</text>
  <text x="815" y="150" font-size="12" fill="var(--success-ink)" font-family="system-ui">JDM + AI infra = margin expansion</text>
  <text x="815" y="170" font-size="12" fill="var(--success-ink)" font-family="system-ui">Celestica: hyperscaler programs</text>
  <text x="815" y="198" font-size="12" fill="var(--accent)" font-family="system-ui">Medical/defense: 15–25% premium</text>
  <text x="815" y="218" font-size="12" fill="var(--muted)" font-family="system-ui">over commodity assembly</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Celestica มี margin สูงกว่า Foxconn 2.5x เพราะ JDM + AI segments — volume alone ≠ profitability</div>

<!-- Speaker: This is the most counter-intuitive insight about EMS. The largest players by market share are NOT the most profitable. Specialization is the lever. -->

---

## Cost Structure: 60–75% is Components — Everything Else is Noise

<p class="subhead">ความเข้าใจ cost structure ช่วย OEM ตั้งความคาดหวังและ negotiate ได้ถูกจุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Cost Structure (% of revenue)</p>
    <h3>Components dominate</h3>
    <p><b style="color:var(--danger)">60–75%</b> — Components / Materials</p>
    <p><b style="color:var(--warning)">10–15%</b> — Labor</p>
    <p><b style="color:var(--accent)">8–12%</b> — Manufacturing overhead</p>
    <p><b style="color:var(--ink-dim)">3–5%</b> — G&A + Sales</p>
    <p><b style="color:var(--success)">2–7%</b> — Operating margin (tier + segment dependent)</p>
  </div>
  <div class="card danger">
    <p class="label">Key Cost Risks</p>
    <h3>ปัจจัยที่ทำให้ margin หาย</h3>
    <ul>
      <li><b>Component spot price volatility</b> — ไม่มี allocation contracts = margin crush ทันที</li>
      <li><b>NRE fees</b> — tooling, stencil, custom test setup คิดแยก ไม่รวมใน unit price</li>
      <li><b>Rush order premium</b> — 20–50% เหนือ standard lead time</li>
      <li><b>FX exposure</b> — USD revenue แต่จ่าย labor/utilities ใน local currency</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า component spot price กระโดดโดยไม่มี long-term allocation — EMS margin หดก่อน, แต่ OEM จะถูก pass ต้นทุนในรอบ PO ถัดไป</div>

<!-- Speaker: This is why EMS players obsess over supply chain. At 65% COGS in components, a 10% spot price increase wipes out the entire operating margin. -->

---

## Key Takeaways: Business Model Shapes Every Operational Decision

<p class="subhead">เข้าใจ business layer ก่อน — แล้วค่อย optimize process layer</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">What we covered</p>
    <h3>Business Model Clarity</h3>
    <ul>
      <li>OEM vs ODM vs EMS แยกกันที่ IP ownership ไม่ใช่ process</li>
      <li>Turnkey ~$20–80/board vs Consignment ~$5–25/board (labor only)</li>
      <li>Hybrid = sweet spot สำหรับ IP-sensitive + scale ต้องการ</li>
      <li>EMS market $578B → $909B (2031), CAGR 6.51%</li>
      <li>Foxconn >40% share แต่ ~2.5% margin — specialization wins</li>
      <li>60–75% cost = components — spot volatility คือ P&L risk อันดับ 1</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">How to apply</p>
    <h3>Before Choosing an EMS Partner</h3>
    <ul>
      <li>Check IP clauses ใน contract ก่อน — ถ้า ODM ต้องมี audit rights</li>
      <li>Match tier ให้ตรง product type — tier-1 = high-volume consumer; tier-2/3 = complex/regulated</li>
      <li>Verify model fit — Startup → Turnkey; Scale → Hybrid/Consignment</li>
      <li>ถาม EMS ว่ามี long-term allocation contracts กับ distributors หรือไม่</li>
      <li>ถาม NRE + rush premium rates ก่อนเปรียบเทียบ unit price</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EP3 จะ zoom-in ลงลึก SMT process engineering: stencil aperture, paste rheology, และ SPC implementation</div>

<!-- Speaker: The business model framing sets context for everything in future EPs. Process control matters more when you understand why EMS partners are incentivized to cut corners. -->
