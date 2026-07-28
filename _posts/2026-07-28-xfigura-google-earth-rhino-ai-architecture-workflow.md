---
title: "เจาะลึก xFigura: ออกแบบสถาปัตยกรรมด้วย AI ผ่าน Google Earth และ Rhino ใน 4 เวิร์กโฟลว์หลัก"
date: 2026-07-27 00:04:00 +0700
categories: [Tools]
tags: [xfigura, google-earth, rhino, architecture, ai-design, kmz]
---

## TL;DR

xFigura คือ AI canvas สำหรับสถาปนิก ที่เชื่อมโมเดล Rhino และแผนที่จริงจาก Google Earth เข้าด้วยกัน ผ่าน 4 เวิร์กโฟลว์หลัก — capture คอนเซปต์จากภาพแคปหน้าจอ, ดึงโมเดล Rhino เข้า canvas, ขึ้น volume 3D บน Google Earth Pro เพื่อเรนเดอร์ฟาซาด, และ export KMZ พร้อม Earth Anchor Point — เพื่อสร้างภาพเรนเดอร์และแอนิเมชันที่แม่นยำตามบริบทพื้นที่จริง

## Background / Why this matters

Context คือหัวใจของงานออกแบบสถาปัตยกรรม การเสนอ concept ที่ดูดีในสุญญากาศไม่มีประโยชน์เท่ากับการเห็นอาคารตั้งอยู่ในตำแหน่งจริง ท่ามกลางอาคารข้างเคียง แสง และมุมมองจริง xFigura ถูกสร้างมาเพื่อแก้ปัญหานี้โดยเฉพาะ

xFigura พัฒนาโดย George Guida สถาปนิกและอาจารย์ผู้สอนที่ PAACADEMY ซึ่งเคยทำงานกับ Foster + Partners, Harvard และ ArchiTAG เปิดตัวช่วงปลายปี 2025 เป็นแพลตฟอร์มแบบ web-based ที่รวม generative AI engine หลายตัวไว้ในที่เดียว ทั้ง text-to-image, sketch-to-image, image-to-3D และ video generation โดยฝัง engine อย่าง SDXL, Flux, Ideogram, Tripo และ Hunyuan3D ไว้ให้เลือกใช้ตามงาน [4][5][7]

จุดเด่นที่ทำให้ xFigura ต่างจากเครื่องมือ AI rendering ทั่วไปคือการเชื่อมต่อกับ workflow ที่สถาปนิกใช้อยู่แล้ว — ทั้ง Rhino/Grasshopper ผ่าน plugin โดยตรง และ Speckle integration สำหรับ Revit, SketchUp [4] รวมถึงความสามารถในการดึงพิกัดจริงจาก Google Earth มาใช้ปักหมุดโมเดล 3D ให้ตรงตำแหน่งเป๊ะ

## Deep Dive

วิดีโอต้นฉบับ ["Place Buildings in Real Locations, Generate Infinite Design Options with AI"](https://youtu.be/S4nvfDQ3ifk) สาธิต 4 เวิร์กโฟลว์ที่ใช้ Google Earth ร่วมกับ xFigura ตั้งแต่ concept แบบเร็วไปจนถึง output คุณภาพสูงพร้อมแอนิเมชัน [3]

### เวิร์กโฟลว์ที่ 1: สร้างคอนเซปต์จากภาพแคปหน้าจอ (Screenshot Concept)

วิธีนี้เร็วที่สุด เหมาะกับการ iterate ไอเดียแบบคร่าวๆ (rough and ready) ก่อนลงรายละเอียด [1][2]

- ใน xFigura web app: double-click บน canvas เพื่อเปิดเมนู ใส่ text prompt (เช่น "top-down view of a 30-story residential tower") เลือกโมเดล AI (วิดีโอใช้ **Nano Banana Pro**) ตั้งจำนวน output และ resolution เริ่มต้น (แนะนำตั้งต่ำก่อนแล้วค่อย upscale) [4]
- เปิด Google Earth เวอร์ชัน web ปิด label เลือก clean setting หามุมที่ต้องการแล้ว screenshot [4]
- กลับมาที่ xFigura ใช้ **Image Loader** อัปโหลดภาพ screenshot แล้วลาก editor icon ออกมาเพื่อวาดเส้นสีแดง (red outline) ล้อมพื้นที่ site ที่ต้องการ [1][4]
- สร้าง Image node ใหม่ เชื่อมทั้งภาพตึกที่ generate ไว้ กับภาพ site ที่มาร์กไว้ (ลากเข้า purple slot) ตั้ง aspect ratio แบบ wide แล้วเขียน prompt อธิบายว่าต้องการให้ตึกวางในเส้น outline โดยคง scale และ perspective ให้ตรง [1]

**Tips:** ใช้ editor สเก็ตช์ landscaping เพิ่มด้วยสีต่างๆ (เช่น สีส้ม = ทางเดิน) แล้วอธิบายใน prompt ว่าสีไหนคือ feature อะไร; เวลาต้องการ variation เช่นภาพตอนเย็น ให้สั่ง "keep the context and perspective the same, only changing the lighting" และตั้ง resolution เป็น x2 สำหรับความละเอียด HD [2]

### เวิร์กโฟลว์ที่ 2: เชื่อมต่อโมเดล Rhino เข้า Canvas

เวิร์กโฟลว์นี้เชื่อม 3D modeling environment ที่สถาปนิกใช้งานประจำเข้ากับ AI generation โดยตรง [5]

- ติดตั้ง plugin: ใน Rhino ไปที่ **Tools > Package Manager** ค้นหา "xfigure" กด install แล้ว restart [5]
- เปลี่ยน viewport เป็น render mode พิมพ์คำสั่ง `xfigure` ใน command line เพื่อเปิด xFigura app ฝังอยู่ใน Rhino viewport โดยตรง ล็อกอินแล้วเปิด board ที่ทำงานอยู่ [5]
- กดปุ่ม screenshot ที่ด้านล่างของ plugin เพื่อแคปวิว Rhino ปัจจุบันเข้า canvas ทันที — ภาพจะ sync กลับไปที่ web app หลักด้วย [5][6]
- เพื่อความแม่นยำเรื่อง scale: screenshot อาคารอ้างอิงจาก Google Earth ที่มีความสูงใกล้เคียงกับดีไซน์ อัปโหลดเข้า xFigura แล้ว circle อาคารนั้นด้วยเส้นแดงในหน้า editor [6]
- สร้าง Image node เชื่อมภาพ Rhino กับภาพ Google Earth ที่มาร์กไว้ เขียน prompt สั่งให้แทนที่อาคารในเส้น outline ด้วยดีไซน์ Rhino โดยคง scale เดิม [6]

**Tips:** ต้องตั้ง aspect ratio ให้ถูกต้องก่อน generate ไม่งั้นระบบจะ default ไปตาม aspect ratio ของภาพแรกที่ใส่เข้าไป [6]; โมเดล **Qwen Edit** เหมาะมากสำหรับ workflow นี้ เพราะควบคุมมุมและการหมุนได้โดยไม่ต้อง import ภาพใหม่ทุกครั้ง [7]

### เวิร์กโฟลว์ที่ 3: ขึ้น Volume 3D บน Google Earth Pro เพื่อเรนเดอร์ฟาซาด

สำหรับงานที่ต้องการความแม่นยำด้าน positioning มากขึ้น ต้องใช้ **Google Earth Pro** (desktop app) แทนเวอร์ชัน web [7]

- เปิด Google Earth Pro ไปยัง site เป้าหมาย ใช้เครื่องมือ **Add Polygon** วาด footprint ของอาคารลงบนแผนที่ 3D โดยตรง [7]
- ไปที่แท็บ **Altitude** เลือก "relative to ground" ใส่ความสูงอาคารที่ต้องการ และต้องติ๊ก **"extend sides to ground"** ผนังด้าน 3D ถึงจะขึ้น [7]
- Screenshot ฉาก massing นี้ แล้วอัปโหลดเข้า xFigura ผ่าน Image Loader พร้อมภาพอ้างอิงฟาซาดและภูมิทัศน์โดยรอบ (สร้างจาก text prompt ก็ได้) ใช้ editor มาร์กพื้นที่ที่ต้องการ intervention บนภาพ massing [8]
- สร้าง Image node เชื่อม reference ทั้งหมดเข้าด้วยกัน ใช้โมเดลอย่าง Nano Banana ตั้ง wide aspect ratio และเขียน prompt อธิบายอย่างละเอียดว่าแต่ละภาพสัมพันธ์กันอย่างไร (ฟาซาดใส่ตรงไหน, landscaping ใส่ตรงไหน) [8]

**Tips:** prompt ที่ละเอียดสำคัญมาก เพราะ AI ต้องเข้าใจความสัมพันธ์ระหว่างภาพหลายใบพร้อมกัน; การ generate หลายภาพพร้อมกันอาจได้ผลลัพธ์เป็นมุมมองอื่นแทนที่จะตรงมุมเดิมทั้งหมด — ต้องเลือกภาพที่ถูกต้องเอง [8][9]

### เวิร์กโฟลว์ที่ 4: Export KMZ พร้อม Earth Anchor Point เพื่อเรนเดอร์และแอนิเมชัน

เวิร์กโฟลว์สุดท้ายคือการปักโมเดลเต็มรูปแบบลงพิกัดจริง แล้วสร้างแอนิเมชันแบบภาพยนตร์ [9][10][11]

- ใน Google Earth Pro ลากไอคอนหมุด (pin) ไปยัง site เพื่อดึงพิกัด latitude/longitude ที่แม่นยำ [9]
- ใน Rhino พิมพ์คำสั่ง `EarthAnchorPoint` ในช่อง command line ใส่ latitude/longitude ที่คัดลอกมา จากนั้นระบุ base point และ north direction ให้ตรงกับตำแหน่งในโมเดล [9][12]
- เปลี่ยน viewport เป็น render mode (เพื่อให้ export ติด material ไปด้วย) แล้ว export selection เลือก file format เป็น Google Earth (.kmz) [10][13]
- เปิดไฟล์ KMZ นี้ใน Google Earth Pro โดยตรง โมเดลจะปรากฏในตำแหน่งและ scale ที่ถูกต้อง พร้อม material จาก Rhino — screenshot ฉากนี้ [10]
- นำ screenshot เข้า xFigura, prompt ให้ปรับแสง material และคุณภาพ พร้อมเพิ่มต้นไม้/ภูมิทัศน์ โดยคง perspective และ context เดิมไว้ [10]
- เลือก **Video Node** เชื่อมกับภาพที่ enhance แล้ว prompt เช่น "slow camera movement around the tower" เลือกโมเดล video generator (วิดีโอใช้ **Sea Dance**) ตั้ง aspect ratio และความยาว แล้ว generate [11]

**Tips:** เพื่อไม่ให้มุมกล้องเปลี่ยนระหว่างกระบวนการ AI ต้องแคป screenshot ต้นทางเป็น **16:9** พอดี [11]; ตาม guideline ของ Rhino ควรตั้ง perspective view lens length เป็น **21mm** เพราะใกล้เคียงกับมุมกล้องของ Google Earth มากที่สุด [14]; วิดีโอความยาว 10 วินาทีขึ้นไปใช้เวลาประมวลผลหลายนาที [11]

## User Guide (Step-by-Step)

สรุปลำดับขั้นแบบรวบรัดสำหรับเริ่มใช้งานจริง:

1. **ติดตั้ง**: สมัคร xFigura (web-based, ไม่ต้องติดตั้งอะไรสำหรับ workflow เว็บ) และถ้าต้องใช้กับ Rhino ให้ติดตั้ง plugin ผ่าน `Tools > Package Manager` ค้นหา "xfigure" [5]
2. **งานแรก (concept เร็ว)**: ทำเวิร์กโฟลว์ที่ 1 — screenshot จาก Google Earth web + generate จาก text prompt — ใช้เวลาไม่กี่นาทีต่อภาพ
3. **งานที่ต้องใช้โมเดลจริง**: เปิด Rhino พิมพ์ `xfigure` ดึง viewport เข้า canvas โดยตรง (เวิร์กโฟลว์ที่ 2)
4. **งานที่ต้อง precision สูง**: ใช้ Google Earth Pro desktop วาด massing (เวิร์กโฟลว์ที่ 3) แล้วต่อด้วย `EarthAnchorPoint` + KMZ export (เวิร์กโฟลว์ที่ 4) สำหรับ deliverable สุดท้าย
5. **Troubleshooting ที่พบบ่อย**: ถ้า generate ได้มุมมองผิด ให้ตรวจ aspect ratio ของ node แรกก่อนเสมอ; ถ้า KMZ ไม่ตรงตำแหน่ง ให้เช็กค่า `EarthAnchorPoint` กับพิกัดจาก Google Earth Pro อีกครั้ง

## Caveats / Limits

- xFigura เป็นเครื่องมือ paid platform (มี academic discount สำหรับนักศึกษา/อาจารย์) [5][6] — รายละเอียดราคาเปลี่ยนแปลงได้ ควรเช็กหน้าเว็บทางการก่อนสมัคร
- Rhino plugin integration ต้องใช้ Rhino ที่รองรับ Package Manager (Rhino 7 ขึ้นไป); KMZ export/import เป็น native feature ของ Rhino เอง ไม่ใช่ของ xFigura โดยตรง [2][13]
- การ generate หลายภาพพร้อมกันไม่รับประกันว่าทุกภาพจะตรง perspective เดิม — ต้องคัดเลือกภาพที่ถูกต้องด้วยมือ [9]
- ผลลัพธ์จาก AI ทั้งหมด (ภาพและวิดีโอ) เป็น generative output ควรใช้เป็นสื่อนำเสนอ concept ไม่ใช่ construction document
- KML/KMZ ส่วนใหญ่ไม่มี 3D geometry ในตัว การนำเข้า Rhino กลับ (import) จึงมีข้อจำกัดเรื่องความละเอียดของ geometry [13]

## References

1. [Place Buildings in Real Locations, Generate Infinite Design Options with AI (YouTube)](https://youtu.be/S4nvfDQ3ifk)
2. [xFigura: Your All-in-One AI Sandbox for Collaborative Architectural Ideation — Parametric Architecture](https://parametric-architecture.com/xfigura-all-in-one-ai-sandbox/)
3. [xFigura AI Pricing, Features & 2D/3D Ideation Platform — AEC+Tech](https://www.aecplustech.com/tools/xfigura)
4. [Xfigura — AI Spotlight Directory, AEC Magazine](https://aidirectory.aecmag.com/entry/xfigura/)
5. [How xFigura Transformed Architectural Design with Tripo AI's 3D Model API](https://www.tripo3d.ai/blog/xfigura-with-tripo)
6. [Rhino to Google Earth — McNeel Wiki](https://wiki.mcneel.com/rhino/googleearth)
7. [Google Earth (.kmz) export — Rhino 3-D modeling docs](http://docs.mcneel.com/rhino/8mac/help/en-us/fileio/google_earth_kml_kmz_export.htm)

## Key Takeaways

- xFigura รวม generative AI (image, video, 3D) ไว้ใน canvas เดียว ออกแบบมาเฉพาะสำหรับ workflow สถาปนิก
- 4 เวิร์กโฟลว์หลัก: screenshot concept → Rhino canvas import → Google Earth Pro massing → KMZ + Earth Anchor Point export
- `EarthAnchorPoint` command ใน Rhino คือกุญแจสำคัญที่ทำให้โมเดลปักตำแหน่งจริงได้แม่นยำ
- ต้องตั้ง aspect ratio ให้ถูกต้องก่อน generate เสมอ ไม่งั้นระบบจะ default ตามภาพแรก
- screenshot อ้างอิงควรเป็น 16:9 เพื่อรักษามุมกล้องให้คงที่ตลอด pipeline
- Rhino perspective lens length 21mm ใกล้เคียงมุมกล้อง Google Earth มากที่สุด สำหรับงานที่ต้องแม่นยำ
- ผลลัพธ์เหมาะกับการนำเสนอ concept และ pitch ไม่ใช่ construction-grade output
