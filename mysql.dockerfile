FROM ubuntu/mysql

# Set locale to UTF-8
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"

# Configure your root password
ENV MYSQL_ROOT_PASSWORD="your_root_password"

# Install essential packages.
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install sudo nano tzdata locales ca-certificates -y && \
    apt-get upgrade ca-certificates -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

EXPOSE 3306
