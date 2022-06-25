## Develop ansible based operator tar

This approach uses ansible to build the operator tar. In this implementation, `make` based build process fully automates the tasks of building the operator tar.

### Pre-requisite
- operator-sdk version
```
operator-sdk version
operator-sdk version: "v0.19.4", commit: "125d0dfcc71fef4f9d7e2a42b1354cb79ffdee03", kubernetes version: "v1.18.2", go version: "go1.13.15 linux/amd64"
```
- kubectl version
```
kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v0.23.0", GitCommit:"3e24949fea37244367d50a1f3a226ec20d51eef1", GitTreeState:"clean", BuildDate:"2022-04-01T12:50:14Z", GoVersion:"go1.17.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.8+f34b40c", GitCommit:"496de02aacae03fbbd977e802b08b71ca76f390a", GitTreeState:"clean", BuildDate:"2022-05-18T18:53:42Z", GoVersion:"go1.16.12", Compiler:"gc", Platform:"linux/amd64"}
WARNING: version difference between client (0.23) and server (1.22) exceeds the supported minor version skew of +/-1
```

### `templates` directory 

**Required**
- deployment.yaml - Responsible for creating the application pods.

*Optional but typically always needed*
- service.yml - To create a service to access the service provided by the application pods. 
- route.yml - To get a route fdr the application. Applicable for deployment on OCP. 

### `tasks` directory

- main.yml is used by the ansible operator to orchestrate the deployment of application resources.

### `roles` directory

- role,yaml - for OCP route to work

### operator.json
An initialization file to capture operator variables. Simialr to hzn.json

### Make targets
Make sure to have logged in a kubernetes cluster - OCP, k3s, iks etc.

**operator-push**

Use to create a new operator scaffolding, build and push the operator image in docker hub. 
```
make operator-push
```
**operator-apply**

Runs operator-push and also does various `kubectl apply` to deploy the app on the cluster.  
```
make operator-apply
```

*Verify running of the application*  
```
make watch 
kubectl get service
kubectl get route -n openhorizon-agent
curl <route-from-above>
```
**operator-delete**

Delete the above deployment
```
make operator-delete 
```
**operator-tar**

After successful development of the operator, create a tar to be deployed as service in IEAM.
``` 
make operator-tar
```


