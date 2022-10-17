#!/usr/bin/env bash

WEB_PORT=9090
export WEB_PORT

SSH_PORT=4444
export SSH_PORT

SHINY_PORT=3939
export SHINY_PORT

SSL_PORT=8443
export SSL_PORT

CONTAINER_NAME=bit-server
export CONTAINER_NAME

custom_env=../workspace/conf/env.sh
if [[ -f $custom_env ]];then
	source $custom_env 
else 
	# cp custom env template 
	mkdir -p ../workspace/conf
	cp ../scripts/workspace_template/conf/env.sh $custom_env
fi 