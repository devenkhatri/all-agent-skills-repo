#!/bin/zsh
# export-carousel-all.zsh
# Runs all three export scripts (PDF, MP4, Hyperframes) sequentially for a given carousel folder.
#
# Usage:
#   ./export-carousel-all.zsh CAROUSEL_FOLDER [--no-music]
#
# Example:
#   ./export-carousel-all.zsh 20260515-141152
#   ./export-carousel-all.zsh 20260515-141152 --no-music
#
# Options:
#   --no-music          Skip background music in both MP4 outputs (default: include music).
#                       PDF is unaffected.

set -euo pipefail

typeset -A opts
zparseopts -D -E -A opts -- -no-music || true
_no_music=""
(( ${+opts[--no-music]} )) && _no_music="yes"

if [[ $# -lt 1 || $# -gt 1 ]]; then
  print "Usage: ./export-carousel-all.zsh CAROUSEL_FOLDER [--no-music]" >&2
  print "Example: ./export-carousel-all.zsh 20260515-141152" >&2
  print "Options:" >&2
  print "  --no-music    Skip background music in both MP4 outputs (PDF unaffected)" >&2
  exit 1
fi

carousel_dir="${1:A}"

# Determine directory of this script to reliably call sibling scripts
script_dir="${0:a:h}"

if [[ ! -d "$carousel_dir" ]]; then
  print "Error: Carousel folder not found: $carousel_dir" >&2
  exit 1
fi

print "============================================================"
print " Exporting Carousel: $(basename "$carousel_dir")"
print "============================================================"

# 1. PDF Export
print "\n--- 1. Exporting PDF ---"
"$script_dir/export-carousel-pdf.zsh" "$carousel_dir"

# 2. MP4 Export (Slideshow)
print "\n--- 2. Exporting Standard MP4 (Slideshow) ---"
"$script_dir/export-carousel-mp4.zsh" "$carousel_dir" ${_no_music:+--no-music}

# 3. Hyperframes MP4 Export (Cinematic)
print "\n--- 3. Exporting Hyperframes MP4 (Cinematic) ---"
"$script_dir/export-carousel-hyperframes.zsh" "$carousel_dir" ${_no_music:+--no-music}

print "\n============================================================"
print " ✅ All exports completed successfully!"
print "============================================================"
