#!/bin/bash
# Convention lint — not a leak gate (that's check.sh). Machine-checkable
# content conventions only. Checks the whole tracked tree, not the staged
# diff, so violations cannot enter silently through merge commits: the
# next commit after a bad merge fails here.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

status=0

# Scratch notes require author: frontmatter (scratch/AGENTS.md) — an
# optional field would misattribute silently. Only dated note files;
# scratch/AGENTS.md and the CLAUDE.md shim are not notes.
while IFS= read -r f; do
  head -10 "$f" | grep -q '^author: ' \
    || { echo "lint: scratch note missing author: frontmatter: $f" >&2; status=1; }
done < <(git ls-files 'scratch/' \
         | grep -E '^scratch/[0-9]{4}/[0-9]{4}-[0-9]{2}-[0-9]{2}/[^/]+\.md$')

# The root flake follows config/nix's nixpkgs, but Nix never checks that the
# root lock's copy matches the host lock (config/nix/AGENTS.md); a stale copy
# evaluates silently against the old nixpkgs. Repair: `nix flake update host`.
python3 - <<'PY' || status=1
import json, sys
rev = lambda f: json.load(open(f))["nodes"]["nixpkgs"]["locked"]["rev"]
root, host = rev("flake.lock"), rev("config/nix/flake.lock")
if root != host:
    print(f"lint: flake.lock nixpkgs {root[:7]} != config/nix/flake.lock {host[:7]}; run: nix flake update host", file=sys.stderr)
    sys.exit(1)
PY

exit "$status"
