#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dst="$HOME/.claude/skills"
mkdir -p "$dst"

if [ $# -eq 0 ]; then
  echo "Usage: ./scripts/install.sh <project-name> [project-name ...]"
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
  [ -L "$dst/$name" ] && [ "$(readlink "$dst/$name")" = "$src" ] && echo "INFO: $name already installed - skipping" && continue
  [ -e "$dst/$name" ] && echo "WARN: $dst/$name already exists — skipping" && continue
  ln -s "$src" "$dst/$name" && echo "INFO: $name installed"
done
