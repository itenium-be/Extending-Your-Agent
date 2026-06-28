#!/usr/bin/env bash
# Read-only snapshot of git state, used to route to the right recipe.
# Runs no mutating git commands.
set -uo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository."
  exit 0
fi

echo "== BRANCH =="
if head=$(git symbolic-ref --quiet --short HEAD 2>/dev/null); then
  echo "on branch: $head"
else
  # Detached HEAD is the classic "where did my commits go" trigger.
  echo "DETACHED HEAD at $(git rev-parse --short HEAD 2>/dev/null)"
fi

echo
echo "== UPSTREAM (behind / ahead) =="
if up=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
  counts=$(git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)
  echo "upstream: $up   (behind ahead): $counts"
else
  echo "no upstream tracking branch"
fi

echo
echo "== STATUS (short) =="
git status --short || true

echo
echo "== RECENT REFLOG (last 15) =="
# The reflog is how lost commits get found again.
git reflog --max-count=15 || true

echo
echo "== STASHES =="
if [ -n "$(git stash list 2>/dev/null)" ]; then
  git stash list
else
  echo "(none)"
fi
