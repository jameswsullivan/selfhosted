FROM rockylinux:9.2

ARG WEB_ROOT="/usr/share/nginx/html"
ARG PHP_INI="/etc/php.ini"
ARG PHP_MEMORY_LIMIT="4096M"
ARG PHP_POST_MAX_SIZE="4096M"
ARG PHP_UPLOAD_MAX_FILESIZE="4096M"
ARG LOG_PHP_ERROR="log_errors = On"
ARG PHP_LOG_FILE="error_log = php_errors.log"

RUN dnf -y update && \
    dnf -y install nginx nano procps mysql && \
    # Install PHP:
    dnf -y install php-fpm php-mysqlnd php-gd php-cli \
    php-curl php-mbstring php-bcmath php-zip php-opcache \
    php-xml php-json php-intl && \
    # Configure time zone to Central:
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    # Create /run/php-fpm directory:
    mkdir /run/php-fpm && \
    mkdir /opt/configs

COPY ./nginx.entrypoint.sh /opt/configs/entrypoing.sh
COPY ./phpinfo.php ${WEB_ROOT}

RUN sed -i "s/^\(memory_limit =\).*/\1 ${PHP_MEMORY_LIMIT}/" ${PHP_INI} && \
    sed -i "s/^\(post_max_size =\).*/\1 ${PHP_POST_MAX_SIZE}/" ${PHP_INI} && \
    sed -i "s/^\(upload_max_filesize =\).*/\1 ${PHP_UPLOAD_MAX_FILESIZE}/" ${PHP_INI} && \
    sed -i 's/^user = apache$/user = nginx/' /etc/php-fpm.d/www.conf && \
    sed -i 's/^group = apache$/group = nginx/' /etc/php-fpm.d/www.conf && \
    echo ${LOG_PHP_ERROR} >> ${PHP_INI} && \
    echo ${PHP_LOG_FILE} >> ${PHP_INI} && \
    chmod ugo+rx /opt/configs/entrypoing.sh

WORKDIR ${WEB_ROOT}

EXPOSE 80 443
ENTRYPOINT ["/opt/configs/entrypoing.sh"]