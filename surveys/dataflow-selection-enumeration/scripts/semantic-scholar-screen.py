#!/usr/bin/env python3
"""Export a Semantic Scholar citation neighborhood for title screening."""

import argparse
import csv
import json
from pathlib import Path
import sys
import time
import urllib.parse
import urllib.request
from urllib.error import HTTPError


API_ROOT = "https://api.semanticscholar.org/graph/v1"
USER_AGENT = "xlsynth-symex-paper/0 (mailto:qobilidop@gmail.com)"
FIELDS = ("rank", "source_id", "year", "doi", "title", "venue", "type")
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


def record(paper: dict, rank: int) -> dict[str, object]:
    external = paper.get("externalIds") or {}
    doi = external.get("DOI") or ""
    kinds = paper.get("publicationTypes") or []
    return {
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


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("doi")
    result.add_argument("direction", choices=("backward", "forward"))
    result.add_argument("--limit", type=int)
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    seed = resolve_doi(args.doi)
    total_field = "referenceCount" if args.direction == "backward" else "citationCount"
    total, papers = neighborhood(
        seed["paperId"], args.direction, args.limit, int(seed.get(total_field) or 0)
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=FIELDS, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, paper in enumerate(papers, start=1):
            writer.writerow(record(paper, rank))
    print(
        json.dumps(
            {
                "source": "Semantic Scholar Graph API",
                "doi": args.doi,
                "seed_paper_id": seed["paperId"],
                "seed_title": seed["title"],
                "direction": args.direction,
                "hits": total,
                "exported": len(papers),
            },
            ensure_ascii=False,
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
