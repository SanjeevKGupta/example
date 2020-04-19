
# Checks required environment variables
-include env.check.mk

# You must always use the Horizon name for architecture (`hzn architecture`)
export ARCH ?= $(shell hzn architecture)

# build, push, publish service all

all: publish

publish: publish-http publish-tflite

publish-http:
	make -C src/http
	make -C src/http push
	make -C src/http publish-service

publish-tflite:
	make -C src/tflite
	make -C src/tflite push
	make -C src/tflite publish-service

publish-pattern:
	hzn exchange pattern publish -f pattern/pattern-arch.json

add-business-policy:
	make -C src/tflite add-business-policy
