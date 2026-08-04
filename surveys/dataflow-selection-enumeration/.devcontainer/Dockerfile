FROM ghcr.io/qobilidop/xlsynth-symex/dev:main

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        biber \
        chktex \
        ghostscript \
        latexmk \
        poppler-utils \
        texlive-bibtex-extra \
        texlive-fonts-recommended \
        texlive-latex-base \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-science \
    && rm -rf /var/lib/apt/lists/*
