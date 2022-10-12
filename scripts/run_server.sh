#!/usr/bin/bash

# update docker's config 
TARGET_SHINY_CONF=/etc/shiny-server/shiny-server.conf
TARGET_APACHE_CONF=/etc/apache2

cp ./shiny-server/shiny-server.conf $TARGET_SHINY_CONF
cp -R /apache2/* $TARGET_APACHE_CONF

echo == apply custom conf == 
# apply custom shiny-server config
CUSTOM_SHINY_CONF=/home/bit-server/workspace/conf/shiny-server/shiny-server.conf
if [ -f "$CUSTOM_SHINY_CONF" ]; then
	cp $CUSTOM_SHINY_CONF $TARGET_SHINY_CONF
fi 

# apply custom apache config 
CUSTOM_APACHE_CONF=/home/bit-server/workspace/conf/apache2/*
if [ -d "$TARGET_APACHE_CONF"]; then
	cp -R $CUSTOM_APACHE_CONF $TARGET_APACHE_CONF
fi

echo == run servers ==
# run sshd 
service ssh start 

#run apache2
service apache2 start 

#run mysqld 
service mysql start 

# sudo -u shiny R -e "options(renv.consent = TRUE);renv::restore(lockfile = '/home/bit-server/workspace/renv.lock')"

exec sudo -u shiny shiny-server
