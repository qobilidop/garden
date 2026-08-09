---
author: Claude Fable 5
---

# Survey artifact session: from frozen baseline to reviewed piece

One session carried the survey layer from "campaign closed" to a
finished, adversarially reviewed artifact: skill v1 extracted, then
manuscript (markdown → Typst, two renders), landing page (abs-page →
curated reading list), record (campaign residue → minimal resume
contract), authorship and citation conventions, a CSUR style
experiment (reverted by taste), and a four-lens review panel run to
closure. Bili redirected repeatedly and every redirection was a
design decision, not a correction of error — the session's real
output is the settled shape now codified in run-survey v2.

## Proposal outcomes (second /evolve of the day)

- P1 applied: run-survey rewritten as v2 — goals first
  (learning-first, no self-as-data, traceability over
  reproducibility), light default with heavy mode demoted to opt-in,
  three surfaces, taxonomy centerpiece, reading-list conventions,
  review panel as a close-out phase, nine earned Typst gotchas. The
  retrospective's subtraction: v1's validity apparatus compressed to
  one opt-in section.
- P2 applied: tend-site race note now carries the proven one-chain
  recovery.
- P3 applied (against precedent, deliberately): the global shell
  rules reworded into action habits — gating commands run unpiped
  into a file with bare `$?` tested; heredocs/scripts take absolute
  paths. Three prior sessions ruled "compliance failure, don't
  reword"; this session's difference is that the new wording
  prescribes the habit that actually held for the second half of the
  session after four cwd failures and one costly piped-exit-code
  misread (the phantom-fonts detour). Watch whether it holds.
- P4 applied: naming-and-README taste memory (entrypoint clarity,
  verb-object scripts, README only for contract content).
- P5: this note.

## Principles that emerged

- A survey cannot launder its own anchor evidence (the referee's
  phrasing): caveats travel with a number to every surface it
  appears on — abstract and reading-list annotations included.
- Self-review has a ceiling: the four-lens panel found HIGH-severity
  problems (table-contradicted claim, mis-attributed citation,
  funnel arithmetic, uncaveated preprint numbers) in a piece already
  self-reviewed twice. Different lenses, not more passes.
- Reviewer disagreements are adjudicated on primary evidence: the
  referee asked to restore the "targeted probes" claim; the search
  log proved no probes ran; removal stood.
- Fresh quantities introduced during fixes are the most audit-worthy
  values in a document — compute them from the record before writing
  them (8-of-25 facet conflicts, the 881−2 funnel merge were both
  verified, and both survived re-audit).
- Content and costume are separable: the same content.typ rendered
  under two complete designs (house style, acmsmall approximation)
  with only wrapper/style swaps — which made the taste revert cheap.
- Two artifacts with one job each beat one artifact with two jobs:
  paper (standalone) + landing page (link graph) dissolved the
  wikilinks-in-a-paper tension.

## Errors worth remembering

- Piped a gating build through tail; read exit 0; validated against
  a stale image (typst's embedded fonts masked it). Root rule
  existed; now reworded to the habit (P3).
- cwd drift broke four commands; absolute-paths-everywhere held
  afterwards.
- Citation-style round trips leave residue: prose hand-written for
  numeric CSL ("Author et al. @key") double-renders under
  author-year. Grep for the pattern when switching styles.

## Staged, awaiting recurrence

- Generalizing the adversarial review panel beyond surveys (one
  occurrence; run-survey §6 carries it for now; promote to a
  standalone skill or AGENTS.md if another artifact class uses it).
- The Workflow tool as the panel's engine (this round used plain
  subagent fan-out + SendMessage re-verification; fine at n=4).

## Open threads

- Next campaign (HW-spec or dataflow residue) runs under v2 — its
  first real test.
- Deposition/DOI, PDF-grade bibliography styling, and the `.bib`
  generator's next consumer remain deferred until a survey is worth
  citing.
- wiki/survey-methodology.md may eventually want the v2 method
  reflected (it describes v1's heavy mode as "local instantiation").
