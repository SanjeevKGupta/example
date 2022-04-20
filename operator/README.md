### IEAM Edge Cluster Node Operator Example 

Writing a Kubenetes oparator to use on IEAM edge cluster node

Important: You will need two compute environments -

1. One running your edge cluster of choice such as OCP, microshift, k3s, microK8 etc. And make sure that is successfully setup and running so that your application operator can be deployed once developed. 

2. Second will be used to do the development of your operator. 

#### Pre-reqsuiite
Development station on ubuntu
- docker 
- operator-sdk
- kubectl
- go

