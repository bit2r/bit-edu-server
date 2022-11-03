#!/usr/bin/env bash

#source ./install_r_packages.sh 

# install quarto 
wget https://quarto.org/download/latest/quarto-linux-amd64.deb
dpkg -i ./quarto-linux-amd64.deb 

# install shiny-server
wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.19.995-amd64.deb
dpkg -i ./shiny-server-1.5.19.995-amd64.deb

# install rstudio-server 
wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb
dpkg -i ./rstudio-server-2022.07.2-576-amd64.deb

# install code-server
wget -O - https://code-server.dev/install.sh | sh

# install shinylive and python lib 
source ./install_shinylive.sh

# make rc-local service and update 
cp ./rc-local.service /etc/systemd/system/
cp ./rc-local /etc/rc.local
chmod 755 /etc/rc.local
ln -s /lib/systemd/system/rc-local.service /etc/systemd/multi-user.target.wants/rc-local.service
 

# cleanup 
rm *.deb 
