### Various service network options in IEAM 

In this example it is shown that how two (or more) services can be configured differently to meet different application requirements. 

#### 1. service1
Example service one 

#### 2. service2
Example service two 

#### 3. service-peer
Two services are configured such that they are peer to each other and can access each other by their service-name alias. This configuration can be extended for more services. For this configuration to work each service is deployed separately and then another service (called service-peer in this example) ties them together. 

Service 1 and Service 2 can access each other.

                 _____________         _____________   
                 |           |         |           |
                 | Service 1 | <---->  | Service 2 |
                 |___________|         |___________|
                    

#### 4. service-required
Two services are configured such that upper level service has a lower dependent service, Deploying upper level service causes dependent lower service to be deployed automatically. This is implemented using requiredServices technique. Mutiple services can be configured similarly as depedent service of upper level service. 

Service 1 has access to Service 2 but Service 2 does not have access to Service 1

                 _____________
                 |           |
                 | Service 1 |
                 |___________|
                      /|\
                       |
                  _____|_____     
                 |           |
                 | Service 2 |
                 |___________|

#### 5. service-network-host
In this configuration services can access each other using host network and can access each other. Services are accessible externally as well. This eequires privilege access.

Service 1 and 2 can access each other using host network host. External user can access Service 1 and Service 2 independently as well 

```
                         |==============|
                         |     Host     |
                         |==============|
                           /          \
                          /            \
                  ______|/_____    _____\|______   
                  |           |    |           |
                  | Service 1 |    | Service 2 |
                  |___________|    |___________|
  
```
