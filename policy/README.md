### Workload Placement Policy and Concepts

Reference: 

https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-based-deployment

https://www.ibm.com/docs/en/eam/4.5?topic=nodes-node-policy

https://www.ibm.com/docs/en/eam/4.5?topic=nodes-policy-properties-constraints

Workload placement on the edge nodes is achieved by setting Node policy, Service Policy abd Deployment Policy appropriately. 
Constraints specified in the policies, work with the properties specified in the policies, to determine the placement of workload on the edge nodes.

### Some best practice rules

1. If the placement decision is predicated on something about the target location (where it is, what is there, what is done there) then set the capability in a Node property and put the condition in a Service or Deployment constraint.
2. If the constraint is something imposed by the software developer (something about the software implementation itself) then put the condition in the Service constraint.
3. If the constraint is something imposed by the business (or Enterprise Architecture) then put the condition in the Deployment constraint.
4. If the placement decision is predicated on an operational or business decision made at the target location then put the condition in the Node constraint.

### Example

A. Place workload on a node on the edge or on a node in the cloud (edge or cloud)
  
B. Place workload on a node in the cloud A or on a node in the cloud B ( Distribute different workload on different clouds )

C. Move workload from node A to a node B ( Move workload based on business and/or changing enviromental conditions)
