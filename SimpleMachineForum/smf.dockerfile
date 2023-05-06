FROM ubuntu

ARG APACHE_WWW=/var/www
ARG WEB_ROOT_DIR=/var/www/smf
ARG APACHE_CONFG_DIR=/etc/apache2/sites-available

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y apache2 apache2-utils && \
    apt-get install wget -y && \
    apt-get install iproute2 -y && \
    apt-get install nano -y && \
    apt-get install -y unzip && \
    apt-get install tzdata -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install locales -y && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y php php-curl php-mbstring php-xml php-gd && \
    apt-get install -y php-mysql libapache2-mod-php

WORKDIR $APACHE_CONFG_DIR

COPY ./smf.conf ./smf.conf

RUN mv ./000-default.conf ./000-default.conf.bk && \
    mv ./default-ssl.conf ./default-ssl.conf.bk && \
    a2ensite smf.conf && \
    a2enmod rewrite

WORKDIR $APACHE_WWW

RUN rm -rf html/ && \
    wget https://download.simplemachines.org/index.php/smf_2-1-3_install.zip && \
    unzip smf_2-1-3_install.zip -d ./smf && \
    rm smf_2-1-3_install.zip && \
    chown -R www-data:www-data smf/

WORKDIR $WEB_ROOT_DIR

COPY ./config.sh ./config.sh

RUN chmod +x ./config.sh

EXPOSE 80 443

ENTRYPOINT ["/var/www/smf/config.sh"]