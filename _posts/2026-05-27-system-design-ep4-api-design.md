---
title: "System Design EP4: ออกแบบ API ให้ถูกต้อง — REST, GraphQL และ gRPC"
date: 2026-05-26 00:06:00 +0700
categories: [Engineering]
tags: [system-design, api-design, rest, graphql, grpc, http, protocol-buffers]
series: system-design-fundamentals
slides: false
---

{% include series-nav.html %}

## TL;DR

REST, GraphQL และ gRPC ต่างมีจุดแข็งที่ต่างกัน — ไม่มีตัวไหน "ดีกว่า" ในทุก context REST เหมาะกับ public API, GraphQL เหมาะกับ complex client needs, gRPC เหมาะกับ internal microservices ที่ต้องการ performance สูง

## Background / Why this matters

API คือ "สัญญา" ระหว่าง producer และ consumer ถ้าออกแบบผิด ต้องแก้ทั้งฝั่ง server และ client ทุก consumer พร้อมกัน — ค่าใช้จ่ายสูงมาก

ยิ่งไปกว่านั้น ใน microservices architecture service หนึ่งอาจมี API หลายประเภทพร้อมกัน: REST สำหรับ mobile clients, gRPC สำหรับ internal service-to-service, WebSocket สำหรับ real-time features การเข้าใจ trade-off จะช่วยเลือก protocol ที่เหมาะกับแต่ละ interaction

## Deep Dive

### REST (Representational State Transfer)

REST เป็น architectural style ที่ใช้ HTTP verbs กับ resource-based URLs

**HTTP Verbs และความหมาย:**

| Verb | ความหมาย | Idempotent | Body |
|------|---------|-----------|------|
| GET | อ่านข้อมูล | ✓ | ไม่มี |
| POST | สร้างข้อมูล | ✗ | มี |
| PUT | แทนที่ทั้งหมด | ✓ | มี |
| PATCH | อัปเดตบางส่วน | ✗ | มี |
| DELETE | ลบข้อมูล | ✓ | อาจมี |

**RESTful URL Design:**
```
GET    /users           → list all users
POST   /users           → create user
GET    /users/123       → get user 123
PUT    /users/123       → replace user 123
PATCH  /users/123       → partial update user 123
DELETE /users/123       → delete user 123
GET    /users/123/orders → get orders of user 123
```

**HTTP Status Codes ที่ควรใช้ให้ถูก:**
```
200 OK           → success (GET, PUT, PATCH)
201 Created      → resource created (POST)
204 No Content   → success, no body (DELETE)
400 Bad Request  → invalid input
401 Unauthorized → not authenticated
403 Forbidden    → authenticated but not authorized
404 Not Found    → resource doesn't exist
409 Conflict     → duplicate resource
422 Unprocessable Entity → validation failed
429 Too Many Requests → rate limited
500 Internal Server Error → server bug
```

**ข้อดี REST:**
- Simple, universal — ทุก language/platform รองรับ HTTP
- Human-readable (JSON)
- Cacheable ด้วย HTTP caching (CDN, browser cache)
- Stateless — scale ง่าย
- Ecosystem ใหญ่มาก: Swagger/OpenAPI, Postman, API gateways

**ข้อเสีย REST:**
- **Over-fetching:** GET /users/123 ดึงข้อมูลทั้งหมดแม้ต้องการแค่ชื่อ
- **Under-fetching:** ต้องเรียก API หลายครั้งเพื่อข้อมูลที่เกี่ยวข้องกัน
- **Versioning ยุ่งยาก:** /v1/users vs /v2/users หรือ Header-based versioning

---

### GraphQL

GraphQL เป็น query language สำหรับ API ที่ให้ client ระบุได้ว่าต้องการข้อมูลอะไร

**ตัวอย่าง — เปรียบเทียบ REST vs GraphQL:**

```
REST: ต้องการชื่อ user + 3 posts ล่าสุด
→ GET /users/123          (ดึง user data ทั้งหมด)
→ GET /users/123/posts?limit=3  (ดึง posts)
= 2 HTTP requests, data มากกว่าที่ต้องการ

GraphQL: request เดียว, ได้แค่ที่ต้องการ
query {
  user(id: "123") {
    name
    posts(limit: 3) {
      title
      createdAt
    }
  }
}
```

**Schema Definition:**
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]!
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts(limit: Int): [Post!]!
}

type Mutation {
  createPost(title: String!, content: String!): Post!
}
```

**ข้อดี GraphQL:**
- ไม่มี over/under-fetching — client ขอเฉพาะที่ต้องการ
- Single endpoint (`/graphql`) — versioning ง่ายกว่า
- Strongly typed schema — auto-generated documentation
- Introspection — client รู้ว่า API มีอะไรได้ทันที
- เหมาะมากกับ BFF (Backend For Frontend) pattern

**ข้อเสีย GraphQL:**
- **Caching ยากกว่า:** HTTP GET caching ไม่ทำงานกับ POST queries
- **N+1 problem:** query ที่ nested หลายชั้นอาจเรียก DB จำนวนมาก (แก้ด้วย DataLoader)
- **Complexity overhead:** schema design, resolver implementation, query depth limiting
- **Over-fetching ยังเกิดได้:** ถ้า client ไม่ระมัดระวัง

---

### gRPC (Google Remote Procedure Call)

gRPC ใช้ Protocol Buffers (protobuf) เป็น IDL (Interface Definition Language) และส่งข้อมูลเป็น binary ผ่าน HTTP/2

**ขั้นตอน:**
1. นิยาม service ใน `.proto` file
2. Generate code สำหรับ language ที่ต้องการ
3. Implement server, สร้าง client stub

**ตัวอย่าง .proto:**
```protobuf
syntax = "proto3";

service UserService {
  rpc GetUser (GetUserRequest) returns (User);
  rpc ListUsers (ListUsersRequest) returns (stream User);
  rpc CreateUser (CreateUserRequest) returns (User);
}

message User {
  string id = 1;
  string name = 2;
  string email = 3;
}

message GetUserRequest {
  string id = 1;
}
```

**HTTP/2 advantages:**
- Multiplexing: หลาย requests ใช้ TCP connection เดียว
- Header compression: ลด overhead
- Server push: server ส่งข้อมูลก่อน client ขอได้
- Bidirectional streaming: ส่งข้อมูลสองทางพร้อมกัน

**ประสิทธิภาพ (approximate latency):**
- REST (JSON): ~250ms average
- GraphQL: ~180ms (complex queries)
- gRPC (protobuf): ~25ms — เร็วกว่า 5-10x

**ข้อดี gRPC:**
- Performance สูงมาก: binary protocol + HTTP/2
- Strongly typed contracts ที่ auto-generate code ได้
- Streaming support: unary, client stream, server stream, bidirectional
- Multi-language: generate client สำหรับ 10+ languages จาก .proto เดียว

**ข้อเสีย gRPC:**
- Browser support จำกัด (ต้องใช้ gRPC-Web proxy)
- Binary ไม่ human-readable — debug ยากกว่า JSON
- ทุก consumer ต้องมี .proto file
- Load balancing ซับซ้อน (ต้องรู้จัก HTTP/2)

---

### เปรียบเทียบสรุป

| ลักษณะ | REST | GraphQL | gRPC |
|--------|------|---------|------|
| Protocol | HTTP/1.1+ | HTTP/1.1+ | HTTP/2 |
| Format | JSON/XML | JSON | Protocol Buffers (binary) |
| Type safety | ไม่มี (runtime) | Schema-based | Compile-time |
| Caching | ดีมาก (HTTP) | ยาก | ยาก |
| Browser support | ✓ | ✓ | จำกัด (gRPC-Web) |
| Streaming | WebSocket | Subscriptions | Native |
| Learning curve | ต่ำ | กลาง | กลาง-สูง |
| เหมาะกับ | Public API | Complex clients | Internal services |

---

### API Design Best Practices

#### Versioning Strategies

**URL Versioning (แนะนำสำหรับ public API):**
```
https://api.example.com/v1/users
https://api.example.com/v2/users
```
ชัดเจน, cacheable แต่ URL ยาว

**Header Versioning:**
```
GET /users
Accept: application/vnd.example+json;version=2
```
URL สะอาด แต่ debug ยากกว่า

#### Pagination

```json
// Offset-based (ง่าย แต่ inconsistent เมื่อ data เปลี่ยน)
GET /posts?offset=20&limit=10

// Cursor-based (แนะนำสำหรับ real-time data)
GET /posts?cursor=eyJpZCI6MTAwfQ&limit=10
Response: {
  "data": [...],
  "nextCursor": "eyJpZCI6MTEwfQ",
  "hasMore": true
}
```

#### Rate Limiting Headers

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 850
X-RateLimit-Reset: 1735689600
```

#### API Gateway Pattern

```
Client → [API Gateway] → Auth Service
                       → User Service
                       → Order Service
                       → Product Service
```

API Gateway ทำหน้าที่: Authentication, Rate limiting, Request routing, Response aggregation, Logging

---

### เลือก API Protocol สำหรับ Use Case จริง

```
Public Web/Mobile API        → REST (ecosystem ใหญ่, cacheable)
Frontend BFF                 → GraphQL (client drives query)
Internal microservices       → gRPC (performance, type safety)
Real-time chat/notifications → WebSocket + REST
File upload                  → REST multipart
Streaming data pipeline      → gRPC streaming
```

## Caveats / Limits

- **REST ไม่ได้ =  CRUD:** REST เป็น style ไม่ใช่ spec — "RESTful" ที่แท้จริงต้องรวม HATEOAS แต่ส่วนใหญ่ไม่ทำ
- **GraphQL N+1 problem:** ถ้าไม่ใช้ DataLoader, query ที่ดึง 100 posts พร้อม author จะเรียก DB 101 ครั้ง
- **gRPC-Web ยังมีข้อจำกัด:** ต้องใช้ proxy layer ระหว่าง browser และ gRPC backend
- **ไม่จำเป็นต้องเลือกแค่อย่างเดียว:** Production systems ใช้หลาย protocol — REST สำหรับ external, gRPC สำหรับ internal
- **Backward compatibility:** การเปลี่ยน API response format โดยไม่มี versioning จะ break consumers

## References

1. [REST vs GraphQL vs gRPC — DesignGurus](https://www.designgurus.io/blog/rest-graphql-grpc-system-design)
2. [When to Use REST vs gRPC vs GraphQL — Kong](https://konghq.com/blog/engineering/rest-vs-grpc-vs-graphql)
3. [REST vs GraphQL vs gRPC — Baeldung](https://www.baeldung.com/rest-vs-graphql-vs-grpc)
4. [AI-Powered APIs: gRPC vs REST vs GraphQL Performance](https://smartdev.com/ai-powered-apis-grpc-vs-rest-vs-graphql/)
5. [SystemDesignSchool - REST vs gRPC vs GraphQL](https://systemdesignschool.io/blog/rest-grpc-graphql)
6. [System Design Primer](https://github.com/donnemartin/system-design-primer/blob/master/README.md)

## Key Takeaways

- REST เหมาะกับ public API ที่ต้องการ compatibility กว้าง; GraphQL เหมาะเมื่อ client มี query requirements หลากหลาย; gRPC เหมาะกับ internal services ที่เน้น performance
- gRPC เร็วกว่า REST ถึง 5-10x ด้วย protobuf + HTTP/2 — สำคัญมากสำหรับ high-frequency internal calls
- GraphQL แก้ปัญหา over/under-fetching แต่แลกด้วย caching complexity และ N+1 risk
- Versioning API ตั้งแต่วันแรก (v1) แม้ยังไม่มี v2 — ป้องกัน breaking change ในอนาคต
- API Gateway เป็น best practice สำหรับ microservices: centralized auth, rate limiting, logging
- Production systems ใช้หลาย protocol พร้อมกัน — เลือกตาม interaction type ไม่ใช่ตาม trend
