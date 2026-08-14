#!/bin/zsh
set -euo pipefail

if ! command -v rsvg-convert >/dev/null 2>&1; then
  print "Error: 'rsvg-convert' is not installed or not in PATH." >&2
  print "Install with: brew install librsvg" >&2
  exit 1
fi

if ! command -v magick >/dev/null 2>&1; then
  print "Error: ImageMagick 'magick' is not installed or not in PATH." >&2
  exit 1
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
  print "Usage: ./export-carousel-pdf.zsh CAROUSEL_FOLDER [OUTPUT_PDF]" >&2
  print "Example: ./export-carousel-pdf.zsh 20260515-141152" >&2
  exit 1
fi

carousel_dir="${1:A}"
slides_dir="$carousel_dir/slides"
output_pdf="${2:-$carousel_dir/carousel.pdf}"

if [[ ! -d "$slides_dir" ]]; then
  print "Error: slides folder not found: $slides_dir" >&2
  exit 1
fi

# Numeric sort so slide-2 comes before slide-10, etc.
slides=("${(@f)$(print -l "$slides_dir"/*slide-<->.svg(Nn) | sort -t- -k2 -n)}")

if [[ ${#slides[@]} -eq 0 ]]; then
  print "Error: no numbered SVG slides found in: $slides_dir" >&2
  exit 1
fi

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

pngs=()
i=1
for svg in "${slides[@]}"; do
  png=$(printf "%s/slide-%03d.png" "$tmpdir" "$i")
  rsvg-convert -d 144 -p 144 "$svg" -o "$png"
  pngs+=("$png")
  ((i++))
done

magick "${pngs[@]}" -quality 100 "$output_pdf"
print "Created PDF: $output_pdf"
