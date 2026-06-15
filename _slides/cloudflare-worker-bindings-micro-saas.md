---
marp: true
theme: default
paginate: true
title: "Cloudflare Worker Bindings: No-API-Key Architecture for Micro SaaS"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f5f3ff; --soft-2:#ede9fe;
    --accent:#8B5CF6; --accent-deep:#5B21B6; --accent-wash:#ede9fe; --gold:#F59E0B;
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
  .img-card { margin:0; padding:8px; background:var(--paper); border-radius:var(--radius); box-shadow:var(--shadow-lg); max-width:100%; max-height:100%; display:flex; flex-direction:column; align-items:center; min-height:0; box-sizing:border-box; }
  .img-card img { display:block; max-width:100%; max-height:100%; width:auto; height:auto; object-fit:contain; margin:0 auto; border-radius:var(--radius-sm); min-height:0; }
  .img-card figcaption { font-size:11px; color:var(--muted); padding:8px 6px 2px; text-align:center; flex-shrink:0; }
  .src { position:absolute; bottom:20px; left:64px; font-size:10px; color:var(--muted); letter-spacing:.02em; }
  section.title {
    background:linear-gradient(135deg,#0F172A 0%,#5B21B6 100%);
    color:white; justify-content:center;
  }
  section.title::before { display:none; }
  section.title h1 { font-size:46px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

<div class="mark"></div>

# Cloudflare Worker Bindings

<p class="tag">No-API-Key Architecture for Micro SaaS — AI + R2 + D1 + Browser Run in one Workers stack</p>

<!-- Speaker: Cloudflare Bindings solve the #1 SaaS secret-management problem — credentials embedded in runtime, never in code. -->

---

## TL;DR: API Keys Are in Runtime, Not in Your Code

<p class="subhead">Worker accesses 25+ services without storing a single credential — runtime injects them at deploy time.</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="480" height="250" rx="12" fill="var(--paper)" stroke="var(--danger)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="480" height="50" rx="12" fill="var(--danger-wash)"/>
  <text x="270" y="51" font-size="15" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">BEFORE: API Keys in Code</text>
  <text x="60" y="96" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">const ai = new AI(process.env.OPENAI_KEY)</text>
  <text x="60" y="122" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">const db = new Pool(process.env.DATABASE_URL)</text>
  <text x="60" y="148" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">const s3 = new S3({key: process.env.AWS_KEY})</text>
  <text x="60" y="184" font-size="12" fill="var(--danger)" font-family="system-ui">Keys scattered: .env, CI/CD, secrets manager</text>
  <text x="60" y="206" font-size="12" fill="var(--danger)" font-family="system-ui">Leak surface: logs, bundle, error traces</text>
  <text x="60" y="228" font-size="12" fill="var(--danger)" font-family="system-ui">Rotate = update CI + redeploy all services</text>
  <circle cx="550" cy="145" r="32" fill="var(--accent)"/>
  <text x="550" y="150" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
  <rect x="590" y="20" width="480" height="250" rx="12" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="590" y="20" width="480" height="50" rx="12" fill="var(--success-wash)"/>
  <text x="830" y="51" font-size="15" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">AFTER: Cloudflare Bindings</text>
  <text x="620" y="96" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">await env.AI.run(model, {prompt})</text>
  <text x="620" y="122" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">await env.DB.prepare(sql).all()</text>
  <text x="620" y="148" font-size="12" fill="var(--ink)" font-family="system-ui,monospace">await env.BUCKET.put(key, data)</text>
  <text x="620" y="184" font-size="12" fill="var(--success-ink)" font-family="system-ui">wrangler.toml = single source of truth</text>
  <text x="620" y="206" font-size="12" fill="var(--success-ink)" font-family="system-ui">Zero credentials in source, bundle, or logs</text>
  <text x="620" y="228" font-size="12" fill="var(--success-ink)" font-family="system-ui">Rotate from dashboard — no redeploy needed</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Bindings embed permissions in runtime — no .env file, no secrets manager, no credential leak surface in code.</div>

<!-- Speaker: The shift isn't just ergonomic — it eliminates an entire class of credential exposure vulnerabilities. -->

---

## Traditional SaaS: Every Provider Adds Secrets + Billing

<p class="subhead">Five providers = five separate API keys, five billing cycles, five leak surfaces. Micro SaaS teams pay this tax hardest.</p>

<div class="infographic">
<svg viewBox="0 0 1100 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="185" height="78" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="112" y="52" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">OpenAI</text>
  <text x="112" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">OPENAI_API_KEY</text>
  <rect x="222" y="20" width="185" height="78" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="314" y="52" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AWS S3</text>
  <text x="314" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">AWS_SECRET_KEY</text>
  <rect x="424" y="20" width="252" height="78" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="550" y="52" font-size="13" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">RDS / PlanetScale</text>
  <text x="550" y="72" font-size="11" fill="var(--danger)" text-anchor="middle" font-family="system-ui,monospace">DATABASE_URL + PASSWORD</text>
  <rect x="693" y="20" width="185" height="78" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="785" y="52" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browserless</text>
  <text x="785" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">BROWSER_API_TOKEN</text>
  <rect x="895" y="20" width="185" height="78" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="987" y="52" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Auth0</text>
  <text x="987" y="72" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">AUTH0_CLIENT_SECRET</text>
  <line x1="112" y1="98" x2="112" y2="144" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <line x1="314" y1="98" x2="314" y2="144" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <line x1="550" y1="98" x2="550" y2="144" stroke="var(--danger)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <line x1="785" y1="98" x2="785" y2="144" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <line x1="987" y1="98" x2="987" y2="144" stroke="var(--muted)" stroke-width="1.5" stroke-dasharray="4,3"/>
  <rect x="80" y="144" width="940" height="58" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="550" y="170" font-size="14" font-weight="700" fill="var(--danger)" text-anchor="middle" font-family="system-ui">5 billing cycles + 5 secret rotations + 5 leak surfaces</text>
  <text x="550" y="190" font-size="12" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">One exposed .env or CI variable = full credentials breach</text>
  <defs><marker id="ar1" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/></marker></defs>
  <line x1="550" y1="202" x2="550" y2="236" stroke="var(--accent)" stroke-width="2.5" marker-end="url(#ar1)"/>
  <rect x="200" y="236" width="700" height="52" rx="10" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="1.5"/>
  <text x="550" y="260" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Cloudflare: one wrangler.toml — all services, one bill, zero secrets in code</text>
  <text x="550" y="278" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">AI + R2 + D1 + Browser Run billed together on Cloudflare dashboard</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Multi-provider stacks multiply both billing and breach risk — Bindings collapse both to a single config file.</div>

<!-- Speaker: The cost isn't just money — managing 5+ secrets is the source of 80% of startup credential incidents. -->

---

## Binding Security Model: Runtime Injection Flow

<p class="subhead">Permission flows: Cloudflare Dashboard → wrangler.toml → Worker runtime — never through source code.</p>

<div class="infographic">
<svg viewBox="0 0 1100 310" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="390" y="100" width="320" height="110" rx="14" fill="var(--accent)" opacity=".1" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="148" font-size="16" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Worker Runtime</text>
  <text x="550" y="172" font-size="13" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,monospace">env.AI  env.DB  env.BUCKET  env.BROWSER</text>
  <rect x="30" y="115" width="230" height="80" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="145" y="148" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui,monospace">wrangler.toml</text>
  <text x="145" y="168" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">declares bindings + scope</text>
  <defs>
    <marker id="al" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/></marker>
    <marker id="at" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/></marker>
    <marker id="am" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker>
  </defs>
  <line x1="260" y1="155" x2="390" y2="155" stroke="var(--accent)" stroke-width="2" marker-end="url(#al)"/>
  <rect x="410" y="16" width="280" height="66" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="44" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Cloudflare Dashboard</text>
  <text x="550" y="64" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">secret store + rotation + audit log</text>
  <line x1="550" y1="82" x2="550" y2="100" stroke="var(--accent)" stroke-width="2" marker-end="url(#at)"/>
  <rect x="860" y="42" width="220" height="52" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="970" y="73" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Workers AI</text>
  <rect x="860" y="108" width="220" height="52" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="970" y="139" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">D1 Database</text>
  <rect x="860" y="174" width="220" height="52" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="970" y="205" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">R2 Storage</text>
  <rect x="860" y="240" width="220" height="52" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="970" y="271" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Browser Run</text>
  <line x1="710" y1="144" x2="860" y2="68" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#am)"/>
  <line x1="710" y1="152" x2="860" y2="134" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#am)"/>
  <line x1="710" y1="160" x2="860" y2="200" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#am)"/>
  <line x1="710" y1="168" x2="860" y2="266" stroke="var(--muted)" stroke-width="1.5" marker-end="url(#am)"/>
  <rect x="320" y="248" width="460" height="40" rx="20" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="273" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">No API key ever touches Worker source code</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Secret rotation happens in the dashboard — Worker code is unchanged; no redeploy, no CI pipeline update needed.</div>

<!-- Speaker: This is fundamentally different from environment variables — the credential never exists as a string in your process. -->

---

## 25+ Available Bindings: One wrangler.toml Rules Them All

<p class="subhead">Six service groups — all wired through the same runtime binding pattern.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">AI / ML</p>
    <h3>Workers AI + Vectorize</h3>
    <p>LLM inference, embeddings, vector search — all via <code>env.AI</code>. 50+ models included.</p>
  </div>
  <div class="card success">
    <p class="label">Storage</p>
    <h3>R2 + D1 + KV + Hyperdrive</h3>
    <p>Object storage, SQL, key-value, DB connection pooling. Zero egress fees on R2 and D1.</p>
  </div>
  <div class="card">
    <p class="label">Compute</p>
    <h3>Durable Objects + Queues + Workflows</h3>
    <p>Per-session state isolation, async task queue, long-running orchestration pipelines.</p>
  </div>
  <div class="card warning">
    <p class="label">Media</p>
    <h3>Browser Run + Images + Stream</h3>
    <p>Headless Chromium (Puppeteer/Playwright/CDP), image transform, video delivery.</p>
  </div>
  <div class="card danger">
    <p class="label">Auth / Security</p>
    <h3>Secrets + mTLS + Rate Limiting</h3>
    <p>Encrypted secrets store, mutual TLS cert binding, per-Worker rate limit rules.</p>
  </div>
  <div class="card gold">
    <p class="label">Platform</p>
    <h3>Analytics + Assets + Platforms</h3>
    <p>Custom metrics pipeline, static asset binding, multi-tenant Workers for Platforms.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Every binding uses the same env.X pattern — same DX across all 25+ services, same wrangler.toml config file.</div>

<!-- Speaker: The power is uniformity — a junior dev who learns env.AI can use env.BROWSER the same day. -->

---

## Complete Micro SaaS Stack: 4 Bindings, Zero API Keys

<p class="subhead">Web scraping + AI summary + SQL save + blob storage — one TypeScript Worker, one config file.</p>

<div class="infographic">
<svg viewBox="0 0 1100 280" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs><marker id="arf" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/></marker></defs>
  <text x="550" y="36" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Scraping + Summarization SaaS — complete TypeScript Worker, env.* only, zero credentials in code</text>
  <rect x="20" y="54" width="220" height="122" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="130" y="86" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">1. Browser Run</text>
  <text x="130" y="106" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,monospace">env.BROWSER</text>
  <text x="130" y="128" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">puppeteer.launch()</text>
  <text x="130" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">page.goto(url)</text>
  <text x="130" y="166" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">page.content()</text>
  <line x1="240" y1="115" x2="295" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#arf)"/>
  <text x="267" y="106" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HTML</text>
  <rect x="295" y="54" width="220" height="122" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="405" y="86" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">2. Workers AI</text>
  <text x="405" y="106" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,monospace">env.AI</text>
  <text x="405" y="128" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">llama-3.1-8b-instruct</text>
  <text x="405" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">summarize HTML</text>
  <text x="405" y="166" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">stream response</text>
  <line x1="515" y1="115" x2="570" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#arf)"/>
  <text x="542" y="106" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">summary</text>
  <rect x="570" y="54" width="220" height="122" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="680" y="86" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">3. D1 Database</text>
  <text x="680" y="106" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,monospace">env.DB</text>
  <text x="680" y="128" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">INSERT summaries</text>
  <text x="680" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">(url, summary, ts)</text>
  <text x="680" y="166" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">zero egress cost</text>
  <line x1="790" y1="115" x2="845" y2="115" stroke="var(--accent)" stroke-width="2" marker-end="url(#arf)"/>
  <text x="817" y="106" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">HTML blob</text>
  <rect x="845" y="54" width="235" height="122" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="2"/>
  <text x="962" y="86" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">4. R2 Storage</text>
  <text x="962" y="106" font-size="12" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui,monospace">env.BUCKET</text>
  <text x="962" y="128" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">BUCKET.put(key, html)</text>
  <text x="962" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">S3-compatible API</text>
  <text x="962" y="166" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">zero egress fee</text>
  <rect x="200" y="210" width="700" height="48" rx="10" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="550" y="234" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">All 4 steps run inside one Worker — no external HTTP calls, no API keys in code</text>
  <text x="550" y="250" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Response.json({summary}) — complete SaaS in ~50 lines of TypeScript</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Browser Run + AI + D1 + R2 = a complete scraping SaaS pipeline in one TypeScript Worker with zero API credentials.</div>

<!-- Speaker: Walk through the flow left to right — each step is just an env.* method call, no SDK init, no auth config. -->

---

## Browser Run: Headless Chromium at the Cloudflare Edge

<p class="subhead">Puppeteer, Playwright, and CDP running on Cloudflare's network — billed per browser hour, not per request.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card">
    <p class="label">Use Cases</p>
    <h3>What Browser Run Does</h3>
    <ul>
      <li>Web scraping and data extraction</li>
      <li>Screenshot and PDF generation</li>
      <li>UI automation and regression tests</li>
      <li>SPA pre-rendering for SEO</li>
      <li>AI agent browser control via CDP</li>
    </ul>
  </div>
  <div class="card warning">
    <p class="label">Two Billing Modes</p>
    <h3>Quick Actions vs Sessions</h3>
    <p><b>Quick Actions</b> — single-page ops only (screenshot, PDF, scrape). No multi-step interaction. $0.09/browser-hour.</p>
    <p><b>Browser Sessions</b> — full Puppeteer/Playwright/CDP. Multi-step automation supported. $0.09/hr compute + $2.00/concurrent browser/mo.</p>
    <p>Free tier: 10 min/day, 3 concurrent browsers.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Browser Run replaces Browserless.io or Apify at lower cost for small-scale SaaS — but concurrent billing scales steeply at high volume.</div>

<!-- Speaker: Free tier is just enough for dev and demo. Watch concurrent count in production — it's the cost multiplier. -->

---

## Browser Run Pricing: Calculate Concurrency Before You Scale

<p class="subhead">Two billing axes: compute hours and concurrent browsers. Plan the ceiling before you hit it.</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="480" height="250" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.06))"/>
  <rect x="30" y="20" width="480" height="52" rx="12" fill="var(--soft)"/>
  <text x="270" y="52" font-size="16" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Quick Actions</text>
  <text x="68" y="106" font-size="14" fill="var(--ink)" font-family="system-ui">Rate: $0.09 per browser hour</text>
  <text x="68" y="136" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Single-page operations only</text>
  <text x="68" y="162" font-size="13" fill="var(--ink-dim)" font-family="system-ui">No multi-step browser interaction</text>
  <text x="68" y="188" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Free: 10 min / day</text>
  <text x="68" y="240" font-size="24" font-weight="700" fill="var(--success-ink)" font-family="system-ui">$0.09 / hr</text>
  <circle cx="550" cy="145" r="32" fill="var(--accent)"/>
  <text x="550" y="150" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">VS</text>
  <rect x="590" y="20" width="480" height="250" rx="12" fill="var(--paper)" stroke="var(--warning)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.10))"/>
  <rect x="590" y="20" width="480" height="52" rx="12" fill="var(--warning-wash)"/>
  <text x="830" y="52" font-size="16" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Browser Sessions</text>
  <text x="628" y="106" font-size="14" fill="var(--ink)" font-family="system-ui">Compute: $0.09 / browser hour</text>
  <text x="628" y="136" font-size="14" fill="var(--warning-ink)" font-family="system-ui">Concurrent: $2.00 / browser / month</text>
  <text x="628" y="162" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Puppeteer + Playwright + CDP</text>
  <text x="628" y="190" font-size="13" fill="var(--ink-dim)" font-family="system-ui">Example: 50 hr + 20 concurrent browsers</text>
  <text x="628" y="214" font-size="13" fill="var(--ink-dim)" font-family="system-ui">= $3.60 + $10.00 = $13.60 / month</text>
  <text x="628" y="242" font-size="13" fill="var(--warning-ink)" font-family="system-ui">vs Browserless.io $25+ / month</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> 50 concurrent browsers = $100/mo in browser fees alone — use Quick Actions for single-page ops, Sessions only when multi-step is truly required.</div>

<!-- Speaker: Most Micro SaaS scraping is single-page — default to Quick Actions and only upgrade when you need multi-step interaction. -->

---

## Caveats: Three Risks to Plan Around

<p class="subhead">Cost at concurrent scale, portability, and runtime constraints — each addressable with the right approach.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Cost Risk</p>
    <h3>Browser Run at High Concurrency</h3>
    <p>$2.00/concurrent browser/mo means 50 concurrent = $100/mo in browser fees alone.</p>
    <p>Fix: use Quick Actions for single-page ops; Sessions only for multi-step flows.</p>
  </div>
  <div class="card danger">
    <p class="label">Portability Risk</p>
    <h3>Vendor Lock-in Grows with Bindings</h3>
    <p>D1 and Durable Objects have no standard-compatible alternatives. Migrating to AWS requires rewriting all <code>env.*</code> calls to AWS SDKs.</p>
    <p>Fix: abstract a service interface layer from day one.</p>
  </div>
  <div class="card">
    <p class="label">Runtime Limits</p>
    <h3>30s CPU / 128MB Memory</h3>
    <p>No native modules, no subprocess, no ffmpeg or sharp. Long jobs must use Workflows or Queues. Not suitable for GPU-scale inference or real-time game servers.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Lock-in is the hidden long-term cost — the more bindings you use, the harder migration becomes. Abstract your service layer from day one.</div>

<!-- Speaker: The runtime limits are the least surprising — the lock-in is what bites teams 18 months later. Plan the abstraction early. -->

---

## Micro SaaS Golden Path: From Zero to Deployed in 5 Steps

<p class="subhead">Workers + AI + D1 + R2 + Browser Run — full stack ready without provisioning any infrastructure.</p>

<div class="infographic">
<svg viewBox="0 0 1100 268" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="ar2" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/></marker>
    <marker id="ar3" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--gold)"/></marker>
  </defs>
  <rect x="10" y="24" width="188" height="110" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="40" cy="70" r="18" fill="var(--accent)"/>
  <text x="40" y="75" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">1</text>
  <text x="104" y="54" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Install + Auth</text>
  <text x="104" y="76" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">npm i -g wrangler</text>
  <text x="104" y="94" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">wrangler login</text>
  <line x1="198" y1="79" x2="228" y2="79" stroke="var(--accent)" stroke-width="2" marker-end="url(#ar2)"/>
  <rect x="228" y="24" width="188" height="110" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="258" cy="70" r="18" fill="var(--accent)"/>
  <text x="258" y="75" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">2</text>
  <text x="322" y="54" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Scaffold</text>
  <text x="322" y="76" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">npm create cloudflare</text>
  <text x="322" y="94" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">TypeScript template</text>
  <line x1="416" y1="79" x2="446" y2="79" stroke="var(--accent)" stroke-width="2" marker-end="url(#ar2)"/>
  <rect x="446" y="24" width="208" height="110" rx="12" fill="var(--soft)" stroke="var(--accent)" stroke-width="1.5"/>
  <circle cx="476" cy="70" r="18" fill="var(--accent)"/>
  <text x="476" y="75" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">3</text>
  <text x="550" y="54" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Enable Bindings</text>
  <text x="550" y="76" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">[ai] [[d1_databases]]</text>
  <text x="550" y="94" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">[[r2_buckets]] [browser]</text>
  <line x1="654" y1="79" x2="684" y2="79" stroke="var(--accent)" stroke-width="2" marker-end="url(#ar2)"/>
  <rect x="684" y="24" width="188" height="110" rx="12" fill="var(--soft)" stroke="var(--gold)" stroke-width="1.5"/>
  <circle cx="714" cy="70" r="18" fill="var(--gold)"/>
  <text x="714" y="75" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">4</text>
  <text x="778" y="54" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Create D1 + R2</text>
  <text x="778" y="76" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">wrangler d1 create</text>
  <text x="778" y="94" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui,monospace">wrangler r2 bucket create</text>
  <line x1="872" y1="79" x2="902" y2="79" stroke="var(--gold)" stroke-width="2" marker-end="url(#ar3)"/>
  <rect x="902" y="24" width="188" height="110" rx="12" fill="var(--success-wash)" stroke="var(--success)" stroke-width="2"/>
  <circle cx="932" cy="70" r="18" fill="var(--success)"/>
  <text x="932" y="75" font-size="14" font-weight="700" fill="white" text-anchor="middle" font-family="system-ui">5</text>
  <text x="996" y="54" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Deploy</text>
  <text x="996" y="76" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui,monospace">wrangler deploy</text>
  <text x="996" y="94" font-size="11" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Live in seconds</text>
  <rect x="200" y="164" width="700" height="80" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="550" y="194" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Daily workflow: wrangler dev (local) + wrangler tail (prod logs) + wrangler d1 execute (migrations)</text>
  <text x="550" y="220" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Workers AI, D1, R2, Browser Run — all simulated locally in wrangler dev, no cloud needed during development</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Zero infrastructure to provision — D1, R2, and Workers AI are available immediately after one wrangler.toml edit and deploy.</div>

<!-- Speaker: This is the fastest path to a production-ready SaaS stack — no AWS console, no VPC, no IAM roles. -->

---

## Key Takeaways

<p class="subhead">Six things to carry away from this deck.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-2">
  <div class="card success">
    <p class="label">Security</p>
    <h3>Bindings = No API Keys in Code</h3>
    <p>Credentials never touch source, bundle, or logs. Rotate from dashboard without redeploying Worker code.</p>
  </div>
  <div class="card">
    <p class="label">Stack Coverage</p>
    <h3>25+ Services, One DX Pattern</h3>
    <p>AI, R2, D1, Browser Run, DO, KV — all <code>env.X</code> in wrangler.toml. Learn once, apply everywhere.</p>
  </div>
  <div class="card warning">
    <p class="label">Cost Planning</p>
    <h3>Browser Run: Calc Concurrency First</h3>
    <p>$0.09/hr + $2.00/concurrent/mo. 50 concurrent = $100/mo in browser fees alone. Plan the ceiling upfront.</p>
  </div>
  <div class="card danger">
    <p class="label">Portability</p>
    <h3>Lock-in Grows with Binding Depth</h3>
    <p>D1 and Durable Objects are not portable. Abstract a service interface layer from day one to keep migration possible.</p>
  </div>
  <div class="card">
    <p class="label">Runtime Limits</p>
    <h3>30s CPU / 128MB per Invocation</h3>
    <p>No native modules. Long-running jobs: use Workflows or Queues. Not for GPU compute or real-time game servers.</p>
  </div>
  <div class="card gold">
    <p class="label">Micro SaaS Path</p>
    <h3>Workers + AI + D1 + R2 + Browser</h3>
    <p>Full SaaS stack, one billing account, zero secrets in code. Best ROI for solo teams and small startups.</p>
  </div>
</div>
</div>

<!-- Speaker: The binding architecture is Cloudflare's moat — it's what makes their platform genuinely different, not just cheaper. -->
