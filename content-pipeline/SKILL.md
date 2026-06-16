---
name: content-pipeline
description: Use when someone asks to repurpose one idea into a LinkedIn post + cover image + Skool post, run a content distribution pipeline, or create a multi-platform content package from a single input.
argument-hint: [topic or idea]
---

# Content Pipeline

Transform one idea into a complete multi-platform content package — a high-engagement LinkedIn post, a 1200×627 cover image, a casual Skool community post, and a premium carousel — all from a single input, run as four sequential stages.

## When to Use This Skill

Trigger this skill when the user wants to:

- Repurpose one idea across LinkedIn and Skool
- Run a full content pipeline from a single topic
- Create a "content package" for a post
- Distribute content across multiple platforms at once
- Save time by writing a LinkedIn post, cover, and Skool post in one shot

**Trigger phrases:**

- "Run the content pipeline on [topic]"
- "Create a LinkedIn + Skool package for [idea]"
- "Repurpose this for LinkedIn and Skool"
- "Make a content package about [topic]"
- "Turn this into a full post package"

## Pipeline Overview

```
[Topic / Idea / Key Points]
            │
            ▼
┌────────────────────────────────────┐
│ Stage 1: LinkedIn Post             │
│   • Hook + re-hook                 │
│   • Body + single takeaway         │
│   • Soft CTA                       │
│   • Repost + Follow lines          │
│   • Hashtags                       │
└────────────────────────────────────┘
            │  linkedin-post.md
            ▼
┌────────────────────────────────────┐
│ Stage 2: Cover Image               │
│   • 1200×627 SVG (1.91:1)          │
│   • Central safe zone              │
│   • Core insight as hero           │
│   • Subtle branding                │
│   • + text prompt for AI tools     │
└────────────────────────────────────┘
            │  cover.svg + cover-prompt.md
            ▼
┌────────────────────────────────────┐
│ Stage 3: Skool Post                │
│   • 30–40% shorter                 │
│   • Casual peer tone               │
│   • No hashtags                    │
│   • Tool/tip/insight leads         │
│   • Bold closing question          │
└────────────────────────────────────┘
            │  skool-post.md
            ▼
┌────────────────────────────────────┐
│ Stage 4: Carousel                  │
│   • Delegates to /carousel-creator │
│   • Pre-collected intake (no       │
│     re-prompting)                  │
│   • Premium SVG slides             │
│   • Caption + exports              │
│   • Outputs land in the SAME       │
│     folder as Stages 1–3           │
└────────────────────────────────────┘
            │  slides/, caption.md, exports
            ▼
[Four deliverables, one input, one folder]
```

## Inputs

**Required:**

- **Topic or idea** — The core insight, news, tip, or concept to publish

**Optional** (gathered during the intake if not provided):

- **Key points or outline** — 2–5 bullet points or notes to weave into the post
- **Tone preference** — Urgent, educational, or inspirational (auto-inferred if missing)
- **Target audience** — Who the post is for (defaults to AI/automation practitioners)
- **Tools, prompts, frameworks** — Specific AI tools, prompt templates, or systems the post should mention

## Outputs

All saved to a date-wise folder in the current working directory using `YYYYMMDD-HHMM` (real current date/time, computed at intake so all four stages share the same folder):

```
YYYYMMDD-HHMM/
├── linkedin-post.md         # Stage 1: Title + full post (caption + content + CTAs + hashtags)
├── cover.svg                # Stage 2: 1200×627 SVG cover image
├── cover-prompt.md          # Stage 2: Detailed prompt for Midjourney / DALL-E / Flux
├── skool-post.md            # Stage 3: Casual Skool community post
├── slides/                  # Stage 4: SVG carousel slides (from /carousel-creator)
│   ├── {slug}-slide-1.svg
│   └── ...
├── caption.md               # Stage 4: Carousel caption (from /carousel-creator)
├── {slug}.pdf               # Stage 4: Carousel export
├── {slug}.mp4               # Stage 4: Carousel export
└── {slug}-hyperframes.mp4   # Stage 4: Carousel export
```

> **Why a folder:** Each stage produces a distinct deliverable. Bundling them in one folder makes the package easy to share, archive, or re-render. Stage 4 is delegated to `/carousel-creator` and the subagent is responsible for landing all carousel output into the same `YYYYMMDD-HHMM/` folder Stages 1–3 already use.

---

## Workflow

### Step 0: Intake

Before generating anything, gather the following. **Compute the timestamp `TS = YYYYMMDD-HHMM` once at the start of intake and use it for all four stages** — this keeps every stage's output in the same folder.

#### Content intake (used by Stages 1–3)

1. **Topic or idea** — If not provided in the argument, ask. Never invent a topic.
2. **Key points** — Ask for 2–5 bullet points or supporting material, or extract them from the topic.
3. **Tone** — Default to "educational" unless the topic implies urgency, controversy, or inspiration.
4. **Tools / frameworks** — Ask if the post should mention specific AI tools, prompts, or systems.

#### Carousel intake (used by Stage 4)

These are passed to the `carousel-creator` subagent so it can skip the carousel's own intake questions.

5. **Platform** — Instagram (1080×1350, 4:5) or LinkedIn (1080×1080, 1:1). Default: **LinkedIn** to match the post platform.
6. **Handle** — The CTA handle. Default: **`@devengoratela`** (matches the LinkedIn Follow CTA).
7. **Audience** — Defaults to the same audience inferred for the LinkedIn post.
8. **Brand colors** — Optional. If provided, pass to the carousel. Otherwise the carousel-creator's premium defaults apply (which already match the cover's dark navy + LinkedIn blue accent).
9. **Slide count** — Optional. If not provided, let the carousel-creator decide based on topic complexity (default range: 6–8).

If the user provides minimal input (just a topic), make reasonable inferences for all fields and proceed. Note inferred choices inline in the LinkedIn post output (e.g., "(tone: educational, platform: LinkedIn, handle: @devengoratela — say so if you want any of this changed)").

---

### Stage 1: LinkedIn Post

**Role:** Senior LinkedIn Content Strategist. Your job is a high-engagement, mobile-readable, professional post designed to drive likes, comments, and shares — and funnel interested readers into the Practical AI Skool community.

#### Hook (lines 1–2)

- **Line 1: under 8 words.** This is the only line visible before "...see more" on mobile.
- **Line 2: a punchy re-hook** that earns the click-to-expand.
- Both lines must stop the scroll. No "Today I want to talk about…"

#### Body

- Short paragraphs. White space between them. No walls of text.
- Emojis at the end of logical sentences (professional, not decorative).
- Adopt a human-to-peer voice.
- **Avoid AI slop:** `delve`, `landscape`, `unlock`, `tapestry`, `navigate`, `realm`, `leverage`, `in today's fast-paced world`, `in conclusion`, `game-changer`, `revolutionize`.
- One clear takeaway or insight. Don't try to teach five things.

#### Soft CTA (before the closing lines)

A question or invitation to share experiences. **Tone-matched** to the post:

- Urgent / provocative post → punchy, direct question
- Educational post → value-driven invitation
- Inspirational post → warm, community-focused prompt

#### Mandatory closing lines (in this exact order, after the soft CTA, before hashtags)

1. **♻️ Repost** — A line emphasizing the article's value and why the reader's network needs to see it.
2. **➕ Follow** — A line positioning **Deven Goratela** (https://www.linkedin.com/in/devengoratela/) as the go-to authority for staying ahead in AI and automation.

The three CTA blocks (soft CTA + Repost + Follow) must all match the article's tone.

#### Output format for `linkedin-post.md`

```markdown
# [Post Title] [relevant emoji]

---

[Hook line 1 — under 8 words]
[Re-hook line 2 — punchy]

[Body — short paragraphs with emojis at the end of sentences]

[Soft CTA — question or invitation]

♻️ [Repost line]
➕ Follow [Follow line positioning Deven Goratela as the AI/automation authority]

[Hashtags on their own line, separated by spaces, 3–5 relevant tags]
```

#### Output rules

- Title ends with a relevant emoji.
- No bold formatting anywhere in the post body.
- Hashtags are always included.
- The output must be **copy-paste ready**. No further editing.

---

### Stage 2: Cover Image

**Role:** Senior visual designer for a high-performing LinkedIn infographic. Visual reinforcement of the post's core insight.

#### Specifications

- **Dimensions:** 1200 × 627 px (1.91:1 widescreen).
- **Aspect ratio:** 1.91:1.
- **Safe zone:** Keep all critical content in the **center 1000 × 500 px** (≈100 px margin on all sides). The image is used both as a shared link preview and as an article header — corners may be cropped on different devices.
- **No author photo.** Do not render or include any image of the author.
- **No tool branding** like "LinkedIn Cover Image Generator" or any AI tool name on the image.
- **Subtle branding:** A small handle (`@devengoratela`) or wordmark in a corner is fine but must not dominate.

#### Design system (defaults — override with user brand colors if provided)

| Element | Default | Purpose |
|---|---|---|
| Background | `#0a0e27` → `#1a1f4e` subtle gradient | Professional, eye-catching on light/dark feeds |
| Hero text | `#ffffff`, 64–72 px, bold sans-serif | The core insight or hook |
| Subtitle | `#a0aec0`, 22–26 px | Supporting context or category tag |
| Accent shape | `#4f9eff` (LinkedIn blue variant) | Vertical bar on left edge or geometric shape |
| Footer | `#718096`, 16–18 px | `@devengoratela` and post topic |
| Font stack | `system-ui, -apple-system, "Segoe UI", Roboto, sans-serif` | Clean, native, no font loading required |

#### SVG layout template

```
┌─────────────────────────────────────────────────────────────┐
│  ▌                                                          │
│  ▌   [CATEGORY / TOPIC TAG]                                 │
│  ▌                                                          │
│      [CORE INSIGHT — HERO TEXT]                             │
│      [wrapped to 2–3 lines max]                             │
│                                                             │
│      [supporting visual — icon, stat, or shape]            │
│                                                             │
│  @devengoratela                              [year/date]    │
└─────────────────────────────────────────────────────────────┘
```

#### Process for `cover.svg`

1. Read the LinkedIn post from Stage 1.
2. Extract the **core insight** (the single biggest takeaway, usually 6–12 words). If the hook itself works, use it.
3. Extract the **category / topic** (e.g., "AI Tools", "Automation", "Career", "Prompting").
4. Build the SVG with the layout above. Use `text-anchor="middle"` for centered hero text. Wrap hero text into 2–3 lines manually (use `<tspan>` with `x` and `dy` for line breaks).
5. Validate the SVG:
   ```bash
   python3 -c "import xml.etree.ElementTree as ET; ET.parse('cover.svg'); print('Valid')"
   ```
   Fix any errors and re-save until it parses cleanly.

#### Process for `cover-prompt.md`

In parallel with the SVG, write a detailed image generation prompt suitable for Midjourney, DALL-E 3, or Flux. Users can use this to upgrade to a higher-fidelity raster render.

**`cover-prompt.md` template:**

```markdown
# LinkedIn Cover Image Prompt

Use this prompt with Midjourney, DALL-E 3, Flux, or any AI image generator.

---

## Prompt

\```
[Full detailed prompt — subject, style, composition, lighting, palette, typography]
\```

## Specifications

- **Dimensions:** 1200 × 627 px (1.91:1)
- **Aspect ratio:** 1.91:1
- **Safe zone:** Keep all text in the center 1000 × 500 px area (corners may be cropped on mobile link previews)
- **Style:** [e.g., "Modern minimal infographic, dark mode aesthetic"]
- **Color palette:** [hex codes]
- **Typography:** [e.g., "Bold sans-serif, large hero text"]

## Do NOT include

- No photo of the author
- No text that says "LinkedIn Cover Image Generator" or any tool name
- No watermarks
- No logo of any AI tool or platform
```

---

### Stage 3: Skool Post

**Role:** Casual content conversion assistant for the Practical AI Skool community. The LinkedIn post is the source material; the Skool post is a peer-to-peer reframe.

#### Persona

- You sound like a fellow AI enthusiast — casual, curious, genuinely helpful.
- You are NOT a corporate content writer. No polished, formal, or salesy language.
- You understand the Practical AI community values **real-world application over hype**.

#### Conversion rules

1. **Tone:** Casual and practical — peer-to-peer, not guru-to-student.
2. **Strip LinkedIn-isms:** Remove professional posturing, humble-brags, and "thought leadership" phrases.
3. **Length:** Cut the LinkedIn post by 30–40%. Punchy and direct.
4. **Hashtags:** Remove all hashtags.
5. **Lead with the tool / tip / insight** — not the backstory or hook.
6. **Keep intact:** Any tools, prompts, tips, or frameworks. Reframe them as "here's what worked for me."
7. **"We / us" language:** Use occasionally — e.g., "for those of us using AI daily…"
8. **No hype / buzzwords:** Keep everything grounded and actionable.
9. **Tools in bold:** Use **bold** for tool names (e.g., **Cursor**, **Claude Code**, **n8n**).
10. **Closing question:** End with **one** strong, open-ended question relevant to AI learners, **bolded**, to spark discussion.

#### Output format for `skool-post.md`

```markdown
# [Hook — 1 line, casual, curiosity-driven]

[Body — short paragraphs, 1–2 lines each]

[Optional: a tool, prompt, or framework block — preserved from the LinkedIn post, reframed as personal experience]

**[Strong open-ended question to spark discussion among AI learners]**
```

> **No "Practical AI Skool" branding in the post body itself.** The community is the destination, not a tagline in every post.

---

### Stage 4: Carousel (delegated to `/carousel-creator`)

Stage 4 invokes the **`carousel-creator`** skill to produce a premium Instagram or LinkedIn carousel. Reusing the carousel-creator means we don't duplicate its design system, content strategy, and export pipeline — the subagent simply runs the skill with pre-collected intake info and lands the output in the parent pipeline's folder.

#### Delegation pattern

Spawn a subagent using the **Task tool** with `subagent_type: "general-purpose"`. The subagent's task prompt is self-contained and includes:

1. **Pre-collected intake** — topic, key points, tone, platform, handle, audience, brand colors, slide count (from Step 0).
2. **Parent folder path** — `{cwd}/{TS}/` — the same folder Stages 1–3 saved to.
3. **Existing files** — the subagent must know that `linkedin-post.md`, `cover.svg`, `cover-prompt.md`, `skool-post.md` already exist in the parent folder.
4. **Output directive** — "Save all carousel output (slides/, caption.md, PDF, MP4, Hyperframes MP4) into the parent folder `{TS}/`. Do not create a separate timestamped folder."

#### Subagent task prompt template

```
You are running Stage 4 of the content-pipeline skill. Your job is to invoke the
`carousel-creator` skill with the pre-collected intake below, then ensure all
carousel output lands in the parent pipeline's folder.

PARENT FOLDER: {cwd}/{TS}/
This folder already contains:
- linkedin-post.md
- cover.svg
- cover-prompt.md
- skool-post.md

PRE-COLLECTED INTAKE (all fields are provided — do NOT re-ask the user):
- Topic: {topic}
- Key points: {key_points}
- Tone: {tone}
- Platform: {platform}
- Handle: {handle}
- Target audience: {audience}
- Brand colors: {brand_colors_or_default}
- Slide count: {slide_count_or_default}

STEPS:
1. Invoke the `carousel-creator` skill (via the Skill tool). The skill's intake
   will be skipped because all fields are provided above.
2. The carousel-creator will create its own timestamped folder based on "actual
   current date and time". In most cases this matches {TS}, so the folder is
   shared naturally. If a minute boundary was crossed during the parent
   pipeline's run, the folder name will differ by one minute (e.g., 20260616-1649
   vs 20260616-1650). Detect this with `ls -la {cwd}/` and compare timestamps.
3. If the carousel-creator's folder is a DIFFERENT folder than {TS}, move all
   its contents into {TS}/:
   - mv {TS_carousel}/* {TS}/
   - rmdir {TS_carousel}
4. Run the carousel-creator's export scripts (PDF, MP4, Hyperframes MP4) per
   its own SKILL.md instructions. Confirm all four files end up in {TS}/.
5. Report back with the final list of files in {TS}/.

Do NOT ask the user any intake questions — every field is pre-collected.
```

#### Why a subagent (not inline)

- **Context cleanliness** — The carousel-creator's intake, design system, and export logic would otherwise clutter the main content-pipeline context.
- **Pre-collected intake** — The subagent prompt has all the fields, so the carousel-creator's intake step is a no-op. The user is never asked the same question twice.
- **Folder reconciliation** — The subagent can detect timestamp drift between the parent pipeline's `TS` and the carousel-creator's auto-generated folder, and move files to reconcile.

#### Why "actual current date and time" is fine

The carousel-creator's instruction to use "actual current date and time" is a default, not a hard constraint. Because:

- content-pipeline computes `TS` at intake (Step 0)
- Stage 4 runs within seconds to minutes of intake
- The carousel-creator's invocation typically lands in the same minute
- If a minute boundary is crossed, the subagent reconciles with a `mv` (Step 3 above)

In 99% of runs, the timestamps match and no `mv` is needed.

#### Output from Stage 4

After Stage 4, the parent folder contains everything from Stages 1–3 plus:

- `slides/{slug}-slide-{n}.svg` — one SVG per slide
- `caption.md` — carousel caption (also usable as a bonus LinkedIn post variant)
- `{slug}.pdf` — multi-page PDF export
- `{slug}.mp4` — MP4 slideshow (5 s/slide)
- `{slug}-hyperframes.mp4` — Ken Burns + cross-dissolve cinematic MP4

---

## Stage Handoffs

Each stage must consume the previous stage's output:

| Stage | Reads | Writes |
|---|---|---|
| 1. LinkedIn | `topic`, `key points`, `tone` | `linkedin-post.md` |
| 2. Cover | `linkedin-post.md` (core insight + category) | `cover.svg`, `cover-prompt.md` |
| 3. Skool | `linkedin-post.md` (full post) | `skool-post.md` |
| 4. Carousel | pre-collected intake (platform, handle, audience, brand colors, slide count) + parent folder `{TS}/` | `slides/`, `caption.md`, `{slug}.pdf`, `{slug}.mp4`, `{slug}-hyperframes.mp4` (all in `{TS}/`) |

If a stage needs clarification that the user did not provide, make a reasonable inference and note it. Do not stop the pipeline to ask.

---

## Quality Checklist

Before reporting done, verify:

**LinkedIn post:**
- [ ] Hook is under 8 words
- [ ] Re-hook is punchy and earns the expand
- [ ] Single clear takeaway
- [ ] No AI slop words (delve, landscape, unlock, etc.)
- [ ] Soft CTA is a question or invitation
- [ ] Repost + Follow lines present in correct order
- [ ] Tone of all CTAs matches the article
- [ ] 3–5 hashtags, no bold in the body

**Cover image:**
- [ ] SVG is 1200×627 with `viewBox="0 0 1200 627"`
- [ ] Critical content sits inside the center 1000×500 safe zone
- [ ] No author photo, no tool-name branding on the image
- [ ] Subtle `@devengoratela` handle visible somewhere
- [ ] SVG validates with `xml.etree.ElementTree.parse`
- [ ] Companion `cover-prompt.md` exists with full prompt + do-not-include list

**Skool post:**
- [ ] 30–40% shorter than the LinkedIn post
- [ ] No hashtags
- [ ] No LinkedIn-isms (humble-brags, "thought leader" framing)
- [ ] Tool names in **bold** where they appear
- [ ] Ends with one bolded open-ended question
- [ ] Body reads like a peer talking, not a brand broadcasting

**Carousel (delegated to /carousel-creator):**
- [ ] All five files (`slides/`, `caption.md`, `.pdf`, `.mp4`, `-hyperframes.mp4`) sit inside `{TS}/`
- [ ] At least 5 SVG slides in `slides/`
- [ ] CTA slide includes `@devengoratela`
- [ ] No separate timestamped folder exists alongside `{TS}/` (timestamp drift reconciled via `mv`)
- [ ] User was NOT re-prompted for carousel intake (all fields pre-collected)

---

## Final Behavior

After all four stages complete:

1. Confirm every file is saved to the `YYYYMMDD-HHMM/` folder (Stages 1–3 by the main agent, Stage 4 by the carousel-creator subagent).
2. List the saved files with one-line descriptions.
3. Remind the user:
   - The LinkedIn post is copy-paste ready.
   - The SVG cover can be opened in any browser or imported into Figma.
   - The `cover-prompt.md` can be pasted into Midjourney / DALL-E for a higher-fidelity render.
   - The Skool post is ready to drop into the community.
   - The carousel `slides/`, `caption.md`, PDF, MP4, and Hyperframes MP4 are all in the same folder — ready to upload to Instagram / LinkedIn.

**Do NOT ask for permission between stages.** Run all four in sequence from a single input.
