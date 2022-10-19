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

#shiny-server 
service shiny-server start 

service --status-all 
#exec sudo -u bit shiny-server
exec sudo -u bit bash