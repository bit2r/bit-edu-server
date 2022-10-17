#!/usr/bin/bash


wget https://quarto.org/download/latest/quarto-linux-amd64.deb
dpkg -i ./quarto-linux-amd64.deb 

# for presentation
npm install reveal.js