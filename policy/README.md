## IEAM Workload Placement Policy and Concepts

Workload placement on the edge nodes is achieved by setting `Node policy, Service Policy and Deployment Policy` appropriately. 
`Constraints` and `properties` specified in the deployment and service policies, work with the `properties` and `constraints` specified in the node policy, to determine the placement of workload on the edge nodes.

## Best practice rules (BPR)

1. If the placement decision is predicated on something about the target location (where it is, what is there, what is done there) then set the capability in a Node property and put the condition in a Service or Deployment constraint.
2. If the constraint is something imposed by the software developer (something about the software implementation itself) then put the condition in the Service constraint.
3. If the constraint is something imposed by the business (or Enterprise Architecture) then put the condition in the Deployment constraint.
4. If the placement decision is predicated on an operational or business decision made at the target location then put the condition in the Node constraint.

References: 
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-based-deployment
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-node-policy
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-properties-constraints

## Service grouping - a related concept
Services are the deployable units and policies manage their deployment on edge nodes. Though a typical and most granular use of the policy is to manage each service independently, tt's possible to group the services couple of ways.

### 1. Peer service group
Create a top level service and include each participating peer service in that group in the deployment section of the service-definition. Then have one deployment policy for the top level service.

### 2. Dependent service group
Use required service syntax of the service-definition to group them as dependent service(s). Then have one deployment service for the top level service.

## Demo examples
**Note:** In these examples all nodes are created as VMs in one data center. The node names such as node-Edge, node-Cloud, node-Azure and node-GCP, are chsoen to illustrate the concepts. Example uses two services as workload.  

### Pre-conditions
- Publish two containerized services as workload - service1 and service2. See `publish` directory in this repo.
  - Create containerized image for the services.
  - Create service definition json file for the services.
  - Publish the service into IEAM mgmt hub.

### 1. Workloads on Edge or Cloud 
In this demo, workload will be placed on two different edge nodes - one on an edge device node and another on a cloud device node. This makes use of BPR 1 and 3. 

#### `Setup`
**1.1** Register edge nodes - node-Edge and node-Cloud
  - Install edge agent on the edge nodes.
  - Register the edge node into the IEAM mgmt hub.

**1.2** View the services on these two nodes either using Web UI or CLI. There should be none and nodes should appear `Registered` in the Web UI. 

**1.3** Create `deployment policies`
  - `deploy-policy-edge` for `service1` with deployment constraint as `target == edge`
  - `deploy-policy-cloud` for `service2` with deployment constraint as `target == cloud`

**1.4** Update `node properties`
  - On `node-Edge` add a property `target = edge`
  - On `node-Cloud` add a property `target = cloud`

**1.5** View the services on these two nodes again. After few minutes `service1` will appear on `node-Edge` and `service2` will appear on `node-Cloud`. Also nodes will be `Active` in the Web UI. 

#### `Result`
By setting appropriate deployment and node policies, two different workloads could be deployed on two edge nodes. 

--------

### 2. Workloads on two different nodes with complex expression 
In this demo, workload will be placed on two different edge nodes - one on a node in cloud A and another on a cloud B, based on some example conditions such as 
```
- latency < 10ms AND
- service-class == gold OR service-class == silver
```

#### `Setup`
**2.1** Register two edge nodes - node-Cloud-A and node-Cloud-B

**2.2** View the services on these two nodes either using Web UI or CLI. There should be none and nodes should appear `Registered` in the Web UI. 

**2.3** Create `deployment policy`
  - `deploy-policy-example-2-1` for `service1` with deployment constraint as `latency-ms < 10 AND (service-class == gold OR service-class == silver)`
  - `deploy-policy-example-2-2` for `service2` with deployment constraint as `sale == true`

**2.4** Add `node properties`
  - On `node-Cloud-A` 
    - `latency-ms = 8`
    - `service-class = gold`
    - `sale = true`
 
  - On `node-Cloud-B`     
    - `latency-ms = 15`
    - `service-class = silver`
    - `sale = false`
   
**2.5** View the services on these two nodes again. After few minutes `service1` and `service2` will appear on `node-Cloud-A` and no service will appear on `node-Cloud-B` as based on the constraints only properties of `node-Cloud-A` qualify.

**2.6** Update `node properties`
  - On `node-Cloud-B`     
    - `latency-ms = 9`

**2.7** View the services on these two nodes again. After few minutes `service1` will appear on `node-Cloud-B` as well as the latency value becomes compliant with the deployment policy of `service1` 

#### `Result`
By setting appropriate deployment and node policies, workload could be deployed on edge nodes or get prevented from getting deployed. In the next example, this setup will be used to move workload from one node to another.

--------

### 3. Move workload from one node to another node 
In this demo, one workload service2 will be moved from node-Cloud-A to node-Cloud-B . This can be necessitated based on business and/or changing enviromental conditions. 

#### `Setup`
**3.1** Continue from example 2 above. 

**3.2** Modify the `deploy-policy-example-2-2` 
  - Access `deploy-policy-example-2-2`
  - Edit to modify the current deployment constraint `sale == true` to `sale == false` instead.
  - Save and watch the effect of this changed deployment policy.

**3.3** View the services on nodes node-Cloud-A and node-Cloud-B again. After few minutes 
  - `service2` will disappear on `node-Cloud-A` as this service is no longer targeted for node-Cloud-A anymore.
  - `service2` will appear on `node-Cloud-B` in addition to already running `service1` 

#### `Result`
By updating appropriate deployment policies, workload can be moved from one node to another, a powerful business imperative.

--------
