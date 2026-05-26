---
title: "System Design EP3: Load Balancing & Horizontal Scaling ให้ระบบไม่ล่ม"
date: 2026-05-26 00:05:00 +0700
categories: [Engineering]
tags: [system-design, load-balancing, horizontal-scaling, high-availability, nginx, kubernetes]
series: system-design-fundamentals
slides: false
---

{% include series-nav.html %}

## TL;DR

Load balancing คือ gateway สู่ horizontal scaling — กระจาย traffic ข้ามหลาย server เพื่อความสามารถรองรับ load สูง, fault tolerance และ zero-downtime deployment EP นี้ครอบคลุม algorithms, patterns และ pitfalls ที่ต้องรู้

## Background / Why this matters

ลองนึกภาพร้านอาหารที่มีแคชเชียร์คนเดียว เมื่อลูกค้าเพิ่มขึ้น คิวยาวขึ้น ทางออกคือเปิดช่องแคชเชียร์เพิ่ม — แต่ต้องมีคนยืนที่ประตูเพื่อบอกลูกค้าว่าให้ไปช่องไหน นั่นคือ load balancer

ในระบบซอฟต์แวร์ load balancer ทำหน้าที่เดียวกัน: รับ request จาก client และตัดสินใจว่า backend server ตัวไหนจะ handle request นั้น การตัดสินใจนี้กระทบโดยตรงต่อ performance, reliability และ cost ของระบบทั้งหมด

## Deep Dive

### ทำไม Load Balancing ถึงสำคัญ

```
ไม่มี Load Balancer:
User → [Server เดียว] → ถ้า server ตาย = ระบบล่มทั้งหมด

มี Load Balancer:
User → [Load Balancer] → Server 1 (healthy)
                       → Server 2 (healthy)
                       → ~~Server 3~~ (down, LB ตัดออกอัตโนมัติ)
```

Load balancing แก้ปัญหาหลัก 3 ข้อ:
1. **High Availability:** ถ้า server 1 ตาย, traffic ไป server 2 อัตโนมัติ
2. **Scalability:** เพิ่ม server ใหม่ได้โดยไม่ต้อง modify client
3. **Performance:** กระจาย load ให้ไม่มี server ใด overloaded

---

### Load Balancing Algorithms

#### Round Robin
ส่ง request ทีละ server เวียนไปเรื่อย ๆ

```
Request 1 → Server A
Request 2 → Server B
Request 3 → Server C
Request 4 → Server A (วนใหม่)
```

**เหมาะกับ:** Server ทุกตัวมี spec เท่ากัน, stateless requests  
**ข้อเสีย:** ไม่คำนึงถึง current load ของแต่ละ server

#### Least Connections
ส่งไปยัง server ที่มี active connections น้อยที่สุด

```
Server A: 100 active connections
Server B: 20 active connections  ← เลือกตัวนี้
Server C: 85 active connections
```

**เหมาะกับ:** Long-lived connections เช่น WebSocket, file uploads  
**ข้อเสีย:** ต้องติดตาม connection count ตลอดเวลา

#### Weighted Round Robin
กำหนด weight ตาม capacity — server แรงกว่าได้ traffic มากกว่า

```
Server A (weight 3): ได้รับ 3/6 ของ traffic
Server B (weight 2): ได้รับ 2/6 ของ traffic
Server C (weight 1): ได้รับ 1/6 ของ traffic
```

**เหมาะกับ:** Server fleet ที่มี spec ต่างกัน หรือเมื่อต้อง canary deploy

#### IP Hash (Sticky Sessions)
Hash จาก client IP เพื่อส่ง request จาก client เดิมไปยัง server เดิมเสมอ

```
Client 192.168.1.1 → hash → Server A (เสมอ)
Client 192.168.1.2 → hash → Server C (เสมอ)
```

**เหมาะกับ:** Stateful applications ที่ยังไม่ได้ migrate ไป stateless  
**ข้อเสีย:** ถ้า server ล้ม, session data หาย; ทำให้ scaling ซับซ้อน

#### Least Response Time
ส่งไปยัง server ที่ response time เฉลี่ยต่ำที่สุดในช่วงเวลาที่ผ่านมา

**เหมาะกับ:** Heterogeneous workloads ที่ request time ต่างกันมาก  
**ข้อเสีย:** Overhead ในการ monitor response times

---

### Layer 4 vs Layer 7 Load Balancing

| | Layer 4 (Transport) | Layer 7 (Application) |
|-|---------------------|----------------------|
| ทำงานที่ | TCP/UDP level | HTTP/HTTPS level |
| รู้จัก | IP, Port | URL, Headers, Cookies |
| Routing ตาม | IP + Port | Path, Host, Content-Type |
| Performance | เร็วกว่า (no inspection) | ช้ากว่าเล็กน้อย |
| SSL Termination | ไม่ทำ | ทำได้ (offload จาก backend) |
| ตัวอย่าง | AWS NLB, HAProxy TCP mode | Nginx, AWS ALB, Traefik |

**กรณีใช้งาน Layer 7:**
```
example.com/api/* → API servers
example.com/static/* → CDN / Static servers
example.com/websocket → WebSocket servers
```

Layer 7 LB สามารถ route ตาม URL path ได้ ทำให้เหมาะกับ microservices architecture

---

### Health Checks

Load balancer ต้องรู้ว่า server ไหน healthy ก่อนส่ง traffic ไป

**Passive health check:** ตรวจจาก response — ถ้า server ตอบ error 5xx บ่อยเกินกำหนด → mark as unhealthy

**Active health check:** LB ส่ง ping/HTTP request ไปเช็ค server เป็น interval สม่ำเสมอ

```
GET /health → 200 OK → healthy ✓
GET /health → 503     → unhealthy ✗ → remove from pool
```

**Best practice:** ทำ `/health` endpoint ที่เช็ค dependencies จริง (DB connection, cache) ไม่ใช่แค่ "server ยังรันอยู่"

---

### Session Persistence (Sticky Sessions) — Trade-offs

บางครั้ง application ต้องการให้ request จาก user เดิมไปยัง server เดิม (เช่น legacy app ที่เก็บ session ใน memory)

```
ปัญหา:
User → Server A (session อยู่ที่นี่)
→ Load Balancer ส่งไป Server B (ไม่รู้จัก session → logout)
```

**ทางออก:**
1. **Sticky sessions (cookie-based):** LB เพิ่ม cookie บอกว่า user นี้ bind กับ server ไหน → แก้ปัญหาได้ชั่วคราว แต่ทำ scaling ยากขึ้น
2. **Shared session store (แนะนำ):** ย้าย session ไป Redis — server ใดก็อ่านได้ (ดูรายละเอียดใน EP1)

---

### High Availability: Load Balancer ไม่ควรเป็น SPOF

Load balancer เองอาจเป็น single point of failure ได้ ถ้ามีแค่ตัวเดียว

**Active-Passive HA:**
```
VIP (Virtual IP) → Primary LB (active)
                 → Secondary LB (standby)
ถ้า Primary ล้ม: Secondary รับ VIP ทันที (failover ~1-30s)
```

**Active-Active HA:**
```
DNS Round Robin → LB1
               → LB2 (ทำงานพร้อมกัน, share load ด้วย)
```

Cloud providers (AWS ALB, GCP Load Balancing) จัดการ HA ให้อัตโนมัติ

---

### Horizontal Scaling: เพิ่ม Server ได้อย่างไร

เมื่อมี load balancer แล้ว การเพิ่ม server ใหม่เข้า pool ทำได้ง่าย:

1. Launch new server instance (EC2, Kubernetes Pod, VM)
2. Register กับ load balancer (auto-scaling group ทำอัตโนมัติ)
3. Health check ผ่าน → LB เริ่มส่ง traffic

**Auto-scaling rules ตัวอย่าง:**
```
CPU > 70% for 5 minutes → เพิ่ม 2 servers
CPU < 30% for 10 minutes → ลด 1 server
```

**Zero-downtime deployment ด้วย Rolling Update:**
```
เริ่มต้น: Server A (v1), Server B (v1), Server C (v1)
Step 1: Deploy Server A → v2; Health check ผ่าน
Step 2: Deploy Server B → v2; Health check ผ่าน
Step 3: Deploy Server C → v2; Health check ผ่าน
ผล: ไม่มี downtime แม้แต่วินาทีเดียว
```

---

### Tools และ Implementation

| Tool | ประเภท | เหมาะกับ |
|------|--------|---------|
| **Nginx** | Software LB (Layer 7) | Web servers, reverse proxy |
| **HAProxy** | Software LB (L4+L7) | High-performance, TCP |
| **AWS ALB** | Managed (Layer 7) | AWS ecosystem, microservices |
| **AWS NLB** | Managed (Layer 4) | Ultra-low latency, TCP |
| **Traefik** | Cloud-native (Layer 7) | Kubernetes, Docker |
| **Envoy** | Proxy/Service mesh | Microservices, Istio |

**Nginx config ตัวอย่าง:**
```nginx
upstream backend {
    least_conn;
    server 10.0.0.1:8080;
    server 10.0.0.2:8080;
    server 10.0.0.3:8080;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
    }
}
```

## Caveats / Limits

- **Sticky sessions ทำ auto-scaling ยาก:** เมื่อลด server, user ที่ sticky อยู่จะ lose session — migrate ไป stateless ก่อนที่จะ scale จริงจัง
- **Load balancer overhead:** Layer 7 LB มี latency overhead จาก HTTP inspection — ไม่มากแต่ต้องรู้
- **Backend server ต้องรองรับ keep-alive:** ถ้าปิด keep-alive, LB ต้องสร้าง TCP connection ใหม่ทุก request
- **SSL termination ที่ LB:** backend traffic เป็น HTTP (ไม่ encrypt) — ต้องใช้ internal network ที่ trusted หรือ re-encrypt
- **Thundering herd:** ถ้า server ใหม่เข้า pool ทันที, อาจถูก flood ด้วย request ก่อน warm-up — ใช้ slow-start หรือ warmup period

## References

1. [ByteByteGo - Scale from Zero to Millions of Users](https://bytebytego.com/courses/system-design-interview/scale-from-zero-to-millions-of-users)
2. [System Design Concepts — AlgoMaster](https://blog.algomaster.io/p/30-system-design-concepts)
3. [11 System Design Concepts Explained — SystemDesign.one](https://newsletter.systemdesign.one/p/11-system-design-concepts-explained)
4. [System Design Primer — Load Balancer](https://github.com/donnemartin/system-design-primer/blob/master/README.md)

## Key Takeaways

- Load balancer = traffic router + health monitor + SPOF eliminator
- เลือก algorithm ตาม workload: Round Robin สำหรับ uniform requests, Least Connections สำหรับ long-lived connections
- Layer 7 LB รู้จัก URL/Headers ทำให้ route ตาม service ได้ — เหมาะกับ microservices
- Sticky sessions เป็น anti-pattern สำหรับ horizontal scaling — migrate session ไป shared store แทน
- Load balancer ต้องมี HA เอง ไม่เช่นนั้นกลายเป็น SPOF ตัวใหม่
- Health check endpoint ที่ดีต้องเช็ค dependencies จริง ไม่ใช่แค่ "process alive"
- Zero-downtime deployment ทำได้ง่ายมากเมื่อมี LB + stateless servers
