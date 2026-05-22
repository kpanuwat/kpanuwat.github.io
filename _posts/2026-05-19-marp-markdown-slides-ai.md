---
title: "Marp: สร้าง Presentation Slides จาก Markdown ด้วย AI"
date: 2026-05-19 00:09:00 +0700
categories: [Tools]
tags: [marp, markdown, slides, presentation, ai, open-source, claude-code]
slides: true
---

{% include slide-link.html %}

## TL;DR

Marp เปลี่ยนไฟล์ Markdown ธรรมดาให้กลายเป็น Presentation Slides ระดับมืออาชีพ — ส่ง export เป็น HTML, PDF, PPTX หรือ PNG/JPEG ได้ในคำสั่งเดียว เมื่อจับคู่กับ Claude Code ก็แปลง blog post หรือ notes เป็น slide deck ได้โดยอัตโนมัติ

## Background / Why This Matters

ปัญหาคลาสสิกของการทำ presentation: เนื้อหาพร้อมแล้ว แต่เสียเวลาครึ่งชั่วโมงกับ PowerPoint — จัด alignment, เลือกฟอนต์, ลาก text box ให้ตรง ทั้งที่ใจความสำคัญอยู่ในหัวแล้ว

Marp แก้ปัญหานี้ด้วยแนวคิด **"เขียน content ก่อน format ทีหลัง"** คล้ายกับที่ Markdown เปลี่ยนการเขียน HTML — ใช้ `---` คั่น slide, ใช้ `#` ทำหัวเรื่อง, ใช้ `-` ทำ bullet list ที่เคยรู้จักอยู่แล้ว ผลลัพธ์ได้ slides ที่ consistent ทันที

สำหรับ developer หรือ technical writer ที่เขียน Markdown อยู่แล้ว ต้นทุนการเรียนรู้ใกล้ศูนย์ เพิ่มเพียง syntax เล็กน้อยสำหรับ directives แล้วปล่อยให้ Marp จัดหน้าให้เอง

## Deep Dive

### สถาปัตยกรรม

Marp ไม่ใช่เครื่องมือเดียว แต่เป็น **ecosystem** ที่แยกชั้นชัดเจน:

| Component | บทบาท |
|-----------|-------|
| **Marpit Framework** | core engine แปลง Markdown + CSS → HTML slide deck |
| **Marp Core** | ต่อยอด Marpit เพิ่ม extended syntax, image sizing, math |
| **Marp CLI** | command-line สำหรับ export HTML/PDF/PPTX/images |
| **Marp for VS Code** | extension preview แบบ real-time ขณะเขียน |

### Themes

Built-in themes 3 แบบ (ใช้ผ่าน `theme:` directive):

- `default` — สะอาด minimal บนพื้นขาว
- `gaia` — สีเข้ม เหมาะงาน tech talk
- `uncover` — เส้นขอบ gradient ดูทันสมัย

Override ด้วย CSS ได้ผ่าน `style:` directive โดยไม่ต้องแยกไฟล์

### Directives ที่ใช้บ่อย

**Global** (ใส่ใน frontmatter — ใช้กับทุก slide):

```markdown
---
marp: true
theme: default
paginate: true
size: 16:9
---
```

**Local** (ใส่ใน HTML comment ภายใน slide):

```markdown
<!-- backgroundColor: #1a1a2e -->
<!-- backgroundImage: url('bg.png') -->
<!-- color: white -->
```

เพิ่ม `_` นำหน้า directive (เช่น `<!-- _backgroundColor: ... -->`) เพื่อให้ใช้เฉพาะ slide นั้น ไม่ inherit ต่อไปยัง slide ถัดไป

### Image Syntax

Marp ขยาย Markdown image syntax ด้วย keywords พิเศษ:

```markdown
![bg](image.png)            # background image
![bg left:40%](image.png)  # bg ซ้าย 40% ของหน้า
![w:300px h:200px](img.png) # กำหนด size ตรง ๆ
```

## User Guide (Step-by-Step)

### 1. ติดตั้ง

ต้องการ Node.js v18+ และ Chrome/Edge/Firefox (สำหรับ PDF/PPTX export)

```bash
# ใช้ครั้งเดียว ไม่ต้องติดตั้ง
npx @marp-team/marp-cli@latest slide-deck.md

# ติดตั้งใน project
npm install --save-dev @marp-team/marp-cli

# global
npm install -g @marp-team/marp-cli

# macOS / Linux via Homebrew
brew install marp-cli
```

### 2. สร้าง slide แรก

```markdown
---
marp: true
theme: default
paginate: true
---

# หัวข้อ Presentation

ชื่อผู้พูด — วันที่

---

## Slide 2

- ประเด็น 1
- ประเด็น 2
- ประเด็น 3

---

## จบ

ขอบคุณ
```

### 3. Export

```bash
# HTML (default)
npx marp slide-deck.md

# PDF
npx marp --pdf slide-deck.md

# PowerPoint
npx marp --pptx slide-deck.md

# PNG ทุก slide
npx marp --images png slide-deck.md

# กำหนด output path
npx marp slide-deck.md -o output.html

# Watch mode (auto-rebuild เมื่อแก้ไฟล์)
npx marp -w slide-deck.md
```

### 4. ใช้ร่วมกับ Claude Code

Claude Code + Marp CLI = workflow สร้าง slide จาก blog post อัตโนมัติ ตัวอย่าง prompt:

> "แปลง blog post นี้เป็น Marp slide deck — ทำ TL;DR เป็น slide แรก, แต่ละ section เป็น slide, ใส่ key points เป็น bullet"

Claude เขียน `.md` ไฟล์ตาม structure ที่ขอ จากนั้น:

```bash
# render เป็น HTML ดู preview
npx -p @marp-team/marp-cli@4.4.0 marp _slides/post-slug.md -o slides/post-slug.html --html
```

บน knowledge-hub นี้ทุก blog post จะถูก chain ไปสร้าง slide deck อัตโนมัติผ่าน `marp-deck` skill — CI รัน Marp render ก่อน Jekyll build ทุกครั้ง

### 5. Daily Workflow

```bash
# เขียน + preview แบบ live
npx marp -s ./_slides      # server mode — เปิด browser ที่ localhost:8080

# export ทั้ง directory
npx marp -I _slides/ -o slides/ --html
```

## Caveats / Limits

- **Browser required สำหรับ PDF/PPTX**: ต้องติดตั้ง Chrome, Edge หรือ Firefox — headless mode ไม่ทำงานบน minimal container โดยไม่ติดตั้ง Chromium แยก
- **Layout ซับซ้อน**: สามารถทำ two-column ด้วย CSS grid ผ่าน `style:` directive แต่ debug ยากกว่า drag-and-drop ใน PowerPoint
- **Animation**: Marp ไม่ support slide transition animation แบบ built-in — ต้องใช้ CSS custom หรือยอมรับว่าไม่มี
- **Node.js v18+ required**: environment เก่าอาจต้องอัปเกรด
- **Offline font**: theme ใช้ Google Fonts บางตัว — export HTML สำหรับ offline ต้อง bundle fonts เพิ่ม
- **Auto-scaling**: ข้อความยาวมากจะ scale ลงอัตโนมัติ อาจดูเล็กเกินไปถ้าใส่ content มากเกิน 1 slide

## References

1. [Marp — Markdown Presentation Ecosystem (official site)](https://marp.app/)
2. [Marp CLI GitHub Repository](https://github.com/marp-team/marp-cli)
3. [Marpit Framework](https://marpit.marp.app/)
4. [Marp for VS Code — VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)
5. [Marp Directives Documentation](https://github.com/marp-team/marp/blob/main/website/docs/guide/directives.md)
6. [สอนใช้ Marp (YouTube)](https://youtu.be/TZQzIYLibyk)

## Key Takeaways

- Marp เป็น MIT-licensed open-source ecosystem ไม่ใช่แค่ CLI tool เดียว — ประกอบด้วย Marpit (core), Marp CLI, VS Code extension
- คั่น slide ด้วย `---`, ควบคุม theme/layout ด้วย YAML directives ใน frontmatter หรือ HTML comment ใน slide
- Export ได้ HTML, PDF, PPTX, PNG/JPEG ด้วย Marp CLI v4.4.0 — PDF/PPTX ต้องมี Chrome/Edge/Firefox
- `_` นำหน้า directive ทำให้ใช้เฉพาะ slide เดียว ไม่ inherit ต่อ — เช่น `<!-- _backgroundColor: red -->`
- จับคู่กับ Claude Code: เขียน Markdown notes → ให้ AI แปลงเป็น slide structure → render ด้วย Marp CLI ครบจบใน pipeline เดียว
- Watch mode (`-w`) และ Server mode (`-s`) ช่วย preview แบบ real-time ขณะเขียน
