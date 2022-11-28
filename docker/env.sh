#!/usr/bin/env bash

export WEB_PORT=9090
export SSH_PORT=2222
export SHINY_PORT=3939
export SSL_PORT=8443
export RSTUDIO_PORT=8787
export CONTAINER_NAME=bit-edu-server

custom_env=../workspace/conf/env.sh
if [[ -f $custom_env ]];then
	source $custom_env 
else 
	# cp custom env template 
	mkdir -p ../workspace/conf
	cp ../scripts/workspace_template/env.sh $custom_env
fi 
