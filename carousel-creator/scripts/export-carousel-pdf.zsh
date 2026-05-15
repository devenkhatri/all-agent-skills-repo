#!/bin/zsh
set -euo pipefail

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

slides=("$slides_dir"/*slide-<->.svg(Nn))

if [[ ${#slides[@]} -eq 0 ]]; then
  print "Error: no numbered SVG slides found in: $slides_dir" >&2
  exit 1
fi

magick -density 144 "${slides[@]}" -quality 100 "$output_pdf"
print "Created PDF: $output_pdf"
