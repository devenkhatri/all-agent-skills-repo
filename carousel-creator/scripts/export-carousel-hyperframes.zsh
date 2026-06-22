#!/bin/zsh
# export-carousel-hyperframes.zsh
# Generates a cinematic "hyperframes" MP4 from carousel SVG slides.
#
# Each slide is embedded in an HTML composition, then animated with a
# subtle Ken Burns (slow zoom/pan) effect using GSAP. Slides are joined
# with smooth cross-dissolve transitions. The result is an H.264 MP4
# rendered natively using the HeyGen Hyperframes framework.
#
# Usage:
#   ./export-carousel-hyperframes.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [TRANSITION_DURATION] [OUTPUT_MP4] [--no-music]
#
# Defaults:
#   SECONDS_PER_SLIDE   = 3.0   (minimum 1.5 s recommended)
#   TRANSITION_DURATION = 0.6   (cross-dissolve blend in seconds)
#   OUTPUT_MP4          = CAROUSEL_FOLDER/carousel-hyperframes.mp4
#
# Options:
#   --no-music          Skip background music in the output MP4 (default: include music)

set -euo pipefail

# ── dependency checks ────────────────────────────────────────────────────────

if ! command -v npx >/dev/null 2>&1; then
  print "Error: Node.js/npx is not installed or not in PATH." >&2
  exit 1
fi

if ! command -v awk >/dev/null 2>&1; then
  print "Error: awk is not installed or not in PATH." >&2
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

# ── argument parsing ─────────────────────────────────────────────────────────

if [[ $# -lt 1 || $# -gt 4 ]]; then
  print "Usage: ./export-carousel-hyperframes.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [TRANSITION_DURATION] [OUTPUT_MP4] [--no-music]" >&2
  print "Example: ./export-carousel-hyperframes.zsh 20260515-141152 5.0 0.6" >&2
  print "Options:" >&2
  print "  --no-music    Skip background music in the output MP4" >&2
  exit 1
fi

carousel_dir="${1:A}"
seconds_per_slide="${2:-5.0}"
transition_dur="${3:-0.6}"
output_mp4="${4:-$carousel_dir/carousel-hyperframes.mp4}"
slides_dir="$carousel_dir/slides"

# ── validate inputs ──────────────────────────────────────────────────────────

if [[ ! -d "$slides_dir" ]]; then
  print "Error: slides folder not found: $slides_dir" >&2
  exit 1
fi

# Collect SVG slides sorted numerically
slides=("$slides_dir"/*slide-[0-9]*.svg(Nn))

if [[ ${#slides[@]} -eq 0 ]]; then
  print "Error: no numbered SVG slides found in: $slides_dir" >&2
  exit 1
fi

n=${#slides[@]}

# Check valid transition duration
is_valid=$(awk "BEGIN { print ($transition_dur < $seconds_per_slide) ? 1 : 0 }")
if [[ "$is_valid" -eq 0 ]]; then
  print "Error: TRANSITION_DURATION ($transition_dur s) must be less than SECONDS_PER_SLIDE ($seconds_per_slide s)." >&2
  exit 1
fi

# Detect canvas shape from the first SVG height attribute
svg_height=$(grep -o 'height="[0-9]*"' "${slides[1]}" 2>/dev/null | head -1 | grep -o '[0-9]*' || true)
svg_height="${svg_height:-1350}"

if (( svg_height <= 1080 )); then
  canvas_w=1080
  canvas_h=1080
else
  canvas_w=1080
  canvas_h=1350
fi

# ── temp dir ─────────────────────────────────────────────────────────────────

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/carousel-hyperframes.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

print "Configuring Hyperframes project …"

# Symlink slides so hyperframes can load them relatively
ln -s "$slides_dir" "$tmp_dir/slides"

# ── generate HTML ────────────────────────────────────────────────────────────

cat > "$tmp_dir/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <style>
    body { margin: 0; background: black; overflow: hidden; }
    #stage { position: relative; width: ${canvas_w}px; height: ${canvas_h}px; }
    .clip { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: contain; transform-origin: center center; }
  </style>
</head>
<body>
  <div id="stage" data-composition-id="carousel" data-start="0" data-width="${canvas_w}" data-height="${canvas_h}">
EOF

index=0
for slide in "${slides[@]}"; do
  start_time=$(awk "BEGIN { printf \"%.3f\", $index * ($seconds_per_slide - $transition_dur) }")
  basename="${slide##*/}"
  
  cat >> "$tmp_dir/index.html" <<EOF
    <img id="slide-${index}" class="clip" data-start="${start_time}" data-duration="${seconds_per_slide}" data-track-index="${index}" src="slides/${basename}" />
EOF
  (( ++index ))
done

cat >> "$tmp_dir/index.html" <<EOF
  </div>
  <script src="https://cdn.jsdelivr.net/npm/gsap@3/dist/gsap.min.js"></script>
  <script>
    const tl = gsap.timeline({ paused: true });
    const S = ${seconds_per_slide};
    const D = ${transition_dur};
    const N = ${n};
    
    for(let i=0; i<N; i++) {
        let startTime = i * (S - D);
        let id = '#slide-' + i;
        
        if (i % 2 === 0) {
            // Even: zoom in (centered)
            tl.fromTo(id, { scale: 1.0 }, { scale: 1.08, duration: S, ease: 'none' }, startTime);
        } else {
            // Odd: zoom out, slight pan
            tl.fromTo(id, { scale: 1.08, x: -16, y: -16 }, { scale: 1.0, x: 0, y: 0, duration: S, ease: 'none' }, startTime);
        }
        
        // Fade in (cross-dissolve)
        if (i > 0) {
            tl.fromTo(id, { opacity: 0 }, { opacity: 1, duration: D, ease: 'none' }, startTime);
        }
    }
    
    window.__timelines = window.__timelines || {};
    window.__timelines['carousel'] = tl;
  </script>
</body>
</html>
EOF

# ── encode ───────────────────────────────────────────────────────────────────

print "\nEncoding hyperframes video via hyperframes CLI …"

npx -y hyperframes render "$tmp_dir" -o "$tmp_dir/video.mp4"

if [[ -n "$_no_music" ]]; then
  mv "$tmp_dir/video.mp4" "$output_mp4"
  print "\n✅ Hyperframes MP4 created (no music): $output_mp4"
  print "   Slides: ${n}  |  Duration per slide: ${seconds_per_slide}s  |  Dissolve: ${transition_dur}s"
else
  ffmpeg -y \
    -i "$tmp_dir/video.mp4" \
    -stream_loop -1 -i "$music_file" \
    -filter:a "volume=0.3,afade=in:st=0:d=1" \
    -map 0:v -map 1:a \
    -c:v copy -c:a aac -b:a 192k -ar 48000 -ac 2 \
    -shortest -movflags +faststart \
    "$output_mp4"
  print "\n✅ Hyperframes MP4 created (with background music): $output_mp4"
  print "   Slides: ${n}  |  Duration per slide: ${seconds_per_slide}s  |  Dissolve: ${transition_dur}s"
fi
