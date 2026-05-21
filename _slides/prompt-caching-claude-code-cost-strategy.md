---
marp: true
theme: default
paginate: true
title: "Prompt Caching: กลยุทธ์ลดต้นทุน Claude Code"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:28px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:16px; margin:0 0 8px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; }
  section.title h1 { font-size:44px; color:white; margin:0; }
  section.title p { color:#93c5fd; font-size:18px; margin-top:16px; }
---

<!-- _class: title -->

# Prompt Caching
### กลยุทธ์ลดต้นทุน Claude Code 90%

**Cache read ราคาเพียง 10% ของ input ปกติ — TTL, Prefix Matching และ Session Management**

<!-- Speaker note: Prompt caching is one of the highest-ROI optimizations for Claude API/Claude Code users. Covers: pricing tiers, TTL options, prefix matching, invalidation triggers, and 5 practical steps. -->

---

## Cache Read คิดแค่ 10% — ประหยัด 90% ทันที

<p class="subhead">Prompt Caching เก็บ context ที่ซ้ำกัน ให้ re-use ในราคาถูก โดยไม่ต้อง re-process ใหม่ทุก turn</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="20" width="980" height="320" rx="20" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="60" y="20" width="12" height="320" rx="6" fill="var(--accent)"/>
  <text x="260" y="155" font-size="90" font-weight="900" fill="var(--accent)" text-anchor="middle" font-family="system-ui">90%</text>
  <text x="260" y="230" font-size="17" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ประหยัดได้จาก Cache Read</text>
  <line x1="460" y1="60" x2="460" y2="300" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <text x="510" y="75" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">ราคาเทียบกับ Base Input Price</text>
  <rect x="510" y="90" width="250" height="50" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1"/>
  <text x="528" y="113" font-size="13" fill="var(--muted)" font-family="system-ui">Cache Write (5-min TTL)</text>
  <text x="748" y="120" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="end" font-family="system-ui">1.25×</text>
  <rect x="510" y="150" width="250" height="50" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1"/>
  <text x="528" y="173" font-size="13" fill="var(--muted)" font-family="system-ui">Cache Write (1-hr TTL)</text>
  <text x="748" y="180" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="end" font-family="system-ui">2×</text>
  <rect x="510" y="210" width="250" height="58" rx="8" fill="var(--accent)" opacity="0.1" stroke="var(--accent)" stroke-width="2"/>
  <text x="528" y="234" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">Cache Read (Hit)</text>
  <text x="748" y="246" font-size="22" font-weight="900" fill="var(--accent)" text-anchor="end" font-family="system-ui">0.1×</text>
  <text x="528" y="260" font-size="12" fill="var(--accent)" font-family="system-ui">← นี่คือเป้าหมาย</text>
  <text x="810" y="100" font-size="13" fill="var(--muted)" font-family="system-ui">Opus 4.7 ($5/MTok base)</text>
  <text x="810" y="125" font-size="13" fill="var(--muted)" font-family="system-ui">Write 5-min: $6.25/MTok</text>
  <text x="810" y="150" font-size="13" fill="var(--muted)" font-family="system-ui">Write 1-hr:  $10.00/MTok</text>
  <text x="810" y="182" font-size="16" font-weight="700" fill="var(--accent)" font-family="system-ui">Read:  $0.50/MTok</text>
  <text x="810" y="204" font-size="12" fill="var(--muted)" font-family="system-ui">vs $5 ปกติ = ประหยัด 90%</text>
  <text x="810" y="240" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">↗ เพิ่ม Cache Hits</text>
  <text x="810" y="260" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">   = ลด Cost ได้ทันที</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Write แพงขึ้นเล็กน้อย แต่ทุก Hit ที่เกิดขึ้นประหยัด 90% — Breakeven เกิดเร็วมาก</div>

<!-- Speaker note: Core math: pay slightly more to write cache once, then every re-read costs only 10%. For large CLAUDE.md + memory files injected every turn, this compounds quickly. -->

---

## ไม่มี Cache = จ่ายราคาเต็มทุก Turn โดยไม่จำเป็น

<p class="subhead">Claude Code inject CLAUDE.md, memory files, skills ซ้ำทุก turn — กับ Cache ต้องจ่ายเต็มแค่ครั้งแรก</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="480" height="320" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--muted)" opacity="0.18"/>
  <rect x="30" y="60" width="480" height="12" fill="var(--muted)" opacity="0.18"/>
  <text x="270" y="50" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">❌ ไม่มี Prompt Cache</text>
  <rect x="55" y="88" width="430" height="50" rx="6" fill="var(--soft)"/>
  <text x="72" y="108" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Turn 1</text>
  <text x="72" y="126" font-size="11" fill="var(--muted)" font-family="system-ui">CLAUDE.md(800t)+Memory(300t)+Task(50t) = 1150t</text>
  <text x="460" y="117" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="end" font-family="system-ui">$5.75</text>
  <rect x="55" y="148" width="430" height="50" rx="6" fill="var(--soft)"/>
  <text x="72" y="168" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Turn 2</text>
  <text x="72" y="186" font-size="11" fill="var(--muted)" font-family="system-ui">CLAUDE.md(800t)+Memory(300t)+Task(50t) = 1150t</text>
  <text x="460" y="177" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="end" font-family="system-ui">$5.75</text>
  <rect x="55" y="208" width="430" height="50" rx="6" fill="var(--soft)"/>
  <text x="72" y="228" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Turn 3</text>
  <text x="72" y="246" font-size="11" fill="var(--muted)" font-family="system-ui">CLAUDE.md(800t)+Memory(300t)+Task(50t) = 1150t</text>
  <text x="460" y="237" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="end" font-family="system-ui">$5.75</text>
  <text x="270" y="305" font-size="16" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">3 turns รวม: $17.25</text>
  <rect x="590" y="20" width="480" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--accent)" opacity="0.1"/>
  <rect x="590" y="60" width="480" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="830" y="50" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">✅ มี Prompt Cache</text>
  <rect x="615" y="88" width="430" height="50" rx="6" fill="var(--soft)"/>
  <text x="632" y="108" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Turn 1 (Cache Write)</text>
  <text x="632" y="126" font-size="11" fill="var(--muted)" font-family="system-ui">prefix cached(1.25x) + Task(1x) = 1150t</text>
  <text x="1020" y="117" font-size="13" font-weight="700" fill="var(--muted)" text-anchor="end" font-family="system-ui">$7.19</text>
  <rect x="615" y="148" width="430" height="50" rx="6" fill="var(--accent)" opacity="0.08" stroke="var(--accent)" stroke-width="1"/>
  <text x="632" y="168" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">Turn 2 (Cache Hit ✓)</text>
  <text x="632" y="186" font-size="11" fill="var(--muted)" font-family="system-ui">prefix(0.1x) + Task(1x) = 1150t</text>
  <text x="1020" y="177" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="end" font-family="system-ui">$0.87</text>
  <rect x="615" y="208" width="430" height="50" rx="6" fill="var(--accent)" opacity="0.08" stroke="var(--accent)" stroke-width="1"/>
  <text x="632" y="228" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">Turn 3 (Cache Hit ✓)</text>
  <text x="632" y="246" font-size="11" fill="var(--muted)" font-family="system-ui">prefix(0.1x) + Task(1x) = 1150t</text>
  <text x="1020" y="237" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="end" font-family="system-ui">$0.87</text>
  <text x="830" y="305" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3 turns รวม: $8.93 (ประหยัด 48%)</text>
  <circle cx="550" cy="190" r="26" fill="var(--accent)"/>
  <text x="550" y="190" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">vs</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Session ที่มี 3+ turns คุ้มทุนตั้งแต่ Turn 2 — ยิ่ง session ยาว ยิ่งประหยัด</div>

<!-- Speaker note: Example uses 1100 tokens CLAUDE.md+Memory+Task at $5/MTok base. After 3 turns: no-cache $17.25 vs with-cache $8.93. Savings grow with session length. -->

---

## 5-min vs 1-hr TTL — เลือกตาม Workflow Pause Time

<p class="subhead">Default TTL คือ 5 นาที, extended TTL คือ 1 ชั่วโมง — ราคา write ต่างกัน แต่ read เท่ากัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="30" y="20" width="490" height="64" rx="14" fill="var(--soft)"/>
  <rect x="30" y="72" width="490" height="12" fill="var(--soft)"/>
  <text x="275" y="48" font-size="17" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">⏱ 5-Minute TTL (Default)</text>
  <text x="275" y="68" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Cache write: 1.25× base price</text>
  <text x="65" y="115" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Auto-refresh ทุกครั้งที่ hit (ฟรี)</text>
  <text x="65" y="145" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Claude Code session ทั่วไป</text>
  <text x="65" y="175" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Rapid iteration / debugging</text>
  <text x="65" y="205" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Multi-turn conversation ต่อเนื่อง</text>
  <rect x="55" y="230" width="440" height="88" rx="8" fill="#f8fafc" stroke="var(--muted)" stroke-width="1"/>
  <text x="75" y="256" font-size="12" fill="var(--muted)" font-family="monospace">cache_control={"type": "ephemeral"}</text>
  <text x="75" y="278" font-size="12" fill="var(--accent)" font-family="monospace"># 1 line เท่านั้น, no ttl key</text>
  <text x="75" y="300" font-size="12" fill="var(--muted)" font-family="monospace">← system จัดการ breakpoint อัตโนมัติ</text>
  <rect x="580" y="20" width="490" height="320" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="580" y="20" width="490" height="64" rx="14" fill="var(--accent)" opacity="0.1"/>
  <rect x="580" y="72" width="490" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="825" y="48" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">⏰ 1-Hour TTL (Extended)</text>
  <text x="825" y="68" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Cache write: 2× base price</text>
  <text x="615" y="115" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Agentic workflow ที่มี pause &gt; 5 นาที</text>
  <text x="615" y="145" font-size="14" fill="var(--ink)" font-family="system-ui">✅  User session ที่ตอบไม่สม่ำเสมอ</text>
  <text x="615" y="175" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Latency-critical app (pre-warm)</text>
  <text x="615" y="205" font-size="14" fill="var(--ink)" font-family="system-ui">✅  Content อัปเดตนานๆ ครั้ง (handbook)</text>
  <rect x="605" y="230" width="440" height="88" rx="8" fill="#f8fafc" stroke="var(--muted)" stroke-width="1"/>
  <text x="625" y="256" font-size="12" fill="var(--muted)" font-family="monospace">cache_control={</text>
  <text x="625" y="278" font-size="12" fill="var(--muted)" font-family="monospace">  "type": "ephemeral", "ttl": "1h"</text>
  <text x="625" y="300" font-size="12" fill="var(--muted)" font-family="monospace">}</text>
  <circle cx="550" cy="190" r="26" fill="var(--accent)"/>
  <text x="550" y="190" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">or</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ 5-min สำหรับ coding session; ใช้ 1-hr สำหรับ agentic task ที่แต่ละ step ห่างกันเกิน 5 นาที</div>

<!-- Speaker note: 1-hr TTL costs 2x to write but essential for long pipelines. If agent steps are 10+ min apart, 5-min TTL means every step is a cache miss and you pay 1.25x for nothing. -->

---

## Breakpoint บน Stable Content เท่านั้น

<p class="subhead">Cache hash คำนวณจากทุกอย่างถึง breakpoint — ถ้า breakpoint อยู่บน dynamic content → hit = 0 ทุกครั้ง</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="550" y="30" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cache Invalidation Hierarchy</text>
  <rect x="340" y="44" width="420" height="46" rx="8" fill="var(--danger)" opacity="0.12" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="550" y="72" font-size="14" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">tools [ ] — เปลี่ยน → invalidate ทุกอย่าง</text>
  <line x1="550" y1="90" x2="550" y2="108" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="544,106 556,106 550,116" fill="var(--muted)"/>
  <rect x="180" y="116" width="740" height="46" rx="8" fill="var(--muted)" opacity="0.12" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="144" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">system [ ] — เปลี่ยน → invalidate system + messages</text>
  <line x1="550" y1="162" x2="550" y2="180" stroke="var(--muted)" stroke-width="2"/>
  <polygon points="544,178 556,178 550,188" fill="var(--muted)"/>
  <rect x="40" y="188" width="1020" height="46" rx="8" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="216" font-size="14" fill="var(--ink)" text-anchor="middle" font-family="system-ui">messages [ ] — conversation history, auto-cached</text>
  <rect x="40" y="258" width="490" height="108" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="285" y="283" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">✅ Breakpoint ที่ถูก</text>
  <text x="65" y="308" font-size="13" fill="var(--ink)" font-family="system-ui">"You are an engineer assistant..."</text>
  <rect x="65" y="316" width="220" height="20" rx="4" fill="var(--accent)" opacity="0.15"/>
  <text x="65" y="330" font-size="12" fill="var(--accent)" font-family="system-ui">cache_control ← stable ✓</text>
  <text x="65" y="352" font-size="12" fill="var(--muted)" font-family="system-ui">f"Task: {task}" ← ไม่มี cache_control</text>
  <rect x="570" y="258" width="490" height="108" rx="10" fill="var(--paper)" stroke="var(--danger)" stroke-width="2"/>
  <text x="815" y="283" font-size="14" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">❌ Breakpoint ที่ผิด</text>
  <text x="595" y="308" font-size="13" fill="var(--ink)" font-family="system-ui">"You are an engineer assistant..."</text>
  <text x="595" y="330" font-size="13" fill="var(--ink)" font-family="system-ui">f"Time: {datetime.now()}"</text>
  <rect x="595" y="338" width="220" height="20" rx="4" fill="var(--danger)" opacity="0.15"/>
  <text x="595" y="352" font-size="12" fill="var(--danger)" font-family="system-ui">cache_control ← เปลี่ยนทุก request ❌</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใส่ cache_control ที่ block สุดท้ายที่ stable — dynamic content ต้องอยู่หลัง breakpoint เสมอ</div>

<!-- Speaker note: The hash includes everything up to and including the breakpoint block. One dynamic element AT the breakpoint means zero cache hits. Timestamps, task IDs, user context — all must come AFTER. -->

---

## Model Switch = Cache Reset ทั้งหมด

<p class="subhead">5 actions ที่ทำให้ cache หายไปทันที — model switching เป็น killer ที่พบบ่อยที่สุดใน Claude Code</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="60" y="36" font-size="13" font-weight="700" fill="var(--muted)" font-family="system-ui">Action</text>
  <text x="580" y="36" font-size="13" font-weight="700" fill="var(--muted)" font-family="system-ui">Impact</text>
  <text x="840" y="36" font-size="13" font-weight="700" fill="var(--muted)" font-family="system-ui">Scope</text>
  <line x1="40" y1="44" x2="1060" y2="44" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <rect x="40" y="52" width="1020" height="54" rx="6" fill="var(--danger)" opacity="0.08"/>
  <rect x="40" y="52" width="5" height="54" rx="2" fill="var(--danger)"/>
  <text x="62" y="74" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">⚡ สลับ Model (Sonnet ↔ Opus)</text>
  <text x="62" y="94" font-size="12" fill="var(--muted)" font-family="system-ui">เปลี่ยน model parameter ระหว่าง session</text>
  <text x="590" y="83" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">❌ Reset ทั้งหมด</text>
  <text x="848" y="83" font-size="13" fill="var(--danger)" font-family="system-ui">tools + system + messages</text>
  <rect x="40" y="114" width="1020" height="50" rx="6" fill="var(--soft)"/>
  <text x="62" y="134" font-size="14" fill="var(--ink)" font-family="system-ui">แก้ไข tool definitions</text>
  <text x="62" y="154" font-size="12" fill="var(--muted)" font-family="system-ui">เปลี่ยน JSON key order ก็ invalid (Go/Swift)</text>
  <text x="590" y="143" font-size="14" fill="var(--danger)" font-family="system-ui">❌ Invalid ทุกอย่าง</text>
  <text x="848" y="143" font-size="13" fill="var(--muted)" font-family="system-ui">tools + system + messages</text>
  <rect x="40" y="172" width="1020" height="50" rx="6" fill="var(--soft)"/>
  <text x="62" y="192" font-size="14" fill="var(--ink)" font-family="system-ui">Toggle web search / citations</text>
  <text x="62" y="212" font-size="12" fill="var(--muted)" font-family="system-ui">เปิด/ปิด feature settings</text>
  <text x="590" y="201" font-size="14" fill="var(--danger)" font-family="system-ui">❌ Invalid บางส่วน</text>
  <text x="848" y="201" font-size="13" fill="var(--muted)" font-family="system-ui">system + messages</text>
  <rect x="40" y="230" width="1020" height="50" rx="6" fill="var(--soft)"/>
  <text x="62" y="250" font-size="14" fill="var(--ink)" font-family="system-ui">เพิ่ม/ลบ images ใน messages</text>
  <text x="62" y="270" font-size="12" fill="var(--muted)" font-family="system-ui">multimodal input changes</text>
  <text x="590" y="259" font-size="14" fill="var(--danger)" font-family="system-ui">❌ Invalid messages</text>
  <text x="848" y="259" font-size="13" fill="var(--muted)" font-family="system-ui">messages เท่านั้น</text>
  <rect x="40" y="288" width="1020" height="50" rx="6" fill="var(--soft)"/>
  <text x="62" y="308" font-size="14" fill="var(--ink)" font-family="system-ui">Extended thinking settings เปลี่ยน</text>
  <text x="62" y="328" font-size="12" fill="var(--muted)" font-family="system-ui">budget tokens, streaming mode</text>
  <text x="590" y="317" font-size="14" fill="var(--danger)" font-family="system-ui">❌ Invalid messages</text>
  <text x="848" y="317" font-size="13" fill="var(--muted)" font-family="system-ui">messages เท่านั้น</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ห้ามสลับ model ระหว่าง session — นี่คือ cache killer อันดับ 1 ใน Claude Code</div>

<!-- Speaker note: Model switching is the most common mistake — users switch between claude-sonnet and claude-opus mid-session. Every cached token must be reprocessed from scratch. Pick one model per session. -->

---

## 5 ขั้นตอนสู่ Cache Hit Rate สูงสุด

<p class="subhead">จาก Stable Prefix ถึง Multiple Breakpoints — ทำครบทั้ง 5 เพื่อ maximize ROI จาก Prompt Caching</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="60" width="170" height="210" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="115" cy="100" r="22" fill="var(--accent)"/>
  <text x="115" y="100" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="115" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Stable Prefix</text>
  <text x="115" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CLAUDE.md</text>
  <text x="115" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">แก้น้อยๆ</text>
  <text x="115" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">reuse session</text>
  <line x1="200" y1="165" x2="228" y2="165" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="225,160 235,165 225,170" fill="var(--accent)"/>
  <rect x="235" y="60" width="170" height="210" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="320" cy="100" r="22" fill="var(--accent)"/>
  <text x="320" y="100" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="320" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เลือก TTL</text>
  <text x="320" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">5-min ทั่วไป</text>
  <text x="320" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">1-hr agentic</text>
  <line x1="405" y1="165" x2="433" y2="165" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="430,160 440,165 430,170" fill="var(--accent)"/>
  <rect x="440" y="60" width="170" height="210" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="525" cy="100" r="22" fill="var(--accent)"/>
  <text x="525" y="100" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="525" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Monitor</text>
  <text x="525" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">cache_read_</text>
  <text x="525" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">input_tokens</text>
  <text x="525" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">/cost command</text>
  <line x1="610" y1="165" x2="638" y2="165" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="635,160 645,165 635,170" fill="var(--accent)"/>
  <rect x="645" y="60" width="170" height="210" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="730" cy="100" r="22" fill="var(--accent)"/>
  <text x="730" y="100" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="730" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Pre-warm</text>
  <text x="730" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">fire ก่อน</text>
  <text x="730" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">user มาถึง</text>
  <text x="730" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">TTFT ↓</text>
  <line x1="815" y1="165" x2="843" y2="165" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="840,160 850,165 840,170" fill="var(--accent)"/>
  <rect x="850" y="60" width="220" height="210" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="960" cy="100" r="22" fill="var(--accent)"/>
  <text x="960" y="100" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">5</text>
  <text x="960" y="140" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Multi-Break</text>
  <text x="960" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">tools→cache</text>
  <text x="960" y="186" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">system→cache</text>
  <text x="960" y="204" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">msgs→auto</text>
  <text x="550" y="310" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ทำตามลำดับ — แต่ละขั้นสะสม hit rate เพิ่มขึ้น</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Step 1 (Stable Prefix) คุ้มค่าที่สุด — ทำอย่างเดียวก็ได้ผลแล้ว ไม่ต้องเปลี่ยน code</div>

<!-- Speaker note: Steps 1 and 4 require no code changes — just behavioral. Steps 2, 3, 5 are code-level optimizations. Start with 1, verify with 3, then layer in 2/4/5. -->

---

## กฎ 7 ข้อที่ต้องจำ

<p class="subhead">จาก pricing ถึง best practices — สรุปทุกอย่างใน 7 กฎ</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="14" width="500" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="72" cy="40" r="16" fill="var(--accent)"/>
  <text x="72" y="40" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="105" y="32" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Cache Read = 0.1× (ประหยัด 90%)</text>
  <text x="105" y="52" font-size="12" fill="var(--muted)" font-family="system-ui">เป้าหมายคือ maximize hits ไม่ใช่แค่ enable</text>
  <rect x="40" y="76" width="500" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="72" cy="102" r="16" fill="var(--accent)"/>
  <text x="72" y="102" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="105" y="94" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">2 TTL: 5-min และ 1-hr</text>
  <text x="105" y="114" font-size="12" fill="var(--muted)" font-family="system-ui">เลือกตาม workflow pause time</text>
  <rect x="40" y="138" width="500" height="52" rx="8" fill="var(--danger)" opacity="0.08" stroke="var(--danger)" stroke-width="1.5"/>
  <circle cx="72" cy="164" r="16" fill="var(--danger)"/>
  <text x="72" y="164" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="105" y="156" font-size="14" font-weight="700" fill="var(--danger)" font-family="system-ui">Model Switch = Cache Reset ทั้งหมด</text>
  <text x="105" y="176" font-size="12" fill="var(--muted)" font-family="system-ui">ไม่สลับ model ระหว่าง session เด็ดขาด</text>
  <rect x="40" y="200" width="500" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="72" cy="226" r="16" fill="var(--accent)"/>
  <text x="72" y="226" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="105" y="218" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">CLAUDE.md แก้น้อยๆ = Cache Miss ลด</text>
  <text x="105" y="238" font-size="12" fill="var(--muted)" font-family="system-ui">ทุกการเปลี่ยนแปลงทำให้ hash prefix ไม่ตรง</text>
  <rect x="580" y="14" width="480" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="612" cy="40" r="16" fill="var(--accent)"/>
  <text x="612" y="40" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">5</text>
  <text x="645" y="32" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">ตรวจ cache_read_input_tokens</text>
  <text x="645" y="52" font-size="12" fill="var(--muted)" font-family="system-ui">ตัวเลขนี้บอกว่า cache ทำงานจริงหรือเปล่า</text>
  <rect x="580" y="76" width="480" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="612" cy="102" r="16" fill="var(--accent)"/>
  <text x="612" y="102" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">6</text>
  <text x="645" y="94" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Breakpoint บน Stable Content เท่านั้น</text>
  <text x="645" y="114" font-size="12" fill="var(--muted)" font-family="system-ui">dynamic content ต้องอยู่หลัง breakpoint</text>
  <rect x="580" y="138" width="480" height="52" rx="8" fill="var(--soft)" stroke="var(--accent)" stroke-width="1"/>
  <circle cx="612" cy="164" r="16" fill="var(--accent)"/>
  <text x="612" y="164" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">7</text>
  <text x="645" y="156" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Pre-warm ก่อน User มาถึง</text>
  <text x="645" y="176" font-size="12" fill="var(--muted)" font-family="system-ui">TTFT ลดลงสำหรับ latency-critical app</text>
  <rect x="40" y="268" width="1020" height="56" rx="10" fill="var(--accent)" opacity="0.1" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="292" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">จ่าย write ครั้งเดียว — ประหยัด read ทุกครั้ง</text>
  <text x="550" y="314" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Source: Anthropic Prompt Caching Docs • youtu.be/6cEQEba0i2A</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มจากกฎ 3 (no model switch) + กฎ 4 (stable CLAUDE.md) — free wins ไม่ต้องเปลี่ยน code แม้แต่บรรทัดเดียว</div>

<!-- Speaker note: Rules 3 and 4 are behavioral changes only — no code changes needed. Start there, verify with rule 5, then layer in code-level optimizations (2, 6, 7). -->
