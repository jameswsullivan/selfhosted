FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

ARG WEB_ROOT=/var/www/html
ARG SITE_CONFIG_DIR=/etc/apache2/sites-available

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget nano curl unzip tzdata locales ca-certificates && \
    apt-get upgrade ca-certificates -y && \
    apt-get install -y iputils-ping iproute2 && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y apache2 apache2-utils && \
    rm -rf ${SITE_CONFIG_DIR}/*

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
COPY ./000-default.conf ${SITE_CONFIG_DIR}

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["entrypoint.sh"]