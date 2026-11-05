# Carousel Creator

Create premium, polished Instagram and LinkedIn carousel posts as individual SVG slides. Generate swipe-worthy, visually striking carousels that feel designed by a top-tier social media agency.

## When to Use This Skill

Trigger this skill when users want to create:
- Instagram carousel posts (4:5 portrait — 1080 × 1350 px)
- LinkedIn carousel content (1:1 square — 1080 × 1080 px)
- Educational carousels
- Brand-aware social media content
- Carousel slides from any topic, niche, or concept

## Output

**Individual SVG slides** per platform:

| Platform | Canvas Size | Aspect Ratio |
|----------|-------------|---------------|
| Instagram | 1080 × 1350 px | 4:5 portrait |
| LinkedIn | 1080 × 1080 px | 1:1 square |

- Minimum 5 slides, ideal 5–10 slides

Each SVG is:
- Complete and self-contained
- Visually clean and renderable
- Mobile-readable with proper typography hierarchy

Additionally, the skill produces **multi-format exports**:
- High-res multi-page PDF (`.pdf`)
- Standard MP4 slideshow (`.mp4`)
- Cinematic Hyperframes MP4 (`-hyperframes.mp4`) featuring Ken Burns transitions, dynamic motion graphics, proper captions, copyright-free B-roll, and ElevenLabs cloned voiceover

## What This Skill Does

1. **Runs intake** — Collects topic, platform, audience, handle, brand colors, tone, and optional video input
2. **Pre-Edit Video Review ("Watch Before You Edit")** — When input is a video: watches and inspects the entire video end-to-end first, delivering an editorial critique on hook, pacing, dead air, and visual gaps before editing
3. **Analyzes the topic** — Understands the niche, audience, and content goals
4. **Creates strategic flow** — Hook → Context → Value → Breakdown → Summary → CTA
5. **Designs premium slides** — Clean layouts, strong typography, intentional colors with a unique background per slide
6. **Generates SVG output** — Raw SVG code for each slide (no HTML/CSS)
7. **Integrates branding** — Uses brand colors, logos, handles if provided
8. **Enriches Hyperframes video** — Adds dynamic motion graphics (top progress bar, slide counter badges, callout cards), proper high-contrast captions with keyword highlighting, relevant copyright-free B-roll from free internet sources (Pexels, Pixabay, Mixkit, Coverr), and ElevenLabs cloned voiceover
9. **Mixes balanced audio** — Blends the user's latest cloned voice from ElevenLabs with background music kept strictly on low volume so the voice remains clearly audible throughout
10. **Writes caption & hashtags** — Generates a copy-paste-ready post caption saved to `caption.md`

## Key Features

- **Intake Workflow** — Collects platform, audience, handle, brand info, and optional video input
- **Pre-Edit Video Review** — "Before you edit, watch the whole video and tell me what can be done better" — analyzes full timeline before touching edits
- **ElevenLabs Cloned Voiceover** — Generates voiceover using user's latest cloned voice from ElevenLabs with background music kept at low volume so speech is clearly audible
- **Motion Graphics** — Top progress bar, animated slide counter badges, card pop-ins, and smooth GSAP choreography
- **Proper Captions** — Frosted glass translucent pill, high contrast for sound-off mobile viewers, active keyword highlighting, and safe margins
- **Copyright-Free B-Roll** — Curates and integrates free, watermark-free B-roll from Pexels, Pixabay, Mixkit, and Coverr to break talking-head monotony
- **Platform-Aware** — Correct canvas size for Instagram (4:5) or LinkedIn (1:1)
- **Unique Background Per Slide** — Always uses a different background color for each slide from a harmonious tonal palette to keep swiping visually dynamic
- **Video Input Support** — When source input is a video, extracts and embeds relevant face-free screenshots (UI, diagrams, workflows, code)
- **Constant Hyperframes Pacing** — Hyperframes MP4 video maintains a steady, readable pace (5.0s per slide default) regardless of slide count (never sped up when there are more slides)
- **Hook-First Design** — First slide uses proven hook formulas to stop scroll
- **Strategic Content Flow** — Maximizes retention, saves, and shares
- **Mobile-Optimized** — Readable on small screens, fast scanning
- **Brand Integration** — Subtle, premium branding with user's handle
- **Consistent System** — All slides feel like one cohesive carousel
- **CTA-Driven** — Final slide drives Follow, Save, and Share
- **Caption & Hashtags** — Generates a ready-to-post caption saved to `caption.md`

## Trigger Phrases

- "Create a carousel about..."
- "Make an Instagram carousel for..."
- "Design a carousel for LinkedIn"
- "Create swipe-worthy content"
- "Make a carousel post"
- "Generate social media carousel"

## Example Input

User provides:
- Topic: "5 AI Tools That Will Transform Your Content Creation"
- Audience: Content creators, marketers
- Brand colors: #FF6B35 (orange), #1A1A2E (dark blue)

Skill outputs:
- 7-8 SVG slides
- Hook slide with bold headline
- Context slide on why it matters
- Main value slides with tool breakdowns
- Summary slide with key takeaways
- CTA slide (Save, Follow, Share)

## Output Structure

Every run creates a date-stamped folder:

```
YYYYMMDD-HHMM/
├── assets/                         ← Extracted media assets (when video input or enriched)
│   ├── screenshot-1.png            ← Face-free video screenshots
│   ├── voiceover.mp3               ← User's latest cloned voiceover from ElevenLabs
│   ├── broll/                      ← Free, copyright-free B-roll clips from the internet
│   │   ├── broll-1.mp4
│   │   └── ...
│   └── review/                     ← Pre-edit timeline thumbnails & contact sheets
├── slides/
│   ├── {topic-slug}-slide-1.svg   ← Hook slide (unique background)
│   ├── {topic-slug}-slide-2.svg   ← Context (different background)
│   └── ...                        ← Value, breakdown, CTA (all unique backgrounds)
├── caption.md                     ← Copy-paste-ready post caption + hashtags
├── captions.json                  ← Synchronized captions with active word highlighting
├── credits.md                     ← Copyright-free B-roll source log & attribution
├── {topic-slug}.pdf               ← Multi-page PDF export
├── {topic-slug}.mp4               ← MP4 slideshow export
└── {topic-slug}-hyperframes.mp4  ← Cinematic Hyperframes export with motion graphics, captions, B-roll & voiceover
```

Open any `.svg` file in a browser to preview. Convert to PNG/JPG for posting.

## Files

```
carousel-creator/
├── SKILL.md                        # Main skill instructions
├── README.md                       # This file
└── references/
    ├── design-system.md            # Typography, colors, layout, brand identity
    ├── content-strategy.md         # Writing rules, CTAs, caption & hashtag format
    └── svg-templates.md            # SVG structure, layout patterns, reusable snippets
```

## What Makes This Different

This skill generates **actual SVG code** that can be:
- Opened in any browser to view
- Imported into design tools
- Converted to PNG/JPG for posting
- Directly used on social platforms

It does NOT output:
- HTML or CSS layouts
- React components
- Website mockups
- Markdown descriptions

Only polished, renderable SVG slides.