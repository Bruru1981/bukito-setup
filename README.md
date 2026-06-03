# Bukito — Brand & Marketing Studio

A Claude Code **plugin** that turns Claude into the Bukito brand & marketing team for **Bukito** — a restaurant & coffee bar in Kertasari, Sumbawa, Indonesia. Tagline: **"Paradise With Fangs."**

It ships two agents and four skills:

| Component | Type | Role |
|-----------|------|------|
| 🎨 **Rubin** | agent | Design Director — menus, website/UI, social layouts, brand materials, photo grading |
| 📱 **Helena** | agent | Marketing & Social Media Director — content calendar, copy, campaigns, SEO, posting, analytics |
| 🎯 `bukito-brand` | skill | Brand kit: colors, typography, logo & asset rules (preloaded into both agents) |
| 📝 `bukito-content` | skill | Generates Instagram/TikTok posts, stories, reels |
| 📸 `bukito-ugc` | skill | Curates and reposts user-generated content |
| 🚀 `bukito-onboarding` | skill | First-run setup; triggers on "bukito setup" |

Rubin and Helena run as **subagents** — each has its own context window and persistent project memory. For public-facing work they collaborate through mandatory checkpoints (Helena reviews copy/SEO before and after Rubin builds).

---

## Install (recommended: plugin)

```text
/plugin marketplace add Bruru1981/bukito-setup
/plugin install bukito@bukito-studio
```

Then reload and start:

```text
/reload-plugins
```

…and in any Bukito project say **`bukito setup`** to run onboarding.

### Manual install (fallback)

If you can't use plugins, copy the skills and agents into `~/.claude` and set up fonts/assets:

```bash
./install.sh
```

This installs to `~/.claude/skills/` and `~/.claude/agents/`, clones the brand-assets repo if it's reachable, and installs fonts (macOS → `~/Library/Fonts`, Linux → `~/.local/share/fonts`).

---

## Configuration

### Environment variables

Set these in your shell profile (or Claude Code env). Defaults are used when unset; secrets have **no default** and must be provided for those integrations to work.

| Variable | Purpose | Default |
|----------|---------|---------|
| `BUKITO_ASSETS_DIR` | Brand assets (logos, fonts, photos, LUT) | `~/bukito-brand-assets` |
| `BUKITO_PROJECTS_DIR` | Local code projects (web, video, postiz) | `~/Documents/Software Projects` |
| `BUKITO_SUPABASE_PROJECT_REF` | Supabase project ref | `glmgwaywptqlzudoiwot` |
| `SUPABASE_ACCESS_TOKEN` | Supabase MCP auth (analytics + media) | _required for analytics_ |
| `TWENTYFIRST_API_KEY` | Magic MCP (21st.dev component search) | _optional_ |
| `RUNWAY_API_KEY` | AI video generation | _optional_ |
| `POSTIZ_API_KEY` | Auto-posting via Postiz | _optional_ |

> 🔒 **Never** hardcode secrets in this repo, the skills, or agent memory. They're read from the environment only.

### MCP servers

`.mcp.json` declares the MCP servers the studio uses. On first use Claude Code asks you to approve project-scoped servers.

- **supabase** — content analytics, content calendar, media library. Needs `SUPABASE_ACCESS_TOKEN`.
- **magic** (21st.dev) — React component search/inspiration for Rubin. Needs `TWENTYFIRST_API_KEY`.
- **Paper** (design canvas) — **configure manually**; add your Paper MCP server to `.mcp.json` or your user config (it isn't bundled because its endpoint is account-specific).

> The package names/args in `.mcp.json` are sensible defaults — adjust them to match the exact MCP servers you use.

---

## Brand assets

Visual assets (logos, fonts, icons, photos, LUT) live in a **separate** repo, `bukito-brand-assets`, expected at `$BUKITO_ASSETS_DIR`. If that repo is private, make sure collaborators have access — `install.sh` skips it gracefully when it can't be cloned, but the agents reference those paths.

---

## How it works

1. **Onboarding** (`bukito setup`) checks env vars, MCP servers, and brand assets, then introduces the agents.
2. **Marketing tasks** ("plan next week", "write captions", "schedule posts") route to **Helena**.
3. **Design tasks** ("make a menu", "design this post", "build the website") route to **Rubin**.
4. **Public-facing work** (website, campaigns) requires both: Helena reviews copy/SEO before and after Rubin builds. Because subagents can't call each other, each hands the task back to the main session to bring the other in.

---

## Working as a team — GitHub is the source of truth

This repo **is** the studio's shared brain. The agents' personalities, Rubin's role, Helena's vision, the brand rules — they all live in version-controlled files here, and everyone installs them *from* this repo via the marketplace. So changes flow through GitHub, not through individual machines.

**To evolve an agent or skill** (e.g. you or an analyst want to change Helena's vision or redraw Rubin's remit):

```bash
git checkout -b update-helena-vision
# edit agents/helena.md  (or agents/rubin.md, skills/*/SKILL.md)
git commit -am "Refine Helena's vision: ..."
git push -u origin update-helena-vision
# open a PR → review → merge to main
```

CI (`.github/workflows/validate.yml`) checks every PR: JSON manifests are valid, `install.sh` parses and passes shellcheck, and every skill/agent has the required frontmatter. Merge only when it's green.

**To pull everyone else's changes** after a merge:

```text
/plugin marketplace update bukito-studio
/plugin update bukito
```

Because the definitions are versioned, every change to who Rubin and Helena are is reviewable, reversible (`git revert`), and has a full history (`git log agents/helena.md`).

### The agents' memory is in GitHub too

The agents have **no local memory**. Their durable learnings live in version-controlled brain files that the whole team shares:

- `brain/rubin.md` — standing design decisions and design-system evolutions
- `brain/helena.md` — winning caption formulas, posting-time learnings, campaign results

Each agent reads its brain file before substantial work and, when it learns something durable, proposes an update via a pull request — so learnings are reviewed and synced through GitHub instead of drifting on individual machines. (Plugin/`install.sh` keep a read copy; the canonical brain is always this repo. Agents are instructed never to write secrets or PII into the brain, since it lives in git history.)

---

## Repository layout

```
.
├── .claude-plugin/
│   ├── plugin.json          # plugin manifest
│   └── marketplace.json      # marketplace listing (this repo is its own marketplace)
├── agents/
│   ├── rubin.md             # Design Director subagent
│   └── helena.md            # Marketing Director subagent
├── brain/
│   ├── rubin.md             # Rubin's shared, versioned memory
│   └── helena.md            # Helena's shared, versioned memory
├── skills/
│   ├── bukito-brand/        # brand kit (preloaded into agents)
│   ├── bukito-content/      # content generation
│   ├── bukito-ugc/          # UGC curation
│   └── bukito-onboarding/   # first-run setup
├── .mcp.json                # MCP server declarations
├── install.sh               # manual install fallback
└── README.md
```
