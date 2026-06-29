#!/usr/bin/env bash
# PostToolUse(Write|Edit) hook: validate & format JSON in place.
#
# Matchers key on tool NAME, not file extension, so this fires on every
# Write/Edit and gates on *.json itself. PostToolUse runs AFTER the write,
# so it formats in place rather than blocking. Exit 2 feeds stderr back to
# Claude so it sees (and fixes) invalid JSON.
set -uo pipefail

input=$(cat)
file=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')

# Only touch non-empty JSON files that actually exist on disk.
case "$file" in *.json) ;; *) exit 0 ;; esac
[ -s "$file" ] || exit 0

# Skip JSONC — config files with // or /* comment lines (tsconfig, vscode settings, …).
# jq can't parse them and reformatting would silently strip the comments. Match comment
# LINES only, so an "https://…" inside a string value doesn't trip this.
grep -qE '^[[:space:]]*(//|/\*)' "$file" && exit 0

# Validate.
if ! err=$(jq empty "$file" 2>&1); then
  echo "❌ Invalid JSON in $file:" >&2
  echo "$err" >&2
  exit 2
fi

# Indent from the nearest ancestor .editorconfig (default 2). jq already emits
# LF, a single trailing newline, and no trailing whitespace — the rest of the
# .editorconfig JSON rules come for free.
indent=2
dir=$(cd -- "$(dirname -- "$file")" && pwd)
while [ -n "$dir" ] && [ "$dir" != "/" ]; do
  if [ -f "$dir/.editorconfig" ]; then
    v=$(grep -iE '^[[:space:]]*indent_size[[:space:]]*=' "$dir/.editorconfig" | head -1 | grep -oE '[0-9]+' || true)
    [ -n "${v:-}" ] && indent=$v
    break
  fi
  dir=$(dirname -- "$dir")
done

# Format in place (command substitution strips jq's trailing newline; printf adds one back).
formatted=$(jq --indent "$indent" . "$file") || exit 0
printf '%s\n' "$formatted" > "$file"
