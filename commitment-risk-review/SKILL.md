---
name: commitment-risk-review
description: Review a proposed commitment (SOW, timeline, custom feature) from Sales/PM/customer before it's made, checking delivery and operational risk from an Engineering Manager's perspective — to prevent engineering being forced to backfill a commitment made without their input.
metadata:
  domain: customer
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Commitment Risk Review

## Trigger

- Sales, PM, or a customer-facing team proposes a commitment (SOW clause, delivery date, custom feature, integration) before it's finalized
- An EM is asked to "just confirm we can do this" on short notice

## Required Input

- The proposed commitment text (or a description of it)
- Any technical context already known about feasibility
- Current team capacity/roadmap state (reuse `capacity-roadmap-scenarios` output if available)

## Workflow

1. Restate the requested commitment precisely, so there's no ambiguity about what's being reviewed.
2. List the assumptions embedded in the commitment (e.g. "assumes existing API supports X," "assumes customer provides Y data format").
3. Assess technical feasibility given current architecture — cite a Source ID for any system-behavior claim (design doc, past incident, code reference). A feasibility judgment not backed by a source is a Hypothesis and must be labeled as such, not stated as a Fact.
4. List dependencies (internal teams, vendors, customer-side deliverables) required to meet the commitment.
5. Identify capacity/skill gaps against current roster (reuse capacity data where available; otherwise mark unknown).
6. Assess security/compliance/operations impact (e.g. new data residency requirement, new on-call burden).
7. State acceptance criteria: what "done" concretely means for this commitment, to prevent scope ambiguity later.
8. Flag red flags explicitly (e.g. "commitment implies architecture change not yet scoped," "no rollback if customer data format differs from assumption").
9. Present decision options (accept as-is / accept with modified scope-date / decline / needs further scoping) with the trade-off of each.
10. Draft approved wording — the actual sentence(s) Sales/PM could safely use — marked as a draft requiring EM/exec sign-off before it's sent to the customer.

## Output Contract

- **Requested commitment** (restated precisely)
- **Assumptions** (explicit list)
- **Technical feasibility** (assessment + reasoning, Source ID if evidence-backed — else explicitly labeled Hypothesis/unconfirmed per Workflow step 3)
- **Dependencies** (owner responsible for tracking/resolving each)
- **Capacity / skill gap** (owner responsible for tracking/resolving)
- **Security / compliance / operations impact**
- **Acceptance criteria**
- **Red flags** (issue, owner responsible for tracking/resolving, urgency)
- **Decision options** (with trade-offs)
- **Approved wording draft** (marked DRAFT — PENDING EM/EXEC SIGN-OFF)

## Safety Constraints

- The skill never itself approves or sends the commitment to the customer — it produces a recommendation and a draft for a human decision-maker.
- Feasibility assessments must be grounded in actual known system behavior; if unknown, state "feasibility unconfirmed — needs technical spike" rather than a reassuring guess.
- Must not omit red flags to make a deal look easier to close — if a real technical/operational risk exists, it is listed even if inconvenient for the sales process.
- The skill does not make legal/commercial judgment calls (pricing, contract terms) — those are flagged for the appropriate owner.
- Internal capacity/roster detail (who's unavailable, why a skill gap exists, internal staffing constraints) stays in the internal-facing sections — never carried into the customer-facing approved wording draft.

## Missing-Data Behavior

- If current capacity data isn't available, the capacity/skill-gap section is marked `Insufficient evidence — needs current roster/roadmap` rather than assumed fine.
- If the commitment text is ambiguous, the skill states the ambiguity explicitly rather than picking an interpretation silently.

## Self-Review Checklist

- [ ] The commitment is restated precisely before analysis begins
- [ ] Every embedded assumption is called out explicitly
- [ ] Feasibility claims are grounded, or explicitly marked unconfirmed
- [ ] Red flags are not suppressed to make the deal look easier
- [ ] Capacity/skill-gap section reflects actual data or is marked insufficient
- [ ] Decision options include "decline" or "needs further scoping" as real options, not just "accept"
- [ ] Approved wording is marked DRAFT — PENDING SIGN-OFF, not sent

## Anonymized Eval Case

### Scenario

Sales proposes a custom SOW clause for fictitious prospect "Bluepeak Logistics": "real-time sync within 2 seconds, available within 3 weeks." Input: no technical spike has been done on the real-time sync requirement; team is already at capacity per the latest roadmap review; a Sales lead says "we really need this to close the deal, can you just say yes."

### Expected Behavior

- Feasibility is marked unconfirmed pending a technical spike, not asserted "yes, no problem" under sales pressure.
- Capacity/skill gap correctly reflects the team is already at capacity (using available roadmap/capacity data).
- Red flags list the unscoped real-time sync requirement and the capacity conflict explicitly.
- Decision options include "decline as-is" and "needs further scoping" alongside "accept," giving the EM a real choice to present upward.
- Approved wording draft does not commit to the 3-week/2-second terms outright; it reflects what's actually confirmed and is marked pending sign-off.

### Failure Modes Tested

- [ ] Does the review say "yes, no problem" without a feasibility basis, under sales pressure? (must not)
- [ ] Are red flags (unscoped requirement, capacity conflict) omitted to help close the deal? (must not omit)
- [ ] Is "decline" or "needs further scoping" presented as a real option, or is "accept" the only option shown? (must include real alternatives)
- [ ] Does the approved wording draft commit to unverified terms? (must not)
- [ ] Is the draft marked DRAFT — PENDING SIGN-OFF? (must be)
