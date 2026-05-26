---
title: "System Design EP2: เลือกฐานข้อมูลให้ถูกประเภท — SQL vs NoSQL"
date: 2026-05-26 00:04:00 +0700
categories: [Engineering]
tags: [system-design, database, sql, nosql, acid, cap-theorem, postgresql, mongodb]
series: system-design-fundamentals
slides: false
---

{% include series-nav.html %}

## TL;DR

ฐานข้อมูลไม่มีตัวที่ "ดีที่สุด" มีแค่ตัวที่เหมาะกับ use case นั้น ๆ EP นี้อธิบายความแตกต่างระหว่าง SQL และ NoSQL ผ่าน ACID vs BASE model, CAP Theorem และ decision framework สำหรับเลือกให้ถูกงาน

## Background / Why this matters

หนึ่งในการตัดสินใจที่ส่งผลระยะยาวที่สุดในการออกแบบระบบคือการเลือกฐานข้อมูล เพราะการ migrate ภายหลังมีต้นทุนสูงมาก

วิศวกรมือใหม่มักคิดว่า SQL คือ default ที่ปลอดภัย แต่ในระบบที่ต้องรองรับ high-throughput หรือ unstructured data การยืนยันทุก transaction ด้วย ACID อาจกลายเป็น bottleneck แทน การเข้าใจ trade-off จะช่วยเลือกเครื่องมือที่เหมาะสม ไม่ใช่เครื่องมือที่คุ้นเคย

## Deep Dive

### SQL (Relational Database)

SQL databases เก็บข้อมูลในรูป **tables** ที่มี schema ชัดเจน และรองรับ **relationship** ระหว่าง tables ผ่าน foreign keys

**ตัวอย่าง:** PostgreSQL, MySQL, SQLite, Microsoft SQL Server, Oracle

**จุดแข็ง:**
- **Structured queries:** JOIN หลาย tables ได้ง่าย
- **ACID transactions:** ข้อมูลถูกต้องแม้มี concurrent writes
- **Mature ecosystem:** tooling, ORM, BI tools ครบครัน
- **Strong consistency:** ทุก node เห็นข้อมูลเดียวกันเสมอ

```sql
-- ตัวอย่าง: ดึง orders พร้อม customer name
SELECT o.id, o.total, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'pending';
```

---

### NoSQL (Non-Relational Database)

NoSQL ครอบคลุมหลาย data model: Document, Key-Value, Column-family, Graph

| ประเภท | ตัวอย่าง | เหมาะกับ |
|--------|---------|---------|
| Document | MongoDB, CouchDB | User profiles, catalogs, CMS |
| Key-Value | Redis, DynamoDB | Sessions, caching, leaderboards |
| Column-family | Cassandra, HBase | Time-series, IoT, analytics |
| Graph | Neo4j, Amazon Neptune | Social networks, fraud detection |

**จุดแข็ง:**
- **Flexible schema:** เปลี่ยน data model ได้ง่ายโดยไม่ต้องทำ migration
- **Horizontal scaling:** ออกแบบมาเพื่อ distribute ข้อมูลข้ามหลาย nodes
- **High write throughput:** เหมาะกับ workload ที่ write บ่อยและเยอะ
- **Specialized models:** Graph DB เหมาะกับ relationship traversal มากกว่า SQL มาก

---

### ACID vs BASE — หัวใจของความแตกต่าง

**ACID (SQL):**

| ตัวย่อ | ความหมาย | ตัวอย่าง |
|--------|---------|---------|
| **A**tomicity | Transaction ทำครบหรือไม่ทำเลย | โอนเงิน: หัก A + เพิ่ม B ต้องสำเร็จพร้อมกัน |
| **C**onsistency | ข้อมูลอยู่ใน valid state เสมอ | ยอดบัญชีไม่ติดลบ |
| **I**solation | Concurrent transactions ไม่รบกวนกัน | User 2 คนซื้อสินค้าชิ้นเดียวพร้อมกัน |
| **D**urability | Data ยังอยู่หลัง commit แม้ระบบ crash | ข้อมูลไม่หายถ้า server รีสตาร์ท |

**BASE (NoSQL):**

| ตัวย่อ | ความหมาย |
|--------|---------|
| **B**asically Available | ระบบตอบสนองเสมอ แม้บาง node ล้ม |
| **S**oft-state | State ไม่ fixed — อาจเปลี่ยนได้แม้ไม่มี input ใหม่ (replication in progress) |
| **E**ventually Consistent | ข้อมูลจะ consistent ในที่สุด แต่ไม่รับประกันเวลา |

**กฎง่าย ๆ:** ถ้าต้องการ "ถูกต้อง 100% ณ ขณะนั้น" → ACID (SQL); ถ้าต้องการ "ตอบสนองเสมอแม้บางส่วนพัง" → BASE (NoSQL)

---

### CAP Theorem

ระบบ distributed สามารถมีได้แค่ **2 ใน 3** คุณสมบัตินี้พร้อมกัน:

```
         Consistency
        /           \
       /             \
      /    Choose 2   \
     /                 \
Availability ——— Partition Tolerance
```

| ระบบประเภท | C | A | P | ตัวอย่าง |
|-----------|---|---|---|---------|
| CA (ไม่ทน network partition) | ✓ | ✓ | ✗ | PostgreSQL (single node) |
| CP (ยอม unavailable เพื่อ consistency) | ✓ | ✗ | ✓ | HBase, Zookeeper |
| AP (ยอม inconsistent ชั่วคราวเพื่อ availability) | ✗ | ✓ | ✓ | Cassandra, DynamoDB |

**ในความเป็นจริง:** network partition เกิดขึ้นเสมอในระบบ distributed ดังนั้น P คือสิ่งที่หลีกเลี่ยงไม่ได้ การเลือกจริงคือ C vs A เมื่อ partition เกิดขึ้น

---

### Decision Framework: เลือก SQL หรือ NoSQL?

**เลือก SQL เมื่อ:**
- Data มี structure ชัดเจน และไม่เปลี่ยนบ่อย
- ต้องการ complex queries ที่มี JOIN หลาย tables
- Consistency และ correctness สำคัญกว่า performance (financial, healthcare)
- ทีมคุ้นเคยกับ relational model
- ต้องการ reporting และ BI tools ที่ทำงานกับ SQL ได้ทันที

**เลือก NoSQL เมื่อ:**
- Data schema เปลี่ยนบ่อย หรือแต่ละ record มีโครงสร้างต่างกัน
- ต้องการ write throughput สูงมาก (IoT, logs, events)
- ต้องการ scale horizontal ข้ามหลาย data centers
- ข้อมูลเป็น hierarchical (document) หรือ relationship-heavy (graph)
- Latency ต่ำสำคัญมาก (gaming leaderboard, session cache)

---

### ตัวอย่างจริง: เลือก DB ให้แต่ละส่วนของระบบ

สมมติสร้าง e-commerce platform:

| Component | แนะนำ | เหตุผล |
|-----------|------|--------|
| User accounts, Orders | PostgreSQL | ต้องการ ACID สำหรับ financial data |
| Product catalog | MongoDB | Schema ยืดหยุ่น, attribute ต่างกันตามประเภทสินค้า |
| Shopping cart | Redis | Fast read/write, TTL-based expiry |
| Search | Elasticsearch | Full-text search, faceted filters |
| Purchase history (analytics) | Cassandra | Append-only time-series, high write throughput |
| Product recommendations | Neo4j | Graph traversal สำหรับ "users who bought X also bought Y" |

**บทเรียน:** Production systems ใช้หลาย database พร้อมกัน แต่ละตัวเหมาะกับ workload ของมัน

---

### Polyglot Persistence

แนวคิด Polyglot Persistence (Martin Fowler, 2011) คือการเลือกใช้ database หลายประเภทในระบบเดียว โดยแต่ละส่วนใช้ตัวที่เหมาะกับ use case ของมัน

```
[Order Service] → PostgreSQL (ACID, financial)
[Product Service] → MongoDB (flexible schema)
[Session Service] → Redis (fast TTL-based K-V)
[Search Service] → Elasticsearch (inverted index)
```

**ข้อควรระวัง:** Polyglot persistence เพิ่ม operational complexity — ต้องดูแลหลาย systems, backup policies ต่างกัน, consistency ข้าม services ต้องออกแบบเอง

## Caveats / Limits

- **CAP Theorem ไม่ใช่ทุกอย่าง:** PACELC theorem เพิ่ม dimension เรื่อง Latency vs Consistency ที่ CAP ไม่ครอบคลุม
- **NoSQL ไม่ใช่ silver bullet for scale:** Cassandra scale ได้ดี แต่ query flexibility น้อยมาก — schema design สำคัญมากกว่า SQL
- **MongoDB transaction support:** MongoDB 4.0+ รองรับ multi-document ACID transactions แล้ว แต่ performance trade-off ต้องทดสอบ
- **Eventual consistency อาจสร้างปัญหา UX:** ถ้า user เพิ่งแก้ข้อมูลแล้วยังเห็นข้อมูลเก่า อาจสับสน
- **ไม่ควรเลือก DB ตาม hype:** เลือกตาม access pattern จริงของ application ไม่ใช่ตามที่ popular ในตอนนั้น

## References

1. [SQL vs NoSQL: Complete Guide to ACID, CAP, and BASE Models](https://www.vijayanandrp.com/blog/tech/sql/sql-nosql-casestudy)
2. [CAP Theorem, ACID, and Choosing Between SQL and NoSQL](https://manigandham.com/post/sql-nosql-acid-cap-theorem)
3. [Choosing the Right Database using CAP Theorem (Medium)](https://avssridhar.medium.com/choosing-the-right-database-using-cap-theorem-43ced137cba5)
4. [System Design Primer — Database section](https://github.com/donnemartin/system-design-primer/blob/master/README.md)
5. [When to Choose NoSQL Databases: Understanding BASE](https://www.creowis.com/blog/when-to-choose-nosql-databases-key-considerations)
6. [ByteByteGo - Scale from Zero to Millions of Users](https://bytebytego.com/courses/system-design-interview/scale-from-zero-to-millions-of-users)

## Key Takeaways

- SQL เหมาะกับ structured data ที่ต้องการ ACID transactions; NoSQL เหมาะกับ flexible schema และ high-throughput
- ACID = correctness first; BASE = availability first — เลือกตาม business requirement ไม่ใช่ preference
- CAP Theorem: distributed system เลือกได้แค่ 2 ใน 3 — Partition Tolerance แทบหลีกเลี่ยงไม่ได้
- Production systems ใช้ Polyglot Persistence — หลาย DB สำหรับหลาย workload
- เลือก DB จาก access pattern ของ application ไม่ใช่จาก popularity
- Migration ฐานข้อมูลคือหนึ่งในงานที่ costly ที่สุด — ตัดสินใจให้ดีตั้งแต่ต้น
