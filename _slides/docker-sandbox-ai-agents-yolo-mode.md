---
marp: true
theme: default
paginate: true
title: "Docker Sandbox: รัน AI Agents ใน YOLO Mode อย่างปลอดภัย"
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
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.2; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Docker Sandbox: รัน AI Agents ใน YOLO Mode อย่างปลอดภัย

<p class="tag">microVM isolation — ให้ Agent ทำงาน full-speed โดยไม่เสี่ยงต่อ host system</p>

<!-- Speaker: Docker Sandboxes แก้ปัญหา approval loop ที่ทำให้ autonomous agent ทำงานช้า ด้วย microVM isolation ที่แยก workspace ออกจาก host โดยสิ้นเชิง -->

---

## ปัญหา: Approval Loop ทำให้ Agent ช้า

<p class="subhead">ทุกครั้งที่ Agent ต้องการทำอะไร ระบบหยุดรอให้ developer อนุมัติ — YOLO mode แก้ได้แต่เสี่ยง</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Without Sandbox -->
  <rect x="30" y="20" width="480" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.07))"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--danger-wash)"/>
  <text x="270" y="51" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี Sandbox (YOLO โดยตรง)</text>
  <text x="70" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Agent รัน --dangerously-skip-permissions</text>
  <text x="70" y="135" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ลบไฟล์ host ได้โดยไม่ตั้งใจ</text>
  <text x="70" y="163" font-size="13" fill="var(--ink-dim)" font-family="system-ui">แก้ .ssh/config โดยไม่รู้ตัว</text>
  <text x="70" y="191" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ส่ง HTTP ออก internet ได้เสรี</text>
  <text x="70" y="219" font-size="13" fill="var(--ink-dim)" font-family="system-ui">ไม่มี audit trail</text>
  <text x="70" y="270" font-size="13" fill="var(--danger)" font-family="system-ui" font-weight="600">ความเสี่ยง: data loss, data leak</text>
  <!-- Right: With Sandbox -->
  <rect x="590" y="20" width="480" height="340" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--success-wash)"/>
  <text x="830" y="51" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Docker Sandbox + YOLO Mode</text>
  <text x="630" y="105" font-size="14" fill="var(--ink)" font-family="system-ui">Agent รัน YOLO ภายใน microVM</text>
  <text x="630" y="135" font-size="13" fill="var(--success-ink)" font-family="system-ui">Host filesystem ปลอดภัยสมบูรณ์</text>
  <text x="630" y="163" font-size="13" fill="var(--success-ink)" font-family="system-ui">.ssh / env vars ถูก block</text>
  <text x="630" y="191" font-size="13" fill="var(--success-ink)" font-family="system-ui">Network policy กำหนดชัดเจน</text>
  <text x="630" y="219" font-size="13" fill="var(--success-ink)" font-family="system-ui">Audit log ทุก action</text>
  <text x="630" y="270" font-size="13" fill="var(--success)" font-family="system-ui" font-weight="600">ผลลัพธ์: ปลอดภัย + ไม่ต้องรออนุมัติ</text>
  <!-- VS badge -->
  <circle cx="550" cy="190" r="26" fill="var(--accent)"/>
  <text x="550" y="195" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> YOLO mode ปลอดภัยก็ต่อเมื่อ sandbox เป็น guardrail แทน developer</div>

<!-- Speaker: อธิบายสองแนวทาง: YOLO โดยตรงกับ host (อันตราย) vs ผ่าน sandbox (ปลอดภัย) -->

---

## YOLO Mode คืออะไร — และทำไม Sandbox ถึงทำให้ปลอดภัย

<p class="subhead">Sandbox ไม่ได้ห้าม Agent ทำ — มันกำหนดว่า Agent ทำได้ "ที่ไหน"</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Central callout box -->
  <rect x="80" y="20" width="940" height="210" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="80" y="20" width="8" height="210" rx="4" fill="var(--accent)"/>
  <!-- Icon circle -->
  <circle cx="168" cy="125" r="42" fill="var(--accent)" opacity=".1"/>
  <circle cx="168" cy="125" r="30" fill="var(--accent)"/>
  <text x="168" y="131" font-size="18" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="800">YOLO</text>
  <!-- Content -->
  <text x="240" y="80" font-size="18" font-weight="700" fill="var(--ink)" font-family="system-ui">--dangerously-skip-permissions</text>
  <text x="240" y="108" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Flag ที่ให้ Agent ข้ามการขออนุมัติทุก action</text>
  <text x="240" y="136" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Agent ทำงาน "at full speed" ไม่มี developer เป็น bottleneck</text>
  <text x="240" y="164" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Docker Sandbox รัน mode นี้ by default ภายใน microVM</text>
  <text x="240" y="200" font-size="13" fill="var(--accent)" font-family="system-ui" font-weight="600">Sandbox = guardrail ที่ทำงานได้ดีกว่า developer เพราะ enforce ทุก op</text>
  <!-- Three benefits below -->
  <rect x="80" y="250" width="290" height="90" rx="10" fill="var(--soft)"/>
  <text x="225" y="278" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Policy ชัดเจน</text>
  <text x="225" y="300" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">filesystem scope</text>
  <text x="225" y="320" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">network allowlist</text>
  <rect x="405" y="250" width="290" height="90" rx="10" fill="var(--soft)"/>
  <text x="550" y="278" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Enforce ทุก operation</text>
  <text x="550" y="300" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่มีพลาด</text>
  <text x="550" y="320" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ไม่มีข้อยกเว้น</text>
  <rect x="730" y="250" width="290" height="90" rx="10" fill="var(--soft)"/>
  <text x="875" y="278" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Log ทุกอย่าง</text>
  <text x="875" y="300" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">audit trail ครบ</text>
  <text x="875" y="320" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SIEM-exportable</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Sandbox ไม่จำกัดความสามารถของ Agent — จำกัดแค่ขอบเขต "พื้นที่" ที่ Agent ทำงานได้</div>

<!-- Speaker: อธิบายว่า YOLO mode ปลอดภัยได้เพราะ sandbox ทำหน้าที่แทน developer ในการกำกับ -->

---

## MicroVM Isolation — ไม่ใช่แค่ Container ธรรมดา

<p class="subhead">แต่ละ agent session ได้รับ microVM แยกต่างหาก — security boundary แข็งแกร่งกว่า Docker container ปกติ</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Outer ring: Host OS -->
  <rect x="40" y="20" width="1020" height="320" rx="20" fill="none" stroke="var(--soft-2)" stroke-width="2" stroke-dasharray="8 4"/>
  <text x="80" y="50" font-size="13" fill="var(--muted)" font-family="system-ui" font-weight="600">HOST OS (Mac / Linux)</text>
  <!-- Middle ring: microVM boundary -->
  <rect x="130" y="55" width="840" height="250" rx="16" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="170" y="82" font-size="13" fill="var(--accent)" font-family="system-ui" font-weight="700">microVM Boundary</text>
  <!-- Inner ring: Agent workspace -->
  <rect x="230" y="95" width="640" height="180" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <text x="550" y="122" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Agent Workspace (Project only)</text>
  <!-- Agent icons inside -->
  <rect x="310" y="138" width="150" height="110" rx="8" fill="var(--soft)"/>
  <text x="385" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude Code /</text>
  <text x="385" y="181" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Codex CLI</text>
  <text x="385" y="215" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">YOLO mode</text>
  <rect x="490" y="138" width="150" height="110" rx="8" fill="var(--soft)"/>
  <text x="565" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Project files</text>
  <text x="565" y="181" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">mounted only</text>
  <rect x="670" y="138" width="150" height="110" rx="8" fill="var(--soft)"/>
  <text x="745" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Specified</text>
  <text x="745" y="181" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">env vars</text>
  <!-- Blocked items outside but inside host -->
  <text x="80" y="155" font-size="11" fill="var(--danger)" font-family="system-ui">BLOCKED:</text>
  <text x="80" y="175" font-size="11" fill="var(--danger)" font-family="system-ui">.ssh keys</text>
  <text x="80" y="195" font-size="11" fill="var(--danger)" font-family="system-ui">host env vars</text>
  <text x="80" y="215" font-size="11" fill="var(--danger)" font-family="system-ui">Docker daemon</text>
  <text x="960" y="155" font-size="11" fill="var(--danger)" font-family="system-ui">BLOCKED:</text>
  <text x="960" y="175" font-size="11" fill="var(--danger)" font-family="system-ui">rm -rf /</text>
  <text x="960" y="195" font-size="11" fill="var(--danger)" font-family="system-ui">shared state</text>
  <text x="960" y="215" font-size="11" fill="var(--danger)" font-family="system-ui">network (policy)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent ทำ rm -rf / ภายใน microVM ได้ — host ไม่ได้รับผลกระทบ ไม่มี shared state หรือ bleed-through</div>

<!-- Speaker: เน้นว่านี่คือ microVM ไม่ใช่ container ธรรมดา — security boundary แข็งแกร่งกว่ามาก -->

---

## Network Policy — ควบคุม 3 ระดับ

<p class="subhead">Agent ที่ถูก compromise อาจ exfiltrate ข้อมูลผ่าน HTTP — sandbox ตัด risk นี้ด้วย proxy-layer policy</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Open Mode</p>
    <h3>เปิด Internet เต็มที่</h3>
    <p>อนุญาต outbound traffic ทุกประเภทไปทุก destination</p>
    <p style="margin-top:8px;font-size:12px;color:var(--warning-ink);">เหมาะสำหรับ dev ที่ต้องการ access internet สมบูรณ์ ความเสี่ยงสูงกว่า</p>
    <p style="margin-top:6px;"><code style="font-size:11px;background:var(--soft);padding:2px 6px;border-radius:4px;">sbx policy set open</code></p>
  </div>
  <div class="card success">
    <p class="label">Balanced Mode — DEFAULT</p>
    <h3>Deny All + Allowlist</h3>
    <p>Block outbound ทั้งหมด ยกเว้น AI provider APIs และ package managers ที่อนุญาตไว้</p>
    <p style="margin-top:8px;font-size:12px;color:var(--success-ink);">Balance ระหว่าง security กับ usability — เหมาะสำหรับ daily use</p>
    <p style="margin-top:6px;"><code style="font-size:11px;background:var(--soft);padding:2px 6px;border-radius:4px;">sbx policy set balanced</code></p>
  </div>
  <div class="card danger">
    <p class="label">Locked Down Mode</p>
    <h3>Block ทุก Outbound</h3>
    <p>ตัด network ทั้งหมดสมบูรณ์ ไม่มีข้อยกเว้น Agent ทำงาน offline เท่านั้น</p>
    <p style="margin-top:8px;font-size:12px;color:var(--danger-ink);">เหมาะสำหรับ offline testing หรือเมื่อต้องการ air-gap environment</p>
    <p style="margin-top:6px;"><code style="font-size:11px;background:var(--soft);padding:2px 6px;border-radius:4px;">sbx policy set locked-down</code></p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Default คือ Balanced — deny all + AI API allowlist เหมาะสำหรับทุกกรณีทั่วไป</div>

<!-- Speaker: อธิบาย 3 tier และเมื่อไรใช้แต่ละแบบ; เน้น default Balanced ซึ่งปลอดภัยแต่ยังใช้งานได้ -->

---

## Audit Log ด้วย sbx policy log

<p class="subhead">ทุก network attempt — allowed และ denied — ถูก log real-time พร้อม context ครบ</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Terminal window -->
  <rect x="60" y="20" width="980" height="280" rx="12" fill="#0f172a"/>
  <rect x="60" y="20" width="980" height="44" rx="12" fill="#1e293b"/>
  <!-- Traffic lights -->
  <circle cx="100" cy="42" r="7" fill="#dc2626"/>
  <circle cx="124" cy="42" r="7" fill="#f59e0b"/>
  <circle cx="148" cy="42" r="7" fill="#16a34a"/>
  <text x="550" y="47" font-size="13" fill="#94a3b8" text-anchor="middle" font-family="monospace">Terminal — sbx policy log</text>
  <!-- Command prompt -->
  <text x="90" y="90" font-size="13" fill="#60a5fa" font-family="monospace">$</text>
  <text x="106" y="90" font-size="13" fill="#e2e8f0" font-family="monospace">sbx policy log</text>
  <!-- Log output rows -->
  <text x="90" y="122" font-size="11" fill="#16a34a" font-family="monospace">ALLOWED</text>
  <text x="175" y="122" font-size="11" fill="#94a3b8" font-family="monospace">2026-05-23 15:02:11</text>
  <text x="360" y="122" font-size="11" fill="#e2e8f0" font-family="monospace">api.anthropic.com:443</text>
  <text x="640" y="122" font-size="11" fill="#64748b" font-family="monospace">rule: ai-providers-allowlist</text>
  <text x="90" y="148" font-size="11" fill="#16a34a" font-family="monospace">ALLOWED</text>
  <text x="175" y="148" font-size="11" fill="#94a3b8" font-family="monospace">2026-05-23 15:02:14</text>
  <text x="360" y="148" font-size="11" fill="#e2e8f0" font-family="monospace">pypi.org:443</text>
  <text x="640" y="148" font-size="11" fill="#64748b" font-family="monospace">rule: package-managers-allowlist</text>
  <text x="90" y="174" font-size="11" fill="#dc2626" font-family="monospace">DENIED </text>
  <text x="175" y="174" font-size="11" fill="#94a3b8" font-family="monospace">2026-05-23 15:02:19</text>
  <text x="360" y="174" font-size="11" fill="#fca5a5" font-family="monospace">external-ip:8080</text>
  <text x="640" y="174" font-size="11" fill="#dc2626" font-family="monospace">BLOCKED — no matching rule</text>
  <text x="90" y="200" font-size="11" fill="#f59e0b" font-family="monospace">BLOCKED</text>
  <text x="175" y="200" font-size="11" fill="#94a3b8" font-family="monospace">2026-05-23 15:02:21</text>
  <text x="360" y="200" font-size="11" fill="#fde68a" font-family="monospace">websocket-fallback</text>
  <text x="640" y="200" font-size="11" fill="#f59e0b" font-family="monospace">attack attempt detected</text>
  <text x="90" y="226" font-size="11" fill="#16a34a" font-family="monospace">ALLOWED</text>
  <text x="175" y="226" font-size="11" fill="#94a3b8" font-family="monospace">2026-05-23 15:02:25</text>
  <text x="360" y="226" font-size="11" fill="#e2e8f0" font-family="monospace">localhost:1234</text>
  <text x="640" y="226" font-size="11" fill="#64748b" font-family="monospace">rule: global-custom-allow</text>
  <!-- Blink cursor -->
  <rect x="90" y="252" width="8" height="16" fill="#60a5fa" opacity=".8"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Log แสดง timestamp + endpoint + policy rule ทุก attempt — export ไป SIEM ได้สำหรับ enterprise audit</div>

<!-- Speaker: ชี้ให้เห็น DENIED row และ "attack attempt detected" ที่ sandbox detect behavior ผิดปกติได้อัตโนมัติ -->

---

## ติดตั้งบน Mac ผ่าน Homebrew

<p class="subhead">ไม่ต้องมี Docker Desktop — sbx เป็น standalone binary ติดตั้งได้ใน 1 คำสั่ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step 1: Install -->
  <rect x="30" y="50" width="220" height="200" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="140" cy="90" r="24" fill="var(--accent)"/>
  <text x="140" y="96" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="140" y="135" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ติดตั้ง Homebrew</text>
  <text x="140" y="158" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">(ถ้ายังไม่มี)</text>
  <text x="140" y="190" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="monospace">brew.sh</text>
  <!-- Arrow 1 -->
  <path d="M 270 150 L 320 150" stroke="var(--accent)" stroke-width="2.5" fill="none" marker-end="url(#arr)"/>
  <!-- Step 2 -->
  <rect x="330" y="50" width="220" height="200" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="440" cy="90" r="24" fill="var(--accent)"/>
  <text x="440" y="96" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="440" y="135" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ติดตั้ง sbx</text>
  <text x="440" y="160" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">brew install</text>
  <text x="440" y="178" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">docker/tap/sbx</text>
  <text x="440" y="210" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ต้อง Docker Desktop</text>
  <!-- Arrow 2 -->
  <path d="M 570 150 L 620 150" stroke="var(--accent)" stroke-width="2.5" fill="none" marker-end="url(#arr)"/>
  <!-- Step 3 -->
  <rect x="630" y="50" width="220" height="200" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <circle cx="740" cy="90" r="24" fill="var(--accent)"/>
  <text x="740" y="96" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="740" y="135" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">cd project/</text>
  <text x="740" y="160" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">sbx run claude</text>
  <text x="740" y="190" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">YOLO mode อัตโนมัติ</text>
  <!-- Arrow 3 -->
  <path d="M 870 150 L 920 150" stroke="var(--accent)" stroke-width="2.5" fill="none" marker-end="url(#arr)"/>
  <!-- Step 4: Running -->
  <rect x="930" y="50" width="140" height="200" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <circle cx="1000" cy="90" r="24" fill="var(--success)"/>
  <text x="1000" y="95" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">GO</text>
  <text x="1000" y="140" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Agent Running</text>
  <text x="1000" y="165" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ปลอดภัย</text>
  <text x="1000" y="185" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไม่รออนุมัติ</text>
  <!-- Arrow defs -->
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> brew install docker/tap/sbx — ไม่ต้อง Docker Desktop; รัน sbx run claude ในโปรเจกต์ใดก็ได้ทันที</div>

<!-- Speaker: เน้นว่าไม่ต้อง Docker Desktop เป็นจุดเด่นสำคัญ ทำให้ setup เร็วมาก -->

---

## ใช้กับ Local LLM (LM Studio) — ไม่มี API Cost

<p class="subhead">LM Studio expose Anthropic-compatible endpoint ที่ /v1/messages — Claude Code เชื่อมได้โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- LM Studio box -->
  <rect x="30" y="60" width="200" height="180" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="60" width="200" height="44" rx="12" fill="var(--soft)"/>
  <text x="130" y="87" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">LM Studio</text>
  <text x="130" y="130" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Local model</text>
  <text x="130" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">port :1234</text>
  <text x="130" y="178" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">/v1/messages</text>
  <text x="130" y="196" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Anthropic-compatible</text>
  <!-- Arrow 1: Allow network -->
  <path d="M 240 150 L 310 150" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <text x="275" y="138" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">sbx policy</text>
  <text x="275" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">allow -g :1234</text>
  <!-- Network policy box -->
  <rect x="320" y="60" width="200" height="180" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <rect x="320" y="60" width="200" height="44" rx="12" fill="var(--warning)" opacity=".3"/>
  <text x="420" y="87" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Network Policy</text>
  <text x="420" y="130" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Global allow rule</text>
  <text x="420" y="150" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">localhost:1234</text>
  <text x="420" y="178" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Sandbox permit เฉพาะ</text>
  <text x="420" y="196" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">port นี้เท่านั้น</text>
  <!-- Arrow 2: Set env vars -->
  <path d="M 530 150 L 600 150" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <text x="565" y="138" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">export env</text>
  <text x="565" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">BASE_URL</text>
  <!-- Env var box -->
  <rect x="610" y="60" width="200" height="180" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="610" y="60" width="200" height="44" rx="12" fill="var(--soft-2)"/>
  <text x="710" y="87" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Env Vars</text>
  <text x="710" y="126" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">ANTHROPIC_BASE_URL</text>
  <text x="710" y="142" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">http://localhost:1234</text>
  <text x="710" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">ANTHROPIC_API_KEY</text>
  <text x="710" y="184" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="monospace">local</text>
  <!-- Arrow 3 -->
  <path d="M 820 150 L 890 150" stroke="var(--accent)" stroke-width="2" fill="none" marker-end="url(#arr2)"/>
  <text x="855" y="138" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">sbx run</text>
  <text x="855" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="monospace">claude</text>
  <!-- Result box -->
  <rect x="900" y="60" width="170" height="180" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="900" y="60" width="170" height="44" rx="12" fill="var(--success)" opacity=".3"/>
  <text x="985" y="87" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Local Agent</text>
  <text x="985" y="130" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไม่มี API cost</text>
  <text x="985" y="152" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ข้อมูลไม่ออก</text>
  <text x="985" y="172" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">machine</text>
  <text x="985" y="200" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">sandbox ยัง enforce</text>
  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--accent)"/>
    </marker>
  </defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> sbx policy allow network -g localhost:1234 + override ANTHROPIC_BASE_URL — Agent ใช้ local model ได้ทันที</div>

<!-- Speaker: อธิบาย 4 ขั้นตอน; เน้นว่า LM Studio ต้องเปิดก่อน และ port อาจต่างกัน -->

---

## User Guide — 5 ขั้นตอนเริ่มต้น

<p class="subhead">ตั้งแต่ติดตั้งจนถึง Agent ทำงานอัตโนมัติได้ภายในไม่กี่นาที</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-5">
  <div class="card compact">
    <p class="label">Step 1</p>
    <h3>ติดตั้ง sbx</h3>
    <p><code style="font-size:10px;">brew install docker/tap/sbx</code></p>
  </div>
  <div class="card compact">
    <p class="label">Step 2</p>
    <h3>รัน Agent</h3>
    <p><code style="font-size:10px;">sbx run claude</code> หรือ <code style="font-size:10px;">sbx run codex</code></p>
  </div>
  <div class="card compact">
    <p class="label">Step 3</p>
    <h3>ตรวจ Policy</h3>
    <p><code style="font-size:10px;">sbx policy list</code> ดู Balanced mode ที่ set ไว้</p>
  </div>
  <div class="card compact">
    <p class="label">Step 4</p>
    <h3>Monitor Log</h3>
    <p><code style="font-size:10px;">sbx policy log</code> real-time network audit</p>
  </div>
  <div class="card compact gold">
    <p class="label">Step 5 (optional)</p>
    <h3>Local LLM</h3>
    <p>Allow :1234 + set BASE_URL สำหรับ LM Studio</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Steps 1-2 ใช้เวลา 2 นาที; Steps 3-5 ปรับ security posture ตาม use case</div>

<!-- Speaker: walk through each step; เน้น step 4 ว่า policy log ควรเปิดดูระหว่าง agent ทำงานเพื่อ debug -->

---

## Caveats และข้อจำกัดที่ควรรู้

<p class="subhead">ข้อมูลที่ควรทราบก่อนนำไปใช้จริงในทีม</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Platform</p>
    <h3>macOS เป็นหลัก</h3>
    <p>Docker Sandbox รองรับ macOS เป็น primary platform (2025) — Linux / Windows อยู่ใน roadmap</p>
  </div>
  <div class="card warning">
    <p class="label">Performance</p>
    <h3>microVM Startup</h3>
    <p>Startup time นานกว่า container ปกติเล็กน้อย แต่ไม่กระทบ throughput ระหว่าง agent ทำงาน</p>
  </div>
  <div class="card danger">
    <p class="label">Local LLM</p>
    <h3>CPU Speed</h3>
    <p>Model ที่รันบน CPU ช้ากว่า Anthropic API มาก — เหมาะทดสอบ logic ไม่ใช่ production speed</p>
  </div>
  <div class="card warning">
    <p class="label">Network</p>
    <h3>Policy Learning</h3>
    <p>Balanced mode อาจ block dependency นอก allowlist — ต้อง add rule ผ่าน sbx policy allow เอง</p>
  </div>
  <div class="card" style="border-left-color:var(--ink-dim);">
    <p class="label">Scope</p>
    <h3>ไม่ใช่ Malware Sandbox</h3>
    <p>ออกแบบสำหรับ agent autonomy — ไม่ใช่ malware analysis ที่ต้องการ kernel-level isolation</p>
  </div>
  <div class="card success">
    <p class="label">Summary</p>
    <h3>เหมาะที่สุดสำหรับ</h3>
    <p>CI/CD autonomous agent, ทดสอบ agent logic ที่ sensitive, ลด API cost ด้วย local model</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> สำหรับทีมที่ใช้ Mac และต้องการรัน agent อัตโนมัติ — Docker Sandbox คือทางเลือกที่ดีที่สุดในปัจจุบัน</div>

<!-- Speaker: อธิบาย caveats แต่ย้ำว่าสำหรับ use case ที่เหมาะ (Mac + autonomous agent) นี่คือ best option -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ผู้อ่านควรจำหลังจาก deck นี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Core Concept</p>
    <h3>microVM Isolation</h3>
    <p>ไม่ใช่แค่ container — security boundary แข็งแกร่งกว่า ป้องกัน host filesystem, .ssh, env vars, Docker daemon</p>
  </div>
  <div class="card success">
    <p class="label">Key Enabler</p>
    <h3>YOLO Mode ปลอดภัย</h3>
    <p>--dangerously-skip-permissions ปลอดภัยใน sandbox เพราะ sandbox เป็น guardrail แทน developer</p>
  </div>
  <div class="card">
    <p class="label">Security Control</p>
    <h3>3-Tier Network</h3>
    <p>Open / Balanced / Locked Down — default Balanced ให้ AI API แต่ block outbound ทั่วไป</p>
  </div>
  <div class="card">
    <p class="label">Observability</p>
    <h3>sbx policy log</h3>
    <p>Audit trail real-time ทุก network attempt — export ไป SIEM ได้ detect anomaly อัตโนมัติ</p>
  </div>
  <div class="card success">
    <p class="label">Setup</p>
    <h3>brew install sbx</h3>
    <p>ไม่ต้อง Docker Desktop — standalone binary, รัน sbx run claude ในโปรเจกต์ใดก็ได้ใน 2 นาที</p>
  </div>
  <div class="card gold">
    <p class="label">Bonus</p>
    <h3>Local LLM Ready</h3>
    <p>ใช้ LM Studio ผ่าน sbx policy allow -g localhost:1234 + override ANTHROPIC_BASE_URL — ประหยัด API cost</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Docker Sandbox = YOLO mode ที่ปลอดภัย — ให้ Agent ทำงาน full-speed ภายใน microVM โดยไม่เสี่ยงต่อ host</div>

<!-- Speaker: สรุป 6 ประเด็นหลัก; ย้ำ core message ว่า sandbox คือ enabler ของ autonomous agent ที่ปลอดภัย -->
