#!/bin/bash

nginx
php-fpm

exec "$@"
tail -f /dev/null