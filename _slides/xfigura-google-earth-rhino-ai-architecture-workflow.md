---
marp: true
theme: default
paginate: true
title: "xFigura: AI Architecture Design with Google Earth and Rhino"
style: |
  :root {
    --ink:#1e293b; --ink-dim:#475569; --muted:#94a3b8;
    --paper:#fff; --soft:#f1f5f9; --soft-2:#e2e8f0;
    --accent:#3b82f6; --accent-deep:#1e3a8a; --accent-wash:#dbeafe; --gold:#d4af37;
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
  section.title h1 { font-size:44px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/xfigura-google-earth-rhino-ai-architecture-workflow-cover.png)

<div class="mark"></div>

# xFigura: AI Architecture Design with Google Earth + Rhino

<p class="tag">4 workflows to place real buildings in real sites — from screenshot concepts to KMZ-anchored cinematic renders</p>

<!-- Speaker: xFigura is an AI canvas for architects. Today: 4 workflows that connect it to Google Earth and Rhino so designs land in real-world context, not a vacuum. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/xfigura-google-earth-rhino-ai-architecture-workflow-cheatsheet.png)

<!-- Speaker: 60-second orientation — 4 workflow panels, point at each before diving in. -->

---

## Context Beats Concept: Why Site-Grounded AI Rendering Wins

![bg right:40% contain](assets/xfigura-google-earth-rhino-ai-architecture-workflow-background.png)

<p class="subhead">A great-looking tower in a vacuum tells a client nothing about how it actually sits in their neighborhood.</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="660" height="280" rx="14" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="20" y="20" width="6" height="280" rx="3" fill="var(--accent)"/>
  <circle cx="90" cy="90" r="26" fill="var(--accent)" opacity=".12"/>
  <circle cx="90" cy="90" r="18" fill="var(--accent)"/>
  <text x="90" y="95" font-size="13" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">1</text>
  <text x="130" y="80" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Concept without site</text>
  <text x="130" y="100" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Polished, tells nobody how it fits</text>
  <circle cx="90" cy="170" r="26" fill="var(--gold)" opacity=".14"/>
  <circle cx="90" cy="170" r="18" fill="var(--gold)"/>
  <text x="90" y="175" font-size="13" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">2</text>
  <text x="130" y="160" font-size="14" font-weight="700" fill="var(--ink)" font-family="system-ui">Site-grounded generation</text>
  <text x="130" y="180" font-size="12" fill="var(--ink-dim)" font-family="system-ui">Real scale, light, neighbors</text>
  <circle cx="90" cy="240" r="5" fill="var(--muted)"/>
  <text x="130" y="245" font-size="11" fill="var(--muted)" font-family="system-ui">George Guida (ex Foster + Partners,</text>
  <text x="130" y="260" font-size="11" fill="var(--muted)" font-family="system-ui">Harvard); launched late 2025</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> xFigura's edge is bridging real-world geodata (Google Earth) and real modeling tools (Rhino/Speckle) with generative AI.</div>

<!-- Speaker: Quick founder/product context, then move straight into the 4 workflows. -->

---

## Workflow 1: Screenshot Concept — Site Context in Minutes

<p class="subhead">The fastest way to test an idea against a real site — rough and ready, iterate fast.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arrow1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0L10 5L0 10z" fill="var(--muted)"/>
    </marker>
  </defs>
  <g font-family="system-ui">
    <rect x="30" y="120" width="220" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="140" y="155" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Generate tower</text>
    <text x="140" y="178" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Text prompt + Nano</text>
    <text x="140" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Banana Pro model</text>
    <line x1="250" y1="170" x2="300" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow1)"/>
    <rect x="305" y="120" width="220" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="415" y="155" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Capture site</text>
    <text x="415" y="178" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Google Earth web,</text>
    <text x="415" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle">clean mode, screenshot</text>
    <line x1="525" y1="170" x2="575" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow1)"/>
    <rect x="580" y="120" width="220" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="690" y="155" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Mark site</text>
    <text x="690" y="178" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Built-in editor,</text>
    <text x="690" y="196" font-size="12" fill="var(--ink-dim)" text-anchor="middle">red outline</text>
    <line x1="800" y1="170" x2="850" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arrow1)"/>
    <rect x="855" y="110" width="215" height="120" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
    <text x="962" y="150" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle">Combine node</text>
    <text x="962" y="173" font-size="12" fill="var(--ink)" text-anchor="middle">wide aspect ratio,</text>
    <text x="962" y="191" font-size="12" fill="var(--ink)" text-anchor="middle">prompt: fit + match</text>
    <text x="962" y="209" font-size="12" fill="var(--ink)" text-anchor="middle">scale/perspective</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Start low-res, upscale later; for lighting variants say "keep context and perspective the same, only changing the lighting."</div>

<!-- Speaker: Emphasize this is the quick-iteration workflow — rough by design. -->

---

## Workflow 2: Connect Rhino Directly to the Canvas

<p class="subhead">Bridges the modeling tool architects already use with real-time AI context generation.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arrow2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0L10 5L0 10z" fill="var(--muted)"/>
    </marker>
  </defs>
  <g font-family="system-ui">
    <rect x="30" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="145" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Install plugin</text>
    <text x="145" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Tools &gt; Package Manager</text>
    <text x="145" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">search "xfigure"</text>
    <line x1="260" y1="170" x2="310" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow2)"/>
    <rect x="315" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="430" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Launch in viewport</text>
    <text x="430" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">render mode,</text>
    <text x="430" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">type `xfigure`</text>
    <line x1="545" y1="170" x2="595" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow2)"/>
    <rect x="600" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="715" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Screenshot button</text>
    <text x="715" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">viewport syncs</text>
    <text x="715" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">straight to canvas</text>
    <line x1="830" y1="170" x2="880" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arrow2)"/>
    <rect x="885" y="110" width="185" height="120" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
    <text x="977" y="150" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle">Scale-match</text>
    <text x="977" y="173" font-size="12" fill="var(--ink)" text-anchor="middle">circle a reference</text>
    <text x="977" y="191" font-size="12" fill="var(--ink)" text-anchor="middle">building in red</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Always set the aspect ratio explicitly — otherwise the output defaults to the first image's ratio. Qwen Edit model gives angle/rotation control without new imports.</div>

<!-- Speaker: This is the workflow for teams whose whole process already lives in Rhino. -->

---

## Workflow 3: Google Earth Pro 3D Massing for Facade Renders

<p class="subhead">Desktop Google Earth Pro gives precise geometric massing that AI can dress with real facades.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arrow3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0L10 5L0 10z" fill="var(--muted)"/>
    </marker>
  </defs>
  <g font-family="system-ui">
    <rect x="30" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="145" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Draw polygon</text>
    <text x="145" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Google Earth Pro,</text>
    <text x="145" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Add Polygon tool</text>
    <line x1="260" y1="170" x2="310" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
    <rect x="315" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="430" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Add volume</text>
    <text x="430" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">Altitude tab,</text>
    <text x="430" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">"extend sides to ground"</text>
    <line x1="545" y1="170" x2="595" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow3)"/>
    <rect x="600" y="120" width="230" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="715" y="150" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle">Upload references</text>
    <text x="715" y="173" font-size="12" fill="var(--ink-dim)" text-anchor="middle">facade + landscape</text>
    <text x="715" y="191" font-size="12" fill="var(--ink-dim)" text-anchor="middle">image loaders</text>
    <line x1="830" y1="170" x2="880" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arrow3)"/>
    <rect x="885" y="110" width="185" height="120" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
    <text x="977" y="150" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle">Combine + render</text>
    <text x="977" y="173" font-size="12" fill="var(--ink)" text-anchor="middle">detailed prompt on</text>
    <text x="977" y="191" font-size="12" fill="var(--ink)" text-anchor="middle">how each image maps</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Long, explicit prompts matter here — the AI must know which reference maps to facade vs. landscaping. Multi-image batches may drift off-angle; hand-pick the correct one.</div>

<!-- Speaker: This is the precision workflow — desktop Pro app, not the web version. -->

---

## Workflow 4: KMZ Export with Earth Anchor Point

<p class="subhead">Anchors the full Rhino model to exact real-world coordinates, then drives a cinematic animation.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arrow4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0L10 5L0 10z" fill="var(--muted)"/>
    </marker>
  </defs>
  <g font-family="system-ui">
    <rect x="20" y="120" width="200" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="120" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle">Get coordinates</text>
    <text x="120" y="173" font-size="11" fill="var(--ink-dim)" text-anchor="middle">Earth Pro pin icon</text>
    <text x="120" y="191" font-size="11" fill="var(--ink-dim)" text-anchor="middle">lat / lon</text>
    <line x1="220" y1="170" x2="265" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow4)"/>
    <rect x="270" y="120" width="200" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="370" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle">Anchor in Rhino</text>
    <text x="370" y="173" font-size="11" fill="var(--ink-dim)" text-anchor="middle">`EarthAnchorPoint`</text>
    <text x="370" y="191" font-size="11" fill="var(--ink-dim)" text-anchor="middle">base point + north</text>
    <line x1="470" y1="170" x2="515" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow4)"/>
    <rect x="520" y="120" width="200" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="620" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle">Export KMZ</text>
    <text x="620" y="173" font-size="11" fill="var(--ink-dim)" text-anchor="middle">render mode,</text>
    <text x="620" y="191" font-size="11" fill="var(--ink-dim)" text-anchor="middle">Google Earth format</text>
    <line x1="720" y1="170" x2="765" y2="170" stroke="var(--muted)" stroke-width="2" marker-end="url(#arrow4)"/>
    <rect x="770" y="120" width="150" height="100" rx="12" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5"/>
    <text x="845" y="150" font-size="13" font-weight="700" fill="var(--ink)" text-anchor="middle">Reopen + shot</text>
    <text x="845" y="173" font-size="11" fill="var(--ink-dim)" text-anchor="middle">exact placement,</text>
    <text x="845" y="191" font-size="11" fill="var(--ink-dim)" text-anchor="middle">screenshot</text>
    <line x1="920" y1="170" x2="960" y2="170" stroke="var(--accent)" stroke-width="2" marker-end="url(#arrow4)"/>
    <rect x="965" y="110" width="115" height="120" rx="12" fill="var(--accent)" opacity=".08" stroke="var(--accent)" stroke-width="2"/>
    <text x="1022" y="150" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle">Enhance +</text>
    <text x="1022" y="168" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle">video node</text>
    <text x="1022" y="191" font-size="11" fill="var(--ink)" text-anchor="middle">Sea Dance model</text>
  </g>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Shoot the base screenshot at exactly 16:9 to keep the camera angle stable; set Rhino perspective lens to 21mm to match Google Earth's camera.</div>

<!-- Speaker: This is the deliverable-grade workflow — precise placement plus cinematic output. -->

---

## Quick-Start: Which Workflow to Reach For

<p class="subhead">Pick by how much precision and tooling the task actually needs.</p>

<div class="infographic">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Fastest</p>
    <h3>Screenshot concept</h3>
    <p>Google Earth web + text prompt. Minutes per iteration.</p>
  </div>
  <div class="card compact success">
    <p class="label">Existing model</p>
    <h3>Rhino canvas</h3>
    <p>Plugin screenshot button, live sync to xFigura.</p>
  </div>
  <div class="card compact warning">
    <p class="label">Precise siting</p>
    <h3>Earth Pro massing</h3>
    <p>Polygon + altitude, then facade/landscape render.</p>
  </div>
  <div class="card compact gold">
    <p class="label">Deliverable</p>
    <h3>KMZ + anchor</h3>
    <p>Exact coordinates, render + cinematic animation.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> If aspect ratio or KMZ position looks wrong, check the first-node aspect ratio and the `EarthAnchorPoint` coordinates first — those are the two most common mistakes.</div>

<!-- Speaker: This is the "which door do I walk through" slide — useful as a recap. -->

---

## Caveats: What This Workflow Doesn't Solve

<p class="subhead">Powerful for concept and pitch work — know where the edges are before promising a client more.</p>

<div class="infographic">
<div class="bento cols-3">
  <div class="card compact warning">
    <p class="label">Cost</p>
    <h3>Paid platform</h3>
    <p>Academic discount exists, but check current pricing before onboarding a team.</p>
  </div>
  <div class="card compact danger">
    <p class="label">Not deterministic</p>
    <h3>Perspective drift</h3>
    <p>Multi-image batch generation can return off-angle results — pick manually.</p>
  </div>
  <div class="card compact">
    <p class="label">Output grade</p>
    <h3>Concept, not CD</h3>
    <p>Generative renders are pitch material, not construction documents.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> KML/KMZ files usually carry no true 3D geometry — round-tripping back into Rhino has real geometry-fidelity limits.</div>

<!-- Speaker: Set expectations before the audience assumes this replaces CD production. -->

---

## Key Takeaways

<p class="subhead">What to remember even if you skip the rest of the deck.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">EarthAnchor</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Point command</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">4 workflows</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">screenshot &#8594; KMZ</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Aspect ratio</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">set it explicitly</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">16:9 shots,</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">21mm lens</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Concept-grade,</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">not CD-grade</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> `EarthAnchorPoint` in Rhino is the single command that makes real-world placement work — get lat/lon and north direction right, and everything downstream (KMZ, render, video) lines up.</div>

<!-- Speaker: Close on the anchor point — it's the technical crux of the whole pipeline. -->
