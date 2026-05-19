---
marp: true
theme: default
paginate: true
---

# Chrome Browser MCP: ให้ Claude Code ควบคุม Chrome ได้โดยตรง

**43 tools · Debug · Automate · ไม่ต้องเขียน script**

---

## TL;DR

- Claude Code สั่ง Chrome ได้โดยตรงผ่าน **Chrome DevTools Protocol**
- navigate · click · fill form · screenshot · network inspect · JS eval
- ไม่ต้องเขียน automation script — แค่พิมพ์ natural language

---

## ปัญหาเดิม: AI "เห็น" แต่ไม่เห็น Browser จริง

**Before MCP**

```
Dev → copy console log → paste to Claude → Claude analyzes → suggest fix
```

ช้า, error-prone, ข้อมูลครึ่งเดียว

**After MCP**

```
Claude → list_pages → take_screenshot → evaluate_script → fix
```

Real-time access to DOM, network, console, performance

---

## 3 ตัวเลือกหลัก

| Tool | ผู้พัฒนา | จุดเด่น | เหมาะกับ |
|------|---------|---------|---------|
| `chrome-devtools-mcp` | Google | 43 tools, Chrome session จริง | Debug + Automation |
| `@playwright/mcp` | Microsoft | Cross-browser, accessibility tree | Testing |
| WebMCP | W3C/Google | Native browser standard | Early preview |

---

## Chrome DevTools MCP — 43 Tools

```
Input automation  → click, drag, fill, type_text, hover, select  (10)
Navigation        → navigate_page, new_page, close_page, reload  (6)
Debugging         → take_screenshot, console_messages, lighthouse (8)
Network           → inspect_requests, mock_response               (2)
Performance       → traces, insights_analysis                     (3)
Memory            → heap_snapshots                                 (5)
Extensions/Other  → specialized tools                             (9+)
```

**GitHub:** ChromeDevTools/chrome-devtools-mcp · v1.0.1 · Apache-2.0 · 40k ★

---

## วิธีเชื่อมต่อ Chrome (2 โหมด)

**แบบที่ 1 — Isolated** *(ค่าเริ่มต้น)*
MCP launch Chrome process แยก — ปลอดภัย ไม่กระทบ session ผู้ใช้

**แบบที่ 2 — AutoConnect** *(ต่อกับ Chrome ที่เปิดอยู่)*
- เปิด remote debugging ที่ `chrome://inspect/#remote-debugging`
- ใช้ flag `--autoConnect`
- Claude Code เข้าถึง cookies, localStorage ของ session นั้น ✓
- ⚠️ ระวัง: access paywalled content + session token ด้วย

---

## Playwright MCP

**Package:** `@playwright/mcp@latest`

```bash
claude mcp add playwright npx @playwright/mcp@latest
```

**ความแตกต่างจาก chrome-devtools-mcp**

| | chrome-devtools-mcp | @playwright/mcp |
|-|-------------------|----------------|
| กลไก | Chrome DevTools Protocol | Accessibility tree |
| Browser | Chrome เท่านั้น | Chrome, Firefox, WebKit |
| เหมาะกับ | Debug + interactive | Automated testing |
| Vision model | ไม่ต้องใช้ | ไม่ต้องใช้ |

---

## WebMCP — Next Frontier

เว็บไซต์ expose tools ให้ AI agent โดยตรงผ่าน browser API

```javascript
// เว็บไซต์ประกาศ tool ของตัวเอง
navigator.modelContext.registerTool("search", handler)
```

- **Chrome 146 Canary** เท่านั้น
- เปิดผ่าน `chrome://flags/#enable-webmcp`
- ยังไม่ production-ready — แต่เป็น next step ของ browser + AI

---

## Requirements

- **Node.js** LTS (v20+)
- **Chrome** 144 หรือใหม่กว่า
- **Claude Code CLI**

---

## Install — ตัวเลือก A: Plugin Marketplace (แนะนำ)

ได้ทั้ง MCP server + **6 skills** (a11y audit, performance debug, troubleshooting)

```bash
# ใน Claude Code session
/plugin marketplace add ChromeDevTools/chrome-devtools-mcp
/plugin install chrome-devtools-mcp
```

Restart Claude Code → ตรวจสอบ:

```
/mcp   →  chrome-devtools: Connected ✓
```

---

## Install — ตัวเลือก B: Manual npx

เพิ่มใน `~/.mcp.json` (global) หรือ `.claude/mcp.json` (project):

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```

หรือ CLI shortcut:
```bash
claude mcp add chrome-devtools npx -y chrome-devtools-mcp@latest
```

---

## Setup AutoConnect

1. เปิด Chrome → `chrome://inspect/#remote-debugging`
2. เช็ก **"Enable remote debugging"** → คลิก **Allow**
3. แก้ args ใน config:

```json
"args": ["chrome-devtools-mcp@latest", "--autoConnect"]
```

4. Restart Claude Code
5. ทดสอบ: `list_pages` → ควรเห็น tabs ที่เปิดอยู่ทั้งหมด

---

## Linux / Wayland Config

Puppeteer default เป็น X11 → fail บน Wayland ต้องใส่ flag เพิ่ม:

```json
{
  "mcpServers": {
    "chrome-devtools-npx": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "chrome-devtools-mcp@latest",
        "--chromeArg=--ozone-platform=wayland",
        "--chromeArg=--no-first-run",
        "--no-usage-statistics",
        "--isolated"
      ]
    }
  }
}
```

`--isolated` ป้องกัน profile conflict เมื่อ Chrome เปิดหลาย instance

---

## ตัวอย่าง Workflow

```
# Debug console error
"open http://localhost:3000 and check for JavaScript console errors"

# Automation
"navigate to /login, fill email test@example.com, fill password, click submit"

# Performance
"take a performance trace of /dashboard and summarize the bottlenecks"

# Accessibility audit
"take a snapshot of the current page and check if all buttons have aria labels"
```

---

## Caveats / Limits

- **AutoConnect = full session access** — cookie, localStorage, session token ทั้งหมด
- **Plugin update อาจ overwrite config** — ต้องใส่ `--autoConnect` ใหม่หลัง update
- **Chrome 144+** เท่านั้น สำหรับ AutoConnect
- **Puppeteer MCP deprecated** — ย้ายมา `chrome-devtools-mcp` หรือ `@playwright/mcp` ได้เลย
- **WebMCP** ยังอยู่ใน Chrome 146 Canary — ไม่เหมาะ production

---

## Key Takeaways

- `chrome-devtools-mcp` มี **43 tools** ครอบคลุม debug + automation
- ติดตั้ง 2 แบบ: **plugin marketplace** (ครบ skills) หรือ **manual npx** (เบา)
- `--autoConnect` เชื่อมกับ Chrome session จริง — ระวัง security
- **Linux/Wayland** ต้องเพิ่ม `--ozone-platform=wayland` + `--isolated`
- `@playwright/mcp` เหมาะ testing — ทำงานผ่าน accessibility tree
- **Puppeteer MCP deprecated** → migrate ได้เลย
- **WebMCP** คือ next step: เว็บ expose tools ให้ AI โดยตรง
