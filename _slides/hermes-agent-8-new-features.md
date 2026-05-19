---
marp: true
theme: default
paginate: true
---

# Hermes Agent just got WAY more powerful

**8 new features in v0.14.0 — from capable agent to persistent autonomous collaborator**

---

## TL;DR

- **Memory**: cross-session persistence + FTS5 recall + prompt caching
- **Parallel work**: isolated background tasks + durable Kanban board
- **Provider freedom**: Grok via OAuth, `cua-driver` for non-Anthropic computer use
- **New tools**: X/Twitter search, local OpenAI-compatible coding proxy, AI video generation

---

## What is Hermes Agent?

**Nous Research's open-source, model-agnostic agent harness**

- Runs *continuously* — not a one-shot chat interface
- Reaches you via **22 messaging platforms** (Telegram, Discord, LINE, SimpleX…)
- v0.14.0 is the biggest feature drop since launch

> Each of the 8 features is independently useful — but they *compound*.

---

## Feature 1: Way Better Memory (0:29)

Persistent `MEMORY.md` + `USER.md` backed by **FTS5 full-text search**

- Selectively recalls facts — no full history reload every turn
- **Cross-session prompt caching** — 1-hour Claude cache window across conversations
- **Pluggable backends** — swap in Honcho or Mem0 for enterprise personalization

→ Hermes learns your preferences and work patterns over time

---

## Feature 2: Background Tasks (2:20)

Dispatch work, close the chat — Hermes keeps going

- Runs in **isolated subagent instances** (up to 3 concurrent by default)
- Results delivered to your messaging platform when done
- **Key property**: isolation prevents context contamination between parallel workstreams

```
/task Run a daily summary of my Kanban board and post it to Telegram
```

---

## Feature 3: Grok OAuth (4:09)

**SuperGrok subscription → zero API key setup**

| Capability | Model |
|---|---|
| Text / reasoning | grok-4.3 (1M token context) |
| Voice | Grok TTS |
| Image / video | Grok Imagine |

- Sign in with xAI account — no separate billing
- OAuth credential rotation supported — pool multiple tokens for throughput

---

## Feature 4: X/Twitter Search Tool (4:09)

`x_search` is now a **first-class agent tool**

- Search timelines, threads, and accounts
- Works via OAuth *or* standard API key
- Ships alongside **Microsoft Teams** support (read + post via Graph API)

→ Real-time social + enterprise messaging inside agent workflows, natively

---

## Feature 5: Native Coding Proxy (5:23)

`hermes proxy` → localhost OpenAI-compatible endpoint

```bash
hermes proxy
# → Listening on localhost:8080 (OpenAI-compatible)
```

- Converts OAuth providers (Claude Pro, ChatGPT Plus, SuperGrok) to standard API
- Tools like **Codex, Aider, Cline** work without separate API billing
- One SuperGrok subscription powers both Hermes *and* your coding tools

---

## Feature 6: Computer Use — Any Vision Model (7:00)

Previously Anthropic-only → now via **`cua-driver` backend**

- Routes screen-capture-and-click loops to *any* vision-capable model
- Raw pixel delivery (not text descriptions) to vision models
- Persistent CDP connections **~180× faster** browser calls
- Per-turn file-mutation verifier catches agent write errors

---

## Feature 7: Native AI Video Generation (9:03)

**Pluggable provider architecture** — same pattern as image and TTS layers

- Switch providers in config, no agent code changes needed
- One interface, swappable backends
- Follows the `hermes providers list --capability video` discovery pattern

---

## Feature 8: Auto Kanban Tasks (10:43)

**Durable multi-agent coordination board**

- **Heartbeat + reclaim** — stalled tasks reclaimed from dead agents automatically
- **Zombie detection** — orphaned subagents cleaned up
- **Auto-block on incomplete exit** — task can't close until sub-tasks finish
- **Per-task retries + hallucination recovery** — agents self-correct before escalating

```bash
hermes kanban init
hermes kanban add "Write blog post outline" --agent auto
hermes kanban status
```

---

## User Guide: Install & Core Setup

```bash
# Install / upgrade
pip install hermes-agent
pip install --upgrade hermes-agent   # → v0.14.0

# Enable Grok OAuth
hermes config set provider grok
# Follow the xAI OAuth browser prompt (requires SuperGrok)

# Launch coding proxy
hermes proxy
# → localhost:8080  (point Aider/Cline here)
```

---

## User Guide: Background Tasks & Kanban

**Background task** — from any connected chat:
```
/task Run a daily summary of my Kanban board and post it to Telegram
```

**Kanban board**:
```bash
hermes kanban init
hermes kanban add "Review PRs" --agent auto
hermes kanban status
```

Heartbeat + reclaim are on by default — no manual cleanup needed.

---

## Caveats & Limits

- **Grok OAuth** requires a paid SuperGrok subscription — free accounts can't use it
- **Background concurrency** default is 3 — raising it without memory limits risks context thrashing
- **Computer use** is still slow for high-frequency tasks; prefer browser tools for web automation
- **Kanban ≠ task queue** — no retry backoff by default; add `max-retries` config to avoid token burn
- **Video backends vary** — quality and availability differ by provider
- **Windows is early beta** — Linux/macOS remain the polished targets

---

## Key Takeaways

- v0.14.0's 8 features *compound* — better memory makes every other feature smarter
- Grok OAuth + coding proxy = one subscription powers multiple AI tools
- Background tasks + Kanban = clean model for parallel autonomous work
- `cua-driver` removes the last Anthropic lock-in for computer use
- Pluggable video/TTS/image providers — no single-vendor dependency
- 22 messaging integrations — fits any existing communication workflow
