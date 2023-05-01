#### Edge cluster node: k3s or microshift
 
#### Verify that the edge cluster agent is running
```
kubectl get pods -n openhorizon-agent

NAME                     READY   STATUS    RESTARTS   AGE
agent-5bbdd76b67-mlmw8   1/1     Running   1          12d
```

#### Register the node without a node policy

Note **hzn** is alias to  `kubectl exec -it <agent-pod-id> -n openhorizon-agent -- hzn`

```
export HZN_EXCHANGE_NODE_AUTH="<node-name>:<node-auth-key>"
hzn exchange node create -n $HZN_EXCHANGE_NODE_AUTH -u $HZN_EXCHANGE_USER_AUTH -T cluster
hzn exchange node confirm -n $HZN_EXCHANGE_NODE_AUTH -u $HZN_EXCHANGE_USER_AUTH
hzn register -u $HZN_EXCHANGE_USER_AUTH -n $HZN_EXCHANGE_NODE_AUTH
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

NAME                                                      READY   STATUS    RESTARTS   AGE
agent-55f4cbdd74-p75gt                                    1/1     Running   0          2d6h
nginx-dfd5566d7-t6bpg                                     1/1     Running   0          8m52s
sg-edge-example-operator-ansible-nginx-5ddc68c5bd-blcw8   1/1     Running   0          9m17s
```

#### Helpful commands to view service, route etc.
```
kubectl get service -n openhorizon-agent

OCP
kubectl get route -n openhorizon-agent
curl nginx-route-openhorizon-agent.<node-name-host/port-from route-above>

IKS
curl $IKS_INGRESS_SUBDOMAIN:30080

k3s
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
