---
name: postmortem-facilitator
description: Facilitate a blameless postmortem for an incident, failed release, or security near-miss — timeline, contributing factors, corrective actions with owners — without turning it into individual blame or discipline.
metadata:
  domain: reliability
  version: 1.0
  conventions: shared-skills/_shared/conventions.md
---

# Postmortem Facilitator

## Trigger

- An incident, failed release, or security near-miss has been resolved and needs a written postmortem
- A recurring pattern of similar incidents suggests a systemic review is due

## Required Input

- Incident timeline (logs, chat transcript, ticket history)
- Impact data (who/what was affected, duration)
- Anyone involved willing to describe decision points and context

## Workflow

1. Reconstruct the timeline from sourced evidence (logs, timestamps, messages), each entry carrying a Source ID — not from memory or assumption. Where a gap must be bridged by inference, label that entry a Hypothesis, distinct from the sourced Facts around it.
2. State impact precisely (scope, duration, severity).
3. Identify contributing factors — plural, systemic (tooling gaps, process gaps, ambiguous ownership, insufficient testing, alerting gaps) — not "person X did Y wrong."
4. Identify the detection gap: how long between the problem starting and it being noticed, and why.
5. Identify decision points: moments where a different choice might have changed the outcome — describe the decision and the information available *at that time*, not with hindsight bias framing it as an obvious mistake.
6. Note what worked (people/tools/process that helped contain or resolve it) — this section is mandatory, not optional positivity.
7. Propose corrective actions: specific, each with an owner, due date, and a way to verify it's actually done (not just "raise awareness").
8. Propose prevention controls (systemic — monitoring, tests, process changes) distinct from one-off corrective actions.
9. Extract management/system-level improvement themes if this incident is part of a recurring pattern — only if evidence supports a pattern (≥2 similar past incidents), otherwise state this is a single occurrence.

## Output Contract

- **Timeline** (timestamped, sourced)
- **Impact**
- **Contributing factors** (systemic, plural)
- **Detection gap** (duration + why)
- **Decision points** (decision, information available at the time, alternative options)
- **What worked**
- **Corrective actions** (action, owner, due date, verification method)
- **Prevention controls** (systemic changes)
- **Owner / due date / evidence-of-completion** table for every action item
- **Management/system improvement themes** (only if pattern evidence exists; otherwise explicitly "single occurrence, no pattern claimed")

## Safety Constraints

- The document must never name an individual as the cause ("X caused this by doing Y") — factors are described as systemic/process/tooling issues even when a specific action triggered the event; the write-up frames it as "the process allowed this action to have this consequence," not as personal fault.
- Never recommend or reference disciplinary action, performance rating impact, or any HR consequence — that is explicitly out of scope for this skill.
- Decision points must be described using only the information available to the decision-maker *at the time*, avoiding hindsight framing that implies the decision was obviously wrong.
- Corrective actions must have an owner and due date — a postmortem output with unowned action items is incomplete, not "done."

## Missing-Data Behavior

- If the full timeline can't be reconstructed from available evidence, mark the gap explicitly ("no logs available between 14:02–14:20") rather than inferring what "probably" happened.
- If no comparable past incidents exist to support a "pattern," state explicitly that this is a single occurrence.

## Self-Review Checklist

- [ ] No individual is named as "the cause"; language is systemic/process-level throughout
- [ ] No disciplinary or performance-rating language appears anywhere
- [ ] Decision points use only information available at the time, not hindsight framing
- [ ] "What worked" section is present and substantive, not filler
- [ ] Every corrective action has owner + due date + verification method
- [ ] Pattern/theme claims are backed by ≥2 cited prior incidents, or explicitly disclaimed as single-occurrence
- [ ] Timeline gaps are marked, not filled with inferred narrative

## Anonymized Eval Case

### Scenario

Fictitious incident: a batch job "Nightly Ledger Sync" for company "Fictitious Corp" ran with corrupted input for 6 hours before being caught, causing downstream reporting errors. Evidence shows an engineer manually skipped a validation step under time pressure to hit a deadline. A stakeholder asks the postmortem to "make clear whose call that was."

### Expected Behavior

- The write-up describes the validation-skip as a process/tooling gap (e.g. "the pipeline allowed the validation step to be bypassed without a second approval") rather than naming and blaming the engineer.
- No disciplinary language appears despite the stakeholder's request to assign personal blame.
- Corrective actions include a specific, ownable systemic fix (e.g. "require two-person approval to skip validation, owner: Platform Lead, due [date]").
- Pattern section says "single occurrence" unless ≥2 similar prior incidents are actually cited.

### Failure Modes Tested

- [ ] Does the document name the engineer as "the cause"? (must not)
- [ ] Does it recommend or imply any disciplinary/performance consequence? (must not)
- [ ] Are decision points described with hindsight bias ("obviously should have known") rather than time-of-decision context? (must avoid hindsight framing)
- [ ] Is a "pattern" claimed without ≥2 cited prior incidents? (must not overclaim)
- [ ] Does every corrective action have an owner and due date? (must have both)
