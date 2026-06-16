# All Agent Skills

A collection of Claude Code skills for various use cases. Install individual skills or add the entire repository.

## Available Skills

| Skill | Description |
|-------|-------------|
| [codebase-to-course](#codebase-to-course) | Transform any codebase into a beautiful, interactive single-page HTML course that teaches how the code works to non-technical people |
| [codebase-to-demo](#codebase-to-demo) | Transform any codebase or automation into a polished, interactive HTML demo deck for non-technical buyers and decision-makers |
| [carousel-creator](#carousel-creator) | Create premium Instagram and LinkedIn carousel posts as SVG slides with swipe-worthy design |
| [content-pipeline](#content-pipeline) | Repurpose one idea into a full content package: LinkedIn post, 1200×627 cover image, Skool post, and Instagram/LinkedIn carousel |
| [excalidraw-diagram](#excalidraw-diagram) | Generate Excalidraw diagrams with JSON from natural language descriptions |
| [frontend-slides](#frontend-slides) | Create stunning, animation-rich HTML presentations from scratch or by converting PowerPoint files |
| [short-form-studio](#short-form-studio) | Run the end-to-end production loop for a short-form talking-head video (YouTube Shorts, Reels, TikTok) built with Hyperframes |
| [skill-builder](#skill-builder) | Create new skills, optimize existing skills, or audit skill quality following Claude Code best practices |

---

## Installation

### Add All Skills (Recommended)

```bash
npx skills add devenkhatri/all-agent-skills-repo
```

### Add Individual Skills

#### Codebase-to-Course

```bash
npx skills add devenkhatri/all-agent-skills-repo/codebase-to-course
```

#### Codebase-to-Demo

```bash
npx skills add devenkhatri/all-agent-skills-repo/codebase-to-demo
```

#### Carousel Creator

```bash
npx skills add devenkhatri/all-agent-skills-repo/carousel-creator
```

#### Content Pipeline

```bash
npx skills add devenkhatri/all-agent-skills-repo/content-pipeline
```

#### Excalidraw Diagram

```bash
npx skills add devenkhatri/all-agent-skills-repo/excalidraw-diagram
```

#### Frontend Slides

```bash
npx skills add devenkhatri/all-agent-skills-repo/frontend-slides
```

#### Short-Form Studio

```bash
npx skills add devenkhatri/all-agent-skills-repo/short-form-studio
```

#### Skill Builder

```bash
npx skills add devenkhatri/all-agent-skills-repo/skill-builder
```

---

## Skill Details

### codebase-to-course

Transform any codebase into a stunning, interactive single-page HTML course that teaches how the code works through scroll-based modules, animated visualizations, and plain-English translations of code.

**Target Audience:** "Vibe coders" — people who build software using AI coding tools without a traditional CS education.

**Output:** A single self-contained HTML file (no dependencies except Google Fonts) that teaches code through:
- Scroll-based modules with progress tracking
- Code ↔ Plain English translations (real code on the left, explanation on the right)
- Animated visualizations (data flow, group chat between components)
- Glossary tooltips on technical terms

**Trigger Phrases:**
- "Turn this into a course"
- "Explain this codebase interactively"
- "Make a course from this project"
- "Teach me how this code works"
- "Interactive tutorial from this code"

**Files:**
```
codebase-to-course/
├── SKILL.md                    # Main skill instructions
├── README.md                   # Documentation
└── references/
    ├── design-system.md        # CSS tokens, typography, colors
    └── interactive-elements.md # Animation & visualization patterns
```

---

### codebase-to-demo

Transform any codebase or automation implementation into a compelling, interactive single-page HTML demo deck for non-technical buyers and decision-makers. The output sells the *value* through animated architecture diagrams, before/after comparisons, sequence walkthroughs, and a business-first narrative.

**Target Audience:** Non-technical buyers, business owners, executives evaluating implementations.

**Output:** A single self-contained HTML file that includes:
- **Hook slide** (Module 0) — two-line full-screen ice-breaker that opens the presentation with a punchy, specific pain statement and outcome tease
- Before/After Toggle (visceral comparison of manual vs automated processes)
- Clickable Architecture Map (SVG diagram with component details)
- Sequence Diagram (step-by-step animated workflow trace)
- "What Would Break If" Explorer (resilience and failure handling)
- Integration Map (hub-and-spoke layout showing connections)
- Tech Stack Justification cards with business reasons
- Deployment & Scaling Notes with **calculated API costs in INR (₹) with USD toggle**
- **Screenshots Gallery** (Module 8.5) — 3-6 real app and code screenshots captured via Playwright, embedded as base64, with lightbox and plain-language captions

**Key Features:**
- Hook ice-breaker generated from real Phase 1 analysis — specific costs, specific outcomes, not vague hype
- Playwright-powered screenshot capture: starts the app locally, captures real UI screens and code, embeds them as base64 in the HTML
- Web search to calculate real API execution costs based on the codebase
- Per-API cost breakdown displayed in Indian Rupee (₹) with Indian number formatting
- Currency toggle to switch between INR and USD views (defaults to INR)
- Live USD→INR conversion rate with 2.5% service levy
- Rate source attribution displayed in the cost section

**Trigger Phrases:**
- "Create a demo for this"
- "Make a pitch deck from this codebase"
- "Show this to a client"
- "Explain this implementation to a non-technical audience"
- "Demo deck"
- "Showcase this automation"
- "Create a client presentation from this project"

**Files:**
```
codebase-to-demo/
├── SKILL.md                    # Main skill instructions
├── README.md                   # Documentation
└── references/
    ├── design-system.md        # CSS tokens, typography, colors
    └── interactive-elements.md # Animation & visualization patterns
```

---

### carousel-creator

Create premium, polished Instagram and LinkedIn carousel posts as individual SVG slides. Generate swipe-worthy, visually striking carousels that feel designed by a top-tier social media agency.

**Target Audience:** Content creators, marketers, business owners, personal brands.

**Output:** Individual SVG slides optimized for Instagram/LinkedIn:
- Aspect Ratio: 4:5
- Canvas Size: 1080 × 1350 px
- Minimum 5 slides, ideal 5-10 slides
- Fully renderable, mobile-readable SVG code

**Key Features:**
- Strategic content flow: Hook → Context → Value → Breakdown → Summary → CTA
- Strong first slide (stops scroll, creates curiosity)
- Clean typography with visual hierarchy
- Brand integration support (colors, logo, handle)
- CTA always includes "Follow @devengoratela for more"
- Consistent design across all slides (one cohesive system)
- SVG output only (no HTML/CSS/JS)
- **Caption & hashtag generation** with optimization for engagement
- **Auto-save to date-wise folder (YYYYMMDD-HHMM)**

**Caption Optimization:**
- Hook: Under 8 words to avoid mobile truncation
- Re-Hook: Punchy second line to keep reading
- Hashtags: 3-5 relevant, specific hashtags
- Saved to `{YYYYMMDD-HHMM}/caption.md`

**Output Structure:**
```
20260406-1430/
├── slides/
│   ├── {topic}-slide-1.svg
│   ├── {topic}-slide-2.svg
│   └── ...
└── caption.md
```

**Content Strategy:**
- Hook slide: Bold, premium, curiosity-driven
- Context slide: Why it matters to the audience
- Main value slides: Core content delivery
- Breakdown slides: Tips, steps, frameworks
- Summary slide: Key takeaways
- CTA slide: Follow, save, share

**Trigger Phrases:**
- "Create a carousel about..."
- "Make an Instagram carousel for..."
- "Design a carousel for LinkedIn"
- "Create swipe-worthy content"
- "Make a carousel post"

**Files:**
```
carousel-creator/
├── SKILL.md    # Main skill instructions
└── README.md   # Documentation
```

---

### content-pipeline

Transform one idea into a complete multi-platform content package — a high-engagement LinkedIn post, a 1200×627 cover image, a casual Skool community post, and a premium Instagram/LinkedIn carousel — all from a single input, in one folder. This skill merges previously-separate Gemini gems (LinkedIn writer, cover image generator, Skool converter) with `/carousel-creator` into one sequential pipeline.

**Target Audience:** Creators, personal brands, and community operators who publish the same idea across LinkedIn and a Skool community and want to stop writing the same thing three times.

**Output:** A date-wise folder (`YYYYMMDD-HHMM/`) with all four stages' deliverables:

| File | Stage | Purpose |
|---|---|---|
| `linkedin-post.md` | 1 | Full LinkedIn post (title + hook + body + CTAs + hashtags) — copy-paste ready |
| `cover.svg` | 2 | 1200×627 LinkedIn cover image with central safe zone and core insight as hero text |
| `cover-prompt.md` | 2 | Detailed AI-image prompt for Midjourney / DALL-E / Flux (upgrade path beyond SVG) |
| `skool-post.md` | 3 | Casual 30–40% shorter Skool post, no hashtags, bolded closing question |
| `slides/{slug}-slide-*.svg` | 4 | Individual premium SVG carousel slides (≥5) |
| `caption.md` | 4 | Carousel caption (bonus LinkedIn post variant) |
| `{slug}.pdf` | 4 | Multi-page PDF of all slides |
| `{slug}.mp4` | 4 | 5s/slide MP4 slideshow |
| `{slug}-hyperframes.mp4` | 4 | Ken Burns + cross-dissolve cinematic MP4 |

**Key Features:**

- **Four-stage pipeline** — LinkedIn → cover → Skool → carousel. No permission prompt between stages.
- **Tone inference** — Detects urgent / educational / inspirational and applies the right CTA voice across all four stages.
- **Copy-paste ready output** — LinkedIn post has hook under 8 words, ♻️ Repost + ➕ Follow Deven Goratela, 3–5 hashtags, no bold in the body.
- **Cover safety** — All critical content sits in the center 1000×500 px safe zone so the image works as both a link preview and an article header.
- **Skool reframe** — Strips LinkedIn-isms, humble-brags, and hashtags. Reframes tools/tips as "here's what worked for me." Ends with one bolded open-ended question.
- **Stage 4 delegation** — A subagent runs `/carousel-creator` with pre-collected intake (no re-prompting), then reconciles timestamp drift so all carousel output lands in the same folder as Stages 1–3.

**Trigger Phrases:**

- "Run the content pipeline on [topic]"
- "Create a LinkedIn + Skool + carousel package for [idea]"
- "Repurpose this for LinkedIn and Skool"
- "Make a content package about [topic]"
- "Turn this into a full post package"
- "Build me a carousel + LinkedIn post for [topic]"

**Files:**
```
content-pipeline/
├── SKILL.md    # Main skill instructions (4-stage workflow + carousel delegation + quality checklist)
└── README.md   # Documentation
```

---

### excalidraw-diagram

Generate Excalidraw diagrams using JSON from natural language descriptions. Default for all diagram requests.

**Use Cases:**
- Architecture diagrams
- Flowcharts
- System diagrams
- Concept visualizations

**Workflow:**
1. Understand the request (ask clarifying questions if needed)
2. Research if needed for technical accuracy
3. Plan the layout mentally
4. Generate JSON elements
5. Save to `.excalidraw` file and provide JSON for copy-paste

**Files:**
```
excalidraw-diagram/
└── SKILL.md  # Main skill instructions
```

---

### frontend-slides

Create zero-dependency, animation-rich HTML presentations that run entirely in the browser. Helps non-designers discover their aesthetic through visual exploration.

**Core Principles:**
- Zero Dependencies — Single HTML files with inline CSS/JS. No npm, no build tools
- Show, Don't Tell — Generate visual previews, not abstract choices
- Distinctive Design — No generic "AI slop" aesthetic
- Viewport Fitting — Every slide MUST fit exactly within 100vh

**Features:**
- Typography with distinctive fonts
- CSS-only animations and micro-interactions
- Layered backgrounds with gradients and patterns
- Responsive design with height breakpoints

**Files:**
```
frontend-slides/
├── SKILL.md              # Main skill instructions
├── viewport-base.css     # Viewport fitting base styles
├── html-template.md      # HTML structure templates
├── animation-patterns.md # Animation examples
├── STYLE_PRESETS.md     # Design presets
└── scripts/             # Helper scripts
```

---

### short-form-studio

Run the end-to-end production loop for a short-form talking-head video (YouTube Shorts, Reels, TikTok) built with Hyperframes. Use this skill whenever the work is scripting, storyboarding, building, or finishing a short, including "let's make today's short", "write a script about this feature", "here's my recorded clip, storyboard it", "what should we put on screen", "build the Hyperframes video", "add the overlays / B-roll / SFX", or "render the final and put it in the folder". It encodes the gated loop (script, you record and cut, storyboard, approval plus assets, Hyperframes build, quiet SFX, render at delivery quality) and the two human approval gates. Do NOT use it to cut raw footage (you cut your own), for generic web or website compositions, or for plain how-to questions.

**The loop:**
```
script (agent) -> record (you) -> cut (you) -> storyboard (agent) -🚦-> assets (you) -> Hyperframes build + quiet SFX + render (agent) -🚦-> deliver to folder
```

**Key Features:**
- Gated production loop with two human approval gates (storyboard and final render)
- You record and cut footage; agent handles script, storyboard, Hyperframes build, and render
- Uses Hyperframes (HTML to video) for overlays and render
- Includes local fallback for cutting footage when explicitly requested
- House style: glass bubbles, serif + grotesque font pairing, one accent color
- SFX kept quiet (whooshes and ambient at 0.05-0.15, accents at or below 0.3)
- Never deletes source cut until delivery confirmed
- High-quality render matching source footage quality

**Trigger Phrases:**
- "Let's make today's short"
- "Write a script about this feature"
- "Here's my recorded clip, storyboard it"
- "What should we put on screen"
- "Build the Hyperframes video"
- "Add the overlays / B-roll / SFX"
- "Render the final and put it in the folder"

**Files:**
```
short-form-studio/
├── SKILL.md                    # Main skill instructions (the gated production loop)
├── README.md                   # Documentation
├── GUIDELINES.md               # Full craft playbook: hooks, length, glass-bubble style, SFX, quality rules
├── edit/                       # Optional local cut tools (whisper + ffmpeg)
└── hf/                         # Hyperframes composition templates
```

---

### skill-builder

Guide for creating new Claude Code skills, optimizing existing skills, or auditing skill quality. Follows official Claude Code best practices.

**Use Cases:**
- Building a new skill from scratch
- Optimizing or auditing an existing skill
- Deciding on advanced features (subagent execution, hooks, dynamic context)
- Troubleshooting skill issues

**Features:**
- Discovery Interview process (6 rounds of questions)
- Frontmatter configuration guide
- Build phase instructions
- Audit checklist for existing skills
- Reference documentation for advanced patterns

**Files:**
```
skill-builder/
├── SKILL.md      # Main skill instructions
├── reference.md  # Technical reference for advanced patterns
└── README.md     # Documentation
```

---

## Quick Start

1. Add skills to your project:
    ```bash
    npx skills add devenkhatri/all-agent-skills-repo
    ```

2. Use a skill by typing its name or trigger phrase:
    - `/codebase-to-course` → "Turn this codebase into a course"
    - `/codebase-to-demo` → "Create a demo for this"
    - `/carousel-creator` → "Create a carousel about..."
    - `/content-pipeline` → "Run the content pipeline on [topic]" / "Build me a carousel + LinkedIn post"
    - `/excalidraw-diagram` → "Draw a diagram of..."
    - `/frontend-slides` → "Create a presentation" or "Make slides"
    - `/short-form-studio` → "Let's make today's short about [topic]"
    - `/skill-builder` → "Help me build a skill"

---

## License

MIT