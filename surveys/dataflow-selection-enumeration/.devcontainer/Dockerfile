FROM ubuntu:24.04

USER root

ARG TYPST_VERSION=0.15.1
ARG TYPST_SHA256=a6d077d0a95eed5a2eba715b2dae06be954f624ccbf85758a03f389ded33118c

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        ca-certificates \
        curl \
        fonts-dejavu-core \
        fonts-linuxlibertine \
        git \
        openssh-client \
        poppler-utils \
        python3 \
        ripgrep \
        shellcheck \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl --fail --location --silent --show-error \
        --output /tmp/typst.tar.xz \
        "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" \
    && echo "${TYPST_SHA256}  /tmp/typst.tar.xz" | sha256sum --check --strict \
    && tar --extract --xz --file /tmp/typst.tar.xz --directory /tmp \
    && install --mode 0755 \
        /tmp/typst-x86_64-unknown-linux-musl/typst \
        /usr/local/bin/typst \
    && rm --recursive --force \
        /tmp/typst.tar.xz \
        /tmp/typst-x86_64-unknown-linux-musl
