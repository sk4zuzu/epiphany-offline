
SELF := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

COMPOSE_FILE := $(abspath $(SELF)/../_shared/docker-compose.SHARED.yml)

export

include $(SELF)/../_shared/Makefile.SHARED

# vim:ts=4:sw=4:noet:syn=make:
