---
name: bukito-onboarding
description: "First-run onboarding for the Bukito brand & marketing studio. Verifies brand assets and MCP servers, configures tools, and introduces the Rubin & Helena agents. Triggers on: bukito setup, start bukito, let's build, let's start building, configure bukito, init bukito."
---

# Bukito Onboarding — First Run Setup

When this skill triggers, run the following setup sequence.

> **Architecture note.** Rubin (Design Director) and Helena (Marketing Director) are **subagents** (`agents/rubin.md`, `agents/helena.md`) — Claude delegates to them and they each run in their own context. The brand/content/UGC capabilities are **skills**. MCP servers are declared in `.mcp.json`. Everything ships as the `bukito` plugin.

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

## Step 3: Check Environment Variables

These configure paths and credentials. Defaults are used when unset.

| Variable | Purpose | Default |
|----------|---------|---------|
| `BUKITO_ASSETS_DIR` | Brand assets (logos, fonts, photos, LUT) | `~/bukito-brand-assets` |
| `BUKITO_PROJECTS_DIR` | Local code projects (web, video, postiz) | `~/Documents/Software Projects` |
| `BUKITO_SUPABASE_PROJECT_REF` | Supabase project ref | `glmgwaywptqlzudoiwot` |
| `SUPABASE_ACCESS_TOKEN` | Supabase MCP auth | _(required for analytics)_ |
| `TWENTYFIRST_API_KEY` | Magic MCP (21st.dev) | _(optional)_ |
| `RUNWAY_API_KEY` | AI video generation | _(optional)_ |
| `POSTIZ_API_KEY` | Auto-posting | _(optional)_ |

Report which are set vs. using defaults. Never print secret values.

## Step 4: Verify MCP Servers

The plugin declares MCP servers in `.mcp.json` (Supabase, Magic). Confirm they connected:

| Server | Check | Required? |
|--------|-------|-----------|
| Supabase | `list_projects` (or list tables for the project ref) | Yes — analytics & media |
| Magic (21st.dev) | component-builder tool available | Nice to have |
| Paper | `get_basic_info` (configure manually — see README) | Nice to have |

If Supabase fails, the user likely needs `SUPABASE_ACCESS_TOKEN` set, then approve the project-scoped `.mcp.json` server.

## Step 5: Verify Brand Assets

```bash
ls "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/logos/ \
   "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/fonts/ \
   "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/photos/
```

If missing, tell the user to clone the brand-assets repo (see README) or run `install.sh`.

Report asset count:
- Logos (3): SnakeBread, SnakeCoffee, SnakePalm
- Fonts (3): Kisrre, Kisrre-Rounded, UDC Sign Painter
- Photos: count .webp files
- Icons: count .png files in icons/
- Wordmarks: count .png files in wordmarks/

## Step 6: Ask for Paper Link

Say: "Do you have Paper open? Share the file URL so Rubin can design directly on your canvas."

If they share a URL like `https://app.paper.design/file/XXXXX`:
- Note it for Rubin to use
- Verify Paper MCP is connected by calling `get_basic_info`

If Paper isn't available:
- Say: "No worries — Rubin can still generate HTML templates and Remotion videos. Paper just gives him a proper design canvas."

## Step 7: Confirm Capabilities Are Loaded

- **Skills**: `bukito-brand`, `bukito-content`, `bukito-ugc` (auto-trigger on relevant requests; `bukito-brand` is preloaded into both agents).
- **Agents**: `rubin` and `helena` are available for delegation — no manual loading needed. Claude routes design tasks to Rubin and marketing tasks to Helena automatically.

## Step 8: Ready

Say:

```
┌──────────────────────────────────────────┐
│  ✓ ALL SYSTEMS GO                        │
│                                          │
│  Connected:                              │
│    [✓/✗] Supabase (brand assets + data)  │
│    ✓ Brand kit (Kisrre + colors + logos)  │
│    [✓/✗] Paper (design canvas)           │
│    [✓/✗] Magic / Remotion / Runway       │
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

- **Rubin and Helena are subagents** — each runs in its own context with persistent project memory. They cannot invoke each other directly; for collaborative (public-facing) work, each hands the task back to the main session so the other can be brought in. Brand enforcement is automatic — `bukito-brand` is preloaded into both.
- Photos are at `$BUKITO_ASSETS_DIR/photos/` and in Supabase Storage.
- The Golden Standard LUT is at `$BUKITO_ASSETS_DIR/lut/BUKITO_GoldenStandard.cube` for Lightroom/Resolve.
- Never print or store secret values (API keys, tokens) — use environment variables.
