---
title: "สร้าง YouTube Shorts 100 คลิปใน 5 นาที ด้วย Claude Code + Remotion"
date: 2026-05-23 00:10:00 +0700
categories: [Tools]
tags: [claude-code, remotion, youtube-shorts, ai, video-production, viroscope]
slides: true
---

{% include slide-link.html %}

## TL;DR

ใช้ Claude Code สร้าง Remotion React component ครั้งเดียว → ใส่ข้อมูลใน JSON → Batch render ออกมาเป็น 100 MP4 ได้อัตโนมัติ  
แต่ประเด็นจริงคือ: การผลิตเร็วเป็นเรื่องของทุกคนแล้ว สิ่งที่แยก creator ออกจากกันคือ **ไอเดียที่ผ่านการ validate ด้วย data ก่อนผลิต**

---

## Background / Why This Matters

ปี 2025 YouTube Shorts แตะ **200 billion daily views** และ **2 billion monthly active users** — 77% ของ views ทั้ง YouTube มาจากคลิปความยาวไม่เกิน 1 นาที  
ความเป็นจริงข้อนี้ดึงดูด creator จำนวนมาก และเครื่องมือ AI ก็ลดต้นทุนการผลิตลงจนแทบเป็นศูนย์

ปัญหาคือเมื่อทุกคนผลิตได้เร็วเท่ากัน **ปริมาณไม่ใช่ความได้เปรียบอีกต่อไป**

สูตรที่ได้ผลในยุคนี้มีสองชั้น:

1. **Validate ไอเดีย** — ใช้ data คัดกรองหัวข้อที่มีโอกาสไวรัลสูงก่อนผลิต  
2. **Automate การผลิต** — ใช้ Claude Code + Remotion batch render จาก template

เมื่อรวมสองชั้นนี้เข้ากัน คุณผลิต *เฉพาะคลิปที่มีโอกาสสูง* ด้วยความเร็วสูงสุด

---

## Deep Dive

### Remotion คืออะไร

[Remotion](https://www.remotion.dev/) คือ framework ที่ให้เขียน video ด้วย React  
แทนที่จะลาก timeline ใน editor — คุณเขียน React component ที่ render ตาม frame number

```tsx
// แต่ละ frame = React render ที่ useCurrentFrame() คืนค่าต่างกัน
const { fps, durationInFrames } = useVideoConfig();
const frame = useCurrentFrame(); // 0, 1, 2, ...
const progress = frame / durationInFrames; // 0.0 → 1.0
```

ผลลัพธ์คือ MP4 ที่ render ได้ด้วย `npx remotion render` — ไม่ต้องเปิด browser ไม่ต้องกด export

**ทำไมถึงเหมาะกับ batch production?**

เพราะ video คือ React props — เปลี่ยน JSON → ได้ video ใหม่ ไม่ต้องแตะ component

### Claude Code เข้ามาตรงไหน

Claude Code เขียน Remotion component ให้จาก natural language prompt ได้ทันที  
ไม่ต้องรู้ Remotion API ทุก detail — Claude อ่าน Agent Skills ของ Remotion แล้วเขียน code ที่ถูกต้องให้

```
"Create a YouTube Shorts component (1080x1920, 30fps, 30s) 
 showing a Top-5 list with animated entries, spring physics, 
 dark gradient background, and reads data from inputProps"
```

Claude ตอบกลับด้วย React component ที่ใช้งานได้จริง ปรับแต่งผ่าน conversation ต่อได้ทันที

### Batch Render จาก JSON Dataset

Remotion มี [dataset-render pattern](https://www.remotion.dev/docs/dataset-render) โดยตรง:

**1. เตรียม JSON dataset**

```json
[
  {
    "title": "5 เหตุผลที่ Go เร็วกว่า Python",
    "items": ["Compiled", "Goroutines", "Low GC", "Static typing", "No interpreter overhead"]
  },
  {
    "title": "ทำไม TypeScript ถึง Dominate Frontend",
    "items": ["Type safety", "Better IDE support", "Easier refactor", "Self-documenting", "Less runtime errors"]
  }
]
```

**2. Render script (render.mjs)**

```javascript
import { bundle } from "@remotion/bundler";
import { renderMedia, selectComposition } from "@remotion/renderer";
import data from "./topics.json" assert { type: "json" };

const bundleLocation = await bundle({ entryPoint: "./src/index.ts" });

for (const [i, entry] of data.entries()) {
  const composition = await selectComposition({
    serveUrl: bundleLocation,
    id: "YouTubeShort",
    inputProps: entry,
  });

  await renderMedia({
    composition,
    serveUrl: bundleLocation,
    codec: "h264",
    outputLocation: `out/short-${i + 1}.mp4`,
    inputProps: entry,
  });

  console.log(`✓ ${i + 1}/${data.length}: ${entry.title}`);
}
```

**3. Run**

```bash
node render.mjs
# ✓ 1/100: 5 เหตุผลที่ Go เร็วกว่า Python
# ✓ 2/100: ทำไม TypeScript ถึง Dominate Frontend
# ...
```

> **Note**: Remotion แนะนำ render ทีละ 1 video เพราะแต่ละ render ใช้ CPU เต็ม machine แล้ว  
> "100 คลิปใน 5 นาที" คือ aspirational — จริงๆ ขึ้นอยู่กับ spec เครื่อง, ความยาวคลิป, และ resolution

### ViroScope AI — Validate ก่อนผลิต

[ViroScope AI](https://tryviroscopeai.com/) และ [Virascope](https://www.virascope.com/) เป็น tools ที่สแกน YouTube Shorts แบบ real-time แล้วให้ viral score กับแต่ละ idea ก่อนที่คุณจะลงทุน render

**workflow ที่แนะนำ:**

```
1. รวม 100 หัวข้อไอเดียใน spreadsheet
2. ใส่เข้า ViroScope/Virascope → ดู score
3. คัดเอาเฉพาะ top 20-30% score สูง
4. แปลง top ideas เป็น JSON dataset
5. Batch render ด้วย Remotion
```

แทนที่จะ render 100 คลิปแล้วรอดู — คุณ render เฉพาะคลิปที่ data บอกว่ามีโอกาสสูง

---

## User Guide (Step-by-Step)

### Prerequisites

- Node.js 18+
- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- ffmpeg (สำหรับ video processing)

### Step 1: Validate ไอเดียก่อน

ก่อนเขียน code แม้แต่บรรทัดเดียว:

1. เปิด [tryviroscopeai.com](https://tryviroscopeai.com/) หรือ [virascope.com](https://www.virascope.com/)
2. ใส่ไอเดีย 10-20 หัวข้อ
3. เลือกเฉพาะหัวข้อที่ได้ score สูงหรือ trending
4. บันทึกลง `topics.json`

### Step 2: สร้าง Remotion Project

```bash
npx create-video@latest my-shorts-studio
cd my-shorts-studio
# เลือก: Blank template, Enable Tailwind, Add Agent Skills
npm install
```

Agent Skills คือ context files ที่บอก Claude Code ว่า Remotion API ถูกต้องเป็นอย่างไร — ทำให้ generated code ใช้งานได้ทันทีโดยไม่ต้อง debug

### Step 3: สั่ง Claude Code สร้าง Component

เปิด Claude Code ใน project directory:

```bash
claude
```

จากนั้น prompt:

```
Create a YouTube Shorts video component (1080x1920, 30fps, 30 seconds).
The component reads from inputProps: { title: string, items: string[] }.

Requirements:
- Animated title slide (fade + scale in, first 2 seconds)
- Each item appears sequentially with spring animation
- Dark gradient background (#0f0f0f → #1a1a2e)
- Progress bar at bottom
- Clean sans-serif typography, large enough to read on mobile

Export as composition named "YouTubeShort"
```

Claude จะสร้าง `src/YouTubeShort.tsx` และ update `src/Root.tsx` ให้อัตโนมัติ

### Step 4: Preview ใน Remotion Studio

```bash
npm run dev
# เปิด http://localhost:3000
```

ปรับ animation ผ่าน Claude ต่อได้: `"Make the items appear faster, 0.5s per item instead of 1s"`

### Step 5: เตรียม JSON Dataset

```json
[
  { "title": "5 เรื่องที่ไม่มีใครบอกเกี่ยวกับ AI", "items": ["..."] },
  { "title": "วิธีเรียน Coding ใน 30 วัน", "items": ["..."] }
]
```

สร้าง `render.mjs` ตาม script ในส่วน Deep Dive ด้านบน

### Step 6: Batch Render

```bash
node render.mjs
```

Output MP4 จะอยู่ใน `out/` — พร้อม upload YouTube Shorts ได้ทันที

### Step 7: Upload Workflow (optional automation)

ใช้ [YouTube Data API v3](https://developers.google.com/youtube/v3) หรือ tool เช่น `yt-dlp` / `tubeup` เพื่อ automate upload  
(หรือ upload manual ถ้า volume ไม่เยอะ)

---

## Caveats / Limits

**Remotion render speed**  
ไม่ใช่ real-time render — 30s video บน machine ทั่วไปใช้เวลาประมาณ 1-3 นาที ขึ้นอยู่กับ complexity ของ animation  
"100 คลิปใน 5 นาที" ต้องใช้ cloud rendering (AWS Lambda via `@remotion/lambda`) หรือ parallel machines

**@remotion/lambda สำหรับ speed จริง**  
```bash
npx remotion lambda render <entry-point> YouTubeShort out.mp4 --props='{"title":"..."}'
```
ค่าใช้จ่ายประมาณ $0.0003–$0.001 ต่อ video สำหรับคลิป 30 วินาที (ขึ้นอยู่กับ region)

**Claude Code Agent Skills**  
ถ้าไม่ enable Agent Skills ตอน `create-video` Claude อาจใช้ deprecated API  
แก้ได้ด้วยการ run `npx remotion add agent-skills` ทีหลัง

**ViroScope AI / Virascope**  
ทั้งสอง tool ยังอยู่ใน early stage — score ไม่ใช่การรับประกัน แต่เป็น signal เพิ่มเติม  
ใช้เป็นตัวกรอง ไม่ใช่ oracle

**YouTube Shorts limits**  
- ความยาวสูงสุด: 3 นาที (180 วินาที), แต่ 15-60 วินาทีได้ผลดีสุด  
- Format: MP4, H.264, 1080x1920 recommended  
- Upload limit: 100 videos/day ต่อ channel (default quota)

---

## References

1. [Remotion — Make videos programmatically](https://www.remotion.dev/)
2. [Remotion: Render videos from a dataset](https://www.remotion.dev/docs/dataset-render)
3. [Remotion CLI render command](https://www.remotion.dev/docs/cli/render)
4. [I Built a YouTube Shorts Generator with AI (Remotion + Claude Code)](https://ayyaztech.com/blog/youtube-shorts-generator-claude-code-remotion)
5. [Building a Video Automation Pipeline with Remotion and AI APIs](https://dev.to/comlaterra_38/building-a-video-automation-pipeline-with-remotion-and-ai-apis-4i82)
6. [ViroScope AI — Viral YouTube Idea Generator](https://tryviroscopeai.com/)
7. [Virascope — YouTube Shorts Intelligence](https://www.virascope.com/)
8. [YouTube Shorts: 200B daily views, 2B MAU (2025)](https://air.io/en/youtube-hacks/what-do-viral-youtube-shorts-analytics-look-like-real-life-cases)
9. [How to Generate Videos with Remotion and Claude Code](https://32blog.com/en/react/remotion-claude-code-video-generation)
10. [Source video: สร้าง 100 Shorts ด้วย Claude Code + Remotion](https://youtu.be/JXDQglxJczE)

---

## Key Takeaways

- **Video = React props**: เปลี่ยน JSON entry → ได้ MP4 ใหม่ ไม่ต้องแตะ editor
- **Claude Code ลด barrier**: ไม่ต้องรู้ Remotion API ทุก detail — prompt ภาษาธรรมชาติแล้วได้ working component
- **Batch render loop**: `for entry of dataset → renderMedia(entry)` คือ core pattern ทำงานได้จริงตาม Remotion docs
- **Speed จริงต้องใช้ Lambda**: local render ≈ 1-3 min/video; `@remotion/lambda` ทำ parallel render บน AWS → 100 videos เร็วกว่ามาก
- **Validate ก่อน render**: ViroScope / Virascope ให้ viral score ก่อนผลิต — render เฉพาะไอเดียที่ data บอกว่ามีโอกาส
- **ยุคที่ production เป็นเรื่องง่าย**: ความได้เปรียบอยู่ที่ upstream (ไอเดีย + validation) ไม่ใช่ downstream (render speed)
- **YouTube Shorts quota**: 100 uploads/day ต่อ channel — batch render ไว้แล้ว schedule upload ด้วย YouTube API ได้
