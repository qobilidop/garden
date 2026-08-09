#!/usr/bin/env python3
"""Export OpenAlex search or citation-neighborhood records for screening."""

import argparse
import csv
import json
import re
from pathlib import Path
import sys
import urllib.parse
import urllib.request
from urllib.error import HTTPError


API_ROOT = "https://api.openalex.org"
BASE_FIELDS = (
    "rank",
    "openalex_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
)


def request_json(path: str, parameters: dict[str, str] | None = None) -> dict:
    query = urllib.parse.urlencode(parameters or {})
    url = f"{API_ROOT}/{path}"
    if query:
        url = f"{url}?{query}"
    request = urllib.request.Request(
        url,
        headers={
            "User-Agent": "sys0-surveys/0 (mailto:qobilidop@gmail.com)"
        },
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


def record(work: dict, rank: int, include_abstract: bool) -> dict[str, object]:
    location = work.get("primary_location") or {}
    source = location.get("source") or {}
    result = {
        "rank": rank,
        "openalex_id": (work.get("id") or "").rsplit("/", 1)[-1],
        "year": work.get("publication_year") or "",
        "doi": work.get("doi") or "",
        "title": work.get("title") or "",
        "venue": source.get("display_name") or "",
        "type": work.get("type") or "",
    }
    if include_abstract:
        result["abstract"] = abstract_text(work)
    return result


def resolve_seed(seed: str) -> dict:
    """Resolve a DOI or an OpenAlex work identifier."""
    short_id = seed.rsplit("/", 1)[-1]
    if short_id.startswith("W") and short_id[1:].isdigit():
        return request_json(f"works/{short_id}")
    encoded = urllib.parse.quote(f"https://doi.org/{seed}", safe="")
    return request_json(f"works/{encoded}")


def resolve_title_seed(title: str, year: int) -> dict:
    """Resolve an identifier-less seed by exact normalized title + year.

    Ambiguity is an error by design: log and skip the seed rather
    than guessing."""
    normalize = lambda value: re.sub(r"[^a-z0-9]", "", value.lower())
    result = request_json(
        "works", {"filter": f"title.search:{title}", "per-page": "25"}
    )
    matches = [
        work
        for work in result.get("results", [])
        if normalize(work.get("title") or "") == normalize(title)
        and work.get("publication_year") == year
    ]
    if len(matches) != 1:
        raise SystemExit(
            f"seed title resolution is ambiguous ({len(matches)} exact "
            "normalized-title and year matches)"
        )
    return matches[0]


def fetch_ids(ids: list[str]) -> tuple[list[dict], list[str]]:
    works = []
    unresolved = []
    for openalex_id in ids:
        short_id = openalex_id.rsplit("/", 1)[-1]
        try:
            works.append(request_json(f"works/{short_id}"))
        except HTTPError as error:
            if error.code != 404:
                raise
            unresolved.append(short_id)
    return works, unresolved


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
        parameters = {"search": args.query}
        bounds = []
        if args.from_date:
            bounds.append(f"from_publication_date:{args.from_date}")
        if args.to_date:
            bounds.append(f"to_publication_date:{args.to_date}")
        if bounds:
            parameters["filter"] = ",".join(bounds)
        total, works = paginate(parameters, args.limit)
        metadata = {
            "kind": "search",
            "query": args.query,
            "from_date": args.from_date,
            "to_date": args.to_date,
            "hits": total,
            "exported": len(works),
        }
        return metadata, works

    if args.seed:
        seed = resolve_seed(args.seed)
    else:
        seed = resolve_title_seed(args.by_title, args.year)
    seed_id = seed["id"].rsplit("/", 1)[-1]
    if args.direction == "backward":
        reference_ids = seed.get("referenced_works") or []
        if args.limit is not None:
            reference_ids = reference_ids[: args.limit]
        works, unresolved = fetch_ids(reference_ids)
        total = len(seed.get("referenced_works") or [])
    else:
        total, works = paginate({"filter": f"cites:{seed_id}"}, args.limit)
        unresolved = []
    metadata = {
        "kind": "snowball",
        "seed": args.seed or f"title:{args.by_title} ({args.year})",
        "seed_openalex_id": seed_id,
        "seed_title": seed.get("title"),
        "direction": args.direction,
        "hits": total,
        "exported": len(works),
        "unresolved": unresolved,
    }
    return metadata, works


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser()
    commands = root.add_subparsers(dest="command", required=True)

    search = commands.add_parser("search")
    search.add_argument("query")
    search.add_argument("--limit", type=int)
    search.add_argument("--from-date")
    search.add_argument("--to-date")
    search.add_argument("--output", type=Path, required=True)
    search.add_argument("--include-abstract", action="store_true")

    snowball = commands.add_parser("snowball")
    snowball.add_argument(
        "seed", nargs="?", help="DOI or OpenAlex work identifier"
    )
    snowball.add_argument(
        "--by-title", help="exact title for an identifier-less seed"
    )
    snowball.add_argument(
        "--year", type=int, help="publication year for --by-title"
    )
    snowball.add_argument("direction", choices=("backward", "forward"))
    snowball.add_argument("--limit", type=int)
    snowball.add_argument("--output", type=Path, required=True)
    snowball.add_argument("--include-abstract", action="store_true")
    return root


def main() -> int:
    args = parser().parse_args()
    metadata, works = collect(args)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fields = BASE_FIELDS + (("abstract",) if args.include_abstract else ())
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output,
            fieldnames=fields,
            dialect="excel-tab",
            lineterminator="\n",
        )
        writer.writeheader()
        for rank, work in enumerate(works, start=1):
            writer.writerow(record(work, rank, args.include_abstract))
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
