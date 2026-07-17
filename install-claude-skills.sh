#!/usr/bin/env bash
# Wires shared-skills/*/SKILL.md into Claude Code's native skill-discovery
# path (.claude/skills/) via relative symlinks, so the Skill tool lists them
# without having to manually point Claude at the file path each time.
#
# Symlinks (not copies) mean edits to shared-skills/*/SKILL.md are picked up
# immediately — this script only needs to be re-run when a *new* skill
# directory is added, not after every edit to an existing one.
#
# Usage: shared-skills/install-claude-skills.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/shared-skills"
TARGET_DIR="$REPO_ROOT/.claude/skills"

mkdir -p "$TARGET_DIR"

linked=0
skipped=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  [ "$skill_name" = "_shared" ] && continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  link_path="$TARGET_DIR/$skill_name"
  relative_target="../../shared-skills/$skill_name"

  if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$relative_target" ]; then
    skipped=$((skipped + 1))
    continue
  fi

  rm -rf "$link_path"
  ln -s "$relative_target" "$link_path"
  echo "Linked: .claude/skills/$skill_name -> shared-skills/$skill_name"
  linked=$((linked + 1))
done

echo ""
echo "Linked $linked new skill(s), $skipped already up to date."
echo "Claude Code's Skill tool should now list these from $TARGET_DIR"
