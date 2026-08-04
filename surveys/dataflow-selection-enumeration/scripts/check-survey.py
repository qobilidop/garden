#!/usr/bin/env python3
"""Validate the survey catalog, audited log, and screening snapshots."""

import csv
from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parent.parent
SURVEY = ROOT / "research" / "survey"
CATALOG_HEADER = [
    "citekey",
    "year",
    "cluster",
    "status",
    "priority",
    "venue",
    "primary_url",
    "relevance",
    "exclusion_reason",
]
SEARCH_HEADER = [
    "date",
    "round_id",
    "phase",
    "source",
    "exact_query_or_seed",
    "direction",
    "hits",
    "screened",
    "included_keys",
    "excluded_keys",
    "notes",
]
SCREENING_HEADER = [
    "rank",
    "openalex_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
]
OPENALEX_ABSTRACT_SCREENING_HEADER = [*SCREENING_HEADER, "abstract"]
GENERIC_SCREENING_HEADER = [
    "rank",
    "source_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
]
GENERIC_ABSTRACT_SCREENING_HEADER = [*GENERIC_SCREENING_HEADER, "abstract"]
BACKWARD_DEFECT_MARKERS = (
    "unresolved",
    "index omits",
    "exposes no references",
    "wrong-version",
    "primary list is longer",
    "incomplete bibliography",
    "truncated bibliography",
)


def rows(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source, dialect="excel-tab")
        return reader.fieldnames or [], list(reader)


def keys(field: str) -> list[str]:
    return [] if field == "-" else field.split(",")


def seed_key(notes: str) -> str | None:
    match = re.search(r"(?:^|; )seed-key:([A-Za-z0-9_.-]+)(?:;|$)", notes)
    return match.group(1) if match else None


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def main() -> int:
    header, catalog_rows = rows(SURVEY / "catalog.tsv")
    if header != CATALOG_HEADER:
        fail(f"unexpected catalog header: {header}")
    catalog = {row["citekey"]: row for row in catalog_rows}
    if len(catalog) != len(catalog_rows):
        fail("catalog contains duplicate citekeys")

    bibliography = (ROOT / "references.bib").read_text(encoding="utf-8")
    bibliography_keys = set(re.findall(r"@[A-Za-z]+\{([^,]+),", bibliography))
    for citekey, row in catalog.items():
        if row["status"] != "deep-read":
            continue
        source_note = SURVEY / "sources" / f"{citekey}.md"
        if not source_note.is_file():
            fail(f"deep-read work {citekey} has no source note")
        if citekey not in bibliography_keys:
            fail(f"deep-read work {citekey} has no bibliography entry")

    header, log_rows = rows(SURVEY / "search-log.tsv")
    if header != SEARCH_HEADER:
        fail(f"unexpected search-log header: {header}")
    referenced_snapshots: set[str] = set()
    for number, row in enumerate(log_rows, start=2):
        for field in ("hits", "screened"):
            if not row[field].isdigit():
                fail(f"search-log row {number} has nonnumeric {field}")
        if int(row["screened"]) > int(row["hits"]):
            fail(f"search-log row {number} screens more records than it reports")
        for citekey in keys(row["included_keys"]):
            if citekey not in catalog:
                fail(f"search-log row {number} includes unknown key {citekey}")
            if catalog[citekey]["status"] == "excluded":
                fail(f"search-log row {number} includes excluded key {citekey}")
        for citekey in keys(row["excluded_keys"]):
            if citekey not in catalog:
                fail(f"search-log row {number} excludes unknown key {citekey}")
            if catalog[citekey]["status"] != "excluded":
                fail(f"search-log row {number} exclusion {citekey} is not excluded")
        for relative in re.findall(r"screening/[^ ;]+\.tsv", row["notes"]):
            referenced_snapshots.add(relative)
            snapshot = SURVEY / relative
            if not snapshot.is_file():
                fail(f"search-log row {number} references missing {relative}")
            _, snapshot_rows = rows(snapshot)
            if len(snapshot_rows) != int(row["screened"]):
                fail(
                    f"search-log row {number} reports {row['screened']} screened "
                    f"records but {relative} contains {len(snapshot_rows)}"
                )

    rows_by_seed: dict[str, list[dict[str, str]]] = {}
    for row in log_rows:
        key = seed_key(row["notes"])
        if key is not None:
            rows_by_seed.setdefault(key, []).append(row)

    for citekey, row in catalog.items():
        if row["priority"] != "critical":
            continue
        if row["status"] != "deep-read":
            fail(f"critical work {citekey} is not deep-read")
        usable = [
            item
            for item in rows_by_seed.get(citekey, [])
            if "discovery-only" not in item["notes"]
        ]
        directions = {item["direction"] for item in usable}
        for direction in ("backward", "forward"):
            if direction not in directions:
                fail(f"critical work {citekey} has no usable {direction} chase")

    for row in log_rows:
        if row["direction"] != "backward":
            continue
        notes = row["notes"].lower()
        if not any(marker in notes for marker in BACKWARD_DEFECT_MARKERS):
            continue
        key = seed_key(row["notes"])
        if key is None:
            fail("defective backward row has no seed-key")
        if not any(
            "primary-complete" in item["notes"]
            for item in rows_by_seed.get(key, [])
        ):
            fail(f"defective backward chase for {key} has no primary bibliography")

    exploratory = (SURVEY / "exploratory-search-log.tsv").read_text(
        encoding="utf-8"
    ).splitlines()
    for number, line in enumerate(exploratory[1:], start=2):
        if "not-recorded" not in line:
            fail(f"exploratory-search-log row {number} is not reconciled")

    screening_paths = sorted((SURVEY / "screening").glob("*.tsv"))
    for path in screening_paths:
        header, snapshot_rows = rows(path)
        if header not in (
            SCREENING_HEADER,
            OPENALEX_ABSTRACT_SCREENING_HEADER,
            GENERIC_SCREENING_HEADER,
            GENERIC_ABSTRACT_SCREENING_HEADER,
        ):
            fail(f"unexpected screening header in {path.relative_to(ROOT)}: {header}")
        for rank, row in enumerate(snapshot_rows, start=1):
            if row["rank"] != str(rank):
                fail(f"nonsequential rank in {path.relative_to(ROOT)}")
            identifier_field = (
                "openalex_id"
                if header in (SCREENING_HEADER, OPENALEX_ABSTRACT_SCREENING_HEADER)
                else "source_id"
            )
            if not row[identifier_field]:
                fail(f"missing identifier in {path.relative_to(ROOT)} row {rank + 1}")

    unreferenced = sorted(
        str(path.relative_to(SURVEY))
        for path in screening_paths
        if str(path.relative_to(SURVEY)) not in referenced_snapshots
    )
    if unreferenced:
        fail(f"unreferenced screening snapshot: {unreferenced[0]}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
