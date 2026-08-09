#!/bin/bash
# Leak guard shared by pre-commit (staged) and pre-push (outgoing range).
# Machine-checkable classes only — secrets (gitleaks) and structure (shadow
# escapes, document blobs, oversized files). Private/personal context is
# judgment, not scannable: see the review rule in AGENTS.md.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

MAX_BYTES=100000
BLOCKED_EXT='\.(pdf|epub|mobi|djvu)$'

fail() { echo "leak guard: $*" >&2; exit 1; }

check_blobs() {  # stdin: "<size><TAB><path>" per file
  while IFS=$'\t' read -r size path; do
    [ -n "$path" ] || continue
    case "$path" in
      shadow/*) fail "path inside shadow/: $path" ;;
    esac
    if printf '%s' "$path" | grep -qiE "$BLOCKED_EXT"; then
      fail "document blob does not belong in git: $path"
    fi
    if [ "$size" -gt "$MAX_BYTES" ]; then
      case "$path" in
        # Machine-generated, textual, required for reproducible npm ci.
        *package-lock.json) ;;
        # Survey records and bibliographies: textual, load-bearing,
        # legitimately catalog-sized (dse catalog 204KB, bib 141KB).
        surveys/*/record/*.tsv|surveys/*/manuscript/references*.bib) ;;
        *) fail "file over $((MAX_BYTES / 1000))KB: $path ($size bytes) — if truly intentional, raise MAX_BYTES here consciously" ;;
      esac
    fi
  done
}

case "${1:-}" in
  staged)
    git show :.gitignore 2>/dev/null | grep -qx '/shadow/' \
      || fail ".gitignore lost its /shadow/ line"
    git diff --cached --name-only --diff-filter=AM -z \
      | while IFS= read -r -d '' p; do
          printf '%s\t%s\n' "$(git cat-file -s ":0:$p")" "$p"
        done | check_blobs
    gitleaks git --staged --no-banner --redact --exit-code 1 >/dev/null 2>&1 \
      || fail "gitleaks found a secret in the staged diff (run: gitleaks git --staged)"
    ;;
  range)  # check.sh range <remote-sha> <local-sha>
    base="${2:?}" tip="${3:?}"
    zeros=0000000000000000000000000000000000000000
    if [ "$base" = "$zeros" ]; then range="$tip"; else range="$base..$tip"; fi
    git show "$tip:.gitignore" 2>/dev/null | grep -qx '/shadow/' \
      || fail ".gitignore at push tip lost its /shadow/ line"
    git rev-list --objects "$range" \
      | git cat-file --batch-check='%(objecttype)%09%(objectsize)%09%(rest)' \
      | awk -F'\t' '$1 == "blob" { print $2 "\t" $3 }' | check_blobs
    gitleaks git --no-banner --redact --exit-code 1 --log-opts="$range" >/dev/null 2>&1 \
      || fail "gitleaks found a secret in the outgoing range $range"
    ;;
  *)
    echo "usage: check.sh staged | range <remote-sha> <local-sha>" >&2
    exit 2
    ;;
esac
