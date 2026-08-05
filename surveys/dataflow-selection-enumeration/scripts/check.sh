#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly repo_dir
cd "${repo_dir}"

git diff --check

expected_header=$'citekey\tyear\tcluster\tstatus\tpriority\tvenue\tprimary_url\trelevance\texclusion_reason'
actual_header="$(head -n 1 research/survey/catalog.tsv)"
if [[ "${actual_header}" != "${expected_header}" ]]; then
  printf 'Unexpected research/survey/catalog.tsv header\n' >&2
  exit 1
fi

awk -F '\t' '
  NR == 1 { next }
  NF != 9 { printf "catalog row %d has %d fields, expected 9\n", NR, NF; failed = 1 }
  $4 !~ /^(candidate|screened|deep-read|excluded)$/ {
    printf "catalog row %d has invalid status: %s\n", NR, $4; failed = 1
  }
  seen[$1]++ { printf "duplicate citekey on catalog row %d: %s\n", NR, $1; failed = 1 }
  END { exit failed }
' research/survey/catalog.tsv

expected_search_header=$'date\tround_id\tphase\tsource\texact_query_or_seed\tdirection\thits\tscreened\tincluded_keys\texcluded_keys\tnotes'
actual_search_header="$(head -n 1 research/survey/search-log.tsv)"
if [[ "${actual_search_header}" != "${expected_search_header}" ]]; then
  printf 'Unexpected research/survey/search-log.tsv header\n' >&2
  exit 1
fi

awk -F '\t' '
  NR == 1 { next }
  NF != 11 { printf "search-log row %d has %d fields, expected 11\n", NR, NF; failed = 1 }
  $3 !~ /^(database-search|backward-snowballing|forward-snowballing|audit)$/ {
    printf "search-log row %d has invalid phase: %s\n", NR, $3; failed = 1
  }
  $6 !~ /^(query|backward|forward|audit)$/ {
    printf "search-log row %d has invalid direction: %s\n", NR, $6; failed = 1
  }
  $7 !~ /^[0-9]+$/ { printf "search-log row %d has nonnumeric hits: %s\n", NR, $7; failed = 1 }
  $8 !~ /^[0-9]+$/ { printf "search-log row %d has nonnumeric screened count: %s\n", NR, $8; failed = 1 }
  END { exit failed }
' research/survey/search-log.tsv

expected_exploratory_header=$'date\tdiscovery_source\tquery_or_method\tresults_screened\tworks_added\tnotes'
actual_exploratory_header="$(head -n 1 research/survey/exploratory-search-log.tsv)"
if [[ "${actual_exploratory_header}" != "${expected_exploratory_header}" ]]; then
  printf 'Unexpected research/survey/exploratory-search-log.tsv header\n' >&2
  exit 1
fi

python3 -m py_compile scripts/*.py
python3 scripts/check-survey.py
python3 - <<'PY'
from pathlib import Path

import yaml

citation = yaml.safe_load(Path("CITATION.cff").read_text(encoding="utf-8"))
assert citation["cff-version"] == "1.2.0"
assert citation["title"] == (
    "Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs"
)
assert citation["authors"] == [{"name": "Codex GPT-5.6 Sol"}]
assert "version" not in citation
assert "date-released" not in citation
assert citation["url"] == (
    "https://qobilidop.github.io/dataflow-selection-enumeration/"
)
assert citation["preferred-citation"]["type"] == "unpublished"
assert Path("LICENSE").stat().st_size > 0
PY

if command -v shellcheck >/dev/null; then
  shellcheck dev.sh scripts/*.sh
fi

if [[ -f manuscript/main.typ ]]; then
  mkdir -p build
  typst compile \
    --root . \
    --creation-timestamp 1785801600 \
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
  if [[ "${pdf_author}" != "Codex GPT-5.6 Sol" ]]; then
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
