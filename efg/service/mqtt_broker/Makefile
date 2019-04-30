#
# Makefile for Edge Fabric Gateway (efgateway)
#

DOCKER_NAME:= arm_mqtt_broker

IMAGE_NAME:= $(DOCKER_HUB_ID)/$(DOCKER_NAME):$(SERVICE_VERSION_MQTT_BROKER)

ARCH:= $(shell hzn node list | jq .configuration.architecture)
HOST_IP:= $(shell hostname -I | cut -d ' ' -f1)

default: all

all: build run
#all: build run check

debug: build test

build:
	docker build -f Dockerfile.$(ARCH) -t $(IMAGE_NAME) .

test:
	docker run -d -p 1883:1883 --name $(DOCKER_NAME) $(IMAGE_NAME) 

run:
	-docker rm -f $(IMAGE_NAME) 2>/dev/null || :
	docker run -d -p 1883:1883 --name $(DOCKER_NAME) $(IMAGE_NAME)

log:
	docker logs -f $(DOCKER_NAME)

docker-push: build
	docker push $(IMAGE_NAME)

#	: $${HZN_ORG_ID:?} $${HZN_EXCHANGE_USER_AUTH:?} $${PRIVATE_KEY_FILE:?} $${PUBLIC_KEY_FILE:?} 
publish-service:
	hzn exchange service publish -k $$PRIVATE_KEY_FILE -K $$PUBLIC_KEY_FILE -f horizon/service.definition.json

#: $${HZN_ORG_ID:?} $${HZN_EXCHANGE_USER_AUTH:?}   # this verifies these env vars are set
publish-pattern:
	hzn exchange pattern publish -p $$SERVICE_NAME_MQTT_BROKER -f horizon/pattern.publish.json

register-node:
	hzn register -n $$EXCHANGE_NODEAUTH $$HZN_ORG_ID $$PATTERN -f horizon/pattern.register.json
