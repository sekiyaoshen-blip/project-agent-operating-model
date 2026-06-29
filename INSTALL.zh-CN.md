# 安装说明

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

不建议在每个普通开发任务、模块实现任务或派单任务中反复调用该 skill。

## 手动安装项目骨架

如果你想手动初始化一个项目，可以将 `project-skeleton/` 下的内容复制到目标项目根目录。

复制后，重点修改这些文件：

- `AGENTS.md`
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
- 除非任务需要历史调查、审计、回归分析或压缩，否则不要让未来线程默认读取 archive。

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
