---
marp: true
theme: default
paginate: true
---

# Marp: สร้าง Slides จาก Markdown

**แปลง Markdown → HTML / PDF / PPTX ด้วย AI ในคำสั่งเดียว**

---

## TL;DR

- Marp = open-source ecosystem เปลี่ยน `.md` → slides
- Export: HTML, PDF, PPTX, PNG/JPEG — ไม่ต้อง drag-and-drop
- จับคู่ Claude Code → แปลง blog post เป็น deck อัตโนมัติ
- MIT-licensed, Node.js v18+, CLI v4.4.0

---

## ปัญหาที่ Marp แก้

เนื้อหาพร้อม แต่เสียเวลากับ PowerPoint:

- ↗ จัด alignment
- ↗ เลือกฟอนต์
- ↗ ลาก text box ให้ตรง

**แนวคิด Marp: "เขียน content ก่อน — format ทีหลัง"**

เหมือนที่ Markdown เปลี่ยนการเขียน HTML

---

## Marp Ecosystem

| Component | บทบาท |
|-----------|-------|
| **Marpit Framework** | core engine: Markdown + CSS → HTML |
| **Marp Core** | extended syntax, image sizing, math |
| **Marp CLI** | export HTML / PDF / PPTX / images |
| **Marp for VS Code** | real-time preview ขณะเขียน |

---

## 3 Built-in Themes

| Theme | ลักษณะ | เหมาะกับ |
|-------|--------|---------|
| `default` | minimal, พื้นขาว | docs, tutorials |
| `gaia` | สีเข้ม, bold | tech talks |
| `uncover` | gradient, modern | product demos |

Override ด้วย CSS ผ่าน `style:` directive — ไม่ต้องแยกไฟล์

---

## Directives — Global

ใส่ใน frontmatter ของไฟล์ (ใช้กับทุก slide):

```markdown
---
marp: true
theme: default
paginate: true
size: 16:9
---
```

---

## Directives — Local + Image

ควบคุมเฉพาะ slide ด้วย HTML comment:

```markdown
<!-- backgroundColor: #1a1a2e -->
<!-- _color: white -->   ← _ = เฉพาะ slide นี้
```

Image syntax พิเศษของ Marp:

```markdown
![bg left:40%](image.png)    ← bg ซ้าย 40%
![w:300px h:200px](img.png)  ← กำหนด size ตรง ๆ
```

---

## Step 1: ติดตั้ง

ต้องการ Node.js v18+ และ Chrome/Edge/Firefox

```bash
# ใช้ครั้งเดียว — ไม่ต้องติดตั้ง
npx @marp-team/marp-cli@latest slide-deck.md

# ติดตั้งใน project
npm install --save-dev @marp-team/marp-cli

# Homebrew (macOS/Linux)
brew install marp-cli
```

---

## Step 2: สร้าง Slide แรก

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
```

คั่น slide ด้วย `---` บรรทัดเดียว

---

## Step 3: Export

```bash
npx marp slide-deck.md              # → HTML
npx marp --pdf slide-deck.md        # → PDF
npx marp --pptx slide-deck.md       # → PowerPoint
npx marp --images png slide-deck.md # → PNG ทุก slide
npx marp -w slide-deck.md           # watch mode
```

> PDF/PPTX ต้องมี Chrome, Edge หรือ Firefox ติดตั้งอยู่

---

## Step 4: Claude Code + Marp

**Prompt ตัวอย่าง:**

> "แปลง blog post นี้เป็น Marp slide deck — TL;DR เป็น slide แรก, แต่ละ section เป็น slide, key points เป็น bullet"

```bash
# render หลัง Claude เขียน deck
npx -p @marp-team/marp-cli@4.4.0 \
  marp _slides/post-slug.md \
  -o slides/post-slug.html --html
```

---

## Step 5: Daily Workflow

```bash
# preview แบบ live (server mode)
npx marp -s ./_slides    # → localhost:8080

# export ทั้ง directory
npx marp -I _slides/ -o slides/ --html
```

บน knowledge-hub: CI รัน Marp render → Jekyll build อัตโนมัติทุก push

---

## Caveats / Limits

- **Browser required** — PDF/PPTX export ต้องมี Chrome/Edge/Firefox
- **No animation** — ไม่มี slide transition built-in
- **Layout ซับซ้อน** — two-column ทำได้ผ่าน CSS grid แต่ debug ยาก
- **Auto-scaling** — content มากเกินไป → ข้อความเล็กโดยอัตโนมัติ
- **Offline font** — themes ใช้ Google Fonts → export offline ต้อง bundle เพิ่ม

---

## Key Takeaways

- Marp = ecosystem ไม่ใช่แค่ CLI: Marpit → Marp Core → CLI → VS Code
- `---` คั่น slide, YAML frontmatter + HTML comment ควบคุม layout
- Export 4 รูปแบบ: HTML / PDF / PPTX / PNG — ด้วย flag เดียว
- `_` นำหน้า directive = ใช้เฉพาะ slide นั้น ไม่ inherit ต่อ
- Claude Code + Marp CLI = pipeline แปลง notes → slides อัตโนมัติ
