# <Module> Runbook

Last updated: YYYY-MM-DD

Use this file for long-lived module-thread memory and recovery. It is not a full transcript and should not become an append-only log.

## Purpose

- What this module owns.
- What this module does not own.

## Thread Identity

- Role:
- Native Thread Link:
- Session ID / Callable Ref:
- Started:
- Last Sync:
- Replaces:

## Current Recovery Context

Keep this section short enough for a future replacement thread to read quickly.

- Current problem being solved:
- Current implementation direction:
- Important constraints and assumptions:
- Most important continuation point:
- Last safe checkpoint:
- Safe to re-run:
- Do not repeat:

## Active Findings

Only keep findings that are still useful for future work.

### <Topic>

- Finding:
- Why it matters:
- Related files:
- Current status:

## Active Risks / Pending Questions

- Risk or question:
  - Who needs to decide:
  - What it blocks:
  - Next check:

## Local Decisions

- Decision:
  - Scope:
  - Why it remains module-local:
  - Promote to ADR if it affects other modules, shared contracts, deployment, security, cost, or product scope.

## Debug Notes

- Important reproduction steps, clues, temporary conclusions, or short error excerpts.
- Avoid pasting long logs; link files or summarize the signal.
- Redact secrets, tokens, emails, IDs, credentials, private URLs, and customer data.

## Adjacent / Cross-Module Notes

- Adjacent integration work performed:
- Owning module:
- Notification / follow-up:

## Archive Index

Move old dated history, abandoned attempts, accepted handoffs, and stale debug notes to archive.

- `docs/archive/modules/<module>/runbook-YYYY-QN.md`
- `docs/archive/modules/<module>/handoff-YYYY-QN.md`

## Runbook Compaction Rule

When this runbook grows too large:

1. Summarize old entries into 5-10 durable findings.
2. Move detailed history to `docs/archive/modules/<module>/`.
3. Promote cross-module decisions to ADRs.
4. Remove stale local notes from the active runbook.
5. Keep only current recovery context, active findings, active risks, and the archive index here.
