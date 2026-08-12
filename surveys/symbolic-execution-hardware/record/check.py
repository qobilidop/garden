#!/usr/bin/env python3
"""Declare the hardware-symbolic-execution record contract."""

import sys
from pathlib import Path

RECORD = Path(__file__).resolve().parent
sys.path.insert(0, str(RECORD.parents[2] / "skills" / "run-survey" / "scripts"))

from survey_check import run  # noqa: E402


def q(name, value, surfaces, *patterns):
    return {"name": name, "value": value, "surfaces": surfaces, "patterns": list(patterns)}


MANUSCRIPT_AND_STATUS = ["manuscript/sections/03-method.typ", "record/status.md"]
METHOD = ["manuscript/sections/03-method.typ"]

CONFIG = {
    "record_dir": RECORD,
    "catalog_columns": [
        "key", "status", "code", "year", "title", "relation", "artifact",
        "execution", "goal", "evidence", "priority", "relevance", "url",
    ],
    "statuses": {"candidate", "screened", "included", "deep-read", "excluded", "parked"},
    "exclusion_codes": {
        "E1-software-or-firmware-only", "E2-formal-hardware-without-execution",
        "E3-symbolic-method-without-path-execution", "E4-analog-physical-or-postsilicon",
        "E5-hardware-accelerates-software", "E6-out-of-scope-artifact",
        "E7-secondary-or-insubstantial", "E8-duplicate-or-superseded",
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
    "include_level_statuses": {"included", "deep-read"},
    "priorities": {"critical", "high", "medium", "low"},
    "noted_statuses": {"included", "deep-read", "excluded"},
    "note_required_statuses": {"deep-read"},
    "claim_required_fields": ["Status", "Statement", "Scope", "Prior frontier"],
    "strict_citation_sections": True,
    "strict_citation_closure": True,
    "citation_closure_exempt_sections": {
        citekey: {"sec-lineages"} for citekey in {
            "bagri2015restrictive", "lyu2017quebs", "pinto2017factored",
            "lin2018ctsc", "ahmed2018trojan", "lyu2019multitarget",
            "lin2020selective", "jayasena2021assertions", "lyu2021soccar",
            "lyu2021fuce", "roy2023slec", "zheng2024incremental",
        }
    } | {
        "camurati1988formal": {"sec-boundary"},
        "jayasena2024directed": {"sec-boundary"},
    },
    "rq_manuscript_file": "manuscript/sections/01-introduction.typ",
    "label_pattern": "(?:sec|tab)-[A-Za-z0-9-]+",
    "validate_screened_partitions": True,
    "audit_partition_groups": [
        {
            "prefix": "critical-chase-rescreen-batch-", "rows": 3, "total": 161,
            "equals_event_ids": [
                "wsa-strict-back", "wsa-strict-forward",
                "qin-strict-back", "qin-strict-forward",
                "v2c-strict-back", "v2c-strict-forward",
                "sesc-strict-back", "sesc-strict-forward",
                "coppelia-strict-back", "coppelia-strict-forward",
                "eisec-strict-back", "eisec-strict-forward",
                "riscv-case-strict-back", "riscv-case-strict-forward",
                "autoverifix-strict-back", "autoverifix-strict-forward",
                "hls-tcp-strict-back", "hls-tcp-strict-forward",
            ],
            "status_counts": {"excluded": 159, "parked": 2},
            "rationale_unique": True,
            "rationale_forbid_fragments": [
                "analyzes software, firmware, binaries, or the software symbolic-execution engine",
                "contributes formal semantics, model/property checking, assertions, invariants",
                "uses concrete simulation, random testing, fuzzing, or heuristic search",
                "is a survey, foundation, standard, benchmark, tool description, or contextual source",
                "duplicate, reprint, or superseded version of the already cataloged contribution titled",
            ],
        },
        {
            "prefix": "critical-rationale-repair-batch-", "rows": 3, "total": 138,
            "subset_of_prefix": "critical-chase-rescreen-batch-",
        },
        {
            "prefix": "classifier-delta-group-", "rows": 14, "total": 46,
            "subset_of_prefix": "critical-chase-rescreen-batch-",
            "require_reclassified_markers": True,
            "classifier_transition_counts": {"status": 0, "code": 38, "priority": 10},
        },
    ],
    "required_audit_ids": ["classifier-delta-btor2c", "adversarial-log-normalization"],
    "funnel_audit_ids": {
        "base_records": "base-screen-a", "chase_records": "snowball-screening",
        "carter_records": "carter-screening", "forbench_records": "forbench-screening",
        "manual_records": "manual-primary-additions",
    },
    "query_checkpoint_fields": {
        "broad": "Broad searches through", "strict": "Strict searches through",
    },
    "expected_unreconciled_queries": {"s25"},
    "query_attempt_checkpoint": "strict",
    "update_ledger_report_keys": [
        "catalog_rows", "include_level", "deep_read", "status.excluded", "status.parked",
    ],
    "require_declared_quantity_match": True,
    "declared_quantities": [
        q("catalog rows", "catalog_rows", MANUSCRIPT_AND_STATUS,
          r"catalog contains ([0-9,]+) records", r"catalog holds ([0-9,]+) works"),
        q("include-level records", "include_level", MANUSCRIPT_AND_STATUS,
          r"([0-9,]+) are include-level publication records", r"for ([0-9,]+) include-level"),
        q("deep reads", "deep_read", MANUSCRIPT_AND_STATUS,
          r"([0-9,]+)\nwere deep-read", r"([0-9,]+) deep-read"),
        q("mapping includes", lambda report: report["status"]["included"], MANUSCRIPT_AND_STATUS,
          r"([0-9,]+) were retained at mapping depth", r"([0-9,]+) included at mapping depth"),
        q("parked", lambda report: report["status"]["parked"], MANUSCRIPT_AND_STATUS,
          r"([0-9,]+) are parked", r"([0-9,]+) parked"),
        q("excluded", lambda report: report["status"]["excluded"], MANUSCRIPT_AND_STATUS,
          r"([0-9,]+) are excluded", r"([0-9,]+) excluded"),
        q("query attempts", "query_attempts", METHOD,
          r"revision attempted ([0-9,]+) boundary-focused queries"),
        q("query successes", "query_successes", METHOD,
          r"([0-9,]+) returned result sets"),
        q("database records", "base_records", METHOD, r"([0-9,]+) deduplicated database-search records"),
        q("chase records", "chase_records", METHOD, r"([0-9,]+)\nchase-only records"),
        q("Carter records", "carter_records", METHOD, r"([0-9,]+) Carter-lineage records"),
        q("Forbench records", "forbench_records", METHOD, r"([0-9,]+) Forbench bibliography\nrecords"),
        q("manual records", "manual_records", METHOD, r"([0-9,]+) directly inspected primary additions"),
        q("classical", lambda report: report["execution"]["classical"], MANUSCRIPT_AND_STATUS, r"([0-9,]+) classical"),
        q("concolic", lambda report: report["execution"]["concolic"], MANUSCRIPT_AND_STATUS, r"([0-9,]+)\s+concolic"),
        q("selective", lambda report: report["execution"]["selective-hybrid"], MANUSCRIPT_AND_STATUS, r"([0-9,]+) selective-hybrid"),
        q("RTL", lambda report: report["artifact"]["rtl"], METHOD, r"([0-9,]+) claim about RTL"),
        q("SystemC", lambda report: report["artifact"]["systemc-tlm"], METHOD, r"([0-9,]+)\nabout SystemC/TLM"),
        q("mixed level", lambda report: report["artifact"]["mixed-level"], METHOD, r"([0-9,]+) about coupled mixed-level models"),
    ],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
