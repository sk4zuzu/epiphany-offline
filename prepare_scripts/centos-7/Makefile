SELF := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))
NAME := $(notdir $(SELF))

EPIPHANY_REMOTE ?= https://github.com/epiphany-platform/epiphany.git
EPIPHANY_BRANCH ?= develop

DESTINATION_IMAGE ?= centos:7

HOST_UID ?= $(shell id -u)
HOST_GID ?= $(shell id -g)

OUTPUT_DIR ?= $(SELF)/output

export

include $(SELF)/../_shared/Makefile.SHARED
