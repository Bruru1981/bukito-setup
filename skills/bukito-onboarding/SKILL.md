---
name: bukito-onboarding
description: "First-run onboarding for Bukito brand & marketing agents. Connects to Supabase, fetches brand data, configures tools, and introduces Rubin & Helena. Triggers on: bukito setup, start bukito, let's build, let's start building, configure bukito, init bukito."
---

# Bukito Onboarding — First Run Setup

When this skill triggers, run the following setup sequence:

## Step 1: Welcome

Say this (in character):

```
┌──────────────────────────────────────────┐
│  BUKITO — PARADISE WITH FANGS            │
│  Brand & Marketing Command Center        │
└──────────────────────────────────────────┘

Welcome! You've got two agents ready to work:

  🎨 RUBIN — Design Director
     Swiss editorial meets tropical brutalism.
     Handles: menus, posts, website, brand materials, photo grading.

  📱 HELENA — Marketing & Social Media Director
     Strategic storyteller, culturally fluent.
     Handles: content calendar, captions, campaigns, posting, analytics.

Let's get you connected.
```

## Step 2: Ask Which Company

Ask: "Which brand are we working on?"

If the answer is **Bukito** (or similar), proceed. Otherwise, explain these agents are Bukito-specific.

## Step 3: Connect to Supabase

The Bukito media project:
- **Project ID**: `glmgwaywptqlzudoiwot`
- **Region**: eu-north-1
- **Bucket**: `media`
- **Tables**: `content_analytics`, `content_calendar`, `media`, `media_categories`

Verify connection by running:
```
List tables for project glmgwaywptqlzudoiwot
```

If it fails, check if Supabase MCP is configured in the user's settings.

## Step 4: Verify Brand Assets

Check that the brand assets repo exists:
```bash
ls ~/bukito-brand-assets/logos/ ~/bukito-brand-assets/fonts/ ~/bukito-brand-assets/photos/
```

If missing, tell the user to run `install.sh` first.

Report asset count:
- Logos (3): SnakeBread, SnakeCoffee, SnakePalm
- Fonts (3): Kisrre, Kisrre-Rounded, UDC Sign Painter
- Photos: count .webp files
- Icons: count .png files in icons/
- Wordmarks: count .png files in wordmarks/

## Step 5: Ask for Paper Link

Say: "Do you have Paper open? Share the file URL so Rubin can design directly on your canvas."

If they share a URL like `https://app.paper.design/file/XXXXX`:
- Note it for Rubin to use
- Verify Paper MCP is connected by calling `get_basic_info`

If Paper isn't available:
- Say: "No worries — Rubin can still generate HTML templates and Remotion videos. Paper just gives him a proper design canvas."

## Step 6: Check Other Tools

Verify these are available (silently, don't bother the user):

| Tool | Check | Required? |
|------|-------|-----------|
| Supabase MCP | `list_projects` | Yes |
| Paper MCP | `get_basic_info` | Nice to have |
| Remotion | `~/Documents/Software Projects/bukito-video/` exists | Nice to have |
| Runway API | `~/.claude/api-keys.conf` has RUNWAY key | Nice to have |
| Postiz | `~/Documents/Software Projects/bukito-postiz/` exists | Nice to have |

Report what's connected and what's missing.

## Step 7: Load Skills

Explicitly load:
1. `bukito-brand` — Always first (brand enforcement)
2. `rubin` — Design Director
3. `helena` — Marketing Director
4. `bukito-content` — Content generation templates
5. `bukito-ugc` — UGC curation (optional)

## Step 8: Ready

Say:

```
┌──────────────────────────────────────────┐
│  ✓ ALL SYSTEMS GO                        │
│                                          │
│  Connected:                              │
│    ✓ Supabase (89 brand assets)          │
│    ✓ Brand kit (Kisrre + colors + logos)  │
│    [✓/✗] Paper (design canvas)           │
│    [✓/✗] Remotion (video)                │
│    [✓/✗] Runway (AI video)               │
│    [✓/✗] Postiz (auto-posting)           │
│                                          │
│  Say:                                    │
│    "Ask Rubin to..." — design tasks      │
│    "Ask Helena to..." — marketing tasks  │
│    "Make bukito content" — quick post    │
│    "Plan next week" — content calendar   │
│                                          │
│  🔥 Let's build.                         │
└──────────────────────────────────────────┘
```

## Important Notes

- Rubin and Helena are SKILLS with personality, not separate chat sessions. When invoked, Claude adopts their voice and expertise.
- Brand enforcement is automatic — any Bukito design work loads the brand skill.
- Photos are at `~/bukito-brand-assets/photos/` and Supabase Storage.
- The Golden Standard LUT is at `~/bukito-brand-assets/lut/BUKITO_GoldenStandard.cube` for Lightroom/Resolve.
