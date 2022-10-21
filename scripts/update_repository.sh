#!/usr/bin/bash
if [ ! -d /home/bit-server ]; then
	echo == git clone == 
	sudo -u bit git clone https://github.com/joygram/bit-server.git /home/bit-server
else 
	echo == git repository update ==
	pushd .
	cd /home/bit-server
	sudo -u bit git reset HEAD^ --hard
	sudo -u bit git pull 
	popd 
fi

# initialize workspace template
TEMPLATE_PATH=/home/bit-server/scripts/workspace_template/*
WORKSPACE_PATH=/home/bit-server/workspace/
if [[ ! -d "$WORKSPACE_PATH/html" ]]; then
	echo == copy workspace template == 
	cp -R $TEMPLATE_PATH $WORKSPACE_PATH
fi 

chmod 777 -R /tmp/*