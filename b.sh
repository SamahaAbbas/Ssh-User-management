#!/bin/bash
clear 
# Edited Opiran Version . Special Thanks To OPIran 



# Install required packages
apt update
apt install ufw libapache2-mod-geoip geoip-database -y
a2enmod geoip
apt install geoip-bin -y

# Open desired ports
ufw allow ssh
ufw allow http
ufw allow https

curl -sSL "https://www.ipdeny.com/ipblocks/data/countries/ir.zone" | awk '{print "sudo ufw deny out from any to ir"}' | bash


ufw enable

# Set up a cronjob to update the zone every 1 month
cronjob_command="curl -sSL https://www.ipdeny.com/ipblocks/data/countries/ir.zone | awk '{print \"sudo ufw deny out from any to ir" }' | bash"
(crontab -l ; echo "0 0 1 * * $cronjob_command") | crontab -
