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

#### Update node policy 
```
cat operator.ansible.nginx.node.policy.json | hzn policy update -f-
```

#### Watch for agreemnt to form 
```
watch hzn agreement list
```

#### View the running pods
At least agent and your opearator pods should be runnung. Additionally your application pods will be running.  
```
kubectl get pods -n openhorizon-agent
```

#### Helpful commands to view servcie, route etc
```
kubectl get service -n openhorizon-agent
kubectl get route -n openhorizon-agent
curl localhost:30080
```

#### Unregister the node 
```
hzn unregister -f
```
#### Verifu return to running of agent pod
```
kubectl get pods -n openhorizon-agent
```
