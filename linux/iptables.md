

## My iptables questions  

### 07/04/2020
  
#### How list ports status with iptables & what each flag means

```
sudo iptables -L -n -v (L=list,   n=numbers,   v=verbose)
```

<br>

#### A good explanation of iptables fundamentals\
https://www.thegeekstuff.com/2011/01/iptables-fundamentals/

<br>

Does netstat show if port is blocked by iptables ?

* After a lot of searching, I don't think it does. It only shows if there's a process listening on that port.
* A problem arise about the minning of "closed". Apparently for some people, closed means that no process is listening on that port, while for others, it inlcudes the fact that the port is been blocked by the iptables. And these are two completely different things.
* as wikipedia says "

> The above use of the terms "open" and "closed" can sometimes be misleading, though; it blurs the distinction between a given port being reachable (unfiltered) and whether there is an application actually listening on that port. Technically, a given port being "open" (in this context, reachable) is not enough for a communication channel to be established. There needs to be an application (service) listening on that port, accepting the incoming packets and processing them. If there is no application listening on a port, incoming packets to that port will simply be rejected by the computer's operating system.

Ports can be "closed" (in this context, filtered) through the use of a firewall. The firewall will filter incoming packets, only letting through those packets for which it has been configured. Packets directed at a port which the firewall is configured to "close" will simply be dropped in transit, as though they never existed.

<br>

### I think, when someone says that a port is closed, we have to try to figure out if is referring to one of 2 things :
* No process is listening
* iptables has blocked the port

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

How did I find out that 141, 80, 443 were the only ports with rules ?

> in the INPUT chain the policy was drop & the only port with a rule that contained ACCEPT was 141.

But what about port 80 y 443 ?

> Is in the other chain called docker

```
Chain DOCKER (2 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     tcp  --  !br-10195981fe2a br-10195981fe2a  0.0.0.0/0            172.19.0.3           tcp dpt:443
    0     0 ACCEPT     tcp  --  !br-10195981fe2a br-10195981fe2a  0.0.0.0/0            172.19.0.3           tcp dpt:80
```

<br>
<br>
How find rules for specific port :

```
sudo iptables -L -n -v|grep 443
```

<br>

But for port 444, the previous command returns nothing, how can we know if it is been blocked?

## Apparently, there is no command for that (know if port is been blocked). We can only search for rules. If there are no rules then the default is the policy of the CHAIN. 

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
<br>

Would ufw be better ?

Could be, but I dont think it can be used with [lockdown.sh](https://github.com/rrhg/lockdown.sh)

And we would loose some rules that lockdown.sh implement to protect about:
  - spoofing attacks
  - masking attacks
  - others. see lockdown.sh

<br>

Is lockdown.sh blocking all ports except 141 80 443 ?

> It looks like it does, but I would need to understand what this rule does. Dont know if allow or deny all ports excessive RST :

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

