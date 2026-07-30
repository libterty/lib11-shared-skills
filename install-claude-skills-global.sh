#!/usr/bin/env bash
# Wires shared-skills/*/SKILL.md into Claude Code's GLOBAL native
# skill-discovery path (~/.claude/skills/) via absolute symlinks, so every
# project on this machine sees these skills, not just this repo's checkout.
#
# For project-local discovery instead, use install-claude-skills.sh.
#
# Symlinks (not copies) mean edits to shared-skills/*/SKILL.md are picked up
# immediately — this script only needs to be re-run when a *new* skill
# directory is added, not after every edit to an existing one.
#
# Usage: shared-skills/install-claude-skills-global.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/shared-skills"
TARGET_DIR="$HOME/.claude/skills"

main() {
  mkdir -p "$TARGET_DIR"

  local linked=0
  local skipped=0

  for skill_dir in "$SKILLS_DIR"/*/; do
    local skill_name
    skill_name="$(basename "$skill_dir")"
    [ "$skill_name" = "_shared" ] && continue
    [ "$skill_name" = "docs" ] && continue
    [ "$skill_name" = "references" ] && continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    local link_path="$TARGET_DIR/$skill_name"
    local absolute_target="${skill_dir%/}"

    if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$absolute_target" ]; then
      skipped=$((skipped + 1))
      continue
    fi

    rm -rf "$link_path"
    ln -s "$absolute_target" "$link_path"
    echo "Linked: ~/.claude/skills/$skill_name -> $absolute_target"
    linked=$((linked + 1))
  done

  echo ""
  echo "Linked $linked new skill(s), $skipped already up to date."
  echo "Claude Code's Skill tool should now list these globally from $TARGET_DIR"
}

main "$@"
