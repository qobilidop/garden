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


def rows(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source, dialect="excel-tab")
        return reader.fieldnames or [], list(reader)


def keys(field: str) -> list[str]:
    return [] if field == "-" else field.split(",")


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

    header, log_rows = rows(SURVEY / "search-log.tsv")
    if header != SEARCH_HEADER:
        fail(f"unexpected search-log header: {header}")
    for number, row in enumerate(log_rows, start=2):
        for field in ("hits", "screened"):
            if not row[field].isdigit():
                fail(f"search-log row {number} has nonnumeric {field}")
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
            if not (SURVEY / relative).is_file():
                fail(f"search-log row {number} references missing {relative}")

    for path in sorted((SURVEY / "screening").glob("*.tsv")):
        header, snapshot_rows = rows(path)
        if header != SCREENING_HEADER:
            fail(f"unexpected screening header in {path.relative_to(ROOT)}: {header}")
        for rank, row in enumerate(snapshot_rows, start=1):
            if row["rank"] != str(rank):
                fail(f"nonsequential rank in {path.relative_to(ROOT)}")
            if not row["openalex_id"]:
                fail(f"missing identifier in {path.relative_to(ROOT)} row {rank + 1}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
