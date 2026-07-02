# Project Agent Instructions

This project uses the `project-agent-operating-model` operating model.

## Project Language

- Project language: auto
- Use the explicit user/project language when one is set.
- Otherwise follow the existing repo/docs language, then the user interface / system locale / current conversation language when available.
- Use English as the fallback for open-source or public developer-facing artifacts.
- Keep file paths, commands, code identifiers, API/schema/config fields, errors, logs, test names, package/framework/protocol names, model names, quota-pool names, and stable template fields in English or original form.

## Always Follow

- Treat repo/workspace project-state docs as the source of truth, not chat history.
- Do not call `$project-agent-operating-model` for routine tasks unless the project needs initialization, restructuring, repair, or an operating-model upgrade.
- The main thread owns roadmap, module boundaries, priorities, cross-module decisions, active dispatch, Return Packet review, and recovery sweep.
- Module threads own implementation, debugging, verification, `status.md`, `handoff.md`, and `runbook.md` for their module.
- When a child/module thread completes, blocks, or needs a decision, write a Return Packet to `docs/thread-runs/inbox/main/`; do not treat direct interruption of the main thread as the stable return path.
- Every cross-thread dispatch must have a `docs/thread-runs/<task-id>.md` record.
- For cross-thread dispatch, choose Model Tier by task difficulty, risk, context size, and purpose; then choose Model Version. Default to the latest available compatible model version for the selected tier. For suitable fast or low-risk work, prefer the independent quota pool of `gpt-5.3-codex-spark` / GPT-5.3-SPARK when available. Record requested/actual model/version, quota pool, fallback, and selection reason in the dispatch queue and thread-run record.
- Long tasks must maintain Checkpoints and a Resume Prompt.
- Never write secrets, tokens, credentials, private customer data, signed URLs, or access-granting links into committed docs.
- Active project-state docs are current snapshots, not append-only logs.
- Each fact should have one primary home; link to the primary home instead of duplicating full content.
- Keep active docs compact. Move stale, historical, or processed material to `docs/archive/` or `docs/thread-runs/archive/`.
- Do not read archives, all module runbooks, or all thread-runs by default.
- Trigger a context compaction sweep when docs become stale, contradictory, oversized, or confusing.
- Use LV2 controlled autonomous compaction: agents may execute docs-only compaction when LV2 preconditions are met, but must create a request instead when scope, ownership, or safety is unclear.
- Broad context compaction must acquire `docs/.locks/context-compaction.lock` first; locks apply across different agent tools and across different threads/sessions inside the same tool.
- Check for compaction at thread startup, before large dispatch batches, after Return Packet review, after task closure, after milestone closure, and whenever active docs exceed budget or contradict each other.

## Read When Relevant

- Detailed thread operating rules: `docs/thread-operating-model.md`
- Thread registry, task queue, and Return Inbox: `docs/thread-registry.md`
- Current roadmap: `docs/roadmap.md`
- Current global status: `docs/status.md`
- Module status: `docs/modules/<module>/status.md`
- Module handoff: `docs/modules/<module>/handoff.md`
- Module recovery notes: `docs/modules/<module>/runbook.md`
- Architecture / contract decisions: `docs/decisions/`
- Cross-thread task records: `docs/thread-runs/`
- Historical archive, only when needed: `docs/archive/`
- Active locks, before broad rewrites or compaction: `docs/.locks/`

## Runtime Summary

- Use native Codex Desktop thread tools for visibility.
- Use project-state task records for reliability.
- Use Checkpoints for quota-limit or runtime interruption recovery.
- Use Return Inbox for ordered result handling.
- Use Model Routing so low-risk tasks can use lighter or independent-quota models while high-risk, cross-module, contract, or deep-reasoning tasks use the latest available strong reasoning model.
- The main thread consumes queued results instead of being interrupted by child-thread callbacks.
- Use compaction locks so Codex, Claude Code, other agents, automations, and humans do not rewrite shared active docs at the same time.

## Context Hygiene

- Treat `status.md`, `handoff.md`, `roadmap.md`, and `thread-registry.md` as current snapshots.
- Do not append routine task logs to active docs.
- Keep `handoff.md` compact and main-thread relevant; move local details to runbook or archive.
- Keep `runbook.md` focused on current recovery context and active findings; archive old dated history.
- Close or archive completed dispatch queue rows and processed Return Packets.
- Use `docs/archive/compactions/YYYY-MM-DD-context-compaction.md` to record compaction sweeps.
- Use `docs/.locks/context-compaction.lock` during LV2 compaction and release it after the compaction note and active-doc updates are complete.

## Documentation Updates

Update project-state docs only when there is a substantive state change.

- Update `status.md`: current state, scope, risks, tasks, or verification changed.
- Update `handoff.md`: main-thread-relevant behavior, contracts, risks, decisions, verification, or milestone progress changed.
- Update `runbook.md`: useful implementation attempts, debugging findings, local decisions, recovery points, or continuation context changed.
- Update `roadmap.md`: scope, priority, dependencies, milestones, or ownership changed.
- Create/update ADRs: cross-module, shared contract, architecture, deployment, security, cost, or product-scope decisions changed.
- Do not force doc updates for purely informational chats, clarifications with no state change, or no-op investigations.
