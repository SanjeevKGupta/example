## Verify the service deployment on the edge cluster node 

- [Service deployment](#service-deployment) 
- [k3s cluster](k3s-cluster)

### Service deployment
You can use either Web UI or CLI to update the node policy in line with the deployment constraint of the service.
Updating the node policy will result into deployment of the operator and all the objacts that the operator needs to deploy. 

- UI
  Update the node properties
  
- CLI on the node
```
hzn policy update --input-file=operator.ansible.nginx.node.policy.json
```
### k3s cluster
- Pods running on deployed edge cluster
``` 
kubectl get pods -A

NAMESPACE           NAME                                             READY   STATUS      RESTARTS       AGE
kube-system         helm-install-traefik-crd-bn8kv                   0/1     Completed   0              35d
kube-system         helm-install-traefik-tzsml                       0/1     Completed   1              35d
kube-system         local-path-provisioner-76d776f6f9-w4cmh          1/1     Running     3 (7d3h ago)   35d
kube-system         svclb-traefik-6684dfa7-k477j                     2/2     Running     6 (7d3h ago)   35d
default             docker-registry-8cdcbd959-tf4bv                  1/1     Running     3 (7d3h ago)   35d
kube-system         traefik-56b8c5fb5c-7dzv4                         1/1     Running     3 (7d3h ago)   35d
kube-system         coredns-59b4f5bbd5-jqx77                         1/1     Running     3 (7d3h ago)   35d
kube-system         metrics-server-7b67f64457-l7g24                  1/1     Running     3 (7d3h ago)   35d
openhorizon-agent   agent-8457dd67f9-qplh4                           1/1     Running     3 (7d3h ago)   32d
sg-edge             edge-nginx-controller-manager-74c6874596-t7kkd   2/2     Running     0              52s
sg-edge             nginx-7c9d479656-r2kzd                           1/1     Running     0              38s
```
- Services running on deployed edge cluster
```
kubectl get svc -A

NAMESPACE     NAME                                            TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
default       kubernetes                                      ClusterIP      10.43.0.1       <none>         443/TCP                      35d
kube-system   kube-dns                                        ClusterIP      10.43.0.10      <none>         53/UDP,53/TCP,9153/TCP       35d
kube-system   metrics-server                                  ClusterIP      10.43.80.90     <none>         443/TCP                      35d
kube-system   traefik                                         LoadBalancer   10.43.126.207   9.30.230.245   80:32170/TCP,443:32082/TCP   35d
default       docker-registry-service                         NodePort       10.43.153.89    <none>         5000:30514/TCP               35d
sg-edge       edge-nginx-controller-manager-metrics-service   ClusterIP      10.43.72.65     <none>         8443/TCP                     64s
sg-edge       nginx                                           NodePort       10.43.56.205    <none>         80:30080/TCP                 52s
```
- View example service output (part of output content removed for brevity)
```
curl http://localhost:30080

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
....
....
<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
 
 
