# BitWarden Installation and Configuration Script

# Installing Docker :
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

# -----------------------------------------

# Create Bitwarden local user & directory :
useradd -m -s /bin/bash bitwarden
echo "bitwarden:%'&A,QFB" | chpasswd

groupadd docker
usermod -aG docker bitwarden
mkdir /opt/bitwarden
chmod -R 700 /opt/bitwarden
chown -R bitwarden:bitwarden /opt/bitwarden

# Install Bitwarden :
su bitwarden
cd /opt/bitwarden

curl -Lso bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux"
chmod 700 bitwarden.sh

./bitwarden.sh install

# ----------------------------------------------------

# Manually verify email by manipulating the database :

# Default configs :
cat bwdata/env/mssql.override.env
SA_PASSWORD=<SA_PASSWORD>

# Steps :
docker exec -it bitwarden-mssql /bin/bash

# Connect to the database :
cd /opt/mssql-tools/bin
./sqlcmd -S 127.0.0.1 -U sa -P <SA_PASSWORD>

# Run the following SQL statements :
SELECT name, database_id, create_date  
FROM sys.databases;  
GO 
Enter the database name for your Bitwarden instance (ex. vault): bitwarden_vault

USE bitwarden_vault
GO
SELECT Name, Email, EmailVerified FROM [User]
GO

UPDATE [User] SET EmailVerified = 1 WHERE [User].Name="admin";
GO

# ------------------------------------------------------------------------------

# Update bitwarden :

# Navigate to your bitwarden installation directory:
./bitwarden.sh updateself
./bitwarden.sh update

# ----------------------------------------------------------------------------------------

# BitWarden SSL location :
./bwdata/ssl/self/<your_site>

# BitWarden config file location :
./bwdata/config.yml

# ----------------------------------------------------------------------------------------

# Self-signed Certificate Generation :
openssl req -x509 -newkey rsa:4096 -sha256 -nodes -days 365 \
  -keyout ./ssl/bitwarden.example.com/private.key \
  -out ./ssl/bitwarden.example.com/certificate.crt \
  -reqexts SAN -extensions SAN \
  -config <(cat /usr/lib/ssl/openssl.cnf <(printf '[SAN]\nsubjectAltName=DNS:bitwarden.example.com\nbasicConstraints=CA:true')) \
  -subj "/C=US/ST=New York/L=New York/O=Company Name/OU=Bitwarden/CN=bitwarden.example.com"
