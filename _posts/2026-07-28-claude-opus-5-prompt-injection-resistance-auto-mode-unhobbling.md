---
title: "Claude Opus 5: ต้านทาน Prompt Injection เกือบสมบูรณ์ พร้อมรัน Auto Mode ต่อเนื่องเป็นเดือน"
date: 2026-07-27 00:05:00 +0700
categories: [Engineering]
tags: [claude-opus-5, claude-code, prompt-injection, auto-mode, unhobbling, dynamic-workflows, ai-agents, anthropic]
slides: true
---

{% include slide-link.html %}

## TL;DR

Claude Opus 5 (เปิดตัว 24 ก.ค. 2026) ลด prompt injection attack success rate เหลือ **0% ใน 129 browser scenarios** เมื่อรวมกับ Auto Mode และรัน autonomous ต่อเนื่องได้ "เป็นวัน สัปดาห์ หรือเป็นเดือน" ตามคำของ Boris Cherny (Head of Claude Code ที่ Anthropic) — ทีมงานทำได้โดยลบ system prompt เดิมของ Claude Code ทิ้งกว่า 80% ("unhobbling") เพราะพบว่าโมเดลฉลาดขึ้นเมื่อไม่มีคำสั่งเก่าคอยจำกัด แล้วเปิดทางให้ฟีเจอร์ Dynamic Workflows สั่งรัน sub-agent ได้ถึง 1,000 ตัวต่อ run เพื่อบำรุงรักษาโค้ดอัตโนมัติ

## Background / Why this matters

Prompt injection คือช่องโหว่ที่ instruction แปลกปลอมซึ่งฝังอยู่ใน content ภายนอก (เว็บเพจ, อีเมล, ไฟล์) เข้ามาแย่งควบคุมพฤติกรรม agent — เช่น agent ที่กำลังอ่านหน้าเว็บเจอข้อความ "ลบไฟล์ทั้งหมดในเครื่องผู้ใช้" แฝงอยู่ แล้วทำตามโดยไม่รู้ตัว ปัญหานี้ถูกเรียกว่า "lethal trifecta" ในวงการ AI agent security และ OpenAI เองเคยยอมรับเมื่อเดือนธันวาคมที่ผ่านมาว่า prompt injection อาจไม่มีทางแก้ได้สมบูรณ์ [2] การที่ Anthropic รายงานตัวเลขที่เข้าใกล้ 0% จึงเป็นเรื่องใหญ่สำหรับทุกทีมที่กำลังสร้าง agent ที่ต้องท่องเว็บหรืออ่าน content จากภายนอก

อีกด้านหนึ่งคือแนวคิด **"unhobbling"** — Boris Cherny อธิบายว่า Claude Code เดิมทีถูกสร้างขึ้นมาเพื่อ "unhobble" Sonnet 3.5 ซึ่งเป็นโมเดลแรกของ Anthropic ที่เขียนไฟล์และฟีเจอร์ทั้งไฟล์ได้ ในยุคที่เครื่องมือโค้ดดิ้งที่มีอยู่รองรับแค่ single-line autocomplete หรือ read-only chat [1] เขาแยกคำสองคำที่ดูคล้ายกัน: **product overhang** (ช่องว่างระหว่างความสามารถจริงของโมเดลกับสิ่งที่ product ยอมให้ทำ) กับ **hobbling** (product ที่ตั้งกฎเกณฑ์จำกัดจนโมเดลแสดงศักยภาพจริงไม่ได้) [1] เมื่อโมเดลฉลาดขึ้นเรื่อยๆ ทุกครั้งที่มีรุ่นใหม่ scaffolding เดิมที่เคยจำเป็นอาจกลายเป็นตัวถ่วง — นี่คือเหตุผลที่ทีม Claude Code ต้องกลับมา "ลบ" คำสั่งเก่าทิ้งแทนที่จะเพิ่มคำสั่งใหม่เข้าไปเรื่อยๆ

## Deep Dive

### 1. Prompt Injection: จากช่องโหว่ร้ายแรงสู่เกือบ 0%

บน **Gray Swan indirect-prompt-injection benchmark** (นับ attacker success rate หลังพยายาม 15 ครั้ง) Opus 5 ลดอัตราความสำเร็จของผู้โจมตีเหลือ **2.0%** จาก 5.5% ใน Opus 4.8 — ดีกว่าโมเดลอื่นที่ทดสอบร่วม คือ Mythos 5 (2.6%) และ Fable 5 (2.8%) [2]

ใน environment ที่สมจริงกว่าคือ **browser-based agent attacks** (ผ่าน Claude Cowork, ครอบคลุม 129 test scenarios): ถ้าไม่เปิด safeguard ใดๆ Opus 5 ลด attack success rate จาก 31.5% (Opus 4.8, extended thinking) เหลือ 3.70% และจาก 17.8% เหลือ 4.30% (ไม่เปิด thinking) — ส่วน Sonnet 5 ทำได้ดีที่สุดในโหมดไม่มี safeguard ที่ 0.93%/1.01% แต่เมื่อ **เปิด Auto Mode** อัตราความสำเร็จของผู้โจมตีตกลงเหลือ **0% ในทั้ง 129 scenarios** ทั้งสำหรับ Opus 5, Sonnet 5 และ Mythos 5 [7]

กลไกเบื้องหลังคือ **defense 3 ชั้น** ตามที่ Boris Cherny อธิบายในวิดีโอ [1]:
1. **Base model ที่ align มาอย่างดี** — ผลจากงานวิจัย alignment สะสมมา 3 ปี
2. **Prompt-injection classifier** — ต่อยอดจากงาน mechanistic interpretability ของ Chris Olah ที่มอนิเตอร์ "neuron" ในโมเดลที่ทำงานเมื่อเกิด prompt injection แม้โมเดลจะไม่บอกตรงๆ ทีมก็ตรวจจับและวินิจฉัยได้จาก activation pattern เหล่านี้
3. **Auto Mode classifier** — ชั้นสุดท้ายที่บล็อก action อันตรายก่อนถูก execute จริง

ต้องเน้นว่าตัวเลข 0% เกิดขึ้น **เฉพาะเมื่อรวมทั้งโมเดลและ safeguard ซอฟต์แวร์เข้าด้วยกัน** — ไม่มีชั้นไหนชั้นเดียวที่ทำให้ risk เป็นศูนย์ได้ด้วยตัวเอง [6][7] Anthropic เองก็ยังระบุใน help doc ว่า "risk ไม่ใช่ศูนย์" แม้ผลการทดสอบจะออกมาสวยงามขนาดนี้ [6]

### 2. Auto Mode: รันต่อเนื่องเป็นเดือนโดยไม่ต้องพึ่ง Scaffolding เดิม

Auto Mode คือระบบสิทธิ์การทำงานของ Claude Code ที่ให้ Claude ตัดสินใจอนุมัติ action ของตัวเองแบบอัตโนมัติ ผ่าน 2 ชั้นตรวจสอบคือ **input scanner** (สแกน tool call ก่อนรัน) และ **action classifier** (บล็อก action เสี่ยง เช่น ลบไฟล์จำนวนมาก, ส่งข้อมูลรั่วไหล, รันโค้ดอันตราย) — action ที่ปลอดภัยผ่านอัตโนมัติ ส่วน action เสี่ยงจะถูกบล็อกและให้ Claude หาทางอื่น ถ้า Claude ยืนกรานทำ action ที่ถูกบล็อกซ้ำๆ ระบบจะขอ permission จากผู้ใช้แทน [feature นี้เข้าสู่ Research Preview 24 มี.ค. 2026 สำหรับ Claude Team และ General Availability 10 ก.ค. 2026 ครอบคลุม Team, Enterprise, และ API]

ผลลัพธ์เมื่อรวม Opus 5 กับ Auto Mode คือสิ่งที่ Boris Cherny เรียกว่า "incredible": โมเดล **"รันได้เป็นวัน เป็นสัปดาห์ เป็นเดือน มันไม่หยุด"** โดยไม่ต้องพึ่ง scaffolding เสริมแบบเดิมที่เคยจำเป็น เพราะโมเดลรู้เองว่าต้องทำ task ให้เสร็จ [1] Trade-off ที่ต้องแลกคือ Auto Mode ใช้ token และ latency เพิ่มขึ้นเล็กน้อยต่อ tool call ที่ถูกตรวจ แต่แลกมาด้วยการตัด permission prompt ที่คอยขัดจังหวะ session ยาวๆ ออกไป

### 3. Unhobbling: ทำไมลบ System Prompt ทิ้งกว่า 80% แล้วโมเดลฉลาดขึ้น

ทีม Claude Code ใช้วิธี **ablation testing** — ลบ system prompt ทั้งหมดออกก่อน แล้วดูว่าโมเดลพลาดตรงไหนบ้าง จากนั้นค่อยใส่คำสั่งกลับเข้าไปเฉพาะจุดที่พบว่าโมเดลทำผิดซ้ำๆ จริงๆ เท่านั้น [3] ผลคือ **มากกว่า 80% ของ system prompt เดิมถูกลบทิ้ง** และ Cherny ยืนยันตรงๆ ว่า "the model is actually a little bit more intelligent without these prompts" [3]

หลักคิดคือ instruction แบบ step-by-step ที่เคยจำเป็นสำหรับโมเดลรุ่นเก่าที่อ่อนกว่า กลายเป็นตัว "hobble" โมเดลรุ่นใหม่ที่ฉลาดกว่าเดิมมาก — แทนที่จะบอกทีละขั้นตอนว่าต้องทำอะไรก่อนหลัง Cherny แนะนำให้ตั้งเป้าหมายที่ยากและเป็นนามธรรม พร้อมเครื่องมือ verify ผลลัพธ์ แล้วปล่อยให้โมเดลหาวิธีไปเองแทนการตีกรอบคำสั่งแบบเดิม — ตรงกับแนวคิดที่ผู้ใช้ต้องปรับตัวเมื่ออัปเดตโมเดลใหม่: กลับไปพิจารณาลบ system prompt เก่าที่เคยเขียนไว้สำหรับโมเดลรุ่นก่อน แทนที่จะสะสมคำสั่งซ้อนกันไปเรื่อยๆ

### 4. Dynamic Workflows: สั่ง Sub-agent เป็นพันตัวด้วยคำสั่งเดียว

**Dynamic Workflows** ไม่ใช่ฟีเจอร์ใหม่ที่มาพร้อม Opus 5 โดยตรง — มันเปิดตัวเป็น Research Preview ตั้งแต่ 28 พ.ค. 2026 คู่กับ Claude Opus 4.8 [8] แต่ Opus 5 ทำให้ agent ที่ orchestrate ผ่านฟีเจอร์นี้รันได้ยาวนานขึ้นกว่าเดิมมาก สถาปัตยกรรมคือ Claude เขียน **JavaScript script ที่ orchestrate sub-agent เป็น scale ใหญ่** แล้ว runtime แยกต่างหากรันสคริปต์นั้นในพื้นหลัง ขณะที่ session หลักของผู้ใช้ยังว่างอยู่ [8] loop, การแตกแขนง, และผลลัพธ์ระหว่างทางทั้งหมดถูกเก็บไว้ใน**ตัวแปรของสคริปต์** ไม่ใช่ใน context ของโมเดล — ทำให้ "context ของ Claude เก็บแค่คำตอบสุดท้าย" แทนที่จะเต็มไปด้วยรายละเอียดปลีกย่อยจาก sub-agent แต่ละตัว [8]

ระบบจำกัด sub-agent ไว้ที่ **16 ตัวรันพร้อมกัน และสูงสุด 1,000 ตัวต่อการรันหนึ่งครั้ง** ก่อนจะมี hard cap ป้องกันไม่ให้ระบบกินทรัพยากรจนล่ม [8] ตัวอย่างที่ Anthropic ใช้โชว์ศักยภาพฟีเจอร์นี้คือการรีไรต์ codebase ของ Bun runtime จาก Zig เป็น Rust จำนวนกว่า 750,000 บรรทัด ภายใน 11 วัน โดย test suite เดิมยังผ่านถึง 99.8% [8] — Cherny เล่าว่าสิ่งที่ผู้ใช้ต้องพิมพ์มีแค่ **"use a workflow"** เท่านั้น จากนั้นระบบก็กระจายงานไปยัง agent หลายพันตัว ตรวจสอบผลลัพธ์กับ test suite ของ Bun เอง และแก้ไขข้อผิดพลาดโดยอัตโนมัติ [3]

### 5. ทักษะยุคใหม่: Empirical มากกว่า Dogma

Cherny เล่าประสบการณ์ตรงว่าเขาเคยยึดมั่นสถาปัตยกรรมแบบ function-only อย่างเคร่งครัด ถึงขั้น revert โค้ดที่วิศวกรเขียนแบบ class-based ทิ้ง — จนกระทั่ง Claude เริ่มเขียนโค้ดแบบ class แล้วให้ผลลัพธ์ทางธุรกิจที่ดีกว่า เขาจึงยอมรับว่าความเห็นหนักแน่นของตัวเองก็เป็นเพียง "ความเห็น" ที่ต้องพิสูจน์ด้วยข้อมูลจริง ไม่ใช่ทฤษฎีที่ยึดถือตายตัว [4] วิธีทำงานของเขาเองก็เปลี่ยนไปจาก "เขียนโค้ด" เป็น "เขียน loop อัตโนมัติที่ orchestrate agent หลายตัว" เพื่อตัดสินใจว่าจะสร้างอะไรต่อ — จากบทบาท coder กลายเป็นบทบาท orchestrator [4]

Anthropic เองเพิ่มขนาดทีมวิศวกรเป็นสองเท่า พร้อมเพิ่ม productivity ต่อหัวถึง 200% โดยกว่า 90% ของโค้ดตอนนี้เขียนโดย Claude Code [4] ทีมงานจึงเข้าสู่สิ่งที่ Cherny เรียกว่า "golden age of the generalist" — วิศวกรทำ scoping, design, dashboard ไปพร้อมกัน และคนจากสายอื่น (designer, finance) ก็เขียนโค้ดเองได้ สิ่งที่ยังเหลือเป็น "ความได้เปรียบที่ทนทาน" ของมนุษย์ไม่ใช่ taste หรือ product sense (เพราะ Cherny เองก็รัน Claude หลายร้อย instance คอยมอนิเตอร์ feedback เพื่อ generate ไอเดียแทนเขา) แต่คือการ**สอนคุณค่า** — สอนให้โมเดล "เป็นโมเดลที่ดี" [4]

## User Guide (Step-by-Step)

1. **ตรวจสอบเวอร์ชัน Claude Code** — Auto Mode (GA) ต้องใช้ Claude Code รุ่นที่รองรับ Team/Enterprise/API plan และเปิดใช้งานผ่าน setting ของ Auto Mode ในแอป — ผลลัพธ์ที่คาดหวัง: session ทำงานต่อเนื่องได้โดยไม่มี permission prompt คอยขัดจังหวะ
2. **ตรวจสอบ system prompt เดิมของทีมคุณ** — ก่อนอัปเกรดเป็นโมเดลใหม่ ให้ลองปิด custom instruction/system prompt เก่าทีละส่วนแล้วสังเกตว่าโมเดลยังทำงานถูกต้องไหม (ablation) — ผลลัพธ์ที่คาดหวัง: เจอคำสั่งที่ "hobble" โมเดลรุ่นใหม่โดยไม่จำเป็น แล้วลบทิ้งได้อย่างมั่นใจ
3. **สั่งงานใหญ่ด้วย Dynamic Workflows** — พิมพ์คำสั่งระดับสูง เช่น "use a workflow to migrate X to Y" แทนการเขียน step-by-step เอง — ผลลัพธ์ที่คาดหวัง: Claude เขียนสคริปต์ orchestration เอง กระจายงานให้ sub-agent สูงสุด 1,000 ตัว แล้วสรุปผลกลับมาให้แค่คำตอบสุดท้าย
4. **ระวังงานที่ยังไม่ verify อัตโนมัติได้** — งานที่ไม่มี test suite หรือเกณฑ์ตรวจสอบชัดเจน ยังต้องมีมนุษย์ตรวจสอบ เพราะ Dynamic Workflows พึ่งพา automated verification เป็นตัวตัดสินว่างานเสร็จจริงหรือไม่

## Caveats / Limits

- **Risk ไม่ใช่ศูนย์** — แม้ผลทดสอบ 0% ใน 129 scenarios จะดูสมบูรณ์แบบ Anthropic เองก็ยังระบุชัดว่า risk ไม่เท่ากับศูนย์ในทางปฏิบัติ [6]
- **0% เกิดจากการรวมกันของโมเดล + Auto Mode เท่านั้น** — ถ้าปิด safeguard หรือไม่เปิด Auto Mode อัตราความสำเร็จของผู้โจมตียังอยู่ที่ 3.70%–4.30% ไม่ใช่ศูนย์ [7]
- **Classifier ไม่สมบูรณ์แบบ** — อาจปล่อยผ่าน action เสี่ยงเมื่อ intent ของผู้ใช้กำกวม หรือบล็อก action ที่ไม่อันตรายโดยไม่จำเป็น
- **Auto Mode เพิ่ม token cost และ latency** ต่อ tool call ที่ถูกตรวจสอบ
- **Dynamic Workflows ยังเป็น Research Preview** พร้อม hard cap ที่ 16 agent พร้อมกันและ 1,000 agent ต่อ run
- **Opus 5 อยู่ภายใต้ ASL-3 protection เดียวกับ Opus 4.8** — Anthropic จัดว่า Opus 5 มี CB-1 capability แต่ยังไม่ถึง CB-2 ภายใต้ Responsible Scaling Policy (RSP), ยังไม่ข้าม threshold ด้าน AI R&D [5]

## References

1. [Boris Cherny: Building Claude Code](https://youtu.be/qyPCVqFUyDo) — YouTube interview, Y Combinator/Startup School 2026
2. [Opus 5 may have solved browser-based prompt injection, the biggest security flaw haunting AI agents](https://the-decoder.com/opus-5-may-have-solved-browser-based-prompt-injection-the-biggest-security-flaw-haunting-ai-agents/) — the-decoder
3. [Boris Cherny: We Deleted 80% of Claude Code's System Prompts for Opus 5. The Model Got Smarter.](https://finance.biggo.com/news/7df48019614f68c0) — BigGo Finance
4. [Key takeaways from Boris Cherny on building Claude Code](https://workos.com/blog/boris-cherny-claude-code-acquired-interview-takeaways) — WorkOS Blog
5. [Meet the New Claude Opus 5: Frontier-Class Agentic Coding and Computer Use at Unchanged Opus Pricing](https://www.marktechpost.com/2026/07/24/meet-the-new-claude-opus-5-frontier-class-agentic-coding-and-computer-use-at-unchanged-opus-pricing/) — MarkTechPost
6. [Auto mode for Claude Code](https://claude.com/blog/auto-mode) — Anthropic official blog
7. [Claude Opus 5 System Card](https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf) — Anthropic, July 24, 2026
8. [Claude Code's Dynamic Workflows: A Thousand Agents, One Script](https://trilogyai.substack.com/p/claude-codes-dynamic-workflows-a) — Trilogy AI Substack

## Key Takeaways

- Claude Opus 5 (24 ก.ค. 2026) ลด prompt injection attack success เหลือ 2.0% บน Gray Swan benchmark และ **0%** ใน 129 browser scenarios เมื่อรวมกับ Auto Mode — แต่ risk ไม่เท่ากับศูนย์ในทางปฏิบัติ
- Defense ทำงาน 3 ชั้น: aligned base model + interpretability-based prompt-injection classifier (ต่อยอดงาน Chris Olah) + Auto Mode classifier — ต้องรวมกันทั้งหมดถึงจะได้ผลลัพธ์ 0%
- Auto Mode (GA 10 ก.ค. 2026) ทำให้ Opus 5 รันงานต่อเนื่องได้ "เป็นวัน สัปดาห์ เป็นเดือน" โดยไม่ต้องพึ่ง scaffolding เสริมแบบเดิม
- ทีม Claude Code ลบ system prompt เดิมทิ้งกว่า 80% ผ่านวิธี ablation testing แล้วพบว่าโมเดลฉลาดขึ้น — บทเรียนคือ instruction เก่าที่เขียนไว้สำหรับโมเดลรุ่นก่อนอาจ "hobble" โมเดลรุ่นใหม่
- Dynamic Workflows (เปิดตัวคู่ Opus 4.8 พ.ค. 2026) ให้ Claude เขียนสคริปต์ orchestrate sub-agent ได้ถึง 1,000 ตัวต่อ run โดย context ของโมเดลเก็บแค่คำตอบสุดท้าย
- ทักษะสำคัญของยุคนี้คือการทดลองแบบ empirical และตั้งเป้าหมายระดับสูงพร้อมเครื่องมือ verify แทนการตีกรอบคำสั่งแบบเดิม — ความได้เปรียบที่ยังเหลืออยู่ของมนุษย์คือการสอนคุณค่า ไม่ใช่ taste หรือ product sense
