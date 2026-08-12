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
    search_match = re.search(r"\*\*Search through:\*\* (\d{4}-\d{2}-\d{2})", status_text)
    if not search_match:
        raise RuntimeError("status has no machine-readable standing-search date")
    search_date = search_match.group(1)
    searches = [row for row in log_rows if row["kind"] == "search" and row["date"] == search_date]
    query_ids = {row["query_id"] for row in query_rows}
    search_ids = [row["id"] for row in searches]
    if len(search_ids) != len(set(search_ids)) or not set(search_ids) <= query_ids:
        raise RuntimeError("current checkpoint has duplicate or unregistered search events")
    due_ids = {row["query_id"] for row in query_rows if row["last_reconciled"] == search_date}
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
        "E3-symbolic-method-without-path-execution",
        "E4-analog-physical-or-postsilicon",
        "E5-hardware-accelerates-software",
        "E6-out-of-scope-artifact",
        "E7-secondary-or-insubstantial",
        "E8-duplicate-or-superseded",
        "E9-retracted-or-withdrawn",
    },
    "facets": {
        "relation": {"core"},
        "artifact": {"rtl", "hdl-other", "hls", "systemc-tlm", "gate-netlist", "mixed-level", "generic"},
        "execution": {"classical", "concolic", "selective-hybrid"},
        "goal": {"functional", "test-coverage", "security", "equivalence", "method-general"},
        "evidence": {"experiment", "case-study", "formal-only", "none"},
    },
    "facet_statuses": {"included", "deep-read"},
    "priorities": {"critical", "high", "medium", "low"},
    # Two excluded boundary works retain notes because the manuscript uses
    # their mechanisms to make the negative boundary auditable.
    "noted_statuses": {"included", "deep-read", "excluded"},
    "note_required_statuses": set(),
    "claim_required_fields": ["Status", "Statement", "Scope", "Prior frontier"],
    "strict_citation_sections": True,
    "strict_citation_closure": True,
    "citation_closure_exempt_citekeys": {
        "baldoni2016-symbolic", "carter1979symbolic", "kolbl2001rtl",
        "feng2004dynamic", "debnath2022greycone", "yang2026-forbench",
        "ryan2023sylvia", "bagri2015restrictive", "lyu2017quebs",
        "pinto2017factored", "shen2018trojan", "lin2018ctsc",
        "zhang2018recursive", "ahmed2018trojan", "lyu2019multitarget",
        "lin2020selective", "jayasena2021assertions", "lyu2021soccar",
        "lyu2021fuce", "roy2023slec", "zheng2024incremental",
        "petersen2015mapping", "wohlin2014snowballing",
        "camurati1988formal", "jayasena2024directed",
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
            "patterns": [r"revision attempted ([0-9,]+) boundary-focused queries", r"The strict revision attempted ([0-9,]+) queries"],
        },
        {
            "name": "successful queries",
            "value": "query_successes",
            "surfaces": ["manuscript/sections/03-method.typ", "record/status.md"],
            "patterns": [r"([0-9,]+) returned result sets", r"([0-9,]+) produced result sets"],
        },
        {
            "name": "failed queries",
            "value": lambda report: report["query_attempts"] - report["query_successes"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) failed with HTTP 429"],
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
            "name": "RTL works",
            "value": lambda report: report["artifact"]["rtl"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) execute RTL"],
        },
        {
            "name": "SystemC/TLM works",
            "value": lambda report: report["artifact"]["systemc-tlm"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) execute SystemC/TLM"],
        },
        {
            "name": "mixed-level works",
            "value": lambda report: report["artifact"]["mixed-level"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) execute coupled mixed-level models"],
        },
        {
            "name": "remaining artifact works",
            "value": lambda report: (
                report["include_level"] - report["artifact"]["rtl"]
                - report["artifact"]["systemc-tlm"] - report["artifact"]["mixed-level"]
            ),
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"The remaining ([0-9,]+) are one each"],
        },
        {
            "name": "classical works",
            "value": lambda report: report["execution"]["classical"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) classical"],
        },
        {
            "name": "concolic works",
            "value": lambda report: report["execution"]["concolic"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) concolic"],
        },
        {
            "name": "selective-hybrid works",
            "value": lambda report: report["execution"]["selective-hybrid"],
            "surfaces": ["manuscript/sections/03-method.typ"],
            "patterns": [r"([0-9,]+) selective-hybrid"],
        },
    ],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
