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
echo === try initialize workspace ===
TEMPLATE_PATH=/home/bit-server/scripts/workspace_template/*
WORKSPACE_PATH=/home/bit-server/workspace/
if [[ ! -d "$WORKSPACE_PATH/html" ]]; then
	echo copy $TEMPLATE_PATH $WORKSPACE_PATH 
	cp -R $TEMPLATE_PATH $WORKSPACE_PATH
fi 
