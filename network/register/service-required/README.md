
In this example Service 2 is specifid as `required service` for service 1 . Hence Service 1 will be able to access Service 2 but not other way around. 


Verify services are running as before
```
curl http://localhost:8881
{"hostname":"afc58ca12c5f","service":"Service One"}

curl http://localhost:8882
{"hostname":"7b68daf407d7","service":"Service Two"}
```
#### View currently running containers
```
docker ps
CONTAINER ID        IMAGE                                             COMMAND                CREATED             STATUS              PORTS                    NAMES
afc58ca12c5f        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   54 seconds ago      Up 52 seconds       0.0.0.0:8881->8881/tcp   8f98d445f470bfbe040b1114b8ba7e5229dcf86c3916833a08fffe2e30254d88-sg.edge.example.network.service1
7b68daf407d7        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   55 seconds ago      Up 54 seconds       0.0.0.0:8882->8882/tcp   dev_sg.edge.example.network.service2_1.0.0_e5d946cd-3880-44c4-a81d-91eb7764cc9c-sg.edge.example.network.service2
```

### Service 1 can access service 2 using service url alias
```
docker exec -it <container-id>  /bin/sh
````
#### Accessing itself
```
/ # curl http://localhost:8881
{"hostname":"afc58ca12c5f","service":"Service One"}
```
#### Trying to access other service
```
/ # curl http://localhost:8882
curl: (7) Failed to connect to localhost port 8882: Connection refused
```
#### But can access using service alias from service One
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"7b68daf407d7","service":"Service Two"}
/ # exit
```

### Service 2 can NOT access service 1 using service url alias either
```
docker exec -it <container-id> /bin/sh
```
#### Trying to access other service
```
/ # curl http://localhost:8881
curl: (7) Failed to connect to localhost port 8881: Connection refused
```
#### Accessing itself
```
/ # curl http://localhost:8882
{"hostname":"7b68daf407d7","service":"Service Two"}
```
#### But access using service alias fails as well
```
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
/ # exit
```

#### Unregister the edge node
```
hzn unregister -vrfD
```
