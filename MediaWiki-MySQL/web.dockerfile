FROM alpine:3.21.3

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV TZ="America/Chicago"

ENV WEB_ROOT="/var/www/localhost/htdocs"
ENV VIRTUAL_HOST_DIR="/etc/apache2/conf.d"

ENV PHP_INI="/etc/php84/php.ini"
ENV PHP_MEMORY_LIMIT=4096M
ENV PHP_POST_MAX_SIZE=4096M
ENV PHP_UPLOAD_MAX_FILESIZE=4096M
ENV LOG_PHP_ERROR="log_errors = On"
ENV PHP_LOG_FILE="error_log = php_errors.log"

RUN apk update && apk upgrade && \
    apk add --no-cache musl-locales musl-locales-lang tzdata ca-certificates && \
    apk add --no-cache openrc curl wget nano unzip git && \
    update-ca-certificates && \
    apk add --no-cache mysql-client apache2 apache2-utils diffutils && \
    apk add --no-cache php84 php84-apache2 php84-common php84-mbstring php84-xml php84-mysqli && \
    apk add --no-cache php84-fileinfo php84-ctype php84-calendar php84-session php84-dom && \
    apk add --no-cache php84-iconv php84-intl php84-gd php84-pecl-apcu && \
    ln -s /usr/bin/php84 /usr/bin/php

RUN rm -rf /var/www/localhost/htdocs/* && \
    sed -i "s/^\(memory_limit =\).*/\1 ${PHP_MEMORY_LIMIT}/" ${PHP_INI} && \
    sed -i "s/^\(post_max_size =\).*/\1 ${PHP_POST_MAX_SIZE}/" ${PHP_INI} && \
    sed -i "s/^\(upload_max_filesize =\).*/\1 ${PHP_UPLOAD_MAX_FILESIZE}/" ${PHP_INI} && \
    echo ${PHP_LOG_FILE} >> ${PHP_INI}

EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]

