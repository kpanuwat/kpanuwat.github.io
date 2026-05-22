---
title: "Chrome Browser MCP: ให้ Claude Code ควบคุม Chrome ได้โดยตรง"
date: 2026-05-19 05:28:25 +0700
categories: [Tools]
tags: [mcp, chrome, browser-automation, claude-code, devtools]
slides: true
---

{% include slide-link.html %}

## TL;DR

Chrome Browser MCP เปิดให้ Claude Code CLI สั่ง Chrome ได้โดยตรง — navigate, click, fill form, จับ screenshot, ดู network request, รัน JavaScript — ผ่าน Chrome DevTools Protocol โดยไม่ต้องเขียน automation script เอง

## Background / Why this matters

ปัญหาเดิมของ AI coding assistant: "เห็น" แต่ code ไม่ได้เห็น browser จริง
เมื่อ Claude Code ช่วย debug หรือ test web app ต้องอาศัย copy-paste output จาก browser console กลับมาให้ LLM แล้วค่อยวิเคราะห์ — ช้า และ error-prone

**Model Context Protocol (MCP)** แก้ปัญหานี้ด้วยการให้ LLM เรียก tool ที่คุย direct กับ browser runtime
ผลลัพธ์: Claude Code กลายเป็น browser automation agent ที่เข้าถึง DOM, console log, network request, และ performance trace ได้ real-time

ปัจจุบันมี 3 ตัวเลือกหลัก:

| Tool | ผู้พัฒนา | จุดเด่น | ใช้กับ |
|------|---------|---------|--------|
| `chrome-devtools-mcp` | Google/ChromeDevTools | 43 tools, ต่อกับ Chrome session จริง | Debug + Automation |
| `@playwright/mcp` | Microsoft | Cross-browser, accessibility tree | Testing |
| WebMCP | W3C/Google | Native browser standard | ยังอยู่ใน preview |

## Deep Dive

### Chrome DevTools MCP

**GitHub:** [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp)
**Package:** `chrome-devtools-mcp`
**Version:** v1.0.1 (May 2026), Apache-2.0 license, 40k+ GitHub stars

Claude Code จะได้รับ **43 tools** แบ่งเป็น category:

```
Input automation   → click, drag, fill, type_text, hover, select, ...  (10 tools)
Navigation         → navigate_page, new_page, close_page, reload, ...  (6 tools)
Debugging          → take_screenshot, console_messages, lighthouse, ... (8 tools)
Network            → inspect_requests, mock_response                    (2 tools)
Performance        → traces, insights_analysis                          (3 tools)
Memory             → heap_snapshots                                     (5 tools)
Extensions / Other → specialized tools                                  (9+ tools)
```

#### วิธีเชื่อมต่อ Chrome

**แบบที่ 1 — Isolated mode** (headless, ไม่ใช้ Chrome ที่เปิดอยู่)
MCP จะ launch Chrome process แยก → ปลอดภัย ไม่กระทบ session ของผู้ใช้

**แบบที่ 2 — AutoConnect** (ต่อกับ Chrome session จริง ✓ login ของผู้ใช้ยังอยู่)
เปิด remote debugging แล้วใช้ flag `--autoConnect` → Claude Code เข้าถึง cookies, localStorage ของ session นั้น

### Playwright MCP

**Package:** `@playwright/mcp`
**ความแตกต่างสำคัญ:** ทำงานผ่าน accessibility tree แทน pixels → ไม่ต้องใช้ vision model → เร็วกว่า, token ถูกกว่า
เหมาะกับ automated testing มากกว่า interactive debugging

```bash
claude mcp add playwright npx @playwright/mcp@latest
```

### WebMCP (Early Preview)

Web standard ใหม่ที่ให้เว็บไซต์ expose tools ผ่าน `navigator.modelContext` API โดยตรง
ปัจจุบันใช้ได้ใน Chrome 146 Canary ผ่าน `chrome://flags/#enable-webmcp`
ยังไม่ production-ready แต่น่าจับตา

## User Guide (Step-by-Step)

### Requirements

- Node.js LTS (v20+)
- Chrome 144 หรือใหม่กว่า
- Claude Code CLI

---

### ตัวเลือก A — Plugin Marketplace (แนะนำ)

ได้ทั้ง MCP server + 6 skills (a11y audit, performance debug, troubleshooting)

```bash
# ใน Claude Code session
/plugin marketplace add ChromeDevTools/chrome-devtools-mcp
/plugin install chrome-devtools-mcp
```

Restart Claude Code → พิมพ์ `/mcp` ตรวจว่า `chrome-devtools` ขึ้น "Connected"

---

### ตัวเลือก B — Manual npx (เบา กว่า)

เพิ่มใน `~/.mcp.json` (global) หรือ `.claude/mcp.json` (project-scoped):

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

```bash
# หรือผ่าน CLI:
claude mcp add chrome-devtools npx -y chrome-devtools-mcp@latest
```

---

### เปิด AutoConnect (ต่อกับ Chrome จริง)

1. เปิด Chrome → ไปที่ `chrome://inspect/#remote-debugging`
2. เช็ก "Enable remote debugging" → คลิก **Allow**
3. แก้ args ใน config:

```json
"args": ["chrome-devtools-mcp@latest", "--autoConnect"]
```

4. Restart Claude Code
5. พิมพ์ `list_pages` ใน Claude → ควรเห็น tabs ที่เปิดอยู่

---

### Linux / Wayland

Chrome DevTools MCP launch Chrome ด้วย Puppeteer ซึ่ง default เป็น X11 — บน Wayland จะ fail
ใช้ config นี้แทน:

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
        "--chromeArg=--no-default-browser-check",
        "--chromeArg=--disable-search-engine-choice-screen",
        "--no-usage-statistics",
        "--isolated"
      ]
    }
  }
}
```

Flag สำคัญ: `--ozone-platform=wayland` บอก Chrome ให้ใช้ Wayland backend
`--isolated` ป้องกัน profile conflict เมื่อมี Chrome instance หลายตัว

---

### ตัวอย่าง Workflow ใน Claude Code

```
# Debug: ดู console error ของ web app
"open http://localhost:3000 and check for JavaScript console errors"

# Automation: กรอก form
"navigate to /login, fill email with test@example.com, fill password, click submit"

# Performance: วิเคราะห์ slow page
"take a performance trace of /dashboard and summarize the bottlenecks"

# Testing: snapshot accessibility tree
"take a snapshot of the current page and check if all buttons have aria labels"
```

## Caveats / Limits

**AutoConnect = full session access**
เมื่อใช้ `--autoConnect` Claude Code เข้าถึง cookie, localStorage, session token ของ Chrome ที่เปิดอยู่จริง รวมถึง paywalled content และ authenticated services — ระวังเมื่อใช้ในสภาพแวดล้อม shared

**Plugin update อาจ overwrite config**
ถ้า install ผ่าน plugin marketplace แล้วแก้ `plugin.json` เพิ่ม `--autoConnect` → plugin update อาจลบ config นั้น ต้องใส่ใหม่หลัง update

**Chrome 144+ เท่านั้น**
Version ต่ำกว่า 144 ไม่รองรับ `--autoConnect` flag

**Puppeteer MCP deprecated**
`@modelcontextprotocol/server-puppeteer` ถูก deprecate แล้ว → ใช้ `chrome-devtools-mcp` หรือ `@playwright/mcp` แทน

**WebMCP ยังไม่ stable**
Chrome 146 Canary เท่านั้น, ยังอยู่ใน experimental flag — ยังไม่เหมาะ production

## References

1. [ChromeDevTools/chrome-devtools-mcp — GitHub](https://github.com/ChromeDevTools/chrome-devtools-mcp/)
2. [Playwright MCP — Official Docs](https://playwright.dev/docs/getting-started-mcp)
3. [How to Set Up Chrome DevTools MCP for Claude Code — samwize](https://samwize.com/2026/03/26/how-to-set-up-chrome-devtools-mcp-for-claude-code/)
4. [Chrome DevTools MCP on Linux Wayland — Alexander Zeitler](https://alexanderzeitler.com/articles/chrome-devtools-mcp-with-claude-code-on-linux-wayland/)
5. [Chrome's Built-In MCP Server: Native MCP v2 — ComputeLeap](https://www.computeleap.com/blog/chrome-built-in-mcp-server-native-mcp-v2-2026/)

## Key Takeaways

- Chrome DevTools MCP ให้ Claude Code มี 43 tools สำหรับ automate + debug Chrome โดยตรง
- ติดตั้งได้ 2 แบบ: plugin marketplace (ครบทั้ง skills) หรือ manual npx (เบากว่า)
- `--autoConnect` เชื่อมกับ Chrome session จริง — ระวังเรื่อง security เพราะ access cookies/session ด้วย
- Linux/Wayland ต้องเพิ่ม `--chromeArg=--ozone-platform=wayland` + `--isolated`
- Playwright MCP (`@playwright/mcp`) เหมาะกับ testing มากกว่า — ทำงานผ่าน accessibility tree
- Puppeteer MCP deprecated แล้ว — migrate ได้เลย
- WebMCP (Chrome 146 Canary) คือ next step: เว็บไซต์ expose tools ให้ AI agent โดยตรงผ่าน browser API
