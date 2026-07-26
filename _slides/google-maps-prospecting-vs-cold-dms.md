---
marp: true
theme: default
paginate: true
title: "Google Maps Prospecting vs Cold DMs"
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
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/google-maps-prospecting-vs-cold-dms-cover.png)

<div class="mark"></div>

# หาลูกค้าผ่าน Google Maps<br>ทำไมได้ผลกว่า Cold DM

<p class="tag">เจาะกลุ่มเว็บไซต์พัง รีวิวลบ ด้วย Prospecting Tools</p>

<!-- Speaker: 30-second intro — cold DM ตายเพราะ generic, Google Maps ให้สัญญาณจริงที่ B2B database มองข้าม. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/google-maps-prospecting-vs-cold-dms-cheatsheet.png)

<!-- Speaker: 60-second cheatsheet orientation — ชี้ 4 panel หลักก่อนเข้าเนื้อหา. -->

---

## TL;DR

<p class="subhead">Cold DM แบบ generic ตาย — Google Maps + prospecting tools คือทางออก</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="190" r="40" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="190" r="28" fill="var(--accent)"/>
  <text x="148" y="196" font-size="18" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">i</text>
  <text x="220" y="150" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">Avg cold email reply rate: ~4.1%</text>
  <text x="220" y="182" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Range 1-8.5%; declined 5.1% (2024) to 3.43% (2026)</text>
  <text x="220" y="214" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Google Maps = database of every real storefront</text>
  <text x="220" y="246" font-size="15" fill="var(--muted)" font-family="system-ui">Target: no website / broken site / negative reviews</text>
  <text x="220" y="278" font-size="15" fill="var(--muted)" font-family="system-ui">Filter with prospecting tools, outreach with real data</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เจาะกลุ่มที่มีสัญญาณอ่อนแอจริง แล้วอ้างอิงข้อมูลจริงตอนทัก — ไม่ใช่ยิงแบบสุ่ม</div>

<!-- Speaker: ตั้งกรอบทั้ง deck — ทำไมต้องเปลี่ยนจาก volume-based เป็น signal-based. -->

---

## ทำไม B2B Database มาตรฐานมองข้ามธุรกิจท้องถิ่น

![bg right:40% contain](assets/google-maps-prospecting-vs-cold-dms-why-google-maps.png)

<p class="subhead">ZoomInfo, Apollo ถูกออกแบบมาสำหรับบริษัท digital-first ที่มี funding — ธุรกิจท้องถิ่นไม่มีข้อมูลอยู่ในนั้นเลย</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="40" width="280" height="240" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="170" y="80" font-size="15" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">B2B DB</text>
  <ellipse cx="170" cy="150" rx="60" ry="18" fill="none" stroke="var(--muted)" stroke-width="2" opacity=".5"/>
  <text x="170" y="220" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">no local-biz data</text>
  <rect x="360" y="40" width="280" height="240" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="500" y="80" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Google Maps</text>
  <circle cx="500" cy="160" r="10" fill="var(--accent)"/>
  <path d="M500 145 L500 175 M485 160 L515 160" stroke="var(--paper)" stroke-width="2"/>
  <text x="500" y="220" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">every real storefront</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Google Maps ให้สัญญาณที่มองเห็นได้จริง (rating, review count, website) แทน intent data ที่ไม่มีอยู่</div>

<!-- Speaker: อธิบาย gap ของ traditional prospecting database ก่อนเข้าสู่ signal เฉพาะ. -->

---

## ทำไม Cold DM แบบ Generic ถึงได้ผลต่ำ

![bg right:40% contain](assets/google-maps-prospecting-vs-cold-dms-why-cold-dms-fail.png)

<p class="subhead">Personalization คือตัวแปรตัดสินผล — ไม่ใช่จำนวนข้อความที่ยิงออกไป</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="40" width="620" height="50" rx="8" fill="var(--soft)"/>
  <rect x="40" y="40" width="80" height="50" rx="8" fill="var(--muted)" opacity=".3"/>
  <text x="150" y="70" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Generic template: ~4.1% avg reply</text>
  <rect x="40" y="110" width="620" height="50" rx="8" fill="var(--soft)"/>
  <rect x="40" y="110" width="280" height="50" rx="8" fill="var(--accent)" opacity=".3"/>
  <text x="150" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">Personalized: up to ~18% reply</text>
  <rect x="40" y="180" width="620" height="50" rx="8" fill="var(--soft)"/>
  <rect x="40" y="180" width="580" height="50" rx="8" fill="var(--accent)"/>
  <text x="150" y="210" font-size="14" fill="var(--paper)" font-family="system-ui" font-weight="700">Top campaigns: 40-50% reply</text>
  <text x="40" y="260" font-size="13" fill="var(--muted)" font-family="system-ui">81% of decision-makers engage only when message is tailored</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Personalized email เพิ่ม response rate ~32% เทียบ generic template</div>

<!-- Speaker: อ้างอิงตัวเลขจาก cold-email benchmark 2026 — ชี้ให้เห็น gap ชัดเจน. -->

---

## สัญญาณ High-Intent Lead บน Google Maps

<p class="subhead">มองหาความเปราะบางที่มองเห็นได้ตรงๆ ก่อนติดต่อ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Signal 1</p>
    <h3>ไม่มีเว็บไซต์</h3>
    <p>พึ่งพา offline traffic หรือ directory ล้วนๆ — เสนอสร้างเว็บ = แก้ lead loss ตรงจุด</p>
  </div>
  <div class="card warning">
    <p class="label">Signal 2</p>
    <h3>เว็บพัง / ล้าสมัย</h3>
    <p>มีเว็บแต่ใช้งานไม่ได้จริง — mobile ไม่รองรับ หรือไม่มี contact form</p>
  </div>
  <div class="card danger">
    <p class="label">Signal 3</p>
    <h3>รีวิวลบ + volume สูง</h3>
    <p>250 รีวิว 3.6 ดาว = demand จริง + pain point ชัดเจน เหมาะกับ reputation/SEO</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> รีวิวเยอะ + คะแนนต่ำ พิสูจน์ demand จริง ไม่ใช่แค่ธุรกิจแย่</div>

<!-- Speaker: 3 สัญญาณหลักที่ mine ได้ตรงจาก listing โดยไม่ต้องใช้ intent data. -->

---

## Prospecting Tools: Scrape → Filter → Enrich

<p class="subhead">ข้อมูลดิบจาก Maps มีแค่ชื่อกับเบอร์ — ต้องผ่าน 3 ขั้นก่อน outreach</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="110" width="280" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="180" y="145" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1. Scrape</text>
  <text x="180" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Outscraper / Clay / Apify</text>
  <text x="180" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">by niche + geography</text>
  <path d="M330 160 L400 160" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="410" y="110" width="280" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="550" y="145" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Filter</text>
  <text x="550" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">No-website / low-rating</text>
  <text x="550" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">isolate vulnerability signal</text>
  <path d="M700 160 L770 160" stroke="var(--muted)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="780" y="110" width="280" height="100" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="920" y="145" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">3. Enrich</text>
  <text x="920" y="170" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">find owner + verified email</text>
  <text x="920" y="190" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">contactable lead</text>
  <defs><marker id="arr" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pin บนแผนที่ยังไม่ใช่ lead — ต้อง enrich หา owner + verified contact ก่อนทัก</div>

<!-- Speaker: ชี้ cost-effective pipeline — scraper ตัวหนึ่ง + enrichment อีกตัวสำหรับ agency ต่ำกว่า 50K lead/เดือน. -->

---

## Outreach: Generic Pitch vs Data-Backed Hook

<p class="subhead">Hook ที่อ้าง signal เฉพาะเจาะจง ลด rejection ได้ชัดเจนกว่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Generic Pitch</text>
  <text x="80" y="120" font-size="14" fill="var(--ink-dim)" font-family="system-ui">"Hi, I help businesses</text>
  <text x="80" y="145" font-size="14" fill="var(--ink-dim)" font-family="system-ui">like yours grow online..."</text>
  <text x="80" y="200" font-size="13" fill="var(--muted)" font-family="system-ui">No evidence of research</text>
  <text x="80" y="230" font-size="13" fill="var(--muted)" font-family="system-ui">Reads as spam / ignored</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Data-Backed Hook</text>
  <text x="610" y="120" font-size="14" fill="var(--ink)" font-family="system-ui">"Noticed on Google Maps</text>
  <text x="610" y="145" font-size="14" fill="var(--ink)" font-family="system-ui">you don't have a website —</text>
  <text x="610" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">any plans to build one?"</text>
  <text x="610" y="225" font-size="13" fill="var(--accent-deep)" font-family="system-ui">Proves real research done</text>
  <text x="610" y="255" font-size="13" fill="var(--accent-deep)" font-family="system-ui">Feels like local consultation</text>
  <circle cx="550" cy="190" r="28" fill="var(--accent)"/>
  <text x="550" y="195" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> รีวิวลบ — เข้าหาด้วยความเข้าใจ ไม่ตำหนิ แล้วเสนอช่วยจัดการ reputation</div>

<!-- Speaker: ยกตัวอย่าง script จริงจากวิดีโอต้นฉบับ — no-website hook + negative-review hook. -->

---

## User Guide: 7 Steps จาก Lead สู่ Outreach

<p class="subhead">Workflow เต็มตั้งแต่กำหนด niche จนถึง foot-in-the-door offer</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">1</p>
    <h3>Niche + Geo</h3>
    <p>กำหนดหมวดธุรกิจ + พื้นที่</p>
  </div>
  <div class="card compact">
    <p class="label">2</p>
    <h3>Scrape</h3>
    <p>ดึง CSV: name, website, rating</p>
  </div>
  <div class="card compact">
    <p class="label">3</p>
    <h3>Filter</h3>
    <p>no-website หรือ rating&lt;4.0 + 20+ review</p>
  </div>
  <div class="card compact">
    <p class="label">4</p>
    <h3>Enrich</h3>
    <p>หาชื่อเจ้าของ + verified contact</p>
  </div>
  <div class="card compact">
    <p class="label">5</p>
    <h3>อ่านรีวิว</h3>
    <p>ดึง signal เฉพาะเจาะจง 1 อย่าง</p>
  </div>
  <div class="card compact">
    <p class="label">6</p>
    <h3>ส่ง Hook</h3>
    <p>1-liner อ้าง signal ตรงๆ</p>
  </div>
  <div class="card compact gold">
    <p class="label">7</p>
    <h3>Foot-in-Door</h3>
    <p>เสนอ commitment ต่ำก่อน upsell</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก step ต้องมี evidence เจาะจงต่อธุรกิจนั้น — ไม่ใช่ template เดียวยิงทุกคน</div>

<!-- Speaker: เดินผ่านทั้ง 7 step แบบเร็ว เน้น step 5-7 ที่เป็นจุดต่างจาก cold DM ทั่วไป. -->

---

## Caveats / Limits

<p class="subhead">ข้อควรระวังก่อนใช้จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Compliance</p>
    <h3>Scraping ToS + Privacy Law</h3>
    <p>ตรวจสอบ Google ToS และกฎหมาย data privacy ก่อนใช้ข้อมูลติดต่อเชิงพาณิชย์</p>
  </div>
  <div class="card warning">
    <p class="label">Freshness</p>
    <h3>ข้อมูลเปลี่ยนตลอดเวลา</h3>
    <p>Rating/review count เปลี่ยนได้ — lead list เก่าอาจไม่ตรงสถานะปัจจุบัน</p>
  </div>
  <div class="card danger">
    <p class="label">Tone</p>
    <h3>ระวังฟังดูเหมือนตำหนิ</h3>
    <p>เข้าหารีวิวลบด้วยน้ำเสียงช่วยเหลือ ไม่ใช่ negative-selling</p>
  </div>
  <div class="card">
    <p class="label">Unverified</p>
    <h3>ตัวเลข Conversion เฉพาะ</h3>
    <p>ยังไม่มี source ที่ verify ได้สำหรับ % conversion ของ Maps prospecting โดยตรง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Compliance และ tone สำคัญพอๆ กับเทคนิค prospecting เอง</div>

<!-- Speaker: เน้นย้ำว่า scraping ต้องถูกกฎหมาย และ tone ต้องไม่ negative-selling. -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้ข้ามเนื้อหาทั้งหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Signal</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">over volume</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">No website /</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">negative reviews</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Scrape → Filter</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">→ Enrich</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Data-backed</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">hook</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Foot-in-door</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">offer first</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เจาะกลุ่มที่มี signal อ่อนแอจริง อ้างอิงข้อมูลจริงตอนทัก — ผลลัพธ์ดีกว่ายิง cold DM แบบสุ่มเสมอ</div>
