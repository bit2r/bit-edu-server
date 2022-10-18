#!/usr/bin/bash
source ./install_quarto.sh

# install shinylive and python lib 
source ./install_shinylive.sh

source ./install_r_packages.sh 

wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.19.995-amd64.deb
dpkg -i ./shiny-server-1.5.19.995-amd64.deb

wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb
dpkg -i ./rstudio-server-2022.07.2-576-amd64.deb

# cleanup 
rm *.deb 

# for presentation
npm install reveal.js
