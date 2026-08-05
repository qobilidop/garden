FROM ubuntu:24.04@sha256:561618e2c15bf2397621dd04f96926663a3b5616c189cf7e38db7e82f5c538ea

USER root

ARG TYPST_VERSION=0.15.1
ARG TYPST_SHA256=a6d077d0a95eed5a2eba715b2dae06be954f624ccbf85758a03f389ded33118c
ARG UBUNTU_SNAPSHOT=20260804T000000Z

RUN sed --in-place \
        "s|^URIs: http://archive.ubuntu.com/ubuntu/$|URIs: http://snapshot.ubuntu.com/ubuntu/${UBUNTU_SNAPSHOT}|" \
        /etc/apt/sources.list.d/ubuntu.sources \
    && sed --in-place \
        "s|^URIs: http://security.ubuntu.com/ubuntu/$|URIs: http://snapshot.ubuntu.com/ubuntu/${UBUNTU_SNAPSHOT}|" \
        /etc/apt/sources.list.d/ubuntu.sources \
    && printf 'Acquire::https::Verify-Peer "false";\n' \
        > /etc/apt/apt.conf.d/99snapshot-bootstrap

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        ca-certificates \
    && rm /etc/apt/apt.conf.d/99snapshot-bootstrap \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        curl \
        fonts-dejavu-core \
        fonts-linuxlibertine \
        git \
        openssh-client \
        poppler-utils \
        python3 \
        python3-yaml \
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
