---
title: "ลดต้นทุน Token Claude Fable 5 ลงถึง 80% ด้วย 5 เทคนิค ประสิทธิภาพยังเหนือกว่า Opus 4.8"
date: 2026-07-04 00:03:00 +0700
categories: [Tools]
tags: [fable-5, token-optimization, claude, anthropic, cost-optimization, ai-workflow]
slides: true
---

{% include slide-link.html %}

## TL;DR

Claude Fable 5 แพงกว่า Opus 4.8 ถึง 2 เท่า ($10/$50 ต่อล้าน token เทียบกับ $5/$25) แต่ด้วย 5 เทคนิคการใช้งาน — ปรับ `/effort`, ให้ Fable 5 เป็น Architect ส่งงานต่อ, ใช้ Ponytail ตัดโค้ดฟุ่มเฟือย, ให้โมเดลถูกกว่าทำ deep research ก่อน, และเปิด `/advisor` mode — ลดค่าใช้จ่ายรวมได้ถึง 80% โดยประสิทธิภาพยังเหนือ Opus 4.8 ที่ effort สูงสุด

## Background / Why this matters

Fable 5 เป็นโมเดล flagship ตัวใหม่ของ Anthropic ที่ทำคะแนน benchmark ด้าน coding และ long-horizon agentic work ได้สูงสุดในกลุ่มโมเดลที่เปิดใช้งานทั่วไป แต่ราคาต่อ token แพงกว่า Opus 4.8 ตรงๆ 2 เท่า ($10 input / $50 output ต่อล้าน token เทียบกับ $5/$25 ของ Opus 4.8) [3]

คำถามที่ทีมงาน AI ส่วนใหญ่เจอคือ: ใช้ Fable 5 ทุกงานแล้วบิลบวมเกินจำเป็น หรือจะดร็อปกลับไปใช้ Opus/Sonnet ทั้งหมดแล้วเสียคุณภาพงาน? วิดีโอต้นทางของโพสต์นี้ ["Make Fable 5 80% Cheaper (& Other Usage Cheat Codes)"](https://youtu.be/p8ypBeNXQ8E) [1] เสนอทางกลาง: ใช้ Fable 5 เฉพาะจุดที่ Fable 5 เก่งจริง (planning, judgment, งานยาก) แล้ว route งานที่เหลือไปโมเดลถูกกว่า — โดยยังคุม quality ไว้ที่ระดับเดียวกันหรือดีกว่า Opus 4.8 max effort

## Deep Dive

### 1. ปรับระดับ `/effort` เป็น Low หรือ Medium

Anthropic เปิด parameter `/effort` ให้ปรับได้ 5 ระดับ: `low`, `medium`, `high` (default), `xhigh`, `max` [2] effort ไม่ใช่ price multiplier ตรงๆ — แต่ effort สูงทำให้โมเดล generate token มากขึ้น (thinking, tool calls, คำอธิบายยาวขึ้น) ซึ่งไปเพิ่มค่าใช้จ่ายทางอ้อม [2]

ตัวเลขจาก Deep Suite benchmark ในวิดีโอ: Fable 5 ที่ effort `low` เฉลี่ย **$3.76 ต่อ task** — ลดลงกว่า 80% จาก effort `max` ที่ $22 ต่อ task — แต่ยังทำ pass rate ได้ 60% สูงกว่า Opus 4.8 ที่ effort max (pass rate 59%, ราคา $13 ต่อ task) [1] บน Frontier Code benchmark ก็เห็น pattern เดียวกัน: Fable 5 effort low ต้นทุนแค่ราว $5 แต่คะแนนเทียบเท่า Opus 4.8 effort max ที่ราว $11 [1]

สรุป: effort ต่ำของ Fable 5 ยัง "แรงเกิน" effort สูงสุดของ Opus 4.8 รุ่นก่อน — จ่ายน้อยกว่าได้งานดีกว่า

### 2. ให้ Fable 5 เป็น Architect ส่งต่อให้โมเดลอื่น Execute

แทนที่จะให้ Fable 5 ทำทั้ง plan และ run code เอง ให้ Fable 5 ทำหน้าที่ orchestrator — วางแผน แตกงาน (decompose) ตัดสิน (judge ผลลัพธ์) — แล้ว hand off งาน implementation ให้โมเดลถูกกว่าอย่าง Opus, Sonnet หรือ GPT-5.5 [4]

จุดสำคัญ: อย่าตั้ง Fable 5 ให้เล่น role "architect" หรือ "qa-reviewer" แบบ fixed — เก็บ Fable 5 ไว้ที่ decision-making เท่านั้น ส่วนงานที่เหลือ (boilerplate, mechanical work) โยนให้โมเดลถูกกว่าทำ [4] เพราะราคา token ของ Fable 5 แพง 2 เท่าของ Opus 4.8 อยู่แล้ว [3] การให้ Fable 5 เขียน boilerplate เองคือการเผา budget แบบไม่จำเป็น

### 3. ใช้ Ponytail ลดความฟุ่มเฟือยของโค้ด

Ponytail คือ ruleset plugin แบบ open-source ที่ inject mindset "senior lazy developer" — บีบให้ agent เช็คก่อนว่ามี library/ฟังก์ชันสำเร็จรูปในโปรเจกต์อยู่แล้วหรือไม่ ก่อนจะเขียนโค้ดใหม่จากศูนย์ [5] แก้ปัญหาที่ Opus/Fable มักทำ คือ recreate functionality ที่มีอยู่แล้วในโปรเจกต์หรือ library

ผลทดสอบจากวิดีโอต้นทาง: รัน Ponytail คู่กับ Fable 5 ที่ effort `medium` ได้ผลลัพธ์ **ถูกลง 22%** โดยรวม [1] ตัวเลขที่กว้างกว่าจากรายงานอื่น (นอกเหนือจากวิดีโอนี้) ระบุว่า Ponytail ลดปริมาณโค้ดที่ generate ได้ 80-94% และลดต้นทุน execution ได้ 47-77% [5] — ข้อควรระวังคือ gain จะมากที่สุดเมื่อโปรเจกต์มี over-building trap จริง ถ้าโค้ด base มินิมอลอยู่แล้ว ผลจะใกล้ศูนย์

### 4. ใช้โมเดลถูกกว่าทำ Deep Research ก่อนส่งให้ Fable 5 สรุป

Dynamic research workflow อย่าง `/deep-research` สามารถ spawn sub-agent ได้เยอะมาก — วิดีโอยกตัวอย่างเคสที่ deep-research task เดียว spawn ไป **109 sub-agents** [1] ถ้าให้ Fable 5 รัน sub-agent ทั้งหมดนั้น จะเผา usage limit หมดในทันที [1]

แนวทางที่ประหยัดกว่า: ให้โมเดลถูกกว่า (Opus, Sonnet) ทำหน้าที่ web search และรวบรวมข้อมูลดิบ (context gathering) จากนั้นส่ง context ที่รวบรวมแล้วให้ Fable 5 สังเคราะห์เป็น high-level plan หรือบทสรุปสุดท้ายเท่านั้น [1] — Fable 5 เก่งด้าน synthesis/judgment มากกว่า raw data collection ซึ่งเป็นงาน mechanical ที่โมเดลถูกกว่าทำได้ผลลัพธ์ไม่ต่างกัน

### 5. เปิด `/advisor` mode — Fable 5 เป็นที่ปรึกษา ไม่ใช่ผู้ลงมือ

Advisor tool ของ Claude Code ให้โมเดลหลัก (executive model เช่น Opus หรือ Sonnet) เป็นคนรัน tool และเขียนงานจริง แต่สามารถ "ปรึกษา" โมเดลที่แข็งกว่า (Fable 5) ในจุดวิกฤต — ก่อนตัดสินใจ approach สำคัญ, ตอนเจอ error ซ้ำๆ, หรือก่อนประกาศว่างานเสร็จ [6][7] จังหวะที่ปรึกษาเป็น model-driven ไม่ใช่ rule-based ตายตัว [7]

Anthropic ยังไม่เปิดเผยตัวเลข benchmark เฉพาะของ Fable 5-as-advisor แต่ pattern เดิมจาก Opus advising Sonnet แสดงว่าคู่นี้ให้ผลลัพธ์ดีกว่าและถูกกว่าการรันโมเดลแข็งตัวเดียวทั้งงาน [6] เทคนิคเสริมที่ช่วยลดต้นทุนได้อีก: ตั้ง `max_tokens` cap ให้ advisor (เช่น 2048 tokens) — Anthropic รายงานว่าการตั้ง cap แบบนี้ลด mean output token ของ advisor ได้ราว **7 เท่า** (จากราว 4,200-5,900 tokens ลงมาเหลือราว 630-840 tokens) โดย truncation เกิดขึ้นน้อยมาก [6]

## Caveats / Limits

- ตัวเลข "80% cheaper" และ "22% cheaper จาก Ponytail" มาจาก benchmark เฉพาะเจสในวิดีโอต้นทาง (Deep Suite, Frontier Code) — ผลจริงขึ้นกับ workload ของแต่ละทีม ไม่ใช่ตัวเลขคงที่ทุกกรณี
- Ponytail ได้ประโยชน์สูงสุดเมื่อ codebase มี over-building trap อยู่แล้ว ถ้าโค้ด base มินิมอลอยู่แล้วผลจะเกือบเป็นศูนย์ [5]
- Advisor mode ต้องใช้ Claude Code v2.1.170 ขึ้นไป และองค์กรต้องมีสิทธิ์เข้าถึง Fable 5 จึงตั้ง Fable 5 เป็น advisor model ได้ [7]
- Effort level ไม่ใช่ price multiplier ตรงๆ — ต้นทุนที่ลดมาจากปริมาณ token ที่ generate น้อยลง (thinking + tool calls สั้นลง) ไม่ใช่ discount ราคาต่อ token [2]
- การ delegate sub-agent จำนวนมาก (เช่น deep-research 109 agents) ยังต้องคุม concurrency/rate limit ของ provider โมเดลที่ถูกกว่าด้วย ไม่ใช่แค่ concern เรื่องต้นทุน

## References

1. [Make Fable 5 80% Cheaper (& Other Usage Cheat Codes)](https://youtu.be/p8ypBeNXQ8E)
2. [Effort - Claude Platform Docs](https://platform.claude.com/docs/en/build-with-claude/effort)
3. [Claude Fable 5 and Claude Mythos 5 — Anthropic](https://www.anthropic.com/news/claude-fable-5-mythos-5)
4. [Use Fable 5 where it pays for itself - DEV Community](https://dev.to/toffy/use-fable-5-where-it-pays-for-itself-1809)
5. [80% Less Code, 77% Cheaper: How 'Ponytail' Injects Lean Security Into AI Coding Agents - Undercode Testing](https://undercodetesting.com/80-less-code-77-cheaper-how-ponytail-injects-lean-security-into-ai-coding-agents-video/)
6. [Advisor tool - Claude Platform Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/advisor-tool)
7. [Escalate hard decisions with the advisor tool - Claude Code Docs](https://code.claude.com/docs/en/advisor)

## Key Takeaways

- Fable 5 แพงกว่า Opus 4.8 2 เท่าต่อ token ($10/$50 vs $5/$25) แต่ effort ต่ำของ Fable 5 ยังชนะ effort สูงสุดของ Opus 4.8 ทั้งราคาและคุณภาพ
- `/effort low` บน Deep Suite benchmark: $3.76/task, pass rate 60% — ถูกกว่า 80% และแม่นกว่า Opus 4.8 max effort ($13/task, 59%)
- ให้ Fable 5 ทำหน้าที่ architect/orchestrator เท่านั้น ส่ง execution ให้ Opus/Sonnet/GPT-5.5 ทำ
- Ponytail (ruleset ลดโค้ดฟุ่มเฟือย) ลดต้นทุนรวมได้ 22% เมื่อรันคู่กับ Fable 5 effort medium ในการทดสอบจากวิดีโอต้นทาง
- Deep research ที่ spawn sub-agent จำนวนมาก (109 agents ในตัวอย่าง) ควรให้โมเดลถูกกว่าทำ แล้วส่ง context ให้ Fable 5 สรุปเท่านั้น
- `/advisor` mode ให้โมเดลถูกกว่ารันงานจริง ปรึกษา Fable 5 เฉพาะจุดวิกฤต — ตั้ง `max_tokens` cap ที่ 2048 ลด output token ของ advisor ได้ราว 7 เท่า
