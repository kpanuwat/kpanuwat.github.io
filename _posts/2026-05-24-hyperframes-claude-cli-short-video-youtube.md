---
title: "Hyperframes + Claude CLI: สร้าง Short Video และ Auto Upload YouTube แบบ Step-by-Step"
date: 2026-05-23 00:11:00 +0700
categories: [Tools]
tags: [hyperframes, claude-code, video, youtube, automation, elevenlabs, ffmpeg, ai]
slides: true
---

{% include slide-link.html %}

## TL;DR

HyperFrames คือ open-source framework จาก HeyGen ที่ให้ Claude เขียน HTML แล้วแปลงเป็น MP4 อัตโนมัติ — รวมกับ ElevenLabs สำหรับ voiceover และ YouTube Data API v3 สำหรับ auto-upload ทำให้ทำ short video pipeline ตั้งแต่ prompt จนถึง YouTube ได้ใน 10-15 นาที โดยไม่ต้องแตะ video editor เลย

## Background / Why this matters

การทำ short-form video ยังต้องการ video editor, screen recording, manual upload ซึ่งกินเวลา 1-3 ชั่วโมงต่อคลิป แม้จะมี AI generative tools ก็ยังต้องสลับ context ระหว่าง tools หลายตัว

**ทำไม HyperFrames ถึงเปลี่ยนเกม**: แทนที่จะให้ AI generate pixels (ช้า, ไม่ deterministic) HyperFrames ให้ Claude **เขียน HTML** ซึ่งเป็นสิ่งที่ LLM ทำได้ดีมาก แล้วจึง render HTML frame-by-frame ผ่าน Puppeteer + FFmpeg ให้ได้ MP4 ที่ทำซ้ำได้ 100% จาก input เดิม

**Claude CLI (Claude Code)** ทำหน้าที่เป็น orchestrator: เรียก ElevenLabs API, สั่ง HyperFrames render, รัน FFmpeg merge, แล้วสั่ง YouTube upload ทั้งหมดจาก natural language prompt ตัวเดียว

ผลลัพธ์: pipeline ที่ cost ต่ำกว่า $0.10/คลิป และ reproducible ทุกครั้ง

## Deep Dive

### HyperFrames Architecture

HyperFrames แบ่งเป็น 4 packages:

| Package | บทบาท |
|---|---|
| `@hyperframes/core` | Parsing + runtime — อ่าน HTML data attributes |
| `@hyperframes/engine` | Capture engine: Puppeteer screenshot → frame sequence |
| `@hyperframes/producer` | FFmpeg pipeline: frames → MP4 |
| `@hyperframes/studio` | Browser editor สำหรับ preview |

Composition คือ HTML ธรรมดาที่ใช้ `data-*` attributes กำหนด timing:

```html
<div id="stage" data-composition-id="my-short"
     data-width="1080" data-height="1920">
  <video id="clip-1" data-start="0" data-duration="5"
         data-track-index="0" src="visual_1.mp4" />
  <audio id="vo-1"  data-start="0" data-duration="5"
         data-track-index="1" data-volume="1.0" src="audio_1.mp3" />
</div>
```

ไม่มี proprietary syntax, ไม่มี rendering credits, ไม่มี seat limits (Apache 2.0)

### Full Pipeline: 4 ขั้นตอน

```
Claude prompt
     │
     ▼
① Script JSON ← Claude generates narration + visual_description per segment
     │
     ▼
② Audio MP3  ← ElevenLabs TTS per segment
     │
③ Visual MP4 ← HyperFrames renders HTML → frame capture → MP4
     │
     ▼
④ Merge + Upload ← FFmpeg concat → YouTube Data API v3
```

**เวลาโดยประมาณสำหรับ 60-second video:**
- Script generation: 30–60 วินาที
- Audio synthesis: 1–2 นาที
- Visual generation: 3–8 นาที (ขั้นตอนที่ช้าที่สุด)
- FFmpeg merge: < 1 นาที
- YouTube upload: 1–2 นาที

**รวม: 6–14 นาที**

### Claude CLI Skills Pattern

Claude Code ใช้ "skills" (`.claude/skills/`) เป็น slash commands ที่ expand เป็น full prompt เช่น `/generate-short` → Claude อ่าน skill file แล้วรัน pipeline ทั้งหมด ทำให้สั่งงานด้วย prompt ภาษาธรรมดาได้:

```
/generate-short topic="วิธีใช้ Claude Code ในชีวิตประจำวัน"
```

## User Guide (Step-by-Step)

### ขั้นตอนที่ 1: ติดตั้ง Prerequisites

```bash
# ตรวจสอบ Node.js >= 22
node --version

# ติดตั้ง FFmpeg (macOS)
brew install ffmpeg

# ติดตั้ง FFmpeg (Ubuntu/Debian)
sudo apt install ffmpeg

# ติดตั้ง Claude Code
npm install -g @anthropic-ai/claude-code

# เพิ่ม HyperFrames skill เข้า project
npx skills add heygen-com/hyperframes
```

หรือ init project ใหม่เลย:

```bash
npx hyperframes init my-shorts
cd my-shorts
npx hyperframes doctor   # ตรวจสอบ environment
```

### ขั้นตอนที่ 2: ตั้งค่า API Keys

สร้างไฟล์ `.env` ใน project root:

```bash
ELEVENLABS_API_KEY=your_elevenlabs_key_here
HYPERFRAMES_API_KEY=your_hyperframes_key_here
```

**ได้ keys จากที่ไหน:**
- ElevenLabs: [elevenlabs.io](https://elevenlabs.io) → Profile → API Key
- HyperFrames: [hyperframes.ai](https://hyperframes.ai) → Dashboard → API Key
- YouTube: Google Cloud Console → APIs & Services → YouTube Data API v3 → OAuth2 Client ID → ดาวน์โหลด `client_secrets.json`

### ขั้นตอนที่ 3: สร้าง Script ด้วย Claude

บอก Claude ใน terminal:

```
Write a 60-second YouTube Shorts script about "วิธีใช้ Claude Code เพื่อเพิ่ม productivity".
Structure as JSON with fields: id, narration_text, duration_seconds, visual_description, visual_style.
Save to script.json
```

ตัวอย่าง output (`script.json`):

```json
[
  {
    "id": 1,
    "narration_text": "Claude Code คืออะไร และทำไมมันถึงเปลี่ยนวิธีเขียนโค้ดของคุณ",
    "duration_seconds": 10,
    "visual_description": "Animated terminal with glowing text, dark theme",
    "visual_style": "professional"
  },
  {
    "id": 2,
    "narration_text": "แค่พิมพ์ภาษาธรรมดา Claude จะเขียนโค้ด รันเอง และแก้บั๊กเอง",
    "duration_seconds": 12,
    "visual_description": "Split screen: chat prompt on left, code output on right",
    "visual_style": "instructional"
  }
]
```

### ขั้นตอนที่ 4: สร้าง Audio ด้วย ElevenLabs

บอก Claude ให้รัน script นี้:

```python
import json, os, requests

API_KEY = os.getenv("ELEVENLABS_API_KEY")
VOICE_ID = "21m00Tcm4TlvDq8ikWAM"   # Rachel voice — ดูรายการที่ elevenlabs.io/voices

with open("script.json") as f:
    segments = json.load(f)

for seg in segments:
    r = requests.post(
        f"https://api.elevenlabs.io/v1/text-to-speech/{VOICE_ID}",
        headers={"xi-api-key": API_KEY, "Content-Type": "application/json"},
        json={
            "text": seg["narration_text"],
            "model_id": "eleven_monolingual_v1",
            "voice_settings": {"stability": 0.5, "similarity_boost": 0.75}
        }
    )
    with open(f"audio_{seg['id']}.mp3", "wb") as out:
        out.write(r.content)
    print(f"✓ audio_{seg['id']}.mp3")
```

Output: `audio_1.mp3`, `audio_2.mp3`, ...

### ขั้นตอนที่ 5: Render Visuals ด้วย HyperFrames

HyperFrames รับ API call หรือใช้ HTML composition โดยตรง:

**วิธี A — API (ง่ายกว่า):**

```python
import json, os, requests

API_KEY = os.getenv("HYPERFRAMES_API_KEY")

with open("script.json") as f:
    segments = json.load(f)

for seg in segments:
    r = requests.post(
        "https://api.hyperframes.ai/v1/generate",
        headers={"Authorization": f"Bearer {API_KEY}"},
        json={
            "prompt": f"{seg['visual_description']}. Style: {seg['visual_style']}",
            "duration": seg["duration_seconds"],
            "format": "mp4",
            "resolution": "1080x1920"   # Shorts = vertical 9:16
        }
    )
    clip_url = r.json()["clip_url"]
    with open(f"visual_{seg['id']}.mp4", "wb") as out:
        out.write(requests.get(clip_url).content)
    print(f"✓ visual_{seg['id']}.mp4")
```

**วิธี B — HTML Composition (control มากกว่า):**

สร้าง `compositions/scene_1.html` แล้วรัน:

```bash
npx hyperframes preview   # live preview ใน browser
npx hyperframes render    # export เป็น MP4
npx hyperframes lint      # validate composition ก่อน render
```

### ขั้นตอนที่ 6: Merge ด้วย FFmpeg

```python
import subprocess, json

with open("script.json") as f:
    segments = json.load(f)

merged = []
for seg in segments:
    sid = seg["id"]
    out = f"merged_{sid}.mp4"
    subprocess.run([
        "ffmpeg", "-y",
        "-i", f"visual_{sid}.mp4",
        "-i", f"audio_{sid}.mp3",
        "-c:v", "copy", "-c:a", "aac", "-shortest",
        out
    ], check=True)
    merged.append(out)

with open("concat_list.txt", "w") as f:
    for clip in merged:
        f.write(f"file '{clip}'\n")

subprocess.run([
    "ffmpeg", "-y",
    "-f", "concat", "-safe", "0",
    "-i", "concat_list.txt",
    "-c", "copy",
    "final_video.mp4"
], check=True)
print("✓ final_video.mp4")
```

### ขั้นตอนที่ 7: Auto Upload ไป YouTube

ต้องทำ **OAuth2 setup ครั้งแรกครั้งเดียว**:

1. ไปที่ [Google Cloud Console](https://console.cloud.google.com/)
2. สร้าง project ใหม่ → เปิดใช้ **YouTube Data API v3**
3. สร้าง OAuth2 Credentials → Application type: **Desktop App**
4. ดาวน์โหลด `client_secrets.json` → วางใน project root

```python
import os, json
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload

SCOPES = ["https://www.googleapis.com/auth/youtube.upload"]
TOKEN_FILE = "token.json"   # JSON — ไม่ใช้ pickle เพื่อหลีกเลี่ยง deserialization risks

def get_credentials():
    creds = None
    if os.path.exists(TOKEN_FILE):
        creds = Credentials.from_authorized_user_file(TOKEN_FILE, SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file("client_secrets.json", SCOPES)
            creds = flow.run_local_server(port=0)   # เปิด browser ให้ authorize ครั้งแรก
        with open(TOKEN_FILE, "w") as f:
            f.write(creds.to_json())
    return creds

def upload_to_youtube(video_path, title, description, tags=None, privacy="public"):
    youtube = build("youtube", "v3", credentials=get_credentials())
    body = {
        "snippet": {
            "title": title,
            "description": description,
            "tags": tags or [],
            "categoryId": "28"   # Science & Technology
        },
        "status": {"privacyStatus": privacy}
    }
    media = MediaFileUpload(video_path, chunksize=-1, resumable=True)
    request = youtube.videos().insert(
        part="snippet,status",
        body=body,
        media_body=media
    )
    response = request.execute()
    return f"https://youtu.be/{response['id']}"

url = upload_to_youtube(
    video_path="final_video.mp4",
    title="#Shorts วิธีใช้ Claude Code เพื่อเพิ่ม Productivity",
    description="Claude Code คืออะไร? ทำไมต้องใช้? ดูใน 60 วินาที\n\n#ClaudeCode #AI #Productivity",
    tags=["claude", "ai", "coding", "shorts"],
    privacy="public"
)
print(f"✓ Uploaded: {url}")
```

ติดตั้ง dependencies ก่อน:

```bash
pip install google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client
```

### ขั้นตอนที่ 8: ทำให้ Claude รัน Pipeline ทั้งหมดอัตโนมัติ

สร้าง skill file `.claude/skills/generate-short.md`:

```markdown
---
name: generate-short
description: End-to-end short video pipeline: script → audio → visuals → merge → upload
---

Given a topic and optional voice/style preferences:
1. Generate script.json with Claude
2. Run audio_gen.py to create ElevenLabs audio
3. Run visual_gen.py to create HyperFrames visuals
4. Run merge.py to concat with FFmpeg
5. Run upload.py to publish to YouTube
Report the final YouTube URL when done.
```

จากนั้นพิมพ์ใน terminal:

```
/generate-short topic="10 วิธีใช้ AI ในชีวิตประจำวัน" privacy="unlisted"
```

Claude จะรัน 5 ขั้นตอนเองทั้งหมด และ report URL เมื่อเสร็จ

### Project Structure สรุป

```
my-shorts/
├── .env                       # API keys (อย่า commit!)
├── .gitignore                 # ต้องรวม .env, client_secrets.json, token.json
├── .claude/skills/
│   └── generate-short.md      # slash command skill
├── scripts/
│   ├── audio_gen.py
│   ├── visual_gen.py
│   ├── merge.py
│   └── upload.py
├── client_secrets.json        # YouTube OAuth2 (อย่า commit!)
├── token.json                 # cached OAuth2 token (อย่า commit!)
├── script.json                # generated per video
└── output/
    ├── audio_*.mp3
    ├── visual_*.mp4
    ├── merged_*.mp4
    └── final_video.mp4
```

## Caveats / Limits

**HyperFrames:**
- ต้องการ Node.js ≥ 22 — เวอร์ชันเก่ากว่าไม่รองรับ
- Visual generation ผ่าน API อาจช้า 3-8 นาทีต่อ 60 วินาทีของวิดีโอ ขึ้นกับ load
- HTML compositions ที่ซับซ้อน (CSS animations หนัก) อาจทำให้ frame capture ไม่สม่ำเสมอ — ใช้ `npx hyperframes lint` ก่อน render จริง

**ElevenLabs:**
- Free tier: 10,000 characters/เดือน (~15 นาทีของ audio)
- Paid tier เริ่มที่ $5/เดือน สำหรับ 30,000 characters
- Thai language support มีแต่ไม่ใช่ strong point — ทดสอบ voice model ก่อนใช้ production

**YouTube Data API:**
- Quota: 10,000 units/วัน (free) — upload 1 วิดีโอ = ~1,600 units → upload ได้ ~6 คลิป/วัน
- Token refresh อัตโนมัติจาก `token.json` — ไม่ต้อง authorize ซ้ำ
- วิดีโอที่ upload ด้วย API จะถูก review ก่อน monetization เหมือนวิดีโอปกติ
- `#Shorts` ต้องอยู่ใน title หรือ description + vertical 9:16 + ≤ 60 วินาที เพื่อให้เข้า Shorts feed

**Security:**
- อย่า commit `.env`, `client_secrets.json`, `token.json` เข้า git เด็ดขาด
- ใช้ JSON token storage (`Credentials.to_json()`) แทน binary formats เพื่อหลีกเลี่ยง deserialization risks

## References

1. [HyperFrames GitHub — heygen-com/hyperframes](https://github.com/heygen-com/hyperframes)
2. [What Is HyperFrames? The HTML-Based Video Renderer for AI Agents — MindStudio](https://www.mindstudio.ai/blog/what-is-hyperframes-html-video-renderer-ai-agents)
3. [How to Generate AI Videos with Claude Code, HyperFrames, and ElevenLabs: Full Workflow — MindStudio](https://www.mindstudio.ai/blog/generate-ai-videos-claude-code-hyperframes-elevenlabs-workflow)
4. [How to Build an AI Video Editing Workflow with Claude Code and Hyperframes — MindStudio](https://www.mindstudio.ai/blog/ai-video-editing-claude-code-hyperframes)
5. [Upload a Video — YouTube Data API v3 Official Docs](https://developers.google.com/youtube/v3/guides/uploading_a_video)
6. [HeyGen HyperFrames: Open-Source Video Generation Framework — Medium](https://medium.com/data-science-in-your-pocket/heygen-hyperframes-open-source-video-generation-framework-bcb9c447b444)
7. [How I Added AI Video Production to Claude Code in One Afternoon — Medium](https://medium.com/@emergentcap/how-i-added-ai-video-production-to-claude-code-in-one-afternoon-9edcb68853aa)

## Key Takeaways

- **HyperFrames = HTML → MP4**: Claude เขียน HTML ได้ดีอยู่แล้ว — HyperFrames แปลงความสามารถนั้นเป็น video frames โดยตรง ไม่ต้อง generate pixels
- **Pipeline 4 ขั้น**: Script JSON → ElevenLabs audio → HyperFrames visuals → FFmpeg merge — แต่ละขั้นแยกกันและ replaceable ได้
- **Claude CLI เป็น orchestrator**: ใช้ skills (`.claude/skills/`) เพื่อรัน multi-step pipeline จาก prompt เดียว
- **YouTube upload ต้องทำ OAuth2 setup ครั้งเดียว**: หลังจากนั้น `token.json` refresh อัตโนมัติ — ไม่ต้อง authorize ซ้ำ
- **Short video = vertical 9:16 + ≤ 60 วินาที + `#Shorts` ใน title/description**: 3 เงื่อนไขต้องครบเพื่อเข้า Shorts algorithm
- **ต้นทุนต่ำ**: < $0.10/คลิปสำหรับ pipeline ขนาดเล็ก — quota YouTube API อนุญาต ~6 uploads/วัน ใน free tier
- **อย่า commit secrets**: `.env`, `client_secrets.json`, `token.json` ต้องอยู่ใน `.gitignore` เสมอ
