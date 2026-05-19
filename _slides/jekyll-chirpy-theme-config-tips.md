---
marp: true
theme: default
paginate: true
---

# Jekyll Chirpy Theme Config Tips

**Config สองชั้น: รู้ว่าอะไรอยู่ที่ไหน แก้ปัญหาได้ก่อน error**

---

## TL;DR

- Chirpy config แยกเป็นสองชั้น: **site-wide** (`_config.yml`) และ **per-post** (frontmatter)
- ใส่ผิดชั้น → feature ดับโดยไม่มี error message
- date format ผิด → post หาย silent

---

## ทำไม Config Layer ถึงสำคัญ

Chirpy มี feature หนาแน่น: TOC, comments, math, mermaid, PWA, analytics

สองชั้นที่ต้องรู้:

- **`_config.yml`** — ค่า default ทั้ง site; เปลี่ยนที่นี่กระทบทุก page
- **Frontmatter** — override เฉพาะ post นั้น; ไม่กระทบ post อื่น

ตัวอย่างปัญหา: ใส่ `toc: false` ใน `_config.yml` → TOC ดับทั้ง site

---

## `_config.yml` — Site-Wide (1/2)

| Field | ค่าตัวอย่าง | ผลลัพธ์ |
|---|---|---|
| `lang` | `en` / `th` | ภาษา UI |
| `timezone` | `Asia/Bangkok` | timezone สำหรับ build |
| `title` | `"My Notes"` | ชื่อ site |
| `tagline` | `"notes on things"` | subtitle |
| `url` | `https://user.github.io` | base URL (ต้องถูกสำหรับ SEO) |
| `avatar` | `/assets/img/avatar.jpg` | รูปใน sidebar |

---

## `_config.yml` — Site-Wide (2/2)

| Field | ค่าตัวอย่าง | ผลลัพธ์ |
|---|---|---|
| `paginate` | `10` | posts/page |
| `toc` | `true` / `false` | TOC ทั้ง site |
| `comments.provider` | `giscus` / `utterances` | ระบบ comment |
| `pwa.enabled` | `true` | Progressive Web App |
| `cdn` | `https://cdn.example.com` | CDN prefix สำหรับ assets |

> Social links → `_data/contact.yml` (ไม่ใช่ `_config.yml`)

---

## Frontmatter — Per-Post (1/2)

| Field | ผลลัพธ์ |
|---|---|
| `date: YYYY-MM-DD HH:MM:SS +0700` | future date = Jekyll suppress post |
| `categories: [A, B]` | max 2 items; hierarchy |
| `tags: [lowercase]` | ไม่จำกัด |
| `toc: false` | ปิด TOC เฉพาะ post นี้ |
| `comments: false` | ปิด comment เฉพาะ post นี้ |
| `pin: true` | ติดไว้บน homepage |
| `math: true` | เปิด MathJax |

---

## Frontmatter — Per-Post (2/2)

| Field | ผลลัพธ์ |
|---|---|
| `mermaid: true` | เปิด Mermaid diagram |
| `description: "..."` | custom excerpt แทน auto-generated |
| `image.path` | preview image (แนะนำ 1200×630px) |
| `image.lqip` | Low Quality Image Placeholder |
| `media_subpath: /path/` | prefix URL สำหรับ image ใน post |
| `render_with_liquid: false` | ปิด Liquid (ป้องกัน `{{` ถูก parse) |
| `author: <id>` | จาก `_data/authors.yml` |

---

## Steps 1–2: Date & Timezone

**Step 1: ตั้ง timezone ใน `_config.yml`**
```yaml
timezone: Asia/Bangkok
```

**Step 2: ใช้ date format ที่ปลอดภัย**
```yaml
date: 2026-05-20 12:00:00 +0700
# = 05:00 UTC — ปลอดภัยทุก build time zone
```

Jekyll builds ใน UTC — date ที่ดูเหมือน "วันนี้" ใน +0700
อาจเป็น "พรุ่งนี้" ใน UTC → post หาย

---

## Step 3: เปิด Math / Diagram เฉพาะ Post ที่ใช้

```yaml
math: true      # เปิด MathJax rendering
mermaid: true   # เปิด Mermaid diagram
```

Chirpy โหลด library ตาม flag — **ไม่ต้องเปิดทั้ง site**

เปิดเฉพาะ post ที่ใช้จริง → page load ที่เหลือเร็วขึ้น

---

## Steps 4–5: Image & Media Path

**Step 4: preview image**
```yaml
image:
  path: /assets/img/posts/my-post.jpg
  alt: "description"   # สำคัญสำหรับ accessibility
```
แนะนำ **1200×630px** (og:image ratio) — ผิด ratio อาจ crop แปลกใน social share

**Step 5: ลด path ซ้ำด้วย `media_subpath`**
```yaml
media_subpath: /assets/img/posts/my-post/
```
จากนั้นใช้ `![alt](filename.jpg)` แทน full path

---

## Step 6: ปิด Liquid สำหรับ Post ที่มี `{{` ใน Code

```yaml
render_with_liquid: false
```

ป้องกัน Jekyll parse `{{ variable }}` หรือ `{% include %}` ใน code block

⚠️ ปิด Liquid **ทั้ง post** — `{% include %}` tags ใช้ไม่ได้ด้วย

ใช้เฉพาะเมื่อ post มี Liquid syntax ใน code examples

---

## Caveats / Limits

- `categories` รับได้แค่ **2 items** — ใส่ 3 ไม่ error แต่ hierarchy เพี้ยน
- `pin: true` หลาย post → sort ตาม date ล่าสุด ไม่มี manual order
- `comments: true` ไม่มี provider ใน `_config.yml` → ไม่มีอะไรแสดง
- `cdn` ใน `_config.yml` → built-in theme assets เท่านั้น; รูปใน `_posts/` ใช้ `media_subpath`
- `render_with_liquid: false` → `{% include %}` tags ใน body ใช้งานไม่ได้

---

## Key Takeaways

- **สองชั้น**: `_config.yml` (site-wide) vs frontmatter (per-post) — ผิดชั้น feature ดับไม่มี error
- **Date**: `HH:MM:SS = 12:00:00 +0700` ป้องกัน future-post suppress
- **math/mermaid**: เปิดเฉพาะ post ที่ใช้ ประหยัด page load
- **categories**: max 2 items; tags ไม่จำกัด
- **render_with_liquid: false**: แก้ปัญหา `{{` ใน code block ถูก parse
