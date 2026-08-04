# Screening snapshots

These TSV files freeze the identifier, title, DOI, year, venue, and type records
returned by the discovery index for each audited query or citation-neighborhood
row in `../search-log.tsv`. They intentionally omit abstracts and full text.

The snapshots serve three purposes:

1. make the screened result set inspectable even if the index ranking changes;
2. expose duplicate, malformed, or unresolved metadata rather than silently
   repairing it; and
3. let an independent reviewer reproduce the inclusion and exclusion audit.

The search log is authoritative for the exact query or seed, hit count,
screened count, included catalog keys, exclusions, and known limitations. A
snapshot records discovery metadata only; technical claims still require a
primary source note. OpenAlex records are discovery evidence, not authoritative
bibliographic metadata. For example, its ECOOP 2024 record currently associates
the compositional-symbolic-execution title with the wrong article DOI; the
catalog and bibliography use the official Dagstuhl record.

OpenAlex citation-neighborhood and concept-query files are generated through:

```console
./dev.sh python3 scripts/openalex-screen.py ... --output research/survey/screening/NAME.tsv
```

The independent Crossref closure batch uses a second exporter with a
source-neutral identifier column:

```console
./dev.sh python3 scripts/crossref-screen.py QUERY \
  --limit 50 --output research/survey/screening/NAME.tsv
```

Files named `primary-CITEKEY-backward.tsv` transcribe the complete reference
list of the exact primary version named in that work's source note. They use
the same source-neutral header. A DOI is the preferred `source_id`; a stable
per-seed `citation-N` identifier preserves entries without one. These files
are mandatory when an index returns unresolved reference identifiers, a
truncated bibliography, a wrong version, or an implausible zero-reference
result.

No closure claim follows merely from the presence of snapshots. The protocol's
deep-reading, separate seed chasing, consecutive no-add rounds, and independent
audit requirements still apply.
