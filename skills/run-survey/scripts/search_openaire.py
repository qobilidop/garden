#!/usr/bin/env python3
"""Export OpenAIRE Graph search results for audited title screening."""

import argparse
import csv
import json
from pathlib import Path
import sys
import urllib.parse
import urllib.request


API_ROOT = "https://api.openaire.eu/graph/v3/research-products"
FIELDS = (
    "rank",
    "source_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
    "abstract",
)
USER_AGENT = "garden-surveys/0 (mailto:qobilidop@gmail.com)"


def text(value: object) -> str:
    return str(value or "")


def doi(record: dict) -> str:
    for identifier in record.get("pids") or []:
        if text(identifier.get("scheme")).lower() == "doi":
            return text(identifier.get("value"))
    return ""


def venue(record: dict) -> str:
    container = record.get("container") or {}
    if isinstance(container, dict):
        for key in ("name", "title", "conferencePlace"):
            if container.get(key):
                return text(container[key])
    return text(record.get("publisher"))


def kind(record: dict) -> str:
    instances = record.get("instances") or []
    for instance in instances:
        if instance.get("type"):
            return text(instance["type"])
    return text(record.get("type"))


def abstract(record: dict) -> str:
    descriptions = record.get("descriptions") or []
    return text(descriptions[0]) if descriptions else ""


def collect(query: str, limit: int) -> tuple[dict[str, object], list[dict]]:
    parameters = urllib.parse.urlencode(
        {
            "search": query,
            "type": "publication",
            "page": "1",
            "pageSize": str(limit),
        }
    )
    request = urllib.request.Request(
        f"{API_ROOT}?{parameters}", headers={"User-Agent": USER_AGENT}
    )
    with urllib.request.urlopen(request, timeout=60) as response:
        payload = json.load(response)
    header = payload.get("header") or {}
    records = payload.get("results") or []
    metadata = {
        "source": "OpenAIRE Graph API v3",
        "query": query,
        "hits": int(header.get("numFound") or 0),
        "exported": len(records),
    }
    return metadata, records


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("query")
    result.add_argument("--limit", type=int, default=100)
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    if not 1 <= args.limit <= 100:
        raise SystemExit("OpenAIRE search limit must be in 1..100")
    metadata, records = collect(args.query, args.limit)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=FIELDS, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, record in enumerate(records, start=1):
            publication_date = text(record.get("publicationDate"))
            writer.writerow(
                {
                    "rank": rank,
                    "source_id": text(record.get("id")) or f"record-{rank}",
                    "year": publication_date[:4],
                    "doi": doi(record),
                    "title": text(record.get("mainTitle")),
                    "venue": venue(record),
                    "type": kind(record),
                    "abstract": abstract(record),
                }
            )
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
