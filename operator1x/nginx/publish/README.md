#### Setup ENVIRONMENT variables

1. `MUST` setup ENVIRONMENT variables needed for project development as in env.check.mk

2. Development requires 
   - Preparing `operator tar`
   - Publishing service using the `operator tar` 
   - Publishing deployment policy

3. Create a horizon directory with `hzn.json` and `service.definition.json` similar to this example. This section is important for edge cluster based deployment 
```
    "clusterDeployment": {
	"operatorYamlArchive": "<operator.tar.gz>"
    }
```

4. Use make to prepare operator tar, publish service and deployment policy

```
make
```
