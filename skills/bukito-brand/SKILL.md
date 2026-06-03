---
description: Bukito restaurant brand identity — enforces colors, typography, tone, and asset usage for all Bukito design and content work.
name: bukito-brand
---

# Bukito Brand Kit

You are designing for **BUKITO** — a restaurant/coffee bar in Kertasari, Sumbawa, Indonesia.
Tagline: **"Paradise With Fangs"**

## Brand Personality
Mystical, edgy, warm. NOT hyper-modern. Think surf culture meets Belgian/local food meets tropical wildlife. Sparks curiosity, feels welcoming. Every piece should invite people to step in and be part of the story.

## Colors

### Primary (use 90% of the time)
| Role | Name | Hex |
|------|------|-----|
| Foreground / text | Sunrust | `#6D0000` |
| Background | Coconut Sand | `#F8F5EA` |
| Dark mode foreground | Coconut Sand | `#F8F5EA` |
| Dark mode background | Black Magic | `#000000` |

### Secondary (events, accents, specials)
| Name | Hex | When |
|------|-----|------|
| Jungle Green | `#008134` | Nature, freshness, specials |
| Orange Beach | `#E67E32` | Events, social media, warmth |
| Wavy Blue | `#A8C8E8` | Light accent, ocean vibes |

### Rules
- Default colorway: **Sunrust on Coconut Sand** — this IS the Bukito look
- One accent per piece max. Don't combine green + orange + blue
- Secondary colors need approval for brand-critical materials

## Typography

### Primary Font: Kisrre Regular
- **File**: `$BUKITO_ASSETS_DIR/fonts/Kisrre.otf`
- **Kerning**: Optical
- **Tracking**: -60 (tight — this is essential to the brand)
- **Case**: ALL CAPS always — headlines AND body
- Kisrre Regular is the DEFAULT for everything.

### Secondary Fonts (use sparingly, with approval)
- **Kisrre-Rounded** (`$BUKITO_ASSETS_DIR/fonts/Kisrre-Rounded.otf`) — Softer variant for friendlier contexts. Same ALL CAPS rule.
- **UDC Sign Painter Light** (`$BUKITO_ASSETS_DIR/fonts/UDC Sign Painter-Light.otf`) — Hand-painted style for event posters, chalkboard menus. Mixed case OK.

### Hierarchy (suggested sizes)
- Hero/display: 48–72px
- Headline: 28–36px
- Subhead: 18–24px
- Body: 14–16px
- Caption: 10–12px

All sizes use Kisrre, ALL CAPS, tracking -60.

## Logo Usage

### Variants (in `logos/`)
- **SnakeBread** — primary logo (snake wrapped around bread/sandwich)
- **SnakeCoffee** — for coffee-focused contexts
- **SnakePalm** — for tropical/location contexts

### Wordmark variants (in `wordmarks/`)
- Clean, Distorted, Faded — each a different vibe
- With address variant for location-specific materials

### Rules
- NEVER stretch, distort, or disassemble logos
- NEVER recolor logos outside the brand palette
- Minimum clear space: logo height on all sides
- Use provided files only — no recreations

## Icons
39 custom icons in `icons/` (PNG). Categories:
- Nature: Volcano, Palm, Wave, Mountain, Leaf, Monstera, Sunset, Sparkle
- Surf: Surfboard, Wave, Volleyball
- Food: Cutlery, Glass, Bottle, Cookies, Egg, Rice Bowl, Coffee Cup, Pizza, Durian, Papaya, Banana
- Wildlife: Parrot, Toucan, Snake, Crab, Spider, Bat, Gecko, Turtle, Lobster, Leopard, Cat, Dog, Fish, Chicken
- Spiritual: Hand with Eye

Icons can be combined with the snake for special occasion designs.

## Photography Style
- Warm analog film aesthetic — grain, light leaks
- Tropical: palms, jungle, ocean, banana leaves
- Moody and atmospheric, NOT sterile or corporate
- Food: natural, appetizing, warm lighting

## Tone of Voice
- Mystical, intriguing, warm
- Short punchy copy: "Minimal Morning Sessions", "Night Coffee And Jungle Walks"
- English primarily, with local Indonesian context
- Not formal — conversational, part of the story
- ALL CAPS in design (follows typography rule)

## Pattern & Texture
- Speckled/noise texture inspired by local fields
- Always subtle — never overpower the content
- Optional on any material

## Social Media
- Instagram: @bukito.sumbawa
- TikTok: @bukito.sumbawa
- Hashtags: #Bukito #BukitoSumbawa #ParadiseWithFangs

## Print
- Menu format: A5
- Color mode: CMYK for print, RGB for digital
- Bleed: 3mm all sides

## Templates
HTML templates in `templates/` for:
- Instagram post (1080x1080)
- Instagram story (1080x1920)
- TikTok cover (1080x1920)
- A4 menu

## Asset Locations
- **Brand assets repo** (`$BUKITO_ASSETS_DIR`, default `~/bukito-brand-assets`): logos, wordmarks, icons, fonts, stamps, patterns, merch, colors.json, templates, LUT
- **Supabase Storage** (bukito-media): photos, videos, large media
- **Google Drive**: source files (AI, PSD, brandbook PDF)
