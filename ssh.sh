#!/bin/bash

#Font Colors

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
ENDCOLOR="\e[0m"

clear

#public ip

pub_ip=$(wget -qO- https://ipecho.net/plain ; echo)

#root check

if ! [ $(id -u) = 0 ]; then
   echo -e "${RED}Plese run the script with root privilages!${ENDCOLOR}"
   exit 1
fi

spinner()
{
    #Loading spinner
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
pre_req()
{
        #installing pre-requirements and adding port rules to ubuntu firewall
		
	apt update -y && apt upgrade -y

        apt-get install -y dropbear && apt-get install -y stunnel4 && apt-get install -y squid && apt-get install -y cmake && apt-get install -y python3 && apt-get install -y screenfetch && apt-get install -y openssl
        ufw allow 443/tcp
	ufw allow 444/tcp
        ufw allow 22/tcp
        ufw allow 80/tcp
        ufw allow 110/tcp
        ufw allow 8080/tcp
        ufw allow 7300/tcp
        ufw allow 7300/udp
}
mid_conf()
{

#configuring openssh

sed -i 's/#Banner none/Banner \/etc\/banner/' /etc/ssh/sshd_config


#Adding the banner

cat << EOF > /etc/banner
<br>
<font>ೋ˚❁ೃೀ๑۩۞۩๑ೃೀ❁ೋ˚</font><br>
<font>┊┊┊┊ <b><font color="#ff5079">&nbsp;Rezoth</font>™</b></font><br>
<font>┊┊┊✧ </font><br>
<font>┊┊✦ <font color="#A52A2A">&nbsp;NO HACKING !!!</font></font><br>
<font>┊✧ <font color="#8A2BE2">&nbsp;NO CARDING !!!</font></font><br>
<font>✦ <font color="#FF7F50">&nbsp;NO TORRENT !!!</font></font><br>
<font>.   ✫   .  ˚  ✦  · </font><br>
<font> .  +  · · <font color="#33a6ff"></font></font><br>
<font>    ✹   . <font color="#008080">&nbsp;Your privacy is our number one priority</font></font><br>
<font>✦  · </font><br>
<b>&nbsp;Powered by <font color="#ff5079">Rezoth™</font></b><br>
<font>     .  +  · </font>
EOF


#creating badvpn systemd service unit

cat << EOF > /etc/systemd/system/udpgw.service
[Unit]
Description=UDP forwarding for badvpn-tun2socks
After=nss-lookup.target

[Service]
ExecStart=/usr/local/bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 10000 --max-connections-for-client 10 --client-socket-sndbuf 10000
User=udpgw

[Install]
WantedBy=multi-user.target
EOF
}
fun_panel()
{
mkdir /etc/rezoth-ssh
wget https://raw.githubusercontent.com/iamtrazy/rezoth-ssh/main/etc/Banner.sh
mv Banner.sh /etc/rezoth-ssh/Banner.sh
mv menu /usr/local/bin/menu
chmod +x /etc/rezoth-ssh/Banner.sh
chmod +x /usr/local/bin/menu
}
fun_service_start()
{
#enabling and starting all services
#exit script
echo -e "\n${CYAN}Script installed. You can access the panel using 'menu' command. ${ENDCOLOR}\n"
echo -e "\nPress Enter key to exit"; read
