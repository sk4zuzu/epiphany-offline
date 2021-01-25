#!/usr/bin/env bash

: ${EPIPHANY_OFFLINE_WORKSPACE:=/terraform/epiphany-offline}
: ${EPIPHANY_OFFLINE_REMOTE:=https://github.com/epiphany-platform/epiphany-offline.git}
: ${EPIPHANY_OFFLINE_BRANCH:=develop}

set -o errexit -o nounset -o pipefail
set -x

install -d ${EPIPHANY_OFFLINE_WORKSPACE}/

cd ${EPIPHANY_OFFLINE_WORKSPACE}/

git clone --branch=${EPIPHANY_OFFLINE_BRANCH} ${EPIPHANY_OFFLINE_REMOTE} . || git fetch origin ${EPIPHANY_OFFLINE_BRANCH}

git checkout ${EPIPHANY_OFFLINE_BRANCH}

git clean -df

git reset --hard origin/${EPIPHANY_OFFLINE_BRANCH}

sync
