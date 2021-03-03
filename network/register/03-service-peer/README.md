## Application Service Network Examples
### Network configuration as `peer services`

In this example multiple services are configured together as part of one service. Services can access each other by their service name aliases.

### Register the edge node with the following `service-peer` pattern
```
hzn register -p "dev/pattern-sg.edge.example.network.service-peer"
```

#### Verify that the service 1 and 2 are running
Service 1
```
curl http://localhost:8881
```
##### Output should look similar
```
{"hostname":"<container-id>","service":"Service One"}
```
Service 2
```
curl http://localhost:8882
```
##### Output should look similar
```
{"hostname":"<container-id>","service":"Service Two"}
```

#### View currently running containers
```
docker ps
```
##### Output should look similar
```
CONTAINER ID        IMAGE                                             COMMAND                CREATED             STATUS              PORTS                    NAMES
cac88488c023        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   19 seconds ago      Up 18 seconds       0.0.0.0:8881->8881/tcp   632ab4417256a640dcc2e73a075ada4efb4b8cb0c2bfc56f83774d32c73239b2-sg.edge.example.network.service1
de2028114faf        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   19 seconds ago      Up 18 seconds       0.0.0.0:8882->8882/tcp   632ab4417256a640dcc2e73a075ada4efb4b8cb0c2bfc56f83774d32c73239b2-sg.edge.example.network.service2
```
### Exec into the first container
```
docker exec -it <container-id> /bin/sh
```
Run following commnands in the first container. Service from other container wiil be accessible using its `service name` alias from the calling container.

#### Access its own service by localhost (works)
```
/ # curl http://localhost:8881
{"hostname":"cac88488c023","service":"Service One"}
```
#### Access service from other container by localhost (fails - this is expected)
```
/ # curl http://localhost:8882
curl: (7) Failed to connect to localhost port 8882: Connection refused
```
#### Access its own service by service-name alias (works)
```
/ # curl http://sg.edge.example.network.service1:8881
{"hostname":"cac88488c023","service":"Service One"}
```
#### Access service from other container by service-name alias (works)
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"de2028114faf","service":"Service Two"}
/ # exit
```

### Exec into the second container
```
docker exec -it <container-id> /bin/sh
```
Run following commnands in the second container. Service from other container is accessible using its `service-name` alias from the calling container.

#### Access its own service by localhost (works)
```
/ # curl http://localhost:8882
{"hostname":"de2028114faf","service":"Service Two"}
```
#### Access service from other container by localhost (fails - this is expected)
```
/ # curl http://localhost:8881
curl: (7) Failed to connect to localhost port 8881: Connection refused
```
#### Access its own service by service-name alias (works)
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"de2028114faf","service":"Service Two"}
```
#### Access service from other container by service-name alias (works)
```
/ # curl http://sg.edge.example.network.service1:8881
{"hostname":"cac88488c023","service":"Service One"}
/ # exit

```

#### Unregister the edge node
```
hzn unregister -vrfD
```

|[Service 2](https://github.com/edgedock/example/tree/master/network/register/02-service2) | **Service Peer** | [Service Required](https://github.com/edgedock/example/tree/master/network/register/04-service-required)  |
|:--|:-:|--:|


