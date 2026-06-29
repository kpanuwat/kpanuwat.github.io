---
title: "Industry 1.0 ถึง 5.0: เจาะลึกวิวัฒนาการอุตสาหกรรม"
date: 2026-06-29 00:01:00 +0700
categories: [Research]
tags: [industry, manufacturing, iot, ai, digital-transformation, industry-4-0, industry-5-0, history]
image:
  path: /assets/images/industry-1-to-5-deep-dive-cheatsheet.png
  alt: Industry 1.0 to 5.0 evolution cheatsheet
---

## TL;DR

วิวัฒนาการอุตสาหกรรม 5 ยุค — จากเครื่องจักรไอน้ำสู่ AI + มนุษย์ทำงานร่วมกัน — ไม่ใช่การแทนที่กัน แต่เป็นการ **ซ้อนทับกันเป็นชั้นๆ** โรงงานส่วนใหญ่ในปัจจุบันยังรันหลาย era พร้อมกันบนสายการผลิตเดียว

## Background / Why this matters

การปฏิวัติอุตสาหกรรมแต่ละยุคไม่ได้เกิดขึ้นแบบ "กดปุ่มเปลี่ยน" แต่เป็นกระบวนการสะสมเทคโนโลยีที่ค่อยๆ เปลี่ยน **วิธีที่มนุษย์ใช้พลังงาน, จัดการข้อมูล, และจัดสรรแรงงาน** ใหม่ทั้งหมด

ทำไมถึงต้องรู้ Industry 1.0–5.0? เพราะ:
- นักพัฒนา, วิศวกร, และ product manager ที่เข้าใจ context นี้จะตัดสินใจได้ดีกว่าว่าเทคโนโลยีใดเหมาะกับ domain ไหน
- ประเทศไทยกำลังอยู่ใน **crossroads ระหว่าง Industry 3.0 และ 4.0** (นโยบาย Thailand 4.0) ขณะที่ภาคการผลิตบางส่วนยังอยู่ระดับ 2.0
- คำว่า "Industry 4.0" และ "Industry 5.0" ถูกใช้ในวงการ marketing บ่อยมาก แต่นิยามที่แท้จริงมีความเฉพาะและวัดได้

ความเข้าใจผิดที่พบบ่อยที่สุด: **เชื่อว่าแต่ละ era แทนที่กันสมบูรณ์** ความจริงคือโรงงานทั่วไปในยุโรปและเอเชียยังมีเครื่องจักรจาก era ที่ต่างกันทำงานบนสายการผลิตเดียวกัน เช่น เครื่องกด (1987, Industry 2.0) + เครื่อง CNC (2003, Industry 3.0) + IoT gateway ใหม่ (2024, Industry 4.0)

## Deep Dive

### Industry 1.0 — ยุคเครื่องจักรไอน้ำ (ค.ศ. 1760–1840)

**แรงผลักดันหลัก**: ถ่านหิน + ไอน้ำ → แทนที่แรงงานมนุษย์และสัตว์

| สิ่งประดิษฐ์สำคัญ | ปี | ผลกระทบ |
|---|---|---|
| Spinning Jenny | 1764 | ปั่นด้ายได้ 8 เส้นพร้อมกัน (เดิม 1 เส้น) |
| Steam engine (Watt) | 1769 | พลังงานไอน้ำแบบหมุนเวียนได้ |
| Power loom | 1785 | ทอผ้าด้วยเครื่อง แทนมือ |
| Steam locomotive | 1804 | ขนส่งวัตถุดิบ + สินค้าข้ามพื้นที่ |

**ลักษณะเด่น**:
- การผลิตย้ายจากบ้านสู่โรงงาน (Factory System)
- อุตสาหกรรมสิ่งทอ, การทำเหมือง, และการผลิตเหล็กเป็นแกนหลัก
- แรงงานเด็กและชั่วโมงทำงาน 16 ชั่วโมง/วันเป็นเรื่องปกติ
- เริ่มในอังกฤษ แพร่ไปยุโรปและอเมริกาเหนือภายใน 50 ปี

**เทคโนโลยีควบคุม**: ไม่มี — ทักษะอยู่ที่ช่าง (Craftsman) และการออกแบบกลไกล้วนๆ

---

### Industry 2.0 — ยุคไฟฟ้าและสายการผลิต (ค.ศ. 1870–1914)

**แรงผลักดันหลัก**: ไฟฟ้า + สายการผลิต (Assembly Line) → ผลิตได้มากขึ้น ถูกลง เร็วขึ้น

| เหตุการณ์สำคัญ | ปี | ผลกระทบ |
|---|---|---|
| Edison ประดิษฐ์หลอดไฟ | 1879 | โรงงานทำงานกลางคืนได้ |
| Ransom Olds: สายการผลิตรถยนต์แรก | 1901 | เวลาประกอบรถลดจาก 12.5 ชั่วโมง → ทดลองได้จริง |
| Ford Model T + Moving Assembly Line | 1913 | ผลิตรถยนต์ได้ทุก 93 นาที |
| เครื่องยนต์สันดาปภายใน | ปลาย 1800s | แทนไอน้ำในยานพาหนะ |

**ลักษณะเด่น**:
- **Standardization**: ชิ้นส่วนที่เปลี่ยนได้ (Interchangeable parts) ทำให้ซ่อมแซมง่าย
- **Mass production**: ต้นทุนต่อหน่วยลดฮวบ → ของฟุ่มเฟือยกลายเป็นของใช้ทั่วไป
- เครือข่ายรถไฟและโทรเลขเชื่อมห่วงโซ่อุปทาน (Supply chain) ระดับทวีป
- เกิด **แรงงานสัมพันธ์** (Labor unions) และกฎหมายแรงงานครั้งแรก

**เทคโนโลยีควบคุม**: ไฟฟ้า + กลไก (ยังไม่มีคอมพิวเตอร์)

---

### Industry 3.0 — ยุค Digital และ Automation (ค.ศ. 1960s–2000s)

**แรงผลักดันหลัก**: Transistor → Microprocessor → PLC → คอมพิวเตอร์ → Internet เบื้องต้น

| เทคโนโลยีสำคัญ | ปี | ผลกระทบในโรงงาน |
|---|---|---|
| PLC (Programmable Logic Controller) แรก | 1968 (Modicon 084) | แทนวงจร relay กล่องใหญ่ด้วยโปรแกรม |
| หุ่นยนต์อุตสาหกรรม (Unimate) | 1961 | งาน welding อันตรายทำโดยหุ่นยนต์ |
| Microprocessor Intel 4004 | 1971 | คอมพิวเตอร์ราคาถูกลง 1,000 เท่า |
| CAD/CAM Software | 1970s–80s | ออกแบบชิ้นส่วนบนคอมพิวเตอร์แล้วผลิตอัตโนมัติ |
| ERP Systems | 1990s | จัดการทรัพยากรองค์กรทั้งหมดจากระบบเดียว |

**ลักษณะเด่น**:
- **Partial automation**: บางขั้นตอนอัตโนมัติ บางขั้นตอนยังต้องใช้มนุษย์
- **Just-In-Time (JIT)**: Toyota Production System ลด waste ในสต็อก
- คอมพิวเตอร์เปลี่ยนจาก mainframe ล้านบาท → PC หมื่นบาท
- เริ่มมี **network ภายใน (LAN)** แต่ยังไม่ได้เชื่อมกับ Internet สาธารณะ
- Thailand: อุตสาหกรรมยานยนต์ (Toyota, Honda) และ Electronics ในนิคมฯ เป็นตัวอย่างหลักของ Industry 3.0 ในไทย

**เทคโนโลยีควบคุม**: PLC + SCADA (Supervisory Control and Data Acquisition)

---

### Industry 4.0 — ยุค Smart Manufacturing (ค.ศ. 2010s–ปัจจุบัน)

**แรงผลักดันหลัก**: IoT + Cloud + AI + Cyber-Physical Systems → โรงงานที่ "รู้" และ "ตัดสินใจ" ได้เอง

คำว่า **"Industry 4.0"** ถูกบัญญัติอย่างเป็นทางการในงาน **Hannover Messe ปี 2011** โดย German government initiative เพื่อเป็น national strategy

**เทคโนโลยีแกน (Core technologies)**:

```
โรงงาน Industry 4.0
├── Cyber-Physical Systems (CPS)
│   ├── เซนเซอร์ฝังในเครื่องจักรทุกชิ้น
│   └── Digital Twin (แบบจำลองดิจิทัลของโรงงานจริง)
├── Industrial IoT (IIoT)
│   ├── OPC UA (มาตรฐานการสื่อสารระหว่างเครื่องจักร)
│   └── MQTT (โปรโตคอลส่งข้อมูล lightweight)
├── Cloud + Edge Computing
│   ├── AWS IoT / Azure IoT Hub
│   └── Edge: ประมวลผลที่เครื่องจักรโดยตรง
├── AI / Machine Learning
│   ├── Predictive Maintenance (แจ้งก่อนเสีย)
│   └── Quality Control (ตรวจสอบของเสียด้วย Vision AI)
└── MES (Manufacturing Execution System)
    └── เชื่อม ERP ↔ เครื่องจักรแบบ real-time
```

**ตัวอย่าง use case จริง**:
- **Predictive Maintenance**: วิเคราะห์ vibration + temperature ของมอเตอร์ → แจ้งเตือนก่อนเสีย 2 สัปดาห์ → ลด unplanned downtime 40–50%
- **Digital Twin**: Siemens ใช้ digital twin ของโรงงาน Amberg ทดสอบ layout ใหม่บน simulation ก่อนก่อสร้างจริง
- **Autonomous Mobile Robots (AMR)**: Amazon ใช้ Kiva robot 750,000+ ตัวในคลังสินค้าทั่วโลก

**มาตรวัด "Industry 4.0 จริง" (5 เกณฑ์)**:
1. เครื่องจักรส่งข้อมูลอัตโนมัติ (counts, states, timestamps) ไม่ต้อง manual entry
2. ดึงข้อมูลโดยไม่ต้องมีคนกรอก
3. ข้อมูลเชื่อมกับ context (orders, products, shifts)
4. ข้อมูลทริกเกอร์การตัดสินใจอัตโนมัติ
5. architecture ไม่ขึ้นกับ equipment generation ใดๆ

---

### Industry 5.0 — ยุคมนุษย์-AI ทำงานร่วมกัน (ค.ศ. 2020s+)

**จุดเริ่มต้นทางนโยบาย**: European Commission เผยแพร่ white paper **"Industry 5.0 — Towards a Sustainable, Human-Centric and Resilient European Industry"** ในเดือนมกราคม 2021

> "Industry 5.0 places the well-being of the worker at the centre of the production process" — European Commission

**3 เสาหลักของ Industry 5.0**:

| เสาหลัก | คำอธิบาย | ตัวอย่างเทคโนโลยี |
|---|---|---|
| **Human-Centric** | คนอยู่ศูนย์กลาง ไม่ใช่ประสิทธิภาพอย่างเดียว | Cobots, Exoskeleton, Adaptive HMI |
| **Sustainable** | ผลิตโดยไม่ทำลายทรัพยากร | Circular economy, Green manufacturing, AI energy optimization |
| **Resilient** | รับมือกับวิกฤตได้ (COVID-19 เป็น wake-up call) | Supply chain diversification, Local production |

**Cobots (Collaborative Robots)** คือสัญลักษณ์หลักของ Industry 5.0:
- ทำงานข้างมนุษย์โดยตรง ไม่ต้องใช้ cage กั้น
- มี force sensor ตรวจจับการสัมผัสและหยุดทันที
- ตัวอย่าง: Universal Robots UR10, ABB YuMi, Fanuc CRX

**ความแตกต่างจาก Industry 4.0**:

| | Industry 4.0 | Industry 5.0 |
|---|---|---|
| เป้าหมายหลัก | ประสิทธิภาพ + ลดต้นทุน | มนุษย์ + สังคม + โลก |
| มองจาก | Shareholder value | Stakeholder value |
| บทบาทมนุษย์ | ลด (automate ออก) | เพิ่ม (amplify ด้วย AI) |
| ความยั่งยืน | Optional | Core requirement |

**ข้อควรระวัง**: Industry 5.0 ยังเป็นแนวคิด (vision) มากกว่า standard ที่วัดได้ในระดับ Industry 4.0 นักวิจารณ์บางส่วนมองว่าเป็น "marketing reframe" มากกว่าการปฏิวัติใหม่จริงๆ

---

### ภาพรวม: โรงงานในปัจจุบันอยู่ยุคไหน?

ความเป็นจริงที่มักถูกมองข้าม: **โรงงานทั่วโลกส่วนใหญ่ยังรัน multi-era พร้อมกัน**

```
ตัวอย่างสายการผลิตจริง (โรงงาน mid-size ยุโรป):
[เครื่องกด ปี 1987] ─── Industry 2.0
       +
[เครื่อง CNC ปี 2003] ─ Industry 3.0
       +
[IoT Gateway ปี 2024] ── Industry 4.0
       │
       └─ Cloud Dashboard → Predictive Maintenance AI
```

Thailand context:
- **SMEs ส่วนใหญ่**: อยู่ระหว่าง Industry 2.0–3.0
- **Tier-1 automotive (Toyota, Honda, Isuzu)**: กำลังเปลี่ยนผ่านสู่ Industry 4.0
- **Electronics/Semiconductor (WD, Seagate)**: อยู่ระดับ Industry 3.0–4.0
- **นโยบาย Thailand 4.0**: เน้น Bio-Circular-Green Economy + Smart City ควบคู่กับ digital manufacturing

## Caveats / Limits

- **ไม่มีมาตรฐานสากลที่วัด "level" ของโรงงาน** — การเรียก Industry 4.0 บางครั้งเป็นแค่ marketing
- **Industry 5.0 ยังไม่มี ISO/IEC standard** — ต่างจาก Industry 4.0 ที่มี OPC UA (IEC 62541), ISA-95, IEC 62443
- **Digital Divide**: ประเทศกำลังพัฒนาส่วนใหญ่ยังข้าม 3.0 ไปไม่พ้น การกระโดดสู่ 4.0 ต้องการ infrastructure (bandwidth, cloud, talent) ที่อาจยังไม่พร้อม
- **ต้นทุน transition**: IIoT gateway + cloud subscription + retraining cost ไม่ใช่ cost ต่ำ — ROI อาจใช้เวลา 3–7 ปี
- **Cybersecurity**: การเชื่อม OT (Operational Technology) กับ IT network ทำให้โรงงานกลายเป็น attack surface — Colonial Pipeline hack (2021) เป็นตัวอย่างที่เจ็บปวด

## References

1. European Commission — [Industry 5.0: Towards a Sustainable, Human-Centric and Resilient European Industry](https://research-and-innovation.ec.europa.eu/research-area/industrial-research-and-innovation/industry-50_en) (January 2021)
2. Symestic — [Industry 1.0 to 5.0: What's Marketing, What's Real](https://www.symestic.com/en-us/what-is/industry-1.0-to-5.0)
3. Automation Ready Panels — [Industrial Revolution: From Industry 1.0 to Industry 4.0](https://www.automationreadypanels.com/plc-systems/industrial-revolution-from-industry-1-0-to-industry-4-0/)
4. KFactory — [Short history of manufacturing: from Industry 1.0 to Industry 4.0](https://kfactory.eu/the-industrial-revolution-short-history-of-manufacturing/)
5. Sustainability Success — [Industry 1.0 to 4.0 – Brief History of the Industrial Revolution](https://sustainability-success.com/industry-1-0-to-4-0-2-3-revolution/)
6. NeuroNomixer — [Industry 5.0 Explained: Why the Future Is Human-Centred](https://www.neuronomixer.com/blog/explainable-ai-risk-responsible-systems/industry-50-explained-why-the-future-is-human-centred-not-just-automated)
7. Britannica — [Industrial Revolution](https://www.britannica.com/event/Industrial-Revolution)

## Key Takeaways

- **5 ยุค ≠ 5 ขั้นบันได** — โรงงานส่วนใหญ่รัน multi-era บนสายการผลิตเดียว ไม่ใช่การแทนที่กัน
- **Industry 1.0**: ไอน้ำ → mechanization (1760–1840, อังกฤษ)
- **Industry 2.0**: ไฟฟ้า + assembly line → mass production (1870–1914, Ford 1913)
- **Industry 3.0**: PLC + คอมพิวเตอร์ → partial automation (1960s–2000s)
- **Industry 4.0**: IoT + AI + Cloud → smart manufacturing (2011–ปัจจุบัน) — มาตรวัดจริงคือ data flows อัตโนมัติ 5 ข้อ
- **Industry 5.0**: มนุษย์ + Cobot + sustainability เป็น core (EU white paper 2021) — ยังเป็น vision มากกว่า standard
- **Thailand context**: ส่วนใหญ่อยู่ช่วง 2.0–3.0 transition; automotive tier-1 กำลังเดิน 4.0; นโยบาย Thailand 4.0 คือ strategic direction
- **Cybersecurity** คือ blind spot ที่ใหญ่ที่สุดของ Industry 4.0 — การเชื่อม OT+IT สร้าง attack surface ใหม่
