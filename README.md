#### ABOUT

**TAKE YOUR PRIVACY BACK** with Self-Hosted applications.
<br>
<br>
#### Nextcloud
<br>
**Build image**
<br>
```
# Linux build:
docker image build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cache . | tee nextcloud_build.log

docker image build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . | tee mysql_build.log

# Windows build using PowerShell
docker image build --file nextcloud.dockerfile --tag nextcloud:1.0 --progress plain --no-cahce . 2>&1 | Tee-Object nextcloud_build.log

docker image build --file mysql.dockerfile --tag mysql:1.0 --progress plain --no-cache . 2>&1 | Tee-Object mysql_build.log

```
<br>
<br>
**Start the containers**
<br>
```

# Nextcloud
# Persistent data mount: /mnt/nextcloud_data
docker run -dit --name MY_NEXTCLOUD_CONTAINER --ip IP_ADDRESS --network DOCKER_NETWORK --restart=unless-stopped --hostname=MY_NEXTCLOUD_CONTAINER_HOSTNAME -v /mnt/nextcloud_data:/var/www/html nextcloud:1.0

# MySQL
# Persistent data mount: /mnt/nextcloud_db
docker run -dit --name MY_NEXTCLOUD_DB_CONTAINER --ip IP_ADDRESS --network DOCKER_NETWORK --hostname=MY_NEXTCLOUD_DB_CONTAINER_HOSTNAME --restart=unless-stopped -v /mnt/nextcloud_db:/var/lib/mysql mysql:1.0

```