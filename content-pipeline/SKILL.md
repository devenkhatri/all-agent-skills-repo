---
name: content-pipeline
description: Repurpose one idea into a complete multi-platform content package (LinkedIn, Instagram, Twitter, YouTube, Facebook, Skool, cover image, and carousel) or fill missing channels in an existing content folder.
argument-hint: [topic/idea OR existing-folder-path]
---

# Content Pipeline

Transform one idea into a complete multi-platform content package — a high-engagement LinkedIn post, a 1200×627 cover image, a casual Skool community post, a premium carousel, an Instagram caption, a Twitter thread/post, a YouTube video description, and a Facebook post — all from a single input, or by completing missing channels in an existing folder.

## Core Principles

1. **One Idea, Native Execution**: Never copy-paste identical text across platforms. Every channel has unique algorithms, formatting limits, and audience expectations.
2. **Zero Extra Markdown Characters**: Social platforms (LinkedIn, Instagram, Twitter, Facebook) do NOT render markdown. Raw markdown syntax (`**bold**`, `*italic*`, `### headings`, `[links](url)`, `---`) displays as literal, ugly symbols when pasted. All generated copyable posts must be **100% clean and copy-paste ready**, using natural line breaks, standard capitalization, and emojis for emphasis. Files must never be wrapped in outer markdown code fences (` ```markdown `).
3. **Folder Continuation & Missing Channel Detection**: If an existing folder path/name is provided as input, the pipeline inspects existing files in that folder, extracts the topic and context, identifies which channels are missing, and generates only the missing deliverables directly into that folder without overwriting existing files.
4. **Autonomous Pipeline Execution**: Run all stages in sequence from a single input without pausing for intermediate permission prompts.

## When to Use This Skill

Trigger this skill when the user wants to:

- Repurpose one idea across all major social channels in one command
- Generate a full content package (LinkedIn, Instagram, Twitter, YouTube, Facebook, Skool, Carousel, Cover Image)
- Fill in missing platform content for a previously generated post folder
- Distribute an article, tutorial, announcement, or insight across multiple platforms
- Get clean, copy-paste ready social copy without markdown artifacts

**Trigger phrases:**

- "Run the content pipeline on [topic]"
- "Create a content package for [idea]"
- "Repurpose this for all platforms"
- "Fill missing channels for folder [folder-name]"
- "Turn this topic into posts for LinkedIn, Instagram, Twitter, YouTube, Facebook, and Skool"

---

## Deliverables & Channels

| Channel / Deliverable | Output File | Format & Style Highlights |
|---|---|---|
| **LinkedIn** | `linkedin-post.md` | Mobile hook (<8 words), re-hook, emojis at sentence ends, soft CTA, ♻️ Repost + ➕ Follow, 3–5 hashtags. Clean text, no markdown. |
| **Cover Image** | `cover.svg` & `cover-prompt.md` | 1200×627 SVG (1.91:1) with central 1000×500 safe zone, hero insight text, `@devengoratela` branding + AI image prompt. |
| **Skool Post** | `skool-post.md` | 30–40% shorter, casual peer-to-peer tone, no hashtags, tool/tip focus, prominent closing question. Clean text, no markdown. |
| **Carousel** | `slides/`, `caption.md`, exports | 5–10 premium SVG slides (4:5 or 1:1), caption, PDF, MP4, and Hyperframes MP4 via `/carousel-creator`. |
| **Instagram** | `instagram-post.md` | High-hook caption, clean spacing, emoji bullet points, save/share CTA, 10–15 hashtags at the bottom. Clean text, no markdown. |
| **Twitter / X** | `twitter-post.md` | Single punchy tweet (<280 chars) PLUS a full numbered thread (`1/`, `2/`, ... `N/`) with follow/repost CTA. Clean text, no markdown. |
| **YouTube** | `youtube.md` | 3 clickable title options, SEO video description with hook, chapters/timestamps placeholder, links, and tags. Clean text, no markdown. |
| **Facebook** | `facebook-post.md` | Conversational storytelling/educational post, readable paragraphs, community discussion CTA, 0–2 hashtags. Clean text, no markdown. |

---

## Pipeline Overview

```
[Topic / Idea] OR [Existing Folder Path]
            │
            ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Step 0: Intake & Mode Selection                                        │
│ • If folder path provided → inspect existing files, extract context,   │
│   identify missing channels, and target existing folder                │
│ • If topic/idea provided → compute TS = YYYYMMDD-HHMM, create folder   │
└────────────────────────────────────────────────────────────────────────┘
            │
            ├─────────────────────────────────────────────┐
            ▼ (generate all OR only missing channels)    ▼
┌────────────────────────────────────┐       ┌────────────────────────────────────┐
│ Stage 1: LinkedIn Post             │       │ Stage 5: Instagram Post            │
│   • linkedin-post.md               │       │   • instagram-post.md              │
│   • Hook + body + CTAs + hashtags  │       │   • Visual hook + spaced paragraphs│
│   • 100% clean copy-paste text     │       │   • Emoji bullets + save/share CTA │
└────────────────────────────────────┘       │   • 10–15 hashtags at bottom       │
            │                                └────────────────────────────────────┘
            ▼                                             │
┌────────────────────────────────────┐                    ▼
│ Stage 2: Cover Image & Prompt      │       ┌────────────────────────────────────┐
│   • cover.svg (1200×627 SVG)       │       │ Stage 6: Twitter / X               │
│   • cover-prompt.md (AI prompt)    │       │   • twitter-post.md                │
│   • Central 1000×500 safe zone     │       │   • Standalone tweet (<280 chars)  │
└────────────────────────────────────┘       │   • Full numbered thread (1/ to N/)│
            │                                └────────────────────────────────────┘
            ▼                                             │
┌────────────────────────────────────┐                    ▼
│ Stage 3: Skool Community Post      │       ┌────────────────────────────────────┐
│   • skool-post.md                  │       │ Stage 7: YouTube Video Description │
│   • Casual peer reframe            │       │   • youtube.md                     │
│   • Tool/tip leads, no hashtags    │       │   • 3 clickable title options      │
│   • Bold open-ended question       │       │   • Chapters / timestamps & tags   │
└────────────────────────────────────┘       └────────────────────────────────────┘
            │                                             │
            ▼                                             ▼
┌────────────────────────────────────┐       ┌────────────────────────────────────┐
│ Stage 4: Carousel                  │       │ Stage 8: Facebook Post             │
│   • Delegates to /carousel-creator │       │   • facebook-post.md               │
│   • slides/, caption.md, exports   │       │   • Conversational & community tone│
│   • Reconciles into target folder  │       │   • Discussion CTA, 0–2 hashtags   │
└────────────────────────────────────┘       └────────────────────────────────────┘
            │                                             │
            └───────────────────────┬─────────────────────┘
                                    ▼
       [Complete multi-channel content package in target folder]
```

---

## Output Folder Structure

All deliverables are saved in a unified folder. For new runs, the folder is `YYYYMMDD-HHMM/` in the current working directory. For existing folders, deliverables are added directly into that folder.

```
YYYYMMDD-HHMM/ (or existing folder)
├── linkedin-post.md         # Stage 1: Full LinkedIn post (hook + body + CTAs + hashtags)
├── cover.svg                # Stage 2: 1200×627 SVG cover image (1.91:1)
├── cover-prompt.md          # Stage 2: Detailed prompt for Midjourney / DALL-E / Flux
├── skool-post.md            # Stage 3: Casual Skool community post
├── slides/                  # Stage 4: SVG carousel slides (from /carousel-creator)
│   ├── {slug}-slide-1.svg
│   └── ...
├── caption.md               # Stage 4: Carousel caption (from /carousel-creator)
├── {slug}.pdf               # Stage 4: Carousel PDF export
├── {slug}.mp4               # Stage 4: Carousel MP4 export
├── {slug}-hyperframes.mp4   # Stage 4: Hyperframes cinematic MP4
├── instagram-post.md        # Stage 5: Instagram post / reel caption + hashtags
├── twitter-post.md          # Stage 6: Standalone tweet + full numbered thread
├── youtube.md               # Stage 7: 3 title options + SEO description + timestamps + tags
└── facebook-post.md         # Stage 8: Conversational Facebook post + engagement CTA
```

---

## Strict Formatting Rule: Zero Extra Markdown Characters

Social media platforms do not support markdown. Every markdown character pasted into a social app becomes visible clutter that harms engagement and requires manual editing.

Enforce these rules across **all text post files** (`linkedin-post.md`, `skool-post.md`, `instagram-post.md`, `twitter-post.md`, `youtube.md`, `facebook-post.md`):

1. **NO markdown bolding or italics**: Never use `**bold**`, `*italic*`, or `_italic_`. For emphasis, use UPPERCASE words sparingly, unicode bold if appropriate, or natural sentence construction.
2. **NO markdown heading markers**: Never put `#`, `##`, `###`, or `####` inside the copyable post body. Use an empty line, a relevant emoji, or an uppercase header line instead.
3. **NO markdown horizontal rules**: Never insert `---` or `***` dividers.
4. **NO markdown links**: Never use `[anchor text](https://...)`. Write the bare URL directly (e.g. `https://linkedin.com/in/devengoratela`) or use phrases like "link in bio" or "link in the first comment".
5. **NO markdown bullet characters**: When making lists, use visual emojis (e.g. `•`, `🔹`, `👉`, `⚡`) or numbers (`1.`, `2.`), never raw markdown `- ` or `* `.
6. **NO outer code blocks**: Never wrap the entire file inside ```` ```markdown ... ``` ````. The file must directly contain the copy-ready text from line 1.

---

## Workflow

### Step 0: Intake & Mode Selection

Check the input argument:

#### Mode A: Existing Folder Provided (Fill Missing Channels)

If the user provides an existing directory name or path (e.g., `20261027-1030` or `./20261027-1030` or an absolute folder path):

1. **Inspect existing files** in the folder:
   - Check presence of: `linkedin-post.md`, `cover.svg`, `cover-prompt.md`, `skool-post.md`, `slides/` / `caption.md`, `instagram-post.md`, `twitter-post.md`, `youtube.md`, `facebook-post.md`.
2. **Extract source context**:
   - Read the existing post files (prioritizing `linkedin-post.md` or `skool-post.md`) to extract:
     - Core topic and primary insight
     - Key bullet points and supporting facts
     - Tone (urgent, educational, inspirational)
     - Named tools, frameworks, and workflows
3. **Determine missing channels**:
   - Identify every file from the standard roster that is missing from the folder.
4. **Target directory**:
   - Set target directory to this existing folder. Do NOT create a new timestamped folder.
5. **Execute only missing stages**:
   - Generate only the missing deliverables directly into the existing folder.
   - Do NOT overwrite existing files unless the user explicitly requested regeneration.

#### Mode B: New Topic / Idea Provided (Full Pipeline Run)

If the user provides a topic or idea:

1. **Intake parameters**:
   - Topic / idea (required)
   - Key points / outline (2–5 bullet points; extract or infer if not provided)
   - Tone (default: "educational" unless topic implies urgency or controversy)
   - Tools / frameworks mentioned
   - Carousel preferences (default: platform LinkedIn, handle `@devengoratela`, 6–8 slides)
2. **Folder creation**:
   - Compute timestamp `TS = YYYYMMDD-HHMM` from current date/time.
   - Target directory: `{cwd}/{TS}/`.
3. **Run all stages** sequentially (Stages 1 through 8).

---

### Stage 1: LinkedIn Post (`linkedin-post.md`)

**Role:** Senior LinkedIn Content Strategist. High-engagement, mobile-readable professional post designed to drive reach, discussion, and followers.

#### Rules
- **Line 1 (Hook):** Under 8 words. Visible before "...see more" on mobile. Must stop the scroll.
- **Line 2 (Re-hook):** Punchy sentence that earns the expand click.
- **Body:** Short 1–2 sentence paragraphs with whitespace. Emojis at sentence ends where natural.
- **Banned AI slop:** `delve`, `landscape`, `unlock`, `tapestry`, `navigate`, `realm`, `leverage`, `in today's fast-paced world`, `in conclusion`, `game-changer`, `revolutionize`.
- **Soft CTA:** Thoughtful question or invitation matched to the post's tone.
- **Mandatory closing CTAs:**
  - `♻️ Repost` line explaining why reader's network benefits from seeing this.
  - `➕ Follow` line positioning Deven Goratela (`https://www.linkedin.com/in/devengoratela/`) as the AI & automation authority.
- **Hashtags:** 3–5 relevant hashtags on their own line.
- **Zero markdown syntax:** No `#`, no `---`, no `**bold**`.

#### Template for `linkedin-post.md`

```
[Post Title with relevant emoji]

[Hook line 1 — under 8 words]
[Re-hook line 2 — punchy]

[Body paragraph 1 — 1 to 2 sentences with emoji]

[Body paragraph 2 — 1 to 2 sentences with emoji]

[Key takeaways using emoji bullets]
• [Point 1]
• [Point 2]
• [Point 3]

[Soft CTA — engaging question or invitation]

♻️ [Repost line emphasizing value to network]
➕ Follow Deven Goratela (https://www.linkedin.com/in/devengoratela/) for practical AI workflows and automation systems.

#[Tag1] #[Tag2] #[Tag3] #[Tag4]
```

---

### Stage 2: Cover Image (`cover.svg` & `cover-prompt.md`)

**Role:** Senior Visual Designer. Visual reinforcement of the post's core insight.

#### Specifications
- **Dimensions:** 1200 × 627 px (1.91:1 widescreen).
- **Safe zone:** Keep all critical content in the **center 1000 × 500 px** (corners cropped on mobile previews).
- **Hero text:** Core insight extracted from Stage 1 (6–12 words), wrapped into 2–3 lines.
- **Branding:** Subtle `@devengoratela` handle in bottom-left or corner. No author photo. No AI tool logos.
- **Validation:** Must parse cleanly with Python `xml.etree.ElementTree`.

#### Companion Prompt (`cover-prompt.md`)
Detailed prompt for Midjourney, DALL-E 3, or Flux with dimensions, style, color palette, typography guidelines, and do-not-include list.

---

### Stage 3: Skool Community Post (`skool-post.md`)

**Role:** Community member in the Practical AI Skool community. Peer-to-peer reframe.

#### Rules
- **Tone:** Casual, curious, genuine peer sharing ("here's what worked for me").
- **Length:** 30–40% shorter than the LinkedIn post. Direct and punchy.
- **No hashtags:** Remove all hashtags.
- **Lead with the tool/insight:** Skip corporate backstory; get straight to the practical application.
- **Closing question:** End with one strong, open-ended question to spark discussion.
- **Zero markdown syntax:** No `#` headings, no `**` bolding around questions.

#### Template for `skool-post.md`

```
[Curiosity-driven hook line]

[Body paragraph 1 — casual peer explanation of what happened]

[Practical breakdown / what worked]
• [Step or insight 1]
• [Step or insight 2]
• [Step or insight 3]

[One strong open-ended question to spark community discussion]
```

---

### Stage 4: Carousel (delegated to `/carousel-creator`)

Stage 4 invokes the `carousel-creator` skill via a general-purpose subagent to generate SVG slides and exports.

#### Delegation Rules
- Pass pre-collected intake: topic, key points, tone, platform (LinkedIn/Instagram), handle (`@devengoratela`), target audience.
- Direct output to the target folder `{FOLDER_PATH}`.
- If timestamp drift creates a separate minute folder, move all files into `{FOLDER_PATH}` and clean up the extra folder.
- Ensure all carousel deliverables (`slides/`, `caption.md`, `.pdf`, `.mp4`, `-hyperframes.mp4`) reside in `{FOLDER_PATH}`.

---

### Stage 5: Instagram Post (`instagram-post.md`)

**Role:** Visual Platform Content Specialist. Engaging caption for Instagram feed, Reel, or carousel.

#### Rules
- **Line 1 (Hook):** Under 10 words. High intrigue, contrarian statement, or clear promise.
- **Line 2 (Hook extension):** Teases the solution before Instagram clips the caption with "...more".
- **Body:** Air-filled, single-thought paragraphs separated by line breaks.
- **Takeaways:** Bulleted with clean visual icons (`⚡`, `👉`, `🔹`) instead of markdown dashes.
- **Call to Action:** Save & Share focused (e.g. "Save this for your next build 📌", "Share with someone who needs this 📲").
- **Community Tag:** Follow `@devengoratela` for daily AI and automation blueprints.
- **Hashtags:** 10–15 curated hashtags placed at the bottom after spaced dot breaks.
- **Zero markdown syntax:** No `**bold**`, no `#` headings, no `[links](url)`.

#### Template for `instagram-post.md`

```
[Hook line 1 — under 10 words]
[Hook line 2 — curiosity-driven]

[Body context — 1 to 2 lines]

[Key insights or steps]
👉 [Point 1]
👉 [Point 2]
👉 [Point 3]

[Actionable takeaway or conclusion]

Save this post so you can reference it later 📌
Follow @devengoratela for practical AI workflows that actually save hours.

.
.
.

#[tag1] #[tag2] #[tag3] #[tag4] #[tag5] #[tag6] #[tag7] #[tag8] #[tag9] #[tag10] #[tag11] #[tag12]
```

---

### Stage 6: Twitter / X (`twitter-post.md`)

**Role:** High-Signal Tech Writer. Optimized for fast-scrolling feeds on Twitter/X.

#### Rules
- Contains TWO complementary formats in one file:
  1. **SINGLE TWEET VARIANT:** Complete standalone post under 280 characters for fast posting.
  2. **FULL THREAD VARIANT:** Numbered multi-tweet thread (`1/`, `2/`, ... `N/`) for deep-dive distribution.
- **Thread Hook (Tweet 1):** Sharp thesis statement, impressive stat, or painful problem.
- **Thread Body (Tweets 2 to N-1):** One insight per tweet. High information density.
- **Thread Finale (Tweet N):** Summary + Call to Action (Follow `@devengoratela` + Retweet / Bookmark).
- **Zero markdown syntax:** No `**bold**`, no `#` headers, no `---`. Use clear tweet demarcations like `TWEET 1 / HOOK:`, `TWEET 2:`, etc.

#### Template for `twitter-post.md`

```
SINGLE TWEET VARIANT
--------------------
[Punchy standalone tweet under 280 characters including hook, core insight, and quick takeaway]


FULL THREAD VARIANT
-------------------
1/ [Hook tweet — sharp claim, problem, or proof that compels reader to click the thread]

2/ [Core context or the big mistake most people make]

3/ [Actionable step 1 or key insight]

4/ [Actionable step 2 or key insight]

5/ [Actionable step 3 or pro-tip]

6/ SUMMARY:
• [Takeaway 1]
• [Takeaway 2]
• [Takeaway 3]

If you found this useful:
1. Follow @devengoratela for practical AI and automation systems
2. Repost the first tweet to share with your network
```

---

### Stage 7: YouTube Video Description (`youtube.md`)

**Role:** YouTube SEO & Audience Growth Specialist. Video metadata package to maximize CTR and search discoverability.

#### Rules
- **3 Clickable Title Options:**
  - Option 1: Curiosity & intrigue driven
  - Option 2: Search / How-to optimized
  - Option 3: Bold / Contrarian statement
  - All under 60 characters to avoid mobile truncation.
- **Video Description:**
  - **Above the fold (first 2–3 lines):** Keyword-rich summary and hook visible before clicking "...more".
  - **What's covered:** Bulleted summary of the video content.
  - **Timestamps / Chapter Placeholders:** Realistic chapter breakdown starting at `00:00`.
  - **Links & Resources:** Placeholders for tools mentioned, community link, and website.
  - **About section:** Brief bio for Deven Goratela.
- **Tags:** 15–20 comma-separated SEO tags for direct copy-paste into YouTube Studio.
- **Zero markdown syntax:** No `**bold**`, no `#` headings in the copyable blocks.

#### Template for `youtube.md`

```
TITLE OPTIONS
1. [Curiosity Title under 60 chars]
2. [How-To / Search Title under 60 chars]
3. [Contrarian / High-Impact Title under 60 chars]


VIDEO DESCRIPTION
[Hook and 2-sentence summary of the video topic — optimized for search and viewer click]

In this video, we break down [core topic] and how you can apply it step by step.

WHAT YOU WILL LEARN:
• [Key learning 1]
• [Key learning 2]
• [Key learning 3]

TIMESTAMPS:
00:00 - Introduction
01:15 - [The Problem / Core Challenge]
03:30 - [Step-by-Step Walkthrough / Setup]
06:45 - [Real-World Example / Demonstration]
09:10 - [Common Mistakes to Avoid]
11:20 - [Summary & Next Steps]

RESOURCES & LINKS:
• Practical AI Community: [Skool Community Link]
• Tools Mentioned: [Tool 1], [Tool 2]
• Connect on LinkedIn: https://www.linkedin.com/in/devengoratela/

ABOUT DEVEN GORATELA:
Sharing practical AI workflows, automation architectures, and agentic engineering patterns that save real hours.

Subscribe for new AI tutorials and automation blueprints every week.


TAGS
[tag 1], [tag 2], [tag 3], [tag 4], [tag 5], [tag 6], [tag 7], [tag 8], [tag 9], [tag 10], [tag 11], [tag 12], [tag 13], [tag 14], [tag 15]
```

---

### Stage 8: Facebook Post (`facebook-post.md`)

**Role:** Social Community Strategist. Conversational, relatable post for personal profile, business page, or tech/creator Facebook groups.

#### Rules
- **Hook:** Conversational opening line that feels authentic and stops feed scrolling.
- **Tone:** Relatable, peer-oriented, and storytelling-driven. Avoid stiff corporate jargon.
- **Spacing:** Short paragraphs (1–2 sentences) with natural white space for mobile readability.
- **Value Delivery:** Easy-to-read bullet points using clean emoji anchors (`•`, `👉`, `🔹`).
- **Call to Action:** Low-friction discussion question or warm invitation to leave a comment.
- **Hashtags:** 0 to 2 hashtags maximum (Facebook algorithms do not favor hashtag blocks).
- **Zero markdown syntax:** No `**bold**`, no `#` headings, no `[links](url)`.

#### Template for `facebook-post.md`

```
[Conversational hook line — relatable problem or interesting observation]

[Context paragraph — 1 to 2 sentences explaining what happened or what was tested]

[Core insights or practical takeaways]
• [Key takeaway 1]
• [Key takeaway 2]
• [Key takeaway 3]

[Short wrap-up or practical advice]

[Friendly discussion question to spark comments]

Drop your thoughts below 👇
```

---

## Stage Handoffs

Each stage consumes the previous stages' output:

| Stage | Reads | Writes |
|---|---|---|
| **1. LinkedIn** | Input topic, key points, tone | `linkedin-post.md` |
| **2. Cover** | `linkedin-post.md` (core insight + category) | `cover.svg`, `cover-prompt.md` |
| **3. Skool** | `linkedin-post.md` (full post) | `skool-post.md` |
| **4. Carousel** | Pre-collected intake + target folder | `slides/`, `caption.md`, exports |
| **5. Instagram** | `linkedin-post.md` (hook & body) | `instagram-post.md` |
| **6. Twitter** | `linkedin-post.md` & `skool-post.md` | `twitter-post.md` |
| **7. YouTube** | `linkedin-post.md` (breakdown & takeaways) | `youtube.md` |
| **8. Facebook** | `linkedin-post.md` (story & insights) | `facebook-post.md` |

*When running in Mode A (Existing Folder), missing stages read whichever files already exist in the folder as their source context.*

---

## Quality Checklist

Before completing execution, verify:

**Cross-Platform Formatting (Mandatory):**
- [ ] ZERO raw markdown syntax (`**bold**`, `*italic*`, `### headings`, `---`, `[link](url)`) in any post body
- [ ] NO outer code block fences (` ```markdown `) wrapping any output file
- [ ] All deliverables are saved in the correct target folder

**Folder Continuation (If folder input was provided):**
- [ ] Existing files were detected and preserved without being overwritten
- [ ] Context was accurately extracted from existing files
- [ ] All previously missing channels were generated into the existing folder

**Channel-Specific Checks:**
- [ ] **LinkedIn (`linkedin-post.md`):** Hook <8 words, punchy re-hook, emojis at sentence ends, soft CTA, ♻️ Repost + ➕ Follow lines, 3–5 hashtags, no markdown
- [ ] **Cover (`cover.svg` & `cover-prompt.md`):** 1200×627 SVG validates with XML parser, central 1000×500 safe zone, `@devengoratela` branding, prompt file created
- [ ] **Skool (`skool-post.md`):** 30–40% shorter than LinkedIn, casual peer tone, no hashtags, ends with bold/prominent closing question, no markdown
- [ ] **Carousel:** ≥5 SVG slides in `slides/`, `caption.md`, PDF, MP4, and Hyperframes MP4 all located in the target folder
- [ ] **Instagram (`instagram-post.md`):** Hook <10 words, clean line breaks, emoji bullets, save/share CTA, 10–15 hashtags at bottom, no markdown
- [ ] **Twitter (`twitter-post.md`):** Single tweet (<280 chars) AND full numbered thread (`1/` to `N/`), follow + repost CTA, no markdown
- [ ] **YouTube (`youtube.md`):** 3 title options (<60 chars), description with hook, chapters/timestamps placeholder, links, tags, no markdown
- [ ] **Facebook (`facebook-post.md`):** Conversational tone, clean spacing, discussion CTA, 0–2 hashtags max, no markdown

---

## Final Output Reporting

After completing the pipeline:

1. Confirm the target folder path (`YYYYMMDD-HHMM/` or the existing folder).
2. Print a clean summary table listing all generated files and their status (Newly Generated vs Previously Existing).
3. Provide quick usage guidance for the creator:
   - **LinkedIn**: Ready to paste into LinkedIn feed.
   - **Cover**: SVG ready to view or edit; prompt ready for Midjourney/DALL-E.
   - **Skool**: Ready to post in the community discussion.
   - **Carousel**: SVG slides and PDF/MP4 ready to upload.
   - **Instagram**: Caption and hashtags ready to paste with Reel/Carousel.
   - **Twitter / X**: Standalone tweet or numbered thread ready to post.
   - **YouTube**: Titles, timestamps, description, and tags ready for YouTube Studio.
   - **Facebook**: Ready to post to profile, page, or group.

**Do NOT ask for permission between stages.** Run all required stages to completion in a single pass.
