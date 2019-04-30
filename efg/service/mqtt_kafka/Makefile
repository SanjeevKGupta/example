#
# Makefile for EFG - MQTT Kafka
#

DOCKER_NAME:= arm_mqtt_kafka

IMAGE_NAME:= $(DOCKER_HUB_ID)/$(DOCKER_NAME):$(SERVICE_VERSION_MQTT_KAFKA)

ARCH:= $(shell hzn node list | jq .configuration.architecture)
HOST_IP:= $(shell hostname -I | cut -d ' ' -f1)

default: all

all: build
#all: build run
#all: build run check

build:
	mkdir -p tmp/$(ARCH)
	cp ../../../../examples/tools/kafkacat/$(ARCH)/*.rsa.pub ../../../../examples/tools/kafkacat/$(ARCH)/kafkacat-*.apk tmp/$(ARCH)
	docker build -f Dockerfile.$(ARCH) -t $(IMAGE_NAME) .

cli:
	docker run -it -e EVENT_STREAM_API_KEY -e EVENT_STREAM_BROKER_URL -e EVENT_STREAM_EFG_TOPIC --net=host $(IMAGE_NAME) /bin/sh

run:
	-docker rm -f $(IMAGE_NAME) 2>/dev/null || :
	docker run -d  -e EVENT_STREAM_API_KEY -e EVENT_STREAM_BROKER_URL -e EVENT_STREAM_EFG_TOPIC --net=host $(IMAGE_NAME)

log:
	docker logs -f $(DOCKER_NAME)

docker-push: build
	docker push $(IMAGE_NAME)

publish-service:
	hzn exchange service publish -k $$PRIVATE_KEY_FILE -K $$PUBLIC_KEY_FILE -f horizon/service.definition.json

publish-pattern:
	hzn exchange pattern publish -p $$SERVICE_NAME_MQTT_KAFKA -f horizon/pattern.publish.json

register-node:
	hzn register -n $$EXCHANGE_NODEAUTH $$HZN_ORG_ID $$PATTERN -f horizon/pattern.register.json
