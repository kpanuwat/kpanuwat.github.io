---
title: "ทักษะพื้นฐานซอฟต์แวร์ในยุค AI: ทำไม Code Entropy ถึงชนะเสมอ (และทางออกคืออะไร)"
date: 2026-05-31 06:37:00 +0700
categories: [Engineering]
tags: [ai, software-engineering, architecture, tdd, domain-driven-design, clean-code]
---

## TL;DR

Matt Pocock นักพัฒนาจาก TypeScript world ชี้ว่ากระแส "vibe coding" และ "specs-to-code" กำลังทำให้ codebase พัง ไม่ใช่เพราะ AI ไม่เก่ง — แต่เพราะนักพัฒนาละทิ้งทักษะพื้นฐานที่ช่วยให้ AI ทำงานได้ดี ทางออกคือการเป็น **สถาปนิกเชิงกลยุทธ์**: ใช้ Shared Design Concept, Ubiquitous Language, Deep Modules และ TDD เพื่อควบคุม AI ให้สร้างระบบที่ยั่งยืน

## Background / Why this matters

ในยุคที่ AI เขียนโค้ดได้เร็วมาก นักพัฒนาจำนวนมากเริ่มเชื่อว่า **"code is cheap"** — แค่ prompt แล้ว AI จะสร้างให้ แต่ Matt Pocock เถียงตรงข้าม: code ไม่ถูกเลย และ **bad code แพงกว่าที่เคยในยุค AI**

เหตุผลคือ AI ทำงานได้ดีมากในโค้ดที่ดี แต่ติดหล่มในโค้ดที่แย่ ถ้า codebase ของคุณยุ่งเหยิง AI จะ "อ่าน" context ไม่ออก → generate code ผิดพลาด → คุณ re-prompt → มันยิ่งแย่ลง วนซ้ำจนเป็น **Software Entropy** ที่ไม่สามารถแก้ได้

**ใครคือ Matt Pocock?** เขาเป็น TypeScript educator และ tool builder ที่เป็นที่รู้จักในชุมชน TypeScript โลก เขา present เรื่องนี้ที่ AI Engineer Europe 2026 ในชื่อ "Software Fundamentals Matter More Than Ever" ซึ่งกลายเป็นหนึ่งใน talk ที่พูดถึงมากที่สุดในงาน

## Deep Dive

### 1. Software Entropy — ศัตรูเงียบของ AI Coding

จาก *The Pragmatic Programmer* (Thomas & Hunt): **entropy** คือแนวโน้มของระบบที่จะพังและกระจัดกระจายหาก ไม่มีการดูแล

ในบริบท AI coding มันเกิดขึ้นเมื่อ:
- แต่ละ prompt แก้เฉพาะ "สิ่งที่เห็น" โดยไม่คิดถึง design ภาพรวม
- AI ทำการเปลี่ยนแปลงเล็กน้อยซ้ำๆ จนทั้งระบบ inconsistent กัน
- ไม่มี shared model ระหว่างนักพัฒนาและ AI ว่าระบบควรเป็นอย่างไร

> "ทุกครั้งที่คุณ prompt โดยไม่คิดถึง design ของทั้งระบบ codebase คุณจะแย่ลงทีละนิด" — Matt Pocock

John Ousterhout (ผู้เขียน *A Philosophy of Software Design*) นิยาม **complexity** ว่าคือ "อะไรก็ตามที่ทำให้ระบบยากต่อการเข้าใจและแก้ไข" — นั่นคือสิ่งที่เกิดขึ้นเมื่อ entropy สะสม

### 2. Shared Design Concept — แก้ปัญหา "AI ทำไม่ตรงที่ต้องการ"

Frederick P. Brooks ใน *The Design of Design* อธิบายว่า เมื่อคนสองคนออกแบบสิ่งหนึ่งร่วมกัน จะมี **design concept** — ทฤษฎีล่องหนของสิ่งที่กำลังสร้าง — ลอยอยู่ระหว่างกัน

ปัญหาที่พบบ่อยที่สุดในการทำงานกับ AI คือ **นักพัฒนาและ AI ไม่ share design concept เดียวกัน** → AI สร้างสิ่งที่ไม่ต้องการ

**วิธีแก้: "Grill Me" Skill**

Matt Pocock สร้าง skill ชื่อ "grill me" ที่มีเนื้อหาสั้นมาก:

```
Interview me relentlessly about every aspect of this plan
until we reach a shared understanding.
Walk down each branch of the design tree,
resolving dependencies between decisions one by one.
```

Skill นี้ทำให้ AI ถามคำถามย้อนกลับมาหา developer 40–100 ข้อ ก่อนที่จะเริ่มเขียนโค้ด ผลลัพธ์คือทั้งสองฝ่าย share design concept เดียวกัน → AI generate ตรง → ต้อง re-prompt น้อยลงมาก (ปัจจุบัน repo นี้มี 13,000+ stars)

### 3. Ubiquitous Language — ลด Verbosity ของ AI

แนวคิดจาก **Domain-Driven Design (DDD)** คือการสร้าง vocabulary ร่วมกันระหว่างนักพัฒนา, ผู้ใช้, และระบบ

Matt Pocock ประยุกต์ใช้กับ AI: สร้าง **markdown file ของ terminology** ที่ define คำศัพท์เฉพาะของ domain แล้ว feed ให้ AI ทุกครั้งที่ plan หรือ implement

ผลที่เห็นชัด:
- AI ใช้ภาษาที่ verbose น้อยลง
- "thinking traces" ของ AI มีคุณภาพดีขึ้น
- Implementation ตรงกับ domain model มากขึ้น
- ลด hallucination เรื่อง business term

ตัวอย่าง ubiquitous language file:
```markdown
# Project Vocabulary

- **Order**: A confirmed purchase intent, has [status: pending|paid|shipped|delivered]
- **Cart**: Temporary container before checkout, not persisted to DB
- **SKU**: Stock Keeping Unit, unique identifier per product variant (not product)
- **Fulfillment**: The act of shipping, managed by 3rd-party logistics
```

เมื่อ AI รู้ว่า "Cart" ≠ "Order" และ "SKU" ≠ "Product" → โค้ดที่ generate ออกมาจะ consistent กับ business logic จริง

### 4. Deep Modules — โครงสร้างที่ AI ทำงานได้ดีที่สุด

จาก *A Philosophy of Software Design* (Ousterhout): **deep module** คือ module ที่มี **interface เรียบง่าย** แต่ **ซ่อน functionality มหาศาล** ไว้ข้างใน

เปรียบเทียบ:

| | Shallow Module | Deep Module |
|---|---|---|
| Interface | ซับซ้อน หลาย parameter | เรียบง่าย ชัดเจน |
| ภายใน | code น้อย logic น้อย | code เยอะ logic ซับซ้อน |
| Dependency | interconnected กับหลาย module | encapsulate ได้ดี |
| AI ทำงาน | ยาก — AI เห็น dependency รก | ง่าย — AI รู้ว่า "กล่องนี้ทำอะไร" |

AI มักสร้าง **shallow modules** — code blobs ขนาดเล็กที่มี dependency ซับซ้อน เมื่อ codebase เติบโตขึ้น AI จะ navigate ไม่ออกและเริ่มสร้าง bug

**Grey Box Strategy**: นักพัฒนาออกแบบแค่ **external interface** (กล่องเทาด้านนอก) แล้วปล่อยให้ AI implement ภายใน — นักพัฒนาประหยัด cognitive energy, AI มีขอบเขตชัดเจน

### 5. TDD กับ AI — บังคับให้ก้าวทีละก้าว

failure mode ที่ Matt เรียกว่า **"outrunning your headlights"**: AI generate โค้ดปริมาณมากในทีเดียว โดยไม่รับ feedback ระหว่างทาง → เมื่อ error เกิด หาสาเหตุไม่เจอ

**TDD บังคับให้ AI ทำงานอย่างถูกต้อง**:
1. เขียน test ก่อน (กำหนด expectation)
2. AI implement ให้ test pass
3. Refactor (AI ทำ, developer review)
4. วน loop จนเสร็จ

ทำไม deep modules + TDD ทำงานร่วมกันได้ดี: deep modules มี interface เรียบง่าย → เขียน unit test ง่าย → AI ได้ feedback ชัดเจน → code quality ดีขึ้น

```
# TDD workflow กับ AI

1. Developer: กำหนด test spec (what it should do)
2. AI: เขียน test
3. AI: ยืนยันว่า test fail ก่อน (red)
4. AI: implement ให้ pass (green)
5. AI: refactor (clean)
6. Developer: review + approve
```

## Caveats / Limits

- **"Grill me" ใช้เวลา** — AI จะถามคำถาม 40-100 ข้อ เหมาะกับ feature ใหม่/ซับซ้อน ไม่เหมาะกับ bug fix เล็กๆ
- **Ubiquitous language ต้อง maintain** — ถ้า domain evolve แล้ว file ไม่อัปเดต AI จะ confuse จาก stale term
- **Deep modules ต้องการ design thinking** — ออกแบบ interface ดีๆ ต้องการความเข้าใจ domain ลึก ไม่ใช่สิ่งที่ AI ทำแทนได้ 100%
- **TDD อาจ overkill** สำหรับ prototype หรือ throwaway code — ใช้ judgment ว่า code ชิ้นนี้ long-lived หรือไม่
- แนวคิดเหล่านี้มาจาก talk ที่ Matt present ที่ AI Engineer Europe 2026 บางส่วนยัง evolve อยู่ — ตรวจสอบ repo และวิดีโอล่าสุดเสมอ

## References

1. [Software Fundamentals Matter More Than Ever — Matt Pocock (YouTube)](https://youtu.be/v4F1gFy-hqg)
2. [Talk summary at AI Engineer Europe 2026](https://tldrecap.tech/posts/2026/aie-europe/software-fundamentals-ai/)
3. [Matt Pocock's skills repo — grill me + AI engineering workflow](https://knightli.com/en/2026/05/15/matt-pocock-skills-ai-engineering-workflow/)
4. [Full Walkthrough: Workflow for AI Coding — Matt Pocock (YouTube)](https://www.youtube.com/watch?v=-QFHIoCo-Ko)
5. *A Philosophy of Software Design* — John Ousterhout (book)
6. *The Pragmatic Programmer* — David Thomas, Andrew Hunt (book)
7. *The Design of Design* — Frederick P. Brooks (book)

## Key Takeaways

- **Code is NOT cheap**: bad code ในยุค AI แพงกว่าที่เคย เพราะมันขัดขวาง AI จากการทำงานได้ดี
- **Software Entropy** เร่งตัวขึ้นเมื่อนักพัฒนา prompt โดยไม่คิดถึง design ภาพรวม
- **"Grill me" skill** แก้ปัญหา design concept mismatch — ให้ AI interview คุณก่อนเขียนโค้ด
- **Ubiquitous Language** (markdown vocabulary file) ลด AI verbosity และ hallucination เรื่อง business term
- **Deep Modules** สร้าง architecture ที่ AI navigate ได้ง่าย: interface เรียบง่าย, ความซับซ้อนซ่อนอยู่ข้างใน
- **TDD** บังคับให้ AI ก้าวทีละก้าว ไม่ "outrun headlights" — ทำงานร่วมกับ deep modules ได้ดีที่สุด
- **บทบาทนักพัฒนาไม่หายไป** — เปลี่ยนจาก "คนเขียนโค้ด" เป็น "สถาปนิกที่ควบคุม AI ด้วยหลักการพื้นฐาน"
