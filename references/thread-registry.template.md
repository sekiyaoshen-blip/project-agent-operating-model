# Thread Registry

Last updated: YYYY-MM-DD

This document is the durable thread index, active dispatch queue, and return-inbox index for future Codex sessions. This document should contain active threads and active tasks only; closed, superseded, or accepted historical detail belongs in archives.

Start a new thread by reading the relevant thread brief and status docs.

## Source Of Truth

Current global architecture baseline:

`docs/<global-architecture-doc>.md`

Current operating model:

`docs/thread-operating-model.md`

Current roadmap:

`docs/roadmap.md`

Current global status:

`docs/status.md`

Sensitive access details, passwords, private keys, runtime env files, and operator-only commands remain in local private docs and must not be committed.

## Current State

Briefly describe the current product/system state:

- Live public surfaces:
  - Admin:
  - User portal:
  - Main user-facing endpoint:
- Current implementation:
  - Main entrypoint:
  - Runtime services:
  - Important shared modules:
- Current caveats:
  - Caveat 1
  - Caveat 2

## Thread Map

| Thread / Module | Role | Scope | Native Thread Link | Session ID / Callable Ref | Status Doc | Handoff / Runbook | Current State | Started | Last Sync | Last Run | Next Sync Trigger | Replaces |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Main Thread | main | Product roadmap, architecture, module boundaries, dispatch, return review | <Codex Desktop link> | <fallback ref> | `docs/status.md` | `docs/thread-registry.md` | active | YYYY-MM-DD | YYYY-MM-DD | TBD | Any cross-module change or return packet | none |
| <Module A> | module | <Owned scope> | <Codex Desktop link> | <fallback ref> | `docs/modules/<module>/status.md` | `docs/modules/<module>/handoff.md`; `docs/modules/<module>/runbook.md` | active / paused / blocked | YYYY-MM-DD | YYYY-MM-DD | TBD | <trigger> | none |
| <Support Thread> | support | <Owned workflow> | <Codex Desktop link> | <fallback ref> | `docs/modules/<module>/status.md` | `docs/modules/<module>/handoff.md`; `docs/modules/<module>/runbook.md` | active / paused / blocked | YYYY-MM-DD | YYYY-MM-DD | TBD | <trigger> | none |

## Model Selection Policy

For cross-thread dispatch, the main thread first chooses Model Tier based on task difficulty, risk, context size, and purpose, then chooses Model Version.

Default version policy: `latest-available`. That means using the latest available, non-deprecated model version in the selected tier that is compatible with the current Codex Desktop / CLI / IDE / API entrypoint.

Use an older or pinned version only when:

- Reproducing historical behavior.
- Project configuration, team convention, or explicit user request requires it.
- The current entrypoint temporarily cannot see the latest model.
- The latest model has a known regression on this task.
- Quota optimization or fallback is needed.

In the current user/project environment, `GPT-5.3-SPARK` / `gpt-5.3-codex-spark` may be treated as a quota pool independent from `GPT-5.5`. For `fast` and some low/medium-risk `standard` tasks, prefer Spark to preserve `GPT-5.5` quota for high-risk, high-reasoning, long-context, and cross-module decision tasks.

| Model Tier | Default Version Policy | Preferred Model / Version | Prefer Spark When | Escalate When | Avoid / Downgrade When |
|---|---|---|---|---|---|
| `fast` | latest available or quota-optimized | `gpt-5.3-codex-spark` when available; otherwise latest fast/mini model | Fast iteration, docs/status, simple search, lint/test small fixes, low-risk verification | Contracts, permissions, billing, security, data migration, or cross-module impact appears | Task remains local, low-risk, and simple to verify |
| `standard` | latest available by default; Spark allowed when risk is low/medium | latest standard model; Spark for bounded low-risk implementation | Clear single-module tasks, small bugs, low-risk UI/adapter/glue, quick verification | Repeated failure, cross-module work, long context, or durable decision | Task has become simple docs/status/formatting work |
| `high-reasoning` | latest available | latest strongest available model, normally `gpt-5.5` or successor | Usually do not prefer Spark unless the user explicitly asks and risk is downgraded | Already highest general tier; request human decision or specialized model if needed | Risk is resolved and remaining work is local implementation |
| `specialized` | latest available within configured specialty | project-configured specialized model/mode | Only when Spark is configured as a specialized fast-iteration model and the task matches | Specialized model cannot handle broad reasoning or cross-module decisions | Return to `standard` or `high-reasoning` after the specialized phase |

## Active Dispatch Queue

| Task ID | Source Thread | Target Thread / Module | Type | Priority | Model Tier | Version Policy | Requested Model | Actual Model | Quota Pool | State | Lease Until | Last Checkpoint | Last Run | Return Packet | Next Action |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| TASK-0001 | Main Thread | `<module>` | implement | P1 | standard | latest-available | latest standard model | TBD | shared / unknown | pending | YYYY-MM-DD HH:MM | `docs/thread-runs/TASK-0001.md#checkpoint` | `docs/thread-runs/TASK-0001.md` | TBD | Dispatch using native visible thread tool |
| TASK-0002 | Main Thread | `<module>` | verify | P2 | fast | quota-optimized | `gpt-5.3-codex-spark` if available | TBD | gpt-5.3-codex-spark | paused-quota | YYYY-MM-DD HH:MM | `docs/thread-runs/TASK-0002.md#checkpoint` | `docs/thread-runs/TASK-0002.md` | TBD | Resume after quota/reset or switch fallback |

States:

- `pending`: identified but not yet dispatched.
- `dispatched`: sent to the target thread.
- `accepted`: target thread acknowledged the task.
- `running`: target thread is working.
- `checkpointed`: meaningful progress exists and the task is resumable.
- `paused-quota`: paused by quota/usage limit or suspected quota stop.
- `paused-approval`: waiting for user approval or external confirmation.
- `paused-runtime`: runtime/tool/app/environment issue.
- `stalled`: no heartbeat/progress past lease.
- `returned`: target thread submitted a Return Packet.
- `in-review`: main thread is reviewing the Return Packet.
- `accepted-result`: main thread accepted the result.
- `needs-followup`: follow-up task or clarification is needed.
- `superseded`: replaced by another task.
- `closed`: complete and archived.

## Registry And Queue Lifecycle

Keep `docs/thread-registry.md` as an active index, not a full task history.

- Keep active, paused, blocked, returned, and needs-followup tasks in the Active Dispatch Queue.
- Move `closed`, `accepted-result`, `superseded`, and failed historical detail to archives after main-thread review.
- Keep processed Return Packets out of `docs/thread-runs/inbox/main/`.
- Keep only current thread refs in Thread Map; mark replaced threads in `Replaces` and archive stale details.
- Link to archives when useful, but do not require future threads to read archives by default.

## Return Inbox

Return packets awaiting main-thread review:

| Return Packet | Task ID | Source Module | Result State | Received | Review State | Next Action |
|---|---|---|---|---|---|---|
| `docs/thread-runs/inbox/main/RET-TASK-0001-module-YYYYMMDD-HHMM.md` | TASK-0001 | `<module>` | completed / blocked / failed / needs-decision | YYYY-MM-DD HH:MM | pending | Main thread review |

Archive processed packets under:

- `docs/thread-runs/archive/accepted/`
- `docs/thread-runs/archive/needs-followup/`
- `docs/thread-runs/archive/failed/`
- `docs/thread-runs/archive/superseded/`

## Recommended Execution Order

1. <Task / module>
2. <Task / module>
3. <Task / module>

## Open Cross-Module Questions

- Question:
  - Modules affected:
  - Owner:
  - Needed by:

## Global Rules

- Main thread owns product direction, architecture boundaries, priorities, dispatch, return review, recovery sweep, and cross-module risks.
- Module threads own implementation and local debugging inside their module boundary.
- Do not duplicate account, routing, billing, or support rules inside unrelated modules.
- Keep private access details out of committed docs.
- Update the relevant status/handoff/runbook/thread-run docs after meaningful work.
- Prefer visible native Codex Desktop thread operations for cross-thread work.
- Select Model Tier and Model Version Policy automatically for cross-thread tasks; default to latest available version, prefer `gpt-5.3-codex-spark` for suitable fast/low-risk work when its independent quota pool is useful, and record tier/model/version/quota reason.
- Use Return Packets instead of direct child-to-main callbacks as the stable return path.

- Archives are not read by default. Read `docs/archive/` only for historical investigation, regression analysis, audits, or context compaction.
- Active docs are snapshots, not logs; avoid duplicating the same fact across registry, roadmap, handoff, runbook, and ADRs.
