#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
ENDCOLOR="\e[0m"

clear
nano banner
banner=$(cat banner)
cp /etc/banner /etc/banner.cbackup

while true; do
    read -p "Do you want to apply the new Banner ? (Y/N) " yn
    case $yn in
        [Yy]* ) rm -f /etc/banner && echo "$banner" >> /etc/banner && echo -e "${YELLOW}New Banner applied${ENDCOLOR}" && systemctl restart sshd && systemctl restart dropbear && systemctl restart stunnel4 && rm -f /etc/banner.cbackup && rm -f banner;break;;
        [Nn]* ) mv /etc/banner.cbackup /etc/banner && systemctl restart sshd && systemctl restart dropbear && systemctl restart stunnel4 && echo -e "${RED}\nBanner not applied.${ENDCOLOR}";break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\nPress Enter key to return to main menu";read
menu
