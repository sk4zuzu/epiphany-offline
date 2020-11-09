SHELL := $(shell which bash)
SELF  := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

export

.PHONY: all

all: apply

.PHONY: plan apply destroy init

init:
	terraform $@

plan apply destroy: init
	terraform $@

.PHONY: ubuntu centos redhat

ubuntu:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-ubuntu[0]'
	terraform apply

centos:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-centos[0]'
	terraform apply

redhat:
	-terraform state rm 'null_resource.aws-public-clone[0]' 'null_resource.aws-public-redhat[0]'
	terraform apply

.PHONY: ssh

ssh:
	$(shell terraform output _ssh)
