---
title: "หยุดให้ AI Agent เขียน Markdown: ทำไม HTML ถึงเป็น Output Format ที่ดีกว่า"
date: 2026-05-27 00:16:00 +0700
categories: [Engineering]
tags: [ai-agents, html, markdown, llm, claude, output-formatting, developer-experience]
slides: true
---

{% include slide-link.html %}

## TL;DR

เมื่อ AI Agent มีพลังมากขึ้น Markdown กลายเป็นกำแพงข้อความที่ไม่มีใครอ่าน การเปลี่ยนมาใช้ HTML เป็น output format ช่วยให้มนุษย์อยู่ "in the loop" กับ AI ได้จริง ด้วย diagrams, interactive elements, และ side-by-side comparisons — แม้ token cost จะสูงกว่า แต่คุ้มค่าในงานที่ต้องการความชัดเจน

## Background: ทำไม Markdown ถึงพอแล้ว

ย้อนกลับไปไม่กี่ปี Markdown เป็นตัวเลือกที่สมเหตุสมผลสำหรับ AI output:

- **Simple และ portable** — ไฟล์ `.md` เปิดได้ทุกที่
- **Easy to edit** — developer แก้ไขได้เองโดยตรง
- **Lightweight** — token ต่ำ render เร็ว

แต่พฤติกรรมการใช้งานเปลี่ยนไป เมื่อ AI agents เก่งขึ้น output ก็ใหญ่ขึ้นตาม จาก 20 บรรทัดเป็น 100+ บรรทัด จาก plan สั้นๆ เป็น spec เต็มรูปแบบ และ developer ก็หยุดอ่านมันจริงๆ

**Thor (ผู้สร้าง T3 Code)** ซึ่งเป็นผู้นำเสนอแนวคิดนี้ใน ["Stop letting your agents write Markdown"](https://youtu.be/S9EGx6ik-18) บันทึกสิ่งที่เกิดขึ้นจากประสบการณ์จริงว่า เขาเริ่มไม่แก้ไข Markdown files เองอีกต่อไป แต่ prompt Claude ให้แก้แทน ซึ่งทำให้หนึ่งในข้อดีสำคัญของ Markdown หายไป — ความง่ายในการแก้ไขโดยมนุษย์

## Deep Dive

### ปัญหาของ Markdown ที่คนมักมองข้าม

**1. "กำแพงข้อความ" (Text Wall Problem)**

ไฟล์ Markdown เกิน 100 บรรทัดคือ death zone ในทางปฏิบัติ developer ไม่อ่าน และยิ่งเป็นไปไม่ได้เลยที่จะให้คนในองค์กรอ่านร่วมกัน เมื่อ AI เขียน spec 200 บรรทัด มันกลายเป็น sequential wall of text ที่ต้องพยายามจับประเด็นทั้งหมดไว้ในหัวพร้อมกัน

**2. Markdown ทำ Diagram ผิดเสมอ**

AI models มักทำ Markdown diagrams พัง: padding เลื่อน, border ไม่ตรง, สีถูก "estimate" ด้วย Unicode characters แทนที่จะ render จริงๆ สิ่งที่ดูดีใน editor หนึ่งอาจดูยับในอีก editor

**3. Share ยาก**

Browser ส่วนใหญ่ไม่ render Markdown natively ต้องส่งเป็น attachment หรือใช้ GitHub/GitLab ในขณะที่ HTML เปิดในทุก browser ได้ทันทีโดยไม่ต้องติดตั้งอะไร

### ทำไม HTML ถึงดีกว่า

HTML สามารถ represent ข้อมูลได้หลากหลายประเภทที่ Markdown ทำไม่ได้:

| ประเภทข้อมูล | Markdown | HTML |
|---|---|---|
| Document structure | ✅ Headers, lists | ✅ + visual hierarchy |
| Tabular data | ⚠️ Basic table | ✅ Full `<table>` + CSS |
| Diagrams | ❌ มักพัง | ✅ SVG native |
| Interactivity | ❌ | ✅ JavaScript + sliders |
| Side-by-side layout | ❌ | ✅ CSS Grid/Flex |
| Mobile responsive | ❌ | ✅ Media queries |
| Spatial data | ❌ | ✅ Canvas + absolute positions |

ประโยค key จาก Thor: _"ไม่มีชุดข้อมูลใดที่ Claude อ่านได้ แต่ไม่สามารถ represent ด้วย HTML ได้อย่างมีประสิทธิภาพ"_

### Use Cases จริงที่ HTML เหนือกว่า

**Design Exploration: 4 Mockups ใน 1 ไฟล์**

แทนที่จะขอ mockup ทีละชิ้น → ขอ 4 variants พร้อมกัน วางบน 4 routes ใน HTML เดียว เปิด browser เลือกได้ทันที ไม่ต้องจินตนาการจาก text description

**Technical Comparisons: Debounced Search Example**

Thor สาธิตการขอ HTML สำหรับ 3 วิธีใช้งาน debounced search:
1. `inline useEffect + setTimeout`
2. `custom useDebounce hook`
3. tiny external library

แต่ละ option มี pros/cons table ใต้ code snippet และมี recommendation ที่ด้านล่าง แทนที่จะอ่านข้อความ developer เห็น structure ทันที

**Interactive Throwaway UI**

สร้าง single-use tools ชั่วคราว เช่น interactive table คำนวณ API cost: มี sliders ปรับ parameters, ปุ่ม "copy as JSON", "copy as prompt", "export CSV" ให้นำข้อมูลที่ tweak แล้วกลับไปใส่ใน prompt ต่อได้ทันที

**Specs ที่คนอ่านจริง**

HTML spec ที่มี tabs, links, illustrations และ mobile-responsive layout มีโอกาสถูกอ่านโดยทีมสูงกว่า Markdown wall of text อย่างมีนัยสำคัญ

### Token Cost Tradeoff

HTML "เผา output tokens" มากกว่า Markdown — ไฟล์ใหญ่กว่า bloated กว่า

แต่ Thor และทีม Claude Code team มองว่าคุ้มค่า เหตุผล:

1. **Context windows ใหญ่ขึ้น** — Claude Opus ที่มี 1M token context ทำให้ cost เพิ่มขึ้นไม่ noticeable มาก
2. **ถ้าไม่มีใครอ่าน output ก็ไร้ค่า** — token ถูกกว่าไม่ช่วยอะไร ถ้า developer ไม่ได้อ่าน plan ก่อน execute
3. **Expressiveness สูงกว่า** — HTML สื่อสารได้ dense กว่า ต่อ token ที่ใช้ เพราะใช้ visual structure แทน verbal description

ใช้ HTML เฉพาะเมื่อ: spec/plan ยาว, ต้องการ comparison, ต้องการ interactivity, หรือจะ share กับคนอื่น — ไม่จำเป็นต้องใช้ทุก output

### "Stay In the Loop": เหตุผลที่แท้จริง

Thor สรุปว่าเหตุผลหลักที่เขาใช้ HTML คือ _รู้สึกว่าตัวเองยัง in the loop กับ Claude อยู่_

เมื่อก่อน เขาหยุดอ่าน plan ละเอียด → ปล่อยให้ Claude ตัดสินใจเอง → เริ่มกลัวว่าจะหลุด context ของโปรเจกต์

HTML เปลี่ยนพฤติกรรมนี้: output ที่ readable → developer อ่านจริง → steering แม่นยำขึ้น → AI ทำงานตรง intent มากขึ้น

นี่คือ feedback loop ที่สำคัญที่สุดใน human-AI collaboration

### Future Direction: React + MDX

Thor และทีมมองว่า evolution ต่อไปคือ **React components + MDX** — agent generate custom React components dynamically ที่ render ผ่าน frameworks เช่น **Copilot Kit** ซึ่งมี hooks สำหรับ interactive components ให้ frontend และ backend interact กันได้ใน AI-driven systems

Andrej Karpathy ก็เห็นด้วยกับ direction นี้: _"audio is the human preferred input to AIs, but vision like images and HTML is the preferred output"_

## User Guide (Step-by-Step)

### วิธีเริ่มใช้ HTML Output กับ AI Agent

**Step 1: ขอ HTML แทน Markdown**

ใส่ที่ท้าย prompt:

```
...structure your response as HTML, then I'll view it in my browser
```

หรือสำหรับ Claude Code:

```
Write the spec as an HTML file to /tmp/spec.html with CSS styling
```

**Step 2: เปิดใน Browser**

```bash
open /tmp/spec.html        # macOS
xdg-open /tmp/spec.html    # Linux
```

**Step 3: ขอ Multiple Options ใน Layout เดียว**

```
Create an HTML file with 3 implementation approaches for [feature].
Each approach on its own <section> with pros/cons table underneath.
Include a recommendation section at the bottom.
```

**Step 4: Interactive Throwaway UI**

สำหรับงานที่ต้องการ tweak ค่า:

```
Build a throwaway HTML tool for [task] with:
- Sliders/inputs for key parameters
- Live preview of results
- "Copy as JSON" button to export settings back to me
```

**Step 5: เลือก Format ให้เหมาะงาน**

| งาน | Format แนะนำ |
|---|---|
| Quick note / reminder | Markdown |
| Code snippet เดี่ยว | Markdown |
| Plan > 50 บรรทัด | HTML |
| Design exploration | HTML |
| Spec ที่ share ได้ | HTML |
| Interactive tool | HTML |
| Report ให้ทีม | HTML |

## Caveats / Limits

**Token Cost สูง**: HTML output ใหญ่กว่า Markdown 2-5x ในกรณีที่มี CSS และ layout ซับซ้อน พิจารณา cost ก่อนใช้กับงาน routine

**ไม่ใช่ Silver Bullet**: output ที่ดี ยังต้องการ prompt ที่ดี HTML format ช่วยให้อ่านได้ แต่ไม่ช่วยให้ AI เข้าใจ requirement ถูกต้องมากขึ้น

**ไม่เหมาะกับทุก pipeline**: ถ้า workflow ต่อมาต้องการ parse text (เช่น ส่งไป another LLM หรือ script) HTML อาจซับซ้อนเกิน Markdown เหมาะกว่า

**Security**: HTML ที่มี JavaScript ควรเปิดใน isolated environment หรือ `<iframe sandbox>` ถ้าเป็น output จาก untrusted source

**React/MDX ยังซับซ้อน**: สำหรับทีมที่ไม่มี frontend setup Copilot Kit หรือ MDX อาจ overkill สำหรับงาน simple HTML ใน static file เพียงพอ

## References

1. Thor, "Stop letting your agents write Markdown" — [youtu.be/S9EGx6ik-18](https://youtu.be/S9EGx6ik-18)
2. Copilot Kit — enterprise AI app framework with React component rendering — [copilotkit.ai](https://copilotkit.ai)
3. T3 Code — open-source terminal for AI coding — referenced in video
4. Andrej Karpathy tweet on HTML as preferred AI output format — referenced in video
5. Claude Code GitHub — [github.com/anthropics/claude-code](https://github.com/anthropics/claude-code)
6. Devon Review — AI PR analysis tool — referenced in video
7. Pangram Labs — AI text detection — referenced in video

## Key Takeaways

- **Markdown พัง ที่ scale**: ไฟล์เกิน 100 บรรทัดไม่มีใครอ่าน และ diagram มักพัง — เป็นข้อจำกัดจริง ไม่ใช่ user error
- **HTML เพิ่ม information density**: tables, SVG, CSS layout, interactivity ใน format เดียวที่ browser เปิดได้ทันที
- **เหตุผลหลักคือ "Stay in the loop"**: output ที่อ่านได้ทำให้ developer steering AI แม่นยำขึ้น ไม่ใช่แค่สวยงาม
- **Token cost คุ้มค่า** สำหรับงานที่ต้องการ human review — context window ใหญ่ขึ้นทำให้ต่างไม่มาก
- **ใช้เฉพาะเมื่อเหมาะสม**: plan ยาว, comparisons, interactive tools, shared specs — ไม่ใช่ทุก output
- **Future = React + MDX**: agent-generated interactive components ผ่าน frameworks เช่น Copilot Kit คือ evolution ต่อไป
- **เริ่มง่าย**: แค่เพิ่ม "structure as HTML" ท้าย prompt แล้วเปิดใน browser — ไม่ต้องติดตั้งอะไร
