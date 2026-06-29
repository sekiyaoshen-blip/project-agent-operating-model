# Project Agent Operating Model

中文说明：[`README.zh-CN.md`](README.zh-CN.md)

A Codex skill package for bootstrapping, auditing, repairing, and compacting durable project-local operating rules for long-running agent-assisted projects.

It installs a project operating model with main planning threads, long-lived module/support/operations/research threads, project-state docs, handoffs, runbooks, ADRs, cross-thread dispatch, checkpoint recovery, Return Inbox workflows, model routing, localization, and context governance.

## Core Principle

```text
Skill installs the system.
AGENTS.md activates the system.
Project docs run the system.
The skill should not be the runtime.
```

After installation, routine project work should rely on project-local `AGENTS.md` and `docs/thread-operating-model.md`, not repeatedly invoke this skill.

## Package Structure

```text
project-agent-operating-model/
  SKILL.md                         # thin skill: bootstrap, audit, repair, compact, upgrade
  agents/openai.yaml               # Codex App metadata and explicit invocation policy
  references/                      # templates and detailed operating-model rules
  project-skeleton/                # copyable project-root skeleton
```

## Recommended Workflow

1. Invoke `$project-agent-operating-model` only when initializing, restructuring, repairing, compacting, or upgrading a project operating model.
2. Copy `project-skeleton/` into the target project root, or copy specific templates from `references/`.
3. For routine development, rely on project-local `AGENTS.md` and `docs/thread-operating-model.md`.
4. For cross-thread dispatch, choose a Model Tier by task difficulty first, then choose a Model Version. Default to the latest available compatible version for the selected tier.
5. Record requested/actual model/version, quota pool, fallback, and selection reason in `docs/thread-registry.md` and `docs/thread-runs/<task-id>.md`.

## Context Governance

- Active docs are current snapshots, not append-only logs.
- Keep `handoff.md`, `status.md`, `thread-registry.md`, and `roadmap.md` compact.
- Move stale, historical, processed, closed, or superseded material to `docs/archive/` or `docs/thread-runs/archive/`.
- Do not read archives by default; use them only for audits, historical investigation, regression analysis, or compaction.
- Run context compaction sweeps when docs become bloated, contradictory, stale, or confusing.

## Localization

- Human-facing generated content follows the explicit user/project language, existing repository language, user interface / system locale, or current conversation language.
- English is the fallback for open-source or public developer-facing artifacts.
- Code identifiers, file paths, commands, API/schema/config fields, errors, logs, model names, quota-pool names, and stable template fields stay English or original.

## Installation

See [`INSTALL.md`](INSTALL.md).

Chinese installation notes: [`INSTALL.zh-CN.md`](INSTALL.zh-CN.md).

## License

MIT License. See [`LICENSE`](LICENSE).
