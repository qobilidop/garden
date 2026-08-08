#!/usr/bin/env python3
"""Print a fail-closed Co-Authored-By trailer for the active Codex session."""

from __future__ import annotations

import json
import os
from pathlib import Path
import re
import sqlite3
import sys


class ResolutionError(RuntimeError):
    pass


def codex_home() -> Path:
    configured = os.environ.get("CODEX_HOME")
    return Path(configured).expanduser() if configured else Path.home() / ".codex"


def active_thread_id() -> str:
    thread_id = os.environ.get("CODEX_THREAD_ID", "").strip()
    if not thread_id:
        raise ResolutionError("CODEX_THREAD_ID is unavailable; refusing to guess the model")
    return thread_id


def thread_record(home: Path, thread_id: str) -> tuple[Path | None, str | None]:
    databases = sorted(
        home.glob("state_*.sqlite"),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    for database in databases:
        try:
            with sqlite3.connect(f"{database.as_uri()}?mode=ro", uri=True) as connection:
                row = connection.execute(
                    "SELECT rollout_path, model FROM threads WHERE id = ?", (thread_id,)
                ).fetchone()
        except (OSError, sqlite3.Error):
            continue
        if row:
            rollout = Path(row[0]).expanduser() if row[0] else None
            return rollout, row[1]
    raise ResolutionError(f"active thread {thread_id!r} was not found in Codex runtime state")


def latest_turn_model(rollout: Path | None) -> str | None:
    if rollout is None or not rollout.is_file():
        return None
    model = None
    try:
        with rollout.open(encoding="utf-8") as stream:
            for line in stream:
                try:
                    item = json.loads(line)
                except json.JSONDecodeError:
                    # The app may be writing the final line concurrently.
                    continue
                if item.get("type") != "turn_context":
                    continue
                payload = item.get("payload")
                if isinstance(payload, dict) and isinstance(payload.get("model"), str):
                    model = payload["model"]
    except OSError:
        return None
    return model


def catalog_display_name(home: Path, model: str) -> str | None:
    try:
        data = json.loads((home / "models_cache.json").read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return None
    models = data.get("models") if isinstance(data, dict) else None
    if not isinstance(models, list):
        return None
    for entry in models:
        if isinstance(entry, dict) and entry.get("slug") == model:
            display = entry.get("display_name")
            return display if isinstance(display, str) and display.strip() else None
    return None


def human_model_name(home: Path, model: str) -> str:
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._:-]*", model):
        raise ResolutionError(f"unsafe model identifier in runtime state: {model!r}")

    display = catalog_display_name(home, model)
    if display is None:
        match = re.fullmatch(r"gpt-(\d+(?:\.\d+)*)(?:-(.+))?", model, re.IGNORECASE)
        if match:
            suffix = match.group(2)
            display = f"GPT-{match.group(1)}"
            if suffix:
                display += " " + " ".join(part.capitalize() for part in suffix.split("-"))
        else:
            display = " ".join(part.capitalize() for part in model.split("-"))

    # The catalog uses names such as GPT-5.6-Sol; repository history uses
    # "GPT-5.6 Sol" while retaining the version hyphen.
    display = re.sub(r"^(GPT-\d+(?:\.\d+)*?)-(.+)$", r"\1 \2", display)
    display = display.replace("-", " ") if not display.startswith("GPT-") else display
    display = " ".join(display.split())
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9 ._()+-]*", display):
        raise ResolutionError(f"unsafe model display name in catalog: {display!r}")
    return display if display.lower().startswith("codex ") else f"Codex {display}"


def main() -> int:
    try:
        home = codex_home()
        rollout, thread_model = thread_record(home, active_thread_id())
        model = latest_turn_model(rollout) or thread_model
        if not model:
            raise ResolutionError("the active thread does not record a model")
        print(f"Co-Authored-By: {human_model_name(home, model)} <codex@openai.com>")
    except ResolutionError as error:
        print(f"coauthor: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
