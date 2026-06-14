---
marp: true
theme: default
paginate: true
title: "Cloudflare Voice SDK: สร้าง Voice AI Agent แบบ Real-time"
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
    --cyan:#06b6d4; --orange:#f97316;
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
  .card.cyan    { border-left-color:var(--cyan); }
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
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
  code { font-size:12px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/cloudflare-voice-sdk-real-time-voice-ai-agent-cover.png)

<div class="mark"></div>

# Cloudflare Voice SDK

<p class="tag">สร้าง Voice AI Agent แบบ Real-time บน Workers — ไม่ต้องใช้ API key ภายนอก</p>

<!-- Speaker: SDK ใหม่จาก Cloudflare เพิ่ม voice pipeline เข้า Agents SDK ที่มีอยู่แล้ว ไม่ต้องสร้าง architecture ใหม่ -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/cloudflare-voice-sdk-real-time-voice-ai-agent-cheatsheet.png)

<!-- Speaker: ภาพรวมของ SDK ทั้งหมด — withVoice wrapper, audio pipeline, STT/TTS providers, context persistence, interruption handling, React hooks -->

---

## Voice AI ในอดีต: ปัญหา Latency จาก Multi-Service Hops

![bg right:40% contain](assets/cloudflare-voice-sdk-real-time-voice-ai-agent-background.png)

<p class="subhead">แต่ละ service hop เพิ่ม latency — budget สำหรับ "เป็นธรรมชาติ" คือต่ำกว่า 800ms</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="680" height="280" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="350" y="42" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Voice Latency Budget</text>
  <rect x="30" y="60" width="105" height="44" rx="8" fill="var(--accent)" opacity=".15" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="82" y="80" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Mic Input</text>
  <text x="82" y="96" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">~40ms</text>
  <line x1="135" y1="82" x2="175" y2="82" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="3,3"/>
  <text x="155" y="76" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">hop</text>
  <rect x="175" y="60" width="105" height="44" rx="8" fill="var(--cyan)" opacity=".15" stroke="var(--cyan)" stroke-width="1.5"/>
  <text x="227" y="80" font-size="12" font-weight="700" fill="var(--cyan)" text-anchor="middle" font-family="system-ui">STT</text>
  <text x="227" y="96" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">~300ms</text>
  <line x1="280" y1="82" x2="320" y2="82" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="3,3"/>
  <text x="300" y="76" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">hop</text>
  <rect x="320" y="60" width="105" height="44" rx="8" fill="var(--warning)" opacity=".15" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="372" y="80" font-size="12" font-weight="700" fill="var(--warning)" text-anchor="middle" font-family="system-ui">LLM</text>
  <text x="372" y="96" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">~400ms</text>
  <line x1="425" y1="82" x2="465" y2="82" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="3,3"/>
  <text x="445" y="76" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">hop</text>
  <rect x="465" y="60" width="105" height="44" rx="8" fill="var(--success)" opacity=".15" stroke="var(--success)" stroke-width="1.5"/>
  <text x="517" y="80" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">TTS</text>
  <text x="517" y="96" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">~150ms</text>
  <rect x="30" y="130" width="640" height="36" rx="6" fill="var(--danger)" opacity=".08" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="350" y="153" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Total ~890ms — รู้สึก "ไม่เป็นธรรมชาติ" เกิน 800ms budget</text>
  <rect x="30" y="185" width="640" height="36" rx="6" fill="var(--success)" opacity=".08" stroke="var(--success)" stroke-width="1.5"/>
  <text x="350" y="208" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Cloudflare: pipeline รันใน 1 datacenter — eliminates hop overhead</text>
  <rect x="30" y="240" width="50" height="20" rx="4" fill="var(--accent)"/>
  <text x="55" y="254" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">CF SDK</text>
  <rect x="90" y="240" width="580" height="6" rx="3" fill="var(--soft-2)"/>
  <rect x="90" y="240" width="435" height="6" rx="3" fill="var(--accent)" opacity=".6"/>
  <text x="535" y="254" font-size="10" fill="var(--accent)" font-family="system-ui">~730ms</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cloudflare รัน STT+LLM+TTS ใน datacenter เดียว — ตัด network hop overhead ออกทั้งหมด</div>

<!-- Speaker: ปัญหาหลักไม่ใช่โมเดลช้า แต่คือ network round trips ระหว่างบริการต่างๆ -->

---

## withVoice: Voice เป็นแค่ Wrapper บน Agent เดิม

<p class="subhead">Higher-order function pattern — ไม่ต้องสร้าง architecture ใหม่</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Before: plain Agent -->
  <rect x="40" y="30" width="460" height="320" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="30" width="460" height="52" rx="12" fill="var(--soft)" opacity=".8"/>
  <text x="270" y="63" font-size="15" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Agent (text only)</text>
  <rect x="70" y="108" width="400" height="38" rx="6" fill="var(--soft-2)"/>
  <text x="270" y="132" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">class MyAgent extends Agent</text>
  <rect x="70" y="158" width="400" height="38" rx="6" fill="var(--soft-2)"/>
  <text x="270" y="182" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">onMessage()</text>
  <rect x="70" y="208" width="400" height="38" rx="6" fill="var(--soft-2)"/>
  <text x="270" y="232" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SQLite history</text>
  <text x="270" y="300" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">text input only</text>
  <!-- Arrow -->
  <path d="M520 190 L580 190" stroke="var(--accent)" stroke-width="2.5" fill="none"/>
  <polygon points="580,185 592,190 580,195" fill="var(--accent)"/>
  <text x="556" y="180" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">withVoice()</text>
  <!-- After: VoiceAgent -->
  <rect x="600" y="30" width="460" height="320" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="600" y="30" width="460" height="52" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="830" y="63" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">VoiceAgent (text + voice)</text>
  <rect x="630" y="108" width="400" height="38" rx="6" fill="var(--accent-wash)"/>
  <text x="830" y="132" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui">class MyAgent extends VoiceAgent</text>
  <rect x="630" y="158" width="400" height="38" rx="6" fill="var(--soft-2)"/>
  <text x="830" y="182" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">onTurn(transcript, context)</text>
  <rect x="630" y="208" width="400" height="38" rx="6" fill="var(--soft-2)"/>
  <text x="830" y="232" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">SQLite history (same)</text>
  <rect x="630" y="258" width="190" height="32" rx="6" fill="var(--cyan)" opacity=".15" stroke="var(--cyan)" stroke-width="1.5"/>
  <text x="725" y="278" font-size="12" fill="var(--cyan)" text-anchor="middle" font-family="system-ui">WorkersAIFluxSTT</text>
  <rect x="840" y="258" width="190" height="32" rx="6" fill="var(--success)" opacity=".15" stroke="var(--success)" stroke-width="1.5"/>
  <text x="935" y="278" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">WorkersAITTS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> <code>withVoice(Agent)</code> เพิ่ม voice ในบรรทัดเดียว — tools, history, scheduling ยังทำงานเหมือนเดิม</div>

<!-- Speaker: ไม่มี new architecture, ไม่มี new infra — เพียง wrap class เดิมแล้วเพิ่ม onTurn() -->

---

## Package Overview: 5 ส่วนหลักของ @cloudflare/voice

<p class="subhead">แต่ละ export ออกแบบมาสำหรับ use case ที่ต่างกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="gap:10px;">
  <div class="card" style="border-left-color:var(--accent);">
    <p class="label">Server — Full Voice</p>
    <h3>withVoice</h3>
    <p>STT + LLM + TTS + SQLite persistence. onTurn() รับ transcript คืน stream/string</p>
  </div>
  <div class="card" style="border-left-color:var(--cyan);">
    <p class="label">Server — STT Only</p>
    <h3>withVoiceInput</h3>
    <p>Transcription เท่านั้น ไม่มี TTS response. เหมาะสำหรับ dictation / voice search</p>
  </div>
  <div class="card gold">
    <p class="label">Client — React</p>
    <h3>useVoiceAgent / useVoiceInput</h3>
    <p>React hooks — status, transcript, interimTranscript, startCall, endCall, toggleMute</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือก <code>withVoice</code> สำหรับ full conversation, <code>withVoiceInput</code> สำหรับ transcription-only — hooks เดียวกันทั้งคู่</div>

<!-- Speaker: VoiceClient ยังมีสำหรับ non-React frameworks ด้วย -->

---

## Audio Pipeline: Browser → Durable Object → LLM → Speaker

<p class="subhead">WebSocket เดียวรองรับทั้ง binary audio และ JSON transcript</p>

<div class="infographic">
<svg viewBox="0 0 1100 360" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Browser box -->
  <rect x="20" y="60" width="180" height="240" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <text x="110" y="90" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browser</text>
  <rect x="40" y="105" width="140" height="28" rx="6" fill="var(--soft)"/>
  <text x="110" y="124" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Mic (16kHz PCM)</text>
  <rect x="40" y="200" width="140" height="28" rx="6" fill="var(--soft)"/>
  <text x="110" y="219" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Speaker output</text>
  <rect x="40" y="240" width="140" height="28" rx="6" fill="var(--soft)"/>
  <text x="110" y="259" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Live transcript UI</text>
  <!-- WebSocket line -->
  <line x1="200" y1="119" x2="290" y2="119" stroke="var(--accent)" stroke-width="2" stroke-dasharray="4,3"/>
  <polygon points="289,114 302,119 289,124" fill="var(--accent)"/>
  <text x="246" y="112" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">binary PCM</text>
  <line x1="200" y1="214" x2="290" y2="214" stroke="var(--success)" stroke-width="2" stroke-dasharray="4,3"/>
  <polygon points="201,209 188,214 201,219" fill="var(--success)"/>
  <text x="246" y="207" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">binary audio</text>
  <line x1="200" y1="254" x2="290" y2="254" stroke="var(--cyan)" stroke-width="2" stroke-dasharray="4,3"/>
  <polygon points="201,249 188,254 201,259" fill="var(--cyan)"/>
  <text x="246" y="247" font-size="10" fill="var(--cyan)" text-anchor="middle" font-family="system-ui">JSON transcript</text>
  <!-- Durable Object box -->
  <rect x="300" y="40" width="500" height="280" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.12))"/>
  <text x="550" y="72" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Durable Object (withVoice)</text>
  <rect x="325" y="88" width="450" height="42" rx="8" fill="var(--cyan)" opacity=".1" stroke="var(--cyan)" stroke-width="1.5"/>
  <text x="550" y="107" font-size="12" font-weight="700" fill="var(--cyan)" text-anchor="middle" font-family="system-ui">Transcriber Session (per-call)</text>
  <text x="550" y="122" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Deepgram Flux — model-driven turn detection</text>
  <line x1="550" y1="130" x2="550" y2="150" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="545,148 550,162 555,148" fill="var(--muted)"/>
  <rect x="325" y="162" width="450" height="42" rx="8" fill="var(--warning)" opacity=".1" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="550" y="181" font-size="12" font-weight="700" fill="var(--warning)" text-anchor="middle" font-family="system-ui">onTurn(transcript, context)</text>
  <text x="550" y="196" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">LLM call — context.messages + abortSignal</text>
  <line x1="550" y1="204" x2="550" y2="224" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="545,222 550,236 555,222" fill="var(--muted)"/>
  <rect x="325" y="236" width="450" height="42" rx="8" fill="var(--success)" opacity=".1" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="255" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">TTS (sentence-chunked)</text>
  <text x="550" y="270" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Deepgram Aura — stream to client</text>
  <!-- SQLite box -->
  <rect x="830" y="100" width="230" height="120" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <text x="945" y="130" font-size="13" font-weight="700" fill="var(--gold)" text-anchor="middle" font-family="system-ui">SQLite</text>
  <text x="945" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">conversation history</text>
  <text x="945" y="172" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">survives reconnect</text>
  <text x="945" y="192" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">+ deployment</text>
  <line x1="800" y1="180" x2="830" y2="160" stroke="var(--gold)" stroke-width="1.5" stroke-dasharray="3,3"/>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Single WebSocket connection รับ/ส่ง binary audio + JSON transcript — STT model ตัดสิน end-of-utterance เอง</div>

<!-- Speaker: ไม่ต้องการ VAD library, ไม่ต้อง button-to-talk — model-driven detection ลด false positive -->

---

## Context Persistence: SQLite ใน Durable Object รองรับทุก Mode

<p class="subhead">Voice, text, text+voice — ทั้งหมดอยู่ใน history เดียวกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="gap:10px;">
  <div class="card success">
    <p class="label">Reconnection</p>
    <h3>User ตัดต่อ → reconnect</h3>
    <p>History ใน SQLite ยังอยู่ — Agent จำบริบทได้เหมือนไม่มีอะไรเกิดขึ้น</p>
  </div>
  <div class="card" style="border-left-color:var(--cyan);">
    <p class="label">Deployment</p>
    <h3>Deploy version ใหม่</h3>
    <p>Durable Object persist ข้ามการ deploy — session ไม่ถูก reset</p>
  </div>
  <div class="card gold">
    <p class="label">Mixed Input</p>
    <h3>Text + Voice ใน history เดียว</h3>
    <p>context.messages รวมทั้ง text messages และ voice turns ไว้ด้วยกัน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> <code>context.messages</code> ให้ SQLite-backed history ที่รอด reconnect, deploy, และ mixed-mode input</div>

<!-- Speaker: นี่คือข้อได้เปรียบหลักของ Durable Objects — stateful instance ต่อ user session -->

---

## Interruption Handling: User พูดแทรก → Agent หยุดทันที

![bg right:40% contain](assets/cloudflare-voice-sdk-real-time-voice-ai-agent-interruption.png)

<p class="subhead">context.signal abort LLM + TTS cancel — ไม่เสีย compute</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2020/svg">
  <rect x="10" y="10" width="680" height="280" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <!-- Timeline -->
  <line x1="40" y1="90" x2="660" y2="90" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="40" y="75" font-size="11" fill="var(--muted)" font-family="system-ui">time</text>
  <!-- Agent speaking phase -->
  <rect x="60" y="60" width="200" height="34" rx="6" fill="var(--success)" opacity=".15" stroke="var(--success)" stroke-width="1.5"/>
  <text x="160" y="81" font-size="12" fill="var(--success)" text-anchor="middle" font-family="system-ui">Agent TTS playing...</text>
  <!-- User interrupts -->
  <line x1="270" y1="50" x2="270" y2="130" stroke="var(--danger)" stroke-width="2" stroke-dasharray="4,3"/>
  <text x="280" y="68" font-size="11" font-weight="700" fill="var(--danger)" font-family="system-ui">User speaks</text>
  <!-- TTS cancel -->
  <rect x="275" y="60" width="140" height="34" rx="6" fill="var(--danger)" opacity=".1" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="345" y="81" font-size="12" fill="var(--danger)" text-anchor="middle" font-family="system-ui">TTS cancelled</text>
  <!-- context.signal badge -->
  <rect x="430" y="55" width="200" height="44" rx="8" fill="var(--warning)" opacity=".15" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="530" y="74" font-size="12" font-weight="700" fill="var(--warning)" text-anchor="middle" font-family="system-ui">context.signal.abort()</text>
  <text x="530" y="91" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">LLM request cancelled</text>
  <!-- New turn -->
  <rect x="60" y="130" width="580" height="40" rx="8" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="350" y="155" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">New onTurn() fires with user's new transcript</text>
  <!-- Code hint -->
  <text x="40" y="210" font-size="11" fill="var(--muted)" font-family="system-ui">abortSignal: context.signal</text>
  <text x="40" y="230" font-size="11" fill="var(--muted)" font-family="system-ui">// ← pass to streamText(), fetch(), AI.run()</text>
  <text x="40" y="250" font-size="11" fill="var(--muted)" font-family="system-ui">// automatic: no manual listener needed</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pass <code>context.signal</code> ให้ทุก async call ใน <code>onTurn()</code> — interruption จัดการให้อัตโนมัติ</div>

<!-- Speaker: นี่คือ UX ที่ทำให้ voice รู้สึกเป็นธรรมชาติ — user ไม่ต้องรอให้ Agent พูดจบ -->

---

## withVoiceInput + React Hooks: STT-Only และ UI Integration

<p class="subhead">ไม่ทุก use case ต้องการ audio response — dictation และ voice search ใช้ input เท่านั้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2" style="gap:12px;">
  <div class="card" style="border-left-color:var(--cyan);">
    <p class="label">STT-Only Server</p>
    <h3>withVoiceInput</h3>
    <p><code>onTranscript(text, connection)</code> — รับ text จาก STT, ไม่มี TTS response</p>
    <p style="margin-top:8px;">Use cases: dictation, voice search, command recognition</p>
  </div>
  <div class="card gold">
    <p class="label">React Client Hooks</p>
    <h3>useVoiceAgent / useVoiceInput</h3>
    <p><b>useVoiceAgent</b>: status, transcript, interimTranscript, startCall, endCall, toggleMute</p>
    <p><b>useVoiceInput</b>: transcript, isListening, start, stop, clear</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> <code>interimTranscript</code> ให้ partial results แบบ real-time ขณะ user ยังพูดอยู่ — แสดงใน UI ได้เลย</div>

<!-- Speaker: VoiceClient (non-React) ก็มี — ใช้กับ Vue, Svelte, vanilla JS ได้ -->

---

## User Guide: 5 ขั้นตอนตั้งแต่ Zero ถึง Running

<p class="subhead">ตั้งค่าทั้งหมดไม่ถึง 50 บรรทัด ไม่ต้องสมัคร external API</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- Step boxes -->
  <rect x="20" y="80" width="180" height="160" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <circle cx="110" cy="50" r="22" fill="var(--accent)"/>
  <text x="110" y="56" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="110" y="112" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Install</text>
  <text x="110" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">npm install</text>
  <text x="110" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">@cloudflare/voice</text>
  <text x="110" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">agents</text>
  <line x1="200" y1="160" x2="225" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="223,155 236,160 223,165" fill="var(--accent)"/>
  <rect x="235" y="80" width="180" height="160" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <circle cx="325" cy="50" r="22" fill="var(--accent)"/>
  <text x="325" y="56" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="325" y="112" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">wrangler.jsonc</text>
  <text x="325" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ai binding</text>
  <text x="325" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">durable_objects</text>
  <text x="325" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SQLite migrations</text>
  <line x1="415" y1="160" x2="440" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="438,155 451,160 438,165" fill="var(--accent)"/>
  <rect x="450" y="80" width="180" height="160" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <circle cx="540" cy="50" r="22" fill="var(--accent)"/>
  <text x="540" y="56" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="540" y="112" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Server Agent</text>
  <text x="540" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">withVoice(Agent)</text>
  <text x="540" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">transcriber + tts</text>
  <text x="540" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">onTurn() handler</text>
  <line x1="630" y1="160" x2="655" y2="160" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="653,155 666,160 653,165" fill="var(--accent)"/>
  <rect x="665" y="80" width="180" height="160" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(15,23,42,.06))"/>
  <circle cx="755" cy="50" r="22" fill="var(--accent)"/>
  <text x="755" y="56" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="755" y="112" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">React UI</text>
  <text x="755" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">useVoiceAgent()</text>
  <text x="755" y="152" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">startCall / endCall</text>
  <text x="755" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">interimTranscript</text>
  <line x1="845" y1="160" x2="870" y2="160" stroke="var(--success)" stroke-width="2"/>
  <polygon points="868,155 881,160 868,165" fill="var(--success)"/>
  <rect x="880" y="80" width="200" height="160" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 2px 8px rgba(22,163,74,.1))"/>
  <circle cx="980" cy="50" r="22" fill="var(--success)"/>
  <text x="980" y="56" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="980" y="112" font-size="13" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Deploy</text>
  <text x="980" y="134" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">wrangler deploy</text>
  <text x="980" y="152" font-size="12" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Live!</text>
  <text x="980" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">no external API key</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ตั้งแต่ install จนถึง deploy ทำได้ใน 5 ขั้นตอน ไม่ต้องสมัคร Deepgram หรือ OpenAI account</div>

<!-- Speaker: Workers AI binding ทำให้ Deepgram models รันบน infrastructure ที่ Cloudflare manage ให้ -->

---

## Caveats: สิ่งที่ต้องรู้ก่อน Production

<p class="subhead">Experimental package — ใช้ได้ดีสำหรับ prototype และ early production</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="gap:10px;">
  <div class="card warning">
    <p class="label">Status</p>
    <h3>Experimental API</h3>
    <p>API อาจเปลี่ยนโดยไม่แจ้งล่วงหน้า ยังไม่ stable สำหรับ production-critical systems</p>
  </div>
  <div class="card danger">
    <p class="label">Scope Limit</p>
    <h3>WebSocket Only</h3>
    <p>ยังไม่รองรับ SIP/PSTN/telephony — เฉพาะ browser WebSocket transport เท่านั้น</p>
  </div>
  <div class="card" style="border-left-color:var(--muted);">
    <p class="label">Data Scope</p>
    <h3>SQLite per Instance</h3>
    <p>History ไม่ sync ข้าม Durable Object instances — routing users ต่างกันทำให้ session แยก</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ดีสำหรับ prototype/POC และ early production — monitor Workers AI quotas และทดสอบ mobile browsers ก่อน launch</div>

<!-- Speaker: telephony support น่าจะมาใน version ถัดไป ตาม roadmap ของ Cloudflare Realtime -->

---

## Key Takeaways

<p class="subhead">สิ่งที่สำคัญที่สุดจาก Cloudflare Voice SDK</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="160" r="150" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="160" r="100" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="160" r="55" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="160" r="55" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="153" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">withVoice</text>
  <text x="550" y="173" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">wrapper</text>
  <!-- Second ring labels -->
  <text x="380" y="95" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">No API Key</text>
  <text x="380" y="113" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Workers AI built-in</text>
  <text x="720" y="95" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">context.signal</text>
  <text x="720" y="113" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">interruption abort</text>
  <text x="380" y="230" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">SQLite History</text>
  <text x="380" y="248" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">survives reconnect</text>
  <text x="720" y="230" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Sentence TTS</text>
  <text x="720" y="248" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">first audio fast</text>
  <!-- Outer ring labels -->
  <text x="200" y="160" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Deepgram</text>
  <text x="200" y="178" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Flux STT</text>
  <text x="900" y="160" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">React</text>
  <text x="900" y="178" font-size="11" fill="var(--muted)" font-family="system-ui" text-anchor="middle">hooks</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Voice เป็นแค่ input mode ใหม่ของ Agent เดิม — เพิ่ม <code>withVoice()</code> แล้วทุก feature ของ Agents SDK ยังใช้ได้</div>

<!-- Speaker: เริ่มจาก withVoice + onTurn() + WorkersAIFluxSTT/TTS — iterate จากตรงนั้น -->
