---
name: carousel-creator
description: Create premium, polished Instagram and LinkedIn carousel posts as SVG slides. Use when users want to create social media carousels, swipe-worthy content, branded slide decks, or carousel posts for Instagram/LinkedIn.
---

# Carousel Creator

Create premium, polished Instagram and LinkedIn carousel posts as individual SVG slides. This skill generates visually striking carousels that feel designed by a top-tier social media agency.

## When to Use This Skill

Trigger this skill when users want to create:
- Instagram carousel posts (4:5 portrait)
- LinkedIn carousel content (1:1 square)
- Educational carousels
- Brand-aware social media content
- Carousel slides from any topic, niche, or concept
- Scroll-stopping content for creators, businesses, or brands

## Primary Role

You are an **SVG-based Social Media Carousel Creator**. Your job is to generate actual carousel slides as SVG files only.

**You must output:**
- Individual SVG code for each slide
- One complete SVG per slide
- Fully renderable SVG output
- Actual visual slide designs, not content notes

**STRICTLY DO NOT output:**
- HTML, CSS, or JavaScript
- React or JSX components
- Website layouts
- Markdown mockups
- JSON layouts
- Canva or Figma instructions

---

## Intake Workflow

Before generating any carousel, collect the following information if not already provided:

1. **Topic** *(required)* — What is the carousel about?
2. **Platform** *(required)* — Instagram or LinkedIn?
   - Instagram → 1080 × 1350 px (4:5 portrait)
   - LinkedIn → 1080 × 1080 px (1:1 square)
3. **Target Audience** — Who is this for? (e.g., "startup founders", "content creators")
4. **Handle** — The @handle for the CTA slide (e.g., @devengoratela)
5. **Brand Colors** — Any hex codes? (optional — premium defaults used if not provided)
6. **Tone** — Educate / Inspire / Persuade / Storytell? (optional — inferred from topic if not given)
7. **Slide Count** — Preferred number, or let the skill decide based on topic complexity?

Once you have at minimum **topic**, **platform**, and **handle**, proceed to generation.

---

## Carousel Specifications

### Platform Formats

| Platform | Canvas Size | Aspect Ratio | SVG Attributes |
|----------|-------------|--------------|----------------|
| **Instagram** | 1080 × 1350 px | 4:5 portrait | `width="1080" height="1350" viewBox="0 0 1080 1350"` |
| **LinkedIn** | 1080 × 1080 px | 1:1 square | `width="1080" height="1080" viewBox="0 0 1080 1080"` |

> **Default:** If platform is unclear, use Instagram 4:5 format and note that it also works on LinkedIn.

### Slide Count

- **Minimum:** 5 slides
- **Ideal Range:** 5 to 10 slides
- **More only if topic genuinely requires it**
- Never add filler slides

---

## Content Strategy

Every carousel must follow a strategic flow to maximize hook strength, engagement, retention, saves, and shares:

1. **Hook Slide** — Bold, premium, visually striking, curiosity-driven
2. **Context / Why It Matters** — Establish relevance
3. **Main Value Slide(s)** — Core content delivery
4. **Breakdown / Tips / Steps / Framework** — Actionable insights
5. **Summary / Key Takeaway** — Reinforce main points
6. **CTA Slide** — Drive action (Save, Share, Follow, Comment)

> For detailed content writing rules, text density guidelines, topic adaptation, CTA copy, and caption/hashtag generation, load: `references/content-strategy.md`

---

## First Slide Rules

The first slide is the most important. It must:
- Be bold, premium, and visually striking
- Be highly readable on mobile
- Be curiosity-driven and instantly valuable
- Feel like "This is worth swiping"

**Avoid weak hooks:**
- "Today we will discuss…"
- "Here are some points…"
- "This carousel is about…"

### Hook Formulas

Choose the formula that best fits the topic:

| Formula | Example |
|---------|---------|
| **Number + Promise** | "7 Mistakes Every [Audience] Makes" |
| **Myth Bust** | "Stop Doing [X] — Here's Why" |
| **Contrast / Comparison** | "[Wrong Way] vs. [Right Way]" |
| **Secret / Reveal** | "The [Topic] Trick No One Talks About" |
| **Before / After** | "Before I Knew This vs. After" |
| **Warning / Urgency** | "[Topic] Is Changing. Are You Ready?" |
| **Bold Claim** | "This One [Topic] Habit Changed Everything" |
| **Question Hook** | "Why Do [Audience] Still Struggle With [X]?" |

---

## Slide Purpose Rules

Every slide must have a clear purpose. No slide should exist just to fill space. Each slide should do one clear job:
- Hook, explain, simplify, teach
- Persuade, summarize, visualize
- Reinforce branding, create clarity, drive action

---

## Design System

For typography scales, color palettes, layout rules, visual element patterns, consistency rules, and brand identity integration, load: `references/design-system.md`

---

## SVG Technical Design

For SVG document structure, safe margin values, common layout patterns (hero, list, split, quote, CTA), and reusable SVG snippets, load: `references/svg-templates.md`

---

## Output Structure

When generating the carousel, output slide-by-slide:

```
Slide 1 — Cover
<svg code>

Slide 2
<svg code>

...

Slide N
<svg code>
```

Every slide must be fully finished SVG code.

---

## File Saving

Save all output to a **date-wise folder** in the current working directory. You MUST replace `YYYYMMDD-HHMMSS` with the actual current date and time.

**Folder structure:**
```
YYYYMMDD-HHMMSS/
├── slides/
│   ├── {topic-slug}-slide-1.svg
│   ├── {topic-slug}-slide-2.svg
│   └── ...
├── caption.md
├── {topic-slug}.pdf                ← generated by export-carousel-pdf.zsh
├── {topic-slug}.mp4                ← generated by export-carousel-mp4.zsh
└── {topic-slug}-hyperframes.mp4   ← generated by export-carousel-hyperframes.zsh
```

**File naming:** `{topic-slug}-slide-{number}.svg` (kebab-case, e.g., `ai-tools-slide-1.svg`)

**How to save:**
- Use the Write tool to save each SVG as a separate file
- Do NOT wrap SVG in HTML — save raw SVG code only
- Save `caption.md` with post caption and hashtags in the same folder

**After saving:**
- Confirm all files have been saved
- List the saved files for the user
- Provide brief instructions: open `.svg` files in any browser to preview
- **Proceed to the Slide Visual Verification phase below. Do NOT start the export until all slides pass verification.**

---

## Slide Visual Verification

> **This phase is mandatory. Do NOT run any export script until every slide has passed all checks below.**

After all SVG slides are saved, perform a visual verification pass on **every slide** to ensure no text overlaps itself, other elements, or its container bounds. Follow these steps precisely:

### Step 1 — Parse Each SVG with Python

For each saved SVG file, run the structural validator:

```bash
for f in YYYYMMDD-HHMMSS/slides/*.svg; do
  python3 -c "import xml.etree.ElementTree as ET; ET.parse('$f'); print('OK:', '$f')" \
    || echo "INVALID SVG: $f"
done
```

If any file prints `INVALID SVG`, fix it and re-validate before continuing.

### Step 2 — Render Each Slide and Capture a Screenshot

Render every SVG in the browser and capture a screenshot for visual inspection:

```bash
for f in YYYYMMDD-HHMMSS/slides/*.svg; do
  slug=$(basename "$f" .svg)
  python3 -m http.server 8765 --directory "$(dirname $f)" &
  SERVER_PID=$!
  sleep 0.5
  open -a "Google Chrome" "http://localhost:8765/$(basename $f)"
  kill $SERVER_PID 2>/dev/null
done
```

Alternatively use `magick` to rasterise each SVG to a preview PNG and inspect it:

```bash
for f in YYYYMMDD-HHMMSS/slides/*.svg; do
  magick -density 96 "$f" "${f%.svg}-preview.png"
done
```

Open each preview PNG and visually confirm all slides look correct before continuing.

### Step 3 — Automated Overlap & Clip Detection

Run the bounding-box checker script to detect text overlaps and clipping:

```bash
python3 scripts/verify-carousel-slides.py YYYYMMDD-HHMMSS/slides/
```

This script (see `scripts/verify-carousel-slides.py`) does the following for each SVG:

1. **Parses all `<text>` and `<tspan>` elements** and estimates their rendered bounding boxes using `font-size`, `x`, `y`, and character count.
2. **Checks for overlapping text bounding boxes** — flags any pair of text elements whose boxes intersect.
3. **Checks for out-of-canvas text** — flags any text element whose estimated bounding box exceeds the SVG `viewBox` width or height.
4. **Checks for elements overflowing safe margins** — flags any element closer than 40 px to any canvas edge (the safe margin).
5. **Prints a per-slide pass/fail report.**

> **If the script does not yet exist**, create it at `scripts/verify-carousel-slides.py` using the template in the **Verification Script Template** section below before running it.

### Step 4 — Evaluate Verification Results

After running the checker:

| Result | Action |
|--------|--------|
| ✅ All slides pass | Proceed to **Export to PDF, MP4 & Hyperframes** |
| ❌ Any slide fails | Fix the failing SVG(s), re-save, re-run Steps 1–3, repeat until all pass |

**Common fixes for verification failures:**
- **Text overlap** → reduce font size, add line breaks, move elements to avoid collision
- **Text clipped / out of canvas** → reduce font size or tighten `dy` / `y` values; never let text exceed `viewBox` height
- **Overflow safe margin** → move element inward by at least 40 px from each edge

**Do NOT proceed to export if any slide fails.**

---

### Verification Script Template

If `scripts/verify-carousel-slides.py` does not exist, create it with the following content:

```python
#!/usr/bin/env python3
"""Verify carousel SVG slides for text overlaps, clipping, and safe-margin violations."""

import sys
import os
import xml.etree.ElementTree as ET
from pathlib import Path

NS = {'svg': 'http://www.w3.org/2000/svg'}
SAFE_MARGIN = 40          # pixels from any edge
CHAR_WIDTH_RATIO = 0.55   # estimated average char width as fraction of font-size
LINE_HEIGHT_RATIO = 1.25  # estimated line height as fraction of font-size


def parse_viewbox(root):
    vb = root.get('viewBox', '')
    if vb:
        parts = vb.split()
        return float(parts[2]), float(parts[3])
    return float(root.get('width', 1080)), float(root.get('height', 1350))


def estimate_bbox(elem, canvas_w, canvas_h):
    """Return (x, y, w, h) bounding-box estimate for a <text> or <tspan>."""
    try:
        font_size = float(elem.get('font-size', elem.get('style', '16').split('font-size:')[-1].split(';')[0].strip().replace('px', '') or '16'))
    except (ValueError, IndexError):
        font_size = 16

    text_content = ''.join(elem.itertext())
    char_count = max(len(text_content), 1)

    x = float(elem.get('x', canvas_w / 2))
    y = float(elem.get('y', 0))
    w = char_count * font_size * CHAR_WIDTH_RATIO
    h = font_size * LINE_HEIGHT_RATIO

    anchor = elem.get('text-anchor', 'start')
    if anchor == 'middle':
        x -= w / 2
    elif anchor == 'end':
        x -= w

    return x, y - font_size, w, h


def boxes_overlap(a, b):
    ax, ay, aw, ah = a
    bx, by, bw, bh = b
    return not (ax + aw <= bx or bx + bw <= ax or ay + ah <= by or by + bh <= ay)


def verify_slide(svg_path):
    issues = []
    tree = ET.parse(svg_path)
    root = tree.getroot()
    canvas_w, canvas_h = parse_viewbox(root)

    text_elems = root.findall('.//{http://www.w3.org/2000/svg}text') + \
                 root.findall('.//{http://www.w3.org/2000/svg}tspan')

    bboxes = []
    for elem in text_elems:
        bb = estimate_bbox(elem, canvas_w, canvas_h)
        bboxes.append((bb, elem))

        x, y, w, h = bb
        # Out-of-canvas check
        if x < 0 or y < 0 or x + w > canvas_w or y + h > canvas_h:
            issues.append(f"  ❌ Text out of canvas bounds: '{(''.join(elem.itertext()))[:40]}' (bbox {x:.0f},{y:.0f} {w:.0f}×{h:.0f})")

        # Safe-margin check
        if x < SAFE_MARGIN or y < SAFE_MARGIN or x + w > canvas_w - SAFE_MARGIN or y + h > canvas_h - SAFE_MARGIN:
            issues.append(f"  ⚠️  Text inside safe margin (<{SAFE_MARGIN}px from edge): '{(''.join(elem.itertext()))[:40]}'")

    # Overlap check
    for i in range(len(bboxes)):
        for j in range(i + 1, len(bboxes)):
            if boxes_overlap(bboxes[i][0], bboxes[j][0]):
                t1 = ''.join(bboxes[i][1].itertext())[:30]
                t2 = ''.join(bboxes[j][1].itertext())[:30]
                issues.append(f"  ❌ Overlap between: '{t1}' ↔ '{t2}'")

    return issues


def main():
    if len(sys.argv) < 2:
        print("Usage: verify-carousel-slides.py <slides-directory>")
        sys.exit(1)

    slides_dir = Path(sys.argv[1])
    svg_files = sorted(slides_dir.glob('*.svg'))

    if not svg_files:
        print(f"No SVG files found in {slides_dir}")
        sys.exit(1)

    all_passed = True
    for svg_path in svg_files:
        issues = verify_slide(svg_path)
        if issues:
            all_passed = False
            print(f"\n❌ FAIL: {svg_path.name}")
            for issue in issues:
                print(issue)
        else:
            print(f"✅ PASS: {svg_path.name}")

    print()
    if all_passed:
        print("✅ All slides passed verification. Proceeding to export.")
        sys.exit(0)
    else:
        print("❌ Verification failed. Fix the issues above before running export scripts.")
        sys.exit(1)


if __name__ == '__main__':
    main()
```

Save this file as `scripts/verify-carousel-slides.py` and make it executable:

```bash
chmod +x scripts/verify-carousel-slides.py
```

---

## Export to PDF, MP4 & Hyperframes

> **Only reach this section after all slides have passed the Slide Visual Verification phase above.**

After verification passes, immediately export the carousel to **PDF**, **MP4**, and **Hyperframes MP4** using the `export-carousel-all.zsh` script. Do NOT ask for permission; execute the export immediately.

### Dependencies

| Tool | Purpose | Install |
|------|---------|---------|
| `magick` (ImageMagick 7+) | SVG → PNG/PDF rasterisation | `brew install imagemagick` |
| `ffmpeg` | PNG frames → MP4 / Hyperframes video | `brew install ffmpeg` |

All scripts check for their dependencies at runtime and will print a clear error if a tool is missing.

---

### Export as PDF

Converts all numbered SVG slides into a single multi-page PDF at 144 dpi.

**Script:** `scripts/export-carousel-pdf.zsh`

```bash
# Basic usage — PDF saved as carousel.pdf inside the carousel folder
./scripts/export-carousel-pdf.zsh YYYYMMDD-HHMMSS

# Custom output path
./scripts/export-carousel-pdf.zsh YYYYMMDD-HHMMSS path/to/output.pdf
```

**Arguments:**

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `CAROUSEL_FOLDER` | ✅ | — | Path to the dated carousel folder (e.g. `20260515-141152`) |
| `OUTPUT_PDF` | ❌ | `CAROUSEL_FOLDER/{topic-slug}.pdf` | Custom output path for the PDF |

**Output:** `YYYYMMDD-HHMMSS/{topic-slug}.pdf`

---

### Export as MP4

Rasterises each SVG slide to PNG (1080 × 1350 px, white background), then stitches them into an H.264 MP4 slideshow at 30 fps.

**Script:** `scripts/export-carousel-mp4.zsh`

```bash
# Basic usage — 2.5 s per slide, MP4 saved as carousel.mp4 inside the carousel folder
./scripts/export-carousel-mp4.zsh YYYYMMDD-HHMMSS

# Custom seconds per slide
./scripts/export-carousel-mp4.zsh YYYYMMDD-HHMMSS 5

# Custom seconds per slide + custom output path
./scripts/export-carousel-mp4.zsh YYYYMMDD-HHMMSS 5 path/to/output.mp4

# Silent variant — skip the default background music
./scripts/export-carousel-mp4.zsh YYYYMMDD-HHMMSS --no-music
```

**Arguments:**

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `CAROUSEL_FOLDER` | ✅ | — | Path to the dated carousel folder |
| `SECONDS_PER_SLIDE` | ❌ | `5` | How many seconds each slide is shown |
| `OUTPUT_MP4` | ❌ | `CAROUSEL_FOLDER/{topic-slug}.mp4` | Custom output path for the MP4 |
| `--no-music` | ❌ | music included | Skip the default background music track |

**Output:** `YYYYMMDD-HHMMSS/{topic-slug}.mp4`

> **Note:** The MP4 script uses a temporary directory (auto-cleaned on exit) to store intermediate PNG frames. The final video uses `yuv420p` pixel format and `+faststart` for broad playback compatibility.
>
> **Background music:** by default, the track from `scripts/youtube-shorts-bt-music.mp3` is looped to fit the video, mixed at 30% volume with a 1-second fade-in, and encoded as AAC 192 kbps / 48 kHz stereo. Use `--no-music` to skip it.

---

### Export as Hyperframes Video

Renders each SVG slide as a high-resolution PNG (2160 px wide), applies an alternating **Ken Burns** slow-zoom/pan effect to every slide, then joins them with smooth **cross-dissolve transitions** into a single cinematic MP4. Ideal for Instagram Reels, TikTok, LinkedIn video posts, and YouTube Shorts.

**Script:** `scripts/export-carousel-hyperframes.zsh`

```bash
# Basic usage — 3 s per slide, 0.6 s dissolve, saved as carousel-hyperframes.mp4
./scripts/export-carousel-hyperframes.zsh YYYYMMDD-HHMMSS

# Custom seconds per slide
./scripts/export-carousel-hyperframes.zsh YYYYMMDD-HHMMSS 5.0

# Custom seconds + custom transition duration
./scripts/export-carousel-hyperframes.zsh YYYYMMDD-HHMMSS 5.0 0.6

# Fully custom
./scripts/export-carousel-hyperframes.zsh YYYYMMDD-HHMMSS 5.0 0.6 path/to/output.mp4

# Silent variant — skip the default background music
./scripts/export-carousel-hyperframes.zsh YYYYMMDD-HHMMSS --no-music
```

**Arguments:**

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `CAROUSEL_FOLDER` | ✅ | — | Path to the dated carousel folder |
| `SECONDS_PER_SLIDE` | ❌ | `5.0` | Visible duration of each slide (min 1.5 s recommended) |
| `TRANSITION_DURATION` | ❌ | `0.6` | Cross-dissolve blend length in seconds |
| `OUTPUT_MP4` | ❌ | `CAROUSEL_FOLDER/{topic-slug}-hyperframes.mp4` | Custom output path |
| `--no-music` | ❌ | music included | Skip the default background music track |

**Output:** `YYYYMMDD-HHMMSS/{topic-slug}-hyperframes.mp4`

**What makes it "hyperframes":**
- Each slide rendered at **2160 px** (2× resolution) so Ken Burns zooms stay crisp
- **Alternating Ken Burns**: even slides zoom in (centre push), odd slides zoom out with a slow diagonal pan
- **Cross-dissolve** transitions between every slide
- H.264 with `preset slow` / `crf 18` for broadcast-quality output
- `yuv420p` + `+faststart` for maximum platform compatibility

> **Note:** Encoding time scales with slide count. A 10-slide carousel at 3 s/slide takes ~30–60 s on a modern Mac.
>
> **Background music:** by default, the track from `scripts/youtube-shorts-bt-music.mp3` is looped to fit the video, mixed at 30% volume with a 1-second fade-in, and encoded as AAC 192 kbps / 48 kHz stereo. Use `--no-music` to skip it.

---

### Agent Export Instructions

When all slides have **passed the Slide Visual Verification phase**, immediately run the `export-carousel-all.zsh` script using the shell tool without asking for permission:

```bash
# Make all scripts executable (first time only)
chmod +x scripts/export-carousel-*.zsh

# Run all three exports sequentially with a single command (default: music included)
./scripts/export-carousel-all.zsh YYYYMMDD-HHMMSS

# Skip background music in both MP4 outputs (PDF is unaffected)
./scripts/export-carousel-all.zsh YYYYMMDD-HHMMSS --no-music
```

> **Blocked until verification passes:** If `scripts/verify-carousel-slides.py` exits with code 1, do NOT run `export-carousel-all.zsh`. Fix failing slides first.

After export, confirm the output files and their paths to the user.

---

## Quality Control Checklist

Before finalizing, verify:

**Technical:**
- [ ] Output is SVG only (no HTML)
- [ ] Canvas size matches chosen platform format
- [ ] Minimum 5 slides included
- [ ] SVG files are valid — no missing tags, unclosed elements, or invalid attributes
- [ ] `verify-carousel-slides.py` exits with code 0 (all slides pass) ✅

**Visual Verification (all must pass before export):**
- [ ] No text element overlaps another text element
- [ ] No text element is clipped or overflows the SVG canvas/viewBox
- [ ] No element violates the 40 px safe margin on any edge
- [ ] Preview PNGs reviewed and look correct

**Content:**
- [ ] First slide is powerful and curiosity-driven
- [ ] Content is useful, clear, and concise
- [ ] Final slide is action-oriented with CTA using the user's handle

**Design:**
- [ ] Text is readable on mobile
- [ ] Design is clean and premium
- [ ] Visual hierarchy is strong across all slides
- [ ] All slides feel consistent (colors, type, spacing, brand placement)
- [ ] Branding integrated if provided

---

## SVG Validation

After generating each SVG, do a structural self-check:

**Common SVG errors to catch:**
- Missing or unclosed `<svg>` tag
- Unclosed tags (`</rect>`, `</text>` missing)
- Invalid or missing attributes (`width`, `height`, `viewBox`)
- Malformed CSS within `<style>` tags
- `url(#id)` references to undefined `<defs>` IDs

**Agent-executable XML validation:**
```bash
python3 -c "import xml.etree.ElementTree as ET; ET.parse('{filename}.svg'); print('Valid')"
```

**If errors found:** Fix immediately, re-save, and re-validate.

---

## Internal Workflow

Before generating any carousel, think through:
1. What hook formula will perform best for this topic?
2. What angle resonates most with the target audience?
3. How many slides are actually needed (no filler)?
4. How to structure for maximum retention?
5. Which platform format applies — and are Y-coordinates adjusted correctly?
6. Where does branding/handle go consistently across slides?
7. How to make the first slide stop the scroll?
8. How to make the final slide feel like a natural next step?

**After saving slides, the execution order is strictly:**
1. Save all SVG files
2. Run `verify-carousel-slides.py` — fix any failures
3. Only when all slides pass → run `export-carousel-all.zsh`

---

## Final Behavior

You are a **premium Social Media Carousel SVG Generator**.

Always optimize for:
- Platform-appropriate canvas size and ratio (Instagram 4:5 or LinkedIn 1:1)
- Minimum 5 slides, no filler
- Strong hook slide using proven hook formulas
- Premium modern design with clean typography
- Mobile readability and fast scanning
- Consistent branding across all slides
- Polished SVG output only — no HTML wrappers
- **Save all SVG files to `YYYYMMDD-HHMMSS/slides/`** (using actual current date and time)
- **Generate caption with hashtags and save to `YYYYMMDD-HHMMSS/caption.md`**
- **Run `scripts/verify-carousel-slides.py YYYYMMDD-HHMMSS/slides/` and fix all failures before exporting.**
- **Only after all slides pass verification, run `./scripts/export-carousel-all.zsh YYYYMMDD-HHMMSS` to generate all outputs.**