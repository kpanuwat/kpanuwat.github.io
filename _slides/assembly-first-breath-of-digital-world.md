---
marp: true
theme: default
paginate: true
title: "Assembly: ลมหายใจแรกของโลกดิจิทัล"
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
  .bento { display:grid; gap:12px; width:100%; align-self:stretch; }
  .bento.cols-2 { grid-template-columns:1fr 1fr; }
  .bento.cols-3 { grid-template-columns:1fr 1fr 1fr; }
  .bento.cols-4 { grid-template-columns:repeat(4,1fr); }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Assembly: ลมหายใจแรกของโลกดิจิทัล

<p class="tag">จาก binary 0/1 สู่ mnemonic ที่มนุษย์อ่านได้ — รากฐานของทุกภาษาโปรแกรม</p>

<!-- Speaker: Assembly คือชั้นแปลชั้นแรกระหว่าง human logic กับ CPU — 7 ทศวรรษยังใช้อยู่ -->

---

## Machine Code → Assembly: การปฏิวัติความอ่านได้

<p class="subhead">แทน binary ด้วย mnemonic — Assembler แปลกลับให้ CPU ก่อนรัน</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- comparison-2col: machine code vs assembly -->
  <rect x="40" y="20" width="460" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <rect x="40" y="20" width="460" height="56" rx="12" fill="#1e293b"/>
  <rect x="40" y="56" width="460" height="20" fill="#1e293b"/>
  <text x="270" y="54" font-size="16" font-weight="700" fill="#94a3b8" text-anchor="middle" font-family="system-ui">Machine Code (Binary)</text>
  <text x="270" y="76" font-size="12" fill="#475569" text-anchor="middle" font-family="system-ui">ก่อนปี 1950 — เขียนด้วยมือทั้งหมด</text>
  <text x="80" y="118" font-size="13" fill="#64748b" font-family="system-ui,monospace">10110000 01100001</text>
  <text x="80" y="148" font-size="13" fill="#64748b" font-family="system-ui,monospace">00000101 00000001</text>
  <text x="80" y="178" font-size="13" fill="#64748b" font-family="system-ui,monospace">11101011 11111110</text>
  <text x="80" y="230" font-size="12" fill="var(--danger)" font-family="system-ui">เกิด error ง่าย, อ่านซ้ำไม่ได้</text>
  <text x="80" y="252" font-size="12" fill="var(--muted)" font-family="system-ui">ช้า, ไม่มีโครงสร้าง</text>

  <!-- arrow in middle -->
  <circle cx="550" cy="160" r="30" fill="var(--accent)"/>
  <text x="550" y="156" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Asm</text>
  <text x="550" y="172" font-size="11" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">bler</text>
  <path d="M500 160 L520 160" stroke="var(--muted)" stroke-width="1.5" fill="none"/>
  <path d="M580 160 L600 160" stroke="var(--muted)" stroke-width="1.5" fill="none"/>

  <rect x="600" y="20" width="460" height="280" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.15))"/>
  <rect x="600" y="20" width="460" height="56" rx="12" fill="var(--accent-deep)"/>
  <rect x="600" y="56" width="460" height="20" fill="var(--accent-deep)"/>
  <text x="830" y="54" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Assembly Mnemonic</text>
  <text x="830" y="76" font-size="12" fill="rgba(255,255,255,.7)" text-anchor="middle" font-family="system-ui">หลังปี 1950 — มนุษย์อ่านได้</text>
  <text x="640" y="118" font-size="14" font-weight="600" fill="var(--accent)" font-family="system-ui,monospace">MOV AL, 97</text>
  <text x="640" y="148" font-size="14" font-weight="600" fill="var(--accent)" font-family="system-ui,monospace">ADD AL, 1</text>
  <text x="640" y="178" font-size="14" font-weight="600" fill="var(--accent)" font-family="system-ui,monospace">JMP $</text>
  <text x="640" y="230" font-size="12" fill="var(--success)" font-family="system-ui">อ่านได้ จำได้ debug ได้</text>
  <text x="640" y="252" font-size="12" fill="var(--muted)" font-family="system-ui">Assembler แปลกลับเป็น binary ให้</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Assembler คือ "ล่าม" ชั้นแรกระหว่างมนุษย์กับ CPU — เปลี่ยน mnemonic → opcode bytes</div>

<!-- Speaker: MOV, ADD, JMP คือ mnemonic — คำย่อที่จำได้ง่ายกว่า binary 8 bits -->

---

## โครงสร้างพื้นฐาน: Registers, Memory, Instructions

<p class="subhead">Assembly ทำงานกับ 3 ส่วนหลักของ CPU ทุกครั้ง</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Registers</p>
    <h3>หน่วยความจำใน CPU</h3>
    <p>เร็วที่สุด — อยู่ภายใน CPU โดยตรง</p>
    <p><code>RAX, RBX, RCX</code> — 64-bit</p>
    <p><code>EAX, EBX, ECX</code> — 32-bit</p>
    <p><code>AL, AH</code> — 8-bit portions</p>
  </div>
  <div class="card success">
    <p class="label">Memory Addressing</p>
    <h3>อ้างอิงตำแหน่งใน RAM</h3>
    <p><code>MOV AX, [1234h]</code></p>
    <p>โหลดค่าจาก address 0x1234</p>
    <p><code>MOV [BX+SI], DX</code></p>
    <p>เก็บค่าที่ address = BX + SI</p>
  </div>
  <div class="card warning">
    <p class="label">Instructions</p>
    <h3>คำสั่งพื้นฐาน</h3>
    <p><code>ADD AX, BX</code> — คำนวณ</p>
    <p><code>CMP AX, 0</code> — เปรียบเทียบ</p>
    <p><code>JE label</code> — กระโดด</p>
    <p><code>CALL fn</code> — เรียกฟังก์ชัน</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Assembly ไม่มี variable name — ทุกอย่างเป็น register หรือ memory address โดยตรง</div>

<!-- Speaker: ความแตกต่างจากภาษาระดับสูง — ไม่มี abstraction ใดๆ คือ CPU โดยตรง -->

---

## Assembler Pipeline: จาก .asm สู่ Executable

<p class="subhead">4 ขั้นตอนจาก source code ไปจนถึง binary ที่ CPU รันได้</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- arrow-flow: 4 steps -->
  <rect x="20" y="70" width="190" height="120" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="115" y="120" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Source</text>
  <text x="115" y="140" font-size="13" fill="var(--accent)" text-anchor="middle" font-family="system-ui,monospace">.asm file</text>
  <text x="115" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">มนุษย์เขียน</text>

  <path d="M215 130 L260 130" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="260,124 272,130 260,136" fill="var(--accent)"/>

  <rect x="272" y="70" width="200" height="120" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(59,130,246,.1))"/>
  <text x="372" y="108" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Assembler</text>
  <text x="372" y="130" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Lex/Parse mnemonics</text>
  <text x="372" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Resolve symbols</text>
  <text x="372" y="170" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Generate opcodes</text>

  <path d="M477 130 L522 130" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="522,124 534,130 522,136" fill="var(--accent)"/>

  <rect x="534" y="70" width="200" height="120" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="634" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Object File</text>
  <text x="634" y="140" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">.o / .obj</text>
  <text x="634" y="162" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">machine code + symbol table</text>

  <path d="M739 130 L784 130" stroke="var(--accent)" stroke-width="2" fill="none"/>
  <polygon points="784,124 796,130 784,136" fill="var(--accent)"/>

  <rect x="796" y="70" width="150" height="120" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 2px 6px rgba(15,23,42,.06))"/>
  <text x="871" y="118" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Linker</text>
  <text x="871" y="145" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">resolve references</text>
  <text x="871" y="165" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">เชื่อม .o หลายไฟล์</text>

  <path d="M951 130 L996 130" stroke="var(--success)" stroke-width="2" fill="none"/>
  <polygon points="996,124 1008,130 996,136" fill="var(--success)"/>

  <rect x="1008" y="85" width="80" height="90" rx="10" fill="var(--success)" style="filter:drop-shadow(0 4px 12px rgba(22,163,74,.2))"/>
  <text x="1048" y="126" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">EXE</text>
  <text x="1048" y="148" font-size="11" fill="rgba(255,255,255,.8)" text-anchor="middle" font-family="system-ui">CPU runs</text>

  <text x="550" y="225" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">ELF (Linux) / PE (Windows) / Mach-O (macOS) — format ต่างกัน ผลเหมือนกัน</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Assembler ทำ 2-pass — pass 1 สร้าง symbol table, pass 2 resolve forward references แล้ว generate opcodes</div>

<!-- Speaker: ทุก compiler ภาษาระดับสูง ผลิต assembly ก่อน แล้วค่อยส่งให้ assembler ต่อ -->

---

## 7 ทศวรรษแห่ง Assembly: IBM ถึง Apollo ถึง UEFI

<p class="subhead">ประวัติศาสตร์ที่พิสูจน์ว่า assembly ไม่เคยตาย — แค่ซ่อนตัวลึกขึ้น</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <!-- timeline -->
  <line x1="80" y1="140" x2="1020" y2="140" stroke="var(--soft-2)" stroke-width="3"/>

  <circle cx="150" cy="140" r="18" fill="var(--accent)"/>
  <text x="150" y="110" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1955</text>
  <text x="150" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">IBM SOAP</text>
  <text x="150" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">IBM 650</text>
  <text x="150" y="211" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Assembler เชิงพาณิชย์</text>

  <circle cx="400" cy="140" r="18" fill="var(--gold)"/>
  <text x="400" y="110" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">1969</text>
  <text x="400" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Apollo 11</text>
  <text x="400" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">MIT / Margaret Hamilton</text>
  <text x="400" y="211" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">4KB RAM, 72KB ROM</text>

  <circle cx="660" cy="140" r="18" fill="var(--accent)"/>
  <text x="660" y="110" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">2000s</text>
  <text x="660" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">BIOS / UEFI</text>
  <text x="660" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">boot stub ยังเป็น asm</text>
  <text x="660" y="211" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">keyboard firmware</text>

  <circle cx="920" cy="140" r="18" fill="var(--success)"/>
  <text x="920" y="110" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">ปัจจุบัน</text>
  <text x="920" y="175" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">SIMD / ISR</text>
  <text x="920" y="193" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">AVX-512, NEON</text>
  <text x="920" y="211" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">exploit research</text>

  <text x="80" y="146" font-size="18" fill="var(--accent)" font-family="system-ui">|</text>
  <text x="1005" y="146" font-size="18" fill="var(--success)" font-family="system-ui">|</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Apollo 11 ลงดวงจันทร์ด้วย assembly ใน 4KB RAM — proof ที่ดีที่สุดว่า assembly ทำได้ทุกอย่าง</div>

<!-- Speaker: Margaret Hamilton เขียนโค้ดทั้งหมดด้วย assembly โดยตรง — ไม่มี high-level language -->

---

## ทำไม Assembly ยังจำเป็นในปี 2026

<p class="subhead">5 use case ที่ compiler ระดับสูงยังทำได้ไม่ดีเท่า</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Boot / Firmware</p>
    <h3>ก่อน OS โหลด</h3>
    <p>ไม่มี runtime library ใดๆ — ต้องเขียน assembly โดยตรง UEFI boot stub, keyboard QMK firmware</p>
  </div>
  <div class="card warning">
    <p class="label">Performance</p>
    <h3>SIMD Optimization</h3>
    <p>AVX-512 / ARM NEON instructions ที่ compiler ไม่ generate ให้ — ต้องเขียน hand-tuned asm สำหรับ ML inference, video codec</p>
  </div>
  <div class="card success">
    <p class="label">Security</p>
    <h3>Exploit Research</h3>
    <p>Reverse engineering ดู disassembler output เป็น assembly, shellcode ต้องการ exact byte control, ISR ต้องการ cycle-exact timing</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> gcc -O3 เก่งมากสำหรับ general code — แต่ boot sector, SIMD, exploit: assembly ยังชนะ</div>

<!-- Speaker: Rust/C เก่งมากแล้ว แต่ยังมี 5 จุดที่ต้องใช้ assembly โดยตรง -->

---

## Key Takeaways — Assembly คือรากฐาน

<p class="subhead">ทุก high-level compiler สุดท้ายผลิต assembly — รู้ assembly หมายถึงรู้ว่าโค้ดเป็นอะไรจริงๆ บน CPU</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">Core Concept</p>
    <h3>Assembly = ชั้นแปลชั้นแรก</h3>
    <p>Mnemonic ที่มนุษย์อ่านได้ → Assembler แปลเป็น binary → CPU รัน</p>
    <p>ทุก C/Rust/Go/Java ผ่าน assembly ก่อนเสมอ</p>
  </div>
  <div class="card warning">
    <p class="label">History</p>
    <h3>7 ทศวรรษที่ไม่ตาย</h3>
    <p>IBM SOAP (1955) → Apollo 11 (1969) → UEFI ปัจจุบัน assembly ยังซ่อนอยู่ในทุกระบบ</p>
    <p>Assemblers: NASM | MASM | GAS | YASM</p>
  </div>
  <div class="card success">
    <p class="label">Still Needed</p>
    <h3>5 จุดที่ยังขาดไม่ได้</h3>
    <p>Boot loader, ISR timing, SIMD (AVX-512/NEON), exploit research, reverse engineering</p>
    <p>gcc -O3 สู้ hand-tuned asm ไม่ได้ใน 5 จุดนี้</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Assembly ไม่ตาย — แค่ซ่อนอยู่ใต้ทุก compiler ทุกตัว รู้ assembly = รู้ว่าโค้ดทำอะไรจริงๆ</div>

<!-- Speaker: ถ้าจำได้อย่างเดียว — ทุก high-level language สุดท้ายเป็น assembly ก่อน CPU รัน -->
