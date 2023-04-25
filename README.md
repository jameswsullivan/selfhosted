### Take Your Privacy Back with Self-Hosted Applications
<br>

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
docker run -dit --name MY_NEXTCLOUD_CONTAINER --ip IP_ADDRESS --network DOCKER_NETWORK --restart=unless-stopped --hostname=MY_NEXTCLOUD_CONTAINER_HOSTNAME -v /mnt/nextcloud_data:/var/www/html nextcloud:1.0

# MySQL
# Persistent data mount: /mnt/nextcloud_db
docker run -dit --name MY_NEXTCLOUD_DB_CONTAINER --ip IP_ADDRESS --network DOCKER_NETWORK --hostname=MY_NEXTCLOUD_DB_CONTAINER_HOSTNAME --restart=unless-stopped -v /mnt/nextcloud_db:/var/lib/mysql mysql:1.0
```

<br>

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