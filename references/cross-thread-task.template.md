# Cross-Thread Task

- Source thread:
- Target thread / module:
- Request type: implement | investigate | review | verify | unblock | decide


## Model Routing

- Model tier:
  - fast | standard | high-reasoning | specialized
- Model version policy:
  - latest-available | pinned | quota-optimized | fallback
- Requested model / mode:
  - <project-configured model id or native UI selection>
- Requested model version:
  - <latest available by default, or explicit version>
- Preferred quota pool:
  - gpt-5.5 | gpt-5.3-codex-spark | shared | unknown | <project-defined>
- Spark preference:
  - use `gpt-5.3-codex-spark` when suitable for fast/low-risk work and independent quota helps; otherwise not applicable
- Fallback model / mode:
  - <fallback if requested model is unavailable>
- Model selection reason:
  - <why this tier/version/quota pool is appropriate>
- Escalation trigger:
  - <when to switch to a stronger model or newer version>

## Background

- Background information:
- Why this task is needed now:

## Why This Belongs To Target Module

- Why this task belongs to the target module:

## Desired Outcome

- Desired result:

## Acceptance Criteria

- [ ] Acceptance criterion 1:
- [ ] Acceptance criterion 2:

## Relevant Files / Docs

- `path/to/file`
- `docs/...`

## Inputs From Source Module

- Inputs, context, interfaces, or constraints provided by the source module:

## Expected Outputs

- Code, docs, verification results, or decisions expected from the target module:

## Sync Back To

- Source module handoff:
  - `docs/modules/<source-module>/handoff.md`
- Target module status:
  - `docs/modules/<target-module>/status.md`
- Target module handoff:
  - `docs/modules/<target-module>/handoff.md`
- Roadmap or ADR, if needed:
  - `docs/roadmap.md`
  - `docs/decisions/ADR-XXXX-title.md`

## Constraints

- Constraints:

## Priority / Deadline

- Priority:
- Deadline, if any:
