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

# Notebook notes are note-XXXX.md with four lowercase base-36 characters
# (notebook/AGENTS.md); anything else in the directory is a misnamed
# note or a stray file.
while IFS= read -r f; do
  echo "lint: notebook file outside note-XXXX.md: $f" >&2; status=1
done < <(git ls-files 'notebook/' \
         | grep -v -E '^notebook/(AGENTS|CLAUDE)\.md$' \
         | grep -v -E '^notebook/note-[0-9a-z]{4}\.md$')

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

# Skill descriptions are index keys sharing one silently-truncated
# budget (skills/create-skill/SKILL.md §Description); one that restates
# its body crowds every sibling. Cap each, on the whole tracked tree.
python3 - <<'PY' || status=1
import re, subprocess, sys
CAP = 400
files = subprocess.run(["git", "ls-files", "skills/*/SKILL.md"],
                       capture_output=True, text=True, check=True).stdout.split()
bad = 0
for f in files:
    m = re.match(r"---\n(.*?)\n---\n", open(f).read(), re.S)
    d = re.search(r"^description:[ \t]*(.*)$", m.group(1) if m else "", re.M)
    if not d or not d.group(1).strip():
        print(f"lint: skill description missing: {f}", file=sys.stderr); bad = 1; continue
    n = len(d.group(1).strip())
    if n > CAP:
        print(f"lint: skill description {n} > {CAP} chars: {f}", file=sys.stderr); bad = 1
sys.exit(bad)
PY

exit "$status"
