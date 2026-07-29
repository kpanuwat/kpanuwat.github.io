---
marp: true
theme: default
paginate: true
title: "OKMD AI Playground"
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
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/okmd-ai-playground-thai-id-cover.png)

<div class="mark"></div>

# OKMD AI Playground

<p class="tag">คนไทยใช้ Gemini, Claude, DeepSeek, Grok ฟรี ผ่านการยืนยันตัวตน ThaiD</p>

<!-- Speaker: ภาครัฐไทยเปิดแพลตฟอร์มรวม AI ชั้นนำหลายค่ายให้คนไทยใช้ฟรี — วันนี้เราจะเจาะทั้งฟีเจอร์จริงจากคลิปสาธิต และงบประมาณที่กำลังเป็นประเด็นในสภา -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/okmd-ai-playground-thai-id-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้งเดคในหน้าเดียว — โมเดล AI, ฟีเจอร์ที่ทดสอบจริง, โควตา, ขั้นตอนใช้งาน, ข้อควรระวัง, และตัวเลขงบประมาณเทียบโครงการอื่น -->

---

## TL;DR: แพลตฟอร์มรัฐ ใช้ AI หลายค่ายฟรีจริง

<p class="subhead">รวม Gemini, GPT, Claude, DeepSeek, Grok ไว้หน้าเดียว ยืนยันตัวตนผ่าน ThaiD</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="190" r="40" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="190" r="28" fill="var(--accent)"/>
  <text x="148" y="196" font-size="18" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">$0</text>
  <text x="220" y="150" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">playground.okmd.or.th — free for all Thai citizens</text>
  <text x="220" y="185" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Login: ThaiD app OR existing TK Park / OKMD e-member account</text>
  <text x="220" y="215" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Models: Gemini, GPT, Claude Sonnet, DeepSeek, Grok, Meta AI, Perplexity</text>
  <text x="220" y="245" font-size="15" fill="var(--muted)" font-family="system-ui">Features: chat, web-app builder + deploy, TTS, image gen, API key</text>
  <text x="220" y="275" font-size="15" fill="var(--muted)" font-family="system-ui">Quota: ~350,000 tokens/day for Gemini (varies by model)</text>
</svg>
</div>

<div class="takeaway"><b>★ สรุป:</b> ไม่ใช่แค่ chat demo — สร้างเว็บแอป, TTS, สร้างภาพ, และ API key ใช้งานได้จริงตามที่สาธิตในคลิป</div>

<!-- Speaker: เน้นว่านี่ verify จากทั้งเว็บข่าวและวิดีโอสาธิตจริง ไม่ใช่แค่คำโฆษณา -->

---

## OKMD คือใคร — ทำไมเรื่องนี้ถึงสำคัญกว่าข่าวเปิดตัวทั่วไป

![bg right:40% contain](assets/okmd-ai-playground-thai-id-background.png)

<p class="subhead">หน่วยงานรัฐไทยด้าน lifelong learning เปิด 3 บริการพร้อมกัน 1 พ.ค. 2569</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="660" height="70" rx="10" fill="var(--accent)" opacity=".1"/>
  <text x="40" y="50" font-size="16" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">OKMD</text>
  <text x="40" y="75" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Office of Knowledge Management and Development (public org)</text>
  <rect x="20" y="110" width="200" height="180" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="120" y="145" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">AI Playground</text>
  <text x="120" y="170" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">this deck's focus</text>
  <rect x="250" y="110" width="200" height="180" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="350" y="145" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Knowledge Portal</text>
  <text x="350" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">digital library</text>
  <rect x="480" y="110" width="200" height="180" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="580" y="145" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Corporate</text>
  <text x="580" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">upskilling</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "3 ฟีเจอร์เด็ด" ในข่าว = 3 บริการคนละตัว ไม่ใช่ 3 ความสามารถใน Playground เดียว</div>

<!-- Speaker: OKMD ดูแล TK Park ด้วย — วันเปิดตัวมี 3 บริการพร้อมกัน แต่เดคนี้เจาะเฉพาะ AI Playground -->

---

## โมเดล AI มากกว่า 10 ตัว จากหลายค่ายทั่วโลก

<p class="subhead">รวมไว้หน้าเดียว พร้อมฟีเจอร์ Compare & Contrast — ยิงคำถามเดียว ดูคำตอบทุกโมเดลพร้อมกัน</p>

| ค่าย | โมเดลที่พบในระบบ |
|------|------------------|
| Google | Gemini (3.5 Flash ที่สาธิตในคลิป) |
| OpenAI | GPT |
| Anthropic | Claude (Sonnet 5) |
| DeepSeek / xAI | DeepSeek, Grok |
| อื่นๆ | Meta AI, Perplexity, Typhoon (ไทย) + เพิ่มเติมผ่าน model router |

<div class="takeaway"><b>★ Takeaway:</b> ยังไม่รู้จะปักหลักกับโมเดลไหน? ใช้ Compare & Contrast ทดสอบทุกค่ายพร้อมกันก่อนตัดสินใจ</div>

<!-- Speaker: เน้นว่านี่ verify จากทั้งข่าวและวิดีโอสาธิตจริง ไม่ใช่แค่รายชื่อโปรโมท -->

---

## 4 ฟีเจอร์ที่ทดสอบจริงในคลิปสาธิต — ไม่ใช่แค่คำโฆษณา

<p class="subhead">ทุกฟีเจอร์ถูกสาธิตสดในวิดีโอต้นทาง ทำได้จริงบนบราวเซอร์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Build</p>
    <h3>Web App Builder + Deploy</h3>
    <p>สั่งเขียนโค้ดเว็บไซต์ (เช่น เว็บร้านกาแฟ) กด deploy มุมขวาบนรันทดสอบได้ทันที ดาวน์โหลด source code ไปใช้จริงได้</p>
  </div>
  <div class="card gold">
    <p class="label">Voice</p>
    <h3>Text-to-Speech</h3>
    <p>สั่งสร้างเว็บอ่านออกเสียงภาษาไทย มีปุ่มเล่นเสียง ปรับความเร็ว ดาวน์โหลดเป็น MP3</p>
  </div>
  <div class="card warning">
    <p class="label">Visual</p>
    <h3>Image Generation</h3>
    <p>ทดสอบด้วย Gemini 3.5 Flash สร้างภาพปก YouTube ตามกฎ 3 ส่วน พร้อมใส่ข้อความในภาพ</p>
  </div>
  <div class="card">
    <p class="label">Developer</p>
    <h3>API Key</h3>
    <p>เชื่อมต่อเข้าแอปพลิเคชันของตัวเอง สาธิตยิง request ผ่าน curl ตรงในคลิป</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI ที่นี่ไม่ใช่แค่ chat — build, พูด, วาด, และเชื่อมต่อผ่าน API ได้ทั้งหมด</div>

<!-- Speaker: ย้ำว่าทุกอันสาธิตสดในคลิป ไม่ใช่ feature list จากเอกสารการตลาด -->

---

## โควตาให้เปล่า ~350,000 token/วัน (ต่อโมเดล)

<p class="subhead">นับรวม input + output token เช็คได้ real-time ที่หน้า Setting</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="230" cy="190" r="130" fill="none" stroke="var(--soft-2)" stroke-width="18"/>
  <circle cx="230" cy="190" r="130" fill="none" stroke="var(--accent)" stroke-width="18" stroke-dasharray="620 817" stroke-linecap="round" transform="rotate(-90 230 190)"/>
  <text x="230" y="180" font-size="34" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">350K</text>
  <text x="230" y="210" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">tokens / day (Gemini)</text>
  <text x="480" y="130" font-size="18" font-weight="700" fill="var(--ink)" font-family="system-ui">Usage tracked per model</text>
  <text x="480" y="165" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Input tokens + output tokens counted together</text>
  <text x="480" y="195" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Real-time usage view under Settings</text>
  <text x="480" y="225" font-size="14" fill="var(--muted)" font-family="system-ui">Other models' daily caps not officially confirmed</text>
  <text x="480" y="255" font-size="14" fill="var(--muted)" font-family="system-ui">— plan long build/API sessions accordingly</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วางแผนก่อนใช้งานยาวๆ — โควตาต่างกันตามโมเดล เช็ค Setting ก่อนชนลิมิตกลางงาน</div>

<!-- Speaker: ตัวเลข 350K มาจากคลิปสาธิตจริงเฉพาะ Gemini เท่านั้น โมเดลอื่นไม่มีตัวเลขยืนยันทางการ -->

---

## เริ่มใช้งานใน 4 ขั้นตอน

<p class="subhead">ตั้งแต่ล็อกอินไปจนถึงเชื่อม API เข้าแอปของตัวเอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="140" cy="150" r="44" fill="var(--accent)"/>
  <text x="140" y="158" font-size="26" font-weight="800" fill="var(--paper)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="140" y="220" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Login</text>
  <text x="140" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ThaiD or TK Park</text>
  <line x1="200" y1="150" x2="320" y2="150" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <circle cx="380" cy="150" r="44" fill="var(--accent)"/>
  <text x="380" y="158" font-size="26" font-weight="800" fill="var(--paper)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="380" y="220" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pick Model</text>
  <text x="380" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">or Compare & Contrast</text>
  <line x1="440" y1="150" x2="560" y2="150" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <circle cx="620" cy="150" r="44" fill="var(--accent)"/>
  <text x="620" y="158" font-size="26" font-weight="800" fill="var(--paper)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="620" y="220" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Build + Test</text>
  <text x="620" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">web app, TTS, image</text>
  <line x1="680" y1="150" x2="800" y2="150" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow)"/>
  <circle cx="860" cy="150" r="44" fill="var(--accent)"/>
  <text x="860" y="158" font-size="26" font-weight="800" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="860" y="220" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Use API Key</text>
  <text x="860" y="240" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">curl into your app</text>
  <defs>
    <marker id="arrow" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 Z" fill="var(--muted)"/></marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่มีบัตรเครดิต ไม่มี sign-up ซับซ้อน — มี ThaiD หรือบัตรประชาชนก็เริ่มได้ทันที</div>

<!-- Speaker: เดินตาม 4 ขั้นตอนหลัก เต็มๆ มี 7 ขั้นย่อยในโพสต์ (เช็ค quota, เช็ค setting ด้วย) -->

---

## 4 ข้อควรระวังก่อนใช้งานจริง

<p class="subhead">ของฟรีจากภาครัฐ แต่ก็มีข้อจำกัดที่ควรรู้ก่อน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Misconception</p>
    <h3>"3 ฟีเจอร์เด็ด" ≠ 3 ความสามารถ</h3>
    <p>คือ 3 บริการคนละตัว (Playground/Knowledge Portal/Corporate) ไม่ใช่ 3 ฟีเจอร์ใน Playground เดียว</p>
  </div>
  <div class="card warning">
    <p class="label">Quota</p>
    <h3>โควตาต่อวันจำกัดจริง</h3>
    <p>ใช้งานต่อเนื่องยาวๆ ในวันเดียว (build + API test) อาจชนโควตาก่อนจบงาน</p>
  </div>
  <div class="card danger">
    <p class="label">Privacy</p>
    <h3>ไม่มีเอกสาร data retention</h3>
    <p>ไม่มีรายละเอียด privacy policy ของ prompt ที่ส่งเข้าระบบในแหล่งข่าวที่ตรวจสอบได้</p>
  </div>
  <div class="card">
    <p class="label">Version</p>
    <h3>โมเดลอาจเปลี่ยนรุ่น</h3>
    <p>ชื่อรุ่นในคลิป (Gemini 3.5 Flash, Sonnet 5) เป็นสถานะ ณ วันทดสอบ 1 พ.ค. 2569 เท่านั้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> อย่าใช้ทดสอบข้อมูลอ่อนไหว — ระวังเหมือนใช้ third-party AI gateway ทั่วไป</div>

<!-- Speaker: เน้น privacy caveat เป็นพิเศษ เพราะไม่มีเอกสารทางการยืนยัน -->

---

## งบพัฒนา 2.4 ล้านบาท vs โครงการรัฐอื่น 1,621 ล้านบาท

<p class="subhead">ส.ส. ตั้งคำถามในสภาถึงความคุ้มค่า — TH-AI Passport มีผู้ใช้จริงแค่ ~100 คน/ชั่วโมง</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--success)" opacity=".1"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">OKMD AI Playground</text>
  <text x="285" y="180" font-size="42" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">2.4M</text>
  <text x="285" y="210" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">baht development budget</text>
  <text x="285" y="290" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ ~500K baht token cost</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--danger)" opacity=".08"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">TH-AI Passport</text>
  <text x="815" y="180" font-size="42" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">1,621M</text>
  <text x="815" y="210" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">baht total budget</text>
  <text x="815" y="290" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">~100 users/hour reported</text>
  <circle cx="550" cy="190" r="28" fill="var(--gold)"/>
  <text x="550" y="195" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยังไม่มีบทสรุปทางการจากหน่วยงานตรวจสอบ — เป็นประเด็นที่ควรติดตามต่อ ไม่ใช่ fact ปิดเรื่องแล้ว</div>

<!-- Speaker: นี่คือประเด็นวิจารณ์ในสภา ไม่ใช่ scandal ที่สรุปแล้ว — นำเสนออย่างสมดุล -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องรู้แม้ข้ามเนื้อหาส่วนอื่นไปเลย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Fact</p>
    <p>รวม Gemini, GPT, Claude Sonnet, DeepSeek, Grok, Meta AI, Perplexity ไว้ที่เดียว ใช้ฟรีจริง — ตรวจสอบได้จากทั้งข่าวและคลิปสาธิต</p>
  </div>
  <div class="card">
    <p class="label">Access</p>
    <p>ล็อกอินผ่าน ThaiD หรือบัญชี TK Park/OKMD e-member เดิม — ไม่ใช่แค่ chat แต่ build เว็บแอป, TTS, image gen, และ API ได้จริง</p>
  </div>
  <div class="card warning">
    <p class="label">Quota</p>
    <p>โควตาฟรีราว 350,000 token/วันสำหรับ Gemini (โมเดลอื่นไม่มีตัวเลขยืนยันทางการ)</p>
  </div>
  <div class="card gold">
    <p class="label">Budget</p>
    <p>งบพัฒนา 2.4 ล้านบาท เทียบโครงการ AI รัฐอื่นที่ใช้งบสูงกว่าหลักพันล้าน — ประเด็นวิจารณ์ที่ยังไม่มีบทสรุป</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> จุดเริ่มต้นฟรีที่ดีสำหรับคนไทยอยากลอง AI หลายค่าย — แต่ระวัง data privacy เหมือน third-party gateway ทั่วไป</div>
