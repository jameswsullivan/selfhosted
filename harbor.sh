# Harbor Installation Script (Ubuntu Server 22.04 LTS)

HARBOR_APP_URL=$(ADD_YOUR_URL)
HARBOR_APP_PORT=$(ADD_YOUR_PORT)


# Basic packages:
echo "Installing basic packages..."
apt-get update -y
apt-get upgrade -y
apt-get install -y nano wget

echo "Retrieve Harbor installer..."
mkdir /opt/harbor
cd /opt/harbor
wget https://github.com/goharbor/harbor/releases/download/v2.8.0/harbor-online-installer-v2.8.0.tgz

# Optional
# wget https://github.com/goharbor/harbor/releases/download/v2.8.0/harbor-online-installer-v2.8.0.tgz.asc

tar xzvf harbor-online-installer-v2.8.0.tgz

cd /harbor
cp harbor.yml.tmpl harbor.yml


# Configure harbor.yml
nano harbor.yml


# Installing Docker.
echo "Installing Docker ..."
apt-get remove docker docker-engine docker.io containerd runc
apt-get update -y
apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg ftp
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get upgrade -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Install Harbor:
echo "Begin installing harbor..."
./install.sh



# OPTIONAL: Running Harbor with HTTP, modify daemon.json file:
# This needs to be done on all/any of the CLIENT machines that need to connect/login to Harbor.

echo "Use Harbor with HTTP..."
systemctl stop docker

json_content="{
\"insecure-registries\" : [\"$HARBOR_APP_URL:$HARBOR_APP_PORT\", \"0.0.0.0\"]
}"

echo "$json_content" | tee /etc/docker/daemon.json > /dev/null

systemctl start docker


# Commands for restarting Harbor:
# Navigate to your Harbor installation directory, mine is /opt/harbor/harbor/
cd /opt/harbor/harbor/
docker compose down -v
docker compose up -d


# Default login:
# Username: admin
# Password: defined in harbor.yml: harbor_admin_password: password