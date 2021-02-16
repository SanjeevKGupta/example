
hzn register -p "dev/pattern-sg.edge.example.network.service-network-host" --policy=node-policy-privileged.json

```
curl http://localhost:8881
{"hostname":"nuc-142-42","service":"Service One"}
```

```
curl http://localhost:8882
{"hostname":"nuc-142-42","service":"Service Two"}
```

```
docker ps
CONTAINER ID        IMAGE                                             COMMAND                CREATED              STATUS              PORTS               NAMES
86548b051a7e        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   About a minute ago   Up About a minute                       10e271bed8b64c6b92190315b55e4a123f13cdc3a294b516408692ea6e4517cd-sg.edge.example.network.service2
9699d42b84b2        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   About a minute ago   Up About a minute                       10e271bed8b64c6b92190315b55e4a123f13cdc3a294b516408692ea6e4517cd-sg.edge.example.network.service1
```

```
docker exec -it 9699d42b84b2 /bin/sh
/ # curl http://localhost:8881
{"hostname":"nuc-142-42","service":"Service One"}
/ # curl http://localhost:8882
{"hostname":"nuc-142-42","service":"Service Two"}
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
/ # curl http://sg.edge.example.network.service2:8882
curl: (6) Could not resolve host: sg.edge.example.network.service2
/ # exit
```

```
docker exec -it 86548b051a7e /bin/sh
/ # curl http://localhost:8881
{"hostname":"nuc-142-42","service":"Service One"}
/ # curl http://localhost:8882
{"hostname":"nuc-142-42","service":"Service Two"}
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
/ # curl http://sg.edge.example.network.service2:8882
curl: (6) Could not resolve host: sg.edge.example.network.service2
/ # exit
```
