# Survey record

The minimal resumable state of this exploratory systematic map. The
rules live in `protocol.md`; this README is the map and the
operating procedure. The original campaign predates the current
`run-survey` workflow — future updates use the current workflow as a
guide, exercising judgment where the retained record differs, and
describe material method changes in the protocol in plain language.
Process history lives in git and is not required to resume.

An updater needs this directory, the
[manuscript](https://qobilidop.github.io/sys0/surveys/agent-assisted-evidence-synthesis/manuscript.html)
(taxonomy in §3; method and historical funnel in §4), the
repository's `AGENTS.md`, and the current `run-survey` skill.

## Start here

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/agent-assisted-evidence-synthesis/record status
./dev.sh python3 surveys/agent-assisted-evidence-synthesis/record/check.py
```

`update.py status` reports coverage and current record counts.
`check.py` validates the catalog, log, queries, notes, claims and
evidence bindings, bibliography, and citation closure, and prints
the derived counts for cross-surface reconciliation.

## Shape

This record deliberately differs from the minimal shape in one way:
the Integrity ledger below retains historical funnel aggregates that
the pruned record cannot regenerate (candidate-level wave/source
provenance was not kept), so the wave table here — not the log alone
— is the provenance for funnel changes. Evidence registration is
partial by declaration: `evidence.md` covers the findings-bearing
citations; registering the remainder is deferred in `status.md`.
One legacy deviation from the current shared shape remains, declared
as deferred work in `status.md`: the campaign's historical log rows
carry counts only, without per-row decided keys. Update rows from
2026-08-09 onward carry them.

## Files

Purpose and update rule for every record file; the governing rules
are in `protocol.md`.

- `protocol.md` — scope, search/key/snowball rules, selection codes
  with boundary examples, screening pass structure, taxonomy tokens,
  note/synthesis/claims discipline — always in current final form.
  Material method changes update it in place, never silently: each
  change is logged in `status.md`'s Method changes section with an
  audit row in `log.tsv`.
- `status.md` — current coverage and manuscript state, plus deferred
  work; counts are regenerated, not hand-edited. Its Method changes
  section is the campaign-scoped, append-only plain-language change
  log for `protocol.md`: it survives regeneration while a campaign
  is open and dissolves at campaign close, once its content is
  absorbed into the protocol's final state, the `log.tsv` audit
  rows, and the manuscript disclosures.
- `catalog.tsv` — one current row per surfaced work: `key`, `status`
  on a single scrutiny scale — `included` (abstract-level
  primary-focus facets), `deep-read` (included *and* carrying an
  evidence note in `sources/`; a strictly higher scrutiny level, so
  headline "included" counts are `included + deep-read`), `excluded`
  (coded screening memory), and `parked` (re-screened each update) —
  then `code`
  (slugged exclusion code, excluded rows only), `year`, `title`,
  the taxonomy facets `stage`/`contribution`/`evidence`/`setting`
  (included rows only), and `priority` (`critical` marks the
  closest-work set — competing maps, the load-bearing evidence works,
  and the disclosure instruments, derived from
  `syntheses/current-position.md` and listed in the designation audit
  row — chased both directions on every substantial update batch;
  other deep reads are `high`; all remaining rows `medium`).
- `log.tsv` — the append-only event log: `search` rows with verbatim
  queries, dates, and yields, plus `audit` rows for corrections and
  migrations; future search and snowball rows record decided keys.
- `queries.tsv` — the standing discovery queries, each row carrying
  its `last_reconciled` date.
- `sources/` — an evidence note per deep-read work, named by short
  citekey; the note contract is the `run-survey` skill's
  `assets/source-note-template.md`.
- `syntheses/` — the understanding layer: thematic files with
  `current-position.md` as entry point, revised after each reading
  batch.
- `claims.md` — the synthesis claims ledger (`Cxx` ids); statuses
  declared in its preamble.
- `evidence.md` — one record per evidence item (`Exxx`), binding
  claims and manuscript sections to note anchors.
- `check.py` — the record validator; shared search, fetch, and
  update tools live in `skills/run-survey/scripts/`.

## Integrity ledger

The campaign closed with 1,291 identifier rows and 672 included rows.
The 2026-08-08 adversarial review resolved 24 duplicate/version aliases
to their versions of record and moved two formally retracted works to
E7-retracted-or-withdrawn. One later journal publication (Madeyski et
al.) added a canonical DOI while retaining its arXiv identifier as
E6-duplicate-or-superseded memory, so the retained ledger now has
1,292 identifier rows: 646 included, 634 excluded, and 12 parked.

Mechanical normalized-title grouping now leaves one apparent collision:
`10.1016/j.jclinepi.2025.111894` is the Stage I protocol and
`10.1016/j.jclinepi.2025.112102` is the distinct Stage II results paper.
Both are intentionally included. `check.py` verifies key uniqueness and
the current marginals; this paragraph records the only known display-
title collision.

Historical phase counts below are retained aggregates: the pruned record
does not contain candidate-level wave/source provenance and cannot
regenerate them. Current catalog and facet counts are mechanical.

| Event | Candidate rows | Included rows | Notes |
|---|---:|---:|---|
| Successful initial searches | 471 result rows | — | 419 unique before arXiv–DOI merging |
| Initial dedup | 412 | — | seven merged rows |
| Dual-pass screen + adjudication | 412 | 139 | historical aggregate |
| Snowball retrieval | 1,204 new | — | from 139 seeds; historical aggregate |
| Vocabulary pre-screen | 881 passed | — | 323 uncataloged rejects |
| Wave-2 screen + verification | 879 added | 533 | two of 881 merged on catalog entry |
| Campaign close | 1,291 | 672 | before integrity correction |
| Integrity correction | 1,292 | 646 | 24 aliases resolved, two retractions removed, one later publication migrated; 12 rows remain parked |

For every future update, append a row to this ledger. It is the retained
provenance for future funnel changes.

| Date | Prior cutoff | New cutoff | Qids succeeded / failed | Raw results | Unique new | Prefilter rejects | Screened | Parked | Aliases | Included | Human gate |
|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---|
| 2026-08-09 | 2026-08-08 | 2026-08-09 | 17/1 (+24 chases, 3 primary-complete) | 1,708 | 683 | 596 | 585 | 76 standing | 13 resolved, 13 dropped | +130 (776 total) | Bili, 2026-08-09 |

Column semantics: Raw results counts all staged rows (query, chase,
and primary-complete files); Unique new is the catalog row delta;
Prefilter rejects are snowball vocabulary rejects (title + model);
Screened counts dual-pass decisions; Parked is the standing total
after the batch; Aliases counts version pairs resolved to E6 plus
unresolved-reference artifacts dropped; Included is the include-level
delta (batch include decisions, minus one rediscovery and one work
later reclassified out by deep-read triage). The chase and
primary-complete counts include the pair run when akinseloyin2026 was
designated critical after the main round, which is why the row's
totals exceed the figures in any single reconciliation step.

The initial campaign's 13 `search` rows in `log.tsv` are 11 logical
qids plus retries: qid `s22` failed once and then succeeded; `s23`
failed twice and never succeeded; the successful initial requests
returned 471 result rows. The inverse held in the 2026-08-09 update,
where `s23` succeeded and `s22` failed terminally after six attempts
across two spaced rounds.

## Bibliography and build

Add an anchor's canonical identifier to `../manuscript/references.tsv`,
then run from the repository root:

```sh
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/agent-assisted-evidence-synthesis/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

`make_references.py` validates duplicate keys/identifiers, accepts a
same-key fallback in `references-manual.bib`, and replaces
`references.bib` atomically only after every entry resolves. On any
failure it leaves the prior bibliography untouched. The build writes
`site/public/surveys/agent-assisted-evidence-synthesis/manuscript.html`
and `.pdf`.

## To update

1. Choose the new cutoff; run the search and snowball rules in
   `protocol.md`. Registered searches stage with
   `update.py fetch --all` (add `--initial-from-date` for any query
   whose `last_reconciled` is empty). Citation chases have no
   orchestrator: invoke `search_openalex.py snowball <seed>
   <direction>` once per seed and direction, and
   `fetch_crossref_references.py` for a defective bibliography.
   Everything downstream of the raw staged file — dedup against the
   catalog, the vocabulary pre-filter, abstract enrichment — is
   currently unscripted in the shared tooling and was done with
   batch-local scripts; expect to rebuild them from the protocol's
   rules. Append request attempts to the log and the update-ledger
   row above.
2. Deduplicate, screen, adjudicate, and human-gate per the protocol;
   update the catalog and re-screen all parked rows.
3. Apply the taxonomy rules; deep-read new anchor candidates,
   preserving and appending `notes-by` attribution on material
   revisions.
4. Reconcile the syntheses, claims, and evidence records the batch
   affects — understanding changes land in `syntheses/` first, then
   `claims.md`/`evidence.md`, then the manuscript.
5. Update the curated list, manuscript prose, historical/current
   funnel, abstract, limitations, and draft date wherever the
   derived report or findings changed.
6. Run `check.py`; reconcile its totals against this README,
   `../index.md`, `../manuscript/meta.typ`, and every quantity in
   `../manuscript/content.typ`.
7. Regenerate the bibliography and build both manuscript formats.
   Check citation closure, HTML anchors, PDF/HTML links, and
   `git diff --check`.
8. Bump the search window and draft date only after all checks pass;
   log the human gate and describe any material method change per
   the protocol. The gate's own working artifacts — the disagreement
   set, the parked list, the sampled agreements shown to the human —
   are staged in scratch and are *not* retained: the ledger keeps the
   attestation (who gated, on what date, over which counts), and the
   decisions themselves are recoverable from the catalog and log.
   This is a deliberate bound on the record, consistent with
   discarding result sets, and it means a future auditor can check
   what was decided but not what was displayed.
