#!/usr/bin/bash

# update config 
cp ./shiny-server.conf /etc/shiny-server/shiny-server.conf

#update r-packages 
#R -f ./install_packages_additional.R

echo == run servers ==
# run sshd 
service ssh start 

#run apache2
service apache2 start 

#run mysqld 
service mysql start 

exec sudo -u shiny shiny-server
