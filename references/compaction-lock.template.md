# Compaction Lock

- Lock ID: LOCK-YYYYMMDD-HHMM-<short-id>
- Lock type: context-compaction
- Safety mode: LV2-docs-only
- Status: active | stale | released

## Owner

- Owner tool: codex | claude-code | other-agent | automation | human
- Owner thread / session / conversation ID:
- Owner task / run ID:
- Owner display name, if useful:

## Scope

- Project / module:
- Files locked:
  - `docs/thread-registry.md`
  - `docs/roadmap.md`
  - `docs/status.md`
  - `docs/modules/<module>/status.md`
  - `docs/modules/<module>/handoff.md`
  - `docs/modules/<module>/runbook.md`
  - `docs/thread-runs/...`
- Out of scope:
  - source code
  - tests
  - production config
  - schemas / migrations
  - ADR decision changes

## Timing

- Started at: YYYY-MM-DD HH:MM
- Last heartbeat: YYYY-MM-DD HH:MM
- Expected release: YYYY-MM-DD HH:MM
- Stale after: YYYY-MM-DD HH:MM

## Trigger

- Trigger type:
  - doc-budget-exceeded | stale-contradiction | processed-return-inbox | closed-dispatch-tasks | replacement-thread-startup | roadmap-phase-complete | scheduled-maintenance | user-reported-confusion
- Trigger details:

## Safety Checks

- [ ] Workspace status checked
- [ ] No active conflicting lock found
- [ ] Affected docs are not owned by another running task
- [ ] Cleanup is docs-only
- [ ] Historical material will be archived before shortening active docs
- [ ] Final diff will be reviewable

## Handoff / Notes

- Current phase:
- Files already archived:
- Files already rewritten:
- Remaining work:
- Release notes:
