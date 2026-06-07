---
marp: true
theme: default
paginate: true
title: "เรียนกับ AI ให้มีประสิทธิภาพ: ส่วนเสริม ไม่ใช่ตัวแทน"
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
  table { width:100%; border-collapse:collapse; font-size:13px; }
  th { background:var(--soft); color:var(--ink); font-weight:700; padding:10px 12px; text-align:left; border-bottom:2px solid var(--soft-2); }
  td { padding:8px 12px; border-bottom:1px solid var(--soft-2); vertical-align:top; line-height:1.5; }
  tr:last-child td { border-bottom:none; }
---

<!-- _class: title -->

![bg opacity:.25](assets/effective-ai-learning-supplement-not-substitute-cover.png)

<div class="mark"></div>

# เรียนกับ AI ให้มีประสิทธิภาพ

<p class="tag">ส่วนเสริม ไม่ใช่ตัวแทน — Bloom's Taxonomy as your AI usage guide</p>

<!-- Speaker: Today we cover when AI helps vs. hurts your learning — using Bloom's Taxonomy as a concrete decision framework. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/effective-ai-learning-supplement-not-substitute-cheatsheet.png)

<!-- Speaker: Full reference cheatsheet — Bloom's AI map, Cognitive Debt mechanisms, Active Recall + Spaced Repetition, and AI limitations at a glance. -->

---

## AI ช่วยเรียนได้ — แต่มีเงื่อนไข

<p class="subhead">ระดับล่าง (L1-L3) AI ช่วยได้เต็มที่ · ระดับบน (L4-L6) มนุษย์ต้องนำ AI ตาม</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">AI-Safe Zone · L1–L3</p>
    <h3>จำ / เข้าใจ / ปรับใช้</h3>
    <p>AI ช่วยออก quiz, สรุป concept, หา use case — cognitive work ยังอยู่ที่มนุษย์</p>
    <ul>
      <li>Flashcards &amp; quizzes</li>
      <li>Podcast / explainer</li>
      <li>Practice problems</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Human-Led Zone · L4–L6</p>
    <h3>วิเคราะห์ / ประเมิน / สร้างสรรค์</h3>
    <p>คิดและ draft เองก่อน แล้วค่อยให้ AI ตรวจทานหรือโต้แย้ง ไม่ใช่ถาม AI ก่อน</p>
    <ul>
      <li>Analyze data yourself first</li>
      <li>Form judgment, then verify</li>
      <li>Draft first, AI refines</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI แทนการคิด = Cognitive Debt สะสม · AI ต่อยอดการคิด = ประสิทธิภาพเพิ่มขึ้น</div>

<!-- Speaker: This is the core decision rule. Before using AI, ask: am I in L1-L3 or L4-L6? -->

---

## The Hidden Cost of Easy AI Answers

![bg right:40% contain](assets/effective-ai-learning-supplement-not-substitute-background.png)

<p class="subhead">AI users scored +22 pts immediately — but only +6 pts three weeks later (Frontiers in Psychology, 2025)</p>

<div class="infographic">
<svg viewBox="0 0 680 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="50" width="70" height="190" rx="6" fill="var(--accent)" opacity=".85"/>
  <text x="95" y="44" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">+22</text>
  <text x="95" y="260" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Immediate</text>
  <rect x="175" y="165" width="70" height="75" rx="6" fill="var(--accent)" opacity=".35" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="5 3"/>
  <text x="210" y="158" font-size="18" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+6</text>
  <text x="210" y="260" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">3 weeks</text>
  <line x1="300" y1="30" x2="300" y2="275" stroke="var(--soft-2)" stroke-width="1" stroke-dasharray="6 4"/>
  <rect x="316" y="55" width="320" height="175" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="336" y="86" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Why the gap collapses:</text>
  <text x="336" y="113" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- AI retrieval = brain skips practice</text>
  <text x="336" y="138" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- No Retrieval Practice = weak synapses</text>
  <text x="336" y="163" font-size="13" fill="var(--ink-dim)" font-family="system-ui">- Knowledge not consolidated long-term</text>
  <text x="336" y="195" font-size="12" fill="var(--warning)" font-weight="600" font-family="system-ui">= Cognitive Debt accumulates silently</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI ให้ short-term boost แต่ถ้าไม่ฝึก active recall สมองไม่ได้สร้าง long-term memory จริง</div>

<!-- Speaker: This is the key research finding. Short-term boost is real but fragile without retrieval practice. -->

---

## Bloom's Taxonomy: แผนที่การใช้ AI อย่างถูกจุด

<p class="subhead">6 ระดับ — แต่ละระดับมีบทบาท AI ที่ต่างกันอย่างสิ้นเชิง</p>

<div class="infographic" style="align-items:stretch; overflow:auto;">

| ระดับ | ทักษะ | บทบาท AI | ตัวอย่าง |
|-------|--------|-----------|---------|
| **L1 Remember (จำ)** | ท่อง, ระลึก | ✅ เต็มที่ | Quiz, flashcard, สรุปนิยาม |
| **L2 Understand (เข้าใจ)** | อธิบาย, สรุป | ✅ เต็มที่ | Explain ด้วยอุปมาใหม่ |
| **L3 Apply (ปรับใช้)** | แก้โจทย์, ทดลอง | ✅ (verify เอง) | Practice problems, use case |
| **L4 Analyze (วิเคราะห์)** | แยกแยะ, pattern | ⚠️ มนุษย์นำ | วิเคราะห์เองก่อน → AI ตรวจ |
| **L5 Evaluate (ประเมิน)** | ตัดสิน, วิจารณ์ | ⚠️ มนุษย์นำ | Argue เองก่อน → AI โต้แย้ง |
| **L6 Create (สร้างสรรค์)** | ออกแบบ, ประดิษฐ์ | ⚠️ AI ขยายผล | Draft เองก่อน → AI refine |

</div>

<div class="takeaway"><b>★ Takeaway:</b> L1-L3 = AI เป็นแรงเสริม · L4-L6 = มนุษย์เป็นแกนหลัก ห้ามสลับบทบาท</div>

<!-- Speaker: Use this as a decision tree every time you're about to ask AI something. Which level am I at? -->

---

## Cognitive Debt: 3 กลไกที่ทำให้สมองไม่พัฒนา

<p class="subhead">หนี้สะสมแบบ compound — ยิ่งข้ามขั้นตอนการคิด ยิ่งยากที่จะ "จ่ายคืน"</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Mechanism 1 · No Pathway</p>
    <h3>Neural Pathway ไม่ถูกสร้าง</h3>
    <p>Retrieval Practice สร้าง synaptic connection แต่ถ้า AI ดึงข้อมูลให้แทน สมองไม่ได้ฝึกวงจรนี้เลย</p>
  </div>
  <div class="card warning">
    <p class="label">Mechanism 2 · False Signal</p>
    <h3>Fluency Illusion</h3>
    <p>อ่านคำอธิบาย AI แล้วรู้สึก "เข้าใจแล้ว" — สมองรับรู้ความ "ราบรื่น" ว่าเป็น signal ของความเข้าใจ ทั้งที่ไม่ใช่</p>
  </div>
  <div class="card gold">
    <p class="label">Mechanism 3 · Compound Loop</p>
    <h3>Dependency Loop</h3>
    <p>พึ่ง AI บ่อย → ไม่ฝึกกล้ามเนื้อทางปัญญา → รู้สึกต้องพึ่ง AI มากขึ้น → วนซ้ำ compound</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> รู้สึก "เข้าใจ" หลังอ่านคำอธิบาย AI ≠ เข้าใจจริง — ต้องทดสอบตัวเองด้วย Active Recall เสมอ</div>

<!-- Speaker: The dependency loop is the hardest to break once established. Deliberate AI-free practice sessions are required to reset it. -->

---

## Active Recall + Spaced Repetition: Gold Standard

<p class="subhead">สองเทคนิคที่มีงานวิจัยรองรับมากที่สุด — AI ช่วยถูกจุดในทั้งสองกรณี</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="490" height="240" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="275" y="64" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Active Recall</text>
  <rect x="58" y="88" width="72" height="34" rx="8" fill="var(--success)" opacity=".8"/>
  <text x="94" y="109" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Study</text>
  <polygon points="138,105 148,105 148,101 158,109 148,117 148,113 138,113" fill="var(--success)"/>
  <rect x="166" y="88" width="72" height="34" rx="8" fill="var(--success)" opacity=".8"/>
  <text x="202" y="109" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Close</text>
  <polygon points="246,105 256,105 256,101 266,109 256,117 256,113 246,113" fill="var(--success)"/>
  <rect x="274" y="88" width="72" height="34" rx="8" fill="var(--accent)" opacity=".9"/>
  <text x="310" y="109" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Recall</text>
  <polygon points="354,105 364,105 364,101 374,109 364,117 364,113 354,113" fill="var(--success)"/>
  <rect x="382" y="88" width="72" height="34" rx="8" fill="var(--success)" opacity=".8"/>
  <text x="418" y="109" font-size="12" fill="white" text-anchor="middle" font-family="system-ui">Check</text>
  <text x="275" y="168" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AI role: generate quiz, Socratic Q&amp;A,</text>
  <text x="275" y="190" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">new analogies — human does the recall</text>
  <text x="275" y="218" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Cognitive work stays with human</text>

  <rect x="580" y="30" width="490" height="240" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="825" y="64" font-size="16" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Spaced Repetition</text>
  <line x1="608" y1="145" x2="1042" y2="145" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="635" cy="145" r="9" fill="var(--accent)"/>
  <text x="635" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Day 0</text>
  <circle cx="720" cy="145" r="9" fill="var(--accent)" opacity=".8"/>
  <text x="720" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+1d</text>
  <circle cx="825" cy="145" r="9" fill="var(--accent)" opacity=".7"/>
  <text x="825" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+3d</text>
  <circle cx="940" cy="145" r="9" fill="var(--accent)" opacity=".6"/>
  <text x="940" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+7d</text>
  <circle cx="1035" cy="145" r="9" fill="var(--accent)" opacity=".45"/>
  <text x="1035" y="168" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">+30d</text>
  <text x="825" y="206" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI role: schedule + adapt intervals</text>
  <text x="825" y="226" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Anki, Quizlet — human does the recall</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI สร้าง content สำหรับ review ได้ดีมาก แต่ cognitive work (การระลึกข้อมูล) ต้องทำเองเสมอ</div>

<!-- Speaker: Anki is the canonical example — AI schedules the when; you do the cognitive work. -->

---

## AI Limitations: 3 ข้อที่ต้องรู้ทัน

<p class="subhead">รู้จักข้อจำกัดก่อนใช้ — โดยเฉพาะในระดับ L4-L6 ที่ stakes สูงกว่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Limitation 1 · False Facts</p>
    <h3>Hallucination</h3>
    <p>LLM generate ข้อความที่ดูน่าเชื่อถือแต่ผิดจริง ตรวจจับยากในหัวข้อ abstract (ประวัติศาสตร์, ปรัชญา) แต่ง่ายกว่าใน coding/math</p>
  </div>
  <div class="card warning">
    <p class="label">Limitation 2 · Echo Chamber</p>
    <h3>Bias Reinforcement</h3>
    <p>AI reflect bias ของ training data ยิ่งถามในทิศทางเดิม ยิ่งได้คำตอบที่ confirm สิ่งที่คิดอยู่แล้ว (Confirmation Bias amplification)</p>
  </div>
  <div class="card gold">
    <p class="label">Limitation 3 · Sycophancy</p>
    <h3>Performative Agreement</h3>
    <p>AI มักตอบ "คุณพูดถูก ขอโทษ" แม้คำตอบเดิมจะถูก นักเรียนอาจคิดว่าตัวเองแก้ AI ได้ ทั้งที่ AI แค่ sycophantic</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ยิ่งหัวข้อ abstract และ high-stakes ยิ่งต้อง verify ด้วยแหล่งอ้างอิงอิสระ ไม่ใช่แค่ถาม AI ซ้ำ</div>

<!-- Speaker: The third one trips up even experienced users — AI saying "you're right, sorry" feels like validation, but it's not. -->

---

## Key Takeaways: กฎ 6 ข้อเอาไปใช้ได้ทันที

<p class="subhead">จากทุก section สู่ action items ที่ชัดเจน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success compact">
    <p class="label">Rule 1 · L1–L3</p>
    <h3>AI ช่วยได้เต็มที่</h3>
    <p>Quiz, podcast, flashcard, practice problems — brain ยังทำ cognitive work อยู่</p>
  </div>
  <div class="card warning compact">
    <p class="label">Rule 2 · L4–L6</p>
    <h3>มนุษย์นำ AI ตาม</h3>
    <p>วิเคราะห์/ประเมิน/สร้างเองก่อน แล้วค่อยให้ AI ตรวจทานหรือโต้แย้ง</p>
  </div>
  <div class="card danger compact">
    <p class="label">Rule 3 · Cognitive Debt</p>
    <h3>รู้สึก "เข้าใจ" ≠ เข้าใจจริง</h3>
    <p>Fluency Illusion หลอกได้เสมอ — ทดสอบด้วย Active Recall ก่อนเชื่อตัวเอง</p>
  </div>
  <div class="card compact">
    <p class="label">Rule 4 · Memory</p>
    <h3>Active Recall + Spaced Repetition</h3>
    <p>Gold standard สำหรับ long-term retention — AI ช่วยสร้าง content, คุณทำ recall</p>
  </div>
  <div class="card gold compact">
    <p class="label">Rule 5 · Know AI Limits</p>
    <h3>รู้ทัน 3 ข้อจำกัด</h3>
    <p>Hallucination · Bias Reinforcement · Performative Agreement</p>
  </div>
  <div class="card success compact">
    <p class="label">Rule 6 · The Golden Rule</p>
    <h3>Supplement ไม่ใช่ Substitute</h3>
    <p>AI แทนการคิด = หนี้สะสม · AI ต่อยอดการคิด = ประสิทธิภาพสูงขึ้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ AI เป็น "workout partner" ไม่ใช่ "someone who does your workout for you"</div>

<!-- Speaker: The workout analogy is the one to remember. AI as partner = growth. AI as replacement = atrophy. -->
