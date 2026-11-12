---
name: youtube-video-generator
description: Use when someone asks to generate YouTube videos from topic or video or another youtube URL or github URL, including voiceover, visuals, and editing.
---
## Purpose
Generate complete YouTube videos from text scripts, including voiceover narration, relevant visuals, and final editing.

## Steps
1. Evaluate the input provided. If not provided then ask for the input

2. Input treatment:
2.1 If the input is topic and research on the topic to create the engaging content
2.2 If the input is video or youtube URL, understand the topic and create engaging content for the video
2.3 If the input is github URL, then go through the README.md of that repo, understand everything mentioned in it and create engaging content for the video

3. Search and locate a motion graphics design from Pinterest based on the content generated in previous step.

4. Now using the content which is created and motion graphics design selected from Pinterest, create videos for both 16:9 ratio and 9:16 ratio.
4.1 16:9 ratio video should be 3 to 6 mins long. If you have confusion on what style to use, then you may ask the user
4.2 9:16 ratio video should be 1 to 3 mins long. If you have confusion on what style to use, then you may ask the user
4.3 The video should have proper captions and copyright-free relatable b-rolls.
4.4 Add a relevant copyright-free background music

5. Generate voiceover script for both the videos and add my latest cloned voice from elevenlabs as voiceover keeping the background music on low volume and my voice clearly audible 

## Process
1. **Input Collection**: Ask user for the topic, video URL, YouTube URL, or GitHub URL to generate the video content
2. **Content Generation**: Research and create full content based on the input type (topic research, video analysis, or GitHub README parsing)
3. **Motion Graphics Selection**: Search Pinterest for appropriate motion graphics designs matching the content theme
4. **Video Creation**: Create 16:9 and 9:16 ratio videos with proper captions, copyright-free b-rolls, and background music
5. **Voiceover Integration**: Add voiceover using the latest cloned ElevenLabs voice, ensuring background music is at low volume for clear audio
6. **Final Output**: Export both video versions in YouTube-optimized formats (1080p, MP4) ready for upload

## Inputs
- Topic description or keyword
- YouTube video URL (optional)
- GitHub repository URL (optional)

## Outputs
- The URL of the Pinterest design used
- `YYYYMMDD-HHMMSS/{topic-slug}-16by9.mp4` (16:9 ratio YouTube video - MP4, 1080p, 3-6 minutes)
- `YYYYMMDD-HHMMSS/{topic-slug}-9by16.mp4` (9:16 ratio Instagram Reels video - MP4, 1080p, 1-3 minutes)

## Guardrails
- Handle missing input gracefully
- Dont use any of the existing skills
- Support common media formats (MP4, MP3, PNG, JPG)
- Provide clear error messages for unsupported formats