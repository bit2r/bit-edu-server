#!/usr/bin/bash
bash ./env.sh
echo start $CONTAINER_NAME : http://localhost:$WEB_PORT
docker run -d --rm -p $WEB_PORT:80 -p $SSH_PORT:22 -p $SHINY_PORT:3838  -p 8443:443 --name $CONTAINER_NAME -v "$(pwd)/../workspace:/home/bit-server/workspace" bit-server-local