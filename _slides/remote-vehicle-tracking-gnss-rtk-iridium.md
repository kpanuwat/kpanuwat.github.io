---
marp: true
theme: default
paginate: true
title: "ออกแบบระบบ Vehicle Tracking ระยะไกล"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; --green:#22c55e; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:28px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:16px; margin:0 0 8px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; justify-content:flex-start; gap:2rem; }
  section.title h1 { font-size:38px; color:white; margin:0; line-height:1.3; }
  section.title p { color:#94a3b8; font-size:17px; margin:0; }
  table { border-collapse:collapse; width:100%; font-size:13px; }
  th, td { padding:5px 10px; border-bottom:1px solid var(--soft); text-align:left; }
  th { color:var(--muted); font-weight:600; }
---

<!-- _class: title -->

# ออกแบบระบบ Vehicle Tracking ระยะไกล<br>ด้วย GNSS RTK + Iridium Satellite

**Centimeter-level accuracy · Global coverage · 15 MB/device/month**

<!-- Speaker note: ระบบ tracking ยานพาหนะที่ทำงานในพื้นที่ห่างไกลไม่มี cellular — ใช้ GNSS RTK สำหรับ cm accuracy และ Iridium Certus สำหรับ satellite link. Challenge หลักคือ balance accuracy/latency/cost. -->

---

## ปัญหา: Cellular ล้มเหลวที่ไหน ระบบ tracking ต้องการที่สุด

<p class="subhead">Fleet management ทั่วไปพึ่ง 4G/LTE — แต่พื้นที่อุตสาหกรรมจริงไม่มีสัญญาณ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: Cellular vs Iridium LEO -->
  <rect x="40" y="30" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="40" y="30" width="490" height="56" rx="12" fill="var(--danger)" opacity="0.12"/>
  <text x="285" y="65" font-size="18" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Cellular (4G/LTE)</text>
  <text x="80" y="118" font-size="15" fill="var(--ink)" font-family="system-ui">✗  ครอบคลุมแค่ ~20% พื้นที่โลก</text>
  <text x="80" y="152" font-size="15" fill="var(--ink)" font-family="system-ui">✗  ไม่มีสัญญาณ: เหมือง, ป่า, ทะเล</text>
  <text x="80" y="186" font-size="15" fill="var(--ink)" font-family="system-ui">✗  GPS standard accuracy 3–5 m</text>
  <text x="80" y="220" font-size="15" fill="var(--muted)" font-family="system-ui">✓  Cost ต่ำ, latency ต่ำ</text>
  <text x="80" y="254" font-size="15" fill="var(--muted)" font-family="system-ui">✓  Bandwidth สูง</text>

  <rect x="570" y="30" width="490" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="570" y="30" width="490" height="56" rx="12" fill="var(--accent)" opacity="0.10"/>
  <text x="815" y="65" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Iridium LEO Satellite</text>
  <text x="610" y="118" font-size="15" fill="var(--ink)" font-family="system-ui">✓  100% global coverage (incl. poles)</text>
  <text x="610" y="152" font-size="15" fill="var(--ink)" font-family="system-ui">✓  ทำงานได้ทุกที่บนโลก</text>
  <text x="610" y="186" font-size="15" fill="var(--ink)" font-family="system-ui">✓  + GNSS RTK → cm accuracy</text>
  <text x="610" y="220" font-size="15" fill="var(--muted)" font-family="system-ui">△  IMT payload ≤ 100 KB</text>
  <text x="610" y="254" font-size="15" fill="var(--muted)" font-family="system-ui">△  Cost สูงกว่า ต้อง compress ดี</text>

  <circle cx="550" cy="190" r="28" fill="var(--accent)"/>
  <text x="550" y="190" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Iridium ให้ global coverage แต่ต้องจ่ายด้วย bandwidth constraint — design ทุก byte ให้นับ</div>

<!-- Speaker note: ยก use case: mine pit edge monitoring, offshore supply boat, autonomous farming ที่ต้องการทั้ง cm accuracy และ remote connectivity. -->

---

## System Architecture: Edge → Satellite → Cloud

<p class="subhead">4 layer ทำงานต่อเนื่อง — ความล้มเหลวของ layer ใดต้องไม่ทำให้ data loss</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 4 nodes horizontal -->
  <!-- Node 1: Edge Device -->
  <rect x="30" y="80" width="210" height="200" rx="14" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="135" y="115" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Edge Device</text>
  <text x="135" y="143" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">GNSS Module</text>
  <text x="135" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(u-blox ZED-F9P)</text>
  <text x="135" y="191" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MCU + Firmware</text>
  <text x="135" y="211" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">queue + compress</text>
  <text x="135" y="239" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">RockBLOCK 9704</text>
  <text x="135" y="259" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Iridium Certus 100</text>

  <!-- Arrow 1 -->
  <line x1="242" y1="180" x2="298" y2="180" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <text x="270" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IMT</text>
  <text x="270" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">4.8 kbps</text>

  <!-- Node 2: Satellite -->
  <rect x="300" y="80" width="210" height="200" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="405" y="115" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Iridium Network</text>
  <text x="405" y="155" font-size="32" text-anchor="middle" font-family="system-ui">🛰️</text>
  <text x="405" y="191" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">LEO constellation</text>
  <text x="405" y="211" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">66 active satellites</text>
  <text x="405" y="239" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">latency &lt; 10s</text>
  <text x="405" y="259" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">100% global coverage</text>

  <!-- Arrow 2 -->
  <line x1="512" y1="180" x2="568" y2="180" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>
  <text x="540" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">webhook</text>
  <text x="540" y="196" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/ REST API</text>

  <!-- Node 3: Cloud -->
  <rect x="570" y="80" width="210" height="200" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="675" y="115" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cloud Pipeline</text>
  <text x="675" y="143" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Ingestion API</text>
  <text x="675" y="163" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">decode + validate</text>
  <text x="675" y="191" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Processing Worker</text>
  <text x="675" y="211" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">geofence, enrich</text>
  <text x="675" y="239" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Time-series DB</text>
  <text x="675" y="259" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">InfluxDB / BigQuery</text>

  <!-- Arrow 3 -->
  <line x1="782" y1="180" x2="838" y2="180" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr)"/>

  <!-- Node 4: Dashboard -->
  <rect x="840" y="80" width="210" height="200" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="945" y="115" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Dashboard</text>
  <text x="945" y="155" font-size="32" text-anchor="middle" font-family="system-ui">🗺️</text>
  <text x="945" y="191" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Vehicle Map</text>
  <text x="945" y="211" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">history playback</text>
  <text x="945" y="239" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">geofence alerts</text>
  <text x="945" y="259" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cost analytics</text>

  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก layer ต้องออกแบบ resilience อิสระ — edge queue รับ satellite outage; cloud queue รับ processing lag</div>

<!-- Speaker note: เน้น data flow ทางเดียว (upstream telemetry). Downlink (command to vehicle) เป็น optional use case ที่ IMT รองรับแต่ไม่ใช่ critical path ของ tracking. -->

---

## GNSS RTK มี 3 Accuracy Tiers — ออกแบบ Fallback ให้ชัด

<p class="subhead">Centimeter accuracy ต้องการ correction stream — เมื่อ correction ขาด ระบบต้อง degrade gracefully</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3-tier horizontal with accuracy gradient -->
  <!-- Tier 1: Fixed RTK -->
  <rect x="50" y="50" width="300" height="260" rx="16" fill="var(--accent)" opacity="0.08" stroke="var(--accent)" stroke-width="2"/>
  <rect x="50" y="50" width="300" height="50" rx="16" fill="var(--accent)"/>
  <text x="200" y="81" font-size="17" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Fixed RTK</text>
  <text x="200" y="140" font-size="40" font-weight="900" fill="var(--accent)" text-anchor="middle" font-family="system-ui">~1 cm</text>
  <text x="200" y="170" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">horizontal accuracy</text>
  <text x="200" y="210" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Ambiguity resolved</text>
  <text x="200" y="234" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต้องมี RTCM corrections</text>
  <text x="200" y="258" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">จาก local base station</text>
  <text x="200" y="290" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">fix_type = 3</text>

  <!-- Tier 2: Float RTK -->
  <rect x="400" y="50" width="300" height="260" rx="16" fill="#f59e0b" opacity="0.08" stroke="#f59e0b" stroke-width="2"/>
  <rect x="400" y="50" width="300" height="50" rx="16" fill="#f59e0b"/>
  <text x="550" y="81" font-size="17" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Float RTK</text>
  <text x="550" y="140" font-size="36" font-weight="900" fill="#f59e0b" text-anchor="middle" font-family="system-ui">20–50 cm</text>
  <text x="550" y="170" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">horizontal accuracy</text>
  <text x="550" y="210" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Ambiguity not resolved</text>
  <text x="550" y="234" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">correction อ่อนหรือขาด</text>
  <text x="550" y="258" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ดีกว่า standalone GPS</text>
  <text x="550" y="290" font-size="12" fill="#f59e0b" text-anchor="middle" font-family="system-ui">fix_type = 2</text>

  <!-- Tier 3: Standalone -->
  <rect x="750" y="50" width="300" height="260" rx="16" fill="var(--muted)" opacity="0.08" stroke="var(--muted)" stroke-width="2"/>
  <rect x="750" y="50" width="300" height="50" rx="16" fill="var(--muted)"/>
  <text x="900" y="81" font-size="17" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Standalone GPS</text>
  <text x="900" y="140" font-size="36" font-weight="900" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3–5 m</text>
  <text x="900" y="170" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">horizontal accuracy</text>
  <text x="900" y="210" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ไม่มี correction</text>
  <text x="900" y="234" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">base station ไม่ทำงาน</text>
  <text x="900" y="258" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">หรือ radio link ขาด</text>
  <text x="900" y="290" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">fix_type = 1</text>

  <!-- Downgrade arrows -->
  <line x1="352" y1="175" x2="398" y2="175" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#arrd)"/>
  <line x1="702" y1="175" x2="748" y2="175" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#arrd)"/>
  <text x="375" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">degrade</text>
  <text x="725" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">degrade</text>

  <defs>
    <marker id="arrd" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> log fix_type ทุก telemetry point — cloud ต้องรู้ accuracy tier ของแต่ละ position เพื่อ filter ก่อน analytics</div>

<!-- Speaker note: RTK base station ต้องการ internet สำหรับ NTRIP corrections ปกติ. ในพื้นที่ remote ต้องใช้ radio link (UHF/LoRa) จาก local base. ถ้า base ไม่ทำงาน → auto-degrade ไป Float หรือ Standalone. -->

---

## RockBLOCK 9704: Satellite Modem สำหรับ Production IoT

<p class="subhead">Iridium Certus 100 — compact, rugged, IMT payload 300× ใหญ่กว่า SBD รุ่นเก่า</p>

| Spec | Value |
|------|-------|
| Protocol | Iridium Messaging Transport (IMT) |
| Payload | 25 bytes – 100 KB per message |
| Data rate | 4.8 kbps bi-directional |
| Latency | < 10 seconds (typical) |
| Power | Peak 1.4 W · Idle < 60 mW · Sleep < 5 mW |
| Temperature | -40°C to +70°C |
| Size (SMA) | 48 × 52 × 16 mm, < 35 g |
| Airtime | $17–75/month base · $0.30–0.50/KB overage |

<div style="display:flex;justify-content:center;margin:0.25rem 0">
<svg viewBox="0 0 540 64" width="540" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="4" width="120" height="56" rx="8" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="60" y="24" font-size="10" fill="#94a3b8" text-anchor="middle" font-family="system-ui">SBD — 9603</text>
  <text x="60" y="48" font-size="20" font-weight="900" fill="#ef4444" text-anchor="middle" font-family="system-ui">340 B</text>
  <text x="215" y="38" font-size="22" font-weight="900" fill="#3b82f6" text-anchor="middle" font-family="system-ui">→ 300×</text>
  <rect x="310" y="4" width="120" height="56" rx="8" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="370" y="24" font-size="10" fill="#94a3b8" text-anchor="middle" font-family="system-ui">IMT — 9704</text>
  <text x="370" y="48" font-size="20" font-weight="900" fill="#3b82f6" text-anchor="middle" font-family="system-ui">100 KB</text>
  <text x="450" y="22" font-size="10" fill="#94a3b8" font-family="system-ui">max</text>
  <text x="450" y="36" font-size="10" fill="#94a3b8" font-family="system-ui">payload</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> IMT payload 300× ใหญ่กว่า SBD — batch 50 positions/message, ลด satellite call overhead</div>

<!-- Speaker note: ราคา hardware $279-299. ต้อง plan airtime cost ใน BOM ด้วย. เน้น sleep mode < 5mW สำคัญมากสำหรับ battery-powered edge device. -->

---

## Firmware: Adaptive Reporting ลด Data Usage 60–80%

<p class="subhead">ปรับ reporting interval ตาม vehicle state — ส่งบ่อยเมื่อวิ่ง, ส่งน้อยเมื่อจอด</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- flowchart-decision: vehicle state → interval -->
  <!-- Start -->
  <rect x="450" y="20" width="200" height="48" rx="24" fill="var(--accent)"/>
  <text x="550" y="49" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">collect_position()</text>
  <line x1="550" y1="68" x2="550" y2="100" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#arr2)"/>

  <!-- Decision 1: velocity > 5 km/h? -->
  <polygon points="550,108 700,158 550,208 400,158" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">velocity</text>
  <text x="550" y="171" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">&gt; 5 km/h?</text>

  <!-- Yes branch (left) -->
  <line x1="400" y1="158" x2="200" y2="158" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="300" y="148" font-size="12" fill="var(--green)" text-anchor="middle" font-family="system-ui">Yes</text>
  <rect x="80" y="130" width="120" height="56" rx="10" fill="var(--green)" opacity="0.15" stroke="var(--green)" stroke-width="1.5"/>
  <text x="140" y="155" font-size="18" font-weight="900" fill="var(--green)" text-anchor="middle" font-family="system-ui">30s</text>
  <text x="140" y="175" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Moving</text>

  <!-- No branch (down) -->
  <line x1="550" y1="208" x2="550" y2="238" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="566" y="228" font-size="12" fill="var(--danger)" font-family="system-ui">No</text>

  <!-- Decision 2: motion_detected? -->
  <polygon points="550,246 700,286 550,326 400,286" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="281" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">motion</text>
  <text x="550" y="299" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">detected?</text>

  <!-- Yes branch (left) -->
  <line x1="400" y1="286" x2="310" y2="286" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="355" y="276" font-size="12" fill="var(--green)" text-anchor="middle" font-family="system-ui">Yes</text>
  <rect x="170" y="258" width="140" height="56" rx="10" fill="#f59e0b" opacity="0.15" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="240" y="283" font-size="18" font-weight="900" fill="#f59e0b" text-anchor="middle" font-family="system-ui">120s</text>
  <text x="240" y="303" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Idle/engine on</text>

  <!-- No branch (right) -->
  <line x1="700" y1="286" x2="840" y2="286" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="770" y="276" font-size="12" fill="var(--danger)" font-family="system-ui">No</text>
  <rect x="840" y="258" width="140" height="56" rx="10" fill="var(--muted)" opacity="0.15" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="910" y="283" font-size="18" font-weight="900" fill="var(--muted)" text-anchor="middle" font-family="system-ui">600s</text>
  <text x="910" y="303" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Parked</text>

  <!-- Budget label -->
  <rect x="730" y="20" width="340" height="80" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <text x="900" y="48" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Budget: 15 MB/device/month</text>
  <text x="900" y="68" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">≈ 100,000 positions @ 150 bytes</text>
  <text x="900" y="88" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">= report ทุก 2.3 นาที ตลอด 24h</text>

  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Adaptive interval ลด data usage 60–80% โดยไม่เสีย track quality ขณะ vehicle กำลังเคลื่อนที่</div>

<!-- Speaker note: ด้วย adaptive interval vehicle ที่วิ่งจริงวันละ 8-10h budget 15 MB เพียงพอ. Worst case คือ vehicle วิ่งตลอด 24h ซึ่งไม่น่าเกิดจริง. -->

---

## Payload Design: Binary 20 bytes ดีกว่า JSON 150+ bytes

<p class="subhead">บน satellite link ทุก byte มีราคา — ออกแบบ payload ให้ compact ตั้งแต่แรก</p>

| Format | Bytes/point | Saving | 50-point batch |
|--------|-------------|--------|----------------|
| **JSON** | 150 B | baseline | 7,500 B |
| **Binary Struct** | 20 B | **7× smaller** | 1,000 B |
| **Delta Encoded** | ~6 B | **25× smaller** | ~300 B |

<div style="margin:0.5rem 0;display:flex;justify-content:center">
<svg viewBox="0 0 800 64" width="85%" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="0" width="800" height="64" rx="10" fill="#f1f5f9" stroke="#3b82f6" stroke-width="1.5"/>
  <text x="400" y="24" font-size="14" font-weight="700" fill="#1e293b" text-anchor="middle" font-family="system-ui">Struct: timestamp 4B + lat 4B + lng 4B + alt 2B + flags 6B = 20 bytes</text>
  <text x="400" y="48" font-size="13" fill="#94a3b8" text-anchor="middle" font-family="system-ui">delta: send full coords once, then only diff per point → ~6 bytes</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Binary struct 20 bytes vs JSON 150 bytes = ประหยัด 7× — delta encoding ลงไปอีกเหลือ 5–8 bytes/point</div>

<!-- Speaker note: Delta encoding: vehicle 60 km/h เปลี่ยน lat/lng แค่ ~0.0005° ใน 30s — ใส่ใน int16 ได้สบาย. ส่ง full coordinate เฉพาะ point แรกของแต่ละ batch. -->

---

## Store-and-Forward: Data ต้องไม่ Lost เมื่อ Link ขาด

<p class="subhead">Satellite link ขาดเป็นปกติ (antenna blocked, congestion) — queue บน Flash คือ safety net</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: collect → queue → check → send → retry -->
  <!-- Step 1: Collect -->
  <rect x="20" y="130" width="150" height="80" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="95" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">collect</text>
  <text x="95" y="184" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">_position()</text>
  <line x1="172" y1="170" x2="210" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr3)"/>

  <!-- Step 2: Queue -->
  <rect x="212" y="130" width="150" height="80" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="287" y="158" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">write_to</text>
  <text x="287" y="176" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">_local_queue()</text>
  <text x="287" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Flash / SD storage</text>
  <line x1="364" y1="170" x2="402" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr3)"/>

  <!-- Step 3: Check satellite -->
  <polygon points="500,130 580,170 500,210 420,170" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="500" y="164" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">satellite</text>
  <text x="500" y="180" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ready?</text>

  <!-- Yes → send -->
  <line x1="580" y1="170" x2="640" y2="170" stroke="var(--green)" stroke-width="2" marker-end="url(#arr3g)"/>
  <text x="610" y="160" font-size="11" fill="var(--green)" text-anchor="middle" font-family="system-ui">Yes</text>

  <rect x="642" y="130" width="160" height="80" rx="10" fill="var(--soft)" stroke="var(--green)" stroke-width="2"/>
  <text x="722" y="158" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">build_batch(</text>
  <text x="722" y="176" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">dequeue_50)</text>
  <text x="722" y="200" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">compress + send</text>
  <line x1="804" y1="170" x2="842" y2="170" stroke="var(--green)" stroke-width="2" marker-end="url(#arr3g)"/>

  <!-- Result diamond -->
  <polygon points="920,130 1000,170 920,210 840,170" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="920" y="164" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">result</text>
  <text x="920" y="180" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">OK?</text>

  <!-- Success -->
  <line x1="1000" y1="170" x2="1060" y2="170" stroke="var(--green)" stroke-width="2" marker-end="url(#arr3g)"/>
  <text x="1030" y="160" font-size="11" fill="var(--green)" text-anchor="middle" font-family="system-ui">Yes</text>
  <rect x="1062" y="148" width="28" height="44" rx="6" fill="var(--green)"/>
  <text x="1076" y="174" font-size="16" fill="white" text-anchor="middle" font-family="system-ui">✓</text>

  <!-- No satellite → wait loop -->
  <line x1="500" y1="210" x2="500" y2="280" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="500" y1="280" x2="95" y2="280" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="95" y1="280" x2="95" y2="213" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#arr3r)"/>
  <text x="300" y="300" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">No → wait, keep queuing to Flash</text>

  <!-- Retry backoff -->
  <line x1="920" y1="210" x2="920" y2="280" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="920" y1="280" x2="722" y2="280" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <line x1="722" y1="280" x2="722" y2="213" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#arr3r)"/>
  <text x="820" y="300" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Fail → requeue_with_backoff()</text>

  <defs>
    <marker id="arr3" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
    <marker id="arr3g" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--green)"/>
    </marker>
    <marker id="arr3r" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--danger)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Store-and-forward ไม่ optional — firmware ที่ไม่มี local queue จะ lose positions ทุกครั้งที่ satellite link ขาด</div>

<!-- Speaker note: Flash queue ควรมี capacity อย่างน้อย 24h ของ positions. Exponential backoff ป้องกัน retry storm ที่จะทำให้ airtime cost พุ่ง. -->

---

## 5 ความเสี่ยงหลักที่ต้องออกแบบรับมือตั้งแต่ต้น

<p class="subhead">Risk ที่ underestimate ตัวใดตัวหนึ่งอาจทำให้ operational cost เกิน budget หรือ project ล่าช้า</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 5 risk cards in a grid -->
  <!-- Card 1 -->
  <rect x="20" y="20" width="320" height="150" rx="12" fill="var(--soft)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="20" y="20" width="320" height="44" rx="12" fill="var(--danger)" opacity="0.15"/>
  <text x="40" y="48" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">RTK Correction Delivery</text>
  <text x="40" y="80" font-size="12" fill="var(--ink)" font-family="system-ui">ต้องมี local base station + radio</text>
  <text x="40" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">link (UHF/LoRa) ในพื้นที่ remote</text>
  <text x="40" y="128" font-size="12" fill="var(--muted)" font-family="system-ui">Mitigation: design fallback tiers</text>
  <text x="40" y="148" font-size="12" fill="var(--muted)" font-family="system-ui">Fixed → Float → Standalone</text>

  <!-- Card 2 -->
  <rect x="390" y="20" width="320" height="150" rx="12" fill="var(--soft)" stroke="#f59e0b" stroke-width="1.5"/>
  <rect x="390" y="20" width="320" height="44" rx="12" fill="#f59e0b" opacity="0.15"/>
  <text x="410" y="48" font-size="14" font-weight="700" fill="#f59e0b" font-family="system-ui">Satellite Network Latency</text>
  <text x="410" y="80" font-size="12" fill="var(--ink)" font-family="system-ui">&lt; 10s typical, worst case สูงกว่า</text>
  <text x="410" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">ไม่ใช่ real-time tracking</text>
  <text x="410" y="128" font-size="12" fill="var(--muted)" font-family="system-ui">Mitigation: ประเมิน SLA ก่อน commit</text>
  <text x="410" y="148" font-size="12" fill="var(--muted)" font-family="system-ui">latency requirement ให้ชัดเจน</text>

  <!-- Card 3 -->
  <rect x="760" y="20" width="320" height="150" rx="12" fill="var(--soft)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="760" y="20" width="320" height="44" rx="12" fill="var(--danger)" opacity="0.15"/>
  <text x="780" y="48" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">Payload Cost Runaway</text>
  <text x="780" y="80" font-size="12" fill="var(--ink)" font-family="system-ui">$0.30–0.50/KB overage</text>
  <text x="780" y="100" font-size="12" fill="var(--ink)" font-family="system-ui">firmware bug → cost พุ่ง</text>
  <text x="780" y="128" font-size="12" fill="var(--muted)" font-family="system-ui">Mitigation: hard cap บน firmware</text>
  <text x="780" y="148" font-size="12" fill="var(--muted)" font-family="system-ui">+ cloud anomaly alert</text>

  <!-- Card 4 -->
  <rect x="20" y="190" width="490" height="150" rx="12" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="20" y="190" width="490" height="44" rx="12" fill="var(--muted)" opacity="0.15"/>
  <text x="40" y="218" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Supply Chain Lead Time</text>
  <text x="40" y="254" font-size="12" fill="var(--ink)" font-family="system-ui">u-blox ZED-F9P lead time 8–16 สัปดาห์+ ในช่วง chip shortage</text>
  <text x="40" y="276" font-size="12" fill="var(--ink)" font-family="system-ui">RockBLOCK 9704 availability เป็นรอบ</text>
  <text x="40" y="308" font-size="12" fill="var(--muted)" font-family="system-ui">Mitigation: lock BOM + place order 1 quarter ก่อน production</text>

  <!-- Card 5 -->
  <rect x="560" y="190" width="520" height="150" rx="12" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="560" y="190" width="520" height="44" rx="12" fill="var(--muted)" opacity="0.15"/>
  <text x="580" y="218" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">IMT Min Payload + GNSS Fallback</text>
  <text x="580" y="254" font-size="12" fill="var(--ink)" font-family="system-ui">RockBLOCK 9704 min payload 25 bytes — heartbeat &lt; 25 bytes อาจ error</text>
  <text x="580" y="276" font-size="12" fill="var(--ink)" font-family="system-ui">Multi-constellation config ต้องตั้งค่าชัดเจน</text>
  <text x="580" y="308" font-size="12" fill="var(--muted)" font-family="system-ui">Mitigation: pad payload + test edge cases ก่อน deploy</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cost guard rails และ supply chain planning ต้องทำก่อน production commit — แก้ทีหลังแพงกว่ามาก</div>

<!-- Speaker note: ความเสี่ยงที่มักถูก underestimate มากที่สุดคือ supply chain และ payload cost runaway. RTK correction delivery เป็น known challenge แต่สองตัวแรกมักไม่ถูก budget ไว้. -->

---

## Key Takeaways: Edge Intelligence คือ Critical Success Factor

<p class="subhead">ระบบที่ดีไม่ได้อยู่ที่ cloud pipeline — อยู่ที่ firmware ที่ตัดสินใจ smart บน edge</p>

<div class="infographic">
<svg viewBox="0 0 1000 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Row 1: cards 1, 2, 3 -->
  <rect x="10" y="10" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="42" cy="42" r="16" fill="var(--accent)"/>
  <text x="42" y="48" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="68" y="38" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Iridium IMT</text>
  <text x="20" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">Payload 100 KB, latency &lt; 10s</text>
  <text x="20" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">RockBLOCK 9704: rugged, global</text>
  <text x="20" y="112" font-size="11" fill="var(--accent)" font-family="system-ui">✓ ครอบคลุม 100% พื้นที่โลก</text>

  <rect x="350" y="10" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="382" cy="42" r="16" fill="var(--accent)"/>
  <text x="382" y="48" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="408" y="38" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">RTK Accuracy Tiers</text>
  <text x="360" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">Fixed ~1 cm · Float ~30 cm</text>
  <text x="360" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">Standalone GPS 3-5 m</text>
  <text x="360" y="112" font-size="11" fill="var(--accent)" font-family="system-ui">✓ log fix_type ทุก message</text>

  <rect x="690" y="10" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="722" cy="42" r="16" fill="var(--accent)"/>
  <text x="722" y="48" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="748" y="38" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">15 MB Budget</text>
  <text x="700" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">Binary + delta + batch + adaptive</text>
  <text x="700" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">อย่าส่ง JSON บน satellite</text>
  <text x="700" y="112" font-size="11" fill="var(--accent)" font-family="system-ui">✓ 7× savings vs JSON</text>

  <!-- Row 2: cards 4, 5 centered -->
  <rect x="180" y="155" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="212" cy="187" r="16" fill="var(--accent)"/>
  <text x="212" y="193" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="238" y="183" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Store-and-Forward</text>
  <text x="190" y="217" font-size="12" fill="var(--muted)" font-family="system-ui">Flash queue สำหรับ link outage</text>
  <text x="190" y="237" font-size="12" fill="var(--muted)" font-family="system-ui">Retry + exponential backoff</text>
  <text x="190" y="257" font-size="11" fill="var(--accent)" font-family="system-ui">✓ ไม่มี queue = data loss</text>

  <rect x="520" y="155" width="300" height="120" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="552" cy="187" r="16" fill="var(--accent)"/>
  <text x="552" y="193" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="578" y="183" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Cost Guard Rails</text>
  <text x="530" y="217" font-size="12" fill="var(--muted)" font-family="system-ui">Firmware byte counter + hard cap</text>
  <text x="530" y="237" font-size="12" fill="var(--muted)" font-family="system-ui">Cloud anomaly alert on volume</text>
  <text x="530" y="257" font-size="11" fill="var(--accent)" font-family="system-ui">✓ overage $0.50/KB = expensive</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Design ดีที่ edge ประหยัดได้ 7× — firmware ที่ส่ง JSON บน satellite ทำให้โปรเจกต์เกิน budget ทันที</div>

<!-- Speaker note: จบด้วยการเน้นว่า critical success factor ไม่ใช่ cloud architecture หรือ dashboard — แต่เป็น firmware ที่ออกแบบ payload compression, adaptive interval และ store-and-forward ได้ดี. -->
