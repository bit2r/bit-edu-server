FROM joygram/bit-server-base:latest
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer="joygram <joygram@gmail.com>"

WORKDIR /home/bit-server

RUN chown -R bit:bit /var/lib/shiny-server

# override latest repository
RUN rm -rf /home/bit-server
RUN git clone https://github.com/bit2r/bit-edu-server.git /home/bit-server
RUN chown -R bit:bit /home/bit-server

#  apache2 apache2-ssl ssh rstudio-server shiny-server 
#EXPOSE 80 22 8787 3838 443  
EXPOSE 80 22 5000

RUN apt-get install -y libsass-dev
RUN apt-get install -y libxt-dev
RUN apt-get install -y npm

RUN cp /home/install/rc-local.service /etc/systemd/system/
RUN cp /home/install/rc.local /etc/

# composer with php 7.1 bit-learn
RUN apt-get install -y php7.1
RUN apt-get install -y php7.1-sqlite sqlite3
RUN apt-get install -y php7.1-curl 
RUN apt-get install -y php7.1-xml
RUN apt update
RUN apt install -y php-cli unzip
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
CMD ["/sbin/init"]