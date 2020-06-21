

## Sending security email alerts from Ubuntu 18.04 with [Wazuh](https://wazuh.com/)  

### This is a very basic step-by-step explanation of installing Wazuh to send email alerts

To make this as simple as posible, Wazuh manager server will be installed in a standalone system. No agents in other machines, no API & no Elastic stack.
> Wazuh server monitors itself by default. The manager includes an agent (whose ID is 000) when you install it. Although it is not listed in Kibana, you can see that it really exists if you run this command in your manager: `/var/ossec/bin/agent_control -lc`

Wazuh/Ossec is a huge topic, here I was just trying to get something up & running in order understand the email alerts & make some experiments.

---
### As a prerequisite, postfix should be already installed & you should be able to send emails by :

```
echo "Test Postfix using a relay host" | mail -s "Postfix  test" myuser@example.com
```

Instruccions on how to install postfix can be found here: [https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication](https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication)

---
### Next, install wazuh-manager

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
The wazuh-manager.service should be active(running).

For more info : [https://documentation.wazuh.com/3.12/installation-guide/installing-wazuh-manager/linux/ubuntu/wazuh_server_packages_ubuntu.html#wazuh-server-packages-ubuntu](https://documentation.wazuh.com/3.12/installation-guide/installing-wazuh-manager/linux/ubuntu/wazuh_server_packages_ubuntu.html#wazuh-server-packages-ubuntu)

---
### Configure Wazuh to start sending emails with postfix

Edit /var/ossec/etc/ossec.conf as follows:
```
<global>
<email_notification>yes</email_notification>
<smtp_server>localhost</smtp_server>
<email_from>USERNAME@example.com</email_from>
<email_to>you@example.com</email_to>
</global>
```
Restart the manager
```
systemctl restart wazuh-manager
```
For more info : - [https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication](https://documentation.wazuh.com/3.12/user-manual/manager/manual-email-report/smtp_authentication.html#smtp-authentication)  note: find it at bottom of page

---
### Why did we received this strange email ?

You should have received your first email with something like this :
> Rule: 502 fired (level 3) -> "Ossec server started." Portion of the log(s): ossec: Ossec started.

Wazuh/Ossec comes with "stock rules"(should not be edited but we can overwrite them) which are located in various files in /var/ossec/ruleset/rules/ on the Wazuh manager.

To find out more about the email we just received, we can take a look at rule 502 which is located in /var/ossec/ruleset/rules/0015-ossec_rules.xml

```
  <rule id="502" level="3">
    <if_sid>500</if_sid>
    <options>alert_by_email</options>
    <match>Ossec started</match>
    <description>Ossec server started.</description>
    <group>pci_dss_10.6.1,gpg13_10.1,gdpr_IV_35.7.d,hipaa_164.312.b,nist_800_53_AU.6,</group>
  </rule>
```

---
### How can we overwrite rules

As specified in [https://documentation.wazuh.com/3.12/learning-wazuh/replace-stock-rule.html](https://documentation.wazuh.com/3.12/learning-wazuh/replace-stock-rule.html)
> The Wazuh Ruleset is maintained by Wazuh, Inc. and is contributed to by the Wazuh community. These stock rules are located in various files in /var/ossec/ruleset/rules/ on the Wazuh manager and should not be edited in that location because they are overwritten when you upgrade Wazuh manager or perform a Wazuh Ruleset update.
> Custom changes to the ruleset must be done within files in the /var/ossec/etc/rules/ folder. In order to change a default rule, then the overwrite="yes" option must be used when declaring the rule.

When overwriting a rule for the purpose of sending email alerts, we could :
* Add or remove \<options>alert_by_email\</options> to the rule.
* Change the level. For example, if in /var/ossec/etc/ossec.conf we find \<email_alert_level>12</email_alert_level>, then (in the case of rule 502), we would need to change level="3" to level="13". 

---
### How to learn more about which rules do what :
   1. Read the documentation [https://documentation.wazuh.com/3.12/user-manual/ruleset/index.html](https://documentation.wazuh.com/3.12/user-manual/ruleset/index.html)
   1. Inspect /var/ossec/ruleset/rules/
   1. Play with Wazuh :
      * vim /var/ossec/etc/ossec.conf
      * change \<email_alert_level>12\</email_alert_level>, to a very low level like 3
      * start making lots of suspicious activities that Wazuh is suppose to identify
      * you may also have to change the frequency & other configuration of some modules


---
### Sending an email alert when root login

The rule for root logins is 5501 & we can find it in /var/ossec/ruleset/rules/0085-pam_rules.xml(do not edit this file).

To overwrite it, we can copy-paste it & add it to /var/ossec/etc/rules/local_rules.xml with some changes like this :
```
<group name="pam,syslog,">
  <rule id="5501" level="3" overwrite="yes">
    <if_sid>5500</if_sid>
    <options>alert_by_email</options>
    <match>session opened for user </match>
    <description>PAM: Login session opened.</description>
  <group>authentication_success,pci_dss_10.2.5,gpg13_7.8,gpg13_7.9,gdpr_IV_32.2,hipaa_164.312.b,nist_800_53_AU.14,nist_800_53_AC.7,</group>
  </rule>
</group>
```
Restart the manager
```
systemctl restart wazuh-manager
```
Logout & login as root. You should receive an email alert with something like this :
> Received From: \<yourserver>->/var/log/auth.log 
Rule: 5501 fired (level 3) -> "PAM: Login session opened."
User: root
Portion of the log(s):
Jun 21 00:18:42 \<yourserver> sudo: pam_unix(sudo:session): session opened for user root by r(uid=0)
uid: 0

---
### Other examples
* Keep watch for malicious command execution [https://documentation.wazuh.com/3.12/learning-wazuh/audit-commands.html](https://documentation.wazuh.com/3.12/learning-wazuh/audit-commands.html)
* Detect an SSH brute-force attack [https://documentation.wazuh.com/3.12/learning-wazuh/ssh-brute-force.html/](https://documentation.wazuh.com/3.12/learning-wazuh/ssh-brute-force.html/)

