

## my iptables questions  

### 07/04/2020
  
How list ports status with iptables & what each flag means

```
sudo iptables -L -n -v (L=list,   n=numbers,   v=verbose)
```

<br>

Does netstat show if port is blocked by iptables ?

* After a lot of searching, I don't think it does. It only shows if there's a process listening on that port.


> open port != unblocked by iptables

```
```

<br>

How open a port

```
iptables -A INPUT -p tcp -m tcp --dport 141 -j ACCEPT
```

<br>

How the previous will show after we do $ sudo iptables -L -n -v

```
43  2544 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:141
```

<br>

how did I find out that 141, 80, 443 were the only ports with rules ?

> in the INPUT chain the policy was drop & the only pot with accept was 141.

But what about 80 y 443 ?

> Is in the other chain called docker

```
Chain DOCKER (2 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     tcp  --  !br-10195981fe2a br-10195981fe2a  0.0.0.0/0            172.19.0.3           tcp dpt:443
    0     0 ACCEPT     tcp  --  !br-10195981fe2a br-10195981fe2a  0.0.0.0/0            172.19.0.3           tcp dpt:80
```

<br>

How find rules for specific port :

```
sudo iptables -L -n -v|grep 443
```

<br>

But for port 444, that returns nothing, how know if is been blocked?

## Apparently, there is no command for that. We can only search for rules. If there are no rules then the default is the policy of the CHAIN. 

<br>

For example :

```
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination 
```

All that means : 

None of the chains have any rules, so they all fall through to their default policy of "ACCEPT". Everything is accepted.

<br>

Would ufw be better ?

Could be, but I dont think it can be used with lockdown.sh

we would loose some rules that lockdown implement to protect about:
  - spoofing attacks
  - masking attacks
  - others. see lockdown.sh

<br>

Is lockdown.sh blocking all ports except 141 80 443 ?

> It looks like it does, except with this rule that looks I dont know if allow or deny all ports that ... :

```
# Drop packets with excessive RST to avoid Masked attacks
iptables -A INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT
```

<br>

How remove a rule

```
sudo iptables -D INPUT -p tcp --dport xxxx -j ACCEPT
```

<br>

Open a port for single ip

```
sudo iptables -A INPUT -p tcp -s your_server_ip --dport xxxx -j ACCEPT
```

<br>

Save the new rules & make them permanent ?
* On Ubuntu 16.04 and Ubuntu 18.04 use the following commands

```
sudo netfilter-persistent save
sudo netfilter-persistent reload
```

