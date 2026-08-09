#!/usr/bin/env python3
"""Report survey freshness and stage registered update searches."""

import argparse
import csv
from collections import Counter
from datetime import date
import json
import re
from pathlib import Path
import shlex
import subprocess
import sys
import time


ROOT = Path(__file__).resolve().parents[2]
SURVEY = ROOT / "record"
UPDATES = SURVEY / "updates"
# Shared source fetchers live with the run-survey skill.
SCRIPT_DIR = Path(__file__).resolve().parent
ARXIV_INTERVAL_SECONDS = 3.0


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as source:
        return list(csv.DictReader(source, dialect="excel-tab"))


def parse_date(value: str) -> date:
    try:
        return date.fromisoformat(value)
    except ValueError as error:
        raise SystemExit(f"invalid ISO date {value!r}") from error


def records() -> list[dict[str, str]]:
    return read_tsv(SURVEY / "queries.tsv")


def status(args: argparse.Namespace) -> int:
    queries = records()
    active = [query for query in queries if query["active"] == "true"]
    today = parse_date(args.as_of)
    last_reconciled = min(
        (parse_date(q["last_reconciled"]) for q in active),
        default=None,
    )

    catalog = read_tsv(SURVEY / "catalog.tsv")
    catalog_statuses = Counter(row["status"] for row in catalog)
    log_rows = read_tsv(SURVEY / "log.tsv")
    source_notes = [
        path
        for path in (SURVEY / "sources").glob("*.md")
        if path.name != "_template.md"
    ]

    print(f"Survey status as of {today.isoformat()}")
    breakdown = ", ".join(
        f"{count} {status}" for status, count in sorted(catalog_statuses.items())
    )
    print(f"Catalog: {len(catalog)} works ({breakdown})")
    evidence = f"Evidence: {len(source_notes)} source notes"
    evidence_path = SURVEY / "evidence.md"
    if evidence_path.is_file():
        text = evidence_path.read_text(encoding="utf-8")
        items = re.findall(r"(?m)^### (E\d{3})", text)
        support_counts = Counter(
            claim.strip()
            for line in re.findall(r"(?m)^- \*\*Supports:\*\* (.*)$", text)
            for claim in line.split(",")
        )
        thin = [claim for claim, count in support_counts.items() if count == 1]
        evidence += f", {len(items)} evidence items"
        if thin:
            evidence += f" ({len(thin)} claims on a single item)"
    print(evidence)
    template = SURVEY / "sources" / "_template.md"
    if template.is_file():
        current_source_notes = sum(
            "- **Template version:** 2" in path.read_text(encoding="utf-8")
            for path in source_notes
        )
        print(
            f"Source-note schema: {current_source_notes} current, "
            f"{len(source_notes) - current_source_notes} legacy"
        )
    audited = [row for row in log_rows if row.get("kind") != "exploratory"]
    print(f"Search record: {len(audited)} audited log rows "
          f"(+{len(log_rows) - len(audited)} exploratory)")
    print(f"Registered searches: {len(active)} active"
          + (f", last fully reconciled {last_reconciled.isoformat()}"
             if last_reconciled else ""))
    print("Updates are staged on demand: fetch --all or --query-id ID")
    return 0


def command_for(
    query: dict[str, str],
    today: date,
    output: Path,
) -> list[str]:
    common = [
        query["query"],
        "--limit",
        query["limit"],
        "--from-date",
        query["last_reconciled"],
        "--to-date",
        today.isoformat(),
        "--output",
        str(output),
    ]
    if query["source"] == "crossref":
        return [sys.executable, str(SCRIPT_DIR / "search_crossref.py"), *common]
    if query["source"] == "arxiv":
        return [
            sys.executable,
            str(SCRIPT_DIR / "search_arxiv.py"),
            *common,
            "--raw-query",
        ]
    if query["source"] == "openalex":
        return [
            sys.executable,
            str(SCRIPT_DIR / "search_openalex.py"),
            "search",
            *common,
        ]
    if query["source"] == "semanticscholar":
        return [
            sys.executable,
            str(SCRIPT_DIR / "search_semantic_scholar.py"),
            "search",
            query["query"],
            "--limit",
            query["limit"],
            "--from-year",
            query["last_reconciled"][:4],
            "--to-year",
            today.isoformat()[:4],
            "--output",
            str(output),
        ]
    raise SystemExit(f"unsupported registered source: {query['source']}")


def select_queries(args: argparse.Namespace) -> list[dict[str, str]]:
    queries = records()
    active = [query for query in queries if query["active"] == "true"]
    today = parse_date(args.as_of)
    if args.query_id:
        selected = [query for query in active if query["query_id"] in args.query_id]
        missing = sorted(set(args.query_id) - {query["query_id"] for query in selected})
        if missing:
            raise SystemExit(f"unknown or inactive query ID: {missing[0]}")
        return selected
    if args.all:
        return active
    raise SystemExit("choose --all or at least one --query-id")


def write_manifest(path: Path, manifest: dict[str, object]) -> None:
    temporary = path.with_suffix(".json.tmp")
    temporary.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    temporary.replace(path)


def fetch(args: argparse.Namespace) -> int:
    selected = select_queries(args)
    today = parse_date(args.as_of)
    output_dir = Path(args.output_dir) if args.output_dir else (
        ROOT / ".scratch" / "survey-update" / today.isoformat()
    )
    if not output_dir.is_absolute():
        output_dir = ROOT / output_dir
    output_dir = output_dir.resolve()
    scratch = (ROOT / ".scratch").resolve()
    if output_dir != scratch and scratch not in output_dir.parents:
        raise SystemExit("staged output must remain under .scratch/")

    if not selected:
        print("No queries selected.")
        return 0

    manifest_path = output_dir / "manifest.json"
    if manifest_path.exists() and not args.dry_run:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        if (
            manifest.get("date") != today.isoformat()
            or manifest.get("status") != "staged-not-adjudicated"
        ):
            raise SystemExit(f"incompatible staged manifest: {manifest_path}")
    else:
        manifest = {
            "date": today.isoformat(),
            "queries": [],
            "status": "staged-not-adjudicated",
        }
    manifest_queries = manifest.get("queries")
    if not isinstance(manifest_queries, list) or not all(
        isinstance(item, dict) and isinstance(item.get("query_id"), str)
        for item in manifest_queries
    ):
        raise SystemExit(f"invalid staged manifest: {manifest_path}")
    staged_ids = {item["query_id"] for item in manifest_queries}
    last_arxiv_request: float | None = None
    for query in selected:
        output = output_dir / f"{query['query_id']}.tsv"
        command = command_for(query, today, output)
        if args.dry_run:
            print(shlex.join(command))
            continue
        if query["query_id"] in staged_ids:
            print(f"already staged {query['query_id']}; skipping")
            continue
        if output.exists():
            raise SystemExit(f"refusing to overwrite staged result: {output}")
        output_dir.mkdir(parents=True, exist_ok=True)
        if query["source"] == "arxiv":
            if last_arxiv_request is not None:
                elapsed = time.monotonic() - last_arxiv_request
                time.sleep(max(0.0, ARXIV_INTERVAL_SECONDS - elapsed))
            last_arxiv_request = time.monotonic()
        try:
            completed = subprocess.run(
                command,
                cwd=ROOT,
                check=True,
                capture_output=True,
                text=True,
            )
        except subprocess.CalledProcessError as error:
            if error.stderr:
                print(error.stderr.rstrip(), file=sys.stderr)
            return error.returncode
        metadata = json.loads(completed.stdout.strip())
        manifest_queries.append(
            {
                "query_id": query["query_id"],
                "output": str(output.relative_to(ROOT)),
                "metadata": metadata,
            }
        )
        staged_ids.add(query["query_id"])
        write_manifest(manifest_path, manifest)
        print(f"staged {query['query_id']} -> {output.relative_to(ROOT)}")

    if not args.dry_run:
        output_dir.mkdir(parents=True, exist_ok=True)
        write_manifest(manifest_path, manifest)
        print(f"manifest: {manifest_path.relative_to(ROOT)}")
    return 0


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser()
    root.add_argument(
        "--record",
        required=True,
        help="path to the survey's record/ directory",
    )
    commands = root.add_subparsers(dest="command", required=True)

    status_parser = commands.add_parser("status")
    status_parser.add_argument("--as-of", default=date.today().isoformat())
    status_parser.set_defaults(function=status)

    fetch_parser = commands.add_parser("fetch")
    choice = fetch_parser.add_mutually_exclusive_group()
    choice.add_argument("--all", action="store_true")
    choice.add_argument("--query-id", action="append")
    fetch_parser.add_argument("--as-of", default=date.today().isoformat())
    fetch_parser.add_argument("--output-dir")
    fetch_parser.add_argument("--dry-run", action="store_true")
    fetch_parser.set_defaults(function=fetch)
    return root


def main() -> int:
    args = parser().parse_args()
    global ROOT, SURVEY
    SURVEY = Path(args.record).resolve()
    if not (SURVEY / "queries.tsv").is_file():
        raise SystemExit(f"not a survey record with a registry: {SURVEY}")
    ROOT = SURVEY.parent
    return args.function(args)


if __name__ == "__main__":
    raise SystemExit(main())
