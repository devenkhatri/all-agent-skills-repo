---
name: generate-video
description: Use when someone asks to create a video from text, HTML, a YouTube URL, a PDF, or an image. Converts multimodal inputs (HTML files, raw text, YouTube URLs, PDFs, or Images) into an automated video sequence using the local Hyperframes framework. This skill orchestrates data extraction, script generation, and programmatic video rendering.
argument-hint: [URL, file path, or text prompt]
disable-model-invocation: true
---

# SKILL: Generate Video via Hyperframes

## Description
Converts multimodal inputs (HTML files, raw text, YouTube URLs, PDFs, or Images) into an automated video sequence using the local Hyperframes framework. This skill orchestrates data extraction, script generation, and programmatic video rendering.

## Trigger
Use this skill when the user asks to "create a video", "generate a hyperframes video", or "turn this [input] into a video".

## Expected Inputs
The user must provide a target source. This can be:
1. A local file path (e.g., `./guide.html`, `./report.pdf`, `./diagram.png`)
2. A raw text string
3. A YouTube URL

## Execution Steps

### Step 1: Input Ingestion & Normalization
Identify the input type and extract the core narrative text:
- **If HTML:** Read the file contents. Strip out CSS/Scripts. Keep hierarchical tags (H1, H2, lists) intact to inform scene structures.
- **If YouTube URLs**: Use the `web_fetch` tool to extract the video transcript, summary, and key points.
- **If Web/HTML URLs**: Use the `web_fetch` tool to scrape the main article content, headings, and value proposition.
- **If PDFs/Documents**: Use the `read_file` tool to extract text. If it's a long document, summarize the core narrative into 5-8 key scenes.
- **If Images**: Use the `read_file` tool to analyze the image using your vision capabilities. Extract any text (OCR) and describe the visual elements to inspire the video theme.
- **If Raw Text**: Use the text directly as the storyboard foundation.

### Step 2: Context & Clarification Check (CRITICAL)
Before generating the video script, analyze the extracted content and the user's original request. **You must pause and ask the user for clarification if any of the following are unclear:**
- **Target Format/Platform:** Is this a vertical video (9:16) for social media or a landscape (16:9) deep-dive?
- **Visual Tone:** Should the visuals be highly technical (showing code blocks), conceptual (diagrams), or presenter-focused?
- **Missing Core Information:** If the extracted text is fragmented or lacks a clear narrative arc (Beginning, Middle, End), ask the user how to fill the gaps.
- **Pacing:** Is there a specific target duration for the final video?

*Do not proceed to Step 3 until the user has resolved these ambiguities.*

### Step 3: Scene & Script Structuring
Based on the extracted content, map out a 5-10 scene storyboard. 
- **Scene 1**: Strong Hook.
- **Scenes 2-N**: Core Value / Narrative progression.
- **Final Scene**: Call to Action (CTA).

Process the normalized text into a strict JSON scene array based on the agreed-upon parameters. Each scene must contain:
- `scene_duration`: Estimated time in seconds.
- `narrator_script`: The exact voiceover text.
- `visual_asset_type`: (e.g., "code_block", "text_slide", "image_overlay").
- `visual_content`: The extracted data for the screen.

### Step 4: Aesthetic & Design System
Unless the user explicitly requested a specific style, default to a **"Clean Minimalist"** aesthetic:
- **Colors**: Deep slate background (`#0F172A`), clean white text, and a vibrant primary accent (e.g., `#3B82F6` or `#10B981`).
- **Typography**: System sans-serif (Inter, Roboto, or SF Pro). Large, bold headings.
- **Animations**: Use GSAP for smooth `y: 30, opacity: 0` stagger reveals on text, and slow scaling on background elements.

### Step 5: Hyperframes Handoff
Write the JSON scene array to a temporary configuration file: `.hyperframes/temp_render_config.json`.

Execute the Hyperframes CLI command to begin the render pipeline (adjusting resolution/aspect ratio based on Step 2):
\`\`\`bash
hyperframes render --config .hyperframes/temp_render_config.json --output ./output/final_video.mp4 
\`\`\`

### Step 6: Verification
Confirm the existence of `./output/final_video.mp4` upon command completion. If the render fails, read the hyperframes console output, summarize the error for the user, and suggest a fix for the scene JSON.

### Step 7: Delivery
Inform the user that the video is ready, provide the path to `final-video.mp4`, and offer to make timing or styling adjustments.

## Guardrails & Constraints

- **No Placeholder Content**: If extraction fails (e.g., a blocked URL), stop and ask the user for the raw text. Do not generate a video with "Lorum Ipsum" or error messages.
- **Performance**: Keep the scene count under 15 to ensure reliable rendering.
- **Direct Execution**: Handle all extraction, writing, and rendering in the main session. Do not delegate to subagents.
- **Valid HTML**: Ensure all SVG/HTML tags in the Hyperframes composition are strictly closed and valid to prevent render crashes.
- **System Prompt Constraints**: Never skip the normalization step; the hyperframes CLI expects strictly structured JSON, not raw multimodal data.
- **Zero-Guessing Policy:** If you are unsure about the required video dimensions, tone, or script length, you must stop execution and prompt the user. Do not assume default values unless explicitly instructed.
- If an input type is unsupported or corrupted, halt execution immediately and ask the user to verify the source file.