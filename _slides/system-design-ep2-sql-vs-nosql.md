---
marp: true
theme: default
paginate: true
title: "System Design EP2: เลือกฐานข้อมูลให้ถูกประเภท — SQL vs NoSQL"
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
  section.title h1 { font-size:42px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# System Design EP2
# เลือกฐานข้อมูลให้ถูกประเภท

<p class="tag">SQL vs NoSQL · ACID vs BASE · CAP Theorem · Decision Framework</p>

<!-- Speaker: EP2 — foundation ที่ผิดพลาดบ่อยที่สุดเพราะเลือก DB จาก habit ไม่ใช่ requirement -->

---

## ฐานข้อมูลที่ผิดประเภทคือ Tech Debt ที่แก้ยากที่สุด

<p class="subhead">ไม่มี database ที่ดีที่สุด — มีแค่ database ที่เหมาะกับ access pattern ของ application นั้น ๆ</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="60" width="300" height="220" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="60" width="300" height="48" rx="12" fill="var(--accent)" opacity=".12"/>
  <text x="190" y="90" font-size="15" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">SQL</text>
  <text x="190" y="108" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Relational Database</text>
  <text x="190" y="140" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Tables + Relationships</text>
  <text x="190" y="162" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ACID Transactions</text>
  <text x="190" y="184" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Strong Consistency</text>
  <text x="190" y="206" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">PostgreSQL, MySQL</text>
  <text x="190" y="252" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Finance · Healthcare · ERP</text>
  <rect x="405" y="120" width="290" height="100" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="550" y="154" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Choose by</text>
  <text x="550" y="178" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Access Pattern</text>
  <text x="550" y="202" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">not by habit or hype</text>
  <rect x="760" y="60" width="300" height="220" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="760" y="60" width="300" height="48" rx="12" fill="var(--warning)" opacity=".12"/>
  <text x="910" y="90" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">NoSQL</text>
  <text x="910" y="108" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Non-Relational Database</text>
  <text x="910" y="140" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Flexible Schema</text>
  <text x="910" y="162" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">BASE / Eventual Consistency</text>
  <text x="910" y="184" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Horizontal Scale</text>
  <text x="910" y="206" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">MongoDB, Redis, Cassandra</text>
  <text x="910" y="252" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">IoT · Social · Cache · Graph</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือก DB จาก access pattern จริง — migration ภายหลังคือ tech debt ที่ cost สูงมาก</div>

<!-- Speaker: แต่ละ DB เหมาะกับ use case ที่ต่างกัน — production systems ใช้หลายตัวพร้อมกัน -->

---

## SQL: Structured Data พร้อม ACID และ Relationships

<p class="subhead">Tables, JOIN, และ foreign keys คือจุดแข็งของ SQL ที่ NoSQL ทำแทนได้ยาก</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="460" height="280" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="40" y="20" width="460" height="44" rx="12" fill="var(--accent)" opacity=".12"/>
  <text x="270" y="48" font-size="14" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">users</text>
  <rect x="60" y="74" width="420" height="28" rx="4" fill="var(--accent-wash)"/>
  <text x="150" y="93" font-size="11" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">id</text>
  <text x="260" y="93" font-size="11" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">name</text>
  <text x="380" y="93" font-size="11" font-weight="700" fill="var(--accent-deep)" font-family="system-ui">email</text>
  <line x1="60" y1="102" x2="480" y2="102" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="150" y="122" font-size="11" fill="var(--ink-dim)" font-family="system-ui">1</text>
  <text x="240" y="122" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Alice</text>
  <text x="350" y="122" font-size="11" fill="var(--ink-dim)" font-family="system-ui">alice@ex.com</text>
  <line x1="60" y1="132" x2="480" y2="132" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="150" y="152" font-size="11" fill="var(--ink-dim)" font-family="system-ui">2</text>
  <text x="240" y="152" font-size="11" fill="var(--ink-dim)" font-family="system-ui">Bob</text>
  <text x="350" y="152" font-size="11" fill="var(--ink-dim)" font-family="system-ui">bob@ex.com</text>
  <line x1="60" y1="162" x2="480" y2="162" stroke="var(--soft-2)" stroke-width="1"/>
  <rect x="40" y="190" width="460" height="100" rx="8" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="270" y="212" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">JOIN Query</text>
  <rect x="55" y="222" width="430" height="58" rx="6" fill="var(--soft)"/>
  <text x="75" y="242" font-size="10" fill="var(--ink-dim)" font-family="system-ui">SELECT u.name, o.total</text>
  <text x="75" y="258" font-size="10" fill="var(--ink-dim)" font-family="system-ui">FROM orders o</text>
  <text x="75" y="274" font-size="10" fill="var(--ink-dim)" font-family="system-ui">JOIN users u ON o.user_id = u.id</text>
  <rect x="540" y="20" width="520" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="800" y="58" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">SQL Strengths</text>
  <rect x="560" y="76" width="480" height="56" rx="8" fill="var(--success-wash)"/>
  <text x="800" y="100" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ACID Transactions</text>
  <text x="800" y="120" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">ความถูกต้อง 100% แม้มี concurrent writes</text>
  <rect x="560" y="142" width="480" height="56" rx="8" fill="var(--accent-wash)"/>
  <text x="800" y="166" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Complex Queries (JOIN)</text>
  <text x="800" y="186" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ดึงข้อมูลจากหลาย table ในคำสั่งเดียว</text>
  <rect x="560" y="208" width="480" height="56" rx="8" fill="var(--warning-wash)"/>
  <text x="800" y="232" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Mature Ecosystem</text>
  <text x="800" y="252" font-size="10" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">ORM, BI tools, migration tools ครบครัน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> SQL เป็น default ที่ดีสำหรับ structured data — ถ้าต้องการ JOIN หลาย table หรือ ACID compliance ให้เลือก SQL</div>

<!-- Speaker: PostgreSQL เป็นตัวที่แนะนำสำหรับ new projects ที่ไม่แน่ใจ — ทั้ง SQL features และ JSON support -->

---

## NoSQL: 4 ประเภท 4 Use Case ที่ต่างกันสิ้นเชิง

<p class="subhead">NoSQL ไม่ใช่ "SQL แต่ไม่มี SQL" — มีหลาย data model แต่ละตัวแก้ปัญหาต่างกัน</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">Document DB</p>
    <h3>MongoDB</h3>
    <p>เก็บ JSON documents — schema ยืดหยุ่น, แต่ละ record ต่างกันได้</p>
    <ul>
      <li>User profiles</li>
      <li>Product catalog</li>
      <li>CMS content</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Key-Value DB</p>
    <h3>Redis</h3>
    <p>เร็วมาก, อยู่ใน memory, TTL-based expiry — เหมาะกับ transient data</p>
    <ul>
      <li>Session cache</li>
      <li>Rate limiting</li>
      <li>Leaderboards</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Column-Family DB</p>
    <h3>Cassandra</h3>
    <p>Write-optimized, distributed ดีเยี่ยม, เหมาะ time-series ที่มี massive volume</p>
    <ul>
      <li>IoT sensor data</li>
      <li>Activity logs</li>
      <li>Analytics events</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Graph DB</p>
    <h3>Neo4j</h3>
    <p>Nodes และ Edges — traversal relationship ซับซ้อนที่ SQL JOIN ทำได้ยาก</p>
    <ul>
      <li>Social networks</li>
      <li>Fraud detection</li>
      <li>Recommendation</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทั้ง 4 ประเภทแก้ปัญหาคนละอย่าง — Redis คือ cache ไม่ใช่ primary DB, Neo4j คือ graph ไม่ใช่ general purpose</div>

<!-- Speaker: เน้น: Redis ไม่ใช่ DB หลัก — เป็น cache layer ที่ fast แต่ข้อมูลหายได้เมื่อ restart -->

---

## ACID vs BASE: หัวใจของความแตกต่าง SQL–NoSQL

<p class="subhead">ACID รับประกันความถูกต้องทุกช่วงเวลา — BASE ยอมรับความไม่ consistent ชั่วคราวเพื่อ availability</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">ACID — SQL Guarantee</p>
    <h3>Correctness First</h3>
    <p><b>Atomicity:</b> Transaction ทำครบหรือไม่ทำเลย (โอนเงิน: หัก A + เพิ่ม B พร้อมกัน)</p>
    <p><b>Consistency:</b> ข้อมูลอยู่ใน valid state เสมอ (ยอดบัญชีไม่ติดลบ)</p>
    <p><b>Isolation:</b> Concurrent transactions ไม่รบกวนกัน</p>
    <p><b>Durability:</b> Data ยังอยู่หลัง commit แม้ server crash</p>
    <ul>
      <li>Banking, payments, healthcare</li>
      <li>ต้องการ "ถูกต้อง 100% ณ ขณะนั้น"</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">BASE — NoSQL Guarantee</p>
    <h3>Availability First</h3>
    <p><b>Basically Available:</b> ระบบตอบสนองเสมอ แม้บาง node ล้ม</p>
    <p><b>Soft-state:</b> State อาจเปลี่ยนได้แม้ไม่มี input ใหม่ (replication in progress)</p>
    <p><b>Eventually Consistent:</b> ข้อมูลจะ consistent ในที่สุด ไม่รับประกันเวลา</p>
    <ul>
      <li>Social media, IoT, analytics</li>
      <li>ต้องการ "ตอบสนองเสมอ ถึงบาง node พัง"</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้า "ข้อมูลผิดไม่ได้" ใช้ ACID — ถ้า "ระบบต้องตอบเสมอ แม้ lag เล็กน้อย" ใช้ BASE</div>

<!-- Speaker: ตัวอย่างชัด: ธนาคารต้องการ ACID; Instagram like count ใช้ BASE ได้ เพราะ "approximately right" is OK -->

---

## CAP Theorem: เลือกได้แค่ 2 ใน 3 เสมอ

<p class="subhead">ระบบ distributed ต้องเลือก C หรือ A เมื่อเกิด network partition — P คือสิ่งหลีกเลี่ยงไม่ได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <polygon points="550,30 200,290 900,290" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <circle cx="550" cy="30" r="52" fill="var(--accent)"/>
  <text x="550" y="24" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">C</text>
  <text x="550" y="42" font-size="11" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Consistency</text>
  <text x="550" y="96" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">All nodes see same data</text>
  <circle cx="200" cy="290" r="52" fill="var(--success)"/>
  <text x="200" y="284" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">A</text>
  <text x="200" y="302" font-size="11" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Availability</text>
  <text x="200" y="238" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Always responds</text>
  <circle cx="900" cy="290" r="52" fill="var(--warning)"/>
  <text x="900" y="284" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">P</text>
  <text x="900" y="302" font-size="11" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Partition Tolerance</text>
  <text x="900" y="238" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Works despite network split</text>
  <rect x="380" y="130" width="340" height="100" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1" style="filter:drop-shadow(var(--shadow-sm))"/>
  <text x="550" y="162" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Real choice: C vs A</text>
  <text x="550" y="185" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Network partition WILL happen</text>
  <text x="550" y="205" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">P is non-negotiable in distributed systems</text>
  <text x="340" y="200" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">CP: HBase</text>
  <text x="340" y="218" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">consistent but may</text>
  <text x="340" y="234" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">be unavailable</text>
  <text x="760" y="200" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AP: Cassandra</text>
  <text x="760" y="218" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">always available but</text>
  <text x="760" y="234" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">eventually consistent</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เมื่อ network partition เกิด (และมันจะเกิด) ต้องเลือก: หยุดตอบจนข้อมูลถูก (CP) หรือตอบต่อแม้ข้อมูลอาจ lag (AP)</div>

<!-- Speaker: PostgreSQL ใน single node เป็น CA — แต่เมื่อ distributed ต้องเลือก CP หรือ AP -->

---

## Decision Framework: เลือก SQL หรือ NoSQL?

<p class="subhead">4 คำถามที่ตอบได้ว่าควรใช้ตัวไหน — ตอบก่อนเขียนโค้ดบรรทัดแรก</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">เลือก SQL เมื่อ...</p>
    <h3>Structured + Consistent</h3>
    <ul>
      <li>Data มี schema ชัดเจน ไม่เปลี่ยนบ่อย</li>
      <li>ต้องการ JOIN หลาย table</li>
      <li>Consistency สำคัญกว่า performance (finance, healthcare)</li>
      <li>ต้องการ reporting / BI tools</li>
      <li>Team คุ้นกับ relational model</li>
    </ul>
    <p style="margin-top:8px;font-weight:700;color:#3b82f6">PostgreSQL, MySQL, SQLite</p>
  </div>
  <div class="card warning">
    <p class="label">เลือก NoSQL เมื่อ...</p>
    <h3>Flexible + High-Throughput</h3>
    <ul>
      <li>Schema เปลี่ยนบ่อย หรือแต่ละ record ต่างกัน</li>
      <li>Write throughput สูงมาก (IoT, logs, events)</li>
      <li>ต้องการ scale horizontal ข้ามหลาย region</li>
      <li>Data เป็น hierarchical หรือ graph</li>
      <li>Latency ต่ำมากสำคัญที่สุด</li>
    </ul>
    <p style="margin-top:8px;font-weight:700;color:#f59e0b">MongoDB, Redis, Cassandra, Neo4j</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ถ้าไม่แน่ใจ เริ่มด้วย PostgreSQL — รองรับทั้ง SQL และ JSON, mature ที่สุด, เปลี่ยนไปได้เมื่อมี evidence ที่ชัดกว่า</div>

<!-- Speaker: PostgreSQL ยังรองรับ JSONB columns ได้ด้วย — เป็น "best of both worlds" สำหรับ early-stage projects -->

---

## Polyglot Persistence: Production Systems ใช้หลาย DB พร้อมกัน

<p class="subhead">แต่ละ service เลือก DB ที่เหมาะกับ access pattern ของตัวเอง — ไม่ใช่ใช้ตัวเดียวทั้งระบบ</p>

<div class="infographic">

| Service | Database | เหตุผล |
|---------|----------|--------|
| Users & Orders | **PostgreSQL** | ACID transactions, financial data |
| Product Catalog | **MongoDB** | Schema ยืดหยุ่น, attribute ต่างกันตาม product |
| Shopping Cart | **Redis** | Fast read/write, TTL-based expiry |
| Full-text Search | **Elasticsearch** | Inverted index, faceted filters |
| Purchase History | **Cassandra** | Append-only time-series, high write volume |
| Recommendations | **Neo4j** | Graph traversal, relationship queries |

</div>

<div class="takeaway"><b>★ Takeaway:</b> Polyglot persistence เพิ่ม operational complexity — แต่แต่ละ DB ทำงานได้ดีที่สุดในสิ่งที่ถูกออกแบบมาสำหรับ</div>

<!-- Speaker: เน้น trade-off: หลาย DB = หลาย backup policy, หลาย monitoring system, team ต้องรู้หลาย technology -->

---

## Key Takeaways: การเลือก Database ให้ถูกตั้งแต่ต้น

<p class="subhead">สิ่งที่ต้องจำจาก EP2 — ผิดตรงนี้คือ tech debt ที่แก้ได้ยากที่สุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Rule 1</p>
    <h3>Access Pattern First</h3>
    <p>เลือก DB จาก access pattern จริงของ application — ไม่ใช่จาก popularity หรือ team preference</p>
  </div>
  <div class="card danger">
    <p class="label">Rule 2</p>
    <h3>ACID vs BASE</h3>
    <p>ถ้าข้อมูลผิดไม่ได้ (finance, medical) ใช้ ACID — ถ้าต้องการ availability สูงยอม lag ชั่วคราวได้ ใช้ BASE</p>
  </div>
  <div class="card warning">
    <p class="label">Rule 3</p>
    <h3>CAP: C vs A</h3>
    <p>Network partition จะเกิดเสมอ — ต้องตัดสินใจล่วงหน้าว่าจะยอม unavailable หรือ inconsistent</p>
  </div>
  <div class="card success">
    <p class="label">Rule 4</p>
    <h3>Polyglot OK</h3>
    <p>ใช้หลาย DB พร้อมกันได้ — แต่ต้องรับ operational complexity ที่เพิ่มขึ้นตามมาด้วย</p>
  </div>
  <div class="card gold">
    <p class="label">Rule 5</p>
    <h3>Start with PostgreSQL</h3>
    <p>ถ้าไม่แน่ใจ PostgreSQL คือ safe default — ทั้ง relational และ JSON, mature ecosystem</p>
  </div>
  <div class="card">
    <p class="label">Rule 6</p>
    <h3>Migration is Expensive</h3>
    <p>เปลี่ยน DB หลังมี data เป็นหนึ่งในงานที่ costly ที่สุด — ตัดสินใจให้ดีตั้งแต่ต้น</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ไม่มี database ที่ดีที่สุด — มีแค่ database ที่เหมาะกับ problem ที่ต้องแก้</div>

<!-- Speaker: EP3 ต่อไป: Load Balancing deep dive — algorithms, HA patterns, zero-downtime deployment -->
