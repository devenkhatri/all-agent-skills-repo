#!/bin/zsh
# export-carousel-hyperframes.zsh
# Generates a cinematic "hyperframes" MP4 from carousel SVG slides with
# motion graphics, proper captions, copyright-free B-roll, and ElevenLabs voiceover.
#
# Rules & Capabilities:
#   1. Pre-Edit Review: Before you edit, watch the whole video and tell me
#      what can be done better (hook, pacing, dead air, visual gaps).
#   2. Motion Graphics: Dynamic top progress bar, animated slide counter badges,
#      and smooth GSAP timeline transitions.
#   3. Proper Captions: High-contrast frosted glass pill, active keyword
#      highlighting, and safe-zone positioning for mobile viewing.
#   4. Copyright-Free B-Roll: Layer free B-roll from Pexels, Pixabay, Mixkit,
#      or Coverr stored in CAROUSEL_FOLDER/assets/broll/.
#   5. ElevenLabs Voiceover: Add latest cloned voice from ElevenLabs as voiceover,
#      keeping background music on low volume and voice clearly audible.
#   6. Constant Pacing: 5.0s per slide default (never speed up for more slides).
#
# Usage:
#   ./export-carousel-hyperframes.zsh CAROUSEL_FOLDER [SECONDS_PER_SLIDE] [TRANSITION_DURATION] [OUTPUT_MP4] [--no-music]
#
# Defaults:
#   SECONDS_PER_SLIDE   = 5.0   (constant pace regardless of slide count)
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
# Maintain constant readable pace (5.0s per slide) regardless of slide count; never accelerate for more slides
seconds_per_slide="${2:-5.0}"
transition_dur="${3:-0.6}"
output_mp4="${4:-$carousel_dir/carousel-hyperframes.mp4}"
slides_dir="$carousel_dir/slides"
broll_dir="$carousel_dir/assets/broll"
captions_json="$carousel_dir/captions.json"

# Check for ElevenLabs cloned voiceover file
voiceover_file=""
for cand in "$carousel_dir/assets/voiceover.mp3" "$carousel_dir/assets/voiceover.wav" "$carousel_dir/voiceover.mp3" "$carousel_dir/voiceover.wav"; do
  if [[ -f "$cand" ]]; then
    voiceover_file="$cand"
    break
  fi
done

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

# Check for B-roll clips in assets/broll
has_broll=0
broll_clips=()
if [[ -d "$broll_dir" ]]; then
  ln -s "$broll_dir" "$tmp_dir/broll"
  broll_clips=("$broll_dir"/*.(mp4|webm|mov)(Nn))
  if (( ${#broll_clips[@]} > 0 )); then
    has_broll=1
    print "  • Found ${#broll_clips[@]} copyright-free B-roll clip(s) in $broll_dir"
  fi
fi

# Check for captions.json
has_captions=0
captions_content="[]"
if [[ -f "$captions_json" ]]; then
  has_captions=1
  captions_content="$(cat "$captions_json")"
  print "  • Found synchronized captions: $captions_json"
fi

if [[ -n "$voiceover_file" ]]; then
  print "  • Found ElevenLabs cloned voiceover: $voiceover_file"
fi

# Total calculated runtime
total_duration=$(awk "BEGIN { printf \"%.3f\", ($n - 1) * ($seconds_per_slide - $transition_dur) + $seconds_per_slide }")

# ── generate HTML ────────────────────────────────────────────────────────────

cat > "$tmp_dir/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <style>
    body { margin: 0; background: #000; overflow: hidden; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; }
    #stage { position: relative; width: ${canvas_w}px; height: ${canvas_h}px; overflow: hidden; background: #000; }
    .clip { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: contain; transform-origin: center center; }
    .broll-clip { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0; z-index: 5; pointer-events: none; }
    
    /* Motion Graphics: Top Progress Bar */
    .progress-bar-container { position: absolute; top: 0; left: 0; width: 100%; height: 8px; background: rgba(255, 255, 255, 0.15); z-index: 25; }
    .progress-bar { width: 0%; height: 100%; background: linear-gradient(90deg, #38BDF8, #818CF8, #C084FC); }
    
    /* Motion Graphics: Slide Counter Badges */
    .slide-badge { position: absolute; top: 36px; left: 40px; padding: 10px 22px; border-radius: 9999px; background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.2); color: #F8FAFC; font-size: 20px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; z-index: 25; opacity: 0; }
    
    /* Proper Captions */
    .caption-box { position: absolute; bottom: 130px; left: 50%; transform: translateX(-50%); width: 88%; max-width: 920px; text-align: center; z-index: 30; pointer-events: none; opacity: 0; }
    .caption-pill { display: inline-block; background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 22px; padding: 16px 30px; box-shadow: 0 12px 32px rgba(0, 0, 0, 0.55); color: #FFFFFF; font-size: 34px; font-weight: 700; line-height: 1.35; letter-spacing: -0.5px; text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6); }
    .caption-highlight { color: #FCD34D; font-weight: 800; }
  </style>
</head>
<body>
  <div id="stage" data-composition-id="carousel" data-start="0" data-width="${canvas_w}" data-height="${canvas_h}">
    <!-- Motion Graphics: Top Progress Bar -->
    <div class="progress-bar-container"><div id="progress-bar" class="progress-bar"></div></div>
EOF

index=0
for slide in "${slides[@]}"; do
  start_time=$(awk "BEGIN { printf \"%.3f\", $index * ($seconds_per_slide - $transition_dur) }")
  basename="${slide##*/}"
  slide_num=$(( index + 1 ))
  
  cat >> "$tmp_dir/index.html" <<EOF
    <!-- Slide ${slide_num} -->
    <div id="badge-${index}" class="slide-badge">SLIDE ${slide_num} / ${n}</div>
    <img id="slide-${index}" class="clip" data-start="${start_time}" data-duration="${seconds_per_slide}" data-track-index="${index}" src="slides/${basename}" />
EOF

  # If B-roll clip corresponds to this slide
  if (( has_broll )) && (( index < ${#broll_clips[@]} )); then
    broll_name="${broll_clips[index + 1]##*/}"
    cat >> "$tmp_dir/index.html" <<EOF
    <video id="broll-${index}" class="broll-clip" src="broll/${broll_name}" muted playsinline></video>
EOF
  fi

  (( ++index ))
done

cat >> "$tmp_dir/index.html" <<EOF
    <!-- Dynamic Captions Container -->
    <div id="captions-container"></div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/gsap@3/dist/gsap.min.js"></script>
  <script>
    const tl = gsap.timeline({ paused: true });
    const S = ${seconds_per_slide};
    const D = ${transition_dur};
    const N = ${n};
    const totalDuration = ${total_duration};
    const captionsData = ${captions_content};
    
    // Motion Graphics: Progress bar animation
    tl.to('#progress-bar', { width: '100%', duration: totalDuration, ease: 'none' }, 0);
    
    // Slide Ken Burns and Badge Animations
    for(let i=0; i<N; i++) {
        let startTime = i * (S - D);
        let id = '#slide-' + i;
        let badgeId = '#badge-' + i;
        let brollId = '#broll-' + i;
        
        // Alternating Ken Burns
        if (i % 2 === 0) {
            tl.fromTo(id, { scale: 1.0 }, { scale: 1.08, duration: S, ease: 'none' }, startTime);
        } else {
            tl.fromTo(id, { scale: 1.08, x: -16, y: -16 }, { scale: 1.0, x: 0, y: 0, duration: S, ease: 'none' }, startTime);
        }
        
        // Slide Cross-dissolve
        if (i > 0) {
            tl.fromTo(id, { opacity: 0 }, { opacity: 1, duration: D, ease: 'none' }, startTime);
        }
        
        // Motion Graphics: Slide Badge Entrance and Fade
        tl.fromTo(badgeId, { opacity: 0, y: -12 }, { opacity: 1, y: 0, duration: 0.45, ease: 'power2.out' }, startTime + 0.1);
        tl.to(badgeId, { opacity: 0, duration: D, ease: 'none' }, startTime + S - D);
        
        // B-Roll Cutaway Layer (if present)
        const brollElem = document.querySelector(brollId);
        if (brollElem) {
            tl.fromTo(brollId, { opacity: 0, scale: 1.04 }, { opacity: 0.95, scale: 1.0, duration: 0.5, ease: 'power2.out' }, startTime + 1.2);
            tl.to(brollId, { opacity: 0, duration: 0.4, ease: 'power2.in' }, startTime + S - 1.0);
        }
    }
    
    // Captions Rendering & Animation
    if (Array.isArray(captionsData) && captionsData.length > 0) {
        const container = document.getElementById('captions-container');
        captionsData.forEach((cap, idx) => {
            const capBox = document.createElement('div');
            capBox.id = 'caption-' + idx;
            capBox.className = 'caption-box';
            
            let htmlText = cap.text;
            if (cap.highlight) {
                const regex = new RegExp('(' + cap.highlight.replace(/[.*+?^${}()|[\\]\\\\]/g, '\\\\$&') + ')', 'gi');
                htmlText = htmlText.replace(regex, '<span class="caption-highlight">\$1</span>');
            }
            capBox.innerHTML = '<div class="caption-pill">' + htmlText + '</div>';
            container.appendChild(capBox);
            
            let start = cap.start || (idx * (S - D) + 0.3);
            let dur = cap.duration || (S - D - 0.6);
            tl.fromTo('#caption-' + idx, { opacity: 0, y: 15 }, { opacity: 1, y: 0, duration: 0.4, ease: 'power2.out' }, start);
            tl.to('#caption-' + idx, { opacity: 0, y: -8, duration: 0.35, ease: 'power2.in' }, start + dur);
        });
    }
    
    window.__timelines = window.__timelines || {};
    window.__timelines['carousel'] = tl;
  </script>
</body>
</html>
EOF

# ── encode ───────────────────────────────────────────────────────────────────

print "\nEncoding hyperframes video via hyperframes CLI (with motion graphics, captions, and b-roll) …"

npx -y hyperframes render "$tmp_dir" -o "$tmp_dir/video.mp4"

if [[ -n "$voiceover_file" ]]; then
  if [[ -n "$_no_music" ]]; then
    ffmpeg -y \
      -i "$tmp_dir/video.mp4" \
      -i "$voiceover_file" \
      -map 0:v -map 1:a \
      -c:v copy -c:a aac -b:a 192k -ar 48000 -ac 2 \
      -shortest -movflags +faststart \
      "$output_mp4"
    print "\n✅ Hyperframes MP4 created (with ElevenLabs voiceover, no music): $output_mp4"
  else
    # ElevenLabs voiceover at full volume (clearly audible), background music at low volume (0.10)
    ffmpeg -y \
      -i "$tmp_dir/video.mp4" \
      -i "$voiceover_file" \
      -stream_loop -1 -i "$music_file" \
      -filter_complex "[1:a]volume=1.0[voice];[2:a]volume=0.10,afade=in:st=0:d=1[bg];[voice][bg]amix=inputs=2:duration=first:dropout_transition=2[aout]" \
      -map 0:v -map "[aout]" \
      -c:v copy -c:a aac -b:a 192k -ar 48000 -ac 2 \
      -shortest -movflags +faststart \
      "$output_mp4"
    print "\n✅ Hyperframes MP4 created (with ElevenLabs voiceover + low volume background music): $output_mp4"
  fi
  print "   Slides: ${n}  |  Duration per slide: ${seconds_per_slide}s  |  Dissolve: ${transition_dur}s"
elif [[ -n "$_no_music" ]]; then
  mv "$tmp_dir/video.mp4" "$output_mp4"
  print "\n✅ Hyperframes MP4 created (no audio): $output_mp4"
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
