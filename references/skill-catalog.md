# Skill Catalog

Index of skills defined in this repo. This repo is the single source of truth — do not fork skill content elsewhere. Shared cross-skill rules live in `_shared/conventions.md`.

Validate structure/safety heuristics with `validate-skills.sh`. Spot-check semantic quality with a review pass against each skill's Anonymized Eval Case and Self-Review Checklist (or your own review agent, if you have one set up).

## A. Delivery & Project Management

| Skill | Path | Use when |
|---|---|---|
| `delivery-health-review` | `delivery-health-review/SKILL.md` | Evaluate a single project or portfolio's delivery health with evidence-backed status, not a vibe check. |
| `project-recovery-plan` | `project-recovery-plan/SKILL.md` | A project is delayed, out of control, scope-drifting, blocked, or has lost stakeholder trust. |
| `capacity-roadmap-scenarios` | `capacity-roadmap-scenarios/SKILL.md` | Quarterly planning, headcount asks, or roadmap conflicts need committed/constrained/accelerated scenarios. |
| `strategy-execution-mbto-check` | `strategy-execution-mbto-check/SKILL.md` | A vague strategy direction needs a Market/Business/Technology/Organization landing-risk check, especially the often-ignored org/KPI/incentive angle. |
| `strategy-execution-review` | `strategy-execution-review/SKILL.md` | Weekly review of a strategy/pilot's original assumptions against new evidence, distinguishing emotional/interest-based/factual pushback, producing a keep/adjust/stop recommendation. |

## B. Incident, Reliability & Cloud Operations

| Skill | Path | Use when |
|---|---|---|
| `incident-executive-update` | `incident-executive-update/SKILL.md` | An incident is active and a stakeholder-facing status update is needed. |
| `postmortem-facilitator` | `postmortem-facilitator/SKILL.md` | Blameless postmortem after an incident, failed release, or security near-miss. |
| `cloud-cost-reliability-review` | `cloud-cost-reliability-review/SKILL.md` | Combined AWS/GCP cost, SLO, capacity, and observability review. |
| `architecture-decision-record` | `architecture-decision-record/SKILL.md` | A significant platform/cloud/API/data/security/integration decision needs recording. |

## C. Customer, Pre-Sales & Cross-Org Delivery

| Skill | Path | Use when |
|---|---|---|
| `customer-escalation-management` | `customer-escalation-management/SKILL.md` | Customer dissatisfaction, SLA risk, major delivery failure, renewal risk, or customer-facing incident escalation. |
| `commitment-risk-review` | `commitment-risk-review/SKILL.md` | Before Sales/PM/customer commitments (SOW, dates, custom features) are finalized — prevents EM being handed a fait accompli. |
| `managed-service-operations-review` | `managed-service-operations-review/SKILL.md` | Periodic review of multi-customer managed service/platform/MSP operations. |

## D. People & Organizational Capability

| Skill | Path | Use when |
|---|---|---|
| `feedback-growth-plan` | `feedback-growth-plan/SKILL.md` | Regular feedback, growth conversations, expectation-setting, coaching. |
| `hiring-interview-calibration` | `hiring-interview-calibration/SKILL.md` | Designing/calibrating an engineering interview loop, scorecards, debriefs. |
| `role-clarity-decision-rights` | `role-clarity-decision-rights/SKILL.md` | Role/responsibility overlap or unclear decision authority across Tech Lead/EM/PM/SRE/Sales. |

## E. Personal Productivity & Workflow Automation

| Skill | Path | Use when |
|---|---|---|
| `daily-priority-briefing` | `daily-priority-briefing/SKILL.md` | Start of the workday — turn calendar + open emails/tickets + carryover into one ranked task list with conflict flags. |
| `weekly-wrapup-focus` | `weekly-wrapup-focus/SKILL.md` | Friday morning — summarize what got done this week and propose a ranked next-week focus list. |
| `notes-to-action-digest` | `notes-to-action-digest/SKILL.md` | Turn a raw email thread, meeting transcript, or chat history into decisions / action items / open questions / FYI. |
| `one-on-one-prep-briefing` | `one-on-one-prep-briefing/SKILL.md` | Shortly before a scheduled 1-1 — recap last meeting's commitments and suggest talking points. |
| `team-standup-digest` | `team-standup-digest/SKILL.md` | Digest team members' async standup updates into blockers, highlights, and items needing EM intervention. |
| `retro-synthesis` | `retro-synthesis/SKILL.md` | Turn raw retro board sticky notes into grouped themes and a ranked action-item draft. |
| `cross-team-dependency-log` | `cross-team-dependency-log/SKILL.md` | Consolidate multiple teams' status updates into a who's-waiting-on-whom dependency/RAID log. |
| `problem-statement-framing` | `problem-statement-framing/SKILL.md` | A vague task/problem just landed (from a manager, customer, or your own observation) — collapse it into Basic Question / Context / Decision Makers & Stakeholders / Criteria for Success / Solution Scope / Constraints / Key Sources of Insight before analysis starts. |
| `meeting-agenda-draft` | `meeting-agenda-draft/SKILL.md` | Before hosting a meeting — draft a time-boxed agenda with necessity check, meeting-type classification, 48-hour lead-time check, and a Parking Lot section. |
| `meeting-question-decomposer` | `meeting-question-decomposer/SKILL.md` | Break a vague core question into an issue tree of sub-questions (today's discussion / needs prep / parking lot), feeding into `meeting-agenda-draft`. |
| `stakeholder-pre-brief-for-results-meeting` | `stakeholder-pre-brief-for-results-meeting/SKILL.md` | Before a results/review meeting whose conclusions may put someone on the defensive — plan who to brief individually beforehand so no one is blindsided in public. |
| `engineering-metrics-review` | `engineering-metrics-review/SKILL.md` | Turn pasted raw metrics (PR cycle time, deploy frequency, lead time) into a trend/bottleneck analysis without an automated metrics tool. |
| `meeting-notes-to-structured-doc` | `meeting-notes-to-structured-doc/SKILL.md` | Consolidate multiple scattered meeting notes into a structured wiki-ready knowledge doc draft. |
| `hiring-pipeline-status` | `hiring-pipeline-status/SKILL.md` | Turn pasted candidate stage data into a pipeline overview with bottleneck and overdue-followup flags. |
| `meeting-participation-balance-review` | `meeting-participation-balance-review/SKILL.md` | Turn pasted talk-time/participation analytics (e.g. Fireflies Conversation Intelligence) into a self-check on whether you're dominating meetings. |
| `cross-meeting-topic-tracker` | `cross-meeting-topic-tracker/SKILL.md` | Synthesize how a topic evolved across multiple meetings over time (e.g. via Fireflies cross-meeting search) into a timeline, flagging unresolved concerns. |
| `action-register-maintainer` | `action-register-maintainer/SKILL.md` | Read meeting notes plus the current `docs/ar/<file>.md` and propose additions/updates/overdue flags — advisory only, never edits the file itself. |

## Cross-cutting guarantees (see `_shared/conventions.md`)

- Every factual claim carries a Source ID; unsourced claims are never presented as fact.
- Fact / Pattern / Hypothesis are always distinguished.
- No fabricated customer commitments, incident root causes, performance judgments, or cost/schedule figures.
- All external and people-related communications produced are drafts pending human sign-off.
- No skill claims to execute a destructive, cloud, contractual, or liability-admitting action — proposals only.
