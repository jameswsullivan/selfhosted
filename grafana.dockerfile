FROM grafana/grafana-enterprise:latest-ubuntu

ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"

USER root

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install nano tzdata locales -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    sed -i "s|;http_port = 3000|http_port = 80|g" /etc/grafana/grafana.ini

EXPOSE 80 443
