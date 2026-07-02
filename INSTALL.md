# Installation Notes

中文安装说明：[`INSTALL.zh-CN.md`](INSTALL.zh-CN.md)

## One-Prompt Installation

You can install this package through Codex, Claude Code, or another capable local agent by pasting one prompt.

English prompt:

```text
Install the Project Agent Operating Model skill from https://github.com/sekiyaoshen-blip/project-agent-operating-model into this machine's local agent skill directory.

Requirements:
- Detect the appropriate local skill root. Prefer $CODEX_HOME/skills when CODEX_HOME is set, otherwise use ~/.codex/skills for Codex. If the current agent uses another skill/plugin directory, explain the detected path before writing.
- Clone or update the repository into a directory named project-agent-operating-model.
- Preserve SKILL.md, agents/openai.yaml, references/, project-skeleton/, README files, LICENSE, and MANIFEST.md.
- Validate that SKILL.md has valid frontmatter with name: project-agent-operating-model and that agents/openai.yaml parses as YAML.
- Do not initialize or modify the current project unless I explicitly ask for project initialization after the skill is installed.
- After installation, report the installed path, the latest commit, and the exact command or invocation I should use to run the skill.
```

中文 prompt：

```text
请从 https://github.com/sekiyaoshen-blip/project-agent-operating-model 安装 Project Agent Operating Model skill 到这台机器的本地 Agent skill 目录。

要求：
- 自动检测合适的本地 skill 根目录。Codex 优先使用 $CODEX_HOME/skills；如果没有设置 CODEX_HOME，则使用 ~/.codex/skills。如果当前 Agent 使用其他 skill/plugin 目录，写入前先说明检测到的路径。
- 将仓库 clone 或更新到名为 project-agent-operating-model 的目录。
- 保留 SKILL.md、agents/openai.yaml、references/、project-skeleton/、README 文件、LICENSE 和 MANIFEST.md。
- 校验 SKILL.md frontmatter 有效，并且包含 name: project-agent-operating-model；校验 agents/openai.yaml 可以被 YAML 解析。
- 除非我在安装完成后明确要求初始化项目，否则不要修改当前项目文件。
- 安装完成后，报告安装路径、最新 commit，以及我应该用什么命令或调用方式运行这个 skill。
```

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
- `CLAUDE.md` if using Claude Code or another compatible agent
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
- Use LV2 controlled autonomous compaction for docs-only cleanup when preconditions are met.
- Acquire `docs/.locks/context-compaction.lock` before broad active-doc rewrites; the lock applies across tools and across different sessions/threads inside the same tool.
- Create a compaction request instead of executing when scope, ownership, active tasks, or safety is unclear.
- Do not make future threads read archives unless the task requires historical investigation or compaction.

## Localization

The installed operating model is language-neutral.

- Set `Project language` in `AGENTS.md` when a project has a preferred language.
- If no project language is configured, generated human-facing content should follow the user/system language or existing repository convention.
- Keep code identifiers, paths, commands, APIs, schemas, model names, quota-pool names, and stable template fields in English or original form.
- For open-source or public developer-facing artifacts, use English by default unless the project explicitly targets another language or maintains localized variants.

## Multi-Agent Entry Points

Codex reads `AGENTS.md`.

When using Claude Code, keep root `CLAUDE.md` short and import `AGENTS.md` instead of duplicating the full operating model. The project skeleton includes a ready-to-copy `CLAUDE.md`:

```md
@AGENTS.md
```

Other agents should also treat `AGENTS.md`, `docs/thread-operating-model.md`, and `docs/thread-registry.md` as the shared source of truth.

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
