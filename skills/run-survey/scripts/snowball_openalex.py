#!/usr/bin/env python3
"""Export an OpenAlex citation neighborhood (backward or forward) for
screening.

Codifies the snowball procedure first documented prose-first in the
agent-assisted-review-methodology record: resolve the seed to an
OpenAlex work (by DOI, or by exact normalized-title-and-year match),
then export its complete referenced_works (backward) or citing works
via cursor pagination (forward) in the source-neutral screening
schema.
"""

import argparse
import csv
import json
import re
import sys
import urllib.parse
import urllib.request

API_ROOT = "https://api.openalex.org"
USER_AGENT = "sys0-surveys/0 (mailto:qobilidop@gmail.com)"
FIELDS = ["rank", "source_id", "year", "doi", "title", "venue", "type"]
WORK_SELECT = "id,doi,title,publication_year,primary_location,type"


def request_json(path: str, parameters: dict[str, str] | None = None) -> dict:
    query = urllib.parse.urlencode(parameters or {})
    url = f"{API_ROOT}/{path}"
    if query:
        url = f"{url}?{query}"
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=60) as response:
        return json.load(response)


def normalize_title(title: str) -> str:
    return re.sub(r"[^a-z0-9]", "", title.lower())


def resolve_seed(args: argparse.Namespace) -> dict:
    if args.seed_doi:
        return request_json(
            f"works/https://doi.org/{args.seed_doi}", {"select": WORK_SELECT}
        )
    result = request_json(
        "works",
        {
            "filter": f"title.search:{args.seed_title}",
            "select": WORK_SELECT,
            "per-page": "25",
        },
    )
    wanted = normalize_title(args.seed_title)
    matches = [
        work
        for work in result.get("results", [])
        if normalize_title(work.get("title") or "") == wanted
        and work.get("publication_year") == args.seed_year
    ]
    if len(matches) != 1:
        raise SystemExit(
            f"seed title resolution is ambiguous ({len(matches)} exact "
            "normalized-title and year matches); log and skip the seed "
            "rather than guessing"
        )
    return matches[0]


def row(work: dict, rank: int) -> dict[str, object]:
    location = work.get("primary_location") or {}
    source = location.get("source") or {}
    doi = (work.get("doi") or "").removeprefix("https://doi.org/")
    return {
        "rank": rank,
        "source_id": (work.get("id") or "").removeprefix("https://openalex.org/"),
        "year": work.get("publication_year") or "",
        "doi": doi,
        "title": work.get("title") or "",
        "venue": source.get("display_name") or "",
        "type": work.get("type") or "",
    }


def backward(seed_id: str) -> list[dict]:
    seed = request_json(f"works/{seed_id}", {"select": "referenced_works"})
    referenced = seed.get("referenced_works", [])
    works = []
    for start in range(0, len(referenced), 50):
        batch = [
            identifier.removeprefix("https://openalex.org/")
            for identifier in referenced[start : start + 50]
        ]
        result = request_json(
            "works",
            {
                "filter": f"openalex_id:{'|'.join(batch)}",
                "select": WORK_SELECT,
                "per-page": "50",
            },
        )
        works.extend(result.get("results", []))
    return works


def forward(seed_id: str) -> list[dict]:
    works = []
    cursor = "*"
    while cursor:
        result = request_json(
            "works",
            {
                "filter": f"cites:{seed_id}",
                "select": WORK_SELECT,
                "per-page": "200",
                "cursor": cursor,
            },
        )
        works.extend(result.get("results", []))
        cursor = result.get("meta", {}).get("next_cursor")
    return works


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    seed = parser.add_mutually_exclusive_group(required=True)
    seed.add_argument("--seed-doi")
    seed.add_argument("--seed-title")
    parser.add_argument("--seed-year", type=int)
    parser.add_argument(
        "--direction", choices=["backward", "forward"], required=True
    )
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    if args.seed_title and args.seed_year is None:
        parser.error("--seed-title requires --seed-year")

    work = resolve_seed(args)
    seed_id = (work.get("id") or "").removeprefix("https://openalex.org/")
    if not seed_id:
        raise SystemExit("seed resolved without an OpenAlex ID")
    works = backward(seed_id) if args.direction == "backward" else forward(seed_id)

    with open(args.output, "w", newline="") as handle:
        writer = csv.DictWriter(
            handle, fieldnames=FIELDS, delimiter="\t", lineterminator="\n"
        )
        writer.writeheader()
        for rank, item in enumerate(works, start=1):
            writer.writerow(row(item, rank))
    print(
        json.dumps(
            {
                "seed": seed_id,
                "direction": args.direction,
                "exported": len(works),
                "output": args.output,
            }
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
