---
marp: true
theme: default
paginate: true
title: "Project Management เบื้องต้น สำหรับงาน SI"
style: |
  :root {
    --ink: #1e293b;
    --accent: #3b82f6;
    --paper: #ffffff;
    --muted: #94a3b8;
    --danger: #ef4444;
  }
  section { display: flex; flex-direction: column; justify-content: center; }
---

# Project Management เบื้องต้น<br>สำหรับงาน SI

**PM ที่ดีคือ "กาว" ที่ประสาน Business, IT, และ Vendors ทุกฝ่าย**

<!-- Speaker note: SI = multi-vendor, multi-system, multi-owner. Normal software PM practices are not enough. -->

---

## TL;DR — SI ต้องประสาน Vendors + Systems + Stakeholders

<div style="display:flex;justify-content:center;margin-top:1rem">
<svg viewBox="0 0 520 180" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="18" y="22" width="480" height="132" rx="12" fill="var(--accent)" opacity="0.08"/>
  <rect x="14" y="16" width="480" height="132" rx="12" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="14" y="16" width="8" height="132" rx="4" fill="var(--accent)"/>
  <rect x="18" y="16" width="4" height="132" fill="var(--accent)"/>
  <circle cx="64" cy="82" r="18" fill="var(--accent)"/>
  <text x="64" y="82" font-size="17" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">⚙</text>
  <text x="104" y="56" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Hybrid PM + Key Deliverables + Vendor Discipline</text>
  <text x="104" y="82" font-size="13" fill="var(--muted)" font-family="system-ui">ทำให้ Go-Live ผ่านโดยไม่มี surprise</text>
  <text x="104" y="108" font-size="13" fill="var(--muted)" font-family="system-ui">ตั้งแต่ Initiation จนถึง Hypercare</text>
  <rect x="432" y="20" width="58" height="20" rx="10" fill="var(--accent)"/>
  <text x="461" y="30" font-size="10" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-weight="700" font-family="system-ui" letter-spacing="0.5">KEY</text>
</svg>
</div>

<!-- Speaker note: Three things separate successful SI from failed ones: right framework, right deliverables, vendor discipline. -->

---

## SI แตกต่างจาก Software Project อย่างไร?

<div style="display:flex;justify-content:center;margin-top:0.5rem">
<svg viewBox="0 0 620 255" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="285" height="235" rx="10" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="10" y="10" width="285" height="46" rx="10" fill="var(--muted)" opacity="0.12"/>
  <rect x="10" y="42" width="285" height="14" fill="var(--muted)" opacity="0.12"/>
  <text x="152" y="35" font-size="14" font-weight="700" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Software Project</text>
  <text x="30" y="86" font-size="12" fill="var(--muted)" font-family="system-ui">• ทีมเขียน code เอง</text>
  <text x="30" y="112" font-size="12" fill="var(--muted)" font-family="system-ui">• Deploy / rollback ควบคุมได้</text>
  <text x="30" y="138" font-size="12" fill="var(--muted)" font-family="system-ui">• 1 codebase, 1 owner</text>
  <text x="30" y="164" font-size="12" fill="var(--muted)" font-family="system-ui">• Integration risk ต่ำ</text>
  <rect x="325" y="10" width="285" height="235" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <rect x="325" y="10" width="285" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="325" y="42" width="285" height="14" fill="var(--accent)" opacity="0.1"/>
  <text x="467" y="35" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">SI Project</text>
  <text x="345" y="86" font-size="12" fill="var(--ink)" font-family="system-ui">• หลาย Vendors, หลาย Teams</text>
  <text x="345" y="112" font-size="12" fill="var(--ink)" font-family="system-ui">• แต่ละระบบมี owner ต่างกัน</text>
  <text x="345" y="138" font-size="12" fill="var(--ink)" font-family="system-ui">• Integration point = จุดเสี่ยง</text>
  <text x="345" y="164" font-size="12" fill="var(--ink)" font-family="system-ui">• Scope creep สูง</text>
  <circle cx="310" cy="127" r="20" fill="var(--accent)"/>
  <text x="310" y="127" font-size="11" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">VS</text>
</svg>
</div>

<!-- Speaker note: You don't own all the pieces in SI. Coordination overhead is much higher. PM must bridge multiple teams with different incentives. -->

---

## Framework: Hybrid Agile-Waterfall

<div style="display:flex;justify-content:center;margin-top:0.5rem">
<svg viewBox="0 0 620 255" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="285" height="235" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="10" y="10" width="285" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="10" y="42" width="285" height="14" fill="var(--accent)" opacity="0.1"/>
  <text x="152" y="35" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Waterfall</text>
  <text x="30" y="84" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Vendor contracts + SOW</text>
  <text x="30" y="110" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Integration architecture</text>
  <text x="30" y="136" font-size="12" fill="var(--ink)" font-family="system-ui">✓ BRD, RTM, SIT Plan</text>
  <text x="30" y="162" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Phase gates ชัดเจน</text>
  <text x="30" y="202" font-size="11" fill="var(--muted)" font-family="system-ui" font-style="italic">ต้องกำหนดชัดก่อน Vendor เริ่ม</text>
  <rect x="325" y="10" width="285" height="235" rx="10" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="325" y="10" width="285" height="46" rx="10" fill="var(--accent)" opacity="0.1"/>
  <rect x="325" y="42" width="285" height="14" fill="var(--accent)" opacity="0.1"/>
  <text x="467" y="35" font-size="14" font-weight="700" fill="var(--accent)" text-anchor="middle" font-family="system-ui">Agile</text>
  <text x="345" y="84" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Custom development</text>
  <text x="345" y="110" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Integration testing</text>
  <text x="345" y="136" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Bug fixes & iterations</text>
  <text x="345" y="162" font-size="12" fill="var(--ink)" font-family="system-ui">✓ Retrospectives</text>
  <text x="345" y="202" font-size="11" fill="var(--muted)" font-family="system-ui" font-style="italic">ต้องปรับได้เมื่อพบ issues</text>
  <circle cx="310" cy="127" r="20" fill="var(--accent)"/>
  <text x="310" y="127" font-size="18" font-weight="700" fill="var(--paper)" text-anchor="middle" dominant-baseline="central" font-family="system-ui">+</text>
</svg>
</div>

<!-- Speaker note: Not a choice between the two — it's about knowing which part of the project needs structure vs. flexibility. -->

---

## 5 Phases ของ SI Project (PMBOK)

<div style="display:flex;justify-content:center;margin-top:1.2rem">
<svg viewBox="0 0 600 148" width="100%" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="6" refX="7" refY="3" orient="auto">
      <path d="M0,0 7,3 0,6" stroke="none" fill="#94a3b8"/>
    </marker>
  </defs>
  <rect x="10" y="48" width="90" height="52" rx="7" fill="var(--accent)"/>
  <text x="55" y="70" font-size="11" font-weight="600" fill="var(--paper)" text-anchor="middle" font-family="system-ui">Initiating</text>
  <text x="55" y="89" font-size="10" fill="var(--paper)" text-anchor="middle" font-family="system-ui" opacity="0.85">Charter</text>
  <line x1="102" y1="74" x2="118" y2="74" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="120" y="48" width="90" height="52" rx="7" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="165" y="70" font-size="11" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Planning</text>
  <text x="165" y="89" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">SOW/BRD</text>
  <line x1="212" y1="74" x2="228" y2="74" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="230" y="48" width="90" height="52" rx="7" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="275" y="70" font-size="11" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Executing</text>
  <text x="275" y="89" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Vendors</text>
  <line x1="322" y1="74" x2="338" y2="74" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="340" y="48" width="90" height="52" rx="7" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="385" y="70" font-size="11" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Monitoring</text>
  <text x="385" y="89" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">CCB/Track</text>
  <line x1="432" y1="74" x2="448" y2="74" stroke="#94a3b8" stroke-width="2" marker-end="url(#arr)"/>
  <rect x="450" y="48" width="90" height="52" rx="7" fill="var(--paper)" stroke="var(--accent)" stroke-width="2"/>
  <text x="495" y="70" font-size="11" font-weight="600" fill="var(--ink)" text-anchor="middle" font-family="system-ui">Closing</text>
  <text x="495" y="89" font-size="10" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Go-Live</text>
  <text x="55" y="118" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 1</text>
  <text x="165" y="118" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 2</text>
  <text x="275" y="118" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 3</text>
  <text x="385" y="118" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 4</text>
  <text x="495" y="118" font-size="9" fill="var(--muted)" text-anchor="middle" font-family="system-ui">Phase 5</text>
</svg>
</div>

PMBOK 5 process groups — ปรับ scope ตาม complexity ของโปรเจกต์

<!-- Speaker note: Every SI project goes through these phases. The key is knowing what's SI-specific at each phase. -->

---

## Planning Phase: 4 Deliverables ที่ขาดไม่ได้

<div style="display:flex;justify-content:center;margin-top:0.5rem">
<svg viewBox="0 0 560 258" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="255" height="108" rx="9" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="10" y="10" width="255" height="35" rx="9" fill="var(--accent)" opacity="0.12"/>
  <rect x="10" y="33" width="255" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="30" y="30" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">SOW — Statement of Work</text>
  <text x="30" y="60" font-size="11" fill="var(--ink)" font-family="system-ui">Scope + Deliverables + Timelines</text>
  <text x="30" y="80" font-size="11" fill="var(--muted)" font-family="system-ui">Acceptance criteria กับทุก Vendor</text>
  <text x="30" y="100" font-size="11" fill="var(--muted)" font-family="system-ui">ป้องกัน scope creep + disputes</text>
  <rect x="295" y="10" width="255" height="108" rx="9" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="295" y="10" width="255" height="35" rx="9" fill="var(--accent)" opacity="0.12"/>
  <rect x="295" y="33" width="255" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="315" y="30" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">BRD — Business Requirements</text>
  <text x="315" y="60" font-size="11" fill="var(--ink)" font-family="system-ui">As-Is → To-Be process mapping</text>
  <text x="315" y="80" font-size="11" fill="var(--muted)" font-family="system-ui">แปลง Business Goals เป็น</text>
  <text x="315" y="100" font-size="11" fill="var(--muted)" font-family="system-ui">Technical Requirements</text>
  <rect x="10" y="140" width="255" height="108" rx="9" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="10" y="140" width="255" height="35" rx="9" fill="var(--accent)" opacity="0.12"/>
  <rect x="10" y="163" width="255" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="30" y="160" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">RTM — Traceability Matrix</text>
  <text x="30" y="190" font-size="11" fill="var(--ink)" font-family="system-ui">Req → Test Case → Deliverable</text>
  <text x="30" y="210" font-size="11" fill="var(--muted)" font-family="system-ui">ยืนยันว่า implement + test ครบ</text>
  <text x="30" y="230" font-size="11" fill="var(--muted)" font-family="system-ui">critical ใน multi-vendor SI</text>
  <rect x="295" y="140" width="255" height="108" rx="9" fill="var(--paper)" stroke="var(--accent)" stroke-width="1.5"/>
  <rect x="295" y="140" width="255" height="35" rx="9" fill="var(--accent)" opacity="0.12"/>
  <rect x="295" y="163" width="255" height="12" fill="var(--accent)" opacity="0.12"/>
  <text x="315" y="160" font-size="13" font-weight="700" fill="var(--accent)" font-family="system-ui">SIT Plan — Integration Test</text>
  <text x="315" y="190" font-size="11" fill="var(--ink)" font-family="system-ui">Scope + Approach + Schedule</text>
  <text x="315" y="210" font-size="11" fill="var(--muted)" font-family="system-ui">Entry/Exit criteria ชัดเจน</text>
  <text x="315" y="230" font-size="11" fill="var(--muted)" font-family="system-ui">real transactions ไม่ใช่ handshake</text>
</svg>
</div>

<!-- Speaker note: Missing any one of these creates a gap that surfaces in testing or go-live. SOW prevents vendor disputes; RTM ensures nothing was skipped. -->

---

## Closing Phase: Go-Live Checklist

| Item | หมายเหตุ |
|------|---------|
| UAT sign-off จาก business owners | ต้องได้ลายเซ็น ไม่ใช่แค่ verbal OK |
| SIT completion — **real transactions** | ไม่ใช่แค่ connectivity test |
| Data migration validation | verify ข้อมูลหลัง migrate ครบถูกต้อง |
| Rollback plan + cutover criteria | กำหนดชัดว่า "fail condition" คืออะไร |
| Hypercare support model | ใครดู support กี่วันหลัง go-live |

<!-- Speaker note: Real transactions means EDI pipelines, banking connections, CRM syncs — tested with production-like data. Not just "the API responds." -->

---

## Top 3 Pitfalls ใน SI Projects

<div style="display:flex;justify-content:center;margin-top:0.5rem">
<svg viewBox="0 0 560 240" width="100%" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="540" height="62" rx="8" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="10" y="10" width="6" height="62" rx="3" fill="var(--danger)"/>
  <text x="30" y="36" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Integration testing ≠ Connectivity testing</text>
  <text x="30" y="58" font-size="11" fill="var(--muted)" font-family="system-ui">API 200 ≠ ระบบ integrate ถูก — ต้องทดสอบด้วย real transactions end-to-end เสมอ</text>
  <rect x="10" y="88" width="540" height="62" rx="8" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="10" y="88" width="6" height="62" rx="3" fill="var(--danger)"/>
  <text x="30" y="114" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">Scope creep — ป้องกันด้วย SOW + formal CCB</text>
  <text x="30" y="136" font-size="11" fill="var(--muted)" font-family="system-ui">ทุก change request ต้องมี impact analysis + Change Control Board approval ก่อน</text>
  <rect x="10" y="166" width="540" height="62" rx="8" fill="var(--paper)" stroke="var(--muted)" stroke-width="1.5"/>
  <rect x="10" y="166" width="6" height="62" rx="3" fill="var(--danger)"/>
  <text x="30" y="192" font-size="13" font-weight="700" fill="var(--ink)" font-family="system-ui">ไม่มี SPOC — Vendor coordination ล้มเหลว</text>
  <text x="30" y="214" font-size="11" fill="var(--muted)" font-family="system-ui">แต่ละ Vendor ต้องมี Single Point of Contact + escalation path ชัดเจน</text>
</svg>
</div>

<!-- Speaker note: These are process failures, not technical ones. A PM who handles these three prevents the most common SI failure modes. -->

---

## Key Takeaways

- SI projects ต้องประสาน Vendors หลายเจ้า + ระบบหลายตัว — PM คือ "กาว" รวมทุกฝ่าย
- **Hybrid Agile-Waterfall** — Waterfall สำหรับ vendor/specs, Agile สำหรับ dev/testing
- Deliverables สำคัญ: **SOW → BRD → RTM → SIT Plan → Go-Live Checklist**
- Integration testing ต้องใช้ **real transactions** — ไม่ใช่แค่ connectivity
- Scope creep = risk อันดับหนึ่ง — ป้องกันด้วย **formal CCB**
- กำหนด **SPOC** ทั้งฝั่งตัวเองและ Vendor เพื่อป้องกัน communication breakdown

<!-- Speaker note: If you remember one thing — SI PM is about coordination and formal processes, not just technical delivery. -->
