# Bisect — find the commit that introduced a bug

Binary search across history. You mark one known-good and one known-bad commit;
git checks out the midpoint repeatedly until it pinpoints the first bad commit.

## Manual

```bash
git bisect start
git bisect bad                 # current commit is broken
git bisect good <old-sha>      # this older commit worked

# git checks out a midpoint. Test it, then mark:
git bisect good                # this one is fine
git bisect bad                 # this one is broken
# ...repeat until git names the first bad commit...

git bisect reset               # ALWAYS finish with this — restores your HEAD
```

## Automated

If you can express "broken" as a command that exits non-zero, let git run it:

```bash
git bisect start HEAD <old-good-sha>
git bisect run ./test.sh       # or: npm test, dotnet test, etc.
git bisect reset
```

`git bisect run` walks the whole range unattended and prints the offending commit.

## Skip an untestable commit

```bash
git bisect skip                # e.g. it won't build for unrelated reasons
```

## Notes

- The good commit must be an ancestor of the bad one.
- With N commits in range, bisect needs about log2(N) tests.
- Don't forget `git bisect reset`, or you'll be left on a detached HEAD
  (see recovery.md).
