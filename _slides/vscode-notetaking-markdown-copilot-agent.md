---
marp: true
theme: default
paginate: true
title: "VS Code for Note-taking, Markdown & Copilot Agent"
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
  section.title h1 { font-size:48px; color:white; margin:0 0 16px; line-height:1.15; font-weight:800; }
  section.title .tag { font-size:18px; color:rgba(255,255,255,.75); margin:0; font-weight:400; }
  section.title .mark { width:56px; height:4px; background:var(--gold); border-radius:2px; margin-bottom:20px; }
---

<!-- _class: title -->

![bg opacity:.25](assets/vscode-notetaking-markdown-copilot-agent-cover.png)

<div class="mark"></div>

# VS Code for Note-Taking, Markdown & Copilot Agent

<p class="tag">Side-by-side preview, dictation, checklists, themes — plus Copilot Agent scaffolding, tables, and release notes</p>

<!-- Speaker: VS Code isn't just a code editor — it's a capable note-taking tool once you layer in the right extensions and Copilot Agent mode. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/vscode-notetaking-markdown-copilot-agent-cheatsheet.png)

<!-- Speaker: 60-second orientation — nine concepts on one page, point at each zone before diving in. -->

---

## Why VS Code for Notes, Not Just Code

<p class="subhead">Local-first, plain-text `.md` files, and an extension ecosystem large enough to replace a dedicated note app.</p>

<div class="infographic">
<svg viewBox="0 0 1100 380" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="60" y="40" width="980" height="300" rx="16" fill="var(--paper)" stroke="var(--soft-2)" stroke-width="1.5" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="60" y="40" width="8" height="300" rx="4" fill="var(--accent)"/>
  <circle cx="148" cy="190" r="40" fill="var(--accent)" opacity=".12"/>
  <circle cx="148" cy="190" r="28" fill="var(--accent)"/>
  <text x="148" y="196" font-size="18" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">+</text>
  <text x="220" y="150" font-size="20" font-weight="700" fill="var(--ink)" font-family="system-ui">Portable plain-text over app lock-in</text>
  <text x="220" y="185" font-size="15" fill="var(--ink-dim)" font-family="system-ui">Files are `.md` — readable outside VS Code, versionable in git</text>
  <text x="220" y="215" font-size="15" fill="var(--muted)" font-family="system-ui">Extensions fill the gaps: preview, checklist, dictation, theming</text>
  <text x="220" y="245" font-size="15" fill="var(--muted)" font-family="system-ui">Copilot Agent adds AI-assisted document workflows on top</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Local-first plain text plus a mature extension ecosystem turns VS Code into a full note-taking tool.</div>

<!-- Speaker: Frame this as "why bother" before going feature-by-feature. -->

---

## Side-by-Side Preview and Interactive Checklists

![bg right:40% contain](assets/vscode-notetaking-markdown-copilot-agent-preview.png)

<p class="subhead">Ctrl+K V splits the pane; task-list checkboxes render but aren't clickable by default.</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="30" width="290" height="260" rx="10" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <text x="165" y="60" font-size="14" font-weight="700" fill="var(--ink-dim)" text-anchor="middle" font-family="system-ui">Editor</text>
  <text x="45" y="100" font-size="13" fill="var(--muted)" font-family="monospace">- [ ] Draft outline</text>
  <text x="45" y="125" font-size="13" fill="var(--muted)" font-family="monospace">- [x] Research done</text>
  <rect x="390" y="30" width="290" height="260" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="535" y="60" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Preview</text>
  <rect x="415" y="90" width="14" height="14" rx="3" fill="none" stroke="var(--ink)" stroke-width="1.5"/>
  <text x="440" y="102" font-size="13" fill="var(--ink)" font-family="system-ui">Draft outline</text>
  <rect x="415" y="120" width="14" height="14" rx="3" fill="var(--success)"/>
  <text x="440" y="132" font-size="13" fill="var(--ink)" font-family="system-ui">Research done</text>
  <path d="M320 160 L385 160" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arrowP)"/>
  <defs><marker id="arrowP" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Ctrl+K V gives real-time split preview; clickable checkboxes need the Markdown Checkbox Preview extension.</div>

<!-- Speaker: Show the keyboard shortcut live if presenting; call out the non-interactive default. -->

---

## Voice Dictation — With a Gap in Agent Mode

![bg right:40% contain](assets/vscode-notetaking-markdown-copilot-agent-dictation.png)

<p class="subhead">The free VS Code Speech extension runs on-device dictation into Copilot Chat — but not into the Agent window.</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="150" cy="160" r="50" fill="var(--accent)" opacity=".12"/>
  <circle cx="150" cy="160" r="34" fill="var(--accent)"/>
  <text x="150" y="167" font-size="22" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui" font-weight="700">mic</text>
  <path d="M195 160 Q260 100 320 160" stroke="var(--muted)" stroke-width="2" fill="none" marker-end="url(#arrowD)"/>
  <defs><marker id="arrowD" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--muted)"/></marker></defs>
  <rect x="330" y="90" width="330" height="140" rx="10" fill="var(--paper)" stroke="var(--success)" stroke-width="2"/>
  <text x="495" y="120" font-size="14" font-weight="700" fill="var(--success)" text-anchor="middle" font-family="system-ui">Copilot Chat</text>
  <text x="495" y="150" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Dictation supported</text>
  <rect x="330" y="250" width="330" height="50" rx="10" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="495" y="280" font-size="13" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Agent window — no mic button</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Use Copilot Chat panel for dictation today; Agent mode has no microphone input yet.</div>

<!-- Speaker: Point out this is a known gap, tracked in a GitHub issue, not a config mistake. -->

---

## Markdown Extensions Worth Installing

<p class="subhead">Three extensions cover most note-taking needs — install, don't build your own tooling.</p>

<div class="infographic" style="align-items:stretch;">

| Extension | Adds |
|---|---|
| **Markdown All in One** | Shortcuts, auto-preview, table formatting — 5M+ installs |
| **Markdown Preview Enhanced** | Mermaid/PlantUML diagrams, math, presentation mode |
| **markdownlint** | Style checks before docs go out the door |

</div>

<div class="takeaway"><b>★ Takeaway:</b> Start with Markdown All in One; add Preview Enhanced only if you need diagrams or math.</div>

<!-- Speaker: Table format is native Marp rendering — keep it as a real table, not an SVG. -->

---

## Theme Customization Beyond the Marketplace

![bg right:40% contain](assets/vscode-notetaking-markdown-copilot-agent-theme.png)

<p class="subhead">Pick a color theme, then fine-tune specific UI colors with `workbench.colorCustomizations`.</p>

<div class="infographic">
<svg viewBox="0 0 700 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="40" width="660" height="240" rx="10" fill="var(--ink)" opacity=".04"/>
  <text x="45" y="75" font-size="13" fill="var(--ink-dim)" font-family="monospace">{</text>
  <text x="65" y="105" font-size="13" fill="var(--accent)" font-family="monospace">"workbench.colorCustomizations"</text>
  <text x="65" y="135" font-size="13" fill="var(--ink-dim)" font-family="monospace">: {</text>
  <text x="85" y="165" font-size="13" fill="var(--ink)" font-family="monospace">"titleBar.activeBackground"</text>
  <text x="85" y="195" font-size="13" fill="var(--gold)" font-family="monospace">: "#ff0000"</text>
  <text x="65" y="225" font-size="13" fill="var(--ink-dim)" font-family="monospace">}</text>
  <text x="45" y="255" font-size="13" fill="var(--ink-dim)" font-family="monospace">}</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Fine-tune one color at a time in settings.json — no need to fork or build a whole new theme.</div>

<!-- Speaker: Show a live edit to settings.json if presenting; changes apply instantly. -->

---

## Copilot Agent Mode: Four Document Workflows

<p class="subhead">Open Copilot Edits → select "Agent" from the mode dropdown. It reads the codebase before proposing changes.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-4">
  <div class="card compact">
    <p class="label">Scaffold</p>
    <h3>New files</h3>
    <p>One prompt creates files, sections, or a whole feature skeleton.</p>
  </div>
  <div class="card compact success">
    <p class="label">Transform</p>
    <h3>CSV → tables</h3>
    <p>Reads a CSV, builds an aligned Markdown table, saves it where asked.</p>
  </div>
  <div class="card compact warning">
    <p class="label">Summarize</p>
    <h3>Release notes</h3>
    <p>A `/release-notes` prompt file pulls context from recent commits.</p>
  </div>
  <div class="card compact gold">
    <p class="label">Suggest</p>
    <h3>Content ideas</h3>
    <p>Reading related files surfaces missing sections while editing.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Agent mode turns document chores — scaffolding, tables, changelogs — into single prompts, but always review the diff before accepting.</div>

<!-- Speaker: Demo one workflow live if time allows — CSV-to-table is the most visually convincing. -->

---

## Caveats Before You Rely On This Workflow

<p class="subhead">Three gaps to know before building a daily habit around VS Code note-taking + Copilot Agent.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card danger">
    <p class="label">Not Default</p>
    <h3>Checklist clicks</h3>
    <p>Preview checkboxes are visual-only until you add an extension.</p>
  </div>
  <div class="card warning">
    <p class="label">Not Stable</p>
    <h3>Speech extension</h3>
    <p>Public reports of dictation failing outright — third-party tools exist as backup.</p>
  </div>
  <div class="card">
    <p class="label">Not Free</p>
    <h3>Copilot subscription</h3>
    <p>Agent mode requires an active GitHub Copilot license.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Treat dictation and one-click checklists as nice-to-haves, not load-bearing parts of the workflow.</div>

<!-- Speaker: Manage expectations — this is a strong setup, not a finished consumer product. -->

---

## Key Takeaways

<p class="subhead">What a reader who skips the deck body still needs to know.</p>

<div class="infographic">
<svg viewBox="0 0 1100 340" width="100%" xmlns="http://www.w3.org/2000/svg">
  <circle cx="550" cy="170" r="160" fill="none" stroke="var(--soft-2)" stroke-width="1.5"/>
  <circle cx="550" cy="170" r="110" fill="none" stroke="var(--accent)" stroke-width="1.5" opacity=".4"/>
  <circle cx="550" cy="170" r="60" fill="var(--accent)" opacity=".1"/>
  <circle cx="550" cy="170" r="60" fill="none" stroke="var(--accent)" stroke-width="2"/>
  <text x="550" y="164" font-size="15" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Ctrl+K V</text>
  <text x="550" y="184" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">split preview</text>
  <text x="380" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">Extensions add</text>
  <text x="380" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">checklists + dictation</text>
  <text x="730" y="100" font-size="13" fill="var(--ink)" font-family="system-ui" text-anchor="middle">workbench.color-</text>
  <text x="730" y="120" font-size="12" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Customizations tunes UI</text>
  <text x="220" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Agent mode</text>
  <text x="220" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">scaffolds + tables</text>
  <text x="880" y="170" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">No mic in</text>
  <text x="880" y="190" font-size="13" fill="var(--muted)" font-family="system-ui" text-anchor="middle">Agent window (yet)</text>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> VS Code + Copilot Agent covers 90% of a note-taking workflow — extensions and license checks fill the last 10%.</div>
