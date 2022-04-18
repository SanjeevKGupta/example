export ARCH ?= $(shell hzn architecture)

-include .hzn.json.tmp.mk

all: publish-operator ansible-nginx-deploy-policy

publish-operator:
	make -C operator/ansible operator-service-def
	hzn exchange service publish -O -f horizon/service.definition.json

ansible-nginx-deploy-policy:
	hzn exchange deployment addpolicy -f horizon/operator.ansible.nginx.deploy.policy.json deploy-$(EDGE_OWNER).$(EDGE_DEPLOY).operator.ansible.nginx_$(ARCH)

.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< > $@~
