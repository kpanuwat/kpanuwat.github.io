---
title: "ตรวจรับงานตู้ไฟ Consumer Unit Din Rail สำหรับชาร์จ EV: ข้อผิดพลาดและมาตรฐานการไฟฟ้า"
date: 2026-06-20 00:01:00 +0700
categories: [Engineering]
tags: [ev-charger, consumer-unit, electrical-safety, din-rail, rcd, rcbo, wiring-standards]
---

## TL;DR

สาย Neutral (N) จากมิเตอร์ต้องต่อเข้า **Ground Bar ก่อนเสมอ** — แม้ในระบบ TT ที่ใช้ในบ้านไทยทั่วไป — แล้วค่อยจ่ายเข้า RCD/RCBO หรือเมนเบรกเกอร์ หากต่อผิดลำดับ RCD จะทำงานผิดพลาดหรือไม่ตัดไฟเมื่อเกิดอุบัติเหตุ โดยเฉพาะกับวงจร EV Charger ที่ดึงกระแสสูงต่อเนื่อง ความผิดพลาดเล็กน้อยคือต้นเหตุของไฟไหม้และไฟดูด

## Background / Why this matters

การติดตั้ง EV Charger ที่บ้านกลายเป็นเรื่องปกติมากขึ้นในไทย แต่หลายครัวเรือนที่จ้างช่างนอกระบบหรือช่างท้องถิ่นมักพบปัญหาการเดินสายผิดมาตรฐานการไฟฟ้า (MEA/PEA) ซึ่งซ่อนอยู่ในตู้ไฟ Consumer Unit แบบ Din Rail — ปัญหาที่ตรวจไม่พบด้วยตาเปล่าแต่เป็นอันตรายถึงชีวิต

ประเทศไทยใช้ระบบ **TT Earthing** (IEC 60364) ในการเดินสายไฟฟ้าที่อยู่อาศัย ระบบนี้กำหนดให้ต้องมี RCD (Residual Current Device) เป็นตัวป้องกันหลัก เพราะค่า loop impedance สูงเกินไปสำหรับเบรกเกอร์ธรรมดาจะตัดไฟทันก่อนเกิดอันตราย ดังนั้นหาก RCD ทำงานผิดพลาดเพราะการเดินสายผิด ระบบป้องกันทั้งหมดก็ล้มเหลว

เจ้าของบ้านที่ติดตั้งชาร์จ EV ควรเข้าใจหลักการนี้เพื่อตรวจรับงานได้ก่อนจ่ายเงิน

## Deep Dive

### ระบบ TT Earthing กับบ้านไทย

ระบบ TT (Terra-Terra) หมายความว่า:
- สายดินฝั่งการไฟฟ้า (source) เชื่อมลงดินที่จุดหนึ่ง
- สายดินฝั่งบ้าน (consumer) เชื่อมลงดินที่จุดของตัวเอง (Ground Rod หน้าบ้าน) อย่างอิสระ

| ลักษณะ | ระบบ TT (ไทย) | ระบบ TN-S (ยุโรปบางประเทศ) |
|--------|--------------|---------------------------|
| สายดิน | แยกอิสระระหว่างการไฟฟ้ากับบ้าน | PE conductor วิ่งมาจากแหล่งจ่าย |
| N กับ PE | ต้องแยกตลอดเส้นทาง | แยกตลอด (S = Separated) |
| พึ่งพาอะไร | RCD เป็นหัวใจการป้องกัน | Loop impedance + RCD เสริม |
| ความเสี่ยง | ถ้า RCD พัง ระบบล้มเหลว | Neutral หัก → PE มีกระแส |

ใน TT ระบบ RCD จึงไม่ใช่ "ตัวเสริม" แต่เป็น **ตัวป้องกันหลัก** ตามมาตรฐาน IEC 60364-4-41

### ทำไม Neutral (N) ต้องเข้า Ground Bar ก่อน

RCD/RCBO ทำงานโดย **วัดความต่างของกระแส** ระหว่างสาย Phase กับสาย Neutral ผ่าน toroidal transformer:

```
กระแส Phase ออกไป − กระแส Neutral กลับมา = กระแสรั่ว (IΔ)
ถ้า IΔ > 30mA → RCD ตัดวงจร
```

**เส้นทางที่ถูกต้อง:**

```
มิเตอร์ → Main Switch → [Ground Bar ← Ground Rod] → Neutral Bar → RCD/RCBO → วงจรต่างๆ
```

**ปัญหาเมื่อ Neutral ข้ามไปต่อ RCD โดยตรง (ผิด):**

```
มิเตอร์ → Main Switch → RCD/RCBO (ต่อ N โดยตรง) ← Ground Bar (ไม่ได้เชื่อม N)
```

เกิดสิ่งที่เรียกว่า **"Hidden N-PE Bridge"** — กระแส Neutral บางส่วนวิ่งผ่านสาย Earth ไปพร้อมกันโดยที่ RCD มองไม่เห็น ผลคือ:
1. **Nuisance Tripping** — RCD เห็น current imbalance ปลอม ตัดไฟโดยไม่มีเหตุ
2. **ไม่ตัดเมื่อมี Fault จริง** — กระแสรั่วจริงกระจายออก 2 เส้นทาง แต่ละเส้นต่ำกว่า 30mA → RCD ไม่ตัด

ใน EV Charger ที่ดึงกระแส 16–32A ต่อเนื่อง ความเสี่ยงยิ่งสูงขึ้นทวีคูณ

### ข้อผิดพลาดที่พบบ่อย 5 ข้อ

#### 1. Neutral ข้าม Ground Bar ไปต่อ RCD โดยตรง ⚠️ อันตราย

ช่างบางรายต่อสาย N จากมิเตอร์ตรงไปยัง input terminal ของ RCD/RCBO โดยไม่ผ่าน Ground Bar ก่อน ผิดมาตรฐาน IEC 60364 และทำให้ระบบป้องกันล้มเหลว

**ตรวจสอบ:** เปิดฝาตู้ไฟ ดูว่าสาย N จาก Main Switch วิ่งไปที่ Ground Bar ก่อนหรือเปล่า ถ้าวิ่งตรงไป RCD เลย = ผิด

#### 2. ขันสกรู Terminal ไม่แน่น

วงจร EV Charger 32A ที่มี connection หลวม จะมีความต้านทานที่จุดสัมผัส (contact resistance) ทำให้:
- ความร้อนสะสมสูง (P = I²R)
- ไฟไหม้ terminal และ busbar
- RCD trip แบบ intermittent ไม่มีสาเหตุชัด

**มาตรฐาน:** ใช้ torque screwdriver ตาม spec ของ busbar (ปกติ 2–4 N·m ตามรุ่น)

#### 3. ขนาดสายไฟเล็กเกินไปสำหรับ EV Charger

| ขนาดชาร์จ | กระแสสูงสุด | ขนาดสายต่ำสุด (Cu) | เบรกเกอร์ที่ใช้ |
|-----------|------------|-------------------|----------------|
| 7.4 kW (32A) | 32A | **6 mm²** | 40A |
| 5.5 kW (25A) | 25A | 4 mm² | 32A |
| 3.7 kW (16A) | 16A | 2.5 mm² | 20A |

ใช้กฎ 125% continuous load: เบรกเกอร์ต้องใหญ่กว่ากระแสของชาร์จ เช่น 32A charger → 40A breaker

#### 4. เลือก RCD/RCBO ผิดประเภท

EV Charger รุ่นใหม่มีวงจรแปลง AC→DC ภายในที่ปล่อย **DC Leakage Current** ซึ่ง Type AC RCBO ตรวจไม่พบ:

| RCD Type | ตรวจ AC fault | ตรวจ DC fault | ใช้กับ EV |
|----------|--------------|--------------|-----------|
| Type AC | ✅ | ❌ | ❌ ห้ามใช้ |
| **Type A** | ✅ | ถึง 6mA DC | ✅ ถ้าชาร์จมี RDC-DD |
| **Type B** | ✅ | ถึง 60mA DC | ✅ ทุกกรณี |

สำหรับไทย: ชาร์จที่มีฉลาก **"Built-in DC Leakage Protection"** หรือ **RDC-DD** ใช้ Type A ได้ นอกนั้นควรใช้ Type B

#### 5. ใช้สายไฟที่ไม่ได้มาตรฐาน TISI

สายที่ไม่ผ่าน มอก. (TISI) มักมีฉนวนและตัวนำที่บางกว่า spec ทำให้ทนกระแสได้น้อยกว่าที่ระบุ ให้เช็คฉลากสายไฟว่ามีตรา **มอก.11-2553** หรือ **TISI 11**

### การเลือก RCD/RCBO ให้ถูกต้อง

สำหรับวงจร EV Charger:
- Sensitivity: **30mA** (IΔn = 0.03A) — ไม่ใช้ 100mA หรือ 300mA
- Type: **A หรือ B** ตามที่ชาร์จกำหนด
- Rated current: **ต้องรองรับได้ไม่น้อยกว่าเบรกเกอร์ในวงจร** (เช่น 40A)
- Breaking capacity: ≥ 6kA (ตาม IEC 60898)

ควรติด RCBO (Residual Current Circuit Breaker + Overcurrent) แทน RCD ล้วนๆ เพราะรวมการป้องกัน overcurrent ด้วย

## User Guide (Step-by-Step)

### ขั้นตอนตรวจรับงานสำหรับเจ้าของบ้าน

> ⚠️ ห้ามแตะสายไฟและอุปกรณ์ภายในตู้ด้วยตนเอง — ตรวจจากภายนอกก่อน เชิญช่างที่มีใบอนุญาตก่อนเปิดฝา

#### Step 1: ตรวจภายนอกตู้ไฟก่อนรับงาน

- ฝาตู้ปิดสนิท ไม่มีรอยไหม้ กลิ่นไหม้ รอยสนิม น้ำซึม
- ฉลากวงจรอ่านได้ชัดเจน: ระบุ "EV Charger", "ห้องนอน", "ครัว" ฯลฯ
- ไม่มีสายไฟโผล่ออกมาภายนอกโดยไม่มี conduit

#### Step 2: ขอให้ช่างเปิดฝาตู้ให้ดู (ไฟดับ Main Switch ก่อน)

ดูจุดเหล่านี้:

**จุด 1 — ลำดับการต่อสาย N:**
```
✅ ถูก: มิเตอร์ → Main Switch → Ground Bar → Neutral Bar → RCD/RCBO
❌ ผิด: มิเตอร์ → Main Switch → RCD/RCBO (ข้าม Ground Bar)
```

**จุด 2 — Ground Bar ต้องมีสายดินลงดิน (Ground Rod):**
- สายสีเขียว-เหลือง (PE) ต้องออกจาก Ground Bar ไปยัง Ground Rod
- ถ้าไม่มีสายนี้ = ไม่มีการต่อลงดิน อันตราย

**จุด 3 — RCD/RCBO สำหรับวงจร EV:**
- มีตัวอักษร **"A"** หรือ **"B"** บนตัว RCBO
- ค่า **IΔn = 30mA** (พิมพ์บนตัวอุปกรณ์)
- ไม่ใช้ Type **AC** หรือค่า 100mA/300mA สำหรับ EV

**จุด 4 — ขนาดสาย EV Charger:**
- ดูสายที่ต่ออยู่กับ RCBO ของชาร์จ: ต้องเป็นสาย **6 mm²** สำหรับ 32A charger
- สายต้องมีฉลาก มอก.

**จุด 5 — ความแน่นของสกรู:**
- ขอให้ช่างขันสกรู terminal ทุกจุดซ้ำอีกรอบต่อหน้าเรา

#### Step 3: ทดสอบ RCD ด้วย Test Button

1. จ่ายไฟเข้าตู้ (ปิดเบรกเกอร์วงจรอื่นก่อนเพื่อความปลอดภัย)
2. กดปุ่ม **TEST** บน RCD/RCBO ของวงจร EV
3. RCD ต้อง **ตัดทันที** (ภายใน 300ms) — ถ้าไม่ตัด = RCD เสีย

#### Step 4: ขอเอกสาร

- ใบรับประกันงาน (warranty) อย่างน้อย 1 ปี
- รายการอุปกรณ์ที่ใช้ (brand, model ของ RCBO, สายไฟ, Consumer Unit)
- รูปถ่ายภายในตู้ก่อนปิดฝา

## Caveats / Limits

- **ไม่ใช่การแทนช่างไฟที่มีใบอนุญาต** — การตรวจรับงานนี้เป็นการให้เจ้าของบ้านเข้าใจ ไม่ใช่การแก้ไขเอง
- **ค่า Derating ในอากาศร้อน** — ไทยมีอุณหภูมิแวดล้อม 30–35°C ช่างต้องคำนวณ derating factor ตาม IEC 60364-5-52; สาย 6 mm² ในสภาพอุณหภูมิสูงอาจต้องเพิ่มเป็น 10 mm² ขึ้นอยู่กับการติดตั้ง (ท่อร้อยสาย vs เดินแบบเปิด)
- **การอัพเกรดมิเตอร์** — EV Charger 32A ต้องการมิเตอร์ขนาด 30A หรือ 45A; หากมิเตอร์บ้านยังเป็น 15A ต้องแจ้ง MEA/PEA ก่อน ไม่เช่นนั้นมิเตอร์จะไหม้
- **Type B RCBO ราคาสูง** — แพงกว่า Type A 3–5 เท่า แต่จำเป็นสำหรับชาร์จที่ไม่มี built-in DC protection
- **Ground Rod ต้องฝังลึกพอ** — ค่า earth resistance ต้องต่ำกว่า 50Ω (IEC 60364) ในดินไทยที่หลากหลาย บางพื้นที่อาจต้องฝัง ground rod หลายแท่ง

## References

1. IEC 60364: Low-voltage electrical installations — <https://www.iec.ch/basecamp/iec-60364-low-voltage-electrical-installations>
2. TT earthing system explained — <https://elek.com/articles/earthing-system-types-explained-and-compared/>
3. Neutral bar vs ground bar: critical differences — <https://viox.com/neutral-bar-vs-grounding-bar-whats-the-critical-difference/>
4. Type A vs Type B RCDs for EV chargers — <https://poweranddatauk.co.uk/blogs/news/type-a-vs-type-b-rcds-for-ev-chargers>
5. RDC-DD vs Type B RCD EV charger design guide — <https://www.bituo-technik.com/rdc-dd-vs-type-b-rcd-ev-charger-design-guide/>
6. EV charger wire sizing guide — <https://electricalcalctools.com/ev-charger-wire-size>
7. EV charger breaker sizing guide (Level 1 & 2) — <https://breakerhunters.com/blogs/news/ev-charger-breaker-sizing-wiring-level-1-2-guide-2025>
8. RCD requirements for EV charging — <https://hager.com/uk/get-involved/news-and-press/ev-charging-and-rcds>
9. Schneider Electric Electrical Installation Guide (IEC standards) — <https://www.se.com/th/en/work/products/product-launch/electrical-installation-guide/>
10. ต้นฉบับวิดีโอ YouTube — <https://youtu.be/WoVhHa_3bWM>

## Key Takeaways

- สาย **Neutral ต้องผ่าน Ground Bar ก่อนเสมอ** — เป็นข้อกำหนดของ IEC 60364 ในระบบ TT; ข้ามขั้นตอนนี้ทำให้ RCD ทำงานผิดพลาด
- **ระบบ TT ในไทยพึ่งพา RCD เป็นหลัก** — ถ้า RCD ถูกหลอกด้วย hidden current path บ้านไม่มีการป้องกันไฟดูดจริงๆ
- **EV Charger 32A ต้องใช้สาย 6 mm²** และ **เบรกเกอร์ 40A** (กฎ 125% continuous load)
- **เลือก RCD Type A หรือ B** เท่านั้น สำหรับวงจร EV — Type AC ตรวจ DC leakage ไม่ได้
- **ขันสกรู terminal ให้แน่น** — สกรูหลวมในวงจร 32A คือต้นเหตุไฟไหม้ที่พบบ่อย
- **ขอรูปถ่ายและเอกสาร** ก่อนปิดฝาตู้ไฟ — หลักฐานตรวจรับงานที่เจ้าของบ้านควรมี
- **อย่ารับงาน** ถ้าช่างต่อ Neutral โดยตรงกับ RCD โดยไม่ผ่าน Ground Bar — บอกให้แก้ไขก่อน
