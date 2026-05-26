---
marp: true
theme: default
paginate: true
title: "System Design EP3: Load Balancing & Horizontal Scaling"
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
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# System Design EP3
# Load Balancing & Horizontal Scaling

<p class="tag">Algorithms · Layer 4 vs 7 · Health Checks · HA · Zero-Downtime Deploy</p>

<!-- Speaker: EP3 — load balancer คือ gateway สู่ horizontal scaling; ไม่มี LB = ไม่สามารถ scale out ได้จริง -->

---

## Load Balancer: ประตูสู่ Horizontal Scaling

<p class="subhead">ไม่มี Load Balancer = ไม่มีทางหนี SPOF; มี LB = เพิ่ม server ได้อิสระโดยไม่แตะ client</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="60" width="200" height="180" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="130" y="90" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ไม่มี LB</text>
  <rect x="50" y="108" width="160" height="36" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="130" y="131" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Users</text>
  <rect x="50" y="158" width="160" height="60" rx="6" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <text x="130" y="183" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Server เดียว</text>
  <text x="130" y="200" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ล้ม = ระบบล่ม</text>
  <rect x="310" y="60" width="760" height="180" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="690" y="90" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">มี LB</text>
  <rect x="330" y="108" width="100" height="36" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="380" y="131" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Users</text>
  <rect x="490" y="108" width="120" height="112" rx="8" fill="var(--accent)" opacity=".9"/>
  <text x="550" y="158" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Load</text>
  <text x="550" y="178" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Balancer</text>
  <rect x="680" y="108" width="120" height="32" rx="6" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="740" y="129" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Server 1 OK</text>
  <rect x="680" y="150" width="120" height="32" rx="6" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="740" y="171" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Server 2 OK</text>
  <rect x="680" y="192" width="120" height="32" rx="6" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1" stroke-dasharray="4,2"/>
  <text x="740" y="213" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Server 3 DOWN</text>
  <rect x="870" y="120" width="170" height="80" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="955" y="150" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Server 3 ล้ม</text>
  <text x="955" y="168" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">LB ตัดออกอัตโนมัติ</text>
  <text x="955" y="186" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1+2 รับ traffic ต่อ</text>
  <line x1="430" y1="126" x2="490" y2="150" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="610" y1="130" x2="680" y2="124" stroke="var(--success)" stroke-width="1.5"/>
  <line x1="610" y1="160" x2="680" y2="166" stroke="var(--success)" stroke-width="1.5"/>
  <line x1="610" y1="175" x2="680" y2="208" stroke="var(--danger)" stroke-width="1" stroke-dasharray="3,2"/>
  <line x1="800" y1="160" x2="870" y2="160" stroke="var(--muted)" stroke-width="1" stroke-dasharray="3,2"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> LB แก้ 3 ปัญหาพร้อมกัน: High Availability, Scalability, และ Performance distribution</div>

<!-- Speaker: เปรียบกับแคชเชียร์: คนเดียว = คิวยาว; หลายช่อง + supervisor = throughput สูงและไม่หยุดถ้าคนหนึ่งลาป่วย -->

---

## Algorithms: เลือกวิธีแจก Traffic ให้ถูก

<p class="subhead">แต่ละ algorithm มี trade-off ต่างกัน — เลือกตาม workload ไม่ใช่ตาม default</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Algorithm 1</p>
    <h3>Round Robin</h3>
    <p>ส่ง request ทีละ server วนไปเรื่อย ๆ ตามลำดับ</p>
    <ul>
      <li>ง่ายที่สุด, overhead ต่ำ</li>
      <li>เหมาะ: server spec เท่ากัน</li>
      <li>ข้อเสีย: ไม่รู้ว่า server ไหน busy</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Algorithm 2</p>
    <h3>Least Connections</h3>
    <p>ส่งไปยัง server ที่มี active connections น้อยที่สุดในขณะนั้น</p>
    <ul>
      <li>เหมาะ: WebSocket, file upload</li>
      <li>จัดการ long-lived connections ได้ดี</li>
      <li>ต้องติดตาม connection count</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Algorithm 3</p>
    <h3>Weighted Round Robin</h3>
    <p>กำหนด weight ตาม capacity — server แรงกว่าได้ traffic มากกว่า</p>
    <ul>
      <li>เหมาะ: server spec ต่างกัน</li>
      <li>ใช้สำหรับ canary deployment</li>
      <li>ยืดหยุ่นที่สุดใน 3 ตัว</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Round Robin คือ default ที่ดี; Least Connections สำหรับ long-lived; Weighted สำหรับ heterogeneous fleet</div>

<!-- Speaker: Weighted Round Robin ยังใช้สำหรับ canary deploy: new version weight=10, old=90 เพื่อ test กับ traffic 10% -->

---

## IP Hash และ Least Response Time

<p class="subhead">IP Hash แก้ปัญหา session; Least Response Time เหมาะ workload ที่ request time ต่างกันมาก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Algorithm 4 — Sticky Sessions</p>
    <h3>IP Hash</h3>
    <p>Hash จาก client IP เพื่อส่ง request จาก client เดิมไปยัง server เดิมเสมอ</p>
    <ul>
      <li>เหมาะ: legacy stateful apps</li>
      <li>ปัญหา: ถ้า server ล้ม session หาย</li>
      <li>ปัญหา: scaling ยากเพราะ client bind กับ server</li>
      <li>แนะนำ: migrate ไป shared session store (Redis) แทน</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">Algorithm 5 — Adaptive</p>
    <h3>Least Response Time</h3>
    <p>ส่งไปยัง server ที่ average response time ต่ำที่สุดในช่วงเวลาที่ผ่านมา</p>
    <ul>
      <li>เหมาะ: heterogeneous workloads</li>
      <li>จัดการ slow server ได้อัตโนมัติ</li>
      <li>ข้อเสีย: overhead จาก monitoring</li>
      <li>มีใน HAProxy, Nginx Plus, AWS ALB</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> IP Hash เป็น anti-pattern สำหรับ elastic scaling — แก้ปัญหา root cause ด้วย stateless design + shared session store</div>

<!-- Speaker: IP Hash ทำให้ auto-scaling ยาก เพราะเมื่อเพิ่ม server ใหม่ hash distribution เปลี่ยน client บางส่วนถูก reroute -->

---

## Layer 4 vs Layer 7: รู้จัก Traffic ในระดับไหน?

<p class="subhead">Layer ที่สูงกว่า = รู้จัก traffic มากกว่า = routing ฉลาดกว่า แต่มี latency overhead เพิ่มขึ้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Layer 4 — Transport Layer</p>
    <h3>TCP/UDP Level</h3>
    <p>ทำงานที่ระดับ TCP — รู้แค่ IP address และ Port ไม่รู้เนื้อหา HTTP</p>
    <ul>
      <li>เร็วกว่า (ไม่ต้อง inspect packet content)</li>
      <li>ไม่รู้จัก URL, headers, cookies</li>
      <li>ไม่ทำ SSL termination</li>
      <li>เหมาะ: database proxy, raw TCP, latency-critical</li>
      <li>ตัวอย่าง: AWS NLB, HAProxy TCP mode</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Layer 7 — Application Layer</p>
    <h3>HTTP/HTTPS Level</h3>
    <p>รู้จัก URL path, HTTP headers, cookies — routing ฉลาดได้ตาม content</p>
    <ul>
      <li>Route ตาม path: /api/ ไป API servers</li>
      <li>SSL termination: decrypt ที่ LB, backend ใช้ HTTP</li>
      <li>สามารถ compress, cache, แก้ headers ได้</li>
      <li>เหมาะ: microservices, web apps</li>
      <li>ตัวอย่าง: Nginx, AWS ALB, Traefik</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Layer 7 LB เหมาะกับ microservices เพราะ route ตาม URL path ได้ — /api/ ไป API servers, /ws/ ไป WebSocket servers</div>

<!-- Speaker: Layer 7 LB ทำ SSL termination ด้วย — backend ไม่ต้องจัดการ TLS ลดความซับซ้อนและ CPU load -->

---

## Health Checks: LB รู้ได้อย่างไรว่า Server พัง?

<p class="subhead">LB ต้องรู้ server status ก่อนส่ง traffic — health check ที่ดีต้องทดสอบ dependencies จริง</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="60" width="160" height="180" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="110" y="100" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Load</text>
  <text x="110" y="120" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Balancer</text>
  <text x="110" y="148" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">polls every</text>
  <text x="110" y="164" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">10–30s</text>
  <rect x="270" y="40" width="220" height="80" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="380" y="68" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Server 1 — Healthy</text>
  <text x="380" y="86" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">GET /health  200 OK</text>
  <text x="380" y="102" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DB: connected, Cache: ok</text>
  <rect x="270" y="140" width="220" height="80" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="380" y="168" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Server 2 — Healthy</text>
  <text x="380" y="186" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">GET /health  200 OK</text>
  <text x="380" y="202" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DB: connected, Cache: ok</text>
  <rect x="270" y="240" width="220" height="60" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="380" y="265" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Server 3 — Unhealthy</text>
  <text x="380" y="283" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">GET /health  503 — DB timeout</text>
  <rect x="580" y="220" width="240" height="80" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="700" y="250" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Server 3 ถูกตัดออก</text>
  <text x="700" y="268" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">traffic ไป 1+2 เท่านั้น</text>
  <text x="700" y="286" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">จนกว่า /health กลับมา 200</text>
  <rect x="580" y="60" width="480" height="130" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="820" y="88" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Health Endpoint ที่ดีต้องทดสอบ</text>
  <rect x="598" y="102" width="440" height="22" rx="4" fill="var(--success-wash)"/>
  <text x="818" y="118" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DB connection: SELECT 1 ได้ผล</text>
  <rect x="598" y="130" width="440" height="22" rx="4" fill="var(--success-wash)"/>
  <text x="818" y="146" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Cache ping: Redis PONG</text>
  <rect x="598" y="158" width="440" height="22" rx="4" fill="var(--warning-wash)"/>
  <text x="818" y="174" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ไม่ใช่แค่: process alive = 200</text>
  <line x1="190" y1="110" x2="270" y2="80" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="190" y1="130" x2="270" y2="180" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="190" y1="150" x2="270" y2="270" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="4,2"/>
  <line x1="490" y1="270" x2="580" y2="260" stroke="var(--danger)" stroke-width="1.5"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Health endpoint ต้องเช็ค dependencies จริง (DB, cache) — ถ้าเช็คแค่ "process alive" LB ไม่รู้ว่า server serve ได้จริงหรือเปล่า</div>

<!-- Speaker: Deep health check สำคัญ: server อาจ run อยู่แต่ DB connection pool หมด — ถ้า /health แค่ return 200 เสมอ LB จะส่ง traffic ไปจนกว่า user จะ error -->

---

## High Availability: LB ตัวเองต้องไม่เป็น SPOF

<p class="subhead">Load Balancer ที่มีแค่ตัวเดียวคือ SPOF ตัวใหม่ — ต้องมี HA setup ด้วย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Pattern 1 — Failover</p>
    <h3>Active-Passive HA</h3>
    <p>Primary LB รับ traffic ทั้งหมด; Secondary รอ standby พร้อม VIP (Virtual IP)</p>
    <ul>
      <li>Primary ล้ม: VIP ย้ายไป Secondary ใน ~1–30s</li>
      <li>ง่ายกว่า active-active</li>
      <li>ข้อเสีย: Secondary ไม่ได้ใช้งานตลอดเวลา</li>
      <li>เหมาะ: traffic ไม่สูงมาก, ต้องการความเรียบง่าย</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Pattern 2 — Load Share</p>
    <h3>Active-Active HA</h3>
    <p>LB หลายตัวทำงานพร้อมกัน DNS round robin กระจาย traffic ระหว่าง LB</p>
    <ul>
      <li>ทุก LB รับ traffic — ไม่มี idle resource</li>
      <li>LB หนึ่งล้ม: DNS ตัดออก LB อื่นรับแทน</li>
      <li>Throughput สูงกว่า active-passive</li>
      <li>Cloud providers (AWS ALB, GCP) ทำอัตโนมัติ</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ Cloud managed LB (AWS ALB/GCP LB) เพื่อให้ provider จัดการ HA ให้อัตโนมัติ — ไม่ต้องทำ failover เอง</div>

<!-- Speaker: AWS ALB, GCP Load Balancing เป็น multi-AZ by default — HA ถูกออกแบบมาในตัว ไม่ต้องคิดเรื่อง SPOF เอง -->

---

## Zero-Downtime Deploy ด้วย Rolling Update

<p class="subhead">LB + stateless servers = deploy ใหม่ได้โดยไม่หยุดระบบแม้แต่วินาทีเดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <text x="40" y="30" font-size="12" font-weight="700" fill="var(--ink-dim)" font-family="system-ui">Before</text>
  <rect x="40" y="44" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="90" y="68" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">A v1</text>
  <rect x="160" y="44" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="210" y="68" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">B v1</text>
  <rect x="280" y="44" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="330" y="68" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">C v1</text>
  <text x="40" y="112" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">Step 1</text>
  <rect x="40" y="126" width="100" height="38" rx="6" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="90" y="150" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">A v2</text>
  <rect x="160" y="126" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="210" y="150" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">B v1</text>
  <rect x="280" y="126" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="330" y="150" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">C v1</text>
  <text x="40" y="194" font-size="12" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">Step 2</text>
  <rect x="40" y="208" width="100" height="38" rx="6" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="90" y="232" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">A v2</text>
  <rect x="160" y="208" width="100" height="38" rx="6" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="210" y="232" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">B v2</text>
  <rect x="280" y="208" width="100" height="38" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="330" y="232" font-size="11" fill="var(--ink)" text-anchor="middle" font-family="system-ui">C v1</text>
  <rect x="480" y="24" width="590" height="264" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="775" y="52" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">วิธีทำ: Rolling Update</text>
  <rect x="500" y="66" width="550" height="34" rx="6" fill="var(--paper)"/>
  <text x="775" y="88" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">1. Deploy Server A ไป v2; รอ health check ผ่าน</text>
  <rect x="500" y="108" width="550" height="34" rx="6" fill="var(--paper)"/>
  <text x="775" y="130" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2. Deploy Server B ไป v2; รอ health check ผ่าน</text>
  <rect x="500" y="150" width="550" height="34" rx="6" fill="var(--paper)"/>
  <text x="775" y="172" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">3. Deploy Server C ไป v2; รอ health check ผ่าน</text>
  <rect x="500" y="202" width="550" height="72" rx="6" fill="var(--success-wash)"/>
  <text x="775" y="232" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ผล: ตลอดเวลา มี server อย่างน้อย 2 ตัว serve traffic</text>
  <text x="775" y="254" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไม่มี downtime แม้แต่วินาทีเดียว</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Rolling update ทำงานได้เพราะ stateless servers — ถ้า server ยังมี local state, user จะ lose session เมื่อ server restart</div>

<!-- Speaker: Kubernetes ทำ rolling update อัตโนมัติ: maxUnavailable=0, maxSurge=1 หมายความว่า always ≥ N replicas ready -->

---

## Key Takeaways: Load Balancing ให้ถูกวิธี

<p class="subhead">สิ่งที่ต้องจำจาก EP3 — LB คือ infrastructure foundation ของทุก scalable system</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Rule 1</p>
    <h3>Algorithm Matters</h3>
    <p>Round Robin สำหรับ uniform load; Least Connections สำหรับ long-lived; Weighted สำหรับ canary</p>
  </div>
  <div class="card warning">
    <p class="label">Rule 2</p>
    <h3>Layer 7 for Microservices</h3>
    <p>Layer 7 LB route ตาม URL path ได้ — /api, /ws, /static ไปคนละ server pool</p>
  </div>
  <div class="card danger">
    <p class="label">Rule 3</p>
    <h3>Real Health Checks</h3>
    <p>Health endpoint ต้องเช็ค DB connection และ cache จริง ไม่ใช่แค่ process alive</p>
  </div>
  <div class="card success">
    <p class="label">Rule 4</p>
    <h3>LB ต้องมี HA เอง</h3>
    <p>Single LB = SPOF ตัวใหม่; ใช้ active-passive หรือ cloud managed LB ที่ HA by default</p>
  </div>
  <div class="card gold">
    <p class="label">Rule 5</p>
    <h3>Stateless First</h3>
    <p>Sticky sessions เป็น anti-pattern; ย้าย session ไป Redis เพื่อ true horizontal scaling</p>
  </div>
  <div class="card">
    <p class="label">Rule 6</p>
    <h3>Zero-Downtime ฟรี</h3>
    <p>LB + stateless servers = rolling update ได้โดยไม่ต้อง maintenance window</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Load balancer ไม่ใช่แค่ traffic router — มันคือ enabler ของ horizontal scaling, HA, และ zero-downtime deployment</div>

<!-- Speaker: EP4 ต่อไป: API Design — REST vs GraphQL vs gRPC; เมื่อไหรใช้ตัวไหน และ API Gateway pattern -->
