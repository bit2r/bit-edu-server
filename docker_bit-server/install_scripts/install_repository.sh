#!/usr/bin/bash
pushd .
echo git clone 
git clone https://github.com/joygram/bit-server.git /home/shiny-server
ln -s /home/shiny-server/docker_bit-server/scripts /home/shiny-server/scripts
popd 
