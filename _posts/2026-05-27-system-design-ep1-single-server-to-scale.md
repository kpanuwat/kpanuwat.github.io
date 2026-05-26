---
title: "System Design EP1: จาก Single Server สู่ระบบที่รองรับล้าน User"
date: 2026-05-26 00:03:00 +0700
categories: [Engineering]
tags: [system-design, scalability, architecture, load-balancing, caching, cdn]
series: system-design-fundamentals
slides: false
---

{% include series-nav.html %}

## TL;DR

ระบบทุกอย่างเริ่มจาก single server — แต่เมื่อผู้ใช้เพิ่มขึ้น สถาปัตยกรรมต้องวิวัฒน์ด้วย EP นี้จะพาไล่เส้นทางตั้งแต่ server เครื่องเดียวไปจนถึง multi-tier distributed system ที่รองรับผู้ใช้หลายล้านคนพร้อมกัน

## Background / Why this matters

สิ่งที่ทำให้ system design สำคัญ คือมันไม่มีคำตอบที่ถูกหรือผิดแบบ absolute — มีแค่ trade-off ที่เหมาะสมกับ context นั้น ๆ

หากเราออกแบบระบบ blog ส่วนตัวที่มีผู้เข้าชม 100 คน/วัน กับ e-commerce platform ที่ต้องรองรับ 1 ล้าน concurrent users ในช่วง flash sale สถาปัตยกรรมที่ดีจะต่างกันโดยสิ้นเชิง

การเข้าใจว่าระบบ "เติบโต" อย่างไรจะช่วยให้วิศวกรตัดสินใจได้ว่าควรลงทุนกับ scalability ตั้งแต่วันแรก หรือรอจนมี traffic จริงก่อนค่อย scale

## Deep Dive

### ขั้นที่ 1: Single Server

ทุกอย่างอยู่ในเครื่องเดียว — web server, application, database

```
User → DNS → IP → [Web + App + DB] (single server)
```

**ข้อดี:** ง่าย, ถูก, deploy เร็ว  
**ข้อเสีย:** single point of failure, ไม่สามารถ scale ส่วนใดส่วนหนึ่งได้อิสระ

เหมาะกับ: MVP, prototype, internal tools ที่ใช้งานน้อย

---

### ขั้นที่ 2: แยก Web Tier และ Data Tier

แยก database ออกมาเป็น dedicated server เพื่อให้ scale ได้อิสระ

```
User → Load Balancer → [Web Server 1]  ─┐
                    → [Web Server 2]  ─┤→ [Database Server]
                    → [Web Server N]  ─┘
```

การแยก tier ช่วยให้:
- Web tier scale horizontal ได้ (เพิ่ม server ได้เรื่อย ๆ)
- Database tier scale vertical ได้ (เพิ่ม RAM/CPU)
- Failure ใน tier หนึ่งไม่ knock out ทุกอย่าง

---

### ขั้นที่ 3: Vertical vs Horizontal Scaling

| ลักษณะ | Vertical Scaling (Scale Up) | Horizontal Scaling (Scale Out) |
|--------|---------------------------|-------------------------------|
| วิธี | เพิ่ม CPU/RAM ใน server เดิม | เพิ่มจำนวน server |
| ขีดจำกัด | มี hardware ceiling | แทบไม่มีขีดจำกัด |
| ค่าใช้จ่าย | แพงเมื่อถึง high-end | คาดเดาได้ง่ายกว่า |
| Fault tolerance | Single point of failure | Redundant โดยธรรมชาติ |
| Complexity | ต่ำ | ต้องมี load balancer, stateless design |

**หลักการ:** Vertical scaling เป็นทางออกระยะสั้นที่ง่าย, Horizontal scaling คือ long-term strategy สำหรับระบบที่ต้อง scale ใหญ่

---

### ขั้นที่ 4: Load Balancer

Load balancer รับ traffic จาก internet แล้วกระจายไปยัง web servers ผ่าน private IP

```
Internet → Load Balancer (public IP) → Web Server 1 (private IP)
                                     → Web Server 2 (private IP)
```

**ประโยชน์:**
- ป้องกัน single point of failure — ถ้า web server 1 ตาย, traffic ถูก redirect ไป server 2 อัตโนมัติ
- ซ่อน internal IP จาก internet ช่วยด้านความปลอดภัย
- รองรับการเพิ่ม/ลด server แบบ dynamic ตาม load

**Algorithms ยอดนิยม:**
- **Round Robin** — ส่งทีละคน, simple, เหมาะเมื่อ server มี spec เท่ากัน
- **Least Connections** — ส่งให้ server ที่มี active connection น้อยที่สุด
- **Weighted Round Robin** — กำหนด weight ตาม capacity ของแต่ละ server

---

### ขั้นที่ 5: Database Replication

โดยทั่วไปใช้ **Master-Slave** (Primary-Replica) pattern:

- **Master (Primary):** รับ write operations เท่านั้น
- **Slave (Replica):** รับ read operations, sync ข้อมูลจาก master

```
App → [Master DB] ← sync → [Slave DB 1]
                  ← sync → [Slave DB 2]
App reads → [Slave DB 1 or 2]
```

**ทำไมถึงสำคัญ:** application ส่วนใหญ่มี read:write ratio ประมาณ 80:20 ถึง 95:5 — การ offload reads ไป slaves ช่วยลด load บน master ได้มาก

---

### ขั้นที่ 6: Caching Layer

Cache เก็บผลลัพธ์ที่ compute แล้ว (หรือ query แล้ว) ไว้ใน memory เพื่อตอบ request ครั้งหน้าเร็วขึ้น

**Read-through cache pattern:**
```
App → Check cache → HIT: return cached data (fast)
                 → MISS: query DB → store in cache → return data
```

**ตัวอย่าง:** Redis, Memcached

**Trade-offs ที่ต้องระวัง:**
- **Expiration policy:** cache นานเกินไป → stale data; สั้นเกินไป → cache ไม่ช่วยอะไร
- **Consistency:** เมื่อ DB update, cache invalidation ต้องระวัง
- **Cold start:** server ใหม่ไม่มี cache → spike ไปที่ DB ชั่วคราว

---

### ขั้นที่ 7: CDN (Content Delivery Network)

CDN กระจาย static assets (images, CSS, JS, videos) ไปยัง edge servers ทั่วโลก ทำให้ user ดึง content จาก server ที่ใกล้ที่สุด

```
User (Bangkok) → CDN Edge (Singapore) → fast!
User (New York) → CDN Edge (Virginia) → fast!
ทั้งคู่ไม่ต้องไปถึง Origin Server
```

**เมื่อไหร่ควรใช้ CDN:**
- มี static content ที่ serve ซ้ำ ๆ
- User อยู่หลาย region
- ต้องการลด latency สำหรับ media-heavy apps

**ข้อควรระวัง:** CDN คิดค่าบริการตาม data transfer — content ที่เปลี่ยนบ่อยหรือ access น้อยไม่คุ้มค่าที่จะ cache ใน CDN

---

### ขั้นที่ 8: Stateless Web Tier

เมื่อ scale horizontal, web servers หลายตัวต้องสามารถ handle request ได้โดยไม่ขึ้นกับว่า user เคย hit server ไหน — หมายความว่า session state ต้องไม่เก็บใน memory ของ web server

**Stateful (ปัญหา):**
```
User session อยู่ใน Server 1
→ Load balancer ส่ง request ไป Server 2
→ Server 2 ไม่มี session → User ต้อง login ใหม่ ❌
```

**Stateless (แก้ปัญหา):**
```
Session เก็บใน Redis / shared DB
→ Server ใดก็ได้รับ session จาก shared store ✅
```

---

### ภาพรวม: Evolution ของ Architecture

```
Single Server
    ↓
Web + DB แยก tier
    ↓
Add Load Balancer + multiple Web Servers
    ↓
Add DB Replication (Master + Slaves)
    ↓
Add Cache Layer (Redis)
    ↓
Add CDN for static assets
    ↓
Stateless Web Tier + Shared Session Store
    ↓
(EP ถัด ๆ ไป: Database scaling, API design, Auth, Security)
```

## Caveats / Limits

- **ไม่มี silver bullet:** เพิ่ม layer แต่ละชั้นเพิ่มความซับซ้อน — อย่า over-engineer ตั้งแต่ต้น
- **Cache invalidation is hard:** ปัญหา consistency ระหว่าง cache กับ DB เป็นหนึ่งในปัญหา classic ของ distributed systems
- **Database replication lag:** Slave อาจล้าหลัง Master ชั่วคราว (eventual consistency) — critical reads อาจต้องไปที่ Master โดยตรง
- **Load balancer เป็น SPOF ตัวใหม่:** ต้องมี HA setup (active-passive หรือ active-active) สำหรับ load balancer เอง
- **CDN cache invalidation:** การ clear CDN cache ทันทีอาจไม่ได้ผล 100% ใน edge nodes ทั่วโลก

## References

1. [ByteByteGo - Scale from Zero to Millions of Users](https://bytebytego.com/courses/system-design-interview/scale-from-zero-to-millions-of-users)
2. [System Design Primer — donnemartin/system-design-primer](https://github.com/donnemartin/system-design-primer/blob/master/README.md)
3. [Complete Guide to System Design: From Single Server to Scalable Architecture (Medium)](https://medium.com/@nomannayeem/complete-guide-to-system-design-from-single-server-to-scalable-architecture-66914baa7355)
4. [30 System Design Concepts — AlgoMaster](https://blog.algomaster.io/p/30-system-design-concepts)
5. [System Design Cheat Sheet — Ajit Singh](https://singhajit.com/system-design-cheat-sheet/)

## Key Takeaways

- ทุกระบบเริ่มต้นง่าย — scale เมื่อมี evidence ว่าต้องการ ไม่ใช่ก่อนหน้านั้น
- แยก Web Tier และ Data Tier ออกจากกันตั้งแต่เนิ่น ๆ เพื่อ scale อิสระ
- Horizontal scaling ดีกว่า Vertical ในระยะยาว แต่ต้องการ Stateless design
- Load Balancer, Replication, Cache, CDN คือ building blocks หลักของระบบที่ scale ได้
- ทุก layer เพิ่ม complexity — วัดผลได้ก่อนเพิ่ม
- "Stateless web tier" คือ prerequisite สำหรับ horizontal scaling ที่แท้จริง
