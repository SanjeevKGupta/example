### Service 1
First example service to be used in peer, required and network configurations.

#### Register the edge device node using pattern 
```
hzn register -p "dev/pattern-sg.edge.example.network.service1"
```

#### Test
Test if the service is running by executing following command. 
```
curl http://localhost:8881
```

Should see output similar to this
```
{"hostname":"<container-id>","service":"Service One"}
```
#### Unregister the edge node
```
hzn unregister -vrfD
```
![Service 1](https://github.com/edgedock/example/tree/master/network/register/01-service1#left)
![Service 2](https://github.com/edgedock/example/tree/master/network/register/02-service2#right)
