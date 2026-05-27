---
marp: true
theme: default
paginate: true
title: "Claude Code Workflow Tools: JavaScript Multi-Agent Orchestration"
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
  section.title h1 { font-size:38px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:16px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Claude Code Workflow Tools: JS Multi-Agent Orchestration

<p class="tag">เปลี่ยน LLM orchestrator เป็น JavaScript — ขจัด token tax, parallel processing, auto-retry</p>

<!-- Speaker: Workflow Tool คือการเปลี่ยน non-deterministic orchestrator มาเป็น deterministic code -->

---

## ปัญหา Token Tax: LLM Orchestrator ทำ Context เต็ม

<p class="subhead">ทุก token ที่ sub-agent ผลิตวนกลับสู่ main session — context เต็ม โมเดลลืม ค่าแพง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Before: LLM orchestrator problem -->
  <rect x="40" y="20" width="1020" height="260" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5" opacity=".6"/>
  <text x="550" y="55" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ก่อนใช้ Workflow Tool — token ไหลผ่าน Main LLM ทุกครั้ง</text>

  <!-- Sub-agents -->
  <rect x="80" y="80" width="160" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="160" y="105" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sub-Agent A</text>
  <text x="160" y="124" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ผลลัพธ์ทั้งหมด</text>

  <rect x="80" y="170" width="160" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="160" y="195" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sub-Agent B</text>
  <text x="160" y="214" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">รับคำสั่งจาก main</text>

  <!-- Main LLM center -->
  <rect x="390" y="100" width="320" height="110" rx="10" fill="var(--danger)" opacity=".15" stroke="var(--danger)" stroke-width="2"/>
  <text x="550" y="148" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Main LLM</text>
  <text x="550" y="170" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Orchestrator (non-deterministic)</text>
  <text x="550" y="192" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">context เต็ม → โมเดลลืม → งานผิดพลาด</text>

  <!-- Arrows: sub-agents → main → sub-agents -->
  <path d="M245 110 L390 148" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,3"/>
  <path d="M245 200 L390 162" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,3"/>

  <!-- Results right side -->
  <rect x="800" y="80" width="220" height="180" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="910" y="120" font-size="13" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Token ทะลัก</text>
  <text x="910" y="145" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Context window เต็ม</text>
  <text x="910" y="168" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ค่าใช้จ่ายพุ่ง</text>
  <text x="910" y="191" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่ resilient</text>
  <text x="910" y="240" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ถ้า sub-agent ล้ม → ทั้ง workflow ล่ม</text>

  <path d="M715 155 L800 155" stroke="var(--danger)" stroke-width="1.5" fill="none" stroke-dasharray="6,3"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> LLM orchestrator = token tax ที่ซ่อนอยู่ — ทุก sub-agent response วนกลับเข้า main context</div>

<!-- Speaker: เปรียบเหมือนให้ผู้จัดการอ่านรายงานทุกฉบับก่อนส่งต่อ แทนที่พนักงานส่งกันตรงๆ -->

---

## วิธีแก้: JavaScript Code แทน LLM Orchestrator

<p class="subhead">Workflow Tool ให้เขียน .js ที่ orchestrate agents — deterministic, ไม่มี token tax</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- After: JS orchestrator -->
  <rect x="40" y="15" width="1020" height="255" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5" opacity=".7"/>
  <text x="550" y="48" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">หลังใช้ Workflow Tool — JS code เป็น orchestrator</text>

  <!-- JS Orchestrator top -->
  <rect x="380" y="65" width="340" height="70" rx="10" fill="var(--success)" opacity=".2" stroke="var(--success)" stroke-width="2"/>
  <text x="550" y="97" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">JavaScript Code</text>
  <text x="550" y="118" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Orchestrator (deterministic)</text>

  <!-- Lines down -->
  <line x1="460" y1="135" x2="300" y2="175" stroke="var(--success)" stroke-width="1.5"/>
  <line x1="550" y1="135" x2="550" y2="175" stroke="var(--success)" stroke-width="1.5"/>
  <line x1="640" y1="135" x2="800" y2="175" stroke="var(--success)" stroke-width="1.5"/>

  <!-- Sub-agents bottom row -->
  <rect x="130" y="175" width="200" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="230" y="200" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sub-Agent A</text>
  <text x="230" y="220" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">schema: {id, title, count}</text>

  <rect x="450" y="175" width="200" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="200" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sub-Agent B</text>
  <text x="550" y="220" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">รับ data ตรงจาก JS</text>

  <rect x="770" y="175" width="200" height="60" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="870" y="200" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Sub-Agent C</text>
  <text x="870" y="220" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">parallel หรือ sequential</text>

</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> JS orchestrator = deterministic, testable, reproducible — ข้อมูลไหลตรงระหว่าง sub-agents ไม่ผ่าน main context</div>

<!-- Speaker: แนวคิดหลัก: เปลี่ยน non-deterministic LLM เป็น JavaScript ที่ควบคุมได้ 100% -->

---

## Parallel + Pipeline: Throughput สูงสุด

<p class="subhead">Fan out agents พร้อมกัน + pipeline ที่ไม่ต้องรอทุก parallel agent เสร็จก่อนเริ่ม stage ถัดไป</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Stage 1: Parallel fan-out -->
  <rect x="40" y="100" width="140" height="100" rx="10" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="110" y="142" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Stage 1</text>
  <text x="110" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Fan Out</text>
  <text x="110" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Promise.all()</text>

  <!-- Fan out arrows -->
  <path d="M185 120 L310 80" stroke="var(--accent)" stroke-width="1.5" fill="none"/>
  <path d="M185 140 L310 140" stroke="var(--accent)" stroke-width="1.5" fill="none"/>
  <path d="M185 160 L310 200" stroke="var(--accent)" stroke-width="1.5" fill="none"/>

  <!-- Parallel research agents -->
  <rect x="310" y="60" width="180" height="50" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="400" y="82" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Research A</text>
  <text x="400" y="100" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">parallel</text>

  <rect x="310" y="120" width="180" height="50" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="400" y="142" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Research B</text>
  <text x="400" y="160" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">parallel</text>

  <rect x="310" y="180" width="180" height="50" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="400" y="202" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Research C</text>
  <text x="400" y="220" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">parallel</text>

  <!-- Converge arrows to stage 2 -->
  <path d="M495 85 L580 130" stroke="var(--success)" stroke-width="1.5" fill="none"/>
  <path d="M495 145 L580 150" stroke="var(--success)" stroke-width="1.5" fill="none"/>
  <path d="M495 205 L580 170" stroke="var(--success)" stroke-width="1.5" fill="none"/>

  <!-- Stage 2 pipeline label -->
  <rect x="580" y="100" width="140" height="100" rx="10" fill="var(--success)" opacity=".15" stroke="var(--success)" stroke-width="1.5"/>
  <text x="650" y="142" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Stage 2</text>
  <text x="650" y="162" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Pipeline</text>
  <text x="650" y="180" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่รอทุกตัว</text>

  <!-- Pipeline agents -->
  <path d="M725 120 L800 90" stroke="var(--success)" stroke-width="1.5" fill="none"/>
  <path d="M725 145 L800 145" stroke="var(--success)" stroke-width="1.5" fill="none"/>
  <path d="M725 170 L800 200" stroke="var(--success)" stroke-width="1.5" fill="none"/>

  <rect x="800" y="70" width="180" height="50" rx="8" fill="var(--success)" opacity=".12" stroke="var(--success)" stroke-width="1.5"/>
  <text x="890" y="92" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Write Email A</text>
  <text x="890" y="110" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">เริ่มทันทีที่ A เสร็จ</text>

  <rect x="800" y="130" width="180" height="50" rx="8" fill="var(--success)" opacity=".12" stroke="var(--success)" stroke-width="1.5"/>
  <text x="890" y="152" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Write Email B</text>
  <text x="890" y="170" font-size="11" fill="var(--success)" text-anchor="middle" font-family="system-ui">ไม่รอ C</text>

  <rect x="800" y="190" width="180" height="50" rx="8" fill="var(--success)" opacity=".12" stroke="var(--success)" stroke-width="1.5"/>
  <text x="890" y="212" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Write Email C</text>
  <text x="890" y="230" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">streaming pipeline</text>

</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Parallel fan-out + streaming pipeline = throughput สูงสุด — เวลารวม = เวลาของ agent ที่ช้าที่สุดตัวเดียว</div>

<!-- Speaker: ตัวอย่าง 8 leads research agents ทำงานพร้อมกัน ไม่ใช่ sequential 8 ครั้ง -->

---

## Schema Validation + Auto-Retry: Reliable Workflow

<p class="subhead">Schema ทำให้ JavaScript อ่านข้อมูลจาก agent ได้ปลอดภัย, auto-retry 3 ครั้งกัน transient fail</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Schema Validation</p>
    <h3>Type-Safe Inter-Agent Data</h3>
    <p>กำหนด schema ที่ sub-agent ต้องคืนมา:</p>
    <p><code>{ issueId: "string", affectedUsers: "number" }</code></p>
    <p>JavaScript filter/sort/transform ข้อมูลได้ปลอดภัย</p>
    <p>เป็น soft contract — validate ใน JS ก่อนส่งต่อเสมอ</p>
  </div>
  <div class="card success">
    <p class="label">Auto-Retry</p>
    <h3>Resilient Long Workflows</h3>
    <p>ถ้า sub-agent fail (เช่น MCP crash) → retry อัตโนมัติสูงสุด 3 ครั้ง</p>
    <p>Workflow ไม่ต้องเริ่มใหม่ตั้งแต่ต้น</p>
    <p>ระวัง: fail เกิน 3 ครั้ง → หยุด ควรออกแบบ fallback เอง</p>
    <p>MCP server down ทั้งหมด → health check ก่อนเริ่ม</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Schema + auto-retry = workflow ยาวๆ ที่ resilient — production-grade โดยไม่ต้องเขียน error handling เอง</div>

<!-- Speaker: schema เป็น soft contract ไม่ใช่ hard type — validate ใน JavaScript ก่อนส่งต่อทุกครั้ง -->

---

## Use Case: เมื่อไหร่ควรใช้ Workflow Tool

<p class="subhead">เหมาะกับงานซ้ำๆ ที่ต้องการ loop, conditional, parallel — ไม่ใช่ one-off task</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">ดีมาก</p>
    <h3>Triage Bugs ทุกวัน</h3>
    <p>Repeatable, structured, มี filter logic. เช่น Sentry triage อัตโนมัติทุกเช้า</p>
  </div>
  <div class="card success">
    <p class="label">ดีมาก</p>
    <h3>Bulk Outreach</h3>
    <p>Parallel research + pipeline write email — throughput สูงสุดสำหรับ 8+ leads พร้อมกัน</p>
  </div>
  <div class="card danger">
    <p class="label">ไม่คุ้ม</p>
    <h3>One-Off Task</h3>
    <p>Setup overhead สูงเกิน ถ้าทำแค่ครั้งเดียว ใช้ Claude Code session ปกติดีกว่า</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถามตัวเองก่อน: "งานนี้จะทำซ้ำไหม?" ใช่ → Workflow, ไม่ใช่ → session ปกติ</div>

<!-- Speaker: Workflow tool เหมาะที่สุดกับงาน dead code sweep, nightly bug triage, batch personalization -->

---

## Key Takeaways — Workflow Tool เปลี่ยน Multi-Agent

<p class="subhead">จาก LLM ที่ non-deterministic มาเป็น JavaScript ที่ควบคุมได้ — คุณภาพสูงขึ้น ต้นทุนต่ำลง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Core Change</p>
    <h3>JS แทน LLM Orchestrator</h3>
    <p>Deterministic, testable, reproducible. ข้อมูลไหลตรงระหว่าง agents ไม่ผ่าน main context</p>
  </div>
  <div class="card success">
    <p class="label">Performance</p>
    <h3>Zero Token Tax</h3>
    <p>Parallel fan-out + streaming pipeline = throughput สูงสุด. รัน hundreds of agents ได้โดยไม่ overflow</p>
  </div>
  <div class="card gold">
    <p class="label">Reliability</p>
    <h3>Schema + Auto-Retry</h3>
    <p>Type-safe inter-agent data + 3-retry resilience สำหรับ transient failures. Production-ready</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Workflow Tool = เปลี่ยน "agent ลองผิดลองถูก" ให้กลายเป็น "pipeline ที่ควบคุมได้" — เหมาะสำหรับงานซ้ำๆ ระดับ production</div>

<!-- Speaker: ถ้าจำได้อย่างเดียว — JS orchestrator ขจัด token tax ได้หมด ทำให้ multi-agent economically viable -->
