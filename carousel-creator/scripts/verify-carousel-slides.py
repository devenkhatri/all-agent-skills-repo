#!/usr/bin/env python3
"""
verify-carousel-slides.py
─────────────────────────
Verify carousel SVG slides for:
  1. XML validity (well-formed SVG)
  2. Text bounding-box overlaps between any two <text> / <tspan> elements
  3. Text elements that overflow the SVG canvas / viewBox
  4. Elements that violate the 40 px safe margin on any canvas edge
  5. Different background colors across all slides (visual variety rule)

Usage:
  python3 verify-carousel-slides.py <slides-directory>

Exit codes:
  0  – all slides passed
  1  – one or more slides failed (fix them before running export scripts)
"""

import sys
import xml.etree.ElementTree as ET
from pathlib import Path

# ── Constants ──────────────────────────────────────────────────────────────────
SAFE_MARGIN = 40          # minimum pixels from any canvas edge
CHAR_WIDTH_RATIO = 0.55   # estimated avg char width as a fraction of font-size
LINE_HEIGHT_RATIO = 1.25  # estimated line height as a fraction of font-size
SVG_NS = "http://www.w3.org/2000/svg"

# ── Helpers ────────────────────────────────────────────────────────────────────

def parse_viewbox(root):
    """Return (canvas_width, canvas_height) from viewBox or width/height attrs."""
    vb = root.get("viewBox", "")
    if vb:
        parts = vb.split()
        if len(parts) == 4:
            return float(parts[2]), float(parts[3])
    return float(root.get("width", 1080)), float(root.get("height", 1350))


def parse_font_size(elem):
    """Best-effort extraction of font-size from element attrs or inline style."""
    fs = elem.get("font-size", "")
    if fs:
        return float(fs.replace("px", "").strip())

    style = elem.get("style", "")
    if "font-size" in style:
        for part in style.split(";"):
            part = part.strip()
            if part.startswith("font-size"):
                value = part.split(":", 1)[-1].strip().replace("px", "")
                try:
                    return float(value)
                except ValueError:
                    pass

    return 16.0  # safe fallback


def estimate_bbox(elem, canvas_w, canvas_h):
    """
    Estimate the rendered bounding box of a <text> or <tspan> element.
    Returns (x, y, width, height) in SVG user units.
    """
    font_size = parse_font_size(elem)
    text_content = "".join(elem.itertext())
    char_count = max(len(text_content), 1)

    raw_x = elem.get("x", None)
    raw_y = elem.get("y", None)

    x = float(raw_x) if raw_x is not None else canvas_w / 2
    y = float(raw_y) if raw_y is not None else 0.0

    w = char_count * font_size * CHAR_WIDTH_RATIO
    h = font_size * LINE_HEIGHT_RATIO

    anchor = elem.get("text-anchor", "start")
    if anchor == "middle":
        x -= w / 2
    elif anchor == "end":
        x -= w

    # y in SVG is the text baseline; shift up by font_size to get top of glyph
    y = y - font_size

    return x, y, w, h


def boxes_overlap(a, b):
    """Return True if two (x, y, w, h) boxes intersect (share area)."""
    ax, ay, aw, ah = a
    bx, by, bw, bh = b
    return not (ax + aw <= bx or bx + bw <= ax or ay + ah <= by or by + bh <= ay)


def extract_background(root, canvas_w, canvas_h):
    """
    Extract the background color or gradient representation of an SVG root.
    Returns a normalized string identifier of the background, e.g. '#0d1b2a' or 'gradient(#0d1b2a,#162236)'.
    """
    for rect in root.findall(f".//{{{SVG_NS}}}rect"):
        x_val = rect.get("x", "0")
        y_val = rect.get("y", "0")
        w_val = rect.get("width", "")
        h_val = rect.get("height", "")

        try:
            x = float(x_val)
            y = float(y_val)
        except ValueError:
            x, y = 0.0, 0.0

        w = canvas_w if w_val in ("100%", "") else 0.0
        h = canvas_h if h_val in ("100%", "") else 0.0
        try:
            if w_val and w_val != "100%":
                w = float(w_val.replace("px", "").strip())
            if h_val and h_val != "100%":
                h = float(h_val.replace("px", "").strip())
        except ValueError:
            pass

        # If rect covers at least 70% of canvas from near origin
        if x <= 100 and y <= 100 and w >= canvas_w * 0.7 and h >= canvas_h * 0.7:
            fill = rect.get("fill", "")
            if fill.startswith("url(#") and fill.endswith(")"):
                grad_id = fill[5:-1]
                for grad in root.findall(f".//{{{SVG_NS}}}linearGradient") + root.findall(f".//{{{SVG_NS}}}radialGradient"):
                    if grad.get("id") == grad_id:
                        stops = [stop.get("stop-color", "").lower() for stop in grad.findall(f"{{{SVG_NS}}}stop")]
                        return f"gradient({','.join(stops)})"
                return f"url({grad_id})"
            elif fill and fill != "none":
                return fill.lower()

    return "unknown"


# ── Per-slide verification ─────────────────────────────────────────────────────

def verify_slide(svg_path):
    """
    Parse an SVG file and return a list of issue strings.
    Empty list means the slide passed all checks.
    """
    issues = []

    # Step 1: XML parse
    try:
        tree = ET.parse(svg_path)
    except ET.ParseError as exc:
        return [f"  \u274c Invalid XML / malformed SVG: {exc}"]

    root = tree.getroot()
    canvas_w, canvas_h = parse_viewbox(root)

    # Collect all <text> and <tspan> elements
    text_elems = (
        root.findall(f".//{{{SVG_NS}}}text")
        + root.findall(f".//{{{SVG_NS}}}tspan")
    )

    bboxes = []

    for elem in text_elems:
        bb = estimate_bbox(elem, canvas_w, canvas_h)
        bboxes.append((bb, elem))

        x, y, w, h = bb
        label = "".join(elem.itertext())[:50].replace("\n", " ")

        # Out-of-canvas check
        if x < 0 or y < 0 or x + w > canvas_w or y + h > canvas_h:
            issues.append(
                f"  \u274c Text outside canvas bounds -> '{label}'\n"
                f"       bbox: x={x:.0f}, y={y:.0f}, w={w:.0f}, h={h:.0f}  "
                f"(canvas: {canvas_w:.0f}x{canvas_h:.0f})"
            )

        # Safe-margin check
        violations = []
        if x < SAFE_MARGIN:
            violations.append(f"left edge ({x:.0f} < {SAFE_MARGIN})")
        if y < SAFE_MARGIN:
            violations.append(f"top edge ({y:.0f} < {SAFE_MARGIN})")
        if x + w > canvas_w - SAFE_MARGIN:
            violations.append(f"right edge ({x+w:.0f} > {canvas_w-SAFE_MARGIN:.0f})")
        if y + h > canvas_h - SAFE_MARGIN:
            violations.append(f"bottom edge ({y+h:.0f} > {canvas_h-SAFE_MARGIN:.0f})")
        if violations:
            issues.append(
                f"  \u26a0\ufe0f  Text inside {SAFE_MARGIN}px safe margin -> '{label}'\n"
                f"       violations: {', '.join(violations)}"
            )

    # Overlap check (O(n^2) over all text/tspan pairs)
    for i in range(len(bboxes)):
        for j in range(i + 1, len(bboxes)):
            bb_i, elem_i = bboxes[i]
            bb_j, elem_j = bboxes[j]
            if boxes_overlap(bb_i, bb_j):
                t1 = "".join(elem_i.itertext())[:30].replace("\n", " ")
                t2 = "".join(elem_j.itertext())[:30].replace("\n", " ")
                issues.append(
                    f"  \u274c Text overlap detected:\n"
                    f"       '{t1}'  <->  '{t2}'"
                )

    return issues


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    if len(sys.argv) < 2:
        print("Usage: verify-carousel-slides.py <slides-directory>")
        print("Example: python3 scripts/verify-carousel-slides.py 20260824-113000/slides/")
        sys.exit(1)

    slides_dir = Path(sys.argv[1])

    if not slides_dir.is_dir():
        print(f"\u274c Directory not found: {slides_dir}")
        sys.exit(1)

    svg_files = sorted(slides_dir.glob("*.svg"))

    if not svg_files:
        print(f"\u274c No SVG files found in: {slides_dir}")
        sys.exit(1)

    print(f"\n{'─'*60}")
    print(f"  Verifying {len(svg_files)} slide(s) in: {slides_dir}")
    print(f"{'─'*60}\n")

    all_passed = True

    for svg_path in svg_files:
        issues = verify_slide(svg_path)
        if issues:
            all_passed = False
            print(f"❌ FAIL  {svg_path.name}")
            for issue in issues:
                print(issue)
            print()
        else:
            print(f"✅ PASS  {svg_path.name}")

    # ── Cross-slide verification: Background colors ─────────────────────────
    backgrounds = []
    for svg_path in svg_files:
        try:
            tree = ET.parse(svg_path)
            root = tree.getroot()
            cw, ch = parse_viewbox(root)
            bg = extract_background(root, cw, ch)
            backgrounds.append((svg_path.name, bg))
        except Exception:
            pass

    if len(backgrounds) > 1:
        known_bgs = [bg for _, bg in backgrounds if bg != "unknown"]
        unique_bgs = set(known_bgs)
        if len(known_bgs) > 1 and len(unique_bgs) == 1:
            all_passed = False
            print(f"\n❌ FAIL: Slide Background Check")
            print(f"  ❌ All {len(backgrounds)} slides have the identical background color/gradient: {list(unique_bgs)[0]}")
            print(f"       Rule: Always use a different background color for each slide to maintain dynamic visual variety.\n")
        else:
            has_consecutive_dup = False
            for i in range(len(backgrounds) - 1):
                s1_name, s1_bg = backgrounds[i]
                s2_name, s2_bg = backgrounds[i + 1]
                if s1_bg != "unknown" and s1_bg == s2_bg:
                    has_consecutive_dup = True
                    print(f"\n⚠️  WARNING: Consecutive slides '{s1_name}' and '{s2_name}' share identical background: {s1_bg}")
                    print(f"    Rule: Use different background colors for each slide for best engagement.")
            if len(unique_bgs) > 1:
                print(f"\n🎨 Slide backgrounds verified: {len(unique_bgs)} distinct background styles across {len(backgrounds)} slides.")

    print(f"\n{'─'*60}")
    if all_passed:
        print("\u2705 All slides passed verification. Safe to run export scripts.")
        print("─" * 60)
        sys.exit(0)
    else:
        print("\u274c Verification FAILED. Fix the issues above before exporting.")
        print("   Do NOT run export-carousel-all.zsh until all slides pass.")
        print("─" * 60)
        sys.exit(1)


if __name__ == "__main__":
    main()
