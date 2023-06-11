## IEAM Edge Cluster Node Operator Example using Operator SDK 1.x (v1.28.1)

Important: You should have two compute environments for development and test. 

1. First environmeent will be used to do the development of the operator. You can use minikuke as cluster during development.
2. Second environmeent can be an edge cluster of your choice such as OCP, microshift, k3s, microK8 etc. Make sure that the edge cluster is successfully setup and edge cluster agent is installed.  

### Pre-requisite and versions used (later version may work as well)
Must setup following in your development environment
- [ubuntu VM](#ubuntu) 
- [docker](#docker)
- [operator-sdk](#operator-sdk)
- [kubectl](#kubectl)
- [kustomize](#kustomize)
- [go](#go)
- [minikube](#minikube)
- [ibmcloud CLI](#ibmcloud-cli)

#### ubuntu
Development platform on Ubuntu VM. Other OS would work as well.
```
NAME="Ubuntu"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
```
#### docker 
```
docker version
Client: Docker Engine - Community
 Version:           23.0.5
 API version:       1.42
 Go version:        go1.19.8
 OS/Arch:           linux/amd64
```
#### operator-sdk
```
operator-sdk version
operator-sdk version: "v1.28.1", commit: "b05f6a56a176a98b7d92c4d4b36076967e0d77f7", kubernetes version: "1.26.0", go version: "go1.19.8", GOOS: "linux", GOARCH: "amd64"
```
#### kubectl
```
kubectl version
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.2", GitCommit:"31aa3e89a926f81aa0af30320ffcb71acadf3015", GitTreeState:"clean", BuildDate:"2023-04-07T11:17:33Z", GoVersion:"go1.19.6", Compiler:"gc", Platform:"linux/amd64"}
```
#### kustomize
```
kustomize version
v5.0.1
```
#### go
```
go version
go version go1.20.4 linux/amd64
```
#### minikube
```
minikube version
minikube version: v1.30.1
```
#### ibmcloud CLI
Download binary and install `ibmcloud` in /usr/local/bin/
- https://github.com/IBM-Cloud/ibm-cloud-cli-release/releases/
