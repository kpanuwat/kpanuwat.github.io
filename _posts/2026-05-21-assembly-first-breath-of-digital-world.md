---
title: "Assembly: ลมหายใจแรกของโลกดิจิทัล"
date: 2026-05-21 12:00:00 +0700
categories: [Engineering]
tags: [assembly, systems-programming, hardware, low-level, computer-science]
---

## TL;DR

Assembly Language คือภาษาโปรแกรมที่แปลงรหัสไบนารีอันซับซ้อนให้เป็นสัญลักษณ์ที่มนุษย์อ่านได้ผ่านโปรแกรม Assembler เป็นรากฐานที่วางอยู่ใต้ภาษาโปรแกรมทุกภาษาในโลก และยังคงเป็นหัวใจของ firmware, boot process, และ system-level code จนถึงปัจจุบัน

## Background / Why This Matters

ก่อนจะมี Assembly โปรแกรมเมอร์ยุคแรกต้องเขียน **machine code** โดยตรง — ลำดับของ `0` และ `1` ที่ CPU เข้าใจ เช่น `10110000 01100001` (x86 สำหรับ "ใส่ค่า 97 ลง register AL") การเขียนแบบนี้ช้า เกิด error ง่าย และไม่มีโครงสร้างใดๆ ที่ช่วยให้อ่านซ้ำได้

**Assembly Language** ถูกพัฒนาขึ้นในช่วงปลายทศวรรษ 1940 โดยแนวคิดหลักคือแทนที่ opcode ด้วย **mnemonic** — คำย่อที่จำได้ง่าย:

| Machine Code (binary) | Assembly Mnemonic | ความหมาย |
|-----------------------|-------------------|-----------|
| `10110000 01100001`   | `MOV AL, 97`      | ใส่ค่า 97 ลง AL |
| `00000101 00000001`   | `ADD AL, 1`       | บวก 1 เข้า AL |
| `11101011 11111110`   | `JMP $`           | วนลูปตลอดไป |

โปรแกรม **Assembler** ทำหน้าที่แปล mnemonic เหล่านี้กลับเป็น binary ที่ CPU รัน — เป็นการสร้าง "ล่าม" ชั้นแรกระหว่างมนุษย์กับเครื่องจักร

## Deep Dive

### โครงสร้างพื้นฐาน

Assembly code ทำงานกับ 3 ส่วนหลักของ CPU:

**Registers** — หน่วยความจำขนาดจิ๋วภายใน CPU เข้าถึงเร็วที่สุด
```nasm
; x86-64 general-purpose registers
RAX, RBX, RCX, RDX   ; 64-bit
EAX, EBX, ECX, EDX   ; 32-bit (ส่วนล่างของ 64-bit)
AL, AH                ; 8-bit (ส่วนล่างของ EAX)
```

**Memory Addressing** — อ้างอิงตำแหน่งใน RAM:
```nasm
MOV AX, [1234h]       ; โหลดค่าจาก address 0x1234
MOV [BX + SI], DX     ; เก็บค่าที่ address = BX + SI
```

**Instructions** — คำสั่งพื้นฐาน:
```nasm
; คำนวณ
ADD AX, BX            ; AX = AX + BX
SUB AX, 5             ; AX = AX - 5
MUL BX                ; AX = AX * BX (unsigned)

; เปรียบเทียบและกระโดด
CMP AX, 0             ; compare AX กับ 0 (set flags)
JE  label             ; กระโดดไป label ถ้า equal
JNE other_label       ; กระโดดถ้า not equal
```

### Assembler ทำงานอย่างไร

```
Source (.asm) ──▶ Assembler ──▶ Object File (.o) ──▶ Linker ──▶ Executable
                                    │
                           symbol table + machine code
```

1. **Lexing / Parsing** — แยก mnemonic, operand, label
2. **Symbol Resolution** — แก้ label address (2 passes สำหรับ forward reference)
3. **Code Generation** — แปลแต่ละ mnemonic เป็น opcode bytes
4. **Object File Output** — เขียน ELF / COFF / Mach-O section

### ในประวัติศาสตร์

**Mainframe Era (1950s):** IBM พัฒนา SOAP (Symbolic Optimizer and Assembly Program) ในปี 1955 สำหรับ IBM 650 — หนึ่งใน assembler ยุคแรกที่ใช้เชิงพาณิชย์จริง

**Apollo Guidance Computer (1969):** ทีม MIT ของ Margaret Hamilton เขียน software นำยาน Apollo 11 ลงดวงจันทร์ด้วย assembly language โดยตรง ขนาด memory เพียง 4 KB RAM และ 72 KB ROM ไม่มีที่ให้ overhead ของภาษาระดับสูง

**Modern Firmware:** UEFI/BIOS boot stub, keyboard firmware (เช่น QMK), GPU shader compiler runtime, และ OS kernel interrupt handlers ล้วนมี assembly code ฝังอยู่

### ทำไมยังใช้ในยุคปัจจุบัน

แม้ภาษา C, Rust, Go จะ compile ได้ใกล้เคียง optimal แต่ assembly ยังจำเป็นใน:

| Use Case | เหตุผล |
|----------|--------|
| **Boot loader** | ก่อน OS โหลด ไม่มี runtime library ใดๆ |
| **Interrupt Service Routine** | ต้องการ cycle-exact timing |
| **SIMD optimization** | ใช้ AVX-512/NEON instruction ที่ compiler ไม่ generate ให้ |
| **Exploit / Shellcode research** | เข้าใจ memory layout ระดับ opcode |
| **Reverse engineering** | disassembler output คือ assembly |

### Assembler ยอดนิยม

| Assembler | Platform | Syntax |
|-----------|----------|--------|
| NASM      | x86/x64 cross-platform | Intel |
| MASM      | Windows x86/x64 | Intel |
| GAS (GNU) | Linux (part of binutils) | AT&T |
| YASM      | x86/x64 multi-syntax | Intel / AT&T |

## Caveats / Limits

- **Portability = 0:** x86 assembly ใช้ใน ARM ไม่ได้เลย — เขียนใหม่ทั้งหมด
- **Productivity ต่ำมาก:** โค้ด 5 บรรทัด C อาจต้องเขียน 50 บรรทัด assembly
- **Debug ยาก:** ไม่มี type system, ไม่มี variable names (ถ้าไม่นับ debug symbol)
- **Modern compiler เก่งมาก:** `gcc -O3` มักให้ output ที่ดีกว่า hand-written assembly สำหรับ general-purpose code
- **Security risk:** buffer overflow, off-by-one ใน manual pointer arithmetic เกิดง่ายมาก

## References

1. IBM SOAP Assembler — IBM 650 documentation, Computer History Museum: [https://computerhistory.org](https://computerhistory.org)
2. Margaret Hamilton, Apollo Guidance Computer software — NASA Technical Report: [https://www.nasa.gov/history/alsj/a11/a11.landing.html](https://www.nasa.gov/history/alsj/a11/a11.landing.html)
3. NASM Documentation: [https://www.nasm.us/doc/](https://www.nasm.us/doc/)
4. x86 Instruction Set Reference (Intel): [https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
5. "Assembly: ลมหายใจแรกของโลกดิจิทัล" (YouTube): [https://youtu.be/KGE36hkLsZc](https://youtu.be/KGE36hkLsZc)

## Key Takeaways

- Assembly คือ "ชั้นแปล" ชั้นแรกระหว่าง human logic กับ machine code — Assembler แปลง mnemonic → binary ก่อน CPU รัน
- ประวัติศาสตร์ครอบ 7 ทศวรรษ: mainframe IBM 650 → Apollo 11 → ยุค UEFI ปัจจุบัน
- แม้ภาษาระดับสูงจะแพร่หลาย แต่ assembly ยังขาดไม่ได้ใน 5 จุด: boot loader, ISR, SIMD, exploit research, reverse engineering
- x86 (Intel/AT&T syntax), ARM (AArch64), RISC-V คือ 3 สถาปัตยกรรมหลักที่ assembly ยังถูกเขียนถึงประจำในปี 2025
- ทุก high-level compiler สุดท้ายผลิต assembly ก่อน — รู้ assembly หมายถึงรู้ว่าโค้ดของคุณ "เป็นอะไร" จริงๆ บน CPU
