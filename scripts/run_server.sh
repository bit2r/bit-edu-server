#!/usr/bin/bash

bash ./copy_conf.sh

echo == run servers ==
# run sshd 
service ssh start 

#run apache2
service apache2 start 

#mysql 
#service mysql start 
service mariadb start 

#rstudio-server
service rstudio-server start

#code-server
service code-server start 

exec sudo -u shiny shiny-server