-include horizon/.hzn.json.tmp.mk

export ARCH ?= $(shell hzn architecture)

build:
	docker build -t $(DOCKER_IMAGE_BASE)_$(ARCH):$(SERVICE_VERSION) -f ./Dockerfile.$(ARCH) .

publish-service:
	hzn exchange service publish -f horizon/service.definition.json

publish-pattern:
	hzn exchange pattern publish -f horizon/pattern.json

horizon/.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< > $@
