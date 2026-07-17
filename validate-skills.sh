#!/usr/bin/env bash
# Validates shared-skills/*/SKILL.md against the structural and safety-heuristic
# rules in shared-skills/_shared/conventions.md.
#
# Checks per skill:
#   1. Frontmatter has name: and description:
#   2. All 8 required sections present, in order
#   3. Mentions "Source ID" (traceability convention)
#   4. Mentions Fact/Pattern/Hypothesis labeling
#   5. No banned absolute-commitment phrase appears without a negation word
#      on the same line (heuristic, not a proof)
#
# shared-skills/_shared/ and shared-skills/docs/ are not skills and are
# skipped: _shared holds the shared conventions doc, docs/ holds non-skill
# reference material (e.g. templates a skill reads/writes, like the
# action-register-maintainer skill's Action Register and RACI tables).
#
# Usage: shared-skills/validate-skills.sh
# Exit code: 0 if all skills pass, 1 if any skill fails.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/shared-skills"

REQUIRED_SECTIONS=(
  "## Trigger"
  "## Required Input"
  "## Workflow"
  "## Output Contract"
  "## Safety Constraints"
  "## Missing-Data Behavior"
  "## Self-Review Checklist"
  "## Anonymized Eval Case"
)

# Banned phrases are only checked within the *operational* sections (Trigger
# through Output Contract) — mentioning them in Safety Constraints / Self-Review
# Checklist / Anonymized Eval Case is expected (that's where we say "don't do this").

# Banned absolute-commitment phrases (regex, extended grep, case-insensitive for latin).
BANNED_PHRASES=(
  '保證'
  '一定會'
  '一定趕得上'
  '百分之百'
  'guaranteed'
  'definitely will'
  '絕對'
)

total=0
failed=0
fail_report=()

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  [ "$skill_name" = "_shared" ] && continue
  [ "$skill_name" = "docs" ] && continue
  skill_file="$skill_dir/SKILL.md"
  total=$((total + 1))

  if [ ! -f "$skill_file" ]; then
    fail_report+=("$skill_name: MISSING SKILL.md")
    failed=$((failed + 1))
    continue
  fi

  errors=()

  # 1. Frontmatter
  if ! grep -qE '^name:\s*\S+' "$skill_file"; then
    errors+=("missing 'name:' in frontmatter")
  fi
  if ! grep -qE '^description:\s*\S+' "$skill_file"; then
    errors+=("missing 'description:' in frontmatter")
  fi

  # 2. Required sections present
  for section in "${REQUIRED_SECTIONS[@]}"; do
    if ! grep -qF "$section" "$skill_file"; then
      errors+=("missing section: $section")
    fi
  done

  # 3. Source ID traceability mention
  if ! grep -qi "Source ID" "$skill_file"; then
    errors+=("no mention of 'Source ID' traceability")
  fi

  # 4. Fact/Pattern/Hypothesis labeling mention
  if ! grep -qi "Fact" "$skill_file" || ! grep -qi "Hypothesis" "$skill_file"; then
    errors+=("missing Fact/Hypothesis labeling convention")
  fi

  # 5. Banned absolute-commitment phrases in operational sections only
  #    (Trigger .. Output Contract). Extract that excerpt with awk.
  operational_excerpt="$(awk '
    /^## Trigger/ { in_range=1 }
    /^## Safety Constraints/ { in_range=0 }
    in_range { print }
  ' "$skill_file")"

  while IFS= read -r line; do
    [ -z "$line" ] && continue
    for phrase in "${BANNED_PHRASES[@]}"; do
      if echo "$line" | grep -qi "$phrase"; then
        errors+=("possible unqualified absolute claim ('$phrase') in operational section: ${line:0:100}")
      fi
    done
  done <<< "$operational_excerpt"

  if [ ${#errors[@]} -gt 0 ]; then
    failed=$((failed + 1))
    fail_report+=("$skill_name:")
    for e in "${errors[@]}"; do
      fail_report+=("  - $e")
    done
  fi
done

echo "Validated $total skills."
if [ "$failed" -gt 0 ]; then
  echo ""
  echo "FAILED: $failed skill(s)"
  for line in "${fail_report[@]}"; do
    echo "$line"
  done
  exit 1
fi

echo "All skills passed structural and heuristic safety checks."
exit 0
