---
title: "Jekyll Chirpy Theme Config Tips"
date: 2026-05-19 12:00:00 +0700
categories: [Tools]
tags: [jekyll, chirpy, static-site]
render_with_liquid: false
---

## TL;DR

Chirpy มี config สองชั้น: `_config.yml` ควบคุม site-wide, frontmatter ควบคุม per-post. รู้ว่า field ไหนอยู่ที่ไหนช่วยประหยัดเวลา debug ได้มาก

## Background / Why this matters

Jekyll Chirpy เป็น theme ที่มี feature หนาแน่น — TOC, comments, math, mermaid, PWA, analytics — แต่ทุก feature ต้องการ config ที่ถูกชั้น ถ้าใส่ผิดชั้น (เช่น ใส่ `toc: false` ใน `_config.yml` แทน frontmatter) feature ดับทั้ง site โดยไม่มี error

Chirpy แยก config ออกเป็นสองชั้นชัดเจน:

- **Site-wide** (`_config.yml`) — ค่า default ที่ทุก page ได้รับ เช่น timezone, avatar, comments provider
- **Per-post** (frontmatter) — override เฉพาะ post นั้น เช่น ปิด TOC, เปิด math

เข้าใจ contract นี้ก่อนจะทำให้ config ไม่งง

## Deep Dive

### `_config.yml` — site-wide settings

| Field | ค่าตัวอย่าง | ผลลัพธ์ |
|---|---|---|
| `lang` | `en` / `th` | ภาษา UI ของ theme |
| `timezone` | `Asia/Bangkok` | กำหนด timezone สำหรับ build |
| `title` | `"My Notes"` | ชื่อ site ใน header และ tab |
| `tagline` | `"notes on things"` | subtitle ใต้ title |
| `url` | `https://user.github.io` | base URL — ต้องถูกสำหรับ sitemap และ SEO |
| `avatar` | `/assets/img/avatar.jpg` | รูปใน sidebar |
| `paginate` | `10` | จำนวน post ต่อหน้า |
| `toc` | `true` / `false` | เปิด/ปิด TOC ทั้ง site |
| `comments.provider` | `giscus` / `utterances` / `disqus` | ระบบ comment |
| `pwa.enabled` | `true` | เปิด Progressive Web App |
| `cdn` | `https://cdn.example.com` | CDN prefix สำหรับ assets |

**Social links** จัดการผ่าน `_data/contact.yml` ไม่ใช่ `_config.yml` โดยตรง

### Frontmatter — per-post overrides

| Field | Type | ผลลัพธ์ |
|---|---|---|
| `date` | `YYYY-MM-DD HH:MM:SS +0700` | timestamp — future date = Jekyll suppresses post |
| `categories` | array, max 2 items | จัด hierarchy ของ post |
| `tags` | array, lowercase | filter และ search |
| `toc` | bool | override site-wide TOC setting |
| `comments` | bool | เปิด/ปิด comment เฉพาะ post นี้ |
| `pin` | `true` | ติด post ไว้บน homepage |
| `math` | `true` | เปิด MathJax rendering |
| `mermaid` | `true` | เปิด Mermaid diagram |
| `description` | string | custom excerpt แทน auto-generated |
| `image.path` | path / URL | preview image (แนะนำ 1200×630px) |
| `image.alt` | string | alt text สำหรับ accessibility |
| `image.lqip` | base64 string | Low Quality Image Placeholder ใช้ lazy-load |
| `media_subpath` | `/assets/img/posts/slug/` | prefix URL สำหรับ image ใน post |
| `render_with_liquid` | `false` | ปิด Liquid processing (ป้องกัน `{{ }}` ใน code block ถูก parse) |
| `author` | id จาก `_data/authors.yml` | ระบุ author (ถ้า multi-author site) |

## User Guide (Step-by-Step)

### 1. ตั้ง timezone ให้ถูก

```yaml
# _config.yml
timezone: Asia/Bangkok
```

Jekyll builds ใน UTC — ถ้าไม่ตั้ง timezone ให้ตรง post ที่ date เป็น `2026-05-20 23:00:00 +0700` อาจถูก suppress เพราะ build server เห็นว่าเป็น future date

### 2. ป้องกัน post ถูก suppress

```yaml
# frontmatter — ใช้ 12:00:00 +0700 (= 05:00 UTC) ปลอดภัยทุก build time
date: 2026-05-20 12:00:00 +0700
```

### 3. เปิด math หรือ diagram เฉพาะ post ที่ต้องการ

```yaml
math: true      # เปิด MathJax
mermaid: true   # เปิด Mermaid
```

ไม่ต้องเปิดทั้ง site เพราะ Chirpy โหลด library พวกนี้ตาม frontmatter flag — เปิดเฉพาะ post ที่ใช้จริงช่วยประหยัด page load

### 4. ตั้ง image preview

```yaml
image:
  path: /assets/img/posts/my-post.jpg
  alt: "description of image"
```

รูปขนาด **1200×630px** คือ recommended ratio สำหรับ og:image (OpenGraph) — ถ้าผิด ratio อาจ crop แปลกใน social share

### 5. ใช้ `media_subpath` แทนการพิมพ์ path ซ้ำ

```yaml
media_subpath: /assets/img/posts/my-post/
```

จากนั้นใน body ใช้แค่ `![alt](filename.jpg)` แทน full path

### 6. ปิด Liquid สำหรับ post ที่มี `{{ }}` ใน code

```yaml
render_with_liquid: false
```

ป้องกัน Chirpy parse `{{ variable }}` ใน code block เป็น Liquid template (ต้องการ Jekyll 4.0+)

## Caveats / Limits

- `categories` รับได้แค่ **2 items** — ถ้าใส่ 3 Chirpy ไม่ error แต่ hierarchy แสดงผลเพี้ยน
- `pin: true` หลาย post พร้อมกัน — Chirpy sort ตาม date ล่าสุดก่อน ไม่มี manual order
- `comments` ใน frontmatter เป็น boolean ต้องตั้ง provider ใน `_config.yml` ก่อนถึงจะมีผล — `comments: true` โดยไม่มี provider = ไม่มีอะไรแสดง
- `cdn` field ใน `_config.yml` ส่งผลกับ **built-in assets** ของ theme เท่านั้น — รูปใน `_posts/` ต้องใช้ `media_subpath` แยก
- `render_with_liquid: false` ปิด Liquid **ทั้ง post** รวมถึง `{% include %}` tags ด้วย — ใช้เฉพาะเมื่อจำเป็น

## References

1. [Write a New Post — Chirpy Docs](https://chirpy.cotes.page/posts/write-a-new-post/) — frontmatter fields ทุก field + valid values
2. [jekyll-theme-chirpy `_config.yml`](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_config.yml) — site-wide config fields และ comments

## Key Takeaways

- Config มีสองชั้น: `_config.yml` (site-wide) vs frontmatter (per-post) — ใส่ผิดชั้นทำให้ feature ดับโดยไม่มี error
- `date: YYYY-MM-DD 12:00:00 +0700` ป้องกัน post ถูก suppress เสมอ ไม่ว่า build time จะเป็นเมื่อไร
- `math`, `mermaid` เปิดเฉพาะ post ที่ใช้ — ช่วย page load ที่เหลือ
- `categories` รับได้แค่ 2 items; `tags` ไม่จำกัด
- `render_with_liquid: false` แก้ปัญหา `{{ }}` ใน code block ถูก parse เป็น Liquid template
