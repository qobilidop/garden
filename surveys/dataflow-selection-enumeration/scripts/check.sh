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

if command -v shellcheck >/dev/null; then
  shellcheck dev.sh scripts/*.sh
fi

if [[ -f manuscript/main.typ ]]; then
  mkdir -p build
  typst compile --root . manuscript/main.typ build/manuscript.pdf
  pdftotext build/manuscript.pdf build/manuscript.txt
  test -s build/manuscript.txt
fi
