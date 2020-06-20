

#### Sending security email alerts from Ubuntu 18.04 with Wazuh  

1. This is a very basic step-by-step explanation of installing Wazuh to send email alerts when :
* rooot login
* suspecious commands
* files changes in /etc/


As a prereqisite, postfix should be already installed & you should be able to send emails by :
    
    # echo "Test Postfix using a relay host" | mail -s "Postfix  test" myuser@example.com

Instruccions on how to install postfix can be found here

2. Next, install wazuh-server 

> this is after a >

    journalctl -u kubelet
    # this worked
    
> this is after a >


the nodes use containerd and to get pulled images had to do :

    sudo -s
    apt update
    apt upgrade
    apt-get install curl apt-transport-https lsb-release gnupg2
    curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
    - this can only be done by root
    - sudo -s
    # curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
    # echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
    # apt-get update
    # apt-get install wazuh-manager
    # systemctl status wazuh-manager
    - it was active (running)
    -did not install API or elastic stack
    
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
