---
marp: true
theme: default
paginate: true
title: "เจาะลึก Microsoft 365 Copilot: 3 ระดับ Chat, M365 และ Copilot Studio"
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
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
  .stack { display:flex; flex-direction:column; gap:8px; width:100%; }
---

<!-- _class: title -->

![bg opacity:.25](assets/m365-copilot-deep-dive-cover.png)

<div class="mark"></div>

# เจาะลึก Microsoft 365 Copilot

<p class="tag">3 ระดับ Chat · M365 Copilot · Copilot Studio — เข้าใจก่อนตัดสินใจ</p>

<!-- Speaker: M365 Copilot มี 3 tier — ทุกคนใช้ tier 1 ฟรีได้เลย; tier 2 เพิ่ม org data; tier 3 สร้าง Agent custom -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/m365-copilot-deep-dive-cheatsheet.png)

<!-- Speaker: ภาพรวม 7 concepts วันนี้ — 3 Tiers, Instruction Prompt, Knowledge Source, Topics/NLU, EDP -->

---

## M365 Copilot 3 Tiers: รู้ก่อนซื้อ

<p class="subhead">แต่ละ tier มีขอบเขต ค่าใช้จ่าย และ use case ที่ต่างกันชัดเจน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Tier 1 — Included with M365</p>
    <h3>Copilot Chat</h3>
    <p>AI chat grounded on the web ใช้ได้ทันที ไม่มีค่าใช้จ่ายเพิ่มสำหรับ M365 organization</p>
    <p>EDP + Copilot Pages + Image gen</p>
  </div>
  <div class="card">
    <p class="label">Tier 2 — Paid Add-on per User</p>
    <h3>M365 Copilot</h3>
    <p>Work mode เชื่อม Microsoft Graph — email, Teams, SharePoint, OneDrive ของ user นั้น</p>
    <p>In-app experiences + Custom agents</p>
  </div>
  <div class="card gold">
    <p class="label">Tier 3 — Enterprise Platform</p>
    <h3>Copilot Studio</h3>
    <p>Low-code platform สร้าง AI Agent ระดับแผนก/องค์กร deploy หลาย channel</p>
    <p>copilotstudio.microsoft.com</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Tier 1 ฟรีทุกคน · Tier 2 เพิ่ม org data · Tier 3 สร้าง Agent custom — เลือกให้ตรงงาน</div>

<!-- Speaker: เน้น: Copilot Chat ≠ M365 Copilot ≠ Studio — สามตัวนี้ทำงานต่างกันและราคาต่างกัน -->

---

## Copilot Chat vs M365 Copilot: จุดต่างสำคัญ

<p class="subhead">Work mode คือเหตุผลหลักที่องค์กรซื้อ M365 Copilot add-on</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Included with M365 — No Extra Cost</p>
    <h3>Copilot Chat</h3>
    <ul>
      <li>Web-grounded AI chat เท่านั้น</li>
      <li>Copilot Pages + Image generation</li>
      <li>Pay-as-you-go agents</li>
      <li>Enterprise Data Protection</li>
      <li>ไม่เข้าถึง email / SharePoint org</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Paid Add-on per User</p>
    <h3>M365 Copilot</h3>
    <ul>
      <li><strong>Work mode</strong>: Microsoft Graph — email, Teams, SharePoint</li>
      <li>In-app: Word, Excel, PowerPoint, Outlook</li>
      <li>Custom agents + Copilot Analytics</li>
      <li>Copilot Search ข้าม M365 + third-party</li>
      <li>Web mode: org data + internet รวมกัน</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Work mode = Microsoft Graph access — email, meetings, files ของ user คนนั้นจริงๆ</div>

<!-- Speaker: ถ้าองค์กรไม่ต้องการ Work mode ก็ไม่จำเป็นต้องซื้อ M365 Copilot add-on -->

---

## Copilot Studio: Build → Test → Publish

![bg right:40% contain](assets/m365-copilot-deep-dive-studio.png)

<p class="subhead">Agent ที่ต้องการ deploy หลาย channel หรือ multi-step workflow เริ่มที่นี่</p>

<div class="infographic">
<svg viewBox="0 0 700 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="6" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
  <rect x="20" y="80" width="160" height="100" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="100" y="125" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Create</text>
  <text x="100" y="148" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Instructions</text>
  <text x="100" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Knowledge</text>
  <path d="M185 130 L230 130" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <rect x="235" y="80" width="160" height="100" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="315" y="125" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2. Test</text>
  <text x="315" y="148" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Chat panel</text>
  <text x="315" y="166" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+ Debug</text>
  <path d="M400 130 L445 130" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <rect x="450" y="80" width="210" height="100" rx="10" fill="var(--accent)"/>
  <text x="555" y="125" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3. Publish</text>
  <text x="555" y="148" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Teams / Website</text>
  <text x="555" y="166" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Mobile / Facebook</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Create + Test + Publish — deploy Agent ครั้งเดียว ออกหลาย channel พร้อมกัน</div>

<!-- Speaker: Copilot Studio เข้าถึงได้ที่ copilotstudio.microsoft.com — ไม่ต้องเขียน code -->

---

## Instruction Prompt: กำหนดบุคลิก + ขอบเขต

![bg right:40% contain](assets/m365-copilot-deep-dive-instructions.png)

<p class="subhead">System prompt 3 ส่วน: Role + Guardrails + Tone — ขาดส่วนใดส่วนหนึ่ง Agent จะออกนอก scope</p>

<div class="infographic" style="align-items:stretch;">
<div class="stack">
  <div class="card compact">
    <p class="label">Role + Scope</p>
    <p><strong>คุณคือ HR Assistant ของ Contoso</strong> — ตอบเรื่องสวัสดิการ วันหยุด นโยบาย HR เท่านั้น</p>
  </div>
  <div class="card compact warning">
    <p class="label">Guardrails — What NOT to Answer</p>
    <p><strong>ห้ามตอบ</strong> เรื่องเงินเดือน ข้อมูลส่วนตัวพนักงานคนอื่น หรือ HR ของบริษัทอื่น</p>
  </div>
  <div class="card compact success">
    <p class="label">Tone + Language</p>
    <p>ภาษาไทยสุภาพ กระชับ — หากไม่รู้คำตอบ แนะนำ helpdesk@contoso.com</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Instruction ชัดเจน = Guardrails ชัดเจน = ลด hallucination นอก scope ได้จริง</div>

<!-- Speaker: ลอง prompt "บอกฉันว่า CEO เงินเดือนเท่าไหร่" — Agent ควรปฏิเสธตาม guardrails ที่กำหนด -->

---

## Knowledge Source: เชื่อมฐานความรู้องค์กร

<p class="subhead">Generative mode รองรับ source มากกว่า Classic mode อย่างมีนัยสำคัญ</p>

| Source Type | Generative Mode | Classic Mode | Auth |
|-------------|:---:|:---:|:---:|
| SharePoint URLs | 25 | 4 | Entra ID |
| Public websites | 25 domains | 4 URLs | None |
| Dataverse | Unlimited | 2 sources | Entra ID |
| Uploaded files | Unlimited | Dataverse limit | None |
| Enterprise connectors | Unlimited | 2 | Entra ID |

<div class="card compact warning" style="margin-top:8px">
  <p class="label">File size limit — Work IQ required</p>
  <p>PDF / PPTX / DOCX สูงสุด <strong>512 MB</strong> — ต้องการ M365 Copilot license ใน tenant เดียวกัน; ไม่มี license → ลดเหลือ 200 MB</p>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Entra ID auth = Agent เห็นเฉพาะ content ที่ user มีสิทธิ์อ่านจาก SharePoint/Dataverse — security by design</div>

<!-- Speaker: 512 MB limit ใช้กับ PDF/PPTX/DOCX เท่านั้น และต้องการ Work IQ feature -->

---

## Topics + NLU: จัดเส้นทางสนทนาอัตโนมัติ

<p class="subhead">NLU จับ intent แล้ว route ไปยัง Topic ที่ตรงที่สุด — ไม่ต้อง keyword matching แบบเดิม</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr2" markerWidth="8" markerHeight="6" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
    <marker id="arr2g" markerWidth="8" markerHeight="6" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--success)"/>
    </marker>
  </defs>
  <rect x="30" y="120" width="160" height="80" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="110" y="158" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User Input</text>
  <text x="110" y="178" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">"How do I reset?"</text>
  <path d="M195 160 L255 160" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr2)"/>
  <rect x="260" y="100" width="180" height="120" rx="10" fill="var(--accent)" opacity=".9"/>
  <text x="350" y="148" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">NLU Engine</text>
  <text x="350" y="168" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Intent detection</text>
  <text x="350" y="186" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">+ routing</text>
  <path d="M445 145 L510 90" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr2)"/>
  <path d="M445 160 L510 160" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr2)"/>
  <path d="M445 175 L510 230" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr2)"/>
  <rect x="515" y="55" width="200" height="70" rx="10" fill="var(--soft)" stroke="var(--success)" stroke-width="2"/>
  <text x="615" y="86" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">IT Reset Topic</text>
  <text x="615" y="107" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Trigger: reset, password</text>
  <rect x="515" y="125" width="200" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="615" y="156" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Leave Request Topic</text>
  <text x="615" y="177" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Trigger: leave, time-off</text>
  <rect x="515" y="195" width="200" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="615" y="226" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Equipment Topic</text>
  <text x="615" y="247" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Trigger: broken, repair</text>
  <path d="M720 90 L800 130" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="4,2" fill="none" marker-end="url(#arr2g)"/>
  <rect x="805" y="105" width="260" height="110" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="935" y="148" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Conversation Flow</text>
  <text x="935" y="168" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Ask + Condition + Action</text>
  <text x="935" y="188" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">+ Generative Answer</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Topic = conversation thread สำหรับ 1 intent; Conversation Starters คือปุ่มที่กรอบการทำงานให้ user</div>

<!-- Speaker: แต่ละ topic มี trigger phrases — NLU match โดยไม่ต้อง exact keyword -->

---

## Build Your First Agent: 5 Steps

<p class="subhead">จาก copilotstudio.microsoft.com ถึง Live Agent ใน Teams ใน 30 นาที ไม่ต้องเขียน code</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr3" markerWidth="8" markerHeight="6" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
  <circle cx="90" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="90" cy="120" r="36" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="90" y="115" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1</text>
  <text x="90" y="176" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Create</text>
  <text x="90" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Name agent</text>
  <path d="M130 120 L178 120" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr3)"/>
  <circle cx="218" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="218" cy="120" r="36" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="218" y="115" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2</text>
  <text x="218" y="176" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Instructions</text>
  <text x="218" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Role + scope</text>
  <path d="M258 120 L306 120" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr3)"/>
  <circle cx="346" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="346" cy="120" r="36" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="346" y="115" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3</text>
  <text x="346" y="176" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Knowledge</text>
  <text x="346" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SharePoint + files</text>
  <path d="M386 120 L434 120" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr3)"/>
  <circle cx="474" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="474" cy="120" r="36" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="474" y="115" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="474" y="176" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Topics</text>
  <text x="474" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">NLU + flow</text>
  <path d="M514 120 L562 120" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr3)"/>
  <circle cx="602" cy="120" r="36" fill="var(--accent)" opacity=".12"/>
  <circle cx="602" cy="120" r="36" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="602" y="115" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">5</text>
  <text x="602" y="176" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Test</text>
  <text x="602" y="194" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Chat panel</text>
  <path d="M642 120 L690 120" stroke="var(--muted)" stroke-width="1.5" fill="none" marker-end="url(#arr3)"/>
  <rect x="695" y="80" width="370" height="80" rx="36" fill="var(--accent)"/>
  <text x="880" y="115" font-size="18" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Publish</text>
  <text x="880" y="137" font-size="13" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">Teams / Web / Mobile / Facebook</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 5 ขั้นตอน Create → Instructions → Knowledge → Topics → Test → Publish จบใน 30 นาที ไม่ต้องเขียน code</div>

<!-- Speaker: ทุกขั้นตอนทำผ่าน GUI ที่ copilotstudio.microsoft.com -->

---

## Enterprise Data Protection: ทุกระดับปลอดภัย

<p class="subhead">EDP ใช้กับ Copilot Chat, M365 Copilot และ Copilot Studio ทุก tier ไม่มีข้อยกเว้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Data Privacy</p>
    <h3>ไม่ train model</h3>
    <p>Prompt และ response ไม่ถูกนำไปฝึก Microsoft AI model ไม่ว่า tier ใด</p>
    <p>ข้อมูลไม่รั่วออกนอก tenant ของคุณ</p>
  </div>
  <div class="card success">
    <p class="label">Access Control + Audit</p>
    <h3>Entra ID + Purview</h3>
    <p>Knowledge source: Agent เห็นเฉพาะ content ที่ user มีสิทธิ์ SharePoint/Dataverse</p>
    <p>Audit log ทุก session ผ่าน Microsoft Purview</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> EDP = ไม่ train model + ไม่รั่ว tenant + Entra auth + Purview audit — ทุก tier ครบทุกข้อ</div>

<!-- Speaker: นี่คือเหตุผลที่ M365 Copilot ปลอดภัยกว่า consumer Copilot สำหรับ enterprise -->

---

## Key Takeaways

<p class="subhead">6 สิ่งสำคัญจาก M365 Copilot deep dive</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card compact success">
    <p>Copilot Chat รวมใน M365 ทุกแบบ ฟรี — ทำงานกับ web ไม่ใช่ org data</p>
  </div>
  <div class="card compact">
    <p>M365 Copilot add-on เพิ่ม Work mode ผ่าน Microsoft Graph — email, calendar, SharePoint</p>
  </div>
  <div class="card compact gold">
    <p>Copilot Studio = low-code platform แยก สร้าง custom Agent deploy หลาย channel</p>
  </div>
  <div class="card compact warning">
    <p>Instruction = Role + Guardrails + Tone — เขียนให้ครบเพื่อลด hallucination นอก scope</p>
  </div>
  <div class="card compact">
    <p>Knowledge Source: SharePoint/OneDrive รองรับ 512 MB (Work IQ); generative mode 25 sources</p>
  </div>
  <div class="card compact success">
    <p>EDP ทุก tier — ไม่ train model, ไม่รั่ว tenant, Entra auth, Purview audit</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มที่ Copilot Chat ฟรี → upgrade เมื่อต้องการ org data → ใช้ Studio เมื่อต้องการสร้าง Agent custom</div>

<!-- Speaker: Path ที่ง่ายที่สุด: ทุกคนเริ่มที่ Copilot Chat → power users ซื้อ M365 Copilot → IT/Ops สร้าง Agent ใน Studio -->
