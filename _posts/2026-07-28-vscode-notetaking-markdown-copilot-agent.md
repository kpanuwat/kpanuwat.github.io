---
title: "เจาะลึก VS Code สำหรับจดโน้ตและเขียน Markdown พร้อม GitHub Copilot Agent"
date: 2026-07-27 00:03:00 +0700
categories: [Tools]
tags: [vscode, markdown, github-copilot, note-taking, productivity]
---

## TL;DR

VS Code ไม่ได้มีไว้แค่เขียนโค้ด — ใช้จดโน้ตและเขียน Markdown ได้อย่างมีประสิทธิภาพด้วย side-by-side preview, voice dictation, checklist, extensions และ theme ที่ปรับแต่งได้เต็มที่ ส่วน GitHub Copilot Agent mode ช่วยสแคฟฟอลด์ไฟล์ สร้างตาราง วิเคราะห์ release notes และแนะนำไอเดียคอนเทนต์แบบอัตโนมัติ

## Background / Why this matters

VS Code ถูกออกแบบมาเป็น code editor แต่ปีหลังๆ Microsoft ผลักดัน use case "non-devs" มากขึ้น — คนที่อยากใช้ VS Code จดโน้ต เขียน documentation หรือจัดการ Markdown files แทนที่จะสลับไปใช้ Notion หรือ Obsidian [1]. เหตุผลหลักคือ VS Code เป็น local-first, ไฟล์เป็น plain text (`.md`) ที่ portable, และ ecosystem extension ใหญ่พอที่จะเติมฟีเจอร์ note-taking app ให้ครบ (preview, checklist, dictation, theming) โดยไม่ต้อง lock-in กับ platform ใด

พอผนวกกับ GitHub Copilot ที่ตอนนี้มี **Agent mode** — ไม่ใช่แค่ autocomplete แต่ทำ multi-step task ได้ (อ่านโค้ดเบส, เสนอ edit หลายไฟล์, รัน terminal command) [2][3] — VS Code เลยกลายเป็นทั้ง note-taking tool และ AI-assisted content workflow ในตัวเดียว เหมาะกับคนที่ทำงานเอกสารเยอะ (README, release notes, spec) แต่ไม่อยากพิมพ์ทุกอย่างเอง

## Deep Dive

### 1. Side-by-side Markdown Preview

กด `Ctrl+K V` (Mac: `Cmd+K V`) เพื่อเปิด preview คู่กับไฟล์ editor แบบ split pane — พิมพ์ฝั่งซ้าย เห็นผล render ฝั่งขวาแบบ real-time [4]. ต่างจาก `Ctrl+Shift+V` ที่เปิด preview เต็มจอแทนที่ editor tab

### 2. Checklist / Task List

Markdown task list syntax (`- [ ]`, `- [x]`) render เป็น checkbox ทั้งใน editor และ preview แต่ **ค่า default ของ VS Code ไม่ interactive** — คลิก checkbox ใน preview ไม่ toggle สถานะให้ [5][6]. ถ้าต้องการคลิกแล้ว sync กลับไฟล์จริง ต้องติดตั้ง extension เช่น Markdown Checkbox Preview ที่ทำ live-sync ระหว่าง preview กับ source file [6]

### 3. Voice Dictation

Microsoft มี **VS Code Speech extension** (ฟรี, ทำงาน on-device) เพิ่ม dictation ให้ทั้ง editor ทั่วไปและ Copilot Chat panel รวมถึง wake-word "Hey Code" [7]. ไอคอนไมโครโฟนใน Copilot Chat จะแสดงตลอดเวลาแล้ว (ไม่ต้องเปิด flag) แต่มีข้อจำกัด: **Agent mode window ไม่มีปุ่ม microphone** — dictation ใช้ได้เฉพาะ Copilot Chat panel ปกติ ไม่รองรับใน Agent window โดยตรง [7][8]

### 4. Markdown Extensions

| Extension | จุดเด่น |
|---|---|
| Markdown All in One | keyboard shortcuts, auto-preview, table formatting — ยอดติดตั้งสูงสุด (5M+) [4] |
| Markdown Preview Enhanced | เพิ่ม diagram (Mermaid, PlantUML), math equation, presentation mode [4] |
| markdownlint | ตรวจ style ก่อนโค้ด/เอกสารเข้า production [4] |

### 5. Theme Customization

ปรับ theme ได้ 2 ระดับ: (1) เปลี่ยน color theme จาก Marketplace ผ่าน Command Palette → "Preferences: Color Theme", (2) fine-tune สีเฉพาะจุดผ่าน `workbench.colorCustomizations` ใน `settings.json` — เช่นเปลี่ยนสี title bar เฉพาะ โดยไม่ต้องสร้าง theme ใหม่ทั้งชุด [9]:
```json
{
  "workbench.colorCustomizations": {
    "titleBar.activeBackground": "#ff0000"
  }
}
```
รองรับ hex format `#RGB`, `#RGBA`, `#RRGGBB`, `#RRGGBBAA` และใช้ wildcard ชื่อ theme เพื่อให้ customization ใช้ได้กับหลาย theme พร้อมกัน [9]

### 6-9. GitHub Copilot Agent Mode

Agent mode เปิดจาก Copilot Edits view → เลือก "Agent" จาก mode dropdown [2][3] ความสามารถหลักที่เกี่ยวกับงานเอกสาร/โน้ต:

- **Scaffold ไฟล์**: สั่ง prompt เดียวให้ Agent สร้างไฟล์ใหม่, จัดโครงสร้าง section, หรือ scaffold ทั้งฟีเจอร์จากคำอธิบายเดียว — Agent วิเคราะห์โค้ดเบสที่มีอยู่ก่อนเสนอไฟล์ [2][3]
- **สร้างตาราง**: แปลง CSV เป็น Markdown table ที่จัด alignment ถูกต้อง แล้วบันทึกลงตำแหน่งที่ต้องการ — ใช้ได้กับงาน content ที่ต้องแปลงข้อมูลดิบเป็นตารางอ่านง่าย [3]
- **วิเคราะห์ Release Notes**: ตั้ง prompt file แบบ `/release-notes` ที่ตาม format changelog คงที่ ดึง context จาก commit ล่าสุดมาสรุปอัตโนมัติ [3]
- **แนะนำไอเดียคอนเทนต์**: เพราะ Agent อ่านโค้ดเบส/ไฟล์ที่เกี่ยวข้องก่อนเสนอ edit มันจึงต่อยอดแนะนำ section หรือหัวข้อที่ยังขาดในเอกสารได้ระหว่างทำ multi-file change [3]

## User Guide (Step-by-Step)

1. **เปิด side-by-side preview**: เปิดไฟล์ `.md` → `Ctrl+K V` → editor แบ่งครึ่งจอ preview ขวา sync ตามการพิมพ์ทันที
2. **ติดตั้ง extension พื้นฐาน**: `Ctrl+Shift+X` → ค้นหา "Markdown All in One" → Install → รีสตาร์ท VS Code ถ้า preview ยังไม่เปลี่ยน
3. **เปิด voice dictation**: ติดตั้ง extension "VS Code Speech" จาก Marketplace → เปิด Copilot Chat panel (ไม่ใช่ Agent window) → คลิกไอคอนไมค์ → พูดแทนพิมพ์
4. **ทำ interactive checklist**: ติดตั้ง "Markdown Checkbox Preview" → เปิด preview → คลิก checkbox ตรงๆ ใน preview pane → สถานะ sync กลับไฟล์ `.md` อัตโนมัติ
5. **ปรับ theme เฉพาะจุด**: `Ctrl+Shift+P` → "Preferences: Open User Settings (JSON)" → เพิ่ม key `workbench.colorCustomizations` → save → เห็นผล live ไม่ต้อง reload
6. **ใช้ Copilot Agent scaffold**: เปิด Copilot Edits view → เลือก mode "Agent" → พิมพ์ prompt เช่น "สร้างไฟล์ README section ใหม่สำหรับ API reference" → รีวิว diff ที่ Agent เสนอก่อนกด Accept
7. **สร้างตารางจาก CSV**: ใน Agent mode พิมพ์ "อ่านไฟล์ data.csv แล้วแปลงเป็น Markdown table บันทึกลง docs/table.md" → ตรวจ alignment ก่อน commit

## Caveats / Limits

- Checklist ใน preview ค่า default **คลิกไม่ได้** — ต้องพึ่ง extension เสมอ ไม่ใช่ built-in behavior [5][6]
- Voice dictation ใน **Agent window ยังไม่รองรับ** ต้องสลับไป Copilot Chat panel ปกติถ้าจะใช้เสียง [7][8]
- มี public bug report เรื่อง VS Code Speech extension ไม่เสถียรพอสำหรับงานจริงทุกวัน บางเคส "ไม่แปลงเสียงเป็นข้อความเลย" — ถ้าต้องพึ่ง dictation หนักๆ พิจารณา third-party เช่น Aqua Voice ที่ทำงาน system-wide [7]
- Copilot Agent mode ต้อง subscription/license ที่รองรับ (GitHub Copilot) — ไม่ใช่ฟีเจอร์ฟรีไม่จำกัด [2]
- `workbench.colorCustomizations` ปรับสี UI เท่านั้น ถ้าต้องการปรับสี syntax highlighting ของโค้ดต้องใช้ `editor.tokenColorCustomizations` แยกต่างหาก [9]

## References

1. [VS Code for non-devs: Note-taking and Markdown in VS Code (YouTube)](https://youtu.be/LCqAQjp9TGU)
2. [Introducing GitHub Copilot agent mode (preview) — code.visualstudio.com](https://code.visualstudio.com/blogs/2025/02/24/introducing-copilot-agent-mode)
3. [Copilot ask, edit, and agent modes: What they do and when to use them — GitHub Blog](https://github.blog/ai-and-ml/github-copilot/copilot-ask-edit-and-agent-modes-what-they-do-and-when-to-use-them/)
4. [VS Code Markdown Guide — Preview, Extensions & Shortcuts (2026)](https://allmarkdowntools.com/vscode-markdown)
5. [Markdown - vscode-docs](https://vscode-docs.readthedocs.io/en/latest/languages/markdown/)
6. [Markdown Checkbox Preview — Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=GSejas.markdown-checkbox-preview)
7. [How to Dictate in VS Code: Voice Coding & Copilot (2026) — Voibe Resources](https://www.getvoibe.com/resources/dictate-in-vs-code/)
8. [Feature Request: Voice Control support in Agent Window (Copilot Chat) · Issue #319086 · microsoft/vscode](https://github.com/microsoft/vscode/issues/319086)
9. [Personalize Your VS Code Theme with workbench.colorCustomizations](https://egghead.io/personalize-your-cursor-vs-code-theme-with-workbench-color-customizations~3w44x)

## Key Takeaways

- `Ctrl+K V` เปิด Markdown preview แบบ side-by-side พร้อม real-time sync
- Checklist แบบคลิกได้ในตัว preview ต้องใช้ extension เพิ่ม (ไม่ใช่ default)
- Voice dictation ใช้ได้ใน Copilot Chat panel แต่ยังไม่รองรับใน Agent window
- Markdown All in One / Markdown Preview Enhanced / markdownlint ครอบคลุมงาน note-taking ส่วนใหญ่
- `workbench.colorCustomizations` ปรับสี UI เฉพาะจุดได้โดยไม่ต้องเปลี่ยน theme ทั้งชุด
- GitHub Copilot Agent mode สแคฟฟอลด์ไฟล์, แปลง CSV เป็นตาราง, สรุป release notes จาก commit ได้ในคำสั่งเดียว
- ตรวจสอบ subscription และข้อจำกัดของ extension ก่อนพึ่งพาเป็น workflow หลัก
