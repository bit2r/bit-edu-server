FROM tattvafoundation/shinyserver_21052022:latest
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

#COPY scripts/shiny-server.conf /etc/shiny-server/shiny-server.conf
WORKDIR /home/install
COPY install_scripts ./install_scripts
COPY scripts/ ./scripts

# install required packages 
RUN R -f install_scripts/install_packages.R 
# install shinylive, quarto, etc.
RUN install_scripts/install_packages.sh

# setup workspace 
RUN git clone https://github.com/joygram/bit-server.git /home/shiny-server

RUN ln -s /home/shiny-server/docker_bit-server/scripts /home/shiny-server/scripts
WORKDIR /home/shiny-server

# copy shiny-server config site: /home/app/shiny-server/apps
RUN chown shiny:shiny -R /home/shiny-server

#USER shiny
SHELL ["/bin/bash", "-c"]

# shiny-server apache2 apache2-ssl ssh
EXPOSE 3838 80 443 22 

## 패치 및 설정 반영 
CMD ["bash", "/home/shiny-server/scripts/update.sh"]
#CMD ["bash"]