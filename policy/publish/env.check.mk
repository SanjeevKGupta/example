# Sets the scope so that multiple users can use the same instance
ifndef EDGE_OWNER
$(error EDGE_OWNER is not set. Set to com or your two-letter initials e.g: export EDGE_OWNER=sg.edge )
endif

# Lets you manage and deploy different group of code across dev, demo, test, prod
ifndef EDGE_DEPLOY
$(error EDGE_DEPLOY is not set. Set to either dev, demo, test, prod etc. e.g: export EDGE_DEPLOY=example.network )
endif

# Docker base. Usually your login account
ifndef DOCKER_BASE
$(error DOCKER_BASE is not set. export DOCKER_BASE=<docker.io/your-docker-account-base> )
endif

ifndef HZN_ORG_ID
$(error HZN_ORG_ID is not set. export HZN_ORG_ID=<your-org-id>))
endif

ifndef HZN_EXCHANGE_USER_AUTH
$(error HZN_EXCHANGE_USER_AUTH is not set. export HZN_EXCHANGE_USER_AUTH=iamapikey:<your-iamapikey> )
endif

