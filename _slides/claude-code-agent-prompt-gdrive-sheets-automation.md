---
marp: true
theme: default
paginate: true
title: "Claude Code 2.1.198: ยกเลิก /agent สร้าง AI Agent ด้วย Prompt"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#3b82f6; --accent-deep:#1e3a8a; --accent-wash:#dbeafe; --gold:#d4af37;
    --danger:#dc2626; --danger-wash:#fee2e2; --danger-ink:#991b1b;
    --success:#16a34a; --success-wash:#dcfce7; --success-ink:#14532d;
    --warning:#f59e0b; --warning-wash:#fef3c7; --warning-ink:#92400e;
    --shadow-sm:0 1px 2px rgba(15,23,42,.06);
    --shadow-md:0 4px 12px rgba(15,23,42,.08);
    --shadow-lg:0 12px 28px rgba(15,23,42,.12);
    --radius:12px; --radius-sm:8px;
  }
  section {
    display:flex; flex-direction:column; justify-content:space-between;
    padding:56px 64px 44px; font-family:system-ui,-apple-system,"Segoe UI",sans-serif;
    color:var(--ink); position:relative;
  }
  section::before {
    content:''; position:absolute; top:28px; left:64px;
    width:40px; height:3px; background:var(--accent); border-radius:2px;
  }
  section h2 { font-size:28px; margin:0 0 4px; color:var(--ink); font-weight:700; }
  .subhead { color:var(--ink-dim); font-size:15px; margin:0 0 8px; }
  .infographic { flex:1; display:flex; align-items:center; justify-content:center; min-height:0; }
  .takeaway {
    border-left:4px solid var(--accent); background:var(--soft);
    padding:12px 18px; border-radius:0 var(--radius-sm) var(--radius-sm) 0;
    font-size:14px; line-height:1.5;
  }
  .takeaway b { color:var(--accent); }
  .card {
    background:var(--paper); border-radius:var(--radius);
    box-shadow:var(--shadow-md); padding:18px 20px;
    border-left:4px solid var(--accent); box-sizing:border-box;
  }
  .card.success { border-left-color:var(--success); }
  .card.danger  { border-left-color:var(--danger); }
  .card.warning { border-left-color:var(--warning); }
  .card.gold    { border-left-color:var(--gold); }
  .card .label { font-size:10px; letter-spacing:.08em; text-transform:uppercase; color:var(--muted); margin:0 0 4px; }
  .card h3 { margin:0 0 6px; font-size:17px; color:var(--ink); font-weight:700; }
  .card p  { margin:0 0 4px; font-size:13px; color:var(--ink-dim); line-height:1.5; }
  .card ul { margin:0; padding-left:16px; font-size:13px; color:var(--ink-dim); line-height:1.9; }
  .card.compact { padding:10px 14px; }
  .card.compact h3 { font-size:14px; margin-bottom:4px; }
  .card.compact p, .card.compact .label { font-size:11px; }
  .bento { display:grid; gap:12px; width:100%; align-self:stretch; align-content:start; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  .flow-row { display:flex; align-items:center; gap:6px; width:100%; }
  .flow-arrow { font-size:22px; color:var(--muted); flex-shrink:0; }
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:17px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/claude-code-agent-prompt-gdrive-sheets-automation-cover.png)

<div class="mark"></div>

# Claude Code 2.1.198: ยกเลิก /agent สร้าง AI Agent ด้วย Prompt

<p class="tag">Use Case: อ่านใบเสร็จ PDF จาก Google Drive → กรอก Google Sheets อัตโนมัติ</p>

<!-- Speaker: เกริ่นว่า /agents wizard ถูกถอดออกแล้วใน 2.1.198 วันนี้จะดู workflow ใหม่ผ่าน use case จริง -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/claude-code-agent-prompt-gdrive-sheets-automation-cheatsheet.png)

<!-- Speaker: ภาพรวมทั้ง 7 concept ของ workflow ใหม่ก่อนลงรายละเอียดทีละส่วน -->

---

## TL;DR

<p class="subhead">สรุปสั้นก่อนลงรายละเอียด</p>

<div class="infographic">
<div class="card gold" style="max-width:900px;">
<p class="label">Key Fact</p>
<h3 style="font-size:22px;">/agents wizard ถูกถอดออกใน 2.1.198 (2 ก.ค. 2026)</h3>
<p style="font-size:16px;">วิธีสร้าง subagent ใหม่คือ <b>พิมพ์ prompt บอก Claude ตรงๆ</b> — ไฟล์ agent ที่ได้ยังเป็น Markdown + YAML frontmatter ใน <code>.claude/agents/</code> เหมือนเดิมทุกประการ ใช้จริงผ่าน use case: สร้าง "expense subagent" อ่านใบเสร็จ PDF จาก Google Drive แล้วกรอกลง Google Sheets อัตโนมัติ</p>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> UI เปลี่ยนจาก wizard เป็น conversational prompt แต่สถาปัตยกรรม agent เบื้องหลังไม่เปลี่ยน</div>

<!-- Speaker: ย้ำว่านี่ไม่ใช่การตัดฟีเจอร์ subagent ทิ้ง แค่เปลี่ยนวิธีสร้าง -->

---

## สิ่งที่เปลี่ยนจริงใน 2.1.198

<p class="subhead">ถอด wizard ทิ้ง แต่สถาปัตยกรรม agent เดิมไม่กระทบ</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Removed</p>
    <h3>/agents wizard ถูกถอด</h3>
    <p>พิมพ์ /agents ตอนนี้ขึ้นข้อความแจ้งว่าคำสั่งถูก remove แล้ว</p>
  </div>
  <div class="card success">
    <p class="label">Replaced By</p>
    <h3>สร้าง agent ด้วย Prompt</h3>
    <p>พิมพ์อธิบาย agent ที่ต้องการตรงๆ ได้ทั้งไทย/อังกฤษ (อังกฤษประหยัด token กว่า)</p>
  </div>
  <div class="card gold">
    <p class="label">Unchanged</p>
    <h3>โครงสร้างไฟล์เดิม</h3>
    <p><code>.claude/agents/*.md</code> + YAML frontmatter เหมือนเดิม มีผลทันทีไม่ต้อง restart</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เปลี่ยนแค่ UI การสร้าง agent จาก wizard เป็น prompt เท่านั้น</div>

<!-- Speaker: เน้นว่าคู่มือเก่าที่สอนกด /agents ใช้ไม่ได้แล้ว ต้องปรับ workflow -->

---

## สร้าง Subagent แบบใหม่ด้วย Prompt

![bg right:40% contain](assets/claude-code-agent-prompt-gdrive-sheets-automation-prompt-creation.png)

<p class="subhead">อธิบายสิ่งที่ต้องการตรงๆ แทนการกด wizard ทีละขั้น</p>

<div class="infographic">
<div class="card compact" style="max-width:560px;">
<p class="label">Prompt Example</p>
<p style="font-size:14px;">"create a subagent that reads receipts and logs expenses"</p>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Claude generate ไฟล์ .md ให้เอง พร้อม identifier, description, tool permissions, model, system prompt</div>

<!-- Speaker: ชี้ portrait ด้านขวาว่า flow นี้แทนที่ wizard เดิมทั้งหมด -->

---

## Use Case: ตั้งค่า "Expense Subagent"

<p class="subhead">อ่านใบเสร็จจากโฟลเดอร์ Google Drive แล้วกรอกลง Google Sheet ตามคอลัมน์ที่กำหนด</p>

<div class="infographic" style="align-items:stretch;">
<div class="flow-row">
  <div class="card compact" style="flex:1;">
    <p class="label">1</p>
    <h3>โฟลเดอร์ Google Drive</h3>
    <p>เก็บใบเสร็จ/ใบแจ้งหนี้ แยกตามเดือน (ต้องเชื่อม Connector ไว้ก่อน)</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">2</p>
    <h3>Prompt สร้าง agent</h3>
    <p>วางลิงก์โฟลเดอร์ Drive + ลิงก์ Google Sheet เข้าไปใน prompt</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">3</p>
    <h3>ระบุคอลัมน์</h3>
    <p>เดือน, section, รายละเอียด, จำนวนเงิน, vendor, วันที่จ่าย</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">4</p>
    <h3>Claude ถามกลับ</h3>
    <p>ถามวิธีเขียนข้อมูลกลับเข้า Sheet เดิม</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> วาง prompt ให้ครบทั้ง input (Drive) + output (Sheet) + คอลัมน์ ตั้งแต่ตอนสร้าง agent</div>

<!-- Speaker: เน้นว่าต้องเชื่อม Google Drive Connector ไว้ล่วงหน้าก่อนถึงจะใช้ flow นี้ได้ -->

---

## ทำไมต้องใช้ Google Apps Script

<p class="subhead">Connector อ่านไฟล์ได้ แต่แก้ไฟล์ Sheet ที่มีอยู่แล้วไม่ได้ — มี 3 ทางเลือก</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card success">
    <p class="label">Option 1 · Recommended</p>
    <h3>Google Apps Script</h3>
    <p>เขียน/append เข้า Sheet เดิมได้ตรงๆ ต้อง setup เพิ่มหน่อยตอนแรก</p>
  </div>
  <div class="card warning">
    <p class="label">Option 2</p>
    <h3>Export เป็น CSV</h3>
    <p>agent สรุปผลเป็นไฟล์ ผู้ใช้ต้อง copy ไปวางใน Sheet เอง</p>
  </div>
  <div class="card warning">
    <p class="label">Option 3</p>
    <h3>สร้าง Sheet ใหม่ทุกครั้ง</h3>
    <p>connector สร้างไฟล์ใหม่ได้ แต่ได้ Sheet ใหม่ทุกครั้งที่เรียก agent</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> เลือก Apps Script เพราะเป็นทางเดียวที่ append เข้า Sheet เดิมได้ต่อเนื่อง</div>

<!-- Speaker: อธิบายว่า connector ของ Claude ตามเอกสารทางการคือ read-only จริงๆ ส่วนพฤติกรรมสร้างไฟล์ใหม่เป็นสิ่งที่ผู้ทำคลิปสังเกตจากการใช้งานจริง -->

---

## Deploy Apps Script แล้วเรียกใช้งาน

<p class="subhead">Claude ให้ขั้นตอน step-by-step แล้วขอข้อมูลกลับ 2 อย่างเพื่อเชื่อมต่อ</p>

<div class="infographic" style="align-items:stretch;">
<div class="flow-row">
  <div class="card compact" style="flex:1;">
    <p class="label">1</p>
    <h3>วาง Script ลง Sheet</h3>
    <p>ทำตามขั้นตอน 1-2-3-4 ที่ Claude ให้มา</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">2</p>
    <h3>ส่ง URL + Token</h3>
    <p>Web App URL และ Secret Token กลับเข้าไปในแชท</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">3</p>
    <h3>ทดสอบแถว Test</h3>
    <p>agent เขียนแถว "Test" ยืนยันว่าเชื่อมต่อสำเร็จ แล้วลบทิ้ง</p>
  </div>
  <div class="flow-arrow">&#8594;</div>
  <div class="card compact" style="flex:1;">
    <p class="label">4</p>
    <h3>เรียกใช้งาน</h3>
    <p><code>@expense</code> บันทึกใบเสร็จเดือน 6 (วิธีเรียกเหมือนเดิมทุกประการ)</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Secret Token คือกุญแจเข้าถึง Sheet — เก็บเป็นความลับเหมือน API key</div>

<!-- Speaker: ย้ำเรื่องความปลอดภัยของ token ก่อนย้ายไป slide ถัดไป -->

---

## Human-in-the-Loop: Agent หยุดถามเมื่อข้อมูลไม่พอ

<p class="subhead">บันทึกใบเสร็จทั้งปีทีเดียว 21 รายการ — ผลลัพธ์ไม่ใช่ 100% แต่โปร่งใส</p>

<div class="infographic">
<div style="display:flex; flex-direction:column; align-items:center; gap:20px; width:100%;">
<svg viewBox="0 0 1100 220" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="220" cy="110" r="80" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="2"/>
  <text x="220" y="100" font-size="40" font-weight="800" fill="var(--ink)" text-anchor="middle" font-family="system-ui">21</text>
  <text x="220" y="135" font-size="14" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">total</text>
  <circle cx="550" cy="110" r="80" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <text x="550" y="100" font-size="40" font-weight="800" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">17</text>
  <text x="550" y="135" font-size="14" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">success</text>
  <circle cx="880" cy="110" r="80" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="2"/>
  <text x="880" y="100" font-size="40" font-weight="800" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">4</text>
  <text x="880" y="135" font-size="14" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">failed</text>
</svg>
<div class="bento cols-2">
  <div class="card compact danger">
    <p class="label">เหตุผลที่ fail</p>
    <p>สลิปโอนเงินไม่ระบุว่าจ่ายค่าอะไร</p>
  </div>
  <div class="card compact danger">
    <p class="label">เหตุผลที่ fail</p>
    <p>ใบเสร็จสกุลเงิน USD แปลงเป็น THB ไม่ได้อัตโนมัติ</p>
  </div>
</div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent ที่ดีหยุดถามเมื่อข้อมูลไม่พอ ไม่เดาตัวเลขการเงินเอง</div>

<!-- Speaker: agent เสนอ 2 ทาง ข้ามรายการไปก่อน หรือให้ผู้ใช้ระบุอัตราแลกเปลี่ยนเอง -->

---

## Agent ปรับปรุงความสามารถของตัวเอง

![bg right:40% contain](assets/claude-code-agent-prompt-gdrive-sheets-automation-self-updating.png)

<p class="subhead">ลากไฟล์ PDF local วางใน terminal — agent แก้ config ตัวเองก่อนทำงานต่อ</p>

<div class="infographic">
<div class="card compact gold" style="max-width:560px;">
<p class="label">Self-update</p>
<p style="font-size:14px;">Claude สังเกตว่านี่คือ input ประเภทใหม่ (ไฟล์ local ไม่ใช่ Google Drive) จึงแก้ไฟล์ <code>expense.md</code> เพิ่มความสามารถ "อ่านไฟล์แนบโดยตรง" ก่อน แล้วค่อยกลับมาทำงานที่ขอ</p>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Subagent แบบ prompt-based ขยายความสามารถตัวเองได้ตามการใช้งานจริง ไม่ใช่แค่ทำตาม spec เดิมตลอดไป</div>

<!-- Speaker: จุดนี้คือไฮไลต์ของคลิป — agent ปรับตัวเองโดยไม่ต้องสั่งตรงๆ -->

---

## Caveats / Limits

<p class="subhead">สิ่งที่ต้องระวังก่อนใช้งานจริง</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Connector Behavior</p>
    <h3>เอกสารทางการระบุ read-only</h3>
    <p>พฤติกรรม "สร้างไฟล์ใหม่ได้" ในคลิปเป็นการสังเกตจากดีโม ไม่ใช่ spec ยืนยัน — ทดสอบเองก่อนพึ่งพา</p>
  </div>
  <div class="card danger">
    <p class="label">Security</p>
    <h3>Secret Token = กุญแจ Sheet</h3>
    <p>รั่วไหลแล้วมีคนเขียนข้อมูลปลอมลง Sheet ได้ ห้าม commit เข้า git</p>
  </div>
  <div class="card warning">
    <p class="label">Currency</p>
    <h3>แปลงสกุลเงินไม่อัตโนมัติ</h3>
    <p>USD หรือสกุลอื่นถูกข้าม หรือต้องผู้ใช้ระบุอัตราแลกเปลี่ยนเอง</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> docs บางหน้าของ Anthropic เองยังไม่อัปเดตตาม 2.1.198 — เจอ doc เก่าให้เชื่อพฤติกรรมจริงมากกว่า</div>

<!-- Speaker: เตือนเรื่อง GitHub issue ที่ยังไม่ fix quickstart -->

---

## Key Takeaways

<p class="subhead">สิ่งที่ต้องจำถ้าอ่านแค่หน้านี้หน้าเดียว</p>

<div class="infographic">
<div class="bento cols-2">
  <div class="card compact success">
    <h3>ถอด /agents wizard</h3>
    <p>สร้าง subagent ใหม่ต้อง prompt ตรงๆ หรือแก้ไฟล์ .claude/agents/*.md เอง</p>
  </div>
  <div class="card compact gold">
    <h3>Use case จริง</h3>
    <p>expense subagent: PDF จาก Google Drive → Google Sheets ผ่าน Apps Script</p>
  </div>
  <div class="card compact danger">
    <h3>Human-in-the-loop</h3>
    <p>agent หยุดถามเมื่อสกุลเงิน/ข้อมูลไม่พอ ไม่เดาตัวเลขการเงินเอง</p>
  </div>
  <div class="card compact">
    <h3>Self-updating</h3>
    <p>agent ขยายความสามารถตัวเองได้จาก pattern งานใหม่ที่เจอ</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Secret Token เก็บเป็นความลับเหมือน API key; prompt ภาษาอังกฤษประหยัด token กว่าไทยสำหรับสร้าง agent ซ้ำๆ</div>

<!-- Speaker: ปิดท้ายด้วยการย้ำว่าคู่มือเก่าที่สอน /agents ใช้ไม่ได้แล้ว -->
