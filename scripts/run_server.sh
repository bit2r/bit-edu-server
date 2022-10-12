#!/usr/bin/bash

bash ./copy_conf.sh

echo == run servers ==
# run sshd 
service ssh start 

#run apache2
service apache2 start 

#run mysqld 
service mysql start 

# sudo -u shiny R -e "options(renv.consent = TRUE);renv::restore(lockfile = '/home/bit-server/workspace/renv.lock')"

exec sudo -u shiny shiny-server
