#!/usr/bin/env python3
"""Validate the retained survey record and print its derived quantities."""

import csv
import json
import re
import sys
from collections import Counter
from pathlib import Path


RECORD = Path(__file__).resolve().parent
SURVEY = RECORD.parent
MANUSCRIPT = SURVEY / "manuscript"

CATALOG_FIELDS = [
    "key",
    "status",
    "code",
    "year",
    "title",
    "stage",
    "contribution",
    "evidence",
    "setting",
]
LOG_FIELDS = [
    "date",
    "kind",
    "id",
    "source",
    "query_or_seed",
    "direction",
    "hits",
    "screened",
    "included_keys",
    "excluded_keys",
    "notes",
]
STATUSES = {"included", "excluded", "parked"}
KINDS = {"search", "snowball", "audit", "exploratory"}
FACET_FIELDS = ["stage", "contribution", "evidence", "setting"]
STAGES = {"search", "screen", "extract", "appraise", "synthesize", "report", "end2end", "meta"}
CONTRIBUTIONS = {"method", "system", "evaluation", "guideline", "position"}
EVIDENCE = {"human-agree", "benchmark", "none"}
SETTINGS = {"med", "se", "general"}
EXCLUSION_CODES = {"E1", "E2", "E3", "E4", "E5", "E6", "E7"}
KEY = re.compile(r"(?:doi:10\.\d{4,9}/\S+|arxiv:\d{4}\.\d{4,5}|t:[a-z0-9]+|legacy:\S+)$")


def read_tsv(path, expected, errors):
    with path.open(newline="") as source:
        reader = csv.DictReader(source, delimiter="\t")
        if reader.fieldnames != expected:
            errors.append(f"{path.name}: header {reader.fieldnames!r}, expected {expected!r}")
        return list(reader)


def duplicates(values):
    return sorted(value for value, count in Counter(values).items() if count > 1)


def main():
    errors = []
    catalog = read_tsv(RECORD / "catalog.tsv", CATALOG_FIELDS, errors)

    for lineno, row in enumerate(catalog, start=2):
        if None in row or row["key"] == "" or row["status"] not in STATUSES:
            errors.append(f"catalog.tsv:{lineno}: malformed row")
            continue
        if row["status"] == "included":
            if row["code"] != "":
                errors.append(f"catalog.tsv:{lineno}: included row carries a code")
            for field in ["year", "title", *FACET_FIELDS]:
                if row[field] == "":
                    errors.append(f"catalog.tsv:{lineno}: included row missing {field}")
        else:
            for field in ["year", "title", *FACET_FIELDS]:
                if row[field] != "":
                    errors.append(f"catalog.tsv:{lineno}: {row['status']} row carries {field}")
            if row["status"] == "excluded" and row["code"] not in EXCLUSION_CODES:
                errors.append(f"catalog.tsv:{lineno}: unknown exclusion code {row['code']!r}")
            if row["status"] == "parked" and row["code"] != "":
                errors.append(f"catalog.tsv:{lineno}: parked row carries a code")

    keys_all = [row["key"] for row in catalog]
    for value in duplicates(keys_all):
        errors.append(f"duplicate catalog key: {value}")
    for value in keys_all:
        if not KEY.fullmatch(value):
            errors.append(f"invalid key: {value}")

    included = [row for row in catalog if row["status"] == "included"]
    excluded = [row for row in catalog if row["status"] == "excluded"]
    parked = [row for row in catalog if row["status"] == "parked"]
    included_keys = [row["key"] for row in included]

    dimensions = {
        "stage": (STAGES, Counter(row["stage"] for row in included)),
        "contribution": (
            CONTRIBUTIONS,
            Counter(row["contribution"] for row in included),
        ),
        "evidence": (EVIDENCE, Counter(row["evidence"] for row in included)),
        "setting": (SETTINGS, Counter(row["setting"] for row in included)),
    }
    for field, (allowed, counts) in dimensions.items():
        for value in sorted(set(counts) - allowed):
            errors.append(f"unknown {field}: {value}")
    codes = Counter(row["code"] for row in excluded)

    log = read_tsv(RECORD / "log.tsv", LOG_FIELDS, errors)
    kind_counts = Counter()
    for lineno, row in enumerate(log, start=2):
        if None in row or row["kind"] not in KINDS:
            errors.append(f"log.tsv:{lineno}: malformed row or unknown kind")
            continue
        kind_counts[row["kind"]] += 1
        if row["date"] == "" or row["id"] == "":
            errors.append(f"log.tsv:{lineno}: missing date or id")
        if row["kind"] in {"search", "snowball"} and (
            row["source"] == "" or row["query_or_seed"] == "" or row["hits"] == ""
        ):
            errors.append(f"log.tsv:{lineno}: {row['kind']} row missing source/query/hits")
        if row["kind"] == "audit" and row["notes"] == "":
            errors.append(f"log.tsv:{lineno}: audit row without notes")

    notes = sorted((RECORD / "sources").glob("*.md"))
    reads = Counter()
    note_keys = set()
    required_sections = {"## Evidence", "## Bearing on RQs", "## Evidence limits"}
    required_note_fields = {
        "citekey",
        "read",
        "source",
        "retrieved",
        "notes-by",
        "notes-date",
        "synthesis",
    }
    required_work_fields = {"title", "author", "date"}
    for note in notes:
        text = note.read_text()
        citekey = re.search(r"^citekey:\s*(.+)$", text, re.M)
        read = re.search(r"^read:\s*(full-text|abstract-only)$", text, re.M)
        frontmatter = text.split("---", 2)[1] if text.startswith("---") else ""
        present_note_fields = set(re.findall(r"^([a-z][a-z-]+):", frontmatter, re.M))
        work_match = re.search(r"^work:\s*$\n((?:^  .+\n?)+)", frontmatter, re.M)
        present_work_fields = (
            set(re.findall(r"^  ([a-z]+):", work_match.group(1), re.M))
            if work_match
            else set()
        )
        for field in sorted(required_note_fields - present_note_fields):
            errors.append(f"{note.name}: missing {field}")
        for field in sorted(required_work_fields - present_work_fields):
            errors.append(f"{note.name}: missing work.{field}")
        if not citekey:
            errors.append(f"{note.name}: missing citekey")
        else:
            value = citekey.group(1).strip()
            note_keys.add(value)
            if value != note.stem:
                errors.append(f"{note.name}: filename/citekey mismatch")
        if not read:
            errors.append(f"{note.name}: invalid or missing read depth")
        else:
            reads[read.group(1)] += 1
        for heading in sorted(required_sections):
            if heading not in text:
                errors.append(f"{note.name}: missing {heading}")
        note_identifiers = {
            f"{scheme}:{value.lower()}"
            for scheme, value in re.findall(
                r"^  (doi|arxiv):\s*[\"']?([^\s\"']+)", frontmatter, re.M
            )
        }
        if not note_identifiers:
            errors.append(f"{note.name}: missing work DOI/arXiv identifier")
        elif not (note_identifiers & set(included_keys)):
            errors.append(f"{note.name}: no work identifier maps to an included catalog row")
    if len(note_keys) != len(notes):
        errors.append("duplicate source-note citekey")

    index = (SURVEY / "index.md").read_text()
    curated = {
        Path(match).stem
        for match in re.findall(r"record/sources/([^\)]+\.md)", index)
    }
    curated.update(
        target
        for target in re.findall(r"\[\[([^\]]+)\]\]", index)
        if target in note_keys
    )

    bib_text = (MANUSCRIPT / "references.bib").read_text()
    bib_keys = set(re.findall(r"^@\w+\{([^,]+),", bib_text, re.M))
    with (MANUSCRIPT / "references.tsv").open(newline="") as source:
        reference_rows = list(csv.reader(source, delimiter="\t"))
    for lineno, row in enumerate(reference_rows, start=1):
        if len(row) != 2 or not all(row):
            errors.append(f"references.tsv:{lineno}: expected two nonempty fields")
    valid_reference_rows = [row for row in reference_rows if len(row) == 2]
    for value in duplicates(row[0] for row in valid_reference_rows):
        errors.append(f"duplicate references.tsv citekey: {value}")
    for value in duplicates(row[1] for row in valid_reference_rows):
        errors.append(f"duplicate references.tsv identifier: {value}")
    reference_keys = {row[0] for row in valid_reference_rows}
    manual_path = MANUSCRIPT / "references-manual.bib"
    manual_keys = (
        set(re.findall(r"^@\w+\{([^,]+),", manual_path.read_text(), re.M))
        if manual_path.exists()
        else set()
    )
    if reference_keys | manual_keys != bib_keys:
        errors.append("generated/manual reference keys do not match references.bib")
    content = (MANUSCRIPT / "content.typ").read_text()
    labels = set(re.findall(r"<((?:sec|tab)-[A-Za-z0-9_-]+)>", content))
    citations = set(re.findall(r"@([A-Za-z][A-Za-z0-9_-]+)", content)) - labels
    citations.update(
        re.findall(r"#cite\(<([A-Za-z][A-Za-z0-9_-]+)>", content)
    )
    for value in sorted(citations - bib_keys):
        errors.append(f"citation missing from references.bib: {value}")
    for value in sorted(bib_keys - citations):
        errors.append(f"uncited references.bib entry: {value}")

    stage_cross = {}
    for stage in sorted(STAGES):
        rows = [row for row in included if row["stage"] == stage]
        stage_cross[stage] = {
            "med": sum(row["setting"] == "med" for row in rows),
            "se": sum(row["setting"] == "se" for row in rows),
            "general": sum(row["setting"] == "general" for row in rows),
            "total": len(rows),
            "human-agree": sum(row["evidence"] == "human-agree" for row in rows),
            "benchmark": sum(row["evidence"] == "benchmark" for row in rows),
            "none": sum(row["evidence"] == "none" for row in rows),
        }

    report = {
        "catalog_rows": len(catalog),
        "included_rows": len(included),
        "excluded_rows": len(excluded),
        "parked_rows": len(parked),
        "exclusion_codes": dict(sorted(codes.items())),
        "log_rows": dict(sorted(kind_counts.items())),
        "stage": dict(sorted(dimensions["stage"][1].items())),
        "contribution": dict(sorted(dimensions["contribution"][1].items())),
        "evidence": dict(sorted(dimensions["evidence"][1].items())),
        "setting": dict(sorted(dimensions["setting"][1].items())),
        "stage_cross_table": stage_cross,
        "source_notes": len(notes),
        "read_depth": dict(sorted(reads.items())),
        "curated_source_notes": len(curated),
        "bibliography_entries": len(bib_keys),
        "manuscript_citations": len(citations),
    }
    print(json.dumps(report, indent=2, sort_keys=True))
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
