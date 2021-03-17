## Application Service Network Examples
### Service 1

![](../../media/service1.png)

First example service to be used in peer, required and network configurations.

#### Register the edge device node using pattern 
```
hzn register -p "<your-org-name>/pattern-sg.edge.example.network.service1"
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

|[Service Examples](https://github.com/edgedock/example/tree/master/network/register)  | **Service 1** | [Service 2](https://github.com/edgedock/example/tree/master/network/register/02-service2)  |
|:--|:-:|--:|

