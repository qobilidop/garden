#!/usr/bin/env python3
"""Declare the hardware-symbolic-execution record contract."""

import sys
from pathlib import Path

RECORD = Path(__file__).resolve().parent
sys.path.insert(0, str(RECORD.parents[2] / "skills" / "run-survey" / "scripts"))

from survey_check import run  # noqa: E402


def q(name, value, surfaces, *patterns):
    return {"name": name, "value": value, "surfaces": surfaces, "patterns": list(patterns)}


METHOD = ["manuscript/sections/03-method.typ"]
STATUS = ["record/status.md"]
METADATA = ["manuscript/metadata.typ"]
INTRODUCTION = ["manuscript/sections/01-introduction.typ"]
EVIDENCE = ["manuscript/sections/09-evidence.typ"]
SYNTHESIS = ["manuscript/sections/10-synthesis.typ"]
LIMITATIONS = ["manuscript/sections/11-limitations.typ"]
CORPUS_MAP = ["manuscript/sections/12-corpus-map.typ"]
CONCLUSION = ["manuscript/sections/13-conclusion.typ"]
METHOD_AND_STATUS = METHOD + STATUS

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
            "equals_events": [
                "2026-08-12|snowball|wsa-strict-back|backward",
                "2026-08-12|snowball|wsa-strict-forward|forward",
                "2026-08-12|snowball|qin-strict-back|backward",
                "2026-08-12|snowball|qin-strict-forward|forward",
                "2026-08-12|snowball|v2c-strict-back|backward",
                "2026-08-12|snowball|v2c-strict-forward|forward",
                "2026-08-12|snowball|sesc-strict-back|backward",
                "2026-08-12|snowball|sesc-strict-forward|forward",
                "2026-08-12|snowball|coppelia-strict-back|backward",
                "2026-08-12|snowball|coppelia-strict-forward|forward",
                "2026-08-12|snowball|eisec-strict-back|backward",
                "2026-08-12|snowball|eisec-strict-forward|forward",
                "2026-08-12|snowball|riscv-case-strict-back|backward",
                "2026-08-12|snowball|riscv-case-strict-forward|forward",
                "2026-08-12|snowball|autoverifix-strict-back|backward",
                "2026-08-12|snowball|autoverifix-strict-forward|forward",
                "2026-08-12|snowball|hls-tcp-strict-back|backward",
                "2026-08-12|snowball|hls-tcp-strict-forward|forward",
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
            "classifier_transition_counts": {
                "status": 0, "code": 38, "priority": 10,
                "code_priority": 2,
            },
        },
    ],
    "audit_transition_contracts": [
        {
            "id": "classifier-delta-btor2c",
            "pattern": (
                r"intermediate correction ([^/;]+)/([^/;]+)/([^ ;]+) -> "
                r"([^/;]+)/([^/;]+)/([^;]+)(?:;|$)"
            ),
            "keys": ["doi:10.1007/s10009-026-00847-z"],
            "old": ["excluded", "E7", "low"],
            "new": ["excluded", "E2", "low"],
            "catalog_new": ["excluded", "E2-formal-hardware-without-execution", "low"],
        },
    ],
    "required_audit_ids": [
        "classifier-delta-btor2c", "adversarial-log-normalization",
        "sylvia-external-decision-binding",
    ],
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
        q("catalog rows", "catalog_rows", METHOD_AND_STATUS,
          r"catalog contains ([0-9,]+) records", r"catalog holds ([0-9,]+) works"),
        q("include-level records", "include_level",
          METHOD_AND_STATUS + METADATA + INTRODUCTION + CORPUS_MAP + CONCLUSION,
          r"([0-9,]+) are include-level publication records",
          r"for ([0-9,]+) include-level publication records",
          r"yield ([0-9,]+) full-text-qualified publication records",
          r"Its ([0-9,]+)-record strict corpus",
          r"complete ([0-9,]+)-publication map",
          r"contains ([0-9,]+) full-text-qualified publication records",
          r"The ([0-9,]+) include preprints", r"all ([0-9,]+) rows"),
        q("deep reads", "deep_read",
          METHOD_AND_STATUS + EVIDENCE + SYNTHESIS + CORPUS_MAP,
          r"([0-9,]+)\nwere deep-read", r"([0-9,]+) deep-read",
          r"the ([0-9,]+) load-bearing works", r"The ([0-9,]+) deep-read studies",
          r"Among the ([0-9,]+) deep reads", r"among the ([0-9,]+) deep reads",
          r"([0-9,]+) source-anchored technical readings",
          r"all ([0-9,]+) critical deep reads"),
        q("mapping includes", lambda report: report["status"]["included"],
          METHOD_AND_STATUS + LIMITATIONS + CORPUS_MAP,
          r"([0-9,]+) were retained at mapping depth",
          r"([0-9,]+) included at mapping depth",
          r"retains ([0-9,]+)\nworks only at mapping depth",
          r"from the ([0-9,]+)\nmapping-only"),
        q("parked", lambda report: report["status"]["parked"],
          METHOD_AND_STATUS + LIMITATIONS,
          r"([0-9,]+) are parked", r"([0-9,]+) parked",
          r"([0-9,]+) such or",
          r"Re-screen the ([0-9,]+) parked records"),
        q("excluded", lambda report: report["status"]["excluded"], METHOD_AND_STATUS,
          r"([0-9,]+) are excluded", r"([0-9,]+) excluded"),
        q("source notes", "source_notes", STATUS,
          r"holds ([0-9,]+) survey-specific notes"),
        q("full-text notes", lambda report: report["read_depth"]["full-text"], STATUS,
          r"([0-9,]+) full-text"),
        q("abstract-only notes", lambda report: report["read_depth"]["abstract-only"], STATUS,
          r"([0-9,]+) abstract-only"),
        q("evidence records", "evidence_records", STATUS,
          r"evidence ledger contains\n([0-9,]+) certainty-graded"),
        q("broad active queries", lambda report: report["query_checkpoint_counts"]["broad"],
          METHOD + STATUS + METADATA,
          r"([0-9,]+) broad active", r"([0-9,]+) broad searches"),
        q("strict reconciled queries", lambda report: report["query_checkpoint_counts"]["strict"],
          METHOD + STATUS + METADATA,
          r"([0-9,]+) added strict-boundary", r"([0-9,]+) strict queries",
          r"([0-9,]+) strict-boundary\s+searches", r"; ([0-9,]+) queries reconciled"),
        q("failed strict queries", lambda report: report["query_attempts"] - report["query_successes"],
          METHOD + METADATA + LIMITATIONS + CONCLUSION,
          r"([0-9,]+) failed with HTTP", r"([0-9,]+) strict query\n  failed",
          r"([0-9,]+) strict Semantic Scholar query failed",
          r"with ([0-9,]+)\nfailed query"),
        q("query attempts", "query_attempts", METHOD,
          r"revision attempted ([0-9,]+) boundary-focused queries"),
        q("query successes", "query_successes", METHOD,
          r"([0-9,]+) returned result sets"),
        q("database records", "base_records", METHOD, r"([0-9,]+) deduplicated database-search records"),
        q("chase records", "chase_records", METHOD, r"([0-9,]+)\nchase-only records"),
        q("Carter records", "carter_records", METHOD, r"([0-9,]+) Carter-lineage records"),
        q("Forbench records", "forbench_records", METHOD, r"([0-9,]+) Forbench bibliography\nrecords"),
        q("manual records", "manual_records", METHOD, r"([0-9,]+) directly inspected primary additions"),
        q("baseline records", "baseline_records", METHOD,
          r"baseline of\n([0-9,]+)"),
        q("strict additions", lambda report: report["catalog_additions"]["strict-boundary-reconciliation"],
          METHOD, r"contributed ([0-9,]+) new catalog records"),
        q("critical chase additions", lambda report: report["catalog_additions"]["strict-critical-chase-additions"],
          METHOD, r"chases added ([0-9,]+) records"),
        q("critical chase rescreen", lambda report: report["audit_groups"]["critical-chase-rescreen-batch-"],
          METHOD, r"all ([0-9,]+) were subsequently",
          r"all ([0-9,]+) records"),
        q("rationale repairs", lambda report: report["audit_groups"]["critical-rationale-repair-batch-"],
          METHOD, r"rejected ([0-9,]+) still-template-shaped", r"exact ([0-9,]+)-record repair"),
        q("primary bibliography additions", lambda report: report["catalog_additions"]["critical-primary-bibliography-additions"],
          METHOD, r"seeds added ([0-9,]+) further records"),
        q("method-source additions", lambda report: report["catalog_additions"]["local-method-source-reconciliation"],
          METHOD, r"Finally, ([0-9,]+) methodology works"),
        q("Sylvia delegated addition", lambda report: report["catalog_additions"]["sylvia-external-decision-binding"],
          METHOD, r"added ([0-9,]+) previously absent boundary comparator"),
        q("addition batches", "catalog_addition_batches", METHOD,
          r"all ([0-9,]+) addition batches"),
        q("classical", lambda report: report["execution"]["classical"],
          METHOD_AND_STATUS + METADATA, r"([0-9,]+) classical", r"([0-9,]+) are classical"),
        q("concolic", lambda report: report["execution"]["concolic"],
          METHOD_AND_STATUS + METADATA, r"([0-9,]+)\s+concolic"),
        q("selective", lambda report: report["execution"]["selective-hybrid"],
          METHOD_AND_STATUS + METADATA, r"([0-9,]+) selective-hybrid"),
        q("RTL", lambda report: report["artifact"]["rtl"], METHOD + METADATA,
          r"([0-9,]+) claim about RTL", r"target for ([0-9,]+)"),
        q("SystemC", lambda report: report["artifact"]["systemc-tlm"], METHOD, r"([0-9,]+)\nabout SystemC/TLM"),
        q("mixed level", lambda report: report["artifact"]["mixed-level"], METHOD, r"([0-9,]+) about coupled mixed-level models"),
        q("other HDL", lambda report: report["artifact"]["hdl-other"], METHOD,
          r"comprise ([0-9,]+) other-HDL work"),
        q("HLS", lambda report: report["artifact"]["hls"], METHOD + METADATA,
          r"([0-9,]+) HLS-source work", r"([0-9,]+) hardware-specific HLS study"),
        q("gate netlist", lambda report: report["artifact"]["gate-netlist"], METHOD,
          r"and ([0-9,]+) gate-netlist work"),
    ],
}

if __name__ == "__main__":
    sys.exit(run(CONFIG))
