export ARCH ?= $(shell hzn architecture)

-include .hzn.json.tmp.mk

publish-operator:
	make -C operator/ansible operator-service-def
	hzn exchange service publish -O -f horizon/service.definition.json

.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< > $@~
