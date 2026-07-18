---
title: "เจาะลึก mattpocock/skills: ระบบ AI Coding Workflow ประหยัด Context Window สำหรับ Claude Code"
date: 2026-07-18 00:01:00 +0700
categories: [Tools]
tags: [claude-code, ai-agent, skills, developer-workflow, ai-coding, github]
slides: true
---

{% include slide-link.html %}

## TL;DR

`mattpocock/skills` [1] คือชุด skill สำหรับ Claude Code (และ agent อื่นๆ เช่น Cursor, Codex) ที่ Matt Pocock แชร์ตรงจาก `.agents` directory ของตัวเอง จุดเด่นคือเป็นระบบ **user-invoked** (ผู้ใช้สั่งเอง ไม่ใช่ agent เดาเอง) ที่กิน context window แค่ ~660 token ต่อ skill และวางขั้นตอนพัฒนาซอฟต์แวร์แบบมีวินัย: คุยแผนก่อน (`/grill-with-docs`) → แตกเป็น spec/ticket ถ้างานใหญ่เกิน "smart zone" → ลงมือเขียนโค้ดพร้อม TDD (`/implement`) → ให้ sub-agent รีวิวโค้ดแยกอิสระ (`/code-review`) → auto-commit เมื่อผ่านเกณฑ์

## Background / Why this matters

ปัญหาที่พบบ่อยเวลาใช้ AI coding agent คือ agent เขียนโค้ดเร็วเกินไปโดยไม่เข้าใจ requirement จริง, context window เต็มจนโมเดล "โง่ลง" กลางทาง, หรือไม่มีขั้นตอนตรวจสอบก่อน commit ทำให้ codebase ค่อยๆ เสื่อมคุณภาพ [1]

Matt Pocock (ผู้สร้างคอร์ส TypeScript ชื่อดังและอดีต core team ของหลายโปรเจกต์ open source) แก้ปัญหานี้ด้วยการรวบรวม skill ที่ตัวเองใช้งานจริงในโปรเจกต์ production ไว้เป็น repo เดียว แล้วเปิดสาธารณะ [1] ปัจจุบัน repo มี **176,203 stars และ 15,096 forks** (ตรวจสอบผ่าน GitHub API วันที่เผยแพร่บทความนี้), ใช้สัญญาอนุญาต MIT, สร้างเมื่อ 3 ก.พ. 2026 [1]

จุดที่ทำให้ระบบนี้ต่างจาก "vibe coding" ทั่วไปคือ skill ถูกออกแบบให้ผู้ใช้เป็นคน**สั่งเปลี่ยนขั้นตอน** (user-invoked) แทนที่จะปล่อยให้ agent ตัดสินใจเองทั้งหมด และแต่ละ skill กิน token น้อยมาก (~660 token) จึงไม่ทำให้ context window บวมโดยไม่จำเป็น [1]

## Deep Dive

### ติดตั้งยังไง

มี 2 วิธีหลัก ที่ยืนยันตรงจาก README ของ repo [2]:

```bash
# วิธีที่ 1: ติดตั้งทั้งชุดผ่าน skills installer (Vercel skills.sh)
npx skills@latest add mattpocock/skills
```

หรือถ้าใช้ Claude Code อยู่แล้ว ติดตั้งแบบ plugin marketplace:

```bash
claude plugin marketplace add mattpocock/skills
claude plugin install mattpocock-skills@mattpocock
```

ตัว `npx skills@latest` installer จะถามว่าจะติดตั้ง agent ตัวไหน (Claude Code, Cursor, Codex ฯลฯ) และจะ scope แบบ global หรือเฉพาะโปรเจกต์ [1][2]

### ตั้งค่าเชื่อม issue tracker

หลังติดตั้งเสร็จ ต้องรันคำสั่งนี้ **ครั้งเดียวต่อ repo** [2]:

```
/setup-matt-pocock-skills
```

คำสั่งนี้จะถาม 3 เรื่องหลัก [2]:
1. เลือก issue tracker — GitHub, Linear หรือไฟล์ local markdown
2. ตั้งค่า triage label ที่ skill อื่นๆ จะใช้สื่อสารสถานะ ticket
3. เลือก layout เอกสาร domain — context เดียวหรือ multi-context สำหรับ monorepo

### Grill-with-docs: สัมภาษณ์แปลงไอเดียเป็นแผน

ขั้นตอนแรกของ main flow คือ `/grill-with-docs` — skill นี้จะ**สัมภาษณ์ทีละคำถาม** จนกว่าทั้งคุณกับ agent จะเข้าใจตรงกัน แทนที่จะให้ agent เดาแล้วเขียนโค้ดทันที [1][2] ระหว่างสัมภาษณ์ skill จะอัปเดต `CONTEXT.md` และ Architectural Decision Records (ADR) ไปพร้อมกัน ทำให้ session ถัดไปมี "ภาษากลาง" เดียวกันไม่ต้องอธิบายซ้ำ [2]

เวอร์ชัน v1.1 ปรับปรุงส่วนนี้ให้เข้มงวดขึ้น — บังคับถามทีละคำถามจริงๆ และเพิ่ม confirmation gate กันไม่ให้ agent เริ่มเขียนโค้ดก่อนแผนจะถูกยืนยัน [3]

### Smart zone: เพดาน token ที่โมเดลยังคิดคมอยู่

แนวคิดสำคัญของ workflow นี้คือ **"smart zone"** — ช่วง token window ที่โมเดลยังให้เหตุผลได้แม่นยำ ก่อนที่ attention จะเริ่มเสื่อมและมีโอกาส hallucinate สูงขึ้น ตัวเลขที่อ้างอิงอยู่ที่ประมาณ **140,000 token** [4]

- ถ้างานเล็กพอที่จะอยู่ใน smart zone เดียว → ไปต่อที่ `/implement` ได้เลย
- ถ้างานใหญ่เกิน หรือคาดว่าต้องใช้หลาย session → ใช้ `/to-spec` บีบอัดบทสนทนาให้เป็น spec เอกสารเดียว แล้วตามด้วย `/to-tickets` เพื่อตัด spec นั้นเป็น "tracer-bullet ticket" ย่อยๆ ที่แต่ละใบประกาศ blocking dependency ของตัวเองชัดเจน [2][4]

กติกาสำคัญ: ควรอยู่ใน context window เดียวตั้งแต่ grill-with-docs ถึง to-tickets ห้าม compact หรือ clear กลางทาง เพื่อให้การสัมภาษณ์ สเปก และ ticket ต่อกันด้วยความคิดชุดเดียว ถ้า session ใกล้ชน smart zone ก่อนถึง to-tickets ให้ใช้ `/handoff` ไปต่อใน thread ใหม่แทนที่จะฝืนทำงานตอน context เสื่อมแล้ว [4]

### Implement + code-review: sub-agent ตรวจสอบตัวเอง

พอมี ticket แล้ว เริ่ม session ใหม่ (context สะอาด) อ้างอิง ticket ที่ต้องการ แล้วรัน `/implement` skill นี้ขับเคลื่อน TDD ที่จุดต่อ (seam) ของโค้ด — เขียน test ก่อน implementation จริง [1][2]

จุดเด่นที่สุดของ workflow นี้คือตอนจบของ `/implement`: มันจะเรียก **`/code-review` ผ่าน sub-agent ที่แยก context ออกจาก agent ที่เขียนโค้ด** เหตุผลคือ agent ที่เพิ่งเขียนโค้ดเองมักประเมินงานตัวเองสวยเกินจริง แต่ sub-agent context สะอาดจะตรวจสอบได้ตรงไปตรงมากว่า [1][2]

การรีวิวเป็นแบบ **2 แกน**: sub-agent หนึ่งเช็คว่าโค้ดตรงกับ spec เดิมทุกข้อไหม อีกตัวเช็คมาตรฐานโค้ดและ code smell พื้นฐานตามแนวทาง Martin Fowler [2] เมื่อผ่านทั้งสองแกน สคริปต์ implement จะ **auto-commit** งานที่เสร็จเข้า branch ปัจจุบันให้ทันที โดยไม่ต้องมีคนกด commit เอง [1][2]

### โครงสร้าง skill ทั้งหมดใน repo

จากการตรวจสอบ README โดยตรง [2] skill แบ่งเป็น 2 bucket หลัก:

| Bucket | User-invoked (คุณสั่งเอง) | Model-invoked (agent เรียกเอง) |
|---|---|---|
| Engineering | `ask-matt`, `grill-with-docs`, `triage`, `improve-codebase-architecture`, `setup-matt-pocock-skills`, `to-spec`, `to-tickets`, `implement`, `wayfinder` | `prototype`, `diagnosing-bugs`, `research`, `tdd`, `domain-modeling`, `codebase-design`, `code-review`, `resolving-merge-conflicts` |
| Productivity | `grill-me`, `handoff`, `teach`, `writing-great-skills` | `grilling` |

`ask-matt` ทำหน้าที่เป็น "router" — แผนที่รวมทุก skill ที่ผู้ใช้เรียกได้และความสัมพันธ์ระหว่างกัน [5]

## User Guide (Step-by-Step)

1. **ติดตั้ง**
   ```bash
   npx skills@latest add mattpocock/skills
   ```
   เลือก agent เป้าหมาย (เช่น Claude Code) และ scope (global หรือ project) ตาม prompt ที่ installer ถาม [1][2]

2. **ตั้งค่าเชื่อม issue tracker (ครั้งเดียวต่อ repo)**
   ```
   /setup-matt-pocock-skills
   ```
   ตอบคำถามเรื่อง tracker (GitHub/Linear/local files), triage label, และ layout เอกสาร domain ผลลัพธ์ที่คาดหวัง: skill อื่นๆ พร้อมบันทึก spec/ticket ไปที่ tracker ที่เลือกอัตโนมัติ [2]

3. **เริ่มงานใหม่ด้วยการคุยแผน**
   ```
   /grill-with-docs
   ```
   อธิบายไอเดียคร่าวๆ แล้วตอบคำถามที่ agent ถามทีละข้อ ผลลัพธ์: `CONTEXT.md` และ ADR ถูกอัปเดต พร้อมความเข้าใจตรงกันระหว่างคุณกับ agent [1][2]

4. **ถ้างานใหญ่เกิน smart zone (~140k token) — แตกเป็น spec แล้วเป็น ticket**
   ```
   /to-spec
   /to-tickets
   ```
   ทำต่อเนื่องในหน้าต่างบทสนทนาเดียวกับขั้นตอนที่ 3 ห้าม clear context ก่อนถึง `/to-tickets` [4]

5. **ลงมือ implement ทีละ ticket**
   เริ่ม session ใหม่ อ้างอิง ticket ที่ต้องการ แล้วรัน
   ```
   /implement
   ```
   ผลลัพธ์ที่คาดหวัง: โค้ดถูกเขียนพร้อม test (TDD), ตามด้วย sub-agent code-review อัตโนมัติ และ auto-commit เมื่อผ่านเกณฑ์ทั้งสองแกน [1][2]

6. **งานประจำวันอื่นๆ**
   ใช้ `/triage` ช่วยจัดลำดับความสำคัญ issue, `/improve-codebase-architecture` ตอนต้องการปรับ architecture, หรือ `/handoff` เมื่อ context ใกล้เต็มแต่ยังทำงานไม่เสร็จ [2][4]

## Caveats / Limits

- Skill ในชุดนี้ค่อนข้างเยอะ ครอบคลุมทั้ง engineering และ productivity bucket — ผู้ใช้ที่ทดลองใช้งานจริงหลายวันแนะนำว่าไม่ควรติดตั้งทั้งหมดพร้อมกัน ควรเริ่มจากไม่กี่ skill หลักที่ตรงกับ workflow ของตัวเองก่อน แล้วค่อยๆ เพิ่ม [5]
- `/tdd` (model-invoked) เหมาะกับงานที่ requirement ชัดเจนพอจะเขียน test ล่วงหน้าได้ — งาน UI ที่ยังสำรวจ (exploratory) หรือ spec ยังไม่นิ่ง อาจทำให้ TDD กลายเป็นตัวถ่วงแทนที่จะช่วยเร่งงาน [5]
- ตัวเลข "smart zone ~140k token" เป็น**แนวคิดเชิงประสบการณ์** (จากวิดีโอต้นทาง) ไม่ใช่ hard limit ที่ mattpocock/skills กำหนดไว้ในเอกสาร README/CLAUDE.md ของ repo โดยตรง — ควรตีความเป็นแนวทางคร่าวๆ มากกว่าค่าคงที่ตายตัว [2][4]
- README และ CLAUDE.md ของ repo ไม่ได้ระบุตัวเลข token overhead ต่อ skill หรือ smart zone ไว้ชัดเจนในเอกสารที่ตรวจสอบได้โดยตรง (ตัวเลข ~660 token และ ~140k token มาจากแหล่งรอง/วิดีโอ) — ผู้อ่านควรตรวจสอบเอกสารล่าสุดของ repo ก่อนอ้างอิงตัวเลขเหล่านี้ในงานที่ critical [2]
- Repo อยู่ระหว่างพัฒนาต่อเนื่อง (อัปเดตล่าสุดตรวจสอบวันที่เผยแพร่บทความนี้) ชื่อคำสั่งเคยเปลี่ยนมาแล้ว เช่น `/to-spec` เดิมชื่อ `/to-prd`, `/to-tickets` เดิมชื่อ `/to-plan`/`/to-issues` — ควร `npx skills@latest add` ใหม่เป็นระยะเพื่อรับชื่อคำสั่งล่าสุด [3]

## References

1. [GitHub - mattpocock/skills](https://github.com/mattpocock/skills)
2. [skills/README.md at main · mattpocock/skills](https://github.com/mattpocock/skills/blob/main/README.md)
3. [v1.1: /wayfinder, /to-spec, /to-tickets, /grilling improvements, and much more — aihero.dev](https://www.aihero.dev/skills/skills-changelog-v1-1-wayfinder-to-spec-to-tickets-grilling-improvements)
4. [mattpocock/skills: A complete AI Coding workflow, end-to-end (YouTube)](https://youtu.be/M6mYodf0dJM)
5. [Anyone tried mattpocock/skills for Claude Code? Here is what I found after a week — Devtalk forum](https://forum.devtalk.com/t/anyone-tried-mattpocock-skills-for-claude-code-here-is-what-i-found-after-a-week/244771/last)
6. [skills/CLAUDE.md at main · mattpocock/skills](https://github.com/mattpocock/skills/blob/main/CLAUDE.md)

## Key Takeaways

- `mattpocock/skills` เป็นชุด skill user-invoked สำหรับ Claude Code/Cursor/Codex ที่กิน context น้อย (~660 token/skill) และเน้นให้ผู้ใช้ควบคุม workflow เอง
- ติดตั้งด้วย `npx skills@latest add mattpocock/skills` แล้วรัน `/setup-matt-pocock-skills` เชื่อม issue tracker ครั้งเดียวต่อ repo
- Main flow: `/grill-with-docs` (คุยแผน) → `/to-spec` + `/to-tickets` (ถ้างานใหญ่เกิน smart zone ~140k token) → `/implement` (TDD) → `/code-review` (sub-agent 2 แกน) → auto-commit
- Sub-agent code-review ใช้ context สะอาดแยกจาก agent ที่เขียนโค้ด ทำให้ตรวจสอบตรงไปตรงมากว่าให้ agent ประเมินงานตัวเอง
- ควรอยู่ใน context window เดียวตั้งแต่ grill ถึง to-tickets, ใช้ `/handoff` ถ้าใกล้ชน smart zone แทนการฝืนทำงานตอนโมเดลเริ่มเสื่อม
- เริ่มจากไม่กี่ skill หลักที่ตรงงานจริงก่อน อย่าติดตั้งทั้งหมดพร้อมกัน โดยเฉพาะ `/tdd` ที่ไม่เหมาะกับงาน exploratory
- Repo มี 176,203 stars, MIT license, พัฒนาต่อเนื่อง — ชื่อคำสั่งเคยเปลี่ยน ควรอัปเดต skill เป็นระยะ
