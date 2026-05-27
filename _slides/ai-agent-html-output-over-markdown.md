---
marp: true
theme: default
paginate: true
title: "หยุดให้ AI Agent เขียน Markdown: ทำไม HTML ถึงเป็น Output Format ที่ดีกว่า"
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# หยุดให้ AI Agent เขียน Markdown

<p class="tag">ทำไม HTML ถึงเป็น Output Format ที่ดีกว่า — และทำให้มนุษย์ Stay In the Loop</p>

<!-- Speaker: เริ่มด้วย pain point: ใครเคยไม่อ่าน Markdown plan ของ Claude เกิน 100 บรรทัดบ้าง? -->

---

## Markdown ยังดีอยู่ ถ้า Output ยังสั้น

<p class="subhead">3 ข้อดีที่ทำให้ Markdown เป็น default format ของ AI agents มาตลอด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Portable</p>
    <h3>Simple & Universal</h3>
    <p>ไฟล์ .md เปิดได้ทุกที่ ไม่ต้องติดตั้ง เปิดใน Notepad ก็อ่านได้</p>
  </div>
  <div class="card success">
    <p class="label">Editable</p>
    <h3>Human-Editable</h3>
    <p>Developer แก้ไขได้โดยตรง ไม่ต้องผ่าน tool พิเศษ — ข้อดีหลักของ Markdown</p>
  </div>
  <div class="card success">
    <p class="label">Lightweight</p>
    <h3>Low Token Cost</h3>
    <p>Token ต่ำ render เร็ว เหมาะกับ short outputs เช่น notes, snippets, quick answers</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Markdown เหมาะกับ AI output ยุคแรก — แต่พฤติกรรมการใช้งาน AI เปลี่ยนไปแล้ว</div>

<!-- Speaker: Context ก่อน — Markdown ไม่ใช่ผิด แค่ไม่ scale กับ agentic workflows -->

---

## Markdown พังที่ Scale: 3 ปัญหาจริง

<p class="subhead">เมื่อ AI agents ทรงพลังขึ้น output ยาวขึ้น — และ Markdown กลายเป็นอุปสรรค</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Text Wall</p>
    <h3>กำแพงข้อความ</h3>
    <p>ไฟล์เกิน 100 บรรทัด = death zone ในทางปฏิบัติ developer ไม่อ่าน — ยิ่งแชร์ทีมยิ่งเป็นไปไม่ได้</p>
  </div>
  <div class="card danger">
    <p class="label">Broken Diagrams</p>
    <h3>Diagram มักพัง</h3>
    <p>padding เลื่อน, border ไม่ตรง, สีถูก "estimate" ด้วย Unicode แทน render จริง — ดีใน editor หนึ่ง พังในอีก editor</p>
  </div>
  <div class="card danger">
    <p class="label">Share Friction</p>
    <h3>Share ยาก</h3>
    <p>Browser ส่วนใหญ่ไม่ render Markdown natively ต้องส่งเป็น attachment หรือใช้ GitHub เท่านั้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ใช่ user error — เป็นข้อจำกัดของ format ที่ไม่ได้ออกแบบมาสำหรับ 200-line AI specs</div>

<!-- Speaker: Thor (T3 Code) สังเกตว่าตัวเองหยุดอ่าน Markdown plans และเริ่ม prompt Claude ให้แก้แทน — ทำให้ข้อดีหลักของ Markdown หายไป -->

---

## HTML Represents ข้อมูลได้ทุกรูปแบบ

<p class="subhead">HTML ไม่ใช่แค่ "text ที่สวยกว่า" — มันเป็น superset ของสิ่งที่ Markdown ทำได้</p>

<div class="infographic">

| ประเภทข้อมูล | Markdown | HTML |
|---|:---:|:---:|
| Document structure | ✅ | ✅ + visual hierarchy |
| Tabular data | ⚠️ basic | ✅ full CSS table |
| Diagrams | ❌ มักพัง | ✅ SVG native |
| Interactivity | ❌ | ✅ JavaScript + sliders |
| Side-by-side layout | ❌ | ✅ CSS Grid/Flex |
| Mobile responsive | ❌ | ✅ Media queries |
| Spatial / canvas | ❌ | ✅ absolute positions |

</div>

<div class="takeaway"><b>★ Takeaway:</b> Thor: "ไม่มีชุดข้อมูลใดที่ Claude อ่านได้ แต่ไม่สามารถ represent ด้วย HTML ได้อย่างมีประสิทธิภาพ"</div>

<!-- Speaker: ตรงนี้คือ core argument — HTML เป็น universal output channel ที่ brain-native กว่า sequential text -->

---

## 4 Use Cases ที่ HTML เหนือกว่าชัดเจน

<p class="subhead">Pattern จริงจากการใช้งาน Claude Code ในทีม — ไม่ใช่ทฤษฎี</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Design Exploration</p>
    <h3>4 Mockups ใน 1 ไฟล์</h3>
    <p>ขอ 4 UI variants พร้อมกัน วางบน 4 routes ใน HTML เดียว เปิด browser เลือกได้ทันที — ไม่ต้องจินตนาการจาก text</p>
  </div>
  <div class="card">
    <p class="label">Technical Comparison</p>
    <h3>Options + Pros/Cons Table</h3>
    <p>เช่น 3 วิธี debounced search แต่ละแบบมี code snippet + pros/cons table + recommendation — เห็น structure ทันที</p>
  </div>
  <div class="card gold">
    <p class="label">Interactive Throwaway UI</p>
    <h3>Single-Use Tools</h3>
    <p>API cost calculator: sliders ปรับ parameters, "copy as JSON", "export CSV" — tweak แล้วส่งกลับ AI ได้ทันที</p>
  </div>
  <div class="card">
    <p class="label">Shareable Spec</p>
    <h3>Spec ที่คนอ่านจริง</h3>
    <p>tabs, links, illustrations, mobile-responsive — โอกาสถูกอ่านจริงโดยทีมสูงกว่า Markdown wall of text อย่างมีนัยสำคัญ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTML output ไม่ใช่แค่สวย — มันเปลี่ยนว่า developer "เลือก" อ่านหรือไม่</div>

<!-- Speaker: Devon Review (PR analyzer) และ Copilot Kit ก็ใช้ pattern นี้ — มันกำลังกลายเป็น standard -->

---

## "Stay In the Loop": เหตุผลที่แท้จริง

<p class="subhead">HTML output ไม่ได้แค่สวย — มันปิด feedback loop ระหว่างมนุษย์กับ AI</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Markdown path: broken loop -->
  <rect x="30" y="40" width="160" height="60" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="110" y="65" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI generates</text>
  <text x="110" y="83" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">plan / spec</text>
  <polygon points="195,70 210,70 210,66 225,70 210,74 210,70" fill="var(--muted)"/>
  <rect x="230" y="40" width="160" height="60" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="310" y="62" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Markdown</text>
  <text x="310" y="79" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">wall of text</text>
  <polygon points="395,70 410,70 410,66 425,70 410,74 410,70" fill="var(--muted)"/>
  <rect x="430" y="40" width="160" height="60" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="510" y="62" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Human skips</text>
  <text x="510" y="79" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">reading</text>
  <polygon points="595,70 610,70 610,66 625,70 610,74 610,70" fill="var(--muted)"/>
  <rect x="630" y="40" width="160" height="60" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="710" y="62" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">AI decides</text>
  <text x="710" y="79" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">alone</text>
  <text x="850" y="74" font-size="22" fill="var(--danger)" text-anchor="middle" font-family="system-ui">✗</text>
  <text x="530" y="130" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui" font-weight="600">— Markdown path: Human out of loop —</text>
  <!-- HTML path: closed loop -->
  <rect x="30" y="190" width="160" height="60" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="110" y="215" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI generates</text>
  <text x="110" y="233" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">plan / spec</text>
  <polygon points="195,220 210,220 210,216 225,220 210,224 210,220" fill="var(--accent)"/>
  <rect x="230" y="190" width="160" height="60" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="310" y="212" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Rich HTML</text>
  <text x="310" y="229" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">tabs + diagrams</text>
  <polygon points="395,220 410,220 410,216 425,220 410,224 410,220" fill="var(--accent)"/>
  <rect x="430" y="190" width="160" height="60" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="510" y="212" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Human reads</text>
  <text x="510" y="229" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">and steers</text>
  <polygon points="595,220 610,220 610,216 625,220 610,224 610,220" fill="var(--success)"/>
  <rect x="630" y="190" width="160" height="60" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="710" y="212" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Better</text>
  <text x="710" y="229" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">outcomes</text>
  <path d="M790,220 Q940,220 940,160 Q940,110 800,110 Q110,110 110,170 Q110,185 110,190" stroke="var(--success)" stroke-width="1.5" fill="none" stroke-dasharray="5,3"/>
  <polygon points="106,186 110,196 114,186" fill="var(--success)"/>
  <text x="530" y="275" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui" font-weight="600">— HTML path: Human stays in loop —</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Thor: "ฉันรู้สึกว่าตัวเองยัง in the loop กับ Claude มากขึ้นกว่าเคย" — นี่คือเหตุผลหลัก ไม่ใช่ความสวยงาม</div>

<!-- Speaker: นี่คือ thesis หลักของ deck ทั้งใบ — ผลลัพธ์ที่ดีขึ้นมาจาก human-AI feedback loop ที่ปิดสมบูรณ์ -->

---

## Token Cost: แลกกันอย่างไร?

<p class="subhead">HTML เผา output tokens มากกว่า Markdown — แต่มีเหตุผลที่คุ้มค่า</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Cost -->
  <rect x="40" y="30" width="460" height="280" rx="14" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <rect x="40" y="30" width="460" height="56" rx="14" fill="var(--warning)" opacity=".15"/>
  <text x="270" y="65" font-size="17" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Cost</text>
  <text x="70" y="120" font-size="14" fill="var(--warning-ink)" font-family="system-ui">• HTML file 2-5x larger than Markdown</text>
  <text x="70" y="150" font-size="14" fill="var(--warning-ink)" font-family="system-ui">• More output tokens per response</text>
  <text x="70" y="180" font-size="14" fill="var(--warning-ink)" font-family="system-ui">• Bloated for simple outputs</text>
  <text x="70" y="210" font-size="14" fill="var(--warning-ink)" font-family="system-ui">• Not suitable for all pipelines</text>
  <!-- Right: Benefit -->
  <rect x="600" y="30" width="460" height="280" rx="14" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="600" y="30" width="460" height="56" rx="14" fill="var(--success)" opacity=".15"/>
  <text x="830" y="65" font-size="17" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Why It's Worth It</text>
  <text x="630" y="120" font-size="14" fill="var(--success-ink)" font-family="system-ui">• 1M+ token context: cost diff barely noticed</text>
  <text x="630" y="150" font-size="14" fill="var(--success-ink)" font-family="system-ui">• Unread output = zero value</text>
  <text x="630" y="180" font-size="14" fill="var(--success-ink)" font-family="system-ui">• HTML is denser per concept conveyed</text>
  <text x="630" y="210" font-size="14" fill="var(--success-ink)" font-family="system-ui">• Better steering = fewer wasted turns</text>
  <!-- VS badge -->
  <circle cx="550" cy="170" r="32" fill="var(--accent)"/>
  <text x="550" y="175" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ HTML เมื่อ: plan ยาว / ต้องการ comparison / ต้องการ interactivity / จะ share — ไม่ต้องใช้ทุก output</div>

<!-- Speaker: Context window ใหญ่ขึ้น ทำให้ tradeoff เอียงมาฝั่ง benefit มากขึ้นเรื่อยๆ -->

---

## วิธีเริ่มใช้: 5 Steps

<p class="subhead">ไม่ต้องติดตั้งอะไร — เริ่มจาก prompt เดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step boxes -->
  <rect x="20" y="80" width="180" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="110" cy="108" r="18" fill="var(--accent)"/>
  <text x="110" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="110" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Ask for HTML</text>
  <text x="110" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"structure as HTML"</text>
  <text x="110" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">at end of prompt</text>
  <polygon points="205,160 220,160 220,156 235,160 220,164 220,160" fill="var(--accent)"/>
  <rect x="240" y="80" width="180" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="330" cy="108" r="18" fill="var(--accent)" opacity=".7"/>
  <text x="330" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="330" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Open in Browser</text>
  <text x="330" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">open /tmp/out.html</text>
  <text x="330" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">or xdg-open</text>
  <polygon points="425,160 440,160 440,156 455,160 440,164 440,160" fill="var(--accent)"/>
  <rect x="460" y="80" width="180" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="108" r="18" fill="var(--accent)" opacity=".7"/>
  <text x="550" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="550" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Multiple Options</text>
  <text x="550" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Ask for 3-4 variants</text>
  <text x="550" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">in one HTML file</text>
  <polygon points="645,160 660,160 660,156 675,160 660,164 660,160" fill="var(--accent)"/>
  <rect x="680" y="80" width="180" height="160" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="770" cy="108" r="18" fill="var(--accent)" opacity=".7"/>
  <text x="770" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="770" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Add Interactivity</text>
  <text x="770" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Sliders + export</text>
  <text x="770" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">buttons for tweaking</text>
  <polygon points="865,160 880,160 880,156 895,160 880,164 880,160" fill="var(--gold)"/>
  <rect x="900" y="80" width="180" height="160" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2"/>
  <circle cx="990" cy="108" r="18" fill="var(--gold)"/>
  <text x="990" y="113" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">5</text>
  <text x="990" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pick the Right</text>
  <text x="990" y="166" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Format</text>
  <text x="990" y="186" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Short = Markdown</text>
  <text x="990" y="204" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Long/shared = HTML</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Karpathy: "at the end of your query ask your LM to structure the response as HTML then view in browser" — เริ่มง่ายแค่นี้</div>

<!-- Speaker: Step 5 คือที่ที่คนมักข้ามไป — ไม่ต้องใช้ HTML กับทุก output แค่รู้จังหวะที่ใช่ -->

---

## Caveats: รู้ข้อจำกัดก่อนใช้

<p class="subhead">HTML output ไม่ใช่ silver bullet — มีกรณีที่ Markdown ยังดีกว่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Token Cost</p>
    <h3>ไฟล์ใหญ่กว่า 2-5x</h3>
    <p>HTML ที่มี CSS layout ซับซ้อน = output tokens สูงกว่ามาก พิจารณา cost ก่อนใช้กับงาน routine หรือ batch</p>
  </div>
  <div class="card warning">
    <p class="label">Pipeline Compatibility</p>
    <h3>ไม่เหมาะกับ Machine Parsing</h3>
    <p>ถ้า output ต้องผ่าน script หรือ LLM ต่อ HTML ซับซ้อนเกิน Markdown หรือ plain text เหมาะกว่า</p>
  </div>
  <div class="card danger">
    <p class="label">Security</p>
    <h3>JavaScript = Risk</h3>
    <p>HTML ที่มี JS ควรเปิดใน isolated environment หรือ iframe sandbox ถ้ามาจาก untrusted source</p>
  </div>
  <div class="card">
    <p class="label">Complexity</p>
    <h3>React/MDX ยังซับซ้อน</h3>
    <p>Copilot Kit และ MDX อาจ overkill สำหรับทีมที่ไม่มี frontend setup — static HTML เพียงพอสำหรับส่วนใหญ่</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Format เป็นเครื่องมือ — เลือกตาม job-to-be-done ไม่ใช่ทำทุก output เป็น HTML</div>

<!-- Speaker: ความเข้าใจผิดที่พบบ่อย: "ใช้ HTML ทุกอย่าง" — ผิด ใช้เมื่อ output ต้องการ human review จริงๆ -->

---

## Future: React + MDX คือ Evolution ต่อไป

<p class="subhead">HTML เป็นจุดเริ่มต้น — อนาคตคือ agent-generated interactive components</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Now — Static HTML</p>
    <h3>HTML + CSS + JS</h3>
    <p>Throwaway files เปิดใน browser ไม่ต้องติดตั้ง เหมาะกับทุกทีม เริ่มได้ทันที</p>
  </div>
  <div class="card gold">
    <p class="label">Next — React Components</p>
    <h3>MDX + Dynamic UI</h3>
    <p>Agent generates React components ที่ render ผ่าน MDX ได้ reusable มากขึ้น integrate กับ codebase ได้</p>
  </div>
  <div class="card success">
    <p class="label">Future — Copilot Kit</p>
    <h3>Agentic UI Framework</h3>
    <p>Enterprise stack: custom React components, hooks สำหรับ interactive AI, frontend-backend AI interaction ใน production</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Karpathy: "audio is the human preferred input to AIs, but vision — images and HTML — is the preferred output"</div>

<!-- Speaker: ไม่ต้องรอ React/MDX ecosystem — เริ่มด้วย static HTML วันนี้ แล้ว migrate ขึ้นเมื่อพร้อม -->

---

## Key Takeaways

<p class="subhead">7 สิ่งที่ควรจำจาก deck นี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="font-size:13px;">
  <div class="card compact danger">
    <p class="label">Problem</p>
    <h3>Markdown พังที่ Scale</h3>
    <p>100+ บรรทัด = ไม่มีใครอ่าน Diagram พัง Share ยาก — ข้อจำกัดจริง ไม่ใช่ user error</p>
  </div>
  <div class="card compact success">
    <p class="label">Solution</p>
    <h3>HTML = Universal Channel</h3>
    <p>tables, SVG, interactivity, responsive — ใน format ที่ browser เปิดได้ทันทีโดยไม่ต้องติดตั้ง</p>
  </div>
  <div class="card compact gold">
    <p class="label">Core Reason</p>
    <h3>"Stay In the Loop"</h3>
    <p>Output ที่อ่านได้ = developer steering AI แม่นขึ้น — feedback loop ที่สำคัญที่สุด</p>
  </div>
  <div class="card compact warning">
    <p class="label">Tradeoff</p>
    <h3>Token Cost คุ้มค่า</h3>
    <p>1M token context ทำให้ต่างน้อยลง — unread output ไม่มีคุณค่า token ถูกแค่ไหนก็ตาม</p>
  </div>
  <div class="card compact">
    <p class="label">When to Use</p>
    <h3>เลือกให้เหมาะงาน</h3>
    <p>Plan ยาว / comparisons / interactive tools / shared specs = HTML. Short notes = Markdown</p>
  </div>
  <div class="card compact">
    <p class="label">How to Start</p>
    <h3>เริ่มง่ายมาก</h3>
    <p>"structure as HTML" ท้าย prompt แล้ว open ใน browser — ไม่ต้องติดตั้งอะไรเลย</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> หยุดให้ AI เขียน Markdown สำหรับงานที่ต้องการ human review — ลอง HTML ครั้งเดียว แล้วจะไม่อยากกลับ</div>

<!-- Speaker: ถามผู้ฟัง: ใครจะลองใช้ "structure as HTML" กับ Claude วันนี้บ้าง? -->
