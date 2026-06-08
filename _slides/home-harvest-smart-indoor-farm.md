---
marp: true
theme: default
paginate: true
title: "Home Harvest: Smart Indoor Farm"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f0fdf4; --soft-2:#dcfce7;
    --accent:#16a34a; --accent-deep:#14532d; --accent-wash:#dcfce7; --gold:#d4af37;
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
    background:linear-gradient(135deg,#052e16 0%,var(--accent-deep) 60%,#166534 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.22](assets/home-harvest-smart-indoor-farm-cover.png)

<div class="mark"></div>

# Home Harvest
# Smart Indoor Farm

<p class="tag">ปลูกสลัดสดได้ใน 8 วัน — seed mat + full automation</p>

<!-- Speaker: UK agri-tech startup solving the 70% supply chain waste problem with a countertop hydroponic farm. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/home-harvest-smart-indoor-farm-cheatsheet.png)

<!-- Speaker: Full deck at a glance — 5 zones: how it works, specs, seed mat, env impact, AI roadmap. -->

---

## What is Home Harvest?

<p class="subhead">A soil-free smart farm that fits on your kitchen counter and delivers fresh greens in 8 days.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">สิ่งที่มันทำ</p>
    <h3>Smart Indoor Farm</h3>
    <p>เครื่องปลูกผักไร้ดิน (hydroponics) ควบคุมแสง น้ำ อุณหภูมิ และความชื้นอัตโนมัติผ่านแอปฯ ไม่ต้องมีความรู้เรื่องการปลูกพืช</p>
  </div>
  <div class="card gold">
    <p class="label">ทำไมมันสำคัญ</p>
    <h3>70% Less Food Waste</h3>
    <p>ผักสลัดในซูเปอร์มาร์เก็ต 70% สูญเสียก่อนถึงมือผู้บริโภค — Home Harvest ย้ายการปลูกมาในครัวตรงๆ ไม่มีขนส่ง ไม่มีของเหลือ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Drop in a seed mat, add water, open the app — harvest fresh salad in 8 days, no gardening skill needed.</div>

<!-- Speaker: The pitch in two cards. Left: what the machine does. Right: why it matters now. -->

---

## Supply Chain Broken: 70% of Salad Never Reaches You

![bg right:40% contain](assets/home-harvest-smart-indoor-farm-supply-chain.png)

<p class="subhead">UK imports ~1,000 salad trucks/week from Southern Europe and Africa — 400 trucks' worth is discarded.</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison: traditional supply chain vs home harvest -->
  <rect x="20" y="20" width="300" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="20" y="20" width="300" height="48" rx="12" fill="#fee2e2"/>
  <text x="170" y="50" font-size="14" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Traditional Chain</text>
  <text x="50" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">Farm (Spain/Morocco)</text>
  <text x="50" y="125" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Pack + Refrigerate</text>
  <text x="50" y="150" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Long-haul Transport</text>
  <text x="50" y="175" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Warehouse + Distribution</text>
  <text x="50" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Supermarket Shelf</text>
  <text x="50" y="240" font-size="13" font-weight="700" fill="var(--danger)" font-family="system-ui">70% wasted along the way</text>
  <rect x="380" y="20" width="300" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="380" y="20" width="300" height="48" rx="12" fill="var(--success-wash)"/>
  <text x="530" y="50" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Home Harvest</text>
  <text x="410" y="105" font-size="12" fill="var(--ink)" font-family="system-ui">Seed Mat (A5, pre-seeded)</text>
  <text x="410" y="135" font-size="12" fill="var(--ink)" font-family="system-ui">Insert + Add Water</text>
  <text x="410" y="165" font-size="12" fill="var(--ink)" font-family="system-ui">App Auto-controls</text>
  <text x="410" y="195" font-size="12" fill="var(--ink)" font-family="system-ui">Harvest in 8 days</text>
  <text x="410" y="240" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">0% wasted — pick what you eat</text>
  <circle cx="350" cy="150" r="22" fill="var(--ink)"/>
  <text x="350" y="155" font-size="11" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Every salad you grow at home eliminates an entire supply chain that wastes 70% of what it moves.</div>

<!-- Speaker: The problem is systemic, not a UK edge case. 1,000 trucks/week, 400 discarded. -->

---

## How It Works: 4 Steps, No Expertise Needed

<p class="subhead">Soil-free, mess-free. The system manages light, water, temperature, and humidity automatically.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 4 steps -->
  <!-- Step boxes -->
  <rect x="40" y="80" width="200" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="80" width="200" height="6" rx="3" fill="var(--accent)"/>
  <circle cx="140" cy="138" r="24" fill="var(--accent)" opacity=".12"/>
  <circle cx="140" cy="138" r="18" fill="var(--accent)"/>
  <text x="140" y="143" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="140" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Insert Seed Mat</text>
  <text x="140" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">A5 fabric, pre-seeded</text>
  <text x="140" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ fertilizer built in</text>
  <!-- Arrow 1 -->
  <polygon points="272,155 295,145 295,165" fill="var(--accent)" opacity=".6"/>
  <rect x="252" y="152" width="43" height="6" rx="3" fill="var(--accent)" opacity=".4"/>
  <!-- Step 2 -->
  <rect x="307" y="80" width="200" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="307" y="80" width="200" height="6" rx="3" fill="var(--accent)"/>
  <circle cx="407" cy="138" r="24" fill="var(--accent)" opacity=".12"/>
  <circle cx="407" cy="138" r="18" fill="var(--accent)"/>
  <text x="407" y="143" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="407" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Add Water</text>
  <text x="407" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">System auto-doses</text>
  <text x="407" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">nutrients + timing</text>
  <!-- Arrow 2 -->
  <polygon points="539,155 562,145 562,165" fill="var(--accent)" opacity=".6"/>
  <rect x="519" y="152" width="43" height="6" rx="3" fill="var(--accent)" opacity=".4"/>
  <!-- Step 3 -->
  <rect x="574" y="80" width="200" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="574" y="80" width="200" height="6" rx="3" fill="var(--accent)"/>
  <circle cx="674" cy="138" r="24" fill="var(--accent)" opacity=".12"/>
  <circle cx="674" cy="138" r="18" fill="var(--accent)"/>
  <text x="674" y="143" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="674" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Select in App</text>
  <text x="674" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Machine auto-sets light</text>
  <text x="674" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">temp + humidity</text>
  <!-- Arrow 3 -->
  <polygon points="806,155 829,145 829,165" fill="var(--accent)" opacity=".6"/>
  <rect x="786" y="152" width="43" height="6" rx="3" fill="var(--accent)" opacity=".4"/>
  <!-- Step 4 -->
  <rect x="841" y="80" width="220" height="160" rx="12" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <circle cx="951" cy="138" r="24" fill="white" opacity=".2"/>
  <circle cx="951" cy="138" r="18" fill="white"/>
  <text x="951" y="143" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="951" y="180" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Harvest in 8 Days</text>
  <text x="951" y="200" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Microgreens fastest</text>
  <text x="951" y="218" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">App notifies when ready</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The app + machine handle every variable — you just insert, add water, and pick what you want to eat.</div>

<!-- Speaker: Step 4 (harvest) is highlighted because that's the payoff that justifies all 3 prior steps. -->

---

## Specs & Pricing

<p class="subhead">Two sizes to match household needs — running cost is ~£2/month in electricity.</p>

| รายการ | Large (3-tray) | Small (1-tray) |
|--------|---------------|---------------|
| ขนาด | Mini fridge (slim) | Large microwave |
| จำนวน tray | 3 (ปลูกพร้อมกัน 3 ชนิด) | 1 |
| ราคาเครื่อง | ~£339 | ~£339 |
| Subscription seed mat | £10–15/เดือน | £10–15/เดือน |
| ค่าไฟ/เดือน | ~£2 | ~£2 |
| วางแบบ | Freestanding / Integrated | Freestanding / Integrated |

<div class="takeaway"><b>★ Takeaway:</b> Same price for both sizes — buy large if you cook for a family; small for couples. Running cost is negligible at £2/month.</div>

<!-- Speaker: £339 upfront + £10-15/month subscription. Break-even depends on how much bagged salad you currently buy and waste. -->

---

## Seed Mat: The Heart of the System

![bg right:40% contain](assets/home-harvest-smart-indoor-farm-seed-mat.png)

<p class="subhead">A5 recyclable fabric with seeds and fertilizer pre-embedded — QR code links directly to grow profile.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">ธีมที่มีจำหน่าย</p>
    <h3>Themed Collections</h3>
    <ul>
      <li>Italian Herbs — โหระพา, ออริกาโน</li>
      <li>Prenatal Health — โฟเลต + ธาตุเหล็ก</li>
      <li>Gut Health — ไฟเบอร์สูง</li>
      <li>Vitamin-focused sets</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">เทคโนโลยี</p>
    <h3>How It's Built</h3>
    <ul>
      <li>Recyclable fabric substrate</li>
      <li>Pre-seeded + fertilizer integrated</li>
      <li>QR code → auto-sets grow profile</li>
      <li>Radish, chervil, fenugreek, salads</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The subscription model keeps you supplied — seed mats are the razor blades to this razor handle.</div>

<!-- Speaker: Subscription lock-in is both the business model and the key dependency risk. QR code is the smart glue between mat and machine. -->

---

## Zero Food Miles, Zero Packaging, Zero Pesticides

![bg right:40% contain](assets/home-harvest-smart-indoor-farm-env-impact.png)

<p class="subhead">Growing at home eliminates the entire cold-chain logistics footprint of bagged supermarket salad.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Zero Food Miles</p>
    <h3>ปลูกในบ้าน</h3>
    <p>ไม่มีการขนส่งข้ามประเทศ ไม่มีการแช่เย็นระหว่างทาง ผักถึงมือตรงๆ จากตัวเครื่อง</p>
  </div>
  <div class="card success">
    <p class="label">Zero Packaging</p>
    <h3>ไม่มีถุงพลาสติก</h3>
    <p>เก็บเกี่ยวเท่าที่ต้องการ ใส่จาน ไม่มีบรรจุภัณฑ์พลาสติกที่ต้องทิ้ง</p>
  </div>
  <div class="card success">
    <p class="label">Zero Pesticides</p>
    <h3>ควบคุมสภาพแวดล้อม</h3>
    <p>ระบบปิดสมบูรณ์ ไม่มีแมลงรบกวน ไม่ต้องใช้สารเคมีใดๆ</p>
  </div>
  <div class="card gold">
    <p class="label">ลดขยะอาหาร</p>
    <h3>Harvest on Demand</h3>
    <p>ตัดเท่าที่กินวันนี้ ที่เหลือโตต่อในเครื่อง ผักไม่เน่าเสียในตู้เย็น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The environmental case isn't just marketing — removing cold-chain transport eliminates a real measurable footprint per household.</div>

<!-- Speaker: UK imports 1,000 trucks/week of salad; 400 are discarded. Home Harvest attacks the demand side of that equation. -->

---

## AI Roadmap: From Automation to Intelligence

![bg right:40% contain](assets/home-harvest-smart-indoor-farm-ai-roadmap.png)

<p class="subhead">Today: automated environment control. Tomorrow: AI that watches your crop and predicts the perfect harvest moment.</p>

<div class="infographic">
<svg viewBox="0 0 700 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- timeline: 2 phases -->
  <line x1="60" y1="140" x2="650" y2="140" stroke="var(--soft-2)" stroke-width="2"/>
  <!-- Phase 1: Now -->
  <circle cx="160" cy="140" r="18" fill="var(--accent)"/>
  <text x="160" y="145" font-size="11" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">NOW</text>
  <rect x="80" y="30" width="160" height="80" rx="10" fill="var(--success-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="160" y="58" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Automation</text>
  <text x="160" y="78" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Light / Water / Temp</text>
  <text x="160" y="96" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Humidity auto-control</text>
  <line x1="160" y1="110" x2="160" y2="122" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="3,2"/>
  <!-- Phase 2: Near term -->
  <circle cx="380" cy="140" r="18" fill="var(--warning)" opacity=".8"/>
  <text x="380" y="145" font-size="9" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">SOON</text>
  <rect x="300" y="170" width="160" height="80" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="380" y="198" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">AI Vision</text>
  <text x="380" y="218" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Plant health scan</text>
  <text x="380" y="236" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Harvest time prediction</text>
  <line x1="380" y1="158" x2="380" y2="170" stroke="var(--warning)" stroke-width="1.5" stroke-dasharray="3,2"/>
  <!-- Phase 3: Future -->
  <circle cx="590" cy="140" r="18" fill="var(--muted)"/>
  <text x="590" y="145" font-size="9" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">FUTURE</text>
  <rect x="510" y="30" width="160" height="80" rx="10" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <text x="590" y="58" font-size="12" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Live-Nutrition DB</text>
  <text x="590" y="78" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Personalized diet advice</text>
  <text x="590" y="96" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Biometrics + crop data</text>
  <line x1="590" y1="110" x2="590" y2="122" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="3,2"/>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI health monitoring and harvest prediction are roadmap — not shipping yet. Buy now for automation; the AI ambition is aspirational.</div>

<!-- Speaker: The Live-Nutrition database is the long-game: a dataset linking crop growth data to biometric outcomes. Ambitious, but no timeline. -->

---

## Caveats: What to Watch Before Buying

<p class="subhead">Pre-order product with real dependency and cost considerations — not right for everyone.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">ราคา</p>
    <h3>Cost Break-even</h3>
    <p>£339 + £10-15/mo subscription. ถูกกว่าผักซูเปอร์มาร์เก็ตก็ต่อเมื่อลดขยะอาหารได้จริง ไม่ใช่ทุกคนที่ซื้อผักแล้วทิ้งมาก</p>
  </div>
  <div class="card danger">
    <p class="label">Dependency</p>
    <h3>Seed Mat Lock-in</h3>
    <p>ถ้าบริษัทหยุดให้บริการหรือขึ้นราคา subscription ตัวเครื่องจะใช้งานยาก — hardware มีค่าก็ต่อเมื่อ seed supply chain ทำงาน</p>
  </div>
  <div class="card warning">
    <p class="label">Scope</p>
    <h3>Greens Only</h3>
    <p>เหมาะสำหรับ microgreens, สลัด, และสมุนไพรเท่านั้น ผักหัว ผลไม้ หรือพืชขนาดใหญ่ ปลูกในเครื่องนี้ไม่ได้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> The AI features are still roadmap; you're buying today's automation — strong for salad lovers, risky if you're not already a heavy salad buyer.</div>

<!-- Speaker: Pre-order risk is real. 4 years of development is promising but product is unproven at consumer scale. -->

---

## Key Takeaways

<p class="subhead">Home Harvest bets that convenience + sustainability convert salad buyers into home growers.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">The Case For</p>
    <h3>Why It Could Win</h3>
    <ul>
      <li>8-day harvest — genuinely fast</li>
      <li>Zero skills, zero mess, zero waste</li>
      <li>£2/mo electricity — negligible OpEx</li>
      <li>AI roadmap adds long-term value</li>
      <li>Summer 2026 — real launch window</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">The Case Against</p>
    <h3>Why It Might Struggle</h3>
    <ul>
      <li>£339 + £10-15/mo is a premium bet</li>
      <li>Seed mat subscription = vendor lock-in</li>
      <li>Greens only — limited crop variety</li>
      <li>AI features still unshipped roadmap</li>
      <li>Pre-order: unproven at consumer scale</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้าคุณซื้อผักสลัดสัปดาห์ละครั้งแล้วทิ้งครึ่ง — Home Harvest คือ hardware ที่แก้ปัญหานั้นได้จริง ถ้าไม่ใช่ — ราคายังสูงเกินไป</div>

<!-- Speaker: The sustainability narrative is compelling. The subscription model and pre-order status are the two risk flags to watch. -->
