#!/usr/bin/bash
if [ ! -d /home/shiny-server ]; then
	echo git clone 
	sudo -u shiny git clone https://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@github.com/joygram/shiny-editor.git /home/shiny-server
else 
	echo git update 
	pushd .
	cd /home/shiny-server
	sudo -u shiny git reset --hard
	sudo -u shiny git pull 
	popd 
fi
