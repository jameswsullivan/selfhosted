#!/bin/bash

service apache2 start

cd /etc/apache2/sites-available
a2ensite *
a2enmod rewrite

service apache2 restart
service apache2 reload

cd /

exec "$@"
tail -f /dev/null