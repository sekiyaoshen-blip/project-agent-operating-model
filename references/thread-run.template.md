# Thread Run: <task-id>

Last updated: YYYY-MM-DD HH:MM

## Routing

- Task ID: <task-id>
- Source thread:
- Target thread / module:
- Native thread link:
- Session ID / Callable Ref:
- State: pending | dispatched | accepted | running | checkpointed | paused-quota | paused-approval | paused-runtime | stalled | returned | in-review | accepted-result | needs-followup | superseded | closed
- Priority: P0 | P1 | P2 | P3
- Model tier: fast | standard | high-reasoning | specialized
- Model version policy: latest-available | pinned | quota-optimized | fallback
- Requested model / mode:
- Requested model version:
- Actual model / mode:
- Actual model version:
- Fallback model / mode:
- Quota pool: gpt-5.5 | gpt-5.3-codex-spark | shared | unknown | <project-defined>
- Spark preference used: yes | no | not-applicable
- Model selection reason:
- Escalation / downgrade notes:
- Lease until: YYYY-MM-DD HH:MM

## Task Brief

- Type: implement | investigate | verify | review | unblock | document | decide
- Background:
- Desired outcome:
- Acceptance criteria:
  - [ ] Criterion 1
  - [ ] Criterion 2
- Relevant files / docs:
  - `docs/thread-registry.md`
  - `docs/modules/<module>/status.md`
  - `docs/modules/<module>/handoff.md`
- Dependencies:
- Constraints:

## Checkpoint

- Last checkpoint:
- Completed work:
- Files changed:
- Commands/checks run:
- Remaining work:
- Blockers:
- Safe to resume: yes / no
- Safe to re-run: yes / no
- Do not repeat:

## Resume Prompt

You are resuming `<task-id>`.

Read first:

- `docs/thread-registry.md`
- `docs/thread-runs/<task-id>.md`
- `docs/modules/<module>/status.md`
- `docs/modules/<module>/handoff.md`
- `docs/modules/<module>/runbook.md`

Current task state:

- State:
- Last checkpoint:
- Last verified result:
- Remaining work:
- Model tier / version policy / actual model:

Continue from the last checkpoint.
Do not repeat completed destructive steps.
Before making changes, check whether the acceptance criteria are already satisfied.

When done, write a return packet to:

- `docs/thread-runs/inbox/main/RET-<task-id>-<module>-YYYYMMDD-HHMM.md`

## Event / Progress Timeline

- YYYY-MM-DD HH:MM — <event>

## Result Summary

Pending.

## Sync Back

- [ ] Updated target module `status.md`
- [ ] Updated target module `handoff.md`
- [ ] Updated target module `runbook.md` if useful local context was created
- [ ] Created Return Packet if completed, blocked, failed, or needs decision

## Closure / Archive Notes

A task is not finished until the main thread reviews its Return Packet and updates the Active Dispatch Queue.

- Final queue state: closed | needs-followup | superseded | failed | TBD
- Return Packet reviewed: yes | no
- Useful outputs promoted to status/handoff/roadmap/ADR: yes | no | not-applicable
- Archived to: `docs/thread-runs/archive/<accepted|needs-followup|failed|superseded>/` or `docs/archive/thread-runs/`
- Stale details removed from active docs: yes | no
