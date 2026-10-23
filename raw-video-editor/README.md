# raw-video-editor

Give Claude your raw recording and get back an edited video, one pass at a time. **Your original file is never touched.** Every result is a new file.

```bash
npx skills add devenkhatri/all-agent-skills-repo/raw-video-editor
```

## Use

```
/raw-video-editor ~/Videos/raw-take.mp4 clean cut, then captions
/raw-video-editor "C:\Users\me\Videos\raw.mp4" edit it in the style of https://youtube.com/shorts/...
/raw-video-editor ~/Videos/raw.mp4 use my B-roll from ~/Videos/old-clips, my photo is ~/me.jpg
```

Claude will: set up a workspace → transcribe and watch → propose an `edit-plan.md` → wait for your "go" → edit → check its own frames → hand you `renders/<name>-edited-v1.mp4`. Reply with plain feedback ("text too small", "first 10s faster") to get v2.

## The passes

| Level | What it does |
|---|---|
| 1 | Quick polish: motion graphics, captions, SFX in one go |
| 2 | Clean cut: silences, um/uh, repeated takes removed (keeps your best take) |
| 3 | Copyright-free B-roll, background music, styled captions, credits list |
| 4 | Catalogue your own clips once, then use them as B-roll |
| 5 | Copy the *editing style* of any reference video, saved for reuse |
| 6 | Clean "Apple-style" premium motion design |

## Voice

When new speech is needed (patching a flubbed line, narration over B-roll, a reveal or CTA beat), the skill uses **your cloned voice via local Chatterbox** first (`~/tools/chatterbox`, `voices/deven.wav`). It falls back to HyperFrames' Kokoro TTS only if Chatterbox isn't installed, and tells you first. Your real recording is never replaced.

## Safety

- The original's SHA-256 is stored in `original.sha256` and re-checked before delivery
- Every ffmpeg write uses `-n` (never overwrite); B-roll folders are never renamed or edited
- Renders are versioned, never overwritten
- Only licence-checked assets; every one is listed in `credits.md`

## Requirements

`ffmpeg`/`ffprobe` and the HyperFrames CLI (no Python needed). Transcription, motion graphics and rendering use [HyperFrames](https://github.com/heygen-com/hyperframes): Node ≥ 22 (an nvm/fnm/volta install is found automatically) and its skills (`npx skills add heygen-com/hyperframes`).

## Credits

Method distilled from Aaghaz, *Edit 10 Videos a Day With Claude* (youtu.be/RDOy_HkTWyY), and Last Moment Tuitions, *Master AI Video Editing in 20 Minutes* (youtu.be/hffQ4UleKUU).
