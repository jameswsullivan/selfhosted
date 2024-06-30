#### Ubuntu version: `Ubuntu Server LTS 22.04` , Harbor version: `2.11.0`

#### 1. Install common packages

```
apt-get update -y
apt-get upgrade -y
apt-get install -y nano wget ca-certificates curl
```

#### 2. Install Docker

```
# Add Docker's official GPG key:

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

# Install docker:

apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker Version
docker --version
```

##### 3. Mount a virtual disk

```
# Find the mounted device:
fdisk -l

gdisk /dev/sda

# We assume the disk is /dev/sda

mkfs.ext4 /dev/sda

blkid | grep /dev/sda

mkdir /opt/harbor-data

nano /etc/fstab

# Add
# UUID="<your_disks_uuid>" /opt/harbor-data ext4 defaults 0 1
# to /etc/fstab

mount -a
```

#### 4. Prepare SSL certificate

```
nano /etc/ssl/certs/your_certificate.crt
nano /etc/ssl/certs/your_certificate_key.key
```

#### 5. Install Harbor

```
cd /opt
wget https://github.com/goharbor/harbor/releases/download/v2.11.0/harbor-offline-installer-v2.11.0.tgz

tar -xzvf harbor-offline-installer-v2.11.0.tgz

rm -f harbor-offline-installer-v2.11.0.tgz

cd harbor
cp harbor.yml.tmpl harbor.yml

nano harbor.yml
```

#### 6. Run harbor installation script
```
/opt/habor/install.sh
```

<hr>

#### Note: if only use HTTP:

If you are only running Harbor in your isolated dev/lab environment like I do, you need to configure Docker to use insecure registries, and this has to be done on any/all clients that will connect/login to your Harbor instance. And when building/tagging your image, you will also need to explicitly specify port 80 to avoid issues.

```
echo "Use Harbor with HTTP..."
systemctl stop docker

json_content="{
\"insecure-registries\" : [\"$HARBOR_APP_URL:$HARBOR_APP_PORT\", \"0.0.0.0\"]
}"

echo "$json_content" | tee /etc/docker/daemon.json > /dev/null

systemctl start docker
```

When building images, use:

```
docker image build --tag yourharborregistry.com:80/repo/image:version ........
```
