#!/bin/sh
# After a switch, from a fresh login shell: tools resolve from the Nix store,
# gitleaks sits at the CI pin, both agent-config sync tools report in sync.
# The tool list is a representative subset of home.nix (the ones Homebrew
# once shadowed), not a second copy of it.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
garden="$(cd "$here/../.." && pwd)"
fail() { echo "verify: $*" >&2; exit 1; }

for tool in git gitleaks python3 typst cmake nixfmt; do
  path="$(command -v "$tool" 2>/dev/null)" || fail "$tool not on PATH"
  case "$(readlink -f "$path")" in
    /nix/store/*) ;;
    *) fail "$tool resolves outside the Nix store: $path" ;;
  esac
done

if [ "$(uname -s)" = Linux ]; then
  shell="$(getent passwd "$(id -un)" | cut -d: -f7)"
  case "$(readlink -f "$shell")" in
    /nix/store/*zsh*) ;;
    *) fail "login shell is $shell, not the Nix zsh" ;;
  esac
fi

pin="$(sed -n 's/^ *GITLEAKS_VERSION: *//p' "$garden/.github/workflows/gitleaks.yml")"
have="$(gitleaks version)"
[ "$have" = "$pin" ] || fail "gitleaks $have, CI pins $pin"

python3 -c 'import tomllib' || fail "python3 lacks tomllib (needs 3.11+)"

# Ghostty's config is written by home.nix but not validated by it (the
# module validates only a Nix-built package); the installed app validates.
ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"
command -v ghostty >/dev/null 2>&1 && ghostty="$(command -v ghostty)"
if [ -x "$ghostty" ]; then
  "$ghostty" +validate-config >/dev/null || fail "ghostty config invalid (ghostty +validate-config)"
fi
"$garden/config/claude/sync.sh" diff >/dev/null || fail "config/claude out of sync"
"$garden/config/codex/sync.sh" diff >/dev/null || fail "config/codex out of sync"
echo "verify: ok"
