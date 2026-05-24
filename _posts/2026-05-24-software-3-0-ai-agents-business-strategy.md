---
title: "Software 3.0: ยุค AI Agents เปลี่ยนโมเดลธุรกิจและกลยุทธ์สร้าง Moat ที่ยั่งยืน"
date: 2026-05-23 00:08:00 +0700
categories: [Engineering]
tags: [software-3-0, ai-agents, prompt-engineering, business-strategy, orchestration, proprietary-data, moat, llm, karpathy]
slides: true
---

{% include slide-link.html %}

## TL;DR

Software 3.0 คือยุคที่ Prompting และ AI Agents กลายเป็น programming paradigm ใหม่ — โมเดลธุรกิจที่ขายขั้นตอน Manual หรือ Code กำลังถูก disrupt; กลยุทธ์ที่ยั่งยืนคือการสร้าง moat จาก Proprietary Data, Domain Knowledge, Complex Orchestration, และการเปลี่ยนจากขาย "process" มาขาย "outcome"

## Background / Why this matters

Andrej Karpathy นักวิจัย AI ที่เคยเป็น Director of AI ที่ Tesla และ founding member ของ OpenAI ได้บัญญัติ framework ที่ชื่อ Software 1.0 / 2.0 / 3.0 เพื่ออธิบาย paradigm shift สามยุคของ software development:

- **Software 1.0** (ยุค Traditional Code): Developer เขียน explicit instructions ใน Python, Java, C++ ทุกบรรทัด — logic ทั้งหมดมาจากมนุษย์
- **Software 2.0** (ยุค Neural Networks): Karpathy เขียน essay ปี 2017 อธิบายว่า "program" คือ neural network weights ที่ train จาก data — มนุษย์ไม่ได้เขียน logic แต่ออกแบบ training process แทน
- **Software 3.0** (ยุคปัจจุบัน): ใช้ Foundation Models (GPT-4, Claude, Gemini) ผ่าน natural language prompts — "prompting a language model is a form of programming"

ความสำคัญของ framework นี้สำหรับธุรกิจคือ: Software 3.0 กำลัง **eat** Software 1.0 และ 2.0 พร้อมกัน ทำให้ธุรกิจที่ competitive advantage เดิมขึ้นอยู่กับ "code complexity" หรือ "technical barrier" เริ่มเสีย moat อย่างรวดเร็ว

## Deep Dive

### Software 1.0 → 2.0 → 3.0: วิวัฒนาการ

```
Software 1.0  │  Developer เขียน if-else, algorithm, logic ทุกบรรทัด
              │  Moat: technical expertise, code complexity
─────────────────────────────────────────────────────────────
Software 2.0  │  Train neural network จาก data
              │  "Program" = model weights
              │  Moat: data volume, compute resources
─────────────────────────────────────────────────────────────
Software 3.0  │  Prompt Foundation Models ด้วย natural language
              │  Context window = programming surface
              │  Moat: domain knowledge, data quality, orchestration
```

ใน Software 3.0, context window คือพื้นที่ programming ใหม่ — AI อ่าน context, reason, เรียก tools, และ adapt ตาม instructions ที่ให้ไป แทนที่จะต้องเขียนโค้ดบอก step by step

สิ่งที่เปลี่ยนไปในยุค Software 3.0:
1. **Verification แทน Generation** — AI generate ได้เร็วกว่ามนุษย์ check; bottleneck เปลี่ยนจาก "เขียนให้ถูก" เป็น "verify ว่าถูก"
2. **Context Management** — สำคัญเท่า syntax mastery; รู้ว่าจะให้ AI รู้อะไร ไม่รู้อะไร
3. **Agentic Engineering** — มนุษย์ supervise และ orchestrate agents แทนที่จะ implement เอง

### Software 3.0 Disrupts Business Models

Karpathy อธิบายใน Sequoia AI Ascent 2026 ว่า "verifiability" คือตัวชี้วัดว่า workflow ไหนจะถูก automate ก่อน:

| Workflow | Verifiability | ความเสี่ยง Disruption |
|----------|--------------|----------------------|
| Tax calculation | High (ตัวเลขถูก/ผิด) | สูงมาก |
| Contract review | Medium (checklist-based) | สูง |
| Creative content | Low (subjective) | ปานกลาง |
| Strategic decision | Very Low | ต่ำ |

ธุรกิจที่ขาย "manual process" ในพื้นที่ high-verifiability กำลัง disrupt อย่างรวดเร็ว ตัวอย่าง: legal research, financial analysis, code review, customer support — ล้วนมี AI solutions ที่ดีขึ้นอย่างรวดเร็วในปี 2025-2026

### 5 Moats ที่ยั่งยืนใน Software 3.0 Era

เมื่อ "simple prompts are commoditized" moat ใหม่คืออะไร?

**1. Specialized Domain Knowledge**

Palantir เป็นตัวอย่างคลาสสิก — moat ไม่ได้อยู่ที่ code complexity แต่อยู่ที่ "deep knowledge of intelligence workflows" ในภาครัฐและ enterprise ธุรกิจที่มี domain experts สามารถเปลี่ยนพวกเขาให้เป็น "prompt architects" ที่ multiply impact ได้

**2. Proprietary Data Assets**

Bloomberg Finance (Bloomberg Terminal) และ Tesla (real-world driving data) เป็นตัวอย่างของ proprietary data moat — data ที่ AI ทั่วไปไม่มีสิทธิ์ access แต่ระบบของธุรกิจนั้นๆ มี กลยุทธ์คือ identify "unique data assets" ในองค์กรและสร้างระบบที่ทำ data นั้น AI-accessible โดยไม่ให้หลุดออก

**3. Complex Workflow Orchestration**

Multi-agent systems ที่จัดการ end-to-end process สร้าง moat ได้เพราะ competitor replicate ยาก ตัวอย่าง: KPMG TaxBot ที่ใช้ sophisticated prompt engineering จัดการ tax complexity ทั้ง workflow — ไม่ใช่แค่ "ask AI คำถามภาษี" แต่เป็นระบบ orchestration ที่ออกแบบมาเฉพาะ

**4. Human-AI Feedback Loops**

Implementation ที่แข็งแกร่งที่สุดคือระบบที่สร้าง "tight feedback loops" ระหว่าง human expertise กับ AI capabilities — สะสม institutional knowledge ที่ replicate ยาก คู่แข่งที่เริ่มทีหลังต้องเริ่มสะสมจากศูนย์

**5. Brand Trust & Accountability**

ใน Software 3.0 ที่ AI outputs มีข้อผิดพลาดได้ ลูกค้าจ่ายเพิ่มเพื่อ "accountable entity" ที่รับผิดชอบ outcome ธุรกิจที่มี track record และ brand trust สามารถ charge premium สำหรับ AI-delivered outcomes ที่ผ่าน human verification

### Agentic Engineering vs Vibe Coding

Karpathy แยก 2 paradigm ของ Software 3.0:

**Vibe Coding** — ให้ AI เขียน code โดยไม่ต้องเข้าใจ — democratizes building แต่ลด quality floor; เหมาะกับ prototype แต่ production path ยังต้องการ authentication, payments, deployment ที่ labor-intensive

**Agentic Engineering** — มนุษย์ maintain professional standards ขณะ leverage AI — ต้องแน่ใจว่า "no security holes, no messy architecture, no fragile systems" — เป็นทิศทางของ serious software development

Quote ที่สำคัญ: **"You can outsource thinking. You cannot outsource understanding."** — Karpathy

ในยุค agentic engineering มนุษย์ shift จาก "write code" มาเป็น "decide what's worth building" และ "define what good looks like" — understanding ยิ่งสำคัญขึ้น ไม่ใช่น้อยลง

### เปลี่ยนจากขาย "Process" → ขาย "Outcome"

นี่คือ strategic shift ที่สำคัญที่สุดสำหรับธุรกิจ Software 3.0:

**Old model (Software 1.0/2.0):**
```
ลูกค้าซื้อ: software tool + training + support
ลูกค้าต้องทำเอง: เรียนใช้เครื่องมือ → ทำงาน → ได้ผลลัพธ์
ราคา: license fee + consulting hours
```

**New model (Software 3.0):**
```
ลูกค้าซื้อ: ผลลัพธ์ (contract reviewed, leads qualified, report generated)
ธุรกิจรับผิดชอบ: orchestrate AI system → deliver outcome
ราคา: outcome-based / success fee
```

ตัวอย่างจริง:
- Law firm เดิม: bill by hour for document review → ใหม่: flat fee per contract reviewed with AI
- Marketing agency เดิม: sell content creation hours → ใหม่: sell leads generated / conversion rate
- Accounting firm เดิม: charge per tax return prepared → ใหม่: subscription for "tax compliance maintained"

ธุรกิจที่ยังขาย "step" หรือ "process" จะโดน commoditize; ธุรกิจที่ขาย "outcome" ด้วย AI-backed guarantee จะสร้าง defensible position

## Caveats / Limits

- **Prototype ≠ Production**: Vibe coding สร้าง prototype ได้เร็ว แต่ production-grade system ยังต้องการ proper engineering สำหรับ security, reliability, และ compliance
- **Hallucination Risk**: AI ใน high-stakes domain (legal, medical, financial) ยังต้องมี human verification layer — ไม่ใช่ทุก workflow ที่ automate เต็ม 100% ได้ปลอดภัย
- **Switching Costs ลดลง**: Software 3.0 systems สร้างง่าย — moat ที่แท้จริงต้องอยู่ที่ data และ knowledge ไม่ใช่แค่ technology implementation
- **Regulation Lag**: หลายอุตสาหกรรมยังมี regulatory requirements ที่ต้องมี human accountability — ขาย outcomes แบบ full-AI อาจมี legal risk ในบาง jurisdiction
- **Verifiability Gap**: Workflows ที่ output ตรวจยาก (creative, strategic) ยังต้องการ human judgment; AI automation ที่นี่ช้ากว่า high-verifiability domains

## References

1. [Andrej Karpathy on Software 3.0 — Travis Media](https://travis.media/blog/software-3-0-ai-changing-programming-karpathy/)
2. [Software 3.0 is eating the stack: What's your moat? — Kyndryl](https://www.kyndryl.com/us/en/about-us/news/2025/10/rise-of-software-3-0)
3. [What Is Software 3.0? How Prompting Replaced Programming — MindStudio](https://www.mindstudio.ai/blog/what-is-software-3-0-prompting-replaced-programming)
4. [Why Andrej Karpathy Says Software 3.0 is eating 1.0 and 2.0 — Towards AI](https://towardsai.net/p/artificial-intelligence/why-andrej-karpathy-says-software-3-0-is-eating-1-0-and-2-0)
5. [Sequoia AI Ascent 2026: Andrej Karpathy — The AI Opportunities](https://www.theaiopportunities.com/p/sequoia-ai-ascent-2026-andrej-karpathy)
6. [Software 1.0 vs 2.0 vs 3.0 — MindStudio](https://www.mindstudio.ai/blog/software-1-0-2-0-3-0-ai-programming-paradigm)
7. [Source video — YouTube](https://youtu.be/hJNp9RwK-Uw)

## Key Takeaways

- Software 3.0 = Context/Prompts เป็น programming language ใหม่ — LLMs คือ runtime ที่รับ natural language instructions แทน code
- **Karpathy's framework**: 1.0 (explicit code) → 2.0 (neural network weights) → 3.0 (prompts + context window) — ทั้งสามยังอยู่ร่วมกัน ทักษะคือรู้ว่าจะใช้ layer ไหนกับงานอะไร
- Moats ที่ยั่งยืน: **Proprietary Data** + **Domain Knowledge** + **Complex Orchestration** + **Human-AI Feedback Loops** + **Brand Trust** — ไม่ใช่แค่ "ใช้ AI เป็น"
- Strategic shift: เลิกขาย "process steps" → ขาย "outcomes" — ธุรกิจที่ยังขาย manual process จะ commoditize เร็วใน high-verifiability domains
- **"You can outsource thinking. You cannot outsource understanding."** — Karpathy: human judgment ยิ่งสำคัญขึ้นใน Software 3.0 ไม่ใช่น้อยลง
- Verifiability คือตัวชี้ว่า workflow ไหนจะถูก disrupt ก่อน — finance, compliance, legal research มีความเสี่ยงสูงที่สุด
- Vibe coding (democratizes) vs Agentic Engineering (maintains quality) — production-grade systems ต้องการ agentic engineering mindset
