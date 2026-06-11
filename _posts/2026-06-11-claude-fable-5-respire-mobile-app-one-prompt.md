---
title: "Claude Fable 5 สร้าง Mobile App ได้ในพรอมต์เดียว: เฟรมเวิร์ก AGENT + Hermes Telegram"
date: 2026-06-10 00:05:00 +0700
categories: [Engineering]
tags: [claude, fable-5, mobile-app, flutter, agent-framework, prompt-engineering, telegram, claude-code]
---

## TL;DR

Claude Fable 5 สร้างแอปฝึกหายใจ Respire ที่ใช้งานได้จริง — แอนิเมชันเฉพาะตัว, เสียงประกอบ, ระบบ favorites — จากพรอมต์เดียวในเวลา 30 นาที โดยใช้เฟรมเวิร์ก **AGENT** (Ask, Goal, Examples, Negations, Tools) และระบบ Hermes Agent บน Telegram ที่เชื่อมกับ Claude Code ช่วย craft prompt โดยอัตโนมัติขณะเดินทาง

## Background / Why this matters

ที่ผ่านมา การสร้าง mobile app ต้องใช้ทีมนักพัฒนา, designer, และ QA เป็นเวลาหลายสัปดาห์ถึงหลายเดือน แม้แต่ MVP ที่ง่ายที่สุดก็ต้องการ boilerplate setup, state management, animation library, และ build toolchain ก่อนที่จะเห็น pixel แรกบนหน้าจอ

Claude Fable 5 เปลี่ยนสมการนี้ด้วยการ collapse ขั้นตอนทั้งหมดเข้าสู่ single inference loop ที่ model วางแผน architecture, เขียนโค้ด, ตั้งค่า build environment, และส่งออกไฟล์ APK ในคราวเดียว สิ่งที่เปลี่ยนแปลงไม่ใช่แค่ความเร็ว — แต่คือ **ใครสามารถสร้างผลิตภัณฑ์ได้** คนที่ไม่เคยเขียนโค้ด Flutter หรือ React Native สามารถมี installable Android app บนมือถือได้ภายใน 30 นาที

## Deep Dive

### Respire: สิ่งที่ Claude สร้างจากพรอมต์เดียว

แอป Respire เป็น breathing technique trainer ที่มี:

- **หลายเทคนิค**: Box Breathing, Coherent Flow, และอื่นๆ แต่ละเทคนิคมีคำอธิบาย, การตั้งค่าเวลา, และ animation เฉพาะตัว
- **Custom animations**: Box Breathing ใช้ animation แบบหนึ่ง, Coherent Flow ใช้ wave animation ขึ้น-ลงที่แตกต่างกันโดยสิ้นเชิง — Claude ตัดสินใจ design เองว่าอะไรเหมาะกับแต่ละเทคนิค
- **Sound effects**: เสียงประกอบที่ช่วย cue การหายใจ ไม่ต้องมอง screen ตลอดเวลา
- **UX features** ที่ไม่ได้ขอ: filter ระดับ (intermediate, advanced) และ favorites system
- **Build output**: APK ที่ติดตั้งบน Android ได้จริง

ชื่อเดิมที่ Claude ตั้งให้คือ "Halakon" — ผู้สร้างส่ง second prompt เพียงประโยคเดียวว่า "I want the app's name to be Respire" และจบ session

### เฟรมเวิร์ก AGENT

AGENT คือ prompt contract ที่ผู้สร้างพัฒนาขึ้นเพื่อสั่งงาน Claude Code โดยเฉพาะเมื่อใช้คำสั่ง `/goal` ซึ่งบอกให้ Claude ทำงานต่อเนื่องจนกว่าจะถึงเป้าหมายโดยไม่หยุดถามทุกขั้นตอน

| ตัวอักษร | ความหมาย | ตัวอย่างใน Respire |
|----------|----------|-------------------|
| **A** — Ask | คำขอที่ชัดเจน: สร้างอะไร, บน platform ไหน, output format คืออะไร | "Build a mobile-first breathing app, export as APK" |
| **G** — Goal | เงื่อนไขหยุด: Claude ยืนยัน goal แล้วทำงานจนครบ — ไม่หยุดกลางทาง | "Stop only when app is built, transferred, tested on emulator" |
| **E** — Examples | Design references: บอก quality bar โดยไม่ copy brand | "Inspired by Headspace/Calm for softness and polish, but original" |
| **N** — Negations | ข้อห้ามชัดเจน: ป้องกัน default ที่ไม่ต้องการ | "No generic timer UI, no unsafe medical claims, no cloud login for MVP" |
| **T** — Tools | Stack แนะนำ: ให้ Claude เลือกจาก known frameworks | "React Native, Expo EAS, Flutter — pick what builds APK fastest" |

เหตุผลที่ **Negations** สำคัญมาก: LLM มี default pattern ที่ดึงดูดไปหาโซลูชันทั่วไป การบอก "ไม่ต้องการอะไร" ชัดๆ ป้องกัน model จาก safe-but-boring defaults ได้ดีกว่าการ describe ว่า "ต้องการอะไร" อย่างเดียว

### Hermes Telegram + Claude Code Integration

ผู้สร้างไม่ได้เขียน AGENT prompt ยาวๆ ด้วยมือเอง — แต่ใช้ Hermes agent บน Telegram ขณะเดินทาง workflow คือ:

```
[ไอเดียคร่าวๆ] → Telegram → Hermes → [AGENT contract สำเร็จรูป] → paste เข้า Claude Code
```

Hermes มี 2 custom skills ที่ทำงานร่วมกัน:

1. **`agent-goal`** — รับ idea คร่าวๆ แล้ว auto-format เป็น AGENT contract ครบ 5 ส่วน
2. **`align`** — ก่อน format จะถาม 3 คำถาม clarify: format, vibe, และ complexity ของแอป เพื่อให้ prompt ตรง vision จริงๆ

Hermes sync กับ Claude Code ผ่าน shared "second brain" workspace ซึ่งหมายความว่า context, skills, และ memory ที่อยู่ใน Claude Code ก็อยู่ใน Hermes ด้วย ทำให้ agent บน Telegram รู้จัก codebase, preferences, และ conventions เดียวกัน

### Token Cost และการประหยัด

การสร้าง app ทั้งตัวใน single session กิน token สูงมาก:

| แผน | ผลกระทบ |
|-----|---------|
| Max 20x (plan สูงสุด) | ใช้ **3–5% ของ weekly rate limit** ต่อ 1 app |
| Pro (แผนทั่วไป) | อาจใช้ quota หมดจาก **1 app เดียว** |

**วิธีประหยัด**: ตั้ง Effort level เป็น **Low** ใน Claude Code

Claude Fable 5 ที่ Effort Low ยังสามารถสร้าง MVP ที่ใช้งานได้จริงแบบ Respire ได้สำเร็จ ความแตกต่างหลักคือ model จะใช้ reasoning tokens น้อยลงต่อ step แต่ยังคง code generation capability ไว้

```
# Claude Code — ตั้ง Effort ก่อนเริ่ม session ใหญ่
/effort low
/goal [AGENT contract ของคุณ]
```

## Caveats / Limits

- **One-shot ≠ production-ready**: Respire คือ MVP — ไม่มี error handling ครบ, ไม่มี accessibility audit, ไม่มี performance profiling
- **APK ไม่ผ่าน Play Store**: APK ที่ export มาต้องเปิด "Unknown Sources" บน Android — ไม่ใช่ signed release build
- **Token quota**: ผู้ใช้ Pro plan ควรวางแผนว่าจะสร้าง app ช่วงต้นรอบ billing หรือตั้ง Effort Low ตั้งแต่ต้น
- **ชื่อ "Halakon"**: Claude เลือกชื่อจาก training data — อาจชนกับ existing trademark ควรตรวจสอบก่อน launch จริง
- **Hermes + Telegram**: integration นี้เป็น custom setup ส่วนตัวของผู้สร้าง ไม่ใช่ feature ใน Claude Code มาตรฐาน

## References

1. "Claude Fable 5 Destroys Every Mobile App Designer" — YouTube, [https://youtu.be/k2VtfRCgXJI](https://youtu.be/k2VtfRCgXJI) (แหล่งหลักของบทความนี้: transcript + demo)
2. Claude Fable 5 release — Anthropic, [https://www.anthropic.com/news/claude-fable-5](https://www.anthropic.com/news/claude-fable-5)
3. Claude Code `/goal` command — Claude Code docs, [https://docs.anthropic.com/en/docs/claude-code/cli-usage](https://docs.anthropic.com/en/docs/claude-code/cli-usage)
4. Expo EAS Build — [https://docs.expo.dev/build/introduction/](https://docs.expo.dev/build/introduction/)
5. Flutter — Google, [https://flutter.dev/](https://flutter.dev/)

## Key Takeaways

- Claude Fable 5 สร้าง installable Android APK ได้จาก single prompt ใน ~30 นาที รวม custom animation และ UX features ที่ไม่ได้ขอ
- เฟรมเวิร์ก **AGENT** (Ask, Goal, Examples, Negations, Tools) คือ prompt contract ที่ป้องกัน LLM จาก safe-but-boring defaults และบอกเงื่อนไขหยุดที่ชัดเจน
- **Negations** มักสำคัญกว่า requirements — บอกว่า "ไม่ต้องการอะไร" ป้องกัน default patterns ได้ตรงจุดกว่า
- ระบบ Hermes Telegram → Claude Code ช่วย craft AGENT prompt บนมือถือขณะเดินทาง — ไม่ต้องเปิด IDE
- ผู้ใช้ Pro plan: ตั้ง **Effort Low** ก่อนสร้าง app ใหญ่ — Fable 5 ที่ Effort Low ยังสร้าง MVP ได้สำเร็จ
- One-shot mobile app = MVP เท่านั้น — ยังต้องผ่าน signing, accessibility audit, และ performance review ก่อน production
