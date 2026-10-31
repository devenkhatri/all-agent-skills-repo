# Content Strategy Reference

> Load this file for detailed content writing rules, topic adaptation, CTA copy, and caption/hashtag generation.

---

## Content Writing Rules

All information must be:
- Useful, concise, accurate, and clear
- Practical, audience-friendly, and easy to understand
- Optimized for fast scanning (short headlines, concise supporting text)

**Avoid:**
- Robotic AI wording
- Boring textbook tone
- Repetitive filler or vague fluff
- Giant paragraphs and unnecessary complexity

---

## Text Density Rules

Social media users scan quickly. Optimize every slide for fast reading:

| Element | Guideline |
|---------|-----------|
| Headline | Max 8 words |
| Subheading | Max 12 words |
| Body text block | 15–30 words |
| Bullet point | 5–8 words each |
| Bullets per slide | Max 4–5 |

- Use visual hierarchy and selectively highlighted keywords
- Smartly use slide real estate — avoid excessive blank space, but never cram
- Clean bullet structures over dense paragraphs

---

## Topic Adaptation Guide

Intelligently adapt the carousel based on topic type:

| Topic Type | Tone | Ideal Slide Count | Layout Style |
|-----------|------|-------------------|--------------|
| Educational / How-to | Clear, instructive | 7–9 | Numbered steps, progressive reveal |
| AI / Tech Tools | Feature-focused, exciting | 6–8 | Card grid, tool spotlight |
| Business / Marketing | Authoritative, data-driven | 6–8 | Bold stats, quote callouts |
| Motivational | Punchy, emotional | 5–7 | Minimal text, large type |
| Myth vs. Fact | Contrast-driven | 6–8 | Split layout, before/after |
| Frameworks / Models | Structured, visual | 7–10 | Diagram-style, labeled boxes |
| Storytelling | Narrative arc | 5–7 | Text-heavy but scannable |
| Thought Leadership | Opinionated, insightful | 5–7 | Clean, editorial |
| Video / Demo Walkthrough | Practical, visual-first | 6–8 | Screenshot cards + concise annotation |

Adapt: tone, layout style, content density, slide count, visual treatment, and CTA style to match the topic type.

### Video Input Content Strategy

When the carousel is derived from a video input:
1. **Focus on concrete visual artifacts:**
   - Instead of generic text lists, center each core value slide around a high-quality screenshot from the video.
   - Strictly choose screenshots without speaker faces (e.g. software UI, settings, architecture diagrams, code, terminal outputs, results).
2. **Text pairing with screenshots:**
   - Top headline: Action-oriented takeaway (e.g. "Step 2: Configure The Automation Agent").
   - Embedded screenshot: Shows the exact interface or diagram from the video.
   - Bottom highlight card: 1–2 bullet points explaining the key decision or outcome shown in the screenshot.
3. **Face exclusion:**
   - Audiences swipe carousels for actionable, scannable knowledge. Talking-head frames distract from the educational value.
   - Whenever the video alternates between presenter face and screen, always capture the screen.
   - If the presenter is in a corner overlay, crop out the face before embedding.

---

## CTA Rules

The final slide must include a CTA to drive engagement. Always use the **user's handle** (collected during intake) as the primary CTA.

**Required CTAs (always include):**
- **Follow @devengoratela for more** — Primary CTA, most visually prominent element
- **Save this post** — For later reference
- **Share this with someone** — Amplify reach

**Optional CTAs (use as appropriate):**
- Comment your thoughts — Drive engagement
- DM for help — If offering services
- Try this today — Action-oriented
- Visit link in bio — If applicable

**CTA Design:**
- Make "Follow @devengoratela" the largest, most prominent element on the final slide
- Use brand colors for the CTA button or box background
- Place CTAs in the bottom half of the final slide
- Keep CTA copy short and action-oriented

**CTA must feel:** natural, relevant, brand-aligned, not spammy.

---

## Caption & Hashtag Generation

After generating and saving all SVG slides, create a post caption and save it to `caption.md` in the dated output folder.

### Caption Structure

**Line 1 — The Hook (under 8 words):**
- Must be strong and compelling
- Create curiosity or promise clear value
- Avoids mobile truncation (keep short)

Examples:
- "5 AI Tools That Changed Everything"
- "Stop Wasting Time on This"
- "The Secret to 10x Growth"

**Line 2 — The Re-Hook:**
- Punchy line to keep readers engaged
- Add context or urgency

Examples:
- "Here's what actually works in 2026..."
- "Your competitors are already using these."
- "Save this for later!"

**Body (optional, 1–2 lines):**
- Brief context about the carousel content
- Keep it concise and relevant

### Hashtag Rules

Use **3–5 relevant, specific hashtags:**
- Niche-specific tags (e.g., `#ContentStrategy`, `#AITools`)
- Industry-relevant tags (e.g., `#SaaS`, `#DevOps`)
- Action-oriented tags (e.g., `#DigitalTransformation`, `#MarketingTips`)

**Avoid:**
- Generic hashtags (`#love`, `#instagood`, `#follow`)
- More than 5 hashtags
- Unrelated or irrelevant hashtags

### Caption Format

```
{hook line}
{re-hook line}

{optional body}

#hashtag1 #hashtag2 #hashtag3 #hashtag4 #hashtag5
```

### caption.md Template

Save the following structure to `{YYYYMMDD-HHMM}/caption.md`:

```markdown
# Carousel Caption

## Hook (Line 1 — under 8 words):
[Your compelling hook here]

## Re-Hook (Line 2):
[Your punchy second line]

## Body (Optional):
[Optional brief context]

## Hashtags:
#tag1 #tag2 #tag3 #tag4 #tag5

---

## Full Caption (Copy-Paste Ready):

[Full caption with proper line breaks, ready to paste into Instagram/LinkedIn]
```
