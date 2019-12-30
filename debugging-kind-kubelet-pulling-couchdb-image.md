
#### worker nodes are stock pulling couhdb images

a kind cluster node is a docker container

    docker ps

    # $ docker logs `<container-id>`
    # or
    # docker exec -it container_name /bin/bash
    
    # this worked
    docker exec -it kind-worker3 /bin/bash

How see kubectl logs once inside the node :
various ways to try according to : https://stackoverflow.com/questions/34113476/where-are-the-kubernetes-kubelet-logs-located

> if using systemd in node

    journalctl -u kubelet
    # this worked
    
> If you are trying to go directly to the file you can find the kubelet logs in /var/log/syslog directory. This is for ubuntu 16.04 and above.

    

