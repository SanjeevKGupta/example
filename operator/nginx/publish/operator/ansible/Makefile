# Makefile

# Check all necessary environment variables
-include ../../env.check.mk

OPERATOR_VERSION ?= 0.0.5
OPERATOR_KIND ?= EdgeApplicationOperator

## You may not need to modify anything below.
## But do review based on your choice of edge cluster such as OCP vs k3s e.g. route is not applicable for k3s and is OCP concept 
OPERATOR_KIND_LC ?= $(shell echo $(OPERATOR_KIND) | tr A-Z a-z)

OPERATOR_TYPE ?= $(notdir $(CURDIR:/=))

OPERATOR_DASH_NAME ?= $(subst .,-,$(EDGE_OWNER))-example-operator-$(OPERATOR_TYPE)-nginx
OPERATOR_DOT_NAME = $(subst -,.,$(OPERATOR_DASH_NAME))
OPERATOR_DOT_NAME_ARCH ?= $(OPERATOR_DOT_NAME)_$(ARCH)

OPERATOR_CR_IMAGE ?= $(CR_DOCKER_HOST)/$(CR_DOCKER_USERNAME)/$(OPERATOR_DOT_NAME_ARCH):$(OPERATOR_VERSION)

operator-push: new-operator build push

operator-apply: operator-push route apply

operator-tar: operator-push route tar 

operator-service-def: operator-push route tar update-service-def

new-operator:
	if [ ! -d "$(OPERATOR_DASH_NAME)" ]; then \
		operator-sdk new "$(OPERATOR_DASH_NAME)" --type=$(OPERATOR_TYPE) --api-version="$(OPERATOR_DOT_NAME)/v1alpha1" --kind=$(OPERATOR_KIND); \
	fi

build:
	cp templates/*.yml $(OPERATOR_DASH_NAME)/roles/$(OPERATOR_KIND_LC)/templates/.
	cp tasks/*.yml $(OPERATOR_DASH_NAME)/roles/$(OPERATOR_KIND_LC)/tasks/.
	cd $(OPERATOR_DASH_NAME); operator-sdk build $(OPERATOR_CR_IMAGE)

push:
	docker login -u $(CR_DOCKER_USERNAME) -p $(CR_DOCKER_APIKEY) $(CR_DOCKER_HOST)
	docker push $(OPERATOR_CR_IMAGE)
	sed -i -e "s'REPLACE_IMAGE'$(OPERATOR_CR_IMAGE)'" "$(OPERATOR_DASH_NAME)/deploy/operator.yaml"

route:
	if [ -f "deploy/role.yaml" ]; then \
		cat deploy/role.yaml >> "$(OPERATOR_DASH_NAME)/deploy/role.yaml"; \
	fi

apply:
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/crds/$(OPERATOR_DOT_NAME)_$(OPERATOR_KIND_LC)s_crd.yaml
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/service_account.yaml 
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/role.yaml
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/role_binding.yaml
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/operator.yaml
	kubectl apply -f $(OPERATOR_DASH_NAME)/deploy/crds/$(OPERATOR_DOT_NAME)_v1alpha1_$(OPERATOR_KIND_LC)_cr.yaml 

test:
	curl `kubectl get route -o jsonpath='{.items[0].status.ingress[0].host}'`

tar:
	cd $(OPERATOR_DASH_NAME); tar -zcvf ../../$(OPERATOR_DASH_NAME).tar.gz deploy/*

update-service-def:
	sed -i -e 's/.*SERVICE_NAME.*/\t"SERVICE_NAME": "$(OPERATOR_DOT_NAME)",/' ../../horizon/hzn.json
	sed -i -e 's/.*SERVICE_VERSION.*/\t"SERVICE_VERSION": "$(OPERATOR_VERSION)"/' ../../horizon/hzn.json
	sed -i -e 's/.*operatorYamlArchive.*/\t"operatorYamlArchive": "..\/operator\/$(OPERATOR_DASH_NAME).tar.gz"/' ../../horizon/service.definition.json

watch:
	watch -n 2 kubectl get pods

get-route:
	kubectl get route -o jsonpath='{.items[0].status.ingress[0].host}'

delete:
	kubectl delete crd $(OPERATOR_KIND_LC)s.$(OPERATOR_DOT_NAME)
	kubectl delete deployment $(OPERATOR_DASH_NAME)
	kubectl delete serviceaccount $(OPERATOR_DASH_NAME)
	kubectl delete rolebinding $(OPERATOR_DASH_NAME)
	kubectl delete role $(OPERATOR_DASH_NAME)
	rm -rf $(OPERATOR_DASH_NAME)

