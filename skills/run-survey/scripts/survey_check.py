#!/usr/bin/env python3
"""Shared survey-record validator engine.

Each survey's ``record/check.py`` declares a config dict and calls
``run(config)``.  The engine validates the record surfaces (catalog, log,
queries, source notes, claims, evidence, bibliography, manuscript bindings,
landing page) against the union of the reference surveys' checks, accumulates
every error, prints the derived counts as JSON on stdout for cross-surface
reconciliation, and returns 1 when any error was found.

Config keys (all paths resolved against ``record_dir``):

- ``record_dir``: Path to the survey's ``record/`` directory.
- ``catalog_columns``: exact header of ``catalog.tsv``.
- ``statuses``: full status vocabulary.
- ``exclusion_codes``: declared exclusion-code vocabulary.
- ``status_required_fields`` / ``status_forbidden_fields``: optional maps
  status -> list of columns that must be non-empty / empty for rows of that
  status (beyond the universal rules: excluded rows carry a declared code,
  all other rows carry none).
- ``facets``: optional map column -> allowed token set, enforced on rows
  whose status is in ``facet_statuses``.
- ``facet_statuses``: statuses whose rows are facet-classified (default:
  the statuses in ``noted_statuses``).
- ``priorities``: optional allowed set for a ``priority`` column; when the
  column exists, every ``critical`` row must be deep-read with usable
  backward and forward chases in the log.
- ``noted_statuses``: statuses whose works may carry source notes; every
  note's identifier must map to a catalog row in one of these statuses.
- ``note_required_statuses``: statuses that REQUIRE a source note.
- ``bib_required_statuses``: statuses that require a bibliography entry.
- ``claim_required_fields``: bold-bullet field names required per claim.
- ``strict_citation_sections``: every bibliography citation must sit inside
  a labeled section.
- ``strict_citation_closure``: every (section, citekey) manuscript citation
  pair must be covered by an evidence record (partial registration must
  instead be declared in the record README).
- ``citation_closure_exempt_citekeys``: optional citekeys whose canonical
  evidence notes live outside the survey record; these remain bibliography
  checked but are exempt from local evidence closure.
- ``secondary_only_evidence_exempt_citekeys``: optional citekeys whose
  ``secondary-only`` notes may support an evidence record making an explicitly
  secondhand claim. Without this deliberate exemption, secondary-only notes
  remain screening memory and cannot enter the evidence ledger.
- ``rq_manuscript_file``: optional path (relative to survey dir) whose RQ
  bullets must equal the protocol's RQ1..RQn.
- ``label_pattern``: regex for manuscript section labels
  (default ``(?:sec|tab)-[A-Za-z0-9-]+``).
- ``extra_reports``: optional list of callables ``catalog_dict -> dict``
  merged into the printed derived-counts report.
- ``declared_quantities``: optional list of published-count assertions,
  each ``{"name", "value", "surfaces", "patterns"}``. ``value`` is a
  report key or a callable over the report; ``patterns`` are regexes
  whose first group captures the number as written (commas allowed).
  Every match in every surface must equal the derived value, so a
  count that drifts in prose fails the validator instead of waiting
  for a reviewer. Keep patterns narrow enough to skip historical
  figures a survey states on purpose.
"""

import csv
import json
import re
import sys
import unicodedata
from collections import Counter
from datetime import date
from pathlib import Path

csv.field_size_limit(sys.maxsize)

KEY = re.compile(r"(?:doi:10\.\d{4,9}/\S+|arxiv:[a-z-]*\d{2}[\d.]+|t:[a-z0-9]+|legacy:\S+)$")
QUERY_SOURCES = {"arxiv", "crossref", "openalex", "semanticscholar"}
QUERIES_HEADER = ["query_id", "source", "theme", "query", "limit", "active", "last_reconciled", "notes"]
LOG_HEADER = ["date", "kind", "id", "source", "query_or_seed", "direction", "hits", "screened", "included_keys", "excluded_keys", "notes"]
LOG_KINDS = {"search", "snowball", "audit", "exploratory"}
NOTE_FIELDS = {"citekey", "read", "source", "retrieved", "notes-by", "notes-date", "synthesis"}
NOTE_WORK_FIELDS = {"title", "author", "date"}
NOTE_SECTIONS = ("## Evidence", "## Bearing on RQs", "## Evidence limits")
EVIDENCE_FIELDS = {
    "Finding": "finding", "Works": "citekeys", "Anchors": "anchors",
    "Supports": "supports", "Manuscript": "manuscript", "Scope": "scope",
    "Caveat": "caveat", "Certainty": "certainty",
}
BACKWARD_DEFECT_MARKERS = (
    "unresolved", "index omits", "exposes no references", "wrong-version",
    "primary list is longer", "incomplete bibliography", "truncated bibliography",
)


def read_tsv(path, expected, errors):
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        if reader.fieldnames != expected:
            errors.append(f"{path.name}: header {reader.fieldnames!r}, expected {expected!r}")
        return list(reader)


def cell_keys(cell):
    return [] if cell in ("", "-") else [key.strip() for key in cell.split(",")]


def heading_anchors(text):
    anchors, seen = set(), {}
    for match in re.finditer(r"^#{1,6}\s+(.+?)\s*$", text, re.M):
        heading = re.sub(r"[`*_~]", "", match.group(1)).lower()
        base = re.sub(r"[^\w\s-]", "", heading)
        base = re.sub(r"\s+", "-", base.strip())
        count = seen.get(base, 0)
        seen[base] = count + 1
        anchors.add(base if count == 0 else f"{base}-{count}")
    return anchors


def research_questions(text):
    lines, extracted, index = text.splitlines(), {}, 0
    while index < len(lines):
        match = re.match(r"^- \*{1,2}(RQ\d+):\*{1,2}\s+(.+)$", lines[index])
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


def seed_key(notes):
    match = re.search(r"(?:^|; )seed-key:(\S+?)(?:;|$)", notes)
    return match.group(1) if match else None


def run(config):
    errors = []
    record = Path(config["record_dir"]).resolve()
    survey = record.parent
    manuscript = survey / "manuscript"
    noted_statuses = set(config["noted_statuses"])
    facet_statuses = set(config.get("facet_statuses", noted_statuses))

    # --- broken local links across the record ---
    for path in sorted(record.rglob("*.md")):
        for target in re.findall(r"\]\(([^)]+)\)", path.read_text(encoding="utf-8")):
            if target.startswith(("#", "http://", "https://", "mailto:")):
                continue
            local = target.split("#", 1)[0].strip("<>")
            if local and not (path.parent / local).exists():
                errors.append(f"{path.relative_to(survey)}: broken local link {target}")

    # --- split manuscript section names and labels ---
    for path in sorted((manuscript / "sections").glob("*.typ")):
        filename = re.fullmatch(r"\d{2}-([a-z0-9-]+)\.typ", path.name)
        if filename is None:
            errors.append(
                f"{path.relative_to(survey)}: section filename must be NN-short-stem.typ"
            )
            continue
        heading = re.search(r"(?m)^= (?![=])(.+)$", path.read_text(encoding="utf-8"))
        label = re.search(r"<sec-([A-Za-z0-9-]+)>\s*$", heading.group(1)) if heading else None
        if label and label.group(1) != filename.group(1):
            errors.append(
                f"{path.relative_to(survey)}: filename stem {filename.group(1)!r} "
                f"does not match section label 'sec-{label.group(1)}'"
            )

    # --- catalog ---
    columns = config["catalog_columns"]
    statuses = set(config["statuses"])
    codes = set(config["exclusion_codes"])
    catalog_rows = read_tsv(record / "catalog.tsv", columns, errors)
    catalog = {}
    for lineno, row in enumerate(catalog_rows, start=2):
        if None in row.values() or None in row or not row.get("key"):
            errors.append(f"catalog.tsv:{lineno}: malformed row")
            continue
        if row["key"] in catalog:
            errors.append(f"catalog.tsv:{lineno}: duplicate key {row['key']}")
        catalog[row["key"]] = row
        if not KEY.fullmatch(row["key"]):
            errors.append(f"catalog.tsv:{lineno}: invalid key {row['key']}")
        if row["status"] not in statuses:
            errors.append(f"catalog.tsv:{lineno}: unknown status {row['status']!r}")
        if row["status"] == "excluded":
            if row["code"] not in codes:
                errors.append(f"catalog.tsv:{lineno}: undeclared exclusion code {row['code']!r}")
        elif row["code"] != "":
            errors.append(f"catalog.tsv:{lineno}: non-excluded row carries a code")
        for field in config.get("status_required_fields", {}).get(row["status"], []):
            if row[field] == "":
                errors.append(f"catalog.tsv:{lineno}: {row['status']} row missing {field}")
        for field in config.get("status_forbidden_fields", {}).get(row["status"], []):
            if row[field] != "":
                errors.append(f"catalog.tsv:{lineno}: {row['status']} row carries {field}")
        for field, allowed in config.get("facets", {}).items():
            if row["status"] in facet_statuses and row[field] not in allowed:
                errors.append(f"catalog.tsv:{lineno}: unknown {field} {row[field]!r}")
        if "priority" in columns and row["priority"] not in config.get("priorities", {""}):
            errors.append(f"catalog.tsv:{lineno}: unknown priority {row['priority']!r}")
    status_counts = Counter(row["status"] for row in catalog.values())
    code_counts = Counter(row["code"] for row in catalog.values() if row["status"] == "excluded")

    # --- bibliography ---
    bib_keys = set(re.findall(r"^@\w+\{([^,]+),", (manuscript / "references.bib").read_text(encoding="utf-8"), re.M))
    with (manuscript / "references.tsv").open(newline="", encoding="utf-8") as handle:
        reference_rows = list(csv.reader(handle, delimiter="\t"))
    for lineno, row in enumerate(reference_rows, start=1):
        if len(row) != 2 or not all(row):
            errors.append(f"references.tsv:{lineno}: expected two nonempty fields")
    valid_references = [row for row in reference_rows if len(row) == 2]
    for column, label in ((0, "citekey"), (1, "identifier")):
        for value, count in Counter(row[column] for row in valid_references).items():
            if count > 1:
                errors.append(f"references.tsv: duplicate {label} {value}")
    manual_path = manuscript / "references-manual.bib"
    manual_keys = set(re.findall(r"^@\w+\{([^,]+),", manual_path.read_text(encoding="utf-8"), re.M)) if manual_path.exists() else set()
    generated_keys = {row[0] for row in valid_references}
    if generated_keys | manual_keys != bib_keys:
        errors.append("references.tsv + references-manual.bib keys do not match references.bib")
    reference_identifiers = {row[0]: row[1] for row in valid_references}

    # --- source notes ---
    sources = record / "sources"
    notes = sorted(path for path in sources.glob("*.md") if path.name != "_template.md")
    note_keys, reads = set(), Counter()
    note_reads = {}
    note_identifiers = {}
    for note in notes:
        text = note.read_text(encoding="utf-8")
        frontmatter = text.split("---", 2)[1] if text.startswith("---") else ""
        present = set(re.findall(r"^([a-z][a-z-]+):", frontmatter, re.M))
        for field in sorted(NOTE_FIELDS - present):
            errors.append(f"{note.name}: missing {field}")
        work_match = re.search(r"^work:\s*$\n((?:^  .+\n?)+)", frontmatter, re.M)
        work_fields = set(re.findall(r"^  ([a-z]+):", work_match.group(1), re.M)) if work_match else set()
        for field in sorted(NOTE_WORK_FIELDS - work_fields):
            errors.append(f"{note.name}: missing work.{field}")
        citekey = re.search(r"^citekey:\s*(.+)$", frontmatter, re.M)
        if citekey and citekey.group(1).strip() != note.stem:
            errors.append(f"{note.name}: filename/citekey mismatch")
        note_keys.add(note.stem)
        read = re.search(r"^read:\s*(full-text|abstract-only|secondary-only)$", frontmatter, re.M)
        if read:
            reads[read.group(1)] += 1
            note_reads[note.stem] = read.group(1)
        else:
            errors.append(f"{note.name}: invalid or missing read depth")
        for heading in NOTE_SECTIONS:
            if not re.search(rf"^{re.escape(heading)}\s*$", text, re.M):
                errors.append(f"{note.name}: missing {heading}")
        registrar_ids = {
            f"{scheme}:{value.lower()}"
            for scheme, value in re.findall(r"^  (doi|arxiv):\s*[\"']?([^\s\"']+)", frontmatter, re.M)
        }
        if not registrar_ids and reference_identifiers.get(note.stem, "").startswith(("doi:", "arxiv:")):
            registrar_ids = {reference_identifiers[note.stem]}
        if not registrar_ids:
            source_line = re.search(r"^source:\s*(.+)$", frontmatter, re.M)
            if not source_line or source_line.group(1).strip() in ('""', "''", "none"):
                errors.append(f"{note.name}: no identifier or source locates the version read")
        # catalog mapping also goes through the title-slug and legacy schemes
        identifiers = set(registrar_ids)
        title_match = re.search(r"^  title:\s*[\"']?(.+?)[\"']?\s*$", frontmatter, re.M)
        if title_match:
            slug = unicodedata.normalize("NFKD", title_match.group(1)).encode("ascii", "ignore").decode().lower()
            identifiers.add("t:" + re.sub(r"[^a-z0-9]+", "", slug)[:80])
        identifiers.add(f"legacy:{note.stem}")
        note_identifiers[note.stem] = identifiers
        mapped = [catalog[key] for key in identifiers if key in catalog]
        if not mapped:
            errors.append(f"{note.name}: no work identifier maps to a catalog row")
        elif not any(row["status"] in noted_statuses for row in mapped):
            errors.append(f"{note.name}: catalog status {mapped[0]['status']!r} does not admit a source note")
    if len(note_keys) != len(notes):
        errors.append("duplicate source-note citekey")

    # notes and bibliography required by catalog status
    identifier_to_note = {identifier: stem for stem, ids in note_identifiers.items() for identifier in ids}
    for key, row in catalog.items():
        if row["status"] in config.get("note_required_statuses", []):
            if key not in identifier_to_note and not (sources / f"{key}.md").is_file():
                errors.append(f"{row['status']} work {key} has no source note")
        if row["status"] in config.get("bib_required_statuses", []):
            note_stem = identifier_to_note.get(key)
            if note_stem is None or note_stem not in bib_keys:
                errors.append(f"{row['status']} work {key} has no bibliography entry")

    # --- claims ---
    claims_text = (record / "claims.md").read_text(encoding="utf-8")
    marker = "## Current survey synthesis claims"
    current = claims_text.split(marker, 1)[-1]
    claim_ids = []
    for block in re.split(r"(?m)^### ", current)[1:]:
        header = block.splitlines()[0]
        match = re.match(r"(C\d{2})\s+—", header)
        if not match:
            errors.append(f"claims.md: malformed claim heading {header!r}")
            continue
        claim_ids.append(match.group(1))
        fields = set(re.findall(r"(?m)^- \*\*([A-Za-z ]+):\*\*", block))
        for field in config.get("claim_required_fields", []):
            if field not in fields:
                errors.append(f"claims.md {match.group(1)}: missing {field}")
    for value, count in Counter(claim_ids).items():
        if count > 1:
            errors.append(f"claims.md: duplicate claim id {value}")
    claim_ids = set(claim_ids)
    if not claim_ids:
        errors.append("claims ledger has no current Cxx synthesis claims")

    # --- manuscript labels and citations ---
    label_pattern = config.get("label_pattern", r"(?:sec|tab)-[A-Za-z0-9-]+")
    manuscript_labels = set()
    citation_pairs = set()
    citations = set()
    for path in sorted(manuscript.rglob("*.typ")):
        text = path.read_text(encoding="utf-8")
        labels = [(match.start(), match.group(1)) for match in re.finditer(rf"<({label_pattern})>", text)]
        manuscript_labels.update(label for _, label in labels)
        section_labels = [(position, label) for position, label in labels if label.startswith("sec-")]
        found = [(match.start(), match.group(1)) for match in re.finditer(r"@([A-Za-z][A-Za-z0-9_-]+)", text)]
        found.extend((match.start(), match.group(1)) for match in re.finditer(r"#cite\(<([A-Za-z][A-Za-z0-9_-]+)>", text))
        for position, citekey in found:
            if citekey not in bib_keys:
                continue
            citations.add(citekey)
            # Figure/table labels are declaration targets, not lexical scopes.
            # A citation belongs to its top-level section even when a table label
            # appears earlier in that section.
            enclosing = [label for label_position, label in section_labels if label_position < position]
            if enclosing:
                citation_pairs.add((enclosing[-1], citekey))
            elif config.get("strict_citation_sections"):
                errors.append(f"{path.name}: citation @{citekey} outside a labeled section")
    content_text = (manuscript / "content.typ").read_text(encoding="utf-8")
    all_citekey_tokens = set(re.findall(r"@([A-Za-z][A-Za-z0-9_-]+)", content_text))
    for value in sorted(all_citekey_tokens - bib_keys - manuscript_labels):
        if re.match(r"[a-z]+\d{4}", value):
            errors.append(f"citation missing from references.bib: {value}")
    for value in sorted(bib_keys - citations):
        errors.append(f"uncited references.bib entry: {value}")

    # --- research-question drift ---
    rq_file = config.get("rq_manuscript_file")
    if rq_file:
        protocol_rqs = research_questions((record / "protocol.md").read_text(encoding="utf-8"))
        manuscript_rqs = research_questions((survey / rq_file).read_text(encoding="utf-8"))
        if protocol_rqs != manuscript_rqs:
            drift = sorted(set(protocol_rqs) ^ set(manuscript_rqs)) or sorted(
                identifier for identifier in protocol_rqs
                if protocol_rqs[identifier] != manuscript_rqs.get(identifier)
            )
            errors.append(f"protocol/manuscript research-question drift: {drift[0]}")

    # --- evidence ---
    evidence_text = (record / "evidence.md").read_text(encoding="utf-8")
    evidence_ids, supported_claims = set(), set()
    covered_pairs, anchor_cache = set(), {}
    certainty_counts = Counter()
    for block in re.split(r"(?m)^### ", evidence_text)[1:]:
        identifier = block.splitlines()[0].strip()
        if not re.fullmatch(r"E\d{3}", identifier):
            errors.append(f"invalid evidence id: {identifier}")
            continue
        if identifier in evidence_ids:
            errors.append(f"duplicate evidence id: {identifier}")
        evidence_ids.add(identifier)
        fields = {column: "-" for column in EVIDENCE_FIELDS.values()}
        for label, value in re.findall(r"(?m)^- \*\*([A-Za-z]+):\*\* (.*)$", block):
            if label not in EVIDENCE_FIELDS:
                errors.append(f"{identifier}: unknown evidence field {label!r}")
                continue
            fields[EVIDENCE_FIELDS[label]] = value.strip()
        if fields["certainty"] not in ("-", "high", "moderate", "low"):
            errors.append(f"{identifier}: invalid certainty {fields['certainty']!r}")
        certainty_counts[fields["certainty"]] += 1
        for field in ("finding", "scope", "caveat"):
            if fields[field] in ("", "-"):
                errors.append(f"{identifier}: empty {field}")
        row_claims = cell_keys(fields["supports"])
        if len(row_claims) != len(set(row_claims)):
            errors.append(f"{identifier}: repeats a supported claim")
        for claim in row_claims:
            if claim not in claim_ids:
                errors.append(f"{identifier}: supports unknown claim {claim}")
            supported_claims.add(claim)
        row_labels = cell_keys(fields["manuscript"])
        for label in row_labels:
            if label not in manuscript_labels:
                errors.append(f"{identifier}: unknown manuscript label {label}")
        if not row_claims and not row_labels:
            errors.append(f"{identifier}: supports neither a claim nor the manuscript")
        row_keys = cell_keys(fields["citekeys"])
        if not row_keys:
            errors.append(f"{identifier}: no citekeys")
        if len(row_keys) != len(set(row_keys)):
            errors.append(f"{identifier}: repeats a citekey")
        anchor_refs = {}
        for reference in fields["anchors"].split(";"):
            reference = reference.strip()
            match = re.fullmatch(r"sources/([A-Za-z0-9_.-]+)\.md#([A-Za-z0-9_.-]+)", reference)
            if match is None:
                errors.append(f"{identifier}: invalid anchor {reference!r}")
                continue
            if match.group(2) in anchor_refs.get(match.group(1), set()):
                errors.append(f"{identifier}: duplicate anchor for {match.group(1)}")
            anchor_refs.setdefault(match.group(1), set()).add(match.group(2))
        secondary_exemptions = set(config.get("secondary_only_evidence_exempt_citekeys", []))
        for citekey in row_keys:
            note = sources / f"{citekey}.md"
            if not note.is_file():
                errors.append(f"{identifier}: {citekey} has no source note")
                continue
            if note_reads.get(citekey) == "secondary-only" and citekey not in secondary_exemptions:
                errors.append(
                    f"{identifier}: secondary-only note {citekey} cannot support an evidence record"
                )
            if citekey not in anchor_refs:
                errors.append(f"{identifier}: no anchor for {citekey}")
                continue
            if citekey not in anchor_cache:
                anchor_cache[citekey] = heading_anchors(note.read_text(encoding="utf-8"))
            for anchor in sorted(anchor_refs[citekey]):
                if anchor not in anchor_cache[citekey]:
                    errors.append(f"{identifier}: missing anchor sources/{citekey}.md#{anchor}")
        for citekey in sorted(set(anchor_refs) - set(row_keys)):
            errors.append(f"{identifier}: anchors unlisted citekey {citekey}")
        row_key_set = set(row_keys)
        for label in row_labels:
            matching = {pair for pair in citation_pairs if pair[0] == label and pair[1] in row_key_set}
            if not matching and config.get("strict_citation_closure"):
                errors.append(f"{identifier}: no cited source at manuscript anchor {label}")
            covered_pairs.update(matching)
    for claim in sorted(claim_ids - supported_claims):
        errors.append(f"claim has no evidence record: {claim}")
    if config.get("strict_citation_closure"):
        exempt_citekeys = set(config.get("citation_closure_exempt_citekeys", []))
        for citekey in sorted(exempt_citekeys - citations):
            errors.append(f"citation-closure exemption is not cited: {citekey}")
        for label, citekey in sorted(citation_pairs - covered_pairs):
            if citekey in exempt_citekeys:
                continue
            errors.append(f"manuscript citation has no evidence record at {label}: {citekey}")

    # --- log ---
    log_rows = read_tsv(record / "log.tsv", LOG_HEADER, errors)
    kind_counts = Counter()
    promoted, superseded, reclassified = set(), set(), set()
    for row in log_rows:
        promoted.update(re.findall(r"(?:^|; )promoted-key:(\S+?)(?:;|$)", row["notes"]))
        superseded.update(re.findall(r"(?:^|; )superseded-key:(\S+?)(?:;|$)", row["notes"]))
        # A later audit may correct what an earlier wave decided. The log is
        # append-only, so that row keeps its historical decision and the audit
        # row carries the correction; both cannot describe current state.
        reclassified.update(re.findall(r"(?:^|; )reclassified-key:(\S+?)(?:;|$)", row["notes"]))
        if re.search(r"(?:^|; )(?:promoted|superseded|reclassified)-key:", row["notes"]) and row["kind"] != "audit":
            errors.append(f"log id {row['id']}: disposition reconciliation is not an audit row")
    for key in sorted(reclassified):
        if key not in catalog:
            errors.append(f"reclassified key is not in the catalog: {key}")
    for key in sorted(promoted & superseded):
        errors.append(f"log both promotes and supersedes {key}")
    for key in sorted(promoted):
        if key not in catalog or catalog[key]["status"] == "excluded":
            errors.append(f"promoted key lacks a retained catalog disposition: {key}")
    for key in sorted(superseded):
        if key not in catalog or catalog[key]["status"] != "excluded":
            errors.append(f"superseded key lacks an excluded catalog disposition: {key}")
    rows_by_seed = {}
    defective_seeds = set()
    for lineno, row in enumerate(log_rows, start=2):
        if None in row.values() or row["kind"] not in LOG_KINDS:
            errors.append(f"log.tsv:{lineno}: malformed row or unknown kind")
            continue
        kind_counts[row["kind"]] += 1
        if row["date"] == "" or row["id"] == "":
            errors.append(f"log.tsv:{lineno}: missing date or id")
        if row["kind"] == "exploratory":
            if "not-recorded" not in row["notes"]:
                errors.append(f"log.tsv:{lineno}: exploratory row is not reconciled")
            continue
        if row["kind"] == "audit":
            if row["notes"] == "":
                errors.append(f"log.tsv:{lineno}: audit row without notes")
        else:
            if row["source"] == "" or row["query_or_seed"] == "" or row["hits"] == "":
                errors.append(f"log.tsv:{lineno}: {row['kind']} row missing source/query/hits")
            if not row["hits"].startswith("FAILED"):
                numeric = row["hits"].isdigit() and (row["screened"].isdigit() or row["screened"] in ("", "-"))
                if not numeric:
                    errors.append(f"log.tsv:{lineno}: nonnumeric hits/screened")
                elif row["screened"].isdigit() and int(row["screened"]) > int(row["hits"]):
                    errors.append(f"log.tsv:{lineno}: screened exceeds hits")
        for key in cell_keys(row["included_keys"]):
            if key not in catalog:
                errors.append(f"log.tsv:{lineno}: includes unknown key {key}")
            elif catalog[key]["status"] == "excluded" and key not in superseded | reclassified:
                errors.append(f"log.tsv:{lineno}: includes excluded key {key}")
        for key in cell_keys(row["excluded_keys"]):
            if key not in catalog:
                errors.append(f"log.tsv:{lineno}: excludes unknown key {key}")
            elif catalog[key]["status"] != "excluded" and key not in promoted | reclassified:
                errors.append(f"log.tsv:{lineno}: exclusion {key} is not excluded")
        seed = seed_key(row["notes"])
        if seed is not None:
            rows_by_seed.setdefault(seed, []).append(row)
        if row["direction"] == "backward" and any(marker in row["notes"].lower() for marker in BACKWARD_DEFECT_MARKERS):
            if seed is None:
                errors.append(f"log.tsv:{lineno}: defective backward row has no seed-key")
            else:
                defective_seeds.add(seed)

    for seed in sorted(defective_seeds):
        if not any("primary-complete" in item["notes"] for item in rows_by_seed.get(seed, [])):
            errors.append(f"defective backward chase for {seed} has no primary bibliography")

    if "priority" in columns:
        for key, row in catalog.items():
            if row["priority"] != "critical":
                continue
            if row["status"] != "deep-read":
                errors.append(f"critical work {key} is not deep-read")
            usable = [item for item in rows_by_seed.get(key, []) if "discovery-only" not in item["notes"]]
            directions = {item["direction"] for item in usable}
            for direction in ("backward", "forward"):
                if direction not in directions:
                    errors.append(f"critical work {key} has no usable {direction} chase")

    # --- queries ---
    query_rows = read_tsv(record / "queries.tsv", QUERIES_HEADER, errors)
    query_ids = set()
    for lineno, row in enumerate(query_rows, start=2):
        if not row["query_id"] or row["query_id"] in query_ids:
            errors.append(f"queries.tsv:{lineno}: duplicate or empty query id")
        query_ids.add(row["query_id"])
        if row["source"] not in QUERY_SOURCES:
            errors.append(f"queries.tsv:{lineno}: unsupported source {row['source']!r}")
        if not row["query"].strip():
            errors.append(f"queries.tsv:{lineno}: empty query")
        if not row["limit"].isdigit() or int(row["limit"]) <= 0:
            errors.append(f"queries.tsv:{lineno}: invalid limit {row['limit']!r}")
        elif row["source"] == "arxiv" and int(row["limit"]) > 100:
            errors.append(f"queries.tsv:{lineno}: arXiv limit exceeds 100")
        if row["source"] == "arxiv" and "all:" not in row["query"]:
            errors.append(f"queries.tsv:{lineno}: arXiv query is not source-native")
        if row["active"] not in ("true", "false"):
            errors.append(f"queries.tsv:{lineno}: invalid active flag {row['active']!r}")
        # Empty last_reconciled marks a registered query that has never
        # been reconciled (its first staged run takes the window start
        # from the protocol via update.py --initial-from-date).
        if row["last_reconciled"]:
            try:
                date.fromisoformat(row["last_reconciled"])
            except ValueError:
                errors.append(f"queries.tsv:{lineno}: invalid last_reconciled {row['last_reconciled']!r}")

    # --- landing page curation ---
    index_text = (survey / "index.md").read_text(encoding="utf-8")
    curated = {Path(match).stem for match in re.findall(r"record/sources/([^)]+\.md)", index_text)}
    curated.update(target for target in re.findall(r"\[\[([^\]]+)\]\]", index_text) if target in note_keys)

    report = {
        "catalog_rows": len(catalog),
        "status": dict(sorted(status_counts.items())),
        "exclusion_codes": dict(sorted(code_counts.items())),
        "log_rows": dict(sorted(kind_counts.items())),
        "claims": len(claim_ids),
        "evidence_records": len(evidence_ids),
        "evidence_certainty": dict(sorted(certainty_counts.items())),
        "source_notes": len(notes),
        "read_depth": dict(sorted(reads.items())),
        "curated_source_notes": len(curated),
        "bibliography_entries": len(bib_keys),
        "manuscript_citations": len(citations),
    }
    for field in config.get("facets", {}):
        counter = Counter(row[field] for row in catalog.values() if row["status"] in facet_statuses)
        report[field] = dict(sorted(counter.items()))
    for extra_report in config.get("extra_reports", []):
        report.update(extra_report(catalog))

    # --- declared quantities ---
    # A survey names the counts it publishes and the exact phrasings that
    # assert them; every match must equal the derived value. Prose counts
    # drift silently otherwise — one update shipped ten stale figures that
    # only an adversarial reviewer caught.
    for declared in config.get("declared_quantities", []):
        expected = declared["value"](report) if callable(declared["value"]) else report[declared["value"]]
        for relative in declared["surfaces"]:
            path = survey / relative
            if not path.is_file():
                errors.append(f"declared-quantity surface is missing: {relative}")
                continue
            text = path.read_text(encoding="utf-8")
            for pattern in declared["patterns"]:
                for match in re.finditer(pattern, text):
                    found = int(match.group(1).replace(",", ""))
                    if found != expected:
                        errors.append(
                            f"{relative}: {declared['name']} reads {match.group(1)}, "
                            f"derived value is {expected} (matched {pattern!r})"
                        )

    print(json.dumps(report, indent=2, sort_keys=True))
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    return 1 if errors else 0
