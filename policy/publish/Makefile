#
# Makefile
#

# Checks required environment variables
-include env.check.mk

all: publish-service1 publish-service2 

publish-service1:
	make -C src/service1 build
	make -C src/service1 push
	make -C src/service1 publish-service

publish-service2:
	make -C src/service2 build
	make -C src/service2 push
	make -C src/service2 publish-service
