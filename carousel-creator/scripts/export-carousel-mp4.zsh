#!/bin/zsh
set -euo pipefail

if ! command -v magick >/dev/null 2>&1; then
  print "Error: ImageMagick 'magick' is not installed or not in PATH." >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  print "Error: ffmpeg is not installed or not in PATH." >&2
  exit 1
fi

script_dir="${0:a:h}"
music_file="$script_dir/youtube-shorts-bt-music.mp3"

typeset -A opts
zparseopts -D -E -A opts -- -no-music || true
_no_music=""
(( ${+opts[--no-music]} )) && _no_music="yes"

if [[ -z "$_no_music" && ! -f "$music_file" ]]; then
  print "Error: music file not found: $music_file" >&2
  print "       Pass --no-music to skip background music, or restore the file." >&2
  exit 1
fi

if [[ $# -lt 1 || $# -gt 3 ]]; then
  print "Usage: ./export-carousel-mp4.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [OUTPUT_MP4] [--no-music]" >&2
  print "Example: ./export-carousel-mp4.zsh 20260515-141152 2.5" >&2
  print "Options:" >&2
  print "  --no-music    Skip background music in the output MP4" >&2
  exit 1
fi

carousel_dir="${1:A}"
seconds_per_slide="${2:-2.5}"
output_mp4="${3:-$carousel_dir/carousel.mp4}"
slides_dir="$carousel_dir/slides"

if [[ ! -d "$slides_dir" ]]; then
  print "Error: slides folder not found: $slides_dir" >&2
  exit 1
fi

slides=("$slides_dir"/*slide-<->.svg(Nn))

if [[ ${#slides[@]} -eq 0 ]]; then
  print "Error: no numbered SVG slides found in: $slides_dir" >&2
  exit 1
fi

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/carousel-mp4.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

concat_file="$tmp_dir/slides.txt"
: > "$concat_file"

index=1
last_png=""
for slide in "${slides[@]}"; do
  png="$tmp_dir/slide-$(printf '%03d' "$index").png"
  magick -density 144 "$slide" -resize 1080x1350! -background white -alpha remove -alpha off "$png"
  print "file '$png'" >> "$concat_file"
  print "duration $seconds_per_slide" >> "$concat_file"
  last_png="$png"
  (( index++ ))
done

print "file '$last_png'" >> "$concat_file"

ffmpeg -y \
  -f concat \
  -safe 0 \
  -i "$concat_file" \
  -vf "fps=30,format=yuv420p" \
  -c:v libx264 \
  -movflags +faststart \
  "$tmp_dir/video.mp4"

if [[ -n "$_no_music" ]]; then
  mv "$tmp_dir/video.mp4" "$output_mp4"
  print "Created MP4 (no music): $output_mp4"
else
  ffmpeg -y \
    -i "$tmp_dir/video.mp4" \
    -stream_loop -1 -i "$music_file" \
    -filter:a "volume=0.3,afade=in:st=0:d=1" \
    -map 0:v -map 1:a \
    -c:v copy -c:a aac -b:a 192k -ar 48000 -ac 2 \
    -shortest -movflags +faststart \
    "$output_mp4"
  print "Created MP4 (with background music): $output_mp4"
fi
