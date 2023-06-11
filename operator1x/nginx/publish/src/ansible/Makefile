#
# Makefile
#

# Check all necessary environment variables
-include ../../env.check.mk

export ARCH ?= $(shell hzn architecture)

# Import variables from operator.json 
-include .operator.json.tmp.mk

## You may not need to modify anything below.
## But do review based on your choice of edge cluster such as OCP vs k3s e.g. route is not applicable for k3s and is OCP concept 

# deploys the operator and all other objects in this namespace (not openhorizon-agent).  
OPERATOR_NAMESPACE=$(subst .,-,$(EDGE_OWNER))

OPERATOR_KIND_LC = $(shell echo $(OPERATOR_KIND) | tr A-Z a-z)

OPERATOR_TYPE = $(notdir $(CURDIR:/=))

OPERATOR_GROUP_NAME = edge-$(OPERATOR_IMAGE_NAME)
OPERATOR_DASH_NAME = $(subst .,-,$(EDGE_OWNER).$(EDGE_DEPLOY))-$(OPERATOR_TYPE)-$(OPERATOR_IMAGE_NAME)
OPERATOR_DOT_NAME = $(subst -,.,$(OPERATOR_DASH_NAME))
OPERATOR_DOT_NAME_ARCH = $(OPERATOR_DOT_NAME)_$(ARCH)

OPERATOR_CR_IMAGE ?= $(CR_DOCKER_HOST)/$(CR_DOCKER_USERNAME)/$(OPERATOR_DOT_NAME_ARCH):$(OPERATOR_VERSION)

operator-push: init build push

operator-deploy: operator-push deploy

operator-tar: operator-push tar 

init:
	if [ ! -d "$(OPERATOR_GROUP_NAME)" ]; then \
		echo ""; \
		echo "${BGREEN}Initializing files using Operator SDK in $(OPERATOR_GROUP_NAME) ... ${NC}"; \
		mkdir "$(OPERATOR_GROUP_NAME)"; \
		cd "$(OPERATOR_GROUP_NAME)"; \
		operator-sdk init --plugins $(OPERATOR_TYPE) --domain "$(OPERATOR_DOT_NAME)" --group $(OPERATOR_GROUP_NAME) --version "$(OPERATOR_API_VERSION)" --kind $(OPERATOR_KIND) --generate-role ; \
		sed -i -e 's/env:/env:\n        - name: WATCH_NAMESPACE\n          valueFrom:\n            fieldRef:\n              fieldPath: metadata.namespace/' ./config/manager/manager.yaml ; \
		sed -i -z -e 's/\s\{2\}- apiGroups:\n\s\{6\}- ""\n\s\{4\}resources:\n/  - apiGroups:\n      - ""\n    resources:\n      - services\n/' ./config/rbac/role.yaml ; \
		sed -i -e 's/metadata:/metadata:\n  namespace: $(OPERATOR_NAMESPACE)/' "./config/samples/$(OPERATOR_GROUP_NAME)_$(OPERATOR_API_VERSION)_$(OPERATOR_KIND_LC).yaml" ; \
		sed -i -e 's/spec:/spec:\n  size: 1/' "./config/samples/$(OPERATOR_GROUP_NAME)_$(OPERATOR_API_VERSION)_$(OPERATOR_KIND_LC).yaml" ; \
		cp ../templates/deployment.yml roles/$(OPERATOR_KIND_LC)/templates/. ; \
		cp ../templates/service.yml roles/$(OPERATOR_KIND_LC)/templates/. ; \
		cp ../tasks/main.yml roles/$(OPERATOR_KIND_LC)/tasks/. ; \
		cd config/default; kustomize edit set namespace $(OPERATOR_NAMESPACE) ; \
		if [ -f "../tasks/route.yml" ]; then \
			cp ../tasks/route.yml roles/$(OPERATOR_KIND_LC)/tasks/. ; \
		fi \
	else \
		echo ""; \
		echo "${BGREEN}Initialized files already exists in $(OPERATOR_GROUP_NAME) ... ${NC}"; \
	fi

build:
	@echo ""
	@echo "${BGREEN}Building operator docker image ... ${NC}"; \
	cd $(OPERATOR_GROUP_NAME); make docker-build IMG="$(OPERATOR_CR_IMAGE)"

push:
	@echo ""
	@echo "${BGREEN}Pushing operator image into docker... ${NC}"; \
	docker login -u $(CR_DOCKER_USERNAME) -p $(CR_DOCKER_APIKEY) $(CR_DOCKER_HOST)
	cd $(OPERATOR_GROUP_NAME); make docker-push IMG="$(OPERATOR_CR_IMAGE)"

deploy:
	@echo ""
	@echo "${BGREEN}Deploying operator image and application on cluster in kubconfig ... ${NC}"; \
	cd $(OPERATOR_GROUP_NAME); make deploy IMG="$(OPERATOR_CR_IMAGE)"
	kubectl apply -f "$(OPERATOR_GROUP_NAME)/config/samples/$(OPERATOR_GROUP_NAME)_$(OPERATOR_API_VERSION)_$(OPERATOR_KIND_LC).yaml"

undeploy:
	@echo ""
	@echo "${BGREEN}Undeploying application from cluster ... ${NC}"; \
	cd $(OPERATOR_GROUP_NAME); make undeploy

clean: 
	@echo ""
	@echo "${BGREEN}Undeploying application from cluster and removing the init files ... ${NC}"; \
	cd $(OPERATOR_GROUP_NAME); make undeploy; cd ..; rm -rf "$(OPERATOR_GROUP_NAME)"

test:
	curl `kubectl get route -o jsonpath='{.items[0].status.ingress[0].host}'`

# Save operator tar in horizon directory and update operatorYamlArchive name
tar:
	@echo ""
	@echo "${BGREEN}Creating operator-tar to publish in IEAM ... ${NC}"; \
	cd $(OPERATOR_GROUP_NAME); \
	mkdir -p tmp; \
	cd config/manager && kustomize edit set image controller="$(OPERATOR_CR_IMAGE)" ; cd ../.. ; \
	kustomize build config/default > tmp/$(OPERATOR_DASH_NAME).yaml; \
	cp config/samples/$(OPERATOR_GROUP_NAME)_$(OPERATOR_API_VERSION)_$(OPERATOR_KIND_LC).yaml tmp/. ; \
	cd tmp; tar -zcvf ../../../../horizon/$(OPERATOR_DASH_NAME).tar.gz * ; cd ..; rm -r tmp; \
	sed -i -e 's/.*operatorYamlArchive.*/\t"operatorYamlArchive": "$(OPERATOR_DASH_NAME).tar.gz"/' ../../../horizon/service.definition.json

watch:
	watch -n 2 kubectl get pods

get-route:
	kubectl get route -o jsonpath='{.items[0].status.ingress[0].host}'


# This imports the variables from oprator.json
.operator.json.tmp.mk: operator.json
	@ hzn util configconv -f $< > $@
