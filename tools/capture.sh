#!/usr/bin/env bash
# capture.sh — mechanical tier of library ingestion: fetch a URL, find or
# create a verified Wayback record, and report the outcome as JSON.
set -u

usage() { cat <<'EOF'
Usage: tools/capture.sh --blob|--page [--retrieved YYYY-MM-DD] [--no-spn] <url> <dest-file>

Fetches <url> to <dest-file> (an existing file is kept, not refetched),
then works the archive ladder:

  1. Check Wayback availability for <url>.
  2. Verify the closest snapshot's id_ record against <dest-file>,
     decompressing gzipped records first: --blob compares bytes;
     --page compares tag-stripped, whitespace-collapsed text.
  3. --page only: a snapshot older than --retrieved (default: today,
     UTC) is accepted only if step 2 verified it.
  4. If no acceptable record and SPN is allowed: trigger
     https://web.archive.org/save/<url> (90s budget), then re-run 1-2.

Modes:
  --blob   immutable URL (pinned revision, versioned arXiv/PDF):
           any verified snapshot suffices, age irrelevant
  --page   mutable page: record must be fresh or content-verified

Output: one JSON object on stdout:
  {url, dest, sha256, archived, snapshot_ts, verified, fresh, spn}
  verified: "bytes"|"text"|"none"   spn: "skipped"|"ok"|"failed"
Diagnostics go to stderr.

Exit codes:
  0  usable archive record (verified, or fresh via SPN)
  2  captured, but no verified/fresh record — frontmatter needs a
     deviation comment or a later retry
  1  usage or fetch error

Examples:
  tools/capture.sh --blob https://arxiv.org/pdf/2310.00001v2 paper.pdf
  tools/capture.sh --page --retrieved 2026-08-08 https://example.com/post out.html
EOF
}

MODE= RETRIEVED= SPN=1 URL= DEST=
while [ $# -gt 0 ]; do
  case "$1" in
    --blob) MODE=blob ;;
    --page) MODE=page ;;
    --retrieved) shift; RETRIEVED="${1:-}" ;;
    --no-spn) SPN=0 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "Error: unknown flag $1 (see --help)" >&2; exit 1 ;;
    *) if [ -z "$URL" ]; then URL=$1; elif [ -z "$DEST" ]; then DEST=$1
       else echo "Error: unexpected argument $1 (see --help)" >&2; exit 1; fi ;;
  esac
  shift
done
[ -n "$MODE" ] && [ -n "$URL" ] && [ -n "$DEST" ] || { echo "Error: need --blob|--page, <url>, <dest-file> (see --help)" >&2; exit 1; }
RETRIEVED=${RETRIEVED:-$(date -u +%Y-%m-%d)}
case "$RETRIEVED" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;; *) echo "Error: --retrieved must be YYYY-MM-DD, got: $RETRIEVED" >&2; exit 1 ;; esac

if [ -s "$DEST" ]; then
  echo "note: $DEST exists, keeping it (pass a fresh path to refetch)" >&2
else
  echo "fetching $URL" >&2
  curl -sSL --max-time 120 "$URL" -o "$DEST" || { echo "Error: fetch failed for $URL" >&2; exit 1; }
  [ -s "$DEST" ] || { echo "Error: fetch produced an empty file" >&2; rm -f "$DEST"; exit 1; }
fi
SHA=$(shasum -a 256 "$DEST" | cut -d' ' -f1)

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

check_and_verify() {  # sets ARCHIVED, TS, VERIFIED, FRESH
  ARCHIVED= TS= VERIFIED=none FRESH=false
  curl -sS --max-time 30 "https://archive.org/wayback/available?url=$URL" -o "$TMP/avail.json" || return
  read -r ARCHIVED TS < <(python3 -c "
import json,sys
try: s=json.load(open('$TMP/avail.json'))['archived_snapshots']['closest']
except Exception: sys.exit(0)
if s.get('available'): print(s['url'].replace('http://','https://'), s['timestamp'])" ) || true
  [ -n "${ARCHIVED:-}" ] || return
  [ "${TS:0:8}" -ge "$(echo "$RETRIEVED" | tr -d -)" ] 2>/dev/null && FRESH=true
  local idurl="https://web.archive.org/web/${TS}id_/$URL"
  echo "verifying $idurl" >&2
  curl -sS --max-time 45 "$idurl" -o "$TMP/record" || return
  VERIFIED=$(python3 - "$MODE" "$DEST" "$TMP/record" <<'PY'
import gzip, html, re, sys
mode, dest, record = sys.argv[1:4]
d = open(dest,'rb').read()
r = open(record,'rb').read()
if r[:2] == b'\x1f\x8b':
    try: r = gzip.decompress(r)
    except OSError: pass
if d == r: print("bytes"); sys.exit()
if mode == "page":
    def text(b):
        # Compare the content region, not page chrome (relative timestamps,
        # counters drift between snapshots): prefer <article> when present.
        arts = re.findall(rb'<article[^>]*>.*?</article>', b, flags=re.S|re.I)
        if arts: b = b' '.join(arts)
        t = re.sub(rb'<(script|style)[^>]*>.*?</\1>', b' ', b, flags=re.S|re.I)
        t = re.sub(rb'<[^>]+>', b' ', t)
        return re.sub(r'\s+', ' ', html.unescape(t.decode('utf-8','replace'))).strip()
    if text(d) and text(d) == text(r): print("text"); sys.exit()
print("none")
PY
)
}

acceptable() {
  [ "$VERIFIED" != none ] && return 0
  [ "$MODE" = page ] && [ "$FRESH" = true ] && return 0
  return 1
}

check_and_verify
SPN_STATUS=skipped
if ! acceptable && [ "$SPN" = 1 ]; then
  echo "no usable record; triggering SPN (90s budget)" >&2
  if curl -sS --max-time 90 -o /dev/null "https://web.archive.org/save/$URL"; then SPN_STATUS=ok; else SPN_STATUS=failed; fi
  sleep 5
  check_and_verify
fi

python3 - "$URL" "$DEST" "$SHA" "${ARCHIVED:-}" "${TS:-}" "$VERIFIED" "$FRESH" "$SPN_STATUS" <<'PY'
import json, sys
u,d,s,a,t,v,f,p = sys.argv[1:9]
print(json.dumps({"url":u,"dest":d,"sha256":s,"archived":a or None,
  "snapshot_ts":t or None,"verified":v,"fresh":f=="true","spn":p}, indent=1))
PY
acceptable && exit 0 || exit 2
