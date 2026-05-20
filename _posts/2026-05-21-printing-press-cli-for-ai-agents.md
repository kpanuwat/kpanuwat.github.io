---
title: "Printing Press: สร้าง CLI สำหรับ AI Agents ประหยัด Token กว่า MCP ถึง 35 เท่า"
date: 2026-05-20 12:00:00 +0700
categories: [Tools]
tags: [cli, ai-agents, mcp, token-efficiency, go, context-bloat]
slides: true
---

{% include slide-link.html %}

## TL;DR

Printing Press คือ CLI factory ที่สร้าง agent-native CLI จาก API spec หรือเว็บไซต์ใดก็ได้ พร้อม Claude Code skill + MCP server ในคำสั่งเดียว ใช้ token น้อยกว่า MCP ถึง 35 เท่า และมีคลัง CLI สำเร็จรูป 45+ รายการให้ติดตั้งได้ทันที

## Background / Why this matters

เวลา AI Agent ต้องดึงข้อมูลจากภายนอก วิธีที่นิยมมีสามแบบ: เรียก REST API โดยตรง, ใช้ MCP server, หรือรัน CLI ปัญหาของสองวิธีแรกคือ token overhead — agent ต้องโหลด schema ขนาดใหญ่, handle pagination, parse JSON ดิบ, และทำ round trip หลายครั้งเพื่อดึงข้อมูลชุดเดียว

งานวิจัยของ MindStudio วัดได้ว่า MCP server ใช้ token มากกว่า CLI equivalent ถึง **35 เท่า** และความเชื่อถือได้ของ MCP ลดจาก 100% เหลือ ~72% เมื่อ task ซับซ้อนขึ้น ขณะที่ CLI ยังคงอยู่ที่ 100%

แนวคิดนี้ไม่ใช่ใหม่ — Peter Steinberger พิสูจน์แล้วกับ [discrawl](https://github.com/steipete/discrawl) และ [gogcli](https://github.com/steipete/gogcli): local SQLite mirror + compound commands ชนะ remote API call ทุกครั้ง Printing Press นำ playbook นั้นมาทำให้ automated และ replicable สำหรับทุก API หรือเว็บไซต์

## Deep Dive

### CLI คืออะไรในบริบท Agent

agent-native CLI ใน Printing Press ออกแบบมาสำหรับ agent โดยเฉพาะ:

- **auto-JSON เมื่อ pipe**: ไม่ต้องใส่ `--json` flag — output ปรับตาม context
- **`--compact` flag**: ลด output 60-80% โดยเก็บเฉพาะ high-gravity fields
- **compound commands**: ดึงข้อมูลจากหลาย source ในคำสั่งเดียว แทนการทำ 10 round trips
- **local SQLite mirror**: query วิ่ง 50ms แทนการรอ remote API

### สิ่งที่ Press สร้างให้

จาก API spec, URL, หรือ HAR file หนึ่งชุด Press จะ output:

| Artifact | ใช้กับ |
|----------|--------|
| Go binary (CLI) | รัน local บน agent machine |
| Claude Code skill | `/printing-press <app>` เรียกใช้ผ่าน harness |
| MCP server | สำหรับ harness ที่ต้องการ MCP interface |

### Library: CLIs สำเร็จรูป 45+

คลัง [printing-press-library](https://github.com/mvanhorn/printing-press-library) มี CLI ที่ tested และ endorsed พร้อม AGENTS.md operating guide ในแต่ละตัว ตัวอย่างที่น่าสนใจ:

**ESPN** (sniffed — ไม่มี official API)
```bash
pp-espn nba playoffs tonight
# → Live scores, series state, leading scorer, injury news ในคำสั่งเดียว
```

**Flight Goat** (Kayak + Google Flights fused)
```bash
pp-flight-goat sea long-haul nonstop dec 24 to jan 1, 4 pax, cheapest first
# → ตารางเที่ยวบิน nonstop 8+ ชั่วโมง จัดเรียงตามราคา
```

**Linear** (50ms vs SQLite mirror)
```bash
linear-pp-cli "Every blocked issue whose blocker has been stuck for a week"
# → compound query ที่ Linear API ตอบไม่ได้โดยตรง
```

### Factory: สร้าง CLI จาก URL ใดก็ได้

ถ้าไม่มี OpenAPI spec Press จะ:
1. เปิด browser อัตโนมัติ
2. Capture traffic
3. Reverse-engineer API
4. Generate spec + CLI + skill + MCP server

กระบวนการทั้งหมดใช้เวลา ~10 นาที

## User Guide (Step-by-Step)

### ติดตั้ง Printing Press

**Prerequisites:** Go 1.26.3+ และ Claude Code

```bash
# 1. Install binary
go install github.com/mvanhorn/cli-printing-press/v4/cmd/printing-press@latest

# 2. Install Claude Code skills (primary interface)
# ทำใน Claude Code session:
/printing-press install
```

> **หมายเหตุ**: binary และ skill ต้องติดตั้งคู่กัน — skill ไม่มีอะไรเรียกถ้าไม่มี binary, binary ทำงานได้แต่ข้าม curated agent loop

### ติดตั้ง CLI จาก Library

```bash
# ดู catalog ทั้งหมด
/printing-press list

# ติดตั้ง ESPN CLI
/printing-press install espn

# ใช้งาน
pp-espn nba okc round 2 game 1
```

### สร้าง CLI ใหม่จาก URL

```bash
# จาก URL (press จะ sniff API เอง)
/printing-press generate https://www.example.com

# จาก OpenAPI spec
/printing-press generate https://api.example.com/openapi.json
```

### Expected Output

```
✓ Research complete (15 sources)
✓ CLI generated: pp-example
✓ Claude Code skill: /pp-example
✓ MCP server: mcp-example
✓ AGENTS.md: docs/AGENTS.md
Install time: 8m 42s
```

### Cursor Users

ดู [docs/CURSOR.md](https://github.com/mvanhorn/cli-printing-press/blob/main/docs/CURSOR.md) สำหรับวิธีติดตั้ง CLI, attach skill, handle auth, และเลือก CLI vs MCP ใน repo ที่ไม่มี workflow document

## Caveats / Limits

- **Go 1.26.3+ required**: binary เขียนด้วย Go — ต้องติดตั้ง Go runtime ก่อน
- **Claude Code tested only**: skills ทดสอบกับ Claude Code; harness อื่น (Codex, ฯลฯ) อาจทำงานได้แต่ไม่รับประกัน
- **Sniffed APIs อาจ break**: ESPN และ Google Flights ไม่มี official API — หากบริษัทเปลี่ยน endpoint, CLI ต้อง re-generate
- **SQLite mirror staleness**: ข้อมูล local อาจล้าสมัยถ้าไม่ sync — ต้องตรวจสอบ sync schedule ของแต่ละ CLI
- **Factory ≠ magic**: บาง website ที่มี aggressive anti-bot จะ generate ไม่สำเร็จ
- **35x token saving คือค่าเฉลี่ย**: savings จริงขึ้นอยู่กับ use case — simple API call อาจ save น้อยกว่า, compound query save มากกว่า

## References

1. [Printing Press — Official Site](https://printingpress.dev/)
2. [GitHub: mvanhorn/cli-printing-press](https://github.com/mvanhorn/cli-printing-press)
3. [GitHub: mvanhorn/printing-press-library](https://github.com/mvanhorn/printing-press-library)
4. [MCP vs CLI in Agentic Workflows: 35x Token Overhead and 72% vs 100% Reliability — MindStudio](https://www.mindstudio.ai/blog/mcp-vs-cli-agentic-workflows-token-overhead-reliability)
5. [How to Build a CLI for Any Tool Using Claude Code and Printing Press — MindStudio](https://www.mindstudio.ai/blog/build-cli-claude-code-printing-press)
6. [YouTube: Printing Press Demo (YHk45NEpspE)](https://youtu.be/YHk45NEpspE)
7. [GitHub: steipete/discrawl](https://github.com/steipete/discrawl) — inspiration: SQLite mirror pattern
8. [GitHub: steipete/gogcli](https://github.com/steipete/gogcli) — inspiration: agent-native CLI design

## Key Takeaways

- CLI ใช้ token น้อยกว่า MCP ถึง **35 เท่า** และ reliability สูงกว่าเมื่อ task ซับซ้อน
- Printing Press สร้าง Go CLI + Claude Code skill + MCP server จาก source เดียวในคำสั่งเดียว
- Factory sniff API จาก URL ได้เองโดยไม่ต้องมี OpenAPI spec
- Library มี 45+ CLI สำเร็จรูป พร้อม AGENTS.md — ติดตั้งแล้วใช้ได้ทันที
- compound commands + local SQLite คือแก่นของ token efficiency — ลด round trips, ลด context bloat
- สำหรับ agent workflow ที่รันบ่อย: ลงทุน 10 นาที generate CLI หนึ่งครั้ง ประหยัดค่า token ทุก run ตลอดไป
- tool นี้ต้องการ Go 1.26.3+ และ Claude Code — ไม่ใช่ zero-dependency
