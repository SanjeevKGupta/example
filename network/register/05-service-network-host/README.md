## IEAM network using `host network`

In this example multiple services are deployed together as part of one service. Services can access each other by the localhost network and not by service-name alias. Using host network does not create service-name alias. This mode requires privileged access.

### Register the edge node with the following `service-network-host` pattern
```
hzn register -p "dev/pattern-sg.edge.example.network.service-network-host" --policy=node-policy-privileged.json

```
#### Verify that the service 1 and 2 are running as before
```
curl http://localhost:8881
```
##### Output
```
{"hostname":"<host-name>","service":"Service One"}
```
```
curl http://localhost:8882
```
##### Output
```
{"hostname":"<host-name>","service":"Service Two"}
```
#### View currently running containers
```
docker ps
```
##### Output (Similar)
```
CONTAINER ID        IMAGE                                             COMMAND                CREATED              STATUS              PORTS               NAMES
86548b051a7e        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   About a minute ago   Up About a minute                       10e271bed8b64c6b92190315b55e4a123f13cdc3a294b516408692ea6e4517cd-sg.edge.example.network.service2
9699d42b84b2        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   About a minute ago   Up About a minute                       10e271bed8b64c6b92190315b55e4a123f13cdc3a294b516408692ea6e4517cd-sg.edge.example.network.service1
```

### Exec into the first container
```
docker exec -it 9699d42b84b2 /bin/sh
```
#### Accessing its own service by localhost (works)
```
/ # curl http://localhost:8881
{"hostname":"nuc-142-42","service":"Service One"}
```
#### Accessing service from other container by localhost (works)
```
/ # curl http://localhost:8882
{"hostname":"nuc-142-42","service":"Service Two"}
```
#### Accessing its own service by service-name alias (fails - there is no service-name alias)
```
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
```
#### Accessing other service by service-name alias (fails - there is no service-name alias)
```
/ # curl http://sg.edge.example.network.service2:8882
curl: (6) Could not resolve host: sg.edge.example.network.service2
/ # exit
```
### Exec into the second container
```
docker exec -it 86548b051a7e /bin/sh
```
#### Accessing service from other container by localhost (works)
```
/ # curl http://localhost:8881
{"hostname":"nuc-142-42","service":"Service One"}
```
#### Accessing its own service by localhost (works)
```
/ # curl http://localhost:8882
{"hostname":"nuc-142-42","service":"Service Two"}
```
#### Accessing other service by service-name alias (fails - there is no service-name alias)
```
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
```
#### Accessing its own service by service-name alias (fails - there is no service-name alias)
```
/ # curl http://sg.edge.example.network.service2:8882
curl: (6) Could not resolve host: sg.edge.example.network.service2
/ # exit
```
### Unregister the edge device node
```
hzn unregister -vrfD
```
