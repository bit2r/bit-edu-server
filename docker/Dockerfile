FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer="joygram <joygram@gmail.com>"

RUN apt update
RUN apt-get update 
RUN apt upgrade -y 

RUN apt-get install -y git 
RUN apt-get install -y texlive-xetex 
RUN apt-get install -y fonts-lmodern fonts-nanum fonts-unfonts-extra 
RUN apt-get install -y tzdata 
RUN apt-get install -y openssh-server 
RUN apt-get install -y gdebi-core 
RUN apt-get install -y r-base r-cran-devtools 
RUN apt-get install -y vim 

# update apt for php 
RUN apt install -y software-properties-common ca-certificates lsb-release apt-transport-https 
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php 


# nodejs 18 and yarn  and apache2
RUN apt -y purge nodejs 
RUN apt -y autoremove 
RUN wget -O - https://deb.nodesource.com/setup_current.x | bash -
RUN apt-get install -y apt-utils
RUN apt-get install -y nodejs
RUN apt-get install -y yarn 
RUN apt-get install -y apache2
# install php8 
RUN apt install php8.1 -y

# install mariadb 
RUN apt install mariadb-server mariadb-client -y

# make ssh admin account 
RUN useradd -m shiny
RUN echo "shiny:shiny" | chpasswd 

#server settings 
WORKDIR /home/install
COPY install_scripts /home/install

# install required packages 
RUN R -f ./install_packages.R 

# install shinylive, quarto, etc.
RUN ./install_packages.sh

#change shiny user directory and sudouer 
RUN usermod -d /home/bit-server shiny
RUN usermod -aG sudo shiny
RUN apt-get install -y sudo 
# setup workspace 
RUN git clone https://github.com/joygram/bit-server.git /home/bit-server

WORKDIR /home/bit-server
RUN cp /home/install/.bash* /home/bit-server
RUN chown shiny:shiny -R /home/bit-server


#  apache2 apache2-ssl ssh rstudio-server shiny-server 
EXPOSE 80 22 8787 3838 443  

# additional apache setting
RUN a2enmod proxy proxy_http proxy_wstunnel rewrite

RUN chsh shiny -s /usr/bin/bash 
RUN chsh root -s /usr/bin/bash 

## 패치 및 설정 반영 
CMD ["bash", "/home/bit-server/scripts/update.sh"]