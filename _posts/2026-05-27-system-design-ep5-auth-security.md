---
title: "System Design EP5: Authentication, Authorization และ Security ที่วิศวกรต้องรู้"
date: 2026-05-26 00:07:00 +0700
categories: [Engineering]
tags: [system-design, authentication, authorization, jwt, oauth2, security, https]
series: system-design-fundamentals
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

Authentication (ตรวจตัวตน) และ Authorization (ตรวจสิทธิ์) เป็น foundation ของความปลอดภัยของระบบ EP นี้ครอบคลุม Session-based, JWT, OAuth2 และ security best practices ที่ต้องนำไปใช้ตั้งแต่วันแรก

## Background / Why this matters

ข้อมูล breach จากงานวิจัยของ IBM (2023) ระบุว่าค่าเฉลี่ยของ data breach อยู่ที่ 4.45 ล้านดอลลาร์ต่อเหตุการณ์ — และสาเหตุอันดับหนึ่งคือ compromised credentials

Authentication และ Authorization ที่ออกแบบผิดไม่ได้แค่ทำให้ระบบ "ไม่ปลอดภัย" แต่อาจนำไปสู่การสูญเสียข้อมูลของผู้ใช้ ค่าปรับจาก regulatory bodies (GDPR, PDPA) และความเสียหายต่อ reputation ที่แก้ไม่ได้ภายในคืนเดียว

## Deep Dive

### Authentication vs Authorization — ความต่างที่ต้องแยกให้ออก

```
Authentication: "คุณคือใคร?"
→ ตรวจ identity (username + password, biometric, certificate)

Authorization: "คุณทำอะไรได้บ้าง?"
→ ตรวจ permissions หลังจาก authenticate แล้ว
```

**ตัวอย่าง:**
- User login ด้วย email + password = **Authentication**
- User ที่ login แล้วพยายามเข้า `/admin` แต่ไม่มีสิทธิ์ = **Authorization failed** (403 Forbidden ไม่ใช่ 401 Unauthorized)

---

### Session-Based Authentication

วิธีดั้งเดิมที่ server เก็บ session state

```
1. User ส่ง credentials
2. Server verify → สร้าง session ID → เก็บใน DB/Memory
3. ส่ง session ID กลับผ่าน cookie
4. ทุก request ส่ง cookie มาด้วย → Server lookup session
```

**ข้อดี:**
- Session revoke ได้ทันที (logout = ลบ session จาก DB)
- ง่ายต่อการ implement สำหรับ monolithic app
- เหมาะกับ web app ที่มี server-side rendering

**ข้อเสีย:**
- Server ต้องเก็บ session state — ทำให้ horizontal scaling ซับซ้อน
- ต้องมี centralized session store (Redis) สำหรับ multi-server setup
- CSRF attacks เป็น concern หลักสำหรับ cookie-based auth

---

### JWT (JSON Web Token)

JWT เป็น stateless token ที่เข้ารหัสข้อมูลไว้ในตัวเอง

**โครงสร้าง:**
```
eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiIxMjMifQ.HMAC_SIGNATURE
|_____Header______|  |_______Payload_______|  |__Signature__|
```

- **Header:** algorithm ที่ใช้ sign (HS256, RS256)
- **Payload:** claims (userId, roles, expiry)
- **Signature:** ยืนยันว่า token ไม่ถูกแก้ไข

**ตัวอย่าง Payload:**
```json
{
  "sub": "user_123",
  "roles": ["user", "editor"],
  "exp": 1735689600,
  "iat": 1735603200
}
```

**Flow:**
```
1. User login → Server verify → ส่งคืน JWT
2. Client เก็บ JWT (localStorage หรือ httpOnly cookie)
3. ทุก request: Authorization: Bearer <JWT>
4. Server verify signature → อ่าน claims → ไม่ต้อง query DB
```

**ข้อดี JWT:**
- Stateless — server ไม่ต้องเก็บ session → scale ง่ายมาก
- Self-contained — token มีข้อมูลทุกอย่างที่ต้องการ
- เหมาะกับ microservices — ทุก service verify token ได้เอง

**ข้อเสีย JWT:**
- **Revocation ยาก:** JWT valid จนหมดอายุ — ถ้า token leak ต้องรอให้หมดอายุเอง (หรือใช้ token blacklist ซึ่งทำให้ไม่ stateless แล้ว)
- **Payload readable:** ใครก็ decode base64 ได้ — อย่าเก็บ sensitive data ใน payload
- **Token ขนาดใหญ่:** ทุก HTTP request ส่ง token ไปด้วย

**Best practices:**
- ตั้ง expiry สั้น (15-60 นาที) + ใช้ refresh token pattern
- เก็บใน httpOnly cookie ไม่ใช่ localStorage (ป้องกัน XSS)
- ใช้ RS256 (asymmetric) สำหรับ production ไม่ใช่ HS256

---

### OAuth2 — Authorization Framework

OAuth2 ไม่ใช่ authentication protocol — เป็น **authorization framework** ที่อนุญาตให้ third-party app เข้าถึง resource แทน user โดยไม่ต้องแชร์ password

**Use case หลัก:**
```
"Login with Google" / "Login with GitHub"
→ User ให้ Google ยืนยัน identity แทน
→ App ได้รับ access token สำหรับ resource ที่ user อนุญาต
```

**4 Grant Types หลัก:**

| Grant Type | เหมาะกับ | Flow |
|-----------|---------|------|
| Authorization Code + PKCE | Web apps, Mobile apps | User → Auth Server → code → tokens |
| Client Credentials | Machine-to-machine | Client ID/Secret → tokens (ไม่มี user) |
| Device Code | TV, IoT | Device แสดง code → User approve ด้วย phone |
| ~~Implicit~~ (deprecated) | SPA (เก่า) | ไม่แนะนำแล้ว — ใช้ Auth Code + PKCE แทน |

**Authorization Code + PKCE Flow (แนะนำสำหรับ web/mobile):**
```
1. App สร้าง code_verifier และ code_challenge (SHA256)
2. Redirect user ไป Auth Server พร้อม code_challenge
3. User login + consent ที่ Auth Server
4. Auth Server redirect กลับมาพร้อม authorization_code
5. App ส่ง code + code_verifier ขอ tokens
6. Auth Server verify → คืน access_token + refresh_token
```

**OpenID Connect (OIDC):**
Extension ของ OAuth2 ที่เพิ่ม **identity layer** — ให้ ID Token (JWT) พร้อม user info เช่น name, email  
→ OAuth2 = Authorization; OIDC = Authentication บน OAuth2

---

### Role-Based Access Control (RBAC)

RBAC กำหนดสิทธิ์ผ่าน roles แทนที่จะกำหนดให้ user โดยตรง

```
Users → Roles → Permissions

User: Alice
Roles: [editor, billing-viewer]
Permissions: 
  editor → create_post, edit_post, delete_own_post
  billing-viewer → view_invoices
```

**ตัวอย่าง middleware (Node.js):**
```javascript
function requireRole(role) {
  return (req, res, next) => {
    if (!req.user.roles.includes(role)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}

router.delete('/posts/:id', authenticate, requireRole('editor'), deletePost);
```

**ABAC (Attribute-Based Access Control):**
ซับซ้อนกว่า RBAC — ตรวจสิทธิ์จาก attributes หลายตัวพร้อมกัน (user department, resource owner, time of day)  
เหมาะกับระบบที่มี fine-grained access control ซับซ้อน เช่น healthcare หรือ banking

---

### Security Best Practices

#### HTTPS Everywhere
```
HTTP (plain text) → ❌ Man-in-the-middle attack ได้
HTTPS (TLS 1.3)   → ✓ Encrypted, authenticated
```
TLS 1.3 ลด handshake จาก 2 round-trips เหลือ 1 (0-RTT resumption)  
ใช้ Let's Encrypt (free) หรือ managed certs บน cloud providers

#### Password Hashing
```python
# ❌ NEVER store plain text or MD5/SHA1
password_hash = md5(password)

# ✓ ใช้ bcrypt, Argon2, scrypt
password_hash = bcrypt.hashpw(password, bcrypt.gensalt(rounds=12))
```
**Argon2id** เป็น winner ของ Password Hashing Competition (2015) — แนะนำสำหรับ new projects

#### Rate Limiting & Brute Force Protection
```
Login endpoint: max 5 failed attempts per 15 minutes per IP
→ 6th attempt → 429 Too Many Requests + lockout
→ Account lockout หลังจาก 10 failed attempts

API endpoints: 1000 requests/hour per API key
```

#### Input Validation & SQL Injection Prevention
```python
# ❌ SQL Injection vulnerability
query = f"SELECT * FROM users WHERE email = '{user_input}'"

# ✓ Parameterized query
cursor.execute("SELECT * FROM users WHERE email = %s", (user_input,))
```

#### CORS (Cross-Origin Resource Sharing)
```javascript
// ❌ อย่า allow wildcard ใน production
Access-Control-Allow-Origin: *

// ✓ Whitelist origins ที่รู้จัก
Access-Control-Allow-Origin: https://app.example.com
```

#### Security Headers
```
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Content-Security-Policy: default-src 'self'
```

---

### Common Vulnerabilities (OWASP Top 10 ที่เกี่ยวข้อง)

| ช่องโหว่ | อธิบาย | วิธีป้องกัน |
|---------|--------|-----------|
| **Broken Authentication** | Session fixation, weak tokens | Strong session IDs, MFA, JWT best practices |
| **Broken Access Control** | User เข้า resource ของ user อื่น | Server-side authorization, ไม่ trust client-side checks |
| **Injection** | SQL, NoSQL, Command injection | Parameterized queries, input validation |
| **XSS** | Inject malicious scripts | Content Security Policy, escape output |
| **CSRF** | Force user ทำ action โดยไม่รู้ตัว | CSRF tokens, SameSite cookie, Origin header check |
| **Sensitive Data Exposure** | ส่งข้อมูลสำคัญ unencrypted | HTTPS, encrypt at rest, mask sensitive logs |

---

### Token Storage Security

| Storage | XSS Attack | CSRF Attack | แนะนำ |
|---------|-----------|------------|-------|
| localStorage | ✗ vulnerable | ✓ safe | ❌ ไม่แนะนำ |
| sessionStorage | ✗ vulnerable | ✓ safe | ❌ ไม่แนะนำ |
| httpOnly Cookie | ✓ safe | ✗ vulnerable | ✓ พร้อม CSRF protection |
| Memory (RAM) | ✓ safe | ✓ safe | ✓ แต่หาย refresh |

**สรุป:** เก็บ JWT ใน httpOnly, Secure, SameSite=Strict cookie + CSRF token สำหรับ state-changing operations

---

### Multi-Factor Authentication (MFA)

MFA เพิ่ม factor ที่ 2 หลังจาก password:

| Factor Type | ตัวอย่าง |
|------------|---------|
| Something you know | Password, PIN |
| Something you have | TOTP (Google Authenticator), Hardware key (YubiKey) |
| Something you are | Fingerprint, Face ID |

TOTP (Time-based One-Time Password) ตาม RFC 6238:
```
secret_key → HMAC(secret, floor(time/30)) → 6-digit code (valid 30s)
```

## Caveats / Limits

- **JWT ไม่ควรใช้เก็บ sensitive data ใน payload:** base64 ไม่ใช่ encryption — ใครก็ decode ได้
- **OAuth2 ≠ Authentication:** OAuth2 เป็น authorization — ถ้าต้องการ authentication ใช้ OIDC หรือ passport.js ที่ implement ถูกต้อง
- **Refresh token rotation:** เมื่อใช้ refresh token แล้วต้อง invalidate ตัวเก่าทันที ป้องกัน token reuse attack
- **bcrypt rounds และ performance:** rounds=12 ใช้เวลา ~250ms — acceptable สำหรับ login แต่ไม่ควรใช้ใน hot path
- **HTTPS ไม่ได้ป้องกันทุกอย่าง:** ป้องกัน transit แต่ไม่ได้ป้องกัน server-side vulnerabilities หรือ phishing

## References

1. [Understanding Authentication & Authorization — DEV Community](https://dev.to/arcadebuilds/understanding-authentication-authorization-jwt-oauth20-session-concepts-390i)
2. [Session vs JWT vs OAuth2: Complete Authentication Strategy — HackerNoon](https://hackernoon.com/session-vs-jwt-vs-oauth2-the-complete-authentication-strategy)
3. [OAuth vs JWT: Difference & Using Together — Frontegg](https://frontegg.com/blog/oauth-vs-jwt)
4. [OWASP Top 10](https://owasp.org/www-project-top-ten/)
5. [System Design Primer — Security](https://github.com/donnemartin/system-design-primer/blob/master/README.md)
6. [IBM Cost of Data Breach Report 2023](https://www.ibm.com/reports/data-breach)

## Key Takeaways

- Authentication = ตรวจตัวตน (Who are you?); Authorization = ตรวจสิทธิ์ (What can you do?) — สองอย่างต้องแยกออกจากกัน
- Session-based เหมาะกับ monolith; JWT เหมาะกับ microservices ที่ต้องการ stateless scaling
- JWT revocation ยาก — ตั้ง expiry สั้น + refresh token pattern แก้ได้
- OAuth2 เป็น authorization framework ไม่ใช่ authentication — ใช้ OIDC เมื่อต้องการ identity
- เก็บ token ใน httpOnly cookie ไม่ใช่ localStorage เพื่อป้องกัน XSS
- HTTPS ทุก endpoint, bcrypt/Argon2 สำหรับ password, parameterized queries — non-negotiable
- MFA ลด risk ได้มากกว่า 99% แม้ password ถูก compromise
