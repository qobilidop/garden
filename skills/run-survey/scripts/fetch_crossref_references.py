#!/usr/bin/env python3
"""Export a publisher-deposited Crossref bibliography for title screening."""

import argparse
import csv
import json
from pathlib import Path
import sys
import time
import urllib.parse
import urllib.request
from urllib.error import HTTPError, URLError


USER_AGENT = "garden-surveys/0 (mailto:qobilidop@gmail.com)"
FIELDS = ("rank", "source_id", "year", "doi", "title", "venue", "type")


def request_json(url: str) -> dict:
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=60) as response:
        return json.load(response)["message"]


def work(doi: str) -> dict:
    encoded = urllib.parse.quote(doi, safe="")
    return request_json(f"https://api.crossref.org/works/{encoded}")


def first(value: object) -> str:
    if isinstance(value, list):
        return str(value[0]) if value else ""
    return str(value or "")


def year(item: dict) -> str:
    for field in ("published-print", "published-online", "published", "issued"):
        parts = (item.get(field) or {}).get("date-parts") or []
        if parts and parts[0]:
            return str(parts[0][0])
    return ""


def resolve(reference: dict, rank: int) -> dict[str, str]:
    doi = str(reference.get("DOI") or "")
    item: dict = {}
    if doi:
        try:
            item = work(doi)
            time.sleep(0.05)
        except (HTTPError, URLError, TimeoutError):
            item = {}

    title = first(item.get("title")) or str(reference.get("article-title") or "")
    if not title:
        title = str(reference.get("volume-title") or "")
    if not title:
        title = str(reference.get("unstructured") or "")
    source_id = doi or str(reference.get("key") or f"reference-{rank}")
    return {
        "source_id": source_id,
        "year": year(item) or str(reference.get("year") or ""),
        "doi": doi,
        "title": title.replace("\t", " ").replace("\n", " "),
        "venue": first(item.get("container-title"))
        or str(reference.get("journal-title") or ""),
        "type": str(item.get("type") or "reference"),
    }


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("doi")
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    seed = work(args.doi)
    references = seed.get("reference") or []
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=FIELDS, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, reference in enumerate(references, start=1):
            writer.writerow({"rank": rank, **resolve(reference, rank)})
    print(
        json.dumps(
            {
                "source": "Crossref publisher-deposited bibliography",
                "doi": args.doi,
                "hits": len(references),
                "exported": len(references),
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
