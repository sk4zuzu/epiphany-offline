FROM httpd:2.4

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && : INSTALL OTHER DEPS \
 && apt-get install -y --no-install-recommends bash ca-certificates curl gzip tar \
 && : REMOVE APT CACHE \
 && rm -rf /var/lib/apt/lists/*

ARG HELM_VERSION=3.3.4

RUN : INSTALL HELM BINARY \
 && curl -fsSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    | tar -xz -f- --strip-components=1 -C /tmp/ linux-amd64/helm \
 && mv -f /tmp/helm /usr/local/bin/helm \
 && chmod +x /usr/local/bin/helm

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && : INSTALL CREATEREPO AND DPKG-SCANPACKAGES \
 && apt-get install -y --no-install-recommends createrepo dpkg-dev \
 && : REMOVE APT CACHE \
 && rm -rf /var/lib/apt/lists/*
