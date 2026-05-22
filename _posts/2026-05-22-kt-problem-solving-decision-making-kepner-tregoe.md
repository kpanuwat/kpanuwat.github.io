---
title: "เจาะลึก KT Problem Solving & Decision Making (Kepner-Tregoe Method)"
date: 2026-05-22 00:22:00 +0700
categories: [Engineering]
tags: [problem-solving, decision-making, kepner-tregoe, methodology, management, root-cause-analysis]
---

## TL;DR

Kepner-Tregoe (KT) คือ framework การแก้ปัญหาและตัดสินใจที่พัฒนาในทศวรรษ 1960 โดย Charles Kepner และ Benjamin Tregoe ซึ่งแบ่งกระบวนการคิดออกเป็น 4 ขั้นตอนที่ชัดเจน ได้แก่ Situation Appraisal, Problem Analysis, Decision Analysis, และ Potential Problem Analysis เหมาะสำหรับงานวิศวกรรม, IT, และการผลิต ที่ต้องการ root cause ที่แม่นยำก่อนลงมือแก้ไข

## Background / Why this matters

ในงานวิศวกรรมและอุตสาหกรรม ปัญหาที่พบบ่อยที่สุดไม่ใช่การขาดทักษะ แต่คือการ **กระโดดจากปัญหาไปสู่การแก้ไขเร็วเกินไป** ทีมที่เจอ defect ในสายการผลิตมักเลือก solution แรกที่นึกออก แทนที่จะใช้เวลาตีกรอบปัญหาให้ชัดก่อน ผลคือแก้ผิดจุด เสียเวลา และปัญหาวนกลับมาซ้ำ

Charles Kepner และ Benjamin Tregoe นักวิจัยจาก RAND Corporation ได้ศึกษาในช่วงทศวรรษ 1950–60 ว่าทำไมนักแก้ปัญหาที่ประสบความสำเร็จถึงคิดต่างจากคนอื่น พวกเขาพบว่ากระบวนการคิดที่ **มีโครงสร้าง** และ **แยกแยะประเภทของคำถาม** ออกจากกัน คือหัวใจของการแก้ปัญหาที่ได้ผล ผลงานนี้ถูกตีพิมพ์ใน *The Rational Manager* (1965) และกลายเป็นพื้นฐานของ KT methodology

ความแตกต่างจาก methodology อื่น: KT ไม่ใช่ tool เฉพาะทาง (ต่างจาก FMEA, SPC) แต่เป็น **thinking framework** ที่ช่วยให้ทีมถามคำถามถูกชนิด ในเวลาที่ถูกต้อง

## Deep Dive

### กระบวนการหลัก 4 ขั้นตอน

KT แบ่งสถานการณ์ที่ต้องจัดการออกเป็น 4 ประเภท โดยแต่ละประเภทมีคำถามหลักที่แตกต่างกัน:

| กระบวนการ | คำถามหลัก | ผลลัพธ์ |
|---|---|---|
| **Situation Appraisal (SA)** | เกิดอะไรขึ้น? อะไรสำคัญกว่า? | Priority list + action plan |
| **Problem Analysis (PA)** | ทำไมถึงเกิด? Root cause คืออะไร? | Verified cause |
| **Decision Analysis (DA)** | จะทำอะไร? ตัวเลือกไหนดีที่สุด? | Documented decision + rationale |
| **Potential Problem Analysis (PPA)** | อะไรอาจผิดพลาดในอนาคต? | Preventive actions + contingency |

#### 1. Situation Appraisal (SA) — "What's going on?"

ขั้นแรกคือการ **จัดกลุ่มและ prioritize** ความกังวลหรือ concerns ที่มีอยู่หลายเรื่องพร้อมกัน ซึ่งมักเกิดใน war room หรือตอน incident response

เครื่องมือใน SA:
- **Concern listing** — รวบรวมทุก concern ออกมาก่อน ไม่กรอง
- **Separation** — แยกว่า concern ไหนเป็น problem (มีอยู่แล้ว), decision (ต้องเลือก), หรือ potential problem (ยังไม่เกิด)
- **Priority setting** — ใช้เกณฑ์ urgency, seriousness, growth trend ในการจัดลำดับ

ตัวอย่างในโรงงาน: เครื่องจักร line A หยุดเอง + ของเสียเพิ่ม + supplier ส่งวัตถุดิบล่าช้า — SA ช่วยจัดลำดับว่าจะจัดการอะไรก่อน

#### 2. Problem Analysis (PA) — "Why did this happen?"

นี่คือหัวใจของ KT และจุดที่แตกต่างจาก methodology อื่นมากที่สุด PA ใช้ **IS / IS NOT analysis** เพื่อ narrow down root cause ผ่านการถามว่า "อะไรที่ปัญหา IS และ IS NOT"

**IS / IS NOT worksheet** — ถามใน 4 มิติ:

| มิติ | IS (ที่ปัญหาเกิด) | IS NOT (ที่ปัญหาไม่เกิด) | What's distinct? |
|---|---|---|---|
| **WHAT** (อะไร) | Product A มี defect | Product B ไม่มี | ต่างกันตรงไหน? |
| **WHERE** (ที่ไหน) | เกิดที่ station 3 เท่านั้น | Station 1, 2, 4 ไม่มี | อะไรที่เฉพาะ station 3? |
| **WHEN** (เมื่อไหร่) | เกิดหลัง 14:00 เท่านั้น | ก่อน 14:00 ไม่เกิด | เปลี่ยนอะไรตอน 14:00? |
| **EXTENT** (ขนาด) | ประมาณ 15% ของ lot | ไม่ได้เกิด 100% | ขนาดบ่งบอกอะไร? |

จากนั้น **Distinctions** ที่พบใน IS vs IS NOT จะนำไปสู่ **Possible Causes** → **Most Probable Cause** → **Verification**

> ข้อสำคัญ: KT PA ไม่ได้หา cause จาก brainstorming แต่หาจาก **logical deduction** ผ่านความแตกต่างของ IS vs IS NOT

#### 3. Decision Analysis (DA) — "What should we do?"

เมื่อทราบ root cause แล้ว DA ช่วยเลือก solution ที่ดีที่สุดอย่างมีโครงสร้าง โดยใช้ **KT Decision Matrix**:

**ขั้นตอน DA:**

1. **State the decision** — กำหนดว่าจะตัดสินใจอะไร (เช่น "เลือก ERP vendor ใหม่")
2. **Set objectives** — แยก MUSTS (ต้องมี, non-negotiable) และ WANTS (อยากได้, weighted)
3. **Generate alternatives** — รายการตัวเลือกที่จะประเมิน
4. **Evaluate alternatives** — ตรวจ MUSTS ก่อน (ถ้าไม่ผ่านให้ตัดออก) แล้วให้คะแนน WANTS
5. **Assess adverse consequences** — ทบทวนความเสี่ยงของตัวเลือกที่ได้คะแนนสูงสุด

ตัวอย่าง MUSTS vs WANTS:

| Objective | Type | Weight | Alt A | Alt B |
|---|---|---|---|---|
| ราคา < 2M THB | MUST | — | Pass | Fail → ตัดออก |
| Support ภาษาไทย | MUST | — | Pass | — |
| Implementation time < 6 months | WANT | 9 | 7 | — |
| Local support team | WANT | 7 | 8 | — |
| Weighted score | | | **7×9 + 8×7 = 119** | — |

#### 4. Potential Problem / Opportunity Analysis (PPA/POA) — "What could go wrong?"

PPA เป็น **proactive step** ที่ใช้ก่อนลงมือ implement โดยถามว่า:
- อะไรอาจผิดพลาด? (Potential Problems)
- โอกาสที่จะเกิดมากน้อยแค่ไหน? (Probability)
- ผลกระทบรุนแรงแค่ไหน? (Seriousness)
- จะป้องกันได้อย่างไร? (Preventive Actions)
- ถ้าเกิดขึ้นแล้วจะทำอะไร? (Contingent Actions)

POA (Potential Opportunity Analysis) คือด้านบวก — ใช้แนวทางเดียวกันแต่มองหาโอกาสที่จะขยายผล

### KT vs. Methodologies อื่น

| Methodology | จุดเน้น | เหมาะกับ | ไม่เหมาะกับ |
|---|---|---|---|
| **KT** | Rational thinking process (ทั้ง 4 ประเภทคำถาม) | Complex problems, high-stakes decisions | ปัญหาซ้ำๆ ที่มี SOP แล้ว |
| **5-Why** | Root cause ผ่านการถามซ้ำ | Simple linear causation | Multi-factor problems |
| **8D** | Structured team problem solving + CAPA | Manufacturing defects, customer complaints | ปัญหาที่ยังไม่รู้จะแก้ทีมไหน |
| **FMEA** | Risk prevention ก่อนเกิด | Design/process risk assessment | Post-failure analysis |
| **PDCA** | Continuous improvement cycle | Iterative process improvement | One-time decisions |

KT และ 8D มักทำงานร่วมกันได้ดี: ใช้ KT PA สำหรับ root cause analysis ใน 8D step D4, และ KT DA สำหรับ solution selection ใน D5

### การใช้งานจริงในอุตสาหกรรม

**Manufacturing / EMS:**
- PA สำหรับวิเคราะห์ defect ที่เกิดเป็น intermittent (IS/IS NOT ช่วยมาก เพราะ defect ไม่สม่ำเสมอ)
- DA สำหรับเลือก supplier หรือ equipment
- PPA ก่อน production launch หรือ ECO (Engineering Change Order)

**IT / Service Management:**
- KT เข้ากันได้ดีกับ ITIL Problem Management — PA ใช้ใน root cause investigation ของ incidents ที่ซ้ำ
- DA ใช้เลือก architecture หรือ technology stack

**Healthcare:**
- PA ใช้ใน clinical troubleshooting และ medication error analysis
- PPA ใช้ใน patient safety planning และ surgical checklist

## User Guide (Step-by-Step)

### วิธีทำ IS / IS NOT Analysis (ขั้นตอนที่ใช้บ่อยที่สุด)

**สิ่งที่ต้องเตรียม:** whiteboard หรือ spreadsheet, ทีม 3-6 คน, ข้อมูล/ข้อเท็จจริงเกี่ยวกับปัญหา

**Step 1: Define the problem statement**
ระบุให้ชัดว่า "object" (อะไร) มี "deviation" (ปัญหาอะไร)
ตัวอย่าง: "PCB Assembly Line B — solder joint open rate 15% (ปกติ <0.5%)"

**Step 2: สร้าง IS / IS NOT worksheet**
วาดตาราง 4 แถว (WHAT, WHERE, WHEN, EXTENT) × 3 คอลัมน์ (IS, IS NOT, Distinctions)

**Step 3: Fill IS column ด้วย factual observations เท่านั้น**
ห้าม inference หรือ assumption — ใช้ข้อมูลที่วัดได้หรือสังเกตได้จริง

**Step 4: Fill IS NOT column**
ถามว่า "อะไรที่ comparable แต่ไม่มีปัญหา" เช่น เส้น WHAT IS = PCB model X → IS NOT = PCB model Y, Z ที่ใช้สายเดียวกัน

**Step 5: Identify Distinctions**
ทุกคู่ IS vs IS NOT → ถาม "อะไรที่แตกต่าง?" บันทึกไว้

**Step 6: Generate Possible Causes**
แต่ละ distinction → "ถ้าสิ่งนี้เป็นสาเหตุ มันจะ explain ทั้ง IS และ IS NOT ได้ไหม?"

**Step 7: Test Most Probable Cause**
เลือก cause ที่ explain ได้ดีที่สุด → verify ด้วยการทดสอบ (confirm สาเหตุ, แก้ชั่วคราว, สังเกตผล)

**Step 8: Document ผล**
บันทึก verified cause + corrective action + ใครทำอะไร ภายในเมื่อไหร่

### Template ฟรีที่ใช้ได้

- KT official templates: [kepner-tregoe.com](https://www.kepner-tregoe.com)
- Toolshero มี template และ step-by-step guide ฟรี: [toolshero.com/problem-solving/kepner-tregoe-method](https://www.toolshero.com/problem-solving/kepner-tregoe-method/)

## Caveats / Limits

**เวลาและทรัพยากร:** KT เต็มรูปแบบใช้เวลา เหมาะกับปัญหาที่ cost ของการแก้ผิดสูง ไม่ใช่ปัญหาเล็กน้อยที่แก้ได้ใน 5 นาที

**Bias ใน IS / IS NOT:** ถ้าทีมเลือก IS NOT ที่ไม่ comparable จะได้ distinctions ที่ไม่มีประโยชน์ — ต้องระวังการเลือก comparison set

**ไม่มี root cause analysis สำหรับ complex systems:** KT PA เหมาะกับปัญหาที่มี single root cause ชัดเจน สำหรับ complex system failures (เช่น distributed IT incidents) อาจต้องใช้ร่วมกับ fault tree analysis

**ต้องการ facilitator ที่มีประสบการณ์:** KT workshop ที่ดีต้องการคนที่รู้จัก method จริงๆ มิฉะนั้นทีมจะเข้าสู่ speculation แทนที่จะยึด IS/IS NOT กับข้อเท็จจริง

**ค่า certification:** KT training และ certification มีค่าใช้จ่ายสูง (corporate training) — สำหรับ self-study ใช้ *The Rational Manager* หรือ Toolshero เป็นจุดเริ่มต้น

**ไม่ใช่ silver bullet:** KT เป็น framework คิด ไม่ใช่เครื่องมือที่จะให้ answer อัตโนมัติ ความถูกต้องของผลขึ้นอยู่กับคุณภาพของ data ที่ใส่เข้าไป

## References

1. Kepner, C.H. & Tregoe, B.B. (1965). *The Rational Manager: A Systematic Approach to Problem Solving and Decision Making*. McGraw-Hill.
2. Toolshero — Kepner Tregoe Method of Problem Solving: [https://www.toolshero.com/problem-solving/kepner-tregoe-method/](https://www.toolshero.com/problem-solving/kepner-tregoe-method/)
3. Wikipedia — Kepner–Tregoe matrix: [https://en.wikipedia.org/wiki/Kepner%E2%80%93Tregoe_matrix](https://en.wikipedia.org/wiki/Kepner%E2%80%93Tregoe_matrix)
4. Kepner-Tregoe Official — Problem Solving and Decision Making: [https://www.kepner-tregoe.com/what-we-do/problem-solving-and-decision-making/](https://www.kepner-tregoe.com/what-we-do/problem-solving-and-decision-making/)
5. Businessmap — Kepner-Tregoe Method: [https://businessmap.io/lean-management/improvement/kepner-tregoe](https://businessmap.io/lean-management/improvement/kepner-tregoe)

## Key Takeaways

- KT แบ่งการคิดออกเป็น 4 ประเภทที่ไม่ควรปนกัน: SA (จัด priority), PA (หา root cause), DA (ตัดสินใจ), PPA (ป้องกันอนาคต)
- IS / IS NOT Analysis คือหัวใจของ PA — ใช้ distinctions ระหว่าง "ที่ปัญหาเกิด" vs "ที่ไม่เกิด" เพื่อ narrow down สาเหตุ โดยไม่ต้องพึ่ง intuition
- Decision Analysis แยก MUSTS (pass/fail) ออกจาก WANTS (weighted score) ก่อนประเมิน alternatives เสมอ
- KT เสริมกับ 8D, ITIL, และ Six Sigma ได้ดี — ไม่ใช่คู่แข่ง แต่เป็น thinking layer ที่อยู่ด้านบน
- Potential Problem Analysis (PPA) คือ tool ที่มักถูกข้ามมากที่สุด แต่มีคุณค่าสูงก่อน production launch หรือ system change
- ประสิทธิภาพของ KT ขึ้นอยู่กับคุณภาพ data ใน IS column — garbage in, garbage out เหมือนกัน
- เริ่มต้นได้ทันทีโดยไม่ต้อง certify: ลองทำ IS/IS NOT worksheet ครั้งถัดไปที่มี defect หรือ incident ซ้ำๆ
