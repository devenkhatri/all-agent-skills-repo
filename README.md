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
| [generate-video](#generate-video) | Convert text, HTML, YouTube URLs, PDFs, or images into automated video sequences using the Hyperframes framework |
| [pptx-custom](#pptx-custom) | Create high-quality presentations in two modes: Academic (conference talks, thesis defenses, grant briefings) and Corporate (proposals, sales pitches, strategy decks, executive briefings) |
| [short-form-studio](#short-form-studio) | Run the end-to-end production loop for a short-form talking-head video (YouTube Shorts, Reels, TikTok) built with Hyperframes |
| [skill-builder](#skill-builder) | Create new skills, optimize existing skills, or audit skill quality following Claude Code best practices |
| [ui-ux-auditor](#ui-ux-auditor) | Perform a thorough, structured UI/UX audit of an application from video recordings, URLs, or screenshots — produces a scored, actionable report |
| [visa-doc-translate](#visa-doc-translate) | Translate visa application documents (images) to English and create a bilingual PDF with original and translation |
| [visa-validator](#visa-validator) | Scan a folder of visa documents, validate against country checklists, perform gap analysis, and generate an approval probability score |

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

#### Generate Video

```bash
npx skills add devenkhatri/all-agent-skills-repo/generate-video
```

#### PPTX Custom

```bash
npx skills add devenkhatri/all-agent-skills-repo/pptx-custom
```

#### Short-Form Studio

```bash
npx skills add devenkhatri/all-agent-skills-repo/short-form-studio
```

#### Skill Builder

```bash
npx skills add devenkhatri/all-agent-skills-repo/skill-builder
```

#### UI/UX Auditor

```bash
npx skills add devenkhatri/all-agent-skills-repo/ui-ux-auditor
```

#### Visa Doc Translate

```bash
npx skills add devenkhatri/all-agent-skills-repo/visa-doc-translate
```

#### Visa Validator

```bash
npx skills add devenkhatri/all-agent-skills-repo/visa-validator
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

### generate-video

Convert multimodal inputs — HTML files, raw text, YouTube URLs, PDFs, or images — into an automated video sequence using the local Hyperframes framework. This skill orchestrates data extraction, script generation, and programmatic video rendering.

**Supported Inputs:**
- Local file paths (HTML, PDF, PNG, JPG, etc.)
- Raw text strings
- YouTube URLs
- Web/article URLs

**Workflow:**
1. Ingest and normalize the input (extract narrative text from any source)
2. Clarify target format, visual tone, pacing, and any content gaps with the user
3. Map content into a 5–10 scene storyboard (Hook → Core Value → CTA)
4. Apply a clean minimalist aesthetic (deep slate bg, white text, GSAP animations)
5. Write the scene JSON config and hand off to Hyperframes CLI for rendering
6. Verify output and deliver the final `.mp4`

**Key Features:**
- Supports vertical (9:16) and landscape (16:9) output
- Zero-guessing policy — always asks before assuming dimensions or tone
- Scene count capped at 15 for reliable rendering
- No placeholder content: stops and asks if source extraction fails

**Trigger Phrases:**
- "Create a video from this"
- "Generate a Hyperframes video"
- "Turn this [URL / PDF / image] into a video"

**Files:**
```
generate-video/
└── SKILL.md  # Main skill instructions
```

---

### pptx-custom

Create high-quality `.pptx` presentations in two modes — **Academic** and **Corporate** — with content, narrative structure, and design standards tailored to each context. Works alongside Anthropic's built-in PPTX skill (which handles file generation); this skill governs everything above the technical layer.

**Modes:**

**🎓 Academic Mode** — for conference papers, seminar talks, thesis defenses, grant briefings, and lab presentations:
- Every slide title is an **action title** (complete sentence stating the takeaway)
- Deck structured as a logical argument using SCR or funnel frameworks
- Ghost deck test: action titles alone must tell the full story
- One exhibit per results slide, key finding annotated on the chart
- Citation standards enforced; References slide always included
- Communication-first design: white background, single font, max 3 colors

**🏢 Corporate Mode** — for solution proposals, sales pitches, strategy decks, executive briefings, QBRs, and capability showcases:
- **Always asks for client brand color** before building
- **Proposes 2–3 structure options** and lets you choose before creating slides
- Auto-selects visual style (Premium/dark, Clean Corporate, or McKinsey analytical) based on deck type and audience
- Every slide title is a **business headline** (outcome, recommendation, or insight)
- Always includes Executive Summary, Next Steps/CTA (specific + time-bound), and Appendix
- Key exhibits covered: architecture diagrams, timelines with responsibility splits, case studies with quantified outcomes
- Named client context retained across the session

**Trigger Phrases:**
- "Make slides for my conference paper on X" *(Academic)*
- "Build a deck for my thesis defense" *(Academic)*
- "Create a solution proposal for [Client]" *(Corporate)*
- "Build a sales pitch deck for [market]" *(Corporate)*
- "Make a strategy deck for our Q3 roadmap" *(Corporate)*
- "Put together an executive briefing on [topic]" *(Corporate)*

**Files:**
```
pptx-custom/
├── SKILL.md                  # Entry point: mode detection, routing logic, design systems
├── content_guidelines.md     # Academic + Corporate content and narrative guidelines
├── slide_patterns.md         # Per-slide-type PptxGenJS implementation patterns
└── README.md                 # Documentation
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

### ui-ux-auditor

Perform a thorough, structured UI/UX audit of any application. Accepts video recordings, YouTube URLs, live web URLs, or a set of screenshots — and produces a scored, actionable report covering 11 audit dimensions.

**Target Audience:** Founders, product teams, and designers who want an expert pre-launch review or design critique.

**Output:** A structured markdown audit report (`ui_ux_audit_report.md`) covering:
- Overall readiness score, UX score, UI polish score, and Trust score (each out of 10)
- Launch recommendation: **Launch / Launch with fixes / Do not launch yet**
- Top 5–10 critical issues with severity, evidence, and actionable fixes
- 11 detailed audit dimensions: First Impression, Navigation & IA, Core User Flows, UI Design, Usability Heuristics (Nielsen's 10), Accessibility, Feedback & States, Mobile/Responsiveness, Trust & Credibility, Product & Business Risk, QA Launch Blockers
- Prioritized fix list: 🔴 Must Fix Now / 🟡 Should Fix Soon / 🟢 Can Improve Later
- Final verdict with top 3 highest-impact improvements

**Supported Inputs:**
- Video file (mp4, webm, mov) — analyzed frame-by-frame
- YouTube URL — navigated and screenshotted via browser
- Live web URL — fully explored (all pages, forms, CTAs, mobile view)
- Zip file or individual screenshots

**Trigger Phrases:**
- "Audit this app: [URL]"
- "Pre-launch UX review"
- "Design critique for my app"
- "Here's a Loom video — can you audit it?"
- "Review the UX from these screenshots"
- "Usability report"

**Files:**
```
ui-ux-auditor/
└── SKILL.md  # Main skill instructions (11-dimension audit framework + scoring rubric)
```

---

### visa-doc-translate

Translate visa application documents (images) to English and generate a professional bilingual PDF — original document on page 1, English translation on page 2. Designed for Australian, US, Canadian, UK, and other visa applications.

**Supported Document Types:**
- Bank deposit certificates (存款证明)
- Income and employment certificates
- Retirement certificates
- Property certificates
- Business licenses
- ID cards and passports
- Other official documents

**Workflow (fully automatic — no confirmation prompts):**
1. Convert HEIC images to PNG if needed
2. Auto-detect and correct image rotation via EXIF data
3. Extract text using OCR (macOS Vision → EasyOCR → Tesseract, in order)
4. Translate to professional English, preserving structure, numbers, dates, and amounts
5. Generate a PDF: page 1 = original image, page 2 = formatted English translation
6. Output as `<original_filename>_Translated.pdf`

**Trigger Phrases:**
- `/visa-doc-translate RetirementCertificate.PNG`
- `/visa-doc-translate BankStatement.HEIC`
- "Translate this document for my visa application"

**Files:**
```
visa-doc-translate/
├── SKILL.md    # Main skill instructions
└── README.md   # Documentation
```

---

### visa-validator

Scan a folder of visa documents, validate the full set against a country-specific checklist, perform a gap analysis, and generate a structured report with an approval probability score.

**Key Features:**
- Scans all document files in a specified folder
- Extracts text via OCR (macOS Vision, EasyOCR, Tesseract)
- **PII scrubbing layer** — strips raw passport numbers and sensitive data before any LLM processing
- Validates documents against `/checklists/{country}.json`
- Generates a markdown report with: identified gaps, approval probability score (0–100%), key insights, and recommendations
- Saves report as `visa-review-report-{timestamp}.md`

**Inputs:**
- Folder path containing visa documents
- Target country (for checklist selection)

**Supported formats:** PDF, JPG, PNG, and other common document formats

**Trigger Phrases:**
- "Validate my visa documents for [country]"
- "Scan this folder for my Canada visa application"
- "Check if I have everything for my US visa"

**Files:**
```
visa-validator/
├── SKILL.md              # Main skill instructions
├── checklists/           # Country-specific document checklists (JSON)
├── test_skill.sh         # Test script
└── test_canada_skill.sh  # Canada-specific test script
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
    - `/generate-video` → "Create a video from this [URL / PDF / image]"
    - `/pptx-custom` → "Make slides for my conference paper" / "Create a solution proposal for [Client]"
    - `/short-form-studio` → "Let's make today's short about [topic]"
    - `/skill-builder` → "Help me build a skill"
    - `/ui-ux-auditor` → "Audit this app: [URL]" / "Pre-launch UX review"
    - `/visa-doc-translate` → "Translate this document for my visa application"
    - `/visa-validator` → "Validate my visa documents for [country]"

---

## License

MIT




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


MIT