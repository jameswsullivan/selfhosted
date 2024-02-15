#!/bin/bash

mkdir mkdir /var/www/html/${PATH_TO_TEST}
ls -al mkdir /var/www/html/${PATH_TO_TEST}
echo "\n"

cp -a /opt/index.html /var/www/html/${PATH_TO_TEST}/index.html
sed -i "s|PLACE_TEST_PATH_HERE|${PATH_TO_TEST}|g" /var/www/html/${PATH_TO_TEST}/index.html
cat /var/www/html/${PATH_TO_TEST}/index.html
echo "\n"

sed -i "s|CUSTOM_LISTENING_PORT|${CUSTOM_LISTENING_PORT}|g" /etc/apache2/ports.conf
cat /etc/apache2/ports.conf
echo "\n"

sed -i "s|CUSTOM_LISTENING_PORT|${CUSTOM_LISTENING_PORT}|g" /etc/apache2/sites-available/000-default.conf
cat /etc/apache2/sites-available/000-default.conf
echo "\n"

service apache2 start

exec "$@"
tail -f /dev/null