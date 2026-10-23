# Assets and copyright

A copyright claim or strike costs more than any edit saves. Every third-party asset must have a licence that allows use in a monetised video, and must be logged in `$WS/credits.md`.

## B-roll (video & images)

| Source | Licence summary | Attribution |
|---|---|---|
| Pexels (pexels.com/videos) | Free for commercial use, no permission needed | Not required, appreciated |
| Pixabay (pixabay.com/videos) | Free for commercial use | Not required |
| Mixkit (mixkit.co) | Free licence for video projects | Not required |
| Coverr (coverr.co) | Free for commercial use | Not required |
| NASA / ESA media | Mostly public domain or CC; check each item | Usually required ("Credit: NASA") |
| Wikimedia Commons | Varies per file (CC-BY, CC-BY-SA, PD) | Required for CC-BY/SA |
| The creator's own footage (Level 4) | Theirs | — |
| Screenshots / screen recordings of public sites/apps | Generally fine as commentary; avoid private data | Name the product if relevant |
| AI-generated visuals | Fine; check the generator's terms | Optional "AI-generated" label |

Rules:
- Re-check the licence on the asset's own page at download time. Licences change. Record the page URL, not just the file URL.
- Reject clips with watermarks, visible brand logos as the subject, or identifiable people in sensitive contexts.
- Licences of stock sites usually forbid redistributing the raw clip, but using it inside an edit is the intended use.
- Download into `$WS/assets/broll/` with descriptive names (`mumbai-skyline-night-pexels-123456.mp4`).

## Music

| Source | Notes |
|---|---|
| YouTube Audio Library (studio.youtube.com → Audio Library) | Free for YouTube; some tracks need attribution text (shown on the track). Needs the user's Google sign-in, so **the user downloads it** and gives you the path. Never sign in for them. |
| Pixabay Music | Free for commercial use; Content ID claims are possible on some tracks, so keep the licence page link |
| Free Music Archive / Incompetech (Kevin MacLeod) | Usually CC-BY: attribution text required |
| Uppbeat / Artlist / Epidemic | Free tiers or paid subscriptions; credit or licence code per their terms (user's account) |

Never extract music from another creator's video, a film, or a commercial song, even "just a few seconds".

## Sound effects

Pixabay SFX, Mixkit SFX, Freesound (filter by CC0, or CC-BY with credit), YouTube Audio Library SFX. Keep a small reusable kit in `~/.raw-video-editor/sfx/` (pop, whoosh, tick, ding, riser, typing), each logged once with its licence.

## credits.md format

Append one row per asset as soon as you download it:

```markdown
| Asset | Type | Source URL | License | Attribution required |
|---|---|---|---|---|
| mumbai-skyline-night-pexels-123456.mp4 | B-roll | https://www.pexels.com/video/123456/ | Pexels License | No |
| "Track Name" — Artist | Music | https://pixabay.com/music/... | Pixabay Content License | No (keep link) |
```

At delivery, also print a ready-to-paste **description block** with only the items that require or benefit from attribution.

## Reference videos

Downloading a reference to *study its style* (Level 5) is analysis. Its footage, audio, graphics, and script never go into the output. Keep the reference copy in `work/ref/` and do not deliver it.
