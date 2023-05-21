FROM ubuntu

ARG APACHE_WWW=/var/www
ARG APACHE_CONFG_DIR=/etc/apache2/sites-available

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV PHP_MEMORY_LIMIT 4096M
ENV PHP_POST_MAX_SIZE 4096M
ENV PHP_UPLOAD_MAX_FILESIZE 4096M
ENV PHP_INI=/etc/php/8.1/apache2/php.ini

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget nano curl unzip tzdata locales mysql-client && \
    apt-get install -y iputils-ping iproute2 openssh-server && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y apache2 apache2-utils && \
    apt-get install -y php8.1 php8.1-curl php8.1-mbstring php8.1-xml php8.1-gd && \
    apt-get install -y php8.1-imagick php8.1-dom php8.1-intl php8.1-zip php8.1-mysql libapache2-mod-php

RUN rm -rf $APACHE_CONFG_DIR/* && \
    chown -R www-data:www-data $APACHE_WWW && \
    sed -i "s/^\(memory_limit =\).*/\1 ${PHP_MEMORY_LIMIT}/" $PHP_INI && \
    sed -i "s/^\(post_max_size =\).*/\1 ${PHP_POST_MAX_SIZE}/" $PHP_INI && \
    sed -i "s/^\(upload_max_filesize =\).*/\1 ${PHP_UPLOAD_MAX_FILESIZE}/" $PHP_INI && \
    cd /

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod ugo+rx /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443 3306

ENTRYPOINT ["docker-entrypoint.sh"]