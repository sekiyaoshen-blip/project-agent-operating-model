# Thread Operating Model

Last updated: YYYY-MM-DD

This file is the detailed runtime collaboration policy for the project. `AGENTS.md` is the lightweight entrypoint; this file is the source of truth for cross-thread work, module boundaries, active dispatch, checkpoints, return inbox, recovery, context compaction, archive policy, and localization policy.

## Core Idea

Treat chat threads as work surfaces, not as the source of truth. Put durable project state in the repository or workspace so the main thread can read compact summaries and decisions while module threads keep implementation detail local.

Use this model:

- Main thread: owns product direction, roadmap, module boundaries, cross-module decisions, prioritization, active dispatch, return review, and recovery sweep.
- Module threads: own implementation, local debugging, verification, status, handoff, and runbook updates inside their module.
- Project documents: own durable state sync between threads.
- Module runbooks: own module-thread memory recovery, including useful attempts, findings, pending questions, local decisions, debug notes, and continuation points.
- ADRs: own decisions that affect architecture, data contracts, product scope, deployment, security, cost, or multiple modules.

## Source Of Truth Priority

When sources conflict, use this priority order:

1. Current code and tests
2. Current build, CI, runtime behavior, or deployment config
3. Accepted ADRs
4. `docs/roadmap.md` and `docs/thread-registry.md`
5. Module `status.md`
6. Module `handoff.md`
7. Module `runbook.md`
8. Chat history or unstated assumptions

Do not silently merge conflicting sources. Report the conflict and update stale documents. If the conflict affects architecture, shared contracts, deployment, security, cost, or product scope, create or update an ADR.

## System Language And Localization Policy

Human-facing project communication should follow the project/user/system language instead of assuming any single language.

Determine the working language in this order:

1. Explicit user instruction in the current task.
2. Project language configured in `AGENTS.md` or this operating model.
3. Existing language convention in the repository, docs, tickets, or team workflow.
4. User interface / system locale / current conversation language when available.
5. English as the fallback for open-source or public developer-facing artifacts.

Use the selected working language for:

- User-facing explanations
- Project planning
- Roadmap notes
- Status summaries
- Handoff summaries
- Runbook notes
- Decision rationale
- Cross-thread task background
- Main-thread review summaries
- Return Packet summaries

Keep English or original text for:

- File paths
- Commands
- Code identifiers
- Function, class, variable, event, and API names
- Schema fields
- Config keys
- Environment variable names
- Package names
- Framework names
- Error messages
- Logs
- Test names
- Public protocol names
- External documentation titles
- Stable structured field names in task, checkpoint, dispatch, model-routing, and return-packet templates

For structured project-state documents, keep canonical section names and fields stable when they are referenced by other docs, scripts, or agents. Explanatory content may use the selected working language.

When localizing technical concepts, preserve the original engineering anchor on first use:

- Localized explanation (`invoice status normalization`)
- Localized label (`Return Packet`)
- Localized label (`Active Dispatch Queue`)
- Localized label (`handoff.md`)

Do not translate code symbols, API contracts, file names, commands, model names, quota-pool names, or error output.

Prefer bilingual or localized headings for high-traffic orchestration concepts when useful:

```md
## Return Inbox (<localized label>)
## Active Dispatch Queue (<localized label>)
## Checkpoint (<localized label>)
## Resume Prompt (<localized label>)
```

For open-source projects, public APIs, libraries, SDKs, or external developer documentation, prefer English by default unless the project explicitly targets another language or maintains localized documentation variants.

If multiple collaborators use different languages, keep stable templates and headings in English and write explanatory summaries in the project language. Avoid mixing languages inside code identifiers or contracts.

## Security And Log Hygiene

Never write secrets, API keys, tokens, credentials, private customer data, sensitive personal data, signed URLs, private URLs, or access-granting links into committed project-state documents.

For logs and debugging notes:

- Paste only the minimal useful excerpt.
- Redact tokens, emails, IDs, credentials, private URLs, and customer data.
- Prefer linking to local log files instead of copying long logs.
- Record the signal, not the noise: symptom, reproduction, likely cause, affected files, and next check.

## Context Budget, Compaction, And Archive Policy

### Core Rule

Active project-state documents are current snapshots, not append-only logs.

The operating model must preserve useful context without making every future thread read historical noise. Use active docs for current truth, current risks, current decisions, and current next actions. Use archives for historical detail.

### Active Context Budget

Keep active docs within practical size limits. These are guidance budgets, not hard parser limits:

| Active Doc | Primary Role | Practical Budget | When It Grows |
|---|---|---:|---|
| `AGENTS.md` | Lightweight project instructions and pointers | 80-120 lines | Move detail to `docs/thread-operating-model.md` |
| `docs/thread-operating-model.md` | Stable operating rules, not project history | 300-600 lines | Move project-specific history to archives or separate references |
| `docs/thread-registry.md` | Active threads, active dispatch queue, Return Inbox index | 100-200 lines | Close/archive stale tasks and superseded thread refs |
| `docs/roadmap.md` | Current phase, active milestones, active dependencies | 150-250 lines | Move completed phases to `docs/archive/roadmap/` |
| `docs/status.md` | Current global state | 80-150 lines | Remove old completed detail or archive it |
| Module `status.md` | Current module state and scope | 80-150 lines | Move old detail to module archive or runbook summary |
| Module `handoff.md` | Compact main-thread handoff | 50-100 lines | Rewrite as a current handoff snapshot |
| Module `runbook.md` | Current recovery context and active findings | 200-400 lines | Compact old findings into `docs/archive/modules/<module>/` |
| `docs/thread-runs/<task-id>.md` | Single task checkpoint and resume state | Task lifetime only | Archive or close after main-thread review |
| `docs/thread-runs/inbox/main/` | Unprocessed Return Packets only | As close to zero as possible | Process and archive packets |

### Single-Home Rule

Each fact should have one primary home:

- Product direction and non-goals: `docs/project-brief.md`
- Current priorities, milestones, and dependencies: `docs/roadmap.md`
- Active thread identities and dispatch queue: `docs/thread-registry.md`
- Current module behavior and scope: module `status.md`
- Main-thread relevant module summary: module `handoff.md`
- Local recovery notes and useful attempts: module `runbook.md`
- Durable cross-module decisions: ADRs in `docs/decisions/`
- Single task execution state: `docs/thread-runs/<task-id>.md`
- Pending returned results: `docs/thread-runs/inbox/main/`

Other documents may link to the primary home, but should not copy the full content.

### Snapshot, Not Log

Do not keep stale entries in active docs merely because they were once true.

- `status.md` describes what is true now.
- `handoff.md` describes what the main thread needs now.
- `roadmap.md` describes the current planning state.
- `thread-registry.md` describes active threads and active tasks.
- `runbook.md` preserves recovery context, not full transcript history.

### Archive Layout

Use `docs/archive/` for historical information that is useful but no longer active context:

```text
docs/
  archive/
    compactions/
      YYYY-MM-DD-context-compaction.md
    roadmap/
      YYYY-MM-DD-roadmap-archive.md
    modules/
      <module>/
        runbook-YYYY-QN.md
        handoff-YYYY-QN.md
    thread-runs/
      accepted/
      needs-followup/
      failed/
      superseded/
```

Archives are not read by default. Read archives only for historical investigation, regression analysis, audits, or context compaction.

### Handoff Rewrite Rule

`handoff.md` must be rewritten as a compact current handoff, not appended forever.

Keep only:

- Current behavior-level state
- Main-thread relevant changes since last accepted sync
- Active contract changes
- Active decisions needed
- Active risks / blockers
- Latest meaningful verification
- Next 3-5 local actions

Archive or remove:

- Completed details already accepted by the main thread
- Superseded risks
- Raw logs
- Long implementation narratives
- Repeated file lists
- Old debug notes

### Runbook Compaction Rule

`runbook.md` may contain local recovery context, but it must not become a full transcript.

Keep the active runbook focused on:

- Current recovery context
- Active findings
- Current continuation point
- Active risks
- Pending questions
- Archive index

When it grows too large:

1. Summarize old entries into durable findings.
2. Move detailed history to `docs/archive/modules/<module>/`.
3. Promote cross-module decisions to ADRs.
4. Remove stale local notes from the active runbook.

### Task And Return Inbox Closure Rule

A dispatched task is not finished until:

- The target thread writes a Return Packet.
- The main thread reviews it.
- The dispatch queue row is marked `closed`, `needs-followup`, `superseded`, or `failed`.
- Useful outputs are promoted to status, handoff, roadmap, or ADR.
- The run record is archived or linked from archive.
- The Return Inbox item is removed from the active inbox.

`docs/thread-runs/inbox/main/` must contain only unprocessed Return Packets.

### Read Budget Rule

Threads should read the minimum active context needed for the task.

Module threads should normally read:

1. `AGENTS.md`
2. Relevant rows in `docs/thread-registry.md`
3. Their module `status.md`
4. Their module `handoff.md`
5. The current recovery context in their module `runbook.md`
6. Relevant ADRs only when contracts or architecture are involved
7. Relevant `docs/thread-runs/<task-id>.md` only for dispatched tasks

Main thread should normally read:

1. `AGENTS.md`
2. `docs/project-brief.md`
3. `docs/roadmap.md`
4. `docs/status.md`
5. `docs/thread-registry.md`
6. Module handoffs, not full module runbooks
7. Relevant ADRs
8. Unprocessed Return Packets, one at a time

Do not read archives, all module runbooks, all thread-runs, or unrelated ADRs by default.

### Context Compaction Sweep

Run a context compaction sweep when:

- Any active doc exceeds its budget.
- Handoff contains stale completed work.
- Runbook has too much dated history.
- Thread registry contains closed or stale tasks.
- Return Inbox contains processed packets.
- Roadmap contains completed phases no longer being planned.
- A replacement main thread or module thread is about to start.
- The user reports context confusion, stale assumptions, or contradictory docs.

Sweep process:

1. Read active docs only.
2. Identify stale, duplicate, contradictory, or historical content.
3. Compare against source-of-truth priority:
   - current code and tests
   - accepted ADRs
   - roadmap and thread registry
   - module status
   - handoff
   - runbook
   - archives or chat history
4. Rewrite active docs as current snapshots.
5. Move useful historical detail to `docs/archive/`.
6. Close, supersede, or archive stale task rows.
7. Empty processed Return Inbox items.
8. Record the cleanup in `docs/archive/compactions/YYYY-MM-DD-context-compaction.md`.

### Anti-Bloat Rules

Do not:

- Copy full chat history into docs.
- Append every turn to runbook.
- Append every task result to handoff.
- Duplicate the same decision in roadmap, handoff, runbook, and ADR.
- Keep closed dispatch tasks in the active queue.
- Keep processed return packets in the active inbox.
- Keep old completed milestones in active roadmap.
- Read archives by default.
- Update docs when no substantive project state changed.
- Create new docs when an existing active doc has the same responsibility.

## Thread Identity Registration

Each long-lived thread must register its stable identity in `docs/thread-registry.md` when it is initialized or replaced.

This applies to:

- Main Thread
- Module Thread
- Support Thread
- Operations Thread
- Research Thread
- Customer-Service Thread
- Any other long-lived project thread

Register these fields:

- Role
- Native Thread Link
- Session ID / Callable Ref
- Started
- Last Sync
- Replaces
- Current State
- Next Sync Trigger

If the current runtime cannot expose a stable thread/session/callable reference, do not invent one. Write:

- `Unavailable in current runtime`
- or `TBD`

Do not write tokens, cookies, private keys, signed URLs, or access-granting links into the registry.

## Thread Routing And Module Ownership

### Core Rule

Each long-lived thread has a default ownership boundary.

- The main thread owns product direction, roadmap, architecture boundaries, module assignments, priorities, and cross-module decisions.
- Module threads own implementation, local debugging, verification, and module-specific iteration inside their module.
- Support, operations, research, or other specialized threads own their defined workflow, but must route module-owned implementation work to the relevant module thread.

Module boundaries are ownership lines, not hard walls. A module thread may perform small adjacent integration work when required to complete its accepted task, but it must not silently take over another module’s core responsibilities, public contracts, business rules, or implementation direction.

### Cross-Thread Invocation Priority

When one thread needs another long-lived thread to do work, choose invocation paths in this order:

1. Prefer native Codex Desktop thread tools.
   - Prefer native thread continuation, background thread creation, thread search, thread routing, or app-visible task controls.
   - The goal is for cross-thread work to appear as normal Codex Desktop thread activity, including the prompt, progress, result, and review state.
2. Use Codex-managed subagent or background-thread workflows next.
   - Use this for temporary, bounded child tasks where the parent thread only needs a consolidated result.
   - Do not use temporary subagents as a replacement for long-lived module threads when durable module memory is needed.
3. Use app-server / session-id invocation only as a fallback or automation layer.
   - Use this when native Codex Desktop thread tools are unavailable, insufficient, or intentionally bypassed.
   - When using session-id invocation, create a project-level run record so progress remains observable when Desktop UI live refresh is unavailable.
4. If no reliable invocation path exists, write the task into `docs/thread-registry.md`, the target module `handoff.md`, or `docs/thread-runs/<run-id>.md`, and clearly mark it as pending.

### Codex Desktop Visibility Rule

Cross-thread work should prefer paths that are visible as normal Codex Desktop thread activity.

When available, use native Codex Desktop thread tools to:

- Continue an existing target thread.
- Create a separate background thread.
- Route work to a visible module thread.
- Inspect running progress.
- Open or review the target thread result.
- Preserve the prompt and response in Desktop UI.

Do not default to low-level session-id invocation when a native Desktop-visible thread operation is available.

If session-id invocation is used because native tools are unavailable, also write a run record to:

- `docs/thread-runs/<run-id>.md`
- or `.codex/thread-runs/<run-id>.jsonl`

When Codex Desktop UI cannot live-refresh, the run record is the fallback observable source of truth.

### Model Routing Rule

For cross-thread dispatch, the main thread must first choose the appropriate Model Tier based on task difficulty, risk, context size, and purpose, then choose the Model Version, and record the choice in the dispatch queue and thread-run document.

Do not hard-code all tasks to a single model in the templates. Model names can come from project `.codex/config.toml`, user settings, Codex Desktop UI, CLI flags, IDE model selector, or team conventions.

#### Selection Order

1. First classify the task into a Model Tier: `fast`, `standard`, `high-reasoning`, or `specialized`.
2. Then choose an available model version in that tier.
3. By default, use the latest available, non-deprecated model version in that tier that is compatible with the current entrypoint.
4. Pin to an older or specific version only for reproduction, compatibility, explicit user request, quota optimization, or project configuration.
5. If the requested model version is unavailable, choose the nearest available fallback in the same tier and record why.
6. If the task reveals higher risk or more complex reasoning needs, escalate to a stronger tier or newer model version; do not silently downgrade high-risk work.

#### Model Tiers

| Tier | Recommended Use | Avoid For |
|---|---|---|
| `fast` | Low-risk, short-context, local tasks: doc formatting, status updates, simple search, lightweight verification, style tweaks, repetitive small fixes, limited test runs, quick first-pass investigation | Architecture, permissions, billing, security, data migration, public contracts, complex bugs, cross-module refactors |
| `standard` | Default choice: normal module implementation, local bug fixes, routine test fixes, clear single-module tasks, routine review | High-risk cross-module decisions, long-term architecture tradeoffs, repeatedly failing complex issues |
| `high-reasoning` | Difficult or high-risk tasks: cross-module contracts, ADRs, permission/auth, billing, security, data model/migration, deployment, performance bottlenecks, complex debugging, ambiguous requirements, retry after a failed attempt, refactors affecting multiple modules | Pure formatting, simple status updates, low-value repetitive tasks |
| `specialized` | Project-configured specialized models or modes, such as ultra-fast interaction, visual/frontend specialty, code-search specialty, or security-scan specialty | No specialty is configured, or the task needs general high reasoning |

#### Model Version Policy

Default policy is `latest-available`: use the latest available, non-deprecated model version in the selected Model Tier that is compatible with the current entrypoint.

Available version policies:

- `latest-available`: default. Choose the latest available model for that tier in the current environment.
- `pinned`: pin to a specific model version for reproduction, compatibility, audit, or explicit user request.
- `quota-optimized`: choose an independent-quota or lower-cost model when it is capable enough.
- `fallback`: use an alternative model when the requested model is unavailable, invisible, quota-limited, or restricted by the current entrypoint.

Version selection rules:

- Do not pin old versions by default; follow the latest available version.
- If using an older version, record why it is more suitable than the latest version.
- If using a fallback, record the requested model, actual model, and fallback reason.
- If a task escalates from `fast` or `standard` to `high-reasoning`, prefer the latest available version in that tier.
- For automation, child-thread, or parallel tasks, still record the actual model/version to avoid recovery confusion.

#### GPT-5.3-Codex-Spark Preference

In the current user/project environment, `GPT-5.3-SPARK` (often recorded as model ID `gpt-5.3-codex-spark`) may be treated as a quota pool independent from `GPT-5.5`. When the task’s capability requirements match, prefer Spark to preserve `GPT-5.5` quota for high-risk, high-reasoning, or long-context work.

Prefer Spark for:

- `fast` tier tasks.
- Low-to-medium-risk `standard` tier tasks.
- Coding loops that need fast interaction, quick iteration, or near-real-time feedback.
- Small bug fixes, lint/test fixes, documentation/status updates, simple code search, and simple verification.
- Tasks with clear acceptance criteria and quick test or human-review paths.
- Large parallel child-thread batches where each task is low-risk and cheap to fail.
- Situations where `GPT-5.5` quota is tight and the task does not need frontier-level reasoning.

Avoid Spark for:

- `high-reasoning` tier tasks.
- Architecture, ADRs, cross-module contracts, permission/auth, billing/payments, security, data migration, deployment, performance bottlenecks, or complex recovery.
- Ambiguous requirements, very long context, or tasks that require synthesis across module history and ADRs.
- High-failure-cost work, changes that are hard to revert, or tasks affecting production or customer-data correctness.

If Spark discovers that the task exceeds its capability boundary, checkpoint, update the thread-run record, and escalate to the latest available `standard` or `high-reasoning` model version. Do not keep a clearly high-risk task on Spark merely because it has an independent quota pool.

#### Selection Signals

Escalate the model tier when any condition applies:

- It changes a public API, schema, shared type, event, CLI, config, file format, or data contract.
- It involves security, auth, permission, billing, payments, customer data, deployment, migration, or cost risk.
- It crosses multiple modules or requires a lead module plus supporting modules.
- Requirements are unclear and need reasoning, decomposition, or tradeoff analysis.
- There have been previous failed attempts, or recovery sweep must resume a complex task.
- Context is long and requires synthesis across roadmap, handoff, runbook, ADR, and code state.
- Failure affects production, release, customer experience, or data correctness.

Downgrade the model tier only when all conditions apply:

- Scope is clear and local.
- Risk is low and changes are easy to revert.
- It does not change contracts, data models, permissions, deployment, or cross-module boundaries.
- Acceptance criteria are simple and quickly verifiable.
- The task is mainly formatting, documentation, search, simple tests, status sync, or a small style adjustment.

#### Required Dispatch Fields

Every cross-thread task must record:

- Model tier: `fast` | `standard` | `high-reasoning` | `specialized`
- Model version policy: `latest-available` | `pinned` | `quota-optimized` | `fallback`
- Requested model / mode: `<project-configured model id or native UI selection>`
- Requested model version: `<latest available by default, or explicit version>`
- Actual model / mode: `<actual model used by the target thread>`
- Actual model version: `<actual version used, if visible>`
- Fallback model / mode: `<fallback if requested model is unavailable>`
- Quota pool: `gpt-5.5` | `gpt-5.3-codex-spark` | `shared` | `unknown` | `<project-defined>`
- Model selection reason: `<why this tier/version was chosen>`
- Escalation trigger: `<when to switch to a stronger model or newer version>`

If the target thread cannot use the requested model or mode, record the actual model/mode and explain the difference in the Return Packet. Do not silently downgrade high-risk work to a weaker model to save quota, and do not default low-risk repetitive work to the highest-cost model.

## Main Thread Active Dispatch Rule

The main thread should not merely passively receive module-thread sync information.  
When the main thread identifies a problem, risk, gap, cross-module dependency, or parallelizable work, it should actively decompose the issue and dispatch scoped tasks to the appropriate module threads.

The main thread is responsible for:

- Identifying problems that need action.
- Determining which module owns the work, or whether multiple modules must collaborate.
- Creating clear execution tasks.
- Dispatching tasks through the highest-priority visible thread invocation path.
- Tracking task state, dependencies, acceptance criteria, and returned results.
- Updating `roadmap.md`, `thread-registry.md`, module `handoff.md`, or ADRs when needed.

The main thread is not responsible for:

- Personally implementing every module’s internal details.
- Spending long periods in local debugging inside a module.
- Bypassing module threads to directly refactor another module’s internals.
- Becoming the implementation thread for all modules.

When work belongs to an existing module, the main thread should create a scoped task and route it to the corresponding module thread.

### Main Thread Active Dispatch Flow

When the main thread encounters a problem or opportunity that requires execution:

1. Classify the issue.
   - Product decision
   - Architecture decision
   - Module-local implementation
   - Cross-module feature
   - Investigation
   - Verification
   - Documentation / status update
2. Determine ownership.
   - Single owning module
   - Lead module plus supporting modules
   - Main-thread decision only
   - Unclear ownership requiring boundary clarification
3. Create one or more scoped tasks.
   Each task must include target module, context, desired outcome, acceptance criteria, relevant files/docs, dependencies, expected verification, Model Tier, model version policy, requested/actual model or mode, model selection reason, and sync-back location.
4. Select the Model Tier, Model Version Policy, requested model/mode, and quota pool before dispatch, then dispatch tasks using the preferred visible thread path.
5. Track task state in `docs/thread-registry.md`, `docs/roadmap.md`, or `docs/thread-runs/<run-id>.md`.
6. Review returned results.
7. Close, request follow-up, or escalate to ADR/roadmap update.

### Dispatch Guardrails

The main thread should actively dispatch work, but avoid noisy task creation.

Create a dispatched task only when:

- the work has a clear owner
- the expected output is concrete
- the acceptance criteria are testable or reviewable
- the task is worth preserving in project state
- the target thread has enough context to act

Do not dispatch tasks for:

- vague ideas with no clear outcome
- tiny clarifications that can be answered immediately
- purely informational notes
- work that should first be resolved as a product or architecture decision
- tasks that duplicate an already active module assignment

## Module Boundary Rules

### Local Adjacent Implementation Rule

A module thread may perform small adjacent cross-module implementation only when all of these conditions are true:

- The work is required to complete the current accepted task for this module.
- The change is small relative to the current task.
- The change does not alter another module’s public API, schema, event contract, permission model, billing logic, routing ownership, persistence model, or deployment assumptions.
- The owning module can easily review or revert the change.
- The change is recorded in the current module’s `handoff.md`.
- If the change affects another module’s files, tests, or behavior, the corresponding module thread is notified.

If any condition is not true, do not continue implementing locally; route the task to the corresponding module thread instead.

### Required Routing To Owning Module

A thread must route the task to the corresponding module thread when any condition applies:

- The task primarily belongs to another module’s responsibility area.
- It requires substantial implementation in another module.
- It changes another module’s public API, schema, shared type, event, CLI, config, or file format.
- It changes another module’s data ownership, persistence model, permission model, routing logic, billing logic, support flow, or deployment assumptions.
- It requires deep debugging inside another module.
- It requires refactoring another module’s internals.
- The current thread would spend more time working in another module than its own.
- The change creates a risk that the owning module will not understand, accept, or maintain it.

If the current thread needs to explain or modify another module’s internal design, it is probably routing work, not local adjacent work.

### Lead Module For Cross-Module Features

When a feature crosses module boundaries, assign one lead module.

The lead module owns:

- User-facing outcome
- Acceptance criteria
- Integration plan
- Cross-module task breakdown
- Final verification path
- Main-thread handoff

Supporting modules own:

- Their local implementation
- Their module contracts and boundaries
- Their local verification
- Their `status.md` and `handoff.md` updates

The lead module may implement small integration glue, but it must route substantial module-owned work to supporting modules.

### Cross-Module Conflict Handling

If a thread discovers that its task overlaps with another module’s ownership:

1. Stop expanding the local change.
2. Record the ownership overlap in the current module’s `handoff.md`.
3. Check `docs/thread-registry.md` to identify the owning module thread.
4. Route the relevant task to the owning module thread using the Cross-Thread Task Payload.
5. Continue only the parts clearly owned by the current module.
6. Ask the main thread to decide ownership if the boundary is unclear.

Do not silently overwrite, rewrite, or redesign another module’s work.

## Quota-Aware Dispatch, Recovery, And Return Inbox

### Core Principle

Native Codex Desktop thread tools are the preferred visible execution surface, but project-state documents are the durable reliable control surface.

Cross-thread tasks must not assume:

- The task will finish in one run.
- The task will automatically continue after quota resets.
- Child threads can reliably interrupt the main thread to return results.
- Codex Desktop UI state is the only source of truth.

Every cross-thread task must be checkpointable, resumable, reviewable, and closable.

### Quota-Aware Dispatch Rule

When the main thread dispatches a task, it must create a durable task record:

- `docs/thread-runs/<task-id>.md`

And register it in the Active Dispatch Queue in `docs/thread-registry.md`:

- Task ID
- Source thread
- Target thread / module
- Type
- Priority
- Model Tier
- Requested Model / Mode
- Model Selection Reason
- State
- Lease Until
- Last Checkpoint
- Last Run
- Return Packet
- Next Action

Task states may include:

- `pending`
- `dispatched`
- `accepted`
- `running`
- `checkpointed`
- `paused-quota`
- `paused-approval`
- `paused-runtime`
- `stalled`
- `returned`
- `in-review`
- `accepted-result`
- `needs-followup`
- `superseded`
- `closed`

### Checkpoint Rule

Long-running threads must work with checkpoints.

Before starting risky or long steps, and after each meaningful step, update the task run record:

- Current state
- Completed work
- Files changed
- Commands/checks run
- Remaining work
- Blockers
- Whether it is safe to resume
- Next explicit command or next action

If a thread detects that quota may run out, stop expanding scope and write a checkpoint first.

If execution stops unexpectedly without a checkpoint, the next resume must first inspect code, tests, and task docs before deciding whether to continue, redo, or close the task.

### Resume Prompt Rule

Each cross-thread task record must include a resume prompt. On resume, first check whether acceptance criteria are already satisfied; do not repeat destructive steps.

### Return Inbox Rule

The main thread must not treat “child thread sends a prompt directly to the main thread” as the stable return channel.

When a module thread completes, blocks, or needs main-thread review, it must write a Return Packet to:

- `docs/thread-runs/inbox/main/`

The child thread may additionally notify the main thread through native Codex Desktop thread tools, but that notification is only a hint, not the source of truth.

When the main thread processes a Return Packet:

1. Read only one Return Packet at a time.
2. Match it to the original task by Task ID.
3. Check the task state in `docs/thread-registry.md`.
4. Review acceptance criteria and verification results.
5. Decide whether to accept the result, request follow-up, route a new task, escalate to ADR/roadmap, mark blocked, or close the task.
6. Update the dispatch queue state.
7. Mark or move the Return Packet as accepted, superseded, failed, or needs-followup.

### Recovery Sweep Rule

The main thread or a designated dispatcher thread should periodically run recovery sweep:

1. Read `docs/thread-registry.md#active-dispatch-queue`.
2. Find tasks in `running`, `dispatched`, or `accepted` state that are past `Lease Until`.
3. Check whether the corresponding `docs/thread-runs/<task-id>.md` has a new checkpoint or Return Packet.
4. If there is no new progress, mark the task as `paused-quota`, `paused-approval`, `paused-runtime`, or `stalled`.
5. Generate a Resume Prompt.
6. Prefer native Codex Desktop thread tools to resume the target thread.
7. If native resume is unavailable, use the fallback invocation path.
8. After resume, update `Last Run`, `Last Checkpoint`, and `Next Action`.

Do not blindly dispatch the same task again. Before resuming, check whether the acceptance criteria are already satisfied.

## Sync Rules

Sync to the main thread when:

- A module changes public behavior, data model, API, schema, event, shared type, config, deployment assumption, or user workflow.
- A module needs a product, priority, architecture, or cross-module decision.
- A risk could affect roadmap, launch quality, security, performance, cost, or another module.
- A milestone completes or a commit changes planning-relevant behavior.

Do not sync:

- Full chat transcripts
- Verbose implementation logs
- Local debugging dead ends
- Raw test output unless it explains a material risk
- Code snippets that the main thread does not need to reason about

Record in module runbook instead:

- Useful implementation attempts and why they were kept or abandoned
- Debug paths, reproduction notes, short error excerpts, and findings
- Local decisions that do not yet deserve an ADR
- Pending module questions, local TODOs, and context needed after compaction
- Continuation notes for the next turn in the same module thread

## Turn-End Maintenance Rule

At the end of every meaningful task in an enabled project, update documentation according to impact:

- Update `runbook.md` when the module thread learned something useful, tried a meaningful approach, changed local direction, found a risk, or created continuation context.
- Update `status.md` when current module behavior, scope, backlog, assumptions, or local risks changed.
- Update `handoff.md` when the main thread needs to know about behavior, contracts, risks, decisions needed, verification gaps, or milestone progress.
- Add or update an ADR when a decision affects more than one module, a shared contract, architecture, deployment, security, cost, or product scope.
- Update `roadmap.md` when scope, priority, dependencies, milestones, or ownership changed.
- Update `thread-registry.md` when thread identity, dispatch queue, return packet state, last run, next sync trigger, or ownership changes.

Only update project-state documents when there is a substantive state or information change. Do not force a document edit for purely informational chat, clarification that changes no project state, or no-op investigation.

Active docs should be rewritten as current snapshots. Prefer replacing stale sections with current truth over appending another dated note. If an update would make an active doc exceed its budget, compact or archive old material first.

## Commit And Documentation Rule

When preparing a commit, include project-state documentation updates in the same change set if the code change changes project state, behavior, contracts, risk, roadmap status, or continuation context.

Do not require documentation updates for:

- Pure formatting
- Mechanical refactors with no behavior or contract change
- Typo fixes
- Test-only changes that do not change project understanding
- Reverted no-op experiments

Never commit automatically unless the user or project policy explicitly asks for auto-commit behavior.

## Main Thread Review Loop

When acting as the main thread:

1. Read the minimum active context needed: `AGENTS.md`, `docs/project-brief.md`, `docs/roadmap.md`, `docs/status.md`, `docs/thread-registry.md`, module handoffs, unprocessed Return Packets, and relevant ADRs.
2. Do not read archives, all module runbooks, or all thread-runs by default.
3. Run recovery sweep for stale, quota-paused, or lease-expired active tasks.
4. Run context compaction sweep when active docs exceed budgets, contradictions appear, stale assumptions spread, or a replacement main/module thread is about to start.
5. Consume Return Packets one at a time from `docs/thread-runs/inbox/main/`.
6. Summarize only cross-module implications.
7. Identify active problems, blockers, stale module states, verification gaps, cross-module dependencies, and opportunities for parallel execution.
8. Update roadmap, ownership, dependencies, priorities, and module assignments as current snapshots.
9. Resolve product, priority, architecture, or cross-module decisions requested by module handoffs or Return Packets.
10. Proactively create execution tasks for module threads when work belongs to a module or can be parallelized.
11. Dispatch tasks using the preferred visible thread path, with clear scope, inputs, outputs, acceptance criteria, dependencies, selected Model Tier, Model Version Policy, requested/actual model or mode, quota-pool reason, verification expectations, checkpoint requirements, and sync-back requirements.
12. Track active dispatched tasks in `docs/thread-registry.md` and `docs/thread-runs/<task-id>.md`; close or archive completed/superseded tasks.
13. Review returned module results and either accept, request follow-up, update roadmap/ADRs, or dispatch additional tasks.

Keep the main thread focused on planning quality, task decomposition, routing, return review, context hygiene, and cross-module coordination, not implementation volume.
