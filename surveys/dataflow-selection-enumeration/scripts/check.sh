#!/usr/bin/env bash

set -euo pipefail

readonly repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
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

if command -v shellcheck >/dev/null; then
  shellcheck dev.sh scripts/*.sh
fi

if [[ -f manuscript/main.tex ]]; then
  mkdir -p build
  latexmk -pdf -halt-on-error -interaction=nonstopmode \
    -output-directory=build manuscript/main.tex
fi
