# Rebasing — squash, reword, reorder, move history

Rebasing rewrites commits, so only do it on history you haven't shared (or have
agreed to force-push). When in doubt, branch first: `git switch -c backup`.

## Interactive rebase

```bash
git rebase -i HEAD~5        # edit the last 5 commits
git rebase -i <base-sha>    # edit everything after <base-sha>
```

In the editor, change the verb at the start of each line:

| Verb     | Effect                                         |
|----------|------------------------------------------------|
| `pick`   | keep as-is                                      |
| `reword` | keep the change, edit the message               |
| `squash` | fold into the previous commit, combine messages |
| `fixup`  | fold into the previous commit, drop its message |
| `drop`   | remove the commit entirely                       |

Reorder by moving lines up/down. Save and close to apply.

## Move a branch onto a new base

```bash
git rebase --onto <new-base> <old-base> <branch>
# e.g. replay feature commits onto main instead of develop:
git rebase --onto main develop feature
```

## When it goes wrong

```bash
git rebase --abort     # bail out, back to the pre-rebase state
git rebase --continue  # after resolving a conflict
git rebase --skip      # drop the conflicting commit and move on
```

## After rebasing a pushed branch

History diverged from the remote, so a normal push is rejected. Force, but safely:

```bash
git push --force-with-lease   # refuses if someone else pushed meanwhile
```
