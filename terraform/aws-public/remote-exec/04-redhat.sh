#!/usr/bin/env bash

: ${EPIPHANY_OFFLINE_WORKSPACE:=/terraform/epiphany-offline}
: ${EPIPHANY_OS_VARIANT:=redhat-7}

set -o errexit -o nounset -o pipefail
set -x

cd ${EPIPHANY_OFFLINE_WORKSPACE}/prepare_scripts/${EPIPHANY_OS_VARIANT}/

make prepare_scripts

cd ${EPIPHANY_OFFLINE_WORKSPACE}/image_registry/${EPIPHANY_OS_VARIANT}/

make down up_no_logs

sync
