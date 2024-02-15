FROM ubuntu/mysql     

# Set locale to UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Configure your root password
ENV MYSQL_ROOT_PASSWORD=1234

# Set timezone to Central Time
ENV TZ=America/Chicago

# Install essential packages.   
RUN apt-get update -y && \      
    apt-get install -y sudo nano tzdata locales && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306