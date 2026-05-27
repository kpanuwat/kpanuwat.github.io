---
marp: true
theme: default
paginate: true
title: "เรียน ML อย่างมีประสิทธิภาพ: กฎ 70/30"
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

# เรียน Machine Learning<br>อย่างมีประสิทธิภาพ

<p class="tag">กฎ 70/30 — ลงมือทำก่อน ทฤษฎีทีหลัง — Job-Ready ใน 6-9 เดือน</p>

<!-- Speaker: ML roadmap ที่เน้นโปรเจกต์ 70% ทฤษฎี 30% — ลำดับขั้น 6 ขั้นที่ชัดเจน -->

---

## Tutorial Hell ทำให้ไม่ไปถึงไหน

<p class="subhead">90% ของคนเรียน ML ติดกับดักนี้ — ดูคอร์สไปเรื่อยๆ แต่ไม่เคย deploy model</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Left: Tutorial Hell path -->
  <rect x="30" y="20" width="480" height="300" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--danger)" opacity=".15"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Tutorial Hell</text>
  <rect x="60" y="92" width="420" height="34" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="114" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Course 1 - Linear Algebra...</text>
  <rect x="60" y="136" width="420" height="34" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="158" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Course 2 - Statistics...</text>
  <rect x="60" y="180" width="420" height="34" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="202" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Course 3 - Another course...</text>
  <text x="270" y="258" font-size="24" font-weight="800" fill="var(--danger)" text-anchor="middle" font-family="system-ui">0 Projects Built</text>
  <text x="270" y="288" font-size="13" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Months later — still not job-ready</text>
  <!-- Right: 70/30 path -->
  <rect x="590" y="20" width="480" height="300" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--success)" opacity=".15"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">70/30 Approach</text>
  <!-- Steps -->
  <circle cx="630" cy="112" r="14" fill="var(--accent)"/>
  <text x="630" y="117" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">1</text>
  <text x="658" y="109" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Build a project (70%)</text>
  <text x="658" y="127" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Hit a wall — get stuck</text>
  <line x1="630" y1="130" x2="630" y2="158" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="3,2"/>
  <circle cx="630" cy="172" r="14" fill="var(--warning)"/>
  <text x="630" y="177" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">2</text>
  <text x="658" y="169" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Learn just-in-time (30%)</text>
  <text x="658" y="187" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Only what you need to unblock</text>
  <line x1="630" y1="190" x2="630" y2="218" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="3,2"/>
  <circle cx="630" cy="232" r="14" fill="var(--success)"/>
  <text x="630" y="237" font-size="12" fill="white" text-anchor="middle" font-family="system-ui" font-weight="700">3</text>
  <text x="658" y="229" font-size="13" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Ship — repeat at higher level</text>
  <text x="658" y="247" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Portfolio builds naturally</text>
  <text x="830" y="290" font-size="14" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Job-ready in 6-9 months</text>
  <!-- VS badge -->
  <circle cx="550" cy="170" r="28" fill="var(--ink)"/>
  <text x="550" y="175" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Theory without projects = zero portfolio. Projects with just-in-time theory = job-ready.</div>

<!-- Speaker: Most roadmaps suggest learn theory first. This one flips it — build first, hit walls, then learn. -->

---

## กฎ 70/30 + Roadmap 6 ขั้น สู่ Job-Ready

<p class="subhead">ทำโปรเจกต์ 70% ทฤษฎี 30% — เรียนตามลำดับที่ถูกต้องเท่านั้น</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/machine-learning-hands-on-70-30-1.png" alt="ML Learning Roadmap: 70/30 rule with 6 sequential stages from Python to Cloud Deployment">
<figcaption>Source: NotebookLM · Project-First Machine Learning Roadmap — 6 stages, job-ready in 6-9 months</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ลำดับขั้นสำคัญมาก — ข้ามขั้นใดขั้นหนึ่งทำให้ขั้นถัดไปยากขึ้นเป็นทวีคูณ</div>

<!-- Speaker: The roadmap isn't just a list — each step builds on the previous. Can't do Scikit-learn well without NumPy/Pandas foundation. -->

---

## Step 1-2: Python Foundation + Essential Libraries

<p class="subhead">3-4 weeks Python basics, then 3 libraries used daily by every ML engineer</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Python box -->
  <rect x="30" y="110" width="180" height="80" rx="12" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="120" y="144" font-size="18" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">Python</text>
  <text x="120" y="166" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">Fundamentals</text>
  <!-- Arrow -->
  <path d="M215 150 L260 150" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="var(--muted)"/>
    </marker>
  </defs>
  <!-- NumPy box -->
  <rect x="265" y="90" width="200" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="265" y="90" width="200" height="36" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="365" y="113" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">NumPy</text>
  <text x="365" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Arrays + Math</text>
  <text x="365" y="162" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Matrix operations</text>
  <text x="365" y="182" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Numerical computing</text>
  <!-- Arrow -->
  <path d="M470 150 L515 150" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Pandas box -->
  <rect x="520" y="90" width="200" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="520" y="90" width="200" height="36" rx="12" fill="var(--success)" opacity=".1"/>
  <text x="620" y="113" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Pandas</text>
  <text x="620" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Data wrangling</text>
  <text x="620" y="162" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Load + clean data</text>
  <text x="620" y="182" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Feature engineering</text>
  <!-- Arrow -->
  <path d="M725 150 L770 150" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <!-- Matplotlib box -->
  <rect x="775" y="90" width="200" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="775" y="90" width="200" height="36" rx="12" fill="var(--warning)" opacity=".1"/>
  <text x="875" y="113" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Matplotlib</text>
  <text x="875" y="142" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Visualization</text>
  <text x="875" y="162" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Plots + graphs</text>
  <text x="875" y="182" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">EDA charts</text>
  <!-- Arrow to goal -->
  <path d="M980 150 L1025 150" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arr)"/>
  <rect x="1030" y="120" width="55" height="60" rx="8" fill="var(--success)" opacity=".15"/>
  <text x="1058" y="148" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ML</text>
  <text x="1058" y="165" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Ready</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Goal is NOT to master Python — just enough to read ML code and write small scripts. Then build.</div>

<!-- Speaker: Week 1 should be a mini-project. You'll hit Pandas issues immediately — that's the signal to learn it. -->

---

## Step 3: Essential Math — Conceptual Only

<p class="subhead">3 areas ที่ต้องเข้าใจระดับ concept — ไม่จำเป็นต้องพิสูจน์สมการ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Math Area 1</p>
    <h3>Linear Algebra</h3>
    <p>Vectors, matrices, dot products</p>
    <p>ใช้เข้าใจว่า data เป็น matrix และ neural network คำนวณอย่างไร</p>
    <ul>
      <li>Matrix multiplication</li>
      <li>Dot product</li>
      <li>Transpose</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Math Area 2</p>
    <h3>Probability & Statistics</h3>
    <p>Distributions, Bayes' theorem, mean, variance</p>
    <p>ใช้ในทุก ML algorithm โดยไม่มีข้อยกเว้น</p>
    <ul>
      <li>Normal distribution</li>
      <li>Bayes' theorem</li>
      <li>Conditional probability</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Math Area 3</p>
    <h3>Calculus</h3>
    <p>Derivatives, gradients, optimization</p>
    <p>ใช้เข้าใจว่า model "เรียนรู้" อย่างไร ผ่าน backpropagation</p>
    <ul>
      <li>Derivatives</li>
      <li>Gradient descent</li>
      <li>Chain rule</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Learn math when you hit a wall in a project — not before. Context makes it stick.</div>

<!-- Speaker: You don't need to derive backprop from scratch. You need to understand WHY gradient descent minimizes loss. -->

---

## Step 4: Core ML ด้วย Scikit-learn — เลือก Model ให้ถูก

<p class="subhead">Focus: picking the right algorithm for the problem, not memorizing equations</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Root: Scikit-learn -->
  <rect x="420" y="10" width="260" height="50" rx="10" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="550" y="33" font-size="16" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">Scikit-learn</text>
  <text x="550" y="52" font-size="12" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">fit() · predict() · score()</text>
  <!-- Lines from root -->
  <line x1="420" y1="35" x2="220" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="550" y1="60" x2="550" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="680" y1="35" x2="900" y2="100" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Supervised Learning box -->
  <rect x="60" y="100" width="310" height="44" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="215" y="126" font-size="14" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Supervised Learning</text>
  <line x1="100" y1="144" x2="100" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="215" y1="144" x2="215" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="330" y1="144" x2="330" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="100" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Linear / Logistic Reg</text>
  <rect x="145" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="215" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Decision Tree / RF / SVM</text>
  <rect x="260" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="330" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">KNN · cross_val_score</text>
  <!-- Unsupervised box -->
  <rect x="395" y="100" width="310" height="44" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="126" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Unsupervised Learning</text>
  <line x1="478" y1="144" x2="478" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="622" y1="144" x2="622" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="408" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="478" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">K-Means Clustering</text>
  <rect x="553" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="623" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">PCA (dim. reduction)</text>
  <!-- Evaluation box -->
  <rect x="740" y="100" width="310" height="44" rx="10" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="895" y="126" font-size="14" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Model Evaluation</text>
  <line x1="830" y1="144" x2="830" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="960" y1="144" x2="960" y2="175" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="760" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="830" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Accuracy / F1 / Recall</text>
  <rect x="890" y="175" width="140" height="36" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="960" y="197" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Cross-validation (k=5)</text>
  <!-- Bottom note -->
  <text x="550" y="265" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">All models share the same API: .fit() .predict() .score() — easy to swap</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Scikit-learn's consistent API lets you swap algorithms in one line — the real skill is knowing WHEN to use which.</div>

<!-- Speaker: Build a Titanic or house price project here. The model selection challenge is more valuable than any single algorithm. -->

---

## Step 5: Deep Learning Architectures (PyTorch)

<p class="subhead">ใช้ PyTorch — ครอง research + production; 4 architectures ที่ต้องรู้</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/machine-learning-hands-on-70-30-2.png" alt="Deep Learning Architecture Comparison: Feedforward, CNN, RNN/LSTM, and Transformer with use cases">
<figcaption>Source: NotebookLM · Deep Learning Architecture Comparison — PyTorch is the recommended framework</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> PyTorch over TensorFlow — dominating research and growing in production. Learn Transformers last; they build on all prior architectures.</div>

<!-- Speaker: Don't jump to Transformers first. Feedforward → CNN → RNN → Transformer is the right order. Each adds one new concept. -->

---

## Step 6: MLOps + Cloud — สิ่งที่ทำให้หางานได้จริง

<p class="subhead">ขั้นที่ roadmap ส่วนใหญ่ข้ามไป แต่ interviewer ถามมากที่สุด</p>

<div class="infographic">
<figure class="img-card">
<img src="assets/machine-learning-hands-on-70-30-3.png" alt="MLOps end-to-end pipeline from raw data through model training to cloud deployment and monitoring">
<figcaption>Source: NotebookLM · Machine Learning Operations Blueprint — Docker, FastAPI, MLflow, AWS/GCP/Azure</figcaption>
</figure>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 80% of real ML work is data cleaning, not model tuning. MLOps + cloud deployment separates hireable from not.</div>

<!-- Speaker: Kaggle data is pre-cleaned. Real data has 40% null values, inconsistent types, and no documentation. Build projects with messy data. -->

---

## Learn in Public: Portfolio ที่ Recruiter หา

<p class="subhead">ML recruiters จ้างจากโปรเจกต์จริง ไม่ใช่ certificate</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Platform 1</p>
    <h3>GitHub</h3>
    <p>Push ทุก project — รวมถึงโปรเจกต์ที่ไม่สมบูรณ์</p>
    <p>README ที่ดีคือ resume ที่ดีที่สุด</p>
    <ul>
      <li>End-to-end projects</li>
      <li>Clear README + docs</li>
      <li>Regular commits</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Platform 2</p>
    <h3>LinkedIn</h3>
    <p>เขียน short posts เกี่ยวกับสิ่งที่เรียน ปัญหาที่เจอ</p>
    <p>ไม่ต้องเป็น expert — progress ก็มีคุณค่า</p>
    <ul>
      <li>Weekly learning logs</li>
      <li>Project launches</li>
      <li>Lessons learned</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Project Rule</p>
    <h3>End-to-End Only</h3>
    <p>ทุกโปรเจกต์ต้องครบ data → model → deploy</p>
    <p>Kaggle notebook ที่หยุดตอน accuracy ดีขึ้น ไม่นับ</p>
    <ul>
      <li>Data collection</li>
      <li>Model training</li>
      <li>Live deployment</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Sharing progress shows you are active, adaptive, and keeping up with the industry" — the recruiter sees this.</div>

<!-- Speaker: 3 end-to-end projects > 30 Kaggle medals. Deploy on Hugging Face Spaces (free), Railway, or AWS EC2. -->

---

## Timeline: Job-Ready ใน 6-9 เดือน

<p class="subhead">แผนที่ชัดเจน — full-time study; part-time คูณด้วย 2-3</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Timeline track -->
  <line x1="60" y1="130" x2="1060" y2="130" stroke="var(--soft-2)" stroke-width="3"/>
  <!-- Milestones -->
  <!-- M1 -->
  <circle cx="160" cy="130" r="20" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="160" y="135" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="160" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Month 1</text>
  <text x="160" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Python + Libraries</text>
  <text x="160" y="187" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">NumPy / Pandas / Matplotlib</text>
  <!-- M2 -->
  <circle cx="360" cy="130" r="20" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="360" y="135" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="360" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Month 2</text>
  <text x="360" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Math + Core ML</text>
  <text x="360" y="187" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Scikit-learn projects</text>
  <!-- M3 -->
  <circle cx="560" cy="130" r="20" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="560" y="135" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3-4</text>
  <text x="560" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Month 3-4</text>
  <text x="560" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Deep Learning</text>
  <text x="560" y="187" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">PyTorch + CNN/RNN</text>
  <!-- M4 -->
  <circle cx="760" cy="130" r="20" fill="var(--warning)" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="760" y="135" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5-6</text>
  <text x="760" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Month 5-6</text>
  <text x="760" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MLOps basics</text>
  <text x="760" y="187" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Docker + FastAPI + MLflow</text>
  <!-- M5 -->
  <circle cx="980" cy="130" r="22" fill="var(--success)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="980" y="128" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">7-9</text>
  <text x="980" y="143" font-size="10" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Apply</text>
  <text x="980" y="90" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Month 7-9</text>
  <text x="980" y="170" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Cloud + Portfolio</text>
  <text x="980" y="187" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Apply for jobs</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 9 months of consistent effort beats 3 years of on-and-off tutorial watching.</div>

<!-- Speaker: Consistent ≠ full-time. Even 2 hrs/day focused project work beats 8 hrs of passive video watching. -->

---

## Key Takeaways: 7 สิ่งที่ต้องจำ

<p class="subhead">กฎที่พาจาก 0 สู่ Job-Ready</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="grid-template-columns:1fr 1fr 1fr; font-size:13px;">
  <div class="card compact">
    <p class="label">Rule 1</p>
    <h3>70/30 Always</h3>
    <p>Code 70%, theory 30% — ไม่ใช่กลับกัน ไม่มีข้อยกเว้น</p>
  </div>
  <div class="card compact">
    <p class="label">Foundation</p>
    <h3>Python + 3 Libraries</h3>
    <p>NumPy, Pandas, Matplotlib ต้องแน่นก่อนแตะ algorithm ใดๆ</p>
  </div>
  <div class="card compact warning">
    <p class="label">Math Rule</p>
    <h3>Conceptual Only</h3>
    <p>เข้าใจ concept ไม่ต้องพิสูจน์สมการ — เรียนเมื่อติดปัญหา</p>
  </div>
  <div class="card compact success">
    <p class="label">Framework</p>
    <h3>PyTorch &gt; TensorFlow</h3>
    <p>Dominate research + production ในปัจจุบัน เลือกเลย</p>
  </div>
  <div class="card compact danger">
    <p class="label">Critical Step</p>
    <h3>MLOps is Non-Optional</h3>
    <p>Docker + FastAPI + Cloud — ข้ามขั้นนี้ = ไม่ผ่าน interview</p>
  </div>
  <div class="card compact gold">
    <p class="label">Career Rule</p>
    <h3>Learn in Public</h3>
    <p>GitHub + LinkedIn — recruiter ดูโปรเจกต์ ไม่ดู certificate</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> End-to-end projects (data → model → deployment) on GitHub มีค่ามากกว่า 10 Kaggle notebooks รวมกัน</div>

<!-- Speaker: The 7th rule: build end-to-end. Not just a model in a notebook. A deployed API with documentation. -->
