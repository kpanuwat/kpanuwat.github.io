---
title: "CLI-Anything vs CLI Printing Press: วางสถาปัตยกรรม Agent ให้ถูก Layer"
date: 2026-05-25 00:01:00 +0700
categories: [Engineering]
tags: [cli, ai-agents, tool-use, automation, mcp]
slides: true
---

{% include slide-link.html %}

## TL;DR

CLI-Anything แปลง software ที่มี source code (desktop apps, local tools) ให้กลายเป็น CLI ที่ agent ใช้ได้ทันที  
CLI Printing Press สร้าง Go CLI + MCP server จาก API specs เพื่อให้ agent เรียก cloud APIs ได้อย่าง efficient  
ทั้งสองคือคนละ layer ในสถาปัตยกรรมเดียวกัน — ไม่ใช่คู่แข่ง

## Background / Why this matters

ปัญหาหลักของ AI agent ในปี 2025–2026 ไม่ใช่ความฉลาด แต่คือ **การเข้าถึง** software จริงๆ

agent ส่วนใหญ่ทำได้แค่สองทาง:
1. เรียก REST API ที่มีอยู่แล้ว (แต่ software ในองค์กรส่วนใหญ่ไม่มี API)
2. ใช้ browser automation / screenshot (เปราะบาง, แพง, ไม่ reproducible)

ทั้ง CLI-Anything และ CLI Printing Press แก้ปัญหานี้คนละมุม CLI-Anything มองจาก **software ลงมา** (มี codebase อยู่แล้ว — ทำ CLI ออกมาเลย) ส่วน CLI Printing Press มองจาก **API spec ขึ้นไป** (มี spec อยู่แล้ว — build tool ที่ agent ใช้ได้ optimal)

## Deep Dive

### CLI-Anything: ปรัชญา "ใช้ Software จริง"

CLI-Anything ถูกออกแบบมาด้วย philosophy ว่า agent ควรได้ใช้ **software จริงๆ** ผ่าน real backend ไม่ใช่ reimplementation หรือ screenshot workaround [1]

**สถาปัตยกรรม:**
- Python + Click CLI framework
- Stateful REPL พร้อม persistent project state, undo/redo capabilities
- Built-in `--json` flag ทุก command (machine-readable output สำหรับ agent)
- Integration method: subprocess หรือ native APIs ของ application จริง [2]

**7-Phase Automated Pipeline:**

```
Analyze → Design → Implement → Plan Tests → Write Tests → Document → Publish
```

| Phase | Output |
|-------|--------|
| 1. Analyze | Scan source code, map GUI actions → `SOFTWARE.md` |
| 2. Design | Architect command groups |
| 3. Implement | Build Click CLI with REPL + `--json` |
| 4–5. Tests | Unit, E2E, subprocess test suite |
| 6. Document | `TEST.md` + `SKILL.md` (agent-discoverable metadata) |
| 7. Publish | Package → `pip install` |

Pipeline ทำงาน deterministic ทุกครั้ง ไม่ต้องแก้ไขด้วยมือ และ test suite มีกว่า 1,508 tests [1, 2]

**ตัวอย่างซอฟต์แวร์ที่ใช้ได้ทันที:** Blender (3D rendering), LibreOffice (document generation), GIMP (image processing), Mermaid (diagram creation), Zotero (reference management), CloudCompare (3D point cloud processing) [2]

### CLI Printing Press: ปรัชญา "Data Gravity"

CLI Printing Press เป็น Go-based code generation engine ที่สร้าง production-grade tools สำหรับ AI agents [3]

concept หลักคือ **Data Gravity** — แทนที่จะให้ agent เดินทางไปหา API ทุกครั้ง ให้ดึงข้อมูลมาไว้ local แล้ว agent ทำงานกับ local data แทน [3, 4]

**สถาปัตยกรรม:**
- Go binary (fast, statically compiled)
- SQLite synchronization layer สำหรับ offline/local-first data
- Offline search capabilities
- Structured outputs + typed exit codes
- Machine-owned freshness (auto-sync ตาม schedule)

**Output ที่ได้จาก 1 run:**
- Go CLI binary (ใช้งานได้ทันที)
- MCP server (รองรับ Claude Code, Claude Desktop)
- Manuscript (proof-of-work document)
- Scorecard (quality audit)

**9-Phase Managed Pipeline:**

```
Preflight → Research → Scaffold → Enrich → Regenerate → 
Review → Agent-readiness → Comparative → Ship
```

Phase "Research" รองรับ input หลายแบบ: OpenAPI spec, GraphQL schema, HAR file จาก browser dev tools (สำหรับ API ที่ไม่มี official docs) [3, 4]

### CLI-Anything vs CLI Printing Press: เปรียบเทียบแบบตาราง

| | CLI-Anything | CLI Printing Press |
|---|---|---|
| **Target** | Local software / codebase | Remote APIs / web services |
| **Language** | Python + Click | Go |
| **Pipeline** | 7 phases | 9 phases |
| **Key concept** | Use Real Software | Data Gravity |
| **REPL** | ✓ Stateful, undo/redo | — |
| **Local cache** | — | ✓ SQLite sync |
| **Output** | pip package + SKILL.md | Go binary + MCP server |
| **Input format** | Source code / codebase | OpenAPI / GraphQL / HAR |
| **Use case** | Blender, GIMP, LibreOffice | GitHub API, Stripe, internal APIs |

### เลือกใช้อะไร ตอนไหน

**ใช้ CLI-Anything เมื่อ:**
- มี software ที่มี source code (desktop app, internal tool, legacy system)
- ไม่มี REST API ให้เรียก แต่มี functionality ใน codebase
- ต้องการให้ agent ทำงานกับ real rendering/processing (ไม่ใช่แค่ data)
- UI automation เปราะบาง/ช้าเกินไปสำหรับ use case นั้น [1]

**ใช้ CLI Printing Press เมื่อ:**
- ทำงานกับ remote web service หรือ cloud API
- ต้องการลด token usage / latency ในการเรียก API
- API ที่ใช้หนักมาก cost สูง หรือมี rate limits
- ต้องการ offline access หรือ compound queries รวมหลาย call เป็นคำสั่งเดียว [3, 4]

### สถาปัตยกรรมที่ดีที่สุด: ใช้ทั้งสองเป็น Layer

```
┌─────────────────────────────────────────────┐
│  AI Agent                                   │
├─────────────────────────────────────────────┤
│  Optimization Layer (CLI Printing Press)    │
│  → Go CLI, MCP server, SQLite cache         │
│  → GitHub API, Stripe, internal REST APIs   │
├─────────────────────────────────────────────┤
│  Access Layer (CLI-Anything)                │
│  → Python Click CLI, Stateful REPL          │
│  → Blender, LibreOffice, GIMP, legacy apps  │
└─────────────────────────────────────────────┘
```

ทั้งสองใช้ agent-native standards เหมือนกัน: `--help` discovery, structured JSON output, MCP protocol ทำให้ agent สามารถ orchestrate ทั้ง local processing และ cloud sync ได้ใน workflow เดียว [1, 3]

**ตัวอย่าง workflow จริง:**
```bash
# CLI-Anything: render PDF report ด้วย LibreOffice จริงๆ
libreoffice-cli convert report.docx --format pdf --json

# CLI Printing Press: sync ข้อมูล customer จาก Salesforce ไว้ local
salesforce sync contacts --since 7d

# Agent combine ทั้งสอง:
# 1. ดึง data จาก Salesforce (Printing Press)
# 2. generate PDF report ด้วย LibreOffice (CLI-Anything)
# 3. ส่งผ่าน Gmail API (Printing Press)
```

## User Guide (Step-by-Step)

### เริ่มต้น: CLI-Anything

**ติดตั้ง:**
```bash
pip install cli-anything
```

**สร้าง CLI จาก codebase:**
```bash
# ชี้ไปที่ root ของ software ที่ต้องการ wrap
cli-anything generate ./my-desktop-app/

# Pipeline ทำงานอัตโนมัติ — ได้ผลลัพธ์เป็น CLI ทดสอบได้ทันที
my-desktop-app --help
my-desktop-app process-file input.csv --json
```

**ใช้ใน agent (ผ่าน SKILL.md):**
Claude Code และ agent อื่นๆ discover ผ่าน `SKILL.md` ที่สร้างอัตโนมัติใน phase 6 ไม่ต้องเขียน integration code เพิ่ม [2]

### เริ่มต้น: CLI Printing Press

**ติดตั้ง:**
ดู release ล่าสุดที่ GitHub repo `mvanhorn/cli-printing-press`

**สร้าง CLI จาก OpenAPI spec:**
```bash
# จาก official spec URL
printing-press run --spec https://api.example.com/openapi.json

# จาก HAR file (สำหรับ API ที่ไม่มี official docs)
printing-press run --har ~/Downloads/network-capture.har
```

**Output ที่ได้:**
```
~/printing-press/
  example-api/
    cli/        ← Go binary
    mcp/        ← MCP server
    manuscript/ ← proof-of-work
    scorecard/  ← quality audit
```

**ใช้ MCP server ใน Claude Code:**
```json
// ~/.mcp.json
{
  "mcpServers": {
    "example-api": {
      "command": "~/printing-press/example-api/mcp/server"
    }
  }
}
```

## Caveats / Limits

**CLI-Anything:**
- ต้องมี source code — ใช้กับ closed-source binary-only apps ไม่ได้
- Quality ของ generated CLI ขึ้นกับ code structure ของ application เดิม
- Python dependency — ต้องมี Python env ใน target machine

**CLI Printing Press:**
- Target คือ API-based services เท่านั้น — ไม่ handle local software
- Go runtime จำเป็นสำหรับ compile (binary ที่ได้ไม่ต้องการ Go runtime)
- HAR file approach เหมาะกับ API ที่ traffic pattern ค่อนข้าง stable — ถ้า API เปลี่ยนบ่อย ต้อง re-generate

**ทั้งสอง:**
- Agentic generation pipeline ใช้ LLM — มี cost และ latency ในขั้น generate ครั้งแรก
- Generated CLI ควร review และ test ก่อน deploy production

## References

1. [CLI-Anything — Making ALL Software Agent-Native](https://clianything.net/)
2. [HKUDS/CLI-Anything | DeepWiki](https://deepwiki.com/HKUDS/CLI-Anything)
3. [mvanhorn/cli-printing-press | DeepWiki](https://deepwiki.com/mvanhorn/cli-printing-press)
4. [CLI Printing Press download | SourceForge.net](https://sourceforge.net/projects/cli-printing-press.mirror/)

## Key Takeaways

- **CLI-Anything = Access Layer** — ใช้เมื่อมี source code ของ software ที่ต้องการควบคุม pipeline 7 phases สร้าง Python CLI พร้อม SKILL.md อัตโนมัติ
- **CLI Printing Press = Optimization Layer** — ใช้เมื่อทำงานกับ API/web services pipeline 9 phases สร้าง Go CLI + MCP server พร้อม SQLite cache
- **Data Gravity** คือ key insight ของ Printing Press: ดึง API data มาไว้ local แทนที่จะให้ agent fetch ทุกครั้ง ลด latency + token cost อย่างมีนัยสำคัญ
- **ใช้ทั้งสองร่วมกัน** เป็น two-layer stack: CLI-Anything เปิด ecosystem local ได้กว้าง, Printing Press optimize APIs ที่ใช้งานหนัก
- ทั้งสองใช้ agent-native standards เหมือนกัน (`--help`, `--json`, MCP) ทำให้ compose ใน workflow เดียวกันได้โดยไม่ต้องเขียน glue code
- สำหรับ organization ที่มีทั้ง legacy desktop software + modern cloud APIs — นี่คือ stack ที่ให้ coverage ครบ ทั้ง local และ cloud ใน agent เดียว
