#!/bin/bash
# ============================================
# BUKITO BRAND & MARKETING — Manual Setup (fallback)
# ============================================
# RECOMMENDED: install as a Claude Code plugin instead —
#   /plugin marketplace add Bruru1981/bukito-setup
#   /plugin install bukito@bukito-studio
#
# Use this script only if you can't use plugins. It copies the
# skills and agents into ~/.claude and sets up brand assets/fonts.
# ============================================

set -euo pipefail

# ---- Config (override via environment) -------------------------------------
BUKITO_ASSETS_DIR="${BUKITO_ASSETS_DIR:-$HOME/bukito-brand-assets}"
BRAND_ASSETS_REPO="${BUKITO_BRAND_ASSETS_REPO:-https://github.com/Bruru1981/bukito-brand-assets.git}"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │  BUKITO — PARADISE WITH FANGS        │"
echo "  │  Brand & Marketing Agent Setup        │"
echo "  └──────────────────────────────────────┘"
echo ""
echo "  Tip: prefer '/plugin install bukito@bukito-studio' — see README."
echo ""

# ---- 1. Clone/update brand assets (optional, may be private) ---------------
echo "→ Brand assets..."
if [ ! -d "$BUKITO_ASSETS_DIR" ]; then
  if git clone "$BRAND_ASSETS_REPO" "$BUKITO_ASSETS_DIR" 2>/dev/null; then
    echo "  ✓ Brand assets cloned to $BUKITO_ASSETS_DIR"
  else
    echo "  ⚠ Could not clone $BRAND_ASSETS_REPO (private or unreachable)."
    echo "    Skills will still install. Set up assets manually at:"
    echo "    $BUKITO_ASSETS_DIR   (or set BUKITO_ASSETS_DIR / BUKITO_BRAND_ASSETS_REPO)"
  fi
else
  git -C "$BUKITO_ASSETS_DIR" pull --ff-only 2>/dev/null \
    && echo "  ✓ Brand assets updated" \
    || echo "  ⚠ Could not update assets at $BUKITO_ASSETS_DIR (skipping)."
fi

# ---- 2. Install skills ------------------------------------------------------
echo ""
echo "→ Installing skills..."
SKILLS_DEST="$CLAUDE_DIR/skills"
mkdir -p "$SKILLS_DEST"
for skill_dir in "$SRC_DIR"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  mkdir -p "$SKILLS_DEST/$name"
  cp "$skill_dir/SKILL.md" "$SKILLS_DEST/$name/SKILL.md"
  echo "  ✓ skill: $name"
done

# ---- 3. Install agents (Rubin & Helena) ------------------------------------
echo ""
echo "→ Installing agents..."
AGENTS_DEST="$CLAUDE_DIR/agents"
mkdir -p "$AGENTS_DEST"
for agent_file in "$SRC_DIR"/agents/*.md; do
  [ -f "$agent_file" ] || continue
  cp "$agent_file" "$AGENTS_DEST/"
  echo "  ✓ agent: $(basename "${agent_file%.md}")"
done

# ---- 4. Install fonts (cross-platform) -------------------------------------
echo ""
echo "→ Installing Bukito fonts..."
case "$(uname -s)" in
  Darwin) FONT_DIR="$HOME/Library/Fonts" ;;
  Linux)  FONT_DIR="$HOME/.local/share/fonts" ;;
  *)      FONT_DIR="" ;;
esac

if [ -n "$FONT_DIR" ] && [ -d "$BUKITO_ASSETS_DIR/fonts" ]; then
  mkdir -p "$FONT_DIR"
  installed=0
  for font in "$BUKITO_ASSETS_DIR"/fonts/*.otf; do
    [ -f "$font" ] || continue
    cp "$font" "$FONT_DIR/" 2>/dev/null && installed=$((installed + 1))
  done
  [ "$(uname -s)" = "Linux" ] && command -v fc-cache >/dev/null 2>&1 && fc-cache -f "$FONT_DIR" >/dev/null 2>&1 || true
  echo "  ✓ $installed font(s) installed to $FONT_DIR"
else
  echo "  ⚠ Skipped (no font dir for this OS, or assets not present)."
fi

# ---- 5. Done ----------------------------------------------------------------
echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │  ✓ SETUP COMPLETE                    │"
echo "  │                                      │"
echo "  │  Agents:                             │"
echo "  │    🎨 Rubin  — Design Director       │"
echo "  │    📱 Helena — Marketing Director    │"
echo "  │  Skills:                             │"
echo "  │    🎯 bukito-brand   📝 bukito-content│"
echo "  │    📸 bukito-ugc     🚀 onboarding   │"
echo "  │                                      │"
echo "  │  Next:                               │"
echo "  │    1. Open Claude Code               │"
echo "  │    2. Set required env vars (README) │"
echo "  │    3. Say: 'bukito setup'            │"
echo "  └──────────────────────────────────────┘"
echo ""
