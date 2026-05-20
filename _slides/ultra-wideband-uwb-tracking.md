---
marp: true
theme: default
paginate: true
title: "Ultra-Wideband (UWB) Tracking"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:28px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:16px; margin:0 0 8px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; }
  section.title h1 { font-size:44px; color:white; margin:0; }
  section.title p { color:#94a3b8; font-size:18px; margin-top:16px; }
---

<!-- _class: title -->

# Ultra-Wideband (UWB) Tracking

**GPS ล้มเหลวในอาคาร — UWB ให้ความแม่นยำ 10 cm**

<!-- Speaker note: UWB ฝังอยู่ใน iPhone, AirTag, และ car key แล้ว 10 slides ครอบคลุม physics ของ ToF จนถึง 802.15.4z ecosystem -->

---

## UWB แม่นยำกว่า BLE และ Wi-Fi ถึง 10–100×

<p class="subhead">bandwidth ≥500 MHz แยก multipath ได้ — วัดเวลาด้วยความละเอียดต่ำกว่า 1 นาโนวินาที</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="20" y="72" font-size="16" font-weight="700" fill="#ef4444" font-family="system-ui">GPS</text>
  <rect x="120" y="48" width="820" height="40" rx="6" fill="#ef4444" opacity="0.2" stroke="#ef4444" stroke-width="1.5"/>
  <text x="950" y="73" font-size="14" fill="#ef4444" font-family="system-ui">~10 m (กลางแจ้ง)</text>
  <text x="20" y="152" font-size="16" font-weight="700" fill="var(--muted)" font-family="system-ui">Wi-Fi</text>
  <rect x="120" y="128" width="600" height="40" rx="6" fill="var(--muted)" opacity="0.2" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="730" y="153" font-size="14" fill="var(--muted)" font-family="system-ui">5–15 m</text>
  <text x="20" y="232" font-size="16" font-weight="700" fill="var(--muted)" font-family="system-ui">BLE</text>
  <rect x="120" y="208" width="300" height="40" rx="6" fill="var(--muted)" opacity="0.2" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="430" y="233" font-size="14" fill="var(--muted)" font-family="system-ui">1–5 m</text>
  <text x="20" y="312" font-size="16" font-weight="700" fill="var(--accent)" font-family="system-ui">UWB</text>
  <rect x="120" y="288" width="55" height="40" rx="6" fill="var(--accent)" opacity="0.85"/>
  <text x="186" y="313" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">10–30 cm ★</text>
  <text x="120" y="350" font-size="12" fill="var(--muted)" font-family="system-ui">← ยิ่งแท่งสั้น ยิ่งแม่นยำ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UWB ให้ความแม่นยำ 10–30 cm ในร่ม — เหนือกว่า BLE/Wi-Fi 10–100× ด้วย Time-of-Flight physics</div>

<!-- Speaker note: bar ไม่ linear — แสดง order of magnitude ที่ต่างกัน -->

---

## GPS ล้มเหลวในอาคาร — BLE ให้แค่ระดับ "ห้อง" ไม่ใช่ "จุด"

<p class="subhead">ผนัง เพดาน โลหะดูดซับสัญญาณดาวเทียม; BLE/Wi-Fi precision ไม่พอสำหรับ RTLS ระดับ cm</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="300" height="280" rx="12" fill="var(--soft)" stroke="#ef4444" stroke-width="1.5"/>
  <text x="190" y="58" font-size="15" font-weight="700" fill="#ef4444" text-anchor="middle" font-family="system-ui">GPS (กลางแจ้ง)</text>
  <text x="190" y="140" font-size="44" text-anchor="middle" font-family="system-ui">🛰️</text>
  <text x="190" y="190" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">~10 m accuracy</text>
  <text x="190" y="215" font-size="13" fill="#ef4444" text-anchor="middle" font-family="system-ui">✗ ล้มเหลวในอาคาร</text>
  <rect x="400" y="20" width="300" height="280" rx="12" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="58" font-size="15" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BLE / Wi-Fi (ในอาคาร)</text>
  <text x="550" y="140" font-size="44" text-anchor="middle" font-family="system-ui">📶</text>
  <text x="550" y="190" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1–15 m accuracy</text>
  <text x="550" y="215" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~ ระดับห้องเท่านั้น</text>
  <rect x="760" y="20" width="300" height="280" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="760" y="20" width="300" height="52" rx="12" fill="var(--accent)" opacity="0.08"/>
  <text x="910" y="58" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">UWB (ในอาคาร)</text>
  <text x="910" y="140" font-size="44" text-anchor="middle" font-family="system-ui">📡</text>
  <text x="910" y="190" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">10–30 cm accuracy</text>
  <text x="910" y="215" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui">✓ ระดับ cm ในร่ม</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UWB เป็นคำตอบเดียวที่ให้ cm-level accuracy ในอาคาร — ใช้งาน รพ., คลังสินค้า, AirTag Precision Finding</div>

<!-- Speaker note: GPS สัญญาณ 1.5 GHz แทรกซึมผนังคอนกรีตได้น้อยมาก UWB 3.1–10.6 GHz ก็ถูก attenuate แต่ ToF physics ชดเชยด้วย precision สูงกว่า -->

---

## 802.15.4z (2020) เพิ่ม STS เข้ารหัส timestamp — ป้องกัน relay attack

<p class="subhead">802.15.4a (2007) สร้าง UWB PHY; 802.15.4z ล็อก timestamp ด้วย cryptography — สำคัญสำหรับ car key</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="80" y1="150" x2="1040" y2="150" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="1040,144 1040,156 1052,150" fill="var(--muted)"/>
  <!-- 2007 -->
  <circle cx="200" cy="150" r="18" fill="var(--muted)" opacity="0.35" stroke="var(--muted)" stroke-width="2"/>
  <text x="200" y="155" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">07</text>
  <text x="200" y="112" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">802.15.4a</text>
  <text x="200" y="132" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">UWB PHY แรก</text>
  <text x="200" y="186" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3 band, ToF ranging</text>
  <text x="200" y="204" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">110 kbps – 6.8 Mbps</text>
  <!-- 2011 -->
  <circle cx="480" cy="150" r="13" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="480" y="155" font-size="11" font-weight="700" fill="var(--muted)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">11</text>
  <text x="480" y="186" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Merged → 802.15.4-2011</text>
  <!-- 2020 -->
  <circle cx="800" cy="150" r="22" fill="var(--accent)"/>
  <text x="800" y="155" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">20</text>
  <text x="800" y="106" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">802.15.4z</text>
  <text x="800" y="128" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">STS encrypted timestamp</text>
  <text x="800" y="190" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">🔐 ป้องกัน relay attack</text>
  <text x="800" y="210" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BPRF/HPRF · max 31.2 Mbps</text>
  <text x="800" y="230" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">→ CCC Digital Key 3.0</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 802.15.4z STS ปกป้อง ranging timestamp — ขาดไม่ได้สำหรับ car key ที่ต้านทาน relay attack</div>

<!-- Speaker note: relay attack = คนร้ายถือ device retransmit สัญญาณระหว่าง car กับ phone ที่อยู่ไกล STS เข้ารหัสทำให้ replay ไม่ได้ แต่ Singh et al. 2023 แสดงว่าต้อง tune threshold ด้วย -->

---

## TWR ไม่ต้องซิงค์ anchor; TDoA ประหยัดพลัง — คนละ trade-off

<p class="subhead">เลือกตาม: จำนวน tag, อายุถ่าน, และ infrastructure budget</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="a1" markerWidth="6" markerHeight="6" refX="3" refY="3" orient="auto"><path d="M0,0 L0,6 L6,3 z" fill="#3b82f6"/></marker>
    <marker id="a2" markerWidth="6" markerHeight="6" refX="3" refY="3" orient="auto"><path d="M0,0 L0,6 L6,3 z" fill="#94a3b8"/></marker>
  </defs>
  <!-- TWR box -->
  <rect x="40" y="10" width="470" height="300" rx="12" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="10" width="470" height="48" rx="12" fill="var(--muted)" opacity="0.18"/>
  <text x="275" y="41" font-size="17" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Two-Way Ranging (TWR)</text>
  <rect x="80" y="72" width="60" height="30" rx="6" fill="var(--accent)" opacity="0.8"/>
  <text x="110" y="92" font-size="13" fill="white" text-anchor="middle" font-family="system-ui">Tag</text>
  <rect x="370" y="72" width="70" height="30" rx="6" fill="var(--muted)" opacity="0.6"/>
  <text x="405" y="92" font-size="13" fill="white" text-anchor="middle" font-family="system-ui">Anchor</text>
  <line x1="145" y1="81" x2="365" y2="81" stroke="#3b82f6" stroke-width="1.5" marker-end="url(#a1)"/>
  <line x1="365" y1="93" x2="145" y2="93" stroke="#94a3b8" stroke-width="1.5" marker-end="url(#a2)"/>
  <line x1="145" y1="105" x2="365" y2="105" stroke="#3b82f6" stroke-width="1.5" marker-end="url(#a1)"/>
  <text x="255" y="78" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">① poll</text>
  <text x="255" y="91" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">② reply</text>
  <text x="255" y="104" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">③ final (DS-TWR)</text>
  <text x="80" y="148" font-size="13" fill="var(--ink)" font-family="system-ui">✓ ไม่ต้องซิงค์นาฬิกา anchor</text>
  <text x="80" y="172" font-size="13" fill="var(--ink)" font-family="system-ui">✓ แม่นยำ &lt;10 cm (DS-TWR)</text>
  <text x="80" y="196" font-size="13" fill="var(--ink)" font-family="system-ui">✓ ติดตั้งง่ายกว่า TDoA</text>
  <text x="80" y="228" font-size="13" fill="#ef4444" font-family="system-ui">✗ Tag ใช้พลังงานมากกว่า</text>
  <text x="80" y="252" font-size="13" fill="#ef4444" font-family="system-ui">✗ จำนวน tag ต่อ zone จำกัด</text>
  <!-- VS -->
  <circle cx="550" cy="160" r="26" fill="var(--accent)"/>
  <text x="550" y="165" font-size="15" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- TDoA box -->
  <rect x="590" y="10" width="470" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="10" width="470" height="48" rx="12" fill="var(--accent)" opacity="0.08"/>
  <text x="825" y="41" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Time Difference of Arrival (TDoA)</text>
  <rect x="620" y="72" width="60" height="30" rx="6" fill="var(--accent)"/>
  <text x="650" y="92" font-size="13" fill="white" text-anchor="middle" font-family="system-ui">Tag</text>
  <rect x="880" y="58" width="70" height="26" rx="5" fill="var(--muted)" opacity="0.5"/>
  <text x="915" y="76" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Anchor 1</text>
  <rect x="880" y="90" width="70" height="26" rx="5" fill="var(--muted)" opacity="0.5"/>
  <text x="915" y="108" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Anchor 2</text>
  <rect x="880" y="122" width="70" height="26" rx="5" fill="var(--muted)" opacity="0.5"/>
  <text x="915" y="140" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Anchor 3</text>
  <line x1="685" y1="84" x2="875" y2="71" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="685" y1="87" x2="875" y2="103" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="685" y1="90" x2="875" y2="135" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="780" y="78" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">blink once →</text>
  <text x="630" y="176" font-size="13" fill="var(--ink)" font-family="system-ui">✓ Tag ส่งครั้งเดียว → ถ่านปีต่อปี</text>
  <text x="630" y="200" font-size="13" fill="var(--ink)" font-family="system-ui">✓ Scale ได้หลักพัน tag</text>
  <text x="630" y="224" font-size="13" fill="var(--ink)" font-family="system-ui">✓ Position คำนวณที่ server</text>
  <text x="630" y="256" font-size="13" fill="#ef4444" font-family="system-ui">✗ ต้องซิงค์ anchor ระดับ ns</text>
  <text x="630" y="280" font-size="13" fill="#ef4444" font-family="system-ui">✗ Infrastructure ซับซ้อนกว่า</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> TWR = ง่าย ไม่ซิงค์ เหมาะ small-medium; TDoA = battery ยาวนาน scale ได้ เหมาะ large-scale RTLS</div>

<!-- Speaker note: DS-TWR 3 รอบยกเลิก clock drift TDoA ต้องการ hardware PPS หรือ wired sync ระหว่าง anchor -->

---

## 6 Chips ขับเคลื่อน UWB ecosystem — ทุกตัวรองรับ Channel 5+9

<p class="subhead">Qorvo, NXP, Apple ครอง silicon; FiRa interoperability ผ่าน ch 5 (6.5 GHz) + ch 9 (8 GHz)</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="10" width="320" height="36" rx="8" fill="var(--muted)" opacity="0.18"/>
  <text x="180" y="33" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tag / Low-Power</text>
  <rect x="390" y="10" width="320" height="36" rx="8" fill="var(--muted)" opacity="0.18"/>
  <text x="550" y="33" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Transceiver / Anchor</text>
  <rect x="760" y="10" width="320" height="36" rx="8" fill="var(--accent)" opacity="0.1"/>
  <text x="920" y="33" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Consumer Silicon</text>
  <!-- Tag chips -->
  <rect x="40" y="62" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="180" y="88" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">NXP SR040</text>
  <text x="180" y="108" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">802.15.4z · TDoA · coin-cell</text>
  <text x="180" y="124" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">FiRa · no AoA</text>
  <rect x="40" y="146" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="180" y="172" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">NXP SR150</text>
  <text x="180" y="192" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">802.15.4z · Anchor · AoA ±3°</text>
  <text x="180" y="208" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">access control · car key</text>
  <!-- Transceiver chips -->
  <rect x="410" y="62" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="88" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Qorvo DW1000</text>
  <text x="550" y="108" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">802.15.4a · legacy · ch 1–5,7</text>
  <text x="550" y="124" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">prototype-friendly</text>
  <rect x="410" y="146" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="172" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Qorvo DW3000</text>
  <text x="550" y="192" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">802.15.4a+z · FiRa · STS</text>
  <text x="550" y="208" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ch 5+9 · interop Apple U1/U2</text>
  <!-- Consumer chips -->
  <rect x="780" y="62" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="920" y="88" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Apple U1</text>
  <text x="920" y="108" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">iPhone 11–14 · AirTag gen 1</text>
  <text x="920" y="124" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">16 nm · ch 5+9</text>
  <rect x="780" y="146" width="280" height="70" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="920" y="172" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Apple U2</text>
  <text x="920" y="192" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">iPhone 15+ · AirTag gen 2</text>
  <text x="920" y="208" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">7 nm · expanded range</text>
  <!-- FiRa badge -->
  <rect x="300" y="242" width="500" height="34" rx="17" fill="var(--accent)" opacity="0.1" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="264" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui">FiRa interoperability — Channel 5 (6.5 GHz) + Channel 9 (8 GHz)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> DW3000 + SR150/SR040 + Apple U1/U2 ล้วน interoperable ผ่าน FiRa — NXP SR150 เพิ่ม AoA ±3° สำหรับ direction finding</div>

<!-- Speaker note: AoA คือสิ่งที่ทำให้ iPhone ชี้ลูกศรหา AirTag ได้ ต้องมีทั้ง ranging และ direction -->

---

## UWB เหนือกว่า 10× ด้านความแม่นยำ แต่ต้องลงทุน anchor infrastructure

<p class="subhead">4 เทคโนโลยี 5 มิติ — เลือก trade-off ให้ตรง use case</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Header -->
  <rect x="200" y="10" width="200" height="34" rx="6" fill="var(--accent)" opacity="0.9"/>
  <text x="300" y="33" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">UWB</text>
  <rect x="420" y="10" width="180" height="34" rx="6" fill="var(--muted)" opacity="0.35"/>
  <text x="510" y="33" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BLE</text>
  <rect x="620" y="10" width="180" height="34" rx="6" fill="var(--muted)" opacity="0.35"/>
  <text x="710" y="33" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Wi-Fi</text>
  <rect x="820" y="10" width="180" height="34" rx="6" fill="#ef4444" opacity="0.18"/>
  <text x="910" y="33" font-size="14" font-weight="700" fill="#ef4444" text-anchor="middle" font-family="system-ui">GPS</text>
  <!-- Alternating row bg -->
  <rect x="10" y="52" width="1080" height="48" rx="4" fill="var(--soft)"/>
  <rect x="10" y="148" width="1080" height="48" rx="4" fill="var(--soft)"/>
  <rect x="10" y="244" width="1080" height="48" rx="4" fill="var(--soft)"/>
  <!-- Row labels -->
  <text x="105" y="82" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Accuracy</text>
  <text x="105" y="130" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Power</text>
  <text x="105" y="178" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Indoor</text>
  <text x="105" y="226" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Infra</text>
  <text x="105" y="274" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tag cost</text>
  <!-- UWB column -->
  <text x="300" y="82" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">★ 10–30 cm</text>
  <text x="300" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต่ำ (TDoA: ปีต่อถ่าน)</text>
  <text x="300" y="178" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">✓ ดีเยี่ยม</text>
  <text x="300" y="226" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">ต้องติด UWB anchor</text>
  <text x="300" y="274" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">~2× BLE</text>
  <!-- BLE column -->
  <text x="510" y="82" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1–5 m</text>
  <text x="510" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต่ำมาก</text>
  <text x="510" y="178" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~ ระดับห้อง</text>
  <text x="510" y="226" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BLE gateway</text>
  <text x="510" y="274" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต่ำ</text>
  <!-- Wi-Fi column -->
  <text x="710" y="82" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5–15 m</text>
  <text x="710" y="130" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">สูง</text>
  <text x="710" y="178" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~ ระดับห้อง</text>
  <text x="710" y="226" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Wi-Fi AP</text>
  <text x="710" y="274" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ปานกลาง</text>
  <!-- GPS column -->
  <text x="910" y="82" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">~10 m กลางแจ้ง</text>
  <text x="910" y="130" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">สูงมาก</text>
  <text x="910" y="178" font-size="12" fill="#ef4444" text-anchor="middle" font-family="system-ui">✗ ล้มเหลว</text>
  <text x="910" y="226" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ดาวเทียม</text>
  <text x="910" y="274" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ขึ้นกับโมดูล</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UWB ชนะด้านความแม่นยำและ indoor — แลกกับ anchor infrastructure ที่แพงกว่า BLE</div>

<!-- Speaker note: ถ้า use case ต้องการแค่ "ห้องไหน" BLE พอและถูกกว่า ต้องการ "cm-level" หรือ "ทิศทาง" ต้องใช้ UWB -->

---

## UWB Mainstream: iPhone 11 (2019) → Car Key Android (2023)

<p class="subhead">จาก research chipset สู่กระเป๋าทุกคน ใน 6 ปี</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <line x1="60" y1="140" x2="1060" y2="140" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="1060,134 1060,146 1072,140" fill="var(--muted)"/>
  <!-- Year ticks -->
  <text x="130" y="274" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2019</text>
  <text x="310" y="274" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2021</text>
  <text x="510" y="274" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2022</text>
  <text x="720" y="274" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2023</text>
  <text x="940" y="274" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">2025</text>
  <!-- 2019: iPhone 11 above -->
  <circle cx="130" cy="140" r="13" fill="var(--accent)"/>
  <line x1="130" y1="127" x2="130" y2="88" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="52" y="42" width="156" height="44" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="130" y="62" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">iPhone 11</text>
  <text x="130" y="79" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Apple U1 · Ch5+9</text>
  <!-- 2021: AirTag below -->
  <circle cx="310" cy="140" r="13" fill="var(--accent)"/>
  <line x1="310" y1="153" x2="310" y2="196" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="226" y="196" width="168" height="44" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="310" y="216" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AirTag Gen 1</text>
  <text x="310" y="233" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Precision Finding</text>
  <!-- 2022: SmartTag+ above -->
  <circle cx="510" cy="140" r="11" fill="var(--muted)" opacity="0.7"/>
  <line x1="510" y1="129" x2="510" y2="88" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="426" y="42" width="168" height="44" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="510" y="62" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Samsung SmartTag+</text>
  <text x="510" y="79" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Galaxy S22 ecosystem</text>
  <!-- 2023: BMW car key below -->
  <circle cx="720" cy="140" r="13" fill="var(--accent)"/>
  <line x1="720" y1="153" x2="720" y2="196" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="632" y="196" width="176" height="44" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="720" y="216" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">BMW Digital Key Plus</text>
  <text x="720" y="233" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Android UWB · CCC 3.0</text>
  <!-- 2025: AirTag 2 + iPhone 15 above -->
  <circle cx="940" cy="140" r="13" fill="var(--accent)"/>
  <line x1="940" y1="127" x2="940" y2="88" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="848" y="42" width="184" height="44" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="940" y="62" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">iPhone 15 + AirTag 2</text>
  <text x="940" y="79" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Apple U2 · 7 nm</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UWB mainstream ใน 6 ปี — 2019 iPhone U1 → 2021 AirTag → 2023 car key; ตอนนี้ฝังอยู่ใน flagship phone ทุกเครื่อง</div>

<!-- Speaker note: Apple เปิด U1 third-party API WWDC 2021 Genesis GV60 คือ EV แรกที่ใช้ Samsung UWB digital key -->

---

## NLOS คือ error source หลัก — แก้ด้วย ML + sensor fusion

<p class="subhead">ผนัง โลหะ ร่างกายคนเพิ่ม range bias ได้ถึงหลาย m; 3 ข้อจำกัดอื่นที่ต้องรู้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="16" width="500" height="136" rx="12" fill="var(--paper)" stroke="#ef4444" stroke-width="2"/>
  <rect x="40" y="16" width="10" height="136" rx="4" fill="#ef4444"/>
  <text x="80" y="52" font-size="15" font-weight="700" fill="#ef4444" font-family="system-ui">⚠ NLOS (ปัญหาหลัก)</text>
  <text x="80" y="78" font-size="13" fill="var(--ink)" font-family="system-ui">ผนังคอนกรีต / โลหะ / ลิฟต์</text>
  <text x="80" y="100" font-size="13" fill="var(--ink)" font-family="system-ui">เพิ่ม range bias cm → หลาย m</text>
  <text x="80" y="122" font-size="13" fill="var(--muted)" font-family="system-ui">→ แก้: ML + IMU + floor map sensor fusion</text>
  <text x="80" y="142" font-size="12" fill="var(--muted)" font-family="system-ui">Active research area; anchor เพิ่มถี่ช่วยได้บางส่วน</text>
  <rect x="580" y="16" width="480" height="136" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="580" y="16" width="8" height="136" rx="4" fill="var(--muted)"/>
  <text x="620" y="52" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">💰 Cost</text>
  <text x="620" y="78" font-size="13" fill="var(--ink)" font-family="system-ui">Anchor UWB สูงกว่า BLE beacon</text>
  <text x="620" y="100" font-size="13" fill="var(--ink)" font-family="system-ui">Tag ~2× BLE; กำลังลดลง</text>
  <text x="620" y="122" font-size="13" fill="var(--muted)" font-family="system-ui">RTLS คุ้มค่าเมื่อ sub-meter accuracy จำเป็น</text>
  <rect x="40" y="172" width="500" height="132" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="172" width="8" height="132" rx="4" fill="var(--muted)"/>
  <text x="78" y="208" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">🌏 Regulatory</text>
  <text x="78" y="234" font-size="13" fill="var(--ink)" font-family="system-ui">FCC (US): 3.1–10.6 GHz</text>
  <text x="78" y="256" font-size="13" fill="var(--ink)" font-family="system-ui">EU/ETSI, Japan, Korea: band ต่างกัน</text>
  <text x="78" y="278" font-size="12" fill="var(--muted)" font-family="system-ui">→ multi-region compliance ต้องวางแผนล่วงหน้า</text>
  <rect x="580" y="172" width="480" height="132" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="580" y="172" width="8" height="132" rx="4" fill="var(--muted)"/>
  <text x="618" y="208" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">🔐 Security (STS threshold)</text>
  <text x="618" y="234" font-size="13" fill="var(--ink)" font-family="system-ui">STS ป้องกัน relay ได้ แต่ไม่ 100%</text>
  <text x="618" y="256" font-size="13" fill="var(--ink)" font-family="system-ui">miss-detect &lt;10% → attack 7–90%</text>
  <text x="618" y="278" font-size="12" fill="var(--muted)" font-family="system-ui">→ ต้อง tune receiver threshold ระมัดระวัง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> NLOS คือ Achilles' heel ของ UWB — แก้ด้วย ML + sensor fusion ไม่ใช่แค่ anchor หนาแน่น</div>

<!-- Speaker note: Singh et al. arXiv 2023 STS ไม่ได้ป้องกัน 100% ต้องตั้ง receiver threshold ให้ดี TWR scalability: time-division จำกัด tag/zone ต้องเปลี่ยนเป็น TDoA ถ้า scale ใหญ่ -->

---

## Key Takeaways: ToF Physics → Consumer Mainstream

<p class="subhead">5 ข้อที่ควรจำจาก deck นี้</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="48" cy="44" r="18" fill="var(--accent)"/>
  <text x="48" y="49" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="84" y="40" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Bandwidth ≥500 MHz + sub-ns ToF → 10–30 cm accuracy (physics ไม่ใช่ software)</text>
  <text x="84" y="60" font-size="12" fill="var(--muted)" font-family="system-ui">BLE/Wi-Fi bandwidth แคบเกินไปที่จะแม่นยำระดับ cm</text>
  <circle cx="48" cy="112" r="18" fill="var(--accent)"/>
  <text x="48" y="117" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="84" y="108" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">TWR = ง่าย ไม่ซิงค์ anchor &nbsp;|&nbsp; TDoA = battery ยาว scale ได้กว่า</text>
  <text x="84" y="128" font-size="12" fill="var(--muted)" font-family="system-ui">เลือกตามจำนวน tag, อายุถ่าน, และ infrastructure budget</text>
  <circle cx="48" cy="180" r="18" fill="var(--accent)"/>
  <text x="48" y="185" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="84" y="176" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">802.15.4z + STS ป้องกัน relay attack — ขาดไม่ได้สำหรับ car key</text>
  <text x="84" y="196" font-size="12" fill="var(--muted)" font-family="system-ui">STS ≠ 100% secure; ต้อง tune receiver threshold (Singh et al. 2023)</text>
  <circle cx="48" cy="248" r="18" fill="var(--accent)"/>
  <text x="48" y="253" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="84" y="244" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">FiRa interop ผ่าน ch 5+9 — DW3000, SR150, SR040, Apple U1/U2 ทำงานร่วมกันได้</text>
  <text x="84" y="264" font-size="12" fill="var(--muted)" font-family="system-ui">NXP SR150 เพิ่ม AoA ±3° สำหรับ direction finding</text>
  <circle cx="48" cy="316" r="18" fill="var(--accent)"/>
  <text x="48" y="321" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">5</text>
  <text x="84" y="312" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">NLOS คือ Achilles' heel — แก้ด้วย ML + sensor fusion; ราคากำลังลดลงทุกปี</text>
  <text x="84" y="332" font-size="12" fill="var(--muted)" font-family="system-ui">Consumer volume (iPhone/AirTag) ดึงให้ต้นทุน industrial RTLS ลดลง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UWB = physics-backed cm accuracy ที่ฝังอยู่ใน phone แล้ว — ลงทุน anchor infrastructure เพื่อแลก precision ที่ BLE/Wi-Fi ให้ไม่ได้</div>

<!-- Speaker note: จบ deck ย้ำว่า UWB mainstream แล้ว ไม่ใช่ emerging tech อีกต่อไป คำถาม? -->
