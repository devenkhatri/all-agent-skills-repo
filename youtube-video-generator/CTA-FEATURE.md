# CTA Scene Feature: LinkedIn & YouTube Call-to-Action

## Overview

The youtube-video-generator skill now includes a production-ready **CTA (Call-to-Action) scene** as the final frame of every generated video. This scene promotes engagement across LinkedIn and YouTube for **@devengoratela**.

## Features

### Visual Design
- **Gradient Background**: Dark theme with dual-tone backdrop (slate/navy)
- **Headline**: "Follow for More" with scale-in animation
- **LinkedIn CTA**: 
  - Blue circular badge (#0077b5)
  - "in" icon rendering
  - @devengoratela handle
  - Staggered fade-in animation
- **YouTube CTA**:
  - Red circular badge (#ff0000)
  - Play icon rendering
  - @devengoratela handle
  - Staggered fade-in animation
- **Tagline**: "Subscribe to stay updated with latest content"

### Animation
- Title scale-in (0.7x → 1x)
- Staggered entry for LinkedIn (starts at 20% progress)
- Staggered entry for YouTube (starts at 30% progress)
- Tagline fade-in (starts at 40% progress)
- All animations use exponential easing

### Duration & Integration
- **Default Duration**: 3 seconds voiceover + 0.6s transition
- **Customizable**: Pass options to `addCTAScene()` to override
- **Auto-Positioned**: Automatically added as final scene in sequence
- **Audio-Synced**: Respects SceneManager's 0.6s transition rule

## API Usage

### Adding CTA Scene

```javascript
const sceneManager = new SceneManager();

// Existing scenes...
sceneManager
  .addScene({ /* ... */ })
  .addScene({ /* ... */ });

// Add CTA as final scene (3s default)
sceneManager.addCTAScene();

// Or customize CTA timing
sceneManager.addCTAScene({
  voiceoverDuration: 4,      // 4 seconds of audio
  transitionDuration: 0.8    // 0.8s fade-out
});
```

### Manual Rendering

If you need to render the CTA scene outside the standard pipeline:

```javascript
const ctx = canvas.getContext('2d');
const localTime = 1.5;        // Current time within scene (0-3.6s)
const sceneDuration = 3.6;    // Total scene duration

drawCTAScene(ctx, localTime, sceneDuration);
```

## Technical Implementation

### Functions

#### `drawCTAScene(ctx, localTime, sceneDuration)`
Main CTA rendering function. Handles all visual elements and animations.

**Parameters:**
- `ctx` (CanvasRenderingContext2D): Canvas 2D context
- `localTime` (number): Current time within the scene
- `sceneDuration` (number): Total duration of the CTA scene

**Features:**
- Computes animation progress using exponential easing
- Renders gradient background
- Renders staggered social media badges
- Manages composite operations and layer opacity

#### `addCTAScene(options = {})`
SceneManager method to auto-add CTA scene.

**Parameters:**
- `options.voiceoverDuration` (number, default: 3): Duration of voiceover
- `options.transitionDuration` (number, default: 0.6): Transition duration

**Returns:** `this` (chainable with SceneManager)

### Scene Type Handler

The render loop automatically detects CTA scenes:

```javascript
if (scene.type === 'cta') {
  drawCTAScene(ctx, localTime, scene.voiceoverDuration + scene.transitionDuration);
} else {
  // Standard scene rendering
  background(ctx, currentTime, index);
  // ...
}
```

## Integration Points

### With Voiceover
When integrated with ElevenLabs or TTS:
```javascript
const voiceoverDuration = 3.2;  // Get from voiceover metadata
sceneManager.addCTAScene({
  voiceoverDuration
});
```

### With Video Export (Puppeteer/Playwright)
All CTA functions are exported to `window`:
```javascript
// In headless browser
window.drawCTAScene(ctx, localTime, duration);
window.SceneManager.addCTAScene();
```

## Customization

### Change Social Handles

Edit `drawCTAScene()` function:
```javascript
ctx.fillText('@yourhandle', linkedInX, linkedInY + 40);  // LinkedIn
ctx.fillText('@yourhandle', youtubeX, youtubeY + 40);     // YouTube
```

### Change Colors

Modify the LinkedIn/YouTube gradient stops:
```javascript
// LinkedIn blue
linkedInGrad.addColorStop(0, 'rgba(0, 119, 181, 0.3)');

// YouTube red
youtubeGrad.addColorStop(0, 'rgba(255, 0, 0, 0.3)');
```

### Adjust Stagger Timing

Modify progress offsets:
```javascript
const linkedInAlpha = Math.min(1, (progress - 0.2) * 2.5);  // Earlier: 0.15
const youtubeAlpha = Math.min(1, (progress - 0.3) * 2.5);   // Later: 0.35
```

## Test Coverage

✅ **7 comprehensive tests** validate CTA implementation:

1. `drawCTAScene()` function exists
2. LinkedIn handle rendered correctly
3. YouTube branding present
4. `addCTAScene()` method available
5. CTA included in scene sequence
6. Staggered animations working
7. Render loop handles CTA type

**Pass Rate:** 100% (86/86 tests)

## Video Output

### Typical Timeline

| Time | Event |
|------|-------|
| 0s   | Title fades in (scale 0.7x → 1x) |
| 0.5s | "Follow for More" headline visible |
| 0.8s | LinkedIn badge enters from left (staggered) |
| 1.0s | YouTube badge enters from right (staggered) |
| 1.2s | Tagline appears |
| 2.5s | Full CTA visible |
| 3.0s | Scene transition begins |
| 3.6s | Next scene or video ends |

## Browser Preview

Open `/youtube-video-generator/scripts/motion-engine-complete.html` in a browser to see:
- Full demo with CTA as final scene
- Play/Pause controls
- Orientation toggle (16:9 ↔ 9:16)
- Real-time rendering

## Phase 5 Enhancements

Future improvements (deferred):
- Scrubber slider to seek to specific frame
- Dynamic handle injection from config
- Template variations (vertical/horizontal layout)
- A/B testing versions

## Files Modified

- `scripts/motion-engine-complete.html`: Added drawCTAScene() + SceneManager.addCTAScene()
- `scripts/validate-engine.js`: Added 7 CTA validation tests
- `scripts/motion-engine-complete.html.backup`: Previous version

## Support

For questions or customization:
- Review the test cases in `validate-engine.js`
- Check the SKILL.md specification
- Inspect the motion-engine-complete.html source
