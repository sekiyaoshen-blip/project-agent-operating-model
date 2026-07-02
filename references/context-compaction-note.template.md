# Context Compaction: YYYY-MM-DD

## Scope

- Project / module:
- Compaction mode:
  - LV2 controlled autonomous docs-only | request-only | human/main-thread approved
- Trigger:
  - doc-budget-exceeded | stale-contradiction | replacement-thread-startup | processed-return-inbox | closed-dispatch-tasks | roadmap-phase-completed | scheduled-maintenance | user-reported-confusion
- Check outcome:
  - no-compaction-needed | compaction-request-created | lv2-compaction-ready | lv2-compaction-executed
- Compaction owner:

## Lock

- Lock file:
  - `docs/.locks/context-compaction.lock`
- Lock ID:
- Owner tool:
  - codex | claude-code | other-agent | automation | human
- Owner thread / session / conversation ID:
- Owner task / run ID:
- Started:
- Released:
- Stale-after:

## LV2 Safety Preconditions

- [ ] Cleanup was docs-only
- [ ] Concrete compaction trigger was found
- [ ] Active compaction lock was acquired or already owned
- [ ] Affected docs were not owned by another active task or lock
- [ ] No `running` or `in-review` task owned the same docs
- [ ] Processed Return Packets were clearly processed, or unprocessed packets were left untouched
- [ ] Historical material was archived or summarized before shortening active docs
- [ ] Final diff was reviewable and limited to project-state docs

## Active Docs Reviewed

- `AGENTS.md`
- `CLAUDE.md`, if present
- `docs/thread-operating-model.md`
- `docs/thread-registry.md`
- `docs/roadmap.md`
- `docs/status.md`
- `docs/modules/<module>/status.md`
- `docs/modules/<module>/handoff.md`
- `docs/modules/<module>/runbook.md`
- Relevant ADRs:
- Relevant active thread-runs:
- Relevant locks:

## Source-Of-Truth Check

Highest-priority sources used:

1. Current code/tests:
2. Build/CI/runtime behavior:
3. Accepted ADRs:
4. Roadmap/thread-registry:
5. Module status/handoff/runbook:

## Changes Made

- Rewrote active docs as current snapshots:
- Archived stale or historical material:
- Closed/superseded task rows:
- Processed Return Packets:
- Removed duplicated facts:
- Updated lock index / released lock:

## Archive Destinations

- `docs/archive/roadmap/...`
- `docs/archive/modules/<module>/...`
- `docs/archive/thread-runs/...`
- `docs/thread-runs/archive/...`

## Current Active Context After Compaction

- Current project state:
- Current module state:
- Active risks:
- Active tasks:
- Next sync trigger:

## Follow-Up

- [ ] Follow-up task
- [ ] ADR needed
- [ ] Roadmap update needed
- [ ] Lock cleanup needed
