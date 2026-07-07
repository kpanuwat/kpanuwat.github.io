---
title: "ComfyUI + LTX 2.3: สร้าง AI Video ฟรีบน PC ด้วย Nvidia RTX"
date: 2026-07-07 00:01:00 +0700
categories: [Tools]
tags: [comfyui, ai-video, ltx, text-to-video, image-to-video, nvidia-rtx, local-ai, open-source]
image:
  path: /assets/img/posts/comfyui-local-ai-video-generation.jpg
  alt: ComfyUI node-based workflow generating AI video locally with LTX 2.3
---

## TL;DR

ComfyUI คือแอป open-source ที่รัน AI model บนพีซีของเราเอง (local) ทำให้สร้าง AI video ได้ฟรีแบบไม่จำกัดจำนวนครั้ง ไม่ต้องมี API key และไม่ต้องสมัคร subscription — จับคู่กับโมเดล LTX 2.3 บน Windows + Nvidia RTX จะได้ workflow ที่เร็วและรองรับทั้ง Text-to-Video และ Image-to-Video ในตัวเดียว

## Background / Why this matters

เครื่องมือสร้าง AI video ส่วนใหญ่ในตลาด (เช่น Runway, Pika, Sora) เป็นแบบ cloud-based ต้องจ่ายค่า subscription หรือซื้อ credit ต่อวิดีโอ — ค่าใช้จ่ายจะบวมขึ้นเรื่อยๆ ถ้าต้อง generate ซ้ำหลายรอบเพื่อปรับ prompt ให้ได้ผลลัพธ์ที่ต้องการ

ComfyUI แก้ปัญหานี้ด้วยการรันทุกอย่าง "local" คือประมวลผลบนการ์ดจอของเราเองทั้งหมด เมื่อติดตั้งเสร็จแล้วไม่มีค่าใช้จ่ายต่อวิดีโอเลย ตัวแอปใช้ interface แบบ node-based (ลาก-วาง-เชื่อมต่อ node) ทำให้ปรับแต่ง pipeline ได้ละเอียดโดยไม่ต้องเขียนโค้ด นอกจากวิดีโอแล้ว ComfyUI ยังรองรับการสร้างภาพ, เสียง, โมเดล 3D และรัน LLM ได้ในระบบเดียวกัน

## Deep Dive

### ComfyUI คืออะไร

ComfyUI เป็น visual workflow editor สำหรับรัน diffusion model และ generative model อื่นๆ บนเครื่องของผู้ใช้เอง ทุก node ในหน้าจอแทน operation หนึ่งขั้นตอน (load model, encode prompt, sample, decode, save) ต่อกันเป็น pipeline ที่มองเห็นได้ทั้งหมด — จุดเด่นคือ **community เปิด custom node ให้ต่อขยายได้เรื่อยๆ** เช่น node สำหรับโมเดล LTX-Video โดยเฉพาะ

### ทำไมแนะนำ Windows + Nvidia RTX

Nvidia RTX เป็น hardware configuration ที่เสถียรและรองรับ workflow นี้ดีที่สุด เพราะ ecosystem ของ CUDA + PyTorch optimization ถูก tune มาสำหรับ RTX โดยเฉพาะ — ทั้ง NVIDIA และ ComfyUI ร่วมมือกันปรับ performance ของ LTX-Video ให้รันบน GPU ผู้บริโภค (consumer GPU) ได้จริง ไม่ใช่แค่ data-center GPU

### โมเดล LTX 2.3: Text-to-Video และ Image-to-Video

LTX (พัฒนาโดย Lightricks ร่วมกับ NVIDIA) เป็นโมเดล video generation แบบ open-source ที่เน้นความเร็ว รุ่น 2.3 รองรับ:

- **Text-to-Video** — generate วิดีโอจาก text prompt อย่างเดียว มีทั้ง workflow แบบ single-stage (distilled, เร็ว) และ two-stage (มี spatial upscaling, คุณภาพสูงสุด)
- **Image-to-Video** — ลากภาพนิ่งเข้า node แล้วเขียน prompt อธิบาย motion ที่ต้องการ โมเดลจะ "อนิเมท" ภาพนั้นให้ขยับตาม
- ฟีเจอร์เสริมอื่น: text-to-audio (T2A), Union IC-LoRA (control ด้วย depth/edge map), Lipdub (sync ปากกับเสียงพูด), และ HDR video output

### พื้นที่เก็บข้อมูลและ VRAM requirements

- **Disk space**: ตัวโมเดล LTX 2.3 พื้นฐาน + dependencies ใช้พื้นที่ประมาณ **40 GB** สำหรับดาวน์โหลดครั้งแรก ถ้ารวม ComfyUI + cache อื่นๆ ด้วย ควรเผื่อพื้นที่ว่างรวมมากกว่า 100 GB
- **VRAM**: เอกสารทางการของ LTX แนะนำ GPU ที่มี VRAM 32GB+ สำหรับความแม่นยำเต็ม (bf16) แต่ในทางปฏิบัติ การ์ดจอ consumer อย่าง RTX 3060 (12GB) ก็ใช้งานได้ผ่านโมเดลแบบ FP8/quantized ส่วน RTX 3090/4090 (24GB) จะได้ผลลัพธ์ที่ดีกว่าและเร็วกว่า ComfyUI ยังมี weight-streaming (offload ไป system RAM เมื่อ VRAM ไม่พอ) และ low-VRAM loader node ช่วยลดภาระเพิ่มอีกชั้น

### การตั้งค่า Workflow: Prompt, Resolution, Duration, Frame Rate

ก่อนกด Run ผู้ใช้ปรับพารามิเตอร์หลักได้อิสระผ่าน node:

- **Prompt** — ใส่รายละเอียดฉาก, การกระทำ, ศัพท์ cinematography (เช่น "golden hour", "close-up shot") จะได้ผลลัพธ์ดีกว่า prompt สั้นๆ
- **Resolution** — width/height ต้องเป็นตัวเลขที่หารด้วย 32 ได้ลงตัว และแนะนำไม่เกิน 720×1280 เพื่อรักษา performance
- **Duration / Frame count** — จำนวนเฟรมต้องเป็น multiple ของ 8 บวก 1 (เช่น 65 หรือ 257 เฟรม) ตาม architecture ของ LTX
- **Frame rate** — ปรับได้เพื่อควบคุมความ smooth ของ motion

## User Guide (Step-by-Step)

1. **ติดตั้ง ComfyUI Desktop** — เข้าเว็บไซต์ ComfyUI กด Download Desktop แล้วรัน installer เลือกโหมด "local" เพื่อให้ประมวลผลบนเครื่องเราเองทั้งหมด
   > Expected: แอป ComfyUI เปิดขึ้นมาที่ home screen พร้อม sidebar ด้านซ้าย

2. **ติดตั้ง LTXVideo custom node** — กด `Ctrl+M` เปิด ComfyUI Manager → "Install Custom Nodes" → ค้นหา "LTXVideo" → กด Install → restart ComfyUI
   > Expected: node ใหม่ปรากฏใน node menu หมวด "LTXVideo"; โมเดลที่ต้องใช้จะดาวน์โหลดอัตโนมัติในการรันครั้งแรก

3. **โหลด Template** — จาก home screen เลือก Templates → ค้นหา "LTX-2.3" → เลือก Text-to-Video หรือ Image-to-Video → "Download all" เพื่อดึงโมเดลที่เหลือ
   > Expected: workflow graph พร้อม node ครบชุด รอแค่กรอก prompt

4. **ตั้งค่า Prompt/Resolution/Duration/Frame rate** — กรอก prompt ใน text node, ปรับ resolution/frame count ใน sampler node ตามเกณฑ์ข้างบน แล้วกด Run
   > Expected: progress bar แสดงสถานะ generate; วิดีโอความยาว 5 วินาทีบน RTX 4090 (FP8 distilled, 8 steps) ใช้เวลาประมาณ 20-40 วินาที

5. **จัดการไฟล์ผ่าน Assets** — คลิกแท็บ "Assets" ด้านซ้ายเพื่อ preview, save ไปโฟลเดอร์อื่น หรือลบวิดีโอที่ generate แล้ว โดยไม่ต้องเข้าไปหาไฟล์เองใน File Explorer

6. **Troubleshooting** — ถ้า VRAM ไม่พอ (out-of-memory): เปลี่ยนไปใช้ low-VRAM loader node หรือลด resolution/frame count ลง; ถ้าดาวน์โหลดโมเดลช้า: ตรวจสอบพื้นที่ disk เหลือพอ (40GB+) ก่อนเริ่ม download

## Caveats / Limits

- เอกสารทางการระบุ VRAM ที่แนะนำคือ 32GB+ — การใช้งานบน GPU consumer (12-24GB) ต้องพึ่ง quantized model (FP8) ซึ่งคุณภาพ/ความเร็วจะต่างจากรุ่น full-precision
- resolution และ frame count มีข้อจำกัดทางคณิตศาสตร์ (multiple ของ 32 และ 8+1 ตามลำดับ) — ใส่ค่าผิดจะ error หรือถูก auto-round
- การดาวน์โหลดโมเดลครั้งแรกใช้เวลานานและกินพื้นที่ disk มาก (~40GB สำหรับ LTX 2.3 อย่างเดียว) — ควรเช็ค bandwidth และพื้นที่ว่างก่อนเริ่ม
- แม้จะ "ฟรี" ในแง่ไม่มีค่า subscription แต่ต้นทุนจริงคือค่าไฟและการ์ดจอราคาแพง (RTX 3090/4090) ถ้าต้องการความเร็วและคุณภาพสูงสุด

## References

1. [Free AI Video Generator on Your PC (ComfyUI Tutorial)](https://youtu.be/0z8Pp4TaAl8)
2. [GitHub - Lightricks/ComfyUI-LTXVideo](https://github.com/Lightricks/ComfyUI-LTXVideo/)
3. [NVIDIA RTX Accelerates 4K AI Video Generation on PC With LTX-2 and ComfyUI Upgrades](https://blogs.nvidia.com/blog/rtx-ai-garage-ces-2026-open-models-video-generation/)
4. [Using ComfyUI with LTX | LTX Documentation](https://docs.ltx.video/open-source-model/integration-tools/comfy-ui)
5. [LTX Video Workflow Step-by-Step Guide | ComfyUI Wiki](https://comfyui-wiki.com/en/tutorial/advanced/ltx-video-workflow-step-by-step-guide)

## Key Takeaways

- ComfyUI = local, open-source, node-based tool สำหรับสร้าง AI content ทุกประเภทรวมถึงวิดีโอ ไม่มีค่า API/subscription
- LTX 2.3 รองรับทั้ง Text-to-Video และ Image-to-Video ในตัวเดียว พร้อมฟีเจอร์เสริมอย่าง T2A และ Lipdub
- ต้องเผื่อพื้นที่ disk ~40GB สำหรับโมเดล LTX 2.3 ครั้งแรก และ 100GB+ รวมทั้งระบบ
- VRAM ทางการแนะนำ 32GB+ แต่ RTX consumer (12-24GB) ใช้งานได้จริงผ่าน FP8/low-VRAM node
- resolution ต้องหารด้วย 32 ได้ลงตัว, frame count ต้องเป็น multiple ของ 8+1 — ข้อจำกัดจาก architecture ของ LTX
- ไฟล์ output ทั้งหมดจัดการผ่านแท็บ Assets ในตัวแอป ไม่ต้องเข้า File Explorer
