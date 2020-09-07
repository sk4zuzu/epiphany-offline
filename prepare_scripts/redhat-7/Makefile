
SELF := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))
NAME := $(notdir $(SELF))

EPIPHANY_REMOTE ?= https://github.com/epiphany-platform/epiphany.git
EPIPHANY_BRANCH ?= develop

DESTINATION_IMAGE ?= registry.access.redhat.com/ubi7:latest

include ./Makefile.SUBSCRIPTION

HOST_UID ?= $(shell id -u)
HOST_GID ?= $(shell id -g)

OUTPUT_DIR ?= $(SELF)/output

export

include $(SELF)/../_shared/Makefile.SHARED

# Overwrite existing recipes:

collect_image: $(SELF)/collect.Dockerfile update_image
	# Make sure the destination image is up to date.
	docker pull $(DESTINATION_IMAGE)
	# Build without context.
	docker build -t epiphany-offline-$(NAME)-prepare_scripts-collect \
	    --build-arg NAME=$(NAME) \
	    --build-arg DESTINATION_IMAGE=$(DESTINATION_IMAGE) \
	    --build-arg SUBSCRIPTION_USERNAME=$(SUBSCRIPTION_USERNAME) \
	    --build-arg SUBSCRIPTION_PASSWORD=$(SUBSCRIPTION_PASSWORD) \
	    --build-arg HOST_UID=$(HOST_UID) \
	    --build-arg HOST_GID=$(HOST_GID) \
	    - < $<

# vim:ts=4:sw=4:noet:syn=make:
