### Service 2

Second example service to be used in peer, required and network configurations.

#### Register the edge device node using pattern 
```
hzn register -p "dev/pattern-sg.edge.example.network.service2"
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
