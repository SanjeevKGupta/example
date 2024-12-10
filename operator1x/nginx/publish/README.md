#### Setup ENVIRONMENT variables

1. `MUST` setup ENVIRONMENT variables needed for project development as in env.check.mk . Create following files with appropriate values.
- ENV_APP_DEV
```
# Arbitrary strings to name appliation services, policiies
export EDGE_OWNER=<sg.edge>
export EDGE_DEPLOY=<example.cluster>

# Container image registry account name
export DOCKER_BASE=<docker-base/username>

# If using docker 
export CR_DOCKER_HOST=<docker.io>
export CR_DOCKER_USERNAME=<username>
export CR_DOCKER_APIKEY=<docker-api-key>
```

- ENV_AGENT_INSTALL
```
export HZN_ORG_ID=dev
export HZN_EXCHANGE_USER_AUTH=iamapikey:<api-key>
export HZN_EXCHANGE_URL=<ieam-exchange-url>
export HZN_FSS_CSSURL=<ieam-fss-url>

```
2. Install `edge-agent` to get basic `hzn` commands and edge-device-agent running on your development node.

3. Clone this example repo
   
4. Development requires 
   - Preparing `operator tar`
   - Publishing service using the `operator tar` 
   - Publishing deployment policy

5. Create a horizon directory with `hzn.json` and `service.definition.json` similar to this example. This section is important for edge cluster based deployment 
```
    "clusterDeployment": {
	"operatorYamlArchive": "<operator.tar.gz>"
    }
```

4. Use make to prepare operator tar, publish service and deployment policy

```
make
```
