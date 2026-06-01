---
marp: true
theme: default
paginate: true
title: "ESP32 Browser Simulation: Wokwi, Cirkit Designer, Velxio"
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

![bg opacity:.25](assets/esp32-browser-simulation-wokwi-cirkit-designer-velxio-cover.png)

<div class="mark"></div>

# ESP32 Browser Simulation

<p class="tag">Wokwi · Cirkit Designer · Velxio — simulate before you solder</p>

<!-- Speaker: 3 platforms, 3 use cases. Each solves a different constraint — IoT fidelity, beginner onramp, and hardware accuracy. -->

---

<!-- _class: cheatsheet -->
<!-- _backgroundColor: #f8f7f4 -->

![bg fit](assets/esp32-browser-simulation-wokwi-cirkit-designer-velxio-cheatsheet.png)

<!-- Speaker: Full-deck cheatsheet — 3 platforms, trade-offs, use-case routing. 60-second orientation. -->

---

## No Hardware? No Problem.

<p class="subhead">3 browser platforms cover every ESP32 dev use case — IoT, learning, and hardware accuracy.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">IoT Workflow</p>
    <h3>Wokwi</h3>
    <p>Full WiFi/MQTT stack simulation. VS Code integration. Production-grade IoT testing — no code changes needed.</p>
  </div>
  <div class="card gold">
    <p class="label">AI-Assisted</p>
    <h3>Cirkit Designer</h3>
    <p>AI co-pilot wires circuits and writes code from plain-language descriptions. Visual-first IDE for beginners.</p>
  </div>
  <div class="card success">
    <p class="label">Hardware Accurate</p>
    <h3>Velxio</h3>
    <p>QEMU CPU emulation via WASM. SPICE analog solver. Open-source and offline-capable via Docker.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> All three are free, browser-based, zero-install — choose by what you need to test, not by price.</div>

<!-- Speaker: Quick orientation. Each card = one platform = one primary use case. -->

---

## From Hours to Seconds: Why Simulate?

![bg right:40% contain](assets/esp32-browser-simulation-wokwi-cirkit-designer-velxio-background.png)

<p class="subhead">Traditional embedded dev burns time, money, and hardware — simulation collapses the iteration loop.</p>

<div class="infographic">
<svg viewBox="0 0 700 300" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arrowR" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto">
      <path d="M0,0 L8,4 L0,8 Z" fill="var(--danger)"/>
    </marker>
    <marker id="arrowG" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto">
      <path d="M0,0 L8,4 L0,8 Z" fill="var(--success)"/>
    </marker>
  </defs>
  <text x="10" y="22" font-size="12" fill="var(--danger)" font-family="system-ui" font-weight="700">Traditional loop</text>
  <rect x="10" y="30" width="120" height="44" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="70" y="53" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Order HW</text>
  <text x="70" y="68" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">days</text>
  <path d="M132 52 L150 52" stroke="var(--danger)" stroke-width="2" marker-end="url(#arrowR)"/>
  <rect x="152" y="30" width="120" height="44" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="212" y="53" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Flash + Wire</text>
  <text x="212" y="68" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">30 min</text>
  <path d="M274 52 L292 52" stroke="var(--danger)" stroke-width="2" marker-end="url(#arrowR)"/>
  <rect x="294" y="30" width="120" height="44" rx="8" fill="var(--danger-wash)" stroke="var(--danger)" stroke-width="1.5"/>
  <text x="354" y="53" font-size="12" font-weight="700" fill="var(--danger-ink)" text-anchor="middle" font-family="system-ui">Debug</text>
  <text x="354" y="68" font-size="10" fill="var(--danger)" text-anchor="middle" font-family="system-ui">hours</text>
  <text x="10" y="115" font-size="12" fill="var(--success)" font-family="system-ui" font-weight="700">Browser simulation</text>
  <rect x="10" y="122" width="120" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="70" y="145" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Write Code</text>
  <text x="70" y="160" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">instant</text>
  <path d="M132 144 L150 144" stroke="var(--success)" stroke-width="2" marker-end="url(#arrowG)"/>
  <rect x="152" y="122" width="120" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="212" y="145" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Simulate</text>
  <text x="212" y="160" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">instant</text>
  <path d="M274 144 L292 144" stroke="var(--success)" stroke-width="2" marker-end="url(#arrowG)"/>
  <rect x="294" y="122" width="120" height="44" rx="8" fill="var(--success-wash)" stroke="var(--success)" stroke-width="1.5"/>
  <text x="354" y="145" font-size="12" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Fix + Iterate</text>
  <text x="354" y="160" font-size="10" fill="var(--success)" text-anchor="middle" font-family="system-ui">seconds</text>
  <rect x="460" y="50" width="200" height="130" rx="12" fill="var(--accent-wash)" stroke="var(--accent)" stroke-width="2"/>
  <text x="560" y="98" font-size="32" font-weight="800" fill="var(--accent)" text-anchor="middle" font-family="system-ui">~100x</text>
  <text x="560" y="126" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">faster iteration</text>
  <text x="560" y="148" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">hours vs seconds</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Browser simulation turns a multi-hour hardware debug cycle into a seconds-long code-test loop.</div>

<!-- Speaker: Portrait image shows the emotional contrast. SVG shows the time delta numerically. -->

---

## Wokwi: Full TCP/IP Stack in the Browser

<p class="subhead">Simulates 802.11 MAC through IP/TCP/UDP to MQTT — broker code runs unchanged inside the browser.</p>

<div class="infographic">
<svg viewBox="0 0 1100 320" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto">
      <path d="M0,0 L8,4 L0,8 Z" fill="var(--accent)"/>
    </marker>
    <marker id="arrG" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto">
      <path d="M0,0 L8,4 L0,8 Z" fill="var(--gold)"/>
    </marker>
  </defs>
  <rect x="30" y="60" width="155" height="200" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="30" y="60" width="155" height="44" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="107" y="88" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">802.11 MAC</text>
  <text x="107" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Wireless sim</text>
  <text x="107" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Layer 1-2</text>
  <path d="M187 160 L208 160" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="210" y="60" width="155" height="200" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="210" y="60" width="155" height="44" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="287" y="88" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">IP / TCP / UDP</text>
  <text x="287" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Transport stack</text>
  <text x="287" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Layer 3-4</text>
  <path d="M367 160 L388 160" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="390" y="60" width="155" height="200" rx="12" fill="var(--soft)" stroke="var(--soft-2)" stroke-width="1.5"/>
  <rect x="390" y="60" width="155" height="44" rx="12" fill="var(--accent)" opacity=".15"/>
  <text x="467" y="88" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">DNS / HTTP</text>
  <text x="467" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">App protocols</text>
  <text x="467" y="152" font-size="11" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Layer 7</text>
  <path d="M547 160 L568 160" stroke="var(--accent)" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="570" y="60" width="155" height="200" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="570" y="60" width="155" height="44" rx="12" fill="var(--accent)" opacity=".25"/>
  <text x="647" y="88" font-size="13" font-weight="700" fill="var(--accent-deep)" text-anchor="middle" font-family="system-ui">MQTT / CoAP</text>
  <text x="647" y="130" font-size="12" fill="var(--ink)" text-anchor="middle" font-family="system-ui">IoT protocols</text>
  <text x="647" y="152" font-size="11" fill="var(--accent)" text-anchor="middle" font-family="system-ui">broker-ready</text>
  <path d="M727 160 L748 160" stroke="var(--gold)" stroke-width="2" marker-end="url(#arrG)"/>
  <rect x="750" y="80" width="310" height="160" rx="12" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <text x="905" y="130" font-size="15" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Private Gateway</text>
  <text x="905" y="154" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Simulator to local network</text>
  <text x="905" y="174" font-size="12" fill="var(--muted)" text-anchor="middle" font-family="system-ui">No cloud relay</text>
  <text x="905" y="108" font-size="13" fill="var(--gold)" text-anchor="middle" font-family="system-ui">wokwi.com</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Wokwi simulates the entire network stack — ESP32 MQTT code connects to real brokers with zero modification.</div>

<!-- Speaker: Private Gateway routes simulator traffic directly through your machine's network — great for testing against local servers or real cloud APIs. -->

---

## Wokwi: ESP32 Peripheral Coverage

<p class="subhead">Most production IoT peripherals are fully supported. Bluetooth and ULP are the gaps to plan around.</p>

| Peripheral | Status | Notes |
|---|---|---|
| GPIO + interrupts | Full | Edge-triggered, pull-up/down |
| UART, I2C (master), SPI | Full | Standard comm protocols |
| LEDC PWM, timers, watchdog | Full | LED control, timing |
| ADC, RNG, DMA | Full | Analog reads work |
| AES / SHA / RSA | Full | Security accelerators |
| I2S, RMT (WS2812), TWAI | Partial | Transmit-only modes |
| Bluetooth, ULP Processor | Not supported | Test on real hardware |

<div class="takeaway"><b>★ Takeaway:</b> GPIO, WiFi, and standard peripherals are all covered — Bluetooth requires real hardware testing.</div>

<!-- Speaker: The "Full" list covers ~90% of hobbyist and production IoT projects. The gaps are niche but worth knowing. -->

---

## Cirkit Designer: AI Wires Your Circuit

<p class="subhead">Describe your project in plain language — AI handles pinout, wiring, and code generation.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card">
    <p class="label">AI Assistant</p>
    <h3>Cirkit AI</h3>
    <p>Describe your circuit in plain language. AI suggests wiring, generates Arduino/ESP32 code, and troubleshoots errors — no pinout memorization required.</p>
  </div>
  <div class="card gold">
    <p class="label">Visual-First IDE</p>
    <h3>Drag-Drop</h3>
    <p>Component library covers sensors, displays, motors, LEDs. ESP32-S3 simulation runs code with live peripheral responses in the same workspace.</p>
  </div>
  <div class="card success">
    <p class="label">Export & Share</p>
    <h3>Diagram Out</h3>
    <p>Export circuit diagrams for documentation or presentations. WiFi workflow support: HTTP, MQTT, and IoT-style projects all in browser.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Cirkit Designer is the fastest onramp for beginners — AI eliminates the pinout lookup loop entirely.</div>

<!-- Speaker: Cirkit AI is the unique differentiator. No other simulator offers inline code generation + circuit guidance in the same workspace. -->

---

## Velxio: Real CPU Emulation via QEMU + WASM

<p class="subhead">Each chip uses a dedicated engine — instruction-level hardware fidelity, SPICE analog co-simulation.</p>

| Chip | Emulation Engine | Frequency |
|---|---|---|
| Arduino Uno / Nano / Mega | avr8js — cycle-accurate AVR8 | 16 MHz |
| Raspberry Pi Pico (RP2040) | rp2040js — ARM Cortex-M0+ | 133 MHz |
| ESP32 / ESP32-S3 (Xtensa) | QEMU lcgamboa via WASM | 240 MHz |
| ESP32-C3 (RISC-V RV32IMC) | QEMU libqemu-riscv32 | — |

<div class="takeaway"><b>★ Takeaway:</b> QEMU compiled to WASM + SPICE analog solver — GPIO pins drive real SPICE nets; <code>analogRead()</code> reads solved node voltages, not approximations.</div>

<!-- Speaker: avr8js and rp2040js are pure-browser. ESP32 uses QEMU inside a Docker container, so offline mode needs Docker installed. -->

---

## Platform at a Glance: Which to Pick?

<p class="subhead">Match your primary constraint to the right tool — no single platform wins every row.</p>

| Feature | Wokwi | Cirkit Designer | Velxio |
|---|---|---|---|
| WiFi / MQTT simulation | Full stack | HTTP + MQTT | None |
| AI circuit assistance | None | Cirkit AI | None |
| CPU emulation accuracy | Simulator | Simulator | QEMU / avr8js |
| SPICE analog solver | No | No | Yes |
| Offline / self-host | No | No | Docker |
| Open source | No | No | Yes |
| VS Code extension | Yes | No | No |

<div class="takeaway"><b>★ Takeaway:</b> Network testing → Wokwi. Learning + prototyping → Cirkit Designer. Analog + timing accuracy → Velxio.</div>

<!-- Speaker: Every row maps to a real developer need. The three empty cells in the Velxio "network" column are not bugs — they're a design choice. -->

---

## Know the Limits Before You Ship

<p class="subhead">No simulator replaces hardware for RF, timing-critical paths, or real analog edge behavior.</p>

<div class="infographic" style="align-items:stretch;">
<div class="bento cols-3">
  <div class="card warning">
    <p class="label">Wokwi</p>
    <h3>Network gaps</h3>
    <p>Bluetooth + ULP not supported. Free tier has simulation speed cap. Private Gateway and CI integration are paid features.</p>
  </div>
  <div class="card warning">
    <p class="label">Cirkit Designer</p>
    <h3>Verify AI code</h3>
    <p>AI-generated code needs human review before flashing real hardware. ESP32-S3 only — not all ESP32 variants. Pricing not publicly disclosed.</p>
  </div>
  <div class="card danger">
    <p class="label">Velxio</p>
    <h3>No network stack</h3>
    <p>ESP32 emulation requires Docker for offline use. No WiFi or MQTT simulation at all — not a Wokwi substitute for IoT testing.</p>
  </div>
</div>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Simulate for iteration speed — validate timing-sensitive and RF code on real hardware before production.</div>

<!-- Speaker: The Velxio danger card is the most common misconception: "best emulation" does not mean "best for IoT." Use Wokwi for that. -->

---

## Choose by Use Case — All Three Are Free

<p class="subhead">Three tools, three strengths — browser-based and zero-install, all of them.</p>

<div class="infographic">
<svg viewBox="0 0 1100 290" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="20" width="310" height="250" rx="14" fill="var(--paper)" stroke="var(--accent)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="30" y="20" width="310" height="52" rx="14" fill="var(--accent)"/>
  <text x="185" y="52" font-size="20" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">Wokwi</text>
  <text x="185" y="105" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">WiFi / MQTT / HTTP</text>
  <text x="185" y="130" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">VS Code extension</text>
  <text x="185" y="155" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CI integration</text>
  <text x="185" y="210" font-size="13" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">IoT workflow testing</text>
  <rect x="395" y="20" width="310" height="250" rx="14" fill="var(--paper)" stroke="var(--gold)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="395" y="20" width="310" height="52" rx="14" fill="var(--gold)"/>
  <text x="550" y="52" font-size="20" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">Cirkit Designer</text>
  <text x="550" y="105" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">AI circuit assistant</text>
  <text x="550" y="130" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Drag-drop visual IDE</text>
  <text x="550" y="155" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Beginner-friendly</text>
  <text x="550" y="210" font-size="13" font-weight="700" fill="var(--warning-ink)" text-anchor="middle" font-family="system-ui">Learning + rapid prototyping</text>
  <rect x="760" y="20" width="310" height="250" rx="14" fill="var(--paper)" stroke="var(--success)" stroke-width="2" style="filter:drop-shadow(0 4px 12px rgba(15,23,42,.08))"/>
  <rect x="760" y="20" width="310" height="52" rx="14" fill="var(--success)"/>
  <text x="915" y="52" font-size="20" font-weight="800" fill="white" text-anchor="middle" font-family="system-ui">Velxio</text>
  <text x="915" y="105" font-size="13" fill="var(--ink)" text-anchor="middle" font-family="system-ui">QEMU CPU emulation</text>
  <text x="915" y="130" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SPICE analog solver</text>
  <text x="915" y="155" font-size="13" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Open-source + offline</text>
  <text x="915" y="210" font-size="13" font-weight="700" fill="var(--success-ink)" text-anchor="middle" font-family="system-ui">Analog + timing accuracy</text>
  <rect x="0" y="0" width="1" height="1" fill="none"/>
</svg>
</div>

<div class="takeaway"><b>★ Takeaway:</b> Pick Wokwi for IoT, Cirkit for learning, Velxio for analog accuracy — none replaces real hardware for RF and timing edge cases.</div>

<!-- Speaker: The routing is the takeaway. Use case determines the tool. Don't mix them up or you'll hit the limits table from the previous slide. -->
