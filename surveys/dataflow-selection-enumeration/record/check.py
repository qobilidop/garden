#!/usr/bin/env python3
"""Validate the survey catalog, audited log, and evidence surfaces."""

import csv
from datetime import date
from pathlib import Path
import re
import sys


csv.field_size_limit(sys.maxsize)


ROOT = Path(__file__).resolve().parents[1]
SURVEY = ROOT / "record"
CATALOG_HEADER = [
    "citekey",
    "year",
    "cluster",
    "status",
    "priority",
    "venue",
    "primary_url",
    "relevance",
    "code",
]
LOG_HEADER = [
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
EVIDENCE_HEADER = [
    "evidence_id",
    "supports_claims",
    "manuscript_anchors",
    "literature_claim",
    "citekeys",
    "source_note_anchors",
    "evidence_scope",
    "caveat",
]
QUERIES_HEADER = [
    "query_id",
    "source",
    "theme",
    "query",
    "limit",
    "active",
    "last_reconciled",
    "notes",
]
BACKWARD_DEFECT_MARKERS = (
    "unresolved",
    "index omits",
    "exposes no references",
    "wrong-version",
    "primary list is longer",
    "incomplete bibliography",
    "truncated bibliography",
)
CURRENT_SOURCE_TEMPLATE = "- **Template version:** 2"
CURRENT_SOURCE_REQUIRED = (
    "- **Status:**",
    "- **Primary source:**",
    "- **Version read:**",
    "- **Last reviewed:**",
    "- **Bibliography key:**",
    "### What is directly established by the work?",
    "### What is our interpretation or inference?",
    "## Evidence locations",
    "## Update impact",
    "- **Syntheses affected:**",
    "- **Claims affected:**",
    "- **Manuscript action:**",
)


def rows(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source, dialect="excel-tab")
        return reader.fieldnames or [], list(reader)


def keys(field: str) -> list[str]:
    return [] if field == "-" else field.split(",")


def markdown_heading_anchors(text: str) -> set[str]:
    """Return GitHub-style fragments for the simple headings in source notes."""
    anchors: set[str] = set()
    occurrences: dict[str, int] = {}
    for match in re.finditer(r"^#{1,6}\s+(.+?)\s*$", text, re.MULTILINE):
        heading = re.sub(r"[`*_~]", "", match.group(1)).lower()
        base = re.sub(r"[^\w\s-]", "", heading)
        base = re.sub(r"\s+", "-", base.strip())
        duplicate = occurrences.get(base, 0)
        occurrences[base] = duplicate + 1
        anchors.add(base if duplicate == 0 else f"{base}-{duplicate}")
    return anchors


def research_questions(text: str) -> dict[str, str]:
    """Extract wrapped Markdown/Typst RQ bullets into normalized sentences."""
    lines = text.splitlines()
    extracted: dict[str, str] = {}
    index = 0
    while index < len(lines):
        match = re.match(
            r"^- \*{1,2}(RQ\d+):\*{1,2}\s+(.+)$", lines[index]
        )
        if match is None:
            index += 1
            continue
        identifier, first = match.groups()
        parts = [first.strip()]
        index += 1
        while index < len(lines) and lines[index].startswith("  "):
            parts.append(lines[index].strip())
            index += 1
        extracted[identifier] = " ".join(parts)
    return extracted


def seed_key(notes: str) -> str | None:
    match = re.search(r"(?:^|; )seed-key:([A-Za-z0-9_.-]+)(?:;|$)", notes)
    return match.group(1) if match else None


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def main() -> int:
    markdown_paths = sorted((ROOT / "record").rglob("*.md"))
    for markdown in markdown_paths:
        text = markdown.read_text(encoding="utf-8")
        for target in re.findall(r"\]\(([^)]+)\)", text):
            if target.startswith(("#", "http://", "https://", "mailto:")):
                continue
            local = target.split("#", 1)[0]
            if local.startswith("<") and local.endswith(">"):
                local = local[1:-1]
            if local and not (markdown.parent / local).exists():
                fail(
                    f"broken local link in {markdown.relative_to(ROOT)}: {target}"
                )

    header, catalog_rows = rows(SURVEY / "catalog.tsv")
    if header != CATALOG_HEADER:
        fail(f"unexpected catalog header: {header}")
    catalog = {row["citekey"]: row for row in catalog_rows}
    if len(catalog) != len(catalog_rows):
        fail("catalog contains duplicate citekeys")

    bibliography = (ROOT / "manuscript" / "references.bib").read_text(encoding="utf-8")
    bibliography_keys = set(re.findall(r"@[A-Za-z]+\{([^,]+),", bibliography))
    for source_note in sorted((SURVEY / "sources").glob("*.md")):
        if source_note.name == "_template.md":
            continue
        source_text = source_note.read_text(encoding="utf-8")
        if CURRENT_SOURCE_TEMPLATE not in source_text:
            continue
        for required in CURRENT_SOURCE_REQUIRED:
            if required not in source_text:
                fail(
                    f"current-template source note {source_note.name} "
                    f"is missing {required}"
                )
        reviewed = re.search(r"^- \*\*Last reviewed:\*\* (\S+)", source_text, re.MULTILINE)
        if reviewed is None:
            fail(f"current-template source note {source_note.name} has no review date")
        try:
            date.fromisoformat(reviewed.group(1))
        except ValueError:
            fail(
                f"current-template source note {source_note.name} has invalid "
                f"review date {reviewed.group(1)}"
            )
    for citekey, row in catalog.items():
        source_note = SURVEY / "sources" / f"{citekey}.md"
        if source_note.is_file() and row["status"] != "excluded":
            status_match = re.search(
                r"^- \*\*Status:\*\* (candidate|screened|deep-read|excluded)\b",
                source_note.read_text(encoding="utf-8"),
                flags=re.MULTILINE,
            )
            if status_match and status_match.group(1) != row["status"]:
                fail(
                    f"catalog/source-note status mismatch for {citekey}: "
                    f"{row['status']} != {status_match.group(1)}"
                )
        if row["status"] != "deep-read":
            continue
        if not source_note.is_file():
            fail(f"deep-read work {citekey} has no source note")
        if citekey not in bibliography_keys:
            fail(f"deep-read work {citekey} has no bibliography entry")

    claims_text = (ROOT / "record" / "claims.md").read_text(encoding="utf-8")
    current_claims = claims_text.split(
        "## Current survey synthesis claims", maxsplit=1
    )[-1]
    synthesis_claims = set(
        re.findall(r"^### (C\d{2})\s+—", current_claims, re.MULTILINE)
    )
    if not synthesis_claims:
        fail("claims ledger has no current Cxx synthesis claims")

    manuscript_paths = sorted((ROOT / "manuscript").rglob("*.typ"))
    manuscript_texts = {
        path: path.read_text(encoding="utf-8") for path in manuscript_paths
    }
    manuscript_labels: set[str] = set()
    manuscript_citation_pairs: set[tuple[str, str]] = set()
    for path, text in manuscript_texts.items():
        labels = [
            (match.start(), match.group(1))
            for match in re.finditer(r"<(sec-[A-Za-z0-9-]+)>", text)
        ]
        manuscript_labels.update(label for _, label in labels)
        for citation in re.finditer(r"@([A-Za-z0-9_-]+)", text):
            citekey = citation.group(1)
            if citekey not in bibliography_keys:
                continue
            enclosing = [
                label for position, label in labels if position < citation.start()
            ]
            if not enclosing:
                fail(
                    "bibliography citation outside a labeled manuscript section: "
                    f"{citekey} in {path.relative_to(ROOT)}"
                )
            manuscript_citation_pairs.add((enclosing[-1], citekey))

    protocol_rqs = research_questions(
        (SURVEY / "protocol.md").read_text(encoding="utf-8")
    )
    introduction_rqs = research_questions(
        (ROOT / "manuscript" / "sections" / "01-introduction.typ").read_text(
            encoding="utf-8"
        )
    )
    expected_rq_ids = {"RQ1", "RQ2", "RQ3", "RQ4"}
    if set(protocol_rqs) != expected_rq_ids:
        fail("protocol must define exactly RQ1 through RQ4")
    if protocol_rqs != introduction_rqs:
        differing = sorted(set(protocol_rqs) ^ set(introduction_rqs))
        if not differing:
            differing = sorted(
                identifier
                for identifier in protocol_rqs
                if protocol_rqs[identifier] != introduction_rqs[identifier]
            )
        fail(f"protocol/manuscript research-question drift: {differing[0]}")

    header, evidence_rows = rows(SURVEY / "evidence.tsv")
    if header != EVIDENCE_HEADER:
        fail(f"unexpected evidence header: {header}")
    evidence_ids: set[str] = set()
    supported_claims: set[str] = set()
    covered_citation_pairs: set[tuple[str, str]] = set()
    source_anchor_cache: dict[str, set[str]] = {}
    for number, row in enumerate(evidence_rows, start=2):
        evidence_id = row["evidence_id"]
        if not re.fullmatch(r"E\d{3}", evidence_id):
            fail(f"invalid evidence ID on row {number}: {evidence_id}")
        if evidence_id in evidence_ids:
            fail(f"duplicate evidence ID on row {number}: {evidence_id}")
        evidence_ids.add(evidence_id)

        row_claims = keys(row["supports_claims"])
        if len(row_claims) != len(set(row_claims)):
            fail(f"evidence row {number} repeats a supported claim")
        for claim_id in row_claims:
            if claim_id not in synthesis_claims:
                fail(f"evidence row {number} supports unknown claim {claim_id}")
            supported_claims.add(claim_id)

        row_anchors = keys(row["manuscript_anchors"])
        if len(row_anchors) != len(set(row_anchors)):
            fail(f"evidence row {number} repeats a manuscript anchor")
        for anchor in row_anchors:
            if anchor not in manuscript_labels:
                fail(f"evidence row {number} uses unknown manuscript anchor {anchor}")
        if not row_claims and not row_anchors:
            fail(f"evidence row {number} supports neither a claim nor the manuscript")
        for field in ("literature_claim", "evidence_scope", "caveat"):
            if not row[field].strip():
                fail(f"evidence row {number} has empty {field}")

        row_keys = keys(row["citekeys"])
        if not row_keys:
            fail(f"evidence row {number} has no citekeys")
        if len(row_keys) != len(set(row_keys)):
            fail(f"evidence row {number} repeats a citekey")
        source_references = row["source_note_anchors"].split(";")
        references_by_key: dict[str, str] = {}
        for reference in source_references:
            match = re.fullmatch(
                r"sources/([A-Za-z0-9_.-]+)\.md#([A-Za-z0-9_.-]+)",
                reference,
            )
            if match is None:
                fail(f"invalid source-note anchor on evidence row {number}: {reference}")
            citekey, anchor = match.groups()
            if citekey in references_by_key:
                fail(f"duplicate source-note anchor for {citekey} on row {number}")
            references_by_key[citekey] = anchor
        for citekey in row_keys:
            if citekey not in bibliography_keys:
                fail(f"evidence row {number} cites unknown bibliography key {citekey}")
            source_note = SURVEY / "sources" / f"{citekey}.md"
            if not source_note.is_file():
                fail(f"evidence row {number} cites {citekey} without a source note")
            if citekey not in references_by_key:
                fail(f"evidence row {number} has no source-note anchor for {citekey}")
            if citekey not in source_anchor_cache:
                source_anchor_cache[citekey] = markdown_heading_anchors(
                    source_note.read_text(encoding="utf-8")
                )
            anchor = references_by_key[citekey]
            if anchor not in source_anchor_cache[citekey]:
                fail(
                    f"evidence row {number} uses missing anchor "
                    f"sources/{citekey}.md#{anchor}"
                )
        extra_source_keys = sorted(set(references_by_key) - set(row_keys))
        if extra_source_keys:
            fail(
                f"evidence row {number} anchors unlisted citekey "
                f"{extra_source_keys[0]}"
            )

        row_key_set = set(row_keys)
        for anchor in row_anchors:
            matching_pairs = {
                pair
                for pair in manuscript_citation_pairs
                if pair[0] == anchor and pair[1] in row_key_set
            }
            if not matching_pairs:
                fail(
                    f"evidence row {number} has no cited source at manuscript "
                    f"anchor {anchor}"
                )
            covered_citation_pairs.update(matching_pairs)

    missing_claims = sorted(synthesis_claims - supported_claims)
    if missing_claims:
        fail(f"synthesis claim has no evidence row: {missing_claims[0]}")
    missing_evidence = sorted(manuscript_citation_pairs - covered_citation_pairs)
    if missing_evidence:
        anchor, citekey = missing_evidence[0]
        fail(f"manuscript citation has no evidence row at {anchor}: {citekey}")

    header, log_rows = rows(SURVEY / "log.tsv")
    if header != LOG_HEADER:
        fail(f"unexpected log header: {header}")
    promoted_keys = {
        match
        for row in log_rows
        for match in re.findall(r"(?:^|; )promoted-key:([A-Za-z0-9_.-]+)", row["notes"])
    }
    superseded_keys = {
        match
        for row in log_rows
        for match in re.findall(r"(?:^|; )superseded-key:([A-Za-z0-9_.-]+)", row["notes"])
    }
    if promoted_keys & superseded_keys:
        fail(f"disposition audit both promotes and supersedes {sorted(promoted_keys & superseded_keys)[0]}")
    for row in log_rows:
        markers = re.findall(
            r"(?:^|; )(?:promoted|superseded)-key:([A-Za-z0-9_.-]+)",
            row["notes"],
        )
        if markers and row["kind"] != "audit":
            fail(f"disposition reconciliation is not an audit row: {row['id']}")
    for citekey in promoted_keys:
        if citekey not in catalog or catalog[citekey]["status"] == "excluded":
            fail(f"promoted key lacks a retained catalog disposition: {citekey}")
    for citekey in superseded_keys:
        if citekey not in catalog or catalog[citekey]["status"] != "excluded":
            fail(f"superseded key lacks an excluded catalog disposition: {citekey}")
    for number, row in enumerate(log_rows, start=2):
        if row["kind"] not in {"search", "snowball", "audit", "exploratory"}:
            fail(f"log row {number} has unknown kind {row['kind']!r}")
        if row["kind"] == "exploratory":
            if "not-recorded" not in row["notes"]:
                fail(f"exploratory log row {number} is not reconciled")
            continue
        for field in ("hits", "screened"):
            if not row[field].isdigit():
                fail(f"search-log row {number} has nonnumeric {field}")
        if int(row["screened"]) > int(row["hits"]):
            fail(f"search-log row {number} screens more records than it reports")
        for citekey in keys(row["included_keys"]):
            if citekey not in catalog:
                fail(f"search-log row {number} includes unknown key {citekey}")
            if (
                catalog[citekey]["status"] == "excluded"
                and citekey not in superseded_keys
            ):
                fail(f"search-log row {number} includes excluded key {citekey}")
        for citekey in keys(row["excluded_keys"]):
            if citekey not in catalog:
                fail(f"search-log row {number} excludes unknown key {citekey}")
            if (
                catalog[citekey]["status"] != "excluded"
                and citekey not in promoted_keys
            ):
                fail(f"search-log row {number} exclusion {citekey} is not excluded")
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

    header, query_rows = rows(SURVEY / "queries.tsv")
    if header != QUERIES_HEADER:
        fail(f"unexpected queries header: {header}")
    query_ids: set[str] = set()
    for number, row in enumerate(query_rows, start=2):
        identifier = row["query_id"]
        if not identifier or identifier in query_ids:
            fail(f"duplicate or empty update query ID on row {number}")
        query_ids.add(identifier)
        if row["source"] not in ("arxiv", "crossref"):
            fail(f"unsupported update source on row {number}: {row['source']}")
        if not row["query"].strip():
            fail(f"empty update query on row {number}")
        if not row["limit"].isdigit() or int(row["limit"]) <= 0:
            fail(f"invalid update limit on row {number}: {row['limit']}")
        if row["source"] == "arxiv":
            if int(row["limit"]) > 100:
                fail(f"arXiv update limit exceeds 100 on row {number}")
            if "all:" not in row["query"]:
                fail(f"arXiv update query is not source-native on row {number}")
        if row["active"] not in ("true", "false"):
            fail(f"invalid update active flag on row {number}: {row['active']}")
        try:
            date.fromisoformat(row["last_reconciled"])
        except ValueError:
            fail(
                f"invalid last_reconciled date on row {number}: "
                f"{row['last_reconciled']}"
            )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
