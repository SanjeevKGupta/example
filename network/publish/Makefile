#
# Makefile
#

# Checks required environment variables
-include env.check.mk

all: publish-service1 publish-service2 publish-service-peer publish-service-network-host publish-service-required

publish-service1:
	make -C src/service1 build
	make -C src/service1 push
	make -C src/service1 publish-service
	make -C src/service1 publish-pattern

publish-service2:
	make -C src/service2 build
	make -C src/service2 push
	make -C src/service2 publish-service
	make -C src/service2 publish-pattern

publish-service-peer:
	make -C src/service-peer publish-service
	make -C src/service-peer publish-pattern

publish-service-network-host:
	make -C src/service-network-host publish-service
	make -C src/service-network-host publish-pattern

publish-service-required:
	make -C src/service-network-host publish-service
	make -C src/service-network-host publish-pattern
