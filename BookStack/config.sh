#!/bin/bash
BOOKSTACK_DIR="/var/www/bookstack"

service apache2 start
a2ensite bookstack.conf
a2enmod rewrite
a2enmod headers

cd "$BOOKSTACK_DIR"

php artisan key:generate --no-interaction --force
php artisan migrate --no-interaction --force

service apache2 restart

exec "$@"
tail -f /var/log/apache2/access.log