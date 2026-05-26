---
marp: true
theme: default
paginate: true
title: "System Design EP5: Authentication, Authorization และ Security"
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

# System Design EP5
# Authentication, Authorization และ Security

<p class="tag">Session · JWT · OAuth2 · RBAC · OWASP Top 10 · MFA</p>

<!-- Speaker: EP5 สุดท้ายของ series — security ไม่ใช่ feature ที่เพิ่มทีหลัง มันคือ foundation ที่ต้องออกแบบตั้งแต่วันแรก -->

---

## Authentication vs Authorization: สองอย่างที่ต้องแยกให้ออก

<p class="subhead">ออกแบบผิดคือช่องโหว่ที่แก้ไม่ได้ภายในคืนเดียว — IBM 2023: ค่าเฉลี่ย data breach = $4.45M</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Authentication — ตรวจตัวตน</p>
    <h3>"คุณคือใคร?"</h3>
    <p>ตรวจ identity ว่าคุณเป็นใครก่อน — ด้วย password, biometric, certificate</p>
    <ul>
      <li>User login ด้วย email + password</li>
      <li>API key ยืนยัน service identity</li>
      <li>JWT ยืนยันว่า token ออกโดย server จริง</li>
      <li>ผล: รู้แล้วว่า "คุณคือ Alice"</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Authorization — ตรวจสิทธิ์</p>
    <h3>"คุณทำอะไรได้บ้าง?"</h3>
    <p>หลัง authenticate แล้ว ตรวจว่า Alice มีสิทธิ์ทำสิ่งนี้หรือเปล่า</p>
    <ul>
      <li>Alice เข้า /admin แต่ role คือ "user" = 403 Forbidden</li>
      <li>Bob เข้าไฟล์ของ Alice = 403 Forbidden</li>
      <li>401 = ไม่รู้ว่าคุณคือใคร (not authenticated)</li>
      <li>403 = รู้แล้วแต่ไม่ให้เข้า (not authorized)</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Authentication = Who are you? Authorization = What can you do? — สองอย่างนี้ต้องออกแบบแยกกันเสมอ</div>

<!-- Speaker: ข้อผิดพลาดที่พบบ่อย: ใช้ 401 แทน 403 หรือ check authorization ที่ client-side แทนที่จะ server-side -->

---

## Session vs JWT: Stateful vs Stateless Auth

<p class="subhead">Session เหมาะกับ monolith; JWT เหมาะกับ microservices ที่ต้องการ stateless scaling</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Session-Based — Stateful</p>
    <h3>Server เก็บ State</h3>
    <p>Server สร้าง session ID และเก็บไว้ใน DB/memory; client ส่ง cookie ทุก request</p>
    <ul>
      <li>Revoke ได้ทันที (ลบ session = logout ทุก device)</li>
      <li>ง่ายสำหรับ monolithic web app</li>
      <li>ข้อเสีย: ต้องมี shared session store สำหรับ multi-server</li>
      <li>ข้อเสีย: CSRF attacks เป็น concern หลัก</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">JWT — Stateless</p>
    <h3>Token มีทุกอย่างในตัว</h3>
    <p>Header.Payload.Signature — server verify signature โดยไม่ต้อง query DB</p>
    <ul>
      <li>Stateless: scale ง่าย ทุก server verify ได้เอง</li>
      <li>เหมาะกับ microservices และ mobile apps</li>
      <li>ข้อเสีย: revoke ยาก — valid จนหมดอายุ</li>
      <li>แก้: expiry สั้น (15-60 นาที) + refresh token</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> JWT revocation ยาก — ตั้ง expiry สั้น + refresh token pattern; เก็บใน httpOnly cookie ไม่ใช่ localStorage (ป้องกัน XSS)</div>

<!-- Speaker: อย่าเก็บ sensitive data ใน JWT payload — base64 ไม่ใช่ encryption ใครก็ decode ได้; signature แค่ยืนยันว่าไม่ถูกแก้ -->

---

## OAuth2: Authorization Framework สำหรับ Third-Party

<p class="subhead">OAuth2 ไม่ใช่ authentication protocol — เป็น framework ที่ให้ app อื่นเข้าถึง resource แทน user</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="130" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="95" y="56" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Your App</text>
  <text x="95" y="74" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Client</text>
  <rect x="30" y="200" width="130" height="60" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="95" y="226" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User</text>
  <text x="95" y="244" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Resource Owner</text>
  <rect x="380" y="100" width="160" height="90" rx="8" fill="var(--accent)" opacity=".85"/>
  <text x="460" y="135" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Auth Server</text>
  <text x="460" y="153" font-size="10" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Google / GitHub</text>
  <text x="460" y="171" font-size="10" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">issues tokens</text>
  <rect x="750" y="100" width="160" height="90" rx="8" fill="var(--success)" opacity=".8"/>
  <text x="830" y="135" font-size="12" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Resource Server</text>
  <text x="830" y="153" font-size="10" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">Protected API</text>
  <text x="830" y="171" font-size="10" fill="rgba(255,255,255,.9)" text-anchor="middle" font-family="system-ui">validates token</text>
  <rect x="990" y="100" width="80" height="90" rx="8" fill="var(--warning)" opacity=".8"/>
  <text x="1030" y="145" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Protected</text>
  <text x="1030" y="163" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Resource</text>
  <text x="200" y="20" font-size="10" fill="var(--ink-dim)" font-family="system-ui">1. Request authorization</text>
  <line x1="160" y1="50" x2="380" y2="130" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="200" y="100" font-size="10" fill="var(--ink-dim)" font-family="system-ui">2. Login + Consent</text>
  <line x1="160" y1="220" x2="380" y2="160" stroke="var(--muted)" stroke-width="1.5"/>
  <text x="550" y="80" font-size="10" fill="var(--ink-dim)" font-family="system-ui">3. auth_code</text>
  <line x1="540" y1="100" x2="160" y2="60" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="4,2"/>
  <text x="550" y="230" font-size="10" fill="var(--ink-dim)" font-family="system-ui">4. code + verifier = access_token</text>
  <line x1="540" y1="160" x2="160" y2="200" stroke="var(--success)" stroke-width="1.5" stroke-dasharray="4,2"/>
  <text x="680" y="80" font-size="10" fill="var(--ink-dim)" font-family="system-ui">5. API call with Bearer token</text>
  <line x1="620" y1="145" x2="750" y2="145" stroke="var(--warning-ink)" stroke-width="1.5"/>
  <line x1="910" y1="145" x2="990" y2="145" stroke="var(--warning-ink)" stroke-width="1.5"/>
  <rect x="30" y="270" width="1040" height="18" rx="4" fill="var(--soft)"/>
  <text x="550" y="283" font-size="10" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">OIDC = OAuth2 + Identity Layer (ID Token พร้อม user info: name, email) — ใช้เมื่อต้องการ authentication บน OAuth2</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> OAuth2 คือ authorization ไม่ใช่ authentication — ถ้าต้องการ identity ใช้ OIDC (OpenID Connect) ที่เพิ่ม ID Token เหนือ OAuth2</div>

<!-- Speaker: Authorization Code + PKCE คือ flow ที่แนะนำสำหรับ web/mobile ปี 2024 — Implicit flow deprecated แล้ว -->

---

## Security Best Practices: Non-Negotiable

<p class="subhead">ความปลอดภัยพื้นฐานที่ต้องทำทุก project — ไม่ทำ = ช่องโหว่ที่รอถูก exploit</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Password Security</p>
    <h3>ห้ามเก็บ Plain Text</h3>
    <p>ใช้ bcrypt (rounds=12) หรือ Argon2id สำหรับ production</p>
    <ul>
      <li>MD5/SHA1 ไม่ปลอดภัย — crack ได้ใน seconds</li>
      <li>Argon2id: winner Password Hashing Competition 2015</li>
      <li>bcrypt rounds=12 ใช้เวลา ~250ms — acceptable สำหรับ login</li>
    </ul>
  </div>
  <div class="card success">
    <p class="label">Transport Security</p>
    <h3>HTTPS ทุก Endpoint</h3>
    <p>TLS 1.3: handshake 1 round-trip (ลดจาก TLS 1.2 ที่ใช้ 2 round-trips)</p>
    <ul>
      <li>Let's Encrypt: free, auto-renew</li>
      <li>HSTS header: บังคับ HTTPS แม้ user พิมพ์ http://</li>
      <li>HTTPS ป้องกัน transit แต่ไม่ป้องกัน server-side bugs</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Input Validation</p>
    <h3>Parameterized Queries</h3>
    <p>ห้าม string concatenation กับ user input — ใช้ prepared statements เสมอ</p>
    <ul>
      <li>SQL Injection: ช่องโหว่อันดับ 1 ใน OWASP Top 10</li>
      <li>XSS: escape output ทุก field ที่ render HTML</li>
      <li>CORS: whitelist origins จริง ไม่ใช่ wildcard (*)</li>
    </ul>
  </div>
  <div class="card gold">
    <p class="label">Rate Limiting</p>
    <h3>Brute Force Protection</h3>
    <p>Login endpoint: max 5 failed attempts / 15 min / IP</p>
    <ul>
      <li>Account lockout หลัง 10 failed attempts</li>
      <li>API: 1000 req/hour per API key</li>
      <li>MFA ลด risk ได้มากกว่า 99% แม้ password leak</li>
    </ul>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> HTTPS, Argon2/bcrypt, parameterized queries คือ minimum baseline — ไม่ใช่ optional extra</div>

<!-- Speaker: Security headers เพิ่มอีกชั้น: Content-Security-Policy, X-Frame-Options: DENY, X-Content-Type-Options: nosniff -->

---

## Token Storage: เก็บ JWT ไว้ที่ไหนให้ปลอดภัย?

<p class="subhead">ที่เก็บ token ต่างกัน = attack surface ต่างกัน — เลือกให้เหมาะกับ threat model</p>

<div class="infographic">

| Storage | XSS Attack | CSRF Attack | แนะนำ | เหตุผล |
|---------|-----------|------------|-------|--------|
| **localStorage** | ช่องโหว่ | ปลอดภัย | ❌ ไม่แนะนำ | JavaScript อ่านได้ — XSS ขโมยได้ทันที |
| **sessionStorage** | ช่องโหว่ | ปลอดภัย | ❌ ไม่แนะนำ | เหมือน localStorage แต่หมดเมื่อปิด tab |
| **httpOnly Cookie** | ปลอดภัย | ช่องโหว่ | ✓ ใช้ได้ | JavaScript อ่านไม่ได้; ต้องเพิ่ม CSRF token |
| **Memory (RAM)** | ปลอดภัย | ปลอดภัย | ✓ ดีที่สุด | หายเมื่อ refresh — ต้องมี refresh token |

</div>

<div class="takeaway"><b>★ Takeaway:</b> เก็บ JWT ใน httpOnly, Secure, SameSite=Strict cookie + CSRF token สำหรับ state-changing operations — localStorage เป็น XSS target ชั้นดี</div>

<!-- Speaker: Memory storage ดีที่สุดด้านความปลอดภัย แต่ UX แย่ (ต้อง login ใหม่ทุกครั้ง refresh) — tradeoff ที่ต้องเลือกตาม sensitivity ของ app -->

---

## RBAC + OWASP Top 10 ที่เกี่ยวข้อง

<p class="subhead">RBAC จัดการสิทธิ์ผ่าน role ไม่ใช่ user โดยตรง — ง่ายกว่า แก้ไขได้เร็วกว่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Role-Based Access Control</p>
    <h3>Users → Roles → Permissions</h3>
    <p>กำหนดสิทธิ์ผ่าน roles แทนที่จะกำหนดให้ user โดยตรง</p>
    <ul>
      <li>Alice: [editor, billing-viewer] — manage posts + view invoices</li>
      <li>Bob: [viewer] — read only</li>
      <li>เปลี่ยนสิทธิ์ทั้ง group: แก้ role ครั้งเดียว</li>
      <li>Server-side check เสมอ — อย่า trust client-side</li>
    </ul>
  </div>
  <div class="card danger">
    <p class="label">OWASP Top 10 ที่เกี่ยวข้อง</p>
    <h3>ช่องโหว่ที่พบบ่อยที่สุด</h3>
    <p><b>Broken Authentication:</b> weak tokens, session fixation</p>
    <p><b>Broken Access Control:</b> user เข้า resource ของ user อื่น</p>
    <p><b>Injection:</b> SQL, NoSQL, Command injection</p>
    <p><b>XSS:</b> inject scripts ผ่าน user input</p>
    <p><b>CSRF:</b> force user ทำ action โดยไม่รู้ตัว</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Authorization check ต้องทำที่ server เสมอ — client-side RBAC เป็นแค่ UX ไม่ใช่ security; attacker ข้าม client-side check ได้ทันที</div>

<!-- Speaker: Broken Access Control คืออันดับ 1 ใน OWASP Top 10 2021 — มักเกิดจาก trust client-sent user ID หรือ role โดยไม่ verify กับ server -->

---

## Key Takeaways: Security ตั้งแต่วันแรก

<p class="subhead">สิ่งที่ต้องจำจาก EP5 — security ไม่ใช่ layer เพิ่มทีหลัง มันต้องอยู่ใน design ตั้งแต่ต้น</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Rule 1</p>
    <h3>AuthN vs AuthZ</h3>
    <p>Authentication = Who; Authorization = What — แยกออกจากกัน 401 vs 403 ต้องถูกต้อง</p>
  </div>
  <div class="card warning">
    <p class="label">Rule 2</p>
    <h3>Session vs JWT</h3>
    <p>Session เหมาะ monolith; JWT เหมาะ microservices — JWT expiry สั้น + refresh token</p>
  </div>
  <div class="card gold">
    <p class="label">Rule 3</p>
    <h3>OAuth2 คือ Authorization</h3>
    <p>OAuth2 ไม่ใช่ authentication — ใช้ OIDC เมื่อต้องการ identity ด้วย</p>
  </div>
  <div class="card danger">
    <p class="label">Rule 4</p>
    <h3>Token ใน httpOnly Cookie</h3>
    <p>localStorage = XSS target; httpOnly cookie ปลอดภัยกว่า; Memory ดีที่สุดแต่ UX แย่กว่า</p>
  </div>
  <div class="card success">
    <p class="label">Rule 5</p>
    <h3>Baseline Non-Negotiable</h3>
    <p>HTTPS ทุก endpoint + Argon2/bcrypt สำหรับ passwords + parameterized queries เสมอ</p>
  </div>
  <div class="card">
    <p class="label">Rule 6</p>
    <h3>MFA ลด Risk 99%</h3>
    <p>MFA เพิ่ม factor ที่ 2 — แม้ password leak ก็ยังต้องมี TOTP/YubiKey</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Security breach ค่าเฉลี่ย $4.45M ต่อครั้ง — HTTPS + Argon2 + parameterized queries + httpOnly cookie คือ minimum ที่ทุก production system ต้องมี</div>

<!-- Speaker: จบ series EP5 — ทั้ง 5 EP ครอบคลุม foundation ของ system design: Scale, DB, LB, API, Security; ขั้นต่อไปคือ practice กับ real system design problems -->
