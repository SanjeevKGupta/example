#
# Makefile
#

# Checks required environment variables
-include env.check.mk

export ARCH ?= $(shell hzn architecture)

-include .hzn.json.tmp.mk

all: prepare-operator-tar publish-service deploy-policy-ansible-nginx

prepare-operator-tar:
	@echo ""
	@echo "${BBLACK}Preparing operator tar ... ${NC}"
	make -C src/ansible operator-tar

publish-service:
	@echo ""
	@echo "${BBLACK}Publishing service ... ${NC}"
	hzn exchange service publish -O -f horizon/service.definition.json

deploy-policy-ansible-nginx:
	@echo ""
	@echo "${BBLACK}Publishing deployment policy ... ${NC}"
	hzn exchange deployment addpolicy -f horizon/operator.ansible.nginx.deploy.policy.json deploy-$(EDGE_OWNER).$(EDGE_DEPLOY).ansible.nginx_$(ARCH)

.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< > $@
