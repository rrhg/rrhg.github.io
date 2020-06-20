

## Sending security email alerts from Ubuntu 18.04 with [Wazuh](https://wazuh.com/)  

1. **This is a very basic step-by-step explanation of installing Wazuh to send email alerts when :**
* root login
* malicious command execution
* files changes in /etc/

To make this as simple as posible, Wazuh server will be installed in a standalone system. No agents in other machines, no API & no Elastic stack.  Wazuh/Ossec is a huge topic, here I was just trying to get something up & running in order understand what it does.
> Wazuh server monitors itself by default. The manager includes an agent (whose ID is 000) when you install it. Although it is not listed in Kibana, you can see that it really exists if you run this command in your manager: `/var/ossec/bin/agent_control -lc`

---
2. **As a prerequisite, postfix should be already installed & you should be able to send emails by :** 

```
echo "Test Postfix using a relay host" | mail -s "Postfix  test" myuser@example.com
```

Instruccions on how to install postfix can be found here: https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication

---
3. **Next, install wazuh-server**

```
sudo -s
apt update
apt upgrade
apt install curl apt-transport-https lsb-release gnupg2
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
apt update
apt install wazuh-manager
systemctl status wazuh-manager
```
wazuh-manager.service should be active(running)
For more info : https://documentation.wazuh.com/3.12/installation-guide/installing-wazuh-manager/linux/ubuntu/wazuh_server_packages_ubuntu.html#wazuh-server-packages-ubuntu

---
4. **Configure Wazuh to start sending emails with postfix**

* edit /var/ossec/etc/ossec.conf as follows:
```
<global>
<email_notification>yes</email_notification>
<smtp_server>localhost</smtp_server>
<email_from>USERNAME@example.com</email_from>
<email_to>you@example.com</email_to>
</global>
```
For more info : - https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication note: is at bottom of page.

---
5. **Test if Wazuh can send emails**
By lowering the email alerts level to 3, you should start receiving lots of emails from rules that come preconfigured out-of-the-box. Each email will specify the exact rule that triggered that alert.  We will be overwriting some of those rules. 
> this is after a >



