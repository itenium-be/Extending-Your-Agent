# Recovery — lost commits, bad resets, detached HEAD

Git almost never deletes commits immediately; they linger in the reflog until
garbage collection. The reflog is the recovery tool.

## Find what was lost

```bash
git reflog                 # every HEAD position, newest first
git reflog show <branch>   # movements of a specific branch
```

Each line has a SHA. That SHA is your way back.

## Undo a `reset --hard`

The commit you reset away from is the reflog entry just before the reset.

```bash
git reset --hard HEAD@{1}   # back to where HEAD was one move ago
# or target the SHA directly:
git reset --hard <sha>
```

## Recover a deleted branch

```bash
git reflog                       # find the tip SHA of the gone branch
git branch <name> <sha>          # recreate it pointing at that commit
```

## Leave a detached HEAD without losing work

A detached HEAD means commits you make aren't on any branch — they're easy to
lose. Anchor them with a branch:

```bash
git switch -c <new-branch>       # keeps the current commit, now on a branch
```

If you already moved away and lost the SHA, find it in `git reflog` and either
branch from it or `git cherry-pick <sha>`.

## Restore a deleted file (committed earlier)

```bash
git restore --source=<sha> -- path/to/file
```
