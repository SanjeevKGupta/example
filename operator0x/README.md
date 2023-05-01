### IEAM Edge Cluster Node Operator Example 

Writing a Kubenetes oparator to use on IEAM edge cluster node

Important: You will need two compute environments -

1. One running your edge cluster of choice such as OCP, microshift, k3s, microK8 etc. Make sure that the edge cluster is successfully setup and edge cluster agent is installed.  

2. Second environmeent will be used to do the development of the operator. 

#### Pre-requisite and versions used (later version may work as well)
Development platform on Intel NUC (Others may work as well, including MacOS)
- ubuntu
```
NAME="Ubuntu"
VERSION="20.04.4 LTS (Focal Fossa)"
```
- docker 
```
docker version
Client: Docker Engine - Community
 Version:           20.10.14
 API version:       1.41
 Go version:        go1.16.15
```
- operator-sdk
```
operator-sdk version
operator-sdk version: "v0.19.4", commit: "125d0dfcc71fef4f9d7e2a42b1354cb79ffdee03", kubernetes version: "v1.18.2", go version: "go1.13.15 linux/amd64"
```
- kubectl
```
kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v0.23.0", GitCommit:"3e24949fea37244367d50a1f3a226ec20d51eef1", GitTreeState:"clean", BuildDate:"2022-04-01T12:50:14Z", GoVersion:"go1.17.5", Compiler:"gc", Platform:"linux/amd64"}
```
- go
```
go version
go version go1.18.1 linux/amd64
```

