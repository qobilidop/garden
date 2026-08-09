# Survey update workflow

`queries.tsv` is the versioned registry of recurring discovery searches. Its
`query` column stores a Crossref bibliographic query or an exact arXiv API
Boolean expression, according to `source`.
`state.tsv` records the last fully reconciled execution of each query, while
`tasks.tsv` tracks periodic maintenance that is not a database query. Fetching
a result set does not advance state.

## 1. Inspect freshness

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
```

## 2. Stage result sets

Fetch all registered queries, or one query while testing:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record fetch --all
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record fetch --query-id crossref-symbolic-residual
```

Results and a JSON manifest are written under
`.scratch/survey-update/YYYY-MM-DD/`. They are intentionally uncommitted.
Each registered search covers the inclusive interval from its last reconciled
date through the batch date. Crossref ranks the date-bounded set by relevance;
arXiv returns recent submissions first. Repeating the boundary date is
deliberate: delayed deposits and same-day updates are caught, then removed
during catalog deduplication. The orchestrator also spaces consecutive arXiv
requests by three seconds.

## 3. Screen and reconcile

For every staged row:

1. match DOI, stable identifier, and normalized title against `catalog.tsv`;
2. assign inclusion, exclusion, or retained-candidate disposition;
3. read the primary source when title and abstract leave relevance plausible;
4. record newly exposed terminology or citation seeds; and
5. complete any source note required by the resulting catalog status.

## 4. Promote an audited batch

Append one matching row to `log.tsv` and update the catalog; the
staged result set is discarded after reconciliation. Then reconcile syntheses,
claims, terminology, formal material, the evidence matrix, and manuscript.

Only after all of those changes are complete should `state.tsv` be advanced to
the batch date. Record the same interval and query ID in the promoted log row. Run `./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/check.py` before committing.

## Citation maintenance

Registered database searches complement rather than replace
snowballing. A new critical work requires separate backward and
forward snapshots. Existing critical works receive a complete forward
refresh as part of any substantial update batch; index defects must
be recorded and checked against another stable source.
