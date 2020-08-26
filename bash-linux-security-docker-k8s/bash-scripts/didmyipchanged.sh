#!/bin/bash


previous=$(cat /home/username/scripts/myip.txt)

#  clear  both  files
>/home/username/scripts/myip.txt
cp /dev/null /home/username/scripts/myip.txt

> /home/username/scripts/myipresult.txt



echo 'something wrong with curl in /home/username/scripts/didmyipchanged' >> /home/username/scripts/myip.txt

# now if curl works it should overwrite previous msg
curl https://ifconfig.co/ip -o /home/username/scripts/myip.txt

sleep 2
#sleep 2 seconds. if 2 minutes would be sleep 2m

current=$(cat /home/username/scripts/myip.txt)


# this is for strings
#if [ "$current" = "$previous" ]
if [[ "$current" == "$previous" ]]

#this print integer expected
#if [ "$current" -eq "$previous" ]

then
  echo " they are equal" >> /home/username/scripts/myipresult.txt
  #/home/username/scripts/sendemail.sh "Public IP has not changed. Current IP is $current .  Previous IP was $previous . The ip was obtain this way: curl-https://ifconfig.co/ip -o /home/username/scripts/myip.txt "

else
    echo " they are NOT equal" >> /home/username/scripts/myipresult.txt
    /home/username/scripts/sendemail.sh "Public IP did changed. Current IP is $current . Previous IP was $previous. "

fi
