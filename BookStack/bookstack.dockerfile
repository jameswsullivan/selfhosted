FROM ubuntu

ARG APACHE_DIR=/var/www
ARG BOOKSTACK_DIR=/var/www/bookstack
ARG DEBIAN_FRONTEND=noninteractive

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install wget -y && \
    apt-get install iproute2 -y && \
    apt-get install nano -y && \
    apt-get install tzdata -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install locales -y && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y git unzip apache2 php8.1 curl php8.1-curl \
    php8.1-mbstring php8.1-ldap php8.1-xml php8.1-zip php8.1-gd \
    php8.1-mysql libapache2-mod-php8.1 && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR $APACHE_DIR

RUN git clone https://github.com/BookStackApp/BookStack.git --branch release --single-branch && \       
    mv BookStack/ bookstack/ && \
    chown -R www-data:www-data $BOOKSTACK_DIR

WORKDIR $BOOKSTACK_DIR

COPY ./config.sh ./config.sh

RUN composer install --no-dev && \
    mv $BOOKSTACK_DIR/public/.htaccess $BOOKSTACK_DIR/public/.htaccess.bk && \
    mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bk && \
    mv /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bk && \
    chmod +x config.sh

ENTRYPOINT ["/var/www/bookstack/config.sh"]