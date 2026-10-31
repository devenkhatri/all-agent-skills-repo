# Design System Reference

> Load this file when designing SVG slides. It covers typography, color, layout, visual elements, consistency, and brand identity.

---

## Typography Rules

Text hierarchy must clearly separate:

1. **Headlines** — Large, bold, high impact, visually dominant
2. **Subheadings** — Structured, supportive, slightly smaller
3. **Body Text** — Highly readable, clean, easy to scan
4. **Highlight Words** — Selectively emphasized for retention

**Rules:**
- Never overcrowd text
- Never make text too small
- Maintain consistency across all slides
- Optimize for mobile readability
- Use system-safe font families (e.g., `font-family="sans-serif"` or embed a Google Font via `<style>@import url(...)</style>`)

### Recommended Size Scale (1080px canvas)

| Element | Weight | Size Range |
|---------|--------|------------|
| Headline | 700–900 | 64–96px |
| Subheading | 600–700 | 40–56px |
| Body | 400–500 | 28–36px |
| Highlight / Label | 600–700 | 24–32px |
| Caption / Fine Print | 400 | 20–24px |

> For LinkedIn (1080×1080), scale sizes down by ~10–15% to preserve readability at square format.

---

## Color Rules

Use color strategically for hierarchy, contrast, emphasis, branding, readability, and emotional tone.

> [!IMPORTANT]
> **Mandatory Rule: Always Use a Different Background Color for Each Slide**
> Every slide in the carousel MUST have a unique background color or gradient. Never use the same background color across all slides, and never repeat the exact background on consecutive slides.
> 
> **Why:** Top-performing social carousels use slide-by-slide background shifts to provide immediate visual feedback upon swiping, prevent visual fatigue, and keep viewers engaged through to the final CTA.

### Harmonious Background Color Progressions

While each slide must have a different background color, the sequence must belong to a **cohesive, harmonious palette family**. Each slide's background should shift smoothly while preserving high text contrast (minimum 4.5:1 contrast ratio for body text).

#### Multi-Slide Background Palettes by Topic (Up to 8–10 Slides)

| Topic | Slide 1 (Hook) | Slide 2 (Context) | Slide 3 (Value 1) | Slide 4 (Value 2) | Slide 5 (Value 3) | Slide 6 (Breakdown) | Slide 7 (Summary) | Slide 8 (CTA) | Primary Text / Accent |
|-------|----------------|-------------------|-------------------|-------------------|-------------------|---------------------|-------------------|---------------|-----------------------|
| **Tech / AI** | `#0B132B` | `#1C2541` | `#1E293B` | `#0F172A` | `#172554` | `#064E3B` | `#1E1B4B` | `#0A0F1D` | `#FFFFFF` / `#3A86FF` |
| **Business / Productivity** | `#18181B` | `#1A1A2E` | `#27272A` | `#1F2937` | `#111827` | `#2E1065` | `#1E293B` | `#0F172A` | `#F0F0F0` / `#F5A623` |
| **Creator / Personal Brand** | `#2D1B69` | `#1E1B4B` | `#3B0764` | `#18181B` | `#4C1D95` | `#1F1D36` | `#2E1065` | `#1A103C` | `#FAFAFA` / `#FF6B6B` |
| **Health / Wellness** | `#1B4332` | `#132E24` | `#064E3B` | `#1F2937` | `#143628` | `#0F3D2E` | `#1A3326` | `#0D281E` | `#FFFDF7` / `#52B788` |
| **Finance / Professional** | `#002147` | `#0A192F` | `#0F2537` | `#14213D` | `#1A2332` | `#0E1E2E` | `#172A3A` | `#091825` | `#FFFFFF` / `#708090` |
| **Education / Learning** | `#1C2951` | `#1E1B4B` | `#282A36` | `#1A2238` | `#2B2D42` | `#1E293B` | `#242038` | `#16192E` | `#F8F9FA` / `#6C63FF` |

**Gradient Backgrounds:**
If using gradients, ensure each slide's `<linearGradient>` has unique stop colors, for example:
- Slide 1: `#0B132B` → `#1C2541`
- Slide 2: `#1C2541` → `#243356`
- Slide 3: `#1E293B` → `#0F172A`
- Slide 4: `#172554` → `#1E1B4B`
- Slide 5: `#064E3B` → `#0B3B2E`
- Slide 6: `#1E1B4B` → `#2E1065`
- Slide 7: `#18181B` → `#27272A`
- Slide 8 (CTA): `#0A0F1D` → `#1E293B`

**If user provides brand colors:**
- Do not repeat the single primary brand color on every slide background.
- Derive 5–10 distinct harmonious background tones across the brand palette: deep brand shade, midnight brand tint, rich brand slate, dark charcoal tint, contrasting brand accent dark, and deep brand navy.
- Keep the user's explicit brand color for prominent headlines, highlight tags, and CTA buttons across all slides.

**Avoid:**
- Using the same background color on all slides (strictly forbidden)
- Using the same background color on two consecutive slides
- Random discordant rainbow colors that break brand cohesion
- Low-contrast text (maintain minimum 4.5:1 ratio between text and that specific slide's background)

---

## Layout Rules

Prioritize:
- Strong visual hierarchy
- Balanced spacing and clear alignment
- Intentional negative space
- Elegant composition and mobile readability
- Visual breathing room

**Safe Margins:**
- Top margin: 80–120px
- Bottom margin: 80–120px (leave room for brand footer)
- Left/Right padding: 72–96px
- Section spacing: 32–48px between content blocks

**Usable Content Area:**
- Instagram (1080×1350): X 72–1008px × Y 80–1270px
- LinkedIn (1080×1080): X 72–1008px × Y 80–1000px

The design must feel: **modern, polished, premium, professional, social-media optimized.**

---

## Visual Element Rules

Use visual elements only when they improve communication:
- Abstract shapes, cards, highlight containers
- Icon-style symbols built from SVG primitives (no external icon dependencies)
- Dividers, arrows, decorative gradients
- Minimal charts or diagrams if content requires it

**Effective SVG Elements:**

| Element | SVG Tag | Notes |
|---------|---------|-------|
| Highlight box | `<rect rx="16">` | Semi-transparent fill + accent left border |
| Accent line | `<rect width="6">` | Brand color, tall and narrow |
| Number badge | `<circle>` + `<text>` | Centered number, brand color fill |
| Gradient bg | `<linearGradient>` in `<defs>` | Subtle, 2-stop |
| Divider | `<line>` | Low opacity (0.2), full width |
| Rounded card | `<rect rx="20">` | Low opacity fill (0.08–0.12) |

**Every element must feel intentional** — support the message, improve readability, never create clutter.

---

## Consistency Rules

All slides must feel like one cohesive branded system while maintaining visual excitement. Maintain consistency in:
- Cohesive color harmony (each slide has a unique background color, but all backgrounds follow a harmonious tonal palette)
- High contrast and readability across each unique background
- Typography hierarchy, margins, and safe zones
- Visual language, icon style, and layout logic
- Brand placement and design rhythm (footer handle `@devengoratela` consistently placed)
- Corner radius values (pick one standard, e.g., `rx="16"`, and use it throughout)
- Font families and weight pairings

---

## Brand Identity Integration

If the user provides branding materials (logo, handle, colors), integrate them consistently:
- **Footer strip:** Handle at the bottom of every slide
- **Top corner:** Small logo or brand mark (optional)
- **CTA slide:** Prominent handle + call to action

**Footer strip SVG example:**
```xml
<!-- Instagram footer (adjust Y for LinkedIn: y="1030") -->
<rect x="0" y="1300" width="1080" height="50" fill="#0D1B2A"/>
<text x="540" y="1332" font-family="sans-serif" font-size="22"
      font-weight="600" fill="#FFFFFF" text-anchor="middle" opacity="0.85">
  @handle
</text>
```

**Branding should feel:** subtle, premium, clean, intentional. Never overpower the content.
