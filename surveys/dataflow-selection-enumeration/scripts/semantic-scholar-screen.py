#!/usr/bin/env python3
"""Export Semantic Scholar search or citation records for screening."""

import argparse
import csv
from datetime import datetime, timezone
import json
from pathlib import Path
import sys
import time
import urllib.parse
import urllib.request
from urllib.error import HTTPError


API_ROOT = "https://api.semanticscholar.org/graph/v1"
USER_AGENT = "dataflow-selection-enumeration/0 (mailto:qobilidop@gmail.com)"
BASE_FIELDS = ("rank", "source_id", "year", "doi", "title", "venue", "type")
PAPER_FIELDS = "paperId,title,year,externalIds,venue,publicationTypes"


def request_json(path: str, parameters: dict[str, str] | None = None) -> dict:
    query = urllib.parse.urlencode(parameters or {})
    url = f"{API_ROOT}/{path}"
    if query:
        url = f"{url}?{query}"
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    for attempt in range(5):
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                return json.load(response)
        except HTTPError as error:
            if error.code != 429 or attempt == 4:
                raise
            retry_after = error.headers.get("Retry-After")
            delay = min(float(retry_after or 2**attempt), 10.0)
            time.sleep(delay)
    raise AssertionError("unreachable")


def resolve_doi(doi: str) -> dict:
    identifier = urllib.parse.quote(f"DOI:{doi}", safe="")
    return request_json(
        f"paper/{identifier}",
        {"fields": f"{PAPER_FIELDS},citationCount,referenceCount"},
    )


def neighborhood(
    paper_id: str, direction: str, limit: int | None, total_hint: int
) -> tuple[int, list[dict]]:
    relation = "references" if direction == "backward" else "citations"
    paper_field = "citedPaper" if direction == "backward" else "citingPaper"
    records: list[dict] = []
    offset = 0
    total = total_hint
    while True:
        page_size = 1000 if limit is None else min(1000, limit - len(records))
        if page_size <= 0:
            break
        page = request_json(
            f"paper/{paper_id}/{relation}",
            {"fields": PAPER_FIELDS, "limit": str(page_size), "offset": str(offset)},
        )
        additions = [entry.get(paper_field) for entry in page.get("data", [])]
        records.extend(record for record in additions if record)
        next_offset = page.get("next")
        if next_offset is None or not page.get("data"):
            break
        offset = int(next_offset)
        if limit is not None and len(records) >= limit:
            break
    return total, records


def record(
    paper: dict, rank: int, include_abstract: bool = False
) -> dict[str, object]:
    external = paper.get("externalIds") or {}
    doi = external.get("DOI") or ""
    kinds = paper.get("publicationTypes") or []
    result = {
        "rank": rank,
        # Semantic Scholar occasionally returns citation stubs with neither a
        # paper ID nor a DOI.  Preserve those records visibly and assign only
        # a snapshot-local identifier; do not silently drop them or pretend
        # that malformed discovery metadata is an authoritative citation.
        "source_id": paper.get("paperId") or doi or f"unresolved-record-{rank}",
        "year": paper.get("year") or "",
        "doi": doi,
        "title": paper.get("title") or "",
        "venue": paper.get("venue") or "",
        "type": kinds[0] if kinds else "",
    }
    if include_abstract:
        result["abstract"] = paper.get("abstract") or ""
    return result


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser()
    commands = root.add_subparsers(dest="command", required=True)

    search = commands.add_parser("search")
    search.add_argument("query")
    search.add_argument("--limit", type=int, default=100)
    search.add_argument("--output", type=Path, required=True)
    search.add_argument("--metadata-output", type=Path)

    snowball = commands.add_parser("snowball")
    snowball.add_argument("doi")
    snowball.add_argument("direction", choices=("backward", "forward"))
    snowball.add_argument("--limit", type=int)
    snowball.add_argument("--output", type=Path, required=True)
    snowball.add_argument("--metadata-output", type=Path)
    return root


def main() -> int:
    args = parser().parse_args()
    captured_at = datetime.now(timezone.utc).isoformat()
    include_abstract = args.command == "search"
    if args.command == "search":
        if not 1 <= args.limit <= 100:
            raise SystemExit("Semantic Scholar search limit must be in 1..100")
        parameters = {
            "query": args.query,
            "limit": str(args.limit),
            "offset": "0",
            "fields": f"{PAPER_FIELDS},abstract",
        }
        page = request_json("paper/search", parameters)
        total = int(page.get("total") or 0)
        papers = page.get("data") or []
        metadata = {
            "source": "Semantic Scholar Graph API",
            "kind": "search",
            "captured_at": captured_at,
            "path": "paper/search",
            "parameters": parameters,
            "hits": total,
            "exported": len(papers),
        }
    else:
        seed = resolve_doi(args.doi)
        total_field = (
            "referenceCount" if args.direction == "backward" else "citationCount"
        )
        total, papers = neighborhood(
            seed["paperId"],
            args.direction,
            args.limit,
            int(seed.get(total_field) or 0),
        )
        metadata = {
            "source": "Semantic Scholar Graph API",
            "kind": "snowball",
            "captured_at": captured_at,
            "doi": args.doi,
            "seed_paper_id": seed["paperId"],
            "seed_title": seed["title"],
            "direction": args.direction,
            "hits": total,
            "exported": len(papers),
        }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fields = BASE_FIELDS + (("abstract",) if include_abstract else ())
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=fields, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, paper in enumerate(papers, start=1):
            writer.writerow(record(paper, rank, include_abstract))
    if args.metadata_output is not None:
        args.metadata_output.parent.mkdir(parents=True, exist_ok=True)
        args.metadata_output.write_text(
            json.dumps(metadata, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
