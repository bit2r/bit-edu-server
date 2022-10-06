#!/usr/bin/bash
pushd .
echo git clone 
git clone https://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@github.com/joygram/shiny-editor.git /home/shiny-server
ln -s /home/shiny-server/docker_bit-server/scripts /home/shiny-server/scripts
popd 
