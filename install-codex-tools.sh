#!/usr/bin/env bash
# Registers shared-skills/*/SKILL.md as Codex global skills, and also installs
# stripped Codex CLI custom prompts as a fallback.
#
# Skills are symlinked into $CODEX_HOME/skills (or ~/.codex/skills), so edits to
# shared-skills/*/SKILL.md are picked up immediately. Prompts are copied into
# $CODEX_HOME/prompts (or ~/.codex/prompts) with YAML frontmatter stripped, so
# they can still be invoked manually with /<skill-name>.
#
# Usage: shared-skills/install-codex-tools.sh
# Target dirs:
#   skills:  $CODEX_HOME/skills  if CODEX_HOME is set, else ~/.codex/skills
#   prompts: $CODEX_HOME/prompts if CODEX_HOME is set, else ~/.codex/prompts

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/shared-skills"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
SKILL_TARGET_DIR="$CODEX_DIR/skills"
PROMPT_TARGET_DIR="$CODEX_DIR/prompts"

mkdir -p "$SKILL_TARGET_DIR" "$PROMPT_TARGET_DIR"

linked=0
verified=0
prompts_installed=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  [ "$skill_name" = "_shared" ] && continue
  [ "$skill_name" = "docs" ] && continue
  [ "$skill_name" = "references" ] && continue
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue

  skill_link_path="$SKILL_TARGET_DIR/$skill_name"
  absolute_target="${skill_dir%/}"

  if [ -L "$skill_link_path" ] && [ "$(readlink "$skill_link_path")" = "$absolute_target" ]; then
    echo "Verified skill: $skill_link_path -> $absolute_target"
    verified=$((verified + 1))
  else
    rm -rf "$skill_link_path"
    ln -s "$absolute_target" "$skill_link_path"
    echo "Registered skill: $skill_link_path -> $absolute_target"
    linked=$((linked + 1))
  fi

  prompt_target_file="$PROMPT_TARGET_DIR/$skill_name.md"

  awk '
    BEGIN { fm = 0 }
    /^---$/ { fm++; next }
    fm >= 2 { print }
  ' "$skill_file" > "$prompt_target_file"

  echo "Installed prompt fallback: /$skill_name -> $prompt_target_file"
  prompts_installed=$((prompts_installed + 1))
done

echo ""
echo "Registered/verified $((linked + verified)) Codex global skill(s) in $SKILL_TARGET_DIR ($linked updated, $verified already correct)."
echo "Installed $prompts_installed Codex prompt fallback(s) to $PROMPT_TARGET_DIR."
echo "Open a new Codex session for global skill discovery to refresh; invoke fallback prompts with: /<skill-name>"
