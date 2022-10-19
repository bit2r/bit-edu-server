FROM joygram/bit-server-base:latest
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer="joygram <joygram@gmail.com>"

# setup workspace 
#RUN git clone https://github.com/joygram/bit-server.git /home/bit-server

# add locale 
RUN apt-get install locales -y 
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /home/bit-server

RUN chown -R bit:bit /var/lib/shiny-server

#  apache2 apache2-ssl ssh rstudio-server shiny-server 
#EXPOSE 80 22 8787 3838 443  
EXPOSE 80 22 


## 패치 및 설정 반영 
CMD ["bash", "/home/bit-server/scripts/update.sh"]