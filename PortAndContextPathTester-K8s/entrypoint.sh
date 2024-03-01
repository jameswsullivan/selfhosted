#!/bin/bash

mkdir mkdir /var/www/html/${PATH_TO_TEST}
ls -al mkdir /var/www/html/${PATH_TO_TEST}
echo "\n"

cp -a /opt/index.html /var/www/html/${PATH_TO_TEST}/index.html
sed -i "s|PLACE_TEST_PATH_HERE|${PATH_TO_TEST}|g" /var/www/html/${PATH_TO_TEST}/index.html
cat /var/www/html/${PATH_TO_TEST}/index.html
echo "\n"

service apache2 start

exec "$@"
tail -f /dev/null