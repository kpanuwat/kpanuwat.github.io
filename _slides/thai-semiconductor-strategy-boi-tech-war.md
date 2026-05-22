---
marp: true
theme: default
paginate: true
title: "ยุทธศาสตร์เซมิคอนดักเตอร์ไทย"
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

# ยุทธศาสตร์เซมิคอนดักเตอร์ไทย

<p class="tag">BOI + Tech War → Mature Node Chip &gt;10nm — โอกาส $79B ปี 2050</p>

<!-- Speaker: 3 แรงขับ — BOI incentives, Tech War Friendshoring, National Roadmap 2050. เป้าคือ Mature Node ≥10nm ไม่ใช่แข่ง TSMC -->

---

## ไทยติดอยู่ใน "ขาประกอบ" — เป้าหมายใหม่คือ "ขาผลิตชิป"

<p class="subhead">70% ของบริษัทเซมิฯ ในไทยเน้น Back-End มูลค่าต่ำ — BOI + Roadmap 2050 กำหนดเส้นทางยกระดับสู่ IC Design + Mature Node Fab</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="300" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="30" width="300" height="48" rx="12" fill="var(--soft)"/>
  <text x="180" y="60" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Front-End</text>
  <text x="65" y="112" font-size="14" fill="var(--muted)" font-family="system-ui">IC Design</text>
  <text x="65" y="140" font-size="14" fill="var(--muted)" font-family="system-ui">Wafer Fabrication</text>
  <text x="65" y="172" font-size="13" fill="var(--muted)" font-family="system-ui">มูลค่าเพิ่ม: สูงมาก</text>
  <rect x="65" y="196" width="220" height="26" rx="5" fill="var(--danger-wash)"/>
  <text x="175" y="214" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">สถานะไทย: อ่อนแอ</text>

  <rect x="390" y="30" width="320" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="390" y="30" width="320" height="48" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="550" y="60" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Back-End (ปัจจุบัน)</text>
  <text x="425" y="112" font-size="14" fill="var(--ink)" font-family="system-ui">Assembly + Test + Package</text>
  <text x="425" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">PCB Manufacturing</text>
  <text x="425" y="168" font-size="13" fill="var(--accent)" font-weight="700" font-family="system-ui">#1 ใน ASEAN</text>
  <text x="425" y="196" font-size="13" fill="var(--muted)" font-family="system-ui">มูลค่าเพิ่ม: ปานกลาง-ต่ำ</text>
  <rect x="425" y="220" width="240" height="26" rx="5" fill="var(--success-wash)"/>
  <text x="545" y="238" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">สถานะไทย: แข็งแกร่ง</text>

  <rect x="770" y="30" width="300" height="300" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="770" y="30" width="300" height="48" rx="12" fill="var(--warning-wash)"/>
  <text x="920" y="60" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">เป้าหมายใหม่</text>
  <text x="805" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">ชิป Mature Node &gt;10nm</text>
  <text x="805" y="133" font-size="14" fill="var(--ink)" font-family="system-ui">Advanced Test</text>
  <text x="805" y="161" font-size="14" fill="var(--ink)" font-family="system-ui">Power / Sensor / IoT</text>
  <text x="805" y="190" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่แข่ง TSMC 3-5nm</text>
  <rect x="805" y="215" width="230" height="26" rx="5" fill="var(--warning-wash)"/>
  <text x="920" y="233" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">BOI + Roadmap 2050</text>

  <defs>
    <marker id="a1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M0 0L10 5L0 10z" fill="var(--muted)"/></marker>
    <marker id="a2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M0 0L10 5L0 10z" fill="var(--gold)"/></marker>
  </defs>
  <line x1="330" y1="180" x2="388" y2="180" stroke="var(--muted)" stroke-width="2" marker-end="url(#a1)"/>
  <line x1="712" y1="180" x2="768" y2="180" stroke="var(--gold)" stroke-width="2.5" stroke-dasharray="6 3" marker-end="url(#a2)"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทยต้องข้าม "ช่องว่างมูลค่า" จาก Back-End สู่ Mature Node Fab — ฐาน PCB #1 ASEAN คือรันเวย์</div>

<!-- Speaker: Micron, Sony, Toshiba, Rohm ที่อยู่ไทยทำ Back-End ทั้งนั้น; เป้าคือดึง Front-End ชิปที่ Automotive/EV ต้องการ -->

---

## BOI เปลี่ยนเกม: ปิดประตู Pass-Through เปิดประตู IC Design

<p class="subhead">ยกเว้นภาษีนิติบุคคล 13+ ปีสำหรับ IC Design/Wafer Fab + บล็อก "ธุรกิจผ่านแดน" ที่ไม่สร้างมูลค่าเพิ่มจริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="460" height="300" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5" stroke-opacity=".4"/>
  <rect x="30" y="30" width="460" height="48" rx="12" fill="var(--danger-wash)"/>
  <text x="260" y="60" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ก่อน: Pass-Through (ยกเลิกแล้ว)</text>
  <text x="70" y="112" font-size="14" fill="var(--danger-ink)" font-family="system-ui">นำเข้าชิ้นส่วน → ประกอบง่าย → ส่งออก</text>
  <text x="70" y="144" font-size="14" fill="var(--danger-ink)" font-family="system-ui">ไม่สร้าง Value ในไทย</text>
  <text x="70" y="176" font-size="14" fill="var(--danger-ink)" font-family="system-ui">ได้รับสิทธิ BOI โดยไม่ผลิตจริง</text>
  <rect x="70" y="210" width="370" height="30" rx="6" fill="var(--danger)" opacity=".15"/>
  <text x="255" y="231" font-size="14" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">BOI ยกเลิกสิทธิ์แล้ว</text>
  <text x="70" y="275" font-size="13" fill="var(--danger-ink)" font-family="system-ui">+ ร่วมศุลกากรตรวจ 100% Export Controls</text>
  <text x="70" y="296" font-size="13" fill="var(--danger-ink)" font-family="system-ui">ป้องกันชิป AI ลักลอบไปจีนผ่านไทย</text>

  <circle cx="550" cy="180" r="32" fill="var(--accent)"/>
  <text x="550" y="185" font-size="24" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">→</text>

  <rect x="610" y="30" width="460" height="300" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5" stroke-opacity=".5"/>
  <rect x="610" y="30" width="460" height="48" rx="12" fill="var(--success-wash)"/>
  <text x="840" y="60" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ใหม่: Significant Manufacturing</text>
  <text x="650" y="108" font-size="14" fill="var(--ink)" font-family="system-ui">IC Design / Wafer Fabrication</text>
  <rect x="690" y="118" width="340" height="24" rx="4" fill="var(--accent)" opacity=".1"/>
  <text x="860" y="135" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ยกเว้นภาษีนิติบุคคล 13+ ปี</text>
  <text x="650" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">EEC + Direct PPA 2,000 MW</text>
  <text x="650" y="200" font-size="14" fill="var(--ink)" font-family="system-ui">นำเข้าเครื่องจักร + วัตถุดิบ</text>
  <text x="650" y="230" font-size="14" fill="var(--ink)" font-family="system-ui">Fast-track พลังงานหมุนเวียน</text>
  <rect x="650" y="260" width="370" height="30" rx="6" fill="var(--success)" opacity=".12"/>
  <text x="835" y="281" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">FDI คุณภาพสูงที่สร้างมูลค่าจริง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> BOI ไม่ได้แค่ "โปรย" สิทธิประโยชน์ — แต่ "คัดกรอง" เฉพาะการผลิตที่สร้างมูลค่าเพิ่มในไทยจริง</div>

<!-- Speaker: Anti-Passthrough เป็น structural change ใหญ่ ทำให้ BOI น่าเชื่อถือกับ FDI ที่จริงจัง -->

---

## Tech War คือลมหนุน: Friendshoring ดัน FDI ไหลเข้าไทย

<p class="subhead">CHIPS Act $52B + ส่งออกชิปไปสหรัฐฯ +62% (2023) — "ความเป็นกลางไทย" ทำให้รับ FDI ได้ทั้งสองฝ่าย</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/thai-semiconductor-strategy-boi-tech-war-2.png" alt="US-China Tech War Friendshoring geopolitical map">
<figcaption>Source: NotebookLM · US-China Tech War Friendshoring — Thailand's neutral-state advantage</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ความเป็นกลางไทยคือ "ทรัพย์สินหายาก" — แต่ต้องรักษา Export Controls compliance เพื่อความน่าเชื่อถือระยะยาว</div>

<!-- Speaker: CHIPS Act context, ทำไม neutrality เป็น strategic asset, ความเสี่ยงถ้า Export Controls tighten -->

---

## ASEAN Race: ไทยต้องแซงมาเลเซียใน Back-End ซับซ้อน

<p class="subhead">มาเลเซียครอง 13% Global APT — เวียดนามรุกเร็วแต่ขาดวิศวกร — ไทยต้องเลือกช่องว่างที่ Differentiate ได้</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/thai-semiconductor-strategy-boi-tech-war-3.png" alt="ASEAN semiconductor competition Thailand Vietnam Malaysia comparison">
<figcaption>Source: NotebookLM · ASEAN Semiconductor Powerhouses — Malaysia / Vietnam / Thailand comparison</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทยชนะด้วย Automotive/EV Ecosystem — ไม่ใช่ราคา; เป้าระยะสั้นคือแย่งส่วนแบ่ง APT จากมาเลเซีย</div>

<!-- Speaker: Malaysia = immediate threat with NSS + Intel; Vietnam = emerging but energy/talent gaps; Thailand differentiates via EV linkage -->

---

## Roadmap 2050: $79B + 230K คน + 5 กลุ่มชิปเป้าหมาย

<p class="subhead">3 Phase ใน 24 ปี — ระยะสั้นเน้น Back-End ซับซ้อน; ระยะยาวเป้า Mature Node Fab ที่ Cluster ลำพูน-ลำปาง</p>

<div class="infographic" style="flex-direction:column;align-items:stretch;gap:10px;">
<svg viewBox="0 0 1100 200" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="60" y1="68" x2="1040" y2="68" stroke="var(--muted)" stroke-width="2"/>

  <circle cx="160" cy="68" r="16" fill="var(--accent)"/>
  <text x="160" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="160" y="42" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2026-2030</text>
  <rect x="78" y="90" width="164" height="92" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="160" y="116" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FDI Back-End</text>
  <text x="160" y="136" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">LTR Visa + BOI</text>
  <text x="160" y="156" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">100K Workforce</text>

  <circle cx="460" cy="68" r="16" fill="var(--accent)" opacity=".7"/>
  <text x="460" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="460" y="42" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2030-2040</text>
  <rect x="372" y="90" width="176" height="92" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" opacity=".7"/>
  <text x="460" y="116" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Advanced Test</text>
  <text x="460" y="136" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Power/Sensor Chip</text>
  <text x="460" y="156" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IC Design Hub</text>

  <circle cx="770" cy="68" r="16" fill="var(--accent)" opacity=".5"/>
  <text x="770" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="770" y="42" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2040-2050</text>
  <rect x="682" y="90" width="176" height="92" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" opacity=".5"/>
  <text x="770" y="116" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Mature Node Fab</text>
  <text x="770" y="136" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">chip &gt;10nm</text>
  <text x="770" y="156" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Lamphun Cluster</text>

  <circle cx="1000" cy="68" r="22" fill="var(--warning)"/>
  <text x="1000" y="42" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Target</text>
  <text x="1000" y="73" font-size="12" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2050</text>
  <text x="1000" y="110" font-size="13" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">$79B</text>
  <text x="1000" y="130" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">230K คน</text>
</svg>
<div class="bento cols-5" style="padding:4px 0 0;">
  <div class="card compact">
    <p class="label">Si/SiC</p>
    <div style="font-size:14px;font-weight:700;color:var(--accent);">Power</div>
  </div>
  <div class="card compact">
    <p class="label">Auto/IoT</p>
    <div style="font-size:14px;font-weight:700;color:var(--accent);">Sensor</div>
  </div>
  <div class="card compact">
    <p class="label">Light-based</p>
    <div style="font-size:14px;font-weight:700;color:var(--accent);">Photonics</div>
  </div>
  <div class="card compact">
    <p class="label">Mixed-Signal</p>
    <div style="font-size:14px;font-weight:700;color:var(--accent);">Analog</div>
  </div>
  <div class="card compact gold">
    <p class="label">Automotive link</p>
    <div style="font-size:14px;font-weight:700;color:var(--warning-ink);">EV Ecosystem</div>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 3 Phase ใน 24 ปี — ชัยชนะระยะสั้นคือ Back-End ซับซ้อน; เป้าระยะยาวคือ Mature Node Fab ที่ Lamphun ปี 2040+</div>

<!-- Speaker: เน้น 5 target chips ที่ lock-in กับ Automotive/EV ที่มีอยู่แล้ว — ไม่ greenfield; ระยะสั้นสำคัญที่สุดในการพิสูจน์ capability -->

---

## 5 ปัจจัยที่อาจพลิกเกม: แผนดีต้องแก้โจทย์จริง

<p class="subhead">แรงงาน · Fab · พลังงาน · Geopolitics · Incentive War — ทั้ง 5 ต้องแก้คู่ขนาน ไม่ใช่รอผลัดกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card danger compact">
    <p class="label">Critical</p>
    <h3>แรงงาน</h3>
    <p>ขาดวิศวกร Semicon<br>ต้องการ 100K+</p>
    <p class="label" style="margin-top:8px;">LTR Visa + งบ 2B บาท</p>
  </div>
  <div class="card danger compact">
    <p class="label">Critical</p>
    <h3>Fab</h3>
    <p>ยังไม่มี Wafer Fab<br>Commercial Scale</p>
    <p class="label" style="margin-top:8px;">ต้องการ FDI ขนาดใหญ่</p>
  </div>
  <div class="card warning compact">
    <p class="label">Important</p>
    <h3>พลังงาน</h3>
    <p>Fab ใช้ไฟสูงมาก<br>ต้นทุน + เสถียรภาพ</p>
    <p class="label" style="margin-top:8px;">Direct PPA 2GW</p>
  </div>
  <div class="card warning compact">
    <p class="label">Important</p>
    <h3>Geopolitics</h3>
    <p>ความเป็นกลาง<br>ยากในระยะยาว</p>
    <p class="label" style="margin-top:8px;">Export Controls เข้มขึ้น</p>
  </div>
  <div class="card success compact">
    <p class="label">Manageable</p>
    <h3>Incentive War</h3>
    <p>VN / MY / IN แข่งกัน<br>ต้อง Differentiate</p>
    <p class="label" style="margin-top:8px;color:var(--success-ink);">Ecosystem ไม่ใช่แค่ราคา</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทยชนะด้วย Ecosystem (Auto/EV + PCB Base) — กลยุทธ์ Differentiation คือเส้นแบ่งระหว่างชนะ vs แพ้ใน Incentive War</div>

<!-- Speaker: ทั้ง 5 ต้องแก้คู่กัน ไม่มีตัวไหนที่รอได้; Red/Yellow = urgent, Green = manageable -->

---

## สรุป: ไทยมีโอกาสสูง — แต่ต้องเร็ว เลือกช่อง และสร้างคน

<p class="subhead">จุดแข็งมีพร้อม — BOI พร้อม — ลมเป็นใจ; สิ่งที่เหลือคือการดำเนินการเร็วกว่าคู่แข่ง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card" style="display:flex;flex-direction:column;">
    <h3 style="color:var(--accent);margin-bottom:10px;">จุดแข็ง + โอกาสที่มีแล้ว</h3>
    <ul>
      <li>#1 PCB ใน ASEAN — รันเวย์พร้อม</li>
      <li>Automotive / EV Ecosystem ลึก</li>
      <li>Tech War → Friendshoring โอกาสทอง</li>
      <li>BOI ยกเว้นภาษี 13+ ปี (IC / Wafer)</li>
      <li>Export ชิปไปสหรัฐฯ +62% (2023)</li>
      <li style="color:var(--muted);">ไม่แข่ง TSMC — Mature &gt;10nm เท่านั้น</li>
    </ul>
  </div>
  <div class="card gold" style="display:flex;flex-direction:column;">
    <h3 style="color:var(--warning-ink);margin-bottom:10px;">สิ่งที่ต้องทำ (เร่งด่วน)</h3>
    <ul>
      <li>National Semicon Strategy ชัดเจน</li>
      <li>โปรแกรมวิศวกร 100K คน</li>
      <li>พลังงานหมุนเวียน 2,000 MW</li>
      <li>Lamphun-Lampang Cluster</li>
      <li style="color:var(--warning-ink);font-weight:700;">เร่งตัดสินใจก่อน MY / VN</li>
      <li style="color:var(--muted);">หน้าต่างโอกาส 2025-2030</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทย ≠ TSMC — ไปที่ Mature Node &gt;10nm ใน Niche ที่ Automotive/EV ต้องการ; ชนะถ้าสร้างคนเร็วและเลือก Cluster ถูก</div>

<!-- Speaker: 2025-2026 คือ critical decision window — ทุกเดือนที่ delay = Malaysia/Vietnam วิ่งหนีไปอีก -->
