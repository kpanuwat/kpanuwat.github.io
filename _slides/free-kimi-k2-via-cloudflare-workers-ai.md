---
marp: true
theme: default
paginate: true
title: "Free Kimi K2.6 API via Cloudflare Workers AI"
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

# Free Kimi K2.6 API via Cloudflare Workers AI

<p class="tag">ใช้ LLM ระดับ GPT-4o ฟรี 10,000 req/day ใน 3 ขั้นตอน</p>

<!-- Speaker: สั้นมาก — ไม่มีค่าใช้จ่าย, รองรับ OpenAI format, เชื่อมได้ทันที -->

---

## Kimi K2.6 ฟรีผ่าน Cloudflare — ทำไมถึงสำคัญ

<p class="subhead">LLM ระดับ GPT-4o ที่ไม่ต้องจ่ายเงิน เพราะ Cloudflare อุดหนุน infra ให้</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- callout-box: 3 key facts -->
  <rect x="40" y="30" width="320" height="300" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="320" height="6" rx="3" fill="var(--accent)"/>
  <text x="200" y="80" font-size="42" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">K2.6</text>
  <text x="200" y="110" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Moonshot AI open-source LLM</text>
  <text x="200" y="160" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Coding + Reasoning + Content</text>
  <text x="200" y="185" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เทียบเคียง GPT-4o / Gemini Pro</text>
  <text x="200" y="270" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">OpenAI-compatible API</text>

  <rect x="400" y="30" width="320" height="300" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="400" y="30" width="320" height="6" rx="3" fill="var(--success)"/>
  <text x="560" y="80" font-size="42" font-weight="800" fill="var(--success)" text-anchor="middle" font-family="system-ui">Free</text>
  <text x="560" y="110" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Workers AI free plan</text>
  <text x="560" y="160" font-size="28" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">10,000</text>
  <text x="560" y="190" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">requests / day</text>
  <text x="560" y="270" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">personal / side project เพียงพอ</text>

  <rect x="760" y="30" width="300" height="300" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="760" y="30" width="300" height="6" rx="3" fill="var(--gold)"/>
  <text x="910" y="80" font-size="28" font-weight="800" fill="var(--gold)" text-anchor="middle" font-family="system-ui">3 Steps</text>
  <text x="910" y="110" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">สมัคร → Token → เชื่อมต่อ</text>
  <text x="910" y="155" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ไม่ต้องใส่บัตรเครดิต</text>
  <text x="910" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OpenAI-compatible</text>
  <text x="910" y="215" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ต่อกับ tool ส่วนใหญ่ได้ทันที</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cloudflare เป็น gateway ที่ดีที่สุดสำหรับทดลอง LLM โดยไม่เสียค่าใช้จ่าย</div>

<!-- Speaker: 3 คอลัมน์ — model คืออะไร, ฟรีได้เท่าไหร่, setup ง่ายแค่ไหน -->

---

## 3 ขั้นตอนเปิดใช้งาน — จาก Account ถึง API Call

<p class="subhead">สมัคร Cloudflare → ดึง credentials → เชื่อมกับ tool ที่รองรับ OpenAI format</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 3 steps -->
  <!-- Step 1 -->
  <rect x="40" y="60" width="280" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="180" cy="100" r="22" fill="var(--accent)"/>
  <text x="180" y="106" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="180" y="142" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สมัคร Cloudflare</text>
  <text x="180" y="168" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">cloudflare.com</text>
  <text x="180" y="190" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">บัญชีฟรี ไม่ต้องบัตรเครดิต</text>
  <text x="180" y="210" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เปิด Workers AI</text>
  <!-- Arrow 1→2 -->
  <path d="M330 150 L410 150" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="410,144 420,150 410,156" fill="var(--accent)"/>
  <!-- Step 2 -->
  <rect x="420" y="60" width="280" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <circle cx="560" cy="100" r="22" fill="var(--accent)"/>
  <text x="560" y="106" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="560" y="142" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ดึง Credentials</text>
  <text x="560" y="165" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI → Workers AI</text>
  <text x="560" y="185" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Copy Account ID</text>
  <text x="560" y="205" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Create API Token</text>
  <text x="560" y="225" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">template: Workers AI</text>
  <!-- Arrow 2→3 -->
  <path d="M710 150 L790 150" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="790,144 800,150 790,156" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="800" y="60" width="260" height="180" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 6px 16px rgba(59,130,246,.15))"/>
  <circle cx="930" cy="100" r="22" fill="var(--accent)"/>
  <text x="930" y="106" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="930" y="142" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เชื่อมกับ Tool</text>
  <text x="930" y="165" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OpenAI-compatible</text>
  <text x="930" y="185" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Model ID:</text>
  <text x="930" y="207" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui,monospace">@cf/moonshot/kimi-k2-6</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้งกระบวนการใช้เวลาไม่เกิน 10 นาที — credentials พร้อม ต่อ tool ได้ทันที</div>

<!-- Speaker: เน้น step 2 — Account ID อยู่ด้านขวาของหน้า Workers AI, ไม่ต้องหานาน -->

---

## ข้อจำกัด Free Tier — รู้ก่อนใช้

<p class="subhead">10,000 requests/day ครอบคลุม personal และ side project ได้ทั้งหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- table-like comparison -->
  <rect x="80" y="20" width="940" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <!-- header row -->
  <rect x="80" y="20" width="940" height="50" rx="12" fill="var(--soft)"/>
  <rect x="80" y="50" width="940" height="20" fill="var(--soft)"/>
  <text x="280" y="52" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">รายละเอียด</text>
  <text x="730" y="52" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ค่า</text>
  <!-- row dividers -->
  <line x1="80" y1="110" x2="1020" y2="110" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="80" y1="160" x2="1020" y2="160" stroke="var(--soft-2)" stroke-width="1"/>
  <line x1="80" y1="210" x2="1020" y2="210" stroke="var(--soft-2)" stroke-width="1"/>
  <!-- col divider -->
  <line x1="500" y1="70" x2="500" y2="280" stroke="var(--soft-2)" stroke-width="1"/>
  <!-- rows -->
  <text x="160" y="93" font-size="14" fill="var(--ink)" font-family="system-ui">Requests/day</text>
  <text x="730" y="93" font-size="18" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">10,000</text>
  <text x="160" y="143" font-size="14" fill="var(--ink)" font-family="system-ui">Model ID</text>
  <text x="730" y="143" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui,monospace">@cf/moonshot/kimi-k2-6</text>
  <text x="160" y="193" font-size="14" fill="var(--ink)" font-family="system-ui">API Compatibility</text>
  <text x="730" y="193" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OpenAI-compatible</text>
  <text x="160" y="243" font-size="14" fill="var(--ink)" font-family="system-ui">ค่าใช้จ่าย</text>
  <text x="730" y="243" font-size="16" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">ฟรี</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 10k req/day = ~7 req/นาที ตลอด 24 ชม. เพียงพอสำหรับงาน personal ทุกประเภท</div>

<!-- Speaker: ถ้าต้องการมากกว่านี้ → Cloudflare Workers AI paid plan หรือ Moonshot AI โดยตรง -->

---

## Key Takeaways

<p class="subhead">จุดสำคัญ 3 ข้อที่ควรจำจาก Kimi K2.6 + Cloudflare</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Free Gateway</p>
    <h3>Cloudflare = ฟรีทันที</h3>
    <p>Workers AI free plan ให้ 10,000 req/day โดยไม่ต้องใส่บัตรเครดิต — ดีที่สุดสำหรับทดลอง LLM</p>
  </div>
  <div class="card">
    <p class="label">Compatibility</p>
    <h3>OpenAI format = ต่อได้ทุก tool</h3>
    <p>Kimi K2.6 รองรับ OpenAI API format — เชื่อมกับ tool ที่มี OpenAI integration ได้ทันทีโดยไม่ต้องแก้โค้ด</p>
  </div>
  <div class="card gold">
    <p class="label">Use Case</p>
    <h3>Personal + Side Project</h3>
    <p>10k req/day เพียงพอสำหรับงาน personal, prototype, side project — ประหยัดค่าใช้จ่ายได้มาก</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> สมัคร Cloudflare → ดึง Account ID + API Token → ใส่ model ID <code>@cf/moonshot/kimi-k2-6</code> เริ่มได้ใน 10 นาที</div>

<!-- Speaker: ข้อสำคัญที่สุด — ไม่มีค่าใช้จ่าย ไม่ต้องบัตรเครดิต ต่อได้ทันที -->
