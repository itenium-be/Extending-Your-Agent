#!/usr/bin/env bash
# Tests for validate-json.sh. Run: bash plugin-tutorial/hooks/validate-json.test.sh
set -uo pipefail
HERE=$(cd -- "$(dirname -- "$0")" && pwd)
SCRIPT="$HERE/validate-json.sh"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
pass=0; fail=0
check(){ if [ "$2" = "$3" ]; then echo "  ok: $1"; pass=$((pass+1)); else echo "  FAIL: $1 — want [$3] got [$2]"; fail=$((fail+1)); fi; }

# Build a PostToolUse hook event for a given file path
event(){ jq -n --arg f "$1" '{tool_input:{file_path:$f}}'; }

# 1. valid-but-ugly JSON → reformatted to 2-space, key order preserved, final newline
f="$tmp/ugly.json"; printf '{"b":2,"a":[1,2]}' > "$f"
event "$f" | bash "$SCRIPT"; rc=$?
check "valid json exits 0" "$rc" "0"
check "reformatted 2-space" "$(cat "$f")" "$(printf '{\n  "b": 2,\n  "a": [\n    1,\n    2\n  ]\n}')"
check "ends with newline" "$(tail -c1 "$f" | od -An -c | tr -d ' ')" '\n'

# 2. invalid JSON → exit 2, file left untouched
f="$tmp/bad.json"; printf '{"a":}' > "$f"; before=$(cat "$f")
event "$f" | bash "$SCRIPT" 2>/dev/null; rc=$?
check "invalid json exits 2" "$rc" "2"
check "invalid json untouched" "$(cat "$f")" "$before"

# 3. non-JSON file → ignored (exit 0, untouched)
f="$tmp/notes.txt"; printf 'hi' > "$f"
event "$f" | bash "$SCRIPT"; rc=$?
check "non-json exits 0" "$rc" "0"
check "non-json untouched" "$(cat "$f")" "hi"

# 4. empty JSON file → ignored, left empty (no fabricated newline)
f="$tmp/empty.json"; : > "$f"
event "$f" | bash "$SCRIPT"; rc=$?
check "empty json exits 0" "$rc" "0"
check "empty json stays empty" "$(wc -c < "$f" | tr -d ' ')" "0"

# 5. JSONC (comment lines) → skipped untouched, comments preserved
f="$tmp/conf.json"; printf '{\n  // keep me\n  "a": 1\n}\n' > "$f"; before=$(cat "$f")
event "$f" | bash "$SCRIPT"; rc=$?
check "jsonc exits 0" "$rc" "0"
check "jsonc untouched" "$(cat "$f")" "$before"

echo "passed=$pass failed=$fail"
[ "$fail" -eq 0 ]
