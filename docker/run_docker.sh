#!/usr/bin/env bash
chmod 755 *.sh
source ./env.sh
IMAGE_NAME=joygram/bit-server
echo start $IMAGE_NAME to $CONTAINER_NAME : $WEB_PORT
docker run -d -it -p $WEB_PORT:80 -p $SSH_PORT:22 -p $SHINY_PORT:3838  -p $SSL_PORT:443 --name $CONTAINER_NAME -v "$(pwd)/../workspace:/home/bit-server/workspace" $IMAGE_NAME