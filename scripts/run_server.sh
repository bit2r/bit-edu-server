#!/usr/bin/bash

bash ./copy_conf.sh

echo == run servers ==
# run sshd 
service ssh restart 

#run apache2
service apache2 restart 

#mysql 
#service mysql start 
service mariadb restart 

#rstudio-server
service rstudio-server restart

#code-server
service code-server restart 

#shiny-server 
service shiny-server restart 

service --status-all 
#exec sudo -u bit shiny-server

exec sudo -u bit bash