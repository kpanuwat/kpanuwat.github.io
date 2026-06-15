---
marp: true
theme: default
paginate: true
title: "Cloudflare AI Ecosystem: Workers, Durable Objects, D1, AI Gateway, Agents SDK"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#0ea5e9; --accent-deep:#0369a1; --accent-wash:#e0f2fe; --gold:#d4af37;
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
  .bento.cols-5 { grid-template-columns:repeat(5,1fr); }
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.cheatsheet { padding:0; }
  section.cheatsheet::before { display:none; }
  section.title {
    background:linear-gradient(135deg,#0f172a 0%,var(--accent-deep) 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/cloudflare-ai-ecosystem-deep-dive-cover.png)

<div class="mark"></div>

# Cloudflare AI Ecosystem

<p class="tag">Workers · Durable Objects · D1 · AI Gateway · Agents SDK — complete platform, zero API keys</p>

<!-- Speaker: Cloudflare AI is not just GPU inference — it's a complete platform where every service wires together without a single API key in your code. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/cloudflare-ai-ecosystem-deep-dive-cheatsheet.png)

<!-- Speaker: 60-second orientation — 8 components at a glance. Workers at the center, D1/R2 for zero-egress storage, AI Gateway for caching and model routing, Bindings as the glue. -->

---

## Complete Platform, Not Just GPU Inference

<p class="subhead">Cloudflare AI bundles runtime, storage, auth, and AI — wired together with no credentials in code.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="40" y="20" width="1020" height="280" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="40" y="20" width="8" height="280" rx="4" fill="var(--accent)"/>
  <text x="84" y="80" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Workers</text>
  <text x="84" y="104" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Serverless runtime — V8 isolates, 330+ cities</text>
  <text x="84" y="148" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Durable Objects</text>
  <text x="84" y="172" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Per-session compute + SQLite storage in one unit</text>
  <text x="84" y="216" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">D1 + R2</text>
  <text x="84" y="240" font-size="14" fill="var(--ink-dim)" font-family="system-ui">SQL + Object storage — zero egress fees</text>
  <text x="560" y="80" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">AI Gateway</text>
  <text x="560" y="104" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Cache, model fallback, spend limits</text>
  <text x="560" y="148" font-size="17" font-weight="700" fill="var(--ink)" font-family="system-ui">Cloudflare Access</text>
  <text x="560" y="172" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Zero-trust auth — no code change needed</text>
  <text x="560" y="216" font-size="17" font-weight="700" fill="var(--accent)" font-family="system-ui">Bindings</text>
  <text x="560" y="240" font-size="14" fill="var(--ink-dim)" font-family="system-ui">All services wired via wrangler.toml — no API keys</text>
  <line x1="540" y1="50" x2="540" y2="280" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="84" y="284" font-size="15" font-weight="700" fill="var(--accent)" font-family="system-ui">+ Agents SDK (Agents Week 2026):</text>
  <text x="380" y="284" font-size="14" fill="var(--ink-dim)" font-family="system-ui">State + WebSockets + Tools — no infra provisioning</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> One wrangler.toml wires your entire AI stack — runtime, storage, auth, AI, agents — no secrets in code.</div>

<!-- Speaker: This is the TL;DR. Every service maps to a binding name — env.AI, env.DB, env.BUCKET. No .env, no IAM roles, no credentials in source code. -->

---

## Traditional AI Stack Has 4 Broken Seams

![bg right:40% contain](assets/cloudflare-ai-ecosystem-deep-dive-background.png)

<p class="subhead">Most teams patch each seam separately — Cloudflare seals all four with one platform.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card danger">
    <p class="label">Problem 1</p>
    <h3>Scattered API Keys</h3>
    <p>OpenAI key in .env, Anthropic in secrets manager, DB creds in CI — breach surface multiplies with every provider added.</p>
  </div>
  <div class="card warning">
    <p class="label">Problem 2</p>
    <h3>Stateless Compute</h3>
    <p>Lambda/Cloud Run forgets session on every request — storing chat history means a separate Redis or DynamoDB call.</p>
  </div>
  <div class="card warning">
    <p class="label">Problem 3</p>
    <h3>Egress Tax</h3>
    <p>S3 + RDS charge per GB transferred out — AI-generated files and query responses add up fast at any real scale.</p>
  </div>
  <div class="card danger">
    <p class="label">Problem 4</p>
    <h3>No Caching Layer</h3>
    <p>Identical prompts sent to OpenAI repeatedly — no request dedup, no spend cap, no model fallback on provider outage.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Bindings, Durable Objects, D1/R2, and AI Gateway each seal exactly one of these four broken seams.</div>

<!-- Speaker: Four broken seams — each solved by exactly one Cloudflare primitive. This is the architecture story. -->

---

## Workers: Edge Inference, Zero Cold Start

<p class="subhead">V8 isolates start in sub-millisecond — inference runs at the nearest of 330+ PoPs without container spin-up.</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="100" width="150" height="80" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="95" y="136" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">User</text>
  <text x="95" y="158" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">HTTPS request</text>
  <line x1="170" y1="140" x2="220" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="220,135 230,140 220,145" fill="var(--accent)"/>
  <rect x="230" y="100" width="150" height="80" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="305" y="136" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Edge PoP</text>
  <text x="305" y="158" font-size="12" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">330+ cities</text>
  <line x1="380" y1="140" x2="430" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="430,135 440,140 430,145" fill="var(--accent)"/>
  <rect x="440" y="80" width="170" height="120" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="525" y="128" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">V8 Isolate</text>
  <text x="525" y="150" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Worker code</text>
  <text x="525" y="170" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">sub-ms start</text>
  <rect x="450" y="196" width="150" height="22" rx="6" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="525" y="210" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">env.AI.run(...)</text>
  <line x1="610" y1="140" x2="660" y2="140" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="660,135 670,140 660,145" fill="var(--accent)"/>
  <rect x="670" y="80" width="170" height="120" rx="12" fill="var(--accent)" opacity=".9"/>
  <text x="755" y="128" font-size="13" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Workers AI</text>
  <text x="755" y="150" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">50+ models</text>
  <text x="755" y="170" font-size="12" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">serverless GPU</text>
  <line x1="840" y1="140" x2="890" y2="140" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="5,3"/>
  <rect x="900" y="100" width="170" height="80" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="985" y="136" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Response</text>
  <text x="985" y="158" font-size="12" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">JSON / Stream</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> env.AI is a runtime binding, not an HTTP client — no external API call leaves user code; Cloudflare routes to the nearest GPU automatically.</div>

<!-- Speaker: The key insight: env.AI talks to Workers AI inside Cloudflare's network. No external API call, no latency penalty, no credential exposure. -->

---

## Durable Objects: Compute + State, Per Session

![bg right:40% contain](assets/cloudflare-ai-ecosystem-deep-dive-durable-objects.png)

<p class="subhead">Each DO instance is a unique JavaScript class + SQLite storage unit — no shared state between sessions.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Inside one DO instance</p>
    <h3>Compute + Storage fused</h3>
    <p>Class methods run in the same process as the SQLite KV store — strongly consistent read-after-write, no race conditions.</p>
  </div>
  <div class="card success">
    <p class="label">Isolation guarantee</p>
    <h3>User A != User B</h3>
    <p>Worker routes by <code>idFromName(sessionId)</code> — each session ID maps to a unique DO; zero shared state leak.</p>
  </div>
  <div class="card gold">
    <p class="label">Use cases</p>
    <h3>Chat · Game · Collab</h3>
    <p>Multi-turn chat history, game state, collaborative documents, real-time coordination. All stateful — no Redis needed.</p>
  </div>
  <div class="card warning">
    <p class="label">Constraint</p>
    <h3>Paid plan only</h3>
    <p>$5/mo minimum. Cold start ~100ms. Max 128 KB per key — use R2 for large payloads like images or generated PDFs.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Durable Objects replace Redis + DB coordination for per-user state — one primitive, strongly consistent, isolated by session ID.</div>

<!-- Speaker: Think of DO as "each chat session gets its own mini-server." No synchronization needed, no race conditions, no cross-session leaks. -->

---

## D1 + R2: Storage Without the Egress Tax

<p class="subhead">SQLite + S3-compatible object storage — both accessed from Workers with zero bandwidth fees.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="475" height="280" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(var(--shadow-sm))"/>
  <rect x="30" y="20" width="475" height="52" rx="12" fill="var(--danger-wash)"/>
  <text x="267" y="52" font-size="16" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Traditional: S3 + RDS</text>
  <text x="60" y="100" font-size="14" fill="var(--ink)" font-family="system-ui">S3 egress: ~$0.09/GB transferred out</text>
  <text x="60" y="128" font-size="14" fill="var(--ink-dim)" font-family="system-ui">RDS data transfer: $0.01-0.09/GB</text>
  <text x="60" y="156" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Separate credentials per service</text>
  <text x="60" y="184" font-size="14" fill="var(--ink-dim)" font-family="system-ui">VPC peering required for low latency</text>
  <text x="60" y="220" font-size="14" fill="var(--danger)" font-family="system-ui">10M row reads/day = ~$0.70 egress</text>
  <text x="60" y="248" font-size="14" fill="var(--danger)" font-family="system-ui">1 TB S3 download = ~$90 egress fee</text>
  <text x="60" y="280" font-size="13" fill="var(--muted)" font-family="system-ui">bills compound with every AI output stored</text>
  <rect x="595" y="20" width="475" height="280" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(var(--shadow-md))"/>
  <rect x="595" y="20" width="475" height="52" rx="12" fill="var(--success-wash)"/>
  <text x="832" y="52" font-size="16" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Cloudflare: D1 + R2</text>
  <text x="625" y="100" font-size="14" fill="var(--ink)" font-family="system-ui">R2 egress: $0.00 — zero bandwidth fees</text>
  <text x="625" y="128" font-size="14" fill="var(--ink-dim)" font-family="system-ui">D1: 5M row reads free / day</text>
  <text x="625" y="156" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Bound via wrangler.toml — no credentials</text>
  <text x="625" y="184" font-size="14" fill="var(--ink-dim)" font-family="system-ui">Co-located with Worker — sub-ms latency</text>
  <text x="625" y="220" font-size="14" fill="var(--success)" font-family="system-ui">10M row reads/day = $0.00 egress</text>
  <text x="625" y="248" font-size="14" fill="var(--success)" font-family="system-ui">1 TB R2 download from Worker = $0.00</text>
  <text x="625" y="280" font-size="13" fill="var(--muted)" font-family="system-ui">store AI outputs freely — egress is free</text>
  <circle cx="548" cy="160" r="28" fill="var(--accent)"/>
  <text x="548" y="165" font-size="14" font-weight="700" fill="white" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Switch to D1 + R2 and egress vanishes from the bill — store every AI output, chat log, and generated file without cost anxiety.</div>

<!-- Speaker: At scale, the difference between $90/TB and $0 compounds every month. This is the cost story of Cloudflare AI — egress is the hidden tax that disappears. -->

---

## AI Gateway: Cache, Route, Control

<p class="subhead">Sits between Worker and every AI provider — adds caching, fallback, rate limits, and spend caps in one config.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3" style="align-self:center; width:100%;">
  <div class="card">
    <p class="label">Cost control</p>
    <h3>Response Caching</h3>
    <p>Identical prompt hash → return cached response. Configurable TTL. One cache hit saves the full token cost.</p>
  </div>
  <div class="card success">
    <p class="label">Reliability</p>
    <h3>Model Fallback</h3>
    <p>OpenAI 503 → auto-route to Anthropic or Workers AI. Chain multiple providers; configure in dashboard — no code change.</p>
  </div>
  <div class="card warning">
    <p class="label">Safety</p>
    <h3>Real-time Spend Limits</h3>
    <p>Hard budget cap per gateway. Requests halt the moment the limit hits — no surprise bill from a prompt loop or DDoS.</p>
  </div>
  <div class="card">
    <p class="label">Governance</p>
    <h3>Rate Limiting</h3>
    <p>Requests/tokens per minute per user. Block abusive clients without touching Worker code.</p>
  </div>
  <div class="card">
    <p class="label">Observability</p>
    <h3>Full Request Logs</h3>
    <p>Every request logged: prompt, model, latency, token usage, cache hit/miss. Searchable from the dashboard.</p>
  </div>
  <div class="card gold">
    <p class="label">Cloudflare internal</p>
    <h3>20M Requests Routed</h3>
    <p>241B tokens processed. 3,683 internal users. Cloudflare runs the same AI Gateway they ship to customers.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> AI Gateway adds caching + fallback + spend limits in one gateway binding — no SDK change, no new library, just a gateway config.</div>

<!-- Speaker: The spend limit feature alone prevents runaway costs from infinite retry loops. The cache pays for itself after the first repeated identical prompt. -->

---

## Cloudflare Access: Zero-Trust Auth, Zero Code

<p class="subhead">Put enterprise SSO in front of any Worker — JWT validates before code runs, no auth library needed.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Supported providers</p>
    <h3>SSO without SDK</h3>
    <ul>
      <li>Google Workspace</li>
      <li>GitHub OAuth</li>
      <li>Azure AD / SAML</li>
      <li>OIDC / custom IdP</li>
    </ul>
  </div>
  <div class="card">
    <p class="label">How it works</p>
    <h3>JWT at the Edge</h3>
    <p>Access injects <code>CF-Access-JWT-Assertion</code> header. Worker reads it directly — no session cookie, no auth middleware to maintain.</p>
  </div>
  <div class="card gold">
    <p class="label">Setup</p>
    <h3>Dashboard only</h3>
    <p>Zero Trust → Access → Add application → pick Worker URL → pick IdP. Done. Zero lines of auth code in your app.</p>
  </div>
  <div class="card warning">
    <p class="label">Best for</p>
    <h3>Internal AI Tools</h3>
    <p>Admin panels, internal agents, GPT-wrapper tools for your team — gate with company SSO without building a login flow.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cloudflare Access adds enterprise auth to any Worker in 5 dashboard clicks — no auth code, no library, no session management.</div>

<!-- Speaker: This is the "no code" auth story for internal tools. If you're building a GPT wrapper for your team, Access is the fastest path to SSO. -->

---

## Bindings: The Glue That Removes API Keys

<p class="subhead">Declare services in wrangler.toml — runtime injects typed TypeScript interfaces; credentials never enter source code.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="400" y="110" width="300" height="100" rx="12" fill="var(--accent)" style="filter:drop-shadow(var(--shadow-md))"/>
  <text x="550" y="152" font-size="16" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">Worker</text>
  <text x="550" y="174" font-size="13" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">env.AI  env.DB</text>
  <text x="550" y="194" font-size="13" fill="rgba(255,255,255,.85)" text-anchor="middle" font-family="system-ui">env.BUCKET  env.DO</text>
  <rect x="20" y="20" width="180" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="110" y="50" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Workers AI</text>
  <text x="110" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">env.AI binding</text>
  <line x1="200" y1="55" x2="400" y2="148" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <rect x="20" y="230" width="180" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="110" y="260" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Durable Objects</text>
  <text x="110" y="282" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">env.DO binding</text>
  <line x1="200" y1="265" x2="400" y2="185" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <rect x="900" y="20" width="180" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="990" y="50" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">D1 Database</text>
  <text x="990" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">env.DB binding</text>
  <line x1="900" y1="55" x2="700" y2="148" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <rect x="900" y="230" width="180" height="70" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="990" y="260" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">R2 Bucket</text>
  <text x="990" y="282" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">env.BUCKET binding</text>
  <line x1="900" y1="265" x2="700" y2="185" stroke="var(--accent)" stroke-width="1.5" stroke-dasharray="6,3"/>
  <rect x="375" y="260" width="350" height="55" rx="10" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="285" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">wrangler.toml</text>
  <text x="550" y="305" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">single source of truth — no .env file</text>
  <line x1="550" y1="260" x2="550" y2="210" stroke="var(--gold)" stroke-width="2" stroke-dasharray="5,3"/>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Bindings are the security architecture — credentials live in Cloudflare's runtime, never in source code, never in environment variables.</div>

<!-- Speaker: Every arrow here is declared in wrangler.toml — no API key appears anywhere in TypeScript. This is Cloudflare's core security insight: move credentials into the platform. -->

---

## Agents SDK + cf CLI: Scaffold to Deploy in Minutes

<p class="subhead">Agents Week 2026 — production-ready agent with WebSockets, DO state, and tool calls out of the box.</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="80" width="180" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="100" y="120" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">npm create</text>
  <text x="100" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">cloudflare@latest</text>
  <text x="100" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">--template ai-agent</text>
  <line x1="190" y1="130" x2="220" y2="130" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="220,125 230,130 220,135" fill="var(--accent)"/>
  <rect x="230" y="80" width="160" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="310" y="120" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">npm run dev</text>
  <text x="310" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">localhost:8787</text>
  <text x="310" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">live reload</text>
  <line x1="390" y1="130" x2="420" y2="130" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="420,125 430,130 420,135" fill="var(--accent)"/>
  <rect x="430" y="60" width="190" height="120" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="525" y="105" font-size="12" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">Add Bindings</text>
  <text x="525" y="125" font-size="11" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">AI + D1 + R2 + DO</text>
  <text x="525" y="145" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">wrangler.toml</text>
  <text x="525" y="165" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">critical step</text>
  <line x1="620" y1="130" x2="650" y2="130" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="650,125 660,130 650,135" fill="var(--accent)"/>
  <rect x="660" y="80" width="160" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="740" y="120" font-size="12" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">cf deploy</text>
  <text x="740" y="140" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">330+ PoPs</text>
  <text x="740" y="160" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">instant global</text>
  <line x1="820" y1="130" x2="850" y2="130" stroke="var(--accent)" stroke-width="2"/>
  <polygon points="850,125 860,130 850,135" fill="var(--accent)"/>
  <rect x="860" y="80" width="215" height="100" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="967" y="118" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">wrangler tail</text>
  <text x="967" y="138" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">live logs + AI Gateway</text>
  <text x="967" y="158" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">dashboard monitoring</text>
  <rect x="270" y="208" width="560" height="30" rx="8" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1"/>
  <text x="550" y="226" font-size="11" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Agents SDK: WebSockets + DO state + cron tasks + MCP tools + browser automation + payments</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> npm create cloudflare + ai-agent template gives state, WebSockets, tools, and 330-PoP global deploy — no infra provisioning at all.</div>

<!-- Speaker: The cf CLI unifies wrangler, d1, r2, and ai into one command. The ai-agent template wires DO state + WebSocket + tools by default — deploy in under 10 minutes. -->

---

## User Guide: 7 Steps to First AI Worker

<p class="subhead">From zero to deployed AI app — each step adds one binding; entire stack is live in under 10 minutes.</p>

<div class="infographic">
<svg viewBox="0 0 1100 260" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="240" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="42" cy="55" r="18" fill="var(--accent)"/>
  <text x="42" y="60" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="82" y="44" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Install + Auth</text>
  <text x="82" y="62" font-size="11" fill="var(--ink-dim)" font-family="system-ui">npm i -g wrangler</text>
  <text x="82" y="80" font-size="11" fill="var(--muted)" font-family="system-ui">wrangler login</text>
  <line x1="250" y1="55" x2="270" y2="55" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="270,50 280,55 270,60" fill="var(--muted)"/>
  <rect x="280" y="10" width="240" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="312" cy="55" r="18" fill="var(--accent)"/>
  <text x="312" y="60" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="352" y="44" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Scaffold</text>
  <text x="352" y="62" font-size="11" fill="var(--ink-dim)" font-family="system-ui">npm create cloudflare</text>
  <text x="352" y="80" font-size="11" fill="var(--muted)" font-family="system-ui">TypeScript Worker</text>
  <line x1="520" y1="55" x2="540" y2="55" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="540,50 550,55 540,60" fill="var(--muted)"/>
  <rect x="550" y="10" width="240" height="90" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <circle cx="582" cy="55" r="18" fill="var(--accent)"/>
  <text x="582" y="60" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="622" y="44" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Add Bindings</text>
  <text x="622" y="62" font-size="11" fill="var(--ink-dim)" font-family="system-ui">AI + D1 + R2 in toml</text>
  <text x="622" y="80" font-size="11" fill="var(--accent)" font-family="system-ui">most important step</text>
  <line x1="790" y1="55" x2="810" y2="55" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="810,50 820,55 810,60" fill="var(--muted)"/>
  <rect x="820" y="10" width="260" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="852" cy="55" r="18" fill="var(--accent)"/>
  <text x="852" y="60" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="892" y="44" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Create D1 + R2</text>
  <text x="892" y="62" font-size="11" fill="var(--ink-dim)" font-family="system-ui">wrangler d1 create</text>
  <text x="892" y="80" font-size="11" fill="var(--muted)" font-family="system-ui">wrangler r2 bucket create</text>
  <rect x="140" y="155" width="240" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="172" cy="200" r="18" fill="var(--accent)"/>
  <text x="172" y="205" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="212" y="188" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">AI Gateway</text>
  <text x="212" y="206" font-size="11" fill="var(--ink-dim)" font-family="system-ui">optional but recommended</text>
  <text x="212" y="224" font-size="11" fill="var(--muted)" font-family="system-ui">cache + spend limits</text>
  <line x1="380" y1="200" x2="400" y2="200" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="400,195 410,200 400,205" fill="var(--muted)"/>
  <rect x="410" y="155" width="240" height="90" rx="10" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="442" cy="200" r="18" fill="var(--accent)"/>
  <text x="442" y="205" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">6</text>
  <text x="482" y="188" font-size="12" font-weight="700" fill="var(--ink)" font-family="system-ui">Deploy</text>
  <text x="482" y="206" font-size="11" fill="var(--ink-dim)" font-family="system-ui">wrangler deploy</text>
  <text x="482" y="224" font-size="11" fill="var(--muted)" font-family="system-ui">workers.dev URL</text>
  <line x1="650" y1="200" x2="670" y2="200" stroke="var(--muted)" stroke-width="1.5"/>
  <polygon points="670,195 680,200 670,205" fill="var(--muted)"/>
  <rect x="680" y="155" width="250" height="90" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <circle cx="712" cy="200" r="18" fill="var(--success)"/>
  <text x="712" y="205" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">7</text>
  <text x="752" y="188" font-size="12" font-weight="700" fill="var(--success-ink)" font-family="system-ui">Access (optional)</text>
  <text x="752" y="206" font-size="11" fill="var(--success-ink)" font-family="system-ui">Zero Trust dashboard</text>
  <text x="752" y="224" font-size="11" fill="var(--muted)" font-family="system-ui">enterprise SSO, 0 code</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Step 3 (Bindings) is the key moment — once declared in wrangler.toml, env.AI / env.DB / env.BUCKET are typed and ready to call immediately.</div>

<!-- Speaker: Walk through these 7 steps once with live coding and the platform clicks. Step 3 is where Cloudflare's philosophy becomes tangible. -->

---

## Caveats and Real Limits

<p class="subhead">Free tier covers experiments; Durable Objects and production throughput require the $5/mo Paid plan.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card warning">
    <p class="label">Workers AI free tier</p>
    <h3>10K neurons/day</h3>
    <p>1 neuron ≈ 1 text token or 1 image pixel batch. ~20 GPT-4-class responses per day on free. Upgrade for production traffic.</p>
  </div>
  <div class="card danger">
    <p class="label">Durable Objects</p>
    <h3>Paid plan only</h3>
    <p>Not on Free tier. $5/mo minimum. First-request cold start ~100ms. Max 128 KB per key — use R2 for large payloads.</p>
  </div>
  <div class="card">
    <p class="label">D1 free limits</p>
    <h3>5M reads, 100K writes</h3>
    <p>Per day. Generous for development. No GUI migration tool yet — schema changes run via <code>wrangler d1 execute</code>.</p>
  </div>
  <div class="card">
    <p class="label">R2 free limits</p>
    <h3>10 GB, 1M Class-A ops</h3>
    <p>Per month. Worker reads are free; public internet reads cost $0.015/GB. S3-compatible — existing AWS SDKs work.</p>
  </div>
  <div class="card warning">
    <p class="label">AI Gateway</p>
    <h3>Cache = exact hash</h3>
    <p>Minor wording change = full cache miss. Model fallback chain must be manually configured per gateway in the dashboard.</p>
  </div>
  <div class="card warning">
    <p class="label">GDPR</p>
    <h3>DO jurisdiction flag</h3>
    <p>EU user data must set <code>jurisdiction: "eu"</code> in binding. Default is global routing — non-compliant without this flag.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Free tier handles 10K AI calls/day and 10 GB storage — enough to build and demo. Durable Objects require the paid plan; budget $5/mo minimum.</div>

<!-- Speaker: The free tier is real — use it for MVPs and demos. But plan for Durable Objects early; it's the one primitive that requires upgrading to show full platform power. -->

---

## Key Takeaways

<p class="subhead">Seven facts worth keeping about the Cloudflare AI platform.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card gold">
    <p class="label">Architecture</p>
    <h3>Bindings = no API keys</h3>
    <p>Every service (AI, DB, storage, auth) wired in runtime via wrangler.toml. Credentials never appear in source code.</p>
  </div>
  <div class="card">
    <p class="label">State</p>
    <h3>DO = per-session isolation</h3>
    <p>Compute + SQLite per instance. Replaces Redis + DB coordination for chat, game state, and collaboration.</p>
  </div>
  <div class="card success">
    <p class="label">Cost</p>
    <h3>D1 + R2 = zero egress</h3>
    <p>No data transfer fee when reading from the same Worker. Store AI outputs and chat logs without billing anxiety.</p>
  </div>
  <div class="card">
    <p class="label">Control</p>
    <h3>AI Gateway saves money</h3>
    <p>Cache identical prompts, fallback on outage, cap spending. 20M requests + 241B tokens processed internally at Cloudflare.</p>
  </div>
  <div class="card">
    <p class="label">Scale</p>
    <h3>330+ edge PoPs</h3>
    <p>Inference near the user. Sub-millisecond Worker start. No cold-start tax vs container-based inference.</p>
  </div>
  <div class="card warning">
    <p class="label">Limit</p>
    <h3>DO needs paid plan</h3>
    <p>$5/mo minimum. Free tier covers Workers AI 10K neurons/day + R2 10 GB/mo — plenty for MVP and demos.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> One wrangler.toml. No API keys. Edge inference. Zero-egress storage. This is the cost-effective, secure default stack for AI-native apps on Cloudflare.</div>

<!-- Speaker: The meta-takeaway: Cloudflare solved the four broken seams of traditional AI stacks in a single platform. If you're starting a new AI app, this is the default stack to evaluate first. -->
