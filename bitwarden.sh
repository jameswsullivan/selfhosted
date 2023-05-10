# bitwarden Installation Script

# Installing Docker.
echo "Installing Docker ..."
apt-get remove docker docker-engine docker.io containerd runc
apt-get update -y
apt-get upgrade -y
apt-get install -y nano openssh-server ca-certificates curl gnupg ftp
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

# Create bitwarden local user & directory
echo "Setting up bitwarden user and directory ..."
useradd -m -s /bin/bash bitwarden
echo "bitwarden:YOUR_BITWARDEN_USER_PASSWORD" | chpasswd

groupadd docker
usermod -aG docker bitwarden
mkdir /opt/bitwarden
chmod -R 700 /opt/bitwarden
chown -R bitwarden:bitwarden /opt/bitwarden

# Install bitwarden
echo "Installing bitwarden ..."

su bitwarden
cd /opt/bitwarden

curl -Lso bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux"
chmod 700 bitwarden.sh

./bitwarden.sh install