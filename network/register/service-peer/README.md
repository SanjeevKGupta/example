### Register the edge device node
In this example configuration multiple services are deployed together as part of one service. Though the services can be accessed independently but services themshelves can `NOT` access each other.

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
3540b67a29a8        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   6 minutes ago       Up 6 minutes        0.0.0.0:8881->8881/tcp   ae0128e582cb5475d613577b4dec9e22a17fb524a328ad8ea4473f33822115f1-sg.edge.example.network.service1
c7ebed158ad5        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   6 minutes ago       Up 6 minutes        0.0.0.0:8882->8882/tcp   ae0128e582cb5475d613577b4dec9e22a17fb524a328ad8ea4473f33822115f1-sg.edge.example.network.service2
```
#### Exec into first container and run. Other container is not accessible
```
docker exec -it 3540b67a29a8 /bin/sh
/ # curl http://localhost:8881
{"hostname":"3540b67a29a8","service":"Service One"}
/ # curl http://localhost:8882
curl: (7) Failed to connect to localhost port 8882: Connection refused
/ # exit
```
#### Exec into second container and run. Other container is not accessible
```
docker exec -it c7ebed158ad5 /bin/sh
/ # curl http://localhost:8881
curl: (7) Failed to connect to localhost port 8881: Connection refused
/ # curl http://localhost:8882
{"hostname":"c7ebed158ad5","service":"Service Two"}
/ # exit
```



