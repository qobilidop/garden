#!/usr/bin/env python3
"""Validate the hardware-symbolic-execution survey and print derived counts."""

import csv
import re
import sys
from collections import Counter
from pathlib import Path

RECORD = Path(__file__).resolve().parent
sys.path.insert(0, str(RECORD.parents[2] / "skills" / "run-survey" / "scripts"))

from survey_check import run  # noqa: E402


def map_report(catalog):
    included = [row for row in catalog.values() if row["status"] in {"included", "deep-read"}]
    by_decade = Counter()
    for row in included:
        if row["year"].isdigit():
            by_decade[f"{(int(row['year']) // 10) * 10}s"] += 1
        else:
            by_decade["unknown"] += 1
    with (RECORD / "log.tsv").open(newline="", encoding="utf-8") as handle:
        log_rows = list(csv.DictReader(handle, delimiter="\t"))
    audit_rows = [row for row in log_rows if row["kind"] == "audit"]
    audits = {row["id"]: row for row in audit_rows}
    funnel_ids = {
        "base_records": "base-screen-a",
        "chase_records": "snowball-screening",
        "carter_records": "carter-screening",
        "forbench_records": "forbench-screening",
        "manual_records": "manual-primary-additions",
    }
    funnel = {name: int(audits[identifier]["hits"]) for name, identifier in funnel_ids.items()}
    additions = sum(
        int(match.group(1))
        for row in audit_rows
        for match in re.finditer(r"(?:^|; )catalog-additions:(\d+)(?:;|$)", row["notes"])
    )
    if sum(funnel.values()) + additions != len(catalog):
        raise RuntimeError("baseline funnel plus update additions does not equal the catalog denominator")
    for row in log_rows:
        if row["kind"] not in {"search", "snowball"} or not row["screened"].isdigit() or int(row["screened"]) == 0:
            continue
        has_decisions = row["included_keys"] not in {"", "-"} or row["excluded_keys"] not in {"", "-"} or "parked-keys:" in row["notes"]
        has_external_partition = "no-chase-only" in row["notes"] or "external-decision-home:" in row["notes"]
        if not has_decisions and not has_external_partition:
            raise RuntimeError(f"positive-screened row {row['id']} has no retained decision partition")
        external = re.search(r"(?:^|; )external-decision-home:([^;]+)(?:;|$)", row["notes"])
        if external:
            target = RECORD.parents[2] / external.group(1)
            if not target.is_file():
                raise RuntimeError(f"external decision home does not exist: {external.group(1)}")
            seed = re.search(r"(?:^|; )seed-key:(\S+?)(?:;|$)", row["notes"])
            with target.open(newline="", encoding="utf-8") as handle:
                external_rows = list(csv.DictReader(handle, delimiter="\t"))
            matches = [item for item in external_rows if seed and f"seed-key:{seed.group(1)}" in item["notes"]]
            if not any(item["hits"] == row["hits"] and item["screened"] == row["screened"] for item in matches):
                raise RuntimeError(f"external decision home does not cover {row['id']}")
    with (RECORD / "queries.tsv").open(newline="", encoding="utf-8") as handle:
        query_rows = list(csv.DictReader(handle, delimiter="\t"))
    status_text = (RECORD / "status.md").read_text(encoding="utf-8")
    coverage_match = re.search(r"\*\*Coverage through:\*\* (\d{4}-\d{2}-\d{2})", status_text)
    if not coverage_match:
        raise RuntimeError("status has no machine-readable coverage date")
    coverage_date = coverage_match.group(1)
    searches = [row for row in log_rows if row["kind"] == "search" and row["date"] == coverage_date]
    query_ids = {row["query_id"] for row in query_rows}
    search_ids = [row["id"] for row in searches]
    if len(search_ids) != len(set(search_ids)) or not set(search_ids) <= query_ids:
        raise RuntimeError("current checkpoint has duplicate or unregistered search events")
    due_ids = {row["query_id"] for row in query_rows if row["last_reconciled"] == coverage_date}
    if not due_ids <= set(search_ids):
        raise RuntimeError("current checkpoint omits a reconciled standing query")
    ledger_lines = [
        line for line in (RECORD / "README.md").read_text(encoding="utf-8").splitlines()
        if re.match(r"^\| \d{4}-\d{2}-\d{2} \|", line)
    ]
    if not ledger_lines:
        raise RuntimeError("README update ledger has no checkpoint row")
    ledger = [cell.strip() for cell in ledger_lines[-1].split("|")][1:-1]
    if ledger[0] != coverage_date:
        raise RuntimeError("latest update-ledger date differs from status coverage")
    ledger_counts = [int(value.replace(",", "")) for value in ledger[1:6]]
    current_counts = [
        len(catalog), len(included), sum(row["status"] == "deep-read" for row in included),
        sum(row["status"] == "excluded" for row in catalog.values()),
        sum(row["status"] == "parked" for row in catalog.values()),
    ]
    if ledger_counts != current_counts:
        raise RuntimeError("latest update-ledger counts differ from the catalog")
    return {
        "include_level": len(included),
        "deep_read": sum(row["status"] == "deep-read" for row in included),
        "include_by_decade": dict(sorted(by_decade.items())),
        "query_attempts": len(searches),
        "query_successes": sum(not row["hits"].startswith("FAILED") for row in searches),
        **funnel,
    }


CONFIG = {
    "record_dir": RECORD,
    "catalog_columns": [
        "key", "status", "code", "year", "title", "relation", "artifact",
        "execution", "goal", "evidence", "priority", "relevance", "url",
    ],
    "statuses": {"candidate", "screened", "included", "deep-read", "excluded", "parked"},
    "exclusion_codes": {
        "E1-software-or-firmware-only",
        "E2-formal-hardware-without-execution",
        "E3-symbolic-simulation-outside-lineage",
        "E4-analog-physical-or-postsilicon",
        "E5-hardware-accelerates-software",
        "E6-out-of-scope-artifact",
        "E7-secondary-or-insubstantial",
        "E8-duplicate-or-superseded",
        "E9-retracted-or-withdrawn",
    },
    "facets": {
        "relation": {"core", "lineage", "comparator"},
        "artifact": {"rtl", "hdl-other", "hls", "systemc-tlm", "gate-netlist", "mixed-level", "generic"},
        "execution": {"path", "concolic", "fragment", "symbolic-simulation", "ste", "hybrid"},
        "goal": {"functional", "test-coverage", "security", "equivalence", "method-general"},
        "evidence": {"experiment", "case-study", "formal-only", "none"},
    },
    "facet_statuses": {"included", "deep-read"},
    "priorities": {"critical", "high", "medium", "low"},
    "noted_statuses": {"included", "deep-read"},
    "note_required_statuses": set(),
    "claim_required_fields": ["Status", "Statement", "Scope", "Prior frontier"],
    "strict_citation_sections": True,
    "strict_citation_closure": True,
    "citation_closure_exempt_citekeys": {
        "baldoni2016-symbolic", "kolbl2001rtl", "feng2004dynamic",
        "ryan2023sylvia", "yang2026-forbench", "petersen2015mapping",
        "wohlin2014snowballing", "camurati1988formal", "jayasena2024directed",
    },
    "rq_manuscript_file": "manuscript/sections/01-introduction.typ",
    "label_pattern": "(?:sec|tab)-[A-Za-z0-9-]+",
    "extra_reports": [map_report],
    "declared_quantities": [
        {
            "name": "catalog rows",
            "value": "catalog_rows",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"catalog contains ([0-9,]+) records", r"\*\*Catalog records:\*\* ([0-9,]+)"],
        },
        {
            "name": "include-level records",
            "value": "include_level",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) are include-level records", r"\*\*Include-level records:\*\* ([0-9,]+)"],
        },
        {
            "name": "deep-read records",
            "value": "deep_read",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+)\nwere deep-read", r"\*\*Critical deep reads:\*\* ([0-9,]+)"],
        },
        {
            "name": "mapping-depth records",
            "value": lambda report: report["status"]["included"],
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) were retained at mapping depth", r"\*\*Mapping-depth includes:\*\* ([0-9,]+)"],
        },
        {
            "name": "parked records",
            "value": lambda report: report["status"]["parked"],
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) are parked", r"\*\*Parked:\*\* ([0-9,]+)"],
        },
        {
            "name": "excluded records",
            "value": lambda report: report["status"]["excluded"],
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) are excluded", r"\*\*Excluded:\*\* ([0-9,]+)"],
        },
        {
            "name": "query attempts",
            "value": "query_attempts",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"attempted ([0-9,]+)\nstanding queries", r"The ([0-9,]+) registered queries"],
        },
        {
            "name": "successful queries",
            "value": "query_successes",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+)\nreturned result sets", r"produced ([0-9,]+) result sets"],
        },
        {
            "name": "failed queries",
            "value": lambda report: report["query_attempts"] - report["query_successes"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"and ([0-9,]+) failed"],
        },
        {
            "name": "base discovery records",
            "value": "base_records",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) deduplicated database-search records"],
        },
        {
            "name": "chase-only records",
            "value": "chase_records",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+)\nchase-only records", r"([0-9,]+) chase-only records"],
        },
        {
            "name": "Carter-lineage records",
            "value": "carter_records",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) Carter-lineage records"],
        },
        {
            "name": "Forbench bibliography records",
            "value": "forbench_records",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) Forbench bibliography\nrecords", r"([0-9,]+) Forbench bibliography\nrecords"],
        },
        {
            "name": "manual primary additions",
            "value": "manual_records",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) directly inspected primary additions"],
        },
        {
            "name": "core works",
            "value": lambda report: report["relation"]["core"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"consists of ([0-9,]+) core works"],
        },
        {
            "name": "lineage works",
            "value": lambda report: report["relation"]["lineage"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) selective\nlineage works"],
        },
        {
            "name": "comparator works",
            "value": lambda report: report["relation"]["comparator"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) direct comparators"],
        },
        {
            "name": "RTL works",
            "value": lambda report: report["artifact"]["rtl"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) included records execute\nRTL"],
        },
        {
            "name": "SystemC/TLM works",
            "value": lambda report: report["artifact"]["systemc-tlm"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) SystemC/TLM"],
        },
        {
            "name": "mixed-level works",
            "value": lambda report: report["artifact"]["mixed-level"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) mixed-level records"],
        },
        {
            "name": "remaining artifact works",
            "value": lambda report: report["include_level"] - report["artifact"]["rtl"] - report["artifact"]["systemc-tlm"] - report["artifact"]["mixed-level"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"remaining ([0-9,]+)\nspan other HDLs"],
        },
        {
            "name": "path works",
            "value": lambda report: report["execution"]["path"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) works are\npath-oriented"],
        },
        {
            "name": "concolic works",
            "value": lambda report: report["execution"]["concolic"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) concolic"],
        },
        {
            "name": "hybrid works",
            "value": lambda report: report["execution"]["hybrid"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) hybrid"],
        },
        {
            "name": "symbolic-simulation works",
            "value": lambda report: report["execution"]["symbolic-simulation"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) symbolic-simulation systems"],
        },
    ],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
