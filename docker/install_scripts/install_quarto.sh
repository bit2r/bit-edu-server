#!/usr/bin/bash

wget https://quarto.org/download/latest/quarto-linux-amd64.deb
apt-get install -y gdebi-core
dpkg -i ./quarto-linux-amd64.deb 
