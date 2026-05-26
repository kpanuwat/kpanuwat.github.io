---
title: "AI สร้าง HTML Presentation แทน PowerPoint: Interactive Slides สำหรับทุกคน"
date: 2026-05-26 00:02:00 +0700
categories: [Tools]
tags: [html, presentation, ai-agent, claude-code, cursor, interactive, 21st-dev, reveal-js]
---

## TL;DR

ใช้ Claude Code Skill สร้าง HTML Presentation แบบ single-file ได้ภายในไม่กี่นาที — ไม่ต้องเขียนโค้ด ไม่ต้องเป็น Designer แค่พิมพ์อธิบาย content ที่ต้องการ AI จัดการทุกอย่างตั้งแต่ layout, animation จนถึง 3D effect ได้ผลลัพธ์ที่ interactive กว่า PowerPoint และแก้ไขผ่าน Browser ได้ทันที

---

## Background / Why this matters

Presentation tools อย่าง PowerPoint และ Google Slides ยังคงครองตลาดอยู่ แต่มีข้อจำกัดชัดเจน: animation ที่จำกัด, static output, ไม่รองรับ 3D objects แบบ real-time และ ต้องใช้ software เฉพาะเปิด

ในขณะที่ HTML presentation framework อย่าง **reveal.js** มีมานานแล้ว แต่ barrier สำหรับ non-developer คือต้องเขียน HTML/CSS/JS เอง — จนกว่า AI Agent จะมาเปลี่ยนสมการนี้

ปัจจุบัน ปี 2025-2026 มี **HTML Slide Skills** สำหรับ Claude Code, Cursor, Codex และ agent อื่นๆ มากกว่า 30+ skills ให้เลือกใช้ — แต่ละ skill มี design system, preset styles และ output format ที่แตกต่างกัน ทำให้ non-designer สามารถสร้าง presentation ระดับ professional ได้เพียงแค่พิมพ์ข้อความอธิบาย content

---

## Deep Dive

### HTML Presentation Skill คืออะไร

HTML Presentation Skill คือ "instruction set" ที่ติดตั้งลงใน AI agent (Claude Code, Cursor ฯลฯ) เพื่อให้ agent รู้วิธีสร้าง presentation ในรูปแบบ single HTML file ที่รันใน browser ได้ทันที — ไม่ต้องติดตั้ง software เพิ่มเติม

skill ที่ได้รับความนิยม เช่น **frontend-slides** บน [mcpmarket.com](https://mcpmarket.com/tools/skills/frontend-slides) และ **html-slides** บน [explainx.ai](https://explainx.ai/skills/claude-office-skills/skills/html-slides) ทำงานโดย:

- รับ prompt อธิบาย content + จำนวน slide + mood ที่ต้องการ
- generate preview ใน **3 style** แตกต่างกันให้เลือก (จาก preset 12 styles: 4 dark, 4 light, 4 special)
- สร้าง deck เต็มรูปแบบตาม style ที่เลือก
- output เป็น single `.html` file (zero external dependencies)

### HTML vs PowerPoint: ความแตกต่างที่สำคัญ

| Feature | HTML Presentation | PowerPoint / Keynote |
|---|---|---|
| Interactivity | ✅ hover effects, click events, scroll triggers | ❌ static mostly |
| 3D Objects | ✅ CSS 3D, Three.js, WebGL | ❌ ไม่รองรับ real-time 3D |
| Animations | ✅ ไม่จำกัด, CSS/JS animation | ⚠️ จำกัดใน preset |
| Browser-native | ✅ เปิดได้ทุก browser | ❌ ต้องมี Office/Keynote |
| AI generation | ✅ จาก prompt ใน minutes | ⚠️ ต้องออกแบบเอง |
| Portability | ✅ 1 file, deploy บน web ได้ | ⚠️ format proprietary |
| Skill required | ✅ ไม่ต้องเขียนโค้ด (ผ่าน AI) | ✅ ใช้ง่าย ถ้าคุ้นแล้ว |
| PDF export | ⚠️ ได้ แต่ animation หาย | ✅ full support |

### แหล่ง Component เสริมลูกเล่น

**[21st.dev](https://21st.dev/home)** — community registry ขนาดใหญ่ที่สุดสำหรับ React components บน AI ecosystem ปัจจุบันมีนักพัฒนาใช้งานกว่า 1.4M คน (200K monthly active) ประกอบด้วย:
- Component พร้อมใช้ทั้ง Framer Motion, Tailwind CSS
- Motion Primitives: UI kit สำหรับ fluid animations
- "Magic Chat": generate + remix component ผ่าน AI chat
- copy ได้ด้วย `npx shadcn add <component>` — source code ตกลงมาใน repo เลย ไม่มี npm dependency

วิธีใช้กับ HTML Presentation: เปิด 21st.dev → เลือก component ที่ชอบ (เช่น 3D background, scroll animation) → copy prompt ของ component นั้น → วางลงใน AI agent พร้อมบอกว่าต้องการ inject ลง slide ไหน

**Motion Sites** — รวม design inspiration และ UI components สำหรับ web animation บางส่วนเป็น premium แต่สามารถ:
- copy free components มาใช้ได้ตรงๆ
- ใช้ premium designs เป็น visual reference แล้วให้ AI recreate effect คล้ายๆ กันแบบฟรี

**[reveal.js](https://revealjs.com/)** — HTML presentation framework open-source ยอดนิยม ที่ HTML Slide Skills หลายตัวใช้เป็น foundation ฟีเจอร์ที่น่าสนใจ:
- nested slides (slides ซ้อนกัน)
- Auto-Animate (animate elements อัตโนมัติระหว่าง slides)
- 3D transitions หลายแบบ
- Markdown support, code highlighting, speaker notes
- ผสานกับ Three.js / D3 ได้

---

## User Guide (Step-by-Step)

### 1. ติดตั้ง HTML Slide Skill

**วิธีที่ 1 — Claude Code (VS Code extension):**
1. เปิด Claude Code ใน VS Code
2. พิมพ์ prompt: `Install this skill: <GitHub URL ของ skill ที่เลือก>`
3. Claude จะ fetch และติดตั้ง skill ให้อัตโนมัติ

**วิธีที่ 2 — ผ่าน terminal:**
```bash
# ตัวอย่าง skill จาก mcpmarket.com (ตรวจสอบ URL จริงก่อนใช้)
claude skill install <skill-name>
```

ตรวจสอบ skill ที่มีได้ที่:
- [mcpmarket.com/tools/skills](https://mcpmarket.com/) — catalog หลายร้อย skills
- [explainx.ai/skills](https://explainx.ai/) — skills พร้อม preview
- [tosea.ai blog](https://tosea.ai/blog/best-html-slide-skills-library-2026) — รายการ 30+ HTML slide skills 2026

### 2. สร้าง Presentation ครั้งแรก

```
prompt ตัวอย่าง:
"สร้าง pitch deck 8 slides เกี่ยวกับ SaaS product ที่ช่วย SME จัดการ inventory 
อยากให้ดูทันสมัย มีความน่าเชื่อถือ รองรับ B2B audience 
ใช้ dark theme ถ้าเป็นไปได้"
```

AI จะ:
1. generate preview 3 styles ให้เลือก
2. รอการ confirm style ที่ชอบ
3. สร้าง deck เต็มรูปแบบ ใน `presentation.html`

### 3. แก้ไขใน Browser

เปิดไฟล์ใน browser → คลิกที่ข้อความที่ต้องการแก้ → พิมพ์แทนได้เลย ไม่ต้องกลับไปแก้โค้ด

### 4. เสริม Component จาก 21st.dev

```
prompt เพิ่ม component:
"เปิด 21st.dev แล้วหา animated gradient background component 
inject ลงใน slide 1 (title slide) ของ presentation.html"
```

AI จะ:
- fetch component code
- embed ลงใน slide ที่ระบุ
- maintain compatibility กับ slide ที่เหลือ

### 5. Deploy หรือ Export

**Deploy เป็น website:**
```bash
# GitHub Pages (ฟรี)
git add presentation.html
git commit -m "add presentation"
git push origin main
# เปิด GitHub Pages settings → เลือก source = main branch
```

**Export PDF:**
- เปิด browser → File → Print → Save as PDF
- หมายเหตุ: animation จะหายไปใน PDF version

---

## Caveats / Limits

- **PDF = static**: export PDF ได้ แต่จะเหลือแค่ snapshot ของแต่ละ slide ไม่มี animation
- **Browser-specific**: บาง CSS 3D effect อาจแสดงผลต่างกันระหว่าง browser (ทดสอบบน Chrome/Edge ก่อน)
- **Skill quality varies**: HTML slide skills แต่ละตัวมีคุณภาพต่างกัน บางตัวให้ผล generic ควรทดสอบหลาย skills แล้วเลือก
- **Component compatibility**: การ inject component จาก 21st.dev ที่เป็น React อาจต้องปรับให้เป็น vanilla JS ก่อน ถ้า slide output ไม่ใช่ React-based
- **ขนาดไฟล์**: ถ้า embed หลาย animation/3D component ไฟล์อาจใหญ่ขึ้น (10MB+) ควร optimize ก่อน deploy สำหรับ audience ที่ internet ช้า
- **Offline**: ถ้า component ดึง resource จาก CDN จะใช้งานไม่ได้ offline — ควร bundle ไว้ในไฟล์ถ้าต้องการ

---

## References

1. [ยุคใหม่ของ Presentation Slide? Unlock Claude Code Skill + แจกพิกัดเว็บ UI (ลับ?) — YouTube](https://youtu.be/o33Gqh6wIs4)
2. [The HTML presentation framework — reveal.js](https://revealjs.com/)
3. [21st.dev — AI Agent Registry, UI Components & Developer Tools](https://21st.dev/home)
4. [Frontend Slides Claude Code Skill — mcpmarket.com](https://mcpmarket.com/tools/skills/frontend-slides)
5. [html-slides AI agent skill — explainx.ai](https://explainx.ai/skills/claude-office-skills/skills/html-slides)
6. [30+ Best HTML Slide Skills for Claude Code, Codex & Cursor: Complete 2026 Library — tosea.ai](https://tosea.ai/blog/best-html-slide-skills-library-2026)
7. [Motion Primitives UI components — 21st.dev](https://21st.dev/community/motion-primitives)
8. [Create 3D and animated presentations using Impress.js — free-power-point-templates.com](https://www.free-power-point-templates.com/articles/3d-and-animated-presentations-using-impress-js/)
9. [The 2026 Stack for AI-Assisted UI: 21st.dev + UI/UX Pro Max + Motion — neuroxai.com](https://neuroxai.com/blog/ai-assisted-ui-stack-21st-dev-ui-ux-pro-max-motion)

---

## Key Takeaways

- HTML Presentation Skill เปลี่ยน workflow สร้างสไลด์จาก "ออกแบบทีละ element" เป็น "อธิบาย outcome แล้วให้ AI สร้าง" — เร็วกว่าชัดเจน
- 12 preset styles + 3 preview before commit = ลด AI slop ได้มาก ไม่ต้องเจอ output ที่ generic
- Browser editing แบบ click-to-edit ลด feedback loop: แก้ไขได้เลยโดยไม่ต้องกลับไปแก้โค้ด
- 21st.dev เป็น "component store" ที่ AI agent ดึงมาใช้ได้ตรงๆ — copy prompt → inject ลง slide ได้เลย
- HTML = web-native: อะไรก็ตามที่ทำได้บน website ทำได้บน slide เช่น live API call, real-time chart, 3D scene
- PDF export ได้ แต่สูญเสีย animation — ถ้าต้องการ share แบบ static ควรวางแผนไว้ล่วงหน้า
- เหมาะที่สุดสำหรับ: pitch deck, technical presentation, project showcase ที่ต้องการ impression แรกที่แข็งแกร่ง
