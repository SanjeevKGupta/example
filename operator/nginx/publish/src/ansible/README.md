#### Preparing the operator tar

This approach uses ansible to build the operator tar. In this implementation, `make` based build process fully automates the tasks of building the operator tar.

#### `templates` directory 

**Required**
- deployment.yaml - Responsible for creeating the appliation pod

Optional but typically always needed
- service.yml - To create a service that can be used to access the service provided by the application pod 
- route.yml - Applcaible for deployment on OCP 

#### `tasks` directory

- main.yml is used by the ansible operator to orchestrate the deployment of applciation resources.

#### operator.json
A initialization file to capture operator variables. Simialr to hzn.json

#### Make targets
Make sure to have logged in a kubernetes cluster - OCP, k3s, iks etc.

Use to create a new operator scaffolding, build and push the operator image in docker hub. 
```
make operator-push
```

Runs operator-push and also does various `kubectl apply` to deploy the app on the cluster.  
```
make operator-apply
```

Verify running of the application using  
```
make watch 
kubectl get service
kubectl get route -n openhorizon-agent
curl <route-from-above>
```
Delete the above deployment
```
make delete 
```

After successful developemnnt of the operator, create a tar to be deployed as service in IEAM.
``` 
make operator-tar
```
