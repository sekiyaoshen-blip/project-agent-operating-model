@AGENTS.md

## Claude Code

Follow the Project Agent Operating Model.

Use this file only as the Claude-specific entry point. Do not duplicate the full operating model here; update `AGENTS.md` or `docs/thread-operating-model.md` instead.

Before changing project-state docs:

- Read `docs/thread-operating-model.md` when the task involves dispatch, Return Inbox, checkpoint recovery, context compaction, archive cleanup, or multi-agent coordination.
- Check `docs/.locks/` for active locks.
- For broad active-doc cleanup, use LV2 docs-only compaction and acquire `docs/.locks/context-compaction.lock` first.
- Write Return Packets to `docs/thread-runs/inbox/main/` instead of interrupting the main thread as the stable return path.
- Keep active docs as current snapshots, not append-only logs.
