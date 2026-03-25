#!/bin/bash
# ============================================
# BUKITO BRAND & MARKETING — Claude Code Setup
# ============================================
# Run this script, then start Claude Code.
# Say: "Let's start building the shit out of this"
# ============================================

set -e

echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │  BUKITO — PARADISE WITH FANGS        │"
echo "  │  Brand & Marketing Agent Setup        │"
echo "  └──────────────────────────────────────┘"
echo ""

# 1. Clone brand assets
echo "→ Cloning brand assets..."
if [ ! -d "$HOME/bukito-brand-assets" ]; then
  git clone https://github.com/Bruru1981/bukito-brand-assets.git "$HOME/bukito-brand-assets"
  echo "  ✓ Brand assets cloned"
else
  cd "$HOME/bukito-brand-assets" && git pull && cd -
  echo "  ✓ Brand assets updated"
fi

# 2. Install skills
echo ""
echo "→ Installing skills..."
SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

# Copy skills from the setup package
for skill in rubin helena bukito-brand bukito-content bukito-ugc; do
  if [ -d "$(dirname "$0")/skills/$skill" ]; then
    mkdir -p "$SKILLS_DIR/$skill"
    cp "$(dirname "$0")/skills/$skill/SKILL.md" "$SKILLS_DIR/$skill/SKILL.md"
    echo "  ✓ $skill"
  fi
done

# 3. Symlink brand skill from repo (source of truth)
if [ -d "$HOME/bukito-brand-assets/skills/bukito-brand" ]; then
  rm -rf "$SKILLS_DIR/bukito-brand"
  ln -sf "$HOME/bukito-brand-assets/skills/bukito-brand" "$SKILLS_DIR/bukito-brand"
  echo "  ✓ bukito-brand symlinked to repo"
fi

# 4. Create project CLAUDE.md
echo ""
echo "→ Setting up project context..."
mkdir -p "$HOME/.claude/projects"

# 5. Install fonts
echo ""
echo "→ Installing Bukito fonts..."
FONT_DIR="$HOME/Library/Fonts"
for font in "$HOME/bukito-brand-assets/fonts/"*.otf; do
  if [ -f "$font" ]; then
    cp "$font" "$FONT_DIR/" 2>/dev/null || true
  fi
done
echo "  ✓ Fonts installed (Kisrre, Kisrre-Rounded, UDC Sign Painter)"

# 6. Setup complete
echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │  ✓ SETUP COMPLETE                    │"
echo "  │                                      │"
echo "  │  Skills installed:                   │"
echo "  │    🎨 Rubin  — Design Director       │"
echo "  │    📱 Helena — Marketing Director    │"
echo "  │    📸 bukito-ugc — UGC Curation      │"
echo "  │    🎯 bukito-brand — Brand Kit       │"
echo "  │    📝 bukito-content — Content Gen   │"
echo "  │                                      │"
echo "  │  Next steps:                         │"
echo "  │    1. Open Claude Code               │"
echo "  │    2. Say: 'bukito setup'            │"
echo "  │    3. Rubin & Helena take over       │"
echo "  └──────────────────────────────────────┘"
echo ""
