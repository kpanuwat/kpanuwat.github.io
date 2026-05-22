---
marp: true
theme: default
paginate: true
title: "EMS Factory EP14: Test Development Services"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# EMS Factory EP14
## Test Development Services

<p class="tag">ICT Fixture · FCT Program · Boundary Scan · NPI Timeline · OEM/EMS Responsibilities</p>

<!-- Speaker: EP14 เจาะกระบวนการพัฒนา test ใน EMS — ไม่ใช่ประเภท test (ดู EP7) แต่คือ HOW ที่ EMS สร้าง test ให้ OEM -->

---

## Test Development Services คืออะไร

<p class="subhead">บริการที่ EMS สร้างระบบ test ทั้งหมดให้ OEM — fixture, program, coverage, จนถึง production-ready</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- callout-box: 3 service areas -->
  <rect x="40" y="30" width="320" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="320" height="8" rx="4" fill="var(--accent)"/>
  <text x="200" y="80" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ICT Fixture</text>
  <text x="200" y="108" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Bed-of-nails design</text>
  <text x="200" y="130" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Test program generation</text>
  <text x="200" y="152" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Structural / electrical</text>

  <rect x="390" y="30" width="320" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="390" y="30" width="320" height="8" rx="4" fill="var(--success)"/>
  <text x="550" y="80" font-size="16" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">FCT Program</text>
  <text x="550" y="108" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Functional test software</text>
  <text x="550" y="130" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Bus validation (CAN/SPI/I2C)</text>
  <text x="550" y="152" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Real-world simulation</text>

  <rect x="740" y="30" width="320" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="740" y="30" width="320" height="8" rx="4" fill="var(--gold)"/>
  <text x="900" y="80" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Boundary Scan</text>
  <text x="900" y="108" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">JTAG chain (IEEE 1149.1)</text>
  <text x="900" y="130" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BGA / high-density coverage</text>
  <text x="900" y="152" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No physical probe needed</text>

  <rect x="40" y="240" width="1020" height="52" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1"/>
  <text x="550" y="268" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">ต่างจาก EP7: EP นี้คือ HOW ที่ EMS สร้าง test — ไม่ใช่ประเภท test</text>
  <text x="550" y="284" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Fixture design · Program development · Coverage analysis · OEM/EMS ownership</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Test development = service ที่ EMS build ให้ OEM — ครอบคลุม ICT fixture, FCT software, และ boundary scan strategy</div>

<!-- Speaker: EP7 = types of test; EP14 = how EMS develops them as services -->

---

## ทำไม Test Development ต้องเริ่มที่ Design Phase

<p class="subhead">3 ปัญหาที่เกิดเมื่อคิดเรื่อง test ช้าเกินไป — แก้ทีหลังแพงมาก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Problem 1 / Test Access</p>
    <h3>Test Point ไม่เพียงพอ</h3>
    <p>Board ไม่มี TP ในตำแหน่งที่ probe เข้าถึงได้ ต้องแก้ layout หลัง tape-out — ราคาและเวลาสูงมาก</p>
  </div>
  <div class="card danger">
    <p class="label">Problem 2 / BGA Coverage</p>
    <h3>BGA ไม่มี Scan Chain</h3>
    <p>Solder joint อยู่ใต้ component ตรวจด้วย visual ไม่เห็น ICT pogo pin เข้าไม่ถึง — ไม่มี boundary scan ก็ไม่รู้ว่า open/short</p>
  </div>
  <div class="card danger">
    <p class="label">Problem 3 / FCT Spec</p>
    <h3>FCT ไม่มี Spec ชัด</h3>
    <p>OEM ไม่ได้กำหนด pass/fail criteria ก่อน production EMS estimate เอง — defect หลุดถึง field</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ปัญหาทั้ง 3 ป้องกันได้ถ้าวาง test strategy ตั้งแต่ layout phase — แก้ทีหลัง = rework ทุก layer</div>

<!-- Speaker: Cost of test escape doubles at every stage — fixing at design costs 1x, fixing at production costs 10x+ -->

---

## ICT Fixture Design — 4-Phase Process

<p class="subhead">จาก Gerber data → production-ready bed-of-nails fixture ใน 4 phase</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 4 phases -->
  <!-- Phase 1: Design -->
  <rect x="30" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="30" y="80" width="210" height="44" rx="12" fill="var(--accent)" opacity=".12"/>
  <text x="135" y="107" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1 · Design</text>
  <text x="135" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">รับ Gerber/CAD data</text>
  <text x="135" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Map test points</text>
  <text x="135" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">กำหนด pogo pin type</text>
  <text x="135" y="202" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ออกแบบ interface board</text>

  <!-- Arrow -->
  <polygon points="258,155 278,145 278,165" fill="var(--accent)"/>
  <line x1="240" y1="155" x2="278" y2="155" stroke="var(--accent)" stroke-width="2"/>

  <!-- Phase 2: Prototyping -->
  <rect x="288" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="288" y="80" width="210" height="44" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="393" y="107" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2 · Prototyping</text>
  <text x="393" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">CNC / laser-cut fixture</text>
  <text x="393" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทดสอบ alignment</text>
  <text x="393" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">กับ DUT จริง</text>
  <text x="393" y="202" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ตรวจ pogo contact ครบ</text>

  <!-- Arrow -->
  <polygon points="516,155 536,145 536,165" fill="var(--accent)"/>
  <line x1="498" y1="155" x2="536" y2="155" stroke="var(--accent)" stroke-width="2"/>

  <!-- Phase 3: Testing & Validation -->
  <rect x="546" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="546" y="80" width="210" height="44" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="651" y="107" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3 · Validate</text>
  <text x="651" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">วัด contact resistance</text>
  <text x="651" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ทดสอบ isolation</text>
  <text x="651" y="182" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ยืนยัน test program</text>
  <text x="651" y="202" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">บน fixture จริง</text>

  <!-- Arrow -->
  <polygon points="774,155 794,145 794,165" fill="var(--accent)"/>
  <line x1="756" y1="155" x2="794" y2="155" stroke="var(--accent)" stroke-width="2"/>

  <!-- Phase 4: Production -->
  <rect x="804" y="80" width="266" height="160" rx="12" fill="var(--accent-deep)" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.12))"/>
  <text x="937" y="107" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4 · Production</text>
  <text x="937" y="142" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Precision CNC machining</text>
  <text x="937" y="162" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Safety interlock integrated</text>
  <text x="937" y="182" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Hand off + test program</text>
  <text x="937" y="202" font-size="12" fill="rgba(255,255,255,.65)" text-anchor="middle" font-family="system-ui">Production-ready</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ICT fixture ไม่ได้แค่ "ตัดแผ่น" — มี 4 phase ที่แต่ละ phase ต้องผ่านก่อนไปต่อ; Design phase depend ที่ test point ที่ OEM วางมา</div>

<!-- Speaker: Phase 1 depends entirely on OEM's Gerber data quality — TP density and placement is OEM's responsibility -->

---

## ICT Fixture: Component ทั้ง 4 ส่วน

<p class="subhead">แต่ละส่วนมีหน้าที่เฉพาะ — ขาดส่วนใดส่วนหนึ่ง fixture ทำงานไม่ได้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Layer 1 / Contact</p>
    <h3>Test Head</h3>
    <p>Bed-of-nails ที่มี pogo pins ตรงกับ test point ทุกจุดบน PCB — จุด contact หลักกับ DUT</p>
  </div>
  <div class="card">
    <p class="label">Layer 2 / Routing</p>
    <h3>Interface Board</h3>
    <p>Routing สัญญาณจาก pogo pins ไปยัง test system connector — รองรับ multiplexing หลาย test point</p>
  </div>
  <div class="card">
    <p class="label">Layer 3 / Mechanical</p>
    <h3>Mounting Hardware</h3>
    <p>Alignment pin + vacuum clamp ยึด DUT ในตำแหน่งที่แน่นอน ป้องกัน misalignment ขณะ test</p>
  </div>
  <div class="card warning">
    <p class="label">Layer 4 / Safety</p>
    <h3>Safety Interlock</h3>
    <p>ป้องกัน fixture ปิดขณะยังไม่ได้วาง DUT — ถ้าไม่มีจะ crush board หรือ short circuit test system</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Modern ICT ยังใช้ CAD/EDA data auto-generate test program (netlist-based) — ลด development time ลงได้มาก</div>

<!-- Speaker: Auto-generated programs cover ~60-80% of tests; remaining 20-40% require manual test writing for custom sequences -->

---

## FCT Program Development — 3 Dimensions

<p class="subhead">FCT ทดสอบว่า assembly ทำงานตาม spec จริง — ไม่ใช่แค่วัดค่าไฟฟ้า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Dimension 1</p>
    <h3>Hardware Interface</h3>
    <p>Custom fixture simulate product จริง: connector ครบ, power supply ตรง, load resistor หรือ dummy sensor ตามจริง</p>
    <p>Wireless product: RF shielded enclosure กัน interference</p>
  </div>
  <div class="card success">
    <p class="label">Dimension 2</p>
    <h3>Software Test Sequence</h3>
    <p>Test script (Python/LabVIEW): bus validation (CAN, LIN, RS-485, Ethernet, I2C, SPI), firmware flash + boot verification, parametric measurement under load</p>
  </div>
  <div class="card gold">
    <p class="label">Dimension 3 / Critical</p>
    <h3>Pass/Fail Criteria</h3>
    <p>OEM ต้องกำหนด acceptance limit ทุก parameter ก่อน production — ถ้า EMS estimate เอง ความเสี่ยงสูง</p>
    <p>ทุก result บันทึกพร้อม S/N ผ่าน MES</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FCT ดักจับสิ่งที่ ICT พลาด: firmware failure, timing delay, power variation, interaction bug — แต่ต้องการ spec ชัดจาก OEM ก่อน</div>

<!-- Speaker: Dimension 3 (pass/fail criteria) is the most common failure point — OEM delays providing limits, EMS ships with estimated thresholds -->

---

## Boundary Scan: Test โดยไม่ต้องมี Physical Probe

<p class="subhead">IEEE 1149.1 / JTAG — test architecture ที่ฝังใน IC สำหรับ BGA และ high-density board</p>

<div class="infographic" style="align-items:stretch;gap:16px;">
<div style="display:grid;grid-template-columns:1fr auto 1fr;gap:12px;width:100%;align-items:stretch;">
  <div class="card danger" style="border-left-color:var(--ink-dim);background:var(--soft);">
    <p class="label">Physical Probe (ICT) — ข้อจำกัด</p>
    <h3 style="color:var(--ink-dim);">Physical Access Required</h3>
    <ul>
      <li>BGA solder joint อยู่ใต้ component — pogo pin เข้าไม่ถึง</li>
      <li>High-density board ไม่มีที่วาง test point</li>
      <li>Fine-pitch SMD ยาก probe</li>
      <li>Coverage gap ในหลาย modern IC package</li>
    </ul>
  </div>
  <div style="display:flex;align-items:center;justify-content:center;min-width:52px;">
    <div style="background:var(--accent);border-radius:50%;width:48px;height:48px;display:flex;align-items:center;justify-content:center;font-weight:700;color:white;font-size:14px;flex-shrink:0;">VS</div>
  </div>
  <div class="card success">
    <p class="label">Boundary Scan (IEEE 1149.1 / JTAG) — ทางออก</p>
    <h3>No Physical Probe Needed</h3>
    <ul>
      <li>Test ผ่าน JTAG chain: TDI → TDO → TMS → TCK</li>
      <li>Interconnect test: ตรวจ open/short ระหว่าง ICs</li>
      <li>In-System Programming (ISP) — flash firmware ผ่าน JTAG</li>
      <li>Board bring-up + debug ตั้งแต่ prototype stage</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Boundary scan ไม่ใช่ทางเลือก — เป็นข้อกำหนดสำหรับ modern board ที่มี BGA; ต้องวาง JTAG chain ก่อน layout freeze</div>

<!-- Speaker: BGA = Ball Grid Array — solder joints underneath the component package, completely inaccessible to ICT probes -->

---

## JTAG Chain Architecture

<p class="subhead">Boundary scan ทำงานผ่าน daisy-chain ของ IC ที่ support IEEE 1149.1 — TAP Header → IC1 → IC2 → IC3 → TDO return</p>

<div class="infographic" style="align-items:stretch;flex-direction:column;gap:12px;">
<div style="display:flex;align-items:center;justify-content:center;gap:8px;padding:14px 0 4px;">
  <div style="background:var(--accent-deep);border-radius:8px;padding:10px 16px;color:white;font-weight:700;font-size:13px;text-align:center;">JTAG<br><span style="font-weight:400;font-size:11px;opacity:.8;">TAP Header</span></div>
  <div style="font-size:11px;color:var(--accent);font-weight:700;">TDI &#8594;</div>
  <div style="background:var(--paper);border:2px solid var(--accent);border-radius:8px;padding:10px 16px;text-align:center;font-size:13px;font-weight:700;color:var(--ink);">IC 1<br><span style="font-weight:400;font-size:11px;color:var(--ink-dim);">FPGA / MCU</span><br><span style="font-size:10px;color:var(--success);">IEEE 1149.1</span></div>
  <div style="font-size:11px;color:var(--accent);font-weight:700;">&#8594;</div>
  <div style="background:var(--paper);border:2px solid var(--accent);border-radius:8px;padding:10px 16px;text-align:center;font-size:13px;font-weight:700;color:var(--ink);">IC 2<br><span style="font-weight:400;font-size:11px;color:var(--ink-dim);">CPU / DSP</span><br><span style="font-size:10px;color:var(--success);">IEEE 1149.1</span></div>
  <div style="font-size:11px;color:var(--accent);font-weight:700;">&#8594;</div>
  <div style="background:var(--paper);border:2px solid var(--accent);border-radius:8px;padding:10px 16px;text-align:center;font-size:13px;font-weight:700;color:var(--ink);">IC 3<br><span style="font-weight:400;font-size:11px;color:var(--ink-dim);">Memory / Codec</span><br><span style="font-size:10px;color:var(--success);">IEEE 1149.1</span></div>
  <div style="font-size:11px;color:var(--muted);font-weight:700;">&#8592; TDO</div>
</div>
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Signal 1</p>
    <h3>TDI</h3>
    <p>Test Data In — input data เข้า chain</p>
  </div>
  <div class="card compact">
    <p class="label">Signal 2</p>
    <h3>TMS / TCK</h3>
    <p>Test Mode Select / Clock — ควบคุม state machine</p>
  </div>
  <div class="card compact success">
    <p class="label">Capability A</p>
    <h3>Interconnect Test</h3>
    <p>ตรวจ open/short ระหว่าง ICs; ทำงานกับ BGA/CSP ได้</p>
  </div>
  <div class="card compact">
    <p class="label">Capability B</p>
    <h3>ISP + Debug</h3>
    <p>Flash firmware ผ่าน JTAG; board bring-up โดยไม่ต้องมี fixture</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DFT rule: เลือก IC ที่ support IEEE 1149.1 + กำหนด JTAG chain architecture ก่อน PCB layout freeze — แก้หลังยาก</div>

<!-- Speaker: Chain architecture must be planned before layout — adding TAP headers or rerouting chain post-layout may require respinning the board -->

---

## Fault Coverage Metrics — Multi-Layer Strategy

<p class="subhead">ผลลัพธ์เมื่อ deploy ICT + Boundary Scan + AOI + FCT ร่วมกันในสายการผลิต</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 large metric cards -->
  <rect x="40" y="30" width="310" height="240" rx="14" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="310" height="8" rx="4" fill="var(--success)"/>
  <text x="195" y="100" font-size="52" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">70%</text>
  <text x="195" y="140" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Field Returns</text>
  <text x="195" y="162" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ลดลงสูงสุด</text>
  <text x="195" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Source: Foxtronics EMS</text>

  <rect x="395" y="30" width="310" height="240" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="395" y="30" width="310" height="8" rx="4" fill="var(--accent)"/>
  <text x="550" y="100" font-size="52" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">&gt;95%</text>
  <text x="550" y="140" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">First-Pass Yield</text>
  <text x="550" y="162" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ดีขึ้นบน mature product line</text>
  <text x="550" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Source: Foxtronics EMS</text>

  <rect x="750" y="30" width="310" height="240" rx="14" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="750" y="30" width="310" height="8" rx="4" fill="var(--gold)"/>
  <text x="905" y="100" font-size="48" font-weight="800" fill="var(--ink)" text-anchor="middle" font-family="system-ui">30–50%</text>
  <text x="905" y="140" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Warranty Cost</text>
  <text x="905" y="162" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ลดลงใน year แรก</text>
  <text x="905" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Source: Foxtronics EMS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตัวเลขเหล่านี้มาจาก EMS ที่ implement layered defense — ไม่ใช่ค่าเฉลี่ยอุตสาหกรรม; actual result ขึ้นกับ product complexity</div>

<!-- Speaker: Testability analysis before layout freeze maximizes these gains — late DFT changes can't achieve same coverage -->

---

## NPI Test Development Timeline

<p class="subhead">ตัดสินใจผิดตอน NPI = rework cost พุ่งสูงมากใน mass production</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- timeline with 5 phases -->
  <!-- Connector line -->
  <line x1="80" y1="130" x2="1040" y2="130" stroke="var(--soft-2)" stroke-width="3"/>

  <!-- Phase 1: Design -->
  <circle cx="130" cy="130" r="22" fill="var(--accent)"/>
  <text x="130" y="135" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="130" y="170" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Design</text>
  <text x="130" y="190" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Test strategy</text>
  <text x="130" y="207" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">JTAG chain plan</text>
  <text x="130" y="224" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Scan-capable IC</text>

  <!-- Phase 2: Layout -->
  <circle cx="300" cy="130" r="22" fill="var(--accent)"/>
  <text x="300" y="135" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="300" y="170" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Layout</text>
  <text x="300" y="190" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เพิ่ม test point</text>
  <text x="300" y="207" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ตาม DFT guideline</text>
  <text x="300" y="224" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">TP density check</text>

  <!-- Phase 3: Prototype -->
  <circle cx="510" cy="130" r="22" fill="var(--warning)"/>
  <text x="510" y="135" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="510" y="170" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Prototype</text>
  <text x="510" y="190" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Flying Probe Test</text>
  <text x="510" y="207" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่ต้องมี fixture</text>
  <text x="510" y="224" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ develop ICT fixture</text>

  <!-- Phase 4: Pre-Production -->
  <circle cx="730" cy="130" r="22" fill="var(--accent-deep)"/>
  <text x="730" y="135" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="730" y="170" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Pre-Production</text>
  <text x="730" y="190" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ICT fixture ready</text>
  <text x="730" y="207" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FCT station ready</text>
  <text x="730" y="224" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Validation run</text>

  <!-- Phase 5: Mass Production -->
  <circle cx="980" cy="130" r="26" fill="var(--success)"/>
  <text x="980" y="135" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="980" y="174" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Mass Production</text>
  <text x="980" y="194" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Full test coverage</text>
  <text x="980" y="211" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MES data logging</text>
  <text x="980" y="228" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Continuous improvement</text>

  <!-- Flying Probe note at prototype -->
  <rect x="370" y="30" width="280" height="60" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1"/>
  <text x="510" y="55" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Flying Probe = no fixture</text>
  <text x="510" y="75" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ประหยัด 4-8 สัปดาห์ vs ICT fixture dev</text>
  <line x1="510" y1="90" x2="510" y2="108" stroke="var(--warning)" stroke-width="1.5" stroke-dasharray="3,2"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตัดสินใจ JTAG chain และ scan-capable IC ก่อน layout release — หลัง layout freeze แก้ได้แต่ราคาแพงมาก</div>

<!-- Speaker: Flying Probe is the bridge between prototype and production — 4-8 weeks saved vs waiting for ICT fixture to be ready -->

---

## Flying Probe vs ICT Fixture

<p class="subhead">เลือก test method ตาม stage และ volume — ไม่ใช่ "better or worse" แต่ "right for this situation"</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Flying Probe -->
  <rect x="30" y="30" width="490" height="260" rx="12" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="30" y="30" width="490" height="52" rx="12" fill="var(--warning)" opacity=".1"/>
  <text x="275" y="62" font-size="17" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Flying Probe Test (FPT)</text>
  <text x="275" y="98" font-size="13" fill="var(--success)" text-anchor="middle" font-family="system-ui">ไม่ต้องมี custom fixture</text>
  <text x="275" y="122" font-size="13" fill="var(--success)" text-anchor="middle" font-family="system-ui">เริ่มได้เร็ว — ประหยัด 4–8 สัปดาห์</text>
  <text x="275" y="160" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">probe เคลื่อนที่ตาม Gerber coord</text>
  <text x="275" y="184" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">design เปลี่ยนได้ง่าย (update coord)</text>
  <text x="275" y="220" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Throughput ช้า</text>
  <text x="275" y="244" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ไม่ efficient สำหรับ mass production</text>
  <text x="275" y="270" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Best for: NPI / Prototype / Low-volume</text>

  <!-- VS badge -->
  <circle cx="550" cy="160" r="30" fill="var(--accent)"/>
  <text x="550" y="165" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>

  <!-- Right: ICT Fixture -->
  <rect x="580" y="30" width="490" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="580" y="30" width="490" height="52" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="825" y="62" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ICT Fixture (Bed-of-nails)</text>
  <text x="825" y="98" font-size="13" fill="var(--success)" text-anchor="middle" font-family="system-ui">Throughput สูง — test ทุก TP พร้อมกัน</text>
  <text x="825" y="122" font-size="13" fill="var(--success)" text-anchor="middle" font-family="system-ui">Consistent contact — repeatable result</text>
  <text x="825" y="160" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Test time สั้นกว่า FPT มาก</text>
  <text x="825" y="184" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">เหมาะกับ design ที่ stable แล้ว</text>
  <text x="825" y="220" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Upfront cost สูง (หลักหมื่น–แสนบาท)</text>
  <text x="825" y="244" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Design change = fixture rework</text>
  <text x="825" y="270" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Best for: Mass Production / Volume &gt;1,000/mo</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FPT ใน NPI phase ช่วยให้ design iterate ได้โดยไม่ต้องรอ fixture — เมื่อ design stable ค่อย commission ICT fixture</div>

<!-- Speaker: Using FPT during NPI also generates the test data needed to specify ICT fixture requirements more accurately -->

---

## OEM vs EMS: แบ่ง Ownership ให้ชัด

<p class="subhead">Test development ล้มเหลวมักเกิดจากไม่ได้กำหนด ownership — ใครทำอะไรต้องตกลงกันก่อน NPI</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">OEM Responsibility</p>
    <h3>OEM drives spec และ design intent</h3>
    <ul>
      <li>กำหนด test strategy ร่วมกับ EMS</li>
      <li>วาง DFT / DFM rules ตั้งแต่ design</li>
      <li>กำหนด pass/fail criteria ทุก parameter</li>
      <li>Freeze test spec ก่อน EMS เริ่ม fixture</li>
      <li>Test escape analysis (ร่วมกับ EMS)</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">EMS Responsibility</p>
    <h3>EMS executes และ feeds back data</h3>
    <ul>
      <li>ออกแบบ + manufacture ICT fixture</li>
      <li>เขียน FCT test program (ร่วมกับ OEM)</li>
      <li>Execute test ใน production line</li>
      <li>Data logging + MES integration</li>
      <li>Test escape analysis (ร่วมกับ OEM)</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> กฎสำคัญ: OEM ต้อง freeze pass/fail criteria ก่อน EMS เริ่ม develop fixture — spec เปลี่ยนหลัง fixture เสร็จ = rework แพง + เสียเวลา</div>

<!-- Speaker: The most common project delay: OEM provides spec sheets but delays confirming test limits — EMS can't start fixture without confirmed pass/fail values -->

---

## Caveats และ Limits ที่ต้องรู้

<p class="subhead">ทุก test method มีข้อจำกัด — เข้าใจ tradeoff ก่อน commit strategy</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Cost Tradeoff</p>
    <h3>Fixture Cost vs Volume</h3>
    <p>ICT fixture upfront cost สูง (หลักหมื่น–แสนบาท) คุ้มค่าสำหรับ volume &gt;1,000/เดือน ต่ำกว่านั้น FPT cost-effective กว่า</p>
  </div>
  <div class="card warning">
    <p class="label">Coverage Gap</p>
    <h3>Boundary Scan ไม่ครอบ IC ทุกตัว</h3>
    <p>IC ที่ไม่ support IEEE 1149.1 อยู่นอก scan chain — ต้องใช้ ICT หรือ cluster test เสริมสำหรับ IC เหล่านั้น</p>
  </div>
  <div class="card danger">
    <p class="label">Maintenance Risk</p>
    <h3>Test Program Stale</h3>
    <p>ทุก design change ต้องอัปเดต test program + fixture ถ้าไม่มี change control ที่ดี (ดู EP12 ECO/ECN) test อาจ outdated</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่มี test method ใดดักได้ 100% — layered strategy เพิ่ม coverage แต่ cost ก็เพิ่ม; balance กับ field failure risk ของ product</div>

<!-- Speaker: FCT tests one assembly in isolation — system integration issues (multiple boards working together) require a separate system-level test -->

---

## Key Takeaways

<p class="subhead">Test Development Services — จาก design spec ถึง production-ready coverage</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="align-self:stretch;">
  <div style="display:flex;flex-direction:column;gap:10px;">
    <div class="card compact success">
      <p class="label">Rule 1 / Timing</p>
      <h3>Test dev เริ่มที่ Design Phase</h3>
      <p>คิดทีหลัง = rework cost สูง, coverage ต่ำ</p>
    </div>
    <div class="card compact">
      <p class="label">Rule 2 / ICT</p>
      <h3>Fixture มี 4 Phase</h3>
      <p>Design → Prototype → Validate → Produce; depend ที่ TP จาก OEM</p>
    </div>
    <div class="card compact">
      <p class="label">Rule 3 / BGA</p>
      <h3>Boundary Scan สำหรับ Modern Board</h3>
      <p>IEEE 1149.1/JTAG = solution เดียวสำหรับ BGA ที่ probe ไม่ถึง</p>
    </div>
  </div>
  <div style="display:flex;flex-direction:column;gap:10px;">
    <div class="card compact warning">
      <p class="label">Rule 4 / NPI</p>
      <h3>FPT ใน NPI, ICT ใน Mass Production</h3>
      <p>Flying Probe ช่วย iterate design เร็ว; ICT ให้ throughput สูง</p>
    </div>
    <div class="card compact gold">
      <p class="label">Rule 5 / Metrics</p>
      <h3>Multi-layer = 70% field return reduction</h3>
      <p>ICT + Boundary Scan + AOI + FCT ร่วมกัน ลด warranty cost 30–50%</p>
    </div>
    <div class="card compact danger">
      <p class="label">Rule 6 / Ownership</p>
      <h3>Freeze Spec ก่อน EMS เริ่ม Fixture</h3>
      <p>OEM เปลี่ยน spec หลัง fixture เสร็จ = rework แพง + ล่าช้า</p>
    </div>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Test Development Services = investment ไม่ใช่ cost — ลงทุนครั้งเดียวใน NPI, ได้ผลตลอด production lifecycle</div>

<!-- Speaker: The ROI of test development is measurable: 70% field return reduction = direct warranty savings that far exceed fixture development cost -->
