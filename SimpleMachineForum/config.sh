#!/bin/bash
service apache2 start

exec "$@"
tail -f /dev/null