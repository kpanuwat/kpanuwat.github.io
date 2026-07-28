---
title: "เลิก Vibe Coding เปลี่ยนมาทำ Agentic Engineering: ลด Maintenance Cost ด้วย Deep Modules และ Hexagonal Architecture"
date: 2026-07-27 00:01:00 +0700
categories: [Engineering]
tags: [agentic-engineering, vibe-coding, technical-debt, software-architecture, hexagonal-architecture, deep-modules, ci-cd, spec-driven-development]
---

## TL;DR

**Vibe coding** (ปล่อยให้ AI เขียนโค้ดโดยไม่อ่าน diff) ลด initial cost แต่ผลักภาระไปเป็น **maintenance cost** ที่บวมขึ้นเรื่อยๆ — แม้แต่ Andrej Karpathy คนที่บัญญัติคำนี้เองก็เปลี่ยนไปใช้คำว่า **Agentic Engineering** แทน แนวทางที่ถูกต้องคือคง human judgment ไว้ใน 2 ขั้นตอนแรกของ dev lifecycle (กำหนดว่าจะสร้างอะไร + groom spec ให้ชัด) ปล่อยให้ agent ทำงาน coding/guardrail แทนได้เต็มที่เมื่อ spec ชัดและมี test คลุม และลง foundation ด้วย code architecture ที่ดี — **Deep Modules** (interface ง่าย ซ่อนความซับซ้อน) และ **Hexagonal Architecture** (แยก core logic ออกจาก adapter ภายนอก) เพื่อให้ทั้งคนและ agent maintain โค้ดได้โดยไม่ต้อง overload context

## Background / Why this matters

ต้นทุนของซอฟต์แวร์แบ่งเป็น 2 ก้อน: **initial cost** (ต้นทุนตอนสร้างครั้งแรก) กับ **maintenance cost** (ต้นทุนดูแลรักษาตลอดอายุการใช้งาน) McKinsey ประเมินว่าองค์กรใช้งบประมาณราว 20% ของต้นทุนพัฒนาเริ่มต้นไปกับการดูแลรักษาซอฟต์แวร์ในแต่ละปี [4] ตัวเลขนี้สะสมข้ามหลายปีของอายุการใช้งาน ทำให้ maintenance กลายเป็นสัดส่วนที่ใหญ่ที่สุดของต้นทุนรวมตลอดอายุซอฟต์แวร์ — และยิ่งซอฟต์แวร์อายุมาก มีฟีเจอร์เพิ่มมากเท่าไหร่ ต้นทุนส่วนนี้ก็ยิ่งเพิ่มขึ้นเรื่อยๆ ไม่มีเพดาน

การมาของ AI coding assistant ทำให้ initial cost ถูกลงมากอย่างที่ไม่เคยเป็นมาก่อน ใครๆ ก็ "สร้างบ้าน" ได้โดยไม่ต้องมีความรู้สถาปัตยกรรม แต่ถ้าไม่มีคนดูแล maintenance cost มันจะกลายเป็น **net negative** — ข้อมูลจาก GitClear ปี 2024 พบว่าโค้ดที่ซ้ำกัน (duplicated code) เพิ่มขึ้นถึง 8 เท่า เทียบกับ 2 ปีก่อนหน้า และสัดส่วนโค้ดที่ copy-paste แซงหน้าโค้ดที่ผ่านการ refactor ไปแล้ว [5][6] ขณะที่ Google DORA report พบว่าการใช้ AI ช่วยเร่งความเร็วรีวิวโค้ด แต่สัมพันธ์กับ **delivery stability ที่ลดลง 7.2%** [6] นี่คือหลักฐานเชิงตัวเลขว่า "vibe coding โดยไม่มี guardrail" กำลังสร้าง technical debt สะสมจริงในวงกว้าง ไม่ใช่แค่ความรู้สึก

## Deep Dive

### Vibe Coding คืออะไร ทำไมถึงมีปัญหา

คำว่า "vibe coding" มาจากทวีตของ **Andrej Karpathy** (co-founder ของ Anthropic และอดีตหัวหน้า AI ของ Tesla) เมื่อกุมภาพันธ์ 2025:

> "There's a new kind of coding I call 'vibe coding', where you fully give in to the vibes, embrace exponentials, and forget that the code even exists... I 'Accept All' always, I don't read the diffs anymore." [1]

ประเด็นสำคัญคือ Karpathy พูดถึงการเขียนโค้ดแบบนี้ในบริบทของ **throwaway weekend project** ไม่ใช่ production software — แต่คำนี้ถูกใช้แบบ marketing term จนกลายเป็นวิธีทำงานจริงจังของหลายคน ที่แย่กว่านั้นคือ "vibe coder" จำนวนมากไม่ยอมอ่านโค้ดเลย ไม่สนใจว่ามันทำงานยังไง ขอแค่ "รันได้" — สิ่งนี้ต่างจาก **Exploratory Coding** ที่มีมาก่อน AI ซึ่งเขียนโค้ดแบบไม่สนใจ architecture เพื่อ *explore solution* ก่อน แล้วค่อยกลับมา refactor ให้ maintain ได้ง่ายทีหลัง — vibe coding ตัดขั้นตอน refactor นั้นทิ้งไปเลย

ผลกระทบที่เกิดขึ้นจริงในวงการ open source:

- **curl**: Daniel Stenberg (bagder) ต้องรวบรวมรายงานช่องโหว่ความปลอดภัยกว่า 49 รายการที่สงสัยว่าเป็น "AI slop" — รายงานปลอมที่ AI สร้างขึ้นเพื่อหวังเงินรางวัล bug bounty โดยไม่ได้ผ่านการตรวจสอบจริง จนกลายเป็นการ DoS ใส่กระบวนการ maintain ของโปรเจกต์เอง [7]
- **Ghostty**: Mitchell Hashimoto (ผู้สร้าง HashiCorp/Terraform) วางกับดักใน `AGENTS.md` ของโปรเจกต์ โดยฝัง prompt injection ที่สั่งให้ agent สร้างไฟล์ข้อความ "I am a sad, dumb little AI driver with no real skills" หากมีคนสั่ง agent เปิด PR โดยไม่ได้อ่านโค้ดเอง ใช้เป็นตัวกรองคนที่ contribute แบบไม่รับผิดชอบ [8][9]

### จาก Vibe Coding สู่ Agentic Engineering

ที่น่าสนใจคือ Karpathy เองก็เปลี่ยนคำที่ใช้ ในทวีตล่าสุดเขาบอกว่าไม่ชอบคำว่า "vibe" ที่ตัวเองบัญญัติเท่าไหร่ เพราะมันสื่อถึงความไม่ใส่ใจ เขาหันมาใช้คำว่า **Agentic Engineering** แทน เพราะคำว่า "engineering" สื่อว่างานนี้ยังต้องมีศาสตร์และศิลป์ ไม่ใช่แค่ปล่อยให้ agent ทำเองทั้งหมด [2]

หัวใจของ Agentic Engineering คือ software engineer ผันตัวจาก "คนออกแบบและ implement ระบบ" มาเป็น "คนออกแบบ factory หรือระบบที่สร้างระบบ" ที่ยังคุม quality ได้ — ไม่ใช่การเลิกใช้ AI แต่คือการใช้ AI แบบเข้าใจ

### 4 ขั้นตอนของ Development Lifecycle — ตรงไหนควรให้ agent ทำ ตรงไหนต้องเป็นคน

งานของ software engineer แบ่งได้ 4 ขั้นตอน:

1. **What do I need to build** — คุยกับ product stakeholder, จัด priority ของ sprint/สัปดาห์นี้ ดึงจาก backlog (เช่น GitHub Issues/Projects) และ design document ที่ผ่านการรีวิวมาแล้ว
2. **Groom the spec** — เช็คว่าแต่ละ ticket มี requirement ครบ มี test scenario ชัดเจน เชื่อมกับ third-party ยังไง ถ้าสเปคไม่ชัด ต้อง sync กับทีมอื่นก่อน
3. **Coding** — implement ตามสเปคที่ครบแล้ว
4. **Guardrails** — run build, run test, static analysis, security scan ก่อน merge

ขั้นตอนที่ 4 ถูก automate อยู่แล้วในทุกทีมที่มี CI/CD แต่สิ่งที่หลายคนยังไม่รู้คือ **ขั้นตอนที่ 1-3 ก็ automate ด้วย agent ได้ถึง 80-90%** — โดยมีเงื่อนไขสำคัญ:

**ขั้นตอน 1-2 ต้องผ่านสมองคนแทบทั้งหมด** เพราะเป็นการตัดสินใจว่า "อะไรควรทำ อะไรไม่ควรทำ" ถ้า AI มั่วขึ้นมาแล้วไม่มีคนเห็น ทีมอาจทำงานผิดทางทั้ง sprint และการ rework ในองค์กรใหญ่ต้องประสานหลายทีม ใช้เวลานานมาก อย่างไรก็ตาม agent ช่วยงานส่วนนี้ได้ทางอ้อม เช่น ใช้ agent อ่านโค้ดของทีมข้างเคียงเพื่อสรุปว่าระบบทำงานยังไง แล้ว propose solution ที่ชัดเจนให้อีกทีม sign-off ได้เร็วขึ้น โดยไม่ต้องรอประชุม

**ขั้นตอน 3 (coding) แบ่งเป็น 2 ประเภท:**

| ประเภทงาน | ลักษณะ | ระดับ automation |
|---|---|---|
| Easy Fix / Safe Refactor | แก้เล็กน้อย, เพิ่ม metric, มี test คลุมอยู่แล้ว, behavior ต้องเหมือนเดิม | เกือบ 100% — ปล่อย agent ทำได้เต็มที่ถ้า test ผ่านและไม่แหกดีไซน์เดิม |
| Large Feature / Non-trivial Change | ต้องออกแบบ subsystem ใหม่, ไม่มีตัวอย่างใน codebase ให้ล้อตาม | ต้องมี human-in-the-loop เยอะ — คนต้องคอย guide ว่าโซนไหนควรทำแบบไหน |

เกณฑ์รีวิว PR ที่มาจากงานประเภทแรก: เช็คแค่ว่า test make sense (ไม่ได้ hack ให้ผ่าน) และ implementation ไม่แหวกดีไซน์ที่วางไว้ ที่เหลือปล่อยให้ CI/CD คุม quality — เพราะสเปคชัดเจนและ deterministic อยู่แล้ว

### Root Cause ของโค้ดที่แก้ไม่ได้: Architecture ไม่ใช่ตัวคน

นิยาม "bad code" ที่เข้าใจง่าย: **โค้ดที่แก้ไขได้ยาก** — ต้องแก้หลายจุดเพราะมี duplication, ไม่มี test coverage, หรือผูก (couple) กับ infrastructure แน่นเกินไปจนอัปเกรดไม่ได้ กรณีร้ายแรงสุดคือระบบ legacy ที่ทีม maintain บอกว่า "แตะไม่ได้เลย" จนต้องเขียนใหม่ทั้งระบบ — นี่คือจุดที่ **root cause ไม่ใช่คนเขียนโค้ดแย่ แต่คือ code architecture ที่ไม่ดีบวกกับไม่มี test coverage** ซึ่งเป็นปัญหาที่มองไม่เห็นจนกว่าจะสายเกินไป

Software architecture ในความหมายทั่วไปหมายถึงการออกแบบระบบระดับใหญ่ (messaging, service boundary) [3] แต่ **code architecture** ในบทความนี้หมายถึงการออกแบบโค้ดระดับ module — เขียนยังไงให้ maintain ง่าย มี 2 แนวคิดหลักที่ช่วยได้โดยไม่เพิ่ม overhead มากและใช้ได้กับทุกภาษา:

#### 1. Deep Module, Simple Interface

แนวคิดนี้มาจาก concept "Deep Modules" ใน software design [10]: module ที่ดีควร **ซ่อนความซับซ้อนของ implementation ไว้หลัง interface ที่ใช้งานง่าย** — caller ไม่จำเป็นต้องรู้กลไกข้างใน แค่รู้ว่าเรียกอะไรแล้วได้อะไรกลับมา

ถ้า codebase มี module เล็กๆ กระจัดกระจายเป็นร้อยตัว การไล่โค้ดจะทำให้คน (และ agent) "หลง" ไปเรื่อยๆ จนลืมว่าตอนแรกมาจากไหน — แต่ถ้ามี **deep module** แค่ 20-30 ตัวที่แต่ละตัว abstract ความซับซ้อนไว้ข้างในดีพอ การทำความเข้าใจ codebase ทั้งระบบจะง่ายขึ้นมาก

นี่คือ concept เดียวกับ **context engineering** — แต่เป็นการทำ context engineering ให้กับ software engineer (และตอนนี้รวมถึง agent ด้วย) การมี interface ที่ดีและ test ครอบคลุมการทำงานของ deep module พอ ทำให้คนที่ maintain ไม่ต้องเข้าไปอ่านโค้ดข้างในโมดูลนั้นเพื่อรู้ว่ามันทำงานยังไง — ประหยัดทั้ง context window ของ AI และ "context window" ในหัวคน

#### 2. Hexagonal Architecture (Ports and Adapters)

แนวคิดนี้บัญญัติโดย **Alistair Cockburn** ตั้งแต่ปี 2005 [11]: มอง core business logic เป็นศูนย์กลาง ล้อมรอบด้วย **port** (จุดเชื่อมต่อ) ที่คุยกับโลกภายนอกผ่าน **adapter** เฉพาะเทคโนโลยี ทำให้แอปพลิเคชัน "ถูกขับเคลื่อนได้เท่าๆ กันไม่ว่าจะโดยผู้ใช้ โปรแกรม automated test หรือ batch script" โดยไม่ผูกติดกับเทคโนโลยีใดเทคโนโลยีหนึ่ง

ตัวอย่างจาก Todo app (มี source code ตัวอย่างทั้ง Go และ Ruby ตามที่ผู้สร้างวิดีโอเผยแพร่ไว้ [12]):

- **Driving Port** — ฝั่งที่คนอื่นมา "บังคับ" แอป เช่น `add`, `remove`, `toggle`, `view` — เปรียบเหมือน game controller ที่เสียบเข้ามาสั่งงาน แอปสามารถมี adapter หลายแบบมาเสียบพอร์ตนี้ได้ เช่น CLI adapter หรือ web adapter โดยไม่ต้องแก้ core logic เลย
- **Driven Port** — ฝั่งที่แอป "พึ่งพา" โค้ดอื่นในการทำงาน เช่น persistence layer แอปกำหนดแค่ interface (`save`, `remove`, `load`, `load all`) โดยไม่สนใจว่าข้างในเก็บลงไฟล์, memory หรือ database จริง — สลับ adapter ได้เลยโดยไม่ต้องแตะ core (เช่น เปลี่ยนจาก `file persistence` เป็น `SQL persistence` แค่เขียน adapter ใหม่ 1 ตัว)
- **Renderer เพื่อ testability** — แยก interface การ render ออกจาก business logic ทำให้เวลารัน test ไม่ต้อง print อะไรออกหน้าจอเลย (swap เป็น no-op renderer ได้) แต่ยังตรวจสอบได้ว่าระบบพิมพ์อะไรออกมาถ้าจำเป็น

จุดสำคัญ: เวลาต้องอัปเกรดหรือเปลี่ยนเทคโนโลยี สิ่งที่เปลี่ยนคือ **adapter** เท่านั้น ส่วน core logic ตรงกลางแทบไม่ต้องแตะเลย — เหมือนต่อ Lego ที่ข้อต่อไม่เท่ากันแต่ประกอบกันได้ทุกชิ้น ทำให้ codebase มีความยืดหยุ่นสูงและปลอดภัยต่อการเปลี่ยนแปลงในระยะยาว ทั้งเวลาคนแก้เองหรือปล่อยให้ agent แก้

## User Guide (Step-by-Step)

การเริ่มปรับทีมจาก vibe coding มาเป็น agentic engineering ทำได้แบบค่อยเป็นค่อยไป:

1. **จัด backlog ให้ agent เข้าถึงได้** — ใช้ GitHub Issues/Projects (หรือ tracker ที่มีอยู่) จัด priority ให้ agent harness เข้าไปอ่านได้ผ่าน integration ที่มีสิทธิ์เข้าถึงโค้ด, เปิด PR, อ่าน issue
2. **แยก ticket เป็น 2 ประเภทตั้งแต่ grooming** — label ว่าเป็น `for-agent` (easy fix / safe refactor ที่มีสเปคชัด+test คลุม) หรือ `needs-human-design` (large feature) เพื่อ route งานให้ถูกช่องทางตั้งแต่ต้น
3. **รัน agent แบบ scheduled สำหรับงาน `for-agent`** — ตั้ง agent (เช่น ผ่าน CLI agent บนเครื่อง dev หรือ scheduled job) ให้กวาดงานที่ label ไว้แล้วมาแก้เป็นระยะ (เช่น ทุกชั่วโมง) โดยอาศัยสเปคที่ชัดเจนเป็นตัวกำกับ
4. **รีวิว PR แบบเน้น test-sanity + design-fit** — ไม่ต้องอ่านทุกบรรทัด เช็คแค่ว่า test สมเหตุสมผล (ไม่ถูก hack ให้ผ่าน) และ implementation ไม่แหกดีไซน์เดิม ปล่อยที่เหลือให้ CI/CD guardrail (build, test, static analysis, security scan) คุม
5. **ลงทุนออกแบบ deep module + hexagonal boundary ก่อนเริ่ม large feature** — สำหรับงานที่ต้องสร้าง subsystem ใหม่ ให้ทีมนั่งออกแบบ port/adapter และขอบเขต module ก่อน ค่อยปล่อยให้ agent (หรือคน) implement รายละเอียดข้างใน
6. **ตั้ง trap/guard สำหรับ contributor ที่ไม่รับผิดชอบ** (สำหรับ open source หรือทีมใหญ่) — พิจารณาแนวทางแบบ Ghostty ที่ฝัง instruction ตรวจจับคนที่ไม่อ่าน diff ของตัวเอง

## Caveats / Limits

- แนวทางนี้ไม่จำเป็นสำหรับซอฟต์แวร์ทุกประเภท — โปรเจกต์ส่วนตัว, informative website ที่ไม่ซับซ้อน หรือซอฟต์แวร์ที่ไม่กระทบธุรกิจ/คนจำนวนมาก ยังใช้ vibe coding แบบเดิมได้โดยไม่มีปัญหา
- ตัวเลข McKinsey (~20% ต่อปี) มาจาก secondary source (AgileEngine) ที่อ้างอิง McKinsey ไม่ใช่ตัวเลขที่ยืนยันได้ตรงจากรายงานต้นฉบับโดยตรงในการตรวจสอบครั้งนี้ [4] — ใช้เป็นค่าประมาณ ไม่ใช่ตัวเลขสัมบูรณ์
- การ retrofit hexagonal architecture หรือ deep module เข้ากับ legacy codebase ที่มีอยู่แล้วมีต้นทุนสูงกว่าการออกแบบตั้งแต่ต้น — บทความ/วิดีโอต้นฉบับไม่ได้ลงรายละเอียดขั้นตอน migration
- repo ตัวอย่าง `vtno/hexagonal-examples` [12] ที่ระบุในคำอธิบายวิดีโอ ไม่สามารถเข้าถึงได้ผ่านการตรวจสอบอัตโนมัติ (GitHub API คืนค่า 404) ณ เวลาที่เขียนบทความนี้ — อาจเป็น repo private, ถูกเปลี่ยนชื่อ, หรือยังไม่ถูก push ขึ้นสาธารณะ ควรตรวจสอบ URL ก่อนใช้อ้างอิง
- การ label ticket เป็น `for-agent` ยังต้องอาศัยวิจารณญาณและประสบการณ์ของ senior engineer ในทีมเพื่อประเมินว่าอันไหน "สเปคชัดจริง" — ไม่มีเกณฑ์อัตโนมัติที่แม่นยำ 100%

## References

1. [Andrej Karpathy — original "vibe coding" tweet](https://x.com/karpathy/status/1886192184808149383)
2. [Andrej Karpathy — moved on to "Agentic Engineering"](https://x.com/karpathy/status/2019137879310836075)
3. [Software architecture — Wikipedia](https://en.wikipedia.org/wiki/Software_architecture)
4. [Software Development Cost Breakdown in 2025 (citing McKinsey) — AgileEngine](https://agileengine.com/software-development-cost-breakdown-in-2025-a-complete-guide/)
5. [AI Copilot Code Quality: 2025 Look Back at 12 Months of Data — GitClear](https://www.gitclear.com/ai_assistant_code_quality_2025_research)
6. [How AI-generated code accelerates technical debt — LeadDev](https://leaddev.com/technical-direction/how-ai-generated-code-accelerates-technical-debt)
7. [AI Slop security reports to curl — gist by Daniel Stenberg (bagder)](https://gist.github.com/bagder/07f7581f6e3d78ef37dfbfc81fd1d1cd)
8. [Mitchell Hashimoto — poisoning AGENTS.md to catch unreviewed AI PRs](https://x.com/mitchellh/status/2067970516951150721)
9. [ghostty/AGENTS.md — GitHub](https://github.com/ghostty-org/ghostty/blob/main/AGENTS.md)
10. [Deep Modules — Software Engineering: A Modern Approach](https://softengbook.org/articles/deep-modules)
11. [Hexagonal Architecture — Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture)
12. [hexagonal-examples (Go/Ruby sample repo referenced in source video)](https://github.com/vtno/hexagonal-examples)
13. [ผมเลิก vibe coding แล้วครับ — TinoThamTech (source video)](https://youtu.be/KWo_sZWrs3Y)

## Key Takeaways

- Vibe coding ลด initial cost แต่ผลักภาระไปเป็น maintenance cost ที่บวมแบบไม่มีเพดาน — GitClear พบ code duplication เพิ่ม 8 เท่าในปี 2024 จากการปล่อย AI เขียนโค้ดโดยไม่รีวิว
- แม้แต่ Karpathy ผู้บัญญัติคำว่า "vibe coding" ก็เปลี่ยนมาใช้คำว่า **Agentic Engineering** เพราะต้องการสื่อว่างานนี้ยังต้องมีศาสตร์/ศิลป์ ไม่ใช่ปล่อยไหลตามความรู้สึก
- Dev lifecycle มี 4 ขั้น — **ขั้น 1-2 (จะสร้างอะไร + groom spec) ต้องเป็นคนตัดสินใจ**, ขั้น 3 (coding) แบ่งตาม "easy fix" (automate ได้เกือบเต็ม) กับ "large feature" (ต้อง human-in-the-loop), ขั้น 4 (guardrail) automate อยู่แล้วผ่าน CI/CD
- Root cause ของโค้ดที่ "แตะไม่ได้" คือ code architecture ที่ไม่ดี + ไม่มี test coverage ไม่ใช่ตัวคนเขียน
- **Deep Module** — ซ่อนความซับซ้อนไว้หลัง interface ง่ายๆ ลด context window ที่ทั้งคนและ agent ต้องแบกตอนไล่โค้ด
- **Hexagonal Architecture** — แยก core logic ออกจาก adapter ภายนอกผ่าน port/adapter ทำให้เปลี่ยนเทคโนโลยีได้โดยแทบไม่แตะ core logic
- Open source กำลังเจอปัญหา "AI slop" จริง (curl, Ghostty) — การมี guardrail และ architecture ที่ดีช่วยกรอง contribution คุณภาพต่ำได้ตั้งแต่ต้นทาง
