#!/usr/bin/env python3
"""Freeze title-screening results from a Crossref bibliographic query."""

import argparse
import csv
from datetime import date, datetime, timezone
import json
from pathlib import Path
import sys
import urllib.parse
import urllib.request


USER_AGENT = "dataflow-selection-enumeration/0 (mailto:qobilidop@gmail.com)"
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


def iso_date(value: str) -> str:
    try:
        return date.fromisoformat(value).isoformat()
    except ValueError as error:
        raise argparse.ArgumentTypeError(f"invalid ISO date: {value}") from error


def collect(
    query: str,
    limit: int,
    from_date: str | None = None,
    to_date: str | None = None,
) -> tuple[dict[str, object], list[dict[str, str]]]:
    if (from_date is None) != (to_date is None):
        raise SystemExit("provide both --from-date and --to-date")
    if from_date and from_date > to_date:
        raise SystemExit("--from-date must not be later than --to-date")

    parameter_values = {
        "query.bibliographic": query,
        "rows": str(limit),
        "mailto": "qobilidop@gmail.com",
    }
    sort = "relevance"
    if from_date:
        parameter_values.update(
            {
                "filter": (
                    f"from-created-date:{from_date},until-created-date:{to_date}"
                ),
            }
        )
    parameters = urllib.parse.urlencode(parameter_values)
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
        "captured_at": datetime.now(timezone.utc).isoformat(),
        "query": query,
        "hits": int(message.get("total-results", len(records))),
        "exported": len(records),
        "sort": sort,
    }
    if from_date:
        metadata["from_created_date"] = from_date
        metadata["until_created_date"] = to_date
    return metadata, records


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("query")
    result.add_argument("--limit", type=int, default=50)
    result.add_argument("--from-date", type=iso_date)
    result.add_argument("--to-date", type=iso_date)
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    if not 1 <= args.limit <= 1000:
        raise SystemExit("Crossref search limit must be in 1..1000")
    metadata, records = collect(
        args.query, args.limit, args.from_date, args.to_date
    )
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
