FROM rocker/shiny:latest
LABEL maintainer="joygram <joygram@gmail.com>"

RUN apt update

RUN apt-get install -y \
	git \
	texlive-xetex \
	fonts-lmodern \
	fonts-nanum \
	fonts-unfonts-extra \
	tzdata \
	openssh-server

RUN apt-get update 
RUN apt-get install -y vim 

RUN apt install -y software-properties-common ca-certificates lsb-release apt-transport-https 
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php 
RUN apt upgrade -y 

# nodejs 18 and yarn  and apache2
RUN wget -O - https://deb.nodesource.com/setup_18.x  | bash
RUN apt-get install -y nodejs yarn apache2

# install php8 
RUN apt install php8.1 -y

# install mariadb 
RUN apt install mariadb-server mariadb-client -y

# make ssh admin account 
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

# setup workspace 
RUN git clone https://github.com/joygram/bit-server.git /home/bit-server

WORKDIR /home/bit-server
RUN cp /home/install/.bash* /home/bit-server
RUN chown shiny:shiny -R /home/bit-server


# shiny-server apache2 apache2-ssl ssh
EXPOSE 80 443 22 3838 

# additional apache setting
RUN a2enmod proxy proxy_http proxy_wstunnel rewrite

RUN chsh shiny -s /usr/bin/bash 
RUN chsh root -s /usr/bin/bash 

## 패치 및 설정 반영 
CMD ["bash", "/home/bit-server/scripts/update.sh"]