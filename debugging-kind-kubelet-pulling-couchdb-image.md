
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


the nodes use containerd and to get pulled images had to do :
    
    root@kind-worker:/# crictl images
    IMAGE                                TAG                 IMAGE ID            SIZE
    docker.io/ibmcom/couchdb-operator    0.2.0               9e2e1d52d1433       52.2MB
    docker.io/kindest/kindnetd           0.5.3               aa67fec7d7ef7       80.3MB
    k8s.gcr.io/coredns                   1.6.2               bf261d1579144       44.2MB
    k8s.gcr.io/etcd                      3.3.15-0            b2756210eeabf       248MB
    k8s.gcr.io/kube-apiserver            v1.16.3             392249bd86967       185MB
    quay.io/operator-framework/olm       <none>              79e06ae1d9e5b       70.5MB
    k8s.gcr.io/kube-controller-manager   v1.16.3             808025b3748ef       128MB
    k8s.gcr.io/kube-proxy                v1.16.3             f4fd1d7052b4e       103MB
    k8s.gcr.io/kube-scheduler            v1.16.3             1974a03197540       105MB
    k8s.gcr.io/pause                     3.1                 da86e6ba6ca19       746kB
    root@kind-worker:/# 


I think the nodes are missing the couchdb and init container images :   
Image:         ibmcom/couchdb2:latest
Image:         ibmcom/couchdb-operator-mgmt:latest


But crictl pods show as if the couchdb pod is ready but when im back at kubectl describe pod it says is pending waiting podInitializing

    root@kind-worker:/# crictl pods
    POD ID              CREATED             STATE               NAME                                NAMESPACE           ATTEMPT
    79bef006e860f       3 hours ago         Ready               c-mycluster-m-0                     my-couchdb          0
    3adefb17be2b6       3 hours ago         Ready               couchdb-operator-7584957dcd-l52c4   operators           0
    7e53b901755f1       3 hours ago         Ready               catalog-operator-7b788c597d-frsqb   olm                 0
    f802ddec860d3       3 hours ago         Ready               olm-operator-946bd977f-9r6jq        olm                 0
    9336353abff32       3 hours ago         Ready               kube-proxy-mk97h                    kube-system         0
    deac02483c8c7       3 hours ago         Ready               kindnet-vtx7f                       kube-system         0
    root@kind-worker:/# 



........
