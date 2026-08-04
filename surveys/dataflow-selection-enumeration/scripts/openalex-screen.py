#!/usr/bin/env python3
"""Export OpenAlex search or citation-neighborhood records for screening."""

import argparse
import csv
import json
from pathlib import Path
import sys
import urllib.parse
import urllib.request


API_ROOT = "https://api.openalex.org"
FIELDS = (
    "rank",
    "openalex_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
    "abstract",
)


def request_json(path: str, parameters: dict[str, str] | None = None) -> dict:
    query = urllib.parse.urlencode(parameters or {})
    url = f"{API_ROOT}/{path}"
    if query:
        url = f"{url}?{query}"
    request = urllib.request.Request(
        url,
        headers={"User-Agent": "xlsynth-symex-paper/0 (mailto:qobilidop@gmail.com)"},
    )
    with urllib.request.urlopen(request, timeout=60) as response:
        return json.load(response)


def abstract_text(work: dict) -> str:
    inverted = work.get("abstract_inverted_index") or {}
    positioned = [
        (position, word)
        for word, positions in inverted.items()
        for position in positions
    ]
    return " ".join(word for _, word in sorted(positioned))


def record(work: dict, rank: int) -> dict[str, object]:
    location = work.get("primary_location") or {}
    source = location.get("source") or {}
    return {
        "rank": rank,
        "openalex_id": (work.get("id") or "").rsplit("/", 1)[-1],
        "year": work.get("publication_year") or "",
        "doi": work.get("doi") or "",
        "title": work.get("title") or "",
        "venue": source.get("display_name") or "",
        "type": work.get("type") or "",
        "abstract": abstract_text(work),
    }


def resolve_doi(doi: str) -> dict:
    encoded = urllib.parse.quote(f"https://doi.org/{doi}", safe="")
    return request_json(f"works/{encoded}")


def fetch_ids(ids: list[str]) -> list[dict]:
    works = []
    for openalex_id in ids:
        works.append(request_json(f"works/{openalex_id.rsplit('/', 1)[-1]}"))
    return works


def paginate(parameters: dict[str, str], limit: int | None) -> tuple[int, list[dict]]:
    cursor = "*"
    results: list[dict] = []
    total = 0
    while cursor:
        page_size = 200 if limit is None else min(200, limit - len(results))
        if page_size <= 0:
            break
        page_parameters = dict(parameters)
        page_parameters.update({"cursor": cursor, "per-page": str(page_size)})
        page = request_json("works", page_parameters)
        total = page["meta"]["count"]
        results.extend(page["results"])
        cursor = page["meta"].get("next_cursor")
        if limit is not None and len(results) >= limit:
            break
    return total, results


def collect(args: argparse.Namespace) -> tuple[dict[str, object], list[dict]]:
    if args.command == "search":
        total, works = paginate({"search": args.query}, args.limit)
        metadata = {
            "kind": "search",
            "query": args.query,
            "hits": total,
            "exported": len(works),
        }
        return metadata, works

    seed = resolve_doi(args.doi)
    seed_id = seed["id"].rsplit("/", 1)[-1]
    if args.direction == "backward":
        reference_ids = seed.get("referenced_works") or []
        if args.limit is not None:
            reference_ids = reference_ids[: args.limit]
        works = fetch_ids(reference_ids)
        total = len(seed.get("referenced_works") or [])
    else:
        total, works = paginate({"filter": f"cites:{seed_id}"}, args.limit)
    metadata = {
        "kind": "snowball",
        "doi": args.doi,
        "seed_openalex_id": seed_id,
        "seed_title": seed.get("title"),
        "direction": args.direction,
        "hits": total,
        "exported": len(works),
    }
    return metadata, works


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser()
    commands = root.add_subparsers(dest="command", required=True)

    search = commands.add_parser("search")
    search.add_argument("query")
    search.add_argument("--limit", type=int)
    search.add_argument("--output", type=Path, required=True)

    snowball = commands.add_parser("snowball")
    snowball.add_argument("doi")
    snowball.add_argument("direction", choices=("backward", "forward"))
    snowball.add_argument("--limit", type=int)
    snowball.add_argument("--output", type=Path, required=True)
    return root


def main() -> int:
    args = parser().parse_args()
    metadata, works = collect(args)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=FIELDS, dialect="excel-tab")
        writer.writeheader()
        for rank, work in enumerate(works, start=1):
            writer.writerow(record(work, rank))
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
