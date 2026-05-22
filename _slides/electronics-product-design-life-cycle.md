---
marp: true
theme: default
paginate: true
title: "Electronics Product Design Life Cycle"
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

# Electronics Product Design Life Cycle

<p class="tag">6 Phases | แต่ละ Gate กรองความเสี่ยง | Concept → Mass Production</p>

<!-- Speaker: Full hardware lifecycle — from first concept through mass production. Key insight: each gate exists to prevent expensive mistakes from propagating downstream. -->

---

## Lifecycle คือ Risk Gate System — ไม่ใช่ Bureaucracy

<p class="subhead">ยิ่งค้นพบข้อผิดพลาดช้า ยิ่งแพงในการแก้ — แต่ละ phase gate กรองความเสี่ยงก่อนต้นทุนสูงขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a1" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L8,3 L0,6 Z" fill="var(--muted)"/>
    </marker>
    <linearGradient id="cg" x1="0" x2="1" y1="0" y2="0">
      <stop offset="0%" style="stop-color:var(--success);stop-opacity:.5"/>
      <stop offset="100%" style="stop-color:var(--danger);stop-opacity:.5"/>
    </linearGradient>
  </defs>
  <!-- cost bar -->
  <rect x="60" y="240" width="980" height="7" rx="3" fill="url(#cg)"/>
  <text x="60" y="258" font-size="11" fill="var(--success-ink)" font-family="system-ui">Low cost to fix</text>
  <text x="1040" y="258" font-size="11" fill="var(--danger-ink)" text-anchor="end" font-family="system-ui">High cost to fix</text>
  <!-- Phase 1 -->
  <rect x="60" y="55" width="130" height="72" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="125" y="82" font-size="9" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 1</text>
  <text x="125" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Concept</text>
  <text x="125" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Product Spec</text>
  <path d="M192,91 L218,91" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a1)"/>
  <!-- Phase 2 -->
  <rect x="221" y="55" width="130" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="286" y="82" font-size="9" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 2</text>
  <text x="286" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">System Arch</text>
  <text x="286" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BOM + PoC</text>
  <path d="M353,91 L379,91" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a1)"/>
  <!-- Phase 3 -->
  <rect x="382" y="55" width="130" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="447" y="82" font-size="9" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 3</text>
  <text x="447" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">PCB Design</text>
  <text x="447" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Gerber + DFM</text>
  <path d="M514,91 L540,91" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a1)"/>
  <!-- Phase 4 -->
  <rect x="543" y="55" width="130" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="608" y="82" font-size="9" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 4</text>
  <text x="608" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Prototype</text>
  <text x="608" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EVT / DVT / PVT</text>
  <path d="M675,91 L701,91" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a1)"/>
  <!-- Phase 5 -->
  <rect x="704" y="55" width="130" height="72" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="769" y="82" font-size="9" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 5</text>
  <text x="769" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Certification</text>
  <text x="769" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">FCC / CE / UL</text>
  <path d="M836,91 L862,91" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#a1)"/>
  <!-- Phase 6 -->
  <rect x="865" y="55" width="145" height="72" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="937" y="82" font-size="9" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="700" letter-spacing="1">PHASE 6</text>
  <text x="937" y="102" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Mass Production</text>
  <text x="937" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">NPI + QC</text>
  <!-- timeline note -->
  <text x="550" y="205" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Consumer: 6-18 months  |  Industrial / Medical: 18-36 months</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Phase 1 bug = ชั่วโมงวิศวกร. Phase 6 bug = field recall ทั้ง batch. ต้นทุนเพิ่มแบบ exponential ยิ่งค้นพบช้า</div>

<!-- Speaker: The cost gradient is the core reason this lifecycle exists. Every gate is an investment that pays back in prevented downstream failures. -->

---

## Hardware Bug ต่างจาก Software Bug — ขั้นฐานราก

<p class="subhead">Software: push fix ใหม่. Hardware: recall batch + rework หรือทิ้ง PCB ทั้งหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- software panel -->
  <rect x="40" y="25" width="470" height="270" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="25" width="470" height="52" rx="12" fill="var(--soft)"/>
  <text x="275" y="57" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Software Bug</text>
  <text x="75" y="112" font-size="14" fill="var(--ink)" font-family="system-ui">Bug discovered in production</text>
  <text x="75" y="140" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Push fix commit to repo</text>
  <text x="75" y="168" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Deploy: users get fix in minutes</text>
  <text x="75" y="232" font-size="14" fill="var(--success-ink)" font-family="system-ui" font-weight="700">Cost: hours of engineer time</text>
  <!-- hardware panel -->
  <rect x="590" y="25" width="470" height="270" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="25" width="470" height="52" rx="12" fill="var(--accent-wash)"/>
  <text x="825" y="57" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Hardware Bug</text>
  <text x="625" y="112" font-size="14" fill="var(--ink)" font-family="system-ui">Bug discovered after mass production</text>
  <text x="625" y="140" font-size="14" fill="var(--danger)" font-family="system-ui">Halt production line</text>
  <text x="625" y="168" font-size="14" fill="var(--danger)" font-family="system-ui">Recall all shipped units</text>
  <text x="625" y="196" font-size="14" fill="var(--danger)" font-family="system-ui">Re-spin PCB (new NRE cost)</text>
  <text x="625" y="232" font-size="14" fill="var(--danger-ink)" font-family="system-ui" font-weight="700">Cost: $10,000 - $1,000,000+ per incident</text>
  <!-- VS badge -->
  <circle cx="550" cy="160" r="30" fill="var(--ink)"/>
  <text x="550" y="165" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lifecycle process ไม่ใช่ overhead — มันคือ insurance policy ที่ป้องกัน field recall ซึ่งแพงกว่า DVT testing 10-100 เท่า</div>

<!-- Speaker: This fundamental asymmetry drives the entire lifecycle discipline. You cannot hotpatch a PCB after it ships. -->

---

## Phase 1: Concept — Product Specification คือ Risk Contract

<p class="subhead">ทุก requirement ที่ไม่ชัดเจนใน Phase 1 จะกลายเป็น rework ที่แพงใน Phase 3-4</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Functional Requirements</p>
    <h3>ทำอะไรได้บ้าง?</h3>
    <p>Connectivity (Wi-Fi / BT / Zigbee), power budget, form factor, I/O count, operating voltage range</p>
  </div>
  <div class="card warning">
    <p class="label">Non-Functional Requirements</p>
    <h3>ทนแค่ไหน?</h3>
    <p>IP rating, temperature range (-20 to +85C?), drop test (IEC 60068), MTBF target, EMC class requirement</p>
  </div>
  <div class="card gold">
    <p class="label">Market and Regulatory Target</p>
    <h3>ขายที่ไหน?</h3>
    <p>กำหนด certification ที่ต้องผ่าน: FCC (US), CE (EU), UL (US/CA), RoHS (EU+CA) — ส่งผลต่อ PCB design ตั้งแต่ต้น</p>
  </div>
  <div class="card danger">
    <p class="label">Cost Target</p>
    <h3>BOM Cost สูงสุดเท่าไร?</h3>
    <p>Lock BOM cost ceiling ก่อน component selection — ถ้าไม่มี target จะเลือก IC แพงเกิน margin และแก้ยากภายหลัง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Scope Creep — เพิ่ม feature กลางโปรเจกต์โดยไม่ update spec document — คือสาเหตุหลักที่ทำให้ hardware project พัง schedule และ budget</div>

<!-- Speaker: Each requirement type constrains the design space differently. The regulatory target is especially critical because it determines PCB shielding, component choices, and test budget from day one. -->

---

## Phase 2: Component Selection ตัดสินชะตาโปรเจกต์ตั้งแต่ต้น

<p class="subhead">Lifecycle status + lead time คือ risk ที่มองไม่เห็นใน BOM spreadsheet — ต้อง verify ก่อน commit</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L8,3 L0,6 Z" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Step boxes row 1 -->
  <rect x="30" y="50" width="155" height="65" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="107" y="77" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700">INPUT</text>
  <text x="107" y="97" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Product Spec</text>
  <path d="M187,82 L210,82" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="213" y="50" width="185" height="65" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="305" y="77" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui" font-weight="700">STEP 1</text>
  <text x="305" y="97" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">System Block Diagram</text>
  <path d="M400,82 L423,82" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="426" y="50" width="205" height="65" rx="10" fill="var(--soft)" stroke="var(--warning)" stroke-width="2"/>
  <text x="528" y="77" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">STEP 2</text>
  <text x="528" y="97" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Component Selection + AVL</text>
  <path d="M633,82 L656,82" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="659" y="50" width="155" height="65" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="736" y="77" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui" font-weight="700">STEP 3</text>
  <text x="736" y="97" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">BOM + Costing</text>
  <path d="M816,82 L839,82" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <rect x="842" y="50" width="195" height="65" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="939" y="77" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">OUTPUT</text>
  <text x="939" y="97" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui" font-weight="600">Proof of Concept</text>
  <!-- Checklist table -->
  <rect x="30" y="145" width="1040" height="145" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="50" y="170" font-size="11" fill="var(--muted)" font-family="system-ui" font-weight="700" letter-spacing="1">COMPONENT SELECTION CHECKLIST</text>
  <text x="50" y="198" font-size="13" fill="var(--ink)" font-family="system-ui" font-weight="600">Lifecycle Status</text>
  <text x="310" y="198" font-size="13" fill="var(--ink)" font-family="system-ui" font-weight="600">Lead Time</text>
  <text x="570" y="198" font-size="13" fill="var(--ink)" font-family="system-ui" font-weight="600">Alternate Vendor (AVL)</text>
  <text x="830" y="198" font-size="13" fill="var(--ink)" font-family="system-ui" font-weight="600">Thermal Rating</text>
  <text x="50" y="224" font-size="12" fill="var(--danger)" font-family="system-ui">EOL mid-project = halt</text>
  <text x="310" y="224" font-size="12" fill="var(--danger)" font-family="system-ui">52+ weeks = blocker</text>
  <text x="570" y="224" font-size="12" fill="var(--warning-ink)" font-family="system-ui">No AVL = single-point-of-failure</text>
  <text x="830" y="224" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Match operating range</text>
  <text x="50" y="272" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Active / NRND / EOL</text>
  <text x="310" y="272" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Target: under 26 weeks</text>
  <text x="570" y="272" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Pin-compatible replacement list</text>
  <text x="830" y="272" font-size="12" fill="var(--ink-dim)" font-family="system-ui">-40C to +125C industrial</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ในช่วง 2021-2023 บาง MCU มี lead time 52-104 สัปดาห์ — โปรเจกต์ที่ไม่ plan component lead time ล่วงหน้าต้องรอทั้งหมดแม้ design พร้อมแล้ว</div>

<!-- Speaker: Component lifecycle and lead time are invisible risks in the BOM. Always check the lifecycle status before finalizing part numbers, and always build an Alternate Vendor List for every critical component. -->

---

## Phase 3: PCB Design แบ่งเป็น 3 Gate ตามลำดับ

<p class="subhead">Schematic = ถูกไฟฟ้าไหม? Layout = ถูก physical ไหม? DFM = ผลิตในโรงงานได้ไหม?</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a3" markerWidth="10" markerHeight="10" refX="7" refY="4" orient="auto">
      <path d="M0,0 L10,4 L0,8 Z" fill="var(--accent)"/>
    </marker>
  </defs>
  <!-- Schematic box -->
  <rect x="40" y="30" width="290" height="205" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="290" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="185" y="62" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Schematic Design</text>
  <text x="60" y="110" font-size="13" fill="var(--ink)" font-family="system-ui">Select components + part numbers</text>
  <text x="60" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Electrical Rule Check (ERC)</text>
  <text x="60" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">SPICE simulation (critical paths)</text>
  <rect x="60" y="198" width="230" height="22" rx="6" fill="var(--accent-wash)"/>
  <text x="175" y="213" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui" font-weight="700">Output: Netlist + final BOM</text>
  <!-- arrow 1 -->
  <path d="M332,132 L365,132" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <!-- Layout box -->
  <rect x="368" y="30" width="290" height="205" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="368" y="30" width="290" height="52" rx="14" fill="var(--soft)"/>
  <text x="513" y="62" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PCB Layout</text>
  <text x="388" y="110" font-size="13" fill="var(--ink)" font-family="system-ui">Component placement by function</text>
  <text x="388" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Trace routing + impedance control</text>
  <text x="388" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">4-layer stack-up: Sig/GND/Pwr/Sig</text>
  <rect x="388" y="198" width="230" height="22" rx="6" fill="var(--soft-2)"/>
  <text x="503" y="213" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui" font-weight="700">Output: PCB layout file</text>
  <!-- arrow 2 -->
  <path d="M660,132 L693,132" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#a3)"/>
  <!-- DFM box -->
  <rect x="696" y="30" width="350" height="205" rx="14" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="696" y="30" width="350" height="52" rx="14" fill="var(--warning-wash)"/>
  <text x="871" y="62" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">DFM Review</text>
  <text x="716" y="110" font-size="13" fill="var(--ink)" font-family="system-ui">Footprint + clearance check</text>
  <text x="716" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Pick-and-place orientation rules</text>
  <text x="716" y="160" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Solder mask, via-in-pad, ICT points</text>
  <rect x="716" y="198" width="290" height="22" rx="6" fill="var(--warning-wash)"/>
  <text x="861" y="213" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Output: Gerber files to PCB house</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DFM ควร apply ตั้งแต่ Layout phase — PCB spin เพราะ footprint ผิด = NRE $1,000-$5,000 + 3-4 สัปดาห์ รอบใหม่</div>

<!-- Speaker: Each gate catches what the previous one cannot. DFM in particular is often treated as optional — it is not. Manufacturing defects discovered post-production cost 10-50x more to fix than a pre-Gerber DFM review. -->

---

## PCB Layout: 3 Principles กำหนด EMI, Yield และ Thermal

<p class="subhead">การวาง component และ routing ผิดทำให้เกิด EMI interference, solder defect และ thermal hotspot</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Component Placement</p>
    <h3>Placement by Function Group</h3>
    <p>Decoupling cap ต้องอยู่ใกล้ IC power pin (ห่างไม่เกิน 0.5mm). RF component ต้องแยกห่างจาก switching PSU เพื่อลด interference.</p>
  </div>
  <div class="card warning">
    <p class="label">Trace Routing</p>
    <h3>Impedance Control</h3>
    <p>High-speed signal (DDR4/USB/PCIe) ต้องการ controlled impedance 50ohm (single-ended) หรือ 100ohm (differential). Width คำนวณจาก stack-up.</p>
  </div>
  <div class="card success">
    <p class="label">Layer Stack-up</p>
    <h3>4-Layer Standard</h3>
    <p>Signal / GND / Power / Signal — GND layer เป็น return path และ EMI shield. Symmetric copper pour ป้องกัน board warpage ตอน reflow.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Min trace width: 0.1mm (standard), 0.075mm (advanced). Solder mask dam ระหว่าง pad ต้องไม่น้อยกว่า 0.1mm เพื่อป้องกัน solder bridging</div>

<!-- Speaker: These three principles are interconnected. Poor placement forces bad routing; bad routing causes EMI; bad stack-up causes both EMI and board warpage during reflow. -->

---

## DFM Prevents Manufacturing Defects Before Gerbers Leave

<p class="subhead">DFM checklist 3 phase: Layout geometry → Placement rules → Routing constraints</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Phase 1 — Layout Review</p>
    <h3>Footprint Verification</h3>
    <p>ตรวจ pad size, courtyard clearance, silkscreen overlap. Footprint ผิดทำให้ solder joint เสีย — ไม่พบจนกว่าจะ reflow แล้ว</p>
    <ul>
      <li>Pad size vs land pattern spec</li>
      <li>Component-to-component clearance</li>
      <li>Edge clearance (&gt; 0.5mm)</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Phase 2 — Placement Rules</p>
    <h3>Machine Compatibility</h3>
    <p>Pick-and-place ต้องการ component orientation ที่ consistent และ fiducial mark ที่ถูกต้อง — ขาด = assembly line หยุด</p>
    <ul>
      <li>Fiducial marks (3 จุดขั้นต่ำ)</li>
      <li>Polarized component orientation</li>
      <li>SMD vs through-hole mix rules</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">Phase 3 — Routing Constraints</p>
    <h3>Solder and Test Points</h3>
    <p>Via-in-pad ทำให้ solder ไหลลง via ระหว่าง reflow — ต้องใช้ filled/capped via เท่านั้น ห้ามใช้ open via ใน pad</p>
    <ul>
      <li>Test points ทุก critical net (ICT)</li>
      <li>Via-in-pad: filled/capped only</li>
      <li>Solder mask dam &gt; 0.1mm</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Failure modes ที่พบบ่อย: tombstoning (pad asymmetry), solder bridging (mask dam แคบ), board warpage (copper imbalance) — ป้องกันได้ทั้งหมดด้วย DFM review ก่อน submit Gerber</div>

<!-- Speaker: Many EMS factories offer free DFM review — always take it. The cost of one board spin due to a footprint error exceeds the cost of a thorough DFM review by 10-100x. -->

---

## EVT / DVT / PVT: แต่ละ Gate ตอบคำถามที่ต่างกัน

<p class="subhead">ข้าม DVT = ความเสี่ยงสูงสุด — EVT prototype ไม่การันตี production yield เลย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Engineering Validation Test</p>
    <h3>EVT: ทำงานได้ไหม?</h3>
    <p><b>Sample:</b> 5-20 pcs (hand-soldered)<br><b>Build:</b> ไม่ต้อง production-intent</p>
    <ul>
      <li>Basic functionality ทุก feature</li>
      <li>Thermal hotspot detection</li>
      <li>RF interference check</li>
      <li>Power sequencing validation</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Design Validation Test</p>
    <h3>DVT: รอดโลกจริงไหม?</h3>
    <p><b>Sample:</b> ~50 pcs (production-intent)<br><b>Build:</b> injection-molded enclosure</p>
    <ul>
      <li>Thermal cycling (-20C to +85C)</li>
      <li>Vibration + Drop (IEC 60068)</li>
      <li>EMC pre-compliance scan</li>
      <li>Regulatory certification (FCC/CE)</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Production Validation Test</p>
    <h3>PVT: Factory ทำซ้ำได้ไหม?</h3>
    <p><b>Sample:</b> 50-500 pcs (production line)<br><b>Build:</b> SMT reflow + wave solder</p>
    <ul>
      <li>First Pass Yield (FPY) measurement</li>
      <li>Assembly line bottleneck map</li>
      <li>ICT coverage verification</li>
      <li>QC protocol finalization</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Hand-soldered EVT prototype ต่างจาก SMT reflow อย่างมาก — yield จริงวัดได้จาก PVT เท่านั้น. Field recall cost 10-100x ของ DVT testing</div>

<!-- Speaker: Think of EVT as unit test, DVT as integration test under environmental stress, PVT as load testing the factory itself. Each answers a completely different question. -->

---

## Regulatory Certification ต้อง Plan ตั้งแต่ Phase 1

<p class="subhead">certification ส่งผลต่อ PCB design และ component choice ตั้งแต่ต้น — ไม่ใช่ขั้นตอนสุดท้าย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">United States</p>
    <h3>FCC Part 15</h3>
    <p>EMC + RF emission. Intentional radiators (Wi-Fi/BT) แพงกว่ามาก — ใช้ pre-certified module ลด cost ได้ 10x</p>
  </div>
  <div class="card gold">
    <p class="label">European Union</p>
    <h3>CE Marking</h3>
    <p>Safety + EMC + Radio รวมกัน. ครอบคลุม Low Voltage Directive และ Radio Equipment Directive (RED)</p>
  </div>
  <div class="card success">
    <p class="label">US / Canada</p>
    <h3>UL Listed</h3>
    <p>Electrical safety: ป้องกัน fire + electric shock. Required by retailers + insurance สำหรับ AC-powered devices</p>
  </div>
  <div class="card warning">
    <p class="label">EU + California</p>
    <h3>RoHS</h3>
    <p>ห้ามสาร hazardous: Pb, Hg, Cd. ครอบคลุมทุกชิ้นส่วน: PCB, enclosure, สกรู, สายไฟ — ต้องมี CoC จาก supplier</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อุปกรณ์ wireless: ใช้ pre-certified module (ESP32 / Nordic nRF พร้อม FCC ID) ทำให้ test เป็น "unintentional radiator" — ประหยัด $5,000-$15,000 และ 4-8 สัปดาห์</div>

<!-- Speaker: The choice of pre-certified vs custom radio is a $10,000-$50,000 decision that must be made in Phase 1. It cannot be changed after the PCB is designed. -->

---

## Phase 6: Mass Production คือ Handoff Package

<p class="subhead">NPI (New Product Introduction) คือกระบวนการส่งมอบ design ให้ EMS พร้อม scale production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">NPI Handoff</p>
    <h3>Production Package</h3>
    <p>Gerber files, BOM + AVL, assembly drawing, test spec, golden sample, IPC class requirement (Class 2 or 3)</p>
  </div>
  <div class="card warning">
    <p class="label">Supply Chain</p>
    <h3>MOQ + Buffer Stock</h3>
    <p>เจรจา Minimum Order Quantity (MOQ). สำรอง buffer stock สำหรับ long lead-time component ป้องกัน production halt</p>
  </div>
  <div class="card success">
    <p class="label">Quality Control</p>
    <h3>AQL + ICT + AOI</h3>
    <p>Acceptable Quality Level (AQL) สำหรับ incoming inspection. ICT coverage ควรเกิน 85%. AOI ทุก board ก่อน shipment</p>
  </div>
  <div class="card gold">
    <p class="label">Post-Market</p>
    <h3>Field Feedback Loop</h3>
    <p>ติดตาม MTBF, field failure rate, warranty claims → feedback กลับ engineering สำหรับ next revision ผ่าน ECO/ECN process</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Mass Production ไม่ใช่จุดสิ้นสุด — Field failure data เป็น input ที่มีค่าที่สุดสำหรับ DFM improvement และ next product revision</div>

<!-- Speaker: Many engineers think their job ends at PVT approval. But post-market MTBF data reveals failure modes that no lab test uncovered — it drives the next design cycle. -->

---

## 4 Common Mistakes ที่ Kill Hardware Startups

<p class="subhead">ข้อผิดพลาดเหล่านี้ฆ่าโปรเจกต์ใน DVT/certification phase ที่แพงที่สุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Mistake 1 — Certification</p>
    <h3>ไม่ทำ EMC Pre-compliance</h3>
    <p>ส่ง cert lab โดยไม่ scan near-field emission ด้วย probe ก่อน → fail FCC/CE → $5,000-$15,000 + 4-8 สัปดาห์ต่อ fail ครั้ง. แก้: ซื้อ near-field probe kit $500 แล้ว scan เองก่อน</p>
  </div>
  <div class="card danger">
    <p class="label">Mistake 2 — Assembly</p>
    <h3>ผสม Lead-Free + Leaded</h3>
    <p>Lead-free reflow ต้องการ peak 260C; leaded 183C. ผสมบน PCB เดียวกัน = solder joint failure ทุก board. แก้: กำหนด solder standard ตั้งแต่ BOM phase</p>
  </div>
  <div class="card warning">
    <p class="label">Mistake 3 — Supply Chain</p>
    <h3>ไม่ Check Component Lifecycle</h3>
    <p>เลือก IC โดยไม่ตรวจ lifecycle status → EOL กลางโปรเจกต์ → หา alternate ไม่ได้ → re-spin PCB. แก้: AVL ทุก critical component ตั้งแต่ Phase 2</p>
  </div>
  <div class="card warning">
    <p class="label">Mistake 4 — Scope</p>
    <h3>Scope Creep ไม่มี Change Control</h3>
    <p>เพิ่ม feature กลางโปรเจกต์โดยไม่ update requirement document → Phase 3-4 ต้อง rework → schedule พัง budget บาน. แก้: ECN process ทุก change request</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Mistake 1 และ 2 มักเจอใน DVT ซึ่งแก้แพงที่สุด — EMC pre-compliance scan และ solder standard ต้องตัดสินใจก่อน Phase 3 เสมอ</div>

<!-- Speaker: These four mistakes are extremely common and extremely expensive. The pre-compliance EMC scan ROI is immediate — one lab failure rejection costs more than the probe kit plus several months of testing. -->

---

## Key Takeaways

<p class="subhead">Electronics Product Design Life Cycle — 7 points ที่ต้องจำ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact">
    <p class="label">Lifecycle</p>
    <p>6 phases: Concept → System Arch → PCB Design → EVT/DVT/PVT → Certification → Mass Production. แต่ละ gate กรองความเสี่ยงก่อนต้นทุนเพิ่ม</p>
  </div>
  <div class="card compact warning">
    <p class="label">PCB Design</p>
    <p>3 gate: Schematic (ERC) → Layout (impedance) → DFM (footprint/ICT). DFM ที่ดีลด defect rate และ NRE cost ได้มหาศาล</p>
  </div>
  <div class="card compact danger">
    <p class="label">EVT / DVT / PVT</p>
    <p>ข้าม DVT = ความเสี่ยงสูงสุด. EVT prototype ไม่ตัวแทน production yield. Field recall แพงกว่า DVT testing 10-100 เท่า</p>
  </div>
  <div class="card compact gold">
    <p class="label">Certification</p>
    <p>Plan Phase 1. Pre-certified module (ESP32/nRF) ลด FCC cost $5k-$15k. RoHS ครอบคลุมทุกชิ้นส่วน ไม่ใช่แค่ PCB</p>
  </div>
  <div class="card compact">
    <p class="label">Component Risk</p>
    <p>Lifecycle + lead time + AVL = BOM hygiene ที่ต้องทำตั้งแต่ Phase 2. EOL component กลางโปรเจกต์ = production halt</p>
  </div>
  <div class="card compact success">
    <p class="label">Timeline</p>
    <p>Consumer: 6-18 เดือน. Industrial/Medical: 18-36 เดือน. Bug fix cost เพิ่ม exponential ยิ่งค้นพบช้า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Hardware lifecycle คือ risk management — แต่ละ gate ไม่ใช่ bureaucracy แต่คือ insurance policy ที่คุ้มค่าเสมอเมื่อเทียบกับต้นทุนของการข้าม</div>

<!-- Speaker: The core message: hardware development is about preventing expensive mistakes from propagating to later stages where they cost exponentially more to fix. Every gate is worth the time it takes. -->
