#!/usr/bin/env python3
"""Synchronize canonical Codex user configuration with the live Codex home."""

from __future__ import annotations

import copy
import difflib
import json
import os
from pathlib import Path
import re
import stat
import sys
import tempfile
import tomllib
from typing import Any, Iterable


REPO = Path(__file__).resolve().parent
CANONICAL_CONFIG = REPO / "config.toml"
FILE_MAP = (
    (REPO / "user-AGENTS.md", Path("AGENTS.md"), 0o644),
    (REPO / "coauthor.py", Path("bin/coauthor"), 0o755),
)
BARE_KEY = re.compile(r"[A-Za-z0-9_-]+")


class SyncError(RuntimeError):
    pass


def live_home() -> Path:
    configured = os.environ.get("CODEX_HOME")
    return Path(configured).expanduser() if configured else Path.home() / ".codex"


def load_toml(path: Path) -> tuple[str, dict[str, Any]]:
    try:
        text = path.read_text(encoding="utf-8")
    except OSError as error:
        raise SyncError(f"cannot read {path}: {error.strerror}") from error
    try:
        return text, tomllib.loads(text)
    except tomllib.TOMLDecodeError as error:
        raise SyncError(f"invalid TOML in {path}: {error}") from error


def leaves(value: Any, prefix: tuple[str, ...] = ()) -> Iterable[tuple[tuple[str, ...], Any]]:
    if isinstance(value, dict):
        for key, child in value.items():
            yield from leaves(child, prefix + (key,))
    else:
        yield prefix, value


def get_path(data: dict[str, Any], path: tuple[str, ...]) -> Any:
    value: Any = data
    try:
        for key in path:
            value = value[key]
    except (KeyError, TypeError) as error:
        raise SyncError(f"live config is missing managed key {'.'.join(path)}") from error
    return value


def remove_path(data: dict[str, Any], path: tuple[str, ...]) -> None:
    parents: list[tuple[dict[str, Any], str]] = []
    value: Any = data
    for key in path[:-1]:
        if not isinstance(value, dict) or key not in value:
            return
        parents.append((value, key))
        value = value[key]
    if isinstance(value, dict):
        value.pop(path[-1], None)
    for parent, key in reversed(parents):
        child = parent.get(key)
        if isinstance(child, dict) and not child:
            del parent[key]
        else:
            break


def key_literal(key: str) -> str:
    return key if BARE_KEY.fullmatch(key) else json.dumps(key, ensure_ascii=False)


def value_literal(value: Any) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if isinstance(value, int) and not isinstance(value, bool):
        return str(value)
    if isinstance(value, float):
        if value == float("inf"):
            return "inf"
        if value == float("-inf"):
            return "-inf"
        if value != value:
            return "nan"
        return repr(value)
    if isinstance(value, list):
        return "[" + ", ".join(value_literal(item) for item in value) + "]"
    raise SyncError(f"managed value has unsupported TOML type: {type(value).__name__}")


def marker_path(value: Any, prefix: tuple[str, ...] = ()) -> tuple[str, ...] | None:
    if not isinstance(value, dict):
        return None
    for key, child in value.items():
        if key == "__garden_marker__":
            return prefix
        found = marker_path(child, prefix + (key,))
        if found is not None:
            return found
    return None


def parse_header(line: str) -> tuple[str, ...] | None:
    stripped = line.strip()
    if not stripped.startswith("[") or stripped.startswith("[["):
        return None
    try:
        parsed = tomllib.loads(f"{stripped}\n__garden_marker__ = true\n")
    except tomllib.TOMLDecodeError:
        return None
    return marker_path(parsed)


def table_blocks(lines: list[str]) -> dict[tuple[str, ...], tuple[int, int]]:
    headers: list[tuple[int, tuple[str, ...] | None]] = []
    for index, line in enumerate(lines):
        stripped = line.lstrip()
        if stripped.startswith("["):
            headers.append((index, parse_header(line)))
    blocks: dict[tuple[str, ...], tuple[int, int]] = {}
    blocks[()] = (0, headers[0][0] if headers else len(lines))
    for position, (index, path) in enumerate(headers):
        if path is None:
            continue
        end = headers[position + 1][0] if position + 1 < len(headers) else len(lines)
        blocks[path] = (index + 1, end)
    return blocks


def assignment_key(line: str) -> str | None:
    stripped = line.strip()
    if not stripped or stripped.startswith("#") or stripped.startswith("["):
        return None
    try:
        parsed = tomllib.loads(stripped + "\n")
    except tomllib.TOMLDecodeError:
        return None
    found = list(leaves(parsed))
    return found[0][0][0] if len(found) == 1 and len(found[0][0]) == 1 else None


def render_header(path: tuple[str, ...]) -> str:
    return "[" + ".".join(key_literal(part) for part in path) + "]\n"


def set_text_value(text: str, path: tuple[str, ...], value: Any) -> str:
    lines = text.splitlines(keepends=True)
    blocks = table_blocks(lines)
    table, key = path[:-1], path[-1]
    replacement = f"{key_literal(key)} = {value_literal(value)}\n"

    if table not in blocks:
        suffix = "" if not text or text.endswith("\n") else "\n"
        separator = "" if not text.strip() else "\n"
        return text + suffix + separator + render_header(table) + replacement

    start, end = blocks[table]
    for index in range(start, end):
        if assignment_key(lines[index]) == key:
            indent = lines[index][: len(lines[index]) - len(lines[index].lstrip())]
            lines[index] = indent + replacement
            return "".join(lines)

    key_forms = (re.escape(key), re.escape(json.dumps(key, ensure_ascii=False)))
    suspicious = re.compile(rf"^\s*(?:{'|'.join(key_forms)})\s*=")
    if any(suspicious.match(lines[index]) for index in range(start, end)):
        raise SyncError(f"managed key {'.'.join(path)} uses an unsupported multiline value")
    lines.insert(end, replacement)
    return "".join(lines)


def patch_text(text: str, values: Iterable[tuple[tuple[str, ...], Any]]) -> str:
    for path, value in values:
        text = set_text_value(text, path, value)
    return text


def signature(path: Path) -> tuple[int, int, int, int]:
    info = path.stat()
    return info.st_dev, info.st_ino, info.st_size, info.st_mtime_ns


def atomic_write(
    path: Path,
    data: bytes,
    mode: int,
    expected: tuple[int, int, int, int] | None = None,
) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.is_symlink():
        raise SyncError(f"refusing to replace symlink {path}")
    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            prefix=f".{path.name}.garden-", dir=path.parent, delete=False
        ) as stream:
            temporary = Path(stream.name)
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        os.chmod(temporary, mode)
        if expected is not None and (not path.exists() or signature(path) != expected):
            raise SyncError(f"{path} changed during sync; retry after reconciling drift")
        os.replace(temporary, path)
        temporary = None
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def unified(old: str, new: str, old_name: str, new_name: str) -> str:
    return "".join(
        difflib.unified_diff(
            old.splitlines(keepends=True),
            new.splitlines(keepends=True),
            fromfile=old_name,
            tofile=new_name,
        )
    )


def managed_values(
    canonical: dict[str, Any], live: dict[str, Any]
) -> list[tuple[tuple[str, ...], Any]]:
    return [(path, get_path(live, path)) for path, _ in leaves(canonical)]


def diff() -> int:
    home = live_home()
    live_config = home / "config.toml"
    canonical_text, canonical = load_toml(CANONICAL_CONFIG)
    drift = False

    if live_config.exists():
        _, live = load_toml(live_config)
        candidate = patch_text(canonical_text, managed_values(canonical, live))
        if candidate != canonical_text:
            print(
                unified(
                    canonical_text,
                    candidate,
                    str(CANONICAL_CONFIG),
                    f"{live_config} (managed keys)",
                ),
                end="",
            )
            drift = True
    else:
        print(f"missing live file: {live_config}")
        drift = True

    for source, relative, mode in FILE_MAP:
        destination = home / relative
        if not destination.exists():
            print(f"missing live file: {destination}")
            drift = True
            continue
        source_bytes = source.read_bytes()
        destination_bytes = destination.read_bytes()
        if source_bytes != destination_bytes:
            try:
                print(
                    unified(
                        source_bytes.decode(),
                        destination_bytes.decode(),
                        str(source),
                        str(destination),
                    ),
                    end="",
                )
            except UnicodeDecodeError:
                print(f"binary files differ: {source} {destination}")
            drift = True
        actual_mode = stat.S_IMODE(destination.stat().st_mode)
        if actual_mode != mode:
            print(f"mode differs: {destination} is {actual_mode:04o}, expected {mode:04o}")
            drift = True

    if not drift:
        print("in sync")
    return 1 if drift else 0


def pull() -> int:
    home = live_home()
    live_config = home / "config.toml"
    canonical_text, canonical = load_toml(CANONICAL_CONFIG)
    _, live = load_toml(live_config)
    outputs: list[tuple[Path, bytes, int]] = []
    updated = patch_text(canonical_text, managed_values(canonical, live))
    outputs.append(
        (
            CANONICAL_CONFIG,
            updated.encode(),
            stat.S_IMODE(CANONICAL_CONFIG.stat().st_mode),
        )
    )

    for source, relative, mode in FILE_MAP:
        destination = home / relative
        if not destination.is_file():
            raise SyncError(f"cannot pull missing live file {destination}")
        outputs.append((source, destination.read_bytes(), mode))

    for path, data, mode in outputs:
        atomic_write(path, data, mode, signature(path) if path.exists() else None)
        print(f"pulled {path.relative_to(REPO)}")
    return 0


def push() -> int:
    home = live_home()
    live_config = home / "config.toml"
    canonical_text, canonical = load_toml(CANONICAL_CONFIG)
    del canonical_text
    live_text, live = load_toml(live_config)
    values = list(leaves(canonical))
    updated = patch_text(live_text, values)

    try:
        updated_data = tomllib.loads(updated)
    except tomllib.TOMLDecodeError as error:
        raise SyncError(f"merged live config would be invalid TOML: {error}") from error

    before_unmanaged = copy.deepcopy(live)
    after_unmanaged = copy.deepcopy(updated_data)
    for path, _ in values:
        remove_path(before_unmanaged, path)
        remove_path(after_unmanaged, path)
    if before_unmanaged != after_unmanaged:
        raise SyncError("merge changed unmanaged Codex state; refusing to write")

    config_mode = stat.S_IMODE(live_config.stat().st_mode)
    outputs: list[tuple[Path, bytes, int, tuple[int, int, int, int] | None]] = [
        (live_config, updated.encode(), config_mode, signature(live_config))
    ]
    for source, relative, mode in FILE_MAP:
        if not source.is_file():
            raise SyncError(f"missing canonical file {source}")
        destination = home / relative
        outputs.append(
            (
                destination,
                source.read_bytes(),
                mode,
                signature(destination) if destination.exists() else None,
            )
        )

    for path, data, mode, expected in outputs:
        atomic_write(path, data, mode, expected)
        print(f"pushed {path.relative_to(home)}")
    return 0


def main() -> int:
    if len(sys.argv) != 2 or sys.argv[1] not in {"diff", "pull", "push"}:
        print("usage: sync.py diff|pull|push", file=sys.stderr)
        return 2
    try:
        return {"diff": diff, "pull": pull, "push": push}[sys.argv[1]]()
    except (OSError, SyncError) as error:
        print(f"sync: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
