---
title: "Pixal3D: โมเดล Open-Weights 3D ใหม่จาก Tencent Arc ที่ท้าทาย Paid Platforms"
date: 2026-05-31 06:42:00 +0700
categories: [Engineering]
tags: [3d-ai, open-weights, local-ai, tencent, generative-ai, siggraph]
---

## TL;DR

Pixal3D คือ image-to-3D model แบบ open-weights ตัวใหม่จาก Tencent ARC Lab ที่ใช้วิธี back-project pixel features ลง 3D โดยตรง ทำให้ได้ output ที่ faithful กับรูปต้นฉบับมากกว่าทุก local model ที่มีก่อนหน้า ถูก accept ใน SIGGRAPH 2026 และ weights เปิดบน HuggingFace ภายใต้ MIT License

## Background / Why This Matters

โมเดล image-to-3D รุ่นก่อน เช่น Trellis, Hunyuan 3D, และ Direct3D ล้วนใช้วิธีเดียวกันคือ "สร้าง geometry ใน canonical space แล้วค่อย reference รูปผ่าน attention layer" ผลคือ output คล้ายรูปต้นฉบับ แต่ไม่เคย *ตรง* จริงๆ — silhouette เบี้ยว, proportions หลุด, รายละเอียดหายไปในกระบวนการ abstraction

Pixal3D เปลี่ยนวิธีคิดใหม่ทั้งหมด: แทนที่จะ "มองรูป" ผ่าน attention, มัน back-project pixel features ลงไปตรงๆ ใน 3D space ทำให้ทุก pixel ของรูปต้นฉบับมี correspondence ตรงกับ 3D surface — เรียกว่า **pixel-aligned, sub-pixel faithful**

สำหรับงาน game concepting, level design, หรือ environment blocking นี่คือ game changer เพราะ prop ที่วาดขึ้นมาจะกลายเป็น 3D ที่ดูเหมือนของจริงโดยไม่ต้อง clean up manual มากนัก

## Deep Dive

### สถาปัตยกรรม

Pixal3D ใช้ **Trellis 2 + Direct3D** เป็น backbone และเพิ่ม pixel-alignment layer ด้านบน:

- **Input**: รูปเดียว (single image to 3D)
- **Process**: Back-project pixel features → establish 3D correspondences → generate geometry + PBR textures
- **Output**: 3D mesh + physically based rendering textures

layer ที่ทำให้มันพิเศษ (pixel-alignment) เป็น open-weights แต่ไม่ open-source — หมายความว่า weights ใช้ได้แต่ architecture code เต็มๆ ยังไม่เปิด

### เปรียบเทียบกับ Models อื่น

| Model | Pixel Fidelity | Shape Accuracy | Commercial | Local |
|-------|---------------|----------------|-----------|-------|
| **Pixal3D** | ★★★★★ | ★★★☆☆ | MIT License | ✓ (24GB VRAM) |
| Trellis 2 | ★★★☆☆ | ★★★★☆ | Open | ✓ |
| Hunyuan 3D | ★★★☆☆ | ★★★★☆ | Limited | ✓ |
| **Tripo** | ★★★★☆ | ★★★★★ | Paid | ✗ |

Tripo ยังคือ #1 สำหรับ shape accuracy โดยรวม แต่ Pixal3D ชนะในเรื่อง pixel-faithfulness สำหรับ front-facing assets

### จุดแข็ง

- **Silhouette accuracy**: ขอบและรูปร่างตรงกับรูปต้นฉบับแทบ 1:1
- **Color fidelity**: สีและ texture ใกล้เคียงรูปต้นฉบับมากกว่า Hunyuan และ Trellis
- **Background objects**: assets ที่วางพื้นหลัง game ออกมาดีมาก
- **Detail retention**: รักษา detail ได้ดีกว่า Hunyuan 3D ที่ชอบ simplify shapes

### จุดอ่อน

- **Rotation problem**: เพราะมัน pixel-aligned กับ view เดิม เวลาหมุน 3D model มักมี artifacts ด้านหลัง
- **Complex geometry**: shapes ที่ต้องการ 3D reasoning (เช่น ปืน, object ที่ถ่ายมุมเฉียง) ทำได้แย่กว่า Trellis
- **VRAM สูง**: ต้องการ 24GB VRAM minimum (low VRAM mode มีใน code แต่ยังไม่ stable)
- **EU restriction**: license block การใช้ใน European Union

### วิธีรัน Local

ต้องการ GPU 24GB+ (หรือใช้ RunPod/cloud GPU):

```bash
# 1. Clone repository
git clone https://github.com/TencentARC/Pixal3D
cd Pixal3D

# 2. Install dependencies (ต้องติดตั้ง Trellis 2 ก่อน)
pip install -r requirements.txt

# 3. Download weights จาก HuggingFace (อาจต้อง request access)
# https://huggingface.co/TencentARC/Pixal3D

# 4. Run Gradio demo
python app.py
```

UI workflow: drop image → click Preview (ไม่ใช่ final quality) → ถ้าพอใจ → Extract Mesh

### License

ปัจจุบัน GitHub repo ระบุ **MIT License** — ใช้ได้ทั้ง commercial และ personal ตาม license terms ปกติ (ช่วงที่วิดีโอถ่าย อาจยังเป็น academic-only แล้วค่อย update เป็น MIT ในภายหลัง)

## Caveats / Limits

- **24GB VRAM**: GPU ระดับ RTX 4090 ขึ้นไป หรือ A100/H100 ถ้าใช้ cloud
- **EU License Block**: ผู้ใช้ใน European Union ถูก restrict โดย license
- **Pixel-alignment trade-off**: เหมาะกับ front-facing assets มากกว่า objects ที่ต้องการ all-around accuracy
- **Back-view artifacts**: ผิวด้านหลังมักมี geometry issues เพราะ model ไม่เห็น pixel นั้นจากรูปต้นฉบับ
- **HuggingFace gating**: บางประเทศต้อง request access แต่ได้รับ approve ทันที
- **Demo queue**: Gradio demo online มี queue ยาวและ instance อาจ down บ่อยเพราะ traffic สูง

## References

1. [Pixal3D GitHub — TencentARC/Pixal3D](https://github.com/TencentARC/Pixal3D)
2. [Pixal3D HuggingFace Model Weights](https://huggingface.co/TencentARC/Pixal3D)
3. [Pixal3D Project Page](https://pixal3d.xyz/)
4. [ArXiv Paper: Pixal3D: Pixel-Aligned 3D Generation from Images (2605.10922)](https://arxiv.org/html/2605.10922v1)
5. [SIGGRAPH 2026 Announcement — Ying Shan on X](https://x.com/yshan2u/status/2054084762340565260)
6. [YouTube Review + Demo by Corridor3D](https://youtu.be/v22dtm3-vqM)

## Key Takeaways

- Pixal3D แก้ปัญหาเรื่อง pixel-faithfulness ที่ทุก model ก่อนหน้าแก้ไม่ได้ โดย back-project pixel features ลง 3D โดยตรง
- เหมาะที่สุดสำหรับ **concepting, blocking, level design** — assets ที่ถ่ายหน้าตรงออกมาดีมาก
- ยังต้องการ GPU 24GB+ ซึ่งเป็นอุปสรรคสำคัญสำหรับ consumer hardware
- Tripo ยังเป็น #1 สำหรับ all-around shape accuracy แต่ Pixal3D ชนะในด้าน pixel-fidelity
- MIT License ทำให้ใช้ได้ทั้ง personal และ commercial (ยกเว้น EU restriction)
- backbone open-source (Trellis 2 + Direct3D) แต่ pixel-alignment layer เป็น open-weights only — community ยังต่อยอดได้แต่มีข้อจำกัด
- รับ accept ที่ SIGGRAPH 2026 — นับเป็นก้าวสำคัญของ local AI 3D ที่พัฒนาเร็วมากในปีนี้
