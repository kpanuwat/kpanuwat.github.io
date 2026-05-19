---
marp: true
theme: default
paginate: true
---

# Spec-Driven Development

**ใช้ Spec เป็น Contract อุดรอยรั่วของ Vibe Coding**

---

## TL;DR

- SDDD ใช้ **Specification เป็น Contract** กำหนดขอบเขตก่อน AI เขียนโค้ด
- ลด Ambiguity ของ AI Agent — ผลลัพธ์แม่นยำและคาดเดาได้
- **OpenSpec** คือ SDDD framework อันดับต้น: เบา, ฟรี, รองรับ Existing Systems

---

## ปัญหาของ Vibe Coding

Vibe Coding = Prompt ลอยๆ → LLM เดาใจ

ปัญหาหลัก 2 อย่าง:

1. **Ambiguity** — AI ไม่รู้ขอบเขตงานจริง: ทำมากไป / น้อยไป / เบี่ยงผิดทาง
2. **Instability** — ผลลัพธ์เปลี่ยนตาม Prompt phrasing แม้ Intent เดิม → Reproduce ยาก

---

## SDDD คืออะไร

> **Specification = Contract** ที่กำหนดขอบเขต พฤติกรรม และเงื่อนไขของระบบล่วงหน้า ก่อนเริ่มเขียนโค้ดจริง

**Spec = Primary Artifact** ควบคุม:
- Code generation
- TDD (Test-Driven Development)
- Verification

แทนที่จะให้ AI ตัดสินใจเองทุกครั้ง

---

## ตลาด SDDD (2025–2026)

ตลาดโต **+131% ใน 6 เดือน**

| Framework | สถานะ | จุดแข็ง |
|-----------|--------|---------|
| **OpenSpec** | ⬆ +863% stars | เบา, ฟรี, existing systems |
| **SpecKit (GitHub)** | ⬆ เติบโต | แบรนด์ GitHub |
| **BMAT v6** | 🔄 Major update | Enterprise |
| **Taskmaster** | ⏸ ชะงัก | เน้น commercial เกินไป |
| **Agent OS** | ❌ ยุติพัฒนา | — |

---

## Wild Card: Native Tooling

Claude Code **Plan Mode / Ultra Plan Mode** ดูดซับความสามารถหลักของ SDDD ไปแล้ว

กรอบแข่งขันเปลี่ยน:

> ~~Framework A vs Framework B~~
> **Framework vs Native Tooling**

Framework ที่ยังมีที่ยืนต้องนำเสนอสิ่งที่ native tools ทำไม่ได้:
- Persistent artifacts ข้ามเซสชัน
- Delta tracking
- Multi-agent integration

---

## OpenSpec v1: 5 คำสั่งหลัก

```
openspec explore   → clarify ambiguity
openspec new       → create new spec slice
openspec continue  → continue spec slice
openspec validate  → completeness check
openspec archive   → merge deltas back to spec
```

ครอบ lifecycle ตั้งแต่ clarify ไปจนถึง maintain spec

---

## explore + new / continue

**`explore`** — เคลียร์ Ambiguity ก่อนร่างแผน
- ระบุ assumption ที่ผิด ก่อนเขียน spec

**`new` + `continue`** — Spec Slicing
- แบ่งงานเป็น Slices (ชิ้นย่อยที่จัดการได้)
- แต่ละ slice สร้าง:
  - `design.md` — Architecture: component, data flow, interface
  - `proposal.md` — Scope: งาน, เงื่อนไข, acceptance criteria
  - **To-do list** — พร้อม implement ทันที

---

## validate + archive

**`validate`** — Completeness Scan
- ใช้ Chrome Browser MCP สแกนความสมบูรณ์
- ตรวจ: requirement ครบ, ไม่มี gap, acceptance criteria วัดได้จริง

**`archive`** — Source of Truth Maintenance
- Merge **delta files** (ความเปลี่ยนแปลงระหว่าง implement) กลับ spec หลัก
- ป้องกัน spec หลุดยุค (outdated) ในระยะยาว

---

## OpenSpec vs SpecKit / Kiro

| ด้าน | OpenSpec | SpecKit / Kiro |
|------|---------|----------------|
| **เหมาะสำหรับ** | Existing systems | New projects |
| **โครงสร้าง** | current spec + proposal (delta) | spec ชุดเดียว |
| **ต้นทุน** | ฟรี | ฟรี / paid tier |
| **ขนาด** | Lightweight | Feature-rich |
| **Token cost** | ต่ำกว่า | ขึ้นกับ implementation |
| **AI Agent** | Claude Code, Cursor, Kilo Code | Claude Code, Cursor |

---

## User Guide: Workflow พื้นฐาน

```
1. openspec explore "feature ที่ต้องการ"
   → เคลียร์ ambiguity จนชัด

2. openspec new "feature-slug"
   → สร้าง design.md + proposal.md + todo list

3. implement งานตาม todo list

4. openspec validate
   → scan spec ครบและ implementation ตรง

5. openspec archive
   → merge delta กลับ spec หลัก
```

---

## Integration กับ Claude Code

ใช้ `proposal.md` + `design.md` เป็น context ให้ Claude Code implement ตาม spec

ผลลัพธ์:
- Code generation **แม่นยำขึ้น**
- ผลลัพธ์ **คาดเดาได้**
- Task verification จาก acceptance criteria ใน `proposal.md`
- **Token cost ต่ำลง** — ไม่ต้องโหลด context ขนาดใหญ่ทั้งหมด

---

## Caveats / Limits

- **Learning curve** — SDDD เพิ่ม upfront work; รู้สึกช้ากว่า vibe coding สำหรับ prototype
- **Native tooling pressure** — Claude Code Plan Mode ทำ spec-like planning ได้ในตัว; ถ้าไม่ต้องการ persistent artifacts อาจไม่จำเป็น
- **Market stats** — ตัวเลข +131% / +863% เป็น snapshot ณ ช่วงเวลาหนึ่ง ตรวจสอบ GitHub stars ปัจจุบัน
- **Chrome Browser MCP** — ระบบ validate พึ่ง browser automation; อาจต้อง skip ถ้า environment ไม่รองรับ

---

## Key Takeaways

- **Spec = Contract**: กำหนดขอบเขตและพฤติกรรมก่อน AI เขียนโค้ด — ลด ambiguity มีนัยสำคัญ
- **OpenSpec ชนะขาด**: +863% ด้วยความเบา ฟรี และรองรับ existing systems ได้ดีกว่า
- **Native tools เป็น wildcard**: Claude Code Plan Mode ดูดซับ SDDD บางส่วน — frameworks ต้องนำเสนอ persistent artifacts และ delta tracking
- **5 คำสั่ง**: `explore` → `new`/`continue` → `validate` → `archive`
- **Delta format**: แยก current spec / proposal — ป้องกัน AI overwrite behavior เดิมโดยไม่ตั้งใจ
