---
marp: true
theme: default
paginate: true
title: "RTK GPS คืออะไร"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; --green:#22c55e; --orange:#f59e0b; }
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

# RTK GPS คืออะไร

**ทำไม GPS ถึงแม่นขึ้น 100× — และทำงานอย่างไร**

<!-- Speaker note: Hook: GPS ในโทรศัพท์แม่น ~3m แต่ RTK แม่น 1-2cm ด้วยดาวเทียมชุดเดียวกัน ทำได้อย่างไร? -->

---

## GPS ปกติแม่น ~3m — RTK ดันขึ้นมาที่ 1–2 ซม.

<p class="subhead">เพราะ error จากดาวเทียมและบรรยากาศ "เหมือนกัน" ทั้งคู่ — RTK หักลบมันออกได้ทันที</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Standard GPS -->
  <rect x="40" y="50" width="460" height="280" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="50" width="460" height="56" rx="14" fill="#f8fafc"/>
  <rect x="40" y="94" width="460" height="12" fill="#f8fafc"/>
  <text x="270" y="84" font-size="17" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">GPS ปกติ (Standalone)</text>
  <!-- big number -->
  <text x="270" y="200" font-size="72" font-weight="800" fill="#e2e8f0" text-anchor="middle" font-family="system-ui">~3 ม.</text>
  <text x="270" y="248" font-size="14" fill="var(--muted)" text-anchor="middle" font-family="system-ui">code-phase · atmospheric error · clock drift</text>
  <text x="270" y="300" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เพียงพอสำหรับ: navigation, แผนที่ทั่วไป</text>

  <!-- VS badge -->
  <circle cx="550" cy="190" r="32" fill="var(--accent)"/>
  <text x="550" y="190" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>

  <!-- Right: RTK -->
  <rect x="600" y="50" width="460" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="600" y="50" width="460" height="56" rx="14" fill="#eff6ff"/>
  <rect x="600" y="94" width="460" height="12" fill="#eff6ff"/>
  <text x="830" y="84" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">RTK (Real-Time Kinematic)</text>
  <!-- big number -->
  <text x="830" y="200" font-size="72" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1–2 ซม.</text>
  <text x="830" y="248" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">carrier-phase · base correction · ambiguity resolved</text>
  <text x="830" y="300" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้กับ: สำรวจที่ดิน, โดรน, เกษตรแม่นยำ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTK ใช้ดาวเทียมชุดเดียวกันกับ GPS ทั่วไป — แต่หักลบ error ร่วมกันระหว่าง base กับ rover ได้ทันที</div>

<!-- Speaker note: จุดสำคัญ: same satellites, entirely different math. -->

---

## GPS error มาจาก 3 แหล่ง — ทั้งหมดนี้ RTK หักลบออกได้

<p class="subhead">เพราะ base และ rover รับ error ชุดเดียวกัน ณ เวลาเดียวกัน — correction คือ "ความต่าง" ระหว่างทั้งสอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 error sources boxes -->
  <!-- Box 1: Satellite clock -->
  <rect x="40" y="60" width="290" height="200" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="60" width="290" height="52" rx="12" fill="#fef3c7"/>
  <rect x="40" y="100" width="290" height="12" fill="#fef3c7"/>
  <text x="185" y="88" font-size="14" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">① Satellite Clock Error</text>
  <text x="185" y="136" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">นาฬิกาดาวเทียมเดินไม่ตรง</text>
  <text x="185" y="158" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">→ เวลา off → ระยะ off</text>
  <text x="185" y="230" font-size="22" font-weight="700" fill="var(--orange)" text-anchor="middle" font-family="system-ui">±1–2 ม.</text>

  <!-- Box 2: Atmosphere -->
  <rect x="405" y="60" width="290" height="200" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="405" y="60" width="290" height="52" rx="12" fill="#fef3c7"/>
  <rect x="405" y="100" width="290" height="12" fill="#fef3c7"/>
  <text x="550" y="88" font-size="14" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">② Atmosphere Delay</text>
  <text x="550" y="136" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ionosphere + troposphere</text>
  <text x="550" y="158" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ชะลอสัญญาณ → ระยะยาวขึ้น</text>
  <text x="550" y="230" font-size="22" font-weight="700" fill="var(--orange)" text-anchor="middle" font-family="system-ui">±1–3 ม.</text>

  <!-- Box 3: Multipath -->
  <rect x="770" y="60" width="290" height="200" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="770" y="60" width="290" height="52" rx="12" fill="#fef3c7"/>
  <rect x="770" y="100" width="290" height="12" fill="#fef3c7"/>
  <text x="915" y="88" font-size="14" font-weight="700" fill="#92400e" text-anchor="middle" font-family="system-ui">③ Multipath</text>
  <text x="915" y="136" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">สัญญาณสะท้อนจากอาคาร</text>
  <text x="915" y="158" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">receiver รับหลาย path</text>
  <text x="915" y="230" font-size="22" font-weight="700" fill="var(--orange)" text-anchor="middle" font-family="system-ui">variable</text>

  <!-- RTK cancels errors 1 & 2 -->
  <rect x="80" y="296" width="900" height="48" rx="10" fill="#eff6ff" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="530" y="316" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">RTK หักลบ ① และ ② ออก เพราะ base กับ rover รับ error เดียวกัน ณ เวลาเดียวกัน</text>
  <text x="530" y="336" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">③ multipath ยังเป็นปัญหา — ต้องหลีกเลี่ยงสิ่งกีดขวาง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Base กับ rover "ดู" error เดียวกัน → หักลบออกได้; multipath ยังคงเป็นข้อจำกัดที่แก้ไม่ได้ด้วย RTK</div>

<!-- Speaker note: ① ② cancel in differential math; ③ does not. -->

---

## Carrier Phase แม่นกว่า Code Phase ถึง 1,000×

<p class="subhead">L1 carrier (1575 MHz) เปลี่ยน phase บ่อยกว่า C/A code (1.023 MHz) มาก — ความละเอียดจึงสูงกว่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Code Phase -->
  <rect x="40" y="40" width="470" height="300" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="40" width="470" height="56" rx="14" fill="#f8fafc"/>
  <rect x="40" y="84" width="470" height="12" fill="#f8fafc"/>
  <text x="275" y="74" font-size="17" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Code Phase (C/A)</text>
  <!-- Square wave representation -->
  <polyline points="80,180 80,140 130,140 130,180 180,180 180,140 230,140 230,180 280,180 280,140 330,140 330,180 380,180 380,140 430,140 430,180 470,180" fill="none" stroke="var(--muted)" stroke-width="2.5"/>
  <text x="275" y="220" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ความถี่: ~1.023 MHz</text>
  <text x="275" y="244" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">wavelength: ~300 ม.</text>
  <text x="275" y="290" font-size="26" font-weight="800" fill="var(--muted)" text-anchor="middle" font-family="system-ui">±1–5 ม.</text>

  <!-- VS badge -->
  <circle cx="550" cy="190" r="32" fill="var(--accent)"/>
  <text x="550" y="190" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">×1000</text>

  <!-- Right: Carrier Phase -->
  <rect x="590" y="40" width="470" height="300" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="40" width="470" height="56" rx="14" fill="#eff6ff"/>
  <rect x="590" y="84" width="470" height="12" fill="#eff6ff"/>
  <text x="825" y="74" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Carrier Phase (L1)</text>
  <!-- Sine wave representation -->
  <path d="M 630,180 Q 650,140 670,180 Q 690,220 710,180 Q 730,140 750,180 Q 770,220 790,180 Q 810,140 830,180 Q 850,220 870,180 Q 890,140 910,180 Q 930,220 950,180 Q 970,140 990,180 Q 1010,220 1020,180" fill="none" stroke="var(--accent)" stroke-width="2.5"/>
  <text x="825" y="220" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ความถี่: 1575.42 MHz</text>
  <text x="825" y="244" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">wavelength: ~19 ซม.</text>
  <text x="825" y="290" font-size="26" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">±1.9 มม.</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ±1% ของ C/A wavelength = ~3ม.; ±1% ของ L1 carrier = ~1.9มม. — เดิม satellites, math ต่างกันทั้งหมด</div>

<!-- Speaker note: Integer ambiguity ต้อง resolve ก่อนถึงใช้ carrier phase ได้ — นั่นคือเวลา FLOAT→FIX -->

---

## Base + Rover: สถาปัตยกรรมของ RTK

<p class="subhead">Base อยู่กับที่ คำนวณ error ส่ง correction; Rover รับ correction หักลบกับ raw GNSS → ได้ FIX</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Satellites at top -->
  <circle cx="250" cy="50" r="28" fill="var(--accent)" opacity="0.8"/>
  <text x="250" y="50" font-size="11" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">SAT</text>
  <circle cx="550" cy="30" r="28" fill="var(--accent)" opacity="0.8"/>
  <text x="550" y="30" font-size="11" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">SAT</text>
  <circle cx="850" cy="50" r="28" fill="var(--accent)" opacity="0.8"/>
  <text x="850" y="50" font-size="11" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">SAT</text>

  <!-- Signal lines to Base -->
  <line x1="250" y1="78" x2="220" y2="200" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3" opacity="0.5"/>
  <line x1="550" y1="58" x2="220" y2="200" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3" opacity="0.5"/>
  <!-- Signal lines to Rover -->
  <line x1="550" y1="58" x2="850" y2="200" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3" opacity="0.5"/>
  <line x1="850" y1="78" x2="850" y2="200" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3" opacity="0.5"/>

  <!-- Base Station box -->
  <rect x="100" y="196" width="240" height="120" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="2"/>
  <rect x="100" y="196" width="240" height="44" rx="12" fill="#f1f5f9"/>
  <rect x="100" y="228" width="240" height="12" fill="#f1f5f9"/>
  <text x="220" y="220" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Base Station</text>
  <text x="220" y="258" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">พิกัดที่รู้แน่นอน</text>
  <text x="220" y="278" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">คำนวณ: measured − known = error</text>
  <text x="220" y="298" font-size="12" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">→ ส่ง RTCM correction</text>

  <!-- Correction arrow -->
  <defs>
    <marker id="arr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--green)"/>
    </marker>
  </defs>
  <line x1="348" y1="256" x2="735" y2="256" stroke="var(--green)" stroke-width="2.5" marker-end="url(#arr)"/>
  <rect x="430" y="232" width="240" height="44" rx="8" fill="white" stroke="var(--green)" stroke-width="1.5"/>
  <text x="550" y="250" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">RTCM Correction</text>
  <text x="550" y="268" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Radio / 4G / NTRIP</text>

  <!-- Rover box -->
  <rect x="760" y="196" width="240" height="120" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="760" y="196" width="240" height="44" rx="12" fill="#eff6ff"/>
  <rect x="760" y="228" width="240" height="12" fill="#eff6ff"/>
  <text x="880" y="220" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Rover</text>
  <text x="880" y="258" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เคลื่อนที่ได้</text>
  <text x="880" y="278" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">raw GNSS − correction</text>
  <text x="880" y="298" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">→ FIX: 1–2 ซม.</text>

  <!-- Requirement note -->
  <text x="550" y="355" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Baseline (base↔rover) ควรไม่เกิน 20–30 กม. สำหรับ multi-band | ~10 กม. สำหรับ single-band</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTK ไม่ได้ทำให้ดาวเทียมแม่นขึ้น — แต่ใช้ base station เป็น "reference" หักลบ common error ออก</div>

<!-- Speaker note: Explain why baseline matters: farther = different atmosphere slice = less common error to cancel. -->

---

## SINGLE → FLOAT → FIX: สถานะ 3 ระดับที่ต้องรู้จัก

<p class="subhead">RTK ต้องแก้ "integer ambiguity" ก่อนจึงจะ FIX — กระบวนการนี้ใช้เวลา 30 วินาที ถึงไม่กี่นาที</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Progress bar background -->
  <rect x="80" y="120" width="940" height="24" rx="12" fill="#f1f5f9"/>
  <!-- Filled -->
  <rect x="80" y="120" width="940" height="24" rx="12" fill="url(#prog)"/>
  <defs>
    <linearGradient id="prog" x1="0" x2="1" y1="0" y2="0">
      <stop offset="0%" stop-color="#ef4444"/>
      <stop offset="45%" stop-color="#f59e0b"/>
      <stop offset="100%" stop-color="#22c55e"/>
    </linearGradient>
  </defs>

  <!-- SINGLE -->
  <circle cx="180" cy="132" r="38" fill="var(--danger)" stroke="white" stroke-width="3"/>
  <text x="180" y="128" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">SINGLE</text>
  <text x="180" y="148" font-size="11" fill="white" text-anchor="middle" font-family="system-ui">no fix</text>
  <!-- description -->
  <rect x="80" y="198" width="200" height="110" rx="10" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="180" y="220" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ไม่มี correction</text>
  <text x="180" y="244" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">GPS ปกติ</text>
  <text x="180" y="266" font-size="22" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">~2–5 ม.</text>
  <text x="180" y="290" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้งาน: ไม่ได้สำหรับงานแม่นยำ</text>

  <!-- FLOAT -->
  <circle cx="550" cy="132" r="38" fill="var(--orange)" stroke="white" stroke-width="3"/>
  <text x="550" y="128" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">FLOAT</text>
  <text x="550" y="148" font-size="11" fill="white" text-anchor="middle" font-family="system-ui">partial</text>
  <!-- description -->
  <rect x="450" y="198" width="200" height="110" rx="10" fill="var(--paper)" stroke="var(--orange)" stroke-width="1.5"/>
  <text x="550" y="220" font-size="13" font-weight="700" fill="var(--orange)" text-anchor="middle" font-family="system-ui">รับ correction แล้ว</text>
  <text x="550" y="244" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ambiguity ยังไม่ resolved</text>
  <text x="550" y="266" font-size="22" font-weight="800" fill="var(--orange)" text-anchor="middle" font-family="system-ui">10–50 ซม.</text>
  <text x="550" y="290" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้งาน: รอ FIX ต่อไป</text>

  <!-- FIX -->
  <circle cx="920" cy="132" r="38" fill="var(--green)" stroke="white" stroke-width="3"/>
  <text x="920" y="128" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">FIX</text>
  <text x="920" y="148" font-size="11" fill="white" text-anchor="middle" font-family="system-ui">✓</text>
  <!-- description -->
  <rect x="820" y="198" width="200" height="110" rx="10" fill="var(--paper)" stroke="var(--green)" stroke-width="2"/>
  <text x="920" y="220" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">ambiguity resolved</text>
  <text x="920" y="244" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">carrier-phase active</text>
  <text x="920" y="266" font-size="22" font-weight="800" fill="var(--green)" text-anchor="middle" font-family="system-ui">1–2 ซม.</text>
  <text x="920" y="290" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ใช้งาน: สำรวจ, stake-out ได้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยอมรับเฉพาะ FIX สำหรับงานแม่นยำ — FLOAT ดีกว่า SINGLE แต่ยังไม่พอ; รอจนกว่าจะ FIX</div>

<!-- Speaker note: Time to first FIX depends on satellite geometry, baseline, and receiver quality. Multi-band is faster. -->

---

## ส่ง Correction 3 วิธี — เลือกตามสภาพแวดล้อม

<p class="subhead">ทุกวิธีส่งข้อมูล RTCM เหมือนกัน — ต่างกันที่ medium ไม่ใช่ protocol</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Box 1: Radio UHF -->
  <rect x="40" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="40" width="320" height="56" rx="14" fill="#f8fafc"/>
  <rect x="40" y="84" width="320" height="12" fill="#f8fafc"/>
  <text x="200" y="74" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">📡 Radio (UHF)</text>
  <text x="200" y="128" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ส่งตรงจาก base → rover</text>
  <text x="200" y="150" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ต้องใช้ internet / SIM</text>
  <text x="200" y="186" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ offline ได้</text>
  <text x="200" y="208" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ low latency</text>
  <text x="200" y="244" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ ระยะ ~10 กม. max</text>
  <text x="200" y="266" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ ต้องมี line-of-sight</text>

  <!-- Box 2: NTRIP (highlighted) -->
  <rect x="390" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2.5"/>
  <rect x="390" y="40" width="320" height="56" rx="14" fill="#eff6ff"/>
  <rect x="390" y="84" width="320" height="12" fill="#eff6ff"/>
  <text x="550" y="74" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">🌐 NTRIP (แนะนำ)</text>
  <text x="550" y="128" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">internet → NTRIP caster</text>
  <text x="550" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ไม่ต้องตั้ง base เอง</text>
  <text x="550" y="186" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ ใช้ network station</text>
  <text x="550" y="208" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ ครอบคลุมพื้นที่กว้าง</text>
  <text x="550" y="244" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ ต้องมี 4G ตลอดเวลา</text>
  <text x="550" y="266" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ค่าบริการ $50–200/เดือน</text>

  <!-- Box 3: 4G cellular own base -->
  <rect x="740" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="740" y="40" width="320" height="56" rx="14" fill="#f8fafc"/>
  <rect x="740" y="84" width="320" height="12" fill="#f8fafc"/>
  <text x="900" y="74" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">📶 4G (base เอง)</text>
  <text x="900" y="128" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">base ส่ง correction ผ่าน 4G</text>
  <text x="900" y="150" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">rover รับผ่าน cellular</text>
  <text x="900" y="186" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ ระยะยาว</text>
  <text x="900" y="208" font-size="13" font-weight="600" fill="var(--green)" text-anchor="middle" font-family="system-ui">✓ ยืดหยุ่น</text>
  <text x="900" y="244" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ ต้องมี SIM ทั้ง base+rover</text>
  <text x="900" y="266" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗ ต้องตั้ง base เอง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> NTRIP คือตัวเลือกที่สะดวกที่สุดในปัจจุบัน — ไม่ต้องตั้ง base เอง ใช้ public/commercial network station ได้ทันที</div>

<!-- Speaker note: RTSD (กรมแผนที่ทหาร) และ GISTDA มี NTRIP service ในไทย -->

---

## RTK vs PPK: Math เดียวกัน แต่เวลาประมวลผลต่างกัน

<p class="subhead">เลือกตาม workflow ไม่ใช่ตามความแม่นยำ — ทั้งคู่ได้ cm-level เหมือนกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: RTK -->
  <rect x="40" y="30" width="490" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="40" y="30" width="490" height="56" rx="14" fill="#eff6ff"/>
  <rect x="40" y="74" width="490" height="12" fill="#eff6ff"/>
  <text x="285" y="64" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">RTK — Real-Time</text>
  <!-- timeline arrow -->
  <line x1="80" y1="160" x2="490" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="120" cy="160" r="10" fill="var(--accent)"/>
  <text x="120" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">START</text>
  <circle cx="305" cy="160" r="10" fill="var(--accent)"/>
  <text x="305" y="185" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FIX ได้</text>
  <circle cx="480" cy="160" r="10" fill="var(--green)"/>
  <text x="480" y="185" font-size="11" fill="var(--green)" text-anchor="middle" font-family="system-ui">stake-out!</text>
  <text x="285" y="225" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ใช้กับ: งานสำรวจที่ดิน, machine control</text>
  <text x="285" y="248" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ต้องการ: correction link ตลอดเวลา</text>
  <text x="285" y="278" font-size="13" font-weight="600" fill="var(--accent)" text-anchor="middle" font-family="system-ui">✓ เห็นผลทันที</text>

  <!-- VS -->
  <circle cx="550" cy="170" r="32" fill="var(--ink)"/>
  <text x="550" y="170" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>

  <!-- Right: PPK -->
  <rect x="570" y="30" width="490" height="280" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="570" y="30" width="490" height="56" rx="14" fill="#f8fafc"/>
  <rect x="570" y="74" width="490" height="12" fill="#f8fafc"/>
  <text x="815" y="64" font-size="18" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PPK — Post-Processing</text>
  <!-- timeline arrow -->
  <line x1="610" y1="160" x2="1020" y2="160" stroke="var(--muted)" stroke-width="2"/>
  <circle cx="650" cy="160" r="10" fill="var(--muted)"/>
  <text x="650" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">FLY</text>
  <circle cx="835" cy="160" r="10" fill="var(--muted)"/>
  <text x="835" y="185" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">LOG data</text>
  <circle cx="1010" cy="160" r="10" fill="var(--green)"/>
  <text x="1010" y="185" font-size="11" fill="var(--green)" text-anchor="middle" font-family="system-ui">post-process</text>
  <text x="815" y="225" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ใช้กับ: Drone mapping, ภาพถ่ายทางอากาศ</text>
  <text x="815" y="248" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ไม่ต้องการ: correction link แบบ real-time</text>
  <text x="815" y="278" font-size="13" font-weight="600" fill="var(--muted)" text-anchor="middle" font-family="system-ui">✓ ยืดหยุ่นกว่าในพื้นที่ห่างไกล</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> โดรน mapping → PPK (บินก่อน แก้ทีหลัง); สำรวจ stakeout → RTK (ต้องรู้จุดทันที)</div>

<!-- Speaker note: Same math: carrier phase ambiguity resolution. Difference is when you do it. -->

---

## NTRIP Setup: 4 ขั้นตอนจาก SINGLE สู่ FIX

<p class="subhead">ทำครั้งแรกใช้เวลา ~10 นาที; ครั้งต่อไปเปิด receiver รอ 30–120 วินาที FIX อัตโนมัติ</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step boxes connected by arrows -->
  <!-- Step 1 -->
  <rect x="40" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="145" cy="80" r="20" fill="var(--accent)"/>
  <text x="145" y="80" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="145" y="126" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เตรียมอุปกรณ์</text>
  <text x="145" y="150" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">RTK receiver</text>
  <text x="145" y="170" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SIM 4G</text>
  <text x="145" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">NTRIP account</text>
  <text x="145" y="218" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Emlid/u-blox</text>

  <!-- Arrow 1→2 -->
  <defs>
    <marker id="a2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto">
      <path d="M0,0 L10,5 L0,10 z" fill="var(--accent)"/>
    </marker>
  </defs>
  <line x1="258" y1="160" x2="288" y2="160" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Step 2 -->
  <rect x="295" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="400" cy="80" r="20" fill="var(--accent)"/>
  <text x="400" y="80" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="400" y="126" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ตั้งค่า NTRIP</text>
  <text x="400" y="150" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">host + port</text>
  <text x="400" y="170" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">mountpoint</text>
  <text x="400" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">user / password</text>
  <text x="400" y="218" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ใน app ของ receiver</text>

  <!-- Arrow 2→3 -->
  <line x1="513" y1="160" x2="543" y2="160" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Step 3 -->
  <rect x="550" y="80" width="210" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="655" cy="80" r="20" fill="var(--accent)"/>
  <text x="655" y="80" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="655" y="126" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">รอ FIX</text>
  <text x="655" y="150" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SINGLE → FLOAT</text>
  <text x="655" y="170" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">→ FIX</text>
  <text x="655" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">30–120 วินาที</text>
  <text x="655" y="218" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">PDOP &lt; 3 = geometry ดี</text>

  <!-- Arrow 3→4 -->
  <line x1="768" y1="160" x2="798" y2="160" stroke="var(--green)" stroke-width="2" marker-end="url(#a2)"/>

  <!-- Step 4 -->
  <rect x="805" y="80" width="255" height="160" rx="12" fill="var(--paper)" stroke="var(--green)" stroke-width="2.5"/>
  <circle cx="932" cy="80" r="20" fill="var(--green)"/>
  <text x="932" y="80" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">✓</text>
  <text x="932" y="126" font-size="13" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">FIX — เริ่มงานได้</text>
  <text x="932" y="150" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เก็บ waypoint</text>
  <text x="932" y="170" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">stake-out</text>
  <text x="932" y="190" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">machine control</text>
  <text x="932" y="218" font-size="11" fill="var(--green)" text-anchor="middle" font-family="system-ui">± 1–2 ซม.</text>

  <!-- Note -->
  <text x="550" y="290" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">สูญเสีย FIX → หยุดงาน รอ FIX กลับมา; ห้ามรับข้อมูลในสถานะ FLOAT สำหรับงานที่ต้องการความแม่นยำ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Setup ครั้งแรก ~10 นาที — ครั้งถัดไปรอแค่ FIX lock; ห้ามเก็บข้อมูลก่อน FIX</div>

<!-- Speaker note: Most field failures come from accepting FLOAT data. Always check status indicator. -->

---

## 7 ข้อจำกัดที่ต้องรู้ก่อนใช้งาน RTK

<p class="subhead">RTK ไม่ใช่ silver bullet — สภาพแวดล้อมและ setup มีผลต่อ accuracy โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 + 4 grid layout -->
  <!-- Row 1: 3 items -->
  <rect x="30" y="20" width="320" height="100" rx="10" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="70" y="58" font-size="22" font-family="system-ui">🏢</text>
  <text x="110" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Multipath</text>
  <text x="110" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">อาคาร/ต้นไม้สะท้อนสัญญาณ</text>
  <text x="110" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">→ accuracy ลดลงทันที</text>
  <text x="110" y="112" font-size="11" fill="var(--danger)" font-family="system-ui">แก้: หลีกเลี่ยงสิ่งกีดขวาง</text>

  <rect x="390" y="20" width="320" height="100" rx="10" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="430" y="58" font-size="22" font-family="system-ui">☁️</text>
  <text x="470" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Sky Obstruction</text>
  <text x="470" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">ต้องเห็นท้องฟ้าเปิดโล่ง</text>
  <text x="470" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">ป่าทึบ / ในอาคาร = ใช้ไม่ได้</text>
  <text x="470" y="112" font-size="11" fill="var(--danger)" font-family="system-ui">≥ 6 ดาวเทียม + PDOP &lt; 3</text>

  <rect x="750" y="20" width="320" height="100" rx="10" fill="var(--paper)" stroke="var(--orange)" stroke-width="1.5"/>
  <text x="790" y="58" font-size="22" font-family="system-ui">⏱️</text>
  <text x="830" y="52" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Init Time</text>
  <text x="830" y="72" font-size="12" fill="var(--muted)" font-family="system-ui">รอ FIX lock: 30s – 5 นาที</text>
  <text x="830" y="92" font-size="12" fill="var(--muted)" font-family="system-ui">multi-band เร็วกว่า single-band</text>
  <text x="830" y="112" font-size="11" fill="var(--orange)" font-family="system-ui">plan: รอ FIX ก่อนเริ่มงาน</text>

  <!-- Row 2: 4 items, narrower -->
  <rect x="30" y="148" width="240" height="100" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="150" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Baseline Limit</text>
  <text x="150" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">multi-band: &lt; 30 กม.</text>
  <text x="150" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">single-band: &lt; 10 กม.</text>
  <text x="150" y="238" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">8mm + 1ppm per km</text>

  <rect x="295" y="148" width="240" height="100" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="415" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Single vs Multi-band</text>
  <text x="415" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">single-band: $200–500</text>
  <text x="415" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">multi-band: $1,000–5,000+</text>
  <text x="415" y="238" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ionosphere weather matters</text>

  <rect x="560" y="148" width="240" height="100" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="680" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cost</text>
  <text x="680" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">receiver: $500–$5,000+</text>
  <text x="680" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">NTRIP: $50–200/เดือน</text>
  <text x="680" y="238" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">vs TS survey: +$10,000+</text>

  <rect x="825" y="148" width="245" height="100" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="947" y="180" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Signal Loss</text>
  <text x="947" y="200" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">correction ขาด → FLOAT/SINGLE</text>
  <text x="947" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต้อง re-initialize</text>
  <text x="947" y="238" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PPK ไม่มีปัญหานี้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Multipath และ sky obstruction เป็น hard limits ที่ hardware แก้ไม่ได้ — เลือก site ให้ดีก่อนตั้ง base</div>

<!-- Speaker note: Most RTK failures in the field come from multipath and obstruction, not hardware. -->

---

## RTK = Carrier Phase + Differential Correction + Ambiguity Resolution

<p class="subhead">สรุปแก่นของ RTK ใน 3 ชั้น: physics → math → workflow</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- concentric rings -->
  <circle cx="550" cy="195" r="175" fill="none" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <circle cx="550" cy="195" r="125" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity="0.5"/>
  <circle cx="550" cy="195" r="72" fill="var(--accent)" opacity="0.12"/>
  <circle cx="550" cy="195" r="72" fill="none" stroke="var(--accent)" stroke-width="2.5"/>
  <!-- Core -->
  <text x="550" y="186" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Carrier</text>
  <text x="550" y="206" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Phase</text>

  <!-- Middle ring labels -->
  <text x="400" y="100" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Differential</text>
  <text x="400" y="118" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Correction</text>
  <text x="700" y="100" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Ambiguity</text>
  <text x="700" y="118" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Resolution</text>
  <text x="400" y="288" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Base + Rover</text>
  <text x="400" y="306" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Architecture</text>
  <text x="700" y="288" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">FIX State</text>
  <text x="700" y="306" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">= cm accuracy</text>

  <!-- Outer ring labels -->
  <text x="200" y="175" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">NTRIP /</text>
  <text x="200" y="193" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Radio / 4G</text>
  <text x="890" y="175" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">RTK vs PPK</text>
  <text x="890" y="193" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">workflow</text>

  <!-- Key stats at bottom corners -->
  <text x="80" y="358" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">FIX: 1–2 ซม.</text>
  <text x="80" y="376" font-size="12" fill="var(--muted)" font-family="system-ui">horizontal accuracy</text>
  <text x="870" y="358" font-size="13" font-weight="700" fill="var(--green)" font-family="system-ui" text-anchor="end">100× more precise</text>
  <text x="870" y="376" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="end">vs standalone GPS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> RTK = carrier-phase (physics) + base correction (math) + FIX ambiguity (result) — เข้าใจ 3 ชั้นนี้ = เข้าใจ RTK ทั้งหมด</div>

<!-- Speaker note: End with this mental model: same satellites, different math, different architecture. -->
