---
marp: true
theme: default
paginate: true
title: "ยุทธศาสตร์เซมิคอนดักเตอร์ไทย"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; --gold:#f59e0b; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:26px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:15px; margin:0 0 6px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:10px 16px; border-radius:0 8px 8px 0; font-size:14px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; overflow:hidden; }
  .infographic img { max-height:340px; width:auto; border-radius:8px; box-shadow:0 4px 16px rgba(0,0,0,.12); }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; }
  section.title h1 { font-size:38px; color:white; margin:0 0 8px 0; line-height:1.25; }
  section.title p { color:#93c5fd; font-size:17px; margin:0; }
---

<!-- _class: title -->

# ยุทธศาสตร์เซมิคอนดักเตอร์ไทย
# BOI + Tech War → ชิป >10nm

ไทยจะก้าวจาก "ผู้ประกอบ" สู่ "ผู้ผลิตชิป" ได้หรือไม่? — โอกาส $79B ปี 2050

<!-- Speaker: 3 แรงขับ — BOI incentives, Tech War Friendshoring, National Roadmap 2050. เป้าคือ Mature Node ≥10nm ไม่ใช่แข่ง TSMC -->

---

## ไทยติดอยู่ใน "ขาประกอบ" — เป้าหมายใหม่คือ "ขาผลิตชิป"

<p class="subhead">70% ของบริษัทเซมิฯ ในไทยเน้น Back-End มูลค่าต่ำ — BOI + Roadmap 2050 กำหนดเส้นทางยกระดับสู่ IC Design + Mature Node Fab</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="300" height="300" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="30" width="300" height="48" rx="12" fill="var(--muted)" opacity="0.12"/>
  <text x="180" y="60" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Front-End</text>
  <text x="65" y="112" font-size="14" fill="var(--muted)" font-family="system-ui">IC Design</text>
  <text x="65" y="140" font-size="14" fill="var(--muted)" font-family="system-ui">Wafer Fabrication</text>
  <text x="65" y="172" font-size="13" fill="var(--muted)" font-family="system-ui">มูลค่าเพิ่ม: สูงมาก</text>
  <rect x="65" y="196" width="220" height="26" rx="5" fill="#fee2e2"/>
  <text x="175" y="214" font-size="13" font-weight="700" fill="#dc2626" text-anchor="middle" font-family="system-ui">สถานะไทย: อ่อนแอ</text>

  <rect x="390" y="30" width="320" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="390" y="30" width="320" height="48" rx="12" fill="var(--accent)" opacity="0.1"/>
  <text x="550" y="60" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Back-End (ปัจจุบัน)</text>
  <text x="425" y="112" font-size="14" fill="var(--ink)" font-family="system-ui">Assembly + Test + Package</text>
  <text x="425" y="140" font-size="14" fill="var(--ink)" font-family="system-ui">PCB Manufacturing</text>
  <text x="425" y="168" font-size="13" fill="var(--accent)" font-weight="700" font-family="system-ui">#1 ใน ASEAN</text>
  <text x="425" y="196" font-size="13" fill="var(--muted)" font-family="system-ui">มูลค่าเพิ่ม: ปานกลาง-ต่ำ</text>
  <rect x="425" y="220" width="240" height="26" rx="5" fill="#dcfce7"/>
  <text x="545" y="238" font-size="13" font-weight="700" fill="#16a34a" text-anchor="middle" font-family="system-ui">สถานะไทย: แข็งแกร่ง ✓</text>

  <rect x="770" y="30" width="300" height="300" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2"/>
  <rect x="770" y="30" width="300" height="48" rx="12" fill="var(--gold)" opacity="0.1"/>
  <text x="920" y="60" font-size="16" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">เป้าหมายใหม่ 🎯</text>
  <text x="805" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">ชิป Mature Node &gt;10nm</text>
  <text x="805" y="133" font-size="14" fill="var(--ink)" font-family="system-ui">Advanced Test</text>
  <text x="805" y="161" font-size="14" fill="var(--ink)" font-family="system-ui">Power / Sensor / IoT</text>
  <text x="805" y="190" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่แข่ง TSMC 3-5nm</text>
  <rect x="805" y="215" width="230" height="26" rx="5" fill="#fef9c3"/>
  <text x="920" y="233" font-size="13" font-weight="700" fill="#854d0e" text-anchor="middle" font-family="system-ui">BOI + Roadmap 2050</text>

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
  <rect x="30" y="30" width="460" height="300" rx="12" fill="#fff1f2" stroke="#fca5a5" stroke-width="1.5"/>
  <rect x="30" y="30" width="460" height="48" rx="12" fill="#fecaca" opacity="0.5"/>
  <text x="260" y="60" font-size="15" font-weight="700" fill="#991b1b" text-anchor="middle" font-family="system-ui">❌ ก่อน: Pass-Through</text>
  <text x="70" y="112" font-size="14" fill="#7f1d1d" font-family="system-ui">• นำเข้าชิ้นส่วน → ประกอบง่าย → ส่งออก</text>
  <text x="70" y="144" font-size="14" fill="#7f1d1d" font-family="system-ui">• ไม่สร้าง Value ในไทย</text>
  <text x="70" y="176" font-size="14" fill="#7f1d1d" font-family="system-ui">• ได้รับสิทธิ BOI โดยไม่ผลิตจริง</text>
  <rect x="70" y="210" width="370" height="30" rx="6" fill="#fca5a5" opacity="0.5"/>
  <text x="255" y="231" font-size="14" font-weight="700" fill="#991b1b" text-anchor="middle" font-family="system-ui">BOI ยกเลิกสิทธิ์แล้ว</text>
  <text x="70" y="275" font-size="13" fill="#7f1d1d" font-family="system-ui">+ ร่วมศุลกากรตรวจ 100% Export Controls</text>
  <text x="70" y="296" font-size="13" fill="#7f1d1d" font-family="system-ui">ป้องกันชิป AI ลักลอบไปจีนผ่านไทย</text>

  <circle cx="550" cy="180" r="32" fill="var(--accent)"/>
  <text x="550" y="185" font-size="24" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">→</text>

  <rect x="610" y="30" width="460" height="300" rx="12" fill="#f0fdf4" stroke="#86efac" stroke-width="2"/>
  <rect x="610" y="30" width="460" height="48" rx="12" fill="#bbf7d0" opacity="0.5"/>
  <text x="840" y="60" font-size="15" font-weight="700" fill="#14532d" text-anchor="middle" font-family="system-ui">✓ ใหม่: Significant Manufacturing</text>
  <text x="650" y="108" font-size="14" fill="var(--ink)" font-family="system-ui">🏭 IC Design / Wafer Fabrication</text>
  <rect x="690" y="118" width="340" height="24" rx="4" fill="var(--accent)" opacity="0.1"/>
  <text x="860" y="135" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ยกเว้นภาษีนิติบุคคล 13+ ปี</text>
  <text x="650" y="170" font-size="14" fill="var(--ink)" font-family="system-ui">⚡ EEC + Direct PPA 2,000 MW</text>
  <text x="650" y="200" font-size="14" fill="var(--ink)" font-family="system-ui">📦 นำเข้าเครื่องจักร + วัตถุดิบ</text>
  <text x="650" y="230" font-size="14" fill="var(--ink)" font-family="system-ui">🌐 Fast-track พลังงานหมุนเวียน</text>
  <rect x="650" y="260" width="370" height="30" rx="6" fill="#bbf7d0" opacity="0.6"/>
  <text x="835" y="281" font-size="14" font-weight="700" fill="#14532d" text-anchor="middle" font-family="system-ui">FDI คุณภาพสูงที่สร้างมูลค่าจริง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> BOI ไม่ได้แค่ "โปรย" สิทธิประโยชน์ — แต่ "คัดกรอง" เฉพาะการผลิตที่สร้างมูลค่าเพิ่มในไทยจริง</div>

<!-- Speaker: Anti-Passthrough เป็น structural change ใหญ่ ทำให้ BOI น่าเชื่อถือกับ FDI ที่จริงจัง -->

---

## Tech War คือลมหนุน: Friendshoring ดัน FDI ไหลเข้าไทย

<p class="subhead">CHIPS Act $52B + ส่งออกชิปไปสหรัฐฯ +62% (2023) — "ความเป็นกลางไทย" ทำให้รับ FDI ได้ทั้งสองฝ่าย</p>

<div class="infographic">
<img src="assets/thai-semiconductor-strategy-boi-tech-war-2.png" alt="Tech War Friendshoring geopolitical diagram">
</div>

<div class="takeaway"><b>★ Takeaway:</b> ความเป็นกลางไทยคือ "ทรัพย์สินหายาก" — แต่ต้องรักษา Export Controls compliance เพื่อความน่าเชื่อถือระยะยาว</div>

<!-- Speaker: CHIPS Act context, ทำไม neutrality เป็น strategic asset, ความเสี่ยงถ้า Export Controls tighten -->

---

## ASEAN Race: ไทยต้องแซงมาเลเซียใน Back-End ซับซ้อน

<p class="subhead">มาเลเซียครอง 13% Global APT — เวียดนามรุกเร็วแต่ขาดวิศวกร — ไทยต้องเลือกช่องว่างที่ Differentiate ได้</p>

<div class="infographic">
<img src="assets/thai-semiconductor-strategy-boi-tech-war-3.png" alt="ASEAN semiconductor competition Thailand Vietnam Malaysia">
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทยชนะด้วย Automotive/EV Ecosystem — ไม่ใช่ราคา; เป้าระยะสั้นคือแย่งส่วนแบ่ง APT จากมาเลเซีย</div>

<!-- Speaker: Malaysia = immediate threat with NSS + Intel; Vietnam = emerging but energy/talent gaps; Thailand differentiates via EV linkage -->

---

## Roadmap 2050: $79B + 230K คน + 5 กลุ่มชิปเป้าหมาย

<p class="subhead">3 Phase ใน 24 ปี — ระยะสั้นเน้น Back-End ซับซ้อน; ระยะยาวเป้า Mature Node Fab ที่ Cluster ลำพูน-ลำปาง</p>

<div class="infographic" style="flex-direction:column;align-items:stretch;gap:10px;">
<svg viewBox="0 0 1100 200" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="60" y1="68" x2="1040" y2="68" stroke="#94a3b8" stroke-width="2"/>

  <circle cx="160" cy="68" r="16" fill="#3b82f6"/>
  <text x="160" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="160" y="42" font-size="13" font-weight="700" fill="#1e293b" text-anchor="middle" font-family="system-ui">2026-2030</text>
  <rect x="78" y="90" width="164" height="92" rx="8" fill="white" stroke="#3b82f6" stroke-width="1.5"/>
  <text x="160" y="116" font-size="12" fill="#1e293b" text-anchor="middle" font-family="system-ui">FDI Back-End</text>
  <text x="160" y="136" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">LTR Visa + BOI</text>
  <text x="160" y="156" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">100K Workforce</text>

  <circle cx="460" cy="68" r="16" fill="#3b82f6" opacity="0.7"/>
  <text x="460" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="460" y="42" font-size="13" font-weight="700" fill="#1e293b" text-anchor="middle" font-family="system-ui">2030-2040</text>
  <rect x="372" y="90" width="176" height="92" rx="8" fill="white" stroke="#3b82f6" stroke-width="1.5" opacity="0.7"/>
  <text x="460" y="116" font-size="12" fill="#1e293b" text-anchor="middle" font-family="system-ui">Advanced Test</text>
  <text x="460" y="136" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">Power/Sensor Chip</text>
  <text x="460" y="156" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">IC Design Hub</text>

  <circle cx="770" cy="68" r="16" fill="#3b82f6" opacity="0.5"/>
  <text x="770" y="73" font-size="13" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="770" y="42" font-size="13" font-weight="700" fill="#1e293b" text-anchor="middle" font-family="system-ui">2040-2050</text>
  <rect x="682" y="90" width="176" height="92" rx="8" fill="white" stroke="#3b82f6" stroke-width="1.5" opacity="0.5"/>
  <text x="770" y="116" font-size="12" fill="#1e293b" text-anchor="middle" font-family="system-ui">Mature Node Fab</text>
  <text x="770" y="136" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">chip &gt;10nm</text>
  <text x="770" y="156" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">Lamphun Cluster</text>

  <circle cx="1000" cy="68" r="22" fill="#f59e0b"/>
  <text x="1000" y="42" font-size="13" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">Target</text>
  <text x="1000" y="73" font-size="12" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2050</text>
  <text x="1000" y="110" font-size="13" fill="#92400e" text-anchor="middle" font-family="system-ui">$79B</text>
  <text x="1000" y="130" font-size="12" fill="#94a3b8" text-anchor="middle" font-family="system-ui">230K คน</text>
</svg>
<div style="display:flex;gap:6px;padding:0 4px;">
  <div style="flex:1;background:#f1f5f9;border-radius:6px;padding:8px 4px;text-align:center;font-size:13px;font-weight:700;color:#3b82f6;font-family:system-ui;">Power<br><span style="font-weight:400;color:#94a3b8;font-size:11px;">Si/SiC</span></div>
  <div style="flex:1;background:#f1f5f9;border-radius:6px;padding:8px 4px;text-align:center;font-size:13px;font-weight:700;color:#3b82f6;font-family:system-ui;">Sensor<br><span style="font-weight:400;color:#94a3b8;font-size:11px;">Auto/IoT</span></div>
  <div style="flex:1;background:#f1f5f9;border-radius:6px;padding:8px 4px;text-align:center;font-size:13px;font-weight:700;color:#3b82f6;font-family:system-ui;">Photonics<br><span style="font-weight:400;color:#94a3b8;font-size:11px;">Light-based</span></div>
  <div style="flex:1;background:#f1f5f9;border-radius:6px;padding:8px 4px;text-align:center;font-size:13px;font-weight:700;color:#3b82f6;font-family:system-ui;">Analog/Discrete<br><span style="font-weight:400;color:#94a3b8;font-size:11px;">Mixed-Signal</span></div>
  <div style="flex:1;background:#dbeafe;border-radius:6px;padding:8px 4px;text-align:center;font-size:13px;font-weight:700;color:#1e40af;font-family:system-ui;">EV Ecosystem<br><span style="font-weight:400;color:#3b82f6;font-size:11px;">Automotive link</span></div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 3 Phase ใน 24 ปี — ชัยชนะระยะสั้นคือ Back-End ซับซ้อน; เป้าระยะยาวคือ Mature Node Fab ที่ Lamphun ปี 2040+</div>

<!-- Speaker: เน้น 5 target chips ที่ lock-in กับ Automotive/EV ที่มีอยู่แล้ว — ไม่ greenfield; ระยะสั้นสำคัญที่สุดในการพิสูจน์ capability -->

---

## 5 ปัจจัยที่อาจพลิกเกม: แผนดีต้องแก้โจทย์จริง

<p class="subhead">แรงงาน · Fab · พลังงาน · Geopolitics · Incentive War — ทั้ง 5 ต้องแก้คู่ขนาน ไม่ใช่รอผลัดกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="196" height="280" rx="10" fill="var(--paper)" stroke="#fca5a5" stroke-width="1.5"/>
  <rect x="20" y="20" width="196" height="44" rx="10" fill="#fecaca" opacity="0.5"/>
  <text x="118" y="47" font-size="14" font-weight="700" fill="#991b1b" text-anchor="middle" font-family="system-ui">👷 แรงงาน</text>
  <text x="118" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ขาดวิศวกร Semicon</text>
  <text x="118" y="112" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต้องการ 100K+</text>
  <text x="118" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แผน LTR Visa</text>
  <text x="118" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ งบ 2B บาท</text>

  <rect x="228" y="20" width="196" height="280" rx="10" fill="var(--paper)" stroke="#fca5a5" stroke-width="1.5"/>
  <rect x="228" y="20" width="196" height="44" rx="10" fill="#fecaca" opacity="0.5"/>
  <text x="326" y="47" font-size="14" font-weight="700" fill="#991b1b" text-anchor="middle" font-family="system-ui">🏭 Fab</text>
  <text x="326" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ยังไม่มี Wafer Fab</text>
  <text x="326" y="112" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Commercial Scale</text>
  <text x="326" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต้องการ FDI</text>
  <text x="326" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ขนาดใหญ่มาก</text>

  <rect x="436" y="20" width="196" height="280" rx="10" fill="var(--paper)" stroke="#fcd34d" stroke-width="1.5"/>
  <rect x="436" y="20" width="196" height="44" rx="10" fill="#fef08a" opacity="0.5"/>
  <text x="534" y="47" font-size="14" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">⚡ พลังงาน</text>
  <text x="534" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Fab ใช้ไฟสูงมาก</text>
  <text x="534" y="112" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต้นทุน + เสถียรภาพ</text>
  <text x="534" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Direct PPA 2GW</text>
  <text x="534" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แก้ได้บางส่วน</text>

  <rect x="644" y="20" width="196" height="280" rx="10" fill="var(--paper)" stroke="#fcd34d" stroke-width="1.5"/>
  <rect x="644" y="20" width="196" height="44" rx="10" fill="#fef08a" opacity="0.5"/>
  <text x="742" y="47" font-size="14" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">🌏 Geopolitics</text>
  <text x="742" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ความเป็นกลาง</text>
  <text x="742" y="112" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ยากในระยะยาว</text>
  <text x="742" y="140" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Export Controls</text>
  <text x="742" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เข้มงวดขึ้นเรื่อยๆ</text>

  <rect x="852" y="20" width="228" height="280" rx="10" fill="var(--paper)" stroke="#86efac" stroke-width="1.5"/>
  <rect x="852" y="20" width="228" height="44" rx="10" fill="#bbf7d0" opacity="0.5"/>
  <text x="966" y="47" font-size="14" font-weight="700" fill="#14532d" text-anchor="middle" font-family="system-ui">🏆 Incentive War</text>
  <text x="966" y="88" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เวียดนาม มาเลเซีย</text>
  <text x="966" y="112" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">อินเดีย แข่งกัน</text>
  <text x="966" y="140" font-size="11" fill="#14532d" font-weight="700" text-anchor="middle" font-family="system-ui">ต้อง Differentiate</text>
  <text x="966" y="160" font-size="11" fill="#14532d" text-anchor="middle" font-family="system-ui">ด้วย Ecosystem</text>
  <text x="966" y="180" font-size="11" fill="#14532d" text-anchor="middle" font-family="system-ui">ไม่ใช่แค่ราคา</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทยชนะด้วย Ecosystem (Auto/EV + PCB Base) — กลยุทธ์ Differentiation คือเส้นแบ่งระหว่างชนะ vs แพ้ใน Incentive War</div>

<!-- Speaker: ทั้ง 5 ต้องแก้คู่กัน ไม่มีตัวไหนที่รอได้; Red/Yellow = urgent, Green = manageable -->

---

## สรุป: ไทยมีโอกาสสูง — แต่ต้องเร็ว เลือกช่อง และสร้างคน

<p class="subhead">จุดแข็งมีพร้อม — BOI พร้อม — ลมเป็นใจ; สิ่งที่เหลือคือการดำเนินการเร็วกว่าคู่แข่ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="500" height="260" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="30" y="20" width="500" height="44" rx="12" fill="var(--accent)" opacity="0.08"/>
  <text x="280" y="47" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">จุดแข็ง + โอกาสที่มีแล้ว</text>
  <text x="65" y="90" font-size="13" fill="var(--ink)" font-family="system-ui">✅ #1 PCB ใน ASEAN — รันเวย์พร้อม</text>
  <text x="65" y="118" font-size="13" fill="var(--ink)" font-family="system-ui">✅ Automotive/EV Ecosystem ลึก</text>
  <text x="65" y="146" font-size="13" fill="var(--ink)" font-family="system-ui">✅ Tech War → Friendshoring โอกาสทอง</text>
  <text x="65" y="174" font-size="13" fill="var(--ink)" font-family="system-ui">✅ BOI ยกเว้นภาษี 13+ ปี (IC/Wafer)</text>
  <text x="65" y="202" font-size="13" fill="var(--ink)" font-family="system-ui">✅ Export ชิปไปสหรัฐฯ +62% (2023)</text>
  <text x="65" y="232" font-size="13" fill="var(--muted)" font-family="system-ui">→ ไม่แข่ง TSMC: ไปที่ Mature &gt;10nm</text>

  <rect x="570" y="20" width="500" height="260" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="1.5"/>
  <rect x="570" y="20" width="500" height="44" rx="12" fill="var(--gold)" opacity="0.08"/>
  <text x="820" y="47" font-size="15" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">สิ่งที่ต้องทำ (เร่งด่วน)</text>
  <text x="605" y="90" font-size="13" fill="var(--ink)" font-family="system-ui">🎯 National Semicon Strategy ชัดเจน</text>
  <text x="605" y="118" font-size="13" fill="var(--ink)" font-family="system-ui">👷 โปรแกรมผลิตวิศวกร 100K คน</text>
  <text x="605" y="146" font-size="13" fill="var(--ink)" font-family="system-ui">⚡ พลังงานหมุนเวียน 2,000 MW</text>
  <text x="605" y="174" font-size="13" fill="var(--ink)" font-family="system-ui">🏭 Lamphun-Lampang Cluster</text>
  <text x="605" y="202" font-size="13" fill="#92400e" font-weight="700" font-family="system-ui">⚡ เร่งตัดสินใจก่อนมาเลเซีย/เวียดนาม</text>
  <text x="605" y="232" font-size="13" fill="var(--muted)" font-family="system-ui">→ หน้าต่างโอกาส 2025-2030</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไทย ≠ TSMC — ไปที่ Mature Node >10nm ใน Niche ที่ Automotive/EV ต้องการ; ชนะถ้าสร้างคนเร็วและเลือก Cluster ถูก</div>

<!-- Speaker: 2025-2026 คือ critical decision window — ทุกเดือนที่ delay = Malaysia/Vietnam วิ่งหนีไปอีก -->
