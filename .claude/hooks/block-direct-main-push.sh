#!/usr/bin/env bash
# PreToolUse hook for Bash: blocks pushes that would land directly on main.
# Reads a JSON event from stdin; exits 2 with a stderr message to block.

set -euo pipefail

payload=$(cat)
cmd=$(printf '%s' "$payload" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null || true)

if [[ -z "$cmd" ]]; then
  exit 0
fi

# Only inspect git push commands.
if ! [[ "$cmd" =~ (^|[[:space:]])git[[:space:]]+push([[:space:]]|$) ]]; then
  exit 0
fi

# Resolve current branch.
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

block=0
reason=""

# Direct push to main from main branch.
if [[ "$branch" == "main" ]]; then
  block=1
  reason="You are on 'main'. The SDD workflow forbids direct pushes to main — open a PR from a feature branch instead."
fi

# Explicit push to main ref.
if [[ "$cmd" =~ git[[:space:]]+push[[:space:]]+[^[:space:]]+[[:space:]]+(HEAD:)?main([[:space:]]|$) ]]; then
  block=1
  reason="Refusing 'git push ... main' — direct pushes to main are blocked. Use a PR."
fi

# Force push anywhere is suspicious; require explicit human override.
if [[ "$cmd" =~ git[[:space:]]+push[[:space:]]+.*(--force([^-]|$)|(^|[[:space:]])-f([[:space:]]|$)) ]]; then
  block=1
  reason="Force pushes are blocked by the SDD scaffold. Re-run manually if you really mean it."
fi

if [[ "$block" -eq 1 ]]; then
  echo "[SDD hook] $reason" >&2
  exit 2
fi

exit 0
