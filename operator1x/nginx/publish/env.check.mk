# Sets the scope so that multiple users can use the same instance

BLACK=\033[0;30m
BBLACK=\033[1;30m
RED=\033[0;31m
BRED=\033[1;31m
GREEN=\033[0;32m
BGREEN=\033[1;32m
ORANGE=\033[0;33m
BORANGE=\033[1;33m
NC=\033[0m

export ARCH ?= $(shell hzn architecture)

ifndef EDGE_OWNER
$(error EDGE_OWNER is not set. Set to com or your two-letter initials e.g: export EDGE_OWNER=sg.edge )
endif

# Lets you manage and deploy different group of code across dev, demo, test, prod
ifndef EDGE_DEPLOY
$(error EDGE_DEPLOY is not set. Set to either dev, demo, test, prod etc. e.g: export EDGE_DEPLOY=example.visual )
endif

# Docker base. Usually your login account
ifndef DOCKER_BASE
$(error DOCKER_BASE is not set. export DOCKER_BASE=<your-docker-account-base> )
endif

ifndef HZN_ORG_ID
$(error HZN_ORG_ID is not set. export HZN_ORG_ID=mycluster))
endif

ifndef HZN_EXCHANGE_USER_AUTH
$(error HZN_EXCHANGE_USER_AUTH is not set. export HZN_EXCHANGE_USER_AUTH=iamapikey:<your-iamapikey> )
endif

ifndef CR_DOCKER_HOST
$(error CR_DOCKER_HOST is not set. export CR_DOCKER_HOST=index.docker.io )
endif

ifndef CR_DOCKER_USERNAME
$(error CR_DOCKER_USERNAME is not set. export CR_DOCKER_USERNAME=<docker-user-id> )
endif

ifndef CR_DOCKER_APIKEY
$(error CR_DOCKER_APIKEY is not set. export CR_DOCKER_APIKEY=<docker-apikey> )
endif

#ifndef APP_BIND_HORIZON_DIR
#$(error APP_BIND_HORIZON_DIR is not set. export APP_BIND_HORIZON_DIR=/var/local/horizon )
#endif
