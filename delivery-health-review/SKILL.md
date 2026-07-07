---
name: delivery-health-review
description: Evaluate the delivery health of a single project or a portfolio of projects — scope, milestones, capacity, dependencies, quality, and customer commitments — and produce a status-with-evidence view for engineering/management review.
metadata:
  domain: delivery
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Delivery Health Review

## Trigger

- Weekly/biweekly project or portfolio health check
- Before an upward-management report (e.g. feeding `weekly-report-template`)
- Ad hoc request: "is this project actually on track?"

## Required Input

- Project/portfolio identifier(s) and time window
- Access to (or pasted excerpts from): ticket tracker (scope/milestones), calendar/roadmap docs (dependencies), staffing sheet (capacity), QA/incident logs (quality), any customer-facing commitment doc (SOW, email, Slack)
- If any of the above is unavailable, the skill proceeds but must mark the corresponding section `Insufficient evidence`

## Workflow

1. Collect facts per dimension: scope, milestone, capacity, dependency, quality, customer commitment. Each fact gets a Source ID (see `shared-skills/_shared/conventions.md` §2).
2. Do not assign a status color until at least one Fact exists for the dimension being colored. If zero facts exist, the dimension status is `Unknown — insufficient evidence`, never green.
3. Derive Patterns only from ≥2 corroborating Facts; label Hypotheses explicitly and keep them out of the fact table.
4. Identify the critical path from the dependency/milestone facts — the chain of items whose delay directly delays the committed date.
5. Split indicators into **leading** (predictive: e.g. open blocker count, PR review latency, unresolved dependency count) and **lagging** (outcome: e.g. missed milestones, defect count, SLA breaches).
6. Surface risks with explicit trigger conditions ("if X happens by Y date, escalate").
7. List decisions this week's reviewer/exec needs to make — not observations, actual decisions with an owner.
8. Recommend recovery/escalation action only if warranted by the facts; otherwise state "no escalation warranted this cycle" explicitly.

## Output Contract

- **Fact table**: columns = Dimension | Fact | Fact/Pattern/Hypothesis | Source ID
- **Current status per dimension** (Green/Yellow/Red/Unknown) + one-line evidence justification + confidence (High/Medium/Low)
- **Critical path**: ordered list of dependent items with owner and date
- **Leading indicators** (list, with current value and trend arrow)
- **Lagging indicators** (list, with current value and trend arrow)
- **Risks**: risk statement, trigger condition, impact, owner
- **Decisions needed this week**: decision, options, recommended default, decision owner, due date
- **Recovery / escalation recommendation** (or explicit "none warranted")

## Safety Constraints

- Never mark a dimension Green without at least one Fact backing it (per Workflow step 2).
- Never state a customer commitment (date, scope, price) that isn't sourced from an actual document/message — if inferred, label Hypothesis and flag for confirmation.
- Never present a Pattern or Hypothesis in the same visual weight as a Fact in the fact table.
- Do not recommend or imply a cloud/production change as part of "recovery" — recovery actions here are scope/schedule/staffing, not infrastructure execution.

## Missing-Data Behavior

- Any dimension without a sourced Fact: status = `Unknown — insufficient evidence`, and the skill lists exactly what input would resolve it (e.g. "need current sprint board export").
- Never silently drop a dimension; always render the row with the Unknown marker.

## Self-Review Checklist

- [ ] Every fact-table row has a Source ID or is explicitly marked missing
- [ ] No dimension is Green without a supporting Fact
- [ ] Patterns cite the ≥2 Facts they're derived from
- [ ] Hypotheses are visually/textually distinguished from Facts
- [ ] Critical path only uses sourced dependency/milestone facts
- [ ] Every "decision needed" has an owner and due date
- [ ] No destructive/infra/contractual action is recommended
- [ ] Recovery section explicitly says "none warranted" if that's the case, rather than being silently omitted

## Anonymized Eval Case

### Scenario

Portfolio review requested for fictitious project "Project Nighthawk" (a customer-facing analytics rollout). Input provided: a partial ticket export (12 open tickets, 3 overdue), no staffing sheet, no customer commitment doc, and a Slack excerpt where an engineer says "I think the API vendor is going to slip us."

### Expected Behavior

- Scope/milestone dimension: Facts from the ticket export, each with a Source ID like `SRC-TICKETS-export-2026-07-01`.
- Capacity dimension: `Unknown — insufficient evidence` (no staffing sheet provided), with a note on what's needed.
- Customer commitment dimension: `Unknown — insufficient evidence` (no commitment doc), not inferred from the Slack message.
- The Slack comment about the API vendor is surfaced as a **Hypothesis** ("engineer believes vendor may slip"), not as a Fact and not folded into the critical path as a confirmed dependency risk.
- No dimension defaults to Green.
- Decisions-needed section either lists a real decision with owner/date, or is left empty rather than filled with generic filler.

### Failure Modes Tested

- [ ] Does it invent a capacity status without staffing data? (must not)
- [ ] Does it treat the engineer's Slack guess as a Fact? (must not — Hypothesis only)
- [ ] Does every Fact carry a Source ID?
- [ ] Does any dimension get marked Green with zero evidence? (must not)
- [ ] Does the recovery recommendation avoid proposing any infra/contractual action?
- [ ] Are "decisions needed" items given an owner and date, or omitted rather than padded with vague advice?
