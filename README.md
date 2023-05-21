### Take Your Privacy Back with Self-Hosted Applications
<br>

---

### Nextcloud:

**BUILD IMAGE**

```
# Linux build:

docker image build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cache . 2>&1 | tee nextcloud_build.log

docker image build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . 2>&1 | tee mysql_build.log

# Windows build using PowerShell
docker image build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cahce . 2>&1 | Tee-Object nextcloud_build.log

docker image build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . 2>&1 | Tee-Object mysql_build.log
```

<br>
<br>

**START CONTAINER**

```
# Nextcloud
# Persistent data mount: /mnt/nextcloud_data
docker run -dit \
    --name MY_NEXTCLOUD_CONTAINER \
    --ip IP_ADDRESS --network DOCKER_NETWORK \
    --restart=unless-stopped \
    --hostname=MY_NEXTCLOUD_CONTAINER_HOSTNAME \
    -v /mnt/nextcloud_data:/var/www/html \
    nextcloud:1.0

# MySQL
# Persistent data mount: /mnt/nextcloud_db
docker run -dit \
    --name MY_NEXTCLOUD_DB_CONTAINER \
    --ip IP_ADDRESS --network DOCKER_NETWORK \
    --hostname=MY_NEXTCLOUD_DB_CONTAINER_HOSTNAME \
    --restart=unless-stopped \
    -v /mnt/nextcloud_db:/var/lib/mysql \
    mysql:1.0
```

<br>

---

### BookStack

**BUILD IMAGE**

```
# Linux build:
docker image build --file bookstack.dockerfile --tag bookstack:1.0 --progress plain --no-cache . 2>&1 | tee bookstack_build.log

# Windows build using PowerShell
docker image build --file bookstack.dockerfile --tag bookstack:1.0 --progress plain --no-cache . 2>&1 | Tee-Object bookstack_build.log
```

<br>
<br>

**START CONTAINER**

```
docker run -dit \
    --name MY_BOOKSTACK_CONTAINER_NAME \
    --ip IP_ADDRESS --network DOCKER_NETWORK \
    --hostname=MY_HOSTNAME \
    --restart=unless-stopped \
    --mount type=bind,source=SOURCE_DIRECTORY/.env,target=/var/www/bookstack/.env \
    --mount type=bind,source=SOURCE_DIRECTORY/bookstack.conf,target=/etc/apache2/sites-available/bookstack.conf \
    -v SOURCE_DIRECTORY:/var/www/bookstack/public/uploads \
    -v SOURCE_DIRECTORY:/var/www/bookstack/storage/uploads \
    bookstack:1.0
```

<br>
<br>

**DEFAULT CONFIG**

[Official Installation Guide](https://www.bookstackapp.com/docs/admin/installation/#manual)
<br>
Default login email: admin@admin.com
<br>
Default login password: password
<br>
Customize .env and bookstack.conf to fit your config.

<br>

---

### Simple Machine Forum

**BUILD IMAGE**

```
# Linux build:
docker image build --file smf.dockerfile --tag smf:1.0 --progress plain --no-cache . 2>&1 | tee smf_build.log

# Windows build using PowerShell
docker image build --file smf.dockerfile --tag smf:1.0 --progress plain --no-cache . 2>&1 | Tee-Object smf_build.log
```

<br>
<br>

**START CONTAINER**

```
docker run -dit \
    --name MY_SMF_CONTAINER_NAME \
    --ip IP_ADDRESS --network DOCKER_NETWORK \
    --hostname=MY_HOSTNAME \
    --restart=unless-stopped \
    -v SOURCE_DIRECTORY:/var/www/smf \
    smf:1.0
```

<br>
<br>

**DEFAULT CONFIG**

Change ServerName to your server name in smf.conf.

<br>

---

### Grafana

**BUILD IMAGE**

```
# Linux build:
docker image build --file grafana.dockerfile --tag grafana:1.0 --progress plain --no-cache . 2>&1 | tee grafana_build.log

# Windows build using PowerShell
docker image build --file grafana.dockerfile --tag grafana:1.0 --progress plain --no-cache . 2>&1 | Tee-Object grafana_build.log
```

<br>
<br>

**START CONTAINER**

```
docker run -dit \
    --name MY_SMF_CONTAINER_NAME \
    --ip IP_ADDRESS --network DOCKER_NETWORK \
    --hostname=MY_HOSTNAME \
    --restart=unless-stopped \
    -v SOURCE_DIRECTORY:/var/lib/grafana \
    grafana:1.0
```

<br>
<br>

**DEFAULT CONFIG and INFO**

- Modified default port from 3000 to 80.
- Default username/password: admin/admin.
- Default locale is set to UTF-8 and time zone set to US Central.

<br>

---

### Ubuntu based LAMP-stack Web Server

**BUILD IMAGE**

```
# Linux build:
docker image build --file ubuntu_lamp_webserver.dockerfile --tag ubuntu-lamp:1.0 --progress plain --no-cache . 2>&1 | tee ubuntu-lamp_build.log

# Windows build using PowerShell
docker image build --file ubuntu_lamp_webserver.dockerfile --tag ubuntu-lamp:1.0 --progress plain --no-cache . 2>&1 | Tee-Object ubuntu-lamp_build.log
```

<br>
<br>

**START CONTAINER**

```
docker run -dit \
    --name YOUR_CONTAINER_NAME \
    --network YOUR_DOCKER_NETWORK --ip IP_ADDRESS \
    --restart=unless-stopped \
    --hostname=YOUR_HOSTNAME \
    -v YOUR_WEB_ROOT_DIRECTORY:/var/www/html \
    -v YOUR_SITE_CONFIGS_DIRECTORY:/etc/apache2/sites-available \
    ubuntu-lamp:1.0
```

<br>
<br>

**CONFIGURATIONS**

The following Environment Variables are defined:
- PHP_MEMORY_LIMIT 4096M
- PHP_POST_MAX_SIZE 4096M
- PHP_UPLOAD_MAX_FILESIZE 4096M
- PHP_INI=/etc/php/8.1/apache2/php.ini


Persistent files:
- YOUR_WEB_ROOT_DIRECTORY: place your website installation files in this directory (such as WordPress).
- YOUR_SITE_CONFIGS_DIRECTORY: place your site config files (*.conf files) in this directory.