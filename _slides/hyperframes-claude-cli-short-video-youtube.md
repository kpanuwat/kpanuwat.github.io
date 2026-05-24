---
marp: true
theme: default
paginate: true
title: "Hyperframes + Claude CLI: Short Video → YouTube Pipeline"
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
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Hyperframes + Claude CLI

<p class="tag">HTML เขียน → MP4 render → YouTube upload: pipeline อัตโนมัติใน 10 นาที</p>

<!-- Speaker: เปิดด้วย "คุณเคยใช้เวลา 2 ชั่วโมงทำวิดีโอสั้นแค่ 60 วินาทีไหม?" — deck นี้จะแสดง pipeline ที่ทำทั้งหมดนั้นด้วย Claude CLI + HyperFrames -->

---

## Video Creation ยังเป็น Bottleneck — ทั้งที่ AI ช่วยได้

<p class="subhead">การสลับ tool หลายตัวคือต้นเหตุจริง ไม่ใช่ content</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 1px 2px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="480" height="52" rx="12" fill="var(--soft)"/>
  <text x="280" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Manual Workflow</text>
  <text x="80" y="106" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Record screen / film footage</text>
  <text x="80" y="136" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Open video editor, cut + trim</text>
  <text x="80" y="166" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Add voiceover separately</text>
  <text x="80" y="196" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Export, re-open YouTube Studio</text>
  <text x="80" y="226" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Fill metadata, set thumbnail</text>
  <text x="280" y="292" font-size="18" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">~2 hours per clip</text>
  <circle cx="550" cy="170" r="28" fill="var(--accent)"/>
  <text x="550" y="175" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="580" y="20" width="480" height="300" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="580" y="20" width="480" height="52" rx="12" fill="var(--accent-wash)"/>
  <text x="820" y="52" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude + HyperFrames Pipeline</text>
  <text x="620" y="106" font-size="14" fill="var(--ink)" font-family="system-ui">1 prompt → Claude writes script JSON</text>
  <text x="620" y="136" font-size="14" fill="var(--ink)" font-family="system-ui">ElevenLabs generates voiceover</text>
  <text x="620" y="166" font-size="14" fill="var(--ink)" font-family="system-ui">HyperFrames renders HTML to MP4</text>
  <text x="620" y="196" font-size="14" fill="var(--ink)" font-family="system-ui">FFmpeg merges audio + video</text>
  <text x="620" y="226" font-size="14" fill="var(--ink)" font-family="system-ui">YouTube API uploads automatically</text>
  <text x="820" y="292" font-size="18" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">~10 minutes, repeatable</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ปัญหาคือ context-switching ระหว่าง tools — pipeline เดียวที่ orchestrate ทุกขั้นตอนคือคำตอบ</div>

<!-- Speaker: ชี้ให้เห็นว่าแต่ละ step ใน manual ต้องเปิด app ใหม่ — Claude Code เป็น single entry point -->

---

## HyperFrames: AI เขียน HTML แล้วได้ MP4

<p class="subhead">แทน pixel generation ด้วย HTML composition — สิ่งที่ Claude ทำได้ดีที่สุด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="50" y="30" width="460" height="280" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="280" y="72" font-size="15" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Traditional AI Video</text>
  <rect x="80" y="90" width="400" height="2" rx="1" fill="var(--soft-2)"/>
  <text x="280" y="138" font-size="38" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">pixels?</text>
  <text x="280" y="185" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Non-deterministic · Slow · Expensive</text>
  <text x="280" y="210" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Hard to reproduce · API credits burn fast</text>
  <path d="M520 170 L590 170" stroke="var(--accent)" stroke-width="3" fill="none"/>
  <polygon points="590,162 610,170 590,178" fill="var(--accent)"/>
  <rect x="620" y="30" width="460" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="620" y="30" width="460" height="52" rx="14" fill="var(--accent-wash)"/>
  <text x="850" y="63" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">HyperFrames Approach</text>
  <text x="850" y="118" font-size="32" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">&lt;HTML&gt; to MP4</text>
  <text x="850" y="165" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Claude writes HTML (already great at this)</text>
  <text x="850" y="190" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Puppeteer screenshots frame-by-frame</text>
  <text x="850" y="215" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">FFmpeg encodes frames to MP4</text>
  <text x="850" y="252" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Deterministic · Reproducible · Apache 2.0</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HyperFrames ไม่ขอให้ AI "วาดภาพ" แต่ขอให้ AI "เขียน HTML" — ทำให้ output ควบคุมได้และทำซ้ำได้ 100%</div>

<!-- Speaker: เน้นว่า deterministic หมายความว่า input เดิม → output เดิม ทุกครั้ง ไม่มี random seed -->

---

## HyperFrames Architecture: 4 Packages, 1 Pipeline

<p class="subhead">ออกแบบแบบ Unix — แต่ละ layer ทำงานเดียว แทนที่ได้อิสระ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Layer 1</p>
    <h3>@hyperframes/core</h3>
    <p>Parsing + runtime อ่าน HTML <code>data-*</code> attributes กำหนด timing และ track layering</p>
  </div>
  <div class="card">
    <p class="label">Layer 2</p>
    <h3>@hyperframes/engine</h3>
    <p>Capture engine: Puppeteer screenshot ทุก frame ตาม timeline ที่ core กำหนด</p>
  </div>
  <div class="card">
    <p class="label">Layer 3</p>
    <h3>@hyperframes/producer</h3>
    <p>FFmpeg pipeline: เรียง frame sequence แล้ว encode เป็น MP4 ที่เล่นได้</p>
  </div>
  <div class="card success">
    <p class="label">Dev Tool</p>
    <h3>@hyperframes/studio</h3>
    <p>Browser editor สำหรับ live preview composition ก่อน render จริง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 3 layers หลัก (core → engine → producer) ทำงานอิสระ — แทน engine ด้วย headless Chrome อื่นได้โดยไม่กระทบ producer</div>

<!-- Speaker: เปรียบกับ Unix pipe: core parses → engine captures → producer encodes. studio เป็น optional dev shortcut -->

---

## Full Pipeline: 5 จุดเชื่อมกันตั้งแต่ Prompt ถึง YouTube

<p class="subhead">Claude orchestrates ทุก tool — ไม่ต้องสลับ terminal</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="90" width="170" height="120" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="105" y="132" font-size="11" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">STEP 1</text>
  <text x="105" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Claude</text>
  <text x="105" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Script JSON</text>
  <text x="105" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">30-60s</text>
  <path d="M192 150 L220 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="220,143 236,150 220,157" fill="var(--muted)"/>
  <rect x="238" y="90" width="170" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="323" y="132" font-size="11" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">STEP 2</text>
  <text x="323" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ElevenLabs</text>
  <text x="323" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Audio MP3</text>
  <text x="323" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1-2 min</text>
  <path d="M410 150 L438 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="438,143 454,150 438,157" fill="var(--muted)"/>
  <rect x="456" y="90" width="170" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="541" y="132" font-size="11" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">STEP 3</text>
  <text x="541" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">HyperFrames</text>
  <text x="541" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Visual MP4</text>
  <text x="541" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">3-8 min</text>
  <path d="M628 150 L656 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="656,143 672,150 656,157" fill="var(--muted)"/>
  <rect x="674" y="90" width="170" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="759" y="132" font-size="11" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">STEP 4</text>
  <text x="759" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">FFmpeg</text>
  <text x="759" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Merge + Concat</text>
  <text x="759" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">&lt; 1 min</text>
  <path d="M846 150 L874 150" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="874,143 890,150 874,157" fill="var(--muted)"/>
  <rect x="892" y="90" width="170" height="120" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="977" y="132" font-size="11" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">STEP 5</text>
  <text x="977" y="153" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">YouTube API</text>
  <text x="977" y="172" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Upload + Live</text>
  <text x="977" y="191" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1-2 min</text>
  <rect x="20" y="240" width="1042" height="28" rx="6" fill="var(--soft)"/>
  <text x="541" y="259" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Total: 6-14 minutes for a 60-second video</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Step 3 (HyperFrames) คือ bottleneck จริง — 3-8 นาทีที่ Claude รออยู่เฉยๆ ระหว่างนั้นเริ่ม script สำหรับคลิปต่อไปได้เลย</div>

<!-- Speaker: เน้น step 3 เป็น slowest — ออกแบบ pipeline ให้ batch-friendly ได้ถ้าต้องการ -->

---

## Setup: ติดตั้ง Tools และ API Keys (Steps 1-2)

<p class="subhead">ทำครั้งเดียว — ทุก video ต่อจากนี้ใช้ setup เดิม</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Prerequisites</p>
    <h3>Node.js + Tools</h3>
    <p>Node.js &gt;= 22 (required)</p>
    <p><code>brew install ffmpeg</code></p>
    <p><code>npm i -g @anthropic-ai/claude-code</code></p>
    <p><code>npx skills add heygen-com/hyperframes</code></p>
  </div>
  <div class="card warning">
    <p class="label">API Keys (.env)</p>
    <h3>ElevenLabs + HyperFrames</h3>
    <p>ElevenLabs: elevenlabs.io → Profile → API Key</p>
    <p>HyperFrames: hyperframes.ai → Dashboard</p>
    <p>Free tier: 10,000 chars/เดือน (~15 min audio)</p>
  </div>
  <div class="card danger">
    <p class="label">YouTube OAuth2</p>
    <h3>Google Cloud Setup</h3>
    <p>Enable YouTube Data API v3</p>
    <p>OAuth2 → Desktop App</p>
    <p>Download client_secrets.json</p>
    <p>ต้องใส่ใน .gitignore เสมอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> YouTube OAuth2 setup ทำครั้งเดียว — หลังจากนั้น token.json refresh อัตโนมัติ ไม่ต้อง authorize ซ้ำ</div>

<!-- Speaker: เน้น .gitignore — .env, client_secrets.json, token.json ต้องไม่เข้า git repo เด็ดขาด -->

---

## Step 3: Claude สร้าง Script JSON

<p class="subhead">Structured output เป็น JSON ทำให้ steps ต่อไปรับ input ได้โดยตรง</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="440" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="440" height="44" rx="12" fill="var(--accent)" opacity=".9"/>
  <text x="250" y="48" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Claude Prompt</text>
  <text x="60" y="88" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">Write a 60-second YouTube Shorts script</text>
  <text x="60" y="108" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">about "[your topic]".</text>
  <text x="60" y="132" font-size="12" fill="var(--ink-dim)" font-family="system-ui,monospace">Structure as JSON with fields:</text>
  <text x="60" y="152" font-size="12" fill="var(--accent)" font-family="system-ui,monospace">  id, narration_text,</text>
  <text x="60" y="172" font-size="12" fill="var(--accent)" font-family="system-ui,monospace">  duration_seconds,</text>
  <text x="60" y="192" font-size="12" fill="var(--accent)" font-family="system-ui,monospace">  visual_description,</text>
  <text x="60" y="212" font-size="12" fill="var(--accent)" font-family="system-ui,monospace">  visual_style</text>
  <text x="60" y="240" font-size="12" fill="var(--ink-dim)" font-family="system-ui,monospace">Save to script.json</text>
  <path d="M478 160 L520 160" stroke="var(--muted)" stroke-width="2.5" fill="none"/>
  <polygon points="520,152 540,160 520,168" fill="var(--muted)"/>
  <rect x="548" y="20" width="510" height="280" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="548" y="20" width="510" height="44" rx="12" fill="var(--success)" opacity=".9"/>
  <text x="803" y="48" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">script.json Output</text>
  <text x="572" y="88" font-size="11" fill="var(--ink)" font-family="system-ui,monospace">[{</text>
  <text x="572" y="108" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">  "id": 1,</text>
  <text x="572" y="126" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">  "narration_text": "Claude Code...",</text>
  <text x="572" y="144" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">  "duration_seconds": 10,</text>
  <text x="572" y="162" font-size="11" fill="var(--accent)" font-family="system-ui,monospace">  "visual_description": "Animated terminal",</text>
  <text x="572" y="180" font-size="11" fill="var(--accent)" font-family="system-ui,monospace">  "visual_style": "professional"</text>
  <text x="572" y="198" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">}, {</text>
  <text x="572" y="216" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">  "id": 2, ...</text>
  <text x="572" y="234" font-size="11" fill="var(--ink-dim)" font-family="system-ui,monospace">}]</text>
  <text x="803" y="276" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Steps 4-5 read this file directly</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> JSON เป็น "contract" ระหว่าง Claude กับ pipeline — visual_description ไปที่ HyperFrames, narration_text ไปที่ ElevenLabs โดยตรง</div>

<!-- Speaker: JSON schema นี้ทำให้แต่ละ step อ่าน input ได้โดยไม่ต้องแปลง format -->

---

## Steps 4-5: Audio และ Visuals ทำงาน per-segment loop

<p class="subhead">ElevenLabs สำหรับ voice, HyperFrames สำหรับ animation — ทำ loop เดียวกัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="490" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="490" height="50" rx="12" fill="var(--warning-wash)"/>
  <text x="275" y="52" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ElevenLabs — audio_N.mp3</text>
  <text x="60" y="100" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">POST /v1/text-to-speech/VOICE_ID</text>
  <text x="60" y="124" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Input: narration_text per segment</text>
  <text x="60" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Model: eleven_monolingual_v1</text>
  <text x="60" y="172" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Output: audio_1.mp3, audio_2.mp3 ...</text>
  <text x="60" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Time: 1-2 minutes total</text>
  <rect x="60" y="222" width="390" height="36" rx="8" fill="var(--warning-wash)"/>
  <text x="255" y="245" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Free: 10,000 chars/mo | Paid: $5+/mo</text>
  <line x1="550" y1="30" x2="550" y2="270" stroke="var(--soft-2)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <circle cx="550" cy="150" r="22" fill="var(--soft)"/>
  <text x="550" y="155" font-size="13" fill="var(--ink-dim)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">+</text>
  <rect x="580" y="20" width="490" height="260" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="580" y="20" width="490" height="50" rx="12" fill="var(--accent-wash)"/>
  <text x="825" y="52" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">HyperFrames — visual_N.mp4</text>
  <text x="610" y="100" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">POST /v1/generate (API) or HTML</text>
  <text x="610" y="124" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Input: visual_description + duration</text>
  <text x="610" y="148" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Resolution: 1080x1920 (9:16 Shorts)</text>
  <text x="610" y="172" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Output: visual_1.mp4, visual_2.mp4 ...</text>
  <text x="610" y="200" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Time: 3-8 minutes (slowest step)</text>
  <rect x="610" y="222" width="420" height="36" rx="8" fill="var(--accent-wash)"/>
  <text x="820" y="245" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Open Source · Apache 2.0 · No seat limits</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้งสองอ่าน script.json แล้ว output ชื่อ audio_N / visual_N — FFmpeg merge ใน step ถัดไปจับคู่ด้วย ID เดียวกัน</div>

<!-- Speaker: ถ้า batch ใหญ่ สามารถรัน ElevenLabs และ HyperFrames parallel กัน -->

---

## Step 6-7: FFmpeg Merge แล้ว Upload YouTube

<p class="subhead">Merge ต่อ segment → concat ทั้งหมด → upload พร้อม metadata</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="40" width="140" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="90" y="68" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">visual_1.mp4</text>
  <text x="90" y="87" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HyperFrames</text>
  <rect x="20" y="120" width="140" height="60" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="90" y="148" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">audio_1.mp3</text>
  <text x="90" y="167" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ElevenLabs</text>
  <path d="M162 70 L210 110" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <path d="M162 150 L210 150" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <polygon points="210,140 228,150 210,160" fill="var(--muted)"/>
  <rect x="228" y="100" width="140" height="60" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="298" y="128" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">merged_1.mp4</text>
  <text x="298" y="147" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ffmpeg -shortest</text>
  <text x="395" y="140" font-size="22" fill="var(--muted)" text-anchor="middle" font-family="system-ui">...</text>
  <rect x="430" y="100" width="140" height="60" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="500" y="128" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">merged_N.mp4</text>
  <text x="500" y="147" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ffmpeg -shortest</text>
  <path d="M572 130 L618 130" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="618,122 636,130 618,138" fill="var(--muted)"/>
  <rect x="636" y="95" width="150" height="70" rx="10" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="711" y="128" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">concat_list.txt</text>
  <text x="711" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ffmpeg -f concat</text>
  <path d="M788 130 L834 130" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="834,122 852,130 834,138" fill="var(--muted)"/>
  <rect x="852" y="80" width="220" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <text x="962" y="124" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">final_video.mp4</text>
  <text x="962" y="148" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">Ready to upload</text>
  <path d="M962 182 L962 220" stroke="var(--success)" stroke-width="2.5" fill="none"/>
  <polygon points="954,220 962,240 970,220" fill="var(--success)"/>
  <rect x="878" y="242" width="168" height="36" rx="8" fill="var(--success)" opacity=".9"/>
  <text x="962" y="265" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">YouTube API upload</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> FFmpeg ทำงานใน &lt;1 นาที — bottleneck ทั้งหมดอยู่ที่ HyperFrames render ก่อนหน้า ไม่ใช่ merge</div>

<!-- Speaker: concat_list.txt คือ text file ที่ FFmpeg ใช้รู้ order ของ clips ที่จะ join -->

---

## YouTube OAuth2: Authorize ครั้งเดียว ใช้ได้เรื่อยๆ

<p class="subhead">token.json เก็บ refresh token — auto-renew ทุกครั้งที่ expired</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="100" width="150" height="56" rx="28" fill="var(--accent)" opacity=".9"/>
  <text x="105" y="132" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">get_credentials()</text>
  <path d="M182 128 L228 128" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="228,120 246,128 228,136" fill="var(--muted)"/>
  <polygon points="330,88 440,128 330,168 220,128" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="330" y="122" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">token.json</text>
  <text x="330" y="140" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">exists?</text>
  <path d="M440 128 L508 128" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="508,120 526,128 508,136" fill="var(--muted)"/>
  <text x="474" y="118" font-size="11" fill="var(--success)" font-family="system-ui" text-anchor="middle">YES</text>
  <rect x="526" y="96" width="160" height="64" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="606" y="122" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Load creds</text>
  <text x="606" y="142" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">auto-refresh if expired</text>
  <path d="M330 168 L330 228" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="322,228 330,246 338,228" fill="var(--muted)"/>
  <text x="348" y="208" font-size="11" fill="var(--danger)" font-family="system-ui">NO</text>
  <rect x="210" y="248" width="240" height="24" rx="6" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="330" y="264" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Browser opens — authorize once</text>
  <path d="M688 128 L748 128" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="748,120 766,128 748,136" fill="var(--muted)"/>
  <rect x="766" y="96" width="150" height="64" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="841" y="122" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">creds.to_json()</text>
  <text x="841" y="142" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">save token.json</text>
  <path d="M916 128 L966 128" stroke="var(--muted)" stroke-width="2" fill="none"/>
  <polygon points="966,120 984,128 966,136" fill="var(--muted)"/>
  <rect x="984" y="96" width="106" height="64" rx="10" fill="var(--success)" opacity=".9"/>
  <text x="1037" y="122" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">videos.insert()</text>
  <text x="1037" y="142" font-size="11" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">youtu.be/ID</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ Credentials.to_json() สำหรับ token storage — JSON format ปลอดภัยกว่า binary serialization และ inspect ด้วย text editor ได้</div>

<!-- Speaker: Quota = 10,000 units/วัน free, upload 1 video = ~1,600 units → ได้ ~6 คลิป/วัน -->

---

## Step 8: Claude Skill = Pipeline ใน 1 Command

<p class="subhead">.claude/skills/ เป็น slash command ที่ expand เป็น full prompt — ไม่ต้องจำ steps</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="440" height="240" rx="12" fill="#0f172a"/>
  <rect x="30" y="30" width="440" height="40" rx="12" fill="#1e293b"/>
  <circle cx="58" cy="50" r="7" fill="#dc2626" opacity=".8"/>
  <circle cx="78" cy="50" r="7" fill="#f59e0b" opacity=".8"/>
  <circle cx="98" cy="50" r="7" fill="#16a34a" opacity=".8"/>
  <text x="60" y="96" font-size="13" fill="#94a3b8" font-family="system-ui,monospace">$ claude</text>
  <text x="60" y="120" font-size="13" fill="#e2e8f0" font-family="system-ui,monospace">/generate-short \</text>
  <text x="60" y="140" font-size="13" fill="#e2e8f0" font-family="system-ui,monospace">  topic="10 ways to use AI" \</text>
  <text x="60" y="160" font-size="13" fill="#e2e8f0" font-family="system-ui,monospace">  privacy="unlisted"</text>
  <text x="60" y="196" font-size="12" fill="#94a3b8" font-family="system-ui,monospace">Generating script...</text>
  <text x="60" y="216" font-size="12" fill="#94a3b8" font-family="system-ui,monospace">Creating audio (ElevenLabs)...</text>
  <text x="60" y="236" font-size="12" fill="#94a3b8" font-family="system-ui,monospace">Rendering visuals (HyperFrames)...</text>
  <path d="M478 150 L524 150" stroke="var(--muted)" stroke-width="2.5" fill="none"/>
  <polygon points="524,142 542,150 524,158" fill="var(--muted)"/>
  <rect x="548" y="30" width="520" height="240" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="548" y="30" width="520" height="44" rx="12" fill="var(--accent)" opacity=".9"/>
  <text x="808" y="58" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">.claude/skills/generate-short.md</text>
  <text x="575" y="98" font-size="12" fill="var(--ink-dim)" font-family="system-ui,monospace">name: generate-short</text>
  <text x="575" y="118" font-size="12" fill="var(--ink-dim)" font-family="system-ui,monospace">description: End-to-end video pipeline</text>
  <rect x="570" y="130" width="480" height="2" rx="1" fill="var(--soft-2)"/>
  <text x="575" y="154" font-size="12" fill="var(--ink)" font-family="system-ui">1. Generate script.json with Claude</text>
  <text x="575" y="174" font-size="12" fill="var(--ink)" font-family="system-ui">2. Run audio_gen.py (ElevenLabs)</text>
  <text x="575" y="194" font-size="12" fill="var(--ink)" font-family="system-ui">3. Run visual_gen.py (HyperFrames)</text>
  <text x="575" y="214" font-size="12" fill="var(--ink)" font-family="system-ui">4. Run merge.py (FFmpeg)</text>
  <text x="575" y="234" font-size="12" fill="var(--success)" font-family="system-ui">5. Upload to YouTube — return URL</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Skill file เป็น "macro" — เปลี่ยน topic เดียวแล้วรันได้ทุกคลิป โดยไม่ต้องจำลำดับ 8 ขั้นตอน</div>

<!-- Speaker: เปรียบกับ Makefile แต่ใช้ภาษาธรรมดาแทน command syntax -->

---

## Caveats: สิ่งที่ต้องรู้ก่อนใช้ Production

<p class="subhead">Limits และ gotchas ของแต่ละ component — ป้องกันได้ล่วงหน้า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card warning">
    <p class="label">HyperFrames</p>
    <h3>Node.js >= 22</h3>
    <p>เวอร์ชันเก่าไม่รองรับ — ใช้ npx hyperframes doctor ตรวจสอบ env ก่อน render</p>
    <p>CSS animations หนักทำให้ frame capture ไม่สม่ำเสมอ</p>
  </div>
  <div class="card">
    <p class="label">ElevenLabs</p>
    <h3>10,000 chars/mo</h3>
    <p>Free tier หมดเร็ว — ทดสอบ Thai voice model ก่อน production</p>
    <p>Paid: $5+/mo สำหรับ 30,000 chars</p>
  </div>
  <div class="card">
    <p class="label">YouTube API</p>
    <h3>~6 uploads/day</h3>
    <p>Free: 10,000 units/วัน</p>
    <p>1 upload = ~1,600 units</p>
    <p>Shorts: #Shorts + 9:16 + &lt;= 60s ต้องครบ</p>
  </div>
  <div class="card danger">
    <p class="label">Security</p>
    <h3>Secrets ใน .gitignore</h3>
    <p>.env, client_secrets.json, token.json ต้องอยู่ใน .gitignore เสมอ — ไม่มีข้อยกเว้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตรวจ .gitignore ก่อน git add ทุกครั้ง — secret ที่ leak เข้า git history แก้ยากกว่าที่คิดมาก</div>

<!-- Speaker: ถ้าต้องการ > 6 uploads/day ให้ขอ quota increase จาก Google Cloud Console -->

---

## Key Takeaways

<p class="subhead">จาก 2 ชั่วโมง manual → 10 นาที automated</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Core Insight</p>
    <h3>HTML คือ video format สำหรับ AI</h3>
    <p>Claude เขียน HTML ได้ดีกว่า generate pixels — HyperFrames ใช้จุดแข็งนั้นตรงๆ ทำให้ output deterministic</p>
  </div>
  <div class="card">
    <p class="label">Architecture</p>
    <h3>4 Steps, แต่ละ Step Replaceable</h3>
    <p>ElevenLabs, HyperFrames, FFmpeg, YouTube API — ทำงานอิสระ แทนที่ได้ทีละตัวโดยไม่กระทบส่วนอื่น</p>
  </div>
  <div class="card">
    <p class="label">Automation</p>
    <h3>1 Skill = 1 Command</h3>
    <p>/generate-short topic="..." รัน 5 ขั้นตอนอัตโนมัติ ไม่ต้องจำ syntax แต่ละ tool</p>
  </div>
  <div class="card warning">
    <p class="label">Shorts Rules</p>
    <h3>3 เงื่อนไข YouTube Shorts</h3>
    <p>9:16 vertical + &lt;= 60s + #Shorts ใน title/description ต้องครบทั้ง 3 เข้า Shorts algorithm</p>
  </div>
  <div class="card">
    <p class="label">Cost</p>
    <h3>&lt; $0.10 per clip</h3>
    <p>Free tier ของทุก service รองรับ 6+ clips/day โดยไม่มีค่าใช้จ่ายเพิ่ม</p>
  </div>
  <div class="card danger">
    <p class="label">Always</p>
    <h3>.gitignore Secrets</h3>
    <p>.env + client_secrets.json + token.json ต้องไม่เข้า git repo ไม่ว่าจะเกิดอะไรขึ้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ลอง npx hyperframes init my-shorts ตอนนี้เลย — setup ครั้งแรก 15 นาที คลิปที่ 2 เป็นต้นไปใช้เวลา &lt; 10 นาที</div>

<!-- Speaker: ปิดด้วย CTA — ลอง init project แล้วรัน pipeline ดู ไม่ต้องรอ setup ทุกอย่างครบก็ได้ -->
