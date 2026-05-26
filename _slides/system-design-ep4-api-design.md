---
marp: true
theme: default
paginate: true
title: "System Design EP4: ออกแบบ API ให้ถูกต้อง — REST, GraphQL และ gRPC"
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

# System Design EP4
# ออกแบบ API ให้ถูกต้อง

<p class="tag">REST · GraphQL · gRPC · API Gateway · Versioning · Pagination</p>

<!-- Speaker: EP4 — API คือสัญญาระหว่าง producer กับ consumer ออกแบบผิดครั้งเดียว แก้ทุก consumer พร้อมกัน -->

---

## API คือสัญญา — ผิดแล้วแก้ทุก Consumer พร้อมกัน

<p class="subhead">ไม่มี API ตัวไหน "ดีที่สุด" — REST เหมาะ public API, GraphQL เหมาะ complex clients, gRPC เหมาะ internal services</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">REST</p>
    <h3>Universal Standard</h3>
    <p>HTTP verbs + resource URLs; JSON; ทุก platform รองรับ</p>
    <ul>
      <li>Cacheable ด้วย HTTP</li>
      <li>Ecosystem ใหญ่ที่สุด</li>
      <li>เหมาะ: Public API, Mobile</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">GraphQL</p>
    <h3>Client Drives Query</h3>
    <p>Client ระบุว่าต้องการข้อมูลอะไร — ไม่มี over/under-fetching</p>
    <ul>
      <li>Single endpoint /graphql</li>
      <li>Strongly typed schema</li>
      <li>เหมาะ: BFF, complex clients</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">gRPC</p>
    <h3>Performance First</h3>
    <p>Protocol Buffers + HTTP/2; binary; เร็วกว่า REST 5-10x</p>
    <ul>
      <li>Strongly typed .proto</li>
      <li>Streaming support</li>
      <li>เหมาะ: Internal microservices</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Production systems ใช้หลาย protocol พร้อมกัน — REST สำหรับ external, gRPC สำหรับ internal, GraphQL สำหรับ BFF</div>

<!-- Speaker: ไม่มี protocol ไหนชนะในทุก context — architecture decision คือเลือกตาม interaction type ไม่ใช่ trend -->

---

## REST: HTTP Verbs และ Status Codes ที่ต้องใช้ให้ถูก

<p class="subhead">RESTful API ที่ดีต้องใช้ verb และ status code ถูกต้อง — ผิดคือ contract ที่สื่อสารผิด</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="490" height="268" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="275" y="48" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">HTTP Verbs</text>
  <rect x="50" y="58" width="452" height="26" rx="4" fill="var(--accent-wash)"/>
  <text x="100" y="76" font-size="11" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">GET</text>
  <text x="220" y="76" font-size="11" fill="var(--ink-dim)" font-family="system-ui">อ่านข้อมูล — Idempotent, ไม่มี body</text>
  <rect x="50" y="90" width="452" height="26" rx="4" fill="var(--paper)"/>
  <text x="100" y="108" font-size="11" font-weight="700" fill="var(--success-ink)" font-family="system-ui">POST</text>
  <text x="220" y="108" font-size="11" fill="var(--ink-dim)" font-family="system-ui">สร้างข้อมูล — ไม่ Idempotent, มี body</text>
  <rect x="50" y="122" width="452" height="26" rx="4" fill="var(--accent-wash)"/>
  <text x="100" y="140" font-size="11" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">PUT</text>
  <text x="220" y="140" font-size="11" fill="var(--ink-dim)" font-family="system-ui">แทนที่ทั้งหมด — Idempotent, มี body</text>
  <rect x="50" y="154" width="452" height="26" rx="4" fill="var(--paper)"/>
  <text x="100" y="172" font-size="11" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">PATCH</text>
  <text x="220" y="172" font-size="11" fill="var(--ink-dim)" font-family="system-ui">อัปเดตบางส่วน — ไม่ Idempotent</text>
  <rect x="50" y="186" width="452" height="26" rx="4" fill="var(--accent-wash)"/>
  <text x="100" y="204" font-size="11" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">DELETE</text>
  <text x="220" y="204" font-size="11" fill="var(--ink-dim)" font-family="system-ui">ลบข้อมูล — Idempotent</text>
  <rect x="50" y="226" width="452" height="50" rx="6" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="100" y="244" font-size="10" fill="var(--ink-dim)" font-family="system-ui">GET /users/123/orders</text>
  <text x="100" y="262" font-size="10" fill="var(--muted)" font-family="system-ui">nested resource: orders ของ user 123</text>
  <rect x="560" y="20" width="510" height="268" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="815" y="48" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Status Codes ที่ต้องจำ</text>
  <rect x="580" y="58" width="470" height="22" rx="4" fill="var(--success-wash)"/>
  <text x="660" y="74" font-size="10" font-weight="700" fill="var(--success-ink)" font-family="system-ui">200 OK</text>
  <text x="800" y="74" font-size="10" fill="var(--success-ink)" font-family="system-ui">GET/PUT/PATCH success</text>
  <rect x="580" y="86" width="470" height="22" rx="4" fill="var(--success-wash)"/>
  <text x="660" y="102" font-size="10" font-weight="700" fill="var(--success-ink)" font-family="system-ui">201 Created</text>
  <text x="800" y="102" font-size="10" fill="var(--success-ink)" font-family="system-ui">POST สร้างสำเร็จ</text>
  <rect x="580" y="114" width="470" height="22" rx="4" fill="var(--success-wash)"/>
  <text x="660" y="130" font-size="10" font-weight="700" fill="var(--success-ink)" font-family="system-ui">204 No Content</text>
  <text x="800" y="130" font-size="10" fill="var(--success-ink)" font-family="system-ui">DELETE สำเร็จ ไม่มี body</text>
  <rect x="580" y="142" width="470" height="22" rx="4" fill="var(--warning-wash)"/>
  <text x="660" y="158" font-size="10" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">400 Bad Request</text>
  <text x="800" y="158" font-size="10" fill="var(--warning-ink)" font-family="system-ui">input ไม่ valid</text>
  <rect x="580" y="170" width="470" height="22" rx="4" fill="var(--warning-wash)"/>
  <text x="660" y="186" font-size="10" font-weight="700" fill="var(--warning-ink)" font-family="system-ui">401 Unauthorized</text>
  <text x="800" y="186" font-size="10" fill="var(--warning-ink)" font-family="system-ui">ยังไม่ได้ authenticate</text>
  <rect x="580" y="198" width="470" height="22" rx="4" fill="var(--danger-wash)"/>
  <text x="660" y="214" font-size="10" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">403 Forbidden</text>
  <text x="800" y="214" font-size="10" fill="var(--danger-ink)" font-family="system-ui">authenticated แต่ไม่มีสิทธิ์</text>
  <rect x="580" y="226" width="470" height="22" rx="4" fill="var(--danger-wash)"/>
  <text x="660" y="242" font-size="10" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">429 Too Many Requests</text>
  <text x="800" y="242" font-size="10" fill="var(--danger-ink)" font-family="system-ui">rate limited</text>
  <rect x="580" y="254" width="470" height="22" rx="4" fill="var(--danger-wash)"/>
  <text x="660" y="270" font-size="10" font-weight="700" fill="var(--danger-ink)" font-family="system-ui">500 Internal Server Error</text>
  <text x="800" y="270" font-size="10" fill="var(--danger-ink)" font-family="system-ui">server bug</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 401 = ไม่รู้ว่าคุณคือใคร; 403 = รู้แล้วแต่ไม่ให้เข้า — ใช้ผิดทำให้ client debug ยาก</div>

<!-- Speaker: status code ที่ใช้ผิดที่พบบ่อย: return 200 พร้อม error ใน body, ใช้ 401 แทน 403 -->

---

## GraphQL: Client ถาม เฉพาะสิ่งที่ต้องการ

<p class="subhead">แก้ปัญหา over-fetching และ under-fetching ของ REST ด้วย query ที่ client กำหนดเอง</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="490" height="260" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1"/>
  <text x="275" y="48" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">REST: 2 requests, data เกินความต้องการ</text>
  <rect x="50" y="60" width="450" height="50" rx="6" fill="var(--paper)"/>
  <text x="70" y="81" font-size="10" fill="var(--ink-dim)" font-family="system-ui">GET /users/123</text>
  <text x="70" y="99" font-size="10" fill="var(--danger-ink)" font-family="system-ui">ดึง: id, name, email, address, phone, ... (ทั้งหมด)</text>
  <rect x="50" y="120" width="450" height="50" rx="6" fill="var(--paper)"/>
  <text x="70" y="141" font-size="10" fill="var(--ink-dim)" font-family="system-ui">GET /users/123/posts?limit=3</text>
  <text x="70" y="159" font-size="10" fill="var(--danger-ink)" font-family="system-ui">ดึง: id, title, content, tags, ... (ทั้งหมดของ post)</text>
  <rect x="50" y="184" width="450" height="80" rx="6" fill="var(--paper)"/>
  <text x="275" y="208" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">ปัญหา</text>
  <text x="275" y="228" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2 HTTP round trips</text>
  <text x="275" y="246" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ข้อมูลเยอะกว่าที่ client ต้องการมาก</text>
  <rect x="580" y="20" width="490" height="260" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="825" y="48" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">GraphQL: 1 request, ได้แค่ที่ต้องการ</text>
  <rect x="600" y="60" width="450" height="130" rx="6" fill="var(--paper)"/>
  <text x="620" y="82" font-size="10" fill="var(--ink-dim)" font-family="system-ui">query {</text>
  <text x="640" y="100" font-size="10" fill="var(--accent)" font-family="system-ui">user(id: "123") {</text>
  <text x="660" y="118" font-size="10" fill="var(--ink-dim)" font-family="system-ui">name</text>
  <text x="660" y="136" font-size="10" fill="var(--ink-dim)" font-family="system-ui">posts(limit: 3) {</text>
  <text x="680" y="154" font-size="10" fill="var(--ink-dim)" font-family="system-ui">title</text>
  <text x="660" y="172" font-size="10" fill="var(--ink-dim)" font-family="system-ui">} } }</text>
  <rect x="600" y="206" width="450" height="60" rx="6" fill="var(--paper)"/>
  <text x="825" y="230" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ผล: 1 request, ได้ name + 3 post titles เท่านั้น</text>
  <text x="825" y="252" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไม่มี field ที่ไม่ต้องการ</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> GraphQL เหมาะกับ BFF pattern — frontend กำหนด query เองได้ ไม่ต้องรอ backend เพิ่ม endpoint ใหม่</div>

<!-- Speaker: N+1 problem: query 100 posts พร้อม author จะเรียก DB 101 ครั้ง — แก้ด้วย DataLoader (batching) -->

---

## gRPC: Binary Protocol สำหรับ Internal Services

<p class="subhead">Protocol Buffers + HTTP/2 ทำให้ gRPC เร็วกว่า REST ถึง 5-10x — เหมาะกับ high-frequency internal calls</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="480" height="260" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="48" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">.proto Definition</text>
  <rect x="50" y="58" width="440" height="200" rx="6" fill="var(--paper)"/>
  <text x="70" y="80" font-size="10" fill="var(--muted)" font-family="system-ui">syntax = "proto3";</text>
  <text x="70" y="100" font-size="10" fill="var(--accent)" font-family="system-ui">service UserService {</text>
  <text x="90" y="120" font-size="10" fill="var(--ink-dim)" font-family="system-ui">rpc GetUser (GetUserRequest)</text>
  <text x="110" y="138" font-size="10" fill="var(--ink-dim)" font-family="system-ui">returns (User);</text>
  <text x="90" y="158" font-size="10" fill="var(--ink-dim)" font-family="system-ui">rpc ListUsers (ListUsersRequest)</text>
  <text x="110" y="176" font-size="10" fill="var(--ink-dim)" font-family="system-ui">returns (stream User);</text>
  <text x="70" y="196" font-size="10" fill="var(--accent)" font-family="system-ui">}</text>
  <text x="70" y="218" font-size="10" fill="var(--muted)" font-family="system-ui">message User { string id = 1; string name = 2; }</text>
  <rect x="570" y="20" width="500" height="260" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="820" y="48" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">gRPC vs REST Performance</text>
  <rect x="590" y="60" width="460" height="50" rx="6" fill="var(--danger-wash)"/>
  <text x="820" y="82" font-size="11" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">REST (JSON): ~250ms average</text>
  <text x="820" y="100" font-size="10" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">text serialization + HTTP/1.1 overhead</text>
  <rect x="590" y="120" width="460" height="50" rx="6" fill="var(--warning-wash)"/>
  <text x="820" y="142" font-size="11" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">GraphQL: ~180ms (complex queries)</text>
  <text x="820" y="160" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">schema resolution + single endpoint</text>
  <rect x="590" y="180" width="460" height="50" rx="6" fill="var(--success-wash)"/>
  <text x="820" y="202" font-size="11" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">gRPC (protobuf): ~25ms</text>
  <text x="820" y="220" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">binary + HTTP/2 multiplexing = 5-10x faster</text>
  <rect x="590" y="244" width="460" height="24" rx="4" fill="var(--paper)"/>
  <text x="820" y="261" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Browser support จำกัด — ใช้ gRPC-Web proxy สำหรับ frontend</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> gRPC เหมาะกับ internal microservices ที่เรียกกันบ่อย — ทุก service generate client จาก .proto เดียวกันได้ทุก language</div>

<!-- Speaker: gRPC streaming: unary (1:1), server stream (1:N), client stream (N:1), bidirectional (N:N) — เหมาะกับ real-time data -->

---

## API Gateway: Central Entry Point สำหรับ Microservices

<p class="subhead">แทนที่จะให้ client เรียก service โดยตรง — API Gateway รวม cross-cutting concerns ไว้ที่เดียว</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="100" width="100" height="90" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="80" y="140" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Mobile</text>
  <text x="80" y="160" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">App</text>
  <rect x="30" y="200" width="100" height="70" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="80" y="235" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Web</text>
  <text x="80" y="255" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Browser</text>
  <rect x="230" y="60" width="220" height="220" rx="12" fill="var(--accent)" opacity=".9"/>
  <text x="340" y="96" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">API Gateway</text>
  <rect x="248" y="110" width="184" height="24" rx="4" fill="rgba(255,255,255,.2)"/>
  <text x="340" y="127" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Authentication</text>
  <rect x="248" y="140" width="184" height="24" rx="4" fill="rgba(255,255,255,.2)"/>
  <text x="340" y="157" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Rate Limiting</text>
  <rect x="248" y="170" width="184" height="24" rx="4" fill="rgba(255,255,255,.2)"/>
  <text x="340" y="187" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Request Routing</text>
  <rect x="248" y="200" width="184" height="24" rx="4" fill="rgba(255,255,255,.2)"/>
  <text x="340" y="217" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Response Aggregation</text>
  <rect x="248" y="230" width="184" height="24" rx="4" fill="rgba(255,255,255,.2)"/>
  <text x="340" y="247" font-size="10" fill="white" text-anchor="middle" font-family="system-ui">Logging + Monitoring</text>
  <rect x="560" y="30" width="180" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="650" y="56" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Auth Service</text>
  <text x="650" y="74" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/auth/*</text>
  <rect x="560" y="110" width="180" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="650" y="136" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User Service</text>
  <text x="650" y="154" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/users/*</text>
  <rect x="560" y="190" width="180" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="650" y="216" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Order Service</text>
  <text x="650" y="234" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">/orders/*</text>
  <rect x="830" y="110" width="240" height="110" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1"/>
  <text x="950" y="138" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ประโยชน์</text>
  <text x="950" y="158" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Client เรียก URL เดียว</text>
  <text x="950" y="176" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Auth จัดการที่เดียว</text>
  <text x="950" y="194" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Service เพิ่ม/ลบได้ตลอด</text>
  <text x="950" y="212" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ไม่กระทบ client</text>
  <line x1="130" y1="145" x2="230" y2="165" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="130" y1="235" x2="230" y2="210" stroke="var(--accent)" stroke-width="1.5"/>
  <line x1="450" y1="120" x2="560" y2="60" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="450" y1="170" x2="560" y2="140" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="450" y1="220" x2="560" y2="220" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="740" y1="165" x2="830" y2="165" stroke="var(--muted)" stroke-width="1" stroke-dasharray="4,2"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> API Gateway = single entry point ที่จัดการ auth, rate limiting, logging ทำให้แต่ละ service ไม่ต้องทำเอง</div>

<!-- Speaker: ตัวอย่าง: AWS API Gateway, Kong, Traefik, Nginx — เลือกตาม scale และ cloud environment -->

---

## เลือก API Protocol ให้ตรงกับ Use Case

<p class="subhead">ไม่มี protocol ไหนชนะในทุก situation — แต่ละ interaction type มีตัวที่เหมาะที่สุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">REST เหมาะกับ</p>
    <h3>Public + Standard</h3>
    <ul>
      <li>Public Web/Mobile API — ecosystem ใหญ่, cacheable</li>
      <li>File upload — REST multipart</li>
      <li>Integration กับ third-party systems</li>
      <li>Team ที่ยังไม่คุ้นกับ GraphQL/gRPC</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">GraphQL เหมาะกับ</p>
    <h3>Complex + Flexible</h3>
    <ul>
      <li>BFF (Backend For Frontend) — mobile vs web</li>
      <li>Dashboard ที่ query pattern เปลี่ยนบ่อย</li>
      <li>Aggregating data จากหลาย microservices</li>
      <li>Rapid iteration โดยไม่ต้องเพิ่ม endpoint</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">gRPC เหมาะกับ</p>
    <h3>Internal + Performance</h3>
    <ul>
      <li>Service-to-service calls ใน microservices</li>
      <li>Streaming data pipeline (ข้อมูลไหลต่อเนื่อง)</li>
      <li>High-frequency calls ที่ latency สำคัญมาก</li>
      <li>Polyglot teams: generate client หลาย language</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Best Practices</p>
    <h3>Design Fundamentals</h3>
    <ul>
      <li>Version ตั้งแต่วันแรก: /v1/users แม้ยังไม่มี v2</li>
      <li>Cursor pagination สำหรับ real-time data</li>
      <li>Rate limit headers: X-RateLimit-Remaining</li>
      <li>Backward compatibility: อย่า break existing consumers</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Versioning ตั้งแต่วันแรก (v1) แม้ยังไม่มี v2 — เพราะเปลี่ยน API format โดยไม่มี versioning = break ทุก consumer</div>

<!-- Speaker: Production systems มักใช้ทั้ง 3: REST สำหรับ external, gRPC สำหรับ internal, GraphQL สำหรับ BFF -->

---

## Key Takeaways: API Design ที่ถูกต้อง

<p class="subhead">สิ่งที่ต้องจำจาก EP4 — API คือ contract; ผิดแล้วแก้ยาก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Rule 1</p>
    <h3>Protocol ตาม Context</h3>
    <p>REST สำหรับ public; GraphQL สำหรับ complex clients; gRPC สำหรับ internal high-perf</p>
  </div>
  <div class="card warning">
    <p class="label">Rule 2</p>
    <h3>Status Code ถูกต้อง</h3>
    <p>401 คือ not authenticated; 403 คือ authorized แต่ forbidden — ใช้ผิดทำ debug ยาก</p>
  </div>
  <div class="card success">
    <p class="label">Rule 3</p>
    <h3>Version ตั้งแต่แรก</h3>
    <p>เพิ่ม /v1/ ตั้งแต่วันแรก แม้ยังไม่มี v2 — backward compatibility เป็น contract</p>
  </div>
  <div class="card danger">
    <p class="label">Rule 4</p>
    <h3>GraphQL N+1</h3>
    <p>query nested หลายชั้นอาจ call DB หลาย 100 ครั้ง — แก้ด้วย DataLoader batching</p>
  </div>
  <div class="card gold">
    <p class="label">Rule 5</p>
    <h3>API Gateway</h3>
    <p>Central entry point สำหรับ auth, rate limiting, routing — ทำให้ services ไม่ต้อง duplicate</p>
  </div>
  <div class="card">
    <p class="label">Rule 6</p>
    <h3>gRPC เร็ว 5-10x</h3>
    <p>binary protobuf + HTTP/2 multiplexing — สำคัญมากสำหรับ high-frequency internal calls</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Production systems ไม่ได้ใช้แค่ protocol เดียว — เลือกตาม interaction type; REST external, gRPC internal, GraphQL BFF</div>

<!-- Speaker: EP5 สุดท้าย: Authentication, Authorization และ Security — JWT, OAuth2, OWASP Top 10 -->
