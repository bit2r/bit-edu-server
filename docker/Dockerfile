FROM joygram/bit-server-base:latest
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer="joygram <joygram@gmail.com>"

RUN apt-get -y install libfreetype6-dev

WORKDIR /home/bit-server

RUN chown -R bit:bit /var/lib/shiny-server
RUN chown -R bit:bit /home/bit-server/workspace 
#  apache2 apache2-ssl ssh rstudio-server shiny-server 
#EXPOSE 80 22 8787 3838 443  
EXPOSE 80 22 8080 5000 


## 패치 및 설정 반영 
CMD ["bash", "/home/bit-server/scripts/update.sh"]