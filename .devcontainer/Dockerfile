FROM ubuntu:24.04

# Single authority on tool versions; keep pins in sync with tools/*.sh needs.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git curl ca-certificates unzip python3 python3-venv \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL https://rclone.org/install.sh | bash

# Python tools live in one venv (avoids PEP 668 fights with the system python).
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir pymupdf4llm==1.28.2
ENV PATH="/opt/venv/bin:$PATH"
