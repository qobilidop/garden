#!/bin/bash
# Extract a markdown transcript from a shadow PDF into a sibling transcript.md.
# Mechanical extraction only (pymupdf4llm): deterministic given the pinned
# version, never agent-retyped. Escalation path for scanned/math-heavy PDFs:
# marker or docling, decided per paper when the need appears.
# Requires: uv (from the repo flake shell), which runs the pymupdf4llm pinned
# in tools/uv.lock; the private shadow/ checkout.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SHADOW="$ROOT/shadow"
[ -d "$SHADOW" ] || { echo "no shadow/ checkout — transcripts live in the private data repo" >&2; exit 1; }

# usage: transcribe.sh library/papers/<year>/<citekey>/<citekey>.pdf
rel="${1:?usage: transcribe.sh <shadow-relative pdf path>}"
src="$SHADOW/$rel"
dst="$SHADOW/$(dirname "$rel")/transcript.md"
mkdir -p "$(dirname "$dst")"
uv run --project "$ROOT/tools" python - "$src" "$dst" <<'PY'
import pathlib, sys
import pymupdf4llm
pathlib.Path(sys.argv[2]).write_text(pymupdf4llm.to_markdown(sys.argv[1]))
PY
echo "wrote $dst"
