# content-pipeline

Transform one idea into a complete multi-platform content package: a high-engagement LinkedIn post, a 1200×627 cover image, a casual Skool community post, a premium Instagram/LinkedIn carousel, an Instagram caption, a Twitter thread/post, a YouTube video description, and a Facebook post — all from a single input or by filling missing channels in an existing folder.

This skill merges previously-separate content generators into one unified, sequential pipeline:

1. **LinkedIn Post Generator** → writes a mobile-optimized, high-engagement post (`linkedin-post.md`)
2. **Cover Image Generator** → designs a 1200×627 SVG cover + AI prompt (`cover.svg`, `cover-prompt.md`)
3. **Skool Community Converter** → reshapes the post into a peer-to-peer sharing post (`skool-post.md`)
4. **`/carousel-creator`** (subagent) → builds premium SVG carousel slides and video exports (`slides/`, `caption.md`, `.pdf`, `.mp4`)
5. **Instagram Post Creator** → crafts a high-hook caption with emoji bullets and 10–15 hashtags (`instagram-post.md`)
6. **Twitter / X Writer** → provides a single punchy tweet plus a full numbered thread (`twitter-post.md`)
7. **YouTube Description Optimizer** → packages 3 title options, SEO description, chapter timestamps, and tags (`youtube.md`)
8. **Facebook Community Post** → writes a conversational, storytelling post with discussion CTA (`facebook-post.md`)

Run all stages in one shot. One input in, complete multi-channel deliverables out, no permission prompts between stages.

---

## Key Features

- **Multi-Platform Native Content**: Tailors the tone, structure, hook, and CTAs for each specific platform's algorithm and community norms.
- **Strict Zero Markdown Formatting**: Social platforms (LinkedIn, Instagram, Twitter, Facebook) do not render markdown. Raw markdown characters (`**bold**`, `*italic*`, `### headings`, `[links](url)`, `---`) display as distracting clutter. All generated post files contain **100% clean, copy-paste ready text** using natural spacing, line breaks, and emojis.
- **Folder Continuation Mode**: Pass an existing folder path/name as the argument. The pipeline automatically scans existing files, extracts context, identifies missing channels, and generates only the missing deliverables directly into that folder without overwriting existing files.
- **Automatic Tone Inference**: Detects educational, urgent, or inspirational tone and aligns voice and CTAs across all channels.
- **One Unified Folder**: All deliverables reside in the same target folder (`YYYYMMDD-HHMM/` or the specified existing folder).

---

## Use Cases

- "Run the content pipeline on [topic]"
- "Turn this idea into a full content package for all platforms"
- "Repurpose this for LinkedIn, Instagram, Twitter, YouTube, Facebook, and Skool"
- "Fill missing channels in folder 20261027-1030"
- "I wrote a LinkedIn post in this folder — generate Instagram, Twitter, and YouTube for it"

---

## Output Folder Structure

All deliverables are saved in a unified folder:

```
YYYYMMDD-HHMM/ (or existing folder)
├── linkedin-post.md         # LinkedIn post (hook + body + soft CTA + repost/follow + hashtags)
├── cover.svg                # 1200×627 LinkedIn cover (1.91:1, central safe zone)
├── cover-prompt.md          # Detailed prompt for Midjourney / DALL-E / Flux
├── skool-post.md            # Casual, peer-to-peer Skool post (no hashtags, prominent question)
├── slides/                  # Carousel SVG slides (≥5 slides)
│   ├── {slug}-slide-1.svg
│   └── ...
├── caption.md               # Carousel caption from /carousel-creator
├── {slug}.pdf               # Multi-page PDF export
├── {slug}.mp4               # 5s/slide MP4 slideshow
├── {slug}-hyperframes.mp4   # Ken Burns + cross-dissolve cinematic MP4
├── instagram-post.md        # Instagram caption + emoji bullets + save CTA + 10–15 hashtags
├── twitter-post.md          # Standalone tweet (<280 chars) + full numbered thread (1/ to N/)
├── youtube.md               # 3 title options + SEO description with timestamps + tags
└── facebook-post.md         # Conversational Facebook post + engagement CTA
```

| File | What it is | How to use it |
|---|---|---|
| `linkedin-post.md` | Mobile-optimized LinkedIn post with hook under 8 words, CTAs, and hashtags | Copy-paste directly into LinkedIn feed |
| `cover.svg` | 1200×627 cover image with core insight and safe margins | Open in browser or import into Figma / Canva |
| `cover-prompt.md` | AI-image generator prompt with styles, colors, and constraints | Paste into Midjourney / DALL-E / Flux |
| `skool-post.md` | Casual 30–40% shorter community post with prominent question | Post in Practical AI Skool community |
| `slides/*.svg` | Individual premium SVG carousel slides | Upload as carousel to Instagram / LinkedIn |
| `caption.md` | Caption from `/carousel-creator` | Accompanying carousel post caption |
| `{slug}.pdf` | Multi-page PDF of all slides | Document post on LinkedIn or PDF share |
| `{slug}.mp4` | 5s/slide MP4 slideshow | Video carousel / Reel / Story |
| `{slug}-hyperframes.mp4` | Cinematic Ken Burns video | Reels / TikTok / YouTube Shorts |
| `instagram-post.md` | Instagram feed / Reel caption with clean spacing and hashtags | Copy-paste into Instagram caption |
| `twitter-post.md` | Single tweet variant + numbered multi-tweet thread | Post to Twitter / X |
| `youtube.md` | 3 clickable titles, SEO description, chapter timestamps, and tags | Copy-paste into YouTube Studio metadata |
| `facebook-post.md` | Conversational community post with discussion CTA | Post to Facebook profile, page, or group |

---

## Operational Modes

### Mode 1: New Topic (From Scratch)

When given a topic or outline:
```bash
/content-pipeline "Using Claude Code worktree mode to parallelize bug fixing"
```
1. Computes timestamp `TS = YYYYMMDD-HHMM` and creates a new folder.
2. Generates all 8 stages sequentially.
3. Delivers a complete, ready-to-publish content suite.

### Mode 2: Existing Folder (Fill Missing Channels)

When given a folder name or path:
```bash
/content-pipeline 20261027-1030
```
1. Detects that `20261027-1030` exists.
2. Scans the folder to see which files are present (e.g., `linkedin-post.md`, `skool-post.md`, `cover.svg`).
3. Reads existing files to extract the topic, key insights, tone, and tool references.
4. Identifies missing channels (e.g., `instagram-post.md`, `twitter-post.md`, `youtube.md`, `facebook-post.md`).
5. Generates only the missing files directly inside `20261027-1030/` without overwriting existing work.

---

## Formatting Standard: Zero Extra Markdown Characters

Social media platforms treat markdown symbols as raw text. To ensure every output is **immediately copy-paste ready with zero cleanup**:

- **No `**bold**` or `*italic*` asterisks**: Emphasis is created using UPPERCASE keywords, emojis, or natural sentence rhythm.
- **No `#` or `##` markdown headings**: Section headings use plain uppercase labels or line breaks with emojis.
- **No `---` horizontal rules**: Clean white space separates blocks.
- **No `[markdown](links)`**: Links are written as plain URLs (`https://...`) or referred to as "link in bio".
- **No markdown `- ` bullets**: Clean visual bullets like `•`, `👉`, or `⚡` are used.
- **No outer ` ```markdown ` fences**: The `.md` file starts with the actual content, ready to select all and copy.

---

## Example Channel Outputs

### `linkedin-post.md`
```
How I Cut Bug-Fix Time In Half 🪛

Claude Code worktree mode changed my workflow.
I shipped three bug fixes yesterday afternoon without losing my place.

Here is what happens when you isolate tasks with worktrees:
• Each branch gets its own clean directory
• Multiple agent sessions run in parallel without file conflicts
• You review and merge only when tests pass

If you are still switching branches manually, give worktree mode a spin.

What is the biggest bottleneck in your daily dev loop?

♻️ Repost if your team spends too much time resolving branch conflicts.
➕ Follow Deven Goratela (https://www.linkedin.com/in/devengoratela/) for practical AI workflows and automation systems.

#AI #ClaudeCode #DeveloperProductivity #SoftwareEngineering
```

### `instagram-post.md`
```
Stop switching git branches manually. 🛑
Here is how worktree mode cuts bug-fix time in half.

Most developers lose 30+ minutes every day context-switching between feature branches and urgent bug tickets.

Here is what changed when I started using git worktrees with AI agents:
👉 Every task runs in its own isolated folder
👉 You can run 3 fixes in parallel with zero merge friction
👉 No unstashed changes getting wiped out

The result: 3 bug fixes shipped in one afternoon.

Save this post so you can set it up on your next project 📌
Follow @devengoratela for daily AI engineering blueprints.

.
.
.

#git #coding #developerlife #softwareengineer #aitools #programming #devproductivity #techtrends #webdev
```

### `twitter-post.md`
```
SINGLE TWEET VARIANT
--------------------
Most developers lose hours to git branch switching.
I tried the worktree + plan workflow in Claude Code and shipped 3 bug fixes in one afternoon.
Isolate your tasks into separate folders. Let parallel agents work. Review and merge.
Huge productivity unlock.


FULL THREAD VARIANT
-------------------
1/ I cut my bug-fixing time in half last week using git worktrees + Claude Code.
Here is the exact setup and why you should stop switching branches manually:

2/ The problem:
When an urgent bug lands, you stash changes, switch branches, fix it, unstash, and hit conflicts.
Context lost. Momentum gone.

3/ The fix: git worktrees.
A worktree lets you check out multiple branches of the same repo into different directories at the same time.
No stashing. No state corruption.

4/ Pair worktrees with autonomous AI agents:
• Terminal 1: Bug fix A in /worktree-1
• Terminal 2: Bug fix B in /worktree-2
• Main directory: Your core feature stays untouched

5/ You review diffs in parallel, run tests, and merge when green.
Yesterday I shipped 3 production fixes in under two hours.

6/ SUMMARY:
• Worktrees eliminate stash/switch friction
• Parallel directories prevent context loss
• Perfect pairing for agentic workflows

If this was useful:
1. Follow @devengoratela for practical AI workflows
2. Repost the first tweet to share with other devs
```

### `youtube.md`
```
TITLE OPTIONS
1. How I Cut My Bug-Fix Time in Half (Git Worktree + AI)
2. Stop Switching Git Branches! Use This Parallel Workflow Instead
3. Why Senior Devs Use Git Worktrees with AI Coding Agents


VIDEO DESCRIPTION
Tired of stashing changes and losing context every time a bug ticket arrives? In this video, we break down how to use Git Worktrees alongside AI coding agents to run parallel bug fixes without branch switching.

WHAT YOU WILL LEARN:
• What git worktrees are and how they differ from standard branches
• How to configure isolated task directories for AI agents
• Step-by-Step walkthrough of fixing 3 bugs in parallel
• Common mistakes and how to clean up finished worktrees

TIMESTAMPS:
00:00 - Introduction & The Context Switching Problem
01:25 - How Git Worktrees Actually Work
03:40 - Setting Up Parallel Worktrees for Bug Fixes
06:15 - Running Autonomous Coding Agents in Worktrees
08:45 - Reviewing Diffs & Merging Back Cleanly
10:30 - Key Takeaways & Best Practices

RESOURCES & LINKS:
• Practical AI Community: [Community Link]
• Connect on LinkedIn: https://www.linkedin.com/in/devengoratela/
• Follow on Twitter/X: https://x.com/devengoratela

ABOUT DEVEN GORATELA:
Deven Goratela shares actionable workflows, agent architectures, and AI development systems that save real engineering hours.

Subscribe for new practical AI tutorials every week.


TAGS
git worktree, claude code, ai coding, developer productivity, software engineering, git tips, ai agents, programming tutorial, git workflow, deven goratela
```

### `facebook-post.md`
```
Quick developer productivity lesson from this week:

If you are still using "git stash" and switching branches every time an urgent bug pops up, there is a much better way.

I tested the git worktree workflow with autonomous coding agents. Instead of stashing work and risking merge headaches, you create isolated working directories for each task.

Here is why it works so well:
• Your main feature work stays completely untouched
• You can run two or three bug fixes in parallel
• Zero friction when jumping between tasks

Shipped three fixes yesterday afternoon without losing my place once.

Have you tried using git worktrees in your daily workflow, or do you still prefer git stash?

Drop your thoughts below 👇
```

---

## See Also

- [carousel-creator](../carousel-creator/) — Premium Instagram/LinkedIn carousels as SVG slides
- [short-form-studio](../short-form-studio/) — Short-form talking-head video scripting and Hyperframes production
- [excalidraw-diagram](../excalidraw-diagram/) — Editable diagrams from natural language
- [skill-builder](../skill-builder/) — Build and audit your own Claude Code skills
