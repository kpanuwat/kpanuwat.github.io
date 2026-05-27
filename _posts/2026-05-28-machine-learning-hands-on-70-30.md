---
title: "เรียน Machine Learning อย่างมีประสิทธิภาพ: กฎ 70/30 และ Roadmap สู่งาน"
date: 2026-05-27 00:11:00 +0700
categories: [Engineering]
tags: [machine-learning, python, pytorch, scikit-learn, mlops, deep-learning]
slides: true
---

{% include slide-link.html %}

## TL;DR

อยากเรียน ML ให้หางานได้จริงใน 6-9 เดือน? ใช้กฎ **70/30**: เขียนโค้ดและทำโปรเจกต์ 70%, ดูคอร์ส/อ่านทฤษฎี 30% — แล้วเรียนตาม roadmap 6 ขั้นที่ถูกลำดับ: Python → Libraries → Math → Core ML (Scikit-learn) → Deep Learning (PyTorch) → MLOps + Cloud สิ่งที่ขาดไม่ได้คือ "Learn in Public" เพื่อสร้างโปรไฟล์ที่ recruiter มองเห็น

## Background / Why this matters

หลายคนที่เริ่มเรียน Machine Learning ติดกับดัก **"tutorial hell"** — ดูคอร์สไปเรื่อยๆ แต่ไม่เคยนำ code ไปใช้จริง หรือพยายามเรียนคณิตศาสตร์ให้เชี่ยวชาญก่อนแตะ ML เลย ทั้งสองแนวทางล้วนเสียเวลา

ความจริงคือ ML Engineer ที่ทำงานจริงในบริษัทไม่ได้ใช้เวลาส่วนใหญ่ไปกับการพิสูจน์สมการ — เขาใช้เวลาไปกับการ debug pipeline, clean ข้อมูลสกปรก, และ deploy model ขึ้น production การเรียนที่มีประสิทธิภาพจึงต้องเลียนแบบสภาพการทำงานจริง ไม่ใช่ท่อง textbook

วิดีโอ "How to learn Machine Learning like a GENIUS and not waste time" นำเสนอ roadmap ที่ตอบโจทย์นี้ มีลำดับขั้นที่ชัดเจน เน้นการลงมือทำ และครอบคลุมทักษะที่ทำให้หางานได้จริงซึ่ง roadmap ทั่วไปมักข้ามไป

## Deep Dive

### กฎ 70/30: หลักการหลักของ Roadmap นี้

**70%** ของเวลาทั้งหมด → เขียน code, ทำโปรเจกต์, ลองผิดลองถูก  
**30%** ของเวลาทั้งหมด → อ่านทฤษฎี, ดูคอร์ส

กุญแจสำคัญ: เมื่อติดปัญหา (ซึ่งจะเกิดขึ้นแน่นอน) ให้ใช้ความเจ็บปวดนั้นเป็น **แรงจูงใจ** กลับไปเรียนทฤษฎีหรือ math ที่จำเป็นต่อการแก้ปัญหาโดยตรง วิธีนี้ทำให้ทฤษฎีมีความหมายและจดจำได้นาน

### Step 1: Python Fundamentals (3-4 สัปดาห์)

ก่อนแตะ math หรือ ML theory แม้แต่นิดเดียว ให้เรียน Python ก่อน เป้าหมายไม่ใช่เป็น Python expert แต่คือ "อ่าน ML code ได้และเขียน script เล็กๆ ได้"

สิ่งที่ต้องรู้:
- Basic syntax, variables, loops, functions
- Data structures: lists, dictionaries, sets
- File handling
- Basic OOP (object-oriented programming)

```python
# เป้าหมาย: อ่าน code แบบนี้ได้และเข้าใจว่ามันทำอะไร
import pandas as pd
df = pd.read_csv("data.csv")
print(df.head())
print(df.describe())
```

### Step 2: Key Libraries (NumPy / Pandas / Matplotlib)

สาม library นี้คือ "เครื่องมือประจำวัน" ของ ML engineer ทุกคน:

| Library | ใช้ทำอะไร |
|---------|-----------|
| **NumPy** | Arrays, matrix operations, คณิตศาสตร์เชิงตัวเลข |
| **Pandas** | โหลด, จัดการ, transform ข้อมูลขนาดใหญ่ |
| **Matplotlib** | สร้างกราฟและ visualize ข้อมูล |

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# NumPy: matrix ops
A = np.array([[1, 2], [3, 4]])
B = np.dot(A, A.T)

# Pandas: data wrangling
df = pd.read_csv("housing.csv")
df_clean = df.dropna().reset_index(drop=True)

# Matplotlib: quick visualization
plt.scatter(df_clean["size"], df_clean["price"])
plt.xlabel("Size (sqft)")
plt.ylabel("Price ($)")
plt.show()
```

### Step 3: Essential Math (เท่าที่จำเป็น)

ไม่ต้องพิสูจน์สมการ — ต้องการความเข้าใจระดับ "conceptual" ใน 3 เรื่อง:

- **Linear Algebra**: Vectors, matrices, dot products — ใช้เข้าใจว่า data เป็น matrix และ neural network คำนวณอย่างไร
- **Probability & Statistics**: Distributions, Bayes' theorem, mean, variance — ใช้ในทุก ML algorithm
- **Calculus**: Derivatives, gradients, optimization — ใช้เข้าใจว่า model "เรียนรู้" อย่างไร (backpropagation)

> **ข้อแนะนำ**: เรียน math ควบคู่กับ implementation อย่าเรียน math แยกต่างหาก

### Step 4: Core ML Algorithms (Scikit-learn)

เน้นการเลือก model ให้ถูกกับปัญหา มากกว่าการท่องจำสมการ

**Supervised Learning**:
- Linear Regression, Logistic Regression
- Decision Trees, Random Forests
- SVM (Support Vector Machines)
- KNN (K-Nearest Neighbors)

**Unsupervised Learning**:
- K-Means Clustering
- PCA (Principal Component Analysis) — dimensionality reduction

**Model Evaluation**:
- Accuracy, Precision, Recall, F1
- Cross-validation

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import classification_report

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Cross-validation ดีกว่า single train/test split
cv_scores = cross_val_score(model, X, y, cv=5)
print(f"CV Accuracy: {cv_scores.mean():.3f} ± {cv_scores.std():.3f}")
print(classification_report(y_test, model.predict(X_test)))
```

Scikit-learn มี API ที่สะอาดและสม่ำเสมอ — ทุก model มี `.fit()`, `.predict()`, `.score()` เหมือนกัน ทำให้สลับ model ได้ง่าย

### Step 5: Deep Learning (PyTorch)

เมื่อเข้าใจ classical ML แล้ว ให้ต่อด้วย neural networks **ใช้ PyTorch ไม่ใช่ TensorFlow** — PyTorch ครอง research community และกำลัง dominate production มากขึ้นเรื่อยๆ

**Concepts พื้นฐาน**:
- Neurons, layers, activation functions
- Forward/backward pass, loss function, optimizer
- Backpropagation

**Architectures ที่ต้องรู้**:
- **Feedforward Neural Networks** — พื้นฐานของทุกอย่าง
- **CNN** — image classification (Computer Vision)
- **RNN / LSTM** — sequence data เช่น sentiment analysis
- **Transformers** — architecture ที่ขับเคลื่อน LLMs ทั้งหมด (ต้องเข้าใจ "attention")

```python
import torch
import torch.nn as nn
import torch.optim as optim

class SimpleNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.Sequential(
            nn.Linear(784, 128),
            nn.ReLU(),
            nn.Linear(128, 10)
        )

    def forward(self, x):
        return self.layers(x)

model = SimpleNet()
optimizer = optim.Adam(model.parameters(), lr=1e-3)
criterion = nn.CrossEntropyLoss()
```

ใช้ **Hugging Face** เพื่อหา pre-trained models สำหรับ fine-tuning — ไม่ต้อง train จาก scratch ทุกครั้ง

### Step 6: MLOps, Real Data, Cloud Deployment (ขั้นที่ทำให้หางานได้จริง)

นี่คือสิ่งที่ roadmap ส่วนใหญ่ข้ามไป แต่เป็นสิ่งที่ interviewer ถามมากที่สุด

**Real Data Skills**:
- ข้อมูลจริง 80% ของเวลา = clean ข้อมูลสกปรก, จัดการ missing values, feature engineering
- Kaggle datasets ≠ production data (Kaggle ถูกทำความสะอาดมาแล้ว)

**MLOps & Model Serving**:
- **Docker** — containerize model ให้ reproducible
- **FastAPI / Flask** — serve model เป็น REST API
- **MLflow / Weights & Biases** — track experiments, version models
- **CI/CD pipelines** — automate testing และ deployment

**Cloud Platforms** (เลือกอย่างน้อยหนึ่ง):

| Cloud | ML Service |
|-------|-----------|
| **AWS** (recommended) | SageMaker |
| **GCP** | Vertex AI |
| **Azure** | Azure ML |

```python
# FastAPI model serving — minimal production-ready setup
from fastapi import FastAPI
import joblib
import numpy as np

app = FastAPI()
model = joblib.load("model.pkl")

@app.post("/predict")
def predict(features: list[float]):
    X = np.array(features).reshape(1, -1)
    prediction = model.predict(X)
    return {"prediction": int(prediction[0])}
```

### Learn in Public: สร้างโปรไฟล์ที่ Recruiter หา

ML recruiters จ้างคนจากโปรเจกต์ที่ทำได้จริง ไม่ใช่ใบ certificate

**วิธีการ**:
- **GitHub**: push ทุก project — สำคัญกว่า LinkedIn
- **LinkedIn**: เขียนสั้นๆ เกี่ยวกับสิ่งที่กำลังเรียน ปัญหาที่เจอ และวิธีแก้
- **End-to-end projects**: ต้องครบ data collection → EDA → modeling → deployment — ไม่ใช่แค่ Kaggle notebook ที่หยุดตอน accuracy ดีขึ้น

> "Continuously sharing your progress shows you are active, adaptive, and keeping up to date with the industry"

### Timeline: Job-Ready ใน 6-9 เดือน

| เดือน | เป้าหมาย |
|-------|----------|
| 1 | Python + Libraries (NumPy / Pandas / Matplotlib) |
| 2 | Essential Math + Core ML Algorithms |
| 3-4 | Projects ด้วย Scikit-learn + เริ่ม Deep Learning |
| 5-6 | PyTorch projects + MLOps basics |
| 7-9 | Cloud deployment + Build portfolio + Apply jobs |

## User Guide (Step-by-Step)

### เริ่มต้นวันนี้: Week 1 Checklist

**Day 1-3: Setup สภาพแวดล้อม**

```bash
pip install numpy pandas matplotlib scikit-learn torch jupyter
pip install fastapi uvicorn mlflow

mkdir ml-learning && cd ml-learning
git init
```

**Day 4-7: First Mini-Project (ทำตาม 70/30)**

เลือก dataset จาก Kaggle (แนะนำ: Titanic หรือ House Prices)

```python
# week1_project.py — ลงมือทำก่อน อ่าน theory ทีหลัง
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

df = pd.read_csv("train.csv")

# ตรงนี้จะเจอปัญหา missing values — นั่นแหละคือ 30% ที่ควรเรียน theory
df["Age"].fillna(df["Age"].median(), inplace=True)
df = pd.get_dummies(df, columns=["Sex", "Pclass"])

features = [c for c in df.columns if c not in ["Survived", "Name", "Ticket", "Cabin"]]
X, y = df[features], df["Survived"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = RandomForestClassifier()
model.fit(X_train, y_train)
print(f"Accuracy: {model.score(X_test, y_test):.3f}")
```

**DataCamp Tracks** (สำหรับ structured learning):
- *Machine Learning Scientist with Python* — covers full pipeline
- *Machine Learning Engineer* — MLOps focus

## Caveats / Limits

**กับดักที่ต้องระวัง**:
- **Tutorial hopping**: อย่าเปลี่ยน course บ่อย ให้จบ project หนึ่งก่อนไปต่อ
- **Math paralysis**: ไม่ต้องเข้าใจ math 100% ก่อนเริ่ม ทำโปรเจกต์ได้เลย
- **Kaggle trap**: Kaggle data สะอาดเกินจริง ฝึก real data ด้วย
- **TensorFlow vs PyTorch**: PyTorch dominate ทั้ง research และ production ในปัจจุบัน

**Timeline ที่จริงจัง**:
- 6-9 เดือน assumes การเรียน consistently (ไม่ใช่ on-and-off)
- Part-time (weekends only) → คูณเวลาด้วย 2-3

**MLOps complexity**: Docker + Cloud + CI/CD มี learning curve สูง — รู้ basics + มี project จริงก็ผ่าน interview ได้

## References

1. "How to learn Machine Learning like a GENIUS and not waste time" — YouTube: https://youtu.be/_hdUddANh_o
2. roadmap.sh Machine Learning Roadmap: https://roadmap.sh/machine-learning
3. Machine Learning Mastery: The Roadmap for Mastering Machine Learning in 2025: https://machinelearningmastery.com/roadmap-mastering-machine-learning-2025/
4. DataCamp Machine Learning Scientist with Python Track: https://www.datacamp.com/tracks/machine-learning-scientist-with-python
5. Scikit-learn Official Documentation: https://scikit-learn.org/stable/
6. PyTorch Official Documentation: https://pytorch.org/docs/stable/index.html
7. Hugging Face — Pre-trained Models Hub: https://huggingface.co/models
8. MLflow Documentation: https://mlflow.org/docs/latest/index.html
9. Weights & Biases (W&B) Documentation: https://docs.wandb.ai/

## Key Takeaways

- **กฎ 70/30**: เขียน code 70%, ดูคอร์ส/อ่านทฤษฎี 30% — ไม่ใช่กลับกัน
- Python + NumPy/Pandas/Matplotlib คือรากฐานที่ต้องแน่น ก่อนแตะ ML algorithm ใดๆ
- Math เพียง conceptual level — ไม่ต้องพิสูจน์ทุกสมการ
- **PyTorch > TensorFlow** สำหรับ Deep Learning ในปัจจุบัน (dominate research + production)
- MLOps, real data handling, Cloud deployment คือสิ่งที่ทำให้หางานได้จริง — อย่าข้ามขั้นนี้
- **Learn in Public**: push ทุก project ขึ้น GitHub, เขียน LinkedIn post สั้นๆ — recruiter ดูโปรเจกต์ ไม่ดู certificate
- End-to-end projects (data → model → deployment) มีค่ามากกว่า 10 Kaggle notebooks
