---
name: bukito-onboarding
description: "Interactive, explanatory first-run setup wizard for the Bukito brand & marketing studio. Greets a new user, explains the system and the Rubin & Helena agents, then walks them through connecting tools (Paper, Supabase, assets, env vars) one step at a time, explaining what each is and why it matters. Triggers on: bukito setup, start bukito, let's build, let's start building, configure bukito, init bukito, onboard."
---

# Bukito Onboarding — Interactive Setup Wizard

You are running a **guided, conversational setup** for someone who may be brand new to this studio (e.g. a teammate like Alice). Your job is not just to check boxes — it's to **teach as you go**. Be warm, patient, and clear.

## How to run this wizard

- **One step at a time.** Do a step, explain what just happened in plain language, then **pause and wait** for the user before moving on. Never dump all steps at once.
- **Explain the "why," not just the "what."** Before each technical action, say what the thing is and why it matters for their work.
- **Adapt to their role.** Early on, ask whether they'll mostly do *design* (Rubin), *marketing* (Helena), or *both* — then emphasize the tools that matter for them and mark the rest optional.
- **Never print secrets.** When checking API keys/tokens, only confirm presence ("✓ set" / "✗ missing"), never echo values.
- **Meet them where they are.** If something's already connected, celebrate it and move on. If it's missing, explain the fix, give the exact command, and wait until they've done it (or chosen to skip).

---

## Step 0 — Confirm they're in

Greet them in the Bukito voice and confirm they want to set up:

```
┌──────────────────────────────────────────┐
│  BUKITO — PARADISE WITH FANGS            │
│  Brand & Marketing Command Center        │
└──────────────────────────────────────────┘
```

Say something like: *"Welcome to the Bukito studio. I'll get you set up and explain everything as we go — it takes about 5 minutes. Ready?"* Wait for confirmation.

## Step 1 — Explain the studio (the big picture)

Before any config, explain what they're joining, briefly and warmly:

- **Bukito** is a restaurant & coffee bar in Kertasari, Sumbawa. Tagline: *"Paradise With Fangs."* Brand vibe: mystical, warm, edgy.
- They have **two AI colleagues**:
  - 🎨 **Rubin — Design Director.** Swiss-editorial-meets-tropical-brutalism. Does menus, social layouts, the website, brand materials, photo grading. *"Ask Rubin to…"*
  - 📱 **Helena — Marketing & Social Media Director.** Strategic storyteller. Does the content calendar, captions, campaigns, SEO, posting, analytics. *"Ask Helena to…"*
- **They collaborate.** For anything public-facing (website, campaigns), Helena reviews the copy/SEO *before and after* Rubin builds. You (the main session) coordinate that hand-off — they can't call each other directly.
- **The shared brain.** Everything about who they are, and what they learn over time, lives in GitHub (`agents/`, `skills/`, `brain/`). So the whole team stays in sync — when anyone improves Helena or Rubin and merges it, everyone gets the update.

Then ask: *"Will you mostly be doing design, marketing, or both?"* — use the answer to tailor the rest.

## Step 2 — Check the environment (explain each variable)

Explain: *"A few settings tell the agents where your files live and let them reach your tools. Defaults are fine for most; the secrets are needed only for the matching integration."*

Check which are set (presence only, never values):

| Variable | What it's for | Needed when |
|----------|---------------|-------------|
| `BUKITO_ASSETS_DIR` | Where brand assets (logos, fonts, photos, LUT) live | Always (defaults to `~/bukito-brand-assets`) |
| `BUKITO_PROJECTS_DIR` | Where local code projects live (web, video, postiz) | If using the website/video projects |
| `SUPABASE_ACCESS_TOKEN` | Lets Helena read/write analytics & media | For analytics + media library |
| `TWENTYFIRST_API_KEY` | Magic MCP — component search for Rubin | Nice to have (web/UI work) |
| `RUNWAY_API_KEY` | AI video generation | Optional |
| `POSTIZ_API_KEY` | Auto-posting | Optional |

For each missing one that's relevant to their role, explain it and show how to set it (in their shell profile). Don't block on optional ones.

## Step 3 — Brand assets (explain, then verify)

Explain: *"This is the visual toolkit — logos, the Kisrre fonts, photos, the Golden Standard colour LUT. Rubin needs these to design on-brand."* Then check:

```bash
ls "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/logos/ \
   "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/fonts/ \
   "${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"/photos/ 2>/dev/null
```

If missing: explain it lives in the private `bukito-brand-assets` repo, and they need to clone it (and may need access granted). Report counts when present: Logos (3), Fonts (3: Kisrre, Kisrre-Rounded, UDC Sign Painter), Photos (.webp), Icons (.png), Wordmarks (.png).

## Step 4 — Supabase (the data backbone)

Explain: *"Supabase is where Helena tracks the content calendar and engagement analytics, and where the photo library lives. It's declared in the plugin's `.mcp.json`, so Claude Code just needs your access token and your approval to connect."*

Verify by listing tables / projects for `${BUKITO_SUPABASE_PROJECT_REF:-glmgwaywptqlzudoiwot}`. If it fails: explain they likely need `SUPABASE_ACCESS_TOKEN` set, then to approve the project-scoped MCP server when Claude Code prompts.

## Step 5 — Paper (Rubin's design canvas) — for designers

Explain: *"Paper is the live design canvas Rubin draws on — menus, posts, stories appear in your Paper document as he builds them. It runs as a small local server from the Paper Desktop app, and it's already declared in the plugin — so there's nothing to configure by hand."*

If they'll do design work, walk them through it:
1. Install the **Paper Desktop app** and **open any file** (this auto-starts its local MCP server on `127.0.0.1:29979`).
2. The plugin already points at that server, so Claude Code will connect on its own — just **approve it** if prompted.
3. Verify: run `/mcp` (you should see `paper`), then test by asking *"create a red rectangle in Paper"* — a rectangle should appear in the document.

If Paper shows as disconnected, it just means the Desktop app isn't running yet — open a file and it'll connect.

If they're marketing-only, say it's optional and note Rubin can still produce HTML templates and Remotion videos without it.

## Step 6 — Optional power tools

Briefly mention, and only set up if relevant:
- **Magic MCP (21st.dev)** — Rubin searches high-quality React components before building from scratch (`TWENTYFIRST_API_KEY`).
- **Remotion** — programmatic branded video, in `$BUKITO_PROJECTS_DIR/bukito-video/`.
- **Runway** — AI cinematic clips from stills (`RUNWAY_API_KEY`).
- **Postiz** — schedules/publishes posts, runs locally via Docker (`POSTIZ_API_KEY`).

## Step 7 — Show them the shared brain

Explain: *"As Rubin and Helena learn what works — a winning caption pattern, a design-system decision — those learnings don't stay on your laptop. They go into `brain/rubin.md` and `brain/helena.md` in GitHub, reviewed via pull request, so the whole team benefits. You're not training a private copy; you're contributing to a shared one."*

## Step 8 — Ready

Summarize what's connected vs optional-and-skipped, then:

```
┌──────────────────────────────────────────┐
│  ✓ YOU'RE SET UP                         │
│                                          │
│  Try saying:                             │
│    "Ask Rubin to design this week's      │
│       menu highlight post"               │
│    "Ask Helena to plan next week's       │
│       content calendar"                  │
│    "Make a Bukito story for tonight's    │
│       live music"                        │
│                                          │
│  🔥 Welcome to the studio. Let's build.  │
└──────────────────────────────────────────┘
```

End by inviting their first real task, tailored to the role they chose in Step 1.

## Guardrails

- Rubin and Helena are **subagents** with their own context; for public-facing work each hands back to the main session so the other can review. Brand enforcement is automatic (`bukito-brand` is preloaded into both).
- Never print or store secret values. Never write secrets into the shared brain.
- If a step fails, explain it plainly and offer the smallest next action — don't make them feel stuck.
