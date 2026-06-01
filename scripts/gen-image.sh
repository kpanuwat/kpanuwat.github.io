#!/usr/bin/env bash
# gen-image.sh — agy -p image generation wrapper for knowledge-hub
#
# Usage: gen-image.sh <abs-output-path> <prompt> [--type hero|cheatsheet|diagram] [--timeout <secs>]
#
# Absorbs agy agent quirks:
#   - Output path: model writes to scratch dir OR Obsidian vault depending on mode.
#     We use find -newer a sentinel file to locate the image wherever it lands.
#   - Shell cwd: resets after each run — all paths here are absolute.
#   - Format: model may emit JPEG with .png extension; we accept image/* and copy as-is.
#
# Exit 0 on success (image verified at <abs-output-path>); non-zero on failure.
# Callers should fall back to notebooklm then inline SVG on non-zero.
#
# Env override: AGY_SEARCH_DIRS="dir1:dir2" (colon-separated, default covers scratch + Obsidian)

set -euo pipefail

OUTPUT_PATH="${1:?Usage: gen-image.sh <abs-output-path> <prompt> [--type hero|cheatsheet|diagram] [--timeout secs]}"
PROMPT="${2:?prompt required}"
TYPE="cheatsheet"
TIMEOUT=300

shift 2
while [[ $# -gt 0 ]]; do
  case "$1" in
    --type) TYPE="$2"; shift 2 ;;
    --timeout) TIMEOUT="$2"; shift 2 ;;
    *) echo "gen-image: unknown flag: $1" >&2; exit 1 ;;
  esac
done

# Dirs agy may write images to (scratch + Obsidian vault are observed locations)
IFS=':' read -ra SEARCH_DIRS <<< "${AGY_SEARCH_DIRS:-$HOME/.gemini/antigravity-cli/scratch:$HOME/Obsidian-Gemini-Vault}"
for d in "${SEARCH_DIRS[@]}"; do mkdir -p "$d"; done

case "$TYPE" in
  hero)
    PREFIX="Use native AI image generation (nano-banana / Imagen). Photorealistic or stylized illustration, high detail."
    ;;
  cheatsheet)
    PREFIX="Use native AI image generation (nano-banana). Sketch-note infographic style. Legible stylized text labels. 2-3 accent colours on white/light background. Dense but scannable."
    ;;
  diagram)
    PREFIX="Draw programmatically using Python with Pillow or matplotlib. Clean flat vector-style chart. No photo realism."
    ;;
  *)
    echo "gen-image: unknown --type '$TYPE' (must be hero|cheatsheet|diagram)" >&2; exit 1 ;;
esac

FULL_PROMPT="${PREFIX} ${PROMPT}. Save the result as a single image file (PNG preferred)."

# Sentinel file: any image newer than this was created by the agy run below
SENTINEL=$(mktemp)
trap 'rm -f "$SENTINEL"' EXIT

# Run agy
set +e
timeout "$TIMEOUT" agy -p "$FULL_PROMPT"
AGY_EXIT=$?
set -e

# Locate newest image (png or jpg/jpeg) created after the sentinel in all search dirs
FOUND=""
for d in "${SEARCH_DIRS[@]}"; do
  CANDIDATE=$(find "$d" -maxdepth 3 -newer "$SENTINEL" \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) \
    -type f 2>/dev/null | xargs -I{} ls -t {} 2>/dev/null | head -1 || true)
  if [[ -n "$CANDIDATE" ]]; then
    FOUND="$CANDIDATE"
    break
  fi
done

if [[ -z "$FOUND" ]]; then
  echo "gen-image: no image found in search dirs after agy run (exit=$AGY_EXIT)" >&2
  echo "gen-image: searched: ${SEARCH_DIRS[*]}" >&2
  exit 1
fi

# Verify it's a real image file (PNG or JPEG) and non-trivial (> 1 KB)
FTYPE=$(file --brief "$FOUND" 2>/dev/null || true)
FSIZE=$(stat -c%s "$FOUND" 2>/dev/null || echo 0)

if [[ "$FTYPE" != PNG* && "$FTYPE" != JPEG* ]]; then
  echo "gen-image: unexpected file type '$FTYPE' at $FOUND" >&2
  exit 1
fi
if [[ "$FSIZE" -lt 1024 ]]; then
  echo "gen-image: file too small ($FSIZE bytes) — likely empty" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"
mv "$FOUND" "$OUTPUT_PATH"

echo "$OUTPUT_PATH"
