#!/usr/bin/env python3
"""Validate this survey record via the shared engine and print derived counts."""

import sys
from collections import Counter
from pathlib import Path

RECORD = Path(__file__).resolve().parent
sys.path.insert(0, str(RECORD.parents[2] / "skills" / "run-survey" / "scripts"))

from survey_check import run  # noqa: E402


def cluster_report(catalog):
    deep = Counter(row["cluster"] for row in catalog.values() if row["status"] == "deep-read")
    return {"deep_read_clusters": dict(sorted(deep.items()))}


CONFIG = {
    "record_dir": RECORD,
    "catalog_columns": ["key", "status", "code", "year", "title", "cluster", "priority", "relevance", "url"],
    "statuses": {"candidate", "screened", "deep-read", "excluded", "parked"},
    "exclusion_codes": {
        "E1-def-use-testing",
        "E2-ml-graph-runtime",
        "E3-secondary",
        "E4-application-only",
        "E5-unobtainable",
        "E6-out-of-scope-model",
        "E7-duplicate-version",
        "E8-retracted",
    },
    "priorities": {"critical", "high", "medium", "low"},
    "noted_statuses": {"deep-read", "screened"},
    "note_required_statuses": {"deep-read"},
    "claim_required_fields": ["Status", "Statement", "Scope", "Prior frontier"],
    "strict_citation_sections": True,
    "strict_citation_closure": True,
    "rq_manuscript_file": "manuscript/sections/01-introduction.typ",
    "label_pattern": "sec-[A-Za-z0-9-]+",
    "extra_reports": [cluster_report],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
