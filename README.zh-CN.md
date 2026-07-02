# Project Agent Operating Model

这是一个面向 Codex 的 skill 包，用来为长期、复杂、多人或多线程协作的项目建立一套项目本地的 Agent 运行规则。

它的目标不是让每次任务都反复加载一个很重的 skill，而是在项目初始化、重构、修复、压缩或升级时，把稳定的协作规则安装到项目自己的文档里。之后，日常开发线程主要读取项目内的 `AGENTS.md`、`docs/thread-operating-model.md` 和相关状态文档即可。

当前版本新增 LV2 受控自主压缩、跨工具/跨线程 Compaction Lock，以及 Claude Code 兼容入口，减少长期项目中的文档膨胀、并发整理冲突和多 Agent 规则漂移。

## 核心原则

```text
Skill 负责安装系统。
AGENTS.md 负责激活系统。
项目文档负责运行系统。
Skill 不应该成为日常运行时。
```

换句话说：这个 skill 是“初始化和治理工具”，不是每个任务都要调用的“常驻运行时”。

## 适用场景

- 项目开始时需要建立长期协作规则。
- 一个项目会拆成主线程、模块线程、支持线程、研究线程或运维线程。
- 需要跨线程派单、回传结果、维护线程登记表和任务运行记录。
- 项目文档已经膨胀、重复、冲突，需要做上下文治理和压缩。
- 需要把模型路由、配额池、降级策略、交接规则写进项目本地文档。
- 需要让未来新线程自动继承项目协作规范，而不是每次重新解释。

## 包结构

```text
project-agent-operating-model/
  SKILL.md                         # 轻量 skill：初始化、审查、修复、压缩、升级
  agents/openai.yaml               # Codex App 元数据和显式调用策略
  references/                      # 模板和详细运行规则
  project-skeleton/                # 可复制到目标项目根目录的骨架
    CLAUDE.md                      # Claude Code 兼容入口，默认引用 AGENTS.md
    docs/.locks/                   # 跨工具共享的文档整理锁控制面
```

## 推荐工作流

1. 只在初始化、重构、修复、压缩或升级项目运行模型时调用 `$project-agent-operating-model`。
2. 将 `project-skeleton/` 的内容复制到目标项目根目录，或从 `references/` 复制需要的模板。
3. 根据项目实际情况修改 `AGENTS.md`、`docs/thread-operating-model.md`、`docs/project-brief.md`、`docs/roadmap.md`、`docs/status.md` 和 `docs/thread-registry.md`。
4. 日常开发、派单、回传、交接和状态维护，应依赖项目本地文档，而不是反复调用 skill。
5. 进行跨线程派单时，先按任务难度选择模型层级，再选择具体模型版本，并记录请求模型、实际模型、配额池、降级原因和选择理由。
6. 对文档膨胀、过期队列、已处理 Return Packet 和关闭任务行，使用 LV2 docs-only 压缩，并在需要重写活跃文档前获取 `docs/.locks/context-compaction.lock`。

## 上下文治理

这个 skill 特别强调控制文档膨胀：

- 活跃文档应该是当前快照，不是追加式日志。
- `handoff.md`、`status.md`、`thread-registry.md` 和 `roadmap.md` 要保持紧凑。
- 过期、已处理、已关闭、被替代或仅用于历史追溯的内容，应移动到 `docs/archive/` 或 `docs/thread-runs/archive/`。
- 新线程默认不读取 archive，除非任务需要审计、历史调查、回归分析或上下文压缩。
- 当文档出现重复、冲突、过期、难以定位信息时，应先执行压缩检查。
- 只有在 LV2 安全前提满足时，Agent 才能自主执行 docs-only 整理。
- LV2 可整理活跃文档快照、历史归档、已处理 Return Packet、关闭或被替代的任务行、compaction note 和 registry 中的队列/锁/上下文卫生字段。
- LV2 不允许整理源码、测试、生产配置、schema/migration、ADR 决策内容、产品方向、模块归属、roadmap 优先级或 public contract。
- 如果存在 active lock、stale lock、范围不清、任务仍活跃或安全前提不满足，应创建 compaction request / Return Packet，让主线程或用户决定。

## 多 Agent 兼容

项目骨架包含 `CLAUDE.md`，默认内容为：

```md
@AGENTS.md
```

这样 Claude Code 可以共享 Codex 使用的 `AGENTS.md`、`docs/thread-operating-model.md` 和 `docs/thread-registry.md`，避免不同工具各自维护规则而发生漂移。

## 本地化规则

- 面向人的生成内容应遵循用户语言、项目语言、仓库现有语言或当前会话语言。
- 开源或公共开发者文档默认使用英文，但可以维护中文版本。
- 代码标识符、文件路径、命令、API 字段、配置字段、错误、日志、模型名、配额池名和稳定模板字段应保留英文或原始形式。

## 安装

见 [`INSTALL.zh-CN.md`](INSTALL.zh-CN.md)。

英文说明见 [`README.md`](README.md)。

## 许可证

MIT License。见 [`LICENSE`](LICENSE)。
