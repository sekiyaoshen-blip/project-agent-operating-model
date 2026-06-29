# Installation Notes

## Use As A Skill Package

Place this directory wherever your Codex skill loader expects skills, preserving this structure:

```text
project-agent-operating-model/
  SKILL.md
  agents/
    openai.yaml
  references/
```

Then invoke the skill only for initialization, restructuring, repair, or upgrade tasks.

## Use Project Skeleton

To bootstrap a project manually, copy the contents of `project-skeleton/` into your project root.

Then customize:

- `AGENTS.md`
- `docs/thread-operating-model.md`
- `docs/project-brief.md`
- `docs/roadmap.md`
- `docs/status.md`
- `docs/thread-registry.md`
- `docs/modules/example-module/*`

Rename `example-module` to your actual module name.

Customize Model Routing in `docs/thread-operating-model.md` and `docs/thread-registry.md` so `fast`, `standard`, `high-reasoning`, and `specialized` map to the model choices available in your Codex Desktop / CLI / IDE environment. By default, each tier should use the latest available compatible model version. If `gpt-5.3-codex-spark` / GPT-5.3-SPARK is available with an independent quota pool, map suitable fast or low-risk standard work to Spark before spending `gpt-5.5` quota.



## Context Governance

The installed operating model includes context-budget, archive, and compaction rules.

After copying the project skeleton, keep active docs as current snapshots:

- `status.md`, `handoff.md`, `roadmap.md`, and `thread-registry.md` should not become append-only logs.
- Archive completed phases, stale runbook history, closed dispatch tasks, and processed Return Packets.
- Use `docs/archive/compactions/YYYY-MM-DD-context-compaction.md` to record context cleanup sweeps.
- Do not make future threads read archives unless the task requires historical investigation or compaction.

## Localization

The installed operating model is language-neutral.

- Set `Project language` in `AGENTS.md` when a project has a preferred language.
- If no project language is configured, generated human-facing content should follow the user/system language or existing repository convention.
- Keep code identifiers, paths, commands, APIs, schemas, model names, quota-pool names, and stable template fields in English or original form.
- For open-source or public developer-facing artifacts, use English by default unless the project explicitly targets another language or maintains localized variants.

## Codex Metadata

This package includes `agents/openai.yaml` for Codex App UI metadata and invocation policy.

The file intentionally sets:

```yaml
policy:
  allow_implicit_invocation: false
```

This keeps the skill explicit-use by default so routine module implementation, dispatch queue updates, checkpoints, and handoff maintenance rely on project docs instead of repeatedly loading the full skill.

## Runtime Reminder

Do not keep invoking the skill for every module implementation or dispatch event. After the project contract is installed, use the project docs as the operating system.
