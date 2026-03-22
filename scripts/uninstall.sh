#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dst="$HOME/.claude/skills"

if [ $# -eq 0 ]; then
  echo "Usage: ./scripts/uninstall.sh <project-name> [project-name ...]"
  exit 1
fi

for project in "$@"; do
  src=$(find "$root" -maxdepth 1 -type d -name "neat_util_$project" 2>/dev/null | head -1)
  if [ -z "$src" ] || [ ! -f "$src/SKILL.md" ]; then
    echo "ERROR: no project matching neat_util_$project found" >&2
    continue
  fi
  name=$(grep '^name:' "$src/SKILL.md" | head -1 | sed 's/^name: *//')
  if [ -z "$name" ]; then
    echo "ERROR: no name in neat_util_$project/SKILL.md frontmatter" >&2
    continue
  fi
  if [ -L "$dst/$name" ] && [ "$(readlink "$dst/$name")" = "$src" ]; then
    rm "$dst/$name" && echo "INFO: $name uninstalled"
  elif [ -e "$dst/$name" ] || [ -L "$dst/$name" ]; then
    echo "WARN: $name exists but was not installed by this project — skipping"
  else
    echo "INFO: $name not installed — skipping"
  fi
done
