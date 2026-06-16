# content-pipeline

Transform one idea into a complete multi-platform content package: a high-engagement LinkedIn post, a 1200×627 cover image, a casual Skool community post, and a premium Instagram/LinkedIn carousel — all from a single input.

This skill merges previously-separate Gemini gems into one sequential pipeline:

1. **LinkedIn Article Generator** → writes the post
2. **LinkedIn Cover Image Generator** → designs the visual
3. **Skool Post Converter** → reshapes the post for the community
4. **`/carousel-creator`** (delegated via subagent) → builds the premium carousel + exports

Run all four in one shot. One topic in, one folder out, no permission prompts between stages.

---

## Use Cases

- "I have an idea — turn it into a full content package"
- "Repurpose this for LinkedIn and Skool"
- "Run the content pipeline on [topic]"
- "Save me from writing the same thing three times"
- "Create today's post package"

---

## Output

Saved to a date-wise folder in the current directory. All four stages land in the same `YYYYMMDD-HHMM/` folder — Stage 4 reconciles any timestamp drift automatically.

```
YYYYMMDD-HHMM/
├── linkedin-post.md         # Title + hook + body + CTAs + hashtags (copy-paste ready)
├── cover.svg                # 1200×627 LinkedIn cover (1.91:1, central safe zone)
├── cover-prompt.md          # Detailed prompt for Midjourney / DALL-E / Flux
├── skool-post.md            # Casual, peer-to-peer Skool post (no hashtags, bolded closing question)
├── slides/                  # Carousel SVG slides (one per file)
│   ├── {slug}-slide-1.svg
│   └── ...
├── caption.md               # Carousel caption (also a bonus LinkedIn post variant)
├── {slug}.pdf               # Multi-page PDF export
├── {slug}.mp4               # 5s/slide MP4 slideshow
└── {slug}-hyperframes.mp4   # Ken Burns + cross-dissolve cinematic MP4
```

| File | What it is | What to do with it |
|---|---|---|
| `linkedin-post.md` | The full LinkedIn post (title + caption + content + CTAs + hashtags) | Copy-paste into LinkedIn |
| `cover.svg` | 1200×627 cover image with the core insight as hero text | Open in browser or import into Figma / Canva |
| `cover-prompt.md` | Detailed AI-image prompt with specs and a do-not-include list | Paste into Midjourney / DALL-E for a higher-fidelity raster |
| `skool-post.md` | Casual 30–40% shorter post, no hashtags, bolded closing question | Drop into the Practical AI Skool community |
| `slides/{slug}-slide-*.svg` | Individual premium SVG slides (≥5) | Upload as a carousel to Instagram or LinkedIn |
| `caption.md` | Carousel caption from `/carousel-creator` | Use as the post text when uploading the carousel |
| `{slug}.pdf` | Multi-page PDF of all slides | Share or print |
| `{slug}.mp4` | MP4 slideshow, 5 s/slide | Upload as video carousel or Reel |
| `{slug}-hyperframes.mp4` | Ken Burns + cross-dissolve cinematic MP4 | Upload to Reels / TikTok / YouTube Shorts |

---

## How It Works

```
[Topic / Idea / Key Points]
            │
            ▼
   Stage 1: LinkedIn Post
   • Hook (under 8 words) + re-hook
   • Body with single clear takeaway
   • Soft CTA + ♻️ Repost + ➕ Follow Deven
   • 3–5 hashtags
            │
            ▼
   Stage 2: Cover Image
   • Extracts core insight from Stage 1
   • Builds 1200×627 SVG with central safe zone
   • Writes companion prompt for AI image tools
            │
            ▼
   Stage 3: Skool Post
   • Strips LinkedIn-isms
   • Cuts length 30–40%
   • Reframes as peer-to-peer
   • Ends with bolded open-ended question
            │
            ▼
   Stage 4: Carousel (delegated to /carousel-creator via subagent)
   • Pre-collected intake (no re-prompting)
   • Premium SVG slides (≥5)
   • Caption + PDF + MP4 + Hyperframes MP4
   • Subagent reconciles timestamp drift so all files
     land in the same folder as Stages 1–3
            │
            ▼
   [Four deliverables, one input, one folder]
```

Each stage hands off to the next:

| Stage | Reads | Writes |
|---|---|---|
| 1. LinkedIn | `topic`, `key points`, `tone` | `linkedin-post.md` |
| 2. Cover | `linkedin-post.md` | `cover.svg`, `cover-prompt.md` |
| 3. Skool | `linkedin-post.md` | `skool-post.md` |
| 4. Carousel | pre-collected intake + parent folder `{TS}/` | `slides/`, `caption.md`, `.pdf`, `.mp4`, `-hyperframes.mp4` (all in `{TS}/`) |

---

## Voice and Tone

**LinkedIn stage** — Professional, peer-to-peer, human. Optimized for mobile readability, scroll-stopping hooks, and engagement-driven CTAs. The three CTA blocks (soft CTA + Repost + Follow) all match the article's tone (urgent / educational / inspirational).

**Skool stage** — Casual, curious, genuinely helpful. Strips humble-brags, "thought leadership" framing, and all hashtags. Reframes tools and tips as "here's what worked for me." Ends with one bolded open-ended question to spark discussion.

**Cover stage** — Visual reinforcement only. No author photo, no AI tool branding. Core insight as the hero text, with `@devengoratela` subtly placed in a corner.

**Carousel stage** — Handled entirely by `/carousel-creator` (delegated via subagent). Produces a premium 5–10 slide carousel following its own design system: hook → context → value → breakdown → summary → CTA, with consistent branding and a strong first slide. The subagent runs the skill in a clean context with pre-collected intake, so the user is never asked the same question twice.

---

## Trigger Phrases

- "Run the content pipeline on [topic]"
- "Create a LinkedIn + Skool package for [idea]"
- "Repurpose this for LinkedIn and Skool"
- "Make a content package about [topic]"
- "Turn this into a full post package"
- "Today's post package: [topic]"

---

## Files

```
content-pipeline/
├── SKILL.md       # Main skill instructions (4-stage workflow + carousel delegation + quality checklist)
└── README.md      # This file
```

---

## Examples

### Example input

> Topic: "I started using Claude Code with the worktree + plan workflow and it cut my bug-fixing time in half."
> Key points:
> - worktree isolates changes per task
> - plan mode forces me to think before code
> - 3 tasks in parallel = no context loss
> Tone: educational

### Example outputs (abbreviated)

**`linkedin-post.md`:**

```markdown
# My Bug-Fix Workflow Halved My Time 🪛

---

I tried Claude Code's worktree mode last week.
I shipped three bug fixes in one afternoon.

The setup is simple...

♻️ Repost if you're drowning in bug tickets.
➕ Follow Deven Goratela for AI workflows that actually save hours.

#AI #ClaudeCode #DeveloperProductivity #Automation
```

**`cover.svg`:** 1200×627 dark-mode infographic with "Cut bug-fix time in half" as the hero, "Claude Code Workflow" as the category tag, and `@devengoratela` in the corner.

**`cover-prompt.md`:** A ready-to-paste Midjourney / DALL-E prompt with full specs and a do-not-include list.

**`skool-post.md`:**

```markdown
# Claude Code worktree mode cut my bug-fix time in half

Been using the worktree + plan workflow in **Claude Code** for a week now.

Three things happened:
- Worktrees isolate each task — no more context bleed
- Plan mode forces me to think before code
- I shipped 3 fixes in one afternoon without losing my place

If you haven't tried `claude --worktree` yet, start there.

**What's the slowest part of your dev loop right now?**
```

**Carousel outputs** (from `/carousel-creator` via subagent):

```
slides/
├── claude-code-worktree-slide-1.svg   # Hook: "Cut bug-fix time in half"
├── claude-code-worktree-slide-2.svg   # Context: why worktrees matter
├── claude-code-worktree-slide-3.svg   # Value: 3 things that happened
├── claude-code-worktree-slide-4.svg   # Breakdown: how to set up
├── claude-code-worktree-slide-5.svg   # Summary
└── claude-code-worktree-slide-6.svg   # CTA: Follow @devengoratela
caption.md                              # Carousel caption
claude-code-worktree.pdf                # Multi-page PDF
claude-code-worktree.mp4                # 5s/slide slideshow
claude-code-worktree-hyperframes.mp4   # Cinematic Ken Burns
```

---

## See Also

- [carousel-creator](../carousel-creator/) — Premium Instagram/LinkedIn carousels as SVG slides
- [excalidraw-diagram](../excalidraw-diagram/) — Editable diagrams from natural language
- [skill-builder](../skill-builder/) — Build and audit your own Claude Code skills
