### IEAM network as `required services`
In this example mutiple services can be deployed as requiredServices to configure them as dependent services.

Here service 2 is specifid as `required service` for service 1 . Hence Service 1 will be able to access Service 2 but not other way around. 

Register the edge node with the following `service-required` pattern
```
hzn register -p "dev/pattern-sg.edge.example.network.service-required"
```

Verify that the service 1 and 2 are running as before
```
curl http://localhost:8881
```
Output
```
{"hostname":"<container-id>","service":"Service One"}
```
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
```
Output (Similar)
```
CONTAINER ID        IMAGE                                             COMMAND                CREATED             STATUS              PORTS                    NAMES
afc58ca12c5f        edgedock/sg.edge.example.network.service1_amd64   "/bin/sh -c /one.sh"   54 seconds ago      Up 52 seconds       0.0.0.0:8881->8881/tcp   8f98d445f470bfbe040b1114b8ba7e5229dcf86c3916833a08fffe2e30254d88-sg.edge.example.network.service1
7b68daf407d7        edgedock/sg.edge.example.network.service2_amd64   "/bin/sh -c /two.sh"   55 seconds ago      Up 54 seconds       0.0.0.0:8882->8882/tcp   dev_sg.edge.example.network.service2_1.0.0_e5d946cd-3880-44c4-a81d-91eb7764cc9c-sg.edge.example.network.service2
```
#### Exec into the first container
```
docker exec -it <container-id>  /bin/sh
````
#### Run following commnands in the first container
Service 1 can access service 2 using `service name` alias of the service 2

#### Accessing its own service by localhost
```
/ # curl http://localhost:8881
{"hostname":"afc58ca12c5f","service":"Service One"}
```
#### Accessing service from other container by localhost (will fail)
```
/ # curl http://localhost:8882
curl: (7) Failed to connect to localhost port 8882: Connection refused
```
#### Accessing required service from upper level container by service-name alias
```
/ # curl http://sg.edge.example.network.service2:8882
{"hostname":"7b68daf407d7","service":"Service Two"}
/ # exit
```

#### Exec into the first container
Service 2 can NOT access service 1 using service name alias
```
docker exec -it <container-id> /bin/sh
```
#### Trying to access other service by localhost
```
/ # curl http://localhost:8881
curl: (7) Failed to connect to localhost port 8881: Connection refused
```
#### Accessing its own service by localhost
```
/ # curl http://localhost:8882
{"hostname":"7b68daf407d7","service":"Service Two"}
```
#### Access upper level service using service-name alias fails
```
/ # curl http://sg.edge.example.network.service1:8881
curl: (6) Could not resolve host: sg.edge.example.network.service1
/ # exit
```

#### Unregister the edge node
```
hzn unregister -vrfD
```
