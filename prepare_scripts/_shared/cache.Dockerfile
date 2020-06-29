
FROM python:3.7-slim

RUN : INSTALL REQUIRED PACKAGES \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
    git curl \
 && apt-get clean

ARG YQ_VERSION=3.3.2

RUN : INSTALL THE "YQ" YAML PROCESSOR \
 && curl -fsSL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
         -o /usr/local/bin/yq \
 && chmod +x /usr/local/bin/yq

ARG EPIPHANY_REMOTE
ARG EPIPHANY_BRANCH

WORKDIR /workspaces/epiphany/

RUN : CLONE EPIPHANY GITHUB REPO \
 && git clone --branch=${EPIPHANY_BRANCH} ${EPIPHANY_REMOTE} .

WORKDIR /workspaces/epiphany/core/src/epicli/

RUN : INSTALL PIP REQUIREMENTS \
 && pip3 --no-cache-dir install -r ./.devcontainer/requirements.txt

RUN : PRINT EPIPHANY VERSION \
 && PYTHONPATH=$(pwd) python3 ./cli/epicli.py --version

ENTRYPOINT []
CMD []

# vim:ts=2:sw=2:et:syn=dockerfile:
