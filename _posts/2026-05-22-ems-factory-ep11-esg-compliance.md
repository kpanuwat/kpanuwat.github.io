---
title: "EMS Factory EP11: ESG & Compliance (Scope 1–3, Conflict Minerals)"
date: 2026-05-22 00:00:00 +0700
categories: [Engineering]
tags: [esg, scope-3, conflict-minerals, 3tg, csrd, dodd-frank, compliance, ems, manufacturing]
series: ems-factory
slides: true
---

{% include slide-link.html %}
{% include series-nav.html %}

## TL;DR

EMS ต้องรับมือกับ compliance สองด้านพร้อมกัน — ESG emissions reporting (โดยเฉพาะ Scope 3 ที่คิดเป็น 70–90% ของ carbon footprint ทั้งหมด) และ conflict minerals traceability (3TG: tantalum, tin, tungsten, gold) ที่ต้องยื่น Form SD กับ SEC ทุกปี ทั้งสองเรื่องนี้ไม่ใช่แค่ tick-box compliance — มันเป็นตัวกำหนดว่า OEM จะสามารถขายสินค้าในตลาด EU และอเมริกาได้หรือไม่

## Background / Why this matters

ESG compliance กลายเป็น market access requirement ไม่ใช่แค่ best practice ใน 5 ปีที่ผ่านมา ตลาด EU กำลังบังคับใช้ CSRD (Corporate Sustainability Reporting Directive) ที่ครอบคลุม supply chain ของ OEM ลงไปถึง tier 1–2 suppliers และ CBAM (Carbon Border Adjustment Mechanism) ที่คิดค่า carbon ของ goods ที่ import เข้า EU

สำหรับ EMS ที่ produce สินค้าให้ OEM ผลกระทบมาสองทาง: (1) OEM ต้องการข้อมูล emissions ของ EMS เพื่อ report Scope 3 ของตัวเอง และ (2) EMS ที่เป็นบริษัทขนาดใหญ่หรือ listed อาจต้องรายงานโดยตรงด้วย

ส่วน conflict minerals เป็นกฎหมายที่ชัดเจนและมีผลมาตั้งแต่ปี 2010: Dodd-Frank Section 1502 บังคับให้บริษัทที่ listed ใน SEC ต้อง trace ว่า 3TG ใน product มาจาก conflict zone ใน DRC หรือไม่ — และ EMS ที่ผลิตให้บริษัทเหล่านั้นต้องให้ข้อมูลนี้

## Deep Dive

### Scope 1, 2, 3: สามชั้นของ Carbon Footprint

GHG Protocol แบ่ง greenhouse gas emissions เป็นสามประเภทตาม control และ ownership [1, 2]:

**Scope 1 — Direct Emissions**
มาจาก sources ที่บริษัทเป็นเจ้าของหรือควบคุมโดยตรง:
- เชื้อเพลิงที่เผาใน on-site boiler, generator, reflow oven ที่ใช้ gas
- fleet ของ company vehicle
- refrigerant leak จาก HVAC/chiller

สำหรับ EMS ส่วนนี้มักเล็กมาก เพราะสายการผลิต SMT ใช้ไฟฟ้าเป็นหลัก ไม่ใช่เชื้อเพลิงโดยตรง [2]

**Scope 2 — Indirect Energy Emissions**
มาจากการซื้อไฟฟ้า, ไอน้ำ, หรือความร้อนจาก utility:
- ไฟฟ้าที่ reflow oven, pick-and-place, AOI, ICT ใช้
- air conditioning ใน cleanroom

Scope 2 วัดง่ายกว่า — ดูจาก utility bill แล้ว apply emission factor ของ grid ในประเทศนั้น [1]

**Scope 3 — Value Chain Emissions**
ทุกอย่างอื่นในห่วงโซ่ upstream + downstream:

| Category | ตัวอย่างสำหรับ EMS |
|---|---|
| Purchased goods | Carbon footprint ของ IC, PCB, passive components ที่ซื้อมา |
| Transportation | Logistics ของ component เข้า factory + finished goods ออก |
| Business travel | การบินของ engineering team |
| Waste | Solder waste, packaging waste, scrap PCB |
| Use of sold products | Carbon ที่เกิดจากการใช้งาน end product ตลอด lifecycle |
| End-of-life | การ dispose ของ product หลัง EOL |

**ตัวเลขที่สำคัญ:** Scope 3 คิดเป็น **70–90% ของ total carbon footprint** ของ manufacturing company [2] — Apple มี 76% ของ emissions มาจาก outsourced manufacturing [2] Scope 3 อาจใหญ่กว่า Scope 1+2 รวมกัน **ถึง 15 เท่า** [2]

ผลลัพธ์สำหรับ EMS: OEM ที่ต้องการลด Scope 3 จะกดดัน EMS partner ให้ provide emissions data และลด carbon footprint ของ manufacturing process

### ESG Regulations ที่ EMS ต้องรู้

**CSRD (EU Corporate Sustainability Reporting Directive)**
ครอบคลุม EU-listed companies และ non-EU companies ที่มี revenue >€150M ในตลาด EU — รายงาน sustainability ตาม ESRS (European Sustainability Reporting Standards) [3] สิ่งสำคัญที่ต่างจากเดิมคือ CSRD ครอบคลุม **supply chain disclosure** — OEM ต้องรายงาน emissions ของ Scope 3 ซึ่งหมายความว่าต้องขอข้อมูลจาก EMS partner [3]

**CBAM (Carbon Border Adjustment Mechanism)**
ตั้งแต่ปี 2026 เป็นต้นไป EU จะเก็บค่า carbon ของ goods บางประเภทที่ import เข้า EU — รวมถึง electronics components บางรายการ [3] EMS ที่ export ไป EU ต้องคำนวณ embedded carbon ของ product ที่ส่งออก

**SEC Climate Disclosure Rules (US)**
SEC ออก climate disclosure requirements ในปี 2024 ให้ public companies เปิดเผย Scope 1+2 emissions และ Scope 3 ถ้า material — แม้ว่า implementation ยังอยู่ระหว่าง legal challenge แต่ direction ชัดเจน [3]

### Conflict Minerals: 3TG และ Dodd-Frank Section 1502

**3TG คืออะไร:**
- **Tantalum (Ta)** — capacitor ใน smartphone, tablet, PCB
- **Tin (Sn)** — solder บน circuit board ทุกใบ
- **Tungsten (W)** — vibration motor ใน mobile devices
- **Gold (Au)** — electrical contact, wire bond ใน IC

ทุก EMS ที่ผลิต PCBA ใช้ 3TG — โดยเฉพาะ tin ที่อยู่ใน solder paste ทุกกระบวนการ SMT [4, 5]

**Dodd-Frank Section 1502 (2010):**
กฎหมายสหรัฐที่บังคับให้บริษัทที่ขึ้นทะเบียนกับ SEC เปิดเผยว่า 3TG ใน product มาจาก Democratic Republic of Congo (DRC) หรือประเทศเพื่อนบ้านที่เป็น conflict zone หรือไม่ [4, 5]

**เหตุผลที่กฎหมายนี้มี:** การขุด 3TG ในพื้นที่ conflict ใน DRC เป็นแหล่งรายได้ของ armed group ที่ก่อการละเมิดสิทธิมนุษยชน — กฎหมายนี้ต้องการตัด supply chain connection ระหว่าง consumer electronics กับ conflict financing [4]

**EU Conflict Minerals Regulation (2021):**
EU บังคับ importer ของ 3TG ให้ทำ due diligence ตาม OECD guidelines — ครอบคลุม smelter และ refiner ใน supply chain [5]

### CMRT และกระบวนการ Filing

**RCOI (Reasonable Country of Origin Inquiry):**
ขั้นตอนแรก — บริษัทต้องตรวจสอบว่า 3TG ที่ใช้อยู่มาจาก DRC region หรือไม่ ผ่านการสอบถาม suppliers [4]

**CMRT (Conflict Minerals Reporting Template):**
Excel form มาตรฐานของอุตสาหกรรม (พัฒนาโดย Responsible Business Alliance + GeSI) ที่ suppliers กรอกข้อมูลเกี่ยวกับ smelter และ refiner ที่ใช้ [4, 6]

**ขั้นตอน CMRT workflow:**
1. OEM ส่ง CMRT ให้ supplier ทุกราย (รวมถึง EMS)
2. EMS รวบรวม CMRT จาก component supplier ของตัวเอง
3. EMS ตรวจสอบ smelter list กับ RMI conformant smelter list
4. EMS กรอก CMRT ของตัวเองและส่งกลับไป OEM
5. OEM รวบรวมข้อมูล → ยื่น Form SD กับ SEC ภายใน **31 พฤษภาคม** ของทุกปี [4]

**Form SD สองกรณี:**
- ถ้า RCOI พิสูจน์ว่าไม่มี conflict mineral → รายงานสั้นใน Form SD
- ถ้า mineral มาจาก หรืออาจมาจาก DRC region → ต้องทำ detailed due diligence + แนบ Conflict Minerals Report เป็น exhibit [4]

### OECD Due Diligence Framework (5 Steps)

OECD Due Diligence Guidance คือ framework ที่ทั้ง US (Dodd-Frank) และ EU (EU CMR) ใช้เป็น reference [5, 6]:

| Step | Action |
|---|---|
| **1. Establish management systems** | กำหนด policy, supplier code of conduct, internal grievance mechanism |
| **2. Identify and assess risks** | Map supply chain ถึง smelter/refiner level; ระบุ CAHRA exposure |
| **3. Design risk response** | ตัดสินใจ: engage supplier เพื่อปรับปรุง หรือ disengage ถ้า risk สูงเกิน |
| **4. Third-party audit** | Smelter ที่อยู่ใน supply chain ต้อง audit ตาม RMAP (Responsible Minerals Assurance Process) |
| **5. Annual reporting** | รายงานต่อสาธารณะว่าทำ due diligence อะไรบ้าง |

**RMAP (Responsible Minerals Assurance Process):** โปรแกรม audit ที่ RMI (Responsible Minerals Initiative) รัน — smelter/refiner ที่ผ่าน audit จะอยู่ใน "conformant smelter list" ที่ companies ใช้ verify ว่า supply chain สะอาด [6]

### Practical Actions: EMS ทำอะไรจริงๆ

**1. BOM Mapping + Scope Analysis**
ก่อน CMRT campaign: engineering team map BOM เพื่อระบุว่า component ไหนมี 3TG — ไม่ใช่ทุก part มี ตัวอย่าง: gasket หรือ structural part อาจไม่มี 3TG แต่ passive capacitor ที่ใช้ tantalum ต้องรวม [4, 6]

**2. Supplier CMRT Collection + Tracking**
EMS ส่ง CMRT ให้ supplier ทุกปีก่อน deadline ใช้ software (Assent, Certivo, Source Intelligence) ในการ automate distribution, track response rate, และ validate ข้อมูลที่ได้รับ [4, 6]

**3. Smelter Verification กับ RMI List**
Cross-reference smelter ที่ supplier report กับ RMI conformant list — ถ้า smelter ไม่อยู่ใน list หรืออยู่ใน "active" review → escalate ไปหา supplier [6]

**4. Emissions Measurement ตาม GHG Protocol**
สำหรับ Scope 2: ใช้ utility bill + grid emission factor ของประเทศนั้น
สำหรับ Scope 3: ใช้ spend-based method (ค่าใช้จ่าย × emission intensity factor) เป็น starting point ก่อน transition ไป supplier-specific data ในระยะยาว [1, 2]

**5. RE100 / Green Electricity**
EMS บางรายซื้อ renewable energy certificate (REC/IREC) หรือเซ็น PPA (Power Purchase Agreement) กับ renewable generator เพื่อลด Scope 2 emissions ลงสู่ 0 ตาม market-based accounting [1]

## Caveats / Limits

- **Scope 3 measurement ยังเป็น art มากกว่า science:** spend-based method ให้ค่าประมาณ — ถ้าต้องการ accurate Scope 3 ต้องรวบรวม primary data จาก supplier ทุกราย ซึ่งใช้ทรัพยากรมาก
- **CMRT ≠ guarantee conflict-free:** CMRT บอกแค่ว่า smelter ที่ใช้อยู่ใน conformant list หรือไม่ — ไม่ได้ guarantee ว่าไม่มี conflict mineral ปะปนอยู่เลย
- **Dodd-Frank Section 1502 บังคับเฉพาะ SEC filers:** EMS ที่ไม่ได้ listed ใน SEC ไม่ถูกบังคับโดยตรง — แต่ถ้า OEM ที่เป็น customer เป็น SEC filer → OEM จะส่ง CMRT requirement มาถึง EMS อยู่ดี
- **CSRD phasing:** ไม่ใช่ทุกบริษัทต้องรายงานพร้อมกัน — large EU companies เริ่มปี 2025, SME และ non-EU companies เริ่มทีหลัง; timeline ยังปรับอยู่
- **CBAM scope ยังจำกัด:** ณ ปัจจุบัน CBAM ครอบคลุม steel, cement, aluminum, fertilizer, electricity, hydrogen — electronics ยังไม่อยู่ใน scope แต่ expansion กำลังถูก discuss
- **Conflict-affected area definition เปลี่ยน:** DRC และประเทศเพื่อนบ้านที่ถูก designate อาจเปลี่ยนตาม geopolitical situation — ต้องติดตาม OECD/SEC guidance

## References

1. [What are Scope 1, 2 and 3 Emissions? — ESG Analytics](https://www.esganalytics.io/insights/what-are-scope-1-2-and-3-carbon-emissions)
2. [Carbon Emissions Scope 1, 2 and 3 in Manufacturing — Regilient](https://www.regilient.ai/blog/understanding-scope-one-two-three-emissions-in-manufacturing)
3. [Conflict Minerals Compliance Basics: What to Know for 2025 — Assent](https://www.assent.com/blog/conflict-minerals-compliance-basics-what-to-know-for-2025/)
4. [Dodd-Frank Section 1502: Conflict Minerals Compliance Guide — Source Intelligence](https://blog.sourceintelligence.com/blog/what-is-section-1502-of-the-us-dodd-frank-act)
5. [Conflict Minerals Regulation Explained — European Commission](https://policy.trade.ec.europa.eu/development-and-sustainability/conflict-minerals-regulation/regulation-explained_en)
6. [Ultimate Guide to Conflict Minerals Compliance — Certivo](https://www.certivo.com/blog-details/ultimate-guide-to-conflict-minerals-compliance-a-practical-breakdown)

## Key Takeaways

- Scope 3 emissions คิดเป็น 70–90% ของ carbon footprint ของ EMS — OEM ที่ต้องรายงาน CSRD จะกดดัน EMS ให้ provide emissions data ใน Scope 3 ของตัวเอง
- **Scope 1** = direct combustion, **Scope 2** = purchased electricity, **Scope 3** = supply chain ทั้งหมด upstream + downstream — วัดยากแต่ใหญ่ที่สุด
- Tin อยู่ใน solder ทุกชิ้น, tantalum อยู่ใน capacitor — EMS ทุกรายมี 3TG ใน process โดยธรรมชาติ
- Dodd-Frank 1502 กำหนด deadline **31 พฤษภาคม** สำหรับ Form SD filing — OEM จะ push CMRT request มาถึง EMS ก่อน deadline นี้
- ลำดับ conflict mineral compliance: BOM mapping → CMRT collection → smelter verification (RMI list) → RCOI → Form SD
- OECD 5-step due diligence เป็น framework ที่ทั้ง US และ EU ใช้ — core คือ trace ถึง smelter/refiner ไม่ใช่แค่ tier-1 supplier
- ถาม EMS partner: "CMRT response rate ของ supplier คุณคือเท่าไหร่?" และ "มี smelter ที่ non-conformant อยู่ใน supply chain ไหม?"
