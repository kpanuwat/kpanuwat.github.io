---
marp: true
theme: default
paginate: true
title: "เจาะลึก Google Flow 2.0: AI Agent, Characters และ Flow Tools"
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

# Google Flow 2.0

<p class="tag">AI Agent · Characters · Flow Tools — ปฏิวัติการสร้างวิดีโอด้วย AI ครบวงจร</p>

<!-- Speaker: Google I/O 2026 — Flow ยกระดับจาก clip generator สู่ AI filmmaking platform เต็มรูปแบบ -->

---

## 3 ฟีเจอร์ที่เปลี่ยน Google Flow ให้เป็น Filmmaking Platform

<p class="subhead">แต่ละฟีเจอร์แก้ pain point จริงของ AI video creators</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Multi-step Automation</p>
    <h3>Flow Agent</h3>
    <p>Creative partner ที่ plan, reason, และ execute งานซับซ้อนได้ — จาก script เดียวสร้าง explainer video ทั้งชุด</p>
  </div>
  <div class="card success">
    <p class="label">Character Consistency</p>
    <h3>Characters</h3>
    <p>ล็อค visual identity + เสียงตัวละครไว้ใน project — ทุก scene ใช้หน้า เสียง ชุด เดิมโดยอัตโนมัติ</p>
  </div>
  <div class="card gold">
    <p class="label">No-Code Tooling</p>
    <h3>Flow Tools</h3>
    <p>สร้างเครื่องมือเฉพาะทางด้วยภาษาธรรมดา — publish ขึ้น community library ให้คนอื่น remix ได้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent + Characters + Flow Tools = end-to-end AI filmmaking pipeline ครั้งแรกใน Google Flow</div>

<!-- Speaker: ทั้ง 3 ฟีเจอร์แก้ 3 ปัญหาต่างกัน — ไม่ใช่ upgrade แต่ละอัน แต่เป็น platform shift -->

---

## Before vs After: AI Video ก่อนและหลัง Flow 2.0

<p class="subhead">Flow 2.0 แก้ปัญหาระดับ structural ที่ prompt engineering ทำไม่ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="10" width="470" height="295" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="30" y="10" width="470" height="50" rx="12" fill="var(--soft)"/>
  <text x="265" y="41" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Before Flow 2.0</text>
  <text x="65" y="92" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Character faces drift between scenes</text>
  <text x="65" y="123" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Voice mismatches — no persistence</text>
  <text x="65" y="154" font-size="13" fill="var(--ink-dim)" font-family="system-ui">10-second clips only, manual stitching</text>
  <text x="65" y="185" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Complex re-engineering per scene</text>
  <text x="65" y="216" font-size="13" fill="var(--ink-dim)" font-family="system-ui">No community tooling</text>
  <text x="65" y="265" font-size="12" fill="var(--muted)" font-family="system-ui,sans-serif" font-style="italic">Professional long-form AI video = impossible</text>
  <rect x="600" y="10" width="470" height="295" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.12))"/>
  <rect x="600" y="10" width="470" height="50" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="835" y="41" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">With Flow 2.0</text>
  <text x="638" y="92" font-size="13" fill="var(--ink)" font-family="system-ui">Characters locked: face + voice per-project</text>
  <text x="638" y="123" font-size="13" fill="var(--ink)" font-family="system-ui">Agent orchestrates multi-step tasks</text>
  <text x="638" y="154" font-size="13" fill="var(--ink)" font-family="system-ui">Full script to long-form, fully automated</text>
  <text x="638" y="185" font-size="13" fill="var(--ink)" font-family="system-ui">Cast characters with one prompt reference</text>
  <text x="638" y="216" font-size="13" fill="var(--ink)" font-family="system-ui">Flow Tools: no-code custom tools + community</text>
  <text x="638" y="265" font-size="12" fill="var(--success)" font-family="system-ui,sans-serif" font-style="italic">Pro-quality AI filmmaking, accessible to all</text>
  <circle cx="548" cy="158" r="26" fill="var(--accent)"/>
  <text x="548" y="163" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Flow 2.0 ยกระดับจาก "AI clip generator" สู่ "AI filmmaking platform" ด้วย 3 ฟีเจอร์พร้อมกัน</div>

<!-- Speaker: ชี้ให้เห็น before/after ชัดๆ — Flow 2.0 ไม่ได้แค่ improve แต่เปลี่ยน paradigm -->

---

## Flow Agent: Creative Partner ที่ Plan และ Execute งานซับซ้อน

<p class="subhead">Agent ทำงานใน side panel — ground ไว้กับ project context โดยเฉพาะ ไม่ใช่ general AI</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Multi-Asset Generation</p>
    <h3>สร้างพร้อมกันหลายชิ้น</h3>
    <p>สร้าง 3 ภาพต่าง style ในคำสั่งเดียว, แปลง image to video อัตโนมัติ, batch edit ข้ามทุก assets</p>
  </div>
  <div class="card warning">
    <p class="label">Credit Approval</p>
    <h3>Manual Approve เสมอ</h3>
    <p>Agent ถามก่อน generate ทุกครั้ง — ปิด Auto-Approve ไว้จน comfortable; video = 15 credits/clip</p>
  </div>
  <div class="card success">
    <p class="label">Storytelling Partner</p>
    <h3>Sounding Board สำหรับ Story</h3>
    <p>เสนอ plot twist, รับ dialogue, suggest scene pacing — เหมือนมี creative director ใน project</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Flow Agent ฟรีสำหรับผู้ใช้ทุกคน — ใช้ได้ทันทีโดยไม่ต้อง subscribe</div>

<!-- Speaker: เน้น Agent ไม่ใช่แค่ chatbot — มัน plan และ execute ได้ด้วย; ปิด Auto-Approve ไว้เสมอในช่วงแรก -->

---

## Explainer Video จาก Script: Agent ทำทุกขั้นตอน

<p class="subhead">Gemini Omni Flash generate ได้แค่ ~10 วินาที/คลิป — Agent ทลาย limit นั้นด้วย scene stitching</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr5" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="var(--accent)"/>
    </marker>
  </defs>
  <rect x="30" y="80" width="210" height="110" rx="12" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="2"/>
  <text x="135" y="123" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Script</text>
  <text x="135" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Full text or</text>
  <text x="135" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">numbered scenes</text>
  <line x1="242" y1="135" x2="275" y2="135" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr5)"/>
  <rect x="278" y="80" width="210" height="110" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="383" y="123" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Scene Split</text>
  <text x="383" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Agent breaks into</text>
  <text x="383" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">individual scenes</text>
  <line x1="490" y1="135" x2="523" y2="135" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr5)"/>
  <rect x="526" y="80" width="210" height="110" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="631" y="123" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">3. Generate</text>
  <text x="631" y="146" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Each scene to</text>
  <text x="631" y="163" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">~10s video clip</text>
  <line x1="738" y1="135" x2="771" y2="135" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr5)"/>
  <rect x="774" y="68" width="290" height="134" rx="12" fill="var(--accent)" stroke="var(--accent)" stroke-width="2"/>
  <text x="919" y="116" font-size="15" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4. Long-Form Video</text>
  <text x="919" y="141" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Agent stitches all scenes</text>
  <text x="919" y="160" font-size="12" fill="var(--paper)" text-anchor="middle" font-family="system-ui">— fully automated output</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ป้อน script เต็ม → Agent ทำทุกขั้นตอน — ไม่ต้องแบ่ง scene หรือ stitch ด้วยตัวเอง</div>

<!-- Speaker: นี่คือ use case ที่เปลี่ยน game — สำหรับ content creators ที่ต้องการ explainer video ยาวๆ -->

---

## Characters: ล็อค Identity ตัวละครทุก Scene

<p class="subhead">Gemini Omni Flash เรียนรู้ face embedding — รักษา identity ใน latent space ไม่ใช่แค่ copy pixel</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="10" width="470" height="275" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(220,38,38,.08))"/>
  <rect x="30" y="10" width="470" height="48" rx="12" fill="var(--danger-wash)"/>
  <text x="265" y="39" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Without Characters Feature</text>
  <text x="65" y="89" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Scene 1: Brown hair, blue jacket</text>
  <text x="65" y="118" font-size="13" fill="var(--danger)" font-family="system-ui">Scene 2: Black hair, different face shape</text>
  <text x="65" y="147" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Scene 3: Voice pitch changes randomly</text>
  <text x="65" y="176" font-size="13" fill="var(--danger)" font-family="system-ui">Scene 4: Costume completely different</text>
  <text x="65" y="216" font-size="12" fill="var(--muted)" font-family="system-ui">Requires re-engineering every prompt</text>
  <text x="65" y="255" font-size="12" fill="var(--danger-ink)" font-family="system-ui,sans-serif" font-style="italic">Result: No narrative continuity possible</text>
  <rect x="600" y="10" width="470" height="275" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.1))"/>
  <rect x="600" y="10" width="470" height="48" rx="12" fill="var(--success-wash)"/>
  <text x="835" y="39" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">With Characters Feature</text>
  <text x="638" y="89" font-size="13" fill="var(--ink)" font-family="system-ui">Scene 1: Same face, costume locked</text>
  <text x="638" y="118" font-size="13" fill="var(--success)" font-family="system-ui">Scene 2: Same face — different angle</text>
  <text x="638" y="147" font-size="13" fill="var(--ink)" font-family="system-ui">Scene 3: Same custom voice, always</text>
  <text x="638" y="176" font-size="13" fill="var(--success)" font-family="system-ui">Scene 4: Identity held across all clips</text>
  <text x="638" y="216" font-size="12" fill="var(--muted)" font-family="system-ui">Cast with one "Add to Prompt" reference</text>
  <text x="638" y="255" font-size="12" fill="var(--success-ink)" font-family="system-ui,sans-serif" font-style="italic">Result: Professional narrative continuity</text>
  <circle cx="548" cy="152" r="26" fill="var(--accent)"/>
  <text x="548" y="157" font-size="12" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Characters ไม่ใช่แค่ seed image — เป็น latent identity lock ที่รักษา visual + voice ข้าม clip โดยอัตโนมัติ</div>

<!-- Speaker: ปัญหา consistency = #1 pain point ของ AI filmmakers — Characters แก้ได้จริงในระดับ system -->

---

## Characters: ตั้งค่าใน 4 ขั้นตอน

<p class="subhead">ตัวละครที่สร้างแล้ว reuse ได้ทุก scene — ไม่ต้อง describe ซ้ำในทุก prompt</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr7" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="var(--accent)"/>
    </marker>
  </defs>
  <rect x="30" y="75" width="210" height="125" rx="12" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="2"/>
  <text x="135" y="118" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Upload / Generate</text>
  <text x="135" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Photo or text prompt</text>
  <text x="135" y="158" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(face must be visible)</text>
  <line x1="242" y1="138" x2="275" y2="138" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr7)"/>
  <rect x="278" y="75" width="210" height="125" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="383" y="118" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2. Assign Voice</text>
  <text x="383" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Base voice + describe</text>
  <text x="383" y="158" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">age, accent, tone</text>
  <line x1="490" y1="138" x2="523" y2="138" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr7)"/>
  <rect x="526" y="75" width="210" height="125" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="631" y="118" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">3. Save Character</text>
  <text x="631" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Name stored in</text>
  <text x="631" y="158" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">project library</text>
  <line x1="738" y1="138" x2="771" y2="138" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#arr7)"/>
  <rect x="774" y="62" width="290" height="151" rx="12" fill="var(--accent)" stroke="var(--accent)" stroke-width="2"/>
  <text x="919" y="110" font-size="14" font-weight="700" fill="var(--paper)" text-anchor="middle" font-family="system-ui">4. Add to Prompt</text>
  <text x="919" y="133" font-size="11" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Click character name</text>
  <text x="919" y="151" font-size="11" fill="var(--paper)" text-anchor="middle" font-family="system-ui">in any scene prompt</text>
  <text x="919" y="172" font-size="11" fill="var(--accent-wash)" text-anchor="middle" font-family="system-ui">Visual + voice auto-locked</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งค่าครั้งเดียว — ทุก scene หลังจากนั้นล็อค face + voice อัตโนมัติโดยไม่ต้อง describe ซ้ำ</div>

<!-- Speaker: เน้น step 4 — "Add to Prompt" คือ casting mechanism ที่ binding identity ทั้งหมด -->

---

## Flow Tools: Build, Publish, Remix — ไม่ต้องเขียน Code

<p class="subhead">อธิบายสิ่งที่ต้องการด้วยภาษาธรรมดา → Flow สร้าง tool ให้ → publish ให้ community ใช้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Community Tool</p>
    <h3>pixelBento</h3>
    <p>ใส่ lo-fi + glitch aesthetics ให้ภาพ — เหมาะสำหรับ retro / analog look โดยไม่ต้อง edit เอง</p>
  </div>
  <div class="card success">
    <p class="label">Community Tool</p>
    <h3>Simple Sketch Tool</h3>
    <p>วาด rough sketch บน canvas → แปลงเป็น generated image คุณภาพสูงอัตโนมัติ</p>
  </div>
  <div class="card gold">
    <p class="label">Community Tool</p>
    <h3>Image Editor Tool</h3>
    <p>ปรับ color grading + เพิ่ม 3D depth-aware text layers ที่ซ่อนอยู่หลัง foreground objects</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ community tools ฟรี — สร้าง/remix tools เองต้อง Google AI subscription</div>

<!-- Speaker: Flow Tools คือ "app store" สำหรับ AI creative workflows — community-driven, no-code, shareable -->

---

## Gemini Omni Flash: Multimodal Engine ขับเคลื่อนทุกฟีเจอร์

<p class="subhead">Model ที่รับ input ทุกรูปแบบ — เปิดให้ Flow Agent, Characters, และ Flow Music ทำงานได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="160" r="78" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="550" cy="160" r="52" fill="var(--accent)" opacity=".2"/>
  <text x="550" y="151" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Gemini</text>
  <text x="550" y="171" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Omni Flash</text>
  <line x1="485" y1="115" x2="370" y2="68" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="200" y="28" width="172" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="286" y="61" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Any Input</text>
  <text x="286" y="82" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Text / Image / Video</text>
  <line x1="485" y1="205" x2="370" y2="252" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="200" y="210" width="172" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="286" y="243" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Flow Video</text>
  <text x="286" y="264" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Agent + Characters</text>
  <line x1="615" y1="205" x2="730" y2="252" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="728" y="210" width="172" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="814" y="243" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Flow Music</text>
  <text x="814" y="264" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Music video direction</text>
  <line x1="615" y1="115" x2="730" y2="68" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="728" y="28" width="172" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="814" y="61" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Conversational</text>
  <text x="814" y="82" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Iterate via chat</text>
  <rect x="430" y="252" width="240" height="48" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="550" y="272" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui" font-weight="700">Limit: ~10 sec per clip</text>
  <text x="550" y="290" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Use Agent stitching for long-form</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Gemini Omni Flash ต้อง Google AI subscription — ขับเคลื่อนทั้ง Flow Video และ Flow Music จากแหล่งเดียวกัน</div>

<!-- Speaker: Omni Flash เป็น core model — ไม่ใช่ tool ไม่ใช่ feature แต่เป็น engine ของทุกอย่าง -->

---

## Access Tiers: ฟรี vs Google AI Subscription

<p class="subhead">3 ฟีเจอร์หลักใช้ได้ฟรี — Gemini Omni Flash และ tool creation ต้อง subscribe</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="10" width="470" height="278" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="30" y="10" width="470" height="50" rx="12" fill="var(--soft)"/>
  <text x="265" y="41" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Free — All Users</text>
  <text x="65" y="92" font-size="13" fill="var(--success)" font-family="system-ui">Flow Agent (all capabilities)</text>
  <text x="65" y="122" font-size="13" fill="var(--success)" font-family="system-ui">Characters feature</text>
  <text x="65" y="152" font-size="13" fill="var(--success)" font-family="system-ui">Flow Tools — use community tools</text>
  <text x="65" y="182" font-size="13" fill="var(--muted)" font-family="system-ui">Mobile app (Android beta / iOS soon)</text>
  <text x="65" y="225" font-size="12" fill="var(--muted)" font-family="system-ui">Uses generation credits (quota applies)</text>
  <text x="65" y="255" font-size="12" fill="var(--muted)" font-family="system-ui">Older generation model on free tier</text>
  <rect x="600" y="10" width="470" height="278" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.12))"/>
  <rect x="600" y="10" width="470" height="50" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="835" y="41" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Google AI Subscription</text>
  <text x="638" y="92" font-size="13" fill="var(--ink)" font-family="system-ui">Everything in Free, plus:</text>
  <text x="638" y="122" font-size="13" fill="var(--accent)" font-family="system-ui">Gemini Omni Flash model access</text>
  <text x="638" y="152" font-size="13" fill="var(--accent)" font-family="system-ui">Create + remix custom Flow Tools</text>
  <text x="638" y="182" font-size="13" fill="var(--accent)" font-family="system-ui">Higher generation credit limits</text>
  <text x="638" y="212" font-size="13" fill="var(--accent)" font-family="system-ui">Priority access to new features</text>
  <text x="638" y="255" font-size="12" fill="var(--muted)" font-family="system-ui">18+ users only (mobile + web)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent + Characters ฟรีสำหรับทุกคน — Gemini Omni Flash (คุณภาพสูงสุด) ต้อง Google AI subscription</div>

<!-- Speaker: Free tier ยัง powerful มาก — Subscription ต่างกันที่ model quality และ tool creation -->

---

## Caveats and Limits: สิ่งที่ต้องรู้ก่อนใช้

<p class="subhead">Plan workflow รอบ limits เหล่านี้ก่อน เพื่อหลีกเลี่ยงปัญหาและค่าใช้จ่ายที่ไม่คาดคิด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Model Limit</p>
    <h3>~10 วินาที/คลิป</h3>
    <p>Gemini Omni Flash ผลิต ~10 วินาทีต่อ generation — ต้องใช้ Agent stitching สำหรับวิดีโอยาว</p>
  </div>
  <div class="card danger">
    <p class="label">Credit Risk</p>
    <h3>Auto-Approve อันตราย</h3>
    <p>เมื่อเปิด Auto-Approve Agent สามารถเผาผลาญ credits เร็วมาก — ใช้ Manual Approve เสมอในช่วงแรก</p>
  </div>
  <div class="card warning">
    <p class="label">Character Constraint</p>
    <h3>Face ต้องเห็นชัด</h3>
    <p>ภาพตัวละครที่ใส่หมวก มาสก์ หรือหน้าบดบัง — ระบบ track face embedding ไม่ได้ผล</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ปิด Auto-Approve, ตรวจหน้าตัวละครชัดเจน, ใช้ Agent stitching — หลีกเลี่ยงค่าใช้จ่ายเกินโดยง่าย</div>

<!-- Speaker: Limits เหล่านี้แก้ได้ทั้งหมดถ้า plan ล่วงหน้า — ไม่ใช่ blocker แต่เป็น workflow consideration -->

---

## Key Takeaways: Google Flow 2.0 ในภาพรวม

<p class="subhead">สิ่งที่ content creators และนักพัฒนาต้องจำจาก update นี้</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Platform Shift</p>
    <h3>AI Clip to AI Filmmaking Platform</h3>
    <p>Agent + Characters + Flow Tools รวมกันเป็น end-to-end pipeline — paradigm shift ไม่ใช่แค่ feature update</p>
  </div>
  <div class="card success">
    <p class="label">Solved Problem</p>
    <h3>Character Consistency แก้แล้ว</h3>
    <p>latent space identity lock ทำให้ professional narrative AI video เป็นไปได้จริงครั้งแรก</p>
  </div>
  <div class="card gold">
    <p class="label">No-Code Power</p>
    <h3>Community Tooling Open</h3>
    <p>Flow Tools ecosystem เปิดให้ทุกคนสร้างและ share เครื่องมือ — กำลังจะเป็น creator's app store</p>
  </div>
  <div class="card warning">
    <p class="label">Cost Awareness</p>
    <h3>Credits + Subscription Plan</h3>
    <p>Agent ฟรี, Omni Flash ต้อง subscribe, Auto-Approve เผา credits — วาง budget ล่วงหน้า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทดลอง Flow Agent + Characters ฟรีได้เลยที่ labs.google/fx/tools/flow — เริ่มจาก Manual Approve เสมอ</div>

<!-- Speaker: ปิดด้วย action — ไปทดลองได้ทันที ฟีเจอร์หลักฟรีทั้งหมด -->
