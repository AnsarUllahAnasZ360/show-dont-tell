#!/usr/bin/env bash
# Make a contact sheet (a grid of evenly spaced frames) from a video, for review.
# Usage: contact-sheet.sh input.mp4 [output.png] [columns] [rows] [tile-width]
# Example: contact-sheet.sh out/video.mp4 review.png 6 5 480
# Works on MP4 and on WebM screen recordings (which often report no duration).
set -euo pipefail
in="${1:?usage: contact-sheet.sh input.mp4 [output.png] [cols] [rows] [tile-width]}"
out="${2:-${in%.*}-sheet.png}"
cols="${3:-5}"; rows="${4:-4}"; tw="${5:-480}"
dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$in" || true)
if ! [[ "$dur" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  # No duration in the header: decode once and read the last timestamp.
  dur=$(ffmpeg -hide_banner -i "$in" -map 0:v:0 -f null - 2>&1 | grep -oE 'time=[0-9:.]+' | tail -1 | cut -d= -f2 | awk -F: '{ print $1 * 3600 + $2 * 60 + $3 }')
fi
n=$((cols * rows))
# One frame per (duration / n) seconds; each tile shows a frame from the end of its slot.
fps=$(awk -v n="$n" -v d="$dur" 'BEGIN { printf "%.6f", n / d }')
label=""
filters=$(ffmpeg -hide_banner -filters 2>/dev/null || true)
if [[ "$filters" == *" drawtext "* ]]; then
  label=",drawtext=text='%{pts\\:hms}':x=8:y=8:fontsize=18:fontcolor=white:box=1:boxcolor=black@0.6:boxborderw=4"
fi
ffmpeg -v error -y -i "$in" -vf "fps=${fps},scale=${tw}:-1${label},tile=${cols}x${rows}:padding=6:margin=6:color=0x111111" -frames:v 1 "$out"
echo "$out"
