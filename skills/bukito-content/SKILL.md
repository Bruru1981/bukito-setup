---
name: bukito-content
description: "Generate Instagram and TikTok marketing content for Bukito restaurant. Creates static posts (Paper MCP), animated videos (Remotion), and AI cinematic clips from photos (Runway API). Use when asked to: create Bukito content, make Bukito Instagram post, Bukito reel, Bukito story, Bukito TikTok, Bukito marketing, Bukito social media, weekly Bukito post, Bukito video, Bukito promo. Also triggers on: social media content for Bukito, Instagram for Bukito, marketing material Bukito."
---

# Bukito Content Generator

Generate on-brand social media content using the full tool pipeline. Load `bukito-brand` skill first.

## Tools

| Tool | What | Output |
|------|------|--------|
| Paper MCP | Static posts & stories | PNG (design in canvas) |
| Remotion | Animated branded videos | MP4 (text overlays + transitions) |
| Runway API | AI video from still photo | MP4 (cinematic 5-10s clips) |

## Photo Library

Local: `$BUKITO_ASSETS_DIR/photos/` (default `~/bukito-brand-assets/photos/`). Supabase: project `$BUKITO_SUPABASE_PROJECT_REF` (default `glmgwaywptqlzudoiwot`), bucket `media`, path `Bukito brand book/photos/`.

| File | Content | Best for |
|------|---------|----------|
| BUKITO_IG1.webp | Bukito t-shirt at night | Vibe, brand |
| BUKITO_IG3.webp | Cat close-up | Lifestyle |
| BUKITO_IG7.webp | Jungle palms | Location |
| BUKITO_IG11.webp | Evening scene | Mood |
| BUKITO_IG15.webp | Rooster by wall | Village life |
| BUKITO_IG19.webp | Tropical atmosphere | Nature |
| BUKITO_IG22.webp | Ocean/beach | Surf, sunset |
| BUKITO_IG24.webp | Evening ambiance | Chill |
| bukito-barista.webp | Barista | Coffee, craft |
| bukito-exterior.webp | Restaurant exterior | Establishing |

Sync missing photos: `curl -sL "https://${BUKITO_SUPABASE_PROJECT_REF:-glmgwaywptqlzudoiwot}.supabase.co/storage/v1/object/public/media/Bukito%20brand%20book/photos/{FILE}" -o "$BUKITO_ASSETS_DIR/photos/{FILE}"`

## Content Templates

### Static Post — Menu Highlight (Paper, 1080x1080)

Photo top 63% with gradient fade to `#F8F5EA`. Text below.

```
Label:  Kisrre 11px #E67E32 tracking:0.15em "THIS WEEK'S HIGHLIGHT"
Title:  Kisrre 56px #6D0000 tracking:-0.05em
Desc:   Kisrre 16px #6D0000 opacity:0.6
Footer: "BUKITO" left / "@BUKITO.SUMBAWA" right
```

### Static Post — Vibe (Paper, 1080x1080)

Full-bleed photo, gradient overlay bottom, editorial text bottom-left.

```
BG:       #1A1A1A, photo full cover
Overlay:  gradient transparent→rgba(0,0,0,0.7)
Label:    Kisrre 11px #E67E32 "THE BUKITO WAY"
Headline: Kisrre 64px #F8F5EA multiline
Subtext:  Kisrre 14px #F8F5EA opacity:0.6
```

### Static Post — Event (Paper, 1080x1080)

Typography-only poster, no photo.

```
BG:       #F8F5EA
Top:      date #E67E32 left / time #6D0000 right
Headline: Kisrre 96px #6D0000 line-height:0.9
Desc:     Kisrre 16px #6D0000 opacity:0.6
Price:    Kisrre 14px #008134
Footer:   "BUKITO" + "PARADISE WITH FANGS"
```

### Story — Weekly Special (Paper, 1080x1920)

Dark mode, centered, full-bleed photo background.

```
BG:     #000000, photo full cover + gradient overlay
Label:  Kisrre 12px #E67E32 centered "THIS WEEK ONLY"
Title:  Kisrre 72px #F8F5EA centered
Line:   60x2px #E67E32
Desc:   Kisrre 16px #F8F5EA opacity:0.7
Price:  Kisrre 28px #E67E32
Footer: "BUKITO" + "KERTASARI, SUMBAWA"
```

### AI Video Clip (Runway)

```bash
cd "$BUKITO_PROJECTS_DIR/bukito-video"
npx tsx scripts/image-to-video.ts <PHOTO> [PROMPT] [DURATION] [RATIO]
```

Ratios: `720:1280` (reel), `960:960` (square), `1280:720` (landscape). Duration: 5 or 10.

Motion prompt tips:
- Exteriors: "slow establishing shot, golden hour, palm trees swaying"
- Food: "slow zoom in, steam rising, warm lighting"
- People: "cinematic pan, natural movement, film grain"
- Nature: "gentle camera drift, breeze in leaves, warm tones"

### Composed Video (Remotion)

Edit `src/BukitoReel.tsx` or `src/BukitoPost.tsx` at `$BUKITO_PROJECTS_DIR/bukito-video/`.

Swap photos via `staticFile('/photos/FILENAME')`. Change text in AnimatedText components. Render:

```bash
npx remotion render BukitoReel out/reel.mp4
npx remotion render BukitoPost out/post.mp4
```

Use AI clips in Remotion: copy `out/ai-videos/*.mp4` → `public/videos/`, replace `<Img>` with `<OffthreadVideo>`.

## Weekly Workflow

1. Pick theme: menu item, event, vibe, or weekly special
2. Select 1-2 photos from library
3. Generate AI video clips if needed (Runway)
4. Create static post (Paper) and/or animated video (Remotion)
5. Export PNG/MP4
6. Post to @bukito.sumbawa — hashtags: #Bukito #BukitoSumbawa #ParadiseWithFangs

## Copy Rules

- ALL CAPS always (Kisrre font rule)
- Short, punchy, mystical: "NIGHT COFFEE AND JUNGLE WALKS"
- Menu: NAME + INGREDIENTS + PRICE (Rp XX.000)
- Events: NAME + TIME + PRICE + ONE-LINE HOOK
