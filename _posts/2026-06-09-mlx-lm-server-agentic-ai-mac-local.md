---
title: "เจาะลึก MLX + MLX-LM Server: รัน Agentic AI บน Mac แบบ Local 100%"
date: 2026-06-08 00:02:00 +0700
categories: [Engineering]
tags: [mlx, apple-silicon, local-ai, agentic-ai, llm, macos]
slides: true
---

{% include slide-link.html %}

## TL;DR

MLX + MLX-LM Server คือ stack open-source จาก Apple ที่เปลี่ยน Mac เป็น private AI inference node — ไม่มี API key, ข้อมูลไม่ออกจากเครื่อง, ไม่มี usage cost ชิป M5 เพิ่มความเร็ว matrix multiplication **4 เท่า** เทียบ M4, Continuous Batching รองรับ subagents หลายตัวพร้อมกัน, และ Distributed Inference ผ่าน Thunderbolt ให้รัน DeepSeek 1.6 ล้านล้าน parameters บน Mac cluster ได้จริง

## Background / Why this matters

AI agent ต่างจาก chat ทั่วไปตรงที่มัน **วนลูป** — model → tool call → observe result → model อีกรอบ จนกว่างานจะเสร็จ หนึ่ง agentic session อาจมีหลักแสน token และ tool calls นับร้อยครั้ง ถ้าใช้ cloud API ค่าใช้จ่ายพุ่งเร็ว latency สูง และ code ที่เป็น proprietary ต้องส่งออกนอกเครื่อง

Apple Silicon มีข้อได้เปรียบเชิงสถาปัตยกรรมที่สำคัญ: **unified memory** — CPU, GPU, Neural Engine แชร์ RAM pool เดียวกัน ทำให้โมเดลขนาดใหญ่โหลดได้ทั้งก้อนโดยไม่ต้องย้ายข้าม PCIe bus เหมือน discrete GPU บน PC

MLX คือ array framework ที่ Apple สร้างเพื่อ Silicon โดยเฉพาะ — ทำงานบน Metal, lazy evaluation, auto-select kernel ตาม hardware ส่วน MLX-LM Server แปลง local model ให้กลายเป็น OpenAI-compatible endpoint ที่ agent framework ทุกตัวใช้ได้ทันทีโดยแค่เปลี่ยน `base_url`

## Deep Dive

### 4-Layer Local AI Stack

Stack ที่ขับเคลื่อน local agentic AI บน Mac มี 4 ชั้น ซ้อนกันตั้งแต่ hardware ถึง agent:

| Layer | Component | หน้าที่ |
|-------|-----------|---------|
| Foundation | **MLX** | Array framework, Metal acceleration, memory management |
| Language Model | **MLX-LM** | Load / run / quantize / fine-tune LLMs + CLI + Python API |
| Server | **MLX-LM Server** | OpenAI-compatible HTTP server, structured tool calling, reasoning models |
| Agent | **OpenCode / Xcode / custom** | ทุก framework ที่พูด OpenAI chat completions protocol |

เครื่องมือยอดนิยมที่ build บน stack นี้ ได้แก่ Ollama, LM Studio, vLLM — ถ้าใช้อยู่แล้ว มักรันบน MLX โดยไม่รู้ตัว

### Quick Setup — 3 Steps

```bash
# Step 1: ติดตั้ง MLX-LM (pip หรือ conda)
pip install mlx-lm

# Step 2: เปิด server พร้อม model ที่ support tool calling
mlx_lm.server --model mlx-community/Qwen2.5-7B-Instruct-4bit --port 8080

# Step 3: ชี้ agent ไปที่ server
# ใน OpenCode (~/.opencode/config.json):
# { "providers": { "local": { "base_url": "http://localhost:8080/v1" } } }
```

Server รับ requests ที่ `http://localhost:8080/v1/chat/completions` เหมือน OpenAI API ทุกประการ — agent ไม่รู้ว่า model รันอยู่บน Mac ไม่ใช่ cloud

### M5 Neural Accelerators: 4× Faster Prompt Processing

**ปัญหา:** ทุกครั้งที่ model ได้รับ tool output ต้องประมวลผล context สะสมทั้งหมดก่อน reason ต่อได้ ใน agentic session ส่วนใหญ่ token ที่ถูก *process* มากกว่า token ที่ถูก *generate* หลายเท่า

**M5 แก้ด้วย Neural Accelerators:**

- Matrix multiplication เร็วขึ้น **4 เท่า** เมื่อเทียบกับ M4
- MLX มี specialized kernels สำหรับ multiplication + attention ที่ map ตรงกับ Neural Accelerators
- Translation เกือบ 1:1: prompt processing speedup ~4×
- **ไม่ต้องเปลี่ยน code** — MLX auto-select kernel ที่ดีที่สุดสำหรับ hardware ที่มีอยู่

ผลจริง: agent อ่าน codebase, ประมวลผล tool results, และ process context ยาวๆ ได้เร็วขึ้นเป็นเงาตามตัว

### Continuous Batching: รัน Subagents หลายตัวพร้อมกัน

**ปัญหา:** pattern ปกติในงาน coding คือ agent หลัก spawn subagents หลายตัวพร้อมกัน — "อ่าน docs", "search code", "เขียน tests" — ส่ง requests ชนกันที่ model พร้อมกัน

**MLX-LM Server แก้ด้วย Continuous Batching:**

```
Subagent A ──┐
Subagent B ──┼──→ Dynamic Batch ──→ GPU ──→ Response A, B, C
Subagent C ──┘
Subagent D ─────→ join batch in-progress ──→ Response D
```

- Requests ถูก group เป็น batch แบบ dynamic
- Request ใหม่ join batch ที่กำลัง process ได้เลย โดยไม่ต้องรอ batch เดิมเสร็จ
- Subagents ไม่ถูกบล็อกในคิว — ทุกตัวได้รับการตอบสนองแบบ concurrent

### Distributed Inference: ขยาย RAM ข้าม Mac Cluster

![Mac Cluster Distributed Inference](/assets/images/mlx_mac_cluster_inference.png)

**ปัญหา:** DeepSeek model ล่าสุดมี **1.6 ล้านล้าน parameters** ต้องใช้ RAM มากกว่า **800GB** สำหรับ weights — เกินแม้แต่ Mac ที่ RAM สูงสุด (512GB)

**MLX Distributed แก้ด้วยการ shard model ข้าม Mac หลายเครื่อง:**

```bash
# hosts.txt — Mac แต่ละเครื่องในคลัสเตอร์
192.168.1.10 slots=1
192.168.1.11 slots=1

# Launch distributed server
mlx.launch --hostfile hosts.txt \
  python -m mlx_lm.server --model deepseek-ai/DeepSeek-V3 --port 8080
```

- เชื่อมต่อผ่าน **Thunderbolt** หรือ Ethernet
- Model ถูก shard อัตโนมัติ — ทุก devices ช่วยกัน process
- **macOS 26.2+**: รองรับ **Thunderbolt RDMA** — latency ต่ำมาก, bandwidth สูง
- Speedup: สูงสุด **3× ด้วย 4 nodes** เทียบกับ single machine
- RDMA รองรับ: M4 Pro Mac Mini, M4 Max Mac Studio, M4 Max MacBook Pro, M3 Ultra Mac Studio

### Xcode Intelligence Integration

เชื่อม Xcode เข้ากับ MLX-LM Server ใน 4 คลิก:

1. Xcode → **Settings** → **Intelligence** tab
2. คลิก **Add Chat Provider...**
3. เลือก **Locally Hosted**
4. ตั้ง **Port**: `8080`

หลังจากนั้น Xcode อ่านไฟล์ project, เข้าใจ build errors, และแก้ code โดย model รันบน Mac — code ไม่ออกจากเครื่องเลย

## User Guide (Step-by-Step)

### ติดตั้งและเปิด Server

```bash
# ติดตั้ง
pip install mlx-lm

# เปิด server พร้อม small model สำหรับทดสอบ
mlx_lm.server --model mlx-community/Qwen2.5-7B-Instruct-4bit --port 8080
# พร้อมเมื่อเห็น: Uvicorn running on http://0.0.0.0:8080
```

**RAM requirement (โดยประมาณ):**
- 7B 4-bit: ~4GB
- 14B 4-bit: ~8GB
- 32B 4-bit: ~18GB
- 70B 4-bit: ~40GB

### ทดสอบ API

```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "mlx-community/Qwen2.5-7B-Instruct-4bit",
    "messages": [{"role": "user", "content": "Hello, are you running locally?"}]
  }'
```

### ใช้กับ Claude Code (claude.ai/code)

```bash
# เพิ่ม local provider ใน Claude Code settings
# ชี้ base_url ไปที่ localhost:8080/v1
# ตั้ง model name ตรงกับที่ server load
```

### ใช้กับ OpenCode Agent

```json
{
  "providers": {
    "local": {
      "base_url": "http://localhost:8080/v1",
      "api_key": "not-needed"
    }
  },
  "model": {
    "provider": "local",
    "id": "mlx-community/Qwen2.5-7B-Instruct-4bit"
  }
}
```

### ใช้กับ Python SDK (OpenAI-compatible)

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8080/v1",
    api_key="not-needed",
)

response = client.chat.completions.create(
    model="mlx-community/Qwen2.5-7B-Instruct-4bit",
    messages=[{"role": "user", "content": "สรุปโค้ดนี้ให้หน่อย"}],
)
print(response.choices[0].message.content)
```

### Tool Calling

```python
tools = [{
    "type": "function",
    "function": {
        "name": "run_command",
        "description": "Execute a shell command",
        "parameters": {
            "type": "object",
            "properties": {
                "command": {"type": "string"}
            },
            "required": ["command"]
        }
    }
}]

response = client.chat.completions.create(
    model="mlx-community/Qwen2.5-7B-Instruct-4bit",
    messages=[{"role": "user", "content": "List files in current directory"}],
    tools=tools,
    tool_choice="auto",
)
```

## Caveats / Limits

- **macOS + Apple Silicon เท่านั้น** — MLX เป็น framework เฉพาะ Apple Silicon ไม่รองรับ Windows/Linux
- **RDMA ต้องการ macOS 26.2+** ซึ่งยังอยู่ใน beta ณ เวลาที่เขียน; Thunderbolt 5 มีแค่ M4 Pro ขึ้นไป
- **Model ต้องรองรับ tool calling** — เลือก `-Instruct` หรือ `-Chat` variant; ไม่ใช่ทุก model จาก HuggingFace ที่ทำงานได้ทันที
- **RAM เหลือน้อยทำให้ system ช้า** — ต้องเผื่อ RAM สำหรับ macOS + apps อื่น; ไม่ควรรัน model ที่ต้องการ RAM เกิน 70–80% ของ total
- **Context window ยาว = prompt processing ช้า** — แม้ M5 จะเร็วขึ้น 4× แต่ session ที่มี 500K+ token ยังใช้เวลาพอสมควร
- **ไม่มี authentication ในตัว** — server listen บน localhost; ถ้า expose ออก local network ต้องเพิ่ม reverse proxy + auth เอง
- **Distributed inference ยัง experimental** — เฉพาะ RDMA บน macOS 26.2 beta; Ethernet path เสถียรกว่า

## References

1. [WWDC Session: Build agentic AI workflows with MLX](https://youtu.be/wykPErJ8M-8) — Angelos, MLX Engineering Team
2. [GitHub: ml-explore/mlx-lm](https://github.com/ml-explore/mlx-lm) — Official MLX-LM repository
3. [MLX Distributed Communication — Official Docs](https://ml-explore.github.io/mlx/build/html/usage/distributed.html)
4. [Run DeepSeek R1 or V3 with MLX Distributed](https://simonwillison.net/2025/Jan/22/mlx-distributed/) — Simon Willison
5. [MLX Distributed Inference — LocalAI docs](https://localai.io/features/mlx-distributed/)
6. [Apple Silicon LLMs: Complete Guide 2026](https://codersera.com/blog/apple-silicon-llms-complete-guide-2026/) — Codersera

## Key Takeaways

- **4-layer stack**: MLX → MLX-LM → MLX-LM Server → Agent; ทุกชั้น open-source, ใช้ได้กับ agent framework ทุกตัว
- **MLX-LM Server** คือ drop-in replacement สำหรับ OpenAI API — แค่เปลี่ยน `base_url` เป็น `localhost:8080/v1`
- **M5 Neural Accelerators** เพิ่ม matrix multiplication 4× vs M4 → prompt processing ใน agentic loop เร็วขึ้นโดยอัตโนมัติ ไม่ต้องเปลี่ยน code
- **Continuous Batching** ให้หลาย subagents serve พร้อมกันได้จริง ไม่บล็อกกันในคิว
- **Distributed Inference** ผ่าน Thunderbolt (RDMA บน macOS 26.2) ขยาย RAM ข้าม Mac cluster — สูงสุด 3× speedup ด้วย 4 nodes
- **Xcode Intelligence** connect ไปที่ MLX-LM Server ได้ใน 4 คลิก — code ไม่ออกจากเครื่อง
- **Cost + Privacy**: $0 API cost, 0 data sent off-device — ideal สำหรับ proprietary codebase และงาน sensitive
