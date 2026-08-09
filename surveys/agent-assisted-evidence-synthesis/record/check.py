#!/usr/bin/env python3
"""Validate this survey record via the shared engine and print derived counts."""

import sys
from pathlib import Path

RECORD = Path(__file__).resolve().parent
sys.path.insert(0, str(RECORD.parents[2] / "skills" / "run-survey" / "scripts"))

from survey_check import run  # noqa: E402

FACET_FIELDS = ["stage", "contribution", "evidence", "setting"]


def stage_cross_table(catalog):
    # Include-level rows: deep-read is a scrutiny level above included,
    # so map-level counts cover both statuses.
    included = [
        row for row in catalog.values()
        if row["status"] in ("included", "deep-read")
    ]
    table = {}
    for stage in sorted({"search", "screen", "extract", "appraise", "synthesize", "report", "end2end", "meta"}):
        rows = [row for row in included if row["stage"] == stage]
        table[stage] = {
            "med": sum(row["setting"] == "med" for row in rows),
            "se": sum(row["setting"] == "se" for row in rows),
            "general": sum(row["setting"] == "general" for row in rows),
            "total": len(rows),
            "human-agree": sum(row["evidence"] == "human-agree" for row in rows),
            "benchmark": sum(row["evidence"] == "benchmark" for row in rows),
            "none": sum(row["evidence"] == "none" for row in rows),
        }
    return {"stage_cross_table": table}


CONFIG = {
    "record_dir": RECORD,
    "catalog_columns": ["key", "status", "code", "year", "title", *FACET_FIELDS, "priority"],
    "statuses": {"included", "deep-read", "excluded", "parked"},
    "exclusion_codes": {
        "E1-primary-research-automation",
        "E2-generic-nlp-no-synthesis-framing",
        "E3-opinion-without-guidance",
        "E4-before-window",
        "E5-insufficient-metadata",
        "E6-duplicate-or-superseded",
        "E7-retracted-or-withdrawn",
    },
    "priorities": {"critical", "high", "medium", "low"},
    "status_required_fields": {
        "included": ["year", "title", *FACET_FIELDS],
        "deep-read": ["year", "title", *FACET_FIELDS],
    },
    "status_forbidden_fields": {
        "excluded": ["year", "title", *FACET_FIELDS],
        "parked": ["year", "title", *FACET_FIELDS],
    },
    "facets": {
        "stage": {"search", "screen", "extract", "appraise", "synthesize", "report", "end2end", "meta"},
        "contribution": {"method", "system", "evaluation", "guideline", "position"},
        "evidence": {"human-agree", "benchmark", "none"},
        "setting": {"med", "se", "general"},
    },
    "facet_statuses": {"included", "deep-read"},
    "noted_statuses": {"included", "deep-read"},
    "claim_required_fields": ["Status", "Statement", "Scope"],
    "extra_reports": [stage_cross_table],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
