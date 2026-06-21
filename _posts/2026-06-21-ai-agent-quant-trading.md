---
title: "AI Agent กับการพัฒนาระบบ Quant Trading: เวิร์กโฟลว์ที่เป็นระบบ"
date: 2026-06-20 00:04:00 +0700
categories: [Engineering]
tags: [quant-trading, ai-agent, python, backtesting, alpaca, jupyter, optuna]
---

## TL;DR

การใช้ AI Agent พัฒนาระบบ Quant Trading ไม่ใช่การพิมพ์ prompt แล้วได้กำไร แต่คือ **เวิร์กโฟลว์ 6 ขั้นตอน** ตั้งแต่ค้นคว้างานวิจัย → prototype ใน Jupyter → แปลงเป็น production CLI → backtest ด้วย synthetic data → optimize hyperparameters → ส่งสัญญาณไปโบรกเกอร์จริง (Alpaca) โดย AI ช่วยมอนิเตอร์ความเสี่ยงแบบ asynchronous ไม่ใช่เทรดแทนทั้งหมด

## Background / Why this matters

หลายคนเห็น demo บน YouTube ที่ "AI เทรดหุ้นทำกำไร" แล้วพยายามลอกด้วยการใส่ prompt สั้นๆ ว่า "build me a profitable trading bot" — แน่นอนว่ามันไม่ work

เหตุผลหลักคือ **ตลาดการเงินเป็น adaptive complex system** ที่กลยุทธ์ที่ work ในอดีตจะ degrade เมื่อคนอื่นรู้และ front-run มัน การพัฒนาระบบเทรดที่ทนทานจึงต้องมีกระบวนการวิจัย วิทยาศาสตร์ และ engineering ที่เป็นระบบ

AI Agent เปลี่ยนเกมไม่ใช่ด้วยการ "เทรดแทน" แต่ด้วยการ **ช่วยเร่งทุกขั้นตอนของ pipeline** ตั้งแต่ literature review ที่เคยใช้เวลาสัปดาห์ ให้เหลือชั่วโมง ไปจนถึงการ optimize parameter หลายพันชุดโดยอัตโนมัติ

## Deep Dive

### Phase 1: Research — ค้นคว้าวิชาการด้วย AI Agent

จุดเริ่มต้นคือ **ไอเดียกลยุทธ์** เช่น "volatility contraction filter ร่วมกับ momentum trading" จากนั้นต้องหาว่าวิชาการรองรับไอเดียนี้อยู่ไหม

เดิมต้องอ่าน paper เองบน arXiv ทีละชิ้น แต่ด้วย AI Agent เวิร์กโฟลว์กลายเป็น:

```
ไอเดียกลยุทธ์
  → Anti Gravity + Gemini/Opus/Sonnet
  → skill: Literature Search Archive (ค้น arXiv ด้วย keyword)
  → skill: digest research paper (ดาวน์โหลด PDF, สรุป concept + methodology)
  → บันทึกเป็น Markdown ไฟล์ใน Obsidian (LM Wiki)
```

**Anti Gravity** คือ software สำหรับรัน AI Agent workflows แบบ local โดยใช้ skill เฉพาะทาง เช่น `Literature Search Archive` ที่ค้น paper จาก arXiv แล้วส่งต่อให้ `digest research paper` แปลง PDF เป็นสรุปที่มี: แนวคิดหลัก, ไลบรารีที่ใช้, methodology, และ gotchas

ผลลัพธ์คือ **LM Wiki** — คลังความรู้ส่วนตัวใน Obsidian ที่ AI สามารถ query ได้ในขั้นตอนถัดไป

> **สำคัญ:** อย่าคาดหวังให้ AI คิดกลยุทธ์จากศูนย์ ต้องให้ context และไอเดียเริ่มต้นก่อนเสมอ — AI คือ research assistant ไม่ใช่ oracle

### Phase 2: Prototype — พัฒนาบน Jupyter Notebook

เมื่อมีไอเดียที่ backed by research แล้ว ให้นำมา implement บน **Jupyter Notebook** ก่อน เหตุผลคือ Notebook ให้ทดสอบ component ทีละชิ้นโดยไม่ต้องรันทั้ง codebase

ไลบรารีหลักที่ใช้:

| ไลบรารี | หน้าที่ |
|---------|---------|
| **Pandas** | data manipulation, time series processing |
| **TA-Lib** | คำนวณ technical indicators (RSI, Bollinger Bands, ATR) |
| **OpenBB** | platform สำหรับดึงข้อมูลตลาดหลายแหล่ง |
| **VectorBT** | vectorized backtesting — เร็วกว่า event-driven backtest หลายสิบเท่า |

ขั้นตอนใน Notebook:
1. ดึงข้อมูล OHLCV จาก data source
2. คำนวณ signals จาก indicators
3. implement money management เบื้องต้น (position sizing, stop-loss)
4. run quick backtest ดู equity curve

AI ช่วย generate boilerplate code, แนะนำ library usage, และ debug error message — แต่ logic ของ signal generation ต้องมาจากความเข้าใจของเรา

### Phase 3: Production Conversion — แปลงโค้ดเป็นระบบ CLI

เมื่อ prototype ผ่านการทดสอบเบื้องต้น ให้ใช้ AI Agent แปลง Notebook เป็น **Python files แบบ production** ที่รันผ่าน CLI

AI จะแยกโค้ดออกเป็น **3 modules ที่ชัดเจน:**

```
trading_system/
├── backtest.py      # รัน backtest ด้วย parameter ที่กำหนด
├── optimize.py      # hyperparameter search (Optuna / Grid Search)
└── trade.py         # เชื่อม broker API, ส่ง order จริง
```

ทำไมต้อง CLI? เพราะ AI Agent ทำงานผ่าน text-based interface — การส่ง parameter ผ่าน CLI argument ง่ายกว่าและประหยัด token กว่าการให้ AI execute Python code โดยตรง:

```bash
# AI Agent สั่งได้แบบนี้
python backtest.py --symbol AAPL --period 200 --stop-loss 0.02

# แทนที่จะต้องโหลด Jupyter kernel ทั้งหมด
```

> **Why it matters:** CLI = fast + low memory + ประหยัด LLM token cost อย่างมีนัยสำคัญ

### Phase 4: Synthetic Data & Backtesting — ทดสอบด้วยข้อมูลจำลอง

ปัญหาของ historical backtest คือ **data snooping bias** — ถ้า backtest 100 ครั้งจนได้ผลดี มันคือการ overfit กับประวัติศาสตร์ ไม่ใช่ robust strategy

แนวทางแก้: ใช้ **synthetic data** เพิ่มเติม

AI ช่วย generate synthetic price data โดยใช้:
- **Geometric Brownian Motion (GBM)** — simulate random walk ที่มี drift
- **Stochastic volatility models** — capture volatility clustering
- ปรับ target volatility / returns / correlation ตามที่ต้องการ stress test

```python
# ตัวอย่าง: generate synthetic data ด้วย GBM
import numpy as np

def generate_gbm(S0, mu, sigma, T, dt, n_paths):
    """Geometric Brownian Motion path simulation"""
    n_steps = int(T / dt)
    paths = np.zeros((n_paths, n_steps))
    paths[:, 0] = S0
    for t in range(1, n_steps):
        z = np.random.standard_normal(n_paths)
        paths[:, t] = paths[:, t-1] * np.exp(
            (mu - 0.5 * sigma**2) * dt + sigma * np.sqrt(dt) * z
        )
    return paths
```

Data sources สำหรับ historical data:
- **Financial Modeling Prep (FMP)** — pre-cleaned, paid tier
- **Yahoo Finance** — ฟรี แต่ต้องระวัง data quality
- **Alpaca Market Data API** — ฟรี (IEX feed), historical OHLCV 2+ ปี

### Phase 5: Hyperparameter Optimization — คัดกลยุทธ์ที่ทนทาน

เมื่อมี backtest engine และ synthetic data แล้ว ให้ใช้ AI Agent รัน **hyperparameter optimization (HPO)** อัตโนมัติ

เครื่องมือที่ใช้:

**Optuna** — framework สำหรับ HPO ที่ใช้ Bayesian optimization แทน brute-force Grid Search:

```python
import optuna

def objective(trial):
    # Parameters ที่ต้อง optimize
    bb_period = trial.suggest_int("bb_period", 10, 50)
    bb_std = trial.suggest_float("bb_std", 1.5, 3.0)
    stop_loss = trial.suggest_float("stop_loss", 0.01, 0.05)
    take_profit = trial.suggest_float("take_profit", 0.02, 0.10)
    
    # รัน backtest และ return metric
    result = run_backtest(bb_period, bb_std, stop_loss, take_profit)
    return result["sharpe_ratio"]

study = optuna.create_study(direction="maximize")
study.optimize(objective, n_trials=500)
```

**สิ่งที่ควร optimize:**
- Money management parameters (position size, stop-loss, take-profit) — **สำคัญกว่า indicator parameters**
- Indicator periods และ thresholds
- Risk rules เช่น max drawdown limit, daily loss limit

**Walk-Forward Analysis** — validation ที่สำคัญที่สุด: แบ่งข้อมูลเป็น rolling windows, optimize บน in-sample, ทดสอบบน out-of-sample ที่ไม่เคยเห็น ถ้า performance ทรุดอย่างหนักบน out-of-sample = overfit

### Phase 6: Broker API Integration — ส่งสัญญาณไปโบรกเกอร์

เมื่อ parameters ผ่าน Walk-Forward Analysis แล้ว นำไปใส่ใน `trade.py` ที่เชื่อมกับ broker API

**Alpaca** เป็นตัวเลือกแรกสำหรับ developer เพราะ:

```python
from alpaca.trading.client import TradingClient
from alpaca.trading.requests import MarketOrderRequest
from alpaca.trading.enums import OrderSide, TimeInForce

# Paper Trading (ทดสอบด้วยเงินสมมติ, real-time data)
client = TradingClient(api_key, secret_key, paper=True)

def send_signal(symbol: str, side: str, qty: int):
    order = MarketOrderRequest(
        symbol=symbol,
        qty=qty,
        side=OrderSide.BUY if side == "buy" else OrderSide.SELL,
        time_in_force=TimeInForce.DAY
    )
    return client.submit_order(order)
```

**Paper Trading** บน Alpaca ใช้ endpoint เดียวกับ live trading เปลี่ยนแค่ flag `paper=True` — ทำให้ forward test ด้วย real-time data โดยไม่เสี่ยงเงินจริง

### Phase 7: AI Monitoring — ตรวจสอบและปรับความเสี่ยง

**สำคัญมาก:** ไม่ควรให้ AI Agent รัน 24/7 เพื่อ monitor และตัดสินใจแบบ real-time เพราะ API token cost จะแพงมาก

Pattern ที่ถูกต้องคือ **asynchronous monitoring:**

```
traditional algorithm รัน trade loop บน server (ไม่ใช้ LLM)
  ↓ บันทึก trade log ทุกครั้ง
AI Agent ตรวจสอบ log เป็น batch (เช่น ทุกชั่วโมง หรือ end-of-day)
  → วิเคราะห์ pattern ของ losses
  → ตรวจจับ regime shift
  → แนะนำปรับ risk policy (เช่น ลด position size, หยุดเทรด sector ที่ขาดทุนต่อเนื่อง)
  → ส่ง notification (Discord, Telegram)
```

AI ทำหน้าที่เป็น **risk manager** ไม่ใช่ trader:
- วิเคราะห์ว่า drawdown เกิดจาก noise หรือ strategy breakdown
- ตรวจสอบว่า volatility regime เปลี่ยนหรือไม่
- แนะนำ parameter adjustment — แต่ human approve ก่อน execute เสมอ

## User Guide (Step-by-Step)

### Setup เบื้องต้น

**1. ติดตั้ง environment:**

```bash
# สร้าง virtual environment
python -m venv quant-env
source quant-env/bin/activate  # หรือ quant-env\Scripts\activate บน Windows

# ติดตั้ง dependencies
pip install pandas ta-lib openbb vectorbt optuna alpaca-py jupyter
```

**2. สมัคร Alpaca account:**
- ไปที่ [alpaca.markets](https://alpaca.markets/) → สมัครฟรี
- ไปที่ Paper Trading dashboard → สร้าง API key
- ตั้งค่า: `API_KEY`, `API_SECRET` ใน environment variables

**3. เริ่ม Jupyter:**

```bash
jupyter notebook
# สร้าง notebook ใหม่ strategy_prototype.ipynb
```

### Workflow ย่อ (Daily Practice)

1. **เช้า:** Review trade log จากคืนที่ผ่านมา ด้วย AI: `"analyze losses in today's log and summarize pattern"`
2. **กลางวัน:** ถ้า drawdown เกิน threshold → AI วิเคราะห์ว่า pause หรือ continue
3. **เย็น:** รัน HPO รอบสัปดาห์บน synthetic data ใหม่
4. **สัปดาห์ละครั้ง:** Walk-Forward Analysis เปรียบเทียบ in-sample vs out-of-sample performance

## Caveats / Limits

- **Overfitting risk สูง:** backtest ที่ดีไม่รับประกัน live performance — Walk-Forward Analysis บังคับ
- **Data quality:** Yahoo Finance มี errors และ survivorship bias; production ควรใช้ clean data source
- **Latency:** Alpaca IEX feed มี delay ~15 นาที สำหรับ real-time data ต้องใช้ feed แบบ pay
- **API rate limits:** Alpaca Paper Trading มี limit — ระวัง retry logic ใน production code
- **Regime change:** กลยุทธ์ที่ผ่าน backtest ดีอาจ fail ถ้า market regime เปลี่ยน (เช่น จาก trending เป็น ranging)
- **Cost of AI monitoring:** Token cost สำหรับ real-time AI monitoring แพงมาก — ใช้ batch/async pattern เสมอ
- **ไม่ใช่ "set and forget":** ระบบต้องการ human oversight สม่ำเสมอ โดยเฉพาะช่วง high volatility

## References

1. [AI Agent สำหรับการพัฒนาระบบเทรด (Quant Trading System) — YouTube](https://youtu.be/9u_YmHLNyhM)
2. [FinRL-X: An AI-Native Modular Infrastructure for Quantitative Trading (arXiv 2603.21330)](https://arxiv.org/abs/2603.21330)
3. [Agentic AI Portfolio Manager: Multi-Agent Trading Bot with Alpaca — QuantInsti](https://www.quantinsti.com/articles/agentic-ai-portfolio-manager-alpaca-trading-bot/)
4. [Alpaca-py SDK Documentation](https://alpaca.markets/sdks/python/)
5. [From Value Investing to Systematic Trading with AI and Alpaca](https://alpaca.markets/learn/from-value-investing-to-systematic-trading-building-a-multi-strategy-backtesting-dashboard-with-ai-and-alpaca)
6. [Optuna — A hyperparameter optimization framework](https://optuna.org/)
7. [VectorBT — Backtesting library](https://vectorbt.dev/)
8. [OpenBB Platform — Financial data](https://openbb.co/)
9. [Best AI Trading Platforms 2026 — LiquidityFinder](https://liquidityfinder.com/insight/technology/best-ai-platforms-for-trading-and-analytics)

## Key Takeaways

- AI Agent เร่งทุกขั้นตอนของ pipeline แต่ **ไม่ใช่ magic wand** — ยังต้องมีไอเดียกลยุทธ์และ domain knowledge
- แยก code เป็น 3 modules (Backtest / Optimize / Trade) และรันผ่าน CLI ลด token cost และเพิ่มความเร็ว
- Synthetic data + Walk-Forward Analysis คือเกราะป้องกัน overfitting ที่ effective ที่สุด
- Optuna ดีกว่า Grid Search สำหรับ parameter space ขนาดใหญ่ เพราะ Bayesian search เจอ optimum เร็วกว่า
- Alpaca Paper Trading ใช้ endpoint เดียวกับ live — forward test ได้โดยไม่เสี่ยงเงินจริง
- AI monitoring ต้องเป็น async/batch ไม่ใช่ real-time loop — ประหยัด cost และลด hallucination risk
- กลยุทธ์ที่ดีต้อง robust ต่อ regime change ไม่ใช่แค่ดูดีใน backtest
