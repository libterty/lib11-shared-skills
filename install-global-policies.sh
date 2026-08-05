#!/usr/bin/env bash
# Installs (or updates) every skill's "always apply this globally" policy
# into Claude Code's ~/.claude/CLAUDE.md and Codex's ~/.codex/AGENTS.md.
#
# This is what makes a skill like communication-writing or
# communication-riqc the *default* standard instead of something you have
# to remember to invoke: both CLIs read their global config file at the
# start of every session, so any forcing rule installed here is always in
# context, on any project, on any machine.
#
# Auto-discovers policies: any shared-skills/<skill-name>/global-policy-snippet.md
# file becomes its own managed block, keyed by <skill-name>. A skill opts
# into "global highest-priority" status simply by having this file — no
# need to edit this script when adding a new one.
#
# Idempotent: each policy's text lives in exactly one place
# (<skill-name>/global-policy-snippet.md) and gets wrapped in a delimited
# managed block per skill. Re-running this script after `git pull` updates
# just those blocks in place — any other personal content you've added to
# CLAUDE.md / AGENTS.md, or blocks for skills not present in this checkout,
# are left untouched.
#
# Usage (from anywhere, after cloning this repo on a new machine):
#   shared-skills/install-global-policies.sh
#
# Also run these so the skills themselves are discoverable, not just the
# rules that point to them:
#   shared-skills/install-claude-tools.sh
#   shared-skills/install-codex-tools.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_block() {
  local target_file="$1"
  local skill_name="$2"
  local snippet_file="$3"

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"

  python3 - "$target_file" "$snippet_file" "$skill_name" <<'PYEOF'
import sys

target_path, snippet_path, skill_name = sys.argv[1:4]
begin_marker = f"<!-- BEGIN {skill_name}-policy (managed by going-cloud/shared-skills -- edit shared-skills/{skill_name}/global-policy-snippet.md, not this block) -->"
end_marker = f"<!-- END {skill_name}-policy -->"

with open(target_path, encoding="utf-8") as f:
    original = f.read()

with open(snippet_path, encoding="utf-8") as f:
    snippet = f.read().rstrip("\n")

block = f"{begin_marker}\n{snippet}\n{end_marker}\n"

if begin_marker in original and end_marker in original:
    start = original.index(begin_marker)
    end = original.index(end_marker) + len(end_marker)
    end_with_nl = end + 1 if end < len(original) and original[end] == "\n" else end
    updated = original[:start] + block + original[end_with_nl:]
    action = "Updated"
else:
    sep = "" if original.endswith("\n") or original == "" else "\n"
    updated = original + sep + ("\n" if original.strip() else "") + block
    action = "Appended"

with open(target_path, "w", encoding="utf-8") as f:
    f.write(updated)

print(f"{action} {skill_name} policy block in {target_path}")
PYEOF
}

main() {
  local claude_target="$HOME/.claude/CLAUDE.md"
  local codex_target="$HOME/.codex/AGENTS.md"
  local count=0

  for snippet_file in "$REPO_ROOT"/*/global-policy-snippet.md; do
    [ -f "$snippet_file" ] || continue
    local skill_name
    skill_name="$(basename "$(dirname "$snippet_file")")"

    install_block "$claude_target" "$skill_name" "$snippet_file"
    install_block "$codex_target" "$skill_name" "$snippet_file"
    count=$((count + 1))
  done

  echo ""
  echo "Installed $count global polic$([ "$count" = 1 ] && echo y || echo ies) to $claude_target and $codex_target."
  echo "Now run (if you haven't already, or after adding new skills):"
  echo "  shared-skills/install-claude-tools.sh"
  echo "  shared-skills/install-codex-tools.sh  # registers Codex global skills and prompt fallbacks"
}

main "$@"
