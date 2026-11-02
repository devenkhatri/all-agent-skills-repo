# Case Study Generator

Generate polished, multi-format case studies for completed projects — from any combination of inputs — in a single run.

## What It Does

Point it at your project (Git repo, Loom video, live site, PPT, or just a description) and it produces **12 ready-to-publish formats** plus **compiled PDF and rendered MP4 video assets by default**:

| # | Format / Asset | Use For |
|---|----------------|---------|
| 1 | `case-study.md` | Blog post, Notion, GitHub |
| 2 | `linkedin-post.md` | LinkedIn long-form post + carousel script |
| 3 | `case-study.html` & `case-study.pdf` | Print-ready source & compiled PDF client deliverable |
| 4 | `slide-deck-outline.md` | PPT / Keynote presentation |
| 5 | `twitter-thread.md` | Twitter/X thread |
| 6 | `one-page-summary.md` | Executive elevator pitch / email |
| 7 | `video-16x9.md` & `video-16x9.mp4` | 16:9 script & rendered video (min 3 mins) with neutral professional male voiceover + light BGM |
| 8 | `youtube-video-meta.md` | YouTube video title, description & tags |
| 9 | `video-9x16.md` & `video-9x16.mp4` | 9:16 Shorts script & rendered video (min 1 min) with neutral professional male voiceover + light BGM |
| 10 | `youtube-shorts-meta.md` | YouTube Shorts title, description & tags |
| 11 | `linkedin-profile-feature.md` | LinkedIn Profile Featured & Experience copy + step-by-step instructions |
| 12 | `upwork-portfolio-item.md` | Upwork Portfolio Project copy, skills, attachments + step-by-step instructions |

## Accepted Inputs

- Git repository URL
- Project description (plain text)
- Loom video URL
- Live web page URL
- PowerPoint / PDF file
- GitHub Issues / PR history

Mix and match — the skill extracts what it can autonomously, then asks only for what's missing.

## Output

All files saved to `YYYYMMDD-HHMMSS-{project-slug}/` in the working directory. Every format ends with a CTA to book a consulting call with **Dhimahi Technolabs** (`https://dhimahitechnolabs.com`).

## Example

```
User: Here's the repo: https://github.com/myorg/myproject
      It was for a logistics company — saved them 4 hours/day of manual work.

Skill: [Extracts tech stack, README, PR history]
       [Asks: "May I name the client? What was your role?"]
       [Generates all 8 formats and saves to 20261102-194500-logistics-automation/]
```

## Related Skills

- `carousel-creator` — Pass `linkedin-post.md` carousel script to generate SVG slides
- `generate-video` — Pass `video-16x9.md` or `video-9x16.md` to generate the actual video

