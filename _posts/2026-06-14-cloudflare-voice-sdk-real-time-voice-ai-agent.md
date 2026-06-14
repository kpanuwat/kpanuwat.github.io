---
title: "Cloudflare Voice SDK: สร้าง Voice AI Agent แบบ Real-time บน Workers"
date: 2026-06-13 00:01:00 +0700
categories: [Engineering]
tags: [cloudflare, voice-ai, workers, stt, tts, real-time, deepgram, durable-objects, agents-sdk]
---

## TL;DR

`@cloudflare/voice` คือ experimental package ใน Cloudflare Agents SDK ที่เพิ่ม Voice pipeline เข้าไปยัง Agent เดิมได้ทันที ด้วย `withVoice()` wrapper — รองรับ STT + LLM + TTS แบบ real-time บน Durable Objects โดยไม่ต้องใช้ API key ภายนอก ทั้งยังจัดการ interruption, context history, และ streaming audio ในตัว

## Background / Why This Matters

ระบบ Voice AI ในอดีตต้องประกอบชิ้นส่วนจากหลายบริการ — STT จากที่หนึ่ง, LLM จากอีกที่, TTS จากอีกที่ แต่ละ hop เพิ่ม latency และความซับซ้อน Cloudflare วัดว่า latency budget สำหรับ voice ที่ยังรู้สึก "เป็นธรรมชาติ" อยู่ที่ **ต่ำกว่า 800ms** — ซึ่งแตกเป็น 40ms mic input, 300ms STT, 400ms LLM, 150ms TTS

`@cloudflare/voice` แก้ปัญหานี้ด้วยการรัน pipeline ทั้งหมดบน Cloudflare network ผ่าน Workers AI bindings ซึ่งหมายความว่า audio ไม่ต้องออกนอก datacenter เพื่อไปหา STT service อื่น และ Agent ที่ใช้ Durable Objects ก็ยังคงเป็น stateful instance เดียวกัน ไม่ว่า user จะส่ง text หรือพูดเข้ามา

นอกจากนี้ยังเหมาะสำหรับ use case เช่น:
- **Voice assistant** บนเว็บ / mobile app
- **Dictation / Voice search** ที่ต้องการแค่ STT
- **Multimodal agent** ที่รับทั้ง text และ voice บน connection เดียวกัน
- **Scheduled spoken reminders** ผ่าน agent scheduling API

## Deep Dive

### ภาพรวม Package

`@cloudflare/voice` มี 5 ส่วนหลัก:

| Export | Import path | หน้าที่ |
|--------|------------|---------|
| `withVoice` | `@cloudflare/voice` | Full voice agent: STT + LLM + TTS + persistence |
| `withVoiceInput` | `@cloudflare/voice` | STT-only: รับเสียง แปลงเป็น text ไม่ตอบกลับ |
| `useVoiceAgent` | `@cloudflare/voice/react` | React hook สำหรับ `withVoice` agents |
| `useVoiceInput` | `@cloudflare/voice/react` | React hook สำหรับ `withVoiceInput` agents |
| `VoiceClient` | `@cloudflare/voice/client` | Framework-agnostic client |

### Built-in Workers AI Providers (ไม่ต้องใช้ API key)

STT (Speech-to-Text):
- **`WorkersAIFluxSTT`** — ใช้ `@cf/deepgram/flux` โมเดล Deepgram ที่ออกแบบมาสำหรับ voice agents โดยเฉพาะ (conversational speech recognition)
- **`WorkersAINova3STT`** — ใช้ `@cf/deepgram/nova-3` เหมาะกับ general transcription

TTS (Text-to-Speech):
- **`WorkersAITTS`** — ใช้ `@cf/deepgram/aura-1` สำหรับ natural-sounding speech output

LLM: ใช้ Workers AI model ใดก็ได้ผ่าน `workers-ai-provider` — รวมถึง Gemma (`@cf/google/gemma-*`), Llama, หรือโมเดลอื่นๆ ใน Workers AI catalog

### Audio Pipeline: วิธีทำงานทั้งระบบ

```
Browser                              Durable Object (withVoice)
┌──────────┐                         ┌──────────────────────────┐
│ Mic      │   binary PCM (16kHz)    │ Transcriber session      │
│          │ ──────────────────────► │ (per-call, continuous)   │
│          │                         │   ↓ model detects turn   │
│          │   JSON: transcript      │ onTurn() → your LLM code │
│          │ ◄────────────────────── │   ↓ (sentence chunking)  │
│          │   binary: audio         │ TTS                      │
│ Speaker  │ ◄────────────────────── │                          │
└──────────┘                         └──────────────────────────┘
```

ขั้นตอน:
1. Client ส่ง mic audio เป็น binary WebSocket frames (16kHz mono 16-bit PCM)
2. Audio stream ต่อเนื่องเข้า Transcriber session ตลอด call
3. STT model ตรวจจับว่า user พูดจบแล้ว → fire `onTurn()` — ไม่ต้องให้ client ส่ง end-of-speech signal
4. `onTurn()` คืน string, `AsyncIterable<string>`, หรือ `ReadableStream`
5. Response ถูก sentence-chunk → TTS synthesize แต่ละประโยคทันที (Time-to-First-Audio ต่ำ)
6. Audio stream กลับไปยัง client

**Key: Model-driven turn detection** — ไม่ใช้ VAD (Voice Activity Detection) แบบ client-side แต่ให้ STT model เป็นคนตัดสินว่าจบ utterance แล้ว ทำให้ลด false positive

### การจดจำบริบท (Context Persistence)

เพราะ Agent คือ Durable Object ที่มี SQLite ในตัว conversation history จึงรอด:
- **reconnection**: user ตัดต่อแล้ว reconnect ได้ history เดิม
- **deployment**: deploy version ใหม่ไม่ทำให้ session หาย
- **mixed input**: text และ voice อยู่ใน history เดียวกัน

```typescript
async onTurn(transcript: string, context: VoiceTurnContext) {
  const result = streamText({
    model: ai("@cf/cloudflare/gpt-oss-20b"),
    messages: [
      ...context.messages.map((m) => ({  // ← SQLite history
        role: m.role as "user" | "assistant",
        content: m.content
      })),
      { role: "user", content: transcript }
    ],
    abortSignal: context.signal  // ← abort ถ้า user พูดแทรก
  });
  return result.textStream;
}
```

### การรับมือกับ Interruption

เมื่อ user พูดขณะที่ Agent กำลังพูด TTS ถูก cancel อัตโนมัติ และ LLM call ถูก abort ผ่าน `context.signal` — ทำให้ไม่เสีย token โดยเปล่าประโยชน์และ Agent ตอบสนองต่อ input ใหม่ได้ทันที

### `withVoiceInput` — STT เท่านั้น

สำหรับ dictation หรือ voice search ที่ไม่ต้องการ response audio:

```typescript
import { Agent, type Connection } from "agents";
import { withVoiceInput, WorkersAINova3STT } from "@cloudflare/voice";

const InputAgent = withVoiceInput(Agent);

export class DictationAgent extends InputAgent<Env> {
  transcriber = new WorkersAINova3STT(this.env.AI);

  onTranscript(text: string, _connection: Connection) {
    // ทำอะไรกับ text ที่ได้ก็ได้ — บันทึก, search, ส่งต่อ
    console.log("User said:", text);
  }
}
```

### React Hooks

```typescript
// Full voice agent
const { status, transcript, interimTranscript, startCall, endCall, toggleMute }
  = useVoiceAgent({ agent: "MyAgent" });

// STT only
const { transcript, interimTranscript, isListening, start, stop, clear }
  = useVoiceInput({ agent: "DictationAgent" });
```

`interimTranscript` คือ partial result ขณะ user ยังพูดอยู่ — ใช้แสดง live transcription ใน UI ได้

### Tools และ Scheduling บน Voice Agent

Voice agent ยังเป็น Agent ปกติ ดังนั้นใช้ทุก Agents SDK feature ได้:

```typescript
export class MyAgent extends VoiceAgent<Env> {
  transcriber = new WorkersAIFluxSTT(this.env.AI);
  tts = new WorkersAITTS(this.env.AI);

  async onCallStart(connection: Connection) {
    // ทักทาย user เมื่อเริ่ม call
    await this.speak(connection, "สวัสดีครับ มีอะไรให้ช่วยไหม?");
  }

  async onTurn(transcript: string, context: VoiceTurnContext) {
    // เรียก tool ภายนอก เช่น ดูราคาหุ้น, เช็คสภาพอากาศ
    return streamText({ ... });
  }
}
```

## User Guide (Step-by-Step)

### ขั้นตอนที่ 1: ติดตั้ง

```bash
npm install @cloudflare/voice agents
```

### ขั้นตอนที่ 2: ตั้งค่า `wrangler.jsonc`

```jsonc
{
  "ai": { "binding": "AI" },
  "durable_objects": {
    "bindings": [{ "name": "MyAgent", "class_name": "MyAgent" }]
  },
  "migrations": [
    { "tag": "v1", "new_sqlite_classes": ["MyAgent"] }
  ]
}
```

ต้องมี `ai` binding เพราะ Workers AI providers ใช้ `this.env.AI` และต้องเปิด SQLite migrations สำหรับ Durable Object

### ขั้นตอนที่ 3: สร้าง Voice Agent (Server)

```typescript
import { Agent, routeAgentRequest } from "agents";
import { withVoice, WorkersAIFluxSTT, WorkersAITTS, type VoiceTurnContext }
  from "@cloudflare/voice";
import { streamText } from "ai";
import { createWorkersAI } from "workers-ai-provider";

const VoiceAgent = withVoice(Agent);

export class MyAgent extends VoiceAgent<Env> {
  transcriber = new WorkersAIFluxSTT(this.env.AI);
  tts = new WorkersAITTS(this.env.AI);

  async onTurn(transcript: string, context: VoiceTurnContext) {
    const ai = createWorkersAI({ binding: this.env.AI });
    const result = streamText({
      model: ai("@cf/cloudflare/gpt-oss-20b"),
      system: "You are a helpful voice assistant. Be concise.",
      messages: [
        ...context.messages.map((m) => ({
          role: m.role as "user" | "assistant",
          content: m.content
        })),
        { role: "user", content: transcript }
      ],
      abortSignal: context.signal
    });
    return result.textStream;
  }
}

export default {
  async fetch(request: Request, env: Env) {
    return (await routeAgentRequest(request, env))
      ?? new Response("Not found", { status: 404 });
  }
} satisfies ExportedHandler<Env>;
```

### ขั้นตอนที่ 4: เชื่อม UI ด้วย React Hook

```typescript
import { useVoiceAgent } from "@cloudflare/voice/react";

function VoiceUI() {
  const { status, transcript, interimTranscript, startCall, endCall, toggleMute }
    = useVoiceAgent({ agent: "MyAgent" });

  return (
    <div>
      <p>Status: {status}</p>
      <button onClick={status === "idle" ? startCall : endCall}>
        {status === "idle" ? "Start Call" : "End Call"}
      </button>
      <button onClick={toggleMute}>Mute / Unmute</button>
      {interimTranscript && <p><em>{interimTranscript}</em></p>}
      {transcript.map((msg, i) => (
        <p key={i}><strong>{msg.role}:</strong> {msg.text}</p>
      ))}
    </div>
  );
}
```

### ขั้นตอนที่ 5: Deploy

```bash
wrangler deploy
```

Agent พร้อมรับ voice input ทันที ไม่ต้องสมัคร external API key ใดๆ

## Caveats / Limits

- **Experimental**: `@cloudflare/voice` เป็น experimental package — API อาจเปลี่ยนโดยไม่แจ้งล่วงหน้า ยังไม่เหมาะกับ production-critical systems
- **Browser support**: ต้องการ WebSocket + Web Audio API — รองรับ modern browsers แต่ควรทดสอบ mobile browsers ด้วย
- **Workers AI quotas**: Deepgram Flux/Nova/Aura และ LLM models มี rate limits ตาม Cloudflare plan — ตรวจสอบ quota ก่อน scale
- **Gemma / LLM model**: Voice SDK ไม่ได้ bundle LLM model มาเอง ต้องเลือกเองผ่าน `workers-ai-provider` — Gemma, Llama, หรือโมเดลอื่นๆ ใน Workers AI catalog ใช้ได้ทั้งหมด แต่ response speed ต่างกัน
- **SQLite per Durable Object**: history stored ต่อ agent instance — ถ้า route users ไปยัง agent instance ต่างกัน history จะไม่ sync กัน
- **ยังไม่รองรับ telephony**: ขณะนี้รองรับ WebSocket transport เท่านั้น ยังไม่รองรับ SIP/PSTN natively

## References

1. [Add voice to your agent — Cloudflare Blog (2026-04-15)](https://blog.cloudflare.com/voice-agents/)
2. [Voice API Reference — Cloudflare Agents Docs](https://developers.cloudflare.com/agents/api-reference/voice/)
3. [Cloudflare is the best place to build realtime voice agents — Blog (2025-08-29)](https://blog.cloudflare.com/cloudflare-realtime-voice-ai/)
4. [Deepgram Flux model on Workers AI](https://developers.cloudflare.com/workers-ai/models/flux/)
5. [Deepgram Nova 3 on Workers AI](https://developers.cloudflare.com/workers-ai/models/nova-3/)
6. [Deepgram Aura TTS on Workers AI](https://developers.cloudflare.com/workers-ai/models/aura-1/)
7. [Cloudflare Agents SDK — GitHub](https://github.com/cloudflare/agents)
8. [Source video: Cloudflare Voice SDK Demo — YouTube](https://youtu.be/j0smTqG-zzA)

## Key Takeaways

- `withVoice(Agent)` เพิ่ม voice pipeline เข้า Agent เดิมได้ทันทีโดยไม่ต้องเขียนใหม่ — Voice เป็นแค่ input mode อีกแบบหนึ่ง
- Pipeline ทั้งหมด (STT → LLM → TTS) รันใน Cloudflare network — ลด latency และไม่ต้องใช้ API key ภายนอก
- **Model-driven turn detection** ใน Deepgram Flux ตรวจจับจุดจบของ utterance เองโดยไม่ต้องการ VAD แบบ client-side
- `context.signal` abort LLM ทันทีเมื่อ user พูดแทรก — ไม่เสีย compute โดยเปล่าประโยชน์
- Conversation history เก็บใน SQLite ของ Durable Object — รอด reconnection + deployment
- `withVoiceInput` สำหรับ STT-only use cases เช่น dictation หรือ voice search ที่ไม่ต้องการ audio response
- `useVoiceAgent` / `useVoiceInput` React hooks + `VoiceClient` ให้ UI integration สมบูรณ์แบบ
