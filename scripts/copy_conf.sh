#!/usr/bin/env bash
echo == copy conf === 
# update docker's config 
TARGET_SHINY_CONF=/etc/shiny-server/shiny-server.conf
TARGET_APACHE_CONF=/etc/apache2

# copy service conf override 
echo == apply service script 
cp -R ./init.d/* /etc/init.d/
chmod 755 /etc/init.d/*

cp ./shiny-server/shiny-server.conf $TARGET_SHINY_CONF
cp -R ./apache2/* $TARGET_APACHE_CONF

# echo copy == bash rc 
# cp ./bash/.bashrc /home/bit-server/
# cp ./bash/.bashrc ~/

# echo == apply custom conf == 
# # apply custom shiny-server config
# CUSTOM_SHINY_CONF=/home/bit-server/workspace/conf/shiny-server/shiny-server.conf
# if [[ -f "$CUSTOM_SHINY_CONF" ]]; then
# 	echo copy $CUSTOM_SHINY_CONF
# 	cp $CUSTOM_SHINY_CONF $TARGET_SHINY_CONF
# fi 

# # apply custom apache config 
# CUSTOM_APACHE_CONF=/home/bit-server/workspace/conf/apache2/
# if [[ -d "$CUSTOM_APACHE_CONF" ]]; then
# 	echo copy $CUSTOM_APACHE_CONF
# 	cp -R $CUSTOM_APACHE_CONF $TARGET_APACHE_CONF
# fi

chmod -R 777 /var/log/shiny-server