#!/bin/bash
# Extract a markdown transcript from a shadow PDF into a sibling transcript.md.
# Mechanical extraction only (pymupdf4llm): deterministic given the pinned
# version, never agent-retyped. Escalation path for scanned/math-heavy PDFs:
# marker or docling, decided per paper when the need appears.
# Requires: python3 with pymupdf4llm (the dev container provides the pinned
# version — run via ./dev.sh); the private shadow/ checkout.
set -euo pipefail

SHADOW="$(cd "$(dirname "$0")/.." && pwd)/shadow"
[ -d "$SHADOW" ] || { echo "no shadow/ checkout — transcripts live in the private data repo" >&2; exit 1; }

# usage: transcribe.sh library/papers/<year>/<citekey>/<citekey>.pdf
rel="${1:?usage: transcribe.sh <shadow-relative pdf path>}"
src="$SHADOW/$rel"
dst="$SHADOW/$(dirname "$rel")/transcript.md"
mkdir -p "$(dirname "$dst")"
python3 - "$src" "$dst" <<'PY'
import pathlib, sys
import pymupdf4llm
pathlib.Path(sys.argv[2]).write_text(pymupdf4llm.to_markdown(sys.argv[1]))
PY
echo "wrote $dst"
