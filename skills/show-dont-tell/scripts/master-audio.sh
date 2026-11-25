#!/usr/bin/env bash
# Normalize a finished video's audio to web loudness (-14 LUFS, -1 dBTP) in two passes,
# copying the video stream untouched. Input: a finished MP4 or MOV (H.264 or HEVC).
# Usage: master-audio.sh input.mp4 [output.mp4] [target-LUFS]
set -euo pipefail
in="${1:?usage: master-audio.sh input.mp4 [output.mp4] [target-LUFS]}"
out="${2:-${in%.*}-mastered.mp4}"
I="${3:--14}"
if [ "$in" = "$out" ] || { [ -e "$out" ] && [ "$in" -ef "$out" ]; }; then
  echo "Output must be a different file from the input." >&2; exit 1
fi
if [ -z "$(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$in")" ]; then
  echo "$in has no audio track; nothing to master." >&2; exit 1
fi
json=$(ffmpeg -hide_banner -i "$in" -af "loudnorm=I=${I}:TP=-1:LRA=11:print_format=json" -f null - 2>&1 | sed -n '/^{/,/^}/p')
read -r mi mtp mlra mth off < <(echo "$json" | python3 -c "import sys, json; d = json.load(sys.stdin); print(d['input_i'], d['input_tp'], d['input_lra'], d['input_thresh'], d['target_offset'])")
if [ "$mi" = "-inf" ]; then
  echo "$in is silent; nothing to master." >&2; exit 1
fi
ffmpeg -v error -y -i "$in" -c:v copy \
  -af "loudnorm=I=${I}:TP=-1:LRA=11:measured_I=${mi}:measured_TP=${mtp}:measured_LRA=${mlra}:measured_thresh=${mth}:offset=${off}:linear=true" \
  -c:a aac -b:a 192k -ar 48000 -movflags +faststart "$out"
echo "$out (was ${mi} LUFS, target ${I})"
