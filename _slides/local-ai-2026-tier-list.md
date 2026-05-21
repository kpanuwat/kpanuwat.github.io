---
marp: true
theme: default
paginate: true
title: "Local AI ในปี 2026: Tier List"
style: |
  :root { --ink:#1e293b; --accent:#3b82f6; --paper:#fff; --muted:#94a3b8; --danger:#ef4444; --soft:#f1f5f9; --green:#22c55e; --amber:#f59e0b; }
  section { display:flex; flex-direction:column; justify-content:space-between; padding:48px 64px; font-family:system-ui,sans-serif; }
  section h2 { font-size:28px; margin:0 0 4px 0; color:var(--ink); }
  .subhead { color:var(--muted); font-size:16px; margin:0 0 8px 0; }
  .takeaway { border-left:4px solid var(--accent); background:var(--soft); padding:12px 16px; border-radius:0 8px 8px 0; font-size:15px; }
  .takeaway b { color:var(--accent); }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; }
  section.title { background:linear-gradient(135deg,#0f172a 0%,#1e3a8a 100%); color:white; }
  section.title h1 { font-size:40px; color:white; margin:0 0 12px 0; }
  section.title p { color:#94a3b8; font-size:18px; margin:0; }
  table { font-size:15px; width:100%; }
  th { background:var(--soft); color:var(--ink); }
---

<!-- _class: title -->

# Local AI ในปี 2026: Tier List

**งานที่คุ้มค่าจริง vs งานที่ยังต้องพึ่ง Cloud**

*Source: The Ultimate Local AI Tier List For 2026*

<!-- Speaker note: ปี 2026 Local AI ไม่ใช่ทางเลือก — แต่ต้องเลือกงานให้ถูก Deck นี้บอกว่าอะไร S-tier และอะไรยังต้องพึ่ง Cloud -->

---

## Local AI ไม่ใช่ดีกว่า Cloud — แต่ดีกว่าในงานที่ใช่

<p class="subhead">S-tier = งานที่เน้นความเร็ว + ความเป็นส่วนตัว; Hard tasks = context ยาวและ reasoning ซับซ้อน</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="60" y="40" width="12" height="300" rx="6" fill="var(--accent)"/>
  <circle cx="150" cy="190" r="44" fill="var(--accent)" opacity="0.12"/>
  <circle cx="150" cy="190" r="44" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="150" y="184" font-size="22" font-weight="700" fill="var(--accent)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">S</text>
  <text x="150" y="208" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">tier</text>
  <text x="226" y="160" font-size="19" font-weight="700" fill="var(--ink)" font-family="system-ui">Code Autocomplete · Image Generation · Speech-to-Text</text>
  <text x="226" y="192" font-size="15" fill="var(--muted)" font-family="system-ui">เร็ว, ส่วนตัว, ไม่มี per-token cost — local ทำได้ดีเทียบเท่าหรือดีกว่า Cloud</text>
  <line x1="226" x2="1020" y1="218" y2="218" stroke="var(--soft)" stroke-width="1"/>
  <text x="226" y="245" font-size="15" fill="var(--danger)" font-family="system-ui" font-weight="600">ยังต้องพึ่ง Cloud:</text>
  <text x="430" y="245" font-size="15" fill="var(--muted)" font-family="system-ui">Agentic Coding, Vibe Coding, Full AI Agents</text>
  <text x="226" y="272" font-size="14" fill="var(--muted)" font-family="system-ui">เพราะ context window ยาว + multi-step reasoning เกิน VRAM ของ consumer hardware</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Local AI เหมาะกับงาน repetitive ที่วัดผลได้ — ไม่ใช่ทางแทน Cloud AI ทั้งหมด</div>

<!-- Speaker note: หัวใจของ deck นี้ — เลือกงานให้ถูก ไม่ใช่เลือก local หรือ cloud ทั้งหมด -->

---

## ทำไมต้องสนใจ Local AI ในปี 2026?

<p class="subhead">สามเหตุผลที่ local inference มีความสำคัญมากขึ้น — ไม่ใช่แค่เทรนด์</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 3 icon boxes horizontal -->
  <rect x="40" y="60" width="320" height="260" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="390" y="60" width="320" height="260" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="740" y="60" width="320" height="260" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Icon circles -->
  <circle cx="200" cy="130" r="34" fill="var(--accent)" opacity="0.15"/>
  <circle cx="200" cy="130" r="34" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="200" y="130" font-size="22" text-anchor="middle" dominant-baseline="central" font-family="system-ui">🔒</text>
  <circle cx="550" cy="130" r="34" fill="var(--green)" opacity="0.15"/>
  <circle cx="550" cy="130" r="34" fill="none" stroke="var(--green)" stroke-width="2"/>
  <text x="550" y="130" font-size="22" text-anchor="middle" dominant-baseline="central" font-family="system-ui">💰</text>
  <circle cx="900" cy="130" r="34" fill="var(--amber)" opacity="0.15"/>
  <circle cx="900" cy="130" r="34" fill="none" stroke="var(--amber)" stroke-width="2"/>
  <text x="900" y="130" font-size="22" text-anchor="middle" dominant-baseline="central" font-family="system-ui">⚡</text>
  <!-- Labels -->
  <text x="200" y="188" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Privacy &amp;</text>
  <text x="200" y="210" font-size="17" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Compliance</text>
  <text x="200" y="240" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Token ไม่ออกจากเครื่อง</text>
  <text x="200" y="260" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HIPAA / GDPR compliant</text>
  <text x="550" y="188" font-size="17" font-weight="700" fill="var(--green)" text-anchor="middle" font-family="system-ui">ต้นทุนระยะยาว</text>
  <text x="550" y="218" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไม่มี per-token cost</text>
  <text x="550" y="240" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">API หลายพันครั้ง/วัน</text>
  <text x="550" y="260" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">→ ประหยัดได้มาก</text>
  <text x="900" y="188" font-size="17" font-weight="700" fill="var(--amber)" text-anchor="middle" font-family="system-ui">Latency</text>
  <text x="900" y="218" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Autocomplete &lt; 100ms</text>
  <text x="900" y="240" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Cloud round-trip</text>
  <text x="900" y="260" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ทำไม่ได้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Privacy + Cost + Latency — สามเหตุผลที่ local inference สำคัญสำหรับองค์กร</div>

<!-- Speaker note: เหตุผลสามข้อนี้ใช้ justify การลงทุน local AI infrastructure ได้ชัดเจน โดยเฉพาะใน regulated industries -->

---

## S-Tier: งานที่ Local ทำได้ดีเทียบเท่าหรือดีกว่า Cloud

<p class="subhead">สามงานที่ local inference ชนะ cloud ด้วยความเร็ว, ความเป็นส่วนตัว, และคุณภาพที่ยอมรับได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- S-Tier badge -->
  <rect x="40" y="80" width="100" height="220" rx="12" fill="var(--accent)"/>
  <text x="90" y="175" font-size="36" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">S</text>
  <text x="90" y="220" font-size="13" fill="white" text-anchor="middle" font-family="system-ui">TIER</text>
  <!-- Row 1: Code Autocomplete -->
  <rect x="160" y="80" width="900" height="64" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="160" y="80" width="6" height="64" rx="3" fill="var(--accent)"/>
  <text x="186" y="104" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Code Autocomplete</text>
  <text x="186" y="128" font-size="13" fill="var(--muted)" font-family="system-ui">Qwen3-Coder 7B · StarCoder2 · fill-in-middle · ไม่มี latency · codebase ไม่ออกจากเครื่อง</text>
  <!-- Row 2: Image Generation -->
  <rect x="160" y="158" width="900" height="64" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="160" y="158" width="6" height="64" rx="3" fill="var(--accent)"/>
  <text x="186" y="182" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Image Generation</text>
  <text x="186" y="206" font-size="13" fill="var(--muted)" font-family="system-ui">SDXL · Flux-dev · ต้องการ GPU 8 GB · ไม่มีค่าต่อภาพ · output ไม่ผ่าน third-party server</text>
  <!-- Row 3: Speech-to-Text -->
  <rect x="160" y="236" width="900" height="64" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="160" y="236" width="6" height="64" rx="3" fill="var(--accent)"/>
  <text x="186" y="260" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Speech-to-Text</text>
  <text x="186" y="284" font-size="13" fill="var(--muted)" font-family="system-ui">Whisper.cpp · รันบน CPU ได้ · accuracy ใกล้เคียง cloud · เหมาะกับ meeting recording / medical notes</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> สามงานนี้ทำซ้ำได้, วัดผลได้, และ privacy-sensitive — local ชนะชัดเจน</div>

<!-- Speaker note: สามงานนี้มีจุดร่วมคือ latency-sensitive, repetitive, และ privacy-critical — local wins on all three axes -->

---

## Cloud ยังชนะ: งานที่ต้องการ Context ยาวและ Reasoning ซับซ้อน

<p class="subhead">Local hardware มี VRAM ceiling ที่ทำให้ agentic tasks ยังด้อยกว่า cloud อย่างมีนัยสำคัญ</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Local box -->
  <rect x="40" y="50" width="480" height="280" rx="14" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="40" y="50" width="480" height="56" rx="14" fill="var(--soft)"/>
  <rect x="40" y="94" width="480" height="12" fill="var(--soft)"/>
  <text x="280" y="84" font-size="18" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Local AI</text>
  <text x="70" y="140" font-size="14" fill="var(--green)" font-family="system-ui" font-weight="600">✓ Code Autocomplete</text>
  <text x="70" y="168" font-size="14" fill="var(--green)" font-family="system-ui" font-weight="600">✓ Image Generation</text>
  <text x="70" y="196" font-size="14" fill="var(--green)" font-family="system-ui" font-weight="600">✓ Speech-to-Text</text>
  <text x="70" y="232" font-size="14" fill="var(--danger)" font-family="system-ui">✗ Agentic Coding</text>
  <text x="70" y="256" font-size="14" fill="var(--danger)" font-family="system-ui">✗ Vibe Coding</text>
  <text x="70" y="280" font-size="14" fill="var(--danger)" font-family="system-ui">✗ Full AI Agents</text>
  <!-- VS circle -->
  <circle cx="550" cy="190" r="32" fill="var(--accent)"/>
  <text x="550" y="190" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <!-- Cloud box -->
  <rect x="580" y="50" width="480" height="280" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="580" y="50" width="480" height="56" rx="14" fill="var(--accent)" opacity="0.1"/>
  <rect x="580" y="94" width="480" height="12" fill="var(--accent)" opacity="0.1"/>
  <text x="820" y="84" font-size="18" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Cloud AI</text>
  <text x="610" y="132" font-size="13" fill="var(--muted)" font-family="system-ui">Context window: 100K–1M tokens</text>
  <text x="610" y="158" font-size="13" fill="var(--muted)" font-family="system-ui">Multi-step planning ข้ามไฟล์หลายร้อยไฟล์</text>
  <text x="610" y="184" font-size="13" fill="var(--muted)" font-family="system-ui">Backtrack + revise plan อัตโนมัติ</text>
  <rect x="610" y="210" width="420" height="44" rx="8" fill="var(--accent)" opacity="0.08"/>
  <text x="820" y="228" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Claude Opus 4.7 · GPT-5.5</text>
  <text x="820" y="248" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Best-in-class SWE-Bench Pro</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> VRAM คือ hard ceiling — agentic tasks ต้องการ 100K+ context ที่ consumer GPU ยังรับไม่ไหว</div>

<!-- Speaker note: ไม่ใช่ว่า local AI แย่ แต่ hardware ยังไม่พร้อมสำหรับ long-context multi-agent orchestration -->

---

## Hardware ที่ต้องการตาม Task

<p class="subhead">VRAM คือตัวกำหนดหลัก — เลือก task ให้เหมาะกับ hardware ที่มี</p>

<div style="flex:1;display:flex;flex-direction:column;justify-content:center;gap:1rem">

| งาน | Min VRAM | โมเดลที่ใช้ได้ |
|---|:---:|---|
| Code Autocomplete | 8 GB | Qwen3-Coder 7B, StarCoder2 7B |
| Image Generation | 8 GB | SDXL, Flux-dev |
| Speech-to-Text | CPU OK | Whisper.cpp |
| General Chat / RAG | 8–16 GB | Llama 3.3 8B, Gemma 4 |
| Complex Reasoning | 24+ GB | Qwen3.5 72B Q4 |

**Apple M4 Pro** (24 GB unified) → 7B–13B สบาย &nbsp;|&nbsp; **M4 Max** (128 GB) → quantized 70B ได้

</div>

<div class="takeaway"><b>★ Takeaway:</b> เริ่มจาก S-tier tasks ที่รันได้บน 8 GB GPU — ไม่ต้องรอ upgrade hardware ก่อน</div>

<!-- Speaker note: จุดเริ่มต้นที่ดีคือ 8 GB GPU ที่หลายองค์กรมีอยู่แล้ว — ไม่ต้องลงทุนใหม่ก่อนทดสอบ -->

---

## เริ่มจาก Repetitive Tasks — ไม่ใช่ Full Agent

<p class="subhead">สี่ขั้นตอนที่ได้ผลจริง: validate ทีละ task ก่อน scale</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 4-step arrow flow -->
  <!-- Step 1 -->
  <rect x="30" y="100" width="220" height="140" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="140" cy="138" r="20" fill="var(--accent)"/>
  <text x="140" y="138" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">1</text>
  <text x="140" y="175" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">เลือก 1 Task</text>
  <text x="140" y="198" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">repetitive ที่ทำบ่อย</text>
  <text x="140" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เช่น code review</text>
  <!-- Arrow -->
  <line x1="255" y1="170" x2="285" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="285,163 300,170 285,177" fill="var(--accent)"/>
  <!-- Step 2 -->
  <rect x="300" y="100" width="220" height="140" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="410" cy="138" r="20" fill="var(--accent)"/>
  <text x="410" y="138" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">2</text>
  <text x="410" y="175" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ทดสอบ Local vs API</text>
  <text x="410" y="198" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">วัด accuracy + speed</text>
  <text x="410" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">บน sample จริง</text>
  <!-- Arrow -->
  <line x1="525" y1="170" x2="555" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="555,163 570,170 555,177" fill="var(--accent)"/>
  <!-- Step 3 -->
  <rect x="570" y="100" width="220" height="140" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="680" cy="138" r="20" fill="var(--accent)"/>
  <text x="680" y="138" font-size="16" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">3</text>
  <text x="680" y="175" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Route งานนั้น</text>
  <text x="680" y="198" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ไป local model</text>
  <text x="680" y="218" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">งานอื่นยัง cloud</text>
  <!-- Arrow -->
  <line x1="795" y1="170" x2="825" y2="170" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="825,163 840,170 825,177" fill="var(--accent)"/>
  <!-- Step 4 -->
  <rect x="840" y="100" width="220" height="140" rx="12" fill="var(--accent)" opacity="0.9"/>
  <circle cx="950" cy="138" r="20" fill="white"/>
  <text x="950" y="138" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">4</text>
  <text x="950" y="175" font-size="15" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Scale ทีละ Task</text>
  <text x="950" y="198" font-size="12" fill="white" text-anchor="middle" opacity="0.85" font-family="system-ui">หลัง validate แล้ว</text>
  <text x="950" y="218" font-size="12" fill="white" text-anchor="middle" opacity="0.85" font-family="system-ui">measure ROI ชัดเจน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่ต้องสร้าง "fully local agent" ตั้งแต่ต้น — validate 1 task ก่อน แล้ว scale ทีหลัง</div>

<!-- Speaker note: แนวทางนี้ลดความเสี่ยงและทำให้ ROI วัดได้ชัด ไม่ต้องลงทุนใหญ่ก่อนเห็นผล -->

---

## ข้อระวัง: Local AI ยังมี Limits ที่สำคัญ

<p class="subhead">รู้ข้อจำกัดก่อน deploy — ป้องกัน regression และ false confidence</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- 2x2 grid -->
  <!-- Cell 1: VRAM ceiling -->
  <rect x="40" y="40" width="490" height="140" rx="12" fill="var(--soft)" stroke="var(--danger)" stroke-width="1.5"/>
  <rect x="40" y="40" width="8" height="140" rx="4" fill="var(--danger)"/>
  <text x="70" y="74" font-size="16" font-weight="700" fill="var(--danger)" font-family="system-ui">VRAM คือ Hard Ceiling</text>
  <text x="70" y="100" font-size="13" fill="var(--muted)" font-family="system-ui">โมเดลใหญ่กว่า VRAM รันไม่ได้โดยตรง</text>
  <text x="70" y="122" font-size="13" fill="var(--muted)" font-family="system-ui">offload ไป RAM ช้ากว่ามาก</text>
  <text x="70" y="144" font-size="13" fill="var(--muted)" font-family="system-ui">ต้องเลือก model ให้เข้ากับ hardware</text>
  <!-- Cell 2: Context Degradation -->
  <rect x="570" y="40" width="490" height="140" rx="12" fill="var(--soft)" stroke="var(--amber)" stroke-width="1.5"/>
  <rect x="570" y="40" width="8" height="140" rx="4" fill="var(--amber)"/>
  <text x="600" y="74" font-size="16" font-weight="700" fill="var(--amber)" font-family="system-ui">Context Degradation</text>
  <text x="600" y="100" font-size="13" fill="var(--muted)" font-family="system-ui">Hallucination เพิ่มขึ้นเมื่อ context &gt; 32K token</text>
  <text x="600" y="122" font-size="13" fill="var(--muted)" font-family="system-ui">ใน long agentic sessions คุณภาพลดลง</text>
  <text x="600" y="144" font-size="13" fill="var(--muted)" font-family="system-ui">monitor และ cap session length</text>
  <!-- Cell 3: Quantization -->
  <rect x="40" y="200" width="490" height="140" rx="12" fill="var(--soft)" stroke="var(--amber)" stroke-width="1.5"/>
  <rect x="40" y="200" width="8" height="140" rx="4" fill="var(--amber)"/>
  <text x="70" y="234" font-size="16" font-weight="700" fill="var(--amber)" font-family="system-ui">Quantization Trade-off</text>
  <text x="70" y="260" font-size="13" fill="var(--muted)" font-family="system-ui">Q4 ลด VRAM แต่ accuracy ลดด้วย</text>
  <text x="70" y="282" font-size="13" fill="var(--muted)" font-family="system-ui">benchmark บน task จริงก่อน deploy เสมอ</text>
  <text x="70" y="304" font-size="13" fill="var(--muted)" font-family="system-ui">อย่าสมมติว่า Q4 ≈ full precision</text>
  <!-- Cell 4: Cold Start -->
  <rect x="570" y="200" width="490" height="140" rx="12" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="570" y="200" width="8" height="140" rx="4" fill="var(--muted)"/>
  <text x="600" y="234" font-size="16" font-weight="700" fill="var(--ink)" font-family="system-ui">Cold Start Latency</text>
  <text x="600" y="260" font-size="13" fill="var(--muted)" font-family="system-ui">โหลด model ครั้งแรก 10–30 วินาที</text>
  <text x="600" y="282" font-size="13" fill="var(--muted)" font-family="system-ui">ไม่เหมาะกับ sporadic one-off requests</text>
  <text x="600" y="304" font-size="13" fill="var(--muted)" font-family="system-ui">เหมาะกับ continuous / batch workloads</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Benchmark บน task จริงก่อน deploy — อย่าสมมติว่า local = cloud quality เสมอ</div>

<!-- Speaker note: ข้อระวังเหล่านี้ไม่ใช่เหตุผลให้ไม่ใช้ local AI แต่เป็นสิ่งที่ต้องวางแผนรับมือก่อน -->

---

## Key Takeaways: Hybrid คือ Pragmatic Choice 2026

<p class="subhead">ไม่ใช่ local หรือ cloud — แต่เป็น local สำหรับ routine, cloud สำหรับ hard reasoning</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Concentric rings: core=Hybrid, middle=S-tier/Cloud, outer=context -->
  <circle cx="300" cy="170" r="155" fill="none" stroke="var(--muted)" stroke-width="1" opacity="0.4"/>
  <circle cx="300" cy="170" r="108" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity="0.5"/>
  <circle cx="300" cy="170" r="62" fill="var(--accent)" opacity="0.1"/>
  <circle cx="300" cy="170" r="62" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="300" y="162" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Hybrid</text>
  <text x="300" y="182" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Setup</text>
  <text x="162" y="92" font-size="13" fill="var(--green)" font-family="system-ui" text-anchor="middle">S-tier</text>
  <text x="162" y="112" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">local tasks</text>
  <text x="440" y="92" font-size="13" fill="var(--accent)" font-family="system-ui" text-anchor="middle">Cloud</text>
  <text x="440" y="112" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">agentic</text>
  <text x="110" y="175" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Privacy</text>
  <text x="490" y="175" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Reasoning</text>
  <!-- Summary list -->
  <rect x="600" y="30" width="460" height="280" rx="14" fill="var(--soft)" stroke="var(--muted)" stroke-width="1"/>
  <text x="830" y="62" font-size="16" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">สรุป 2026</text>
  <text x="630" y="96" font-size="13" fill="var(--green)" font-family="system-ui">✓ S-tier local: Autocomplete · Image · STT</text>
  <text x="630" y="124" font-size="13" fill="var(--danger)" font-family="system-ui">✗ Cloud wins: Agentic · Vibe · Agents</text>
  <text x="630" y="152" font-size="13" fill="var(--ink)" font-family="system-ui">▶ เริ่มจาก repetitive tasks</text>
  <text x="630" y="180" font-size="13" fill="var(--ink)" font-family="system-ui">▶ 8 GB GPU เริ่มได้เลย</text>
  <text x="630" y="208" font-size="13" fill="var(--ink)" font-family="system-ui">▶ Benchmark ก่อน deploy เสมอ</text>
  <text x="630" y="236" font-size="13" fill="var(--accent)" font-family="system-ui">★ Privacy ROI สูงใน regulated industries</text>
  <text x="630" y="264" font-size="13" fill="var(--accent)" font-family="system-ui">★ Hybrid คือ pragmatic choice ปี 2026</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือกงานให้ถูก — local สำหรับ repetitive + private; cloud สำหรับ complex + long-context</div>

<!-- Speaker note: จบด้วย hybrid mindset — ไม่ใช่ all-or-nothing แต่เป็นการ route งานให้ถูก model -->
