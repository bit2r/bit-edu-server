#!/usr/bin/bash

# update config 
cp ./shiny-server.conf /etc/shiny-server/shiny-server.conf

# update r-packages 
#R -f ./install_packages_additional.R
cd /home/shiny-server
R -e "renv::restore()"

#service sshd start 
#/usr/sbin/init

service ssh start 
service shiny-server start
exec sudo -u shiny shiny-server #>> /var/log/shiny-server.log 2>&1 
