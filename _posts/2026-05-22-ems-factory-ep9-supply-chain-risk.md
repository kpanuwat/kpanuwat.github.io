---
title: "EMS Factory EP9: Supply Chain Risk & Component Obsolescence"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [supply-chain, component-obsolescence, ems, manufacturing, bom, risk-management]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

Component obsolescence คือหนึ่งในความเสี่ยงที่ซ่อนอยู่ใน EMS supply chain — part ที่ใช้งานอยู่อาจหยุดผลิตโดยไม่แจ้งเตือนล่วงหน้า (37% ของ part ที่ obsolete ไม่มี advance warning) การจัดการต้องเริ่มตั้งแต่ design phase ไม่ใช่รอให้ PDN (Product Discontinuance Notice) มาถึงมือก่อน

## Background / Why this matters

ใน EMS supply chain มีความเสี่ยงสองประเภทที่แตกต่างกันในเชิงเวลา — ความเสี่ยงระยะสั้นอย่าง shortage หรือ lead time spike ที่เห็นชัดและแก้ได้ด้วยการ expedite หรือ spot buy กับความเสี่ยงระยะยาวอย่าง component obsolescence ที่ค่อยๆ สะสมและระเบิดขึ้นเมื่อ manufacturer หยุดผลิต part นั้นอย่างถาวร

ปัญหาคือ lifespan ของ component ลดลงเร็วกว่าที่หลายคนคาด — จากเดิมที่ component เก่าอยู่ได้ 10–30 ปี ปัจจุบัน advanced semiconductor มี lifecycle เฉลี่ยแค่ 2–5 ปี เพราะ technology node เปลี่ยนเร็ว, fab รุ่นใหม่ไม่รองรับ old process, และ market shift ทำให้ supplier ตัดสินใจหยุด line ที่ไม่ทำกำไรได้เร็วขึ้น

สำหรับ OEM ที่ outsource การผลิตให้ EMS การเลือก partner ที่มี supply chain resilience ที่ดีไม่ใช่แค่เรื่อง cost — มันคือเรื่องของ product continuity สำหรับ program ที่มี lifecycle ยาว เช่น industrial equipment, medical device, หรือ automotive ที่ต้องการ spare part อีก 10–15 ปีหลังจาก launch

## Deep Dive

### Component Lifecycle: 6 Stages & Obsolescence Drivers

Component ทุกตัวผ่าน 6 ขั้นตอน:

1. **Introduction** — component เพิ่งออก production ยัง ramp up อยู่ lead time นาน
2. **Growth** — production เต็มที่ availability ดี ราคาลง
3. **Maturity** — peak supply; EMS ชอบ phase นี้มากที่สุด
4. **Decline** — demand ลด; manufacturer เริ่มพิจารณา discontinue
5. **Phase-Out** — Product Discontinuance Notice (PDN) ออก; มี Last Time Buy window
6. **Obsolescence** — ไม่มีผลิตอีกแล้ว; ต้องพึ่ง secondary market หรือ re-design

**ตัวเลขที่ต้องรู้:**
- Lifespan เฉลี่ยลดจาก 30 ปี เหลือต่ำกว่า 4 ปี (ลดลง 87%) [1]
- Advanced semiconductor มี lifecycle 2–5 ปี [3]
- **37% ของ part ที่ obsolete ไม่มี advance warning** — ไม่มี PCN, ไม่มี PDN [1]
- "Instant obsolescence" (หยุดผลิตทันทีโดยไม่มี notice) เพิ่มขึ้น 35% [1]
- ปี 2022: มากกว่า **750,000 component** ถูกประกาศ obsolete [3]
- ปี 2023: 328,000 EOL notices ออกมา [1]

**สาเหตุหลักของ obsolescence:**
- **Technology shift**: node size เล็กลงเรื่อยๆ — older process nodes ไม่คุ้มค่าที่จะรัน
- **Market consolidation**: M&A ทำให้ product line ถูกตัด, plant ปิด
- **Regulatory compliance**: RoHS, REACH บังคับให้เปลี่ยน material → legacy part ไม่ผ่าน
- **Geopolitical risk**: tariff, trade restriction, factory fire, supplier bankruptcy

### DMSMS: Framework จาก Defense ที่ใช้ได้กับ EMS

**DMSMS (Diminishing Manufacturing Sources and Material Shortages)** คือ framework ที่กระทรวงกลาโหมสหรัฐพัฒนาขึ้นเพื่อจัดการ obsolescence ในระบบอาวุธและอุปกรณ์ทางทหาร (SD-22 guideline) [5]

แม้จะมีต้นกำเนิดจาก defense แต่ logic ของ DMSMS ใช้ได้กับ EMS ทั่วไป:
- **Case management**: ทุก "obsolescence case" มี owner, timeline, resolution path
- **Early identification**: monitor lifecycle data ต่อเนื่อง ไม่รอให้ part หาย
- **Risk categorization**: แบ่ง severity ตาม replacement difficulty + program impact
- **Resolution hierarchy**: Multi-source ก่อน → LTB → เปลี่ยน supplier → Re-design เป็น last resort

ตัวอย่างผลลัพธ์จริง: US Air Force ใช้ structured lifetime buys และ cross-sourcing strategy ระหว่างปี 2012–2021 ทำให้เกิด **cost avoidance $1.2 billion** [3]

### BOM Risk Classification & Heat-Mapping

การจัดการ supply chain risk เริ่มที่ BOM — ไม่ใช่รอให้เกิดปัญหาก่อน

**BOM Heat-Map แบ่ง part เป็น 3 กลุ่ม:**

| Risk Level | เกณฑ์ | Action |
|---|---|---|
| **Red** (Critical) | Single-source, lifecycle Decline/Phase-Out, long lead time (>26 wk), no known alternative | Immediate: LTB + เร่งหา alternative |
| **Yellow** (Watch) | Dual-source แต่ concentration risk, lifecycle Decline, lead time 13–26 wk | Monitor monthly: ระบุ 2nd source, เตรียม buffer |
| **Green** (Stable) | Multi-source, Maturity/Growth phase, lead time <13 wk, standard part | Review quarterly |

**สิ่งที่ PLM/SCRM tools ต้อง track ต่อ part:**
- Lifecycle status (ข้อมูลจาก distributor feeds เช่น IHS Markit, Siliconexpert, Z2Data)
- Number of qualified sources (OCM + authorized distributor)
- Lead time trend (เพิ่มขึ้นหมายถึง supply tightening)
- Market inventory level (weeks of supply)
- PCN/PDN history

การทำ BOM risk scan ตั้งแต่ program onboarding ช่วยให้ EMS surface "red parts" ก่อนที่จะเริ่ม production — ไม่ใช่หลังจาก pilot run แล้วเจอว่า key component หมด [4]

### Mitigation Strategies: จาก Multi-Sourcing ถึง Re-Design

มี 4 strategy หลักที่ EMS และ OEM ใช้ เรียงจาก preferred → last resort:

**1. Multi-Sourcing / Dual-Sourcing**
- ระบุ Form-Fit-Function (FFF) equivalent จาก manufacturer อื่นตั้งแต่ design phase
- qualify alternate ให้ครบก่อน production เริ่ม
- บางครั้งต้อง update schematic, BOM, และ test specification
- ผลลัพธ์: บริษัทที่ใช้ dual-sourcing มี disruption-related cost ต่ำกว่า single-source 15–20% [4]

**2. Last Time Buy (LTB)**
- ซื้อ stock เพียงพอสำหรับ remaining product lifecycle ก่อน PDN deadline
- ต้องคำนวณ: projected demand × buffer factor − existing inventory
- ข้อเสีย: ล็อก capital, ต้องการ warehouse และ climate control, component มี shelf life
- เหมาะกับ: part ที่ critical แต่ไม่มี drop-in replacement

**3. Bonded Inventory**
- EMS จอง component ล่วงหน้ากับ authorized distributor — ไม่ต้องจ่ายทั้งหมดทันที แต่ได้สิทธิ์เบิกตามต้องการ
- ช่วยลด lead time risk ในกรณีที่ market tighten กะทันหัน
- ต้องตรวจสอบว่า distributor เป็น authorized (franchised) ไม่ใช่ broker — ลดความเสี่ยง counterfeit

**4. Re-Design**
- Last resort เมื่อ part obsolete แล้วและไม่มี drop-in replacement
- ต้องอัปเดต schematic, PCB layout, firmware (ถ้า driver เปลี่ยน), test coverage
- สำหรับ medical device: ต้องทำ design validation ซ้ำและอาจต้อง re-submit regulatory approval
- ต้นทุนสูงและใช้เวลานาน — บางโปรแกรมใช้เวลา 6–18 เดือนในการ qualify redesign

### Counterfeit Component Risk

นอกจาก obsolescence, supply chain risk อีกประเภทที่เชื่อมกันคือ **counterfeit component** — พบมากในตลาด secondary (non-franchised broker) ที่ EMS บางรายหันไปพึ่งเมื่อ authorized stock หมด

**Red flag ของ counterfeit:**
- ราคาต่ำผิดปกติในช่วง shortage
- markings ไม่ตรงกับ datasheet (date code, lot code, country of origin)
- source เป็น broker ไม่รู้จัก ไม่มี traceability ไปถึง OCM

**วิธี verify:**
- ซื้อจาก authorized distributor เท่านั้น (Mouser, Digi-Key, Arrow, Avnet, TTI)
- สำหรับ part ที่ต้องซื้อจาก open market: ต้องผ่าน testing ตาม AS6081/AS6171 standard
- IDEA-ICE-3000 inspection checklist ใช้ตรวจ marking, dimensions, solderability

### ประเมิน EMS Partner: 5 คำถามเรื่อง Supply Chain Resilience

เมื่อ OEM ประเมิน EMS ให้ถามเรื่อง supply chain มากกว่าแค่ดู certificate [6]:

1. **"BOM risk scan ทำเมื่อไหร่?"** — คำตอบที่ดี: ทำตั้งแต่ RFQ/onboarding ไม่ใช่หลัง PO ออก
2. **"Tool ที่ใช้ track component lifecycle คืออะไร?"** — ต้องการ real data feed (SiliconExpert, Z2Data, IHS) ไม่ใช่แค่ดู distributor website manual
3. **"Approved Vendor List (AVL) มี alternate source กี่ % ของ BOM?"** — target: >80% ของ critical component มี qualified 2nd source
4. **"Last Time Buy กี่ครั้งในปีที่แล้ว?"** — measure ว่า EMS reactive หรือ proactive
5. **"Counterfeit prevention process เป็นอย่างไร?"** — ต้องมี authorized-only policy และ incoming inspection procedure

## Caveats / Limits

- **LTB calculation error**: ประเมิน demand ต่ำเกินไป → stock หมดก่อน EOL; ประเมินสูงเกินไป → ต้นทุน holding cost และ write-off risk
- **Alternate qualification time**: FFF equivalent ไม่ได้ qualify ได้เร็วเสมอ — บาง part ต้องใช้เวลา 3–6 เดือนในการ qualification testing โดยเฉพาะ automotive/medical
- **Secondary market risks**: ช่วง shortage หนัก EMS บางรายถูกกดดันให้ซื้อจาก broker — ความเสี่ยง counterfeit สูงมาก ต้องมี incoming inspection จริงๆ
- **Re-design scope creep**: เปลี่ยน component หนึ่งตัวอาจ cascade ไปถึง layout, firmware, test fixture — ประเมิน cost/timeline อย่างระมัดระวัง
- **Geopolitical uncertainty**: Taiwan/China concentration ใน semiconductor supply chain คือ systemic risk ที่ individual company ควบคุมไม่ได้คนเดียว — geographic diversification ของ EMS partner สำคัญ

## References

1. [Buyer's guide: Electronics lifecycle & obsolescence management — Luminovo](https://luminovo.com/resources/blog/guide-electronics-component-lifecycle-obsolescence-management)
2. [Proactive Component Obsolescence Management for Electronics — Part Analytics](https://partanalytics.com/proactive-component-obsolescence-management-for-electronics/)
3. [Component Obsolescence is Rising: Why is it Increasing and How to Proactively Mitigate the Risks — Sourceability](https://sourceability.com/post/how-to-mitigate-electronic-component-obsolescence-risks)
4. [Mitigating risks in the electronics supply chain: Best practices — Luminovo](https://luminovo.com/resources/blog/mitigating-risks-in-the-electronics-supply-chain-best-practices)
5. [Managing Obsolescence in the Electronics Components Industry — Electropages](https://www.electropages.com/blog/2025/01/rising-tide-obsolescence-and-solutions-mitigation)
6. [Mitigating End-of-Life Obsolescence in Custom-Built Electronics — Siemens Manufacturing](https://siemensmfg.com/electronics-manufacturing-trends/mitigating-end-of-life-obsolescence-in-custom-built-electronics/)
7. [Component Shortages: 4 Effective Tips To Manage Them — Federal Electronics](https://federalelec.com/blog/managing-component-shortages-in-ems/)
8. [Component unavailability challenges — Sourceability](https://sourceability.com/post/when-parts-disappear-why-component-unavailability-is-rising)

## Key Takeaways

- Component lifespan ลดจาก 30 ปีเหลือต่ำกว่า 4 ปี — supply chain ที่ถูก design 5 ปีก่อนอาจมี red part แล้วโดยไม่รู้
- **37% ของ part ที่ obsolete ไม่มี advance warning** — reactive monitoring ไม่พอ ต้องมี proactive lifecycle tracking
- BOM heat-map (Red/Yellow/Green) ควรทำตั้งแต่ program onboarding — ไม่ใช่หลัง production เริ่ม
- ลำดับ mitigation: Multi-source ก่อน → LTB → Bonded Inventory → Re-design; อย่ากระโดดไป LTB ถ้ายังหา alternate ได้
- Dual-sourcing ลด disruption cost 15–20% เมื่อเทียบกับ single-source — ROI ชัดเจนแม้จะมี qualification overhead
- ซื้อจาก authorized distributor เท่านั้น — secondary market ในช่วง shortage คือ counterfeit hotspot
- ถาม EMS partner ว่า "BOM risk scan ทำเมื่อไหร่?" — คำตอบที่ดีคือ "ตั้งแต่ RFQ" ไม่ใช่ "ตอน part หมด"
