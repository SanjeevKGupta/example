#
# Makefile
#

# Checks required environment variables
-include env.check.mk

export ARCH ?= $(shell hzn architecture)

-include .hzn.json.tmp.mk

all: prepare-operator-tar publish-service ansible-nginx-deploy-policy

prepare-operator-tar:
	make -C src/ansible operator-tar

publish-service:
	hzn exchange service publish -O -f horizon/service.definition.json

ansible-nginx-deploy-policy:
	hzn exchange deployment addpolicy -f horizon/operator.ansible.nginx.deploy.policy.json deploy-$(EDGE_OWNER).$(EDGE_DEPLOY).ansible.nginx_$(ARCH)

.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< > $@
