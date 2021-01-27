## Service Network in IEAM

### Publish

### Register

hzn register -p "dev/pattern-sg.edge.example.network.service1"

hzn register -p "dev/pattern-sg.edge.example.network.service2"

hzn register -p "dev/pattern-sg.edge.example.network.service-peer"

hzn register -p "dev/pattern-sg.edge.example.network.service-required"

hzn register -p "dev/pattern-sg.edge.example.network.service-network-host" --policy=node_policy_privileged.json
