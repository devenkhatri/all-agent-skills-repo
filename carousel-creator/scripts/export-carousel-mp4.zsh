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

if [[ $# -lt 1 || $# -gt 3 ]]; then
  print "Usage: ./export-carousel-mp4.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [OUTPUT_MP4]" >&2
  print "Example: ./export-carousel-mp4.zsh 20260515-141152 2.5" >&2
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
  "$output_mp4"

print "Created MP4: $output_mp4"
