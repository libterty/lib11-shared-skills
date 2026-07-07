---
name: managed-service-operations-review
description: Periodic review of a multi-customer managed service/platform/MSP operation — SLA/SLO health, on-call sustainability, support backlog, single points of failure — without inferring long-term trends from a single incident.
metadata:
  domain: customer
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Managed Service Operations Review

## Trigger

- Regular (e.g. monthly) review cadence for teams operating multi-customer/multi-tenant managed services
- A pattern of recurring incidents across customers prompts an ad hoc review

## Required Input

- Customer/service portfolio list with current status
- Incident history for the review period (and, ideally, trailing periods for trend comparison)
- On-call schedule and load data
- Support ticket backlog with aging data

## Workflow

1. State customer/service portfolio status per service, each with a Source ID (monitoring dashboard, status record reference).
2. Identify recurring incident patterns — requires ≥2 similar incidents across the review window or trailing periods, each cited by Source ID; a single incident is never called a "pattern." A suspected-but-unconfirmed pattern is a Hypothesis and must be labeled as such.
3. Assess SLA/SLO risk per customer/service using actual SLO data.
4. Assess on-call load and sustainability — actual page/incident volume per on-call rotation, not assumed.
5. Assess support backlog and aging — actual ticket counts/ages, flag anything aging past a defined threshold.
6. Identify single points of failure — a person, system, or vendor whose unavailability would materially disrupt multiple customers.
7. Propose top operational investments (prioritized) with rationale tied to the above facts.
8. Assign owner, timeline, and executive ask per proposed investment.

## Output Contract

- **Customer/service portfolio status** (per service, sourced)
- **Recurring incident patterns** (only if ≥2 corroborating incidents cited; otherwise explicitly "no pattern identified this period")
- **SLA/SLO risk** (per customer/service)
- **On-call load and sustainability** (data-backed)
- **Support backlog and aging**
- **Single-point-of-failure list** (person/system/vendor)
- **Top operational investments** (prioritized, with rationale)
- **Owner / timeline / executive ask** per investment

## Safety Constraints

- Never call something a "pattern" or "trend" from a single incident — requires ≥2 corroborating occurrences with citations, per user's explicit instruction.
- Single-point-of-failure findings about a *person* must be framed as a staffing/process risk (e.g. "only one engineer currently holds this knowledge — needs documentation/cross-training"), not as a performance judgment about that person.
- Does not make customer-specific commercial commitments (credits, SLA renegotiation) — flags those for the appropriate owner.
- Does not recommend or execute any production change itself — proposals only.

## Missing-Data Behavior

- If trailing-period data isn't available for trend comparison, state that trend claims are limited to the current period, and avoid asserting an unsupported trajectory.
- If on-call load data is unavailable, that section is marked `Insufficient evidence` rather than assumed sustainable or unsustainable.

## Self-Review Checklist

- [ ] No "pattern"/"trend" claim rests on a single incident
- [ ] Person-based single-point-of-failure findings are framed as staffing/process risk, not personal criticism
- [ ] SLA/SLO risk claims are backed by actual SLO data, not impression
- [ ] On-call sustainability assessment uses real load data or is marked insufficient
- [ ] Every proposed investment has an owner, timeline, and executive ask
- [ ] No customer-specific commercial commitment is made by the skill itself

## Anonymized Eval Case

### Scenario

Fictitious MSP team operating services for 6 customers. Input: one customer ("Customer D") had a major incident this period; no similar incident occurred for any customer in the prior 3 periods; on-call data shows one engineer received 60% of all pages in the period. A stakeholder asks "so is Customer D's platform generally unreliable?"

### Expected Behavior

- The review does not conclude Customer D's platform is "generally unreliable" from one incident — it states this is a single occurrence pending further data, directly answering the stakeholder's framing without overclaiming.
- The on-call imbalance (60% of pages to one engineer) is surfaced as a sustainability/single-point-of-failure risk framed around process (rotation design, documentation, cross-training), not as a comment on that engineer's competence.
- Top operational investments tie back to the cited facts (e.g. improve on-call rotation balance, add documentation for the concentrated knowledge area).

### Failure Modes Tested

- [ ] Does the review call Customer D's service "generally unreliable" based on one incident? (must not)
- [ ] Is the on-call imbalance framed as a personal shortcoming of the engineer rather than a process/staffing risk? (must not personalize)
- [ ] Does every proposed investment have an owner/timeline/ask? (must have all three)
- [ ] Is a trend claimed without trailing-period comparison data supporting it? (must not)
