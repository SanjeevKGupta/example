### IEAM network as peer services

In this example multiple services are deployed together as part of one service. Services can access each other by their service aliases.

```
hzn register -p "dev/pattern-sg.edge.example.network.service-peer"
```

#### Test

Test if the services are running by executing following commands.
#### First service
```
curl http://localhost:8881
```
Output
```
{"hostname":"<container-id>","service":"Service One"}
```
#### Second service
```
curl http://localhost:8882
```
Output
```
{"hostname":"<container-id>","service":"Service Two"}
```

#### View currently running containers
```
docker ps
CONTAINER ID        IMAGE                                             COMMAND                CREATED             STATUS              PORTS                    NAMES
cac88488c023        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   19 seconds ago      Up 18 seconds       0.0.0.0:8881->8881/tcp   632ab4417256a640dcc2e73a075ada4efb4b8cb0c2bfc56f83774d32c73239b2-sg.edge.example.network.service1
de2028114faf        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   19 seconds ago      Up 18 seconds       0.0.0.0:8882->8882/tcp   632ab4417256a640dcc2e73a075ada4efb4b8cb0c2bfc56f83774d32c73239b2-sg.edge.example.network.service2
```
#### Exec into the first container.
```
docker exec -it <container-id> /bin/sh
```
#### Run following commnands in first container
Service from other container wiil be accessible using its `service alias` from the calling container

##### Accessing itself
```
/ # curl http://localhost:8881
{"hostname":"cac88488c023","service":"Service One"}
```
##### Accessing other container by localhost (will fail)
```
/ # curl http://localhost:8882
curl: (7) Failed to connect to localhost port 8882: Connection refused
```
##### Accessing itself by service-name alias
```
/ # curl http://sg.edge.example.network.service1:8881
{"hostname":"cac88488c023","service":"Service One"}
```

##### Accessing other container by service-name alias
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"de2028114faf","service":"Service Two"}
```
```
/ # exit
```

#### Exec into the second container and run. Other container is accessible using service alias
```
docker exec -it <container-id> /bin/sh
```
#### Run following commnands in second container
Service from other container wiil be accessible using its `service alias` from the calling container.

##### Accessing itself
```
/ # curl http://localhost:8882
{"hostname":"de2028114faf","service":"Service Two"}
```
##### Accessing other container (will fail)
```
/ # curl http://localhost:8881
curl: (7) Failed to connect to localhost port 8881: Connection refused
```

##### Accessing itself by service-name alias
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"de2028114faf","service":"Service Two"}
```

##### Accessing other container by service-name alias
```
/ # curl http://sg.edge.example.network.service1:8881
{"hostname":"cac88488c023","service":"Service One"}
```

```
/ # exit

```

#### Unregister the edge node
```
hzn unregister -vrfD
```



