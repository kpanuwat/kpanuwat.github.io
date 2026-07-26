---
marp: true
theme: default
paginate: true
title: "AI Multi-agent Orchestration: Sub-agent CLI กับ Headless Mode ผ่าน SSE"
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

![bg opacity:.25](assets/ai-multi-agent-orchestration-subagent-headless-sse-cover.png)

<div class="mark"></div>

# AI Multi-agent Orchestration: Sub-agent CLI กับ Headless Mode ผ่าน SSE

<p class="tag">Two orchestration patterns: isolated sub-agent context windows, and cross-CLI headless piping over SSE</p>

<!-- Speaker: Frame the two patterns up front — sub-agent (single CLI, internal delegation) vs headless mode (cross-CLI, external piping via stdin/stdout + SSE). -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/ai-multi-agent-orchestration-subagent-headless-sse-cheatsheet.png)

<!-- Speaker: Orient the audience to the 7 panels before diving into any one of them. -->

---

## Two Patterns, One Goal: Faster Agents, Cleaner Context

<p class="subhead">Sub-agent กระจายงานภายในเซสชันเดียว ส่วน Headless Mode ต่อข้าม CLI ผ่าน stdin/stdout และ SSE</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="190" r="40" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="190" r="28" fill="var(--accent)"/>
  <text x="148" y="196" font-size="18" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">2</text>
  <text x="220" y="150" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">Two orchestration patterns</text>
  <text x="220" y="185" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Sub-agent: distribute work inside one CLI session</text>
  <text x="220" y="215" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Headless mode: pipe across multiple CLIs via stdin/stdout</text>
  <text x="220" y="245" font-size="15" fill="var(--muted)" font-family="system-ui">SSE streams live status to a frontend</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้งสองแบบช่วยแยก context และเพิ่มความเร็วด้วยการทำงานแบบขนาน</div>

<!-- Speaker: Set up the two-pattern framing that the rest of the deck follows. -->

---

## Background: Context Window ล้นเมื่อ Agent ทำทุกอย่างเอง

![bg right:40% contain](assets/ai-multi-agent-orchestration-subagent-headless-sse-background.png)

<p class="subhead">งานที่มีผลลัพธ์เยอะ (log, ผลค้นเอกสาร) ทำให้ context หลักเต็มเร็วและ agent เริ่มหลงประเด็น</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="620" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="60" y="65" font-size="15" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">One agent, one context</text>
  <text x="60" y="90" font-size="13" fill="var(--danger-ink)" font-family="system-ui">Logs + search results + files pile up together</text>
  <line x1="350" y1="120" x2="350" y2="160" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="342,155 358,155 350,168" fill="var(--muted)"/>
  <rect x="40" y="180" width="620" height="110" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="60" y="215" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">Result</text>
  <text x="60" y="240" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Context fills up fast — agent loses focus</text>
  <text x="60" y="262" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Cross-CLI orchestration needs a standard channel too</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> การแยกงานออกไปทำในพื้นที่ (context) ของตัวเองคือทางแก้สถาปัตยกรรม ไม่ใช่แค่ฟีเจอร์เสริม</div>

<!-- Speaker: This is the "why" slide — the problem both patterns solve. -->

---

## Sub-agent: Fresh Context Window per Task

![bg right:40% contain](assets/ai-multi-agent-orchestration-subagent-headless-sse-subagent.png)

<p class="subhead">Subagent เริ่มต้นด้วย context ใหม่ทั้งหมด ไม่สืบทอดประวัติสนทนาจาก parent</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="140" width="140" height="60" rx="8" fill="var(--accent)" opacity=".12" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="100" y="175" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Orchestrator</text>
  <line x1="170" y1="170" x2="260" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="170" y1="170" x2="260" y2="170" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="170" y1="170" x2="260" y2="250" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="260" y="60" width="150" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="335" y="95" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">subagent A (fresh)</text>
  <rect x="260" y="140" width="150" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="335" y="175" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">subagent B (fresh)</text>
  <rect x="260" y="220" width="150" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="335" y="255" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">subagent C (fresh)</text>
  <line x1="410" y1="90" x2="480" y2="170" stroke="var(--gold)" stroke-width="1.5" stroke-dasharray="4 3"/>
  <line x1="410" y1="170" x2="480" y2="170" stroke="var(--gold)" stroke-width="1.5" stroke-dasharray="4 3"/>
  <line x1="410" y1="250" x2="480" y2="170" stroke="var(--gold)" stroke-width="1.5" stroke-dasharray="4 3"/>
  <text x="490" y="175" font-size="11" fill="var(--muted)" font-family="system-ui">summary only</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ต้องใส่ path/error/context ที่จำเป็นลง prompt ตอนเรียก subagent เพราะมันมองไม่เห็นบทสนทนาก่อนหน้า</div>

<!-- Speaker: The dashed lines are the only channel back — summary, not raw context. -->

---

## Headless Mode: Pipe One CLI's stdout into Another's stdin

<p class="subhead">`-p` flag รันแบบ non-interactive; stdout ของ CLI หนึ่งกลายเป็น stdin ของอีกตัวได้ตรงๆ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="140" width="260" height="100" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="170" y="180" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">claude -p</text>
  <text x="170" y="205" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">headless CLI #1</text>
  <line x1="300" y1="190" x2="420" y2="190" stroke="var(--gold)" stroke-width="2.5"/>
  <polygon points="410,182 430,190 410,198" fill="var(--gold)"/>
  <text x="360" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">stdout</text>
  <rect x="430" y="140" width="240" height="100" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="185" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">stream-json</text>
  <text x="550" y="208" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">newline-delimited events</text>
  <line x1="670" y1="190" x2="790" y2="190" stroke="var(--gold)" stroke-width="2.5"/>
  <polygon points="780,182 800,190 780,198" fill="var(--gold)"/>
  <text x="730" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">stdin</text>
  <rect x="800" y="140" width="260" height="100" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="930" y="180" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">codex exec</text>
  <text x="930" y="205" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">headless CLI #2</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> output format ต้องระบุชัด — `text` เปล่าอาจพา metadata ปนเข้าไปถ้าไม่ตั้ง `--output-format`</div>

<!-- Speaker: This is the cross-CLI orchestration primitive — no chat window required. -->

---

## Three Output Formats, One CLI Flag

<p class="subhead">`--output-format` เลือกได้ 3 แบบ ขึ้นกับว่าใครเป็นผู้บริโภคผลลัพธ์</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Default</p>
    <h3>text</h3>
    <p>Plain words — for a human reading the terminal directly.</p>
  </div>
  <div class="card gold">
    <p class="label">Structured</p>
    <h3>json</h3>
    <p>Single JSON object with result + session_id — for scripts and CI.</p>
  </div>
  <div class="card success">
    <p class="label">Incremental</p>
    <h3>stream-json</h3>
    <p>Newline-delimited events as they happen — for SSE and live UIs.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> `stream-json` คือ format ที่ทำให้ระบบภายนอก track สถานะ agent แบบ real-time ได้</div>

<!-- Speaker: Pick the format based on the consumer, not out of habit. -->

---

## SSE: Push Live Status to the Browser, One-Way

<p class="subhead">Server ฟัง stream-json แล้ว push event ผ่าน SSE ไปหา client โดยไม่ต้อง poll</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="150" width="260" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="190" y="188" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">headless CLI</text>
  <text x="190" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">emits stream-json</text>
  <line x1="320" y1="195" x2="420" y2="195" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="410,187 430,195 410,203" fill="var(--muted)"/>
  <rect x="430" y="150" width="220" height="90" rx="10" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="2"/>
  <text x="540" y="188" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">server</text>
  <text x="540" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">parses + patches SSE</text>
  <line x1="650" y1="195" x2="770" y2="195" stroke="var(--gold)" stroke-width="2.5"/>
  <polygon points="760,187 780,195 760,203" fill="var(--gold)"/>
  <text x="710" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SSE</text>
  <rect x="780" y="150" width="260" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="910" y="188" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">frontend client</text>
  <text x="910" y="210" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">EventSource — no polling</text>
  <text x="550" y="290" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">"thinking" -&gt; "agent spawned" -&gt; "results synthesized"</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SSE เป็นทางเดียว (server→client) — ต้องการช่องทางแยกถ้าอยาก steer agent กลับ</div>

<!-- Speaker: Contrast with WebSocket — SSE is simpler because the client only ever watches. -->

---

## Three Reasons This Is Faster and Cleaner

<p class="subhead">ประโยชน์หลักของการแยก context และ orchestrate ข้าม CLI</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Speed</p>
    <h3>Parallelization</h3>
    <p>Independent subtasks run concurrently — total time = slowest agent, not the sum.</p>
  </div>
  <div class="card">
    <p class="label">Memory</p>
    <h3>Context window management</h3>
    <p>Verbose work stays in the subagent — orchestrator never hits its token limit.</p>
  </div>
  <div class="card gold">
    <p class="label">Accuracy</p>
    <h3>Task specialization</h3>
    <p>Narrow system prompt + restricted tools per agent — safer, more precise output.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แยกงานตามความเชี่ยวชาญ ไม่ใช่ยัดทุกความสามารถไว้ใน agent เดียว</div>

<!-- Speaker: Tie all three benefits back to the isolation principle from slide 3. -->

---

## User Guide: Five Steps from Sub-agent to SSE

<p class="subhead">ลำดับการทดลองจริง ตั้งแต่ subagent เดี่ยวไปจนถึง orchestration เต็มรูปแบบ</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <g font-family="system-ui">
    <circle cx="90" cy="150" r="34" fill="var(--accent)"/>
    <text x="90" y="157" font-size="16" fill="var(--paper)" text-anchor="middle" font-weight="700">1</text>
    <text x="90" y="205" font-size="12" fill="var(--ink)" text-anchor="middle">Sub-agent</text>
    <line x1="124" y1="150" x2="266" y2="150" stroke="var(--muted)" stroke-width="2"/>
    <polygon points="256,143 274,150 256,157" fill="var(--muted)"/>
    <circle cx="300" cy="150" r="34" fill="var(--accent)"/>
    <text x="300" y="157" font-size="16" fill="var(--paper)" text-anchor="middle" font-weight="700">2</text>
    <text x="300" y="205" font-size="12" fill="var(--ink)" text-anchor="middle">headless -p</text>
    <line x1="334" y1="150" x2="476" y2="150" stroke="var(--muted)" stroke-width="2"/>
    <polygon points="466,143 484,150 466,157" fill="var(--muted)"/>
    <circle cx="510" cy="150" r="34" fill="var(--accent)"/>
    <text x="510" y="157" font-size="16" fill="var(--paper)" text-anchor="middle" font-weight="700">3</text>
    <text x="510" y="205" font-size="12" fill="var(--ink)" text-anchor="middle">pipe stdin/stdout</text>
    <line x1="544" y1="150" x2="686" y2="150" stroke="var(--muted)" stroke-width="2"/>
    <polygon points="676,143 694,150 676,157" fill="var(--muted)"/>
    <circle cx="720" cy="150" r="34" fill="var(--accent)"/>
    <text x="720" y="157" font-size="16" fill="var(--paper)" text-anchor="middle" font-weight="700">4</text>
    <text x="720" y="205" font-size="12" fill="var(--ink)" text-anchor="middle">stream-json</text>
    <line x1="754" y1="150" x2="896" y2="150" stroke="var(--muted)" stroke-width="2"/>
    <polygon points="886,143 904,150 886,157" fill="var(--muted)"/>
    <circle cx="930" cy="150" r="34" fill="var(--gold)"/>
    <text x="930" y="157" font-size="16" fill="var(--paper)" text-anchor="middle" font-weight="700">5</text>
    <text x="930" y="205" font-size="12" fill="var(--ink)" text-anchor="middle">SSE to frontend</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มจาก subagent เดี่ยวก่อน แล้วค่อยขยับไป cross-CLI piping เมื่อจำเป็นจริง</div>

<!-- Speaker: Walk left to right — each step builds on the previous, don't skip to 5. -->

---

## Troubleshooting: Three Failure Modes

<p class="subhead">ปัญหาที่พบบ่อยเมื่อต่อ CLI ข้ามตัวและ stream สถานะผ่าน SSE</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Pipe fails</p>
    <h3>No stdin support</h3>
    <p>ไม่ใช่ทุก CLI รองรับ non-interactive input เหมือนกัน — เช็ค flag ก่อนต่อ pipe</p>
  </div>
  <div class="card warning">
    <p class="label">Connection drops</p>
    <h3>SSE timeout</h3>
    <p>เพิ่ม heartbeat event กันบาง proxy ตัด idle connection ที่นานเกินไป</p>
  </div>
  <div class="card">
    <p class="label">Wrong output</p>
    <h3>Subagent missing context</h3>
    <p>ใส่ path/error/decision ที่จำเป็นลง prompt ตอนเรียกจริง เพราะไม่สืบทอด conversation</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ปัญหาส่วนใหญ่มาจากสมมติฐานผิดว่าทุก CLI/agent มีบริบทหรือ interface เหมือนกัน</div>

<!-- Speaker: These are the three questions to ask first when orchestration breaks. -->

---

## Caveats and Limits

<p class="subhead">ข้อจำกัดที่ต้องรู้ก่อนเอาไปใช้จริง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning compact">
    <p class="label">Cost</p>
    <h3>Not a "lighter" mode</h3>
    <p>Headless ตัด UI ออก แต่ agent loop เต็มรูปแบบยังทำงาน — token usage เท่าเดิม</p>
  </div>
  <div class="card danger compact">
    <p class="label">Direction</p>
    <h3>SSE is one-way</h3>
    <p>Server→client เท่านั้น — steer agent กลับต้องมีช่องทางแยก เช่น POST endpoint</p>
  </div>
  <div class="card compact">
    <p class="label">Format match</p>
    <h3>stdout ↔ stdin</h3>
    <p>ต้องระบุ `--output-format` ให้ตรงกับสิ่งที่ปลายทางรับได้ ไม่งั้น metadata ปนเข้าไป</p>
  </div>
  <div class="card compact">
    <p class="label">Fresh start</p>
    <h3>Subagent forgets</h3>
    <p>ไม่สืบทอด context เดิม — ลืมใส่ข้อมูลจำเป็นลง prompt = ทำงานผิดทิศทาง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ประเมินก่อนใช้จริง: token cost, ทิศทางการสื่อสาร, format matching, และ context inheritance</div>

<!-- Speaker: Close on realism — this is a pattern with real tradeoffs, not a silver bullet. -->

---

## Key Takeaways

<p class="subhead">สรุปสิ่งที่ต้องจำแม้จะข้ามเนื้อหาส่วนอื่นไปทั้งหมด</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">isolate</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">context</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Sub-agent</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">fresh window</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Headless</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">-p + stdin/stdout</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">stream-json</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">incremental</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">SSE</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">one-way push</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Parallelization + context isolation + task specialization = agent orchestration ที่เร็วขึ้นและแม่นยำขึ้น</div>

<!-- Speaker: End here — this is the one slide worth screenshotting. -->
