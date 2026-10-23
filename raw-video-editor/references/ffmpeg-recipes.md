# ffmpeg recipes

All commands read inputs and write a **new** output. Every writing command uses **`-n`** (never overwrite), so neither the original nor an earlier render can be replaced. Intermediate files go in `$WS/work/`; finals go to `$OUT` (SKILL.md "Next render path").

Quality defaults: `-c:v libx264 -crf 16 -preset medium -pix_fmt yuv420p -movflags +faststart`, audio `-c:a aac -b:a 256k`. Keep the source resolution and fps.

## Cut from keep.txt (Level 2)

`work/keep.txt` holds the segments to keep, one `start end` per line (seconds). `awk` turns it into a filter graph with 12 ms audio fades on every segment so joins never click:

```bash
awk -v F=0.012 '{d=$2-$1; i=NR-1;
  printf "[0:v]trim=%.3f:%.3f,setpts=PTS-STARTPTS[v%d];\n[0:a]atrim=%.3f:%.3f,asetpts=PTS-STARTPTS,afade=t=in:d=%s,afade=t=out:st=%.3f:d=%s[a%d];\n",$1,$2,i,$1,$2,F,d-F,F,i;
  L=L sprintf("[v%d][a%d]",i,i)} END{printf "%sconcat=n=%d:v=1:a=1[v][a]\n",L,NR}' \
  "$WS/work/keep.txt" > "$WS/work/cut_filter.txt"
ffmpeg -n -hide_banner -loglevel error -i "$SRC" -filter_complex_script "$WS/work/cut_filter.txt" \
  -map "[v]" -map "[a]" -r <source fps> -c:v libx264 -crf 16 -preset medium -pix_fmt yuv420p \
  -c:a aac -b:a 256k -movflags +faststart "$WS/work/clean-cut.mp4"
```
For a video with no audio track, drop the `[0:a]` lines and use `concat=n=N:v=1:a=0[v]`.

## Contact sheet (watch a whole video at a glance)

```bash
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN")
ffmpeg -n -v error -i "$IN" -vf "fps=16/$DUR,scale=480:-2,drawtext=text='%{pts\:hms}':x=8:y=8:fontsize=22:fontcolor=white:box=1:boxcolor=black@0.6,tile=4x4" \
  -frames:v 1 "$WS/work/raw-sheet.jpg"
```
Then Read the jpg. Use 16 frames for a first look, `tile=6x4` with `fps=24/$DUR` for long videos.

## Review frames (Step 4)

```bash
mkdir -p "$WS/work/review-v$n"
ffmpeg -n -v error -i "$OUT" -vf "fps=1/2,scale=960:-2" "$WS/work/review-v$n/f%04d.jpg"   # frame N ≈ 2*(N-1) s
```

## Frame at a time (overlay checks)

```bash
for t in 3.2 7.5 12.0; do
  ffmpeg -n -v error -ss "$t" -i "$OUT" -frames:v 1 -vf scale=960:-2 "$WS/work/review-v$n/t$t.jpg"
done
```

## Scene detection: cuts/min and average shot length (Level 5)

```bash
ffmpeg -hide_banner -i ref.mp4 -vf "select='gt(scene,0.3)',showinfo" -f null - 2>&1 \
  | grep -oE "pts_time:[0-9.]+" | cut -d: -f2 > scenes.txt
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 ref.mp4)
awk -v d="$DUR" 'END{printf "cuts=%d  cuts_per_min=%.1f  avg_shot_s=%.2f\n", NR, NR/d*60, d/(NR+1)}' scenes.txt
```
Lower the threshold (0.2) for soft-cut styles, raise it (0.4) when fast motion creates false cuts.

## B-roll library sheets (Level 4)

Read-only on the user's folder; sheets go to the catalog folder:
```bash
LIB=~/.raw-video-editor/broll/<folder-name>; mkdir -p "$LIB/sheets"
i=0; find "<clips folder>" -type f \( -iname '*.mp4' -o -iname '*.mov' -o -iname '*.m4v' -o -iname '*.mkv' -o -iname '*.webm' \) -print0 | sort -z |
while IFS= read -r -d '' f; do
  id=$(printf %04d $i); d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f")
  ffmpeg -n -v error -i "$f" -vf "fps=6/$d,scale=480:-2,tile=3x2" -frames:v 1 "$LIB/sheets/$id.jpg" \
    && printf '%s\t%s\t%s\n' "$id" "$d" "$f" >> "$LIB/index.tsv"
  i=$((i+1))
done
```
`index.tsv` (id, duration, path) is the starting point for `clips.json`.

## Music ducking (voice on top)

```bash
ffmpeg -i work/video.mp4 -stream_loop -1 -i assets/music.mp3 -filter_complex \
"[1:a]volume=0.35,afade=t=in:d=1.5[m]; \
 [m][0:a]sidechaincompress=threshold=0.03:ratio=10:attack=20:release=400[duck]; \
 [0:a][duck]amix=inputs=2:duration=first:normalize=0,afade=t=out:st=<dur-2>:d=2[a]" \
-map 0:v -map "[a]" -c:v copy -c:a aac -b:a 256k -shortest work/with-music.mp4
```
Tune `volume` (bed level) and `threshold` (how eagerly it ducks). The music should be felt, not heard, under speech.

## Loudness normalise to YouTube (-14 LUFS, -1 dBTP)

```bash
ffmpeg -i in.mp4 -af loudnorm=I=-14:TP=-1:LRA=11 -c:v copy -c:a aac -b:a 256k out.mp4
```
For Shorts/Reels, -14 is also fine. Check with `-af ebur128 -f null -`.

## Light voice cleanup (optional, only on request or obvious hum/hiss)

```bash
-af "highpass=f=80,afftdn=nf=-25,acompressor=threshold=-18dB:ratio=3:attack=10:release=200"
```

## Speed up the whole export (pacing feedback)

```bash
ffmpeg -i in.mp4 -filter_complex "[0:v]setpts=PTS/1.08[v];[0:a]atempo=1.08[a]" -map "[v]" -map "[a]" out.mp4
```
Keep ≤ 1.15× for speech. Apply to the final export, never inside HyperFrames.

## Punch-in zoom (jump-cut energy) on a time range

```bash
-vf "zoompan=z='if(between(it,12.0,15.5),1.12,1)':x='iw/2-(iw/zoom/2)':y='ih/3-(ih/zoom/3)':d=1:s=1920x1080:fps=30"
```
Prefer HyperFrames transforms for multiple zooms; this is a quick single-range option.

## 16:9 → 9:16 reframe (face-centred crop)

Find the face x-centre from a contact sheet (fraction `fx` of width), then:
```bash
-vf "crop=ih*9/16:ih:iw*<fx>-ih*9/32:0,scale=1080:1920"
```
If the speaker moves a lot, split into segments with different `fx`, or use a blurred-background fill:
```bash
-filter_complex "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=20[bg];[0:v]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2"
```

## Burn captions without HyperFrames (fallback only, e.g. a captions-only job when `hf doctor` fails)

```bash
ffmpeg -i in.mp4 -vf "subtitles=work/captions.srt:force_style='FontName=Inter,FontSize=18,Bold=1,PrimaryColour=&H00FFFFFF,OutlineColour=&H80000000,BorderStyle=3,Outline=2,Alignment=2,MarginV=60'" out.mp4
```
`captions.srt` must come from the transcript of the **cut** video.

## Overlay a B-roll cutaway (voice continues)

```bash
ffmpeg -i main.mp4 -i broll.mp4 -filter_complex \
"[1:v]trim=0:3,setpts=PTS-STARTPTS+12.4/TB,scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080[b]; \
 [0:v][b]overlay=enable='between(t,12.4,15.4)'[v]" -map "[v]" -map 0:a -c:a copy out.mp4
```

## Trim a B-roll piece from a personal clip (copy, never edit the original)

```bash
ffmpeg -ss <start> -t <dur> -i "<original clip>" -an -c:v libx264 -crf 16 "$WS/assets/broll/<alias>-<start>.mp4"
```

## Final check

```bash
ffprobe -v error -show_entries stream=width,height,r_frame_rate,codec_name -show_entries format=duration -of compact out.mp4
shasum -a 256 -c "$WS/original.sha256"   # must print OK
```
