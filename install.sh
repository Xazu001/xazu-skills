#!/usr/bin/env bash
# Installs all skills from ./skills/ into the Devin CLI global skills directory.
# Works on macOS, Linux and Windows (via Git Bash).
set -euo pipefail

cd "$(dirname "$0")"

# Global skills dir: %APPDATA%\devin\skills on Windows, ~/.config/devin/skills elsewhere
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    if [ -z "${APPDATA:-}" ]; then
      echo "error: APPDATA is not set" >&2
      exit 1
    fi
    BASE="$APPDATA/devin/skills"
    ;;
  *)
    BASE="${XDG_CONFIG_HOME:-$HOME/.config}/devin/skills"
    ;;
esac

mkdir -p "$BASE"

for dir in skills/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  mkdir -p "$BASE/$name"
  cp "$dir"SKILL.md "$BASE/$name/SKILL.md"
  echo "installed: $name -> $BASE/$name/SKILL.md"
done

echo "done. Invoke with /<skill-name> in Devin CLI."
