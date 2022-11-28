#!/usr/bin/bash
if [ ! -d /home/bit-server ]; then
	echo == git clone == 
	sudo -u bit git clone https://github.com/bit2r/edu-bit-server.git /home/bit-server
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

# update workspace by joygram 2022/11/02
if [[ -f "$WORKSPACE_PATH/scripts/update_workspace.sh" ]]; then
	echo == update workspace == 
	source $WORKSPACE_PATH/scripts/update_workspace.sh
fi
chmod 777 -R /tmp/*