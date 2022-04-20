#### Edge cluster node: k3s or microshift
 
#### Verify that the edge cluster agent is running
```
kubectl get pods -n openhorizon-agent

NAME                     READY   STATUS    RESTARTS   AGE
agent-5bbdd76b67-mlmw8   1/1     Running   1          12d
```

#### Register the node without a node policy

```
hzn register -u $HZN_EXCHANGE_USER_AUTH
```

#### Update the node policy 
```
cat operator.ansible.nginx.node.policy.json | hzn policy update -f-
```

#### View agreement to form 
```
hzn agreement list
```

#### View the running pods
At least agent and the operator pods should be runnung. Additionally application pods should be running.  
```
kubectl get pods -n openhorizon-agent
```

#### Helpful commands to view service, route etc.
```
kubectl get service -n openhorizon-agent
kubectl get route -n openhorizon-agent
curl localhost:30080
```

#### Unregister the node 
```
hzn unregister -f
```
#### Verify return to running of agent pod
```
kubectl get pods -n openhorizon-agent
```
