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

# sudo -u shiny R -e "options(renv.consent = TRUE);renv::restore(lockfile = '/home/bit-server/workspace/renv.lock')"

exec sudo -u shiny shiny-server
