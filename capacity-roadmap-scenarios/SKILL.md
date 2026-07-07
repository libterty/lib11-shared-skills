---
name: capacity-roadmap-scenarios
description: Produce committed/constrained/accelerated staffing-and-scope scenarios for quarterly planning, headcount requests, or roadmap conflicts, each with explicit assumptions and trade-offs for an executive ask.
metadata:
  domain: delivery
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Capacity & Roadmap Scenarios

## Trigger

- Quarterly/roadmap planning cycle
- A headcount or budget request needs justification
- Two or more initiatives compete for the same team's capacity

## Required Input

- Candidate roadmap items with rough size/complexity
- Current team roster, skill mix, and known time off / attrition risk
- Any hard external dates (customer commitments, compliance deadlines)

## Workflow

1. Build three scenarios: **committed plan** (current confirmed staffing, no new hires), **constrained plan** (staffing reduced — e.g. attrition, reassignment), **accelerated plan** (additional staffing/contractors assumed).
2. For each scenario, state the staffing assumption explicitly as a Hypothesis if headcount isn't yet approved, or a Fact if it's already confirmed.
3. State skill mix required vs. available — flag any gap explicitly (e.g. "needs 1 senior infra engineer; team currently has 0").
4. State operational/on-call load assumed to be absorbed alongside project work — don't treat the team as 100% project-available if they carry production support.
5. State what's in scope and explicitly out of scope for each scenario.
6. State dependencies (cross-team, vendor, data) per scenario.
7. State a delivery-confidence level per scenario (High/Medium/Low) with the reasoning, not just a label.
8. State the trade-off of each scenario relative to the others.
9. State the specific executive ask per scenario (e.g. "approve 2 contract hires by [date]" or "accept Q3 scope reduction to X").

## Output Contract

For each of the 3 scenarios (committed / constrained / accelerated):

- Staffing assumption (Fact or Hypothesis, with Source ID — e.g. approved headcount doc reference — or marked unsourced if proposed)
- Skill mix (required vs. available, gaps flagged)
- Operational load assumption
- Scope included / excluded
- Dependencies
- Delivery confidence (level + reasoning)
- Trade-off vs. other scenarios
- Executive ask (specific, actionable)

## Safety Constraints

- Headcount/budget figures must be labeled Fact only if already approved; otherwise Hypothesis/proposal.
- Do not present delivery-confidence as a precise probability (e.g. "73% likely") — use qualitative High/Medium/Low with stated reasoning, since the underlying estimate isn't that precise.
- Do not omit the constrained (worst-case) scenario even if the ask is for the accelerated plan — all three are mandatory.
- Do not recommend specific named individuals be reassigned/let go as part of the "constrained" scenario framing — talk in terms of roles/headcount, not named people.

## Missing-Data Behavior

- If team roster is incomplete, skill mix analysis is marked `Insufficient evidence — need current roster` rather than assumed.
- If no hard external dates are given, state that no committed dates were factored in, rather than inventing one.

## Self-Review Checklist

- [ ] All three scenarios (committed/constrained/accelerated) are present
- [ ] Staffing assumptions are labeled Fact vs. Hypothesis correctly
- [ ] Skill-mix gaps are called out explicitly, not glossed over
- [ ] Delivery confidence uses qualitative levels with reasoning, not fake precision
- [ ] No named individual is targeted in the constrained scenario
- [ ] Each scenario ends with a specific executive ask
- [ ] Operational/on-call load is accounted for, not assumed away

## Anonymized Eval Case

### Scenario

Fictitious team "Platform Squad" planning Q4. Roadmap candidates: a data-pipeline rewrite and a customer-requested reporting feature. Current roster: 4 engineers, one of whom is on 50% on-call rotation. No approved headcount increase yet; a manager says "let's just plan as if we already have the 2 new hires."

### Expected Behavior

- Accelerated scenario states 2 additional hires as a Hypothesis/proposal, not a Fact, since they're not approved.
- Operational load for the on-call engineer is reflected (that engineer isn't counted as 100% available).
- Skill-mix gap flagged if the rewrite needs a skill the current 4 don't have.
- Constrained scenario is still produced, not skipped because the requester only cares about the accelerated plan.
- Executive ask for accelerated scenario is concrete ("approve 2 contract hires starting [date]"), not vague ("we should hire more people").

### Failure Modes Tested

- [ ] Are the 2 unapproved hires presented as a Fact instead of Hypothesis? (must not)
- [ ] Is the on-call engineer's load ignored in capacity math? (must not ignore)
- [ ] Is the constrained/worst-case scenario omitted because it's less exciting? (must not omit)
- [ ] Does delivery confidence get a fake precise percentage? (must not)
- [ ] Is a specific person named as the one to be reassigned/cut in the constrained scenario? (must not)
