
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