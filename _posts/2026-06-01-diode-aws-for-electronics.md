---
title: "Diode: AWS สำหรับอิเล็กทรอนิกส์ — ปฏิวัติการออกแบบ PCB ด้วย AI"
date: 2026-05-31 06:39:00 +0700
categories: [Engineering]
tags: [hardware, electronics, ai, pcb, startup, llm, manufacturing]
---

## TL;DR

Diode คือ startup จาก Brooklyn Navy Yard ที่ใช้ AI ปฏิวัติการออกแบบและผลิต PCB (Printed Circuit Board) ในสหรัฐฯ ด้วยวิสัยทัศน์ **"AWS สำหรับอิเล็กทรอนิกส์"** — ย่น timeline จาก "หลายเดือน" เหลือ "สัปดาห์" engineer คนเดียวออกแบบได้มากกว่า **100 บอร์ดต่อปี** ระดมทุน $11.4M Series A จาก Andreessen Horowitz (a16z) ในปี 2025

## Background / Why This Matters

### Hardware กับ Software — ช่องว่างที่ถ่างมาหลายสิบปี

ในโลก software ทีมเล็กๆ ส่ง feature ใหม่ได้ภายใน **ชั่วโมง** แต่ใน hardware โดยเฉพาะ PCB หนึ่ง iteration ใช้เวลา **หลายสัปดาห์ถึงหลายเดือน** เหตุผลคือกระบวนการ design แบบเดิมซับซ้อน ต้องจัดการ:

- **Library component** ด้วยมือทีละตัว
- **Schematic** วาดเป็นภาพ (lines + symbols) ใน GUI
- **Layout** วางชิ้นส่วนและลาก trace บนบอร์ด
- **Fabricator communication** ส่งไฟล์ Gerber พร้อมอธิบาย constraint ซ้ำซากทุกครั้ง

ผลคือ PCB กลายเป็น "forgotten middle child of technology" — ช้าเกินไปสำหรับยุคที่ software iterate รายวัน

### ปัญหา Supply Chain และ Hardware Renaissance

สหรัฐฯ พึ่งพาการผลิต PCB จาก Asia มาหลายทศวรรษ ทำให้เปราะบางทั้งด้าน supply chain และความสามารถแข่งขัน Diode เกิดขึ้นเพื่อแก้ทั้งสองปัญหาพร้อมกัน — เร่งการ design **และ** ฟื้นฟูการผลิตบน US soil

### ทีมผู้ก่อตั้ง

- **Davide Asnaghi** (CEO) — อดีตวิศวกรที่ Apple และ Butterfly Network มีพื้นเพอิตาเลียน ประสบการณ์ธุรกิจอเมริกา และ insight จากการผลิตในเอเชีย
- **Lenny Khazan** (co-founder) — ร่วมก่อตั้งและ build ระบบ AI core

Diode เข้าร่วม Y Combinator Summer 2024 batch

## Deep Dive

### 1. Zener — ภาษา Schematics-as-Code

หัวใจของ Diode คือ **Zener** — open-source DSL (Domain-Specific Language) ที่สร้างบน Starlark (subset ของ Python) สำหรับอธิบาย schematic เป็น code แทนภาพ

```python
# ตัวอย่างแนวคิด Zener: อธิบาย decoupling cap เป็น code
module bypass_cap(net vcc, net gnd, capacitance value=100nF):
    C = capacitor(value)
    connect(C.plus, vcc)
    connect(C.minus, gnd)
```

**ทำไม schematics-as-code ถึงเปลี่ยนเกม:**

| แบบเดิม (GUI) | Zener (Code) |
|---|---|
| ไฟล์ binary, merge ยาก | Version control + code review ปกติ |
| LLM อ่านภาพ/symbol ไม่ได้ | LLM trace signal path ได้โดยตรง |
| Fabricator constraint แยกจาก design | constraint embed ใน code ได้ |
| Copy-paste เสี่ยง error | Reuse module เป็น function call |

Zener สร้างขึ้นให้อ่านได้ทั้งสำหรับ engineer (render เป็น graphical schematic) และสำหรับ LLM (syntax Python-based ที่โมเดลคุ้นเคย)

### 2. AI Pipeline: จาก Datasheet ถึง Reference Design

Diode ใช้ **Claude (Anthropic)** เป็น LLM หลัก ร่วมกับ OpenAI models และ reinforcement learning สำหรับ smaller models ที่ตรวจจับ design mistake

**กระบวนการ automated reference design:**

```
Datasheet (PDF) 
    ↓  LLM อ่านและเข้าใจ component specs
Claude drafts Zener module 
    ↓  ครอบคลุม operating modes ต่างๆ
Automated verification
    ├── SPICE simulation (gain, bandwidth, stability margins)
    └── Static checks (floating pins, miswired connections, power paths)
    ↓  fail → model iterates; pass → human review
Engineer sign-off + publish ไปยัง library
```

**ผลลัพธ์ที่วัดได้:** ภายใน **2 สัปดาห์** pipeline สร้าง reference design ได้มากกว่า **250 modules** — ครอบคลุม simple sensors, microcontrollers, switching power stages, และ analog signal-processing chains

**Public Library** ที่ `zener.diode.computer` เปิด open-source **Internal Registry** มี higher-value modules เช่น Qualcomm/Nvidia Jetson compute platforms, RF frontends, power/sensing/communications blocks ที่ผ่าน real-world testing และ volume production แล้ว

### 3. Verification ที่ครอบคลุม

**SPICE Simulation:** ทุก Zener module รัน simulation อัตโนมัติ คืนค่า quantitative เช่น gain, bandwidth, stability margins — model iterate ถ้าวงจรไม่ผ่าน spec

**Static Checks (Rust-based verification core):**
- Netlist tracing — ตรวจ power paths และ signal directionality
- Floating pin detection
- Miswired connection detection

**Automated Placement:** AI จัด decoupling capacitor, bulk capacitor bank, label alignment อัตโนมัติ

### 4. Co-design กับ Manufacturing

Diode evolve จาก "design validation tool" มาเป็น **full-stack manufacturer** นี่คือจุดต่างจากคู่แข่ง:

- **ผลิตที่ Brooklyn Navy Yard** — ไม่ใช่แค่ออกแบบแล้วส่ง outsource
- **Manufacturing constraint อยู่ใน design ตั้งแต่ต้น** — shop-specific rules embed ใน Zener code ลด revision loop
- **Lesson จาก Shenzhen** — นำ agility และ efficiency ของ ecosystem เอเชียมาประยุกต์กับ US manufacturing

เป้าหมาย: engineer "push code" → Diode generate physical product — เหมือน deploy บน AWS

```
git push origin main
→ Diode compiles schematic
→ runs DRC/ERC
→ generates Gerber + BOM
→ schedules fabrication
→ ships board
```

### 5. ตัวเลขที่วัดได้

| Metric | ก่อน Diode | กับ Diode |
|---|---|---|
| Design cycle | หลายสัปดาห์–เดือน | หลายวัน–สัปดาห์ |
| Boards per engineer/year | ~10–20 (estimate) | **100+** |
| Reference designs (2 สัปดาห์) | — | **250+** |
| Funding (Series A, Jul 2025) | — | **$11.4M** |

### 6. Customers และ Partners

- **Physical Intelligence** — AI robotics startup
- **Saronic** — autonomous maritime
- **Fortune 100 companies** (ไม่เปิดเผยชื่อ)
- **Anthropic** — partner อย่างเป็นทางการ (teaching Claude electrical engineering)

## Caveats / Limits

- **Engineer sign-off ยังจำเป็น** — ทุก AI-generated design ต้องผ่าน human review ก่อน production Diode ไม่ใช่ "push button, get board" แบบไม่มีคน
- **LLM ยังผิดพลาดได้** — ระบบ verification ออกแบบมาจับ error แต่ analog circuit และ high-speed layout ยังต้องการ domain expertise สูง
- **ครอบคลุมบางประเภทบอร์ด** — เน้น robotics, medical, aerospace ยังไม่ใช่ทุก industry vertical
- **Full-stack lock-in** — ถ้า design อยู่ใน Zener ecosystem การ migrate ออกต้องใช้ effort
- **US-focused** — infrastructure ที่ Brooklyn Navy Yard ยังจำกัด geographic reach สำหรับลูกค้านอก US
- **Early stage** — Series A, Jul 2025 ยังเป็นช่วงเริ่มต้น scale จริง risk สูงกว่า established vendor

## References

1. [Teaching Claude To Design Circuit Boards That Ship — Diode Computers](https://blog.diode.computer/anthropic-partnership)
2. [Diode Raises $11.4M to End Circuit Board Design Frustrations — TechNews180](https://technews180.com/funding-news/diode-raises-11-4m-to-end-circuit-board-design-frustrations/)
3. [The Renaissance of American PCB Manufacturing — Frank's World](https://www.franksworld.com/2026/05/29/the-renaissance-of-american-pcb-manufacturing-davide-asnaghis-vision-with-diode/)
4. [Diode Computers: Automate circuit board design using AI — Y Combinator](https://www.ycombinator.com/companies/diode-computers-inc)
5. [Diode Computers Develops AI-Powered Tools to Revolutionize PCB Design — PCB Directory](https://www.pcbdirectory.com/news/diode-computers-develops-ai-powered-tools-to-revolutionize-pcb-design-and-manufacturing)
6. [Diode Computers raises $11.4M led by a16z — B17 News](https://b17news.com/diode-computers-is-designing-circuit-boards-with-ai-it-just-raised-11-4-million-led-by-andreessen-horowitz/)

## Key Takeaways

- **Schematics-as-code คือกุญแจ** — Zener (Python/Starlark DSL) ทำให้ LLM อ่าน circuit design ได้และเปิด version control workflow เหมือน software
- **AI pipeline ไม่ใช่แค่ generate — มี verify ด้วย** — SPICE simulation + static checks (Rust core) ทำงานอัตโนมัติก่อนส่งให้ human review ทุกครั้ง
- **Full-stack = competitive moat** — การ own ทั้ง design tool และ manufacturing line ทำให้ constraint จากโรงงานอยู่ใน design ตั้งแต่ต้น ลด revision loop
- **100+ boards/engineer/year** — เพิ่มขึ้นอย่างน้อย 5x จากกระบวนการแบบเดิม วัดได้จริงไม่ใช่แค่ claim
- **Hardware Renaissance ต้องการ toolchain ใหม่** — Diode พิสูจน์ว่า "ทำ hardware ใน US ได้เร็วพอๆ กับ software" ไม่ใช่แค่ฝัน ถ้า tool stack เปลี่ยนไปด้วย
- **"Electronics is where software meets the real world"** — quote จาก Davide Asnaghi สรุป thesis ของทั้งบริษัท: hardware development ควร agile เหมือน software development
