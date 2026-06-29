# Main Thread Dispatch Task

- Dispatching thread:
  - Main Thread

- Target thread / module:
  - `<module>`

- Task type:
  - implement | investigate | verify | review | unblock | document | decide

- Priority:
  - P0 | P1 | P2 | P3


## Model Routing

- Model tier:
  - fast | standard | high-reasoning | specialized
- Model version policy:
  - latest-available | pinned | quota-optimized | fallback
- Requested model / mode:
  - <project-configured model id or native UI selection>
- Requested model version:
  - <latest available by default, or explicit version>
- Preferred quota pool:
  - gpt-5.5 | gpt-5.3-codex-spark | shared | unknown | <project-defined>
- Spark preference:
  - use `gpt-5.3-codex-spark` when suitable for fast/low-risk work and independent quota helps; otherwise not applicable
- Fallback model / mode:
  - <fallback if requested model is unavailable>
- Model selection reason:
  - <why this tier/version/quota pool is appropriate>
- Escalation trigger:
  - <when to switch to a stronger model or newer version>

## Background

- Why this task exists.
- What triggered it.

## Ownership Reason

- Why this belongs to the target module.

## Desired Outcome

- What should be true when this task is done.

## Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Relevant Files / Docs

- `docs/roadmap.md`
- `docs/thread-registry.md`
- `docs/thread-runs/<task-id>.md`
- `docs/modules/<module>/status.md`
- `docs/modules/<module>/handoff.md`
- `path/to/file`

## Dependencies

- Depends on:
- Blocks:

## Constraints

- Do not change:
- Must preserve:
- Security / privacy constraints:

## Expected Verification

- Command/check:
- Manual check:
- Not required because:

## Checkpoint / Recovery

- Create or update `docs/thread-runs/<task-id>.md`.
- Checkpoint before risky or long steps.
- Include resume notes.

## Return Packet

When completed, blocked, failed, or needing a decision, write:

- `docs/thread-runs/inbox/main/RET-<task-id>-<module>-YYYYMMDD-HHMM.md`

## Sync Back

- Update `docs/modules/<module>/status.md`
- Update `docs/modules/<module>/handoff.md`
- Update `docs/modules/<module>/runbook.md` if meaningful local context was created
- Notify main thread with decision-level summary

## Escalation Trigger

Create or request ADR if this changes architecture, shared contracts, deployment, security, cost, or product scope.
