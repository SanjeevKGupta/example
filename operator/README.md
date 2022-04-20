### IEAM Edge Cluster Node Operator Example 

Writing a Kubenetes oparator to use on IEAM edge cluster node

Important: You will need two compute environments -

1. One running your edge cluster of choice such as OCP, microshift, k3s, microK8 etc. Make sure that the edge cluster is successfully setup and edge cluster agent is installed.  

2. Second environmeent will be used to do the development of the operator. 

#### Pre-reqsuiite
Development station on ubuntu
- docker 
- operator-sdk
- kubectl
- go

