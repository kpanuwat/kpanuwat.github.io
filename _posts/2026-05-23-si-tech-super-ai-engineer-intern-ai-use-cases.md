---
title: "SI Tech × Super AI Engineer: เปิดรับ Intern 4 บทบาท พัฒนา AI Use Cases จริงในอุตสาหกรรม"
date: 2026-05-23 00:29:00 +0700
categories: [Engineering]
tags: [si-tech, super-ai-engineer, ai-intern, llm, enterprise-ai, forward-deploy, data-engineering, system-integration]
series: project-management-si
---

{% include series-nav.html %}

## TL;DR

SI Tech เปิดรับผู้ฝึกงานจากโครงการ **Super AI Engineer (AIAT)** ใน 4 บทบาท — Forward Deploy Engineer, AI Engineer, Data Engineer, Solutions Engineer — เพื่อพัฒนา AI use case จริง 5 ประเภทที่สร้าง value ทั้งให้ลูกค้าและภายในองค์กร ความร่วมมือนี้ช่วย SI Tech เข้าถึง AI talent คุณภาพสูง ทดลอง solution ได้เร็ว และเร่ง AI adoption เชิงธุรกิจอย่างเป็นรูปธรรม

## Background / Why This Matters

**โครงการ Super AI Engineer คืออะไร?**

Super AI Engineer เป็นโครงการพัฒนากำลังคนด้าน AI ของ **สมาคมปัญญาประดิษฐ์ประเทศไทย (AIAT)** โดยดำเนินการมาแล้ว 6 ซีซั่น มีผู้เข้าร่วมสะสมกว่า 45,800 คน แบ่งเป็น 3 tracks: AI Innovator, AI Engineer, AI Researcher โดย Season 6 ล่าสุดรับสมัครช่วงเมษายน 2026 [1][2]

จุดเด่นของโปรแกรมนี้คือการผสาน **intensive upskilling + hackathon + real-world internship** เข้าด้วยกัน ผู้ผ่านการคัดเลือกจึงมีทั้ง theoretical foundation และ hands-on experience จากโจทย์จริง ไม่ใช่แค่ coursework

**ทำไม SI Tech ถึงเหมาะจะร่วมโครงการนี้?**

SI Tech ในฐานะ System Integrator (SI) อยู่ในจุดที่ได้เปรียบมาก — มีลูกค้าหลายอุตสาหกรรม, legacy systems ที่ต้องการ AI layer, และโครงการ integration ที่เป็น **perfect sandbox** สำหรับ AI intern ที่อยากพัฒนา use case จริง

ปัญหาที่ SI หลายรายเผชิญคือ: รู้ว่าควร adopt AI แต่ไม่รู้จะเริ่มจากไหน ขาด talent ที่เข้าใจทั้ง AI และ domain ธุรกิจ และไม่มีเวลา experiment เพราะงาน project หลักเต็มมือ นี่คือช่องว่างที่ AI intern เติมได้พอดี

## Deep Dive

### บทบาทผู้ฝึกงาน 4 ประเภท

| บทบาท | โฟกัส | ทักษะหลัก |
|-------|--------|----------|
| **Forward Deploy Engineer** | Embed ใน client environment; build AI systems in production | RAG pipelines, prompt engineering, multi-agent frameworks, observability |
| **AI Engineer** | Model selection, fine-tuning, evaluation, deployment | LLM APIs, vector databases, inference optimization |
| **Data Engineer** | Data pipelines, feature stores, structured/unstructured data prep | ETL, SQL/NoSQL, streaming, data quality |
| **Solutions Engineer** | Pre-sales + post-sales technical scoping; demo ให้ลูกค้า | Solution architecture, cost estimation, PoC delivery |

**Forward Deploy Engineer (FDE)** คือบทบาทที่โตเร็วสุดในวงการ AI ปี 2026 — OpenAI, Anthropic, Cohere ต่างเปิดรับ FDE เพิ่มขึ้น 800–1,000% จากปี 2025 [3] ความต่างจาก consultant ทั่วไปคือ: consultant ส่ง report แต่ FDE เขียน production code โดยตรงในระบบลูกค้า และอยู่จนกว่าระบบจะ run ได้จริง [4]

---

### Use Case 1: AI Customer Support Copilot

**โจทย์:** ลูกค้าของ SI Tech บ่นว่า support team ตอบ ticket ช้า, cost ต่อ ticket สูง, รักษา consistency ยาก

**Solution pattern:**

```
User query → LLM Router → [FAQ Bot / Ticket System / Human Escalation]
                              ↓
                     Knowledge Base (RAG)
                              ↓
                     Response + Ticket Update
```

**สิ่งที่ AI Copilot ทำได้:**
- **Automated ticket routing** — จำแนก intent อัตโนมัติ ส่งไปแผนกที่ถูก
- **24/7 FAQ resolution** — ตอบคำถาม tier-1 โดยไม่ต้องพนักงาน
- **Instant knowledge retrieval** — ดึงข้อมูล product manual/policy ได้ทันที
- **Smart escalation** — ส่งต่อ human agent เฉพาะ case ที่ซับซ้อน พร้อม context summary

**ROI ที่วัดได้:** ลด ticket resolution time ได้ 40–70% ลด human escalation ได้ถึง 70% [5] ธุรกิจสามารถ scale ปริมาณ support ได้โดยไม่ต้องเพิ่ม headcount สัดส่วน

**บทบาท intern ที่เกี่ยวข้อง:** AI Engineer (build RAG), Forward Deploy Engineer (deploy in client env), Solutions Engineer (demo + ROI estimate)

---

### Use Case 2: Sales & Proposal Assistant

**โจทย์:** ทีม sales ของ SI Tech ใช้เวลานานสร้าง proposal/BOQ (Bill of Quantities) สำหรับแต่ละ deal เพราะต้องรวบรวมข้อมูล scope, pricing, past projects ด้วยมือ

**Solution pattern:**

```
Deal brief (client requirements) → LLM → Draft Proposal
     ↑                                         ↓
Past proposal DB (RAG)              Review + Edit by Sales
     ↑                                         ↓
Pricing DB + BOM templates          Final Proposal → Client
```

**ความสามารถหลัก:**
- Generate proposal ร่างแรกจาก brief ใน 5–10 นาที (เดิมใช้ 1–2 วัน)
- Pull ข้อมูลจาก past projects ที่คล้ายกัน
- Auto-fill pricing template จาก component/service catalog
- ปรับ tone และ format ตามลูกค้าแต่ละราย

**ตัวเลขอ้างอิง:** Salesforce Einstein GPT ช่วยเพิ่ม lead conversion 34% และ deal closure 28% [6] ส่วน ZoomInfo รายงานว่า proposal generation เป็นหนึ่งใน highest-ROI gen AI use cases ปี 2026 โดย compress จาก days → minutes [6]

**บทบาท intern ที่เกี่ยวข้อง:** AI Engineer (LLM pipeline), Data Engineer (past project DB, pricing catalog)

---

### Use Case 3: Predictive Analytics Dashboard

**โจทย์:** ลูกค้าในอุตสาหกรรม (manufacturing, retail, logistics) มีข้อมูลมหาศาลแต่ยังใช้ Excel forecasting หรือ report แบบ backward-looking

**Solution pattern:**

```
Historical data + External signals → ML Model → Forecast
         ↓                                          ↓
(ERP, IoT, market data, weather)         Embed in ERP/CRM/Pricing
                                                    ↓
                                         Automated Action Trigger
```

**ข้อสังเกตสำคัญ:** งานวิจัยพบว่า **องค์กรที่ embed predictions เข้า workflow จริง (ERP/CRM) ได้ผลลัพธ์ แต่องค์กรที่แค่แสดงบน dashboard ไม่ได้ ROI** [7] คือ AI ต้องเชื่อมกับ decision ที่เกิดขึ้นจริง ไม่ใช่แค่ดูสวย

**Use case ที่ scale ได้สำหรับ SI:**
- **Demand forecasting** สำหรับ manufacturer/retailer — ลด excess inventory 16%+ [7]
- **Risk scoring** สำหรับ project: คาดการณ์ delay/cost overrun ก่อนเกิด
- **Churn prediction** สำหรับ service business — รักษา revenue $100M+ (benchmark SaaS) [7]

**บทบาท intern ที่เกี่ยวข้อง:** Data Engineer (data pipeline, feature store), AI Engineer (model training/serving), Solutions Engineer (PoC demo)

---

### Use Case 4: Document Intelligence & Workflow Automation

**โจทย์:** SI Tech และลูกค้าจมกับ manual document processing — ใบแจ้งหนี้, สัญญา, ใบเสนอราคาจาก supplier, รายงานตรวจรับ — ต้องพิมพ์ข้อมูลเข้าระบบซ้ำๆ

**วิวัฒนาการของ Document Intelligence:**

| ยุค | เทคโนโลยี | ข้อจำกัด |
|-----|-----------|---------|
| Legacy OCR | Template-based extraction | ต้องมี template แต่ละ format |
| ML-based IDP | Pattern recognition + retraining | ต้อง retrain บ่อยเมื่อ format เปลี่ยน |
| **LLM-powered IDP** | Semantic comprehension, zero-config | **เข้าใจ intent ไม่ต้องมี template** |

LLM-powered IDP ทำได้:
- Extract ข้อมูลจาก document layout ใดก็ได้ โดยไม่ต้อง template
- Normalize ข้อมูล (เช่น standardize date format, currency conversion)
- Validate context (เช่น ตรวจว่า invoice amount ตรงกับ PO)
- Route document ไปยัง workflow ที่ถูกต้องอัตโนมัติ

**ตัวเลขอ้างอิง:** LLM-IDP บรรลุ accuracy 95%+ เทียบกับ legacy OCR ที่ 80% [8] ตลาด IDP โต 26%+ ต่อปี องค์กรที่ลงทุน document automation รายงาน ROI 340% [8]

**บทบาท intern ที่เกี่ยวข้อง:** AI Engineer (LLM pipeline, document parsing), Data Engineer (structured output → ERP integration)

---

### Use Case 5: API-based LLM Integration กับระบบเดิม

**โจทย์:** SI Tech ลูกค้ามีระบบ ERP/CRM/HRMS เดิมที่ทำงานดีแต่ยังไม่มี AI layer — อยากเพิ่ม AI features โดยไม่ต้อง rip & replace ระบบหลัก

**Architecture pattern ที่แนะนำ (Model-Agnostic):**

```
Business Application Layer
         ↓
Orchestration Layer (agent framework: LangChain/LlamaIndex)
         ↓
Model Abstraction Layer  ←  swap model โดยไม่กระทบ business logic
         ↓
[OpenAI GPT-4 | Claude | ThaiLLM | Llama local]
         ↓
Governance Layer: PII detection + audit log + compliance check
```

**สิ่งที่ต้องระวัง:**
- **Vendor lock-in** — ถ้า hardcode model เฉพาะราย พอเปลี่ยน model จะ break ทั้ง stack [9]
- **Execution-time governance** — compliance check ต้องรันแบบ real-time ไม่ใช่ afterthought เพราะ shadow AI เป็น regulatory risk [9]
- **Legacy system audit** — ต้อง audit existing API limitations ก่อน integrate ทุกครั้ง [10]
- **ThaiLLM option** — สำหรับ government/regulated clients ที่ต้องการ in-country data control, ThaiLLM accessible via API เป็นทางเลือกที่สำคัญ [11]

**บทบาท intern ที่เกี่ยวข้อง:** AI Engineer (LLM integration), Solutions Engineer (architecture proposal), Forward Deploy Engineer (production deployment + monitoring)

---

### ประโยชน์ของความร่วมมือ: มุมมอง SI Tech

| ประโยชน์ | รายละเอียด |
|---------|-----------|
| **เข้าถึง talent คุณภาพสูง** | Intern จาก Super AI Engineer ผ่านการคัดกรองและ upskilling เข้มข้น ไม่ใช่ fresh graduate ทั่วไป |
| **ทดลอง use case ด้วย cost ต่ำ** | PoC 3–6 เดือนก่อนลงทุน full product; fail fast ด้วย intern cost ไม่ใช่ FTE cost |
| **Scale AI adoption เร็ว** | 5 use cases คือ 5 workstreams ที่รัน parallel ได้ถ้ามี intern ครบ 4 บทบาท |
| **สร้าง value ให้ลูกค้า** | AI features เพิ่ม stickiness และ justify premium pricing |
| **เพิ่มรายได้ AI-driven services** | AI copilot, predictive analytics, IDP เป็น recurring revenue ต่าง one-time project |

## Caveats / Limits

- **ข้อมูลลูกค้า** — use cases หลายตัวต้องเข้าถึง sensitive data; ต้องมี data governance, NDA, และ role-based access ชัดเจนก่อน intern เริ่มงาน
- **Hallucination risk** — LLM-generated proposals/forecasts ต้องผ่าน human review เสมอ อย่า automate สมบูรณ์โดยไม่มี human-in-the-loop ใน high-stakes decisions
- **Latency of legacy integration** — API integration กับระบบเดิม (SAP, Oracle) บางทีซับซ้อนกว่าที่คาด; ควร scope PoC เฉพาะ module ก่อน
- **ThaiLLM maturity** — ThaiLLM ยังอยู่ระหว่างพัฒนา สำหรับ use case ที่ require Thai language precision ต้องทดสอบ performance เทียบ GPT-4/Claude ก่อนตัดสินใจ
- **Intern timeline** — Super AI Engineer internship มี timeline fixed; ต้องวางแผน scope ให้ deliver MVP ได้ใน 3 เดือน ไม่ใช่ full product
- **Integration cost post-PoC** — PoC ง่ายกว่า production integration มาก; budget ต้องรวม cost ของ hardening, monitoring, และ maintenance หลัง PoC จบ

## References

1. [Super AI Engineer Season 6 — Official Site](https://superai.aiat.or.th/en/home/)
2. [Super AI Engineer Season 5 เปิดรับสมัคร — AIAT](https://aiat.or.th/super-ai-engineer-season-5-applications-open/)
3. [What is a Forward Deployed Engineer: The AI Role OpenAI, Anthropic, and Google Are Hiring in 2026 — MarkTechPost](https://www.marktechpost.com/2026/05/20/what-is-a-forward-deployed-engineer-the-ai-role-openai-anthropic-and-google-are-hiring-in-2026/)
4. [Forward Deployed Engineer — Wikipedia](https://en.wikipedia.org/wiki/Forward_Deployed_Engineer)
5. [How to Create an AI Copilot for Smarter Customer Support — CoSupport AI](https://cosupport.ai/articles/llm-powered-ai-copilot-for-customer-support)
6. [LLM for Sales Automation in 2025 — VideoSDK](https://www.videosdk.live/developer-hub/llm/llm-for-sales-automation)
7. [AI Predictive Analytics: 10 High-Value Use Cases (2026) — LatentView](https://www.latentview.com/blog/ai-predictive-analytics-use-cases/)
8. [Intelligent Document Processing with LLM: No Templates — elDoc](https://eldoc.online/blog/intelligent-document-processing-with-llm/)
9. [LLM Integration Services for Enterprise Systems 2026 — Kyanon Digital](https://kyanon.digital/blog/llm-integration-services-for-enterprise-systems/)
10. [Mastering LLM Integration: 6 Steps Every CTO Should Follow — Hatchworks](https://hatchworks.com/blog/gen-ai/llm-integration-guide/)
11. [ThaiLLM: What you need to know about Thailand's homegrown AI project — Thailand NOW](https://www.thailandnow.in.th/innovation-sustainability/thaillm-what-you-need-to-know-about-thailands-homegrown-ai-project/)

## Key Takeaways

- **Super AI Engineer intern** ≠ นักศึกษาฝึกงานทั่วไป — ผ่าน upskilling + hackathon มาแล้ว พร้อม deliver use case จริง
- **FDE เป็น role ที่โตเร็วสุดในวงการ** — เขียน production code ในระบบลูกค้าโดยตรง แตกต่างจาก consultant ที่ส่งแค่ report
- **5 use cases ครอบคลุม revenue, cost, และ efficiency** — AI Customer Support, Sales Proposal, Predictive Analytics, Document Intelligence, LLM API Integration
- **Dashboard ≠ ROI** — Predictive analytics ต้อง embed ใน ERP/CRM workflow ถึงจะสร้าง value; แค่แสดงตัวเลขบนหน้าจอไม่พอ
- **Model-agnostic architecture** คือสิ่งแรกที่ต้องออกแบบ — ป้องกัน vendor lock-in และรองรับ ThaiLLM สำหรับ regulated clients
- **PoC scope ต้องจำกัด** — intern timeline 3 เดือน; วาง MVP scope ชัดก่อนเริ่ม อย่าพยายาม build full product
- ความร่วมมือนี้สร้าง **win-win**: SI Tech ได้ PoC AI solutions ต้นทุนต่ำ + intern ได้ real-world experience จาก production projects จริง
