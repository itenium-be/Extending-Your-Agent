---
# Progressive Context Disclosure & Custom Scripts

name: git-recipes
description: Use when stuck on a git operation — recovering lost commits, undoing a bad reset, rebasing or squashing history, or finding which commit introduced a bug.
allowed-tools: Read, Bash(*repo-snapshot.sh)
---

Recover from a tricky git situation using focused, on-demand recipes.

## Steps

1. Snapshot the repo state (read-only):
   `bash ${CLAUDE_SKILL_DIR}/scripts/repo-snapshot.sh`
2. Match the snapshot against the table and `Read` the **one** matching reference file.
3. If the snapshot is ambiguous or several apply, ask the user via a multi-select
   (`AskUserQuestion`, `multiSelect: true`) which area(s) they need, then load those.
4. Follow the recipe. Run mutating commands only with the user's go-ahead.

## Routing

| Snapshot shows                                | Read                   |
|-----------------------------------------------|------------------------|
| detached HEAD, lost commit, `reset --hard`    | reference/recovery.md  |
| clean up / squash / reorder history           | reference/rebasing.md  |
| "something broke — which commit?"             | reference/bisect.md    |

Load a reference file only when its situation applies — that restraint is the point.
