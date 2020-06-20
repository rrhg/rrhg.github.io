

## Sending security email alerts from Ubuntu 18.04 with Wazuh  

1. **This is a very basic step-by-step explanation of installing Wazuh to send email alerts when :**
* root login
* malicious command execution
* files changes in /etc/

To make this as simple as posible, Wazuh will be installed in a standalone system. No agents & no Elastic stack.
> Wazuh server monitors itself by default. The manager includes an agent (whose ID is 000) when you install it. Although it is not listed in Kibana, you can see that it really exists if you run this command in your manager: `/var/ossec/bin/agent_control -lc`


2. **As a prereqisite, postfix should be already installed & you should be able to send emails by :** 

```
    echo "Test Postfix using a relay host" | mail -s "Postfix  test" myuser@example.com
```

Instruccions on how to install postfix can be found here


3. **Next, install wazuh-server**

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


I think the nodes are missing the couchdb and init container images :   
Image:         ibmcom/couchdb2:latest
Image:         ibmcom/couchdb-operator-mgmt:latest

> this is after a >



