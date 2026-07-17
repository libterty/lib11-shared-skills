#!/usr/bin/env bash
# Installs shared-skills/*/SKILL.md as Codex CLI custom prompts, so they can
# be invoked with /<skill-name> in Codex the same way they're used in Claude
# Code by pointing at the SKILL.md file directly.
#
# Codex prompts don't need YAML frontmatter, so it's stripped on copy — only
# the body (Trigger..Anonymized Eval Case) is installed.
#
# Usage: shared-skills/install-codex-prompts.sh
# Target dir: $CODEX_HOME/prompts if CODEX_HOME is set, else ~/.codex/prompts

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/shared-skills"
TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/prompts"

mkdir -p "$TARGET_DIR"

installed=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  [ "$skill_name" = "_shared" ] && continue
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue

  target_file="$TARGET_DIR/$skill_name.md"

  awk '
    BEGIN { fm = 0 }
    /^---$/ { fm++; next }
    fm >= 2 { print }
  ' "$skill_file" > "$target_file"

  echo "Installed: /$skill_name -> $target_file"
  installed=$((installed + 1))
done

echo ""
echo "Installed $installed Codex prompt(s) to $TARGET_DIR"
echo "Invoke in Codex CLI with: /<skill-name>"
