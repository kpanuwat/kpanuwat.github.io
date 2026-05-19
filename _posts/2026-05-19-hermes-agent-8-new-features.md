---
title: "Hermes Agent just got WAY more powerful: 8 New Features"
date: 2026-05-19 12:00:00 +0700
categories: [Tools]
tags: [hermes-agent, ai-agent, nous-research, grok, computer-use, kanban, llm]
---

## TL;DR

Hermes Agent v0.14.0 ships 8 major upgrades: smarter cross-session memory, isolated background tasks, Grok via OAuth (no API key), X/Twitter search, a local OpenAI-compatible coding proxy, computer use for non-Anthropic models, pluggable AI video generation, and a durable multi-agent kanban board. Taken together, they push Hermes from "capable agent" to "persistent autonomous collaborator."

## Background / Why this matters

[Hermes Agent](https://hermes-agent.nousresearch.com/) is Nous Research's open-source, model-agnostic agent harness. Unlike one-shot chat interfaces, Hermes runs continuously — it remembers what it learned, executes tasks in the background, and reaches you via 22 messaging platforms (Telegram, Discord, LINE, SimpleX, etc.).

Version 0.14.0, covered in Alex Finn's May 19 2026 video, is the biggest feature drop since the project launched. Each of the 8 features is independently useful, but they compound: better memory makes every other feature smarter; background tasks multiply throughput; Kanban coordinates parallel agents cleanly.

## Deep Dive

### 1. Way Better Memory (0:29)

Hermes now persists a `MEMORY.md` and `USER.md` across sessions, backed by FTS5 full-text search so the agent can retrieve relevant facts without loading your entire history into context. Two additional mechanisms layer on top:

- **Cross-session prompt caching** — a one-hour Claude prompt-cache window keeps shared prefixes warm across conversations, cutting latency and cost for heavy users.
- **Pluggable memory backends** — drop in Honcho or Mem0 for enterprise-grade personalization outside the local filesystem.

The net effect: Hermes learns your preferences, recurring projects, and work patterns, and recalls them selectively rather than re-reading everything on every turn.

### 2. Background Tasks (2:20)

Background tasks run in isolated subagent instances — up to 3 concurrently by default (configurable). You dispatch a task, close the chat, and Hermes keeps working. Instructions arrive via your preferred messaging platform; results are delivered the same way when the task finishes.

Key design property: isolation. Background tasks cannot read or modify your current conversation, which prevents context contamination and allows safe parallel workstreams.

### 3. Grok OAuth (4:09) — feature 3 of 8

xAI Grok is now available through a SuperGrok subscription with zero API key setup. Sign in with your xAI account and Hermes maps three Grok capabilities:

| Capability | Model |
|---|---|
| Text / reasoning | grok-4.3 (1M token context) |
| Voice | Grok TTS |
| Image / video | Grok Imagine |

OAuth credential rotation is supported — you can pool multiple SuperGrok tokens for higher throughput.

### 4. X/Twitter Search Tool (4:09) — feature 4 of 8

Bundled in the same chapter, X/Twitter search (`x_search`) is now a first-class tool. Hermes can search timelines, threads, and accounts using OAuth or a standard API key. This ships alongside Microsoft Teams support (read + post via Graph API), bringing real-time social and enterprise messaging into agent workflows natively.

### 5. Native Coding Proxy (5:23)

`hermes proxy` spins up a localhost OpenAI-compatible endpoint that converts OAuth-authenticated providers (Claude Pro, ChatGPT Plus, SuperGrok) into a standard API surface. This means tools like Codex, Aider, and Cline can use your existing subscriptions without separate API billing.

Practical result: a single SuperGrok subscription powers both your Hermes conversations and your Aider coding sessions through the same OAuth token.

### 6. Computer Use — Non-Anthropic Models (7:00)

Computer use was previously limited to Anthropic's own computer-use models. v0.14.0 introduces the `cua-driver` backend, which routes screen-capture-and-click loops to any vision-capable model. Combined with:

- Raw pixel delivery (instead of text descriptions) for vision models
- Persistent Chrome DevTools Protocol (CDP) connections (~180× faster browser calls)
- Per-turn file-mutation verifier catching agent write errors

...the computer-use loop is both faster and far more reliable than before.

### 7. Native AI Video Generation (9:03)

Video generation is now unified behind a pluggable provider architecture. Switch between providers in config without changing any agent code. This follows the same design as Hermes's existing image and TTS provider layers — one interface, swappable backends.

### 8. Auto Kanban Tasks (10:43)

Multi-agent Kanban is the headline coordination feature. Tasks live on a durable board with:

- **Heartbeat + reclaim** — stalled tasks are automatically reclaimed from dead agents
- **Zombie detection** — orphaned subagents are cleaned up
- **Auto-block on incomplete exit** — a task can't close until its sub-tasks are done
- **Per-task retries + hallucination recovery** — agents self-correct on failure before escalating

This gives Hermes a reliable primitive for long-running, multi-step work that spans multiple agent instances across time.

## User Guide (Step-by-Step)

### Install / Upgrade

```bash
pip install hermes-agent          # fresh install
pip install --upgrade hermes-agent  # upgrade to v0.14.0
```

### Enable Grok OAuth

```bash
hermes config set provider grok
# Follow the xAI OAuth browser prompt
```

Requires an active SuperGrok subscription. No API key is needed after authorization.

### Start a Background Task

In any chat interface connected to Hermes:
```
/task Run a daily summary of my Kanban board and post it to Telegram
```

Hermes spawns an isolated subagent, runs the task, and delivers results to your Telegram.

### Launch the Coding Proxy

```bash
hermes proxy
# → Listening on localhost:8080 (OpenAI-compatible)
```

Point Aider or Cline at `http://localhost:8080` with a dummy API key. All calls route through your authenticated provider.

### Enable Kanban

```bash
hermes kanban init
hermes kanban add "Write blog post outline" --agent auto
hermes kanban status
```

Agents pick up tasks from the board automatically. Heartbeat and reclaim are on by default.

## Caveats / Limits

- **Grok OAuth requires SuperGrok** — free xAI accounts cannot use the OAuth flow; a paid subscription is mandatory.
- **Background concurrency cap** — default is 3 concurrent subagents; raising it without memory constraints can cause context thrashing.
- **Computer use latency** — even with persistent CDP connections, full screen-capture loops are slow for high-frequency tasks; use browser tools for web automation instead.
- **Kanban is not a task queue** — it has no retry backoff by default; tight retry loops on failing tasks will burn tokens quickly without a max-retries config.
- **Video generation backends vary** — provider support and output quality differ; check `hermes providers list --capability video` to see what's available in your install.
- **Windows support is early beta** — `cmd.exe`/PowerShell support landed in v0.14.0 but some tools have known gaps; Linux/macOS remain the stable targets.

## References

1. Alex Finn — [Hermes Agent just got WAY more powerful (YouTube, May 19 2026)](https://youtu.be/8iZUyE7SlXo)
2. NousResearch — [Hermes Agent v0.14.0 Release Notes](https://github.com/NousResearch/hermes-agent/blob/main/RELEASE_v0.14.0.md)
3. Hermes Agent Docs — [Features Overview](https://hermes-agent.nousresearch.com/docs/user-guide/features/overview)
4. Hermes Agent Docs — [xAI Grok OAuth Guide](https://hermes-agent.nousresearch.com/docs/guides/xai-grok-oauth)
5. xAI — [Connect Grok to Hermes Agent](https://x.ai/news/grok-hermes)
6. Geeky Gadgets — [Hermes Agent v2.0 Brings Background AI Automation to macOS](https://www.geeky-gadgets.com/autonomous-ai-hermes-v2/)
7. Blake Crosley — [Hermes Agent v0.13 Reference: Kanban + Multi-Agent](https://blakecrosley.com/guides/hermes)

## Key Takeaways

- Hermes 0.14.0 adds 8 features that compound: better memory improves every other capability.
- Grok OAuth + the local coding proxy let a single subscription power multiple AI tools simultaneously.
- Background tasks + Kanban give Hermes a clean coordination model for parallel autonomous work.
- Computer use now works with non-Anthropic vision models via `cua-driver`, removing the last Anthropic lock-in.
- The pluggable video/TTS/image provider architecture means Hermes isn't tied to any single AI vendor for media generation.
- Windows beta support means Hermes is now viable on all three major platforms, though Linux/macOS remain the polished targets.
- With 22 messaging platform integrations, Hermes can fit into virtually any existing communication workflow.
