#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Script: screencast-prep
# Phase: video-processing
# Requires: ffmpeg, ffprobe, bc
# Behavior: Compress + speed up screencast for publishing (no audio)
# -----------------------------------------------------------------------------

INPUT="$1"

if [ -z "$INPUT" ]; then
  echo "❌ Usage: screencast-prep <video-file>"
  exit 1
fi

# -------------------------------
# 📁 Output Setup
# -------------------------------

OUTPUT_DIR="$HOME/Videos/Processed"
mkdir -p "$OUTPUT_DIR"

BASENAME=$(basename "${INPUT%.*}")
DATE=$(date +%Y-%m-%d)

OUTPUT="$OUTPUT_DIR/${BASENAME}-${DATE}-compressed.mp4"

# -------------------------------
# ⏱ Duration + Speed Logic
# -------------------------------

DURATION=$(ffprobe -v error -show_entries format=duration \
-of default=noprint_wrappers=1:nokey=1 "$INPUT")

DURATION=${DURATION%.*}

TARGET=900  # 15 minutes

if [ "$DURATION" -le 1800 ]; then
  SPEED=2
else
  SPEED=$(echo "scale=2; $DURATION / $TARGET" | bc)
fi

echo "⏱ Duration: $DURATION seconds"
echo "⚡ Speed factor: $SPEED"

# -------------------------------
# 🎥 FFmpeg Processing (NO AUDIO)
# -------------------------------

ffmpeg -i "$INPUT" \
-filter:v "setpts=PTS/$SPEED" \
-an \
-c:v libx264 -preset fast -crf 23 \
-movflags +faststart \
"$OUTPUT"

echo "✅ Done!"
echo "📁 Output: $OUTPUT"