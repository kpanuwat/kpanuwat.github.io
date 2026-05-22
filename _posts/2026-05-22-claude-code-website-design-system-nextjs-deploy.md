---
title: "สร้างเว็บไซต์ด้วย Claude Code: Design System → Next.js → Deploy ในหลักนาที"
date: 2026-05-22 00:04:00 +0700
categories: [Tools]
tags: [claude-code, nextjs, tailwind, design-system, spline, vercel, web-development]
slides: true
---

{% include slide-link.html %}

## TL;DR

Workflow ใหม่ปี 2026 เปลี่ยนงานเว็บที่เคยใช้เวลาหลายวันให้เหลือหลักนาที: ใช้ **Claude Design** สกัด Design System จากต้นแบบ → สร้าง Prototype → ส่ง Handoff Bundle ไปยัง **Claude Code** → พัฒนาด้วย Next.js + Tailwind ภายใต้ CLAUDE.md ที่คุม Brand Voice → เพิ่ม 3D จาก Spline หรือ AI Video จาก Higgsfield → Deploy อัตโนมัติผ่าน GitHub + Vercel

---

## Background / Why this matters

งานเว็บดีไซน์แบบดั้งเดิมมีคอขวดอยู่ที่การส่งต่องาน (Handoff) ระหว่างดีไซเนอร์กับนักพัฒนา ทีมต้องใช้เวลาหลายรอบในการตีความ Mockup, แปลง Design Token เป็น CSS, และรักษาความสม่ำเสมอของ Brand ตลอดทั้ง Codebase

**Claude Design** (เปิดตัว 17 เมษายน 2026 โดย Anthropic Labs) เป็นครั้งแรกที่ชั้น Visual Design และ Code เชื่อมต่อกันผ่าน AI เดียวกัน: Claude Opus 4.7 ที่รู้จัก Codebase ของคุณ, สกัด Design Token ได้อัตโนมัติ, และส่ง Handoff Bundle ที่ Claude Code อ่านได้โดยตรง วงจรปิด Explore → Prototype → Production Code ทำงานได้ภายใน Ecosystem เดียวของ Anthropic

สำหรับทีมเล็กหรือ Solo Founder นี่คือการเปลี่ยนแปลงระดับ Paradigm: ไม่ต้องจ้างทีม Design แยก, ไม่ต้องนำเข้า Figma File ด้วยมือ, และไม่ต้อง Refactor Style ทุกครั้งที่ Brand เปลี่ยน

---

## Deep Dive

### Claude Design: สกัด Design System อัตโนมัติ

Claude Design ทำงานเหมือน Visual Canvas ที่ Claude เป็นผู้สร้างและแก้ไขแบบ Real-time คุณสามารถ:

- **อัปโหลด Codebase หรือ Figma File** → Claude สแกนและสกัด Color Palette, Typography Scale, Spacing Tokens, และ Reusable Components ออกมาเป็น Design System อัตโนมัติ
- **Web Capture Tool**: จับ Element จากเว็บไซต์ที่มีอยู่แล้วมาใช้เป็นฐาน ทำให้ Prototype สะท้อน Product จริง ไม่ใช่ Generic Template
- **Fine-grained Controls**: Comment Inline บน Element เฉพาะจุด, แก้ Text โดยตรง, หรือใช้ Adjustment Knobs ปรับ Spacing/Color/Layout แบบ Live แล้วสั่งให้ Claude Apply การเปลี่ยนแปลงทั่วทั้ง Design

เมื่อ Prototype พร้อม Claude Design จะ Package ทุกอย่างเป็น **Handoff Bundle** ซึ่งส่งต่อไป Claude Code ได้ด้วยคำสั่งเดียว Bridge นี้คือ Key Differentiator เทียบกับ Tool อื่นๆ

### CLAUDE.md + .claude Folder: กำหนด Brand Voice และมาตรฐานโค้ด

Claude Code อ่าน `.claude` Folder เมื่อเริ่ม Session โครงสร้างที่ดีช่วยให้ทุก Component ที่ Claude สร้างตรงกับมาตรฐาน Brand ทันที:

```
project/
├── .claude/
│   ├── CLAUDE.md           # กฎหลัก: Tech stack, Brand voice, Code conventions
│   ├── rules/
│   │   ├── brand-voice.md  # @ import เข้า CLAUDE.md ได้
│   │   └── design-tokens.md
│   ├── skills/
│   │   ├── component-gen/  # Workflow สร้าง Component ตาม Design System
│   │   └── vercel-deploy/  # Hook สำหรับ Auto-deploy
│   └── agents/
│       └── perf-optimizer/ # Subagent ตรวจ Bundle Size + Core Web Vitals
├── src/
└── package.json
```

ตัวอย่าง CLAUDE.md ที่ควร include สำหรับ Web Project:

```markdown
# Brand Voice
@rules/brand-voice.md

# Tech Stack
- Next.js 16 (App Router + Turbopack)
- Tailwind CSS v4
- TypeScript strict mode

# Design Tokens (from Design System)
- Primary: #3b82f6  Secondary: #1e293b
- Font: Inter (heading), system-ui (body)
- Radius: 12px  Shadow: 0 4px 12px rgba(15,23,42,.08)

# Code Conventions
- Server Components by default; Client Components only when needed (useState, useEffect, browser API)
- Tailwind utility classes only — no inline styles, no CSS Modules
- File naming: kebab-case components (hero-section.tsx, not HeroSection.tsx)
```

Claude จะ Enforce กฎเหล่านี้ทุก Component ที่ Generate — ไม่ต้อง Review ซ้ำในทุก PR

### Next.js 16 + Tailwind CSS v4: Scaffold ด้วย Claude Code

เมื่อได้รับ Handoff Bundle จาก Claude Design แล้ว Claude Code สามารถ Scaffold โครงสร้างทั้งหมดได้:

```bash
# คำสั่งเริ่ม Project ใหม่
npx create-next-app@latest my-site --typescript --tailwind --app

# Claude Code จะ Generate:
# - Root Layout (app/layout.tsx) พร้อม Design Token CSS Variables
# - Page components ตาม Prototype
# - Reusable components ใน components/
# - API Routes ใน app/api/ (ถ้ามี)
```

**Key Patterns สำหรับ Next.js App Router:**

```tsx
// app/layout.tsx — Design Tokens เป็น CSS Custom Properties
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="th">
      <body className="font-sans bg-slate-950 text-slate-100">
        {children}
      </body>
    </html>
  )
}

// components/hero-section.tsx — Server Component (ไม่มี 'use client')
export function HeroSection() {
  return (
    <section className="min-h-screen flex flex-col items-center justify-center px-8">
      <h1 className="text-5xl font-bold text-white mb-6">...</h1>
      <SplineScene />  {/* Lazy-loaded Client Component */}
    </section>
  )
}
```

Claude Code จัดการ Pain Point ของ Next.js ได้ดี: Hydration Errors, Server/Client Component Boundary, และ Dynamic Import สำหรับ Heavy Libraries อย่าง Spline

### Spline 3D: เพิ่มมิติด้วย WebGPU

[Spline](https://spline.design/) เป็น Browser-based 3D Design Tool ที่ Export ออกมาเป็น React Component ได้โดยตรง เครื่องยนต์ 2026 ใช้ **WebGPU** (ทดแทน WebGL) เร็วขึ้น 3x และรองรับ Mobile Browser ได้ดีขึ้น

**การ Embed ใน Next.js:**

```bash
npm install @splinetool/react-spline @splinetool/runtime
```

```tsx
// components/spline-scene.tsx
'use client'
import dynamic from 'next/dynamic'

// Lazy-load ป้องกัน Bundle Size ใน Initial Load
const Spline = dynamic(() => import('@splinetool/react-spline'), {
  ssr: false,
  loading: () => <div className="animate-pulse bg-slate-800 rounded-xl h-[400px]" />
})

export function SplineScene() {
  return (
    <Spline
      scene="https://prod.spline.design/your-scene-id/scene.splinecode"
      className="w-full h-[400px]"
    />
  )
}
```

สำหรับ SSR ที่ดีขึ้น ใช้ `@splinetool/react/next` ซึ่ง Auto-generate Blurred Placeholder บน Server ขณะ Scene กำลัง Load

**Use Cases ที่เหมาะ:**
- Hero Section แบบ Interactive (ผู้ใช้ Hover/Click ได้)
- Product Showcase 3D
- Background Animation ที่ Response ต่อ Mouse Movement

### Higgsfield AI: AI Video สำหรับ Web

[Higgsfield](https://higgsfield.ai/) เป็น Infrastructure สำหรับ AI Video Generation ระดับ Cinematic ที่ Web Developer นำมาใช้แทน Stock Video หรือ Hero Animation ที่ต้องจ้าง Production House

**การ Integrate กับ Next.js:**

```tsx
// components/hero-video.tsx
'use client'
export function HeroVideo({ src }: { src: string }) {
  return (
    <video
      autoPlay muted loop playsInline
      className="absolute inset-0 w-full h-full object-cover opacity-30"
    >
      <source src={src} type="video/mp4" />
    </video>
  )
}
```

Video ที่ Generate จาก Higgsfield เหมาะกับ Role เป็น Background Layer (opacity ต่ำ) เพื่อไม่แข่งกับ Content หลัก

### GitHub + Vercel: Deploy อัตโนมัติ

Claude Code มี Hook สำหรับ Vercel ผ่าน `.claude/skills/vercel-deploy/`:

```bash
# push → Vercel Auto-build ทันที
git push origin main

# หรือใช้ Vercel CLI สำหรับ Preview Deployment
npx vercel --prod
```

**Performance Budget Guard** ใน `.claude/settings.json` ป้องกัน Deploy ที่ Bundle Size เกิน Threshold:

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "node .claude/hooks/check-bundle-size.js"
      }]
    }]
  }
}
```

Vercel Infer ว่า Route ไหนเป็น Static, Dynamic, หรือ Cached จาก Build Output อัตโนมัติ — ไม่ต้องกำหนดเอง

---

## User Guide (Step-by-Step)

### ขั้นตอนที่ 1: สกัด Design System ด้วย Claude Design

1. เปิด [claude.ai](https://claude.ai) → เลือก **Claude Design** (ต้องการ Claude Pro/Max/Team/Enterprise)
2. อัปโหลด Figma File, Screenshot ของเว็บต้นแบบ, หรือชี้ไปที่ URL ของเว็บที่มีอยู่
3. พิมพ์: `"สกัด Design System จากต้นแบบนี้ — ต้องการ Color Palette, Typography Scale, Spacing, และ Component Library"`
4. Claude จะ Generate Design System พร้อม Preview → แก้ไขผ่าน Adjustment Knobs หรือ Inline Comment
5. เมื่อพอใจแล้ว: คลิก **"Hand off to Claude Code"** → จะได้ Handoff Bundle (ZIP + Markdown)

**ผลลัพธ์ที่คาดหวัง:** ไฟล์ `design-system.md` ที่มี CSS Custom Properties พร้อม Tailwind Config

### ขั้นตอนที่ 2: ตั้งค่า Project ด้วย Claude Code

```bash
# 1. สร้าง Next.js Project
npx create-next-app@latest my-site --typescript --tailwind --app --src-dir

# 2. สร้างโครงสร้าง .claude
mkdir -p .claude/{rules,skills,agents}

# 3. เปิด Claude Code แล้วส่ง Handoff Bundle
claude  # เปิด Interactive Session
# พิมพ์: "นำ Handoff Bundle ใน ./handoff/ มาสร้าง Layout และ Component หลัก"
```

**ผลลัพธ์ที่คาดหวัง:** Claude สร้าง `app/layout.tsx`, `tailwind.config.ts`, และ Component ใน `src/components/` ตาม Design System

### ขั้นตอนที่ 3: เพิ่ม Spline 3D Scene

```bash
npm install @splinetool/react-spline @splinetool/runtime
```

1. ออกแบบ Scene ใน [spline.design](https://spline.design/) (ฟรีสำหรับ Public Projects)
2. Export → **"For Web"** → Copy Scene URL
3. วาง URL ใน Component ตามตัวอย่างด้านบน

### ขั้นตอนที่ 4: Generate Hero Video ด้วย Higgsfield

1. เปิด [higgsfield.ai](https://higgsfield.ai/) → เลือก **Marketing Studio** หรือ **Cinematic**
2. ป้อน Prompt: `"Futuristic tech startup hero video, dark background, blue accent lighting, 10 seconds loop"`
3. Download MP4 → วางไว้ใน `public/videos/hero.mp4`
4. ใช้ Component `<HeroVideo src="/videos/hero.mp4" />` ตามตัวอย่างด้านบน

### ขั้นตอนที่ 5: Deploy ผ่าน Vercel

```bash
# ติดตั้ง Vercel CLI
npm i -g vercel

# Link กับ Vercel Project
vercel link

# Deploy Production
git add . && git commit -m "feat: initial site" && git push
# Vercel Auto-deploy ทุกครั้งที่ Push ไป main
```

**ผลลัพธ์ที่คาดหวัง:** URL ที่ Live ภายใน 2-3 นาที รูปแบบ `https://my-site.vercel.app`

---

## Caveats / Limits

- **Claude Design ยังเป็น Research Preview** (ณ พ.ค. 2026) — ต้องการ Claude Pro/Max/Team/Enterprise; ยังไม่รองรับ Free Plan
- **Spline Scene Size**: Scene ที่ซับซ้อนมีขนาด `.splinecode` หลาย MB — ใช้ `loading` Prop และ Lazy Loading ป้องกัน LCP เสีย
- **Higgsfield Video ขนาดใหญ่**: MP4 สำหรับ Background Video ควรอยู่ที่ < 5 MB — ใช้ Tool อย่าง `ffmpeg` Compress ก่อน Deploy: `ffmpeg -i input.mp4 -crf 28 -preset fast output.mp4`
- **Tailwind v4 Breaking Changes**: Tailwind CSS v4 เปลี่ยน Config Format (ไม่ใช่ `tailwind.config.js` แบบเดิม) — ดู [Migration Guide](https://tailwindcss.com/docs/v4-upgrade) ก่อน Upgrade
- **Vercel Free Tier Limits**: Bandwidth 100 GB/เดือน, Serverless Function Duration 10 วินาที — เพียงพอสำหรับ Static/Marketing Site แต่ต้องอัปเกรดถ้ามี Heavy API
- **WebGPU Browser Support**: Spline Engine 2026 ใช้ WebGPU ซึ่ง Safari 17+ รองรับแล้ว แต่ยังมี Edge Case บน iOS Safari เก่า — ทดสอบ Cross-browser ก่อน Production

---

## References

1. [Introducing Claude Design by Anthropic Labs](https://www.anthropic.com/news/claude-design-anthropic-labs) — Official announcement (April 17, 2026)
2. [Set up your design system in Claude Design](https://support.claude.com/en/articles/14604397-set-up-your-design-system-in-claude-design) — Claude Help Center
3. [What Is Claude Design? Anthropic's AI Design Tool Explained](https://www.datacamp.com/blog/claude-design) — DataCamp Deep Dive
4. [Next.js + Vercel + Claude Code Integration: Complete Guide](https://aitmpl.com/blog/nextjs-vercel-claude-code-integration/) — Hooks, Agents, Commands
5. [I built a production-ready Next.js app using Claude Code](https://dev.to/julykk/i-built-a-production-ready-nextjs-app-using-claude-code-heres-what-i-learned-3e0c) — DEV Community
6. [Anatomy of the .claude Folder](https://codewithmukesh.com/blog/anatomy-of-the-claude-folder/) — Every file explained
7. [react-spline: React component for Spline scenes](https://github.com/splinetool/react-spline) — GitHub
8. [Higgsfield AI: Infrastructure for AI Video & Image Gen](https://higgsfield.ai/) — Official site
9. [Spline Documentation: Code API for Web](https://docs.spline.design/exporting-your-scene/web/code-api-for-web) — Embed guide
10. [How to Deploy a Website Built with Claude Design to Vercel](https://www.mindstudio.ai/blog/deploy-claude-design-website-to-vercel) — MindStudio Guide
11. [YouTube: สร้างเว็บไซต์ด้วย Claude Code Workflow](https://youtu.be/2Gda_ZvV1V4) — Reference video

---

## Key Takeaways

- **Claude Design สกัด Design System อัตโนมัติ** จาก Codebase หรือ Figma File → ทุก Project ใหม่ได้ Brand Token ทันที ไม่ต้อง Setup ซ้ำ
- **Handoff Bundle** คือ Bridge ที่ทำให้ Claude Design → Claude Code → Production Code ไม่มี Gap — ลด Interpretation Error ระหว่างดีไซเนอร์กับนักพัฒนา
- **CLAUDE.md + .claude/rules/** คือ Brain ของ Project — ใส่ Brand Voice, Design Tokens, Code Convention ไว้ที่เดียว Claude enforce ทุก Component ที่ Generate
- **Spline 3D + WebGPU** เปิดให้ใส่ Interactive 3D ใน Next.js ได้โดยไม่ต้องเขียน Three.js เอง — เหมาะกับ Hero Section และ Product Showcase
- **Higgsfield** แก้ปัญหาขาด Cinematic Video สำหรับ Background Layer — Generate จาก Text Prompt และใส่เป็น `<video autoPlay muted loop>` ได้เลย
- **Vercel Auto-deploy + Performance Guard** ปิด Loop ตั้งแต่ Code → Deploy → Monitor — Push ไป `main` แล้วเว็บ Live ภายใน 2-3 นาที
- Workflow นี้เหมาะมากสำหรับ **Solo Founder** หรือ **ทีมเล็ก** ที่ต้องการ Output คุณภาพสูงโดยไม่มี Full Design Team
