#!/usr/bin/env python3
"""Freeze title-screening results from a Crossref bibliographic query."""

import argparse
import csv
import json
from pathlib import Path
import sys
import urllib.parse
import urllib.request


USER_AGENT = "xlsynth-symex-paper/0 (mailto:qobilidop@gmail.com)"
FIELDS = ("rank", "source_id", "year", "doi", "title", "venue", "type")


def text(value: object) -> str:
    if isinstance(value, list):
        return str(value[0]) if value else ""
    return str(value or "")


def publication_year(item: dict) -> str:
    for field in ("published-print", "published-online", "published", "issued"):
        parts = (item.get(field) or {}).get("date-parts") or []
        if parts and parts[0]:
            return str(parts[0][0])
    return ""


def collect(query: str, limit: int) -> tuple[dict[str, object], list[dict[str, str]]]:
    parameters = urllib.parse.urlencode(
        {
            "query.bibliographic": query,
            "rows": str(limit),
            "mailto": "qobilidop@gmail.com",
        }
    )
    request = urllib.request.Request(
        f"https://api.crossref.org/works?{parameters}",
        headers={"User-Agent": USER_AGENT},
    )
    with urllib.request.urlopen(request, timeout=60) as response:
        message = json.load(response)["message"]

    records = []
    for item in message.get("items", []):
        doi = text(item.get("DOI"))
        records.append(
            {
                "source_id": doi or text(item.get("URL")),
                "year": publication_year(item),
                "doi": doi,
                "title": text(item.get("title")),
                "venue": text(item.get("container-title")),
                "type": text(item.get("type")),
            }
        )
    metadata = {
        "source": "Crossref REST API",
        "query": query,
        "hits": int(message.get("total-results", len(records))),
        "exported": len(records),
    }
    return metadata, records


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("query")
    result.add_argument("--limit", type=int, default=50)
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    metadata, records = collect(args.query, args.limit)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=FIELDS, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, record in enumerate(records, start=1):
            writer.writerow({"rank": rank, **record})
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
