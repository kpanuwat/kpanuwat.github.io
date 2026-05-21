---
marp: true
theme: default
paginate: true
title: "วิกฤตโรงงานไทยปิดตัว: ถึงเวลา Industry 4.0 หรืออยู่รอด?"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; --warn:#f59e0b; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:28px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:16px; margin:0 0 8px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .takeaway b { color:var(--accent); }
  .warn-takeaway { border-left:4px solid var(--warn); background:#fffbeb; padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .warn-takeaway b { color:var(--warn); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; }
  section.title h1 { font-size:40px; color:white; margin:0 0 12px 0; line-height:1.2; }
  section.title p { color:#94a3b8; font-size:18px; margin:0; }
---

<!-- _class: title -->

# วิกฤตโรงงานไทยปิดตัว
ถึงเวลา Industry 4.0 — หรืออยู่รอด?

<p style="color:#94a3b8;font-size:17px;margin-top:16px">สัญญาณเตือนภัย · Road Map · BOI Incentives · Upskill/Reskill</p>

<!-- Speaker note: Hook — 2 ปีที่โรงงานไทยปิดตัวไม่หยุด ไม่ใช่วิกฤตชั่วคราว แต่คือ structural shift ที่ต้องตอบสนองด้วย Industry 4.0 -->

---

## วิกฤตตัวเลข: โรงงานไทยปิดตัวไม่หยุด

<p class="subhead">ข้อมูลจาก DIW และ KResearch ยืนยันตัวเลขที่น่าตกใจต่อเนื่อง 2 ปี</p>

<div class="infographic">
<svg viewBox="0 0 1100 400" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 stat boxes -->
  <rect x="40" y="60" width="300" height="280" rx="16" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <rect x="40" y="60" width="300" height="8" rx="4" fill="var(--danger)"/>
  <text x="190" y="160" font-size="64" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">100+</text>
  <text x="190" y="210" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">โรงงานปิด/เดือน</text>
  <text x="190" y="235" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต่อเนื่อง 2 ปี (2024–2025)</text>
  <text x="190" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ที่มา: KResearch ก.พ. 2025</text>

  <rect x="400" y="60" width="300" height="280" rx="16" fill="var(--paper)" stroke="var(--warn)" stroke-width="2"/>
  <rect x="400" y="60" width="300" height="8" rx="4" fill="var(--warn)"/>
  <text x="550" y="160" font-size="64" font-weight="800" fill="var(--warn)" text-anchor="middle" font-family="system-ui">79</text>
  <text x="550" y="210" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">โรงงานปิดในมกราคม 2026</text>
  <text x="550" y="235" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">มูลค่า 2,656 ล้านบาท</text>
  <text x="550" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ที่มา: กรมโรงงานอุตสาหกรรม</text>

  <rect x="760" y="60" width="300" height="280" rx="16" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="760" y="60" width="300" height="8" rx="4" fill="var(--accent)"/>
  <text x="910" y="155" font-size="54" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2.4%</text>
  <text x="910" y="205" font-size="15" fill="var(--ink)" text-anchor="middle" font-family="system-ui">GDP ไทย 2025</text>
  <text x="910" y="230" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">คาดการณ์ 2026: 1.5–2.5%</text>
  <text x="910" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ที่มา: สศช.</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตัวเลขนี้ไม่ใช่ noise — เป็น signal ที่ชัดเจนว่าโมเดลธุรกิจแบบเดิมกำลังล้มเหลว</div>

<!-- Speaker note: ชี้ 3 ตัวเลขพร้อมกัน — ความถี่, ขนาด, บริบท GDP ที่ต่ำเกินรับมือ -->

---

## ไม่ใช่ Recession ชั่วคราว — คือ Structural Shift

<p class="subhead">Nissan และ Suzuki ปิดโรงงานไทยไม่ใช่เพราะเศรษฐกิจ แต่เพราะไทยแข่งขันไม่ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- timeline: 3 events -->
  <line x1="80" y1="190" x2="1020" y2="190" stroke="var(--muted)" stroke-width="2"/>
  <!-- event 1 -->
  <circle cx="180" cy="190" r="14" fill="var(--danger)"/>
  <text x="180" y="165" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">2024</text>
  <text x="180" y="225" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">100+ โรงงาน/เดือน</text>
  <text x="180" y="245" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ปีแรกที่เกินเกณฑ์</text>
  <!-- event 2 -->
  <circle cx="460" cy="190" r="14" fill="var(--danger)"/>
  <text x="460" y="165" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ปลาย 2025</text>
  <text x="460" y="225" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Suzuki ปิดโรงงานไทย</text>
  <text x="460" y="245" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EV จีนกินส่วนแบ่ง</text>
  <!-- event 3 -->
  <circle cx="740" cy="190" r="14" fill="var(--danger)"/>
  <text x="740" y="165" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ม.ค. 2026</text>
  <text x="740" y="225" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Nissan ประกาศลดไลน์</text>
  <text x="740" y="245" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แผนลดต้นทุน ¥8.8 หมื่นล้าน</text>
  <!-- event 4: future -->
  <circle cx="980" cy="190" r="14" fill="var(--accent)" opacity="0.5"/>
  <text x="980" y="155" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2027</text>
  <text x="980" y="225" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ปรับตัวหรืออยู่รอด?</text>
  <text x="980" y="245" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BOI window ปิด</text>
  <!-- cause label -->
  <rect x="250" y="290" width="580" height="50" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1"/>
  <text x="540" y="313" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สาเหตุจริง: ต้นทุนแรงงานสูง + Automation ต่ำ = แข่งขันไม่ได้</text>
  <text x="540" y="332" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ใช่แค่เศรษฐกิจโลกชะลอ — เป็นปัญหาเชิงโครงสร้าง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Structural shift ไม่รอ — รอแก้ไขเมื่อมีเวลา คือยอมรับความพ่ายแพ้ล่วงหน้า</div>

<!-- Speaker note: ต่างจาก recession ที่เศรษฐกิจฟื้นแล้วกลับมาได้ — structural shift คือเปลี่ยนแล้วเปลี่ยนเลย ต้องปรับตัวให้ทัน -->

---

## Automation ≠ ลดต้นทุน — คือเพิ่ม Capability ที่คนทำไม่ได้

<p class="subhead">การลงทุนผิดจุดเพราะเข้าใจผิดว่า Automation แค่แทนแรงงาน</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: แบบเดิม vs Industry 4.0 -->
  <rect x="40" y="30" width="480" height="320" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="30" width="480" height="56" rx="12" fill="var(--soft)"/>
  <text x="280" y="63" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">แบบเดิม</text>
  <text x="80" y="120" font-size="14" fill="var(--muted)" font-family="system-ui">• ตรวจคุณภาพด้วยสายตา</text>
  <text x="80" y="155" font-size="14" fill="var(--muted)" font-family="system-ui">• วางแผนผลิตด้วย Spreadsheet</text>
  <text x="80" y="190" font-size="14" fill="var(--muted)" font-family="system-ui">• แก้เครื่องเมื่อเสียแล้ว</text>
  <text x="80" y="225" font-size="14" fill="var(--muted)" font-family="system-ui">• Batch ใหญ่ถึงจะคุ้มต้นทุน</text>
  <text x="280" y="295" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แข่งขันด้วยค่าแรงต่ำ</text>
  <text x="280" y="318" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">→ สูญเสีย edge นี้แล้ว</text>

  <rect x="580" y="30" width="480" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="580" y="30" width="480" height="56" rx="12" fill="var(--accent)" opacity="0.1"/>
  <text x="820" y="63" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Industry 4.0</text>
  <text x="620" y="120" font-size="14" fill="var(--ink)" font-family="system-ui">• AI Vision ตรวจ defect 24/7</text>
  <text x="620" y="155" font-size="14" fill="var(--ink)" font-family="system-ui">• Predictive scheduling จาก sensor</text>
  <text x="620" y="190" font-size="14" fill="var(--ink)" font-family="system-ui">• Predictive Maintenance ก่อนเสีย</text>
  <text x="620" y="225" font-size="14" fill="var(--ink)" font-family="system-ui">• Flexible mfg รับ batch เล็กได้</text>
  <text x="820" y="295" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">แข่งขันด้วย capability</text>
  <text x="820" y="318" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">→ ทำสิ่งที่คู่แข่งทำไม่ได้</text>

  <circle cx="548" cy="192" r="28" fill="var(--accent)"/>
  <text x="548" y="192" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> โรงงานที่แข่งขันได้ไม่ใช่โรงงานที่ถูกกว่า — แต่คือโรงงานที่ทำสิ่งที่คู่แข่งทำไม่ได้</div>

<!-- Speaker note: Reframe the investment question: ไม่ใช่ "จะประหยัดเงินได้เท่าไหร่" แต่ "จะทำอะไรได้บ้างที่ตอนนี้ทำไม่ได้" -->

---

## ก่อนลงทุน — รู้ว่าตัวเองอยู่ตรงไหนก่อน

<p class="subhead">Thailand i4.0 Index โดย NSTDA: ประเมินจุดเริ่มต้นก่อนซื้อ solution</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- hierarchy: NSTDA → 2 tools -->
  <rect x="380" y="30" width="340" height="70" rx="10" fill="var(--accent)" opacity="0.15" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="60" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Thailand i4.0 Platform</text>
  <text x="550" y="83" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">พัฒนาโดย สวทช. (NSTDA)</text>

  <line x1="340" y1="100" x2="200" y2="170" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="760" y1="100" x2="900" y2="170" stroke="var(--muted)" stroke-width="1.5"/>

  <!-- Tool 1: i4.0 Index -->
  <rect x="60" y="170" width="320" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="60" y="170" width="320" height="44" rx="10" fill="var(--accent)" opacity="0.12"/>
  <text x="220" y="196" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Thailand i4.0 Index</text>
  <text x="220" y="216" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">thindex.or.th</text>
  <text x="90" y="250" font-size="13" fill="var(--ink)" font-family="system-ui">• ประเมินเชิงลึก + ที่ปรึกษา</text>
  <text x="90" y="274" font-size="13" fill="var(--ink)" font-family="system-ui">• เปรียบเทียบระดับชาติ / นานาชาติ</text>
  <text x="90" y="298" font-size="13" fill="var(--muted)" font-family="system-ui">→ สำหรับโรงงานพร้อม upgrade</text>

  <!-- Tool 2: i4.0 Checkup -->
  <rect x="720" y="170" width="320" height="160" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="720" y="170" width="320" height="44" rx="10" fill="var(--soft)"/>
  <text x="880" y="196" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Thailand i4.0 Checkup</text>
  <text x="880" y="216" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">nstda.or.th/i4platform</text>
  <text x="750" y="250" font-size="13" fill="var(--ink)" font-family="system-ui">• Self-assessment ออนไลน์ ฟรี</text>
  <text x="750" y="274" font-size="13" fill="var(--ink)" font-family="system-ui">• ไม่ต้องมีที่ปรึกษา</text>
  <text x="750" y="298" font-size="13" fill="var(--muted)" font-family="system-ui">→ จุดเริ่มต้นที่ดีที่สุดสำหรับ SME</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มที่ i4.0 Checkup (ฟรี, 20 นาที) — รู้ว่าลงทุนเรื่องอะไรก่อน แทนที่จะซื้อตามคู่แข่ง</div>

<!-- Speaker note: ปี 2024 มีเป้า 500 โรงงาน — ยังมีที่ว่างอีกมาก เครื่องมือมีให้ใช้แล้ว -->

---

## BOI 2026–2027: หน้าต่างสิทธิประโยชน์ที่เปิดอยู่

<p class="subhead">คณะกรรมการส่งเสริมการลงทุน (BOI) เปิดรับถึงสิ้นปี 2027</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 incentive boxes -->
  <rect x="40" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="40" y="40" width="320" height="54" rx="10" fill="var(--accent)" opacity="0.12"/>
  <circle cx="100" cy="66" r="22" fill="var(--accent)"/>
  <text x="100" y="66" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="175" y="62" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">SME Efficiency</text>
  <text x="175" y="80" font-size="12" fill="var(--muted)" font-family="system-ui">ลงทุนเพิ่มประสิทธิภาพ</text>
  <text x="70" y="140" font-size="28" font-weight="800" fill="var(--accent)" font-family="system-ui">100%</text>
  <text x="70" y="168" font-size="13" fill="var(--ink)" font-family="system-ui">CIT ยกเว้น 5 ปี</text>
  <text x="70" y="190" font-size="13" fill="var(--muted)" font-family="system-ui">(เดิม 50%/3 ปี)</text>

  <rect x="390" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="390" y="40" width="320" height="54" rx="10" fill="var(--accent)" opacity="0.12"/>
  <circle cx="450" cy="66" r="22" fill="var(--accent)"/>
  <text x="450" y="66" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="520" y="62" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">Group A1</text>
  <text x="520" y="80" font-size="12" fill="var(--muted)" font-family="system-ui">Automation &amp; Robotics</text>
  <text x="420" y="135" font-size="13" fill="var(--ink)" font-family="system-ui">พัฒนา Automation/</text>
  <text x="420" y="158" font-size="13" fill="var(--ink)" font-family="system-ui">หุ่นยนต์สำหรับการผลิต</text>
  <text x="420" y="195" font-size="13" fill="var(--muted)" font-family="system-ui">→ สิทธิประโยชน์สูงสุด</text>

  <rect x="740" y="40" width="320" height="260" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="740" y="40" width="320" height="54" rx="10" fill="var(--accent)" opacity="0.12"/>
  <circle cx="800" cy="66" r="22" fill="var(--accent)"/>
  <text x="800" y="66" font-size="16" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="870" y="62" font-size="14" font-weight="700" fill="var(--accent)" font-family="system-ui">EEC Automation Park</text>
  <text x="870" y="80" font-size="12" fill="var(--muted)" font-family="system-ui">Knowledge hub</text>
  <text x="770" y="135" font-size="13" fill="var(--ink)" font-family="system-ui">ศูนย์กลาง Robotics</text>
  <text x="770" y="158" font-size="13" fill="var(--ink)" font-family="system-ui">&amp; Industry 4.0 ครบวงจร</text>
  <text x="770" y="195" font-size="13" fill="var(--muted)" font-family="system-ui">→ Training + implementation</text>

  <!-- FDI stat -->
  <rect x="200" y="320" width="700" height="34" rx="8" fill="var(--soft)"/>
  <text x="550" y="341" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FDI ม.ค.–พ.ย. 2025: <tspan font-weight="700">311,160 ล้านบาท (+45% YoY)</tspan> — นักลงทุนเชื่อในไทยที่ปรับตัวแล้ว</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> หน้าต่าง BOI เปิดถึงสิ้นปี 2027 — ผู้ประกอบการที่เริ่มยื่นขอตอนนี้ได้เปรียบชัดเจน</div>

<!-- Speaker note: ไม่ใช่สิทธิ์ที่จะได้ตลอดไป — ยื่นขอตามกรอบเวลา และต้องมี investment plan ที่ชัดเจน -->

---

## Upskill/Reskill: เปลี่ยนบทบาทก่อนงานหายไปเอง

<p class="subhead">ลงทุน Automation โดยไม่มีคนที่พร้อมใช้งาน = เผาเงิน</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 3 paths -->
  <!-- box 1 -->
  <rect x="40" y="80" width="240" height="180" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="80" width="240" height="44" rx="10" fill="var(--soft)"/>
  <text x="160" y="108" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">แรงงาน Line</text>
  <text x="160" y="157" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">งานซ้ำ ๆ</text>
  <text x="160" y="177" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เสี่ยงถูกแทนที่</text>

  <!-- arrow 1 -->
  <line x1="280" y1="170" x2="360" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
  <text x="320" y="158" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Reskill</text>

  <!-- box 2 -->
  <rect x="360" y="80" width="240" height="180" rx="12" fill="var(--accent)" opacity="0.1" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="360" y="80" width="240" height="44" rx="10" fill="var(--accent)" opacity="0.2"/>
  <text x="480" y="108" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Cobot Operator</text>
  <text x="480" y="157" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ดูแล/program หุ่นยนต์</text>
  <text x="480" y="177" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">คน + เครื่องทำงานด้วยกัน</text>

  <!-- box 3 start: Maintenance -->
  <rect x="40" y="290" width="240" height="44" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="160" y="317" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ทีม Maintenance</text>

  <!-- arrow 3 up to upskill box -->
  <line x1="160" y1="290" x2="160" y2="265" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4"/>

  <!-- Upskill box below main flow -->
  <rect x="680" y="80" width="240" height="180" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="680" y="80" width="240" height="44" rx="10" fill="var(--soft)"/>
  <text x="800" y="108" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Upskill Path</text>
  <text x="700" y="157" font-size="13" fill="var(--ink)" font-family="system-ui">Maintenance → IoT Sensor</text>
  <text x="700" y="177" font-size="13" fill="var(--ink)" font-family="system-ui">Predictive Maintenance</text>

  <!-- New hire box -->
  <rect x="920" y="80" width="160" height="180" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="920" y="80" width="160" height="44" rx="10" fill="var(--soft)"/>
  <text x="1000" y="108" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">New Hire</text>
  <text x="1000" y="155" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Data Analyst</text>
  <text x="1000" y="175" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Process Engineer</text>
  <text x="1000" y="215" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">อ่าน production</text>
  <text x="1000" y="232" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">data ได้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Industry 4.0 ไม่ใช่การไล่คนออก — คือการเปลี่ยนบทบาทก่อนที่งานนั้นจะหายไปเอง</div>

<!-- Speaker note: ชี้ให้เห็นว่า Reskill + Upskill ทำคู่กันได้ทันที ไม่ต้องรอ tech พร้อมก่อน -->

---

## ข้อควรระวัง: ลงทุนผิดจุดอันตรายกว่าไม่ลงทุน

<p class="subhead">Industry 4.0 ไม่ใช่ one-size-fits-all — บริบทโรงงานต่างกัน เส้นทางต่างกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4 warning callout boxes -->
  <rect x="40" y="30" width="480" height="110" rx="12" fill="#fffbeb" stroke="var(--warn)" stroke-width="1.5"/>
  <rect x="40" y="30" width="6" height="110" rx="3" fill="var(--warn)"/>
  <text x="70" y="60" font-size="14" font-weight="700" fill="var(--warn)" font-family="system-ui">No one-size-fits-all</text>
  <text x="70" y="85" font-size="13" fill="var(--ink)" font-family="system-ui">โรงงานอาหาร ≠ โรงงาน PCB</text>
  <text x="70" y="108" font-size="13" fill="var(--muted)" font-family="system-ui">ประเมินบริบทก่อนเลือก solution</text>

  <rect x="580" y="30" width="480" height="110" rx="12" fill="#fffbeb" stroke="var(--warn)" stroke-width="1.5"/>
  <rect x="580" y="30" width="6" height="110" rx="3" fill="var(--warn)"/>
  <text x="610" y="60" font-size="14" font-weight="700" fill="var(--warn)" font-family="system-ui">ROI ใช้เวลา 3–5 ปี</text>
  <text x="610" y="85" font-size="13" fill="var(--ink)" font-family="system-ui">cash flow ตึง → พิจารณา BOI + leasing</text>
  <text x="610" y="108" font-size="13" fill="var(--muted)" font-family="system-ui">อย่าซื้อ tech เพราะเห็นคู่แข่งซื้อ</text>

  <rect x="40" y="180" width="480" height="110" rx="12" fill="#fffbeb" stroke="var(--warn)" stroke-width="1.5"/>
  <rect x="40" y="180" width="6" height="110" rx="3" fill="var(--warn)"/>
  <text x="70" y="210" font-size="14" font-weight="700" fill="var(--warn)" font-family="system-ui">Data quality ก่อน</text>
  <text x="70" y="235" font-size="13" fill="var(--ink)" font-family="system-ui">ยังทำ manual record อยู่ → แก้ infra ก่อน</text>
  <text x="70" y="258" font-size="13" fill="var(--muted)" font-family="system-ui">AI ไม่มีประโยชน์ถ้า data ไม่สะอาด</text>

  <rect x="580" y="180" width="480" height="110" rx="12" fill="#fffbeb" stroke="var(--warn)" stroke-width="1.5"/>
  <rect x="580" y="180" width="6" height="110" rx="3" fill="var(--warn)"/>
  <text x="610" y="210" font-size="14" font-weight="700" fill="var(--warn)" font-family="system-ui">ตัวเลข DIW undercount</text>
  <text x="610" y="235" font-size="13" fill="var(--ink)" font-family="system-ui">นับเฉพาะโรงงานที่จดทะเบียนและแจ้งปิด</text>
  <text x="610" y="258" font-size="13" fill="var(--muted)" font-family="system-ui">ตัวเลขจริงในตลาดอาจสูงกว่า</text>
</svg>
</div>

<div class="warn-takeaway"><b>⚠ Caveat:</b> ประเมินตัวเองก่อน (i4.0 Checkup) → เลือก solution ตามบริบท → ยื่น BOI → Upskill คู่กัน</div>

<!-- Speaker note: ลงทุนผิดจุดทำให้เงินหมดก่อนเห็นผล — ลำดับขั้นตอนสำคัญมาก -->

---

## Key Takeaways: สิ่งที่ต้องทำตอนนี้

<p class="subhead">ผู้ประกอบการที่ไม่เริ่มในปี 2026 อาจไม่ทันคู่แข่งที่ปรับตัวไปแล้ว</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- concentric rings: core = ประเมินตัวเอง, middle = ลงทุน+upskill, outer = BOI+ecosystem -->
  <circle cx="300" cy="185" r="160" fill="none" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <circle cx="300" cy="185" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity="0.5"/>
  <circle cx="300" cy="185" r="60" fill="var(--accent)" opacity="0.12"/>
  <circle cx="300" cy="185" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="300" y="179" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ประเมิน</text>
  <text x="300" y="197" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ตัวเอง</text>
  <text x="160" y="105" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">i4.0 Checkup</text>
  <text x="450" y="105" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Upskill คู่กัน</text>
  <text x="100" y="195" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BOI</text>
  <text x="100" y="212" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Incentives</text>
  <text x="500" y="195" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EEC</text>
  <text x="500" y="212" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Ecosystem</text>

  <!-- takeaway list on right -->
  <rect x="600" y="30" width="460" height="310" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1"/>
  <text x="830" y="65" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สรุป 6 ข้อ</text>
  <line x1="620" y1="76" x2="1040" y2="76" stroke="var(--muted)" stroke-width="1" opacity="0.5"/>
  <text x="625" y="108" font-size="13" fill="var(--ink)" font-family="system-ui">1. 100+โรงงาน/เดือน — structural shift ไม่ใช่ recession</text>
  <text x="625" y="140" font-size="13" fill="var(--ink)" font-family="system-ui">2. Automation = เพิ่ม capability ไม่ใช่แค่ลดคน</text>
  <text x="625" y="172" font-size="13" fill="var(--ink)" font-family="system-ui">3. เริ่มที่ i4.0 Checkup ฟรี ก่อนซื้อ solution</text>
  <text x="625" y="204" font-size="13" fill="var(--ink)" font-family="system-ui">4. BOI 2026–2027: CIT 100% 5 ปีสำหรับ SME</text>
  <text x="625" y="236" font-size="13" fill="var(--ink)" font-family="system-ui">5. Reskill + Upskill คู่กับ technology เสมอ</text>
  <text x="625" y="268" font-size="13" fill="var(--danger)" font-family="system-ui">6. ไม่เริ่มตอนนี้ = ยอมแพ้ให้คู่แข่งล่วงหน้า</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ประเมิน → วาง Road Map → ยื่น BOI → Upskill — ทำตอนนี้ก่อนที่หน้าต่างจะปิด</div>

<!-- Speaker note: จบด้วย call to action — ขั้นแรกเดียวที่ต้องทำวันนี้คือเปิด i4.0 Checkup -->
