FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV DB_CONTAINER_NAME=

COPY script.sh /opt/script.sh

RUN apt-get update && \
    apt-get install -y nano mysql-client tzdata locales ca-certificates && \
    apt-get upgrade ca-certificates -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    chmod +x /opt/script.sh

# ENTRYPOINT ["/opt/script.sh"]