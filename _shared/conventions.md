# Shared Conventions for `shared-skills/`

All skills in this directory are authored under these repository-wide rules. Every skill file must comply; this document is the single normative reference — individual skills should link back here rather than restate it.

## 1. Source of truth

`shared-skills/` is the only place skill definitions are edited. Do not fork copies elsewhere in the repo.

## 2. Source ID traceability

Every factual claim in a skill's output must carry a `Source ID` — a short reference the user or a downstream reviewer can trace back to where the fact came from (e.g. `SRC-JIRA-1234`, `SRC-SLACK-2026-07-01`, `SRC-INTERVIEW-emp014`, `SRC-DASH-costexplorer`). If no source exists, the output must say so explicitly rather than omit the field.

## 3. Fact / Pattern / Hypothesis labeling

Every output line that asserts something must be tagged as one of:

- **Fact** — directly observed/reported, has a Source ID.
- **Pattern** — a recurring trend inferred across multiple Facts (must cite the Facts it's built from).
- **Hypothesis** — an unconfirmed explanation or prediction. Must be labeled as such and never presented as a Fact.

## 4. Prohibited fabrication

Skills must never invent, or allow their output to imply without evidence:

- Customer commitments or promises
- Incident root causes before investigation is complete
- Individual performance judgments not tied to observed behavior
- Delivery dates or cost/benefit figures not derived from stated assumptions or real data

## 5. Draft-only external and people content

Any customer-facing message, legal/commercial statement, or people-related communication (feedback, performance content, org changes) produced by a skill is a **draft**. Output must label it as a draft requiring human review and sign-off before it is sent or acted on.

## 6. No unauthorized action

Skills only produce analysis, drafts, and recommendations. They must never claim to have performed, authorized, or committed the org to:

- Destructive infrastructure or data operations
- Cloud environment changes
- Contractual or commercial commitments
- Admissions of customer liability

## 7. Required skill sections

Every `SKILL.md` under `shared-skills/` must contain these sections, in this order:

1. `## Trigger`
2. `## Required Input`
3. `## Workflow`
4. `## Output Contract`
5. `## Safety Constraints`
6. `## Missing-Data Behavior`
7. `## Self-Review Checklist`
8. `## Anonymized Eval Case`

`scripts/validate-skills.sh` checks structurally for these sections and for a set of prohibited absolute-commitment phrases used outside of a prohibition context.

## 8. Missing-data default behavior

When required input is not provided or evidence is insufficient, a skill must:

- Explicitly output `Insufficient evidence` (or the local-language equivalent) for the affected field, not a best guess dressed as fact
- Avoid defaulting a status/severity/health indicator to a "safe-looking" value (e.g. never default an unknown project to a green light)
- List what input is missing and how to obtain it

## 9. Anonymization in eval cases

Eval cases must use fictitious names, companies, and projects. Do not use real customer names, real employee names, or real incident identifiers copied from production systems.
