## Publish service

In this example, `make` is used to automate the process of building example services and publishing them into IEAM mgmt hub. 
This project uses docker.io as container registry for the images. The automation requires you to setup following ENVs as per your environment and credentials. 

### Get the source

git clone the repo or copy policy directory

### Setup ENVs
```
export HZN_ORG_ID=<your-org-id>
export HZN_EXCHANGE_USER_AUTH=iamapikey:<your-iamapikey>

export EDGE_OWNER=<arbitrary-text-to-identify e.g sg.edge>
export EDGE_DEPLOY=<arbitrary-text-to-identify-your-service e.g example.policy>
export DOCKER_BASE=<your-docker-account-name>

export CR_DOCKER_USERNAME=<your-docker-account-name>
export CR_DOCKER_APIKEY=<your-docker-api-key>
export CR_DOCKER_HOST=docker.io
```

### Build and publish

```
make
```
