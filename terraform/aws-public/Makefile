SHELL := $(shell which bash)
SELF  := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

export

.PHONY: all

all: apply

.PHONY: plan apply destroy init refresh

init:
	terraform $@

plan apply destroy: init
	terraform $@

refresh: refresh-ubuntu refresh-centos refresh-redhat apply

.PHONY: refresh-ubuntu refresh-centos refresh-redhat

refresh-ubuntu:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-ubuntu[0]'

refresh-centos:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-centos[0]'

refresh-redhat:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-redhat[0]'

.PHONY: ubuntu centos redhat

ubuntu: refresh-ubuntu apply

centos: refresh-centos apply

redhat: refresh-redhat apply

.PHONY: ssh

ssh:
	$(shell terraform output _ssh)
