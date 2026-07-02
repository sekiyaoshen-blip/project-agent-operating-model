# 安装说明

## 一键安装

你可以在 Codex、Claude Code 或其他具备本地文件操作能力的 Agent 中，直接粘贴一条 prompt 完成安装。

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

## 作为 Codex Skill 包使用

将整个目录放到 Codex skill loader 能识别的位置，并保持目录结构不变：

```text
project-agent-operating-model/
  SKILL.md
  agents/
    openai.yaml
  references/
```

然后只在以下场景调用这个 skill：

- 初始化项目运行模型。
- 重构已有项目的多线程协作方式。
- 修复已经混乱或失效的项目协作文档。
- 压缩膨胀的上下文和历史记录。
- 升级旧版本的项目运行模型。
- 修复 LV2 文档压缩、Compaction Lock 或多 Agent 入口相关问题。

不建议在每个普通开发任务、模块实现任务或派单任务中反复调用该 skill。

## 手动安装项目骨架

如果你想手动初始化一个项目，可以将 `project-skeleton/` 下的内容复制到目标项目根目录。

复制后，重点修改这些文件：

- `AGENTS.md`
- `CLAUDE.md`，如果使用 Claude Code 或其他兼容 Agent
- `docs/thread-operating-model.md`
- `docs/project-brief.md`
- `docs/roadmap.md`
- `docs/status.md`
- `docs/thread-registry.md`
- `docs/modules/example-module/*`

其中 `example-module` 应改成你项目里的真实模块名称。

## 配置模型路由

在 `docs/thread-operating-model.md` 和 `docs/thread-registry.md` 中，根据你的 Codex Desktop、CLI 或 IDE 环境配置模型路由。

默认建议维护这些层级：

- `fast`
- `standard`
- `high-reasoning`
- `specialized`

选择模型时，应先选择任务难度对应的模型层级，再选择具体模型版本。默认使用该层级中可用的最新兼容版本。

如果你的环境里有独立配额池的 `gpt-5.3-codex-spark` / GPT-5.3-SPARK，可以优先把适合的快速任务或低风险标准任务路由到 Spark，避免过早消耗 `gpt-5.5` 配额。

## 上下文治理

安装后的项目运行模型包含上下文预算、归档和压缩规则。

复制项目骨架后，应保持活跃文档为当前快照：

- `status.md`、`handoff.md`、`roadmap.md` 和 `thread-registry.md` 不应变成追加式流水账。
- 已完成阶段、过期 runbook 历史、关闭的派单任务和已处理的 Return Packet 应归档。
- 使用 `docs/archive/compactions/YYYY-MM-DD-context-compaction.md` 记录上下文清理。
- 当安全前提满足时，允许 Agent 执行 LV2 受控自主 docs-only 压缩。
- 执行大范围活跃文档重写前，应获取 `docs/.locks/context-compaction.lock`。该锁在不同工具之间共享，也区分同一工具里的不同线程或会话。
- 如果存在 active lock、stale lock、范围不清、任务仍活跃或涉及禁止范围，应创建 compaction request / Return Packet，让主线程或用户决定。
- 除非任务需要历史调查、审计、回归分析或压缩，否则不要让未来线程默认读取 archive。

LV2 可以整理：

- 活跃文档的快照化重写。
- 过期或历史内容归档。
- 已处理 Return Packet 移出 inbox。
- 已关闭或被替代的任务行归档。
- compaction note。
- registry 中的 queue、lock 和 active context hygiene 字段。

LV2 禁止整理：

- 源码、测试、生产配置。
- schema、migration。
- ADR 决策内容。
- 产品方向、模块归属、roadmap 优先级。
- public contract。

## 多 Agent 入口

Codex 读取 `AGENTS.md`。

Claude Code 可通过根目录 `CLAUDE.md` 共享同一套规则。项目骨架中的 `CLAUDE.md` 默认内容为：

```md
@AGENTS.md
```

这样 Codex 和 Claude Code 都以 `AGENTS.md`、`docs/thread-operating-model.md` 和 `docs/thread-registry.md` 为共同事实源，避免规则漂移。

## 本地化

安装后的运行模型是语言中立的。

- 如果项目有固定语言，在 `AGENTS.md` 中设置 `Project language`。
- 如果没有配置项目语言，面向人的生成内容应遵循用户语言、系统语言或仓库现有语言。
- 代码标识符、路径、命令、API、schema、模型名、配额池名和稳定模板字段应保留英文或原始形式。
- 开源或公共开发者文档默认使用英文，除非项目明确维护本地化版本。

## Codex 元数据

本包包含 `agents/openai.yaml`，用于 Codex App 的 UI 元数据和调用策略。

该文件有意设置：

```yaml
policy:
  allow_implicit_invocation: false
```

这表示 skill 默认需要显式调用。项目契约安装完成后，日常模块实现、派单队列更新、检查点恢复和交接维护，应依赖项目文档，而不是反复加载完整 skill。

## 运行时提醒

不要把这个 skill 当作每个任务都要调用的常驻运行时。

安装项目契约后，项目自己的 `AGENTS.md` 和 `docs/thread-operating-model.md` 才是后续线程协作的主要依据。
