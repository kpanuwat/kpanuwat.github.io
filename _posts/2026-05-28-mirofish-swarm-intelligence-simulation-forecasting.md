---
title: "MiroFish: Swarm Intelligence Engine ที่จำลองสังคมเสมือนเพื่อพยากรณ์อนาคต"
date: 2026-05-27 00:13:00 +0700
categories: [Research]
tags: [swarm-intelligence, multi-agent, simulation, forecasting, ai-agents, knowledge-graph, oasis]
---

## TL;DR

MiroFish คือ open-source engine ที่สร้าง "สังคมดิจิทัล" จาก Agent AI อิสระนับพัน แต่ละตัวมี memory, บุคลิก, และ logic ในการตัดสินใจของตัวเอง — แล้วปล่อยให้ถกเถียงกันในสภาพแวดล้อมเสมือน (คล้าย Twitter + Reddit) เพื่อดูว่า "อะไรจะเกิดขึ้นต่อไป" แทนที่จะพยากรณ์ด้วย statistical regression แบบเดิม

---

## Background / Why This Matters

การพยากรณ์อนาคตด้วย AI แบบดั้งเดิม (time series, regression, ensemble models) มีจุดอ่อนร่วมกันอย่างหนึ่ง: มันวิเคราะห์ **ข้อมูลตัวเลขในอดีต** แต่ไม่ได้จำลอง **พฤติกรรมมนุษย์** ซึ่งขับเคลื่อนโดยอารมณ์ เครือข่ายสังคม และ information cascade

MiroFish เกิดจากคำถามว่า: *"ถ้าเราสร้างสังคมดิจิทัลที่มี Agent อิสระหลายพัน ซึ่งแต่ละตัวมีบุคลิกและความทรงจำของตัวเอง แล้วปล่อยให้พวกมันตอบสนองต่อ event จริง — ผลลัพธ์ที่ emergent ขึ้นมาจะบอกอะไรเราบ้าง?"*

โปรเจกต์นี้สร้างในเวลา **10 วัน** โดย Guo Hangjiang นักศึกษาอายุ 20 ปี ก่อนที่จะติดอันดับ #1 บน GitHub Global Trending และระดมทุนได้ **30 ล้านหยวน (~$4.1M)** ภายใน 24 ชั่วโมงจาก Chen Tianqiao ผู้ก่อตั้ง Shanda Group [4]

---

## Deep Dive

### Architecture: ไม่ใช่ Chatbot — เป็น Digital Society

MiroFish ต่างจาก AI prediction tool ทั่วไปตรงที่ไม่ได้ถาม LLM ว่า "อะไรจะเกิดขึ้น?" แต่ **สร้างสังคมจำลองแล้วสังเกตผล**

```
Seed Data (news/reports)
       ↓
  Knowledge Graph (GraphRAG)
       ↓
  Agent Population (1000s of unique personas)
       ↓
  Parallel Simulation (Twitter-like + Reddit-like)
       ↓
  ReportAgent → Structured Prediction
       ↓
  Deep Interaction (user ↔ individual agents)
```

### ขั้นตอนที่ 1: Knowledge Graph Construction

ระบบรับ seed material (ข่าว, รายงานการเงิน, เอกสารนโยบาย) แล้วใช้ **GraphRAG architecture** สกัด entity และ relationship สร้างเป็น knowledge graph — รู้จักว่า "ใคร เกี่ยวข้องกับ ใคร อย่างไร" ไม่ใช่แค่ text chunks [3]

ข้อแตกต่างจาก plain RAG: Graph-RAG เก็บโครงสร้างความสัมพันธ์ ทำให้ Agent สามารถอ้างอิง context เชิงโครงสร้าง เช่น "นาย A เคยทำงานให้ Company B ซึ่งแข่งกับ C" แทนที่จะดึงแค่ paragraphs ที่คล้ายกัน

### ขั้นตอนที่ 2: Agent & Environment Setup

จาก knowledge graph ระบบ generate **Agent personas** นับพัน แต่ละตัวมี:

| Property | รายละเอียด |
|----------|-----------|
| Personality Traits | background, stance เริ่มต้น, decision logic ที่ไม่ซ้ำกัน |
| Long-term Memory | จัดการโดย **Zep Cloud** — จำได้ข้ามรอบ simulation |
| Social Network | ความสัมพันธ์และ influence weight กับ Agent อื่น |
| Social Actions | 23 ประเภท: post, comment, like, follow, quote-reply, opinion-shift, ฯลฯ |

### ขั้นตอนที่ 3: Parallel Simulation (OASIS Engine)

Simulation รันบน **OASIS framework** (พัฒนาโดย CAMEL-AI research community) [3] ซึ่งเป็น core ที่รองรับ:

- **1 ล้าน Agent พร้อมกัน**
- สภาพแวดล้อมแบบ dual-platform: Twitter-like (short posts) + Reddit-like (threaded debate)
- จำลองปรากฏการณ์ทางสังคมที่ documented แล้ว: information propagation, group polarization, herd effects

Agents โต้ตอบกัน อัปเดต belief ของตัวเอง เปลี่ยน opinion ได้ — สร้าง **emergent behavior** ที่ไม่ได้ถูก hard-code ไว้ [5]

### ขั้นตอนที่ 4: Report Generation

หลัง simulation จบ **ReportAgent** — AI พิเศษที่แยกออกมา — วิเคราะห์ผลการจำลอง (opinion shifts, coalition formations, narrative dominance) แล้วออก structured report ที่ประกอบด้วย:

- สรุป outcome หลักพร้อม probability estimate
- emerging trends และ behavioral insights
- possible risks และ scenario variations

### ขั้นตอนที่ 5: Deep Interaction (God's-Eye View)

Feature ที่โดดเด่นที่สุด: user ไม่ได้แค่อ่าน report แต่ **เข้าไปในสังคมจำลองได้เลย**

- คุยกับ Agent รายบุคคล: "ทำไมคุณถึงเปลี่ยนใจ?"
- ถาม ReportAgent: "สมมติว่า X เกิดขึ้นแทน ผลเปลี่ยนไปไหม?"
- inject what-if variables กลางการจำลอง
- ทดสอบ alternative scenarios แบบ parallel

---

## Use Cases

| Use Case | วิธีใช้ MiroFish |
|----------|----------------|
| **การเงิน / Trading** | inject Fed announcement → ดูว่า trader, analyst, retail investor Agents ตอบสนองยังไง → predict sentiment, volatility |
| **การวิเคราะห์นโยบาย** | simulate citizen/media/lobbyist reactions ต่อร่างกฎหมาย → identify unexpected alliances หรือ blocking coalitions |
| **Marketing / Crisis PR** | ทดสอบว่า marketing message จะ spread ยังไง หรือ brand crisis จะ unfold อย่างไรบน social media |
| **การตัดสินใจส่วนตัว** | predict ผลของ career change, relocation, partnership decision |
| **Narrative Forecasting** | simulate character interactions เพื่อ predict story arcs หรือ missing chapters |

---

## User Guide (Step-by-Step)

### Prerequisites

```bash
# Required
node >= 18
python >= 3.8
# LLM API key (OpenAI-compatible; Qwen recommended)
# Zep Cloud account (free tier available, but exhausts quickly on large sims)

# Optional
docker  # for containerized stack
```

### Installation

```bash
git clone https://github.com/mirofish/mirofish   # check GitHub for latest repo URL
cd mirofish
npm install
pip install -r requirements.txt
```

### Basic Configuration

```bash
cp .env.example .env
# Edit .env:
# LLM_API_KEY=<your-openai-compatible-key>
# LLM_BASE_URL=https://api.openai.com/v1  # or Qwen endpoint
# ZEP_API_KEY=<zep-cloud-key>
# AGENT_COUNT=100   # start small; 1000+ = expensive
```

### Run First Simulation

```bash
# 1. Start the platform
npm run dev

# 2. Open http://localhost:3000
# 3. Create new simulation:
#    - Input: seed text (news article, scenario description)
#    - Agent count: 50-100 for testing
#    - Simulation rounds: 5-10 (each round = 1 LLM call per active agent)

# 4. Wait for Knowledge Graph + Agent generation (~2-5 min for 100 agents)
# 5. Start simulation → watch real-time agent interactions
# 6. Query ReportAgent when done
# 7. Use Deep Interaction to probe individual agents
```

### Cost Management

| Config | ~Token Cost per Simulation Round |
|--------|----------------------------------|
| 50 agents | ~50K tokens (~$0.05 at GPT-4o-mini pricing) |
| 500 agents | ~500K tokens (~$0.50) |
| 5,000 agents | ~5M tokens (~$5.00) |
| 40 rounds × 1,000 agents | ~200M tokens = significant cost |

> จำกัด simulation rounds ไว้ที่ **5-10 rounds** สำหรับการทดสอบ ก่อน scale ขึ้น

---

## Caveats / Limits

### ⚠️ ไม่มี Validation Benchmarks

ยังไม่มีงานวิจัยที่ตีพิมพ์ที่ verify ว่า MiroFish predictions accurate กว่า traditional forecasting [4] — outcome ขึ้นอยู่กับ seed data quality และ prompt framing อย่างมาก

### 💸 API Cost สูงมากเมื่อ Scale

แต่ละ Agent interaction ใช้ LLM API call — simulation ขนาดใหญ่ consume tokens มหาศาล Free tier ของ Zep Cloud (memory) หมดเร็วมากสำหรับ simulation ขนาดใหญ่ [3]

### 🧠 Bias Inheritance

Agents สืบทอด bias จาก underlying LLM — สามารถ amplify polarization หรือ herd behavior เกินความเป็นจริงของมนุษย์ [4] ผลลัพธ์จาก simulation ไม่ควร interpret เป็น ground truth

### 🔒 Security Considerations

โปรเจกต์ต้นทางเป็น Chinese open-source พร้อม documentation ภาษาจีน บางองค์กร Enterprise มีข้อกังวลด้าน security เกี่ยวกับการพึ่งพา cloud APIs [4] ตรวจสอบ dependencies ก่อน deploy ใน production environment

### 🖥️ Platform Support

ปัจจุบัน (v0.1.2) optimize สำหรับ macOS; Windows support ยังอยู่ใน testing [3]

---

## References

1. [MiroFish Official Site — mirofish.ink](https://mirofish.ink/)
2. [MiroFish Work — mirofish.work](https://mirofish.work/)
3. [Everything You Need to Know About MiroFish — DEV Community](https://dev.to/therealmrmumba/everything-you-need-to-know-about-mirofish-the-ai-swarm-engine-predicting-everything-5fp3)
4. [MiroFish: The AI Swarm Engine That Got $4M in 24 Hours — emelia.io](https://emelia.io/hub/mirofish-ai-swarm-prediction)
5. [What is MiroFish? — blocmates](https://www.blocmates.com/articles/what-is-mirofish-the-agent-engine-that-can-predict-anything-and-everything)
6. [MiroFish Full Tutorial (YouTube)](https://youtu.be/QmdCkaTM1P4)
7. [MiroFish Offline Fork — GitHub](https://github.com/nikmcfly/MiroFish-Offline)

---

## Key Takeaways

- **Paradigm shift**: MiroFish ไม่พยากรณ์ด้วย statistics — สร้าง digital society แล้วสังเกต emergent behavior
- **5-step pipeline**: Knowledge Graph → Agent Setup → Parallel Simulation (OASIS) → ReportAgent → Deep Interaction
- **OASIS engine**: open-source framework จาก CAMEL-AI รองรับ 1M agents พร้อมกัน, 23 social action types
- **Agent architecture**: personality + long-term memory (Zep Cloud) + social network position ทำให้แต่ละ Agent มีพฤติกรรมที่ unique
- **Deep Interaction**: feature ที่ทรงพลังที่สุด — user เข้าไป interview Agent รายบุคคลหรือ inject what-if scenarios กลาง simulation
- **Cost trap**: 1,000 agents × 40 rounds = ร้อยล้าน tokens; เริ่มจาก 50-100 agents เสมอ
- **Validation gap**: ยังไม่มี published benchmark — ใช้เป็น exploration/ideation tool ไม่ใช่ prediction oracle
- **Built in 10 days** โดยนักศึกษาอายุ 20 ปี → viral บน GitHub (33K+ stars), ระดมทุน $4.1M ใน 24 ชั่วโมง
