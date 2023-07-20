FROM ubuntu

ARG APACHE_DIR=/var/www/html
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
    apt-get install -y wget nano curl unzip tzdata locales mysql-client ca-certificates && \
    apt-get upgrade ca-certificates -y && \
    apt-get install -y iputils-ping iproute2 openssh-server && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y apache2 apache2-utils && \
    apt-get install -y php8.1 php8.1-curl php8.1-mbstring php8.1-xml php8.1-gd && \
    apt-get install -y php8.1-imagick php8.1-dom php8.1-intl php8.1-zip php8.1-mysql libapache2-mod-php && \
    apt-get install -y vsftpd acl

RUN rm -rf $APACHE_CONFG_DIR/* && \
    sed -i "s/^\(memory_limit =\).*/\1 ${PHP_MEMORY_LIMIT}/" $PHP_INI && \
    sed -i "s/^\(post_max_size =\).*/\1 ${PHP_POST_MAX_SIZE}/" $PHP_INI && \
    sed -i "s/^\(upload_max_filesize =\).*/\1 ${PHP_UPLOAD_MAX_FILESIZE}/" $PHP_INI && \
    # configure FTP user and permissions.
    useradd -m ftpuser && echo "ftpuser:1234" | chpasswd && \
    setfacl -Rm u:ftpuser:rwx $APACHE_DIR && \
    chown -R ftpuser:www-data $APACHE_DIR && \
    chmod -R 775 $APACHE_DIR && \
    sed -i 's:/home/ftpuser:/var/www/html:g' /etc/passwd && \
    cd /

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod ugo+rx /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443 3306 21 30000
ENTRYPOINT ["docker-entrypoint.sh"]