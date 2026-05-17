#!/bin/zsh
# export-carousel-hyperframes.zsh
# Generates a cinematic "hyperframes" MP4 from carousel SVG slides.
#
# Each slide is rendered as a high-resolution PNG, then animated with a
# subtle Ken Burns (slow zoom/pan) effect. Slides are joined with smooth
# cross-dissolve transitions. The result is an H.264 MP4 suitable for
# Instagram Reels, TikTok, LinkedIn video posts, and YouTube Shorts.
#
# Usage:
#   ./export-carousel-hyperframes.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [TRANSITION_DURATION] [OUTPUT_MP4]
#
# Defaults:
#   SECONDS_PER_SLIDE   = 3.0   (minimum 1.5 s recommended)
#   TRANSITION_DURATION = 0.6   (cross-dissolve blend in seconds)
#   OUTPUT_MP4          = CAROUSEL_FOLDER/carousel-hyperframes.mp4

set -euo pipefail

# ── dependency checks ────────────────────────────────────────────────────────

if ! command -v magick >/dev/null 2>&1; then
  print "Error: ImageMagick 'magick' is not installed or not in PATH." >&2
  print "  Install: brew install imagemagick" >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  print "Error: ffmpeg is not installed or not in PATH." >&2
  print "  Install: brew install ffmpeg" >&2
  exit 1
fi

# ── argument parsing ─────────────────────────────────────────────────────────

if [[ $# -lt 1 || $# -gt 4 ]]; then
  print "Usage: ./export-carousel-hyperframes.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [TRANSITION_DURATION] [OUTPUT_MP4]" >&2
  print "Example: ./export-carousel-hyperframes.zsh 20260515-141152 3.0 0.6" >&2
  exit 1
fi

carousel_dir="${1:A}"
seconds_per_slide="${2:-3.0}"
transition_dur="${3:-0.6}"
output_mp4="${4:-$carousel_dir/carousel-hyperframes.mp4}"
slides_dir="$carousel_dir/slides"

# ── validate inputs ──────────────────────────────────────────────────────────

if [[ ! -d "$slides_dir" ]]; then
  print "Error: slides folder not found: $slides_dir" >&2
  exit 1
fi

slides=("$slides_dir"/*slide-<->.svg(Nn))

if [[ ${#slides[@]} -eq 0 ]]; then
  print "Error: no numbered SVG slides found in: $slides_dir" >&2
  exit 1
fi

# ── constants ────────────────────────────────────────────────────────────────

fps=30
# Render each PNG at 2× resolution for crisp Ken Burns zoom without pixel loss
render_w=2160
render_h=2700   # 4:5 portrait; overridden per slide if square detected

# Ken Burns zoom range: start at 100%, end at 108% (subtle outward push)
zoom_start=1.00
zoom_end=1.08

# ── temp dir ─────────────────────────────────────────────────────────────────

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/carousel-hyperframes.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

print "Rendering ${#slides[@]} slides …"

# ── render SVGs to high-res PNGs ─────────────────────────────────────────────

index=1
png_files=()
for slide in "${slides[@]}"; do
  png="$tmp_dir/slide-$(printf '%03d' "$index").png"

  # Detect canvas shape from the SVG viewBox/height to handle square (LinkedIn)
  svg_height=$(grep -o 'height="[0-9]*"' "$slide" | head -1 | grep -o '[0-9]*' || echo 1350)
  if [[ "$svg_height" -le 1080 ]]; then
    magick -density 144 "$slide" -resize 2160x2160! -background white -alpha remove -alpha off "$png"
  else
    magick -density 144 "$slide" -resize 2160x2700! -background white -alpha remove -alpha off "$png"
  fi

  png_files+=("$png")
  print "  ✓ Slide $index rendered"
  (( index++ ))
done

# ── build ffmpeg filter graph ────────────────────────────────────────────────
#
# Strategy:
#   1. Each PNG is looped for (seconds_per_slide * fps) frames with a zoompan
#      filter to produce the Ken Burns effect.
#   2. Consecutive segments are blended with an acrossfade-style xfade dissolve.
#   3. All segments are concatenated into the final output stream.
#
# Ken Burns direction alternates (zoom-in vs zoom-out, slight diagonal pan)
# to add visual variety across slides.

n=${#png_files[@]}
slide_frames=$(( int(seconds_per_slide * fps) ))
trans_frames=$(( int(transition_dur * fps) ))

# Each segment duration in frames (including overlap for dissolve)
# Effective visible frames per segment = slide_frames
# Total frames in segment             = slide_frames + trans_frames (except last)

filter_parts=()
input_labels=()

for (( i=0; i<n; i++ )); do
  # Alternate Ken Burns: even slides zoom in from centre, odd slides zoom out with pan
  if (( i % 2 == 0 )); then
    # Zoom in: 1.00 → 1.08, centred
    kb_filter="zoompan=z='min(zoom+0.0008,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=${slide_frames}:s=1080x1350:fps=${fps}"
  else
    # Zoom out: 1.08 → 1.00, slight top-left drift
    kb_filter="zoompan=z='if(lte(zoom,1.0),1.08,max(1.0,zoom-0.0008))':x='iw/2-(iw/zoom/2)-2*on':y='ih/2-(ih/zoom/2)-on':d=${slide_frames}:s=1080x1350:fps=${fps}"
  fi

  filter_parts+=("[${i}:v]${kb_filter}[v${i}]")
  input_labels+=("[v${i}]")
done

# Build xfade chain: v0 xfade v1 → tmp01; tmp01 xfade v2 → tmp02; …
xfade_parts=()
prev_label="[v0]"
for (( i=1; i<n; i++ )); do
  offset=$(( i * slide_frames - i * trans_frames ))
  if (( i < n-1 )); then
    out_label="[xf${i}]"
  else
    out_label="[vout]"
  fi
  xfade_parts+=("${prev_label}[v${i}]xfade=transition=dissolve:duration=${transition_dur}:offset=${offset}${out_label}")
  prev_label="$out_label"
done

# Assemble complete filter_complex string
all_filters="${(j:;:)filter_parts};${(j:;:)xfade_parts}"

# Build -i arguments
input_args=()
for png in "${png_files[@]}"; do
  input_args+=(-loop 1 -i "$png")
done

print "\nEncoding hyperframes video …"

ffmpeg -y \
  "${input_args[@]}" \
  -filter_complex "$all_filters" \
  -map "[vout]" \
  -c:v libx264 \
  -preset slow \
  -crf 18 \
  -pix_fmt yuv420p \
  -movflags +faststart \
  -r $fps \
  "$output_mp4"

print "\n✅ Hyperframes MP4 created: $output_mp4"
print "   Slides: ${#png_files[@]}  |  Duration per slide: ${seconds_per_slide}s  |  Dissolve: ${transition_dur}s"
