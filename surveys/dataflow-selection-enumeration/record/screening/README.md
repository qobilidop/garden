# Screening snapshots

These TSV files freeze the identifier, title, DOI, year, venue, and type records
returned by the discovery index for each audited query or citation-neighborhood
row in `../log.tsv`. Some source exporters include abstracts; full
text is never committed here.

`baseline-2026-08-04/` contains the complete first mapping snapshot. Later
fully adjudicated batches use their own `YYYY-MM-DD/` directories.

The snapshots serve three purposes:

1. make the screened result set inspectable even if the index ranking changes;
2. expose duplicate, malformed, or unresolved metadata rather than silently
   repairing it; and
3. let an independent reviewer reproduce the inclusion and exclusion audit.

The event log is authoritative for the exact query or seed, hit count,
screened count, included catalog keys, exclusions, and known limitations. A
snapshot records discovery metadata only; technical claims still require a
primary source note. OpenAlex records are discovery evidence, not authoritative
bibliographic metadata. For example, its ECOOP 2024 record currently associates
the compositional-symbolic-execution title with the wrong article DOI; the
catalog and bibliography use the official Dagstuhl record.

New update batches use date-named subdirectories. OpenAlex citation-neighborhood
and concept-query files are generated through:

```console
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/screen_openalex.py ... \
  --output surveys/dataflow-selection-enumeration/record/screening/YYYY-MM-DD/NAME.tsv
```

Manual Crossref result snapshots use a source-neutral identifier column. Date
bounds are required for recurring updates and may be supplied for an ad hoc
snapshot:

```console
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/screen_crossref.py QUERY \
  --limit 100 --from-date YYYY-MM-DD --to-date YYYY-MM-DD \
  --output surveys/dataflow-selection-enumeration/record/screening/YYYY-MM-DD/NAME.tsv
```

Files named `primary-CITEKEY-backward.tsv` transcribe the complete reference
list of the exact primary version named in that work's source note. They use
the same source-neutral header. A DOI is the preferred `source_id`; a stable
per-seed `citation-N` identifier preserves entries without one. These files
are mandatory when an index returns unresolved reference identifiers, a
truncated bibliography, a wrong version, or an implausible zero-reference
result.

Semantic Scholar can likewise return citation stubs with neither a paper ID
nor a DOI. The exporter retains them under the snapshot-local identifier
`unresolved-record-N`; this exposes missing index metadata without deleting a
screened result or inventing authoritative bibliographic identity.

No freshness or closure claim follows merely from the presence of snapshots.
The catalog, syntheses, evidence matrix, manuscript, and update state must also
be reconciled under the living protocol.
