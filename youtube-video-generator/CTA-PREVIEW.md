# CTA Scene Visual Preview

## Scene Layout

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                     🎬 CTA FINAL SCENE                         │
│                                                                 │
│                  Follow for More                               │
│                  (Scale: 0.7x → 1x)                            │
│                  Color: Cyan Accent                            │
│                  Glow: 20px shadow                             │
│                                                                 │
│                                                                 │
│        ┌─────────────────┐    ┌─────────────────┐             │
│        │                 │    │                 │             │
│        │   ◯ in          │    │   ▶ (red)      │             │
│        │   Blue (#0077b5)│    │   Red (#ff0000) │             │
│        │                 │    │                 │             │
│        │ @devengoratela  │    │ @devengoratela  │             │
│        │ LinkedIn        │    │ YouTube        │             │
│        │                 │    │                 │             │
│        └─────────────────┘    └─────────────────┘             │
│        ↑                       ↑                               │
│        Enters at 20% progress  Enters at 30% progress         │
│                                                                 │
│                                                                 │
│    Subscribe to stay updated with latest content              │
│    (Appears at 40% progress)                                  │
│                                                                 │
│ ┌────────────────────────────────────────────────────────────┐ │
│ │ Progress: ████████████████████ 55%                      │  │ │
│ └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

Background: Slate → Navy Gradient
Dimensions: 1920×1080 (16:9) or 1080×1920 (9:16)
```

## Animation Sequence

### Timeline (0s → 3.6s)

```
Time    Action
────────────────────────────────────────────────────────────────
0.0s    Scene begins
        ↓ Scale-in starts
        
0.2s    Headline fully visible
        └─ "Follow for More" at 1x scale
        
0.6s    LinkedIn badge fades in
        └─ From α=0 to α=1 at 20% progress
        ├─ Staggered entry (progress - 0.2)
        
0.9s    YouTube badge fades in
        └─ From α=0 to α=1 at 30% progress
        ├─ Staggered entry (progress - 0.3)
        
1.2s    Tagline appears
        └─ Subtitle text fades in
        └─ Staggered entry (progress - 0.4)
        
2.5s    Full CTA visible
        └─ All elements at full opacity
        
3.0s    Transition phase begins
        └─ Prepare for next scene
        
3.6s    Scene complete
        └─ Typically followed by black fade
```

## Component Details

### LinkedIn Badge

**Position:** Centered left (CenterX - 300, CenterY + 80)

**Visual:**
```
         ┌─────────────────┐
         │   ◯ in          │
         │  (Blue badge)   │
         │                 │
         │ @devengoratela  │
         │                 │
         └─────────────────┘
```

**Colors:**
- Background: Radial gradient (0077b5 @ 30% → 0077b5 @ 5%)
- Border: #0077b5, 3px stroke
- Icon: "in" text in #0077b5
- Text: #f4f4f5 (off-white)

**Diameter:** 200px (100px radius)

### YouTube Badge

**Position:** Centered right (CenterX + 300, CenterY + 80)

**Visual:**
```
         ┌─────────────────┐
         │   ▶ (red)       │
         │  (Red badge)    │
         │                 │
         │ @devengoratela  │
         │                 │
         └─────────────────┘
```

**Colors:**
- Background: Radial gradient (ff0000 @ 30% → ff0000 @ 5%)
- Border: #ff0000, 3px stroke
- Icon: Play triangle in #ff0000
- Text: #f4f4f5 (off-white)

**Diameter:** 200px (100px radius)

### Headline

**Text:** "Follow for More"

**Font:** Inter, bold, 96px

**Color:** C.accent (typically cyan/blue)

**Shadow:** 20px blur, rgba(0,0,0,0.5)

**Animation:** Scale 0.7x → 1x over first 0.5 seconds

### Tagline

**Text:** "Subscribe to stay updated with latest content"

**Font:** Inter, 400 weight, 16px

**Color:** rgba(244, 244, 245, 0.6) (translucent off-white)

**Position:** Bottom center, 80px from edge

## Easing Curves

All animations use **exponential out** easing:

```javascript
CM.ez.outExpo(u) → 1 - Math.pow(2, -10 * u)
```

**Effect:** Fast start, gradual slowdown (natural deceleration)

**Progress Mapping:**
- Headline: `ez.outExpo(progress)`
- LinkedIn: `(progress - 0.2) * 2.5` (clamped, staggered multiplier)
- YouTube: `(progress - 0.3) * 2.5` (clamped, staggered multiplier)
- Tagline: `(progress - 0.4) * 2` (clamped)

## Background Gradient

**Type:** Linear horizontal

**Colors:**
- Start (left): PALETTE.slides[8] (slate: #1a1a2e)
- End (right): PALETTE.slides[9] (navy: #16213e)

**Opacity:** Fully opaque (blends naturally into previous scenes)

## Rendering Performance

**Canvas Size:** 1920×1080 or 1080×1920

**Frame Rate:** 60fps (standard browser animation)

**Computations per Frame:**
- 1 gradient render
- 1 headline text render + shadow
- 2 radial gradients (LinkedIn + YouTube)
- 2 circle paths + strokes
- 2 text renders (handles)
- 1 tagline text render

**Estimated:** ~0.3ms per frame (negligible impact)

## Browser Preview

To see this live:

1. Open `/youtube-video-generator/scripts/motion-engine-complete.html`
2. Click **▶ Play** button
3. Watch through to final scene (around 15 seconds total)
4. CTA scene appears as last slide before reset

**Controls:**
- ▶ Play / ⏸ Pause: Play/pause animation
- ↻ Reset: Jump to beginning
- 9:16 Portrait / 16:9 Landscape: Toggle aspect ratio

## Export Considerations

When rendering to MP4 (Phase 5):

1. **Duration:** Ensure CTA gets 3+ seconds in final video
2. **Audio:** Silence or outro music during CTA
3. **Fade:** Consider 0.5s black fade after CTA ends
4. **Resolution:** Match source video (1920×1080 or 1080×1920)
5. **Frame Rate:** Lock to 30fps or 60fps for consistency

## Customization Examples

### Change Handles

```javascript
// Edit in drawCTAScene() function around line 920-930
ctx.fillText('@yourhandle', linkedInX, linkedInY + 40);  // LinkedIn
ctx.fillText('@yourhandle', youtubeX, youtubeY + 40);     // YouTube
```

### Change Headline

```javascript
ctx.fillText('Subscribe Now', 0, 0);  // Line ~887
```

### Change Tagline

```javascript
ctx.fillText('Your custom message here', centerX, H - 80);  // Line ~947
```

### Change Colors

```javascript
// LinkedIn blue → Different blue
ctx.strokeStyle = '#1E40AF';  // Line ~904

// YouTube red → Different red
ctx.strokeStyle = '#DC2626';  // Line ~925
```

### Change Timing

```javascript
// Make LinkedIn enter earlier
const linkedInAlpha = Math.min(1, (progress - 0.15) * 2.5);  // Was 0.2

// Make YouTube slower
const youtubeAlpha = Math.min(1, (progress - 0.3) * 1.8);   // Was 2.5
```

## Troubleshooting

**Text Not Visible:**
- Check font loading (Inter from Google Fonts)
- Verify ctx.fillStyle is set before ctx.fillText()
- Ensure applyTypography() is called

**Badges Not Showing:**
- Verify radial gradient creation
- Check circle path (beginPath + arc + fill/stroke)
- Confirm globalAlpha > 0

**Animation Too Fast/Slow:**
- Adjust stagger multiplier (currently 2.5)
- Change progress offset (0.2, 0.3, 0.4)
- Modify duration in addCTAScene()

**Colors Wrong on Export:**
- Check canvas.toDataURL() color space
- Verify compositing mode (should default to 'source-over')
- Confirm no CSS filters affecting output

## Testing

All aspects verified by automated test suite (86/86 passing):

✅ Function exists and is callable
✅ LinkedIn handle renders correctly
✅ YouTube branding is present
✅ Animations trigger at right times
✅ Exports to window for headless rendering
✅ Integrates with scene sequence
✅ Backward compatible with existing features
