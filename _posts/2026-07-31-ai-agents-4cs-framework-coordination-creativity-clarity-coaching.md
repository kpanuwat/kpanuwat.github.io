---
title: "4 Cs Framework: ใช้ AI Agents จัดการ Inbox, สร้าง Presentation, วิเคราะห์เอกสาร และซ้อมสัมภาษณ์ด้วย Voice Mode"
date: 2026-07-30 00:01:00 +0700
categories: [Tools]
tags: [ai-agents, productivity, claude, chatgpt, gemini, automation, voice-mode, human-in-the-loop]
slides: true
---

{% include slide-link.html %}

## TL;DR

Sandeep Swadia (อดีต CEO/board member/investor สาย tech กว่า 20 ปี) เสนอ **4 Cs Framework** — Coordination, Creativity, Clarity, Coaching — เป็นระบบคิดสำหรับสร้าง AI agent 4 ตัวที่ใช้ได้กับ Claude, ChatGPT หรือ Gemini ตัวไหนก็ได้ เพื่อจัดการ inbox/calendar, สร้าง presentation deck, วิเคราะห์เอกสารซับซ้อน และซ้อมบทสนทนาสำคัญด้วย voice mode — โดยมนุษย์ยังเป็นคนตัดสินใจสุดท้ายเสมอ

## Background / Why this matters

จุดตั้งต้นของวิดีโอนี้คือตัวเลขจาก Microsoft ที่ชี้ปัญหาการทำงานยุคปัจจุบันตรงๆ: พนักงานทั่วไปได้รับอีเมลเฉลี่ย **117 ฉบับต่อวัน** และถูกขัดจังหวะทุก **2 นาที** ไม่ว่าจะจากอีเมล การประชุม หรือข้อความ — รวมแล้ว **275 ครั้งต่อวัน** (ยังไม่นับ social media) [1][2]

Sandeep บอกว่าปัญหาไม่ได้อยู่ที่ "เครื่องมือ AI" แต่อยู่ที่ "วิธีคิด" — เขาจึงวางกรอบ 4 Cs ขึ้นมาเพื่อให้คนทั่วไปที่ไม่มีพื้นฐานเทคนิคสร้าง agent ได้เอง ทีละขั้น โดยใช้หลักการเดียวกันไม่ว่าจะ deploy บน Claude, ChatGPT หรือ Gemini — ปุ่มกดต่างกัน แต่ workflow เหมือนกัน [1][2]

หัวใจของทุก pillar คือ **prompt ที่มี 5 ส่วน**: job (งานคืออะไร), tool (ใช้เครื่องมือ/ข้อมูลไหน), categories (แบ่งหมวดผลลัพธ์อย่างไร), output (รูปแบบผลลัพธ์), และ boundary (ขอบเขตที่ agent ห้ามข้าม) — ภายใต้ทุก agent คือ loop เดียวกันที่เรียกว่า **ReAct** (Reason → Act → ดูผลลัพธ์ → Reason ต่อ) [3][4]

## Deep Dive

### C ที่ 1 — Coordination: จัดการ Inbox และ Calendar

เป้าหมาย: หยุดให้วันทำงานถูก "จี้" ด้วยการขัดจังหวะตลอดเวลา

ขั้นตอนสร้าง agent (สาธิตด้วย Claude Co-work แต่หลักการเดียวกันใช้กับ ChatGPT/Gemini ได้):

1. เชื่อม Gmail ผ่านเมนู connectors → add connectors → browse → select — นี่คือก้าวแรกจาก "chatbot" สู่ "agent" จริง [3]
2. สั่งงานด้วย prompt 5 ส่วน เช่น: *"Review my unread Gmail from the last 24 hours. Sort it into three buckets: urgent, informational, ignore. For anything urgent draft a reply that sounds like me. Don't send anything without my approval."* [4]
3. เมื่อไว้ใจ output ของ email agent แล้ว ค่อยเชื่อม Google Calendar เพิ่ม แล้วสั่งให้เปรียบเทียบอีเมลด่วนกับตารางนัด เพื่อหา conflict และจัดลำดับงานประจำวัน [4][5]
4. เมื่อไว้ใจทั้งสองระบบแล้ว ตั้ง schedule ให้รันทุกเช้าอัตโนมัติ (ผ่าน schedule tab หรือ schedule command) และค่อยๆ "เลื่อนขั้น" agent ให้ทำหน้าที่เป็น executive assistant เต็มตัว เช่น บล็อกเวลาส่วนตัวให้ไปวิ่งออกกำลังกาย [5]

**บทเรียนสำคัญ**: อย่ามอบอำนาจตัดสินใจให้ agent ทันที — ลำดับที่ถูกต้องคือ **ทำให้เห็น (visible) → ทำให้มีประสิทธิภาพ (efficient) → ทำให้อัตโนมัติ (automatic) → แล้วค่อยมอบอำนาจ (delegate)** ทีละขั้น เหมือนพนักงานที่ต้องพิสูจน์ตัวเองก่อนได้เลื่อนตำแหน่ง [6]

### C ที่ 2 — Creativity: สร้าง Presentation Deck และเอกสาร

เป้าหมาย: แปลง "โน้ตที่ยังไม่เรียบร้อย" ให้เป็นร่างที่พร้อมให้มนุษย์ตัดสิน — โดยมนุษย์ยังเป็น "ผู้กำกับ" เสมอ [6]

วิธีทำ: ชี้ agent ไปยังโฟลเดอร์ที่เก็บโน้ตดิบ แล้วสั่งด้วย prompt skeleton เดิม (job/tool/categories/output/boundary) โดยเน้นที่ส่วน output เป็นพิเศษ เช่น: *"Here are my notes for an idea I want to pitch this to the CFO. Build me a short pitch deck. Ask me questions if you have any gaps in your understanding. I want 8 to 10 slides and I want that pitch to last for maybe 15 minutes."* [7]

จุดสำคัญทางเทคนิค: Claude ใช้กลไกที่เรียกว่า **skills** — ชุดคำสั่งสำเร็จรูปสำหรับงานเฉพาะ (PowerPoint, Word, Excel, PDF) ทำให้ output ที่ได้เป็น**ไฟล์จริง** เปิดแก้ไขต่อใน Microsoft Office ได้เลย ไม่ใช่แค่ข้อความ [8] ผู้ใช้ยังสามารถ:
- ส่ง deck ที่ชอบสไตล์ให้ agent ลอกแบบ
- แปลง brand template ของตัวเองให้กลายเป็น skill ถาวร เพื่อให้ทุก deck/document ในอนาคตใช้สี ฟอนต์ เลย์เอาต์เดียวกันโดยอัตโนมัติ [8]

หลักคิดที่ Sandeep ย้ำ: "ถ้าคุณป้อนความชัดเจนเข้าไป AI จะขยายความชัดเจนนั้น ถ้าคุณป้อนความสับสน AI จะขยายความสับสนนั้น" [9]

### C ที่ 3 — Clarity: วิเคราะห์เอกสารเชิงลึกด้วย Telescope และ Microscope

เป้าหมาย: ช่วยแปล "ภาษาที่จงใจเขียนให้ปกป้องผู้เขียน" ในสัญญา กรมธรรม์ หรือรายงานทางการแพทย์ ให้เข้าใจง่าย [9][10]

Sandeep แบ่งการใช้งานออกเป็น 2 โหมด:

| โหมด | ใช้เมื่อไหร่ | ตัวอย่าง Prompt |
|------|--------------|-------------------|
| **Telescope** | ข้อมูลกระจัดกระจายหลายแหล่ง ต้องรวบรวม | "Find out who they are. Analyze our past emails with them. Find anything recent in the news. Do deep research on their core product from reliable sources. Create a document in my folder and cite the sources." [10][11] |
| **Microscope** | ข้อมูลฝังลึกในเอกสารเดียวที่หนาแน่น | "Read this document carefully. Find the key terms like fee structure, obligations, deadlines, exclusions and risks. Create a table with five columns: what the contract says, what it means in plain English, why it matters, the risk level, the questions I should be asking." [12] |

ข้อควรระวังที่ระบุไว้ชัดเจน: **อย่าขอแค่ "summarize"** สำหรับเอกสารกฎหมาย — สรุปแบบสั้นทำให้เอกสารดูสั้นลงแต่รายละเอียดที่อันตรายมักซ่อนอยู่ในความละเอียด [12]

เทคนิคเสริม: ใช้คำว่า **"please verify"** และ **"be concise"** บ่อยๆ ในโหมด telescope และใช้ AI หลายตัว (Claude, Gemini, ChatGPT) เป็น "personal advisory board" ไขว้ตรวจสอบกันเอง [11] — และสำคัญที่สุดคือ**ไม่อัปโหลดข้อมูลอ่อนไหว** เช่น การเงินส่วนตัวหรือประวัติการแพทย์เข้าไปในระบบเหล่านี้ [12]

### C ที่ 4 — Coaching: ซ้อมสัมภาษณ์และบทสนทนาสำคัญด้วย Voice Mode

เป้าหมาย: ฝึกซ้อมบทสนทนาที่มีโอกาสเดียว (สัมภาษณ์งาน, ขอขึ้นเงินเดือน, พิทช์ดีล) เพื่อลดความกังวลและสร้างความสามารถในการด้นสด [13][14]

จากงานสำรวจของ JDP: **93% ของคนกังวลเรื่องสัมภาษณ์งาน** — และวิธีลดความกังวลที่ได้ผลที่สุดคือ **การซ้อมพูดออกเสียงจริง** [14]

ขั้นตอน:

1. ป้อน context ทั้งหมด — ประวัติบริษัท job description, cover letter, resume [14]
2. กำหนด persona ให้ agent เช่น: *"You are the hiring manager for a senior product role. You are sharp, a little skeptical, and you've read my resume. Ask one question at a time and push back on weak answers."* [14][16]
3. **เปิด voice mode บนมือถือ** (ใช้ได้ทั้ง ChatGPT, Gemini, Claude) แล้วคุยออกเสียงจริงแบบ real-time — ขัดจังหวะได้ ถามกลับได้เหมือนคุยกับคนจริง [16]
4. หลังซ้อมเสร็จ สั่งให้ agent **"break character"** แล้วเปลี่ยนบทบาทเป็น interview coach วิจารณ์จุดอ่อน แนะนำคำตอบที่ดีกว่า [16]
5. ปิดท้ายด้วยการขอให้สร้าง **one-page prep card** สรุปสิ่งที่เรียนรู้ไว้ทบทวนก่อนสัมภาษณ์จริง [15]

Sandeep เล่าด้วยว่า CEO บางคนซ้อม board meeting ทั้งชุดด้วย agent 6-7 ตัวพร้อมกัน แต่ละตัวจำลองบุคลิกของกรรมการแต่ละคน [14] — เป้าหมายไม่ใช่การท่องบทตอบสำเร็จรูป แต่คือการสร้าง "judgment และ taste" ให้ด้นสดได้ในสถานการณ์จริง เหมือนนักดนตรีที่ซ้อมเพื่ออิมโพรไวส์บนเวที [15]

### Human-in-the-loop: หลักการที่ยึดไว้ตลอดทั้ง 4 pillar

Sandeep ย้ำตลอดวิดีโอว่า agent เป็น **multiplier ของ judgment มนุษย์** ไม่ใช่ตัวแทนที่ทำงานอิสระ:

- **Coordination**: ตั้งขอบเขตชัดเจนใน prompt ("Don't send anything without my approval") และปล่อยให้ agent "earn" ความรับผิดชอบสูงขึ้นทีละขั้น ไม่มอบอำนาจทันที [4][6]
- **Creativity**: มนุษย์ยังเป็นผู้กำกับ (director) ที่ตัดสินว่าอะไรใช้ได้ อะไรอ่อน [6][8]
- **Clarity**: ใช้ AI หลายตัวไขว้ตรวจสอบกันเอง และใช้วิจารณญาณเลือกไม่อัปโหลดข้อมูลอ่อนไหว [11][12]
- **Coaching**: เป้าหมายคือสร้างความสามารถของมนุษย์เอง ไม่ใช่สร้างสคริปต์ให้ท่อง [15]

ตัวเลขที่ Sandeep ยกมาปิดท้าย: จากผลสำรวจ **70% ของชาวอเมริกันเชื่อว่า AI จะลดโอกาสงาน** และในกลุ่ม Gen Z ตัวเลขนี้พุ่งเป็น **81%** [17] แต่ข้อสรุปของเขาคือ: ถ้าการแข่งขันคือความเร็วหรือความจำ เครื่องจักรชนะเสมอ — แต่สิ่งที่เครื่องจักรเป็นเจ้าของไม่ได้คือ **attention, creativity, clarity และที่สำคัญที่สุดคือ judgment** [17]

## Caveats / Limits

- Framework นี้สาธิตด้วย Claude Co-work เป็นหลัก แต่ผู้เล่าเน้นว่าใช้หลักการเดียวกันกับ ChatGPT/Gemini ได้ — อินเทอร์เฟซและชื่อฟีเจอร์ (เช่น "skills", "connectors") อาจต่างกันไปตามแพลตฟอร์ม
- การเชื่อม Gmail/Google Calendar ผ่าน connectors ต้องให้สิทธิ์ (permissions) ที่ควรอ่านให้ละเอียดก่อนกด accept — วิดีโอแนะนำให้เริ่มจากโหมด "read and draft only" ไม่ให้ agent ส่งอีเมลหรือย้ายนัดหมายเองในช่วงแรก
- สำหรับเอกสารอ่อนไหว (การเงิน, การแพทย์) วิดีโอแนะนำให้**ไม่อัปโหลด**เข้า AI เลย เป็นเรื่องดุลยพินิจส่วนบุคคลที่ต้องประเมินความเสี่ยงเอง
- เนื้อหาอ้างอิงจากวิดีโอ YouTube เพียงแหล่งเดียว ยังไม่มีการยืนยันตัวเลขสถิติ (Microsoft email study, JDP interview anxiety survey, job-displacement survey) จากแหล่งต้นทางโดยตรงในบทความนี้

## References

1. [How I Use AI Agents to Automate 99% of My Life — Sandeep Swadia (YouTube)](https://youtu.be/TL8V41Ea6oM)
2. Microsoft workplace interruption study, cited in the video above (117 emails/day, interrupted every 2 minutes / 275 times per day)
3. Claude Co-work connectors workflow, demonstrated in the video above
4. Email-agent prompt structure (5-part: job/tool/categories/output/boundary), demonstrated in the video above
5. Calendar-agent integration workflow, demonstrated in the video above
6. "Don't delegate the decision immediately" principle, stated in the video above
7. Creativity-agent (pitch deck) prompt walkthrough, demonstrated in the video above
8. Claude "skills" mechanism for generating real PowerPoint/Word/Excel/PDF files, demonstrated in the video above
9. "AI multiplies your clarity or your confusion" principle, stated in the video above
10. Telescope/Microscope framing for document analysis, stated in the video above
11. Telescope-mode deal-research workflow and "personal advisory board" cross-verification technique, demonstrated in the video above
12. Microscope-mode contract-analysis prompt (5-column risk table) and sensitive-data caution, demonstrated in the video above
13. JDP interview-anxiety survey (93%), cited in the video above
14. Coaching-agent persona setup and voice-mode rehearsal workflow, demonstrated in the video above
15. "Break character" coaching feedback and one-page prep card technique, demonstrated in the video above
16. Voice-mode capability across ChatGPT/Gemini/Claude mobile apps, described in the video above
17. AI job-displacement survey (70% Americans / 81% Gen Z) and closing "attention, creativity, clarity, judgment" framing, stated in the video above

## Key Takeaways

- **4 Cs Framework** = Coordination (inbox/calendar) + Creativity (deck/document generation) + Clarity (deep document analysis) + Coaching (voice-mode rehearsal) — ใช้ได้กับ Claude, ChatGPT, Gemini เหมือนกันทุกตัว
- Prompt ที่ดีมี 5 ส่วนเสมอ: job, tool, categories, output, boundary — และทุก agent วิ่งอยู่บน loop แบบ ReAct (Reason → Act)
- หลักมอบอำนาจที่ถูกต้อง: **visible → efficient → automatic → delegate** ทีละขั้น ห้ามข้ามขั้นตอน
- Clarity pillar แยกเป็น 2 โหมดชัดเจน: **Telescope** (รวบรวมข้อมูลกระจัดกระจาย) กับ **Microscope** (เจาะลึกเอกสารเดียว) — ห้ามใช้ "summarize" เปล่าๆ กับเอกสารกฎหมาย
- Coaching pillar ใช้ voice mode จริงบนมือถือ ไม่ใช่แค่พิมพ์คุย — พร้อมเทคนิค "break character" ให้ agent สลับจากคู่สนทนาเป็นโค้ช
- มนุษย์ยังเป็นศูนย์กลางการตัดสินใจเสมอ: agent เป็น multiplier ของ attention, creativity, clarity และ judgment ที่มนุษย์มีอยู่แล้ว ไม่ใช่ตัวแทนอิสระ
- ข้อมูลอ่อนไหว (การเงิน/การแพทย์) ควรพิจารณาความเสี่ยงก่อนอัปโหลดเข้า AI เสมอ
