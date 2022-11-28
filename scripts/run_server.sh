#!/usr/bin/bash

bash ./copy_conf.sh

systemctl daemon-reload 

echo == run servers ==
# run sshd 
service ssh restart 

#run apache2
service apache2 restart 

#service mysql start 
service mariadb restart 

#rstudio-server
service rstudio-server restart
#code-server
service code-server restart 

service --status-all 

#shiny-server 
service shiny-server restart 
