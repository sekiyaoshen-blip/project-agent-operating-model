#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-project-agent-operating-model}"
OWNER="${GITHUB_OWNER:-sekiyaoshen-blip}"
DESCRIPTION="Bootstrap, audit, repair, compact, and upgrade project-local operating rules for long-running agent-assisted projects."

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is required. Install it and authenticate with: gh auth login" >&2
  exit 1
fi

if [ ! -d .git ]; then
  git init
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "Initial open-source release of Project Agent Operating Model"
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$OWNER/$REPO_NAME" --public --description "$DESCRIPTION" --source=. --remote=origin --push
else
  git push -u origin HEAD
fi

echo "Published to: https://github.com/$OWNER/$REPO_NAME"
