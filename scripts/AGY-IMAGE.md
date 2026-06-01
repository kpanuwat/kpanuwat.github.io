# agy Image Generation — knowledge-hub Reference

`gen-image.sh` is the hub's wrapper for `agy -p` (Google Antigravity CLI → nano-banana / Gemini image generation).
All three skills (knowledge-hub-html, knowledge-hub, marp-deck) call this script instead of `notebooklm generate infographic`.

## Usage

```bash
scripts/gen-image.sh <abs-output-path> "<prompt>" [--type hero|cheatsheet|diagram] [--timeout <secs>]
```

| Flag | Default | Purpose |
|------|---------|---------|
| `--type hero` | — | Native AI: photorealistic / stylized illustration |
| `--type cheatsheet` | **default** | Native AI: sketch-note infographic, legible in-image text |
| `--type diagram` | — | Programmatic: Pillow/matplotlib, clean flat chart |
| `--timeout <secs>` | 300 | Kill if agy hangs |
| `AGY_SCRATCH_DIR=<path>` | `~/.gemini/antigravity-cli/scratch` | Override scratch dir (testing/fallback) |

Exit 0 + prints path on success. Non-zero on failure → caller falls back to NotebookLM then inline SVG.

## Examples

```bash
# Post hero image
scripts/gen-image.sh ~/dev/knowledge-hub/assets/images/mqtt-guide.png \
  "MQTT protocol concept art, IoT devices connected to a central broker, circuit-board aesthetic" \
  --type hero

# Explainer cheat-sheet
scripts/gen-image.sh ~/dev/knowledge-hub/explainers/assets/mqtt-basics/cheatsheet.png \
  "MQTT pub/sub cheat sheet: broker, publisher, subscriber, QoS levels, topic wildcards, retain flag" \
  --type cheatsheet

# Slide infographic
scripts/gen-image.sh ~/dev/knowledge-hub/_slides/assets/esp32-power-modes-1.png \
  "bar chart comparing ESP32 power draw: active 240mA, modem-sleep 15mA, light-sleep 0.8mA, deep-sleep 10uA" \
  --type diagram
```

## Fallback chain

```
agy (gen-image.sh)
  └─ exit 0 → use PNG
  └─ exit non-zero → notebooklm generate infographic
       └─ success → download + use PNG
       └─ fail / auth error → inline SVG cheat-sheet
```

---

## Top 10 Nano Banana (Gemini Image) use cases for knowledge-hub

nano-banana = Gemini 2.5/3 Flash Image. Runs locally via `agy -p`. No credit limit (model subscription), no PII sent to external indexing services.

| # | Use case | --type | Prompt pattern |
|---|----------|--------|---------------|
| 1 | **Post hero / cover illustration** | `hero` | `"[topic] concept art, [aesthetic], high detail"` |
| 2 | **Cheat-sheet infographic** | `cheatsheet` | `"[topic] cheat sheet: [key concepts, DO/DON'T, 3-5 stats]"` |
| 3 | **Educational concept visualization** | `hero` | `"3D/cinematic explainer of [complex mechanism], labelled diagram style"` |
| 4 | **Architecture / flow diagram with text** | `cheatsheet` | `"[system] architecture diagram: [components], arrows, legible labels"` — nano-banana renders in-image text well |
| 5 | **Storyboard / step-sequence** | `hero` | `"[n]-panel storyboard: step 1 ... step n, consistent style"` |
| 6 | **Brand-consistent icon/banner set** | `cheatsheet` | `"[n] icons for [topic], consistent flat design, [palette]"` |
| 7 | **Conversational iteration** | any | Call agy interactively (`-i`) to refine via follow-up prompts |
| 8 | **Product-shot enhancement** | `hero` | `"[product] on [clean background], [lighting], lifestyle photo style"` |
| 9 | **Multi-image style transfer** | `hero` | `"image in the style of [reference description], [topic]"` |
| 10 | **Real-data imagery with Search grounding** | `cheatsheet` | `"infographic of [stat/fact] — use current data, cite sources in caption"` |

Sources:
- [Google AI image-generation docs](https://ai.google.dev/gemini-api/docs/image-generation)
- [Nano Banana use cases — imagine.art](https://www.imagine.art/blogs/nano-banana-use-cases-and-creative-possibilities)
- [Ultimate prompting guide — Google Cloud](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)
- [Gemini Image — Google DeepMind](https://deepmind.google/models/gemini-image/)
