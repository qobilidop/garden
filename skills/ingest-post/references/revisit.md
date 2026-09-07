# Revisiting an existing post

Open when the post is already in the library and the request is to
refresh, check, or update it.

Capture the live origin into a scratch directory and compare its prose
with the stored transcript:

```console
node tools/capture-post.mjs <url> <scratch-dir> <citekey> \
  --compare shadow/library/posts/<year>/<citekey>/transcript.md
```

The comparison diffs the work's prose as word tokens — frontmatter, image
references, link targets, and math excluded, since a rendered page
re-serializes formulas without the work changing — and saves the word diff
as `compare.diff` beside the candidate. Read the spans before deciding: an
unchanged work can still show a span or two of extraction noise. Keep the
candidate outside shadow and discard it after an unchanged comparison. If
the live capture fails, retain `retrieved` and the current artifacts; a
verified Wayback capture may be evaluated as a new candidate but is not
silently treated as the same source version.

- Unchanged work: retain the existing capture and transcript and make no
  garden or shadow commit. A health check is not a new evidence version.
- Material change: reconcile the synthesis against the fresh source,
  replace both artifacts in the same path, and commit the public notes and
  shadow update together. Shadow git history retains the prior evidence
  version.
- Version-addressed source: a raw artifact pinned to a Git commit or equivalent
  immutable revision may be the evidence identity; still retain the consulted
  bytes when deletion would otherwise make the notes unauditable.

`retrieved` means the date the source version supporting the current notes was
captured. Update it only when the notes are reconciled to a materially changed
source; never bump it merely because the URL was fetched successfully.
