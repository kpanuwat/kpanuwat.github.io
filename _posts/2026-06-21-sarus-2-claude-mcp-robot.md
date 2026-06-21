---
title: "Sarus 2.0: เมื่อ Claude AI มีร่างกายด้วย MCP — หุ่นยนต์ที่โปรแกรมด้วยภาษาอังกฤษธรรมดา"
date: 2026-06-20 00:05:00 +0700
categories: [Engineering]
tags: [mcp, claude, raspberry-pi, esp32, robotics, lidar, ros2, ai-agent, model-context-protocol]
---

## TL;DR

Sarus 2.0 คือหุ่นยนต์ที่ใช้ **Claude + Model Context Protocol (MCP)** เป็นสมอง โดยให้ Claude Code เขียนโค้ดควบคุมระบบให้เกือบทั้งหมด — ผู้สร้างแค่อธิบายฮาร์ดแวร์ด้วยภาษาอังกฤษในไฟล์ `claw.md` ก็เปลี่ยนพฤติกรรมหุ่นได้โดยไม่ต้องแตะ code เลย

## Background / Why this matters

ปกติการเขียนโปรแกรมหุ่นยนต์หมายถึงโค้ด C++/Python หลายพันบรรทัด ต้องเข้าใจ ROS, PID controllers, sensor fusion และ driver ของทุกฮาร์ดแวร์ แต่ **Sarus 2.0** พิสูจน์แนวคิดใหม่: ถ้า AI มี API ที่สะอาดพอเข้าถึงเซนเซอร์และ actuator ได้ มันสามารถตัดสินใจและสั่งงานร่างกายได้เอง

แนวคิดนี้สำคัญเพราะ:
- **Democratizes robotics** — คนที่รู้แค่ภาษาอังกฤษสามารถปรับพฤติกรรมหุ่นได้
- **MCP เป็น lingua franca** ของ AI-hardware bridge — แทนที่จะ hardcode driver, wrap ทุกอย่างเป็น MCP tool
- **Claude เขียน MCP server ของตัวเอง** — bootstrap loop ที่น่าสนใจมาก

Sarus 2.0 สร้างโดย YouTuber ที่แชร์ source code ไว้ใน video "What Happens When You Give Claude a Body? (Code Included)"

## Deep Dive

### 1. Hardware Architecture

| Component | รายละเอียด | หน้าที่ |
|-----------|-----------|---------|
| **Raspberry Pi 4** | Main compute unit | รัน Claude AI + MCP servers + high-level logic |
| **ESP32** | Microcontroller (C++ firmware) | Physical execution — รับคำสั่ง, ควบคุม motors |
| **JGA25 motors + encoders** | DC motors with feedback | Precise movement, odometry |
| **LT06 Lidar** | 360° laser scanner | Obstacle mapping, spatial awareness |
| **ToF sensor (8×8 grid)** | Time-of-Flight บน bumper | ตรวจจับสิ่งกีดขวางต่ำ (สายไฟ, รองเท้า) |
| **Dual cameras** | Horizon cam + floor cam | stitched เป็น single frame ส่งให้ Claude |
| **7-inch display** | หน้าจอ | แสดง personality/expression |
| **3S2P Li-ion + BMS** | Custom battery pack | Clean power, discharge protection |

ระบบแบ่งชัดเป็น 2 ชั้น:
- **RPi 4 (AI layer)**: คิด, วางแผน, เรียก MCP tools
- **ESP32 (execution layer)**: รับคำสั่ง, ขยับ motors, อ่านเซนเซอร์ระดับต่ำ

### 2. Model Context Protocol (MCP) Architecture

แทนที่จะให้ Claude fire raw shell commands (อันตราย, ไม่ reliable) — ทุก peripheral ถูก wrap เป็น **MCP server** หนึ่งตัว:

```
Claude (AI brain)
    │
    ▼ calls MCP tools
┌─────────────────────────────────────┐
│  MCP Server Layer (Raspberry Pi 4) │
│  ┌──────────┐ ┌──────────┐ ┌────┐  │
│  │  Lidar   │ │  Camera  │ │ToF │  │
│  │  Tool    │ │  Tool    │ │Tool│  │
│  └──────────┘ └──────────┘ └────┘  │
└─────────────────────────────────────┘
    │
    ▼ serial/network commands
ESP32 (C++ firmware) → motors/servos
```

เมื่อ Claude อยากดู Lidar scan → เรียก `lidar_scan()` tool → ได้ structured data กลับมา  
เมื่อ Claude อยากขยับ → เรียก `move_forward(speed, duration)` → ESP32 execute

**ที่น่าทึ่ง**: ผู้สร้างแค่บอก Claude ว่า hardware มี input/output อะไร — Claude เขียน MCP server code ให้เอง

### 3. `claw.md` — Brain in Plain English

นี่คือ innovation ที่น่าสนใจที่สุดของ project นี้:

```markdown
# Robot Behavior Rules (claw.md)

You are Sarus 2.0, a home robot assistant.

## Your Sensors
- Lidar: gives 360-degree distance map, angles in degrees
- Cameras: front (horizon) + floor stitched into single image
- ToF: 8x8 grid of distances on bumper, detects low obstacles

## Safety Rules
- Never move if any ToF reading < 15cm
- Stop if Lidar shows obstacle within 30cm in forward direction
- Always announce navigation decisions aloud

## Navigation Style
- Deliberate and careful, explain each decision
- ...
```

ไฟล์นี้ **ไม่ใช่โค้ด** — เป็นภาษาอังกฤษธรรมดา 100%  
ต้องการเปลี่ยนให้หุ่นไม่ชอบชนของ? แก้ safety threshold ใน `claw.md`  
ต้องการให้หุ่น narrate ทุก action? เพิ่ม 1 ประโยคใน behavior rules

### 4. ความสามารถที่เกิดขึ้น (Emergent Capabilities)

เพราะ Claude มี reasoning สูง + sensor access ครบ → behaviors ที่ไม่ต้อง hardcode:

- **Voice commands**: รับคำสั่งเสียง → Claude interpret → execute
- **Object search**: "ไปหา remote control" → สแกน camera, navigate ไปยังวัตถุ
- **Real-time obstacle avoidance**: Lidar + ToF → Claude ตัดสินใจหลบเองแบบ context-aware
- **Traffic light understanding**: เข้าใจกฎสัญญาณไฟจราจรโดยไม่ต้อง hardcode rules — Claude อนุมานจาก visual + ความรู้เดิม

ทั้งหมดนี้ไม่มี if-else ใน robot code เลย — logic อยู่ใน LLM ล้วนๆ

### 5. Latency — ข้อจำกัดสำคัญ

```
User command
    │  
    ▼  
Claude receives → reads sensors → reasons → decides which tools to call
    │  (ช่วงนี้หุ่นหยุดนิ่ง ~1-3 วินาที)
    ▼  
Execute move
    │
    ▼
Claude reads sensors again → next decision
```

เพราะทุก action ต้องผ่าน LLM reasoning — การเคลื่อนไหวเป็น **step-by-step ไม่ fluid**  
เปรียบเทียบ: หุ่นยนต์ทั่วไปใช้ continuous control loop ที่ update 50-100Hz; Sarus 2.0 update ทุก ~2-5 วินาที

Trade-off ที่ต้องเลือก:

| Model | Latency | Reasoning Quality |
|-------|---------|-------------------|
| Claude Haiku | เร็วกว่า (~0.5s) | ลดลง |
| Claude Sonnet | ช้ากว่า (~2-3s) | สูง — วางแผน, เข้าใจ context |

ผู้สร้างใช้ Sonnet เพราะ reasoning quality สำคัญกว่าความเร็วในการ demo

## User Guide (Step-by-Step)

> Pattern นี้ใช้ได้กับ hardware project ใดก็ได้ที่อยากให้ Claude เป็นสมอง

### Step 1: Design MCP Tool Interface

สำหรับแต่ละ peripheral ให้กำหนด:
```python
# ตัวอย่าง MCP tool definition (Python)
@tool
def lidar_scan() -> dict:
    """
    Get current 360-degree Lidar scan.
    Returns: {angles: [0..359], distances: [float...], unit: 'cm'}
    """
    # อ่านจาก serial/network จาก hardware layer
    return read_lidar_data()
```

### Step 2: สร้าง `claw.md` (Behavior File)

```markdown
# [Robot Name] Behavior

## Identity
You are [robot name]. [personality description]

## Sensors Available
- [sensor]: [what it returns, units, range]

## Movement Commands
- move_forward(speed, ms): [what happens]

## Safety Rules
- [rule 1]
- [rule 2]

## Personality
[how to express emotions, narration style]
```

### Step 3: Boot Sequence

```bash
# RPi 4 startup
python3 mcp_server.py &   # start all MCP tool servers
claude --mcp-config robot.json --system-prompt claw.md
```

### Step 4: Test Incrementally

1. Test แต่ละ MCP tool แยก ก่อน connect Claude
2. ทดสอบ safety rules ก่อน movement
3. เพิ่ม capability ทีละอย่าง

## Caveats / Limits

- **Latency**: LLM inference ช้าเกินไปสำหรับ real-time reaction (< 100ms) — ไม่เหมาะกับงานที่ต้องการ reflex
- **API Cost**: ทุก sense-decide-act cycle เรียก Claude API — cost สูงถ้าใช้หนัก; on-device LLM (Ollama) เป็นทางเลือก
- **Context limit**: ถ้า sensor data ใหญ่มาก (เช่น camera image) → ใช้ token หนัก; ต้องออกแบบ data compression
- **No persistent memory**: Claude ไม่จำ session ก่อนหน้าโดย default — ต้อง implement memory layer แยก
- **Single-threaded decisions**: Claude ตัดสินใจทีละอย่าง ไม่ parallel — ซับซ้อนน้อยกว่า traditional robotics architecture
- **ROS 2 gap**: ยังไม่มี sensor fusion, continuous control loop, หรือ navigation stack ระดับ professional

## References

1. Video: "What Happens When You Give Claude a Body? (Code Included)" — [youtu.be/zrvFgxxDrIU](https://youtu.be/zrvFgxxDrIU)
2. Anthropic Model Context Protocol (MCP) — [modelcontextprotocol.io](https://modelcontextprotocol.io)
3. GitHub: robotmcp/ros-mcp-server — Connect AI models with robots via MCP and ROS — [github.com/robotmcp/ros-mcp-server](https://github.com/robotmcp/ros-mcp-server)
4. GitHub: mcp2serial — AI hardware control via serial/MCP — [github.com/mcp2everything/mcp2serial](https://github.com/mcp2everything/mcp2serial)
5. Arm Learning Path: Deploy MCP Server on Raspberry Pi for AI Agent — [learn.arm.com](https://learn.arm.com/learning-paths/cross-platform/mcp-ai-agent/intro-to-mcp-uv/)
6. peaq Robotics SDK: Making Robots OpenClaw-ready — [peaq.xyz](https://www.peaq.xyz/blog/make-your-robot-openclaw-ready-with-robotics-sdk)
7. ROS 2 Documentation — [docs.ros.org](https://docs.ros.org)

## Key Takeaways

- **MCP เป็น hardware bridge ที่สะอาดที่สุด**: แทน raw shell commands → typed tool definitions ป้องกัน injection + ให้ Claude เข้าใจ capability ของ robot ชัดเจน
- **`claw.md` pattern เปลี่ยน game**: behavior file ภาษาอังกฤษทำให้ non-programmer ปรับพฤติกรรม robot ได้ — เหมือน CLAUDE.md ของ robot
- **Claude เขียน MCP server ของตัวเอง** — ผู้สร้างแค่บอก I/O spec, Claude generate integration code → bootstrap loop ที่ทรงพลัง
- **Latency คือ trade-off หลัก**: LLM reasoning สูง แต่ไม่ real-time; งานที่ต้อง reflex ยังต้องการ traditional control loop
- **ROS 2 คือ next step**: sensor fusion + continuous control loops จะปิด gap ระหว่าง deliberate AI decisions กับ fluid robot movement
- **Pattern นี้ reproducible**: ใครก็ทำได้ด้วย RPi + ESP32 + MCP SDK — entry barrier ต่ำผิดปกติสำหรับ robotics
