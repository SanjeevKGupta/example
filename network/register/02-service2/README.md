## Application Service Network Examples
### Service 2

![](../../media/service2.png)

Second example service to be used in peer, required and network configurations.

#### Register the edge device node using pattern 
```
hzn register -p "<your-org-name>/pattern-sg.edge.example.network.service2"
```

#### Test
Test if the service is running by executing following command. 
```
curl http://localhost:8882
```

Should see output similar to this
```
{"hostname":"<container-id>","service":"Service Two"}
```

#### Unregister the edge node
```
hzn unregister -vrfD
```

|[Service 1](https://github.com/edgedock/example/tree/master/network/register/01-service1) | **Service 2** | [Service Peer](https://github.com/edgedock/example/tree/master/network/register/03-service-peer)  |
|:--|:-:|--:|
