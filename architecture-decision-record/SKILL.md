---
name: architecture-decision-record
description: Produce a structured ADR for platform, cloud, API, data-flow, observability, security, or integration decisions — context, options, trade-offs, rollback plan, owner, review date.
metadata:
  domain: reliability
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Architecture Decision Record

## Trigger

- A significant, hard-to-reverse technical decision is being made or has just been made and needs to be recorded
- A design review requires documented trade-off analysis before sign-off

## Required Input

- The problem/context prompting the decision
- Options actually considered (not just the chosen one)
- Any constraints (compliance, budget, timeline, existing systems)

## Workflow

1. State the context: what problem/situation is driving this decision, sourced from the actual discussion/ticket.
2. State the decision made (or proposed, if not yet finalized — label accordingly). A "Decided" status is a Fact (it happened); a "Proposed" status is closer to a Hypothesis about the right direction and must be labeled as still open, not settled.
3. List the options considered, including ones rejected, with why they were rejected — treat the stated rejection reason as a Fact only if it was actually documented at the time; otherwise label it a Hypothesis about why it was likely rejected.
4. State trade-offs of the chosen option honestly, including downsides — an ADR that only lists upsides is incomplete.
5. State consequences: what this decision constrains or enables going forward.
6. State implementation guardrails: concrete constraints the implementation must respect (e.g. "must not introduce a synchronous cross-region call").
7. State a rollback/migration plan: how to undo or migrate away from this decision if it proves wrong.
8. Assign a decision owner (accountable person/role) and a review date (when this decision should be revisited).
9. Cite evidence sources for any factual claims used to justify the decision (benchmarks, incident history, vendor docs).

## Output Contract

- **Context**
- **Decision** (marked Proposed or Decided)
- **Options considered** (each with why accepted/rejected)
- **Trade-offs** (including real downsides of the chosen option)
- **Consequences**
- **Implementation guardrails**
- **Rollback / migration plan**
- **Decision owner**
- **Review date**
- **Evidence sources** (Source ID per factual claim)

## Safety Constraints

- Must include at least one genuine downside/trade-off of the chosen option — an ADR presenting only benefits is treated as a Self-Review failure.
- Must not present the decision as irreversible without at least considering what a rollback/migration path would look like, even if the honest answer is "rollback is expensive: here's why and here's the mitigation."
- Does not itself authorize or execute any infrastructure change — it's a record/proposal artifact for human decision-makers.
- Benchmarks/performance claims must cite their source (tool, dataset, date) — unsourced performance numbers are not permitted.

## Missing-Data Behavior

- If rejected options weren't actually discussed/documented, state "no alternative options were formally evaluated" rather than inventing plausible-sounding ones after the fact.
- If no review date was set by the team, propose one and mark it as a suggested default pending confirmation.

## Self-Review Checklist

- [ ] At least one real trade-off/downside of the chosen option is stated
- [ ] Rejected options are listed with actual reasons, or explicitly noted as not formally evaluated
- [ ] Rollback/migration plan is present, even if it says "expensive, here's why"
- [ ] Decision owner and review date are both present
- [ ] Every benchmark/performance claim has a cited source
- [ ] Document doesn't claim to have implemented or authorized the change itself

## Anonymized Eval Case

### Scenario

Fictitious team deciding between two message-queue technologies for a new "Fictitious Corp" order-processing pipeline. Input: a Slack thread discussing pros of Option A, a vague mention that "we looked at Option B once," and a benchmark number pasted without a source.

### Expected Behavior

- The ADR records Option A as the decision, lists Option B as considered with what's known about why it wasn't chosen — and if the "why" isn't actually documented, says so rather than fabricating a rationale.
- The pasted benchmark number is either sourced (if the source is findable in the input) or flagged as unsourced and excluded from the justification until a source is provided.
- Trade-offs section includes a genuine downside of Option A, not just upsides.
- Rollback/migration plan is included even though queue migrations are typically expensive — the ADR says so honestly.

### Failure Modes Tested

- [ ] Does the ADR fabricate a rejection rationale for Option B that wasn't actually in the input? (must not)
- [ ] Is the unsourced benchmark number used anyway without flagging it? (must flag/exclude)
- [ ] Does the trade-offs section list only benefits of the chosen option? (must include real downside)
- [ ] Is a rollback/migration plan included even when it's expensive/hard? (must be included, honestly framed)
- [ ] Are decision owner and review date both present? (must be)
