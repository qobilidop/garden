---
author: Codex GPT-5.6 Sol
---

# Closing the hardware symbolic-execution survey and ingesting its adjacent map

The `symbolic-execution-hardware` campaign reached a publication-ready
snapshot only after its adversarial panel tested three different things:
claim fidelity, generated-artifact fidelity, and whether the record could be
resumed as a living survey. Treating those as one generic “review” would have
hidden the session's most useful lessons.

## Generated artifacts are part of the reviewed object

Several late claim fixes were correct in Typst source while the generated
HTML and PDF still contained superseded language. A separate export defect
turned a method date beginning with `2026.` into an ordered-list item, and
Markdown-style double emphasis produced empty HTML nodes even though the PDF
looked plausible. The final gate therefore had to rebuild references, both
manuscript forms, and the site, then inspect the affected PDF pages and HTML
structure.

This is now explicit in `run-survey`: a source edit reopens artifact-level
closure, and a review verdict is provisional until it addresses current
generated output.

## A living-survey validator must understand checkpoints

The first local validator was accurate for the initial snapshot but encoded
that snapshot as if it were permanent. It fixed the funnel arithmetic,
counted search events over the lifetime log, and compared every update-ledger
row with current state. The resumability review exposed the shared cause:
historical events and current-checkpoint quantities had not been separated.

The repaired survey checker preserves the initial funnel, admits later
audited additions, scopes query execution to the current coverage date,
compares the latest ledger row, and validates delegated decision homes. The
general requirement now lives in `run-survey`; the survey-local checker keeps
the concrete schema.

## OA metadata and OA acquisition are different questions

For `jayasena2023-directed`, Unpaywall and OpenAlex correctly identified an
open ACM PDF, while the publisher endpoint served a bot challenge to the
ingestion environment. The authors' official publication index provided an
exact stable PDF link, and the downloaded file's title, authors, header, and
publication identity matched the registrar record. This pattern already
appears across author-hosted hardware papers in the public survey evidence,
so it has recurred enough to refine `ingest-paper`.

The new fallback remains bounded: resolver first; when the identified OA host
is technically gated, one official author or institution index; follow an
exact link rather than guessing; verify identity and record provenance; then
use a verified existing archive or the queue. It does not reopen the old
publisher-mirror tour.

## Candidates not promoted

- A mistaken ripgrep flag was a one-off command error, not a missing project
  rule.
- One internet search call stalled; the successful metadata and author-index
  routes already fit existing network fallback discipline.
- Mechanical PDF transcripts contain extractor whitespace. `ingest-paper`
  already forbids hand-cleaning derived transcripts, so another rule would be
  duplicate weight rather than protection.
- Empty terminal TSV cells produced noisy staged whitespace in the new survey,
  but existing retained survey ledgers deliberately use them. A global TSV
  sentinel rule would force migration for presentation hygiene, so it was not
  promoted.

No new skill or memory was justified. The recurring work still belongs within
`run-survey` and `ingest-paper`, and the session established no new durable
fact about the user.
