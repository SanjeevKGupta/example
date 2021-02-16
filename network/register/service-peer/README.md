#### Register the edge device node using pattern
In this deployment configuration mutiple services are deployed together as part of one service. Though they can be accessed indepedently but services themshelves can `NOT` access each other.

This pattern will deploy two services using pattern service-peer
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
{"hostname":"c7ebed158ad5","service":"Service Two"}
```

#### View currently runninf containers
```
docker ps
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



