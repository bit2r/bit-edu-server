#!/usr/bin/bash
if [ ! -d /home/bit-server ]; then
	echo == git clone == 
	sudo -u shiny git clone https://github.com/joygram/bit-server.git /home/bit-server
else 
	echo == git repository update ==
	pushd .
	cd /home/bit-server
	sudo -u shiny git reset HEAD^ --hard
	sudo -u shiny git pull 
	popd 
fi

# initialize workspace template
TEMPLATE_PATH=/home/bit-server/scripts/workspace_template/*
WORKSPACE_PATH=/home/bit-server/workspace/
if [[ ! -d "$WORKSPACE_PATH/html" ]]; then
	echo == copy workspace template == 
	cp -R $TEMPLATE_PATH $WORKSPACE_PATH
fi 

# temp 
wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb
gdebi rstudio-server-2022.07.2-576-amd64.deb