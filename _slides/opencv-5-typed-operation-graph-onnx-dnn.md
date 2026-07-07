---
marp: true
theme: default
paginate: true
title: "OpenCV 5: Typed Operation Graph"
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
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/opencv-5-typed-operation-graph-onnx-dnn-cover.png)

<div class="mark"></div>

# OpenCV 5: Typed Operation Graph

<p class="tag">DNN engine ยกเครื่องใหม่ทั้งหมด — ONNX coverage 22% → 80%+, รัน YOLO/LDM/VLM ได้ native, เร็วกว่า ONNX Runtime บน CPU</p>

<!-- Speaker: OpenCV 5 คือ major release แรกตั้งแต่ปี 2018 หัวใจคือ DNN module ที่เขียนใหม่ทั้งหมด. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/opencv-5-typed-operation-graph-onnx-dnn-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้ง 6 concept หลักของ deck นี้ — ใช้เวลา 60 วิ ปูพื้นก่อนเข้ารายละเอียด. -->

---

## TL;DR: การยกเครื่องที่ใหญ่ที่สุดตั้งแต่ปี 2018

<p class="subhead">OpenCV 5 เปลี่ยน DNN engine ทั้งระบบ ปิดช่องว่าง ONNX ที่ค้างมา 8 ปี</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card gold">
    <p class="label">Architecture</p>
    <h3>Typed Operation Graph</h3>
    <p>วิเคราะห์ทั้งกราฟก่อนรัน แทน layer-by-layer แบบเดิม</p>
  </div>
  <div class="card success">
    <p class="label">Coverage</p>
    <h3>ONNX 22% → 80%+</h3>
    <p>รันโมเดลสมัยใหม่ได้โดยไม่เจอ operator ที่ไม่รองรับ</p>
  </div>
  <div class="card">
    <p class="label">Performance</p>
    <h3>เร็วกว่า ONNX Runtime</h3>
    <p>+11.5% บน YOLOv8n, สูงสุด +36.6% บน OWLv2 (CPU)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ใช่แค่ patch เพิ่ม operator — เป็นการเขียน DNN engine ใหม่ทั้งหมด.</div>

<!-- Speaker: เกริ่นภาพรวม 3 แกนหลักก่อนลงรายละเอียดแต่ละส่วน. -->

---

## แปดปีที่ค้างอยู่บน OpenCV 4.x กับกำแพง ONNX 22%

![bg right:40% contain](assets/opencv-5-typed-operation-graph-onnx-dnn-background.png)

<p class="subhead">Engine เดิมประมวลผลแบบ layer-by-layer ตามโมเดลยุคใหม่ไม่ทัน</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="640" height="70" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="60" y="72" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">OpenCV 4.x (2018–2026)</text>
  <text x="560" y="72" font-size="15" fill="var(--danger)" text-anchor="end" font-family="system-ui">~8 years</text>
  <rect x="30" y="130" width="640" height="70" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="60" y="172" font-size="16" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">ONNX operator coverage</text>
  <text x="560" y="172" font-size="22" font-weight="800" fill="var(--danger-ink)" text-anchor="end" font-family="system-ui">22%</text>
  <rect x="30" y="230" width="640" height="60" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="350" y="266" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Load model → hit unsupported operator → stuck</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> transformer / dynamic-shape models เจอ operator wall เดิมบ่อยเกินไป — ต้องเขียน engine ใหม่ ไม่ใช่ patch เพิ่ม.</div>

<!-- Speaker: เซ็ตอัพปัญหาก่อนเข้า architecture ใหม่. -->

---

## Typed Operation Graph: จาก Layer-by-Layer สู่ Whole-Graph Analysis

<p class="subhead">Engine ใหม่วิเคราะห์ทั้งกราฟก่อนรัน เปิดทาง optimization ที่ engine เดิมทำไม่ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="30" width="980" height="70" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="90" y="72" font-size="16" font-weight="700" fill="var(--muted)" font-family="system-ui">OpenCV 4.x: layer → layer → layer (sequential)</text>
  <text x="550" y="150" font-size="24" fill="var(--accent)" text-anchor="middle" font-family="system-ui">↓</text>
  <rect x="60" y="180" width="220" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="170" y="220" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Shape</text>
  <text x="170" y="240" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Inference</text>
  <rect x="300" y="180" width="220" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="410" y="220" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Constant</text>
  <text x="410" y="240" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Folding</text>
  <rect x="540" y="180" width="220" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="650" y="220" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Operator</text>
  <text x="650" y="240" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Fusion</text>
  <rect x="780" y="180" width="260" height="160" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="910" y="220" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Unified Memory</text>
  <text x="910" y="240" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Buffer Pool</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วิเคราะห์ทั้งกราฟก่อนรัน = fuse MatMul+Softmax+attention เป็น single pass, reuse memory ข้าม operator.</div>

<!-- Speaker: เจาะรายละเอียด 4 ความสามารถที่เกิดจาก whole-graph analysis. -->

---

## ONNX Operator Coverage: จาก 22% สู่ 80%+

<p class="subhead">การกระโดดครั้งนี้ปิดกำแพงที่ทำให้โมเดลสมัยใหม่โหลดไม่ผ่าน</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="60" y="60" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">OpenCV 4.x</text>
  <rect x="220" y="35" width="800" height="40" rx="8" fill="var(--soft-2)"/>
  <rect x="220" y="35" width="176" height="40" rx="8" fill="var(--danger)"/>
  <text x="410" y="62" font-size="16" font-weight="800" fill="var(--paper)" font-family="system-ui">22%</text>
  <text x="60" y="160" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">OpenCV 5.0</text>
  <rect x="220" y="135" width="800" height="40" rx="8" fill="var(--soft-2)"/>
  <rect x="220" y="135" width="640" height="40" rx="8" fill="var(--success)"/>
  <text x="840" y="162" font-size="16" font-weight="800" fill="var(--paper)" font-family="system-ui">80%+</text>
  <rect x="60" y="230" width="480" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="90" y="266" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Dynamic / symbolic shapes</text>
  <text x="90" y="296" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Input shape ไม่ fix ตอน compile</text>
  <rect x="560" y="230" width="480" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="590" y="266" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">If / Loop subgraphs</text>
  <text x="590" y="296" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Control-flow สำหรับ quantized models</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่เจอ "operator not supported" กลางทางเวลาโหลดโมเดลสมัยใหม่เข้า pipeline อีกต่อไป.</div>

<!-- Speaker: ตัวเลขนี้คือหัวใจของ release — เน้นย้ำก่อนเข้าเรื่อง model support. -->

---

## รันโมเดลสมัยใหม่แบบ Native: YOLO, LDM, VLM/LLM

<p class="subhead">ไม่ต้องพึ่ง PyTorch หรือ ONNX Runtime เป็นตัวกลางอีกต่อไป</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">YOLO</p>
    <h3>YOLOv8, YOLOX-S</h3>
    <p>Real-time object detection แบบ native เร็วกว่า ONNX Runtime บน CPU</p>
  </div>
  <div class="card gold">
    <p class="label">LDM</p>
    <h3>LaMa Inpainting</h3>
    <p>Object removal แบบ single forward pass, iterative denoise บน CPU ตรง</p>
  </div>
  <div class="card success">
    <p class="label">VLM / LLM</p>
    <h3>Qwen 2.5, Gemma 3, GPT</h3>
    <p>รันผ่าน Net API เดียวกัน — built-in tokenizer + KV-cache สำหรับ autoregressive decoding</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Built-in tokenizer + KV-cache ในตัว engine เอง = OpenCV ก้าวจาก "image library" สู่ multi-modal inference runtime.</div>

<!-- Speaker: ย้ำว่าทั้ง 3 กลุ่มโมเดลรันผ่าน Net API เดียวกัน ไม่ต้องมี dependency แยก. -->

---

## Performance: ชนะ ONNX Runtime บน CPU

<p class="subhead">Benchmark บน Intel Core i9-14900KS (Ubuntu 24.04 LTS) — engine ใหม่ยังไม่มี GPU แต่ CPU แข่งตรงได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="60" y="50" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">YOLOv8n</text>
  <rect x="220" y="28" width="800" height="34" rx="6" fill="var(--soft-2)"/>
  <rect x="220" y="28" width="92" height="34" rx="6" fill="var(--accent)"/>
  <text x="330" y="51" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">+11.5%</text>
  <text x="60" y="150" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">DINOv2</text>
  <rect x="220" y="128" width="800" height="34" rx="6" fill="var(--soft-2)"/>
  <rect x="220" y="128" width="195" height="34" rx="6" fill="var(--accent)"/>
  <text x="435" y="151" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">+24.4%</text>
  <text x="60" y="250" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">OWLv2</text>
  <rect x="220" y="228" width="800" height="34" rx="6" fill="var(--soft-2)"/>
  <rect x="220" y="228" width="293" height="34" rx="6" fill="var(--success)"/>
  <text x="533" y="251" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">+36.6%</text>
  <text x="60" y="330" font-size="13" fill="var(--muted)" font-family="system-ui">Faster than ONNX Runtime, native OpenCV 5 DNN engine, CPU-only</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> YOLOv8n 10.9ms vs ONNX Runtime 12.15ms — CPU-only engine ยังชนะ runtime ที่ optimize มาอย่างหนักแล้ว.</div>

<!-- Speaker: ตัวเลขมาจาก hardware เฉพาะ เตือนผู้ฟังเรื่อง benchmark variance ตาม hardware. -->

---

## C++17 Baseline และการตัด Legacy C API

<p class="subhead">เขย่าหนี้เทคนิคที่สะสมมาตั้งแต่ยุค OpenCV 1.x–3.x</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="40" y="20" width="490" height="56" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="285" y="54" font-size="17" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OpenCV 4.x</text>
  <text x="80" y="115" font-size="15" fill="var(--ink)" font-family="system-ui">Legacy C API present</text>
  <text x="80" y="150" font-size="15" fill="var(--ink-dim)" font-family="system-ui">CvMat, cvCreateMat still work</text>
  <text x="80" y="185" font-size="15" fill="var(--muted)" font-family="system-ui">Python 2 + 3 bindings</text>
  <rect x="570" y="20" width="490" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="570" y="20" width="490" height="56" rx="12" fill="var(--accent)" opacity=".08"/>
  <text x="815" y="54" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">OpenCV 5.0</text>
  <text x="610" y="115" font-size="15" fill="var(--ink)" font-family="system-ui">C++17 minimum baseline</text>
  <text x="610" y="150" font-size="15" fill="var(--ink)" font-family="system-ui">Legacy C API removed entirely</text>
  <text x="610" y="185" font-size="15" fill="var(--ink)" font-family="system-ui">Python 3.6+ only</text>
  <circle cx="550" cy="190" r="28" fill="var(--accent)"/>
  <text x="550" y="195" font-size="13" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">→</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Breaking change — codebase ที่ยังใช้ CvMat/cvCreateMat ต้อง port ก่อน upgrade เป็น 5.0.</div>

<!-- Speaker: เตือนว่า upgrade ไม่ใช่แค่เปลี่ยนเลขเวอร์ชัน ต้องวางแผน migration. -->

---

## Caveats: สิ่งที่ต้องรู้ก่อน Upgrade

<p class="subhead">4 ข้อจำกัดที่ทีมต้องเช็คก่อนย้ายไป production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card warning compact">
    <p class="label">GPU</p>
    <h3>CPU-only</h3>
    <p>GPU support ยังไม่มา รอ release ถัดไป</p>
  </div>
  <div class="card danger compact">
    <p class="label">Breaking</p>
    <h3>C API หายหมด</h3>
    <p>CvMat/cvCreateMat ต้อง port ก่อน</p>
  </div>
  <div class="card warning compact">
    <p class="label">Toolchain</p>
    <h3>ต้อง C++17+</h3>
    <p>compiler เก่าเกินไป build ไม่ผ่าน</p>
  </div>
  <div class="card compact">
    <p class="label">Engine Modes</p>
    <h3>4 โหมดเลือกได้</h3>
    <p>classic / graph / auto-fallback / ORT wrapper</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทดสอบทั้ง 4 engine mode ก่อนเลือก production — benchmark ตัวเลขมาจาก hardware เฉพาะ อาจต่างบนเครื่องอื่น.</div>

<!-- Speaker: ปิดด้วยข้อจำกัด ก่อนสรุป key takeaways. -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำแม้ข้ามเนื้อหาส่วนอื่นไปหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Typed Op</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Graph</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">ONNX 22%</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">→ 80%+</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Native YOLO</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">LDM / VLM</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">CPU beats</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">ONNX Runtime</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">C++17 +</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">no C API</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OpenCV 5 ไม่ใช่ patch เล็กๆ — เป็น major rewrite ที่ปิดช่องว่าง 8 ปีในคราวเดียว. GPU ตามมาทีหลัง, CPU ก็เร็วกว่า ONNX Runtime แล้ววันนี้.</div>
