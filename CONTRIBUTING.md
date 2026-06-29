# Contributing

Thanks for considering a contribution to Project Agent Operating Model.

## Guidelines

- Keep `SKILL.md` thin. Runtime rules should usually live in project docs or `references/` templates.
- Preserve the core principle: skill installs, `AGENTS.md` activates, project docs run.
- Keep public-facing docs in English by default, while preserving localization hooks for project-specific use.
- Keep code identifiers, paths, commands, APIs, schema fields, logs, model names, and stable template fields in English or original form.
- Avoid adding append-only project history to active templates. Prefer snapshot + archive patterns.

## Pull Request Checklist

- [ ] `SKILL.md` remains focused on bootstrap/audit/repair/upgrade work.
- [ ] Templates and project skeleton are consistent.
- [ ] Context governance rules are not duplicated across many files unless necessary.
- [ ] Markdown code fences are balanced.
- [ ] `MANIFEST.md` is regenerated if package contents changed.
