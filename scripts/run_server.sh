#!/usr/bin/bash

bash ./copy_conf.sh

echo == run servers ==
# run sshd 
service ssh start 

#run apache2
service apache2 start 

#run mysqld 
service mysql start 

exec sudo -u shiny shiny-server
