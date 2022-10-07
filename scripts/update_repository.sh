#!/usr/bin/bash
if [ ! -d /home/bit-server ]; then
	echo == git clone == 
	sudo -u shiny git clone https://github.com/joygram/bit-server.git /home/bit-server
else 
	echo == git repository update ==
	pushd .
	cd /home/bit-server
	sudo -u shiny git reset --hard
	sudo -u shiny git pull 
	popd 
fi
