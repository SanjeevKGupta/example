## IEAM Workload Placement Policy and Concepts

Workload placement on the edge nodes is achieved by setting `Node policy, Service Policy abd Deployment Policy` appropriately. 
`Constraints` specified in the policies, work with the `properties` specified in the policies, to determine the placement of workload on the edge nodes.

## Some best practice rules

1. If the placement decision is predicated on something about the target location (where it is, what is there, what is done there) then set the capability in a Node property and put the condition in a Service or Deployment constraint.
2. If the constraint is something imposed by the software developer (something about the software implementation itself) then put the condition in the Service constraint.
3. If the constraint is something imposed by the business (or Enterprise Architecture) then put the condition in the Deployment constraint.
4. If the placement decision is predicated on an operational or business decision made at the target location then put the condition in the Node constraint.

References: 
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-based-deployment
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-node-policy
- https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-properties-constraints

## Demo examples

### 1. Edge or Cloud 
In this demo, workload will be placed on two different edge nodes - one on an edge device node and another on a cloud device node.

#### `Setup`

**1.1** Publish two containerized services as workload - service1 and service2

**1.2** Register two edge nodes - node-Edge and node-Cloud

**1.3** View the services on these two nodes either using Web UI or CLI. There should be none and nodes should appear `Registered` in the Web UI. 

**1.4** Create `deployment policies`
  - `deploy-policy-edge` for `service1` with deployment constraint as `target == edge`
  - `deploy-policy-cloud` for `service2` with deployment constraint as `target == cloud`

**1.5** Update `node properties`
  - On `node-Edge` add a property `target = edge`
  - On `node-Cloud` add a property `target = cloud`

**1.6** View the services on these two nodes again. After few minutes `service1` will appear on `node-Edge` and `service2` will appear on `node-Cloud`. Also  nodes will be `Active` in the Web UI. 

#### `Result`
By setting appropriate deployment and node policies, two different workloads could be deployed on two edge nodes. 


### 2. Two different clouds 
In this demo, workload will be placed on two different edge nodes - one on a node in cloud A and another on a cloud B.

### 3. Move workload from one node to another 
In this demo, workload will be moved from node A to a node B. This can be necesitated based on business and/or changing enviromental conditions.
