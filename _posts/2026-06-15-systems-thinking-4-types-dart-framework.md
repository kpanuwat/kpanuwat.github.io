---
title: "การคิดเชิงระบบ: เห็นรูปแบบที่ซ่อนอยู่ด้วย 4 ประเภทระบบและกรอบ DART"
date: 2026-06-14 00:06:00 +0700
categories: [Engineering]
tags: [systems-thinking, cynefin, problem-solving, decision-making, mental-models, leadership]
---

## TL;DR

การคิดเชิงระบบ (Systems Thinking) ช่วยให้เราเห็นรูปแบบที่ซ่อนอยู่และแก้ปัญหาตรงจุด ด้วยการจำแนกระบบออกเป็น 4 ประเภท — Clear, Complicated, Complex, Chaotic — แต่ละประเภทต้องการวิธีตอบสนองที่แตกต่างกันอย่างสิ้นเชิง และระบบที่ปรับปรุงยากที่สุดไม่ใช่ระบบภายนอก แต่คือกรอบความคิดในหัวเราเอง

## Background: ทำไม Systems Thinking ถึงสำคัญ

นักแก้ปัญหาส่วนใหญ่มักใช้วิธีแก้ปัญหาแบบเดิมกับทุกสถานการณ์ — เรียกผู้เชี่ยวชาญ, ทำ analysis, หรือออก checklist ให้ทุกคนทำตาม แต่วิธีนี้ล้มเหลวซ้ำๆ เพราะ **ระบบแต่ละประเภทต้องการ response ที่แตกต่างกันโดยสิ้นเชิง**

การใช้ checklist กับปัญหา Complex เหมือนพยายามใช้แผนที่กรุงเทพฯ นำทางในป่า เครื่องมือถูกต้อง แต่ใช้ผิดประเภทปัญหา

**Cynefin Framework** (พัฒนาโดย Dave Snowden ปี 1999) เป็นกรอบ sense-making ที่ช่วยให้ผู้นำและนักแก้ปัญหาวิเคราะห์ว่าตนอยู่ใน "domain" ไหน ก่อนตัดสินใจว่าจะ respond อย่างไร ซึ่งเป็นรากฐานของการคิดเชิงระบบในทางปฏิบัติ

## Deep Dive: 4 ประเภทระบบ

### 1. Clear — ระบบที่ชัดเจน

**ลักษณะ:** ความสัมพันธ์เหตุ-ผลชัดเจนและคาดเดาได้ ("known knowns") วิธีแก้ปัญหาเป็นที่รู้จักดี สามารถสร้าง best practice ได้

**Pattern การทำงาน:** Sense → Categorize → Respond

**เครื่องมือที่ใช้:**
- Checklists และ Standard Operating Procedures (SOP)
- Best practices ที่พิสูจน์แล้ว
- Automation และ rules-based systems

**ตัวอย่าง:**
- การทำบัญชีรายวัน (มีกฎตายตัว)
- งาน QA บนสายการผลิตที่ standardize แล้ว
- การ deploy code ผ่าน CI/CD pipeline ที่กำหนดไว้

**ข้อระวัง:** ระบบ Clear อาจ "complacency trap" — เมื่อทุกอย่างดูง่ายเกินไป ผู้คนหยุดตั้งคำถามจนกระทั่ง context เปลี่ยน แต่ยังใช้ checklist เดิมอยู่

---

### 2. Complicated — ระบบที่ซับซ้อนแบบมีคำตอบ

**ลักษณะ:** ความสัมพันธ์เหตุ-ผลต้องใช้ความเชี่ยวชาญในการค้นหา ("known unknowns") มีคำตอบที่ถูกต้อง แต่ไม่ใช่ทุกคนจะมองเห็น

**Pattern การทำงาน:** Sense → Analyze → Respond

**เครื่องมือที่ใช้:**
- ผู้เชี่ยวชาญ (subject matter experts)
- Data analysis และ root cause analysis
- Good practices (ไม่ใช่ best practices — มีหลายวิธีที่ดี)

**ตัวอย่าง:**
- การวินิจฉัยโรคโดยแพทย์ (มีขั้นตอน แต่ต้องใช้ expertise)
- การออกแบบ architecture ของ software ระบบขนาดใหญ่
- การวิเคราะห์ financial model ที่มีตัวแปรหลายตัว

**ข้อระวัง:** ระบบ Complicated อาจตกใน "expert trap" — พึ่งผู้เชี่ยวชาญมากเกินไปจนลืมว่าบริบทเปลี่ยน หรือผู้เชี่ยวชาญอาจมี bias จาก experience เดิม

---

### 3. Complex — ระบบที่ซับซ้อนแบบไม่มีคำตอบตายตัว

**ลักษณะ:** ความสัมพันธ์เหตุ-ผลเข้าใจได้เฉพาะย้อนหลัง ("unknown unknowns") รูปแบบเกิดขึ้นจากปฏิสัมพันธ์ของส่วนต่างๆ ไม่มีคำตอบที่ "ถูก" ก่อนลงมือ

**Pattern การทำงาน:** Probe → Sense → Respond

**เครื่องมือที่ใช้:**
- Safe-to-fail experiments (ทดลองเล็กๆ ที่ fail ได้โดยไม่เสียหายมาก)
- Emergent practices (รอให้รูปแบบโผล่ขึ้นมาเอง)
- Iterative learning และ rapid feedback loops

**ตัวอย่าง:**
- การเปลี่ยนวัฒนธรรมองค์กร (ไม่มี SOP ที่ใช้ได้กับทุกบริษัท)
- การพัฒนา product ใหม่ในตลาดที่ยังไม่แน่นอน
- การ scale startup จาก 10 เป็น 100 คน

**ข้อระวัง:** คนที่คุ้นกับ Complicated มักอยาก "over-plan" ระบบ Complex ซึ่งทำให้เสียเวลาออกแบบ solution ที่จะ obsolete ก่อนลงมือ การทดลองเร็วและถูกมักดีกว่าแผนที่สมบูรณ์

---

### 4. Chaotic — ระบบที่วุ่นวาย

**ลักษณะ:** ไม่มีความสัมพันธ์เหตุ-ผลที่ชัดเจน ต้องการการลงมือทันทีเพื่อควบคุมสถานการณ์ก่อน

**Pattern การทำงาน:** Act → Sense → Respond

**เครื่องมือที่ใช้:**
- Decisive leadership action (ลงมือก่อน วิเคราะห์หลัง)
- Crisis management protocols
- Stabilize → Assess → Transition to Complex

**ตัวอย่าง:**
- Production outage ที่กระทบผู้ใช้หลักล้านคน
- วิกฤตการณ์ PR ที่ viral บน social media
- ภัยธรรมชาติที่กระทบ supply chain

**ข้อระวัง:** ผู้นำบางคน "ชอบ" ความโกลาหลเพราะรู้สึกว่าตัวเองมีประโยชน์ ("hero mode") ซึ่งทำให้พวกเขา maintain chaos แทนที่จะ resolve มัน เป้าหมายของ Chaotic คือ stabilize แล้วเคลื่อนไปสู่ Complex เร็วที่สุด

## กรอบ DART: จำแนกประเภทระบบก่อนลงมือ

วิดีโอต้นทางนำเสนอกรอบ DART เป็นเครื่องมือในการประเมินว่าระบบหรือปัญหาที่เผชิญอยู่นั้นอยู่ใน domain ไหน ก่อนตัดสินใจว่าจะ respond อย่างไร แนวคำถามที่ใช้ประเมิน:

| มิติ | คำถามประเมิน |
|------|-------------|
| **Domain clarity** | ความสัมพันธ์เหตุ-ผลชัดเจนแค่ไหน? รู้คำตอบล่วงหน้าหรือต้องค้นหา? |
| **Actor variety** | ผู้เกี่ยวข้องมีกี่ฝ่าย? มี emergent behavior จาก interaction ไหม? |
| **Response options** | มี playbook อยู่แล้ว หรือต้องทดลองหาเอง? |
| **Time pressure** | มีเวลา analyze หรือต้อง act ทันที? |

ผลจาก DART ชี้ไปที่ domain → domain กำหนด response pattern (Sense-Categorize vs Sense-Analyze vs Probe-Sense vs Act-Sense)

## มุมมองภายนอก: 3 แหล่งที่ช่วยประเมินได้ตรงกว่า

หนึ่งในความท้าทายของ systems thinking คือ **เราแทบไม่สามารถประเมิน domain ของระบบที่เราอยู่ใน ได้อย่างแม่นยำ** เพราะมี cognitive bias และ tunnel vision

**3 แหล่งมุมมองภายนอก:**

1. **พี่เลี้ยง/ที่ปรึกษา (Mentor)** — คนที่เคยอยู่ในระบบคล้ายกันมาก่อน สามารถบอกได้ว่านี่คือ Complicated (มีคำตอบ) หรือ Complex (ต้องทดลอง) จาก pattern recognition ของพวกเขา

2. **ข้อมูล (Data)** — Leading indicators ที่ track feedback loop ในระบบ ช่วยให้เห็นว่า response ที่ทำอยู่นั้น moving ไปในทิศทางที่ต้องการหรือไม่ หรือเกิด emergent behavior ที่ไม่คาดคิด

3. **เวลา (Time)** — หลังผ่านไปสักระยะ รูปแบบของระบบ Complex มักโผล่ชัดเจนขึ้นเมื่อมองย้อนหลัง การ "รอให้เห็นรูปแบบ" บางครั้งดีกว่าการตัดสินใจด้วยข้อมูลน้อยเกินไป

## ระบบที่ยากที่สุดคือกรอบความคิดในหัวเราเอง

ประเด็นสำคัญที่สุดจากวิดีโอ: **ระบบที่ปรับปรุงยากที่สุดไม่ใช่ระบบ IT, ระบบองค์กร หรือกระบวนการ — แต่คือ mental model ในหัวเราเอง**

Mental models ของเราเป็นระบบ Complex ที่มี feedback loop ซ่อนอยู่:
- เราแทบไม่รู้ว่ากำลัง categorize ปัญหาผิด domain
- bias จากประสบการณ์เดิมทำให้มองระบบ Complex เหมือน Complicated
- "Availability heuristic" ทำให้เราดึงวิธีแก้ที่เคยใช้ได้มาก่อน แม้ context เปลี่ยนไปแล้ว

**วิธีปรับปรุง mental model:**
- สร้าง habit ของการถามว่า "domain นี้คืออะไร?" ก่อนตัดสินใจทุกครั้ง
- seek มุมมองภายนอก (mentor, data, time) อย่างสม่ำเสมอ
- post-mortem หลังแก้ปัญหา: เราจำแนก domain ถูกตั้งแต่ต้นไหม?

## Caveats / Limits

| ข้อจำกัด | รายละเอียด |
|----------|------------|
| **ระบบเปลี่ยน domain ได้** | ปัญหา COVID-19 เริ่มต้นใน Chaotic → เคลื่อนไปสู่ Complex → บางส่วนกลายเป็น Complicated เมื่อมีข้อมูลมากพอ |
| **Cynefin มี 5th domain: Disorder** | เมื่อไม่รู้ว่าอยู่ใน domain ไหน — อันตรายที่สุดเพราะคนมักตัดสินใจจาก comfort zone ไม่ใช่จาก context |
| **DART เป็น heuristic ไม่ใช่ algorithm** | ใช้เป็น starting point ในการตั้งคำถาม ไม่ใช่สูตรสำเร็จ |
| **Expert bias ใน Complicated** | ผู้เชี่ยวชาญอาจ force ปัญหา Complex เข้า Complicated domain เพราะอยากใช้ expertise ตัวเอง |
| **Paralysis ใน Complex** | "ต้องทดลองก่อน" บางครั้งกลายเป็นข้ออ้างสำหรับการไม่ตัดสินใจ ต้องกำหนด scope ของ experiment ให้ชัด |

## References

1. [Systems Thinking — 4 ประเภทระบบและกรอบ DART (YouTube)](https://youtu.be/mjTgkm-h__M)
2. [Cynefin Framework — Wikipedia](https://en.wikipedia.org/wiki/Cynefin_framework)
3. [A Leader's Framework for Decision Making — Harvard Business Review](https://hbr.org/2007/11/a-leaders-framework-for-decision-making)
4. [Cynefin Framework: Systems Thinking — Umbrex](https://umbrex.com/resources/frameworks/organization-frameworks/cynefin-framework/)
5. [Simple, Complicated, Complex, and Chaotic Systems: The Cynefin Framework — Technical Leadership](https://technicalleadership.pl/blog/069-simple-complicated-complex-and-chaotic-systems-the-cynefin-framework/)
6. [Cynefin Framework Guide — Creately](https://creately.com/guides/understanding-the-cynefin-framework/)

## Key Takeaways

- **4 ประเภทระบบมีวิธี respond ที่แตกต่างกัน** — ใช้วิธีผิดกับ domain ที่ผิดไม่ได้ผล ไม่ว่าจะทำดีแค่ไหน
- **Clear** = Sense-Categorize-Respond → checklist และ best practice
- **Complicated** = Sense-Analyze-Respond → ผู้เชี่ยวชาญและ analysis
- **Complex** = Probe-Sense-Respond → safe-to-fail experiments และ emergent learning
- **Chaotic** = Act-Sense-Respond → stabilize ก่อน แล้วค่อย assess
- **DART** ช่วย classify domain ก่อนตัดสินใจ: Domain clarity, Actor variety, Response options, Time pressure
- **มุมมองภายนอก** (mentor, data, time) จำเป็นเพราะเราประเมิน domain ของระบบที่เราอยู่ใน ได้ไม่แม่นยำ
- **กรอบความคิดในหัวเรา** คือระบบที่ยากแก้ที่สุด — ต้องสร้าง habit ในการตรวจสอบว่า categorize ปัญหาถูก domain ไหม
