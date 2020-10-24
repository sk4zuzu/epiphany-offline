SELF := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

COMPOSE_FILE := $(abspath $(SELF)/../_shared/docker-compose.SHARED.yml)

export

include $(SELF)/../_shared/Makefile.SHARED
