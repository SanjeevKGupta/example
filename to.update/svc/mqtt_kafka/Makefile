#
# Makefile for EFG - MQTT Kafka
#

ARCH:= $(shell hzn node list | jq .configuration.architecture | sed 's/"//g')

DOCKER_NAME:= $(ARCH)_$(SERVICE_NAME_MQTT_KAFKA)
IMAGE_NAME:= $(DOCKER_HUB_ID)/$(DOCKER_NAME):$(SERVICE_VERSION_MQTT_KAFKA)

default: all

all: build run

build:
	mkdir -p tmp/$(ARCH)
	cp ../../../examples/tools/kafkacat/$(ARCH)/*.rsa.pub ../../../examples/tools/kafkacat/$(ARCH)/kafkacat-*.apk tmp/$(ARCH)
	docker build -f Dockerfile.$(ARCH) -t $(IMAGE_NAME) .

cli:
	docker run -it -e EVENT_STREAM_API_KEY -e EVENT_STREAM_BROKER_URL -e EVENT_STREAM_EFG_TOPIC --net=host $(IMAGE_NAME) /bin/sh

run:
	-docker rm -f $(IMAGE_NAME) 2>/dev/null || :
	docker run -d  -e EVENT_STREAM_API_KEY -e EVENT_STREAM_BROKER_URL -e EVENT_STREAM_EFG_TOPIC --net=host $(IMAGE_NAME)

stop:
	docker stop `docker ps | grep $(IMAGE_NAME) | cut -d' ' -f1`

log:
	docker logs -f $(DOCKER_NAME)

docker-push: build
	docker push $(IMAGE_NAME)

publish-service:
	hzn exchange service publish -k $(PRIVATE_KEY_FILE) -K $(PUBLIC_KEY_FILE) -f horizon/service.definition.json

publish-pattern:
	hzn exchange pattern publish -p $(SERVICE_NAME_MQTT_KAFKA) -f horizon/pattern.publish.json

register-node:
	hzn register -n $(EXCHANGE_NODEAUTH) $(HZN_ORG_ID) $(PATTERN) -f horizon/pattern.register.json
