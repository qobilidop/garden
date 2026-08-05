#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly repo_dir
cd "${repo_dir}"

python3 -m compileall -q scripts
python3 scripts/survey/check.py
python3 - <<'PY'
from pathlib import Path

import yaml

citation = yaml.safe_load(Path("CITATION.cff").read_text(encoding="utf-8"))
assert citation["cff-version"] == "1.2.0"
assert citation["title"] == (
    "Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs"
)
assert citation["authors"] == [
    {
        "affiliation": "Independent researcher",
        "family-names": "Dong",
        "given-names": "Bili",
    }
]
assert "version" not in citation
assert "date-released" not in citation
assert citation["url"] == (
    "https://qobilidop.github.io/dataflow-selection-enumeration/"
)
assert citation["preferred-citation"]["type"] == "unpublished"
assert Path("LICENSE").stat().st_size > 0
for workflow in sorted(Path(".github/workflows").glob("*.yml")):
    assert isinstance(yaml.safe_load(workflow.read_text(encoding="utf-8")), dict)
PY

if command -v shellcheck >/dev/null; then
  shellcheck dev.sh scripts/*.sh
fi

if [[ -f manuscript/main.typ ]]; then
  mkdir -p build
  typst compile \
    --root . \
    --creation-timestamp 1785913200 \
    --pdf-standard a-2b \
    --no-pdf-tags \
    manuscript/main.typ \
    build/manuscript.pdf
  pdftotext build/manuscript.pdf build/manuscript.txt \
    2>build/pdf-text.stderr
  if [[ -s build/pdf-text.stderr ]]; then
    printf 'PDF text-extraction diagnostics were emitted:\n' >&2
    cat build/pdf-text.stderr >&2
    exit 1
  fi
  test -s build/manuscript.txt

  pdfinfo build/manuscript.pdf \
    >build/pdfinfo.txt \
    2>build/pdf-metadata.stderr
  if [[ -s build/pdf-metadata.stderr ]]; then
    printf 'PDF metadata diagnostics were emitted:\n' >&2
    cat build/pdf-metadata.stderr >&2
    exit 1
  fi

  pdf_author="$(sed -n 's/^Author:[[:space:]]*//p' build/pdfinfo.txt)"
  if [[ "${pdf_author}" != "Bili Dong" ]]; then
    printf 'Unexpected PDF author metadata: %s\n' "${pdf_author}" >&2
    exit 1
  fi

  pdfinfo -struct-text build/manuscript.pdf \
    >/dev/null \
    2>build/pdf-structure.stderr
  if [[ -s build/pdf-structure.stderr ]]; then
    printf 'PDF structure diagnostics were emitted:\n' >&2
    cat build/pdf-structure.stderr >&2
    exit 1
  fi
fi
