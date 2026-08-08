FROM ubuntu:24.04

# Single authority on tool versions; keep pins in sync with tools/*.sh needs.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git curl ca-certificates unzip xz-utils python3 python3-venv \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL https://rclone.org/install.sh | bash

# Leak-guard scanner, pinned; release naming maps amd64 -> x64.
# Keep in sync with GITLEAKS_VERSION in .github/workflows/gitleaks.yml.
ARG TARGETARCH
RUN A="$TARGETARCH"; [ "$A" = "amd64" ] && A=x64; \
    curl -fsSL "https://github.com/gitleaks/gitleaks/releases/download/v8.30.1/gitleaks_8.30.1_linux_${A}.tar.gz" \
    | tar -xz -C /usr/local/bin gitleaks

# Node toolchain for site/, pinned; release naming maps amd64 -> x64.
ENV NODE_VERSION=24.19.0
RUN A="$TARGETARCH"; [ "$A" = "amd64" ] && A=x64; \
    curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${A}.tar.xz" \
    | tar -xJ -C /usr/local --strip-components=1

# Python tools live in one venv (avoids PEP 668 fights with the system python).
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir pymupdf4llm==1.28.2
ENV PATH="/opt/venv/bin:$PATH"
