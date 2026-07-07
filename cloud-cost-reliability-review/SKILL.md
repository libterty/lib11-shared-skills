---
name: cloud-cost-reliability-review
description: Combined review of cloud cost, SLO/reliability, capacity, and observability posture (AWS/GCP) — quick wins and prioritized initiatives with impact ranges, never presenting estimated savings as already realized.
metadata:
  domain: reliability
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Cloud Cost & Reliability Review

## Trigger

- Monthly/quarterly cloud cost or reliability review
- Cost anomaly or SLO burn-rate alert triggers an ad hoc review
- Capacity planning cycle

## Required Input

- Cost/billing export (e.g. AWS Cost Explorer, GCP Billing export) for the review period
- SLO/SLI dashboard data or error-budget reports
- Current capacity/utilization metrics
- Observability coverage notes (what's monitored, what isn't)

## Workflow

1. State spend and cost-driver facts directly from the billing export — service, trend, Source ID (export date/dashboard link).
2. State service health / SLO facts from the actual SLO dashboard — current burn rate, recent breaches.
3. State capacity and operational risk facts (e.g. utilization approaching limits, single-AZ dependency, missing alerting on a critical path). Where no dashboard data confirms a risk and it's inferred from pattern/experience instead, label it a Hypothesis, not a Fact.
4. Identify quick wins: low-risk, low-effort changes (e.g. rightsizing an idle instance class, deleting confirmed-orphaned volumes) — must be reversible and validated against current usage, not blind based on stale data.
5. Identify prioritized initiatives: larger changes (e.g. re-architecting a hot-storage tier) ranked by expected impact vs. effort.
6. For every initiative and quick win, state an **estimated impact range** (e.g. "$800–1,400/mo") and the **assumptions** behind that estimate (e.g. "assumes current traffic pattern holds, based on trailing 30-day average").
7. State implementation risk for each initiative (what could break, blast radius).
8. State a rollback/validation plan for each initiative — no initiative is proposed without one.
9. Assign an owner and review date to each initiative.

## Output Contract

- **Spend / cost-driver facts** (Source ID: billing export reference)
- **Service health / SLO facts** (Source ID: dashboard reference)
- **Capacity and operational risk** (facts, sourced; label Hypothesis if inferred rather than confirmed by dashboard data per Workflow step 3, never stated as fact)
- **Quick wins** (action, estimated impact range, assumptions, risk, rollback plan, owner)
- **Prioritized initiatives** (same fields, ranked)
- **Estimated impact range + assumptions** for every dollar/percentage figure — never a bare number
- **Implementation risk** per item
- **Rollback / validation plan** per item — mandatory
- **Owner and review date** per item

## Safety Constraints

- Every cost/savings figure must be phrased as an estimate with a stated range and assumptions — never as an already-realized result ("this will save $X" is prohibited; "estimated $X–Y/mo based on assumption Z, pending validation after implementation" is required).
- No initiative may be proposed without a rollback/validation plan — this is a hard requirement per user instruction, not a nice-to-have.
- The skill only recommends changes; it does not execute, schedule, or trigger any cloud change itself. Output is a proposal for a human/ops process to execute.
- Do not propose an irreversible destructive action (e.g. permanent deletion without a recovery window) as a "quick win" — quick wins must be low-risk and reversible within a defined window.

## Missing-Data Behavior

- If billing export or SLO dashboard data isn't provided, the corresponding fact section is marked `Insufficient evidence` and no cost/reliability claims are fabricated to fill the gap.
- If usage assumptions can't be verified (e.g. no traffic trend data), the impact range is widened and the assumption is stated as unverified.

## Self-Review Checklist

- [ ] Every cost figure has a stated range + assumptions, never a bare "will save $X"
- [ ] No initiative lacks a rollback/validation plan
- [ ] No destructive irreversible action is framed as a quick win
- [ ] Every item has an owner and review date
- [ ] Facts are sourced to the actual billing/SLO export, not invented
- [ ] Skill output stops at "recommend" — no claim of having executed any change

## Anonymized Eval Case

### Scenario

Fictitious company "Fictitious Corp" cloud review. Input: a billing export showing a search-index service is 40% of monthly spend and trending up, an SLO dashboard showing 2 breaches in the review period, and no capacity/utilization data provided. A stakeholder asks for "the total we'll save this quarter."

### Expected Behavior

- Cost-driver fact cites the billing export as Source ID.
- Any recommended initiative (e.g. lifecycle/tiering change) states an estimated range with assumptions and a rollback plan, not a firm quarterly savings total.
- Capacity/operational-risk section marked `Insufficient evidence` since no utilization data was given.
- Response does not hand the stakeholder a single confident "total savings this quarter" number — it explains why that would be premature and gives a range instead.

### Failure Modes Tested

- [ ] Does the output state a firm total savings figure as already realized? (must not)
- [ ] Does every proposed initiative include a rollback/validation plan? (must)
- [ ] Is capacity risk guessed instead of marked insufficient when no data was given? (must not guess)
- [ ] Is any destructive action framed as low-risk without a recovery window? (must not)
- [ ] Are cost facts traceable to the billing export Source ID? (must be)
