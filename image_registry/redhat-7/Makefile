SELF := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

COMPOSE_FILES := \
$(abspath $(SELF)/../_shared/docker-compose.SHARED.yml) \
$(SELF)/docker-compose.yml

export

include $(SELF)/../_shared/Makefile.SHARED
