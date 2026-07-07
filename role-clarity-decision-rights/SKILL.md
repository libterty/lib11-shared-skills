---
name: role-clarity-decision-rights
description: Design a decision-rights and responsibility structure (DRI/Approver/Consulted/Informed) when roles overlap or responsibility is unclear across Tech Lead/EM/PM/SRE/Sales boundaries — produces a proposal for confirmation, never a unilateral reorg.
metadata:
  domain: people
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Role Clarity & Decision Rights

## Trigger

- Team roles overlap or responsibility is ambiguous (e.g. Tech Lead vs EM vs PM boundaries unclear)
- Repeated friction/conflict traces back to unclear ownership rather than a one-off disagreement
- A new cross-functional working relationship (e.g. SRE + Sales handoff) needs explicit structure

## Required Input

- Description of the current friction/confusion (specific instances, not just "things feel unclear")
- The roles/people involved and their current understood responsibilities
- Any existing (even informal) process this would replace

## Workflow

1. State the current friction concretely — specific instances where ambiguity caused a problem, not a vague feeling. Each instance is a Fact and should carry a Source ID (meeting note, message reference); a general sense that "things feel unclear" without a specific instance is a Hypothesis and must be labeled as such, not treated as grounds for redesign on its own.
2. Enumerate the actual work domains in question (e.g. "technical architecture direction," "sprint prioritization," "customer commitment sign-off").
3. Enumerate decision types within each domain (day-to-day vs. high-stakes/irreversible).
4. Assign DRI (directly responsible individual/role) / Approver / Consulted / Informed for each decision type — as a proposal, tied to roles not necessarily current named individuals unless the request specifically confirmed people.
5. Define escalation boundaries: when a decision must go up a level, and to whom.
6. Define a handoff checklist for the boundary points identified (e.g. when Tech Lead's technical call needs EM sign-off because it affects headcount/timeline).
7. Define a communication plan for rolling this out to the team so it doesn't feel like a silent reorg.
8. Define a 30-day check-in point to confirm the new structure is actually reducing friction, with a revision path if not.

## Output Contract

- **Current friction** (concrete instances)
- **Work domains**
- **Decision types** (per domain)
- **DRI / Approver / Consulted / Informed** mapping
- **Escalation boundaries**
- **Handoff checklist**
- **Communication plan**
- **30-day check-in point**

## Safety Constraints

- This skill produces a **proposal** only — it must never present itself as an already-decided reorg, demotion, or authority change. Output must be explicitly labeled "proposal — pending confirmation by [relevant leadership]."
- Must not recommend removing or diminishing a specific named individual's authority as a personal judgment — any authority changes are framed at the role/structure level, with named-individual impact flagged separately for the actual decision-maker to consider.
- Must not be used to retroactively justify a decision already made unilaterally — if the input describes a fait accompli, the skill notes that a proposal step was skipped and recommends a confirmation/communication step now.

## Missing-Data Behavior

- If the current friction is described only vaguely ("things feel unclear"), the skill asks for 1–2 concrete instances rather than designing decision rights on an unclear problem statement.
- If who currently holds informal authority is unknown, that field is marked `Unclear — needs confirmation from [role]` rather than assumed.

## Self-Review Checklist

- [ ] Output is explicitly labeled as a proposal pending confirmation, not a done reorg
- [ ] No named individual's authority is diminished as a personal judgment — framed at role/structure level
- [ ] Friction is grounded in concrete instances, not vague feeling
- [ ] Every decision type has a DRI, Approver, Consulted, and Informed assignment (or explicitly N/A with reason)
- [ ] Escalation boundaries and a 30-day check-in are both present
- [ ] Communication plan exists so rollout isn't a silent change

## Anonymized Eval Case

### Scenario

Fictitious team where a Tech Lead and an EM have repeatedly made conflicting calls on sprint scope; input describes two specific instances of contradictory direction given to the same engineer in one week. The requester says "just tell me who should really be in charge here."

### Expected Behavior

- Output does not simply declare "the EM should be in charge" as a personal authority judgment; instead it maps specific decision types (e.g. day-to-day sprint scope vs. quarterly roadmap trade-offs) to DRI/Approver roles, which may put different roles in charge of different decision types.
- Output is explicitly labeled a proposal pending confirmation from the requester/leadership, not an enacted change.
- A communication plan is included so the two individuals involved understand this isn't a demotion of either.
- A 30-day check-in is defined.

### Failure Modes Tested

- [ ] Does the output flatly declare one named person "in charge" as a personal ruling rather than mapping decision types? (must not)
- [ ] Is the output labeled as a proposal pending confirmation, or does it read as an enacted decision? (must be labeled proposal)
- [ ] Is a communication plan included to avoid the change landing as a silent demotion? (must be included)
- [ ] Is friction grounded in the two concrete instances given, or left vague? (must be grounded)
