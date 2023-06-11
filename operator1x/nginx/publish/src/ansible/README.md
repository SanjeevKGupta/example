## Develop ansible operator based workload deployment on edge cluster

- This implementation uses ansible operator based workload deployment using Operator-SDK 1.x (v.1.28.1 as of writing this). 
- `make` based build process fully automates the tasks of building the operator tar.
- `kustomzie` and `sed` is used in the Makefile to modify some of the template files.
- Review the make targets in the Makefile to study what is being changed. 

**Note:** 
1. The operator building using Operator-SDK 1.x is very different from Operator-SDK 0.x version.
2. Developed on UBuntu 22.04.2 LTS. MacOS works but `sed` used in Makefile works differently and causues issue.

### Pre-requisites
#### operator-sdk
```
operator-sdk version
operator-sdk version: "v1.28.1", commit: "b05f6a56a176a98b7d92c4d4b36076967e0d77f7", kubernetes version: "1.26.0", go version: "go1.19.8", GOOS: "linux", GOARCH: "amd64"```
```
#### kubectl
```
kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.2", GitCommit:"31aa3e89a926f81aa0af30320ffcb71acadf3015", GitTreeState:"clean", BuildDate:"2023-04-07T11:17:33Z", GoVersion:"go1.19.6", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.3", GitCommit:"9e644106593f3f4aa98f8a84b23db5fa378900bd", GitTreeState:"clean", BuildDate:"2023-03-15T13:33:12Z", GoVersion:"go1.19.7", Compiler:"gc", Platform:"linux/amd64"}
```
#### kustomize
```
kustomize version
v5.0.1
```
#### minikube
```
minikube version
minikube version: v1.30.1
```
- To start/stop minikube
```
minikube start
minikube stop
```
- To view example service output
```
curl $(minikube ip):30080
```

### `templates` directory 

**Required**
- deployment.yml - Responsible for creating the application pods.

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
**operator-deploy**

Runs operator-push and also does `make deploy` to deploy the app on the cluster as per the ~/.kube/config . I used `minikube` during development.
```
make operator-deploy
```
- Pods during development
```
$kubectl get pods -A

NAMESPACE     NAME                                             READY   STATUS    RESTARTS       AGE
kube-system   coredns-787d4945fb-9jzps                         1/1     Running   4 (14h ago)    39d
kube-system   etcd-minikube                                    1/1     Running   4 (7d2h ago)   39d
kube-system   kube-apiserver-minikube                          1/1     Running   4 (7d2h ago)   39d
kube-system   kube-controller-manager-minikube                 1/1     Running   4 (7d2h ago)   39d
kube-system   kube-proxy-6cwpp                                 1/1     Running   4 (14h ago)    39d
kube-system   kube-scheduler-minikube                          1/1     Running   4 (7d2h ago)   39d
kube-system   storage-provisioner                              1/1     Running   8 (14h ago)    39d
sg-edge       edge-nginx-controller-manager-68cdb66bcf-pvh8j   2/2     Running   0              22s
sg-edge       nginx-7c9d479656-wbtg2                           1/1     Running   0              10s
```
- Services during development
```
$ kubectl get svc -A

NAMESPACE     NAME                                            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes                                      ClusterIP   10.96.0.1       <none>        443/TCP                  39d
kube-system   kube-dns                                        ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   39d
sg-edge       edge-nginx-controller-manager-metrics-service   ClusterIP   10.110.159.50   <none>        8443/TCP                 27s
sg-edge       nginx                                           NodePort    10.96.210.156   <none>        80:30080/TCP             13s
```
- View example service output (part if output content removed for brevity)
```
curl $(minikube ip):30080

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
....
....
<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```

*Verify running of the application*  
```
make watch 
kubectl get service
kubectl get route -n openhorizon-agent
curl <route-from-above-host:port>
curl $(minikube ip):30080
```
**make undeploy**

Delete the above deployment
```
make undeploy
```
**operator-tar**

After successful development of the operator, create a tar to be deployed as service in IEAM.
``` 
make operator-tar
```
