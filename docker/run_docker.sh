#!/usr/bin/env bash
chmod 755 *.sh
source ./env.sh
IMAGE_NAME=joygram/bit-server
echo start $IMAGE_NAME to $CONTAINER_NAME : $WEB_PORT
docker rm $CONTAINER_NAME
docker run -d -it --hostname $CONTAINER_NAME -p $WEB_PORT:80 -p $SSH_PORT:22 --name $CONTAINER_NAME -v "$(pwd)/../workspace:/home/bit-server/workspace" $IMAGE_NAME