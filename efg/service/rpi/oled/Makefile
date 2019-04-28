#
# Makefile for Edge Fabric Gateway (efgateway)
#

VERSION:= '0.0.2'
DOCKER_NAME:= arm_rpii2coled

IMAGE_NAME:= $(DOCKER_HUB_ID)/$(DOCKER_NAME):$(SERVICE_VERSION)

ARCH:= $(shell hzn node list | jq .configuration.architecture)
HOST_IP:= $(shell hostname -I | cut -d ' ' -f1)

default: all

all: build run
#all: build run check

debug: build test

build:
	docker build -f Dockerfile.$(ARCH) -t $(IMAGE_NAME) .

test:
#	docker run --env HOST_IP=$(HOST_IP) --device=/dev/i2c-1:/dev/i2c-1 -it $(DOCKER_NAME)
#       docker run -it --volume `pwd`:/outside $(DOCKER_NAME) /bin/sh
	docker run --device=/dev/i2c-1:/dev/i2c-1 -it $(IMAGE_NAME)

run:
	-docker rm -f $(IMAGE_NAME) 2>/dev/null || :
#        docker run  -d --name $(DOCKER_NAME) --device=/dev/i2c-1:/dev/i2c-1
#	docker run -d --name $(DOCKER_NAME) -e MOCK=true -e VERBOSE=1 -e PUBLISH=false $(DOCKER_NAME)
#	docker run -d --name $(DOCKER_NAME) -e MOCK=true -e VERBOSE=1 -e PUBLISH=false --device=/dev/i2c-1:/dev/i2c-1 $(IMAGE_NAME)
	docker run -d --name $(DOCKER_NAME) --device=/dev/i2c-1:/dev/i2c-1 $(IMAGE_NAME)

check:
	docker logs -f $(DOCKER_NAME)

docker-push: build
	docker push $(IMAGE_NAME)

#	: $${HZN_ORG_ID:?} $${HZN_EXCHANGE_USER_AUTH:?} $${PRIVATE_KEY_FILE:?} $${PUBLIC_KEY_FILE:?} 
publish-service:
	hzn exchange service publish -k $$PRIVATE_KEY_FILE -K $$PUBLIC_KEY_FILE -f horizon/service.definition.json

#: $${HZN_ORG_ID:?} $${HZN_EXCHANGE_USER_AUTH:?}   # this verifies these env vars are set
publish-pattern:
	hzn exchange pattern publish -p $$SERVICE_NAME -f horizon/pattern/pat_pub_rpii2coled.json

register-node:
	hzn register -n $$EXCHANGE_NODEAUTH $$HZN_ORG_ID $$PATTERN -f horizon/pattern/pat_reg_node_input.json
