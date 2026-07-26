---
title: "สร้างระบบ Face Detection ด้วย Python: OpenCV, YOLOv8 และ Webcam"
date: 2026-07-25 00:04:00 +0700
categories: [Engineering]
tags: [python, opencv, yolo, computer-vision, pytorch, cuda]
slides: true
---

{% include slide-link.html %}

## TL;DR

ประกอบระบบ face detection real-time จากศูนย์ด้วย Python — ตั้ง environment ด้วย Miniconda, โหลด YOLOv8 มาตรวจจับวัตถุทั่วไป, เสริม YOLOv8-face model จาก GitHub เพื่อตรวจจับใบหน้าโดยเฉพาะ, รันพร้อมกันบน live webcam feed ผ่าน `while` loop และเร่งความเร็วด้วย GPU/CUDA ผ่าน PyTorch [1]

## Background / Why this matters

YOLOv8 (You Only Look Once v8) ของ Ultralytics เป็นโมเดล object detection ที่ pretrained บน COCO dataset มาพร้อม 80 classes มาตรฐาน เช่น person, bicycle, car [4] — แต่ "person" ไม่ใช่ "face" มันบอกได้แค่ว่ามีคนอยู่ในเฟรม ไม่ได้ระบุตำแหน่งใบหน้าแบบละเอียด งานหลายอย่าง (attendance system, privacy blur, emotion analysis เบื้องต้น) ต้องการ bounding box เฉพาะใบหน้า ซึ่งต้องอาศัยโมเดลที่ train เฉพาะทางเพิ่ม

จุดที่น่าสนใจของ workflow นี้คือการรัน 2 โมเดล YOLO พร้อมกันบนเฟรมเดียวกัน (general object model + face model) แล้ว overlay ผลลัพธ์เข้าด้วยกัน — เป็นรูปแบบทั่วไปที่ใช้ขยาย capability ของ pretrained model โดยไม่ต้อง fine-tune เองใหม่ทั้งหมด และเป็นจุดที่ CPU มักจะตันก่อน ทำให้การย้ายไปรันบน GPU กลายเป็นเรื่องจำเป็นไม่ใช่ทางเลือก

## Deep Dive

### 1. Miniconda & Environment Setup

Miniconda คือ minimal installer ที่มีแค่ Conda + Python — ต่างจาก Anaconda Distribution ที่มาพร้อม package วิทยาศาสตร์ข้อมูลจำนวนมาก เหมาะกับคนที่รู้อยู่แล้วว่าต้องการ package อะไรบ้างและอยากควบคุม environment เอง [2]

ขั้นตอน:
```bash
# ติดตั้ง Miniconda ตาม installer ของ OS ตัวเอง (Windows/macOS/Linux)
conda create -n detection_env python=3.12
conda activate detection_env
```

### 2. ติดตั้ง opencv-python, ultralytics, jupyter

ใน environment ที่ activate แล้ว ติดตั้ง 3 package หลักผ่าน pip:

```bash
pip install opencv-python   # cv2 — computer vision I/O (webcam, image, video) [3]
pip install ultralytics     # ที่อยู่ของโมเดล YOLO ทุกเวอร์ชัน [4]
pip install jupyter         # coding interface แบบ interactive notebook
```

`opencv-python` เป็น pre-built CPU-only wheel ของ OpenCV ที่แจกผ่าน PyPI ("OpenCV on Wheels") ไม่ต้อง compile เอง [3]

### 3. โหลด YOLOv8 สำหรับตรวจจับวัตถุทั่วไป

Ultralytics มี YOLOv8 5 ขนาด — `n` (nano, เร็วสุด), `s`, `m`, `l`, `x` (large, แม่นสุด) — trade-off ระหว่างความเร็วกับความแม่นยำ [4]

```python
from ultralytics import YOLO

model = YOLO("yolov8n.pt")   # auto-download weights ถ้ายังไม่มีในเครื่อง
results = model("path/to/image.jpg")
```

โมเดลนี้ตรวจจับได้ 80 classes จาก COCO dataset แต่ไม่มี class "face" เฉพาะ [4] — ต้องเสริมโมเดลที่ 4

### 4. เพิ่ม YOLOv8-face model จาก GitHub

Repo [`akanametov/yolo-face`](https://github.com/akanametov/yolo-face) แจก weight ที่ train เฉพาะสำหรับ face detection บน WIDERFACE dataset ครอบคลุมหลายเวอร์ชัน YOLO (v6/v8/v10/v11/v12) ขนาด n/s/m/l ต่อเวอร์ชัน — สำหรับ YOLOv8 มี `yolov8n-face.pt`, `yolov8m-face.pt`, `yolov8l-face.pt` ให้เลือก [5] repo อยู่ภายใต้ GPL-3.0 License (มี Enterprise License แยกสำหรับใช้เชิงพาณิชย์) [5]

```python
face_model = YOLO("yolov8m-face.pt")   # ดาวน์โหลด weight จาก repo แล้ววางไว้ในโปรเจกต์
```

ตอนรันจริง ส่งเฟรมเดียวกันเข้าทั้ง `model` (วัตถุทั่วไป) และ `face_model` (ใบหน้า) แล้ว overlay bounding box จากทั้งสองผลลัพธ์ทับกันบนภาพเดียว

### 5. Live webcam inference ผ่าน while loop

```python
import cv2

cap = cv2.VideoCapture(0)   # 0 = default camera, เปลี่ยน index ถ้ามีหลายกล้อง

while True:
    ret, frame = cap.read()
    if not ret:
        break

    obj_results = model(frame, verbose=False)
    face_results = face_model(frame, verbose=False)

    annotated = obj_results[0].plot()
    annotated = face_results[0].plot(img=annotated)

    cv2.imshow("Face + Object Detection", annotated)
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
```

`cv2.VideoCapture()` เปิด stream จากกล้อง, loop วนอ่านทีละเฟรมด้วย `cap.read()`, ประมวลผลผ่านทั้งสองโมเดล, แสดงผลด้วย `cv2.imshow()`, และ `cv2.waitKey()` ใช้เช็คปุ่มกดเพื่อ break loop ปิดกล้องอย่างถูกต้อง

### 6. ลดความหน่วงด้วย GPU/CUDA ผ่าน PyTorch

รัน 2 โมเดลพร้อมกันบน CPU หนักและทำให้ frame rate ตก — ถ้ามี NVIDIA GPU ให้ย้ายไปรันบน CUDA แทน:

1. เช็กเวอร์ชัน CUDA driver: `nvidia-smi`
2. ไปที่ [PyTorch — Start Locally](https://docs.pytorch.org/get-started/locally/) เลือก OS / Package (pip) / CUDA version ที่ตรงกับเครื่อง แล้ว copy คำสั่ง pip install ที่ selector สร้างให้ (ถ้ามี PyTorch CPU-only ติดตั้งอยู่ก่อน ให้ uninstall ออกก่อน) [6]
3. เพิ่ม `.to("cuda")` ให้ทั้งสองโมเดล:

```python
model = YOLO("yolov8n.pt").to("cuda")
face_model = YOLO("yolov8m-face.pt").to("cuda")
```

## User Guide (Step-by-Step)

1. **ติดตั้ง Miniconda** → สร้าง environment: `conda create -n detection_env python=3.12` → `conda activate detection_env`
2. **ติดตั้ง dependencies**: `pip install opencv-python ultralytics jupyter`
3. **ทดสอบโมเดลพื้นฐาน** — เปิด Jupyter, โหลด `yolov8n.pt`, รันบนภาพนิ่งดูก่อนว่า detect วัตถุได้ปกติ
4. **ดาวน์โหลด face weight** จาก [akanametov/yolo-face](https://github.com/akanametov/yolo-face) (เช่น `yolov8m-face.pt`) วางในโฟลเดอร์โปรเจกต์
5. **รัน dual-model บนภาพนิ่งก่อน** — ยืนยันว่า overlay bounding box จากทั้งสองโมเดลถูกต้อง ก่อนต่อ webcam
6. **ต่อ webcam ด้วย while loop** ตามโค้ดใน Deep Dive ข้อ 5 — กด `q` เพื่อปิดโปรแกรม
7. **ถ้า frame rate กระตุก** — เช็ก `nvidia-smi`, ติดตั้ง PyTorch CUDA build ตาม selector ของ pytorch.org, แล้วเพิ่ม `.to("cuda")` ให้ทั้งสองโมเดล

## Caveats / Limits

- `opencv-python` (pip) เป็น build headless แบบ GUI-enabled ปกติ — ถ้า deploy บน server/container ที่ไม่มี GUI ให้ใช้ `opencv-python-headless` แทน ไม่งั้น `cv2.imshow()` จะ error
- Face detection model จาก community repo (ไม่ใช่ official Ultralytics) — license เป็น GPL-3.0 ต้องเช็กเงื่อนไขก่อนใช้ในโปรเจกต์เชิงพาณิชย์ หรือใช้ Enterprise License แทน [5]
- รันสองโมเดล YOLO พร้อมกันบน CPU กิน resource สูง มือใหม่ที่ไม่มี NVIDIA GPU จะเจอ latency สูงจนภาพกระตุกได้
- Face detection ≠ Face recognition — โมเดลนี้บอกแค่ "ตรงนี้มีใบหน้า" ไม่ได้ identify ว่าใบหน้าเป็นใคร
- Index กล้องใน `cv2.VideoCapture()` (0, 1, 2, …) ขึ้นกับเครื่อง ถ้ามีหลายกล้องหรือ virtual camera ต้องลองเปลี่ยนเลขจนกว่าจะเจอตัวที่ถูกต้อง

## References

1. [Python Face Detection from Scratch (OpenCV + YOLO + Webcam)](https://youtu.be/GhAC0xBIepQ) — YouTube
2. [Anaconda Distribution vs. Miniconda](https://docs.anaconda.com/free/miniconda/) — Anaconda official docs
3. [opencv-python](https://pypi.org/project/opencv-python/) — PyPI
4. [Explore Ultralytics YOLOv8](https://docs.ultralytics.com/models/yolov8/) — Ultralytics Docs
5. [akanametov/yolo-face](https://github.com/akanametov/yolo-face) — GitHub
6. [Start Locally](https://docs.pytorch.org/get-started/locally/) — PyTorch official docs

## Key Takeaways

- Miniconda ให้ environment ที่ isolate และ control เวอร์ชัน package ได้ชัดเจน เหมาะกับโปรเจกต์ CV ที่ dependency เยอะ
- YOLOv8 pretrained บน COCO detect ได้ 80 classes ทั่วไป แต่ไม่มี class "face" เฉพาะ ต้องเสริมโมเดลแยก
- รันสองโมเดล YOLO พร้อมกัน (general + face) แล้ว overlay ผลลัพธ์ เป็นวิธีขยาย capability โดยไม่ต้อง fine-tune เอง
- `cv2.VideoCapture()` + `while` loop + `cap.read()` + `cv2.imshow()` คือ pattern มาตรฐานสำหรับ live video inference
- CPU รันสองโมเดลพร้อมกันหนักมาก — GPU/CUDA ผ่าน PyTorch (`.to("cuda")`) จำเป็นสำหรับ real-time ที่ลื่นจริง
- Face detection model จาก community repo มักมี license เข้มกว่า official model — เช็กก่อนใช้เชิงพาณิชย์
