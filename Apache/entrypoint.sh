#!/bin/bash

service apache2 start

cd /etc/apache2/sites-available
a2ensite *
a2enmod proxy
a2enmod proxy_http

service apache2 restart
service apache2 reload

cd /var/www/html

exec "$@"
tail -f /dev/null