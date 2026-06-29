---
title: "Unlimited OCR 3B: โมเดล Open-Source ที่อ่านเอกสารทั้งเล่มได้ในครั้งเดียว"
date: 2026-06-28 00:01:00 +0700
categories: [Engineering]
tags: [ocr, document-parsing, open-source, rag, vision-language-model, baidu]
slides: true
---

{% include slide-link.html %}

## TL;DR

Baidu เปิดตัว **Unlimited OCR** — Visual Language Model ขนาด 3B พารามิเตอร์ (active inference: 500M) ที่สามารถอ่านเอกสารทั้งเล่มในครั้งเดียวโดยไม่ต้องตัดหน้า ด้วยกลไก **Soft Forgetting (R-SWA)** ควบคุม KV Cache ให้คงที่ ทำคะแนน OmniDocBench v1.5 ได้ **93.23%** สูงกว่า DeepSeek OCR ถึง 6% — MIT License ดาวน์โหลดใช้ได้ฟรี

## Background / Why this matters

ระบบ OCR แบบดั้งเดิมในสาย RAG (Retrieval-Augmented Generation) มีขั้นตอนที่ซับซ้อน: PDF เข้ามา → OCR Engine ประมวลผลทีละหน้า → ระบบที่สองประกอบข้อความกลับเป็นชิ้นเดียว → index เข้า vector database

ทุกจุดเชื่อมต่อคือจุดที่อาจพัง — ตารางที่คร่อมหน้า header ที่หาย ลำดับการอ่านที่ผิด แต่ละ stage เพิ่มทั้ง latency และ error rate ให้กับ pipeline

Baidu ปล่อย Unlimited OCR เมื่อ 22 มิถุนายน 2026 โดยตั้งโจทย์ใหม่: แทนที่จะแก้ปัญหา input-side (compress visual tokens เหมือน DeepSeek OCR) ให้แก้ปัญหา **output-side** — ทำอย่างไรให้ generate ข้อความยาวๆ โดยที่ KV cache ไม่โตแบบไม่สิ้นสุด

ผลลัพธ์คือโมเดลที่อ่านเอกสารในกระบวนการเดียว ไม่มีการ stitch ไม่มี scheduler ภายนอก และ text ที่ได้สะอาดพร้อมเข้า vector database ทันที

## Deep Dive

### Architecture: Visual Language Model + R-SWA

Unlimited OCR เป็น Visual Language Model ที่มี:

| ค่า | รายละเอียด |
|-----|------------|
| Total parameters | 3B |
| Active parameters (inference) | 500M |
| Context length | 32,768 tokens |
| Max pages per run | ~40 หน้า |
| License | MIT |

กลไกหลักคือ **Reference Sliding Window Attention (R-SWA)** หรือที่เรียกในเชิงแนวคิดว่า "Soft Forgetting"

### Soft Forgetting: กลไก KV Cache แบบมนุษย์

ในการ decode ปกติ (conventional autoregressive decoder) ทุก output token ที่ generate เพิ่ม entry เข้า KV cache — ทำให้ working memory โตเป็น O(n) ตาม sequence ที่ generate ออกมา เมื่อเอกสารยาวขึ้น ระบบช้าลงแบบ quadratic

Unlimited OCR แก้ด้วยการเลียนแบบพฤติกรรมมนุษย์ขณะคัดลอกหนังสือ:

```
มนุษย์คัดลอกหนังสือ:
 ├─ เห็นต้นฉบับทั้งหมดตลอดเวลา (full document in context)
 └─ จำเฉพาะ 2-3 บรรทัดล่าสุดที่เพิ่งเขียน (sliding window of generated text)

Unlimited OCR:
 ├─ Document ทั้งเล่มอยู่ใน context ตลอดการ inference
 └─ KV cache ของ generated text = sliding window ขนาดคงที่
```

ผลลัพธ์: KV cache ของฝั่ง output คงที่ ไม่โต — อ่าน 40 หน้าหรือ 400 หน้าใช้ memory เท่ากัน (ข้อจำกัดอยู่ที่ context length ของ input แทน)

### OmniDocBench: ผลทดสอบ vs คู่แข่ง

OmniDocBench v1.5 คือ benchmark มาตรฐานสำหรับ document parsing ครอบคลุม 4 ประเภทเนื้อหา:

| ประเภทการทดสอบ | Unlimited OCR | DeepSeek OCR | ช่องว่าง |
|----------------|---------------|--------------|----------|
| OmniDocBench v1.5 overall | **93.23%** | ~87% | +6% |
| Formula recognition | ดีมาก | — | — |
| Table recognition | ดีมาก | — | — |
| Reading order | ดีมาก | — | — |
| Handwritten text | อ่อน | — | — |

หมายเหตุ: ตัวเลขรายหมวดอ้างจาก video demo ไม่มีตาราง breakdown แบบ public paper — ตรวจสอบ README ล่าสุดที่ github.com/baidu/Unlimited-OCR

### จุดแข็ง 4 ด้านจาก Demo

**1. Formula Recognition** — อ่านนิพจน์คณิตศาสตร์ซับซ้อน superscript/subscript ได้แม่นยำ แม้ใน PDF ที่มีสูตรยาวหลายบรรทัด

**2. Table Recognition** — ประมวลผลตารางที่มี/ไม่มีเส้นขอบ และตารางที่มีข้อมูลตัวเลขจำนวนมากได้ถูกต้อง

**3. Reading Order** — เอกสาร multi-column, ข้อความผสมรูปภาพ, สแกนเอียง, สีพิมพ์ซับซ้อน โมเดลเรียงลำดับการอ่านตาม human intuition ไม่ใช่แค่ top-to-bottom

**4. Long Document** — อ่านหนังสือทั้งเล่มใน single forward pass — ไม่มี for-loop, ไม่มี external scheduler

### จุดอ่อน: Handwritten Text

เมื่อทดสอบกับเอกสารลายมือโดยเฉพาะที่มีองค์ประกอบซับซ้อน (ข้อความ + รูปภาพ + multi-column ผสมกัน) โมเดลมีปัญหาหลัก 3 อย่าง:
- ข้าม content ไปบางส่วน
- generate ข้อความผิด
- ไม่รักษาโครงสร้างเดิม

Output ที่ได้ต้องผ่านการแก้ไขด้วยมือ — **ยังไม่เหมาะกับงาน handwritten document parsing**

## User Guide (Step-by-Step)

### 1. ติดตั้ง Dependencies

```bash
pip install torch==2.10.0 torchvision==0.25.0 transformers==4.57.1
pip install Pillow einops addict easydict pymupdf psutil
```

ต้องใช้ Python 3.12.3, CUDA 12.9 (ตรวจสอบ requirements.txt ที่ repo ก่อน — version อาจ update)

### 2. โหลดโมเดล

```python
import torch
from transformers import AutoModel, AutoTokenizer

model_name = 'baidu/Unlimited-OCR'
tokenizer = AutoTokenizer.from_pretrained(model_name, trust_remote_code=True)
model = AutoModel.from_pretrained(
    model_name,
    trust_remote_code=True,
    use_safetensors=True,
    torch_dtype=torch.bfloat16,
).eval().cuda()
```

### 3. Single Image Inference

```python
model.infer(
    tokenizer,
    prompt='<image>document parsing.',
    image_file='your_image.jpg',
    output_path='./output/',
    base_size=1024,
    image_size=640,
    crop_mode=True,
    max_length=32768,
    no_repeat_ngram_size=35,
    ngram_window=128,
    save_results=True,
)
```

### 4. Multi-Page / PDF Inference

```python
model.infer_multi(
    tokenizer,
    prompt='<image>Multi page parsing.',
    image_files=['page1.png', 'page2.png', 'page3.png'],
    output_path='./output/',
    image_size=1024,
    max_length=32768,
    no_repeat_ngram_size=35,
    ngram_window=1024,
    save_results=True,
)
```

`ngram_window=1024` สำหรับ multi-page ช่วย reduce repetition ในเอกสารยาว

### 5. vLLM Docker (Production)

```bash
docker pull vllm/vllm-openai:unlimited-ocr
```

### 6. Batch Inference ด้วย SGLang

```bash
# จาก folder รูปภาพ
python infer.py --image_dir ./examples/images \
  --output_dir ./outputs --concurrency 8 --image_mode gundam

# จาก PDF โดยตรง
python infer.py --pdf ./examples/document.pdf \
  --output_dir ./outputs --concurrency 8 --image_mode gundam
```

### เชื่อม RAG Pipeline

Output จาก Unlimited OCR คือ clean Markdown — ไม่ต้องผ่าน post-processing step เพิ่ม:

```python
# ตัวอย่าง flow: OCR → chunk → embed → store
result_text = open('./output/result.md').read()

# ส่งตรงเข้า chunker โดยไม่ต้อง stitch หน้า
from langchain.text_splitter import RecursiveCharacterTextSplitter
chunks = RecursiveCharacterTextSplitter(chunk_size=512).split_text(result_text)
```

## Caveats / Limits

- **Handwritten content**: ไม่น่าเชื่อถือ — ข้าม content, text ผิด, โครงสร้างพัง
- **CUDA 12.9 required**: ตรวจสอบ GPU compatibility ก่อน; Apple Silicon → ใช้ community build `LoJexLLM/Unlimited-OCR-MLX`
- **Context limit**: 32K tokens = ~40 หน้า; เอกสารยาวกว่านี้ต้องแบ่ง batch เอง
- **`trust_remote_code=True`**: ควรตรวจสอบ source code ก่อน run ใน production environment
- **Benchmark coverage**: ตัวเลข per-category breakdown ยังไม่มีใน official paper — อ้างจาก video demo เท่านั้น

## References

1. Unlimited OCR + RAG: Revolutionize Complex Data Extraction (Open-Source) — [YouTube](https://youtu.be/QA8hoFdtRXQ)
2. GitHub Repository — [github.com/baidu/Unlimited-OCR](https://github.com/baidu/Unlimited-OCR)
3. HuggingFace Model — [huggingface.co/baidu/Unlimited-OCR](https://huggingface.co/baidu/Unlimited-OCR)
4. Community GGUF — [huggingface.co/sahilchachra/Unlimited-OCR-GGUF](https://huggingface.co/sahilchachra/Unlimited-OCR-GGUF)
5. Community MLX (Apple Silicon) — [huggingface.co/LoJexLLM/Unlimited-OCR-MLX](https://huggingface.co/LoJexLLM/Unlimited-OCR-MLX)

## Key Takeaways

- **3B total, 500M active**: ขนาดเล็กแต่ประสิทธิภาพสูง — inference บน consumer GPU ได้
- **Soft Forgetting (R-SWA)**: KV cache ของ generated text เป็น sliding window คงที่ — ไม่โตตามความยาว output
- **Single-pass RAG**: อ่านเอกสารทั้งเล่มในครั้งเดียว ตัด stitching errors ออกจาก pipeline ได้เลย
- **OmniDocBench v1.5: 93.23%** — เหนือ DeepSeek OCR 6% ในการทดสอบมาตรฐาน
- **Formula + Table + Reading Order = แข็งแกร่ง**: ครอบคลุม document type หลักในงาน enterprise
- **MIT License**: ใช้ได้ทั้งงานส่วนตัวและ production commercial โดยไม่มีค่าลิขสิทธิ์
- **Handwritten = จุดอ่อน**: ยังต้องการ manual review — อย่าใช้ใน pipeline แบบ fully automated สำหรับ handwritten input
