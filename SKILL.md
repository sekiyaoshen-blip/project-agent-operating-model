---
name: project-agent-operating-model
description: >
  Bootstrap, audit, repair, compact, or upgrade a durable project-agent
  operating model for long-running agent-assisted projects. Installs
  project-local rules for main planning threads, module/support/operations/
  research threads, AGENTS.md, project-state docs, thread registry, handoffs,
  runbooks, ADRs, cross-thread dispatch, checkpoints, return inboxes, model
  tier/version routing, localization, context budgets, archives, and compaction.
  Use for project setup, restructuring, migration, collaboration-model repair,
  or context-governance cleanup. Do not use for routine implementation after
  AGENTS.md and docs/thread-operating-model.md are installed. Trigger terms:
  agent operating model, project agent OS, main thread, module threads,
  context compaction, return inbox, dispatch queue, 主线程规划, 子线程实现,
  项目智能体协作, 上下文治理, 文档压缩, 归档策略.
---

# Project Agent Operating Model

## Skill Role

This skill is a bootstrap, audit, and repair tool for a durable project-agent operating model.
It installs runtime rules into project files so future threads can follow the system without repeatedly loading this skill.

Use this skill to:

- initialize a new project operating model
- reorganize an existing project
- install or update `AGENTS.md`
- create or repair project-state documents
- add or restructure long-lived module, support, operations, research, or customer-service threads
- generate thread startup prompts
- migrate runtime rules into project docs
- install or update model-tier and model-version routing rules for cross-thread dispatch
- install or repair context-budget, archive, compaction, and anti-bloat rules
- audit drift between docs, code, thread registry, handoffs, runbooks, and ADRs

Do not use this skill for:

- routine module implementation
- every cross-thread dispatch
- every checkpoint update
- every return packet
- ordinary status/handoff maintenance after the project contract is installed
- small one-off edits where `docs/status.md` or a short note is enough

After installation, runtime behavior should be governed by:

- `AGENTS.md`
- `docs/thread-operating-model.md`
- `docs/thread-registry.md`
- `docs/roadmap.md`
- `docs/status.md`
- `docs/modules/*/status.md`
- `docs/modules/*/handoff.md`
- `docs/modules/*/runbook.md`
- `docs/thread-runs/*`
- `docs/archive/*`
- `docs/decisions/*`

**Core principle:** Skill installs the system. `AGENTS.md` activates the system. Project docs run the system. The skill should not be the runtime.

## First Pass Audit

Before applying the structure, check whether this operating model is actually the right fit.

- If the work is small, use Minimal Mode: one thread plus `docs/status.md`.
- If module boundaries are unclear, first map domains, user workflows, data ownership, and integration points.
- If the user asks for sub-agents but wants long-lived visible conversations, recommend separate visible Codex threads instead of temporary sub-agents.
- If the user wants every detail synced to the main thread, push back and define what is main-thread relevant.
- If the user wants long-lived module threads, install module runbooks so threads can recover after long histories or conversation compaction.
- If the repo already has project docs, adapt to the existing structure instead of forcing new file names.

## Operating Modes

Choose the smallest operating mode that preserves useful project memory.

### Minimal Mode

Use for small, early, or exploratory projects.

Create only:

- `AGENTS.md`
- `docs/status.md`

Use when:

- there is one active thread
- module boundaries are unclear or unstable
- the project mainly needs continuity, not multi-thread orchestration

### Standard Mode

Use for medium projects with clear module boundaries and limited coordination overhead.

Create:

- `AGENTS.md`
- `docs/thread-operating-model.md`
- `docs/project-brief.md`
- `docs/roadmap.md`
- `docs/status.md`
- `docs/thread-registry.md`
- `docs/modules/<module>/status.md`
- `docs/modules/<module>/handoff.md`

Add `runbook.md` only for long-lived module threads.

### Full Mode

Use for large, long-running, multi-agent, or multi-module projects.

Create the full structure:

```text
AGENTS.md
docs/
  thread-operating-model.md
  project-brief.md
  roadmap.md
  status.md
  thread-registry.md
  decisions/
    ADR-0001-title.md
  modules/
    <module>/
      status.md
      handoff.md
      runbook.md
  thread-runs/
    <task-id>.md
    inbox/
      main/
        RET-<task-id>-<module>-<timestamp>.md
    archive/
      accepted/
      needs-followup/
      failed/
      superseded/
  archive/
    compactions/
    roadmap/
    modules/
      <module>/
```

## Installation Workflow

For a new project:

1. Clarify product objective, users, non-goals, constraints, and expected module boundaries.
2. Choose Minimal, Standard, or Full Mode.
3. Install `AGENTS.md` from `references/agents.template.md`.
4. Install `docs/thread-operating-model.md` from `references/thread-operating-model.template.md`.
5. Create project-state docs from the templates in `references/`.
6. Create `docs/archive/` folders for compactions, roadmap history, module history, and historical task material.
7. Fill `docs/thread-registry.md` with main thread, module threads, visible native thread links, fallback session/callable refs, and current state.
8. Generate module startup prompts from `references/module-startup-prompt.template.md`.
9. Explain that routine future work should follow `AGENTS.md` and project docs, not repeatedly invoke this skill.

For an existing project:

1. Inventory existing docs, README files, architecture notes, modules, packages, services, tests, and project instructions.
2. Infer module boundaries from code ownership, routes, packages, data models, APIs, and user workflows.
3. Preserve existing conventions where possible.
4. Add only the missing layer: `thread-operating-model.md`, registry, status, handoff, runbook, ADR, or thread-runs as needed.
5. Backfill current state from code and current docs. Do not pretend old project history is complete.
6. Install or update `AGENTS.md` with a lightweight pointer to the detailed operating model.
7. If the project already has bloated docs, run a context compaction sweep and archive stale material before adding more rules.
8. Report unresolved assumptions and recommended next fixes.

## What To Install

Use the included reference files:

- `references/agents.template.md` -> project `AGENTS.md`
- `references/thread-operating-model.template.md` -> `docs/thread-operating-model.md`
- `references/project-brief.template.md` -> `docs/project-brief.md`
- `references/roadmap.template.md` -> `docs/roadmap.md`
- `references/global-status.template.md` -> `docs/status.md`
- `references/thread-registry.template.md` -> `docs/thread-registry.md`
- `references/module-status.template.md` -> `docs/modules/<module>/status.md`
- `references/handoff.template.md` -> `docs/modules/<module>/handoff.md`
- `references/runbook.template.md` -> `docs/modules/<module>/runbook.md`
- `references/adr.template.md` -> `docs/decisions/ADR-0001-title.md`
- `references/thread-run.template.md` -> `docs/thread-runs/<task-id>.md`
- `references/return-packet.template.md` -> `docs/thread-runs/inbox/main/RET-<task-id>-<module>-<timestamp>.md`
- `references/context-compaction-note.template.md` -> `docs/archive/compactions/YYYY-MM-DD-context-compaction.md`

## Runtime Contract

The installed project contract must preserve these rules:

- Treat chat threads as work surfaces, not as the source of truth.
- Put durable project state in repo/workspace docs.
- Main thread owns roadmap, module boundaries, prioritization, cross-module decisions, active dispatch, return review, and recovery sweep.
- Module threads own implementation, local debugging, verification, status, handoff, and runbook updates for their module.
- Prefer visible native Codex Desktop thread operations for cross-thread work.
- Use session-id/app-server invocation only as fallback or automation layer, with a project-level run record.
- For every cross-thread dispatch, choose a Model Tier by task difficulty, risk, context size, and purpose; then choose Model Version. Default to the latest available compatible version for that tier, prefer `gpt-5.3-codex-spark` / GPT-5.3-SPARK for suitable fast or low-risk standard tasks when its independent quota pool helps, and record requested/actual model/version, quota pool, fallback, and selection reason in the dispatch queue and thread-run record.
- Every dispatched task has a `docs/thread-runs/<task-id>.md` record.
- Long tasks checkpoint before risky or long steps.
- Child/module threads do not directly interrupt the main thread as the stable return path; they write Return Packets into `docs/thread-runs/inbox/main/`.
- Main thread consumes return packets in queue order and updates the dispatch queue.
- Human-facing project communication follows the project/user/system language; code identifiers, paths, commands, API/schema/config fields, errors, logs, tests, package names, model names, quota-pool names, and stable template fields stay English or original.
- Active project-state docs are current snapshots, not append-only logs.
- Each fact should have one primary home; other docs should link instead of duplicating full content.
- Keep active docs within context budgets; archive stale, historical, closed, or processed material.
- Archives are not read by default; read them only for historical investigation, regression analysis, audits, or compaction.
- Run a context compaction sweep when docs become bloated, contradictory, stale, or confusing.
- Never write secrets, tokens, credentials, private customer data, signed URLs, or access-granting links into committed project-state docs.

## Audit / Repair Checklist

When auditing an enabled project, check:

- Is `AGENTS.md` concise and pointing to `docs/thread-operating-model.md`?
- Does `docs/thread-operating-model.md` contain the current runtime rules, including localization / system-language policy?
- Does `docs/thread-registry.md` list active threads, native links, fallback refs, dispatch queue, and next sync triggers?
- Are module boundaries clear and non-overlapping enough?
- Are stale, duplicate, or superseded thread refs marked?
- Are running/stalled tasks represented in `docs/thread-runs/`?
- Do dispatch queue rows and thread-run records include Model Tier, Model Version Policy, requested/actual model/version or mode, quota pool, fallback, and selection reason?
- Are checkpoint and resume prompts present for long tasks?
- Are return packets going to `docs/thread-runs/inbox/main/` instead of interrupting the main thread?
- Are handoffs compact and main-thread relevant?
- Are runbooks detailed enough for recovery but free of secrets and long raw logs?
- Are ADRs present for durable cross-module decisions?
- Are original engineering anchors preserved inside localized documentation?
- Are active docs current snapshots instead of append-only logs?
- Does each fact have a single primary home, with links instead of duplicated full content?
- Are handoffs compact and rewritten, not endlessly appended?
- Are runbooks focused on current recovery context, with old dated history archived?
- Are closed dispatch tasks and processed Return Packets removed from active queues/inboxes?
- Does `docs/archive/` contain useful historical detail without being read by default?
- Has a context compaction sweep been recorded when bloat or contradictions were repaired?

## Fallback

If project-local instructions cannot be written, tell the user to explicitly invoke this skill in new threads and point those threads to the project docs. Prefer writing a local operating document such as `docs/thread-operating-model.md` or `docs/project-operating-model.md` when `AGENTS.md` cannot be created.
