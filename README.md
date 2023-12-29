## Take Your Privacy Back with Self-Hosted Applications

## Nextcloud:

#### BUILD IMAGE

```
# Linux build:

docker build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cache . 2>&1 | tee nextcloud-build.log

docker build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . 2>&1 | tee mysql-build.log

# Windows build using PowerShell
docker build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cahce . 2>&1 | Tee-Object nextcloud-build.log

docker build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . 2>&1 | Tee-Object mysql-build.log
```

#### START CONTAINER

```
# Nextcloud
# Persistent data mount: /mnt/nextcloud-data
docker run -dit \
    --name MY-NEXTCLOUD-CONTAINER \
    --ip IP-ADDRESS --network DOCKER-NETWORK \
    --restart=unless-stopped \
    --hostname=MY-NEXTCLOUD-CONTAINER-HOSTNAME \
    -v /mnt/nextcloud-data:/var/www/html \
    nextcloud:1.0

# MySQL
# Persistent data mount: /mnt/nextcloud-db
docker run -dit \
    --name MY-NEXTCLOUD-DB-CONTAINER \
    --ip IP-ADDRESS --network DOCKER-NETWORK \
    --hostname=MY-NEXTCLOUD-DB-CONTAINER-HOSTNAME \
    --restart=unless-stopped \
    -v /mnt/nextcloud-db:/var/lib/mysql \
    mysql:1.0
```

## BookStack

#### BUILD IMAGE

```
# Linux build:
docker build --file bookstack.dockerfile --tag bookstack:1.0 --progress plain --no-cache . 2>&1 | tee bookstack-build.log

# Windows build using PowerShell
docker build --file bookstack.dockerfile --tag bookstack:1.0 --progress plain --no-cache . 2>&1 | Tee-Object bookstack-build.log
```

#### START CONTAINER

```
docker run -dit \
    --name MY-BOOKSTACK-CONTAINER-NAME \
    --ip IP-ADDRESS --network DOCKER-NETWORK \
    --hostname=MY-HOSTNAME \
    --restart=unless-stopped \
    --mount type=bind,source=SOURCE-DIRECTORY/.env,target=/var/www/bookstack/.env \
    --mount type=bind,source=SOURCE-DIRECTORY/bookstack.conf,target=/etc/apache2/sites-available/bookstack.conf \
    -v SOURCE-DIRECTORY:/var/www/bookstack/public/uploads \
    -v SOURCE-DIRECTORY:/var/www/bookstack/storage/uploads \
    bookstack:1.0
```

#### DEFAULT CONFIG

- [Official Installation Guide](https://www.bookstackapp.com/docs/admin/installation/#manual)
- Default login email: admin@admin.com
- Default login password: password
- Customize .env and bookstack.conf to fit your config.

## Simple Machine Forum

#### BUILD IMAGE

```
# Linux build:
docker build --file smf.dockerfile --tag smf:1.0 --progress plain --no-cache . 2>&1 | tee smf-build.log

# Windows build using PowerShell
docker build --file smf.dockerfile --tag smf:1.0 --progress plain --no-cache . 2>&1 | Tee-Object smf-build.log
```

#### START CONTAINER

```
docker run -dit \
    --name MY-SMF-CONTAINER-NAME \
    --ip IP-ADDRESS --network DOCKER-NETWORK \
    --hostname=MY-HOSTNAME \
    --restart=unless-stopped \
    -v SOURCE-DIRECTORY:/var/www/smf \
    smf:1.0
```

#### DEFAULT CONFIG

- Change ServerName to your server name in smf.conf.

## Grafana

#### BUILD IMAGE

```
# Linux build:
docker build --file grafana.dockerfile --tag grafana:1.0 --progress plain --no-cache . 2>&1 | tee grafana-build.log

# Windows build using PowerShell
docker build --file grafana.dockerfile --tag grafana:1.0 --progress plain --no-cache . 2>&1 | Tee-Object grafana-build.log
```

#### START CONTAINER

```
docker run -dit \
    --name MY-SMF-CONTAINER-NAME \
    --ip IP-ADDRESS --network DOCKER-NETWORK \
    --hostname=MY-HOSTNAME \
    --restart=unless-stopped \
    -v SOURCE-DIRECTORY:/var/lib/grafana \
    grafana:1.0
```

#### DEFAULT CONFIG and INFO

- Modified default port from 3000 to 80.
- Default username/password: admin/admin.
- Default locale is set to UTF-8 and time zone set to US Central.


## Ubuntu based LAMP-stack Web Server (with FTP)

#### BUILD IMAGE

```
# Linux build:
docker build --file ubuntu-lamp-webserver.dockerfile --tag ubuntu-lamp:1.0 --progress plain --no-cache . 2>&1 | tee ubuntu-lamp-build.log

# Windows build using PowerShell
docker build --file ubuntu-lamp-webserver.dockerfile --tag ubuntu-lamp:1.0 --progress plain --no-cache . 2>&1 | Tee-Object ubuntu-lamp-build.log
```

#### START CONTAINER

```
docker run -dit \
    --name YOUR-CONTAINER-NAME \
    --network YOUR-DOCKER-NETWORK --ip IP-ADDRESS \
    --restart=unless-stopped \
    --hostname=YOUR-HOSTNAME \
    -v YOUR-WEB-ROOT-DIRECTORY:/var/www/html \
    -v YOUR-SITE-CONFIGS-DIRECTORY:/etc/apache2/sites-available \
    ubuntu-lamp:1.0
```

#### CONFIGURATIONS

The following Environment Variables are defined:
- PHP_MEMORY_LIMIT 4096M
- PHP_POST_MAX_SIZE 4096M
- PHP_UPLOAD_MAX_FILESIZE 4096M
- PHP_INI=/etc/php/8.1/apache2/php.ini

Persistent files:
- YOUR-WEB-ROOT-DIRECTORY: place your website installation files in this directory (such as WordPress).
- YOUR-SITE-CONFIGS-DIRECTORY: place your site config files (*.conf files) in this directory.