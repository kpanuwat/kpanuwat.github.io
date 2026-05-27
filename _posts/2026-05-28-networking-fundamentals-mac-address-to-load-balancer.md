---
title: "เจาะลึก Networking เบื้องต้น: จาก MAC Address ถึง Load Balancer"
date: 2026-05-27 00:15:00 +0700
categories: [Engineering]
tags: [networking, tcp-ip, dns, firewall, vpn, tls, load-balancer]
slides: true
---

{% include slide-link.html %}

## TL;DR

Networking คือระบบที่ทำให้อุปกรณ์นับล้านเครื่องสื่อสารกันได้ทั่วโลก — ตั้งแต่ **MAC Address** ระบุตัวตนใน LAN, **Switch** และ **Router** ส่งข้อมูลถูกทิศทาง, **TCP/UDP** เลือกระหว่างความแม่นยำกับความเร็ว, ไปจนถึง **TLS**, **VPN**, **DNS**, และ **Load Balancer** ที่ทำให้ระบบปลอดภัย ใช้งานง่าย และรองรับ Traffic ขนาดใหญ่ได้

## Background / Why this matters

ทุกครั้งที่คุณเปิด YouTube, ส่ง Line หรือโหลดเว็บไซต์ — มีกระบวนการ Networking หลายสิบขั้นตอนเกิดขึ้นภายในมิลลิวินาที เรามักมองข้ามสิ่งเหล่านี้เพราะมันทำงานอยู่เบื้องหลัง แต่สำหรับ Software Engineer, DevOps, หรือใครก็ตามที่ Build ระบบ — การเข้าใจ Networking เป็นทักษะพื้นฐานที่ขาดไม่ได้

ปัญหาส่วนใหญ่ใน Production เช่น latency สูง, connection timeout, หรือ security breach — มักมีต้นตอจาก Networking ที่ตั้งค่าผิด หรือเข้าใจกลไกผิด การเข้าใจแต่ละ Layer ตั้งแต่ MAC Address ไปจนถึง Load Balancer จะทำให้คุณ Debug ได้เร็วขึ้น Design ได้ดีขึ้น และ Secure ระบบได้มีประสิทธิภาพขึ้น

## Deep Dive

### 1. MAC Address — ระบุตัวตนใน LAN

**MAC Address (Media Access Control Address)** คือ Hardware identifier ที่ฝังอยู่ใน Network Interface Card (NIC) ของอุปกรณ์ทุกชิ้น ตั้งแต่ผลิต รูปแบบคือ 48-bit Hex เช่น `AA:BB:CC:DD:EE:FF` โดย 3 byte แรกคือ Organizationally Unique Identifier (OUI) ของผู้ผลิต

**ข้อจำกัดสำคัญ**: MAC Address ใช้ได้เฉพาะ **ภายในเครือข่ายเดียวกัน (Local Network)** เท่านั้น ไม่สามารถ Route ข้ามเครือข่ายได้ Router จะไม่ส่งต่อ MAC Address ออกไปนอก LAN

```
Device A           Device B
MAC: AA:11:...    MAC: BB:22:...
    |                  |
    +------Switch------+
         (same LAN)
```

### 2. Switch — เชื่อมอุปกรณ์ใน LAN

**Switch** คืออุปกรณ์ Layer 2 ที่เชื่อมต่ออุปกรณ์หลายชิ้นในเครือข่ายเดียวกัน โดยมันจะสร้าง **MAC Address Table** (หรือ CAM Table) ที่จำว่า MAC Address ไหนอยู่ที่ Port ไหน

กระบวนการทำงาน:
1. Frame เข้ามาที่ Port หนึ่ง — Switch อ่าน MAC Address ปลายทาง
2. ค้นหาใน MAC Table — ถ้าเจอ → ส่งตรงไปที่ Port นั้นเลย
3. ถ้าไม่เจอ → **Flood** ออกทุก Port (ยกเว้น Port ที่รับมา)

**ข้อดีเหนือ Hub**: Hub broadcast ทุก Frame ออกทุก Port เสมอ → ทำให้ Traffic แน่น Switch ฉลาดกว่า — ส่งตรงถึงปลายทาง ลด Collision และประหยัด Bandwidth

### 3. IP Address — ระบุตัวตนข้ามเครือข่าย

**IP Address** คือ Logical Address ที่กำหนดให้อุปกรณ์เพื่อระบุตัวตนและสื่อสารข้ามเครือข่ายที่แตกต่างกันได้

| ประเภท | รูปแบบ | ตัวอย่าง |
|--------|--------|---------|
| IPv4 | 32-bit (4 octets) | `192.168.1.100` |
| IPv6 | 128-bit (8 groups hex) | `2001:db8::1` |
| Private (RFC 1918) | ใช้ภายใน LAN | `10.x.x.x`, `192.168.x.x` |
| Public | ใช้บน Internet | กำหนดโดย ISP |

**DHCP (Dynamic Host Configuration Protocol)**: แทนที่จะกำหนด IP เอง อุปกรณ์สามารถขอ IP จาก DHCP Server โดยอัตโนมัติเมื่อเชื่อมต่อเครือข่าย

**Subnet Mask**: ใช้แบ่งว่า IP ส่วนไหนคือ Network portion และส่วนไหนคือ Host portion เช่น `/24` หมายความว่า 24 bit แรกคือ Network → มี host ได้ 254 เครื่อง

### 4. Router — เชื่อมต่อเครือข่ายและหาเส้นทาง

**Router** คืออุปกรณ์ Layer 3 ที่ทำหน้าที่เชื่อมต่อเครือข่ายที่แตกต่างกัน และตัดสินใจว่าจะส่ง Packet ไปทิศทางไหนโดยดูจาก **Routing Table**

เปรียบเสมือน "ป้ายบอกทาง" — Router เห็น Packet ที่มีปลายทาง IP แล้วเลือก Route ที่ดีที่สุด

**Routing Protocols** (วิธีที่ Router แลกเปลี่ยนข้อมูลเส้นทาง):

| Protocol | ประเภท | ใช้งาน |
|----------|--------|--------|
| **Static Route** | Manual | Small networks, simple topologies |
| **OSPF** (Open Shortest Path First) | Dynamic, Link-State | Internal (within one organization) |
| **BGP** (Border Gateway Protocol) | Dynamic, Path-Vector | Inter-AS routing บน Internet |

**BGP** คือ "Glue" ของ Internet — ทุก ISP และ Cloud Provider ใช้ BGP แลกเปลี่ยน Routing Information ระหว่างกัน ทำให้ Packet เดินทางจาก Bangkok ไป New York ได้โดยผ่าน Router หลายสิบตัว

### 5. TCP vs UDP — ความแม่นยำหรือความเร็ว

เมื่อ Packet ถึงปลายทางแล้ว จะต้องมี Protocol ระดับ Transport ที่จัดการว่าข้อมูลส่งถึงมือผู้รับอย่างถูกต้องหรือไม่

**TCP (Transmission Control Protocol)**:
- สร้าง Connection ก่อน (**3-Way Handshake**: SYN → SYN-ACK → ACK)
- รับประกัน Delivery — ถ้าข้อมูลหายระหว่างทาง → ส่งใหม่
- จัดเรียงลำดับ Packet ให้ถูกต้อง
- เหมาะกับ: HTTP/HTTPS, Email, File Transfer, SSH

**UDP (User Datagram Protocol)**:
- ไม่มี Connection — ยิงข้อมูลออกไปเลย ไม่รอ Confirm
- เร็วกว่า TCP มาก แต่ไม่รับประกัน Delivery
- Packet หายก็หายไปเลย
- เหมาะกับ: Video Streaming, Online Gaming, VoIP, DNS

```
TCP:  Sender ──SYN──► Router ──SYN-ACK──► Receiver ──ACK──► (connected)
UDP:  Sender ──DATA──► Router ──────────────────────────────► Receiver (fire & forget)
```

### 6. Ports — ระบุแอปพลิเคชัน

**Port** คือตัวเลข 16-bit (0–65535) ที่ระบุว่า Packet นี้ควรส่งให้ Application ไหนบนเครื่องปลายทาง

| Port | Protocol | การใช้งาน |
|------|----------|----------|
| 80 | HTTP | Web traffic ไม่เข้ารหัส |
| 443 | HTTPS | Web traffic เข้ารหัสด้วย TLS |
| 22 | SSH | Secure shell remote access |
| 53 | DNS | Domain name resolution |
| 25 | SMTP | Email sending |
| 3306 | MySQL | Database connection |

เมื่อ Browser เชื่อมต่อ `https://google.com` → TCP connection ไปที่ **Port 443** ของ Google Server → Google ส่งคืนหน้าเว็บ

### 7. Firewall — ยามเฝ้าประตูเครือข่าย

**Firewall** คือระบบที่ควบคุมว่า Traffic ใดได้รับอนุญาตให้เข้าหรือออกจากเครือข่าย โดยตรวจสอบตาม Rules ที่กำหนดไว้

**ประเภทของ Firewall**:

| ประเภท | วิธีทำงาน | ตัวอย่าง |
|--------|----------|---------|
| **Packet Filter** | ตรวจ IP, Port, Protocol | iptables, AWS Security Groups |
| **Stateful** | จำสถานะ Connection (ปลอดภัยกว่า) | Most modern firewalls |
| **Application Layer (WAF)** | ตรวจ HTTP/HTTPS content | AWS WAF, Cloudflare |

**ตัวอย่าง Rule**: Block port 22 (SSH) จาก public internet ยกเว้น IP whitelist → ลดความเสี่ยง brute force attack

### 8. TLS — เข้ารหัสการสื่อสาร

**TLS (Transport Layer Security)** คือ Protocol ที่เข้ารหัส Connection ระหว่างสองอุปกรณ์ ทำให้แม้แต่ผู้ที่ดัก Traffic อยู่ตรงกลาง (Man-in-the-Middle) ก็ไม่สามารถอ่านหรือแก้ไขข้อมูลได้

TLS เป็นเวอร์ชันใหม่ของ SSL (ที่ปัจจุบัน Deprecated แล้ว)

**TLS Handshake** (เกิดขึ้นก่อนส่ง HTTPS ทุกครั้ง):
1. Client Hello — บอก TLS version, cipher suites ที่รองรับ
2. Server Hello — Server ส่ง Certificate (Public Key) กลับมา
3. Client ตรวจสอบ Certificate ว่าน่าเชื่อถือ (ออกโดย CA ที่รู้จัก)
4. Key Exchange — แลกเปลี่ยน Session Key อย่างปลอดภัย
5. Encrypted channel สร้างเสร็จ → ส่งข้อมูลได้

**ทำไม HTTPS จึงสำคัญ**: HTTP ส่งข้อมูลแบบ Plaintext — ใครก็อ่านได้ถ้าดัก Traffic ได้ HTTPS ใช้ TLS เข้ารหัส → Password, Cookie, Personal data ปลอดภัย

### 9. VPN — อุโมงค์ส่วนตัวบน Public Internet

**VPN (Virtual Private Network)** สร้าง Encrypted Tunnel ระหว่างอุปกรณ์ของคุณกับ VPN Server ทำให้:
- Traffic ทั้งหมดถูกเข้ารหัสก่อนออกจากเครื่อง
- ผู้ที่อยู่ระหว่างทาง (ISP, Hacker บน Public WiFi) มองเห็นแค่ Encrypted data
- ปลายทางเห็นว่า Traffic มาจาก VPN Server แทน IP จริงของคุณ

**Use Cases**:
- **Remote Work**: พนักงาน Work from Home เชื่อมต่อ Office Network ผ่าน VPN → เข้าถึง Internal System ได้อย่างปลอดภัย
- **Privacy**: ซ่อน IP จาก ISP หรือ Tracker
- **Bypass Geo-block**: เข้าถึง Content ที่ถูก Block ในบางประเทศ

**VPN Protocols ยอดนิยม**: OpenVPN, WireGuard, IPSec/IKEv2

### 10. DNS — สมุดโทรศัพท์ของ Internet

**DNS (Domain Name System)** แปลง Domain Name ที่มนุษย์อ่านได้ (เช่น `google.com`) เป็น IP Address ที่คอมพิวเตอร์ใช้งาน (เช่น `142.250.66.46`)

**DNS Resolution Flow**:
1. Browser ถาม DNS Resolver (ปกติคือของ ISP หรือ `8.8.8.8`)
2. Resolver ถาม Root Nameserver → รู้ว่า `.com` อยู่ที่ไหน
3. Root ชี้ไปที่ TLD Nameserver (`.com`)
4. TLD ชี้ไปที่ Authoritative Nameserver ของ `google.com`
5. Authoritative ตอบกลับด้วย IP Address
6. Resolver Cache IP ไว้ตาม TTL (Time To Live)

**DNS Record Types ที่ควรรู้**:
| Record | ใช้งาน |
|--------|--------|
| `A` | Domain → IPv4 |
| `AAAA` | Domain → IPv6 |
| `CNAME` | Alias ชี้ไป Domain อื่น |
| `MX` | Mail Server |
| `TXT` | Verification, SPF, DKIM |

### 11. Load Balancer — กระจายงานสู่ Server หลายเครื่อง

**Load Balancer** คือระบบที่รับ Request จาก Client แล้วกระจายไปยัง Server หลายเครื่อง (Server Pool) เพื่อป้องกันไม่ให้เครื่องใดเครื่องหนึ่งรับภาระหนักเกินไป

**Load Balancing Algorithms**:

| Algorithm | วิธีทำงาน | เหมาะกับ |
|-----------|----------|---------|
| **Round Robin** | ส่งทีละเครื่องวนไป | Simple, stateless services |
| **Least Connections** | ส่งไปเครื่องที่ connection น้อยสุด | Long-lived connections |
| **IP Hash** | Hash จาก Client IP → เครื่องเดิมเสมอ | Session-based apps |
| **Weighted** | เครื่องแรงกว่าได้งานมากกว่า | Heterogeneous servers |

**Layer 4 vs Layer 7 Load Balancer**:
- **L4** (TCP/UDP): ดู IP + Port → เร็วมาก แต่ไม่รู้ HTTP content
- **L7** (HTTP/HTTPS): อ่าน HTTP header, URL, cookie → Route ได้ฉลาดกว่า (เช่น `/api` ไปเครื่อง A, `/static` ไปเครื่อง B)

## Caveats / Limits

- **NAT (Network Address Translation)** ซ่อน Private IP ไว้หลัง Public IP — ทำให้ MAC/IP ที่ปลายทางเห็นไม่ใช่ของต้นทางจริง ต้องระวังเมื่อ Debug
- **DNS Caching** — DNS มี TTL; ถ้า Update IP แล้ว Client บางส่วนยังเห็น IP เก่า (Cache ยังไม่ Expire)
- **TLS Certificate Expiry** — Certificate มีอายุ (ปัจจุบัน Let's Encrypt ออกให้ 90 วัน) ต้อง Auto-renew ไม่งั้น HTTPS ล้มเหลว
- **VPN ≠ 100% Anonymity** — VPN Server ยังเห็น Traffic ของคุณอยู่; เชื่อถือได้แค่เท่ากับ VPN Provider ที่ใช้
- **Load Balancer เพิ่ม Latency** — มี hop เพิ่ม 1 จุด, ถ้า L7 ต้องตีความ HTTP ด้วย → latency สูงกว่า L4

## References

1. "Every Networking Concept Explained | Networking 101 (2026)" — [YouTube](https://youtu.be/bdeV_TjNfFA)
2. Cloudflare Learning — [What is a MAC Address?](https://www.cloudflare.com/learning/network-layer/what-is-a-mac-address/)
3. Cloudflare Learning — [What is an IP Address?](https://www.cloudflare.com/learning/dns/glossary/what-is-my-ip-address/)
4. Cisco — [Understanding IP Routing](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html)
5. Cloudflare Learning — [What is BGP?](https://www.cloudflare.com/learning/security/glossary/what-is-bgp/)
6. MDN Web Docs — [TCP](https://developer.mozilla.org/en-US/docs/Glossary/TCP)
7. Cloudflare Learning — [UDP vs TCP](https://www.cloudflare.com/learning/ddos/glossary/user-datagram-protocol-udp/)
8. Cloudflare Learning — [What is a Firewall?](https://www.cloudflare.com/learning/security/what-is-a-firewall/)
9. Cloudflare Learning — [What is TLS?](https://www.cloudflare.com/learning/ssl/transport-layer-security-tls/)
10. Cloudflare Learning — [What is a VPN?](https://www.cloudflare.com/learning/access-management/what-is-a-vpn/)
11. Cloudflare Learning — [What is DNS?](https://www.cloudflare.com/learning/dns/what-is-dns/)
12. NGINX — [What is Load Balancing?](https://www.nginx.com/resources/glossary/load-balancing/)

## Key Takeaways

- **MAC vs IP**: MAC ระบุตัวตนใน LAN (Layer 2), IP ระบุตัวตนข้ามเครือข่าย (Layer 3) — คนละ scope ใช้ร่วมกันเสมอ
- **Switch vs Router**: Switch ส่งโดย MAC (ใน LAN), Router ส่งโดย IP (ข้าม Network) — ทั้งคู่จำเป็นสำหรับ Internet
- **TCP = แม่นยำ, UDP = เร็ว**: เลือกตาม use case — File/Web ใช้ TCP, Video Call/Game ใช้ UDP
- **Port บอก Application**: IP บอกว่า "เครื่องไหน", Port บอกว่า "แอปฯ ไหน"
- **TLS เข้ารหัส Connection**: HTTPS = HTTP + TLS — ป้องกัน eavesdropping และ tampering
- **DNS คือสมุดโทรศัพท์ของ Internet**: แปลง Domain เป็น IP — Cache ตาม TTL ระวังเมื่อ Update
- **Load Balancer กระจาย Traffic**: ป้องกัน Single Point of Failure และรองรับ Scale ใหญ่ขึ้น
