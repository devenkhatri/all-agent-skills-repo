# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A collection of Claude Code skills installable via `npx skills add devenkhatri/all-agent-skills-repo`. Each skill lives in its own subdirectory containing `SKILL.md` (the main instructions) and optional reference files.

## Installing Skills

```bash
# Install all skills
npx skills add devenkhatri/all-agent-skills-repo

# Install a single skill
npx skills add devenkhatri/all-agent-skills-repo/<skill-name>
```

## Available Skills

| Slash Command | Trigger |
|---|---|
| `/carousel-creator` | "Create a carousel about..." / "Make an Instagram carousel" |
| `/codebase-to-course` | "Turn this into a course" / "Teach me how this code works" |
| `/codebase-to-demo` | "Create a demo for this" / "Make a pitch deck from this codebase" |
| `/content-pipeline` | "Run the content pipeline on..." / "Create a LinkedIn + Skool package" / "Repurpose for LinkedIn and Skool" |
| `/excalidraw-diagram` | "Draw a diagram of..." / Default for all diagram requests |
| `/frontend-slides` | "Create a presentation" / "Make slides" |
| `/skill-builder` | "Help me build a skill" / "Audit this skill" |
| `/remotion-generator` | "Generate a video" / "Create a video" / "Generate remotion" |
| `/visa-validator` | "Scan visa documents, validate against country checklists, perform gap analysis, and generate approval probability scores" |

## Skill Architecture

Every skill follows this structure:
```
<skill-name>/
├── SKILL.md          # Required: frontmatter + instructions
├── README.md         # Optional: human-facing docs
└── references/       # Optional: supporting files loaded on-demand
    ├── design-system.md
    └── interactive-elements.md
```

**Frontmatter fields in SKILL.md** (YAML block at top):
- `name` — matches directory name, becomes the `/slash-command`
- `description` — controls when Claude auto-invokes the skill; write as "Use when someone asks to [action]..."
- `disable-model-invocation: true` — set for skills with side effects (file generation, API calls)
- `argument-hint`, `context`, `model`, `allowed-tools` — set only when needed

Supporting reference files are **not loaded automatically** — they load only when explicitly referenced from the workflow steps in SKILL.md.

## Skill-Specific Notes

### carousel-creator
- Output: SVG files (1080×1350px, 4:5 ratio) saved to `YYYYMMDD-HHMM/slides/` with a `caption.md`
- CTAs must include "Follow @devengoratela for more"
- Minimum 5 slides; SVG output only — no HTML/CSS/JS wrappers

### codebase-to-demo / codebase-to-course
- Output: single self-contained HTML file (inline CSS/JS, no dependencies except Google Fonts)
- Both skills use the same reference file pattern: `references/design-system.md` and `references/interactive-elements.md`
- `codebase-to-demo` uses Playwright to capture real app screenshots and embeds them as base64; it also calculates API costs in INR (₹) with USD toggle
- `codebase-to-course` targets "vibe coders" (non-CS background); `codebase-to-demo` targets non-technical buyers

### frontend-slides
- Every slide **must** fit in 100vh — never scroll within a slide
- Always read `viewport-base.css` and include its full contents in every generated presentation
- Use `clamp()` for all font sizes and spacing — never fixed px/rem
- Helper scripts: `scripts/extract-pptx.py` (PPTX → content), `scripts/export-pdf.sh`, `scripts/deploy.sh`

### skill-builder
- Runs a 6-round Discovery Interview before writing any files
- See `skill-builder/reference.md` for full frontmatter field reference and advanced patterns
- SKILL.md files should stay under 500 lines; move detailed reference material to supporting files

### remotion-generator
- Checks and installs dependencies (Remotion CLI, FFmpeg) if needed
- Creates Remotion project with YouTube-ready settings (1080p, 60fps, high bitrate)
- Uses reference files: `references/design-system.md` for visual styling, `references/script-format.md` for input format
- Output: MP4 file in current directory with timestamp prefix

### content-pipeline
- Merges the LinkedIn writer + cover image + Skool converter gems with `/carousel-creator` into one 4-stage pipeline
- Runs all four stages from a single topic input — no permission prompt between stages
- Stage 1 outputs `linkedin-post.md` (copy-paste ready, includes ♻️ Repost + ➕ Follow Deven Goratela)
- Stage 2 outputs `cover.svg` (1200×627, central safe zone) + `cover-prompt.md` (for Midjourney/DALL-E)
- Stage 3 outputs `skool-post.md` (30–40% shorter, casual peer tone, no hashtags, bolded closing question)
- Stage 4 delegates to `/carousel-creator` via a subagent — pre-collected intake prevents re-prompting; subagent reconciles timestamp drift so all files land in the same `YYYYMMDD-HHMM/` folder as Stages 1–3
- CTA tone (urgent/educational/inspirational) is inferred from the topic and applied consistently across all four stages

## Output Conventions

- `carousel-creator` → `YYYYMMDD-HHMM/` in current directory
- `codebase-to-demo` → `<project-name>-demo.html` in current directory
- `codebase-to-course` → `<project-name>-course.html` in current directory
- `content-pipeline` → `YYYYMMDD-HHMM/` in current directory with `linkedin-post.md`, `cover.svg`, `cover-prompt.md`, `skool-post.md`, plus `slides/`, `caption.md`, and carousel exports (`.pdf`, `.mp4`, `-hyperframes.mp4`) from Stage 4
- `frontend-slides` → single `.html` file in current directory
- `excalidraw-diagram` → `.excalidraw` file in current directory
- `remotion-generator` → `YYYYMMDD-HHMM-video.mp4` in current directory
