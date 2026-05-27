---
marp: true
theme: default
paginate: true
title: "Networking เบื้องต้น: MAC Address ถึง Load Balancer"
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
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Networking เบื้องต้น

<p class="tag">จาก MAC Address ถึง Load Balancer — 11 concepts สำหรับ Engineer ทุกคน</p>

<!-- Speaker: Cover how data travels from device to internet through 11 core networking concepts. -->

---

## Data Travels Through 4 Layers — Each Solves One Problem

<p class="subhead">ทำความเข้าใจ architecture ก่อน — แต่ละ Layer แก้ปัญหาเดียว แต่ทำงานร่วมกันทำให้ Internet ทำงานได้</p>

<div class="infographic">
<svg viewBox="0 0 1060 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="a1" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--muted)" stroke-width="1.2" fill="none"/></marker></defs>
  <rect x="20" y="30" width="210" height="90" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="125" y="62" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">LAN Layer</text>
  <text x="125" y="82" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">MAC + Switch</text>
  <text x="125" y="106" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Within one network</text>
  <line x1="230" y1="75" x2="270" y2="75" stroke="var(--muted)" stroke-width="2" marker-end="url(#a1)"/>
  <rect x="270" y="30" width="210" height="90" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="375" y="62" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Network Layer</text>
  <text x="375" y="82" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">IP + Router</text>
  <text x="375" y="106" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Across networks</text>
  <line x1="480" y1="75" x2="520" y2="75" stroke="var(--muted)" stroke-width="2" marker-end="url(#a1)"/>
  <rect x="520" y="30" width="210" height="90" rx="12" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="2"/>
  <text x="625" y="62" font-size="15" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Transport Layer</text>
  <text x="625" y="82" font-size="12" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">TCP/UDP + Ports</text>
  <text x="625" y="106" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Reliable delivery</text>
  <line x1="730" y1="75" x2="770" y2="75" stroke="var(--muted)" stroke-width="2" marker-end="url(#a1)"/>
  <rect x="770" y="30" width="270" height="90" rx="12" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="905" y="55" font-size="15" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Application Layer</text>
  <text x="905" y="75" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">TLS / VPN / DNS</text>
  <text x="905" y="92" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Load Balancer</text>
  <text x="905" y="109" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Security + Scale</text>
  <line x1="20" y1="155" x2="1040" y2="155" stroke="var(--soft-2)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <rect x="30" y="172" width="190" height="26" rx="8" fill="var(--accent)" opacity=".12"/>
  <text x="125" y="190" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Ethernet, Wi-Fi, ARP</text>
  <rect x="280" y="172" width="190" height="26" rx="8" fill="var(--success)" opacity=".12"/>
  <text x="375" y="190" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">IPv4, IPv6, OSPF, BGP</text>
  <rect x="530" y="172" width="190" height="26" rx="8" fill="var(--warning)" opacity=".12"/>
  <text x="625" y="190" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">TCP, UDP, Port 443</text>
  <rect x="780" y="172" width="250" height="26" rx="8" fill="var(--danger)" opacity=".12"/>
  <text x="905" y="190" font-size="11" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">HTTP, TLS 1.3, DNS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> แต่ละ Layer ซ่อน complexity จาก Layer ข้างบน — LAN Layer ไม่รู้จัก TLS; Application Layer ไม่รู้จัก MAC Address</div>

<!-- Speaker: This 4-layer model maps to the TCP/IP stack. Each layer has one job. Together they route data from Bangkok to New York in milliseconds. -->

---

## MAC Stays in LAN; IP Routes Globally

<p class="subhead">MAC = hardware ID ใช้ได้แค่ใน LAN — IP = logical ID ข้ามเครือข่ายได้ — Switch อ่าน MAC; Router อ่าน IP</p>

<div class="infographic">
<svg viewBox="0 0 1060 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="a2" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--accent)" stroke-width="1.2" fill="none"/></marker><marker id="a2g" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--success)" stroke-width="1.2" fill="none"/></marker></defs>
  <!-- LAN dashed boundary -->
  <rect x="10" y="40" width="660" height="160" rx="14" fill="none" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="8,4" opacity=".5"/>
  <text x="340" y="32" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">LAN — MAC routing works here</text>
  <!-- Device A -->
  <rect x="30" y="70" width="150" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="105" y="107" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Device A</text>
  <text x="105" y="127" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MAC: AA:BB:CC:11:22</text>
  <text x="105" y="145" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">IP: 192.168.1.10</text>
  <!-- Switch -->
  <rect x="270" y="80" width="130" height="80" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="2"/>
  <text x="335" y="115" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Switch</text>
  <text x="335" y="135" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">reads MAC</text>
  <line x1="180" y1="120" x2="270" y2="120" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <!-- Device B -->
  <rect x="490" y="70" width="150" height="100" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="565" y="107" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Device B</text>
  <text x="565" y="127" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">MAC: DD:EE:FF:44:55</text>
  <text x="565" y="145" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">IP: 192.168.1.20</text>
  <line x1="400" y1="120" x2="490" y2="120" stroke="var(--accent)" stroke-width="2" marker-end="url(#a2)"/>
  <!-- Router -->
  <rect x="720" y="80" width="130" height="80" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="785" y="115" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Router</text>
  <text x="785" y="135" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">reads IP</text>
  <line x1="670" y1="120" x2="720" y2="120" stroke="var(--success)" stroke-width="2" marker-end="url(#a2g)"/>
  <!-- Internet -->
  <circle cx="970" cy="120" r="55" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="970" y="114" font-size="13" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Internet</text>
  <text x="970" y="132" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IP routing</text>
  <line x1="850" y1="120" x2="915" y2="120" stroke="var(--success)" stroke-width="2" marker-end="url(#a2g)"/>
  <!-- MAC stops note -->
  <line x1="695" y1="175" x2="695" y2="215" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <text x="695" y="232" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">MAC stripped here</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Router ลบ MAC header ออกทุกครั้งที่ forward packet — MAC ไม่มีวันออกไปนอก LAN เด็ดขาด</div>

<!-- Speaker: Switch uses MAC table (CAM table) for L2 forwarding. Router uses routing table for L3 forwarding. MAC lives only within one broadcast domain. -->

---

## IPv4 vs IPv6, Static vs DHCP — Know All Four

<p class="subhead">IP Address มี 2 versions และ 2 วิธีกำหนด — รู้จักทุกแบบเพื่อ configure และ debug ได้ถูกจุด</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card">
    <p class="label">IPv4</p>
    <h3>32-bit</h3>
    <p><code>192.168.1.100</code></p>
    <p>~4.3B addresses — ใช้ NAT ช่วยรองรับอุปกรณ์จำนวนมาก</p>
  </div>
  <div class="card success">
    <p class="label">IPv6 — Future</p>
    <h3>128-bit</h3>
    <p><code>2001:db8::1</code></p>
    <p>340 undecillion addresses — รองรับ IoT ได้โดยไม่ต้อง NAT</p>
  </div>
  <div class="card warning">
    <p class="label">Private IP (RFC 1918)</p>
    <h3>LAN Only</h3>
    <p><code>10.x.x.x</code><br><code>192.168.x.x</code></p>
    <p>ไม่ route บน Internet — ต้องผ่าน NAT เพื่อออกข้างนอก</p>
  </div>
  <div class="card gold">
    <p class="label">DHCP — Auto-assign</p>
    <h3>Dynamic IP</h3>
    <p>อุปกรณ์ขอ IP อัตโนมัติเมื่อ connect</p>
    <p>Subnet <code>/24</code> = 254 hosts ใน network</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Private IP + NAT คือสิ่งที่คุณเจอทุกวัน — IPv6 คือทิศทางอนาคต เริ่ม adopt ได้เลยโดยเฉพาะ cloud infra</div>

<!-- Speaker: Your home router has one public IP but assigns private IPs to all devices via DHCP. NAT translates between them. -->

---

## Router Picks the Best Path — 3 Protocols for 3 Scales

<p class="subhead">Router ไม่แค่ส่งข้อมูล — เลือก "เส้นทางที่ดีที่สุด" ด้วย Protocol ที่เหมาะกับขนาดเครือข่าย</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Static Route</p>
    <h3>Manual Config</h3>
    <p>Admin กำหนด Route เองทุกเส้น — ไม่ปรับตัวอัตโนมัติเมื่อ link ล้มเหลว</p>
    <p>ใช้กับ: small networks, simple edge routers</p>
  </div>
  <div class="card success">
    <p class="label">OSPF — Interior Gateway</p>
    <h3>Dynamic / Link-State</h3>
    <p>Router แชร์ topology map กัน คำนวณ shortest path ด้วย Dijkstra algorithm</p>
    <p>ใช้กับ: เครือข่ายภายในองค์กร (Intra-AS)</p>
  </div>
  <div class="card gold">
    <p class="label">BGP — Internet Backbone</p>
    <h3>Dynamic / Path-Vector</h3>
    <p>แลกเปลี่ยน Routes ระหว่าง Autonomous Systems (AS) — ISP, Cloud Provider, CDN</p>
    <p>ใช้กับ: ทุก hop บน public Internet</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> BGP คือ "Glue of the Internet" — packet เดินทางกรุงเทพ → New York ผ่าน BGP routing หลายสิบ AS</div>

<!-- Speaker: BGP outages have taken down large portions of the internet. Facebook's 2021 outage was caused by a BGP misconfiguration that withdrew all their routes. -->

---

## TCP Guarantees Delivery; UDP Prioritizes Speed

<p class="subhead">เลือก Protocol ให้ตรง use case — ผิดอาจทำให้ latency พุ่งหรือข้อมูลสูญหาย</p>

<div class="infographic">
<svg viewBox="0 0 1060 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="at" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--accent)" stroke-width="1.2" fill="none"/></marker>
    <marker id="au" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--success)" stroke-width="1.2" fill="none"/></marker>
  </defs>
  <!-- TCP panel -->
  <rect x="20" y="15" width="490" height="275" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="20" y="15" width="490" height="44" rx="12" fill="var(--accent)" opacity=".1"/>
  <text x="265" y="43" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">TCP — Reliable</text>
  <text x="100" y="85" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Client</text>
  <text x="430" y="85" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Server</text>
  <line x1="100" y1="95" x2="100" y2="265" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="430" y1="95" x2="430" y2="265" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="100" y1="120" x2="430" y2="138" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#at)"/>
  <text x="265" y="116" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SYN</text>
  <line x1="430" y1="158" x2="100" y2="175" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#at)"/>
  <text x="265" y="154" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SYN-ACK</text>
  <line x1="100" y1="192" x2="430" y2="207" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#at)"/>
  <text x="265" y="188" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">ACK</text>
  <text x="265" y="238" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Connected — data transfer</text>
  <text x="265" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HTTPS, SSH, Email, File Transfer</text>
  <!-- UDP panel -->
  <rect x="550" y="15" width="490" height="275" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2"/>
  <rect x="550" y="15" width="490" height="44" rx="12" fill="var(--success)" opacity=".1"/>
  <text x="795" y="43" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">UDP — Fast</text>
  <text x="625" y="85" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Sender</text>
  <text x="975" y="85" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Receiver</text>
  <line x1="625" y1="95" x2="625" y2="265" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="975" y1="95" x2="975" y2="265" stroke="var(--muted)" stroke-width="1.5"/>
  <line x1="625" y1="118" x2="975" y2="130" stroke="var(--success)" stroke-width="1.5" marker-end="url(#au)"/>
  <text x="800" y="113" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DATA 1</text>
  <line x1="625" y1="148" x2="975" y2="160" stroke="var(--success)" stroke-width="1.5" marker-end="url(#au)"/>
  <text x="800" y="143" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DATA 2</text>
  <line x1="625" y1="178" x2="880" y2="188" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <text x="755" y="172" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui">DATA 3 (lost — ignored)</text>
  <line x1="625" y1="208" x2="975" y2="220" stroke="var(--success)" stroke-width="1.5" marker-end="url(#au)"/>
  <text x="800" y="203" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">DATA 4</text>
  <text x="795" y="258" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Video Call, Gaming, DNS, Streaming</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> TCP ส่ง 3 packets (handshake) ก่อนข้อมูลจริง — UDP ยิงแล้วลืม เร็วกว่าแต่ยอมรับ packet loss ได้</div>

<!-- Speaker: A dropped frame in video call is barely noticeable. A dropped bank transaction is catastrophic. Protocol choice reflects acceptable failure modes. -->

---

## Ports Tell the OS Which App Gets Each Packet

<p class="subhead">IP บอกว่า "เครื่องไหน" — Port บอกว่า "แอปฯ ไหนในเครื่องนั้น" — OS routes ด้วย destination port</p>

<div class="infographic">
<svg viewBox="0 0 1060 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="ap" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--muted)" stroke-width="1.2" fill="none"/></marker></defs>
  <!-- Server -->
  <rect x="600" y="25" width="420" height="255" rx="14" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <text x="810" y="55" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Server 10.0.0.1</text>
  <rect x="630" y="70" width="80" height="34" rx="8" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="670" y="92" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">:443</text>
  <text x="740" y="92" font-size="12" fill="var(--ink-dim)" font-family="system-ui">HTTPS / nginx</text>
  <rect x="630" y="115" width="80" height="34" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="670" y="137" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">:22</text>
  <text x="740" y="137" font-size="12" fill="var(--ink-dim)" font-family="system-ui">SSH / sshd</text>
  <rect x="630" y="160" width="80" height="34" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="670" y="182" font-size="12" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">:3306</text>
  <text x="740" y="182" font-size="12" fill="var(--ink-dim)" font-family="system-ui">MySQL</text>
  <rect x="630" y="205" width="80" height="34" rx="8" fill="var(--soft-2)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="670" y="227" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">:53</text>
  <text x="740" y="227" font-size="12" fill="var(--ink-dim)" font-family="system-ui">DNS / named</text>
  <!-- Clients -->
  <rect x="40" y="70" width="170" height="34" rx="8" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="125" y="92" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browser (HTTPS)</text>
  <line x1="210" y1="87" x2="600" y2="87" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3" marker-end="url(#ap)"/>
  <rect x="40" y="115" width="170" height="34" rx="8" fill="var(--paper)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="125" y="137" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ssh client</text>
  <line x1="210" y1="132" x2="600" y2="132" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="6,3" marker-end="url(#ap)"/>
  <rect x="40" y="160" width="170" height="34" rx="8" fill="var(--paper)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="125" y="182" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">App (DB connector)</text>
  <line x1="210" y1="177" x2="600" y2="177" stroke="var(--warning)" stroke-width="1.5" stroke-dasharray="6,3" marker-end="url(#ap)"/>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Block port 22 จาก public internet บน Firewall เป็น security baseline — เปิดเฉพาะ IP whitelist หรือใช้ SSH over VPN</div>

<!-- Speaker: Ports 0-1023 are well-known (require root). 1024-49151 are registered. 49152-65535 are ephemeral (used by clients for outbound connections). -->

---

## Firewall Has 3 Levels — Pick the Right One

<p class="subhead">Firewall ไม่ใช่แค่ "block/allow" — มี 3 ระดับความสามารถ แต่ละระดับมี trade-off ที่ต้องเข้าใจ</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Layer 3-4</p>
    <h3>Packet Filter</h3>
    <p>ตรวจสอบ IP, Port, Protocol ของแต่ละ Packet แบบ stateless</p>
    <p>เร็วมาก แต่ไม่รู้ connection state — ถูก bypass ด้วย fragmented packets ได้</p>
    <ul>
      <li>iptables, nftables</li>
      <li>AWS Security Groups</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Layer 3-4 — Stateful</p>
    <h3>Stateful Firewall</h3>
    <p>จำสถานะ Connection table — รู้ว่า reply packet ถูกต้องหรือไม่ ป้องกัน spoofing</p>
    <p>ปลอดภัยกว่า — recommended baseline สำหรับทุก infrastructure</p>
    <ul>
      <li>AWS Network Firewall</li>
      <li>Modern hardware FW</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Layer 7 — Application</p>
    <h3>WAF</h3>
    <p>อ่าน HTTP/HTTPS content — detect SQL injection, XSS, bot traffic ตาม OWASP rules</p>
    <p>เพิ่ม latency แต่ป้องกันได้ลึกสุด — จำเป็นสำหรับ public web apps</p>
    <ul>
      <li>AWS WAF, Cloudflare WAF</li>
      <li>ModSecurity (NGINX)</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Stateful Firewall เป็น baseline ทุก environment — เพิ่ม WAF เมื่อ expose web app สู่ internet เพื่อ OWASP Top 10</div>

<!-- Speaker: Defense in depth: use all three layers together. Security Groups (stateful) + WAF for web-facing apps + VPC Network Firewall for east-west traffic. -->

---

## TLS Encrypts Every HTTPS Connection in 5 Steps

<p class="subhead">TLS Handshake เกิดขึ้นก่อนส่งข้อมูลทุกครั้ง — เข้าใจ flow นี้แก้ bug HTTPS ได้ทันที</p>

<div class="infographic">
<svg viewBox="0 0 1060 285" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="atls" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--accent)" stroke-width="1.2" fill="none"/></marker>
    <marker id="atlsr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--success)" stroke-width="1.2" fill="none"/></marker>
  </defs>
  <text x="120" y="30" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Client</text>
  <line x1="120" y1="42" x2="120" y2="245" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="940" y="30" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Server</text>
  <line x1="940" y1="42" x2="940" y2="245" stroke="var(--muted)" stroke-width="1.5"/>
  <!-- Step 1 -->
  <line x1="120" y1="65" x2="940" y2="78" stroke="var(--accent)" stroke-width="2" marker-end="url(#atls)"/>
  <rect x="330" y="50" width="400" height="24" rx="6" fill="var(--accent-wash)"/>
  <text x="530" y="67" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Client Hello — TLS version + cipher suites</text>
  <!-- Step 2 -->
  <line x1="940" y1="106" x2="120" y2="118" stroke="var(--success)" stroke-width="2" marker-end="url(#atlsr)"/>
  <rect x="300" y="91" width="460" height="24" rx="6" fill="var(--success-wash)"/>
  <text x="530" y="108" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">2. Server Hello + Certificate (Public Key)</text>
  <!-- Step 3 (client side) -->
  <rect x="20" y="132" width="200" height="26" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="120" y="150" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">3. Verify cert via CA</text>
  <!-- Step 4 -->
  <line x1="120" y1="178" x2="940" y2="190" stroke="var(--accent)" stroke-width="2" marker-end="url(#atls)"/>
  <rect x="310" y="163" width="440" height="24" rx="6" fill="var(--accent-wash)"/>
  <text x="530" y="180" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">4. Key Exchange — derive shared Session Key</text>
  <!-- Step 5 -->
  <rect x="180" y="218" width="700" height="38" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="530" y="242" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">5. Encrypted Channel Ready — HTTPS data flows</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Certificate หมดอายุ → HTTPS พังทั้งหมด — ตั้ง Auto-renew (Let's Encrypt / AWS ACM) เป็น must-have สำหรับทุก production service</div>

<!-- Speaker: Session key (symmetric) is fast for bulk data. It's derived from asymmetric key exchange (secure but slower). TLS 1.3 reduced the handshake from 2 round-trips to 1. -->

---

## VPN Tunnels All Traffic Through an Encrypted Channel

<p class="subhead">VPN ไม่ใช่แค่ "เปลี่ยน IP" — เข้ารหัส traffic ทั้งหมดก่อนออกจากเครื่อง ป้องกัน ISP และ Public WiFi</p>

<div class="infographic">
<svg viewBox="0 0 1060 270" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="av" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--muted)" stroke-width="1.2" fill="none"/></marker><marker id="avr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--danger)" stroke-width="1.2" fill="none"/></marker></defs>
  <!-- Without VPN -->
  <text x="530" y="26" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">Without VPN — traffic readable by ISP</text>
  <rect x="20" y="38" width="110" height="50" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="75" y="68" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Device</text>
  <line x1="130" y1="63" x2="230" y2="63" stroke="var(--danger)" stroke-width="2" marker-end="url(#avr)"/>
  <rect x="230" y="38" width="120" height="50" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="290" y="60" font-size="12" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">ISP</text>
  <text x="290" y="78" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">reads plaintext</text>
  <line x1="350" y1="63" x2="470" y2="63" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#av)"/>
  <rect x="470" y="38" width="120" height="50" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="530" y="68" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Internet</text>
  <line x1="590" y1="63" x2="710" y2="63" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#av)"/>
  <rect x="710" y="38" width="120" height="50" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="770" y="68" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Server</text>
  <!-- Divider -->
  <line x1="20" y1="110" x2="1040" y2="110" stroke="var(--soft-2)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <!-- With VPN -->
  <text x="530" y="132" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">With VPN — ISP sees only encrypted bytes</text>
  <rect x="20" y="143" width="110" height="50" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="75" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Device</text>
  <!-- Tunnel -->
  <rect x="150" y="138" width="680" height="60" rx="12" fill="var(--accent)" opacity=".06" stroke="var(--accent)" stroke-width="2" stroke-dasharray="8,4"/>
  <text x="490" y="156" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Encrypted VPN Tunnel</text>
  <line x1="130" y1="168" x2="150" y2="168" stroke="var(--accent)" stroke-width="2" marker-end="url(#av)"/>
  <rect x="370" y="145" width="120" height="46" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="430" y="173" font-size="12" fill="var(--accent)" text-anchor="middle" font-family="system-ui">VPN Server</text>
  <line x1="830" y1="168" x2="910" y2="168" stroke="var(--accent)" stroke-width="2" marker-end="url(#av)"/>
  <rect x="910" y="143" width="120" height="50" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="970" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Server</text>
  <!-- ISP blocked -->
  <rect x="230" y="215" width="130" height="38" rx="8" fill="var(--soft)"/>
  <text x="295" y="236" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ISP sees only</text>
  <text x="295" y="250" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">encrypted bytes</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> VPN ไม่ใช่ "anonymous" — VPN Provider ยังเห็น traffic อยู่ เลือก Provider ที่ no-log policy ได้รับการ audit แล้ว</div>

<!-- Speaker: WireGuard is the modern VPN protocol — faster and simpler than OpenVPN. For corporate use, consider Zero Trust (per-app access) over traditional VPN. -->

---

## DNS Resolves domain.com → IP in 6 Steps

<p class="subhead">ทุก request บน Internet เริ่มต้นด้วย DNS Lookup — เข้าใจ flow แก้ปัญหา "site ขึ้นบ้างบางเครื่อง" ได้</p>

<div class="infographic">
<svg viewBox="0 0 1060 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ad" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--accent)" stroke-width="1.2" fill="none"/></marker>
    <marker id="adr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6" stroke="var(--success)" stroke-width="1.2" fill="none"/></marker>
  </defs>
  <!-- Browser -->
  <rect x="10" y="100" width="120" height="60" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="70" y="134" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Browser</text>
  <!-- Resolver -->
  <rect x="190" y="100" width="140" height="60" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="2"/>
  <text x="260" y="127" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Resolver</text>
  <text x="260" y="147" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">8.8.8.8 / ISP</text>
  <line x1="130" y1="127" x2="190" y2="127" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#ad)"/>
  <text x="160" y="120" font-size="10" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. query</text>
  <!-- Root NS -->
  <rect x="410" y="20" width="140" height="60" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="480" y="46" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Root NS</text>
  <text x="480" y="64" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">13 root servers</text>
  <line x1="330" y1="115" x2="410" y2="60" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="5,3" marker-end="url(#ad)"/>
  <text x="360" y="78" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">2. ask root</text>
  <!-- TLD NS -->
  <rect x="670" y="20" width="150" height="60" rx="10" fill="var(--soft)" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="745" y="46" font-size="12" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">TLD NS</text>
  <text x="745" y="64" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">.com nameserver</text>
  <line x1="550" y1="50" x2="670" y2="50" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#ad)"/>
  <text x="610" y="43" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">3. ref TLD</text>
  <!-- Auth NS -->
  <rect x="670" y="185" width="150" height="60" rx="10" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="745" y="211" font-size="12" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Auth NS</text>
  <text x="745" y="229" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">ns1.google.com</text>
  <line x1="745" y1="80" x2="745" y2="185" stroke="var(--accent)" stroke-width="1.5" marker-end="url(#ad)"/>
  <text x="772" y="136" font-size="10" fill="var(--ink-dim)" font-family="system-ui">4. ref auth</text>
  <!-- IP returned -->
  <line x1="670" y1="215" x2="330" y2="148" stroke="var(--success)" stroke-width="2" marker-end="url(#adr)"/>
  <text x="500" y="198" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">5. IP: 142.250.66.46</text>
  <!-- Back to browser -->
  <line x1="190" y1="148" x2="130" y2="148" stroke="var(--success)" stroke-width="2" marker-end="url(#adr)"/>
  <text x="160" y="166" font-size="10" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">6. cached + return</text>
  <!-- TTL note -->
  <rect x="155" y="215" width="200" height="32" rx="8" fill="var(--warning-wash)" stroke="var(--warning)" stroke-width="1.5"/>
  <text x="255" y="236" font-size="11" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Cached per TTL (Time To Live)</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> "Site ขึ้นบ้างบางเครื่อง" = DNS cache ยังไม่ expire — ลด TTL ก่อน DNS change เพื่อ propagate เร็ว</div>

<!-- Speaker: Full DNS resolution only happens on cache miss. Most lookups hit cache at the resolver level. Low TTL = faster changes, higher DNS query volume. -->

---

## Load Balancer Spreads Traffic Across Server Pools

<p class="subhead">Load Balancer ป้องกัน Single Point of Failure และทำให้ Scale ออกตาม Traffic ได้อย่าง seamless</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">4 Algorithms</p>
    <h3>How to Route Requests</h3>
    <ul>
      <li><b>Round Robin</b> — วนเวียนทุก server เท่ากัน: stateless services</li>
      <li><b>Least Connections</b> — ส่งไปเครื่องที่ว่างสุด: long-lived connections</li>
      <li><b>IP Hash</b> — client เดิม → server เดิมเสมอ: session apps</li>
      <li><b>Weighted</b> — server แรงกว่าได้งานมากกว่า: mixed capacity pools</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">L4 vs L7 — Pick by Need</p>
    <h3>Which Layer to Balance</h3>
    <p><b>L4 (TCP/UDP)</b> — ดู IP + Port เท่านั้น ultra-low latency ไม่รู้ HTTP content</p>
    <p><b>L7 (HTTP/HTTPS)</b> — อ่าน URL, Header, Cookie route ได้ฉลาดกว่า</p>
    <p>L7 example: <code>/api/*</code> → backend pool, <code>/static/*</code> → CDN origin</p>
    <p>AWS: ALB = L7 / NLB = L4 — Health check built-in ทั้งคู่</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ใช้ ALB (L7) สำหรับ web apps — เปลี่ยนเป็น NLB (L4) เมื่อต้องการ ultra-low latency หรือ non-HTTP protocol</div>

<!-- Speaker: Health checks are the load balancer's superpower — when a server fails, LB stops routing to it automatically. This is foundational to high availability. -->

---

## 7 Concepts That Run the Internet

<p class="subhead">สรุปสิ่งที่คุณเรียนรู้ — Networking ไม่ใช่ Black Box อีกต่อไป Debug ได้ทุก Layer</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card compact">
    <p class="label">Identity</p>
    <h3>MAC + IP</h3>
    <p>MAC = LAN only (Layer 2). IP = global routing (Layer 3). คนละ scope ใช้ร่วมกันเสมอ</p>
  </div>
  <div class="card compact success">
    <p class="label">Forwarding</p>
    <h3>Switch + Router</h3>
    <p>Switch ส่งด้วย MAC ใน LAN. Router ส่งด้วย IP ข้ามเครือข่าย. MAC ไม่ผ่าน Router</p>
  </div>
  <div class="card compact warning">
    <p class="label">Transport</p>
    <h3>TCP + UDP</h3>
    <p>TCP = แม่นยำ (HTTPS/file). UDP = เร็ว (video/gaming). เลือกตาม failure tolerance</p>
  </div>
  <div class="card compact">
    <p class="label">Access Control</p>
    <h3>Port + Firewall</h3>
    <p>Port ระบุ application. Firewall ควบคุม traffic ด้วย IP/Port/content 3 ระดับ</p>
  </div>
  <div class="card compact gold">
    <p class="label">Security</p>
    <h3>TLS + VPN</h3>
    <p>TLS เข้ารหัส connection (HTTPS). VPN สร้าง encrypted tunnel ทั้ง session</p>
  </div>
  <div class="card compact success">
    <p class="label">Scale + Discovery</p>
    <h3>DNS + Load Balancer</h3>
    <p>DNS แปลง domain → IP (cache via TTL). LB กระจาย traffic ป้องกัน overload</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> ทุก Production bug ด้าน Networking เริ่มจากไม่เข้าใจ Layer ใดสักอัน — เข้าใจครบแล้ว Debug ได้ทุกชั้น</div>

<!-- Speaker: These 7 concepts build on each other. Master them and you can debug any networking issue in production — from packet loss to TLS cert failures to DNS propagation delays. -->
