---
title: "รีวิว Claude Fable 5: สร้าง UI/UX แบบ One-Shot ใน 5 การทดสอบ"
date: 2026-06-10 00:04:00 +0700
categories: [Engineering]
tags: [claude, fable, ui-ux, web-design, gsap, three-js, one-shot, ai-coding]
---

## TL;DR

Claude Fable 5 สามารถสร้างหน้าเว็บที่มี animation และ 3D effect ซับซ้อนได้จากพรอมต์รอบเดียว — ทั้ง GSAP ScrollTrigger, Three.js particles, และการ clone สไตล์จาก URL — เปิดประตูให้นักออกแบบที่เขียนโค้ดไม่เป็นสามารถสร้าง production-ready UI ได้ด้วยภาษาธรรมชาติ

## Background / Why this matters

การสร้างหน้าเว็บที่สวยงามและมี interactive animation เป็นงานที่เคยต้องการทักษะด้าน frontend ระดับสูง — รู้จัก GSAP สำหรับ animation, Three.js สำหรับ 3D, และประสบการณ์ปรับแต่ง CSS หลายร้อยบรรทัด แต่ Claude Fable 5 ซึ่ง Anthropic เปิดตัวเมื่อ **9 มิถุนายน 2026** เริ่มเปลี่ยนสมการนี้อย่างมีนัยสำคัญ

โมเดลนี้ทำคะแนนสูงสุดบน **ViBench** (end-to-end vibe-coding benchmark ของ Anthropic) โดย "nearly saturating base use cases and building apps in less time with fewer tokens" [1] หนึ่งใน developer ที่ทดสอบช่วงต้น (early access) สรุปว่า *"Apps that took a hundred prompts a year ago, it now one-shots"* [2]

สิ่งที่น่าสนใจกว่าตัวเลข benchmark คือคำถามเชิงปฏิบัติ: ถ้า Fable 5 สามารถ one-shot UI จริงๆ นักออกแบบ UX ที่เขียน JavaScript ไม่เป็น หรือ product designer ที่อยากทดสอบ concept ด่วนๆ จะได้อะไรจากมัน? วิดีโอรีวิว 5-test ของ YouTube channel คำตอบของคำถามนี้ผ่านการทดสอบจริง

## Deep Dive

### Claude Fable 5 คืออะไร

Fable 5 เป็น Anthropic's flagship model สำหรับ production ณ มิถุนายน 2026 ออกแบบมาสำหรับงาน complex ที่ต้องการความแม่นยำสูง มีจุดเด่น 3 ข้อหลัก:

| ความสามารถ | รายละเอียด |
|---|---|
| **Vision reconstruction** | สร้าง source code จาก screenshot ของ web app ได้ [2] |
| **Long-context reasoning** | รักษา focus ข้ามหลาย million tokens ในงาน long-running [2] |
| **One-shot efficiency** | เข้าใจ intent ของ developer ไม่ใช่แค่ syntax ของ prompt [1] |

**ราคา:** $10/M input tokens, $50/M output tokens (ส่วนลด prompt caching 90% ใช้ได้) [2]

### 5 การทดสอบ One-Shot UI/UX

**Test 1: Portfolio Landing Page**
ป้อน prompt อธิบาย portfolio designer พร้อม requirement ด้าน layout, typography, color scheme — Fable 5 ผลิต landing page พร้อม hero section, featured work grid, และ smooth scroll animation ออกมาในรอบเดียว ไม่ต้องระบุ library หรือ CSS class ใดๆ โมเดลเลือก stack เองและเขียนโค้ดให้ครบ

**Test 2: Clone 3D Web Gallery จาก URL**
ให้ URL ของเว็บที่มี 3D gallery effect (คล้าย helix/carousel) — Fable 5 ดึง visual language ออกมา แล้ว reconstruct effect ด้วย Three.js โดยไม่มี source code ต้นฉบับ ทดสอบ vision capability ที่ฝั่ง "เห็นแล้วเขียน" แทนที่ "อ่านแล้วแปล"

**Test 3: Hero Section Refresh**
เอา hero section เดิมที่ดูเก่า มาให้ Fable 5 ออกแบบใหม่ ผลลัพธ์รวม GSAP ScrollTrigger สำหรับ entrance animation, parallax layer, และ gradient overlay ที่ responsive — ทั้งหมดในพรอมต์เดียว

**Test 4: Craigslist Modern Redesign**
Craigslist เป็นตัวอย่างคลาสสิกของเว็บที่ "functional แต่ ugly" — การให้ AI redesign จาก URL นี้ทดสอบว่า Fable 5 เข้าใจ content architecture ของเว็บต้นฉบับและแปลงเป็น modern UI ได้หรือเปล่า โดยไม่ทำลาย information hierarchy เดิม

**Test 5: Award Site Effect Clone**
เว็บที่ได้รับรางวัล (เช่นใน Awwwards) มักมี micro-interaction และ custom cursor effect ที่ซับซ้อน การ clone effect เหล่านี้จาก URL เดียวเป็นการทดสอบระดับสูงสุด — ต้องใช้ทั้ง GSAP, CSS custom properties, และบางครั้ง WebGL

### ผลลัพธ์และคุณภาพโค้ด

ผลรวมของทั้ง 5 tests แสดงให้เห็นรูปแบบที่ชัดเจน:

**GSAP (GreenSock Animation Platform)** — Fable 5 เขียน ScrollTrigger ได้ถูกต้องทั้ง `trigger`, `start`, `stagger`, และ `ease` parameters โดยไม่ต้องระบุ version หรือ CDN ให้:

```javascript
gsap.from(".feature-card", {
  scrollTrigger: {
    trigger: ".features-section",
    start: "top 80%",
  },
  y: 40,
  opacity: 0,
  duration: 0.7,
  stagger: 0.15,
  ease: "power2.out"
});
```

**Three.js** — สร้าง particle field และ geometric objects ได้ถูกต้อง รวมถึง scene setup, camera, renderer, และ animation loop ที่สมบูรณ์ [3]

**CSS + Layout** — เลือก modern CSS (custom properties, grid, clamp()) แทน approach เก่า และใช้ responsive breakpoint ที่สมเหตุสมผล

### เหตุใด One-Shot จึงสำคัญสำหรับ Designer

สิ่งที่ video reviewer สรุปมีน้ำหนัก: ปัญหาเดิมของ designer ที่ไม่ถนัดเขียนโค้ดไม่ใช่แค่ "ไม่รู้ syntax" แต่คือ **feedback loop ที่ยาว** — อธิบาย → รอ dev เขียน → ผิด → อธิบายใหม่ → วนซ้ำ

One-shot UI generation ตัดวงจรนี้: designer ป้อน visual language ที่ตัวเองคุ้นเคย ("helix gallery", "frosted glass card", "award site cursor trail") แล้วได้ HTML+CSS+JS ที่ browser รันได้ทันที แม้จะยังต้องปรับ แต่ starting point มีคุณภาพสูงพอที่จะ iterate ได้เร็ว

สำหรับงาน landing page ทั่วไป ค่าใช้จ่าย API อยู่ที่ **ต่ำกว่า $10** ต่อหน้า [3]

## Caveats / Limits

- **Production ≠ One-Shot**: output จาก one-shot เป็น prototype-quality — ต้องทดสอบ cross-browser, accessibility (WCAG), และ performance optimization ก่อน deploy จริง
- **Three.js complexity ceiling**: Fable 5 สร้าง particle/geometry ได้ดี แต่งาน physically-based material, shadow, หรือ complex shader ยังต้องการ iteration
- **Vision accuracy ≠ pixel-perfect**: การ clone จาก URL อิงจาก visual interpretation — อาจมีความแตกต่างใน spacing หรือ font weight เล็กน้อย
- **ราคา**: $50/M output token ทำให้งานที่ต้องการหลาย iteration มีต้นทุนสะสม — เหมาะกับ one-shot prototype ไม่ใช่ generate-and-throw-away workflow
- **Fable 5 ไม่ใช่ Claude Design**: Claude Design (เปิดตัว 17 เม.ย. 2026) เป็น visual UI product แยกต่างหากที่ใช้ Opus 4.7 [4] — Fable 5 ทำงานผ่าน API/code ไม่ใช่ drag-and-drop interface

## References

1. [Claude Fable 5 and Claude Mythos 5 — Anthropic](https://www.anthropic.com/news/claude-fable-5-mythos-5)
2. [Claude Fable — Anthropic](https://www.anthropic.com/claude/fable)
3. [How to Build Animated 3D Websites with Claude Code and AI Video Generation — MindStudio](https://www.mindstudio.ai/blog/animated-3d-websites-claude-code-ai-video-generation)
4. [Introducing Claude Design by Anthropic Labs — Anthropic](https://www.anthropic.com/news/claude-design-anthropic-labs)
5. [Claude Fable 5 UI/UX One-Shots - 5 Tests — YouTube](https://youtu.be/tSg3FAdWvzI)

## Key Takeaways

- Claude Fable 5 one-shots UI ที่มี GSAP animation และ Three.js 3D ได้จริง — โค้ดที่ได้รันได้โดยไม่ต้องแก้ structure หลัก
- Vision capability ("เห็นแล้วเขียน") ทำให้การ clone design จาก URL เป็นไปได้โดยไม่ต้องมี source code
- Craigslist redesign และ Awwwards effect clone ทดสอบ design intelligence ที่เกินกว่า template generation — โมเดลต้องเข้าใจ UX intent ด้วย
- ต้นทุนต่ำกว่า $10 ต่อ landing page เปิดทาง prototyping ที่ designer สามารถ iterate ด้วย natural language
- One-shot ≠ production-ready — ยังต้องมี QA ด้าน accessibility, cross-browser, และ performance
- Claude Design (Opus 4.7) และ Fable 5 API เป็นคนละ product — เลือกตามว่าต้องการ visual UI หรือ code output
- นักออกแบบที่เขียนโค้ดไม่เป็นได้ประโยชน์สูงสุด: Fable 5 แปลง visual language เป็น working HTML ได้โดยตรง
