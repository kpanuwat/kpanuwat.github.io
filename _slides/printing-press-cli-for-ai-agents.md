---
marp: true
theme: default
paginate: true
title: "Printing Press: CLI Factory สำหรับ AI Agents"
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
---

<!-- _class: title -->

# Printing Press

**CLI Factory — ประหยัด Token 35× กว่า MCP สำหรับ AI Agents**

<!-- Speaker note: Printing Press คือ CLI factory สร้าง agent-native CLI จาก API spec หรือ URL ใดก็ได้ ใช้ token น้อยกว่า MCP 35 เท่า มีคลัง 45+ CLI สำเร็จรูป -->

---

## MCP ใช้ Token มากกว่า CLI ถึง 35 เท่า

<p class="subhead">MindStudio benchmark: MCP reliability ลดจาก 100% → 72% เมื่อ task ซับซ้อน; CLI คงที่ที่ 100%</p>

<div class="infographic">
<svg viewBox="0 0 1100 400" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="30" width="470" height="340" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="30" width="470" height="56" rx="12" fill="var(--muted)" opacity="0.15"/>
  <text x="275" y="66" font-size="20" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MCP Server</text>
  <text x="75" y="125" font-size="14" fill="var(--ink)" font-family="system-ui">📦 Schema loading ทุก call</text>
  <text x="75" y="158" font-size="14" fill="var(--ink)" font-family="system-ui">🔄 หลาย round trips ต่อ query</text>
  <text x="75" y="191" font-size="14" fill="var(--ink)" font-family="system-ui">📄 Raw JSON parsing ใน context</text>
  <text x="75" y="224" font-size="14" fill="var(--ink)" font-family="system-ui">📉 Reliability: ~72% (complex tasks)</text>
  <text x="75" y="280" font-size="30" font-weight="900" fill="var(--danger)" font-family="system-ui">35× more tokens</text>
  <rect x="590" y="30" width="470" height="340" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="590" y="30" width="470" height="56" rx="12" fill="var(--accent)" opacity="0.12"/>
  <text x="825" y="66" font-size="20" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">CLI (Printing Press)</text>
  <text x="625" y="125" font-size="14" fill="var(--ink)" font-family="system-ui">⚡ Compiled binary — ไม่มี schema</text>
  <text x="625" y="158" font-size="14" fill="var(--ink)" font-family="system-ui">🔗 Compound commands (1 call)</text>
  <text x="625" y="191" font-size="14" fill="var(--ink)" font-family="system-ui">💾 Local SQLite mirror, 50ms</text>
  <text x="625" y="224" font-size="14" fill="var(--ink)" font-family="system-ui">✅ Reliability: 100%</text>
  <text x="625" y="280" font-size="30" font-weight="900" fill="var(--accent)" font-family="system-ui">35× fewer tokens</text>
  <circle cx="550" cy="200" r="32" fill="var(--ink)"/>
  <text x="550" y="200" font-size="15" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Token savings ไม่ใช่แค่ค่าใช้จ่าย — มันส่งผลตรงต่อ reliability ของ agent workflow ด้วย</div>

<!-- Speaker note: ตัวเลข 35× จาก MindStudio benchmark; reliability 72% vs 100% คือความแตกต่างระหว่าง workflow ที่ใช้งานได้จริงกับที่ไม่ได้ -->

---

## Printing Press พิมพ์ 3 Artifact จาก Source เดียว

<p class="subhead">หนึ่ง API spec, URL, หรือ HAR file → Go CLI + Claude Code skill + MCP server พร้อมใช้ใน ~10 นาที</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="340" y="15" width="420" height="72" rx="12" fill="var(--ink)" opacity="0.88"/>
  <text x="550" y="46" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Input: API spec / URL / HAR file</text>
  <text x="550" y="70" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ใช้เวลา ~10 นาที</text>
  <rect x="545" y="87" width="10" height="48" fill="var(--accent)"/>
  <rect x="180" y="135" width="740" height="4" fill="var(--accent)"/>
  <rect x="180" y="135" width="4" height="48" fill="var(--accent)"/>
  <rect x="40" y="183" width="290" height="110" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="185" y="220" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Go Binary (CLI)</text>
  <text x="185" y="244" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">รัน local, 50ms queries</text>
  <text x="185" y="268" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">--compact, auto-JSON</text>
  <rect x="545" y="135" width="4" height="48" fill="var(--accent)"/>
  <rect x="400" y="183" width="300" height="110" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="220" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude Code Skill</text>
  <text x="550" y="244" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">/printing-press &lt;app&gt;</text>
  <text x="550" y="268" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">curated agent loop</text>
  <rect x="916" y="135" width="4" height="48" fill="var(--muted)"/>
  <rect x="770" y="183" width="290" height="110" rx="12" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="915" y="220" font-size="16" font-weight="700" fill="var(--muted)" text-anchor="middle" font-family="system-ui">MCP Server</text>
  <text x="915" y="244" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">harness อื่น</text>
  <text x="915" y="268" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">optional fallback</text>
  <text x="550" y="335" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ AGENTS.md operating guide พร้อมทุก CLI</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> หนึ่งคำสั่ง ได้สามสิ่ง — ใช้ CLI เป็นหลัก, MCP เป็น fallback สำหรับ harness ที่ไม่รองรับ CLI</div>

<!-- Speaker note: Press สร้าง Go CLI + Claude Code skill + MCP server พร้อมกัน; primary path คือ CLI ผ่าน skill -->

---

## Agent-Native CLI มี 4 คุณสมบัติที่ Raw API ไม่มี

<p class="subhead">ออกแบบให้ agent ใช้งาน — output และ behavior ปรับตาม context อัตโนมัติ</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="15" width="510" height="150" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="85" cy="90" r="34" fill="var(--accent)"/>
  <text x="85" y="90" font-size="18" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">{}</text>
  <text x="140" y="72" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Auto-JSON when piped</text>
  <text x="140" y="98" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่ต้องใส่ --json flag</text>
  <text x="140" y="118" font-size="13" fill="var(--muted)" font-family="system-ui">output ปรับตาม context เอง</text>
  <rect x="570" y="15" width="510" height="150" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="635" cy="90" r="34" fill="var(--accent)"/>
  <text x="635" y="90" font-size="13" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">-80%</text>
  <text x="690" y="72" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">--compact flag</text>
  <text x="690" y="98" font-size="13" fill="var(--muted)" font-family="system-ui">ลด output 60-80%</text>
  <text x="690" y="118" font-size="13" fill="var(--muted)" font-family="system-ui">เก็บเฉพาะ high-gravity fields</text>
  <rect x="20" y="200" width="510" height="150" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="85" cy="275" r="34" fill="var(--accent)"/>
  <text x="85" y="275" font-size="20" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">⚡</text>
  <text x="140" y="257" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Compound commands</text>
  <text x="140" y="283" font-size="13" fill="var(--muted)" font-family="system-ui">หลาย source ในคำสั่งเดียว</text>
  <text x="140" y="303" font-size="13" fill="var(--muted)" font-family="system-ui">ตัด 10 round trips → 1 call</text>
  <rect x="570" y="200" width="510" height="150" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="635" cy="275" r="34" fill="var(--accent)"/>
  <text x="635" y="275" font-size="12" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">50ms</text>
  <text x="690" y="257" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Local SQLite mirror</text>
  <text x="690" y="283" font-size="13" fill="var(--muted)" font-family="system-ui">query วิ่ง 50ms local</text>
  <text x="690" y="303" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่รอ remote API</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> --compact + compound commands คือคู่หู — ลด output size และตัด round trips พร้อมกัน</div>

<!-- Speaker note: 4 features นี้คือสิ่งที่ทำให้ CLI มี token overhead ต่ำกว่า MCP อย่างมีนัยสำคัญ -->

---

## Library: 45+ CLI สำเร็จรูป ติดตั้งแล้วใช้เลย

<p class="subhead">ESPN (no official API), Flight Goat (Kayak + Google Flights fused), Linear (50ms SQLite) — ทุกตัวมี AGENTS.md</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="15" y="10" width="340" height="340" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="15" y="10" width="340" height="52" rx="12" fill="var(--accent)" opacity="0.15"/>
  <text x="185" y="43" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ESPN CLI</text>
  <text x="35" y="85" font-size="11" fill="var(--muted)" font-family="monospace">$ pp-espn nba playoffs tonight</text>
  <rect x="30" y="98" width="310" height="76" rx="6" fill="white" stroke="var(--muted)" stroke-width="1"/>
  <text x="46" y="120" font-size="11" fill="var(--ink)" font-family="monospace">OKC 131 – PHX 122 (Final)</text>
  <text x="46" y="138" font-size="11" fill="var(--ink)" font-family="monospace">Series: OKC leads 3-1</text>
  <text x="46" y="156" font-size="11" fill="var(--ink)" font-family="monospace">SGA: 34pts 8ast | Injury: none</text>
  <text x="35" y="202" font-size="12" fill="var(--muted)" font-family="system-ui">Sniffed API — ไม่มี official docs</text>
  <text x="35" y="222" font-size="12" fill="var(--muted)" font-family="system-ui">Live score + series state + injury</text>
  <text x="35" y="242" font-size="12" fill="var(--muted)" font-family="system-ui">ในคำสั่งเดียว</text>
  <rect x="380" y="10" width="340" height="340" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="380" y="10" width="340" height="52" rx="12" fill="var(--accent)" opacity="0.15"/>
  <text x="550" y="43" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Flight Goat</text>
  <text x="398" y="85" font-size="10" fill="var(--muted)" font-family="monospace">$ pp-flight-goat sea long-haul nonstop...</text>
  <rect x="395" y="98" width="310" height="76" rx="6" fill="white" stroke="var(--muted)" stroke-width="1"/>
  <text x="410" y="120" font-size="11" fill="var(--ink)" font-family="monospace">1. London LHR  $4,953  Delta</text>
  <text x="410" y="138" font-size="11" fill="var(--ink)" font-family="monospace">2. Amsterdam AMS $5,052</text>
  <text x="410" y="156" font-size="11" fill="var(--ink)" font-family="monospace">3. Tokyo HND   $5,817  ANA</text>
  <text x="398" y="202" font-size="12" fill="var(--muted)" font-family="system-ui">Kayak + Google Flights fused</text>
  <text x="398" y="222" font-size="12" fill="var(--muted)" font-family="system-ui">2 sources ใน 1 query</text>
  <text x="398" y="242" font-size="12" fill="var(--muted)" font-family="system-ui">filter: nonstop 8+h, 4 pax</text>
  <rect x="745" y="10" width="340" height="340" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="745" y="10" width="340" height="52" rx="12" fill="var(--accent)" opacity="0.15"/>
  <text x="915" y="43" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Linear CLI</text>
  <text x="763" y="85" font-size="10" fill="var(--muted)" font-family="monospace">$ linear-pp-cli "blocked 1 week+"</text>
  <rect x="760" y="98" width="310" height="76" rx="6" fill="white" stroke="var(--muted)" stroke-width="1"/>
  <text x="776" y="120" font-size="11" fill="var(--ink)" font-family="monospace">ENG-142: Auth timeout</text>
  <text x="776" y="138" font-size="11" fill="var(--ink)" font-family="monospace">  blocked by ENG-89 (9d)</text>
  <text x="776" y="156" font-size="11" fill="var(--ink)" font-family="monospace">  assignee: unassigned</text>
  <text x="763" y="202" font-size="12" fill="var(--muted)" font-family="system-ui">SQLite mirror: 50ms query</text>
  <text x="763" y="222" font-size="12" fill="var(--muted)" font-family="system-ui">compound query ที่ Linear API</text>
  <text x="763" y="242" font-size="12" fill="var(--muted)" font-family="system-ui">ตอบไม่ได้โดยตรง</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า CLI ที่ต้องการมีใน library แล้ว — ติดตั้งทันที ไม่ต้องลงทุน 10 นาที generate เอง</div>

<!-- Speaker note: Library ครอบคลุม travel, sports, media, productivity, food และอีก 40+ รายการ -->

---

## Factory สร้าง CLI จาก URL ใดก็ได้ใน ~10 นาที

<p class="subhead">ไม่มี OpenAPI spec ไม่เป็นไร — Press เปิด browser, sniff traffic, reverse-engineer API เอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="60" width="220" height="160" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="130" cy="115" r="32" fill="var(--accent)"/>
  <text x="130" y="115" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="130" y="165" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Open Browser</text>
  <text x="130" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เปิด URL เป้าหมาย</text>
  <text x="130" y="30" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Input: URL ใดก็ได้</text>
  <path d="M 244 140 L 290 140" stroke="var(--accent)" stroke-width="3" fill="none" marker-end="url(#arr)"/>
  <defs><marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><polygon points="0 0, 8 3, 0 6" fill="var(--accent)"/></marker></defs>
  <rect x="295" y="60" width="220" height="160" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="405" cy="115" r="32" fill="var(--accent)"/>
  <text x="405" y="115" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="405" y="165" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Capture Traffic</text>
  <text x="405" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">record requests → HAR</text>
  <path d="M 519 140 L 565 140" stroke="var(--accent)" stroke-width="3" fill="none" marker-end="url(#arr)"/>
  <rect x="570" y="60" width="220" height="160" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="680" cy="115" r="32" fill="var(--accent)"/>
  <text x="680" y="115" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="680" y="165" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Reverse-Engineer</text>
  <text x="680" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">สร้าง OpenAPI spec</text>
  <path d="M 794 140 L 840 140" stroke="var(--accent)" stroke-width="3" fill="none" marker-end="url(#arr)"/>
  <rect x="845" y="60" width="235" height="160" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="962" cy="115" r="32" fill="var(--accent)"/>
  <text x="962" y="115" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="962" y="165" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Generate</text>
  <text x="962" y="188" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CLI + Skill + MCP (~10m)</text>
  <text x="962" y="30" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Output: 3 artifacts</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แค่มี URL ก็พอ — Press handle research, traffic capture, code generation, verification เอง</div>

<!-- Speaker note: ใช้ได้กับ website ส่วนใหญ่ ยกเว้น aggressive anti-bot; ESPN และ Google Flights ถูก sniff ด้วยวิธีนี้ -->

---

## ติดตั้ง Printing Press ใน 2 ขั้นตอน

<p class="subhead">ต้องติดตั้ง binary + Claude Code skill คู่กัน — ขาดอย่างใดอย่างหนึ่งทำงานได้ไม่สมบูรณ์</p>

<div class="infographic">
<svg viewBox="0 0 1100 330" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="15" width="495" height="280" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="100" cy="68" r="30" fill="var(--accent)"/>
  <text x="100" y="68" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="150" y="56" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Install Binary</text>
  <text x="150" y="78" font-size="12" fill="var(--muted)" font-family="system-ui">Prerequisites: Go 1.26.3+ และ Claude Code</text>
  <rect x="50" y="100" width="455" height="52" rx="8" fill="white" stroke="var(--muted)" stroke-width="1"/>
  <text x="68" y="122" font-size="11" fill="var(--ink)" font-family="monospace">go install github.com/mvanhorn/</text>
  <text x="68" y="143" font-size="11" fill="var(--ink)" font-family="monospace">  cli-printing-press/v4/cmd/printing-press@latest</text>
  <text x="50" y="186" font-size="12" fill="var(--muted)" font-family="system-ui">Binary: research, generation,</text>
  <text x="50" y="205" font-size="12" fill="var(--muted)" font-family="system-ui">verification, scoring</text>
  <rect x="575" y="15" width="495" height="280" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="645" cy="68" r="30" fill="var(--accent)"/>
  <text x="645" y="68" font-size="18" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="695" y="56" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Install Claude Code Skills</text>
  <text x="695" y="78" font-size="12" fill="var(--muted)" font-family="system-ui">Primary interface — ทำใน Claude Code session</text>
  <rect x="595" y="100" width="455" height="52" rx="8" fill="white" stroke="var(--muted)" stroke-width="1"/>
  <text x="612" y="122" font-size="13" fill="var(--ink)" font-family="monospace">/printing-press install</text>
  <text x="612" y="143" font-size="11" fill="var(--muted)" font-family="monospace"># แล้วใช้: /printing-press list</text>
  <text x="595" y="186" font-size="12" fill="var(--muted)" font-family="system-ui">Skills = primary interface;</text>
  <text x="595" y="205" font-size="12" fill="var(--muted)" font-family="system-ui">binary = engine เบื้องหลัง</text>
  <rect x="30" y="280" width="1040" height="38" rx="8" fill="var(--danger)" opacity="0.08" stroke="var(--danger)" stroke-width="1"/>
  <text x="550" y="303" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">⚠️ ต้องติดตั้งทั้งสอง — skill ไม่มีอะไรเรียกถ้าไม่มี binary; binary ข้าม curated agent loop ถ้าไม่มี skill</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> หลังติดตั้ง: /printing-press list ดู library; /printing-press generate &lt;url&gt; สร้างใหม่</div>

<!-- Speaker note: Cursor users ดู docs/CURSOR.md; tested เฉพาะกับ Claude Code -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำก่อนนำ Printing Press ไปใช้ใน agent workflow</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="240" cy="180" r="160" fill="none" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <circle cx="240" cy="180" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity="0.5"/>
  <circle cx="240" cy="180" r="60" fill="var(--accent)" opacity="0.12"/>
  <circle cx="240" cy="180" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="240" y="173" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">35×</text>
  <text x="240" y="193" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">token savings</text>
  <text x="120" y="108" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Library</text>
  <text x="120" y="126" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">45+ CLIs</text>
  <text x="365" y="108" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Factory</text>
  <text x="365" y="126" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">URL → CLI</text>
  <text x="88" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Go 1.26.3+</text>
  <text x="392" y="188" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Claude Code</text>
  <text x="240" y="318" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">compound + SQLite</text>
  <line x1="530" y1="60" x2="1080" y2="60" stroke="var(--muted)" stroke-width="1" opacity="0.3"/>
  <text x="530" y="52" font-size="15" font-weight="700" fill="var(--ink)" font-family="system-ui">สิ่งที่ต้องจำ</text>
  <circle cx="545" cy="105" r="9" fill="var(--accent)"/>
  <text x="568" y="110" font-size="14" fill="var(--ink)" font-family="system-ui">35× token savings + 100% vs 72% reliability</text>
  <circle cx="545" cy="155" r="9" fill="var(--accent)"/>
  <text x="568" y="160" font-size="14" fill="var(--ink)" font-family="system-ui">1 source → Go CLI + CC skill + MCP server</text>
  <circle cx="545" cy="205" r="9" fill="var(--accent)"/>
  <text x="568" y="210" font-size="14" fill="var(--ink)" font-family="system-ui">Library 45+ CLI (0 min); Factory ~10 min</text>
  <circle cx="545" cy="255" r="9" fill="var(--accent)"/>
  <text x="568" y="260" font-size="14" fill="var(--ink)" font-family="system-ui">compound + SQLite = แก่นของ token efficiency</text>
  <circle cx="545" cy="305" r="9" fill="var(--danger)" opacity="0.8"/>
  <text x="568" y="310" font-size="14" fill="var(--muted)" font-family="system-ui">⚠️ ต้องการ Go 1.26.3+ — ไม่ใช่ zero-dependency</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ลงทุน 10 นาทีสร้าง CLI ครั้งเดียว ประหยัด token ทุก run ตลอดไปสำหรับ workflow ที่รันบ่อย</div>

<!-- Speaker note: ปิดด้วย call-to-action — printingpress.dev สำหรับ library; github.com/mvanhorn/cli-printing-press สำหรับ install -->
