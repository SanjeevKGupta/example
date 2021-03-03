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
<table style="width=100%">
    <th>1</th><th>2</th><th>3</th>
</table>
