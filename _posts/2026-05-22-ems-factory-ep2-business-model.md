---
title: "เจาะลึก EMS Factory EP2: Business Model & Value Chain"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [ems, manufacturing, business-model, value-chain, oem, odm, turnkey]
series: ems-factory
---

{% include series-nav.html %}

## TL;DR

EMS, OEM, ODM ต่างกันที่ "ใครเป็นเจ้าของ design และ IP" ไม่ใช่ว่าใครผลิต การเลือก manufacturing model (turnkey vs consignment vs hybrid) ส่งผลโดยตรงต่อ cash flow, supply chain risk, และ margin ของ OEM ส่วน EMS tier-1 อย่าง Foxconn มี market share >40% แต่ operating margin เพียง ~2.5% — ขณะที่ Celestica และ Sanmina มี margin 6%+ จากการเลือก high-mix และ JDM segments

## Background / Why This Matters

ก่อนที่จะเจาะลึกเรื่อง process control หรือ quality system ใน EP ถัดๆ ไป สิ่งที่สำคัญกว่าคือการเข้าใจก่อนว่า "EMS factory ทำเงินอย่างไร และ OEM เข้าหา EMS ด้วย relationship model แบบใด"

หลายคนสับสนระหว่าง OEM, ODM, และ EMS เพราะทั้งสามโมเดลล้วนเกี่ยวข้องกับ "การผลิต electronics" แต่ความแตกต่างที่แท้จริงอยู่ที่ว่า **ใครเป็นเจ้าของ design IP** และ **ใครรับความเสี่ยงของ supply chain**

ความเข้าใจเรื่อง business model นี้สำคัญมากสำหรับ OEM ที่กำลังเลือก EMS partner เพราะ:
- ถ้าเลือกผิด model → capital อาจถูก lock ใน inventory โดยไม่จำเป็น
- ถ้าไม่ตรวจ IP clause ใน contract → design อาจถูก leverage โดย EMS กับ competitor ได้
- ถ้าไม่เข้าใจ margin structure ของ EMS → คาดหวัง service level ผิดจากความเป็นจริง

## Deep Dive

### OEM vs ODM vs EMS: IP Ownership คือ Core Differentiator

ตารางด้านล่างสรุปความแตกต่างที่สำคัญ [1, 2, 3]:

| Model | ใครออกแบบ | ใครเป็นเจ้าของ IP | ใครผลิต | Sold Under |
|-------|-----------|-------------------|---------|-----------|
| **OEM** | Brand owner | Brand owner | EMS/CM | Brand's label |
| **ODM** | Manufacturer | Manufacturer | Manufacturer | Multiple brands |
| **EMS/CEM** | Brand owner | Brand owner | EMS | Brand's label |

**OEM (Original Equipment Manufacturer)**
ในความหมายที่ถูกต้อง OEM คือ brand owner ที่ออกแบบ product, เป็นเจ้าของ IP ทั้งหมด และ outsource การผลิตให้ EMS [1] ตัวอย่าง: Apple (OEM) → Foxconn (EMS ที่ผลิต)

**ODM (Original Design Manufacturer)**
ODM ออกแบบและผลิตเอง — ลูกค้าซื้อ design สำเร็จรูปมา label แบรนด์ตัวเอง IP เป็นของ ODM ไม่ใช่ของ brand [2, 3] เหมาะสำหรับ startups ที่ต้องการ speed-to-market โดยไม่มี design capability

**EMS (Electronics Manufacturing Services)**
EMS ผลิตตาม spec ของ OEM — IP ของ product ยังเป็นของ OEM ทั้งหมด EMS แค่ execute กระบวนการผลิต [1, 2] นี่คือ model ที่ทำให้ OEM ควบคุม design และ brand ได้เต็มที่

**CEM, CM** เป็นคำที่ใช้แทนกันกับ EMS ในหลายบริบท — ความหมายไม่ต่างกันนัก

**เมื่อไหร่ควรเลือกแบบไหน [3]:**
- **EMS**: มี design แล้ว, ต้องการ manufacturing scale + QMS, ต้องการ IP ownership เต็ม
- **ODM**: ต้องการ fast market entry, ยอมรับว่า ODM อาจขาย design เดียวกันให้ competitor
- **Hybrid**: supply proprietary firmware/module แต่ให้ EMS ออกแบบ standard subsystems

### Manufacturing Models: Turnkey, Consignment, Hybrid

เมื่อ OEM ตัดสินใจใช้ EMS แล้ว ยังต้องเลือก manufacturing model ว่าจะให้ EMS รับผิดชอบ supply chain มากน้อยแค่ไหน [4, 5, 6]:

**1. Turnkey Model**

EMS จัดการทุกอย่าง: component sourcing, incoming inspection, assembly, test, packaging

| ข้อดี | ข้อเสีย |
|-------|---------|
| OEM ลด CapEx + working capital | EMS อาจ markup component บาง items |
| EMS มี volume leverage → ราคา component ดีกว่า | OEM มีอำนาจควบคุม supplier น้อยลง |
| Shortage + obsolescence risk ตกไปอยู่ที่ EMS | ยาก enforce preferred vendor list บาง component |
| Cash flow ดีขึ้น — จ่ายตาม PO สำเร็จ | ต้องตรวจสอบ component quality อย่างเข้มงวด |

ราคา turnkey: ~$20–80 per board สำหรับ production runs ขนาดเล็ก [5]

**2. Consignment Model**

OEM จัดหา component ทั้งหมดก่อน, ส่งไปให้ EMS เพื่อ assembly เท่านั้น

| ข้อดี | ข้อเสีย |
|-------|---------|
| OEM ควบคุม supplier และ component quality โดยตรง | ต้องมี procurement team + supplier relationships |
| ราคา assembly ต่ำกว่า (จ่ายแค่ labor) | ต้องแบก inventory risk เอง |
| Transparent component pricing | Admin overhead สูง (หลาย PO) |
| ปกป้อง proprietary component sourcing | Supply chain disruption ตกอยู่ที่ OEM |

ราคา consignment (labor only): ~$5–25 per board [5]

**3. Hybrid Model**

OEM supply proprietary หรือ sensitive components (เช่น firmware chip, custom IC, display module), EMS source standard components (passive components, connectors, standard MCU)

เหมาะสำหรับ: automotive tier-1 ที่ต้องการปกป้อง EE architecture แต่ยังต้องการ EMS scale สำหรับ commodity parts [7]

**Decision Matrix:**

```
Startup, ไม่มี procurement team      → Turnkey (จ่ายเพิ่มนิด แต่ลด overhead มาก)
มี procurement ดีอยู่แล้ว, volume ใหญ่ → Consignment หรือ Hybrid
Proprietary IP บาง component          → Hybrid (supply ส่วน sensitive เอง)
High-reliability product (medical/defense) → Hybrid หรือ Turnkey + Approved Vendor List
```

### ตลาด EMS: ขนาด, Tier Structure, และ Key Players

**Market Size [7]:**
- Global EMS market: ~$578B (2024) → projected $663B (2026) → $909B (2031)
- CAGR 6.51% (2026–2031)
- Total electronics assembly (OEM+EMS+ODM combined): ~$1.6T (2024) → projected ~$2.2T (2029)
- Consumer electronics: ~42% ของ 2024 EMS revenue (largest segment)
- Automotive: growing 8.27% CAGR — driven by EV electronics demand

**Tier Structure [7, 8]:**

| Tier | Characteristics | ตัวอย่าง |
|------|----------------|---------|
| **Tier 1** | Multi-billion USD, global footprint, high-volume | Foxconn, Jabil, Flex, Pegatron |
| **Tier 2** | Regional scale, mid-volume, some specialization | Celestica, Sanmina, Benchmark |
| **Tier 3** | Local/niche, high-mix low-volume, specialized | Regional EMS, medical/defense focused |

Top 5 tier-1 vendors ควบคุม 35–40% ของ total EMS market revenue [8]

**Key Players (2024) [7, 8, 9]:**
- **Foxconn** (Hon Hai): revenue ~$208B, market share >40% ของ EMS segment — dominant ใน consumer electronics + AI servers
- **Jabil**: revenue ~$32–35B — pivoting toward AI data centers + healthcare
- **Flex Ltd.**: revenue ~$24.5B — focus on automotive + industrial
- **Celestica**: มี operating margin สูงกว่า average — JDM + AI compute infrastructure
- **Sanmina**: specializes ใน high-reliability industrial + medical

### Margin Profile: ใครได้กำไรจาก EMS จริงๆ

นี่คือส่วนที่ counter-intuitive ที่สุดใน EMS industry [8, 9]:

| Company | Operating Margin | Strategy |
|---------|-----------------|---------|
| Foxconn | ~2.5% | Pure volume, cost leadership, consumer electronics |
| Pegatron | ~1.5% | Volume play, Apple-dependent |
| Flex | ~4.2% | High-mix complexity + automotive |
| Jabil | ~3.5–4.5% | Diversified: healthcare + AI infrastructure |
| Celestica | ~6.0–6.5% | JDM + AI/ML compute, hyperscaler programs |
| Sanmina | ~6.0% | High-reliability industrial + medical |

**Consumer-grade gross margins อาจต่ำกว่า 6%** สำหรับ commodity assembly [7, 8]

**Pattern ที่ชัดเจน: Specialization → Higher Margin**
- Volume + commodity = margin compression → Foxconn/Pegatron model
- High-mix + regulated industries (medical, aerospace, defense) = 15–25% pricing premium [7]
- JDM (Joint Design and Manufacturing) + AI infrastructure = Celestica's winning formula

**Implication สำหรับ OEM:** EMS ที่รับทำ consumer electronics volume ใหญ่ๆ อาจไม่ have incentive ที่จะ dedicate resources ให้ OEM เล็กๆ — ต้องเลือก EMS tier ที่ business model ของเขา match กับ product type ของคุณ

### Revenue Drivers และ Cost Structure

**Revenue Drivers หลักของ EMS [7]:**
1. **Automotive electronics** — 8.27% CAGR จาก EV power management, ADAS, battery systems
2. **AI server infrastructure** — Celestica, Foxconn แข่งกันใน hyperscaler programs
3. **Medical devices** — 15–25% pricing premium จาก regulatory requirements
4. **Industrial IoT** — high-mix, long lifecycle products

**Cost Structure (% ของ revenue โดยประมาณ) [4, 10]:**

```
Components / Materials:    60–75%  ← dominant cost driver
Labor:                     10–15%
Manufacturing overhead:     8–12%
G&A + Sales:                3–5%
Operating margin:           2–7%   (depends on tier + segment)
```

**Key Cost Risks:**
- **Component spot price volatility** — ถ้า EMS ไม่มี long-term allocation contracts อาจ margin crush ได้ทันที [10]
- **NRE (Non-Recurring Engineering) fees** — first-run setup, tooling, custom test development คิดแยก ไม่รวมใน unit price
- **Rush order premium** — มักสูงถึง 20–50% เหนือ standard lead time [5]
- **FX exposure** — EMS ที่มี global footprint รับ revenue ใน USD แต่จ่าย labor/utilities ใน local currency

## Caveats / Limits

**ODM IP Risk ที่มักถูกมองข้าม**  
ถ้าใช้ ODM แล้ว IP ของ design อยู่กับ ODM — ถ้า business relationship เปลี่ยน ODM อาจ license design ให้ competitor ได้ ต้องมี contractual protection และ audit rights ก่อน commit

**Turnkey ไม่ได้ "ราคาถูกกว่า" เสมอไป**  
Turnkey markup ที่ EMS เพิ่มใน component บางตัวอาจสูงกว่าที่ OEM จะซื้อเองได้ โดยเฉพาะถ้า OEM มี scale ใหญ่และมี supplier relationships อยู่แล้ว

**Market Share ≠ Best Fit**  
Foxconn มี >40% market share แต่ operating margin ~2.5% — นั่นหมายความว่า incentive structure ของเขา optimize สำหรับ high-volume consumer electronics ไม่ใช่ high-mix industrial ถ้า product ของคุณเป็น low-volume high-complexity ควรพิจารณา tier-2/3 ที่ business model match กว่า

**EMS tier hierarchy ไม่ได้ตายตัว**  
Celestica ถือว่า tier-2 แต่มี margin สูงกว่า tier-1 อย่าง Flex เพราะเลือก segment ต่างกัน — tier classification ควรใช้เป็น proxy ของ volume/scale ไม่ใช่ quality หรือ profitability

## References

1. [OEM vs ODM vs EMS Explained: Complete B2B Manufacturing Guide — GT Setu](https://gtsetu.com/blogs/oem-vs-odm-vs-ems-explained/)
2. [Understanding ODM, OEM, and EMS Key Manufacturing Models — SILKBRIDGE](https://www.silkbridgeltd.com/understanding-odm-oem-and-ems-key-manufacturing-models-in-electronics-and-product-design/)
3. [EMS vs ODM vs CM: What's the Right Manufacturing Model? — SVTronics](https://svtronics.com/ems-vs-odm-vs-cm-whats-the-right-model-for-your-product-stage/)
4. [OEM, EMS, CEM, ODM, CMO: What's the difference and why does it matter? — Escatec](https://www.escatec.com/blog/define-oem-ems-cem-odm)
5. [Consignment Manufacturing vs. Turnkey PCB Manufacturing: Pros and Cons — Dynamic Source Mfg](https://dynamicsourcemfg.com/consignment-manufacturing-turnkey-pcb-manufacturing/)
6. [Turnkey vs Consigned Manufacturing for High-Reliability Electronics — EST](https://est.com/turnkey-electronics-manufacturing-when-and-why-its-the-right-choice/)
7. [Electronics Manufacturing Services Market Size & Share Analysis 2031 — Mordor Intelligence](https://www.mordorintelligence.com/industry-reports/electronics-manufacturing-services-market)
8. [Competitive Landscape of Celestica — CanvasBusinessModel](https://canvasbusinessmodel.com/blogs/competitors/celestica-competitive-landscape)
9. [Competitive Landscape of Jabil Circuit — MatrixBCG](https://matrixbcg.com/blogs/competitors/jabil)
10. [OEM spend v. EMS product pricing models — VentureOutsource](https://ventureoutsource.com/contract-manufacturing/benchmarks-best-practices/electronics-assembly/product-pricing-model)
11. [Electronics manufacturing services — Wikipedia](https://en.wikipedia.org/wiki/Electronics_manufacturing_services)

## Key Takeaways

- **OEM vs ODM vs EMS แยกกันที่ IP ownership** — EMS รักษา IP ไว้ที่ OEM, ODM ถือ IP เอง — ต้องดู contract clause ก่อน commit
- **Turnkey สะดวกกว่า แต่แพงกว่า** (~$20–80/board vs consignment ~$5–25/board) — เลือกตาม procurement capability และ supply chain risk tolerance ของ OEM
- **Hybrid model** คือ sweet spot สำหรับ OEM ที่มี proprietary component แต่ต้องการ EMS scale สำหรับ standard parts
- **Foxconn >40% market share, ~2.5% margin** — scale อย่างเดียวไม่พอ ต้องมี specialization เพื่อ margin ที่ดีกว่า
- **Celestica/Sanmina ~6% margin** มาจาก JDM + high-reliability segments ไม่ใช่ volume
- **60–75% ของ revenue คือ component cost** — spot price volatility คือ risk สำคัญที่สุดใน EMS P&L
- **เลือก EMS tier ให้ match กับ product type** — tier-1 optimize สำหรับ high-volume consumer, tier-2/3 better fit สำหรับ regulated/complex products
- EP3 ถัดไปจะเจาะลึก SMT process engineering: stencil aperture design, paste rheology, และ SPC implementation
